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

#include <units/SiegeTankClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <GameClass.h>
#include <MapClass.h>
#include <Explosion.h>
#include <ScreenBorder.h>
#include <SoundPlayer.h>

Coord	siegeTurretOffset[] =
{
	Coord(2, -4),
	Coord(1, -5),
	Coord(0, -5),
	Coord(-1, -5),
	Coord(-2, -4),
	Coord(-1, -2),
	Coord(-1, -4),
	Coord(1, -2)
};

SiegeTankClass::SiegeTankClass(PlayerClass* newOwner) : TankClass(newOwner)
{
    SiegeTankClass::init();

    health = getMaxHealth();
}

SiegeTankClass::SiegeTankClass(Stream& stream) : TankClass(stream)
{
    SiegeTankClass::init();
}
void SiegeTankClass::init()
{
    itemID = Unit_SiegeTank;
    owner->decrementUnits(Unit_Tank); // incremented by TankClass::init()
    owner->incrementUnits(itemID);

	numWeapons = 2;
	bulletType = Bullet_Shell;
	weaponReloadTime = 150;

	GraphicID = ObjPic_Siegetank_Base;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());
	GunGraphicID = ObjPic_Siegetank_Gun;
	turretGraphic = pDataManager->getObjPic(GunGraphicID,getOwner()->getColour());

	imageW = graphic->w/NUM_ANGLES;
	imageH = graphic->h;
}

SiegeTankClass::~SiegeTankClass()
{
}

void SiegeTankClass::blitToScreen()
{
	SDL_Rect dest, source;
	dest.x = getDrawnX();
	dest.y = getDrawnY();
	dest.w = source.w = imageW;
	dest.h = source.h = imageH;
	source.y = 0;

    source.x = drawnAngle*imageW;

    SDL_BlitSurface(graphic, &source, screen, &dest);	//blit base
    source.x = drawnTurretAngle*source.w;
    source.y = 0;
    dest.x = getDrawnX() + siegeTurretOffset[drawnTurretAngle].x;
    dest.y = getDrawnY() + siegeTurretOffset[drawnTurretAngle].y;
    SDL_BlitSurface(turretGraphic, &source, screen, &dest);	//blit turret
    if (badlyDamaged)
        drawSmoke(screenborder->world2screenX(realX), screenborder->world2screenY(realY));
}

void SiegeTankClass::destroy() {
    if(currentGameMap->cellExists(location) && isVisible()) {
        Coord realPos((short)realX, (short)realY);
        Uint32 explosionID = currentGame->RandomGen.getRandOf(2,Explosion_Medium1, Explosion_Medium2);
        currentGame->getExplosionList().push_back(new Explosion(explosionID, realPos, owner->getHouse()));

        if(isVisible(getOwner()->getTeam()))
            soundPlayer->playSoundAt(Sound_ExplosionLarge,location);
    }

    // call TrackedUnit::destroy() directly and circumvent TankClass::destroy()
    TrackedUnit::destroy();
}

void SiegeTankClass::PlayAttackSound() {
	soundPlayer->playSoundAt(Sound_ExplosionSmall,location);
}

