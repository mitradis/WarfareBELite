Private['_moveMode','_team'];

_team = _this select 0;
_moveMode = _this select 1;

if (isNull _team) exitWith {};

Call Compile Format ["%1MoveMode = _moveMode; publicVariable '%1MoveMode';",_team getVariable 'identification'];