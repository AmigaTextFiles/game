/***************************************************************************
           sprite.cpp  -  optimised sprite class
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

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cSprite :: cSprite( SDL_Surface *new_image, double x, double y )
{
	type = TYPE_SPRITE;
	
	Array = ARRAY_MASSIVE;
	
	rect.x = 0;
	rect.y = 0;
	rect.w = 0;
	rect.h = 0;
	startposx = 0;
	startposy = 0;
	StartImage = NULL;
	image = NULL;
	
	if( new_image )
	{
		SetImage( new_image );
	}

	SetPos( x, y );

	massive = 1;
	visible = 1;

	state = 0;
	velx = 0;
	vely = 0;
	direction = 0;
	onGround = 0;
	collidtop = 0;
	collidbottom = 0;
	collidright = 0;
	collidleft = 0;
	iCollisionType = 0;
	iCollisionNumber = 0;

	halfmassive = 0;

	rect.x = (int) posx;
	rect.y = (int) posy;

	spawned = 0;

	ID = MassiveCount + PassiveCount + ActiveCount + EnemyCount + HUDCount + (int)rand() % (90000); // Unique Identifier
}

cSprite :: ~cSprite( )
{
	image = NULL;
	StartImage = NULL;
}

void cSprite :: SetImage( SDL_Surface *new_image, bool new_Startimage )
{
	image = new_image;

	if( new_Startimage )
	{
		StartImage = new_image;
	}

	if( !new_image )
	{
		rect.w = 0;
		rect.h = 0;

		return;
	}

    rect.w = image->w;
	rect.h = image->h;
	
	if( !StartImage )
	{
		StartImage = image;
	}
}

void cSprite :: SetPos( double x, double y )
{
	posx = x;
	posy = y;

	if( startposx == 0 && startposy == 0 )
	{
		startposx = x;
		startposy = y;
	}
}

void cSprite :: Update( void )
{
	Draw( screen );
}

void cSprite :: PlayerCollision( int direction )
{
	// virtual function
}

void cSprite :: EnemyCollision( int direction )
{
	// virtual function
}

void cSprite :: BoxCollision( int direction, SDL_Rect *r2 )
{
	// virtual function
}

void cSprite :: Die( void )
{
	// virtual function
}

int cSprite :: Move( double move_x, double move_y, bool real, bool force )
{
	if( !real ) 
	{
		move_x *= Framerate.speedfactor;
		move_y *= Framerate.speedfactor;
	}

	if( !force )
	{
		int Collision = 0;
		double posx_old = posx;
		double posy_old = posy;

		Uint16 cwidth = rect.w;
		Uint16 cheight = rect.h;

		if( cwidth == 0 )
		{
			return 0;
		}

		if( cheight == 0 )
		{
			return 0;
		}
		
		while( move_x != 0 || move_y != 0 )
		{
			if( move_x != 0 )
			{
				if( PosValid( (int)(posx + ((move_x > 0) ? (cwidth) : (-cwidth))), (int)posy, 0, 0, (cwidth == 1) ? (0) : (1) ) )
				{
					posx += ((move_x > 0) ? (cwidth) : (-cwidth));
					
					if( (move_x > 0 && posx_old + move_x <= posx) || (move_x < 0 && posx_old + move_x >= posx) )
					{
						posx = posx_old + move_x;
						move_x = 0;
					}
				}
				else
				{
					if( cwidth == 1) 
					{
						if( !Collision )
						{
							Collision = 2;	// Collision Left/Right
						}
						else if( Collision )
						{
							Collision = 1;	// Collision Up/Down/Left/Right
						}
						
						move_x = 0;
					}
					else
					{
						cwidth = 1;
					}
				}
			}

			if( move_y != 0 )
			{
				if( PosValid( (int)posx, (int)(posy + ((move_y > 0) ? (cheight) : (-cheight)) ), 0, 0, (cheight == 1) ? (0) : (1)) )
				{
					posy += ((move_y > 0) ? (cheight) : (-cheight));

					if( (move_y > 0 && posy_old + move_y <= posy) || (move_y < 0 && posy_old + move_y >= posy) )
					{
						posy = posy_old + move_y;
						move_y = 0;
					}
					
				}
				else
				{
					if( cheight == 1 ) 
					{
						if( !Collision ) 
						{
							Collision = 3;	// Collision Up/Down
						}
						else if( Collision ) 
						{
							Collision = 1;	// Collision Up/Down/Left/Right
						}

						move_y = 0;
					}
					else
					{
						cheight = 1;
					}
				}
			}
		}

		
		return Collision;
	}
	else if( force )
	{
		posx += move_x;
		posy += move_y;
	}

	return 0;
}

void cSprite :: AddVel( double vel_x, double vel_y, bool real )
{
	if( real ) 
	{
		velx += vel_x;
		vely += vel_y;
	}
	else
	{
		velx += vel_x * Framerate.speedfactor;
		vely += vel_y * Framerate.speedfactor;
	}

}

void cSprite :: Draw( SDL_Surface *target )
{
	if( !visible && !Leveleditor_Mode )
	{
		return;
	}

	if( !Leveleditor_Mode )
	{
		rect.x = (int)posx;
		rect.y = (int)posy;
	}
	else
	{
		rect.x = (int)startposx;
		rect.y = (int)startposy;
	}
	
	if( !Visible_onScreen() ) 
	{
		return;
	}

	SDL_Rect r = rect;
	r.x -= cameraposx;
	r.y -= cameraposy;

	if( image )
	{
		if( Leveleditor_Mode && StartImage )
		{
			r.w = StartImage->w;
			r.h = StartImage->h;
			SDL_BlitSurface( StartImage, NULL, target, &r );
			//SDL_UpdateRect( StartImage, r.x, r.y, r.w, r.h );
			r.w = image->w;
			r.h = image->h;
		}
		else
		{
			SDL_BlitSurface( image, NULL, target, &r );
			//SDL_UpdateRect( image, r.x, r.y, r.w, r.h );
		}
	}

}

bool cSprite :: Visible_onScreen( void )
{
	if( rect.x + rect.w < cameraposx ) // if Object is not visible (left)
	{
		return 0;
	}
	else if ( rect.x > cameraposx + pPreferences->Screen_W ) // if Object is not visible (right)
	{
		return  0;
	}
	else if ( rect.y + rect.h < cameraposy ) // if Object is not visible (down)
	{
		return 0;
	}
	else if ( rect.y > cameraposy + pPreferences->Screen_H ) // if Object is not visible (up)
	{
		return 0;
	}

	return 1;
}

int cSprite :: CollideMove( void )
{	
	iCollisionType = 0; // reset the Collision information
	iCollisionNumber = 0;
	collid = -1;

	int cdir = Move( velx, vely );

	if( posx < 0 && type != TYPE_BANZAI_BILL )
	{
		posx = 0;
		collid = LEFT;
		cdir = 2; // Collision in Left/Right
	}
	else if( pPlayer->debugmode && type == TYPE_PLAYER && posy > 550 )
	{
		vely = -30;
	}

	return cdir;
}

void cSprite :: GetCollid( SDL_Rect *r2 )
{
	// collidtop means there is a collision on top
	// so  above   =   -y    
	// so pos >= collider pos
	
	collidtop = posy + 1 >= r2->y + r2->h;
	collidbottom = posy + rect.h - 1 <= r2->y;
	collidleft = posx + 1 >= r2->x + r2->w;
	collidright = posx + rect.w - 1 <= r2->x;
	
	if( collidtop )
	{
		collid = UP;
	}
	else if( collidleft )
	{
		collid = LEFT;
	}
	else if( collidbottom )
	{
		collid = DOWN;
	}
	else if( collidright )
	{
		collid = RIGHT;
	}
}

// returns false if the position is not valid
bool cSprite :: PosValid( int x, int y, int w, int h, bool only_check, bool Debug_Draw )
{
	SDL_Rect rect1 = this->rect;
	SDL_Rect rect2;
	
	rect1.x = x;
	rect1.y = y;

	if( w > 0 )
	{
		rect1.x += ( rect.w - w )/2;
		rect1.w = w;
	}

	if( h > 0 )
	{
		rect1.y += ( rect.h - h )/2;
		rect1.h = h;
	}
	
	if( Debug_Draw )
	{
		SDL_Rect r3 = rect1;
		r3.x -= cameraposx;
		r3.y -= cameraposy;
		SDL_FillRect( screen, &r3, SDL_MapRGB( screen->format, 0, 120, 0 ) );
	}
	
	int i;
	
	for( i = 0;i < ActiveCount;i++ ) // Active
	{
		/*	There is no collision if :
		 *	1.This is an Cloud 
		 *	2.This is an (Fireball ,Mushroom, moving Turtle shell) and the Object is an Enemystopper
		 */
		if( !ActiveObjects[i] || this->ID == ActiveObjects[i]->ID || this->type == TYPE_BANZAI_BILL || 
			this->type == TYPE_CLOUD || ( ( this->type == TYPE_FIREBALL || this->type == TYPE_MUSHROOM_DEFAULT || this->type == TYPE_MUSHROOM_LIVE_1 ||
			( this->type == TYPE_TURTLE_RED && this->state == 3 ) ) && ActiveObjects[i]->type == TYPE_ENEMYSTOPPER ) || 
			( this->Array == ARRAY_ACTIVE && ( ActiveObjects[i]->type == TYPE_GOLDPIECE || ActiveObjects[i]->type == TYPE_BOUNCINGGOLDPIECE ) ) 
			|| ( this->Array == ARRAY_ENEMY && ( ActiveObjects[i]->type == TYPE_MUSHROOM_DEFAULT || ActiveObjects[i]->type == TYPE_MUSHROOM_LIVE_1 || ActiveObjects[i]->type == TYPE_MOON ) ) )
			{
				continue;
			}
		
		if( this->ID == pPlayer->ID )
		{
			if( !ActiveObjects[i]->massive && !ActiveObjects[i]->halfmassive ) 
			{
				continue;
			}
		}
		else
		{
			if( !ActiveObjects[i]->massive && !ActiveObjects[i]->halfmassive && ActiveObjects[i]->type != TYPE_ENEMYSTOPPER 
				&& ActiveObjects[i]->type != TYPE_MUSHROOM_DEFAULT && ActiveObjects[i]->type != TYPE_MUSHROOM_LIVE_1 ) 
			{
				continue;
			}
			else if( ActiveObjects[i]->type == TYPE_CLOUD ) 
			{
				continue;
			}
		}

		if( ActiveObjects[i]->halfmassive && this->vely < 0 ) 
		{
			continue;
		}

		rect2 = ActiveObjects[i]->rect;

		if( ActiveObjects[i]->halfmassive ) 
		{
			if( (int)this->posy + this->rect.h <= (int)ActiveObjects[i]->posy && 
				this->posx >= ActiveObjects[i]->posx - this->rect.w && 
				(int)this->posx <= (int) ActiveObjects[i]->posx + ActiveObjects[i]->rect.w )
			{
				// nothing
			}
			else
			{
				continue;
			}
		}


		if( RectIntersect( &rect1, &rect2 ) )
		{
			if( !only_check ) 
			{
				iCollisionNumber = i;
				iCollisionType = 2; // Active Obj
				GetCollid( &rect2 );
			}
			return 0;
		}
	}
	
	for( i = 0;i < MassiveCount;i++ ) // Massive
	{
		if( !MassiveObjects[i] || this->ID == MassiveObjects[i]->ID || !MassiveObjects[i]->massive || 
			this->type == TYPE_BANZAI_BILL || this->type == TYPE_JPIRANHA )
		{
			continue;
		}

		rect2 = MassiveObjects[i]->rect;

		if( RectIntersect( &rect1, &rect2 ) )
		{
			if( !only_check ) 
			{
				iCollisionNumber = i;
				iCollisionType = 1; // Massive Obj
				GetCollid( &rect2 );
			}

			return 0;
		}
	}

	for ( i = 0;i < EnemyCount;i++ ) // Enemy
	{
		if( !EnemyObjects[i] || this->ID == EnemyObjects[i]->ID || this->type == TYPE_MUSHROOM_DEFAULT || this->type == TYPE_MUSHROOM_LIVE_1 || 
			this->type == TYPE_FIREPLANT || !EnemyObjects[i]->massive || !this->massive || 
			EnemyObjects[i]->type == TYPE_BANZAI_BILL )
			{
				continue;
			}

		rect2 = EnemyObjects[i]->rect;

		if( this->type == TYPE_PLAYER )
		{
			rect2.x += (int)((rect2.w - rect2.w*0.6)/2);
			rect2.w = (int)(rect2.w*0.6);

			rect2.y += (int)((rect2.h - rect2.h*0.5)/2);
			rect2.h = (int)(rect2.h*0.5);
		}
		else if( this->Array == ARRAY_ENEMY )
		{
			rect2.x += (int)( (rect2.w - rect2.w*0.8)/2 );
			rect2.w = (int)( rect2.w*0.8 );

			rect2.y += (int)( (rect2.h - rect2.h*0.8)/2 );
			rect2.h = (int)( rect2.h*0.8 );
		}

		if( RectIntersect( &rect1, &rect2 ) )
		{
			if( !only_check ) 
			{
				iCollisionNumber = i;
				iCollisionType = 3; // Enemy Obj
				GetCollid( &rect2 );

				if( iCollisionType == 3 ) 
				{
					if( ( EnemyObjects[i]->velx >= velx && velx > 0 && collid == LEFT ) || 
							( EnemyObjects[i]->velx <= velx && velx < 0 && collid == RIGHT ) ||
								( EnemyObjects[i]->velx < 0 && velx > 0 ) ||
						( EnemyObjects[i]->velx > 0 && velx < 0) ) 
					{
						EnemyObjects[i]->EnemyCollision( collid );
					}
				}
			}

			return 0;
		}
	}


	if( this->massive && this->type != TYPE_PLAYER && this->type != TYPE_FIREBALL && 
		this->type != TYPE_MUSHROOM_DEFAULT && this->type != TYPE_MUSHROOM_LIVE_1 ) // Player
	{
		rect2 = pPlayer->rect;

		if( this->Array == ARRAY_ENEMY )
		{
			rect2.x += (int)((rect2.w - rect2.w * 0.6)/2);
			rect2.w = (int)(rect2.w * 0.6);

			rect2.y += (int)((rect2.h - rect2.h * 0.6)/2);
			rect2.h = (int)(rect2.h * 0.6);
		}
		
		if( RectIntersect( &rect1, &rect2 ) )
		{
			if( !only_check ) 
			{
				iCollisionNumber = 0;
				iCollisionType = 4; // Player Obj
				GetCollid( &rect2 );
			}

			return 0;
		}
	}

	return 1;
}



/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cActiveSprite :: cActiveSprite( double x, double y ) : cSprite( NULL, x, y )
{
	type = TYPE_ACTIVESPRITE;
	massive = 1;
	Array = ARRAY_ACTIVE;
	SetPos( x, y );
}

cActiveSprite :: ~cActiveSprite( void )
{
	// empty
}

void cActiveSprite :: PlayerCollision( int cdirection )
{
	// virtual function
}

void cActiveSprite :: EnemyCollision( int cdirection )
{
	// virtual function
}

void cActiveSprite :: BoxCollision( int cdirection, SDL_Rect *r2 )
{
	// virtual function
}

void cActiveSprite :: Update( void )
{
	// virtual function
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cEnemyStopper :: cEnemyStopper( double x, double y ) : cSprite( NULL, x, y )
{
	type = TYPE_ENEMYSTOPPER;
	Array = ARRAY_ACTIVE;
	massive = 0;

	SetImage( NULL );
	rect.w = 15;
	rect.h = 15;
	SetPos( x, y );
}

cEnemyStopper :: ~cEnemyStopper( void )
{
	// nothing
}

void cEnemyStopper :: Draw( SDL_Surface* target )
{
	if( !Leveleditor_Mode )
	{
		rect.x = (int)startposx;
		rect.y = (int)startposy;
		
		return;
	}
	
	rect.x = (int)startposx;
	rect.y = (int)startposy;

	if( rect.x + rect.w < cameraposx )
	{
		return;
	}

	if( rect.x > cameraposx + pPreferences->Screen_W )
	{
		return;
	}
	
	SDL_Rect r = rect;
	r.x -= cameraposx;
	r.y -= cameraposy;
	r.w = rect.w;
	r.h = rect.h;

	//SDL_FillRect( target, &r, darkblue );
	boxRGBA( target, r.x, r.y , r.x + r.w , r.y + r.h, 0, 0, 255, 125 ); 
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cMouseCursor :: cMouseCursor( double x, double y ) : cSprite ( NULL, x, y )
{
	SetImage( GetImage( "game/mouse.png" ) );

	HoveredObject.x = 0;
	HoveredObject.y = 0;
	HoveredObject.w = 0;
	HoveredObject.h = 0;

	Mover_mouse = GetImage( "game/axis_m.png" );

	MouseObject = NULL;
	CopyObject = NULL;

	mouse_H = 0;
	mouse_W = 0;

	fastCopyMode = 0;
	mover_mode = 0;

	MousePressed_left = 0;
	MousePressed_right = 0;

	clickcounter = 0;

	active_type = -1;
	active_number = -1;
}

cMouseCursor :: ~cMouseCursor( void )
{
	image = NULL;
}

bool cMouseCursor :: CollsionCheck( double x, double y )
{
	if( mover_mode ) 
	{
		iCollisionType = 0; // no Collision
		iCollisionNumber = 0;
		return 1;
	}

	SDL_Rect rect1;
	SDL_Rect rect2;
	
	rect1.x = (int) x;
	rect1.y = (int) y;
	rect1.w = 1;
	rect1.h = 1;
	
	int i;
	
	// The Leveleditor Objects
	if( Leveleditor_Mode && !MouseObject )
	{
		// Item Menu
		if( pLeveleditor->wItem.y == screen->h - pLeveleditor->wItem.h ) 
		{
			for( i = 0; i < (int)pLeveleditor->wItem_Count; i++ )
			{
				Menu_Item_Object *Item = pLeveleditor->Get_Item_Object( i + 1 );

				if( !Item || !Item->visible ) 
				{
					continue;
				}

				rect2 = Item->ColRect;
				rect2.x += cameraposx;
				rect2.y += cameraposy;
				
				if ( RectIntersect( &rect1, &rect2 ))
				{
					iCollisionNumber = i;
					iCollisionType = 6; // Leveleditor Item Object

					HoveredObject = Item->ColRect;

					pLeveleditor->wItem_timer = ( DESIRED_FPS*3 );

					return 0;
				}
			}
		}
		
		// Main menu
		if( pLeveleditor->wMain_open == 150 ) 
		{
			for( i = 0; i < (int)pLeveleditor->wMenu_Count; i++ )
			{
				Menu_Main_Object *Item = pLeveleditor->Get_Main_Object( i + 1 );

				if( !Item ) 
				{
					continue;
				}

				rect2 = Item->ColRect;
				rect2.x = pLeveleditor->wMain.x + 15;
				rect2.w = pLeveleditor->wMain.w - 22;
				rect2.x += cameraposx;
				rect2.y += cameraposy;
				
				if ( RectIntersect( &rect1, &rect2 ))
				{
					iCollisionNumber = i;
					iCollisionType = 7; // Leveleditor Main Menu Object

					rect2.x -= cameraposx;
					rect2.y -= cameraposy;
					HoveredObject = rect2;

					if( Item->state == 0 ) 
					{
						Item->state = 1;
					}
					
					pLeveleditor->wMain_timer = ( DESIRED_FPS*3 );

					return 0;
				}
				else
				{
					if( Item->state == 1 )
					{
						Item->state = 0;
					}
				}
			}
		}

	}
	// The Leveleditor Main Menu
	rect2 = pLeveleditor->wMain;
	rect2.x += cameraposx;
	rect2.y += cameraposy;

	if( Leveleditor_Mode && RectIntersect( &rect1, &rect2 ) ) 
	{
		pLeveleditor->wMain_timer = ( DESIRED_FPS*3 );
		iCollisionType = 0;
		iCollisionNumber = 0;
		return 1;
	}
	
	// The Leveleditor Item Menu

	if( pLeveleditor->wItem_Count && Leveleditor_Mode ) 
	{
		if( pLeveleditor->wItem.y == screen->h - pLeveleditor->wItem.h ) 
		{
			rect2 = pLeveleditor->Item_scroller[0];
			rect2.x += cameraposx;
			rect2.y += cameraposy;

			// The left Item Object Scroller
			if( RectIntersect( &rect1, &rect2 ) ) 
			{
				pLeveleditor->wItem_timer = ( DESIRED_FPS*3 );
				iCollisionType = 8;
				iCollisionNumber = 0;

				HoveredObject = pLeveleditor->Item_scroller[0];

				return 0;	
			}

			rect2 = pLeveleditor->Item_scroller[1];
			rect2.x += cameraposx;
			rect2.y += cameraposy;

			// The right Item Object Scroller
			if( RectIntersect( &rect1, &rect2 ) ) 
			{
				pLeveleditor->wItem_timer = ( DESIRED_FPS*3 );
				iCollisionType = 8;
				iCollisionNumber = 1;

				HoveredObject = pLeveleditor->Item_scroller[1];
				
				return 0;	
			}
		}

		rect2 = pLeveleditor->wItem;
		rect2.x += cameraposx;
		rect2.y += cameraposy;

		if( RectIntersect( &rect1, &rect2 ) ) 
		{
			pLeveleditor->wItem_timer = ( DESIRED_FPS*3 );
			iCollisionType = 0;
			iCollisionNumber = 0;
			return 1;
		}
	}


	if( Get_Collision_Dialogs( (int)x, (int)y ) >= 0 ) // Check the Dialog Boxes
	{
		iCollisionType = 10;
		iCollisionNumber = Get_Collision_Dialogs( (int)x, (int)y );
		return 0;
	}

	for ( i = ActiveCount - 1;i >= 0;i-- ) // only Enemystopper
	{
		if ( !ActiveObjects[i] )
		{
			continue;
		}
		
		if( ActiveObjects[i]->type != TYPE_ENEMYSTOPPER ) 
		{
			continue;
		}

		rect2 = ActiveObjects[i]->rect;

		if ( RectIntersect ( &rect1, &rect2 ))
		{
			iCollisionNumber = i;
			iCollisionType = 2; // Active Obj
			return 0;
		}
	}
	
	for( i = EnemyCount - 1;i >= 0;i-- ) // new
	{
		if ( !EnemyObjects[i] || EnemyObjects[i]->type != TYPE_JPIRANHA )
		{
			continue;
		}
		rect2 = EnemyObjects[i]->rect;

		if ( RectIntersect ( &rect1, &rect2 ))
		{
			iCollisionNumber = i;
			iCollisionType = 3; // Enemy Obj
			return 0;
		}
	}
	
	for( i = MassiveCount - 1;i >= 0;i-- )
	{
		if ( !MassiveObjects[i] || !MassiveObjects[i]->massive )
		{
			continue;
		}

		rect2 = MassiveObjects[i]->rect;

		if ( RectIntersect ( &rect1, &rect2 ) )
		{
			iCollisionNumber = i;
			iCollisionType = 1; // Massive Obj
			return 0;
		}
	}

	for( i = ActiveCount - 1;i >= 0;i-- ) // All Active without Enemystopper
	{
		if ( !ActiveObjects[i] )
		{
			continue;
		}
		
		if( ActiveObjects[i]->type == TYPE_ENEMYSTOPPER ) 
		{
			continue;
		}

		rect2 = ActiveObjects[i]->rect;

		if ( RectIntersect ( &rect1, &rect2 ))
		{
			iCollisionNumber = i;
			iCollisionType = 2; // Active Obj
			return 0;
		}
	}
	
	for( i = EnemyCount - 1;i >= 0;i-- )
	{
		if ( !EnemyObjects[i] || EnemyObjects[i]->type == TYPE_JPIRANHA ) // || !EnemyObjects[i]->massive
		{
			continue;
		}

		rect2 = EnemyObjects[i]->rect;

		if ( RectIntersect ( &rect1, &rect2 ))
		{
			iCollisionNumber = i;
			iCollisionType = 3; // Enemy Obj
			return 0;
		}
	}
	
	if( !pPlayer->invincible )
	{
		rect2 = pPlayer->rect;

		if ( RectIntersect ( &rect1, &rect2 ))
		{
			iCollisionNumber = 0;
			iCollisionType = 4; // Player Obj
			return 0;
		}
	}
	
	for( i = PassiveCount - 1;i >= 0;i-- )
	{
		if ( !PassiveObjects[i] )
		{
			continue;
		}

		rect2 = PassiveObjects[i]->rect;

		if ( RectIntersect ( &rect1, &rect2 ) )
		{
			iCollisionNumber = i;
			iCollisionType = 5; // Passive Obj
			return 0;
		}
	}
	
	
	iCollisionType = 0; // no Collision
	iCollisionNumber = 0;
	return 1;
}

void cMouseCursor :: Update( void )
{
	SDL_Rect r;
	r.x = mouseX;
	r.y = mouseY;
	r.w = image->w;
	r.h = image->h;
	
	if( !mover_mode ) 
	{
		if( !MousePressed_left && ( MouseObject || iCollisionType == 6 || iCollisionType == 7 || iCollisionType == 8 ) )
		{
			Draw_HoveredObject();
		}
		
		if( !(MousePressed_left && MouseObject && pPreferences->Lvleditor_automousehide) )
		{
			SDL_BlitSurface( StartImage, NULL, screen, &r );
		}
	}
	else
	{
		SDL_BlitSurface( Mover_mouse, NULL, screen, &r );
	}
}

void cMouseCursor :: Update_Position( void )
{
	SDL_GetMouseState( &mouseX, &mouseY );

	if( !mover_mode ) 
	{
		SetPos( mouseX + cameraposx, mouseY + cameraposy );
	}
	
	rect.x = (int)posx;
	rect.y = (int)posy;
}

void cMouseCursor :: Update_Doubleclick( void )
{
	if( clickcounter ) 
	{
		if( clickcounter - Framerate.speedfactor <= 0 ) 
		{
			clickcounter = 0;
		}
		else
		{
			clickcounter -= Framerate.speedfactor;
		}
	}

	if( active_number ) 
	{
		if( active_type == 1 ) // Massive 
		{
		//	MassiveObjects[active_number]->rect.x
		}
	}
}

void cMouseCursor :: MouseObject_Update( void )
{
	if( mover_mode ) 
	{
		return;
	}

	if( MouseObject )
	{
		MouseObject->startposx 	= ( ( (int)posx ) - mouse_W );
		MouseObject->startposy 	= ( ( (int)posy ) - mouse_H );
		
		MouseObject->posx 	= ( ( (int)posx ) - mouse_W );
		MouseObject->posy 	= ( ( (int)posy ) - mouse_H );

		if( !MousePressed_left )
		{
			HoveredObject.x = (int)( MouseObject->posx - cameraposx );
			HoveredObject.y = (int)( MouseObject->posy - cameraposy );
			
			if( MouseObject->StartImage ) 
			{
				HoveredObject.w = MouseObject->StartImage->w;
				HoveredObject.h = MouseObject->StartImage->h;
			}
			else
			{
				HoveredObject.w = MouseObject->rect.w;
				HoveredObject.h = MouseObject->rect.h;
			}
		}
	}
}

void cMouseCursor :: Double_Click( void )
{
	clickcounter = 0;
	
	CollsionCheck( posx, posy );

	Set_Active( iCollisionType, iCollisionNumber );
}

void cMouseCursor :: Set_Active( unsigned int type, unsigned int number )
{
	active_number = number;
	active_type = type;
}

void cMouseCursor :: Reset_Active( void )
{
	active_number = -1;
	active_type = -1;
}

void cMouseCursor :: Copy( cSprite *nCopyObject, double x, double y )
{		
	cSprite *new_Sprite = Copy_Object( nCopyObject, x, y );

	if( !new_Sprite ) 
	{
		printf( "MouseCursor CopyObject invald source Object\n" );
		return;
	}

	if( new_Sprite->Array == ARRAY_MASSIVE ) 
	{
		AddMassiveObject( new_Sprite );
	}
	else if( new_Sprite->Array == ARRAY_PASSIVE ) 
	{
		AddPassiveObject( new_Sprite );
	}
	else if( new_Sprite->Array == ARRAY_ACTIVE ) 
	{
		AddActiveObject( new_Sprite );
	}
	else if( new_Sprite->Array == ARRAY_ENEMY ) 
	{
		AddEnemyObject( new_Sprite );
	}
	else
	{
		printf( "MouseCursor CopyObject unknown Array : %d\n", new_Sprite->Array );
		delete new_Sprite;
		new_Sprite = NULL;
	}
}

void cMouseCursor :: Delete( void )
{
	if( iCollisionType == 1 )
	{
		delete MassiveObjects[iCollisionNumber];
		MassiveObjects[iCollisionNumber] = NULL;
	}
	else if( iCollisionType == 2 )
	{
		delete ActiveObjects[iCollisionNumber];
		ActiveObjects[iCollisionNumber] = NULL;
	}
	else if( iCollisionType == 3 )
	{
		delete EnemyObjects[iCollisionNumber];
		EnemyObjects[iCollisionNumber] = NULL;
	}
	else if( iCollisionType == 5 )
	{
		delete PassiveObjects[iCollisionNumber];
		PassiveObjects[iCollisionNumber] = NULL;
	}
}

void cMouseCursor :: Draw_HoveredObject( void )
{
	Uint32 dColor = 0;

	if( fastCopyMode )
	{
		dColor = green;
	}
	else
	{
		dColor = white;
	}

	SDL_Rect r2 = HoveredObject;
	
	r2.h = 1;
	SDL_FillRect( screen, &r2, dColor ); // Up

	r2.y += HoveredObject.h;
	SDL_FillRect( screen, &r2, dColor ); // Down

	r2.y += 1;
	SDL_FillRect( screen, &r2, grey );	// Down Shadow

	r2.y = HoveredObject.y;
	r2.h = HoveredObject.h;
	r2.w = 1;
	SDL_FillRect( screen, &r2, dColor );	// Left

	r2.x = HoveredObject.x + HoveredObject.w;
	r2.h += 1;
	SDL_FillRect( screen, &r2, dColor ); // Right

	r2.x += 1;
	SDL_FillRect( screen,&r2, grey );	// Right Shadow
}

void cMouseCursor :: Mover_Update( Sint16 move_x, Sint16 move_y )
{
	if( !mover_mode ) 
	{
		return;
	}
	
	cameraposx += move_x;
	cameraposy += move_y;

	SDL_WarpMouse( mouseX, mouseY );

	SDL_Event inEvent;

	SDL_PeepEvents( &inEvent, 1, SDL_GETEVENT, SDL_MOUSEMOTIONMASK );

	while( SDL_PollEvent( &inEvent ) )
	{
		if( inEvent.type == SDL_MOUSEBUTTONDOWN ) 
		{
			if( inEvent.button.button == 2 ) 
			{
				mover_mode = 0;
			}
			break;
		}
		else if( inEvent.type == SDL_KEYDOWN ) 
		{
			mover_mode = 0;
			KeyDown( event.key.keysym.sym );
			break;
		}
		else if( inEvent.type == SDL_QUIT ) 
		{
			done = 1;
			break;
		}
	}
}

void cMouseCursor :: Editor_Update( void )
{
	if( !CollsionCheck( posx, posy ) )
	{
		string type;
		
		type.reserve( 60 );

		if( iCollisionType == 1 )	// Massive
		{
			if( !MousePressed_left || !MouseObject )
			{
				MouseObject = MassiveObjects[iCollisionNumber];
			}
			if( MouseObject->halfmassive )
			{
				type = "Halfmassive";
			}
			else
			{
				type = "Massive";
			}
		}
		else if( iCollisionType == 2 )	// Active
		{
			if( !MousePressed_left || !MouseObject )
			{
				MouseObject = ActiveObjects[iCollisionNumber];
			}
			if( MouseObject->type == TYPE_ENEMYSTOPPER )
			{
				type = "Enemystopper";
			}
			else if( MouseObject->type == TYPE_GOLDPIECE )
			{
				type = "Goldpiece";
			}
			else if( MouseObject->type == TYPE_MOON )
			{
				type = "Moon (3-UP)";
			}
			else if( MouseObject->type == TYPE_CLOUD )
			{
				type = "Moving Cloud";
			}
			else if( MouseObject->type == TYPE_HALFMASSIVE )
			{
				type = "Halfmassive";
			}
			else if( MouseObject->type == TYPE_GOLDBOX )
			{
				type = "Gold box";
			}
			else if( MouseObject->type == TYPE_BONUSBOX_MUSHROOM_FIRE )
			{
				type = "Bonus box Mushroom - Fire";
			}
			else if( MouseObject->type == TYPE_BONUSBOX_LIVE )
			{
				type = "Bonus box Level-UP";
			}
			else if( MouseObject->type == TYPE_SPINBOX )
			{
				type = "Spin box";
			}
			else if( MouseObject->type == TYPE_LEVELEXIT )
			{
				type = "Levelexit";
			}
			else
			{
				type = "Active";
			}
		}
		else if( iCollisionType == 3 )	// Enemy
		{
			if( !MousePressed_left || !MouseObject )
			{
				MouseObject = EnemyObjects[iCollisionNumber];
			}
			if( MouseObject->type == TYPE_TURTLE_RED )
			{
				type = "Red Rurtle";
			}
			else if( MouseObject->type == TYPE_GOOMBA_BROWN )
			{
				type = "Brown Goomba";
			}
			else if( MouseObject->type == TYPE_GOOMBA_RED )
			{
				type = "Red Goomba";
			}
			else if( MouseObject->type == TYPE_JPIRANHA )
			{
				type = "Jumping Piranha";
			}
			else if( MouseObject->type == TYPE_BANZAI_BILL )
			{
				type = "Banzai Bill";
			}
			else if( MouseObject->type == TYPE_REX )
			{
				type = type, "Rex";
			}
			else 
			{
				type = type, "Enemy";
			}
		}
		else if( iCollisionType == 4 )	// Player
		{
			if( !MousePressed_left || !MouseObject )
			{
				MouseObject = (cSprite*)pPlayer;
			}
			
			type = "Player";
		}
		else if( iCollisionType == 5 )	// Passive
		{
			if( !MousePressed_left || !MouseObject )
			{
				MouseObject = PassiveObjects[iCollisionNumber];
			}
			
			type = "Passive";
		}
		else if( iCollisionType == 6 ) // Leveleditor Item Object
		{
			Menu_Item_Object *Item = pLeveleditor->Get_Item_Object( iCollisionNumber + 1 );

			if( Item && !MousePressed_left ) 
			{
				type = Item->name;
			}
			else
			{
				type = "";
			}

			if( !MouseObject ) 
			{
				if( MousePressed_left ) 
				{
					cSprite *new_Sprite = NULL;
					
					new_Sprite = Copy_Object( Item->Sprite_type, posx, posy );

					if( !new_Sprite ) 
					{
						printf( "Sprite copying Error\n" );
						return;
					}

					if( new_Sprite->Array == ARRAY_MASSIVE ) 
					{
						AddMassiveObject( new_Sprite );
					}
					else if( new_Sprite->Array == ARRAY_PASSIVE ) 
					{
						AddPassiveObject( new_Sprite );
					}
					else if( new_Sprite->Array == ARRAY_ACTIVE ) 
					{
						AddActiveObject( new_Sprite );
					}
					else if( new_Sprite->Array == ARRAY_ENEMY ) 
					{
						AddEnemyObject( new_Sprite );
					}

					new_Sprite->posx = posx;
					new_Sprite->posy = posy;

					mouse_H = new_Sprite->rect.h/2;
					mouse_W = new_Sprite->rect.w/2;

					MouseObject = new_Sprite;
				}
			}
			else if( !MousePressed_left ) 
			{
				MouseObject = NULL;
			}
		}
		else if( iCollisionType == 7 ) // Leveleditor Main Menu Object
		{
			Menu_Main_Object *Item = pLeveleditor->Get_Main_Object( iCollisionNumber + 1 );

			if( Item && !MousePressed_left ) 
			{
				type = Item->name;
			}
			else
			{
				type = "";
			}

			if( !MouseObject ) 
			{
				if( MousePressed_left ) 
				{
					if( Item->Item_Menu_Id != MENU_FUNCTION ) 
					{
						pLeveleditor->Load_Item_Menu( Item->Item_Menu_Id );
						pLeveleditor->Set_Main_Active( iCollisionNumber );
					}
					else
					{
						Item->pfunction();
						MousePressed_left = 0;
					}
				}
			}
			else
			{
				MouseObject = NULL;
			}
		}
		else if( iCollisionType == 8 ) // Leveleditor Item Object Scroller
		{
			type = "Object Scroller";

			if( !MouseObject && MousePressed_left ) 
			{
				if( iCollisionNumber == 0 ) 
				{
					pLeveleditor->Item_scoll += Framerate.speedfactor*8;

					pLeveleditor->Set_Item_Objects_Pos();
				}
				else if( iCollisionNumber == 1 ) 
				{
					// todo : limit
					pLeveleditor->Item_scoll -= Framerate.speedfactor*8;

					pLeveleditor->Set_Item_Objects_Pos();
				}
			}
			else if( !MousePressed_left ) 
			{
				MouseObject = NULL;
			}

		}
		else if( iCollisionType == 10 ) // A Dialog Box
		{
			if( DialogCount >= iCollisionNumber && iCollisionNumber >= 0 )
			{
				type = DialogObjects[iCollisionNumber]->identifier;

				if( MousePressed_left ) 
				{
					DialogObjects[iCollisionNumber]->Get_Focus();
					MousePressed_left = 0;
				}
			}
		}

		if( iCollisionType > 0 && iCollisionType < 6 && MouseObject )
		{
			if( !MousePressed_left )
			{
				if( iCollisionType == 4 || iCollisionType == 3 ) // If Player or Enemy !
				{
					mouse_W = (int)posx - (int)MouseObject->startposx;
					mouse_H = (int)posy - (int)MouseObject->startposy;
				}
				else
				{
					mouse_W = (int)posx - (int)MouseObject->posx;
					mouse_H = (int)posy - (int)MouseObject->posy;
				}
			}
			
			SDL_Rect rect_pos;
			SDL_Surface *Position_info = NULL;
			char info[50];

			rect_pos.x = mouseX + 20;
			rect_pos.y = mouseY + 35;
			
			sprintf( info ,"Pos X : %d  Y : %d", (int)MouseObject->posx, (int)MouseObject->posy );
			Position_info = TTF_RenderText_Blended( font_16, info, colorBlack );
			
			SDL_BlitSurface( Position_info, NULL, screen, &rect_pos );

			SDL_FreeSurface( Position_info );
			Position_info = TTF_RenderText_Blended( font_16, info, colorWhite );

			rect_pos.x -= 2;
			rect_pos.y -= 2;

			SDL_BlitSurface( Position_info, NULL, screen, &rect_pos );

			SDL_FreeSurface( Position_info );
		}
		
		if( debugdisplay->counter <= 0 )
		{
			sprintf( debugdisplay->text, "%s", type.c_str() );
			debugdisplay->counter = 1;
		}
	}
	else
	{
		if( !MousePressed_left )
		{
			MouseObject = NULL;
		}
		
		if( !MousePressed_left && iCollisionType == 0 )
		{
			mouse_W = 0;
			mouse_H = 0;
		}
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */
