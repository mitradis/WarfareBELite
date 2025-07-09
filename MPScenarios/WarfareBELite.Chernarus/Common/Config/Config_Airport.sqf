Private['_balancePrice','_c','_longestAirportBuildTime','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Airport */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Airport_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTAIRPORTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRPORT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Airport */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Airport_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTAIRPORTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRPORT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

_longestAirportBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestAirportBuildTime) then {
			_longestAirportBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,2]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	};
} forEach (('WFBE_EASTAIRPORTUNITS' Call GetNamespace) + ('WFBE_WESTAIRPORTUNITS' Call GetNamespace));

['WFBE_LONGESTAIRPORTBUILDTIME',_longestAirportBuildTime,true] Call SetNamespace;

airportDistance = 60;
airportDirection = 180;
