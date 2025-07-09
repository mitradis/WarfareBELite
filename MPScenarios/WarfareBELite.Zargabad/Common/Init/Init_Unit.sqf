Private ["_isMan","_side","_sideID","_unit","_unit_kind","_upgrades"];

_unit = _this select 0;
_sideID = _this select 1;
_unit_kind = typeOf _unit;

//--- Abort if the unit is null or dead.
if !(alive _unit) exitWith {};

//--- Wait for the common part.
waitUntil {sleep 0.05;!(isNil 'commonInitComplete')};
waitUntil {sleep 0.05;commonInitComplete};

_side = (_sideID) Call GetSideFromID;

//--- We don't need the server to process it.
if !(local player) exitWith {};

//--- Wait for the client part.
waitUntil {sleep 0.05;clientInitComplete};

//--- Wait a bit.
sleep 2;

_isMan = if (_unit isKindOf 'Man') then {true} else {false};
_upgrades = (sideJoinedText) Call GetSideUpgrades;

// --- 				[Generic Vehicle initialization] (Run on all clients)

//--- Units that can lift vehicles.
waitUntil {sleep 0.05;!(isNil 'Zeta_Lifter')};
if (_unit_kind in Zeta_Lifter) then {
	if (_upgrades select 8 > 0) then {_unit addAction [localize "STR_WF_Lift", 'Client\Module\ZetaCargo\Zeta_Hook.sqf']};
};

//--- Repair Trucks.
if (_unit_kind in (Format['WFBE_%1REPAIRTRUCKS',sideJoinedText] Call GetNamespace)) then {
	//--- Build action.
	_unit addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', Format['side player == side _target && alive _target && player distance _target <= %1', 'WFBE_REPAIRTRUCKRANGE' Call GetNamespace]];
	
	//--- Repair camps.
	if (paramKeepCamps) then {
		_unit addAction [localize 'STR_WF_Repair_Camp','Client\Action\Action_RepairCamp.sqf', [], 97, false, true, '', 'alive _target'];
	};
	
	//--- Repair HQ Ability.
	if (('WFBE_VICTORYCONDITION' Call GetNamespace) != 1) then {
		//--- Repair MHQ action.
		_unit addAction [localize 'STR_WF_Repair_MHQ','Client\Action\Action_RepairMHQ.sqf', [], 98, false, true, '', 'alive _target'];
	};
};

//--- Boats.
if (_unit isKindOf "Ship") then {
	//--- Push action.
	_unit addAction [localize "STR_WF_Push","Client\Action\Action_Push.sqf", [], 93, false, true, "", 'driver _target == _this && alive _target && speed _target < 30'];
};

//--- Air units.
if (_unit isKindOf "Air") then {
	//--- Transporters only.
	if ((getNumber (configFile >> 'CfgVehicles' >> _unit_kind >> 'transportSoldier')) > 0) then {
		//--- HALO action.
		_unit addAction ['HALO','Client\Action\Action_HALO.sqf', [], 97, false, true, '', Format['getPos _target select 2 >= %1 && alive _target', 'WFBE_HALOJUMPHEIGHT' Call GetNamespace]];
		//--- Cargo Eject action.
		_unit addAction [localize 'STR_WF_Cargo_Eject','Client\Action\Action_EjectCargo.sqf', [], 99, false, true, '', 'driver _target == _this && alive _target'];
	};
	
	//--- AAR Tracking.
	if (paramAARadar) then {
		//--- Track the unit via AAR System, skip if the unit side is the same as the player one.
		if (sideJoined != _side) then {
			[_unit, _side] ExecVM 'Common\Common_AARadarMarkerUpdate.sqf';
		};
	};
	
	//--- Planes.
	if (_unit isKindOf "Plane") then {
		_unit addAction [localize "STR_WF_TaxiReverse","Client\Action\Action_TaxiReverse.sqf", [], 92, false, true, "", 'driver _target == _this && alive _target && speed _target < 4 && speed _target > -4 && getPos _target select 2 < 4'];
	};
};

//--- Vehicle Specific.
if !(_isMan) then {
	//--- Max missile range.
	if (('WFBE_INCOMINGMISSILEMAXRANGE' Call GetNamespace) != 0) then {
		//--- Handle incoming missiles.
		_unit addEventHandler ['incomingMissile', {_this Spawn HandleIncomingMissile}];
	};
	
	//--- Only run on non-vanilla versions.
	if !(WF_A2_Vanilla) then {
		//--- Call Compile the variable to prevent code errors. Disable TI.
		if (('WFBE_THERMALIMAGING' Call GetNamespace) < 2) then {Call Compile '_unit disableTIEquipment true;'};
	};
};

// --- 				[Side specific initialization] (Run on the desired client team).
if (sideID != _sideID) exitWith {};

Private ["_color","_markerName","_params","_size","_txt","_type"];

//--- Map Marker tracking.
_type = "Vehicle";
_color = missionNamespace getVariable (Format ["WFBE_C_%1_COLOR", _side]);
_size = [5,5];
_txt = "";
_params = [];

unitMarker = unitMarker + 1;
_markerName = Format ["unitMarker%1", unitMarker];

if (_isMan) then {
	//--- Man.
	_type = "mil_dot";
	_size = [0.5,0.5];
	if (group _unit == group player) then {
		_color = "ColorOrange";
		_txt = (_unit) Call GetAIDigit;
	};
	_params = [_type,_color,_size,_txt,_markerName,_unit,1,true,"DestroyedVehicle",_color,false,_side,[1,1]];
} else {
	//--- Vehicle.
	if (local _unit && isMultiplayer) then {_color = "ColorOrange"};
	if ((typeOf _unit) in (Format['WFBE_%1SUPPLYTRUCKS',str _side] Call GetNamespace)) then {_type = "SupplyVehicle";_size = [1,1]};//--- Supply.
	if ((typeOf _unit) in (Format['WFBE_%1REPAIRTRUCKS',str _side] Call GetNamespace)) then {_type = "RepairVehicle"};//--- Repair.
	_params = [_type,_color,_size,_txt,_markerName,_unit,1,true,"DestroyedVehicle",_color,false,_side,[2,2]];
	if (_unit == ((_side) Call GetSideHQ)) then {_params = ['Headquarters',_color,[1,1],'','HQUndeployed',_unit,1,false,'','',false,_side]};//--- HQ.
};

_params Spawn MarkerUpdate;