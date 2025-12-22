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

#include <ScreenBorder.h>

#include <globals.h>

#include <MapClass.h>

void ScreenBorder::SetNewScreenCenter(const Coord& newPosition) {
    Coord currentBorderSize = BottomRightCorner - TopLeftCorner;

    TopLeftCorner = newPosition - currentBorderSize/2;
    BottomRightCorner = newPosition + currentBorderSize/2;

    int MapSizeX = currentGameMap->sizeX * BLOCKSIZE;
    int MapSizeY = currentGameMap->sizeY * BLOCKSIZE;

    if((TopLeftCorner.x < 0) && (BottomRightCorner.x >= MapSizeX)) {
        // screen is wider than map
        TopLeftCorner.x = MapSizeX/2 - currentBorderSize.x/2;
        BottomRightCorner.x = MapSizeX/2 + currentBorderSize.x/2;
    } else if(TopLeftCorner.x < 0) {
        // leaving the map at the left border
        BottomRightCorner.x -= TopLeftCorner.x;
        TopLeftCorner.x = 0;
    } else if(BottomRightCorner.x >= MapSizeX) {
        // leaving the map at the right border
        TopLeftCorner.x -= (BottomRightCorner.x - MapSizeX);
        BottomRightCorner.x = MapSizeX;
    }

    if((TopLeftCorner.y < 0) && (BottomRightCorner.y >= MapSizeY)) {
        // screen is higher than map
        TopLeftCorner.y = MapSizeY/2 - currentBorderSize.y/2;
        BottomRightCorner.y = MapSizeY/2 + currentBorderSize.y/2;
    } else if(TopLeftCorner.y < 0) {
        // leaving the map at the top border
        BottomRightCorner.y -= TopLeftCorner.y;
        TopLeftCorner.y = 0;
    } else if(BottomRightCorner.y >= MapSizeY) {
        // leaving the map at the bottom border
        TopLeftCorner.y -= (BottomRightCorner.y - MapSizeY);
        BottomRightCorner.y = MapSizeY;
    }
}

bool ScreenBorder::scrollLeft() {
    if(TopLeftCorner.x > 0) {
        TopLeftCorner.x--;
        BottomRightCorner.x--;
        return true;
    } else {
        return false;
    }
}

bool ScreenBorder::scrollRight() {
    if(BottomRightCorner.x < currentGameMap->sizeX*BLOCKSIZE-1) {
        TopLeftCorner.x++;
        BottomRightCorner.x++;
        return true;
    } else {
        return false;
    }
}

bool ScreenBorder::scrollUp() {
    if(TopLeftCorner.y > 0) {
        TopLeftCorner.y--;
        BottomRightCorner.y--;
        return true;
    } else {
        return false;
    }
}

bool ScreenBorder::scrollDown() {
    if(BottomRightCorner.y < currentGameMap->sizeY*BLOCKSIZE-1) {
        TopLeftCorner.y++;
        BottomRightCorner.y++;
        return true;
    } else {
        return false;
    }
}
