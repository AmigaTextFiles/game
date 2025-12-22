/*

	SnakeMe 1.0 GPL
	Copyright (C) 2000 Stephane Magnenat/Ysagoon

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/


#include "SnakeUI.h"
#include "CSnakeArray.h"
#include <stdio.h>

/* depreciated
void CUISnakeList::DisplayListElement(int eln,int x,int y,SDL_Surface *si)
{
	((SGU_Sprite *)(snakes->GetElementN(eln)))->Display(si,x+2,y+4,14);
	for (int m=1;m<9;m++)
	{
		((SGU_Sprite *)(snakes->GetElementN(eln)))->Display(si,x+(m<<3)+2,y+4,2);
	}
	((SGU_Sprite *)(snakes->GetElementN(eln)))->Display(si,x+74,y+4,18);
};
*/

bool CUISnakeChooser::SendChildMessage(int message,int p1,int p2,SDL_Surface *si)
{
	switch (message)
	{
	case UIEV_DRAW:
		{
			lsnakezone=w-(2*arrowlng);
			snakeregion.SaveRegion(si,x+arrowlng,y,lsnakezone,h);
			SendChildMessage(INTERNEV_REDRAW,0,0,si);
			return true;
		}
	case INTERNEV_REDRAW:
		{
			// redraw background
			snakeregion.RestaurRegion(si);
			// draw snake
			((SGU_Sprite *)(snakes->GetElementN(val)))->Display(si,x+arrowlng+10,y+5,14);
			for (int m=1;m<5;m++)
			{
				((SGU_Sprite *)(snakes->GetElementN(val)))->Display(si,x+arrowlng+(m<<3)+10,y+5,2);
			}
			((SGU_Sprite *)(snakes->GetElementN(val)))->Display(si,x+arrowlng+50,y+5,18);
			return true;
		}
	default:
		return false;
	}
}

void CUISnakeChooser::DoTick(SDL_Surface *si)
{

}

void CUILevelViewer::DrawArray(char *array,SDL_Surface *si)
{
	int cx,cy,d;
	unsigned char r,g,b;
	FILE *fp;
	fp=fopen(array,"rb");
	if (fp)
	{
		// load obstacles
		for (cx=0;cx<SNAKEARRAYW;cx++)
		{
			for (cy=0;cy<SNAKEARRAYH;cy++)
			{
				fscanf(fp,"%d\n",&d);
				if ((d==10) || (d==11))
				{
					r=0;
					g=0;
					b=0;
				}
				else if ((d==12) || (d==13))
				{
					r=255;
					g=0;
					b=0;
				}
				else
				{
					r=100;
					g=100;
					b=255;
				}
				SGU_SetPixel(si,x+(cx<<1),y+(cy<<1),r,g,b);
			}
		}
		fclose(fp);
	}
}


void CUIThemeViewer::DrawTheme(char *theme,SDL_Surface *si)
{
	int n,m;
	SDL_Rect r1,r2;
	SGU_Sprite spr;

	// load theme
	spr.Load(theme,si->format);
	// draw background
	for (n=0;n<20;n++)
	{
		for (m=0;m<14;m++)
		{
			r1.x=((n<<3)%spr.GetW(0));
			r1.y=((m<<3)%spr.GetH(0));
			r1.w=8;
			r1.h=8;
			r2.x=(n<<3)+x;
			r2.y=(m<<3)+y;
			r2.w=8;
			r2.h=8;
			SDL_BlitSurface(spr.GetFrameSurface(0),&r1,si,&r2);
		}
	}

	// draw exterior
	for (n=0;n<20;n++)
	{
		spr.Display(si,x+(n<<3),y,1);		
		spr.Display(si,x+(n<<3),y+104,1);
	}
	for (n=0;n<12;n++)
	{
		spr.Display(si,x,y+8+(n<<3),1);		
		spr.Display(si,x+152,y+8+(n<<3),1);
	}
}
