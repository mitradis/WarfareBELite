Private ['_vehicle'];

_vehicle = _this select 0;

(driver _vehicle) action ["engineOff", _vehicle];
(driver _vehicle) disableAI "MOVE";
(driver _vehicle) disableAI "TARGET";
waitUntil {sleep 0.1;speed _vehicle < 1};

sleep 3;
