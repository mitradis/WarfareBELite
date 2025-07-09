Private["_assist","_bounty","_get","_name","_type"];

_type = _this select 0;
_assist = _this select 1;

_get = _type Call GetNamespace;

_name = _get select QUERYUNITLABEL;
_bounty = round((_get select QUERYUNITPRICE) * ('WFBE_BOUNTYMODIFIER' Call GetNamespace));

//--- Are we dealing with a kill assist or a full kill.
if (_assist) then {
	_bounty = _bounty * ('WFBE_BOUNTYMODIFIERASSIST' Call GetNamespace);
	Format[Localize "STR_WF_CHAT_Award_Bounty_Assist",_bounty,_name] Call GroupChatMessage;
} else {
	Format[Localize "STR_WF_CHAT_Award_Bounty",_bounty,_name] Call GroupChatMessage;
};

_bounty Call ChangePlayerFunds;