/* 
Copyright (C) 1996-1997 Id Software, Inc. 
 
This program is free software; you can redistribute it and/or 
modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation; either version 2 
of the License, or (at your option) any later version. 
 
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   
 
See the GNU General Public License for more details. 
 
You should have received a copy of the GNU General Public License 
along with this program; if not, write to the Free Software 
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. 
 
*/ 

/*
** vid_ChunkyPPCamiga.c
**
** chunkyppc.library
**
** Written by Steffen Häuser <magicSN@BIRDLAND.es.bawue.de>
**
*/

#include "quakedef.h"

#pragma amiga-align
#include <exec/libraries.h>
#include <intuition/screens.h>
#include <cybergraphics/cybergraphics.h>
#include <proto/exec.h>
#include <proto/chunkyppc.h>
#pragma default-align


extern byte *vid_buffer;
extern unsigned char rawkeyconv[];
extern int modearray_x[11];
extern int modearray_y[11];
extern cvar_t vid_mode;
extern int shutdown_keyboard;

extern struct Library *ChunkyPPCBase;
extern struct Screen *QuakeScreen;

static struct Mode_Screen *mode_screen = NULL;
static struct Mode_Screen ms;
#define CallChunkyCopy ms.algo

#ifdef __PPC__
extern void ChunkyCopyPPC(struct Mode_Screen *,unsigned char *,
                          unsigned char *,int,
                          void *(*)(unsigned char *),unsigned char *);
#else
#ifndef _68881 /* 040/060 only */
extern void ChunkyCopy68k(struct Mode_Screen *,unsigned char *,
                          unsigned char *,int,
                          void *(*)(unsigned char *),unsigned char *);
#endif
#endif



void VID_SetPalette_ChunkyPPC(unsigned char *palette)
{
  ULONG colors[3*256+2];
  ULONG *ptr = colors;
  ULONG x;
  int i;

  *ptr++ = 256<<16;
  for (i=0; i<256; i++) {
    x = (ULONG)*palette++;
    *ptr++ = (x<<24)|(x<<16)|(x<<8)|x;
    x = (ULONG)*palette++;
    *ptr++ = (x<<24)|(x<<16)|(x<<8)|x;
    x = (ULONG)*palette++;
    *ptr++ = (x<<24)|(x<<16)|(x<<8)|x;
  }
  *ptr = 0;
  LoadColors(mode_screen,colors);
}


void VID_Init_ChunkyPPC(unsigned char *palette)
{
  char *module = "ChunkyPPC_Init: ";

#ifdef WOS  /* PowerUp and M68k ports use static CPPC linking */
  if (!(ChunkyPPCBase = OpenLibrary("chunkyppc.library",19)))
    Sys_Error("%sCan't open chunkyppc.library V19",module);
#endif

  if (!mode_screen) {
    mode_screen = &ms;
    ms.video_screen = NULL;
    ms.video_window = NULL;
  }
  ms.SCREENWIDTH = modearray_x[(int)(vid_mode.value)];
  ms.SCREENHEIGHT = modearray_y[(int)(vid_mode.value)];
  ms.MS_MAXWIDTH = 1600;
  ms.MS_MAXHEIGHT = 1200;
  ms.MINDEPTH = 8;
  ms.MAXDEPTH = 8;

  if (!(mode_screen = OpenGraphics("QuakeWorld",&ms,2)))
    Sys_Error("%sCouldn't create window",module);

#ifndef __PPC__
  if (!(ChunkyInit68k(&ms,PIXFMT_LUT8))) Sys_Error("%sInvalid video format",module);
#else
  if (!(ChunkyInit(&ms,PIXFMT_LUT8)))
    Sys_Error("%sInvalid video format",module);
#endif
#ifndef _68881 /* 040/060/PPC only */
  if ((ms.SCREENWIDTH & 31) == 0) {
    /* 32-byte alignment allows better speed (phx) */
    if (!(ms.video_is_native_mode) && !(ms.wb_int))
#ifndef __PPC__
      ms.algo = (void *)ChunkyCopy68k;
#else
      ms.algo = (void *)ChunkyCopyPPC;
#endif
  }
#endif

  vid.width = vid.conwidth = ms.SCREENWIDTH;
  vid.height = vid.conheight = ms.SCREENHEIGHT;
  vid.rowbytes = vid.conrowbytes = ms.bpr;
  vid.aspect = 1.0;
  vid.numpages = 1;
  if (ms.wb_int!=1) {
    if (ms.bpr > ms.SCREENWIDTH)
      vid.rowbytes = ms.SCREENWIDTH;
  }
  else {
    if (ms.likecgx)
      vid.rowbytes = ms.SCREENWIDTH;
  }

  QuakeScreen = ms.video_screen;
  VID_SetPalette(palette);
  Con_Printf("chunkyppc.library %d x %d x %d\n",vid.width,vid.height,8);
}


void VID_Shutdown_ChunkyPPC(void)
{
#ifdef WOS
  if (ChunkyPPCBase)
#endif
  {
    if (mode_screen)
      CloseGraphics(mode_screen,1);
    mode_screen = NULL;
#ifdef WOS
    CloseLibrary(ChunkyPPCBase);
#endif
    ChunkyPPCBase = NULL;
  }
}


void VID_Update_ChunkyPPC(vrect_t *rects)
{
  int temp = ms.SCREENHEIGHT;

  while (rects) {
    if ((!ms.video_is_native_mode)&&(ms.wb_int)) ms.SCREENHEIGHT = rects->height;
    if (ms.video_is_native_mode) {
      switch (ms.numbuffers) {
        case 1:
          CallChunkyCopy(&ms,(void *)(ms.bitmapa),vid_buffer,PIXFMT_LUT8,0,0);
          break;
        case 2:
          if (ms.bufnum==0)
            CallChunkyCopy(&ms,(void *)(ms.bitmapb),vid_buffer,PIXFMT_LUT8,0,0);
          else
            CallChunkyCopy(&ms,(void *)(ms.bitmapa),vid_buffer,PIXFMT_LUT8,0,0);
          DoubleBuffer(&ms);
          break;
        case 3:
          if (ms.bufnum==0)
            CallChunkyCopy(&ms,(void *)(ms.bitmapb),vid_buffer,PIXFMT_LUT8,0,0);
          else if (ms.bufnum==1)
            CallChunkyCopy(&ms,(void *)(ms.bitmapc),vid_buffer,PIXFMT_LUT8,0,0);
          else
            CallChunkyCopy(&ms,(void *)(ms.bitmapa),vid_buffer,PIXFMT_LUT8,0,0);
          DoubleBuffer(&ms);
          break;
      }
    }
    else {
      switch (ms.numbuffers) {
        case 1:
          CallChunkyCopy(&ms,ms.screen,vid_buffer,PIXFMT_LUT8,0,0);
          break;
        case 2:
          if (ms.bufnum==0)
            CallChunkyCopy(&ms,ms.screenb,vid_buffer,PIXFMT_LUT8,0,0);
          else
            CallChunkyCopy(&ms,ms.screen,vid_buffer,PIXFMT_LUT8,0,0);
	  			DoubleBuffer(&ms);
          break;
        case 3:
          if (ms.bufnum==0)
            CallChunkyCopy(&ms,ms.screenb,vid_buffer,PIXFMT_LUT8,0,0);
          else if (ms.bufnum==1)
            CallChunkyCopy(&ms,ms.screenc,vid_buffer,PIXFMT_LUT8,0,0);
          else
            CallChunkyCopy(&ms,ms.screen,vid_buffer,PIXFMT_LUT8,0,0);
          DoubleBuffer(&ms);
          break;
      }
    }
    rects = rects->pnext;
  }
  ms.SCREENHEIGHT = temp;
}


void Sys_SendKeyEvents_ChunkyPPC (void)
{
  struct IntuiMessage *imsg;
  int kn;

  while (imsg = (struct IntuiMessage *)
         GetMsg((mode_screen->video_window)->UserPort)) {
    if (imsg->Class==IDCMP_RAWKEY || imsg->Class==IDCMP_MOUSEBUTTONS) {
      kn = (int)rawkeyconv[imsg->Code & 0x7f];
      if (imsg->Code & IECODE_UP_PREFIX)
        Key_Event(kn,false);
      else
        Key_Event(kn,true);
    }
    if (shutdown_keyboard) {
      shutdown_keyboard = 0;
      return;
    }
    if (mode_screen->video_window)
      ReplyMsg((struct Message *)imsg);
  }
}
