Private ["_blackListID","_id"];
_id = getPlayerUID (_this select 0);

//--- Griefers ID.
_blackListID = [
"4837314",
"12051782",
"7148678",
"4139392",
"4094594",
"2992070",
"823297"
];

if (_id in _blackListID) then {true} else {false};