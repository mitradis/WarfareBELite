Private ["_get","_position","_side","_skill","_team","_type","_unit"];

_type = _this select 0;
_team = _this select 1;
_position = _this select 2;
_side = _this select 3;
_sideID = _side Call GetSideID;

_get = _type Call GetNamespace;
_skill = if !(isNil '_get') then {_get select QUERYUNITSKILL} else {'WFBE_AISKILL' Call GetNamespace};
_unit = _team createUnit [_type,_position,[],0,"FORM"];
_unit setSkill _skill;

//todo, optimize dynamic init (if 2 way).
if (_sideID != RESISTANCEID) then {
	if (paramTrackAI) then {
		// _unit setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
		_unit setVehicleInit Format["[this,%1] ExecVM 'Common\Init\Init_Unit.sqf';",_sideID];
		processInitCommands;
	} else {
		// if (isPlayer leader _team) then {[_unit,_side] ExecVM 'Common\Common_InitUnit.sqf'};
		if (isPlayer leader _team) then {[_unit,_sideID] ExecVM 'Common\Init\Init_Unit.sqf'};
	};
};
_unit addEventHandler ['Killed', Format ['[_this select 0,_this select 1,%1] Spawn UnitKilled', _sideID]];

_unit