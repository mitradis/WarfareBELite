Private ['_aiTeamTemplateRequires','_aiTeamTemplateName','_aiTeamTemplates','_aiTeamTypes','_aiTeamUpgrades','_return','_u'];

//--- Overall Dump.
_aiTeamTemplates = [];
_aiTeamTemplateName = [];
_aiTeamTemplateRequires = [];
_aiTeamTypes = [];
_aiTeamUpgrades = [];

//--- Custom Groups.
_u		= ["RU_Soldier_Sniper"];
_u = _u + ["RU_Soldier_MG"];
_u = _u + ["RU_Soldier_HAT"];
_u = _u + ["RU_Soldier_Medic"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Infantry"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[true,false,false,false]];
_aiTeamTypes = _aiTeamTypes + [0];
_aiTeamUpgrades = _aiTeamUpgrades + [[3,0,0,0]];

_u		= ["BTR90"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(L)-BTR90"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,true,false,false]];
_aiTeamTypes = _aiTeamTypes + [1];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,3,0,0]];

_u		= ["BMP3"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-BMP3"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,1,0]];

_u		= ["T72_RU"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-T72"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,2,0]];

_u		= ["T90"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-T90"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,3,0]];

_u		= ["2S6M_Tunguska"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-Tunguska"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,3,0]];

_u		= ["Mi17_rockets_RU"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - Mi17"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,1]];

_u		= ["Ka52"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - Ka52"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,2]];

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_aiTeamTemplateName]