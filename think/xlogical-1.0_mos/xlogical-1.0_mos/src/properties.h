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



// $Id: properties.h,v 1.8 2001/02/16 21:00:02 tom Exp $
// 

#ifndef _properties_h_
#define _properties_h_

#include <cstring>
#include <list>
#include <map>
#include <string>

#ifdef WIN32
using namespace std;
#endif

#include "defs.h"

class properties
{
   public:
		typedef list<string> search_paths_t;
      properties(
			int aArgc,
			char ** aArgv,
			const search_paths_t& aSearchPaths );
      virtual ~properties();

      inline const string& get( const char * aKey ) const { return get(string(aKey)); }
      const string& get( const string& aKey ) const;
      void put( const string& aKey, const string& aValue );
		void remove( const string& aKey );
		void write( const string& aFileName="" );

      static properties& instance();

   private:
      properties();  // can't use this

      struct string_lt
      {
         inline bool operator()( const string& aStr1, const string& aStr2 ) const
         {
            return( strcasecmp( aStr1.c_str(), aStr2.c_str() ) < 0 );
         }
      };
      typedef map<string, string, string_lt> properties_t;

      bool                 load_file_props( const string& aName );
      void                 parse_line(
										const char * aLine,
										const unsigned long aLen,
										string& aKey,
										string& aValue );

		string					fFileLoaded;
      properties_t         fProperties;
      static properties*   fGlobalProperties;
};

#endif

// $Log: properties.h,v $
// Revision 1.8  2001/02/16 21:00:02  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.7  2001/01/20 17:32:33  brown
// Working toward Windows integration
//
// Revision 1.6  2000/10/08 16:46:25  tom
// added filename parameter to write() method
//
// Revision 1.5  2000/10/08 16:07:29  tom
// fixed some little annoyances
//
// Revision 1.4  2000/10/07 21:48:35  tom
// added logic to write out properties on exit
//
// Revision 1.3  2000/10/07 04:00:50  tom
// added search path for xlogical property file
//
// Revision 1.2  2000/10/06 19:29:11  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1  2000/10/01 05:00:26  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
//
