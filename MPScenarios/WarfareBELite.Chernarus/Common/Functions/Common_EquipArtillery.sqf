Private ['_ammo','_currentUpgrades','_extMagUpgr','_i','_index','_side','_unit'];
_unit = _this select 0;
_index = _this select 1;
_side = _this select 2;

//--- Browse for extended Mags (WP, SADARM... )
_ammo = (Format['WFBE_%1_ARTILLERY_EXTENDED_MAGS',_side] Call GetNamespace) select _index;
if (count _ammo == 0) exitWith {};

_extMagUpgr = Format['WFBE_%1_ARTILLERY_EXTENDED_MAGS_UPGRD',_side] Call GetNamespace;

//--- Retrieve the Artillery upgrade level.
_currentUpgrades = ((str _side) Call GetSideUpgrades) select 15;

for [{_i = 0},{_i < count(_ammo)},{_i = _i + 1}] do {
	if (_currentUpgrades >= ((_extMagUpgr select _index) select _i)) then {
		_unit addMagazine (_ammo select _i);
	};
};