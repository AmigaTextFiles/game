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
 * $Source: /usr/CVS/descent/2d/gr.c,v $
 * $Revision: 1.20 $
 * $Author: nobody $
 * $Date: 1999/03/10 23:26:38 $
 *
 * Graphical routines for setting video modes, etc.
 *
 * $Log: gr.c,v $
 * Revision 1.20  1999/03/10 23:26:38  nobody
 * Warp3D V2 adaption
 *
 * Revision 1.19  1998/12/21 17:11:13  nobody
 * *** empty log message ***
 *
 * Revision 1.18  1998/11/09 22:20:09  nobody
 * *** empty log message ***
 *
 * Revision 1.17  1998/09/26 15:03:51  nobody
 * Added Warp3D support
 *
 * Revision 1.16  1998/08/11 14:38:35  nobody
 * Conflicts ?
 *
 * Revision 1.15  1998/05/13 14:57:37  hfrieden
 * *** empty log message ***
 *
 * Revision 1.14  1998/04/24 14:18:02  tfrieden
 * Unsuccesful try for a cgx wbmode kludge
 *
 * Revision 1.13  1998/04/05 13:30:24  tfrieden
 * Some changes in screen mode request, and wbmode
 *
 * Revision 1.12  1998/04/05 01:52:25  tfrieden
 * Added ECS support
 *
 * Revision 1.11  1998/04/03 13:58:49  tfrieden
 * Exeprimental Workbench support
 *
 * Revision 1.10  1998/03/31 17:03:38  hfrieden
 * Removed placement bug with ViRGE version
 *
 * Revision 1.9  1998/03/30 18:39:14  hfrieden
 * Conflicts removed
 *
 * Revision 1.8  1998/03/30 12:33:38  tfrieden
 * Corrected the SM_ORIGINAL bug
 *
 * Revision 1.7  1998/03/28 23:04:15  tfrieden
 * Remove OpenLibrary stuff
 *
 * Revision 1.6  1998/03/25 21:55:51  tfrieden
 * Some more errors corrected (register spills)
 *
 * Revision 1.5  1998/03/23 20:08:29  hfrieden
 * Added Workbench info window
 *
 * Revision 1.4  1998/03/22 15:48:50  hfrieden
 * ViRGE stuff fixed
 *
 * Revision 1.3  1998/03/18 23:19:26  tfrieden
 * Added support for cybergraphics direct access
 *
 * Revision 1.2  1998/03/14 13:55:23  hfrieden
 * Preliminary ViRGE support added
 *
 * Revision 1.3  1998/02/28 01:13:03  tfrieden
 * Additional AGA stuff
 *
 * Revision 1.2  1998/02/22 13:25:22  tfrieden
 * Added mouse pointer stuff
 *
 * Revision 1.1.1.1  1998/02/13  20:21:22  hfrieden
 * Initial Import
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <cybergraphx/cybergraphics.h>
#include <inline/cybergraphics.h>
#include <inline/intuition.h>
#include <intuition/intuition.h>
#include <inline/graphics.h>
#include <graphics/gfx.h>
#include <graphics/displayinfo.h>
#include <inline/exec.h>
#include <exec/exec.h>
#include <clib/asl_protos.h>
#include <libraries/asl.h>
#include <inline/asl.h>
#include "c2p_040.h"

#ifdef VIRGIN
#include <cybergraphics/cgx3dvirgin.h>
#include <clib/cgx3dvirgin_protos.h>
#include <inline/cgx3dvirgin.h>
#include "VirgeTexture.h"
#endif

#ifdef WARP3D
#include <Warp3D/Warp3D.h>
#include <clib/Warp3D_protos.h>
#include <inline/Warp3D.h>
#endif

#include "types.h"
#include "mem.h"
#include "gr.h"
#include "grdef.h"
#include "error.h"
#include "mono.h"
#include "palette.h"
#include "args.h"

#define debug(x) // printf x

extern unsigned short gr_bitvalues[];
extern int VR_screen_mode;

char gr_pal_default[768];

ULONG gr_pixfmt = 0;
int gr_installed = 0;
int gr_mouse_reported = 0;
int gr_keep_resolution = 0;

int gr_show_screen_info = 0;
double wscale = 1.0;
double hscale = 1.0;
//  Amiga system stuff
#ifdef VIRGIN
extern struct Library *CGX3DVirginBase;
View3D MyView;
struct MsgPort *MyViewMsgPort;
ULONG BufNum = 0;
ULONG virgin_depth = 15;
int VirgeHave320 = 0;
#endif

#ifdef WARP3D
extern W3D_Context *WARP_Context;
extern struct Library *Warp3DBase;
extern int WARP_Buffer;
#endif

#ifndef VIRGIN
struct Screen *scr = NULL;
struct Window *win = NULL;

struct ScreenBuffer *sb1 = NULL, *sb2 = NULL;
#endif

extern struct Library *CyberGfxBase;
extern struct Library *IntuitionBase;
extern struct Library *GfxBase;
extern struct Library *AslBase;
extern struct Library *SysBase;
struct BitMap *tmp = NULL;
struct BitMap bm;
struct RastPort TempRas;
struct Window *InfoWin = 0;
struct Screen *InfoScr = 0;
UBYTE *OffscreenBuffer = NULL;
int OffscreenW = 0, OffscreenH = 0;
int OffscreenSize = 0;
char ScreenType = 1;    // 0 = AGA, 1 = CyberGfx, 2 = EHB
int depth = 8;
int cgx_direct;
PLANEPTR planes = NULL;
UBYTE *compare_buffer = NULL;

struct ScreenModeRequester *smr;

UWORD *PointerData = NULL;

UWORD  EditorPointer[]  = {
	0x0000, 0x0000,

	0xc000, 0x0000,
	0xf000, 0x0000,
	0x7c00, 0x0000,
	0x7f00, 0x0000,
	0x3fc0, 0x0000,
	0x3fc0, 0x0000,
	0x1f00, 0x0000,
	0x1f80, 0x0000,
	0x0dc0, 0x0000,
	0x0ce0, 0x0000,
	0x0060, 0x0000,

	0x0000, 0x0000
};


// Variables for screenmodes
unsigned long Mode320x200;
unsigned long Mode320x400;
unsigned long Mode640x480;
unsigned long Mode800x600;
int farg;
int wbmode = 0;
short wbmode_cgxkludge = 0;

// Pallette stuff
long wbpal[256*3+2];
UBYTE xlate[256];
short palette_changed;
extern ULONG palette[];
char *gr_sc_small = "Small Screen";
char *gr_sc_medium = "Medium Screen";
char *gr_sc_large = "Large Screen";

void gr_wlpa(void);

#ifdef VIRGIN
char *InfoTxt = "Loading ViRGE ADescent";
#elif defined(WARP3D)
char *InfoTxt = "Loading Warp3D ADescent";
#else
char *InfoTxt = "Loading ADescent";
#endif

void HideInfoWindow(void)
{
	if (InfoWin) CloseWindow(InfoWin);
	InfoWin = 0;
}

void ShowInfoWindow(void)
{
	ULONG w,h;
	ULONG b,l;
	struct DrawInfo *dri;

	atexit(HideInfoWindow);

	InfoScr = LockPubScreen(NULL);
	if (!InfoScr) goto siw_fail;

	dri = GetScreenDrawInfo(InfoScr);
	if (!dri) {
		UnlockPubScreen(NULL, InfoScr);
		InfoScr = 0;
		goto siw_fail;
	}

	w = (ULONG)InfoScr->Width;
	h = (ULONG)InfoScr->Height;
	b = (ULONG)(dri->dri_Font->tf_YSize);

	InfoWin = OpenWindowTags(NULL,
		WA_InnerHeight,         b+8,
		WA_InnerWidth,          w/2,
		WA_Left,                w/4,
		WA_Top,                 (h/2)-b,
		WA_CloseGadget,         FALSE,
		WA_DragBar,             FALSE,
		WA_SizeGadget,          FALSE,
		WA_DepthGadget,         FALSE,
		WA_Activate,            TRUE,
	TAG_DONE);

	if (InfoWin) {
		SetAPen(InfoWin->RPort, dri->dri_Pens[TEXTPEN]);
		SetFont(InfoWin->RPort, dri->dri_Font);
		l = TextLength(InfoWin->RPort, InfoTxt, strlen(InfoTxt));
		Move(InfoWin->RPort, w/4-l/2, InfoWin->BorderTop+dri->dri_Font->tf_Baseline+2);
		Text(InfoWin->RPort, InfoTxt, strlen(InfoTxt));
	}

	FreeScreenDrawInfo(InfoScr, dri);
	UnlockPubScreen(NULL, InfoScr);
siw_fail:
}


#ifdef VIRGIN
void gccWriteRect(int dummy, ...)
{
	V3D_WriteRect(OffscreenBuffer, 0,0, OffscreenW, MyView, 0,0,
		OffscreenW, OffscreenH, RECT2D_LUT8);
}
#endif

void gr_update2(void)
{
#ifndef VIRGIN
	if (ScreenType == 1) {
		WritePixelArray(OffscreenBuffer, 0, 0, OffscreenW, win->RPort, 0, 0, OffscreenW-1,
				OffscreenH-1, RECTFMT_LUT8);
	} else if (ScreenType == 0) {
		c2p_8_040((UBYTE *)OffscreenBuffer, planes, compare_buffer, OffscreenSize);
	} else if (ScreenType == 2) {
		c2p_6_040_kludge((UBYTE *)OffscreenBuffer, planes, compare_buffer, xlate, OffscreenSize, palette_changed);
		palette_changed = 0;
	}

#else
	//printf("Updating...\n");
	if (V3D_LockView(MyView)) {
		gccWriteRect(0);
		V3D_UnLockView(MyView);
	#ifdef VIRGIN_DBUF
		BufNum++; BufNum&=1;
		V3D_FlipBuffer(MyView, (ULONG)BufNum);
	#endif
	}
#endif
}

void gr_update3(void)
{
#ifndef VIRGIN
//        WriteLUTPixelArray(OffscreenBuffer, 0, 0, OffscreenW, win->RPort, wbpal,
//                win->BorderLeft, win->BorderTop,
//                OffscreenW-1, OffscreenH-1, CTABFMT_XRGB8);
#endif
}

void gr_update(grs_canvas *canv)
{
#ifdef WARP3D
	WARP_Update(win->Height/2*(1-WARP_Buffer));
#else
	if (cgx_direct == 1) return;
	if (wbmode == 0) {
		gr_update2();
	} else
		gr_update3();
#endif
}

void gr_close()
{
#ifdef VIRGIN
	extern void VirgeCleanupTextureCache(void);
#endif

	printf("Closing graphics subsystem\n");
	gr_set_current_canvas(NULL);
	gr_clear_canvas( BM_XRGB(0,0,0) );
	if (gr_installed==1)
	{
		gr_installed = 0;
		mem_free(grd_curscreen);
	}

	if (PointerData)        FreeVec(PointerData);
	if (OffscreenBuffer)    FreeVec(OffscreenBuffer);
#ifdef WARP3D
	WARP_Close();
#endif
#ifdef VIRGIN
	VirgeCleanupTextureCache();
	if (MyView)             V3D_CloseView(MyView);
	VirgePrintTextureStatistics();
#else


	if (win)                CloseWindow(win);
	if (scr) {
		if (wbmode)
			UnlockPubScreen(NULL, scr);
		else
			CloseScreen(scr);
	}
#endif
	if (planes)             FreeVec(planes);
}


unsigned long gr_asl_req(int iw, int ih, int mw, int mh, int xw, int xh, char *text)
{
#ifdef WARP3D
	ULONG depth = 15;
	ULONG mdepth = 15;
#else
	ULONG depth = 8;
	ULONG mdepth = 6;
#endif

	ULONG mode;
	if (CyberGfxBase) {
		mode = BestCModeIDTags( CYBRBIDTG_NominalWidth,     iw,
								CYBRBIDTG_NominalHeight,    ih,
								CYBRBIDTG_Depth,            depth,
								TAG_DONE);
	} else {
		mode = BestModeID( BIDTAG_NominalWidth,     iw,
						   BIDTAG_NominalHeight,    ih,
						   BIDTAG_Depth,            8,
						   BIDTAG_DIPFMustNotHave,  DIPF_IS_DUALPF|DIPF_IS_PF2PRI|DIPF_IS_HAM,
						   TAG_DONE);
	}

	if (AslRequestTags((APTR)smr,
			ASLSM_TitleText,            (ULONG)text,
			ASLSM_InitialDisplayID,     mode,
			ASLSM_MinWidth,             mw,
			ASLSM_MaxWidth,             xw,
			ASLSM_MinHeight,            mh,
			ASLSM_MaxHeight,            xh,
			ASLSM_MinDepth,             mdepth,
			ASLSM_MaxDepth,             depth,
			ASLSM_PropertyMask,         DIPF_IS_DUALPF|DIPF_IS_PF2PRI|DIPF_IS_HAM,
			ASLSM_PropertyFlags,        0,
			TAG_DONE))
			return (unsigned long)smr->sm_DisplayID;
	else
		return(0);
}


int gr_select_mode(void)
{

	smr = AllocAslRequestTags( ASL_ScreenModeRequest,
			ASLSM_PubScreenName,        (ULONG)"Workbench",
			ASLSM_TitleText,            (ULONG)"Select screen mode",
			TAG_DONE);

	if (Mode320x200 == 0) {
		Mode320x200 = gr_asl_req(320,200, 320,200, 320,256,
				"Select 320x200 screenmode (game/menu)");
		if (!Mode320x200) return 0;
	}


	if (Mode320x400 == 0) {
		Mode320x400 = gr_asl_req(320,400, 320,400, 320,512,
				"Select 320x400 screenmode (small automap)");
		if (!Mode320x400) return 0;

	}

	if (Mode640x480 == 0) {
		Mode640x480 = gr_asl_req(640,480, 640,480, 640,512,
				"Select 640x480 screenmode (large automap/game)");
		if (!Mode640x480) return 0;
	}
	if (Mode800x600 == 0) {
		Mode800x600 = gr_asl_req(800,600, 800, 600, 800,600,
				"Select 800x600 screenmode (editor)");
		if (!Mode800x600) Mode800x600=Mode640x480;
	}

	FreeAslRequest((APTR)smr);
	return 1;
}


int gr_set_mode(int mode)
{
#ifdef WARP3D
	return WARP_set_mode(mode);
#else
	int w, h, r, x, y;
	ULONG sa_error;
	char *smode;
	int i;
	long cmode;
	ulong adr;
	int direct = 0;
	struct DisplayInfo di_info;
	DisplayInfoHandle di_handle;
#ifndef VIRGIN
	struct Screen *scr2=NULL;
	struct Window *win2=NULL;
#else
	int ww,hh;
	int ModeBackup;
	View3D MyView2 = NULL;
	struct TagItem opentags[] = {
		{V3DVA_UseZBuffer,   FALSE},
		{TAG_DONE,           0}
	};
	extern void VirgeInitTextureCache(void);


#endif

	debug(("gr_set_mode\n"));
	if (gr_keep_resolution && scr) return 0;

	if (!PointerData) {
		PointerData = AllocVec(256, MEMF_CLEAR|MEMF_CHIP);
		farg = FindArg("-smr");
#ifndef VIRGIN
		if (CyberGfxBase) {
			wbmode = FindArg("-wbmode"); // Doesn`t work yet
			/*if (wbmode && FindArg("-cgxkludge")) {
				wbmode_cgxkludge = 1;
			} else {
				wbmode_cgxkludge = 0;
			} */
		}
#endif
	}

#ifndef VIRGIN
	debug(("gr_set_mode: Checking modes\n"));
	if (Mode320x200 == 0 || Mode320x400 == 0 || Mode640x480 == 0 || Mode800x600 == 0 || farg != 0) {
		if (farg != 0) {
			Mode320x200 = 0;
			Mode320x400 = 0;
			Mode640x480 = 0;
			Mode800x600 = 0;
			farg = 0;
		}
		debug(("gr_set_mode: selecting screen modes\n"));
		if (gr_select_mode() == 0) exit(1); //  smr canceled
	}

#endif

#ifndef VIRGIN
	if (scr) {
		scr2 = scr;
		win2 = win;
		scr=NULL;
	}
#else
	if (MyView) {
		MyView2 = MyView;
		MyView = NULL;
	}
	if (MyViewMsgPort) {
		V3D_DeleteEventPort(MyViewMsgPort);
		MyViewMsgPort = NULL;
	}
#endif

	debug(("gr_set_mode: determining parameters\n"));

	if (gr_keep_resolution) mode = VR_screen_mode;
	switch (mode) {
		case SM_ORIGINAL:
			return 0;
		case SM_320x200x8:
		case SM_320x200C:
		case SM_320x200x8UL:
			w = 320;
			h = 200;
			smode = gr_sc_small;
			#ifdef VIRGIN
			ww = 320;
			if (VirgeHave320 == 0) {
				hh = 240;
				//h  = 240;
			} else {
				hh = 200;
				//h  = 200;
			}
			#endif
			x = 0;
			y = 0;
			cmode = Mode320x200;
			break;
		case SM_320x400U:
			w = 320;
			h = 400;
			smode = gr_sc_medium;
			#ifdef VIRGIN
			ww = 320;
			hh = 400;
			#endif
			x = 0;
			y = 0;
			cmode = Mode320x400;
			break;

		case SM_320x200x16:
			exit(1);
			break;
		case SM_800x600V:
			w = 800;
			h = 600;
			x = 0;
			y = 0;
			cmode = Mode800x600;
			break;

		default:
			printf("Warning: Unknown screen mode. Opening large default\n");
		case SM_640x480V:
			w = 640;
			h = 480;
			smode = gr_sc_large;
			#ifdef VIRGIN
			ww = 640;
			hh = 480;
			#endif
			x = 0;
			y = 0;
			cmode = Mode640x480;
			break;
			
	}

#ifndef VIRGIN

	GetDisplayInfoData(NULL, (UBYTE *)&di_info, sizeof(di_info), DTAG_DISP, cmode);
	if (di_info.PropertyFlags & DIPF_IS_EXTRAHALFBRITE) {
		depth = 6;
		ScreenType = 2;
	} else {
		depth = 8;
		ScreenType = 0;
		if (CyberGfxBase) {
			if (IsCyberModeID(cmode)) {
				ScreenType = 1;
				if (FindArg( "-vdirect" ) && wbmode==0)
					cgx_direct = 1;
			}
		}
	}


#ifdef WARP3D
	depth = 15;
#endif

	if (scr) {
		scr2 = scr;
		win2 = win;
		scr=NULL;
	}
#else
	if (MyView) {
		MyView2 = MyView;
		MyView = NULL;
	}
#endif

#if !defined(VIRGIN) && !defined(WARP3D)

	if (planes) FreeVec(planes);
	if (ScreenType == 0 || ScreenType == 2) {
		planes = AllocVec(depth * RASSIZE(w, h), MEMF_CHIP|MEMF_CLEAR); //  Chip ram for AGA
	} else {
		planes = AllocVec(depth * RASSIZE(w, h), MEMF_CLEAR);           //  Other (fast) for CGX
	}
	if (!planes) {
		Error("No memory for display, allocation failed (%d*RASSIZE(%d,%d) = %d)\n",
			depth, w, h, depth*RASSIZE(w,h));
		exit(1);
	}
	InitBitMap(&bm, depth, w, h);
	for (i = 0; i < depth; i++) {
		bm.Planes[i] = planes + i * RASSIZE(w, h);
//        printf("Plane %i @ 0x%08x\n", i, bm.Planes[i]);
	}
#else
	planes = 0;
#endif

#ifndef VIRIGN
	if (!scr) {
		if (!wbmode) {
#ifdef WARP3D
	int f = 2;
	debug(("gr_set_mode: Opening screen\n"));
			scr = OpenScreenTags( NULL,
				SA_Quiet,       TRUE,
				SA_Left,        0,
				SA_Top,         0,
				SA_Width,       w,
				SA_Height,      h*f,
				SA_Title,       (ULONG)smode,
				SA_Depth,       8,
				SA_Type,        CUSTOMSCREEN,
				SA_DisplayID,   cmode,
				SA_ErrorCode,   (ULONG)&sa_error,
			TAG_DONE);

#else
			scr = OpenScreenTags( NULL,
				SA_Quiet,       TRUE,
				SA_Left,        0,
				SA_Top,         0,
				SA_Width,       w,
				SA_Height,      h,
				SA_Title,       (ULONG)smode,
				SA_Depth,       depth,
				SA_Type,        CUSTOMSCREEN,
				SA_DisplayID,   cmode,
				SA_BitMap,      (ULONG)(&bm),
				SA_ErrorCode,   (ULONG)&sa_error,
			TAG_DONE);
#endif
			if (!scr) {
				printf("Can`t open screen: ");
				switch(sa_error) {
					case OSERR_NOMONITOR:
						printf("Monitor not available\n"); break;
					case OSERR_NOCHIPS:
						printf("Custom chips too old\n"); break;
					case OSERR_NOMEM:
						printf("Could not get enough memory\n"); break;
					case OSERR_NOCHIPMEM:
						printf("Could not get enough chip memory\n"); break;
					case OSERR_PUBNOTUNIQUE:
						printf("Public screen name not unique\n"); break;
					case OSERR_UNKNOWNMODE:
						printf("This mode is unknown\n"); break;
					case OSERR_TOODEEP:
						printf("Screen too deep to be displayed on this hardware\n"); break;
					case OSERR_ATTACHFAIL:
						printf("Illegal attachment for screens\n"); break;
					default:
						printf("Unknown error\n"); break;
				}
				exit(1);
			}
			if (scr->Width != w || scr->Height != h) {
				printf("Warning: Screen dimensions do not match requested dimensions\n");
			}
			if (win2) {
				CloseWindow(win2);
				win2 = NULL;
			}
			if (scr2) {
				CloseScreen(scr2);
				scr2 = NULL;
			}
#ifndef WARP3D
			win = OpenWindowTags( NULL,
				WA_Left,        0,
				WA_Top,         0,
				WA_Width,       w,
				WA_Height,      h,
				WA_Flags,       WFLG_BORDERLESS|WFLG_SIMPLE_REFRESH|WFLG_ACTIVATE|WFLG_RMBTRAP|WFLG_REPORTMOUSE,
				WA_AutoAdjust,  TRUE,
				WA_IDCMP,       IDCMP_RAWKEY,
				WA_CustomScreen, (ULONG)scr,
				WA_SimpleRefresh, TRUE,
				TAG_DONE);
#else
		debug(("gr_set_mode: opening window\n"));
			win = OpenWindowTags( NULL,
				WA_Left,        0,
				WA_Top,         0,
				WA_Width,       w,
				WA_Height,      h*2,
				WA_Flags,       WFLG_BORDERLESS|WFLG_SIMPLE_REFRESH|WFLG_ACTIVATE|WFLG_RMBTRAP|WFLG_REPORTMOUSE,
				WA_AutoAdjust,  TRUE,
				WA_IDCMP,       IDCMP_RAWKEY,
				WA_CustomScreen, (ULONG)scr,
				WA_SimpleRefresh, TRUE,
				TAG_DONE);
#endif
			if (!win) {
				if (scr) {
					CloseScreen(scr);
					scr = NULL;
				}
				if (win2) {
					CloseWindow(win2);
					win2 = NULL;
				}
				if (scr2) {
					CloseScreen(scr2);
					scr2 = NULL;
				}
				Error("Can`t open window (%d,%d)\n", w, h);
				exit(1);
			}
		} else {
			scr = LockPubScreen(NULL);
			win = OpenWindowTags( NULL,
				WA_Title,       (ULONG)"Amiga Descent",
				WA_InnerWidth,  w,
				WA_InnerHeight, h,
				WA_Borderless,  FALSE,
				WA_SizeGadget,  FALSE,
				WA_DragBar,     TRUE,
				WA_DepthGadget, TRUE,
				WA_CloseGadget, FALSE,
				WA_RMBTrap,     TRUE,
				WA_IDCMP,       IDCMP_RAWKEY,
				WA_Activate,    TRUE,
				WA_CustomScreen, (ULONG)scr,
				WA_SimpleRefresh, FALSE,
				TAG_DONE);
			if (!win) {
				 Error("Can`t open window\n");
				 exit(1);
			}
		}

		if (scr->Width < w || scr->Height < h) {
			Error("Selected video mode too small\n");
			exit(0);
		}

#else
	if (!MyView) {
		MyView = V3D_OpenViewTagList(ww,hh, 15L, opentags);
#endif

		if (OffscreenBuffer) FreeVec(OffscreenBuffer);
		OffscreenBuffer = AllocVec(w*h, MEMF_CLEAR);
		if (!OffscreenBuffer) {
			Error("No memory for offscreen buffer\n");
			exit(0);
		}
		OffscreenH = h;
		OffscreenW = w;
		OffscreenSize = (h*w)/8;
		if (compare_buffer) FreeVec(compare_buffer);
		compare_buffer = AllocVec(w*h, MEMF_CLEAR);
		if (!compare_buffer) {
			printf("Error: No memory for compare_buffer\n");
			exit(0);
		}
	}

#ifndef VIRGIN
	if (scr && scr2) {
		CloseWindow(win2);
		if (wbmode) {
			UnlockPubScreen(NULL, InfoScr);
		} else {
			CloseScreen(scr2);
		}
	}

	if (win && wbmode == 0) {
		SetPointer(win, PointerData, 16, 16, 1, 1);
	}
#else
	if (MyView && MyView2) {
		VirgeCleanupTextureCache();
		V3D_CloseView(MyView2);
		MyView2=NULL;
	}

	MyViewMsgPort = V3D_CreateEventPort(MyView, IDCMP_RAWKEY);
#endif

	gr_palette_clear();
	grd_curscreen->sc_w = w;
	grd_curscreen->sc_h = h;
	grd_curscreen->sc_aspect = fixdiv(grd_curscreen->sc_w*3,grd_curscreen->sc_h*4);
	grd_curscreen->sc_canvas.cv_bitmap.bm_x = 0;
	grd_curscreen->sc_canvas.cv_bitmap.bm_y = 0;
	grd_curscreen->sc_canvas.cv_bitmap.bm_type = BM_LINEAR;
	grd_curscreen->sc_canvas.cv_bitmap.bm_w = w;
	grd_curscreen->sc_canvas.cv_bitmap.bm_h = h;
	grd_curscreen->sc_canvas.cv_bitmap.bm_rowsize = w;

	if (w>600) {
		wscale = (w+1)/w;
		hscale = (h+1)/h;
	} else {
		wscale = 1.0;
		hscale = 1.0;
	}

	debug(("gr_set_mode: bitmap is %ld×%ld\n", w, h));

#if !defined(VIRGIN) && !defined(WARP3D)
	if (cgx_direct == 1) {
		Forbid();
		grd_curscreen->sc_canvas.cv_bitmap.bm_Handle =
						  (void *)LockBitMapTags(win->RPort->BitMap,
							LBMI_BASEADDRESS,   (ULONG)(&adr),
							TAG_DONE);
		UnLockBitMap((APTR)(grd_curscreen->sc_canvas.cv_bitmap.bm_Handle));
		Permit();
		grd_curscreen->sc_canvas.cv_bitmap.bm_data = (ubyte *)adr;
	} else {
#endif
		grd_curscreen->sc_canvas.cv_bitmap.bm_data = (ubyte *)OffscreenBuffer;
#if !defined(VIRIGN) && !defined(WARP3D)
	}
#endif

	gr_set_current_canvas(NULL);
#ifdef VIRGIN
	VirgeInitTextureCache();
	VirgeSetupBuffers();
#endif

	gr_pixfmt = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_PIXFMT);

	debug(("gr_set_mode: done\n"));

	return 0;
#endif
}

extern void gr_build_mac_gamma(double correction);
extern double gamma_corrections[9];
extern ubyte gr_palette_gamma;

int gr_init(int mode)
{
	int retcode;

	debug(("gr_init\n"));

	// Only do this function once!
	if (gr_installed==1)
		return 1;

	HideInfoWindow();

	// Save the current palette, and fade it out to black.

	MALLOC( grd_curscreen,grs_screen,1 );
	memset( grd_curscreen, 0, sizeof(grs_screen));
	
// initialize the macintosh window that we will use -- including picking the
// monitor

	// Set the mode.
	if ((retcode=gr_set_mode(mode)))
		return retcode;

//JOHNgr_disable_default_palette_loading();

	gr_build_mac_gamma(gamma_corrections[gr_palette_gamma]);

	// Set all the screen, canvas, and bitmap variables that
	// aren't set by the gr_set_mode call:
	grd_curscreen->sc_canvas.cv_color = 0;
	grd_curscreen->sc_canvas.cv_drawmode = 0;
	grd_curscreen->sc_canvas.cv_font = NULL;
	grd_curscreen->sc_canvas.cv_font_fg_color = 0;
	grd_curscreen->sc_canvas.cv_font_bg_color = 0;
	gr_set_current_canvas( &grd_curscreen->sc_canvas );

	// Set flags indicating that this is installed.
	gr_installed = 1;
	atexit(gr_close);

	return 0;
}

int gr_check_mode(int mode) {
	return 0; // *shrug*
}

void gr_wlpa(void) {
#ifndef VIRGIN
	//  Kludge to replace WriteLUTPixelArray

	APTR handle;
	int x,y;
	ULONG pixfmt;
	UWORD *adr, *oadr;
	UBYTE *offscr = OffscreenBuffer;
	ULONG width;

	Forbid();
	handle = LockBitMapTags(win->RPort->BitMap,
					LBMI_BASEADDRESS,   (ULONG)(&adr),
					LBMI_BYTESPERROW,   (ULONG)(&width),
					TAG_DONE);


	adr = (UWORD *)(((UBYTE *)adr) +
			(width * (win->TopEdge + win->BorderTop)) +
			(win->LeftEdge + win->BorderLeft));

	for (y = OffscreenH; y > 0; y--) {
		oadr = adr;
		for (x = OffscreenW; x > 0; x--) {
			*adr++ = gr_bitvalues[*offscr++];
		}
		adr = (UWORD *)((UBYTE *)oadr + width); // put to next line
	}

	UnLockBitMap(handle);
	Permit();
#endif
}

void gr_mouse_setimage(int image);

void gr_mouse_show(void)
{
#ifndef VIRGIN
//    gr_mouse_setimage(1);
	SetPointer(win, EditorPointer, 11, 16, 0, 0);
	gr_mouse_reported = 1;
#endif
}

void gr_mouse_hide(void)
{
#ifndef VIRGIN
//    gr_mouse_setimage(0);
	SetPointer(win, PointerData, 11, 16, 0, 0);
	gr_mouse_reported = 0;
#endif
}

#ifdef EDITOR
extern char ui_mouse_pointer[];
#endif

#define PTR_W 11
#define PTR_H 19

void gr_mouse_setimage(int image)
{
#ifdef EDITOR
	int j, i;
	UWORD first, second;
	int b;
	UWORD *here;
#ifndef VIRGIN
	if (image == 0) {
		for (i = 0; i < 256; i++) PointerData[i] = 0;
		SetPointer(win, PointerData, 16, 16, 1, 1);
	} else {
		here = PointerData + 2;
		PointerData[0] = 0;
		PointerData[1] = 0;
		for (i = 0; i < PTR_H; i++) {
			first = 0;
			second = 0;
			b = 1;
			for (j = PTR_W; j > 0; j--) {
				switch (ui_mouse_pointer[i * PTR_W +j]) {
					case '1': first &= b;
							break;
					case '2': second &= b;
							break;
					case '4': first &= b;
							second &= b;
							break;
				}
				b = b << 1;
			}
			*here ++ = first;
			*here ++ = second;
		}
		*here++ = 0;
		*here ++ = 0;

		SetPointer(win, PointerData, PTR_H, PTR_W, 1, 1);
	}
#endif
#endif
}
