Private ["_eallies","_efolder","_u","_wallies","_wfolder"];

//--- Folders and Faction.
_eallies = "INS";
_efolder = "Vanilla";
_wallies = "CDF";
_wfolder = "Vanilla";

//--- West Allies.
['WFBE_WESTALLIESCREW','CDF_Soldier_Crew',true] Call SetNamespace;
['WFBE_WESTALLIESSOLDIER','CDF_Soldier',true] Call SetNamespace;
['WFBE_WESTALLIESPILOT','CDF_Soldier_Pilot',true] Call SetNamespace;

_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Barracks_%2.sqf",_wfolder,_wallies];
['WFBE_WESTALLIESBARRACKSUNITS',_u,true] Call SetNamespace;	
_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Light_%2.sqf",_wfolder,_wallies];
['WFBE_WESTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",_wfolder,_wallies];
['WFBE_WESTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",_wfolder,_wallies];
['WFBE_WESTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;

//--- East Allies.
['WFBE_EASTALLIESCREW','Ins_Soldier_Crew',true] Call SetNamespace;
['WFBE_EASTALLIESSOLDIER','Ins_Soldier_1',true] Call SetNamespace;
['WFBE_EASTALLIESPILOT','Ins_Soldier_Pilot',true] Call SetNamespace;

_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Barracks_%2.sqf",_efolder,_eallies];
['WFBE_EASTALLIESBARRACKSUNITS',_u,true] Call SetNamespace;	
_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Light_%2.sqf",_efolder,_eallies];
['WFBE_EASTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",_efolder,_eallies];
['WFBE_EASTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
_u = Call Compile preprocessFile Format ["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",_efolder,_eallies];
['WFBE_EASTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
