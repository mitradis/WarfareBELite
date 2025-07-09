Private ['_aibase','_commanderTeam','_comVoteTime','_side','_sideText'];
_side = _this select 0;
_sideText = _side;

_comVoteTime = 'WFBE_VOTETIME' Call GetNamespace;
WF_Logic setVariable [Format["%1CommanderVoteTime",_sideText],_comVoteTime,true];

while {_comVoteTime > 0} do {
	sleep 1;
	_comVoteTime = _comVoteTime - 1;
	WF_Logic setVariable [Format["%1CommanderVoteTime",_sideText],_comVoteTime,true];
};
	
WF_Logic setVariable [Format["%1CommanderVoteTime",_sideText],_comVoteTime,true];

_commanderTeam = [_side] Call GetCommanderFromVotes;
if (!IsNull _commanderTeam) then {WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],_commanderTeam,true]} else {WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],objNull,true]};

// WFBE_CommanderVote = [_side,'CLTFNCCOMMANDERVOTE',_commanderTeam];
// publicVariable 'WFBE_CommanderVote';
// if (isHostedServer) then {[_side,'CLTFNCCOMMANDERVOTE',_commanderTeam] Spawn HandlePVF};
[_side, "CommanderVote", _commanderTeam] Call SendToClients;

[Format["WFBE_%1_LastCommander",_sideText],_commanderTeam,true] Call SetNamespace;

_aibase = Format["WFBE_%1_AIBase",_sideText] Call GetNamespace;
if (isNull _commanderTeam) then {
	if (paramAIcom && !_aibase) then {
		Call Compile Format["%1CommanderPercent = 0; publicVariable '%1CommanderPercent';",_sideText];
		[Format["WFBE_%1_AIBase",_sideText],true,true] Call SetNamespace;
		[_side] ExecFSM "Server\FSM\aicommander.fsm";
	};
} else {
	[Format["WFBE_%1_AIBase",_sideText],false,true] Call SetNamespace;
};
