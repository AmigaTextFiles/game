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



#ifndef _graph_keysyms_h
#define _graph_keysyms_h

typedef enum
{
	eA=0,eB,eC,eD,eE,eF,eG,eH,eI,eJ,eK,eL,eM,eN,eO,eP,eQ,eR,eS,eT,eU,eV,eW,
	eX,eY,eZ,eLeft,eRight,eUp,eDown,eSpace,eEsc,eEnter,eBackSpace,eDelete,
	e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,ePeriod,
	eNumKeySyms
} keysyms;

char keysym_to_char( keysyms aKeysym );

#endif

// $Log: graph_keysyms.h,v $
// Revision 1.3  2001/02/16 20:59:55  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.2  2000/10/06 19:29:06  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1  2000/10/01 19:28:01  tom
// - removed all references to CFont
// - fixed password entry menu item
//
