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
// vid_amiga.c -- amiga video driver

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

#include <exec/exec.h>
#include <graphics/gfx.h>
#include <intuition/intuition.h>
#include <libraries/asl.h>
#include <utility/tagitem.h>
#include <clib/chunkyppc_protos.h>
#include <powerup/ppcproto/exec.h>
#include <powerup/ppcproto/graphics.h>
#include <powerup/ppcproto/intuition.h>
#include <powerup/ppcproto/asl.h>

#include "quakedef.h"
#include "d_local.h"

extern void ppc_c2p_line (int line, int src, struct BitMap *dst, int cnt);

static qboolean using_mouse = false;
extern short int last_mouse[2];
qboolean mousemove = false;
static qboolean force = false;
static qboolean wpa8 = false;

#define	BASEWIDTH	320
#define	BASEHEIGHT	200

pixel_t *vid_buffer;
short *zbuffer;
byte *surfcache;

unsigned short	d_8to16table[256];

/**********************************************************************/

struct GfxBase *GfxBase = NULL;
struct IntuitionBase *IntuitionBase = NULL;
struct Library *ChunkyPPCBase = NULL;
struct Library *AslBase = NULL;

static struct Mode_Screen ms;
struct Mode_Screen *msptr = &ms;
static struct Screen *video_screen = NULL;
static struct Window *video_window = NULL;
static struct ScreenModeRequester *smr = NULL;
static struct RastPort rp;
static struct RastPort temprp;
static struct BitMap *next_bm;
static unsigned char *next_sbuf;
static struct BitMap tmp_bm = {
  0, 0, 0, 0, 0, {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL}
};

static UWORD *emptypointer = NULL;
static BOOL is_cyber_mode = FALSE;
static BOOL is_native_mode = FALSE;

/**********************************************************************/
void	VID_SetPalette (unsigned char *palette)
{
  int i;
  ULONG v;
  static ULONG colourtable[1+3*256+1];

  colourtable[0] = (256 << 16) + 0;
  for (i = 0; i < 3*256; i++) {
    v = *palette++;
    v += (v << 8);
    v += (v << 16);
    colourtable[i+1] = v;
  }
  colourtable[1 + 3*256] = 0;
	if (wpa8)
		LoadRGB32 (&video_screen->ViewPort, colourtable);
	else
  	LoadColors (&ms, colourtable);
}

/**********************************************************************/
void	VID_ShiftPalette (unsigned char *palette)
{
  VID_SetPalette (palette);
}

/****************************************************************************/
void	VID_Init (unsigned char *palette)
{
  int mode, d;
	int width = 0, height = 0;
	int w, h;
	ULONG idcmp, flags, propertymask;
	struct TagItem stags[7];
	struct TagItem wtags[8];
	struct TagItem atags[12];

	force = COM_CheckParm ("-force");
	wpa8 = COM_CheckParm ("-wpa8");
	using_mouse = COM_CheckParm ("-mouse");

	(struct Library *)GfxBase = OpenLibrary("graphics.library", 39);
	(struct Library *)IntuitionBase = OpenLibrary("intuition.library", 39);
	AslBase = OpenLibrary("asl.library", 38);

	if (GfxBase == NULL)
		Sys_Error ("OpenLibrary(""graphics.library"", 39) failed");
	if (IntuitionBase == NULL)
		Sys_Error ("OpenLibrary(""intuition.library"", 39) failed");
	if (AslBase == NULL)
		Sys_Error ("OpenLibrary(""asl.library"", 38) failed");

	if (!wpa8)
	{
		if ((ChunkyPPCBase = OpenLibrary("chunkyppc.library", 3)) == NULL)
			Sys_Error ("OpenLibrary(""chunkyppc.library"", 3) failed");
	}

	if (wpa8)
	{
		if ((smr = AllocAslRequest (ASL_ScreenModeRequest, NULL)) == NULL)
			Sys_Error ("AllocAslRequest() failed");


		propertymask = DIPF_IS_EXTRAHALFBRITE | DIPF_IS_DUALPF | DIPF_IS_PF2PRI |
									 DIPF_IS_HAM;

		atags[0].ti_Tag = ASLSM_TitleText;
		atags[0].ti_Data = (ULONG)"WarpQuake";
		atags[1].ti_Tag = ASLSM_MinWidth;
		atags[1].ti_Data = BASEWIDTH;
		atags[2].ti_Tag = ASLSM_MinHeight;
		atags[2].ti_Data = BASEHEIGHT;
		atags[3].ti_Tag = ASLSM_InitialDisplayWidth;
		atags[3].ti_Data = BASEWIDTH;
		atags[4].ti_Tag = ASLSM_InitialDisplayHeight;
		atags[4].ti_Data = BASEHEIGHT;
		atags[5].ti_Tag = ASLSM_MinDepth;
		atags[5].ti_Data = 8;
		atags[6].ti_Tag = ASLSM_MaxDepth;
		atags[6].ti_Data = 8;
		atags[7].ti_Tag = ASLSM_DoWidth;
		atags[7].ti_Data = TRUE;
		atags[8].ti_Tag = ASLSM_DoHeight;
		atags[8].ti_Data = TRUE;
		atags[9].ti_Tag = ASLSM_PropertyMask;
		atags[9].ti_Data = propertymask;
		atags[10].ti_Tag = ASLSM_PropertyFlags;
		atags[10].ti_Data = 0;
		atags[11].ti_Tag = TAG_DONE;
		atags[11].ti_Data = 0;

		if((AslRequest (smr, atags)) == NULL)
			Sys_Error ("AslRequest() failed");

		mode = smr->sm_DisplayID;
		width = smr->sm_DisplayWidth;
		height = smr->sm_DisplayHeight;

		stags[0].ti_Tag = SA_Type;
		stags[0].ti_Data = CUSTOMSCREEN;
		stags[1].ti_Tag = SA_DisplayID;
		stags[1].ti_Data = mode;
		stags[2].ti_Tag = SA_Width;
		stags[2].ti_Data = width;
		stags[3].ti_Tag = SA_Height;
		stags[3].ti_Data = height;
		stags[4].ti_Tag = SA_Depth;
		stags[4].ti_Data = 8;
		stags[5].ti_Tag = SA_Quiet;
		stags[5].ti_Data = TRUE;
		stags[6].ti_Tag = TAG_END;
		stags[6].ti_Data = 0;

		if((video_screen = OpenScreenTagList (NULL, stags)) == NULL)
			Sys_Error ("OpenScreenTagList() failed\n");

		idcmp = IDCMP_RAWKEY;
		flags = WFLG_ACTIVATE | WFLG_BORDERLESS | WFLG_NOCAREREFRESH |
          	WFLG_SIMPLE_REFRESH;
  	if (using_mouse)
		{
    	idcmp |= IDCMP_MOUSEBUTTONS | IDCMP_DELTAMOVE | IDCMP_MOUSEMOVE;
    	flags |= WFLG_RMBTRAP | WFLG_REPORTMOUSE;
  	}

		wtags[0].ti_Tag = WA_Left;
		wtags[0].ti_Data = 0;
		wtags[1].ti_Tag = WA_Top;
		wtags[1].ti_Data = 0;
		wtags[2].ti_Tag = WA_Width;
		wtags[2].ti_Data = width;
		wtags[3].ti_Tag = WA_Height;
		wtags[3].ti_Data = height;
		wtags[4].ti_Tag = WA_IDCMP;
		wtags[4].ti_Data = idcmp;
		wtags[5].ti_Tag = WA_Flags;
		wtags[5].ti_Data = flags;
		wtags[6].ti_Tag = WA_CustomScreen;
		wtags[6].ti_Data = (ULONG) video_screen;
		wtags[7].ti_Tag = TAG_DONE;
		wtags[7].ti_Data = 0;

		if((video_window = OpenWindowTagList (NULL, wtags)) == NULL)
			Sys_Error ("OpenWindowTagList() failed\n");

		if ((emptypointer = AllocVec (16, MEMF_CHIP | MEMF_CLEAR)) == NULL)
			Sys_Error ("Couldn't allocate chip memory for pointer");
		SetPointer (video_window, emptypointer, 1, 16, 0, 0);

		InitRastPort (&rp);
		rp.BitMap = video_screen->ViewPort.RasInfo->BitMap;

		InitBitMap (&tmp_bm, 8, width, 1);
		for (d = 0; d < 8; d++)
			if ((tmp_bm.Planes[d] = (PLANEPTR)AllocRaster (width, 1)) == NULL)
				Sys_Error ("AllocRaster() failed");
		temprp = *video_window->RPort;
		temprp.Layer = NULL;
		temprp.BitMap = &tmp_bm;
	}
	else
	{
		w = COM_CheckParm ("-width");
		if (w)
		{
			if (w < com_argc-1)
				ms.SCREENWIDTH = Q_atoi (com_argv[w+1]);
			else
				Sys_Error ("You must specify a size after -width");
		}
		else
			ms.SCREENWIDTH = BASEWIDTH;

		h = COM_CheckParm ("-height");
		if (h)
		{
			if (h < com_argc-1)
				ms.SCREENHEIGHT = Q_atoi (com_argv[h+1]);
			else
				Sys_Error ("You must specify a size after -height");
		}
		else
			ms.SCREENHEIGHT = BASEHEIGHT;

		ms.MS_MAXWIDTH = 1280;
		ms.MS_MAXHEIGHT = 1024;
		ms.MAXDEPTH = 8;
		ms.MINDEPTH = 8;
		ms.video_screen = 0;
		ms.video_window = 0;

		if (force)
			msptr = OpenGraphics ("WarpQuake", &ms, 1);
		else
			msptr = OpenGraphics ("WarpQuake", &ms, 0);

		if (!msptr)
			Sys_Error ("OpenGraphics() failed\n");

		if (!(ChunkyInit(&ms,PIXFMT_LUT8)))
			Sys_Error ("ChunkyInit() failed\n");

		if (ms.video_is_native_mode)
		{
			is_native_mode = TRUE;
			InitRastPort (&rp);
			rp.BitMap = ms.video_screen->ViewPort.RasInfo->BitMap;
			if (ms.numbuffers == 1)
				next_bm = ms.bitmapa;
			else
				next_bm = ms.bitmapb;
		}
		else
		{
			if (ms.video_is_cyber_mode)
				is_cyber_mode = TRUE;

			if (ms.numbuffers == 1)
				next_sbuf = ms.screen;
			else
				next_sbuf = ms.screenb;
		}

  	mode = ms.mode;
  	width = ms.SCREENWIDTH;
  	height = ms.SCREENHEIGHT;
		video_window = ms.video_window;

  	Con_Printf ("Screen Mode $%08x is", mode);
  	if (is_native_mode)
    	Con_Printf (" NATIVE-PLANAR");
  	else
    	Con_Printf (" FOREIGN");
  	Con_Printf (" 8-BIT");
  	if (is_cyber_mode)
    	Con_Printf (" CYBERGRAPHX");
  	Con_Printf (", using size %d x %d\n", width, height);

		if (!using_mouse)
		{
			if(!(ModifyIDCMP(ms.video_window, IDCMP_RAWKEY)))
				Sys_Error ("ModifyIDCMP() failed\n");
		}
	}

  if ((vid_buffer = (pixel_t *)malloc(sizeof(pixel_t) *
                                      width * height)) == NULL ||
      (zbuffer = (short *)malloc(sizeof(short) * width * height)) == NULL ||
      (surfcache = (byte *)malloc(sizeof(byte) *
                                  (width*height/(320*200))*256*1024*3)) == NULL)
			Sys_Error ("Out of memory");

  vid.width = vid.conwidth = width;
  vid.height = vid.conheight = height;
  vid.maxwarpwidth = WARP_WIDTH;
  vid.maxwarpheight = WARP_HEIGHT;

	if (COM_CheckParm ("-noaspectadjust"))
		vid.aspect = 1.0;
	else
  	vid.aspect = ((float)vid.height / (float)vid.width) * (320.0 / 240.0);

	if (wpa8)
		vid.numpages = 1;
	else
  	vid.numpages = ms.numbuffers;

  vid.colormap = host_colormap;
  vid.fullbright = 256 - LittleLong (*((int *)vid.colormap + 2048));
  vid.buffer = vid.conbuffer = vid_buffer;
  vid.rowbytes = vid.conrowbytes = width;
  vid.direct = NULL;

  d_pzbuffer = zbuffer;
  D_InitCaches (surfcache, sizeof(byte) *
                           (width*height/(320*200))*256*1024*3);

  VID_SetPalette (palette);

}

/**********************************************************************/
void	VID_Shutdown (void)
{
	int d;

  if (surfcache != NULL)
	{
    free (surfcache);
    surfcache = NULL;
  }

  if (zbuffer != NULL)
	{
    free (zbuffer);
    zbuffer = NULL;
  }

  if (vid_buffer != NULL)
	{
    free (vid_buffer);
    vid_buffer = NULL;
  }

	for (d = 0; d < 8; d++)
	{
  	if (tmp_bm.Planes[d] != NULL)
		{
    	FreeRaster (tmp_bm.Planes[d], vid.width, 1);
			tmp_bm.Planes[d] = NULL;
		}
	}

	if (wpa8)
	{
		if (video_window != NULL)
		{
			ClearPointer (video_window);
			CloseWindow (video_window);
			video_window = NULL;
		}
	}

	if (emptypointer != NULL)
	{
		FreeVec (emptypointer);
		emptypointer = NULL;
	}

	if (video_screen != NULL)
	{
		CloseScreen (video_screen);
		video_screen = NULL;
	}

	if (smr != NULL)
	{
		FreeAslRequest (smr);
		smr = NULL;
	}


	if (msptr != NULL)
	{
		CloseGraphics (msptr, 1);
		msptr = NULL;
	}

	if (ChunkyPPCBase != NULL)
	{
		CloseLibrary (ChunkyPPCBase);
		ChunkyPPCBase = NULL;
	}

	if (AslBase != NULL)
	{
		CloseLibrary (AslBase);
		AslBase = NULL;
	}

	if (IntuitionBase != NULL)
	{
		CloseLibrary ((struct Library *)IntuitionBase);
		IntuitionBase = NULL;
	}

	if (GfxBase != NULL)
	{
		CloseLibrary ((struct Library *)GfxBase);
		GfxBase = NULL;
	}
}

/**********************************************************************/
void	VID_Update (vrect_t *rects)
{
	APTR handle;

	if (cls.timedemo2)
		return;

	if (is_native_mode)
	{
		int i, j;
		while (rects != NULL)
		{
			for (i = rects->y, j = ((int)(vid_buffer)) + rects->y * vid.width;
      								i < rects->y + rects->height; i++, j += vid.width)
        ppc_c2p_line (i, j, rp.BitMap, (vid.width + 31) >> 5);
			rects = rects->pnext;
		}
		if (ms.numbuffers == 2)
		{
			if (next_bm == ms.bitmapa)
				next_bm = ms.bitmapb;
			else
				next_bm = ms.bitmapa;
		}
		else if (ms.numbuffers == 3)
		{
			if (next_bm == ms.bitmapa)
				next_bm = ms.bitmapb;
			else if (next_bm == ms.bitmapb)
				next_bm = ms.bitmapc;
			else
				next_bm = ms.bitmapa;
		}
		DoubleBuffer (&ms);
	}
	else if (wpa8)
	{
		while (rects != NULL)
		{
			WritePixelArray8 (video_window->RPort, rects->x, rects->y,
                      	rects->x + rects->width - 1,
                      	rects->y + rects->height - 1,
                      	vid_buffer, &temprp);
			rects = rects->pnext;
		}
	}
	else
	{
		while (rects != NULL)
		{
			ChunkyFastest ((UBYTE *)next_sbuf, (UBYTE *)vid_buffer, rects->x, rects->y,
										rects->x + rects->width, rects->y + rects->height, ms.bpr);
			rects = rects->pnext;
		}

		if (ms.numbuffers == 2)
		{
			if (next_sbuf == ms.screen)
				next_sbuf = ms.screenb;
			else
				next_sbuf = ms.screen;
		}
		else if (ms.numbuffers == 3)
		{
			if (next_sbuf == ms.screen)
				next_sbuf = ms.screenb;
			else if (next_sbuf == ms.screenb)
				next_sbuf = ms.screenc;
			else
				next_sbuf = ms.screen;
		}
		DoubleBuffer (&ms);
	}
}

/**********************************************************************/
/*
================
D_BeginDirectRect
================
*/

void D_BeginDirectRect (int x, int y, byte *pbitmap, int width, int height)
{
}

/**********************************************************************/
/*
================
D_EndDirectRect
================
*/
void D_EndDirectRect (int x, int y, int width, int height)
{
}

/**********************************************************************/
void Sys_SendKeyEvents(void)
{
  UWORD code;
	ULONG class;
	WORD mousex, mousey;
  struct IntuiMessage *msg;
  static int xlate[0x68] = {
    '`', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', '0', '-', '=', '\\', 0, '0',
    'q', 'w', 'e', 'r', 't', 'y', 'u', 'i',
    'o', 'p', K_F11, K_F12, 0, '0', '2', '3',
    'a', 's', 'd', 'f', 'g', 'h', 'j', 'k',
    'l', ';', '\'', K_ENTER, 0, '4', '5', '6',
    K_SHIFT, 'z', 'x', 'c', 'v', 'b', 'n', 'm',
    ',', '.', '/', 0, '.', '7', '8', '9',
    K_SPACE, K_BACKSPACE, K_TAB, K_ENTER, K_ENTER, K_ESCAPE, K_F11,
    0, 0, 0, '-', 0, K_UPARROW, K_DOWNARROW, K_RIGHTARROW, K_LEFTARROW,
    K_F1, K_F2, K_F3, K_F4, K_F5, K_F6, K_F7, K_F8,
    K_F9, K_F10, '(', ')', '/', '*', '=', K_PAUSE,
    K_SHIFT, K_SHIFT, 0, K_CTRL, K_ALT, K_ALT, 0, K_CTRL
  };

	if (video_window !=NULL )
	{
		while ((msg = (struct IntuiMessage *)GetMsg (video_window->UserPort)) != NULL)
		{
      class = msg->Class;
      code = msg->Code;
      mousex = msg->MouseX;
      mousey = msg->MouseY;
      ReplyMsg ((struct Message *)msg);
      switch (class)
			{
        case IDCMP_RAWKEY:
          if ((code & 0x80) != 0)
					{
            code &= ~0x80;
            if (code < 0x68)
              Key_Event (xlate[code], false);
          }
					else 
					{
            if (code < 0x68)
              Key_Event (xlate[code], true);
          }
          break;
        case IDCMP_MOUSEBUTTONS:
					switch (code)
					{
  					case IECODE_LBUTTON:
    					Key_Event (K_MOUSE1, true);
							break;
    				case IECODE_LBUTTON + IECODE_UP_PREFIX:
      				Key_Event (K_MOUSE1, false);
      				break;
    				case IECODE_MBUTTON:
      				Key_Event (K_MOUSE2, true);
      				break;
    				case IECODE_MBUTTON + IECODE_UP_PREFIX:
      				Key_Event (K_MOUSE2, false);
      				break;
    				case IECODE_RBUTTON:
      				Key_Event (K_MOUSE3, true);
      				break;
    				case IECODE_RBUTTON + IECODE_UP_PREFIX:
      				Key_Event (K_MOUSE3, false);
      				break;
						default:
							break;
					}
        case IDCMP_MOUSEMOVE:									// Handled in in_amiga.c
          last_mouse[0] = mousex;
          last_mouse[1] = mousey;
					mousemove = true;
          break;
        default:
          break;
      }
    }
  }
}

/**********************************************************************/
