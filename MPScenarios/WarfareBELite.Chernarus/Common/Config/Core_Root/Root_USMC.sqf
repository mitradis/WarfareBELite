Private ["_side"];

_side = "WEST";

//--- Generic.
missionNamespace setVariable [Format["WFBE_%1CREW", _side], 'USMC_Soldier_Crew'];
missionNamespace setVariable [Format["WFBE_%1PILOT", _side], 'USMC_Soldier_Pilot'];
missionNamespace setVariable [Format["WFBE_%1SOLDIER", _side], 'USMC_Soldier'];

//--- Flag texture.
missionNamespace setVariable [Format["WFBE_%1FLAG", _side], '\Ca\Data\flag_usa_co.paa'];

missionNamespace setVariable [Format["WFBE_%1AMBULANCES", _side], ['HMMWV_Ambulance','HMMWV_Ambulance_DES_EP1','UH60M_MEV_EP1','M1133_MEV_EP1']];
missionNamespace setVariable [Format["WFBE_%1REPAIRTRUCKS", _side], ['MtvrRepair','MtvrRepair_DES_EP1']];
missionNamespace setVariable [Format["WFBE_%1SALVAGETRUCK", _side], ['WarfareSalvageTruck_USMC','MtvrSalvage_DES_EP1']];
missionNamespace setVariable [Format["WFBE_%1SUPPLYTRUCKS", _side], ['WarfareSupplyTruck_USMC','MtvrSupply_DES_EP1']];
missionNamespace setVariable [Format["WFBE_%1UAV", _side], 'MQ9PredatorB'];

//--- Radio Announcers.
missionNamespace setVariable [Format ["WFBE_%1_RadioAnnouncers", _side], ['WFHQ_EN0','WFHQ_EN1','WFHQ_EN2']];
missionNamespace setVariable [Format ["WFBE_%1_RadioAnnouncers_Config", _side], 'RadioProtocolEN'];

//--- Server only.
if (isServer) then {
	//--- Patrols.
	missionNamespace setVariable [Format["WFBE_%1_PATROL_LIGHT", _side], [
		['USMC_Soldier_TL','USMC_Soldier_MG','USMC_SoldierS_Sniper','USMC_Soldier_Medic'], 
		['USMC_Soldier_TL','USMC_Soldier_AR','USMC_Soldier_GL','USMC_Soldier_LAT','USMC_Soldier'],
		['HMMWV_M2','HMMWV_MK19']
	]];

	missionNamespace setVariable [Format["WFBE_%1_PATROL_MEDIUM", _side], [
		['LAV25','LAV25'], 
		['MTVR','USMC_Soldier_TL','USMC_Soldier_AT','USMC_Soldier_MG','USMC_Soldier_LAT'],
		['AAV','USMC_Soldier_AA','USMC_Soldier_AA','USMC_Soldier_Medic']
	]];

	missionNamespace setVariable [Format["WFBE_%1_PATROL_HEAVY", _side], [
		['M1A1','AAV'], 
		['M1A1','M1A1'],
		['AAV','AAV','USMC_Soldier_TL','USMC_Soldier_MG','USMC_SoldierM_Marksman','USMC_Soldier_Medic','USMC_Soldier_AT','USMC_Soldier_HAT','USMC_Soldier'],
		['LAV25','USMC_Soldier_TL','USMC_Soldier_Medic','USMC_Soldier_GL','USMC_Soldier','USMC_Soldier_AR']
	]];
	
	//--- Base Patrols.
	if (paramBasePatrols) then {
		missionNamespace setVariable [Format["WFBE_%1BASEPATROLS_0", _side],['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier','USMC_Soldier_AR','USMC_Soldier_GL','USMC_Soldier_MG']];
		missionNamespace setVariable [Format["WFBE_%1BASEPATROLS_1", _side],['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier','USMC_Soldier_MG','USMC_Soldier_LAT','USMC_Soldier_Medic']];
		missionNamespace setVariable [Format["WFBE_%1BASEPATROLS_2", _side],['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier','USMC_Soldier_AT','USMC_Soldier_AA','USMC_SoldierS_Sniper']];
		missionNamespace setVariable [Format["WFBE_%1BASEPATROLS_3", _side],['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier_AR','USMC_Soldier_HAT','USMC_Soldier_LAT','USMC_Soldier_GL']];
	};
	
	//--- Paratroopers.
	missionNamespace setVariable [Format["WFBE_%1PARACHUTELEVEL1", _side],['USMC_Soldier_SL','USMC_Soldier_LAT','USMC_Soldier','USMC_Soldier2','USMC_Soldier_AR','USMC_Soldier_Medic']];
	missionNamespace setVariable [Format["WFBE_%1PARACHUTELEVEL2", _side],['USMC_Soldier_SL','USMC_Soldier_AT','USMC_Soldier_AT','USMC_Soldier_AT','USMC_Soldier_AA','USMC_Soldier_MG','USMC_Soldier_Medic','USMC_SoldierS_Spotter','USMC_SoldierS_Sniper']];
	missionNamespace setVariable [Format["WFBE_%1PARACHUTELEVEL3", _side],['FR_Assault_R','USMC_Soldier_HAT','USMC_Soldier_HAT','USMC_Soldier_HAT','USMC_Soldier_HAT','USMC_Soldier_AA','USMC_Soldier_AA','FR_AR','FR_AC','USMC_Soldier_Medic','FR_Marksman','USMC_Soldier_AT','USMC_SoldierS_Sniper']];
	
	missionNamespace setVariable [Format["WFBE_%1PARACARGO", _side], 'C130J'];	//--- Paratroopers, Vehicle.
	missionNamespace setVariable [Format["WFBE_%1REPAIRTRUCK", _side], 'MtvrRepair'];//--- Repair Truck model.
	missionNamespace setVariable [Format["WFBE_%1STARTINGVEHICLES", _side], ['HMMWV_Ambulance','MTVR']];//--- Starting Vehicles.
	missionNamespace setVariable [Format["WFBE_%1PARAAMMO", _side], ['USBasicAmmunitionBox','USBasicWeaponsBox','USLaunchersBox']];//--- Supply Paradropping, Dropped Ammunition.
	missionNamespace setVariable [Format["WFBE_%1PARAVEHICARGO", _side], 'HMMWV'];//--- Supply Paradropping, Dropped Vehicle.
	missionNamespace setVariable [Format["WFBE_%1PARAVEHI", _side], 'MH60S'];//--- Supply Paradropping, Vehicle
	missionNamespace setVariable [Format["WFBE_%1PARACHUTE", _side], 'ParachuteMediumWest'];//--- Supply Paradropping, Parachute Model.
	missionNamespace setVariable [Format["WFBE_%1SUPPLYTRUCK", _side], 'WarfareSupplyTruck_USMC'];//--- Supply Truck model.
	
	//--- AI Loadouts [weapons, magazines, eligible muzzles, {backpack}, {backpack content}].
	missionNamespace setVariable [Format["WFBE_%1_AI_Loadout_0", _side], [
		[['m16a4_acg','M136','Colt1911','Binocular','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],
		 ['m16a4_acg','M136','Colt1911']],
		[['G36C','M136','Colt1911','Binocular','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],
		 ['G36C','M136','Colt1911']]
	]];	
	missionNamespace setVariable [Format["WFBE_%1_AI_Loadout_1", _side], [
		[['M4A1_Aim_camo','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],
		 ['M4A1_Aim_camo','M136','Colt1911']],
		[['G36K','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],
		 ['G36K','M136','Colt1911']],
		[['DMR','M9SD','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD'],
		 ['DMR','M9SD']]
	]];
	missionNamespace setVariable [Format["WFBE_%1_AI_Loadout_2", _side], [
		[['M4A1_Aim_camo','SMAW','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],
		 ['M4A1_Aim_camo','SMAW','Colt1911']],
		[['G36C','SMAW','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],
		 ['G36C','SMAW','Colt1911']]
	]];
	missionNamespace setVariable [Format["WFBE_%1_AI_Loadout_3", _side], [
		[['M4A1_HWS_GL','SMAW','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],
		 ['M4A1_HWS_GL','SMAW']],
		[['M4A1_HWS_GL_camo','Javelin','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],
		 ['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Javelin','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],
		 ['M4A1_HWS_GL_camo','Javelin','Colt1911']]
	]];
};

//--- Client only.
if (local player) then {
	//--- Import the needed Gear (Available from the gear menu), multiple gear can be used.
	(_side) Call Compile preprocessFileLineNumbers "Common\Config\Loadout\Loadout_USMC.sqf";
};

//--- Default Loadout [weapons, magazines, eligible muzzles, {backpack}, {backpack content}].
missionNamespace setVariable [Format["WFBE_%1_DefaultGear", _side], [
	['M4A1_Aim','M9','Binocular','NVGoggles','ItemCompass','ItemMap','ItemRadio','ItemWatch'],
	['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West','HandGrenade_West','SmokeShellBlue','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD'],
	['M4A1_Aim','M9']
]];