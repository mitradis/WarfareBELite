Private["_index"];

_index = ('WFBE_EASTSLOTNAMES' Call GetNamespace) find (vehicleVarName _this);
if (_index < 0) then {_index = ('WFBE_WESTSLOTNAMES' Call GetNamespace) find (vehicleVarName _this)};

_index + 1