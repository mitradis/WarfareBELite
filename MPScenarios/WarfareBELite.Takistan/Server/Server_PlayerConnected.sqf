Private ['_attempts','_funds','_get','_name','_sideJoined','_sideOrigin','_slotIndex','_team','_uid','_units'];
_uid = _this select 0;
_name = _this select 1;



sleep (0.1 + (random 0.1));

//--- Don't bother with the server.
if (_name == '__SERVER__' || _uid == '') exitWith {};

//--- Attempt to get the player's team.
_attempts = 0;
_team = objNull;
while {_attempts < 12 && isNull _team} do {
	sleep 1;
	{if ((getPlayerUID (leader _x)) == _uid) then {_team = _x}} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	{if ((getPlayerUID (leader _x)) == _uid) then {_team = _x}} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	_attempts = _attempts + 1;
};

//--- Not found, exit.
if (isNull _team) exitWith {};

_sideJoined = civilian;

//--- Nasty hack, a leader side can be enemy so we do a class check.
if ((leader _team) isKindOf westSoldierBaseClass) then {_sideJoined = west};
if ((leader _team) isKindOf eastSoldierBaseClass) then {_sideJoined = east};

//--- Type not found.
if (_sideJoined == civilian) exitWith {};

//--- Retrieve the player's team.
_slotIndex = (Format["WFBE_%1TEAMS",str _sideJoined] Call GetNamespace) find _team;
if (_slotIndex == -1) exitWith {};

//--- Grab the player info (if they exist).
_get = Format["WFBE_JIP_USER%1",_uid] Call GetNamespace;

//--- Force the unit out if it's in a vehicle.
if !(isNull(assignedVehicle (leader _team))) then {
	unassignVehicle (leader _team);
	[leader _team] orderGetIn false;
	[leader _team] allowGetIn false;
};

//--- Do we keep the AI over JIP?.
if !(paramKeepAI) then {
	
	_units = units _team;
	_units = _units - [(leader _team)];
	_units = _units + ([_team,false] Call GetTeamVehicles);
	{deleteVehicle _x} forEach _units;
};

//--- 'Sanitize' the player.
_team Call AIWPRemove;
(leader _team) setDammage 0;

//--- Player didn't d/c.
if (isNil '_get') exitWith {
	/* 
		UID | Slot Index | Cash | Side | Current Side | (mysql) time | Vehicle Var Name
		This new method allows the server to execute the code faster, it will also prevent any possible 'wrong indexing' with the array (JIP Scripts are ExecVM'ed
		 by the engine), note that this method also sanitize the values, preventing them from being modified by anything else than the server.
	*/
	[Format["WFBE_JIP_USER%1",_uid],[_uid,_slotIndex,0,_sideJoined,_sideJoined,0,vehicleVarName (leader _team)],true] Call SetNamespace;

	Call Compile Format ["%1Funds = %2; publicVariable '%1Funds';",_team getVariable 'identification',Format ["WFBE_%1STARTINGMONEY",str _sideJoined] Call GetNamespace];
};

//--- Player d/c before, update info.
_get set [1,_slotIndex];
_get set [4,_sideJoined];
_get set [6,vehicleVarName (leader _team)];

//--- Player d/c before, grab the info.
_funds = _get select 2;
_sideOrigin = _get select 3;

//--- Update.
[Format["WFBE_JIP_USER%1",_uid],_get,true] Call SetNamespace;

//--- Did the player teamswap?.
if (_sideOrigin != _sideJoined) then {
	_funds = Format ["WFBE_%1STARTINGMONEY",str _sideJoined] Call GetNamespace;
};

//--- Set the cash.
Call Compile Format ["%1Funds = _funds; publicVariable '%1Funds';",_team getVariable 'identification'];