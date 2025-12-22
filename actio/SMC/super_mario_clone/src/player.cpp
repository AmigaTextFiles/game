/***************************************************************************
           player.cpp  -  player class, very important
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

cPlayer :: cPlayer ( double x, double y ) : cSprite( NULL, x, y )
{
	type = TYPE_PLAYER;

	fire[0] = NULL;
	fire[1] = NULL;

	for( int i = 0;i < 15;i++ )
	{
		images[i] = NULL;
	}

	ducked = 0;

	invincible = 0;
	invincible_mod = 0;
	
	iSize = MARIO_SMALL;

	LoadImages( 1 ); // preload all images

	SetImage( images[1] ); // Default Image = Mario small right
	SetPos( x, y );

	direction = RIGHT;
	walk_count = 0;

	collid = -1;
	iCollisionType = 0;
	iCollisionNumber = 0;
	debugmode = 0;

	lives = 3;		// Starting with 3 Lifes 
	goldpieces = 0;
	points = 0;

	startjump = 0;
	start_enemyjump = 0;
	jump_Acc_up = 4.5;
	jump_vel_deAcc = 0.06;
}

cPlayer :: ~cPlayer( void )
{
	Unload_Fireballs();

	for( int i = 0;i < 15;i++ )
	{
		images[i] = NULL;
	}
}

void cPlayer :: LoadImages( bool preload )
{
	if( preload )
	{
		int old_iSize = iSize;
		
		iSize = MARIO_SMALL;// small
		LoadImages();
		
		iSize = MARIO_BIG;	// big
		LoadImages();
		
		iSize = MARIO_FIRE;	// fire
		LoadImages();

		iSize = old_iSize;
	}

	if( iSize == MARIO_SMALL )
	{
		/********************* Small **************************/
		// standing
		images[0] = GetImage( "mario/small_left.png" );
		images[1] = GetImage( "mario/small_right.png" );
		// running
		images[2] = GetImage( "mario/small_run_left.png" );
		images[3] = GetImage( "mario/small_run_right.png" );
		// falling
		images[4] = GetImage( "mario/small_fall_left.png" );
		images[5] = GetImage( "mario/small_fall_right.png" );
		// jumping
		images[6] = GetImage( "mario/small_jump_left.png" );
		images[7] = GetImage( "mario/small_jump_right.png" );
		// ducked
		images[10] = GetImage( "mario/small_duck_left.png" );
		images[11] = GetImage( "mario/small_duck_right.png" );
		/****************************************************/
	}
	else if( iSize == MARIO_BIG )
	{
		/********************* Big ****************************/
		// standing
		images[0] = GetImage( "mario/big_left.png" );
		images[1] = GetImage( "mario/big_right.png" );
		// running
		images[2] = GetImage( "mario/big_run_left_1.png" );
		images[3] = GetImage( "mario/big_run_right_1.png" );
		// falling
		images[4] = GetImage( "mario/big_fall_left.png" );
		images[5] = GetImage( "mario/big_fall_right.png");
		// jumping
		images[6] = GetImage( "mario/big_jump_left.png" );
		images[7] = GetImage( "mario/big_jump_right.png" );
		// ducked
		images[10] = GetImage( "mario/big_duck_left.png" );
		images[11] = GetImage( "mario/big_duck_right.png" );
		// running 2
		images[12] = GetImage( "mario/big_run_left_2.png" );
		images[13] = GetImage( "mario/big_run_right_2.png" );
		/****************************************************/
	}
	else if( iSize == MARIO_FIRE )
	{
		/********************* Fire **************************/
		// standing
		images[0] = GetImage( "mario/fire_left.png" );
		images[1] = GetImage( "mario/fire_right.png" );
		// running
		images[2] = GetImage( "mario/fire_run_left_1.png" );
		images[3] = GetImage( "mario/fire_run_right_1.png" );
		// falling
		images[4] = GetImage( "mario/fire_fall_left.png" );
		images[5] = GetImage( "mario/fire_fall_right.png" );
		// jumping
		images[6] = GetImage( "mario/fire_jump_left.png" );
		images[7] = GetImage( "mario/fire_fall_right.png" );
		// ducked
		images[10] = GetImage( "mario/fire_duck_left.png" );
		images[11] = GetImage( "mario/fire_duck_right.png" );
		// running 2
		images[12] = GetImage( "mario/fire_run_left_2.png" );
		images[13] = GetImage( "mario/fire_run_right_2.png" );
		/****************************************************/
	}

	/********************** Dead Animation **************************/
	images[8] = GetImage( "mario/small_dead_left.png" );
	images[9] = GetImage( "mario/small_dead_right.png" );
	/****************************************************/
}

void cPlayer :: Hold( void )
{
	if( state != JUMPING && state != FALLING )
	{
		state = STAYING;
	}
}

void cPlayer :: Duck( void )
{
	if( ( state == STAYING || state == WALKING ) && onGround == 1 && !ducked )
	{
		rect.h = images[10]->h;
		rect.w = images[10]->w;

		Move( 0, (double)(images[0]->h - images[10]->h), 1 );
		
		ducked = 1;
		state = STAYING;
		vely = 0;
	}
}

void cPlayer :: Walk( double velwalk, double maxvel, double velwrongway )
{
	if( direction == RIGHT )
	{
		if( state != JUMPING && state != FALLING )
		{
			state = WALKING;
		}

		if( velx > 0 )
		{
			AddVel( velwalk, 0 );

			if( velx > maxvel )
				velx = maxvel;
		}
		else
		{
			AddVel( velwrongway, 0 );	// slow down
		}

	}
	else if( direction == LEFT )
	{
		if( state != JUMPING && state != FALLING )
		{
			state = WALKING;
		}

		if( velx < 0 )
		{
			AddVel( -velwalk, 0 );

			if( velx < -maxvel )
				velx = -maxvel;
		}
		else
		{
			AddVel( -velwrongway, 0 );	// slow down
		}
	}
}

void cPlayer :: Die( void )
{
	if( debugmode || invincible )
	{
		return;
	}

	if( iSize != MARIO_SMALL )
	{
		iSize = MARIO_SMALL;
		LoadImages();

		if( !( posy - cameraposy > (pPreferences->Screen_H - rect.h) ) ) // if not dead because of falling down
		{
			pAudio->PlaySound( SOUNDS_DIR "/powerdown.ogg", CHANNEL_MARIO_POWERDOWN );

			invincible = DESIRED_FPS*2.5;
			invincible_mod = 0;

			Itembox->Request_Item();
			
			return;
		}
	}

	iSize = MARIO_DEAD;

	pAudio->FadeOutMusic( 1700 );
	pAudio->PlaySound( SOUNDS_DIR "/death.ogg", CHANNEL_MARIO_DEATH );

	Unload_Fireballs();

	if( livedisplay )
	{
		livedisplay->AddLives( -1 );
	}

	if( debugdisplay )
	{
		sprintf( debugdisplay->text, "You Died!" );
		debugdisplay->counter = DESIRED_FPS;
		debugdisplay->Update();
	}
	
	// Mario die animation


	SDL_FillRect( screen, NULL, pLevel->background_color );
	pLevel->Draw( 0 ); // no Level updates
	DrawP( 9 );
	SDL_Flip( screen );	// Draw
	SDL_Delay( 500 );
	Framerate.Reset();
	
	double i;

	for( i = 0; i < 7; i += Framerate.speedfactor )
	{
		Move( 0, -13, 0, 1 );
		SDL_FillRect( screen, NULL, pLevel->background_color );
		pLevel->Draw( 0 );	// no Level updates
		DrawP( 8 );
		SDL_Flip( screen );	// Draw
		Framerate.SetSpeedFactor();
	}

	SDL_Delay( 300 );

	Framerate.Reset();
	walk_count = 0;
	
	for( i = 0; posy < pPreferences->Screen_H + cameraposy +  rect.h; i++ )
	{
		walk_count += Framerate.speedfactor;

		if( walk_count > 4 )
		{
			walk_count = 0;
		}

		Move( 0, 14, 0, 1 );
		SDL_FillRect( screen, NULL, pLevel->background_color );
		pLevel->Draw( 0 );	// no Level updates

		if( walk_count > 2 )
		{
			DrawP( 8 );
		}
		else
		{
			DrawP( 9 );
		}

		SDL_Flip( screen ); // Draw
		
		Framerate.SetSpeedFactor();
	}

	if( lives >= 0 )
	{
		pLevel->Unload();
		Reset();
		DrawEffect();
	}
	else
	{
		if( debugdisplay )
		{
			sprintf( debugdisplay->text, "Game Over!" );
			debugdisplay->counter = DESIRED_FPS;
			debugdisplay->Update();
		}
		
		SDL_FillRect( screen, NULL, pLevel->background_color );
		pLevel->Draw( 0 );	// no Level updates
		DrawP( 9 );
		SDL_Flip( screen ); // Draw

		pLevel->Unload();
		DrawEffect();
		ResetSave();
	}
	
	Framerate.Reset( );

	ClearEvents();
	
	iSize = MARIO_SMALL;
}

void cPlayer :: ResetSave( void )
{
	pOverWorld->Current_Waypoint = -2;
	pOverWorld->Current_OverWorld = 0;
	
	pOverWorld->SetMarioPos( 0 );

	pOverWorld->Nlevel = -1;
	pOverWorld->Slevel = 0;
	
	for( int i = 0;i < MAX_WAYPOINTS;i++ )
	{
		pOverWorld->Waypoints[i]->access = 0;
	}

	pLevel->Unload();

	Reset();

	lives = 3;
	goldpieces = 0;
	points = 0;

	timedisplay->counter = 0;

	iSize = MARIO_SMALL;
	LoadImages();

	Itembox->Reset();

	pOverWorld->LoadOverWorld( 0 );

	pMenu->Menu_Item = 1;
	pMenu->ShowMenu();
}

void cPlayer :: Reset( void )
{
	SetPos( startposx, startposy );

	direction = RIGHT;
	ducked = 0;
	state = 0;
	jump_power = 0;
	startjump = 0;
	start_enemyjump = 0;
	jump_Acc_up = 0;
	jump_vel_deAcc = 0;
	velx = 0;
	vely = 0;
	iCollisionNumber = 0;
	iCollisionType = 0;
	walk_count = 0;
	cameraposx = 0;
	cameraposy = 0;
	onGround = 0;
	invincible = 0;
	invincible_mod = 0;
}

void cPlayer :: GotoNextLevel( void )
{
	int iSize_old = iSize;
	iSize = MARIO_DEAD; // a little hack for drawing the complete map

	pLevel->Draw( 0 );
	
	iSize = iSize_old;
	
	DrawEffect();

	pLevel->Unload();

	pOverWorld->GotoNextLevel();

	pPlayer->Reset();

	pOverWorld->Enter();
}

void cPlayer :: StartJump( double Power, double Acc_up, double vel_deAcc )
{
	jump_Acc_up = Acc_up;
	jump_vel_deAcc = vel_deAcc;

	if ( startjump || start_enemyjump )
	{
		if( keys[pPreferences->Key_up] || pJoystick->up || pJoystick->Button( pPreferences->Joy_jump ) )
		{
			jump_power = 10;
		}
		else
		{
			jump_power = 2;
		}

		if( startjump ) // new
		{
			if( iSize == MARIO_SMALL )
			{
				pAudio->PlaySound( SOUNDS_DIR "/jump_small.ogg", CHANNEL_MARIO_JUMP );
			}
			else
			{
				pAudio->PlaySound( SOUNDS_DIR "/jump.ogg", CHANNEL_MARIO_JUMP );
			}

		}

		startjump = 0;
		start_enemyjump = 0;
	}
	else
	{
		jump_power = 8;
	}



	state = JUMPING;
	vely = -Power;
}

void cPlayer :: JumpStep( void )
{
	if( keys[pPreferences->Key_up] || pJoystick->up || pJoystick->Button( pPreferences->Joy_jump ) )
	{
		jump_power -= Framerate.speedfactor;
		AddVel( 0, -( jump_Acc_up + ( vely * jump_vel_deAcc ) ) );
	}	
	else
	{
		AddVel( 0, 1 );
		jump_power -= 6 * Framerate.speedfactor;
	}

	if( jump_power <= 0 )
	{
		state = FALLING;
	}
}

void cPlayer :: Update( void )
{
	if( Leveleditor_Mode )
	{
		// no update
		Draw( screen );
		return;
	}

	/*************************
	**  Collision control	**
	*************************/

	iCollisionType = 0;
	iCollisionNumber = 0;
	
	collid = -1;

	if( vely > -1 && !PosValid( (int)posx, (int)posy + 1,(int)(rect.w*0.85) ) && iCollisionType != 3 )
	{
		//printf("Staying\n");
		if( iCollisionType == 2 && ActiveObjects[iCollisionNumber]->halfmassive )
		{
			onGround = 2;
			state = STAYING;
		}
		else
		{
			onGround = 1;
			state = STAYING;
		}
	}
	else
	{
		onGround = 0;
	}
	
	// Check if Mario is stuck
	if( !ducked && !PosValid( (int)posx, (int)posy ) && iCollisionType != 3 && 
		!( iCollisionType == 2 && ActiveObjects[iCollisionNumber]->halfmassive ) )
	{
		// printf( "Mario is Stuck !\n" );

		if( PosValid( (int)posx + rect.w/2, (int)posy ) ) 
		{
			Move( 1, 0, 1 );
		}
		else if( PosValid( (int)posx - rect.w/2, (int)posy ) ) 
		{
			Move( -1, 0, 1 );
		}
		else if( PosValid( (int)posx , (int)posy + rect.h/2 ) ) 
		{
			Move( 0, 1, 1 );
		}
		else if( PosValid( (int)posx , (int)posy - rect.h/2 ) ) 
		{
			Move( 0, -1, 1 );
		}
	}
	
	// 1. Jump
	if( state == JUMPING )
	{
		//printf("Jumping\n");
		JumpStep( );
	}
	
	// 2. Fall
	if( !onGround )
	{
		//printf("Falling\n");

		if( vely < 25.0 )
		{
			AddVel( 0, 2.8 );	// GRAVITATION
		}
		if( state != JUMPING )
		{
			state = FALLING;
		}
	}

	// 3. Walk
	if( !ducked && ( keys[pPreferences->Key_left] || keys[pPreferences->Key_right] || pJoystick->left || pJoystick->right ) )
	{
		//printf("Walking\n");
		double velwalk = 1.0; // 1.5
		double maxvel = 13;
		double velwrongway = 1.8; // 2.0
		double factor = 0.5;
	
		if( onGround )
		{
			Walk( velwalk, maxvel, velwrongway );
		}
		else if( !collidleft && !collidright )
		{
			Walk( velwalk * factor, maxvel , velwrongway );
		}
	}
	else if( ducked && onGround ) // if ducked
	{
		if( velx > 0 )
		{
			AddVel( -1.3, 0 );

			if ( velx < 0 )
				velx = 0;
		}
		else if( velx < 0 )
		{
			AddVel( 1.3 ,0 );

			if ( velx > 0 )
				velx = 0;
		}
	}


	if( onGround ) // if player is onground
	{
		if( ( !keys[pPreferences->Key_left] && !keys[pPreferences->Key_right] ) && 
			( !pJoystick->left && !pJoystick->right ) && !ducked )
		{
			// slow down the player
			if( velx > 0 )
			{
				AddVel( -1.1, 0 );

				if ( velx < 0 )
					velx = 0;
			}
			else if( velx < 0 )
			{
				AddVel( 1.1, 0 );

				if ( velx > 0 )
					velx = 0;
			}
		}

		vely = 0;
	}
	else // flying
	{
		// slow down the player
		if( velx > 0 )
		{
			AddVel( -0.05, 0 );

			if ( velx < 0 )
				velx = 0;
		}
		else if( velx < 0 )
		{
			AddVel( 0.05, 0 );

			if ( velx > 0 )
				velx = 0;
		}
	}

	//printf("|state:%d|onGround:%d|velx:%f|vely:%f\n", state, onGround?1:0, velx, vely);
	//printf("Vel X: %f Vel Y : %f \n",velx, vely);

	int Collidedir = CollideMove();

	if( Collidedir && !( iCollisionType == 2 && ActiveObjects[iCollisionNumber]->halfmassive ) )
	{
		if( iCollisionType != 3 ) 
		{
			if( Collidedir == 1 && !ducked ) // Left/Right and Up/Down (rarely true)
			{
				vely = -(vely/6) * Framerate.speedfactor;
			}
			else if( Collidedir == 3 && vely < 0 ) // Up
			{
				if( iCollisionType == 1 ) // Massive
				{
					pAudio->PlaySound( SOUNDS_DIR "/tock.ogg", CHANNEL_MARIO_TOCK );
				}

				//printf("Slowdown vely : %f\n",vely);
				vely = -(vely/6) * Framerate.speedfactor;

				UpKeyTime = 0;
			}
		}

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
		default:
			memset( &r2, 0, sizeof( r2 ) );
			break;
		}

		// printf("collid : %d,  CollisionType : %d,  OnGround : %d,  Velx : %d,  Vely : %d\n", collid, iCollisionType, onGround, (int)velx, (int)vely);
		
		if( iCollisionType == 2 ) // Active
		{
			ActiveObjects[iCollisionNumber]->PlayerCollision( collid );
			//printf("Active Collision \n");
		}
		else if(iCollisionType == 3 ) // Enemy
		{
			EnemyObjects[iCollisionNumber]->PlayerCollision( collid );
		}

		if( state == JUMPING && collidtop )
		{
			state = FALLING;
		}

		if( iCollisionType != 3 )
		{
			// Most of these Collision tests are very rarely true
			if( collidright && velx > 0 && !PosValid( (int)posx + 10, (int)posy, (int)(rect.w*0.9), (int)(rect.h*0.6), 1) )
			{
				velx = 0;
				//printf("RigHt\n");
			}
			else if( collidleft && velx < 0 && !PosValid( (int)posx - 10, (int)posy, (int)(rect.w*0.9), (int)(rect.h*0.6), 1) )
			{
				velx = 0;
				//printf("LeFt\n");
			}
			if( collidbottom && vely > 0 && !PosValid( (int)posx, (int)posy + 10, (int)(rect.w*0.6), (int)(rect.h*0.9), 1) )
			{
				vely = 0;
				//printf("BoTToM\n");
			}
			else if( collidtop && vely < 0 && !PosValid( (int)posx, (int)posy - 10, (int)(rect.w*0.6), (int)(rect.h*0.9), 1) )
			{
				vely = 0;
				//printf("Up\n");
			}
		}
		
		if( ( state == FALLING || state == JUMPING ) && collidbottom && !PosValid( (int)posx, (int)posy + 2, (int)(rect.w/0.95), 0, 1 ) )
		{
			state = STAYING;
		}
	}
	else
	{
		iCollisionType = 0;
		iCollisionNumber = 0;
		collidtop = 0;
		collidbottom = 0;
		collidleft = 0;
		collidright = 0;
	}

	/*************************
	** Drawing			   **
	*************************/

	rect.x = (int) posx;
	rect.y = (int) posy;

	walk_count += Framerate.speedfactor; 

	if( velx != 0 ) 
	{
		if(velx > 0) 
		{
			walk_count += (velx*0.05) * Framerate.speedfactor;
		}
		else
		{
			walk_count += (-velx*0.05) * Framerate.speedfactor;
		}
	}

	if( walk_count > 8 )
	{
		walk_count = 1;
	}

	if( state == FALLING )
	{
		if( !ducked )
		{
			DrawP( 4 + this->direction );
		}
		else
		{
			DrawP( 10 + this->direction );
		}
	}
	else if( state == STAYING && !velx ) // changed
	{
		if( !ducked )
		{
			DrawP( 0 + this->direction );
		}
		else
		{
			DrawP( 10 + this->direction );
		}
	}
	else if( state == JUMPING )
	{
		DrawP( 6 + this->direction );
	}
	else
	{
		if ( !ducked )
		{
			if( ( velx < 12 && velx > -12 ) || iSize == MARIO_SMALL )
			{
				if( walk_count > 4 )
				{
					DrawP( 0 + this->direction );
				}
				else
				{
					DrawP( 2 + this->direction );
				}
			}
			else
			{
				if( walk_count > 6 )
				{
					DrawP( 0 + this->direction );
				}
				else if( walk_count > 4 )
				{
					DrawP( 2 + this->direction );
				}
				else if( walk_count > 2 )
				{
					DrawP( 12 + this->direction );	
				}
				else
				{
					DrawP( 2 + this->direction );
				}
			}
		}
		else
		{
			DrawP( 10 + this->direction );
		}
	}
	

	/*****************
	** Camera		**
	*****************/
	// x camera ( left & right )

	// Never forget the Mod_Camera !
	// todo : a camera which goes further into the player direction when moving
	if( posx - cameraposx > (pPreferences->Screen_W / 6 * 3) + pLevel->Mod_Camera_right )	//  scrolling right
	{
		cameraposx = (int) ( posx - (pPreferences->Screen_W / 6 * 3) - pLevel->Mod_Camera_right );
	}
	else if( cameraposx && posx - cameraposx < (pPreferences->Screen_W / 6 * 2) + pLevel->Mod_Camera_left ) //  scrolling left
	{
		cameraposx = (int) (posx - (pPreferences->Screen_W / 6 * 2) - pLevel->Mod_Camera_left);
	}

	if( cameraposx < 0 )
	{
		cameraposx = 0;
	}

	// y camera ( up & down )
	if( posy - cameraposy < (pPreferences->Screen_H / 6) + pLevel->Mod_Camera_up )
	{
		cameraposy += (signed int)((posy - cameraposy - pPreferences->Screen_H / 6 * 3)/27 );
		//printf("Up : %f\n",(posy - cameraposy - pPreferences->Screen_H / 6 * 3)/40);
	}
	else if( cameraposy && !(posy - cameraposy < 0) && posy - cameraposy > ( pPreferences->Screen_H / 6 * 2.8 ) + pLevel->Mod_Camera_up )
	{
		cameraposy += (signed int)( ( posy - cameraposy - pPreferences->Screen_H / 6 * 3 )/4.8 );
		//printf("Down : %f\n",(posy - cameraposy - pPreferences->Screen_H / 6 * 3)/8);
	}

	if( cameraposy > 0 )
	{
		cameraposy = 0;
	}
	
	
	/*************************
	**  Fireball			**
	*************************/
	
	if ( fire[0] )
	{
		if ( fire[0]->bDestroy )
		{
			delete fire[0];
			fire[0] = NULL;
		}
		else
		{
			fire[0]->Update ();
		}
	}
	if ( fire[1] )
	{
		if (fire[1]->bDestroy)
		{
			delete fire[1];
			fire[1] = NULL;
		}
		else
		{
			fire[1]->Update ();
		}
	}

	/*************************
	**  Stuff				**
	*************************/
	// if players dead because of falling down
	if( posy - cameraposy > ( pPreferences->Screen_H - rect.h ) )
	{
		this->invincible = 0;
		this->Die();
	}

	if( invincible > 0 )
	{
		invincible -= Framerate.speedfactor;

		if( invincible < 0 ) 
		{
			invincible = 0;
		}
	}
}

void cPlayer :: DrawP( int imgnr )
{
	if( imgnr != -1 )
	{
		SetImage( images[imgnr] );
	}

	if( invincible <= 0 )
	{
		Draw( screen );
	}
	else
	{
		if( invincible > 0 )
		{
			if( (int)invincible % 2 == 0 && invincible_mod < 0 )
			{
				Draw( screen );

				invincible_mod = invincible/15;

				if( invincible_mod > 15 ) 
				{
					invincible_mod = 15;
				}
			}

			invincible_mod -= Framerate.speedfactor;
		}
	}

}

void cPlayer :: Get_Item( unsigned int Item_type, bool force )
{
	if( Item_type == TYPE_MUSHROOM_DEFAULT ) 
	{
		if( iSize == MARIO_SMALL && PosValid( (int)posx, (int)posy -32 ) || force ) 
		{
			pAudio->PlaySound( SOUNDS_DIR "/mushroom.ogg", CHANNEL_MUSHROOM );
			
			if( iSize == MARIO_SMALL ) 
			{
				Move( 0, -32, 1 );
				iSize = MARIO_BIG;
				LoadImages();
			}
			else if( iSize == MARIO_BIG ) 
			{
				Itembox->Get_Item( TYPE_MUSHROOM_DEFAULT );
			}
			else if( iSize == MARIO_FIRE ) 
			{
				Itembox->Get_Item( TYPE_MUSHROOM_DEFAULT );

				//Move( 0, -7 , 1 );
			}

			
		}
		else
		{
			Itembox->Get_Item( TYPE_MUSHROOM_DEFAULT );
		}
	}
	else if( Item_type == TYPE_FIREPLANT ) 
	{
		if( ( iSize == MARIO_SMALL && PosValid( (int)posx, (int)posy -60 ) ) || 
			( iSize == MARIO_BIG ) || force )
		{
			if( iSize == MARIO_SMALL ) 
			{
				Move( 0, -60 , 1 );
			}
			else if( iSize == MARIO_BIG ) 
			{
				//he advances
			}
			else if( iSize == MARIO_FIRE ) 
			{
				Itembox->Get_Item( TYPE_FIREPLANT );
			}
			
			// TODO : a sound ;)
			iSize = MARIO_FIRE;
			LoadImages();
		}
		else
		{
			Itembox->Get_Item( TYPE_FIREPLANT );
		}
	}
	else if( Item_type == TYPE_MUSHROOM_LIVE_1 ) 
	{
		pAudio->PlaySound( SOUNDS_DIR "/live_up.ogg", CHANNEL_1UP_MUSHROOM );
		livedisplay->AddLives( 1 );
	}
	else if( Item_type == TYPE_MOON ) 
	{
		pAudio->PlaySound( SOUNDS_DIR "/live_up.ogg", CHANNEL_1UP_MUSHROOM );
		livedisplay->AddLives( 3 );
	}
}

void cPlayer :: Add_Fireball( void )
{
	if( iSize != MARIO_FIRE || ducked )
	{
		return;
	}

	for( int i = 0;i < 2;i++ )
	{
		// Checks if an Fireball Slot is available
		if( !fire[i] )
		{
			fire[i] = new cFireball( (direction == 1) ? (posx + 20) : (posx + 8), posy + 45,(direction == 1) ? (+17) : (-17) );
			
			pAudio->PlaySound( SOUNDS_DIR "/fireball_1.ogg", CHANNEL_MARIO_FIREBALL );

			break;
		}
	}
}

void cPlayer :: Unload_Fireballs( void )
{
	if( fire[0] )
	{
		delete fire[0];
		fire[0] = NULL;
	}

	if( fire[1] )
	{
		delete fire[1];
		fire[1] = NULL;
	}
}


cFireball :: cFireball( double x, double y, double fvelx ) : cSprite ( NULL, x, y )
{
	this->velx = fvelx;
	vely = 0;
	counter = 0;

	bDestroy = 0;

	Array = ARRAY_ACTIVE;

	posx = x;
	posy = y;

	type = TYPE_FIREBALL;

	img[0] = GetImage( "animation/fireball_1/1.png" );
	img[1] = GetImage( "animation/fireball_1/2.png" );
	img[2] = GetImage( "animation/fireball_1/3.png" );
	img[3] = GetImage( "animation/fireball_1/4.png" );

	SetImage( img[0] );
}

cFireball :: ~cFireball()
{
	for( int i = 0;i < 4;i++ )
	{
		img[i] = NULL;
	}
}

void cFireball :: Update( void )
{
	counter += Framerate.speedfactor;

	if( counter < 3 )
	{
		SetImage( img[0] );
	}
	else if( counter < 5 )
	{
		SetImage( img[1] );
	}
	else if( counter < 7 )
	{
		SetImage( img[2] );
	}
	else
	{
		SetImage( img[3] );
		counter = 0;
	}

	if( posx <= 10 )
	{
		bDestroy = 1;
	}
	
	if( vely < 30 )
	{
		AddVel( 0, 1.0 );
	}

	// move the fireball
	if( CollideMove() )
	{
		SDL_Rect r2;

		switch(iCollisionType)
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
		
		GetCollid( &r2 );

		if( iCollisionType && iCollisionType != 4 ) // no Player
		{

			if( iCollisionType == 3 ) // Enemy 
			{
				if(EnemyObjects[iCollisionNumber]->type != TYPE_BANZAI_BILL) 
				{
					pointsdisplay->AddPoints( 30, (int)posx, (int)posy );

					EnemyObjects[iCollisionNumber]->visible = 0;
					
					if(EnemyObjects[iCollisionNumber]->PosValid( (int)EnemyObjects[iCollisionNumber]->posx, (int)EnemyObjects[iCollisionNumber]->posy ))
					{
						cSprite *tmp;
						tmp = new cGoldPiece( EnemyObjects[iCollisionNumber]->posx, EnemyObjects[iCollisionNumber]->posy );
						tmp->spawned = 1;
						AddActiveObject((cSprite*) tmp);
					}
					else
					{
						cSprite *tmp;
						tmp = new cGoldPiece(EnemyObjects[iCollisionNumber]->posx + EnemyObjects[iCollisionNumber]->rect.w/2, EnemyObjects[iCollisionNumber]->posy + EnemyObjects[iCollisionNumber]->rect.h/2);
						tmp->spawned = 1;
						AddActiveObject((cSprite*) tmp);
					}
					
					EnemyObjects[iCollisionNumber]->Die();
					
					bDestroy = 1;				
				}
				else
				{
					pAudio->PlaySound( SOUNDS_DIR "/tock.ogg" );
					bDestroy = 1;
				}
			}
			else if(vely < 1.0 && iCollisionType == 2 && ActiveObjects[iCollisionNumber]->type == TYPE_HALFMASSIVE)
			{
				Move( velx, vely, 0, 1 );
			}
			else if(!collidbottom && (iCollisionType == 1 || iCollisionType == 2))
			{
				bDestroy = 1;
			}
			else if(collid == DOWN && (iCollisionType == 1 || iCollisionType == 2))
			{
				vely = -10;
			}
			else
			{
				// printf("Nothing Type : %d , Direction : %d\n",iCollisionType,collid);
				bDestroy = 1;
			}
			
		}
		else
		{
			Move( velx, vely, 0, 1 );
		}
	}

	// If the Fireball is out of Range
	if(pPlayer->posx + 2000 < this->posx || pPlayer->posx - 2000 > this->posx ||
		pPlayer->posy + 2000 < this->posy || pPlayer->posy - 2000 > this->posy)
	{
		bDestroy = 1;
	}

	Draw( screen );
}
