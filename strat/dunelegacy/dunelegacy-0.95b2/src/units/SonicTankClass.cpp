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

#include <units/SonicTankClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>
#include <MapClass.h>
#include <Explosion.h>
#include <ScreenBorder.h>
#include <SoundPlayer.h>

Coord sonicTankTurretOffset[] =
{
	Coord(3, 1),
	Coord(3, 1),
	Coord(3, 1),
	Coord(3, 1),
	Coord(3, 1),
	Coord(3, 1),
	Coord(3, 1),
	Coord(3, 1)
};

SonicTankClass::SonicTankClass(PlayerClass* newOwner) : TrackedUnit(newOwner)
{
    SonicTankClass::init();

    health = getMaxHealth();
}

SonicTankClass::SonicTankClass(Stream& stream) : TrackedUnit(stream)
{
    SonicTankClass::init();
}

void SonicTankClass::init()
{
    itemID = Unit_SonicTank;
    owner->incrementUnits(itemID);

	numWeapons = 1;
	bulletType = Bullet_Sonic;
	weaponReloadTime = 150;

	GraphicID = ObjPic_Tank_Base;
	GunGraphicID = ObjPic_Sonictank_Gun;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	turretGraphic = pDataManager->getObjPic(GunGraphicID,getOwner()->getColour());

	imageW = graphic->w/NUM_ANGLES;
	imageH = graphic->h;
}

SonicTankClass::~SonicTankClass()
{
}

void SonicTankClass::blitToScreen()
{
	SDL_Rect dest, source;
	dest.x = getDrawnX();
	dest.y = getDrawnY();
	dest.w = source.w = imageW;
	dest.h = source.h = imageH;
	source.y = 0;
    source.x = drawnAngle*imageW;

    SDL_BlitSurface(graphic, &source, screen, &dest);	//blit base
    source.w = turretGraphic->w/NUM_ANGLES;
    source.h = turretGraphic->h;
    source.x = drawnAngle*source.w;
    source.y = 0;
    dest.x = getDrawnX() + sonicTankTurretOffset[drawnAngle].x;
    dest.y = getDrawnY() + sonicTankTurretOffset[drawnAngle].y;
    SDL_BlitSurface(turretGraphic, &source, screen, &dest);	//blit turret
    if (badlyDamaged)
        drawSmoke(screenborder->world2screenX(realX), screenborder->world2screenY(realY));
}

void SonicTankClass::destroy() {
    if(currentGameMap->cellExists(location) && isVisible()) {
        Coord realPos((short)realX, (short)realY);
        currentGame->getExplosionList().push_back(new Explosion(Explosion_SmallUnit, realPos, owner->getHouse()));

        if(isVisible(getOwner()->getTeam()))
            soundPlayer->playSoundAt(Sound_ExplosionSmall,location);
    }

    TrackedUnit::destroy();
}

void SonicTankClass::handleDamage(int damage, Uint32 damagerID)
{
    ObjectClass* damager = currentGame->getObjectManager().getObject(damagerID);

	if (!damager || (damager->getItemID() != Unit_SonicTank))
		ObjectClass::handleDamage(damage, damagerID);
}

bool SonicTankClass::canAttack(const ObjectClass *object) const
{
	return ((object != NULL) && ObjectClass::canAttack(object) && (object->getItemID() != Unit_SonicTank));
}

void SonicTankClass::PlayAttackSound() {
	soundPlayer->playSoundAt(Sound_Sonic,location);
}
