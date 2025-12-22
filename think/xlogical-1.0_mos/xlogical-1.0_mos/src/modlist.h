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



#ifndef _modlist_h_
#define _modlist_h_

#include <list>
#include <string>
#include <vector>

#ifdef WIN32
using namespace std;
#endif

typedef list<string> 	file_list_base_t;

class Cmodlist : public file_list_base_t
{
public:
	Cmodlist();
	virtual ~Cmodlist();

	void init();
	void randomize();
	string next();
	string previous();

	static Cmodlist& instance();

private:
	typedef vector<string>	path_list_t;

	static const char kPathSeparator[];
	static Cmodlist * fGlobalList;
	static iterator   fCurrent;

	void parse_paths( const string& aDirPaths, path_list_t& aOutputPaths );
};

#endif

// $Log: modlist.h,v $
// Revision 1.6  2001/02/17 07:18:24  tom
// got xlogical working in windows finally - with the following limitations:
// - music is broken (disabled in this checkin)
// - no user specified mod directories for in game music
// - high scores will be saved as user "nobody"
//
// Revision 1.5  2001/02/16 21:00:02  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2001/01/20 17:32:31  brown
// Working toward Windows integration
//
// Revision 1.3  2000/10/25 16:45:24  brown
// Updated to build on vanilla RedHat 7.0
//
// Revision 1.2  2000/10/06 19:29:10  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1  2000/10/01 08:08:15  tom
// finished implementing the SDL_mixer audio driver
//
