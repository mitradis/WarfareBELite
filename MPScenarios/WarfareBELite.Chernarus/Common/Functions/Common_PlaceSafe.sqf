Private["_count","_currentPosition","_direction","_object","_obstacles","_placed","_position","_radius","_vehicles"];
scopeName "PlaceSafe";

_object = _this select 0;
_position = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {20};

_currentPosition = _position;
_placed = false;
_direction = random 360;

for [{_count = 0},{_count < 50 && !_placed},{_count = _count + 1}] do {
	_obstacles = nearestObjects [_currentPosition, ["Building"], 15];
	_vehicles = _currentPosition nearEntities [["Building","Car","Tank","Air"], 7];
	if (count _obstacles > 0 || count _vehicles > 0 || surfaceIsWater _currentPosition) then {
		_direction = random 360;
		_currentPosition = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),0];
		if (_count > 25) then {_radius = _radius + 20};
	} else {
		_object setPos _currentPosition;
		_object setVelocity [0,0,-0.5];
		_placed = true;
		breakTo "PlaceSafe";
	};
};

if (!_placed) then {_object setPos _position;_object setVelocity [0,0,-0.5]};
