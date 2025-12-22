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

#ifdef __MORPHOS__
#include <machine/types.h>
#endif

#include <iostream>
#include <fstream>

#ifdef WIN32
#include <afxwin.h>
#include <cstdlib>
#include <ctime>
#include <direct.h>
#else
#include <dirent.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#endif

#include "exception.h"
#include "modlist.h"
#include "music_files.h"
#include "properties.h"

using namespace std;

//#define DEBUG 2

bool gIsInGameFile	= false;

Cmodlist* 			Cmodlist::fGlobalList		= NULL;
Cmodlist::iterator	Cmodlist::fCurrent;
#ifdef WIN32
const char			Cmodlist::kPathSeparator[]	= ";";
#else
const char			Cmodlist::kPathSeparator[]	= ":";
#endif

Cmodlist::Cmodlist()
{
	if (fGlobalList)
	{
cout << "xxxmodlistErrorxxx" << endl;
		ThrowEx( "modlist already initialized" );
	}
	fGlobalList = this;
}

Cmodlist::~Cmodlist()
{
	if (fGlobalList == this)
	{
		fGlobalList = NULL;
	}
	clear();
}

void
Cmodlist::init()
{
#if DEBUG & 2
	cout << "Cmodlist::init() entered" << endl;
#endif

	// clear our music lists
	clear();

	// figure out if we should load a list of file names or not
	string inGame;
	try
	{
		inGame = properties::instance().get( "music.ingame.paths" );
	}
	catch( CXLException& e )
	{
		// only play the default in game music
		gIsInGameFile = true;
		return;
	}

	// parse mod paths out of input parameter
	path_list_t l;
	parse_paths( inGame, l );

	// loop through finding mods in the mod paths
#ifdef WIN32
	CFileFind finder;
	for( path_list_t::iterator iter=l.begin(); iter != l.end(); ++iter )
	{
#if DEBUG & 2
		cout << "looking in dir [" << (*iter).c_str() << "]" << endl;
#endif
		string findPattern( (*iter) );
		findPattern += PATHSEP;
		findPattern += "*.*";
		bool more = finder.FindFile( findPattern.c_str() );
#if DEBUG & 2
		cout << "findPattern=[" << findPattern.c_str() << "]" << endl;
#endif
		if (!more)
		{
			cerr << "unable to find mod files in '" << (*iter) << "'" << endl;
		}
		while( more )
		{
			more = finder.FindNextFile();

			if (!finder.IsDirectory())
			{
				// build full path to music file
				string filePath = finder.GetFilePath();
#if DEBUG & 2
				cout
					<< "adding mod ["
					<< filePath.c_str() << "] to user list" << endl;
#endif
				push_back( filePath );
			}
		}
		finder.Close();
	}
#else
	DIR *dirStream = NULL;
	string filePath;
	struct dirent * dirEntry = NULL;
	struct stat s;
	for( path_list_t::iterator iter=l.begin(); iter != l.end(); ++iter )
	{
		dirStream = opendir( (*iter).c_str() );
		if (!dirStream)
		{
cout << "xxxmodlistErrorxxx" << endl;
			ThrowEx(
				string( "unable to open dir '" ) +
				(*iter) +
				string( "'" ) );
		}

		while( (dirEntry = readdir( dirStream ) ) )
		{
			// skip current and parent dir entries
			if ((strcmp( dirEntry->d_name, "." )!=0) && 
				(strcmp( dirEntry->d_name, "..")!=0))
			{

				// build full path to music file
				filePath = (*iter);
				filePath += PATHSEP;
				filePath += dirEntry->d_name;

				// make sure file is a regular file
				if ((stat( filePath.c_str(), &s ) == 0) &&
					(S_ISREG(s.st_mode)))
				{
#if DEBUG & 2
					cout
						<< "adding mod ["
						<< filePath << "] to user list" << endl;
#endif
					push_back( filePath );
				}
			}
		}
		closedir( dirStream );
	}
#endif
	fCurrent = begin();
	if (empty())
	{
		gIsInGameFile = true;
	} else {
		gIsInGameFile = false;
	}
}

void
Cmodlist::randomize()
{
	if (size() > 1)
	{
		file_list_base_t tmpList;

#ifdef WIN32
		// for now this is as good as it gets in WIN32
		srand( time( NULL ) );
#else
#ifdef __MORPHOS__
	srand(time(NULL));
#else

		// this is a bit more random than the WIN32 approach
		struct timeval tv;
		gettimeofday( &tv, NULL );
		srandom( tv.tv_sec + tv.tv_usec );
#endif
#endif

		tmpList.swap( *this );
		for( file_list_base_t::iterator iter=tmpList.begin();
			  iter!=tmpList.end();
			  iter=tmpList.begin() )
		{
			string s;
#ifdef WIN32
			int n = rand() % tmpList.size();
#else
#ifdef __MORPHOS__
			int n = rand() % tmpList.size();
#else
			int n = random() % tmpList.size();
#endif
#endif

			for(int i=0;i<n;i+=1)
			{
				++iter;
			}
			s = *iter;
			tmpList.remove( *iter );
			push_back( s );
		}
	}
}

Cmodlist&
Cmodlist::instance()
{
	if (!fGlobalList)
	{
cout << "xxxmodlistErrorxxx" << endl;
		ThrowEx( "modlist not initialized" );
	}
	return( *fGlobalList );
}

void
Cmodlist::parse_paths( const string& aDirPaths, path_list_t& aOutputPaths )
{
	bool done = false;
	string paths( aDirPaths );
	string::size_type i;

	aOutputPaths.clear();
	while( !done )
	{
		i = paths.find( kPathSeparator );
		if ((i != string::npos) && (i > 0))
		{
			string s( paths, 0, i );
			aOutputPaths.push_back( s );
			paths.erase( 0, i+1 );
		} else {
			if (paths.size() > 0)
			{
				aOutputPaths.push_back( paths );
			}
			done = true;
		}
	}
}

string
Cmodlist::next()
{
	if (gIsInGameFile || empty())
	{
		return( musicFiles[MUSIC_IN_GAME] );
	}
	if (size() > 1)
	{
		++fCurrent;
		if (fCurrent == end())
		{
			fCurrent = begin();
		}
	} else {
		fCurrent = begin();
	}
	return( *fCurrent );
}

string
Cmodlist::previous()
{
	if (gIsInGameFile || empty())
	{
		return( musicFiles[MUSIC_IN_GAME] );
	}
	if (size() > 1)
	{
		if (fCurrent == begin())
		{
			fCurrent = end();
			--fCurrent;
		} else {
			--fCurrent;
		}
	} else {
		fCurrent = begin();
	}
	return( *fCurrent );
}

