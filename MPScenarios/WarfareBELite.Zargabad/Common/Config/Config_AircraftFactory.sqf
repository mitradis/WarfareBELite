Private['_balancePrice','_c','_longestAircraftBuildTime','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Aircraft */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Aircraft */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

_longestAircraftBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestAircraftBuildTime) then {
			_longestAircraftBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,2]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	};
} forEach (('WFBE_EASTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_WESTAIRCRAFTUNITS' Call GetNamespace));

['WFBE_LONGESTAIRCRAFTBUILDTIME',_longestAircraftBuildTime,true] Call SetNamespace;
