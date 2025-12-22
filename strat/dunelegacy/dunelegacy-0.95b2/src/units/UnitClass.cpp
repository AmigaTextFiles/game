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

#include <units/UnitClass.h>

#include <globals.h>

#include <SoundPlayer.h>
#include <MapClass.h>
#include <BulletClass.h>
#include <ScreenBorder.h>
#include <PriorityQ.h>
#include <ObjectInterfaces.h>

#include <misc/draw_util.h>

#include <structures/RefineryClass.h>
#include <units/HarvesterClass.h>

UnitClass::UnitClass(PlayerClass* newOwner) : ObjectClass(newOwner)
{
    UnitClass::init();

	attackMode = DEFENSIVE;     // differs from ObjectClass::ObjectClass()
    drawnAngle = currentGame->RandomGen.rand(0, 7);
	angle = lround(drawnAngle);

    goingToRepairYard = false;
    pickedUp = false;
    bFollow = false;
    guardPoint.x = INVALID_POS;
    guardPoint.y = INVALID_POS;

    moving = false;
    turning = false;
    justStoppedMoving = false;
	speedCap = -1.0;
    xSpeed = 0.0;
    ySpeed = 0.0;

    targetDistance = 0.0;
	targetAngle = INVALID;

	noCloserPointCount = 0;
    nextSpotFound = false;
	nextSpotAngle = drawnAngle;
    recalculatePathTimer = 0;
	nextSpot.x = INVALID_POS;
	nextSpot.y = INVALID_POS;

	findTargetTimer = 0;
    attacking = false;
    bAttackPos = false;
    primaryWeaponTimer = 0;
	secondaryWeaponTimer = INVALID;

	deviationTimer = INVALID;
	realOwner = newOwner;
}

UnitClass::UnitClass(Stream& stream) : ObjectClass(stream)
{
    UnitClass::init();

    goingToRepairYard = stream.readBool();
    pickedUp = stream.readBool();
    bFollow = stream.readBool();
    guardPoint.x = stream.readSint32();
	guardPoint.y = stream.readSint32();

	moving = stream.readBool();
	turning = stream.readBool();
	justStoppedMoving = stream.readBool();
	speedCap = stream.readDouble();
	xSpeed = stream.readDouble();
	ySpeed = stream.readDouble();

	targetDistance = stream.readDouble();
	targetAngle = stream.readSint8();

	noCloserPointCount = stream.readUint8();
	nextSpotFound = stream.readBool();
	nextSpotAngle = stream.readSint8();
	recalculatePathTimer = stream.readSint32();
	nextSpot.x = stream.readSint32();
	nextSpot.y = stream.readSint32();
	int numPathNodes = stream.readUint32();
	for(int i=0;i<numPathNodes; i++) {
	    Sint32 x = stream.readSint32();
	    Sint32 y = stream.readSint32();
        pathList.push_back(Coord(x,y));
	}

	findTargetTimer = stream.readSint32();
	attacking = stream.readBool();
	bAttackPos = stream.readBool();
	primaryWeaponTimer = stream.readSint32();
	secondaryWeaponTimer = stream.readSint32();

	deviationTimer = stream.readSint32();
	realOwner = currentGame->player[stream.readUint32()];
}

void UnitClass::init()
{
    aUnit = true;
    canAttackStuff = true;

	tracked = false;
	turreted = false;
	numWeapons = 0;

	drawnFrame = 0;

	unitList.push_back(this);
}

UnitClass::~UnitClass()
{
	pathList.clear();
	removeFromSelectionLists();

	currentGame->getObjectManager().RemoveObject(objectID);
}


void UnitClass::save(Stream& stream) const
{
	ObjectClass::save(stream);

	stream.writeBool(goingToRepairYard);
	stream.writeBool(pickedUp);
	stream.writeBool(bFollow);
	stream.writeSint32(guardPoint.x);
	stream.writeSint32(guardPoint.y);

	stream.writeBool(moving);
	stream.writeBool(turning);
	stream.writeBool(justStoppedMoving);
	stream.writeDouble(speedCap);
	stream.writeDouble(xSpeed);
	stream.writeDouble(ySpeed);

	stream.writeDouble(targetDistance);
	stream.writeSint8(targetAngle);

	stream.writeUint8(noCloserPointCount);
	stream.writeBool(nextSpotFound);
	stream.writeSint8(nextSpotAngle);
	stream.writeSint32(recalculatePathTimer);
	stream.writeSint32(nextSpot.x);
	stream.writeSint32(nextSpot.y);
    stream.writeUint32(pathList.size());
    for(std::list<Coord>::const_iterator iter = pathList.begin(); iter != pathList.end(); ++iter) {
        stream.writeSint32(iter->x);
        stream.writeSint32(iter->y);
    }

	stream.writeSint32(findTargetTimer);
	stream.writeBool(attacking);
	stream.writeBool(bAttackPos);
	stream.writeSint32(primaryWeaponTimer);
	stream.writeSint32(secondaryWeaponTimer);

	stream.writeSint32(deviationTimer);
	stream.writeUint32(realOwner->getPlayerNumber());
}

void UnitClass::attack()
{
	if(numWeapons) {
		Coord targetCenterPoint;
		Coord centerPoint = getCenterPoint();
		bool bAirBullet;

		if(target) {
			targetCenterPoint = target.getObjPointer()->getClosestCenterPoint(location);
			bAirBullet = target.getObjPointer()->isAFlyingUnit();
		} else {
			targetCenterPoint = currentGameMap->getCell(destination)->getCenterPoint();;
			bAirBullet = false;
		}

		if(primaryWeaponTimer == 0) {
			bulletList.push_back( new BulletClass( objectID, &centerPoint, &targetCenterPoint, bulletType,
                                                   currentGame->objectData.data[itemID].weapondamage / numWeapons, bAirBullet) );
			PlayAttackSound();
			primaryWeaponTimer = weaponReloadTime;

			secondaryWeaponTimer = 15;

			if(bAttackPos && currentGameMap->getCell(destination)->isBloom()) {
                setDestination(location);
                forced = false;
				speedCap = -1.0;
				bAttackPos = false;
			}
		}

		if((numWeapons == 2) && (secondaryWeaponTimer == 0) && !badlyDamaged) {
			bulletList.push_back( new BulletClass( objectID, &centerPoint, &targetCenterPoint, bulletType,
                                                   currentGame->objectData.data[itemID].weapondamage / numWeapons, bAirBullet) );
			PlayAttackSound();
			secondaryWeaponTimer = -1;

            if(bAttackPos && currentGameMap->getCell(destination)->isBloom()) {
                setDestination(location);
                forced = false;
				speedCap = -1.0;
				bAttackPos = false;
			}
		}
	}
}

void UnitClass::blitToScreen()
{
	SDL_Rect dest, source;
	dest.x = getDrawnX();
	dest.y = getDrawnY();
	dest.w = source.w = imageW;
	dest.h = source.h = imageH;

    if( screenborder->isInsideScreen(Coord((int) getRealX(), (int) getRealY()),Coord(getImageW(), getImageH())) == false) {
		// Out of screen
		return;
	}

    if(drawnAngle > 7) {
        fprintf(stdout,"Invalid drawnAngle(%d)\n", drawnAngle);
    }

	source.x = drawnAngle*imageW;
	source.y = drawnFrame*imageH;

	SDL_BlitSurface(graphic, &source, screen, &dest);
	if (badlyDamaged) {
		drawSmoke(screenborder->world2screenX(realX), screenborder->world2screenY(realY));
	}
}

ObjectInterface* UnitClass::GetInterfaceContainer() {
	if((thisPlayer == owner) || (debug == true)) {
		return UnitInterface::Create(objectID);
	} else {
		return DefaultObjectInterface::Create(objectID);
	}
}

int UnitClass::getCurrentAttackAngle() {
	return drawnAngle;
}

void UnitClass::deploy(const Coord& newLocation)
{
	if (currentGameMap->cellExists(newLocation))
	{
		setLocation(newLocation);

		if ((guardPoint.x == INVALID_POS) || (guardPoint.y == INVALID_POS))
			guardPoint = location;
		setDestination(guardPoint);
		pickedUp = false;
		setRespondable(true);
		setActive(true);
		setVisible(VIS_ALL, true);
	}
}

void UnitClass::destroy()
{
	setTarget(NULL);
	currentGameMap->removeObjectFromMap(getObjectID());	//no map point will reference now
	currentGame->getObjectManager().RemoveObject(objectID);

	realOwner->decrementUnits(itemID);

	unitList.remove(this);
	delete this;
}

void UnitClass::deviate(PlayerClass* newOwner)
{
	removeFromSelectionLists();
	setTarget(NULL);
	setGuardPoint(location);
	setDestination(location);
	clearPath();
	nextSpotFound = false;
	DoSetAttackMode(AGGRESSIVE);
	owner = newOwner;

	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	deviationTimer = DEVIATIONTIME;
}

void UnitClass::drawSelectionBox()
{
    SDL_Rect	dest;
    SDL_Surface* selectionBox = pDataManager->getUIGraphic(UI_SelectionBox);
    dest.x = getDrawnX() + imageW/2 - selectionBox->w/2;
    dest.y = getDrawnY() + imageH/2 - selectionBox->h/2;
	dest.w = selectionBox->w;
	dest.h = selectionBox->h;

	SDL_BlitSurface(selectionBox, NULL, screen, &dest);

	dest.x = getDrawnX() + imageW/2 - selectionBox->w/2;
	dest.y = getDrawnY() + imageH/2 - selectionBox->h/2;
	drawhline(screen, dest.x+1, dest.y-1, dest.x+1 + ((int)(((double)health/(double)getMaxHealth())*(selectionBox->w-3))), getHealthColour());

}	//want it to start in one from edges		finish one from right edge

void UnitClass::engageTarget()
{
	if(!bAttackPos
        && ((target.getObjPointer() == NULL)
                || ((!canAttack(target.getObjPointer())
                    || (!forced && !isInAttackModeRange(target.getObjPointer()))
                    ) && !targetFriendly))
            )
	{
		findTargetTimer = 0;
		forced = false;
		setTarget(NULL);

		//if (attackMode != DEFENSIVE)
		//	setGuardPoint(&location);

		setDestination(guardPoint);
		nextSpotFound = false;
		pathList.clear();
	}
	else
	{
		Coord targetLocation;

		if(bAttackPos) {
			targetLocation = destination;
		} else {
			targetLocation = target.getObjPointer()->getClosestPoint(location);

			if ((destination.x != targetLocation.x)	//targets location has moved, recalculate path
				|| (destination.y != targetLocation.y))
			{
				pathList.clear();
				nextSpotFound = false;
			}

			if(forced) {
				setDestination(targetLocation);
			}
		}

		targetDistance = blockDistance(location, targetLocation);

		targetAngle = lround(8.0/256.0*dest_angle(location, targetLocation));
		if (targetAngle == 8)
			targetAngle = 0;

		if ((targetDistance <= currentGame->objectData.data[itemID].weaponrange) && (bFollow == false)) {
          	if (!targetFriendly || forced)
			{
				if (isTracked() && target && target.getObjPointer()->isInfantry() && (forced || (attackMode == AGGRESSIVE) || (attackMode == DEFENSIVE))) {
					setDestination(targetLocation);
				} else {
					if(!bAttackPos) {
						setDestination(location);
					}
					pathList.clear();
					nextSpotFound = false;
				}

				if(getCurrentAttackAngle() == targetAngle) {
					attack();
				}
			}
		} else {
			setDestination(targetLocation);
		}
	}
}

void UnitClass::move()
{
	if(!moving && currentGame->RandomGen.rand(0,40) == 0)
		currentGameMap->viewMap(owner->getTeam(), location, getViewRange() );

	if(moving) {
		if(!badlyDamaged || isAFlyingUnit()) {
			realX += xSpeed;
			realY += ySpeed;
		} else {
			realX += xSpeed/2;
			realY += ySpeed/2;
		}

		// check if vehicle is on the first half of the way
		if(location != nextSpot) {
		    // check if vehicle is half way out of old cell
            if ((abs(location.x*BLOCKSIZE - (int)realX + BLOCKSIZE/2) >= BLOCKSIZE/2)
                || (abs(location.y*BLOCKSIZE - (int)realY + BLOCKSIZE/2) >= BLOCKSIZE/2))
            {
                unassignFromMap(location);	//let something else go in
                oldLocation = location;
                location = nextSpot;
		    }
		} else {
			// if vehicle is out of old cell
			if ((abs(oldLocation.x*BLOCKSIZE - (int)realX + BLOCKSIZE/2) >= BLOCKSIZE)
			|| (abs(oldLocation.y*BLOCKSIZE - (int)realY + BLOCKSIZE/2) >= BLOCKSIZE)) {
			    //location = nextSpot;
			    //realX = location.x*BLOCKSIZE + BLOCKSIZE/2;
			    //realY = location.y*BLOCKSIZE + BLOCKSIZE/2;

				if(forced && (location == destination) && !target) {
					setForced(false);
				}

				moving = false;
				justStoppedMoving = true;
				realX = location.x * BLOCKSIZE + BLOCKSIZE/2;
                realY = location.y * BLOCKSIZE + BLOCKSIZE/2;

				currentGameMap->viewMap(owner->getTeam(), location, getViewRange() );
			}
		}
	} else {
		justStoppedMoving = false;
	}

	checkPos();
}

void UnitClass::navigate()
{
	if(!moving) {
		if(location != destination) {
			if(!nextSpotFound)	{
				if(nextSpotAngle == drawnAngle) {
					if (pathList.empty() && (recalculatePathTimer == 0)) {
						recalculatePathTimer = 100;

						if(!AStarSearch() && (++noCloserPointCount >= 3)
							&& (location != oldLocation))
						{	//try searching for a path a number of times then give up
							if (target && targetFriendly
								&& (target.getObjPointer()->getItemID() != Structure_RepairYard)
								&& ((target.getObjPointer()->getItemID() != Structure_Refinery)
								|| (getItemID() != Unit_Harvester))) {

								setTarget(NULL);
							}

							setDestination(location);	//can't get any closer, give up
							forced = false;
							speedCap = -1.0;
						}
					}

					if(!pathList.empty()) {
						nextSpot = pathList.front();
						pathList.pop_front();
						nextSpotFound = true;
						recalculatePathTimer = 0;
						noCloserPointCount = 0;
					}
				}
			} else {
				int tempAngle;
				if ((tempAngle = currentGameMap->getPosAngle(location, nextSpot)) != INVALID)
					nextSpotAngle = tempAngle;

				if (!canPass(nextSpot.x, nextSpot.y)) {
					nextSpotFound = false;
					pathList.clear();
				} else if (drawnAngle == nextSpotAngle)	{
					moving = true;
					nextSpotFound = false;

					assignToMap(nextSpot);
					angle = drawnAngle;
					setSpeeds();
				}
			}
		} else if (!target) {
			//not moving and not wanting to go anywhere, do some random turning
			//if (currentGame->RandomGen.rand(0, RANDOMTURNTIMER) == 0)
			//	nextSpotAngle = currentGame->RandomGen.rand(0, 7);	//choose a random one of the eight possible angles
		}
	}
}

void UnitClass::HandleActionClick(int xPos, int yPos)
{
	if(respondable) {
		if (currentGameMap->cellExists(xPos, yPos)) {
			if (currentGameMap->cell[xPos][yPos].hasAnObject()) {
 				// attack unit/structure or move to structure
				ObjectClass* tempTarget = currentGameMap->cell[xPos][yPos].getObject();

				if(tempTarget->getOwner() != getOwner()) {
					// attack
					currentGame->GetCommandManager().addCommand(Command(CMD_UNIT_ATTACKOBJECT,objectID,tempTarget->getObjectID()));
				} else {
					// move to object/structure
					currentGame->GetCommandManager().addCommand(Command(CMD_UNIT_MOVE2OBJECT,objectID,tempTarget->getObjectID()));
				}
			} else {
				// move this unit
				currentGame->GetCommandManager().addCommand(Command(CMD_UNIT_MOVE2POS,objectID,(Uint32) xPos, (Uint32) yPos, (Uint32) true));
			}
		}
	}
}

void UnitClass::HandleAttackMoveClick(int xPos, int yPos) {
	if(respondable) {
		if (currentGameMap->cellExists(xPos, yPos)) {
			if (currentGameMap->cell[xPos][yPos].hasAnObject()) {
				// attack unit/structure or move to structure
				ObjectClass* tempTarget = currentGameMap->cell[xPos][yPos].getObject();

				currentGame->GetCommandManager().addCommand(Command(CMD_UNIT_ATTACKOBJECT,objectID,tempTarget->getObjectID()));
			} else {
				// move this unit
				currentGame->GetCommandManager().addCommand(Command(CMD_UNIT_ATTACKPOS,objectID,(Uint32) xPos, (Uint32) yPos, (Uint32) true));
			}
		}
	}

}

void UnitClass::HandleSetAttackModeClick(ATTACKTYPE newAttackMode) {
	currentGame->GetCommandManager().addCommand(Command(CMD_UNIT_SETMODE,objectID,(Uint32) newAttackMode));
}

void UnitClass::DoMove2Pos(int xPos, int yPos, bool bForced) {
	setGuardPoint(xPos,yPos);

	if ((xPos != destination.x) || (yPos != destination.y)) {
		clearPath();
		recalculatePathTimer = 0;
		findTargetTimer = 0;
		nextSpotFound = false;
	}

	setTarget(NULL);
	setDestination(xPos,yPos);
	setGuardPoint(xPos,yPos);
	setForced(bForced);
}

void UnitClass::DoMove2Pos(const Coord& coord, bool bForced) {
	DoMove2Pos(coord.x, coord.y, bForced);
}

void UnitClass::DoMove2Object(ObjectClass* pTargetObject) {
	if(pTargetObject->getObjectID() == getObjectID()) {
		return;
	}

	setDestination(INVALID_POS,INVALID_POS);
	setTarget(pTargetObject);
	setForced(true);

	bFollow = true;

	clearPath();
	recalculatePathTimer = 0;
	findTargetTimer = 0;
	nextSpotFound = false;
}

void UnitClass::DoMove2Object(Uint32 TargetObjectID) {
	ObjectClass* pObject = currentGame->getObjectManager().getObject(TargetObjectID);

	DoMove2Object(pObject);
}

void UnitClass::DoAttackPos(int xPos, int yPos, bool bForced) {
	setDestination(xPos,yPos);
	setTarget(NULL);
	setForced(bForced);
	bAttackPos = true;

	clearPath();
	recalculatePathTimer = 0;
	findTargetTimer = 0;
	nextSpotFound = false;
}

void UnitClass::DoAttackObject(ObjectClass* pTargetObject) {
	if(pTargetObject->getObjectID() == getObjectID()) {
		return;
	}


	setDestination(INVALID_POS,INVALID_POS);
	setTarget(pTargetObject);
	setForced(true);

	clearPath();
	recalculatePathTimer = 0;
	findTargetTimer = 0;
	nextSpotFound = false;
}

void UnitClass::DoAttackObject(Uint32 TargetObjectID) {
	ObjectClass* pObject = currentGame->getObjectManager().getObject(TargetObjectID);

	DoAttackObject(pObject);
}

void UnitClass::DoSetAttackMode(ATTACKTYPE newAttackMode)
{
	if ((newAttackMode >= SCOUT) && (newAttackMode <= AGGRESSIVE))
		attackMode = newAttackMode;
}

void UnitClass::handleDamage(int damage, Uint32 damagerID)
{
    // shorten deviation time
    deviationTimer = std::max(0,deviationTimer - 10*damage);

    ObjectClass::handleDamage(damage, damagerID);
}

void UnitClass::DoRepair()
{
    if(isAFlyingUnit()) {
        return;
    }

	if(health < getMaxHealth()) {
		//find a repair yard to return to

		int	leastNumBookings = 1000000; //huge amount so repairyard couldn't be possible
		double	closestLeastBookedRepairYardDistance = 1000000;
        RepairYardClass* bestRepairYard = NULL;

        RobustList<StructureClass*>::const_iterator iter;
        for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
            StructureClass* tempStructure = *iter;

			if ((tempStructure->getItemID() == Structure_RepairYard) && (tempStructure->getOwner() == owner)) {
                RepairYardClass* tempRepairYard = ((RepairYardClass*)tempStructure);
				Coord closestPoint = tempRepairYard->getClosestPoint(location);
				double tempDistance = distance_from(location, closestPoint);
                int tempNumBookings = tempRepairYard->getNumBookings();

                if(tempNumBookings < leastNumBookings) {
                    leastNumBookings = tempNumBookings;
                    bestRepairYard = tempRepairYard;
                    closestLeastBookedRepairYardDistance = tempDistance;
                } else if(tempNumBookings == leastNumBookings)	{
					if(tempDistance < closestLeastBookedRepairYardDistance) {
                        closestLeastBookedRepairYardDistance = tempDistance;
                        bestRepairYard = tempRepairYard;
                    }
                }
            }
        }

        if(bestRepairYard) {
            DoMove2Object(bestRepairYard);
        }
	}
}

bool UnitClass::isInAttackModeRange(ObjectClass* object)	//optimised
{
    int weaponRange = currentGame->objectData.data[itemID].weaponrange;

	//Coord objectLocation = object->getClosestPoint(location);
	//double objectDistance = blockDistance(location, objectLocation);

	switch (attackMode)
	{

		case (STANDGROUND): //if the distance to this object is in weapon range, its attackable
		{
			Coord closestPoint = object->getClosestPoint(location);
			return (blockDistance(location, closestPoint) <= weaponRange);
			break;
		}

		case (DEFENSIVE): //if the object is not further then twice the guard range plus weapon range, and this unit is not further then twice the guardrange away, its attackable
		{
			Coord objectLocation = object->getClosestPoint(location);
			return ((blockDistance(guardPoint, objectLocation) + blockDistance(location, objectLocation)) <= (2*getGuardRange() + weaponRange));
			break;
		}

		case (AGGRESSIVE):	//don't care go, its attackable
			return true;
			break;

		default:
			return false;
			break;
	}

	return false;
}

void UnitClass::setAngle(int newAngle)
{
	if (!moving && (newAngle >= 0) && (newAngle < NUM_ANGLES))
	{
		angle = drawnAngle = newAngle;
		nextSpotAngle = drawnAngle;
		nextSpotFound = false;
	}
}

void UnitClass::setGettingRepaired()
{
	if (target && (target.getObjPointer()->getItemID() == Structure_RepairYard))
	{
		if (selected)
			removeFromSelectionLists();

		currentGameMap->removeObjectFromMap(getObjectID());

		((RepairYardClass*)target.getObjPointer())->assignUnit(this);

		respondable = false;
		setActive(false);
		setVisible(VIS_ALL, false);
		goingToRepairYard = false;
		badlyDamaged = false;

		setTarget(NULL);
		//setLocation(NONE, NONE);
		setDestination(location);
		nextSpotAngle = DOWN;
	}
}

void UnitClass::setGuardPoint(int newX, int newY)
{
	if (currentGameMap->cellExists(newX, newY) || ((newX == INVALID_POS) && (newY == INVALID_POS)))
	{
		guardPoint.x = newX;
		guardPoint.y = newY;
	}
}

void UnitClass::setLocation(int xPos, int yPos)
{
	if((xPos == INVALID_POS) && (yPos == INVALID_POS))
	{
		ObjectClass::setLocation(xPos, yPos);
	} else if (currentGameMap->cellExists(xPos, yPos)) {
		ObjectClass::setLocation(xPos, yPos);
		realX += BLOCKSIZE/2;
		realY += BLOCKSIZE/2;
	}

	moving = false;
	nextSpotFound = false;
	nextSpotAngle = drawnAngle;
	pickedUp = false;
	setTarget(NULL);
	clearPath();
	noCloserPointCount = 0;

}

void UnitClass::setPickedUp(UnitClass* newCarrier)
{
	if (selected)
		removeFromSelectionLists();

	currentGameMap->removeObjectFromMap(getObjectID());

	if (goingToRepairYard) {
		((RepairYardClass*)target.getObjPointer())->unBook();
	}

	if(getItemID() == Unit_Harvester) {
		HarvesterClass* harvester = (HarvesterClass*) this;
		if(harvester->isReturning() && target && (target.getObjPointer()!= NULL)
			&& (target.getObjPointer()->getItemID() == Structure_Refinery))
		{
			((RefineryClass*)target.getObjPointer())->unBook();
		}
	}

	target.PointTo(newCarrier);

	goingToRepairYard = false;
	moving = false;
	nextSpotFound = false;
	pickedUp = true;
	respondable = false;
	setActive(false);
	setVisible(VIS_ALL, false);
}

double UnitClass::getMaxSpeed() const {
    return currentGame->objectData.data[itemID].maxspeed;
}

void UnitClass::setSpeeds()
{
	double speed = getMaxSpeed();

	if (!isAFlyingUnit()) {
		speed += speed*(1.0 - currentGameMap->getCell(location)->getDifficulty());
		speed *= HEAVILYDAMAGEDSPEEDMULTIPLIER;
	}

	if ((speedCap > 0.0) && (speedCap < speed))
		speed = speedCap;

	switch (drawnAngle)
	{
	case (LEFT): xSpeed = -speed; ySpeed = 0; break;
	case (LEFTUP): xSpeed = -speed*DIAGONALSPEEDCONST; ySpeed = xSpeed; break;
	case (UP): xSpeed = 0; ySpeed = -speed; break;
	case (RIGHTUP): xSpeed = speed*DIAGONALSPEEDCONST; ySpeed = -xSpeed; break;
	case (RIGHT): xSpeed = speed; ySpeed = 0; break;
	case (RIGHTDOWN): xSpeed = speed*DIAGONALSPEEDCONST; ySpeed = xSpeed; break;
	case (DOWN): xSpeed = 0; ySpeed = speed; break;
	case (LEFTDOWN): xSpeed = -speed*DIAGONALSPEEDCONST; ySpeed = -xSpeed;
	}
}

void UnitClass::setTarget(ObjectClass* newTarget)
{
	bAttackPos = false;
	bFollow = false;

	if (goingToRepairYard && target && (target.getObjPointer()->getItemID() == Structure_RepairYard))
	{
		((RepairYardClass*)target.getObjPointer())->unBook();
		goingToRepairYard = false;
	}

	ObjectClass::setTarget(newTarget);

	if(target
		&& (target.getObjPointer()->getOwner() == getOwner())
		&& (target.getObjPointer()->getItemID() == Structure_RepairYard)
		&& (itemID != Unit_Carryall) && (itemID != Unit_Frigate)
		&& (itemID != Unit_Ornithopter))
	{
		((RepairYardClass*)target.getObjPointer())->book();
		goingToRepairYard = true;
	}
}

void UnitClass::targeting()
{
	if(!target && !moving && !forced && (attackMode != SCOUT) && (findTargetTimer == 0)) {
		target.PointTo(findTarget());

		if(target && isInAttackModeRange(target.getObjPointer())) {
			DoAttackObject(target.getObjPointer());
			pathList.clear();
			nextSpotFound = false;
			speedCap = -1.0;
		} else {
			target.PointTo(NONE);

			if(attacking) {
				StructureClass* closestStructure = (StructureClass*)findClosestTargetStructure(this);
				if (closestStructure) {
					DoAttackObject(closestStructure);
				} else {
					UnitClass* closestUnit = (UnitClass*)findClosestTargetUnit(this);
					if(closestUnit != NULL)
                        DoAttackObject(closestUnit);
				}
			}
		}

		findTargetTimer = 100;
	}

	if(target || bAttackPos) {
		engageTarget();
	}
}

void UnitClass::turn()
{
	if(!moving) {
		int wantedAngle;
		if( (target || bAttackPos)
		      && (!targetFriendly || forced || (targetDistance < 1.0))
		      && (targetDistance <= currentGame->objectData.data[itemID].weaponrange) )
        {
			wantedAngle = targetAngle;
		} else {
			wantedAngle = nextSpotAngle;
		}

		if(wantedAngle != -1) {
			if(justStoppedMoving) {
				angle = wantedAngle;
				drawnAngle = lround(angle);
			} else {
				double	angleLeft = 0,
						angleRight = 0;

 				if(angle > wantedAngle) {
					angleRight = angle - wantedAngle;
					angleLeft = fabs(8-angle)+wantedAngle;
				} else if (angle < wantedAngle) {
					angleRight = abs(8-wantedAngle) + angle;
					angleLeft = wantedAngle - angle;
				}

				if(angleLeft <= angleRight) {
					turnLeft();
				} else {
					turnRight();
				}
			}
		}
	}
}

void UnitClass::turnLeft()
{
	angle += currentGame->objectData.data[itemID].turnspeed;
	if(angle >= 7.5) {
	    drawnAngle = lround(angle) - 8;
        angle -= 8.0;
	} else {
        drawnAngle = lround(angle);
	}
}

void UnitClass::turnRight()
{
	angle -= currentGame->objectData.data[itemID].turnspeed;
	if(angle <= -0.5) {
	    drawnAngle = lround(angle) + 8;
		angle += 8.0;
	} else {
	    drawnAngle = lround(angle);
	}
}

bool UnitClass::update()
{
    if(active) {
        targeting();
        navigate();
        move();
        if(active) {
            turn();
        }
    }

    if(badlyDamaged) {
        if(health <= 0) {
            destroy();
            return false;
        } else if(!goingToRepairYard && owner->isAI() && !isAFlyingUnit() && owner->hasRepairYard() && !forced && !target) {
            DoRepair();
        }
    }

    if(recalculatePathTimer > 0) recalculatePathTimer--;
    if(findTargetTimer > 0) findTargetTimer--;
    if(primaryWeaponTimer > 0) primaryWeaponTimer--;
    if(secondaryWeaponTimer > 0) secondaryWeaponTimer--;
    if(deviationTimer != INVALID) {
        if(--deviationTimer <= 0) {
            // revert back to real owner
            removeFromSelectionLists();
            setTarget(NULL);
            setGuardPoint(location);
            setDestination(location);
            owner = realOwner;
            graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
            deviationTimer = INVALID;
        }
    }

	return true;
}

bool UnitClass::canPass(int xPos, int yPos) const
{
	return (currentGameMap->cellExists(xPos, yPos) && !currentGameMap->getCell(xPos, yPos)->hasAGroundObject() && !currentGameMap->getCell(xPos, yPos)->isMountain());
}

int UnitClass::getDrawnX() const
{
	return screenborder->world2screenX(realX) - imageW/2;
}

int UnitClass::getDrawnY() const
{
	return screenborder->world2screenY(realY) - imageH/2;
}

/* search algorithmns */
void UnitClass::nodePushSuccesors(PriorityQ* open, TerrainClass* parent_node)
{
	int dx1, dy1, dx2, dy2;
	double	cost,
			cross,
			heuristic,
			f;

	Coord	checkedPoint = destination,
				tempLocation;
	TerrainClass* node;

	//push a node for each direction we could go
	for (int angle=0; angle<=7; angle++)	//going from angle 0 to 7 inc
	{
		tempLocation = currentGameMap->getMapPos(angle, parent_node->location);
		if (canPass(tempLocation.x, tempLocation.y))
		{
			node = &currentGameMap->cell[tempLocation.x][tempLocation.y];
			cost = parent_node->cost;
			if ((location.x != parent_node->location.x) && (tempLocation.y != parent_node->location.y))
				cost += DIAGONALCOST*(isAFlyingUnit() ? 1.0 : (double)node->getDifficulty());	//add diagonal movement cost
			else
				cost += (isAFlyingUnit() ? 1.0 : (double)node->getDifficulty());
			/*if (parent_node->parent)	//add cost of turning time
			{
				int posAngle = currentGameMap->getPosAngle(parent_node->parent->getLocation(), parent_node->getLocation());
				if (posAngle != angle)
					cost += (1.0/currentGame->objectData.data[itemID].turnspeed * (double)min(abs(angle - posAngle), NUM_ANGLES - max(angle, posAngle) + min(angle, posAngle)))/((double)BLOCKSIZE);
			}*/

			if (target)
				checkedPoint = target.getObjPointer()->getClosestPoint(tempLocation);

			dx1 = tempLocation.x - checkedPoint.x;
			dy1 = tempLocation.y - checkedPoint.y;
			dx2 = location.x - checkedPoint.x;
			dy2 = location.y - checkedPoint.y;
			cross = (double)(dx1*dy2 - dx2*dy1);

			if( cross<0 )
				cross = -cross;

			heuristic = blockDistance(tempLocation, checkedPoint);// + cross*0.1;//01;
			f = cost + heuristic;
			if (node->visited)	//if we have already looked at this node before
				if (node->f <= f)	//if got here with shorter travel time before
					continue;

			TerrainClass* tempNode;

			if ((tempNode = open->findNodeWithKey(&tempLocation)))
			{
				if (tempNode->f <= f)
					continue;

				open->removeNodeWithKey(&tempLocation);
			}
			node->cost = cost;
			node->heuristic = heuristic;
			node->f = f;
			node->parent = parent_node;
			open->insertNode(node);
		}
	}
}

bool UnitClass::AStarSearch()
{
	int numNodesChecked = 0;
	Coord checkedPoint;

	TerrainClass *node = &currentGameMap->cell[location.x][location.y];//initialise the current node the object is on
	if (target) {
		checkedPoint = target.getObjPointer()->getClosestPoint(location);
	} else {
		checkedPoint = destination;
	}

	node->f = node->heuristic = blockDistance(location, checkedPoint);

	/*for (int i=0; i<max(currentGameMap->sizeX, currentGameMap->sizeY)-1; i++)
		if (currentGameMap->depthCheckCount[i] != 0)	//very very bad if this happens, check if its in visited list and being reset to not visited
			selected = true;*/

	//if the unit is not directly next to its dest, or it is and the dest is unblocked
	if ((node->heuristic > 1.5) || canPass(checkedPoint.x, checkedPoint.y)) {
		double smallestHeuristic = node->heuristic;
		PriorityQ open(currentGameMap->sizeX*currentGameMap->sizeY);
		std::list<TerrainClass*> visitedList;
		TerrainClass	*bestDest = NULL; //if we dont find path to destination, we will head here instead

		node->next = node->parent = node->previous = NULL;
		node->cost = 0.0;
		open.insertNode(node);

		//short	maxDepth = max(currentGameMap->sizeX, currentGameMap->sizeY),
		short		depth;

		while (!open.isEmpty()) {
			//take the closest node to target out of the queue
			node = open.removeNode();

			if (node->heuristic < smallestHeuristic) {
				smallestHeuristic = node->heuristic;
				bestDest = node;

				if (node->heuristic == 0.0)	//if the distance from this node to dest is zero, ie this is the dest node
					break;	//ive found my dest!
			}

			if (numNodesChecked < currentGame->maxPathSearch)
				nodePushSuccesors(&open, node);

			if (!node->visited) {
				depth = std::max(abs(node->location.x - checkedPoint.x), abs(node->location.y - checkedPoint.y));
				if (++currentGameMap->depthCheckCount[depth] >= currentGameMap->depthCheckMax[checkedPoint.x][checkedPoint.y][depth])
					break;	//we have searched a whole square around destination, it cant be reached
				visitedList.push_back(node);	//so know which ones to reset to unvisited
				node->visited = true;
				numNodesChecked++;
			}
		}

        std::list<TerrainClass*>::const_iterator iter;
        for(iter = visitedList.begin(); iter != visitedList.end(); ++iter) {
			node = *iter;
			node->visited = false;
			depth = std::max(abs(node->location.x - checkedPoint.x), abs(node->location.y - checkedPoint.y));
			currentGameMap->depthCheckCount[depth] = 0;
		}

		//go to closest point to dest if is one
		if (bestDest != NULL) {
			node = bestDest;
			while(node->parent != NULL) {
				nextSpot = node->location;
				pathList.push_front(node->location);
				node = node->parent;
			}
			return true;
		}
	}

	//no closer point found
	return false;
}

void UnitClass::PlayAttackSound() {
}
