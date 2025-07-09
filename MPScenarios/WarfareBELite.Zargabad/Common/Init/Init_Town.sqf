Private ['_town','_townName','_townDubbingName','_townStartSV','_townMaxSV','_townRange'];

_town = _this select 0;
_townName = _this select 1;
_townDubbingName = _this select 2;
_townStartSV = _this select 3;
_townMaxSV = _this select 4;
_townRange = if (count _this > 5) then {_this select 5} else {550};


waitUntil {sleep 0.05;!(isNil 'townModeSet')};
waitUntil {sleep 0.05;!(isNil 'initJIP')};
waitUntil {sleep 0.05;townModeSet && initJIP};

//todo, opposite system.
if ((str _town) in TownTemplate) exitWith {
	_town setVariable ["wfbe_inactive", true];
};

if (isNull _town || (_town getVariable "wfbe_inactive")) exitWith {};

_town setVariable ["name",_townName];
_town setVariable ["range",_townRange];
_town setVariable ["startingSupplyValue",_townStartSV];
_town setVariable ["maxSupplyValue",_townMaxSV];

waitUntil {sleep 0.05;commonInitComplete};

if (isServer) then {
	if (isNil 'EastMHQ' || isNil 'WestMHQ') exitWith {};
	
	//--- Get the camps and defenses, note that synchronizedObjects only work for the server.
	_camps = [];
	_defenses = [];
	for '_i' from 0 to count(synchronizedObjects _town)-1 do {
		_synced = (synchronizedObjects _town) select _i;
		if (typeOf _synced == "LocationLogicCamp" && paramKeepCamps) then {
			[_camps, _synced] Call ArrayPush;
			_synced setVariable ["town", _town];
		};
		if (!isNil {_synced getVariable "wfbe_defense_kind"}) then {[_defenses, _synced] Call ArrayPush};
	};

	_town setVariable ["camps", _camps, true];
	_town setVariable ["wfbe_town_defenses", _defenses];
	
	_townDubbingName = switch (_townDubbingName) do {
		case "+": {_townName};//--- Copy the name.
		case "": {"Town"};//--- Unknown name, apply Town dubbing.
		default {_townDubbingName};//--- Input name.
	};
	_town setVariable ["wfbe_town_dubbing", _townDubbingName];
	
	//--- Don't pause.
	[_town,_townStartSV,_townRange] Spawn {
		Private ["_camps","_defenses","_marker","_size","_town","_townRange","_townStartSV"];
		_town = _this select 0;
		_townStartSV = _this select 1;
		_townRange = _this select 2;
		_camps = _town getVariable "camps";
		
		//--- Models creation.
		_townModel = (missionNamespace getVariable "WFBE_C_DEPOT") createVehicle (getPos _town);
		_townModel setDir ((getDir _town) + (missionNamespace getVariable "WFBE_C_DEPOT_RDIR"));
		_townModel setPos (getPos _town);
		_townModel addEventHandler ["handleDamage", {false}];
		

		if (isNil {_town getVariable "sideID"}) then {_town setVariable ["sideID",RESISTANCEID,true]};
		_town setVariable ["supplyValue",_townStartSV,true];
		
		sleep (random 1);
		
		waitUntil {sleep 0.05;serverInitComplete};
		
		{
			Private ["_camp_health","_flag","_pos"];
			//--- Create the camp model.
			_townModel = (missionNamespace getVariable "WFBE_C_CAMP") createVehicle (getPos _x);
			_townModel setDir ((getDir _x) + (missionNamespace getVariable "WFBE_C_CAMP_RDIR"));
			_townModel setPos (getPos _x);
			
			//--- Maybe we want to make the camp stronger.
			_townModel addEventHandler ["handleDamage",{getDammage (_this select 0)+(_this select 2)/15}];
			
			//--- Create a flag near the camp location & position it.
			_flag = (missionNamespace getVariable "WFBE_C_CAMP_FLAG") createVehicle (getPos _x);
			_flag setPos (_x modelToWorld (missionNamespace getVariable "WFBE_C_CAMP_FLAG_POS"));
			
			_x setVariable ["wfbe_flag", _flag];
			
			//--- Initialize the camp.
			if (isNil {_x getVariable "sideID"}) then {_x setVariable ["sideID",RESISTANCEID,true]} else {_flag setFlagTexture (missionNamespace getVariable Format["WFBE_%1FLAG",(_x getVariable "sideID") Call GetSideFromID])};
			if (isNil {_x getVariable "supplyValue"}) then {
				waitUntil {sleep 0.05;!isNil {_town getVariable "supplyValue"}};
				_x setVariable ["supplyValue", _town getVariable "supplyValue", true];
				_x setVariable ["wfbe_camp_bunker", _townModel, true];
				[_x, _town, _flag] ExecFSM 'Server\FSM\server_town_camp.fsm';
			};
		} forEach _camps;
		
		waitUntil {sleep 0.05;townInitServer};

		//--- Town SV & Control script.
		[_town, _townRange] ExecFSM 'Server\FSM\server_town.fsm';

		//--- Main Town AI Script
		if (paramOccup) then {[_town, _townRange] ExecFSM 'Server\FSM\server_town_ai.fsm'};
			
		//--- Prepare the default defenses (if needed).
		if ((_town getVariable "sideID") != WFBE_C_UNKNOWN_ID) then {[_town, (_town getVariable "sideID") Call GetSideFromID] Spawn ManageTownDefenses};

		//--- UPSMON Area Definition.
		if (paramUPSMON) then {
			_marker = Format['UPSMON_TOWN_%1',str _town];
			createMarkerLocal [_marker, getPos _town];
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerShapeLocal "RECTANGLE";
			_marker setMarkerBrushLocal "BORDER";
			_size = 'WFBE_UPSMONTOWNAREASIZE' Call GetNamespace;
			_marker setMarkerSizeLocal [_size select 0,_size select 1];
			_marker setMarkerAlphaLocal 0;
		};
	};
	
	if (('WFBE_TOWNCONQUESTMODE' Call GetNamespace) > 0) then {
		_town setVariable ["wfbe_cancap_w", false];
		_town setVariable ["wfbe_cancap_e", false];
	};
};

//--- Client camp init.
if (local player) then {
	waitUntil {sleep 0.05;!isNil {_town getVariable "camps"}};
	
	_camps = _town getVariable "camps";
	for '_i' from 0 to count(_camps)-1 do {
		_camp = _camps select _i;
		_camp setVariable ["wfbe_camp_marker", Format ["WFBE_%1_CityMarker_Camp%2", str _town, _i]];
		_camp setVariable ["town", _town];
	};
};

towns = towns + [_town];