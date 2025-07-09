/*
	Neighbors town per world.
*/

Private ["_index","_townMode"];
_index = 0;
for [{_i = 0},{_i < (count (missionConfigFile/"Params"))},{_i = _i + 1}]  do {if ((configName ((missionConfigFile >> "Params") select _i)) == "townsAmount") exitWith {_index =_i}};
_townMode = if (isMultiplayer) then {paramsArray select _index} else {getNumber (missionConfigFile >> "Params" >> "townsAmount" >> "default")};

switch (toLower(worldName)) do {
	case "chernarus": {
		switch (_townMode) do {
			case 4: {//--- Full.
				Kamenka setVariable ["neighbors", [Pavlovo, Komarovo]];
				Komarovo setVariable ["neighbors", [Pavlovo, Komarovo, Bor, Chernogorsk]];
				Chernogorsk setVariable ["neighbors", [Komarovo, Nadezhdino, Prigorodki, Kozlovka]];
				Prigorodki setVariable ["neighbors", [Chernogorsk, Elektrozavodsk]];
				Elektrozavodsk setVariable ["neighbors", [Prigorodki, Chernogorsk, Pusta, Kamyshovo, Staroye]];
				Kamyshovo setVariable ["neighbors", [Tulga, Elektrozavodsk]];
				Tulga setVariable ["neighbors", [Kamyshovo, Msta, Solnichniy]];
				Solnichniy setVariable ["neighbors", [Kamyshovo, Msta, Nizhnoye, Dolina]];
				Nizhnoye setVariable ["neighbors", [Solnichniy, Berezino]];
				Berezino setVariable ["neighbors", [Nizhnoye, Khelm, Orlovets, Dubrovka]];
				Khelm setVariable ["neighbors", [Berezino, Krasnostav]];
				Krasnostav setVariable ["neighbors", [Olsha, Gvozdno, Dubrovka, Khelm]];
				Olsha setVariable ["neighbors", [Krasnostav]];
				Gvozdno setVariable ["neighbors", [Krasnostav, Grishino]];
				Grishino setVariable ["neighbors", [Gvozdno, Petrovka, Kabanino]];
				Petrovka setVariable ["neighbors", [Grishino, Lopatino]];
				Lopatino setVariable ["neighbors", [Petrovka, Vybor, Pustoshka]];
				Myshkino setVariable ["neighbors", [Sosnovka, Pustoshka]];
				Sosnovka setVariable ["neighbors", [Zelenogorsk, Myshkino, Pustoshka]];
				Zelenogorsk setVariable ["neighbors", [Sosnovka, Pogorevka, Kozlovka, Pavlovo]];
				Pavlovo setVariable ["neighbors", [Kamenka, Komarovo, Bor, Zelenogorsk]];
				Bor setVariable ["neighbors", [Pavlovo, Kozlovka, Komarovo]];
				Kozlovka setVariable ["neighbors", [Bor, Zelenogorsk, Nadezhdino, Chernogorsk]];
				Nadezhdino setVariable ["neighbors", [Kozlovka, Chernogorsk]];
				Mogilevka setVariable ["neighbors", [Vyshnoye, Pusta]];
				Pusta setVariable ["neighbors", [Mogilevka, Elektrozavodsk]];
				Staroye setVariable ["neighbors", [Shakhovka, Guglovo, Elektrozavodsk, Msta]];
				Msta setVariable ["neighbors", [Staroye, Tulga, Solnichniy]];
				Dolina setVariable ["neighbors", [Staroye, Solnichniy, Solnichniy, Polana]];
				Orlovets setVariable ["neighbors", [Berezino, Polana]];
				Polana setVariable ["neighbors", [Orlovets, Polana, Dolina, Shakhovka, Gorka]];
				Gorka setVariable ["neighbors", [Dubrovka, NovySobor, Polana]];
				Dubrovka setVariable ["neighbors", [Gorka, Krasnostav, Berezino]];
				Shakhovka setVariable ["neighbors", [Staroye, Polana]];
				Guglovo setVariable ["neighbors", [Staroye, NovySobor]];
				NovySobor setVariable ["neighbors", [Guglovo, Gorka, StarySobor]];
				Vyshnoye setVariable ["neighbors", [StarySobor, Gorka]];
				StarySobor setVariable ["neighbors", [Vyshnoye, NovySobor, Kabanino, Pogorevka]];
				Pulkovo setVariable ["neighbors", [Pogorevka]];
				Pogorevka setVariable ["neighbors", [Pulkovo, Zelenogorsk, StarySobor]];
				Kabanino setVariable ["neighbors", [Vybor, Grishino, StarySobor]];
				Vybor setVariable ["neighbors", [Kabanino, Lopatino, Pustoshka]];
				Pustoshka setVariable ["neighbors", [Kabanino, Vybor, Myshkino]];
			};
			case 3: {//--- Large.
				Chernogorsk setVariable ["neighbors", [Komarovo, Nadezhdino, Elektrozavodsk]];
				Elektrozavodsk setVariable ["neighbors", [Chernogorsk, Pusta, Kamyshovo, Staroye]];
				Kamyshovo setVariable ["neighbors", [Solnichniy, Elektrozavodsk]];
				Solnichniy setVariable ["neighbors", [Kamyshovo, Dolina, Berezino]];
				Berezino setVariable ["neighbors", [Solnichniy, Dubrovka]];
				Krasnostav setVariable ["neighbors", [Gvozdno, Dubrovka]];
				Dubrovka setVariable ["neighbors", [Gorka, Krasnostav, Berezino]];
				Gorka setVariable ["neighbors", [Dubrovka, Polana, StarySobor]];
				Polana setVariable ["neighbors", [Gorka, Dolina]];
				Dolina setVariable ["neighbors", [Polana, Solnichniy, Staroye]];
				Staroye setVariable ["neighbors", [Elektrozavodsk, Dolina, Guglovo]];
				Pusta setVariable ["neighbors", [Elektrozavodsk, Mogilevka]];
				Guglovo setVariable ["neighbors", [Staroye, StarySobor]];
				Mogilevka setVariable ["neighbors", [Pusta, Vyshnoye, Nadezhdino]];
				Vyshnoye setVariable ["neighbors", [Mogilevka, StarySobor]];
				StarySobor setVariable ["neighbors", [Mogilevka, Kabanino, Gorka, Pogorevka, Guglovo]];
				Gvozdno setVariable ["neighbors", [Grishino, Krasnostav]];
				Grishino setVariable ["neighbors", [Kabanino, Petrovka, Gvozdno]];
				Kabanino setVariable ["neighbors", [StarySobor, Grishino, Vybor]];
				Petrovka setVariable ["neighbors", [Grishino, Lopatino]];
				Lopatino setVariable ["neighbors", [Vybor, Petrovka]];
				Vybor setVariable ["neighbors", [Lopatino, Myshkino, Kabanino]];
				Pogorevka setVariable ["neighbors", [StarySobor, Zelenogorsk]];
				Myshkino setVariable ["neighbors", [Zelenogorsk, Lopatino]];
				Nadezhdino setVariable ["neighbors", [Mogilevka, Chernogorsk]];
				Zelenogorsk setVariable ["neighbors", [Pogorevka, Myshkino, Pavlovo]];
				Pavlovo setVariable ["neighbors", [Zelenogorsk, Komarovo]];
				Komarovo setVariable ["neighbors", [Pavlovo, Chernogorsk]];
			};
			case 2: {//--- Medium.
				Chernogorsk setVariable ["neighbors", [Komarovo, Nadezhdino, Kozlovka, Mogilevka]];
				Mogilevka setVariable ["neighbors", [Vyshnoye, Nadezhdino]];
				Vyshnoye setVariable ["neighbors", [Mogilevka, StarySobor]];
				StarySobor setVariable ["neighbors", [Mogilevka, Kabanino, Pogorevka]];
				Grishino setVariable ["neighbors", [Kabanino]];
				Kabanino setVariable ["neighbors", [StarySobor, Grishino, Vybor]];
				Lopatino setVariable ["neighbors", [Vybor]];
				Vybor setVariable ["neighbors", [Lopatino, Pustoshka, Kabanino]];
				Myshkino setVariable ["neighbors", [Zelenogorsk, Pustoshka]];
				Nadezhdino setVariable ["neighbors", [Mogilevka, Chernogorsk]];
				Zelenogorsk setVariable ["neighbors", [Pogorevka, Myshkino, Pavlovo, Kozlovka]];
				Pavlovo setVariable ["neighbors", [Zelenogorsk, Komarovo, Kamenka]];
				Komarovo setVariable ["neighbors", [Pavlovo, Chernogorsk, Kamenka]];
				Kamenka setVariable ["neighbors", [Pavlovo, Komarovo]];
				Kozlovka setVariable ["neighbors", [Zelenogorsk, Nadezhdino, Chernogorsk]];
				Pustoshka setVariable ["neighbors", [Vybor, Myshkino]];
				Pogorevka setVariable ["neighbors", [StarySobor, Zelenogorsk]];
			};
			case 1: {//--- Small.
				Berezino setVariable ["neighbors", [Khelm, Orlovets, Dubrovka]];
				Orlovets setVariable ["neighbors", [Berezino, Polana]];
				Polana setVariable ["neighbors", [Gorka, Orlovets]];
				Gorka setVariable ["neighbors", [Dubrovka, Polana]];
				Dubrovka setVariable ["neighbors", [Gorka, Krasnostav, Berezino]];
				Khelm setVariable ["neighbors", [Berezino, Krasnostav]];
				Krasnostav setVariable ["neighbors", [Olsha, Gvozdno, Dubrovka, Khelm]];
				Olsha setVariable ["neighbors", [Krasnostav]];
				Gvozdno setVariable ["neighbors", [Krasnostav]];
			};
			case 0: {//--- Extra Small.
				Grishino setVariable ["neighbors", [Kabanino]];
				Kabanino setVariable ["neighbors", [Grishino, Vybor]];
				Vybor setVariable ["neighbors", [Kabanino, Lopatino, Pustoshka]];
				Pustoshka setVariable ["neighbors", [Vybor]];
				Lopatino setVariable ["neighbors", [Vybor]];
			};
		};	
	};
	case "takistan": {
		switch (_townMode) do {
			case 4: {//--- Full.
				Landay setVariable ["neighbors", [ChakChak]];
				ChakChak setVariable ["neighbors", [Landay, Sakhee, Huzrutimam]];
				Huzrutimam setVariable ["neighbors", [ChakChak, Sultansafee]];
				Sultansafee setVariable ["neighbors", [Huzrutimam, LoyManara]];
				LoyManara setVariable ["neighbors", [Sultansafee, Jaza, Chardarakht, Timurkalay]];
				Jaza setVariable ["neighbors", [LoyManara]];
				Chardarakht setVariable ["neighbors", [LoyManara, HazarBagh]];
				HazarBagh setVariable ["neighbors", [Chardarakht]];
				Timurkalay setVariable ["neighbors", [LoyManara, Anar, Garmarud]];
				Garmarud setVariable ["neighbors", [Timurkalay, Garmsar, Imarat]];
				Garmsar setVariable ["neighbors", [Garmarud]];
				Imarat setVariable ["neighbors", [Garmarud, Zavarak, Bastam]];
				Zavarak setVariable ["neighbors", [Imarat, Karachinar, Ravanay]];
				Karachinar setVariable ["neighbors", [Zavarak]];
				Ravanay setVariable ["neighbors", [Zavarak]];
				Bastam setVariable ["neighbors", [Imarat, Falar, Rasman, Gospandi]];
				Rasman setVariable ["neighbors", [Shamali, Bastam]];
				Shamali setVariable ["neighbors", [Rasman, Nagara]];
				Nagara setVariable ["neighbors", [Nur, Gospandi, Shamali]];
				Nur setVariable ["neighbors", [Nagara]];
				Gospandi setVariable ["neighbors", [Nagara, Bastam, Mulladoost]];
				Mulladoost setVariable ["neighbors", [Gospandi, Khushab]];
				Khushab setVariable ["neighbors", [Mulladoost, Jilavur, Shukurkalay]];
				Shukurkalay setVariable ["neighbors", [Khushab, Jilavur, Chaman]];
				Chaman setVariable ["neighbors", [Shukurkalay]];
				Jilavur setVariable ["neighbors", [Shukurkalay, Khushab, Sakhee, FeeruzAbad]];
				Sakhee setVariable ["neighbors", [Jilavur, ChakChak, FeeruzAbad, Kakaru]];
				Kakaru setVariable ["neighbors", [Sakhee, Anar, FeeruzAbad]];
				FeeruzAbad setVariable ["neighbors", [Jilavur, Anar, Kakaru, Falar, Sakhee]];
				Anar setVariable ["neighbors", [FeeruzAbad, Kakaru, Timurkalay, Falar]];
				Falar setVariable ["neighbors", [FeeruzAbad, Anar, Bastam]];
			};
			case 3: {//--- Large.
				Landay setVariable ["neighbors", [ChakChak]];
				ChakChak setVariable ["neighbors", [Landay, Sakhee, Huzrutimam]];
				Huzrutimam setVariable ["neighbors", [ChakChak, Sultansafee]];
				Sultansafee setVariable ["neighbors", [Huzrutimam, LoyManara]];
				LoyManara setVariable ["neighbors", [Sultansafee, Jaza, Chardarakht, Timurkalay]];
				Jaza setVariable ["neighbors", [LoyManara]];
				Chardarakht setVariable ["neighbors", [LoyManara]];
				Timurkalay setVariable ["neighbors", [LoyManara, Anar, Garmarud]];
				Garmarud setVariable ["neighbors", [Timurkalay, Garmsar, Imarat]];
				Garmsar setVariable ["neighbors", [Garmarud]];
				Imarat setVariable ["neighbors", [Garmarud, Zavarak, Bastam]];
				Zavarak setVariable ["neighbors", [Imarat, Karachinar, Ravanay]];
				Karachinar setVariable ["neighbors", [Zavarak]];
				Ravanay setVariable ["neighbors", [Zavarak]];
				Bastam setVariable ["neighbors", [Imarat, Falar, Rasman, Gospandi]];
				Rasman setVariable ["neighbors", [Shamali, Bastam]];
				Shamali setVariable ["neighbors", [Rasman, Nagara]];
				Nagara setVariable ["neighbors", [Gospandi, Shamali]];
				Gospandi setVariable ["neighbors", [Nagara, Bastam, Mulladoost]];
				Mulladoost setVariable ["neighbors", [Gospandi, Khushab]];
				Khushab setVariable ["neighbors", [Mulladoost, Jilavur, Shukurkalay]];
				Shukurkalay setVariable ["neighbors", [Khushab, Jilavur]];
				Jilavur setVariable ["neighbors", [Shukurkalay, Khushab, Sakhee, FeeruzAbad]];
				Sakhee setVariable ["neighbors", [Jilavur, ChakChak, FeeruzAbad, Kakaru]];
				Kakaru setVariable ["neighbors", [Sakhee, Anar, FeeruzAbad]];
				FeeruzAbad setVariable ["neighbors", [Jilavur, Anar, Kakaru, Falar, Sakhee]];
				Anar setVariable ["neighbors", [FeeruzAbad, Kakaru, Timurkalay, Falar]];
				Falar setVariable ["neighbors", [FeeruzAbad, Anar, Bastam]];
			};
			case 2: {//--- Medium.
				Garmarud setVariable ["neighbors", [Imarat]];
				Imarat setVariable ["neighbors", [Garmarud, Bastam]];
				Bastam setVariable ["neighbors", [Imarat, Falar, Rasman, Gospandi]];
				Rasman setVariable ["neighbors", [Shamali, Bastam]];
				Shamali setVariable ["neighbors", [Rasman, Nagara]];
				Nagara setVariable ["neighbors", [Gospandi, Shamali]];
				Gospandi setVariable ["neighbors", [Nagara, Bastam, Mulladoost]];
				Mulladoost setVariable ["neighbors", [Gospandi, Khushab]];
				Khushab setVariable ["neighbors", [Mulladoost]];
				Falar setVariable ["neighbors", [Anar, Bastam]];
			};
			case 1: {//--- Small.
				Bastam setVariable ["neighbors", [Imarat, Falar, Rasman, Gospandi]];
				Rasman setVariable ["neighbors", [Shamali, Bastam]];
				Shamali setVariable ["neighbors", [Rasman, Nagara]];
				Nagara setVariable ["neighbors", [Gospandi, Shamali]];
				Nur setVariable ["neighbors", [Nagara]];
				Gospandi setVariable ["neighbors", [Nagara, Bastam, Mulladoost]];
			};
			case 0: {//--- Extra Small.
				Huzrutimam setVariable ["neighbors", [LoyManara]];
				LoyManara setVariable ["neighbors", [Chardarakht, Huzrutimam]];
				Chardarakht setVariable ["neighbors", [LoyManara]];
			};
		};
	};
	case "zargabad": {
		Qeslaq setVariable ["neighbors", [Shahbaz, Zargabad]];
		Shahbaz setVariable ["neighbors", [Qeslaq, Yarum]];
		Yarum setVariable ["neighbors", [Zargabad, Shahbaz]];
		Zargabad setVariable ["neighbors", [Qeslaq, Yarum, Nango, Azizajt, HazarBagh]];
		Azizajt setVariable ["neighbors", [Zargabad, Nango]];
		Nango setVariable ["neighbors", [Zargabad, Azizajt, HazarBagh]];
		HazarBagh setVariable ["neighbors", [Zargabad, Nango]];
	};
	default {
		['WFBE_TOWNCONQUESTMODE', 0, true] Call SetNamespace;
	};
};

objnull setVariable ["neighbors",objnull];

