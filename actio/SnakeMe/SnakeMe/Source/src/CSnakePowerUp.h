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


#ifndef __CSNAKEPOWERUP_H
#define __CSNAKEPOWERUP_H

#include "CSnakeArray.h"
#include "CSnake.h"
#include "SGU.h"
#include "SGU_List.h"

#define MEALBYEBYE 4

class CSnakeMeal
{
public:
	CSnakeMeal() { meals=NULL; timeleft=-1; }
	~CSnakeMeal() {  if (meals) delete meals; }
	bool IsAtPos(int x,int y);
	bool EatAtPos(int x,int y,SDL_Surface *si);
	void SetBaseValues(int nbm,SDL_Surface *si,CSnakeArray *ar,SGU_Sprite *spr,int f);
	SSnakePos GetMealPos(int m) { return meals[m]; }
	int GetNbMeal(void) { return nbmeal; }
	void Redraw(SDL_Surface *si);
	void DisplaceAMeal(SDL_Surface *si);
	void DoStepAndDraw(SDL_Surface *si,CSnakeMeal *other);
	void ComputeNewMealPosition(int *nx,int *ny,CSnakeMeal *other);
private:
	int nbmeal;
	int timeleft;
	int mealtobereplaced;
	SSnakePos *meals;
	CSnakeArray *array;
	SGU_Sprite *sprite;
	int frame;
};

class CFireToken
{
public:
	int x;
	int y;
	int dx;
	int dy;
	int owner;
	int dir;
	bool valid;
public:
	int GetNextX() { return x+dx; }
	int GetNextY() { return y+dy; }
};
// dir : 0:right, 1:top, 2:left, 3:bottom

class CSnakeFire
{
public:
	CSnakeFire() { nfire=0; fires=NULL; }
	~CSnakeFire() {  free (fires); }
	void DoStepAndDraw(SDL_Surface *si);
	void AddFire(int x,int y,int dx,int dy,int o,int dir);
	void SetBaseValues(CSnakeArray *ar,SGU_Sprite *spr) { array=ar; sprite=spr; }
public:
	CFireToken *fires;
	int nfire;
private:
	SGU_Sprite *sprite;
	CSnakeArray *array;
};

#endif
