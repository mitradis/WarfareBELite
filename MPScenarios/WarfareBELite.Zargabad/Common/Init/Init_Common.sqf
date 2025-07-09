//todo if not res playable then disable res processinit createveh & createman

Private ['_count'];

ArrayPush = Compile preprocessFileLineNumbers "Common\Functions\Common_ArrayPush.sqf";
ArrayRemoveIndex = Compile preprocessFileLineNumbers "Common\Functions\Common_ArrayRemoveIndex.sqf";
ArrayShift = Compile preprocessFileLineNumbers "Common\Functions\Common_ArrayShift.sqf";
ArrayShuffle = Compile preprocessFileLineNumbers "Common\Functions\Common_ArrayShuffle.sqf";
BuildingInRange = Compile preprocessFileLineNumbers "Common\Functions\Common_BuildingInRange.sqf";
ChangeSideSupply = Compile preprocessFileLineNumbers "Common\Functions\Common_ChangeSideSupply.sqf";
ChangeTeamFunds = Compile preprocessFileLineNumbers "Common\Functions\Common_ChangeTeamFunds.sqf";
CreateMan = Compile preprocessFileLineNumbers "Common\Functions\Common_CreateUnit.sqf";
CreateVehi = Compile preprocessFileLineNumbers "Common\Functions\Common_CreateVehicle.sqf";
EquipArtillery = Compile preprocessFileLineNumbers "Common\Functions\Common_EquipArtillery.sqf";
EquipBackpack = if !(WF_A2_Vanilla) then {Compile preprocessFileLineNumbers "Common\Functions\Common_EquipBackpack.sqf"} else {{}};
EquipLoadout = Compile preprocessFileLineNumbers "Common\Functions\Common_EquipLoadout.sqf";
EquipUnit = Compile preprocessFileLineNumbers "Common\Functions\Common_EquipUnit.sqf";
EquipVehicle = Compile preprocessFileLineNumbers "Common\Functions\Common_EquipVehicle.sqf";
FireArtillery = Compile preprocessFileLineNumbers "Common\Functions\Common_FireArtillery.sqf";
GetAIDigit = Compile preprocessFileLineNumbers "Common\Functions\Common_GetAIDigit.sqf";
GetAreaEnemies = Compile preprocessFileLineNumbers "Common\Functions\Common_GetAreaEnemies.sqf";
GetClientID = Compile preprocessFileLineNumbers "Common\Functions\Common_GetClientID.sqf";
GetClosestEntity = Compile preprocessFileLineNumbers "Common\Functions\Common_GetClosestEntity.sqf";
GetClosestLocation = Compile preprocessFileLineNumbers "Common\Functions\Common_GetClosestLocation.sqf";
GetClosestLocationBySide = Compile preprocessFileLineNumbers "Common\Functions\Common_GetClosestLocationBySide.sqf";
GetCommanderFromVotes = Compile preprocessFileLineNumbers "Common\Functions\Common_GetCommanderFromVotes.sqf";
GetCommanderTeam = Compile preprocessFileLineNumbers "Common\Functions\Common_GetCommanderTeam.sqf";
GetCommanderVotes = Compile preprocessFileLineNumbers "Common\Functions\Common_GetCommanderVotes.sqf";
GetConfigEntry = Compile preprocessFileLineNumbers "Common\Functions\Common_GetConfigEntry.sqf";
GetConfigInfo = Compile preprocessFileLineNumbers "Common\Functions\Common_GetConfigInfo.sqf";
GetFactories = Compile preprocessFileLineNumbers "Common\Functions\Common_GetFactories.sqf";
GetFriendlyCamps = Compile preprocessFileLineNumbers "Common\Functions\Common_GetFriendlyCamps.sqf";
GetHostilesInArea = Compile preprocessFileLineNumbers "Common\Functions\Common_GetHostilesInArea.sqf";
GetLiveUnits = Compile preprocessFileLineNumbers "Common\Functions\Common_GetLiveUnits.sqf";
GetNamespace = Compile preprocessFileLineNumbers "Common\Functions\Common_GetNamespace.sqf";
GetPositionFrom = Compile preprocessFileLineNumbers "Common\Functions\Common_GetPositionFrom.sqf";
GetRandomPosition = Compile preprocessFileLineNumbers "Common\Functions\Common_GetRandomPosition.sqf";
GetRespawnCamps = Compile preprocessFileLineNumbers "Common\Functions\Common_GetRespawnCamps.sqf";
GetSideFromID = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideFromID.sqf";
GetSideHQ = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideHQ.sqf";
GetSideHQDeployed = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideHQDeployed.sqf";
GetSideID = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideID.sqf";
GetSideStructures = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideStructures.sqf";
GetSideSupply = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideSupply.sqf";
GetSideTowns = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideTowns.sqf";
GetSideUpgrades = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSideUpgrades.sqf";
GetSleepFPS = Compile preprocessFileLineNumbers "Common\Functions\Common_GetSleepFPS.sqf";
GetTeamArtillery = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamArtillery.sqf";
GetTeamAutonomous = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamAutonomous.sqf";
GetTeamFunds = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamFunds.sqf";
GetTeamMoveMode = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamMoveMode.sqf";
GetTeamMovePos = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamMovePos.sqf";
GetTeamRespawn = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamRespawn.sqf";
GetTeamType = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamType.sqf";
GetTeamVehicles = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTeamVehicles.sqf";
GetTotalCamps = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTotalCamps.sqf";
GetTotalCampsOnSide = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTotalCampsOnSide.sqf";
GetTownsIncome = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTownsIncome.sqf";
GetTurretsMags = Compile preprocessFileLineNumbers "Common\Functions\Common_GetTurretsMags.sqf";
GetUnitConfigGear = Compile preprocessFileLineNumbers "Common\Functions\Common_GetUnitConfigGear.sqf";
GetUnitVehicle = Compile preprocessFileLineNumbers "Common\Functions\Common_GetUnitVehicle.sqf";
GetVehicleMags = Compile preprocessFileLineNumbers "Common\Functions\Common_GetVehicleMags.sqf";
HandleArtillery = Compile preprocessFileLineNumbers "Common\Functions\Common_HandleArtillery.sqf";
HandleIncomingMissile = Compile preprocessFileLineNumbers "Common\Functions\Common_HandleIncomingMissile.sqf";
IsArtillery = Compile preprocessFileLineNumbers "Common\Functions\Common_IsArtillery.sqf";
MarkerUpdate = Compile preprocessFileLineNumbers "Common\Common_MarkerUpdate.sqf";
PlaceNear = Compile preprocessFileLineNumbers "Common\Functions\Common_PlaceNear.sqf";
PlaceSafe = Compile preprocessFileLineNumbers "Common\Functions\Common_PlaceSafe.sqf";
RearmVehicle = Compile preprocessFileLineNumbers "Common\Functions\Common_RearmVehicle.sqf";
RevealArea = Compile preprocessFileLineNumbers "Common\Functions\Common_RevealArea.sqf";
SendToClients = Compile preprocessFileLineNumbers "Common\Functions\Common_SendToClients.sqf";
SendToServer = Compile preprocessFileLineNumbers "Common\Functions\Common_SendToServer.sqf";
SetCommanderVotes = Compile preprocessFileLineNumbers "Common\Functions\Common_SetCommanderVotes.sqf";
SetNamespace = Compile preprocessFileLineNumbers "Common\Functions\Common_SetNamespace.sqf";
SetTeamAutonomous = Compile preprocessFileLineNumbers "Common\Functions\Common_SetTeamAutonomous.sqf";
SetTeamMoveMode = Compile preprocessFileLineNumbers "Common\Functions\Common_SetTeamMoveMode.sqf";
SetTeamMovePos = Compile preprocessFileLineNumbers "Common\Functions\Common_SetTeamMovePos.sqf";
SetTeamRespawn = Compile preprocessFileLineNumbers "Common\Functions\Common_SetTeamRespawn.sqf";
SetTeamType = Compile preprocessFileLineNumbers "Common\Functions\Common_SetTeamType.sqf";
SetTurretsMags = Compile preprocessFileLineNumbers "Common\Functions\Common_SetTurretsMags.sqf";
SortByDistance = Compile preprocessFileLineNumbers "Common\Functions\Common_SortByDistance.sqf";
SpawnTurrets = Compile preprocessFileLineNumbers "Common\Functions\Common_SpawnTurrets.sqf";
UnitKilled = Compile preprocessFileLineNumbers "Common\Functions\Common_UnitKilled.sqf";
UpdateStatistics = Compile preprocessFileLineNumbers "Common\Functions\Common_UpdateStatistics.sqf";
UseStationaryDefense = Compile preprocessFileLineNumbers "Common\Functions\Common_UseStationaryDefense.sqf";
if (paramICBM) then {
	NukeDammage = Compile preprocessFileLineNumbers "Client\Module\Nuke\damage.sqf";
	NukeRadiation = Compile preprocessFileLineNumbers "Client\Module\Nuke\radzone.sqf";
};

//todo counter attack system. (help from neighbourgs towns if friendly).

varQueu = random(10)+random(100)+random(1000);

EastCommanderTeam = ObjNull;
WestCommanderTeam = ObjNull;

/* Starting Supply */
if (isNil "EastSupplies") then {EastSupplies = 4800};
if (isNil "WestSupplies") then {WestSupplies = 4800};

/* Starting Money */
['WFBE_EASTSTARTINGMONEY',2400,false] Call SetNamespace;
['WFBE_WESTSTARTINGMONEY',2400,false] Call SetNamespace;

unitMarker = 0;

for [{_count = 0},{_count < maxPlayers},{_count = _count + 1}] do {
	Call Compile Format["if (IsNil 'EastTeam%1Vote') then {EastTeam%1Vote = -1}",_count + 1];
	Call Compile Format["if (IsNil 'WestTeam%1Vote') then {WestTeam%1Vote = -1}",_count + 1];
};

/* Respawn Markers */
createMarkerLocal ["respawn_east",getMarkerPos "EastTempRespawnMarker"];
"respawn_east" setMarkerColorLocal "ColorGreen";
"respawn_east" setMarkerShapeLocal "RECTANGLE";
"respawn_east" setMarkerBrushLocal "BORDER";
"respawn_east" setMarkerSizeLocal [15,15];
"respawn_east" setMarkerAlphaLocal 0;
createMarkerLocal ["respawn_west",getMarkerPos "WestTempRespawnMarker"];
"respawn_west" setMarkerColorLocal "ColorGreen";
"respawn_west" setMarkerShapeLocal "RECTANGLE";
"respawn_west" setMarkerBrushLocal "BORDER";
"respawn_west" setMarkerSizeLocal [15,15];
"respawn_west" setMarkerAlphaLocal 0;

//--- Types.
WFBE_Logic_Airfield = "LocationLogicAirport";
WFBE_Logic_Camp = "LocationLogicCamp";
WFBE_Logic_Depot = "LocationLogicDepot";

/* Prepare the common constants */
[] Call Compile preprocessFileLineNumbers "Common\Init\Init_CommonConstants.sqf";

/* Wait for BIS Module Init */
waitUntil {sleep 0.05;!(isNil 'BIS_fnc_init')};
waitUntil {sleep 0.05;BIS_fnc_init};

/* CORE SYSTEM - Start
	Different Core are added depending on the current ArmA Version running, add yours bellow.
*/
switch (true) do {
	case WF_A2_Vanilla: {
		/* Model Core */
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core_Models\Vanilla.sqf';
		
		/* Gear Core */
		if (local player) then {
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_RU.sqf";
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_GUE.sqf";
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_USMC.sqf";
		};
		/* Class Core */
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_CDF.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_CIV.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_FR.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_GUE.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_INS.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_MVD.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_RU.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_Spetsnaz.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_USMC.sqf';

		/* Call in the teams template - Vanilla */
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core_Definition\Vanilla\Definition_USMC_RU.sqf';
	};
	case WF_A2_Arrowhead: {
		/* Model Core */
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core_Models\Arrowhead.sqf';
	
		/* Gear Core */
		if (local player) then {
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_US.sqf";
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_TKA.sqf";
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_BAF.sqf";
			[] Call Compile preprocessFileLineNumbers "Common\Config\Gear\Gear_PMC.sqf";
		};
		/* Class Core */
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_ACR.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_BAF.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_BAFD.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_BAFW.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_DeltaForce.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_KSK.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_PMC.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_TKA.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_TKCIV.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_TKGUE.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_TKSF.sqf';
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core\Core_US.sqf';

		/* Call in the teams template - Arrowhead */
		[] Call Compile preprocessFileLineNumbers 'Common\Config\Core_Definition\Arrowhead\Definition_US_TKA.sqf';
	};
};

//--- new system.
_grpWest = ('WFBE_OCCUPATIONWESTFACTIONS' Call GetNamespace) select ('WFBE_OCCUPATIONWESTFACTION' Call GetNamespace);
_grpEast = ('WFBE_OCCUPATIONEASTFACTIONS' Call GetNamespace) select ('WFBE_OCCUPATIONEASTFACTION' Call GetNamespace);
_grpRes = ('WFBE_RESISTANCEFACTIONS' Call GetNamespace) select ('WFBE_RESISTANCEFACTION' Call GetNamespace);

/* CORE SYSTEM - End */

//--- Determine which logics are defined.
{
	Private ["_sideIsPresent"];
	_sideIsPresent = if !(isNil (_x select 1)) then {true} else {false};
	missionNamespace setVariable [Format["WFBE_%1_PRESENT", _x select 0], _sideIsPresent];
	if (_sideIsPresent) then {missionNamespace setVariable ['WFBE_%1_Logic', call compile (_x select 1)]};
} forEach [["WEST","WFBE_L_BLU"],["EAST","WFBE_L_OPF"],["GUER","WFBE_L_GUE"]];

//--- Todo, dynamic (if logic is present or not).
WFBE_DEFENDER = resistance;

//--- Import the desired global side variables.
[] Call Compile preprocessFileLineNumbers Format["Common\Config\Core_Root\Root_%1.sqf",_grpRes];
[] Call Compile preprocessFileLineNumbers Format["Common\Config\Core_Root\Root_%1.sqf", WFBE_V_West_SquadsFaction];
[] Call Compile preprocessFileLineNumbers Format["Common\Config\Core_Root\Root_%1.sqf", WFBE_V_East_SquadsFaction];

//--- Common Exec.
[] Call Compile preprocessFileLineNumbers "Common\Init\Init_PublicVariables.sqf";
// [] Call Compile preprocessFileLineNumbers "Common\Config\Config_Special.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Artillery.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Barracks.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_LightFactory.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_HeavyFactory.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_AircraftFactory.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Airport.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Depot.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Structures.sqf";
[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Squads.sqf";
// [] Call Compile preprocessFileLineNumbers "Common\Config\Config_Loadouts.sqf";

//--- Import the desired defenses. (todo, Replace the old defense init by this one).
[] Call Compile preprocessFileLineNumbers Format["Common\Config\Defenses\Defenses_%1.sqf",_grpWest];
[] Call Compile preprocessFileLineNumbers Format["Common\Config\Defenses\Defenses_%1.sqf",_grpEast];
[] Call Compile preprocessFileLineNumbers Format["Common\Config\Defenses\Defenses_%1.sqf",_grpRes];

//--- Server Exec.
if (isServer) then {
	//--- Import the desired town groups.
	[] Call Compile preprocessFileLineNumbers Format["Common\Config\Groups\Groups_%1.sqf",_grpWest];
	[] Call Compile preprocessFileLineNumbers Format["Common\Config\Groups\Groups_%1.sqf",_grpEast];
	[] Call Compile preprocessFileLineNumbers Format["Common\Config\Groups\Groups_%1.sqf",_grpRes];
	
	//--- Allies.
	if (('WFBE_ALLIES' Call GetNamespace) > 0) then {[] Call Compile preprocessFileLineNumbers "Common\Config\Config_Allies.sqf"};
};

//--- Airports Init.
ExecVM "Common\Init\Init_Airports.sqf";

//--- Boundaries, use setPos to find the perfect spot on other islands and worldName to determine the island name.
[] Call Compile preprocessFileLineNumbers "Common\Init\Init_Boundaries.sqf";

//--- Neighbors
if (('WFBE_TOWNCONQUESTMODE' Call GetNamespace) > 0) then {[] Call Compile preprocessFileLineNumbers "Common\Init\Init_Neighbors.sqf"};

//--- CIPHER Module - Functions.
[] Call Compile preprocessFileLineNumbers "Common\Module\CIPHER\CIPHER_Init.sqf";

//--- Common initilization is complete at this point.
commonInitComplete = true;

//--- Variable Destruction.
{Call Compile Format ["%1 = nil",_x]} forEach ['WFBE_V_West_UnitsRootVersion','WFBE_V_East_UnitsRootVersion','WFBE_V_West_Faction',
'WFBE_V_East_Faction','WFBE_V_East_SquadsFaction','WFBE_V_West_SquadsFaction','WFBE_V_East_SquadsRootVersion','WFBE_V_West_SquadsRootVersion','WFBE_V_East_Loadout',
'WFBE_V_West_Loadout','WFBE_V_East_LoadoutRootVersion','WFBE_V_West_LoadoutRootVersion','WFBE_V_West_StructuresFaction','WFBE_V_East_StructuresFaction','WFBE_V_East_StructuresRootVersion',
'WFBE_V_West_StructuresRootVersion','WFBE_V_West_ArtilleryRootVersion','WFBE_V_West_ArtilleryFaction','WFBE_V_East_ArtilleryRootVersion','WFBE_V_East_ArtilleryFaction'];