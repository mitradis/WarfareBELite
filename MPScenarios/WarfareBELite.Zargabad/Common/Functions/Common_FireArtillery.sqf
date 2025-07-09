Private["_ammo","_angle","_artillery","_burst","_destination","_dispersion","_direction","_distance","_FEH","_gunner","_i","_index","_minRange","_maxRange","_position","_radius","_reloadTime","_side","_type","_velocity","_watchPosition","_weapon","_xcoord","_ycoord"];

_artillery = _this select 0;
_destination = _this select 1;
_side = _this select 2;
_radius = _this select 3;
_index = _this select 4;

_gunner = gunner _artillery;
if (_index == -1) exitWith {};
if (isNull _gunner) exitWith {};
if (isPlayer _gunner) exitWith {};

_minRange = (Format ["WFBE_%1_ARTILLERY_MINRANGES",_side] Call GetNamespace) select _index;
_maxRange = (Format ["WFBE_%1_ARTILLERY_MAXRANGES",_side] Call GetNamespace) select _index;
_weapon = (Format ["WFBE_%1_ARTILLERY_WEAPONS",_side] Call GetNamespace) select _index;
_ammo = (Format ["WFBE_%1_ARTILLERY_AMMOS",_side] Call GetNamespace) select _index;
_velocity = (Format ["WFBE_%1_ARTILLERY_VELOCITIES",_side] Call GetNamespace) select _index;
_dispersion = (Format ["WFBE_%1_ARTILLERY_DISPERSIONS",_side] Call GetNamespace) select _index;

//--- Move function to global later on.
if (local player) then {[_artillery] Call ARTY_Prep};

//--- Artillery Calculations.
_position = getPos _artillery;
_xcoord = (_destination select 0) - (_position select 0);
_ycoord = (_destination select 1) - (_position select 1);
_direction =  -(((_ycoord atan2 _xcoord) + 270) % 360);
if (_direction < 0) then {_direction = _direction + 360};
_distance = sqrt ((_xcoord ^ 2) + (_ycoord ^ 2)) - _minRange;
_angle = _distance / (_maxRange - _minRange) * 100 + 15;
if (_angle > 70) then {_angle = 70};
if (_distance < 0 || _distance + _minRange > _maxRange) exitWith {};

_FEH = Call Compile Format ["_artillery addEventHandler ['Fired',{[_this select 4,_this select 6,%1,%2,%3,%4,%5,%6,%7,%8,%9] Spawn HandleArtillery}];",_ammo,_destination,_velocity,_dispersion,getPos _artillery,_distance,_radius,_maxRange,sideJoinedText];

{_gunner disableAI _x} forEach ['ANIM','MOVE','TARGET','AUTOTARGET'];
_watchPosition = [_destination select 0, _destination select 1, (_artillery distance _destination)/(tan(90-_angle))];
(_gunner) doWatch _watchPosition;

sleep 10;
if !(alive (_gunner)) exitWith {if !(isNull _artillery) then {_artillery removeEventHandler ['Fired',_FEH]}};
if !(alive _artillery) exitWith {
	if (alive (_gunner)) then {{_gunner enableAI _x} forEach ['ANIM','MOVE','TARGET','AUTOTARGET']};
};

_reloadTime = (Format ["WFBE_%1_ARTILLERY_RELOADTIME",_side] Call GetNamespace) select _index;
_burst = (Format ["WFBE_%1_ARTILLERY_BURST",_side] Call GetNamespace) select _index;

for [{_i = 0},{_i < _burst},{_i = _i + 1}] do {
	sleep _reloadTime;
	if (!alive (_gunner) || !alive _artillery) exitWith {};
	
	_artillery fire _weapon;
};

sleep 1;

if !(isNull _artillery) then {_artillery removeEventHandler ['Fired',_FEH]};

sleep _reloadTime;

if (alive (_gunner)) then {{_gunner enableAI _x} forEach ['ANIM','MOVE','TARGET','AUTOTARGET']};

if (local player) then {[_artillery] Call ARTY_Finish};