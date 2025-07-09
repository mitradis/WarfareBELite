Private ['_array','_exist','_skip','_tent','_toWorld','_type','_z'];

_type = Format ["WFBE_%1FARP",sideJoinedText] Call GetNamespace;
_exist = WF_Logic getVariable Format ["%1MASH",sideJoinedText];
if !(isNull _exist) then {deleteVehicle _exist};

WFBE_SK_V_LastUse_MASH = time;

_skip = false;
for [{_z = 0},{_z < 7},{_z = _z + 1}] do {
	sleep 0.5;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 0.5;
	waitUntil {sleep 0.05;animationState player == "ainvpknlmstpslaywrfldnon_amovpknlmstpsraswrfldnon" || !alive player || vehicle player != player};
	if (!alive player || vehicle player != player) exitWith {_skip = true};
};

if (!_skip) then {
	_array = [((player worldToModel (getPos player)) select 0),((player worldToModel (getPos player)) select 1) + 10];
	_toWorld = player modelToWorld _array;
	_tent = _type createVehicle _toWorld;
	WF_Logic setVariable [Format["%1MASH",sideJoinedText],_tent,true];
	_tent addAction ["<t color='#f8d664'>" + localize 'STR_WF_ACTION_UndeployMASH'+ "</t>", "Client\Module\Skill\Actions\Officer_Undeploy_MASH.sqf", [], 75, false, true, "", "alive _target && time - WFBE_SK_V_LastUse_MASH > 240"];
} else {
	WF_Logic setVariable [Format["%1MASH",sideJoinedText],objNull,true];
};