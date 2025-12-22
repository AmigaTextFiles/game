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



#include <dirent.h>
#include <dlfcn.h>
#include <errno.h>
#include <iostream>
#include <regex.h>
#include <sys/types.h>
#include "exception.h"
#include "gamelogic.h"
#include "graph.h"
#include "plugins.h"

CPlugins::CPlugins( void )
{
#if DEBUG & 1
	cout << ">CPlugins::CPlugins()" << endl;
#endif

	fPlugins.clear();

#if DEBUG & 1
	cout << "<CPlugins::CPlugins()" << endl;
#endif
}

CPlugins::CPlugins( const string &aDirPath ) :
	fLibHandle( NULL )
{
#if DEBUG & 1
	cout << ">CPlugins::CPlugins( const string & )" << endl;
#endif

	fPlugins.clear();
	ScanDir( aDirPath );

#if DEBUG & 1
	cout << "<CPlugins::CPlugins()" << endl;
#endif
}

CPlugins::~CPlugins( void )
{
#if DEBUG & 1
	cout << ">CPlugins::~CPlugins()" << endl;
#endif

	if (fLibHandle)
	{
		dlclose( fLibHandle );
		fLibHandle = NULL;
	}

#if DEBUG & 1
	cout << "<CPlugins::~CPlugins()" << endl;
#endif
}

const CPlugins::Plugins &
CPlugins::GetPlugins( void ) const
{
	return( fPlugins );
}

void
CPlugins::Load( const string &aPlugin )
{
#if DEBUG & 1
	cout << ">CPlugins::Load()" << endl;
#endif

/* - NSB commented out because IconData became private

	string filename( string( "./" ) + aPlugin + ".so" );
	void *tmpHandle = dlopen( filename.c_str(), RTLD_LAZY );
	if (tmpHandle)
	{
		bool found = false;
		int i;
		char **sym;
		char **tmpIconData[NUM_DEFAULT_ICONS];

		copy_icon_data( defaultIconData, tmpIconData );
		for( i=0; i<NUM_DEFAULT_ICONS; i++ )
		{
#if DEBUG & 2
			cout
				<< "iconDataSymbols[" << i
				<< "]=[" << iconDataSymbols[i] << "]" << endl;
#endif
			sym = static_cast<char **>(dlsym( tmpHandle, iconDataSymbols[i] ));
			if (sym)
			{
				found = true;
				tmpIconData[i] = sym;
			}
		}
		if (!found)
		{
cout << "xxxpropertiesErrorxxx" << endl;
			ThrowEx( "not xlogical plugin" );
		}

		copy_icon_data( tmpIconData, iconData );
		free_pixmaps();
		graphDriver->graph_reload();

		if (fLibHandle)
		{
			(void) dlclose( fLibHandle );
			fLibHandle = NULL;
		}
		fLibHandle = tmpHandle;
	} else {
cout << "xxxpropertiesErrorxxx" << endl;
		ThrowEx( dlerror() );
	}
*/

#if DEBUG & 1
	cout << "<CPlugins::Load()" << endl;
#endif
}

void
CPlugins::ScanDir( const string &aDirPath )
{
#if DEBUG & 1
	cout << ">CPlugins::ScanDir()" << endl;
#endif
	string dirStr( "." );
	DIR *dirHandle = NULL;

	try
	{
		fPlugins.clear();
		if (!aDirPath.empty())
		{
			dirStr = aDirPath;
		}

		dirHandle = opendir( dirStr.c_str() );
		if (!dirHandle)
		{
cout << "xxxpropertiesErrorxxx" << endl;
			ThrowEx(
				string( "unable to open directory '" ) +
				dirStr +
				"':" +
				strerror( errno ) );
		}

		struct dirent *de;
		regex_t reg;
		int err = regcomp( &reg, ".*\\.so$", REG_NOSUB );

		if (err != 0)
		{
cout << "xxxpropertiesErrorxxx" << endl;
			ThrowEx( "unable to compile regular expression" );
		}

		while( (de = readdir( dirHandle ) ) )
		{
			if (regexec( &reg, de->d_name, 0, NULL, 0 ) == 0)
			{
				string s( de->d_name );
				string::size_type i = s.find_last_of( "." );
				s.erase( i );
				fPlugins.push_back( s );
			}
		}
		fPlugins.sort();
		regfree( &reg );

		closedir( dirHandle );
	}
	CatchEx( &ex )
	{
		if (dirHandle)
		{
			closedir( dirHandle );
		}
		throw ex;
	}

#if DEBUG & 1
	cout << "<CPlugins::ScanDir()" << endl;
#endif
}
// $Id: plugins.cpp,v 1.2 2001/02/16 21:00:02 tom Exp $
//
// $Log: plugins.cpp,v $
// Revision 1.2  2001/02/16 21:00:02  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:31  brown
// Working toward Windows integration
//
// Revision 1.2  2000/10/06 19:29:11  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.5  1999/12/25 08:18:39  tom
// Added "Id" and "Log" CVS keywords to source code.
//
