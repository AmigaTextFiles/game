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

#ifndef SAND_H
#define SAND_H

#include <SDL.h>

#include <DataTypes.h>
#include <string>
#include <vector>

// forward declarations
class GameInitClass;

void drawCursor();

SDL_Surface* resolveItemPicture(int itemID);
Coord	getStructureSize(int ItemID);
Uint32  getItemIDByName(std::string name);
int     getHouseByName(std::string name);

void startReplay(std::string filename);
void startSinglePlayerGame(GameInitClass * init);

bool SplitString(std::string ParseString, unsigned int NumStringPointers,...);
std::vector<std::string> SplitString(std::string ParseString);

#endif //SAND_H
