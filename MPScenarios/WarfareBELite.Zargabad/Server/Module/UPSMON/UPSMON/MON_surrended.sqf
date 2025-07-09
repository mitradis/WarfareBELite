private ["_side","_soldiers"];
_side = _this select 0;

_soldiers = switch (_side) do {
  case west: {KRON_AllWest};
  case east: {KRON_AllEast};
  case resistance: {KRON_AllRes};
};

{
	if ( leader _x == _x ) then {
		_x addaction [localize "STR_WF_ACTION_OrderFollowMe", "scripts\UPSMON\actions\followme.sqf", [], 1, false];
	} else {
		_x addaction [localize "STR_WF_ACTION_FollowMe", "scripts\UPSMON\actions\followme.sqf", [], 1, false];
	};
}foreach _soldiers;

if (true) exitWith {};
