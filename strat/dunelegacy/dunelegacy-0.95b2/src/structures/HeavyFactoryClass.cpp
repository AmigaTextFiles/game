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

#include <structures/HeavyFactoryClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>

HeavyFactoryClass::HeavyFactoryClass(PlayerClass* newOwner) : BuilderClass(newOwner)
{
    HeavyFactoryClass::init();

    health = getMaxHealth();
}

HeavyFactoryClass::HeavyFactoryClass(Stream& stream) : BuilderClass(stream)
{
    HeavyFactoryClass::init();
}

void HeavyFactoryClass::init()
{
   	itemID = Structure_HeavyFactory;
	owner->incrementStructures(itemID);

	structureSize.x = 3;
	structureSize.y = 2;

	GraphicID = ObjPic_HeavyFactory;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 8;
	imageH = graphic->h;
	FirstAnimFrame = 2;
	LastAnimFrame = 3;

	allowedToUpgrade = true;
	upgradeCost = 500;

	if(currentGame->techLevel >= 6) {
		upgradeLevels = 2;
	} else if (currentGame->techLevel >= 5) {
		upgradeLevels = 1;
	} else {
		upgradeLevels = 0;
	}
}

HeavyFactoryClass::~HeavyFactoryClass()
{
}

void HeavyFactoryClass::buildRandom() {
	if((AllowedToUpgrade() == true) && (CurrentUpgradeLevel() < MaxUpgradeLevel())
		&& (GetUpgradeCost() <= owner->getAmountOfCredits())) {
			DoUpgrade();
			return;
	}

	int Item2Produce = Unknown;

	do {
		int randNum = currentGame->RandomGen.rand(0, getNumSelections()-1);
		int i = 0;
		std::list<BuildItem>::iterator iter;
		for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
			if(i == randNum) {
				Item2Produce = iter->ItemID;
				break;
			}
		}
	} while((Item2Produce == Unit_Harvester) || (Item2Produce == Unit_MCV));

	DoProduceItem(Item2Produce);
}

void HeavyFactoryClass::checkSelectionList()
{
	BuilderClass::checkSelectionList();

	std::list<BuildItem>::iterator iter = BuildList.begin();

	switch(origHouse) {
		case(HOUSE_ATREIDES):
		case(HOUSE_FREMEN): {
			if(getOwner()->hasIX()) {
				InsertItem(BuildList, iter, Unit_SonicTank);
			} else {
				RemoveItem(BuildList, iter, Unit_SonicTank);
			}
		} break;

		case(HOUSE_ORDOS):
		case(HOUSE_MERCENARY): {
			if(getOwner()->hasIX()) {
				InsertItem(BuildList, iter, Unit_Deviator);
			} else {
				RemoveItem(BuildList, iter, Unit_Deviator);
			}
		} break;

		case(HOUSE_HARKONNEN):
		case(HOUSE_SARDAUKAR): {
			if(getOwner()->hasIX()) {
				InsertItem(BuildList, iter, Unit_Devastator);
			} else {
				RemoveItem(BuildList, iter, Unit_Devastator);
			}
		} break;

		default: {
		} break;
	}

	if(currentGame->techLevel >= 6 && curUpgradeLev >= 2) {
		InsertItem(BuildList, iter, Unit_SiegeTank);
	} else {
		RemoveItem(BuildList, iter, Unit_SiegeTank);
	}

	if(currentGame->techLevel >= 5 && curUpgradeLev >= 1 && (owner->getHouse() != HOUSE_ORDOS && owner->getHouse() != HOUSE_MERCENARY)) {
		InsertItem(BuildList, iter, Unit_Launcher);
	} else {
		RemoveItem(BuildList, iter, Unit_Launcher);
	}

	InsertItem(BuildList, iter, Unit_Tank);
	InsertItem(BuildList, iter, Unit_Harvester);
	InsertItem(BuildList, iter, Unit_MCV);
}

void HeavyFactoryClass::doSpecificStuff()
{
	buildUpdate();
}
