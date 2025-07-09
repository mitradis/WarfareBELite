Private ['_artyNames','_i','_retVal','_side','_unit'];
_unit = _this select 0;
_side = _this select 1;

_retVal = -1;
_artyNames = Format ["WFBE_%1_ARTILLERY_NAMES",_side] Call GetNamespace;

for [{_i = 0},{_i < count(_artyNames)},{_i = _i + 1}] do {
	if (_unit in (_artyNames select _i)) exitWith {_retVal = _i};
};

_retVal