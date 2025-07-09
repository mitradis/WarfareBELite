Private ['_aiTeamTemplateRequires','_aiTeamTemplateName','_aiTeamTemplates','_aiTeamTypes','_aiTeamUpgrades','_return','_u'];

//--- Overall Dump.
_aiTeamTemplates = [];
_aiTeamTemplateName = [];
_aiTeamTemplateRequires = [];
_aiTeamTypes = [];
_aiTeamUpgrades = [];

//--- Custom Groups.
_u		= ["US_Soldier_Sniper_EP1"];
_u = _u + ["US_Soldier_MG_EP1"];
_u = _u + ["US_Soldier_HAT_EP1"];
_u = _u + ["US_Soldier_Medic_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Infantry"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[true,false,false,false]];
_aiTeamTypes = _aiTeamTypes + [0];
_aiTeamUpgrades = _aiTeamUpgrades + [[3,0,0,0]];

_u		= ["M1128_MGS_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(L)-M1128MGS"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,true,false,false]];
_aiTeamTypes = _aiTeamTypes + [1];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,3,0,0]];

_u		= ["HMMWV_Avenger_DES_EP1"];
_u = _u + ["HMMWV_Avenger_DES_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(L)-HMMWVAvenger`s"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,true,false,false]];
_aiTeamTypes = _aiTeamTypes + [1];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,3,0,0]];

_u		= ["M2A3_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-M2A3"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,2,0]];

_u		= ["M1A1_US_DES_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-M1A1"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,3,0]];

_u		= ["M6_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-M6"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,3,0]];

_u		= ["AH6J_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - AH6J"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,1]];

_u		= ["AH64D_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - AH64D"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,2]];

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_aiTeamTemplateName]