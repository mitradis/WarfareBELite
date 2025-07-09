Private ["_gear","_get","_j","_lb","_prefix","_upgrade_level","_values"];
_lb = _this select 0;
_gear = _this select 1;

_upgrade_level = ((sideJoinedText) Call GetSideUpgrades) select 12;

_j = 0;
for '_i' from 0 to count(_gear)-1 do {
	_values = (_gear select _i) select 0;
	_prefix = if (count (_gear select _i) > 1) then {(_gear select _i) select 1} else {""};
	{
		_get = missionNamespace getVariable Format ["%1%2",_prefix,_x];
		if !(isNil '_get') then {
			if ((_get select 3) <= _upgrade_level) then {
				lnbAddRow[_lb, [Format ["$%1.", _get select 2], _get select 1]];
				lnbSetPicture[_lb,[_j,0],_get select 0];
				lnbSetData[_lb,[_j,0],Format ["%1%2",_prefix,_x]];
				_j = _j + 1;
			};
		};
	} forEach _values;
};