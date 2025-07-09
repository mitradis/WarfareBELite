Private ["_cmdrTeam","_side"];
_side = _this;

_cmdrTeam = WF_Logic getVariable Format ["%1CommanderTeam",str _side];
if (isNil "_cmdrTeam") then {_cmdrTeam = objNull};

_cmdrTeam