Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

//--- Takistan Aircraft Vehicles.
_u 			= ['Mi17_TK_EP1'];
_u = _u		+ ['UH1H_TK_EP1'];
if (_r == 0 ||_r == 1) then {
	_u = _u		+ ['Mi24_D_TK_EP1'];
	_u = _u		+ ['Ka52Black'];
};
if (_r == 0) then {
	_u = _u		+ ['An2_TK_EP1'];
	_u = _u		+ ['L39_TK_EP1'];
	_u = _u		+ ['Su25_TK_EP1'];
};

_u