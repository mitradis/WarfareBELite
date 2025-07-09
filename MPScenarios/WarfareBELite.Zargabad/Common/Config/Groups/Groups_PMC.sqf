/*
	Groups (Used in towns).
*/

Private ["_faction","_k","_l","_side","_u"];
_l = [];//--- Unit list
_k = [];//--- Type used by AI.

_side = "GUER";
_faction = "PMC";

_k = _k + ["Squad"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
_u = _u + ["Soldier_M4A3_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_Engineer_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

_k = _k + ["Squad_Advanced"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
_u = _u + ["Soldier_M4A3_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_Engineer_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

_k = _k + ["Squad"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_M4A3_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_GL_M16A2_PMC"];
_u = _u + ["Soldier_Sniper_PMC"];
_l = _l + [_u];

_k = _k + ["Team_MG"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_MG_PKM_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

_k = _k + ["Team"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_GL_PMC"];
_u = _u + ["Soldier_PMC"];
_l = _l + [_u];

_k = _k + ["Team"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_PMC"];
_l = _l + [_u];

_k = _k + ["Team"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_MG_PKM_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

_k = _k + ["Team_AT"];
_u		= ["Soldier_AT_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_MG_PKM_PMC"];
_l = _l + [_u];

_k = _k + ["Team_HAT"];
_u		= ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

_k = _k + ["Team_AA"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_MG_PKM_PMC"];
_l = _l + [_u];

_k = _k + ["Team_Sniper"];
_u		= ["Soldier_Sniper_PMC"];
_u = _u + ["Soldier_Sniper_KSVK_PMC"];
_u = _u + ["Soldier_Sniper_PMC"];
_l = _l + [_u];

_k = _k + ["Motorized"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
_u = _u + ["ArmoredSUV_PMC"];
_u = _u + ["ArmoredSUV_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_M4A3_PMC"];
_u = _u + ["Soldier_Sniper_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

_k = _k + ["Motorized"];
_u		= ["SUV_PMC"];
_u = _u + ["SUV_PMC"];
_l = _l + [_u];

_k = _k + ["Armored_Light"];
_u		= ["SUV_PMC"];
_u = _u + ["SUV_PMC"];
_u = _u + ["SUV_PMC"];
_l = _l + [_u];

_k = _k + ["Armored_Heavy"];
_u		= ["SUV_PMC"];
_u = _u + ["SUV_PMC"];
_u = _u + ["SUV_PMC"];
_l = _l + [_u];

_k = _k + ["AA_Light"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_PMC"];
_l = _l + [_u];

_k = _k + ["AA_Heavy"];
_u		= ["Soldier_AA_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_l = _l + [_u];

_k = _k + ["Mechanized"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_PMC"];
_l = _l + [_u];

_k = _k + ["Mechanized"];
_u		= ["Soldier_GL_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_PMC"];
_l = _l + [_u];

_k = _k + ["Mechanized_Heavy"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Engineer_PMC"];
_u = _u + ["Soldier_Sniper_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_l = _l + [_u];

[_k,_l,_side,_faction] Call Compile preprocessFile "Common\Config\Config_Groups.sqf";