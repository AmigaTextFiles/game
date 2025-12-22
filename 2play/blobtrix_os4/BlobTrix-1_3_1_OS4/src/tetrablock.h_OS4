/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#ifndef _TETRABLOCK_H_
#define _TETRABLOCK_H_

#include "SDL.h"
#include "config.h"

#define XSIZE 14
#define YSIZE 28

class tetrablock {
	public:
		tetrablock(int x, int y, int type, char *blockmap);
		tetrablock(char *blockmap);
		tetrablock();

		int CollideHorizontalWalls(int x, int y);
		bool CollideBlocks(int x, int y);
		bool MoveLeft();
		bool MoveRight();
		bool Drop();

		void Fossilize();
		void Fossilize(char *bmap, int i);

		int GetX();
		int GetY();
		int GetAngle();
		int GetType();

		int GetMinY();
		int GetMaxY();

		void SetX(int x);
		void SetY(int y);
		void SetAngle(int angle);
		void SetType(int type);

		void SetUsed(bool b);
		void QuickSetUsed(bool b);
		bool IsUsed();
		void DecreaseHideTime();

		bool Launched();
	 	void SetSpeed(int dropspeed, int dropdirection);

		int dropspeed;
		int dropdirection;
		int droptimer;
		int x, y, type, angle;

	private:
		int GetBlock(int x, int y);
		void SetBlock(int x, int y, char c);

		char *blockmap;
		bool falling;

		bool inuse;
//		Uint32 notinusetime; NOTICE



};




#endif
