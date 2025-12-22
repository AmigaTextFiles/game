/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <GameInitClass.h>

#include <stdlib.h>
#include <string.h>

GameInitClass::GameInitClass()
{
	gameType = SKIRMISH;
	techlevel = 1;
	mission = -1;
	InitType = NEW_GAME;
	House = ATREIDES;
	Difficulty = EASY;
	randomSeed = rand();
}

GameInitClass::~GameInitClass()
{
}

GameInitClass& GameInitClass::operator=(const GameInitClass& op2)
{
	PlayerName = op2.PlayerName;
	mapname = op2.mapname;
	gameType = op2.gameType;
	techlevel = op2.techlevel;
	mission = op2.mission;
	InitType = op2.InitType;
	House = op2.House;
	Difficulty = op2.Difficulty;
	return *this;
}

void GameInitClass::setMission(PLAYERHOUSE newHouse, int MissionNumber, DIFFICULTYTYPE newDifficulty)
{
	char name[] = "SCEN?000.INI";

	if( (MissionNumber < 0) || (MissionNumber > 22)) {
		fprintf(stdout, "GameInitClass::setMission(): There is no mission number %d.\n",MissionNumber);
		return;
	}

	switch(newHouse)
	{
		case ATREIDES:
		{
			name[4] = 'A';
		} break;

		case ORDOS:
		{
			name[4] = 'O';
		} break;

		case HARKONNEN:
		{
			name[4] = 'H';
		} break;

		default:
		{
			fprintf(stdout, "GameInitClass::setMission(): There are only missions for Atreides, Ordos and Harkonnen.\n");
			return;
		} break;
	};

	name[6] = '0' + (MissionNumber / 10);
	name[7] = '0' + (MissionNumber % 10);



	mapname = name;

	mission = MissionNumber;
	gameType = SKIRMISH;
	techlevel = ((mission + 1)/3) + 1;
	House = newHouse;
	Difficulty = newDifficulty;

	InitType = NEW_GAME;
}

void GameInitClass::setCampaign(PLAYERHOUSE newHouse, int MissionNumber, DIFFICULTYTYPE newDifficulty)
{
	setMission(newHouse,MissionNumber,newDifficulty);
	gameType = ORIGINAL;
}

void GameInitClass::setloadFile(std::string filename)
{
    mapname = filename;
	InitType = LOAD_GAME;
}

void GameInitClass::save(Stream& stream) const
{
	stream.writeBool(InitType);

	stream.writeString(PlayerName.c_str());

	stream.writeUint8(gameType);
	stream.writeUint8(House);
	stream.writeUint8(techlevel);

	stream.writeString(mapname.c_str());

	stream.writeUint8(mission);
	stream.writeUint8(Difficulty);
	stream.writeUint32(randomSeed);
}

void GameInitClass::load(Stream& stream)
{
	InitType = stream.readBool();

	PlayerName = stream.readString();

	gameType = (GAMETYPE) stream.readUint8();
	House = (PLAYERHOUSE) stream.readUint8();
	techlevel = stream.readUint8();

	mapname = stream.readString();

	mission = stream.readUint8();
	Difficulty = (DIFFICULTYTYPE) stream.readUint8();
	randomSeed = stream.readUint32();
}
