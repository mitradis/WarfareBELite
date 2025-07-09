Private ["_string"];

_string = _this;
if (isMultiplayer) then {
	hint _string;
} else {
	hintC _string;
};