Private ["_leader","_team","_cpos","_npos","_tpos"];

_team = _this select 0;
_leader = leader _team;
_tpos = getPos _leader;
_cpos = str [_tpos select 0, _tpos select 1];

sleep (random 0.5);

while {!gameOver} do {
	sleep 30;
	_leader = leader _team;
	if (isNull _leader || IsPlayer _leader) exitWith {};
	if (_leader == (vehicle _leader)) then {
		_tpos = getPos _leader;
		_npos = str [_tpos select 0, _tpos select 1];
		if (_cpos == _npos) then {
			_leader setPos ([_tpos,15,3] Call GetRandomPosition);
		};
		_cpos = _npos;
	};
};