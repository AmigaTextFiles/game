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
 * $Source: /usr/CVS/descent/2d/palette.c,v $
 * $Revision: 1.9 $
 * $Author: tfrieden $
 * $Date: 1998/04/24 14:18:51 $
 *
 * Graphical routines for setting the palette
 *
 * $Log: palette.c,v $
 * Revision 1.9  1998/04/24 14:18:51  tfrieden
 * Unsuccesful try for a cgx wbmode kludge
 *
 * Revision 1.8  1998/04/09 17:42:44  hfrieden
 * *** empty log message ***
 *
 * Revision 1.7  1998/04/09 17:40:28  hfrieden
 * ifdefed wbmode & halfbrite stuff
 *
 * Revision 1.6  1998/04/05 01:52:37  tfrieden
 * Added ECS support
 *
 * Revision 1.5  1998/04/03 13:59:00  tfrieden
 * Exeprimental Workbench support
 *
 * Revision 1.4  1998/03/30 18:28:07  hfrieden
 * Experimental Briefing stuff added
 *
 * Revision 1.3  1998/03/22 15:49:28  hfrieden
 * ViRGE stuff fixed
 *
 * Revision 1.2  1998/03/14 13:56:20  hfrieden
 * Preliminary ViRGE support added
 *
 * Revision 1.2  1998/02/28 01:13:42  tfrieden
 * Additional AGA stuff
 *
 * Revision 1.1.1.1  1998/02/13  20:21:22  hfrieden
 * Initial Import
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
/*#include <vga.h>
#include <vgagl.h>*/
#include <bsd/bsd.h>
#include <exec/types.h>
#include <graphics/gfx.h>
#include <inline/graphics.h>
#include <intuition/intuition.h>

#ifdef VIRGIN
#include <cybergraphics/cgx3dvirgin.h>
#include <clib/cgx3dvirgin_protos.h>
#include <inline/cgx3dvirgin.h>
#include "VirgeTexture.h"
#endif

#include "types.h"
#include "mem.h"
#include "gr.h"
#include "fix.h"
#include "error.h"
#include "palette.h"
#include "cfile.h"

extern int gr_installed;

ubyte gr_palette[256*3];
ubyte gr_current_pal[256*3];
ubyte gr_fade_table[256*34];
ubyte gr_debug_mode = 0;            // reverse white and black for debugging
ushort gr_mac_gamma[64];
double gamma_corrections[9] = {1.7,1.6,1.5,1.4,1.3,1.2,1.1,1.0,0.9};

ushort gr_palette_selector;
ushort gr_fade_table_selector;

ubyte gr_palette_gamma = 4;
int gr_palette_gamma_param = 4;
ubyte gr_palette_faded_out = 1;

unsigned short gr_bitvalues[256];
short gr_bitvalues_valid = 0;

#define kGammaCorrect   1.70    //  Might also try 1.2
//#define kGammaCorrect 1.5

#ifndef VIRGIN
extern struct Window *win;
extern struct Screen *scr;
#else
extern View3D MyView;
extern struct Library *CGX3DVirginBase;
#endif

#define b2l(col)  (((col)&0xff)<<26 | 0xffffff)
#define l2b(col)  (((col)>>26)&63)

extern struct Library *GfxBase;
struct lrgb_pal {
	WORD numcols;
	WORD firstcol;
};

ULONG palette[800];
UBYTE tmpcol[768];
extern long wbpal[];
extern int wbmode;
extern short wbmode_cgxkludge;
extern char ScreenType;
extern UBYTE xlate[];
extern short palette_changed;


void gr_MakeBitValues(void);

void gl_setpalette(ubyte *colors)
{
	int i, j;
	ulong r, g, b;
	struct lrgb_pal pal;


#ifndef VIRGIN
	if (ScreenType == 2) {
		palette_changed = 1;
		pal.numcols = 32;
		pal.firstcol = 0;
		memcpy(&palette[0], &pal, 4);
		palette[33] = 0;
		palette[34] = 0;
		for (i = 0; i < 256; i++) {
			tmpcol[i*3]   = colors[i*3  ]<<2;
			tmpcol[i*3+1] = colors[i*3+1]<<2;
			tmpcol[i*3+2] = colors[i*3+2]<<2;
		}
		median_cut((UBYTE *)tmpcol, (ULONG *)&palette[1], (UBYTE *)&xlate[0]);
		LoadRGB32(&(scr->ViewPort), (ULONG *)palette);
		return;
	}

	if (wbmode) {
		gr_bitvalues_valid = 0;
		for (i = 0; i < 256; i++) {
			wbpal[i] = colors[i*3]<<18 | colors[i*3+1]<<10 | colors[i*3+2]<<2;
		}
		if (wbmode_cgxkludge) gr_MakeBitValues();
		return;
	}
#endif

	pal.numcols = 256;
	pal.firstcol = 0;

	memcpy(&palette[0], &pal, 4);

	j = 1;
	for (i = 0; i < pal.numcols; i++) {
		palette[j++] = b2l(colors[i*3]);
		palette[j++] = b2l(colors[i*3+1]);
		palette[j++] = b2l(colors[i*3+2]);
	}
	palette[j] = 0;
#ifdef VIRGIN
	V3D_SetViewAttr(MyView, V3DVA_Colors32, (ULONG *)palette);
#else
	LoadRGB32(&(scr->ViewPort), (ULONG *)palette);
#endif

}

void gl_getpalette(ubyte *colors)
{
	int i, j;
	byte r, g, b;
	ULONG table[10];

	j = 0;

	for(i = 0; i < 256; i++) {
		//GetRGB32(&(scr->ViewPort.ColorMap), i, 1, table);
		//r = l2b(table[0]);
		//g = l2b(table[1]);
		//b = l2b(table[2]);
		r=l2b(palette[1+i*3]);
		g=l2b(palette[1+i*3+1]);
		b=l2b(palette[1+i*3+2]);
		colors[j++] = r;
		colors[j++] = g;
		colors[j++] = b;
	}

}


void gr_build_mac_gamma(double correction)
{
	int i;

	for (i = 0; i < 64 ; i++)
		gr_mac_gamma[i] = MIN(63,i+gr_palette_gamma);
}

void gr_palette_set_gamma( int gamma )
{
	if ( gamma < 0 ) gamma = 0;
	if ( gamma > 8 ) gamma = 8;

	if (gr_palette_gamma_param != gamma )   {
		gr_palette_gamma_param = gamma;
		gr_palette_gamma = gamma;
		gr_build_mac_gamma(gamma_corrections[gr_palette_gamma]);
		if (!gr_palette_faded_out)
			gr_palette_load( gr_palette );
	}   
}

int gr_palette_get_gamma()
{
	return gr_palette_gamma_param;
}

void gr_use_palette_table( char * filename )
{
	CFILE *fp;
	int i,j;
	ubyte c;

	fp = cfopen( filename, "rb" );
	if ( fp==NULL)
		Error("Can't open palette file <%s> which is not in the current dir.",filename);

	cfread( gr_palette, 256*3, 1, fp );
	cfread( gr_fade_table, 256*34, 1, fp );
	cfclose(fp);

	// This is the TRANSPARENCY COLOR
	for (i=0; i<GR_FADE_LEVELS; i++ )   {
		gr_fade_table[i*256+255] = 255;
	}
	
// swap colors 0 and 255 of the palette along with fade table entries

#ifdef SWAP_0_255
	for (i = 0; i < 3; i++) {
		c = gr_palette[i];
		gr_palette[i] = gr_palette[765+i];
		gr_palette[765+i] = c;
	}

	for (i = 0; i < GR_FADE_LEVELS * 256; i++) {
		if (gr_fade_table[i] == 0)
			gr_fade_table[i] = 255;
	}
	for (i=0; i<GR_FADE_LEVELS; i++)
		gr_fade_table[i*256] = TRANSPARENCY_COLOR;
#endif
}

#define SQUARE(x) ((x)*(x))

#define MAX_COMPUTED_COLORS 32

int Num_computed_colors=0;

typedef struct {
	ubyte   r,g,b,color_num;
} color_record;

color_record Computed_colors[MAX_COMPUTED_COLORS];

//  Add a computed color (by gr_find_closest_color) to list of computed colors in Computed_colors.
//  If list wasn't full already, increment Num_computed_colors.
//  If was full, replace a random one.
void add_computed_color(int r, int g, int b, int color_num)
{
	/*
	int add_index;

	if (Num_computed_colors < MAX_COMPUTED_COLORS) {
		add_index = Num_computed_colors;
		Num_computed_colors++;
	} else
		add_index = (rand() * MAX_COMPUTED_COLORS) >> 15;

	Computed_colors[add_index].r = r;
	Computed_colors[add_index].g = g;
	Computed_colors[add_index].b = b;
	Computed_colors[add_index].color_num = color_num;
	*/
}

void init_computed_colors(void)
{
	int i;

	for (i=0; i<MAX_COMPUTED_COLORS; i++)
		Computed_colors[i].r = 255;     //  Make impossible to match.
}

int gr_find_closest_color( int r, int g, int b )
{
	int i, j;
	int best_value, best_index, value;

	if (Num_computed_colors == 0)
		init_computed_colors();

	//  If we've already computed this color, return it!
	for (i=0; i<Num_computed_colors; i++)
		if (r == Computed_colors[i].r)
			if (g == Computed_colors[i].g)
				if (b == Computed_colors[i].b) {
					if (i > 4) {
						color_record    trec;
						trec = Computed_colors[i-1];
						Computed_colors[i-1] = Computed_colors[i];
						Computed_colors[i] = trec;
						return Computed_colors[i-1].color_num;
					}
					return Computed_colors[i].color_num;
				}

//  r &= 63;
//  g &= 63;
//  b &= 63;

//  best_value = SQUARE(r-gr_palette[0])+SQUARE(g-gr_palette[1])+SQUARE(b-gr_palette[2]);
//  best_index = 0;
	best_value = SQUARE(r-gr_palette[765])+SQUARE(g-gr_palette[766])+SQUARE(b-gr_palette[767]);
	best_index = 255;
	if (best_value==0) {
		add_computed_color(r, g, b, best_index);
		return best_index;
	}
	j=0;
	// only go to 255, 'cause we dont want to check the transparent color.
	for (i=1; i<254; i++ )  {
		j += 3;
		value = SQUARE(r-gr_palette[j])+SQUARE(g-gr_palette[j+1])+SQUARE(b-gr_palette[j+2]);
		if ( value < best_value )   {
			if (value==0) {
				add_computed_color(r, g, b, i);
				return i;
			}
			best_value = value;
			best_index = i;
		}
	}
	add_computed_color(r, g, b, best_index);
	return best_index;
}

int gr_find_closest_color_15bpp( int rgb )
{
	return gr_find_closest_color( ((rgb>>10)&31)*2, ((rgb>>5)&31)*2, (rgb&31)*2 );
}


int gr_find_closest_color_current( int r, int g, int b )
{
	int i, j;
	int best_value, best_index, value;

//  r &= 63;
//  g &= 63;
//  b &= 63;

//  best_value = SQUARE(r-gr_current_pal[0])+SQUARE(g-gr_current_pal[1])+SQUARE(b-gr_current_pal[2]);
//  best_index = 0;
	best_value = SQUARE(r-gr_palette[765])+SQUARE(g-gr_palette[766])+SQUARE(b-gr_palette[767]);
	best_index = 255;
	if (best_value==0)
		return best_index;

	j=0;
	// only go to 255, 'cause we dont want to check the transparent color.
	for (i=1; i<254; i++ )  {
		j += 3;
		value = SQUARE(r-gr_current_pal[j])+SQUARE(g-gr_current_pal[j+1])+SQUARE(b-gr_current_pal[j+2]);
		if ( value < best_value )   {
			if (value==0)
				return i;
			best_value = value;
			best_index = i;
		}
	}
	return best_index;
}

static int last_r=0, last_g=0, last_b=0;

void gr_palette_step_up( int r, int g, int b )
{
	int i,j;
	ubyte *p;
	int temp;
	ubyte colors[768];

	if (gr_palette_faded_out) return;

	if ( (r==last_r) && (g==last_g) && (b==last_b) ) return;

	last_r = r;
	last_g = g;
	last_b = b;

	p=gr_palette;
	for (i=0,j=0; i<256; i++ ) {
		temp = (int)(*p++) + r;
		if (temp<0) temp=0;
		else if (temp>63) temp=63;
		colors[j++] = gr_mac_gamma[temp];
		temp = (int)(*p++) + g;
		if (temp<0) temp=0;
		else if (temp>63) temp=63;
		colors[j++] = gr_mac_gamma[temp];
		temp = (int)(*p++) + b;
		if (temp<0) temp=0;
		else if (temp>63) temp=63;
		colors[j++] = gr_mac_gamma[temp];
	}
	gl_setpalette(colors);
}

void gr_palette_clear()
{
#ifndef VIRGIN
	int i;
	ubyte colors[768];

	for (i = 0; i < 768; i++) colors[i]=0;
	gl_setpalette(colors);
#else
	VirgeClearBuffer();
#endif
	gr_palette_faded_out = 1;
}

void gr_palette_load( ubyte *pal )  
{
	int i, j;
	ubyte colors[768];

	for (i=0; i<768; i++ ) {
//      gr_current_pal[i] = pal[i] + gr_palette_gamma;
		gr_current_pal[i] = pal[i];
		if (gr_current_pal[i] > 63) gr_current_pal[i] = 63;
	}
	for (i = 0, j = 0; j < 256; j++) {
		colors[i] = gr_mac_gamma[gr_current_pal[i++]];
		colors[i] = gr_mac_gamma[gr_current_pal[i++]];
		colors[i] = gr_mac_gamma[gr_current_pal[i++]];
	}
	gl_setpalette(colors);

	gr_palette_faded_out = 0;
	init_computed_colors();
}

int gr_palette_fade_out(ubyte *pal, int nsteps, int allow_keys )    
{
#ifndef VIRGIN
	ubyte c;
	int i,j, k;
	fix fade_palette[768];
	fix fade_palette_delta[768];
	ubyte colors[768];

	if (ScreenType == 2) {
		gr_palette_faded_out = 1;
		return 0;
	}

	allow_keys  = allow_keys;

	if (gr_palette_faded_out) return 0;

	for (i=0; i<768; i++ )  {
		fade_palette[i] = i2f(pal[i]);
		fade_palette_delta[i] = fade_palette[i] / nsteps;
	}

	for (j=0; j<nsteps; j++ )   {
		for (i=0, k = 0; k < 256; k++)  {
			fade_palette[i] -= fade_palette_delta[i];
			if (fade_palette[i] < 0 )
				fade_palette[i] = 0;
			colors[i] = gr_mac_gamma[(f2i(fade_palette[i]))];
			i++;
			fade_palette[i] -= fade_palette_delta[i];
			if (fade_palette[i] < 0 )
				fade_palette[i] = 0;
			colors[i] = gr_mac_gamma[(f2i(fade_palette[i]))];
			i++;
			fade_palette[i] -= fade_palette_delta[i];
			if (fade_palette[i] < 0 )
				fade_palette[i] = 0;
			colors[i] = gr_mac_gamma[(f2i(fade_palette[i]))];
			i++;
		}
		gl_setpalette(colors);
	}
#endif
	gr_palette_faded_out = 1;
	return 0;
}

int gr_palette_fade_in(ubyte *pal, int nsteps, int allow_keys)  
{
	int i,j, k;
	ubyte c;
	fix fade_palette[768];
	fix fade_palette_delta[768];
	ubyte colors[768];

	allow_keys  = allow_keys;

	if (!gr_palette_faded_out) return 0;
#ifdef VIRGIN
	nsteps=1;
#endif
//  palette = GetPalette(GameWindow);

	if (ScreenType == 2) {
		nsteps = 1;
	}

	for (i=0; i<768; i++ )  {
		gr_current_pal[i] = pal[i];
		fade_palette[i] = 0;
		fade_palette_delta[i] = i2f(pal[i]) / nsteps;
	}

	for (j=0; j<nsteps; j++ )   {
		for (i=0, k = 0; k<256; k++ )   {
			fade_palette[i] += fade_palette_delta[i];
			if (fade_palette[i] > i2f(pal[i]) )
				fade_palette[i] = i2f(pal[i]);
			c = f2i(fade_palette[i]);
			if (c > 63) c = 63;
			colors[i] = gr_mac_gamma[c];
			i++;
			fade_palette[i] += fade_palette_delta[i];
			if (fade_palette[i] > i2f(pal[i]) )
				fade_palette[i] = i2f(pal[i]);
			c = f2i(fade_palette[i]);
			if (c > 63) c = 63;
			colors[i] = gr_mac_gamma[c];
			i++;
			fade_palette[i] += fade_palette_delta[i];
			if (fade_palette[i] > i2f(pal[i]) )
				fade_palette[i] = i2f(pal[i]);
			c = f2i(fade_palette[i]);
			if (c > 63) c = 63;
			colors[i] = gr_mac_gamma[c];
			i++;
		}
		gl_setpalette(colors);
	}
	gr_palette_faded_out = 0;
	return 0;
}

void debug_video_mode()
{
}

void reset_debug_video_mode()
{
}

void gr_make_cthru_table(ubyte * table, ubyte r, ubyte g, ubyte b )
{
	int i;
	ubyte r1, g1, b1;

	for (i=0; i<256; i++ )  {
		r1 = gr_palette[i*3+0] + r;
		if ( r1 > 63 ) r1 = 63;
		g1 = gr_palette[i*3+1] + g;
		if ( g1 > 63 ) g1 = 63;
		b1 = gr_palette[i*3+2] + b;
		if ( b1 > 63 ) b1 = 63;
		table[i] = gr_find_closest_color( r1, g1, b1 );
	}
}

void gr_palette_read(ubyte * pal)
{
	gl_getpalette(pal);
}

void gr_MakeBitValues(void)
{
	ubyte r,g,b;
	int i;

	if (gr_bitvalues_valid) return;

	if (gr_palette_faded_out) gr_palette_fade_in(gr_palette, 1,0);

	for (i=0; i<255; i++) {
		r=palette[1+i*3]>>24;
		g=palette[1+i*3+1]>>24;
		b=palette[1+i*3+2]>>24;
		gr_bitvalues[i] = (r&0xF8)<<8 | (g&0xFA)<<3 | (b&0xF8)>>3;
	}
	gr_bitvalues[255] = 0;
	gr_bitvalues_valid = 1;
}

