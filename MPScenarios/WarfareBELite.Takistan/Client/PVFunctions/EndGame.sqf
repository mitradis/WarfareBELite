Private["_blist","_side","_sideValue"];

_sideValue = _this select 0;
_blist = _this select 1;
gameOver = true;
WFBE_GameOver = true;
_side = east;
if (_sideValue == WESTID) then {_side = west};

[_side,_blist] ExecVM "Client\Client_EndGame.sqf";