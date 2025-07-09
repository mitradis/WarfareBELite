Private ['_delay','_range','_sensitivity','_uav'];

_uav = _this select 0;
_delay = 'WFBE_UAVSPOTTINGDELAY' Call GetNamespace;
_range = 'WFBE_UAVSPOTTINGRANGE' Call GetNamespace;
_sensitivity = 'WFBE_UAVSPOTTINGDETECTION' Call GetNamespace;

while {true} do {
	sleep _delay;
	if (!alive _uav || isNull _uav) exitWith {};
	
	{
		if (_uav knowsAbout _x > _sensitivity && side _x != sideJoined && side _x != civilian) then {
			sleep 0.5;
			// WFBE_UAV_Reveal = [sideJoined,'CLTFNCUAV_REVEAL',[_uav,_x]];
			// publicVariable 'WFBE_UAV_Reveal';
			// if (isHostedServer) then {[sideJoined,'CLTFNCUAV_REVEAL',[_uav,_x]] Spawn HandlePVF};
			[sideJoined, "UAV_Reveal", [_uav,_x]] Call SendToClients;
		};
	} forEach (_uav nearEntities _range);
};
