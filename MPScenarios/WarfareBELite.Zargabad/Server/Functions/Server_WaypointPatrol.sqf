Private ["_behaviours","_destination","_maxWaypoints","_pos","_radius","_team","_type","_wps"];
_team = _this select 0;
_destination = _this select 1;
_radius = _this select 2;
_maxWaypoints = _this select 3;
_behaviours = if (count _this > 4) then {_this select 4} else {[]};
if (typeName _destination == 'OBJECT') then {_destination = getPos _destination};

_wps = [];
for '_z' from 0 to _maxWaypoints do {
	_pos = [_destination,_radius] Call GetRandomPosition;
	_type = if (_z != _maxWaypoints) then {'MOVE'} else {'CYCLE'};
	[_wps, [_pos,_type,35,40,[],[],_behaviours]] Call ArrayPush;
};

[_team, true, _wps] Call WaypointsAdd;