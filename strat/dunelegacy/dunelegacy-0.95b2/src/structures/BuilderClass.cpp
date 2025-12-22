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

#include <structures/BuilderClass.h>

#include <globals.h>

#include <ObjectInterfaces.h>
#include <SoundPlayer.h>
#include <MapClass.h>


BuilderClass::BuilderClass(PlayerClass* newOwner) : StructureClass(newOwner) {
    BuilderClass::init();

	curUpgradeLev = 0;
	upgradeProgress = 0;
	upgrading = false;

	CurrentProducedItem = ItemID_Invalid;
	CurrentItemOnHold = false;
	ProductionProgress = 0;
}

BuilderClass::BuilderClass(Stream& stream) : StructureClass(stream) {
    BuilderClass::init();

	upgrading = stream.readBool();
	upgradeProgress = stream.readDouble();
    curUpgradeLev = stream.readUint8();

	CurrentItemOnHold = stream.readBool();
	CurrentProducedItem = stream.readUint32();
	ProductionProgress = stream.readDouble();

	CurrentProductionList = stream.readUint32List();

	int num = stream.readUint32();
	for(int i=0;i<num;i++) {
		BuildItem tmp;
		tmp.load(stream);
		BuildList.push_back(tmp);
	}
}

void BuilderClass::init() {
    aBuilder = true;

    allowedToUpgrade = false;
    upgradeCost = 0;
    upgradeLevels = 0;
}

BuilderClass::~BuilderClass() {
}


void BuilderClass::save(Stream& stream) const {
	StructureClass::save(stream);

    stream.writeBool(upgrading);
    stream.writeDouble(upgradeProgress);
	stream.writeUint8(curUpgradeLev);

	stream.writeBool(CurrentItemOnHold);
	stream.writeUint32(CurrentProducedItem);
	stream.writeDouble(ProductionProgress);

	stream.writeUint32List(CurrentProductionList);

	stream.writeUint32(BuildList.size());
	std::list<BuildItem>::const_iterator iter;
	for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
		iter->save(stream);
	}
}

ObjectInterface* BuilderClass::GetInterfaceContainer() {
	if((thisPlayer == owner) || (debug == true)) {
		return BuilderInterface::Create(objectID);
	} else {
		return DefaultObjectInterface::Create(objectID);
	}
}

void BuilderClass::InsertItem(std::list<BuildItem>& List, std::list<BuildItem>::iterator& iter, Uint32 itemID, int price) {
	if(iter != List.end()) {
		if(iter->ItemID == itemID) {
			if(price != -1) {
				iter->price = price;
			}
			++iter;
			return;
		}
	}

	if(price == -1) {
        price = currentGame->objectData.data[itemID].price;
	}

	BuildItem newItem;

	switch(itemID) {
		case (Structure_Barracks):			newItem = BuildItem(itemID,price,"Barracks"); break;
		case (Structure_ConstructionYard):	newItem = BuildItem(itemID,price,"Construction Yard"); break;
		case (Structure_GunTurret):			newItem = BuildItem(itemID,price,"Gun Turret"); break;
		case (Structure_HeavyFactory):		newItem = BuildItem(itemID,price,"Heavy Factory"); break;
		case (Structure_HighTechFactory):	newItem = BuildItem(itemID,price,"High Tech Factory"); break;
		case (Structure_IX):				newItem = BuildItem(itemID,price,"House of IX"); break;
		case (Structure_LightFactory):		newItem = BuildItem(itemID,price,"Light Factory"); break;
		case (Structure_Palace):			newItem = BuildItem(itemID,price,"Palace"); break;
		case (Structure_Radar):				newItem = BuildItem(itemID,price,"Radar");	break;
		case (Structure_Refinery):			newItem = BuildItem(itemID,price,"Refinery"); break;
		case (Structure_RepairYard):		newItem = BuildItem(itemID,price,"Repair Yard"); break;
		case (Structure_RocketTurret):		newItem = BuildItem(itemID,price,"Rocket Turret");	break;
		case (Structure_Silo):				newItem = BuildItem(itemID,price,"Silo"); break;
		case (Structure_StarPort):			newItem = BuildItem(itemID,price,"Star Port");	break;
		case (Structure_Slab1):				newItem = BuildItem(itemID,price,"Concrete Slab"); break;
		case (Structure_Slab4):				newItem = BuildItem(itemID,price,"Concrete Slab"); break;
		case (Structure_Wall):				newItem = BuildItem(itemID,price,"Wall"); break;
		case (Structure_WindTrap):			newItem = BuildItem(itemID,price,"Wind Trap");	break;
		case (Structure_WOR):				newItem = BuildItem(itemID,price,"WOR"); break;

		case (Unit_Carryall):				newItem = BuildItem(itemID,price,"Carryall"); break;
		case (Unit_Devastator):				newItem = BuildItem(itemID,price,"Devastator"); break;
		case (Unit_Harvester):				newItem = BuildItem(itemID,price,"Harvester"); break;
		case (Unit_Soldier):				newItem = BuildItem(itemID,price,"Light Infantry"); break;
		case (Unit_Launcher):				newItem = BuildItem(itemID,price,"Rocket Launcher"); break;
		case (Unit_MCV):					newItem = BuildItem(itemID,price,"MCV"); break;
		case (Unit_Ornithopter):			newItem = BuildItem(itemID,price,"Ornithopter"); break;
		case (Unit_Quad):					newItem = BuildItem(itemID,price,"Quad"); break;
		case (Unit_SiegeTank):				newItem = BuildItem(itemID,price,"Siege Tank"); break;
		case (Unit_SonicTank):				newItem = BuildItem(itemID,price,"Sonic Tank"); break;
		case (Unit_Tank):					newItem = BuildItem(itemID,price,"Combat Tank"); break;
		case (Unit_Trike):					newItem = BuildItem(itemID,price,"Trike"); break;
		case (Unit_Raider):					newItem = BuildItem(itemID,price,"Ordos Raider"); break;
		case (Unit_Trooper):				newItem = BuildItem(itemID,price,"Rocket Trooper"); break;
		case (Unit_Fremen):					newItem = BuildItem(itemID,price,"Fremen Trooper"); break;
		case (Unit_Sardaukar):				newItem = BuildItem(itemID,price,"Sardaukar Trooper"); break;
		default:
			break;
	}

	List.insert(iter,newItem);
}

void BuilderClass::RemoveItem(std::list<BuildItem>& List, std::list<BuildItem>::iterator& iter, Uint32 itemID) {
	if(iter != List.end()) {
		if(iter->ItemID == itemID) {
			std::list<BuildItem>::iterator iter2 = iter;
			++iter;
			List.erase(iter2);

            // is this item currently produced?
            if(CurrentProducedItem == itemID) {
                owner->returnCredits(ProductionProgress);
                ProductionProgress = 0.0;
                CurrentProducedItem = ItemID_Invalid;
            }
            CurrentProductionList.remove(itemID);
            ProduceNextAvailableItem();
		}
	}
}


void BuilderClass::setOwner(PlayerClass *no) {
	this->owner = no;
}

bool BuilderClass::IsWaitingToPlace() {
	if(CurrentProducedItem == ItemID_Invalid) {
		return false;
	}

	BuildItem* tmp = GetBuildItem(CurrentProducedItem);
	if(tmp == NULL) {
		return false;
	} else {
		return (ProductionProgress >= tmp->price);
	}
}


void BuilderClass::buildUpdate() {
	if((CurrentProducedItem != ItemID_Invalid) && !IsOnHold()
		&& !IsWaitingToPlace() && (owner->getAmountOfCredits() > 0)) {

		double oldProgress = ProductionProgress;
		if (getOwner()->hasPower() || (((currentGame->gameType == ORIGINAL) || (currentGame->gameType == SKIRMISH)) && getOwner()->isAI())) {
			//if not enough power, production is halved
			ProductionProgress += owner->takeCredits(0.25);
		} else {
			ProductionProgress += owner->takeCredits(0.125);
		}

		if ((oldProgress == ProductionProgress) && (owner == thisPlayer)) {
			currentGame->AddToNewsTicker("not enough credits");
		}

		if(IsWaitingToPlace() == true) {
			setWaitingToPlace();
		}
	}
}

void BuilderClass::buildRandom() {
	int randNum = currentGame->RandomGen.rand(0, getNumSelections()-1);
	int i = 0;
	std::list<BuildItem>::iterator iter;
	for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
		if(i == randNum) {
			DoProduceItem(iter->ItemID);
			break;
		}
	}
}

void BuilderClass::ProduceNextAvailableItem() {
	if(CurrentProductionList.empty() == true) {
		CurrentProducedItem = ItemID_Invalid;
	} else {
		CurrentProducedItem = CurrentProductionList.front();
	}

	ProductionProgress = 0.0;
	CurrentItemOnHold = false;
}


void BuilderClass::setWaitingToPlace() {
	if (CurrentProducedItem != ItemID_Invalid)	{
		if (owner == thisPlayer) {
			soundPlayer->playVoice(ConstructionComplete,getOwner()->getHouse());
		}

		if (isUnit(CurrentProducedItem)) {
			//if its a unit
			int FinishedItemID = CurrentProducedItem;
			ProductionProgress = 0.0;
			DoCancelItem(CurrentProducedItem);

			UnitClass* newUnit = (UnitClass*)(getOwner()->createUnit(FinishedItemID));

			if (newUnit != NULL) {
				Coord spot = currentGameMap->findDeploySpot(&location, &destination, &structureSize, newUnit);
				newUnit->deploy(spot);

				if (getOwner()->isAI()
					&& (newUnit->getItemID() != Unit_Carryall)
					&& (newUnit->getItemID() != Unit_Harvester)
					&& (newUnit->getItemID() != Unit_MCV)) {
					newUnit->DoSetAttackMode(AGGRESSIVE);
				}

				if (destination.x != INVALID_POS) {
					newUnit->setGuardPoint(destination);
					newUnit->setDestination(destination);
					newUnit->setAngle(lround(8.0/256.0*dest_angle(newUnit->getLocation(), newUnit->getDestination())));
				}
			}
		} else {
			//its a structure
			if (owner == thisPlayer)
				currentGame->AddToNewsTicker("Structure is ready to place.");
		}
	}
}

void BuilderClass::unSetWaitingToPlace() {
	ProductionProgress = 0.0;
	DoCancelItem(CurrentProducedItem);
}

bool BuilderClass::update() {
	if(StructureClass::update() == false) {
        return false;
	}

	if(upgrading == true) {
		upgradeProgress += owner->takeCredits(2.0);

		if(upgradeProgress >= upgradeCost) {
			upgrading = false;
			curUpgradeLev++;
			this->checkSelectionList();

			upgradeProgress = 0;
		}
	} else {
		buildUpdate();
	}

	return true;
}

void BuilderClass::HandleUpgradeClick() {
	currentGame->GetCommandManager().addCommand(Command(CMD_BUILDER_UPGRADE, objectID));
}

void BuilderClass::HandleProduceItemClick(Uint32 ItemID, bool multipleMode) {
	currentGame->GetCommandManager().addCommand(Command(CMD_BUILDER_PRODUCEITEM, objectID, ItemID, (Uint32) multipleMode));
}

void BuilderClass::HandleCancelItemClick(Uint32 ItemID, bool multipleMode) {
	currentGame->GetCommandManager().addCommand(Command(CMD_BUILDER_CANCELITEM, objectID, ItemID, (Uint32) multipleMode));
}

void BuilderClass::HandleSetOnHoldClick(bool OnHold) {
	currentGame->GetCommandManager().addCommand(Command(CMD_BUILDER_SETONHOLD, objectID, (Uint32) OnHold));
}


void BuilderClass::DoUpgrade() {
	if(owner->getAmountOfCredits() >= upgradeCost) {
		upgrading = true;
		upgradeProgress = 0;
	}
}

void BuilderClass::DoProduceItem(Uint32 ItemID, bool multipleMode) {
	std::list<BuildItem>::iterator iter;
	for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
		if(iter->ItemID == ItemID) {
			for(int i = 0; i < (multipleMode ? 5 : 1); i++) {
				iter->num++;
				CurrentProductionList.push_back(ItemID);
				if(CurrentProducedItem == ItemID_Invalid) {
					ProductionProgress = 0;
					CurrentProducedItem = ItemID;
				}
			}
			break;
		}
	}
}

void BuilderClass::DoCancelItem(Uint32 ItemID, bool multipleMode) {
	bool cancelCurrentItem = false;
	if(ItemID == CurrentProducedItem) {
		cancelCurrentItem = true;
	}

	std::list<BuildItem>::iterator iter;
	for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
		if(iter->ItemID == ItemID) {
			for(int i = 0; i < (multipleMode ? 5 : 1); i++) {
				if(iter->num > 0) {
					iter->num--;

					std::list<Uint32>::iterator iter2;
					for(iter2 = CurrentProductionList.begin(); iter2 != CurrentProductionList.end(); iter2++) {
						if(*iter2 == ItemID) {
							owner->returnCredits(ProductionProgress);
							CurrentProductionList.erase(iter2);

							break;
						}
					}

					if(cancelCurrentItem == true) {
						ProduceNextAvailableItem();
					}
				}
			}
			break;
		}
	}
}


