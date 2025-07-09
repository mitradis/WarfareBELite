Private ["_areas","_deployed","_direction","_grp","_HQ","_HQName","_logic","_MHQ","_near","_position","_side","_sideText","_site","_type","_update","_varTH"];

_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_sideText = _side;
_sideID = (_side) Call GetSideID;

/* Handle the LAG. */
_varTH = format['WF_CHQInUse_%1',_sideText];
waitUntil {sleep 0.05;!(WF_Logic getVariable _varTH)};
WF_Logic setVariable [_varTH,true];

_HQ = (_sideText) Call GetSideHQ;
_deployed = (_sideText) Call GetSideHQDeployed;

if (!_deployed) then {
	_HQ setPos [1,1,1];
	
	_site = _type CreateVehicle _position;
	_site SetDir _direction;
	_site SetPos _position;
	
	Call Compile Format ["%1MHQ = _site; %1MHQDeployed = true; publicVariable '%1MHQ'; publicVariable '%1MHQDeployed';",_sideText];
	
	_site setVehicleInit Format["[this,true,%1] ExecVM 'Client\Init\Init_BaseStructure.sqf'",_side];
	processInitCommands;
	
	["Constructed",_type,_side] Spawn SideMessage;
	Call Compile Format ["_site addEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _site];
	_site addEventHandler ["hit",{_this Spawn BuildingDamaged}];
	if (paramHandleFF) then {Call Compile Format ["_site addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	
	//--- base area limits.
	if (paramBaseArea) then {
		_update = true;
		_areas = WF_Logic getVariable Format['%1Area',_sideText];
		_near = [_position,_areas] Call GetClosestEntity;
		if (!isNull _near) then {
			if (_near distance _position < (('WFBE_BASEAREARANGE' Call GetNamespace) + ('WFBE_MHQBUILDINGRANGE' Call GetNamespace))) then {_update = false};
		};
		if (_update) then {
			_grp = createGroup sideLogic;
			_logic = _grp createUnit ["Logic",[0,0,0],[],0,"NONE"];
			_logic setPos _position;
			WF_Logic setVariable [Format['%1Area',_sideText],_areas + [_logic],true];
		};
	};
	
	
	
	deleteVehicle _HQ;
} else {
	_position = getPos _HQ;
	_direction = getDir _HQ;
	_HQName = Format["WFBE_%1MHQNAME",_sideText] Call GetNamespace;

	_HQ setPos [1,1,1];
	
	_MHQ = [_HQName, _position, _sideID, false, false] Call CreateVehi;
	_MHQ setDir _direction;
	_MHQ setVelocity [0,0,-1];

	Call Compile Format ["%1MHQ = _MHQ; %1MHQDeployed = false; publicVariable '%1MHQ'; publicVariable '%1MHQDeployed';",_sideText];
	
	["Constructed",_HQName,_side] Spawn SideMessage;
	Call Compile Format ["_MHQ AddEventHandler [""killed"",{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _MHQ];
	if (paramHandleFF) then {Call Compile Format ["_MHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	
	
	
	deleteVehicle _HQ;
};

/* Handle the LAG. */
WF_Logic setVariable [_varTH,false];