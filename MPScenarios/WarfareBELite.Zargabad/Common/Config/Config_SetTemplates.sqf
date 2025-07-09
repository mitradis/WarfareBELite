Private ["_counts","_counts_b","_emplacement","_get","_items","_mags","_prefix","_s","_set","_side","_skiponexist","_u","_u_back","_u_backpack","_u_backpack_usedefault","_u_belong","_u_label","_u_mags","_u_picture","_u_price","_u_upgrade","_u_weap"];

_u = _this select 0;
_side = _this select 1;
_skiponexist = if (count _this > 2) then {_this select 2} else {true};

if (_skiponexist && !isNil {missionNamespace getVariable Format ["WFBE_%1_Template", _side]}) exitWith {};

_s = [];
for '_h' from 0 to count(_u)-1 do {
	_u_weap = (_u select _h) select 0;
	_u_mags = (_u select _h) select 1;
	_u_back = if (count (_u select _h) > 2) then {(_u select _h) select 2} else {[]};
	
	_set = [];
	_u_upgrade = 0;
	_u_price = 0;
	_u_label = "";
	_u_picture = "";
	_u_backpack = "";
	_u_backpack_usedefault = if (typeName _u_back == "SCALAR") then {true} else {false};
	
	for '_i' from 0 to count(_u_weap)-1 do {
		_get = missionNamespace getVariable (_u_weap select _i);
		if !(isNil '_get') then {
			_u_belong = _get select 4;
			if ((_get select 3) > _u_upgrade) then {_u_upgrade = (_get select 3)};
			_u_price = _u_price + (_get select 2);
			switch (true) do {
				case (_u_belong < 4): {
					if (_u_picture == "") then {_u_picture = (_get select 0)};
					if (_u_label != "") then {_u_label = _u_label + " | " + (_get select 1)} else {_u_label = _u_label + (_get select 1)};
				};
				case (_u_belong == 200): {_u_backpack = _u_weap select _i};
			};
		} else {
			_u_weap set [_i, false];
		};
	};
	
	_u_weap = _u_weap - [false];
	
	if (count _u_mags > 0) then {
		_mags = _u_mags select 0;
		_counts = _u_mags select 1;
		for '_i' from 0 to count(_mags)-1 do {
			_get = missionNamespace getVariable Format["Mag_%1",(_mags select _i)];
			if !(isNil '_get') then {
				if ((_get select 3) > _u_upgrade) then {_u_upgrade = (_get select 3)};
				if (_u_picture == "") then {_u_picture = (_get select 0)};
				if (_u_label == "") then {_u_label = (_get select 1)};
				_u_price = _u_price + ((_get select 2)*(_counts select _i));
			} else {
				_mags set [_i, false];
				_counts set [_i, false];
			};
		};
		
		_mags = _mags - [false];
		_counts = _counts - [false];
	};
	
	if (_u_backpack != "" && _u_backpack_usedefault) then {
		_get = missionNamespace getVariable _u_backpack;
		if !(isNil '_get') then {_u_back = _get select 5};
	};
	
	if (typeName _u_back == "SCALAR") then {_u_back = [[[],[]],[[],[]]]};

	if (count _u_back > 0 && _u_backpack != "") then {
		_prefix = "";
		for '_i' from 0 to count(_u_back)-1 do {
			_emplacement = _u_back select _i;
			
			if (count _emplacement > 0) then {
				_items = _emplacement select 0;
				_counts_b = _emplacement select 1;
				
				for '_j' from 0 to count(_items)-1 do {
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
				
				_items = _items - [false];
				_counts_b = _counts_b - [false];
				_u_back set [_i, [_items,_counts_b]];
			};
			_prefix = "Mag_";
		};
	};

	_set set [0,_u_picture];
	_set set [1,_u_label];
	_set set [2,_u_price];
	_set set [3,_u_upgrade];
	_set set [4,_u_weap];
	_set set [5,[_mags,_counts]];
	_set set [6,_u_back];

	_s = _s + [_set];
	
	
};



//--- Set or update.
if (isNil {missionNamespace getVariable Format ["WFBE_%1_Template", _side]}) then {
	missionNamespace setVariable [Format ["WFBE_%1_Template", _side], _s];
} else {
	missionNamespace setVariable [Format ["WFBE_%1_Template", _side], (missionNamespace getVariable Format ["WFBE_%1_Template", _side]) + _s];
};