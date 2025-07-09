Private ['_action','_from','_unit'];
_unit = _this select 0;
_action = _this select 1;
_from = _this select 2;

_unit action [_action, _from];

switch (_action) do {
	case "EJECT": {unassignVehicle _unit};
};
