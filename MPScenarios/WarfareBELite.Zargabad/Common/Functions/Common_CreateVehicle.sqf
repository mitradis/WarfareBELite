Private ["_bountyadd","_lock","_position","_side","_type","_vehicle"];

_type = _this select 0;
_position = _this select 1;
_sideID = _this select 2;
_lock = _this select 3;
_bountyadd = if (count _this > 4) then {_this select 4} else {true};

_vehicle = _type createVehicle _position;

//todo, optimize dynamic init (if 3 way).
if (_sideID != RESISTANCEID) then {
	_vehicle setVehicleInit Format["[this,%1] ExecVM 'Common\Init\Init_Unit.sqf'",_sideID];
	processInitCommands;
};

if (_bountyadd) then {_vehicle addEventHandler ['Killed', Format ['[_this select 0,_this select 1,%1] Spawn UnitKilled', _sideID]]};

if (_lock) then {_vehicle lock _lock};



_vehicle