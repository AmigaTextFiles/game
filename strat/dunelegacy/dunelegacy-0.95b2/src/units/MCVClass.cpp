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

#include <units/MCVClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <Explosion.h>
#include <GameClass.h>
#include <SoundPlayer.h>
#include <MapClass.h>

MCVClass::MCVClass(PlayerClass* newOwner) : GroundUnit(newOwner)
{
    MCVClass::init();

    health = getMaxHealth();
    attackMode = SCOUT;
}

MCVClass::MCVClass(Stream& stream) : GroundUnit(stream)
{
    MCVClass::init();
}

void MCVClass::init() {
    itemID = Unit_MCV;
    owner->incrementUnits(itemID);

	canAttackStuff = false;

	GraphicID = ObjPic_MCV;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());

	imageW = graphic->w/NUM_ANGLES;
	imageH = graphic->h;
}

MCVClass::~MCVClass() {

}

void MCVClass::HandleDeployClick() {
	currentGame->GetCommandManager().addCommand(Command(CMD_MCV_DEPLOY,objectID));
}

void MCVClass::DoDeploy() {
	if (currentGameMap->okayToBuildExclusive(getX(), getY(), 2, 2)) {
		//2x2 is size of construction yard

		setVisible(VIS_ALL, false);

		getOwner()->placeStructure(getObjectID(), Structure_ConstructionYard, getX(), getY());
		destroy();
		return;
	} else {
		currentGame->AddToNewsTicker("You cannot deploy here.");
	}
}

void MCVClass::destroy() {
    if(currentGameMap->cellExists(location) && isVisible()) {
        Coord realPos((short)realX, (short)realY);
        currentGame->getExplosionList().push_back(new Explosion(Explosion_SmallUnit, realPos, owner->getHouse()));

        if(isVisible(getOwner()->getTeam()))
            soundPlayer->playSoundAt(Sound_ExplosionSmall,location);
    }

    GroundUnit::destroy();
}
