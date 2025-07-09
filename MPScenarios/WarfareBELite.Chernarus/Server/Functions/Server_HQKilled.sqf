Private ["_deployed","_dir","_hq","_HQName","_killer","_kname","_kuid","_MHQ","_pos","_side","_tked","_type","_uid"];
_hq = _this select 0;
_killer = _this select 1;
_side = _this select 2;
_type = _this select 3;

_pos = getPos _hq;
_dir = getDir _hq;
_kuid = if (isPlayer _killer) then {getPlayerUID _killer} else {'0'};
_kname = name _killer;

_deployed = (str _side) Call GetSideHQDeployed;



//--- Building Teamkill.
if ((side _killer == _side)&&(isPlayer(_killer))) then {
	_uid = if !(paramShowUID) then {_uid = 'xxxxxxx'} else {_kuid};
	_tked = [_type, 'displayName'] Call GetConfigInfo;
	// WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]];
	// publicVariable 'WFBE_LocalizeMessage';
	// if (isHostedServer) then {[_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]] Spawn HandlePVF};
	[_side, "LocalizeMessage", ['BuildingTeamkill',name _killer,_uid,_tked]] Call SendToClients;
	
	
};

sleep (random 2);
if (_deployed) then {
	_HQName = Format["WFBE_%1MHQNAME",_side] Call GetNamespace;
	_MHQ = _HQName createVehicle _pos;
	_MHQ setDir _dir;
	_MHQ setDammage 1;

	Call Compile Format ["%1MHQ = _MHQ; %1MHQDeployed = false; publicVariable '%1MHQ'; publicVariable '%1MHQDeployed';",str _side];
};

if (_type == WESTHQ) then {_type = 'WFBE_WESTMHQNAME' Call GetNamespace};
if (_type == EASTHQ) then {_type = 'WFBE_EASTMHQNAME' Call GetNamespace};
['Destroyed',_type,_side] Spawn SideMessage;
