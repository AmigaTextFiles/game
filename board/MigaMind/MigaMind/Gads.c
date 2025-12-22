/*****************************************************************************

				GADS.c

		    Some GFX/INTUI-like-functions. 		1-5-90
								 Ekke
*****************************************************************************/


#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>
#include <proto/all.h>
#include "Gads.h"
#include "MM_Proto.h"


/***************************************************************************/
void BaseGad(struct RastPort *rp,BGAD *bg)
{
	SetAPen(rp, bg->bg_BPen);
	RectFill(rp, bg->bg_x, bg->bg_y, bg->bg_x+bg->bg_w, bg->bg_y+bg->bg_h);
	SetAPen(rp, bg->bg_TPen);
	Move(rp,bg->bg_x+TEXTPOS_X,bg->bg_y+TEXTPOS_Y);
	Text(rp,bg->bg_text,bg->bg_tsize);
}
/***************************************************************************/
void DrawSysGad(struct RastPort *rp,int id,int selected,int ready)
{
BGAD bg;

	if (id == QUIT)
	{   bg.bg_x = 8;
	    bg.bg_text = "QUIT";
	    bg.bg_TPen = 3;
	}
	else if (id == SHOW)
	{   bg.bg_x = 54;
	    if (ready) 
	    {	bg.bg_text = "MORE";
	    }
	    else 
	    {	bg.bg_text = "SHOW";
	    }
	    bg.bg_TPen = TPEN;
	}

	bg.bg_w = SYSGAD_W;
	bg.bg_h = SYSGAD_H;
	bg.bg_y = 140;
	bg.bg_tsize = 4;

	if (selected)
	{   bg.bg_TPen = TPEN_S;
	    bg.bg_BPen = BPEN_S;
	}
	else
	{   bg.bg_BPen = BPEN;
	}
	BaseGad(rp,&bg);
}
/***************************************************************************/
WORD GadPosX(int turn,int id)
{
WORD y;

	y = turn ? 22+id*14 : 8+id*14;
	return(y);
}
/***************************************************************************/
WORD GadPosY(int turn)
{
WORD y;
	y = turn ? turn*12+6 : 4;
	return(y);
}
/***************************************************************************/
void DrawGad(struct RastPort *rp,int turn,int id,int value,int selected)
{
BGAD bg;
char v = value + 'A' ;

	bg.bg_x = GadPosX(turn,id);
	bg.bg_y = GadPosY(turn);
	bg.bg_w = GAD_W;
	bg.bg_h = GAD_H;
	bg.bg_text = &v;
	bg.bg_tsize = 1;
	if (selected)
	{   bg.bg_TPen = TPEN_S;
	    bg.bg_BPen = BPEN_S;
	}
	else
	{   bg.bg_TPen = TPEN;
	    bg.bg_BPen = BPEN;
	}
	BaseGad(rp,&bg);
}
/***************************************************************************/
int GetSysID(WORD x,WORD y)
{
	if (y >= 140 && y <= 148)
	{   if (x >=  9 && x <= 42) return(QUIT);
	    if (x >= 55 && x <= 88) return(SHOW);
	}
	return(-1);
}
/***************************************************************************/
int GetGadTurn(WORD y)
{
int i;
WORD pos;

	if (y >= 4 && y < 4+GAD_H) return(0);
	for (i=1; i<11; i++)
	{   pos = 6+i*12 ;
	    if (y >= pos && y < pos+GAD_H) return(i);
	}
	return(-1);
}
/***************************************************************************/
int GetGadID(int turn,WORD x)
{
int i;
WORD pos;
	
	if (turn) 
	{   for (i=0; i<4; i++)
	    {	pos = 22+i*14;
		if (x >= pos && x < pos+GAD_W) return(i);
	    }
	    return(-1);
	}
	for (i=0; i<6; i++)
	{   pos = 8+i*14;
	    if (x >= pos && x < pos+GAD_W) return(i);
	}
	return(-1);
}											
/***************************************************************************/
int GadNr(int turn,int id)
{
	if (turn) return(2+turn*4+id);
	return(id);
}

