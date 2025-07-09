/* Players Attack Script (Hybrid) */
Private ["_boundaries","_chopper","_group","_jipHandler","_list","_pilot","_players","_ran","_ranDir","_runFor","_ranPos","_target","_targets","_turrets","_uniqueIndex","_uniqueLabel","_vehicle"];

_uniqueLabel = _this select 0;
_uniqueIndex = _this select 1;
_runFor = _this select 2;

//--- Retrieve the players on a side.
_players = [];
_list = Format ["WFBE_%1TEAMS",_runFor] Call GetNamespace;
{
	if !(isNil '_x') then {
		if (side _x == _runFor) then {
			if (isPlayer(leader _x) && alive(leader _x)) then {_players = _players + [leader _x]};
		};
	};
} forEach _list;

//--- Ensure that the team already has a town.
if (count _players == 0) exitWith {
	[Format['_WFBE_M_RUNNINGMISSIONS_%1',_runFor],((Format['_WFBE_M_RUNNINGMISSIONS_%1',_runFor]) Call GetNamespace) - 1, true] Call SetNamespace;
};

//--- Radio the designated team that a new mission is available.
['NewMissionAvailable','',_runFor] Spawn SideMessage;

//--- Define the chopper spawn position.
_boundaries = "WFBE_BOUNDARIESXY" Call GetNamespace;

_ranPos = [];
_ranDir = [];

_bd = 'WFBE_BOUNDARIESXY' Call GetNamespace;
if !(isNil '_bd') then {
	_ranPos = [
		[0+random(200),0+random(200),400+random(200)],
		[0+random(200),_bd-random(200),400+random(200)],
		[_bd-random(200),_bd-random(200),400+random(200)],
		[_bd-random(200),0+random(200),400+random(200)]
	];
	_ranDir = [45,145,225,315];
} else {
	_ranPos = [[0+random(200),0+random(200),400+random(200)],[10000+random(200),0+random(200),400+random(200)]];
	_ranDir = [45,315];
};

_ran = round(random((count _ranPos)-1));

//--- This script use PMC units.
_chopper = "Ka60_PMC";
_group = createGroup resistance;
_vehicle = createVehicle [_chopper,(_ranPos select _ran), [], (_ranDir select _ran), "FLY"];
_vehicle addEventHandler ['Killed',{[_this select 0,_this select 1,RESISTANCEID] Spawn UnitKilled}];

//--- Man the chopper.
_pilot = ["Soldier_Pilot_PMC",_group,[0,0,0],resistance] Call CreateMan;
_pilot moveInDriver _vehicle;
_pilot = ["Soldier_Pilot_PMC",_group,[0,0,0],resistance] Call CreateMan;
_pilot moveInGunner _vehicle;

//--- Man the extra turrets.
_config = configFile >> "CfgVehicles" >> _chopper >> "Turrets";
_turrets = [_config] call BIS_fnc_returnVehicleTurrets;
if (count _turrets > 0) then {[_turrets, [], _vehicle, "Soldier_Pilot_PMC", _group] call SpawnTurrets};

//--- Warn the client.
// WFBE_M_PLAYERS_Attack_Air = [_runFor,'CLTFNCM_PLAYERS_ATTACK_AIR',[_vehicle,_uniqueLabel,_uniqueIndex]];
// publicVariable 'WFBE_M_PLAYERS_Attack_Air';
// if (isHostedServer || local player) then {[_runFor,'CLTFNCM_PLAYERS_ATTACK_AIR',[_vehicle,_uniqueLabel,_uniqueIndex]] Spawn HandlePVF};
[_runFor, "M_PLAYERS_Attack_Air",[_vehicle,_uniqueLabel,_uniqueIndex]] Call SendToClients;
_jipHandler = [_vehicle,_uniqueLabel,_uniqueIndex,_runFor] Spawn {
	Private ['_chopper','_oldPlayerList','_runFor','_uniqueLabel','_uniqueIndex','_update'];
	_chopper = _this select 0;
	_uniqueLabel = _this select 1;
	_uniqueIndex = _this select 2;
	_runFor = _this select 3;
	
	while {true} do {
		_oldPlayerList = playableUnits;
		sleep 15;
		_update = false;
		{
			if !(_x in _oldPlayerList) then {_update = true};
		} forEach playableUnits;
		
		if (_update) then {
			// WFBE_M_PLAYERS_Attack_Air = [_runFor,'CLTFNCM_PLAYERS_ATTACK_AIR',[_chopper,_uniqueLabel,_uniqueIndex]];
			// publicVariable 'WFBE_M_PLAYERS_Attack_Air';
			// if (isHostedServer || local player) then {[_runFor,'CLTFNCM_PLAYERS_ATTACK_AIR',[_chopper,_uniqueLabel,_uniqueIndex]] Spawn HandlePVF};
			[_runFor, "M_PLAYERS_Attack_Air",[_chopper,_uniqueLabel,_uniqueIndex]] Call SendToClients;
		};
	};
};

//--- Move the chopper toward the target.
while {true} do {
	sleep 20;
	
	_players = [];
	{
		if !(isNil '_x') then {
			if (side _x == _runFor) then {
				if (isPlayer(leader _x) && alive(leader _x)) then {_players = _players + [leader _x]};
			};
		};
	} forEach _list;
	
	if (count _players == 0 || !alive _vehicle || !alive(driver _vehicle) || !canMove _vehicle) exitWith {};
	
	_target = [_vehicle, _players] Call GetClosestEntity;
	
	if !(someAmmo _vehicle) then {[_vehicle,resistance] Call RearmVehicle};
	
	_vehicle doMove (getPos _target);
	{_group reveal _x} forEach (vehicle _target nearEntities 200);
};

if (alive _vehicle || count _players == 0) then {_vehicle setDammage 1};
{if (alive _x || count _players == 0) then {_x setDammage 1}} forEach (units _group);

//--- Kill the spawned thread if it still runs.
if !(scriptDone _jipHandler) then {terminate _jipHandler};

//--- Wait for the client to end up his sync.
sleep 35;

[Format['_WFBE_M_RUNNINGMISSIONS_%1',_runFor],((Format['_WFBE_M_RUNNINGMISSIONS_%1',_runFor]) Call GetNamespace) - 1, true] Call SetNamespace;