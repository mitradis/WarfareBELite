/*
	Global Public Variable Functions Initialization, this file initialize PVF files for both the client and the server
*/

scriptName "Common\Init\Init_PublicVariables.sqf";

Private ['_clientCommandPV','_l','_serverCommandPV'];

_l		= ["RequestVehicleLock"];
_l = _l + ["RequestChangeScore"];
_l = _l + ["RequestCommanderVote"];
_l = _l + ["RequestStructure"];
_l = _l + ["RequestDefense"];
_l = _l + ["RequestJoin"];
_l = _l + ["RequestMHQRepair"];
_l = _l + ["RequestSpecial"];
_l = _l + ["RequestTeamUpdate"];
_l = _l + ["RequestUpgrade"];
if (paramUseWorkers) then {_l = _l + ["RequestWorker"]};

_serverCommandPV = _l;

_l =      ["AllCampsCaptured"];
_l = _l + ["AwardBounty"];
_l = _l + ["CampCaptured"];
_l = _l + ["CanJoin"];
_l = _l + ["ChangeScore"];
_l = _l + ["CommanderVote"];
_l = _l + ["DisplayICBM"];
_l = _l + ["EndGame"];
_l = _l + ["LocalizeMessage"];
_l = _l + ["PerformAction"];
_l = _l + ["SetHQStatus"];
_l = _l + ["SetTask"];
_l = _l + ["SetVehicleLock"];
_l = _l + ["TownCaptured"];
_l = _l + ["UAV_Reveal"];
_l = _l + ["VoteForCommander"];

/* Add missions Clients PVF here */
if (paramSecondaryMissions) then {
	_l = _l + ['M_BASE_Attack'];
	_l = _l + ['M_TOWN_Attack'];
	_l = _l + ['M_UAV_RetrieveModule'];
	/* OA/CO Specific PVF */
	if !(WF_A2_Vanilla) then {
		_l = _l + ['M_PLAYERS_Attack_Air'];
	};
};

_clientCommandPV = _l;

{
	Call Compile Format["CLTFNC%1 = compile preprocessFileLineNumbers 'Client\PVFunctions\%1.sqf'", _x];
	if (isClient) then {Format['WFBE_PVF_%1',_x] addPublicVariableEventHandler {(_this select 1) Spawn HandlePVF}};
} forEach _clientCommandPV;

{
	Call Compile Format["SRVFNC%1 = compile preprocessFileLineNumbers 'Server\PVFunctions\%1.sqf'", _x];
	if (isServer) then {Format['WFBE_PVF_%1',_x] addPublicVariableEventHandler {(_this select 1) Spawn HandlePVFServer}};
} forEach _serverCommandPV;
