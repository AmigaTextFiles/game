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

#ifndef GLOBALS_H
#define GLOBALS_H

#include <DataTypes.h>
#include <Definitions.h>
#include <data.h>
#include <misc/RobustList.h>
#include <SDL.h>


// forward declarations
class SoundPlayer;
class MusicPlayer;
class FileManager;
class DataManager;
class FontManager;

class GameClass;
class MapClass;
class ScreenBorder;
class PlayerClass;
class UnitClass;
class StructureClass;
class BulletClass;

#ifndef SKIP_EXTERN_DEFINITION
 #define EXTERN extern
#else
 #define EXTERN
#endif

// SDL stuff
EXTERN SDL_Surface*         screen;
EXTERN SDL_Palette*         palette;
EXTERN int                  drawnMouseX;
EXTERN int                  drawnMouseY;


// abstraction layers
EXTERN SoundPlayer*	soundPlayer;
EXTERN MusicPlayer*         musicPlayer;
EXTERN FileManager*         pFileManager;
EXTERN FontManager*         pFontManager;
EXTERN DataManager*         pDataManager;


// game stuff
EXTERN GameClass*       currentGame;
EXTERN ScreenBorder*    screenborder;
EXTERN MapClass*        currentGameMap;
EXTERN PlayerClass*		thisPlayer;

EXTERN RobustList<UnitClass*>       unitList;
EXTERN RobustList<StructureClass*>  structureList;
EXTERN RobustList<BulletClass*>     bulletList;

EXTERN GAMESTATETYPE    gameState;
EXTERN bool             shade;
EXTERN bool             fog_wanted;
EXTERN SDL_Rect         gameBarPos;
EXTERN SDL_Rect         selectionRect;


// misc
EXTERN SettingsClass            settings;
EXTERN CURSORTYPE               cursorFrame;

EXTERN bool debug;
EXTERN char messageBuffer[MESSAGE_BUFFER_SIZE][MAX_LINE];
EXTERN int  messageTimer[MESSAGE_BUFFER_SIZE];

EXTERN int lookDist[11];
EXTERN int houseColour[NUM_HOUSES];

#endif //GLOBALS_H
