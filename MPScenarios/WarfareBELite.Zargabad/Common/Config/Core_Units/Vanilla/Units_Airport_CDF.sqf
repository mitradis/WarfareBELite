Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* CDF Airport Vehicles */
_u = [];
if (_r == 0) then {
	_u = _u		+ ['Mi24_D'];
};

_u