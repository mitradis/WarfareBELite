/*
	Town mode initialization.
		the town that have to be removed need to be stored on the desired variable over WF_Logic. If those ain't set, the full town setting will be used. 
		Custom templates can be added bellow.
*/

Private ['_i','_index','_paramName','_towns','_value'];

_index = 0;
for [{_i = 0},{_i < (count (missionConfigFile/"Params"))},{_i = _i + 1}]  do {
	_paramName = (configName ((missionConfigFile >> "Params") select _i));
	if (_paramName == "townsAmount") exitWith {_index =_i};
};

_value = if (isMultiplayer) then {paramsArray select _index} else {getNumber (missionConfigFile >> "Params" >> "townsAmount" >> "default")};

TownTemplate = [];
switch (_value) do {
	case 0: {TownTemplate = WF_Logic getVariable "Towns_RemovedXSmall"};
	case 1: {TownTemplate = WF_Logic getVariable "Towns_RemovedSmall"};
	case 2: {TownTemplate = WF_Logic getVariable "Towns_RemovedMedium"};
	case 3: {TownTemplate = WF_Logic getVariable "Towns_RemovedLarge"};
	//--- case 4 = full. useless.
	/* Add your templates here !
		Custom templates can be added here, just set a new variable with the towns to remove in WF_Logic and add your template name/value in the parameter class 
			- WF_Logic:   this setVariable ["myRemovedTowns",["Chernogorsk","Pavlovo","Zelenogorsk"]];
			- parameter (Add it at the end!!!): 
				class townsAmount {
					title = "$STR_WF_PARAMETER_TownsAmount";
					values[] = {0,1,2,3,4,5};
					texts[] = {"Extra Small","Small","Medium","Large","Full","MyOwnTemplate"};
					default = 3;
				};
			- Init_TownMode.sqf (Here!): case 5: {TownTemplate = WF_Logic getVariable "myRemovedTowns"}
			
			As a result, Chernogorsk, Pavlovo and Zelenogorsk will be removed.
	*/
};

if (isNil "TownTemplate") then {TownTemplate = []};//--- The field is not defined, we use the default island setting.

_towns = [0,0,0] nearEntities [["LocationLogicDepot"], 100000];
totalTowns = (count _towns) - (count TownTemplate);

townModeSet = true;
