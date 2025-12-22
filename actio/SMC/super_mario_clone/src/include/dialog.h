/***************************************************************************
			dialog.h  -  Dialog header

			Version : 1.0

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

#include "include/globals.h"

#ifndef __DIALOG_H__
#define __DIALOG_H__

#define DIALOG_ALL 0
#define DIALOG_ONLY_LETTERS 1
#define DIALOG_ONLY_NUMBERS 2

class cDialog  : public cSprite 
{
public:
	cDialog( double nposx, double nposy, string nidentifier, string ntext, int dialogtype, Uint8 ncharlength,
		unsigned int nmin_width );
	~cDialog( void );

	virtual void Update( void );

	// Checks if the text was changed
	bool gotChanged( void );

	// Returns teh Value and resets the changed
	int Get_Value_int( bool reset_changed = 1 );
	string Get_Value_string( bool reset_changed = 1 );

	// Sets the Focus to this Dialog
	void Get_Focus( void );

	// Sets the outer Boarder size
	void Set_Boardersize_out( Uint8 size );

	// Sets the Colors
	void SetColors( SDL_Color outer, SDL_Color inner, SDL_Color text_area, SDL_Color text );

	// Sets the inner Boarder size
	void Set_Boardersize_in( Uint8 size );

	// Sets the Additional Text area size
	void Additional_Textareasize( Uint8 size );

	// Returns a rect with the real size
	SDL_Rect Get_Rect( void );

	// The Text images
	SDL_Surface *stext;

	// The Text string
	string text;

	// If the type is number only
	int text_number;

	// The minimal width
	unsigned int min_width;

	// The Identfier
	string identifier;

	// The Maximum character or number length
	Uint8 max_length;

	// The Boarder and Text Colors
	SDL_Color boarder_out_color, boarder_in_color, text_area_color, text_color;

private:
	void Update_Boarders( void );
	void Update_Text( void );

	SDL_Rect rect_boarder_out, rect_boarder_in, rect_text_area;
	
	Uint8 boarder_out, boarder_in, text_area;

	bool changed;
};

// Updates all Dialogs
void UpdateDialogs( void );

// Adds an Dialog
void AddDialog( double posx, double posy, string identifier, string ntext, int dialogtype = DIALOG_ALL, int max_length = 20,
			   unsigned int min_width = 70 );

/* Returns the Dialog id with the given identifier
 * else -1
 */ 
int Get_Dialog( string tidentifier );

// Deletes the Dialog with the given identifier
bool DeleteDialog( string tidentifier );

// Deletes all Dialogs
void DeleteAllDialogObjects( void );

/* Returns the Collision number
 * else -1
 */ 
int Get_Collision_Dialogs( int x, int y );

#endif
