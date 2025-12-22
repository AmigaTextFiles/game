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

#include <units/DeviatorClass.h>

#include <globals.h>

#include <PlayerClass.h>

DeviatorClass::DeviatorClass(PlayerClass* newOwner) : LauncherClass(newOwner)
{
    DeviatorClass::init();

    health = getMaxHealth();
}

DeviatorClass::DeviatorClass(Stream& stream) : LauncherClass(stream)
{
    DeviatorClass::init();
}

void DeviatorClass::init()
{
    itemID = Unit_Deviator;
    owner->decrementUnits(Unit_Launcher);   // was incremented by LauncherClass::init()
    owner->incrementUnits(itemID);

	numWeapons = 1;
	bulletType = Bullet_DRocket;
	weaponReloadTime = 285;
}

DeviatorClass::~DeviatorClass()
{
}

bool DeviatorClass::canAttack(const ObjectClass* object) const
{
	if ((object != NULL) &&	!object->isAStructure()
		&& ((object->getOwner()->getTeam() != owner->getTeam()) || object->getItemID() == Unit_Sandworm)
		&& object->isVisible(getOwner()->getTeam()))
		return true;
	else
		return false;
}
