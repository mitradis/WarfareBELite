Private["_class","_label","_structure"];

_structure = _this Select 0;

_label = "";
_class = TypeOf _structure;

if (_class == EASTBAR || _class == WESTBAR) then {_label = "B"};
if (_class == EASTLVF || _class == WESTLVF) then {_label = "L"};
if (_class == EASTCC || _class == WESTCC) then {_label = "C"};
if (_class == EASTHEAVY || _class == WESTHEAVY) then {_label = "H"};
if (_class == EASTAIR || _class == WESTAIR) then {_label = "A"};
if (_class == EASTSP || _class == WESTSP) then {_label = "S"};
if (_class == EASTAAR || _class == WESTAAR) then {_label = "AAR"};

_label