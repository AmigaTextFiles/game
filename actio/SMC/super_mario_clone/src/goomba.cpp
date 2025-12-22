/***************************************************************************
              goomba.cpp  -  goomba, little moving around enemy
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

cGoomba :: cGoomba( double x, double y,int color ) : cEnemy( x, y )
{
	massive = 1;
	vely = 0;
	direction = 0;
	walk_count = 0;
	iCollisionType = 0;
	state = 0;

	if( color == 0 ) // Brown
	{
		images[0] = GetImage ( "Enemy/Goomba/brown/r.png" );
		images[1] = GetImage ( "Enemy/Goomba/brown/l.png" );
		images[2] = GetImage ( "Enemy/Goomba/brown/dead.png" );
		velx = 2.7;
		anispeed = 16;
		type = TYPE_GOOMBA_BROWN;
	}
	else if( color == 1 ) // Red
	{
		// Todo : Red not Blue !!
		images[0] = GetImage ( "Enemy/Goomba/blue/r.png" );
		images[1] = GetImage ( "Enemy/Goomba/blue/l.png" );
		images[2] = GetImage ( "Enemy/Goomba/blue/dead.png" );
		velx = 4.5;
		anispeed = 12;
		type = TYPE_GOOMBA_RED;
	}
	else
	{
		printf( "Goomba Color Error color : %d", color );
		exit( 1 );
	}

	
	SetImage( images[0] );
	SetPos( x, y );
}

cGoomba :: ~cGoomba( void )
{
	for( int i = 0;i < 3;i++ )
	{
		images[i] = NULL;
	}

	SetImage( NULL );
}

void cGoomba :: Die( void )
{
	dead = 1;
	massive = 0;

	SetImage( images[2] );
	Move( 0, images[1]->h - images[2]->h, 1 );
}

void cGoomba :: DieStep( void )
{
	counter += Framerate.speedfactor;

	if ( counter > DESIRED_FPS )
	{
		visible = 0;	
	}

	this->Draw( screen );
}

void cGoomba :: Update( void )
{
	if( dead )
	{
		if( visible )
		{
			DieStep();
		}

		return;
	}

	walk_count += Framerate.speedfactor;
	
	if ( walk_count > anispeed )
	{
		walk_count = 1;
	}
	
	if ( walk_count > anispeed/2 )
	{
		SetImage( images[0] );
	}
	else
	{
		SetImage( images[1] );
	}
	
	if( vely > -1 && !PosValid( (int)posx, (int)posy + 1, (int)(rect.w*0.85) ) && iCollisionType != 4 )
	{
		if( iCollisionType == 2 && ActiveObjects[iCollisionNumber]->halfmassive )
		{
			onGround = 2;
		}
		else
		{
			onGround = 1;
		}
	}
	else
	{
		onGround = 0;
	}

	if( !onGround && vely < 25 )
	{
		AddVel( 0,2 + ( vely*0.05 ) );
	}
	else if( onGround && vely != 0 )
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
		default:
			memset( &r2, 0, sizeof( r2 ) );
			break;
		}
		
		if( iCollisionType && iCollisionType != 4 )
		{
			if( collid == RIGHT || collid == LEFT )
			{
				velx *= -1;
				Move( velx, vely );
			}
		}
		else if( posx < 1 )
		{
			velx *= -1;
			Move( velx, vely );
		}

		if( iCollisionType == 4 && massive )
		{
			this->PlayerCollision( collid );

   			if( EnemyCount && !dead )
			{
				if( collid != -1 ) 
				{
					velx *= -1;
				}
				
				Move( velx, vely );
			}
		}
	}

   	if( EnemyCount && !dead )
	{
		Draw( screen );
	}
}

void cGoomba :: PlayerCollision( int cdirection )
{
	if( cdirection == DOWN )
	{
		pAudio->PlaySound( SOUNDS_DIR "/stomp_2.ogg" );
		this->Die();
		pPlayer->start_enemyjump = 1;

		if( type == TYPE_GOOMBA_BROWN )
		{
			pointsdisplay->AddPoints( 10, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else if( type == TYPE_GOOMBA_RED )
		{
			pointsdisplay->AddPoints( 50, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else
		{
			printf( "Goomba type error : %d", type );
		}
	}
	else if( !dead && cdirection != -1 )
	{
		pPlayer->Die();
	}
}
void cGoomba :: EnemyCollision( int cdirection )
{
	if( cdirection == LEFT && velx > 0 ) 
	{
		velx *= -1;
	}
	else if( cdirection == RIGHT && velx < 0 ) 
	{
		velx *= -1;
	}
}
