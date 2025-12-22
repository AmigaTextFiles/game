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

#include <structures/WallClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>

WallClass::WallClass(PlayerClass* newOwner) : StructureClass(newOwner)
{
    WallClass::init();

    health = getMaxHealth();
}

WallClass::WallClass(Stream& stream) : StructureClass(stream)
{
    WallClass::init();
}

void WallClass::init() {
    itemID = Structure_Wall;
	owner->incrementStructures(itemID);

	structureSize.x = 1;
	structureSize.y = 1;

	GraphicID = ObjPic_Wall;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 75;
	imageH = graphic->h;

	setTile(Structure_w8);
}

WallClass::~WallClass()
{
}

void WallClass::checkSelf()
{
}

void WallClass::doSpecificStuff()
{
}
