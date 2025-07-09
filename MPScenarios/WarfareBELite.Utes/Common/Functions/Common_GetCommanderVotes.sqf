Private["_count","_side","_teams","_total","_vote","_votes"];

_side = _this Select 0;

_teams = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace);
_total = Count _teams + 1;

_votes = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {_votes = _votes + [0]};

//Count votes.
for [{_count = 1},{_count < _total},{_count = _count + 1}] do {
	if (isPlayer (leader (_teams Select (_count - 1)))) then {
		_vote = (Call Compile Format ["%1Team%2Vote",Str _side,_count]) + 1;
		_votes Set[_vote,(_votes Select _vote) + 1];
	};
};

_votes
