Private ['_current','_find','_killer','_structure','_structures','_side','_tked','_type','_uid'];
_structure = _this select 0;
_killer = _this select 1;
_side = _this select 2;
_type = _this select 3;



//--- Building Teamkill.
if ((side _killer == _side)&&(isPlayer(_killer))) then {
	_uid = getPlayerUID _killer;
	if !(paramShowUID) then {_uid = "xxxxxxx"};
	_tked = [_type, 'displayName'] Call GetConfigInfo;
	// WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]];
	// publicVariable 'WFBE_LocalizeMessage';
	// if (isHostedServer) then {[_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]] Spawn HandlePVF};
	[_side, "LocalizeMessage", ['BuildingTeamkill',name _killer,_uid,_tked]] Call SendToClients;
};

//--- Decrement building limit.
_find = (Format ['WFBE_%1STRUCTURENAMES',_side] Call GetNamespace) find _type;
if (_find != -1) then {
	_current = Call Compile Format ['%1BuildingsCurrent',_side];
	_current set [_find - 1, (_current select (_find-1)) - 1];
	Call Compile Format ['%1BuildingsCurrent = _current',_side];
	publicVariable Format ['%1BuildingsCurrent',_side];
};

Call Compile Format ["%1BaseStructures = %1BaseStructures - [_structure] - [objNull]; publicVariable '%1BaseStructures';",str _side];

["Destroyed",_type,_side] Spawn SideMessage;

//--- Can be fixed with workers.
if (paramUseWorkers) then {
	Private ["_nearLogic","_position","_sold"];
	
	_sold = _structure getVariable "sold";
	
	if (isNil '_sold') then {
		//--- Grab the logic.
		_position = getPos _structure;
		_nearLogic = _position nearEntities [["LocationLogicStart"],15];
		_nearLogic = [_position, _nearLogic] Call GetClosestEntity;
		
		if (isNull _nearLogic) exitWith {};
		
		//--- Completed at 25% on destruction, dropping until it reach 0 (delete).
		_nearLogic setVariable ["WFBE_B_Completion", 25];
		//--- The ratio gets lower after each destruction.
		_nearLogic setVariable ["WFBE_B_CompletionRatio", (_nearLogic getVariable "WFBE_B_CompletionRatio")*0.8];
		//--- Can be repaired.
		_nearLogic setVariable ["WFBE_B_Repair", true];
		
		[Format ["WFBE_WORKERS_%1LOGIC",str _side],((Format ["WFBE_WORKERS_%1LOGIC",str _side]) Call GetNamespace) + [_nearLogic],true] Call SetNamespace;
		
		[_nearLogic, typeOf _structure, _side, _find - 1] Spawn HandleBuildingRepair;
	};
};

sleep 10;

deleteVehicle _structure;
