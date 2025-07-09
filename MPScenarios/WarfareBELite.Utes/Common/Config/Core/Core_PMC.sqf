/* PMC Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['Soldier_AA_PMC'];
_i = _i + [['','',300,6,-1,2,0,0.92,'West',[]]];

_c = _c + ['Soldier_AT_PMC'];
_i = _i + [['','',260,6,-1,0,0,0.90,'West',[]]];

_c = _c + ['Soldier_Bodyguard_AA12_PMC'];
_i = _i + [['','',325,6,-1,3,0,0.94,'West',[]]];

_c = _c + ['Soldier_Bodyguard_M4_PMC'];
_i = _i + [['','',225,6,-1,0,0,0.94,'West',[]]];

_c = _c + ['Soldier_Crew_PMC'];
_i = _i + [['','',170,6,-1,0,0,0.89,'West',[]]];

_c = _c + ['Soldier_Engineer_PMC'];
_i = _i + [['','',270,6,-1,2,0,0.91,'West',[]]];

_c = _c + ['Soldier_GL_M16A2_PMC'];
_i = _i + [['','',185,6,-1,0,0,0.92,'West',[]]];

_c = _c + ['Soldier_GL_PMC'];
_i = _i + [['','',260,6,-1,2,0,0.92,'West',[]]];

_c = _c + ['Soldier_M4A3_PMC'];
_i = _i + [['','',210,6,-1,1,0,0.91,'West',[]]];

_c = _c + ['Soldier_Medic_PMC'];
_i = _i + [['','',255,6,-1,2,0,0.92,'West',[]]];

_c = _c + ['Soldier_MG_PKM_PMC'];
_i = _i + [['','',190,6,-1,0,0,0.90,'West',[]]];

_c = _c + ['Soldier_MG_PMC'];
_i = _i + [['','',260,6,-1,3,0,0.92,'West',[]]];

_c = _c + ['Soldier_Pilot_PMC'];
_i = _i + [['','',175,6,-1,0,0,0.90,'West',[]]];

_c = _c + ['Soldier_PMC'];
_i = _i + [['','',230,6,-1,0,0,0.91,'West',[]]];

_c = _c + ['Soldier_Sniper_KSVK_PMC'];
_i = _i + [['','',290,6,-1,0,0,0.94,'West',[]]];

_c = _c + ['Soldier_Sniper_PMC'];
_i = _i + [['','',275,6,-1,0,0,0.94,'West',[]]];

_c = _c + ['Soldier_TL_PMC'];
_i = _i + [['','',280,6,-1,0,0,0.95,'West',[]]];

/* Light Vehicles */
_c = _c + ['SUV_PMC'];
_i = _i + [['','',300,20,-2,0,1,0,'West',[]]];

_c = _c + ['ArmoredSUV_PMC'];
_i = _i + [['','',1250,25,-2,0,1,0,'West',[]]];

/* Air Vehicles */
_c = _c + ['Ka137_PMC'];
_i = _i + [['','',3000,35,-2,0,3,0,'West',[]]];

_c = _c + ['Ka137_MG_PMC'];
_i = _i + [['','',3500,35,-2,0,3,0,'West',[]]];

_c = _c + ['Ka60_PMC'];
_i = _i + [['','',16000,43,-2,0,3,0,'West',[]]];

_c = _c + ['Ka60_GL_PMC'];
_i = _i + [['','',17000,45,-2,0,3,0,'West',[]]];

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
