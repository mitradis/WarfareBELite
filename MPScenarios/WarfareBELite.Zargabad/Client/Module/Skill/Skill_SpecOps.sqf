Private ['_min','_skip','_vehicle','_vehicles','_z'];

_vehicles = player nearEntities [["Car","Motorcycle","Tank","Ship","Air"],5];
if (count _vehicles < 1) exitWith {};

_vehicle = [player,_vehicles] Call GetClosestEntity;

if (!locked _vehicle) exitWith {};

WFBE_SK_V_LastUse_Lockpick = time;

_skip = false;
for [{_z = 0},{_z < 2},{_z = _z + 1}] do {
	sleep 0.5;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 0.5;
	waitUntil {sleep 0.05;animationState player == "ainvpknlmstpslaywrfldnon_amovpknlmstpsraswrfldnon" || !alive player || vehicle player != player || !alive _vehicle || _vehicle distance player > 5};
	if (!alive player || vehicle player != player || !alive _vehicle || _vehicle distance player > 5) exitWith {_skip = true};
};

if (!locked _vehicle) exitWith {};

if (!_skip) then {
	switch (typeOf _vehicle) do {
		case "Motorcycle": {_min = 75};
		case "Car": {_min = 50};
		case "Ship": {_min = 35};
		case "Tank": {_min = 25};
		case "Air": {_min = 15};
		default {_min = 30};
	};
	if ((random 100) <= _min) then {
		["RequestVehicleLock", [_vehicle, false]] Call SendToServer;
		hint (localize "STR_WF_INFO_Lockpick_Succeed");
	} else {
		hint (localize "STR_WF_INFO_Lockpick_Failed");
	};
};
