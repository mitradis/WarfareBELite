Private ["_funds"];

if (isNull _this) exitWith {0};

_funds = Call Compile Format ["%1Funds",_this getVariable 'identification'];
if (isNil '_funds') exitWith {0};
_funds