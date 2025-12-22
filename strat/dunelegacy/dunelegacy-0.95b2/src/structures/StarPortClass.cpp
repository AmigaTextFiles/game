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

#include <structures/StarPortClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>
#include <MapClass.h>
#include <SoundPlayer.h>

#include <units/Frigate.h>

#define STARPORT_ARRIVETIME			4000
#define STARPORT_CHANGE_PRICETIME	5000

StarPortClass::StarPortClass(PlayerClass* newOwner) : BuilderClass(newOwner)
{
    StarPortClass::init();

    health = getMaxHealth();

    arrivalTimer = 0;
    modifierTimer = STARPORT_CHANGE_PRICETIME;
}

StarPortClass::StarPortClass(Stream& stream) : BuilderClass(stream)
{
    StarPortClass::init();

    arrivalTimer = stream.readSint32();
	modifierTimer = stream.readSint32();
}
void StarPortClass::init()
{
	itemID = Structure_StarPort;
	owner->incrementStructures(itemID);

	structureSize.x = 3;
	structureSize.y = 3;

	GraphicID = ObjPic_Starport;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 10;
	imageH = graphic->h;
	FirstAnimFrame = 2;
	LastAnimFrame = 3;
}

StarPortClass::~StarPortClass()
{
	;
}

void StarPortClass::save(Stream& stream) const
{
	BuilderClass::save(stream);
	stream.writeSint32(arrivalTimer);
	stream.writeSint32(modifierTimer);
}

void StarPortClass::buildRandom()
{
	int Item2Produce = Unknown;

	do {
		int randNum = currentGame->RandomGen.rand(0, getNumSelections()-1);
		int i = 0;
		std::list<BuildItem>::iterator iter;
		for(iter = BuildList.begin(); iter != BuildList.end(); ++iter,i++) {
			if(i == randNum) {
				Item2Produce = iter->ItemID;
				break;
			}
		}
	} while((Item2Produce == Unit_Harvester) || (Item2Produce == Unit_MCV) || (Item2Produce == Unit_Carryall));

	DoProduceItem(Item2Produce);
}

void StarPortClass::HandlePlaceOrderClick() {
	currentGame->GetCommandManager().addCommand(Command(CMD_STARPORT_PLACEORDER, objectID));
}

void StarPortClass::HandleCancelOrderClick() {
	currentGame->GetCommandManager().addCommand(Command(CMD_STARPORT_CANCELORDER, objectID));
}

void StarPortClass::DoProduceItem(Uint32 ItemID, bool multipleMode) {

	std::list<BuildItem>::iterator iter;
	for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
		if(iter->ItemID == ItemID) {
			for(int i = 0; i < (multipleMode ? 5 : 1); i++) {
				if(owner->getAmountOfCredits() >= (int) iter->price) {
					iter->num++;
					CurrentProductionList.push_back(ItemID);
					owner->takeCredits(iter->price);
				}
			}
			break;
		}
	}
}

void StarPortClass::DoCancelItem(Uint32 ItemID, bool multipleMode) {
	std::list<BuildItem>::iterator iter;
	for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
		if(iter->ItemID == ItemID) {
			for(int i = 0; i < (multipleMode ? 5 : 1); i++) {
				if(iter->num > 0) {
					iter->num--;

					std::list<Uint32>::iterator iter2;
					for(iter2 = CurrentProductionList.begin(); iter2 != CurrentProductionList.end(); iter2++) {
						if(*iter2 == ItemID) {
							owner->addCredits(iter->price);
							CurrentProductionList.erase(iter2);
							break;
						}
					}
				}
			}
			break;
		}
	}
}

void StarPortClass::DoPlaceOrder() {

	if (CurrentProductionList.size() > 0) {

		arrivalTimer = STARPORT_ARRIVETIME;

		FirstAnimFrame = 2;
		LastAnimFrame = 7;
	}
}

void StarPortClass::DoCancelOrder() {
	if (arrivalTimer == 0) {
		CurrentProductionList.clear();
		std::list<BuildItem>::iterator iter;
		for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
			owner->addCredits(iter->num * iter->price);
			iter->num = 0;
		}

		CurrentProducedItem = Unknown;
		arrivalTimer = 0;
	}
}


void StarPortClass::checkSelectionList()
{
	BuilderClass::checkSelectionList();

	std::list<BuildItem>::iterator iter = BuildList.begin();

	if(currentGame->techLevel >= 7) {
		InsertItem(BuildList, iter, Unit_SiegeTank);
	} else {
		RemoveItem(BuildList, iter, Unit_SiegeTank);
	}

	InsertItem(BuildList, iter, Unit_Launcher);
	InsertItem(BuildList, iter, Unit_Tank);
	InsertItem(BuildList, iter, Unit_Quad);

	if(owner->getHouse() == HOUSE_ORDOS) {
		InsertItem(BuildList, iter, Unit_Raider);
	} else {
		InsertItem(BuildList, iter, Unit_Trike);
	}

	InsertItem(BuildList, iter, Unit_Carryall);

	if(owner->getHouse() != HOUSE_HARKONNEN || owner->getHouse() != HOUSE_SARDAUKAR) {
		InsertItem(BuildList, iter, Unit_Ornithopter);
	}

	InsertItem(BuildList, iter, Unit_Harvester);
	InsertItem(BuildList, iter, Unit_MCV);
}

void StarPortClass::doSpecificStuff()
{
	if(modifierTimer > 0) {
		if(--modifierTimer == 0) {
			char temp[50];

			checkSelectionList();
			sprintf(temp, "New Starport prices");
			currentGame->AddToNewsTicker(temp);

			modifierTimer = STARPORT_CHANGE_PRICETIME;
		}
	}

	if (arrivalTimer > 0) {
		int region = arrivalTimer/(STARPORT_ARRIVETIME/10);

		if (--arrivalTimer == 0) {
			Frigate*		frigate;
			UnitClass*		unit;
			Coord		pos;

			//make a frigate with all the cargo
			frigate = (Frigate*)owner->createUnit(Unit_Frigate);
			pos = currentGameMap->findClosestEdgePoint(getLocation(), getStructureSize());
			frigate->deploy(pos);
			frigate->setTarget(this);
			Coord closestPoint = getClosestPoint(frigate->getLocation());
			frigate->setDestination(closestPoint);

			if (pos.x == 0)
				frigate->setAngle(RIGHT);
			else if (pos.x == currentGameMap->sizeX-1)
				frigate->setAngle(LEFT);
			else if (pos.y == 0)
				frigate->setAngle(DOWN);
			else if (pos.y == currentGameMap->sizeY-1)
				frigate->setAngle(UP);

			std::list<Uint32>::iterator iter;
			for(iter = CurrentProductionList.begin(); iter != CurrentProductionList.end(); ++iter) {
				unit = (UnitClass*)owner->createUnit(*iter);
				if(unit != NULL) {
					unit->setPickedUp(frigate);
					frigate->giveCargo(unit);
				}
			}


			CurrentProductionList.clear();
			std::list<BuildItem>::iterator iter2;
			for(iter2 = BuildList.begin(); iter2 != BuildList.end(); iter2++) {
				iter2->num = 0;
			}

			CurrentProducedItem = Unknown;

			if (getOwner() == thisPlayer)
			{
				soundPlayer->playVoice(FrigateHasArrived,getOwner()->getHouse());
				currentGame->AddToNewsTicker("Frigate has arrived");
			}

			//Stop it from animating
			FirstAnimFrame = 2;
			LastAnimFrame = 3;
		}
		else
		{
			if ((getOwner() == thisPlayer) && (arrivalTimer/(STARPORT_ARRIVETIME/10) != region))
			{
				char temp[50];

				sprintf(temp, "Frigate arrival in t - %d", region);
				currentGame->AddUrgentMessageToNewsTicker(temp);
			}
		}
	}
}

void StarPortClass::setArrivalTimer(int newArrivalTimer) {
	if (newArrivalTimer >= 0)
	{
		arrivalTimer = newArrivalTimer;
	}
}

void StarPortClass::InsertItem(std::list<BuildItem>& List, std::list<BuildItem>::iterator& iter, Uint32 itemID, int price)
{
    if(price == -1) {
        price = currentGame->objectData.data[itemID].price;
    }

    const int min_mod = 4;
    const int max_mod = 15;

    price = std::min(currentGame->RandomGen.rand(min_mod, max_mod)*(price/10), 999);

    BuilderClass::InsertItem(List, iter, itemID, price);

}


