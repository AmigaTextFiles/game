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

#include <units/InfantryClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>
#include <MapClass.h>
#include <SoundPlayer.h>

#include <structures/StructureClass.h>
#include <structures/RepairYardClass.h>

InfantryClass::InfantryClass(PlayerClass* newOwner) : GroundUnit(newOwner)
{
    InfantryClass::init();

    health = getMaxHealth();

    cellPosition = INVALID_POS;
    oldCellPosition = INVALID_POS;
}

InfantryClass::InfantryClass(Stream& stream) : GroundUnit(stream)
{
    InfantryClass::init();

	cellPosition = stream.readSint8();
	oldCellPosition = stream.readSint8();
}

void InfantryClass::init()
{
	infantry = true;

	walkFrame = 0;
}

InfantryClass::~InfantryClass()
{
}


void InfantryClass::save(Stream& stream) const
{
	GroundUnit::save(stream);

	stream.writeSint8(cellPosition);
	stream.writeSint8(oldCellPosition);
}

void InfantryClass::assignToMap(const Coord& pos)
{
	if(currentGameMap->cellExists(pos)) {
		oldCellPosition = cellPosition;
		cellPosition = currentGameMap->cell[pos.x][pos.y].assignInfantry(getObjectID());
	}
}

void InfantryClass::blitToScreen()
{
	SDL_Rect dest, source;
    dest.x = getDrawnX();
    dest.y = getDrawnY();
    dest.w = source.w = imageW;
    dest.h = source.h = imageH;

    int temp = drawnAngle;
    if (temp == UP)
        temp = 1;
    else if (temp == DOWN)
        temp = 3;
    else if (temp == LEFTUP || temp == LEFTDOWN || temp == LEFT)
        temp = 2;
    else	//RIGHT
        temp = 0;

    source.x = temp*imageW;

    if (walkFrame/10 == 3)
        source.y = imageH;
    else
        source.y = walkFrame/10*imageH;

    SDL_BlitSurface(graphic, &source, screen, &dest);
}

bool InfantryClass::canPass(int xPos, int yPos) const
{
	bool passable = false;
	if (currentGameMap->cellExists(xPos, yPos))
	{
		TerrainClass* cell = currentGameMap->getCell(xPos, yPos);
		if (!cell->hasAGroundObject())
		{
			if (cell->getType() != Terrain_Mountain)
				passable = true;
			else
			{
				/* if this unit is infantry so can climb, and cell can take more infantry */
				if (cell->infantryNotFull())
					passable = true;
			}
		}
		else
		{
			ObjectClass *object = cell->getGroundObject();

			if ((object != NULL) && (object->getObjectID() == target.getObjectID())
				&& object->isAStructure()
				&& (object->getOwner()->getTeam() != owner->getTeam())
				&& object->isVisible(getOwner()->getTeam()))
			{
				passable = true;
			} else {
				passable = (!cell->hasANonInfantryGroundObject()
							&& (cell->infantryNotFull()
							&& (cell->getInfantryTeam() == getOwner()->getTeam())));
			}
		}
	}
	return passable;
}

void InfantryClass::checkPos()
{
	if(moving) {
		if(++walkFrame > 39) {
			walkFrame = 0;
		}
	}

	if(justStoppedMoving) {
		walkFrame = 0;

		if(currentGameMap->getCell(location)->isBloom()) {
			Coord realPos;
			realPos.x = location.x*BLOCKSIZE + BLOCKSIZE/2;
			realPos.y = location.y*BLOCKSIZE + BLOCKSIZE/2;
			currentGameMap->getCell(location)->damageCell(objectID, getOwner(), realPos, NONE, 500, BLOCKSIZE, false);
		}

        //check to see if close enough to blow up target
        if(target
            && target.getObjPointer()->isAStructure()
            && (getOwner()->getTeam() != target.getObjPointer()->getOwner()->getTeam()))
        {
            Coord	closestPoint;

            closestPoint = target.getObjPointer()->getClosestPoint(location);

            if(blockDistance(location, closestPoint) <= 0.5) {
                if(target.getObjPointer()->getHealthColour() == COLOUR_RED) {
                    int targetID = target.getObjPointer()->getItemID();
                    int targetOID = target.getObjPointer()->getObjectID();
                    int posX = target.getObjPointer()->getX();
                    int posY = target.getObjPointer()->getY();
                    int h;
                    int oldHealth = target.getObjPointer()->getHealth();

                    StructureClass *temp = target.getStructurePointer();
                    temp->setHealth(0);
                    h = temp->getOriginalHouse();

                    if(temp) {
                        //fprintf(stdout,"Infantry captured structure %d!\n",temp->getObjectID());
                        //delete temp;
                        temp = (StructureClass*)owner->placeStructure(NONE, targetID, posX, posY);
                        temp->setObjectID(targetOID);
                        temp->setOriginalHouse(h);
                        temp->setHealth(oldHealth);
                        setTarget(NULL);
                    }
                } else {
                    Coord realPos;
                    realPos.x = location.x*BLOCKSIZE + BLOCKSIZE/2;
                    realPos.y = location.y*BLOCKSIZE + BLOCKSIZE/2;
                    currentGameMap->getCell(location)->damageCell(objectID, getOwner(), realPos, NONE, 100, BLOCKSIZE, false);
                }
                destroy();
                return;
            }
        } else if(target && target.getObjPointer()->isAStructure())	{
            Coord	closestPoint;
            closestPoint = target.getObjPointer()->getClosestPoint(location);

            if(blockDistance(location, closestPoint) <= 0.5) {
                destroy();
                return;
            }
        }
	}

	if(goingToRepairYard) {
		Coord closestPoint = target.getObjPointer()->getClosestPoint(location);
		if((justStoppedMoving == true) && (blockDistance(location, closestPoint) <= 1.5)
			&& ((RepairYardClass*)target.getObjPointer())->isFree()) {

			if(health*100/getMaxHealth() < 100) {
				setGettingRepaired();
			} else {
				setTarget(NULL);
				setDestination(guardPoint);
			}
		}
	}
}

void InfantryClass::destroy()
{
    if(currentGameMap->cellExists(location) && isVisible()) {
        TerrainClass* pTerrain = currentGameMap->getCell(location);

        if(pTerrain->hasANonInfantryGroundObject() && pTerrain->getNonInfantryGroundObject()->isAUnit()) {
            // squashed
            pTerrain->assignDeadObject( currentGame->RandomGen.randBool() ? DeadObject_Infantry_Squashed1 : DeadObject_Infantry_Squashed2,
                                        owner->getHouse(),
                                        Coord((Sint32) realX, (Sint32) realY) );

            if(isVisible(getOwner()->getTeam()))
                soundPlayer->playSoundAt(Sound_Squashed,location);

        } else {
            // "normal" dead
            pTerrain->assignDeadObject( DeadObject_Infantry,
                                        owner->getHouse(),
                                        Coord((Sint32) realX, (Sint32) realY));

            if(isVisible(getOwner()->getTeam()))
                soundPlayer->playSoundAt(getRandomOf(5,Sound_Scream1,Sound_Scream2,Sound_Scream3,Sound_Scream4,Sound_Scream5),location);
        }
    }

	UnitClass::destroy();
}

void InfantryClass::move()
{
	if(!moving && currentGame->RandomGen.rand(0,40) == 0)
		currentGameMap->viewMap(owner->getTeam(), location, getViewRange());

	if (moving)
	{
		Coord	wantedReal;

		realX += xSpeed;
		realY += ySpeed;

		wantedReal.x = nextSpot.x*BLOCKSIZE + BLOCKSIZE/2,
		wantedReal.y = nextSpot.y*BLOCKSIZE + BLOCKSIZE/2;

		switch (cellPosition) {

		case 1:
			wantedReal.x -= BLOCKSIZE/4;
			wantedReal.y -= BLOCKSIZE/4;
			break;

		case 2:
			wantedReal.x += BLOCKSIZE/4;
			wantedReal.y -= BLOCKSIZE/4;
			break;

		case 3:
			wantedReal.x -= BLOCKSIZE/4;
			wantedReal.y += BLOCKSIZE/4;
			break;

		case 4:
			wantedReal.x += BLOCKSIZE/4;
			wantedReal.y += BLOCKSIZE/4;
			break;

		default:
			break;
		}

		if ((fabs((double)wantedReal.x - realX) <= 0.2) && (fabs((double)wantedReal.y - realY) <= 0.2))
		{
			realX = wantedReal.x;
			realY = wantedReal.y;
			oldLocation = location;
			location = nextSpot;

            if(forced && (location == destination) && !target) {
				setForced(false);
			}

			moving = false;
			justStoppedMoving = true;

			unassignFromMap(oldLocation);

			currentGameMap->viewMap(owner->getTeam(), location, getViewRange());

		}
	} else {
		justStoppedMoving = false;
	}

	checkPos();
}


void InfantryClass::setLocation(int xPos, int yPos)
{
	if (currentGameMap->cellExists(xPos, yPos) || ((xPos == INVALID_POS) && (yPos == INVALID_POS)))
	{
		oldCellPosition = cellPosition = INVALID_POS;
		GroundUnit::setLocation(xPos, yPos);
		switch (cellPosition)
		{
		case 1:
			realX -= BLOCKSIZE/4;
			realY -= BLOCKSIZE/4;
			break;
		case 2:
			realX += BLOCKSIZE/4;
			realY -= BLOCKSIZE/4;
			break;
		case 3:
			realX -= BLOCKSIZE/4;
			realY += BLOCKSIZE/4;
			break;
		case 4:
			realX += BLOCKSIZE/4;
			realY += BLOCKSIZE/4;
			break;
		default:
			break;
		}
	}
}

void InfantryClass::setSpeeds()
{
	if (oldCellPosition == INVALID_POS)
		fprintf(stdout, "InfantryClass::setSpeeds(): Infantry cell position  == INVALID_POS.\n");
	else if (cellPosition == oldCellPosition)	//havent changed infantry position
		GroundUnit::setSpeeds();
	else
	{
		int sx = 0, sy = 0, dx = 0, dy = 0;
		switch (oldCellPosition)
		{
		case 0: sx = sy = 0; break;
		case 1: sx = -BLOCKSIZE/4; sy = -BLOCKSIZE/4; break;
		case 2: sx = BLOCKSIZE/4; sy = -BLOCKSIZE/4; break;
		case 3: sx = -BLOCKSIZE/4; sy = BLOCKSIZE/4; break;
		case 4: sx = BLOCKSIZE/4; sy = BLOCKSIZE/4; break;
		}

		switch (cellPosition)
		{
		case 0: dx = dy = 0; break;
		case 1: dx = -BLOCKSIZE/4; dy = -BLOCKSIZE/4; break;
		case 2: dx = BLOCKSIZE/4; dy = -BLOCKSIZE/4; break;
		case 3: dx = -BLOCKSIZE/4; dy = BLOCKSIZE/4; break;
		case 4: dx = BLOCKSIZE/4; dy = BLOCKSIZE/4; break;
		}

		switch (drawnAngle)
		{
		case (RIGHT): dx += BLOCKSIZE; break;
		case (RIGHTUP): dx += BLOCKSIZE; dy -= BLOCKSIZE; break;
		case (UP): dy -= BLOCKSIZE; break;
		case (LEFTUP): dx -= BLOCKSIZE; dy -= BLOCKSIZE; break;
		case (LEFT): dx -= BLOCKSIZE; break;
		case (LEFTDOWN): dx -= BLOCKSIZE; dy += BLOCKSIZE; break;
		case (DOWN): dy += BLOCKSIZE; break;
		case (RIGHTDOWN): dx += BLOCKSIZE; dy += BLOCKSIZE; break;
		}

		dx -= sx;
		dy -= sy;

		double scale = currentGame->objectData.data[itemID].maxspeed/sqrt((double)(dx*dx + dy*dy));
		xSpeed = dx*scale;
		ySpeed = dy*scale;
	}
}

void InfantryClass::squash()
{
	destroy();
	return;
}

void InfantryClass::playConfirmSound() {
	soundPlayer->playSound(getRandomOf(2,MovingOut,InfantryOut));
}

void InfantryClass::playSelectSound() {
	soundPlayer->playSound(YesSir);
}
