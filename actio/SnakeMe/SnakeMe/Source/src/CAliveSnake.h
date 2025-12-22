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

#ifndef __CALIVESNAKE_H
#define __CALIVESNAKE_H

#include "CSnake.h"
#include "CDeadSnake.h"
class CAliveSnake:public CSnake
{
public:
	CAliveSnake() { tol=0; dir=3; upcoming=true; frozen=false;/*snake=NULL; length=0;*/ }
	~CAliveSnake() { /*if(snake) free(snake); snake=NULL;*/ }
	void Clear(void);
	bool TestCollision(int *type);  // true == collision
	void DoStepAndDraw(SDL_Surface *si);
	bool KillAtPos(int x,int y,CDeadSnake **dead,int lifetime);
	SSnakePos GetNextStep(void);
	void IncreaseLength(int l) {tol=l; }
	void TurnRight(void) {dir=(dir-1)&0x3; }
	void TurnLeft(void) {dir=(dir+1)&0x3; }
	//void SetDir(int n) {if (n!=((dir+2)&0x3)) dir=n; }
	void SetDir(int n);
	int GetDir(void) {return dir; }
	void SetUpcoming(SDL_Surface *si, int t);
	void ClrUpcoming(SDL_Surface *si);
	bool IsUpcoming(void) { return upcoming; }
	bool IsWaiting(void) { return (waittime>0); }
	void Freeze(void) { frozen=true; }
	void UnFreeze(void) { frozen=false; }
	bool IsFrozen(void) { return frozen; }
private:
	int tol;
	int dir;
	int waittime;
	bool upcoming;
	bool frozen;
public:
	int defx,defy;
	int owner;
};

#endif
