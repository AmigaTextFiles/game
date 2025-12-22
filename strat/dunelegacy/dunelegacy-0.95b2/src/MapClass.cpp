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

#include <MapClass.h>

#include <globals.h>

#include <GameClass.h>
#include <PlayerClass.h>
#include <MapGenerator.h>
#include <ScreenBorder.h>

#include <units/UnitClass.h>
#include <structures/StructureClass.h>

#include <stack>

MapClass::MapClass(int xSize, int ySize)
{
	sizeX = xSize;
	sizeY = ySize;

	lastSinglySelectedObject = NULL;

	int i, j, k;
	cell = new TerrainClass*[xSize];

	for (i = 0; i < xSize; i++)
		cell[i] = new TerrainClass[ySize];

	depthCheckCount = new short[std::max(xSize, ySize)];
	memset(depthCheckCount, 0, sizeof(short)*std::max(xSize, ySize));
	depthCheckMax = new short**[xSize];

	for (i=0; i<xSize; i++) {
		depthCheckMax[i] = new short*[ySize];
		for (j=0; j<ySize; j++) {
			cell[i][j].location.x = i;
			cell[i][j].location.y = j;
			depthCheckMax[i][j] = new short[std::max(xSize, ySize)+1];
		}
	}

	//arrays used by astar algorithm
	//now fill in the maximum number of cells in a square shape
	//u could look at without success around a destination i,j
	//with a specific k distance before knowing that it is
	//imposible to get to the destination.  Each time the astar
	//algorithm pushes a node with a max diff of k,
	//depthcheckcount(k) is incremented, if it reaches the
	//value in depthcheckmax(i,j,k), we know have done a full
	//square around target, and thus it is impossible to reach
	//the target, so we should try and get closer if possible,
	//but otherwise stop
	int x, y, maxSquareDepth,
		end;

	for (i=0; i<xSize; i++)	//x position
	for (j=0; j<ySize; j++)	//y position
	{
		//must account for edges of map
		depthCheckMax[i][j][0] = 0;
		maxSquareDepth = std::max(std::max((xSize-1) - i, i), std::max((ySize-1) - j, j));

		for (k=1; k<=maxSquareDepth; k++)	//manually count number of cells
		{									//bad
			depthCheckMax[i][j][k] = 0;
			y = j - k;
			if ((y >= 0) && (y < ySize))
			{
				x = i - k;
				if (x < 0)
					x = 0;

				if ((i + k) < xSize)
					end = i + k;
				else
					end = xSize - 1;

				depthCheckMax[i][j][k] += end - x + 1;
			}
			x = i + k;
			if ((x >= 0) && (x < xSize))
			{
				if (++y < 0)
					y = 0;

				if ((j + k) < ySize)
					end = j + k;
				else
					end = ySize - 1;

				depthCheckMax[i][j][k] += end - y + 1;
			}
			y = j + k;
			if ((y >= 0) && (y < ySize))
			{
				if (--x >= xSize)
					x = xSize - 1;

				if ((i - k) >= 0)
					end = i - k;
				else
					end = 0;

				depthCheckMax[i][j][k] += x - end + 1;
			}

			x = i - k;

			if ((x >= 0) && (x < xSize))
			{
				if (--y >= ySize)
					y = ySize - 1;

				if ((j - k + 1) >= 0)
					end = j - k + 1;
				else
					end = 0;

				depthCheckMax[i][j][k] += y - end + 1;
			}
			//fprintf(stdout, "depthCheckMax[%d][%d][%d] is %d.\n", i, j, k, depthCheckMax[i][j][k]);
		}
	}
}


MapClass::~MapClass()
{
	int i, j;

	if(depthCheckMax)
	{
		for (i = 0; i < sizeX; i++)
		{
			if(depthCheckMax[i])
			{
				for (j = 0; j < sizeY; j++)
				{
					if(depthCheckMax[i][j] != NULL)
						delete[] depthCheckMax[i][j];
				}
			}
		}
	}

	for (i = 0; i < sizeX; i++)
	{
		delete[] cell[i];
		delete[] depthCheckMax[i];
	}

	delete[] cell;
	delete[] depthCheckCount;
	delete[] depthCheckMax;
}

void MapClass::load(Stream& stream)
{
	sizeX = stream.readSint32();
	sizeY = stream.readSint32();
	winFlags = stream.readSint32();
	for (int i = 0; i < sizeX; i++) {
		for (int j = 0; j < sizeY; j++) {
		    stream.readString();
			cell[i][j].load(stream);
			cell[i][j].location.x = i;
			cell[i][j].location.y = j;
			stream.readString();
		}
	}

	// load all the astar-search information
	for(int i = 0; i < sizeX; i++) {
		for(int j = 0; j < sizeY; j++) {
		    cell[i][j].visited = stream.readBool();
		    cell[i][j].cost = stream.readDouble();
            cell[i][j].f = stream.readDouble();
		    cell[i][j].heuristic = stream.readDouble();

            Sint32 x,y;

            x = stream.readSint32();
            y = stream.readSint32();
            if(x == INVALID_POS || y == INVALID_POS) {
                cell[i][j].parent = NULL;
            } else {
                cell[i][j].parent = &cell[x][y];
            }

            x = stream.readSint32();
            y = stream.readSint32();
            if(x == INVALID_POS || y == INVALID_POS) {
                cell[i][j].previous = NULL;
            } else {
                cell[i][j].previous = &cell[x][y];
            }

            x = stream.readSint32();
            y = stream.readSint32();
            if(x == INVALID_POS || y == INVALID_POS) {
                cell[i][j].next = NULL;
            } else {
                cell[i][j].next = &cell[x][y];
            }
		}
	}
}

void MapClass::save(Stream& stream) const
{
	stream.writeSint32(sizeX);
	stream.writeSint32(sizeY);
	stream.writeSint32(winFlags);

	for (int i = 0; i < sizeX; i++) {
		for (int j = 0; j < sizeY; j++) {
		    stream.writeString("<Tile>");
			cell[i][j].save(stream);
			stream.writeString("</Tile>");
		}
	}

	// save all the astar-search information
	for(int i = 0; i < sizeX; i++) {
		for(int j = 0; j < sizeY; j++) {
		    stream.writeBool(cell[i][j].visited);
		    stream.writeDouble(cell[i][j].cost);
            stream.writeDouble(cell[i][j].f);
		    stream.writeDouble(cell[i][j].heuristic);
		    if(cell[i][j].parent == NULL) {
                stream.writeSint32(INVALID_POS);
                stream.writeSint32(INVALID_POS);
		    } else {
                stream.writeSint32(cell[i][j].parent->location.x);
                stream.writeSint32(cell[i][j].parent->location.y);
            }
		    if(cell[i][j].previous == NULL) {
                stream.writeSint32(INVALID_POS);
                stream.writeSint32(INVALID_POS);
		    } else {
                stream.writeSint32(cell[i][j].previous->location.x);
                stream.writeSint32(cell[i][j].previous->location.y);
            }
            if(cell[i][j].next == NULL) {
                stream.writeSint32(INVALID_POS);
                stream.writeSint32(INVALID_POS);
		    } else {
                stream.writeSint32(cell[i][j].next->location.x);
                stream.writeSint32(cell[i][j].next->location.y);
            }

		}
	}

}

void MapClass::createSandRegions()
{
	int	angle,
		i, j,
		region = 0;

	Coord pos;
	std::stack<TerrainClass*> terrainQueue;

	for(i = 0; i < sizeX; i++) {
		for(j = 0; j < sizeY; j++)	{
			cell[i][j].setSandRegion(NONE);
			cell[i][j].visited = false;
		}
	}

	for(i = 0; i < sizeX; i++) {
		for(j = 0; j < sizeY; j++) {
			if(!cell[i][j].isRock() && !cell[i][j].visited) {
				terrainQueue.push(&cell[i][j]);

				while(!terrainQueue.empty()) {
					TerrainClass* pTerrain = terrainQueue.top();
					terrainQueue.pop();

					pTerrain->setSandRegion(region);
					for(angle = 0; angle < NUM_ANGLES; angle++) {
						pos = getMapPos(angle, pTerrain->location);
						if (cellExists(pos) && !getCell(pos)->isRock() && !getCell(pos)->visited)
						{
							terrainQueue.push(getCell(pos));
							getCell(pos)->visited = true;
						}
					}
				}
				region++;
			}
		}
	}

	for (i = 0; i < sizeX; i++) {
		for (j = 0; j < sizeY; j++) {
			cell[i][j].visited = false;
		}
	}
}

void MapClass::damage(Uint32 damagerID, PlayerClass* damagerOwner, const Coord& realPos, Uint32 bulletID, int damage, int damageRadius, bool air)
{
	Coord centerCell = Coord(realPos.x/BLOCKSIZE, realPos.y/BLOCKSIZE);

	for(int i = centerCell.x-2; i <= centerCell.x+2; i++) {
		for(int j = centerCell.y-2; j <= centerCell.y+2; j++) {
			if(cellExists(i, j)) {
				getCell(i, j)->damageCell(damagerID, damagerOwner, realPos, bulletID, damage, damageRadius, air);
			}
		}
	}
}


void MapClass::setWinFlags(int newWinFlags)
{
	if (newWinFlags == 6 || newWinFlags == 7)
		currentGame->winFlags = winFlags = newWinFlags;
	else if (newWinFlags == 23)
		currentGame->winFlags = winFlags = 7;
	else
		currentGame->winFlags = winFlags = 3;
}


bool MapClass::okayToPlaceStructure(int x, int y, int buildingSizeX, int buildingSizeY, bool tilesRequired, PlayerClass* aPlayer)
{
	bool withinBuildRange = false;

	for (int i = x; i < x + buildingSizeX; i++)
	{
		for (int j = y; j < y + buildingSizeY; j++)
		{
			if (!currentGameMap->cellExists(i,j) || !currentGameMap->getCell(i,j)->isRock() || (tilesRequired && !currentGameMap->getCell(i,j)->isConcrete()) || currentGameMap->getCell(i,j)->isMountain() || currentGameMap->getCell(i,j)->hasAGroundObject())
				return false;

			if ((aPlayer == NULL) || isWithinBuildRange(i, j, aPlayer))
				withinBuildRange = true;
		}
	}
	return withinBuildRange;
}


bool MapClass::isWithinBuildRange(int x, int y, PlayerClass* aPlayer)
{
	bool withinBuildRange = false;

	for (int i = x - BUILDRANGE; i <= x + BUILDRANGE; i++)
		for (int j = y - BUILDRANGE; j <= y + BUILDRANGE; j++)
			if (cellExists(i, j) && (cell[i][j].getOwner() == aPlayer->getPlayerNumber()))
				withinBuildRange = true;

	return withinBuildRange;
}


bool MapClass::okayToBuildExclusive(int x, int y, int buildingSizeX, int buildingSizeY)
{
	for (int i = 0; i < buildingSizeX; i++)
	{
		for (int j = 0; j < buildingSizeY; j++)
		{
			if (((cellBlocked(x+i, y+j) == NOTBLOCKED) || ((i == 0) && (j == 0))))
			{
				if (!cell[x+i][y+j].isRock())
				{
					//printf("%d, %d is not rock\n", x+i, y+j);
					return false;
				}
			}
			else
			{
				//printf("%d, %d is blocked\n", x+i, y+j);
				return false;
			}
		}
	}

	return true;
}

/**
    This method figures out the direction of tile pos relative to tile source.
    \param  source  the starting point
    \param  pos     the destination
    \return one of RIGHT, RIGHTUP, UP, LEFTUP, LEFT, LEFTDOWN, DOWN, RIGHTDOWN or INVALID
*/
int MapClass::getPosAngle(const Coord& source, const Coord& pos) const
{
	if(pos.x > source.x) {
		if(pos.y > source.y) {
			return RIGHTDOWN;
        } else if(pos.y < source.y) {
			return RIGHTUP;
		} else {
			return RIGHT;
		}
	} else if(pos.x < source.x) {
		if(pos.y > source.y) {
			return LEFTDOWN;
		} else if(pos.y < source.y) {
			return LEFTUP;
		} else {
			return LEFT;
		}
	} else {
		if(pos.y > source.y) {
			return DOWN;
		} else if(pos.y < source.y) {
			return UP;
		} else {
			return INVALID;
		}
	}
}

BLOCKEDTYPE MapClass::cellBlocked(int xPos, int yPos)
{
        BLOCKEDTYPE blocked = COMBLOCKED;
        if (cellExists(xPos, yPos))
		{
			if (cell[xPos][yPos].getType() == Terrain_Mountain)
				blocked = MOUNTAIN;
			else if (cell[xPos][yPos].hasAnObject())
			{
				if (cell[xPos][yPos].getObject()->isInfantry())
					blocked = INFANTRY;
				else
					blocked = COMBLOCKED;
			}
			else
				blocked = NOTBLOCKED;
		}

        return blocked;
}

/**
    This method calculates the coordinate of one of the neighbour cells of source
    \param  angle   one of RIGHT, RIGHTUP, UP, LEFTUP, LEFT, LEFTDOWN, DOWN, RIGHTDOWN
    \param  source  the cell to calculate neigbour cell from
*/
Coord MapClass::getMapPos(int angle, const Coord& source) const
{
	switch (angle)
	{
		case (RIGHT):       return Coord(source.x + 1 , source.y);       break;
		case (RIGHTUP):     return Coord(source.x + 1 , source.y - 1);   break;
		case (UP):          return Coord(source.x     , source.y - 1);   break;
		case (LEFTUP):      return Coord(source.x - 1 , source.y - 1);   break;
		case (LEFT):        return Coord(source.x - 1 , source.y);       break;
		case (LEFTDOWN):    return Coord(source.x - 1 , source.y + 1);   break;
		case (DOWN):        return Coord(source.x     , source.y + 1);   break;
		case (RIGHTDOWN):   return Coord(source.x + 1 , source.y + 1);   break;
		default:            return Coord(source.x     , source.y);       break;
	}
}

//building size is num squares
Coord MapClass::findDeploySpot(const Coord* origin, const Coord* gatherPoint, const Coord* buildingSize, ObjectClass* object) const
{
	double		closestDistance = 1000000000.0;
	Coord	closestPoint,
				size;

	UnitClass*	unit = (UnitClass*)object;

	bool	found = false,
			foundClosest = false;

	int	counter = 0,
		depth = 0,
		edge,
		x = origin->x,
		y = origin->y,
		ranX,
		ranY;

	if ((gatherPoint == NULL) || (gatherPoint->x == INVALID_POS) || (gatherPoint->y == INVALID_POS))
		gatherPoint = NULL;
	if (buildingSize == NULL)
		size.x = size.y = 0;
	else
	{
		size.x = buildingSize->x;
		size.y = buildingSize->y;
	}

	//y += size.y;
	ranX = x; ranY = y;
	do
	{
		edge = currentGame->RandomGen.rand(0, 3);
		switch(edge)
		{
		case 0:	//right edge
			ranX = x + size.x + depth;
			ranY = currentGame->RandomGen.rand(y-depth, y + size.y+depth);
			break;
		case 1:	//top edge
            ranX = currentGame->RandomGen.rand(x-depth, x + size.x+depth);
			ranY = y - depth - 1;
			break;
		case 2:	//left edge
            ranX = x - depth - 1;
			ranY = currentGame->RandomGen.rand(y-depth, y + size.y+depth);
			break;
		case 3: //bottom edge
            ranX = currentGame->RandomGen.rand(x-depth, x + size.x+depth);
			ranY = y + size.y + depth;
			break;
		default:
			break;
		}

		if (unit->canPass(ranX, ranY))
		{
			if (gatherPoint == NULL)
			{
				closestPoint.x = ranX;
				closestPoint.y = ranY;
				found = true;
			}
			else
			{
				Coord temp = Coord(ranX, ranY);
				if (blockDistance(temp, *gatherPoint) < closestDistance)
				{
					closestDistance = blockDistance(temp, *gatherPoint);
					closestPoint.x = ranX;
					closestPoint.y = ranY;
					foundClosest = true;
				}
			}
		}

		if (counter++ >= 100)		//if hasn't found a spot on tempObject layer in 100 tries, goto next
		{
			counter = 0;
			if (++depth > (std::max(currentGameMap->sizeX, currentGameMap->sizeY)))
			{
				closestPoint.x = INVALID_POS;
				closestPoint.y = INVALID_POS;
				found = true;
				fprintf(stdout, "Map full\n"); fflush(stdout);
			}
		}
	} while (!found && (!foundClosest || (counter > 0)));

	return closestPoint;
}

/**
    This method finds the tile which is at a map border and is at minimal distance to the structure
    specified by origin and buildingsSize. This method is especcially useful for Carryalls and Frigates
    that have to enter the map to deliver units.
    \param origin           the position of the structure in map coordinates
    \param buildingsSize    the number of tiles occupied by the building (e.g. 3x2 for refinery)
*/
Coord MapClass::findClosestEdgePoint(const Coord& origin, const Coord& buildingSize) const
{
	int closestDistance = NONE;
	Coord closestPoint;

	if(origin.x < (sizeX - (origin.x + buildingSize.x))) {
		closestPoint.x = 0;
		closestDistance = origin.x;
	} else {
		closestPoint.x = sizeX - 1;
		closestDistance = sizeX - (origin.x + buildingSize.x);
	}
	closestPoint.y = origin.y;

	if(origin.y < closestDistance) {
		closestPoint.x = origin.x;
		closestPoint.y = 0;
		closestDistance = origin.y;
	}

	if((sizeY - (origin.y + buildingSize.y)) < closestDistance) {
		closestPoint.x = origin.x;
		closestPoint.y = sizeY - 1;
		closestDistance = origin.y;
	}

	return closestPoint;
}


void MapClass::removeObjectFromMap(Uint32 ObjectID)
{
	for(int y = 0; y < sizeY ; y++) {
		for(int x = 0 ; x < sizeX ; x++) {
			cell[x][y].unassignObject(ObjectID);
		}
	}
}

void MapClass::selectObjects(int playerNum, int x1, int y1, int x2, int y2, int realX, int realY, bool objectARGMode)
{
	ObjectClass	*lastCheckedObject = NULL,
				*lastSelectedObject = NULL;

	//if selection rectangle is checking only one cell and has shift selected we want to add/ remove that unit from the selected group of units
	if(!objectARGMode) {
		currentGame->unselectAll(currentGame->getSelectedList());
		currentGame->getSelectedList().clear();
	}

	if((x1 == x2) && (y1 == y2) && cellExists(x1, y1)) {

        if(cell[x1][y1].isExplored(playerNum) || debug) {
            lastCheckedObject = cell[x1][y1].getObjectAt(realX, realY);
        } else {
		    lastCheckedObject = NULL;
		}

		if((lastCheckedObject != NULL) && (lastCheckedObject->getOwner()->getPlayerNumber() == playerNum)) {
			if((lastCheckedObject == lastSinglySelectedObject) && ( !lastCheckedObject->isAStructure())) {
                for(int i = screenborder->getTopLeftTile().x; i <= screenborder->getBottomRightTile().x; i++) {
                    for(int j = screenborder->getTopLeftTile().y; j <= screenborder->getBottomRightTile().y; j++) {
                        if(cellExists(i, j) && cell[i][j].hasAnObject()) {
                            cell[i][j].selectAllPlayersUnitsOfType(playerNum, lastSinglySelectedObject->getItemID(), &lastCheckedObject, &lastSelectedObject);
                        }
                    }
				}
				lastSinglySelectedObject = NULL;

			} else if(!lastCheckedObject->isSelected())	{

				lastCheckedObject->setSelected(true);
				currentGame->getSelectedList().insert(lastCheckedObject->getObjectID());
				lastSelectedObject = lastCheckedObject;
				lastSinglySelectedObject = lastSelectedObject;

			} else if(objectARGMode) {
			    //holding down shift, unselect this unit
				lastCheckedObject->setSelected(false);
				currentGame->getSelectedList().erase(lastCheckedObject->getObjectID());
			}

		} else {
			lastSinglySelectedObject = NULL;
		}

	} else {
		lastSinglySelectedObject = NULL;
		for (int i = std::min(x1, x2); i <= std::max(x1, x2); i++)
		for (int j = std::min(y1, y2); j <= std::max(y1, y2); j++)
			if (cellExists(i, j) && cell[i][j].hasAnObject()
				&& cell[i][j].isExplored(playerNum)
				&& !cell[i][j].isFogged(playerNum) )
					cell[i][j].selectAllPlayersUnits(playerNum, &lastCheckedObject, &lastSelectedObject);
	}

	//select an enemy unit if none of your units found
	if(currentGame->getSelectedList().empty() && (lastCheckedObject != NULL) && !lastCheckedObject->isSelected()) {
		lastCheckedObject->setSelected(true);
		lastSelectedObject = lastCheckedObject;
		currentGame->getSelectedList().insert(lastCheckedObject->getObjectID());
	} else if (lastSelectedObject != NULL) {
		lastSelectedObject->playSelectSound();	//we only want one unit responding
	}

/*
	if ((selectedList->getNumElements() == 1) && lastSelectedObject && lastSelectedObject->isAStructure() && ((StructureClass*)lastSelectedObject)->isABuilder())
		((BuilderClass*)lastSelectedObject)->checkSelectionList();*/
}


bool MapClass::findSpice(Coord* destination, Coord* origin)
{
	bool found = false;

	int	counter = 0,
		depth = 1,
		x = origin->x,
		y = origin->y,
		ranX,
		ranY;

	do
	{
		do
		{
			ranX = currentGame->RandomGen.rand(x-depth, x + depth);
			ranY = currentGame->RandomGen.rand(y-depth, y + depth);
		} while (((ranX >= (x+1 - depth)) && (ranX < (x + depth))) && ((ranY >= (y+1 - depth)) && (ranY < (y + depth))));

		if (cellExists(ranX,ranY) && !cell[ranX][ranY].hasAGroundObject() && cell[ranX][ranY].hasSpice())
		{
			found = true;
			destination->x = ranX;
			destination->y = ranY;
		}

		counter++;
		if (counter >= 100)		//if hasn't found a spot on tempObject layer in 100 tries, goto next
		{
			counter = 0;
			depth++;
		}
		if (depth > std::max(sizeX, sizeY))
			return false;	//there is possibly no spice left anywhere on map
	} while (!found);

	if ((depth > 1) && (cell[origin->x][origin->y].hasSpice()))
	{
		destination->x = origin->x;
		destination->y = origin->y;
	}

	return true;
}


void MapClass::removeSpice(int xPos, int yPos)	//fixes spice tiles after spice gone to make things look smooth
{
	int i,j,
		x = xPos,
		y = yPos;

	if (cellExists(x, y))	//this is the centre cell
	{
		if (cell[x][y].getType() == Terrain_ThickSpice)
			cell[x][y].setType(Terrain_Spice);
		else
		{
			cell[x][y].setType(Terrain_Sand);
			cell[x][y].setTile(Terrain_a1);

			//thickspice tiles cant handle non-(thick)spice tiles next to them, if there is after changes, make it non thick
			for(i = x-1; i <= x+1; i++)
			for(j = y-1; j <= y+1; j++)
				if (cellExists(i, j) && (((i==x) && (j!=y)) || ((i!=x) && (j==y))) && cell[i][j].isThickSpice())	//only check cell, right, up, left and down of this one
					cell[i][j].setType(Terrain_Spice);
		}
	}

	//make it look all smooth and nice, tiles will "fit" together
	for(i = x-2; i <= x+2; i++)
	for(j = y-2; j <= y+2; j++)
		if (cellExists(i, j))
			smooth_spot(i, j);
}

void MapClass::viewMap(int playerTeam, const Coord& location, int maxViewRange)
{
	int			i;
    Coord   check;

//makes map viewable in an area like as shown below

//				       *****
//                   *********
//                  *****T*****
//                   *********
//                     *****

	check.x = location.x - maxViewRange;
	if (check.x < 0)
		check.x = 0;

	while ((check.x < sizeX) && ((check.x - location.x) <=  maxViewRange))
	{
		check.y = (location.y - lookDist[abs(check.x - location.x)]);
		if (check.y < 0) check.y = 0;

		while ((check.y < sizeY) && ((check.y - location.y) <= lookDist[abs(check.x - location.x)]))
		{
			if (distance_from(location, check) <= maxViewRange)
			for (i = 0; i < MAX_PLAYERS; i++)
				if (currentGame->player[i] && (currentGame->player[i]->getTeam() == playerTeam))
					cell[check.x][check.y].setExplored(i, true);

			check.y++;
		}

		check.x++;
		check.y = location.y;
	}

///////////////smooth the hidden shade/hide/fogged area
	if (playerTeam == thisPlayer->getTeam())
	{
		bool	up = false, upEdge = false,
				down = false, downEdge = false,
				left = false, leftEdge = false,
				right = false, rightEdge = false;

		bool    upFog = false,
				downFog = false,
				leftFog = false,
				rightFog = false;

		int		hideTile = Terrain_HiddenFull;
		int		fogTile = Terrain_HiddenFull;
		maxViewRange = 10;

		check.x = location.x - maxViewRange;
		if (check.x < 0)
			check.x = 0;
		while ((check.x < sizeX) && ((check.x - location.x) <=  maxViewRange))
		{
			check.y = (location.y - lookDist[abs(check.x - location.x)]);
			if (check.y < 0) check.y = 0;

			while ((check.y < sizeY) && ((check.y - location.y) <=  lookDist[abs(check.x - location.x)]))
			{
				if (distance_from(location, check) <= maxViewRange)
				{
					hideTile = Terrain_HiddenFull;

					upEdge = !cellExists(check.x, check.y-1);
					downEdge = !cellExists(check.x, check.y+1);
					leftEdge = !cellExists(check.x-1, check.y);
					rightEdge = !cellExists(check.x+1, check.y);

					up = !upEdge && (!cell[check.x][check.y-1].isExplored(thisPlayer->getPlayerNumber()));
					down = !downEdge && (!cell[check.x][check.y+1].isExplored(thisPlayer->getPlayerNumber()));
					left = !leftEdge && (!cell[check.x-1][check.y].isExplored(thisPlayer->getPlayerNumber()));
					right = !rightEdge && (!cell[check.x+1][check.y].isExplored(thisPlayer->getPlayerNumber()));

					upFog = !upEdge && (cell[check.x][check.y-1].isFogged(thisPlayer->getPlayerNumber()));
					downFog = !downEdge && (cell[check.x][check.y+1].isFogged(thisPlayer->getPlayerNumber()));
					leftFog = !leftEdge && (cell[check.x-1][check.y].isFogged(thisPlayer->getPlayerNumber()));
					rightFog = !rightEdge && (cell[check.x+1][check.y].isFogged(thisPlayer->getPlayerNumber()));

						// Now perform the test
					if (left && right && up && down)
							hideTile = Terrain_HiddenFull;

					else if (!left && right && up && down)
							hideTile = Terrain_HiddenNotLeft; //missing left edge

					else if (left && !right && up && down)
							hideTile = Terrain_HiddenNotRight; //missing right edge

					else if (left && right && !up && down)
							hideTile = Terrain_HiddenNotUp; //missing top edge

					else if (left && right && up && !down)
							hideTile = Terrain_HiddenNotDown; //missing bottom edge

					else if (!left && right && !up && down)
							hideTile = Terrain_HiddenDownRight; //missing top left edge

					else if (left && !right && up && !down)
							hideTile = Terrain_HiddenUpLeft; //missing bottom right edge

					else if (left && !right && !up && down)
							hideTile = Terrain_HiddenDownLeft; //missing top right edge

					else if (!left && right && up && !down)
							hideTile = Terrain_HiddenUpRight; //missing bottom left edge

					else if (left && right && !up && !down)
							hideTile = Terrain_HiddenLeftRight; //missing bottom up and down

					else if (left && !right && !up && !down)
							hideTile = Terrain_HiddenLeft; //missing above, right and below

					else if (!left && right && !up && !down)
							hideTile = Terrain_HiddenRight; //missing above, left and below

					else if (!left && !right && up && !down)
							hideTile = Terrain_HiddenUp; //only up

					else if (!left && !right && !up && down)
							hideTile = Terrain_HiddenDown; //only down

					else if (!left && !right && up && down)
							hideTile = Terrain_HiddenUpDown; //missing left and right

					else if (!cell[check.x][check.y].isExplored(thisPlayer->getPlayerNumber()) && !left && !right && !up && !down)
							hideTile = Terrain_HiddenIsland; //missing left and right
				///////
					cell[check.x][check.y].setHideTile(hideTile);

					if(!cell[check.x][check.y].isFogged(thisPlayer->getPlayerNumber()))
					{
					// do it again with fog
					fogTile = Terrain_HiddenFull;
					if (leftFog && rightFog && upFog && downFog)
							fogTile = Terrain_HiddenFull;

					else if (!leftFog && rightFog && upFog && downFog)
							fogTile = Terrain_HiddenNotLeft; //missing left edge

					else if (leftFog && !rightFog && upFog && downFog)
							fogTile = Terrain_HiddenNotRight; //missing right edge

					else if (leftFog && rightFog && !upFog && downFog)
							fogTile = Terrain_HiddenNotUp; //missing top edge

					else if (leftFog && rightFog && upFog && !downFog)
							fogTile = Terrain_HiddenNotDown; //missing bottom edge

					else if (!leftFog && rightFog && !upFog && downFog)
							fogTile = Terrain_HiddenDownRight; //missing top left edge

					else if (leftFog && !rightFog && upFog && !downFog)
							fogTile = Terrain_HiddenUpLeft; //missing bottom right edge

					else if (leftFog && !rightFog && !upFog && downFog)
							fogTile = Terrain_HiddenDownLeft; //missing top right edge

					else if (!leftFog && rightFog && upFog && !downFog)
							fogTile = Terrain_HiddenUpRight; //missing bottom left edge

					else if (leftFog && rightFog && !upFog && !downFog)
							fogTile = Terrain_HiddenLeftRight; //missing bottom up and down

					else if (leftFog && !rightFog && !upFog && !downFog)
							fogTile = Terrain_HiddenLeft; //missing above, right and below

					else if (!leftFog && rightFog && !upFog && !downFog)
							fogTile = Terrain_HiddenRight; //missing above, left and below

					else if (!leftFog && !rightFog && upFog && !downFog)
							fogTile = Terrain_HiddenUp; //only up

					else if (!leftFog && !rightFog && !upFog && downFog)
							fogTile = Terrain_HiddenDown; //only down

					else if (!leftFog && !rightFog && upFog && downFog)
							fogTile = Terrain_HiddenUpDown; //missing left and right

					/*else if (cell[check.x][check.y].isFogged(thisPlayer->getPlayerNumber()) && leftFog && rightFog
					       && upFog && downFog)
							fogTile = Terrain_HiddenIsland; //missing left and right*/
				///////
					cell[check.x][check.y].setFogTile(fogTile);
					}
					else
					cell[check.x][check.y].setFogTile(Terrain_HiddenFull);
				}

				check.y++;
			}

			check.x++;
			check.y = location.y;
		}
	}
}

void MapClass::viewMap(int playerTeam, int x, int y, int maxViewRange)
{
	viewMap(playerTeam, Coord(x,y), maxViewRange);
}


ObjectClass* MapClass::findObjectWidthID(int objectID, int lx, int ly)
{
	int			x,y;
	ObjectClass	*object = NULL;

	if (cellExists(lx, ly))
		object = getCell(lx, ly)->getObjectWithID(objectID);


	if(object == NULL) {
        //object wasn't found in expected cell
        //search surrounding cells

		for(x=lx-5; x<lx+5 && !object; x++) {
			for(y=ly-5; y<ly+5 && !object; y++) {
				if (cellExists(x, y)) {
					object = getCell(x, y)->getObjectWithID(objectID);
				}
			}
		}

		if(object == NULL) {
		    //object wasn't found in surrounding cells
            //search lists

            RobustList<UnitClass*>::const_iterator iter;
            for(iter = unitList.begin(); iter != unitList.end(); ++iter) {
				if((*iter)->hasObjectID(objectID)) {
                    object = *iter;
                    break;
				}
			}

			if(object == NULL) {
			    //object wasn't found in units
                RobustList<StructureClass*>::const_iterator iter;
                for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
                    if((*iter)->hasObjectID(objectID)) {
                        object = *iter;
                        break;
                    }
                }
			}
		}
	}

	return object;
}
