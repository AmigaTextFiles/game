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



#ifndef TILES_H
#define TILES_H

// Language Includes
#include <vector>
#include <list>

#ifdef WIN32
using namespace std;
#endif

// Application Includes
#include "defs.h"
#include "ball.h"
#include "anim.h"

// Some quick and easy typecast crap
#define TILE_BLANK(x)	((Ctile_blank*)(x))
#define TILE_BLOCKER(x)	((Ctile_blocker*)(x))
#define TILE_COVERED(x)	((Ctile_covered*)(x))
#define TILE_MOVING(x)	((Ctile_moving*)(x))
#define TILE_NEXT(x)	((Ctile_next*)(x))
#define TILE_ONEWAY(x)	((Ctile_oneway*)(x))
#define TILE_ORDER(x)	((Ctile_order*)(x))
#define TILE_PAINTER(x)	((Ctile_painter*)(x))
#define TILE_PATTERN(x)	((Ctile_pattern*)(x))
#define TILE_SPINNER(x)	((Ctile_spinner*)(x))
#define TILE_START(x)	((Ctile_start*)(x))
#define TILE_TELEPORT(x)((Ctile_teleport*)(x))
#define TILE_TIMER(x)	((Ctile_timer*)(x))
#define TILE_TRACK(x)	((Ctile_track*)(x))

class Ctile_base
{
public:
	// Process balls on a tile.
	virtual void move_balls(	void ) = 0;
	// Perform any updates you need for an animation step.  
	virtual void anim_loop(		void ) = 0;
	// What to do when we get a mouseclick
	virtual void click_func(	int, int, int ) = 0;
	// Draw bottom layer of "stuff"
	virtual void draw_under(	int, int ) = 0;
	// Draw balls on this tile
	virtual void draw_balls(	int, int ) = 0;
	// Draw anything that needs to be drawn over balls
	virtual void draw_over(		int, int ) = 0;
	// Return the type of object you are
	virtual tile_t get_type(	void ) = 0;
};

class Ctile : public Ctile_base
{
public:
	// Balls currently on this tile
	list< Cball * > balls;

	// Add a ball to this tile
	int add_ball( Cball *, dir_t, int ) ; // ball is moving dir, int = offset

	// Pass a ball to another tile
	int pass_ball( Cball *, dir_t, int ); // Direction = dir. ball is moving
											// int is dist. into next tile

	// These are undefined until the map is fully parsed
	// Returns the type of tile
	Ctile * get_tile( dir_t );
	// Tile's row
	int get_row( void );
	// Tile's column
	int get_col( void );

	// Recursive start path setting code
	void set_start_path( dir_t );

	// Return our start_path status
	int is_start_path( void );

	// Draw the correct track image based on exit flags
	void draw_exit_tracks( int, int );

	// Simple generic ball drawing function
	void simple_draw_balls( int, int );

	// Check if there's a spinner in the passed direction
	// and whether or not we have an exit in that direction as well
	int check_available_spinner( int );

	// Where are the track exits from this tile?
	unsigned long exitFlags;

	// Draw the darkening stuff for the start track
	void draw_start_background( int, int );

	// Our index position
	int indexPos;

	// Are we on the start path?
	int startPath;

	Ctile( void );
	virtual ~Ctile( void );
};

class Ctile_blank : public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void )			{ return; }
	void draw_under(		int, int );
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int )		{ return; }
	tile_t get_type( 		void )			{ return( BLANK_TILE ); }
	Ctile_blank(			void );
	virtual ~Ctile_blank(	void );
};

class Ctile_pattern :  public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void )			{ return; }
	void draw_under(		int, int );
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( PATTERN_DISP ); }
	Ctile_pattern(			void );
	virtual ~Ctile_pattern(	void );
};

class Ctile_order :  public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void );
	void draw_under(		int, int );
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( ORDER_DISP ); }
	Ctile_order(			void );
	virtual ~Ctile_order(	void );
};

class Ctile_next :  public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void )			{ return; }
	void draw_under(		int, int );
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( NEXT_DISP ); }
	Ctile_next(				void );
	virtual ~Ctile_next(	void );
};

class Ctile_timer :  public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void )			{ return; }
	void draw_under(		int, int );
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( TIME_DISP ); }
	Ctile_timer(			void );
	virtual ~Ctile_timer(	void );
};

class Ctile_moving :  public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void );
	void draw_under(		int, int )		{ return; }
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( MOVE_COUNTER ); }
	Ctile_moving(			void );
	virtual ~Ctile_moving(	void );
};

class Ctile_track :  public Ctile
{
public:
	void click_func(		int, int, int ) { return; }
	void move_balls(		void );
	void anim_loop(			void )			{ return; }
	void draw_under(		int, int );
	void draw_balls(		int, int );
	void draw_over(			int, int );
	void set_image(			unsigned long );
	tile_t get_type(	 	void )			{ return( TRACK ); }
	int move_a_ball( 		Cball & );
	Ctile_track(			void );
	Ctile_track(			unsigned long );
	virtual ~Ctile_track(	void );
private:
	float check_move_up(	Cball &, float &, float & );
	float check_move_down(	Cball &, float &, float & );
	float check_move_left(	Cball &, float &, float & );
	float check_move_right( Cball &, float &, float & );
};

class Ctile_spinner:  public Ctile
{
public:
	void move_balls(		void )			{ return; }
	void click_func(		int, int, int );
	void anim_loop(			void );
	void draw_under(		int, int )		{ return; }
	void draw_balls(		int, int )		{ return; }
	void draw_over(			int, int );
	tile_t get_type( 		void )			{ return( SPINNER ); }
	int is_moving( 			void )			{ return( moving ); }
	int is_finishing(		void )			{ return( finishing ); }
	Cball *check_hopper(	dir_t );
	int check_complete(		void );
	void try_eject(		 	dir_t );

	// Which balls are in which hopper
	//   0
	// 3   1
	//   2
	Cball *hopper[4];

	// Have we finished the spinner
	int finished;

	// Is this spinner spinning?
	int moving;

	// Are we in the process of finishing this guy?
	int finishing;

	// Which hopper animation are we drawing?
	int finishing_hopper;

	// Anim class to handle spin animation
	anim anim_frames;

	// Frames for the "finishing" animation
	anim finish_frames;

	Ctile_spinner( 			void );
	virtual ~Ctile_spinner( void );
private:

	// To flash the light
	int flashOn;
	int flashWait;
	void flash_light( 		void );
};

class Ctile_painter :  public Ctile
{ 
public:
	void move_balls(		void );
	void click_func(		int, int, int ) { return; };
	void anim_loop(			void )			{ return; };
	void draw_under(		int, int );
	void draw_balls(		int, int );
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( PAINTER ); }
	color_t get_new_color(	void )			{ return( newColor ); }
	Ctile_painter(			void );
	Ctile_painter(			color_t, int );
	virtual ~Ctile_painter( void );
private:
	color_t newColor;
};

class Ctile_teleport :  public Ctile
{ 
public:
	void move_balls(		void );
	void click_func(		int, int, int ) { return; };
	void anim_loop(			void )			{ return; };
	void draw_under(		int, int );
	void draw_balls(		int, int );
	void draw_over(			int, int );
	tile_t get_type(		void )			{ return( TELEPORT ); }
	Ctile_teleport(			void );
	Ctile_teleport(			int );
	virtual ~Ctile_teleport(void );
private:
};

class Ctile_blocker :  public Ctile
{
public:
	void move_balls(		void );
	void click_func(		int, int, int ) { return; }
	void anim_loop(			void )			{ return; }
	void draw_under(		int, int );
	void draw_balls(		int, int );
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( BLOCKER ); }
	color_t get_pass_color(	void )			{ return( passColor ); }
	Ctile_blocker( 			void );
	Ctile_blocker( color_t, int );
	virtual ~Ctile_blocker( void );
private:
	color_t passColor;
};

class Ctile_start :  public Ctile
{
public:
	void click_func(		int, int, int ) { return; }
	void move_balls(		void );
	void anim_loop(			void );
	void draw_under(		int, int );
	void draw_balls(		int, int );
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( START ); }
	Ctile_start(			void );
	Ctile_start(			unsigned long );
	virtual ~Ctile_start(	void );
private:
	int startImage;
};

class Ctile_oneway :  public Ctile_track
{
public:
	void move_balls(		void );
	void draw_over(			int, int );
	dir_t get_one_way_dir(	void )			{ return( oneWayDir ); }
	tile_t get_type(	 	void )			{ return( ONEWAY ); }
	Ctile_oneway(			void );
	Ctile_oneway(			unsigned long, dir_t );
	virtual ~Ctile_oneway(	void );
private:
	dir_t oneWayDir;
};

class Ctile_covered :  public Ctile_track
{
public:
	void draw_over(			int, int );
	tile_t get_type(	 	void )			{ return( COVERED ); }
	Ctile_covered(			void );
	Ctile_covered(			unsigned long );
	virtual ~Ctile_covered( void );
private:
};


#endif
// $Id: tiles.h,v 1.5 2001/02/16 21:00:11 tom Exp $
//
// $Log: tiles.h,v $
// Revision 1.5  2001/02/16 21:00:11  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2001/01/20 17:32:37  brown
// Working toward Windows integration
//
// Revision 1.3  2000/10/08 02:53:49  brown
// Fixed the level editor and some graphics
//
// Revision 1.2  2000/10/06 19:29:13  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.20  2000/07/23 16:50:33  brown
// Fixed level timer changing while paused
// Added "finish spinner" animation
// Fixed level ending before last spinner finished ( sortof )
//
// Revision 1.19  2000/02/21 23:06:37  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.18  2000/01/10 02:53:51  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.17  2000/01/01 21:51:22  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.16  1999/12/27 03:38:03  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.15  1999/12/25 08:18:41  tom
// Added "Id" and "Log" CVS keywords to source code.
//
