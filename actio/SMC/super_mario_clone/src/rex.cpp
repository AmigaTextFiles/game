/***************************************************************************
           rex.cpp  -  the little dinosaur
                             -------------------
    copyright            : (C) 2004-2005 by FluXy
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

cRex :: cRex( double x, double y ) : cEnemy( x, y )
{
	massive = 1;
	velx = 2.5;
	vely = 0;
	direction = RIGHT;
	walk_count = 0;
	iCollisionType = 0;
	state = 1; // normal Walking
	
	Array = ARRAY_ENEMY;
	
	type = TYPE_REX;

	speed = 6.0;

	images[0] = GetImage( "Enemy/Rex/l1.png" );		// Walking left 1
	images[1] = GetImage( "Enemy/Rex/l2.png" );		// Walking left 2
	images[2] = GetImage( "Enemy/Rex/l3.png" );		// small Walking left 1
	images[3] = GetImage( "Enemy/Rex/l4.png" );		// small Walking left 2

	images[4] = GetImage( "Enemy/Rex/ld.png" );		// dead left
	
	images[5] = GetImage( "Enemy/Rex/r1.png" );		// Walking right 1
	images[6] = GetImage( "Enemy/Rex/r2.png" );		// Walking right 2
	images[7] = GetImage( "Enemy/Rex/r3.png" );		// small Walking right 1
	images[8] = GetImage( "Enemy/Rex/r4.png" );		// small Walking right 2

	images[9] = GetImage( "Enemy/Rex/rd.png" );		// dead right
	
	SetImage( images[5] ); // walking right 1
	SetPos( x, y );
}

cRex :: ~cRex( void )
{
	for( int i = 0; i < 10; i++ )
	{
		images[i] = NULL;
	}	
}

void cRex :: Die( void )
{
	dead = 1;
	massive = 0;

	if( state == 1 ) 
	{
		Move( 0, images[1]->h - images[4]->h, 1, 1 );
	}
	else if( state == 2 )
	{
		Move( 0, images[3]->h - images[4]->h, 1, 1 );
	}

	if( direction == RIGHT )
	{
		SetImage( images[9] );
	}
	else
	{
		SetImage( images[4] );
	}

	counter = 0;
}

void cRex :: DieStep( void )
{
	counter += Framerate.speedfactor;

	if( counter > DESIRED_FPS * 2 )
	{
		visible = 0;
	}

	Draw( screen );
}

void cRex :: Update( void )
{
	if( dead )
	{
		if( visible )
		{
			DieStep();
		}

		return;
	}

	if( ( posx < pPlayer->posx - 4000 || posy < pPlayer->posy - 4000 || posx > pPlayer->posx + 4000 || posy > pPlayer->posy + 4000 ) )
	{
		return;
	}

	counter += Framerate.speedfactor;
	
	if( state == 1 ) 
	{
		if( counter > (double)(DESIRED_FPS/7 * 2) )
		{
			counter = 0;
		}
	}
	else
	{
		if( counter > (double)(DESIRED_FPS/10 * 2) )
		{
			counter = 0;
		}
	}


	if( velx < 0 )
	{
		if( state == 1 )
		{
			if( counter < (double)(DESIRED_FPS/7) )
			{
				SetImage( images[0] ); // walking left 1
			}
			else
			{
				SetImage( images[1] ); // walking left 2
			}
		}
		else
		{
			if( counter < (double)(DESIRED_FPS/10) )
			{
				SetImage( images[2] ); // small walking left 1
			}
			else
			{
				SetImage( images[3] ); // small walking left 2
			}
		}
	}
	else
	{
		if( state == 1 )
		{
			if( counter < (double)(DESIRED_FPS/7) )
			{
				SetImage( images[5] ); // walking right 1
			}
			else 
			{
				SetImage( images[6] ); // walking right 2
			}
		}
		else
		{
			if( counter < (double)(DESIRED_FPS/10) )
			{
				SetImage( images[7] ); // small walking right 1
			}
			else
			{
				SetImage( images[8] ); // small walking right 2
			}
		}
	}
	
	if( !PosValid( (int)posx, (int)posy + 1,(int)(rect.w*0.85) ) && vely > -1 && iCollisionType != 4 )
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
		AddVel( 0, 1.5 + vely*0.1 );
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
			break;
		default:
			memset( &r2, 0, sizeof( r2 ) );
			break;
		}
		
		if( collid == RIGHT || collid == LEFT )
		{
			velx *= -1;

			Move( velx, vely );
		}
		else if( posx < 1 )
		{
			velx *= -1;

			Move( velx, vely );
		}
		

		if( iCollisionType == 4 )
		{
			this->PlayerCollision( collid );
			
			if( EnemyCount && !dead && visible ) 
			{
				Move( velx, vely );
			}
		}
	}

	if( EnemyCount && !dead ) 
	{
		Draw( screen );
	}
}

void cRex :: PlayerCollision( int cdirection )
{
	if( cdirection == DOWN )
	{
		if( state == 1 )
		{
			pointsdisplay->AddPoints( 20, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else if( state == 2 )
		{
			pointsdisplay->AddPoints( 40, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else
		{
			printf( "Rex state error : %d", state );
		}
		
		if( state == 1 )
		{
			counter = 0;
			state = 2; // small walking

			if( velx < 0 ) 
			{
				velx = -speed;
				Move( 0, images[1]->h - images[2]->h - 1, 1, 1 );
			}
			else
			{
				velx = speed;
				Move( 0, images[6]->h - images[7]->h - 1, 1, 1 );
			}
		}
		else if( state == 2 )
		{
			counter = 0;
			state = 0;

			Move( 0, images[3]->h - images[4]->h, 1, 1 );
			Die();
		}

		pAudio->PlaySound( SOUNDS_DIR "/stomp_1.ogg" );

		pPlayer->start_enemyjump = 1;
	}
	else if( !dead && direction != -1 )
	{
		pPlayer->Die();
	}
}

void cRex :: EnemyCollision( int cdirection )
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
