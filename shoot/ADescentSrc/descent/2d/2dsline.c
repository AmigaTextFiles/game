/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/2d/2dsline.c,v $
 * $Revision: 1.4 $
 * $Author: nobody $
 * $Date: 1998/11/09 22:20:05 $
 *
 * Graphical routines for drawing solid scanlines.
 *
 * $Log: 2dsline.c,v $
 * Revision 1.4  1998/11/09 22:20:05  nobody
 * *** empty log message ***
 *
 * Revision 1.3  1998/09/26 15:00:02  nobody
 * Added Warp3D support
 *
 * Revision 1.2  1998/03/30 18:24:31  hfrieden
 * ViRGE direct rendering added
 *
 * Revision 1.1.1.1  1998/03/03 15:11:45  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:21:23  hfrieden
 * Initial Import
 *
 */

#include "mem.h"
#include "gr.h"
#include "grdef.h"
#include "asmdraw.h"
#ifdef VIRGIN
#include <exec/types.h>
#include "VirgeTexture.h"
#endif

#ifdef WARP3D
#include "Warp3D.h"
#endif

int Gr_scanline_darkening_level = GR_FADE_LEVELS;

void gr_linear_darken( ubyte * dest, int darkening_level, int count, ubyte * fade_table )
{
	int i;

	for (i=0; i<count; i++ )    {
		*dest = fade_table[*dest+(darkening_level*256)];
		dest++;
	}
}

void gr_linear_stosd( ubyte * dest, ubyte color, int count )
{
	int i, x;

	if (count > 3) {            
		while ((int)(dest) & 0x3) { *dest++ = color; count--; };
		if (count >= 4) {
			x = (color << 24) | (color << 16) | (color << 8) | color;
			while (count > 4) { *(int *)dest = x; dest += 4; count -= 4; };
		}
		while (count > 0) { *dest++ = color; count--; };
	} else {
		for (i=0; i<count; i++ )
			*dest++ = color;
	}
}

void gr_uscanline( int x1, int x2, int y )
{
//  memset(DATA + ROWSIZE*y + x1, COLOR, x2-x1+0);
//
	if (Gr_scanline_darkening_level >= GR_FADE_LEVELS ) {
		gr_linear_stosd( DATA + ROWSIZE*y + x1, COLOR, x2-x1+1);
	} else {
		gr_linear_darken( DATA + ROWSIZE*y + x1, Gr_scanline_darkening_level, x2-x1+1, gr_fade_table);
	}
}

void gr_scanline( int x1, int x2, int y )
{
	if ((y<0)||(y>MAXY)) return;

	if (x2 < x1 ) x2 ^= x1 ^= x2;

	if (x1 > MAXX) return;
	if (x2 < MINX) return;

	if (x1 < MINX) x1 = MINX;
	if (x2 > MAXX) x2 = MAXX;

//  memset(DATA + ROWSIZE*y + x1, COLOR, x2-x1+1);
//  
	if (Gr_scanline_darkening_level >= GR_FADE_LEVELS ) {
		gr_linear_stosd( DATA + ROWSIZE*y + x1, COLOR, x2-x1+1);
	} else {
		gr_linear_darken( DATA + ROWSIZE*y + x1, Gr_scanline_darkening_level, x2-x1+1, gr_fade_table);
	}
}

#if defined(VIRGIN)
void gr_direct_linear_darken( UWORD * dest, int darkening_level, int count, ubyte * fade_table )
{
	int i;
	extern UWORD BitValues[256];

	for (i=0; i<count; i++ )    {
		*dest = BitValues[fade_table[*dest+(darkening_level*256)]];
		dest++;
	}
}

void gr_direct_scanline( int x1, int x2, int y )
{
	extern int VirgePixelsPerRow;
	extern UWORD BitValues[256];

	UWORD *RenderBuffer = VirgeGetBuffer();

	UWORD FGColor = BitValues[COLOR];


	if ((y<0)||(y>MAXY)) return;

	if (x2 < x1 ) x2 ^= x1 ^= x2;

	if (x1 > MAXX) return;
	if (x2 < MINX) return;

	if (x1 < MINX) x1 = MINX;
	if (x2 > MAXX) x2 = MAXX;

//  memset(DATA + ROWSIZE*y + x1, COLOR, x2-x1+1);
//
	if (Gr_scanline_darkening_level >= GR_FADE_LEVELS ) {
		//gr_linear_stosd( DATA + ROWSIZE*y + x1, COLOR, x2-x1+1);
		virge_repw(RenderBuffer+VirgePixelsPerRow*y+x1, x2-x1+1, FGColor);
	} else {
		gr_direct_linear_darken( RenderBuffer+VirgePixelsPerRow*y + x1,
			Gr_scanline_darkening_level, x2-x1+1, gr_fade_table);
	}
}

#endif

#ifdef WARP3D
void gr_direct_linear_darken( UWORD * dest, int darkening_level, int count, ubyte * fade_table )
{
	int i;

	for (i=0; i<count; i++ )    {
		*dest = BitValues[fade_table[*dest+(darkening_level*256)]];
		dest++;
	}
}

void gr_direct_scanline( int x1, int x2, int y )
{
	extern UWORD BitValues[256];

	UWORD *RenderBuffer = WARP_GetBufferAddress();

	UWORD FGColor = BitValues[COLOR];


	if ((y<0)||(y>MAXY)) return;

	if (x2 < x1 ) x2 ^= x1 ^= x2;

	if (x1 > MAXX) return;
	if (x2 < MINX) return;

	if (x1 < MINX) x1 = MINX;
	if (x2 > MAXX) x2 = MAXX;

	if (Gr_scanline_darkening_level >= GR_FADE_LEVELS ) {
		virge_repw(RenderBuffer+VirgePixelsPerRow*y+x1, x2-x1+1, FGColor);
	} else {
		gr_direct_linear_darken( RenderBuffer+VirgePixelsPerRow*y + x1,
			Gr_scanline_darkening_level, x2-x1+1, gr_fade_table);
	}
}

#endif

