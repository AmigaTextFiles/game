/*
 * $Source: /usr/CVS/descent/Amiga/Warp3D.c,v $
 * $Author: nobody $
 * $Date: 1999/03/10 23:26:42 $
 * $Revision: 1.4 $
 *
 * Warp3D stuff for Descent
 *
 * $Log: Warp3D.c,v $
 * Revision 1.4  1999/03/10 23:26:42  nobody
 * Warp3D V2 adaption
 *
 * Revision 1.3  1998/12/21 17:12:20  nobody
 * *** empty log message ***
 *
 * Revision 1.2  1998/11/09 22:20:17  nobody
 * *** empty log message ***
 *
 * Revision 1.1  1998/09/26 15:16:01  nobody
 * Initial version
 *
 *
 *
 */
#ifdef WARP3D

#include <Warp3D/Warp3D.h>
#include <cybergraphics/cybergraphics.h>
#include <intuition/intuition.h>
#include <exec/exec.h>
#include <graphics/gfx.h>
#include <libraries/asl.h>

#include <clib/Warp3D_protos.h>
#include <inline/Warp3D.h>
#include <clib/cybergraphics_protos.h>
#include <inline/cybergraphics.h>
#include <clib/exec_protos.h>
#include <inline/exec.h>

#include "types.h"
#include "mem.h"
#include "gr.h"
#include "grdef.h"
#include "error.h"
#include "mono.h"
#include "palette.h"
#include "args.h"
#include "timer.h"
#include "rle.h"
#include "gauges.h"
#include "texmap.h"
#include "3d.h"
#include "iff.h"
#include "object.h"

#include <stdio.h>

#define debug(x) //printf x
#define PROF_CACHE 0

extern struct Library *Warp3DBase;
extern struct Library *SysBase;

extern int gr_keep_resolution;
#define WARP_GetBufferAddress() (void *)(WARP_Buffers[1-WARP_Buffer])

//  Misc stuff
W3D_Context *WARP_Context = NULL;
struct Window *WARP_Window;
int WARP_NumTex= 40;        // Number of texcache entries
ULONG WARP_ready = 0;
extern ULONG gr_pixfmt;

//  Double-Buffering stuff
int WARP_Buffer = 1;
void *WARP_Buffers[2];
ULONG WARP_BytesPerRow;
ULONG WARP_PixelsPerRow;

//  Predefined textures
W3D_Texture *WARP_Dummy = NULL;
W3D_Texture *WARP_Trans = NULL;
W3D_Texture *WARP_White = NULL;
W3D_Texture *WARP_Reticle = NULL;
W3D_Texture *WARP_Fireball = NULL;
UWORD DummyTex[64*64];
ULONG Fireball[64*64];
UWORD TransTex[4] = {
	0x8111, 0xa111,
	0x5111, 0x7111
};
UWORD WhiteTex[4] = {
	0xffff, 0xffff,
	0xffff, 0xffff
};

//  Reticle stuff
UWORD ReticleTex[64*64];
grs_bitmap *wreticle = NULL;
UWORD rcol[] = {
	0x0000,                     // 0: background
	0xffff,                     // 1: crosshairs
	0x8bbb,                     // 2: shield gauge
	0x8bbb,                     // 3: energy gauge
	0xaaaa,                     // 4: targeter
	0xaaaa,                     // 5: normal laser left
	0xaaaa,                     // 6: normal laser right
	0x7666,                     // 7: left missile
	0x7666,                     // 8: center missile
	0x7666,                      // 9: right missile
	0xaaaa,                     //10: dual laser left
	0xaaaa,                     //11: dual laser right

};

W3D_Vertex rverts[4] = {
	{ 128,  78, 0,  0,  0, 1.0, 0.0, 1.0, 0.0, 1.0 },
	{ 192,  78, 0, 64,  0, 1.0, 0.0, 1.0, 0.0, 1.0 },
	{ 192, 142, 0, 64, 64, 1.0, 0.0, 1.0, 0.0, 1.0 },
	{ 128, 142, 0,  0, 64, 1.0, 0.0, 1.0, 0.0, 1.0 }
};

W3D_Triangles rtris = {
	4,
	&rverts[0],
	NULL,
	NULL
};


//  Configuration parameters
int WARP_TMap = 1;                      // TMapping on
int WARP_MipMap = 0;                    // MipMapping off
int WARP_Persp = 1;                     // Perspective correction on
int WARP_TMapSub = 0;                   // Subdivider off
int WARP_FogSub = 0;                    // Same for fogging
int WARP_Fog = 0;                       // Fogging off
int WARP_wreticle = 0;                  // Warp3D reticle
int WARP_Modulate = 1;                  // Color effects
int WARP_Filter = 1;                    // Texture filter
int WARP_Depth = 0;                     // Depth filter
int WARP_Dither = 1;                    // Dithering
W3D_Float WARP_MFactor = 3.0;           // Color effect factor
W3D_Fog WARP_FogParam = {
	0.5,                                // Start at 0.5
	0.2,                                // End at 0.2
	1.0,                                // Density 1.0 (currently ignored)
	0.0, 0.0, 0.0                       // Fog color (Black)
};

//  Hinting parameters
int WARP_HTMap  = 1;
int WARP_HMMap  = 1;
int WARP_HBif   = 1;
int WARP_HDf    = 1;
int WARP_HPers  = 1;
int WARP_HBlend = 1;
int WARP_HFog   = 1;
int WARP_HAnti  = 1;
int WARP_HDith  = 1;
ULONG Hints[3] = {W3D_H_FAST, W3D_H_AVERAGE, W3D_H_NICE};

//  Direct-access stuff
UWORD BitValues[256];
UWORD BitValuesTexture[256];
extern ULONG palette[800];
int WARP_BitValues = 0;
int WARP_automap_active = 0;

//  Prototypes
void WARP_Close(void);
void WARP_UpdateImage(W3D_Texture *tex, void *data);
void WARP_UpdateTextureCache(void);
void WARP_UpdateState(void);
void WARP_UpdateFog(void);
void WARP_UpdateHints(void);
void WARP_init_reticle(void);
void WARP_GenFireball(void);

//  Externals
extern UBYTE *OffscreenBuffer;
extern int OffscreenW;
extern int OffscreenH;
extern int OffscreenSize;
extern struct Window *win;
extern struct Screen *scr;
extern struct ScreenBuffer *sb1, *sb2;
extern unsigned long Mode320x200;
extern unsigned long Mode320x400;
extern unsigned long Mode640x480;
extern unsigned long Mode800x600;
extern int farg;
extern int wbmode;
extern UWORD *PointerData;

extern char *gr_sc_small;
extern char *gr_sc_medium;
extern char *gr_sc_large;
extern char ScreenType;
extern int depth;
extern PLANEPTR planes;
extern double wscale;
extern double hscale;
extern UBYTE *compare_buffer;
extern int VR_screen_mode;
extern int VR_render_width;
extern int VR_render_height;


#ifdef PROF_CACHE
//  Used for cache statistics
ULONG WARP_S_Update = 0;            // UpdateTexImage calls
ULONG WARP_S_Find = 0;              // FindTexture
ULONG WARP_S_Miss = 0;              // Cache misses
ULONG WARP_S_Invalid = 0;           // Invalidations
ULONG WARP_S_Make = 0;              // Texture conversion
ULONG WARP_S_Clear = 0;             // Clearings
#endif


/*
** Texture cache structure
*/
typedef struct {
	W3D_Texture *TexObj;        // Pointer to the associated TexObj
	APTR SourceData;            // Source Data of texture
	ULONG LastAccess;           // Last time this was accessed
	grs_bitmap *ref;            // Reference in Descent Texture Cache
} WarpTextureCache;

WarpTextureCache *WTCache;      // Allocated Texture Array

/*
** Initializes the texture cache
** Allocates texture objects
** Allocates Cache array
*/
void WARP_InitTextureCache(void)
{
	int i;
	ULONG error;
	struct TagItem tags [] = {
		{W3D_ATO_IMAGE,     (ULONG)DummyTex},
		{W3D_ATO_FORMAT,    W3D_A1R5G5B5},
		{W3D_ATO_WIDTH,     64},
		{W3D_ATO_HEIGHT,    64},
		{TAG_DONE,          0}
	};

	struct TagItem Mtags [] = {
		{W3D_ATO_IMAGE,     (ULONG)DummyTex},
		{W3D_ATO_FORMAT,    W3D_A1R5G5B5},
		{W3D_ATO_WIDTH,     64},
		{W3D_ATO_HEIGHT,    64},
		{W3D_ATO_MIPMAP,    0x3f},
		{TAG_DONE,          0}
	};


	debug(("WARP_InitTextureCache: Creating texture cache using %d entries\n", WARP_NumTex));

	WTCache = malloc(sizeof(WarpTextureCache)*WARP_NumTex);
	if (!WTCache) {
		printf("Unable to create texture cache\n");
		exit(0);
	}

	for (i=0; i<WARP_NumTex; i++) {
		if (WARP_MipMap)
			WTCache[i].TexObj = W3D_AllocTexObj(WARP_Context, &error, Mtags);
		else
			WTCache[i].TexObj = W3D_AllocTexObj(WARP_Context, &error, tags);
		if (error != W3D_SUCCESS) {
			printf("Texture cache initialization failed because of error %d\n", error);
			exit(0);
		}
		WTCache[i].SourceData = NULL;
		WTCache[i].LastAccess = 0;
		WTCache[i].ref        = NULL;
		W3D_SetTexEnv(WARP_Context, WTCache[i].TexObj, W3D_MODULATE, NULL);
		W3D_SetBlendMode(WARP_Context, W3D_SRC_ALPHA, W3D_ONE_MINUS_SRC_ALPHA);
		W3D_SetWrapMode(WARP_Context, WTCache[i].TexObj, W3D_REPEAT, W3D_REPEAT, NULL);
	}
	WARP_UpdateTextureCache();
	debug(("WARP_InitTextureCache: Done\n"));
}

/*
** Frees all memory associated with texture cache and texture objects
*/
void WARP_DeleteTextureCache(void)
{
	int i;
	if (!WTCache) return;

	debug(("WARP_DeleteTextureCache: Freeing texture cache\n"));

	if (WARP_ready != 0) {
		for (i=0; i<WARP_NumTex; i++) {
			W3D_FreeTexObj(WARP_Context, WTCache[i].TexObj);
		}
	} else {
		printf("Warning: Freeing texture cache while Warp3D is disabled\n");
	}

	free(WTCache);
	WTCache = NULL;
	debug(("WARP_DeleteTextureCache: Done\n"));
}

/*
** Invalidate all entries in the texture cache
*/
void WARP_ClearTextureCache(void)
{
	int i;
	if (WARP_ready == 0) return;
#ifdef PROF_CACHE
	WARP_S_Clear++;
#endif
	if (!WTCache || WARP_ready == 0) return;
	debug(("WARP_ClearTextureCache: Clearing Texture Cache\n"));
	for (i=0; i<WARP_NumTex; i++) {
		WTCache[i].ref = NULL;
	}
	debug(("WARP_ClearTextureCache: Done\n"));
}


/*
**  WARP_SingleBuffer
**  Make sure the first buffer is set
*/
#ifndef SCBUF
void WARP_SingleBuffer(void)
{
	static int active = 0;
	W3D_Scissor s = {0,0, win->Width, win->Height/2};
	struct Screen *scr = win->WScreen;
	struct ViewPort *vp = &(scr->ViewPort);

	if (active == 0) {
		W3D_SetDrawRegion(WARP_Context, win->RPort->BitMap, 0, &s);
		vp->RasInfo->RyOffset = 0;
		ScrollVPort(vp);
		active = 1;
	}
}
#else
void WARP_SwitchBuffer(void);

void WARP_SingleBuffer(void)
{
	W3D_Scissor s = {0,0, win->Width, win->Height/2};
	struct Screen *scr = win->WScreen;
	struct ViewPort *vp = &(scr->ViewPort);

	if (WARP_Buffer != 0) {
		WARP_SwitchBuffer();
	}

}
#endif


/*
**  WARP_SwitchBuffer
**  Switch buffer for double buffering
*/
#ifndef SCBUF
void WARP_SwitchBuffer(void)
{
	W3D_Scissor s = {0,0, win->Width, win->Height/2};
	struct Screen *scr = win->WScreen;
	struct ViewPort *vp = &(scr->ViewPort);

	W3D_WaitIdle(WARP_Context);

	if (WARP_Buffer == 0) {
		vp->RasInfo->RyOffset = win->Height/2;
		ScrollVPort(vp);
		W3D_SetDrawRegion(WARP_Context, win->RPort->BitMap, 0, &s);
		WARP_Buffer = 1;
	} else {
		vp->RasInfo->RyOffset = 0;
		ScrollVPort(vp);
		W3D_SetDrawRegion(WARP_Context, win->RPort->BitMap,
			win->Height/2, &s);
		WARP_Buffer = 0;
	}
}
#else
void WARP_SwitchBuffer(void)
{
	W3D_Scissor s = {0,0, win->Width, win->Height/2};
	struct Screen *scr = win->WScreen;
	struct ViewPort *vp = &(scr->ViewPort);

	W3D_WaitIdle(WARP_Context);

	if (WARP_Buffer == 0) {
		ChangeScreenBuffer(scr, sb2);
		WaitBOVP(&(scr->ViewPort));
		WARP_Buffer = 1;
	} else {
		ChangeScreenBuffer(scr, sb1);
		WaitBOVP(&(scr->ViewPort));
		WARP_Buffer = 0;
	}
}
#endif


/*
**  WARP_Update
**  WritePixelArray wrapper
*/
void WARP_Update(int y)
{
	if (gr_keep_resolution == 0) {
		WritePixelArray(OffscreenBuffer, 0, 0, OffscreenW, win->RPort, 0, y,
			OffscreenW, OffscreenH, RECTFMT_LUT8);
	} else {
		/*ScalePixelArray(OffscreenBuffer, 320, 200, 320, win->RPort, 0, y,
			win->Width, win->Height*0.5, RECTFMT_LUT8);*/ // Until Cybergraphics solves this...
		if (!WARP_automap_active) {
			WritePixelArray(OffscreenBuffer, 0, 0, 320, win->RPort, win->Width*0.5-160, y+(win->Height*0.25)-100,
				320, 200, RECTFMT_LUT8);
		} else {
			WritePixelArray(OffscreenBuffer, 0, 0, VR_render_width, win->RPort, 0, y,
				VR_render_width, VR_render_height, RECTFMT_LUT8);
		}
	}

	WARP_SwitchBuffer();
}


/*
**  WARP_Error
**  Print error message
*/
void WARP_Error(ULONG code)
{
	switch (code) {
		case W3D_SUCCESS:           printf("No error\n"); break;
		case W3D_ILLEGALINPUT:      printf("Illegal input\n"); break;
		case W3D_NOMEMORY:          printf("No memory left\n"); break;
		case W3D_NODRIVER:          printf("No driver is loaded\n"); break;
		case W3D_UNSUPPORTEDFMT:    printf("The bitmap format is not supported\n"); break;
		case W3D_ILLEGALBITMAP:     printf("The bitmap is not initialized correctly\n"); break;
		case W3D_UNSUPPORTEDTEXSIZE:printf("Unsupported texture size\n");
		case W3D_NOPALETTE:         printf("Need palette\n");
		default:                    printf("Unknown error code\n"); break;
	}
}


/*
**  WARP_Init
**  Initialise the Warp3D subsystem
*/
void WARP_Init(struct Window *win, ULONG mode)
{
	/*
	** Some of the tag's ti_Data fields are filled in later
	*/
	struct TagItem tags[] = {
		{W3D_CC_BITMAP,     NULL},
		{W3D_CC_YOFFSET,    0},
		{W3D_CC_DRIVERTYPE, W3D_DRIVER_BEST},
		{W3D_CC_DOUBLEHEIGHT,TRUE},
		{W3D_CC_FAST,       TRUE},
		{W3D_CC_INDIRECT,   FALSE},             //  set later
		{W3D_CC_MODEID,     0},
		{TAG_DONE,          0}
	};

	struct TagItem ATO_Tags[] = {
		{W3D_ATO_IMAGE,     (ULONG)DummyTex},
		{W3D_ATO_FORMAT,    W3D_A1R5G5B5},
		{W3D_ATO_WIDTH,     64},
		{W3D_ATO_HEIGHT,    64}
	};

	struct TagItem ATO_TagsT[] = {
		{W3D_ATO_IMAGE,     (ULONG)TransTex},
		{W3D_ATO_FORMAT,    W3D_A4R4G4B4},
		{W3D_ATO_WIDTH,     2},
		{W3D_ATO_HEIGHT,    2}
	};

	struct TagItem ATO_TagsW[] = {
		{W3D_ATO_IMAGE,     (ULONG)WhiteTex},
		{W3D_ATO_FORMAT,    W3D_A1R5G5B5},
		{W3D_ATO_WIDTH,     2},
		{W3D_ATO_HEIGHT,    2}
	};


	/*
	** Height is used to calculate the real display height
	** and the correct offset for double buffering
	**
	** CError is used as an error variable during context creation
	*/
	ULONG Height, CError;

	/*
	** Used for LockBitmap
	*/
	void *handle;
	UBYTE *scrn;
	ULONG bpr;
	int i;

	debug(("WARP_Init: Initialising Warp3D\n"));

#if 0
	//  Free existing context (if any)
	if (WARP_Context) {
		WARP_DeleteTextureCache();
		if (WARP_Dummy) W3D_FreeTexObj(WARP_Context, WARP_Dummy);
		if (WARP_Trans) W3D_FreeTexObj(WARP_Context, WARP_Trans);
		if (WARP_White) W3D_FreeTexObj(WARP_Context, WARP_White);
		if (WARP_Reticle) W3D_FreeTexObj(WARP_Context, WARP_Reticle);
		W3D_DestroyContext(WARP_Context);
		WARP_Context = NULL;
		WARP_Dummy = NULL;
		WARP_Trans = NULL;
		WARP_White = NULL;
		WARP_Reticle = NULL;
	}
#endif
		// Insert values into Taglist
		Height = win->Height / 2;
		tags[0].ti_Data = (ULONG)(win->RPort->BitMap);
		tags[1].ti_Data = Height;
		if (FindArg("-indirect"))
			tags[5].ti_Data = TRUE;
		else
			tags[5].ti_Data = FALSE;

	tags[6].ti_Data = mode;

	if (!WARP_Context) {
		// Create context
		WARP_Context = W3D_CreateContext(&CError, tags);
		if (!WARP_Context) {
			printf("ERROR: W3D_CreateContext failed:");
			WARP_Error(CError);
			exit(0);
		}

		debug(("WARP_Init: Setting state\n"));
		W3D_SetState(WARP_Context, W3D_GOURAUD, W3D_ENABLE);
		W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_ENABLE);
		W3D_SetState(WARP_Context, W3D_BLENDING, W3D_ENABLE);
		W3D_SetState(WARP_Context, W3D_PERSPECTIVE, W3D_ENABLE);
		W3D_SetBlendMode(WARP_Context, W3D_SRC_ALPHA, W3D_ONE_MINUS_SRC_ALPHA);
	} else {
		debug(("WARP_Init: Setting draw region\n"));
		W3D_SetDrawRegion(WARP_Context, (win->RPort->BitMap), 0, NULL);
		debug(("WARP_Init: New bitmap is %ld×%ld\n", WARP_Context->width,
				WARP_Context->height));
	}

	//  Initialize Double buffering
	Forbid();
	handle = LockBitMapTags(win->RPort->BitMap,
		LBMI_BASEADDRESS,   (ULONG)&scrn,
		LBMI_BYTESPERROW,   (ULONG)&bpr,
	TAG_DONE);
	UnLockBitMap(handle);
	Permit();
	WARP_Buffers[0] = (void *)scrn;
	WARP_Buffers[1] = (void *)((char *)scrn+bpr*Height);
	WARP_BytesPerRow = bpr;
	WARP_PixelsPerRow = bpr/2;
	WARP_Buffer = 1;        // Draw to second buffer
	WARP_Window = win;

	if (WARP_Dummy) {
		//  Create Dummy texture
		debug(("WARP_Init: Creating dummy texture\n"));
		for (i = 0; i < 64*64; i++) {
			if (i%2) DummyTex[i] = 0xffff;
			else     DummyTex[i] = 0x0;
		}
		WARP_Dummy = W3D_AllocTexObj(WARP_Context, &CError, ATO_Tags);
		if (CError != W3D_SUCCESS) {
			printf("Warning: W3D_AllocTexObj failed for dummy texture:");
			WARP_Error(CError);
		} else {
			debug(("WARP_Init: Dummy at 0x%x\n", WARP_Dummy));
		}
		W3D_SetWrapMode(WARP_Context, WARP_Dummy, W3D_REPEAT, W3D_REPEAT, NULL);
		W3D_SetTexEnv(WARP_Context, WARP_Dummy, W3D_MODULATE, NULL);
		W3D_SetFilter(WARP_Context, WARP_Dummy, W3D_LINEAR, W3D_LINEAR);
	}

	if (WARP_Trans) {
		//  Create Transparent texture
		debug(("WARP_Init: Creating transparent texture\n"));
		WARP_Trans = W3D_AllocTexObj(WARP_Context, &CError, ATO_TagsT);
		if (CError != W3D_SUCCESS) {
			printf("Warning: W3D_AllocTexObj failed for transparency texture:");
			WARP_Error(CError);
		}
		W3D_SetWrapMode(WARP_Context, WARP_Trans, W3D_REPEAT, W3D_REPEAT, NULL);
		W3D_SetTexEnv(WARP_Context, WARP_Trans, W3D_MODULATE, NULL);
		W3D_SetFilter(WARP_Context, WARP_Trans, W3D_LINEAR, W3D_LINEAR);

		debug(("WARP_Init: Creating white texture\n"));
		WARP_White = W3D_AllocTexObj(WARP_Context, &CError, ATO_TagsW);
		if (CError != W3D_SUCCESS) {
			printf("Warning: W3D_AllocTexObj failed for white texture:");
			WARP_Error(CError);
		}
		W3D_SetWrapMode(WARP_Context, WARP_White, W3D_REPEAT, W3D_REPEAT, NULL);
		W3D_SetTexEnv(WARP_Context, WARP_White, W3D_MODULATE, NULL);
		W3D_SetFilter(WARP_Context, WARP_White, W3D_NEAREST, W3D_NEAREST);
	}

	//  Init reticle
	WARP_init_reticle();

	//  Create fireball
	WARP_GenFireball();

	//  Create texture cache
	debug(("WARP_Init: Initializing texture cache\n"));
	if (!WTCache) WARP_InitTextureCache();

	WARP_ready = 1;

	//  Settings
	WARP_UpdateHints();
#if 0
	WARP_UpdateFog();
	WARP_UpdateTextureCache();
	WARP_UpdateState();
#endif

	//  Schedule closing of Warp on exit
	atexit(WARP_Close);
	debug(("WARP_Init: Done\n"));
}

/*
**  WARP_FirstBuffer
**  Make sure the first buffer is active
*/
void* WARP_FirstBuffer(void)
{
		if (WARP_Buffer == 0) return WARP_GetBufferAddress();
		WARP_SwitchBuffer();
		return WARP_GetBufferAddress();
}


/*
**  WARP_Close
**  Free everything WarpP3D-Related
*/
void WARP_Close(void)
{
	if (WARP_ready == 0) return;

	debug(("WARP_Close: Closing Warp3D\n"));

	debug(("WARP_Close: Deleting texture cache\n"));
	WARP_DeleteTextureCache();

	if (WARP_Dummy) {
		debug(("WARP_Close: Deleting dummy\n"));
		W3D_FreeTexObj(WARP_Context, WARP_Dummy);
	}

	if (WARP_Trans) {
		debug(("WARP_Close: Deleting transparency texture\n"));
		W3D_FreeTexObj(WARP_Context, WARP_Trans);
	}

	if (WARP_White) {
		debug(("WARP_Close: Deleting white texture\n"));
		W3D_FreeTexObj(WARP_Context, WARP_White);
	}

	if (WARP_Reticle) {
		debug(("WARP_Close: Deleting reticle texture\n"));
		W3D_FreeTexObj(WARP_Context, WARP_Reticle);
		if (wreticle) gr_free_bitmap(wreticle);
	}

	if (WARP_Fireball) {
		debug(("WARP_Close: Deleting fireball texture\n"));
		W3D_FreeTexObj(WARP_Context, WARP_Fireball);
	}

	if (WARP_Context) {
		debug(("WARP_Close: Deleting context\n"));
		W3D_DestroyContext(WARP_Context);
		WARP_Context = NULL;
	}

	WARP_ready = 0;

	debug(("WARP_Close: Done\n"));

#ifdef PROF_CACHE
	printf("\nStatistics for texture cache:\n");
	printf(  "-----------------------------\n");
	printf("Calls to UpdateTexImage:    %8d\n", WARP_S_Update);
	printf("Single invalidations:       %8d\n", WARP_S_Invalid);
	printf("Texture creation:           %8d\n", WARP_S_Make);
	printf("Total cache invalidations:  %8d\n", WARP_S_Clear);
	printf("Cache accesses:             %8d\n", WARP_S_Find);
	printf("Cache misses:               %8d\n", WARP_S_Miss);
	printf("Hit/Miss ratio:             %8.3g%\n", 100 - (((float)WARP_S_Miss/(float)WARP_S_Find) * 100.0));
	printf("\n");
#endif
}


/*
**  WARP_Kludge
**  RectFil to get around the Text() bug
*/
void WARP_Kludge(void)
{
//    RectFill(win->RPort, 0, 0, 0, 0);
}

// Now a macro
#if 0
/*
**  WARP_GetBufferAddress
**  Get address of current buffer
*/
void *WARP_GetBufferAddress(void)
{
  return WARP_Buffers[1-WARP_Buffer];
}
#endif

/*
** Generates an array of 16 bit words for the generation of textures.
** Words are in the format ARGB1555
*/
void WARP_MakeBitValues(void)
{
	ubyte r,g,b;
	int i;
	// Leave if the values are computed
	if (WARP_BitValues == 1) return;

	// Make sure the palette is completely faded in
	if (gr_palette_faded_out) gr_palette_fade_in(gr_palette, 1,0);

	// Build the ARGB table. Alpha value is always 1, meaning
	// full opacity.
	// The strange shift values are because Descent uses a 64 step
	// VGA palette
	for (i=0; i<255; i++) {
		r=palette[1+i*3]>>24;
		g=palette[1+i*3+1]>>24;
		b=palette[1+i*3+2]>>24;
		switch (gr_pixfmt) {
		case PIXFMT_RGB15:
			BitValues[i] = 0x8000 | (r&0xF8)<<7 | (g&0xF8)<<2 | (b&0xF8)>>3;
			break;
		case PIXFMT_RGB15PC:
			BitValues[i] = 0x8000 | (r&0xF8)<<7 | (g&0xF8)<<2 | (b&0xF8)>>3;
			BitValues[i] = (BitValues[i]>>8) & 0x00ff | (BitValues[i]<<8) & 0xff00;
			break;
		case PIXFMT_BGR15:
			BitValues[i] = 0x8000 | (b&0xF8)<<7 | (g&0xF8)<<2 | (r&0xF8)>>3;
			break;
		case PIXFMT_BGR15PC:
			BitValues[i] = 0x8000 | (b&0xF8)<<7 | (g&0xF8)<<2 | (r&0xF8)>>3;
			BitValues[i] = (BitValues[i]>>8) & 0x00ff | (BitValues[i]<<8) & 0xff00;
			break;
		}
		BitValuesTexture[i] = 0x8000 | (r&0xF8)<<7 | (g&0xF8)<<2 | (b&0xF8)>>3;
	}
	// BitValue 255 is set to zero to indicate full transparency
	BitValues[255] = 0;
	BitValuesTexture[255] = 0;
	// Make those values valid
	WARP_BitValues=1;
	// Invalidate the texture cache, so that new textures
	// are correctly re-calculated.
	WARP_ClearTextureCache();
}

/*
** Makes the BitValue array, but invalidates it immediately
** Used for temporarily allocating textures.
*/
void WARP_MakeTempBitValues(void)
{
	WARP_MakeBitValues();
	WARP_BitValues=0;
}

/*
** Convert a LUT8 texture to ARGB.
**
** The process is straigtforward, since the required information
** is available in the BitArray
**
** Uses the BitArray supplied to convert from source BYTES to
** target WORDS
*/
void WARP_MakeARGBTexture(UWORD *BitArray, UBYTE *source, UWORD *target)
{
	/*
	** Implementation note:
	** I didn't use a for loop because the loop below is easier to optimizes. The
	** compiler will detect that the variable <i> is not needed, and optimize it
	** away...
	**
	** For maximum speed, this loop could be unrolled a few times. However,
	** experience showed that this routine is actually seldomly called.
	*/
	int i;
#ifdef PROF_CACHE
	WARP_S_Make++;
#endif
	i=4096;
	while (i) {
		*target++=*(BitArray+*source++);
		i--;
	}
}

/*
** Get Oldest Entry in the texture cache
**
** This routine looks through the texture cache and searches for the
** least recently used entry. I could have done this using a self-organizing
** list, but this would have introduced additional overhead during the
** case when the texture was actually cached. Since the cache-miss case
** is much more infrequent (around 98% are hits), I chose this implementation.
*/
int WARP_GetOldestEntry(void)
{
	int i;
	int oldidx=0;
	for (i=0; i<WARP_NumTex; i++) {
		if (WTCache[i].LastAccess < WTCache[oldidx].LastAccess) {
			oldidx = i;
		}
	}
	return oldidx;
}

/*
** Invalidate the cache entry associated with the given bitmap
*/
void WARP_InvalidCacheEntry(grs_bitmap *map)
{
	int i = (int)map->bm_Handle;
#ifdef PROF_CACHE
	WARP_S_Invalid++;
#endif
	map->bm_Handle = 0;
	if (i>=WARP_NumTex || i<=0) return;
	if (WTCache[i].ref != map) return;
	WTCache[i].ref = NULL;
	WTCache[i].LastAccess = 0;
}

/*
** Find a texture
**
** Tries to find the texture corresponding to a given bitmap
** If the texture is not cached, the least recently used texture
** is killed, and a new entry is created for that.
*/
W3D_Texture* WARP_FindTexture(grs_bitmap *map)
{
	int i;
	grs_bitmap *oldmap = map;
	fix now = timer_get_fixed_seconds();

#ifdef PROF_CACHE
	WARP_S_Find++;
#endif

	WARP_MakeBitValues();   // Create bit values if not present

	// If this bitmap has a handle, check if it is valid
	if (map->bm_Handle) {
		if (WTCache[(int)map->bm_Handle].ref == map) {
			WTCache[(int)map->bm_Handle].LastAccess = now;
			return WTCache[(int)map->bm_Handle].TexObj;
		} else {
			map->bm_Handle = 0;
		}
	}

	/*
	** Cache miss
	** The bitmap was not in the cache, or the cache entry has
	** already been invalidated.
	**
	*/

#ifdef PROF_CACHE
	WARP_S_Miss++;
#endif

	// Step one     expand a compressed texture
	if (map->bm_flags & BM_FLAG_RLE)
		map = rle_expand_texture(map);


	// Step two     find a suitable entry
	i = WARP_GetOldestEntry();

	// Step three   make a texture and upload it
	if (map == NULL || map->bm_data == NULL) {
		int j;
		for (j=0; j<4096; j++) DummyTex[i] = 0xffff;
	} else {
		WARP_MakeARGBTexture(BitValuesTexture, map->bm_data, DummyTex);
	}

	WARP_UpdateImage(WTCache[i].TexObj, DummyTex);

	// Use the handle field to store the cache entry for fast retrieval
	oldmap->bm_Handle = (void *)i;

	// Set the reference pointer and time code
	WTCache[i].ref          = oldmap;
	WTCache[i].LastAccess   = now;

	return WTCache[i].TexObj;
}


/*
**  WARP_UpdateImage
**  Warpper for UpdateTexImage
*/
void WARP_UpdateImage(W3D_Texture *tex, void *data)
{
	ULONG error;
	int i;

	error = W3D_UpdateTexImage(WARP_Context, tex, data, 0, NULL);

	if (error != W3D_SUCCESS)
		printf("Warning: W3D_UpdateTexImage returned %d\n", error);


#ifdef PROF_CACHE
	WARP_S_Update++;
#endif
}


/*
**  WARP_UpdateState
**  Updates the state according to user preferences
*/
void WARP_UpdateState(void)
{
	if (WARP_Persp == 0)        W3D_SetState(WARP_Context, W3D_PERSPECTIVE, W3D_DISABLE);
	else                        W3D_SetState(WARP_Context, W3D_PERSPECTIVE, W3D_ENABLE);

	if (WARP_TMap == 0)         W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_DISABLE);
	else                        W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_ENABLE);

	if (WARP_Dither == 0)       W3D_SetState(WARP_Context, W3D_DITHERING, W3D_DISABLE);
	else                        W3D_SetState(WARP_Context, W3D_DITHERING, W3D_ENABLE);

	WARP_Persp =  (W3D_GetState(WARP_Context, W3D_PERSPECTIVE) == W3D_ENABLED ? 1: 0);
	WARP_TMap =   (W3D_GetState(WARP_Context, W3D_TEXMAPPING) == W3D_ENABLED ? 1: 0);
	WARP_Dither = (W3D_GetState(WARP_Context, W3D_DITHERING) == W3D_ENABLED ? 1: 0);

	WARP_ClearTextureCache();
}

/*
**  WARP_UpdateTextureCache
**  Update the textures' filter modes
*/
void WARP_UpdateTextureCache(void)
{
	int i;
	ULONG filter, mfilter;

	if (WARP_Filter == 0)    filter = W3D_NEAREST;
	if (WARP_Filter == 1)    filter = W3D_LINEAR;
	mfilter = filter;

	if (WARP_MipMap) {
		if (filter == W3D_NEAREST && WARP_Depth == 0) filter = W3D_NEAREST_MIP_NEAREST;
		if (filter == W3D_NEAREST && WARP_Depth == 1) filter = W3D_NEAREST_MIP_LINEAR;
		if (filter == W3D_LINEAR && WARP_Depth == 0)  filter = W3D_LINEAR_MIP_NEAREST;
		if (filter == W3D_LINEAR && WARP_Depth == 1)  filter = W3D_LINEAR_MIP_LINEAR;
	}

	for (i=0; i<WARP_NumTex; i++)
		W3D_SetFilter(WARP_Context, WTCache[i].TexObj, filter, mfilter);

	WARP_ClearTextureCache();
}


/*
**  WARP_UpdateFog
**  Update and set fogging
*/
void WARP_UpdateFog(void)
{
	if (WARP_Fog == 0)      W3D_SetState(WARP_Context, W3D_FOGGING, W3D_DISABLE);
	else {
		W3D_SetState(WARP_Context, W3D_FOGGING, W3D_ENABLE);
		W3D_SetFogParams(WARP_Context, &WARP_FogParam, W3D_FOG_INTERPOLATED);
	}
	WARP_ClearTextureCache();
}

/*
**  WARP_UpdateHints
**  Update the W3D_Hint
*/
void WARP_UpdateHints(void)
{
	W3D_Hint(WARP_Context, W3D_H_TEXMAPPING,        Hints[WARP_HTMap]);
	W3D_Hint(WARP_Context, W3D_H_MIPMAPPING,        Hints[WARP_HMMap]);
	W3D_Hint(WARP_Context, W3D_H_BILINEARFILTER,    Hints[WARP_HBif]);
	W3D_Hint(WARP_Context, W3D_H_MMFILTER,          Hints[WARP_HDf]);
	W3D_Hint(WARP_Context, W3D_H_PERSPECTIVE,       Hints[WARP_HPers]);
	W3D_Hint(WARP_Context, W3D_H_BLENDING,          Hints[WARP_HBlend]);
	W3D_Hint(WARP_Context, W3D_H_FOGGING,           Hints[WARP_HFog]);
	W3D_Hint(WARP_Context, W3D_H_ANTIALIASING,      Hints[WARP_HAnti]);
	W3D_Hint(WARP_Context, W3D_H_DITHERING,         Hints[WARP_HDith]);
	WARP_ClearTextureCache();
}

/*
**  WARP_init_reticle
**  Initialise the warp reticle
*/
void WARP_init_reticle(void)
{
	struct TagItem ATO_Tags[] = {
		{W3D_ATO_IMAGE,     (ULONG)ReticleTex},
		{W3D_ATO_FORMAT,    W3D_A4R4G4B4},
		{W3D_ATO_WIDTH,     64},
		{W3D_ATO_HEIGHT,    64}
	};
	int ifferror, x, y, i, j;
	unsigned char a, b;
	UWORD *to;
	ULONG CError;

	if (wreticle == NULL) {     // create and load bitmao
		wreticle = gr_create_bitmap(64, 64);
		ifferror = iff_read_into_bitmap("reticle.iff", wreticle, NULL);
		if (ifferror != IFF_NO_ERROR) {
			printf("Error: Can`t get reticle bitmap: %d\n", ifferror);
			WARP_wreticle = 0;
			return;
		}
	}

	to = &ReticleTex[0];
	for (i = 0; i < 64*64; i++) {   //  create texture from bitmap
		a = wreticle->bm_data[i];
		if (a <= 11) *to++ = rcol[a];
		else         *to++ = 0x0000;
	}

	WARP_Reticle = W3D_AllocTexObj(WARP_Context, &CError, ATO_Tags);
	if (CError != W3D_SUCCESS) {
		printf("Warning: W3D_AllocTexObj failed for reticle texture:");
		WARP_Error(CError);
		WARP_wreticle = 0;
		return;
	}
	W3D_SetWrapMode(WARP_Context, WARP_Reticle, W3D_REPEAT, W3D_REPEAT, NULL);
	W3D_SetTexEnv(WARP_Context, WARP_Reticle, W3D_MODULATE, NULL);
	W3D_SetFilter(WARP_Context, WARP_Reticle, W3D_LINEAR, W3D_LINEAR);
}



/*
**  WARP_show_reticle
**  Draw the Warp3D MEGA reticle
*/

void WARP_show_reticle(void)
{
	int laser_ready = allowed_to_fire_laser();
	int i, j;

	if (WARP_wreticle == 0) return;

	rtris.tex = WARP_Reticle;
	W3D_LockHardware(WARP_Context);
	W3D_DrawTriFan(WARP_Context, &rtris);
	W3D_UnLockHardware(WARP_Context);

}


/*
**  WARP_AddLight
**  Add light component
*/
W3D_Float WARP_AddLight(W3D_Float c, int add)
{
	W3D_Float b, a = add/256.0;
	b = c + a * WARP_MFactor;
	if (b > 1.0) b = 1.0;
	return b;
}


/*
** WARP_select_mode
** Select screen modes
*/
int WARP_select_mode(void)
{
	Mode320x200 = W3D_RequestModeTags(
		W3D_SMR_TYPE,       W3D_DRIVER_3DHW,
		W3D_SMR_SIZEFILTER, TRUE,
		W3D_SMR_DESTFMT,    W3D_FMT_R5G5B5,
		ASLSM_TitleText,    (ULONG)"Select Screen mode for 320x200 Screens",
		ASLSM_MinWidth,     320,
		ASLSM_MaxWidth,     321,
		ASLSM_MinHeight,    200,
		ASLSM_MaxHeight,    256,
	TAG_DONE);

	if (Mode320x200 == INVALID_ID)  return 0;

	Mode320x400 = W3D_RequestModeTags(
		W3D_SMR_TYPE,       W3D_DRIVER_3DHW,
		W3D_SMR_SIZEFILTER, TRUE,
		W3D_SMR_DESTFMT,    W3D_FMT_R5G5B5,
		ASLSM_TitleText,    (ULONG)"Select Screen mode for 320x400 Screens",
		ASLSM_MinWidth,     320,
		ASLSM_MaxWidth,     640,
		ASLSM_MinHeight,    400,
		ASLSM_MaxHeight,    512,
	TAG_DONE);

	Mode640x480 = W3D_RequestModeTags(
		W3D_SMR_TYPE,       W3D_DRIVER_3DHW,
		W3D_SMR_SIZEFILTER, TRUE,
		W3D_SMR_DESTFMT,    W3D_FMT_R5G5B5,
		ASLSM_TitleText,    (ULONG)"Select Screen mode for 640x480 Screens",
		ASLSM_MinWidth,     640,
		ASLSM_MaxWidth,     641,
		ASLSM_MinHeight,    480,
		ASLSM_MaxHeight,    512,
	TAG_DONE);

	if (Mode640x480 == INVALID_ID)  return 0;

	Mode800x600 = W3D_RequestModeTags(
		W3D_SMR_TYPE,       W3D_DRIVER_3DHW,
		W3D_SMR_SIZEFILTER, TRUE,
		W3D_SMR_DESTFMT,    W3D_FMT_R5G5B5,
		ASLSM_TitleText,    (ULONG)"Select Screen mode for 800x600 Screens",
		ASLSM_MinWidth,     800,
		ASLSM_MaxWidth,     801,
		ASLSM_MinHeight,    600,
		ASLSM_MaxHeight,    601,
	TAG_DONE);

	if (Mode800x600 == INVALID_ID)  return 0;

	return 1;
}


/*
**  WARP_set_mode
**  Warp3D version of gr_set_mode
*/
int WARP_set_mode(int mode)
{
	int w, h, r, x, y;
	ULONG sa_error;
	int real_mode = mode;
	char *smode;
	int i;
	long cmode;
	ulong adr;
	int direct = 0;
	struct DisplayInfo di_info;
	DisplayInfoHandle di_handle;
	struct Screen *scr2=NULL;
	struct Window *win2=NULL;

	if (gr_keep_resolution && scr) {

		switch (mode) {
			case SM_ORIGINAL:
				return 0;
			case SM_320x200x8:
			case SM_320x200C:
			case SM_320x200x8UL:
				w = 320;
				h = 200;
				smode = gr_sc_small;
				x = 0;
				y = 0;
				cmode = Mode320x200;
				break;
			case SM_320x400U:
				w = 320;
				h = 400;
				smode = gr_sc_medium;
				x = 0;
				y = 0;
				if (Mode320x400 == INVALID_ID) {
					cmode = Mode640x480;
					w = 640;
					h = 480;
				} else {
					cmode = Mode320x400;
				}
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
				x = 0;
				y = 0;
				cmode = Mode640x480;
				break;
		}

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
		grd_curscreen->sc_canvas.cv_bitmap.bm_data = (ubyte *)OffscreenBuffer;

		if (w>600) {
			wscale = (w+1)/w;
			hscale = (h+1)/h;
		} else {
			wscale = 1.0;
			hscale = 1.0;
		}

		gr_set_current_canvas(NULL);

		FillPixelArray(win->RPort, 0, 0, win->Width, win->Height, 0);
		bzero(OffscreenBuffer, VR_render_width*VR_render_height);

		gr_pixfmt = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_PIXFMT);

		WARP_Init(win, cmode);

		return 0;
	}

	if (!PointerData) {
		PointerData = AllocVec(256, MEMF_CLEAR|MEMF_CHIP);
		farg = FindArg("-smr");
		wbmode = 0;
	}

	if (Mode320x200 == 0 || Mode320x400 == 0 || Mode640x480 == 0 || Mode800x600 == 0 || farg != 0) {
		if (farg != 0) {
			Mode320x200 = 0;
			Mode320x400 = 0;
			Mode640x480 = 0;
			Mode800x600 = 0;
			farg = 0;
		}
		if (WARP_select_mode() == 0) {
			printf("Error: ScreenMode request canceled, or invalid mode\n");
			exit(1);
		}
	}


	if (scr) {
		scr2 = scr;
		win2 = win;
		scr=NULL;
	}

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
			x = 0;
			y = 0;
			cmode = Mode320x200;
			break;
		case SM_320x400U:
			w = 320;
			h = 400;
			smode = gr_sc_medium;
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
			x = 0;
			y = 0;
			cmode = Mode640x480;
			break;

	}

	ScreenType = 1;
	depth = 15;

	if (scr) {
		scr2 = scr;
		win2 = win;
		scr=NULL;
	}

	planes = 0;

	if (!scr) {
		int f = 2;
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
	}

	if (scr->Width < w || scr->Height < h) {
		Error("Selected video mode too small\n");
		exit(0);
	}


	if (OffscreenBuffer)
		FreeVec(OffscreenBuffer);

	if (gr_keep_resolution == 1)
		OffscreenBuffer = AllocVec(VR_render_width*VR_render_height, MEMF_CLEAR);
	else
		OffscreenBuffer = AllocVec(w*h, MEMF_CLEAR);

	if (!OffscreenBuffer) {
			Error("No memory for offscreen buffer\n");
			exit(0);
	}

	OffscreenH = h;
	OffscreenW = w;
	OffscreenSize = (h*w)/8;

	if (compare_buffer) FreeVec(compare_buffer);
	compare_buffer = 0;

	if (scr && scr2) {
		CloseWindow(win2);
		CloseScreen(scr2);
	}

	if (win && wbmode == 0) {
		SetPointer(win, PointerData, 16, 16, 1, 1);
	}

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
	grd_curscreen->sc_canvas.cv_bitmap.bm_data = (ubyte *)OffscreenBuffer;

	if (w>600) {
		wscale = (w+1)/w;
		hscale = (h+1)/h;
	} else {
		wscale = 1.0;
		hscale = 1.0;
	}

	gr_set_current_canvas(NULL);

	gr_pixfmt = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_PIXFMT);

	WARP_Init(win, cmode);

	return 0;
}


/*
** WARP_GenFireball
** Load and generate fireball texture
*/
void WARP_GenFireball(void)
{
#if 0
	int i, x, y;
	char a;
	ULONG error;
	FILE *fh = fopen("explosion.p5", "rb");
	struct TagItem tags [] = {
		{W3D_ATO_IMAGE,     (ULONG)Fireball},
		{W3D_ATO_FORMAT,    W3D_A8R8G8B8},
		{W3D_ATO_WIDTH,     64},
		{W3D_ATO_HEIGHT,    64},
		{TAG_DONE,          0}


	i = fscanf(fh, "P5\n%ld %ld\n255\n", &x, &y);

	if (i != 2) {
		printf("Warning: explosion.p5 is no PPM file\n");
		fclose(fh);
		return;
	}

	if (x != 64 && y != 64) {
		printf("Warning: explosion.p5 has wrong size\n");
		fclose(fh);
		return;
	}

	for (i = 0; i < 64*64; i++) {
		a = fgetc(fh);
		Fireball[i] = a<<24 | 0xFFFFFF;
	}

	fclose(fh);

	WARP_Fireball = W3D_AllocTexObj( WARP_context, &error, tags);

	if (error != W3D_SUCCESS) {
		printf("Warning: Can't create fireball texture: %ld\n", error);
		WARP_Fireball = NULL;
		return;
	}
#endif
}


/*
** WARP_DrawFireball
** Draw a Warp3D fireball
*/

void WARP_DrawFireball(object *obj, fix timeleft)
{
#if 0
	g3s_point pnt;
	W3D_Triangle t1, t2;
	fix t,w,h;

	if (g3_rotate_point(&pnt,pos) & CC_BEHIND)
		return 1;

	g3_project_point(&pnt);

	if (pnt.p3_flags & PF_OVERFLOW)
		return 1;

	if (checkmuldiv(&t,width,Canv_w2,pnt.p3_z))
		w = fixmul(t,Matrix_scale.x);
	else
		return 1;

	if (checkmuldiv(&t,height,Canv_h2,pnt.p3_z))
		h = fixmul(t,Matrix_scale.y);
	else
		return 1;

	blob_vertices[0].x = pnt.p3_sx - w;
	blob_vertices[0].y = blob_vertices[1].y = pnt.p3_sy - h;
	blob_vertices[1].x = blob_vertices[2].x = pnt.p3_sx + w;
	blob_vertices[2].y = pnt.p3_sy + h;

	t1.tex = WARP_Fireball;
	t2.tex = WARP_Fireball;

	t1.v1.x = pnt.p3_sx - w;
	t1.v1.y = pnt.p3_sy - h;
	t1.v1.z = 0;
	t1.v1.w = 12.0 / f2fl(pnt.p3_z);
	t1.v1.r = t1.v1.g = t1.v1.b = 1.0;

	t1.v2.x = pnt.p3_sx - w;
	t1.v2.y = pnt.p3_sy + h;
	t1.v2.z = 0;
	t1.v2.w = t1.v1.w;
	t1.v2.r = t1.v2.g = t1.v2.b = 1.0;

	t1.v3.x = pnt.p3_sx + w;
	t1.v3.y = pnt.p3_sy - h;
	t1.v3.z = 0;
	t1.v3.w = t1.v1.w;
	t1.v3.r = t1.v3.g = t1.v3.b = 1.0;

	t2.v1 = t1.v3;
	t2.v3 = t1.v2;

	t2.v2.x = pnt.p3_sx + w;
	t2.v2.y = pnt.p3_sy + h;
	t2.v2.z = 0;
	t2.v2.w = 12.0 / f2fl(pnt.p3_z);
	t2.v2.r = t2.v2.g = t2.v2.b = 1.0;

	W3D_DrawTriangle(WARP_Context, &t1);
	W3D_DrawTriangle(WARP_Context, &t2);
#endif
}

#endif
