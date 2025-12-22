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

// Language Includes
#include<iostream>
#include<fstream>
#include<cstdio>
#include<cctype>

#ifndef WIN32
#include<unistd.h>
#ifndef USE_GETLOGIN
#include <pwd.h>
#endif
#endif

// Application Includes
#include "gamelogic.h"
#include "properties.h"

//#define DEBUG_FUNC
//#define DEBUG 2

void
Cgame::reset_hiscores( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Cgame::reset_hiscores( )" << endl;
#endif
	for( int i=0; i < NUM_HI_SCORES; i++ )
	{
		hiscores[i].name = "nobody";
		hiscores[i].score = 1000 - 100*i;
	}

	return;
}

bool
Cgame::is_hiscore()
{
	return( score > hiscores[NUM_HI_SCORES-1].score );
}

void
Cgame::update_hiscores( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Cgame::update_hiscores( )" << endl;
#endif
	
	// Did we make the high score list?
	if( score <= hiscores[NUM_HI_SCORES-1].score )
	{
		// Nope
		return;
	}

	// We're obviously at least in last place
	// so make room!
	hiscores[NUM_HI_SCORES-1].name = "";
	hiscores[NUM_HI_SCORES-1].score = 0;

	// Find where we are in the list?
	for( int i=NUM_HI_SCORES-2; i >= 0; i-- )
	{
		// Are we greater than this score?
		if( score > hiscores[i].score )
		{
			// Yes, bubble the next one down and move on
			hiscores[i+1].name = hiscores[i].name;
			hiscores[i+1].score = hiscores[i].score;
		} else {
			// No, we should pop ourselves below this one
			hiscores[i+1].name = playerName;
			hiscores[i+1].score = score;

			return;
		}
	}

	// Looks like we're at the top
	hiscores[0].name = playerName;
	hiscores[0].score = score;

	return;
}

void
Cgame::read_hiscores( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Cgame::read_hiscores( )" << endl;
#endif
	// in editor mode, we don't need a hiscore file
	if (properties::instance().get( "game.mode" ) == "editor")
	{
		return;
	}

	ifstream ifs(
		properties::instance().get( "hiscore.file" ).c_str(), ios::in );
	char tmpbuff[128];

	if( ifs.bad( ) )
	{
		cerr
			<< "ERROR Opening hi-score file '"
			<< properties::instance().get( "hiscore.file" ).c_str()
			<< "'" << endl;

		for( int i=0; i < NUM_HI_SCORES; i++ )
		{
			hiscores[i].name = "nobody";
			hiscores[i].score = 1000 - 100*i;
		}

		return;
	}

	for( int i=0; i < NUM_HI_SCORES; i++ )
	{

		ifs >> tmpbuff;

		if( ifs.bad( ) || ifs.eof( ) )
		{
			cerr << "ERROR Reading hi-score file" << endl;

			for( ; i < NUM_HI_SCORES; i++ )
			{
				hiscores[i].name = "nobody";
				hiscores[i].score = 1000 - 100*i;
			}
			return;
		}

		hiscores[i].name = tmpbuff;

		ifs >> hiscores[i].score;

		if( ifs.bad( ) || ifs.eof( ) )
		{
			cerr << "ERROR Reading hi-score file" << endl;
			for( ; i < NUM_HI_SCORES; i++ )
			{
				hiscores[i].name = "NOBODY";
				hiscores[i].score = 1000 - 100*i;
			}
			return;
		}

#if DEBUG & 2
		cerr << "name: " << hiscores[i].name.c_str();
		cerr << "    score: " << hiscores[i].score << endl;
#endif
	}
	ifs.close();
}

void
Cgame::write_hiscores( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Cgame::write_hiscores( )" << endl;
#endif
	// in editor mode, we don't need a hiscore file
	if (properties::instance().get( "game.mode" ) == "editor")
	{
		return;
	}

	ofstream ofs(
		properties::instance().get( "hiscore.file" ).c_str(),
		ios::out|ios::trunc );

	// Open our output stream
	if( !ofs )
	{
		cerr << "ERROR!  Could not open hi-score file." << endl;
		return;
	}

	for( int i=0; i < NUM_HI_SCORES; i++ )
	{
		ofs << hiscores[i].name.c_str() << " " << hiscores[i].score << endl;

		if( ofs.bad( ) )
		{
			cerr << "ERROR!  Could not write to hi-score file." << endl;
			ofs.close();
			return;
		}
	}
	ofs.close();
}

Clevel_map *
load_a_level( char *levelText )
{
#if DEBUG & 1
	cerr << __FILE__ << " : load_a_level( )" << endl;
#endif
	class Clevel_map *tMap;
	char *tempPointer = NULL;

	tMap = new Clevel_map;

	try{
		tempPointer = tMap->load_level( levelText );

	}
	catch ( const char *str )
	{
		cerr << "ERROR: " << str << endl;
		tMap = NULL;
	}

	return( tMap );
}

char *
encrypt( char *amap, char *user )
{
#if DEBUG & 1
	cerr << __FILE__ << " : encrypt( )" << endl;
#endif
	char	*crypt	= NULL;
	char	*p0		= NULL;
	char	*p1		= NULL;
	int		c0		= 0;
	int		c1		= 0;
	int		i		= 0;
	long	nums[5];

	for( i = 0; i < 5; i++ )
	{
		nums[i] = 0;
	}

	crypt = new char[6];

	p0 = amap;
	c0 = 0;
	p1 = user;
	c1 = 4;

	while( *p0 != '\0' )
	{
		if( *p0 != '\0' )
		{
			nums[c0++] += (int)*p0 * *p1;
			if( c0 > 4 )
			{
				c0 = 0;
			}
			p0++;
		}
		nums[c1--] += (int)*p1 * 13849;
		if( c1 < 0 )
		{
			c1 = 4;
		}
		p1++;
		if( *p1 == '\0' )
		{
			p1 = user;
		}
	}

	for( i = 0; i < 5; i++ )
	{
		crypt[i] = (char)((nums[i]%26) + 65 );
	}
	crypt[5] = '\0';

	return( crypt );
}

char *
get_next_builtin_map( char *in )
{
#if DEBUG & 1
	cerr << __FILE__ << " : get_next_builtin_map( )" << endl;
#endif

	int brace = 0;
	int done = 0;
	int skipping = 1;
	char *buff1 = new char[1025];
	int count = 0;

	while( (*in != '\0') && !done )
	{
		// grab the next char
		buff1[count++] = *in;

		// Skip until we see the first open brace
		if( skipping )
		{
			if( *in == '{' )
			{
				skipping = 0;
				brace++;
			}
			in++;
		} else {
			switch( *in )
			{
			case '{':
				brace++;
				in++;
				break;
			case '}':
				brace--;
				if( ! brace )
				{
					done = 1;
					buff1[count] = '\0';
				} else {
					in++;
				}
				break;
			default:
				in++;
				break;
			}
		}
		// See if we're blowing out the buffer
		if( count == 1024 )
		{
			cerr << "DATA TOO BIG" << endl;
			delete [] buff1;
			return( NULL );
		}
	}

	// We didn't find another opening brace
	if( skipping == 1 )
	{
		delete [] buff1;
		buff1 = NULL;
	}

	return( buff1 );
}

char *
get_next_file_map( void )
{
#if DEBUG & 1
	cerr << __FILE__ << " : get_next_file_map( )" << endl;
#endif

	int brace = 0;
	int done = 0;
	int skipping = 1;
	char *buff1 = new char[1025];
	int count = 0;

	// State variables for reentry
	static int first = 1;
	static ifstream *ifs;

	// Only do this the first time
	if( first )
	{
		// Open the file
		ifs = new ifstream( currentGame->levelFile, ios::in );
		if( ifs->bad( ) )
		{
			cerr << "ERROR Opening Map file" << endl;
			return( NULL );
		}
		first = 0;
	}

	// Loop until we're done or we find the end
	while( (! ifs->eof( ) ) && ( ! done ) )
	{
		// Grab the next byte from the file
		ifs->get( buff1[count] );

		// Skip at first until we see the first open brace
		if( skipping )
		{
			if( buff1[count] == '{' )
			{
				brace++;
				skipping = 0;
			}
		} else {
			switch( buff1[count] )
			{
			case '{':
				brace++;
				break;
			case '}':
				brace--;
				if( !brace )
				{
					buff1[++count] = '\0';
					done = 1;
				}
				break;
			}
		}
		// See if we're blowing out the buffer
		if( count++ == 1024 )
		{
			cerr << "DATA TOO BIG" << endl;
			delete [] buff1;
		}
	}

	// We didn't find another opening brace
	if( (skipping == 1)  || (ifs->eof( ) ))
	{
		delete [] buff1;
		buff1 = NULL;
	}

	return( buff1 );
}

dir_t
exit_to_dir( unsigned long exits )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : exit_to_dir( )" << endl;
#endif
	if( exits & EXIT_UP )
	{
		return( UP );
	}
	if( exits & EXIT_DOWN )
	{
		return( DOWN );
	}
	if( exits & EXIT_LEFT )
	{
		return( LEFT );
	}
	if( exits & EXIT_RIGHT )
	{
		return( RIGHT );
	}

	// Return the default
	return( STOPPED );
}

long
get_cksum( char *str )
{
	char *p;
	long ck = 0;
	int flip = 0;
	p = str;
	while( *p != '\0' )
	{
		ck += (flip++%2)?(*(p++)<<2):(*(p++)<<3);
	}
#if DEBUG & 2
	cerr << "Mod Checksum: " << ck << endl;
#endif
	return( ck );
}


