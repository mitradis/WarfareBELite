Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

//--- Russian Aircraft Vehicles.
_u 			= ['Mi17_Ins'];
_u = _u		+ ['Mi17_medevac_RU'];
if (_r == 0 ||_r == 1) then {
	_u = _u		+ ['Mi17_rockets_RU'];
	_u = _u		+ ['Mi24_V'];
	_u = _u		+ ['Mi24_P'];
	_u = _u		+ ['Ka52'];
	_u = _u		+ ['Ka52Black'];
};
if (_r == 0) then {
	_u = _u		+ ['Su34'];
	_u = _u		+ ['Su39'];
};

_u