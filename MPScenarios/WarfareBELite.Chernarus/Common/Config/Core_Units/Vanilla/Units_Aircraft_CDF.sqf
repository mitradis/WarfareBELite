Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* Chernarus Aircraft Vehicles */
_u			= ['Mi17_CDF'];
_u = _u		+ ['Mi17_medevac_CDF'];
if (_r == 0 ||_r == 1) then {
	_u = _u		+ ['Mi24_D'];
};
if (_r == 0) then {
	_u = _u		+ ['Su25_CDF'];
};

_u