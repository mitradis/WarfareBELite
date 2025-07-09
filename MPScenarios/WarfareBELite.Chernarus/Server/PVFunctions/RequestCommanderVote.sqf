Private["_commanderTeam","_side","_team"];

_side = _this;

if ((WF_Logic getVariable Format["%1CommanderVoteTime",str _side]) <= 0) then {
	_team = -1;
	_commanderTeam = (_side) Call GetCommanderTeam;

	if (!IsNull _commanderTeam) then {
		_team = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace) find _commanderTeam;
	};

	[_side,_team] Call SetCommanderVotes;
	[_side] Spawn SVoteForCommander;
	["VotingForNewCommander","",_side,""] Spawn SideMessage;

	// WFBE_VoteForCommander = [_side,'CLTFNCVOTEFORCOMMANDER'];
	// publicVariable 'WFBE_VoteForCommander';
	// if (isHostedServer) then {[_side,'CLTFNCVOTEFORCOMMANDER'] Spawn HandlePVF};
	
	[_side, "VoteForCommander"] Call SendToClients;
};
