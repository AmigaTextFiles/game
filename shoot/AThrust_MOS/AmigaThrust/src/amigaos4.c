/*
 * amiga.c
 * Amiga specific graphic routines for Thrust.
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#define __USE_OWN_SCREEN__ 0

#if defined(HAVE_GETOPT_H) && defined(HAVE_GETOPT_LONG_ONLY)
# include <getopt.h>
#elif !defined(HAVE_GETOPT_LONG_ONLY)
# include "getopt.h"
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <exec/types.h>
#include <exec/libraries.h>

#include <proto/intuition.h>

#include <proto/exec.h>

#include <proto/picasso96api.h>

#include <proto/graphics.h>

#include "thrust.h"
#include "fast_gr.h"
#include "gr_drv.h"
#include "options.h"

struct Screen* screen = NULL;
struct Window* window = NULL;
struct BitMap* bitmap = NULL;

struct MsgPort* RtgScreen = NULL;

unsigned char *gfxbuf = NULL;  /* gfx buffer - same dimensions as fb */

static ULONG rtgwidth = 640, rtgheight = 400, /*fbwidth,*/ totalsize;

int framedelay = 0;

void clearscr(void)
{
	memset(gfxbuf,0,totalsize);
}


#ifndef __VBCC__ /* inlined */
void putarea(unsigned char *source, int x, int y, int width, int height,
             int bytesperline, int destx, int desty)
{
  int ix;
  unsigned char *s = source+(y*bytesperline)+x;

  unsigned char *d = gfxbuf+(desty*rtgwidth)+destx;

  int smod = bytesperline - width;
  int dmod = rtgwidth - width;

  for (; height>0; height--,s+=smod,d+=dmod)
    for (ix=0; ix<width; ix++,*d++=*s++);
}
#endif


#ifndef __VBCC__ /* inlined */
void putpixel(int x, int y, unsigned char color)
{
  *(gfxbuf+(y*rtgwidth)+x) = color;
}
#endif


void syncscreen(void)
{
  if ( framedelay )
  	usleep( framedelay );

  WaitTOF();  /* @@@ */
}


void displayscreen(void)
{
    BltBitMapRastPort( bitmap, 0, 0, window->RPort, 0, 0, rtgwidth, rtgheight, 0xC0 );
}


void fadepalette(int first, int last, unsigned char *RGBtable, int fade, int flag)
{
#ifdef __USE_OWN_SCREEN__
  static ULONG tmprgb[3*256+2];
  ULONG *p = tmprgb;
  ULONG cnt = (ULONG)(last-first)+1;
  unsigned char *rgb = RGBtable;
  ULONG c;

  *p++ = (cnt<<16) | (ULONG)first;
  cnt *= 3;
  while (cnt--) {
    c = ((((ULONG)*rgb++) * (ULONG)(fade<<2)) >> 8) & 0xff;
    *p++ = (c<<24)|(c<<16)|(c<<8)|c;
  }
  *p = 0;
  if(flag)
    syncscreen();

  LoadRGB32( &screen->ViewPort, tmprgb );

  displayscreen();
#endif
}


void fade_in(void)
{
#ifdef __USE_OWN_SCREEN__
  int i;

  for(i=0; i<=64; i+=4)
    fadepalette(0, 255, bin_colors, i, 1);
#endif
}


void fade_out(void)
{
#ifdef __USE_OWN_SCREEN__
  int i;

  for(i=64; i; i-=4)
    fadepalette(0, 255, bin_colors, i, 1);
  clearscr();
  displayscreen();
  usleep(200000L);
#endif
}


void graphics_preinit(void)
{
}


int graphicsinit(int argc, char **argv)
{
#ifdef __USE_OWN_SCREEN__
    screen = OpenScreenTags( NULL,
    	SA_Title, "AmigaThrust",
        SA_Width, rtgwidth,
        SA_Height, rtgheight,
        SA_Depth, 8,
        SA_Type, CUSTOMSCREEN,

        TAG_DONE );
#else
    screen = LockPubScreen( NULL );
#endif

    if (screen)
    {
        window = OpenWindowTags( NULL,
        WA_Width, rtgwidth,
        WA_Height, rtgheight,
        WA_PubScreen, screen,
        WA_IDCMP, IDCMP_RAWKEY,
        WA_Activate, TRUE,
        WA_Borderless, TRUE,
        TAG_DONE );

#ifndef __USE_OWN_SCREEN__
    UnlockPubScreen( NULL, screen );
#endif

        if (window)
        {
            RtgScreen = window->UserPort;

	        bitmap = p96AllocBitMap( rtgwidth, rtgheight, 8, BMF_CLEAR | BMF_USERPRIVATE, NULL, RGBFB_CLUT );
	        if ( bitmap )
	        {
	            gfxbuf = (void*)p96GetBitMapAttr(bitmap, P96BMA_MEMORY);
                totalsize = rtgwidth * rtgheight;

	            fadepalette(0, 255, bin_colors, 1, 0);
	            return (0);
	        }
	        else
	        {
	            printf("Couldn't allocate BitMap\n");
                CloseWindow( window );

#ifdef __USE_OWN_SCREEN__
	            CloseScreen( screen );
#endif
	        }
        }
        else
        {
#ifdef __USE_OWN_SCREEN__
            CloseScreen( screen );
#endif
            printf("Couldn't open Window\n");
        }

    }
    else
    {
        printf("Couldn't open Screen\n");
    }

  return (-1);
}


int graphicsclose(void)
{
    if (bitmap)
    {
        WaitBlit();
    	p96FreeBitMap( bitmap );
    }

    if (window) CloseWindow( window );

#ifdef __USE_OWN_SCREEN__
    if (screen) CloseScreen( screen );
#endif

  return (0);
}


char *graphicsname(void)
{
  static char name[] = "AmigaOS 4";

  return name;
}
