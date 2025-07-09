Private ["_backpack_content","_counts","_counts_b","_emplacement","_flag_cannotadd","_get","_index","_items","_mags","_magazines","_prefix","_process","_side_equipment","_template","_upgrades","_u_backpack","_u_belong","_u_label","_u_labels","_u_picture","_u_pictures","_u_price","_u_upgrade","_weapons"];

_weapons = +(_this select 0);
_magazines = +(_this select 1);
_backpack_content = +(_this select 2);

_u_upgrade = 0;
_u_price = 0;
_u_label = "";
_u_labels = ["","",""];
_u_picture = "";
_u_pictures = ["",""];
_u_backpack = "";
_set = [];
_mags = [];
_counts = [];

_side_equipment = missionNamespace getVariable Format ["WFBE_%1_All", WFBE_Client_SideJoinedText];
_flag_cannotadd = false;

//--- Weapons
for '_i' from 0 to count(_weapons)-1 do {
	_get = missionNamespace getVariable (_weapons select _i);
	if !(isNil '_get') then {
		_process = true;
		if !(WFBE_Allow_HostileGearSaving) then {if !((_weapons select _i) in _side_equipment) then {_weapons set [_i, false]; _process = false; _flag_cannotadd = true}};
		if (_process) then {
			_u_belong = _get select 4;
			if ((_get select 3) > _u_upgrade) then {_u_upgrade = (_get select 3)};
			_u_price = _u_price + (_get select 2);
			if (_u_belong in [0,3]) then {_u_labels set [0, _get select 1];_u_pictures set [0, _get select 0]};
			if (_u_belong == 1) then {_u_labels set [2, _get select 1]};
			if (_u_belong == 2) then {_u_labels set [1, _get select 1];_u_pictures set [1, _get select 0]};
			switch (true) do {
				case (_u_belong < 4): {
					if (_u_picture == "") then {_u_picture = (_get select 0)};
				};
				case (_u_belong == 200): {_u_backpack = _weapons select _i};
			};
		};
	} else {
		_weapons set [_i, false];
	};
};

//--- Attempt to set the best picture.
if (_u_picture != "") then {
	{if (_x != "") exitWith {_u_picture = _x}} forEach _u_pictures;
};

//--- Attempt to set the best desc.
{
	if (_x != "") then {
		if (_u_label != "") then {_u_label = Format ["%1 | %2",_u_label, _x]} else {_u_label = _x};
	};
} forEach _u_labels;

_weapons = _weapons - [false];
//--- Magazines
if (count _magazines > 0) then {
	{
		_get = missionNamespace getVariable Format["Mag_%1",_x];
		if !(isNil '_get') then {
			_process = true;
			if !(WFBE_Allow_HostileGearSaving) then {if !(_x in _side_equipment) then {_process = false; _flag_cannotadd = true}};
			if (_process) then {
				_index = _mags find _x;
				if (_index != -1) then {
					_counts set [_index, (_counts select _index)+1];
				} else {
					[_mags, _x] Call ArrayPush;
					[_counts, 1] Call ArrayPush;
				};
				if ((_get select 3) > _u_upgrade) then {_u_upgrade = (_get select 3)};
				if (_u_picture == "") then {_u_picture = (_get select 0)};
				if (_u_label == "") then {_u_label = (_get select 1)};
				_u_price = _u_price + (_get select 2);
			};
		};
	} forEach _magazines;
};

//--- Backpacks
if (_u_backpack != "" && count(_backpack_content) > 0) then {
	_prefix = "";
	for '_i' from 0 to count(_backpack_content)-1 do {
		_emplacement = _backpack_content select _i;
		
		if (count _emplacement > 0) then {
			_items = _emplacement select 0;
			_counts_b = _emplacement select 1;
			
			for '_j' from 0 to count(_items)-1 do {
				_process = true;
				if !(WFBE_Allow_HostileGearSaving) then {if !((_items select _j) in _side_equipment) then {_items set [_j, false];_counts_b set [_j, false];_process = false; _flag_cannotadd = true}};
				if (_process) then {
					_get = missionNamespace getVariable Format["%1%2",_prefix,(_items select _j)];
					if !(isNil '_get') then {
						if ((_get select 3) > _u_upgrade) then {_u_upgrade = (_get select 3)};
						if (_u_picture == "") then {_u_picture = (_get select 0)};
						if (_u_label == "") then {_u_label = (_get select 1)};
						_u_price = _u_price + ((_get select 2)*(_counts_b select _j));
					} else {
						_items set [_j, false];
						_counts_b set [_j, false];
					};
				};
			};
			
			_items = _items - [false];
			_counts_b = _counts_b - [false];
			_backpack_content set [_i, [_items,_counts_b]];
		};
		_prefix = "Mag_";
	};
} else {
	_backpack_content = [];
};

if (_flag_cannotadd) exitWith {hint localize "STR_WF_Template_Cannot_Be_Set"};

//--- Check the final upgrade level.
_upgrades = (WFBE_Client_SideJoined) Call GetSideUpgrades;
if (_u_upgrade <= (_upgrades select 0) || _u_upgrade <= (_upgrades select 12)) then {
	_set set [0,_u_picture];
	_set set [1,_u_label];
	_set set [2,_u_price];
	_set set [3,_u_upgrade];
	_set set [4,_weapons];
	_set set [5,[_mags,_counts]];
	_set set [6,_backpack_content];

	_template = missionNamespace getVariable Format ["WFBE_%1_Template", WFBE_Client_SideJoinedText];
	[_template, _set] Call ArrayPush;
	missionNamespace setVariable [Format ["WFBE_%1_Template", WFBE_Client_SideJoinedText], _template];
} else {
	hint localize "STR_WF_Template_Too_Hight";
};