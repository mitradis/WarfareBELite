Private ["_arty"];
_arty = _this select 0;

waitUntil {sleep 0.05;!(isNil 'BIS_ARTY_LOADED')};
waitUntil {sleep 0.05;BIS_ARTY_LOADED};
sleep 5;

[_arty] call BIS_ARTY_F_initVehicle;