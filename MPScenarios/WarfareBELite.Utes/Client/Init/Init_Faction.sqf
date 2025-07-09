Private ['_c','_list','_r','_side','_type','_u'];
_type = _this select 0;
_side = _this select 1;
_list = _this select 2;

_r = [];
_u = [];

{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if !((_c select QUERYUNITFACTION) in _u) then {
			_r = _r + [(_c select QUERYUNITFACTION)];
			_u = _u + [(_c select QUERYUNITFACTION)];
		};
	};
} forEach _list;

[Format["WFBE_%1%2FACTIONS",_side,_type],_r,true] Call SetNamespace;