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



#ifndef GLOBALS_H
#define GLOBALS_H

extern void clean_exit( int aExitCode=0 );

#endif
// $Id: globals.h,v 1.5 2001/02/16 20:59:55 tom Exp $
//
// $Log: globals.h,v $
// Revision 1.5  2001/02/16 20:59:55  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2000/10/08 16:07:29  tom
// fixed some little annoyances
//
// Revision 1.3  2000/10/06 19:29:05  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 05:00:24  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.8  2000/02/23 05:53:34  tom
// Changed music and sound playing to use ESD (mod playing is broken now).
//
// Revision 1.7  2000/01/23 06:11:37  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.6  1999/12/25 08:18:33  tom
// Added "Id" and "Log" CVS keywords to source code.
//
