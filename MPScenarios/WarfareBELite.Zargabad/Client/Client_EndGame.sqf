Private ['_HQ','_base','_blist','_camShotOrder','_camera','_nvgstate','_position','_secTarget','_side','_track','_vehi'];

_side = _this select 0;
_blist = _this select 1;

[_side] ExecVM "Client\GUI\GUI_EndOfGameStats.sqf";
_track = if (WF_A2_Vanilla) then {["Track21_Rise_Of_The_Fallen",41]} else {["EP1_Track13",91]};
playMusic _track;
_base = WestMHQ;
_secTarget = EastMHQ;
if (_side == West) then {_base = EastMHQ;_secTarget = WestMHQ};
_position = getPos _base;

_blist = [_secTarget,_blist] Call SortByDistance;
_blist = [_secTarget] + _blist;

//--- Safety Pos.
_HQ = (sideJoinedText) Call GetSideHQ;
_vehi = vehicle player;
if (_vehi != player) then {player action ["EJECT", _vehi];_vehi = player};
_vehi setVelocity [0,0,-0.1];
_vehi setPos ([getPos _HQ,30,20] Call GetRandomPosition);

if (!isNil "DeathCamera") then {
	DeathCamera cameraEffect["TERMINATE","BACK"];
	camDestroy DeathCamera;
	"colorCorrections" ppEffectEnable false;
	"dynamicBlur" ppEffectEnable false;
};

_camera = "camera" camCreate _position;
_camera camSetDir 0;
_camera camSetFov 0.200;
_camera cameraEffect["Internal","back"];
_camera camSetTarget getPos _base;
_camera camSetRelPos [160.80,130.29,140.07];
_camera camCommit 0;
_nvgstate = if (daytime > 18.5 || daytime < 5.5) then {true} else {false};
camUseNVG _nvgstate;

waitUntil {sleep 0.05;camCommitted _camera};

_camera camSetRelPos [-190.71,190.55,180.94];
_camera camCommit 10;

waitUntil {sleep 0.05;camCommitted _camera};

_camShotOrder = [[0,100,35],[50,0,20],[0,-50,20],[-50,0,20]];

{
	_camera camSetPos getPos _x;
	_camera camSetTarget getPos _x;
	
	{
		_camera camSetRelPos _x;
		_camera camCommit 5;
		waitUntil {sleep 0.05;camCommitted _camera};
	} forEach _camShotOrder;
	
	_camera camSetRelPos [0,100,35];
	_camera camCommit 5;
	waitUntil {sleep 0.05;camCommitted _camera};
} forEach _blist;

sleep 3;
failMission "END1";