Private ['_u'];

/* Insurgent Depot Vehicles */
_u			= ["MMT_Civ"];
_u = _u		+ ["TT650_Civ"];
_u = _u		+ ["Lada2"];
_u = _u		+ ["LadaLM"];
_u = _u		+ ["SkodaRed"];
_u = _u		+ ["datsun1_civil_2_covered"];
_u = _u		+ ["UralCivil"];
if (paramPurchaseInfDepot) then {
	_u = _u		+ ['WFBE_EASTSOLDIER' Call GetNamespace];
};

_u