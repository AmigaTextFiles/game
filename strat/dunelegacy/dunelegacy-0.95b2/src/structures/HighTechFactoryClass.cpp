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

#include <structures/HighTechFactoryClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>

HighTechFactoryClass::HighTechFactoryClass(PlayerClass* newOwner) : BuilderClass(newOwner)
{
    HighTechFactoryClass::init();

    health = getMaxHealth();
}

HighTechFactoryClass::HighTechFactoryClass(Stream& stream) : BuilderClass(stream)
{
    HighTechFactoryClass::init();
}

void HighTechFactoryClass::init()
{
    itemID = Structure_HighTechFactory;
	owner->incrementStructures(itemID);

	structureSize.x = 3;
	structureSize.y = 2;

	GraphicID = ObjPic_HighTechFactory;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 8;
	imageH = graphic->h;
	FirstAnimFrame = 2;
	LastAnimFrame = 3;
}

HighTechFactoryClass::~HighTechFactoryClass()
{
}

void HighTechFactoryClass::checkSelectionList()
{
	BuilderClass::checkSelectionList();

	std::list<BuildItem>::iterator iter = BuildList.begin();

	InsertItem(BuildList, iter, Unit_Carryall);

	if(currentGame->techLevel >= 7 && (origHouse != HOUSE_HARKONNEN || origHouse != HOUSE_SARDAUKAR)) {
		InsertItem(BuildList, iter, Unit_Ornithopter);
	} else {
		RemoveItem(BuildList, iter, Unit_Ornithopter);
	}

}

void HighTechFactoryClass::doSpecificStuff()
{
	buildUpdate();
}
