Private ['_u'];

//--- USMC Depot Vehicles.
_u			= ["MMT_Civ"];
_u = _u		+ ["TT650_Civ"];
_u = _u		+ ["Lada1"];
_u = _u		+ ["SkodaBlue"];
_u = _u		+ ["car_sedan"];
_u = _u		+ ["car_hatchback"];
_u = _u		+ ["datsun1_civil_1_open"];
_u = _u		+ ["datsun1_civil_3_open"];
_u = _u		+ ["hilux1_civil_1_open"];
_u = _u		+ ["V3S_Civ"];
_u = _u		+ ["Ikarus"];
if (paramPurchaseInfDepot) then {
	_u = _u		+ ['WFBE_WESTSOLDIER' Call GetNamespace];
};

_u