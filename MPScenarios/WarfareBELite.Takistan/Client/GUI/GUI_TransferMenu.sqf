scriptName "Client\GUI\GUI_TransferMenu.sqf";

//--- Register the UI.
uiNamespace setVariable ["wfbe_display_transfer", _this select 0];

{
	lnbAddRow[505001, [Format ["$%1.",_x Call GetTeamFunds],name leader (_x)]];
} forEach WFBE_Client_Teams;

_funds_last = -1;
_last_update = time;
_update_slider = true;

WFBE_MenuAction = -1;

while {alive player && dialog} do {
	if (WFBE_MenuAction == 2) then {WFBE_MenuAction = -1; _update_slider = true};
	
	_funds = Call GetPlayerFunds;
	
	if (time - _last_update > 1) then {
		_last_update = time;
		for '_i' from 0 to WFBE_Client_Teams_Count do {
			_funds_team = (WFBE_Client_Teams select _i) Call GetTeamFunds;
			_name_leader = name(leader(WFBE_Client_Teams select _i));
			if ((((uiNamespace getVariable "wfbe_display_transfer") displayCtrl 505001) lnbText [_i, 0]) != Format["$%1.",_funds_team]) then {lnbSetText [505001, [_i, 0], Format ["$%1.",_funds_team]]};
			if ((((uiNamespace getVariable "wfbe_display_transfer") displayCtrl 505001) lnbText [_i, 1]) != _name_leader) then {lnbSetText [505001, [_i, 1], _name_leader]};
		};
		//reload if everyone funds is different, reload on timer or fund transfer.
	};
	
	if (_update_slider) then {
		_update_slider = false;
		ctrlSetText[505003, str (floor (sliderPosition 505002))];
	};
	
	if (WFBE_MenuAction == 1) then {
		WFBE_MenuAction = -1;
		_ui_lnb_currow = lnbCurSelRow 505001;
		_funds_transfering = floor parseNumber(ctrlText 505003);
		_cando = if (_funds_transfering > 0 && _funds_transfering <= _funds) then {true} else {false};
		if (_cando) then {
			if (_ui_lnb_currow != -1) then {
				_selected = WFBE_Client_Teams select _ui_lnb_currow;
				if (_selected != group player) then {
					hint parseText format [localize "STR_WF_INFO_Funds_Sent", _funds_transfering, name leader _selected]; 
					-(_funds_transfering) Call ChangePlayerFunds;
					[_selected, _funds_transfering] Call ChangeTeamFunds;
					if (isPlayer leader _selected) then {[getPlayerUID(_selected), "LocalizeMessage",['FundsTransfer',_funds_transfering,name player]] Call SendToClients};
					_funds = Call GetPlayerFunds;
					_last_update = -1;
				} else {
					hint parseText localize "STR_WF_INFO_Funds_Self";
				};
			};
		} else {
			_update_slider = true;
		};
	};
	
	if (_funds != _funds_last) then {
		sliderSetRange[505002, 0, _funds];
		((uiNamespace getVariable "wfbe_display_transfer") displayCtrl 505004) ctrlSetStructuredText (parseText Format [localize "STR_WF_INFO_Funds",_funds]);
	};

	_funds_last = _funds;
	sleep 0.05;
};

//--- Release the UI.
uiNamespace setVariable ["wfbe_display_transfer", nil];