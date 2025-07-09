Private["_group","_index","_model","_models","_position","_side","_unit"];

_side = _this select 0;
_position = _this select 1;
_index = _this select 2;

_models = Format ["WFBE_WORKERS_MODELS_%1",str _side] Call GetNamespace;
_model = _models select (round(random((count _models)-1)));
_group = createGroup _side;
_position = [getPos _position, 30] Call GetRandomPosition;
_unit = [_model,_group,_position,_side] Call CreateMan;

_group setSpeedMode "LIMITED";

_workers = Call Compile Format ["WF_%1Workers",str _side];
_workers set [_index, _unit];
Call Compile Format ["WF_%1Workers = _workers; publicVariable 'WF_%1Workers';",str _side];

[_unit,_side,_index] ExecFSM "Server\FSM\workers.fsm";