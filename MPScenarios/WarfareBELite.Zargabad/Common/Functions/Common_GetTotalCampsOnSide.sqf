Private ["_camps","_side","_sideID","_total","_town"];

_town = _this select 0;
_side = _this select 1;

_sideID = _side Call GetSideID;

_camps = _town getVariable "camps";
if (count _camps == 0) exitWith {1};

_total = 0;

{if ((_x getVariable "sideID") == _sideID) then {_total = _total + 1}} forEach _camps;

_total