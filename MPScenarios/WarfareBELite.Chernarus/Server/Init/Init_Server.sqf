if (!isServer || time > 30) exitWith {};

Private ['_BIS_WF_HQEASTgrp','_BIS_WF_HQEASTgrp2','_BIS_WF_HQWESTgrp','_BIS_WF_HQWESTgrp2','_WF_GroupLogic','_WF_GroupLogic2','_WF_GroupLogic3','_WF_GroupLogic4','_alice','_allies','_eastLocation','_i','_locationLogics','_nearLogics','_oc','_ran','_total','_type','_upArray','_vehicle','_weat','_westLocation'];

//--- Allow resistance group to be spawned without a placeholder.
createCenter resistance;
resistance setFriend [west,0];
resistance setFriend [east,0];

if (paramAI) then {
	AIBuyUnit = Compile preprocessFile "Server\Functions\Server_BuyUnit.sqf";
	AISquadRespawn = Compile preprocessFile "Server\AI\AI_SquadRespawn.sqf";
};
AIMoveTo = Compile preprocessFile "Server\AI\Orders\AI_MoveTo.sqf";
AIPatrol = Compile preprocessFile "Server\AI\Orders\AI_Patrol.sqf";
AITownPatrol = Compile preprocessFile "Server\AI\Orders\AI_TownPatrol.sqf";
AIUpgrade = Compile preprocessFile "Server\AI\AI_Upgrade.sqf";
AIWPAdd = Compile preprocessFile "Server\AI\Orders\AI_WPAdd.sqf";
AIWPRemove = Compile preprocessFile "Server\AI\Orders\AI_WPRemove.sqf";
BuildingDamaged = Compile preprocessFile "Server\Functions\Server_BuildingDamaged.sqf";
BuildingKilled = Compile preprocessFile "Server\Functions\Server_BuildingKilled.sqf";
CanUpdateTeam = Compile preprocessFile "Server\Functions\Server_CanUpdateTeam.sqf";
ChangeAICommanderFunds = Compile preprocessFile "Server\Functions\Server_ChangeAICommanderFunds.sqf";
ConstructDefense = Compile preprocessFile "Server\Construction\Construction_StationaryDefense.sqf";
CreateDefenseTemplate = Compile preprocessFile "Server\Functions\Server_CreateDefenseTemplate.sqf";
CreateTeamTemplate = Compile preprocessFile "Server\Functions\Server_CreateTeam.sqf";
GetAICommanderFunds = Compile preprocessFile "Server\Functions\Server_GetAICommanderFunds.sqf";
GetTownGroups = Compile preprocessFileLineNumbers "Server\Functions\Server_GetTownGroups.sqf";
GetTownGroupsDefender = Compile preprocessFileLineNumbers "Server\Functions\Server_GetTownGroupsDefender.sqf";
GetTownPatrol = Compile preprocessFileLineNumbers "Server\Functions\Server_GetTownPatrol.sqf";
HQKilled = Compile preprocessFile "Server\Functions\Server_HQKilled.sqf";
HandleBuildingDamage = Compile preprocessFile "Server\Functions\Server_HandleBuildingDamage.sqf";
HandleDefense = Compile preprocessFile "Server\Functions\Server_HandleDefense.sqf";
HandleEmptyVehicle = Compile preprocessFile "Server\Functions\Server_HandleEmptyVehicle.sqf";
HandlePVFServer = Compile preprocessFileLineNumbers "Server\Functions\Server_HandlePVF.sqf";
HandleSpecial = Compile preprocessFile "Server\Functions\Server_HandleSpecial.sqf";
HandleStuckAI = Compile preprocessFile "Server\Functions\Server_HandleStuckAI.sqf";
MHQRepair = Compile preprocessFile "Server\Functions\Server_MHQRepair.sqf";
ManageTownDefenses = Compile preprocessFileLineNumbers "Server\Functions\Server_ManageTownDefenses.sqf";
OperateTownDefensesUnits = Compile preprocessFileLineNumbers "Server\Functions\Server_OperateTownDefensesUnits.sqf";
SVoteForCommander = Compile preprocessFile "Server\Server_VoteForCommander.sqf";
SetCampsToSide = Compile preprocessFileLineNumbers "Server\Functions\Server_SetCampsToSide.sqf";
SideMessage = Compile preprocessFile "Server\Functions\Server_SideMessage.sqf";
SpawnTownDefense = Compile preprocessFileLineNumbers "Server\Functions\Server_SpawnTownDefense.sqf";
TrashObject = Compile preprocessFile "Server\Functions\Server_TrashObject.sqf";
UpdateSupplyTruck = Compile preprocessFile "Server\AI\AI_UpdateSupplyTruck.sqf";
UpdateTeam = Compile preprocessFile "Server\Functions\Server_UpdateTeam.sqf";
WaypointPatrol = Compile preprocessFileLineNumbers "Server\Functions\Server_WaypointPatrol.sqf";
WaypointPatrolTown = Compile preprocessFileLineNumbers "Server\Functions\Server_WaypointPatrolTown.sqf";
WaypointSimple = Compile preprocessFileLineNumbers "Server\Functions\Server_WaypointSimple.sqf";
WaypointsAdd = Compile preprocessFileLineNumbers "Server\Functions\Server_WaypointsAdd.sqf";
WaypointsRemove = Compile preprocessFileLineNumbers "Server\Functions\Server_WaypointsRemove.sqf";
if (paramHandleFF) then {BuildingHandleDamages = Compile preprocessFile "Server\Functions\Server_BuildingHandleDamages.sqf"};
if (paramUseWorkers) then {HandleBuildingRepair = Compile preprocessFile "Server\Functions\Server_HandleBuildingRepair.sqf"};

//--- Support Functions.
KAT_ParaAmmo = Compile preprocessFile "Server\Support\Support_ParaAmmo.sqf";
KAT_Paratroopers = Compile preprocessFile "Server\Support\Support_Paratroopers.sqf";
KAT_ParaVehicles = Compile preprocessFile "Server\Support\Support_ParaVehicles.sqf";
KAT_UAV = Compile preprocessFile "Server\Support\Support_UAV.sqf";

//--- Server Init is now complete.
serverInitComplete = true;

//--- JIP Handler, handle the joining and leaving players.
onPlayerConnected "[_uid,_name] ExecVM 'Server\Server_PlayerConnected.sqf'";
onPlayerDisconnected "[_uid,_name] ExecVM 'Server\Server_PlayerDisconnected.sqf'";

//--- Getting all locations.
startingLocations = [0,0,0] nearEntities ["LocationLogicStart", 100000];

//--- Waiting for the common part to be executed.
waitUntil {sleep 0.1;commonInitComplete && townInit};

//--- Side logics.
_present_west = missionNamespace getVariable "WFBE_WEST_PRESENT";
_present_east = missionNamespace getVariable "WFBE_EAST_PRESENT";
_present_res = missionNamespace getVariable "WFBE_GUER_PRESENT";

//--- New Variables.
if (('WFBE_PATROLS' Call GetNamespace) > 0) then {
	missionNamespace setVariable ["WFBE_C_PATROLS_DELAY_SPAWN", 10];//--- Patrols will be able to respawn after x seconds.
	missionNamespace setVariable ["WFBE_C_PATROLS_TOWNS_REUSABLITY", 0.25];//--- Patrols may patrol a town again after being in 25% of the other towns.
	missionNamespace setVariable ["WFBE_C_PATROLS_TOWNS_LOCK", floor(totalTowns * (missionNamespace getVariable "WFBE_C_PATROLS_TOWNS_REUSABLITY"))];
};
	
[] Call Compile preprocessFile 'Server\Init\Init_Defenses.sqf';

//--- Fast Time.
if (('WFBE_FASTTIMERATE' Call GetNamespace) > 0) then {
	[] ExecFSM "Server\FSM\env_fast_time.fsm";
};

//--- Weather.
_weat = 'WFBE_WEATHER' Call GetNamespace;
if (_weat == 3) then {
	[] ExecFSM "Server\FSM\weather.fsm";
} else {
	if (isDedicated) then {
		_oc = 0.05;
		switch (_weat) do {
			case 0: {_oc = 0};
			case 1: {_oc = 0.5};
			case 2: {_oc = 1};
		};
		60 setOvercast _oc;
	};
};

//--- Static defenses groups in main towns.
{
	missionNamespace setVariable [Format ["WFBE_%1_DefenseTeam", _x], createGroup _x];
} forEach [west,east,resistance];

//--- Select whether the spawn restriction is enabled or not.
_locationLogics = [];
if (paramSpawnRestriction) then {
	{
		_nearLogics = _x nearEntities[["LocationLogicStart"],2000];
		if (count _nearLogics > 0) then {{if !(_x in _locationLogics) then {_locationLogics = _locationLogics + [_x]}} forEach _nearLogics};
	} forEach towns;
	if (count _locationLogics < 3) then {_locationLogics = startingLocations};
} else {
	_locationLogics = startingLocations;
};

//--- Retrieve the starting locations.
//--- Make sure that we have enough starting locations.
// if (count _startingLocations < 3) exitWith {endMission "END1"};

Private ["_i", "_maxAttempts", "_minDist", "_rPosE", "_rPosG", "_rPosW", "_setEast", "_setGuer", "_setWest", "_startE", "_startG", "_startW"];
_i = 0;
_maxAttempts = 2000;
_minDist = missionNamespace getVariable 'WFBE_SIDESTARTINGDISTANCE';
_startW = [0,0,0];
_startE = [0,0,0];
_startG = [0,0,0];
_rPosW = [0,0,0];
_rPosE = [0,0,0];
_rPosG = [0,0,0];
_setWest = if (_present_west) then {true} else {false};
_setEast = if (_present_east) then {true} else {false};
_setGuer = if (_present_res) then {true} else {false};
_total = count _locationLogics;

_use_random = false;

_spawn_north = objNull;
_spawn_south = objNull;
{
	if (!isNil {_x getVariable "wfbe_spawn"}) then {
		switch (_x getVariable "wfbe_spawn") do {
			case "north": {_spawn_north = _x};
			case "south": {_spawn_south = _x};
		};
	};
} forEach _locationLogics;

switch ('WFBE_STARTINGLOCATIONMODE' Call GetNamespace) do {
	case 0: {
		//--- West north, east south.
		if (isNull _spawn_north || isNull _spawn_south) then {
			_use_random = true;
		} else {
			_startE = _spawn_south;
			_startW = _spawn_north;
		};
	};
	case 1: {
		//--- West south, east north.
		if (isNull _spawn_north || isNull _spawn_south) then {
			_use_random = true;
		} else {
			_startE = _spawn_north;
			_startW = _spawn_south;
		};
	};
	case 2: {
		_use_random = true;
	};
};

if (_use_random) then {
	while {true} do {
		if (!_setWest && !_setEast && !_setGuer) exitWith {};

		//--- Determine west starting location if necessary.
		if (_setWest) then {
			_rPosW = _locationLogics select floor(random _total);
			if (_rPosW distance _startE > _minDist && _rPosW distance _startG > _minDist) then {_startW = _rPosW; _setWest = false};
		};
		
		// --- Determine west starting location if necessary.
		if (_setEast) then {
			_rPosE = _locationLogics select floor(random _total);
			if (_rPosE distance _startW > _minDist && _rPosE distance _startG > _minDist) then {_startE = _rPosE; _setEast = false};
		};
		
		// --- Determine guer starting location if necessary.
		if (_setGuer) then {
			_rPosG = _locationLogics select floor(random _total);
			if (_rPosG distance _startW > _minDist && _rPosG distance _startE > _minDist) then {_startG = _rPosG; _setGuer = false};
		};
		
		_i = _i + 1;
		
		if (_i >= _maxAttempts) exitWith {
			//--- Get the default locations.
			Private ["_eastDefault", "_guerDefault", "_westDefault"];
			_eastDefault = objNull;
			_westDefault = objNull;
			_guerDefault = objNull;


			{
				if (!isNil {_x getVariable "wfbe_default"}) then {
					switch (_x getVariable "wfbe_default") do {
						case west: {_westDefault = _x};
						case east: {_eastDefault = _x};
						case resistance: {_guerDefault = _x};
					};
				};
			} forEach startingLocations;

			// --- Ensure that everything is set, otherwise we randomly set the spawn.
			if (isNull _guerDefault || isNull _eastDefault || isNull _westDefault) then {
				Private ["_tempWork"];
				_tempWork = +(startingLocations) - [_westDefault, _eastDefault, _guerDefault];
				if (isNull _guerDefault && _present_res) then {_guerDefault = _tempWork select floor(random _total); _tempWork = _tempWork - [_guerDefault]};
				if (isNull _eastDefault && _present_east) then {_eastDefault = _tempWork select floor(random _total); _tempWork = _tempWork - [_eastDefault]};
				if (isNull _westDefault && _present_west) then {_westDefault = _tempWork select floor(random _total); _tempWork = _tempWork - [_westDefault]};
			};
			
			if (_present_res) then {_startG = _guerDefault};
			if (_present_east) then {_startE = _eastDefault};
			if (_present_west) then {_startW = _westDefault};
		};
	};
};

_eastLocation = _startE;
_westLocation = _startW;

//--- Moving each non-owner objects to the location.
EastMHQ setPos getPos _eastLocation;
WestMHQ setPos getPos _westLocation;

//--- Friendly Fire handler.
if (paramHandleFF) then {
	EastMHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, east] Call BuildingHandleDamages}];
	WestMHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, west] Call BuildingHandleDamages}];
};

eastStartingLocation = _eastLocation;
westStartingLocation = _westLocation;

publicVariable "eastStartingLocation";
publicVariable "westStartingLocation";

//--- Adding a killed EH to both MHQ.
Call Compile Format ["EastMHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",east,typeOf EastMHQ];
Call Compile Format ["WestMHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",west,typeOf WestMHQ];

//--- Radio System - Server.
_WF_GroupLogic = createGroup sideLogic;
_WF_GroupLogic2 = createGroup sideLogic;
_WF_GroupLogic3 = createGroup sideLogic;
_WF_GroupLogic4 = createGroup sideLogic;

_BIS_WF_HQEASTgrp = createGroup east;
_BIS_WF_HQWESTgrp = createGroup west;
_BIS_WF_HQEASTgrp2 = createGroup east;
_BIS_WF_HQWESTgrp2 = createGroup west;

BIS_WF_HQEAST = _WF_GroupLogic createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQEAST] joinSilent _BIS_WF_HQEASTgrp;
BIS_WF_HQWEST = _WF_GroupLogic2 createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQWEST] joinSilent _BIS_WF_HQWESTgrp;
BIS_WF_HQEAST2 = _WF_GroupLogic3 createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQEAST2] joinSilent _BIS_WF_HQEASTgrp2;
BIS_WF_HQWEST2 = _WF_GroupLogic4 createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQWEST2] joinSilent _BIS_WF_HQWESTgrp2;

BIS_WF_HQEAST_TI = ('WFBE_EAST_RadioAnnouncers' Call GetNamespace) select round(random((count ('WFBE_EAST_RadioAnnouncers' Call GetNamespace))-1));
BIS_WF_HQWEST_TI = ('WFBE_WEST_RadioAnnouncers' Call GetNamespace) select round(random((count ('WFBE_WEST_RadioAnnouncers' Call GetNamespace))-1));

BIS_WF_HQEAST setIdentity BIS_WF_HQEAST_TI;
BIS_WF_HQEAST setRank 'COLONEL';
BIS_WF_HQEAST setGroupId ["HQ"];
BIS_WF_HQEAST kbAddTopic [BIS_WF_HQEAST_TI,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];

BIS_WF_HQWEST setIdentity BIS_WF_HQWEST_TI;
BIS_WF_HQWEST setRank 'COLONEL';
BIS_WF_HQWEST setGroupId ["HQ"];
BIS_WF_HQWEST kbAddTopic [BIS_WF_HQWEST_TI,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];

publicVariable 'BIS_WF_HQEAST';
publicVariable 'BIS_WF_HQEAST_TI';
publicVariable 'BIS_WF_HQWEST';
publicVariable 'BIS_WF_HQWEST_TI';

['WFBE_West_TimeUnderAttack',0,true] Call SetNamespace;
['WFBE_East_TimeUnderAttack',0,true] Call SetNamespace;

['WFBE_West_LastCommander',objNull,true] Call SetNamespace;
['WFBE_East_LastCommander',objNull,true] Call SetNamespace;

['WFBE_West_AIBase',false,true] Call SetNamespace;
['WFBE_East_AIBase',false,true] Call SetNamespace;

['WFBE_West_AISupplyTrucks',[],true] Call SetNamespace;
['WFBE_East_AISupplyTrucks',[],true] Call SetNamespace;

['WFBE_West_AICommanderFunds',round(('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*1.5),true] Call SetNamespace;
['WFBE_East_AICommanderFunds',round(('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*1.5),true] Call SetNamespace;

//--- MHQ Tracking.
EastMHQ setVehicleInit Format["[this,%1] ExecVM 'Common\Init\Init_Unit.sqf'",EASTID];
WestMHQ setVehicleInit Format["[this,%1] ExecVM 'Common\Init\Init_Unit.sqf'",WESTID];
processInitCommands;

//--- Statistics variables.
WF_Logic setVariable ["eastUnitsCreated",0,true];
WF_Logic setVariable ["eastCasualties",0,true];
WF_Logic setVariable ["eastVehiclesCreated",0,true];
WF_Logic setVariable ["eastVehiclesLost",0,true];
WF_Logic setVariable ["westUnitsCreated",0,true];
WF_Logic setVariable ["westCasualties",0,true];
WF_Logic setVariable ["westVehiclesCreated",0,true];
WF_Logic setVariable ["westVehiclesLost",0,true];

WF_Logic setVariable ["WF_CHQInUse_West",false];
WF_Logic setVariable ["WF_CHQInUse_East",false];

//--- Structures (en: it's possible to add location in the array, just make sure that they match the defined type in config_structures).
EastBaseStructures = [];
WestBaseStructures = [];
publicVariable "EastBaseStructures";
publicVariable "WestBaseStructures";

emptyQueu = [];

//--- Starting Vehicles East.
{
	_vehicle = [_x,(getPos EastMHQ),EASTID,false] Call CreateVehi;
	[_vehicle,getPos EastMHQ,45,60,true,false,true] Call PlaceNear;
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	emptyQueu = emptyQueu + [_vehicle];
	_vehicle Spawn HandleEmptyVehicle;
} forEach ('WFBE_EASTSTARTINGVEHICLES' Call GetNamespace);
//--- Starting Vehicles West.
{
	_vehicle = [_x,(getPos WestMHQ),WESTID,false] Call CreateVehi;
	[_vehicle,getPos WestMHQ,45,60,true,false,true] Call PlaceNear;
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	emptyQueu = emptyQueu + [_vehicle];
	_vehicle Spawn HandleEmptyVehicle;
} forEach ('WFBE_WESTSTARTINGVEHICLES' Call GetNamespace);

if (paramAI) then {
	//--- Loadout replacement & positioning & variables.
	_i = 1;
	{
		if !(isNil "_x") then {
			if (!isPlayer (leader _x) && alive (leader _x)) then {
				_ran = 1 + round(random(2));
				(leader _x) setPos ([getPos _eastLocation,30,20] Call GetRandomPosition);
				// [(leader _x),Format ["WFBE_EASTLEADERWEAPONS0%1",_ran] Call GetNamespace,Format ["WFBE_EASTLEADERAMMO0%1",_ran] Call GetNamespace] Call EquipLoadout;
				_loadout = missionNamespace getVariable "WFBE_East_AI_Loadout_0";
				if !(isNil '_loadout') then {
					_loadout = _loadout select floor (random count _loadout);
					if (count _loadout <= 3) then {
						[leader _x, _loadout select 0, _loadout select 1, _loadout select 2] Call EquipUnit;
					} else {
						[leader _x, _loadout select 0, _loadout select 1, _loadout select 2, _loadout select 3, _loadout select 4] Call EquipUnit;
					};
				};
			};
			_x setVariable ["wfbe_persistent", true];
			_x setVariable ["queue",[]];
			Call Compile Format ["EastSlot%1Funds = %2; publicVariable 'EastSlot%1Funds';",_i,'WFBE_EASTSTARTINGMONEY' Call GetNamespace];
			[_x, false]	Call SetTeamAutonomous;
			[_x, ""] Call SetTeamRespawn;
			[_x, -1] Call SetTeamType;
			[_x, "towns"] Call SetTeamMoveMode;
			[_x, [0,0,0]] Call SetTeamMovePos;
		};
		_i = _i + 1;
	} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	_i = 1;
	{
		if !(isNil "_x") then {
			if (!isPlayer (leader _x) && alive (leader _x)) then {
				_ran = 1 + round(random(2));
				(leader _x) setPos ([getPos _westLocation,30,20] Call GetRandomPosition);
				// [(leader _x),Format ["WFBE_WESTLEADERWEAPONS0%1",_ran] Call GetNamespace,Format ["WFBE_WESTLEADERAMMO0%1",_ran] Call GetNamespace] Call EquipLoadout;
				_loadout = missionNamespace getVariable "WFBE_West_AI_Loadout_0";
				if !(isNil '_loadout') then {
					_loadout = _loadout select floor (random count _loadout);
					if (count _loadout <= 3) then {
						[leader _x, _loadout select 0, _loadout select 1, _loadout select 2] Call EquipUnit;
					} else {
						[leader _x, _loadout select 0, _loadout select 1, _loadout select 2, _loadout select 3, _loadout select 4] Call EquipUnit;
					};
				};
			};
			_x setVariable ["wfbe_persistent", true];
			_x setVariable ["queue",[]];
			Call Compile Format ["WestSlot%1Funds = %2; publicVariable 'WestSlot%1Funds';",_i,'WFBE_WESTSTARTINGMONEY' Call GetNamespace];
			[_x, false]	Call SetTeamAutonomous;
			[_x, ""] Call SetTeamRespawn;
			[_x, -1] Call SetTeamType;
			[_x, "towns"] Call SetTeamMoveMode;
			[_x, [0,0,0]] Call SetTeamMovePos;
		};
		_i = _i + 1;
	} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	
	//--- AI Supply Trucks.
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		[east] Spawn UpdateSupplyTruck;
		[west] Spawn UpdateSupplyTruck;
	};
	
	//--- AI Teams (Don't pause the server initialization process).
	[] Spawn {
		waitUntil{sleep 0.1;townInit};
		{if (!isNil "_x") then {[_x] ExecFSM "Server\FSM\aiteam.fsm"}} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
		{if (!isNil "_x") then {[_x] ExecFSM "Server\FSM\aiteam.fsm"}} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	};
} else {
	_i = 1;
	{
		if !(isNil "_x") then {
			Call Compile Format ["EastSlot%1Funds = %2; publicVariable 'EastSlot%1Funds';",_i,'WFBE_EASTSTARTINGMONEY' Call GetNamespace];
			_x setVariable ["identification", Format["EastSlot%1",_i]];
			[_x, false]	Call SetTeamAutonomous;
			[_x, ""] Call SetTeamRespawn;
			[_x, -1] Call SetTeamType;
		};
		_i = _i + 1;
	} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	_i = 1;
	{
		if !(isNil "_x") then {
			Call Compile Format ["WestSlot%1Funds = %2; publicVariable 'WestSlot%1Funds';",_i,'WFBE_WESTSTARTINGMONEY' Call GetNamespace];
			_x setVariable ["identification", Format["WestSlot%1",_i]];
			[_x, false] Call SetTeamAutonomous;
			[_x, ""] Call SetTeamRespawn;
			[_x, -1] Call SetTeamType;
		};
		_i = _i + 1;
	} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
};

//--- Town starting mode.
if (('WFBE_TOWNSTARTINGMODE' Call GetNamespace) != 0 || ('WFBE_PATROLS' Call GetNamespace) > 0) then {[] Call Compile preprocessFile "Server\Init\Init_Towns.sqf"} else {townInitServer = true};

//--- Pre-initialization of the Garbage Collector & Empty vehicle collector.
WF_Logic setVariable ["emptyVehicles",[],true];

//--- Don't pause the server init script.
[] Spawn {
	waitUntil {sleep 0.1;townInit};
	[] ExecFSM "Server\FSM\updateserver.fsm";
	[] ExecFSM "Server\FSM\updateresources.fsm";
	
	if (('WFBE_TOWNCONQUESTMODE' Call GetNamespace) > 0) then {[] ExecFSM "Server\FSM\conquest.fsm"};
};
[] ExecFSM "Server\FSM\server_collector_garbage.fsm";
[] ExecFSM "Server\FSM\emptyvehiclescollector.fsm";

//--- Network System Part 2.
EastMHQDeployed = false; publicVariable 'EastMHQDeployed';
WestMHQDeployed = false; publicVariable 'WestMHQDeployed';

WFBE_East_Upgrading = false; publicVariable 'WFBE_East_Upgrading';
WFBE_West_Upgrading = false; publicVariable 'WFBE_West_Upgrading';

if !(paramMoneyOnly) then {
	WF_Logic setVariable ["EastSupplies",EastSupplies,true];
	WF_Logic setVariable ["WestSupplies",WestSupplies,true];
};

WF_Logic setVariable ["EastCommanderVoteTime",30,true];
WF_Logic setVariable ["WestCommanderVoteTime",30,true];

WF_Logic setVariable ["EastCommanderTeam",EastCommanderTeam,true];
WF_Logic setVariable ["WestCommanderTeam",WestCommanderTeam,true];

WF_Logic setVariable ["EastMHQRepair",false,true];
WF_Logic setVariable ["WestMHQRepair",false,true];

//--- Upgrades.
_upArray = if (paramUpgradesEast) then {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]} else {'WFBE_UPGRADELEVELS' Call GetNamespace};
EASTUpgrades = _upArray;
PublicVariable 'EASTUpgrades';
_upArray = if (paramUpgradesWest) then {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]} else {'WFBE_UPGRADELEVELS' Call GetNamespace};
WESTUpgrades = _upArray;
PublicVariable 'WESTUpgrades';
//todo, pimp in 073
GUERUpgrades = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];


//--- Building Limits.
WestBuildingsCurrent = [];
EastBuildingsCurrent = [];
for '_i' from 0 to ((count ('WFBE_WESTSTRUCTURES' Call GetNamespace))-2) do {WestBuildingsCurrent set [_i, 0]};
for '_i' from 0 to ((count ('WFBE_EASTSTRUCTURES' Call GetNamespace))-2) do {EastBuildingsCurrent set [_i, 0]};
PublicVariable 'WestBuildingsCurrent';
PublicVariable 'EastBuildingsCurrent';

if (paramRespawnMASH) then {
	WF_Logic setVariable ["EastMASH",objNull,true];
	WF_Logic setVariable ["WestMASH",objNull,true];
};

//--- Base Area (grouped base)
if (paramBaseArea) then {
	WF_Logic setVariable ["EastArea",[],true];
	WF_Logic setVariable ["WestArea",[],true];
	
	[] ExecFSM "Server\FSM\basearea.fsm";
};

//--- Allies base.
_allies = 'WFBE_ALLIES' Call GetNamespace;
if (_allies > 0 && WF_A2_Vanilla) then {
	AlliesBuyUnit = Compile preprocessFile "Server\Functions\Server_AlliesBuyUnit.sqf";
	[] Call Compile preprocessFile "Server\Config\Config_Allies.sqf";
	if (_allies in [1,3]) then {[west] ExecFSM "Server\FSM\allies.fsm"};
	if (_allies in [2,3]) then {[east] ExecFSM "Server\FSM\allies.fsm"};
};

//--- Use Workers?
if (paramUseWorkers) then {
	WF_WestWorkers = [];
	publicVariable "WF_WestWorkers";
	WF_EastWorkers = [];
	publicVariable "WF_EastWorkers";
	
	["WFBE_WORKERS_WESTLOGIC",[],true] Call SetNamespace;
	["WFBE_WORKERS_EASTLOGIC",[],true] Call SetNamespace;
};

//--- ALICE Module.
if (paramAlice) then {
	_type = if (WF_A2_Vanilla) then {'AliceManager'} else {'Alice2Manager'};
	_alice = (createGroup sideLogic) createUnit [_type,[0,0,0],[],0,"NONE"];
};

//--- Mission Module
if (paramSecondaryMissions) then {
	ExecFSM 'Server\FSM\missions.fsm';
};

//--- UPSMON AI
if (paramUPSMON) then {
	Call Compile preprocessFileLineNumbers "Server\Module\UPSMON\Init_UPSMON.sqf";
};

//--- Waiting until that the game is launched.
waitUntil {sleep 0.1;time > 0};

//--- Launch votes.
[East] Spawn SVoteForCommander;
[West] Spawn SVoteForCommander;