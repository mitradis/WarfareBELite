Private ["_canSpeak","_extra","_localizedString","_locRaw","_receiver","_rlName","_side","_speaker","_special","_specialb","_topicSide","_value"];
_special = _this select 0;
_specialb = _this select 1;
_side = _this select 2;
_extra = "";
if (count _this > 3) then {_extra = _this select 3};

//todo define res later on.
if (_side == resistance) exitWith {};

_speaker = BIS_WF_HQEAST; _receiver = BIS_WF_HQEAST2; _topicSide = BIS_WF_HQEAST_TI;
if (_side == west) then {_speaker = BIS_WF_HQWEST;_receiver = BIS_WF_HQWEST2; _topicSide = BIS_WF_HQWEST_TI};

//--- Radio: Base building / attacks / destruction.
if (_special in ["Destroyed","IsUnderAttack","Constructed"]) then {
	_localizedString = localize "strwfbarracks";
	_value = "Barracks";
	switch (typeName _specialb) do {
		case "OBJECT": {
			_localizedString = _specialb getVariable "name";
			_dub = _specialb getVariable "wfbe_town_dubbing";
			if (_dub != "Town") then {if (count(getArray(configFile >> (missionNamespace getVariable Format ["WFBE_%1_RadioAnnouncers_Config", _side]) >> "Words" >> _dub)) == 0) then {_dub = "Town"}};
			
			_value = _dub;
		};
		case "STRING": {
			if (_specialb == ('WFBE_WESTMHQNAME' Call GetNamespace) || _specialb == ('WFBE_EASTMHQNAME' Call GetNamespace)) then {_localizedString = localize "STRHeadquarters";_value = "Headquarters";if (_special == "Constructed") then {_special = "Mobilized"}};
			if (_specialb == WESTHQ || _specialb == EASTHQ) then {_localizedString = localize "STRHeadquarters";_value = "Headquarters";if (_special == "Constructed") then {_special = "Deployed"}};
			if (_specialb == WESTLVF || _specialb == EASTLVF) then {_localizedString = localize "STRLightVehicleSupply";_value = "LightVehicleSupply"};
			if (_specialb == WESTCC || _specialb == EASTCC) then {
				_localizedString = localize "STR_WF_CommandCenter";
				_value = "UAVTerminal";
				if (WF_A2_Arrowhead) then {_value = "CommandPost"};
			};
			if (_specialb == WESTHEAVY || _specialb == EASTHEAVY) then {_localizedString = localize "STRHeavyVehicleSupply";_value = "HeavyVehicleSupply"};
			if (_specialb == WESTAIR || _specialb == EASTAIR) then {_localizedString = localize "STRHelipad";_value = "Helipad"};
			if (_specialb == WESTSP || _specialb == EASTSP) then {_localizedString = localize "STRServicePoint";_value = "ServicePoint"};
			if (_specialb == WESTAAR || _specialb == EASTAAR) then {_localizedString = localize "STRAntiAirRadar";_value = "AntiAirRadar"};
		};
	};
	_speaker kbTell [_receiver, _topicSide, _special,["1","",_localizedString,[_value]],true];
};

//--- Radio: Town Capture/Loss.
if (_special in ["Lost","Captured","HostilesDetectedNear"]) then {
	_locRaw = str _specialb;
	_rlName = _specialb getVariable "name";
	
	_dub = _specialb getVariable "wfbe_town_dubbing";
	if (_dub != "Town") then {if (count(getArray(configFile >> (missionNamespace getVariable Format ["WFBE_%1_RadioAnnouncers_Config", _side]) >> "Words" >> _dub)) == 0) then {_dub = "Town"}};

	_speaker kbTell [_receiver, _topicSide, _special,["1","",_rlName,[_dub]],true];
};

//--- Radio: Voting for a new commander.
if (_special in ["VotingForNewCommander","NewIntelAvailable"]) then {_speaker kbTell [_receiver, _topicSide, _special,true]};

//--- Radio: Camp Capture/Loss.
if (_special in ["CapturedNear","LostAt"]) then {
	_locRaw = str _extra;
	_rlName = _extra getVariable "name";

	_dub = _extra getVariable "wfbe_town_dubbing";
	if (_dub != "Town") then {if (count(getArray(configFile >> (missionNamespace getVariable Format ["WFBE_%1_RadioAnnouncers_Config", _side]) >> "Words" >> _dub)) == 0) then {_dub = "Town"}};
	
	_speaker kbTell [_receiver, _topicSide, _special,["1","",_specialb,[_specialb]],["2","",_rlName,[_dub]],true];
};

if (paramSecondaryMissions) then {
	//--- Radio: Mission.
	if (_special in ['MMissionFailed','NewMissionAvailable']) then {
		_speaker kbTell [_receiver, _topicSide, _special,true];
	};
	
	//--- Radio: Mission Complete.
	if (_special == 'MMissionComplete') then {
		_speaker kbTell [_receiver, _topicSide, _special,["1","",_specialb,[_extra]],true];
	};
	
	//--- Radio: Extraction Team.
	if (_special in ['ExtractionTeam','ExtractionTeamCancel']) then {
		_speaker kbTell [_receiver, _topicSide, _special,["1","",_specialb,[_specialb]],true];
	};	
};