/***************************************************************************
  globals.h  -  header for the whole programm, included by every cpp file
                             -------------------
    copyright            : (C) 2003-2004 by Artur Hallmann, (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#ifndef __GLOBALS_H__
#define __GLOBALS_H__

/* *** *** *** *** *** *** *** *** *** *** */

#define CAPTION "Super Mario Clone FX"
#if !defined( VERSION ) && !defined( HAVE_CONFIG_H )
#define VERSION "0.95 Alpha 2"
#endif

#define DESIRED_FPS 32

#define LEFT    0
#define RIGHT   1
#define UP		2
#define DOWN	3

#define STAYING 0
#define WALKING 1
#define JUMPING 2
#define FALLING 3

#define STAY	0
#define RUN		2
#define FALL	4
#define JUMP	6


// ### - Special Channels ( For ingame sounds which shouldn't be played twice at the same time )
// 5 an up is buggy ...
// Todo : more channels sometime

#define CHANNEL_MARIO_JUMP 1
#define CHANNEL_MARIO_TOCK 2
#define CHANNEL_MARIO_POWERDOWN 3
#define CHANNEL_MARIO_DEATH 1
#define CHANNEL_MARIO_FIREBALL 2

#define CHANNEL_FIREPLANT 3
#define CHANNEL_MUSHROOM 3
#define CHANNEL_1UP_MUSHROOM 3

// ###

#define CAMERASPEED 35 // camerapos in EditMode

// for use with the KeyPressed function
#define KEY_ENTER 1
#define KEY_LEFT 2
#define KEY_RIGHT 3
#define KEY_UP 4
#define KEY_DOWN 5
#define KEY_ESC 6

// The Game Modes
#define MODE_NOTHING 0
#define MODE_LEVEL 1
#define MODE_OVERWORLD 2
#define MODE_MENU 3

/* *** *** *** *** *** *** *** *** *** *** */

#ifndef _DEBUG
	#undef _STLP_DEBUG
#else
	#define _STLP_DEBUG 1
#endif

#ifdef _WIN32
	#define __WIN32__
	#ifdef _DEBUG
		#pragma warning ( disable : 4786 )
	#endif
#endif

#ifdef HAVE_CONFIG_H // for non-windows platforms
	#include "config.h"
#else
	#ifdef __WIN32__
		#define LEVEL_DIR "levels"
		#define OVERWORLD_DIR "world"
		#define PIXMAPS_DIR "data/pixmaps"
		#define SOUNDS_DIR "data/sounds"
		#define MUSIC_DIR "data/music"
		#define FONT_DIR "data/font"
	#else
		#error HAVE_CONFIG_H is required on non-windows plattforms
	#endif
#endif


#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <time.h>
#include <math.h>

using std::string;
using std::vector;
using std::cout;
using std::flush;
using std::ifstream;
using std::fstream;
using std::ofstream;
using std::endl;
using std::ios;
using std::find_if;


#ifdef __MORPHOS__

#include <proto/powersdl.h>


#include <SDL/SDL.h>
#include <SDL/SDL_ttf.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>

#include <SDL/SDL_gfxPrimitives.h>	// Pixel, Rectangle, etc functions
#include <SDL/SDL_rotozoom.h>		// image zooming and rotating functions ( update to SGE sometime... )

#else

#include <SDL.h>
#include <SDL_ttf.h>
#include <SDL_image.h>
#include <SDL_mixer.h>

#endif

#if defined( __WIN32__ ) && defined( _DEBUG )
	#undef main
#endif

#ifndef __MORPHOS__

#include <SDL_gfxPrimitives.h>	// Pixel, Rectangle, etc functions
#include <SDL_rotozoom.h>		// image zooming and rotating functions ( update to SGE sometime... )
#endif


#include "include/img_manager.h"
#include "include/framerate.h"

extern cFramerate Framerate;

#include "include/savegame.h"
#include "include/audio.h"
#include "include/animation.h"
#include "include/joystick.h"
#include "include/menu.h"
#include "include/sprite.h"
#include "include/leveleditor.h"
#include "include/level.h"
#include "include/goldpiece.h"
#include "include/cloud.h"
#include "include/hud.h"
#include "include/levelexit.h"
#include "include/powerup.h"
#include "include/box.h"
#include "include/player.h"
#include "include/enemy.h"
#include "include/turtle.h"
#include "include/goomba.h"
#include "include/jpiranha.h"
#include "include/banzai_bill.h"
#include "include/rex.h"
#include "include/preferences.h"
#include "include/overworld.h"
#include "include/dialog.h"

// The Image Manager
extern cImageManager *ImageFactory; 
// The Joystick
extern cJoystick *pJoystick;
// The Sprites
extern cSprite **MassiveObjects, **PassiveObjects, **ActiveObjects, **EnemyObjects, **HUDObjects, **AnimationObjects;
// The Dialogs
extern cDialog **DialogObjects;
// The Player
extern cPlayer *pPlayer;
// The Level
extern cLevel *pLevel;
// The Overworld
extern cOverWorld *pOverWorld;
// The Menu
extern cMainMenu *pMenu;
// The Mouse
extern cMouseCursor *pMouseCursor;
// The HUD
extern cPlayerPoints *pointsdisplay;
extern cDebugDisplay *debugdisplay;
extern cGoldDisplay *golddisplay;
extern cLiveDisplay *livedisplay;
extern cTimeDisplay *timedisplay;
extern cItemBox *Itembox;
// The Leveleditor
extern cLevelEditor *pLeveleditor;
// The Preferences
extern cPreferences *pPreferences;
// Sprite counts
extern int MassiveCount, PassiveCount, ActiveCount, EnemyCount, HUDCount, AnimationCount, DialogCount;

extern bool done;
extern SDL_Surface *screen;
extern Uint32 magenta, std_bgcolor, darkblue, white, grey, green;
extern TTF_Font *font, *font_16;
extern SDL_Color colorBlack, colorWhite, colorBlue, colorDarkBlue, colorGreen ,colorDarkGreen, colorMagenta, colorGrey, colorRed;
// Pressed keys
extern Uint8 *keys;
// Event system
extern SDL_Event event;
/* 0 = disabled
 * 1 = Level Editor
 * 2 = Object Editor
 */
extern int Leveleditor_Mode;
/* 0 = nothing
 * 1 = Level
 * 2 = Overworld
 * 3 = Menu
 */
extern int Game_Mode;
extern bool Game_debug, Overworld_debug;
extern bool HUD_loaded;

extern signed int cameraposx;
extern signed int cameraposy;
extern signed int _cameraposx;
extern signed int _cameraposy;
extern int UpKeyTime;
// ### Mouse
extern int mouseX, mouseY, _mouseX, _mouseY;
// ### Mouse ###

extern cAudio *pAudio;

// Returns true if the number is valid
bool is_valid_number( string num );

/*	Loads image directly.
 *	The returned image can be deleted.
 */
SDL_Surface* LoadImage( const char *filename );

/*	Loads image from pixmaps directory.
 *	The returned image should not be deleted !
 */ 
SDL_Surface* GetImage( string filename );

// Creates a Surface with the given attributes
SDL_Surface* MakeSurface( unsigned int width, unsigned int height, bool hardware = 0 );

// Adds a Sprite to the Array
void AddActiveObject( cSprite *obj );
void AddPassiveObject( cSprite *obj );
void AddEnemyObject( cSprite *obj );
void AddHUDObject( cSprite *obj );
void AddMassiveObject( cSprite *obj );

/* Returns a copied Object
 * with the given position
 * if no position is given default is 0
 */
cSprite *Copy_Object( cSprite *CopyObject, double x = 0, double y = 0 );

 // Gets an Pixel color
Uint32 SDL_GetPixel( SDL_Surface *surface, Sint16 x, Sint16 y );

 // Puts an single Pixel
void SDL_PutPixel( SDL_Surface *Surface, Sint16 x, Sint16 y, Uint32 color );

 // gets the Current computer time
char *Get_Curr_Time( void );

// if effect = 0 then an random effect will be selected
void DrawEffect( unsigned int effect = 0, double speed = 1 ); 

// Checks if an key is pressed on the common keys
bool KeyPressed( unsigned int key ); 

// Clears the input event queue
void ClearEvents( void ); 

// Draws an Hadowed Box
void DrawShadowedBox( SDL_Surface * dst, Sint16 x, Sint16 y, Sint16 w, Sint16 h, Uint8 r, Uint8 g, Uint8 b, Uint8 alpha, 
					 Uint8 shadowsize );
/* an EditBox
 * default_text = the Default Text
 * auto_no_text = if a key is pressed the default text dissapers
 */
string EditMessageBox( string default_text, string title_text, Uint16 pos_x, Uint16 pos_y, bool auto_no_text = 1 );

/* Preloads the common images
 * into the image manager
 */
void Preload_images( void );

// Checks if the first rect intersects with the second
bool RectIntersect( SDL_Rect *r1, SDL_Rect *r2 );
// Checks if the first rect intersects completely with the second
bool FullRectIntersect( SDL_Rect *r1, SDL_Rect *r2 );

/* Deletes the given file returns 1 on success else 0
 * Use with Caution
*/
bool Delete_file( string filename );

// Checks if the file exists
bool valid_file( string filename );

// Locks the given surface
void LockSurface( SDL_Surface *surface );
// Unlocks the given surface
void UnlockSurface( SDL_Surface *surface );

#endif
#ifndef VERSION
#define VERSION "SMC 0.95"
#endif

#ifndef SOUNDS_DIR
#define SOUNDS_DIR "data/sounds"
#endif

#ifndef MUSIC_DIR
#define MUSIC_DIR "data/music"
#endif

#ifndef PIXMAPS_DIR
#define PIXMAPS_DIR "data/pixmaps"
#endif

#ifndef FONT_DIR
#define FONT_DIR "data/font"
#endif

#ifndef OVERWORLD_DIR
#define OVERWORLD_DIR "world"
#endif
