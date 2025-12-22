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

#include <units/AirUnit.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>
#include <Explosion.h>
#include <SoundPlayer.h>
#include <MapClass.h>

#include <structures/RepairYardClass.h>

AirUnit::AirUnit(PlayerClass* newOwner) : UnitClass(newOwner)
{
    AirUnit::init();
}

AirUnit::AirUnit(Stream& stream) : UnitClass(stream)
{
    AirUnit::init();
}

void AirUnit::init()
{
    aFlyingUnit = true;
}

AirUnit::~AirUnit()
{
}

void AirUnit::save(Stream& stream) const
{
	UnitClass::save(stream);
}

void AirUnit::destroy()
{
    if(isVisible()) {
        Coord position((short) realX, (short) realY);
        currentGame->getExplosionList().push_back(new Explosion(Explosion_Medium2, position, owner->getHouse()));

        if(isVisible(getOwner()->getTeam()))
            soundPlayer->playSoundAt(Sound_ExplosionMedium,location);
    }

    UnitClass::destroy();
}

void AirUnit::assignToMap(const Coord& pos)
{
	if(currentGameMap->cellExists(pos)) {
		currentGameMap->cell[pos.x][pos.y].assignAirUnit(getObjectID());
		currentGameMap->viewMap(owner->getTeam(), location, getViewRange());
	}
}

void AirUnit::checkPos()
{
}

bool AirUnit::canPass(int xPos, int yPos) const
{
	return (currentGameMap->cellExists(xPos, yPos) && (!currentGameMap->getCell(xPos, yPos)->hasAnAirUnit()));
}
