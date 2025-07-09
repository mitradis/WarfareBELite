Private ["_maxRange"];
_maxRange = 'WFBE_ARTILLERYMAXRANGE' Call GetNamespace;

['WFBE_WEST_ARTILLERY_DESC',['M119','M252','MLRS','Stryker MC'],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_NAMES',
  [
	['M119_US_EP1'],
	['M252_US_EP1'],
	['MLRS_DES_EP1'],
	['M1129_MC_EP1']
  ]
,true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_WEAPONS',['M119','M252','MLRS','M120'],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_AMMOS',
  [
	['Sh_105_HE','Sh_105_WP','Sh_105_SADARM','Sh_105_LASER','Sh_105_SMOKE','Sh_105_ILLUM'],
	['Sh_81_HE','Sh_81_WP','Sh_81_ILLUM'],
	['R_MLRS'],
	['120mmHE_M120']
  ]
,true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_EXTENDED_MAGS',
  [
	['30Rnd_105mmWP_M119','30Rnd_105mmSADARM_M119','30Rnd_105mmLASER_M119','30Rnd_105mmSMOKE_M119','30Rnd_105mmILLUM_M119'],
	['8Rnd_81mmWP_M252','8Rnd_81mmILLUM_M252'],
	[],
	[]
  ]
,true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_EXTENDED_MAGS_UPGRD',
  [
	[2,3,3,1,1],
	[2,1],
	[],
	[]
  ]
,true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_MINRANGES',[1000,500,1200,550],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange,2150*_maxRange],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_RELOADTIME',[7,4,2,4],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_BURST',[10,4,6,6],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_VELOCITIES',[500,475,550,475],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_DISPERSIONS',[50,60,40,55],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_AMMO_LASER',['Sh_105_LASER'],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_AMMO_SADARM',['Sh_105_SADARM'],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_AMMO_ILLUMN',['Sh_105_ILLUM'],true] Call SetNamespace;
['WFBE_WEST_ARTILLERY_DEPLOY_SMOKE',['Sh_105_WP','Sh_105_SMOKE'],true] Call SetNamespace;