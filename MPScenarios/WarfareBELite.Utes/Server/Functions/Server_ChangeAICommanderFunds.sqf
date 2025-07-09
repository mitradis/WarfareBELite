Private ["_amount","_funds","_side"];
_side = _this select 0;
_amount = _this select 1;

_funds = (_side) Call GetAICommanderFunds;

[Format ["WFBE_%1_AICommanderFunds",_side], _funds + _amount, true] Call SetNamespace;