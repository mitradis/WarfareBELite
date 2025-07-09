Private ["_availableSpawn","_autonomous","_buildings","_checks","_closestRespawn","_deathLoc","_enemySide","_hq","_isForcedRespawn","_leader","_loadout","_mobileRespawns","_moveMode","_pos","_ran","_range","_rcm'","_rd","_respawn","_respawnLoc","_side","_sideID","_sideText","_team","_update","_upgrades"];
_side = _this select 0;
_team = _this select 1;
_sideText = str _side;
_deathLoc = objNull;
_respawnLoc = objNull;
_sideID = (_side) Call GetSideID;
_leader = leader _team;

_rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
_rcm = 'WFBE_RESPAWNCAMPSMODE' Call GetNamespace;

sleep (random 1);

while {!gameOver} do {
	if (isPlayer _leader) exitWith {};
	[str _side,'UnitsCreated',1] Call UpdateStatistics;
	_leader removeAllEventHandlers "Killed";
	_leader setVariable ["wfbe_trashed", nil, true];
	Call Compile Format ["_leader addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_sideID];
	
	_leader enableAI "MOVE";
	waitUntil {sleep 0.5;!alive _leader || isPlayer _leader};
	if (isPlayer _leader) exitWith {};
	
	_deathLoc = getPos _leader;
	
	waitUntil {sleep 0.5;alive (leader _team) || isPlayer (leader _team)};
	_leader = leader _team;
	if (isPlayer _leader) exitWith {};
	_leader disableAI "MOVE";

	_respawn = (_team) Call GetTeamRespawn;
	
	//--- Place the AI.
	_leader setPos getMarkerPos Format["%1TempRespawnMarker",_sideText];

	_availableSpawn = [];
	_isForcedRespawn = false;
	if (typeName _respawn == 'STRING') then {if (_respawn == "forceRespawn") then {_isForcedRespawn = true}};
	
	//--- Towns.
	if (_rcm > 0 && !_isForcedRespawn) then {
		_availableSpawn = _availableSpawn + ([_deathLoc, _side] Call GetRespawnCamps);
	};
	
	_upgrades = (_sideText) Call GetSideUpgrades;
	
	//--- Mobile Respawn.
	if (paramMobileRespawn && !_isForcedRespawn) then {
		_mobileRespawns = Format ["WFBE_%1AMBULANCES",_sideText] Call GetNamespace;
		_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
		_checks = _deathLoc nearEntities[_mobileRespawns,_range];
		if (count _checks > 0) then {
			{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
		};
	};
	
	sleep _rd;
	if (isPlayer _leader) exitWith {};
	
	//--- Equip the AI.
	_loadout = missionNamespace getVariable Format["WFBE_%1_AI_Loadout_%2", _sideText, _upgrades select 12];
	if !(isNil '_loadout') then {
		_loadout = _loadout select floor (random count _loadout);
		if (count _loadout <= 3) then {
			[_leader, _loadout select 0, _loadout select 1, _loadout select 2] Call EquipUnit;
		} else {
			[_leader, _loadout select 0, _loadout select 1, _loadout select 2, _loadout select 3, _loadout select 4] Call EquipUnit;
		};
	};
	_hq = (_sideText) Call GetSideHQ;
	_buildings = (_sideText) Call GetSideStructures;

	//--- Check whether AI has a spawn set or not.
	_update = false;
	switch (typeName _respawn) do {
		case "STRING": {
			_update = true;
			if (_isForcedRespawn) then {[_team,""] Call SetTeamRespawn};
		}; //--- Not defined.
		case "OBJECT": {
			_respawnLoc = _respawn;
			if (!alive _respawn || isNull _respawn) then {
				[_team, ""] Call SetTeamRespawn;
				_update = true;
			};	//--- Defined.
		};
	};
	
	//--- Default respawn.
	if (_update) then {
		_respawnLoc = _hq;
		if (count _buildings > 0) then {
			_respawnLoc = [_hq,_buildings] Call GetClosestEntity;
		};
	};
	
	//--- Alternative spawn location.
	if (count _availableSpawn > 0) then {
		_respawnLoc = _availableSpawn select (round(random((count _availableSpawn)-1)));
	};

	
	_pos = [getPos _respawnLoc,30,20] Call GetRandomPosition;
	_pos set [2,0];
	_leader setPos _pos;
	
	//--- Assign fresh order if the AI is not on autonomous mode.
	_autonomous = (_team) Call GetTeamAutonomous;
	if !(_autonomous) then {
		_foundMode = false;
		_moveMode = (_team) Call GetTeamMoveMode;
		if (_moveMode == "towns") then {_foundMode = true;[_team,"resetTowns"] Call SetTeamMoveMode};
		if (!(_foundMode) && _moveMode == "move") then {_foundMode = true;[_team,"resetMove"] Call SetTeamMoveMode};
		if (!(_foundMode) && _moveMode == "patrol") then {_foundMode = true;[_team,"resetPatrol"] Call SetTeamMoveMode};
		if (!(_foundMode) && _moveMode == "defense") then {_foundMode = true;[_team,"resetDefense"] Call SetTeamMoveMode};
		if !(_foundMode) then {[_team,"resetTowns"] Call SetTeamMoveMode};
	};
};