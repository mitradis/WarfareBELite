Private ["_towns"];

waitUntil {sleep 0.1;!(isNil 'townModeSet')};
waitUntil {sleep 0.1;townModeSet};

//--- Get all of the city logics.
_towns = [0,0,0] nearEntities [["LocationLogicDepot"], 100000];

//--- Await for a proper initialization.
{
	waitUntil {sleep 0.05;!isNil {_x getVariable "sideID"} || !isNil {_x getVariable "wfbe_inactive"}};
} forEach _towns;

townInit = true;
