/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef MAIN_H
#define MAIN_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <dirent.h>

#include "SDL.h"
#include "SDL_ttf.h"
#include "SDL_image.h"

#include "computer.h"
#include "draw.h"
#include "types.h"


#define MAX(q, w)  ((q) > (w) ? (q) : (w))
#define MIN(q, w)  ((q) < (w) ? (q) : (w))
#define SIGN(x)  (((x) > 0) ? 1 : (((x) < 0) ? -1 : 0))

#define DATA_DIR  "data/"
#define APP_ICON  DATA_DIR "icon.png"
#define APP_NAME  "Tric-Tac-Toe"
#define SCREEN_W  400
#define SCREEN_H  400
#define BPP  8
#define VIDEO_FLAGS  SDL_SWSURFACE

#define QUIT  1
#define LEAVE_LOOP  2

#define MAX_NAME_LENGTH  40
#define MAX_MESSAGE_LENGTH  80
#define MESSAGE_BORDER_SIZE  2
#define BUTTON_BORDER_SIZE  2

#if SDL_BYTEORDER == SDL_BIG_ENDIAN
# define R_24BIT  0xff0000
# define G_24BIT  0x00ff00
# define B_24BIT  0x0000ff
#else
# define R_24BIT  0x0000ff
# define G_24BIT  0x00ff00
# define B_24BIT  0xff0000
#endif

#define NUM_SAMPLES  6

#define SURFACE_FLAGS  SDL_SWSURFACE
#define FADE_DELTA  4
#define TEXT_MOVE_DELTA  4
#define TITLE_HOLD_COUNT  64
#define NUM_INTROS  3
#define INTRO_FPS_TARGET  40
#define INTRO_OFFSET_DIST  400.0
#define HEX_RADIUS  160.0
#define NUM_CELLS  27
#define NUM_CONNECTORS  27
#define CONNECT_END_RADIUS  4.5
#define POINT_STR_SIZE  4
#define MAX_NUM_PLAYERS  6
#define NUM_PLAYERS  3

#define NUM_PLAYER_HIT_RECTS  10
#define BTN_HIT_RECT  NUM_PLAYERS * NUM_PLAYER_HIT_RECTS
#define NUM_HIT_RECTS  BTN_HIT_RECT + 1

/* Function prototypes */
Sint8 GetCell( int, int );
SDL_Surface *NewSurfaceDefault( int, int );
SDL_Surface *RenderTextDefault( char *, Uint8 );
void InitSDLStuff( void );
void SetGamePalette( void );
void InitMainData( void );
void LoadWave( char *, Uint16 );
void ReadDataFromFile( void );
void CleanupFileError( void );
void WriteDataToFile( void );
void ResetData( void );
void GetPlayerData( void );
void ShowTutorialScreen( void );
void ShowLogo( void );
void ShowGridAnimation( int );
void RenderTurnText( int );
void AudioCallback( void *, Uint8 *, int );
void PlaySound( int, int );
void DrawTriLine( SDL_Surface *, int, int );
int ConnectValue( int, int );
int TestConnection( int, int, int );
int QuitQuery( void );
int DisplayWinMessage( int, int );
void ShowEndScreen( void );
int SetPan( int );
void SetNextPlayer( void );
int PlayerUp( void );
int PointsRemain( int );
void MainLoop( void );
void Quit( int );

#endif  /* MAIN_H */
