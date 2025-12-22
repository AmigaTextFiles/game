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

#include <units/Ornithopter.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <MapClass.h>
#include <PlayerClass.h>
#include <SoundPlayer.h>

Ornithopter::Ornithopter(PlayerClass* newOwner) : AirUnit(newOwner)
{
    Ornithopter::init();

    health = getMaxHealth();
}

Ornithopter::Ornithopter(Stream& stream) : AirUnit(stream)
{
    Ornithopter::init();
}

void Ornithopter::init()
{
	itemID = Unit_Ornithopter;
	owner->incrementUnits(itemID);

	GraphicID = ObjPic_Ornithopter;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());

	imageW = graphic->w/NUM_ANGLES;
	imageH = graphic->h/3;

	numWeapons = 1;
	bulletType = Bullet_SmallRocket;
	weaponReloadTime = 300;
}

Ornithopter::~Ornithopter()
{
}

void Ornithopter::checkPos()
{
	AirUnit::checkPos();

	++drawnFrame;
	if(drawnFrame >= 3) {
		drawnFrame = 0;
	}
}

bool Ornithopter::canAttack(const ObjectClass* object) const
{
	if ((object != NULL)
		&& ((object->getOwner()->getTeam() != owner->getTeam()) || object->getItemID() == Unit_Sandworm)
		&& object->isVisible(getOwner()->getTeam()))
		return true;
	else
		return false;
}

void Ornithopter::destroy()
{
	// place wreck
    if(currentGameMap->cellExists(location)) {
        TerrainClass* pTerrain = currentGameMap->getCell(location);
        pTerrain->assignDeadObject(DeadObject_Ornithopter, owner->getHouse(), Coord((Sint32) realX, (Sint32) realY));
    }

	AirUnit::destroy();
}

void Ornithopter::PlayAttackSound() {
	soundPlayer->playSoundAt(Sound_RocketSmall,location);
}
