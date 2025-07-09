Private ['_add','_buildings','_built','_checks','_closest','_d','_dir','_driver','_group','_gunner','_lastWP','_lastWPpos','_logic','_logicMARTA','_pos','_radius','_sorted','_spawn','_step','_uav','_waypoints','_wp','_wpcount'];
_logic = WF_Logic;

if (!isNull playerUAV) then {if (!alive playerUAV) then {playerUAV = objNull}};
if (!isNull playerUAV) exitWith {ExecVM "Client\Module\UAV\uav_interface.sqf";};

//--- Execute MARTA
if (isnil "bis_marta_mainscope") then {
	_logicMARTA = (group _logic) createunit ["MartaManager",position player,[],0,"none"];
};

if (isNil {missionNamespace getVariable Format ["WFBE_%1UAV",sideJoinedText]}) exitWith {};
if ((missionNamespace getVariable Format ["WFBE_%1UAV",sideJoinedText]) == "") exitWith {};

_buildings = (sideJoinedText) Call GetSideStructures;
_checks = [sideJoined,Format ["WFBE_%1COMMANDCENTERTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
_closest = objNull;
if (count _checks > 0) then {
	_closest = [player,_checks] Call GetClosestEntity;
};

if (isNull _closest) exitWith {};

_uav = createVehicle [Format ["WFBE_%1UAV",sideJoinedText] Call GetNamespace,getPos _closest, [], 0, "FLY"];
playerUAV = _uav;
Call Compile Format ["_uav addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",sideID];
_uav setVehicleInit Format["[this,%1] ExecVM 'Common\Init\Init_Unit.sqf';",sideID];
processInitCommands;

//--- Remove weapons if air restriction is enabled.
if (('WFBE_RESTRICTIONADVAIR' Call GetNamespace) == 2) then {_uav removeweapon "HellfireLauncher";};

_group = createGroup sideJoined;
_driver = [Format ["WFBE_%1SOLDIER",sideJoinedText] Call GetNamespace,_group,getPos _uav,sideJoined] Call CreateMan;
_driver MoveInDriver _uav;

_built = 1;
//--- OPFOR Uav has no gunner slot.
if (sideJoined == west) then {
	_gunner = [Format ["WFBE_%1SOLDIER",sideJoinedText] Call GetNamespace,_group,getPos _uav,sideJoined] Call CreateMan;
	_gunner MoveInGunner _uav;
	_built = _built + 1;
};
[sideJoinedText,'UnitsCreated',_built] Call UpdateStatistics;
[sideJoinedText,'VehiclesCreated',1] Call UpdateStatistics;

if (side player == west) then {if (('WFBE_RESTRICTIONADVAIR' Call GetNamespace) != 2) then {-10500 Call ChangePlayerFunds;} else {-7500 Call ChangePlayerFunds;};} else {-5500 Call ChangePlayerFunds;};

["RequestSpecial", ["uav",sideJoined,_uav,clientTeam]] Call SendToServer;

sleep 0.05;

if ((count units _uav) > 1) then {[driver _uav] join grpnull};

_radius = 1000;
_wpcount = 4;
_step = 360 / _wpcount;
_add = 0;
_dir = 0;
(group _uav) addwaypoint [getPos _closest,0];

//--- No need to preprocess those.
ExecVM "Client\Module\UAV\uav_interface.sqf";
[_uav] ExecVM 'Client\Module\UAV\uav_spotter.sqf';

_spawn = [] spawn {}; //--- Empty spawn
while {alive _uav} do {
	waituntil {sleep 0.05;waypointdescription [group _uav,currentwaypoint group _uav] != ' ' || !alive _uav};
	terminate _spawn; //--- Terminate spawn from previous loop
	if (!(alive _uav)||isNull _uav) exitwith {};

	_waypoints = waypoints _uav;
	_lastWP = _waypoints select (count _waypoints - 1);
	_lastWPpos = waypointposition _lastWP;
	while {count (waypoints _uav) > 0} do {deletewaypoint ((waypoints _uav) select 0)};
	for "_d" from 0 to (360-_step) step _step do
	{
		_add = _d;
		_pos = [_lastWPpos, _radius, _dir+_add] call bis_fnc_relPos;
		_wp = (group _uav) addwaypoint [_pos,0];
		_wp setWaypointType "MOVE";
		_wp setwaypointdescription ' ';
		_wp setwaypointcompletionradius (1000/_wpcount);
	};
	_uav disableAI "TARGET";
	_spawn = [_uav,_add,_step,_lastWPpos,_radius,_dir,_wpcount] spawn {
		Private ['_add','_currentWP','_dir','_lastWPpos','_pos','_radius','_step','_uav','_wp','_wpcount'];
		scriptname "UAV Route planning";
		_uav = _this select 0;
		_add = _this select 1;
		_step = _this select 2;
		_lastWPpos = _this select 3;
		_radius = _this select 4;
		_dir = _this select 5;
		_wpcount = _this select 6;
		_currentWP = currentwaypoint group _uav;
		while {alive _uav} do {
			waituntil {sleep 0.05;_currentWP != currentwaypoint group _uav};
			sleep 0.5;
			_add = _add + _step;
			_pos = [_lastWPpos, _radius, _dir+_add] call bis_fnc_relPos;
			_wp = (group _uav) addwaypoint [_pos,0];
			_wp setWaypointType "MOVE";
			_wp setwaypointdescription ' ';
			_wp setwaypointcompletionradius (1000/_wpcount);
			_currentWP = currentwaypoint group _uav;
		};
	};

	_wpcount = count waypoints _uav;
	waituntil {sleep 0.05;waypointdescription [group _uav,currentwaypoint group _uav] == ' ' || _wpcount != count waypoints _uav || !alive _uav};
	if (!(alive _uav)||isNull _uav) exitwith {};
};
