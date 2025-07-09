Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

//--- Insurgent Aircraft Vehicles.
_u			= ['Mi17_Ins'];
_u = _u		+ ['Mi17_medevac_Ins'];
if (_r == 0 ||_r == 1) then {
	_u = _u		+ ['Mi24_V'];
};
if (_r == 0) then {
	_u = _u		+ ['Su25_Ins'];
};

_u