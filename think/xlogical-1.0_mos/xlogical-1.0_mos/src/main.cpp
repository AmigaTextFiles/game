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



// language includes
#include <iostream>
#include <stdlib.h>

#ifdef WIN32
#include <ctime>
#else
#include <sys/time.h>
#include <unistd.h>
#endif

// Application Includes
#include "exception.h"
#include "gamelogic.h"
#include "globals.h"
#include "levelmap.h"
#include "mapedit.h"
#include "music_files.h"
#include "properties.h"
#include "sdl_audio.h"
#include "sdl_graph.h"
#include "sound_files.h"

//#define DEBUG_FUNC

Caudio *    audioDriver     = NULL;         // our audio driver
Cgame *     currentGame     = NULL;         // a class for our current game
Cgraph *    graphDriver     = NULL;         // our graphics driver
list< class Clevel_map * >gameLevels;       // a place to store our current levels
properties *	gProps	= NULL;

void
usage()
{
	cout << PACKAGE " " VERSION " Copyright (C) 2000 Neil Brown, Tom Warkentin" << endl;
	cout << "Released under the Gnu General Public License Version 2, June 1991" << endl;
	cout << endl;
	cout << "Usage: xlogical [<property1=value1> <property2=value2> ... ]" << endl;
	cout << endl;
	cout << "Some useful properties are:" << endl;
	cout << endl;
	cout << "game.mode=editor|custom|default" << endl;
	cout << "game.levels=<path_to_xlogical_levels_file>" << endl;
	cout << "audio.enabled=0|1                           0=off, 1=on" << endl;
	cout << "audio.channels=1|2                          1=mono, 2=stereo" << endl;
	cout << "audio.frequency=<frequency>                 e.g. 11025, 22050, 44100" << endl;
	cout << "audio.chunksize=<size_of_audio_buffer>      NOTE: must be a power of two" << endl;
	cout << "music.volume=<music_volume>                 NOTE: must be between 0.0 and 1.0" << endl;
	cout << "music.in_game.paths=<path_to_in_game_music> NOTE: this can be a single file or a" << endl;
#ifdef WIN32
	cout << "                                              ':' separated list of directories " << endl;
#else
	cout << "                                              ';' separated list of directories " << endl;
#endif
	cout << "                                              containing mod files" << endl;
	cout << "sound.volume=<sound_volume>                 NOTE: must be between 0.0 and 1.0" << endl;
	cout << "video.mode=fullscreen|windowed" << endl;
	cout << endl;
	cout << "XLogical properties files are located in:" << endl;
	cout << endl;
#ifdef WIN32
	cout << DATA_DIR PATHSEP "xlogical.ini" << endl;
#else
#ifdef __MORPHOS__
	cout << "Progdir:xlogical.properties" << endl;
#else
	cout << "${HOME}" PATHSEP ".xlogicalrc" << endl;
	cout << DATA_DIR PATHSEP "xlogical.properties" << endl;
#endif
#endif
	cout << endl;
	cout << "Read one of the properties files for more information." << endl;

	clean_exit();
}

void
init_audio()
{
	// don't need music when editing levels
	if (properties::instance().get( "game.mode" ) != "editor")
	{
		// start up the audio driver
		audioDriver = new Csdl_audio;
		bool soundFailed = false;
		bool shouldContinue = true;

		// try to initialize
		try
		{
			audioDriver->setup();
		}
		catch( CXLException& e )
		{
			// if audio was disabled, no point in continuing
			shouldContinue = atoi(
				properties::instance().get( "audio.enabled" ).c_str() ) > 0;
			if (!shouldContinue)
			{
				throw;
			}

			// audio was enabled - output warning message
			cout
				<< "WARNING: audio device failed initialization ("
				<< e.Error().c_str()
				<< ")"
				<< endl;
			cout.flush();
			soundFailed = true;
		}

		if (soundFailed)
		{
			// if we get here, sound initialization failed but audio was enabled so we can
			// try again with audio disabled
			cout << "WARNING: attempting to continue with audio disabled" << endl;
			cout.flush();
			properties::instance().put( "audio.enabled", "0" );
			audioDriver->setup();
		}
		// start playing music
		audioDriver->play_music( musicFiles[MUSIC_INTRO] );

		for( unsigned int i=0; i<NUM_DEFAULT_SOUNDS; i+=1 )
		{
			audioDriver->load_sound( soundFiles[i] );
		}

		// setup music callback mechanism
		audioDriver->set_music_finished_func( music_finished );

	}
}

void
init_graphics( int argc, char **argv )
{
	string fileName;

	graphDriver = new Csdl_graph;

	// are we editing levels?
	if( properties::instance().get( "game.mode" ) == "editor" )
	{
		// scale things for the level editor
		graphDriver->graph_set_loop_func( edit_loop_func );
		graphDriver->graph_set_click_func( edit_click_func );
		graphDriver->graph_set_key_press_func( edit_key_press_func );
		graphDriver->graph_setup( &argc, &argv, 864, 510 );
		
		// set up a blank levelmap
		class Clevel_map *tMap = new Clevel_map( );

		// may as well put the filename someplace we can find it later
		fileName = properties::instance().get( "game.levels" );
		tMap->mapName = new char [ strlen( fileName.c_str( ) ) + 1 ];
		strcpy( tMap->mapName, fileName.c_str( ) );

		// add it to the level list
		gameLevels.insert( gameLevels.end( ), tMap );

		// temp stuff for edit mode
		currentGame = new Cgame( (char *)fileName.c_str( ) );
		currentGame->currentMap = gameLevels.begin( );

	} else {
		// scale things for gameplay
		graphDriver->graph_set_reload_func( reload_func );
		graphDriver->graph_set_loop_func( start_loop_func );
		graphDriver->graph_set_click_func( start_click_func );
		// disable key press events until levels loaded
		graphDriver->graph_set_key_press_func( NULL );
		graphDriver->graph_setup( &argc, &argv, PLAYWIDTH, PLAYHEIGHT );

		// check if we have custom levels
		if (properties::instance().get( "game.mode" ) == "custom")
		{
			fileName = properties::instance().get( "game.levels" );
			gProps->put(
				"hiscore.file",
#ifdef __MORPHOS__
				"Progdir:.xlogical.scores" );
#else
				string( getenv( "HOME" ) ) + PATHSEP + ".xlogical.scores" );
#endif
		} else {
#ifdef __MORPHOS__
			fileName = "Progdir:xlogical.levels";
#else
			fileName = string( DATA_DIR ) + PATHSEP + "xlogical.levels";
#endif
			gProps->put(
				"hiscore.file",
#ifdef __MORPHOS__
				"Progdir:.xlogical.scores" );
#else
				string( SCORE_DIR ) + PATHSEP + HISCOREFILE );
#endif
		}

		// create our game class
		currentGame = new Cgame(
			(fileName.length() > 0) ?
				const_cast<const char *>(fileName.c_str()) :
				NULL );
	}
}

// Our Main routine
int
main( int argc, char **argv )
{
	try
	{

#ifdef DEBUG_FUNC
		cerr << __FILE__ << " : main( )" << endl;
#endif

		// build search path for properties file
		list<string> searchPaths;
#ifdef WIN32
		searchPaths.push_back( "xlogical.ini" );
#else
		searchPaths.push_back( "xlogical.properties" );
		char *home = getenv( "HOME" );
		if (home)
		{
#ifdef __MORPHOS__
			searchPaths.push_back( "xlogical.properties" );
			//searchPaths.push_back( "Progdir:.xlogicalrc" );
#else
			searchPaths.push_back( string( home ) + PATHSEP + ".xlogicalrc" );
#endif
		}
#ifdef __MORPHOS__
		searchPaths.push_back("Progdir:xlogical.properties");
#else
		searchPaths.push_back(DATA_DIR PATHSEP "xlogical.properties");
#endif
#endif
		gProps = new properties( argc, argv, searchPaths );
	}
	catch( CXLException& ex )
	{
		cerr << "*** exception caught ***" << endl << ex << endl;
		usage();
	}

	try
	{
		// initialize random number seed
#ifdef WIN32
		// for now this is as good as it gets in WIN32
		srand( time( NULL ) );
#else
		// this is a bit more random than the WIN32 approach
		struct timeval tv;
		gettimeofday( &tv, NULL );
		srand( tv.tv_sec + tv.tv_usec );
#endif

		init_audio();
		init_graphics( argc, argv );

		graphDriver->graph_start();
		graphDriver->graph_shutdown();
	}
	catch( CXLException& ex )
	{
		cerr << "*** exception caught ***" << endl << ex << endl;
	}
	catch( exception& sysex )
	{
		cerr << "*** system exception caught ***" << endl << sysex.what() << endl;
	}
	catch( string& str )
	{
		cerr << "*** string exception caught ***" << endl << str.c_str() << endl;
	}
	catch( ... )
	{
		cerr << "*** UNKNOWN EXCEPTION CAUGHT ***" << endl;
	}

	clean_exit( );
	
	return 0;
}

void
clean_exit( int aExitCode )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : clean_exit( )" << endl;
#endif
	if (graphDriver)
	{
		graphDriver->graph_shutdown( );
		delete graphDriver;
		graphDriver = NULL;
	}
	delete currentGame;
	currentGame = NULL;
	if (audioDriver)
	{
#ifndef __MORPHOS__
		audioDriver->shutdown();
#else
		audioDriver->audio_shutdown();
#endif
		delete audioDriver;
		audioDriver = NULL;
	}
	if (gProps)
	{
		try
		{
			// get rid of these so they don't get written out
			try
			{
				gProps->remove( "hiscore.file" );
				gProps->remove( "game.mode" );
			}
			catch(...)
			{
				// we don't care if these don't exist in the properties class
			}

			// try to write properties out
#ifdef WIN32
			gProps->write( DATA_DIR PATHSEP "xlogical.ini" );
#else
#ifdef __MORPHOS__
			gProps->write( "Progdir:xlogical.properties" );
			//gProps->write( "Progdir:.xlogicalrc" );
#else
			gProps->write( string( getenv( "HOME" ) ) + PATHSEP + ".xlogicalrc" );
#endif
#endif
		}
		catch( CXLException& e )
		{
			cerr << "ERROR: " << e.Error().c_str() << endl;
		}
	}
	delete gProps;
	gProps = NULL;
	exit( aExitCode );
}

// $Log: main.cpp,v $
// Revision 1.7  2001/07/31 20:54:55  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.6  2001/03/15 09:41:10  tom
// initialized video driver reload callback
//
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
// Revision 1.2  2001/02/16 20:59:56  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:28  brown
// Working toward Windows integration
//
// Revision 1.20  2000/11/09 23:05:53  tom
// added SCORE_DIR compile time define
//
// Revision 1.19  2000/11/09 21:46:46  tom
// added logic to initialize xlogical with audio disabled if initialization
// fails with audio enabled.
//
// Revision 1.18  2000/10/14 04:07:10  tom
// added GPL to usage()
//
// Revision 1.17  2000/10/14 04:02:31  tom
// added usage information if an exception is caught while processing
// properties.
//
// Revision 1.16  2000/10/08 16:45:57  tom
// added time warning sound
//
// Revision 1.15  2000/10/08 16:07:29  tom
// fixed some little annoyances
//
// Revision 1.14  2000/10/08 05:37:44  tom
// added new pattern sound effect
//
// Revision 1.13  2000/10/08 05:28:11  tom
// added sound effect for finishing level
//
// Revision 1.12  2000/10/08 04:02:36  tom
// added bonus life sound
//
// Revision 1.11  2000/10/07 21:48:35  tom
// added logic to write out properties on exit
//
// Revision 1.10  2000/10/07 17:23:57  tom
// - made it so that DATA_DIR doesn't need to have trailing path separator
// - in default mode, hiscore file path is hard coded to DATA_DIR wherease
//   in custom mode, hiscore file path is hard coded to
//   ${HOME}/.xlogical.scores
//
// Revision 1.9  2000/10/07 08:03:29  tom
// changed property file search order so that user can override system
// property file by creating .xlogicalrc in home directory.
//
// Revision 1.8  2000/10/07 04:00:50  tom
// added search path for xlogical property file
//
// Revision 1.7  2000/10/06 19:29:07  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.6  2000/10/02 05:28:59  tom
// - removed getopt command line args in favor of using properties
// - tidied main() up a bit
//
// Revision 1.5  2000/10/01 18:41:11  tom
// initialized random number seed so ball sequence cannot be predicted
//
// Revision 1.4  2000/10/01 18:27:02  tom
// added new ball sound effect and code to play it
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
// Revision 1.34  2000/04/17 21:29:54  tom
// Fixed core dumps and music & sound playing problems.  (xlogical now
// requires libmikmod 3.1.9)
//
// Revision 1.33  2000/03/30 02:06:07  tom
// Fixed core dumps when sound initialization fails or quiet mode is enabled.
//
// Revision 1.32  2000/03/28 07:44:03  tom
// Added code to free up sound and music caches when calling clean_exit().
//
// Revision 1.31  2000/02/23 05:53:34  tom
// Changed music and sound playing to use ESD (mod playing is broken now).
//
// Revision 1.30  2000/02/13 07:32:46  tom
// Moved writing of high score file into clean_exit()
//
// Revision 1.29  2000/01/23 06:48:08  tom
// Disabled key press events until levels are loaded.
//
// Revision 1.28  2000/01/23 06:11:37  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.27  2000/01/23 02:35:02  tom
// Added support for multiple module paths.
//
// Revision 1.26  2000/01/05 03:47:33  brown
// Fixed some endgame stuff, scrollers, and hi-score menu entry goodies
//
// Revision 1.25  2000/01/02 01:25:42  tom
// Added wavpath command line option and fixed modpath option to work
//
// Revision 1.24  2000/01/01 21:51:19  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.23  1999/12/25 08:18:34  tom
// Added "Id" and "Log" CVS keywords to source code.
//
