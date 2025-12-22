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
#include<list>
#include<vector>

#ifndef WIN32
#include<unistd.h>
#endif

// Application Includes
#include "mapedit.h"
#include "graph.h"
#include "gamelogic.h"
#include "globals.h"
#include "clickarea.h"
#include "text.h"

#define NUM_COLS 10
#define NUM_ROWS 7
#define TILESIZE 64
#define MENU_NUM_COLS 3
#define MENU_NUM_ROWS 5

#define SEEN_PATTERN 	 (1<<0)
#define SEEN_ORDER 		 (1<<1)
#define SEEN_NEXT	 	 (1<<2)
#define SEEN_TIME		 (1<<3)
#define SEEN_BALLTIME	 (1<<4)
#define SEEN_TP1		 (1<<5)
#define SEEN_TP2		 (1<<6)
#define SEEN_TP3		 (1<<7)
#define SEEN_TP4		 (1<<8)
#define SEEN_SPINNER	 (1<<9)
#define SEEN_START		 (1<<10)

//#define DEBUG_FUNC

#define TOP_MAP_OFFSET 32
#define MENU_X_OFFSET (NUM_COLS * TILESIZE + 5)
#define MENU_Y_OFFSET 96
#define MENU_SEP 10
#define SPACER 4

// Some random local functions
void initial_setup( void );
void write_current_map( void );
void click_on_map( int, int, int );
void click_on_menu( int, int, int );
void click_on_menu_up( int, int, int );
void click_on_menu_down( int, int, int );
void edit_draw_map_under( void );
void edit_draw_map_over( void );
void edit_draw_menu_under( void );
void edit_draw_menu_over( void );
void load_levels( void );
void next_level( int, int, int );
void prev_level( int, int, int );
void quit_no_save( int, int, int );
void quit_with_save( int, int, int );

// The offset for the menu
int menu_offset;
int selected_index;
int num_tiles;

CText errScroll;

char outFileName[128];

// For flagging problem tiles
int flagMatrix[NUM_ROWS][NUM_COLS];

// Our clickable area list
list< Cclick_area *> clickAreas;

// The map itself
vector< Ctile * > tiles;

// The template area
vector< Ctile * > menuTiles;

void
edit_click_func( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : click_func( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif

	list< Cclick_area *>::iterator it;

	it = clickAreas.begin( );
	for(; it != clickAreas.end( ); it++ )
	{
		(*it)->click_it( x, y, button );
	}
}

void
click_on_menu( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : click_on_menu( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif

	int row;
	int col;
	int relX, relY;
	int index;

	// Find our row and column
	row = y / TILESIZE;
	col = x / TILESIZE;

	// Get the click position relative to the tile origin
	relX = x % TILESIZE;
	relY = y % TILESIZE;

	// Get the vector index for our tile
	index = row * MENU_NUM_COLS + col;
	selected_index = index + menu_offset;

}

void
click_on_menu_up( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : click_on_menu_up( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif
	menu_offset -= MENU_NUM_COLS;
	if( menu_offset < 0 )
	{
		menu_offset = 0;
	}
}

void
click_on_menu_down( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : click_on_menu_down( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif
	menu_offset += MENU_NUM_COLS;
	if( menu_offset + MENU_NUM_COLS * MENU_NUM_ROWS > num_tiles )
	{
		menu_offset -= MENU_NUM_COLS;
	}
}

void
next_level( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : next_level( ";
#endif
	currentGame->currentMap++;
	if( currentGame->currentMap == gameLevels.end( ) )
	{
		currentGame->currentMap--;
		class Clevel_map *tMap = new Clevel_map;
		Ctile *tempTile = NULL;
		// Create the tiles
		for( int index = 0; index < NUM_COLS * NUM_ROWS; index++ )
		{
			tempTile = new Ctile_blank;
			tempTile->indexPos = index;
			tMap->tiles.insert( tMap->tiles.end( ), tempTile );
		}
		tMap->mapName = new char[7];
		strcpy( tMap->mapName, "NONAME" );
		gameLevels.insert( gameLevels.end( ), tMap );
		currentGame->currentMap++;
	}
}

void
quit_no_save( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : quit_no_save( ";
#endif
	cerr << endl << "EXITED WITHOUT SAVING" << endl << endl;
	clean_exit( 0 );
}

void
quit_with_save( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : quit_with_save( ";
#endif
	ofstream * ofs;

	// Truncate our output file
	ofs = new ofstream( outFileName, ios::trunc );
	ofs->close( );

	currentGame->currentMap = gameLevels.begin( );
	while( currentGame->currentMap != gameLevels.end( ) )
	{
		write_current_map( );
		currentGame->currentMap++;
	}
	clean_exit( 0 );
}

void
prev_level( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : prev_level( ";
#endif
	if( currentGame->currentMap != gameLevels.begin( ) )
	{
		currentGame->currentMap--;
	}
}

void
click_on_map( int x, int y, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : click_on_map( ";
	cerr << x << "," << y << "," << button << " )" << endl;
#endif
	int row;
	int col;
	int relX, relY;
	int index;
	int idx;
	int count;
	Ctile *tempTile = NULL;

	// Find our row and column
	row = y / TILESIZE;
	col = x / TILESIZE;

	// Get the click position relative to the tile origin
	relX = x % TILESIZE;
	relY = y % TILESIZE;

	// Get the vector index for our tile
	index = row * NUM_COLS + col;

	// Are we erasing?
	if( (button == 3)
		|| (menuTiles[selected_index]->get_type( ) == BLANK_TILE) )
	{
		tempTile = new Ctile_blank( );
		delete CURMAP->tiles[index];
		CURMAP->tiles[index] = tempTile;
		graphDriver->graph_clear_rect_perm( row * 64, col * 64, 64, 64 );
		return;
	}

	switch( menuTiles[selected_index]->get_type( ) )
	{
	case PATTERN_DISP:
		tempTile = new Ctile_pattern( );
		break;
	case ORDER_DISP:
		tempTile = new Ctile_order( );
		break;
	case NEXT_DISP:
		tempTile = new Ctile_next( );
		break;
	case TIME_DISP:
		tempTile = new Ctile_timer( );
		break;
	case MOVE_COUNTER:
		tempTile = new Ctile_moving( );
		break;
	case TELEPORT:
		tempTile = new Ctile_teleport( menuTiles[selected_index]->exitFlags );
		break;
	case TRACK:
		tempTile = new Ctile_track( menuTiles[selected_index]->exitFlags );
		break;
	case SPINNER:
		tempTile = new Ctile_spinner( );
		break;
	case PAINTER:
		tempTile = new Ctile_painter(
			TILE_PAINTER( menuTiles[selected_index] )->get_new_color( ),
			menuTiles[selected_index]->exitFlags );
		break;
	case BLOCKER:
		tempTile = new Ctile_blocker(
			TILE_BLOCKER( menuTiles[selected_index])->get_pass_color( ),
			menuTiles[selected_index]->exitFlags );
		break;
	case START:
		// See if we already have a start
		count = 0;
		idx = 0;
		for( row = 0; row < NUM_ROWS; row++ )
		{
			for( col = 0; col < NUM_COLS; col++ )
			{
				if( CURMAP->tiles[idx]->get_type( ) == START )
				{
					count++;
				}
				idx++;
			}
		}
		if( count == 0 )
		{
			tempTile = new Ctile_start( menuTiles[selected_index]->exitFlags );
		} else {
			// We found a start - no point in replacing the tile
			return;
		}
		break;
	case ONEWAY:
		tempTile = new Ctile_oneway( menuTiles[selected_index]->exitFlags,
				TILE_ONEWAY( menuTiles[selected_index])->get_one_way_dir( ) );
		break;
	case COVERED:
		tempTile = new Ctile_covered( menuTiles[selected_index]->exitFlags );
		break;
	case BLANK_TILE:
	default:
		cout << "DANGER WIL ROBINSON!!" << endl;
		break;
	}

	// Delete the old tile
	delete CURMAP->tiles[index];

	// Insert the new tile
	CURMAP->tiles[index] = tempTile;

}

void
check_completeness( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : check_completeness( )" << endl;
#endif
	int idx = 0;
	int row = 0;
	int col = 0;
	int upCount = 0;
	int leftCount = 0;
	char cstr[128];
	unsigned long flags = 0;

	for( row = 0; row < NUM_ROWS; row++ )
	{
		for( col = 0; col < NUM_COLS; col++ )
		{
			switch( CURMAP->tiles[idx]->get_type( ) )
			{
			case SPINNER:
				flags |= SEEN_SPINNER;
				break;
			case START:
				flags |= SEEN_START;
				break;
			case TELEPORT:
				if( CURMAP->tiles[idx]->exitFlags & EXIT_UP )
				{
					upCount++;
				}
				if( CURMAP->tiles[idx]->exitFlags & EXIT_LEFT )
				{
					leftCount++;
				}
				break;
			default:
				break;
			}
		idx++;
		}
	}
	if( ! (flags & SEEN_START) )
	{
		errScroll.render_string( "Start Tile Needed", 300, 0 );
	}

	if( ! (flags & SEEN_SPINNER) )
	{
		errScroll.render_string( "Spinner Needed", 300, 10 );
	}

	if( (leftCount % 2) || (upCount % 2) )
	{
		errScroll.render_string( "Unmatched Teleporters", 300, 20 );
	}

	if( (leftCount > 2) || (upCount > 2) )
	{
		errScroll.render_string( "Too Many Teleporters", 450, 0 );
	}

	sprintf( cstr, "MAP NAME: %s", CURMAP->mapName );
	errScroll.render_string( cstr, 10, 10 );
}

void
edit_loop_func( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : edit_loop_func( )" << endl;
#endif
	static int first = 1;
	static int swap = 0;

	if( first )
	{
		first = 0;
		initial_setup( );
	}

	if( swap % 50000 == 0 )
	{
		CURMAP->nextColor = (color_t)(rand( ) % 4 + 1 );
		CURMAP->order[0] = (color_t)(rand( ) % 4 + 1 );
		CURMAP->order[1] = (color_t)(rand( ) % 4 + 1 );
		CURMAP->order[2] = (color_t)(rand( ) % 4 + 1 );
		CURMAP->pattern[0] = (color_t)(rand( ) % 4 + 1 );
		CURMAP->pattern[1] = (color_t)(rand( ) % 4 + 1 );
		CURMAP->pattern[2] = (color_t)(rand( ) % 4 + 1 );
		CURMAP->pattern[3] = (color_t)(rand( ) % 4 + 1 );
	}

	// Clear the top area
	graphDriver->graph_clear_rect(
		0, 0, graphDriver->graph_main_width(), TOP_MAP_OFFSET );

	// Now redraw the map
	edit_draw_map_under( );

	// Now redraw the map
	edit_draw_menu_under( );

	graphDriver->graph_erase_rect( 
		0, 
		0, 
		graphDriver->graph_main_width( ),
		graphDriver->graph_main_height( ) );

	// Now redraw the map
	edit_draw_map_over( );

	// Now redraw the map
	edit_draw_menu_over( );

	// Draw the right color font
	if( menu_offset > 0 )
	{

		graphDriver->graph_hi_font( )->
			render_string("UP",
			NUM_COLS*TILESIZE + MENU_SEP + 60,
			TOP_MAP_OFFSET + SPACER + 15 );
	} else {
		// Draw the label
		graphDriver->graph_lo_font( )->
			render_string("UP",
			NUM_COLS*TILESIZE + MENU_SEP + 60,
			TOP_MAP_OFFSET + SPACER + 15 );
	}

	// Draw the right color font
	if( menu_offset < num_tiles )
	{
		// Draw the label
		graphDriver->graph_hi_font( )->
			render_string("DOWN",
			NUM_COLS*TILESIZE+MENU_SEP + 27,
			MENU_NUM_ROWS*TILESIZE + MENU_Y_OFFSET + SPACER + 13);
	} else {
		// Draw the label
		graphDriver->graph_lo_font( )->
			render_string("DOWN",
			NUM_COLS*TILESIZE+MENU_SEP + 27,
			MENU_NUM_ROWS*TILESIZE + MENU_Y_OFFSET + SPACER + 13);
	}

	// Display the map completeness
	check_completeness( );
}

void edit_draw_map_under( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : edit_draw_map( )" << endl;
#endif
	int row;
	int col;
	int index = 0;
	static char flash = 0;

	// Increment our flash counter
	flash++;

	// Loop through the Clevel_map object
	// and draw background squares
	for( row = 0; row < NUM_ROWS; row++ )
	{
		for( col = 0; col < NUM_COLS; col++ )
		{
			if( flagMatrix[row][col] && (flash % 2) )
			{
				flagMatrix[row][col]--;
				graphDriver->graph_draw_pixmap( 
					BMP_SPINDARK, 
					0,
					0,
					col * TILESIZE,
					row * TILESIZE + TOP_MAP_OFFSET,
					TILESIZE,
					TILESIZE,
					USE_MASK );

			} else {
				graphDriver->graph_draw_perm( 
					BMP_BACK_GAME, 
					0,
					0,
					col * TILESIZE,
					row * TILESIZE + TOP_MAP_OFFSET,
					TILESIZE,
					TILESIZE);
			}
		}
	}

	// Now loop through the Clevel_map object and draw everything 
	// that's not blank and goes under ball graphics
	index = 0;
	for( row = 0; row < NUM_ROWS; row++ )
	{
		for( col = 0; col < NUM_COLS; col++ )
		{
			if( CURMAP->tiles[index]->get_type( ) != BLANK_TILE )
			{
				CURMAP->tiles[index]->draw_under( 
					col * TILESIZE, 
					row * TILESIZE + TOP_MAP_OFFSET );
			}
			index++;
		}
	}
}	

void edit_draw_menu_under( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : edit_draw_menu( )" << endl;
#endif
	int row;
	int col;
	int index = menu_offset;
	static int back_offset = 0;

	// Loop through the Clevel_map object
	// and draw background squares
	for( row = 0; row < MENU_NUM_ROWS; row++ )
	{
		for( col = 0; col < MENU_NUM_COLS; col++ )
		{
			if( index == selected_index )
			{
				graphDriver->graph_draw_perm( 
					BMP_SEL_1 + back_offset, 
					0,
					0,
					col * TILESIZE + MENU_X_OFFSET,
					row * TILESIZE + MENU_Y_OFFSET,
					TILESIZE,
					TILESIZE );
					back_offset++;
					if( back_offset > 3 )
					{
						back_offset = 0;
					}
			} else {
				graphDriver->graph_draw_perm( 
					BMP_BACK_GAME, 
					0,
					0,
					col * TILESIZE + MENU_X_OFFSET,
					row * TILESIZE + MENU_Y_OFFSET,
					TILESIZE,
					TILESIZE );
			}

			menuTiles[index]->draw_under( 
				col * TILESIZE + MENU_X_OFFSET, 
				row * TILESIZE + MENU_Y_OFFSET);
			index++;
		}
	}
}	
void edit_draw_map_over( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : edit_draw_map( )" << endl;
#endif
	int row;
	int col;
	int index = 0;

	// Now loop through the Clevel_map object and draw anything
	// that goes on top of balls
	index = 0;
	for( row = 0; row < NUM_ROWS; row++ )
	{
		for( col = 0; col < NUM_COLS; col++ )
		{
			if( CURMAP->tiles[index]->get_type( ) != BLANK_TILE )
			{
				CURMAP->tiles[index]->draw_over( 
					col * TILESIZE, 
					row * TILESIZE + TOP_MAP_OFFSET );
			}
			index++;
		}
	}
}	

void edit_draw_menu_over( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : edit_draw_menu( )" << endl;
#endif
	int row;
	int col;
	int index = menu_offset;

	// Loop through the Clevel_map object
	// and draw background squares
	for( row = 0; row < MENU_NUM_ROWS; row++ )
	{
		for( col = 0; col < MENU_NUM_COLS; col++ )
		{
			menuTiles[index]->draw_over( 
				col * TILESIZE + MENU_X_OFFSET, 
				row * TILESIZE + MENU_Y_OFFSET );
			index++;
		}
	}

	// Prev Level Arrow
	graphDriver->graph_draw( BMP_ARROW_L,
		NUM_COLS*TILESIZE + MENU_SEP, 
		5 );
	graphDriver->graph_draw( BMP_ARROW_L,
		NUM_COLS*TILESIZE + MENU_SEP+18, 
		5 );

	graphDriver->graph_hi_font( )->
		render_string("MAP",
		NUM_COLS*TILESIZE + MENU_SEP + 43,
		0 );

	// Next Level Arrow
	graphDriver->graph_draw( BMP_ARROW_R,
		NUM_COLS*TILESIZE + MENU_SEP + 150, 
		5 );
	graphDriver->graph_draw( BMP_ARROW_R,
		NUM_COLS*TILESIZE + MENU_SEP + 150 + 18, 
		5 );

	// Quit Without Saving
	graphDriver->graph_draw( BMP_BALL_C2,
		NUM_COLS*TILESIZE - 150,
		NUM_ROWS * TILESIZE + 39 );
	errScroll.render_string( "Quit WITHOUT Saving",
		NUM_COLS*TILESIZE  - 150 + 20,
		NUM_ROWS * TILESIZE + 44 );

	// Quit And Save
	graphDriver->graph_draw( BMP_BALL_C2,
		NUM_COLS*TILESIZE + 60,
		NUM_ROWS * TILESIZE + 39);
	errScroll.render_string( "Quit And Save",
		NUM_COLS*TILESIZE + 80,
		NUM_ROWS * TILESIZE + 44 );
}	


void
edit_key_press_func( keysyms keyval )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : edit_key_press_func( keyval=" << (int)keyval << " )" << endl;
#endif

	switch( keyval )
	{
		case eEsc:
		case eQ:
			quit_no_save( 0, 0, 0 );
			break;
		case eEnter:
		case eSpace:
			quit_with_save( 0, 0, 0 );
			break;
		default:
			break;
	}
}

void
initial_setup( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : initial_setup( ) " <<endl;
#endif
	int index = 0;
	Ctile *tempTile;
	Cclick_area *tempArea;

	strcpy( outFileName, CURMAP->mapName );
	cerr << "FILE: " << outFileName << endl;

	// Put the menu at the topmost position
	menu_offset = 0;

	// Default the selection to the first menu tile
	selected_index = 0;

	// Clear all the click areas
	clickAreas.empty( );

	// Map area
	tempArea = new Cclick_area;
	tempArea->set_area( 
		0, 
		TOP_MAP_OFFSET, 
		NUM_COLS*TILESIZE, 
		NUM_ROWS*TILESIZE + TOP_MAP_OFFSET );
	tempArea->set_func( click_on_map );
	clickAreas.push_front( tempArea );

	// Menu Area
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE + MENU_SEP, 
		MENU_Y_OFFSET, 
		(NUM_COLS+MENU_NUM_COLS)*TILESIZE + MENU_SEP, 
		MENU_NUM_ROWS*TILESIZE + MENU_Y_OFFSET );
	tempArea->set_func( click_on_menu );
	clickAreas.push_front( tempArea );

	// Menu Up Area
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE + MENU_SEP, 
		TOP_MAP_OFFSET + SPACER, 
		(NUM_COLS+MENU_NUM_COLS)*TILESIZE,
		TOP_MAP_OFFSET + TILESIZE - SPACER );
	tempArea->set_func( click_on_menu_up );
	clickAreas.push_front( tempArea );

	// Menu Down Area
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE + MENU_SEP, 
		MENU_NUM_ROWS*TILESIZE + MENU_Y_OFFSET + SPACER, 
		(NUM_COLS + MENU_NUM_COLS)*TILESIZE + MENU_SEP,
		MENU_NUM_ROWS*TILESIZE + MENU_Y_OFFSET + TILESIZE - SPACER );
	tempArea->set_func( click_on_menu_down );
	clickAreas.push_front( tempArea );

	// Prev Level Area
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE + MENU_SEP, 
		0, 
		NUM_COLS*TILESIZE + MENU_SEP + 40, 
		40 );
	tempArea->set_func( prev_level );
	clickAreas.push_front( tempArea );

	// Next Level Area
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE + MENU_SEP + 150, 
		0, 
		NUM_COLS*TILESIZE + MENU_SEP + 150 + 40,
		40 );
	tempArea->set_func( next_level );
	clickAreas.push_front( tempArea );

	// Quit Without Saving
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE - 150,
		NUM_ROWS * TILESIZE + 39,
		NUM_COLS*TILESIZE - 150 + 18,
		NUM_ROWS * TILESIZE + 39 + 18 );
	tempArea->set_func( quit_no_save );
	clickAreas.push_front( tempArea );

	// Quit And Save
	tempArea = new Cclick_area;
	tempArea->set_area( 
		NUM_COLS*TILESIZE + 60,
		NUM_ROWS * TILESIZE + 39,
		NUM_COLS*TILESIZE + 60 + 18,
		NUM_ROWS * TILESIZE + 39 + 18);
	tempArea->set_func( quit_with_save );
	clickAreas.push_front( tempArea );

	// Teleporter Tiles
	tempTile = new Ctile_teleport( EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_teleport( EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Number of Moving Balls
	tempTile = new Ctile_moving( );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	// Map Timer Tile
	tempTile = new Ctile_timer( );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	// Next Ball Indicator
	tempTile = new Ctile_next;
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	// Spinner ORder
	tempTile = new Ctile_order;
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	// Pattern Display
	tempTile = new Ctile_pattern;
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	// Spinner
	tempTile = new Ctile_spinner;
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Blocker Tiles
	tempTile = new Ctile_blocker( C1, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C2, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C3, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C4, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C1, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C2, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C3, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C4, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C1, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C2, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C3, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blocker( C4, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Start Tiles
	tempTile = new Ctile_start( EXIT_UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_start( EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_start( EXIT_LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_start( EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Painter Tiles
	tempTile = new Ctile_painter( C1, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C2, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C3, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C4, EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C1, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C2, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C3, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C4, EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C1, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C2, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C3, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_painter( C4, EXIT_UP | EXIT_DOWN | EXIT_LEFT |
	EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Track Tiles
	tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN | EXIT_LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_UP | EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_LEFT| EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_track( EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// One Way Tiles
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT 
													| EXIT_RIGHT, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT| EXIT_RIGHT, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_RIGHT, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_RIGHT, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP, UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT
											| EXIT_RIGHT, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_RIGHT, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_RIGHT, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN, DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT
											| EXIT_RIGHT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT| EXIT_RIGHT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_LEFT| EXIT_RIGHT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_LEFT, LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_LEFT
											| EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_LEFT| EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_DOWN | EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_DOWN | EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_UP | EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_LEFT| EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_oneway( EXIT_RIGHT, RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Covered Tracks
	tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_UP | EXIT_LEFT| EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN | EXIT_LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN | EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_LEFT| EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_UP | EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_UP );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_DOWN );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_LEFT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_covered( EXIT_RIGHT );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Filler
	tempTile = new Ctile_blank( );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );
	tempTile = new Ctile_blank(  );
	tempTile->indexPos = index++;
	menuTiles.insert( menuTiles.end( ), tempTile );

	// Set the menu tile counter
	num_tiles = menuTiles.size( );

	// Load up our mapfile
	load_levels( );

	// Did we find any levels?
	if( gameLevels.size( ) == 0 )
	{
		// Add a blank level
		class Clevel_map *tMap = new Clevel_map;
		Ctile *tempTile = NULL;
		// Create the tiles
		for( int index = 0; index < NUM_COLS * NUM_ROWS; index++ )
		{
			tempTile = new Ctile_blank;
			tempTile->indexPos = index;
			tMap->tiles.insert( tMap->tiles.end( ), tempTile );
		}
		tMap->mapName = new char[7];
		strcpy( tMap->mapName, "NONAME" );
		gameLevels.insert( gameLevels.end( ), tMap );
		currentGame->currentMap = gameLevels.end( );
		currentGame->currentMap--;
	}

	// Start at the beginning
	currentGame->currentMap = gameLevels.begin( );
}

void
write_current_map( void )
{
	ofstream * ofs;
	int index = 0;

	// Open our output stream
	ofs = new ofstream( outFileName, ios::app );

	if( ofs->bad( ) )
	{
		cerr << "ERROR!  Could not open output file." << endl;
		return;
	}

	*ofs <<"\"" << CURMAP->mapName << "\" { " << endl;
	*ofs << "\tmap_time_limit 300" << endl;
	*ofs << "\tball_time_limit 60" << endl;
	*ofs << "\tball_speed 50" << endl;
	*ofs << "\tmax_moving_balls 5" << endl;
	*ofs << "\tMAP {" << endl;
	*ofs << "\t\t";
	for( index = 0; index < NUM_COLS * NUM_ROWS; index++ )
	{
		switch( CURMAP->tiles[index]->get_type( ) )
		{
		case TELEPORT:
			*ofs << "TP";
			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_UP:
				*ofs << "UP";
				break;
			case EXIT_DOWN:
				*ofs << "DN";
				break;
			case EXIT_LEFT:
				*ofs << "LT";
				break;
			case EXIT_RIGHT:
				*ofs << "RT";
				break;
			case EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HH";
				break;
			case EXIT_UP | EXIT_DOWN:
				*ofs << "VV";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT:
				*ofs << "VL";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_RIGHT:
				*ofs << "VR";
				break;
			case EXIT_UP | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HU";
				break;
			case EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HD";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HV";
				break;
			}
			break;
		case BALL_TIMER:
			*ofs << "BALL";
			break;
		case PATTERN_DISP:
			*ofs << "PATT";
			break;
		case ORDER_DISP:
			*ofs << "ORDR";
			break;
		case NEXT_DISP:
			*ofs << "NEXT";
			break;
		case TIME_DISP:
			*ofs << "LEVL";
			break;
		case MOVE_COUNTER:
			*ofs << "MOVE";
			break;
		case TRACK:
			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HHVV";
				break;
			case EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HHDD";
				break;
			case EXIT_UP | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HHUU";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT:
				*ofs << "VVLL";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_RIGHT:
				*ofs << "VVRR";
				break;
			case EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HHHH";
				break;
			case EXIT_UP | EXIT_DOWN:
				*ofs << "VVVV";
				break;
			case EXIT_DOWN:
				*ofs << "ENDD";
				break;
			case EXIT_UP:
				*ofs << "ENDU";
				break;
			case EXIT_RIGHT:
				*ofs << "ENDR";
				break;
			case EXIT_LEFT:
				*ofs << "ENDL";
				break;
			}
			break;
		case SPINNER:
			*ofs << "SPIN";
			break;
		case PAINTER:
			*ofs << "PT";
			switch( TILE_PAINTER( CURMAP->tiles[index] )->get_new_color( ) )
			{
			case C1:
				*ofs << "1";
				break;
			case C2:
				*ofs << "2";
				break;
			case C3:
				*ofs << "3";
				break;
			case C4:
				*ofs << "4";
				break;
			default:
				*ofs << "?";
				break;

			}
			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_LEFT | EXIT_RIGHT:
				*ofs << "H";
				break;
			case EXIT_UP | EXIT_DOWN:
				*ofs << "V";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "B";
				break;
			}
			break;
		case BLOCKER:
			*ofs << "BL";
			switch( TILE_BLOCKER( CURMAP->tiles[index] )->get_pass_color( ) )
			{
			case C1:
				*ofs << "1";
				break;
			case C2:
				*ofs << "2";
				break;
			case C3:
				*ofs << "3";
				break;
			case C4:
				*ofs << "4";
				break;
			default:
				*ofs << "?";
				break;
			}
			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_LEFT | EXIT_RIGHT:
				*ofs << "H";
				break;
			case EXIT_UP | EXIT_DOWN:
				*ofs << "V";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "B";
				break;
			}
			break;
		case START:
			*ofs << "STR";
			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_UP:
				*ofs << "U";
				break;
			case EXIT_DOWN:
				*ofs << "D";
				break;
			case EXIT_LEFT:
				*ofs << "L";
				break;
			case EXIT_RIGHT:
				*ofs << "R";
				break;
			}
			break;
		case ONEWAY:
			*ofs << "O";
			switch( TILE_ONEWAY( CURMAP->tiles[index] )->get_one_way_dir( ) )
			{
			case UP:
				*ofs << "U";
				break;
			case DOWN:
				*ofs << "D";
				break;
			case LEFT:
				*ofs << "L";
				break;
			case RIGHT:
				*ofs << "R";
				break;
			default:
				break;
			}

			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HV";
				break;
			case EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HD";
				break;
			case EXIT_UP | EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HU";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT:
				*ofs << "VL";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_RIGHT:
				*ofs << "VR";
				break;
			case EXIT_DOWN | EXIT_LEFT:
				*ofs << "LD";
				break;
			case EXIT_DOWN | EXIT_RIGHT:
				*ofs << "RD";
				break;
			case EXIT_UP | EXIT_LEFT:
				*ofs << "LU";
				break;
			case EXIT_UP | EXIT_RIGHT:
				*ofs << "RU";
				break;
			case EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HH";
				break;
			case EXIT_UP | EXIT_DOWN:
				*ofs << "VV";
				break;
			case EXIT_UP:
			case EXIT_DOWN:
			case EXIT_LEFT:
			case EXIT_RIGHT:
				*ofs << "ND";
				break;
			}
			break;
		case COVERED:
			*ofs << "C";
			switch( CURMAP->tiles[index]->exitFlags )
			{
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
				*ofs << "HVV";
				break;
			case EXIT_DOWN | EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HDD";
				break;
			case EXIT_UP | EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HUU";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_LEFT:
				*ofs << "VLL";
				break;
			case EXIT_UP | EXIT_DOWN | EXIT_RIGHT:
				*ofs << "VRR";
				break;
			case EXIT_DOWN | EXIT_LEFT:
				*ofs << "DLL";
				break;
			case EXIT_DOWN | EXIT_RIGHT:
				*ofs << "DRR";
				break;
			case EXIT_UP | EXIT_LEFT:
				*ofs << "ULL";
				break;
			case EXIT_UP | EXIT_RIGHT:
				*ofs << "URR";
				break;
			case EXIT_LEFT| EXIT_RIGHT:
				*ofs << "HHH";
				break;
			case EXIT_UP | EXIT_DOWN:
				*ofs << "VVV";
				break;
			case EXIT_DOWN:
				*ofs << "NDD";
				break;
			case EXIT_UP:
				*ofs << "UDU";
				break;
			case EXIT_RIGHT:
				*ofs << "NDR";
				break;
			case EXIT_LEFT:
				*ofs << "NDL";
				break;
			}
			break;
		case BLANK_TILE:
			*ofs << "BLNK";
			break;
		default:
			*ofs << "   ";
			break;
		}
		*ofs << " ";
		if( index % NUM_COLS == (NUM_COLS - 1) )
		{
			*ofs << endl;
			*ofs << "\t\t";
		}
	}
	*ofs << endl;
	*ofs << "\t}" << endl;
	*ofs << "}" << endl;

	// Close the stream
	ofs->close( );
}

void
load_levels( void )
{
	class Clevel_map *tMap;
	char *singleMap = (char *)1;

	// clear the levels
	gameLevels.clear( );

	while( singleMap != NULL )
	{
		singleMap = get_next_file_map( );

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
			}
		}
	}
}

// $Id: mapedit.cpp,v 1.2 2001/02/16 20:59:57 tom Exp $
//
// $Log: mapedit.cpp,v $
// Revision 1.2  2001/02/16 20:59:57  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:29  brown
// Working toward Windows integration
//
// Revision 1.7  2000/11/09 22:06:34  tom
// cleaned up compiler warnings
//
// Revision 1.6  2000/10/08 18:23:10  brown
// Fixed the editor crash when the level file didn't exist
// Added help menu
//
// Revision 1.5  2000/10/08 16:07:29  tom
// fixed some little annoyances
//
// Revision 1.4  2000/10/08 02:53:48  brown
// Fixed the level editor and some graphics
//
// Revision 1.3  2000/10/06 19:29:07  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 19:28:01  tom
// - removed all references to CFont
// - fixed password entry menu item
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.20  1999/12/27 03:38:02  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.19  1999/12/25 08:18:37  tom
// Added "Id" and "Log" CVS keywords to source code.
//
