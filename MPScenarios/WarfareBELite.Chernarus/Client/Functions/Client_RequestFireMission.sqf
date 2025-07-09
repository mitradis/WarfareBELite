Private ["_count","_destination","_index","_type","_units"];

_destination = _this select 0;
_index = _this select 1;
_type = 0;

scopeName "FireMission";

_units = [group player,false,_index,sideJoinedText] Call GetTeamArtillery;

if (count _units < 1) exitWith {};
_type = ((Format ['WFBE_%1_ARTILLERY_NAMES',sideJoinedText] Call GetNamespace) select _index) find (typeOf (_units select 0));

if (_type < 0) exitWith {_type};

_units = [group player,false,_index,sideJoinedText] Call GetTeamArtillery;
if (Count _units < 1) then {breakTo "FireMission"};

for [{_count = count _units - 1},{_count >= 0},{_count = _count - 1}] do {
	[_units select _count,_destination,Side player,artyRange,_index] Spawn FireArtillery;
};

//Keep weapons reloaded.
_units = [Group player,true,_index,sideJoinedText] Call GetTeamArtillery;
{if (!someAmmo _x) then {[_x,sideJoinedText] Call RearmVehicle}} forEach _units;