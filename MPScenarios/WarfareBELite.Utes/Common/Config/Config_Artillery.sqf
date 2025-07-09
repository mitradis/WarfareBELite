/* Call in dynamically the west artillery. */
Call Compile PreprocessFile Format["Common\Config\Core_Artillery\%1\Artillery_%2.sqf",WFBE_V_West_ArtilleryRootVersion,WFBE_V_West_ArtilleryFaction];

/* Call in dynamically the east artillery. */
Call Compile PreprocessFile Format["Common\Config\Core_Artillery\%1\Artillery_%2.sqf",WFBE_V_East_ArtilleryRootVersion,WFBE_V_East_ArtilleryFaction];
