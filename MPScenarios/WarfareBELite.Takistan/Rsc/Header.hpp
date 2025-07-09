/* Header */

//--- Respawn options.
respawn = 3;
respawnDelay = WF_RESPAWNDELAY;
respawnDialog = false;

//--- Require briefing.html to show up.
onLoadMission = WF_MISSIONNAME;
onLoadMissionTime = false;

//--- Loadscreen.
loadScreen = "ca\ui\data\loadscreen_generic_co.paa";

#ifndef VANILLA
	//--- Prevent gear from being dropped in water, not vanilla compatible.
	enableItemsDropping = 0;
#endif

//--- Properties.
class Header {
	gameType = CTI;
	minPlayers = 1;
	maxPlayers = WF_MAXPLAYERS;
};