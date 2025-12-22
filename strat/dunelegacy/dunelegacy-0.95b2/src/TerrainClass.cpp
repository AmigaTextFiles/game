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

#include <TerrainClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>

#include <GameClass.h>
#include <MapClass.h>
#include <PlayerClass.h>
#include <SoundPlayer.h>
#include <MapGenerator.h>
#include <ScreenBorder.h>
#include <ConcatIterator.h>

#include <structures/StructureClass.h>
#include <units/InfantryClass.h>
#include <units/AirUnit.h>

TerrainClass::TerrainClass() {
	type = Terrain_Sand;
	tile = Terrain_a1;

	for(int i = 0; i < MAX_PLAYERS; i++) {
		explored[i] = false;
		/*fogged[i] = false;*/
		lastAccess[i] = -1;
	}

	hideTile = Terrain_HiddenFull;
	fogTile = Terrain_HiddenFull;
	fogColour = COLOUR_BLACK;

	owner = INVALID;
	sandRegion = NONE;

	difficulty = 1.0;
	spice = 0.0;

	sprite = pDataManager->getObjPic(ObjPic_Terrain);

	for(int i=0; i < NUM_ANGLES; i++) {
        tracksCounter[i] = 0;
	}

	location.x = 0;
	location.y = 0;
	visited = false;
	parent = NULL;
	previous = NULL;
	next = NULL;
}


TerrainClass::~TerrainClass() {
}

void TerrainClass::load(Stream& stream) {
	type = stream.readUint32();
	tile = stream.readUint32();

	for(int i=0;i<MAX_PLAYERS;i++) {
        explored[i] = stream.readBool();
	}

	hideTile = stream.readUint32();
	fogTile = stream.readUint32();
	fogColour = stream.readUint32();

	owner = stream.readSint32();
	sandRegion = stream.readUint32();

	difficulty = stream.readDouble();
	spice = stream.readDouble();

	Uint32 numDamage = stream.readUint32();
	for(Uint32 i=0; i<numDamage; i++) {
        DAMAGETYPE newDamage;
        newDamage.damageType = stream.readUint32();
        newDamage.tile = stream.readSint32();
        newDamage.realPos.x = stream.readSint32();
        newDamage.realPos.y = stream.readSint32();

        damage.push_back(newDamage);
	}

	Uint32 numDeadObjects = stream.readUint32();
	for(Uint32 i=0; i<numDeadObjects; i++) {
        DEADOBJECTTYPE newDeadObject;
        newDeadObject.type = stream.readUint8();
        newDeadObject.house = stream.readUint8();
        newDeadObject.onSand = stream.readBool();
        newDeadObject.realPos.x = stream.readSint32();
        newDeadObject.realPos.y = stream.readSint32();
        newDeadObject.timer = stream.readSint16();

        deadObject.push_back(newDeadObject);
	}

    for(int i=0; i < NUM_ANGLES; i++) {
        tracksCounter[i] = stream.readSint16();
    }

	assignedAirUnitList = stream.readUint32List();
	assignedInfantryList = stream.readUint32List();
	assignedUndergroundUnitList = stream.readUint32List();
	assignedNonInfantryGroundObjectList = stream.readUint32List();
}

void TerrainClass::save(Stream& stream) const {
	stream.writeUint32(type);
	stream.writeUint32(tile);

    for(int i=0;i<MAX_PLAYERS;i++) {
        stream.writeBool(explored[i]);
	}

	stream.writeUint32(hideTile);
	stream.writeUint32(fogTile);
	stream.writeUint32(fogColour);

	stream.writeUint32(owner);
	stream.writeUint32(sandRegion);

	stream.writeDouble(difficulty);
	stream.writeDouble(spice);

	stream.writeUint32(damage.size());
    for(std::vector<DAMAGETYPE>::const_iterator iter = damage.begin(); iter != damage.end(); ++iter) {
        stream.writeUint32(iter->damageType);
        stream.writeSint32(iter->tile);
        stream.writeSint32(iter->realPos.x);
        stream.writeSint32(iter->realPos.y);
    }

    stream.writeUint32(deadObject.size());
    for(std::vector<DEADOBJECTTYPE>::const_iterator iter = deadObject.begin(); iter != deadObject.end(); ++iter) {
        stream.writeUint8(iter->type);
        stream.writeUint8(iter->house);
        stream.writeBool(iter->onSand);
        stream.writeSint32(iter->realPos.x);
        stream.writeSint32(iter->realPos.y);
        stream.writeSint16(iter->timer);
    }

    for(int i=0; i < NUM_ANGLES; i++) {
        stream.writeSint16(tracksCounter[i]);
    }

	stream.writeUint32List(assignedAirUnitList);
	stream.writeUint32List(assignedInfantryList);
	stream.writeUint32List(assignedUndergroundUnitList);
	stream.writeUint32List(assignedNonInfantryGroundObjectList);
}

void TerrainClass::assignAirUnit(Uint32 newObjectID) {
	assignedAirUnitList.push_back(newObjectID);
}

void TerrainClass::assignNonInfantryGroundObject(Uint32 newObjectID) {
	assignedNonInfantryGroundObjectList.push_back(newObjectID);
}

int TerrainClass::assignInfantry(Uint32 newObjectID, Sint8 currentPosition) {
	Sint8 i = currentPosition;

	if(currentPosition == -1) {
		bool used[NUM_INFANTRY_PER_CELL];
		int pos;
		for (i = 0; i < NUM_INFANTRY_PER_CELL; i++)
			used[i] = false;


		std::list<Uint32>::const_iterator iter;
		for(iter = assignedInfantryList.begin(); iter != assignedInfantryList.end() ;++iter) {
			InfantryClass* infant = (InfantryClass*) currentGame->getObjectManager().getObject(*iter);
			if(infant == NULL) {
				continue;
			}

			pos = infant->getCellPosition();
			if ((pos >= 0) && (pos < NUM_INFANTRY_PER_CELL))
				used[pos] = true;
		}

		for (i = 0; i < NUM_INFANTRY_PER_CELL; i++) {
			if (used[i] == false) {
				break;
			}
		}

		if ((i < 0) || (i >= NUM_INFANTRY_PER_CELL))
			i = 0;
	}

	assignedInfantryList.push_back(newObjectID);
	return i;
}


void TerrainClass::assignUndergroundUnit(Uint32 newObjectID) {
	assignedUndergroundUnitList.push_back(newObjectID);
}

void TerrainClass::blitGround(int xPos, int yPos) {
	SDL_Rect	source = { tile*BLOCKSIZE, 0, BLOCKSIZE, BLOCKSIZE };
	SDL_Rect    drawLocation = { xPos, yPos, BLOCKSIZE, BLOCKSIZE };

	if (hasANonInfantryGroundObject() && getNonInfantryGroundObject()->isAStructure()) {
		//if got a structure, draw the structure, and dont draw any terrain because wont be seen
		bool	done = false;	//only draw it once
		StructureClass* structure = (StructureClass*) getNonInfantryGroundObject();

		for(int i = structure->getX(); (i < structure->getX() + structure->getStructureSizeX()) && !done;  i++) {
            for(int j = structure->getY(); (j < structure->getY() + structure->getStructureSizeY()) && !done;  j++) {
                if(screenborder->isTileInsideScreen(Coord(i,j))
                    && currentGameMap->cellExists(i, j) && (currentGameMap->getCell(i, j)->isExplored(thisPlayer->getPlayerNumber()) || debug))
                {

                    structure->setFogged(isFogged(thisPlayer->getPlayerNumber()));

                    if ((i == location.x) && (j == location.y)) {
                        //only this cell will draw it, so will be drawn only once
                        structure->blitToScreen();
                    }

                    done = true;
                }
            }
        }
	} else {
		//draw terrain
		SDL_BlitSurface(sprite, &source, screen, &drawLocation);

		if(!isFogged(thisPlayer->getPlayerNumber())) {
		    // tracks
		    for(int i=0;i<NUM_ANGLES;i++) {
                if(tracksCounter[i] > 0) {
                    source.x = ((10-i)%8)*BLOCKSIZE;
                    SDL_BlitSurface(pDataManager->getObjPic(ObjPic_Terrain_Tracks), &source, screen, &drawLocation);
                }
		    }

            // damage
		    for(std::vector<DAMAGETYPE>::const_iterator iter = damage.begin(); iter != damage.end(); ++iter) {
                source.x = iter->tile*BLOCKSIZE;
                drawLocation.x = screenborder->world2screenX(iter->realPos.x) - BLOCKSIZE/2;
                drawLocation.y = screenborder->world2screenY(iter->realPos.y) - BLOCKSIZE/2;
                if(iter->damageType == Terrain_RockDamage) {
                    SDL_BlitSurface(pDataManager->getObjPic(ObjPic_RockDamage), &source, screen, &drawLocation);
                } else {
                    SDL_BlitSurface(pDataManager->getObjPic(ObjPic_SandDamage), &source, screen, &drawLocation);
                }
		    }
		}
	}

}

void TerrainClass::blitUndergroundUnits(int xPos, int yPos) {
	if(hasAnUndergroundUnit() && !isFogged(thisPlayer->getPlayerNumber())) {
	    UnitClass* current = getUndergroundUnit();

	    if(current->isVisible(thisPlayer->getTeam())) {
		    if(location == current->getLocation()) {
                current->blitToScreen();
		    }
		}
	}
}

void TerrainClass::blitDeadObjects(int xPos, int yPos) {
	if(!isFogged(thisPlayer->getPlayerNumber())) {
	    for(std::vector<DEADOBJECTTYPE>::const_iterator iter = deadObject.begin(); iter != deadObject.end(); ++iter) {
	        SDL_Rect source = { 0, 0, BLOCKSIZE, BLOCKSIZE};
	        SDL_Surface* pSurface = NULL;
	        switch(iter->type) {
                case DeadObject_Infantry: {
                    pSurface = pDataManager->getObjPic(ObjPic_DeadInfantry, iter->house);
                    source.x = (iter->timer < 1000 && iter->onSand) ? BLOCKSIZE : 0;
                } break;

                case DeadObject_Infantry_Squashed1: {
                    pSurface = pDataManager->getObjPic(ObjPic_DeadInfantry, iter->house);
                    source.x = 4 * BLOCKSIZE;
                } break;

                case DeadObject_Infantry_Squashed2: {
                    pSurface = pDataManager->getObjPic(ObjPic_DeadInfantry, iter->house);
                    source.x = 5 * BLOCKSIZE;
                } break;

                case DeadObject_Carrall: {
                    pSurface = pDataManager->getObjPic(ObjPic_DeadAirUnit, iter->house);
                    if(iter->onSand) {
                        source.x = (iter->timer < 1000) ? 5*BLOCKSIZE : 4*BLOCKSIZE;
                    } else {
                        source.x = 3*BLOCKSIZE;
                    }
                } break;

                case DeadObject_Ornithopter: {
                    pSurface = pDataManager->getObjPic(ObjPic_DeadAirUnit, iter->house);
                    if(iter->onSand) {
                        source.x = (iter->timer < 1000) ? 2*BLOCKSIZE : BLOCKSIZE;
                    } else {
                        source.x = 0;
                    }
                } break;

                default: {
                    pSurface = NULL;
                } break;
	        }

	        if(pSurface != NULL) {
                SDL_Rect dest;
                dest.x = screenborder->world2screenX(iter->realPos.x) - BLOCKSIZE/2;
                dest.y = screenborder->world2screenY(iter->realPos.y) - BLOCKSIZE/2;
                dest.w = pSurface->w;
                dest.h = pSurface->h;
                SDL_BlitSurface(pSurface, &source, screen, &dest);
	        }
	    }
	}
}

void TerrainClass::blitInfantry(int xPos, int yPos) {
	if(hasInfantry() && !isFogged(thisPlayer->getPlayerNumber())) {
		std::list<Uint32>::const_iterator iter;
		for(iter = assignedInfantryList.begin(); iter != assignedInfantryList.end() ;++iter) {
			InfantryClass* current = (InfantryClass*) currentGame->getObjectManager().getObject(*iter);

			if(current == NULL) {
				continue;
			}

			if(current->isVisible(thisPlayer->getTeam())) {
			    if(location == current->getLocation()) {
                    current->blitToScreen();
			    }
			}
		}
	}
}

void TerrainClass::blitNonInfantryGroundUnits(int xPos, int yPos) {
	if(hasANonInfantryGroundObject() && !isFogged(thisPlayer->getPlayerNumber())) {
        std::list<Uint32>::const_iterator iter;
		for(iter = assignedNonInfantryGroundObjectList.begin(); iter != assignedNonInfantryGroundObjectList.end() ;++iter) {
			ObjectClass* current =  currentGame->getObjectManager().getObject(*iter);

            if(current->isAUnit() && current->isVisible(thisPlayer->getTeam())) {
                if(location == current->getLocation()) {
                    current->blitToScreen();
                }
            }
		}
	}
}


void TerrainClass::blitAirUnits(int xPos, int yPos) {
	if(hasAnAirUnit() && !isFogged(thisPlayer->getPlayerNumber())) {
		std::list<Uint32>::const_iterator iter;
		for(iter = assignedAirUnitList.begin(); iter != assignedAirUnitList.end() ;++iter) {
			AirUnit* airUnit = (AirUnit*) currentGame->getObjectManager().getObject(*iter);

			if(airUnit == NULL) {
				continue;
			}

			if(airUnit->isVisible(thisPlayer->getTeam())) {
			    if(location == airUnit->getLocation()) {
                    airUnit->blitToScreen();
			    }
			}
		}
	}
}

void TerrainClass::blitSelectionRects(int xPos, int yPos) {
    // draw underground selection rectangles
    if(hasAnUndergroundUnit() && !isFogged(thisPlayer->getPlayerNumber())) {
	    UnitClass* current = getUndergroundUnit();

	    if(current->isSelected() && current->isVisible(thisPlayer->getTeam())) {
		    if(location == current->getLocation()) {
                current->drawSelectionBox();
		    }
		}
	}


    // draw infantry selection rectangles
    if(hasInfantry() && !isFogged(thisPlayer->getPlayerNumber())) {
		std::list<Uint32>::const_iterator iter;
		for(iter = assignedInfantryList.begin(); iter != assignedInfantryList.end() ;++iter) {
			InfantryClass* current = (InfantryClass*) currentGame->getObjectManager().getObject(*iter);

			if(current == NULL) {
				continue;
			}

			if(current->isSelected() && current->isVisible(thisPlayer->getTeam())) {
			    if(location == current->getLocation()) {
                    current->drawSelectionBox();
			    }
			}
		}
	}

    // draw non infantry ground object selection rectangles
	if(hasANonInfantryGroundObject() && !isFogged(thisPlayer->getPlayerNumber())) {
	    std::list<Uint32>::const_iterator iter;
		for(iter = assignedNonInfantryGroundObjectList.begin(); iter != assignedNonInfantryGroundObjectList.end() ;++iter) {
            ObjectClass* current = currentGame->getObjectManager().getObject(*iter);

            if(current->isSelected() && current->isVisible(thisPlayer->getTeam())) {
                if(location == current->getLocation()) {
                    current->drawSelectionBox();
                }
            }
		}
	}

    // draw air unit selection rectangles
	if(hasAnAirUnit() && !isFogged(thisPlayer->getPlayerNumber())) {
		std::list<Uint32>::const_iterator iter;
		for(iter = assignedAirUnitList.begin(); iter != assignedAirUnitList.end() ;++iter) {
			AirUnit* airUnit = (AirUnit*) currentGame->getObjectManager().getObject(*iter);

			if(airUnit == NULL) {
				continue;
			}

			if(airUnit->isSelected() && airUnit->isVisible(thisPlayer->getTeam())) {
			    if(location == airUnit->getLocation()) {
                    airUnit->drawSelectionBox();
			    }
			}
		}
	}
}

void TerrainClass::update() {
    for(int i=0;i<NUM_ANGLES;i++) {
        if(tracksCounter[i] > 0) {
            tracksCounter[i]--;
        }
    }

    for(int i=0 ; i < (int)deadObject.size() ; i++) {
        if(deadObject[i].timer == 0) {
            deadObject.erase(deadObject.begin()+i);
            i--;
        } else {
            deadObject[i].timer--;
        }
    }
}

void TerrainClass::clearTerrain() {
    damage.clear();
    deadObject.clear();
}


void TerrainClass::damageCell(Uint32 damagerID, PlayerClass* damagerOwner, const Coord& realPos, int bulletType, int bulletDamage, int damageRadius, bool air) {
	TerrainClass* cell;

	if (bulletType == Bullet_Sandworm) {
		ConcatIterator<Uint32> iterator;
		iterator.addList(assignedInfantryList);
		iterator.addList(assignedNonInfantryGroundObjectList);

		ObjectClass* object;
		while(!iterator.IterationFinished()) {

			object = currentGame->getObjectManager().getObject(*iterator);
			if ((object->getX() == location.x) && (object->getY() == location.y)) {
				object->setVisible(VIS_ALL, false);
				object->handleDamage(bulletDamage, damagerID);
			}
			++iterator;
		}
	} else {
		int			distance;
		double		damageProp;

		if (air == true) {
			// air damage
			if (hasAnAirUnit() && ((bulletType == Bullet_DRocket) || (bulletType == Bullet_Rocket) || (bulletType == Bullet_SmallRocket)))
			{
				AirUnit*	airUnit;

				std::list<Uint32>::const_iterator iter;
				for(iter = assignedAirUnitList.begin(); iter != assignedAirUnitList.end() ;++iter) {
					airUnit = (AirUnit*) currentGame->getObjectManager().getObject(*iter);

					if(airUnit == NULL)
						continue;

					Coord centerPoint = airUnit->getCenterPoint();
					distance = lround(distance_from(centerPoint, realPos));
					if (distance <= 0) {
						distance = 1;
					}

					if ((distance - airUnit->getRadius()) <= damageRadius) {
						if ((bulletType == Bullet_DRocket) && (currentGame->RandomGen.rand(0, 100) <= 5)) {
							((UnitClass*)airUnit)->deviate(damagerOwner);
						}

						damageProp = ((double)(damageRadius + airUnit->getRadius() - distance))/((double)distance);
						if (damageProp > 0)	{
							if (damageProp > 1.0) {
								damageProp = 1.0;
							}
							airUnit->handleDamage(lround((double)bulletDamage * damageProp), damagerID);
						}
					}
				}
			}
		} else {
			// non air damage
			ConcatIterator<Uint32> iterator;
			iterator.addList(assignedNonInfantryGroundObjectList);
			iterator.addList(assignedInfantryList);
			iterator.addList(assignedUndergroundUnitList);

			ObjectClass* object;
			while(!iterator.IterationFinished()) {

				object = currentGame->getObjectManager().getObject(*iterator);

				Coord centerPoint = object->getClosestCenterPoint(location);
				distance = lround(distance_from(centerPoint, realPos));
				if (distance <= 0) {
					distance = 1;
				}

				if (distance - object->getRadius() <= damageRadius)	{
					if ((bulletType == Bullet_DRocket) && (object->isAUnit()) && (currentGame->RandomGen.rand(0, 100) <= 30)) {
						((UnitClass*)object)->deviate(damagerOwner);
					}

					damageProp = ((double)(damageRadius + object->getRadius() - distance))/(double)distance;
					if (damageProp > 0)	{
						if (damageProp > 1.0) {
							damageProp = 1.0;
						}

						object->handleDamage(lround((double) bulletDamage * damageProp), damagerID);
					}
				}

				++iterator;
			}

			if ((getType() == Terrain_Sand)
				&& ((getTile() == Terrain_a2) || (getTile() == Terrain_a3))) {
				//a spice bloom
				int i, j;
				setType(Terrain_Spice);
				soundPlayer->playSoundAt(Sound_Bloom, getLocation());
				for (i = -5; i <= 5; i++) {
					for (j = -5; j <= 5; j++) {
						if (currentGameMap->cellExists(location.x + i, location.y + j)
                            && !currentGameMap->getCell(location.x + i, location.y + j)->isBloom()
							&& (distance_from(location.x, location.y, location.x + i, location.y + j) <= 5))
						{
							cell = currentGameMap->getCell(location.x + i, location.y + j);
							if (cell->isSand())
								cell->setType(Terrain_Spice);
						}
					}
				}

				for(i = location.x-8; i <= location.x+8; i++)
					for(j = location.y-8; j <= location.y+8; j++)
						if (currentGameMap->cellExists(i, j))
							smooth_spot(i, j);
			}

			if (currentGameMap->cellExists(realPos.x/BLOCKSIZE, realPos.y/BLOCKSIZE))
			{
				cell = currentGameMap->getCell(realPos.x/BLOCKSIZE, realPos.y/BLOCKSIZE);
				if (((bulletType == Bullet_Rocket) || (bulletType == Bullet_SmallRocket) || (bulletType == Bullet_LargeRocket) || (bulletType == Unit_Devastator))
					&& (!hasAGroundObject() || !getGroundObject()->isAStructure())
					&& ((realPos.x <= (location.x*BLOCKSIZE + BLOCKSIZE/2))//if hasn't been assigned an object or the assigned object isnt a structure
						&& (realPos.y <= (location.y*BLOCKSIZE + BLOCKSIZE/2))))
				{
					if(!cell->hasAGroundObject() || !cell->getGroundObject()->isAStructure()) {
						if(((cell->getType() == Terrain_Rock) && (cell->getTile() == Terrain_t1))
							|| (cell->getType() == Terrain_Slab1))
						{
							if(cell->getType() == Terrain_Slab1) {
								cell->setType(Terrain_Rock);
								cell->setOwner(NONE);
							}

							if(damage.size() < DAMAGEPERCELL) {
                                DAMAGETYPE newDamage;
                                newDamage.tile = (bulletType==Bullet_SmallRocket) ? Terrain_td1 : Terrain_td2;
                                newDamage.damageType = Terrain_RockDamage;
                                newDamage.realPos.x = realPos.x;
                                newDamage.realPos.y = realPos.y;

                                damage.push_back(newDamage);
							}
						} else if((cell->getType() == Terrain_Sand) || (cell->getType() == Terrain_Spice)) {
							if(damage.size() < DAMAGEPERCELL) {
                                DAMAGETYPE newDamage;
                                newDamage.tile = (bulletType==Bullet_SmallRocket) ? currentGame->RandomGen.rand(Terrain_sd1, Terrain_sd2) : Terrain_sd3;
                                newDamage.damageType = Terrain_SandDamage;
                                newDamage.realPos.x = realPos.x;
                                newDamage.realPos.y = realPos.y;

                                damage.push_back(newDamage);
							}
						}
					}
				}
			}
		}
	}
}


void TerrainClass::selectAllPlayersUnits(int playerNum, ObjectClass** lastCheckedObject, ObjectClass** lastSelectedObject) {
	ConcatIterator<Uint32> iterator;
	iterator.addList(assignedInfantryList);
	iterator.addList(assignedNonInfantryGroundObjectList);
	iterator.addList(assignedUndergroundUnitList);
	iterator.addList(assignedAirUnitList);

	while(!iterator.IterationFinished()) {
		*lastCheckedObject = currentGame->getObjectManager().getObject(*iterator);
		if (((*lastCheckedObject)->getOwner()->getPlayerNumber() == playerNum)
			&& !(*lastCheckedObject)->isSelected()
			&& (*lastCheckedObject)->isAUnit()
			&& ((*lastCheckedObject)->getItemID() != Unit_Carryall)
			&& ((*lastCheckedObject)->getItemID() != Unit_Frigate))	{

			(*lastCheckedObject)->setSelected(true);
			currentGame->getSelectedList().insert((*lastCheckedObject)->getObjectID());
			*lastSelectedObject = *lastCheckedObject;
		}
		++iterator;
	}
}


void TerrainClass::selectAllPlayersUnitsOfType(int playerNum, int itemID, ObjectClass** lastCheckedObject, ObjectClass** lastSelectedObject) {
	ConcatIterator<Uint32> iterator;
	iterator.addList(assignedInfantryList);
	iterator.addList(assignedNonInfantryGroundObjectList);
	iterator.addList(assignedUndergroundUnitList);
	iterator.addList(assignedAirUnitList);

	while(!iterator.IterationFinished()) {
		*lastCheckedObject = currentGame->getObjectManager().getObject(*iterator);
		if (((*lastCheckedObject)->getOwner()->getPlayerNumber() == playerNum)
			&& !(*lastCheckedObject)->isSelected()
			&& ((*lastCheckedObject)->getItemID() == itemID)) {

			(*lastCheckedObject)->setSelected(true);
			currentGame->getSelectedList().insert((*lastCheckedObject)->getObjectID());
			*lastSelectedObject = *lastCheckedObject;
		}
		++iterator;
	}
}


void TerrainClass::unassignAirUnit(Uint32 ObjectID) {
	assignedAirUnitList.remove(ObjectID);
}


void TerrainClass::unassignNonInfantryGroundObject(Uint32 ObjectID) {
	assignedNonInfantryGroundObjectList.remove(ObjectID);
}

void TerrainClass::unassignUndergroundUnit(Uint32 ObjectID) {
	assignedUndergroundUnitList.remove(ObjectID);
}

void TerrainClass::unassignInfantry(Uint32 ObjectID, int currentPosition) {
	assignedInfantryList.remove(ObjectID);
}

void TerrainClass::unassignObject(Uint32 ObjectID) {
	unassignInfantry(ObjectID,-1);
	unassignUndergroundUnit(ObjectID);
	unassignNonInfantryGroundObject(ObjectID);
	unassignAirUnit(ObjectID);
}


void TerrainClass::setType(int newType) {
	type = newType;
	tile = 0;

	if (type == Terrain_Spice) {
		difficulty = 1.2;
		spice = currentGame->RandomGen.rand(RANDOMSPICEMIN, RANDOMSPICEMAX);
	} else if (type == Terrain_ThickSpice) {
		difficulty = 1.2;
		spice = currentGame->RandomGen.rand(RANDOMTHICKSPICEMIN, RANDOMTHICKSPICEMAX);
	} else if (type == Terrain_Dunes) {
		difficulty = 1.5;
	} else{
		difficulty = 1.2;
		spice = 0;
		if (isRock()) {
			difficulty = 1.0;
			sandRegion = NONE;
			if (hasAnUndergroundUnit())	{
				ObjectClass* current;
				std::list<Uint32>::const_iterator iter;
				iter = assignedUndergroundUnitList.begin();

				do {
					current = currentGame->getObjectManager().getObject(*iter);
					++iter;

					if(current == NULL)
						continue;

					unassignUndergroundUnit(current->getObjectID());
					current->destroy();
				} while(iter != assignedUndergroundUnitList.end());
			}
			if (type == Terrain_Slab1) {
				difficulty = 0.7;
				tile = Terrain_Slab;	//theres only the one image - the concrete block (BLOCKSIZE*BLOCKSIZE)
			} else if (type == Terrain_Mountain) {
				difficulty = 1.5;

				if(hasANonInfantryGroundObject()) {
					ObjectClass* current;
					std::list<Uint32>::const_iterator iter;
					iter = assignedNonInfantryGroundObjectList.begin();

					do {
						current = currentGame->getObjectManager().getObject(*iter);
						++iter;

						if(current == NULL)
							continue;

						unassignNonInfantryGroundObject(current->getObjectID());
						current->destroy();
					} while(iter != assignedNonInfantryGroundObjectList.end());
				}
			}
		}
	}

	clearTerrain();

	for (int i=location.x; i <= location.x+3; i++) {
		for (int j=location.y; j <= location.y+3; j++) {
			if (currentGameMap->cellExists(i, j)) {
				currentGameMap->getCell(i, j)->clearTerrain();
			}
		}
	}
}


void TerrainClass::squash() {
	if(hasInfantry()) {
		InfantryClass* current;
		std::list<Uint32>::const_iterator iter;
		iter = assignedInfantryList.begin();

		do {
			current = (InfantryClass*) currentGame->getObjectManager().getObject(*iter);
			++iter;

			if(current == NULL)
				continue;

			current->squash();
		} while(iter != assignedInfantryList.end());
	}
}


int TerrainClass::getInfantryTeam() {
	int team = NONE;
	if (hasInfantry())
		team = getInfantry()->getOwner()->getTeam();
	return team;
}


double TerrainClass::harvestSpice() {
	double oldSpice = spice;

	if ((spice - HARVESTSPEED) >= 0)
		spice -= HARVESTSPEED;
	else
		spice = 0;

	return (oldSpice - spice);
}


void TerrainClass::setSpice(double newSpice) {
	tile = 0;

	if(newSpice == 0) {
		type = Terrain_Sand;
	} else if(newSpice >= RANDOMTHICKSPICEMIN) {
		type = Terrain_ThickSpice;
	} else {
		type = Terrain_Spice;
	}
	spice = newSpice;
}


AirUnit* TerrainClass::getAirUnit() {
	return dynamic_cast<AirUnit*>(currentGame->getObjectManager().getObject(assignedAirUnitList.front()));
}

ObjectClass* TerrainClass::getGroundObject() {
	if (hasANonInfantryGroundObject())
		return getNonInfantryGroundObject();
	else if (hasInfantry())
		return getInfantry();
	else
		return NULL;
}

InfantryClass* TerrainClass::getInfantry() {
	return dynamic_cast<InfantryClass*>(currentGame->getObjectManager().getObject(assignedInfantryList.front()));
}

ObjectClass* TerrainClass::getNonInfantryGroundObject() {
	return currentGame->getObjectManager().getObject(assignedNonInfantryGroundObjectList.front());
}

UnitClass* TerrainClass::getUndergroundUnit() {
	return dynamic_cast<UnitClass*>(currentGame->getObjectManager().getObject(assignedUndergroundUnitList.front()));
}


/*ObjectClass* TerrainClass::getInfantry(int i)
{
	int count;
	InfantryClass* infantry;
	assignedInfantry.reset();
	while (assignedInfantry.currentNotNull())
	{
		((InfantryClass*)assignedInfantry.getCurrent())->squash();
		assignedInfantry.nextLink();
	}
	return assignedInfantry.removeElement();
}*/


ObjectClass* TerrainClass::getObject() {
	ObjectClass* temp = NULL;
	if (hasAnAirUnit())
		temp = getAirUnit();
	else if (hasANonInfantryGroundObject())
		temp = getNonInfantryGroundObject();
	else if (hasInfantry())
		temp = getInfantry();
	else if (hasAnUndergroundUnit())
		temp = getUndergroundUnit();
	return temp;
}


ObjectClass* TerrainClass::getObjectAt(int x, int y) {
	ObjectClass* temp = NULL;
	if (hasAnAirUnit())
		temp = getAirUnit();
	else if (hasANonInfantryGroundObject())
		temp = getNonInfantryGroundObject();
	else if (hasInfantry())	{
		double closestDistance = NONE;
		Coord atPos, centerPoint;
		InfantryClass* infantry;
		atPos.x = x;
		atPos.y = y;

		std::list<Uint32>::const_iterator iter;
		for(iter = assignedInfantryList.begin(); iter != assignedInfantryList.end() ;++iter) {
			infantry = (InfantryClass*) currentGame->getObjectManager().getObject(*iter);
			if(infantry == NULL)
				continue;

			centerPoint = infantry->getCenterPoint();
			if ((closestDistance == NONE) || (distance_from(atPos, centerPoint) < closestDistance)) {
				closestDistance = distance_from(atPos, centerPoint);
				temp = infantry;
			}
		}
	}
	else if (hasAnUndergroundUnit())
		temp = getUndergroundUnit();

	return temp;
}


ObjectClass* TerrainClass::getObjectWithID(Uint32 objectID) {
	ConcatIterator<Uint32> iterator;
	iterator.addList(assignedInfantryList);
	iterator.addList(assignedNonInfantryGroundObjectList);
	iterator.addList(assignedUndergroundUnitList);
	iterator.addList(assignedAirUnitList);

	while(!iterator.IterationFinished()) {
		if(*iterator == objectID) {
			return currentGame->getObjectManager().getObject(*iterator);
		}
		++iterator;
	}

	return NULL;
}

/*
ObjectClass* TerrainClass::selectAll()
{
}*/

bool TerrainClass::isFogged(int player) {
#ifdef	_DEBUG
		if(debug)
		return false;
#endif
	if(!fog_wanted)
		return false;
	else

	if((int)((clock() - lastAccess[player])/CLOCKS_PER_SEC) >= FOGTIMEOUT) {
		return true;
	} else {
		return false;
	}
}

Uint32 TerrainClass::getRadarColour(int player, bool radar) {
	int colour;

	if (isExplored(player) || debug || (!shade) ) {
		if(isFogged(player) && radar) {
			return fogColour;
		} else {
			ObjectClass* tempObject = NULL;
			if (hasAnObject()) {
				tempObject = getObject();
			}

			if(tempObject != NULL) {
				switch (tempObject->getOwner()->getColour()) {
					case(HOUSE_ATREIDES): colour = COLOUR_ATREIDES; break;
					case(HOUSE_ORDOS): colour = COLOUR_ORDOS; break;
					case(HOUSE_HARKONNEN): colour = COLOUR_HARKONNEN; break;
					case(HOUSE_SARDAUKAR): colour = COLOUR_SARDAUKAR; break;
					case(HOUSE_FREMEN): colour = COLOUR_FREMEN; break;
					case(HOUSE_MERCENARY): colour = COLOUR_MERCENARY; break;
					default: colour = COLOUR_BLACK; break;
				}

				if (tempObject->getItemID() == Unit_Sandworm)
					colour = COLOUR_WHITE;

				/*units are not visible if no radar*/
				if(!radar && (tempObject->getOwner()->getPlayerNumber() != player))
					colour = COLOUR_BLACK;
			} else {
				if(!radar && !debug)
					return COLOUR_BLACK;

				switch (getType()) {
					case Terrain_Dunes:
						colour = COLOUR_DESERTSAND;
						break;
					case Terrain_Mountain:
						colour = COLOUR_MOUNTAIN;
						break;
					case Terrain_Rock:
						colour = COLOUR_DARKGREY;
						break;
					case Terrain_Sand:
						colour = COLOUR_DESERTSAND;
						break;
					case Terrain_Spice:
						colour = COLOUR_SPICE;
						break;
					case Terrain_ThickSpice:
						colour = COLOUR_THICKSPICE;
						break;
                    case Terrain_Slab1:
					default:
						colour = COLOUR_DARKGREY;
				};
			}
			fogColour = colour;
		}
	} else {
		colour = COLOUR_BLACK;
	}
	return colour;
}
