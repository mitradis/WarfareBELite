Private ["_index","_index2","_name","_side","_sideText","_time","_upgrades","_upgrades_old"];
_time = _this select 0;
_index = _this select 1;
_index2 = _this select 2;
_name = _this select 3;
_side = _this select 4;
_sideText = Str _side;

Call Compile Format ["WFBE_%1_Upgrading = true; publicVariable 'WFBE_%1_Upgrading';",_sideText];

_upgrades_old = (_sideText) Call GetSideUpgrades;

sleep _time;

_upgrades = (_sideText) Call GetSideUpgrades;

//--- Failover due to faulty pv.
for '_i' from 0 to count _upgrades_old do {
	if ((_upgrades_old select _i) != (_upgrades select _i)) then {_upgrades set [_i, (_upgrades_old select _i)]};
};

_upgrades set [_index2,_index + 1];
Call Compile Format ["%1Upgrades = _upgrades; publicVariable '%1Upgrades';",_sideText];

// WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['UpgradeComplete',_index2,(_index + 1)]];
// publicVariable 'WFBE_LocalizeMessage';
// if (isHostedServer) then {[_side,'CLTFNCLOCALIZEMESSAGE',['UpgradeComplete',_index2,(_index + 1)]] Spawn HandlePVF};
[_side, "LocalizeMessage", ['UpgradeComplete',_index2,(_index + 1)]] Call SendToClients;

[Format["WFBE_%1_Upgrading",_sideText],false,true] Call SetNamespace;

["NewIntelAvailable","",_side,""] Spawn SideMessage;

Call Compile Format ["WFBE_%1_Upgrading = false; publicVariable 'WFBE_%1_Upgrading';",_sideText];
