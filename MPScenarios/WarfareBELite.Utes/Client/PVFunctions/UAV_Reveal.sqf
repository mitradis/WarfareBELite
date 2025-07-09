Private ['_marker','_size','_target','_uav'];
_uav = _this select 0;
_target = _this select 1;

if (typeName _uav != 'OBJECT' || typeName _target != 'OBJECT') exitWith {};

_size = round((_uav distance _target) / 16);
_marker = Format["WFBE_UAV_SPOTTED_%1",unitMarker];
unitMarker = unitMarker + 1;
createMarkerLocal [_marker,[(getPos _target select 0) - random(_size) + random(_size),(getPos _target select 1) - random(_size) + random(_size),0]];
_marker setMarkerShapeLocal "Ellipse";
_marker setMarkerColorLocal "ColorOrange";
_marker setMarkerSizeLocal [_size,_size];

sleep (('WFBE_UAVSPOTTINGDELAY' Call GetNamespace)*3);

deleteMarkerLocal _marker;