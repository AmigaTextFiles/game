/***************************************************************************
                level.h  -  header for the corresponding cpp file
                             -------------------
    copyright            : (C) 2003-2004 by Artur Hallmann, (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#ifndef __LEVEL_H__
#define __LEVEL_H__

#include "include/globals.h"

// Background
#define BG_LEFTRIGHT 100	// only to the horizontal
#define BG_ALL 101			// into all directions
#define BG_DOUBLE 102		// 2 images

class cBackground
{
public:
	cBackground( void );
	~cBackground( void );

	void Set_type( Uint8 ntype );
	void Set_images( string nimg_file_1, string nimg_file_2 = "" );

	void Draw( SDL_Surface *target );

	// The type
	Uint8 type;

	// The image filenames
	string img_file_1, img_file_2;

	// The images
	SDL_Surface *img_1, *img_2;

	// The rect
	SDL_Rect rect;
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cLevel
{
public:
	cLevel( void );
	~cLevel( void );

	// Creates a new level
	int New( string filename = "null" );
	// Loads a Level
	bool Load( string filename );
	// Unloads the current Level
	void Unload( void );
	// Saves the current Level
	void Save( void );

	// Draws all Level Objects ( Sprites,Enemies,Hud )
	// and updates them if update is true
	void Draw( bool update = 1 );

	// Shows a big Text with the string and exits
	void Show_Error( string text );

	// Sets the Background color
	void Set_BackgroundColor( Uint8 red, Uint8 green, Uint8 blue );
	// Sets the Musicfile
	void Set_Musicfile( string filename );
	// Sets a new Levelfile name and automatically resaves the level
	void Set_Levelfile( string filename );

	// Returns the Levelfile
	string Get_Levelfile( bool with_dir = 1, bool with_end = 1 );

	// Music filename
	string Musicfile;

	// Level file
	string Levelfile;

	// Camera Modification settings
	int Mod_Camera_up, Mod_Camera_left, Mod_Camera_right;

	// Background Color
	Uint32 background_color;

	// the Levelenine version from the loaded Level
	int Levelengine_version;

	// The background
	cBackground *Background;

	// Returns 0 if failed , 1 if Ingame save, 2 if OverWorld save
	int Load_Savegame( unsigned int Save_file );
	// saves the game with the given description
	bool Save_Savegame( unsigned int Save_file, string Description );


private:
	// Parses the command parts
	void Parse_Map( string command, int line );
	// Handles the command
	int HandleMessage( string *parts, unsigned int count, unsigned int line );
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
