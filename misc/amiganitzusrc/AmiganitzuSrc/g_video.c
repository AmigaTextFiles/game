/* g_video

init the video display */

#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <graphics/copper.h>
#include <libraries/dos.h>
#include <intuition/screens.h>

#include <clib/graphics_protos.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

#include <stdio.h>
#include <stdlib.h>

#include "g_headers.h"
#include "g_video.h"


struct GfxBase *GfxBase = NULL;
LONG clock;
struct View view0, view1, view_menu, *oldview = NULL;
struct BitMap sc_bitmap0, sc_bitmap1, sc_bitmap_menu;
struct ViewPort view_port0, view_port1, view_port_menu;
struct ColorMap *cm;
struct RastPort rp_menu, *rp = NULL, rp0, rp1;
struct palette_struct global_palette;
struct UCopList *coplist_menu = NULL, *coplist_play = NULL;
UBYTE *displaymem = NULL;
unsigned char cur_buffer = 1;

extern struct Custom far custom;

int init_display(int width, int height, int depth)
{
	int i;
	struct BitMap blargh;
	struct RasInfo rasInfo0, rasInfo1, rasInfo2;	

	GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 33L);
	if(GfxBase == NULL) return 0;
	if(GfxBase->DisplayFlags & PAL) clock = 3546895; // PAL clock
	else clock = 3579545;	// NTSC clock

	oldview = GfxBase->ActiView;

	InitView(&view0);

	InitBitMap(&sc_bitmap0, depth, width, height);
	for(i = 0; i < depth; i++) {
		sc_bitmap0.Planes[i] = (PLANEPTR)AllocRaster(width, height);
		if(sc_bitmap0.Planes[i] == NULL) {
			CloseLibrary((struct Library*)GfxBase);
			return 0;
		}
	}
	for(i = 0; i < depth; i++) {
		displaymem = (UBYTE*)sc_bitmap0.Planes[i];
		BltClear(displaymem, (sc_bitmap0.BytesPerRow * sc_bitmap0.Rows), 1L);
	}
	rasInfo0.BitMap = &sc_bitmap0;
	rasInfo0.RxOffset = 0;
	rasInfo0.RyOffset = 0;
	rasInfo0.Next = NULL;

	InitVPort(&view_port0);
	view0.ViewPort = &view_port0;
	view_port0.RasInfo = &rasInfo0;
	view_port0.DWidth = width;
	view_port0.DHeight = height;

	// set palette
	global_palette.cm = NULL;
	global_palette.d = 5;
	if(!load_ilbm("data/32blank.iff", &blargh, &global_palette)) return 0;
	free_bitmap(&blargh);
	if(global_palette.cm == NULL) {
		global_palette.cm = GetColorMap(32L);
		if(global_palette.cm == NULL) return 0;
	}
	view_port0.ColorMap = global_palette.cm;	
	LoadRGB4(&view_port0, (UWORD*)global_palette.c, 32);
	
	coplist_play = (struct UCopList *)AllocMem(sizeof(struct UCopList), MEMF_PUBLIC|MEMF_CLEAR);
	if(!coplist_play) return 0;
	
	MakeVPort(&view0, &view_port0);
	MrgCop(&view0);
	LoadView(&view0);

	InitRastPort(&rp0);
	rp0.BitMap = &sc_bitmap0;

	// second screen for double buffering
	InitView(&view1);

	InitBitMap(&sc_bitmap1, depth, width, height);
	for(i = 0; i < depth; i++) {
		sc_bitmap1.Planes[i] = (PLANEPTR)AllocRaster(width, height);
		if(sc_bitmap1.Planes[i] == NULL) {
			CloseLibrary((struct Library*)GfxBase);
			return 0;
		}
	}
	for(i = 0; i < depth; i++) {
		displaymem = (UBYTE*)sc_bitmap1.Planes[i];
		BltClear(displaymem, (sc_bitmap1.BytesPerRow * sc_bitmap1.Rows), 1L);
	}
	rasInfo1.BitMap = &sc_bitmap1;
	rasInfo1.RxOffset = 0;
	rasInfo1.RyOffset = 0;
	rasInfo1.Next = NULL;

	InitVPort(&view_port1);
	view1.ViewPort = &view_port1;
	view_port1.RasInfo = &rasInfo1;
	view_port1.DWidth = width;
	view_port1.DHeight = height;

	// set palette
	view_port1.ColorMap = global_palette.cm;	
	LoadRGB4(&view_port1, (UWORD*)global_palette.c, 32);
	
	MakeVPort(&view1, &view_port1);
	MrgCop(&view1);
	LoadView(&view1);

	InitRastPort(&rp1);
	rp1.BitMap = &sc_bitmap1;

	rp = &rp1;
	cur_buffer = 1;

	// hi res menu screen
	depth = 1; // 2 colour screen
	width = 640;
	InitView(&view_menu);
	InitBitMap(&sc_bitmap_menu, depth, width, height);
	for(i = 0; i < depth; i++) {
		sc_bitmap_menu.Planes[i] = (PLANEPTR)AllocRaster(width, height);
		if(sc_bitmap_menu.Planes[i] == NULL) {
			CloseLibrary((struct Library*)GfxBase);
			return 0;
		}
	}
	for(i = 0; i < depth; i++) {
		displaymem = (UBYTE*)sc_bitmap_menu.Planes[i];
		BltClear(displaymem, (sc_bitmap_menu.BytesPerRow * sc_bitmap_menu.Rows), 1L);
	}
	rasInfo2.BitMap = &sc_bitmap_menu;
	rasInfo2.RxOffset = 0;
	rasInfo2.RyOffset = 0;
	rasInfo2.Next = NULL;

	InitVPort(&view_port_menu);
	view_menu.ViewPort = &view_port_menu;
	view_port_menu.RasInfo = &rasInfo2;
	view_port_menu.DWidth = width;
	view_port_menu.DHeight = height;
	view_port_menu.Modes = HIRES;
	// set palette
	view_port_menu.ColorMap = global_palette.cm;
	LoadRGB4(&view_port_menu, (UWORD*)global_palette.c, 2);
	
	MakeVPort(&view_menu, &view_port_menu);
	MrgCop(&view_menu);
	LoadView(&view_menu);

	coplist_menu = (struct UCopList *)AllocMem(sizeof(struct UCopList), MEMF_PUBLIC|MEMF_CLEAR);
	if(!coplist_menu) return -1;

	InitRastPort(&rp_menu);
	rp_menu.BitMap = &sc_bitmap_menu;

	return 1;
}

void set_to_offscreen()
{
	if(cur_buffer == 0) rp = &rp1;
	else rp = &rp0;
}

void set_to_onscreen()
{
	if(cur_buffer == 0) rp = &rp0;
	else rp = &rp1;
}

void set_to_playscreen()
{
	LoadView(&view1);
	cur_buffer = 1;
}

void swap_buffers()
{
	if(cur_buffer == 0) {
		LoadView(&view1);
		cur_buffer = 1;
	}
	else {
		LoadView(&view0);
		cur_buffer = 0;
	}
}

void make_copperlist(struct UCopList *cl, int t, int g)
{
	int red[6] = {0x100, 0x200, 0x300, 0x400, 0x300, 0x200};
	int green[6] = {0x010, 0x020, 0x030, 0x040, 0x030, 0x020};
	int blue[6] = {0x001, 0x002, 0x003, 0x004, 0x003, 0x002};
	int i;
	
	if(t == 0)
	{
		CINIT(cl, 2);
		CWAIT(cl, 0, 0);
		CMOVE(cl, custom.color[0], 0x00);
		CEND(cl);
	}

	if(t == REDBARS) {
		CINIT(cl, 500);
		for(i = 0; i < 200; i+=12) {
			CWAIT(cl, i, 0);
			CMOVE(cl, custom.color[0], red[0]);
			CWAIT(cl, i+2, 0);
			CMOVE(cl, custom.color[0], red[1]);
			CWAIT(cl, i+4, 0);
			CMOVE(cl, custom.color[0], red[2]);
			CWAIT(cl, i+6, 0);
			CMOVE(cl, custom.color[0], red[3]);
			CWAIT(cl, i+8, 0);
			CMOVE(cl, custom.color[0], red[4]);
			CWAIT(cl, i+10, 0);
			CMOVE(cl, custom.color[0], red[5]);
		}
		CWAIT(cl, 199, 0);
		CMOVE(cl, custom.color[0], 0x000);
		CEND(cl);
	}

	if(t == GREENBARS) {
		CINIT(cl, 500);
		for(i = 0; i < 200; i+=12) {
			CWAIT(cl, i, 0);
			CMOVE(cl, custom.color[0], green[0]);
			CWAIT(cl, i+2, 0);
			CMOVE(cl, custom.color[0], green[1]);
			CWAIT(cl, i+4, 0);
			CMOVE(cl, custom.color[0], green[2]);
			CWAIT(cl, i+6, 0);
			CMOVE(cl, custom.color[0], green[3]);
			CWAIT(cl, i+8, 0);
			CMOVE(cl, custom.color[0], green[4]);
			CWAIT(cl, i+10, 0);
			CMOVE(cl, custom.color[0], green[5]);
		}
		CWAIT(cl, 199, 0);
		CMOVE(cl, custom.color[0], 0x000);
		CEND(cl);
	}

	if(t == BLUEBARS) {
		CINIT(cl, 500);
		for(i = 0; i < 200; i+=12) {
			CWAIT(cl, i, 0);
			CMOVE(cl, custom.color[0], blue[0]);
			CWAIT(cl, i+2, 0);
			CMOVE(cl, custom.color[0], blue[1]);
			CWAIT(cl, i+4, 0);
			CMOVE(cl, custom.color[0], blue[2]);
			CWAIT(cl, i+6, 0);
			CMOVE(cl, custom.color[0], blue[3]);
			CWAIT(cl, i+8, 0);
			CMOVE(cl, custom.color[0], blue[4]);
			CWAIT(cl, i+10, 0);
			CMOVE(cl, custom.color[0], blue[5]);
		}
		CWAIT(cl, 199, 0);
		CMOVE(cl, custom.color[0], 0x000);
		CEND(cl);
	}

	if(g == 1) {
		Forbid();
		view_port_menu.UCopIns = cl;
		Permit();	
		MrgCop(&view_menu);
	}
	
	if(g == 0) {
		Forbid();
		view_port0.UCopIns = cl;
		Permit();	
		MrgCop(&view0);
		Forbid();
		view_port1.UCopIns = cl;
		Permit();	
		MrgCop(&view1);
	}
}


void free_bitmap(struct BitMap *bm)
{
	int i;

	for(i = 0; i < bm->Depth; i++)
	{
		if(bm->Planes[i]) FreeRaster(bm->Planes[i], bm->BytesPerRow * 8, bm->Rows);
	}

}

void video_exit(void)
{
	WORD i;

	LoadView(oldview);

	// this code was crashing, i just commented it out since its not much memory
	/*
	FreeCprList(view0.LOFCprList);
	if(view0.SHFCprList) FreeCprList(view0.SHFCprList);
	FreeVPortCopLists(&view_port0);
	FreeCprList(view1.LOFCprList);
	if(view1.SHFCprList) FreeCprList(view1.SHFCprList);
	FreeVPortCopLists(&view_port1);
	FreeCprList(view_menu.LOFCprList);
	if(view_menu.SHFCprList) FreeCprList(view_menu.SHFCprList);
	FreeVPortCopLists(&view_port_menu);
	*/
	if(cm) FreeColorMap(cm);

	for(i = 0; i < 5; i++) {
		if(sc_bitmap0.Planes[i]) FreeRaster(sc_bitmap0.Planes[i], 320, 200);
	}
	for(i = 0; i < 5; i++) {
		if(sc_bitmap1.Planes[i]) FreeRaster(sc_bitmap1.Planes[i], 320, 200);
	}
	
	for(i = 0; i < 2; i++) {
		if(sc_bitmap_menu.Planes[i]) FreeRaster(sc_bitmap_menu.Planes[i], 320, 200);
	}

	CloseLibrary((struct Library*)GfxBase);
}

