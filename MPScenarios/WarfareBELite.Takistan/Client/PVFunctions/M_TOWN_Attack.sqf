Private ['_cpt','_exit','_groups','_id','_label','_marker','_markers','_properPos','_size','_task','_town','_townPos'];

_size = _this select 0;
_label = _this select 1;
_id = _this select 2;
_town = _this select 3;
_groups = _this select 4;

_marker = Format["%1%2",_label,_id];
//--- Does the client already have the mission (jip handler, some client joining won't have it running)?
if (((getMarkerPos _marker) select 0) != 0 && ((getMarkerPos _marker) select 1) != 0) exitWith {};

_townPos = getPos _town;
_properPos = [(_townPos select 0)-(_size / 2),(_townPos select 1)-(_size / 2)];

//--- Inform the player about a new task.
taskHint [format [localize "str_taskNew" + "\n%1",Format[localize 'STR_WF_M_TOWN_Attack',_town getVariable "name"]], [1,1,1,1], "taskNew"];

//--- Task.
_task = player createSimpleTask [Format["TSK_M_%1%2",_label,_id]];
_task setSimpleTaskDescription [Format[localize 'STR_WF_M_TOWN_Attack_Description',_town getVariable "name"], Format[localize 'STR_WF_M_TOWN_Attack',_town getVariable "name"], Format[localize 'STR_WF_M_TOWN_Attack',_town getVariable "name"]];
_task setSimpleTaskDestination _properPos;

//--- Marker part.
_markers = [_marker];
createMarkerLocal [_marker, _townPos];
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerBrushLocal "BORDER";
_marker setMarkerSizeLocal [_size,_size];
_marker = Format["0%1%2",_label,_id];
_markers = _markers + [_marker];
createMarkerLocal [_marker, _townPos];
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerBrushLocal "FDIAGONAL";
_marker setMarkerSizeLocal [_size,_size];
_marker = Format["00%1%2",_label,_id];
_markers = _markers + [_marker];
createMarkerLocal [_marker, _properPos];
_marker setMarkerColorLocal "ColorRedAlpha";
_marker setMarkerTypeLocal "mil_marker";
_marker setMarkerSizeLocal [0.5,0.5];
_marker setMarkerTextLocal localize "STR_WF_TACTICAL_TargetedArea";

//--- Wait for the unit to be spawned.
waitUntil {
	sleep 1;
	
	_exit = false;
	{
		if (count (units _x) > 0) then {_exit = true};
	} forEach _groups;
	
	_exit
};

//--- Mission run while the enemies are here.
waitUntil {
	sleep 1;

	_cpt = 0;
	{
		if !(isNil '_x') then {
			_cpt = _cpt + (count ((units _x) Call GetLiveUnits));
		};
	} forEach _groups;
	
	_cpt == 0
};

sleep 10;

//--- Validate the mission for the player.
_task setTaskState 'Succeeded';
taskHint [format [localize "str_taskAccomplished" + "\n%1", Format[localize 'STR_WF_M_TOWN_Attack',_town getVariable "name"]], [1,1,1,1], "taskDone"];

{_x setMarkerColorLocal "ColorGreenAlpha"} forEach _markers;

sleep 30;

//--- Remove the task & markers.
player removeSimpleTask _task;
{deleteMarkerLocal _x} forEach _markers;