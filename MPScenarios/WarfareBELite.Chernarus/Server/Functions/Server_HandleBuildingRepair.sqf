Private ["_bindex","_degradation","_direction","_etat","_group","_lastCompletionCheck","_logic","_position","_ruins","_ruinsType","_side","_type"];

_logic = _this select 0;
_type = _this select 1;
_side = _this select 2;
_bindex = _this select 3;

_lastCompletionCheck = 0;
_degradation = 'WFBE_WORKERS_DEGRADATION' Call GetNamespace;

_ruinsType = "WFBE_WORKERS_RUINS" Call GetNamespace;
_position = _logic getVariable "WFBE_B_Position";
_direction = _logic getVariable "WFBE_B_Direction";

//--- Create ruins wherever the building get destroyed.
_ruins = _ruinsType createVehicle _position;
_ruins setDir _direction;
_ruins setPos _position;

while {true} do {
	_etat = _logic getVariable 'WFBE_B_Completion';

	//--- Completed.
	if (_etat >= 100) exitWith {
		Private ["_buildingsCosts","_buildingsNames","_buildingsType","_current","_index","_limit","_site"];
		_buildingsType = Format["WFBE_%1STRUCTURES",str _side] Call GetNamespace;
		_buildingsType = _buildingsType - [_buildingsType select 0];
		_buildingsNames = Format["WFBE_%1STRUCTURENAMES",str _side] Call GetNamespace;
		_buildingsNames = _buildingsNames - [_buildingsNames select 0];
		_buildingsCosts = Format["WFBE_%1STRUCTURECOSTS",str _side] Call GetNamespace;
		
		//--- Place if limits allows us to do so.
		_index = _buildingsNames find _type;
		
		if (_index != -1) then {
			_current = Call Compile Format ['%1BuildingsCurrent',str _side];
			_limit = (Format['WFBE_BUILDINGMAX%1',(_buildingsType select _index)]) Call GetNamespace;
			if (isNil '_limit') then {_limit = 4}; //--- Default.
			
			//--- We can build, the limist hasn't been reached yet.
			if ((_current select _index) < _limit) then {
				_site = _type createVehicle _position;
				_site setDir _direction;
				_site setPos _position;
				
				["Constructed",_type,_side] Spawn SideMessage;

				//--- Site is created, we add the rest.
				if !(isNull _site) then {
					_current set [_bindex, (_current select _bindex) + 1];
					Call Compile Format ['%1BuildingsCurrent = _current',_side];
					publicVariable Format ['%1BuildingsCurrent',_side];
				
					Call Compile Format ["%1BaseStructures = %1BaseStructures + [_site]; publicVariable '%1BaseStructures';",str _side];

					_site setVehicleInit Format["[this,false,%1] ExecVM 'Client\Init\Init_BaseStructure.sqf'",_side];
					processInitCommands;
					
					_site addEventHandler ["hit",{_this Spawn BuildingDamaged}];
					if (paramHandleFF) then {
						Call Compile Format ["_site addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side];
					} else {
						_site addEventHandler ['handleDamage',{getDammage (_this select 0)+((_this select 2)/('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace))}];
					};
					Call Compile Format ["_site AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn BuildingKilled}];",_side,_type];
					
					if !(paramMoneyOnly) then {
						[_side, -round((_buildingsCosts select _index)/2)] Call ChangeSideSupply;
					};
					
					
				};
				
				_logic setVariable ["WFBE_B_Repair",false];
			};
		};
	
		[Format ["WFBE_WORKERS_%1LOGIC",str _side],((Format ["WFBE_WORKERS_%1LOGIC",str _side]) Call GetNamespace) - [_logic],true] Call SetNamespace;
	};
	
	sleep 5;
	
	//--- Has the etat changed?
	if ((_logic getVariable 'WFBE_B_Completion') == _etat) then {_lastCompletionCheck = _lastCompletionCheck + 5} else {_lastCompletionCheck = 0};
	
	//--- Degradation if nothing happened.
	if (_lastCompletionCheck > 30) then {
		_etat = (_logic getVariable "WFBE_B_Completion") - _degradation;
		if (_etat < 0) then {_etat = 0};
		_logic setVariable ["WFBE_B_Completion",_etat];
		_lastCompletionCheck = 0;
	};
	
	//--- If the etat reach 0, the building is lost.
	if (_etat <= 0) exitWith {
		[Format ["WFBE_WORKERS_%1LOGIC",str _side],((Format ["WFBE_WORKERS_%1LOGIC",str _side]) Call GetNamespace) - [_logic],true] Call SetNamespace;
	
		_group = group _logic;
		deleteVehicle _logic;
		deleteGroup _group;
	};
};

deleteVehicle _ruins;