/* KSK Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['GER_Soldier_MG_EP1'];
_i = _i + [['','',340,6,-1,2,0,0.95,'West',[]]];

_c = _c + ['GER_Soldier_Medic_EP1'];
_i = _i + [['','',325,6,-1,2,0,0.94,'West',[]]];

_c = _c + ['GER_Soldier_EP1'];
_i = _i + [['','',310,6,-1,2,0,0.94,'West',[]]];

_c = _c + ['GER_Soldier_Scout_EP1'];
_i = _i + [['','',345,6,-1,2,0,0.96,'West',[]]];

_c = _c + ['GER_Soldier_TL_EP1'];
_i = _i + [['','',355,6,-1,2,0,0.98,'West',[]]];

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
