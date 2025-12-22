/***************************************************************************
                globals.h  -  header for the corresponding cpp file
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

#ifndef __MENU_H__
#define __MENU_H__

#include "include/globals.h"

class cMainMenu
{
public:
	cMainMenu( void );
	~cMainMenu( void );
	
	void LoadImages( void );
	void FreeImages( void );

	// Generic Menu handler
	void UpdateGeneric( void );

	// Main menu
	void ShowMenu( void );
	void UpdateMenu( void );
	void MenuAction( void );

	// Options Submenu
	void ShowSubOptions( void );
	void UpdateSubOptions( void );
	void SubOptionsAction( void );

	// Controls Submenu
	void ShowSubControls( void );
	void UpdateSubControls( void );
	void SubControlsAction( void );

	// Audio Submenu
	void ShowSubAudio( void );
	void UpdateSubAudio( void );
	
	// Video Submenu
	void ShowSubVideo( void );
	void UpdateSubVideo( void );

	// Savegame Load Submenu
	void ShowLoadGames( void );
	void UpdateLoadGames( void );

	// Savegame Save Submenu
	void ShowSaveGames( void );
	void UpdateSaveGames( void );
	string Set_SaveDescription( unsigned int Save_file );

	void GetSavedGames( void ); // Gets all 9 Save Descriptions into the SaveLoadTemp Surfaces
	void SetScreeninfo( int Tmp_screen_w, int Tmp_screen_h, int Tmp_screen_Bpp, bool Tmp_screen_Fullscreen ); // Sets the screen info

	// For leaving the current menu ( Is set to 2 if the user pressed ESC )
	int leave;
	// If the UpdateGeneric detected an Action
	bool action;
	
	// The current Menu Item
	int Menu_Item;
	// The Maximal Menu Items in the current menu
	int Menu_Max;

	// Menu Logo
	SDL_Surface *logo;
	SDL_Surface *logo_quit;

	// The SDl Logo
	SDL_Surface *logo_sdl;

	SDL_Surface *bstart1;
	SDL_Surface *bstart2;

	SDL_Surface *boptions1;
	SDL_Surface *boptions2;

	SDL_Surface *bload1;
	SDL_Surface *bload2;
	SDL_Surface *bsave1;
	SDL_Surface *bsave2;
	
	SDL_Surface * bquit1;
	SDL_Surface * bquit2;

	SDL_Surface *bcontrols1;
	SDL_Surface *bcontrols2;

	SDL_Surface *baudio1;
	SDL_Surface *baudio2;
	SDL_Surface *bvideo1;
	SDL_Surface *bvideo2;
	
	SDL_Surface *bon1;
	SDL_Surface *bon2;
	SDL_Surface *boff1;
	SDL_Surface *boff2;

	// Keyboard Keys
	SDL_Surface *text_up;
	SDL_Surface *text_upkey;
	SDL_Surface *text_down;
	SDL_Surface *text_downkey;
	SDL_Surface *text_left;
	SDL_Surface *text_leftkey;
	SDL_Surface *text_right;
	SDL_Surface *text_rightkey;
	SDL_Surface *text_shoot;
	SDL_Surface *text_shootkey;
	SDL_Surface *text_pointer;
	SDL_Surface *text_usejoystick;
	SDL_Surface *text_usejoystick_on;
	SDL_Surface *text_usejoystick_off;

	// Video Items
	SDL_Surface *video_resolution;
	SDL_Surface *video_bpp;
	SDL_Surface *video_fullscreen;

	SDL_Surface *video_resolution_val;
	SDL_Surface *video_bpp_val;
	SDL_Surface *video_fullscreen_val;
	SDL_Surface *video_change;

	// Audio Items
	SDL_Surface *audio_music;
	SDL_Surface *audio_sounds;
	SDL_Surface *audio_on;
	SDL_Surface *audio_off;

	SDL_Surface *back1;
	
	// The Main Menu images near the text
	SDL_Surface *Item_1;
	SDL_Surface *Item_2;
	SDL_Surface *Item_3;
	SDL_Surface *Item_4;

	// Version image in the Main Menu
	SDL_Surface *SMC_Version;

	// Save and Load images
	SDL_Surface *SaveLoadTemp1[9];
	SDL_Surface *SaveLoadTemp2[9];
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
