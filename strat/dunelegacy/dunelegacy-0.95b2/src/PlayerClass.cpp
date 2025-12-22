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

#include <PlayerClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <FileClasses/music/MusicPlayer.h>

#include <GameClass.h>
#include <MapClass.h>
#include <RadarView.h>
#include <SoundPlayer.h>
#include <MapGenerator.h>

#include <structures/StructureClass.h>
#include <structures/BuilderClass.h>
#include <structures/RefineryClass.h>
#include <units/Carryall.h>
#include <units/HarvesterClass.h>

PlayerClass::PlayerClass(int newPlayerNumber, int newHouse, int newColour, int newCredits, int team)
{
    PlayerClass::init();

	playerNumber = newPlayerNumber;
	mapPlayerNum = 0;

    house = ((newHouse >= 0) && (newHouse < NUM_HOUSES)) ? newHouse :  0;
    this->team = (team == -1) ? newPlayerNumber : team;
    colour = ((newColour >= 0) && (newColour < NUM_HOUSES)) ? newColour : 0;

	credits = 0.0;
    startingCredits = newCredits;
    oldCredits = (int) (credits+startingCredits);
}

PlayerClass::PlayerClass(Stream& stream, int playerNumber)
{
    this->playerNumber = playerNumber;

    PlayerClass::init();

	mapPlayerNum = stream.readUint8();
    house = stream.readUint8();
	team = stream.readUint8();
	colour = stream.readUint8();

	credits = stream.readDouble();
	startingCredits = stream.readDouble();
    oldCredits = (int) (credits+startingCredits);

	if(stream.readBool() == true) {
		thisPlayer = this;
	}
}

void PlayerClass::init()
{
    ai = false;

    numUnits = 0;
	numStructures = 0;
	for(int i=0;i<ItemID_max;i++) {
        numItem[i] = 0;
	}

	capacity = 0;
	power = 0;
	powerRequirement = 0;
}

PlayerClass::~PlayerClass()
{
}

void PlayerClass::save(Stream& stream) const
{
	stream.writeUint8(mapPlayerNum);
	stream.writeUint8(house);
	stream.writeUint8(team);
	stream.writeUint8(colour);

	stream.writeDouble(credits);
	stream.writeDouble(startingCredits);

	stream.writeBool(this == thisPlayer);
}

void PlayerClass::PrintStat() const {
	fprintf(stdout,"Player %d: (Number of Units: %d, Number of Structures: %d)\n",getPlayerNumber(),numUnits,numStructures);
	fprintf(stdout,"Barracks: %d\t\tWORs: %d\n", numItem[Structure_Barracks],numItem[Structure_WOR]);
	fprintf(stdout,"Light Factories: %d\tHeavy Factories: %d\n",numItem[Structure_LightFactory],numItem[Structure_HeavyFactory]);
	fprintf(stdout,"IXs: %d\t\t\tPalaces: %d\n",numItem[Structure_IX],numItem[Structure_Palace]);
	fprintf(stdout,"Repair Yards: %d\t\tHigh-Tech Factories: %d\n",numItem[Structure_RepairYard],numItem[Structure_HighTechFactory]);
	fprintf(stdout,"Refineries: %d\t\tStarports: %d\n",numItem[Structure_Refinery],numItem[Structure_StarPort]);
	fprintf(stdout,"Walls: %d\t\tRocket Turrets: %d\n",numItem[Structure_Wall],numItem[Structure_RocketTurret]);
	fprintf(stdout,"Gun Turrets: %d\t\tConstruction Yards: %d\n",numItem[Structure_GunTurret],numItem[Structure_ConstructionYard]);
	fprintf(stdout,"Windtraps: %d\t\tRadars: %d\n",numItem[Structure_WindTrap],numItem[Structure_Radar]);
	fprintf(stdout,"Silos: %d\n",numItem[Structure_Silo]);
	fprintf(stdout,"Carryalls: %d\t\tFrigates: %d\n",numItem[Unit_Carryall],numItem[Unit_Frigate]);
	fprintf(stdout,"Devastators: %d\t\tDeviators: %d\n",numItem[Unit_Devastator],numItem[Unit_Deviator]);
	fprintf(stdout,"Soldiers: %d\t\tFremen: %d\n",numItem[Unit_Soldier],numItem[Unit_Fremen]);
	fprintf(stdout,"Trooper: %d\t\tDeviators: %d\n",numItem[Unit_Trooper],numItem[Unit_Sardaukar]);
	fprintf(stdout,"Saboteur: %d\t\tSandworms: %d\n",numItem[Unit_Saboteur],numItem[Unit_Sandworm]);
	fprintf(stdout,"Quads: %d\t\tTrikes: %d\n",numItem[Unit_Quad],numItem[Unit_Trike]);
	fprintf(stdout,"Raiders: %d\t\tTanks: %d\n",numItem[Unit_Raider],numItem[Unit_Tank]);
	fprintf(stdout,"Siege Tanks : %d\t\tSonic Tanks: %d\n",numItem[Unit_SiegeTank],numItem[Unit_SonicTank]);
	fprintf(stdout,"Harvesters: %d\t\tMCVs: %d\n",numItem[Unit_Harvester],numItem[Unit_MCV]);
	fprintf(stdout,"Ornithopters: %d\t\tRocket Launchers: %d\n",numItem[Unit_Ornithopter],numItem[Unit_Launcher]);
}

void PlayerClass::addCredits(double newCredits)
{
	if (newCredits > 0.0) {
		credits += newCredits;
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


void PlayerClass::assignMapPlayerNum(int newMapPlayerNum)
{
	if ((newMapPlayerNum >=0) && (newMapPlayerNum < MAX_PLAYERS))
		mapPlayerNum = newMapPlayerNum;
	else
		mapPlayerNum = 0;
}

void PlayerClass::checkSelectionLists()
{
    RobustList<StructureClass*>::const_iterator iter;
    for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
		StructureClass* tempStructure = *iter;
        if(tempStructure->isABuilder() && (tempStructure->getOwner() == this)) {
			((BuilderClass*) tempStructure)->checkSelectionList();
        }
    }
}


void PlayerClass::incrementStructures(int itemID)
{
//	fprintf(stdout,"Adding new structure to Player %d: ItemID = %d\n",getPlayerNumber(),itemID);
	numStructures++;
	numItem[itemID]++;

    // change power requirements
	bool bhasPowerBefore = hasPower();
	int currentItemPower = currentGame->objectData.data[itemID].power;
	if(currentItemPower < 0) {
        power += abs(currentItemPower);
	} else {
        powerRequirement += currentGame->objectData.data[itemID].power;
	}
	bool bhasPowerAfterwards = hasPower();

    if(gameState != LOADING) {
        if(hasRadar() && (bhasPowerBefore != bhasPowerAfterwards)) {
            changeRadar(bhasPowerAfterwards);
        }
    } else {
        // loading => don't show radar animation
        if(hasRadar()) {
            currentGame->radarView->setRadarMode(bhasPowerAfterwards);
        }
    }

	// change spice capacity
	capacity += currentGame->objectData.data[itemID].capacity;

    if(gameState != LOADING) {
        // do not check selection lists if we are loading
        checkSelectionLists();
    }
}


void PlayerClass::decrementStructures(int itemID, const Coord& location)
{
	numStructures--;
    numItem[itemID]--;

	// change power requirements
	bool bhasPowerBefore = hasPower();
	int currentItemPower = currentGame->objectData.data[itemID].power;
	if(currentItemPower < 0) {
        power -= abs(currentItemPower);
	} else {
        powerRequirement -= currentGame->objectData.data[itemID].power;
	}
	bool bhasPowerAfterwards = hasPower();
	if(bhasPowerBefore != bhasPowerAfterwards) {
        changeRadar(bhasPowerAfterwards);
	}

    // change spice capacity
	capacity -= currentGame->objectData.data[itemID].capacity;

    if(gameState != LOADING) {
        // do not check selection lists if we are loading
        checkSelectionLists();
    }

	if (!isAlive())
		lose();

}


void PlayerClass::decrementHarvesters()
{
    numItem[Unit_Harvester]--;

    if (numItem[Unit_Harvester] <= 0) {
        numItem[Unit_Harvester] = 0;

        if(numItem[Structure_Refinery]) {
            Coord	closestPos;
            Coord	pos = Coord(0,0);
            double	closestDistance = INFINITY;
            StructureClass *closestRefinery = NULL;

            RobustList<StructureClass*>::const_iterator iter;
            for(iter = structureList.begin(); iter != structureList.end(); ++iter) {
                StructureClass* tempStructure = *iter;

                if((tempStructure->getItemID() == Structure_Refinery) && (tempStructure->getOwner() == this)) {
                    pos = tempStructure->getLocation();

                    Coord closestPoint = tempStructure->getClosestPoint(pos);
                    double refineryDistance = blockDistance(pos, closestPoint);
                    if(!closestRefinery || (refineryDistance < closestDistance)) {
                            closestDistance = refineryDistance;
                            closestRefinery = tempStructure;
                            closestPos = pos;
                    }
                }
            }

            if(closestRefinery && (gameState == BEGUN)) {
                freeHarvester(closestRefinery->getLocation().x, closestRefinery->getLocation().y);
            }
        }
    }
}

void PlayerClass::incrementUnits(int itemID)
{
    numUnits++;
    numItem[itemID]++;
}

void PlayerClass::decrementUnits(int itemID)
{
	numUnits--;

	if(itemID == Unit_Harvester) {
        decrementHarvesters();
	} else {
        numItem[itemID]--;
	}

	if (!isAlive())
		lose();

}


void PlayerClass::freeHarvester(int xPos, int yPos)
{
	if (currentGameMap->cellExists(xPos, yPos)
		&& currentGameMap->getCell(xPos, yPos)->hasAGroundObject()
		&& (currentGameMap->getCell(xPos, yPos)->getGroundObject()->getItemID() == Structure_Refinery))
	{
		RefineryClass* refinery = (RefineryClass*)currentGameMap->getCell(xPos, yPos)->getGroundObject();
		Coord closestPos = currentGameMap->findClosestEdgePoint(refinery->getLocation(), refinery->getStructureSize());

		Carryall* carryall = (Carryall*)createUnit(Unit_Carryall);
		HarvesterClass* harvester = (HarvesterClass*)createUnit(Unit_Harvester);
		carryall->setOwned(false);
		carryall->giveCargo(harvester);
		carryall->deploy(closestPos);
		carryall->setDropOfferer(true);

		if (closestPos.x == 0)
			carryall->setAngle(RIGHT);
		else if (closestPos.x == currentGameMap->sizeX-1)
			carryall->setAngle(LEFT);
		else if (closestPos.y == 0)
			carryall->setAngle(DOWN);
		else if (closestPos.y == currentGameMap->sizeY-1)
			carryall->setAngle(UP);

		harvester->setTarget(refinery);
		harvester->setActive(false);
		carryall->setTarget(refinery);
	}
}


void PlayerClass::lose()
{
	char message[100];
	sprintf(message, "Player %d has been defeated.", playerNumber);
	currentGame->AddToNewsTicker(message);

	if(this == thisPlayer) {
		currentGame->finished = true;
		currentGame->won = false;

		musicPlayer->changeMusic(MUSIC_LOSE);
		soundPlayer->playVoice(YouHaveFailedYourMission,house);

	} else if(currentGame->winFlags != 6) {
		//if the only players left are on the thisPlayers team, thisPlayer has won
		bool finished = true;

		for(int i=0; i<NUM_HOUSES; i++) {
			if ((currentGame->player[i] != NULL) && currentGame->player[i]->isAlive()
				&& (currentGame->player[i]->getTeam() != thisPlayer->getTeam()))
				finished = false;
		}

		if(finished) {
			currentGame->finished = true;

			/*always won can cause fault if next mission should load,
			but game was aborted*/

			currentGame->won = true;
			musicPlayer->changeMusic(MUSIC_WIN);
			soundPlayer->playVoice(YourMissionIsComplete,house);
		}
	}
}


void PlayerClass::noteDamageLocation(ObjectClass* pObject, const Coord& location)
{
	//if (this == thisPlayer)
	//	soundPlayer->playVOSound(Sound
}


void PlayerClass::returnCredits(double newCredits)
{
	if (newCredits > 0.0) {
		startingCredits += newCredits;
	}
}

void PlayerClass::setStartingCredits(double newCredits)
{
	if (newCredits >= 0.0)
		startingCredits = newCredits;
}

void PlayerClass::setStoredCredits(double newCredits)
{
	if (newCredits >= 0.0)
		credits = newCredits;
}

void PlayerClass::update()
{
	if (oldCredits != getAmountOfCredits())
	{
		if ((this == thisPlayer) && (getAmountOfCredits() > 0))
			soundPlayer->playSound(CreditsTick);
		oldCredits = getAmountOfCredits();
	}

	if (credits > capacity)
	{
		credits--;// = capacity;
		if (this == thisPlayer)
			currentGame->AddToNewsTicker("spice lost, build more silos.");
	}
}

void PlayerClass::win()
{
	currentGame->finished = true;

	if (getTeam() == thisPlayer->getTeam())
	{
		currentGame->won = true;

		musicPlayer->changeMusic(MUSIC_WIN);
		soundPlayer->playVoice(YourMissionIsComplete,house);
	}
	else
	{
		currentGame->won = false;

		musicPlayer->changeMusic(MUSIC_LOSE);
		soundPlayer->playVoice(YouHaveFailedYourMission,house);
	}
}

StructureClass* PlayerClass::placeStructure(Uint32 builderID, int itemID, int xPos, int yPos)
{
	if(!currentGameMap->cellExists(xPos,yPos)) {
		return NULL;
	}

	StructureClass* tempStructure = NULL;

	switch (itemID) {
		case (Structure_Slab1): {
			// Slabs are no normal buildings
			currentGameMap->getCell(xPos, yPos)->setType(Terrain_Slab1);
			currentGameMap->getCell(xPos, yPos)->setOwner(getPlayerNumber());
			currentGameMap->viewMap(getTeam(), xPos, yPos, currentGame->objectData.data[Structure_Slab1].viewrange);
	//		currentGameMap->getCell(xPos, yPos)->clearTerrain();
			ObjectClass* pObject = currentGame->getObjectManager().getObject(builderID);
			if (pObject != NULL) {
				if (pObject->isAStructure() && ((StructureClass*) pObject)->isABuilder()) {
					((BuilderClass*) pObject)->unSetWaitingToPlace();
					if (this == thisPlayer) {
						currentGame->placingMode = false;
					}
				}
			} else if (this == thisPlayer) {
				currentGame->placingMode = false;
			}
		} break;

		case (Structure_Slab4): {
			// Slabs are no normal buildings
			int i,j;
			for(i = xPos; i < xPos + 2; i++) {
				for(j = yPos; j < yPos + 2; j++) {
					if (currentGameMap->cellExists(i, j)) {
						TerrainClass* cell = currentGameMap->getCell(i, j);

						if (!cell->hasAGroundObject() && cell->isRock() && !cell->isMountain()) {
							cell->setType(Terrain_Slab1);
							cell->setOwner(getPlayerNumber());
							currentGameMap->viewMap(getTeam(), i, j, currentGame->objectData.data[Structure_Slab4].viewrange);
							//cell->clearTerrain();
						}
					}
				}
			}

			ObjectClass* pObject = currentGame->getObjectManager().getObject(builderID);
			if(pObject != NULL) {
				if (pObject->isAStructure() && ((StructureClass*) pObject)->isABuilder()) {
					((BuilderClass*) pObject)->unSetWaitingToPlace();

					if (this == thisPlayer) {
						currentGame->placingMode = false;
					}
				}
			} else if (this == thisPlayer) {
				currentGame->placingMode = false;
			}

		} break;

		default: {
			tempStructure = (StructureClass*) ObjectClass::createObject(itemID,this);
			if(tempStructure == NULL) {
				fprintf(stdout,"PlayerClass::placeStructure(): Cannot create Object with itemID %d\n",itemID);
				fflush(stdout);
				exit(EXIT_FAILURE);
			}

			for(int i=0;i<tempStructure->getStructureSizeX();i++) {
				for(int j=0;j<tempStructure->getStructureSizeY();j++) {
					if(currentGameMap->cellExists(xPos+i, yPos+j)) {
						currentGameMap->getCell(xPos+i, yPos+j)->clearTerrain();
					}
				}
			}

			tempStructure->setLocation(xPos, yPos);

			if (itemID == Structure_Wall) {
				fixWalls(xPos, yPos);
			} else {
				tempStructure->setJustPlaced();
			}

			// at the beginning of the game every refinery gets one harvester for free (brought by a carryall)
			if(itemID == Structure_Refinery) {
				freeHarvester(xPos, yPos);
			}

			// if this structure was built by a construction yard this construction yard must be informed
			ObjectClass* pObject = currentGame->getObjectManager().getObject(builderID);
			if(pObject != NULL) {
				if(pObject->isAStructure() && ((StructureClass*) pObject)->isABuilder()) {
					((BuilderClass*) pObject)->unSetWaitingToPlace();
					if (this == thisPlayer) {
						currentGame->placingMode = false;
					}
				}
			} else if (this == thisPlayer) {
				currentGame->placingMode = false;
			}

			if(itemID == Structure_Radar && hasPower()) {
                changeRadar(true);
			}

			if(tempStructure->isABuilder()) {
                ((BuilderClass*) tempStructure)->checkSelectionList();
			}


		} break;
	}

	return tempStructure;
}



UnitClass* PlayerClass::createUnit(int itemID)
{
	UnitClass* newUnit = NULL;

	newUnit = (UnitClass*) ObjectClass::createObject(itemID,this);

	if(newUnit == NULL) {
		fprintf(stdout,"PlayerClass::createUnit(): Cannot create Object with itemID %d\n",itemID);
		fflush(stdout);
		exit(EXIT_FAILURE);
	}

	return newUnit;
}

UnitClass* PlayerClass::placeUnit(int itemID, int xPos, int yPos)
{
	UnitClass* newUnit = NULL;
	if (currentGameMap->cellExists(xPos, yPos))
		newUnit = (UnitClass*)createUnit(itemID);

	if (newUnit)
	{
		Coord pos = Coord(xPos, yPos);
		if (newUnit->canPass(xPos, yPos))
			newUnit->deploy(pos);
		else
		{
			newUnit->setVisible(VIS_ALL, false);
			newUnit->destroy();
			newUnit = NULL;
		}
	}

	return newUnit;
}

int PlayerClass::getMapPlayerNum() const
{
	return mapPlayerNum;
}

double PlayerClass::takeCredits(double amount)
{
	double	taken = 0.0;

	if(getAmountOfCredits() >= 1) {
		if(credits >= amount) {
			taken = amount;
			credits -= amount;
		} else {
			taken = credits;
			credits = 0.0;

			if(startingCredits >= (amount - taken)) {
				startingCredits -= (amount - taken);
				taken = amount;
			} else {
				taken += startingCredits;
				startingCredits = 0.0;
			}
		}
	}

	return taken;	//the amount that was actually withdrawn
}

/**
    This method starts the animation for switching the radar on or off
    \param status   true if the radar is switched on, false if switched off
*/
void PlayerClass::changeRadar(bool status)
{
	if(this == thisPlayer) {
		soundPlayer->playSound(RadarNoise);

		if(status == true) {
			//turn on
			currentGame->radarView->switchRadarMode(true);
			soundPlayer->playVoice(RadarActivated,this->getHouse());
		} else {
			//turn off
			currentGame->radarView->switchRadarMode(false);
			soundPlayer->playVoice(RadarDeactivated,this->getHouse());
		}
	}
}
