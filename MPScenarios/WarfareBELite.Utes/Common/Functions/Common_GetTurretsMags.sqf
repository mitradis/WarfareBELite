/* Adapted from BIS turret's function. */
private ['_entry','_turrets','_turretIndex'];
_entry = _this select 0;

_turrets = [];
_turretIndex = 0;

//Explore all turrets and sub-turrets recursively.
for '_i' from 0 to ((count _entry) - 1) do
{
	private ['_subEntry'];
	_subEntry = _entry select _i;
	
	if (isClass _subEntry) then
	{
		private ['_hasGunner'];
		_hasGunner = [_subEntry, 'hasGunner'] call BIS_fnc_returnConfigEntry;

		//Make sure the entry was found.
		if !(isNil '_hasGunner') then 
		{
			if (_hasGunner == 1) then 
			{
				_turrets = _turrets + [[_turretIndex],getArray(_subEntry >> 'magazines')];
				
				//Include sub-turrets, if present.
				if (isClass (_subEntry >> 'Turrets')) then 
				{
					_turrets = _turrets + [[_subEntry >> 'Turrets'] call GetTurretsMags];
				} 
				else 
				{
					_turrets = _turrets + [[]];
				};
			};
		};

		_turretIndex = _turretIndex + 1;
	};
};

_turrets