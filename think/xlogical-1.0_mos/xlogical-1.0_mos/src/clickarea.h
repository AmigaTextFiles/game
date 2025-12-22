//////////////////////////////////////////////////////////////////////
// XLogical - A puzzle game
//
// Copyright (C) 2000 Neil Brown, Tom Warkentin
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// or at the website: http://www.gnu.org
//
////////////////////////////////////////////////////////////////////////



#ifndef CLICKAREA_H
#define CLICKAREA_H

class Cclick_area
{
public:
	void set_area( int x, int y, int X, int Y ) { ux=x; uy=y; lx=X; ly=Y; }
	void set_func( void(*f)(int,int,int) ) { clickFunc = f; }
	int click_it( int, int, int );
	Cclick_area( void );
	~Cclick_area( void );
private:
	int ux;
	int uy;
	int lx;
	int ly;
	void(*clickFunc)( int, int, int );
};

#endif
// $Id: clickarea.h,v 1.3 2001/02/16 20:59:52 tom Exp $
//
// $Log: clickarea.h,v $
// Revision 1.3  2001/02/16 20:59:52  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.2  2000/10/06 19:29:04  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.2  1999/12/25 08:18:33  tom
// Added "Id" and "Log" CVS keywords to source code.
//
