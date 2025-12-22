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

#include <units/Carryall.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <MapClass.h>
#include <GameClass.h>

#include <structures/RepairYardClass.h>
#include <structures/RefineryClass.h>
#include <structures/ConstructionYardClass.h>
#include <units/HarvesterClass.h>

Carryall::Carryall(PlayerClass* newOwner) : AirUnit(newOwner)
{
    Carryall::init();

    health = getMaxHealth();

	booked = false;
    idle = true;
	firstRun = true;
    owned = true;

    aDropOfferer = false;
    droppedOffCargo = false;

	curFlyPoint = 0;
	for(int i=0; i < 8; i++) {
		flyPoints[i].x = INVALID_POS;
		flyPoints[i].y = INVALID_POS;
	}
	constYardPoint.x = INVALID_POS;
	constYardPoint.y = INVALID_POS;
}

Carryall::Carryall(Stream& stream) : AirUnit(stream)
{
    Carryall::init();

	PickedUpUnitList = stream.readUint32List();
	if(!PickedUpUnitList.empty()) {
		drawnFrame = 1;
	}

    booked = stream.readBool();
    idle = stream.readBool();
    firstRun = stream.readBool();
    owned = stream.readBool();

	aDropOfferer = stream.readBool();
	droppedOffCargo = stream.readBool();

	curFlyPoint = stream.readUint8();
	for(int i=0; i < 8; i++) {
		flyPoints[i].x = stream.readSint32();
		flyPoints[i].y = stream.readSint32();
	}
	constYardPoint.x = stream.readSint32();
	constYardPoint.y = stream.readSint32();
}

void Carryall::init()
{
	itemID = Unit_Carryall;
	owner->incrementUnits(itemID);

	canAttackStuff = false;

	GraphicID = ObjPic_Carryall;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());

	imageW = graphic->w/NUM_ANGLES;
	imageH = graphic->h/2;
}

Carryall::~Carryall()
{
	;
}

void Carryall::save(Stream& stream) const
{
	AirUnit::save(stream);

	stream.writeUint32List(PickedUpUnitList);

    stream.writeBool(booked);
	stream.writeBool(idle);
	stream.writeBool(firstRun);
	stream.writeBool(owned);

	stream.writeBool(aDropOfferer);
	stream.writeBool(droppedOffCargo);

	stream.writeUint8(curFlyPoint);
	for(int i=0; i < 8; i++) {
		stream.writeSint32(flyPoints[i].x);
		stream.writeSint32(flyPoints[i].y);
	}
	stream.writeSint32(constYardPoint.x);
	stream.writeSint32(constYardPoint.y);
}

bool Carryall::update() {
    if(AirUnit::update() == false) {
        return false;
    }

	// check if this carryall has to be removed because it has just brought something
	// to the map (e.g. new harvester)
	if (active)	{
		if(aDropOfferer && droppedOffCargo
            && (    (location.x == 0) || (location.x == currentGameMap->sizeX-1)
                    || (location.y == 0) || (location.y == currentGameMap->sizeY-1))
            && !moving)	{

            setVisible(VIS_ALL, false);
            destroy();
            return false;
		}
	}

	return true;
}

void Carryall::checkPos()
{
	AirUnit::checkPos();

	if (active)	{
		if (hasCargo() && (location == destination)) {
			while(PickedUpUnitList.begin() != PickedUpUnitList.end()) {
				deployUnit(*(PickedUpUnitList.begin()) );
			}

			setTarget(NULL);
			setDestination(guardPoint);

			idle = true;
		} else if(idle && !firstRun) {
			//fly around const yard
			Coord point;
			int looped = 0;
			point = this->getClosestPoint(location);

			if(point == guardPoint) {
				//arrived at point, move to next
				curFlyPoint++;

				if(curFlyPoint >= 8) {
					curFlyPoint = 0;
				}

				while(!(currentGameMap->cellExists(flyPoints[curFlyPoint].x, flyPoints[curFlyPoint].y)) && looped <= 2) {
					curFlyPoint++;

					if(curFlyPoint >= 8) {
						curFlyPoint = 0;
						looped++;
					}
				}

				setGuardPoint(flyPoints[curFlyPoint]);
				setDestination(guardPoint);
			}
		} else if(firstRun && owned) {
			findConstYard();
			setGuardPoint(constYardPoint);
			setDestination(guardPoint);
			firstRun = false;
		}
	}
}

void Carryall::deployUnit(Uint32 UnitID)
{
	bool found = false;


	std::list<Uint32>::iterator iter;
	for(iter = PickedUpUnitList.begin() ; iter != PickedUpUnitList.end(); ++iter) {
		if(*iter == UnitID) {
			found = true;
			break;
		}
	}

	PickedUpUnitList.remove(UnitID);

	UnitClass* unit = (UnitClass*) (currentGame->getObjectManager().getObject(UnitID));

	if(unit == NULL)
		return;

	if (found) {
		if (currentGameMap->getCell(location)->hasANonInfantryGroundObject()) {
			ObjectClass* object = currentGameMap->getCell(location)->getNonInfantryGroundObject();
			if (object->getOwner() == getOwner()) {
				if (object->getItemID() == Structure_RepairYard) {
					if (((RepairYardClass*)object)->isFree()) {
						unit->setTarget(object);
						unit->setGettingRepaired();
						unit = NULL;
					} else {
						((RepairYardClass*)object)->unBook();
					}
				} else if ((object->getItemID() == Structure_Refinery) && (unit->getItemID() == Unit_Harvester)) {
					if (((RefineryClass*)object)->isFree()) {
						((HarvesterClass*)unit)->setTarget(object);
						((HarvesterClass*)unit)->setReturned();
						unit = NULL;
						goingToRepairYard = false;
					}
				}
			}
		}

		if(unit != NULL) {
			unit->setAngle(drawnAngle);
			Coord deployPos = currentGameMap->findDeploySpot(&location, NULL, NULL, unit);
			unit->deploy(deployPos);
		}

		if (PickedUpUnitList.empty())
		{
			if(!aDropOfferer) {
				booked = false;
                idle = true;
			}
			droppedOffCargo = true;
			drawnFrame = 0;
			recalculatePathTimer = 0;
		}
	}
}

void Carryall::destroy()
{
    // destroy cargo
	std::list<Uint32>::const_iterator iter;
	for(iter = PickedUpUnitList.begin() ; iter != PickedUpUnitList.end(); ++iter) {
		UnitClass* unit = (UnitClass*) (currentGame->getObjectManager().getObject(*iter));
		if(unit != NULL) {
			unit->destroy();
		}
	}
	PickedUpUnitList.clear();

	// place wreck
    if(isVisible() && currentGameMap->cellExists(location)) {
        TerrainClass* pTerrain = currentGameMap->getCell(location);
        pTerrain->assignDeadObject(DeadObject_Carrall, owner->getHouse(), Coord((Sint32) realX, (Sint32) realY));
    }

	AirUnit::destroy();
}

void Carryall::engageTarget()
{
	if(!target)
	{
		fprintf(stdout,"Carryall::engageTarget(): No target given\n");
		fflush(stdout);
	}
	else if ((target.getObjPointer() == NULL)
		|| (!target.getObjPointer()->isVisible(getOwner()->getTeam()))
		|| (target.getObjPointer()->isAGroundUnit()
			&& !((GroundUnit*)target.getObjPointer())->isAwaitingPickup())
		|| (target.getObjPointer()->getOwner()->getTeam() != owner->getTeam()))
	{
		setTarget(NULL);

		if (!hasCargo())
		{
			booked = false;
			idle = true;
			setDestination(guardPoint);
			nextSpotFound = false;
		}
	}
	else
	{
		Coord targetLocation = target.getObjPointer()->getClosestPoint(location);
		Coord realLocation, realDestination;
		realLocation.x = lround(realX);
		realLocation.y = lround(realY);
		realDestination.x = targetLocation.x * BLOCKSIZE + BLOCKSIZE/2;
		realDestination.y = targetLocation.y * BLOCKSIZE + BLOCKSIZE/2;

		targetAngle = lround((double)NUM_ANGLES*dest_angle(realLocation, realDestination)/256.0);
		if (targetAngle == 8)
			targetAngle = 0;

		targetDistance = blockDistance(location, targetLocation);

		if (targetDistance <= currentGame->objectData.data[itemID].weaponrange)
		{
			if (target.getObjPointer()->isAUnit())
				targetAngle = ((GroundUnit*)target.getObjPointer())->getAngle();

			if (drawnAngle == targetAngle)
			{
				if (target.getObjPointer()->isAGroundUnit())
					pickupTarget();
				else if (hasCargo() && target.getObjPointer()->isAStructure())
				{
					while(PickedUpUnitList.begin() != PickedUpUnitList.end()) {
						deployUnit(*(PickedUpUnitList.begin()) );
					}

					setTarget(NULL);
					setDestination(guardPoint);
				}
			}
		}
		else
			setDestination(targetLocation);
	}
}

void Carryall::giveCargo(UnitClass* newUnit)
{
	if(newUnit == NULL)
		return;

	booked = true;
	PickedUpUnitList.push_back(newUnit->getObjectID());

	newUnit->setPickedUp(this);

	if (getItemID() != Unit_Frigate)
		drawnFrame = 1;

	droppedOffCargo = false;
}

void Carryall::HandleActionClick(int xPos, int yPos)
{
	if(!currentGameMap->cellExists(xPos,yPos))
		return;

	if (respondable && !aDropOfferer && !booked) {
		if (currentGameMap->cell[xPos][yPos].hasAnObject()) {
			ObjectClass	*tempTarget = currentGameMap->cell[xPos][yPos].getObject();

			if (tempTarget == this)	{
				currentGame->GetCommandManager().addCommand(Command(CMD_CARRYALL_SETDEPLOYSTRUCTURE,objectID,NONE));
			} else {
				currentGame->GetCommandManager().addCommand(Command(CMD_CARRYALL_SETDEPLOYSTRUCTURE,objectID,tempTarget->getObjectID()));
			}
		} else {
			AirUnit::HandleActionClick(xPos, yPos);
		}

		pathList.clear();
	}
}

void Carryall::DoSetDeployStructure(Uint32 TargetObjectID) {
	if (target && target.getObjPointer()->isAStructure()) {
		if (goingToRepairYard) {
			((RepairYardClass*)target.getObjPointer())->unBook();
			goingToRepairYard = false;
			target.PointTo(NONE);
		} else if (target.getObjPointer()->getItemID() == Structure_Refinery) {
			((RefineryClass*)target.getObjPointer())->unBook();
			target.PointTo(NONE);
		}
	}

	if(TargetObjectID == NONE) {
		std::list<Uint32>::iterator iter;
		for(iter = PickedUpUnitList.begin() ; iter != PickedUpUnitList.end(); ++iter) {
			deployUnit(*iter);
		}
		PickedUpUnitList.clear();
	} else {
		ObjectClass* pTarget = currentGame->getObjectManager().getObject(TargetObjectID);
		if (pTarget->isAStructure())	{
			int targetID = pTarget->getItemID();
			if (targetID == Structure_RepairYard) {
				((RepairYardClass*) pTarget)->book();
				goingToRepairYard = true;
			} else if (targetID == Structure_Refinery) {
				((RefineryClass*) pTarget)->book();
			}
		}
	}

	pathList.clear();
}

void Carryall::pickupTarget()
{
	if (target.getObjPointer()->isAGroundUnit()) {

		if (target.getObjPointer()->hasATarget()
			|| ( ((GroundUnit*)target.getObjPointer())->getGuardPoint() != target.getObjPointer()->getLocation())
			|| ((GroundUnit*)target.getObjPointer())->isBadlyDamaged())	{

			if(((GroundUnit*)target.getObjPointer())->isBadlyDamaged())	{
				((GroundUnit*)target.getObjPointer())->DoRepair();
			}

			ObjectClass* newTarget = target.getObjPointer()->hasATarget() ? target.getObjPointer()->getTarget() : NULL;

			PickedUpUnitList.push_back(target.getObjectID());
			((GroundUnit*)target.getObjPointer())->setPickedUp(this);

			drawnFrame = 1;
			booked = true;

            if(newTarget && ((newTarget->getItemID() == Structure_Refinery)
                              || (newTarget->getItemID() == Structure_RepairYard)))
            {
                setTarget(newTarget);
                Coord closestPoint = target.getObjPointer()->getClosestPoint(location);
                setDestination(closestPoint);
            } else if (((GroundUnit*)target.getObjPointer())->getDestination().x != INVALID_POS) {
                setDestination(((GroundUnit*)target.getObjPointer())->getDestination());
            }
            clearPath();
            recalculatePathTimer = 0;
		} else {
			((GroundUnit*)target.getObjPointer())->setAwaitingPickup(false);
			setTarget(NULL);
		}
	}
}

void Carryall::setTarget(ObjectClass* newTarget)
{
	if (target
		&& targetFriendly
		&& target.getObjPointer()->isAGroundUnit()
		&& (((GroundUnit*)target.getObjPointer())->getCarrier() == this))
	{
		((GroundUnit*)target.getObjPointer())->bookCarrier(NULL);
	}

	UnitClass::setTarget(newTarget);

	if (target && targetFriendly && target.getObjPointer()->isAGroundUnit())
		((GroundUnit*)target.getObjPointer())->setAwaitingPickup(true);

	booked = target;
}

void Carryall::targeting()
{
	if (target)
		engageTarget();
}

void Carryall::turn()
{
	if (!moving)
	{
		int wantedAngle;

		if (target && (targetDistance <= currentGame->objectData.data[itemID].weaponrange))
			wantedAngle = targetAngle;
		else
			wantedAngle = nextSpotAngle;

		if (wantedAngle != -1)
		{
			if (justStoppedMoving)
			{
				angle = wantedAngle;
				drawnAngle = lround(angle);
			}
			else
			{
				double	angleLeft = 0,
						angleRight = 0;

				if (angle > wantedAngle)
				{
					angleRight = angle - wantedAngle;
					angleLeft = fabs(8-angle)+wantedAngle;
				}
				else if (angle < wantedAngle)
				{
					angleRight = abs(8-wantedAngle) + angle;
					angleLeft = wantedAngle - angle;
				}

				if (angleLeft <= angleRight)
					turnLeft();
				else
					turnRight();
			}
		}
	}
}
bool Carryall::hasCargo()
{
	return (PickedUpUnitList.size() > 0);
}

void Carryall::findConstYard()
{
    double	closestYardDistance = 1000000;
    ConstructionYardClass* bestYard = NULL;

    RobustList<StructureClass*>::const_iterator iter;
    for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
        StructureClass* tempStructure = *iter;

        if((tempStructure->getItemID() == Structure_ConstructionYard) && (tempStructure->getOwner() == owner)) {
            ConstructionYardClass* tempYard = ((ConstructionYardClass*) tempStructure);
            Coord closestPoint = tempYard->getClosestPoint(location);
            double tempDistance = distance_from(location, closestPoint);

            if(tempDistance < closestYardDistance) {
                closestYardDistance = tempDistance;
                bestYard = tempYard;
            }
        }
    }

    if(bestYard) {
        constYardPoint = bestYard->getClosestPoint(location);
    } else {
        constYardPoint = guardPoint;
    }

    flyPoints[0].x = constYardPoint.x + 8;
    flyPoints[0].y = constYardPoint.y;
    flyPoints[1].x = constYardPoint.x + 4;
    flyPoints[1].y = constYardPoint.y + 4;
    flyPoints[2].x = constYardPoint.x;
    flyPoints[2].y = constYardPoint.y + 8;
    flyPoints[3].x = constYardPoint.x - 4;
    flyPoints[3].y = constYardPoint.y + 4;
    flyPoints[4].x = constYardPoint.x - 8;
    flyPoints[4].y = constYardPoint.y;
    flyPoints[5].x = constYardPoint.x - 4;
    flyPoints[5].y = constYardPoint.y - 4;
    flyPoints[6].x = constYardPoint.x;
    flyPoints[6].y = constYardPoint.y - 8;
    flyPoints[7].x = constYardPoint.x + 4;
    flyPoints[7].y = constYardPoint.y - 4;
}
