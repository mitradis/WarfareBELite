Private ["_defense","_side","_sideID","_spawn","_town"];

_town = _this select 0;
_side = _this select 1;
_sideID = (_side) Call GetSideID;

//--- Browse all the defenses of the town.
{
	_defense = _x getVariable "wfbe_defense";
	_spawn = false;
	if (isNil '_defense') then {
		_spawn = true;
	} else {
		if (!alive _defense || (_x getVariable "wfbe_defense_side") != _sideID) then {
			//--- Remove if non-null.
			if !(isNull _defense) then {deleteVehicle _defense};
			_spawn = true;
		};
	};
	
	if (_spawn) then {
		//--- Spawn a defense according to the types (if it exists).
		[_x, _side] Call SpawnTownDefense;
	};
} forEach (_town getVariable "wfbe_town_defenses");