Private ["_action","_defense","_side","_spawn","_town"];

_town = _this select 0;
_side = _this select 1;
_action = _this select 2;

switch (_action) do {
	case "spawn": {
		//--- Man the defenses.
		{
			_defense = _x getVariable "wfbe_defense";
			
			//--- Make sure that the defense gunner is null or dead.
			if (!(alive gunner _defense)) then {
				_unit = [missionNamespace getVariable Format ["WFBE_%1SOLDIER", _side],missionNamespace getVariable Format ["WFBE_%1_DefenseTeam", _side], getPos _x, _side] Call CreateMan;
				_unit assignAsGunner _defense;
				[_unit] orderGetIn true;
				_unit moveInGunner _defense;
			};
		} forEach (_town getVariable "wfbe_town_defenses");
		
		//--- Reveal the town area to the statics.
		if (count (_town getVariable "wfbe_town_defenses") > 0) then {
			[missionNamespace getVariable Format ["WFBE_%1_DefenseTeam", _side], _town getVariable "range", _town] Call RevealArea;
		};
		
		
	};
	case "remove": {
		//--- De-man the defenses.
		{
			_defense = _x getVariable "wfbe_defense";
			
			//--- Make sure that we do not remove a player's unit.
			_unit = gunner _defense;
			if !(isNull _unit) then {
				if (alive _unit) then {
					if (isNil {(group _unit) getVariable "wfbe_persistent"}) then {
						_unit setPos (getpos _x);
						deleteVehicle _unit;
					};
				};
			};
		} forEach (_town getVariable "wfbe_town_defenses");
		
		
	};
};