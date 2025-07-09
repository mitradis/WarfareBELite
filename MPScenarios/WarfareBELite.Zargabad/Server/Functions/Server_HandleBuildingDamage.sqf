Private ["_difference"];
_difference = ((_this select 1) - (getDammage (_this select 0)))/('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace);
((getDammage (_this select 0))+_difference)