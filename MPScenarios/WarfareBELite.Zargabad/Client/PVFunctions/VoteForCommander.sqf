if (votePopUp) then {
	Private ["_voteTime"];
	_voteTime = 0;
	waitUntil {sleep 0.05;_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];!isNil "_voteTime"};
	if (_voteTime > 0 && !voted) then {CreateDialog "RscMenu_Voting"};
	if (voted) then {voted = false};
};