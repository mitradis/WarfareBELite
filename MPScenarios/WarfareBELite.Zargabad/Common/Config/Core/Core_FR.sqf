/* FR Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['FR_GL'];
_i = _i + [['','',260,6,-1,2,0,0.98,'West',[]]];

_c = _c + ['FR_Corpsman'];
_i = _i + [['','',270,6,-1,2,0,0.98,'West',[]]];

_c = _c + ['FR_Commander'];
_i = _i + [['','',295,6,-1,2,0,1.00,'West',[]]];

_c = _c + ['FR_TL'];
_i = _i + [['','',285,6,-1,2,0,1.00,'West',[]]];

_c = _c + ['FR_Assault_R'];
_i = _i + [['','',280,6,-1,2,0,0.99,'West',[]]];

_c = _c + ['FR_Assault_GL'];
_i = _i + [['','',285,6,-1,2,0,0.99,'West',[]]];

_c = _c + ['FR_AR'];
_i = _i + [['','',290,6,-1,2,0,0.98,'West',[]]];

_c = _c + ['FR_R'];
_i = _i + [['','',300,6,-1,2,0,0.98,'West',[]]];

_c = _c + ['FR_Sapper'];
_i = _i + [['','',310,6,-1,2,0,0.98,'West',[]]];

_c = _c + ['FR_AC'];
_i = _i + [['','',320,6,-1,2,0,1.0,'West',[]]];

_c = _c + ['FR_Marksman'];
_i = _i + [['','',340,6,-1,2,0,0.99,'West',[]]];

/* Infantry - Special Characters */
_c = _c + ['FR_Cooper'];
_i = _i + [['','',400,6,-1,3,0,1.0,'West',[]]];

_c = _c + ['FR_Miles'];
_i = _i + [['','',400,6,-1,3,0,1.0,'West',[]]];

_c = _c + ['FR_OHara'];
_i = _i + [['','',400,6,-1,3,0,1.0,'West',[]]];

_c = _c + ['FR_Rodriguez'];
_i = _i + [['','',400,6,-1,3,0,1.0,'West',[]]];

_c = _c + ['FR_Sykes'];
_i = _i + [['','',400,6,-1,3,0,1.0,'West',[]]];

for '_z' from 0 to (count _c)-1 do {
	if (isClass (configFile >> 'CfgVehicles' >> (_c select _z))) then {
		_get = (_c select _z) Call GetNamespace;
		if (isNil '_get') then {
			if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
			if (typeName ((_i select _z) select 4) == 'SCALAR') then {
				if (((_i select _z) select 4) == -2) then {
					_ret = (_c select _z) Call Compile preprocessFile "Common\Functions\Common_GetConfigVehicleCrewSlot.sqf";
					(_i select _z) set [4, _ret select 0];
					(_i select _z) set [9, _ret select 1];
				};
			};
			_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
			(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
			[_c select _z,_i select _z] Call SetNamespace;
		};
	};
};
