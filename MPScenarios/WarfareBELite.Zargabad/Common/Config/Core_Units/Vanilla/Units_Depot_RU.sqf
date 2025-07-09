Private ['_u'];

/* Russian Depot Vehicles */
_u			= ["MMT_Civ"];
_u = _u		+ ["TT650_Civ"];
_u = _u		+ ["Tractor"];
_u = _u		+ ["Lada2"];
_u = _u		+ ["LadaLM"];
_u = _u		+ ["SkodaRed"];
_u = _u		+ ["VWGolf"];
_u = _u		+ ["datsun1_civil_2_covered"];
_u = _u		+ ["hilux1_civil_2_covered"];
_u = _u		+ ["UralCivil"];
if (paramPurchaseInfDepot) then {
	_u = _u		+ ['WFBE_EASTSOLDIER' Call GetNamespace];
};

_u