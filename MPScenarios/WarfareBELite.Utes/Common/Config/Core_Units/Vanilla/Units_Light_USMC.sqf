Private ['_u'];

//--- USMC Light Vehicles.
_u 			= ['MMT_USMC'];
_u = _u		+ ['M1030'];
_u = _u		+ ['HMMWV'];
_u = _u		+ ['Zodiac'];
_u = _u		+ ['HMMWV_M2'];
_u = _u		+ ['HMMWV_Armored'];
_u = _u		+ ['HMMWV_MK19'];
_u = _u		+ ['HMMWV_TOW'];
_u = _u		+ ['HMMWV_Avenger'];
_u = _u		+ ['HMMWV_Ambulance'];
_u = _u		+ ['MTVR'];
_u = _u		+ ['MtvrRepair'];
_u = _u		+ ['WarfareReammoTruck_USMC'];
_u = _u		+ ['MtvrRefuel'];
_u = _u		+ ['WarfareSalvageTruck_USMC'];
if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['WarfareSupplyTruck_USMC']};
_u = _u		+ ['RHIB'];
_u = _u		+ ['RHIB2Turret'];
_u = _u		+ ['LAV25'];

_u