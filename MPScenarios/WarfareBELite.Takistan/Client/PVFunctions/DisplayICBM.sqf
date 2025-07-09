Private ["_cruise","_obj"];

_obj = _this select 0;
_cruise = _this select 1;
waitUntil {sleep 0.05;!alive _cruise || isNull _cruise};
[_obj] Spawn Nuke;