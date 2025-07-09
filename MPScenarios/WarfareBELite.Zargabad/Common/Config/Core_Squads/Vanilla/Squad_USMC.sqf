Private ['_aiTeamTemplateRequires','_aiTeamTemplateName','_aiTeamTemplates','_aiTeamTypes','_aiTeamUpgrades','_return','_u'];

//--- Overall Dump.
_aiTeamTemplates = [];
_aiTeamTemplateName = [];
_aiTeamTemplateRequires = [];
_aiTeamTypes = [];
_aiTeamUpgrades = [];

//--- Custom Groups.
_u		= ["USMC_SoldierS_Sniper"];
_u = _u + ["USMC_Soldier_MG"];
_u = _u + ["USMC_Soldier_HAT"];
_u = _u + ["USMC_Soldier_Medic"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Infantry"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[true,false,false,false]];
_aiTeamTypes = _aiTeamTypes + [0];
_aiTeamUpgrades = _aiTeamUpgrades + [[3,0,0,0]];

_u		= ["LAV25"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(L)-LAV25"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,true,false,false]];
_aiTeamTypes = _aiTeamTypes + [1];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,3,0,0]];

_u		= ["HMMWV_Avenger"];
_u = _u + ["HMMWV_Avenger"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(L)-HMMWVAvenger`s"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,true,false,false]];
_aiTeamTypes = _aiTeamTypes + [1];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,3,0,0]];

_u		= ["AAV"];
_u = _u + ["AAV"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-AAV`s"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,1,0]];

_u		= ["M1A1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-M1A1"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,2,0]];

_u		= ["M1A2_TUSK_MG"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-M1A2TUSK"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,3,0]];

_u		= ["UH1Y"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - UH1Y"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,1]];

_u		= ["AH64D"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - AH64D"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,2]];

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_aiTeamTemplateName]