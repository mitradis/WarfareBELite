Private["_position","_minRadius","_maxRadius","_radius","_direction","_attempts","_obstacles","_vehicles","_newPos"];

_position = _this select 0;
if (typeName _position == "OBJECT") then {_position = getPos _position};
if (count _position < 3) then {_position set [2, 0]};
_minRadius = if (count _this > 2) then {_this select 2} else {0};
_maxRadius = if (count _this > 1) then {_this select 1} else {20};

_newPos = [];
_attempts = 0;

while {_attempts != -1} do {
	_direction = random 360;
	_radius = (random (_maxRadius - _minRadius)) + _minRadius;
	_newPos = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),(_position select 2)];
	_obstacles = nearestObjects [_newPos, ["Building"], 15];
	_vehicles = _newPos nearEntities [["Building","Car","Tank","Air"], 7];
	if (count _obstacles > 0 || count _vehicles > 0 || surfaceIsWater _newPos) then {
		_attempts = _attempts + 1;
		if (_attempts > 25) then {_maxRadius = _maxRadius + 20};
	} else {
		_attempts = -1;
	}
};

_newPos
