/*
** $Revision: 1.7 $
** $State: Exp $
** $Author: hfrieden $
** $Date: 1998/04/24 16:08:56 $
**
** Routines for ViRGE Texture handling (C part)
**
** $Log: VirgeTexture.c,v $
** Revision 1.7  1998/04/24 16:08:56  hfrieden
** Meddled with the FPS limited
**
** Revision 1.6  1998/04/09 17:09:43  hfrieden
** Added ViRGE init and new lightning stuff
**
** Revision 1.5  1998/03/31 17:05:40  hfrieden
** Added stuff for transparent cloaked ships
**
** Revision 1.4  1998/03/30 18:32:28  hfrieden
** Direct line drawing added
**
** Revision 1.3  1998/03/25 22:31:52  hfrieden
** First try for DrawTriangle3DSet
**
** Revision 1.2  1998/03/22 15:55:42  hfrieden
** Additional ViRGE stuff added
**
** Revision 1.1  1998/03/15 18:48:29  hfrieden
** Virge Texture stuff
**
*/
#ifdef VIRGIN
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <cybergraphics/cybergraphics.h>
#include <inline/cybergraphics.h>
#include <inline/intuition.h>
#include <intuition/intuition.h>
#include <intuition/screens.h>
#include <inline/graphics.h>
#include <graphics/gfx.h>
#include <inline/exec.h>
#include <exec/exec.h>
#include <clib/asl_protos.h>
#include <libraries/asl.h>
#include <inline/asl.h>

#include <cybergraphics/cgx3dvirgin.h>
#include <clib/cgx3dvirgin_protos.h>
#include <inline/cgx3dvirgin.h>

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
#include "virge.h"
#include "texmap.h"

#define MAX_TEXTURES    128
extern int Inferno_verbose;
extern View3D MyView;

extern struct Library *CGX3DVirginBase;
extern struct Library *SysBase;
extern struct Library *DOSBase;


void (*PolygonRenderer)(g3ds_tmap *tmap, const APTR texture);

void *VirgeGetBuffer(void);

typedef struct {
	struct Screen *scr;
	struct Window *win;
} MyView3D;

typedef struct {
	APTR TextureHandle;
	APTR MemArea;
	ULONG LastAccess;
	grs_bitmap *ref;
} VirgeTextureCache;

#define HUD_printf HUD_init_message

VirgeTextureCache *VirgeTextures;
UWORD *VirgeTextureBackup;
UWORD Dummy[4096];

UWORD DummyTexture[4] = {
	0x8111, 0xa111,
	0x5111, 0x7111
};
APTR DummyTextureHandle;

UWORD *VirgeBuffer[2];

int VirgeFilter = 1;        /* Bilinear filtering on */
int Max_textures = 60;      /* Size of GraphicBoard Cache */
int VirgeTextures_initialized = 0;

int VirgeBytesPerRow;
int VirgePixelsPerRow;

int VirgeFPSLimit = 0;      // 0 = No Limit
fix VirgeFrameTime = 0;
fix VirgeLastFrameTime = 0;
int VirgeModulateLight = 1;
int VirgeMode = -1;
int VirgeCacheMiss = 0;
int VirgeCacheHit  = 0;
extern int BufNum;

UWORD BitValues[256];
int VirgeBitValues=0;
extern ULONG palette[800];


extern void VirgeDrawPolyP(g3ds_tmap *tmap, const APTR texutre);
extern void VirgeDrawPolyI(g3ds_tmap *tmap, const APTR texture);
extern void VirgeDrawPolyPP(g3ds_tmap *tmap, const APTR texture);

int VirgeTMapper = 0;
int VirgeDefaultMapper = 1;

void VirgeSetModulate(int i)
{
	VirgeModulateLight = i;
}

void VirgeSetFPSLimit(int i)
{
	VirgeFPSLimit = i;
	if (i) VirgeFrameTime = fixdiv(F1_0, i2f(VirgeFPSLimit));
	else   VirgeFrameTime = 0;
}

void VirgeSetMapper(int i)
{
	if (i==-1) i=VirgeDefaultMapper;
	switch(i) {
	case 0: PolygonRenderer = VirgeDrawPolyP;   break;
	case 1: PolygonRenderer = VirgeDrawPolyI;   break;
	case 2: PolygonRenderer = VirgeDrawPolyPP;  break;
	}
	VirgeTMapper = i;
}

void VirgeInit(void)
{
	int i = FindArg("-mapper");
	int j;
	if (i) {
		if      (stricmp(Args[i+1],"FPU")==0)   j=0;
		else if (stricmp(Args[i+1],"INT")==0)   j=1;
		else if (stricmp(Args[i+1],"FPUP")==0)  j=2;
		VirgeSetMapper(j);
		VirgeDefaultMapper = j;
	} else {
		VirgeSetMapper(1);
		VirgeDefaultMapper = 1;
	}
	if (FindArg("-nofilter")) VirgeFilter = 0;
	else                      VirgeFilter = 1;

	i = FindArg("-fpslimit");
	if (i) {
		i=atoi(Args[i+1]);
		VirgeSetFPSLimit(i);
	} else VirgeSetFPSLimit(0);
	if (FindArg("-lightfx")) VirgeSetModulate(1);
	else                     VirgeSetModulate(0);
}

/*
** Generates an array of 16 bit words for the generation of textures.
** Words are in the format ARGB1555
*/
void MakeBitValues(void)
{
	ubyte r,g,b;
	int i;
	if (VirgeBitValues == 1) return;

	if (gr_palette_faded_out) gr_palette_fade_in(gr_palette, 1,0);

	for (i=0; i<255; i++) {
		r=palette[1+i*3]>>24;
		g=palette[1+i*3+1]>>24;
		b=palette[1+i*3+2]>>24;
		BitValues[i] = 0x8000 | (r&0xF8)<<7 | (g&0xF8)<<2 | (b&0xF8)>>3;
	}
	BitValues[255] = 0;
	VirgeBitValues=1;
	VirgeClearCache();
}

void MakeTempBitValues(void)
{
	MakeBitValues();
	VirgeBitValues=0;
}

void VirgeClearBuffer(void)
{
	V3D_ClearBuffer(MyView, BufNum);
}

void VirgeCleanupTextureCache(void)
{
	int i,j=0;

	if (VirgeTextures_initialized == 0) return;
	for (i=0; i<Max_textures; i++) {
		if (VirgeTextures[i].TextureHandle) {
			V3D_DeleteTexHandle(VirgeTextures[i].TextureHandle);
			VirgeTextures[i].TextureHandle = 0;
		}
		if (VirgeTextures[i].ref) j++;
	}
	if (DummyTextureHandle) V3D_DeleteTexHandle(DummyTextureHandle);
	VirgeTextures_initialized = 0;
}

void VirgePrintTextureStatistics(void) {
	int i,j;
	printf("Texture cache statistics:\n");
	printf("Cache accesses total: %d\n", VirgeCacheMiss+VirgeCacheHit);
	i=VirgeCacheMiss+VirgeCacheHit;
	printf("Misses: %d (%4.2f %%)\n", VirgeCacheMiss, 100*((double)VirgeCacheMiss/(double)i));
	printf("Hits:   %d (%4.2f %%)\n", VirgeCacheHit, 100*((double)VirgeCacheHit/(double)i));
}

void VirgeInitTextureCache(void)
{
	int i;
	struct TagItem ttags[] = {
		{V3DTHA_TexelMap,    0},
		{V3DTHA_MapSize,     64L},
		{V3DTHA_TexClrFmt,   TEXFMT_ARGB1555},
		{V3DTHA_FilterMode,  FLTRMD_4TPP},
		{V3DTHA_LitTexture,  TRUE},
		{V3DTHA_TexWrap,     TRUE},
		{V3DTHA_AlphaBlend,  ABLEND_USETEXTURE},
		{TAG_DONE,           0L}
	};
	struct TagItem tag2[] = {
		{V3DTHA_TexelMap,    (ULONG)DummyTexture},
		{V3DTHA_MapSize,     2L},
		{V3DTHA_TexClrFmt,   TEXFMT_ARGB4444},
		{V3DTHA_FilterMode,  FLTRMD_1TPP},
		{V3DTHA_LitTexture,  FALSE},
		{V3DTHA_TexWrap,     TRUE},
		{V3DTHA_AlphaBlend,  ABLEND_USETEXTURE},
		{TAG_DONE,           0L}
	};


	if (VirgeTextures_initialized == 1) return;

	DummyTextureHandle = V3D_CreateTexHandleTagList((View3D)MyView, tag2);
	if (!DummyTextureHandle) {
		printf("ERROR allocation transparent dummy texture\n");
		exit(0);
	}

	if (!VirgeTextureBackup) {
		VirgeTextureBackup = (UWORD *)malloc(8192);
		for (i=0; i<4096; i++) *(VirgeTextureBackup+i) = 0x4210;
		for (i=0; i<64; i++) {
		  *(VirgeTextureBackup+i+i*64) = 0x7C00;
		  *(VirgeTextureBackup+i*64+(63-i)) = 0x7C00;
		}

	}

	if (!VirgeTextures) VirgeTextures = malloc(sizeof(VirgeTextureCache)*Max_textures);
	if (!VirgeTextures) {
		printf("Error allocating texture cache\n");
		exit(0);
	}

	for (i=0; i<Max_textures; i++) VirgeTextures[i].TextureHandle = 0;
	for (i=0; i<Max_textures; i++) {
		APTR xx;
		VirgeTextures[i].LastAccess = 0;
		VirgeTextures[i].MemArea = VirgeTextureBackup;
		VirgeTextures[i].ref = NULL;
		ttags[0].ti_Data = (ULONG)VirgeTextureBackup;
		xx = (APTR)V3D_CreateTexHandleTagList(MyView, ttags);
		if (xx == NULL) {
			printf("Error creating texture cache\n");
			exit(0);
		} else VirgeTextures[i].TextureHandle = xx;
	}
	if (VirgeFilter==0) {
		VirgeBilinearOff();
	}
	VirgeTextures_initialized = 1;
}

void VirgeSetupBuffers(void)
{
	UBYTE *scrn;
	MyView3D *mv;
	struct Window *win;
	APTR handle;
	ULONG bpr;
	ULONG height;

	mv = (MyView3D *)MyView;
	win = mv->win;
	Forbid();
	handle = LockBitMapTags(win->RPort->BitMap,
		LBMI_BASEADDRESS,   (ULONG)&scrn,
		LBMI_BYTESPERROW,   (ULONG)&bpr,
		LBMI_HEIGHT,        (ULONG)&height,
	TAG_DONE);
	UnLockBitMap(handle);
	Permit();
	VirgeBuffer[0] = (UWORD *)scrn;
	VirgeBuffer[1] = (UWORD *)(scrn + (height/2)*bpr);
	VirgeBytesPerRow = (int)bpr;
	VirgePixelsPerRow = (int)bpr/2;
	VirgeLastFrameTime = timer_get_fixed_seconds();
}

void MakeARGBTexture(UWORD *BitArray, UBYTE *source, UWORD *target)
{
	int i;
	//for (i=0; i<4096; i++) *target++=*(BitArray+*source++);
	i=4096;
	while (i) {
		*target++=*(BitArray+*source++);
		i--;
	}
}

int GetOldestEntry(void)
{
	int i;
	int oldidx=0;
	for (i=0; i<Max_textures; i++) {
		if (VirgeTextures[i].LastAccess < VirgeTextures[oldidx].LastAccess) {
			oldidx = i;
		}
	}
	return oldidx;
}

void VirgeInvalidCacheEntry(grs_bitmap *map)
{
	int i = (int)map->bm_Handle;
	map->bm_Handle = 0;
	if (i>=Max_textures || i<=0) return;
	if (VirgeTextures[i].ref != map) return;
	VirgeTextures[i].LastAccess = 0;
}

void VirgeClearCache(void)
{
	int i;
	extern int VirgeBitValues;
	extern void MakeBitValues();

	for (i=0; i<Max_textures; i++) {
		VirgeTextures[i].ref = NULL;
	}
}

void VirgeBilinearOn(void)
{
	int i;
	for (i=0; i<Max_textures; i++) {
		V3D_SetTexHandleAttr(VirgeTextures[i].TextureHandle,
			V3DTHA_FilterMode, FLTRMD_4TPP);
	}
	VirgeFilter = 1;
}

void VirgeBilinearOff(void)
{
	int i;
	for (i=0; i<Max_textures; i++) {
		V3D_SetTexHandleAttr(VirgeTextures[i].TextureHandle,
			V3DTHA_FilterMode, FLTRMD_1TPP);
	}
	VirgeFilter = 0;
}

void VirgeToggleBilinear(void)
{
	if (VirgeFilter == 0) {
		VirgeBilinearOn();
		HUD_printf("Texture Filtering turned on");
	} else {
		VirgeBilinearOff();
		HUD_printf("Texture Filtering turned off");
	}
}

void *VirgeFindTexture(grs_bitmap *map)
{
	int i;
	grs_bitmap *oldmap = map;
	fix now = timer_get_fixed_seconds();

	MakeBitValues();

	// --- If this map has a handle set, check if it is still valid
	if (map->bm_Handle) {
		if (VirgeTextures[(int)map->bm_Handle].ref == map) {
			VirgeCacheHit++;
			// It is valid. Return it.
			VirgeTextures[(int)map->bm_Handle].LastAccess = now;
			return VirgeTextures[(int)map->bm_Handle].TextureHandle;
		} else {
			map->bm_Handle = 0;
		}
	} 


	// --- Cache miss
	//     Expand bitmap if needed
	if (map->bm_flags & BM_FLAG_RLE)
		map = rle_expand_texture(map);

	// --- Find the least recently used entry in the cache
	i=GetOldestEntry();

	// --- Make a texture out of this and upload it
	if (map == NULL || map->bm_data == NULL) {
		int j;
		for (j=0; j<4096; j++) Dummy[i] = 0xffff;
		printf("Dammit: %d\n", map);
	} else {
		MakeARGBTexture(BitValues, map->bm_data, Dummy);
	}
	V3D_SetTexHandleAttr(VirgeTextures[i].TextureHandle,
		V3DTHA_TexelMap,    Dummy);

	// --- Use the (obsolete) Handle field to store the cache entry for
	//     quick retrieval
	oldmap->bm_Handle = (void *)i;

	// --- Set the reference pointer and time code
	VirgeTextures[i].ref = oldmap;
	VirgeTextures[i].LastAccess = now;

	// --- Increment the miss counter. For statistics only
	VirgeCacheMiss++;

	// --- Return the texture handle
	return VirgeTextures[i].TextureHandle;
}

void *VirgeGetBuffer(void)
{
	return (void *)VirgeBuffer[BufNum];
}

void VirgeSwitchBuffer(void)
{
#ifdef VIRGIN_DBUF
	BufNum++; BufNum&=1;
	V3D_FlipBuffer(MyView, (ULONG)BufNum);
#endif
}

void VirgeSwitchBufferWait(void)
{
	fix sec;
	if (VirgeFPSLimit) {
		do {
			sec=timer_get_fixed_seconds();
			if (VirgeLastFrameTime+VirgeFrameTime <= sec) break;
		} while(1);
	}
	VirgeLastFrameTime = sec;
	VirgeSwitchBuffer();
}

void *VirgeFirstBuffer(void)
{
#ifdef VIRGIN_DBUF
	if (BufNum==0) return;
	VirgeSwitchBuffer();
	return (void *)VirgeBuffer[BufNum];
#endif
}


void _drawpoly(VertexV3Dtex **vertex, int nverts, APTR texh)
{
		(void)V3D_DrawTriangle3DSet(MyView,
			vertex, (ULONG)nverts, T3DSET_TRIFAN, BLENDMD_MODULATE, texh);
}

void VirgeDrawPoly(VertexV3Dtex **vertex, int nverts, APTR texh)
{
	int i;
	if (V3D_LockView(MyView)) {
		_drawpoly(vertex, nverts, texh);
		V3D_UnLockView(MyView);
	}
}


void xBlitV3DTriangle(V3DTriangle *tri, APTR texture)
{
	BlitV3DTriangle(MyView, tri, texture, CGX3DVirginBase);
}


void VirgeDrawLine2D(int xs, int ys, int xe, int ye)
{
	extern ULONG palette[800];
	Line3D line;
	extern View3D MyView;
	ULONG col;
	short color = grd_curcanv->cv_color;

	col = ((palette[1+color*3+0]&0xff000000)>>8)
		| ((palette[1+color*3+1]&0xff000000)>>16)
		| ((palette[1+color*3+2]&0xff000000)>>24);

	line.p1.x = (ULONG)xs; line.p1.y = (ULONG)ys; line.p1.z = 0;
	line.p2.x = (ULONG)xe; line.p2.y = (ULONG)ye; line.p2.z = 0;
	line.p1.color.argbval = col;
	line.p2.color.argbval = col;
	if (V3D_LockView(MyView)) {
		V3D_DrawLine3D(MyView, &line, 0);
		V3D_UnLockView(MyView);
	}
	return;
}

void VirgeDummyUpdate(void *x)
{
	return;
}

#endif /* VIRGIN */

