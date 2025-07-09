Private ['_boundariesXY'];
_boundariesXY = -1;

switch (toLower(worldName)) do {
	case 'chernarus': {_boundariesXY = 15360};
	case 'takistan': {_boundariesXY = 12800};
	case 'utes': {_boundariesXY = 5120};
	case 'zargabad': {_boundariesXY = 8192};
};

if (paramBoundaries) then {
	if (_boundariesXY == -1) then {
		paramBoundaries = false;
		if (local player) then {
			BoundariesIsOnMap = nil;
			BoundariesHandleOnMap = nil;
		};
		
	} else {
		['WFBE_BOUNDARIESXY',_boundariesXY,true] Call SetNamespace;
		
	};
} else {
	if (_boundariesXY == -1) then {
		
	} else {
		['WFBE_BOUNDARIESXY',_boundariesXY,true] Call SetNamespace;
		
	};
};