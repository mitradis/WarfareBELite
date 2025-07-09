Private["_canJoin","_get","_name","_side","_sideOrigin","_uid","_varname"];

_uid = _this select 0;
_side = _this select 1;
_name = _this select 2;
_varname = _this select 3;

_canJoin = true;

_get = Format["WFBE_JIP_USER%1",_uid] Call GetNamespace;

if !(isNil '_get') then {
	_sideOrigin = _get select 3;
	
	if (_sideOrigin != _side) then {
		if !(paramShowUID) then {_uid = "xxxxxxx"};
	
		// WFBE_LocalizeMessage = [nil,'CLTFNCLOCALIZEMESSAGE',['Teamswap',_name,_uid,_sideOrigin,_side]];
		// publicVariable 'WFBE_LocalizeMessage';
		[nil, "LocalizeMessage", ['Teamswap',_name,_uid,_sideOrigin,_side]] Call SendToClients;
		
		_canJoin = false;
	};
};
// [_varname, "CanJoin", [_varname,_canJoin]] Call SendToClients;

// WFBE_CanJoin = [_uid,'CLTFNCCANJOIN',[_varname,_canJoin]];
// publicVariable 'WFBE_CanJoin';
[_uid, "CanJoin", [_varname,_canJoin]] Call SendToClients;