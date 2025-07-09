Private['_balancePrice','_c','_longestHeavyBuildTime','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Heavy */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Heavy */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

_longestHeavyBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestHeavyBuildTime) then {
			_longestHeavyBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,3]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	};
} forEach (('WFBE_EASTHEAVYUNITS' Call GetNamespace) + ('WFBE_WESTHEAVYUNITS' Call GetNamespace));

['WFBE_LONGESTHEAVYBUILDTIME',_longestHeavyBuildTime,true] Call SetNamespace;