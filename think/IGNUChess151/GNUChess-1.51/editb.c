/************************************************************************/
/* Edit position														*/
/************************************************************************/

#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>

#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>

#include <libraries/gadtools.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>

#include <clib/macros.h>

#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "global.h"
#include "gfx.h"
#include "gnuchess.h"
#include "Proto.h"
#include "Interface.h"

extern short PieceList[2][16];

static int WIsCheck(void);
static int SIsCheck(void);
static int ValidBoard(void);

static struct Window	*v;
static struct RastPort	*rpv;
static int				WhoBegins, StartZugNr;


int MFeld(struct IntuiMessage *msg, int *index)
{
	int r, c;
	
	if ( (MOUSEX(msg) < XOFF) || (MOUSEY(msg) > YOFF) )
		return FALSE; 
	c = (MOUSEX(msg) - XOFF) / FELDBREITE;
	r = (YOFF - MOUSEY(msg)) / FELDHOEHE;
	if ( reverse ) {
		c = _H - c;
		r = _8 - r;
	}
	if ( (c >= _A) && (c <= _H) && (r >= _1) && (r <= _8) ) {
		*index = locn[r][c];
		return TRUE;
	}
	return FALSE;
}

static int WIsCheck(void)
{
	int i;

	for ( i = 0; i < 64; i++ )
		if ( ( board[i] == king ) && ( color[i] == white ) )
			return SqAtakd(i, black);
	return TRUE;
}

static int SIsCheck(void)
{
	int i;

	for ( i = 0; i < 64; i++ )
		if ( ( board[i] == king ) && ( color[i] == black ) )
			return SqAtakd(i, white);
	return TRUE;
}

static int ValidBoard(void)
{
	int	i, umw,
		wk = 0, wd = 0, wt = 0, wlwf = 0, wlsf = 0, ws = 0, wb = 0,
		sk = 0, sd = 0, st = 0, slwf = 0, slsf = 0, ss = 0, sb = 0;

	for ( i = 0; i < 64; i++ ) {
		switch ( board[i] ) {
				case king  : if ( color[i] == white ) wk++; else sk++; break;
				case queen : if ( color[i] == white ) wd++; else sd++; break;
				case rook  : if ( color[i] == white ) wt++; else st++; break;
				case knight: if ( color[i] == white ) ws++; else ss++; break;
				case pawn  : if ( color[i] == white ) wb++; else sb++; break;
 				case bishop:
					if ( FCOLOR(i / 8, i % 8) == COLOR_WFELD )
						if ( color[i] == white ) wlwf++; else slwf++;
					else
						if ( color[i] == white ) wlsf++; else slsf++;
					break;
		}
	}
	if ( (wk != 1) || (sk != 1) || (wb > 8) || (sb > 8) ) return FALSE;
	umw =	MAX(0, wd	- 1) +
			MAX(0, wt	- 2) +
			MAX(0, wlwf	- 1) +
			MAX(0, wlsf	- 1) +
			MAX(0, ws	- 2);
	if ( ( 8 - wb ) < umw ) return FALSE;
	umw =	MAX(0, sd	- 1) +
			MAX(0, st	- 2) +
			MAX(0, slwf	- 1) +
			MAX(0, slsf	- 1) +
			MAX(0, ss	- 2);
	if ( ( 8 - sb ) < umw ) return FALSE;

	if ( (WhoBegins == WHITE) && SIsCheck() ) return FALSE;
	if ( (WhoBegins == BLACK) && WIsCheck() ) return FALSE;

	for ( i =  0; i <=  7; i++ )
		if ( board[i] == pawn ) return FALSE;
	for ( i = 56; i <= 63; i++ )
		if ( board[i] == pawn ) return FALSE;

	return TRUE;
}

void EditBoard(void)
{
	int					i, quit = FALSE;
	struct IntuiMessage	*msg;
	int					Sel;
	struct Gadget		*SelG;
	int					sq;
	short				saved_board[64],
						saved_color[64];

	ClearMessage();

	v = OpenWindowTags(
		NULL,
		WA_Left,			NX1 - 2,
		WA_Top,				NY1 - 2,
		WA_Width,			NX2 - NX1 + 5,
		WA_Height,			TY2 - NY1 + 5,
		WA_DetailPen,		COLOR_TXTFGR,
		WA_BlockPen,		COLOR_BLOCK,
		WA_IDCMP,			IDCMP_GADGETUP,
		WA_CustomScreen,	s,
		WA_SizeGadget,		FALSE,
		WA_DragBar,			FALSE,
		WA_AutoAdjust,		TRUE,
		WA_Borderless,		TRUE,
		WA_NoCareRefresh,	TRUE,
		TAG_DONE
	);
	if ( ! v ) return;

	AddGList(v, EdB_GL , -1, -1, NULL);
	AddGList(v, EdB_GL2, -1, -1, NULL);

	ClearMenuStrip(w);

	rpv = v->RPort;

	SetRast(rpv, COLOR_REQBCK);

	DrawBevelBox(
		rpv,
		0,			1,
		NX2 - NX1 + 5,		TY2 - NY1 + 3,
		GT_VisualInfo,		vi,
		TAG_DONE
	);
	DrawBevelBox(
		rpv,
		0,			0,
		NX2 - NX1 + 5,		TY2 - NY1 + 5,
		GT_VisualInfo,		vi,
		TAG_DONE
	);

	SetAPen(rpv, COLOR_RAHMEN);
	for ( i = 0; i <= 2; i++ ) {
		Move(rpv,   6+i*50,   6);
		Draw(rpv,   6+i*50, 306);
		Move(rpv,   7+i*50,   6);
		Draw(rpv,   7+i*50, 306);
	}
	for ( i = 0; i <= 6; i++ ) {
		Move(rpv,   6, 6+i*50);
		Draw(rpv, 106, 6+i*50);
		Move(rpv,   6, 7+i*50);
		Draw(rpv, 106, 7+i*50);
	}

	Sel  = GAD_WB;
	SelG = EdB_GL;

	GT_SetGadgetAttrs(GAD_ToMove , v, NULL, GTCY_Active, 0, TAG_DONE);
	GT_SetGadgetAttrs(GAD_MoveNum, v, NULL, GTIN_Number, 1, TAG_DONE);

	RefreshGadgets(EdB_GL, v, NULL);
	GT_RefreshWindow(v, NULL);

	memcpy(saved_board, board, 64 * sizeof(short));
	memcpy(saved_color, color, 64 * sizeof(short));

	while ( ! quit ) {
		if ( ValidBoard() )
			GT_SetGadgetAttrs(GAD_Ok, v, NULL, GA_Disabled, FALSE, TAG_DONE);
		else
			GT_SetGadgetAttrs(GAD_Ok, v, NULL, GA_Disabled, TRUE , TAG_DONE);

		while ( TRUE ) {
			if ( msg = GT_GetIMsg(v->UserPort) ) break;
			if ( msg = GT_GetIMsg(w->UserPort) ) break;
			Wait((1 << v->UserPort->mp_SigBit) | (1 << w->UserPort->mp_SigBit));
			if ( msg = GT_GetIMsg(v->UserPort) ) break;
			if ( msg = GT_GetIMsg(w->UserPort) ) break;
		}
		switch ( CLASS(msg) ) {
			case IDCMP_MOUSEBUTTONS:
				if ( ( CODE(msg) & IECODE_UP_PREFIX ) && MFeld(msg, &sq) ) {
					if ( board[sq] == no_piece ) {
						switch ( Sel ) {
							case GAD_WB: board[sq] = pawn  ; color[sq] = white; break;
							case GAD_SB: board[sq] = pawn  ; color[sq] = black; break;
							case GAD_WS: board[sq] = knight; color[sq] = white; break;
							case GAD_SS: board[sq] = knight; color[sq] = black; break;
							case GAD_WL: board[sq] = bishop; color[sq] = white; break;
							case GAD_SL: board[sq] = bishop; color[sq] = black; break;
							case GAD_WT: board[sq] = rook  ; color[sq] = white; break;
							case GAD_ST: board[sq] = rook  ; color[sq] = black; break;
							case GAD_WD: board[sq] = queen ; color[sq] = white; break;
							case GAD_SD: board[sq] = queen ; color[sq] = black; break;
							case GAD_WK: board[sq] = king  ; color[sq] = white; break;
							case GAD_SK: board[sq] = king  ; color[sq] = black; break;
						}
					}
					else {
						board[sq] = no_piece; color[sq] = neutral;
					}
					DrawPiece(sq);
					Book = NULL;
				}
				break;
			case IDCMP_REFRESHWINDOW:
				GT_BeginRefresh(msg->IDCMPWindow);
				GT_EndRefresh(msg->IDCMPWindow, TRUE);
				break;
			case IDCMP_GADGETUP:
				switch ( GADGETID(msg) ) {
					case GAD_WB:
					case GAD_SB:
					case GAD_WT:
					case GAD_ST:
					case GAD_WS:
					case GAD_SS:
					case GAD_WL:
					case GAD_SL:
					case GAD_WD:
					case GAD_SD:
					case GAD_WK:
					case GAD_SK:
						if ( Sel != GADGETID(msg) ) {
							Sel = GADGETID(msg);
							SelG->Flags &= ~GFLG_SELECTED;
							RefreshGList(SelG, v, NULL, 1);
							SelG = GADGET(msg);
						}
						SelG->Flags |=  GFLG_SELECTED;
						RefreshGList(SelG, v, NULL, 1);
						break;
					case GAD_CLEAR:
						for ( sq = 0; sq < 64; sq++ ) {
							board[sq] = no_piece; color[sq] = neutral;
						}
						Book = NULL;
						UpdateDisplay(0,0,1,0);
						break;
					case GAD_DEFAULT:
						GT_SetGadgetAttrs(GAD_ToMove , v, NULL, GTCY_Active, 0, TAG_DONE);
						GT_SetGadgetAttrs(GAD_MoveNum, v, NULL, GTIN_Number, 1, TAG_DONE);
						for ( sq = 0; sq < 64; sq++ ) {
							board[sq] = Stboard[sq]; color[sq] = Stcolor[sq];
						}
						UpdateDisplay(0, 0, 1, 0);
						if ( ! Book ) GetOpenings();
						break;
					case GAD_OK:
						quit = TRUE;
						mate = false;
						StartZugNr = GADGETINT(GAD_MoveNum);
						kingmoved[white] = (board[ 4] != king) ? 10 : 0;
						kingmoved[black] = (board[60] != king) ? 10 : 0;
						GameCnt = -1; Game50 = 0; Sdepth = 0;
						InitializeStats();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case GAD_MOVENUM:
						break;
					case GAD_TOMOVE:
						WhoBegins = (WhoBegins == WHITE) ? BLACK : WHITE;
						break;
					default:
						break;
				}
				break;
			default:
				break;				
		}
		GT_ReplyIMsg(msg);
	}

	RemoveGList(v, EdB_GL2, -1);
	CloseWindow(v);
	SelG->Flags &= ~GFLG_SELECTED;
	SelG = EdB_GL;
	SelG->Flags |=  GFLG_SELECTED;

	if ( ! ResetMenuStrip(w, Menu) ) ExitChess(10);
}
