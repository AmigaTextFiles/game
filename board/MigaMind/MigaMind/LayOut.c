/*****************************************************************************

				Paint.c
		    Some GFX-functions, obviously.
								1-5-90
								 Ekke
*****************************************************************************/

#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>
#include <proto/all.h>
#include "Gads.h"
#include "MM_Proto.h"

/****************************************************************************/
void Line(struct RastPort *rp,WORD x1,WORD y1,WORD x2,WORD y2)
{
	Move(rp,x1,y1);
	Draw(rp,x2,y2);
}

/****************************************************************************/
void PaintLines(struct RastPort *rp)
{
int i;
WORD y;
WORD l[4] = { 0,1,96,97 };
WORD m[4] = { 18,19,78,79 };

	SetAPen(rp,1);
/* horizontaal */
	Line(rp,0,0,97,0);
	for (i=0,y=16; i<11; i++,y+=12) Line(rp,0,y,97,y);
	Line(rp,0,152,97,152);
/* vertikaal */
	for (i=0; i<4; i++) Line(rp,l[i],0,l[i],152);	
	for (i=0; i<4; i++) Line(rp,m[i],16,m[i],136);	
}

/****************************************************************************/
void HRBorder(struct RastPort *rp,WORD x1,WORD y1,WORD x2,WORD y2)
{
	Move(rp,x1,y1);		/*				*/
	Draw(rp,x1,y2);		/*	|		|	*/
	Draw(rp,x2-1,y2);	/*	|		|	*/
	Draw(rp,x2-1,y1+1);	/*	|_______________|	*/

	Move(rp,x1+1,y2-1);	/*	  _______________	*/
	Draw(rp,x1+1,y1);	/*	 |		 |	*/
	Draw(rp,x2,y1);		/*	 |		 |	*/
	Draw(rp,x2,y2);		/*	 |		 |	*/
}

/****************************************************************************/
void PaintBorders(struct RastPort *rp)
{
	SetAPen(rp,3);
	HRBorder(rp,4,2,93,14);
	HRBorder(rp,4,138,47,150);
	HRBorder(rp,50,138,93,150);
}

/****************************************************************************/
void PaintGads(struct RastPort *rp)
{
int i,j;
WORD x,y;

	for (i=0; i<6; i++) DrawGad(rp,0,i,i,0);
	SetAPen(rp,2);
	for (i=0; i<4; i++)
	{   for (j=1; j<11; j++)
	    {	x = GadPosX(j,i);
		y = GadPosY(j);
		RectFill(rp,x,y,x+GAD_W,y+GAD_H);
	}   }
	DrawSysGad(rp,QUIT,0,0);
	DrawSysGad(rp,SHOW,0,0);
}

/****************************************************************************/
void LayOut(struct RastPort *rp)
{
	SetRast(rp,0);
	BNDRYOFF(rp);
	SetDrMd(rp,JAM1);

	PaintLines(rp);
	PaintBorders(rp);
	PaintGads(rp);
}

/****************************************************************************/
void Block(struct RastPort *rp,WORD x,WORD y)
{
	Move(rp,x,y);
	Draw(rp,x+2,y);
	Move(rp,x,y+1);
	Draw(rp,x+2,y+1);
}

/****************************************************************************/
void PaintWright(struct RastPort *rp,int turn,int colors,int positions)
{
WORD y[2] = {1,6}, x[4] = {5,12,83,90}, ypos;

	ypos = GadPosY(turn);

	SetAPen(rp,2);	
	if (colors > 3) Block(rp,x[3],(WORD)(y[1]+ypos));
	if (colors > 2) Block(rp,x[2],(WORD)(y[1]+ypos));
	if (colors > 1) Block(rp,x[3],(WORD)(y[0]+ypos));
	if (colors > 0) Block(rp,x[2],(WORD)(y[0]+ypos));

	SetAPen(rp,3);
	if (positions > 3) Block(rp,x[1],(WORD)(y[1]+ypos));
	if (positions > 2) Block(rp,x[0],(WORD)(y[1]+ypos));
	if (positions > 1) Block(rp,x[1],(WORD)(y[0]+ypos));
	if (positions > 0) Block(rp,x[0],(WORD)(y[0]+ypos));
}



