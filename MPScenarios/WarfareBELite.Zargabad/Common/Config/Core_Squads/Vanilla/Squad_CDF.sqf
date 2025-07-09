Private ['_aiTeamTemplateRequires','_aiTeamTemplateName','_aiTeamTemplates','_aiTeamTypes','_aiTeamUpgrades','_return','_u'];

//--- Overall Dump.
_aiTeamTemplates = [];
_aiTeamTemplateName = [];
_aiTeamTemplateRequires = [];
_aiTeamTypes = [];
_aiTeamUpgrades = [];

//--- Custom Groups.
_u		= ["BMP2_CDF"];
_u = _u + ["BMP2_CDF"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-BMP2"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,2,0]];

_u		= ["ZSU_CDF"];
_u = _u + ["ZSU_CDF"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Armor(H)-ZSU"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTypes = _aiTeamTypes + [2];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,true,false]];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,1,0]];

_u		= ["Mi17_CDF"];
_aiTeamTemplateName = _aiTeamTemplateName + ["Air - Mi17"];
_aiTeamTemplates = _aiTeamTemplates + [_u];
_aiTeamTypes = _aiTeamTypes + [3];
_aiTeamTemplateRequires = _aiTeamTemplateRequires + [[false,false,false,true]];
_aiTeamUpgrades = _aiTeamUpgrades + [[0,0,0,1]];

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_aiTeamTemplateName]