/***************************************************************************
              banzai_bill.cpp  -  banzai bill,a giant, slow-moving bullet.
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

cbanzai_bill :: cbanzai_bill( double x, double y, int fdirection ) : cEnemy( x, y )
{
	massive = 0;
	vely = 0;
	velx = 0;
	direction = fdirection;
	walk_count = 0;
	iCollisionType = 0;
	state = 0;

	type = TYPE_BANZAI_BILL;

	if( direction == LEFT )
	{
		SetImage( GetImage( "Enemy/Banzai_Bill/l.png" ) );
	}
	else
	{
		SetImage( GetImage( "Enemy/Banzai_Bill/r.png" ) );
	}
	
	SetPos( x, y );
}

cbanzai_bill :: ~cbanzai_bill( void )
{
	//
}

void cbanzai_bill :: Die( void )
{
	dead = 1;
	massive = 0;
	
	DieStep();
}

void cbanzai_bill :: DieStep( void )
{
	Move( 0, 17, 0, 1 );

	Draw( screen );
	
	if(posy > 600)
	{
		visible = 0;
		massive = 0;
	}
}

void cbanzai_bill :: Update( void )
{
	if( dead )
	{
		if( visible )
		{
			DieStep();
		}

		return;
	}
	

	if( !massive )
	{
		if( direction == LEFT )
		{
			if( pPlayer->posx + 1000 > posx || walk_count )
			{
				AddVel( -6.5, 0, 1 );
			}
			else
			{
				return;
			}
		}
		else
		{
			if( pPlayer->posx - 1000 > posx || walk_count )
			{
				AddVel( 6.5, 0, 1 );
			}
			else
			{
				return;
			}
		}

		pAudio->PlaySound( SOUNDS_DIR "/cannon_1.ogg" );
		
		walk_count = 1;
		massive = 1;
	}

	
	if( massive && CollideMove() )
	{
		if( iCollisionType == 4 )
		{
			this->PlayerCollision( collid );
		}

		if( EnemyCount && visible && massive && !dead ) 
		{
			Move( velx, vely, 0, 1 );
		}
	}
	
   	if( EnemyCount && visible && massive && !dead )
	{
		Draw( screen );
	}
}

void cbanzai_bill :: PlayerCollision( int cdirection )
{
	if( cdirection == DOWN && ( pPlayer->velx != 0 || pPlayer->vely != 0 ) )
	{
		pointsdisplay->AddPoints( 250, (int)pPlayer->posx + pPlayer->image->w/3, (int)pPlayer->posy - 5 );
		pAudio->PlaySound( SOUNDS_DIR "/stomp_1.ogg" );
		this->Die();
		pPlayer->start_enemyjump = 1;
	}
	else if( !dead && cdirection != -1 )
	{
		pPlayer->Die();
	}
}
