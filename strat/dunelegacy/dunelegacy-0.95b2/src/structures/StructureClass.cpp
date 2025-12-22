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

#include <structures/StructureClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>
#include <MapClass.h>
#include <ScreenBorder.h>
#include <Explosion.h>
#include <SoundPlayer.h>

#include <misc/draw_util.h>

#include <ObjectInterfaces.h>

StructureClass::StructureClass(PlayerClass* newOwner) : ObjectClass(newOwner)
{
    StructureClass::init();

    repairing = false;
    origHouse = owner->getHouse();

    fogged = false;
}

StructureClass::StructureClass(Stream& stream): ObjectClass(stream)
{
    StructureClass::init();

    repairing = stream.readBool();
    origHouse = stream.readUint32();

    fogged = stream.readBool();
}

void StructureClass::init() {
	aStructure = true;

	structureSize.x = 0;
	structureSize.y = 0;

	JustPlacedTimer = 0;

	curAnimFrame = 2;
	animationCounter = 0;

	structureList.push_back(this);
}

StructureClass::~StructureClass()
{
}

void StructureClass::save(Stream& stream) const
{
	ObjectClass::save(stream);

    stream.writeBool(repairing);
	stream.writeUint32(origHouse);

	stream.writeBool(fogged);
}

void StructureClass::assignToMap(const Coord& pos)
{
	Coord temp;
	for (int i = pos.x; i < pos.x + structureSize.x; i++) {
		for (int j = pos.y; j < pos.y + structureSize.y; j++)
		{
			if (currentGameMap->cellExists(i, j))
			{
				currentGameMap->cell[i][j].assignNonInfantryGroundObject(getObjectID());
				if ((itemID != Structure_Wall) && (itemID != Structure_ConstructionYard) && !currentGameMap->cell[i][j].isConcrete() && currentGame->concreteRequired && (gameState != START))
					health -= (int)(0.5*(double)getMaxHealth()/((double)(structureSize.x*structureSize.y)));
				currentGameMap->cell[i][j].setType(Terrain_Rock);
				currentGameMap->cell[i][j].setOwner(getOwner()->getPlayerNumber());
				currentGameMap->viewMap(getOwner()->getTeam(), Coord(i,j), getViewRange());

				setVisible(VIS_ALL, true);
				setRespondable(true);
			}
		}
	}
}

void StructureClass::blitToScreen()
{
    SDL_Rect dest, source;
    dest.x = getDrawnX();
    dest.y = getDrawnY();
    dest.w = source.w = imageW;
    dest.h = source.h = imageH;

    source.x = imageW * curAnimFrame;
    source.y = 0;

    if(fogged) {
        SDL_BlitSurface(graphic, &lastVisible, screen, &dest);
        SDL_BlitSurface(currentGame->fogSurf, &lastVisible, screen, &dest);
    } else {
        lastVisible = source;
        SDL_BlitSurface(graphic, &source, screen, &dest);
    }
}

ObjectInterface* StructureClass::GetInterfaceContainer() {
	if((thisPlayer == owner) || (debug == true)) {
		return DefaultStructureInterface::Create(objectID);
	} else {
		return DefaultObjectInterface::Create(objectID);
	}
}

void StructureClass::drawSelectionBox()
{
	SDL_Rect dest;
	dest.x = getDrawnX();
	dest.y = getDrawnY();
	dest.w = imageW;
	dest.h = imageH;

	//now draw the selection box thing, with parts at all corners of structure
	if (!SDL_MUSTLOCK(screen) || (SDL_LockSurface(screen) == 0))
	{
		putpixel(screen, dest.x, dest.y, COLOUR_WHITE);	//top left bit
		putpixel(screen, dest.x+1, dest.y, COLOUR_WHITE);
		putpixel(screen, dest.x, dest.y+1, COLOUR_WHITE);

		putpixel(screen, dest.x-1 + imageW, dest.y, COLOUR_WHITE);	//top right bit
		putpixel(screen, dest.x-2 + imageW, dest.y, COLOUR_WHITE);
		putpixel(screen, dest.x-1 + imageW, dest.y+1, COLOUR_WHITE);

		putpixel(screen, dest.x, dest.y-1 + imageH, COLOUR_WHITE);	//bottom left bit
		putpixel(screen, dest.x+1, dest.y-1 + imageH, COLOUR_WHITE);
		putpixel(screen, dest.x, dest.y-2 + imageH, COLOUR_WHITE);

		putpixel(screen, dest.x-1 + imageW, dest.y-1 + imageH, COLOUR_WHITE);	//bottom right bit
		putpixel(screen, dest.x-2 + imageW, dest.y-1 + imageH, COLOUR_WHITE);
		putpixel(screen, dest.x-1 + imageW, dest.y-2 + imageH, COLOUR_WHITE);

		if (SDL_MUSTLOCK(screen))
			SDL_UnlockSurface(screen);
	}

	drawhline(screen, dest.x, dest.y-2, dest.x + ((int)(((double)health/(double)getMaxHealth())*(BLOCKSIZE*structureSize.x - 1))), getHealthColour());
}


Coord StructureClass::getCenterPoint() const
{
    return Coord( lround(realX + structureSize.x*BLOCKSIZE/2),
                  lround(realY + structureSize.y*BLOCKSIZE/2));
}

Coord StructureClass::getClosestCenterPoint(const Coord& objectLocation) const
{
	return getClosestPoint(objectLocation) * BLOCKSIZE + Coord(BLOCKSIZE/2, BLOCKSIZE/2);
}

int StructureClass::getDrawnX() const
{
	return screenborder->world2screenX(realX);
}

int StructureClass::getDrawnY() const
{
	return screenborder->world2screenY(realY);
}

void StructureClass::HandleActionClick(int xPos, int yPos)
{
	if ((xPos < location.x) || (xPos >= (location.x + structureSize.x)) || (yPos < location.y) || (yPos >= (location.y + structureSize.y))) {
		currentGame->GetCommandManager().addCommand(Command(CMD_STRUCTURE_SETDEPLOYPOSITION,objectID, (Uint32) xPos, (Uint32) yPos));
	} else {
		currentGame->GetCommandManager().addCommand(Command(CMD_STRUCTURE_SETDEPLOYPOSITION,objectID, (Uint32) NONE, (Uint32) NONE));
	}
}

void StructureClass::HandleRepairClick()
{
	currentGame->GetCommandManager().addCommand(Command(CMD_STRUCTURE_REPAIR,objectID));
}

void StructureClass::DoSetDeployPosition(int xPos, int yPos) {
	setTarget(NULL);
	setDestination(xPos,yPos);
	setForced(true);
}


void StructureClass::DoRepair()
{
	repairing = true;
}

void StructureClass::setDestination(int newX, int newY)
{
	if(currentGameMap->cellExists(newX, newY) || ((newX == INVALID_POS) && (newY == INVALID_POS))) {
		destination.x = newX;
		destination.y = newY;
	}
}

void StructureClass::setJustPlaced()
{
	JustPlacedTimer = 4;
	curAnimFrame = 0;
}

bool StructureClass::update()
{
    //update map
    if(currentGame->RandomGen.rand(0,40) == 0) {
        // PROBLEM: causes very low fps
        currentGameMap->viewMap(owner->getTeam(), location, getViewRange());
    }

    doSpecificStuff();

    if(health <= 0) {
        destroy();
        return false;
    }

    if(repairing) {
        if(owner->getAmountOfCredits() >= 5) {
            owner->takeCredits(0.05);
            health += 0.5;
            if(health >= getMaxHealth()) {
                health = getMaxHealth();
                repairing = false;
            }
        } else {
            repairing = false;
        }
    } else if(owner->isAI() && (((double)health/(double)getMaxHealth()) < 0.75)) {
        DoRepair();
    }

    // update animations
    animationCounter++;
    if(animationCounter > ANIMATIONTIMER) {
        animationCounter = 0;
        curAnimFrame++;
        if((curAnimFrame < FirstAnimFrame) || (curAnimFrame > LastAnimFrame)) {
            curAnimFrame = FirstAnimFrame;
        }

        JustPlacedTimer--;
        if((JustPlacedTimer > 0) && (JustPlacedTimer % 2 == 0)) {
            curAnimFrame = 0;
        }
    }

    return true;
}

void StructureClass::destroy()
{
	int	i, j;

	currentGameMap->removeObjectFromMap(getObjectID());	//no map point will reference now
	currentGame->getObjectManager().RemoveObject(getObjectID());
	structureList.remove(this);
	owner->decrementStructures(itemID, location);

    removeFromSelectionLists();


	for(i = 0; i < structureSize.x; i++) {
           for(j = 0; j < structureSize.y; j++) {
               Coord position((location.x+i)*BLOCKSIZE + BLOCKSIZE/2, (location.y+j)*BLOCKSIZE + BLOCKSIZE/2);
               Uint32 explosionID = currentGame->RandomGen.getRandOf(2,Explosion_Large1,Explosion_Large2);
               currentGame->getExplosionList().push_back(new Explosion(explosionID, position, owner->getHouse()) );
          }
	}

	if (isVisible(thisPlayer->getTeam()))
		soundPlayer->playSoundAt(Sound_ExplosionStructure, location);


    delete this;
}

Coord StructureClass::getClosestPoint(const Coord& objectLocation) const
{
	Coord closestPoint;

	// find the closest cell of a structure from a location
	if(objectLocation.x <= location.x) {
	    // if we are left of the structure
        // set destination, left most point
		closestPoint.x = location.x;
	} else if(objectLocation.x >= (location.x + structureSize.x-1)) {
	    //vica versa
		closestPoint.x = location.x + structureSize.x-1;
	} else {
        //we are above or below at least on cell of the structure, closest path is straight
		closestPoint.x = objectLocation.x;
	}

	//same deal but with y
	if(objectLocation.y <= location.y) {
		closestPoint.y = location.y;
	} else if(objectLocation.y >= (location.y + structureSize.y-1)) {
		closestPoint.y = location.y + structureSize.y-1;
	} else {
		closestPoint.y = objectLocation.y;
	}

	return closestPoint;
}
