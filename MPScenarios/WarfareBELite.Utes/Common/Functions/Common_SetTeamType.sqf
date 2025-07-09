Private['_idtype','_team'];

_team = _this select 0;
_idtype = _this select 1;

if (isNull _team) exitWith {};

Call Compile Format ["%1Types = _idtype; publicVariable '%1Types';",_team getVariable 'identification'];