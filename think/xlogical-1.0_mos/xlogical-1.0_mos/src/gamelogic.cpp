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
#include "audio.h"
#include "gamelogic.h"
#include "graph.h"
#include "globals.h"
#include "ball.h"
#include "menus.h"
#include "modlist.h"
#include "music_files.h"
#include "text.h"
#include "maps.h"
#include "properties.h"
#include "sound_files.h"

#include "gpl.h"

//#define DEBUG_FUNC
//#define DEBUG 2
//#define SHOW_FPS

// Optimization of draws
#define REFRESH_INTERVAL 50

// Rate for blinking items on the screen
#define BLINK_RATE 5

// How many frames to skip before
// we check for a new mod to update
// the text
#define MOD_UPDATE_SKIP 50

// We'll scroll once every SCROLL_FREQ frames
#define SCROLL_FREQ 1

// Space for text at the top
#define TOP_OFFSET 50

// For end credits scrolling
#define CREDITS_SCROLL_BASE 95
#define CREDITS_SCROLL_SKIP 1
#define CREDITS_SCROLL_HEIGHT 330
#define CREDITS_SCROLL_SPACING 5

// For end credits scrolling
#define LICENSE_SCROLL_BASE 340
#define LICENSE_SCROLL_SKIP 1
#define LICENSE_SCROLL_HEIGHT 75
#define LICENSE_SCROLL_SPACING 1

// bonus life stuff
const ulong	kBonusLifeScoreStep	= 10000;		// bonus life every this often
ulong			gNextBonusLifeScore	= kBonusLifeScoreStep;

// state of startup
static bool		gEnteringHiScore	= false;
static int      gNamePos	= 0;
static int		gTitleState = PRE_LOADING;
static long		kBonusStep	= 20L;
static bool		gFullRefreshNeeded	= false;

// To count the time we're in a menu so we don't lose it
// from our timers
ulong gMenuEntryTime = 0;

// To save the time left when a level is over
ulong spareTime = 0;

// For the screen text stuffs
int scrFontWidths[] = {
	12, 9, 18, 13, 10, 17, // %
	17, 8, 13, 14, 13, 15,
	11, 18, 7, 29, // /
	22, 8, 16, 15, 16, 17, // 5
	17, 13, 17, 16, 8, 9, 13, 18, // =
	14, 18, 19, 18, 17, 21, // C
	19, 14, 14, 22, 14, 9, // I
	11, 15, 14, 22, 19, 21, 17, 22, // Q
	18, 16, 17, 15, 18, 21, // W
	17, 13, 14, 14, 28, 15 };

// Some Local functions
void			draw_help(				void );
void			draw_score(				void );
void			scroll_info(			void );
void			scroll_mod_info(		void );
void			refresh_scroll_info(	void );

// in game music list
Cmodlist	gModList;
bool		gInGame = false;

// Class instances to scroll some text
CText modScroller;
CText infoScroller;
CText scrFont;

void
check_bonus_life()
{
	while (currentGame->score > gNextBonusLifeScore)
	{
		currentGame->livesLeft += 1;
		gNextBonusLifeScore += kBonusLifeScoreStep;
		audioDriver->play_sound( soundFiles[SOUND_BONUS_LIFE] );
	}
}

Cgame::Cgame( const char *fn )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Cgame::constructor( )" << endl;
#endif

	// Did we have a level filename?
	if (fn)
	{
		levelFile = strdup( fn );
	} else {
		levelFile = NULL;
	}

	currentMap = NULL;

	playerName = new char[32+1];
	strcpy( playerName, "nobody" );

#ifdef WIN32
	encryptName = new char[32+1];
	strcpy( encryptName, "nobody" );
#else
	encryptName = new char[L_cuserid+1];
#ifdef USE_GETLOGIN
	char *login = getlogin();
	if (login)
	{
		strcpy( encryptName, getlogin( ) );
	} else {
		strcpy( encryptName, "nobody" );
	}

#else
	struct passwd *p = getpwuid( geteuid() );
	if (p)
	{
		strcpy( encryptName, p->pw_name );
	} else {
		strcpy( encryptName, "nobody" );
	}
#endif
#endif

	// Set the initial state
	gameState = MAP_START;

	gNextBonusLifeScore = kBonusLifeScoreStep;
	score = 0;
	bonus = 0;
	livesLeft = 3;

	modScroller.set_bounds( 32, 256, 40 );
	modScroller.set_string( " " );

	infoScroller.set_bounds( 384, 607, 40 );
	infoScroller.set_string( " " );
	read_hiscores( );

	scrFont.set_font_info( BMP_FONT_3, scrFontWidths, 26, 2, ' ', '`' );
	infoScroller.set_string( " " );
}


Cgame::~Cgame( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Cgame::destructor( )" << endl;
#endif
	write_hiscores( );
	delete [] playerName;
	delete [] encryptName;
}


void
Cgame::reset_game( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Cgame::reset_game( )" << endl;
#endif
	gNextBonusLifeScore = kBonusLifeScoreStep;
	score = 0;
	bonus = 0;
	livesLeft = 3;
	warningPlayed = false;
}

void
add_new_ball( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : add_new_ball( )" << endl;
#endif
	dir_t dir = UP;
	Cball *b = NULL;
#if 0
	static int done = 0;
	if( done > 4 )
	{
		return;
	}
#endif

	// Check to see if there's a ball on the current path
	if( CURMAP->startPathActive )
	{
		return;
	}

	// Check to see if we're at max moving balls
	if( ! CURMAP->can_move_ball( ) )
	{
		return;
	}

	// Get our new ball class
	b = new Cball;

	CURMAP->ballStartTime = graphDriver->graph_get_time();

	// Assign color to new ball
	b->set_color( CURMAP->nextColor );
	switch( CURMAP->nextColor )
	{
	default:
	case C1:
		b->set_pixmap_num( BMP_BALL_C1 );
		break;
	case C2:
		b->set_pixmap_num( BMP_BALL_C2 );
		break;
	case C3:
		b->set_pixmap_num( BMP_BALL_C3 );
		break;
	case C4:
		b->set_pixmap_num( BMP_BALL_C4 );
		break;
	}

	// Choose the next color for the map
	CURMAP->nextColor = (color_t)(rand( ) % 4 + 1);

	switch( CURMAP->tiles[ CURMAP->startTile]->exitFlags )
	{
	case EXIT_UP:
		dir = UP;
		break;
	case EXIT_DOWN:
		dir = DOWN;
		break;
	case EXIT_LEFT:
		dir = LEFT;
		break;
	case EXIT_RIGHT:
		dir = RIGHT;
		break;
	default:
		break;
	}

	CURMAP->startPathActive = 1;
	CURMAP->tiles[ CURMAP->startTile ]->add_ball( b, dir, 0 );
	b->doMidPoint = false;	// special case for start track

   audioDriver->play_sound( soundFiles[SOUND_NEW_BALL] );

	// Add a new moving ball
	CURMAP->move_ball( );
#if 0
	done++;
#endif
}

void 
setup_new_map( void )
{
	int row;
	int col;
	int index = 0;

	// Clear the background buffer
	graphDriver->graph_clear_rect_perm( 0, 0, 
			graphDriver->graph_main_width( ), 
			graphDriver->graph_main_height( ) );

	// Fake it out in case the background is the same
	graphDriver->graph_set_background( BMP_SPINDARK );

	// Now draw the real background
	graphDriver->graph_set_background( CURMAP->bgPixmap );

	// Draw the bases for everything
	for( row = 0; row < CURMAP->ySize; row++ )
	{
		for( col = 0; col < CURMAP->xSize; col++ )
		{
			CURMAP->tiles[index]->draw_under( 
				col * CURMAP->tileSize, 
				row * CURMAP->tileSize + TOP_OFFSET );
			index++;
		}
	}
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
// PLAY STATE FUNCTIONS
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void
play_click_func( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : play_click_func( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif

	int row;
	int col;
	int relX, relY;
	int index;

	// Find our row and column
	row = (y - TOP_OFFSET) / CURMAP->tileSize;
	col = x / CURMAP->tileSize;

	// Get the click position relative to the tile origin
	relX = x % CURMAP->tileSize;
	relY = (y - TOP_OFFSET) % CURMAP->tileSize;

	// If we're outside the map area, bail
	if( relY < 0 )
	{
		return;
	}

	// Get the vector index for our tile
	index = row * CURMAP->xSize + col;

	// Call that tile's click function
	CURMAP->tiles[index]->click_func( relX, relY, button );
}

void
play_loop_func( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : play_loop_func( )" << endl;
#endif
	int status = 1;
	int ret = 0;
	ulong timeNow = graphDriver->graph_get_time();
	vector< Ctile * >::iterator it;
	int finishedSpinner = 1;
	static int scroll_update = 0;

	if (gFullRefreshNeeded)
	{
		graphDriver->graph_set_background( BMP_SPINDARK );
		graphDriver->graph_set_background( BMP_BACK_GAME );

		full_refresh();
		graphDriver->graph_refresh();

		gFullRefreshNeeded = false;
	}

#ifdef SHOW_FPS
	static ulong timestamp = 0;
	static int framecounter = 0;

	if( timeNow - timestamp > 0 )
	{
		char fps[10];
		sprintf( fps, "%d FPS", framecounter );
		graphDriver->graph_clear_rect( 10, 490, 50, 10 );
		modScroller.render_string( fps, 10, 490 );
		framecounter = 0;
		timestamp = timeNow;
	} else {
		framecounter++;
	}
#endif

	// Adjust timers to account for the time that was spent in
	// menus
	if (gMenuEntryTime > 0)
	{
		CURMAP->startTime += timeNow - gMenuEntryTime;
		CURMAP->ballStartTime += timeNow - gMenuEntryTime;
		if (CURMAP->nextPatternTime > 0)
		{
			CURMAP->nextPatternTime += timeNow - gMenuEntryTime;
		}
		gMenuEntryTime = 0;
	}

	// Check to see if we need to update the pattern
	if ((CURMAP->nextPatternTime != 0) &&
		(CURMAP->nextPatternTime < timeNow))
	{
		CURMAP->nextPatternTime = 0;
		CURMAP->new_pattern();
		audioDriver->play_sound( soundFiles[SOUND_NEW_PATTERN] );
	}

	// If we're just waiting for the last spinner to finish, we can do
	// a slimmed-down loop
	if( currentGame->gameState == FINISH_WAIT )
	{
		// Loop over the map tiles and do our stuff.
		for( it = CURMAP->tiles.begin( ); it != CURMAP->tiles.end( ); it++ )
		{
			if( (*it)->get_type( ) != BLANK_TILE )
			{
				// Update Animations
				(*it)->anim_loop( );

				// Move the balls we have to
				(*it)->move_balls( );
			}

			// Check for unfinished ( "finishing" ) spinners
			if( (*it)->get_type( ) == SPINNER )
			{
				if( ! TILE_SPINNER( *it )->check_complete( ) )
				{
					ret ++;
				}
			}

		}

		// Were there no unfinished spinners left?
		if( ret == CURMAP->spinnersOnMap )
		{
			// Nope - we can move on
			currentGame->gameState = MAP_COMPLETE;
			switch_to_intermission();
			audioDriver->play_sound( soundFiles[SOUND_FINISH_LEVEL] );
		}

		play_draw_map( );

		// Refresh the display
		//graphDriver->graph_refresh( );

		return;
	}

	// Loop over the map tiles and do our stuff.
	for( it = CURMAP->tiles.begin( ); it != CURMAP->tiles.end( ); it++ )
	{
		if( (*it)->get_type( ) != BLANK_TILE )
		{
			// Update Animations
			(*it)->anim_loop( );

			// Move the balls we have to
			(*it)->move_balls( );
		}
	}

	// Loop while spinners are still "finishing"
	while( status > 0 )
	{
		// Reset our status
		status = 0;

		for( it = CURMAP->tiles.begin( ); it != CURMAP->tiles.end( ); it++ )
		{
			if( (*it)->get_type( ) == SPINNER )
			{
				ret = TILE_SPINNER( *it )->check_complete( );

				switch( ret )
				{
				case FILL_SOLID:
					currentGame->score = currentGame->score + 
									(SOLID_POINTS * finishedSpinner);
					break;
				case FILL_ORDER:
					currentGame->score += ORDER_POINTS * finishedSpinner;
					break;
				case FILL_PATTERN:
					currentGame->score += PATTERN_POINTS * finishedSpinner;
					break;
				case FILL_COMPLETED:
					currentGame->score += SOLID_POINTS / 10;
					break;
				default:
					break;
				}
			}

			// We finished a spinner - refresh everything
			if( ret )
			{
				finishedSpinner++;
			}
				
			status += ret;
			ret = 0;

			// TBD - here's where we check for combos
		}
	}
	check_bonus_life();

	// Did we complete all the spinners on the map?
	if( CURMAP->spinnersFinished == CURMAP->spinnersOnMap )
	{
		currentGame->gameState = FINISH_WAIT;

		if (gMenuEntryTime != 0)
		{
			spareTime = CURMAP->startTime + CURMAP->mapTimeLimit 
					- timeNow + (timeNow - gMenuEntryTime);
		} else {
			spareTime = CURMAP->startTime + CURMAP->mapTimeLimit 
					- timeNow;
		}

		// Add our spare time to the bonus
		if (CURMAP->haveMapTimer)
		{
			currentGame->bonus += spareTime / kTicksInSecond;
		} else {
			currentGame->bonus = 0;
		}

		return;
	}

	// Check to see if we're over ball time for the start path.
	// We only need to check this if the start path is active
	if( CURMAP->startPathActive && (CURMAP->ballStartTime > 0) )
	{
		if( CURMAP->ballStartTime + CURMAP->ballTimeLimit <= timeNow )
		{
			CURMAP->reset( );
			currentGame->gameState = BALL_TIMEOUT;
			currentGame->livesLeft -= 1;

			switch_to_intermission();

			return;
		}
	}

	// Check to see if we're over map time
	if( CURMAP->haveMapTimer )
	{
		long timeLeft = CURMAP->startTime + CURMAP->mapTimeLimit - timeNow;
		if( CURMAP->startTime + CURMAP->mapTimeLimit <= timeNow )
		{
			CURMAP->reset( );
			currentGame->gameState = MAP_TIMEOUT;
			currentGame->livesLeft -= 1;

			switch_to_intermission();
			return;
		} else
		if ((timeLeft <= 60*(long)kTicksInSecond) &&
			!currentGame->warningPlayed)
		{
			audioDriver->play_sound( soundFiles[SOUND_TIME_WARNING] );
			currentGame->warningPlayed = true;
		}
	}

	// Add a new ball if it looks like we need one
	add_new_ball( );

	// Redraw the map
	play_draw_map( );

	// Do some scrolly stuff
	if( scroll_update++ % SCROLL_FREQ == 0 )
	{
		// Clear the scroll area
		graphDriver->graph_clear_rect(
			0, 40, graphDriver->graph_main_width(), 10 );

		// Draw the scroll boundaries
		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 0, 0, 0, 40, 32, 10, 0 );
		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 0, 0, 256, 40, 128, 10, 0 );
		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 0, 0, 607, 40, 32, 10, 0 );

		scroll_mod_info( );
		scroll_info( );
	}

	// print out our score
	draw_score( );
}

void
play_key_press_func( keysyms keyval )
{
#if DEBUG & 1
	cerr << __FILE__ << " : play_key_press_func( keyval=" << (int)keyval << " )" << endl;
#endif

	switch( keyval )
	{
		case eEsc:

			// Clear the game board for the menu
			graphDriver->graph_clear_rect( 
				0, 
				0, 
				graphDriver->graph_main_width( ), 
				graphDriver->graph_main_height( ) );

			gMenuEntryTime = graphDriver->graph_get_time();
			get_game_menu()->Start(
				graphDriver->graph_main_width(),
				graphDriver->graph_main_height(),
				full_refresh,
				switch_to_playing_no_music_change );
			break;
#ifdef DEBUG
		case eN:
				currentGame->currentMap++;
				CURMAP->reset( );
				setup_new_map( );
				full_refresh( );
			break;
#endif
		case eRight:
		case eDown:
			// switch music to next song in user list
			audioDriver->play_music( gModList.next().c_str() );
			break;
		case eLeft:
		case eUp:
			// switch music to previous song in user list
			audioDriver->play_music( gModList.previous().c_str() );
			break;
#ifdef DEBUG
		case eQ:
			exit( 0 );
			break;
#endif
		default:
			break;
	}
}


void 
play_draw_map( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : play_draw_map( )" << endl;
#endif

	ulong timeUsed;
	ulong checkTime;
	float newSpeed;
	static ulong savedTime = 0;
	int row;
	int col;
	int index = 0;

	// Now loop through the Clevel_map object and draw the balls
	index = 0;
	for( row = 0; row < CURMAP->ySize; row++ )
	{
		for( col = 0; col < CURMAP->xSize; col++ )
		{
			if( ! CURMAP->tiles[index]->balls.empty( ) )
			{
				CURMAP->tiles[index]->draw_balls( 
					col * CURMAP->tileSize, 
					row * CURMAP->tileSize + TOP_OFFSET );
			}
			index++;
		}
	}

	// Refresh the correct tiles
	index = 0;
	for( row = 0; row < CURMAP->ySize; row++ )
	{
		for( col = 0; col < CURMAP->xSize; col++ )
		{
			// Check to see if we should draw this tile
			switch( CURMAP->tiles[index]->get_type( ) )
			{
			case PAINTER:
			case BLOCKER:
			case SPINNER:
			case PATTERN_DISP:
			case ORDER_DISP:
			case TELEPORT:
			case ONEWAY:
			case NEXT_DISP:
			case MOVE_COUNTER:
			case BALL_TIMER:
			case TIME_DISP:
			case START:
				CURMAP->tiles[index]->draw_over( 
					col * CURMAP->tileSize, 
					row * CURMAP->tileSize + TOP_OFFSET );
				break;
			default:
				break;
			}
			index++;
		}
	}

	// speed throttling code
	checkTime = graphDriver->graph_get_time( );
	if( checkTime < savedTime )
	{
		// we wrapped around the 1 second mark
		timeUsed = (1000 - savedTime) + checkTime;
	} else {
		timeUsed = checkTime - savedTime;
	}

	newSpeed = BALL_SPEED_MAX * ((float)CURMAP->ballSpdPct / 100.0 ) *
		((float)timeUsed / (float)REFRESH_INTERVAL );
	if( (newSpeed < BALL_SPEED_MAX) && (newSpeed > 0) )
	{
		CURMAP->ballSpd = newSpeed;
	}
	savedTime = checkTime;
}	

void
reload_func( void )
{
	gFullRefreshNeeded = true;
}

void 
full_refresh( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : full_refresh( )" << endl;
#endif
	int row;
	int col;
	int index = 0;

	// Paint the background onto the screen
	graphDriver->graph_refresh( );

	// Now loop through the Clevel_map object and draw the balls
	index = 0;
	// Draw the bases for everything
	for( row = 0; row < CURMAP->ySize; row++ )
	{
		for( col = 0; col < CURMAP->xSize; col++ )
		{
			CURMAP->tiles[index]->draw_under( 
				col * CURMAP->tileSize, 
				row * CURMAP->tileSize + TOP_OFFSET );
			index++;
		}
	}

	index = 0;
	for( row = 0; row < CURMAP->ySize; row++ )
	{
		for( col = 0; col < CURMAP->xSize; col++ )
		{
			if( CURMAP->tiles[index]->get_type( ) 
				!= BLANK_TILE )
			{
				CURMAP->tiles[index]->draw_balls( 
					col * CURMAP->tileSize, 
					row * CURMAP->tileSize + TOP_OFFSET );
			}
			index++;
		}
	}

	// Now loop through the Clevel_map object and draw anything
	// that goes on top of balls
	index = 0;
	for( row = 0; row < CURMAP->ySize; row++ )
	{
		for( col = 0; col < CURMAP->xSize; col++ )
		{
			if( CURMAP->tiles[index]->get_type( ) 
				!= BLANK_TILE )
			{
				CURMAP->tiles[index]->draw_over( 
					col * CURMAP->tileSize, 
					row * CURMAP->tileSize + TOP_OFFSET );
			}
			index++;
		}
	}
}	


//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
// START STATE FUNCTIONS
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

void
start_click_func( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : start_click_func( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif
	if (gTitleState > POST_LOADING)
	{
		get_main_menu()->Start(
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height(),
			start_draw_map,
			switch_to_intro_no_music_change );
	}
}


void
start_loop_func( void )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " : start_loop_func( )" << endl;
#endif

	static char *maps = NULL;
	class Clevel_map *tMap;
	char *singleMap;
	int i;

	switch( gTitleState )
	{
	case PRE_LOADING:
	{
		// Set the background image
		graphDriver->graph_set_background( BMP_TITLE_TEXT_4 );

		// Draw main title
		graphDriver->graph_draw_perm( BMP_TITLE_TEXT_1, 0, 0, 50, 100, 0, 0 );
		graphDriver->graph_erase_rect( 
				0,0, 
				graphDriver->graph_main_width( ), 
				graphDriver->graph_main_height( ) );

		// Draw things once
		start_draw_map( );

		// Draw "loading" text
		graphDriver->graph_draw( BMP_TITLE_TEXT_3, 80, 210 );

		// Clear the text area
		graphDriver->graph_clear_rect( 90, 290, 470, 70 );

		if( (currentGame->levelFile != NULL)  
			&& (strlen( currentGame->levelFile) > 0) )
		{
#if DEBUG & 2
			cerr << currentGame->levelFile << endl;
#endif
			gTitleState = LOADING_FILE;
		} else {
			gTitleState = LOADING_BUILTIN;
			maps = maptext;
		}
		break;
	}
	case LOADING_BUILTIN:
	case LOADING_FILE:
	{
		static bool userMusicLoaded = false;
		if (!userMusicLoaded)
		{
			init_in_game_music();
			userMusicLoaded = true;
		}
		if( gTitleState == LOADING_BUILTIN )
		{
			// grab the next map
			singleMap = get_next_builtin_map( maps );

			if( singleMap != NULL )
			{
				// Move the counter forward
				maps += strlen( singleMap );
			}
		} else {
			// Grab the next map from the file
			singleMap = get_next_file_map( );
		}

		// Load the map if we got one
		if( singleMap != NULL )
		{
			// Load up the level
			tMap = load_a_level( singleMap );

			// Free up our space 
			delete [] singleMap;

			// If we got a valid map in, add it
			if( tMap != NULL )
			{
#if DEBUG & 2
				cerr	<< "Level: " << tMap->mapName;
				cerr	<< "\t\t" << currentGame->playerName;
				cerr	<< " = "
						<< encrypt( tMap->mapName, currentGame->encryptName )
						<< endl;
#endif
				// Insert the level into the level list
				gameLevels.insert( gameLevels.end( ), tMap );

				// This is a little hackish - may get changed when we do the
				// "GAME OVER" stuff
				// point our CURMAP stuff so set_start_path( ) works
				currentGame->currentMap = gameLevels.end( );
				currentGame->currentMap--;

				// This has to happen after currentMap is assigned.
				// This is due to the use of CURMAP everywhere.
				// Bad design I guess.  Won't make that mistake again...
				// ( Yeah right...)
				tMap->tiles[tMap->startTile]->set_start_path(
					exit_to_dir( CURMAP->tiles[tMap->startTile]->exitFlags ) );
			} else {
				// We're done loading
				gTitleState = POST_LOADING;
			}

			// Move the lines up
			for( i = 0; i < 4; i++ )
			{
				graphDriver->graph_copy_area( 
					100, 					// SRC_ULX
					300 + i * 10 + 10, 		// SRC_ULY
					100, 					// DST_ULX
					300 + i * 10, 			// DST_ULY
					450, 					// WIDTH
					10 ); 					// HEIGHT
			}

			// Clear the bottom line
			graphDriver->graph_clear_rect( 100, 340, 450, 10 );

			// Render the map name
			modScroller.render_string( tMap->mapName, 100, 340 );

		} else {
			// Out of map text
			gTitleState = POST_LOADING;
		}

		break;
	}
	case POST_LOADING:
	{
		// No more levels to load
		// If we added at least one level, reset the levels to the start.
		if( gameLevels.size( ) > 0 )
		{
			// Set our first level and get on with it
			currentGame->currentMap = gameLevels.begin( );
		} else {
			// No point in playing if we didn't get any levels
			cerr << "ERROR: No valid levels!" << endl;
			clean_exit( 1 );
		}
		graphDriver->graph_set_key_press_func( start_key_press_func );

		// Go to the "end"
		gTitleState = 999;

		graphDriver->graph_draw_perm( BMP_TITLE_TEXT_2, 0, 0, 50, 300, 0, 0 );
		break;
	}
	default:
	{
		graphDriver->graph_erase_rect( 0, 0, 600, 500 ); 
		graphDriver->graph_erase_rect( 
				0,0, 
				graphDriver->graph_main_width( ),
				graphDriver->graph_main_height( ) );

		break;
	}
	}
}

void 
start_draw_map( void )
{
#if DEBUG & 1
	cerr << __FILE__ << " : start_draw_map( )" << endl;
#endif
}

void
start_key_press_func( keysyms keyval )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : start_key_press_func( keyval=" << (int)keyval << " )" << endl;
#endif
	switch( keyval )
	{
#ifdef DEBUG
		case eQ:
			exit( 0 );
			break;
#endif
		case eEsc:
			get_main_menu()->Start(
				graphDriver->graph_main_width(),
				graphDriver->graph_main_height(),
				start_draw_map,
				switch_to_intro_no_music_change );
			break;
		default:
			break;
	}
}

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
// INTERMISSION STATE FUNCTIONS
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

void
intermission_click_func( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : intermission_click_func( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif
	// Refresh the info scroller
	refresh_scroll_info( );

	switch( currentGame->gameState )
	{
	case MAP_COMPLETE:
		if (currentGame->bonus == 0)
		{
			// Pop to the next level
			currentGame->currentMap++;

			// Is there a next level?
			if( currentGame->currentMap == gameLevels.end( ) )
			{
				// Set our state
				currentGame->gameState = WON;

				if (currentGame->is_hiscore())
				{
					gEnteringHiScore = true;
					gNamePos = 0;
					*(currentGame->playerName) = 0;
				}

				// Clear the screen to black
				graphDriver->graph_clear_rect(
					0, 0,
					graphDriver->graph_main_width(),
					graphDriver->graph_main_height() );

				// End the game 
				currentGame->livesLeft = -1;

				// Reset the maps
				currentGame->currentMap = gameLevels.begin( );

				audioDriver->play_music( musicFiles[MUSIC_WON_GAME] );
				break;
			}
			CURMAP->reset();
			currentGame->gameState = MAP_START;
		}
		break;
	case GAME_OVER:
		// Put us back at the beginning
		if (!gEnteringHiScore)
		{
			CURMAP->reset( );
			currentGame->currentMap = gameLevels.begin( );
			CURMAP->reset( );

			switch_to_high_scores();
		}

		break;
	case HIGH_SCORES:
		switch_to_intro();
		get_main_menu()->Start(
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height(),
			start_draw_map,
			switch_to_intro_no_music_change );
		break;
	case HELP_MAIN:
	case ABOUT:
		switch_to_intro_no_music_change();
		get_main_menu()->Start(
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height(),
			start_draw_map,
			switch_to_intro_no_music_change );
		break;
	case HELP_GAME:
		switch_to_playing_no_music_change();
		get_game_menu()->Start(
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height(),
			start_draw_map,
			switch_to_playing_no_music_change );
		break;
	case WON:
		if (!gEnteringHiScore)
		{
			// Reset the levels and update the high score table
			CURMAP->reset( );
			currentGame->currentMap = gameLevels.begin( );
			currentGame->reset_game( );
			switch_to_high_scores();
		}
		break;
	default:
		if (currentGame->livesLeft <= 0)
		{
			switch_to_game_over();
		} else {
			// Reset the current map
			CURMAP->reset( );

			setup_new_map( );

			// Restore the play loop stuff
			switch_to_playing();

			full_refresh();

			// Maybe need a switch
			currentGame->gameState = PLAYING;
		}
		break;
	}
}

void
intermission_loop_func( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : intermission_loop_func( )" << endl;
#endif

	// Now redraw the map
	intermission_draw_screen( );
}

void
intermission_key_press_func( keysyms keyval )
{
#if DEBUG & 1
	cerr << __FILE__ << " : intermission_key_press_func( keyval=" << (int)keyval << " )" << endl;
#endif

	switch( keyval )
	{
#ifdef DEBUG
		case eQ:
			exit( 0 );
			break;
#endif
		case eEsc:
			switch( currentGame->gameState )
			{
			case GAME_OVER:
				if (!gEnteringHiScore)
				{
					// Put us back at the beginning
					CURMAP->reset( );
					currentGame->currentMap = gameLevels.begin( );
					CURMAP->reset( );

					switch_to_high_scores();
				}
				break;
			case HIGH_SCORES:
				switch_to_intro();
				get_main_menu()->Start(
					graphDriver->graph_main_width(),
					graphDriver->graph_main_height(),
					start_draw_map,
					switch_to_intro_no_music_change );
				break;
			case ABOUT:
				switch_to_intro_no_music_change();
				get_main_menu()->Start(
					graphDriver->graph_main_width(),
					graphDriver->graph_main_height(),
					start_draw_map,
					switch_to_intro_no_music_change );
				break;
			case WON:
				if (!gEnteringHiScore)
				{
					// Reset the levels and update the high score table
					CURMAP->reset( );
					currentGame->currentMap = gameLevels.begin( );
					currentGame->reset_game( );
					switch_to_high_scores();
				}
				break;
			default:
				if ((currentGame->gameState != MAP_COMPLETE) ||
					(currentGame->bonus == 0))
				{
					get_intermission_menu()->Start(
						graphDriver->graph_main_width(),
						graphDriver->graph_main_height(),
						intermission_draw_screen,
						switch_to_intermission_no_music_change );
				}
				break;
			}
			break;
		case eSpace:

			// Refresh the info scroller
			refresh_scroll_info( );

			switch( currentGame->gameState )
			{
			case MAP_COMPLETE:
				if (currentGame->bonus == 0)
				{
					// Pop to the next level
					currentGame->currentMap++;

					// Is there a next level?
					if( currentGame->currentMap == gameLevels.end( ) )
					{
						// Set our state
						currentGame->gameState = WON;

						// Clear the screen to black
						graphDriver->graph_clear_rect(
							0, 0,
							graphDriver->graph_main_width(),
							graphDriver->graph_main_height() );

						// End the game 
						currentGame->livesLeft = -1;

						// Reset the maps
						currentGame->currentMap = gameLevels.begin( );

						audioDriver->play_music( musicFiles[MUSIC_WON_GAME] );
						break;
					}

					// Reset the current map
					CURMAP->reset( );

					// Maybe need a switch
					currentGame->gameState = MAP_START;
				}
				break;
			case GAME_OVER:
				if (!gEnteringHiScore)
				{
					// Put us back at the beginning
					CURMAP->reset( );
					currentGame->currentMap = gameLevels.begin( );
					CURMAP->reset( );

					switch_to_high_scores();
				}

				break;
			case HIGH_SCORES:
				switch_to_intro();
				get_main_menu()->Start(
					graphDriver->graph_main_width(),
					graphDriver->graph_main_height(),
					start_draw_map,
					switch_to_intro_no_music_change );
				break;
			case HELP_MAIN:
			case ABOUT:
				switch_to_intro_no_music_change();
				get_main_menu()->Start(
					graphDriver->graph_main_width(),
					graphDriver->graph_main_height(),
					start_draw_map,
					switch_to_intro_no_music_change );
				break;
			case HELP_GAME:
				switch_to_playing_no_music_change();
				get_game_menu()->Start(
					graphDriver->graph_main_width(),
					graphDriver->graph_main_height(),
					start_draw_map,
					switch_to_playing_no_music_change );
				break;
			case WON:
				if (!gEnteringHiScore)
				{
					// Reset the levels and update the high score table
					CURMAP->reset( );
					currentGame->currentMap = gameLevels.begin( );
					currentGame->reset_game( );
					switch_to_high_scores();
				}
				break;
			default:
				if (currentGame->livesLeft <= 0)
				{
					CURMAP->reset( );
					switch_to_game_over();
				} else {
					// Reset the current map
					CURMAP->reset( );

					// May not need this
					setup_new_map( );

					// Restore the play loop stuff
					switch_to_playing();

					// Draw the current map
					full_refresh( );

					// Maybe need a switch
					currentGame->gameState = PLAYING;
				}
				break;
			}
			break;
		case eBackSpace:
			if (gEnteringHiScore)
			{
				gNamePos -= 1;
				if (gNamePos < 0)
				{
					gNamePos = 0;
				}
				currentGame->playerName[gNamePos] = 0;
			}
			break;
		case eEnter:
			if (gEnteringHiScore)
			{
				currentGame->update_hiscores();
				gEnteringHiScore = false;
			}
		default:
			if (gEnteringHiScore && (keyval >= eA) && (keyval <= eZ))
			{
				if (gNamePos < 10)
				{
					currentGame->playerName[gNamePos] = keysym_to_char( keyval );
					gNamePos += 1;
					currentGame->playerName[gNamePos] = 0;
				}
			}
			break;
	}
}

void 
intermission_draw_screen( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : intermission_draw_screen( )" << endl;
#endif
	char cstr[50];

	static int switchFlag = 0;
	static int blinker = 0;
	int i,j;

	static int scrollPixSkip = 0;
	static int renderLine = 0;
	static int blankLine = 0;

	static int scrollPixSkipAbout = 0;
	static int renderLineAbout = 0;
	static int blankLineAbout = 0;

	static char *credits[] = {
		"XLOGICAL",
		" ",
		" ",
		" ",
		"DEVELOPERS",
		"TOM WARKENTIN",
		"NEIL BROWN",
		" ",
		" ",
		" ",
		"RENDERED GRAPHICS",
		"SLOANE MUSCROFT",
		" ",
		" ",
		" ",
		" ",
		"THANKS TO ALL THE FOLKS AT",
		"RAINBOW ARTS WHO PRODUCED THIS",
		"GREAT GAME FOR THE AMIGA",
		" ",
		"...WHEREVER THEY ARE NOW",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		"NOTHING TO SEE HERE....",
		" ",
		" ",
		" ",
		"MOVE ALONG...",
		"" // Must have a null at the end
	};


	if( switchFlag++ % BLINK_RATE == 0 )
	{
		if (blinker)
		{
			blinker = 0;
		} else {
			blinker = 1;
		}
	}

	switch( currentGame->gameState )
	{
	case BALL_TIMEOUT:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );
		// Blink on and off here.
		if( blinker )
		{
			scrFont.render_string_center( "BALL TIMEOUT", 0, PLAYWIDTH, 50 );
		}
		break;
	case MAP_TIMEOUT:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );
		if( blinker )
		{
			scrFont.render_string_center( "OUT OF TIME", 0, PLAYWIDTH, 50 );
		}
		break;
	case WON:
		// Blink our congrats
		if( blinker )
		{
			scrFont.render_string_center( 
					"CONGRATULATIONS!!  YOU WON", 0, PLAYWIDTH, 50 );
		} else {

			// Clear the blinker area
			graphDriver->graph_clear_rect(
				0, 50,
				graphDriver->graph_main_width(),
				scrFont.get_height( ) );
		}

		if (gEnteringHiScore)
		{
			scrFont.render_string_center("ENTER YOUR NAME", 0, PLAYWIDTH, 200);
			static int wonBlinkCount = 3;
			static bool wonOnOffFlag = true;
			if (wonBlinkCount <= 0)
			{
				wonBlinkCount = 3;
				wonOnOffFlag = !wonOnOffFlag;
			} else {
				wonBlinkCount -= 1;
			}
			// clear the name area
			graphDriver->graph_clear_rect(
				0, 250,
				graphDriver->graph_main_width(),
				scrFont.get_height( ) );
			char buf[32+1];
			sprintf( buf, "%s", currentGame->playerName );
			scrFont.render_string_center(buf, 0, PLAYWIDTH, 250);
			if (wonOnOffFlag)
			{
				int len = scrFont.stringLen( buf );
				int x = (PLAYWIDTH - len ) / 2 + len;
				scrFont.render_string( "-", x, 250 );
			}
		} else {

			// Move the text up by our CREDITS_SCROLL_SKIP.
			graphDriver->graph_copy_area( 
					0, CREDITS_SCROLL_BASE, 
					0, CREDITS_SCROLL_BASE - CREDITS_SCROLL_SKIP, 
					PLAYWIDTH, CREDITS_SCROLL_HEIGHT );

			// Decrement the pixel rows to skip before drawing
			scrollPixSkip += CREDITS_SCROLL_SKIP;

			// Now draw the lines of text we can see
			if( credits[renderLine][0] != '\0' )
			{
				// We're not on the last line yet so keep drawing stuff
				// Draw our line of text starting at the bottom
				scrFont.render_string_center( 
					credits[renderLine], 0, PLAYWIDTH,  
					CREDITS_SCROLL_BASE + CREDITS_SCROLL_HEIGHT - scrollPixSkip );
			}

			// See if we're at the height of the text  + spacing yet
			if( scrollPixSkip >= scrFont.get_height( ) + CREDITS_SCROLL_SPACING )
			{
				// Yep, we are.  Reset our pixel skip
				scrollPixSkip = 0;
				if( credits[renderLine][0] != '\0' )
				{
					// Increment our rendering line if we're not at the end.
					renderLine++;
				} else {
					// We're at the last line - count render lines until
					// we've scrolled everything and we can redraw
					blankLine++;
					if( blankLine > ( CREDITS_SCROLL_HEIGHT / scrFont.get_height( ) ) )
					{
						renderLine = 0;
					}
				}
			}

			// Now erase the top where we copied over stuff
			graphDriver->graph_clear_rect( 
					0, CREDITS_SCROLL_BASE - CREDITS_SCROLL_SKIP, 
					PLAYWIDTH, CREDITS_SCROLL_SKIP );

			// Now erase the bottom where we drew too much
			graphDriver->graph_clear_rect( 
					0, CREDITS_SCROLL_BASE + CREDITS_SCROLL_HEIGHT - 1,
					PLAYWIDTH, scrFont.get_height( ) );
		}

		break;
	case MAP_COMPLETE:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );
		// Do some scoring here.....
		scrFont.render_string_center( "WELL DONE", 0, PLAYWIDTH, 5 );
		scrFont.render_string_center( "LEVEL COMPLETED", 0, PLAYWIDTH, 50 );
		scrFont.render_string( "SPINNERS", 50, 150 );

		sprintf( cstr, "%d", CURMAP->spinnersOnMap );
		scrFont.render_string_rjust( cstr, PLAYWIDTH - 50 , 150 );

		if( CURMAP->haveMapTimer )
		{
			scrFont.render_string( "SECONDS LEFT", 50, 200 );
			sprintf( cstr, "%ld", spareTime / kTicksInSecond );
			scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 200 );

			scrFont.render_string( "TIME BONUS", 50, 250 );
			sprintf( cstr, "%ld", currentGame->bonus );
			scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 250 );

			if (currentGame->bonus > 0)
			{
				if (currentGame->bonus > kBonusStep)
				{
					currentGame->score += kBonusStep;
					currentGame->bonus -= kBonusStep;
				} else {
					currentGame->score += currentGame->bonus;
					currentGame->bonus = 0;
				}
				check_bonus_life();
			} else {
				currentGame->bonus = 0;
			}
		} else {
			scrFont.render_string( "NO TIME LIMIT", 50, 200 );
			scrFont.render_string( "NO TIME BONUS", 50, 250 );
			currentGame->bonus = 0;
		}

		scrFont.render_string( "SCORE", 50, 300 );
		sprintf( cstr, "%ld", currentGame->score );
		scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 300 );

		break;
	case HELP_MAIN:
	case HELP_GAME:
		draw_help();
		break;
	case MAP_START:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );

		sprintf( cstr, "%s", (*currentGame->currentMap)->mapName );
		scrFont.render_string_center( cstr, 5, PLAYWIDTH - 5, 20 );

		scrFont.render_string( "PASSWORD" , 50, 100 );
		sprintf( cstr, "%s", encrypt(
			(*currentGame->currentMap)->mapName, currentGame->encryptName ) );
		scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 100 );

		scrFont.render_string( "SPINNERS" , 50, 150 );
		sprintf( cstr, "%d", CURMAP->spinnersOnMap );
		scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 150 );

		if( CURMAP->haveMapTimer )
		{
			long totalSecs = CURMAP->mapTimeLimit / kTicksInSecond;
			long mins = totalSecs / 60;
			long secs = totalSecs % 60;
			scrFont.render_string( "MAP TIME" , 50, 200 );
			sprintf( cstr, "%02ld:%02ld", mins, secs );
			scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 200 );
		} else {
			scrFont.render_string( "NO TIME LIMIT" , 50, 200 );
		}

		{
			long totalSecs = CURMAP->ballTimeLimit / kTicksInSecond;
			long mins = totalSecs / 60;
			long secs = totalSecs % 60;
			scrFont.render_string( "BALL TIME" , 50, 250 );
			sprintf( cstr, "%02ld:%02ld", mins, secs );
			scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 250 );
		}

		scrFont.render_string( "LIVES LEFT" , 50, 300 );
		sprintf( cstr, "%d", currentGame->livesLeft );
		scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 300 );

		break;
	case GAME_OVER:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );
		scrFont.render_string_center( "GAME OVER", 0, PLAYWIDTH, 50 );
		if (gEnteringHiScore)
		{
			scrFont.render_string_center("ENTER YOUR NAME", 0, PLAYWIDTH, 200);
			static int blinkCount = 3;
			static bool onOffFlag = true;
			if (blinkCount <= 0)
			{
				blinkCount = 3;
				onOffFlag = !onOffFlag;
			} else {
				blinkCount -= 1;
			}
			char buf[32+1];
			sprintf( buf, "%s", currentGame->playerName );
			scrFont.render_string_center(buf, 0, PLAYWIDTH, 250);
			if (onOffFlag)
			{
				int len = scrFont.stringLen( buf );
				int x = (PLAYWIDTH - len ) / 2 + len;
				scrFont.render_string( "-", x, 250 );
			}
		}
		break;
	case HIGH_SCORES:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );
		scrFont.render_string_center( "HIGH SCORES", 0, PLAYWIDTH, 10 );

		// Draw the high scores
		for( i = 0; i < NUM_HI_SCORES; i++ )
		{
			scrFont.render_string( 
				(char *)currentGame->hiscores[i].name.c_str( ), 50, 
															60 + i * 35 );
			sprintf( cstr, "%ld", currentGame->hiscores[i].score );
			scrFont.render_string_rjust( cstr, PLAYWIDTH - 50, 60 + i * 35 );
		}
		break;
	case ABOUT:
		scrFont.render_string_center( "ABOUT XLOGICAL", 0, PLAYWIDTH, 30 );
		j = 100;
		scrFont.render_string( "CODERS", 50, j );
		scrFont.render_string_rjust( "NEIL BROWN", PLAYWIDTH - 50, j );
		j += 35;
		scrFont.render_string_rjust( "TOM WARKENTIN", PLAYWIDTH - 50, j );
		j += 35;
		j += 35;
		scrFont.render_string( "GRAPHICS", 50, j );
		scrFont.render_string_rjust( "SLOANE MUSCROFT", PLAYWIDTH - 50, j );

		modScroller.render_string_center( 
				"XLOGICAL V1.0 COPYRIGHT (C) 2000 NEIL BROWN, TOM WARKENTIN", 
				0, PLAYWIDTH, 280 );
		modScroller.render_string_center( 
				"XLOGICAL COMES WITH ABSOLUTELY NO WARRANTY;", 
				0, PLAYWIDTH, 290 );
		modScroller.render_string_center( 
				"XLOGICAL IS DISTRIBUTED UNDER THE GNU PUBLIC LICENSE", 
				0, PLAYWIDTH, 300 );

		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 
			0, 0, 
			64, LICENSE_SCROLL_BASE - 10 , 
			176, 2, 
			1 );

		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 
			0, 0, 
			395, LICENSE_SCROLL_BASE - 10 , 
			180, 2, 
			1 );


		modScroller.render_string_center( 
				"GNU PUBLIC LICENSE", 
				0, PLAYWIDTH, LICENSE_SCROLL_BASE - 13 );

		// Move the text up by our CREDITS_SCROLL_SKIP.
		graphDriver->graph_copy_area( 
				0, LICENSE_SCROLL_BASE, 
				0, LICENSE_SCROLL_BASE - LICENSE_SCROLL_SKIP, 
				PLAYWIDTH, LICENSE_SCROLL_HEIGHT );

		// Decrement the pixel rows to skip before drawing
		scrollPixSkipAbout += LICENSE_SCROLL_SKIP;

		// Now draw the lines of text we can see
		if( gpl[renderLineAbout][0] != '\0' )
		{
			// We're not on the last line yet so keep drawing stuff
			// Draw our line of text starting at the bottom
			modScroller.render_string_center( 
				gpl[renderLineAbout], 0, PLAYWIDTH,  
				LICENSE_SCROLL_BASE + LICENSE_SCROLL_HEIGHT - scrollPixSkipAbout );
		}

		// See if we're at the height of the text  + spacing yet
		if( scrollPixSkipAbout >= modScroller.get_height( ) + LICENSE_SCROLL_SPACING )
		{
			// Yep, we are.  Reset our pixel skip
			scrollPixSkipAbout = 0;
			if( gpl[renderLineAbout][0] != '\0' )
			{
				// Increment our rendering line if we're not at the end.
				renderLineAbout++;
			} else {
				// We're at the last line - count render lines until
				// we've scrolled everything and we can redraw
				blankLineAbout++;
				if( blankLineAbout > ( LICENSE_SCROLL_HEIGHT / modScroller.get_height( ) ) )
				{
					renderLineAbout = 0;
				}
			}
		}

		// Now erase the top where we copied over stuff
		graphDriver->graph_clear_rect( 
				0, LICENSE_SCROLL_BASE - LICENSE_SCROLL_SKIP, 
				PLAYWIDTH, LICENSE_SCROLL_SKIP );

		// Now erase the bottom where we drew too much
		graphDriver->graph_clear_rect( 
				0, LICENSE_SCROLL_BASE + LICENSE_SCROLL_HEIGHT - 1,
				PLAYWIDTH, modScroller.get_height( ) );

		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 
			0, 0, 
			64, LICENSE_SCROLL_BASE + LICENSE_SCROLL_HEIGHT + 3 , 
			256, 2, 
			1 );

		graphDriver->graph_draw_pixmap( 
			BMP_SCROLL_BLOCK, 
			0, 0, 
			320, LICENSE_SCROLL_BASE + LICENSE_SCROLL_HEIGHT + 3 , 
			256, 2, 
			1 );

		break;
	default:
		// Clear the screen to black
		graphDriver->graph_clear_rect(
			0, 0,
			graphDriver->graph_main_width(),
			graphDriver->graph_main_height() );
		scrFont.render_string_center( "HOW DID YOU GET HERE???", 0, 
														PLAYWIDTH, 40 );
		break;
	}

	scrFont.render_string_center( "PRESS SPACE TO CONTINUE", 0, PLAYWIDTH, 440 );
}


void
draw_help( void )
{
	int xoff;
	int yoff;

	// Clear the screen to black
	graphDriver->graph_clear_rect(
		0, 0,
		graphDriver->graph_main_width(),
		graphDriver->graph_main_height() );

	scrFont.render_string_center( "HOW TO PLAY", 0, PLAYWIDTH, 5 );

	xoff = 10;
	yoff = 50;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_TELEPORT_BASE, xoff, yoff );
	graphDriver->graph_draw( BMP_TELEPORT_UD, xoff, yoff );
	modScroller.render_string( "-- Teleporter --", xoff+70, yoff+5 );
	modScroller.render_string( "The ball will be", xoff+70, yoff+15 );
	modScroller.render_string( "transported to", xoff+70, yoff+ 25 );
	modScroller.render_string( "the matching", xoff+70, yoff+35);
	modScroller.render_string( "teleporter tile.", xoff+70, yoff+45 );

	yoff += 70 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_BALLMOVE5_5, xoff + 12, yoff + 5 );
	modScroller.render_string( "--Moving Balls--", xoff+70, yoff+5 );
	modScroller.render_string( "Colored bars show", xoff+70, yoff+15 );
	modScroller.render_string( "how many balls are", xoff+70, yoff+ 25 );
	modScroller.render_string( "in motion. When it", xoff+70, yoff+35);
	modScroller.render_string( "is full, no more", xoff+70, yoff+45 );
	modScroller.render_string( "balls can be moved.", xoff+70, yoff+55 );

	yoff += 70 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_PATTERN, xoff, yoff );
	graphDriver->graph_draw( BMP_GEM_C1, xoff + 23, yoff + 4 );
	graphDriver->graph_draw( BMP_GEM_C2, xoff + 43, yoff + 23 );
	graphDriver->graph_draw( BMP_GEM_C3, xoff + 23, yoff + 42 );
	graphDriver->graph_draw( BMP_GEM_C4, xoff + 2, yoff + 23 );
	modScroller.render_string( "--Pattern--", xoff+70, yoff+5 );
	modScroller.render_string( "Shows the colors", xoff+70, yoff+15 );
	modScroller.render_string( "of the balls in", xoff+70, yoff+ 25 );
	modScroller.render_string( "a spinner for it", xoff+70, yoff+35);
	modScroller.render_string( "to be completed.", xoff+70, yoff+45 );
	xoff = 235;
	yoff = 50 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_ORDER, xoff, yoff );
	graphDriver->graph_draw( BMP_GEM_C1, xoff + 23, yoff + 4 );
	graphDriver->graph_draw( BMP_GEM_C2, xoff + 23, yoff + 23 );
	graphDriver->graph_draw( BMP_GEM_C3, xoff + 23, yoff + 42 );
	modScroller.render_string( "--Order--", xoff+70, yoff+5 );
	modScroller.render_string( "Shows which", xoff+70, yoff+15 );
	modScroller.render_string( "color balls", xoff+70, yoff+ 25 );
	modScroller.render_string( "to fill the", xoff+70, yoff+35);
	modScroller.render_string( "spinner with", xoff+70, yoff+45 );
	modScroller.render_string( "first.", xoff+70, yoff+55 );
	yoff += 70 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_NEXT_BASE, xoff, yoff );
	graphDriver->graph_draw( BMP_GEM_C1, xoff + 24, yoff + 24 );
	modScroller.render_string( "--Next Ball--", xoff+70, yoff+5 );
	modScroller.render_string( "Shows what the", xoff+70, yoff+15 );
	modScroller.render_string( "color of the", xoff+70, yoff+ 25 );
	modScroller.render_string( "next ball will", xoff+70, yoff+35);
	modScroller.render_string( "be.", xoff+70, yoff+45);
	yoff += 70 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_TIMER, xoff, yoff );
	modScroller.render_string( "--Map Timer--", xoff+70, yoff+5 );
	modScroller.render_string( "Counts down", xoff+70, yoff+15 );
	modScroller.render_string( "the time left", xoff+70, yoff+ 25 );
	modScroller.render_string( "to complete", xoff+70, yoff+35);
	modScroller.render_string( "the map.", xoff+70, yoff+45);
	xoff = 420;
	yoff = 50 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_STARTTIMER_00, xoff + 7, yoff + 8 );
	modScroller.render_string( "--Ball Timer--", xoff+70, yoff+5 );
	modScroller.render_string( "Indicates how", xoff+70, yoff+15 );
	modScroller.render_string( "much time you", xoff+70, yoff+ 25 );
	modScroller.render_string( "have to get", xoff+70, yoff+ 35 );
	modScroller.render_string( "the ball off the", xoff+70, yoff+45);
	modScroller.render_string( "starting track.", xoff+70, yoff+55 );
	yoff += 70 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_BLOCK_BASE, xoff, yoff );
	graphDriver->graph_draw( BMP_GEM_C1, xoff + 24, yoff + 24 );
	modScroller.render_string( "--Blocker--", xoff+70, yoff+5 );
	modScroller.render_string( "Only balls that", xoff+70, yoff+15 );
	modScroller.render_string( "match the", xoff+70, yoff+ 25 );
	modScroller.render_string( "blocker's color", xoff+70, yoff+35);
	modScroller.render_string( "may pass.", xoff+70, yoff+45);
	yoff += 70 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_PAINT_BASE, xoff, yoff );
	graphDriver->graph_draw( BMP_GEM_C1, xoff + 24, yoff + 24 );
	modScroller.render_string( "--Painter--", xoff+70, yoff+5 );
	modScroller.render_string( "Changes the color", xoff+70, yoff+15 );
	modScroller.render_string( "of the ball to", xoff+70, yoff+ 25 );
	modScroller.render_string( "match", xoff+70, yoff+35);
	yoff += 70 ;
	xoff = 10;
	yoff = 265 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_NEXT_BASE, xoff, yoff );
	graphDriver->graph_draw( BMP_ARROW_R, xoff + 23, yoff + 23 );
	modScroller.render_string( "--Oneway--", xoff+70, yoff+5 );
	modScroller.render_string( "Balls may only", xoff+70, yoff+15 );
	modScroller.render_string( "travel in the", xoff+70, yoff+ 25 );
	modScroller.render_string( "direction of the", xoff+70, yoff+35);
	modScroller.render_string( "arrow.", xoff+70, yoff+45 );
	xoff = 235;
	yoff = 265 ;
	graphDriver->graph_draw( BMP_BACK_GAME, xoff, yoff );
	graphDriver->graph_draw( BMP_SPIN_0, xoff, yoff );
	modScroller.render_string( "--Spinner--", xoff+70, yoff+5 );
	modScroller.render_string( "Must be filled with balls of the", xoff+70, yoff+15 );
	modScroller.render_string( "same color or following the order", xoff+70, yoff+ 25 );
	modScroller.render_string( "and pattern tiles.  Right-click", xoff+70, yoff+35);
	modScroller.render_string( "to spin.  Left-click on a ball to", xoff+70, yoff+45 );
	modScroller.render_string( "eject it.", xoff+70, yoff+55 );

	xoff = 230;
	yoff = 340 ;
	modScroller.render_string( "[ESC]   - Bring up the menu", xoff, yoff );
	modScroller.render_string( "[LEFT]  - Play Previous MOD", xoff, yoff+10 );
	modScroller.render_string( "[RIGHT] - Play Next MOD", xoff, yoff+20 );

	yoff = 375;
	modScroller.render_string_center( "The object of the game is to fill up the spinners on the", 0, PLAYWIDTH, yoff );
	yoff += 10;
	modScroller.render_string_center( "map with balls of the same color.  If there is a pattern", 0, PLAYWIDTH, yoff );
	yoff += 10;
	modScroller.render_string_center( "indicator on the level, the spinners must match that", 0, PLAYWIDTH, yoff );
	yoff += 10;
	modScroller.render_string_center( "pattern instead.  If there is an order indicator", 0, PLAYWIDTH, yoff );
	yoff += 10;
	modScroller.render_string_center( "then the spinners must be filled with balls matching", 0, PLAYWIDTH, yoff );
	yoff += 10;
	modScroller.render_string_center( "the colors in the order indicator until it is empty.", 0, PLAYWIDTH, yoff );
	yoff += 10;
	modScroller.render_string_center( "", 0, PLAYWIDTH, yoff );

}

void
draw_score( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : draw_score( )" << endl;
#endif
	char scoreStr[ 24 ];

	// Clear the score spot
	graphDriver->graph_clear_rect( 500, 5, 139, 35 );

	// Draw the score
	sprintf( scoreStr, "%8ld", currentGame->score );
	scrFont.render_string( (char *)&scoreStr, 500, 5 );
}

void
scroll_info( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : scroll_info( )" << endl;
#endif
	static int first = 1;

	if( first )
	{
		refresh_scroll_info( );
		first = 0;
	}
	infoScroller.draw( );
}


void
refresh_scroll_info( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : refresh_scroll_info( )" << endl;
#endif
	char *info = new char [300];

	sprintf( 
		info, 
		"LEVEL: %s  --  PASSWORD: %s  --  LIVES LEFT: %d",
		(*currentGame->currentMap)->mapName,
		encrypt((*currentGame->currentMap)->mapName, currentGame->encryptName ),
		currentGame->livesLeft );

	infoScroller.set_string( info );
}

void
scroll_mod_info( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : scroll_mod_info( )" << endl;
#endif
	static char *modInfo = NULL;
	static long modChecksum = 0;
	static bool noModInfoSet = false;
	static int skip = MOD_UPDATE_SKIP;

	// Skip a few cycles before updating text
	// We don't need to be dead-on, and it saves
	// a lot of time
	if( skip-- > 0 )
	{
		modScroller.draw( );
		return;
	}

	skip = MOD_UPDATE_SKIP;

	// Get the mod name
	if(audioDriver->get_current_music_name() != NULL)
	{
		noModInfoSet = false;
		// If the checksum doesn't match, then it's a new mod
		if(modChecksum != get_cksum( audioDriver->get_current_music_name() ))
		{
			modChecksum = get_cksum( audioDriver->get_current_music_name() );
			delete [] modInfo;
			modInfo = new char [ 
					strlen( audioDriver->get_current_music_name() ) + 100 ];
			sprintf( 
				modInfo, 
				"MODULE [%s] -- MODULE TYPE: [%s]",
				audioDriver->get_current_music_name(),
				audioDriver->get_current_music_type() );
			modScroller.set_string( modInfo );
			modScroller.draw( );
		} else {
			modScroller.draw( );
		}
	} else {
		if (!noModInfoSet)
		{
			modScroller.set_string( "NO MODULE INFO" );
			noModInfoSet = true;
		}
		modScroller.draw( );
	}
}

void
switch_to_game_over( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_game_over" << endl;
#endif

	gInGame = false;
	currentGame->gameState = GAME_OVER;
	if (currentGame->is_hiscore())
	{
		gEnteringHiScore = true;
		gNamePos = 0;
		*(currentGame->playerName) = 0;
	}

	audioDriver->play_music( musicFiles[MUSIC_END_GAME] );
}

void
switch_to_high_scores( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_high_scores" << endl;
#endif

	gInGame = false;
	currentGame->gameState = HIGH_SCORES;
	currentGame->write_hiscores();
	graphDriver->graph_set_click_func( intermission_click_func );
	graphDriver->graph_set_key_press_func( intermission_key_press_func );
	graphDriver->graph_set_loop_func( intermission_loop_func );

	audioDriver->play_music( musicFiles[MUSIC_HIGH_SCORE] );
}

void
switch_to_intro( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_intro" << endl;
#endif

	gInGame = false;
	graphDriver->graph_set_click_func( start_click_func );
	graphDriver->graph_set_key_press_func( start_key_press_func );
	graphDriver->graph_set_loop_func( start_loop_func );

	audioDriver->play_music( musicFiles[MUSIC_INTRO] );

	// Set the background image
	graphDriver->graph_set_background( BMP_TITLE_TEXT_4 );

	// Draw main title
	graphDriver->graph_draw_perm( BMP_TITLE_TEXT_1, 0, 0, 50, 100, 0, 0 );
	graphDriver->graph_draw_perm( BMP_TITLE_TEXT_2, 0, 0, 50, 300, 0, 0 );
	graphDriver->graph_erase_rect( 
			0,0, 
			graphDriver->graph_main_width( ), 
			graphDriver->graph_main_height( ) );
}

void
switch_to_intro_no_music_change( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_intro" << endl;
#endif

	gInGame = false;
	graphDriver->graph_set_click_func( start_click_func );
	graphDriver->graph_set_key_press_func( start_key_press_func );
	graphDriver->graph_set_loop_func( start_loop_func );

	// Set the background image
	graphDriver->graph_set_background( BMP_TITLE_TEXT_4 );

	// Draw main title
	graphDriver->graph_draw_perm( BMP_TITLE_TEXT_1, 0, 0, 50, 100, 0, 0 );
	graphDriver->graph_draw_perm( BMP_TITLE_TEXT_2, 0, 0, 50, 300, 0, 0 );
	graphDriver->graph_erase_rect( 
			0,0, 
			graphDriver->graph_main_width( ), 
			graphDriver->graph_main_height( ) );
}

void
switch_to_intermission( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_intermission" << endl;
#endif

	gInGame = false;
	graphDriver->graph_set_click_func( intermission_click_func );
	graphDriver->graph_set_key_press_func( intermission_key_press_func );
	graphDriver->graph_set_loop_func( intermission_loop_func );

	audioDriver->play_music( musicFiles[MUSIC_PRE_GAME] );
}

void
switch_to_intermission_no_music_change( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_intermission_no_music_change" << endl;
#endif

	gInGame = false;
	graphDriver->graph_set_click_func( intermission_click_func );
	graphDriver->graph_set_key_press_func( intermission_key_press_func );
	graphDriver->graph_set_loop_func( intermission_loop_func );

}

void
switch_to_playing( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_playing" << endl;
#endif

	gInGame = true;
	gMenuEntryTime = 0;
	CURMAP->reset();
	graphDriver->graph_set_click_func( play_click_func );
	graphDriver->graph_set_key_press_func( play_key_press_func );
	graphDriver->graph_set_loop_func( play_loop_func );
	full_refresh();

	audioDriver->play_music( gModList.next().c_str() );
}

void
switch_to_playing_no_music_change( void )
{
#ifdef DEBUG_FUNC
	cout << "switch_to_playing_no_music_change" << endl;
#endif

	gInGame = true;
	graphDriver->graph_set_click_func( play_click_func );
	graphDriver->graph_set_key_press_func( play_key_press_func );
	graphDriver->graph_set_loop_func( play_loop_func );
	full_refresh();
}

void
init_in_game_music()
{
	if (atoi(properties::instance().get( "audio.enabled" ).c_str()) > 0)
	{
		gModList.init();
		gModList.randomize();
	}
}

void
music_finished()
{
	if (gInGame)
	{
		// we are in game - so play the next song in the modlist
		audioDriver->play_music( gModList.next().c_str() );
	} else {
		// we are not in game - so replay the current song
		audioDriver->play_current_music();
	}
}

// $Log: gamelogic.cpp,v $
// Revision 1.8  2001/08/01 00:59:40  tom
// Changed blinker code to use if statement.  Visual C++ didn't like the ~
// operator.
//
// Revision 1.7  2001/07/31 20:54:52  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.6  2001/03/15 09:39:31  tom
// added some logic to handle video mode changes on the fly
//
// Revision 1.5  2001/02/19 03:03:53  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.4  2001/02/18 09:04:14  tom
// - changed background tile to be a background jpg image
// - added prompt for user name when high score achieved
// - moved finding user defined in game music to load phase so that game
//   screen comes up faster when a large number of user defined dirs exist
// - fixed a bug on "RESTART LEVEL" menu item where it would take you to the
//   intermission screen but as soon as game play started, it was "GAME OVER".
//   The menu item now changes to "END GAME" if no lives are left.
//
// Revision 1.3  2001/02/17 07:18:21  tom
// got xlogical working in windows finally - with the following limitations:
// - music is broken (disabled in this checkin)
// - no user specified mod directories for in game music
// - high scores will be saved as user "nobody"
//
// Revision 1.2  2001/02/16 20:59:53  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:27  brown
// Working toward Windows integration
//
// Revision 1.44  2000/11/19 03:23:47  brown
// Fixed lost ball bug - found teleporter bug but it's not fixed yet
//
// Revision 1.43  2000/11/09 22:06:33  tom
// cleaned up compiler warnings
//
// Revision 1.42  2000/11/07 07:40:21  tom
// fixed infinite negative bonus bug
//
// Revision 1.41  2000/10/17 05:15:42  tom
// fixed typo in "BROWN" on about screen
//
// Revision 1.40  2000/10/14 03:09:29  tom
// commented out defining of debug mode
//
// Revision 1.39  2000/10/13 04:41:11  tom
// fixed core dump when no module info is available.
//
// Revision 1.38  2000/10/08 23:28:56  tom
// commented out debug defines
//
// Revision 1.37  2000/10/08 21:14:02  brown
// Fixed blocker problem
// Fixed painter tile so the right bitmaps is drawn
//
// Revision 1.36  2000/10/08 19:12:57  tom
// fixed help screen
//
// Revision 1.35  2000/10/08 18:23:09  brown
// Fixed the editor crash when the level file didn't exist
// Added help menu
//
// Revision 1.34  2000/10/08 16:45:56  tom
// added time warning sound
//
// Revision 1.33  2000/10/08 16:07:28  tom
// fixed some little annoyances
//
// Revision 1.32  2000/10/08 07:08:01  tom
// ifdef'd quick quit keypress code and next level jump keypress code
//
// Revision 1.31  2000/10/08 05:41:00  tom
// fixed check score potential feature
//
// Revision 1.30  2000/10/08 05:37:44  tom
// added new pattern sound effect
//
// Revision 1.29  2000/10/08 05:30:18  tom
// - added map reset calls all over the place
// - added sound effect for finishing level
//
// Revision 1.28  2000/10/08 04:04:07  tom
// added bonus life scoring
//
// Revision 1.27  2000/10/08 02:53:47  brown
// Fixed the level editor and some graphics
//
// Revision 1.26  2000/10/07 19:26:20  brown
// Added BALL_SPEED_PCT to the parser
// Fixed debug info output
//
// Revision 1.25  2000/10/07 19:21:35  tom
// ifdef'd printing of level file being loaded and some other debug stuff
//
// Revision 1.24  2000/10/07 19:12:18  brown
// Speed-throttling code completed
//
// Revision 1.22  2000/10/07 05:41:19  tom
// made hi-score file a hard coded absolute path
//
// Revision 1.21  2000/10/06 19:29:04  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.20  2000/10/03 02:51:15  brown
// Random refresh changes.
//
// Revision 1.19  2000/10/03 01:46:04  tom
// fixed refresh bug when cancelling/resuming game from play menu
//
// Revision 1.18  2000/10/02 06:00:00  tom
// fixed some remaining refresh and music restart bugs
//
// Revision 1.17  2000/10/02 02:23:47  brown
// Random fixes
//
// Revision 1.16  2000/10/01 22:16:25  tom
// added about screen
//
// Revision 1.15  2000/10/01 21:41:42  tom
// fixed refresh flickering during transitions
//
// Revision 1.14  2000/10/01 21:29:22  tom
// fixed music restarting in the intermission screens when you enter/exit
// the menu repeatedly
//
// Revision 1.13  2000/10/01 21:07:53  tom
// made use of music_finished callback to play next user song or to replay
// current song depending on what state the program is in.
//
// Revision 1.12  2000/10/01 20:53:15  brown
// More background fixes
//
// Revision 1.11  2000/10/01 19:35:53  brown
// Background fixes
//
// Revision 1.10  2000/10/01 19:28:01  tom
// - removed all references to CFont
// - fixed password entry menu item
//
// Revision 1.9  2000/10/01 18:52:27  brown
// Fixed some background stuff and the title screen
//
// Revision 1.8  2000/10/01 18:41:34  tom
// fixed music starting over when returning from menu
//
// Revision 1.7  2000/10/01 18:27:01  tom
// added new ball sound effect and code to play it
//
// Revision 1.6  2000/10/01 08:08:14  tom
// finished implementing the SDL_mixer audio driver
//
// Revision 1.5  2000/10/01 05:00:24  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.4  2000/10/01 03:43:32  brown
// Added FPS counter
//
// Revision 1.3  2000/09/30 17:33:15  brown
// Fixed timer drawing and order/pattern refreshes
//
// Revision 1.2  2000/09/30 15:52:12  brown
// Fixed score display, text scrolling, window height, ball redraws
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.72  2000/07/23 18:29:52  brown
// Fixed problem where quitting the current level didn't reset levels to the
// beginning
//
// Revision 1.71  2000/07/23 16:50:27  brown
// Fixed level timer changing while paused
// Added "finish spinner" animation
// Fixed level ending before last spinner finished ( sortof )
//
// Revision 1.70  2000/04/19 03:20:26  tom
// ifdef'd the code that uses getlogin() in favor of getpwuid( geteuid() ).
//
// Revision 1.69  2000/04/17 21:29:53  tom
// Fixed core dumps and music & sound playing problems.  (xlogical now
// requires libmikmod 3.1.9)
//
// Revision 1.68  2000/03/28 07:29:59  tom
// ifdef'd printing of debug information.
//
// Revision 1.67  2000/02/23 07:28:58  tom
// Fixed a bonus calculating bug.
//
// Revision 1.66  2000/02/21 23:06:34  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.65  2000/02/13 07:32:46  tom
// Moved writing of high score file into clean_exit()
//
// Revision 1.64  2000/02/13 07:24:15  tom
// made high score reading ifstream not use the new operator (no more memory
// leak and it will close the file when the object goes out of scope).
//
// Revision 1.63  2000/02/13 07:16:36  tom
// - changed level names to include spaces
// - made it so that player cannot advance intermission screens until bonus
//   is finished being moved to the player's score
//
// Revision 1.62  2000/02/13 06:27:18  tom
// Fixed new ball timer bug and high score update bug.
//
// Revision 1.61  2000/02/13 03:44:49  brown
// Start tile changes, as well as some font scroll changes
//
// Revision 1.60  2000/02/13 00:16:45  tom
// Made title screen pop up menu when mouse is clicked, implemented reset high
// score menu item.
//
// Revision 1.59  2000/02/12 23:47:09  tom
// Fixed writing of hiscore file.
//
// Revision 1.58  2000/02/12 23:23:46  tom
// Fixed next level transition when using mouse click to advance from
// intermission screens.
//
// Revision 1.57  2000/02/12 23:12:45  tom
// Fixed "Spinners" text being printed off the edge of the screen.
// print_normal() wasn't fixed...
//
// Revision 1.56  2000/02/12 22:54:50  tom
// Did a bunch of menu fixing up... and got rid of menu stuff in graph_gtk.
//
// Revision 1.55  2000/02/12 21:23:13  brown
// Fix
//
// Revision 1.54  2000/02/12 21:07:07  brown
//
// Bunch of new backgrounds
//
// Revision 1.53  2000/02/12 20:38:33  tom
// Fixed up
//
// Revision 1.52  2000/02/07 03:53:09  brown
// General graphics changes with some logic here and there
//
// Revision 1.51  2000/01/23 09:04:31  tom
// - made threaded sound loop conditionally compiled (now disabled by default)
//
// Revision 1.50  2000/01/23 06:48:07  tom
// Disabled key press events until levels are loaded.
//
// Revision 1.49  2000/01/23 06:11:36  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.48  2000/01/22 19:35:27  brown
// High score changes etc.
//
// Revision 1.47  2000/01/10 02:53:47  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.46  2000/01/09 02:26:16  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.45  2000/01/06 02:41:58  brown
// Some font stuff.  Fixed some other intermission goodies
//
// Revision 1.44  2000/01/05 03:47:33  brown
// Fixed some endgame stuff, scrollers, and hi-score menu entry goodies
//
// Revision 1.43  2000/01/02 03:33:04  tom
// Added levels 70 & 71.
//
// Revision 1.42  2000/01/01 21:51:18  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.41  1999/12/28 07:36:20  tom
// Fixed menu refresh problems.
//
// Revision 1.40  1999/12/25 08:18:33  tom
// Added "Id" and "Log" CVS keywords to source code.
//
