Private ["_AITrucks","_hq","_isDeployed","_maist","_side","_sideText"];
_side = _this select 0;
_sideText = str _side;
_maist = 'WFBE_MAXAISUPPLYTRUCKS' Call GetNamespace;

sleep ((Random 200) / 100);
sleep ((Random 200) / 100);

waitUntil {sleep 1;townInit};

while {!gameOver} do {
	sleep 60;
	_AITrucks = Format ["WFBE_%1_AISupplyTrucks",_sideText] Call GetNamespace;
	if (count _AITrucks < _maist) then {
		_isDeployed = (_sideText) Call GetSideHQDeployed;
		_hq = (_sideText) Call GetSideHQ;
		if (_isDeployed && alive _hq) then {
			
			[_side] ExecFSM "Server\FSM\supplytruck.fsm";
		};
	};
};
