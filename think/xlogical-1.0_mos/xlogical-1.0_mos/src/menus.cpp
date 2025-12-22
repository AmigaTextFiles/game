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

#include <cstdio>
#include <iostream>
#include "audio.h"
#include "exception.h"
#include "gamelogic.h"
#include "globals.h"
#include "menubase.h"
#include "menuentry.h"
#include "menulabel.h"
#include "menus.h"
#include "menuslider.h"
#include "menutext.h"
#include "menuvertical.h"
#include "music_files.h"
#if 0
#include "plugins.h"
#endif
#include "properties.h"

static CMenuText *  gRestartMenuItem	= NULL;
static CMenuBase *	gGameMenu			= NULL;
static CMenuBase *	gIntermissionMenu	= NULL;
static CMenuBase *	gMainMenu			= NULL;
#if 0
static CPlugins *	plugins				= NULL;
#endif

class CMenuMusic: public CMenuSlider
{
public:
	CMenuMusic( float aVal ) : CMenuSlider( aVal, "MUSIC VOLUME" ) {};
	virtual ~CMenuMusic( void ) {};

	void Selected( void );
};

class CMenuSound: public CMenuSlider
{
public:
	CMenuSound( float aVal ) : CMenuSlider( aVal, "SOUND VOLUME" ) {};
	virtual ~CMenuSound( void ) {};

	void Selected( void );
};

class CMenuPassword: public CMenuEntry
{
public:
	CMenuPassword( void ) : CMenuEntry( 5 ) {};
	virtual ~CMenuPassword( void ) {};

	void Selected( void );

};

class CMenuRestart: public CMenuText
{
public:
	CMenuRestart( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuRestart( void ) {};

	void Selected( void );
};

class CMenuMainHelp: public CMenuText
{
public:
	CMenuMainHelp( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuMainHelp( void ) {};

	void Selected( void );
};

class CMenuGameHelp: public CMenuText
{
public:
	CMenuGameHelp( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuGameHelp( void ) {};

	void Selected( void );
};

class CMenuVideoMode: public CMenuText
{
public:
	CMenuVideoMode( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuVideoMode( void ) {};

	void Selected( void );
};

class CMenuEraseScores: public CMenuText
{
public:
	CMenuEraseScores( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuEraseScores( void ) {};

	void Selected( void );
};

class CMenuStart: public CMenuText
{
public:
	CMenuStart( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuStart( void ) {};

	void Selected( void );
};

class CMenuAbout: public CMenuText
{
public:
	CMenuAbout( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuAbout( void ) {};

	void Selected( void );
};

class CMenuScores: public CMenuText
{
public:
	CMenuScores( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuScores( void ) {};

	void Selected( void );
};

class CMenuMain: public CMenuText
{
public:
	CMenuMain( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuMain( void ) {};

	void Selected( void );
};

class CMenuCancel: public CMenuText
{
public:
	CMenuCancel( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuCancel( void ) {};

	void Selected( void );
};

class CMenuLoadPlugin: public CMenuVertical
{
public:
	CMenuLoadPlugin( const string &aString ) : CMenuVertical( aString ) {};
	virtual ~CMenuLoadPlugin( void ) {};

	void Selected( void );
};

class CMenuQuit: public CMenuText
{
public:
	CMenuQuit( const string &aString ) : CMenuText( aString ) {};
	virtual ~CMenuQuit( void ) {};

	void Selected( void );
};

#if 0
CMenuBase *
build_plugins( void )
{
	if (!plugins)
	{
		plugins = new CPlugins( "." );
	}
	CMenuBase *pluginMenu = new CMenuVertical( "PLUGINS" );

	CPlugins::Plugins p = plugins->GetPlugins();

	for( CPlugins::Plugins::iterator i=p.begin(); i!=p.end(); ++i )
	{
		CMenuBase *load = new CMenuLoadPlugin( *i );
		pluginMenu->AddChild( load );
		load->AddChild( new CMenuCancel( "PLUGIN ERROR" ) );
	}
	pluginMenu->AddChild( new CMenuCancel( "RETURN TO OPTIONS" ) );

	return( pluginMenu );
}
#endif

CMenuBase *
build_passwd_menu( void )
{
	CMenuBase *passwdError = new CMenuVertical( "ERROR" );
	passwdError->AddChild( new CMenuCancel( "LEVEL NOT FOUND" ) );

	CMenuBase *passwdEntry = new CMenuPassword();
	passwdEntry->AddChild( passwdError );

	CMenuBase *passwdMenu = new CMenuVertical( "PASSWORD" );
	passwdMenu->AddChild( new CMenuLabel( "ENTER PASSWORD" ) );
	passwdMenu->AddChild( passwdEntry );

	return( passwdMenu );
}

CMenuBase *
build_main_options( void )
{
	CMenuBase *scores = NULL;
	if (properties::instance().get( "game.mode" ) == "custom")
	{
		scores = new CMenuVertical( "RESET HIGH SCORES" );
		scores->AddChild( new CMenuEraseScores( "ERASE AWAY" ) );
		scores->AddChild( new CMenuCancel( "CANCEL" ) );
	}

	CMenuBase *options = new CMenuVertical( "OPTIONS" );
	options->AddChild( new CMenuMusic( audioDriver->set_music_volume( -1 ) ) );
	options->AddChild( new CMenuSound( audioDriver->set_sound_volume( -1 ) ) );
	options->AddChild( new CMenuVideoMode(
		properties::instance().get( "video.mode" ) ) );
	//options->AddChild( build_plugins() );
	if (scores)
	{
		options->AddChild( scores );
	}
	options->AddChild( new CMenuCancel( "RETURN TO MAIN" ) );

	return( options );
}

CMenuBase *
build_game_options( void )
{
	CMenuBase *options = new CMenuVertical( "OPTIONS" );
	options->AddChild( new CMenuMusic( audioDriver->set_music_volume( -1 ) ) );
	options->AddChild( new CMenuSound( audioDriver->set_sound_volume( -1 ) ) );
	options->AddChild( new CMenuVideoMode(
		properties::instance().get( "video.mode" ) ) );
	//options->AddChild( build_plugins() );
	options->AddChild( new CMenuCancel( "RETURN TO MAIN" ) );

	return( options );
}

CMenuBase *
get_game_menu( void )
{
	if (!gGameMenu)
	{
		CMenuBase *quit = new CMenuVertical( "QUIT" );
		quit->AddChild( new CMenuMain( "MAIN MENU" ) );
		quit->AddChild( new CMenuCancel( "CANCEL" ) );

		gGameMenu = new CMenuVertical( "MAIN MENU" );
		gGameMenu->AddChild( new CMenuCancel( "RESUME GAME" ) );
		gRestartMenuItem = new CMenuRestart( "RESTART LEVEL" );
		gGameMenu->AddChild( gRestartMenuItem );
		gGameMenu->AddChild( build_passwd_menu() );
		gGameMenu->AddChild( build_game_options() );
		gGameMenu->AddChild( new CMenuGameHelp( "HELP" ) );
		gGameMenu->AddChild( quit );
	}
	if (currentGame->livesLeft <= 1)
	{
		gRestartMenuItem->SetText( "End Game" );
	} else {
		gRestartMenuItem->SetText( "Restart Level" );
	}

	return( gGameMenu );
}

CMenuBase *
get_intermission_menu( void )
{
	if (!gIntermissionMenu)
	{
		gIntermissionMenu = new CMenuVertical( "INTERMISSION MENU" );
		gIntermissionMenu->AddChild( new CMenuMain( "MAIN MENU" ) );
		gIntermissionMenu->AddChild( new CMenuCancel( "CANCEL" ) );
	}
	return( gIntermissionMenu );
}

CMenuBase *
get_main_menu( void )
{
	if (!gMainMenu)
	{
		CMenuBase *quit = new CMenuVertical( "QUIT" );
		quit->AddChild( new CMenuQuit( "EXIT TO SYSTEM" ) );
		quit->AddChild( new CMenuCancel( "CANCEL" ) );

		gMainMenu = new CMenuVertical( "MAIN MENU" );
		gMainMenu->AddChild( new CMenuStart( "START GAME" ) );
		gMainMenu->AddChild( build_passwd_menu() );
		gMainMenu->AddChild( build_main_options() );
		gMainMenu->AddChild( new CMenuScores( "HIGH SCORES" ) );
		gMainMenu->AddChild( new CMenuMainHelp( "HELP" ) );
		gMainMenu->AddChild( new CMenuAbout( "ABOUT" ) );
		gMainMenu->AddChild( quit );
	}

	return( gMainMenu );
}

void
CMenuCancel::Selected( void )
{
	CMenuBase *mgr;

	if (fParent && (mgr = fParent->ParentManager()))
	{
		mgr->Start( 
			graphDriver->graph_main_width(), 
			graphDriver->graph_main_height() );
	} else {
		if (gTop == get_main_menu())
		{
			switch_to_intro();
		} else
		if (gTop == get_intermission_menu())
		{
			switch_to_intermission_no_music_change();
		} else {
			switch_to_playing_no_music_change();
		}
	}
}

void
CMenuEraseScores::Selected( void )
{
	CMenuBase *mgr;

	currentGame->reset_hiscores();
	if (fParent && (mgr = fParent->ParentManager()))
	{
		mgr->Start( 
			graphDriver->graph_main_width(), 
			graphDriver->graph_main_height() );
	} 
}

#if 0
void
CMenuLoadPlugin::Selected( void )
{
	try
	{
		plugins->Load( fText );
	}
	CatchEx( &ex )
	{
		// show the plugin error sub menu since we caught an exception
		CMenuVertical::Selected();
	}
}
#endif

void
CMenuMain::Selected( void )
{
	audioDriver->play_music( musicFiles[MUSIC_INTRO] );

	// Reset the game
	currentGame->currentMap = gameLevels.begin( );
	CURMAP->reset();
	currentGame->gameState = GAME_OVER;
	currentGame->reset_game( );

	get_main_menu()->Start( 
		graphDriver->graph_main_width(), 
		graphDriver->graph_main_height(),
		start_draw_map,
		switch_to_intro_no_music_change );
}

void
CMenuQuit::Selected( void )
{
	clean_exit();
}

void
CMenuStart::Selected( void )
{
	CURMAP->reset();

	currentGame->gameState = MAP_START;
	currentGame->reset_game();
	switch_to_intermission();
}

void
CMenuAbout::Selected( void )
{
	currentGame->gameState = ABOUT;

	// Clear the screen to black
	graphDriver->graph_clear_rect(
		0, 0,
		graphDriver->graph_main_width(),
		graphDriver->graph_main_height() );

	switch_to_intermission_no_music_change();
}

void
CMenuScores::Selected( void )
{
	CURMAP->reset();

	currentGame->gameState = HIGH_SCORES;
	switch_to_high_scores();
}

void
CMenuRestart::Selected( void )
{
	CURMAP->reset();

	// Decrement the ball count and act appropriately
	if( --currentGame->livesLeft <= 0 )
	{
		switch_to_intermission_no_music_change();
		switch_to_game_over();
	} else {
		currentGame->gameState = MAP_START;
		switch_to_intermission();
	}
}

void
CMenuPassword::Selected( void )
{
#if DEBUG & 2
	cerr << "password=[" << fText << "]" << endl;
#endif

	list< class Clevel_map * >::iterator i;
	bool found = false;
	char *cryptName;

#if DEBUG & 2
	cerr <<"Player name is '" <<  currentGame->playerName << "'" << endl;
#endif

	for( i=gameLevels.begin(); i!=gameLevels.end(); ++i )
	{

		if ( (*i)->mapName != NULL )
		{
			// Get the encrypted level name
			cryptName = encrypt( (*i)->mapName, currentGame->encryptName ) ;

#if DEBUG & 2
			cerr	<< "Comparing " << fText.c_str( )
					<< " with " << cryptName << endl;
#endif
			// See if it matches what we typed in
			if( strcasecmp( fText.c_str(), cryptName ) == 0 )
			{
				found = true;
				break;
			}

			// Free our space
			delete [] cryptName;
		}
	}
	if (found)
	{
		Reset();
		currentGame->currentMap = i;
		CURMAP->reset();

		// Go to the start_map screen
		currentGame->gameState = MAP_START;
		currentGame->reset_game();
		switch_to_intermission();

	} else {
#if DEBUG & 2
		cerr << "level not found" << endl;
#endif
		ChildManager()->Start(
			graphDriver->graph_main_width(), 
			graphDriver->graph_main_height(),
			start_draw_map );
	}
}

void
CMenuMainHelp::Selected( void )
{
	currentGame->gameState = HELP_MAIN;
	switch_to_intermission_no_music_change();
}

void
CMenuGameHelp::Selected( void )
{
	currentGame->gameState = HELP_GAME;
	switch_to_intermission_no_music_change();
}

void
CMenuVideoMode::Selected( void )
{
	if (fText == "windowed")
	{
		SetText( "fullscreen" );
		properties::instance().put( "video.mode", "fullscreen" );
	} else {
		SetText( "windowed" );
		properties::instance().put( "video.mode", "windowed" );
	}
	graphDriver->graph_reload();
}

void
CMenuMusic::Selected( void )
{
	audioDriver->set_music_volume( GetValue() );
	char volume[20];
	sprintf( volume, "%f", GetValue() );
	properties::instance().put( "music.volume", volume );
}

void
CMenuSound::Selected( void )
{
	audioDriver->set_sound_volume( GetValue() );
	char volume[20];
	sprintf( volume, "%f", GetValue() );
	properties::instance().put( "sound.volume", volume );
}

// $Id: menus.cpp,v 1.5 2001/02/19 03:03:54 tom Exp $
//
// $Log: menus.cpp,v $
// Revision 1.5  2001/02/19 03:03:54  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.4  2001/02/18 09:04:15  tom
// - changed background tile to be a background jpg image
// - added prompt for user name when high score achieved
// - moved finding user defined in game music to load phase so that game
//   screen comes up faster when a large number of user defined dirs exist
// - fixed a bug on "RESTART LEVEL" menu item where it would take you to the
//   intermission screen but as soon as game play started, it was "GAME OVER".
//   The menu item now changes to "END GAME" if no lives are left.
//
// Revision 1.3  2001/02/17 07:18:23  tom
// got xlogical working in windows finally - with the following limitations:
// - music is broken (disabled in this checkin)
// - no user specified mod directories for in game music
// - high scores will be saved as user "nobody"
//
// Revision 1.2  2001/02/16 21:00:00  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:30  brown
// Working toward Windows integration
//
// Revision 1.15  2000/12/26 21:34:43  tom
// implemented switching the video mode on the fly.
//
// Revision 1.14  2000/10/08 19:12:58  tom
// fixed help screen
//
// Revision 1.13  2000/10/08 16:28:32  tom
// added help menu item
//
// Revision 1.12  2000/10/08 06:33:56  tom
// added video mode menu option
//
// Revision 1.11  2000/10/07 21:48:09  tom
// fixed a bug where volume properties were not updated when they were changed
//
// Revision 1.10  2000/10/07 17:27:21  tom
// If game.mode is custom, user can erase high scores.  Otherwise the option
// is not available.
//
// Revision 1.9  2000/10/07 04:00:14  tom
// removed reset high score menu option (root can do this by deleting the
// file if he/she wants - but regular users shouldn't be able to do this)
//
// Revision 1.8  2000/10/06 19:29:10  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.7  2000/10/02 06:00:00  tom
// fixed some remaining refresh and music restart bugs
//
// Revision 1.6  2000/10/01 22:16:25  tom
// added about screen
//
// Revision 1.5  2000/10/01 21:41:43  tom
// fixed refresh flickering during transitions
//
// Revision 1.4  2000/10/01 21:29:22  tom
// fixed music restarting in the intermission screens when you enter/exit
// the menu repeatedly
//
// Revision 1.3  2000/10/01 17:11:34  tom
// fixed some of the menu redrawing bugs
//
// Revision 1.2  2000/10/01 05:00:25  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.29  2000/07/23 18:29:52  brown
// Fixed problem where quitting the current level didn't reset levels to the
// beginning
//
// Revision 1.28  2000/02/13 07:32:47  tom
// Moved writing of high score file into clean_exit()
//
// Revision 1.27  2000/02/13 00:16:46  tom
// Made title screen pop up menu when mouse is clicked, implemented reset high
// score menu item.
//
// Revision 1.26  2000/02/12 23:47:09  tom
// Fixed writing of hiscore file.
//
// Revision 1.25  2000/02/12 23:12:09  tom
// Put cerr statement between #if DEBUG directive...
//
// Revision 1.24  2000/02/12 22:54:54  tom
// Did a bunch of menu fixing up... and got rid of menu stuff in graph_gtk.
//
// Revision 1.23  2000/02/12 20:38:36  tom
// Fixed up
//
// Revision 1.22  2000/01/23 09:04:35  tom
// - made threaded sound loop conditionally compiled (now disabled by default)
//
// Revision 1.21  2000/01/23 06:11:39  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.20  2000/01/10 02:53:49  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.19  2000/01/09 02:26:17  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.18  2000/01/05 03:47:34  brown
// Fixed some endgame stuff, scrollers, and hi-score menu entry goodies
//
// Revision 1.17  1999/12/28 23:50:38  tom
// Fixed some menu refresh bugs.
//
// Revision 1.16  1999/12/28 22:53:39  tom
// Fixed level warp and menu refresh bug.
//
// Revision 1.15  1999/12/28 22:25:54  tom
// - added levels 36-59.
// - added map warp using password
//
// Revision 1.14  1999/12/28 08:58:19  tom
// Whoops.. fixed this to show start background again.
//
// Revision 1.13  1999/12/28 07:36:23  tom
// Fixed menu refresh problems.
//
// Revision 1.12  1999/12/25 08:18:38  tom
// Added "Id" and "Log" CVS keywords to source code.
//
