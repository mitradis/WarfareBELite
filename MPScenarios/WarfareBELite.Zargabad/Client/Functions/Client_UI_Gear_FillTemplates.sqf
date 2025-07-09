Private ["_ct","_lb","_template","_u","_upgrade_level"];
_lb = _this select 0;
_template = _this select 1;

_upgrade_level = (sideJoinedText) Call GetSideUpgrades;

_u = 0;
for '_i' from 0 to count(_template)-1 do {
	_ct = _template select _i;
	if ((_ct select 3) <= (_upgrade_level select 0) || (_ct select 3) <= (_upgrade_level select 12)) then {
		lnbAddRow[_lb, [Format ["$%1.", _ct select 2], _ct select 1]];
		if ((_ct select 0) != "") then {lnbSetPicture[_lb,[_u,0],(_ct select 0)]};
		lnbSetValue[_lb,[_u,0],_i];
		_u = _u + 1;
	};
};