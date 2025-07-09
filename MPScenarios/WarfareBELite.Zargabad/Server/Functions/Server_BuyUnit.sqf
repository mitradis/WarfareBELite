Private ["_building","_built","_config","_crew","_direction","_dir","_distance","_factoryType","_factoryPosition","_gbq","_id","_index","_isVehicle","_longest","_position","_queu","_queu2","_ret","_side","_sideID","_sideText","_soldier","_team","_turrets","_type","_unitType","_vehicle","_waitTime"];
_id = _this select 0;
_building = _this select 1;
_unitType = _this select 2;
_side = _this select 3;
_sideID = (_side) Call GetSideID;
_team = _this select 4;
_isVehicle = _this select 5;

_sideText = str _side;

if (!(alive _building)||(isPlayer (leader _team))) exitWith {
	_gbq = (_team getVariable "queue") - _id;
	_team setVariable ["queue",_gbq];
};



_queu = _building getVariable "queu";
if (isNil "_queu") then {_queu = []};
_queu = _queu + [_id select 0];
_building setVariable ["queu",_queu,true];

_type = typeOf _building;
_index = (Format ["WFBE_%1STRUCTURENAMES",_sideText] Call GetNamespace) find _type;
_distance = (Format ["WFBE_%1STRUCTUREDISTANCES",_sideText] Call GetNamespace) select _index;
_direction = (Format ["WFBE_%1STRUCTUREDIRECTIONS",_sideText] Call GetNamespace) select _index;
_factoryType = (Format ["WFBE_%1STRUCTURES",_sideText] Call GetNamespace) select _index;
_waitTime = (_unitType Call GetNamespace) select QUERYUNITTIME;
_position = [getPos _building,_distance,getDir _building + _direction] Call GetPositionFrom;
_longest = Format ["WFBE_LONGEST%1BUILDTIME",_factoryType] Call GetNamespace;

_ret = 0;
_queu2 = [0];

if (count _queu > 0) then {
	_queu2 = _building getVariable "queu";
};

while {_id select 0 != _queu select 0} do {
	sleep 4;
	_ret = _ret + 4;
	_queu = _building getVariable "queu";
	
	if (!(alive _building)||(isNull _building)||(isPlayer (leader _team))) exitWith {
		_gbq = (_team getVariable "queue") - _id;
		_team setVariable ["queue",_gbq];
		_queu = _building getVariable "queu";
		_queu = _queu - [_queu select 0];
		_building setVariable ["queu",_queu,true];
	};
	
	if (_queu select 0 == _queu2 select 0) then {
		if (_ret > _longest) then {
			if (count _queu > 0) then {
				_queu = _building getVariable "queu";
				_queu = _queu - [_queu select 0];
				_building setVariable ["queu",_queu,true];
			};	
		};
	};
	if (count _queu != count _queu2) then {
		_ret = 0;
		_queu2 = _building getVariable "queu";
	};
};

sleep _waitTime;

_queu = _building getVariable "queu";
_queu = _queu - [_id select 0];
_building setVariable ["queu",_queu,true];

if (!(alive _building)||(isPlayer (leader _team))) exitWith {
	_gbq = (_team getVariable "queue") - _id;
	_team setVariable ["queue",_gbq];
};

if (_unitType isKindOf "Man") then {
	_soldier = [_unitType,_team,_position,_side] Call CreateMan;
	[_sideText,'UnitsCreated',1] Call UpdateStatistics;
} else {
	_crew = Format ["WFBE_%1SOLDIER",_sideText] Call GetNamespace;
	if (_unitType isKindOf "Tank") then {_crew = Format ["WFBE_%1CREW",_sideText] Call GetNamespace};
	if (_unitType isKindOf "Air") then {_crew = Format ["WFBE_%1PILOT",_sideText] Call GetNamespace};
	_vehicle = [_unitType,_position,_sideID,true] Call CreateVehi;
	_factoryPosition = getPos _building;
	_dir = -((((_position select 1) - (_factoryPosition select 1)) atan2 ((_position select 0) - (_factoryPosition select 0))) - 90);
	_vehicle setDir _dir;
	_vehicle setVelocity [0,0,-1];
	//--- AI Can fly.
	if (_vehicle isKindOf "Air") then {
		_vehicle flyInHeight 120;
		if (_vehicle isKindOf "Plane") then {
			_vehicle setPos [_position select 0,_position select 1,1500];
			_vehicle setVelocity [sin _dir * 250,cos _dir * 250,0];
		};
	};

	emptyQueu = emptyQueu + [_vehicle];
	_vehicle Spawn HandleEmptyVehicle;
	if (_vehicle distance (leader _team) < 200) then {(units _team) allowGetIn true;_team addVehicle _vehicle};
	
	/* Clear the vehicle */
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	
	_soldier = [_crew,_team,_position,_side] Call CreateMan;
	[_soldier] allowGetIn true;
	[_soldier] orderGetIn true;
	_soldier assignAsDriver _vehicle;
	_soldier moveInDriver _vehicle;
	[_sideText,'VehiclesCreated',1] Call UpdateStatistics;
	_built = 1;
	if (_isVehicle select 1) then {
		_soldier = [_crew,_team,_position,_side] Call CreateMan;
		[_soldier] allowGetIn true;
		[_soldier] orderGetIn true;
		_soldier assignAsGunner _vehicle;
		_soldier moveInGunner _vehicle;
		_built = _built + 1;
	};
	if (_isVehicle select 2) then {
		if (vehicle leader _team == leader _team && leader _team distance _vehicle < 200 && alive leader _team) then {
			[leader _team] allowGetIn true;
			[leader _team] orderGetIn true;
			(leader _team) assignAsCommander _vehicle;
			(leader _team) moveInCommander _vehicle;
		} else {
			_soldier = [_crew,_team,_position,_side] Call CreateMan;
			[_soldier] allowGetIn true;
			[_soldier] orderGetIn true;
			_soldier assignAsCommander _vehicle;
			_soldier moveInCommander _vehicle;
		};
		_built = _built + 1;
	};
	
	if (_isVehicle select 3) then {
		Private ["_get","_turrets"];
		_get = _unitType Call GetNamespace;
		_turrets = _get select QUERYUNITTURRETS;
		
		{
			if (isNull (_vehicle turretUnit _x)) then {
				_soldier = [_crew,_team,_position,_side] Call CreateMan;
				[_soldier] allowGetIn true;
				_soldier moveInTurret [_vehicle, _x];
				_built = _built + 1;			
			};
		} forEach _turrets;
	};
	[_sideText,'UnitsCreated',_built] Call UpdateStatistics;
};

_gbq = (_team getVariable "queue") - _id;
_team setVariable ["queue",_gbq];