/******************************************************************************
BINIAX GRAPHICS-RELATED DEFINITIONS
COPYRIGHT JORDAN TUZSUZOV, (C) 2005.
******************************************************************************/

#ifndef _BNX_GFX_H
#define _BNX_GFX_H

/******************************************************************************
INCLUDES
******************************************************************************/

#include "inc.h"

#include <SDL.h>

/******************************************************************************
GRAPHICS CONSTANTS
******************************************************************************/

#define cGfxScreenX		640
#define cGfxScreenY		480
#define cGfxColorDepth	16

#define cGfxZeroX		16
#define cGfxZeroY		424
#define cGfxNextPlusX	48
#define cGfxShieldPlusX	39

#define cGfxPairPlusX	128
#define cGfxPairPlusY	-64

#define cGfxPlayerPlusX	24

#define cGfxFontSizeX	16
#define cGfxFontSizeY	20
#define cGfxFontTileX	14
#define cGfxFontTileY	10

#define cGfxInfoBar		30
#define cGfxSpraySize	5
#define cGfxSpray		300

#define cGfxScoreX		4
#define cGfxScoreY		4
#define cGfxBestX		290
#define cGfxBestY		4

#define cGfxOptionX		220
#define cGfxOptionY		300

#define cGfxGameoverX	150
#define cGfxGameoverY	210

#define cGfxShake		3
#define cGfxCursors		2

#define cGfxCursorSpeed	3

/******************************************************************************
LOCAL GRAPHICS DATA (VIDEO BUFFERS, IMAGES, FONTS, ETC.)
******************************************************************************/

typedef struct BNX_GFX
{
	SDL_Surface *screen;

	SDL_Surface	*splash;
	SDL_Surface	*gameover;

	SDL_Surface	*options[ cMaxOptions ];

	SDL_Surface *background;
	SDL_Surface *elements[ cMaxElements ];
	SDL_Surface *shield;
	SDL_Surface *cursors[ cGfxCursors ];

	SDL_Surface	*font;

} BNX_GFX;

/******************************************************************************
PUBLIC FUNCTIONS
******************************************************************************/

BNX_BOOL gfxInit();

void gfxUpdate();

void gfxRenderMenu( const BNX_INT16 option );

void gfxRenderGame( const BNX_GAME *game );

void gfxPrintText( BNX_INT16 x, BNX_INT16 y, const char *text );

/******************************************************************************
HELPER FUNCTIONS
******************************************************************************/

#endif
