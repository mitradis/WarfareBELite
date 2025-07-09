Private ['_camps','_insert','_insertObject','_insertStep','_maxWaypoints','_pos','_radius','_team','_town','_townPos','_type','_update','_usable','_wpcompletionRadius','_wpradius','_wps','_z'];
_team = _this select 0;
_town = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {30};
if (typeName _town != 'OBJECT') exitWith {};
if (isNull _team) exitWith {};
_townPos = getPos _town;

_camps = _town getVariable 'camps';

_usable = [_town] + _camps;
_maxWaypoints = ('WFBE_TOWNPATROLHOPS' Call GetNamespace) + count(_usable);
_wps = [];

//--- Randomize the behaviours.
if (random 100 > 50) then {_team setFormation "DIAMOND"} else {_team setFormation "STAG COLUMN"};
if (random 100 > 50) then {_team setCombatMode "YELLOW"} else {_team setCombatMode "RED"};
if (random 100 > 50) then {_team setBehaviour "AWARE"} else {_team setBehaviour "COMBAT"};
if (random 100 > 50) then {_team setSpeedMode "NORMAL"} else {_team setSpeedMode "LIMITED"};

//--- Dyn insert.
_insertStep = if (count(_usable) != 0) then {floor(_maxWaypoints / count(_usable))} else {-1};
_insert = _insertStep;
_insertObject = objNull;
_wpradius = -1;
_wpcompletionRadius = -1;

for [{_z=0},{_z<=_maxWaypoints},{_z=_z+1}] do {
	if (_z == _insert && count _usable > 0) then {
		_insert = _insert + _insertStep;
		_insertObject = _usable select (round(random((count _usable)-1)));
		_usable = _usable - [_insertObject];
	};

	if (isNull _insertObject) then {
		_pos = [_townPos,_radius] Call GetRandomPosition;
		_wpradius = 32;
		_wpcompletionRadius = 44;
	} else {
		_pos = getPos _insertObject;
		_wpradius = 35;
		_wpcompletionRadius = 68;
	};
	
	_type = if (_z != _maxWaypoints) then {'MOVE'} else {'CYCLE'};
	_wps = _wps + [[_pos,_type,_wpradius,_wpcompletionRadius, "", []]];
};



[_team, true, _wps] Call AIWPAdd;