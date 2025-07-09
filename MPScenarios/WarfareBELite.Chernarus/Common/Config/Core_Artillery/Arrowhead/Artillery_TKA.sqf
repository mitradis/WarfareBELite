Private ["_maxRange"];
_maxRange = 'WFBE_ARTILLERYMAXRANGE' Call GetNamespace;

['WFBE_EAST_ARTILLERY_DESC',['D30','2B14','GRAD'],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_NAMES',
  [
	['D30_TK_EP1'],
	['2b14_82mm_TK_EP1'],
	['GRAD_TK_EP1']
  ]
,true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_WEAPONS',['D30','2B14','GRAD'],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_AMMOS',
  [
	['Sh_122_HE','Sh_122_WP','Sh_122_SADARM','Sh_122_LASER','Sh_122_SMOKE','Sh_122_ILLUM'],
	['Sh_82_HE','Sh_82_WP','Sh_82_ILLUM'],
	['R_GRAD']
  ]
,true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_EXTENDED_MAGS',
  [
	['30Rnd_122mmWP_D30','30Rnd_122mmSADARM_D30','30Rnd_122mmLASER_D30','30Rnd_122mmSMOKE_D30','30Rnd_122mmILLUM_D30'],
	['8Rnd_82mmWP_2B14','8Rnd_82mmILLUM_2B14'],
	[]
  ]
,true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_EXTENDED_MAGS_UPGRD',
  [
	[2,3,3,1,1],
	[2,1],
	[]
  ]
,true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_MINRANGES',[1000,500,800],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_RELOADTIME',[7,4,2],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_BURST',[10,4,10],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_VELOCITIES',[500,475,550],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_DISPERSIONS',[50,60,40],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_AMMO_LASER',['Sh_122_LASER'],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_AMMO_SADARM',['Sh_122_SADARM'],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_AMMO_ILLUMN',['Sh_122_ILLUM'],true] Call SetNamespace;
['WFBE_EAST_ARTILLERY_DEPLOY_SMOKE',['Sh_122_WP','Sh_122_SMOKE'],true] Call SetNamespace;