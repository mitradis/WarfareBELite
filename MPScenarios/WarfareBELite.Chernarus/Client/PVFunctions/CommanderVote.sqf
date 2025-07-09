Private["_commanderTeam","_text"];

_commanderTeam = _this;

_text = Localize "STR_WF_CHAT_AI_Commander";
if (!IsNull _commanderTeam) then {
	_text = Format[localize "STR_WF_CHAT_VoteForNewCommander",name (leader _commanderTeam)];
	if (group player == _commanderTeam) then {_text = localize "STR_WF_CHAT_PlayerCommander"};
};

[_text] Call TitleTextMessage;