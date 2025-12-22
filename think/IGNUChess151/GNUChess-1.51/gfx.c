/************************************************************************/
/* "Low-Level" graphics functions										*/
/************************************************************************/

#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>

#include <intuition/intuition.h>

#include <proto/graphics.h>
#include <proto/intuition.h>

#include "global.h"
#include "gfx.h"
#include "gnuchess.h"

static void DrawRect(int, int, int, int);

void DrawFeld(int Figur, int x, int y)
{
	int off;

	switch ( Figur ) {
		case ' ': off =  0; break;
		case 'P': off =  1; break;
		case 'R': off =  2; break;
		case 'N': off =  3; break;
		case 'B': off =  4; break;
		case 'Q': off =  5; break;
		case 'K': off =  6; break;
		case 'p': off =  7; break;
		case 'r': off =  8; break;
		case 'n': off =  9; break;
		case 'b': off = 10; break;
		case 'q': off = 11; break;
		case 'k': off = 12; break;
	}
	if ( ! (ODD(x + y)) ) off += 13;
	DrawImage(rp, Images[off], XPOS(x), YPOS(y));
}

void XField(int sq, int col)
{
	int x1, y1;
	
	x1 = XPOS(sq % 8); y1 = YPOS(sq / 8);
	
	SetAPen(rp, col);
	DrawRect(x1 - 2, y1 - 2, x1 + (FELDBREITE - 1), y1 + (FELDHOEHE - 1));
	DrawRect(x1 - 1, y1 - 1, x1 + (FELDBREITE - 2), y1 + (FELDHOEHE - 2));
}

static void DrawRect(int x1, int y1, int x2, int y2)
{
	Move(rp, x1, y1);
	Draw(rp, x1, y2);
	Draw(rp, x2, y2);
	Draw(rp, x2, y1);
	Draw(rp, x1, y1);
}

void ResetGfx(void)
{
	if ( reverse )
		PrintIText(rp, IText_rev, XOFF - 16, YOFF - 384);
	else
		PrintIText(rp, IText_nor, XOFF - 16, YOFF - 384);
}
