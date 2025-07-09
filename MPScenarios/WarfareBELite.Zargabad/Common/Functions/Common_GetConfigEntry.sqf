private ["_config", "_entryName"];

_config = _this select 0;
_entryName = _this select 1;

//--- Validate parameters
if ((typeName _config) != (typeName configFile)) exitWith {nil};
if ((typeName _entryName) != (typeName "")) exitWith {nil};

private ["_entry", "_value"];
_entry = _config >> _entryName;

//--- If the entry is not found and we are not yet at the config root, explore the class' parent.
if (((configName (_config >> _entryName)) == "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
	[inheritsFrom _config, _entryName] call GetConfigEntry;
} else {
	//--- Supporting either Numbers or Strings, and array ofc!
	switch (true) do {
		case (isNumber _entry): {_value = getNumber _entry};
		case (isText _entry): {_value = getText _entry};
		case (isArray _entry): {_value = getArray _entry};
	};
};

//--- Make sure returning 'nil' works.
if (isNil "_value") exitWith {nil};
 
_value