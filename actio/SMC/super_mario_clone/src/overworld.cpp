/***************************************************************************
    overworld.cpp  -  class for the OverWorld Map
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
#include "include/main.h"

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

// class Waypoint

cWaypoint :: cWaypoint( void )
{
	gcolor = 0;
	glim = 1;
	
	access = 0;
	
	ID = 0;
	rect.x = 0;
	rect.y = 0;

	direction_back = 0;
	direction_forward = 0;

	rect.w = 20; // default
	rect.h = 20;

	type = WAYPOINT_NORMAL;

	water = NULL;
	land = NULL;

	levelname = "";

	arrow_white_l = NULL;
	arrow_white_r = NULL;
	arrow_white_u = NULL;
	arrow_white_d = NULL;

	arrow_blue_l = NULL;
	arrow_blue_r = NULL;
	arrow_blue_u = NULL;
	arrow_blue_d = NULL;
}

cWaypoint :: ~cWaypoint( void )
{
	if( levelname.length() > 0 )
	{
		levelname = "";
	}

	arrow_white_l = NULL;
	arrow_white_r = NULL;
	arrow_white_u = NULL;
	arrow_white_d = NULL;

	arrow_blue_l = NULL;
	arrow_blue_r = NULL;
	arrow_blue_u = NULL;
	arrow_blue_d = NULL;

	land = NULL;
	water = NULL;
}

void cWaypoint :: Init( void )
{
	water = GetImage( "world/Waypoints/water_1.png" );
	land = GetImage( "world/Waypoints/land_1.png" );

	arrow_blue_l = GetImage( "world/arrowb_left_small.png" );
	arrow_blue_r = GetImage( "world/arrowb_right_small.png" );
	arrow_blue_u = GetImage( "world/arrowb_up_small.png" );
	arrow_blue_d = GetImage( "world/arrowb_down_small.png" );

	arrow_white_l = GetImage( "world/arrow_left_small.png" );
	arrow_white_r = GetImage( "world/arrow_right_small.png" );
	arrow_white_u = GetImage( "world/arrow_up_small.png" );
	arrow_white_d = GetImage( "world/arrow_down_small.png" );
}

void cWaypoint :: Draw( void )
{
	if( !land ) 
	{
		Init();
	}
	
	if( glim )
	{
		gcolor += 3;
	}
	else
	{
		gcolor -= 3;
	}

	if( gcolor > 120 )
	{
		glim = 0;
	}
	else if( gcolor < 7 )
	{
		glim = 1;
	}
	
	SDL_Surface *ring, *image;

	ring = NULL;
	image = NULL;

	if( Overworld_debug )
	{
		if( type == 2 )
		{
			ring = water;
		}
		else if( type == 1 )
		{
			ring = land;
		}
		else
		{
			ring = MakeSurface( 20, 15 );

			SDL_SetColorKey( ring, SDL_SRCCOLORKEY | SDL_RLEACCEL, magenta );
		}

		SDL_Rect ra;
	
		ra.x = rect.x - cameraposx;
		ra.y = rect.y - cameraposy;
		
		// Direction Back
		if( direction_back == RIGHT )
		{
			ra.x += ring->w;
			ra.y -= 2;
			SDL_BlitSurface( arrow_blue_r, NULL, screen, &ra );
		}
		else if( direction_back == LEFT )
		{
			ra.x -= arrow_blue_l->w;
			ra.y -= 4;
			SDL_BlitSurface( arrow_blue_l, NULL, screen, &ra );
		}
		else if( direction_back == UP )
		{
			ra.y -= ring->h;
			SDL_BlitSurface( arrow_blue_u, NULL, screen, &ra );
		}
		else if( direction_back == DOWN )
		{
			ra.y += arrow_blue_d->h;
			SDL_BlitSurface( arrow_blue_d, NULL, screen, &ra );
		}

		ra.x = rect.x - cameraposx;
		ra.y = rect.y - cameraposy;

		// Direction Forward
		if( direction_forward == RIGHT )
		{
			ra.x += ring->w;
			ra.y -= 2;
			SDL_BlitSurface( arrow_white_r, NULL, screen, &ra );
		}
		else if( direction_forward == LEFT )
		{
			ra.x -= arrow_white_l->w;
			ra.y -= 4;
			SDL_BlitSurface( arrow_white_l, NULL, screen, &ra );
		}
		else if( direction_forward == UP )
		{
			ra.y -= ring->h;
			SDL_BlitSurface( arrow_white_u, NULL, screen, &ra );
		}
		else if( direction_forward == DOWN )
		{
			ra.y += arrow_white_l->h;
			SDL_BlitSurface( arrow_white_d, NULL, screen, &ra );
		}	

	}	
	else if( type == 0 )
	{
		// Nothing
	}
	else if( type == 1 )
	{
		ring = land;
	}
	else if( type == 2 )
	{
		ring = water;
	}


	if( type == 1 || type == 2 || Overworld_debug )
	{
		image = MakeSurface( ring->w, ring->h, 1 );

		SDL_SetColorKey( image, SDL_SRCCOLORKEY | SDL_RLEACCEL, magenta );
		
		if( !Overworld_debug )
		{
			SDL_FillRect( image, NULL, SDL_MapRGB( image->format, 250, 100 + gcolor, 10 ) );
		}
		else
		{
			SDL_FillRect( image, NULL, SDL_MapRGB( image->format, 20, 100 + gcolor, 10 ) );
		}

		
		SDL_BlitSurface( ring, NULL, image, NULL );

		SDL_Rect rt;
		
		rt.x = rect.x - cameraposx;
		rt.y = rect.y - cameraposy;
		rt.w = image->w;
		rt.h = image->h;
		
		SDL_BlitSurface( image, NULL, screen, &rt );
		
		ring = NULL;
		SDL_FreeSurface( image );
	}
}
/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

// class Layer

cLayer :: cLayer( void )
{
	image = NULL;
	x = 0;
	y = 0;
}

cLayer :: cLayer( char *filename )
{
	image = GetImage( filename );
	x = 0;
	y = 0;
}

cLayer :: ~cLayer( void )
{
	if( image )
	{
		image = NULL;
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

// class OverWorld

cOverWorld :: cOverWorld( void )
{
	Nlevel = -1;
	Slevel = 0;

	Overworld_debug = 0;
	showlayer = 0;
	cameramode = 0;

	Debugimage = NULL;
	DebugWaypoint = NULL;
	Debugimage_shadow = NULL;
	DebugWaypoint_shadow = NULL;
	DebugNlevel = NULL;
	DebugNlevel_shadow = NULL;
	
	OverWorld_Count = 0;
	Current_OverWorld = 0;
	Waypointcount = 0;
	Current_Waypoint = -2;
	MapObjectCount = 0;
	
	MapObjects = NULL;
	Layer = NULL;

	int i = 0;

	for( i = 0;i < 5;i++ )
	{
		Mario_Anims[i] = NULL;
	}

	Mario_Anim_counter = 0;
	Mario_Anim_Max = 0;
	Mario_Anim_Speed = 0;
	Mario_fixed_walking = 0;

	Mario = new cSprite( NULL, 0, 0 );	
	
	Mario->state = 1;
	Mario->direction = -1;
	
	for( i = 0;i < 5;i++ )
	{
		Mario_Anims[i] = NULL;
	}

	// Get the current Overworlds
	OverWorlds = new char*[MAX_OVERWORLDS];
	
	for( i = 0;i < MAX_WAYPOINTS;i++ )
	{
		Waypoints[i] = new cWaypoint();
	}
	
	ifstream ifs( OVERWORLD_DIR "/worlds.txt", ios :: in );

	if( !ifs )
	{
		printf( "Couldn't open Worlds file : %s/%s\n", OVERWORLD_DIR, "worlds.txt" );
		exit( 2 );
	}

	char contents[100];

	for( i = 0; ifs.getline( contents, sizeof( contents ) ); i++ )
	{
		if( contents[0] != '#' && strlen( contents ) > 3 ) // commented lines and empty lines not
		{
			OverWorlds[OverWorld_Count] = new char[100];
			sprintf( OverWorlds[OverWorld_Count], "%s/%s/world.txt", OVERWORLD_DIR, contents );
			OverWorld_Count++;
		}
	}

	ifs.close();

	// Load the current Overworld ......
}

cOverWorld :: ~cOverWorld( void )
{
	int  i = 0;
	
	if( Debugimage )
	{
		SDL_FreeSurface( Debugimage );
		Debugimage = NULL;
	}
	if( Debugimage_shadow )
	{
		SDL_FreeSurface( Debugimage_shadow );
		Debugimage_shadow = NULL;
	}

	if( DebugWaypoint )
	{
		SDL_FreeSurface( DebugWaypoint );
		DebugWaypoint = NULL;
	}
	if( DebugWaypoint_shadow )
	{
		SDL_FreeSurface( DebugWaypoint_shadow );
		DebugWaypoint_shadow = NULL;
	}
	
	UnloadOverWorld();

	UnloadMarioImages();

	for( i = 0;i < MAX_WAYPOINTS;i++ )
	{
		delete Waypoints[i];
		Waypoints[i] = NULL;
	}

	delete []OverWorlds;
	delete []MapObjects;

	OverWorlds = NULL;
	MapObjects = NULL;

	delete Mario;
	Mario = NULL;
}

void cOverWorld :: Enter( void )
{
	Game_Mode = MODE_OVERWORLD;
	Leveleditor_Mode = 0;
	
	LoadMarioImages();

	pAudio->FadeOutMusic( 1000 );
	pAudio->PlayMusic( MUSIC_DIR "/overworld/land_1.ogg", -1, 0, 1500 );

	if( !MapObjects && !Layer )
	{
		LoadOverWorld( 0 );
	}
	else
	{
		LoadHudObjects();
	}

	cameraposx = 0;
	cameraposy = 0;
	
	int Entered = 0;
	
	while( !Entered )
	{
		// ### Keys

		while( SDL_PollEvent (&event) && !Entered ) 
		{
			if( event.type == SDL_QUIT )
			{
				pLevel->Unload();
				Entered = 1;
				done = 1;
			}
			else if( KeyPressed( KEY_ESC ) )
			{
				Entered = 2;
			}
			else if( KeyPressed( KEY_ENTER ) )
			{
				if( Current_Waypoint > -1 && Mario->direction == -1 )
				{
					char *Levelname = new char[strlen( LEVEL_DIR ) + 1 + Waypoints[Current_Waypoint]->levelname.length() + 1];
			
					sprintf( Levelname, "%s%s", LEVEL_DIR "/", Waypoints[Current_Waypoint]->levelname.c_str() );
					
					
					pLevel->Load( Levelname );
					
					delete Levelname;
					
					Entered = 1;
					
					DrawEffect( 100 ); // SMW Pixelation
					continue;
				}
			}
			else if( event.key.keysym.sym == SDLK_d && ( event.key.keysym.mod & KMOD_LCTRL ) && event.type == SDL_KEYDOWN )
			{
				if( !Overworld_debug )
				{
					if( !Debugimage )
					{
						Debugimage = TTF_RenderText_Blended( font, "Debug Mode", colorWhite );
						Debugimage_shadow = TTF_RenderText_Blended( font, "Debug Mode", colorBlack );
					}
					
					Overworld_debug = 1;
					printf( "OverWorld Debug Mode Activated\n" );
				}
				else
				{
					Overworld_debug = 0;
					printf( "OverWorld Debug Mode Deactivated\n" );
				}	
			}
			else if( event.key.keysym.sym == SDLK_l && event.type == SDL_KEYDOWN )
			{
				if( Overworld_debug ) 
				{
					if( !showlayer )
					{
						showlayer = 1;
						printf( "OverWorld : Debug Layer Activated\n" );
					}
					else
					{
						showlayer = 0;
						printf( "OverWorld : Debug Layer Deactivated\n" );
					}
				}
				else
				{
					KeyDown( SDLK_l );

					if( pLevel->Levelfile.length() > 2 ) 
					{
						Entered = 1;
					}
				}
			}
			else if( event.key.keysym.sym == SDLK_c && event.type == SDL_KEYDOWN )
			{
				if( cameramode && Current_Waypoint != -1 )
				{
					cameramode = 0;
				}
				else
				{
					cameramode = 1;
				}
			}
			else if( KeyPressed( KEY_LEFT ) && Mario->direction != LEFT && !cameramode )
			{
				SetMarioDirection( LEFT );
			}
			else if( KeyPressed( KEY_RIGHT ) && Mario->direction != RIGHT && !cameramode )
			{
				SetMarioDirection( RIGHT );	
			}
			else if( KeyPressed( KEY_UP ) && Mario->direction != UP && !cameramode )
			{
				SetMarioDirection( UP );
			}
			else if( KeyPressed( KEY_DOWN ) && Mario->direction != DOWN && !cameramode )
			{
				SetMarioDirection( DOWN );
			}
		}
		
		// ## Input Keys
		
		keys = SDL_GetKeyState( NULL );
		
		// ## Camera
		
		UpdateCamera();
		
		pAudio->Update();

		if( Entered )
		{
			continue;
		}
	
		SDL_FillRect( screen, NULL, darkblue ); // Background color
		
		DrawMapObjects(); // Objects
		
		DrawHUD();
		
		DrawDebug();
		
		SDL_Flip( screen );
		
		// ## Frametime
		CorrectFrameTime();
	}
	
	if( Entered == 2 )
	{
		pMenu->ShowMenu();
	}
	
	Framerate.Reset();

	Game_Mode = MODE_LEVEL;
	
	UpdateHudObjects();
}

void cOverWorld :: LoadOverWorld( unsigned int overworld )
{
	int i = 0;
	
	if( MapObjects || Layer )
	{
		UnloadOverWorld();
	}

	ifstream ifs( OverWorlds[overworld], ios::in );
	
	if( !ifs )
	{
		cout << "Open level file failed: " << OverWorlds[overworld] << endl;
		exit( 1 );
	}
	
	char contents[1000];
	
	for( i = 0; ifs.getline( contents, sizeof( contents ) ); i++ )
	{
		GetMap( contents, i );
	}
	
	ifs.close();

	// Reloads the Waypoint images
	for( int i = 0;i < Waypointcount;i++ )
	{
		Waypoints[i]->Init();
	}

	LoadMarioImages();
	
	LoadHudObjects();
}

void cOverWorld :: UnloadOverWorld( void )
{
	int i = 0;
	
	if( MapObjects )
	{
		for( i = 0;i < MapObjectCount;i++ )

		if( MapObjects[i] )
		{
			delete MapObjects[i];
			MapObjects[i] = NULL;
		}
		
		delete []MapObjects;
		MapObjects = NULL;
	}
	
	if( Layer )
	{
		//delete Layer;
		Layer = NULL;
	}
	
	OverWorld_Count = 0;
	Current_OverWorld = 0;
	
	Waypointcount = 0;
	MapObjectCount = 0;
}

void cOverWorld :: LoadMarioImages( void )
{
	UnloadMarioImages();
	
	//printf("Loading Mario Images\n");
	
	if( Mario->state == MARIO_SMALL )
	{
		if( Mario->direction == DOWN )
		{
			Mario_Anims[0] = GetImage( "world/mario/small_d1.png" );
			Mario_Anims[1] = GetImage( "world/mario/small_d2.png" );
			Mario_Anims[2] = GetImage( "world/mario/small_d1.png" );
			Mario_Anims[3] = GetImage( "world/mario/small_d3.png" );
			
			Mario_Anim_Max = 4;
			Mario_Anim_Speed = 2;
		}
		else if( Mario->direction == UP )
		{
			Mario_Anims[0] = GetImage( "world/mario/small_u2.png" );
			Mario_Anims[1] = GetImage( "world/mario/small_u1.png" );
			Mario_Anims[2] = GetImage( "world/mario/small_u2.png" );
			Mario_Anims[3] = GetImage( "world/mario/small_u3.png" );
			
			Mario_Anim_Max = 4;
			Mario_Anim_Speed = 2;
		}
		else if( Mario->direction == LEFT )
		{
			Mario_Anims[0] = GetImage( "world/mario/small_l1.png" );
			Mario_Anims[1] = GetImage( "world/mario/small_l2.png" );
			
			Mario_Anim_Max = 2;
			Mario_Anim_Speed = 3;
		}
		else if( Mario->direction == RIGHT )
		{
			Mario_Anims[0] = GetImage( "world/mario/small_r1.png" );
			Mario_Anims[1] = GetImage( "world/mario/small_r2.png" );
			
			Mario_Anim_Max = 2;
			Mario_Anim_Speed = 3;
		}
		else // Standard Animation
		{
			Mario_Anims[0] = GetImage( "world/mario/small_d1.png" );
			Mario_Anims[1] = GetImage( "world/mario/small_d2.png" );
			Mario_Anims[2] = GetImage( "world/mario/small_d1.png" );
			Mario_Anims[3] = GetImage( "world/mario/small_d3.png" );
			
			Mario_Anim_Max = 4;
			Mario_Anim_Speed = 2;
		}
	}
	else if( Mario->state == MARIO_YOSHI_SMALL )
	{
		Mario_Anims[0] = GetImage( "world/mario/yoshi_d1.png" );
		Mario_Anims[1] = GetImage( "world/mario/yoshi_d2.png" );
		Mario_Anim_Max = 2;
		Mario_Anim_Speed = 3;
	}
	else
	{
		printf( "Unsupported Mario state : %d\n", Mario->state );
		Mario->state = MARIO_SMALL;
		return;
	}
	
	Mario->SetImage( Mario_Anims[0] );	
	//printf( "Loaded Mario Images\n" );
}

void cOverWorld :: UnloadMarioImages( void )
{
	for( int  i = 0;i < 5;i++ )
	{
		if( Mario_Anims[i] )
		{
			Mario_Anims[i] = NULL;
		}
	}
	
	Mario_Anim_counter = 0;
	Mario_Anim_Max = 0;
	Mario_Anim_Speed = 0;
}

bool cOverWorld :: SetMarioDirection( int direction )
{
	if( !( Current_Waypoint < Nlevel ) && Waypoints[Current_Waypoint]->direction_forward == direction && Mario->direction == -1 )
	{
		//printf("SetMarioDirection Waypoint Error\n");
		return 0;
	}

	if( !Mario->image )
	{
		return 0;
	}

	/*
	if( Current_Waypoint >= 0 )
	{
		printf("Direction Forward : %d\n",Waypoints[Current_Waypoint]->directionf);
	}
	*/

	int direction2 = 0;
	int directioncheckx,directionchecky;
	
	int oldDirecion = Mario->direction;
	
	directioncheckx = directionchecky = 0;
	
	if( direction == LEFT )
	{
		direction2 = RIGHT;
		directioncheckx = -25;
	}
	else if( direction == RIGHT )
	{
		direction2 = LEFT;
		directioncheckx = +25;
	}
	else if( direction == UP )
	{
		direction2 = DOWN;
		directionchecky = -25;
	}
	else if( direction == DOWN )
	{
		direction2 = UP;
		directionchecky = +25;
	}
	else
	{
		printf( "SetMarioDirection : direction is invalid : %d\n", direction );
		return 0;
	}

	if( Mario->direction != -1 )
	{
		if( Mario->direction == direction2 && !Mario_fixed_walking && WaypointCollision( Mario ) == -1 )
		{
			Mario->direction = direction;
			LoadMarioImages();
		}
	}
	else
	{
		SDL_LockSurface( Layer->image );
		
		int px = (int)( Mario->posx - Layer->x + Mario->image->w/2 );
		int py = (int)( Mario->posy - Layer->y + Mario->image->h/1.25 );
		
		if( SDL_GetPixel( Layer->image, px + directioncheckx,py + directionchecky ) == SDL_MapRGB( Layer->image->format, 0, 255, 0 ) )
		{
			Mario->direction = direction;
			LoadMarioImages();
		}
		
		SDL_UnlockSurface( Layer->image );
	}
	
	if( Current_Waypoint > -1 && !RectIntersect( &Mario->rect, &Waypoints[Current_Waypoint]->rect ) )
	{
		Current_Waypoint = -1;
	}
	
	if( oldDirecion != Mario->direction )
	{
		return 1;
	}
	
	return 0;
}

int cOverWorld :: SetMarioPos( int Waypoint )
{
	if( Waypoints[Waypoint] )
	{
		if( Waypoints[Waypoint]->access ) 
		{
			Mario->SetPos( Waypoints[Waypoint]->rect.x - 15 , Waypoints[Waypoint]->rect.y - 35 );
		}
	}

	return 0;
}

void cOverWorld :: UpdateCamera( void )
{
	if( cameramode )
	{
		if( keys[pPreferences->Key_right] || ( pJoystick->right && pPreferences->Joy_enabled ) )
		{
			cameraposx += 10;
		}
		else if( keys[pPreferences->Key_left] || ( pJoystick->left && pPreferences->Joy_enabled ) )
		{
			cameraposx -= 10;
		}
		if( keys[pPreferences->Key_up] || ( ( pJoystick->up || pJoystick->Button( pPreferences->Joy_jump ) ) && pPreferences->Joy_enabled ) )
		{
			cameraposy -= 10;
		}
		else if( keys[pPreferences->Key_down] || ( pJoystick->down && pPreferences->Joy_enabled ) )
		{
			cameraposy += 10;
		}
	}
	else
	{
		if( Mario->posx - cameraposx - 1> (pPreferences->Screen_W / 4 * 3) ) // Right
		{
			cameraposx = (int) (Mario->posx - (pPreferences->Screen_W / 4 * 3));
		}
		else if( cameraposx && Mario->posx - cameraposx + 1 < (pPreferences->Screen_W / 8 * 2) ) // Left
		{
			cameraposx = (int) (Mario->posx - (pPreferences->Screen_W / 8 * 2));
		}
		
		if( Mario->posy - cameraposy + 1 < (pPreferences->Screen_H / 6) ) // Up
		{
			cameraposy = (int) (Mario->posy - (pPreferences->Screen_H / 6));
		}
		else if( cameraposy && Mario->posy - cameraposy - 1 > (pPreferences->Screen_H / 6 * 2.9) ) // Down
		{
			cameraposy = (int) (Mario->posy - (pPreferences->Screen_H / 6 * 2.9));
		}
	}
}

int cOverWorld :: WaypointCollision( cSprite *s2 )
{
	for( int  i = 0;i < Waypointcount;i++ )
	{
		if( RectIntersect( &s2->rect, &Waypoints[i]->rect ) )
		{
			return i;
		}
	}
	
	return -1;
}

// ToDo : The Secret Way
int cOverWorld :: GotoNextLevel( bool Secretpath )
{
	//printf("NL Cur_Waypoint : %d ,Nlevel : %d ,Waypointcount : %d , Acces W+1 : %d\n",
	//	Current_Waypoint,Nlevel,Waypointcount,Waypoints[Current_Waypoint + 1]->access);
	
	if( Waypointcount <= 0 )
	{
		return 0;
	}

	if( Current_Waypoint < Waypointcount && Waypoints[Current_Waypoint]->direction_forward > -1 ) // Checks if Waypoint exist and if its not the first
	{
		if( !Waypoints[Current_Waypoint + 1]->access )
		{
			Waypoints[Current_Waypoint + 1]->access = 1;

			Nlevel++;
			//pPlayer->Waypoint++;

			SetMarioDirection( Waypoints[Current_Waypoint]->direction_forward );	

			return 1;
		}
	}

	return  0;
}

void cOverWorld :: LoadMap( void )
{

}

void cOverWorld :: GetMap( char *command,int line )
{
	if ( strlen( command ) <= 5 || *command == '#')
	{
		return;
	}

	if( command[ strlen( command ) - 1] == '\r' ) // for Linux support
	{
		command[ strlen( command ) - 1 ] = 0;
	}

	char *str = command;
	int count = 0;
	int i = 0;
	
	str += strspn( str, " " );
	
	while( *str )
	{
		count++;
		str += strcspn( str, " " );
		str += strspn( str, " " );
	}
	
	str = command; // reset
	
	char** parts = new char*[ count ];
	
	str += strspn( str, " " );
	
	while( *str )
	{
		int len = strcspn( str, " " );
		parts[i] = (char*)malloc( len + 1 );
		memcpy( parts[i], str, len );
		parts[i][len] = 0;
		str += len + strspn( str + len, " " );
		i++; 
	}
	

/***************************************************************************/
	
	if( strcmp( parts[0], "Sprite" ) == 0 )
	{
		// filename,x,y

		if( count != 4 )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << " OverWorld Sprite needs 4 parameters" << endl;
			exit(1);
		}
		
		char *filename = new char[100];

		sprintf( filename, "%s/%s/%s", PIXMAPS_DIR, "world/overworlds", parts[1] );
		FILE *fp = fopen( filename, "r" );

		if( !fp )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! file not found: " << parts[1] << endl;
			exit( 1 );
		}
		else
		{
			fclose( fp );
		}
		
		sprintf( filename, "world/overworlds/%s", parts[1] );

		if( !is_valid_number( parts[2] ) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid integer value" << endl;
			exit(1);
		}
		if( !is_valid_number( parts[3] ) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[3] << " is not a valid integer value" << endl;
			exit(1);
		}
		
		SDL_Surface *sTemp = GetImage( filename );
		cSprite *temp = new cSprite( sTemp, atoi( parts[2] ), pPreferences->Screen_H - atoi( parts[3] ) );
		AddMapObject( temp );

		delete []filename;
	}
	else if( strcmp( parts[0], "Layer" ) == 0 )
	{
		// filename todo x,y
		if( count != 2 )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << " OverWorld Layer needs 2 parameters" << endl;
			exit(1);
		}
		
		char *filename = new char[120];
		sprintf( filename, "%s/%s/%s", PIXMAPS_DIR, "world/overworlds", parts[1] );
		FILE* fp = fopen( filename, "r" );

		if( !fp )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! file not found: " << parts[1] << endl;
			exit(1);
		}
		else
		{
			fclose( fp );
		}

		sprintf( filename, "world/overworlds/%s", parts[1] );

		/*  Todo
		if (!is_valid_number(parts[2]))
		{
			cout << world[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid integer value" << endl;
			exit(1);
		}
		if (!is_valid_number(parts[3]))
		{
			cout << world[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[3] << " is not a valid integer value" << endl;
			exit(1);
		}
		*/

		if( Layer )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << filename << " Layer already loaded" << endl;
			exit(1);
		}
		else
		{
			Layer = new cLayer( filename );
	
			Layer->x = 0;// atoi(parts[2]);
			Layer->y = pPreferences->Screen_H - 600;// pPreferences->Screen_H - atoi(parts[3]);
		}
	}
	else if( strcmp( parts[0], "Waypoint" ) == 0 )
	{
		// x,y,type,Levelnname,Direction back,Direction forward

		if( count != 8 )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << " OverWorld Waypoint needs 7 parameters" << endl;
			exit(1);
		}

		if( !is_valid_number(parts[1]) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid integer value" << endl;
			exit(1);
		}
		if( !is_valid_number(parts[2]) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid integer value" << endl;
			exit(1);
		}
		if( !is_valid_number(parts[3]) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[3] << " is not a valid integer value" << endl;
			exit(1);
		}
		if( !is_valid_number(parts[7]) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[3] << " is not a valid integer value" << endl;
			exit(1);
		}

		if( strcmp(parts[5],"FIRST") == -1 && strcmp(parts[5],"LAST") == -1 && strcmp(parts[5],"LEFT") == -1 && 
			strcmp(parts[5],"RIGHT") == -1 && strcmp(parts[5],"UP") == -1 && strcmp(parts[5],"DOWN") == -1 )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[5] << " is not a valid value" << endl;
			exit(1);
		}

		if( strcmp(parts[6],"FIRST") == -1 && strcmp(parts[6],"LAST") == -1 && strcmp(parts[6],"LEFT") == -1 && 
			strcmp(parts[6],"RIGHT") == -1 && strcmp(parts[6],"UP") == -1 && strcmp(parts[6],"DOWN") == -1 )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[6] << " is not a valid value" << endl;
			exit( 1 );
		}

		// ToDo : check if levelname exists !

		Waypoints[Waypointcount]->rect.x = atoi( parts[1] );
		Waypoints[Waypointcount]->rect.y = pPreferences->Screen_H - atoi( parts[2] );
		Waypoints[Waypointcount]->type = atoi( parts[3] );

		Waypoints[Waypointcount]->levelname = ".txt";
		Waypoints[Waypointcount]->levelname.insert( 0, parts[4] );

		if( strcmp( parts[5],"FIRST" ) == 0 )
		{
			Waypoints[Waypointcount]->direction_back = -1; // First
		}
		else if( strcmp( parts[5],"LAST" ) == 0 )
		{
			Waypoints[Waypointcount]->direction_back = -2; // Last
		}
		else if( strcmp( parts[5],"LEFT" ) == 0 )
		{
			Waypoints[Waypointcount]->direction_back = LEFT;
		}
		else if( strcmp( parts[5],"RIGHT" ) == 0 )
		{
			Waypoints[Waypointcount]->direction_back = RIGHT; 
		}
		else if( strcmp( parts[5],"UP" ) == 0 )
		{
			Waypoints[Waypointcount]->direction_back = UP;
		}
		else if( strcmp( parts[5],"DOWN" ) == 0 )
		{
			Waypoints[Waypointcount]->direction_back = DOWN;
		}
		else
		{
			printf( "Waypoint back direction error\n" );
		}

		if(strcmp(parts[6],"FIRST") == 0)
		{
			Waypoints[Waypointcount]->direction_forward = -1; // First
		}
		else if(strcmp(parts[6],"LAST") == 0)
		{
			Waypoints[Waypointcount]->direction_forward = -2; // Last
		}
		else if(strcmp(parts[6],"LEFT") == 0)
		{
			Waypoints[Waypointcount]->direction_forward = LEFT;
		}
		else if(strcmp(parts[6],"RIGHT") == 0)
		{
			Waypoints[Waypointcount]->direction_forward = RIGHT; 
		}
		else if(strcmp(parts[6],"UP") == 0)
		{
			Waypoints[Waypointcount]->direction_forward = UP;
		}
		else if(strcmp(parts[6],"DOWN") == 0)
		{
			Waypoints[Waypointcount]->direction_forward = DOWN;
		}
		else
		{
			printf( "Waypoint forward direction error\n" );
		}


		if( atoi( parts[7] ) == 1 || Waypointcount == 0 )
		{
			Waypoints[Waypointcount]->access = 1;
			Nlevel++;
		}

		Waypointcount++;
	}
	else if( strcmp( parts[0], "Player" ) == 0 )
	{
		//Waypoint,state
		if( !is_valid_number( parts[1] ) )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid integer value" << endl;
			exit( 1 );
		}		
		if (!is_valid_number(parts[2]))
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid integer value" << endl;
			exit( 1 );
		}

		if( atoi( parts[1]) > Waypointcount )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid Waypoint value" << endl;
			exit(1);
		}
		
		if( atoi( parts[2] ) > 5 )
		{
			cout << OverWorlds[Current_OverWorld] << ": ";
			cout << "line " << line << " error! " << parts[2] << " is not a valid state value" << endl;
			exit(1);
		}

		if( Current_Waypoint == -2 )
		{
			SetMarioPos( atoi( parts[1] ) );
			Current_Waypoint = atoi( parts[1] );
		}

		Mario->state = atoi( parts[2] );
	}
	else
	{
		cout << OverWorlds[Current_OverWorld] << " : ";
		cout << "line " << line << " error! " << parts[1] << " unknown command" << endl;
	}

	for( i = 0; i < count ; i++ )
	{
		delete( parts[i] );
	}
	
	delete []parts;
}

void cOverWorld :: AddMapObject( cSprite *obj )
{
	MapObjects = (cSprite**) realloc(MapObjects, ++MapObjectCount * sizeof(cSprite*));
	MapObjects[MapObjectCount-1] = obj;
}

void cOverWorld :: DrawMapObjects( void )
{
	int i = 0;

	for( i = 0;i < MapObjectCount;i++ )
	{
		if( !MapObjects[i] )
		{
			continue;
		}

		MapObjects[i]->Draw( screen );
	}

	DrawWaypoints();
	DrawMario();
	
	UpdateMario();
}

void cOverWorld :: UpdateMario( void )
{
	if( Mario->direction == -1 )
	{
		return;
	}

	LockSurface( Layer->image );

	int px = (int)( Mario->posx - Layer->x + Mario->image->w/2 );
	int py = (int)( Mario->posy - Layer->y + Mario->image->h/1.25 );

	int counter = 0;
	int x_counter = 0;
	int y_counter = 0;

	while( SDL_GetPixel( Layer->image, px, py + counter ) == SDL_MapRGB( Layer->image->format, 0, 255, 0 ) )
	{
		counter++;
		y_counter++;
	}

	counter = 0;

	while( SDL_GetPixel( Layer->image, px, py - counter ) == SDL_MapRGB( Layer->image->format, 0, 255, 0 ) )
	{
		counter++;
		y_counter--;
	}		

	counter = 0;

	while( SDL_GetPixel( Layer->image, px + counter ,py ) == SDL_MapRGB( Layer->image->format, 0, 255, 0) )
	{
		counter++;
		x_counter++;
	}

	counter = 0;

	while( SDL_GetPixel( Layer->image, px - counter, py ) == SDL_MapRGB(Layer->image->format, 0, 255, 0) )
	{
		counter++;
		x_counter--;
	}

	counter = 0;
	
	if( Mario->direction == LEFT )
	{
		if( !Mario_fixed_walking )
		{
			MarioWalk( px, py, -3 );

			if( WaypointCollision( Mario ) == -1 )
			{
				if( y_counter > 5 )
				{
					Mario->posy += 1.7;
				}
				else if( y_counter < -5 )
				{
					Mario->posy -= 1.7;
				}
			}
		}
		else // if Mario fixed walking
		{
			WaypointWalk();
		}
	}
	else if( Mario->direction == RIGHT )
	{
		if( !Mario_fixed_walking )
		{
			MarioWalk( px, py, 3 );

			if( WaypointCollision( Mario ) == -1 )
			{
				if( y_counter > 5 )
				{
					Mario->posy += 1.7;
				}
				else if( y_counter < -5 )
				{
					Mario->posy -= 1.7;
				}
			}
		}
		else // if Mario fixed walking
		{
			WaypointWalk();
		}
	}
	else if( Mario->direction == UP )
	{
		if( !Mario_fixed_walking )
		{
			MarioWalk( px, py, 0, -3 );

			if( WaypointCollision( Mario ) == -1 )
			{
				if(x_counter > 5)
				{
					Mario->posx += 1.7;
				}
				else if(x_counter < -5)
				{
					Mario->posx -= 1.7;
				}
			}
		}
		else // if Mario fixed walking
		{
			WaypointWalk();
		}
	}
	else if( Mario->direction == DOWN )
	{
		if( !Mario_fixed_walking )
		{
			MarioWalk( px, py, 0, 3 );

			if( WaypointCollision( Mario ) == -1 )
			{
				if( x_counter > 5 )
				{
					Mario->posx += 1.7;
				}
				else if( x_counter < -5 )
				{
					Mario->posx -= 1.7;
				}
			}
		}
		else // if Mario fixed walking
		{
			WaypointWalk();
		}
	}

	UnlockSurface( Layer->image );
}

void cOverWorld :: DrawMario( void ) // FIXME : the Mario_Anim_Speed does not work correctly
{
	Mario_Anim_counter++;

	if( Mario->state == MARIO_SMALL )
	{
		for( int i = 0;i < 5;i++ )
		{
			//printf("i : %d , Anim Counter : %d , Anim : %d\n",i,Mario_Anim_counter,Mario_Anim_Max/(i + 1));
			
			if( Mario_Anim_counter < Mario_Anim_Max * ( (i + 1) * Mario_Anim_Speed ) )
			{
				if( Mario_Anim_Max < i + 1 )
				{
					//printf("Anim Counter resetted at : %d\n",Mario_Anim_counter);
					Mario_Anim_counter = 0;
					break;
				}
				else
				{
					//printf("Setting image : %d\n",i);
					Mario->SetImage( Mario_Anims[i] );
					break;
				}
			}
		}
	}
	else
	{
		printf( "Animation state error : %d", Mario->state );
	}

	if( Mario->image )
	{
		Mario->Draw( screen );
	}
}

void cOverWorld :: DrawWaypoints( void )
{
	if( !Overworld_debug )
	{
		for (int i = 0;i < Nlevel + 1;i++)
		{
			Waypoints[i]->Draw();
		}
	}
	else
	{
		for( int i = 0;i < Waypointcount;i++ )
		{
			Waypoints[i]->Draw();
		}
	}
}

void cOverWorld :: DrawHUD( void )
{
	// The Black Background
	boxRGBA( screen, 0, 0, screen->w, 30, 230, 170, 0, 255 );
	boxRGBA( screen, 0, 30, screen->w, 35, 200, 150, 0, 255 );
	
	if( livedisplay )
	{
		//DrawShadowedBox( screen, (Sint16)livedisplay->posx - 5, (Sint16)livedisplay->posy, livedisplay->rect.w + 10, livedisplay->rect.h, 0, 80, 0, 64, 1 );
		livedisplay->Update();
	}

	if( pointsdisplay )
	{
		//DrawShadowedBox( screen, (Sint16)pointsdisplay->posx - 5, (Sint16)pointsdisplay->posy, pointsdisplay->rect.w + 10, pointsdisplay->rect.h, 0, 0, 0, 64, 1 );
		pointsdisplay->Update();
	}
}

void cOverWorld :: DrawDebug( void )
{
	if( Overworld_debug )
	{
		SDL_Rect rl;
	
		rl.x = 0;
		rl.y = 0;
		
		rl.x = 15;
		rl.y = pPreferences->Screen_H - Debugimage->h - 30;
		rl.w = Debugimage->w;
		rl.h = Debugimage->h;
		
		if( Debugimage_shadow )
		{
			SDL_BlitSurface( Debugimage_shadow, NULL, screen, &rl );
		}

		rl.x -= 2;
		rl.y -= 2;

		if( Debugimage )
		{
			SDL_BlitSurface( Debugimage, NULL, screen, &rl );
		}

		// ## Free the Waypoint images
		if( DebugWaypoint )
		{
			SDL_FreeSurface( DebugWaypoint );
			DebugWaypoint = NULL;
		}

		if( DebugWaypoint_shadow )
		{
			SDL_FreeSurface( DebugWaypoint_shadow );
			DebugWaypoint_shadow = NULL;
		}
		// ## Free the Nlevel images
		if( DebugNlevel )
		{
			SDL_FreeSurface( DebugNlevel );
			DebugNlevel = NULL;
		}

		if( DebugNlevel_shadow )
		{
			SDL_FreeSurface( DebugNlevel_shadow );
			DebugNlevel_shadow = NULL;
		}

		// The Waypoint Text
		char dtext[100];
		sprintf( dtext, "Waypoint : %d", Current_Waypoint );

		DebugWaypoint = TTF_RenderText_Blended( font, dtext, colorGreen );
		DebugWaypoint_shadow = TTF_RenderText_Blended( font, dtext, colorBlack );

		rl.x = rl.w + 40;
		rl.y = pPreferences->Screen_H - DebugWaypoint->h - 30;
		rl.w = DebugWaypoint->w;
		rl.h = DebugWaypoint->h;
		
		SDL_BlitSurface( DebugWaypoint_shadow, NULL, screen, &rl );
		
		rl.x -= 2;
		rl.y -= 2;
		
		SDL_BlitSurface( DebugWaypoint, NULL, screen, &rl );
		
		// The Nlevel Text
		sprintf( dtext, "N-Level : %d", Nlevel );

		DebugNlevel = TTF_RenderText_Blended( font, dtext, colorBlue );
		DebugNlevel_shadow = TTF_RenderText_Blended( font, dtext, colorBlack );

		rl.x += rl.w + 40;
		rl.w = DebugNlevel->w;
		rl.h = DebugNlevel->h;

		SDL_BlitSurface( DebugNlevel_shadow, NULL, screen, &rl );
		
		rl.x -= 2;
		rl.y -= 2;
		
		SDL_BlitSurface( DebugNlevel, NULL, screen, &rl );

		if( showlayer )
		{
			rl.x = Layer->x - cameraposx;
			rl.y = Layer->y - cameraposy;
			rl.w = Layer->image->w;
			rl.h = Layer->image->h;
			
			SDL_BlitSurface( Layer->image, NULL, screen, &rl );
		}
	}
}

void cOverWorld :: WaypointWalk( void )
{
	int reached = 0;

	if( (Waypoints[Current_Waypoint]->rect.x + 11) > (int)Mario->posx + (int)Mario->rect.w/2 )
	{
		Mario->posx += 3.0;
	}
	else if( (Waypoints[Current_Waypoint]->rect.x + 16) < (int)Mario->posx + (int)Mario->rect.w/2 )
	{
		Mario->posx -= 3.0;
	}
	else
	{
		reached++;
	}

	if( (Waypoints[Current_Waypoint]->rect.y + 5) > (int)Mario->posy + (int)Mario->rect.h * 0.9 )
	{
		Mario->posy += 3.0;
	}
	else if( ( Waypoints[Current_Waypoint]->rect.y + 10 ) < (int)Mario->posy + (int)Mario->rect.h * 0.9 )
	{
		Mario->posy -= 3.0;
	}
	else
	{
		reached++;
	}

	if( reached == 2 )
	{
		// printf("Reached !\n");
		Mario_fixed_walking = 0;
		Mario->direction = DOWN;
		LoadMarioImages();
		Mario->direction = -1;
	}
}


void cOverWorld :: MarioWalk( int px, int py, int xspeed, int yspeed )
{
	if( SDL_GetPixel( Layer->image, (int)(px + xspeed*2.5), (int)(py + yspeed*2.5) ) == magenta )
	{
		Current_Waypoint = -1;

		if( Mario->direction == RIGHT )
		{
			int  i = 0;

			Mario->direction = LEFT;

			for( i = 0;i < 8;i++ )
			{
				if( SDL_GetPixel( Layer->image, (int)(px + xspeed*1.5), (int)(py + i) ) == magenta )
				{
					Mario->direction = UP;
					break;
				}

				if( SDL_GetPixel( Layer->image, (int)(px + xspeed*1.5), (int)(py - i) ) == magenta )
				{
					Mario->direction = DOWN;
					break;
				}
			}	
		}
		else if( Mario->direction == LEFT )
		{
			int  i = 0;

			Mario->direction = RIGHT;

			for( i = 0;i < 8;i++ )
			{
				if( SDL_GetPixel( Layer->image, (int)(px + xspeed*1.5), (int)(py + i) ) == magenta )
				{
					Mario->direction = UP;
					break;
				}

				if( SDL_GetPixel( Layer->image, (int)(px + xspeed*1.5), (int)(py - i) ) == magenta )
				{
					Mario->direction = DOWN;
					break;
				}
			}
		}
		else if( Mario->direction == UP )
		{
			int  i = 0;

			Mario->direction = DOWN;

			for( i = 0;i < 8;i++ )
			{
				if( SDL_GetPixel( Layer->image, (int)(px + i), (int)(py + yspeed*1.5) ) == magenta )
				{
					Mario->direction = LEFT;
					break;
				}

				if( SDL_GetPixel( Layer->image, (int)(px - i), (int)(py + yspeed*1.5) ) == magenta )
				{
					Mario->direction = RIGHT;
					break;
				}
			}
		}
		else if( Mario->direction == DOWN )
		{
			int  i = 0;

			Mario->direction = UP;

			for( i = 0;i < 8;i++ )
			{
				if( SDL_GetPixel( Layer->image, (int)(px + i), (int)(py + yspeed*1.5) ) == magenta )
				{
					Mario->direction = LEFT;
					break;
				}

				if( SDL_GetPixel( Layer->image, (int)(px - i), (int)(py + yspeed*1.5) ) == magenta )
				{
					Mario->direction = RIGHT;
					break;
				}
			}
		}
		
		LoadMarioImages();
	}

	/*

	SDL_Rect rt;

	rt.x = px - cameraposx;
	rt.y = py - cameraposy;

	rt.w = 3;
	rt.h = 3;

	SDL_FillRect(screen,&rt,grey);

	*/

	Mario->posx += xspeed;
	Mario->posy += yspeed;

	for( int i = 0;i < Waypointcount;i++ )
	{
		if( i == Current_Waypoint )
		{
			continue;
		}

		if( RectIntersect( &Waypoints[i]->rect, &Mario->rect ) )
		{
			Mario_fixed_walking = 1;
			//Mario->direction = -1;
			Current_Waypoint = i;
		}
	}
}
