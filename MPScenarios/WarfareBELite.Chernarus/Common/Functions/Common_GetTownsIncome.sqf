Private ["_income","_incomeCoef","_incomeSystem","_side"];
_side = (_this) Call GetSideID;

_income = 0;
_incomeSystem = 'WFBE_INCOMESYSTEM' Call GetNamespace;
_incomeCoef = 0;
if (_incomeSystem == 3) then {_incomeCoef = 'WFBE_INC_COEFFICIENT' Call GetNamespace};

{
	if ((_x getVariable "sideID") == _side) then {
		switch (_incomeSystem) do {
			case 3: {_income = _income + ((_x getVariable "supplyValue")*_incomeCoef)};
			default {_income = _income + (_x getVariable "supplyValue")};
		};
	};
} forEach towns;

_income