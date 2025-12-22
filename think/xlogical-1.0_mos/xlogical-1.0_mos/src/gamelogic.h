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



#ifndef GAME_H
#define GAME_H

// Language Includes
#include <ctime>
#include <string>
#include <vector>

#ifdef WIN32
using namespace std;
#endif

// Application Includes
#include "defs.h"
#include "graph.h"
#include "levelmap.h"

// state switching routines
void switch_to_game_over( void );
void switch_to_high_scores( void );
void switch_to_intro( void );
void switch_to_intro_no_music_change( void );
void switch_to_intermission( void );
void switch_to_intermission_no_music_change( void );
void switch_to_playing( void );
void switch_to_playing_no_music_change( void );

// The game loop functions while playing
void play_click_func(				int, int, int );
void play_loop_func(				void );
void play_key_press_func(			keysyms );
void play_draw_map(					void );

// The game loop functions while in the start menu
void start_click_func(				int, int, int );
void start_loop_func(				void );
void start_key_press_func(			keysyms );
void start_draw_map(				void );
void full_refresh(                  void );
void reload_func(                   void );

// The game loop functions while between levels
void intermission_click_func(		int, int, int );
void intermission_loop_func(		void );
void intermission_key_press_func(	keysyms );
void intermission_draw_screen(		void );

// audio callbacks
void init_in_game_music();
void music_finished();

void add_new_ball(					void );
char *encrypt( 						char *, char * );

long			get_cksum(				char * );
char *			encrypt(				char *, char * );
char *			get_next_builtin_map(	char * );
char * 			get_next_file_map(		void );
Clevel_map *	load_a_level(			char * );
dir_t 			exit_to_dir( 			unsigned long );

#define NUM_HI_SCORES 10
#define HISCOREFILE "xlogical.scores"

class Cgame
{
public:
	list< class Clevel_map *>::iterator currentMap;
	char *			playerName;
	char *			encryptName;
	char *			levelFile;
	int				gameState;
	ulong			   score;
	long			   bonus;
	int				livesLeft;
	bool           warningPlayed;
	typedef struct {
		string		name;
		ulong		score;
	} hiscores_t;
	hiscores_t hiscores[NUM_HI_SCORES];

	Cgame(			const char * );
	virtual ~Cgame( void );
	bool is_hiscore( void );
	void read_hiscores( void );
	void write_hiscores( void );
	void reset_hiscores( void );
	void update_hiscores( void );
	void reset_game( void );
};

extern ulong gMenuEntryTime;
extern Cgame *currentGame;
extern list< class Clevel_map * >gameLevels;
extern list< class Canim *> animList;

#define START_BALLS 3

enum playStates {
		STARTUP = 0,
		MENU,
		PLAYING,
		BALL_TIMEOUT,
		MAP_TIMEOUT,
		MAP_START,
		MAP_COMPLETE,
		FINISH_WAIT,
		WON,
		GAME_OVER,
		HIGH_SCORES,
		ABOUT,
		HELP_MAIN,
		HELP_GAME,
		SHUTDOWN
};

enum titleStates {
	PRE_LOADING = 0,
	LOADING_BUILTIN,
	LOADING_FILE,
	POST_LOADING
};

#endif
// $Id: gamelogic.h,v 1.18 2001/07/31 20:54:54 tom Exp $
//
// $Log: gamelogic.h,v $
// Revision 1.18  2001/07/31 20:54:54  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.17  2001/03/15 09:40:11  tom
// added reload_func prototype
//
// Revision 1.16  2001/02/18 09:04:15  tom
// - changed background tile to be a background jpg image
// - added prompt for user name when high score achieved
// - moved finding user defined in game music to load phase so that game
//   screen comes up faster when a large number of user defined dirs exist
// - fixed a bug on "RESTART LEVEL" menu item where it would take you to the
//   intermission screen but as soon as game play started, it was "GAME OVER".
//   The menu item now changes to "END GAME" if no lives are left.
//
// Revision 1.15  2001/02/16 20:59:55  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.14  2001/01/20 17:32:27  brown
// Working toward Windows integration
//
// Revision 1.13  2000/11/07 07:40:21  tom
// fixed infinite negative bonus bug
//
// Revision 1.12  2000/10/08 19:12:57  tom
// fixed help screen
//
// Revision 1.11  2000/10/08 16:51:42  tom
// added HELP state
//
// Revision 1.10  2000/10/08 16:45:57  tom
// added time warning sound
//
// Revision 1.9  2000/10/08 02:53:48  brown
// Fixed the level editor and some graphics
//
// Revision 1.8  2000/10/07 05:41:19  tom
// made hi-score file a hard coded absolute path
//
// Revision 1.7  2000/10/06 19:29:05  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.6  2000/10/01 22:16:25  tom
// added about screen
//
// Revision 1.5  2000/10/01 21:29:22  tom
// fixed music restarting in the intermission screens when you enter/exit
// the menu repeatedly
//
// Revision 1.4  2000/10/01 18:41:34  tom
// fixed music starting over when returning from menu
//
// Revision 1.3  2000/10/01 08:08:14  tom
// finished implementing the SDL_mixer audio driver
//
// Revision 1.2  2000/10/01 05:00:24  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.27  2000/07/23 16:50:28  brown
// Fixed level timer changing while paused
// Added "finish spinner" animation
// Fixed level ending before last spinner finished ( sortof )
//
// Revision 1.26  2000/04/17 21:29:54  tom
// Fixed core dumps and music & sound playing problems.  (xlogical now
// requires libmikmod 3.1.9)
//
// Revision 1.25  2000/02/12 20:38:34  tom
// Fixed up
//
// Revision 1.24  2000/01/23 09:04:32  tom
// - made threaded sound loop conditionally compiled (now disabled by default)
//
// Revision 1.23  2000/01/23 06:11:37  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.22  2000/01/22 19:35:28  brown
// High score changes etc.
//
// Revision 1.21  2000/01/10 02:53:48  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.20  2000/01/09 02:26:16  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.19  2000/01/05 03:47:33  brown
// Fixed some endgame stuff, scrollers, and hi-score menu entry goodies
//
// Revision 1.18  2000/01/01 21:51:19  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.17  1999/12/28 07:36:21  tom
// Fixed menu refresh problems.
//
// Revision 1.16  1999/12/25 08:18:33  tom
// Added "Id" and "Log" CVS keywords to source code.
//
