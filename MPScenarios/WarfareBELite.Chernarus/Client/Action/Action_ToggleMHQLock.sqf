Private ["_lock","_MHQ"];

_MHQ = _this select 0;

_lock = if (locked _MHQ) then {false} else {true};

["RequestVehicleLock", [_MHQ,_lock]] Call SendToServer;