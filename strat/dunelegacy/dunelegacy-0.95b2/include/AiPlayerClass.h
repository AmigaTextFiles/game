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

#ifndef AIPLAYERCLASS_H
#define AIPLAYERCLASS_H

#include <PlayerClass.h>

#include <DataTypes.h>

#include <misc/Stream.h>

class AiPlayerClass : public PlayerClass
{
public:
	AiPlayerClass(int newPlayerNumber, int newHouse, int newColour, int newCredits, DIFFICULTYTYPE difficulty, int team = -1);
	AiPlayerClass(Stream& stream, int playerNumber);
	void init();
	~AiPlayerClass();
	void save(Stream& stream) const;

	void addCredits(double newCredits);
	void decrementStructures(int itemID, const Coord& location);
	void noteDamageLocation(ObjectClass* pObject, const Coord& location);
	void setAttackTimer(int newAttackTimer);
	void setDifficulty(DIFFICULTYTYPE newDifficulty);
	void update();
	bool isAttacking() const { return (attackTimer < 0); }

	inline int getAttackTimer() const { return attackTimer; }
	inline DIFFICULTYTYPE getDifficulty() const { return difficulty; }

private:
	Coord findPlaceLocation(int structureSizeX, int structureSizeY);

	DIFFICULTYTYPE	difficulty;     ///< difficulty level
	Sint32  attackTimer;    ///< When to attack?
    Sint32  buildTimer;     ///< When to build the next structure/unit

	std::list<Coord> placeLocations;    ///< Where to place structures

	double spiceMultiplyer; ///< Multiplyer'when extracting spice
};

#endif //AIPLAYERCLASS_H
