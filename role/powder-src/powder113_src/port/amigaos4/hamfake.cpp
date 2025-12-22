/*
 * PROPRIETARY INFORMATION.  This software is proprietary to POWDER
 * Development, and is not to be reproduced, transmitted, or disclosed
 * in any way without written permission.
 *
 * Produced by:	Jeff Lait
 *
 *      	POWDER Development
 *
 * NAME:        hamfake.cpp ( POWDER Library, C++ )
 *
 * COMMENTS:
 *	This file implements all the fake ham functions.
 *	It also stores the global state of the hardware.
 */


#ifdef WIN32
#pragma comment(lib, "SDL.lib")
#pragma comment(lib, "SDLmain.lib")
#endif

#ifdef _WIN32_WCE
#include <windows.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <iostream>

using namespace std;

#include "mygba.h"
#include "hamfake.h"
#include "SDL.h"

#include "../../gfxengine.h"
#include "../../bmp.h"
#include "../../assert.h"
#include "../../buf.h"

#include "../../gfx/icon_sdl.bmp.c"

#define SRAMSIZE 65536

#define KEY_REPEAT_INITIAL 15
#define KEY_REPEAT_AFTER 7

//
// Global GBA state:
//
SDL_Surface	*glbVideoSurface;
bool		 glbFullScreen = false;

#ifdef USING_TILE10
int		 glbScreenWidth = 640;
int		 glbScreenHeight = 480;
//int		 glbScreenWidth = 320;
//int		 glbScreenHeight = 240;
int		 glbTileWidth = 10;
int		 glbTileHeight = 10;
#else
int		 glbScreenWidth = 640;
int		 glbScreenHeight = 480;
//int		 glbScreenWidth = 256;
//int		 glbScreenHeight = 192;
int		 glbTileWidth = 8;
int		 glbTileHeight = 8;
#endif

int		 glbScaleFactor = 1;
int		 glbScreenFudgeX = 0;
int		 glbScreenFudgeY = 0;

int		 glbStylusX = 0, glbStylusY = 0;
bool		 glbStylusState = false;

tile_info_ptr	 glbTheTileSet = 0;

#define TILEWIDTH (glbTileWidth)
#define TILEHEIGHT (glbTileHeight)

#define HAM_SCRW	(TILEWIDTH*HAM_SCRW_T)
#define HAM_SCRH	(TILEWIDTH*HAM_SCRH_T)

struct SPRITEDATA
{
    bool 	active;
    int 	x, y;
    u8		*data;
};

SPRITEDATA	 *glbSpriteList;

#define MAX_SPRITES 128

// Do we have an extra tileset loaded?
bool		 ham_extratileset = false;

// Keyboard state:
bool			glb_keystate[SDLK_LAST];

// Key to push
int			glb_keypusher = 0;
int			glb_keypusherraw = 0;
// Frame to push on.
int			glb_keypushtime = 0;

int			glb_keybuf[16];
s8			glb_keybufentry = -1;

int			glb_keymod = 0;

// Background state:
bg_info			ham_bg[4];

bool			glb_isnewframe = 0, glb_isdirty = false;

u8			glb_palette[2048];

// Mode 3 screen - a raw 15bit bitmap.
u16			*glb_rawscreen = 0;

// Paletted version of screen which is scaled into final SDL surface
// We use u16 as the high bit selects whether to use sprite or
// global palette
u16			*glb_nativescreen = 0;

char			glb_rawSRAM[SRAMSIZE];

int			glb_videomode = -1;

void
rebuildVideoSystemFromGlobals()
{
    int		flags = SDL_RESIZABLE;

    if (glbFullScreen)
	flags |= SDL_FULLSCREEN;

    // Yes, we want a guaranteed 24bit video mode.
    glbVideoSurface = SDL_SetVideoMode(glbScreenWidth, glbScreenHeight, 
				    32, flags);

    if (!glbVideoSurface)
    {
	fprintf(stderr, "Failed to create screen: %s\n",
			SDL_GetError());
	SDL_Quit();
	exit(1);
    }

    // Setup our window environment.
    SDL_WM_SetCaption("POWDER", 0);

    // We want the cursor enabled now that you can click on stuff. 
    // SDL_ShowCursor(SDL_DISABLE);

    glb_isdirty = true;
}

void
hamfake_setFullScreen(bool fullscreen)
{
    // Pretty straight forward :>
    glbFullScreen = fullscreen;

    rebuildVideoSystemFromGlobals();
}

bool
hamfake_isFullScreen()
{
    return glbFullScreen;
}

// Updates our glbScreenWidth & glbScreenHeight appropriately.  Finds a scale
// factor that will fit.
void
setResolution(int width, int height)
{
    // Find maximum scale factor that fits.
    glbScaleFactor = 2;
    while (1)
    {
	glbScreenWidth = HAM_SCRW * glbScaleFactor;
	glbScreenHeight = HAM_SCRH * glbScaleFactor;
	if (glbScreenWidth > width || glbScreenHeight > height)
	{
	    glbScaleFactor--;
	    break;
	}
	glbScaleFactor++;
    }

    glbScreenWidth = width;
    glbScreenHeight = height;

    // Do not allow fractional scales.
    if (glbScreenWidth < HAM_SCRW)
	glbScreenWidth = HAM_SCRW;
    if (glbScreenHeight < HAM_SCRH)
	glbScreenHeight = HAM_SCRH;

    // Calculate our fudge factor...
    glbScreenFudgeX = ((glbScreenWidth - HAM_SCRW * glbScaleFactor) / 2);
    glbScreenFudgeY = ((glbScreenHeight - HAM_SCRH * glbScaleFactor) / 2);

    // Take effect!
    rebuildVideoSystemFromGlobals();
}

void
scaleScreenFromPaletted(u8 *dst, int pitch)
{
    int		x, y, s_y, s_x;
    u8		pixel[3];
    u16		idx;
    u16		*src;

    // Clear initial dst...
    memset(dst, 0, pitch * glbScreenHeight);

    // Add in fudge factor
    dst += glbScreenFudgeX * 3 + glbScreenFudgeY * pitch;

    src = glb_nativescreen;
    for (y = 0; y < HAM_SCRH; y++)
    {
	for (s_y = 0; s_y < glbScaleFactor; s_y++)
	{
	    for (x = 0; x < HAM_SCRW; x++)
	    {
		// Read in a pixel & decode
		idx = src[x];
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
		pixel[0] = glb_palette[idx*4+3];
		pixel[1] = glb_palette[idx*4+2];
		pixel[2] = glb_palette[idx*4+1];
#else
		pixel[0] = glb_palette[idx*4+1];
		pixel[1] = glb_palette[idx*4+2];
		pixel[2] = glb_palette[idx*4+3];
#endif
		// Now write out the needed number of times...
		for (s_x = 0; s_x < glbScaleFactor; s_x++)
		{
		    *dst++ = pixel[0];
		    *dst++ = pixel[1];
		    *dst++ = pixel[2];
		}
	    }
	    // Add remainder of pitch.
	    dst += pitch - 3 * glbScaleFactor * HAM_SCRW;
	}
	src += HAM_SCRW;
    }
}

void
scaleScreenFrom15bit(u8 *dst, int pitch)
{
    int		 x, y, s_y, s_x;
    u8		 pixel[3];
    u16		 raw;
    u16		*src;

    // Clear initial dst...
    memset(dst, 0, pitch * glbScreenHeight);

    // Add in fudge factor
    dst += glbScreenFudgeX * 3 + glbScreenFudgeY * pitch;

    src = glb_rawscreen;
    for (y = 0; y < HAM_SCRH; y++)
    {
	for (s_y = 0; s_y < glbScaleFactor; s_y++)
	{
	    for (x = 0; x < HAM_SCRW; x++)
	    {
		// Read in a pixel & decode
		raw = src[x];

#if SDL_BYTEORDER == SDL_BIG_ENDIAN
		pixel[0] = (raw & 31) << 3;
		pixel[1] = ((raw >> 5) & 31) << 3;
		pixel[2] = ((raw >> 10) & 31) << 3;
#else
		pixel[2] = (raw & 31) << 3;
		pixel[1] = ((raw >> 5) & 31) << 3;
		pixel[0] = ((raw >> 10) & 31) << 3;
#endif

		// Now write out the needed number of times...
		for (s_x = 0; s_x < glbScaleFactor; s_x++)
		{
		    *dst++ = pixel[0];
		    *dst++ = pixel[1];
		    *dst++ = pixel[2];
		}
	    }
	    // Add remainder of pitch.
	    dst += pitch - 3 * glbScaleFactor * HAM_SCRW;
	}
	src += HAM_SCRW;
    }
}

// Draws the given sprite to the native buffer.
void
blitSprite(const SPRITEDATA &sprite)
{
    if (sprite.active)
    {
	// Finally, blit the sprite.
	int		sx, sy, x, y, tx, ty, srcoffset;
	u8		src;

	for (sy = 0; sy < TILEHEIGHT*2; sy++)
	{
	    for (sx = 0; sx < TILEWIDTH*2; sx++)
	    {
		x = sprite.x + sx;
		y = sprite.y + sy;
		// Convert to DS coords from GBA
		x += TILEWIDTH;
		y += 2*TILEHEIGHT;

		tx = (sx >= TILEWIDTH) ? 1 : 0;
		ty = (sy >= TILEHEIGHT) ? 1 : 0;
		srcoffset = sx + tx * TILEWIDTH * (TILEHEIGHT-1) +
			    ty * 1 * TILEWIDTH * (TILEHEIGHT) + sy * TILEWIDTH;
		src = sprite.data[srcoffset];
		if (src &&
		    x >= 0 && x < HAM_SCRW &&
		    y >= 0 && y < HAM_SCRH)
		{
		    glb_nativescreen[x + y * HAM_SCRW] = src + 256;
		}
	    }
	}
    }
}

void
hamfake_rebuildScreen()
{
    int			i, layer, x, y, tileidx, tx, ty, px, py;
    int			offset;

    if (!glb_isdirty)
	return;

    glb_isdirty = false;
    
    if (glb_videomode == 3)
    {
	u8		*dst;

	SDL_LockSurface(glbVideoSurface);

	dst = (u8 *) glbVideoSurface->pixels;
	if (!dst)
	{
	    printf("Lock failure: %s\n", SDL_GetError());
	}

	scaleScreenFrom15bit(dst, glbVideoSurface->pitch);

	SDL_UnlockSurface(glbVideoSurface);
	// Rebuild from 15bit screen.
	SDL_UpdateRect(glbVideoSurface, 0, 0, 0, 0);
	return;
    }

    // Clear our video surface.
    memset(glb_nativescreen, 0, HAM_SCRH * HAM_SCRW * sizeof(u16));

    // Blit each layer in turn.
    // Hard coded layer order:
    int		lay_ord[4] = { 1, 2, 3, 0 };
    for (i = 0; i < 4; i++)
    {
	layer = lay_ord[i];

	ty = ham_bg[layer].scrolly;
	if (ty < 0)
	    ty = - ((-ty + TILEHEIGHT-1) / TILEHEIGHT);
	else
	    ty = (ty + TILEHEIGHT-1) / TILEHEIGHT;
	py = ham_bg[layer].scrolly % TILEHEIGHT;
	if (py < 0)
	{
	    ty++;
	    py += TILEHEIGHT;
	}

	ty %= ham_bg[layer].mi->height;
	if (ty < 0)
	    ty += ham_bg[layer].mi->height;

	for (y = (py ? 1 : 0); y < HAM_SCRH_T; y++)
	{
	    tx = ham_bg[layer].scrollx;
	    if (tx < 0)
		tx = - ((-tx + TILEWIDTH-1) / TILEWIDTH);
	    else
		tx = (tx + TILEWIDTH-1) / TILEWIDTH;
	    px = ham_bg[layer].scrollx % TILEWIDTH;
	    if (px < 0)
	    {
		px += TILEWIDTH;
		tx++;
	    }

	    tx %= ham_bg[layer].mi->width;
	    if (tx < 0)
		tx += ham_bg[layer].mi->width;
	    
	    for (x = (px ? 1 : 0); x < HAM_SCRW_T; x++)
	    {
		u8		*tile;

		tileidx = ham_bg[layer].mi->tiles[ty * ham_bg[layer].mi->width + tx];
		    
		// Out of bound tiles are ignored.
		if ((tileidx & 1023) < ham_bg[layer].ti->numtiles)
		{
		    tile = ham_bg[layer].ti->tiles[tileidx & 1023];

		    // Compute offset into native screen
		    // This computation is very suspect and has only
		    // been vetted with px == 4, so may not work with
		    // other sub pixel scroll values.
		    offset = x * TILEWIDTH - px + (y * TILEHEIGHT - py) * HAM_SCRW;

		    // Figure out any flip flags.
		    if (tileidx & (2048 | 1024))
		    {
			int	    sx, sy, fx, fy;

			for (sy = 0; sy < TILEHEIGHT; sy++)
			{
			    if (tileidx & 2048)
				fy = TILEHEIGHT-1 - sy;
			    else
				fy = sy;

			    for (sx = 0; sx < TILEWIDTH; sx++)
			    {
				if (tileidx & 1024)
				    fx = TILEWIDTH-1 - sx;
				else
				    fx = sx;

				// Write if non-zero
				if (tile[fx + fy * TILEWIDTH])
				    glb_nativescreen[offset] = tile[fx + fy * TILEWIDTH];
				offset++;
			    }
			    offset += HAM_SCRW - TILEWIDTH;
			}
		    }
		    else
		    {
			int		sx, sy;

			// Straight forward write...
			for (sy = 0; sy < TILEHEIGHT; sy++)
			{
			    for (sx = 0; sx < TILEWIDTH; sx++)
			    {
				if (*tile)
				{
				    glb_nativescreen[offset] = *tile;
				}
				tile++;
				offset++;
			    }
			    offset += HAM_SCRW - TILEWIDTH;
			}
		    }
		}
		
		tx++;
		if (tx >= ham_bg[layer].mi->width)
		    tx -= ham_bg[layer].mi->width;
	    }

	    ty++;
	    if (ty >= ham_bg[layer].mi->height)
		ty -= ham_bg[layer].mi->height;
	}

	// Just before the text layer we draw our sprites
	// This ensures the buttons are under the text.
	if (i == 2)
	{
	    int		j;

	    // Since we composite on top, we want to do in reverse order of
	    // priority.  Hence the backwards loop.
	    // The last sprite is the cursor and is done at the very end.
	    for (j = MAX_SPRITES; j --> 1; )
	    {
		blitSprite(glbSpriteList[j]);
	    }
	}
    }

    // Draw the cursor sprite
    blitSprite(glbSpriteList[0]);

    // Lock and update the final surface using our lookup...
    {
	u8		*dst;

	SDL_LockSurface(glbVideoSurface);
	dst = (u8 *) glbVideoSurface->pixels;
	if (!dst)
	{
	    printf("Lock failure: %s\n", SDL_GetError());
	}

	scaleScreenFromPaletted(dst, glbVideoSurface->pitch);

	SDL_UnlockSurface(glbVideoSurface);
	// Rebuild from 8bit screen.
	SDL_UpdateRect(glbVideoSurface, 0, 0, 0, 0);
    }
}

// Converts a unicode key into an ASCII key.
int
processSDLKey(int unicode, int sdlkey)
{
#ifdef _WIN32_WCE
    // Windows CE defines some hard-coded buttons we
    // want to re-interpret
    // Ideally we'd handle these remaps using an actual
    // new defaults for the character mapping, but since POWDER
    // is still all 1970's with hardcoded key definitions, we'll
    // suffer with this for now.
    switch (unicode)
    {
	case 'r':
	    return '\x1b';
	case 'p':
	    return 'g';
	case 'q':
	    return 'x';
	case 's':
	    return 'm';

	// Shortcut buttons
	case 193:
	    return 'O';
	case 195:
	    return '\x1b';
	case 194:
	    return 'V';
	case 196:
	    return 'i';
    }
#endif

    // Check to see if we are intelligble unicode.
    if (unicode && unicode < 128)
    {
	// The control characters usually report as unicode
	// values, we want to instead treat these as the normal
	// lower case alpha just with the ctrl- modifier set.
	// This then allows control to be a modifier on any
	// normal key.
	if (unicode < ' ')
	{
	    if (sdlkey >= SDLK_a && sdlkey <= SDLK_z)
	    {
		return 'a' + sdlkey - SDLK_a;
	    }
	}
	return unicode;
    }

    // Process stupid exceptions.
    switch (sdlkey)
    {
	// The mac often ships without a backspace key.  Out of laziness,
	// alias delete to backspace
	case SDLK_DELETE:
	    return '\b';
	// Insert several curses here...  This isn't necessary
	// anywhere except WIndows XP it seems...
	case SDLK_KP0:
	    return '0';
	case SDLK_KP1:
	    return '1';
	case SDLK_KP2:
	    return '2';
	case SDLK_KP3:
	    return '3';
	case SDLK_KP4:
	    return '4';
	case SDLK_KP5:
	    return '5';
	case SDLK_KP6:
	    return '6';
	case SDLK_KP7:
	    return '7';
	case SDLK_KP8:
	    return '8';
	case SDLK_KP9:
	    return '9';
	case SDLK_UP:
	    return GFX_KEYUP;
	case SDLK_DOWN:
	    return GFX_KEYDOWN;
	case SDLK_LEFT:
	    return GFX_KEYLEFT;
	case SDLK_RIGHT:
	    return GFX_KEYRIGHT;
	case SDLK_PAGEUP:
	    return GFX_KEYPGUP;
	case SDLK_PAGEDOWN:
	    return GFX_KEYPGDOWN;
	case SDLK_F1:
	    return GFX_KEYF1;
	case SDLK_F2:
	    return GFX_KEYF2;
	case SDLK_F3:
	    return GFX_KEYF3;
	case SDLK_F4:
	    return GFX_KEYF4;
	case SDLK_F5:
	    return GFX_KEYF5;
	case SDLK_F6:
	    return GFX_KEYF6;
	case SDLK_F7:
	    return GFX_KEYF7;
	case SDLK_F8:
	    return GFX_KEYF8;
	case SDLK_F9:
	    return GFX_KEYF9;
	case SDLK_F10:
	    return GFX_KEYF10;
	case SDLK_F11:
	    return GFX_KEYF11;
	case SDLK_F12:
	    return GFX_KEYF12;
	case SDLK_F13:
	    return GFX_KEYF13;
	case SDLK_F14:
	    return GFX_KEYF14;
	case SDLK_F15:
	    return GFX_KEYF15;
    }

    // Failed to parse key, 0.
    return 0;
}

// Wait for an event to occur.
void
hamfake_awaitEvent()
{
    SDL_WaitEvent(0);
}

// Return our internal screen.
u16 *
hamfake_lockScreen()
{
    // Note we have to offset to the normal GBA start
    // location to account for our official offset.
    return glb_rawscreen + TILEWIDTH + 2*TILEHEIGHT * HAM_SCRW;
}

void
hamfake_unlockScreen(u16 *)
{
    glb_isdirty = true;
}

// Deal with our SRAM buffer.
char *
hamfake_writeLockSRAM()
{
    return glb_rawSRAM;
}

void
hamfake_writeUnlockSRAM(char *)
{
}

char *
hamfake_readLockSRAM()
{
    return glb_rawSRAM;
}

void
hamfake_readUnlockSRAM(char *)
{
}

void
hamfake_endWritingSession()
{
    FILE		*fp;

    fp = hamfake_fopen("powder.sav", "wb");

    if (!fp)
    {
	fprintf(stderr, "Failure to open powder.sav for writing!\r\n");
	return;
    }

    fwrite(glb_rawSRAM, SRAMSIZE, 1, fp);

    fclose(fp);
}

void
processKeyMod(int mod)
{
    if (mod & KMOD_CTRL || mod & KMOD_META)
	glb_keymod |= GFX_KEYMODCTRL;
    else
	glb_keymod &= ~GFX_KEYMODCTRL;

    if (mod & KMOD_SHIFT)
	glb_keymod |= GFX_KEYMODSHIFT;
    else
	glb_keymod &= ~GFX_KEYMODSHIFT;

    // Modal-T?  Is that a type of car?
    if (mod & KMOD_ALT)
	glb_keymod |= GFX_KEYMODALT;
    else
	glb_keymod &= ~GFX_KEYMODALT;
}

// Called to run our event poll
void
hamfake_pollEvents()
{
    SDL_Event	event;
    int		cookedkey;

    while (SDL_PollEvent(&event))
    {
	switch (event.type)
	{
	    case SDL_VIDEORESIZE:
		setResolution(event.resize.w, event.resize.h);
		break;
	    case SDL_KEYDOWN:
		if (event.key.keysym.sym < SDLK_LAST)
		{
		    glb_keystate[event.key.keysym.sym] = 1;

		    cookedkey = processSDLKey(event.key.keysym.unicode, event.key.keysym.sym);
		    processKeyMod(event.key.keysym.mod);

		    // What sort of drunk would insert the keypress
		    // on a key up?
 		    hamfake_insertKeyPress(cookedkey);

		    if (cookedkey)
		    {
			glb_keypushtime = gfx_getframecount() + KEY_REPEAT_INITIAL;
			glb_keypusher = cookedkey;
		        glb_keypusherraw = event.key.keysym.sym;
		    }
		}
		break;
	    case SDL_KEYUP:
		if (event.key.keysym.sym < SDLK_LAST)
		{
		    glb_keystate[event.key.keysym.sym] = 0;

		    // Sadly, unicode is *not* cooked on a keyup!
		    // Damn SDL!
		    // Thus, we always clear out on a key going high.
		    // cookedkey = processSDLKey(event.key.keysym.unicode);
		    // This will annoy copx, however, so we instead
		    // stop being lazy and store the original raw code.

		    // If our currently repeated key goes high,
		    // clear it out.
		    if (event.key.keysym.sym  == glb_keypusherraw)
		    {
			glb_keypusher = 0;
		    }
		}
		break;

	    case SDL_MOUSEMOTION:
	    {
		glbStylusX = event.motion.x;
		glbStylusY = event.motion.y;
		
		int x, y;
		hamfake_getstyluspos(x, y);
		break;
	    }
		
	    case SDL_MOUSEBUTTONDOWN:
		glbStylusX = event.button.x;
		glbStylusY = event.button.y;
		cookedkey = 0;
		switch (event.button.button)
		{
		    case SDL_BUTTON_LEFT:
			cookedkey = GFX_KEYLMB;
			glbStylusState = true;
			break;
		    case SDL_BUTTON_MIDDLE:
			cookedkey = GFX_KEYMMB;
			break;
		    case SDL_BUTTON_RIGHT:
			cookedkey = GFX_KEYRMB;
			break;
		}
		if (cookedkey)
		{
		    hamfake_insertKeyPress(cookedkey);
		    glb_keypushtime = gfx_getframecount() + KEY_REPEAT_INITIAL;
		    glb_keypusher = cookedkey;
		    // Special value for these...
		    glb_keypusherraw = -cookedkey;
		}
		break;

	    case SDL_MOUSEBUTTONUP:
		glbStylusX = event.button.x;
		glbStylusY = event.button.y;
		cookedkey = 0;
		switch (event.button.button)
		{
		    case SDL_BUTTON_LEFT:
			glbStylusState = false;
			cookedkey = GFX_KEYLMB;
			break;
		    case SDL_BUTTON_MIDDLE:
			cookedkey = GFX_KEYMMB;
			break;
		    case SDL_BUTTON_RIGHT:
			cookedkey = GFX_KEYRMB;
			break;
		}
		// Wipe out the pusher if we match.
		if (-cookedkey == glb_keypusherraw)
		{
		    glb_keypusher = 0;
		}
		break;

	    case SDL_QUIT:
		SDL_Quit();
		exit(0);
		break;
	}
    }

    // After chewing up all the events, we pump the keyboard repeat
    // This ensures it is the same thread as the keyboard repeat
    // set up.  It also ensures that if we are stalling on the main
    // thread, so weren't able to respond to the users key up command,
    // we will not send extra keys.
    // It is reasoned that extra repeats are more frustrating than
    // missed repeats.
    {
	int			frame;

	frame = gfx_getframecount();
	if (glb_keypusher)
	{
	    if (frame >= glb_keypushtime)
	    {
		hamfake_insertKeyPress(glb_keypusher);
		glb_keypushtime = frame + KEY_REPEAT_AFTER;
	    }
	}
    }
}

bool
hamfake_isPressed(SDLKey key)
{
    hamfake_pollEvents();
    hamfake_rebuildScreen();

    if (key >= SDLK_LAST)
	return false;

    return (glb_keystate[key]);
}

int
hamfake_isAnyPressed()
{
    hamfake_pollEvents();
    hamfake_rebuildScreen();

    int			i;
    for (i = 0; i < SDLK_LAST; i++)
	if (glb_keystate[i]) return 0x0;
    return 0x3FF;
}

int
hamfake_peekKeyPress()
{
    hamfake_pollEvents();
    hamfake_rebuildScreen();

    // Nothing available.
    if (glb_keybufentry < 0)
	return 0;

    return glb_keybuf[0];
}

int
hamfake_getKeyModifiers()
{
    hamfake_pollEvents();
    hamfake_rebuildScreen();

    return glb_keymod;
}

int
hamfake_getKeyPress(bool onlyascii)
{
    hamfake_pollEvents();
    hamfake_rebuildScreen();

    // Nothing available.
    if (glb_keybufentry < 0)
	return 0;

    int		newkey;

    newkey = glb_keybuf[0];

    // Eat up the keys.
    if (glb_keybufentry)
	memmove(glb_keybuf, &glb_keybuf[1], glb_keybufentry * sizeof(int));

    glb_keybufentry--;

    // If the key isn't ascii and we only want ascii, eat the key and try
    // again.
    if (onlyascii && newkey > 255)
    {
	return hamfake_getKeyPress(onlyascii);
    }

    return newkey;
}

void
hamfake_insertKeyPress(int key)
{
    // Ignore illegal keys.
    if (!key)
	return;
    
    if (glb_keybufentry < 15)
    {
	glb_keybuf[glb_keybufentry+1] = key;
	glb_keybufentry++;
    }
}

void
hamfake_clearKeyboardBuffer()
{
    // Stop pushing keys!
    glb_keypusher = 0;
    // Flush the buffer!
    glb_keybufentry = -1;
    // Release the stylus
    glbStylusState = false;
}

void
hamfake_setScrollX(int layer, int scroll)
{
    ham_bg[layer].scrollx = scroll;	
}

void
hamfake_setScrollY(int layer, int scroll)
{
    ham_bg[layer].scrolly = scroll;	
}

u8 *
convertTo32Bit(const unsigned short *s, int numpixel)
{
    u8 		*result, *d;
    unsigned short	 p;

    result = (u8 *) malloc(numpixel * 4);
    d = result;
    
    while (numpixel--)
    {
	p = *s++;
	*d++ = (p & 31) * 8 + 4;
	p >>= 5;
	*d++ = (p & 31) * 8 + 4;
	p >>= 5;
	*d++ = (p & 31) * 8 + 4;
	*d++ = 0xff;
    }
    return result;
}

#ifdef CHANGE_WORK_DIRECTORY
// This is Linux friendly.
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>

const char *
gethomedir()
{
    static char *home = 0;

    if (!home)
	home = getenv("HOME");
    if (!home)
    {
	struct passwd *pw = getpwuid(getuid());
	if (pw) home = pw->pw_dir;
    }

    return home;
}

bool
changeworkdir()
{
    struct stat buffer;
    int status;

    const char *home = gethomedir();
    if (!home)
    {
	fprintf(stderr, "Error finding home directory.\r\n");
	return false;
    }

    if (chdir(home))
    {
	perror("Changing home directory");
	return false;
    }

    const char *powderdir = ".powder";

    status = stat(powderdir, &buffer);
    if (status)
    {
	if (mkdir(powderdir, S_IRWXU | S_IRWXG | S_IRWXO))
	{
	    perror(powderdir);
	    return false;
	}
    }
    else if (!S_ISDIR(buffer.st_mode))
    {
	fprintf(stderr, "~/%s is not a directory!\r\n", powderdir);
	return false;
    }

    return !chdir(powderdir);
}
#endif

void
ham_Init()
{
    int		i;
    
    printf("\nPOWDER initializing...\n");

#ifdef CHANGE_WORK_DIRECTORY
    if (!changeworkdir())
    {
	fprintf(stderr, "Failed to initialize ~/.powder\r\n");
	exit(-1);
    }
#endif

    /* initialize SDL */
    if ( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_TIMER ) < 0 )
    {
	    fprintf( stderr, "Video initialization failed: %s\n",
		    SDL_GetError( ) );
	    SDL_Quit( );
    }

    u8 *rgbpixel;

    rgbpixel = convertTo32Bit(bmp_icon_sdl, 32 * 32);

    /* SDL interprets each pixel as a 32-bit number, so our masks must depend
       on the endianness (byte order) of the machine */
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
    const Uint32 rmask = 0xff000000;
    const Uint32 gmask = 0x00ff0000;
    const Uint32 bmask = 0x0000ff00;
    const Uint32 amask = 0x000000ff;
#else
    const Uint32 rmask = 0x000000ff;
    const Uint32 gmask = 0x0000ff00;
    const Uint32 bmask = 0x00ff0000;
    const Uint32 amask = 0xff000000;
#endif

    SDL_Surface *surf = SDL_CreateRGBSurfaceFrom((char *)rgbpixel, 32, 32, 32, 32*4,
			    rmask, gmask, bmask, amask);

    SDL_WM_SetIcon(surf, NULL);
    
    SDL_EnableUNICODE(1);

    glbSpriteList = new SPRITEDATA[MAX_SPRITES]; 
    for (i = 0; i < MAX_SPRITES; i++)
    {
	glbSpriteList[i].active = false;
	glbSpriteList[i].data = new u8[TILEWIDTH * TILEHEIGHT * 4];
    }

    memset(glb_keystate, 0, SDLK_LAST);

    glb_rawscreen = new u16[HAM_SCRW*HAM_SCRH];
    memset(glb_rawscreen, 0, HAM_SCRW*HAM_SCRH*sizeof(u16));
    glb_nativescreen = new u16[HAM_SCRW*HAM_SCRH];

    // Load any save games.
    FILE	*fp;

    fp = hamfake_fopen("powder.sav", "rb");
    if (fp)
    {
	fread(glb_rawSRAM, SRAMSIZE, 1, fp);
	fclose(fp);
    }

    // Load any extra tilesets.
    if (bmp_loadExtraTileset())
    {
	ham_extratileset = true;
	printf("External tileset loaded.\n");
    }
    
    return;
}

void (*glb_vblcallback)() = 0;

Uint32
glb_VBLTimerCallback(Uint32 interval, void *fp)
{
    glb_isnewframe = 1;
    (*glb_vblcallback)();

    // Push a fake event so we wake up.
    SDL_Event		event;

    event.type = SDL_USEREVENT;
    SDL_PushEvent(&event);
    
    return 16;
}

void
ham_StartIntHandler(u8 intno, void (*fp)())
{
    assert(intno == INT_TYPE_VBL);
    
    glb_vblcallback = fp;
    SDL_AddTimer(16, glb_VBLTimerCallback, 0);
}

void
ham_SetBgMode(u8 mode)
{
    if (glb_videomode == -1)
    {
#ifdef _WIN32_WCE
	// For mobiles we want to default to the lowest res.
	setResolution(HAM_SCRW, HAM_SCRH);
#else
	setResolution(HAM_SCRW * 2, HAM_SCRH * 2);
#endif
	rebuildVideoSystemFromGlobals();
    }

    glb_videomode = mode;
}


void
ham_LoadBGPal(void *vpal, int bytes)
{
    // Need to promote our 15bit palette to a 24 bit one.
    int		entries = bytes / 2, i;
    u16		*pal = (u16 *) vpal;

    for (i = 0; i < entries; i++)
    {
	glb_palette[i*4+3] = (pal[i] & 31) << 3;
	glb_palette[i*4+2] = ((pal[i] >> 5) & 31) << 3;
	glb_palette[i*4+1] = ((pal[i] >> 10) & 31) << 3;
	if (i)
	    glb_palette[i*4] = 255;
	else
	    glb_palette[i*4] = 0;
    }
}

map_info_ptr
ham_InitMapEmptySet(u8 size, u8 )
{
    map_info_ptr		mi;

    mi = new map_info;
    
    if (size == 0)
    {
	mi->width = 32;
	mi->height = 32;
    }
    else
    {
	mi->width = 64;
	mi->height = 64;
    }

    mi->tiles = new int[mi->width * mi->height];
    memset(mi->tiles, 0, sizeof(int) * mi->width * mi->height);
    
    return mi;
}

tile_info_ptr
ham_InitTileEmptySet(int entries, int , int)
{
    tile_info_ptr		ti;
    int				i;

    ti = new tile_info;
    ti->numtiles = entries;
    ti->tiles = new u8 *[entries];

    for (i = 0; i < entries; i++)
    {
	ti->tiles[i] = new u8 [TILEWIDTH * TILEHEIGHT];
    }
    glbTheTileSet = ti;
    return ti;
}

void
ham_InitBg(int layer, int foo, int bar, int baz)
{
    ham_bg[layer].scrollx = 0;	
    ham_bg[layer].scrolly = 0;	
}

void
ham_CreateWin(int , int, int, int, int, int, int, int)
{
}

void
ham_DeleteWin(int wid)
{
}

void
ham_SetMapTile(int layer, int mx, int my, int tileidx)
{
    map_info_ptr		mi;

    mi = ham_bg[layer].mi;

    mx = (mx % mi->width);
    if (mx < 0)
	mx += mi->width;
    my = (my % mi->height);
    if (my < 0)
	my += mi->height;

    mi->tiles[mx + my * mi->width] = tileidx;

    glb_isdirty = true;
}

void
hamfake_setTileSize(int tilewidth, int tileheight)
{
    int			i;
    
    glbTileWidth = tilewidth;
    glbTileHeight = tileheight;

    delete [] glb_rawscreen;
    delete [] glb_nativescreen;
    glb_rawscreen = new u16[HAM_SCRW*HAM_SCRH];
    memset(glb_rawscreen, 0, HAM_SCRW*HAM_SCRH*sizeof(u16));
    glb_nativescreen = new u16[HAM_SCRW*HAM_SCRH];

    for (i = 0; glbTheTileSet && (i < glbTheTileSet->numtiles); i++)
    {
	delete [] glbTheTileSet->tiles[i];
	glbTheTileSet->tiles[i] = new u8 [TILEWIDTH * TILEHEIGHT];
    }

    for (i = 0; i < MAX_SPRITES; i++)
    {
	delete [] glbSpriteList[i].data;
	glbSpriteList[i].data = new u8[TILEWIDTH * TILEHEIGHT * 4];
    }
    setResolution(glbScreenWidth, glbScreenHeight);
}

void
ham_ReloadTileGfx(tile_info_ptr tiledata, const u16 *data, int destidx, 
		  int numtile)
{
    int		 t;
    u8		*raw;
    u8		*dst;

    raw = (u8*) data;
    for (t = destidx; t < destidx + numtile; t++)
    {
	dst = tiledata->tiles[t];
	
	memcpy(dst, raw, TILEWIDTH*TILEHEIGHT);
	raw += TILEWIDTH*TILEHEIGHT;
    }
    glb_isdirty = true;
}

void
hamfake_ReloadSpriteGfx(const u16 *data, int tileno, int numtile)
{
    tileno /= 4;
    UT_ASSERT(tileno >= 0 && tileno < MAX_SPRITES);
    if (tileno < 0 || tileno >= MAX_SPRITES)
	return;

    memcpy(glbSpriteList[tileno].data, data, numtile * TILEWIDTH*TILEHEIGHT);
    glb_isdirty = true;
}

void
hamfake_LoadSpritePal(void *vpal, int bytes)
{
    // Need to promote our 15bit palette to a 24 bit one.
    int		entries = bytes / 2, i;
    u16		*pal = (u16 *) vpal;

    for (i = 0; i < entries; i++)
    {
	glb_palette[1024+i*4+3] = (pal[i] & 31) << 3;
	glb_palette[1024+i*4+2] = ((pal[i] >> 5) & 31) << 3;
	glb_palette[1024+i*4+1] = ((pal[i] >> 10) & 31) << 3;
	if (i)
	    glb_palette[1024+i*4] = 255;
	else
	    glb_palette[1024+i*4] = 0;
    }
    glb_isdirty = true;
}

void
hamfake_softReset()
{
    SDL_Quit();
    exit(0);
}

bool
hamfake_extratileset()
{
    return ham_extratileset;
}

void
hamfake_getstyluspos(int &x, int &y)
{
    x = glbStylusX;
    y = glbStylusY;
    // Convert accordint to our scale.
    x -= glbScreenFudgeX;
    y -= glbScreenFudgeY;
    x /= glbScaleFactor;
    y /= glbScaleFactor;
    // After conversion we can be out of the valid bounds.
    if (x < 0)
	x = 0;
    if (y < 0)
	y = 0;
    if (x >= HAM_SCRW)
	x = HAM_SCRW-1;
    if (y >= HAM_SCRH)
	y = HAM_SCRH-1;

    // Now return to the GBA coordinate system by adjusting for the DS coords.
    x -= TILEWIDTH;
    y -= 2*TILEHEIGHT;
}

bool
hamfake_getstylusstate()
{
    return glbStylusState;
}

void
hamfake_movesprite(int spriteno, int x, int y)
{
    UT_ASSERT(spriteno >= 0 && spriteno < MAX_SPRITES);
    if (spriteno < 0 || spriteno >= MAX_SPRITES)
	return;
    glb_isdirty = true;
    glbSpriteList[spriteno].x = x;
    glbSpriteList[spriteno].y = y;
}

void
hamfake_enablesprite(int spriteno, bool enabled)
{
    UT_ASSERT(spriteno >= 0 && spriteno < MAX_SPRITES);
    if (spriteno < 0 || spriteno >= MAX_SPRITES)
	return;
    glb_isdirty = true;
    glbSpriteList[spriteno].active = enabled;
}

FILE *
hamfake_fopen(const char *path, const char *mode)
{
#ifdef _WIN32_WCE
    // No concept of current directory in Windows CE, so we
    // hard code into their documents.
    BUF		fullpath;
    CreateDirectory(L"\\My Documents", NULL);
    CreateDirectory(L"\\My Documents\\POWDER", NULL);
    fullpath.sprintf("\\My Documents\\POWDER\\%s", path);

    return fopen(fullpath.buffer(), mode);
#else
    // Use the local directory on these platforms.
    return fopen(path, mode);
#endif
}

bool
hamfake_fatvalid()
{
    return true;
}
