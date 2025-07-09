Private ['_tiMode','_u'];

_tiMode = 'WFBE_THERMALIMAGING' Call GetNamespace;
_tiMode = if (_tiMode == 1 || _tiMode == 3) then {true} else {false};

//--- Takistan Army Troops.
_u 			= ['TK_Soldier_EP1'];
_u = _u		+ ['TK_Soldier_B_EP1'];
if (_tiMode) then {
	_u = _u		+ ['TK_Soldier_TWS_EP1'];
};
_u = _u		+ ['TK_Soldier_Engineer_EP1'];
_u = _u		+ ['TK_Soldier_LAT_EP1'];
_u = _u		+ ['TK_Soldier_AAT_EP1'];
_u = _u		+ ['TK_Soldier_AT_EP1'];
_u = _u		+ ['TK_Soldier_HAT_EP1'];
_u = _u		+ ['TK_Soldier_AA_EP1'];
_u = _u		+ ['TK_Soldier_AR_EP1'];
_u = _u		+ ['TK_Soldier_AMG_EP1'];
_u = _u		+ ['TK_Soldier_MG_EP1'];
_u = _u		+ ['TK_Soldier_GL_EP1'];
_u = _u		+ ['TK_Soldier_Spotter_EP1'];
_u = _u		+ ['TK_Soldier_Sniper_EP1'];
_u = _u		+ ['TK_Soldier_SniperH_EP1'];
_u = _u		+ ['TK_Soldier_Medic_EP1'];
_u = _u		+ ['TK_Special_Forces_EP1'];
_u = _u		+ ['TK_Special_Forces_TL_EP1'];
_u = _u		+ ['TK_Special_Forces_MG_EP1'];
_u = _u		+ ['TK_Soldier_Crew_EP1'];
_u = _u		+ ['TK_Soldier_Pilot_EP1'];
_u = _u		+ ['TK_Soldier_SL_EP1'];
_u = _u		+ ['TK_Soldier_Officer_EP1'];

_u