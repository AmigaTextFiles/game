/***************************************************************************
       powerup.cpp  -  classes for some powerups that can be found
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

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cPowerUp :: cPowerUp( double x, double y ) : cActiveSprite( x, y )
{
	counter = 0;
	
	type = TYPE_POWERUP;
	
	visible = 1;
	massive = 0;
	
	SetPos( x, y );
}

cPowerUp :: ~cPowerUp( void )
{
	//
}

void cPowerUp :: Update( void )
{
	this->Draw( screen );
}

void cPowerUp :: PlayerCollision( int direction )
{
	// virtual
}

void cPowerUp :: BoxCollision( int direction, SDL_Rect *r2 )
{
	// virtual
}
/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cMushroom :: cMushroom( double x, double y, int ntype ) : cPowerUp( x, y )
{
	visible = 1;
	massive = 0;

	if( ntype == TYPE_MUSHROOM_DEFAULT )
	{
		SetImage( GetImage( "game/items/mushroom_red.png" ) );
	}
	else if( ntype == TYPE_MUSHROOM_LIVE_1 ) 
	{
		SetImage( GetImage( "game/items/mushroom_green.png" ) );
	}
	else
	{
		printf( "Warning Unknown Mushroom type : %d\n", ntype );
		visible = 0;
	}

	type = ntype;
	
	SetPos( x, y );
	
	velx = 3;
}

cMushroom :: ~cMushroom( void )
{
	//
}

void cMushroom :: Update( void )
{
	if( !visible )
	{
		return;
	}

	if( RectIntersect( &this->rect, &pPlayer->rect ) )
	{
		visible = 0;
		pPlayer->Get_Item( type );
		
		if( type == TYPE_MUSHROOM_DEFAULT ) 
		{
			pointsdisplay->AddPoints( 500, (int)posx + image->w/2, (int)posy + 3 );
		}
		else if( type == TYPE_MUSHROOM_LIVE_1 ) 
		{
			pointsdisplay->AddPoints( 1000, (int)posx + image->w/2,(int)posy + 3 );
		}
	}

	onGround = !PosValid( (int)posx, (int)posy + 1 );

	if( !onGround && vely < 50 )
	{
		if( vely > 0 )
		{
			AddVel( 0, 0.5 + vely*0.05 );
		}
		else
		{
			AddVel( 0, 2.5 );
		}
	}
	else
	{
		vely = 0;
	}
	
	if( CollideMove() )
	{
		SDL_Rect r2;
		
		switch( iCollisionType )
		{
		case 1:
			r2 = MassiveObjects[iCollisionNumber]->rect;
			break;
		case 2:				
			r2 = ActiveObjects[iCollisionNumber]->rect;
			break;
		case 3:
			r2 = EnemyObjects[iCollisionNumber]->rect;
			break;
		case 4:
			r2 = pPlayer->rect;
		}
		
		if( ( iCollisionType == 1 || iCollisionType == 2 ) && ( collid == LEFT || collid == RIGHT ) )
		{
			velx *= -1;
			Move( velx, vely );
		}
		else if( posx == 0 && collid == LEFT ) 
		{
			velx *= -1;
			Move( velx, vely );
		}
	}

   	Draw( screen );
}

void cMushroom :: BoxCollision( int cdirection, SDL_Rect *r2 )
{
	if( cdirection == DOWN )
	{
		if( posx > r2->x && velx < 0 ) // left
		{
			velx *= -1;
		}
		else if( posx < r2->x && velx > 0 ) // right
		{
			velx *= -1;
		}
		
		vely = -30;
		Move( velx, vely, 0, 1 );
		onGround = 0;
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cFirePlant :: cFirePlant( double x, double y ) : cPowerUp( x, y )
{
	type = TYPE_FIREPLANT;
	
	visible = 1;
	massive = 0;
	
	images[0] = GetImage( "game/items/flower_red_1.png" );
	images[1] = GetImage( "game/items/flower_red_2.png" );

	SetImage( images[0] );

	SetPos( x, y );
}

cFirePlant :: ~cFirePlant( void )
{
	images[0] = NULL;
	images[1] = NULL;
}

void cFirePlant :: Update( void )
{
	if( !visible )
	{
		return;
	}

	counter += Framerate.speedfactor;
	
	if( (int)counter < (int)( DESIRED_FPS/2 ) )
	{
		SetImage( images[1] );
	}
	else if( (int)counter < DESIRED_FPS )
	{
		SetImage( images[0] );
	}
	else
	{
		counter = 0;
	}

	if( RectIntersect( &this->rect, &pPlayer->rect ) )
	{
		visible = 0;
		pPlayer->Get_Item( TYPE_FIREPLANT );

		pointsdisplay->AddPoints( 700, (int)posx + image->w/2,(int)posy );
	}

	this->Draw( screen );
}



/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cMoon :: cMoon( double x, double y ) : cPowerUp( x, y )
{
	type = TYPE_MOON;
	
	visible = 1;
	massive = 0;

	images[0] = GetImage( "game/items/moon_1.png" );
	images[1] = GetImage( "game/items/moon_2.png" );

	SetImage(  images[0] );

	SetPos( x, y );
}

cMoon :: ~cMoon( void )
{
	images[0] = NULL;
	images[1] = NULL;
}

void cMoon :: Update( void )
{
	if( !visible )
	{
		return;
	}

	counter += Framerate.speedfactor;
	
	if( (int)counter > DESIRED_FPS*3 )
	{
		SetImage( images[1] );
	}
	else if( (int)counter > 0 )
	{
		SetImage( images[0] );
	}
	
	if( counter > DESIRED_FPS*3.3 ) 
	{
		counter = 0;
	}

	if( RectIntersect( &this->rect, &pPlayer->rect ) )
	{
		visible = 0;
		pPlayer->Get_Item( TYPE_MOON );

		pointsdisplay->AddPoints( 4000, (int)posx + image->w/2, (int)posy );
	}

	this->Draw( screen );
}
