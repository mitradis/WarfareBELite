if (!isServer) exitWith {};

if (isNil("KRON_UPS_INIT")) then {
	KRON_UPS_INIT=0;
};

waitUntil {sleep 0.05;KRON_UPS_INIT==1};

// convert argument list to uppercase
	_UCthis = [];
	for [{_i=0},{_i<count _this},{_i=_i+1}] do {_e=_this select _i; if (typeName _e=="STRING") then {_e=toUpper(_e)};_UCthis set [_i,_e]};

	if ((count _this)<2) exitWith {
		if (format["%1",_this]!="INIT") then {hint "UPS: Unit and marker name have to be defined!"};
	};


// Postioning
private["_targetX","_targetY","_relTX","_relTY","_relUX","_relUY","_waiting","_pursue","_newpos","_currPos","_orgPos","_targetPos","_attackPos","_flankPos","_avoidPos", "_speedmode"];
private["_dist","_lastdist","_lastmove1","_lastmove2","_gothit", "_supressed" , "_flankdist","_nBuilding","_nBuildingt","_distnbuid","_distnbuidt"];
private["_objsflankPos1","_cntobjs1","_objsflankPos2","_cntobjs2","_targettext","_dir1","_dir2","_dir3","_dd","_timeontarget","_react","_dirf1","_dirf2","_fightmode",
		"_flankPos2","_cosU","_sinU","_cosT","_sinT","_reinforcement","_reinforcementsent","_target","_targets","_flankdir","_prov","_lastpos","_newtarget","_planta","_nomove",
		"_newflankAngle","_sharedist" ,"_targetPosOld","_fldest","_grpidx","_grpid","_i","_unitpos","_Behaviour", "_incar", "_inheli" , "_inboat","_gunner","_driver"
		,"_vehicle","_minreact","_lastreact","_CombatMode","_rnd","_GetOutDist","_GetOut","_GetIn_NearestVehicles","_makenewtarget","_index","_wp","_grp","_wptype","_wpformation","_i"
		,"_targetdead","_frontPos","_GetIn","_dist1","_dist2","_dist3","_fldestfront","_fldest2","_bld","_blddist","_bldunitin","_flyInHeight","_fortify","_buildingdist","_rfid","_rfidcalled","_Mines"
		,"_enemytanks","_enemytanksnear","_friendlytanksnear","_mineposition","_enemytanknear","_roads","_timeout","_lastcurrpos","_wait","_countfriends","_side","_SURRENDER","_spawned","_nowp","_unitsIn"
		,"_ambush","_ambushed","_ambushdist","_friendside","_enemyside","_newattackPos","_fixedtargetpos","_NearestEnemy","_targetdist","_cargo","_targetsnear","_landing","_ambushwait"
		,"_membertypes","_respawn","_respawnmax","_lead","_safemode","_vehicles","_dist3","_lastwptype","_template","_unittype","_initstr","_fortifyorig","_nowpType","_ambushtype" ,"_vehicletypes", "_onroad","_loop2", "_tries2","_targetPosTemp","_sokilled","_sowounded","_nosmoke","_newunit","_rlastpos","_rcurrpos","_jumpers","_isSoldier"];


_grpid =0;
_exit = false;
_fldest = 0;
_unitpos = "AUTO";
_vehicle = objnull;
_minreact = KRON_UPS_minreact;
_lastreact = KRON_UPS_minreact;
_rnd = 0.0;
_GetOutDist = 0;
_GetOut=false;
_index = 0;
_wp=[];
_wptype="HOLD";
_wpformation = "VEE";
_targetdead = false;
_GetIn=false;
_dist3 = 0;
_fldestfront = 0;
_fldest2=0;
_bld = objnull;
_flyInHeight = 0;
_rfid = 0;
_rfidcalled = false;
_Mines = 3;
_enemytanks = [];
_friendlytanks =[];
_enemytanksnear = false;
_friendlytanksnear = false;
_mineposition = [0,0,0];
_enemytanknear = objnull;
_NearestEnemy = objnull;
_roads = [];
_timeout = 0;
_wait=90;
_countfriends = 0;
_side="";
_friendside=[];
_enemyside=[];
_SURRENDER = 0;
_surrended = false;
_inheli = false;
_spawned = false;
_nowp = false;
_unitsIn = [];
_ambush = false;
_ambushed = false;
_ambushdist = KRON_UPS_ambushdist;
_dist2 = 0;
_targetdist = 10000;
_cargo = [];
_targetsnear = false;
_landing=false;
_ambushwait = 10000;
_membertypes = [];
_vehicletypes =[];
_respawn = false;
_respawnmax = 10000;
_lead=objnull;
_safemode=["CARELESS","SAFE"];
_vehicles = [];
_dist3=0;
_lastwptype = "";
_unittype = "";
_initstr = "";
_fortifyorig= false;
_rlastPos = [0,0,0];

// unit that's moving
_obj = leader (_this select 0); //group or leader
_npc = _obj;


// give this group a unique index
KRON_UPS_Instances = KRON_UPS_Instances + 1;
_grpid = KRON_UPS_Instances;
_grpidx = format["%1",_grpid];
_grpname = format["%1_%2",(side _npc),_grpidx];
_side = side _npc;


//To not run all at the same time we hope to have as many seconds as id's
_rnd = _grpid;
sleep _rnd ;


// == set "UPSMON_grpid" to units in the group and EH===============================
	{
		_x setVariable ["UPSMON_grpid", _grpid, false];
		sleep 0.05;


		if (side _x != civilian) then
		{//soldiers
			_x AddEventHandler ["hit", {nul = _this spawn R_SN_EHHIT}];
			sleep 0.05;
			_x AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLED}];
			sleep 0.05;
		}
		else
		{//civ
			_x removeAllEventHandlers "firedNear";
			sleep 0.05;
			_x AddEventHandler ["firedNear", {nul = _this spawn R_SN_EHFIREDNEAR}];
			sleep 0.05;
			_x removeAllEventHandlers "killed";
			sleep 0.05;
			_x AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLEDCIV}];
			sleep 0.05;
		};
	} foreach units _npc;

	//if is vehicle will not be in units so must set manually
	if (isnil {_npc getVariable ("UPSMON_grpid")}) then {
		_npc setVariable ["UPSMON_grpid", _grpid, false];
		sleep 0.05;

		if (side _npc != civilian) then
		{//soldiers
			_npc AddEventHandler ["hit", {nul = _this spawn R_SN_EHHIT}];
			sleep 0.05;
			_npc AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLED}];
			sleep 0.05;
		}
		else
		{ //civilian
			_npc removeAllEventHandlers "firedNear";
			sleep 0.05;
			_npc AddEventHandler ["firedNear", {nul = _this spawn R_SN_EHFIREDNEAR}];
			sleep 0.05;



			_npc removeAllEventHandlers "killed";
			sleep 0.05;
			_npc AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLEDCIV}];
			sleep 0.05;
		}
	};
	//the index will be _grpid
	R_GOTHIT_ARRAY = R_GOTHIT_ARRAY + [0];


// == get the name of area marker ==============================================
	_areamarker = _this select 1;
	if (isNil ("_areamarker")) exitWith {
		hint "UPS: Area marker not defined.\n(Typo, or name not enclosed in quotation marks?)";
	};

	// remember center position of area marker
	_centerpos = getMarkerPos _areamarker;
	_centerX = abs(_centerpos select 0);
	_centerY = abs(_centerpos select 1);
	_centerpos = [_centerX,_centerY];

	// show/hide area marker
	_showmarker = if ("SHOWMARKER" in _UCthis) then {"SHOWMARKER"} else {"HIDEMARKER"};
	if (_showmarker=="HIDEMARKER") then {
		//_areamarker setMarkerCondition "false"; // VBS2
		_areamarker setMarkerPos [-abs(_centerX),-abs(_centerY)];
	};

// is anybody alive in the group?
	_exit = true;
	if (typename _npc=="OBJECT") then {
		if (!isnull group _npc) then {
			_npc = [_npc,units (group _npc)] call MON_getleader;
		}else{
			_vehicles = [_npc,2] call MON_nearestSoldiers;
			if !(isNil '_vehicles') then {
				if (count _vehicles>0) then {
					_npc = [_vehicles select 0,units (_vehicles select 0)] call MON_getleader;
				};
			};
		};
	} else {
		if (count _obj>0) then {
			_npc = [_obj,count _obj] call MON_getleader;
		};
	};


	// set the leader in the vehilce
	if (!(_npc iskindof "Man")) then {
		if (!isnull(commander _npc) ) then {
			_npc = commander _npc;
		}else{
			if (!isnull(driver _npc) ) then {
				_npc = driver _npc;
			}else{
				_npc = gunner _npc;
			};
		};
		group _npc selectLeader _npc;
	};

// ===============================================
	if (alive _npc) then {_exit = false;};

	// exit if something went wrong during initialization (or if unit is on roof)
	if (_exit) exitWith {};

// remember the original group members, so we can later find a new leader, in case he dies
	_members = units _npc;
	KRON_UPS_Total = KRON_UPS_Total + (count _members);

//Fills member soldier types
	_vehicles = [];
	{
		if (vehicle _x != _x ) then {
			_vehicles = _vehicles - [vehicle _x];
			_vehicles = _vehicles + [vehicle _x];
		};
		_membertypes = _membertypes + [typeof _x];
	} foreach _members;

//Fills member vehicle types
	{
		_vehicletypes = _vehicletypes + [typeof _x];
	} foreach _vehicles;

// what type of "vehicle" is _npc ?
	_isman = "Man" countType [ vehicle _npc]>0;
	_iscar = "LandVehicle" countType [vehicle _npc]>0;
	_isboat = "Ship" countType [vehicle _npc]>0;
	_isplane = "Air" countType [vehicle _npc]>0;

// we just have to brute-force it for now, and declare *everyone* an enemy who isn't a civilian
	_isSoldier = _side != civilian;

	_friends=[];
	_enemies=[];
	_sharedenemy=0;

	if (_isSoldier) then {
		switch (_side) do {
		case west:
			{ 	_sharedenemy=0;
				_friendside = [west];
				_enemyside = [east];
			};
		case east:
			{  _sharedenemy=1;
				_friendside = [east];
				_enemyside = [west];
			};
		case resistance:
			{
			 _sharedenemy=2;
			 _enemyside = KRON_UPS_Res_enemy;

				if (!(east in _enemyside)) then {
					_friendside = [east];
				};
				if (!(west in _enemyside)) then {
					_friendside = [west];
				};
			};
		};
	};

	if (_side in KRON_UPS_Res_enemy) then {
		_enemyside = _enemyside + [resistance];
	}else {
		_friendside = _friendside + [resistance];
	};
	sleep 0.05;

//Sets min units alive for surrender
	_surrender = call (compile format ["KRON_UPS_%1_SURRENDER",_side]);



	// Tanks friendlys are contabiliced
{
	if ( side _x in _friendside && ( _x iskindof "Tank"  || _x iskindof "Wheeled_APC" )) then {
		_friendlytanks = _friendlytanks + [_x];
	};
}foreach vehicles;

// global unit variable to externally influence script
//call compile format ["KRON_UPS_%1=1",_npcname];

// X/Y range of target area
_areasize = getMarkerSize _areamarker;
_rangeX = _areasize select 0;
_rangeY = _areasize select 1;
_area = abs((_rangeX * _rangeY) ^ 0.5);
// marker orientation (needed as negative value!)
_areadir = (markerDir _areamarker) * -1;


// store some trig calculations
_cosdir=cos(_areadir);
_sindir=sin(_areadir);

// minimum distance of new target position
_mindist=(_rangeX^2+_rangeY^2)/3;
if (_rangeX==0) exitWith {
	hint format["UPS: Cannot patrol Sector: %1\nArea Marker doesn't exist",_areamarker];
};

// remember the original mode & speed
_orgMode = behaviour _npc;
_orgSpeed = speedmode _npc;

// set first target to current position (so we'll generate a new one right away)
_currPos = getpos _npc;
_orgPos = _currPos;
_orgDir = getDir _npc;
_orgWatch=[_currPos,50,_orgDir] call KRON_relPos;
_lastpos = _currPos;
_lastcurrpos = _currpos;

_avoidPos = [0,0];
_flankPos = [0,0];
_attackPos = [0,0];
_newattackPos = [0,0];
_fixedtargetpos = [0,0];
_frontPos = [0,0];
_dirf1 = 0;_dirf2=0;_flankPos2=[0,0];
_dist = 10000;
_lastdist = 0;
_lastmove1 = 0;
_lastmove2 = 0;
_maxmove=0;
_moved=0;

_damm=0;
_dammchg=0;
_lastdamm = 0;
_timeontarget = 0;
_react = 0;

_fightmode = "walk";
_fm=0;
_gothit = false;
_pursue = false;
_hitPos=[0,0,0];
_lastknown = 0;
_opfknowval = 0;

_sin0=1;
_sin90=1; _cos90=0;
_sin270=-1; _cos270=0;
_targetX =0; _targetY=0;
_relTX=0;_relTY=0;
_relUX=0;_relUY=0;
_supressed = false;
_flankdist=0;
_nBuilding=nil;
_nBuildingt =nil;
_speedmode="Limited";
_distnbuid = 0;
_distnbuidt = 0;
_objsflankPos1 =  [];
_cntobjs1 = 0;
_objsflankPos2 =  [];
_cntobjs2 = 0;
_targettext ="";
_dir1 =0;_dir2=0;_dir3=0;_dd=0;
_reinforcement ="";
_reinforcementsent = false;
_target = objnull;
_newtarget=objnull;
_flankdir=0; //1 tendencia a flankpos1, 2 tendencia a flankpos2
_prov=0;
_targets=[];
_planta=0; //Indice de plantas en edificios
_newflankAngle = 0;
_closeenough = KRON_UPS_closeenough;
_gunner = objnull;
_driver = objnull;
_fortify = false;
_buildingdist= 60;//Distance to search buildings near
_Behaviour = "SAFE";
_grp = grpnull;
_grp = group _npc;
_template = 0;
_nowpType = 1;
_ambushtype = 1;
_rstuckControl = 0;


// set target tolerance high for choppers & planes
if (_isplane) then {_closeenough = KRON_UPS_closeenough * 2};

// ***************************************** optional arguments *****************************************

// wait at patrol end points
_pause = if ("NOWAIT" in _UCthis) then {"NOWAIT"} else {"WAIT"};
// don't move until an enemy is spotted
_nomove  = if ("NOMOVE" in _UCthis) then {"NOMOVE"} else {"MOVE"};
//fortify group in near places
	_fortify= if ("FORTIFY" in _UCthis) then {true} else {false};
	_fortifyorig = _fortify;
	if (_fortify) then {
		_nomove="NOMOVE";
		_minreact = KRON_UPS_minreact * 3;
		_buildingdist = _buildingdist * 2;
		_makenewtarget = true;
		_wait = 3000;
	};

// create _targerpoint on the roads only (by this group)
	_onroad = if ("ONROAD" in _UCthis) then {true} else {false};
// do not use smoke (by this group)
	_nosmoke = if ("NOSMOKE" in _UCthis) then {true} else {false};

// don't make waypoints
	_nowp = if ("NOWP" in _UCthis) then {true} else {false};
	_nowp = if ("NOWP2" in _UCthis) then {true} else {_nowp};
	_nowp = if ("NOWP3" in _UCthis) then {true} else {_nowp};
	_nowpType = if ("NOWP2" in _UCthis) then {2} else {_nowpType};
	_nowpType = if ("NOWP3" in _UCthis) then {3} else {_nowpType};

//Ambush squad will no move until in combat or so close enemy
	_ambush= if ("AMBUSH" in _UCthis) then {true} else {false};
	_ambush= if ("AMBUSH:" in _UCthis) then {true} else {_ambush};
	_ambush= if ("AMBUSH2" in _UCthis) then {true} else {_ambush};
	_ambushwait = ["AMBUSH:",_ambushwait,_UCthis] call KRON_UPSgetArg;
	_ambushwait = ["AMBUSH2:",_ambushwait,_UCthis] call KRON_UPSgetArg;
	_ambushType = if ("AMBUSH2" in _UCthis) then {2} else {_ambushType};
	_ambushType = if ("AMBUSH2:" in _UCthis) then {2} else {_ambushType};

// respawn
	_respawn = if ("RESPAWN" in _UCthis) then {true} else {false};
	_respawn = if ("RESPAWN:" in _UCthis) then {true} else {_respawn};
	_respawnmax = ["RESPAWN:",_respawnmax,_UCthis] call KRON_UPSgetArg;
	if (!_respawn) then {_respawnmax = 0};

// any init strings?
	_initstr = ["INIT:","",_UCthis] call KRON_UPSgetArg;

// don't follow outside of marker area
	_nofollow = if ("NOFOLLOW" in _UCthis) then {"NOFOLLOW"} else {"FOLLOW"};
// share enemy info
	_shareinfo = if ("NOSHARE" in _UCthis) then {"NOSHARE"} else {"SHARE"};
// "area cleared" trigger activator
	_areatrigger = if ("TRIGGER" in _UCthis) then {"TRIGGER"} else {if ("NOTRIGGER" in _UCthis) then {"NOTRIGGER"} else {"SILENTTRIGGER"}};

	// suppress fight behaviour
	if ("NOAI" in _UCthis) then {_isSoldier=false};

	// adjust cycle delay
	_cycle = ["CYCLE:",KRON_UPS_Cycle,_UCthis] call KRON_UPSgetArg;
	_currcycle=_cycle;

	//spawned for squads created in runtime
	_spawned= if ("SPAWNED" in _UCthis) then {true} else {false};
	if (_spawned) then {
		switch (side _npc) do {
			case west:
			{ 	KRON_AllWest=KRON_AllWest + units _npc;
			};
			case east:
			{  	KRON_AllEast=KRON_AllEast + units _npc; };
			case resistance:
			{
				KRON_AllRes=KRON_AllRes + units _npc;
				if (east in KRON_UPS_Res_enemy ) then {
					KRON_UPS_East_enemies = KRON_UPS_East_enemies+units _npc;
				} else {
					KRON_UPS_East_friends = KRON_UPS_East_friends+units _npc;
				};
				if (west in KRON_UPS_Res_enemy ) then {
					KRON_UPS_West_enemies = KRON_UPS_West_enemies+units _npc;
				} else {
					KRON_UPS_West_friends = KRON_UPS_West_friends+units _npc;
				};
			};
		};
		call (compile format ["KRON_UPS_%1_Total = KRON_UPS_%1_Total + count (units _npc)",side _npc]);

		_vehicletypes = ["VEHTYPE:",_vehicletypes,_UCthis] call KRON_UPSgetArg; //!R

	};

// set drop units at random positions
	_initpos = "ORIGINAL";
	if ("RANDOM" in _UCthis) then {_initpos = "RANDOM"};
	if ("RANDOMUP" in _UCthis) then {_initpos = "RANDOMUP"};
	if ("RANDOMDN" in _UCthis) then {_initpos = "RANDOMDN"};
	// don't position groups or vehicles on rooftops
	if ((_initpos!="ORIGINAL") && ((!_isman) || (count _members)>1)) then {_initpos="RANDOMDN"};

	// set behaviour modes (or not)
	_orgMode = "SAFE";
	if ("CARELESS" in _UCthis) then {_orgMode = "CARELESS"};
	if ("AWARE" in _UCthis) then {_orgMode = "AWARE"};
	if ("COMBAT" in _UCthis) then {_orgMode = "COMBAT"};
	if ("STEALTH" in _UCthis) then {_orgMode = "STEALTH"};

// set original beahviour
	if (!_isSoldier) then {
		_Behaviour = "CARELESS";
	} else {
		_Behaviour = _orgMode;
	};
	_npc setbehaviour _Behaviour;


// set initial speed
	_noslow = if ("NOSLOW" in _UCthis) then {"NOSLOW"} else {"SLOW"};
	if (_noslow!="NOSLOW") then {
		_orgSpeed = "limited";
	} else {
		_orgSpeed = "FULL";
	};
	_speedmode = _orgSpeed;
	_npc setspeedmode _speedmode;

// set If enemy detected reinforcements will be sent REIN1
	_reinforcement= if ("REINFORCEMENT" in _UCthis) then {"REINFORCEMENT"} else {"NOREINFORCEMENT"}; //rein_yes
	_rfid = ["REINFORCEMENT:",0,_UCthis] call KRON_UPSgetArg; // rein_#

	if (_rfid>0) then {
		_reinforcement="REINFORCEMENT";
	};

//set Is a template for spawn module?
	_template = ["TEMPLATE:",_template,_UCthis] call KRON_UPSgetArg;
	//Fills template array for spawn
	if (_template > 0 && !_spawned) then {
		KRON_UPS_TEMPLATES = KRON_UPS_TEMPLATES + ( [[_template]+[_side]+[_membertypes]+[_vehicletypes]] );
	};

// make start position random
	if (_initpos!="ORIGINAL") then {
		// find a random position (try a max of 20 positions)
		_try=0;
		_bld=0;
		_bldpos=0;
		while {_try<20} do {
			_currPos=[_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
			_posinfo=[_currPos] call KRON_PosInfo3;
			// _posinfo: [0,0]=no house near, [obj,-1]=house near, but no roof positions, [obj,pos]=house near, with roof pos
			_bld=_posinfo select 0;
			_bldpos=_posinfo select 1;
			if (_isplane || _isboat || !(surfaceiswater _currPos)) then {
				if (((_initpos=="RANDOM") || (_initpos=="RANDOMUP")) && (_bldpos>0)) then {_try=99};
				if (((_initpos=="RANDOM") || (_initpos=="RANDOMDN")) && (_bldpos==0)) then {_try=99};
			};
			_try=_try+1;
			sleep 0.05;
		};
		if (_bldpos==0) then {
			if (_isman) then {
				{_x setpos _currPos} foreach units _npc;
			} else {
				_npc setpos _currPos;
			};
		} else {
		// put the unit on top of a building
			_npc setPos (_bld buildingPos _bldpos);
			_currPos = getPos _npc;
			_nowp=true; // don't move if on roof
		};
	};

// track unit ======================================================================================
	_track = 	if ("TRACK" in _UCthis) then {"TRACK"} else {"NOTRACK"};
	_trackername = "";
	_destname = "";
	if (_track=="TRACK") then {
		_track = "TRACK";
		_trackername=format["trk_%1",_grpidx];
		_markerobj = createMarker[_trackername,[0,0]];
		_markerobj setMarkerShape "ICON";
		_markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Dot")) then {"WTF_DOT"} else {"DOT"};
		_trackername setMarkerType _markertype;
		_markercolor = switch (side _npc) do {
			case west: {"ColorGreen"};
			case east: {"ColorRed"};
			case resistance: {"ColorBlue"};
			default {"ColorBlack"};
		};
		_trackername setMarkerColor _markercolor;
		_trackername setMarkerText format["%1",_grpidx];
		_trackername setmarkerpos _currPos;

		_destname=format["dest_%1",_grpidx];
		_markerobj = createMarker[_destname,[0,0]];
		_markerobj setMarkerShape "ICON";
		_markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Flag")) then {"WTF_FLAG"} else {"FLAG"};
		_destname setMarkerType _markertype;
		_destname setMarkerColor _markercolor;
		_destname setMarkerText format["%1",_grpidx];
		_destname setMarkerSize [.5,.5];
	};


// delete dead units ==============================================================================
	_deletedead = ["DELETE:",0,_UCthis] call KRON_UPSgetArg;
	if (_deletedead>0) then {
		{
			_x addEventHandler['killed',format["[_this select 0,%1] spawn KRON_deleteDead",_deletedead]];
			sleep 0.05;
		}forEach _members;
	};

// how many group clones? =========================================================================
// TBD: add to global side arrays?
	_mincopies = ["MIN:",0,_UCthis] call KRON_UPSgetArg;
	_maxcopies = ["MAX:",0,_UCthis] call KRON_UPSgetArg;
	if (_mincopies>_maxcopies) then {_maxcopies=_mincopies};
	if (_maxcopies>140) exitWith {hint "Cannot create more than 140 groups!"};
	if (_maxcopies>0) then {
		_copies=_mincopies+random (_maxcopies-_mincopies);

	// create the clones
		for "_grpcnt" from 1 to _copies do {
			// copy groups
			if (isNil ("KRON_grpindex")) then {KRON_grpindex = 0};
			KRON_grpindex = KRON_grpindex+1;
			// copy group leader
			_unittype = typeof _npc;
			// make the clones civilians
			// use random Civilian models for single unit groups
			if ((_unittype=="Civilian") && (count _members==1)) then {_rnd=1+round(random 20); if (_rnd>1) then {_unittype=format["Civilian%1",_rnd]}};

			_grp=createGroup side _npc;
			_lead = _grp createUnit [_unittype, getpos _npc, [], 0, "form"];
			_lead setVehicleVarName format["l%1",KRON_grpindex];
			call compile format["l%1=_lead",KRON_grpindex];
			_lead setBehaviour _orgMode;
			_lead setSpeedmode _orgSpeed;
			_lead setSkill skill _npc;
			_lead setVehicleInit _initstr;
			[_lead] join _grp;
			_grp selectLeader _lead;
			// copy team members (skip the leader)
			_i=0;
			{
				_i=_i+1;
				if (_i>1) then {
					_newunit = _grp createUnit [typeof _x, getpos _x, [],0,"form"];
					_newunit setBehaviour _orgMode;
					_newunit setSpeedMode _orgSpeed;
					_newunit setSkill skill _x;
					_newunit setVehicleInit _initstr;
					[_newunit] join _grp;
				};
			} foreach _members;
			_nul=[_lead,_areamarker,_pause,_noslow,_nomove,_nofollow,_initpos,_track,_showmarker,_shareinfo,"DELETE:",_dead] execVM "Server\Module\UPSMON\upsmon.sqf";
			//sleep 0.05;
		};
		processInitCommands;
		sleep 0.05;
	};


// units that can be left for area to be "cleared" =============================================================================================
	_zoneempty = ["EMPTY:",0,_UCthis] call KRON_UPSgetArg;

// create area trigger =========================================================================================================================
	if (_areatrigger!="NOTRIGGER") then {
		_trgside = switch (side _npc) do { case west: {"WEST"}; case east: {"EAST"}; case resistance: {"GUER"}; case civilian: {"CIV"};};
		//_trgside = switch (side _npc) do { case west: {"EAST"}; case east: {"WEST"}; case resistance: {"ANY"}; case civilian: {"ANY"};};
		_trgname="KRON_Trig_"+_trgside+"_"+_areamarker;
		_flgname="KRON_Cleared_"+_areamarker;
		// has the trigger been created already?
		trgnameNil=true;
		call compile format["%1=false",_flgname];
		call compile format["if !(isNil '%1') then {trgnameNil=false}",_trgname];
		if (trgnameNil) then {
			// trigger doesn't exist yet, so create one (make it a bit bigger than the marker, to catch path finding 'excursions' and flanking moves)
			call compile format["%1=createTrigger['EmptyDetector',_centerpos]",_trgname];
			call compile format["%1 setTriggerArea[_rangeX*1.5,_rangeY*1.5,markerDir _areamarker,true]",_trgname];
			call compile format["%1 setTriggerActivation[_trgside,'PRESENT',true]",_trgname];
			call compile format["%1 setEffectCondition 'true'",_trgname];
			call compile format["%1 setTriggerTimeout [5,7,10,true]",_trgname];
			if (_areatrigger!="SILENTTRIGGER") then {
				call compile format["%1 setTriggerStatements['count thislist<=%6', 'titletext [''SECTOR <%2> LIMPIO'',''PLAIN''];''%2'' setmarkerpos [-%4,-%5];%3=true;', 'titletext [''SECTOR <%2> HA SIDO REOCUPADO'',''PLAIN''];''%2'' setmarkerpos [%4,%5];%3=false;']", _trgname,_areamarker,_flgname,_centerX,_centerY,_zoneempty];

			} else {
				call compile format["%1 setTriggerStatements['count thislist<=%3', '%2=true;', '%2=false;']", _trgname,_flgname,_zoneempty];
			};
		};
		sleep 0.05;
	};

//If a soldier has a useful building takes about ======================================================================================================================
	if ( _nomove=="NOMOVE" ) then {
			sleep 10;
			 _unitsIn = [_grpid,_npc,150] call MON_GetIn_NearestStatic;
			if ( count _unitsIn > 0 ) then { sleep 10};
			[_npc, _buildingdist,false,_wait,true] spawn MON_moveNearestBuildings;
		};

// init done
	_makenewtarget=true;
	_newpos=false;
	_targetPos = [0,0,0];//_currPos;
	_targettext ="_currPos";
	_swimming = false;
	_waiting = if (_nomove=="NOMOVE") then {9999} else {0};
	_sharedist = if (_nomove=="NOMOVE") then {KRON_UPS_sharedist} else {KRON_UPS_sharedist*1.5};


//Gets position of waypoint if no targetpos
	if (format ["%1", _targetPos] == "[0,0,0]") then {
		_index = (count waypoints _grp) - 1;
		_wp = [_grp,_index];
		_targetPos = waypointPosition _wp;
		if (([_currpos,_targetPos] call KRON_distancePosSqr)<= 20) then {_targetPos = [0,0,0];};
	};

// ***********************************************************************************************************
// ************************************************ MAIN LOOP ************************************************
// ***********************************************************************************************************

scopeName "main";

_loop=true;

while {_loop} do {

	_timeontarget=_timeontarget+_currcycle;
	_react=_react+_currcycle;
	_waiting = _waiting - _currcycle;
	_lastreact = _lastreact+_currcycle;
	_newpos = false;
	_sokilled = false;
	_sowounded = false;
	// CHECK IF did anybody in the group got hit or die?
	if ((R_GOTHIT_ARRAY select _grpId) != 0) then
	{
		_gothit = true;

		if ((R_GOTHIT_ARRAY select _grpId) == 1) then
		{
			_sowounded = true;
		}
		else
		{
			_sokilled = true;
		};
	sleep 0.05;
	R_GOTHIT_ARRAY set [_grpId, 0];
	};





	// nobody left alive, exit routine
	if (count _members==0) then {
		_exit=true;
	} else {
		// did the leader die?
		_npc = [_npc,_members] call MON_getleader;
		if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
	};

	//exits from loop
	if (_exit) exitwith {};


	//Checks if surrender is enabled
	if ( _surrender > 0 ) then {
		_surrended = call (compile format ["KRON_UPS_%1_SURRENDED",_side]);
	};

	//If surrended exits from script
	if (_surrended) exitwith {
		{
			[_x] spawn MON_surrender;
		}foreach _members;

	};

	//Assign the current leader of the group in the array of group leaders
	KRON_NPCs set [_grpid,_npc];

	// current position
	_currPos = getpos _npc; _currX = _currPos select 0; _currY = _currPos select 1;
	if (_track=="TRACK") then { _trackername setmarkerpos _currPos; };


	// if the AI is a civilian we don't have to bother checking for enemy encounters
	if ( _isSoldier && !_exit) then {
		_pursue=false;
		//_Behaviour = Behaviour _npc;

		//Variables to see if the leader is in a vehicle
		_incar = "LandVehicle" countType [vehicle (_npc)]>0;
		_inheli = "Air" countType [vehicle (_npc)]>0;
		_inboat = "Ship" countType [vehicle (_npc)]>0;


		//If the group is strengthened and the enemies have been detected are sent to target
		if (_rfid > 0 ) then {
			_rfidcalled = call (compile format ["KRON_UPS_reinforcement%1",_rfid]); // will be TRUE when variable in triger will be true.
			if (isnil "_rfidcalled") then {_rfidcalled=false};
			_fixedtargetPos = call (compile format ["KRON_UPS_reinforcement%1_pos",_rfid]); // will be position os setfix target of sending reinforcement
			if (isnil "_fixedtargetPos") then {
				_fixedtargetPos=[0,0];
			}else{
				_fixedtargetPos =  [abs(_fixedtargetPos select 0),abs(_fixedtargetPos select 1)];
				_target = objnull;
			};
		};
		sleep 0.05;

		//Reinforcement control
		if (_reinforcement=="REINFORCEMENT") then {
			// (global call  OR id call) AND !send yet
			if ( (KRON_UPS_reinforcement || _rfidcalled) && (!_reinforcementsent)) then {
				_reinforcementsent=true;
				_fortify = false;
				_minreact = KRON_UPS_minreact;
				_buildingdist = 60;
				_react = _react + 100;
				_waiting = -1;
			}else{
				// !(global or id call) AND send
				if ( !(KRON_UPS_reinforcement || _rfidcalled) && (_reinforcementsent)) then {
					_fixedtargetPos = [0,0];
					_attackPos = [0,0];
					_fortify = _fortifyorig;
					_reinforcementsent=false;
					if (_rfid > 0 ) then {
						call (compile format ["KRON_UPS_reinforcement%1_pos = [0,0]",_rfid]);
						call (compile format ["KRON_UPS_reinforcement%1 = false",_rfid]);
					};
				};
			};
		};

		//Gets targets from radio
		_targets = call (compile format ["KRON_targets%1",_sharedenemy]);

		//Reveal targets found by members to leader
		{
			//_NearestEnemy = assignedTarget _x;
			_NearestEnemy = _x findnearestenemy _x;
			if (_x knowsabout _NearestEnemy > R_knowsAboutEnemy && (_npc knowsabout _NearestEnemy <= R_knowsAboutEnemy || count _targets <= 0 )) then 	{

				if (_npc knowsabout _NearestEnemy <= R_knowsAboutEnemy ) then 	{
					_npc reveal _NearestEnemy;
				};

				//If no targets adds this
				if (count _targets <= 0) then {
					//_target = _NearestEnemy;
					_targets = _targets + [_NearestEnemy];
					_NearestEnemy setvariable ["UPSMON_lastknownpos", position _NearestEnemy, false];
				};
			};
		} foreach units _npc;


		//if no target but _npc knows enemy then this is _target
		if (isNull (_target)) then {
			{
				if ((_npc knowsabout _x > R_knowsAboutEnemy) && (alive _x) && (canmove _x)) then {
					_target =_x;
					if (!isNull (_target)) exitWith{};
				};
			} foreach _targets;
		};




		//Resets distance to target
		_dist = 10000;

		//Gets  current known position of target and distance
		if ( !isNull (_target) && alive _target ) then {
			_newattackPos = _target getvariable ("UPSMON_lastknownpos");

			if ( !isnil "_newattackPos" ) then {
				_attackPos=_newattackPos;
				//Gets distance to target known pos
				_dist = ([_currpos,_attackPos] call KRON_distancePosSqr);
			};
		};


		//Initialization for geting new targets
		//If the current target is dead or no prior knowledge is cleaned
		if (isNull (_target) || !alive _target || !canmove _target ) then {
			_lastknown = 0;
			_opfknowval = 0;
			_target = objnull;
		};

		_newtarget = _target;


		if ((_shareinfo=="SHARE")) then {

			//Requests for radio the enemy's position, if it is within the range of acts
			if ((KRON_UPS_comradio == 2)) then
			{
				_targetsnear = false;

				//I we have a close target alive do not search another
				if (!alive _target || !canmove _target || _dist > _closeenough) then {
					{
						 if ( !isnull _x && canmove _x && alive _x ) then {

							_newattackPos = _x getvariable ("UPSMON_lastknownpos");

							if (  !isnil "_newattackPos" ) then {
								_dist3 = ([_currpos,_newattackPos] call KRON_distancePosSqr);

								//Sets if near targets to begin warning
								IF ( _dist3 <= (_closeenough + KRON_UPS_safedist)) then { _targetsnear = true };

								//Sets new target
								if ( ( isnull (_newtarget) || captive _newtarget|| !alive _newtarget|| !canmove _newtarget || _dist3 < _dist )
								&& ( _dist3 <= _sharedist || _reinforcementsent )
								&& ( !(_x iskindof "Air") || (_x iskindof "Air" && _isplane ))
								&& ( !(_x iskindof "Ship") || (_x iskindof "Ship" && _isboat ))
								&& ( _x emptyPositions "Gunner" == 0 && _x emptyPositions "Driver" == 0
								|| (!isnull (gunner _x) && canmove (gunner _x))
								|| (!isnull (driver _x) && canmove (driver _x)))
								) then {
									_newtarget = _x;
									_opfknowval = _npc knowsabout _x;
									_dist = _dist3;
									if (_dist < _closeenough) exitWith {};
								};
							};
						};
					} foreach _targets;
					sleep 0.5;
				};
			};

			//If you change the target changed direction flanking initialize
			if ( !isNull (_newtarget) && alive _newtarget && canmove _newtarget && (_newtarget != _target || isNull (_target)) ) then {
				_timeontarget = 0;
				_targetdead = false;
				_flankdir= if (random 100 <= 10) then {0} else {_flankdir};
				_target = _newtarget;
			};
		};

	// use smoke when hit or s/o killed
	if !_nosmoke then {
		{
			//when hit
			if (_sowounded && random 100 < R_USE_SMOKE_wounded) then {
				nul = [_x,_target] spawn MON_throw_grenade;
			};

			//when die
			if (_sokilled && random 100 < R_USE_SMOKE_killed) then {
				nul = [_x,_target] spawn MON_throw_grenade;
			};
		sleep 0.1;
		} foreach _members;
	};



		//Gets  current known position of target and distance
		if ( !isNull (_target) && alive _target ) then {
			//Enemy detected
			if (_fightmode != "fight" ) then {
				_fightmode = "fight";
				_npc setCombatMode "YELLOW";  // !R
				_react = KRON_UPS_react;

				if (_nowpType == 1) then {
					nul = [_npc] call R_FN_deleteObsoleteWaypoints;
					_nowp = false;
				};
			};

			_newattackPos = _target getvariable ("UPSMON_lastknownpos");

			if ( !isnil "_newattackPos" ) then {
				_attackPos=_newattackPos;
				//Gets distance to target known pos
				_dist = ([_currpos,_attackPos] call KRON_distancePosSqr);
				//Looks at target known pos
				_members lookat _attackPos;
			};
		};

		//If the enemy has moved away from the radio coverage is not a reinforcement sent we will have lost track
		if ( _fightmode != "walk" && !isnull(_target) && _dist < 15 &&  _npc knowsabout _target < R_knowsAboutEnemy ) then {
			//If squad is near last position and no target clear position of target
			_fightmode="walk";
			_speedmode = _orgSpeed;
			_target = objnull;
			_Behaviour = _orgMode;
			_waiting = -1;
			_unitpos = "AUTO";
			_pursue=false;
			_targetdead	= true;
			_makenewtarget = true; //Go back to the original position
		};

		//If knowledge of the target increases accelerate the reaction
		if (_opfknowval>_lastknown ) then {
			_react = _react + 20;
		};

		// if spotted an enemy or got shot, so start pursuit, if in combat and exceed time to react or movecompleted
		if (_fightmode != "walk" && ((_react >= KRON_UPS_react && _lastreact >=_minreact) || moveToCompleted _npc )) then {
			_pursue=true;
		};


		//Ambush ==========================================================================================================
		if (_ambush && !_ambushed) then {
			_ambushed = true;
			_nowp = true;
			_currcycle = 2;
			_grp setFormation "LINE";
			_npc setBehaviour "STEALTH";
			_npc setSpeedMode "FULL";
			sleep 10;
			{
				[_x,"DOWN"] spawn MON_setUnitPos;
				_x stop true;
			}foreach units _npc;

			//Puts a mine if near road
			if ( KRON_UPS_useMines && _ambushType == 1 ) then {
				_npc setBehaviour "careless";
				_dir1 = getDir _npc;
				_mineposition = [position _npc,_dir1, 25] call MON_GetPos2D;
				_roads = _mineposition nearroads KRON_UPS_ambushdist;

				if (count _roads > 0) then {
					_mineposition = position (_roads select 0);
					if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};

					if (count _roads > 3) then {
						_mineposition = position (_roads select 3);
						if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};
					};

				} else {
					_mineposition = [position _npc,(_dir1-30)mod 360, KRON_UPS_ambushdist + random 15] call MON_GetPos2D;
					if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};

					_mineposition = [position _npc,(_dir1+30)mod 360, KRON_UPS_ambushdist + random 15] call MON_GetPos2D;
					if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};
				};

				_mineposition = [position _npc,_dir1, KRON_UPS_ambushdist + random 20] call MON_GetPos2D;
				if ([_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};

				_mineposition = [position _npc,_dir1-15, KRON_UPS_ambushdist + random 10] call MON_GetPos2D;
				if ([_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};

				_npc setBehaviour "carelesscareless";
				sleep 30;
				{
					if (!stopped _x) then {
						_x domove position _npc;
						waituntil {sleep 0.05;moveToCompleted _x || moveToFailed _x || !alive _x || !canmove _x || _x distance _npc <= 5};
					};
				}foreach units _npc;
			};


			// did the leader die?
			_npc = [_npc,_members] call MON_getleader;
			if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

			_npc setBehaviour "STEALTH";
			_grp setFormation "LINE";

			sleep 10;
			{
				[_x,"DOWN"] spawn MON_setUnitPos;
				_x stop true;
				_x setUnitPos "DOWN";
			}foreach units _npc;
		};	// end of ambush mine


		//Ambus enemy is nearly aproach
		//_ambushdist = 50;
		if (_ambush) then {
			_prov = ((_ambushdist*2 - (_npc distance _target))*3) - 40;

			if (_gothit  || _reinforcementsent || time > _ambushwait
					|| ( "Air" countType [_target]<=0
						&& (	_npc distance _target <= _ambushdist + random 10
								|| (!isNull (_target) && (( random 100 <= _prov &&  _npc distance _target > _lastdist)
									|| _npc distance _target > _ambushdist*3 && _lastdist < _ambushdist*3 && _lastdist > 0))
						))
				) then {

				_nowp = false;
				_ambush = false;
				_ambushed = false;
				_currcycle = _cycle;
				{
					_x stop false;
					_x setUnitPos "Middle";
				} foreach _members;

				//No engage yet
				_pursue = false;
			};

			//Sets distance to target
			_lastdist = _npc distance _target;
		}; // end of ambush


		//If in vehicle take driver if not controlled by user
		if (alive _npc && !_nowp) then {
			if (!_isman || (vehicle (_npc) != _npc && !_inboat && !(vehicle (_npc) iskindof "StaticWeapon"))) then {

				//If new target is close enough getout vehicle (not heli)
				_unitsin = [];

				if (!_inheli) then {
					if (_fightmode == "walk") then {
						_GetOutDist =  _area / 20;
					}else{
						_GetOutDist =  _closeenough  * ((random .4) + 0.6);
					};




					//If near target or stuck getout of vehicle and lock or gothit exits inmediately
					if (_gothit || _dist <= _closeenough * 1.5 || (_lastcurrpos select 0 == _currpos select 0 && _lastcurrpos select 1 == _currpos select 1 && moveToFailed (vehicle (_npc)))
													|| moveTocompleted (vehicle (_npc))) then
					{
						_GetOutDist = 10000;
					};

					_unitsin = [_npc] call R_FN_allUnitsInCargo; // return units in cargo in all vehs used by the group

					private ["_handle1"];
					_handle1 = [_npc,_targetpos,_GetOutDist] spawn R_SN_GetOutDist;	// getout if as close as _GetOutDist to the target
					_timeout = time + 10;
					waitUntil {sleep 0.05;scriptDone _handle1 || time > _timeout};

				} else {
					_GetOutDist = 0;
				};



				// if there was getout of the cargo
				if (count _unitsin > 0) then {

					_timeout = time + 7;
					{
						waituntil {sleep 0.05;vehicle _x == _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x  };
					} foreach _unitsin;


					// did the leader die?
					_npc = [_npc,_members] call MON_getleader;
					if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

					if (_fightmode == "fight" || _gothit) then {
						_npc setBehaviour "COMBAT";		// AWARE
						_groupOne = group _npc;
						_groupOne setFormation "DIAMOND";
						nul = [_npc,30] spawn MON_move;
					};

					sleep 0.2;
					// select leader outside of vehicle
					{
						if (alive _x && canmove _x) exitwith {group _x selectLeader _x; _npc = _x};
					} foreach _unitsin;



					if (_fightmode == "fight") then {
						_pursue = true;
					}else
					{
						_pursue = false;
						_makenewtarget=true;
					};
				};
			};
		};


		//If under attack or increasing knowledge speeds up the response and regain control of the AI
		if (_gothit ) then {
			_react = if (!_supressed) then {_react + 30} else {_react};
			if (_fightmode != "walk") then {
				if (_nowpType != 3) then {
					nul = [_npc] call R_FN_deleteObsoleteWaypoints;
					_nowp = false;
				};
			};
		};

		//If there is no objective order is canceled persecution
		if ((isNull (_target) || !alive _target )) then {
			_pursue=false;

			if (_gothit && !_fortify && !_nowp) then {
				if ((_fightmode == "walk")) then
				{
					//It could be a sniper, better be alert and move in case
					_Behaviour =  "COMBAT";
					_speedmode = "FULL";
					_unitpos = "AUTO";
					_gothit = false;
					_makenewtarget = true;
					_waiting = -1;
					if (random 100 < 20) then {
						nul= [_npc,_target] spawn MON_throw_grenade;
					};
				} else {
					if ((_react >= KRON_UPS_react && _lastreact >=_minreact && count _targets <= 0) || _sowounded) then {
						//Covers the group with a smoke grenade
						if (!_supressed && random 100 < 80) then {
							nul= [_npc,_target] spawn MON_throw_grenade;
						};
						_gothit = false;
						_makenewtarget = true;
						_waiting = -1;
						_pause="NOWAIT";
						_speedmode = "FULL";
						_unitpos = "middle";
						_Behaviour = "AWARE";
					} else {
						if (_lastreact >=_minreact && !_targetdead) then
						{
							_targetdead = true;
							_pursue = true;
						};
					};
				};
			};
		};






		//If no fixed target check if current target is available
		if (format ["%1",_fixedtargetPos] != "[0,0]") then {
			//If fixed target check if close enough or near enemy and gothit
			if (([_currpos,_fixedtargetpos] call KRON_distancePosSqr) <= _closeenough || (_dist <= _closeenough && _gothit)) then {
				_fixedtargetPos = [0,0];
			} else {
				_pursue = false;
				_attackPos=_fixedtargetPos;
				if (_react >= KRON_UPS_react && _lastreact >=_minreact) then {
					_makenewtarget = true;
					_unitpos = "AUTO";
					_speed = "FULL";
				};
			};
		};





		//If captive or surrended do not pursue
		if ( isnil "_attackPos") then {_pursue = false;};
		if ( captive _target || format ["%1", _attackPos] == "[0,0]") then {_pursue = false;};

		//If no waypoint do not move
		if (_nowp) then {
			_makenewtarget = false;
			_pursue = false;
		};

		if (_inheli) then {
			_landing = _heli getVariable "UPSMON_landing";
			if (isnil ("_landing")) then {_landing=false;};
			if (_landing) then {
				_pursue = false;
			};
		};
		sleep 0.5;

// **********************************************************************************************************************
//   								PURSUE: CHASE BEGINS THE LENS
// **********************************************************************************************************************

		if (_pursue) then {

			_pursue = false;
			_newpos = true;
			_react = 0;
			_lastreact = 0;
			_timeontarget = 0;
			_makenewtarget = false;
			_fm = 1;
			//Cancel supress effect when reaction time
			_supressed = false;

			// did the leader die?
			_npc = [_npc,_members] call MON_getleader;
			if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

			// get position of spotted unit in player group, and watch that spot
			_targetPos = _attackPos;
			_targetX = _targetPos select 0; _targetY = _targetPos select 1;
			_currPos = getpos _npc;

			 // also go into "combat mode"
			_pause="NOWAIT";
			_waiting=0;

			// angle from unit to target
			_dir1 = [_currPos,_targetPos] call KRON_getDirPos;
			// angle from target to unit (reverse direction)
			_dir2 = (_dir1+180) mod 360;

			//Establecemos una distancia de flanqueo
			_flankdist = ((random 0.5)+0.7)*KRON_UPS_safedist;

			//La distancia de flanqueo no puede ser superior a la distancia del objetivo o nos pordría pillar por la espalda
			_flankdist = if ((_flankdist*1.40) >= _dist) then {_dist*.65} else {_flankdist};

			if (_inheli) then {_flankdist = _flankdist / 2;};

			// avoidance position (right or left of unit)
			_avoidPos = [_currPos,_dir2, KRON_UPS_safedist] call MON_GetPos2D;

			//Calculamos posición de avance frontal
			_frontPos = [_targetPos,_dir2, _flankdist] call MON_GetPos2D;


			//Adaptamos el ángulo de flanqueo a la distancia
			_newflankAngle = ((random(KRON_UPS_flankAngle)+1) * 2 * (_flankdist / KRON_UPS_safedist )) + (KRON_UPS_flankAngle/1.4) ;
			if (_newflankAngle > KRON_UPS_flankAngle) then {_newflankAngle = KRON_UPS_flankAngle};

			//Calculamos posición de flanqueo 1 45º
			_dirf1 = (_dir2+_newflankAngle) mod 360;
			_flankPos = [_targetPos,_dirf1, _flankdist] call MON_GetPos2D;


			//Calculamos posición de flanqueo 2 -45º
			_dirf2 = (_dir2-_newflankAngle+360) mod 360;
			_flankPos2 = [_targetPos,_dirf2, _flankdist] call MON_GetPos2D;


			//Decidir por el mejor punto de flanqueo
			//Contamos las posiciones de destino de otros grupos más alejadas
			_fldest = 0;
			_fldest2 = 0;
			_fldestfront = 0;
			_i = 0;

			{
				if !(isNil '_x') then {
					if (_i != _grpid &&  format ["%1", _x] != "[0,0]") then {
						_dist1 = [_x,_flankPos] call KRON_distancePosSqr;
						_dist2 = [_x,_flankPos2] call KRON_distancePosSqr;
						_dist3 = [_x,_frontPos] call KRON_distancePosSqr;
						if (_dist1 <= _flankdist/1.5 || _dist2 <= _flankdist/1.5 || _dist3 <= _flankdist/1.5) then {
							if (_dist1 < _dist2 && _dist1 < _dist3) then {_fldest = _fldest + 1;};
							if (_dist2 < _dist1 && _dist2 < _dist3) then {_fldest2 = _fldest2 + 1;};
							if (_dist3 < _dist1 && _dist3 < _dist2) then {_fldestfront = _fldestfront + 1;};
						};
					};
				};
				_i = _i + 1;

			sleep 0.05;
			} foreach KRON_targetsPos;


			//We have the positions of other groups more distant
			_i = 0;
			{
				if !(isNil '_x') then {
					if (_i != _grpid) then {
						_dist1 = [getpos(_x),_flankPos] call KRON_distancePosSqr;
						_dist2 = [getpos(_x),_flankPos2] call KRON_distancePosSqr;
						_dist3 = [getpos(_x),_frontPos] call KRON_distancePosSqr;
						if (_dist1 <= _flankdist/1.5 || _dist2 <= _flankdist/1.5 || _dist3 <= _flankdist/1.5) then {
							if (_dist1 < _dist2 && _dist1 < _dist3) then {_fldest = _fldest + 1;};
							if (_dist2 < _dist1 && _dist2 < _dist3) then {_fldest2 = _fldest2 + 1;};
							if (_dist3 < _dist1 && _dist3 < _dist2) then {_fldestfront = _fldestfront + 1;};
						};
					};
				};
				_i = _i + 1;
			sleep 0.05;
			} foreach KRON_NPCs;



			//La preferencia es la elección inicial de dirección
			switch (_flankdir) do {
				case 1:
					{_prov = 125};
				case 2:
					{_prov = -25};
				default
					{_prov = 50};
			};


			//Si es positivo significa que hay más destinos existentes lejanos a la posicion de flanqueo1, tomamos primariamente este
			if (_fldest<_fldest2) then {_prov = _prov + 50;};
			if (_fldest2<_fldest) then {_prov = _prov - 50;};

			//Si la provablilidad es negativa indica que tomará el flank2 por lo tanto la provabilidad de coger 1 es 0
			if (_prov<0) then {_prov = 0;};


			//Evaluamos la dirección en base a la provablilidad calculada
			if ((random 100) <= _prov) then {
				_flankdir =1;
				_flankPos = _flankPos; _targettext = "_flankPos";
			} else {
				_flankdir =2;
				_flankPos = _flankPos2; _targettext = "_flankPos2";
			};


			//Posición de ataque por defecto el flanco
			_targetPos = _flankPos;
			_targettext = "_flankPos";


			if ((surfaceIsWater _flankPos && !(_isplane || _isboat)) ) then {
				_targetPos = _attackPos;_targettext ="_attackPos";
				_flankdir =0;
			} else {
				if (_fldestfront < _fldest  && _fldestfront < _fldest2) then {
					_targetPos = _frontPos;_targettext ="_frontPos";
				};
			};


			//Establish the type of waypoint
			//DESTROY has worse behavior with and sometimes do not move
			_wptype = "MOVE";

			//Set speed and combat mode
			_rnd = random 100;
			if ( _dist <= _closeenough ) then {
				//If we are so close we prioritize discretion fire
				if ( _dist <= _closeenough/2 ) then {
					//Close combat modeo
					_speedmode = "LIMITED";
					_wpformation = "LINE";
					_unitpos = "Middle";
					_react = _react + KRON_UPS_react / 2;
					_minreact = KRON_UPS_minreact / 2;
					if ((_nomove == "NOMOVE" && _rnd < 25) && !_reinforcementsent) then {
						//Defensive combat
						_Behaviour =  "STEALTH";
						_wptype = "HOLD";
					} else {
						if (_rnd < 75) then {
							_Behaviour =  "COMBAT";
						} else {
							_Behaviour =  "STEALTH";
						};
						_wptype = "MOVE";
					}
				} else {
					//If the troop has the role of not moving tend to keep the position
					_speedmode = "NORMAL";
					_wpformation = "VEE"; //or WEDGE
					_unitpos = "Middle";
					_minreact = KRON_UPS_minreact / 1.5;
					if ((_nomove == "NOMOVE" && _rnd < 50) && !_reinforcementsent) then {
						//Combate defensivo
						_Behaviour =  "COMBAT";
						_wptype = "HOLD";
					} else {
						if (_rnd < 75) then {
							_Behaviour =  "AWARE";
						} else {
							_Behaviour =  "COMBAT";
						};
						_wptype = "MOVE";
					};
				};
			} else	{
				if (( _dist <= (_closeenough + KRON_UPS_safedist))) then {
					_speedmode = "FULL";
					_wpformation = "WEDGE";
					_unitpos = if (_rnd < 90) then {"Middle"}else{"AUTO"};
					_minreact = KRON_UPS_minreact;
					if ((_nomove=="NOMOVE" && _rnd < 75)  && !_reinforcementsent) then {
						//Combate defensivo
						_Behaviour =  "COMBAT"; 	//AWARE
						_wptype = "HOLD";
					} else {
						//Movimiento con precaución (más rápido)
						_Behaviour =  "AWARE";
						_wptype = "MOVE";
					};
				} else {
					//In May distance of radio patrol act..
					if (( _dist <  KRON_UPS_sharedist )) then {
						//Platoon from the target must move fast and to the point
						_Behaviour =  "AWARE";
						_speedmode = "FULL";
						_unitpos = if (_rnd < 60) then {"Middle"}else{"AUTO"};
						_minreact = KRON_UPS_minreact * 2;
						if ((_nomove=="NOMOVE" && _rnd < 95) && !_reinforcementsent) then {
							_wptype = "HOLD";
							_wpformation = "WEDGE";
						}else{
							_wptype = "MOVE";
							_wpformation = "WEDGE";
						};
					} else {
						//Platoon very far from the goal if not move nomove role
						_Behaviour =  "SAFE";
						_speedmode = "FULL";
						_unitpos = "AUTO";
						_minreact = KRON_UPS_minreact * 3;

						if (((_nomove=="NOMOVE") || (_nomove=="MOVE" && _rnd < 70)) && !_reinforcementsent) then {
							_wptype = "HOLD";
							_wpformation = "WEDGE";
						}else{
							_wptype = "MOVE";
							_wpformation = "FILE";  //COLUMN
						};
					};
				};
			};

			//Always keep the brackets fortified position
			if ( _fortify && (random 100)<99) then {_wptype = "HOLD"};

			// did the leader die?
			_npc = [_npc,_members] call MON_getleader;
			if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

			//If leader is in vehicle will move in  anyway
			if (vehicle (_npc) != _npc || !_isman) then {
				_wptype = "MOVE";
				_Behaviour =  "AWARE";
				if ( _inheli ) then {
					_speedmode = "FULL";
					_unitpos = "AUTO";
					if ( (random 100) < 0 ) then {
						_targetPos = _AttackPos;
					};

				};
			};

		//Establecemos el target
			KRON_targetsPos set [_grpid,_targetPos];
			sleep 0.05;

			//If use statics are enabled leader searches for static weapons near.
			// Tanks enemies are contabiliced
			if ( KRON_UPS_useMines && _Mines > 0 ) then {
				_enemytanksnear = false;
				{
					if ( ("Tank" countType [_x] > 0 || "Wheeled_APC" countType [_x] >0
						|| "Tank" countType [vehicle _x] > 0 || "Wheeled_APC" countType [vehicle _x] >0 )
						&& alive _x && canMove _x && _npc distance _x <= _closeenough + KRON_UPS_safedist )
						exitwith { _enemytanksnear = true; _enemytanknear = _x;};
				} foreach _targets;



				//If use mines are enabled and enemy armors near and no friendly armor put mine.
				if ( _enemytanksnear && !isnull _enemytanknear && alive _enemytanknear ) then {
					_friendlytanksnear = false;
					{
						if (!( alive _x && canMove _x)) then {_friendlytanks = _friendlytanks - [_x]};
						if (alive _x && canMove _x && _npc distance _x <= _closeenough + KRON_UPS_safedist ) exitwith { _friendlytanksnear = true;};
					}foreach _friendlytanks;

					if (!_friendlytanksnear && random(100)<30 ) then {
						_dir1 = [_currPos,position _enemytanknear] call KRON_getDirPos;
						_mineposition = [position _npc,_dir1, 25] call MON_GetPos2D;
						_roads = _mineposition nearroads 50;
						if (count _roads > 0) then {_mineposition = position (_roads select 0);};
						if ([_npc,_mineposition] call MON_CreateMine) then {
						_Mines = _Mines -1;
						};
					};
				};
			};

			//Si es unidad de refuerzo siempre acosará al enemigo
			if (_reinforcementsent) then {
				_wptype="MOVE";
				_newpos=true;
				_makenewtarget = false;
			};

			if (_nofollow=="NOFOLLOW" && _wptype != "HOLD") then {
				_targetPos = [_targetPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside;
				_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;
				if ( _targetdist <= 1 ) then {
					_wptype="HOLD";
				};
			};

			if (_wptype == "HOLD") then {
				_targetPos = _currPos;	_targettext ="_currPos";
			};

			//Is updated with the latest value, changing the target
			_lastknown = _opfknowval;

			//If for whatever reason cancels the new position should make clear the parameters that go into pursuit
			if  (!_newpos) then {
				//If the unit has decided to maintain position but is being attacked is being suppressed, should have the opportunity to react
				_newpos = _gothit;
				if  (!_newpos) then {
					_targetPos=_lastpos;
				};
			};
		};	//END PURSUE
	sleep 0.1;
	}; //((_isSoldier) && ((count _enemies)>0)


// **********************************************************************************************************************
//   								NO NEWS
// **********************************************************************************************************************
	if !(_newpos) then {
		// did the leader die?
		_npc = [_npc,_members] call MON_getleader;
		if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

		// calculate new distance
		// if we're waiting at a waypoint, no calculating necessary
		_currpos = getpos _npc;



		//Sets behaviour of squad if nearly changes of target
		if (_targetsnear) then{
			if (( toUpper(_Behaviour) IN _safemode) && _isSoldier) then {
				_Behaviour = "AWARE";
				_npc setBehaviour _Behaviour;
			};
		};



		//If in safe mode if find dead bodies change behaviour
		if( toUpper(_Behaviour) IN _safemode) then {
			_unitsin = [_npc,_buildingdist] call MON_deadbodies;
			if (count _unitsin > 0) then {
				if !_isSoldier then {
					_npc setSpeedMode "FULL";
				} else {
					if ((random 100) < 75) then {
						_Behaviour =  "AWARE";
					} else {
						_Behaviour =  "COMBAT";
					};
					_react = _react + 30;
					_npc setBehaviour _Behaviour;
				};
			};
		};


		//Stuck control
		if (!_nowp && alive _npc && canmove _npc && _wptype == "MOVE" && _timeontarget >= 60 && _lastcurrpos select 0 == _currpos select 0 && _lastcurrpos select 1 == _currpos select 1) then {
			[_npc] call MON_cancelstop;
			_makenewtarget = true;
		};

		_lastpos = _targetPos;
		_lastcurrpos = _currpos; //sets last currpos for avoiding stuk

		if (_waiting<0) then {
			//Gets distance to targetpos
			_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;

			//It assesses whether it has exceeded the maximum waiting time and the objective is already shot to return to the starting position.
			if (_fightmode!="walk") then {
				if (_timeontarget > KRON_UPS_alerttime && count _targets <= 0 && ( isNull (_target) || !alive (_target) || captive _target)) then {
					_pursue = false;
					_gothit = false;
					_targetdead	= true;
					_fightmode = "walk";
					_speedmode = _orgSpeed;
					_targetPos = _currPos;
					_reinforcementsent = false;
					_target = objnull;
					_fixedtargetPos = [0,0];
					_Behaviour = _orgMode;
					_waiting = -1;
					_unitpos = "AUTO";
					_wpformation = "WEDGE";

					KRON_UPS_reinforcement = false; //there is no threat
					if (_rfid > 0 ) then {
						call (compile format ["KRON_UPS_reinforcement%1 = false;",_rfid]);
					};

					{[_x,"AUTO"] spawn MON_setUnitPos;}	foreach units _npc;
					_npc setBehaviour _orgMode;

				};
			};


			// if not in combat and we're either close enough, seem to be stuck, or are getting damaged, so find a new target
			if (!_nowp && (!_gothit) && (!_swimming) && (_fightmode == "walk") && (( _targetdist <= (_area/4) || moveToFailed _npc) && (_timeontarget > KRON_UPS_maxwaiting))) then {
				_makenewtarget=true;
				_unitpos = "AUTO";
				_Behaviour = _orgMode;
			};

			// make new target
			if (_makenewtarget) then
			{
				_gothit = false;
				_react = 0;
				_lastreact = 0;
				_makenewtarget = false;
				_timeontarget = 0;
				_wptype = "MOVE";

				if (format ["%1",_fixedtargetPos] !="[0,0]") then {
					_targetPos = _fixedtargetPos; _targettext ="Reinforcement";
				} else {

					if ((_nomove=="NOMOVE") && (_timeontarget>KRON_UPS_alerttime)) then {
						if (([_currPos,_orgPos] call KRON_distancePosSqr)<_closeenough) then {
							_newpos = false;
							_wptype = "HOLD";
							_waiting = 9999;
							if (_fortify) then {
								_minreact = KRON_UPS_minreact * 3;
								_buildingdist = _buildingdist * 2;
								_wait = 3000;
							};
						} else {
							_targetPos=_orgPos; _targettext ="_orgPos";
						};
					} else {

						//rStuckControl !R
						_rcurrPos = getpos _npc;
						if (_rlastPos select 0 == _rcurrPos select 0 && _rlastPos select 1 == _rcurrPos select 1) then {

							if (vehicle _npc != _npc) then {
									_rstuckControl = _rstuckControl + 1;
								if (_rstuckControl > 1) then {
									_jumpers = crew (vehicle _npc);
									{
										_x spawn MON_doGetOut;
										sleep 0.5;
									} forEach _jumpers;

								} else {
									nul = [vehicle _npc,25] spawn MON_domove;
								}

							} else {
								nul = [_npc,25] spawn MON_domove;
							};

						} else {
							_rstuckControl = 0;
						};
						_rlastPos = _rcurrPos;

						// re-read marker position/size
						_centerpos = getMarkerPos _areamarker; _centerX = abs(_centerpos select 0); _centerY = abs(_centerpos select 1);
						_centerpos = [_centerX,_centerY];
						_areasize = getMarkerSize _areamarker; _rangeX = _areasize select 0; _rangeY = _areasize select 1;
						_areadir = (markerDir _areamarker) * -1;

						// find a new target that's not too close to the current position
						_targetPos=_currPos; _targettext ="newTarget";
						_tries=0;

						while {((([_currPos,_targetPos] call KRON_distancePosSqr) < _mindist)) && (_tries<50)} do {
							_tries=_tries+1;
							// generate new target position
							_targetPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;

							_loop2=FALSE;
							// boat or plane
							if (_isplane || _isboat) then {
								// boat
								if (_isboat) then {
									_tries2=0;
									while {(!_loop2) && (_tries2 <50)} do {
										_tries2=_tries2+1;
										_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
										if (surfaceIsWater _targetPosTemp) then {
											_targetPos = _targetPosTemp;
											_loop2 = TRUE;
										};
										sleep 0.05;
									};

								// plane
								} else {
									_targetPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
								};

							// man or car
							} else {
								// "_onroad"
								if _onroad then {
									_tries2=0;
									while {(!_loop2) && (_tries2 <100)} do {
										_tries2=_tries2+1;

										_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
										_roads = (_targetPosTemp nearRoads 50);
										if ((count _roads) > 0) then {
											_targetPosTemp = getpos (_roads select 0);
											_targetPos = _targetPosTemp;
											_loop2 = TRUE;
										};
										sleep 0.05;
									};
								// any place on ground
								} else {

									_tries2=0;
									while {(!_loop2) && (_tries2 <100)} do {
										_tries2=_tries2+1;
										_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
										if (!surfaceIsWater _targetPosTemp) then {
											_targetPos = _targetPosTemp;
											_loop2 = TRUE;
										};
										sleep 0.05;
									};

								};
							};
						};
					};
				};
				sleep 0.05;


				// distance to target position
				_avoidPos = [0,0]; _flankPos = [0,0]; _attackPos = [0,0];	_frontPos = [0,0];
				_fm=0;
				_newpos=true;
			};
		};
	};

	// if in water, get right back out of it again
	if (surfaceIsWater _currPos) then {
		if (_isman && !_swimming) then {
			_drydist=999;
			// look around, to find a dry spot
			for [{_a=0}, {_a<=270}, {_a=_a+90}] do {
				_dp=[_currPos,30,_a] call KRON_relPos;
				if !(surfaceIsWater _dp) then {_targetPos=_dp};
			};
			_newpos=true;
			_swimming=true;
		};
	} else {
		_swimming=false;
	};

	sleep 0.5;


// **********************************************************************************************************************
//   								NEWPOS:	SE	EJECUTA		LA	ORDEN 	DE 	MOVIMIENTO
// **********************************************************************************************************************
	if ((_waiting<=0) && _newpos) then {

		// did the leader die?
		_npc = [_npc,_members] call MON_getleader;
		if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

		_currPos = getpos _npc;
		_newpos = false;
		_waiting = -1;
		_swimming=false;
		_GetIn_NearestVehicles = false;

		//Gets distance to targetpos
		_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;

		//If gothit and not in vehicle
		if (_gothit && _npc == vehicle (_npc) && alive _npc ) then {

			//Unidad suprimida
			if ((random 100) <50) then {

				//The unit is deleted, delete the current waypoint
				_supressed = true;
				_targetPos = _currPos;	_targettext ="SUPRESSED";
				_wptype = "HOLD";

				//Prone
				{
					//Motion vanishes
					if ( _x iskindof "Man" && canmove _x && alive _x) then {
						if ((random 100)<40 || (primaryWeapon _x ) in KRON_UPS_MG_WEAPONS) then {[_x,"DOWN",20] spawn MON_setUnitPosTime;
						}else{	[_x,"Middle"] spawn MON_setUnitPos;};
					};
					sleep 0.05;
				} foreach units _npc;

				//All Retreat!!
				if ((random 100)<=60 && morale _npc < 0) then {
					_targetPos = _avoidPos;_targettext = "_avoidPos";
					_wptype = "MOVE";
					_flankdir = 0;
				};
			};

			if ((random 100) < 15 && _targettext == "_avoidPos") then {
				[_npc,_target] call MON_throw_grenade;
			};
			sleep 0.5;
		};




		// did the leader die?
		_npc = [_npc,_members] call MON_getleader;
		if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

		//If you have not been removed progress continue
		if (alive _npc) then {
			_currPos = getpos _npc;

			if ( _wptype == "MOVE") then {

				//Try to avoid stucked soldiers out of vehicles
				if ( _npc == vehicle _npc) then {
					{
						if (alive _x && canmove _x) then {
							//[_x] spawn MON_cancelstop;
							[_x] dofollow _npc;
						};
					} foreach _members;
				};
				sleep 0.05;

				//Search for vehicle
				if ((!_gothit && _targetdist >= ( KRON_UPS_searchVehicledist )) && _isSoldier ) then {

					if ( vehicle _npc == _npc && _dist > _closeenough ) then {

						 _unitsIn = [_grpid,_npc] call MON_GetIn_NearestVehicles;

						if ( count _unitsIn > 0) then {
							_GetIn_NearestVehicles = true;
							_speedmode = "FULL";
							_unitpos = "AUTO";
							_npc setbehaviour "SAFE";
							_npc setspeedmode "FULL";
							_timeout = time + 60;

							_vehicle = objnull;
							_vehicles = [];
							{
								waituntil {sleep 0.05;vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x};

								if ( vehicle _x != _x && (isnull _vehicle || _vehicle != vehicle _x)) then {
									_vehicle = vehicle _x ;
									_vehicles = _vehicles + [_vehicle]
								};
							}foreach _unitsIn;
							sleep 1;

							{
								_vehicle = _x;
								_cargo = _vehicle getvariable ("UPSMON_cargo");
								if ( isNil("_cargo")) then {_cargo = [];};
								_cargo ordergetin true;

								//Wait for other groups to getin
								{
									waituntil {sleep 0.05;vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x};
								} foreach _cargo;

								//Starts gunner control
								nul = [_vehicle] spawn MON_Gunnercontrol;
								sleep 0.1;
								// nul = [_x,30] spawn MON_domove; //!R just little kick to make sure it moves
							} foreach _vehicles;

							//Cheks if leader has dead until wait
							_npc = [_npc,_members] call MON_getleader;
							if (!alive _npc || !canmove _npc) exitwith {_exit=true;};


							if ( "Air" countType [vehicle (_npc)]>0) then {
								_rnd = (random 2) * 0.1;
								_flyInHeight = round(KRON_UPS_flyInHeight * (0.9 + _rnd));
								vehicle _npc flyInHeight _flyInHeight;

								//If you just enter the helicopter landing site is defined
								if (_GetIn_NearestVehicles) then {
									_GetOutDist = round(((KRON_UPS_paradropdist )  * (random 100) / 100 ) + 150);

									[vehicle _npc, _TargetPos, _GetOutDist, 90] spawn MON_doParadrop; // org _flyInHeight
									sleep 1;
									//Execute control stuck for helys
									[vehicle _npc] spawn MON_HeliStuckcontrol;
								};
							};
						};
					};
				};
			};
			sleep 0.05;


			//Get in combat vehicles
			if (!_gothit && !_GetIn_NearestVehicles && _fightmode != "walk" && _isSoldier) then {
				_dist2 = _dist / 4;
				if ( _dist2 <= 100 ) then {
					_unitsIn = [];
					_unitsIn = [_grpid,_npc,_dist2,false] call MON_GetIn_NearestCombat;
					_timeout = time + (_dist2/2);

					if ( count _unitsIn > 0) then {
						_npc setbehaviour "SAFE";
						_npc setspeedmode "FULL";

						{
							waituntil {sleep 0.05;vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x};
						}foreach _unitsIn;

						// did the leader die?
						_npc = [_npc,_members] call MON_getleader;
						if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

						//Return to combat mode
						_npc setbehaviour _Behaviour;
						_timeout = time + 150;
						{
							waituntil {sleep 0.05;vehicle _x != _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x};
						}foreach _unitsIn;

						{
							if ( vehicle _x  iskindof "Air") then {
								//moving hely for avoiding stuck
								if (driver vehicle _x == _x) then {
									_vehicle = vehicle (_x);
									nul = [_vehicle,1000] spawn MON_domove;
									//Execute control stuck for helys
									[_vehicle] spawn MON_HeliStuckcontrol;
								};
							};

							if (driver vehicle _x == _x) then {
								//Starts gunner control
								nul = [vehicle _x] spawn MON_Gunnercontrol;
							};
						sleep 0.05;
						}foreach _unitsIn;
					};

				};
			};



			sleep 0.05;
			// did the leader die?
			_npc = [_npc,_members] call MON_getleader;
			if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

			//If use statics are enabled leader searches for static weapons near.
			if ((KRON_UPS_useStatics && (vehicle _npc == _npc) && !_GetIn_NearestVehicles && _isSoldier ) && ((_wptype == "HOLD" && (random 100) < 80) || (_wptype != "HOLD" && (random 100) < 60))) then {

				 _unitsIn = [_grpid,_npc,_buildingdist] call MON_GetIn_NearestStatic;

				if ( count _unitsIn > 0) then {
					_npc setbehaviour "SAFE";
					_npc setspeedmode "FULL";
					_timeout = time + 60;

					{
						waituntil {sleep 0.05;vehicle _x != _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x};
					}foreach _unitsIn;

				};
				sleep 0.05;
			};
			// did the leader die?
			_npc = [_npc,_members] call MON_getleader;
			if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

			//Buildings usage.
			if (!_GetIn_NearestVehicles) then {
				if ( _wptype == "HOLD" && vehicle _npc == _npc && ( _fortify ||(random 100) < 60) ) then {
					[_npc,_buildingdist,false,_wait] spawn MON_moveNearestBuildings;
				} else {
					//If we are close enough patrol in buildings for searching enemies
					if ((( _wptype != "HOLD" && vehicle _npc == _npc && (random 100) < 90  )
						&& _npc == vehicle _npc && _dist <= ( _closeenough ))) then {
						[_npc,_buildingdist,true] spawn MON_moveNearestBuildings;
					};
				};
				sleep 0.05;
			};

			// did the leader die?
			_npc = [_npc,_members] call MON_getleader;
			if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};

			if (isnull _grp || _grp != group _npc) then {
				_grp = group _npc;
			};


			_index = currentWaypoint _grp;

			//If the waypoing is different than it has or is different from what we set hold
			IF (_wptype != "HOLD" || _lastwptype != _wptype) then {
				//Has not completed or are waypoints
				//_index = 1 Waypoint by default, not use.
				if ( _index == 1 || _index > count waypoints _grp && !isnull _grp) then {
					_wp = _grp addWaypoint [_targetPos, 0];
					_index = _wp select 1;
				} else {
					_wp = [_grp,_index];
				};
			};

			// _wp = [_grp,_index];



			// if iscar the run fast if targetpost is far. !R
			if ((!_gothit && _targetdist >= (_closeenough * 1.5)) && (vehicle _npc != _npc)) then {
					_speedmode = "FULL";
				} else {
					// _speedmode = _orgSpeed;
				};



			//We define the parameters of the new waypoint
			_wp  setWaypointType _wptype;
			_wp  setWaypointPosition [_targetPos, 0];
			_wp  setWaypointFormation _wpformation;
			_wp  setWaypointSpeed _speedmode;
			_lastwptype = _wptype;



				//If you have more than 1 waypoints delete the obsolete
				{
					if ( _x select 1 < _index ) then {
						deleteWaypoint _x;
					};
				sleep 0.05;
				} foreach waypoints _grp;


			//Sets behaviour
			if (toupper(behaviour _npc) != toupper (_Behaviour)) then {
				_npc setBehaviour _Behaviour;
			};

			//Refresh position vector
			KRON_targetsPos set [_grpid,_targetPos];

			//Although there are predefined type of movement to a small percentage will vary on an individual level
			{
				if ((random 100)<95 && _x == vehicle _x && _x iskindof "Man" && !((primaryWeapon _x ) in KRON_UPS_MG_WEAPONS)) then {
					nul = [_x,_unitpos] spawn MON_setUnitPos;
				}else{
					nul = [_x,"AUTO"] spawn MON_setUnitPos;
				};
			} foreach units _npc;


			//If closeenough will leave some soldiers doing supress fire
			if (_gothit || _dist <= _closeenough) then {
				{
					if (!canStand _x || ((primaryWeapon _x ) in KRON_UPS_MG_WEAPONS) || (vehicle _x == _x && _x iskindof "Man" && (random 100) < 50) ) then {
						_x suppressFor 15;
					};
				} foreach units _npc;
			};
		};

		_gothit = false;

	};

	if (_track=="TRACK") then {
		switch (_fm) do {
			case 1:
				{_destname setmarkerSize [.4,.4]};
			case 2:
				{_destname setmarkerSize [.6,.6]};
			default
				{_destname setmarkerSize [.5,.5]};
		};
		_destname setMarkerPos _targetPos;

	};

	//If in hely calculations must done faster
	if (_isplane || _inheli) then {
		_currcycle = _cycle/2;
		_flyInHeight = KRON_UPS_flyInHeight;
		vehicle _npc flyInHeight _flyInHeight;

	};

	if ((_exit) || (isNil("_npc"))) then {
		_loop=false;
	} else {
		// slowly increase the cycle duration after an incident
		sleep _currcycle;
	};

}; //while {_loop}

//Limpiamos variables globales de este grupo
KRON_targetsPos set [_grpid,[0,0]];
KRON_NPCs set [_grpid,objnull];
KRON_UPS_Exited=KRON_UPS_Exited+1;

if (_track=="TRACK") then {
	//_trackername setMarkerType "Dot";
	_trackername setMarkerType "Empty";
	_destname setMarkerType "Empty";
};

//Gets dist from orinal pos
if (!isnull _target) then {
	_dist = ([_orgpos,position _target] call KRON_distancePosSqr);
};

//does respawn of group =====================================================================================================
if (_respawn && _respawnmax > 0 &&  !_surrended  && _dist > _closeenough) then {

	// copy group leader
	_unittype = _membertypes select 0;

	// make the clones civilians
	// use random Civilian models for single unit groups
	if ((_unittype=="Civilian") && (count _members==1)) then {_rnd=1+round(random 20); if (_rnd>1) then {_unittype=format["Civilian%1",_rnd]}};

	_grp=createGroup _side;
	_lead = _grp createUnit [_unittype, _orgpos, [], 0, "form"];
	_lead setVehicleInit _initstr;
	[_lead] join _grp;
	_grp selectLeader _lead;

	// copy team members (skip the leader)
	_i=0;
	{
		_i=_i+1;
		if (_i>1) then {
			_newunit = _grp createUnit [_x, _orgpos, [],0,"form"];
			_newunit setVehicleInit _initstr;
			[_newunit] join _grp;
			sleep 0.1;
		};
	} foreach _membertypes;


	if ( _lead == vehicle _lead) then {
			{
				if (alive _x && canmove _x) then {
					[_x] dofollow _lead;
				};
			sleep 0.1;
			} foreach units _lead;
	};

	{
		_targetpos = _orgpos findEmptyPosition [10, 200];
		sleep 0.4;
		if (count _targetpos <= 0) then {_targetpos = _orgpos};
		_newunit = _x createvehicle (_targetpos);
	} foreach _vehicletypes;



	//Set new parameters
	if (!_spawned) then {

		_UCthis = _UCthis + ["SPAWNED"];

		if ((count _vehicletypes) > 0) then {
				_UCthis = _UCthis + ["VEHTYPE:"] + ["dummyveh"];
		};
	};


	_UCthis set [0,_lead];
	_respawnmax = _respawnmax - 1;
	_UCthis =  ["RESPAWN:",_respawnmax,_UCthis] call KRON_UPSsetArg;
	sleep 0.1;
	_UCthis =  ["VEHTYPE:",_vehicletypes,_UCthis] call KRON_UPSsetArg;


	//Exec UPSMON script
	_UCthis SPAWN UPSMON;
	sleep 0.1;
	processInitCommands;
};

_friends=nil;
_enemies=nil;
_enemytanks = nil;
_friendlytanks = nil;
_roads = nil;
_targets = nil;
_members = nil;
_membertypes = nil;
_UCthis = nil;

if (!alive _npc) then {
	deleteGroup _grp;
};
