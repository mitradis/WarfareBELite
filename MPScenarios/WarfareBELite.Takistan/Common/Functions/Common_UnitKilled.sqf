Private ["_bounty","_crew","_get","_group","_isAIControlled","_iskilledplayer","_iskillerplayer","_isMan","_killed","_killedname","_killeduid","_killer","_killer_uid","_killerID","_killername","_killerTeam","_killerVehName","_killertype","_killeruid","_lost","_objects","_objectType","_side","_sideKiller","_sideVictim","_sta","_uid","_vehicle"];

_killed = _this select 0;
_killer = _this select 1;
_sideVictim = (_this select 2) Call GetSideFromID;
_sideKiller = side _killer;

_group = group _killed;
_killerTeam = group _killer;
_killerVehName = vehicleVarName (leader _killerTeam);
_killer_uid = getPlayerUID(_killer);
_vehicle = vehicle _killer;
_objectType = typeOf _killed;
_killertype = "";
_killeruid = "";
_killername = "";
_killeduid = "";
_killedname = "";
_iskilledplayer = false;

_isMan = if (_killed isKindOf "Man") then {true} else {false};

_iskillerplayer = if (isPlayer _killer) then {true} else {false};

//--- Renegade.
if (_sideKiller == sideEnemy) then {
	if (_killer isKindOf westSoldierBaseClass) then {_sideKiller = west};
	if (_killer isKindOf eastSoldierBaseClass) then {_sideKiller = east};
};
if (_sideVictim == civilian) then {
	if (_killed isKindOf westSoldierBaseClass) then {_sideVictim = west};
	if (_killed isKindOf eastSoldierBaseClass) then {_sideVictim = east};
};

if (isServer) then {
	_killed setVariable ["wfbe_trashed", true];
	_killed Spawn TrashObject;
};

sleep (random 3);

if (_isMan && (_sideVictim == west || _sideVictim == east)) then {[str _sideVictim,'Casualties',1] Call UpdateStatistics};
if (!_isMan && (_sideVictim == west || _sideVictim == east)) then {[str _sideVictim,'VehiclesLost',1] Call UpdateStatistics};

_killerID = (leader _killerTeam) Call GetClientID;
_get = _objectType Call GetNamespace;

_isAIControlled = true;
if (_killerID > 0) then {_isAIControlled = if (isPlayer (leader _killerTeam)) then {false} else {true}};

//--- Normal kill.
if (!isNull _killerTeam && !isNil '_get' && (_sideKiller != sideEnemy) && (_sideKiller != _sideVictim) && (_sideKiller != Civilian)) then {
	//--- If the killer is an ai of a player's squad, then the killer uid is the leader uid.
	if (!isPlayer _killer && isPlayer (leader _killerTeam)) then {_killer_uid = getPlayerUID (leader _killerTeam)};

	if (_killerID > 0 && !_isAIControlled) then {
		/* Bounty */
		if (paramBounty) then {
			// WFBE_AwardBounty = [_killerVehName,'CLTFNCAWARDBOUNTY',[_objectType, false]];
			// publicVariable 'WFBE_AwardBounty';
			// if (isHostedServer) then {[_killerVehName,'CLTFNCAWARDBOUNTY',[_objectType, false]] Spawn HandlePVF};
			[_killer_uid, "AwardBounty", [_objectType, false]] Call SendToClients;
			
			//--- Kill Assist.
			if (!(_vehicle isKindOf 'Man') && alive _vehicle) then {
				_crew = [driver _vehicle, gunner _vehicle, commander _vehicle] - [_killer, player];
				{
					if !(isNull _x) then {
						if (isPlayer _x && group _x != _killerTeam) then {
							// WFBE_AwardBounty = [vehicleVarName _x,'CLTFNCAWARDBOUNTY',[_objectType, true]];
							// publicVariable 'WFBE_AwardBounty';
							// if (isHostedServer) then {[vehicleVarName _x,'CLTFNCAWARDBOUNTY',[_objectType, true]] Spawn HandlePVF};
							[getPlayerUID(_x), "AwardBounty", [_objectType, true]] Call SendToClients;
						};
					};
				} forEach _crew;
			};
		};
		
		/* AI Score */
		if !(_iskillerplayer) then {
			[_objectType,leader _killerTeam] Spawn {
				Private ['_player','_point','_type'];
				_type = _this select 0;
				_player = _this select 1;
				
				_point = switch (true) do {
					case (_type isKindOf "Infantry"): {1};
					case (_type isKindOf "Car"): {2};
					case (_type isKindOf "Ship"): {4};
					case (_type isKindOf "Motorcycle"): {1};
					case (_type isKindOf "Tank"): {4};
					case (_type isKindOf "Helicopter"): {4};
					case (_type isKindOf "Plane"): {6};
					case (_type isKindOf "StaticWeapon"): {2};
					case (_type isKindOf "Building"): {2};
					default {1};
				};

				sleep (random 3);
				
				if !(isServer) then {
					["RequestChangeScore", [_player,score _player + _point]] Call SendToServer;
				};
			};
		};
	};
	
	/* Playable AI Kill */
	if (paramAI && _killerID > 0 && _isAIControlled) then {
		if (isServer) then {
			_bounty = (_get select QUERYUNITPRICE) * ('WFBE_BOUNTYMODIFIER' Call GetNamespace);
			_bounty = _bounty - (_bounty % 1);
			[_killerTeam,_bounty] Call ChangeTeamFunds;
		};
	};
};

//--- Teamkill.
if (!isNull _killerTeam && !isNil '_get' && (_sideKiller != sideEnemy) && (_sideKiller == _sideVictim) && (_sideKiller != Civilian) && _isMan) then {
	if (_killerID > 0 && !_isAIControlled) then {
		// WFBE_LocalizeMessage = [_killerVehName,'CLTFNCLOCALIZEMESSAGE',['Teamkill']];
		// publicVariable 'WFBE_LocalizeMessage';
		// if (isHostedServer) then {[_killerVehName,'CLTFNCLOCALIZEMESSAGE',['Teamkill']] Spawn HandlePVF};
		//--- If the killer is an ai of a player's squad, then the killer uid is the leader uid. tbd rework all.
		if (!isPlayer _killer && isPlayer (leader _killerTeam)) then {_killer_uid = getPlayerUID (leader _killerTeam)};
		[_killer_uid, "LocalizeMessage", ['Teamkill']] Call SendToClients;
	};
};
