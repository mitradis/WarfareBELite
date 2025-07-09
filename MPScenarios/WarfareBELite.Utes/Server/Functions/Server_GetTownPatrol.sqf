Private ["_group", "_side", "_sv", "_town", "_type", "_maxsvdef"];

_town = _this select 0;
_side = _this select 1;

_group = [];
_sv = _town getVariable "supplyValue";
_maxsvdef = 'WFBE_TOWNMAXSVDEFENDER' Call GetNamespace;

_type = switch (true) do {
	case (_sv <= 30 || _maxsvdef == 0): {"LIGHT"};
	case ((_sv > 30 && _sv <= 60) || _maxsvdef == 1): {"MEDIUM"};
	case (_sv > 60): {"HEAVY"};
};

_available = missionNamespace getVariable Format["WFBE_%1_PATROL_%2", _side, _type];
if (count _available > 0) then {_group = _available select floor(random count _available)};

_group