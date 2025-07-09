/* ACE US Desert Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Heavy Vehicles */
_c = _c + ['ACE_Stryker_RV_SLAT_D'];
_i = _i + [['','',1800,25,[false,true,2,0],0,2,0,'West',[]]];

_c = _c + ['ACE_M1A1HA_TUSK_DESERT'];
_i = _i + [['','',5850,40,-2,2,2,0,'West',[]]];

_c = _c + ['ACE_M1A1HA_TUSK_CSAMM_DESERT'];
_i = _i + [['','',6450,40,-2,3,2,0,'West',[]]];

/* Air Vehicles */
_c = _c + ['ACE_AH6_GAU19_FLIR'];
_i = _i + [['','',29500,50,-2,2,3,0,'West',[]]];

_c = _c + ['ACE_AH6J_DAGR_FLIR'];
_i = _i + [['','',35500,50,-2,2,3,0,'West',[]]];

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
