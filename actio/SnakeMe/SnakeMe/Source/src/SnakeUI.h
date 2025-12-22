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


#ifndef __SNAKEUI_H
#define __SNAKEUI_H

#include "SGU_UI.h"
#include "SGU_List.h"
#include "CSnakeArray.h"

/* depreciated
class CUISnakeList:public CUIGenericList
{
public:
	CUISnakeList(int ix,int iy, int iw,int ih,CUITheme *ithm,int nbel,int elw,int slidew):CUIGenericList( ix, iy,  iw, ih, ithm, nbel, elw, slidew) {}
private:
	void DisplayListElement(int eln,int x,int y,SDL_Surface *si);
public:
	void SetSnakes(List *snk) {snakes=snk; }
private:
	List *snakes;
};
*/

class CUISnakeChooser:public CUIGenericHorzIntBar
{
public:
	CUISnakeChooser(int ix,int iy, int iw, int ih,CUITheme *ithm,List *snk):CUIGenericHorzIntBar(ix,iy,iw,ih,ithm,0,snk->GetNbElement()-1,0,ih)
	{
		warp=true;
		snakes=snk;
	}
	bool SendChildMessage(int message,int p1,int p2,SDL_Surface *si);
	void DoTick(SDL_Surface *si);
	int GetSel(void) { return val; }
private:
	SGU_RegionSaver snakeregion;
	int lsnakezone;
	List *snakes;
};

class CUILevelViewer:public CUIObject
{
public:
	CUILevelViewer(int ix,int iy,CUITheme *ithm):CUIObject(ix,iy,SNAKEARRAYW<<1,SNAKEARRAYH<<1,ithm) { }
	bool SendMessage(int message,int p1,int p2,SDL_Surface *si) { return DefaultSendMessage(message,p1,p2,si); }
	void DrawArray(char *array,SDL_Surface *si);
};

class CUIThemeViewer:public CUIObject
{
public:
	CUIThemeViewer(int ix,int iy,CUITheme *ithm):CUIObject(ix,iy,SNAKEARRAYW<<1,SNAKEARRAYH<<1,ithm) { }
	bool SendMessage(int message,int p1,int p2,SDL_Surface *si) { return DefaultSendMessage(message,p1,p2,si); }
	void DrawTheme(char *theme,SDL_Surface *si);
};

#endif
