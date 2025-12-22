/*
Copyright (c) 1992, Trevor Smigiel.  All rights reserved.

(I hope Commodore doesn't mind that I borrowed their copyright notice.)

The source and executable code of this program may only be distributed in free
electronic form, via bulletin board or as part of a fully non-commercial and
freely redistributable diskette.  Both the source and executable code (including
comments) must be included, without modification, in any copy.  This example may
not be published in printed form or distributed with any commercial product.

This program is provided "as-is" and is subject to change; no warranties are
made.  All use is at your own risk.  No liability or responsibility is assumed.

*/

#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfx.h>
#include <graphics/rastport.h>
/* This comment is for the includesym.ced macro which searches for first comment*/
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

#include <stdio.h>

#include "Tetris.h"

static Point TPoints[148] = {
/*   0 */	{0, -2}, {0,  0}, {-2,  0}, {-2, -2}, {0, -2}, 

/*   5 */	{0, -1}, {0,  0}, {-4,  0}, {-4, -1}, {0, -1}, 
/*  10 */	{0, -4}, {0,  0}, {-1,  0}, {-1, -4}, {0, -4}, 

/*  15 */	{0, -1}, {0,  0}, {-3,  0}, {-3, -2}, { 2, -2}, { 2, -1}, {0, -1}, 
/*  22 */	{0, -3}, {0,  2}, { 1,  2}, { 1,  0}, {-2,  0}, {-2, -3}, {0, -3}, 
/*  29 */	{0, -2}, {0,  0}, {-1,  0}, {-1,  1}, {-3,  1}, {-3, -2}, {0, -2}, 
/*  36 */	{0, -3}, {0,  0}, {-2,  0}, {-2, -1}, {-1, -1}, {-1, -3}, {0, -3}, 

/*  43 */	{0, -2}, {0,  0}, {-3,  0}, {-3, -1}, {-1, -1}, {-1, -2}, {0, -2}, 
/*  50 */	{0, -1}, {0,  0}, {-2,  0}, {-2, -3}, { 1, -3}, { 1, -1}, {0, -1}, 
/*  57 */	{0, -2}, {0,  1}, { 2,  1}, { 2,  0}, {-3,  0}, {-3, -2}, {0, -2}, 
/*  64 */	{0, -3}, {0,  0}, {-1,  0}, {-1,  2}, {-2,  2}, {-2, -3}, {0, -3}, 

/*  71 */	{0, -1}, {0,  0}, {-3,  0}, {-3, -1}, {-2, -1}, {-2, -2}, { 1, -2}, { 1, -1}, {0, -1}, 
/*  80 */	{0, -2}, {0,  1}, { 1,  1}, { 1,  0}, {-2,  0}, {-2, -3}, { 1, -3}, { 1, -2}, {0, -2}, 
/*  89 */	{0, -2}, {0,  1}, { 1,  1}, { 1,  0}, {-2,  0}, {-2,  1}, {-3,  1}, {-3, -2}, {0, -2}, 
/*  98 */	{0, -3}, {0,  0}, {-1,  0}, {-1,  1}, {-2,  1}, {-2, -2}, {-1, -2}, {-1, -3}, {0, -3}, 

/* 107 */	{0, -1}, {0,  0}, {-2,  0}, {-2,  1}, {-3,  1}, {-3, -2}, { 1, -2}, { 1, -1}, {0, -1}, 
/* 116 */	{0, -3}, {0,  1}, { 1,  1}, { 1,  0}, {-2,  0}, {-2, -2}, {-1, -2}, {-1, -3}, {0, -3}, 

/* 125 */	{0, -2}, {0,  1}, { 1,  1}, { 1,  0}, {-3,  0}, {-3, -1}, {-2, -1}, {-2, -2}, {0, -2}, 
/* 134 */	{0, -2}, {0,  0}, {-1,  0}, {-1,  1}, {-2,  1}, {-2, -3}, { 1, -3}, { 1, -2}, {0, -2}, 

/* 143 */	{0, -1}, {0,  0}, {-1,  0}, {-1, -1}, {0, -1}, 
};
static Point TBorders[NBITMAPS] = {
	{4,   0},
	{4,   5}, {4,  10},
	{6,  15}, {6,  22}, {6,  29}, {6,  36},
	{6,  43}, {6,  50}, {6,  57}, {6,  64},
	{8,  71}, {8,  80}, {8,  89}, {8,  98},
	{8, 107}, {8, 116},
	{8, 125}, {8, 134},
	{4, 143},
};
static UWORD TRef[NBITMAPS] = {0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 6, 6, 7};
Point TSizes[NBITMAPS];
extern Point TSSizes[NBITMAPS] = {
	/* width, height */
	{ 2,  2},
	{ 4,  1}, { 1,  4},
	{ 3,  2}, { 2,  3}, { 3,  2}, { 2,  3},
	{ 3,  2}, { 2,  3}, { 3,  2}, { 2,  3},
	{ 3,  2}, { 2,  3}, { 3,  2}, { 2,  3},
	{ 3,  2}, { 2,  3},
	{ 3,  2}, { 2,  3},
	{ 1,  1},
};

struct BitMap TBitMaps[NBITMAPS];
UWORD TColors[8] = {4, 9, 6, 5, 10, 11, 14, 3};
UWORD TFirst[8] = {0, 1, 3, 7, 11, 15, 17, 19};
UWORD TNext[NBITMAPS] = {
	0, 
	2, 1,
	6, 3, 4, 5,
	10, 7, 8, 9,
	14, 11, 12, 13,
	16, 15,
	18, 17,
	19
};
UWORD TPieces[NBITMAPS] = {
	0xcc00,
	0xf000, 0x8888,
	0xe200, 0x44c0, 0x8e00, 0xc880,
	0xe800, 0xc440, 0x2e00, 0x88c0,
	0xe400, 0x4c40, 0x4e00, 0x8c80,
	0xc600, 0x4c80,
	0x6c00, 0x8c40,
	0x8000
};

static struct RastPort TetrisRP;
static struct TmpRas TetrisTR;
static struct AreaInfo TetrisAI;
static UBYTE TetrisAIBuf[5 * 12];

void
DrawTetrisImage(struct BitMap *bm, WORD which, WORD depth, WORD xsize, WORD ysize)
{
	Point points[10];
	Point *point;
	Point *ppt;
	int pen;
	int i;
	int n;

	TetrisRP.BitMap = bm;

	n = TBorders[which].x;
	point = &TPoints[TBorders[which].y];
	ppt = &points[0];
	for (i = n; i >= 0; i--, ppt++, point++) {
		ppt->x = point->x * xsize;
		if (ppt->x < 0) ppt->x = (-ppt->x) - 1;
		ppt->y = point->y * ysize;
		if (ppt->y < 0) ppt->y = (-ppt->y) - 1;
	}

	switch (depth) {
		case 1: pen = 1; break;
		case 2: pen = 3; break;
		case 3: pen = (TColors[TRef[which]] - 3) % 5 + 3; break;
		default: pen = TColors[TRef[which]]; break;
	}
	SetAPen(&TetrisRP, pen);
	SetBPen(&TetrisRP, pen);
	point = &points[0];
	AreaMove(&TetrisRP, point->x, point->y);
	for (i = n - 2, point++; i >= 0; point++, i--)
		AreaDraw(&TetrisRP, point->x, point->y);
	AreaEnd(&TetrisRP);

	if (depth > 1) {
		pen = 2;
		SetAPen(&TetrisRP, 2);
		ppt = point = &points[0];
		Move(&TetrisRP, point->x, point->y);
		for (i = n - 2, point++; i >= 0; point++, i--) {
			switch (pen) {
			case 1:
				if ((ppt->y > point->y) || (ppt->x < point->x)) {
					pen = 2;
					SetAPen(&TetrisRP, 2);
				}
				break;
			case 2:
				if ((ppt->y < point->y) || (ppt->x > point->x)) {
					pen = 1;
					SetAPen(&TetrisRP, 1);
				}
				break;
			}
			Draw(&TetrisRP, point->x, point->y);
			ppt = point;
		}
		SetAPen(&TetrisRP, 1);
		Draw(&TetrisRP, point->x + 1, point->y);
	}
}

BOOL 
InitTetrisImages(WORD depth, WORD xsize, WORD ysize)
{
	struct BitMap *bm;
	int i, j;



	InitRastPort(&TetrisRP);
	InitArea(&TetrisAI, TetrisAIBuf, 12);
	TetrisRP.AreaInfo = &TetrisAI;

	if (!depth) return FALSE;

	i = xsize * 4; j = ysize * 4;
	InitTmpRas(&TetrisTR, AllocRaster(i, j), RASSIZE(i, j));
	TetrisRP.TmpRas = &TetrisTR;

	for (i = 0; i < NBITMAPS; i++) {
		TSizes[i].x = TSSizes[i].x * xsize;
		TSizes[i].y = TSSizes[i].y * ysize;
		bm = &TBitMaps[i];
		InitBitMap(bm, depth, TSizes[i].x, TSizes[i].y);
		bm->Planes[0] = AllocMem(bm->BytesPerRow * bm->Rows * bm->Depth, MEMF_CHIP | MEMF_CLEAR);
		//bm->Planes[0] = AllocRaster(TSizes[i].x, TSizes[i].y * depth);
		if (!bm->Planes[0]) break;
	}
	if (i == NBITMAPS) {
		for (i = 0; i < NBITMAPS; i++) {

			bm = &TBitMaps[i];
			//BltClear(bm->Planes[0], bm->BytesPerRow * bm->Rows * bm->Depth, 0);
			for (j = 1; j < depth; j++)
				bm->Planes[j] = bm->Planes[j - 1] + bm->BytesPerRow;
			bm->BytesPerRow *= depth;

			DrawTetrisImage(bm, i, depth, xsize, ysize);
		}
		return TRUE;
	}
	for (i--; i >= 0; i--) {
		if (TBitMaps[i].Planes[0])
			//FreeRaster(TBitMaps[i].Planes[0], TSizes[i].x, TSizes[i].y * depth);
			FreeMem(TBitMaps[i].Planes[0], TBitMaps[i].BytesPerRow * TBitMaps[i].Rows * TBitMaps[i].Depth);
	}
	return FALSE;
}

void 
FreeTetrisImages(WORD depth, WORD xsize, WORD ysize)
{
	int i;
	if (TetrisTR.RasPtr) FreeRaster(TetrisTR.RasPtr, xsize * 4, ysize * 4);
	for (i = 0; i < NBITMAPS; i++) {
		if (TBitMaps[i].Planes[0]) {
			//FreeRaster(TBitMaps[i].Planes[0], TSizes[i].x, TSizes[i].y * depth);
			FreeMem(TBitMaps[i].Planes[0], TBitMaps[i].BytesPerRow * TBitMaps[i].Rows);
		}
	}
}

