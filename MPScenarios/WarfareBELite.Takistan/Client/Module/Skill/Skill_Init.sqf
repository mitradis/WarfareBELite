/*
	Script: Skill System by Benny.
	Description: Skill Initialization.
*/

/* Skills Root */
WFBE_SK_V_Root = 'Client\Module\Skill\Skill_';

/* Functions */
WFBE_SK_FNC_Apply = Compile preprocessFile "Client\Module\Skill\Skill_Apply.sqf";

/* Define which classname belong to which skill group */
WFBE_SK_V_Engineers = ['RU_Soldier_AR','USMC_Soldier_AR','TK_Soldier_MG_EP1','US_Soldier_MG_EP1'];
WFBE_SK_V_Officers = ['RU_Soldier_Officer','FR_Commander','TK_Soldier_Officer_EP1','US_Soldier_Officer_EP1'];
WFBE_SK_V_Soldiers = ['MVD_Soldier_TL','USMC_Soldier_SL','TK_Soldier_SL_EP1','US_Soldier_SL_EP1'];
WFBE_SK_V_SpecsOps = ['RUS_Soldier1','RUS_Soldier_TL','USMC_SoldierS','FR_TL','TK_Special_Forces_EP1','TK_Special_Forces_TL_EP1','US_Delta_Force_EP1','US_Delta_Force_TL_EP1'];
WFBE_SK_V_Spotters = ['RU_Soldier_Sniper','RUS_Soldier_Marksman','USMC_SoldierS_Sniper','FR_Marksman','TK_Soldier_Sniper_EP1','TK_Soldier_Spotter_EP1','US_Soldier_Sniper_EP1','US_Soldier_Spotter_EP1'];

//--- Binoculars.
['WFBE_BINOCULARS',["Laserdesignator", "Binocular", "Binocular_Vector"],true] Call SetNamespace;

/* Skills Variables */
WFBE_SK_V_LastUse_Repair = -1200;
WFBE_SK_V_LastUse_MASH = -1200;
WFBE_SK_V_LastUse_Lockpick = -1200;
WFBE_SK_V_LastUse_Spot = -1200;

/* Skills Timeout */
WFBE_SK_V_Reload_Repair = 65;
WFBE_SK_V_Reload_MASH = 600;
WFBE_SK_V_Reload_Lockpick = 25;
WFBE_SK_V_Reload_Spot = 8;

/* Find the player type */
WFBE_SK_V_Type = "";
if (playerType in WFBE_SK_V_Engineers) then {WFBE_SK_V_Type = "Engineer"};
if (playerType in WFBE_SK_V_Officers) then {WFBE_SK_V_Type = "Officer"};
if (playerType in WFBE_SK_V_Soldiers) then {WFBE_SK_V_Type = "Soldier"};
if (playerType in WFBE_SK_V_SpecsOps) then {WFBE_SK_V_Type = "SpecOps"};
if (playerType in WFBE_SK_V_Spotters) then {WFBE_SK_V_Type = "Spotter"};

/* Special one time init */
/* The soldier can hire more units than the others leader */
if (WFBE_SK_V_Type == 'Soldier') then {['WFBE_MAXGROUPSIZE',('WFBE_MAXGROUPSIZE' Call GetNameSpace) + ('WFBE_MAXGZBONUSSKILL' Call GetNamespace),true] Call SetNamespace};