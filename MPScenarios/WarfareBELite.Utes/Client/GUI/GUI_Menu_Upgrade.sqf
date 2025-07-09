disableSerialization;

_display = _this select 0;
displayUpgrade = "";

MenuAction = -1;
mouseX = -1;
mouseY = -1;

_requiredFunds = 0;
_requiredSupply = 0;

_tooltip = _display DisplayCtrl 18998;
_tooltip_text = _display DisplayCtrl 18999;

_controls = [];
_u = 18001;
_curIDC = _display DisplayCtrl _u;
while {!isNull _curIDC} do {_controls = _controls + [_curIDC];_u = _u + 1;_curIDC = _display DisplayCtrl _u};

_level = 0;
_val = 0;
_time = 0;
_name = '';
_tooltip_text_content = '';
_canUpgrade = false;
_dependent = false;
_isUpgrading = false;
_lastTimerUpdate = -5;
_upgr = 'WFBE_UPGRADELABELS' Call GetNamespace;
_upgrlev = 'WFBE_UPGRADELEVELS' Call GetNamespace;
_upgrdep = 'WFBE_UPGRADEDEPENDENCIES' Call GetNamespace;
_upgrcond = 'WFBE_UPGRADECONDITION' Call GetNamespace;
_upgrdesc = 'WFBE_UPGRADEDESCRIPTION' Call GetNamespace;

while {alive player && dialog} do {
	if (side player != sideJoined || !commandInRange) exitWith {closeDialog 0};
	if !(dialog) exitWith {};
	
	_upgrades = (sideJoinedText) Call GetSideUpgrades;
	
	if (time - _lastTimerUpdate > 1) then {_lastTimerUpdate = time;_isUpgrading = Call Compile Format ["WFBE_%1_Upgrading",sideJoinedText]};
	
	_u = 0;
	{
		_level = _upgrades select _u;
		_maxLevel = _upgrlev select _u;
		_dependencie = _upgrdep select _u;
		_condition = _upgrcond select _u;
		if (_level == _maxLevel) then {_x ctrlSetTextColor [0, 1, 0, 1]};
		if (!_condition) then {_x ctrlSetTextColor [1, 0, 0, 1]};
		if (count _dependencie > 0 && _level != _maxLevel && _condition) then {
			if (_upgrades select (_dependencie select 0) < (_dependencie select 1)) then {
				_x ctrlSetTextColor [1, 0, 0, 1];
			} else {
				if (_level != _maxLevel) then {
					_x ctrlSetTextColor [0.75,0.75,0.75,1];
				};
			};
		};
		_u = _u + 1;
	} forEach _controls;
	
	//--- Tooltips.
	if (displayUpgrade != "") then {
		
		switch (displayUpgrade) do {
			case "infantry": {_val = 0};
			case "light": {_val = 1};
			case "heavy": {_val = 2};
			case "air": {_val = 3};
			case "parachutist": {_val = 4};
			case "uav": {_val = 5};
			case "supply": {_val = 6};
			case "ambuSpawn": {_val = 7};
			case "airlift": {_val = 8};
			case "artillery": {_val = 9};
			case "icbm": {_val = 10};
			case "fasttravel": {_val = 11};
			case "gear": {_val = 12};
			case "ammo": {_val = 13};
			case "paradrop": {_val = 14};
			case "shells": {_val = 15};
		};

		ctrlSetFocus (_controls select _val);
		
		_dependencie = _upgrdep select _val;
		_condition = _upgrcond select _val;
		_maxLevel = _upgrlev select _val;
		_name = _upgr select _val;
		_level = _upgrades select _val;
		_desc = _upgrdesc select _val;

		
		_enabled = true;
		if (!_condition) then {_enabled = false};
		if (count _dependencie > 0 && _enabled) then {
			if (_upgrades select (_dependencie select 0) < (_dependencie select 1)) then {
				_dependent = true;
			} else {_dependent = false};
		} else {_dependent = false};
		
		_bpath = if (_level == _maxLevel) then {_level} else {_level + 1};
		_time = (Format["WFBE_UPGRADETIMESLEVEL%1",_bpath] Call GetNamespace) select _val;
		_needed = (Format["WFBE_UPGRADEPRICESLEVEL%1",_bpath] Call GetNamespace) select _val;
		_requiredSupply = _needed select 0;
		_requiredFunds = _needed select 1;

		_currentSupply = (sideJoined) Call GetSideSupply;
		_currentFunds = Call GetPlayerfunds;
		
		_colorSupply = "'#ff9900'";
		_colorFunds = "'#ff9900'";
		_hasFunds = true;
		if !(paramMoneyOnly) then {if (_currentSupply < _requiredSupply) then {_colorSupply = "'#ff0033'";_hasFunds = false}} else {if (_currentFunds < _requiredFunds) then {_colorFunds = "'#ff0033'";_hasFunds = false}};
		
		if (!_isUpgrading && _level < _maxLevel && !_dependent && _enabled && _hasFunds) then {_canUpgrade = true} else {_canUpgrade = false};
		
		_tooltip_w = 0.30;
		_tooltip_h = 0.50;
		_tooltip_x = if ((1 - mouseX) < _tooltip_w) then {mouseX - _tooltip_w - 0.02} else {mouseX + 0.02};
		_tooltip_y = if (mouseY > 0.5) then {mouseY - _tooltip_h - 0.02} else {mouseY + 0.02};
		
		if (_level != _maxLevel) then {
			_costCd = if !(paramMoneyOnly) then {Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br />",Format [localize 'STR_WF_UPGRADE_Cost',"<t color=" + _colorSupply + ">" + str(_requiredSupply) + '</t>' + '/' + "<t color='#ff9900'>" + str(_currentSupply) + '</t> S']]} else {Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br />",Format [localize 'STR_WF_UPGRADE_Cost',"<t color=" + _colorFunds + ">" + str(_requiredFunds) + '</t>' + '/' + "<t color='#ff9900'>" + str(_currentFunds) + '</t> $']]};
			_tooltip_text_content = parsetext (
				Format ["<t size='1.2' color='#338dcc' shadow='0'>%1:</t><br />",_name] +
				Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br /><br />",Format [localize 'STR_WF_UPGRADE_Level',"<t color='#ff9900'>" + str(_level) + '</t>' + "/<t color='#ff9900'>" + str(_maxLevel) + '</t>']] +
				_costCd +
				Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br /><br />",Format [localize 'STR_WF_UPGRADE_Duration',"<t color='#ff9900'>" + str(_time) + ' </t>' + localize 'STR_WF_Seconds']] +
				Format ["<t size='0.8' color='#ff9900' shadow='0'>%1</t><br />",localize 'STR_WF_UPGRADE_Description'] +
				Format ["<t size='0.8' color='#338dcc' shadow='2'>%1</t><br />",_desc]
			);

			if (_isUpgrading) then {
				//_tooltip_h = 0.12;
				_tooltip_text_content = parsetext (
					Format ["<t size='1.2' color='#338dcc' shadow='0'>%1:</t><br />",_name] +
					Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br /><br />",Format [localize 'STR_WF_UPGRADE_Level',"<t color='#ff9900'>" + str(_level) + '</t>' + "/<t color='#ff9900'>" + str(_maxLevel) + '</t>']] +
					Format ["<t size='0.8' color='#ff9900' font='Zeppelin33'>%1</t><br /><br />",localize 'STR_WF_UPGRADE_AlreadyRunning']+
					Format ["<t size='0.8' color='#ff9900' shadow='0'>%1</t><br />",localize 'STR_WF_UPGRADE_Description'] +
					Format ["<t size='0.8' color='#338dcc' shadow='0'>%1</t><br />",_desc]
				);
			};
			if (!_enabled) then {
				//_tooltip_h = 0.12;
				_tooltip_text_content = parsetext (
					Format ["<t size='1.2' color='#338dcc' shadow='0'>%1:</t><br />",_name] +
					Format ["<t size='0.8' color='#ff0033' font='Zeppelin33'>%1</t><br /><br />",localize 'STR_WF_UPGRADE_Condition'] +
					Format ["<t size='0.8' color='#ff9900' shadow='0'>%1</t><br />",localize 'STR_WF_UPGRADE_Description'] +
					Format ["<t size='0.8' color='#338dcc' shadow='0'>%1</t><br />",_desc]
				);			
			};
			if (_dependent && !_isUpgrading && _enabled) then {
				_tooltip_text_content = parsetext (
					Format ["<t size='1.2' color='#338dcc' shadow='0'>%1:</t><br />",_name] +
					Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br /><br />",Format [localize 'STR_WF_UPGRADE_Level',"<t color='#ff9900'>" + str(_level) + '</t>' + "/<t color='#ff9900'>" + str(_maxLevel) + '</t>']] +
					Format ["<t size='0.8' color='#ff9900' font='Zeppelin33'>%1</t><br /><br />",Format[localize 'STR_WF_UPGRADE_Dependent',_upgr select (_dependencie select 0),_dependencie select 1]] +
					Format ["<t size='0.8' color='#ff9900' shadow='0'>%1</t><br />",localize 'STR_WF_UPGRADE_Description'] +
					Format ["<t size='0.8' color='#338dcc' shadow='0'>%1</t><br />",_desc]
				);			
			};
		} else {
			//_tooltip_h = 0.12;
			_tooltip_text_content = parsetext (
				Format ["<t size='1.2' color='#338dcc' shadow='0'>%1:</t><br />",_name] +
				Format ["<t size='0.8' color='#bfbfbf' font='Zeppelin33'>%1</t><br /><br />",Format [localize 'STR_WF_UPGRADE_Level',"<t color='#ff9900'>" + str(_level) + '</t>' + "/<t color='#ff9900'>" + str(_maxLevel) + '</t>']] +
				Format ["<t size='0.8' color='#00ff33' font='Zeppelin33'>%1</t><br /><br />",localize 'STR_WF_UPGRADE_Maximum'] +
				Format ["<t size='0.8' color='#ff9900' shadow='0'>%1</t><br />",localize 'STR_WF_UPGRADE_Description'] +
				Format ["<t size='0.8' color='#338dcc' shadow='0'>%1</t><br />",_desc]

			);
		};
		
		if ((ctrlPosition _tooltip select 0) == 0 || true) then {_tooltip ctrlSetPosition [_tooltip_x,_tooltip_y,_tooltip_w,_tooltip_h]};
		_tooltip ctrlCommit 0;
		
		_tooltip_text ctrlSetStructuredText _tooltip_text_content;
		if ((ctrlPosition _tooltip_text select 0) == 0 || true) then {_tooltip_text ctrlSetPosition [_tooltip_x,_tooltip_y,_tooltip_w,_tooltip_h]};
		_tooltip_text ctrlCommit 0;
		
	} else {
		if ((ctrlPosition _tooltip select 0) != 0) then {_tooltip ctrlSetPosition [0,0,0,0];_tooltip ctrlCommit 0};
		if ((ctrlPosition _tooltip_text select 0) != 0) then {_tooltip_text ctrlSetPosition [0,0,0,0];_tooltip_text ctrlCommit 0};
	};
	
	_commander = false;
	if (!isNull(commanderTeam)) then {
		if (commanderTeam == group player) then {_commander = true};
	};
	
	if (MenuAction == 1 && _canUpgrade && _commander) then {
		MenuAction = -1;
		if !(paramMoneyOnly) then {[sideJoined, -_requiredSupply] Call ChangeSideSupply} else {-(_requiredFunds) Call ChangePlayerFunds};
		
		["RequestUpgrade", [_time,_level,_val,_name,sideJoined]] Call SendToServer;
		
		Call Compile Format ["WFBE_%1_Upgrading = true;",sideJoinedText];
		_isUpgrading = true;
		hint Format [localize "STR_WF_INFO_Upgrade_Start",_name];
	} else {MenuAction = -1};
	
	_txt = if (_isUpgrading) then {localize "STR_WF_UPGRADE_RunningInfo" + "..."} else {""};
	ctrlSetText[18802,_txt];
	
	sleep 0.05;
	
	//--- Back Button.
	if (MenuAction == 2) exitWith {
		MenuAction = -1;
		closeDialog 0;
		createDialog "WF_Menu";
	};
};