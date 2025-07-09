/* Parameters */

class Params {
	class aiGroupSizeAI {
		title = "$STR_WF_PARAMETER_GroupSizeAI";
		values[] = {6,12};
		texts[] = {"6","12"};
		default = 6;
	};
	class aiGroupSizePlayer {
		title = "$STR_WF_PARAMETER_GroupSizePlayer";
		values[] = {6,12,18,24};
		texts[] = {"6","12","18","24"};
		default = 12;
	};
	class aiKeepUnits {
		title = "$STR_WF_PARAMETER_KeepAI";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_No","$STR_WF_PARAMETER_Yes"};
		default = 0;
	};
	class aiTeams {
		title = "$STR_WF_PARAMETER_AI";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class artilleryCalls {
		title = "$STR_WF_PARAMETER_Arty";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	#ifndef VANILLA
		class artilleryComputer {
			title = "$STR_WF_PARAMETER_ArtilleryComputer";
			values[] = {0,1,2};
			texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Enabled_Upgrade","$STR_WF_Enabled"};
			default = 0;
		};	
	#endif
	class artilleryUI {
		title = "$STR_WF_PARAMETER_ArtilleryUI";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class artilleryRange {
		title = "$STR_WF_PARAMETER_Artillery";
		values[] = {1,1.5,2};
		texts[] = {"$STR_WF_PARAMETER_Short","$STR_WF_PARAMETER_Medium","$STR_WF_PARAMETER_Long"};
		default = 2;
	};
	class baseAICommander {
		title = "$STR_WF_PARAMETER_AICommander";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_No","$STR_WF_PARAMETER_Yes"};
		default = 1;
	};
	//--- OA has no suitable allies for both side (yet).
	#ifndef ARROWHEAD
		class baseAllies {
			title = "$STR_WF_PARAMETER_Allies";
			values[] = {0,1,2,3};
			texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Side_West","$STR_WF_PARAMETER_Side_East","$STR_WF_PARAMETER_Both"};
			default = 0;
		};
	#endif
	class baseAAR {
		title = "$STR_WF_PARAMETER_AntiAirRadar";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class baseArea {
		title = "$STR_WF_PARAMETER_BaseArea";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_No","$STR_WF_PARAMETER_Yes"};
		default = 1;
	};
	class baseAreaLimit {
		title = "$STR_WF_PARAMETER_BaseArea_Limit";
		values[] = {1,2,3};
		texts[] = {"1","2","3"};
		default = 2;
	};
	class baseAutoDefenses {
		title = "$STR_WF_PARAMETER_AutoMannedDefense";
		values[] = {0,10,20,30,40,50,60,70,80,90,100};
		texts[] = {"$STR_WF_Disabled","10","20","30","40","50","60","70","80","90","100"};
		default = 30;
	};
	class baseAutoDefensesRange {
		title = "$STR_WF_PARAMETER_AutoDefense_Range";
		values[] = {50,100,150,200,250,300,350,400,450,500};
		texts[] = {"50m","100m","150m","200m","250m","300m","350m","400m","450m","500m"};
		default = 350;
	};
	class baseBuildingsLimit {
		title = "$STR_WF_PARAMETER_BuildingsLimit";
		values[] = {1,2,3};
		texts[] = {"1","2","3"};
		default = 2;
	};
	class baseConstructionMode {
		title = "$STR_WF_PARAMETER_ConstructionMode";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_Time","$STR_WF_PARAMETER_HQWorkers"};
		default = 0;
	};
	class baseDefensePlacement {
		title = "$STR_WF_PARAMETER_DefensePlacement";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_Collide_No","$STR_WF_PARAMETER_Collide"};
		default = 1;
	};
	class baseHQDeploycost {
		title = "$STR_WF_PARAMETER_HQDeployCost";
		values[] = {100,200,300,400,500,600,700,800,900,1000};
		texts[] = {"S 100","S 200","S 300","S 400","S 500","S 600","S 700","S 800","S 900","S 1000"};
		default = 100;
	};
	class baseHQDeployRange {
		title = "$STR_WF_PARAMETER_HQDeployRange";
		values[] = {50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200};
		texts[] = {"50m","60m","70m","80m","90m","100m","110m","120m","130m","140m","150m","160m","170m","180m","190m","200m"};
		default = 100;
	};
	class basePatrols {
		title = "$STR_WF_PARAMETER_BasePatrols";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class baseSpawnSystemRestrict {
		title = "$STR_WF_PARAMETER_SpawnSystemRestrict";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_No","$STR_WF_PARAMETER_Yes"};
		default = 1;
	};
	class baseStartingDistance {
		title = "$STR_WF_PARAMETER_StartingDistance";
		values[] = {-1,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500};
		texts[] = {"$STR_WF_PARAMETER_StartingLocations_Random","1000m","1500m","2000m","2500m","3000m","3500m","4000m","4500m","5000m","5500m"};
		default = 1500;
	};
	class baseStartingLocations {
		title = "$STR_WF_PARAMETER_StartingLocations";
		values[] = {0,1,2};
		texts[] = {"$STR_WF_PARAMETER_StartingLocations_WestNorth","$STR_WF_PARAMETER_StartingLocations_WestSouth","$STR_WF_PARAMETER_StartingLocations_Random"};
		default = 2;
	};
	class economyCurrency {
		title = "$STR_WF_PARAMETER_Currency";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_Money_Supply","$STR_WF_PARAMETER_Money"};
		default = 0;
	};
	class economyIncomeInterval {
		title = "$STR_WF_PARAMETER_IncomeInterval";
		values[] = {60,75,90,105,120,150,180,240,300,360,420,480,540,600};
		texts[] = {"1 Minute","1 Minute 15 Seconds","1 Minute 30 Seconds","1 Minute 45 Seconds","2 Minutes","2 Minutes 30 Seconds","3 Minutes","4 Minutes","5 Minutes","6 Minutes","7 Minutes","8 Minutes","9 Minutes","10 Minutes"};
		default = 60;
	};
	class economyIncomeSystem {
		title = "$STR_WF_PARAMETER_IncomeSystem";
		values[] = {1,2,3,4};
		texts[] = {"$STR_WF_PARAMETER_IncomeSystem_Full","$STR_WF_PARAMETER_IncomeSystem_Half","$STR_WF_PARAMETER_Income_Sys_Param","$STR_WF_PARAMETER_Income_Sys_Param_Full"};
		default = 3;
	};
	class economyStartingFundsEast {
		title = "$STR_WF_PARAMETER_Funds_East";
		values[] = {800,1600,2400,3200,4000,4800,6400,8000,12800,25600,51200,102400,204800,409600,819200};
		texts[] = {"$ 800","$ 1600","$ 2400","$ 3200","$ 4000","$ 4800","$ 6400","$ 8000","$ 12800","$ 25600","$ 51200","$ 102400","$ 204800","$ 409600","$ 819200"};
		default = 2400;
	};
	class economyStartingFundsWest {
		title = "$STR_WF_PARAMETER_Funds_West";
		values[] = {800,1600,2400,3200,4000,4800,6400,8000,12800,25600,51200,102400,204800,409600,819200};
		texts[] = {"$ 800","$ 1600","$ 2400","$ 3200","$ 4000","$ 4800","$ 6400","$ 8000","$ 12800","$ 25600","$ 51200","$ 102400","$ 204800","$ 409600","$ 819200"};
		default = 2400;
	};
	class economyStartingSupplyEast {
		title = "$STR_WF_PARAMETER_Supply_East";
		values[] = {1200,2400,3600,4800,6000,7200,8400,9600,19200,38400,76800};
		texts[] = {"S 1200","S 2400","S 3600","S 4800","S 6000","S 7200","S 8400","S 9600","S 19200","S 38400","S 76800"};
		default = 4800;
	};
	class economyStartingSupplyWest {
		title = "$STR_WF_PARAMETER_Supply_West";
		values[] = {1200,2400,3600,4800,6000,7200,8400,9600,19200,38400,76800};
		texts[] = {"S 1200","S 2400","S 3600","S 4800","S 6000","S 7200","S 8400","S 9600","S 19200","S 38400","S 76800"};
		default = 4800;
	};
	class economySupplySystem {
		title = "$STR_WF_PARAMETER_SupplySystem";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_SupplySystem_Truck","$STR_WF_PARAMETER_Time"};
		default = 1;
	};
	class environmentFastTime {
		title = "$STR_WF_PARAMETER_FastTime";
		values[] = {0,2,3,4,5,10,15,20};
		texts[] = {"$STR_WF_Disabled","1 Minute = 2 Minutes","1 Minute = 3 Minutes","1 Minute = 4 Minutes","1 Minute = 5 Minutes","1 Minute = 10 Minutes","1 Minute = 15 Minutes","1 Minute = 20 Minutes"};
		default = 0;
	};
	class environmentTimeOfDay {
		title = "$STR_WF_PARAMETER_TimeOfDay";
		values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		texts[] = {"00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00",
		"12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"};
		default = 9;
	};
	class environmentWeather {
		title = "$STR_WF_PARAMETER_Weather";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_PARAMETER_Weather_Clear","$STR_WF_PARAMETER_Weather_Cloudy","$STR_WF_PARAMETER_Weather_Rainy","$STR_WF_PARAMETER_Weather_Dynamic"};
		default = 0;
	};
	#ifndef VANILLA
		class extensionBAF {
			title = "$STR_WF_PARAMETER_BAF";
			values[] = {0,1};
			texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
			default = 1;
		};
		class extensionPMC {
			title = "$STR_WF_PARAMETER_PMC";
			values[] = {0,1};
			texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
			default = 1;
		};
	#endif
	class gameplayAlice {
		title = "$STR_WF_PARAMETER_Alice";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class gameplayHangars {
		title = "$STR_WF_PARAMETER_Hangars";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayBodiesTimeout {
		title = "$STR_WF_PARAMETER_BodiesTimeout";
		values[] = {60,120,180,240,300};
		texts[] = {"1 Minutes","2 Minutes","3 Minutes","4 Minutes","5 Minutes"};
		default = 60;
	};
	class gameplayVehiclesTimeout {
		title = "$STR_WF_PARAMETER_VehicleDelay";
		values[] = {60,120,180,240,300,600,1200,1800};
		texts[] = {"1 Minute","2 Minutes","3 Minutes","4 Minutes","5 Minutes","10 Minutes","20 Minutes","30 Minutes"};
		default = 600;
	};
	class gameplayFastTravel {
		title = "$STR_WF_PARAMETER_FastTravel";
		values[] = {0,1,2};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Free","$STR_WF_PARAMETER_Fee"};
		default = 0;
	};
	class gameplayFriendlyFire {
		title = "$STR_WF_PARAMETER_FriendlyFire";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class gameplayGrass {
		title = "$STR_WF_PARAMETER_Grass";
		values[] = {10,20,30,50};
		texts[] = {"$STR_WF_PARAMETER_Grass_Far","$STR_WF_PARAMETER_Grass_Medium","$STR_WF_PARAMETER_Grass_Short","$STR_WF_PARAMETER_Grass_Toggle"};
		default = 50;
	};
	class gameplayKickTeamswap {
		title = "$STR_WF_PARAMETER_KickTeamswapper";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class gameplayLimitedBoundaries {
		title = "$STR_WF_PARAMETER_LimitedBoundaries";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayMissileRange {
		title = "$STR_WF_PARAMETER_MissileRange";
		values[] = {0,500,1000,1500,2000,2500,3000,3500,4000,4500,5000};
		texts[] = {"$STR_WF_Disabled","500m","1000m","1500m","2000m","2500m","3000m","3500m","4000m","4500m","5000m"};
		default = 2500;
	};
	class gameplaySecondaryMissions {
		title = "$STR_WF_PARAMETER_SecondaryMissions";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayShowUID {
		title = "$STR_WF_PARAMETER_ShowUID";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplaySpecialization {
		title = "$STR_WF_PARAMETER_Specialization";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Infantry","$STR_WF_PARAMETER_LandVehicles","$STR_WF_PARAMETER_Aircraft"};
		default = 0;
	};
	class gameplayThermalImaging {
		title = "$STR_WF_PARAMETER_ThermalImaging";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Weapons","$STR_WF_PARAMETER_Vehicles","$STR_WF_Enabled"};
		default = 3;
	};
	class gameplayVehicleLock {
		title = "$STR_WF_PARAMETER_VehLock";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class gameplayTrackAI {
		title = "$STR_WF_PARAMETER_TrackAI";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class gameplayTrackPlayers {
		title = "$STR_WF_PARAMETER_TrackPlayers";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayUnitsBounty {
		title = "$STR_WF_PARAMETER_UnitsBounty";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayUpgradesEast {
		title = "$STR_WF_PARAMETER_Upgrades_East";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayUpgradesWest {
		title = "$STR_WF_PARAMETER_Upgrades_West";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class gameplayVictoryConditions {
		title = "$STR_WF_PARAMETER_VictoryCondition";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_PARAMETER_Victory_Annihilation","$STR_WF_PARAMETER_Victory_Assassination","$STR_WF_PARAMETER_Victory_Supremacy","$STR_WF_PARAMETER_Victory_Towns"};
		default = 2;
	};
	class gameplayViewDistance {
		title = "$STR_WF_PARAMETER_ViewDistance";
		values[] = {200,500,800,1000,1500,2000,2500,3000,3500,4000,4500,5000};
		texts[] = {"200m","500m","800m","1000m","1500m","2000m","2500m","3000m","3500m","4000m","4500m","5000m"};
		default = 3500;
	};
	class moduleHC {
		title = "$STR_WF_PARAMETER_HighCommand";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class moduleICBM {
		title = "$STR_WF_PARAMETER_ICBM";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class moduleUPSMON {
		title = "$STR_WF_PARAMETER_UPSMON";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class moduleVC {
		title = "$STR_WF_PARAMETER_Clouds";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 0;
	};
	class respawnCamps {
		title = "$STR_WF_PARAMETER_Camp";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Classic","$STR_WF_PARAMETER_Respawn_CampsNearby","$STR_WF_PARAMETER_Respawn_Defender"};
		default = 2;
	};
	class respawnCampsRule {
		title = "$STR_WF_PARAMETER_CampRespawnRule";
		values[] = {0,1,2};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Respawn_CampsRule_WestEast","$STR_WF_PARAMETER_Respawn_CampsRule_WestEastRes"};
		default = 2;
	};
	class respawnDelay {
		title = "$STR_WF_PARAMETER_Respawn";
		values[] = {10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90};
		texts[] = {"10 Seconds","15 Seconds","20 Seconds","25 Seconds","30 Seconds","35 Seconds","40 Seconds","45 Seconds","50 Seconds",
		"55 Seconds","60 Seconds","65 Seconds","70 Seconds","75 Seconds","80 Seconds","85 Seconds","90 Seconds"};
		default = 30;
	};
	class respawnMASH {
		title = "$STR_WF_PARAMETER_Respawn_MASH";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class respawnMobile {
		title = "$STR_WF_PARAMETER_MobileRespawn";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class respawnMobileGear {
		title = "$STR_WF_PARAMETER_MobileRespawnGear";
		values[] = {0,1};
		texts[] = {"$STR_WF_RESPAWN_GearDefault","$STR_WF_RESPAWN_GearCurrent"};
		default = 1;
	};
	class respawnPenalty {
		title = "$STR_WF_PARAMETER_Respawn_Penalty";
		values[] = {0,1,2,3,4};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Respawn_Penalty_Full","$STR_WF_PARAMETER_Respawn_Penalty_OneHalf","$STR_WF_PARAMETER_Respawn_Penalty_OneFourth","$STR_WF_PARAMETER_Respawn_Penalty_Mobile"};
		default = 3;
	};
	class respawnTownsRange {
		title = "$STR_WF_PARAMETER_TownRespawnRange";
		values[] = {50,100,150,200,250,300,350,400,450,500};
		texts[] = {"50m","100m","150m","200m","250m","300m","350m","400m","450m","500m"};
		default = 400;
	};
	class restrictionAdvancedAir {
		title = "$STR_WF_PARAMETER_AdvancedAir";
		values[] = {0,1,2};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_Restriction_Air_H","$STR_WF_PARAMETER_Restriction_Air_HTransport"};
		default = 0;
	};
	class townsAmount {
		title = "$STR_WF_PARAMETER_TownsAmount";
		values[] = {0,1,2,3,4};
		texts[] = {"$STR_WF_PARAMETER_Extra_Small","$STR_WF_PARAMETER_Small","$STR_WF_PARAMETER_IncomeSystem_Half","$STR_WF_PARAMETER_Large","$STR_WF_PARAMETER_Full"};
		default = 4;
	};
	class townsCamps {
		title = "$STR_WF_PARAMETER_TownsCamps";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class townsCaptureMode {
		title = "$STR_WF_PARAMETER_TownsCaptureMode";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_Classic","$STR_WF_PARAMETER_TownsCaptureMode_Threshold"};
		default = 1;
	};
	class townsConquestMode {
		title = "$STR_WF_PARAMETER_TownsConquestMode";
		values[] = {0,1};
		texts[] = {"$STR_WF_PARAMETER_Classic","$STR_WF_PARAMETER_Territorial"};
		default = 0;
	};
	class townsGear {
		title = "$STR_WF_PARAMETER_TownsGear";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_Disabled","$STR_WF_PARAMETER_CampSel","$STR_WF_PARAMETER_Depot","$STR_WF_PARAMETER_CampnDepot"};
		default = 1;
	};
	class townsOccupation {
		title = "$STR_WF_PARAMETER_Occupation";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	class townsOccupDifficulty {
		title = "$STR_WF_PARAMETER_Difficulty_Occupation";
		values[] = {1,2,3,4};
		texts[] = {"$STR_WF_PARAMETER_Light","$STR_WF_PARAMETER_Medium","$STR_WF_PARAMETER_Hard","$STR_WF_PARAMETER_Impossible"};
		default = 2;
	};
	#ifdef VANILLA
		class townsOccupationFactionEast {
			title = "$STR_WF_PARAMETER_Occupation_Type_East";
			values[] = {0,1};
			texts[] = {"Insurgents","Russians"};
			default = 1;
		};
	#endif
	#ifdef VANILLA
		class townsOccupationFactionWest {
			title = "$STR_WF_PARAMETER_Occupation_Type_West";
			values[] = {0,1};
			texts[] = {"Chernarussian Defence Force","United States Marine Corps"};
			default = 1;
		};
	#endif
	#ifdef ARROWHEAD
		class townsOccupationFactionEast {
			title = "$STR_WF_PARAMETER_Occupation_Type_East";
			values[] = {0};
			texts[] = {"Takistan Army"};
			default = 0;
		};
	#endif
	#ifdef ARROWHEAD
		class townsOccupationFactionWest {
			title = "$STR_WF_PARAMETER_Occupation_Type_West";
			values[] = {0};
			texts[] = {"United States"};
			default = 0;
		};
	#endif
	class townsMaxPatrol {
		title = "$STR_WF_PARAMETER_MaxResPatrols";
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {"$STR_WF_Disabled","1","2","3","4","5","6","7","8","9","10"};
		default = 0;
	};
	class townsProtectionRange {
		title = "$STR_WF_PARAMETER_TownProtectionRange";
		values[] = {250,500,1000};
		texts[] = {"250m","500m","1000m"};
		default = 250;
	};
	class townsPurchaseInfantry {
		title = "$STR_WF_PARAMETER_TownsPurchaseMilita";
		values[] = {0,1};
		texts[] = {"$STR_WF_Disabled","$STR_WF_Enabled"};
		default = 1;
	};
	#ifdef VANILLA
		class townsResistanceFaction {
			title = "$STR_WF_PARAMETER_Reinforcement_Type";
			values[] = {0};
			texts[] = {"Guerillas"};
			default = 0;
		};
	#endif
	#ifdef ARROWHEAD
		class townsResistanceFaction {
			title = "$STR_WF_PARAMETER_Reinforcement_Type";
			values[] = {0,1};
			texts[] = {"Private Military Company","Takistani Locals"};
			default = 1;
		};
	#endif
	class townsStartingMode {
		title = "$STR_WF_PARAMETER_StartingMode";
		values[] = {0,1,2,3};
		texts[] = {"$STR_WF_PARAMETER_None","$STR_WF_PARAMETER_Divided_Towns","$STR_WF_PARAMETER_Nearby_Town","$STR_WF_PARAMETER_StartingLocations_Random"};
		default = 0;
	};
};