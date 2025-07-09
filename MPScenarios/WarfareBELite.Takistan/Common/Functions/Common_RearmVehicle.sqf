Private['_amount','_config','_get','_isAir','_isArtillery','_magazines','_side','_turrets','_type','_vehicle'];

_vehicle = _this select 0;
_side = _this select 1;
_type = typeOf _vehicle;
_isAir = if (_vehicle isKindOf "Air") then {true} else {false};

/* Clear the vehicle */
_vehicle setVehicleAmmo 0;

/* Reload all turrets */
_turrets = [];
_config = configFile >> 'CfgVehicles' >> typeOf _vehicle >> 'Turrets';
_turrets = [_config] call GetTurretsMags;
[_vehicle,_turrets] Call SetTurretsMags;
/* Reload the driver (Special) */
_magazines = [configFile >> 'CfgVehicles' >> typeOf _vehicle] call GetVehicleMags;
{_vehicle addMagazineTurret[_x,[-1]]} forEach _magazines;

reload _vehicle;

/* Are we dealing with an artillery unit ? */
_isArtillery = -1;
if (_side == west || _side == east) then {_isArtillery = [_type,_side] Call IsArtillery};
if (_isArtillery != -1) then {[_vehicle,_isArtillery,_side] Call EquipArtillery};
