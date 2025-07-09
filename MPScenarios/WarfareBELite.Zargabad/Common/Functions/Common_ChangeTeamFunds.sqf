Private['_amount','_team'];

_team = _this select 0;
_amount = _this select 1;

if (isNull _team) exitWith {};

Call Compile Format ["%1Funds = %1Funds + _amount; publicVariable '%1Funds';",_team getVariable 'identification'];