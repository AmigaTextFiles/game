/***************************************************************************
    globals.cpp  -  all global used variables, as specified in globals.h
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
 

#include "include/globals.h"
#include "include/main.h"

#ifndef __WIN32__
#include <algorithm>
#endif

// #####  The global variables #########

cFramerate Framerate( DESIRED_FPS );

cImageManager *ImageFactory;
cJoystick *pJoystick;

cSprite **MassiveObjects, **PassiveObjects, **ActiveObjects, **EnemyObjects, **HUDObjects, **AnimationObjects;
cDialog **DialogObjects;

cPlayer *pPlayer = NULL;
cLevel *pLevel = NULL;
cOverWorld *pOverWorld = NULL;
cMainMenu *pMenu = NULL;

cPreferences *pPreferences = NULL;
cMouseCursor *pMouseCursor = NULL;
cLevelEditor *pLeveleditor = NULL;

cPlayerPoints *pointsdisplay = NULL;
cDebugDisplay *debugdisplay = NULL;
cGoldDisplay *golddisplay = NULL;
cLiveDisplay *livedisplay = NULL;
cTimeDisplay *timedisplay = NULL;
cItemBox *Itembox = NULL;

int MassiveCount, PassiveCount, ActiveCount, EnemyCount, HUDCount, AnimationCount, DialogCount;

int Leveleditor_Mode;
int Game_Mode;
bool Game_debug, Overworld_debug;
bool HUD_loaded;

bool done;
SDL_Surface *screen, *image;
SDL_Event event;
Uint32 std_bgcolor, magenta, darkblue, white, grey, green;
SDL_Color colorBlack, colorWhite, colorBlue, colorDarkBlue, colorGreen, colorDarkGreen, colorMagenta, colorGrey, colorRed;
Uint8 *keys;
// Cameraposition
signed int cameraposx, cameraposy, _cameraposx, _cameraposy;
// ### Mouse

int mouseX, mouseY, _mouseX, _mouseY;
// ### Mouse ###
TTF_Font *font, *font_16;
int UpKeyTime;
cAudio *pAudio;

// uses the is_valid_number function
class nondigit
{
	public:
	bool operator() (char c) {return !isdigit(c);}
};


bool is_valid_number( string num )
{
	if( num.find( '-' ) == 0 ) // Should also accept negative numbers
	{
		num.erase( 0, 1 );
	}

	if( find_if( num.begin(), num.end(), nondigit() ) == num.end() )
	{
		return 1;
	}

	return 0;
}

/*	Loads an image directly and returns a pointer to it.
 *	The returned image can be deleted.
 */

SDL_Surface *LoadImage( const char *szFilename ) // V.2.2.1
{
	char *szFilenametemp = NULL;
	
	ifstream ifs( szFilename, ios::in );
	
	if( !ifs )
	{
		szFilenametemp = new char[ strlen( szFilename ) + strlen( PIXMAPS_DIR ) + 2 ];

		sprintf( szFilenametemp, "%s/%s", PIXMAPS_DIR, szFilename );

		ifstream ifst( szFilenametemp, ios::in );
		
		if( !ifst )
		{
			printf( "Loading file failed : %s\nAlso not found in : %s\n", szFilename, szFilenametemp );
			return NULL;
		}
		ifst.close();
	} 
	else
	{
		szFilenametemp = new char[ strlen( szFilename ) + 1 ];
		sprintf( szFilenametemp, szFilename );
		ifs.close();
	}
	
	SDL_Surface *image, *temp;
	
	temp = IMG_Load( szFilenametemp );
	
	if( !temp )
	{
		printf( "Error loading file : %s\nReason : %s", szFilenametemp, SDL_GetError() );
		return NULL;
	}
	
	image = SDL_DisplayFormat( temp );
		
	if( !image )
	{
		printf( "Error Displayformat returned NULL : %s\nReason : %s", szFilenametemp, SDL_GetError() );
		return NULL;
	}

	SDL_FreeSurface( temp );
	SDL_SetColorKey( image, SDL_SRCCOLORKEY | SDL_RLEACCEL, magenta );
	
	delete szFilenametemp;

	return image;
}

/*	Checks if the image was already loaded and returns a pointer to it
 *	else it will be loaded.
 *	The returned image should not be deleted or modified.
 *	V.2.2
 */
SDL_Surface *GetImage( string filename )
{

	if( filename.find( PIXMAPS_DIR ) == string::npos ) 
	{
		filename.insert( 0, "/" );
		filename.insert( 0, PIXMAPS_DIR );
	}

	SDL_Surface *Sprite = ImageFactory->GetPointer( filename );
	
	if( Sprite )
	{
		return Sprite;
	}

	Sprite = LoadImage( filename.c_str() );
	
	ImageFactory->Add( Sprite, filename );
	
	return Sprite;
}

/*	Creates a new Surface and sets it to the displayformat
 *	V.1.2	
 */ 
SDL_Surface *MakeSurface( unsigned int width, unsigned int height, bool hardware )
{
    Uint32 rmask, gmask, bmask, amask;
	
	#if SDL_BYTEORDER == SDL_BIG_ENDIAN
		rmask = 0xff000000;
		gmask = 0x00ff0000;
		bmask = 0x0000ff00;
		amask = 0x000000ff;
	#else
		rmask = 0x000000ff;
		gmask = 0x0000ff00;
		bmask = 0x00ff0000;
		amask = 0xff000000;
	#endif
	
	SDL_Surface *image, *temp;
	
	if( hardware )
	{
		temp = SDL_CreateRGBSurface( SDL_HWSURFACE | SDL_SRCCOLORKEY | SDL_SRCALPHA, width, height, screen->format->BitsPerPixel, rmask, gmask, bmask, amask );
	}
	else
	{
		temp = SDL_CreateRGBSurface( SDL_SWSURFACE | SDL_SRCCOLORKEY | SDL_SRCALPHA, width, height, screen->format->BitsPerPixel, rmask, gmask, bmask, amask );
	}

	if( !temp )
	{
		printf( "Error creating image\nReason : %s", SDL_GetError() );
		return NULL;
	}

	image = SDL_DisplayFormatAlpha( temp );

	if( !image )
	{
		printf( "Error Displayformat returned NULL\nReason : %s", SDL_GetError() );
		return NULL;
	}

	SDL_FreeSurface( temp );
	
	return image;
}


// Adds a massive Object
void AddMassiveObject( cSprite *obj )
{
	MassiveObjects = (cSprite**) realloc(MassiveObjects, ++MassiveCount * sizeof(cSprite*));
	MassiveObjects[MassiveCount-1] = obj;
}

// Adds a HUD Object
void AddHUDObject( cSprite *obj )
{
	HUDObjects = (cSprite**) realloc ( HUDObjects, ++HUDCount * sizeof(cSprite*) );
	HUDObjects[ HUDCount - 1 ] = obj;
}

// Adds an Enemy Object
void AddEnemyObject( cSprite *obj )
{
	EnemyObjects = (cSprite**) realloc ( EnemyObjects, ++EnemyCount * sizeof(cSprite*) );
	EnemyObjects[ EnemyCount - 1 ] = obj;
}

// Adds a Passive Object
void AddPassiveObject( cSprite *obj )
{
	PassiveObjects = (cSprite**) realloc ( PassiveObjects, ++PassiveCount * sizeof(cSprite*) );
	PassiveObjects[ PassiveCount - 1 ] = obj;
}

// Adds an Active Object
void AddActiveObject( cSprite *obj )
{
	ActiveObjects = (cSprite**) realloc ( ActiveObjects, ++ActiveCount * sizeof(cSprite*) );
	ActiveObjects[ ActiveCount - 1 ] = obj;
}

/*	Copies an Object
 *	and returns it
 * if an error occured returns NULL
 */
cSprite *Copy_Object( cSprite *CopyObject, double x, double y )
{
	if( CopyObject->type == TYPE_GOLDPIECE )
	{
		return (cSprite*) new cGoldPiece( x, y );
	}
	else if( CopyObject->type == TYPE_MOON )
	{
		return (cSprite*) new cMoon( x, y );
	}
	else if( CopyObject->type == TYPE_CLOUD )
	{
		return (cSprite*) new cCloud( x, y );
	}
	else if(CopyObject->type == TYPE_LEVELEXIT )
	{
		return (cSprite*) new cLevelExit( x, y );
	}
	else if(CopyObject->type == TYPE_GOLDBOX )
	{
		return (cSprite*) new cGoldBox( x, y );
	}
	else if(CopyObject->type == TYPE_SPINBOX )
	{
		return (cSprite*) new cSpinBox( x, y );
	}
	else if(CopyObject->type == TYPE_GOOMBA_BROWN )
	{
		return (cSprite*) new cGoomba( x, y, 0 );
	}
	else if(CopyObject->type == TYPE_GOOMBA_RED )
	{
		return (cSprite*) new cGoomba( x, y, 1 );
	}
	else if(CopyObject->type == TYPE_TURTLE_RED )
	{
		return (cSprite*) new cTurtle( x, y, 1 );
	}
	else if(CopyObject->type == TYPE_JPIRANHA )
	{
		return (cSprite*) new cjPiranha( x, y );
	} 
	else if(CopyObject->type == TYPE_BANZAI_BILL )
	{
		return (cSprite*) new cbanzai_bill( x, y,CopyObject->direction );
	}
	else if(CopyObject->type == TYPE_REX )
	{
		return (cSprite*) new cRex( x, y );
	}
	else if(CopyObject->type == TYPE_BONUSBOX_MUSHROOM_FIRE )
	{
		return (cSprite*) new cBonusBox( x, y,TYPE_BONUSBOX_MUSHROOM_FIRE );
	}
	else if(CopyObject->type == TYPE_BONUSBOX_LIVE )
	{
		return (cSprite*) new cBonusBox( x, y, TYPE_BONUSBOX_LIVE );
	}
	else if(CopyObject->type == TYPE_ENEMYSTOPPER )
	{
		return (cSprite*) new cEnemyStopper( x, y );
	}
	else if( CopyObject->type == TYPE_PLAYER )
	{
		return NULL;
	}
	else // Sprite
	{
		SDL_Surface *ImgTemp = GetImage( ImageFactory->GetPath( CopyObject->image ) );
		cSprite *New_Sprite = new cSprite( ImgTemp, x, y );

		if( CopyObject->massive && !CopyObject->halfmassive )
		{
			New_Sprite->Array = ARRAY_MASSIVE;
			return New_Sprite;
		}
		else if( !CopyObject->massive && !CopyObject->halfmassive )
		{
			New_Sprite->massive = 0;
			New_Sprite->Array = ARRAY_PASSIVE;
			return New_Sprite;
		}
		else if( CopyObject->halfmassive )
		{
			New_Sprite->halfmassive = 1;
			New_Sprite->type = TYPE_HALFMASSIVE;
			New_Sprite->Array = ARRAY_ACTIVE;
			return New_Sprite;
		}
	}

	return NULL;
}

// Returns the Pixel Color
Uint32 SDL_GetPixel( SDL_Surface *surface, Sint16 x, Sint16 y )
{
	if(x<0 || x>=surface->w || y<0 || y>=surface->h)
		return 0;

	switch (surface->format->BytesPerPixel) {
		case 1: { /* Assuming 8-bpp */
			return *((Uint8 *)surface->pixels + y*surface->pitch + x);
		}
		break;

		case 2: { /* Probably 15-bpp or 16-bpp */
			return *((Uint16 *)surface->pixels + y*surface->pitch/2 + x);
		}
		break;

		case 3: { /* Slow 24-bpp mode, usually not used */
			Uint8 *pix;
			int shift;
			Uint32 color=0;

			pix = (Uint8 *)surface->pixels + y * surface->pitch + x*3;
			shift = surface->format->Rshift;
			color = *(pix+shift/8)<<shift;
			shift = surface->format->Gshift;
			color|= *(pix+shift/8)<<shift;
			shift = surface->format->Bshift;
			color|= *(pix+shift/8)<<shift;
			shift = surface->format->Ashift;
			color|= *(pix+shift/8)<<shift;
			return color;
		}
		break;

		case 4: { /* Probably 32-bpp */
			return *((Uint32 *)surface->pixels + y*surface->pitch/4 + x);
		}
		break;
	}
	return 0;
}

// Sets an Pixel to the given Color
void SDL_PutPixel( SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color )
{
	if(x<0 || x>=surface->w || y<0 || y>=surface->h)
		return;

	switch (surface->format->BytesPerPixel) {
		case 1: { /* Assuming 8-bpp */
			*((Uint8 *)surface->pixels + y*surface->pitch + x) = color;
		}
		break;

		case 2: { /* Probably 15-bpp or 16-bpp */
			*((Uint16 *)surface->pixels + y*surface->pitch/2 + x) = color;
		}
		break;

		case 3: { /* Slow 24-bpp mode, usually not used */
			Uint8 *pix = (Uint8 *)surface->pixels + y * surface->pitch + x*3;

  			/* Gack - slow, but endian correct */
			*(pix+surface->format->Rshift/8) = color>>surface->format->Rshift;
  			*(pix+surface->format->Gshift/8) = color>>surface->format->Gshift;
  			*(pix+surface->format->Bshift/8) = color>>surface->format->Bshift;
			*(pix+surface->format->Ashift/8) = color>>surface->format->Ashift;
		}
		break;

		case 4: { /* Probably 32-bpp */
			*((Uint32 *)surface->pixels + y*surface->pitch/4 + x) = color;
		}
		break;
	}
}

// Returns the Current Computer time
char *Get_Curr_Time( void )
{
   time_t t;
   struct tm *area;

   t = time( NULL );
   area = localtime( &t );
   return asctime( area );
}

// Draws an Effect
void DrawEffect( unsigned int effect, double speed )
{
	if( !effect )
	{
		effect = (int)(rand() % (7)) + 1;
	}

	switch( effect )
	{
	case 1 : // Complete Screen gets more and more darker
		{
			for( double i = 1;i > 0;i -= speed * Framerate.speedfactor/50 )
			{
				SDL_SetGamma( (float)i, (float)i, (float)i );
				
				SDL_Flip( screen );

				Framerate.SetSpeedFactor();
			}
			SDL_SetGamma( (float)1, (float)1, (float)1 );
			break;
		}
	case 2 : // Big black lines from right and left
		{
			SDL_Rect Rct;
			Uint16 pos = 0;
			Rct.x = 0;
			Rct.y = 0;
			Rct.w = 1;
			Rct.h = screen->h;

			while( pos < (unsigned int)( screen->w/2 ) )
			{
				Rct.w = (Uint16)( Framerate.speedfactor*18 );

				if( Rct.w < 1 )
				{
					Rct.w = 1;
				}
				
				Rct.x = pos;
				pos += Rct.w;

				SDL_FillRect( screen, &Rct, 0 );

				Rct.x = screen->w - Rct.x - Rct.w;

				SDL_FillRect( screen, &Rct, 0 );

				SDL_Flip( screen );

				Framerate.SetSpeedFactor();
			}
			break;
		}
	case 3 : // Big black lines from up and down
		{
			SDL_Rect Rct;
			Uint16 pos = 0;
			Rct.x = 0;
			Rct.y = 0;
			Rct.w = screen->w;
			Rct.h = 1;

			while( pos < (unsigned int)( screen->h/2 ) )
			{
				Rct.h = (Uint16)( Framerate.speedfactor*12 );

				if( Rct.h < 1 )
				{
					Rct.h = 1;
				}
				
				Rct.y = pos;
				pos += Rct.h;

				SDL_FillRect( screen, &Rct, 0 );

				Rct.y = screen->h - Rct.y - Rct.h;

				SDL_FillRect( screen, &Rct, 0 );

				SDL_Flip( screen );

				Framerate.SetSpeedFactor();
			}
			break;
		}
	case 4 : // Wishy Washy Pixelation ;)
		{
			int f = 0;
			double i = (double)( screen->w * screen->h );
			int fspeed = (int)( speed * 10000 );

			while( i > ( f * Framerate.speedfactor ) )
			{
				for( int g = 0;g < fspeed;g++ )
				{
					int x = (int)rand() % ( screen->w );
					int y = (int)rand() % ( screen->h );

					LockSurface( screen );
					Uint32 Pixel = SDL_GetPixel( screen, x, y );
					UnlockSurface( screen );
					
					LockSurface( screen );

					SDL_PutPixel( screen, x + 1, y, Pixel );
					SDL_PutPixel( screen, x - 1, y, Pixel );
					
					SDL_PutPixel( screen, x + 1, y + 1, Pixel );
					SDL_PutPixel( screen, x - 1, y - 1, Pixel );

					SDL_PutPixel( screen, x + 1, y - 1, Pixel );
					SDL_PutPixel( screen, x - 1, y + 1, Pixel );

					SDL_PutPixel( screen, x - 1, y + 1, Pixel );
					SDL_PutPixel( screen, x + 1, y - 1, Pixel );

					SDL_PutPixel( screen, x, y + 1, Pixel );
					SDL_PutPixel( screen, x, y - 1, Pixel );

					UnlockSurface( screen );

					f++;
				}

				SDL_Flip( screen );
				
				Framerate.SetSpeedFactor();
				CorrectFrameTime( DESIRED_FPS );
			}
			
			break;
		}
	case 5 : // Random Rectangle Pixelation
		{
			double f = 0;
			double i = (double)( ( screen->w * screen->h ) / 11000 );
			
			double xwidth = 8;

			SDL_Rect Rct;

			while( i > f )
			{
				xwidth += 1.1 * Framerate.speedfactor;

				for( int g = 0;g < 2000;g++ )
				{
					Rct.x = (int)rand() % ( screen->w );
					Rct.y = (int)rand() % ( screen->h );
					
					Rct.w = (int)xwidth;
					Rct.h = (int)xwidth;

					LockSurface( screen );
					Uint32 Pixel = SDL_GetPixel( screen, Rct.x, Rct.y );
					UnlockSurface( screen );

					Rct.x -= (int)( xwidth/2 );
					Rct.y -= (int)( xwidth/2 );
					
					SDL_FillRect( screen, &Rct, Pixel );
				}
				
				f += Framerate.speedfactor;

				SDL_Flip( screen );

				Framerate.SetSpeedFactor();
			}
			break;
		}
	case 6: // tile-like
		{	// needs speedfcator adjusments and the size in double ( replace rect )
			const int num_hor = 12;
			const int num_ver = 9;
			const int num = num_hor * num_ver;

			bool grid[num_ver][num_hor];

			for( int i = 0; i < num_ver; i++ )
			{
				for( int j = 0; j < num_hor; j++ )
				{
					grid[i][j] = 1;
				}
			}
			
			int select_x = 0, select_y = 0;
			int temp;
			SDL_Rect dest = {0, 0, screen->w/num_hor, screen->h/num_ver};
			
			for( int i = 0; i < num; i++ )
			{
				while( grid[select_y][select_x] == 0 )
				{
					temp = rand()%( num );

					select_y = temp/num_hor;
					select_x = temp%num_hor;
				}

				grid[select_y][select_x] = 0;
				dest.x = select_x*dest.w;
				dest.y = select_y*dest.h;
				
				SDL_FillRect( screen, &dest, 0 );

				SDL_Flip( screen );

				//SDL_FillRect( screen, &dest, 0 );

				Framerate.SetSpeedFactor();
			}
		}
		break;
	case 7: // Slider to the right or downwards
		{
			SDL_Rect src = {0, 0, screen->w, screen->h};

			double xpos = 0;
			double ypos = 0;
			double width = (int)src.w;
			double height = (int)src.h;
			
			int direction = (int)(rand() % (2)) + 1;

			LockSurface( screen );
			SDL_Surface *temp = SDL_ConvertSurface( screen, screen->format, screen->flags );
			UnlockSurface( screen );

			Framerate.SetSpeedFactor();

			//SDL_BlitSurface( screen, &src, temp, NULL );

			while( direction )
			{
				if( direction == 1 ) // Right
				{
					xpos += Framerate.speedfactor;
					width -= Framerate.speedfactor;

					if( (int)xpos > 50 )
					{
						direction = 0;
					}
				}
				else // down
				{
					ypos += Framerate.speedfactor;
					height -= Framerate.speedfactor;

					if( (int)ypos > 50 )
					{
						direction = 0;
					}
				}

				src.x = (Sint16)xpos;
				src.y = (Sint16)ypos;
				src.w = (Uint16)width;
				src.h = (Uint16)height;

				SDL_BlitSurface( temp, &src, screen, NULL );
				SDL_Flip( screen );
				//SDL_FillRect( screen, 0, 0 );

				Framerate.SetSpeedFactor();
			}
		
			SDL_FreeSurface( temp );
		}
		break;
	case 100 : // Fixed Rectangle Pixelation (SMW style)
		{
			double xsize = 4.5;
			int xtemp = 0;
			Uint16 xpos = 0;
			Uint16 ypos = 0;

			SDL_Rect Rct;
			
			LockSurface( screen );
			SDL_Surface *temp = SDL_CreateRGBSurfaceFrom( screen->pixels, screen->w, screen->h, screen->format->BitsPerPixel, screen->pitch, screen->format->Rmask, screen->format->Gmask, screen->format->Bmask, screen->format->Amask );
			UnlockSurface( screen );

			Framerate.SetSpeedFactor();

			while( xsize < 45 )
			{
				xsize += Framerate.speedfactor*2.2;

				if( xtemp < (int)xsize )
				{
					xpos = (int)(rand() % ((unsigned int)xsize)) + 1;
					ypos = (int)(rand() % ((unsigned int)xsize)) + 1;
					xtemp = (int)xsize + 1;
				}

				for( int g = xpos;g < screen->w;g += (int)(xsize) )
				{
					for( int y = ypos;y < screen->h;y += (int)(xsize) )
					{
						Rct.x = g;
						Rct.y = y;
						
						Rct.w = (int)xsize;
						Rct.h = (int)xsize;

						LockSurface( temp );
						Uint32 Pixel = SDL_GetPixel( temp, Rct.x ,Rct.y );
						UnlockSurface( temp );
						
						Rct.x -= 2 + (int)( xsize/2 );
						Rct.y -= 2 + (int)( xsize/2 );
						
						SDL_FillRect( screen, &Rct, Pixel );
					}
				}

				SDL_Flip( screen );

				Framerate.SetSpeedFactor();
			}

			SDL_FreeSurface( temp );
			
			
			break;
		}
	default:
		{
			printf( "Warning unknown Effect : %d\n", effect );
		}
		break;
	}
	
	Framerate.SetSpeedFactor();
}


bool KeyPressed( unsigned int key )
{
	if( key == KEY_ENTER )
	{
		if( pJoystick->Button( pPreferences->Joy_item ) || 
			( event.type == SDL_KEYDOWN && ( event.key.keysym.sym == SDLK_RETURN || event.key.keysym.sym == SDLK_KP_ENTER ) ) )
		{
			return 1;
		}
	}
	else if( key == KEY_ESC )
	{
		if( pJoystick->Button( pPreferences->Joy_exit ) || 
			( event.type == SDL_KEYDOWN && ( event.key.keysym.sym == SDLK_ESCAPE || event.key.keysym.sym == SDLK_BACKSPACE ) ) )
		{
			return 1;
		}
	}
	else if( key == KEY_LEFT )
	{
		if( pJoystick->Left() || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_LEFT) )
		{
			return 1;
		}		
	}
	else if( key == KEY_RIGHT )
	{
		if( pJoystick->Right() || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_RIGHT) )
		{
			return 1;
		}		
	}
	else if( key == KEY_UP )
	{
		if( pJoystick->Up() || ( event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_UP ) )
		{
			return 1;
		}
	}
	else if( key == KEY_DOWN )
	{
		if( pJoystick->Down() || ( event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_DOWN ) )
		{
			return 1;
		}
	}

	return 0;
}

// Clears the Keyboard Queue
void ClearEvents( void )
{
	SDL_Event inEvent;

	while( SDL_PollEvent( &inEvent ) )
	{
		continue;  // ignore
	}
}

void DrawShadowedBox( SDL_Surface *dst, Sint16 x, Sint16 y, Sint16 w, Sint16 h, Uint8 r, Uint8 g, Uint8 b, 
					 Uint8 alpha, Uint8 shadowsize )
{
	boxRGBA( dst, x, y, x + w, y + h, r, g, b, alpha );
	
	if( !shadowsize )
	{
		return;
	}

	if( alpha < 255 )
	{
		if( alpha*2 > 255 )
		{
			alpha = 255;
		}
		else
		{
			alpha *= 2;
		}
	}
	
	boxRGBA( dst, x + w + 1, y + 1, x + w + shadowsize, y + h, r/2, g/2, b/2, alpha );
	boxRGBA( dst, x + 1, y + h + 1, x + w + shadowsize, y + h + shadowsize, 0 + r/2, g/2, b/2, alpha );
}

string EditMessageBox( string default_text, string title_text, Uint16 pos_x, Uint16 pos_y, bool auto_no_text /* = 1  */)
{
	std :: string sDescription = default_text;

	bool Entered = 0;

	SDL_Rect Srect2; // Colored Background Rects
	SDL_Rect Drect,Drect2; // Title and Description Rect
	SDL_Rect Erect; // default text Background Color Rect

	SDL_Surface *Title_Text = TTF_RenderText_Shaded( font, title_text.c_str(), colorBlack, colorWhite );
	SDL_Surface *Entered_Description = TTF_RenderText_Shaded( font, sDescription.c_str() , colorBlack, colorWhite );
	
	SDL_Rect pos_rect;

	pos_rect.x = pos_x;
	pos_rect.y = pos_y;
	pos_rect.w = 350;
	pos_rect.h = Entered_Description->h + 2;

	Srect2 = pos_rect;
	Srect2.x += 1;
	Srect2.y += 1;
	Srect2.h -= 2;
	Srect2.w -= 2;
	
	Drect = Srect2;
	Drect.y -= Srect2.h + 2;
	Drect.x += (pos_rect.w/2) - ( Title_Text->w/2 ) - 5;
	Drect2 = Srect2;

	Erect = Drect;
	Erect.x -= 2;
	Erect.y -= 2;
	Erect.h = Title_Text->h + 4;
	Erect.w = Title_Text->w + 4;

	sDescription.reserve( 30 );
	
	SDL_EnableUNICODE( 1 );

	while( !Entered )
	{
		SDL_FillRect( screen, &pos_rect, green );
		SDL_FillRect( screen, &Srect2, white );

		SDL_FillRect( screen, &Erect, darkblue );
		
		SDL_BlitSurface( Title_Text, NULL ,screen, &Drect );
		SDL_BlitSurface( Entered_Description, NULL, screen, &Drect2 );

		SDL_Flip( screen );

		while( SDL_PollEvent( &event ) )
		{
			keys = SDL_GetKeyState( NULL );

			if( KeyPressed( KEY_ESC) && event.key.keysym.sym != SDLK_BACKSPACE )
			{
				sDescription = "";
				Entered = 1;
			}
			else if ( KeyPressed( KEY_ENTER ) )
			{
				Entered = 1;
			}
			else if( event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_BACKSPACE )
			{
				if( sDescription.length() <= 1 || ( sDescription.compare( default_text ) == 0 && auto_no_text ) )
				{
					sDescription = "";

					if( Entered_Description )
					{
						SDL_FreeSurface( Entered_Description );
						Entered_Description = NULL;
					}

					Entered_Description = TTF_RenderText_Shaded( font, " ", colorBlack, colorWhite );
				}
				else
				{
					sDescription.erase( sDescription.length() - 1, 1 );
					
					if( Entered_Description )
					{
						SDL_FreeSurface( Entered_Description );
						Entered_Description = NULL;
					}
					
					Entered_Description = TTF_RenderText_Shaded( font, sDescription.c_str(), colorBlack, colorWhite );
				}
			}
			else if( event.type == SDL_KEYDOWN && event.key.keysym.sym != SDLK_ESCAPE )
			{
				if( event.key.keysym.unicode && sDescription.length() < 30 )
				{
					if( sDescription.compare( default_text ) == 0 && auto_no_text )
					{
						sDescription = "";
					}
					
					sDescription.insert( sDescription.length(), 1, (char)event.key.keysym.unicode );
					
					if( Entered_Description ) 
					{
						SDL_FreeSurface( Entered_Description );
						Entered_Description = NULL;
					}

					Entered_Description = TTF_RenderText_Shaded( font, sDescription.c_str(), colorBlack, colorWhite );
				}
			}
		}
		
		Framerate.SetSpeedFactor();
	}

	SDL_EnableUNICODE( 0 );

	if( Entered_Description )
	{
		SDL_FreeSurface( Entered_Description );
		Entered_Description = NULL;
	}

	if( Title_Text )
	{
		SDL_FreeSurface( Title_Text );
		Title_Text = NULL;
	}

	return sDescription;
}

void Preload_images( void )
{
	// The Mushrooms
	GetImage( "game/items/mushroom_red.png" );
	GetImage( "game/items/mushroom_green.png" );

	// The Box
	GetImage( "game/box/brown1_1.png" );

	// The Flower
	GetImage( "game/items/flower_red_1.png" );
	GetImage( "game/items/flower_red_2.png" );

	// The Goldpiece Animation
	GetImage( "animation/light_1/1.png" );
	GetImage( "animation/light_1/2.png" );
	GetImage( "animation/light_1/3.png" );
}

bool RectIntersect( SDL_Rect *r1, SDL_Rect *r2 )
{
	if( r1->x + r1->w <= r2->x )
	{
		return 0;
	}
	if( r1->x >= r2->x + r2->w )
	{
		return 0;
	}
	if( r1->y + r1->h <= r2->y ) 
	{
		return 0;
	}
	if( r1->y >= r2->y + r2->h )
	{
		return 0;
	}

	return 1;
}

bool FullRectIntersect( SDL_Rect *r1, SDL_Rect *r2 )
{
	if( r1->x <= r2->x )
	{
		return 0;
	}
	if( r1->x + r1->w >= r2->x + r2->w )
	{
		return 0;
	}
	if( r1->y <= r2->y )
	{
		return 0;
	}
	if( r1->y + r1->h >= r2->y + r2->h )
	{
		return 0;
	}

	return 1;
}

bool Delete_file( string filename )
{
	if( remove( filename.c_str() ) == 0 )
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

bool valid_file( string filename )
{
	ifstream ifs( filename.c_str(), ios::in );

	if( ifs ) 
	{
		ifs.close();
		return 1;
	}

	return 0;
}


void LockSurface( SDL_Surface *surface )
{
	if( SDL_MUSTLOCK( surface ) )
	{
		if( SDL_LockSurface( surface ) == -1 )
		{
			printf( "Warning : Couldn't lock Surface\n" );
		}
	}
}

void UnlockSurface( SDL_Surface *surface )
{
	if( SDL_MUSTLOCK( surface ) )
	{
		SDL_UnlockSurface( surface);
	}
}
