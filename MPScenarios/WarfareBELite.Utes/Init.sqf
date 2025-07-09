//--- Global Init, first file called.

//--- Client Init.
if (!isServer || local player) then {
	waitUntil {!isNull(player)};
	/* Client Init - Begin the blackout on Layer 1 */
	12452 cutText [(localize 'STR_WF_Loading')+"...","BLACK FADED",50000];
	isHostedServer = if (!isMultiplayer || (isServer && local player)) then {true} else {false};
	isClient = true;
} else {
	if (isNil 'EastMHQ' || isNil 'WestMHQ') exitWith {};
	isHostedServer = if (!isMultiplayer || (isServer && local player)) then {true} else {false};
	isClient = false;
};

//--- Server & Client default View Distance.
setViewDistance 1600;

clientInitComplete = false;
commonInitComplete = false;
serverInitComplete = false;
gameOver = false;
WFBE_GameOver = false;
townInitServer = false;
townInit = false;
towns = [];

//--- Define which 'part' of the game to run.
#include "version.sqf"

WF_A2_Vanilla = false;
#ifdef VANILLA
	WF_A2_Vanilla = true;
#endif

WF_A2_Arrowhead = false;
#ifdef ARROWHEAD
	WF_A2_Arrowhead = true;
#endif

WF_Camo = false;
#ifdef WF_CAMO
	WF_Camo = true;
#endif

//--- Gameplay variables.
paramMobileGear = true;
paramMobileRespawn = true;
paramAI = true;
paramAIcom = true;
paramShowUID = true;
paramArty = true;
paramArtyUI = false;
paramTrackAI = true;
paramTrackPlayer = true;
paramOccup = true;
paramHangars = true;
paramAARadar = false;
paramVolumClouds = true;
paramICBM = false;
paramHighCommand = true;
paramBaseArea = true;
paramSpawnRestriction = true;
paramUpgradesEast = true;
paramUpgradesWest = true;
paramKickTeamswappers = true;
paramRespawnMASH = true;
paramPurchaseInfDepot = true;
paramHandleFF = false;
paramBoundaries = false;
paramBasePatrols = false;
paramAlice = false;
paramDLCBAF = true;
paramDLCPMC = true;
paramBounty = true;
paramVehLock = false;
paramSecondaryMissions = true;
paramUPSMON = false;
paramDefenseCollide = true;
paramKeepCamps = true;
paramUseWorkers = false;
paramMoneyOnly = false;

//--- Multiplayers Parameter, the order it the same as Parameters.hpp
if !(isNil "paramsArray") then {
	Private['_u'];
	_u = 0;
	missionNamespace setVariable ['WFBE_MAXGROUPSIZEAI',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_MAXGROUPSIZE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramKeepAI = false} else {paramKeepAI = true};_u = _u + 1; //--- Keep AI Units over JIP.
	if ((paramsArray select _u) == 0) then {paramAI = false} else {paramAI = true};_u = _u + 1; //--- AI Enabled.
	if ((paramsArray select _u) == 0) then {paramArty = false} else {paramArty = true};_u = _u + 1; //--- Enable Artillery.
	if !(WF_A2_Vanilla) then {missionNamespace setVariable ['WFBE_ARTILLERYCOMPUTER',(paramsArray select _u)];_u = _u + 1};
	if ((paramsArray select _u) == 0) then {paramArtyUI = false} else {paramArtyUI = true};_u = _u + 1; //--- Enable Artillery Interface (Artillery Module).
	missionNamespace setVariable ['WFBE_ARTILLERYMAXRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramAIcom = false} else {paramAIcom = true};_u = _u + 1; //--- AI Commander Enabled.
	if !(WF_A2_Arrowhead) then {missionNamespace setVariable ['WFBE_ALLIES',(paramsArray select _u)];_u = _u + 1};
	if ((paramsArray select _u) == 0) then {paramAARadar = false} else {paramAARadar = true};_u = _u + 1; //--- Anti Air Radar.
	if ((paramsArray select _u) == 0) then {paramBaseArea = false} else {paramBaseArea = true};_u = _u + 1; //--- Base Area.
	missionNamespace setVariable ['WFBE_BASEAREAMAX',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_AIDEFENSE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_DEFENSEMANRANGE',(paramsArray select _u)];_u = _u + 1;
	//--- Building Limits.
	missionNamespace setVariable ['WFBE_BUILDINGMAXBARRACKS',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXLIGHT',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXCOMMANDCENTER',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXHEAVY',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXAIRCRAFT',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXSERVICEPOINT',(paramsArray select _u)*2];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramUseWorkers = false} else {paramUseWorkers = true};_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramDefenseCollide = false} else {paramDefenseCollide = true};_u = _u + 1;
	missionNamespace setVariable ['WFBE_HQDEPLOYPRICE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_HQDEPLOYRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramBasePatrols = false} else {paramBasePatrols = true};_u = _u + 1; //--- Base patrols.
	if ((paramsArray select _u) == 0) then {paramSpawnRestriction = false} else {paramSpawnRestriction = true};_u = _u + 1; //--- Restrict the Spawn logic to 2km within a town.
	missionNamespace setVariable ['WFBE_SIDESTARTINGDISTANCE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_STARTINGLOCATIONMODE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramMoneyOnly = false} else {paramMoneyOnly = true};_u = _u + 1;
	missionNamespace setVariable ['WFBE_INCOMEINTERVAL',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_INCOMESYSTEM',(paramsArray select _u)];_u = _u + 1;
	//--- Funds.
	missionNamespace setVariable ['WFBE_EASTSTARTINGMONEY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_WESTSTARTINGMONEY',(paramsArray select _u)];_u = _u + 1;
	//--- Supply.
	EastSupplies = (paramsArray select _u);_u = _u + 1;
	WestSupplies = (paramsArray select _u);_u = _u + 1;
	missionNamespace setVariable ['WFBE_SUPPLYSYSTEM',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_FASTTIMERATE', paramsArray select _u];_u = _u + 1;
	if (time < 2) then {setDate [(date select 0),(date select 1),(date select 2),(paramsArray select _u),(date select 3)]};_u = _u + 1; //--- Time of Day.
	missionNamespace setVariable ['WFBE_WEATHER',(paramsArray select _u)];_u = _u + 1;
	if !(WF_A2_Vanilla) then {if ((paramsArray select _u) == 0) then {paramDLCBAF = false} else {paramDLCBAF = true};_u = _u + 1};
	if !(WF_A2_Vanilla) then {if ((paramsArray select _u) == 0) then {paramDLCPMC = false} else {paramDLCPMC = true};_u = _u + 1};
	if ((paramsArray select _u) == 0) then {paramAlice = false} else {paramAlice = true};_u = _u + 1; //--- Ambient Civilians.
	if ((paramsArray select _u) == 0) then {paramHangars = false} else {paramHangars = true};_u = _u + 1; //--- Airport Hangars.
	missionNamespace setVariable ['WFBE_UNITREMOVEDLAY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_ABANDONVEHICLETIMER', paramsArray select _u];_u = _u + 1;
	missionNamespace setVariable ['WFBE_FASTTRAVEL',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramHandleFF = false} else {paramHandleFF = true};_u = _u + 1; //--- Base Friendly Fire.
	missionNamespace setVariable ['WFBE_MAXCLUTTERDISTANCE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramKickTeamswappers = false} else {paramKickTeamswappers = true};_u = _u + 1; //--- Kick teamswappers.
	if ((paramsArray select _u) == 0) then {paramBoundaries = false} else {paramBoundaries = true};_u = _u + 1; //--- Prevent players from going outside of the map, they're killed after x seconds.
	missionNamespace setVariable ['WFBE_INCOMINGMISSILEMAXRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramSecondaryMissions = false} else {paramSecondaryMissions = true};_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramShowUID = false} else {paramShowUID = true};_u = _u + 1; //--- Show User ID.
	missionNamespace setVariable ['WFBE_BALANCEPRICE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_THERMALIMAGING',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramVehLock = false} else {paramVehLock = true};_u = _u + 1; //--- Buy Vehicles Lock.
	if ((paramsArray select _u) == 0) then {paramTrackAI = false} else {paramTrackAI = true};_u = _u + 1; //--- Track AI (Yellow dots) on map.
	if ((paramsArray select _u) == 0) then {paramTrackPlayer = false} else {paramTrackPlayer = true};_u = _u + 1; //--- Track players.
	if ((paramsArray select _u) == 0) then {paramBounty = false} else {paramBounty = true};_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramUpgradesEast = false} else {paramUpgradesEast = true};_u = _u + 1; //--- Upgrades.
	if ((paramsArray select _u) == 0) then {paramUpgradesWest = false} else {paramUpgradesWest = true};_u = _u + 1; //--- Upgrades.
	missionNamespace setVariable ['WFBE_VICTORYCONDITION',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_MAXVIEWDISTANCE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramHighCommand = false} else {paramHighCommand = true};_u = _u + 1; //--- High Command.
	if ((paramsArray select _u) == 0) then {paramICBM = false} else {paramICBM = true};_u = _u + 1; //--- ICBM.
	if ((paramsArray select _u) == 0) then {paramUPSMON = false} else {paramUPSMON = true};_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramVolumClouds = false} else {paramVolumClouds = true};_u = _u + 1; //--- Volumetric Clouds.
	missionNamespace setVariable ['WFBE_RESPAWNCAMPSMODE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_RESPAWNCAMPSRULEMODE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_RESPAWNDELAY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramRespawnMASH = false} else {paramRespawnMASH = true};_u = _u + 1; //--- MASH respawn's enabled.
	if ((paramsArray select _u) == 0) then {paramMobileRespawn = false} else {paramMobileRespawn = true};_u = _u + 1; //--- Mobile respawn's enabled.
	if ((paramsArray select _u) == 0) then {paramMobileGear = false} else {paramMobileGear = true};_u = _u + 1; //--- Mobile respawn gear.
	missionNamespace setVariable ['WFBE_RESPAWNPENALTY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_RESPAWNRANGE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_RESTRICTIONADVAIR',(paramsArray select _u)];_u = _u + 1;
	_u = _u + 1; //--- Town Amount System, leave blank.
	if ((paramsArray select _u) == 0) then {paramKeepCamps = false} else {paramKeepCamps = true};_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNCAPTUREMODE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNCONQUESTMODE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNGEAR',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramOccup = false} else {paramOccup = true};_u = _u + 1; //--- Town Occupation.
	missionNamespace setVariable ['WFBE_TOWNOCCUPATIONDIFFICULTY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_OCCUPATIONEASTFACTION',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_OCCUPATIONWESTFACTION',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_PATROLS',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNBUILDPROTECTIONRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramPurchaseInfDepot = false} else {paramPurchaseInfDepot = true};_u = _u + 1; //--- Town Milita Purchase.
	missionNamespace setVariable ['WFBE_RESISTANCEFACTION',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNSTARTINGMODE',(paramsArray select _u)];_u = _u + 1;
};

//--- All parameters are set and ready.
initJIP = true;

//---- Server store the groups once in for all.
if (isServer) then {
	//--- BUG workaround: "attempt" to ensure that the client is really a client and not a server
	if !(isNil "WFBE_EASTTEAMS") exitWith {};
	WFBE_EASTTEAMS = [Group EastSlot1,Group EastSlot2,Group EastSlot3,Group EastSlot4,Group EastSlot5,Group EastSlot6,Group EastSlot7,Group EastSlot8];
	WFBE_WESTTEAMS = [Group WestSlot1,Group WestSlot2,Group WestSlot3,Group WestSlot4,Group WestSlot5,Group WestSlot6,Group WestSlot7,Group WestSlot8];
	
	for '_i' from 0 to count(WFBE_EASTTEAMS)-1 do {
		if (isNil {WFBE_WESTTEAMS select _i}) then {WFBE_WESTTEAMS set [_i, grpNull]};
		if (isNil {WFBE_EASTTEAMS select _i}) then {WFBE_EASTTEAMS set [_i, grpNull]};
	};
	
	publicVariable "WFBE_EASTTEAMS";
	publicVariable "WFBE_WESTTEAMS";
};

/* Root classes */
westSoldierBaseClass = 'SoldierWB';
eastSoldierBaseClass = 'SoldierEB';
resistanceSoldierBaseClass = 'SoldierGB';

//--- Cli Exec - Wait for sync.
// if (!isServer) then {
	waitUntil{!isNil 'WFBE_EASTTEAMS' && !isNil 'WFBE_WESTTEAMS'};
// };

missionNamespace setVariable ['WFBE_EASTTEAMS', WFBE_EASTTEAMS];
missionNamespace setVariable ['WFBE_WESTTEAMS', WFBE_WESTTEAMS];

//--- Slot names.
{
	Private ["_temp"];
	_temp = [];
	{_temp = _temp + [if !(isNull _x) then {vehicleVarName (leader _x)} else {""}]} forEach (_x select 0);
	missionNamespace setVariable [_x select 1, _temp];
} forEach [[WFBE_EASTTEAMS,"WFBE_EASTSLOTNAMES"],[WFBE_WESTTEAMS,"WFBE_WESTSLOTNAMES"]];

//--- Maximum players, try to keep the same amount of player on east & west.
maxPlayers = count (missionNamespace getVariable 'WFBE_EASTTEAMS');

//--- Execute the common files.
ExecVM "Common\Init\Init_Common.sqf";
//--- Execute the towns file.
ExecVM "Common\Init\Init_Towns.sqf";

//--- Run the client's part.
if (isClient) then {
	ExecVM "Client\Init\Init_Client.sqf";
};

//--- Run the server's part.
if (isServer) then {
	if (isNil 'EastMHQ' || isNil 'WestMHQ') exitWith {};
	
	ExecVM "Server\Init\Init_Server.sqf";
};

//--- Fast Get/Set.
_i = 1;
{if !(isNil '_x') then {_x setVariable ["identification", Format["EastSlot%1",_i]]};_i = _i + 1} forEach (missionNamespace getVariable 'WFBE_EASTTEAMS');
_i = 1;
{if !(isNil '_x') then {_x setVariable ["identification", Format["WestSlot%1",_i]]};_i = _i + 1} forEach (missionNamespace getVariable 'WFBE_WESTTEAMS');