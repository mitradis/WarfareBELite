Private ["_belong","_cpt","_div","_faction","_n","_o","_p","_set","_type","_u","_z"];

_faction = _this select 0;
_u = _this select 1;
_p = _this select 2;
_n = _this select 3;
_o = _this select 4;
_z = _this select 5;

_cpt = 0;
for '_i' from 0 to count(_u)-1 do {
	if (isClass(configFile >> 'CfgMagazines' >> (_u select _i))) then {
		if (isNil {missionNamespace getVariable Format["Mag_%1",_u select _i]}) then {
			_set = [];
			_div = 0;
			_type = getNumber(configFile >> 'CfgMagazines' >> (_u select _i) >> "type");
			_belong = -1;
			switch (true) do {
				case (_type >= 16 && _type < 256): {_belong = 100;_div = 16};
				case (_type >= 256 && _type < 4096): {_belong = 101;_div = 256};
			};
			
			if (_belong != -1) then {
				_set set [0, if ((_p select _i) == '') then {getText(configFile >> 'CfgMagazines' >> (_u select _i) >> "picture")} else {_p select _i}];
				_set set [1, if ((_n select _i) == '') then {getText(configFile >> 'CfgMagazines' >> (_u select _i) >> "displayName")} else {_n select _i}];
				_set set [2, _o select _i];
				_set set [3, _z select _i];
				_set set [4, _belong];
				_set set [5, _type/_div];
				_set set [6, _u select _i];
				
				missionNamespace setVariable [Format["Mag_%1",_u select _i], _set];
				_cpt = _cpt + 1;
			};
		} else {
			_cpt = _cpt + 1;
		};
	};
};

