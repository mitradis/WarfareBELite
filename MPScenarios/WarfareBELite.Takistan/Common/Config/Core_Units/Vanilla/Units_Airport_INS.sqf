Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* Insurgent Airport Vehicles */
_u = [];
if (_r == 0) then {
	_u = _u		+ ['Su25_Ins'];
};

_u