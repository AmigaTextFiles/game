/////////////////////////////////////////////////////////////////////////////////////
//
//	TITLE		:	KJText
//	AUTHOR	:	Kevan Thurstans
//	VERSION	:	0.1
//	CREATED	:	05/05/01
//						Sets up a bitmap surface containing a fixed sized font.
//						This gives us simple text usage on any game surface.
//						Upon created a bitmap filename needs to be given in order
//						to load this bitmap, which contains a full ascii set starting
//						from <SPACE> onwards.
//						All the characters are kept in columns.
//						'ascii.bmp' is included as an example.
//						the size of the characters must be given along with how many 
//						characters per column.
//
//						KJText hass a two pass creation. 
//						The constructor has no parameters, and simply sets up the object
//						'Create()' actually loads in the bitmap etc.
//
//	UPDATES	:
//
/////////////////////////////////////////////////////////////////////////////////////


#ifndef	__KJTEXT_H
#define	__KJTEXT_H

#include <SDL/SDL.h>
#include "KJ.h"

class KJText
{

	public:

		KJText();
		~KJText();

		/* CREATE THE FONT BITMAP OBJECT AND SET DEFAULT DRAW SURFACE */
		bool Create(const char* bmpFilename, KJSize *charSize, 
								SDL_Surface *defSurface = NULL);
		/* DRAW STRING ONTO GIVEN SURFACE AT GIVEN POSITION */
		void Print(const char* textStr, KJPos *position = NULL,
							 SDL_Surface *surface = NULL);
		void Print(int number, KJPos *position = NULL,
							 SDL_Surface *surface = NULL);

		int		Transparent(bool keyOn);	// turns colorkey on/off
	protected:

		SDL_Surface		*fontSurface,			// surface to hold bitmap of all characters
									*defaultSurface;	// if no surface is given this is where we draw
		KJSize				chrSize;					// size of characters, in pixels
		KJPos					cursor;
		Uint32				colorKey;					// transparent color

};

#endif
