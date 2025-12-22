/***************************************************************************
              jpiranha.cpp  -  jprinha,jumping piranha plant
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

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cjPiranha :: cjPiranha( double x, double y, int mh ) : cEnemy( x, y )
{
	massive = 1;
	velx = 0;
	vely = -5.8;
	direction = 0;
	walk_count = rand() % (8);
	iCollisionType = 0;
	state = 0;
	max_h = mh;
	wait_time = rand() % (90);

	type = TYPE_JPIRANHA;

	images[0] = GetImage( "Enemy/jpiranha/c1.png" );
	images[1] = GetImage( "Enemy/jpiranha/c2.png" );
	images[2] = GetImage( "Enemy/jpiranha/o1.png" );
	images[3] = GetImage( "Enemy/jpiranha/o2.png" );
	
	SetImage( images[0] );
	SetPos( x, y );
}

cjPiranha :: ~cjPiranha( void )
{
	for( int i = 0;i < 4;i++ )
	{
		images[i] = NULL;
	}	
}

void cjPiranha :: Die( void )
{
	dead = 1;
	massive = 0;
	SetImage( images[0] );
}

void cjPiranha :: DieStep( void )
{
	visible = 0;
}

void cjPiranha :: Update( void )
{
	if( dead )
	{
		if( visible )
		{
			DieStep();
		}

		return;
	}

	// 8000 should be enough
	if( posx < pPlayer->posx - 8000 || posy < pPlayer->posy - 8000 || posx > pPlayer->posx + 8000 || posy > pPlayer->posy + 8000 )
	{
		return;
	}

	if( startposy - posy > 70 && startposy - posy < 210 && vely < - 0.5 )
	{
		AddVel( 0, -vely*0.04 );
	}
	else if( startposy - posy > 200 && wait_time < 1 )
	{
		vely = 0.5;
	}
	else if( startposy - posy > 100 && wait_time < 1 )
	{
		AddVel( 0, vely*0.025 );
	}
	else if( startposy - posy < 0 && vely > 0.3 )
	{
		wait_time = DESIRED_FPS * 3;
		vely = 0.0;
	}
	else if( wait_time > 0 )
	{
		wait_time -= Framerate.speedfactor;
	}
	else if( startposy - posy < 0 )
	{
		SDL_Rect r2 = this->rect;
		r2.y -= 40;
		r2.h += 40;

		if( RectIntersect( &pPlayer->rect, &r2 ) ) // new
		{
			wait_time = DESIRED_FPS * 2;
		}
		else
		{
			vely = -7.0;
		}
	}

	walk_count += Framerate.speedfactor;
	
	if ( walk_count > 8 )
	{
		walk_count = -8;
	}
	
	if ( walk_count < -4 )
	{
		SetImage(images[0]);
	}
	else if ( walk_count < 0 )
	{
		SetImage(images[1]);
	}
	else if ( walk_count < 4 )
	{
		SetImage(images[2]);
	}
	else
	{
		SetImage(images[3]);
	}

	if( CollideMove() )
	{
		Move( velx, vely, 0, 1 );

		SDL_Rect r2;
		
		switch (iCollisionType)
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
		default:
			memset( &r2, 0, sizeof(r2) );
			break;
		}
		
		if (iCollisionType == 4 && massive && visible)
		{
			this->PlayerCollision( collid );
		}
	}

   	if ( EnemyCount && visible && !dead )
	{
		Draw( screen );
	}
}

void cjPiranha :: PlayerCollision( int cdirection )
{
	if( cdirection != -1 )
	{
		pPlayer->Die();
	}
}
