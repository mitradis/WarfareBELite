if (!isserver) exitWith {};

//Waits until UPSMON is init
waitUntil {sleep 0.05;!isNil("KRON_UPS_INIT")};
waitUntil {sleep 0.05;KRON_UPS_INIT==1};

private ["_artillery","_smoke1","_i","_area","_position","_maxcadence","_mincadence","_sleep","_rounds"];
_range = 800;
_area = 150;
_maxcadence = 10;
_mincadence = 5;
_sleep = 0;
_rounds = 1;
_bullet = "ARTY_Sh_81_HE";
_vector =[];
_artillery  = _this select 0;

if (isnull _artillery || !alive _artillery) exitwith{};
if ((count _this) > 1) then {_rounds = _this select 1;};
if ((count _this) > 2) then {_range = _this select 2;};
if ((count _this) > 3) then {_area = _this select 3;};
if ((count _this) > 4) then {_maxcadence = _this select 4;};
if ((count _this) > 5) then {_mincadence = _this select 5;};
if ((count _this) > 6) then {_bullet = _this select 6;};

//Add artillery to array of artilleries
_vector = [_artillery,_rounds,_range,_area,_maxcadence,_mincadence,_bullet];
if (isnil "KRON_UPS_ARTILLERY_UNITS" ) then  {KRON_UPS_ARTILLERY_UNITS = []};
KRON_UPS_ARTILLERY_UNITS = KRON_UPS_ARTILLERY_UNITS + [_vector];

if (true) exitwith{};
