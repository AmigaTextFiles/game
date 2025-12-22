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


#include <AiPlayerClass.h>


#include <globals.h>


#include <GameClass.h>
#include <GameInitClass.h>
#include <MapClass.h>
#include <sand.h>

#include <structures/StructureClass.h>
#include <structures/BuilderClass.h>
#include <structures/StarPortClass.h>
#include <units/UnitClass.h>



AiPlayerClass::AiPlayerClass(int newPlayerNumber, int newHouse, int newColour, int newCredits, DIFFICULTYTYPE difficulty, int team) : PlayerClass(newPlayerNumber, newHouse, newColour, newCredits,team)
{
    AiPlayerClass::init();

	setDifficulty(difficulty);

	attackTimer = currentGame->RandomGen.rand(20000, 40000);
	buildTimer = 0;


}

AiPlayerClass::AiPlayerClass(Stream& stream, int playerNumber) : PlayerClass(stream, playerNumber)
{
    AiPlayerClass::init();

	setDifficulty((DIFFICULTYTYPE) stream.readUint8());
	attackTimer = stream.readSint32();
	buildTimer = stream.readSint32();

	Uint32 NumPlaceLocations = stream.readUint32();
	for(Uint32 i = 0; i < NumPlaceLocations; i++) {
        Sint32 x = stream.readSint32();
        Sint32 y = stream.readSint32();

		placeLocations.push_back(Coord(x,y));
	}
}

void AiPlayerClass::init()
{
    ai = true;
}


AiPlayerClass::~AiPlayerClass() {
}

void AiPlayerClass::save(Stream& stream) const
{
    PlayerClass::save(stream);

    stream.writeUint8(difficulty);
	stream.writeSint32(attackTimer);
    stream.writeSint32(buildTimer);

	stream.writeUint32(placeLocations.size());
	std::list<Coord>::const_iterator iter;
	for(iter = placeLocations.begin(); iter != placeLocations.end(); ++iter) {
		stream.writeSint32(iter->x);
		stream.writeSint32(iter->y);
	}
}

void AiPlayerClass::addCredits(double newCredits)
{
	if (newCredits > 0.0) {
		credits += newCredits*spiceMultiplyer;

		if (this == thisPlayer)	{
			if (currentGame->winFlags != 3)	{
				if (credits >= 1000) {
					if (currentGame->winFlags == 6)
						win();
					else if (credits >= 2700)
						win();
				}
			}
		}
	}
}

void AiPlayerClass::decrementStructures(int itemID, const Coord& location)
{
	PlayerClass::decrementStructures(itemID, location);

	/* // no good idea to rebuild everything
	//rebuild the structure if its the original gameType

	if (((currentGame->gameType == ORIGINAL) || (currentGame->gameType == SKIRMISH)) && !structureList.empty()) {
		RobustList<StructureClass*>::const_iterator iter;
		for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
			StructureClass* structure = *iter;
			if ((structure->getItemID() == Structure_ConstructionYard) && (structure->getOwner() == this)) {
				Coord *newLocation;

				if (currentGame->concreteRequired) {
					int i, j,
						incI, incJ,
						startI, startJ;

					if (currentGameMap->isWithinBuildRange(location->x, location->y, this))
						startI = location->x, startJ = location->y, incI = 1, incJ = 1;
					else if (currentGameMap->isWithinBuildRange(location->x + getStructureSize(itemID).x - 1, location->y, this))
						startI = location->x + getStructureSize(itemID).x - 1, startJ = location->y, incI = -1, incJ = 1;
					else if (currentGameMap->isWithinBuildRange(location->x, location->y + getStructureSize(itemID).y - 1, this))
						startI = location->x, startJ = location->y + getStructureSize(itemID).y - 1, incI = 1, incJ = -1;
					else
						startI = location->x + getStructureSize(itemID).x - 1, startJ = location->y + getStructureSize(itemID).y - 1, incI = -1, incJ = -1;

					for (i = startI; abs(i - startI) < getStructureSize(itemID).x; i += incI) {
						for (j = startJ; abs(j - startJ) < getStructureSize(itemID).y; j += incJ) {
							TerrainClass* tmpCell = currentGameMap->getCell(i, j);

							if(tmpCell == NULL) {
								fprintf(stdout,"%s - Line %d:getCell(%d,%d) returned NULL\n", __FILE__, __LINE__,i,j);
								fflush(stdout);
							}

							if(tmpCell->getType() != Terrain_Slab1) {
								placeLocations.push_back(Coord(i,j));
								((ConstructionYardClass*)structure)->ProduceItem(Structure_Slab1);
							}
						}
					}
				}

				((ConstructionYardClass*)structure)->ProduceItem(itemID);
				placeLocations.push_back(*location);
				break;
			}
		}
	}*/
}

void AiPlayerClass::noteDamageLocation(ObjectClass* pObject, const Coord& location)
{
    if(currentGame->InitSettings->mission == 1) {
        // make the AI more stupid in the first mission
        return;
    }

	int itemID = pObject->getItemID();

	if((itemID == Unit_Harvester) || isStructure(itemID)) {
	    //scramble some free units to defend

	    RobustList<UnitClass*>::const_iterator iter;
	    for(iter = unitList.begin(); iter != unitList.end(); ++iter) {
		    UnitClass* tempUnit = *iter;
			if (tempUnit->isRespondable()
				&& (tempUnit->getOwner() == this)
				&& !tempUnit->isAttacking()
				&& (tempUnit->getItemID() != Unit_Harvester)
				&& (tempUnit->getItemID() != Unit_MCV)
				&& (tempUnit->getItemID() != Unit_Carryall)
				&& (tempUnit->getItemID() != Unit_Frigate)
				&& (tempUnit->getItemID() != Unit_Saboteur)
				&& (tempUnit->getItemID() != Unit_Sandworm)) {

					tempUnit->DoMove2Pos(location, false);
					//tempUnit->setAttacking(true);
			}
		}

	} else if(pObject->isAUnit() && ((UnitClass*)pObject)->isAttacking()) {
	    //if one of attack force is shot, unrestrict the speeds of others as to catch up

	    RobustList<UnitClass*>::const_iterator iter;
	    for(iter = unitList.begin(); iter != unitList.end(); ++iter) {
			UnitClass* tempUnit = *iter;
			if (tempUnit->isRespondable()
				&& (tempUnit->getOwner() == this)
				&& tempUnit->isAttacking()
				&& (tempUnit->getItemID() != Unit_Harvester)
				&& (tempUnit->getItemID() != Unit_MCV)
				&& (tempUnit->getItemID() != Unit_Carryall)
				&& (tempUnit->getItemID() != Unit_Saboteur)) {
				tempUnit->setSpeedCap(NONE);
			}
		}
	}

}


void AiPlayerClass::setAttackTimer(int newAttackTimer)
{
	if (newAttackTimer >= 0)
		attackTimer = newAttackTimer;
}

void AiPlayerClass::setDifficulty(DIFFICULTYTYPE newDifficulty)
{
	if ((newDifficulty >= EASY) && (newDifficulty <= HARD))
	{
		difficulty = newDifficulty;

		switch (difficulty)
		{
		case EASY:
			spiceMultiplyer = 0.5;
			break;
		case MEDIUM:
			spiceMultiplyer = 0.75;
			break;
		case HARD:
			spiceMultiplyer = 1.0;
			break;
	/*	case IMPOSSIBLE:
			spiceMultiplyer = 1.25;
			break;*/
		default:
			break;
		}
	}
}

void AiPlayerClass::update()
{
	bool bConstructionYardChecked = false;
	if (buildTimer == 0) {

		RobustList<StructureClass*>::const_iterator iter;
		for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
            StructureClass* tempStructure = *iter;

            //if this players structure, and its a heavy factory, build something
            if(tempStructure->getOwner() == this) {
                BuilderClass* builder = (BuilderClass*) tempStructure;

                switch (tempStructure->getItemID()) {

                case (Structure_Barracks):
                case (Structure_LightFactory):
                case (Structure_WOR):
                    if (((credits + startingCredits) > 100) && (builder->getNumItemsToBuild() < 1) && (builder->getNumSelections() > 0))
                        builder->buildRandom();
                    break;

                case (Structure_ConstructionYard):
                    if(bConstructionYardChecked == false) {
                        bConstructionYardChecked = true;
                        if (((credits + startingCredits) > 100) && ((currentGame->gameType == ORIGINAL) || (currentGame->gameType == SKIRMISH)))
                        {
                            if ((builder->getNumItemsToBuild() < 1) && (builder->getNumSelections() > 0))
                            {
                                Uint32 itemID = NONE;
                                if (power < 50)
                                    itemID = Structure_WindTrap;
                                else if (numItem[Structure_Refinery] < 2)
                                    itemID = Structure_Refinery;
                                else if ((!hasRadar()) && (currentGame->techLevel >= 2))
                                    itemID = Structure_Radar;
                                else if ((numItem[Structure_WOR] <= 0) && (currentGame->techLevel >= 2))
                                    itemID = Structure_WOR;
                                else if ((numItem[Structure_RocketTurret] < 2) && (currentGame->techLevel >= 6))
                                    itemID = Structure_RocketTurret;
                                else if (power < 150)
                                    itemID = Structure_WindTrap;
                                else if ((!hasLightFactory()) && (currentGame->techLevel >= 3))
                                    itemID = Structure_LightFactory;
                                else if (numItem[Structure_Refinery] < 3)
                                    itemID = Structure_Refinery;
                                else if ((numItem[Structure_RocketTurret] < 4) && (currentGame->techLevel >= 6))
                                    itemID = Structure_RocketTurret;
                                else if ((numItem[Structure_HeavyFactory] <= 0) && (currentGame->techLevel >= 4))
                                    itemID = Structure_HeavyFactory;
                                else if ((numItem[Structure_HighTechFactory] <= 0) && (currentGame->techLevel >= 5))
                                    itemID = Structure_HighTechFactory;
                                else if ((numItem[Structure_RocketTurret] < 6) && (currentGame->techLevel >= 6))
                                    itemID = Structure_RocketTurret;
                                else if ((numItem[Structure_RepairYard] <= 0) && (currentGame->techLevel >= 5))
                                    itemID = Structure_RepairYard;
                                else if ((numItem[Structure_StarPort] <= 0) && (currentGame->techLevel >= 6))
                                    itemID = Structure_StarPort;
                                else if ((numItem[Structure_IX] <= 0) && (currentGame->techLevel >= 7))
                                    itemID = Structure_IX;
                                else if ((numItem[Structure_Palace] <= 0) && (currentGame->techLevel >= 8))
                                    itemID = Structure_Palace;
                                else if ((numItem[Structure_RocketTurret] < 10) && (currentGame->techLevel >= 6))
                                    itemID = Structure_RocketTurret;
                                else if ((numItem[Structure_WOR] < 2) && (currentGame->techLevel >= 2))
                                    itemID = Structure_WOR;
                                else if ((numItem[Structure_LightFactory] < 2) && (currentGame->techLevel >= 3))
                                    itemID = Structure_LightFactory;
                                else if ((numItem[Structure_HeavyFactory] < 2) && (currentGame->techLevel >= 4))
                                    itemID = Structure_HeavyFactory;
                                else if ((numItem[Structure_Palace] < 2) && (currentGame->techLevel >= 8))
                                    itemID = Structure_Palace;
                                else if (power < 300)
                                    itemID = Structure_WindTrap;
                                else if ((numItem[Structure_RocketTurret] < 20) && (currentGame->techLevel >= 6))
                                    itemID = Structure_RocketTurret;

                                if (itemID != NONE)
                                {

                                    Coord	placeLocation, location;

                                    location = findPlaceLocation(getStructureSize(itemID).x, getStructureSize(itemID).y);

                                    if (location.x >= 0) {
                                        placeLocation = location;
                                        if (currentGame->concreteRequired) {
                                            int i, j,
                                                incI, incJ,
                                                startI, startJ;

                                            if (currentGameMap->isWithinBuildRange(location.x, location.y, this))
                                                startI = location.x, startJ = location.y, incI = 1, incJ = 1;
                                            else if (currentGameMap->isWithinBuildRange(location.x + getStructureSize(itemID).x - 1, location.y, this))
                                                startI = location.x + getStructureSize(itemID).x - 1, startJ = location.y, incI = -1, incJ = 1;
                                            else if (currentGameMap->isWithinBuildRange(location.x, location.y + getStructureSize(itemID).y - 1, this))
                                                startI = location.x, startJ = location.y + getStructureSize(itemID).y - 1, incI = 1, incJ = -1;
                                            else
                                                startI = location.x + getStructureSize(itemID).x - 1, startJ = location.y + getStructureSize(itemID).y - 1, incI = -1, incJ = -1;

                                            for (i = startI; abs(i - startI) < getStructureSize(itemID).x; i += incI) {
                                                for (j = startJ; abs(j - startJ) < getStructureSize(itemID).y; j += incJ) {
                                                    TerrainClass *tmpCell = currentGameMap->getCell(i, j);

                                                    if(tmpCell == NULL) {
                                                        fprintf(stdout,"%s - Line %d:getCell(%d,%d) returned NULL\n", __FILE__, __LINE__,i,j);
                                                        fflush(stdout);
                                                    }

                                                    if(tmpCell->getType() != Terrain_Slab1) {

                                                        placeLocations.push_back(Coord(i,j));
                                                        builder->DoProduceItem(Structure_Slab1);
                                                    }
                                                }
                                            }
                                        }

                                        placeLocations.push_back(placeLocation);
                                        builder->DoProduceItem(itemID);
                                    }
                                }
                            }
                        }
                    }

                    if(builder->IsWaitingToPlace()) {
                        //find total region of possible placement and place in random ok position
                        int ItemID = builder->GetCurrentProducedItem();
                        Coord itemsize = getStructureSize(ItemID);

                        //see if there is already a spot to put it stored
                        if(!placeLocations.empty()) {
                            //bool concreteRequired = currentGame->concreteRequired && (ItemID != Structure_Slab1);
                            Coord location = placeLocations.front();

                            if (currentGameMap->okayToPlaceStructure(location.x, location.y, itemsize.x, itemsize.y, false /*concreteRequired*/, builder->getOwner())) {
                                builder->getOwner()->placeStructure(builder->getObjectID(), ItemID, location.x, location.y);
                                placeLocations.pop_front();
                            } else if(ItemID == Structure_Slab1) {
                                builder->DoCancelItem(Structure_Slab1);	//forget about concrete
                                placeLocations.pop_front();
                            } else {
                                //cancel item
                                builder->DoCancelItem(ItemID);
                                placeLocations.pop_front();
                            }
                        }
                    }
                    break;

                case (Structure_HeavyFactory):
                    if(((credits + startingCredits) > 100) && (builder->getNumItemsToBuild() < 1) && (builder->getNumSelections() > 0)) {

                        if(numItem[Unit_Harvester] < 2*numItem[Structure_Refinery]) {
                            builder->DoProduceItem(Unit_Harvester);
                        } else {
                            builder->buildRandom();
                        }
                    }
                    break;

                case(Structure_HighTechFactory):
                    if(((credits + startingCredits) > 100) && (builder->getNumItemsToBuild() < 1)) {

                        if(numItem[Unit_Carryall] < numItem[Unit_Harvester]) {
                            builder->DoProduceItem(Unit_Carryall);
                        } else {
                            builder->DoProduceItem(Unit_Ornithopter);
                        }
                    }
                    break;

                case (Structure_StarPort):
                    if (((StarPortClass*)builder)->okToOrder())	{
                        // order max 6 units
                        int num = 6;
                        while((num > 0) && ((credits + startingCredits) > 2000)) {
                            builder->buildRandom();
                            num--;
                        }
                        ((StarPortClass*)builder)->DoPlaceOrder();
                    }
                    break;

                default:
                    break;
                }
            }

		}

		buildTimer = currentGame->RandomGen.rand(300, 400) * (  numItem[Structure_HeavyFactory]
                                                                + numItem[Structure_LightFactory]
                                                                + numItem[Structure_WOR] );
	}


	if(attackTimer > 0) {
	    attackTimer--;
	} else {
        double speedCap = -1.0;

	    RobustList<UnitClass*>::const_iterator iter;
	    for(iter = unitList.begin(); iter != unitList.end(); ++iter) {
            UnitClass *tempUnit = *iter;

            if (tempUnit->isRespondable()
                && (tempUnit->getOwner() == this)
                && !tempUnit->isAttacking()
                && (tempUnit->getAttackMode() == AGGRESSIVE)
                && (tempUnit->getItemID() != Unit_Harvester)
                && (tempUnit->getItemID() != Unit_MCV)
                && (tempUnit->getItemID() != Unit_Carryall)
                && (tempUnit->getItemID() != Unit_Saboteur)) {
                //find slowest speed of all units
                if ((speedCap < 0.0) || (tempUnit->getMaxSpeed() < speedCap))
                    speedCap = tempUnit->getMaxSpeed();
            }
        }

        Coord destination;
        UnitClass* leader = NULL;
	    for(iter = unitList.begin(); iter != unitList.end(); ++iter) {
            UnitClass *tempUnit = *iter;
            if (tempUnit->isRespondable()
                && (tempUnit->getOwner() == this)
                && tempUnit->isActive()
                && !tempUnit->isAttacking()
                && (tempUnit->getAttackMode() == AGGRESSIVE)
                && (tempUnit->getItemID() != Unit_Harvester)
                && (tempUnit->getItemID() != Unit_MCV)
                && (tempUnit->getItemID() != Unit_Carryall)
                && (tempUnit->getItemID() != Unit_Saboteur)) {

                if(leader == NULL) {
                    leader = tempUnit;

                    //default destination
                    destination.x = leader->getX();
                    destination.y = leader->getY();

                    StructureClass* closestStructure = (StructureClass*)ObjectClass::findClosestTargetStructure(leader);
                    if(closestStructure) {
                        destination = closestStructure->getClosestPoint(leader->getLocation());
                    } else {
                        UnitClass* closestUnit = (UnitClass*)ObjectClass::findClosestTargetUnit(leader);
                        if(closestUnit) {
                            destination.x = closestUnit->getX();
                            destination.y = closestUnit->getY();
                        }
                    }
                }

                tempUnit->setSpeedCap(speedCap);
                tempUnit->DoMove2Pos(destination, false);
                tempUnit->setAttacking(true);
            }
        }

		//reset timer for next attack
		attackTimer = currentGame->RandomGen.rand(10000, 20000);
	}

	if(buildTimer > 0) {
		buildTimer--;
	}
}

Coord AiPlayerClass::findPlaceLocation(int structureSizeX, int structureSizeY)
{
	Coord bestLocation(INVALID_POS,INVALID_POS);
	int	count, x, y,
		minX = currentGameMap->sizeX, maxX = -1,
		minY = currentGameMap->sizeY, maxY = -1;
	StructureClass* structure;

    RobustList<StructureClass*>::const_iterator iter;
    for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
		structure = *iter;
		if (structure->getOwner() == this) {
			if (structure->getX() < minX)
				minX = structure->getX();
			if (structure->getX() > maxX)
				maxX = structure->getX();
			if (structure->getY() < minY)
				minY = structure->getY();
			if (structure->getY() > maxY)
				maxY = structure->getY();
		}
	}

	minX -= structureSizeX + 1;
	maxX += 2;
	minY -= structureSizeY + 1;
	maxY += 2;
	if (minX < 0) minX = 0;
	if (maxX >= currentGameMap->sizeX) maxX = currentGameMap->sizeX - 1;
	if (minY < 0) minY = 0;
	if (maxY >= currentGameMap->sizeY) maxY = currentGameMap->sizeY - 1;

	count = 0;
	do {
		x = currentGame->RandomGen.rand(minX, maxX);
		y = currentGame->RandomGen.rand(minY, maxY);
		count++;
	} while (!currentGameMap->okayToPlaceStructure(x, y, structureSizeX, structureSizeY, false, this) && (count <= 100));

	if (count <= 100) {
	    //a suitable location found!!!
		bestLocation.x = x;
		bestLocation.y = y;
	}

	return bestLocation;
}
