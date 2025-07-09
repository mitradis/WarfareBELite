/*
	Update the target combobox of the gear menu according to the players unit.
*/

Private ["_add","_camp_gear_enabled","_gear_mode","_near","_range","_structures","_target","_temp","_unit","_units","_vehicles"];
_target = _this;

lbClear 503004;
_temp = if (WFBE_Client_IsLeader) then {(units player) Call GetLiveUnits} else {[player]};
_units = [];
_vehicles = [];
_structures = (WFBE_Client_SideJoined) Call GetSideStructures;
// _near = ([_structures, objNull, ["Barracks"]] Call WFBE_CO_FNC_GetStructuresByKind) select 0;

// _near = if (isNull (['BARRACKSTYPE',_buildings,_purchaseRange,sideJoined,player] Call BuildingInRange)) then {false} else {true};
_near = [sideJoined, Format ["WFBE_%1%2",sideJoinedText,'BARRACKSTYPE'] Call GetNamespace, _structures] Call GetFactories;

_gear_mode = missionNamespace getVariable "WFBE_TOWNGEAR";
_camp_gear_enabled = if (_gear_mode in [1,2,3]) then {true} else {false};

{
	_unit = _x;
	_add = false;
	if (count _near > 0) then {
		{if (_x distance (vehicle _unit) < (missionNamespace getVariable "WFBE_PURCHASEGEARRANGE")) exitWith {_add = true}} forEach _near;
	};
	if (_camp_gear_enabled && !_add) then {
		_range = if (_unit == player) then {missionNamespace getVariable "WFBE_PURCHASEGEARFIELDRANGE"} else {missionNamespace getVariable "WFBE_PURCHASEGEARFIELDRANGE_AI"};
		_nObject = objNull;
		switch (_gear_mode) do { 
			case 1:{_nObject = [vehicle _unit, _range] Call GetClosestCamp}; 
			case 2:{_nObject = [vehicle _unit, _range] Call GetClosestDepot}; 
			case 3:{{if !(isNull _x) exitWith {_nObject = _x}} forEach [[vehicle _unit, _range] Call GetClosestCamp, [vehicle _unit, _range] Call GetClosestDepot]}; 
		};
		if !(isNull _nObject) then {_add = true};
	};
	if (_add) then {[_units, _unit] Call ArrayPush};
} forEach _temp;

{if (local _x) then {[_vehicles, _x] Call ArrayPush}} forEach ((vehicle player) nearEntities [["Car","Motorcycle","Tank","Ship","Air"], missionNamespace getVariable "WFBE_C_PLAYERS_GEAR_VEHICLE_RANGE"]);

_temp = _units + _vehicles;
if (count _temp == 0) then {_temp = [player]};
for '_i' from 0 to count(_temp)-1 do {
	_unit = _temp select _i;
	_label = if (_unit isKindOf "Man") then {Format["[%1] %2",(_unit) Call GetAIID, name _unit]} else {getText(configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")};
	lbAdd[503004, _label];
	if (_unit == _target) then {lbSetCurSel [503004, _i]};
};

if (lbCurSel(503004) == -1) then {lbSetCurSel[503004, 0]};
_temp