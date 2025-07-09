Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* RU Airport Vehicles */
_u = [];
if (_r == 0) then {
	_u = _u 	+ ['Su34'];
	_u = _u		+ ['Su39'];
};

_u