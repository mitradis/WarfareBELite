Private ['_canUpdate','_commander','_team'];
_team = _this;

_canUpdate = true;
if (((leader _team) Call GetClientID) != 0) then {
	_commander = (side _team) Call GetCommanderTeam;
	if !(isNull _commander) then {_canUpdate = false};
};

_canUpdate