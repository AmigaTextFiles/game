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

#ifndef TERRAINCLASS_H
#define TERRAINCLASS_H

#include <DataTypes.h>
#include <terrainData.h>
#include <mmath.h>
#include <data.h>

#include <misc/FileStream.h>

#include <list>
#include <vector>

// forward declarations
class PlayerClass;
class ObjectClass;
class UnitClass;
class AirUnit;
class InfantryClass;

#define lround(x) (int)(x+(x<0? -0.5 : 0.5)) 


#define DAMAGEPERCELL 5
#define FOGTIMEOUT 10

enum deadObjectEnum {
    DeadObject_Infantry = 1,
    DeadObject_Infantry_Squashed1 = 2,
    DeadObject_Infantry_Squashed2 = 3,
    DeadObject_Carrall = 4,
    DeadObject_Ornithopter = 5
};

typedef struct
{
	Uint32 damageType;
	int	tile;
	Coord realPos;
} DAMAGETYPE;

typedef struct
{
    Uint8   type;
    Uint8   house;
    bool    onSand;
    Coord   realPos;
    Sint16  timer;
} DEADOBJECTTYPE;


class TerrainClass
{
public:
	TerrainClass();
	~TerrainClass();

	void load(Stream& stream);
	void save(Stream& stream) const;

	void assignAirUnit(Uint32 newObjectID);
	void assignDeadObject(Uint8 type, Uint8 house, const Coord& position) {
        DEADOBJECTTYPE newDeadObject;
        newDeadObject.type = type;
        newDeadObject.house = house;
        newDeadObject.onSand = isSand();
        newDeadObject.realPos = position;
        newDeadObject.timer = 2000;

        deadObject.push_back(newDeadObject);
	}

	void assignNonInfantryGroundObject(Uint32 newObjectID);
	int assignInfantry(Uint32 newObjectID, Sint8 currentPosition = INVALID_POS);
	void assignUndergroundUnit(Uint32 newObjectID);

    /**
        This method draws the terrain of this tile or the structure on this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
	void blitGround(int xPos, int yPos);

    /**
        This method draws the underground units of this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
	void blitUndergroundUnits(int xPos, int yPos);

    /**
        This method draws the dead objects of this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
	void blitDeadObjects(int xPos, int yPos);

    /**
        This method draws the infantry units of this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
    void blitInfantry(int xPos, int yPos);

    /**
        This method draws the ground units of this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
	void blitNonInfantryGroundUnits(int xPos, int yPos);

    /**
        This method draws the air units of this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
	void blitAirUnits(int xPos, int yPos);

    /**
        This method draws the infantry units of this tile.
        \param xPos the x position of the left top corner of this tile on the screen
        \param yPos the y position of the left top corner of this tile on the screen
    */
	void blitSelectionRects(int xPos, int yPos);


	void update();

	void clearTerrain();

	inline void setTrack(Uint8 direction) {
	    if( type == Terrain_Sand || type == Terrain_Dunes
            || type == Terrain_Spice || type == Terrain_ThickSpice
            || type == Terrain_Dunes)
        {
            tracksCounter[direction] = 5000;
	    }
    }

	void damageCell(Uint32 damagerID, PlayerClass* damagerOwner, const Coord& realPos, int bulletType, int bulletDamage, int damageRadius, bool air);
	void selectAllPlayersUnits(int playerNum, ObjectClass** lastCheckedObject, ObjectClass** lastSelectedObject);
	void selectAllPlayersUnitsOfType(int playerNum, int itemID, ObjectClass** lastCheckedObject, ObjectClass** lastSelectedObject);
	void unassignAirUnit(Uint32 ObjectID);
	void unassignNonInfantryGroundObject(Uint32 ObjectID);
	void unassignObject(Uint32 ObjectID);
	void unassignInfantry(Uint32 ObjectID, int currentPosition);
	void unassignUndergroundUnit(Uint32 ObjectID);
	void setType(int newType);
	void squash();
	int getInfantryTeam();
	double harvestSpice();
	void setSpice(double newSpice);

	/**
        Returns the center point of this tile
        \return the center point in world coordinates
	*/
	Coord getCenterPoint() const
	{
	    return Coord( lround(location.x*BLOCKSIZE + (BLOCKSIZE/2)),
                      lround(location.y*BLOCKSIZE + (BLOCKSIZE/2)) );
	}

/*!
		returns a pointer to an air unit in current cell (if there's one)
		@return AirUnit* pointer to air unit
	*/
	AirUnit* getAirUnit();

	/*!
		returns a pointer to a non infantry ground object in current cell (if there's one)
		@return ObjectClass*  pointer to non infantry ground object
	*/
	ObjectClass* getNonInfantryGroundObject();
	/*!
		returns a pointer to an underground object in current cell (if there's one)
		@return UnitClass*  pointer to underground object(sandworm?)
	*/
	UnitClass* getUndergroundUnit();

	/*!
		returns a pointer to an ground object in current cell (if there's one)
		@return ObjectClass*  pointer to ground object
	*/
	ObjectClass* getGroundObject();

	/*!
		returns a pointer to infantry object in current cell (if there's one)
		@return InfantryClass*  pointer to infantry object
	*/
	InfantryClass* getInfantry();
	//ObjectClass* getInfantry(int i);
	ObjectClass* getObject();
	ObjectClass* getObjectAt(int x, int y);
	ObjectClass* getObjectWithID(Uint32 objectID);
	//ObjectClass* selectAll();
	inline void setExplored(int player, bool truth) { if(truth)
													lastAccess[player] = clock();
													  explored[player] = truth; }

	inline void setHideTile(int newTile) { hideTile = newTile; }
	inline void setFogTile(int newTile) { fogTile = newTile; }
	inline void setOwner(int newOwner) { owner = newOwner; }
	inline void setSandRegion(int newSandRegion) { sandRegion = newSandRegion; }
	inline void setTile(int newTile) { tile = newTile; }

	inline bool hasAGroundObject() const { return (hasInfantry() || hasANonInfantryGroundObject()); }
	inline bool hasAnAirUnit() const { return !assignedAirUnitList.empty(); }
	inline bool hasAnUndergroundUnit() const { return !assignedUndergroundUnitList.empty(); }
	inline bool hasANonInfantryGroundObject() const { return !assignedNonInfantryGroundObjectList.empty(); }
	inline bool hasInfantry() const { return !assignedInfantryList.empty(); }
    inline bool hasAnObject() { return (hasAGroundObject() || hasAnAirUnit() || hasInfantry() || hasAnUndergroundUnit()); }

	inline bool hasSpice() const { return (fixDouble(spice) > 0.0); }
	inline bool infantryNotFull() const { return (assignedInfantryList.size() < NUM_INFANTRY_PER_CELL); }
	inline bool isConcrete() const { return (type == Terrain_Slab1); }
	inline bool isExplored(int player) const {return explored[player];}

	bool isFogged(int player);
	inline bool isNextToHidden() const { return (hideTile != Terrain_HiddenFull); }
	inline bool isNextToFogged() const { return (fogTile != Terrain_HiddenFull); }
	inline bool isMountain() const { return (type == Terrain_Mountain);}
	inline bool isRock() const { return ((type == Terrain_Rock) || (type == Terrain_Slab1) || (type == Terrain_Mountain));}

	inline bool isSand() const { return ((type == Terrain_Dunes) || (type == Terrain_Sand)); }
	inline bool isBloom() const { return ((type == Terrain_Sand) && ((tile == Terrain_a2) || (tile == Terrain_a3))); }
	inline bool isSpice() const { return ((type == Terrain_Spice) || (type == Terrain_ThickSpice)); }
	inline bool isThickSpice() const { return (type == Terrain_ThickSpice); }
	inline int getHideTile() const { return hideTile; }
	inline int getFogTile() const { return fogTile; }

	inline int getSandRegion() const { return sandRegion; }
	inline int getOwner() const { return owner; }
	inline int getType() const {	return type; }
	inline int getTile() const { return tile; }
	inline double getSpice() const { return spice; }
	inline double getDifficulty() const { return difficulty;}
	Uint32 getRadarColour(int Player, bool radar);
	inline double getSpiceRemaining() { return fixDouble(spice); }

	inline const Coord& getLocation() const { return location; }
	inline SDL_Surface* getSprite() const { return sprite; }

	bool	visited;    ///< needed for path searching
	double	cost;		///< cost to get here from original location
    double  f;		    ///< cost + heuristic
    double  heuristic;	///< estimate for how much it will cost to get from here to dest

	TerrainClass	*parent;    ///< needed for path searching
	TerrainClass	*previous;  ///< needed for path searching
	TerrainClass	*next;      ///< needed for path searching

	Coord	location;   ///< location of this tile in map coordinates

private:

	Uint32  	type;   ///< the type of the tile (Terrain_Sand, Terrain_Rock, ...)
	Uint32      tile;   ///< this is the index of the picture to draw (e.g. Terrain_DunesUpLeft)

	bool        explored[MAX_PLAYERS];      ///< contains for every player if this tile is explored
	clock_t     lastAccess[MAX_PLAYERS];    ///< contains for every player when this tile was seen last by this player

	Uint32      hideTile;       ///< What kind of black tile should be drawn, when this tile is hidden?
	Uint32      fogTile;        ///< What kind of tile should be drawn, when this tile is fogged?
	Uint32      fogColour;      ///< remember last colour (radar)

	Sint32      owner;          ///< player number of the owner of this tile
	Uint32      sandRegion;     ///< used by sandworms to check if can get to a unit

	double	    difficulty;     ///< how fast can units move over this tile
	double      spice;          ///< how much spice on this particular cell is left

	std::vector<DAMAGETYPE>         damage;                     ///< damage positions
	std::vector<DEADOBJECTTYPE>     deadObject;                 ///< dead object positions
	Sint16                          tracksCounter[NUM_ANGLES];  ///< Contains counters for the tracks on sand

	std::list<Uint32>	assignedAirUnitList;                    ///< all the air units on this tile
	std::list<Uint32>	assignedInfantryList;                   ///< all infantry units on this tile
	std::list<Uint32>	assignedUndergroundUnitList;            ///< all underground units on this tile
	std::list<Uint32>	assignedNonInfantryGroundObjectList;    ///< all structures/vehicles on this tile

	SDL_Surface		*sprite;    ///< the graphic to draw
};



#endif //TERRAINCLASS_H
