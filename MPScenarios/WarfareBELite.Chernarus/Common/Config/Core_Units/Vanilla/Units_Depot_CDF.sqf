Private ['_u'];

/* CDF Depot Vehicles */
_u			= ["MMT_Civ"];
_u = _u		+ ["TT650_Civ"];
_u = _u		+ ["Lada1"];
_u = _u		+ ["SkodaBlue"];
_u = _u		+ ["car_hatchback"];
_u = _u		+ ["datsun1_civil_1_open"];
_u = _u		+ ["V3S_Civ"];
if (paramPurchaseInfDepot) then {
	_u = _u		+ ['WFBE_WESTSOLDIER' Call GetNamespace];
};

_u