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
#include <cstdio>
#include <cctype>
#include <cstring>
#include <ctime>
#include <iostream>

#ifndef USE_HASH_MAP
#include <map>
#else
#include <hash_map>
#endif

#include <cerrno>

#ifdef WIN32
using namespace std;
#endif

// Application Includes
#include "defs.h"
#include "graph.h"
#include "levelmap.h"

#ifdef FALSE
#undef FALSE
#endif

#define FALSE 0

#ifdef TRUE
#undef TRUE
#endif

#define TRUE 1

//#define DEBUG_FUNC
//#define DEBUG_TOKENS

enum tokens {
	NO_TOKEN = 0,
	STARTBLOCK,
	ENDBLOCK,
	MAP_TIME_LIMIT,
	BALL_SPEED,
	BALL_TIME_LIMIT,
	MAX_MOVING_BALLS,
	RANDOM_ORDER,
	RANDOM_PATTERN,
	PATTERN_TIME,
	MAP,
	YES,
	NO,

	// MAP TILES 
	TELEPORT_UP,				// TPUP
	TELEPORT_DOWN,				// TPDN
	TELEPORT_LEFT,				// TPLT
	TELEPORT_RIGHT,				// TPRT
	TELEPORT_HORIZ,				// TPHH
	TELEPORT_VERT,				// TPVV
	TELEPORT_VERT_LEFT,			// TPVL
	TELEPORT_VERT_RIGHT,		// TPVR
	TELEPORT_HORIZ_UP,			// TPHU
	TELEPORT_HORIZ_DOWN,		// TPHD
	TELEPORT_HORIZ_VERT,		// TPHV

	COLOR_1_BLOCK_HORIZ,		// BL1H
	COLOR_2_BLOCK_HORIZ,		// BL2H
	COLOR_3_BLOCK_HORIZ,		// BL3H
	COLOR_4_BLOCK_HORIZ,		// BL4H
	COLOR_1_BLOCK_VERT,			// BL1V
	COLOR_2_BLOCK_VERT,			// BL2V
	COLOR_3_BLOCK_VERT,			// BL3V
	COLOR_4_BLOCK_VERT,			// BL4V
	COLOR_1_BLOCK_H_V,			// BL1B
	COLOR_2_BLOCK_H_V,			// BL2B
	COLOR_3_BLOCK_H_V,			// BL3B
	COLOR_4_BLOCK_H_V,			// BL4B
	MOVING_BALLS_TILE,			// MOVE
	NEXT_COLOR_DISP,			// NEXT
	ORDER_TILE,					// ORDR
	PATTERN_TILE,				// PATT
	BALL_TIMER_TILE,			// BALL
	START_UP,					// STRU
	START_DOWN,					// STRD
	START_LEFT,					// STRL
	START_RIGHT,				// STRR
	SPINNER_TILE,            	// SPIN
	UNUSED_TILE,            	// BLNK
	LEVEL_TIMER_TILE,			// LEVL
	COLOR_1_PAINT_HORIZ,		// PT1H
	COLOR_2_PAINT_HORIZ,		// PT2H
	COLOR_3_PAINT_HORIZ,		// PT3H
	COLOR_4_PAINT_HORIZ,		// PT4H
	COLOR_1_PAINT_VERT,			// PT1V
	COLOR_2_PAINT_VERT,			// PT2V
	COLOR_3_PAINT_VERT,			// PT3V
	COLOR_4_PAINT_VERT,			// PT4V
	COLOR_1_PAINT_H_V,			// PT1B
	COLOR_2_PAINT_H_V,			// PT2B
	COLOR_3_PAINT_H_V,			// PT3B
	COLOR_4_PAINT_H_V,			// PT4B
	HORIZ_AND_VERT,				// HHVV
	HORIZ_WITH_DOWN,			// HHDD
	HORIZ_WITH_UP,				// HHUU
	VERT_WITH_LEFT,				// VVLL
	VERT_WITH_RIGHT,			// VVRR
	HORIZ,						// HHHH
	VERT,						// VVVV
	END_UP,						// ENDU
	END_DOWN,					// ENDD
	END_LEFT,					// ENDL
	END_RIGHT,					// ENDR

	ONEWAY_UP_UDLR,				// OUHV
	ONEWAY_UP_ULR,				// OUHU
	ONEWAY_UP_UDL,				// OUVL
	ONEWAY_UP_UDR,				// OUVR
	ONEWAY_UP_UL,				// OULU
	ONEWAY_UP_UR,				// OURU
	ONEWAY_UP_UD,				// OUVV
	ONEWAY_UP_END,				// OUND

	ONEWAY_DOWN_UDLR,			// ODHV
	ONEWAY_DOWN_DLR,			// ODHD
	ONEWAY_DOWN_UDL,			// ODVL
	ONEWAY_DOWN_UDR,			// ODVR
	ONEWAY_DOWN_DL,				// ODLD
	ONEWAY_DOWN_DR,				// ODRD
	ONEWAY_DOWN_UD,				// ODVV
	ONEWAY_DOWN_END,			// ODND

	ONEWAY_LEFT_UDLR,			// OLHV
	ONEWAY_LEFT_DLR,			// OLHD
	ONEWAY_LEFT_ULR,			// OLHU
	ONEWAY_LEFT_UDL,			// OLVL
	ONEWAY_LEFT_DL,				// OLLD
	ONEWAY_LEFT_UL,				// OLLU
	ONEWAY_LEFT_LR,				// OLHH
	ONEWAY_LEFT_END,			// OLND

	ONEWAY_RIGHT_UDLR,			// ORHV
	ONEWAY_RIGHT_DLR,			// ORHD
	ONEWAY_RIGHT_ULR,			// ORHU
	ONEWAY_RIGHT_UDR,			// ORVR
	ONEWAY_RIGHT_DR,			// ORRD
	ONEWAY_RIGHT_UR,			// ORRU
	ONEWAY_RIGHT_LR,			// ORHH
	ONEWAY_RIGHT_END,			// ORND

	COVERED_UDLR,				// CHVV
	COVERED_ULR,				// CHUU
	COVERED_DLR,				// CHDD
	COVERED_UDL,				// CVLL
	COVERED_UDR,				// CVRR
	COVERED_DL,					// CDLL
	COVERED_DR,					// CDRR
	COVERED_UL,					// CULL
	COVERED_UR,					// CURR
	COVERED_LR,					// CHHH
	COVERED_UD,					// CVVV
	COVERED_END_UP,				// CNDU
	COVERED_END_DOWN,			// CNDD
	COVERED_END_LEFT,			// CNDL
	COVERED_END_RIGHT,			// CNDR

	// Marker for external tokens
	NUM_EXTERNAL_TOKENS,

	// INTERNAL TOKENS AFTER THIS
	IDENTIFIER,
	INTEGER,
	FLOAT,
	UNKNOWN,

	// End of the tokens
	NUM_TOKENS
};

// Possible text tokens in the map text
char *tokenStrings[] = {
	"notoken",
	"{",
	"}",
	"map_time_limit",
	"ball_speed",
	"ball_time_limit",
	"max_moving_balls",
	"random_order",
	"random_pattern",
	"pattern_time",
	"map",
	"yes",
	"no",
	"tpup",
	"tpdn",
	"tplt",
	"tprt",
	"tphh",
	"tpvv",
	"tpvl",
	"tpvr",
	"tphu",
	"tphd",
	"tphv",
	"bl1h",
	"bl2h",
	"bl3h",
	"bl4h",
	"bl1v",
	"bl2v",
	"bl3v",
	"bl4v",
	"bl1b",
	"bl2b",
	"bl3b",
	"bl4b",
	"move",
	"next",
	"ordr",
	"patt",
	"ball",
	"stru",
	"strd",
	"strl",
	"strr",
	"spin",
	"blnk",
	"levl",
	"pt1h",
	"pt2h",
	"pt3h",
	"pt4h",
	"pt1v",
	"pt2v",
	"pt3v",
	"pt4v",
	"pt1b",
	"pt2b",
	"pt3b",
	"pt4b",
	"hhvv",
	"hhdd",
	"hhuu",
	"vvll",
	"vvrr",
	"hhhh",
	"vvvv",
	"endu",
	"endd",
	"endl",
	"endr",
	"ouhv",
	"ouhu",
	"ouvl",
	"ouvr",
	"oulu",
	"ouru",
	"ouvv",
	"ound",
	"odhv",
	"odhd",
	"odvl",
	"odvr",
	"odld",
	"odrd",
	"odvv",
	"odnd",
	"olhv",
	"olhd",
	"olhu",
	"olvl",
	"olld",
	"ollu",
	"olhh",
	"olnd",
	"orhv",
	"orhd",
	"orhu",
	"orvr",
	"orrd",
	"orru",
	"orhh",
	"ornd",
	"chvv",
	"chuu",
	"chdd",
	"cvll",
	"cvrr",
	"cdll",
	"cdrr",
	"cull",
	"curr",
	"chhh",
	"cvvv",
	"cndu",
	"cndd",
	"cndl",
	"cndr"
};

#define OUT(x)	cerr<<(x)<<endl;
#define MAX_BUFFER_SIZE 1024

// Parsing stuff
int get_next_token(			char ** );
void skip_white(			char ** );
void get_next_word(			char ** );

int current_is_integer(		void );
int current_is_float(		void );
int get_current_token_id(	void );

char *currentSymbol	= new char [ MAX_BUFFER_SIZE ];
long currentInteger	= 0;
double currentFloat	= 0.0;

#ifdef USE_HASH_MAP
struct Token_hash
{
	size_t operator()( const char *key ) const
	{
		size_t res = 0;
		while( *key )
		{
			res = (res << 1) ^ tolower(*key);
			key++;
		}
		return( res );
	}
};
struct Token_eq
{
	bool operator()( const char *p, const char *q ) const
	{
		return( (strcasecmp( p, q ) == 0) );
	}
};

typedef hash_map<char *, int, Token_hash, Token_eq> TokenMap;

#else

struct Token_lt
{
	bool operator()( const char *p, const char *q ) const
	{
		return( (strcasecmp( p, q ) < 0) );
	}
};

typedef map<char *, int, Token_lt> TokenMap;

#endif

TokenMap tokenMap;

Clevel_map::Clevel_map( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::constructor( )" << endl;
#endif
	base_init( );
}

Clevel_map::Clevel_map( char *mapText )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::constructor( )" << endl;
#endif
	base_init( );

	try {
	load_level( mapText );
	} 
	catch( const char *str )
	{
		cerr << "ERROR: " << str << endl;
	}
}

Clevel_map::~Clevel_map( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::destructor( )" << endl;
#endif
}

char *
Clevel_map::load_level( char *inText )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::load_level( )" << endl;
#endif
	char *textPtr = NULL;

	try 
	{
		textPtr = parse_map( inText );
		//post_process_map( );

	} 
	catch( const char *str )
	{
		throw( str );
	}
	return( textPtr );
}

void
Clevel_map::base_init( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::base_init( )" << endl;
#endif
	int i;

	xSize			= 10;
	ySize			= 7;
	tileSize		= 64;
	ballSize		= 16;
	maxBallsInMotion= 5;
	numBallsInMotion= 0;
	nextColor 		= (color_t)(rand( ) % 4 + 1);
	ballTimeLimit	= 60 * kTicksInSecond;
	mapTimeLimit	= 300 * kTicksInSecond;
	ballSpdPct		= 50;
	ballSpd			= BALL_SPEED_MAX * ( (float)ballSpdPct / 100.0 );
	spinnersFinished= 0;
	spinnersOnMap 	= 0;
	startPathActive	= 0;
	patternWaitTime	= 60 * kTicksInSecond;
	nextPatternTime	= 0;
	bgPixmap 		= BMP_BACK_GAME;
	haveMapTimer	= 0;
	haveBallTimer	= 0;
	ballStartTime	= 0;

	// Clear up all the tiles
	tiles.clear( );

	// Initialize some settings
	for( i = 0; i < 4; i++ )
	{
		// Spinner completion pattern matching
		pattern[i] = NO_COLOR;

		// Settings for solid color spinner ordering
		order[i] = NO_COLOR;
	}

	// Clear the random flags
	randPattern		= 0;
	randOrder		= 0;

}

void
Clevel_map::reset( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::reset( )" << endl;
#endif
	vector< Ctile * >::iterator it;
	numBallsInMotion= 0;
	nextColor 		= (color_t)(rand( ) % 4 + 1);
	startTime		= graphDriver->graph_get_time();
	spinnersFinished= 0;
	startPathActive	= 0;
	nextPatternTime	= 0;
	ballStartTime	= 0;

	for( int i = 0; i < 4; i++ )
	{
		pattern[i] = NO_COLOR;
		order[i] = NO_COLOR;
	}

	randPattern		= 0;
	randOrder		= 0;

	for( it = tiles.begin( ); it != tiles.end( ); it++ )
	{
		(*it)->balls.clear();
		if( (*it)->get_type( ) == SPINNER )
		{
			TILE_SPINNER( *it )->finished = 0;
			TILE_SPINNER( *it )->finishing = 0;
			TILE_SPINNER( *it )->finishing_hopper = 0;
			TILE_SPINNER( *it )->moving = 0;
			TILE_SPINNER( *it )->hopper[0] = NULL;
			TILE_SPINNER( *it )->hopper[1] = NULL;
			TILE_SPINNER( *it )->hopper[2] = NULL;
			TILE_SPINNER( *it )->hopper[3] = NULL;
			TILE_SPINNER( *it )->anim_frames.reset_anim( );
		}
	}

	// Do the post processing stuff
	post_process_map( );
}

char *
Clevel_map::parse_map( char *mText )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::parse_map( )" << endl;
#endif
	int done = false;
	int tokenID = 0;
	int haveMap = 0;

	if( get_next_token( &mText ) != IDENTIFIER )
	{
		// We're done
		throw( "Expecting Level Name" );
	} else {
		mapName = new char[ strlen( currentSymbol ) + 1];
		strcpy( mapName, currentSymbol );
	}
	if( get_next_token( &mText ) != STARTBLOCK )
	{
		throw( "Expecting { after LEVEL NAME" );
	}

	while( !done )
	{
		tokenID = get_next_token( &mText );
		switch( tokenID )
		{
		case MAP_TIME_LIMIT:
			if( get_next_token( &mText ) == INTEGER )
			{
				mapTimeLimit = currentInteger * kTicksInSecond;
			} else {
				throw( "Expecting Integer after MAP_TIME_LIMIT" );
			}
			break;
		case BALL_TIME_LIMIT:
			if( get_next_token( &mText ) == INTEGER )
			{
				ballTimeLimit = currentInteger * kTicksInSecond;
			} else {
				throw( "Expecting Integer after BALL_TIME_LIMIT" );
			}
			break;
		case BALL_SPEED:
			if( get_next_token( &mText ) == INTEGER )
			{
				ballSpdPct = currentInteger;
			} else {
				throw( "Expecting Integer after BALL_SPEED" );
			}
			break;
		case MAX_MOVING_BALLS:
			if( get_next_token( &mText ) == INTEGER )
			{
				maxBallsInMotion = currentInteger;
			} else {
				throw( "Expecting Integer after MAX_MOVING_BALLS" );
			}
			break;
		case RANDOM_ORDER:
			if( get_next_token( &mText ) == YES )
			{
				randOrder = 1;
			}
			break;
		case RANDOM_PATTERN:
			if( get_next_token( &mText ) == YES )
			{
				randPattern = 1;
				new_pattern();		// generate a new random pattern
			}
			break;
		case PATTERN_TIME:
			if( get_next_token( &mText ) == INTEGER )
			{
				patternWaitTime = currentInteger * kTicksInSecond;
			} else {
				throw( "Expecting Integer after PATTERN_TIME" );
			}
			break;
		case MAP:
			if( get_next_token( &mText ) == STARTBLOCK )
			{
				try 
				{
					read_map( &mText );
				}
				catch( const char *str )
				{
					throw( str );
				}
				haveMap = 1;
			} else {
				throw( "Expecting { after MAP keyword" );
			}
			break;
		case ENDBLOCK:
			done = true;
			break;
		default:
			cerr << currentSymbol << endl;
			throw( "IDENTIFIER out of place." );
			break;
		}
	}

	// Skip trailing whitespace so we start fresh next time
	skip_white( &mText );

	if( haveMap )
	{
		// Return the position we left off at
		return( mText );
	} else {
		throw( "INCOMPLETE LEVEL" );
	}
}

void 
Clevel_map::read_ball_colors( char **mText )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::read_ball_colors( )" << endl;
#endif
}

void 
Clevel_map::read_color_block( char **mText, color_t *tColors, int count )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::read_color_block( )" << endl;
#endif
}

void
Clevel_map::read_map( char **mText )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::read_map( )" << endl;
#endif

	Ctile *tempTile;

	int done = false;
	int tokenID = 0;
	int index = 0;
	int haveStart = 0;

	while( !done )
	{
		skip_white( mText );
		tokenID = get_next_token( mText );
		switch( tokenID )
		{
		case TELEPORT_UP:
			tempTile = new Ctile_teleport( EXIT_UP );
			break;
		case TELEPORT_DOWN:
			tempTile = new Ctile_teleport( EXIT_DOWN );
			break;
		case TELEPORT_LEFT:
			tempTile = new Ctile_teleport( EXIT_LEFT );
			break;
		case TELEPORT_RIGHT:
			tempTile = new Ctile_teleport( EXIT_RIGHT );
			break;
		case TELEPORT_HORIZ:
			tempTile = new Ctile_teleport( EXIT_LEFT | EXIT_RIGHT );
			break;
		case TELEPORT_VERT:
			tempTile = new Ctile_teleport( EXIT_UP | EXIT_DOWN );
			break;
		case TELEPORT_VERT_LEFT:
			tempTile = new Ctile_teleport( EXIT_UP | EXIT_DOWN | EXIT_LEFT);
			break;
		case TELEPORT_VERT_RIGHT:
			tempTile = new Ctile_teleport( EXIT_UP | EXIT_DOWN | EXIT_RIGHT);
			break;
		case TELEPORT_HORIZ_UP:
			tempTile = new Ctile_teleport( EXIT_UP | EXIT_LEFT |  EXIT_RIGHT);
			break;
		case TELEPORT_HORIZ_DOWN:
			tempTile = new Ctile_teleport( EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT);
			break;
		case TELEPORT_HORIZ_VERT:
			tempTile = new Ctile_teleport( EXIT_UP | EXIT_DOWN | EXIT_LEFT 
															| EXIT_RIGHT);
			break;
		case COLOR_1_BLOCK_HORIZ:
			tempTile = new Ctile_blocker( C1, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_2_BLOCK_HORIZ:
			tempTile = new Ctile_blocker( C2, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_3_BLOCK_HORIZ:
			tempTile = new Ctile_blocker( C3, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_4_BLOCK_HORIZ:
			tempTile = new Ctile_blocker( C4, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_1_BLOCK_VERT:
			tempTile = new Ctile_blocker( C1, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_2_BLOCK_VERT:
			tempTile = new Ctile_blocker( C2, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_3_BLOCK_VERT:
			tempTile = new Ctile_blocker( C3, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_4_BLOCK_VERT:
			tempTile = new Ctile_blocker( C4, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_1_BLOCK_H_V:
			tempTile = new Ctile_blocker( C1, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
			EXIT_RIGHT );
			break;
		case COLOR_2_BLOCK_H_V:
			tempTile = new Ctile_blocker( C2, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
			EXIT_RIGHT );
			break;
		case COLOR_3_BLOCK_H_V:
			tempTile = new Ctile_blocker( C3, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
			EXIT_RIGHT );
			break;
		case COLOR_4_BLOCK_H_V:
			tempTile = new Ctile_blocker( C4, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
			EXIT_RIGHT );
			break;
		case MOVING_BALLS_TILE:
			tempTile = new Ctile_moving( );
			break;
		case NEXT_COLOR_DISP:
			tempTile = new Ctile_next;
			break;
		case ORDER_TILE:
			tempTile = new Ctile_order;
			break;
		case PATTERN_TILE:
			tempTile = new Ctile_pattern;
			break;
		case START_UP:
			if( !haveStart )
			{
				tempTile = new Ctile_start( EXIT_UP );
				startTile = tiles.size( );
				haveStart = 1;
			} else {
				throw( "Cannot have more than one start square in map" );
			}
			break;
		case START_DOWN:
			if( !haveStart )
			{
				tempTile = new Ctile_start( EXIT_DOWN );
				startTile = tiles.size( );
				haveStart = 1;
			} else {
				throw( "Cannot have more than one start square in map" );
			}
			break;
		case START_LEFT:
			if( !haveStart )
			{
				tempTile = new Ctile_start( EXIT_LEFT );
				startTile = tiles.size( );
				haveStart = 1;
			} else {
				throw( "Cannot have more than one start square in map" );
			}
			break;
		case START_RIGHT:
			if( !haveStart )
			{
				tempTile = new Ctile_start( EXIT_RIGHT );
				startTile = tiles.size( );
				haveStart = 1;
			} else {
				throw( "Cannot have more than one start square in map" );
			}
			break;
		case SPINNER_TILE:
			tempTile = new Ctile_spinner;
			spinnersOnMap++;
			break;
		case UNUSED_TILE:
			tempTile = new Ctile_blank;
			break;
		case LEVEL_TIMER_TILE:
			tempTile = new Ctile_timer;
			break;
		case COLOR_1_PAINT_HORIZ:
			tempTile = new Ctile_painter( C1, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_2_PAINT_HORIZ:
			tempTile = new Ctile_painter( C2, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_3_PAINT_HORIZ:
			tempTile = new Ctile_painter( C3, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_4_PAINT_HORIZ:
			tempTile = new Ctile_painter( C4, EXIT_LEFT | EXIT_RIGHT );
			break;
		case COLOR_1_PAINT_VERT:
			tempTile = new Ctile_painter( C1, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_2_PAINT_VERT:
			tempTile = new Ctile_painter( C2, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_3_PAINT_VERT:
			tempTile = new Ctile_painter( C3, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_4_PAINT_VERT:
			tempTile = new Ctile_painter( C4, EXIT_UP | EXIT_DOWN );
			break;
		case COLOR_1_PAINT_H_V:
			tempTile = new Ctile_painter( C1, EXIT_UP | EXIT_DOWN | EXIT_LEFT
			| EXIT_RIGHT );
			break;
		case COLOR_2_PAINT_H_V:
			tempTile = new Ctile_painter( C2, EXIT_UP | EXIT_DOWN | EXIT_LEFT
			| EXIT_RIGHT );
			break;
		case COLOR_3_PAINT_H_V:
			tempTile = new Ctile_painter( C3, EXIT_UP | EXIT_DOWN | EXIT_LEFT
			| EXIT_RIGHT );
			break;
		case COLOR_4_PAINT_H_V:
			tempTile = new Ctile_painter( C4, EXIT_UP | EXIT_DOWN | EXIT_LEFT
			| EXIT_RIGHT );
			break;
		case HORIZ_AND_VERT:
			tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN | EXIT_LEFT
														| EXIT_RIGHT );
			break;
		case HORIZ_WITH_DOWN:
			tempTile = new Ctile_track( EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT );
			break;
		case HORIZ_WITH_UP:
			tempTile = new Ctile_track( EXIT_UP | EXIT_LEFT| EXIT_RIGHT );
			break;
		case VERT_WITH_LEFT:
			tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN | EXIT_LEFT );
			break;
		case VERT_WITH_RIGHT:
			tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN | EXIT_RIGHT );
			break;
		case HORIZ:
			tempTile = new Ctile_track( EXIT_LEFT| EXIT_RIGHT );
			break;
		case VERT:
			tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN );
			break;
		case END_UP:
			tempTile = new Ctile_track( EXIT_UP );
			break;
		case END_DOWN:
			tempTile = new Ctile_track( EXIT_DOWN );
			break;
		case END_LEFT:
			tempTile = new Ctile_track( EXIT_LEFT );
			break;
		case END_RIGHT:
			tempTile = new Ctile_track( EXIT_RIGHT );
			break;
		case ONEWAY_UP_UDLR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT 
												| EXIT_RIGHT, UP );
		case ONEWAY_UP_ULR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT | EXIT_RIGHT, UP );
			break;
		case ONEWAY_UP_UDL:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT, UP );
			break;
		case ONEWAY_UP_UDR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_RIGHT, UP );
			break;
		case ONEWAY_UP_UL:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT, UP );
			break;
		case ONEWAY_UP_UR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_RIGHT, UP );
			break;
		case ONEWAY_UP_UD:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN, UP );
			break;
		case ONEWAY_UP_END:
			tempTile = new Ctile_oneway( EXIT_UP, UP );
			break;
		case ONEWAY_DOWN_UDLR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT 
													| EXIT_RIGHT, DOWN );
			break;
		case ONEWAY_DOWN_DLR:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT 
													| EXIT_RIGHT, DOWN );
			break;
		case ONEWAY_DOWN_UDL:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN 
													| EXIT_LEFT, DOWN );
			break;
		case ONEWAY_DOWN_UDR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN 
													| EXIT_RIGHT, DOWN );
			break;
		case ONEWAY_DOWN_DL:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT, DOWN );
			break;
		case ONEWAY_DOWN_DR:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_RIGHT, DOWN );
			break;
		case ONEWAY_DOWN_UD:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN, DOWN );
			break;
		case ONEWAY_DOWN_END:
			tempTile = new Ctile_oneway( EXIT_DOWN, DOWN );
			break;
		case ONEWAY_LEFT_UDLR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT 
												| EXIT_RIGHT, LEFT );
			break;
		case ONEWAY_LEFT_DLR:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT 
												| EXIT_RIGHT, LEFT );
			break;
		case ONEWAY_LEFT_ULR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT 
												| EXIT_RIGHT, LEFT );
			break;
		case ONEWAY_LEFT_UDL:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN 
												| EXIT_LEFT , LEFT );
			break;
		case ONEWAY_LEFT_DL:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT , LEFT );
			break;
		case ONEWAY_LEFT_UL:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT , LEFT );
			break;
		case ONEWAY_LEFT_LR:
			tempTile = new Ctile_oneway( EXIT_LEFT | EXIT_RIGHT, LEFT );
			break;
		case ONEWAY_LEFT_END:
			tempTile = new Ctile_oneway( EXIT_LEFT, LEFT );
			break;
		case ONEWAY_RIGHT_UDLR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT 
												| EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_DLR:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT 
												| EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_ULR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT 
												| EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_UDR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN 
												| EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_DR:
			tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_UR:
			tempTile = new Ctile_oneway( EXIT_UP | EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_LR:
			tempTile = new Ctile_oneway( EXIT_LEFT | EXIT_RIGHT, RIGHT );
			break;
		case ONEWAY_RIGHT_END:
			tempTile = new Ctile_oneway( EXIT_RIGHT, RIGHT );
			break;
		case COVERED_UDLR:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN | EXIT_LEFT
														| EXIT_RIGHT );
			break;
		case COVERED_ULR:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_LEFT | EXIT_RIGHT );
			break;
		case COVERED_DLR:
			tempTile = new Ctile_covered( EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT );
			break;
		case COVERED_UDL:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN | EXIT_LEFT );
			break;
		case COVERED_UDR:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN | EXIT_RIGHT );
			break;
		case COVERED_DL:
			tempTile = new Ctile_covered( EXIT_DOWN | EXIT_LEFT );
			break;
		case COVERED_DR:
			tempTile = new Ctile_covered( EXIT_DOWN | EXIT_RIGHT );
			break;
		case COVERED_UL:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_LEFT );
			break;
		case COVERED_UR:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_RIGHT );
			break;
		case COVERED_LR:
			tempTile = new Ctile_covered( EXIT_LEFT | EXIT_RIGHT );
			break;
		case COVERED_UD:
			tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN );
			break;
		case COVERED_END_UP:
			tempTile = new Ctile_covered( EXIT_UP );
			break;
		case COVERED_END_DOWN:
			tempTile = new Ctile_covered( EXIT_DOWN );
			break;
		case COVERED_END_LEFT:
			tempTile = new Ctile_covered( EXIT_LEFT );
			break;
		case COVERED_END_RIGHT:
			tempTile = new Ctile_covered( EXIT_RIGHT );
			break;
		case ENDBLOCK:
			done = TRUE;
			break;
		default:
			done = TRUE;
			cerr << "[" << currentSymbol << "]" << endl;
			throw( "Unknown Map tile!" );
			break;
		}
		if( !done )
		{
			// Set the index
			tempTile->indexPos = index++;

			// Add the new tile to our list
			tiles.insert( tiles.end( ), tempTile );

		} else {
			if( index < xSize * ySize )
			{
				throw( "Not enough map tiles!!" );
			}
		}
	}
}

void 
skip_white( char **cPtr )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::skip_white( )" << endl;
#endif
	while ( isspace( **cPtr ) )
	{
//cerr <<"Skipping: [" << (int)**cPtr<< "]" << endl;
		*cPtr = *cPtr + 1;
	}
}

int 
get_next_token( char **cPtr )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::get_next_token( )" << endl;
#endif
	int retVal = IDENTIFIER;

	skip_white( cPtr );

	get_next_word( cPtr );

	// Is it an integer?
	if( current_is_integer( ) )
	{
		retVal = INTEGER;
	} else {
		// Is it a float?
		if( current_is_float( ) )
		{
			retVal = FLOAT;
		} else {
			retVal = get_current_token_id( );
		}
	}

	// Can't have a zero-length identifier
	if( (retVal == IDENTIFIER)
		&& ( strlen( currentSymbol ) == 0 ) )
	{
		retVal = UNKNOWN;
	}

#ifdef DEBUG_TOKENS
cerr << "Read in [" << currentSymbol << "]" << endl;
cerr << "Current Symbol: [" << currentSymbol << "]" << endl;
cerr << "Current Integer: " << currentInteger << "" << endl;
cerr << "Current Float: " << currentFloat << "" << endl;
#endif

	return( retVal );
}

void
get_next_word( char **tokenStr )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::get_next_word( )" << endl;
#endif
	int counter = 0;
	bool inQuote = false;

	while( (**tokenStr != '\0') &&
		   (counter < MAX_BUFFER_SIZE) &&
		   (inQuote || !isspace( **tokenStr )) )
	{
		if (**tokenStr == '\"')
		{
			if (!inQuote)
			{
				inQuote = true;
				(*tokenStr)++;
				continue;
			} else {
				(*tokenStr)++;
				break;
			}
		}

		currentSymbol[counter] = **tokenStr;
		(*tokenStr)++;
		counter++;
	}

	// Tack on our null
	currentSymbol[counter] = '\0';
}

int
current_is_integer( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::current_is_integer( )" << endl;
#endif
	int retVal = TRUE;
	unsigned long i = 0;

	// Check for a sign
	if( ( currentSymbol[i] == '+' )
			|| ( currentSymbol[i] == '-' )
			|| ( isdigit( currentSymbol[i] ) ) )
	{
		for( i=1; i < strlen( currentSymbol ); i ++ )
		{
			if( !isdigit( currentSymbol[i] ) )
			{
				retVal = FALSE;
			}
		}
	} else {
		retVal = FALSE;
	}
	if( retVal )
	{
		currentInteger = strtol( currentSymbol, NULL, 10 );
	}
	return( retVal );
}

int
current_is_float( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::current_is_float( )" << endl;
#endif
	int retVal = FALSE;

	if( (currentFloat = strtod( currentSymbol, NULL )) )
	{
		retVal = TRUE;
	}
	return( retVal );
}

int
get_current_token_id( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::get_current_token_id( )" << endl;
#endif
	int id = IDENTIFIER;
	TokenMap::iterator iter;
	static int start = 1;

	// Build the token hash the first time 'round
	if( start )
	{
		start = 0;

		// Build the hash map
		tokenMap.clear();
#ifdef USE_HASH_MAP
		tokenMap.resize( static_cast<int>(NUM_EXTERNAL_TOKENS * 1.5) );
#endif
		for( int i = 0; i < NUM_EXTERNAL_TOKENS; i ++ )
		{
			tokenMap[tokenStrings[i]] = i;
		}
	}

#ifdef DEBUG_TOKENS
	cerr << "Searching for: [" << currentSymbol << "]" << endl;
#endif

	iter = tokenMap.find( currentSymbol );
	if( iter != tokenMap.end( ) )
	{
		id = iter->second;
	} else {
		id = IDENTIFIER;
	}

#ifdef DEBUG_TOKENS
	cerr << "FOUND: " << id << endl;
#endif

	return( id );
}

void
Clevel_map::post_process_map( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::post_process_map( )" << endl;
#endif
	vector< Ctile * >::iterator it;
	int idx = 0;
	int row;
	int col;

	for( it = tiles.begin( ); it != tiles.end( ); it++, idx++ )
	{
		// Get the row/col we're on
		row = idx / xSize;
		col = idx % xSize;
		switch( (*it)->get_type( ) ) 
		{
		case SPINNER:
			// Check UP
			if( idx - xSize >= 0 )
			{
				if( (tiles[idx - xSize]->exitFlags & EXIT_DOWN)
				|| (tiles[idx - xSize]->get_type( ) == SPINNER) )
				{
					(*it)->exitFlags |= EXIT_UP;
				}
			}
			// Check Down
			if( idx + xSize < xSize * ySize - 1 )
			{
				if( (tiles[idx + xSize]->exitFlags & EXIT_UP)
				|| (tiles[idx + xSize]->get_type( ) == SPINNER) )
				{
					(*it)->exitFlags |= EXIT_DOWN;
				}
			}
			// Check Left
			if( idx - 1 >= 0 )
			{
				if( (tiles[idx - 1]->exitFlags & EXIT_RIGHT)
				|| (tiles[idx - 1]->get_type( ) == SPINNER) )
				{
					(*it)->exitFlags |= EXIT_LEFT;
				}
			}
			// Check right
			if( idx + 1 < xSize * ySize - 1 )
			{
				if( (tiles[idx + 1]->exitFlags & EXIT_LEFT)
				|| (tiles[idx + 1]->get_type( ) == SPINNER) )
				{
					(*it)->exitFlags |= EXIT_RIGHT;
				}
			}
			break;
		case TIME_DISP:
			haveMapTimer = 1;
			break;
		case BALL_TIMER:
			haveBallTimer = 1;
			break;
		case TRACK:
			break;
		case PATTERN_DISP:
			// Set a default pattern
			spinnerPattern[0] = (color_t)(rand( )%4 + 1);
			spinnerPattern[1] = (color_t)(rand( )%4 + 1);
			spinnerPattern[2] = (color_t)(rand( )%4 + 1);
			spinnerPattern[3] = (color_t)(rand( )%4 + 1);
			new_pattern( );
			break;
		case ORDER_DISP:
			// Set some default order if we don't have any
			if( order[0] == NO_COLOR )
			{
				order[0] = (color_t)(rand( )%4 + 1);
				order[1] = (color_t)(rand( )%4 + 1);
				order[2] = (color_t)(rand( )%4 + 1);
			}
			break;
		default:
			break;
		}
	}
}

void
Clevel_map::new_pattern( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::new_pattern( )" << endl;
#endif
	if ( randPattern == 1 )
	{
		// calculate new random pattern
		pattern[0] = (color_t)(rand( )%4 + 1);
		pattern[1] = (color_t)(rand( )%4 + 1);
		pattern[2] = (color_t)(rand( )%4 + 1);
		pattern[3] = (color_t)(rand( )%4 + 1);
	} else {
		// restore old pattern
		pattern[0] = spinnerPattern[0];
		pattern[1] = spinnerPattern[1];
		pattern[2] = spinnerPattern[2];
		pattern[3] = spinnerPattern[3];
	}
}

Ctile_teleport *
Clevel_map::find_teleport_with_dir( Ctile_teleport *t, dir_t dir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Clevel_map::find_teleport_with_dir( )" << endl;
#endif

	// Dir is the direction we'd LEAVE the teleporter from...
	vector< Ctile *>::iterator it;
	it = tiles.begin( );
	while( it != tiles.end( ) )
	{
		if( ((*it)->get_type( ) == TELEPORT )
			&& ( TILE_TELEPORT( *it ) != t ) )
		{
			switch( dir )
			{
			case UP:
				if( (*it)->exitFlags & EXIT_UP )
				{
					return( TILE_TELEPORT( *it ) );
				}
				break;
			case DOWN:
				if( (*it)->exitFlags & EXIT_DOWN )
				{
					return( TILE_TELEPORT( *it ) );
				}
				break;
			case LEFT:
				if( (*it)->exitFlags & EXIT_LEFT )
				{
					return( TILE_TELEPORT( *it ) );
				}
				break;
			case RIGHT:
				if( (*it)->exitFlags & EXIT_RIGHT )
				{
					return( TILE_TELEPORT( *it ) );
				}
				break;
			default:
				break;
			}
		}
		it++;
	}
	cout << "MATCHING TELEPORT NOT FOUND! ACK!" << endl;
	return( NULL );
}

// $Id: levelmap.cpp,v 1.3 2001/07/31 20:54:54 tom Exp $
//
// $Log: levelmap.cpp,v $
// Revision 1.3  2001/07/31 20:54:54  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.2  2001/02/16 20:59:55  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:28  brown
// Working toward Windows integration
//
// Revision 1.9  2000/10/09 03:21:37  tom
// fixed resetting of order and pattern tiles
//
// Revision 1.8  2000/10/08 05:29:44  tom
// reset spinner vars that were carried over between games
//
// Revision 1.7  2000/10/08 02:53:48  brown
// Fixed the level editor and some graphics
//
// Revision 1.6  2000/10/07 19:26:21  brown
// Added BALL_SPEED_PCT to the parser
// Fixed debug info output
//
// Revision 1.5  2000/10/07 19:12:18  brown
// Speed-throttling code completed
//
// Revision 1.4  2000/10/07 18:16:34  brown
// Ball movement fixes
//
// Revision 1.2  2000/10/06 19:29:06  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.44  2000/07/23 16:50:28  brown
// Fixed level timer changing while paused
// Added "finish spinner" animation
// Fixed level ending before last spinner finished ( sortof )
//
// Revision 1.43  2000/02/13 07:16:37  tom
// - changed level names to include spaces
// - made it so that player cannot advance intermission screens until bonus
//   is finished being moved to the player's score
//
// Revision 1.42  2000/02/13 06:27:18  tom
// Fixed new ball timer bug and high score update bug.
//
// Revision 1.41  2000/02/13 03:44:50  brown
// Start tile changes, as well as some font scroll changes
//
// Revision 1.40  2000/02/12 21:07:08  brown
//
// Bunch of new backgrounds
//
// Revision 1.39  2000/02/12 20:39:48  tom
// whoops... accidentally checked in stuff without finishing my comment the
// last time. Anyway, fixed up music transition between game states.
//
// Revision 1.38  2000/02/12 20:38:34  tom
// Fixed up
//
// Revision 1.37  2000/01/10 02:53:48  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.36  2000/01/09 02:26:16  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.35  2000/01/02 01:30:36  tom
// fixed hash table lookup of tokens
//
// Revision 1.34  2000/01/01 22:44:25  tom
// Added a user defined comparison routine for the hash map. Commented out all
// the hash map code and put back linear search code for tokens... but it still
// cores.
//
// Revision 1.33  2000/01/01 21:51:19  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.32  1999/12/28 08:54:51  tom
// Fixed level maps to work with new teleporters.
//
// Revision 1.31  1999/12/27 03:38:00  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.30  1999/12/25 08:18:34  tom
// Added "Id" and "Log" CVS keywords to source code.
//
