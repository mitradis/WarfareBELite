Private ["_color","_town","_townMarker","_town_side_value","_town_side_value_new"];

_town = _this select 0;
_town_side_value = _this select 1;
_town_side_value_new = _this select 2;

//--- Make sure that the client is concerned by the capture either by capturing or having a town captured.
if !(WFBE_Client_SideID in [_town_side_value,_town_side_value_new]) exitWith {};

_side_captured = (_town_side_value_new) Call GetSideFromID;

//--- Color the town depending on the side which captured.
_color = missionNamespace getVariable (Format ["WFBE_C_%1_COLOR", _side_captured]);
_townMarker = Format ["WFBE_%1_CityMarker", _town];
_townMarker setMarkerColorLocal _color;

//--- Display a title message.
_side_label = switch (_side_captured) do {case west: {localize "STR_WF_PARAMETER_Side_West"}; case east: {localize "STR_WF_PARAMETER_Side_East"}; case resistance: {localize "STR_WF_Side_Resistance"};	default {"Civilian"}};
[Format[Localize "STR_WF_CHAT_Town_Captured", str _town, _side_label]] Call TitleTextMessage;

//--- Task.
_task = _town getVariable 'taskLink';
_ptask = currentTask player;
if (isNil '_task') then {_task = objNull};

//--- Taskman
["TownUpdate", _town] Spawn TaskSystem;

//--- Client side capture.
if (_town_side_value_new == WFBE_Client_SideID) then {
	//--- Retrieve the closest unit of the town.
	_closest = [_town, (units group player) Call GetLiveUnits] Call GetClosestEntity;
	
	//--- Client reward.
	if !(isNull _closest) then {
		//--- Check if the closest unit of the town in in range.
		_distance = _closest distance _town;
		
		_bonus = -1;
		_score = -1;
		if (_distance <= (missionNamespace getVariable "WFBE_TOWNCAPTURERANGE") * 3) then {
			//--- Capture
			_bonus = missionNamespace getVariable "WFBE_TOWNCAPTUREBOUNTY";
			_score = missionNamespace getVariable "WFBE_SCORECAPTURETOWN";
		} else {
			//--- Is it an assist?.
			if (_distance <= (missionNamespace getVariable "WFBE_C_TOWNS_CAPTURE_ASSIST")) then {
				//--- Assist.
				_bonus = missionNamespace getVariable "WFBE_TOWNASSISTCAPTUREBOUNTY";
				_score = missionNamespace getVariable "WFBE_SCOREASSISTCAPTURETOWN";
			};
		};
		
		//--- Update the funds if necessary.
		if (_bonus != -1) then {
			(_bonus) Call ChangePlayerFunds;
			Format[Localize "STR_WF_CHAT_Town_Bounty_Full", _town getVariable "name", _bonus] Call CommandChatMessage;
		};
		
		//--- Update the score necessary.
		if (_score != -1) then {["RequestChangeScore", [player,score player + _score]] Call SendToServer};
	};
	
	//--- Commander reward (if the player is the commander)
	if !(isNull commanderTeam) then {
		if (commanderTeam == group player) then {
			_bonus = (_town getVariable "startingSupplyValue") * (missionNamespace getVariable "WFBE_COMMANDERTOWNCAPTURECOEF");
			(_bonus) Call ChangePlayerFunds;
			["RequestChangeScore", [player,score player + (missionNamespace getVariable "WFBE_COMMANDERTOWNCAPTURESCORE")]] Call SendToServer;
			Format[Localize "STR_WF_CHAT_Commander_Bounty_Town", _bonus, _town getVariable "name"] Call CommandChatMessage;
		};
	};
	
	//--- Taskman
	if !(isNull _task) then {
		if (_ptask == _task) then {
			["TownAssignClosest"] Spawn TaskSystem;
		};
	};
};