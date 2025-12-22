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

#include <RadarView.h>

#include <globals.h>

#include <FileClasses/DataManager.h>

#include <GameClass.h>
#include <MapClass.h>
#include <PlayerClass.h>
#include <ScreenBorder.h>
#include <TerrainClass.h>

#include <misc/draw_util.h>


#define NUM_STATIC_FRAMES 21
#define NUM_STATIC_FRAME_TIME 5

#define RADARVIEW_BORDERTHICKNESS 2

SDL_Rect RadarPosition = { 14, RADARVIEW_BORDERTHICKNESS, 128, 128 };

RadarView::RadarView()
	: currentRadarMode(Mode_RadarOff), animFrame(NUM_STATIC_FRAMES - 1), animCounter(NUM_STATIC_FRAME_TIME)
{
    radarStaticAnimation = pDataManager->getUIGraphic(UI_RadarAnimation);
}


RadarView::~RadarView()
{
}

void RadarView::switchRadarMode(bool bOn)
{
    if(bOn == true) {
        currentRadarMode = Mode_AnimationRadarOn;
    } else {
        currentRadarMode = Mode_AnimationRadarOff;
    }
}

void RadarView::setRadarMode(bool bStatus)
{
    if(bStatus == true) {
        currentRadarMode = Mode_RadarOn;
        animFrame = 0;
        animCounter = NUM_STATIC_FRAME_TIME;
    } else {
        currentRadarMode = Mode_RadarOff;
        animFrame = NUM_STATIC_FRAMES - 1;
        animCounter = NUM_STATIC_FRAME_TIME;
    }
}

void RadarView::draw() const
{
    switch(currentRadarMode) {
        case Mode_RadarOff:
        case Mode_RadarOn:
        {
            int MapSizeX = currentGameMap->sizeX;
            int MapSizeY = currentGameMap->sizeY;

            // Lock the screen for direct access to the pixels
            if (!SDL_MUSTLOCK(screen) || (SDL_LockSurface(screen) == 0)) {
                for (int x = 0; x <  MapSizeX; x++) {
                    for (int y = 0; y <  MapSizeY; y++) {

                        TerrainClass* tempTerrain = &currentGameMap->cell[x][y];

                        /* Selecting the right colour is handled in TerrainClass::getRadarColour() */
                        putpixel(screen, gameBarPos.x + RadarPosition.x + 2*x, gameBarPos.y + RadarPosition.y + 2*y,
                                tempTerrain->getRadarColour(thisPlayer->getPlayerNumber(),
                                thisPlayer->hasRadarOn())	);
                        putpixel(screen, gameBarPos.x + RadarPosition.x + 2*x+1, gameBarPos.y + RadarPosition.y + 2*y,
                                tempTerrain->getRadarColour(thisPlayer->getPlayerNumber(),
                                thisPlayer->hasRadarOn())	);
                        putpixel(screen, gameBarPos.x + RadarPosition.x + 2*x, gameBarPos.y + RadarPosition.y + 2*y+1,
                                tempTerrain->getRadarColour(thisPlayer->getPlayerNumber(),
                                thisPlayer->hasRadarOn())	);
                        putpixel(screen, gameBarPos.x + RadarPosition.x + 2*x+1, gameBarPos.y + RadarPosition.y + 2*y+1,
                                tempTerrain->getRadarColour(thisPlayer->getPlayerNumber(),
                                thisPlayer->hasRadarOn())	);
                    }
                }

                if (!SDL_MUSTLOCK(screen) || (SDL_LockSurface(screen) == 0)) {
                    if (SDL_MUSTLOCK(screen))
                        SDL_UnlockSurface(screen);
                }
            }

            SDL_Rect RadarRect;
            RadarRect.x = (screenborder->getLeft() * MapSizeX*2) / (MapSizeX*BLOCKSIZE);
            RadarRect.y = (screenborder->getTop() * MapSizeY*2) / (MapSizeY*BLOCKSIZE);
            RadarRect.w = ((screenborder->getRight() - screenborder->getLeft()) * MapSizeX*2) / (MapSizeX*BLOCKSIZE);
            RadarRect.h = ((screenborder->getBottom() - screenborder->getTop()) * MapSizeY*2) / (MapSizeY*BLOCKSIZE);

            drawrect(   screen,
                        gameBarPos.x + RadarPosition.x + RadarRect.x,
                        gameBarPos.y + RadarPosition.y + RadarRect.y,
                        gameBarPos.x + RadarPosition.x + (RadarRect.x + RadarRect.w),
                        gameBarPos.y + RadarPosition.y + (RadarRect.y + RadarRect.h),
                        COLOUR_WHITE);

        } break;

        case Mode_AnimationRadarOff:
        case Mode_AnimationRadarOn:
        {
            int imageW = radarStaticAnimation->w / NUM_STATIC_FRAMES;
            int imageH = radarStaticAnimation->h;
            SDL_Rect source = { animFrame*imageW, 0, imageW, imageH };
            SDL_Rect dest = { gameBarPos.x + RadarPosition.x, gameBarPos.y + RadarPosition.y, imageW, imageH };
            SDL_BlitSurface(radarStaticAnimation, &source, screen, &dest);
        } break;
    }
}

void RadarView::update()
{
    switch(currentRadarMode) {
        case Mode_RadarOff: {

        } break;

        case Mode_RadarOn: {

        } break;

        case Mode_AnimationRadarOff: {
            if(animFrame >= NUM_STATIC_FRAMES-1) {
                currentRadarMode = Mode_RadarOff;
            } else {
                animCounter--;
                if(animCounter <= 0) {
                    animFrame++;
                    animCounter = NUM_STATIC_FRAME_TIME;
                }
            }
        } break;

        case Mode_AnimationRadarOn: {
            if(animFrame <= 0) {
                currentRadarMode = Mode_RadarOn;
            } else {
                animCounter--;
                if(animCounter <= 0) {
                    animFrame--;
                    animCounter = NUM_STATIC_FRAME_TIME;
                }
            }
        } break;
    }
}

Coord RadarView::getWorldCoords(int mouseX, int mouseY) const
{
    Coord positionOnRadar(mouseX - gameBarPos.x - RadarPosition.x, mouseY - RadarPosition.y);

    return Coord( (positionOnRadar.x * currentGameMap->sizeX * BLOCKSIZE) / RadarPosition.w,
                  (positionOnRadar.y * currentGameMap->sizeY * BLOCKSIZE) / RadarPosition.h);
}

bool RadarView::isOnRadar(int mouseX, int mouseY) const
{
    return ((mouseX >= RadarPosition.x + gameBarPos.x - RADARVIEW_BORDERTHICKNESS)
            && (mouseX < RadarPosition.x + gameBarPos.x + RadarPosition.w + 2*RADARVIEW_BORDERTHICKNESS)
            && (mouseY >= RadarPosition.y - RADARVIEW_BORDERTHICKNESS)
            && (mouseY < RadarPosition.y + RadarPosition.h + 2*RADARVIEW_BORDERTHICKNESS) );
}
