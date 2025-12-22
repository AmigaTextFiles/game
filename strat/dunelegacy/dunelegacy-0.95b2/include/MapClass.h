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

#ifndef MAPCLASS_H
#define MAPCLASS_H

#include <TerrainClass.h>

class MapClass
{
public:
	MapClass(int xSize, int ySize);
	~MapClass();

	void load(Stream& stream);
	void save(Stream& stream) const;

	void createSandRegions();
	void damage(Uint32 damagerID, PlayerClass* damagerOwner, const Coord& realPos, Uint32 bulletID, int damage, int damageRadius, bool air);
	Coord getMapPos(int angle, const Coord& source) const;
	void removeObjectFromMap(Uint32 ObjectID);
	void removeSpice(int xPos, int yPos);	//fixes spice tiles after spice gone to make things look smooth
	void selectObjects(int playerNum, int x1, int y1, int x2, int y2, int realX, int realY, bool objectARGMode);
	void setWinFlags(int newWinFlags);
	void viewMap(int playerTeam, const Coord& location, int maxViewRange);
	void viewMap(int playerTeam, int x, int y, int maxViewRange);

	bool findSpice(Coord* destination, Coord* origin);
	bool perfectlyInACell(ObjectClass* thing);
	bool okayToPlaceStructure(int x, int y, int buildingSizeX, int buildingSizeY, bool tilesRequired, PlayerClass* aPlayer);
	bool isWithinBuildRange(int x, int y, PlayerClass* aPlayer);
	bool okayToBuildExclusive(int x, int y, int buildingSizeX, int buildingSizeY);
	int getPosAngle(const Coord& source, const Coord& pos) const;
	BLOCKEDTYPE cellBlocked(int xPos, int yPos);
	Coord findClosestEdgePoint(const Coord& origin, const Coord& buildingSize) const;
	Coord findDeploySpot(const Coord* origin, const Coord* gatherPoint, const Coord* buildingSize, ObjectClass* object) const;//building size is num squares
	ObjectClass* findObjectWidthID(int objectID, int lx, int ly);


	inline bool cellExists(int xPos, int yPos) {
		return ((xPos >= 0) && (xPos < sizeX) && (yPos >= 0) && (yPos < sizeY));
	}

	inline bool cellExists(const Coord& pos) {
		return cellExists(pos.x, pos.y);
	}

	inline int getWinFlags() {
		return (int)winFlags;
	}

	inline TerrainClass* getCell(int xPos, int yPos)	{
		if(cellExists(xPos,yPos))
			return &cell[xPos][yPos];
		else {
			fprintf(stderr,"getCell (%s - %d): cell[%d][%d] does not exist\n",__FILE__,__LINE__,xPos,yPos);
			fflush(stderr);
			return NULL;
		}
	}

	inline TerrainClass* getCell(const Coord& location)   {
		return getCell(location.x, location.y);
	}

	Sint32	sizeX;          ///< number of tiles this map is wide
	Sint32  sizeY;          ///< number of tiles this map is high
	Sint32  winFlags;       ///< the win-flags of this map

	TerrainClass **cell;    ///< the 2d-array containing all the cells of the map

	short   *depthCheckCount;   ///< needed for the A-Star search
	short   ***depthCheckMax;   ///< needed for the A-Star search
private:
	ObjectClass* lastSinglySelectedObject;      ///< The last selected object. If selected again all units of the same time are selected
};


#endif // MAPCLASS_H
