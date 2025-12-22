/***************************************************************************
           turtle.cpp  -  turtle enemy class
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

cTurtle :: cTurtle( double x, double y, int color ) : cEnemy( x, y )
{
	massive = 1;
	velx = 4;
	vely = 0;
	direction = RIGHT;
	walk_count = 0;
	iCollisionType = 0;
	state = 1; // Normal Walking
	playercounter = 0;
	
	Array = ARRAY_ENEMY;
	
	if( color == 1 ) // Red
	{
		type = TYPE_TURTLE_RED;
	}
	else // If there is an unknown/invalid color just set the default an print an error
	{
		printf("Invalid Turtle Color  : %d",color);
		type = TYPE_TURTLE_RED;
	}

	speed = 15.0;

	/*	Turtle Colors
	 *	
	 *	1 = Red
	 *	2 = Green
	 *	3 = Yellow
	 *	4 = Blue
	 *	5 = 
	 */

	if ( color == 1 ) // Red
	{
		images[0] = GetImage( "Enemy/Turtle/red/shell_m1r.png"	); // Red Shell Standard
		images[1] = GetImage( "Enemy/Turtle/red/shell_m2r.png"	); // Red Shell Blinks

		images[2] = GetImage( "Enemy/Turtle/red/turtle_l1r.png" ); // Red Turtle walking left 1
		images[3] = GetImage( "Enemy/Turtle/red/turtle_l2r.png" ); // Red Turtle walking left 2
		images[4] = GetImage( "Enemy/Turtle/red/turtle_r1r.png" ); // Red Turtle walking right 1
		images[5] = GetImage( "Enemy/Turtle/red/turtle_r2r.png" ); // Red Turtle walking right 2

		images[6] = GetImage( "Enemy/Turtle/red/shell_m3r.png"  ); // Red Shell Back
		images[7] = GetImage( "Enemy/Turtle/red/turtle_m1r.png" ); // Red Shell Standard
		images[8] = GetImage( "Enemy/Turtle/red/turtle_m2r.png" ); // Red Shell Blinks

		images[9] = GetImage( "Enemy/Turtle/red/shell_lr.png"	); // Red Shell moving right
		images[10]= GetImage( "Enemy/Turtle/red/shell_rr.png"	); // Red Shell moving left

		images[11]= GetImage( "Enemy/Turtle/red/shell_d.png"	); // Red Shell dead
	}
	else // if there is an unsopported/invalid color just set all images to null and print an Error
	{
		printf( "Error : Invalid or Unsupported Turtle images Color : %d\n", color );
		
		for( int i = 0;i < 12;i++ )
		{
			images[i] = NULL;
		}
	}
	
	SetImage( images[4] ); // Red Turtle walking right 1
	SetPos( x, y );
}

cTurtle :: ~cTurtle( void )
{
	for( int i = 0; i < 12; i++ )
	{
		images[i] = NULL;
	}	
}

void cTurtle :: Die( void )
{
	dead = 1;
	massive = 0;

	SetImage( images[11] );
	counter = 0;
}

void cTurtle :: DieStep( void )
{
	counter += Framerate.speedfactor;

	if( counter < 5 )
	{
		Move( 0, -5.0, 0, 1 );
	}
	else if( posy < pPreferences->Screen_H + rect.h )
	{
		Move( 0, 20.0, 0, 1 );
	}
	else
	{
		visible = 0;
	}

	Draw( screen );
}

void cTurtle :: Update( void )
{
	if( dead )
	{
		if( visible )
		{
			DieStep();
		}

		return;
	}

	// 4000 for walking and staying
	// 8000 for the fast shell
	if( ( state != 3 && ( posx < pPlayer->posx - 4000 || posy < pPlayer->posy - 4000 || posx > pPlayer->posx + 4000 || posy > pPlayer->posy + 4000 ) ) || 
		( posx < pPlayer->posx - 8000 || posy < pPlayer->posy - 8000 || posx > pPlayer->posx + 8000 || posy > pPlayer->posy + 8000 ) )
	{
		return;
	}

	if( state == 2 ) // shell standing
	{
		counter += Framerate.speedfactor;
		
		if( (int)counter < DESIRED_FPS * 5 )
		{
			SetImage( images[0] );// Red Shell Standard
		}
		else
		{
			if( (int)counter < DESIRED_FPS * 6 )
			{
				if( (int)counter % 5 == 1 )
				{
					SetImage( images[1] );
				}
				else
				{
					SetImage( images[0] ); // Red Shell Standard
				}
			}
			else
			{
				counter = 0;
				state = 1;
				
				Move( 0, -(images[2]->h - images[0]->h) - 1, 1, 1 );
				SetImage( images[2] );
			}
		}
		
		
		if( velx != 0 )
		{
			AddVel( -velx*0.2, 0 );

			if( velx < 0.3 && velx > -0.3 ) 
			{
				velx = 0;
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
			AddVel( 0, 1.2 + vely*0.1 );
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
				if( iCollisionType != 4 )
				{
					velx *= -1;
					Move( velx, vely );
				}
			}
			
			if( iCollisionType == 4 )
			{
				this->PlayerCollision( collid );

				if( EnemyCount && !dead && visible ) 
				{
					velx *= -1;

					Move( velx, vely );
					Draw( screen );
				}
				
				return;
			}
		}

		Draw( screen );
	}
	else if ( state == 3 ) // fast moving shell
	{
		if ( velx != speed && velx != -speed)
		{
			if( ( pPlayer->rect.w/2 + pPlayer->posx) < (this->rect.w/2 + this->posx) )
			{
				velx = speed;
			}
			else 
			{
				velx = -speed;
			}
		}

		int anispeed = 15;

		counter += Framerate.speedfactor;

		if( playercounter > 0 )
		{
			playercounter -= Framerate.speedfactor;
			
			if( playercounter < 0 )
			{
				playercounter = 0;
			}
		}
		

		if( (int)counter > DESIRED_FPS/anispeed * 4 )
		{
			counter = 0;
		}

		if( velx > 0 )
		{
			if( (int)counter < DESIRED_FPS/anispeed )
			{
				SetImage( images[10] ); // rr
			}
			else if( (int)counter < DESIRED_FPS/anispeed*2 )
			{
				SetImage( images[0] ); // Red Shell Standard
			}
			else if( (int)counter < DESIRED_FPS/anispeed*3 )
			{
				SetImage( images[9] ); // lr
			}
			else
			{
				SetImage( images[6] ); // m3r
			}
		} 
		else
		{
			if( (int)counter < DESIRED_FPS/anispeed*1 )
			{
				SetImage( images[9] ); // lr
			}
			else if( (int)counter < DESIRED_FPS/anispeed*2 )
			{
				SetImage( images[0] ); // Red Shell Standard
			}
			else if( (int)counter < DESIRED_FPS/anispeed*3 )
			{
				SetImage( images[10] ); // rr
			}
			else 
			{
				SetImage( images[6] ); // m3r
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
				if( iCollisionType && iCollisionType != 3 && iCollisionType != 4 )
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
			
			if( iCollisionType == 2 && ( collid == LEFT || collid == RIGHT ) ) // Active Object Collision
			{
				ActiveObjects[iCollisionNumber]->EnemyCollision( collid );
			}
			else if( iCollisionType == 3 ) // killed an Enemy
			{
				pAudio->PlaySound( SOUNDS_DIR "/stomp_3.ogg" );
				pointsdisplay->AddPoints( 35, (int)posx + image->w/3, (int)posy - 5 );
				EnemyObjects[iCollisionNumber]->Die();

				Move( velx, vely );
			}
			else if( iCollisionType == 4 )
			{
				if( playercounter == 0 ) // player collision
				{
					this->PlayerCollision( collid );
					
					if( EnemyCount && !dead && visible ) 
					{
						if( collidleft ) 
						{
							velx = speed;
						}
						else if( collidright ) 
						{
							velx = -speed;
						}

						Move( velx, vely );
					}
				}
				else // go through mario
				{
					type = TYPE_PLAYER; // a collision detection hack
					Move( velx, vely );
					type = TYPE_TURTLE_RED;
				}
			}
		}

		if( EnemyCount && !dead ) 
		{
			Draw( screen );
		}

	}
	else if ( state == 1 ) // normal walking
	{
		if( velx > 0 )
		{
			velx = 4;
		}
		else if( velx < 0 )
		{
			velx = -4;
		}
		else
		{
			velx = 4;
		}
		
		if( counter )
		{
			counter -= Framerate.speedfactor;
		}

		walk_count += Framerate.speedfactor;
		
		if( walk_count > 16 )
		{
			walk_count = 1;
		}
		
		if( walk_count > 8 )
		{
			if( counter < 1 )
			{
				if( velx < 0 )
				{
					SetImage( images[2] );
				}
				else
				{
					SetImage( images[4] );
				}
			}
		} 
		else
		{
			if( counter < 1 )
			{
				if( velx < 0 )
				{
					SetImage( images[3] );
				}
				else
				{
					SetImage( images[5] );
				}
			}
		}
				
		if( !PosValid( (int)posx, (int)posy + 1, (int)(rect.w*0.85) ) && vely > -1 && iCollisionType != 4 )
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
			AddVel( 0, 2.0 + vely*0.1 );
		}
		else if( onGround && vely != 0 )
		{
			vely = 0;
		}
				
		if( CollideMove() )
		{
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
				break;
			default:
				memset(&r2, 0, sizeof(r2));
				break;
			}
			
			if( iCollisionType && iCollisionType != 4 && !collidbottom )
			{
				if( collid == RIGHT || collid == LEFT )
				{
					if( velx > 0 )
					{
						SetImage( images[8] );
					}
					else
					{
						SetImage( images[7] );
					}

					counter = (int)(DESIRED_FPS/5);

					velx *= -1;
					Move( velx, vely );
				}

			}
			else if( posx < 1 )
			{
				if( velx > 0 )
				{
					SetImage( images[8] );
				}
				else
				{
					SetImage( images[7] );
				}

				counter = (int)( DESIRED_FPS/5 );
				
				velx *= -1;

				Move( velx, vely );
			}

			if( iCollisionType == 4 )
			{
				this->PlayerCollision( collid );
				
				if( EnemyCount && !dead && visible ) 
				{
					velx *= -1;

					Draw( screen );
				}
				
				return;
			}
		}

		Draw( screen );
	}
}

void cTurtle :: PlayerCollision( int cdirection )
{
	if( state == 3 && playercounter ) 
	{
		return;
	}

	if( cdirection == DOWN )
	{
		if( state == 1 )
		{
			pointsdisplay->AddPoints( 25, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else if( state == 2 )
		{
			pointsdisplay->AddPoints( 10, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else if( state == 3 )
		{
			pointsdisplay->AddPoints( 5, (int)pPlayer->posx, (int)pPlayer->posy );
		}
		else
		{
			printf( "Turtle state error : %d", state );
		}
		
		if( state == 1 )  // normal walking
		{
			counter = 0;
			state = 2; // shell staying
			Move( 0, (images[2]->h - images[0]->h) - 5, 1, 1 );
		}
		else if( state == 2 ) // shell staying
		{
			counter = 0;
			state = 3; // shell moving
		}
		else if( state == 3 ) // shell moving
		{
			counter = 0;
			state = 2; // shell staying
		}

		pAudio->PlaySound( SOUNDS_DIR "/stomp_1.ogg" );

		massive = 1;

		pPlayer->start_enemyjump = 1;
		
	}
	else if( state == 2 && ( cdirection == LEFT || cdirection == RIGHT || cdirection == UP ) )
	{
		if( cdirection == LEFT )
		{
			Move( -5, 0, 1 );
		}
		else
		{
			Move( 5, 0, 1 );
		}
		
		playercounter = (int)DESIRED_FPS * 0.13;

		state = 3;
	} 
	else if( !dead && cdirection != -1 )
	{
		pPlayer->Die();
	}
}

void cTurtle :: EnemyCollision( int cdirection )
{
	if( cdirection == LEFT && velx > 0 && state != 3 ) 
	{
		velx *= -1;
	}
	else if( cdirection == RIGHT && velx < 0 && state != 3 ) 
	{
		velx *= -1;
	}
}
