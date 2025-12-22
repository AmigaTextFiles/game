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

#ifndef GAMEINITCLASS_H
#define GAMEINITCLASS_H

#include "Definitions.h"
#include "DataTypes.h"
#include <misc/Stream.h>

#include <string>

#define		NEW_GAME	false
#define		LOAD_GAME	true

class GameInitClass
{
public:
	GameInitClass();
	~GameInitClass();

	GameInitClass& operator=(const GameInitClass& op2);

	void setPlayerName(std::string name) { PlayerName = name; }
	void setMission(PLAYERHOUSE newHouse, int MissionNumber, DIFFICULTYTYPE newDifficulty = MEDIUM);
	void setCampaign(PLAYERHOUSE newHouse, int MissionNumber, DIFFICULTYTYPE newDifficulty = MEDIUM);
	void setloadFile(std::string filename);

	void save(Stream& stream) const;
	void load(Stream& stream);

	bool		InitType;		// NEW_GAME or LOAD_GAME

	std::string		PlayerName;
	GAMETYPE		gameType;
	PLAYERHOUSE		House;
	int				techlevel;
	std::string		mapname;
	int				mission;
	DIFFICULTYTYPE	Difficulty;
	Uint32          randomSeed;
};

#endif // GAMEINITCLASS_H
