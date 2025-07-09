Private['_get','_lb','_type'];
_lb = _this select 0;
_type = _this select 1;

lbClear _lb;
{
	lbAdd [_lb,_x];
} forEach (Format["WFBE_%1%2FACTIONS",sideJoinedText,_type] Call GetNamespace);

_get = Format["WFBE_%1%2CURRENTFACTIONSELECTED",sideJoinedText,_type] Call GetNamespace;
if (isNil '_get') then {
	lbSetCurSel [_lb,0];
} else {
	lbSetCurSel [_lb,_get];
};