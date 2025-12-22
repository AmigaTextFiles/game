/*
    YacTris v0.0
    Copyright ©1993 Jonathan P. Springer

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 1, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    For more details see the files README and COPYING, which should have
    been included in this distribution.

    The author can be reached during the school year at these E-Mail addresses:

	springjp@screech.alfred.edu	    (Internet)
	springjp@ceramics.bitnet	    (Bitnet)

    And can be reached by paper mail year-round at the following address:

	Jonathan Springer
	360 W. Main St.
	Dallastown, PA	17313-2014
	USA

*/


/*
**
**  MakePieces.c
**
**  Program module containing the routines related to creating and freeing
**  the images associated with each piece.
**
*/
#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>
#include <graphics/gels.h>
#include <graphics/rastport.h>
#include <intuition/intuition.h>
#include <math.h>
#include "dbug/dbug.h"
#include "yactris.h"
#include "bruce.h"

#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>

Prototype BOOL MakePieces(struct ScreenInfo *);
Prototype BOOL GivePieceBitMap(struct PieceRot *, struct ScreenInfo *);
Prototype void UnMakePieces(struct ScreenInfo *);
Prototype void FreePieceBitMap(struct PieceRot *, struct ScreenInfo *);
Prototype void DrawPiece(struct RastPort *, struct MakeStruct *, struct ScreenInfo *);

extern struct PieceRot Line[2];
extern struct PieceRot Block;
extern struct PieceRot Tee[4];
extern struct PieceRot Zig[2];
extern struct PieceRot Zag[2];
extern struct PieceRot Ell[4];
extern struct PieceRot Lee[4];

extern struct BitMap Sqbm;
extern const struct MakeStruct Sq;

extern struct PieceRot *Pieces[];

extern struct Bob PBob;
extern struct VSprite PVSprite;

extern struct Window *tWindow;
extern struct Window *pWindow;

/*
**
**  MakePieces()
**
**  A brute force approach to creating bitmaps of the different pieces.
**  I may go back and add some finesse to it later.
**
**  This routine will not notice if another bitmap already exists, meaning
**  that you will lose bitmaps if you're not careful.
*/
BOOL MakePieces(struct ScreenInfo *sInfo)
{
    struct RastPort rPort = {0};
    struct TmpRas tRas = {0};
    struct BitMap rBitMap;
    UBYTE * tBuf = NULL;
    int i;
    UWORD areaBuffer[400] = {0};
    struct AreaInfo aInfo;
    const UWORD fill = 0xFFFF;
    struct PieceRot *piece = NULL;
    BOOL success = TRUE;

    DBUG_ENTER("MakePieces");

    /*	Initialize the raster port  */
    InitRastPort(&rPort);

    /*	Init an AreaInfo for the Raster Port  */
    InitArea(&aInfo, areaBuffer, 160);
    rPort.AreaInfo = &aInfo;
    rPort.DrawMode = JAM1;

    InitBitMap(&rBitMap,sInfo->planes,ceil(sInfo->xTimes/4)*16,sInfo->yTimes * 4);

    /*	Init a temporary Raster for the Raster Port  */
    tBuf = AllocRaster(rBitMap.BytesPerRow * 8, rBitMap.Rows);
    if (tBuf) {
	InitTmpRas(&tRas, tBuf, rBitMap.BytesPerRow * rBitMap.Rows);
	rPort.TmpRas = &tRas;
    }

    /*	Finally, set the raster port's settings  */
    SetAfPt(&rPort, &fill, 0);

    /*	And now, we can finally begin drawing  */
    for (i=0; i<NUM_TYPES && success; i++) {
	piece = Pieces[i];
	do {
	    if ( GivePieceBitMap (piece, sInfo) ) {
		rPort.BitMap = &piece->BitMap;
		DrawPiece (&rPort, piece->ms, sInfo);
	    } else {
		success = FALSE;
	    }

	} while (((piece=piece->next)!=Pieces[i]) && (success));
    }

    /*	Let's draw the 1x1 square while we're at it.  */
    InitBitMap(&Sqbm, sInfo->planes,
	    ceil(sInfo->xTimes/4)*16, sInfo->yTimes * 4);
    for (i=0; i<sInfo->planes && success; i++)
	if (!(Sqbm.Planes[i]=AllocRaster(Sqbm.BytesPerRow * 8, Sqbm.Rows)))
	    success = FALSE;
    if (success) {
	rPort.BitMap = &Sqbm;
	DrawPiece (&rPort, &Sq, sInfo);
    }

    /*	And clean-up, if we can remember what's dirty :)  */
    if (tBuf) FreeRaster(tBuf, rBitMap.BytesPerRow * 8, rBitMap.Rows);

    DBUG_RETURN(success);
}

/*
**
**  DrawPiece()
**
**  Given a raster port, an array of MakeStructs, and an array of pens, draws
**  a playing piece.
**
*/
void DrawPiece(struct RastPort *rp, struct MakeStruct *MS, struct ScreenInfo *sInfo)
{
    struct MakeStruct *ms;

    DBUG_ENTER("DrawPiece");

    /*	Clear the raster  */
    SetRast(rp, sInfo->pens[BACK]);

    for (ms=MS; ms->command != STOP; ms++) switch (ms->command) {

	case DRAW:
	    Draw(rp, ms->xMult*sInfo->xTimes+ms->xOffSet,
		     ms->yMult*sInfo->yTimes+ms->yOffSet);
	    break;

	case MOVE:
	    Move(rp, ms->xMult*sInfo->xTimes+ms->xOffSet,
		     ms->yMult*sInfo->yTimes+ms->yOffSet);
	    break;

	case FLOOD:
	    Flood(rp, 1, ms->xMult*sInfo->xTimes+ms->xOffSet,
			 ms->yMult*sInfo->yTimes+ms->yOffSet);
	    break;

	case PEN:
	    SetAPen(rp, sInfo->pens[ms->xMult]);
	    break;

    }
    DBUG_VOID_RETURN;
}

/*
**
**  GivePieceBitMap()
**
**  Allocate BitMap structure and space for a piece's bitmap and clear
**  the bitmap.
**
*/
BOOL GivePieceBitMap(struct PieceRot *piece, struct ScreenInfo *sInfo)
{
    int i;
    BOOL success = TRUE;

    DBUG_ENTER("GivePieceBitMap");

    DBUG_PRINT("GPBM",("xTimes: %2d,  yTimes: %2d,  planes: %2d", sInfo->xTimes,
	    sInfo->yTimes, sInfo->planes));

    InitBitMap(&piece->BitMap, sInfo->planes,
	    ceil(sInfo->xTimes/4)*16, sInfo->yTimes * 4);
    for (i=0; i<sInfo->planes && success; i++) {
	if (!(piece->BitMap.Planes[i]= AllocMem(
	    piece->BitMap.BytesPerRow*piece->BitMap.Rows, MEMF_CHIP|MEMF_CLEAR
	))) {
	    success = FALSE;
	}
    }

    DBUG_RETURN(success);
}

/*
**
**  UnMakePieces()
**
**  Free the BitMaps for each of the Pieces
**
*/
void UnMakePieces(struct ScreenInfo *sInfo)
{
    int i;
    struct PieceRot *piece;

    DBUG_ENTER("UnMakePieces");

    for (i=0; i<NUM_TYPES; i++) {
	DBUG_PRINT("UMP",("Freeing piece %d", i));
	piece = Pieces[i];
	do {
	    FreePieceBitMap(piece, sInfo);
	    piece = piece->next;
	} while (piece != Pieces[i]);
    }

    for (i=0; i<sInfo->planes; i++) {
	if (Sqbm.Planes[i])
	    FreeRaster(Sqbm.Planes[i], Sqbm.BytesPerRow*8, Sqbm.Rows);
	Sqbm.Planes[i] = NULL;
    }


    DBUG_VOID_RETURN;
}

/*
**
**  FreePieceBitMap()
**
**  Free all the memory allocated by GivePieceBitMap
**
*/
void FreePieceBitMap(struct PieceRot *piece, struct ScreenInfo *sInfo)
{
    int i;

    DBUG_ENTER("FreePieceBitMap");

    for (i=0; i<sInfo->planes; i++) {
	if (piece->BitMap.Planes[i])
	    FreeMem(piece->BitMap.Planes[i],
		    piece->BitMap.BytesPerRow * piece->BitMap.Rows);
	piece->BitMap.Planes[i] = NULL;
    }

    DBUG_PRINT("FPBM",("BitMap.Planes NULLed"));

    DBUG_VOID_RETURN;
}
