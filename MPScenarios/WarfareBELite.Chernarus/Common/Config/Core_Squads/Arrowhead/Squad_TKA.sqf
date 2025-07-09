Private ['_aiTeamTemplateRequires','_aiTeamTemplateName','_aiTeamTemplates','_aiTeamTypes','_aiTeamUpgrades','_return','_u'];

//--- Overall Dump.
_aiTeamTemplates = [];
_aiTeamTemplateName = [];
_aiTeamTemplateRequires = [];
_aiTeamTypes = [];
_aiTeamUpgrades = [];

//--- Custom Groups.
_u		= ["TK_Soldier_Sniper_EP1"];
_u = _u + ["TK_Soldier_MG_EP1"];
_u = _u + ["TK_Soldier_HAT_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Infantry"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[true,false,false,false]];
_aiTeamTypes = _aiTeamTypes + [0];
_aiTeamUpgrades = _aiTeamUpgrades + [[3,0,0,0]];

_u		= ["BTR60_TK_EP1"];
_u = _u + ["BTR60_TK_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(L)-BTR60`s"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,true,false,false]];
_aiTeamTypes = _aiTeamTypes + [1];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,2,0,0]];

_u		= ["BMP2_TK_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-BMP2"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,1,0]];

_u		= ["T72_TK_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-T72"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,3,0]];

_u		= ["ZSU_TK_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-ZSU"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,2,0]];

_u		= ["Mi24_D_TK_EP1"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - Mi24"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,1]];

_u		= ["Ka52Black"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - Ka52"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,2]];

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_aiTeamTemplateName]