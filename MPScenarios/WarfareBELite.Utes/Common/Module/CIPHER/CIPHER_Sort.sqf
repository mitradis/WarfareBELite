/* Elements to sort etc ... */

_preformat = {
	Private ["_get","_output","_units"];
	_units = _this;
	_output = [];

	for '_i' from 0 to count(_units)-1 do {
		_get = (_units select _i) Call GetNamespace;
		if !(isNil "_get") then {
			_output set [_i, _get select QUERYUNITLABEL];
		} else {
			_output set [_i, (_units select _i)];
		};
	};
	
	_output
};

_preformat_gear = {
	Private ["_content","_get","_output"];
	_content = _this select 0;
	_prefix = if (count _this > 1) then {_this select 1} else {""};
	_output = [];

	for '_i' from 0 to count(_content)-1 do {
		_get = missionNamespace getVariable Format ["%1%2",_prefix,(_content select _i)];
		if !(isNil "_get") then {
			_output set [_i, _get select 1];
		} else {
			_output set [_i, (_content select _i)];
		};
	};
	
	_output
};

//--- Sort Factions.
{
	_content = Format["WFBE_%1%2FACTIONS",sideJoinedText,_x] Call GetNamespace;
	if (count _content > 0)  then {
		_sorted = ([_content, false] Call CIPHER_SortArray) select 0;
		[Format['WFBE_%1%2FACTIONS',sideJoinedText,_x], _sorted, true] Call SetNamespace;
	}
} forEach ["BARRACKS","LIGHT","HEAVY","AIRCRAFT","AIRPORT","DEPOT"];

//--- Sort Purchases (Default, name - asc).
{
	_content = Format['WFBE_%1%2UNITS',sideJoinedText,_x] Call GetNamespace;
	if (count _content > 0)  then {
		_sorted = ([(_content) Call _preformat,false,_content] Call CIPHER_SortArray) select 1;
		[Format['WFBE_%1%2UNITS',sideJoinedText,_x], _sorted, true] Call SetNamespace;
	}
} forEach ["BARRACKS","LIGHT","HEAVY","AIRCRAFT","AIRPORT","DEPOT"];

//--- Sort Gear.
{
	_content = missionNamespace getVariable Format ["WFBE_%1_%2", sideJoinedText, _x];
	_sorted = ([[_content] Call _preformat_gear,false,_content] Call CIPHER_SortArray) select 1;
	missionNamespace setVariable [Format ["WFBE_%1_%2", sideJoinedText, _x], _sorted];
} forEach ["primary","secondary","pistols","equipment"];

_content = missionNamespace getVariable Format ["WFBE_%1_Magazines", sideJoinedText];
_sorted = ([[_content, "Mag_"] Call _preformat_gear,false,_content] Call CIPHER_SortArray) select 1;
missionNamespace setVariable [Format ["WFBE_%1_Magazines", sideJoinedText], _sorted];