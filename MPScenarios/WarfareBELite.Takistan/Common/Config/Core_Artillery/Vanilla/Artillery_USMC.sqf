Private ["_maxRange"];
_maxRange = 'WFBE_ARTILLERYMAXRANGE' Call GetNamespace;

//--- Label shown in the GUI.
['WFBE_WEST_ARTILLERY_DESC',['M119','M252','MLRS'],true] Call SetNamespace;
//--- Class name of the Artillery unit.
['WFBE_WEST_ARTILLERY_NAMES',
  [
	['M119'],
	['M252'],
	['MLRS']
  ]
,true] Call SetNamespace;
//--- Artillery Weapon used to fire the shells.
['WFBE_WEST_ARTILLERY_WEAPONS',['M119','M252','MLRS'],true] Call SetNamespace;
//--- Compatible ammo.
['WFBE_WEST_ARTILLERY_AMMOS',
  [
	['ARTY_Sh_105_HE','Sh_105_HE','ARTY_Sh_105_WP','ARTY_Sh_105_SADARM','ARTY_Sh_105_LASER','ARTY_Sh_105_SMOKE','ARTY_Sh_105_ILLUM'],
	['ARTY_Sh_81_HE','Sh_81_HE','ARTY_Sh_81_WP','ARTY_Sh_81_ILLUM'],
	['ARTY_R_227mm_HE_Rocket','R_MLRS']
  ]
,true] Call SetNamespace;
//--- Extended ammo.
['WFBE_WEST_ARTILLERY_EXTENDED_MAGS',
  [
	['ARTY_30Rnd_105mmWP_M119','ARTY_30Rnd_105mmSADARM_M119','ARTY_30Rnd_105mmLASER_M119','ARTY_30Rnd_105mmSMOKE_M119','ARTY_30Rnd_105mmILLUM_M119'],
	['ARTY_8Rnd_81mmWP_M252','ARTY_8Rnd_81mmILLUM_M252'],
	[]
  ]
,true] Call SetNamespace;
//--- Upgrade level required for the extended ammo.
['WFBE_WEST_ARTILLERY_EXTENDED_MAGS_UPGRD',
  [
	[2,3,3,1,1],
	[2,1],
	[]
  ]
,true] Call SetNamespace;
//--- Artillery Minimal fire distance.
['WFBE_WEST_ARTILLERY_MINRANGES',[1000,500,1200],true] Call SetNamespace;
//--- Artillery Maximal fire distance multiplied by the artillery range parameter.
['WFBE_WEST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange],true] Call SetNamespace;
//--- Artillery Reload time between each shot.
['WFBE_WEST_ARTILLERY_RELOADTIME',[7,4,2],true] Call SetNamespace;
//--- Amount of shells fired during a fire mission.
['WFBE_WEST_ARTILLERY_BURST',[10,4,6],true] Call SetNamespace;
//--- Velocity of the shell (note: try to keep it above 400 for a realistic result).
['WFBE_WEST_ARTILLERY_VELOCITIES',[500,475,550],true] Call SetNamespace;
//--- Shell land dispersion.
['WFBE_WEST_ARTILLERY_DISPERSIONS',[50,60,40],true] Call SetNamespace;
//--- Laser Guided Ammunitions.
['WFBE_WEST_ARTILLERY_AMMO_LASER',['ARTY_Sh_105_LASER'],true] Call SetNamespace;
//--- Search And Destroy Armor ammunition.
['WFBE_WEST_ARTILLERY_AMMO_SADARM',['ARTY_Sh_105_SADARM'],true] Call SetNamespace;
//--- Illum rounds.
['WFBE_WEST_ARTILLERY_AMMO_ILLUMN',['ARTY_Sh_105_ILLUM'],true] Call SetNamespace;
//--- Deploy smoke on impact if it's this type.
['WFBE_WEST_ARTILLERY_DEPLOY_SMOKE',['ARTY_Sh_105_WP','ARTY_Sh_105_SMOKE'],true] Call SetNamespace;