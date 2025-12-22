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

#include <structures/GunTurretClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <MapClass.h>
#include <SoundPlayer.h>
#include <ObjectInterfaces.h>

RepairYardClass::RepairYardClass(PlayerClass* newOwner) : StructureClass(newOwner)
{
    RepairYardClass::init();

    health = getMaxHealth();
    bookings = 0;
	repairing = false;
}

RepairYardClass::RepairYardClass(Stream& stream) : StructureClass(stream)
{
    RepairYardClass::init();

	repairing = stream.readBool();
	repairUnit.load(stream);
	bookings = stream.readUint32();
}

void RepairYardClass::init()
{
    itemID = Structure_RepairYard;
	owner->incrementStructures(itemID);

	structureSize.x = 3;
	structureSize.y = 2;

	GraphicID = ObjPic_RepairYard;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	imageW = graphic->w / 10;
	imageH = graphic->h;
	FirstAnimFrame = 2;
	LastAnimFrame = 5;
}

RepairYardClass::~RepairYardClass()
{
}

void RepairYardClass::save(Stream& stream) const
{
	StructureClass::save(stream);

	stream.writeBool(repairing);
	repairUnit.save(stream);
	stream.writeUint32(bookings);
}


ObjectInterface* RepairYardClass::GetInterfaceContainer() {
	if((thisPlayer == owner) || (debug == true)) {
		return RepairYardInterface::Create(objectID);
	} else {
		return DefaultObjectInterface::Create(objectID);
	}
}

void RepairYardClass::deployRepairUnit()
{
	unBook();
	repairing = false;
	FirstAnimFrame = 2;
	LastAnimFrame = 5;
	Coord deployPos = currentGameMap->findDeploySpot(&location, &destination, &structureSize, repairUnit.getUnitPointer());
	repairUnit.getUnitPointer()->deploy(deployPos);
	repairUnit.PointTo(NONE);


	if(getOwner() == thisPlayer) {
		soundPlayer->playVoice(VehicleRepaired,getOwner()->getHouse());
	}
}

void RepairYardClass::doSpecificStuff()
{
	if(repairing) {
		if(curAnimFrame < 6) {
			FirstAnimFrame = 6;
			LastAnimFrame = 9;
			curAnimFrame = 6;
		}
	} else {
		if(curAnimFrame > 5) {
			FirstAnimFrame = 2;
			LastAnimFrame = 5;
			curAnimFrame = 2;
		}
	}

	if(repairing == true) {
		if (repairUnit.getUnitPointer()->getHealth()*100/repairUnit.getUnitPointer()->getMaxHealth() < 100) {
			if (owner->takeCredits(UNIT_REPAIRCOST) > 0) {
				repairUnit.getUnitPointer()->addHealth();
			}
		} else {
			deployRepairUnit();
		}
	}
}

void RepairYardClass::destroy() {
	if(repairing) {
		unBook();
		repairUnit.getUnitPointer()->destroy();
	}

	StructureClass::destroy();

}
