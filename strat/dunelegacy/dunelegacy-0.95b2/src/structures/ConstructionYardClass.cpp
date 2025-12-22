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

#include <structures/ConstructionYardClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>

ConstructionYardClass::ConstructionYardClass(PlayerClass* newOwner) : BuilderClass(newOwner)
{
    ConstructionYardClass::init();

    health = getMaxHealth();
}

ConstructionYardClass::ConstructionYardClass(Stream& stream) : BuilderClass(stream)
{
    ConstructionYardClass::init();
}

void ConstructionYardClass::init()
{
    itemID = Structure_ConstructionYard;
	owner->incrementStructures(itemID);

	structureSize.x = 2;
	structureSize.y = 2;

	GraphicID = ObjPic_ConstructionYard;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 4;
	imageH = graphic->h;

	FirstAnimFrame = 2;
	LastAnimFrame = 3;

	allowedToUpgrade = true;
	upgradeCost = 500;

	if(currentGame->techLevel >= 6) {
        upgradeLevels = 2;
	} else if(currentGame->techLevel >= 4) {
        upgradeLevels = 1;
	} else {
        upgradeLevels = 0;
	}
}

ConstructionYardClass::~ConstructionYardClass()
{
}

void ConstructionYardClass::checkSelectionList()
{
	//needed so selection list will have things in the right order when changed
	BuilderClass::checkSelectionList();

	std::list<BuildItem>::iterator iter = BuildList.begin();

	InsertItem(BuildList, iter, Structure_Slab1);

	if((currentGame->techLevel >= 4) && (curUpgradeLev >= 1)) {
		InsertItem(BuildList, iter, Structure_Slab4);
		InsertItem(BuildList, iter, Structure_Wall);
	} else {
		RemoveItem(BuildList, iter, Structure_Slab4);
		RemoveItem(BuildList, iter, Structure_Wall);
	}

	if(owner->hasWindTrap()) {
		InsertItem(BuildList, iter, Structure_Refinery);
	} else {
		RemoveItem(BuildList, iter, Structure_Refinery);
	}

	if(owner->hasWindTrap() && owner->hasRefinery() && (currentGame->techLevel >= 2)) {
		InsertItem(BuildList, iter, Structure_Silo);
		InsertItem(BuildList, iter, Structure_Radar);
	} else {
		RemoveItem(BuildList, iter, Structure_Silo);
		RemoveItem(BuildList, iter, Structure_Radar);
	}

	if(owner->hasWindTrap() && owner->hasRefinery() && (currentGame->techLevel >= 6)) {
		InsertItem(BuildList, iter, Structure_StarPort);
	} else {
		RemoveItem(BuildList, iter, Structure_StarPort);
	}

	if(owner->hasWindTrap() && owner->hasRefinery() && (currentGame->techLevel >= 3)) {
		InsertItem(BuildList, iter, Structure_LightFactory);
	} else {
		RemoveItem(BuildList, iter, Structure_LightFactory);
	}

	if(owner->hasWindTrap() && owner->hasRadar() && (currentGame->techLevel >= 5)) {
		InsertItem(BuildList, iter, Structure_GunTurret);
	} else {
		RemoveItem(BuildList, iter, Structure_GunTurret);
	}

	if(owner->hasWindTrap() && owner->hasRadar()  && (curUpgradeLev >= 2) && (currentGame->techLevel >= 6)) {
		InsertItem(BuildList, iter, Structure_RocketTurret);
	} else {
		RemoveItem(BuildList, iter, Structure_RocketTurret);
	}

	switch (getOwner()->getHouse()) {
		case(HOUSE_ATREIDES): {
			if(owner->hasWindTrap() && owner->hasRadar()) {
				InsertItem(BuildList, iter, Structure_Barracks);
			} else {
				RemoveItem(BuildList, iter, Structure_Barracks);
			}
		} break;

		case(HOUSE_FREMEN): {
			if(owner->hasWindTrap() && owner->hasRadar()) {
				InsertItem(BuildList, iter, Structure_Barracks);
				InsertItem(BuildList, iter, Structure_WOR);
			} else {
				RemoveItem(BuildList, iter, Structure_Barracks);
				RemoveItem(BuildList, iter, Structure_WOR);
			}
		} break;

		case(HOUSE_ORDOS):
		case(HOUSE_MERCENARY): {
			if(owner->hasWindTrap() && owner->hasRadar()) {
				InsertItem(BuildList, iter, Structure_Barracks);
			} else {
				RemoveItem(BuildList, iter, Structure_Barracks);
			}

			if(owner->hasWindTrap() && owner->hasRadar() && currentGame->techLevel >= 8) {
				InsertItem(BuildList, iter, Structure_WOR);
			} else {
				RemoveItem(BuildList, iter, Structure_WOR);
			}
		} break;

		case(HOUSE_HARKONNEN):
		case(HOUSE_SARDAUKAR): {
			if(owner->hasWindTrap() && owner->hasRadar()) {
				InsertItem(BuildList, iter, Structure_WOR);
			} else {
				RemoveItem(BuildList, iter, Structure_WOR);
			}
		} break;
	}


	if(owner->hasWindTrap() && owner->hasRadar() && owner->hasLightFactory() && (currentGame->techLevel >= 4)) {
		InsertItem(BuildList, iter, Structure_HeavyFactory);
	} else {
		RemoveItem(BuildList, iter, Structure_HeavyFactory);
	}

	if(owner->hasWindTrap() && owner->hasRadar() && owner->hasLightFactory() && (currentGame->techLevel >= 5)) {
		InsertItem(BuildList, iter, Structure_HighTechFactory);
	} else {
		RemoveItem(BuildList, iter, Structure_HighTechFactory);
	}

	if(owner->hasWindTrap() && owner->hasRadar() && owner->hasHeavyFactory() && (currentGame->techLevel >= 5)) {
		InsertItem(BuildList, iter, Structure_RepairYard);
	} else {
		RemoveItem(BuildList, iter, Structure_RepairYard);
	}

	if(owner->hasWindTrap() && owner->hasRadar() && owner->hasStarPort() && (currentGame->techLevel >= 7)) {
		InsertItem(BuildList, iter, Structure_IX);
	} else {
		RemoveItem(BuildList, iter, Structure_IX);
	}

	InsertItem(BuildList, iter, Structure_WindTrap);

	if(owner->hasWindTrap() && owner->hasRadar() && owner->hasStarPort() && owner->hasIX() && (currentGame->techLevel >= 8)) {
		InsertItem(BuildList, iter, Structure_Palace);
	} else {
		RemoveItem(BuildList, iter, Structure_Palace);
	}
}

void ConstructionYardClass::doSpecificStuff()
{
	buildUpdate();
}
