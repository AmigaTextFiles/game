/***************************************************************************
    level.cpp  -  class for handling level loading and many other things
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

#include <stdio.h> // Date & Time
#include <stdlib.h>


cBackground :: cBackground( void )
{
	type = 0;

	img_file_1.reserve( 120 );
	img_file_2.reserve( 120 );

	img_1 = NULL;
	img_2 = NULL;

	rect.x = 0;
	rect.y = 0;
	rect.w = 0;
	rect.h = 0;
}

cBackground :: ~cBackground( void )
{
	if( img_1 ) 
	{
		img_1 = NULL;
	}

	if( img_2 ) 
	{
		img_2 = NULL;
	}
}

void cBackground :: Set_type( Uint8 ntype )
{
	if( ntype == BG_LEFTRIGHT || ntype == BG_ALL || ntype == BG_DOUBLE ) 
	{
		type = ntype;
	}
}

void cBackground :: Set_images( string nimg_file_1, string nimg_file_2 /* = ""  */)
{
	img_file_1 = nimg_file_1;
	img_file_2 = nimg_file_2;

	if( img_file_1.length() > 3 ) 
	{
		img_1 = GetImage( img_file_1 );
	}


	if( nimg_file_2.length() > 3 ) 
	{
		img_2 = GetImage( img_file_2 );		
	}
}

void cBackground :: Draw( SDL_Surface *target )
{
	if( pPreferences->Backgroundimages_disabled )
	{
		return;
	}

	if( type == BG_LEFTRIGHT && img_1 ) 
	{
		int xpos = -(cameraposx/5);

		while( xpos < -img_1->w )
		{
			xpos += img_1->w;
			
		}
		
		while( xpos < screen->w )
		{
			rect.x = xpos;
			rect.y = -(cameraposy/3);

			SDL_BlitSurface( img_1, NULL, target, &rect );

			xpos += img_1->w;
		}

	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cLevel :: cLevel( void )
{
	Mod_Camera_up = 0;
	Mod_Camera_left = 0;
	Mod_Camera_right = 0;

	Levelengine_version = -1; // no version

	Musicfile = "";
	Levelfile = "";

	Musicfile.reserve( 120 );
	Levelfile.reserve( 120 );
	
	background_color = 0;

	Background = new cBackground();
}

cLevel :: ~cLevel( void )
{
	Unload();

	if( Background ) 
	{
		delete Background;
		Background = NULL;
	}
}

int cLevel :: New( string filename ) // V.1.1
{
	Unload();
	
	if( filename.compare( "null" ) == 0 )
	{
		unsigned int i = 1;

		filename = LEVEL_DIR "/new_1.txt";
		
		FILE *fp = fopen( filename.c_str(), "r" );
		
		while( fp ) 
		{
			char ic[2];

			i++;

			sprintf( ic, "%d", i );
			
			filename.replace( filename.length() - 5, 1, ic );

			fclose( fp );
			
			fp = fopen( filename.c_str(), "r" );

			if( i > 99 ) 
			{
				break;
			}
		}
	}

	ifstream ifs;
	ifs.open( filename.c_str(), ios :: out );

	if( ifs )	// Level already exists
	{
		printf( "NewLevel Error : Level already exists %s\n", filename.c_str() );
		return 0; 
	} 
	else // Level does not exists - Succesfull
	{
		ifs.close();
		printf( "Succesfully created a New Level (%s)\n", filename.c_str() );
		Levelfile = filename;
		Save();
		return 1; 
	}

	return 0;
}

bool cLevel :: Load( string szFilename ) // V.1.9
{
	// Loads the Level 

	if( szFilename.length() < 3 )
	{
		return 0;
	}

	ifstream ifs( szFilename.c_str(), ios :: in );
	
	if( !ifs )
	{
		printf( "Could not load Level : %s\n", szFilename.c_str() );
		return 0;
	}
	
	if( MassiveCount > 0 || PassiveCount > 0 || ActiveCount > 0 || EnemyCount > 0 )
	{
		Unload();
	}
	
	Musicfile = MUSIC_DIR "/Land/land_1.ogg";
	
	background_color = std_bgcolor;
	
	Background->Set_type( BG_LEFTRIGHT );
	Background->Set_images( "game/background/blue_hills_1.png" );

	char contents[500]; // maximal length of an line
	
	Levelfile = szFilename;
	
	for( unsigned int i = 0; ifs.getline( contents, sizeof( contents ) ); i++ )
	{
		Parse_Map( contents, i );
	}


	ifs.close();
	
	if( Levelengine_version < 0 ) // no Levelengine_version entry found
	{
		Levelengine_version = 0;
	}

	// Player info bar
	LoadHudObjects();

	Framerate.Reset();

	pAudio->FadeOutMusic( 1000 );
	pAudio->PlayMusic( Musicfile, -1, 0, 1000 );

	return 1;
}

void cLevel :: Save( void ) // V 2.3
{
	pAudio->PlaySound( SOUNDS_DIR "/level_saved.ogg" ); // todo : do not play the sound here

	ofstream ofs( Levelfile.c_str(), ios::out | ios::trunc );

	string tempname; // Temporary image path
	tempname.reserve( 120 );

	int i;
	char row[300];

	sprintf( row, "### Level Saved with Super Mario Clone FX V.%s ###\n", VERSION );
	ofs.write( row, strlen( row ) );

	sprintf( row, "### Level Saved on the %s\n", Get_Curr_Time() ); //Get_Curr_Time() has a \n in the string
	ofs.write( row, strlen( row ) );
	
	sprintf( row, "Levelengine_version %d\n\n", 1 ); // The Current Levelengine version
	ofs.write( row, strlen( row ) );
	
	string fMusicfile = Musicfile;
	fMusicfile.erase( 0, strlen( MUSIC_DIR ) + 1 );
	
	sprintf( row, "Music %s\n", fMusicfile.c_str() );
	ofs.write( row, strlen( row ) );

	sprintf( row, "Mod_Camera %d %d %d\n", Mod_Camera_up, Mod_Camera_left, Mod_Camera_right );
	ofs.write( row, strlen( row ) );

	Uint8 Back_red;
	Uint8 Back_green;
	Uint8 Back_blue;

	SDL_GetRGB( background_color, screen->format, &Back_red, &Back_green, &Back_blue );

	sprintf( row, "Background_Color %d %d %d\n\n", Back_red, Back_green, Back_blue );
	ofs.write(row, strlen( row ) );

	sprintf( row, "Player %d %d\n\n", (int) pPlayer->startposx, pPreferences->Screen_H - (int)pPlayer->startposy );
	ofs.write( row, strlen( row ) );

	sprintf( row, "### Massive Objects ###\n" );
	ofs.write( row, strlen( row ) );

	for( i = 0;i < MassiveCount;i++ )
	{
		if( !MassiveObjects[i] )
		{
			continue;
		}

		tempname = ImageFactory->GetPath( MassiveObjects[i]->StartImage );

		if( tempname.find( PIXMAPS_DIR ) == 0 )
		{
			tempname.erase( 0, strlen( PIXMAPS_DIR ) + 1 );
		}

		sprintf( row, "Sprite %s %d %d MASSIVE\n", tempname.c_str(), (int) MassiveObjects[i]->startposx, pPreferences->Screen_H - (int) MassiveObjects[i]->startposy );
		ofs.write( row, strlen( row ) );
	}
	
	sprintf( row, "\n### Passive Objects ###\n" );
	ofs.write( row, strlen( row ) );

	for( i = 0;i < PassiveCount;i++ )
	{
		if ( !PassiveObjects[i] )
		{
			continue;
		}

		tempname = ImageFactory->GetPathC( PassiveObjects[i]->StartImage );

		if( tempname.find( PIXMAPS_DIR ) == 0 )
		{
			tempname.erase( 0, strlen( PIXMAPS_DIR ) + 1 );
		}

		sprintf( row, "Sprite %s %d %d PASSIVE\n", tempname.c_str(), (int) PassiveObjects[i]->startposx, pPreferences->Screen_H - (int) PassiveObjects[i]->startposy );
		ofs.write( row, strlen( row ) );
	}
	
	sprintf( row, "\n### Enemy Objects ###\n" );
	ofs.write( row, strlen( row ) );

	for( i = 0;i < EnemyCount;i++ )
	{
		if( !EnemyObjects[i] )
		{
			continue;
		}
		
		switch (EnemyObjects[i]->type)
		{
		case TYPE_GOOMBA_BROWN:
		{
			sprintf( row, "Enemy %s %d %d 0\n", "GOOMBA", (int)EnemyObjects[i]->startposx, pPreferences->Screen_H - (int)EnemyObjects[i]->startposy );
			break;
		}
		case TYPE_GOOMBA_RED:
		{
			sprintf( row, "Enemy %s %d %d 1\n", "GOOMBA", (int)EnemyObjects[i]->startposx, pPreferences->Screen_H - (int)EnemyObjects[i]->startposy );
			break;
		}
		case TYPE_TURTLE_RED:
		{
			sprintf( row, "Enemy %s %d %d\n", "RTURTLE", (int)EnemyObjects[i]->startposx, pPreferences->Screen_H - (int)EnemyObjects[i]->startposy );
			break;
		}
		case TYPE_JPIRANHA:
		{
			sprintf( row, "Enemy %s %d %d\n", "JPIRANHA", (int)EnemyObjects[i]->startposx, pPreferences->Screen_H - (int)EnemyObjects[i]->startposy );
			break;
		}
		case TYPE_BANZAI_BILL:
		{
			sprintf( row, "Enemy %s %d %d %d\n", "BANZAI_BILL", (int)EnemyObjects[i]->startposx, pPreferences->Screen_H - (int)EnemyObjects[i]->startposy, EnemyObjects[i]->direction );
			break;
		}
		case TYPE_REX:
		{
			sprintf( row, "Enemy %s %d %d\n", "REX", (int)EnemyObjects[i]->startposx, pPreferences->Screen_H - (int)EnemyObjects[i]->startposy );
			break;
		}
		default:
		{
			continue;
		}
		}

		ofs.write( row, strlen(row) );
	}
	
	sprintf( row, "\n### Active Objects ###\n" );
	ofs.write( row, strlen( row ) );

	for( i = 0;i < ActiveCount;i++ )
	{
		if( !ActiveObjects[i] )
		{
			continue;
		}

		switch(ActiveObjects[i]->type)
		{
		case TYPE_GOLDPIECE:
		{
			if (!ActiveObjects[i]->spawned )
			{
				sprintf( row, "Goldpiece %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			}
			break;
		}
		case TYPE_MOON:
		{
			if (!ActiveObjects[i]->spawned )
			{
				sprintf( row, "Moon %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			}
			break;
		}
		case TYPE_HALFMASSIVE:
		{
			tempname = ImageFactory->GetPathC( ActiveObjects[i]->StartImage );
			
			if( tempname.find( PIXMAPS_DIR ) == 0 )
			{
				tempname.erase( 0, strlen( PIXMAPS_DIR ) + 1 );
			}

			sprintf( row, "Sprite %s %d %d HALFMASSIVE\n", tempname.c_str(), (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		}
		case TYPE_CLOUD:
		{
			sprintf( row, "Cloud %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		}
		case TYPE_LEVELEXIT:
		{
			sprintf( row, "Levelexit %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		}
		case TYPE_ENEMYSTOPPER:
		{
			sprintf( row, "EnemyStopper %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		}
		case TYPE_BONUSBOX_MUSHROOM_FIRE:
		{
			sprintf( row, "BonusBox %d %d AUTO\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		} 
		case TYPE_BONUSBOX_LIVE:
		{
			sprintf( row, "BonusBox %d %d LIFE\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		} 
		case TYPE_SPINBOX:
		{
			sprintf( row, "SpinBox %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		}
		case TYPE_GOLDBOX:
		{
			sprintf( row, "GoldBox %d %d\n", (int) ActiveObjects[i]->startposx, pPreferences->Screen_H - (int) ActiveObjects[i]->startposy );
			break;
		} 
		default:
		{
			sprintf( row, "%c", '\0' );
			break;
		}
		}
		
		ofs.write( row, strlen( row ) );
	}

	ofs.close();

	printf( "Level %s saved\n", Get_Levelfile( 0, 0 ).c_str() );

	sprintf( debugdisplay->text, "Level %s saved", Get_Levelfile( 0, 0 ).c_str() );
	debugdisplay->counter = DESIRED_FPS*2.5;
}

void cLevel :: Show_Error( string errortext ) // V 1.5
{
	SDL_Surface* image = TTF_RenderText_Shaded( font, errortext.c_str(), colorBlack, colorWhite );
	cSprite* temp = new cSprite( image, screen->w/2 - image->w/2, screen->h/2 - image->h/2 );

	temp->Draw( screen );
	SDL_Flip( screen );
	SDL_Delay( 4000 ); // todo with pollevent for ESC and a counter
	delete temp;
	SDL_FreeSurface( image );
	exit( 1 );
}

void cLevel :: Draw( bool update /* = 1  */ )
{
	if( Leveleditor_Mode )
	{
		update = 0;
		pMouseCursor->Update_Position();
	}
	
	Background->Draw( screen );
	
	int i;

	for( i = 0;i < ActiveCount;i++ )
	{
		if ( !ActiveObjects[i] )
		{
			continue;
		}


		// If Object is out of range ( 2000 for Clouds )
		if( !Leveleditor_Mode && ( ActiveObjects[i]->posx < pPlayer->posx - 2000 || ActiveObjects[i]->posy < pPlayer->posy - 2000 ||
			ActiveObjects[i]->posx > pPlayer->posx + 2000 || ActiveObjects[i]->posy > pPlayer->posy + 2000 ) )
		{
			continue;
		}

		if( update ) // Update
		{
			if( ActiveObjects[i]->type != TYPE_MUSHROOM_DEFAULT && ActiveObjects[i]->type != TYPE_MUSHROOM_LIVE_1 && ActiveObjects[i]->type != TYPE_FIREPLANT &&
				ActiveObjects[i]->type != TYPE_HALFMASSIVE && ActiveObjects[i]->type != TYPE_GOLDBOX &&
				ActiveObjects[i]->type != TYPE_SPINBOX && ActiveObjects[i]->type != TYPE_BONUSBOX_LIVE && 
				ActiveObjects[i]->type != TYPE_BONUSBOX_MUSHROOM_FIRE )
			{
				ActiveObjects[i]->Update();
			}
		}
		else // No Update
		{
			if( ActiveObjects[i]->visible || Leveleditor_Mode )
			{
				if( ActiveObjects[i]->type != TYPE_HALFMASSIVE && ActiveObjects[i]->type != TYPE_GOLDPIECE && ActiveObjects[i]->type != TYPE_MOON && 
					ActiveObjects[i]->type != TYPE_SPINBOX && ActiveObjects[i]->type != TYPE_GOLDBOX && 
					ActiveObjects[i]->type != TYPE_BONUSBOX_MUSHROOM_FIRE && ActiveObjects[i]->type != TYPE_BONUSBOX_LIVE &&
					ActiveObjects[i]->type != TYPE_MUSHROOM_DEFAULT && ActiveObjects[i]->type != TYPE_MUSHROOM_LIVE_1 && 
					ActiveObjects[i]->type != TYPE_FIREPLANT && ActiveObjects[i]->type != TYPE_ENEMYSTOPPER )
				{
					ActiveObjects[i]->Draw( screen );
				}
			}
		}
	}

	for( i = 0;i < PassiveCount;i++ )
	{
		if ( !PassiveObjects[i] )
		{
			continue;
		}

		// automtically checks if it's out of range
		PassiveObjects[i]->Draw( screen );
	}
	
	for( i = 0;i < EnemyCount;i++ )
	{
        if( !EnemyObjects[i] )
		{
			continue;
		}

		if( update ) // Update
		{
			if( EnemyObjects[i]->type == TYPE_BANZAI_BILL )
			{
				EnemyObjects[i]->Update();
			}
			
		}
		else // No Update
		{
			if( 0 ) // Currently nothing
			{
				EnemyObjects[i]->Draw( screen );
			}
		}
	}
	
	// only halfmassive
	for( i = 0;i < ActiveCount;i++ )
	{
		if( !ActiveObjects[i] )
		{
			continue;
		}
		
		if( update ) // Update
		{
			if( ActiveObjects[i]->type == TYPE_HALFMASSIVE ) // only halfmassive
			{
				ActiveObjects[i]->Update();
			}
		}
		else // No Update
		{
			if( ActiveObjects[i]->visible || Leveleditor_Mode )
			{
				if( ActiveObjects[i]->type == TYPE_HALFMASSIVE ) // only halfmassive
				{
					ActiveObjects[i]->Draw( screen );
				}
			}
		}
	}

	// all the other Active Objects
	for( i = 0;i < ActiveCount;i++ )
	{
		if( !ActiveObjects[i] )
		{
			continue;
		}

		// If Object is out of range ( 2000 for Mushrooms )
		if( !Leveleditor_Mode && ( ActiveObjects[i]->posx < pPlayer->posx - 2000 || ActiveObjects[i]->posy < pPlayer->posy - 2000 ||
			ActiveObjects[i]->posx > pPlayer->posx + 2000 || ActiveObjects[i]->posy > pPlayer->posy + 2000 ) )
		{
			continue;
		}
		
		if( update ) // Update
		{
			if( ActiveObjects[i]->type == TYPE_MUSHROOM_DEFAULT || ActiveObjects[i]->type == TYPE_MUSHROOM_LIVE_1 || 
				ActiveObjects[i]->type == TYPE_FIREPLANT || ActiveObjects[i]->type == TYPE_GOLDBOX ||
				ActiveObjects[i]->type == TYPE_SPINBOX || ActiveObjects[i]->type == TYPE_BONUSBOX_LIVE || 
				ActiveObjects[i]->type == TYPE_BONUSBOX_MUSHROOM_FIRE )
			{
				ActiveObjects[i]->Update();
			}
		}
		else // No Update
		{
			if( ActiveObjects[i]->visible || Leveleditor_Mode )
			{
				if( ActiveObjects[i]->type == TYPE_GOLDPIECE || ActiveObjects[i]->type == TYPE_MOON ||
					ActiveObjects[i]->type == TYPE_SPINBOX || ActiveObjects[i]->type == TYPE_GOLDBOX ||
					ActiveObjects[i]->type == TYPE_BONUSBOX_MUSHROOM_FIRE || ActiveObjects[i]->type == TYPE_BONUSBOX_LIVE
					|| ( !pPlayer->iSize && ( ActiveObjects[i]->type == TYPE_MUSHROOM_DEFAULT || ActiveObjects[i]->type == TYPE_BONUSBOX_MUSHROOM_FIRE || ActiveObjects[i]->type == TYPE_MUSHROOM_LIVE_1 ) )
					)
				{
					ActiveObjects[i]->Draw( screen );
				}
			}
		}
	}

	for( i = 0;i < EnemyCount;i++ )
	{
        if( !EnemyObjects[i] )
		{
			continue;
		}

		if( update ) // Update
		{
			if( EnemyObjects[i]->type == TYPE_JPIRANHA )
			{
				EnemyObjects[i]->Update();
			}
		}
		else // No Update
		{
			if( EnemyObjects[i]->type != TYPE_JPIRANHA && EnemyObjects[i]->type != TYPE_BANZAI_BILL )
			{
				EnemyObjects[i]->Draw( screen );
			}
			else if( !pPlayer->iSize && ( EnemyObjects[i]->type == TYPE_BANZAI_BILL || EnemyObjects[i]->type == TYPE_JPIRANHA ) )
			{
				EnemyObjects[i]->Draw( screen );
			}
		}
	}

	UpdateAnimatons();
	
	for( i = 0;i < MassiveCount;i++ )
	{
		if( !MassiveObjects[i] )
		{
			continue;
		}

		MassiveObjects[i]->Draw( screen );
	}

	for( i = 0;i < EnemyCount;i++ )
	{
        if ( !EnemyObjects[i] )
		{
			continue;
		}

		if( update ) // Update
		{
			if( EnemyObjects[i]->type != TYPE_JPIRANHA && EnemyObjects[i]->type != TYPE_BANZAI_BILL )
			{
				EnemyObjects[i]->Update();
			}
		}
		else // No Update
		{
			if( ( EnemyObjects[i]->type == TYPE_JPIRANHA || EnemyObjects[i]->type == TYPE_BANZAI_BILL ) && pPlayer->iSize != MARIO_DEAD )
			{
				EnemyObjects[i]->Draw( screen );
			}
		}
	}

	for( i = 0;i < ActiveCount;i++ )
	{
		if( !ActiveObjects[i] )
		{
			continue;
		}

		if( update ) // Update
		{
			if( 0 ) // Currently nothing
			{
				ActiveObjects[i]->Update();
			}
		}
		else // No Update
		{
			if( ActiveObjects[i]->visible || Leveleditor_Mode )
			{
				if( ActiveObjects[i]->type == TYPE_ENEMYSTOPPER	) // changed
				{
					ActiveObjects[i]->Draw( screen );
				}
			}
		}

	}

	for( i = 0;i < HUDCount;i++ )
	{
		if( !HUDObjects[i] )
		{
			continue;
		}

		HUDObjects[i]->Update();
	}

	if( !Leveleditor_Mode )
	{
		return;
	}
	
	// #### The below is only for the EditMode

	pMouseCursor->Editor_Update();
}

void cLevel :: Unload( void ) // V.2.3
{
	int i = 0;
	
	if( MassiveObjects )
	{
		for( i = 0;i < MassiveCount;i++ ) 
		{
			if( MassiveObjects[i] )
			{
				delete MassiveObjects[i];
				MassiveObjects[i] = NULL;
			}
		}

		delete []MassiveObjects;	
		MassiveObjects = NULL;	
	}
	MassiveCount = 0;

	if( PassiveObjects ) 
	{
		for( i = 0;i < PassiveCount;i++ ) 
		{
			if( PassiveObjects[i] ) 
			{
				delete PassiveObjects[i];
				PassiveObjects[i] = NULL; 
			} 
		}
		
		delete []PassiveObjects;
		PassiveObjects = NULL;
	}
	PassiveCount = 0;

	if( ActiveObjects ) 
	{
		for( i = 0;i < ActiveCount;i++ ) 
		{
			if( ActiveObjects[i] ) 
			{
				delete ActiveObjects[i];
				ActiveObjects[i] = NULL; 
			}
		} 

		delete []ActiveObjects;
		ActiveObjects = NULL;	
	}
	ActiveCount = 0;

	if( EnemyObjects )
	{
		for( i = 0;i < EnemyCount;i++ ) 
		{
			if( EnemyObjects[i] ) 
			{
				delete EnemyObjects[i];
				EnemyObjects[i] = NULL; 
			} 
		}

		delete []EnemyObjects;
		EnemyObjects = NULL;	
	}
	EnemyCount = 0;

	DeleteAllDialogObjects();
	DeleteAllAnimations();

	UpdateHudObjects();

	pJoystick->Reset_keys();

	if( timedisplay )
	{
		timedisplay->counter = -1;
	}

	if( pMouseCursor ) 
	{
		pMouseCursor->CopyObject = NULL;
		pMouseCursor->iCollisionType = 0;
		pMouseCursor->MouseObject = NULL;
	}

	Mod_Camera_up = 0;
	Mod_Camera_left = 0;
	Mod_Camera_right = 0;

	Levelengine_version = -1; // no version

	Musicfile = ""; // Standard Music

	Levelfile = "";

	background_color = 0;
}

void cLevel :: Parse_Map( string command, int line ) // V 3.0
{
	if( command.length() <= 5 || command.find_first_of( '#' ) == 0 )
	{
		return;
	}


	while( command.find( '\r' ) != string::npos ) // Linux support
	{
		command.erase( command.find( '\r' ), 1 );
	}

	while( command.find( '\t' ) != string::npos ) // No Tabs
	{
		command.replace( command.find( '\t' ), 1, " " );
	}

	while( command.find_last_of( ' ' ) == command.length() - 1  ) // No Spaces at the end
	{
		command.erase( command.find_last_of( ' ' ), 1 );
	}

	while( command.find_first_of( ' ' ) == 0  ) // No Spaces at the start
	{
		command.erase( command.find_first_of( ' ' ), 1 );
	}

	string tempstr = command;
	int count = 1;

	while( tempstr.find( ' ' ) != string::npos  ) // Count Spaces
	{
		tempstr.erase( tempstr.find( ' ' ) , 1 );
		count++;
	}

	tempstr = command;
	
	string *parts = new string[ count + 1];
	
	int len;
	int i = 0;

	while( count > 0 )
	{
		len = tempstr.find_first_of( ' ' );
		parts[i] = tempstr.substr( 0, len );
		tempstr.erase( 0, len + 1 );
		i++;
		count--;
	}

	parts[i] = tempstr;
	
	// Message handler
	HandleMessage( parts, i, line );

	delete []parts;
}


void cLevel :: Set_BackgroundColor( Uint8 red, Uint8 green, Uint8 blue )
{
	background_color = SDL_MapRGB( screen->format, red, green, blue );
}

void cLevel :: Set_Musicfile( string filename )
{
	if( filename.length() > 4 ) 
	{
		if( filename.find( MUSIC_DIR ) == string::npos ) 
		{
			filename.insert( 0, "/" );
			filename.insert( 0, MUSIC_DIR );
		}

		Musicfile = filename;
	}
}

void cLevel :: Set_Levelfile( string filename )
{
	Delete_file( Levelfile ); // does not work

	Levelfile = filename;

	if( Levelfile.find( LEVEL_DIR ) == string::npos ) 
	{
		Levelfile.insert( 0, "/" );
		Levelfile.insert( 0, LEVEL_DIR );
	}

	Save();
}

string cLevel :: Get_Levelfile( bool with_dir /* = 1 */, bool with_end /* = 1  */)
{
	string name = Levelfile;

	if( !with_dir && name.find( LEVEL_DIR ) != string::npos ) 
	{
		name.erase( name.find( LEVEL_DIR ), strlen( LEVEL_DIR ) + 1 );
	}

	if( !with_end && name.find( ".txt" ) != string::npos ) 
	{
		name.erase( name.find( ".txt"), 4 );
	}

	return name;
}
int cLevel :: Load_Savegame( unsigned int Save_file )
{
	Savegame LSavegame = Savegame_Load( Save_file );

	if( LSavegame.Lives < 0 )
	{
		printf( "Error Loading Savegame\n" );
		return 0;
	}

	char Full_Level_name[60];
	sprintf( Full_Level_name, "%s/%s", LEVEL_DIR, LSavegame.Levelname );
	
	Unload();

	pOverWorld->LoadOverWorld( LSavegame.OverWorld );

	if( !LSavegame.OWsave )
	{
		Load( Full_Level_name );
	}	
	
	if( LSavegame.Version >= 4 )
	{
		pOverWorld->Nlevel = LSavegame.OWNlevel;
		pOverWorld->Slevel = LSavegame.OWSlevel;
		pOverWorld->Current_Waypoint = LSavegame.OWCurr_WP;
	}
	else // old savegame support (below Version 4)
	{
		for( int i = 0;i < pOverWorld->Waypointcount;i++ )
		{
			if( pOverWorld->Waypoints[i]->levelname.compare( Full_Level_name ) == 0 )
			{
				pOverWorld->Current_Waypoint = i;
				break;
			}
		}

		if( pOverWorld->Current_Waypoint >= 0 )
		{
			pOverWorld->Nlevel = pOverWorld->Current_Waypoint;
		}
		else
		{
			pOverWorld->Nlevel = 0;
		}

		pOverWorld->Slevel = 0;
	}
	
	pOverWorld->Mario->SetPos( pOverWorld->Waypoints[pOverWorld->Current_Waypoint]->rect.x - 15,pOverWorld->Waypoints[pOverWorld->Current_Waypoint]->rect.y - 35 );
	
	pPlayer->Reset();
	pPlayer->lives = 0;
	pPlayer->iSize = LSavegame.State;
	pPlayer->LoadImages();
	pPlayer->SetPos( (double)LSavegame.Pos_x, (double)( LSavegame.Pos_y - pPreferences->Screen_H ) );
	pointsdisplay->AddPoints( LSavegame.Points );
	golddisplay->AddGold( LSavegame.Goldpieces );
	livedisplay->AddLives( LSavegame.Lives );

	if( LSavegame.Version >= 5 )
	{
		Itembox->Get_Item( LSavegame.Itembox_item );	
	}

	if( !LSavegame.OWsave )
	{
		pPlayer->invincible = DESIRED_FPS;
	}

	pPlayer->Unload_Fireballs();

	sprintf( debugdisplay->text, "Savegame %d loaded", Save_file );
	debugdisplay->counter = DESIRED_FPS*1.5;

	debugdisplay->Update ();
	pointsdisplay->Update();
	pPlayer->Update();
	golddisplay->Update();

	if( LSavegame.OWsave )
	{
		return 2;
	}
	
	return 1;
}

bool cLevel :: Save_Savegame( unsigned int Save_file, string Description )
{
	if( !pOverWorld || !pPlayer || !debugdisplay || pOverWorld->Current_Waypoint < 0 )
	{
		return 0;
	}

	Savegame SSavegame;

	// Description
	SSavegame.Description = Description; 
	// Goldpieces
	SSavegame.Goldpieces = pPlayer->goldpieces;
	// Level
	string Level_name;
	if( MassiveCount || ActiveCount ) // Player is in a Level
	{
		Level_name = pLevel->Levelfile;
		
		Level_name.erase( 0, strlen( LEVEL_DIR ) + 1 );
	}
	else
	{
		Level_name = pOverWorld->Waypoints[pOverWorld->Current_Waypoint]->levelname;
	}

	sprintf( SSavegame.Levelname, Level_name.c_str() );
	// Lifes
	SSavegame.Lives = pPlayer->lives;
	// Points
	SSavegame.Points = pPlayer->points;
	// Position
	SSavegame.Pos_x = (int)(pPlayer->posx);
	SSavegame.Pos_y = (int)pPlayer->posy + pPreferences->Screen_H - 5;
	// State
	SSavegame.State = pPlayer->iSize;
	// Itembox Item
	SSavegame.Itembox_item = Itembox->Item_id;
	// OverWorld save
	if( MassiveCount || ActiveCount )
	{
		SSavegame.OWsave = 0;
	}
	else
	{
		SSavegame.OWsave = 1;
	}

	// OverWorld normal Levels accessed
	SSavegame.OWNlevel = pOverWorld->Nlevel;
	// OverWorld secret Levels accessed
	SSavegame.OWSlevel = pOverWorld->Slevel;
	// Current Waypoint
	SSavegame.OWCurr_WP = pOverWorld->Current_Waypoint;
	// which OverWorld
	SSavegame.OverWorld = pOverWorld->Current_OverWorld;
	// Time
	sprintf( SSavegame.Time_Stamp, Get_Curr_Time() );
	// Version
	SSavegame.Version = 5;
	// Save it
	Savegame_Save( Save_file, SSavegame );

	// Print
	sprintf( debugdisplay->text, "Saved to Slot %d", Save_file );
	debugdisplay->counter = DESIRED_FPS*1.5;

	return 1;
}


int cLevel :: HandleMessage( string *parts, unsigned int count, unsigned int line )
{
	if( parts[0].compare( "Sprite" ) == 0 )
	{
		if( count != 5 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Sprite needs 5 parameters\n" );
			return 0; // error
		}
		
		// check if file exists
		string filename = parts[1];

		while( filename.find( "/" ) == 0 )
		{
			filename.erase( 0, 1 );
		}
		
		if( filename.find( PIXMAPS_DIR ) == string::npos )
		{
			filename.insert( 0, "/" );
			filename.insert( 0, PIXMAPS_DIR );	
		}

		ifstream ifs( filename.c_str(), ios::in );

		if( !ifs )
		{
			// try it with the old_pixmaps

			filename.insert( strlen( PIXMAPS_DIR ), "/old_pixmaps" );
			ifs.open( filename.c_str(), ios::in );
			
			if( !ifs ) // nowhere found = error
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "file not found : %s/%s\n", PIXMAPS_DIR, parts[1].c_str() );
				return 0; // error
			}
		}

		ifs.close();
		
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[3] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[3].c_str() );
			return 0; // error
		}
		if( !parts[4].compare( "MASSIVE" ) == 0 && !parts[4].compare( "PASSIVE" ) == 0 && !parts[4].compare( "HALFMASSIVE" ) == 0 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "parameter five has to be MASSIVE, PASSIVE, or HALFMASSIVE\n" );
			return 0; // error
		}

		string getimage_path = filename;
		getimage_path.erase( 0, strlen( PIXMAPS_DIR ) + 1 );

		if( parts[4].compare( "MASSIVE" ) == 0 )
		{
			SDL_Surface *sTemp = GetImage( getimage_path );
			cSprite *temp = new cSprite( sTemp, atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ) );
			AddMassiveObject( (cSprite*) temp );
		}
		else if( parts[4].compare( "PASSIVE" ) == 0 )
		{
			SDL_Surface *sTemp = GetImage( getimage_path );
			cSprite *temp = new cSprite( sTemp, atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ) );
			temp->massive = 0;
			temp->Array = ARRAY_PASSIVE;
			AddPassiveObject( (cSprite*)temp );
		}
		else if( parts[4].compare( "HALFMASSIVE" ) == 0 )
		{
			SDL_Surface *sTemp = GetImage( getimage_path );
			cSprite *temp = new cSprite( sTemp, atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ) );
			temp->halfmassive = 1;
			temp->massive = 0;
			temp->type = TYPE_HALFMASSIVE;
			temp->Array = ARRAY_ACTIVE;
			AddActiveObject( (cSprite*)temp );
		}
	} 
	
	/***************************************************************************/

	else if( parts[0].compare( "Enemy" ) == 0 )
	{
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[3] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[3].c_str() );
			return 0; // error
		}
		
		if( parts[1].compare( "GOOMBA" ) == 0 ) // Goomba
		{
			if( !(count == 3 || count == 4 || count == 5) )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "Enemy GOOMBA needs 3 or 4 parameters\n" );
				return 0; // error
			}

			if( count == 5 )
			{
				if( atoi( parts[4].c_str() ) == 1 ) // Red
				{
					cGoomba *temp = new cGoomba( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ), 1 );
					AddEnemyObject( (cSprite*)temp );
				}
				else if( atoi( parts[4].c_str() ) == 0 ) // Brown
				{
					cGoomba *temp = new cGoomba( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ), 0 );
					AddEnemyObject( (cSprite*)temp );
				}
				else
				{
					printf( "Goomba Color Error  color : %d",atoi( parts[4].c_str() ) );
					return 0; // error
				}
			}
			else // Support for older levels (lower than 0.8)
			{
				cGoomba *temp = new cGoomba( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ) );
				AddEnemyObject( (cSprite*)temp );
			}

		}
		else if( parts[1].compare( "RTURTLE" ) == 0 )
		{
			if( count != 4 )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( " Enemy RTURTLE needs 3 parameters\n" );
				return 0; // error
			}

			// 1 for red
			cTurtle *temp = new cTurtle( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ), 1 );
			AddEnemyObject ( (cSprite*) temp );
		}
		else if( parts[1].compare( "JPIRANHA" ) == 0 )
		{
			if( count != 4 )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( " Enemy JPIRANHA needs 3 parameters\n" );
				return 0; // error
			}

			cjPiranha *temp = new cjPiranha( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ) );
			AddEnemyObject ( (cSprite*) temp );
		}
		else if( parts[1].compare( "BANZAI_BILL" ) == 0 )
		{
			if( count != 5 )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "Enemy BANZAI_BILL needs 4 parameters\n" );
				return 0; // error
			}

			if( atoi( parts[4].c_str() ) != 1 && atoi( parts[4].c_str() ) != 0 )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "Enemy BANZAI_BILL parameter 4 is not 1 or 0\n" );
				return 0; // error
			}

			cbanzai_bill *temp = new cbanzai_bill( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ),atoi( parts[4].c_str() ) );
			AddEnemyObject( (cSprite*)temp );
		}
		else if( parts[1].compare( "REX" ) == 0 )
		{
			if( count != 4 )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "Enemy REX needs 3 parameters\n" );
				return 0; // error
			}

			cRex *temp = new cRex( atoi( parts[2].c_str() ), pPreferences->Screen_H - atoi( parts[3].c_str() ) );
			AddEnemyObject ( (cSprite*)temp );
		}
		else
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "parameter 2 has an unknown enemy type\n" );
			return 0; // error
		}
	}

	/***************************************************************************/

	else if( parts[0].compare( "Goldpiece" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Goldpiece needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cGoldPiece *temp = new cGoldPiece( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject( (cSprite*)temp );
	}

	/***************************************************************************/

	else if( parts[0].compare( "Moon" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Moon needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cMoon *temp = new cMoon( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject ( (cSprite*)temp );
	}
	/***************************************************************************/
	
	else if( parts[0].compare( "Levelexit" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Levelexit needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cLevelExit *temp = new cLevelExit( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject ( (cSprite*)temp );
	}

	/***************************************************************************/

	else if( parts[0].compare( "BonusBox" ) == 0 )
	{
		if( !( count == 3 || count == 4 ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "BonusBox needs 3 or 4 parameters\n" );
			return 0; // error
		}

		if( count == 3 ) // old Level Support
		{
			if( !is_valid_number( parts[1] ) )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "%s is not a valid integer value\n", parts[1].c_str() );
				return 0; // error
			}
			if( !is_valid_number( parts[2] ) )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "%s is not a valid integer value\n", parts[2].c_str() );
				return 0; // error
			}
			
			cBonusBox *temp = new cBonusBox( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
			AddActiveObject( (cSprite*)temp );

		}
		else if( count == 4 )
		{
			if( !is_valid_number( parts[1] ) )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "%s is not a valid integer value\n", parts[1].c_str() );
				return 0; // error
			}
			if ( !is_valid_number( parts[2] ) )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "%s is not a valid integer value\n", parts[2].c_str() );
				return 0; // error
			}

			if( parts[3].compare( "AUTO" ) == 0 ) // Auto Mushroom - Fire Box
			{
				cBonusBox *temp = new cBonusBox( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ),TYPE_BONUSBOX_MUSHROOM_FIRE);
				AddActiveObject ( (cSprite*) temp );
			}
			else if( parts[3].compare( "LIFE" ) == 0 ) // Auto Life Box
			{
				cBonusBox *temp = new cBonusBox( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ),TYPE_BONUSBOX_LIVE );
				AddActiveObject( (cSprite*) temp );
			}
			else // unknown Bonus item
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "Bonusbox type Error %s\n", parts[3].c_str() );
				return 0; // error
			}
		}
		else
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Bonusbox count Error %d\n", count );
			return 0; // error
		}
	}
	
	/***************************************************************************/

	else if( parts[0].compare( "GoldBox" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "GoldBox needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cGoldBox *temp = new cGoldBox( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject( (cSprite*)temp );
	}
	
	/***************************************************************************/

	else if( parts[0].compare( "SpinBox" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "SpinBox needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cSpinBox *temp = new cSpinBox( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject( (cSprite*)temp );
	}
	
	/***************************************************************************/

	else if( parts[0].compare( "Cloud" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Cloud needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cCloud *temp = new cCloud( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject ( (cSprite*)temp );
	}
	
	/***************************************************************************/
	
	else if ( parts[0].compare( "Player" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Player needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		pPlayer->SetPos( (double) atoi( parts[1].c_str() ), (double) pPreferences->Screen_H - (double) atoi( parts[2].c_str() ) );

		pPlayer->startposx = (double) atoi( parts[1].c_str() );
		pPlayer->startposy = (double) pPreferences->Screen_H - (double) atoi( parts[2].c_str() );
	}

	/***************************************************************************/
	
	else if ( parts[0].compare( "EnemyStopper" ) == 0 )
	{
		if( count != 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "EnemyStopper needs 3 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		
		cEnemyStopper *temp = new cEnemyStopper( atoi( parts[1].c_str() ), pPreferences->Screen_H - atoi( parts[2].c_str() ) );
		AddActiveObject( (cSprite*)temp );
	}

	/***************************************************************************/
	
	else if( parts[0].compare( "Music" ) == 0 )
	{
		if( parts[1].empty() || parts[1].length() < 3 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "No valid Music file" );
			return 0;  // error
		}
		
		string filename;

		filename.reserve( parts[1].length() + 50 );
		filename = parts[1];

		if( filename.find( MUSIC_DIR ) == string::npos ) 
		{
			filename.insert( 0, "/" );
			filename.insert( 0, MUSIC_DIR );
		}
		
		
		if( count != 2 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Music needs 2 parameters" );
			return 0; // error
		}
		else
		{
			FILE *fp = fopen( filename.c_str(), "r" );

			if( !fp )
			{
				printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
				printf( "Music file not found : %s\n", filename.c_str() );
				return 0; // error
			}
			else
			{
				fclose( fp );

				Set_Musicfile( filename );
			}
		}
	}

	/***************************************************************************/
	
	else if( parts[0].compare( "Mod_Camera" ) == 0 )
	{
		if( count != 4 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( " Mod_Camera needs 4 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}

		if( !is_valid_number( parts[3] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[3].c_str() );
			return 0; // error
		}

		if( atoi( parts[1].c_str() ) >= 0 && atoi( parts[1].c_str() ) < 400 )
		{
			Mod_Camera_up = atoi( parts[1].c_str() );
		}
		else
		{
			printf( "warning : Mod_Camera_up not in a range between 0 - 400\n" );
		}

		if( atoi( parts[2].c_str() ) > -200 && atoi( parts[2].c_str() ) < 300 )
		{
			Mod_Camera_left = atoi( parts[2].c_str() );
		}
		else
		{
			printf( "warning : Mod_Camera_left not in a range between -200 - 400\n" );
		}

		if( atoi( parts[3].c_str() ) > -200 && atoi( parts[3].c_str() ) < 300 )
		{
			Mod_Camera_right = atoi( parts[3].c_str() );
		}
		else
		{
			printf( "warning : Mod_Camera_right not in a range between -200 - 400\n" );
		}
	}
	/***************************************************************************/
	
	else if( parts[0].compare( "Background_Color" ) == 0 )
	{
		if( count != 4 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( " Background_Color needs 4 parameters\n" );
			return 0; // error
		}
		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[2] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[2].c_str() );
			return 0; // error
		}
		if( !is_valid_number( parts[3] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[3].c_str() );
			return 0; // error
		}
		
	
		int Back_red = atoi( parts[1].c_str() );
		int Back_green = atoi( parts[2].c_str() );
		int Back_blue = atoi( parts[3].c_str() );

		if( Back_red < 0 || Back_red > 255 )
		{
			printf( "Warning : Background_Color red is not between 0 - 255\n" );
			Back_red = 0;
		}
		else if( Back_green < 0 || Back_green > 255 )
		{
			printf( "Warning : Background_Color green is not between 0 - 255\n" );
			Back_green = 0;
		}
		else if( Back_blue < 0 || Back_blue > 255 )
		{
			printf( "Warning : Background_Color blue is not between 0 - 255\n" );
			Back_blue = 0;
		}

		Set_BackgroundColor( Back_red, Back_green, Back_blue );
		
	}
	/***************************************************************************/
	
	else if( parts[0].compare( "Levelengine_version") == 0 )
	{
		if( count < 2 )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "Levelengine_version needs 2 parameters or more\n" );
			return 0; // error
		}

		if( !is_valid_number( parts[1] ) )
		{
			printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
			printf( "%s is not a valid integer value\n", parts[1].c_str() );
			return 0; // error
		}

		Levelengine_version = atoi( parts[1].c_str() );
	}
	else
	{
		printf( "%s : line %d Error : ", Get_Levelfile( 0, 0 ).c_str(), line );
		printf( "%s unknown command\n", parts[1].c_str() );
		return 0; // error
	}

	return 1; // Succesfull
}
