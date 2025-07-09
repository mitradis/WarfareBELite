Private ["_destination","_maxWaypoints","_pos","_radius","_team","_type","_update","_wps","_z"];
_team = _this select 0;
_destination = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {30};
if (typeName _destination == 'OBJECT') then {_destination = getPos _destination};

_update = true;
if (side _team == west || side _team == east) then {
	_update = (_team) Call CanUpdateTeam;
};

//--- Override.
if (_update) then {_team Call UpdateTeam};

_maxWaypoints = 8;
_wps = [];
for [{_z=0},{_z<=_maxWaypoints},{_z=_z+1}] do {
	_pos = [_destination,_radius] Call GetRandomPosition;
	_type = if (_z != _maxWaypoints) then {'MOVE'} else {'CYCLE'};
	_wps = _wps + [[_pos,_type,35,40,"",[]]];
};



[_team, true, _wps] Call AIWPAdd;