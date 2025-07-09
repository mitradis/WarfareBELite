Private ["_allowCustom","_buildings","_charge","_funds","_get","_loadDefault","_listbp","_mode","_price","_skip","_spawn","_spawnInside","_typeof","_unit","_weaps"];

_unit = _this select 0;
_spawn = _this select 1;
_loadDefault = true;
_typeof = typeOf _spawn;

//--- Respawn.
_spawnInside = false;
if (_typeof in (Format ["WFBE_%1AMBULANCES",sideJoinedText] Call GetNamespace) && alive _spawn) then {
	if (_spawn emptyPositions "cargo" > 0 && !(locked _spawn)) then {_unit moveInCargo _spawn;_spawnInside = true};
};

if !(_spawnInside) then {_unit setPos ([getPos _spawn,20,10] Call GetRandomPosition)};

//--- Stock gear on mobile respawn.
_allowCustom = true;
if !(paramMobileGear) then {
	if (_typeof in (missionNamespace getVariable Format ["WFBE_%1AMBULANCES",sideJoinedText]) || _typeof == (missionNamespace getVariable Format ["WFBE_%1FARP",sideJoinedText])) then {
		_allowCustom = false;
	};
};

//--- Loadout.
if (!isNil {_unit getVariable "wfbe_custom_gear"} && !WFBE_RespawnDefaultGear && _allowCustom) then {
	_mode = 'WFBE_RESPAWNPENALTY' Call GetNamespace;
	
	if (_mode in [0,1,2,3,4]) then {
		//--- Calculate the price/funds.
		_skip = false;
		respawnGearCost = _unit getVariable "wfbe_custom_gear_cost";
		if (_mode != 0) then {
			_price = 0;
			
			//--- Get the mode pricing.
			switch (_mode) do {
				case 1: {_price = respawnGearCost};
				case 2: {_price = round(respawnGearCost/2)};
				case 3: {_price = round(respawnGearCost/4)};
				case 4: {_price = respawnGearCost};
			};
			
			//--- Are we charging only on mobile respawn?
			_charge = true;
			if (_mode == 4) then {
				_buildings = (sideJoinedText) Call GetSideStructures;
				if (_spawn in _buildings || _spawn == ((sideJoinedText) Call GetSideHQ)) then {_charge = false};
			};
			
			//--- Charge if possible.
			_funds = Call GetPlayerFunds;
			if (_funds >= _price && _charge) then {
				-(_price) Call ChangePlayerFunds;
				(Format[localize 'STR_WF_CHAT_Gear_RespawnCharge',_price]) Call GroupChatMessage;
			};
			
			//--- Check that the player has enough funds.
			if (_funds < _price) then {_skip = true};
		};
		
		//--- Use the respawn loadout.
		if !(_skip) then {
			_get = _unit getVariable "wfbe_custom_gear";
			[_unit, _get select 0, _get select 1, _get select 4, _get select 2, _get select 3] Call EquipUnit;
			_loadDefault = false;
		};
	};
};

//--- Load the default loadout.
if (_loadDefault) then {
	Private ["_default"];
	_default = missionNamespace getVariable Format["WFBE_%1_DefaultGear", WFBE_Client_SideJoinedText];
	if (count _default <= 3) then {
		[_unit, _default select 0, _default select 1, _default select 2] Call EquipUnit;
	} else {
		[_unit, _default select 0, _default select 1, _default select 2, _default select 3, _default select 4] Call EquipUnit;
	};
	// [_unit,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
};