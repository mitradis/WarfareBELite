Private ['_HQRadio','_base','_buildings','_condition','_get','_idbl','_isDeployed','_oc','_voteTime','_weat'];

sideJoined = side player;
sideJoinedText = str sideJoined;
//--- WF3 Compatible.
WFBE_Client_SideJoined = sideJoined;
WFBE_Client_SideJoinedText = sideJoinedText;
WFBE_Client_IsLeader = true;
WFBE_Allow_HostileGearSaving = true;

ARTY_HandleILLUM = Compile preprocessFile "Client\Module\Arty\ARTY_HandleILLUM.sqf"; 
ARTY_HandleSADARM = Compile preprocessFile "Client\Module\Arty\ARTY_HandleSADARM.sqf"; 
if (paramArty) then {
	ARTY_Prep = Compile preprocessFile "Client\Module\Arty\ARTY_mobileMissionPrep.sqf";
	ARTY_Finish = Compile preprocessFile "Client\Module\Arty\ARTY_mobileMissionFinish.sqf";
	RequestFireMission = Compile preprocessFile "Client\Functions\Client_RequestFireMission.sqf"
};
if (paramBoundaries) then {
	BoundariesIsOnMap = Compile preprocessFile "Client\Functions\Client_IsOnMap.sqf";
	BoundariesHandleOnMap = Compile preprocessFile "Client\Functions\Client_HandleOnMap.sqf";
};
BuildUnit = Compile preprocessFile "Client\Functions\Client_BuildUnit.sqf";
ChangePlayerFunds = Compile preprocessFile "Client\Functions\Client_ChangePlayerFunds.sqf";
CommandChatMessage = Compile preprocessFile "Client\Functions\Client_CommandChatMessage.sqf";
DebugHint = Compile preprocessFile "Client\Functions\Client_DebugHint.sqf";
FX = Compile preprocessFile "Client\Functions\Client_FX.sqf";
GetAIID = Compile preprocessFileLineNumbers "Client\Functions\Client_GetAIID.sqf";
GetBackpackContent = if !(WF_A2_Vanilla) then {Compile preprocessFileLineNumbers "Client\Functions\Client_GetBackpackContent.sqf"} else {{[[],[]]}};
GetClosestAirport = Compile preprocessFileLineNumbers "Client\Functions\Client_GetClosestAirport.sqf";
GetClosestCamp = Compile preprocessFileLineNumbers "Client\Functions\Client_GetClosestCamp.sqf";
GetClosestDepot = Compile preprocessFileLineNumbers "Client\Functions\Client_GetClosestDepot.sqf";
GetGearCargoSize = Compile preprocessFileLineNumbers "Client\Functions\Client_GetGearCargoSize.sqf";
GetIncome = Compile preprocessFile "Client\Functions\Client_GetIncome.sqf";
GetMagazinesSize = Compile preprocessFileLineNumbers "Client\Functions\Client_GetMagazinesSize.sqf";
GetParsedGear = Compile preprocessFileLineNumbers "Client\Functions\Client_GetParsedGear.sqf";
GetPlayerFunds = Compile preprocessFile "Client\Functions\Client_GetPlayerFunds.sqf";
GetRespawnAvailable = Compile preprocessFile "Client\Functions\Client_GetRespawnAvailable.sqf";
GetStructureMarkerLabel = Compile preprocessFile "Client\Functions\Client_GetStructureMarkerLabel.sqf";
GetTime = Compile preprocessFile "Client\Functions\Client_GetTime.sqf";
GetUnitBackpack = if !(WF_A2_Vanilla) then {Compile preprocessFileLineNumbers "Client\Functions\Client_GetUnitBackpack.sqf"} else {{""}};
GetVehicleCargoSize = Compile preprocessFileLineNumbers "Client\Functions\Client_GetVehicleCargoSize.sqf";
GetVehicleContent = Compile preprocessFileLineNumbers "Client\Functions\Client_GetVehicleContent.sqf";
GroupChatMessage = Compile preprocessFile "Client\Functions\Client_GroupChatMessage.sqf";
HandleHQAction = Compile preprocessFile "Client\Functions\Client_HandleHQAction.sqf";
HandlePVF = Compile preprocessFile "Client\Functions\Client_HandlePVF.sqf";
MarkerAnim = Compile preprocessFile "Client\Functions\Client_MarkerAnim.sqf";
OnKilled = Compile preprocessFileLineNumbers "Client\Functions\Client_OnKilled.sqf";
OnRespawnHandler = Compile preprocessFile "Client\Functions\Client_OnRespawnHandler.sqf";
OperateCargoGear = Compile preprocessFileLineNumbers "Client\Functions\Client_OperateCargoGear.sqf";
PreRespawnHandler = Compile preprocessFile "Client\Functions\Client_PreRespawnHandler.sqf";
RemoveMagazineGear = Compile preprocessFileLineNumbers "Client\Functions\Client_RemoveMagazineGear.sqf";
ReplaceMagazinesGear = Compile preprocessFileLineNumbers "Client\Functions\Client_ReplaceMagazinesGear.sqf";
SetControlFadeAnim = Compile preprocessFile "Client\Functions\Client_SetControlFadeAnim.sqf";
SetControlFadeAnimStop = Compile preprocessFile "Client\Functions\Client_SetControlFadeAnimStop.sqf";
SupportHeal = Compile preprocessFile "Client\Functions\Client_SupportHeal.sqf";
SupportRearm = Compile preprocessFile "Client\Functions\Client_SupportRearm.sqf";
SupportRefuel = Compile preprocessFile "Client\Functions\Client_SupportRefuel.sqf";
SupportRepair = Compile preprocessFile "Client\Functions\Client_SupportRepair.sqf";
TaskSystem = Compile preprocessFile "Client\Functions\Client_TaskSystem.sqf";
TitleTextMessage = Compile preprocessFile "Client\Functions\Client_TitleTextMessage.sqf";
UIChangeComboBuyUnits = Compile preprocessFile "Client\Functions\Client_UIChangeComboBuyUnits.sqf";
UIFillListBuyUnits = Compile preprocessFile "Client\Functions\Client_UIFillListBuyUnits.sqf";
UIFillListTeamOrders = Compile preprocessFile "Client\Functions\Client_UIFillListTeamOrders.sqf";
UIFindLBValue = Compile preprocessFile "Client\Functions\Client_UIFindLBValue.sqf";
UI_Gear_AddTemplate = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_AddTemplate.sqf";
UI_Gear_DeleteTemplate = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_DeleteTemplate.sqf";
UI_Gear_DisplayInventory = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_DisplayInventory.sqf";
UI_Gear_FillCargoList = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_FillCargoList.sqf";
UI_Gear_FillList = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_FillList.sqf";
UI_Gear_FillTemplates = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_FillTemplates.sqf";
UI_Gear_ParseTemplateContent = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_ParseTemplateContent.sqf";
UI_Gear_Sanitize = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_Sanitize.sqf";
UI_Gear_UpdatePrice = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_UpdatePrice.sqf";
UI_Gear_UpdateTarget = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_UpdateTarget.sqf";
UI_Gear_UpdateView = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Gear_UpdateView.sqf";
UI_Respawn_Selector = Compile preprocessFileLineNumbers "Client\Functions\Client_UI_Respawn_Selector.sqf";
if (paramICBM) then {
	Nuke = Compile preprocessFile "Client\Module\Nuke\nuke.sqf";
	NukeIncomming = Compile preprocessFile "Client\Module\Nuke\nukeincoming.sqf";
};
//--- Namespace related (GUI).
BIS_FNC_GUIset = {UInamespace setVariable [_this select 0, _this select 1]};
BIS_FNC_GUIget = {UInamespace getVariable (_this select 0)};

clientInitComplete = true;

//--- UI Namespace release from previous possible games (only on titles dialog!).
{uiNamespace setVariable [_x, displayNull]} forEach ["wfbe_title_capture"];

//--- Waiting for the common part to be executed.
waitUntil {sleep 0.05;commonInitComplete};

//--- Queue Protection.
['WFBE_C_QUEUE_BARRACKS',0,true] Call SetNamespace;
['WFBE_C_QUEUE_BARRACKS_MAX',10,true] Call SetNamespace;
['WFBE_C_QUEUE_LIGHT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_LIGHT_MAX',3,true] Call SetNamespace;
['WFBE_C_QUEUE_HEAVY',0,true] Call SetNamespace;
['WFBE_C_QUEUE_HEAVY_MAX',3,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRCRAFT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRCRAFT_MAX',2,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRPORT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRPORT_MAX',2,true] Call SetNamespace;
['WFBE_C_QUEUE_DEPOT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_DEPOT_MAX',3,true] Call SetNamespace;

//--- Handle the Fast Time.
if (('WFBE_FASTTIMERATE' Call GetNamespace) > 0 && !isServer) then {
	[] Spawn {
		waitUntil{sleep 0.05;!isNil "WFBE_SERVERDATE"};
		[] ExecFSM "Client\FSM\env_fast_time_cli.fsm";
	};
};

//--- Handle the weather.
_weat = 'WFBE_WEATHER' Call GetNamespace;
if (_weat == 3) then {
	[] ExecFSM "Client\FSM\overcast.fsm";
} else {
	_oc = 0.05;
	switch (_weat) do {
		case 0: {_oc = 0};
		case 1: {_oc = 0.5};
		case 2: {_oc = 1};
	};
	60 setOvercast _oc;
};
if (paramVolumClouds) then {[] Exec "CA\Modules\clouds\data\scripts\bis_cloudsystem.sqs"};

_idbl = [player] Call Compile preprocessFile "Client\Init\Init_Blacklist.sqf";
if (_idbl) exitWith {[] Spawn {Private["_txt"];_txt = "INFORMATION:\n\n You are currently blacklisted.";_txt Call DebugHint;sleep 5; disableUserInput true; sleep 60; disableUserInput false; failMission "END1"}};

//--- Global Client Variables.
sideID = sideJoined Call GetSideID;
clientID = player Call GetClientID;
clientIdentification = Format ["%1Slot%2",sideJoinedText,clientID];
clientTeam = group player;
clientTeams = (Format['WFBE_%1TEAMS',sideJoinedText] Call GetNamespace);
playerType = typeOf player;
playerDead = false;
paramBoundariesRunning = false;

WFBE_Client_SideID = sideID;
WFBE_Client_Color = switch (WFBE_Client_SideJoined) do { case west: {missionNamespace getVariable "WFBE_C_WEST_COLOR"}; case east: {missionNamespace getVariable "WFBE_C_EAST_COLOR"}; case resistance: {missionNamespace getVariable "WFBE_C_GUER_COLOR"}};
WFBE_Client_Team = clientTeam;
WFBE_Client_Teams = clientTeams;
WFBE_Client_Teams_Count = (count WFBE_Client_Teams)-1;

commanderTeam = objNull;
buildingMarker = 0;
markerID = 0;
gearCost = 0;
currentTG = 25;
lastBuilt = [];
unitQueu = 0;
fireMissionTime = -1000;
artyRange = 15;
artyPos = [0,0,0];
playerUAV = objNull;
comTask = objNull;
voted = false;
votePopUp = true;
manningDefense = true;
currentFX = 0;
lastParaCall = -1200;
lastSupplyCall = -1200;
canBuildWHQ = true;
WFBE_RespawnDefaultGear = false;
WFBE_ForceUpdate = false;

hqInRange = false;
barracksInRange = false;
gearInRange = false;
lightInRange = false;
heavyInRange = false;
aircraftInRange = false;
serviceInRange = false;
commandInRange = false;
depotInRange = false;
antiAirRadarInRange = false;
hangarInRange = false;

enableTeamSwitch false;

/* CIPHER Module - Sorting */
ExecVM "Common\Module\CIPHER\CIPHER_Sort.sqf";

//--- Disable Artillery Computer.
if ((('WFBE_ARTILLERYCOMPUTER' Call GetNamespace) != 2) && !WF_A2_Vanilla) then {Call Compile "enableEngineArtillery false;"};

/* Exec SQF|FSM Misc stuff. */
if (paramTrackPlayer) then {[] ExecFSM "Client\FSM\updateteamsmarkers.fsm"};
[] ExecFSM "Client\FSM\updateactions.fsm";
/* Don't pause the client initialization process. */
[] Spawn {	
	waitUntil {sleep 0.05;townInit};
	/* Handle the capture GUI */
	[] ExecFSM "Client\FSM\client_title_capture.fsm";
	/* Handle the map town markers */
	[] ExecFSM "Client\FSM\updatetownmarkers.fsm";
	waitUntil {sleep 0.05;!isNil Format["%1BaseStructures",sideJoinedText]};
	/* Handle the client actions */
	[] ExecFSM "Client\FSM\updateavailableactions.fsm";
};
[] Spawn {
	Private ["_commanderTeam"];
	waitUntil{sleep 0.1;!isNil {(sideJoined) Call GetCommanderTeam}};
	/* Commander Handling */
	[] ExecFSM "Client\FSM\updateclient.fsm";
};

//--- Add the briefing (notes).
[] Call Compile preprocessFile "briefing.sqf";

//--- HQ Radio system.
waitUntil {sleep 0.05;!isNil Format ["BIS_WF_HQ%1",sideJoinedText]};
_HQRadio = Call Compile Format ["BIS_WF_HQ%1",sideJoinedText];
waitUntil {sleep 0.05;!isNil Format ["BIS_WF_HQ%1_TI",sideJoinedText]};
WFBE_V_HQTopicSide = Call Compile Format ["BIS_WF_HQ%1_TI",sideJoinedText];
_HQRadio setIdentity WFBE_V_HQTopicSide;
_HQRadio setRank "COLONEL";
_HQRadio setGroupId ["HQ"]; 
_HQRadio kbAddTopic [WFBE_V_HQTopicSide,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
player kbAddTopic [WFBE_V_HQTopicSide,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
sideHQ = _HQRadio;

/* Wait for a valid signal (Teamswaping) with failover */
if (isMultiplayer && paramKickTeamswappers && time > 7) then {
	Private ["_get","_timelaps"];
	_get = true;

	sleep (random 0.1);
	
	// WFBE_RequestJoin = ['SRVFNCREQUESTJOIN',[getPlayerUID(player),sideJoined,name player,vehicleVarName player]];
	// publicVariable 'WFBE_RequestJoin';
	["RequestJoin", [getPlayerUID(player),sideJoined,name player,vehicleVarName player]] Call SendToServer;
	
	_timelaps = 0;
	while {true} do {
		sleep 0.1;
		_get = 'WFBE_P_CANJOIN' Call GetNamespace;
		if !(isNil '_get') exitWith {};
		
		_timelaps = _timelaps + 0.1;
		if (_timelaps > 5) then {
			_timelaps = 0;
			// WFBE_RequestJoin = ['SRVFNCREQUESTJOIN',[getPlayerUID(player),sideJoined,name player,vehicleVarName player]];
			// publicVariable 'WFBE_RequestJoin';
			["RequestJoin", [getPlayerUID(player),sideJoined,name player,vehicleVarName player]] Call SendToServer;
		};
	};
	
	if !(_get) exitWith {
		(localize 'STR_WF_CHAT_Teamswap_Warnning') Call CommandChatMessage;
		sleep 3;
		failMission "END1";
	};
};

/* Get the client starting location */
_base = objNull;
if (time < 30) then {
	waitUntil {sleep 0.05;!isNil Format ["%1StartingLocation",sideJoinedText]};
	_base = Call Compile Format ["%1StartingLocation",sideJoinedText];
} else {
	waitUntil {sleep 0.05;!isNil Format ["%1MHQ",sideJoinedText]};
	waitUntil {sleep 0.05;!isNil Format ["%1BaseStructures",sideJoinedText]};
	_base = (sideJoinedText) Call GetSideHQ;
	_buildings = (sideJoinedText) Call GetSideStructures;
	
	if (count _buildings > 0) then {_base = _buildings select 0};
};

/* Position the client at the previously defined location */
player setPos ([getPos _base,30,20] Call GetRandomPosition);

/* HQ Building Init. */
waitUntil {sleep 0.05;!isNil Format ["%1MHQDeployed",sideJoinedText]};
_isDeployed = (sideJoinedText) Call GetSideHQDeployed;
if (_isDeployed) then {
	['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
} else {
	['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
};

/* Options menu. */
Options = player addAction ["<t color='#42b6ff'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", "_target == player"];

/* Zeta Cargo Lifter. */
[] Call Compile preprocessFile "Client\Module\ZetaCargo\Zeta_Init.sqf";
/* Set Groups ID. */
[] Call Compile preprocessFile "Client\Functions\Client_SetGroupsID.sqf";

sleep 1;

//--- Play a tune.
_music = switch (true) do {
	case WF_A2_Vanilla: {["Track11_Large_Scale_Assault","Track02_Insertion","Ambient07_Manhattan","Track10_Logistics","Track09_Movement_To_Contact","Track16_Valentine"]};
	case WF_A2_Arrowhead: {["EP1_Track10","EP1_Track12","EP1_Track14","EP1_Track15"]};
	default {[]};
};

if (count _music > 0) then {playMusic (_music select floor(random(count _music)))};

/* Override player's Gear.*/
// [player,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
_default = missionNamespace getVariable Format["WFBE_%1_DefaultGear", WFBE_Client_SideJoinedText];
if (count _default <= 3) then {
	[player, _default select 0, _default select 1, _default select 2] Call EquipUnit;
} else {
	[player, _default select 0, _default select 1, _default select 2, _default select 3, _default select 4] Call EquipUnit;
};

/* Default gear menu filler. */
WF_Logic setVariable ['filler','primary'];

/* Skill Module. */
[] Call Compile preprocessFile "Client\Module\Skill\Skill_Init.sqf";
(player) Call WFBE_SK_FNC_Apply;

/* Vote System, define whether a vote is already running or not */
_voteTime = 0;
waitUntil {sleep 0.05;_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];!(isNil '_voteTime')};
if (_voteTime > 0) then {createDialog "RscMenu_Voting"};

/* Artillery UI */
if (paramArtyUI) then {[] ExecVM "ca\modules\ARTY\data\scripts\init.sqf"};

/* Key Binding */
[] Call Compile preprocessFile "Client\Init\Init_Keybind.sqf";

/* JIP Handler */
waitUntil {sleep 0.05;townInit};

/* Conquest helper */
if (('WFBE_TOWNCONQUESTMODE' Call GetNamespace) > 0) then {[] ExecFSM "Client\FSM\conquest_helper.fsm"};

sleep 3;
/* JIP System, initialize the camps and towns properly. */
[] Spawn {
	sleep 2;
	[] Call Compile preprocessFileLineNumbers "Client\Init\Init_Markers.sqf";
};

/* Repair Truck CoIn Handling. */
['WFBE_AREAREPAIRTRUCK' Call GetNamespace,false,RCoin,"REPAIR"] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";

/* A new player come to reinforce the battlefield */
[sideJoinedText,'UnitsCreated',1] Call UpdateStatistics;

/* Towns Task System */
["TownAddComplete"] Spawn TaskSystem;

/* End Init */
finishMissionInit;

/* Client death handler. */
WFBE_PLAYERKEH = player addEventHandler ['Killed',format ["[_this select 0,_this select 1] Spawn OnKilled;[_this select 0,_this select 1,%1,false] Spawn UnitKilled",sideID]];

/* Client Init Done - Remove the blackout */
12452 cutText [(localize 'STR_WF_Loading')+"...","BLACK IN",2];
