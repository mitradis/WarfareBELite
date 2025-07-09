MenuAction = -1;

_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];
if (_voteTime <= 0) exitWith {};

_name = "";
_lastTeams = [];
_lastTeam = -2;

_lastVotes = [sideJoined] Call GetCommanderVotes;

while {true} do {
	sleep 0.1;

	if (!(alive player) || Side player != sideJoined) exitWith {CloseDialog 0;_exit = true};
	if !(dialog) exitWith {};

	_commanderTeam = [sideJoined] Call GetCommanderFromVotes;
	if (IsNull _commanderTeam) then {_name = Localize "STR_WF_AI"} else {_name = name leader _commanderTeam};

	_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];
	ctrlSetText [10007,Format ["%1",_name]];
	ctrlSetText [10008,Format ["%2: %3",_name,Localize "STR_WF_VOTING_TimeLeft",_voteTime]];
	
	if (_voteTime <= 0) exitWith {CloseDialog 0};

	_refresh = false;
	_playerSlots = [];
	{
		if !(isNil '_x') then {if (isPlayer (leader _x)) then {_playerSlots = _playerSlots + [_x]}};
	} forEach clientTeams;

	_count = 0;
	_votes = [sideJoined] Call GetCommanderVotes;

	{if (_x != (_votes Select _count)) then {_refresh = true};_count = _count + 1} ForEach _lastVotes;
	{if !(_x In _lastTeams) then {_refresh = true}} ForEach _playerSlots;
	{if !(_x In _playerSlots) then {_refresh = true}} ForEach _lastTeams;
	
	if (_refresh) then {

		_reselect = false;
		_selected = lbCurSel 10006;
		_selectedTeam = lbValue[10006,_selected];
		_selectedText = lbText[10006,_selected];
		_lastVotes = _votes;

		if (_selected != -1) then {_reselect = true};

		lbClear 10006;
		_AI = lbAdd[10006,Format["%1        %2",_votes select 0,Localize "STR_WF_AI"]];
		lbSetValue [10006,_AI,-1];

		_count = 0;
		_total = 1;

		{
			if !(isNil '_x') then {if (_x In _playerSlots) then {_total = _total + 1;_selection = lbAdd[10006,Format ["%1        %2",_votes select _count+1,name (leader _x)]];lbSetValue [10006,_selection,_count]}};_count = _count + 1;
		} forEach clientTeams;
		_lastTeams = +_playerSlots;

		if (_reselect) then {
			_selected = 0;
			for [{_count = 0},{_count < _total},{_count = _count + 1}] do {if (lbValue[10006,_count] == _selectedTeam) then {_selected = _count}};
			lbSetCurSel[10006,_selected];
		};
	};

	_selected = lbCurSel 10006;
	if (_selected != -1) then {
		_selectedTeam = lbValue[10006,_selected];
		if (_selectedTeam != _lastTeam) then {Call Compile Format["%1Team%2Vote = _selectedTeam;publicVariable '%1Team%2Vote';",sideJoinedText,clientID]};
		_lastTeam = _selectedTeam;
	};
};