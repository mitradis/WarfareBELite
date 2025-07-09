Private['_balancePrice','_c','_longestLightBuildTime','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Light */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Light_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Light */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Light_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

_longestLightBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestLightBuildTime) then {
			_longestLightBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,3]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	};
} forEach (('WFBE_EASTLIGHTUNITS' Call GetNamespace) + ('WFBE_WESTLIGHTUNITS' Call GetNamespace));

['WFBE_LONGESTLIGHTBUILDTIME',_longestLightBuildTime,true] Call SetNamespace;
