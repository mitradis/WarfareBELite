Private["_commanderTeam","_income","_incomeSystem","_side"];

_side = _this;
_incomeSystem = 'WFBE_INCOMESYSTEM' Call GetNamespace;
_income = (_side) Call GetTownsIncome;

switch (_incomeSystem) do {
	case 2: {_income = round(_income /2)};
	case 3: {
		Private["_ply"];
		_commanderTeam = (_side) Call GetCommanderTeam;
		if (isNull _commanderTeam) then {_commanderTeam = grpNull};
		_ply = round(_income * (((100 - (Call Compile Format ["%1CommanderPercent",_side]))/100)/maxPlayers));
		if (_commanderTeam == group player) then {
			_income = round((_income * ((Call Compile Format ["%1CommanderPercent",_side])/100)) / ('WFBE_INC_DIVIDE_COM' Call GetNamespace)) + _ply;
		} else {
			_income = _ply;
		};
	};
	case 4: {
		Private["_ply"];
		_commanderTeam = (_side) Call GetCommanderTeam;
		if (isNull _commanderTeam) then {_commanderTeam = grpNull};
		_ply = round(_income * (100 - (Call Compile Format ["%1CommanderPercent",_side])) / 100);
		if (_commanderTeam == group player) then {
			_income = _ply + round((_income - _ply)*maxPlayers);
		} else {
			_income = _ply;
		};
	};
};

_income