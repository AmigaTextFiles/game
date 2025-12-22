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



// $Id: properties.cpp,v 1.4 2001/02/19 03:03:55 tom Exp $
//

#include <cstdio>
#include <fstream>

#include "exception.h"
#include "properties.h"

#ifdef WIN32
const string kFileNameSuffix( ".ini" );
#else
const string kFileNameSuffix( ".properties" );
#endif
const unsigned long kBufferSize = 1024;

properties* properties::fGlobalProperties = NULL;

properties::properties(
	int aArgc,
	char ** aArgv,
	const search_paths_t& aSearchPaths)
{
	if (fGlobalProperties)
	{
cout << "xxxpropertiesError000xxx" << endl;
		ThrowEx( "properties already initialized" );
	}

   // load properties from supplied search path
	bool loaded=false;
	string searchedPaths;
	for(	search_paths_t::const_iterator iter=aSearchPaths.begin();
			iter != aSearchPaths.end();
			++iter )
	{
		searchedPaths += (searchedPaths.length() == 0) ? *iter : ":" + *iter;
		if (load_file_props( *iter ))
		{
			fFileLoaded = *iter;
			loaded = true;
			break;
		}
	}
	// if we still haven't loaded properties, try argv[0] + suffix
	string defaultPath = string( aArgv[0] ) + kFileNameSuffix;
	if (!loaded)
	{
		if (!load_file_props( defaultPath ))
		{
			// give up
			searchedPaths +=
				(searchedPaths.length() == 0) ? defaultPath : string(":")+defaultPath;
cout << "xxxpropertiesError001xxx" << endl;
			ThrowEx( string( "cannot find properties in '" ) + searchedPaths + "'" );
		} else {
			fFileLoaded = defaultPath;
		}
	}

   // override with properties on command line
	string key;
	string value;
   for( int i=1; i<aArgc; i+=1 )
   {
      char buf[kBufferSize+1];
      strncpy( buf, aArgv[i], kBufferSize );
      buf[kBufferSize] = '\0';
      try
      {
         parse_line( buf, strlen( buf ), key, value );
			if (key.length() > 0)
			{
				put( key, value );
			}
      }
      catch( CXLException& e )
      {
         char numBuf[20];
         sprintf( numBuf, "%d", i );
cout << "xxxpropertiesError002xxx" << endl;
         ThrowEx( string( "arg " ) + numBuf + ": " + e.Error() );
      }
   }
   fGlobalProperties = this;
}

properties::~properties()
{
   fProperties.clear();
	if (fGlobalProperties == this)
	{
		fGlobalProperties = NULL;
	}
}

bool
properties::load_file_props( const string& aFileName )
{
   ifstream in( aFileName.c_str() );

   if (!in)
   {
		return( false );
   }

	string key;
	string value;
   char buf[kBufferSize+1];
   unsigned long lineNum = 0;
   while( in )
   {
      in.getline( buf, kBufferSize );
      lineNum += 1;
      buf[kBufferSize] = '\0';
      try
      {
         parse_line( buf, strlen( buf ), key, value );
			if (key.length() > 0)
			{
				put( key, value );
			}
      }
      catch( CXLException& e )
      {
         char numBuf[20];
         sprintf( numBuf, "%ld", lineNum );
         in.close();
cout << "xxxpropertiesError003xxx" << endl;
         ThrowEx( string( "line " ) + numBuf + ": " + e.Error() );
      }
   }
   in.close();
	return( true );
}

void
properties::parse_line(
	const char * aLine,
	const unsigned long aLen,
	string& aKey,
	string& aValue )
{
	aKey.erase();
	aValue.erase();

	char buf[kBufferSize+1];
   if ((aLine[0] != '#') && (aLen > 0) && (aLen <= kBufferSize))
   {
		strncpy( buf, aLine, aLen );
		buf[aLen] = '\0';

      // find first equal sign
      bool found = false;
      char *tmp;
      for( tmp=buf; (*tmp) != '\0'; ++tmp )
      {
         if (*tmp == '=')
         {
            found = true;
            break;
         }
      }
      if (!found)
      {
cout << "xxxpropertiesError004xxx" << endl;
         ThrowEx( "missing '=' in property" );
      }
      *tmp = '\0';
		aKey = string( buf );
		aValue = string( tmp+1 );
   }
}

const string&
properties::get( const string& aKey ) const
{
   properties_t::const_iterator iter = fProperties.find( aKey );
   if (iter == fProperties.end())
   {
cout << "xxxpropertiesError005xxx" << endl;
cout << "property ";
cout << aKey;
cout << " not found" << endl;
      ThrowEx( string( "property '" ) + aKey + "' not found" );
   }
   return( iter->second );
}

void
properties::put( const string& aKey, const string& aValue )
{
   fProperties[aKey] = aValue;
}

void
properties::remove( const string& aKey )
{
   properties_t::iterator iter = fProperties.find( aKey );
   if (iter == fProperties.end())
   {
cout << "xxxpropertiesError006xxx" << endl;
      ThrowEx( string( "property '" ) + aKey + "' not found" );
   }
	fProperties.erase( iter );
}

void
properties::write( const string& aFileName )
{
	if (fFileLoaded.length() == 0)
	{
		return;
	}

	// maybe there is a more efficient way to do this... but for now load in
	// the lines in the properties file, and then as we're writing out
	// properties, parse the lines and replace with the values we have in
	// memory.  This way comments are left intact.
	list<string> lines;
	ifstream ifs( fFileLoaded.c_str(), ios::in );

	if (!ifs)
	{
cout << "xxxpropertiesError007xxx" << endl;
		ThrowEx(
			string( "unable to read properties file '" )
				+ fFileLoaded.c_str()
				+ "'" );
	}

	// read in all the lines into our list
   char buf[kBufferSize+1];
   while( ifs )
   {
      ifs.getline( buf, kBufferSize );
		if (!ifs.bad() && !ifs.eof())
		{
			buf[kBufferSize] = '\0';
			lines.push_back( buf );
		}
   }
   ifs.close();

	string fileName = (aFileName.length() > 0) ? aFileName : fFileLoaded;

	if (fileName.length() == 0)
	{
		return;
	}

	// write out the lines
	ofstream ofs( fileName.c_str(), ios::out|ios::trunc );
	if (!ofs)
	{
cout << "xxxpropertiesError008xxx" << endl;
		ThrowEx(
			string( "unable to write properties file '" )
				+ fileName.c_str()
				+ "'" );
	}
	string key;
	string value;
	for(	list<string>::iterator iter=lines.begin();
			iter != lines.end();
			++iter )
	{
		bool found = false;
		key.erase();
		value.erase();
		try
		{
			parse_line( iter->c_str(), iter->length(), key, value );
			if (key.length() > 0)
			{
				try
				{
					value = properties::instance().get( key );
					found = true;
				}
				catch( CXLException& e )
				{
					// do nothing
				}
			}
		}
		catch( CXLException& e )
		{
			// do nothing
		}

		if (!found)
		{
			// write out original line
			ofs << iter->c_str() << endl;
		} else {
			// write out value we found
			ofs << key.c_str() << '=' << value.c_str() << endl;
		}
	}
	ofs.close();

	lines.clear();
}

properties&
properties::instance()
{
   if (!fGlobalProperties)
   {
cout << "xxxpropertiesError009xxx" << endl;
      ThrowEx( "properties not initialized" );
   }
   return( *fGlobalProperties );
}

// $Log: properties.cpp,v $
// Revision 1.4  2001/02/19 03:03:55  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.3  2001/02/17 07:18:24  tom
// got xlogical working in windows finally - with the following limitations:
// - music is broken (disabled in this checkin)
// - no user specified mod directories for in game music
// - high scores will be saved as user "nobody"
//
// Revision 1.2  2001/02/16 21:00:02  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:32  brown
// Working toward Windows integration
//
// Revision 1.8  2000/10/08 16:58:05  tom
// fixed a bug in writing properties file
//
// Revision 1.7  2000/10/08 16:46:25  tom
// added filename parameter to write() method
//
// Revision 1.6  2000/10/08 16:07:29  tom
// fixed some little annoyances
//
// Revision 1.5  2000/10/07 21:48:35  tom
// added logic to write out properties on exit
//
// Revision 1.4  2000/10/07 04:00:50  tom
// added search path for xlogical property file
//
// Revision 1.3  2000/10/06 19:29:11  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 08:08:15  tom
// finished implementing the SDL_mixer audio driver
//
// Revision 1.1  2000/10/01 05:00:25  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
//
