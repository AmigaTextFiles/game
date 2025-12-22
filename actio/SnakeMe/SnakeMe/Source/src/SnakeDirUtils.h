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


#ifndef __SNAKEDIRUTILS_H
#define __SNAKEDIRUTILS_H

inline int DxytoDir(int dx,int dy)
{
	if ((dx<-1) || (dx>1) || (dy<-1) || (dy>1))
	{
		return -1;
	}
	static int dtodir[3][3] = { {2,2,2},{1,0,3},{0,0,0}};
	return dtodir[dx+1][dy+1];
}

inline int DirtoDx(int dir)
{
	if (dir==0)
		return 1;
	else if (dir==2)
		return -1;
	else return 0;
}

inline int DirtoDy(int dir)
{
	if (dir==1)
		return -1;
	else if (dir==3)
		return 1;
	else
		return 0;
}

inline int NLtoI(int next,int last)
{
	if ((next<0) || (next>3) ||(last<0) || (last>3))
	{
		return -1;
	}
	static int dirmid[4][4] = { {0,8,0,4}, {5,1,9,1} ,{2,6,2,10} ,{11,3,7,3}};
	return dirmid[next][last];
	// always next-actual, previous-actual
}

#endif

