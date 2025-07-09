Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* Takistan Airport Vehicles */
_u = [];
if (_r == 0) then {
	_u = _u		+ ['An2_TK_EP1'];
	_u = _u		+ ['L39_TK_EP1'];
	_u = _u		+ ['Su25_TK_EP1'];
};

_u