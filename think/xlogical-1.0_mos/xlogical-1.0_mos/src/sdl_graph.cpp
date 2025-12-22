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




#include <iostream>
#include <errno.h>
#include <list>
#include <string>

#ifdef WIN32
#else
#include <sys/time.h>
#include <unistd.h>
#endif

#include <SDL.h>
#include <SDL_timer.h>

#include "sdl_graph.h"
#include "SDL_image.h"
#include "exception.h"
#include "defs.h"
#include "graph_images.h"
#include "properties.h"

//#define DEBUG_FUNC

const Uint32 kTicksPerLoop	= 30;

SDL_Surface *tile_images[NUM_DEFAULT_ICONS];
SDL_Surface *mainScreen;
SDL_Surface *bgScreen;

list<SDL_Rect *>rectList;
int	currentBGPixmap;

void load_images( void );
void draw_background( void  );
keysyms keycode_to_keysym( unsigned int );

Csdl_graph::Csdl_graph( void )
{
	// Load up the fonts
	fLoFont = new CText;
	fLoFont->set_font_info( BMP_FONT_1, 30, 30, 5, ' ', 'Z' );

	fHiFont = new CText;
	fHiFont->set_font_info( BMP_FONT_2, 30, 30, 5, ' ', 'Z' );
}

int
Csdl_graph::graph_setup( int *argc, char ***argv, int width, int height )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_setup( )" << endl;
#endif
	int fullscreen = 0;
	int depth = 0;

	// Set our boundaries
	reqWidth = width;
	reqHeight = height;

	string videoMode=properties::instance().get( "video.mode" );
	if (videoMode == "fullscreen")
	{
		fullscreen = 1;
		get_std_resolution( width, height, mainWidth, mainHeight );
		if ((mainWidth <= 0) || (mainHeight <= 0))
		{
cout << "xxxsgraphErrorxxx" << endl;
			ThrowEx( "no supported resolutions found" );
		}
		mainXOffset = (mainWidth - width) / 2;
		mainYOffset = (mainHeight - height) / 2;
	} else {
		mainXOffset = 0;
		mainYOffset = 0;
		mainWidth = reqWidth;
		mainHeight = reqHeight;
	}

	// See if we can set up a video mode of any kind
	if( SDL_InitSubSystem( SDL_INIT_VIDEO ) < 0 )
	{
		throw( CXLException( "Could not init video", "ack", 0 ) );
	}

	// Try to get our requested depth
	if( fullscreen == 1 )
	{
		depth = SDL_VideoModeOK( mainWidth, mainHeight, 16, 
											SDL_FULLSCREEN );
		if( depth )
		{
			mainScreen = SDL_SetVideoMode( mainWidth, mainHeight, 16, 
											SDL_FULLSCREEN );
		}
	} else {
		depth = SDL_VideoModeOK( mainWidth, mainHeight, 16, 0 ); 
		if( depth )
		{
			mainScreen = SDL_SetVideoMode( mainWidth, mainHeight, 16, 0 );
		}
	}

	// Set the window manager caption stuff
	SDL_WM_SetCaption( "XLogical", "XLogical" );

	// Load up the image tiles
	load_images( );

	// Set up the background screen
	bgScreen = SDL_CreateRGBSurface( 
			SDL_HWSURFACE, mainWidth, mainHeight, 16, 0, 0, 0, 0);
	bgScreen = SDL_DisplayFormat( bgScreen );
	SDL_FillRect( bgScreen, NULL, 0 );

	return( 0 );
}

void
Csdl_graph::graph_start( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_start( )" << endl;
#endif
	SDL_Event event;
	Uint32 start, elapsed;
	bool done = false;

	while( !done )
	{
		start = SDL_GetTicks();

		game_loop( );

		while( SDL_PollEvent( &event ) )
		{
			switch( event.type )
			{
				case SDL_KEYDOWN:
					if( keyPressFunc == NULL )
					{
						break;
					}
					keyPressFunc( keycode_to_keysym( event.key.keysym.sym ) );
					break;
				case SDL_MOUSEMOTION:
					break;
				case SDL_MOUSEBUTTONDOWN:
					clickFunc( 
						event.button.x - mainXOffset, 
						event.button.y - mainYOffset, 
						event.button.button );
					break;
				case SDL_QUIT:
					done = true;
					break;
				default:
					break;
			}
		}

		if( rectList.size( ) > 0 )
		{
			SDL_Rect *rects;
			int count = 0;
			rects = new SDL_Rect[ rectList.size( ) ];
			list<SDL_Rect *>::iterator it = rectList.begin( );
			for( ; it != rectList.end( ); it++ )
			{
				rects[count].x = (*it)->x;
				rects[count].y = (*it)->y;
				rects[count].w = (*it)->w;
				rects[count].h = (*it)->h;

#ifdef DEBUG_DRAW
				cerr << "("<< rects[count].x;
				cerr << ","<< rects[count].y << ") ";
				cerr << "("<< rects[count].w;
				cerr << ","<< rects[count].h << ") " << endl;;
#endif

				count++;

				delete (*it);

			}

			rectList.clear( );

			SDL_UpdateRects( mainScreen, count - 1, rects );

			delete [] rects;
		}

		elapsed = SDL_GetTicks() - start;

		if (elapsed < kTicksPerLoop)
		{
			SDL_Delay( kTicksPerLoop - elapsed );
		}
	}
}

void
load_images( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : load_images( )" << endl;
#endif
	SDL_Surface *image;

	for(int i = 0; i < NUM_DEFAULT_ICONS; i++ )
	{
		image = IMG_Load( imageFiles[i] );
		if( image == NULL )
		{
			throw( CXLException( SDL_GetError( ), imageFiles[i], 0 ) );
		}
		if( SDL_SetColorKey( image, (SDL_SRCCOLORKEY | SDL_RLEACCEL ), 
							SDL_MapRGB( image->format, 
							0x00, 0xFF, 0xFF )) == -1 )
		{
			throw( CXLException( "making transparent ", imageFiles[i], 0 ) );
		}
		tile_images[i] = SDL_DisplayFormat( image );
		if( tile_images[i] == NULL )
		{
			throw( CXLException( "converting format ", imageFiles[i], 0 ) );
		}
		SDL_FreeSurface( image );
	}
}

void
Csdl_graph::graph_reload( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_reload( )" << endl;
#endif
	if( rectList.size( ) > 0 )
	{
		list<SDL_Rect *>::iterator it = rectList.begin( );
		for( ; it != rectList.end( ); it++ )
		{
			delete (*it);
		}
		rectList.clear( );
	}
	(void) SDL_QuitSubSystem( SDL_INIT_VIDEO );

	int fullscreen = 0;
	int depth = 0;

	string videoMode=properties::instance().get( "video.mode" );
	if (videoMode == "fullscreen")
	{
		fullscreen = 1;
		get_std_resolution( reqWidth, reqHeight, mainWidth, mainHeight );
		if ((mainWidth <= 0) || (mainHeight <= 0))
		{
cout << "xxxsgraphErrorxxx" << endl;
			ThrowEx( "no supported resolutions found" );
		}
		mainXOffset = (mainWidth - reqWidth) / 2;
		mainYOffset = (mainHeight - reqHeight) / 2;
	} else {
		mainXOffset = 0;
		mainYOffset = 0;
		mainWidth = reqWidth;
		mainHeight = reqHeight;
	}

	// See if we can set up a video mode of any kind
	if( SDL_InitSubSystem( SDL_INIT_VIDEO ) < 0 )
	{
		throw( CXLException( "Could not init video", "ack", 0 ) );
	}

	// Try to get our requested depth
	if( fullscreen == 1 )
	{
		depth = SDL_VideoModeOK( mainWidth, mainHeight, 16, 
											SDL_FULLSCREEN );
		if( depth )
		{
			mainScreen = SDL_SetVideoMode( mainWidth, mainHeight, 16, 
											SDL_FULLSCREEN );
		}
	} else {
		depth = SDL_VideoModeOK( mainWidth, mainHeight, 16, 0 ); 
		if( depth )
		{
			mainScreen = SDL_SetVideoMode( mainWidth, mainHeight, 16, 0 );
		}
	}

	// Set the window manager caption stuff
	SDL_WM_SetCaption( "XLogical", "XLogical" );

	// Load up the image tiles
	load_images( );

	// Set up the background screen
	bgScreen = SDL_CreateRGBSurface( 
			SDL_HWSURFACE, mainWidth, mainHeight, 16, 0, 0, 0, 0);
	bgScreen = SDL_DisplayFormat( bgScreen );
	SDL_FillRect( bgScreen, NULL, 0 );

	currentBGPixmap = 0;
	reloadFunc();
}

void
Csdl_graph::graph_shutdown( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_shutdown( )" << endl;
#endif
	(void) SDL_QuitSubSystem( SDL_INIT_VIDEO );
}

void
Csdl_graph::game_loop( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " sdl_graph game_loop( )" << endl;
#endif
	loopFunc( );
}

void
Csdl_graph::graph_refresh( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_refresh( )" << endl;
#endif
	SDL_Rect *dstRect = new SDL_Rect;

	// Refresh the whole thing
	dstRect->x = 0;
	dstRect->y = 0;
	dstRect->w = mainWidth;
	dstRect->h = mainHeight;

	// Update the main display
	SDL_BlitSurface( 
		bgScreen,
		dstRect,
		mainScreen,
		dstRect );

}

void
Csdl_graph::graph_set_background( int pm )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_set_background( )" << endl;
#endif

	// Return if there's no change
	if( pm == currentBGPixmap )
	{
		return;
	}

	// Erase the old
	graph_clear_rect_perm( 0, 0, mainWidth, mainHeight );

	currentBGPixmap = pm;
	draw_background( );
}

void 
Csdl_graph::draw_background( void )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : draw_background( )" << endl;
#endif
	SDL_Rect srcRect;
	SDL_Rect *dstRect = new SDL_Rect;

	int width = tile_images[currentBGPixmap]->w;
	int height = tile_images[currentBGPixmap]->h;

	int row;
	int col;
	int yOffset;

	// check for special case where background is size of screen
	if (height >= reqHeight)
	{
		yOffset = 0;
	} else {
		yOffset = 50;
	}

	srcRect.x = 0;
	srcRect.y = 0;
	srcRect.w = width;
	srcRect.h = height;

	dstRect->w = width;
	dstRect->h = height;

	// Loop through the Clevel_map object
	// and draw background squares
	int tileAreaHeight = reqHeight - yOffset;
	for( row = 0; row < tileAreaHeight; row+=height )
	{
		for( col = 0; col < reqWidth; col+=width )
		{
			dstRect->x = col + mainXOffset;
			dstRect->y = row + yOffset + mainYOffset;

			SDL_BlitSurface( 
				tile_images[currentBGPixmap], 
				&srcRect,
				bgScreen,
				dstRect );

		}
	}

	// Refresh the whole thing
	dstRect->x = mainXOffset;
	dstRect->y = mainYOffset;
	dstRect->w = reqWidth;
	dstRect->h = reqHeight;

	// Update the main display
	SDL_BlitSurface( 
		bgScreen,
		dstRect,
		mainScreen,
		dstRect );

	// Update the rectangle list
	rectList.insert( rectList.end( ), dstRect );
}

// A smaller draw routine with some defaults
// Hopefully this will be used in most cases
void
Csdl_graph::graph_draw( int pm, int ulX, int ulY )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_draw( )" << endl;
#endif
	graph_draw_pixmap( pm, 0, 0, ulX, ulY, 0, 0, USE_MASK );
}

void
Csdl_graph::graph_draw_pixmap( int pm, int srcX, int srcY, int destX, 
				int destY, int xSize, int ySize, long flags )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_draw_pixmap(";
	cerr << pm << "," << srcX << "," << srcY << "," ;
	cerr << destX << "," << destY << "," ;
	cerr << xSize << "," << ySize << ")" << endl;
#endif

	SDL_Rect srcRect;
	SDL_Rect *dstRect = new SDL_Rect;

	srcRect.x = srcX;
	srcRect.y = srcY;
	srcRect.w = xSize==0?tile_images[pm]->w:xSize;
	srcRect.h = ySize==0?tile_images[pm]->h:ySize;

	dstRect->x = mainXOffset + destX;
	dstRect->y = mainYOffset + destY;
	dstRect->w = xSize==0?tile_images[pm]->w:xSize;
	dstRect->h = ySize==0?tile_images[pm]->h:ySize;

	SDL_BlitSurface( 
		tile_images[pm], 
		&srcRect,
		mainScreen,
		dstRect );

	rectList.insert( rectList.end( ), dstRect );
}

void
Csdl_graph::graph_draw_perm( int pm, int srcX, int srcY, int destX, 
				int destY, int xSize, int ySize )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_draw_pixmap(";
	cerr << pm << "," << srcX << "," << srcY << "," ;
	cerr << destX << "," << destY << "," ;
	cerr << xSize << "," << ySize << ")" << endl;
#endif

	SDL_Rect srcRect;
	SDL_Rect *dstRect = new SDL_Rect;;

	srcRect.x = srcX;
	srcRect.y = srcY;
	srcRect.w = xSize==0?tile_images[pm]->w:xSize;
	srcRect.h = ySize==0?tile_images[pm]->h:ySize;

	dstRect->x = destX + mainXOffset;
	dstRect->y = destY + mainYOffset;
	dstRect->w = xSize==0?tile_images[pm]->w:xSize;
	dstRect->h = ySize==0?tile_images[pm]->h:ySize;

	SDL_BlitSurface( 
		tile_images[pm], 
		&srcRect,
		bgScreen,
		dstRect );
}

void
Csdl_graph::graph_draw_rect( int ulx, int uly, int width, int height )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_draw_rect( ) " << endl;
#endif
}

void
Csdl_graph::graph_copy_area( int srcULX, int srcULY, int dstULX, int dstULY,
									int width, int height )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_copy_area(";
	cerr << srcULX << "," << srcULY << "," ;
	cerr << dstULX << "," << dstULY << "," ;
	cerr << width << "," << height << ")" << endl;
#endif
	SDL_Rect srcRect;
	SDL_Rect *dstRect = new SDL_Rect;

	srcRect.x = mainXOffset + srcULX;
	srcRect.y = mainYOffset + srcULY;
	srcRect.w = width;
	srcRect.h = height;

	dstRect->x = mainXOffset + dstULX;
	dstRect->y = mainYOffset + dstULY;
	dstRect->w = width;
	dstRect->h = height;

	SDL_BlitSurface( 
		mainScreen,
		&srcRect,
		mainScreen,
		dstRect );

	rectList.insert( rectList.end( ), dstRect );
}

void
Csdl_graph::graph_clear( void )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_clear( )" << endl;
#endif
	Uint32 color = 0;

	SDL_FillRect( mainScreen, NULL, color );
}

void
Csdl_graph::graph_clear_rect( int ulx, int uly, int width, int height )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_clear_rect( ) " << endl;
#endif
	SDL_Rect *dstRect = new SDL_Rect;
	Uint32 color = 0;

	dstRect->x = mainXOffset + ulx;
	dstRect->y = mainYOffset + uly;
	dstRect->w = width;
	dstRect->h = height;

    SDL_FillRect( mainScreen, dstRect, color );
	rectList.insert( rectList.end( ), dstRect );
}

void
Csdl_graph::graph_clear_rect_perm( int ulx, int uly, int width, int height )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_clear_rect( ) " << endl;
#endif
	SDL_Rect *dstRect = new SDL_Rect;
	Uint32 color = 0;

	dstRect->x = mainXOffset + ulx;
	dstRect->y = mainYOffset + uly;
	dstRect->w = width;
	dstRect->h = height;

    SDL_FillRect( bgScreen, dstRect, color );
	rectList.insert( rectList.end( ), dstRect );
}

void
Csdl_graph::graph_erase_rect( int ulx, int uly, int width, int height )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_erase_rect( ) " << endl;
#endif
	SDL_Rect *dstRect = new SDL_Rect;

	dstRect->x = mainXOffset + ulx;
	dstRect->y = mainYOffset + uly;
	dstRect->w = width;
	dstRect->h = height;

	SDL_BlitSurface( 
		bgScreen,
		dstRect,
		mainScreen,
		dstRect );

	rectList.insert( rectList.end( ), dstRect );
}

void
Csdl_graph::graph_erase_pixmap( int pm, int ulx, int uly )
{
#ifdef DEBUG_DRAW
	cerr << __FILE__ << " : Csdl_graph::graph_erase_pixmap( ) " << endl;
#endif
	SDL_Rect *dstRect = new SDL_Rect;

	dstRect->x = mainXOffset + ulx;
	dstRect->y = mainYOffset + uly;
	dstRect->w = tile_images[pm]->w;
	dstRect->h = tile_images[pm]->h;

	SDL_BlitSurface( 
		bgScreen,
		dstRect,
		mainScreen,
		dstRect );

	rectList.insert( rectList.end( ), dstRect );
}

void 
Csdl_graph::graph_set_reload_func( void(*func)(void) )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_set_reload_func( )" << endl;
#endif
	reloadFunc = func;
}

void 
Csdl_graph::graph_set_loop_func( void(*lFunc)(void) )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_set_loop_func( )" << endl;
#endif

	loopFunc = lFunc;
}

void 
Csdl_graph::graph_set_click_func( void(*cFunc)(int, int, int) )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_set_click_func( )" << endl;
#endif
	clickFunc = cFunc;
}

void 
Csdl_graph::graph_set_key_press_func( key_press_func_t kFunc )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : Csdl_graph::graph_set_key_press_func( )" << endl;
#endif
	keyPressFunc = kFunc;
}

int
Csdl_graph::graph_main_width( void )
{
	return( reqWidth );
}

int
Csdl_graph::graph_main_height( void )
{
	return( reqHeight );
}

CText *
Csdl_graph::graph_hi_font( void )
{
	return( fHiFont );
}

CText *
Csdl_graph::graph_lo_font( void )
{
	return( fLoFont );
}

ulong
Csdl_graph::graph_get_time( void )
{
	return( SDL_GetTicks() );
}

void
Csdl_graph::graph_delay( long delay )
{
	SDL_Delay( delay * 1000 );
}

keysyms
keycode_to_keysym( unsigned int keycode )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " :keycode_to_keysym( )" << endl;
#endif
	switch( keycode )
	{
		case SDLK_a:
			return( eA );
		case SDLK_b:
			return( eB );
		case SDLK_c:
			return( eC );
		case SDLK_d:
			return( eD );
		case SDLK_e:
			return( eE );
		case SDLK_f:
			return( eF );
		case SDLK_g:
			return( eG );
		case SDLK_h:
			return( eH );
		case SDLK_i:
			return( eI );
		case SDLK_j:
			return( eJ );
		case SDLK_k:
			return( eK );
		case SDLK_l:
			return( eL );
		case SDLK_m:
			return( eM );
		case SDLK_n:
			return( eN );
		case SDLK_o:
			return( eO );
		case SDLK_p:
			return( eP );
		case SDLK_q:
			return( eQ );
		case SDLK_r:
			return( eR );
		case SDLK_s:
			return( eS );
		case SDLK_t:
			return( eT );
		case SDLK_u:
			return( eU );
		case SDLK_v:
			return( eV );
		case SDLK_w:
			return( eW );
		case SDLK_x:
			return( eX );
		case SDLK_y:
			return( eY );
		case SDLK_z:
			return( eZ );
		case SDLK_0:
			return( e0 );
		case SDLK_1:
			return( e1 );
		case SDLK_2:
			return( e2 );
		case SDLK_3:
			return( e3 );
		case SDLK_4:
			return( e4 );
		case SDLK_5:
			return( e5 );
		case SDLK_6:
			return( e6 );
		case SDLK_7:
			return( e7 );
		case SDLK_8:
			return( e8 );
		case SDLK_9:
			return( e9 );
		case SDLK_ESCAPE:
			return( eEsc );
		case SDLK_UP:
			return( eUp );
		case SDLK_DOWN:
			return( eDown );
		case SDLK_LEFT:
			return( eLeft );
		case SDLK_RIGHT:
			return( eRight );
		case SDLK_SPACE:
			return( eSpace );
		case SDLK_BACKSPACE:
			return( eBackSpace );
		case SDLK_DELETE:
			return( eDelete );
		case SDLK_PERIOD:
			return( ePeriod );
		case SDLK_RETURN:
			return( eEnter );
	}
	return( eSpace );
}

void
Csdl_graph::get_std_resolution(
	int inWidth,
	int inHeight,
	int& stdWidth,
	int& stdHeight )
{
	static struct
	{
		int width;
		int height;
	} stdResolutions[] =
	{
		{ 640, 480 },
		{ 800, 600 },
		{1024, 768 },
		{1280, 1024},
		{1600, 1200},
		{  -1,   -1}	// must be last
	};

	int i;
	for(i=0; (stdResolutions[i].width != -1); i += 1)
	{
		if ((inWidth <= stdResolutions[i].width) &&
			(inHeight <= stdResolutions[i].height))
		{
			break;
		}
	}
	stdWidth = stdResolutions[i].width;
	stdHeight = stdResolutions[i].height;
}

