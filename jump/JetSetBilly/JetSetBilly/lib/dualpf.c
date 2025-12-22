/*
 * Double-buffered dual playfield
 *
 * openup(width, height, depth, viewmodes, char *title);
 *
 */

#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <graphics/view.h>
#include <hardware/dmabits.h>
#include <hardware/custom.h>
#include <libraries/dos.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
void switch_view(void);
void panic(char *msg);
void cleandown(int error);

/* Variables */
SHORT			SWidth, SHeight, SDepth;
USHORT			SMode;

struct GfxBase		*GfxBase = NULL;
struct BitMap		bitmap[4];
struct View		view[2], *oldview;
struct RasInfo		rasinfo[4];
struct RastPort		rp[4];
struct ViewPort		vp[2];

char			current_view;	/* Which buffer? */

void
switch_view()
{
	current_view = (!current_view ? 1 : 0);
	LoadView(&view[current_view]);
	WaitTOF();
}

void
openup(SHORT w, SHORT h, SHORT d, USHORT vm, char *t)
{
	int	i, j;

	if ((GfxBase = (struct GfxBase *)
		OpenLibrary("graphics.library", 33L)) == NULL)
		panic("Aargh! Can't open graphics.library!\n");

	if (d != 3) panic("Only depth 3 can be used with this module.\n");

	SWidth = w; SHeight = h; SDepth = d; SMode = vm;

	for (j = 0; j < 4; j++) {
		InitBitMap(&bitmap[j], SDepth, SWidth, SHeight);
		for (i = 0; i < 8; i++) bitmap[j].Planes[i] = NULL;
	}

	for (j = 0; j < 4; j++) {
		for (i = 0; i < SDepth; i++) {
		  bitmap[j].Planes[i] = (PLANEPTR)AllocRaster(SWidth, SHeight);
		  if (bitmap[j].Planes[i] == NULL)
			panic("Out of chip memory!\n");
		}
	}

	rasinfo[0].Next = &rasinfo[1];
	rasinfo[1].Next = NULL;
	rasinfo[2].Next = &rasinfo[3];
	rasinfo[3].Next = NULL;

	for (j = 0; j < 4; j++) {
		InitRastPort(&rp[j]);
		rp[j].BitMap = &bitmap[j];

		SetRast(&rp[j], 0);

		rasinfo[j].BitMap = &bitmap[j];
		rasinfo[j].RxOffset = 0;
		rasinfo[j].RyOffset = 0;
	}

	InitVPort(&vp[0]);
	InitVPort(&vp[1]);

	vp[0].DWidth  = vp[1].DWidth  = SWidth;
	vp[0].DHeight = vp[1].DHeight = SHeight;
	vp[0].Modes   = vp[1].Modes   = (SMode | DUALPF);

	vp[0].RasInfo = &rasinfo[0];
	vp[1].RasInfo = &rasinfo[2];

	vp[0].ColorMap = GetColorMap(32L);
	vp[1].ColorMap = GetColorMap(32L);

	if (vp[0].ColorMap == NULL || vp[1].ColorMap == NULL)
		panic("Out of memory when allocating ColorMap!\n");

	InitView(&view[0]);
	InitView(&view[1]);

	view[0].ViewPort = &vp[0];
	view[1].ViewPort = &vp[1];

	MakeVPort(&view[0], &vp[0]);
	MakeVPort(&view[1], &vp[1]);

	MrgCop(&view[0]);
	MrgCop(&view[1]);

	oldview = GfxBase->ActiView;

	LoadView(&view[0]);
}


void
panic(char *msg)
{
	if (msg) fprintf(stderr, "%s", msg);
	cleandown(-1);
}


void
cleandown(int error)
{
	int i, j;

	if (oldview) {
		LoadView(oldview);
		WaitTOF();
	}

	for (j = 0; j < 4; j++) {
		for (i = 0; i < SDepth; i++) {
			if (bitmap[j].Planes[i])
			  FreeRaster(bitmap[j].Planes[i], SWidth, SHeight);
		}
	}

	for (j = 0; j < 2; j++) {
		if (view[j].ViewPort->ColorMap)
			FreeColorMap(view[j].ViewPort->ColorMap);

		if (view[j].ViewPort)
			FreeVPortCopLists(view[j].ViewPort);

		if (view[j].LOFCprList)
			FreeCprList(view[j].LOFCprList);
	}

	if (GfxBase) CloseLibrary((struct Library *) GfxBase);

	exit(error);
}


/* Test */
int
main()
{
	int stripe, col, i;

	openup(320, 200, 3, NULL, "Title is not used");

	stripe = SWidth / 32;

	for (col = 0, i = SWidth - stripe; i >= 0; i -= stripe) {
		SetAPen(&rp[current_view * 2], (col++ % 8L));

		RectFill(&rp[current_view * 2], i+1, 1, i+stripe-2, SHeight-1);

		Delay(TICKS_PER_SECOND / 4L + 1L);
	}

	Delay(1L * TICKS_PER_SECOND);

	stripe = SHeight / 20;

	for (col = 0, i = SHeight - stripe; i >= 0; i -= stripe) {
		SetAPen(&rp[current_view * 2 + 1], (col++ % 8L));

		RectFill(&rp[current_view * 2 + 1], 1, i+1, SWidth-1, i+stripe-2);

		Delay(TICKS_PER_SECOND / 4L + 1L);
	}

	Delay(1 * TICKS_PER_SECOND);

	for(i = 0; i < 20; i++) {
		ScrollRaster(&rp[current_view * 2], 1, -1, 100, 60, 220, 140);
		WaitTOF();
	}

	switch_view();

	for (col = i = 0; i <= 320; i += 8) {
		SetAPen(&rp[current_view * 2], (col++ % 8L));

		Move(&rp[current_view * 2], i, 0);
		Draw(&rp[current_view * 2], 0, (i / 8) * 5);

		Delay(4L);
	}

	for (col = i = 0; i <= 320; i += 8) {
		SetAPen(&rp[current_view * 2], (col++ % 8L));

		Move(&rp[current_view * 2], i, 199);
		Draw(&rp[current_view * 2], 319-i, (i / 8) * 5);

		Delay(4L);
	}

	for(i = 0; i < 20; i++) {
		ScrollRaster(&rp[current_view * 2], -1, 1, 100, 60, 220, 140);
		WaitTOF();
	}

	Delay(1L * TICKS_PER_SECOND);

	for (i = 0; i < 8; i++) {
		switch_view();
		Delay(TICKS_PER_SECOND / 2);
	}

	cleandown(0);
}
