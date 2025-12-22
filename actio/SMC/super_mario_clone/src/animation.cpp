/***************************************************************************
           Animation.cpp  -  Animation class
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

cAnimation :: cAnimation( double posx, double posy, int animtype, int height, int width ) : cSprite( NULL, posx, posy )
{
	spawned = 1;

	counter = 0;
	massive = 0;

	Array = ARRAY_ANIM;
	type = TYPE_ACTIVESPRITE;
	

	for( int i = 0;i < 4;i++ )
	{
		rects[i].x = (int)rand() % ( width );
		rects[i].y = (int)rand() % ( height );
	}

	if( animtype == 1 )
	{
		images[0] = GetImage( "animation/light_1/1.png" );
		images[1] = GetImage( "animation/light_1/2.png" );
		images[2] = GetImage( "animation/light_1/3.png" );
	}
	else
	{
		printf( "Invalid Animation Type : %d\n", animtype );
		visible = 0;
	}

	SetImage( images[0] );
}

cAnimation :: ~cAnimation( void )
{
	for( int i = 0;i < 3;i++ )
	{
		images[i] = NULL;
	}
}

void cAnimation :: Update( void )
{
	if( !visible )
	{
		return;
	}

	counter += Framerate.speedfactor;

	for( int i = 0;i < 4;i++ )
	{
		switch( i ) 
		{
		case 0:
			{
				if( counter < 3 )
				{
					SetImage( NULL );
				}
				else if( counter < 6 )
				{
					SetImage( images[0] );
				}
				else if( counter < 9 )
				{
					SetImage( images[1] );
				}
				else if( counter < 12 )
				{
					SetImage( images[0] );
				}
			}
			break;
		case 1:
			{
				if( counter < 3 )
				{
					SetImage( images[0] );
				}
				else if( counter < 6 )
				{
					SetImage( images[1] );
				}
				else if( counter < 9 )
				{
					SetImage( images[2] );
				}
				else if( counter < 12 )
				{
					SetImage( images[1] );
				}
			}
			break;
		case 2:
			{
				if( counter < 3 )
				{
					SetImage( images[1] );
				}
				else if( counter < 6 )
				{
					SetImage( images[2] );
				}
				else if( counter < 9 )
				{
					SetImage( images[0] );
				}
				else if( counter < 12 )
				{
					SetImage( NULL );
				}			
			}
			break;
		case 3:
			{
				if( counter < 3 )
				{
					SetImage( images[0] );
				}
				else if( counter < 6 )
				{
					SetImage( images[1] );
				}
				else if( counter < 9 )
				{
					SetImage( images[0] );
				}
				else if( counter < 12 )
				{
					SetImage( images[0] );
				}
			}
			break;
		default:
			break;
		}

		if( image )
		{
			SDL_Rect r = rects[i];

			r.x -= (int)(cameraposx - posx);
			r.y -= (int)(cameraposy - posy);

			r.w = image->w;
			r.h = image->h;
			
			SDL_BlitSurface( image, NULL, screen, &r );	
		}
	}

	if( counter > 11 || counter < 0 )
	{
		visible = 0;
	}
}

void UpdateAnimatons( void )
{
	if( !AnimationObjects || AnimationCount < 1 )
	{
		return;
	}
	
	for( int i = 0;i < AnimationCount;i++ )
	{
		if( !AnimationObjects[i] )
		{
			continue;
		}

		AnimationObjects[i]->Update();
	
		if( !AnimationObjects[i]->visible ) // if animation has ended delete the animation spite
		{
			delete AnimationObjects[i];
			AnimationObjects[i] = NULL;

			AnimationCount--;

			if( AnimationCount > 1 && AnimationCount != i )
			{
				AnimationObjects[i] = AnimationObjects[AnimationCount];
				AnimationObjects[AnimationCount] = NULL;

			}
		}
	}
}

void AddAnimation( double posx, double posy, unsigned int animtype, int height, int width )
{
	cAnimation *temp = new cAnimation( posx, posy, animtype, height, width );

	AnimationObjects = (cSprite**) realloc( AnimationObjects  , ++AnimationCount * sizeof(cSprite*) );
	AnimationObjects[ AnimationCount - 1 ] = (cSprite*)temp;
}

void DeleteAllAnimations( void )
{
	if( !AnimationObjects )
	{
		return;
	}

	for( int i = 0; i < AnimationCount; i++ )
	{
		if( AnimationObjects[i] ) 
		{
			delete AnimationObjects[i];
			AnimationObjects[i] = NULL;
		}
	}

	delete []AnimationObjects;
	AnimationObjects = NULL;

	AnimationCount = 0;
}
