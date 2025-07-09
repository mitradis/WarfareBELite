Private ['_building','_dammages','_origin','_side','_sideBuilding','_side'];

_building = _this select 0;
_dammages = _this select 1;
_origin = _this select 2;
_sideBuilding = _this select 3;

_side = civilian;
if (side _origin == sideEnemy) then {
	if (_origin isKindOf westSoldierBaseClass) then {_side = west};
	if (_origin isKindOf eastSoldierBaseClass) then {_side = east};
} else {
	_side = side _origin;
};

if (_sideBuilding == _side) then {
	_dammages = false;
} else {
	_dammages = [_building, _dammages] Call HandleBuildingDamage;
};

_dammages