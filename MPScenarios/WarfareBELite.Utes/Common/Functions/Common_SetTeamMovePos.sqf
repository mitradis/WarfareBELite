Private['_movePos','_team'];

_team = _this select 0;
_movePos = _this select 1;

if (isNull _team) exitWith {};

Call Compile Format ["%1MovePos = _movePos; publicVariable '%1MovePos';",_team getVariable 'identification'];