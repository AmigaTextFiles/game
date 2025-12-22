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

#include <structures/RefineryClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <SoundPlayer.h>
#include <MapClass.h>

#include <units/UnitClass.h>
#include <units/HarvesterClass.h>

RefineryClass::RefineryClass(PlayerClass* newOwner) : StructureClass(newOwner)
{
    RefineryClass::init();

    health = getMaxHealth();

	extractingSpice = false;
    bookings = 0;

	firstRun = true;

    FirstAnimFrame = 2;
	LastAnimFrame = 3;
}

RefineryClass::RefineryClass(Stream& stream) : StructureClass(stream)
{
    RefineryClass::init();

	extractingSpice = stream.readBool();
	harvester.load(stream);
	bookings = stream.readUint32();

	if(extractingSpice) {
		FirstAnimFrame = 8;
		LastAnimFrame = 9;
		curAnimFrame = 8;
	} else if(bookings == 0) {
		FirstAnimFrame = 2;
		LastAnimFrame = 3;
		curAnimFrame = 2;
	} else {
		FirstAnimFrame = 2;
		LastAnimFrame = 7;
		curAnimFrame = 2;
	}

	firstRun = false;
}
void RefineryClass::init()
{
    itemID = Structure_Refinery;
	owner->incrementStructures(itemID);

	structureSize.x = 3;
	structureSize.y = 2;

	GraphicID = ObjPic_Refinery;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 10;
	imageH = graphic->h;
}

RefineryClass::~RefineryClass()
{
}

void RefineryClass::save(Stream& stream) const
{
	StructureClass::save(stream);

    stream.writeBool(extractingSpice);
	harvester.save(stream);
	stream.writeUint32(bookings);
}

void RefineryClass::assignHarvester(HarvesterClass* newHarvester)
{
	extractingSpice = true;
	harvester.PointTo(newHarvester);
	drawnAngle = 1;
	FirstAnimFrame = 8;
	LastAnimFrame = 9;
	curAnimFrame = 8;
}



void RefineryClass::deployHarvester()
{
	unBook();
	drawnAngle = 0;
	extractingSpice = false;

	if(firstRun)
	{
		if (getOwner() == thisPlayer)
		{
			soundPlayer->playVoice(HarvesterDeployed,getOwner()->getHouse());
		}
	}

	firstRun = false;
	Coord deployPos = currentGameMap->findDeploySpot(&location, &destination, &structureSize, harvester.getObjPointer());
	((HarvesterClass*) harvester.getObjPointer())->deploy(deployPos);

	if(bookings == 0) {
		FirstAnimFrame = 2;
		LastAnimFrame = 3;
		curAnimFrame = 2;
	} else {
		FirstAnimFrame = 2;
		LastAnimFrame = 7;
		curAnimFrame = 2;
	}
}

void RefineryClass::startAnimate()
{
	if(extractingSpice == false) {
		FirstAnimFrame = 2;
		LastAnimFrame = 7;
		curAnimFrame = 2;
	}
}

void RefineryClass::doSpecificStuff()
{
	if (extractingSpice)
	{
		if (((HarvesterClass*) harvester.getObjPointer())->getAmountOfSpice() > 0.0)
		{
			owner->addCredits(((HarvesterClass*) harvester.getObjPointer())->extractSpice());
		}
		else
			deployHarvester();
	}
}

void RefineryClass::destroy()
{
    if (extractingSpice && harvester) {
		if(harvester.getUnitPointer() != NULL)
			harvester.getUnitPointer()->destroy();
		harvester.PointTo(NONE);
	}

	StructureClass::destroy();
}
