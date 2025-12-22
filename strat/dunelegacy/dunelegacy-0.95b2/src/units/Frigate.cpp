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

#include <units/Frigate.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <MapClass.h>

Frigate::Frigate(PlayerClass* newOwner) : Carryall(newOwner)
{
    Frigate::init();

    health = getMaxHealth();

    attackMode = SCOUT;

    respondable = false;
	owned = false;
	aDropOfferer = true;
}

Frigate::Frigate(Stream& stream) : Carryall(stream)
{
    Frigate::init();

    // Carryall::Carryall(stream) set drawnFrame to 1 if carryall has cargo
    // -> set back to 0
	drawnFrame = 0;
}

void Frigate::init()
{
	itemID = Unit_Frigate;
	owner->decrementUnits(Unit_Carryall);   // was incremented by Carryall::init()
	owner->incrementUnits(itemID);

	canAttackStuff = false;

	GraphicID = ObjPic_Frigate;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());

	imageW = graphic->w/NUM_ANGLES;
	imageH = graphic->h;
}

Frigate::~Frigate()
{
}

bool Frigate::canPass(int xPos, int yPos) const
{
	// frigate can always pass other air units
	return currentGameMap->cellExists(xPos, yPos);
}
