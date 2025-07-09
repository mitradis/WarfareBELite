Private ['_buildings','_closestRespawn','_cmdrTeam','_funds','_get','_hq','_name','_respawnLoc','_side','_sideText','_slotIndex','_team','_units','_uid'];
_uid = _this select 0;
_name = _this select 1;



//--- Grab the player info (if they exist).
_get = Format["WFBE_JIP_USER%1",_uid] Call GetNamespace;
if (isNil '_get') exitWith {};

//--- Check this mess.
_side = _get select 4;
_sideText = str _side;
_slotIndex = _get select 1;
_team = Call Compile Format ["group %1",_get select 6];
if (isNull _team) exitWith {};

//--- Force the unit out if it has a vehicle.
if !(isNull(assignedVehicle (leader _team))) then {
	unassignVehicle (leader _team);
	[leader _team] orderGetIn false;
	[leader _team] allowGetIn false;
};

//--- Is unit driving the HQ?
_hq = (_sideText) Call GetSideHQ;
if (vehicle(leader _team) == _hq) then {(leader _team) action ["EJECT", _hq]};

//--- Keep AI over JIP?
if !(paramKeepAI) then {
	
	_units = units _team;
	_units = _units - [leader _team];
	_units = _units + ([_team,false] Call GetTeamVehicles) - [_hq];
	{deleteVehicle _x} forEach _units;
};

//--- Save the Client Cash.
_funds = _team Call GetTeamFunds;
_get set [2,_funds];

//--- SetPos the AI.
_buildings = (_sideText) Call GetSideStructures;
_respawnLoc = _hq;
if (count _buildings > 0) then {
	_respawnLoc = [leader _team,_buildings] Call GetClosestEntity;
};
(leader _team) setPos ([getPos _respawnLoc,30,20] Call GetRandomPosition);

//--- Update.
[Format["WFBE_JIP_USER%1",_uid],_get,true] Call SetNamespace;

//--- Player was commander?.
_cmdrTeam = (_side) Call GetCommanderTeam;
if !(isNull (_cmdrTeam)) then {
	if (_team == _cmdrTeam) then {
		WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],objNull,true];
		// WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['CommanderDisconnected']];
		// publicVariable 'WFBE_LocalizeMessage';
		[_side, "LocalizeMessage", ['CommanderDisconnected']] Call SendToClients;
		
		[_side] Spawn SVoteForCommander;
		
		//--- High Command (Remove).
		if (paramHighCommand && count (hcAllGroups (leader _team)) > 0) then {HCRemoveAllGroups (leader _team)};
		
		//--- AI Can move freely now & respawn at the default location.
		{[_x,false] Call SetTeamAutonomous;[_x, ""] Call SetTeamRespawn;} forEach (Format["WFBE_%1TEAMS",_sideText] Call GetNamespace);
	};
};