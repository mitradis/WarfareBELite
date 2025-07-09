Private ['_canjoin','_name'];
_name = _this select 0;
_canjoin = _this select 1;

if (!_canjoin && vehicleVarName player != _name) then {_canjoin = true};

['WFBE_P_CANJOIN',_canjoin,true] Call SetNamespace;