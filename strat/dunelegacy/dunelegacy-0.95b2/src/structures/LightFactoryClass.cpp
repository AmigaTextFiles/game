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

#include <structures/LightFactoryClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>

LightFactoryClass::LightFactoryClass(PlayerClass* newOwner) : BuilderClass(newOwner)
{
    LightFactoryClass::init();

    health = getMaxHealth();
}

LightFactoryClass::LightFactoryClass(Stream& stream) : BuilderClass(stream)
{
    LightFactoryClass::init();
}

void LightFactoryClass::init()
{
    itemID = Structure_LightFactory;
	owner->incrementStructures(itemID);

	structureSize.x = 2;
	structureSize.y = 2;

	GraphicID = ObjPic_LightFactory;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 6;
	imageH = graphic->h;
	FirstAnimFrame = 2;
	LastAnimFrame = 3;

	allowedToUpgrade = true;
	upgradeCost = 500;
	upgradeLevels = (currentGame->techLevel >= 4) ? 1 : 0;
}

LightFactoryClass::~LightFactoryClass()
{
}

void LightFactoryClass::checkSelectionList()
{
	BuilderClass::checkSelectionList();

	std::list<BuildItem>::iterator iter = BuildList.begin();

	switch(origHouse) {
		case HOUSE_ORDOS: {
			InsertItem(BuildList, iter, Unit_Raider);
			if(curUpgradeLev >= 1) {
				InsertItem(BuildList, iter, Unit_Quad);
			} else {
				RemoveItem(BuildList, iter, Unit_Quad);
			}
		} break;

		case HOUSE_ATREIDES: {
			InsertItem(BuildList, iter, Unit_Trike);
			if(curUpgradeLev >= 1) {
				InsertItem(BuildList, iter, Unit_Quad);
			} else {
				RemoveItem(BuildList, iter, Unit_Quad);
			}
		} break;

		case HOUSE_HARKONNEN: {
			if(curUpgradeLev >= 1) {
				InsertItem(BuildList, iter, Unit_Trike);
			} else {
				RemoveItem(BuildList, iter, Unit_Trike);
			}
			InsertItem(BuildList, iter, Unit_Quad);
		} break;

		default: {
			InsertItem(BuildList, iter, Unit_Trike);
			InsertItem(BuildList, iter, Unit_Quad);
		} break;
	};
}

void LightFactoryClass::doSpecificStuff()
{
	buildUpdate();
}
