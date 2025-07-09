Private ["_ammo","_irLock","_missile","_source","_unit"];
_unit = _this select 0;
_ammo = _this select 1;
_source = _this select 2;

_missile = nearestObject [_source,_ammo];
if (isNull _missile) exitWith {};

//--- Get the ammo type.
_irLock = getNumber(configFile >> "CfgAmmo" >> _ammo >> "irLock");

//--- IR Lock is affected
if (_irLock == 1) then {
	_distance = _unit distance _source;
	
	_limit = 'WFBE_INCOMINGMISSILEMAXRANGE' Call GetNamespace;
	
	if (_distance > _limit) then {
		waitUntil {sleep 0.05;_missile distance _source > _limit};
		deleteVehicle _missile;
	};
};