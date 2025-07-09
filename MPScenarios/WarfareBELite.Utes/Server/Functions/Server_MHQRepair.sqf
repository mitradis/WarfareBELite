Private ["_commanderTeam","_direction","_hq","_HQName","_MHQ","_position","_side","_sideID","_sideText"];

_side = _this select 0;
_sideText = str _side;
_sideID = (_side) Call GetSideID;

_hq = (_sideText) Call GetSideHQ;
_position = getPos _hq;
_direction = getDir _hq;

_commanderTeam = (_side) Call GetCommanderTeam;
if !(isNull _commanderTeam) then {
	// WFBE_SetHQStatus = [vehicleVarName (leader _commanderTeam),'CLTFNCSETHQSTATUS',false];
	// publicVariable 'WFBE_SetHQStatus';
	// if (isHostedServer) then {[vehicleVarName (leader _commanderTeam),'CLTFNCSETHQSTATUS',false] Spawn HandlePVF};
	if (isPlayer (leader _commanderTeam)) then {[getPlayerUID(leader _commanderTeam), "SetHQStatus", false] Call SendToClients};
};

sleep 15;

_MHQ = [Format["WFBE_%1MHQNAME",_sideText] Call GetNamespace, _position, _sideID, false, false] Call CreateVehi;
_MHQ setDir _direction;
_MHQ setVelocity [0,0,-1];

Call Compile Format ["%1MHQ = _MHQ; publicVariable '%1MHQ';",_sideText];
Call Compile Format ["_MHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];", _side, typeOf _MHQ];

deleteVehicle _hq;

Call Compile Format ["%1MHQDeployed = false; publicVariable '%1MHQDeployed';",_sideText];
WF_Logic setVariable [Format ["%1MHQRepair",_sideText],false,true];

