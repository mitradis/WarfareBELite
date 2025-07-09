Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

//--- USMC Airport Vehicles.
_u = [];
if (_r == 0) then {
	_u = _u 	+ ['MV22'];
	_u = _u		+ ['C130J'];
	_u = _u		+ ['F35B'];
	_u = _u		+ ['AV8B'];
	_u = _u		+ ['AV8B2'];
	_u = _u		+ ['A10'];
};

_u