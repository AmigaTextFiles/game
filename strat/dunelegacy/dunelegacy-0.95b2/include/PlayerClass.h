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

#ifndef PLAYERCLASS_H
#define PLAYERCLASS_H

#include <misc/Stream.h>
#include <Definitions.h>
#include <DataTypes.h>
#include <data.h>

// forward declarations
class UnitClass;
class StructureClass;
class ObjectClass;

class PlayerClass
{
public:
	PlayerClass(int newPlayerNumber, int newHouse, int newColour, int newCredits, int team = -1);
	PlayerClass(Stream& stream, int playerNumber);
	void init();
	virtual ~PlayerClass();
	virtual void save(Stream& stream) const;

	void PrintStat() const;
	virtual void addCredits(double newCredits);
	void assignMapPlayerNum(int newMapPlayerNum);
	void checkSelectionLists();
	void incrementUnits(int itemID);
	void decrementUnits(int itemID);
	virtual void incrementStructures(int itemID);
	virtual void decrementStructures(int itemID, const Coord& location);
	void freeHarvester(int xPos, int yPos);

	void lose();
	void returnCredits(double newCredits);
	virtual void setStartingCredits(double newCredits);
	virtual void setStoredCredits(double newCredits);
	virtual void noteDamageLocation(ObjectClass* pObject, const Coord& location);
	virtual void update();
	void win();
	StructureClass* placeStructure(Uint32 builderID, int itemID, int xPos, int yPos);
	UnitClass* createUnit(int itemID);
	UnitClass* placeUnit(int itemID, int xPos, int yPos);
	int getMapPlayerNum() const;
	double takeCredits(double amount);
	void changeRadar(bool status);

	inline void setTeam(int newTeam) { team = newTeam; }

	inline bool hasCarryalls() const { return (numItem[Unit_Carryall] > 0); }
	inline bool hasIX() const { return (numItem[Structure_IX] > 0); }
	inline bool hasLightFactory() const { return (numItem[Structure_LightFactory] > 0); }
	inline bool hasHeavyFactory() const { return (numItem[Structure_HeavyFactory] > 0); }
	inline bool hasPower() const { return (power >= powerRequirement); }
	inline bool hasRadar() const { return (numItem[Structure_Radar] > 0); }
	inline bool hasRadarOn() const { return (hasRadar() && hasPower()); }
	inline bool hasRefinery() const { return (numItem[Structure_Refinery] > 0); }
	inline bool hasRepairYard() const { return (numItem[Structure_RepairYard] > 0); }
	inline bool hasStarPort() const { return (numItem[Structure_StarPort] > 0); }
	inline bool hasWindTrap() const { return (numItem[Structure_WindTrap] > 0); }
	inline bool hasSandworm() const { return (numItem[Unit_Sandworm] > 0); }
	inline bool isAI() const { return ai; }
	inline bool isAlive() const { return !(((numStructures - numItem[Structure_Wall]) <= 0) && (((numUnits - numItem[Unit_Carryall] - numItem[Unit_Harvester] - numItem[Unit_Frigate] - numItem[Unit_Sandworm]) <= 0))); }
	inline int getNumRadars() const { return numItem[Structure_Radar]; }
	inline int getAmountOfCredits() const { return (int)(credits+startingCredits); }
	inline int getCapacity() const { return capacity; }
	inline int getColour() const { return colour; }
	inline int getPlayerNumber() const { return playerNumber; }
	inline int getPower() const { return power; }
	inline int getPowerRequirement() const { return powerRequirement; }
	inline int getHouse() const { return house; }
	inline int getTeam() const { return team; }
	virtual double getStartingCredits() const { return startingCredits; }
	virtual double getStoredCredits() const { return credits; }

protected:
	void decrementHarvesters();

	bool    ai;             ///< Is this an ai player?

	Uint8   playerNumber;   ///< The player number
    Uint8   mapPlayerNum;   ///< The map player number
	Uint8   house;          ///< The house number
	Uint8   team;           ///< The team number
	Uint8   colour;         ///< The house colour

    int numStructures;          ///< How many structures does this player have?
    int numUnits;               ///< How many units does this player have?
    int numItem[ItemID_max];    ///< This array contains the number of structures/units of a certain type this player has

    int capacity;           ///< Total spice capacity
    int power;              ///< Power prodoced by this player
    int powerRequirement;   ///< How much power does this player use?

	double credits;         ///< current number of credits that are stored in refineries/silos
    double startingCredits; ///< number of starting credits this player still has
    int oldCredits;         ///< amount of credits in the last game cycle (used for playing the credits tick sound)
};



#endif // PLAYERCLASS_H
