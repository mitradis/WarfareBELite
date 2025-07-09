Private['_status','_team'];

_team = _this select 0;
_status = _this select 1;

if (isNull _team) exitWith {};

Call Compile Format ["%1Autonomous = _status; publicVariable '%1Autonomous';",_team getVariable 'identification'];