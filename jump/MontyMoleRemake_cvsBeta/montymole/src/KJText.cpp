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
//						When the surcafe bitmap is created, the top-left hand pixel is
//						taken and stored as the given transparent colour key.
//						This can be turned on and off..
//
//	UPDATES	:	16/01/02	-	More MS sloppyiness.. Added <stdio.h> for Linux etal..
//
/////////////////////////////////////////////////////////////////////////////////////


#include "KJText.h"
#include <stdio.h>
#include <stdlib.h>
#include "string.h"


KJText::KJText()
{
	fontSurface=NULL;
	defaultSurface=NULL;
	cursor.x = 0;					// position to draw next at
	cursor.y = 0;
}


KJText::~KJText()
{
	if(fontSurface != NULL)
		  SDL_FreeSurface(fontSurface);

}



/******************************************************************************
 *                                                                            *
 *	Create                                                                    *
 *                                                                            *
 *	ENTRY	:	const char* bmpFilename - filename of bitmap holding font         *
 *					KJ_size			charSize		-	width and height of characters          *
 *          SDL_Surface *defSurface - somewhere to draw                       *
 *                                                                            *
 *	 EXIT	:	bool - true = created font                                        *
 *								 false = problem creating font                              *
 *                                                                            *
 ******************************************************************************/

bool KJText::Create(const char* bmpFilename, KJSize *charSize,
										SDL_Surface *defSurface /*= NULL*/)
{
	bool		fSuccess = false;

  /* Load the BMP file into a surface */
  if(fontSurface = SDL_LoadBMP(bmpFilename))
	{
		SDL_LockSurface(fontSurface);								/* Lock the surface */


		chrSize.w = charSize->w;
		chrSize.h = charSize->h;
		defaultSurface = defSurface;

		colorKey = *(Uint8*)fontSurface->pixels;				/* get top-left pixel */
																								/* and map it as the transparent key */
		SDL_SetColorKey(fontSurface, SDL_SRCCOLORKEY, colorKey);
	
	  SDL_UnlockSurface(fontSurface);

		fSuccess = true;
  } // END LOAD BITMAP

	return fSuccess;
}



/******************************************************************************
 *                                                                            *
 *	Print                                                                     *
 *                                                                            *
 *  Displays a string onto a given surface at a given position                *
 *  If no position is given it defaults to -1,-1 which means draw at next     *
 *  cursor position.                                                          *
 *  If no surface is given then we draw onto default surface.                 *
 *                                                                            *
 *                                                                            *
 *	ENTRY	:	const char  *textStr    - String to draw                          *
 *          KJ_Pos      *position   - Position of text (in pixels)            *
 *					SDL_surface *canvas  	  - surface to draw onto                    *
 *                                                                            *
 *	 EXIT	:	                                                                  *
 *								                                                            *
 *                                                                            *
 ******************************************************************************/

void KJText::Print(const char* textStr, KJPos *position /*=NULL*/, 
									 SDL_Surface *surface /*=NULL*/)
{
	SDL_Rect	src,		// where to grab bitmap from
						dest;
	KJPos			start;	// copy of start position
	Uint16		strLen = strlen(textStr),
						temp,
						chr;



	if(position == NULL)						// if no position is given
		position = &cursor;						// start at cursors next position instead

	if(surface == NULL)							// if no surface is given
		surface = defaultSurface;			// we can use the default surface...

	start.x = position->x;
	start.y = position->y;

	for(chr=0; chr<strLen; chr++)
	{
		switch(textStr[chr])
		{
		case 0x0A:
			position->x = start.x;
			position->y = start.y + chrSize.h;
			break;

		default:
			if(textStr[chr]>31 && textStr[chr]<128)
			{
				temp = (Uint16)(textStr[chr]-32);
			}
			else
			{
				temp = (Uint16)'?';
			}
			
			src.x = (temp>>3)*chrSize.w;
			src.y = ((temp %8)*chrSize.h);
			src.w = chrSize.w;
			src.h = chrSize.h;

			dest.x = position->x;
			dest.y = position->y;

			SDL_BlitSurface(fontSurface, &src, surface, &dest);
			position->x +=chrSize.w;     
		} // END SWITCH CASE

	} // LOOP NEXT CHR

	cursor.x = position->x;
	cursor.y = position->y;
}


void KJText::Print(int number, KJPos *position /*=NULL*/, SDL_Surface *surface /*=NULL*/)
{
	char numberStr[0x80];

	sprintf(numberStr, "%d", number);
	Print(numberStr, position, surface);
}



/******************************************************************************
 *                                                                            *
 *	Transparent                                                               *
 *                                                                            *
 *  The method turns the transparency on and off.                             *
 *  if a true value is passed then the color key is turned on                 *
 *  A false turns the key off.                                                *
 *                                                                            *
 *	ENTRY	:	bool        keyOn       - true = colorKey on                      *
 *                                  - false = off                             *
 *                                                                            *
 *	 EXIT	:	                        - 0 successful                            *
 *								                  - -1 failed                               *
 *                                                                            *
 ******************************************************************************/

int KJText::Transparent(bool keyOn)
{
	Uint32	flags = 0;

	if(keyOn)
		flags =(SDL_SRCCOLORKEY | SDL_RLEACCEL )*keyOn;

	return 		SDL_SetColorKey(fontSurface, flags, colorKey);
}
