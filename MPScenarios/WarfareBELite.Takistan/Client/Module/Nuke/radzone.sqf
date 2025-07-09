//--- Radiation
Private ['_target','_z'];

_target = _this select 0;
[_target] Spawn {
	Private ["_array","_dammageable","_target"];
	_target = _this select 0;
	_dammageable = ["Man","Car","Motorcycle","Tank","Ship","Air","StaticWeapon"];
	for [{_z = 0},{_z < 300},{_z = _z + 1}] do {
		_array = _target nearEntities [_dammageable, 1000];
		{
			_x setDammage (getDammage _x +  0.03);
			{_x setDammage  (getDammage _x + 0.05)} forEach crew _x;
		} forEach _array;
		sleep (3 + (random 3));
	};
	deleteVehicle _target;
};