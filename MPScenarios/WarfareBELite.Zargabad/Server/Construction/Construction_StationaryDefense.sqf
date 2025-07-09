/* Description: Creates Defenses. */
Private ["_buildings","_defense","_direction","_isAIQuery","_isArtillery","_manned","_position","_side","_sideID","_type"];
_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_manned = _this select 4;
_isAIQuery = _this select 5;
_manRange = if (count _this > 6) then {_this select 6} else {'WFBE_DEFENSEMANRANGE' Call GetNamespace};
_sideID = (_side) Call GetSideID;

_defense = _type createVehicle _position;
_defense setDir _direction;
_defense setPos _position;



//--- If it's a minefield, we exit the script while spawning it.
if (_type == 'Sign_Danger') exitWith {
	Private ["_c","_h","_mine","_mineType","_toWorld"];
	_mineType = if (_side == east) then {'MineMineE'} else {'MineMine'};
	_h = -4;
	_c = 0;
	for [{_z=0}, {_z<9}, {_z=_z+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};

	_h = 0;
	_c = 2;
	for [{_z=0}, {_z<8}, {_z=_z+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};

	_h = 4;
	_c = 0;
	for [{_z=0}, {_z<9}, {_z=_z+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};
	deleteVehicle _defense;
};

if (_type == 'Concrete_Wall_EP1') then {
	_defense addEventHandler ['handleDamage',{getDammage (_this select 0)+(_this select 2)/160}];
};

Call Compile Format ["_defense addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_sideID];

if (_defense EmptyPositions "gunner" > 0 && ((('WFBE_AIDEFENSE' Call GetNamespace) > 0) || _isAIQuery)) then {
	Private ["_alives","_check","_closest","_team"];
	_team = missionNamespace getVariable Format ["WFBE_%1_DefenseTeam", _side];
	emptyQueu = emptyQueu + [_defense];
	_defense Spawn HandleEmptyVehicle;
	if (_manned) then {
		_alives = (units _team) Call GetLiveUnits;
		if (count _alives < ('WFBE_AIDEFENSE' Call GetNamespace) || _isAIQuery) then {
			_buildings = (str _side) Call GetSideStructures;
			_closest = ['BARRACKSTYPE',_buildings,_manRange,_side,_defense] Call BuildingInRange;

			//--- Manning Defenses.
			if !(isNull _closest) then {			
				[_defense,_side,_team,_closest] Spawn HandleDefense;
			};
		};
	};
};

if (paramArtyUI) then {
	Private ["_isAC","_isVeh"];
	_isVeh = getNumber(configFile >> "CfgVehicles" >> typeOf(_defense) >> "ARTY_IsArtyVehicle");
	_isAC = getNumber(configFile >> "CfgVehicles" >> typeOf(_defense) >> "artilleryScanner");
	if (_isVeh == 1 || _isAC == 1) then {
		_defense setVehicleInit "[this] ExecVM 'Common\Common_InitArtillery.sqf'";
		processInitCommands;
		
	};
};

/* Are we dealing with an artillery unit ? */
_isArtillery = [_type,_side] Call IsArtillery;
if (_isArtillery != -1) then {[_defense,_isArtillery,_side] Call EquipArtillery};

_defense