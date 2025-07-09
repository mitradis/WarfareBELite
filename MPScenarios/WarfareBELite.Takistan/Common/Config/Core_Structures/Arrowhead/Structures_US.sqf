Private ['_c','_count','_d','_dir','_dis','_n','_s','_t','_v'];

/* Root Definition */
WESTHQ = "M1130_HQ_unfolded_EP1";
WESTBAR = "US_WarfareBBarracks_EP1";
WESTLVF = "US_WarfareBLightFactory_EP1";
WESTCC = "US_WarfareBUAVterminal_EP1";
WESTHEAVY = "US_WarfareBHeavyFactory_EP1";
WESTAIR = "US_WarfareBAircraftFactory_EP1";
WESTSP = "US_WarfareBVehicleServicePoint_EP1";
WESTAAR = "US_WarfareBAntiAirRadar_EP1";

/* Mash used after being deployed */
['WFBE_WESTFARP','Camp_EP1',true] Call SetNamespace;

/* Construction Crates */
['WFBE_WESTCONSTRUCTIONSITE','US_WarfareBContructionSite_EP1',true] Call SetNamespace;

/* Structures */
_v			= ["Headquarters"];
_n			= [WESTHQ];
_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
_t			= [30];
_s			= ["HQSite"];
_dis		= [15];
_dir		= [0];

_v = _v		+ ["Barracks"];
_n = _n		+ [WESTBAR];
_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c = _c		+ [200];
_t = _t		+ [70];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [18];
_dir = _dir	+ [90];

_v = _v		+ ["Light"];
_n = _n		+ [WESTLVF];
_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c = _c		+ [600];
_t = _t		+ [90];
_s = _s		+ ["MediumSite"];
_dis = _dis	+ [25];
_dir = _dir	+ [90];

_v = _v		+ ["CommandCenter"];
_n = _n		+ [WESTCC];
_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
_c = _c		+ [1200];
_t = _t		+ [110];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [20];
_dir = _dir	+ [90];

_v = _v		+ ["Heavy"];
_n = _n		+ [WESTHEAVY];
_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c = _c		+ [2800];
_t = _t		+ [130];
_s = _s		+ ["MediumSite"];
_dis = _dis	+ [25];
_dir = _dir	+ [90];

_v = _v		+ ["Aircraft"];
_n = _n		+ [WESTAIR];
_d = _d		+ [localize "STR_WF_AircraftFactory"];
_c = _c		+ [4400];
_t = _t		+ [150];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [31];
_dir = _dir	+ [90];

_v = _v		+ ["ServicePoint"];
_n = _n		+ [WESTSP];
_d = _d		+ [localize "STR_WF_MAIN_ServicePoint"];
_c = _c		+ [700];
_t = _t		+ [70];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [21];
_dir = _dir	+ [90];

if (paramAARadar) then {
	_v = _v		+ ["AARadar"];
	_n = _n		+ [WESTAAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [3200];
	_t = _t		+ [280];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
};

for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
	[Format["WFBE_WEST%1TYPE",_v select _count],_count,true] Call SetNamespace;
};

['WFBE_WESTMHQNAME','M1130_CV_EP1',true] Call SetNamespace;

['WFBE_WESTSTRUCTURES',_v,true] Call SetNamespace;
['WFBE_WESTSTRUCTURENAMES',_n,true] Call SetNamespace;
['WFBE_WESTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
['WFBE_WESTSTRUCTURECOSTS',_c,true] Call SetNamespace;
['WFBE_WESTSTRUCTURETIMES',_t,true] Call SetNamespace;
['WFBE_WESTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
['WFBE_WESTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
['WFBE_WESTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;

/* Defenses */
_n			= ["WarfareBMGNest_M240_US_EP1"];
_n = _n		+ ["M2HD_mini_TriPod_US_EP1"];
_n = _n		+ ["SearchLight_US_EP1"];
_n = _n		+ ["M2StaticMG_US_EP1"];
_n = _n		+ ["MK19_TriPod_US_EP1"];
_n = _n		+ ["TOW_TriPod_US_EP1"];
_n = _n		+ ["Stinger_Pod_US_EP1"];
_n = _n		+ ["M252_US_EP1"];
_n = _n		+ ["M119_US_EP1"];
_n = _n		+ ["Land_HBarrier3"];
_n = _n		+ ["Land_HBarrier5"];
_n = _n		+ ["Land_HBarrier_large"];
_n = _n		+ ["US_WarfareBBarrier5x_EP1"];
_n = _n		+ ["US_WarfareBBarrier10x_EP1"];
_n = _n		+ ["US_WarfareBBarrier10xTall_EP1"];
_n = _n		+ ["MASH_EP1"];
_n = _n		+ ["Land_fort_bagfence_long"];
_n = _n		+ ["Land_fort_bagfence_corner"];
_n = _n		+ ["Land_fort_bagfence_round"];
_n = _n		+ ["Land_fortified_nest_small_EP1"];
_n = _n		+ ["Land_fort_rampart_EP1"];
_n = _n		+ ["Land_fort_artillery_nest_EP1"];
_n = _n		+ ["Hhedgehog_concreteBig"];
_n = _n		+ ["Hedgehog_EP1"];
_n = _n		+ ["Land_CamoNet_NATO_EP1"];
_n = _n		+ ["Land_CamoNetVar_NATO_EP1"];
_n = _n		+ ["Land_CamoNetB_NATO_EP1"];
_n = _n		+ ["Sign_Danger"];
_n = _n		+ ["HeliH"];
_n = _n		+ ["Fort_RazorWire"];
_n = _n		+ ["Concrete_Wall_EP1"];
_n = _n		+ ["Land_Campfire"];
_n = _n		+ ["USOrdnanceBox_EP1"];
_n = _n		+ ["USVehicleBox_EP1"];
_n = _n		+ ["USBasicAmmunitionBox_EP1"];
_n = _n		+ ["USBasicWeapons_EP1"];
_n = _n		+ ["USLaunchers_EP1"];
_n = _n		+ ["USSpecialWeapons_EP1"];

/* Class used for AI, AI will attempt to build those */
['WFBE_WESTDEFENSES_MG',['M2StaticMG_US_EP1'],true] Call SetNamespace;
['WFBE_WESTDEFENSES_GL',['MK19_TriPod_US_EP1'],true] Call SetNamespace;
['WFBE_WESTDEFENSES_AAPOD',['Stinger_Pod_US_EP1'],true] Call SetNamespace;
['WFBE_WESTDEFENSES_ATPOD',['TOW_TriPod_US_EP1'],true] Call SetNamespace;
['WFBE_WESTDEFENSES_CANNON',['M119_US_EP1'],true] Call SetNamespace;
['WFBE_WESTDEFENSES_MASH',['MASH_EP1'],true] Call SetNamespace;

['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;