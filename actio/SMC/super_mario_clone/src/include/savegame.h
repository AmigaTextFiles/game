/***************************************************************************
           Savegame.h  -  Savegame Engine Header
                             -------------------
    copyright            : (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#ifndef __SAVEGAME_H__
#define __SAVEGAME_H__

#include "include/globals.h"

#define SAVEGAME_VERSION "2.1"

#define SAVE_DIR "savegames"
#define LEVEL_DIR "levels"

struct Savegame
{
	std::string Description;	// Level Description
	int Version;				// Level Savegame Version
	char Levelname[40];			// Level Name
	char Time_Stamp[30];		// Time
	int Pos_x,Pos_y;			// Position
	unsigned int Lives;
	unsigned int Points;
	unsigned int Goldpieces;
	unsigned int State;			// 1 = normal small, 2 = normal Big, 3 = Fire ...
	unsigned int Itembox_item;	// The Item in the Itembox

	// OverWorld
	unsigned int OWsave;	// is this an OverWorld save
	unsigned int OWNlevel;	// accessed OverWorld normal levels
	unsigned int OWSlevel;	// accessed OverWorld secret levels
	unsigned int OWCurr_WP; // Current Waypoint
	unsigned int OverWorld; // Current OverWorld
};

bool GetSave( char* command, unsigned int line );

Savegame Savegame_Load( unsigned int Save_file );
int Savegame_Save( unsigned int Save_file, Savegame Save_info );
const char *Savegame_GetDescription( unsigned int Save_file, bool Only_Description = 0 );
void Savegame_Debug_Print( Savegame TSavegame );
bool Savegame_valid( unsigned int Save_file );

#endif
