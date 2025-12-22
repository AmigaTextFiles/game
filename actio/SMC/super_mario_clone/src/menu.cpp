/***************************************************************************
         main.cpp  -  the nice menu at the beginning of the game
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

cMainMenu :: cMainMenu( void )
{
	leave = 0;
	action = 0;
	Menu_Item = 1;
	Menu_Max = 0;

	LoadImages();
}

cMainMenu :: ~cMainMenu( void )
{
	FreeImages();
}

void cMainMenu :: LoadImages( void )
{
	// Menu Logo
	logo = LoadImage( "menu/logo.png" );
	logo_quit = LoadImage( "menu/logo_quit.png" );

	// SDL Logo
	logo_sdl = LoadImage( "menu/logo_sdl.png" );

	char filename[150];
	
	sprintf( filename,"menu/%dstart.jpg", pPreferences->Screen_W );
	bstart1 = LoadImage( filename );
	sprintf( filename,"menu/%dstart_bw.jpg", pPreferences->Screen_W );
	bstart2 = LoadImage( filename );

	sprintf( filename,"menu/%doptions.jpg", pPreferences->Screen_W );
	boptions1 = LoadImage( filename );
	sprintf( filename,"menu/%doptions_bw.jpg", pPreferences->Screen_W );
	boptions2 = LoadImage( filename );
	
	sprintf( filename,"menu/%dsave.jpg", pPreferences->Screen_W );
	bsave1 = LoadImage( filename );
	sprintf( filename,"menu/%dsave_bw.jpg", pPreferences->Screen_W );
	bsave2 = LoadImage( filename );

	sprintf( filename,"menu/%dload.jpg", pPreferences->Screen_W );
	bload1 = LoadImage( filename );
	sprintf( filename,"menu/%dload_bw.jpg", pPreferences->Screen_W );
	bload2 = LoadImage( filename );
	
	sprintf( filename,"menu/%dquit.jpg", pPreferences->Screen_W );
	bquit1 = LoadImage( filename );
	sprintf( filename,"menu/%dquit_bw.jpg", pPreferences->Screen_W );
	bquit2 = LoadImage( filename );
	
	sprintf( filename,"menu/%dcontrols.jpg", pPreferences->Screen_W );
	bcontrols1 = LoadImage( filename );
	sprintf( filename,"menu/%dcontrols_bw.jpg", pPreferences->Screen_W );
	bcontrols2 = LoadImage( filename );

	sprintf( filename,"menu/%daudio.jpg", pPreferences->Screen_W );
	baudio1 = LoadImage( filename );
	sprintf( filename,"menu/%daudio_bw.jpg", pPreferences->Screen_W );
	baudio2 = LoadImage( filename );

	sprintf( filename,"menu/%dvideo.jpg", pPreferences->Screen_W );
	bvideo1 = LoadImage( filename );
	sprintf( filename,"menu/%dvideo_bw.jpg", pPreferences->Screen_W );
	bvideo2 = LoadImage( filename );
	
	sprintf( filename,"menu/%don.jpg", pPreferences->Screen_W );
	bon1 = LoadImage( filename );
	sprintf( filename,"menu/%don_bw.jpg", pPreferences->Screen_W );
	bon2 = LoadImage( filename );

	sprintf( filename,"menu/%doff.jpg", pPreferences->Screen_W );
	boff1 = LoadImage( filename );
	sprintf( filename,"menu/%doff_bw.jpg", pPreferences->Screen_W );
	boff2 = LoadImage( filename );
	
	text_up			= TTF_RenderText_Shaded( font, "Jump", colorBlack, colorWhite );
	text_upkey		= TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_up ), colorBlack, colorWhite );
		
	text_down		= TTF_RenderText_Shaded( font, "Down", colorBlack, colorWhite );
	text_downkey	= TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_down ), colorBlack, colorWhite );
		
	text_left		= TTF_RenderText_Shaded( font, "Left", colorBlack, colorWhite );
	text_leftkey	= TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_left ), colorBlack, colorWhite );
		
	text_right		= TTF_RenderText_Shaded( font, "Right", colorBlack, colorWhite );
	text_rightkey	= TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_right ), colorBlack, colorWhite );

	text_shoot		= TTF_RenderText_Shaded( font, "Shoot", colorBlack, colorWhite );
	text_shootkey	= TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_shoot ), colorBlack, colorWhite );
	
	text_pointer	= TTF_RenderText_Shaded( font, "->", colorBlack, colorWhite );

	text_usejoystick		=  TTF_RenderText_Shaded( font, "Use Joystick", colorBlack, colorWhite );
	text_usejoystick_on		=  TTF_RenderText_Shaded( font, "Enabled", colorGreen, colorWhite );
	text_usejoystick_off	=  TTF_RenderText_Shaded( font, "Disabled", colorBlack, colorWhite );
	
	video_resolution		=  TTF_RenderText_Shaded( font, "Resolution", colorBlack, colorWhite );
	video_bpp				=  TTF_RenderText_Shaded( font, "Bpp", colorBlack, colorWhite );
	video_fullscreen		=  TTF_RenderText_Shaded( font, "Fullscreen", colorBlack, colorWhite );
	
	video_resolution_val	=  TTF_RenderText_Shaded( font, "Resolution", colorBlack, colorWhite );
	video_bpp_val			=  TTF_RenderText_Shaded( font, "Bpp", colorBlack, colorWhite );
	video_fullscreen_val	=  TTF_RenderText_Shaded( font, "Fullscreen", colorBlack, colorWhite );
	video_change			=  TTF_RenderText_Shaded( font, "Change", colorDarkBlue, colorWhite );
	
	audio_music		= TTF_RenderText_Shaded( font, "Music", colorBlack, colorWhite );
	audio_sounds	= TTF_RenderText_Shaded( font, "Sounds", colorBlack, colorWhite );
	audio_on		= TTF_RenderText_Shaded( font, "On", colorGreen, colorWhite );
	audio_off		= TTF_RenderText_Shaded( font, "Off", colorBlack, colorWhite );

	back1			= TTF_RenderText_Shaded( font, "Back", colorBlack, colorWhite );

	SMC_Version		= TTF_RenderText_Shaded( font_16, "V." VERSION, colorGreen, colorWhite );

	for( int i = 0;i < 9;i++ )
	{
		SaveLoadTemp2[i] = TTF_RenderText_Shaded( font, "No Savegame", colorBlack, colorWhite );
		SaveLoadTemp1[i] = TTF_RenderText_Shaded( font, "No Savegame", colorDarkGreen, colorWhite );
	}

	// Loads the Main menu images
	Item_1 = LoadImage( "menu/item_1.png" );
	Item_2 = LoadImage( "menu/item_2.png" );
	Item_3 = LoadImage( "menu/item_3.png" );
	Item_4 = LoadImage( "menu/item_4.png" );
}

void cMainMenu :: FreeImages( void )
{
	// Menu Logo
	SDL_FreeSurface( logo );
	SDL_FreeSurface( logo_quit );

	// SDL Logo
	SDL_FreeSurface( logo_sdl );
	
	// Keyboard Keys
	SDL_FreeSurface( text_up );
	SDL_FreeSurface( text_upkey );
	SDL_FreeSurface( text_down );
	SDL_FreeSurface( text_downkey );
	SDL_FreeSurface( text_left );
	SDL_FreeSurface( text_leftkey );
	SDL_FreeSurface( text_right );
	SDL_FreeSurface( text_rightkey );
	SDL_FreeSurface( text_shoot );
	SDL_FreeSurface( text_shootkey );
	SDL_FreeSurface( text_pointer );

	// Joystick
	SDL_FreeSurface( text_usejoystick );
	SDL_FreeSurface( text_usejoystick_on );
	SDL_FreeSurface( text_usejoystick_off );

	// Video Items
	SDL_FreeSurface( video_resolution );
	SDL_FreeSurface( video_bpp );
	SDL_FreeSurface( video_fullscreen );
	SDL_FreeSurface( video_change );

	// Audio Items
	SDL_FreeSurface( audio_music );
	SDL_FreeSurface( audio_sounds );
	SDL_FreeSurface( audio_on );
	SDL_FreeSurface( audio_off );

	// Back Button
	SDL_FreeSurface( back1 );

	// Version
	SDL_FreeSurface( SMC_Version );

	// Savegame names
	for( int i = 0;i < 9;i++ )
	{
		if( SaveLoadTemp1[i] )
		{
			SDL_FreeSurface( SaveLoadTemp1[i] );
			SaveLoadTemp1[i] = NULL;
		}

		if( SaveLoadTemp2[i] )
		{
			SDL_FreeSurface( SaveLoadTemp2[i] );
			SaveLoadTemp2[i] = NULL;
		}
	}
}

void cMainMenu :: UpdateGeneric( void )
{
	keys = SDL_GetKeyState( NULL );

	while( SDL_PollEvent( &event ) )
	{
		if( event.type == SDL_QUIT )
		{
			exit( 0 );
		}
		else if( KeyPressed( KEY_ESC ) ) // ESC
		{
			leave = 2;
		}
		else if( KeyPressed( KEY_DOWN ) ) // Down
		{
			if( Menu_Item < Menu_Max )
			{
				Menu_Item++;
			}
			else
			{
				Menu_Item = 1;
			}
		}
		else if( KeyPressed( KEY_UP ) ) // Up
		{
			if( Menu_Item > 1 )
			{
				Menu_Item--;
			}
			else
			{
				Menu_Item = Menu_Max;
			}
		}
		else if( KeyPressed( KEY_ENTER ) ) // Button
		{
			action = 1;
		}
		else if( event.key.keysym.sym == SDLK_l ) 
		{
			KeyDown( SDLK_l );

			if( pLevel->Levelfile.length() > 2 ) 
			{
				Menu_Item = 1;
				action = 1;
			}
		}
	}

	pAudio->Update();
}

void cMainMenu :: ShowMenu( void )
{
	Game_Mode = MODE_MENU;

	if( pLevel->Musicfile.empty() )
	{
		pAudio->FadeOutMusic( 1500 );
		pAudio->PlayMusic( MUSIC_DIR "/Game/mainmenu.ogg", -1, 0, 1500 );
	}
	
	leave = 0;
	Menu_Max = 5;
	
	while( !leave )
	{
		UpdateGeneric();

		if( action )
		{
			MenuAction();
		}

		UpdateMenu();

		CorrectFrameTime();
	}

	if( leave == 2 && !pPlayer->points && !Leveleditor_Mode )	
	{
		exit( 0 );
	}

	Game_Mode = MODE_LEVEL;
}

void cMainMenu :: UpdateMenu( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect;

	// Logo
	rect.x = pPreferences->Screen_W/2-logo->w/2;
	rect.y = 10;
	rect.w = logo->w;
	rect.h = logo->h;
	
	if( Menu_Item != 5 )
	{
		SDL_BlitSurface( logo, NULL, screen, &rect );	
	}
	else
	{
		SDL_BlitSurface( logo_quit, NULL, screen, &rect );	
	}

	// Menu items
	if( Menu_Item == 1 )
	{
		rect.x = pPreferences->Screen_W/2 + bstart1->w + 10;
		rect.y = logo->h + 20;
		rect.w = Item_1->w;
		rect.h = Item_1->h;
		SDL_BlitSurface( Item_1, NULL, screen, &rect );
	}
	else if( Menu_Item == 2 )
	{
		rect.x = (int)(pPreferences->Screen_W/2.5) - boptions1->w;
		rect.y = logo->h + bstart1->h + 25;
		rect.w = Item_1->w;
		rect.h = Item_1->h;
		SDL_BlitSurface( Item_2, NULL, screen, &rect );
	}
	else if( Menu_Item == 3 )
	{
		rect.x = pPreferences->Screen_W/2 + bstart1->w + 10;
		rect.y = logo->h + bstart1->h + boptions1->h + 30;
		rect.w = Item_1->w;
		rect.h = Item_1->h;
		SDL_BlitSurface( Item_3, NULL, screen, &rect );
	}
	else if( Menu_Item == 4 )
	{
		rect.x = (pPreferences->Screen_W/2) - bsave1->w;
		rect.y = logo->h + bstart1->h + boptions1->h + bsave1->h + 35;
		rect.w = Item_1->w;
		rect.h = Item_1->h;
		SDL_BlitSurface( Item_4, NULL, screen, &rect );
	}

	// SMC Version
	rect.x = pPreferences->Screen_W - SMC_Version->w - 10;
	rect.y = pPreferences->Screen_H - SMC_Version->h - 5;
	rect.w = SMC_Version->w;
	rect.h = SMC_Version->h;
	SDL_BlitSurface( SMC_Version, NULL, screen, &rect );

	// SDL Logo
	rect.x = 5;
	rect.y = pPreferences->Screen_H - logo_sdl->h - 5;
	rect.w = logo_sdl->w;
	rect.h = logo_sdl->h;
	SDL_BlitSurface( logo_sdl, NULL, screen, &rect );

	// Start
	rect.x = pPreferences->Screen_W/2-bstart1->w/2;
	rect.y = logo->h + 20;
	rect.w = bstart1->w;
	rect.h = bstart1->h;

	if( Menu_Item == 1 )
	{
		SDL_BlitSurface( bstart1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( bstart2, NULL, screen, &rect );
	}

	// Options
	rect.x = pPreferences->Screen_W/2-boptions1->w/2;
	rect.y += rect.h + 5;
	rect.w = boptions1->w;
	rect.h = boptions1->h;

	if( Menu_Item == 2 )
	{
		SDL_BlitSurface( boptions1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( boptions2, NULL, screen, &rect );
	}

	// Save
	rect.x = pPreferences->Screen_W/2-bsave1->w/2;
	rect.y += rect.h + 5;
	rect.w = bsave1->w;
	rect.h = bsave1->h;

	if( Menu_Item == 3 )
	{
		SDL_BlitSurface( bsave1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( bsave2, NULL, screen, &rect );
	}

	// Load
	rect.x = pPreferences->Screen_W/2-bload1->w/2;
	rect.y += rect.h + 5;
	rect.w = bload1->w;
	rect.h = bload1->h;

	if( Menu_Item == 4 )
	{
		SDL_BlitSurface( bload1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( bload2, NULL, screen, &rect );
	}
	
	// Quit
	rect.x = pPreferences->Screen_W/2-bquit1->w/2;
	rect.y += rect.h + 5;
	rect.w = bquit1->w;
	rect.h = bquit1->h;

	if( Menu_Item == 5 )
	{
		SDL_BlitSurface( bquit1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( bquit2, NULL, screen, &rect );
	}

	SDL_Flip( screen );
}


void cMainMenu :: MenuAction( void )
{
	action = 0;

	if( Menu_Item == 1 ) // Start
	{
		leave = 1;
	}
	else if( Menu_Item == 2 ) // Options
	{
		ShowSubOptions();
	}
	else if( Menu_Item == 3 )	// Save
	{
		GetSavedGames();
		ShowSaveGames();
	}
	else if( Menu_Item == 4 ) // Load
	{	
		GetSavedGames();
		ShowLoadGames();
	}
	else if( Menu_Item == 5 ) // Quit
	{
		exit( 0 );
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

void cMainMenu :: ShowSubControls( void )
{
	leave = 0;
	Menu_Item = 1;
	Menu_Max = 7;

	while( !leave )
	{
		UpdateGeneric();
		UpdateSubControls();

		if( action )
		{
			SubControlsAction();
		}

		CorrectFrameTime();
	}

	Menu_Item = 1;
}

void cMainMenu :: UpdateSubControls( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect;

	// Options
	rect.x = 10;
	rect.y = 15;
	rect.w = bcontrols1->w;
	rect.h = bcontrols1->h;
	SDL_BlitSurface( bcontrols1, NULL, screen, &rect );	

	// text_up
	rect.x = 200;
	rect.y = 120;
	rect.w = text_up->w;
	rect.h = text_up->h;
	SDL_BlitSurface(text_up, NULL, screen, &rect);	

	if( Menu_Item == 1 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface(text_pointer, NULL, screen, &rect);	
	}

	rect.x = 200 + 100;
	rect.w = text_upkey->w;
	rect.h = text_upkey->h;
	SDL_BlitSurface(text_upkey, NULL, screen, &rect);	
	
	// text_down
	rect.x = 200;
	rect.y = 170;
	rect.w = text_down->w;
	rect.h = text_down->h;
	SDL_BlitSurface(text_down, NULL, screen, &rect);	
	
	if( Menu_Item == 2 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface(text_pointer, NULL, screen, &rect);	
	}

	rect.x = 200 + 100;
	rect.w = text_downkey->w;
	rect.h = text_downkey->h;
	SDL_BlitSurface(text_downkey, NULL, screen, &rect);	
	
	// text_left
	rect.x = 200;
	rect.y = 220;
	rect.w = text_left->w;
	rect.h = text_left->h;
	SDL_BlitSurface(text_left, NULL, screen, &rect);	
	
	if( Menu_Item == 3 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface(text_pointer, NULL, screen, &rect);	
	}

	rect.x = 200 + 100;
	rect.w = text_leftkey->w;
	rect.h = text_leftkey->h;
	SDL_BlitSurface(text_leftkey, NULL, screen, &rect );	
	
	// text_right
	rect.x = 200;
	rect.y = 270;
	rect.w = text_right->w;
	rect.h = text_right->h;
	SDL_BlitSurface(text_right, NULL, screen, &rect );	
	
	if( Menu_Item == 4 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}

	rect.x = 200 + 100;
	rect.w = text_rightkey->w;
	rect.h = text_rightkey->h;
	SDL_BlitSurface( text_rightkey, NULL, screen, &rect );	
	
	// text_shoot
	rect.x = 200;
	rect.y = 320;
	rect.w = text_shoot->w;
	rect.h = text_shoot->h;
	SDL_BlitSurface( text_shoot, NULL, screen, &rect );	
	
	if( Menu_Item == 5 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}

	rect.x = 200 + 100;
	rect.w = text_shootkey->w;
	rect.h = text_shootkey->h;
	SDL_BlitSurface( text_shootkey, NULL, screen, &rect );	
	
	// text_usejoystick
	rect.x = 200;
	rect.y = 390;
	rect.w = text_usejoystick->w;
	rect.h = text_usejoystick->h;
	SDL_BlitSurface(text_usejoystick, NULL, screen, &rect );

	if( Menu_Item == 6 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface(text_pointer, NULL, screen, &rect);	
	}

	rect.x = 200 + 150;
	rect.w = text_shootkey->w;
	rect.h = text_shootkey->h;

	if( pPreferences->Joy_enabled )
	{
		SDL_BlitSurface( text_usejoystick_on, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( text_usejoystick_off, NULL, screen, &rect );
	}

	//  add the next control here ...

	// Back
	rect.x = 200;
	rect.y += text_pointer->h + 20;
	rect.w = back1->w;
	rect.h = back1->h;

	SDL_BlitSurface( back1, NULL, screen, &rect );	

	if( Menu_Item == 7 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface(text_pointer, NULL, screen, &rect);	
	}
	
	SDL_Flip( screen );	// for Double-Buffering
}

void cMainMenu :: SubControlsAction( void )
{
	action = 0;
	int sdone = 0;


	if( Menu_Item  == 6 )
	{
		pPreferences->Joy_enabled = !pPreferences->Joy_enabled;
		sdone = 1;
	}
	else if( Menu_Item == 7 )
	{
		leave = 1;
		sdone = 1;
	}

	while( !sdone )
	{
		while( SDL_PollEvent( &event ) )
		{
			if( event.type == SDL_KEYDOWN )
			{
				switch( Menu_Item )
				{
				case 1: 
					pPreferences->Key_up = event.key.keysym.sym; 
					SDL_FreeSurface( text_upkey );
					text_upkey = TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_up ), colorBlack, colorWhite );
					break;
				case 2: 
					pPreferences->Key_down = event.key.keysym.sym; 
					SDL_FreeSurface( text_downkey );
					text_downkey = TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_down ), colorBlack, colorWhite );
					break;
				case 3: 
					pPreferences->Key_left = event.key.keysym.sym; 
					SDL_FreeSurface( text_leftkey );
					text_leftkey = TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_left ), colorBlack, colorWhite );
					break;
				case 4: 
					pPreferences->Key_right = event.key.keysym.sym; 
					SDL_FreeSurface( text_rightkey );
					text_rightkey = TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_right ), colorBlack, colorWhite );
					break;
				case 5:
					pPreferences->Key_shoot = event.key.keysym.sym; 
					SDL_FreeSurface( text_shootkey );
					text_shootkey = TTF_RenderText_Shaded( font, SDL_GetKeyName( pPreferences->Key_shoot ), colorBlack, colorWhite );
					break;
				default:
					break;
				}

				sdone = 1;
			}
		}	
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

void cMainMenu :: ShowSubOptions( void )
{
	done = 0;
	Menu_Item = 1;
	while( !done )
	{
		UpdateSubOptions();
		
		keys = SDL_GetKeyState( NULL );

		while( SDL_PollEvent(&event) )
		{
			if( KeyPressed( KEY_ESC ) )
			{
				done = 1;
			}
			else if( KeyPressed( KEY_DOWN ) )
			{
				if( Menu_Item < 3 )
				{
					Menu_Item++;
				}
				else
				{
					Menu_Item = 1;
				}
			}
			else if( KeyPressed( KEY_UP ) )
			{
				if( Menu_Item > 1 )
				{
					Menu_Item--;
				}
				else
				{
					Menu_Item = 3;
				}
			}
			else if( KeyPressed( KEY_ENTER ) )
			{
				SubOptionsAction();
			}			
		}	

		CorrectFrameTime();
	}

	Menu_Item = 2;
	done = 0;
}

void cMainMenu :: ShowLoadGames( void )
{
	done = 0;
	Menu_Item = 1;

	while( !done )
	{
		UpdateLoadGames();
		
		keys = SDL_GetKeyState( NULL );

		while( SDL_PollEvent( &event ) )
		{
			
			if( KeyPressed( KEY_ESC ) )
			{
				done = 1;
			}
			else if( KeyPressed( KEY_DOWN ) )
			{
				if( Menu_Item < 10 )
				{
					Menu_Item++;
				}
				else
				{
					Menu_Item = 1;
				}
			}
			else if( KeyPressed( KEY_UP ) )
			{
				if( Menu_Item > 1 )
				{
					Menu_Item--;
				}
				else
				{
					Menu_Item = 10;
				}
			}
			else if( KeyPressed( KEY_ENTER ) )
			{
				if( Menu_Item == 1 )
				{
					Menu_Item = 4;
					done = 0;
					return;
				}
				else
				{
					if( Savegame_valid( Menu_Item - 1 ) )
					{
						done = 1;
						pAudio->PauseMusic();
						pAudio->PlaySound( SOUNDS_DIR "/savegame_load.ogg" );
						
						pLevel->Load_Savegame( Menu_Item - 1 );

						Menu_Item = 4;
						return;
					}
				}
	
			}
		}	

		CorrectFrameTime();
	}

	Menu_Item = 4;
	done = 0;
}

void cMainMenu :: ShowSaveGames( void )
{
	done = 0;
	Menu_Item = 1;

	while( !done )
	{
		keys = SDL_GetKeyState( NULL );

		while( SDL_PollEvent( &event ) )
		{
			if( KeyPressed( KEY_ESC ) )
			{
				done = 1;
			}
			else if( KeyPressed( KEY_DOWN ) )
			{
				if( Menu_Item < 10 )
				{
					Menu_Item++;
				}
				else
				{
					Menu_Item = 1;
				}
			} 
			else if( KeyPressed( KEY_UP ) )
			{
				if( Menu_Item > 1 )
				{
					Menu_Item--;
				}
				else
				{
					Menu_Item = 10;
				}
			} 
			else if( KeyPressed( KEY_ENTER ) )
			{
				if( Menu_Item == 1 )
				{
					Menu_Item = 3;
					done = 0;
					return;
				}
				else // Description
				{
					pAudio->PlaySound( SOUNDS_DIR "/beep_1.ogg" );
					string tmp_Descripion = Set_SaveDescription( Menu_Item - 1 );
					
					Framerate.Reset();

					if( tmp_Descripion.compare( "Not enough Points" ) == 0 ) 
					{
						sprintf( debugdisplay->text, "Not Enough Points [3000 needed]" );
						debugdisplay->counter = ( DESIRED_FPS*2 ); // 2 seconds
						done = 1;
						return;
					}
					else if( tmp_Descripion.length() > 0 )
					{
						done = 1;
						pAudio->PlaySound( SOUNDS_DIR "/save.ogg" );
						pLevel->Save_Savegame( Menu_Item-1, tmp_Descripion );
						Menu_Item = 3;
						return;
					}
				}
			}			
		}

		UpdateSaveGames();

		CorrectFrameTime();
	}

	Menu_Item = 3;
	done = 0;
}

/* Sets the Savegame Description
 */
string cMainMenu :: Set_SaveDescription( unsigned int Save_file )
{
	if( Save_file <= 0 || Save_file >= 10 ) 
	{
		return "Wrong Savefile";
	}
#ifndef _DEBUG // saving costs 3000 Points only in Release Builds
	if( pPlayer ) 
	{
		if( pPlayer->points < 3000 ) 
		{
			return "Not enough Points";
		}
		else
		{
			pointsdisplay->SetPoints( pPlayer->points - 3000 );
		}
	}
	else
	{
		return NULL;
	}
#endif
	string Save_Description;

	bool auto_text = 0;

	if( Savegame_valid( Save_file ) ) // If Savegame exists use old Description
	{
		Save_Description.empty();
		Save_Description = Savegame_GetDescription( Save_file, 1 ); // Only the Description
	}
	else
	{
		Save_Description = " No Description "; // Standard Description
		auto_text = 1;
	}

	return EditMessageBox( Save_Description, "Enter Description", pPreferences->Screen_W/2 - 100, 
		10 + logo->h + 10 + bquit1->h + ( Save_file * (6 + SaveLoadTemp1[1]->h ) - SaveLoadTemp1[1]->h ), auto_text );
}

void cMainMenu :: UpdateSubOptions( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect;

	// Logo
	rect.x = pPreferences->Screen_W/2-logo->w/2;
	rect.y = 10;
	rect.w = logo->w;
	rect.h = logo->h;
	SDL_BlitSurface(logo, NULL, screen, &rect);	
	
	
	// Options
	rect.x = 10;
	rect.y += rect.h + 10;
	rect.w = boptions1->w;
	rect.h = boptions1->h;
	SDL_BlitSurface(boptions1, NULL, screen, &rect);	
	
	// Controls
	rect.x = pPreferences->Screen_W/2-bcontrols1->w/2;
	rect.y += rect.h + 10;
	rect.w = bcontrols1->w;
	rect.h = bcontrols1->h;

	if( Menu_Item == 1 )
	{
		SDL_BlitSurface( bcontrols1, NULL, screen, &rect );	
	}
	else
	{
		SDL_BlitSurface( bcontrols2, NULL, screen, &rect );	
	}
	
	// Audio
	rect.x = pPreferences->Screen_W/2-baudio1->w/2;
	rect.y += rect.h + 10;
	rect.w = baudio1->w;
	rect.h = baudio1->h;

	if ( Menu_Item == 2 )
	{
		SDL_BlitSurface( baudio1, NULL, screen, &rect );	
	}
	else
	{
		SDL_BlitSurface( baudio2, NULL, screen, &rect );
	}
	
	// Video
	rect.x = pPreferences->Screen_W/2-bvideo1->w/2;
	rect.y += rect.h + 10;
	rect.w = bvideo1->w;
	rect.h = bvideo1->h;

	if( Menu_Item == 3 )
	{
		SDL_BlitSurface(bvideo1, NULL, screen, &rect);
	}
	else
	{
		SDL_BlitSurface(bvideo2, NULL, screen, &rect);	
	}
	
	SDL_Flip( screen );	// for Double-Buffering
}

void cMainMenu :: UpdateSaveGames( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect;

	// Logo
	rect.x = pPreferences->Screen_W/2-logo->w/2;
	rect.y = 10;
	rect.w = logo->w;
	rect.h = logo->h;
	SDL_BlitSurface( logo, NULL, screen, &rect );	
	
	
	// Save Menu
	rect.x = 10;
	rect.y += rect.h + 10; // 
	rect.w = bsave1->w;
	rect.h = bsave1->h;
	SDL_BlitSurface( bsave1, NULL, screen, &rect );	

	// Quit
	rect.x = pPreferences->Screen_W/2-bquit1->w/2;
	rect.w = bquit1->w;
	rect.h = bquit1->h;

	if( Menu_Item == 1 )
	{
		SDL_BlitSurface( bquit1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( bquit2, NULL, screen, &rect );
	}
	
	// All the saved games
	
	for( int i = 0;i < 9;i++ ) // 9 Savegames
	{
		if( !SaveLoadTemp1[i] )
		{
			continue;
		}
		
		rect.x = pPreferences->Screen_W/2 - SaveLoadTemp1[i]->w/2;
		rect.y += rect.h + 6;
		rect.w = SaveLoadTemp1[i]->w;
		rect.h = SaveLoadTemp1[i]->h;

		if( Menu_Item== ( i + 2 ) )
		{
			SDL_BlitSurface( SaveLoadTemp1[i], NULL, screen, &rect );	
		}
		else
		{
			SDL_BlitSurface( SaveLoadTemp2[i], NULL, screen, &rect );
		}

	}

	SDL_Flip( screen );	// for Double-Buffering
}

void cMainMenu :: UpdateLoadGames( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect;

	// Logo
	rect.x = pPreferences->Screen_W/2-logo->w/2;
	rect.y = 10;
	rect.w = logo->w;
	rect.h = logo->h;

	SDL_BlitSurface( logo, NULL, screen, &rect );	
	
	
	// Save Menu
	rect.x = 10;
	rect.y += rect.h + 10;
	rect.w = bload1->w;
	rect.h = bload1->h;

	SDL_BlitSurface( bload1, NULL, screen, &rect );	
	
	// Quit
	rect.x = pPreferences->Screen_W/2-bquit1->w/2;
	rect.w = bquit1->w;
	rect.h = bquit1->h;

	if( Menu_Item == 1 )
	{
		SDL_BlitSurface( bquit1, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( bquit2, NULL, screen, &rect );
	}
	
	// All the saved games
	
	for( int i = 0;i < 9;i++ ) // 9 Savegames
	{
		if( !SaveLoadTemp1[i] ) // untested
		{
			continue;
		}
		
		rect.x = pPreferences->Screen_W/2 - SaveLoadTemp1[i]->w/2;
		rect.y += rect.h + 6;
		rect.w = SaveLoadTemp1[i]->w;
		rect.h = SaveLoadTemp1[i]->h;

		if( Menu_Item == ( i + 2 ) )
		{
			SDL_BlitSurface( SaveLoadTemp1[i], NULL, screen, &rect );
		}
		else
		{
			SDL_BlitSurface( SaveLoadTemp2[i], NULL, screen, &rect );
		}

	}
	
	SDL_Flip( screen );	// for Double-Buffering
}

void cMainMenu :: SubOptionsAction( void )
{
	switch( Menu_Item )
	{
		case 1: 
		{
			ShowSubControls();
			break;
		}
		case 2: 
		{
			ShowSubAudio();	
			break;
		}
		case 3:
		{
			ShowSubVideo();
			break;
		}
		default:
			break;
	}
}



/* *** *** *** *** *** *** *** *** Sub Audio *** *** *** *** *** *** *** *** *** *** */

void cMainMenu :: ShowSubAudio( void )
{
	done = 0;
	
	Menu_Item = 1;
	
	while( !done )
	{
		keys = SDL_GetKeyState( NULL );

		while( SDL_PollEvent(&event) )
		{
			

			if ( KeyPressed( KEY_ESC ) )
			{
				done = 1;
			}
			else if( KeyPressed( KEY_ENTER ) )
			{
				if( Menu_Item == 1 )
				{
					if( pAudio->bMusic )
					{
						pAudio->bMusic = 0;

						Mix_HaltMusic();
					}
					else
					{
						pAudio->bMusic = 1;
						
						pAudio->Init();
						
						if( pLevel->Musicfile.empty() )
						{
							pAudio->PlayMusic( MUSIC_DIR "/Game/mainmenu.ogg", -1, 1, 2000 );
						}
						else
						{
							pAudio->PlayMusic( pLevel->Musicfile, -1, 1, 2000 );
						}
						
					}
				} 
				else if( Menu_Item == 2 )
				{
					if( pAudio->bSounds )
					{
						pAudio->bSounds = 0;

						// pAudio->StopSounds(); // buggy
					}
					else
					{
						pAudio->bSounds = 1;
						
						pAudio->Init();

						pAudio->PlaySound( SOUNDS_DIR "/audio_on.ogg" );
					}
				}
				else if( Menu_Item == 3 )
				{
					done = 1;
				}
			}
			else if( KeyPressed(KEY_DOWN) )
			{
				if( Menu_Item < 3 )
				{
					Menu_Item++;
				}
				else
				{
					Menu_Item = 1;
				}
			}
			else if( KeyPressed(KEY_UP) )
			{
				if( Menu_Item > 1 )
				{
					Menu_Item--;
				}
				else
				{
					Menu_Item = 3;
				}
			}			
		}
		
		UpdateSubAudio();

		CorrectFrameTime();
	}

	Menu_Item = 2;
	done = 0;
}

void cMainMenu :: UpdateSubAudio( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect;
	
	// Logo
	rect.x = pPreferences->Screen_W/2-logo->w/2;
	rect.y = 10;
	rect.w = logo->w;
	rect.h = logo->h;
	SDL_BlitSurface( logo, NULL, screen, &rect );
	
	// Audio
	rect.x = 10;
	rect.y += rect.h + 10;
	rect.w = baudio1->w;
	rect.h = baudio1->h;
	SDL_BlitSurface(baudio1, NULL, screen, &rect);
	
	// On
	rect.x = pPreferences->Screen_W/2-audio_music->w/2;
	rect.y += rect.h + 10;
	rect.w = audio_music->w;
	rect.h = audio_music->h;

	SDL_BlitSurface( audio_music, NULL, screen, &rect );
	
	rect.x += rect.w + 20;
	
	if( pAudio->bMusic )
	{
		SDL_BlitSurface( audio_on, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( audio_off, NULL, screen, &rect );
	}

	rect.x -= audio_music->w + 20;

	if( Menu_Item == 1 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}
	
	// Off
	rect.x = pPreferences->Screen_W/2-audio_sounds->w/2;
	rect.y += rect.h + 10;
	rect.w = audio_sounds->w;
	rect.h = audio_sounds->h;

	SDL_BlitSurface( audio_sounds, NULL, screen, &rect );
	
	rect.x += rect.w + 20;
	
	if( pAudio->bSounds )
	{
		SDL_BlitSurface( audio_on, NULL, screen, &rect );
	}
	else
	{
		SDL_BlitSurface( audio_off, NULL, screen, &rect );
	}

	rect.x -= audio_sounds->w + 20;

	if( Menu_Item == 2 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}
	
	// Back
	rect.x = pPreferences->Screen_W/2-audio_sounds->w/2;
	rect.y += text_pointer->h + 10;
	rect.w = back1->w;
	rect.h = back1->h;

	SDL_BlitSurface( back1, NULL, screen, &rect );	

	if( Menu_Item == 3 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}
	
	SDL_Flip( screen );	// for Double-Buffering
}

/* *** *** *** *** *** *** *** *** Sub Video *** *** *** *** *** *** *** *** *** *** */

void cMainMenu :: ShowSubVideo( void )
{
	done = 0;

	int Tmp_screen_w = pPreferences->Screen_W;
	int Tmp_screen_h = pPreferences->Screen_H;
	int Tmp_screen_bpp = pPreferences->Bpp;
	bool Tmp_fullscreen = pPreferences->Fullscreen;
	
	SetScreeninfo( pPreferences->Screen_W, pPreferences->Screen_H, pPreferences->Bpp, pPreferences->Fullscreen );
	
	while( !done )
	{
		while( SDL_PollEvent(&event) )
		{
			keys = SDL_GetKeyState(NULL);

			if( KeyPressed(KEY_ESC) )
			{
				done = 1;
			}
			else if( KeyPressed(KEY_ENTER) )
			{
				if(Menu_Item == 1)
				{
					if(Tmp_screen_w == 800 && Tmp_screen_h == 600)
					{
						Tmp_screen_w = 1024;
						Tmp_screen_h = 768;
						SetScreeninfo( Tmp_screen_w, Tmp_screen_h, Tmp_screen_bpp, Tmp_fullscreen );
					}
					else if(Tmp_screen_w == 1024 && Tmp_screen_h == 768)
					{
						Tmp_screen_w = 800;
						Tmp_screen_h = 600;
						SetScreeninfo( Tmp_screen_w, Tmp_screen_h, Tmp_screen_bpp, Tmp_fullscreen );
					}
				}
				else if(Menu_Item == 2)
				{
					if( Tmp_screen_bpp == 16 )
					{
						Tmp_screen_bpp = 32;
						SetScreeninfo( Tmp_screen_w, Tmp_screen_h, Tmp_screen_bpp, Tmp_fullscreen );
					}
					else if( Tmp_screen_bpp == 32 ) // does not work correct
					{
						//Tmp_screen_bpp = 16;
						//SetScreeninfo(Tmp_screen_w,Tmp_screen_h,Tmp_screen_bpp,Tmp_fullscreen);
					}
				}
				else if( Menu_Item == 3 )
				{
					if( Tmp_fullscreen )
					{
						Tmp_fullscreen = 0;
						SetScreeninfo( Tmp_screen_w, Tmp_screen_h, Tmp_screen_bpp, Tmp_fullscreen );	
					}
					else
					{
						Tmp_fullscreen = 1;
						SetScreeninfo( Tmp_screen_w, Tmp_screen_h, Tmp_screen_bpp, Tmp_fullscreen );
					}
				}
				else if( Menu_Item == 4 )
				{
					pLevel->Unload();
					UnloadHudObjects();
					FreeImages();

					if( screen )
					{
						SDL_FreeSurface( screen );
					}
					
					pPreferences->Screen_W = Tmp_screen_w;
					pPreferences->Screen_H = Tmp_screen_h;
					pPreferences->Bpp = Tmp_screen_bpp;
					pPreferences->Fullscreen = Tmp_fullscreen;
					
					ImageFactory->ReloadImages( 1 );

					if( pPreferences->Fullscreen )
					{
						screen = SDL_SetVideoMode( pPreferences->Screen_W, pPreferences->Screen_H, pPreferences->Bpp, SDL_SWSURFACE | SDL_HWACCEL | SDL_RLEACCEL | SDL_FULLSCREEN );
					}
					else
					{
						screen = SDL_SetVideoMode( pPreferences->Screen_W, pPreferences->Screen_H, pPreferences->Bpp, SDL_SWSURFACE | SDL_HWACCEL | SDL_RLEACCEL | SDL_DOUBLEBUF );
					}

					ImageFactory->ReloadImages( 2 );

					pPlayer->LoadImages( 1 );
					
					pOverWorld->UnloadOverWorld();

					LoadImages();
					UpdateHudObjects();
										
					SetScreeninfo( pPreferences->Screen_W, pPreferences->Screen_H, pPreferences->Bpp, pPreferences->Fullscreen );
					
				}
				else if( Menu_Item == 5 )
				{
					done = true;
				}
			}
			else if( KeyPressed( KEY_DOWN ) )
			{
				if (Menu_Item < 5)
					Menu_Item++;
				else
					Menu_Item = 1;
			}
			else if( KeyPressed( KEY_UP ) )
			{
				if( Menu_Item > 1 )
				{
					Menu_Item--;
				}
				else
				{
					Menu_Item = 5;
				}
			}			
		}	

		UpdateSubVideo();

		CorrectFrameTime();
	}
	Menu_Item = 3;
	done = 0;
}

void cMainMenu :: UpdateSubVideo( void )
{
	SDL_FillRect( screen, NULL, white );
	SDL_Rect rect,rect2;
	
	// Logo
	rect.x = pPreferences->Screen_W/2-logo->w/2;
	rect.y = 10;
	rect.w = logo->w;
	rect.h = logo->h;
	SDL_BlitSurface( logo, NULL, screen, &rect );	
	
	
	// Video
	rect.x = 10;
	rect.y += rect.h + 10;
	rect.w = bvideo1->w;
	rect.h = bvideo1->h;
	SDL_BlitSurface( bvideo1, NULL, screen, &rect );

	// Resolution
	rect.x = 320;
	rect.y += text_pointer->h + 50;
	rect.w = video_resolution->w;
	rect.h = video_resolution->h;

	SDL_BlitSurface( video_resolution, NULL, screen, &rect );	
	rect2 = rect;
	rect2.x += video_resolution->w + 20;
	SDL_BlitSurface( video_resolution_val, NULL, screen, &rect2 );

	if( Menu_Item == 1 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}	
	
	// Bpp
	rect.x = 320;
	rect.y += text_pointer->h + 10;
	rect.w = video_bpp->w;
	rect.h = video_bpp->h;

	SDL_BlitSurface( video_bpp, NULL, screen, &rect );	
	rect2 = rect;
	rect2.x += video_resolution->w + 20;
	SDL_BlitSurface( video_bpp_val, NULL, screen, &rect2 );
	
	if( Menu_Item == 2 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}

	// Fullscreen
	rect.x = 320;
	rect.y += text_pointer->h + 10;
	rect.w = video_fullscreen->w;
	rect.h = video_fullscreen->h;

	SDL_BlitSurface( video_fullscreen, NULL, screen, &rect );	
	rect2 = rect;
	rect2.x += video_resolution->w + 20;
	SDL_BlitSurface( video_fullscreen_val, NULL, screen, &rect2 );

	if( Menu_Item == 3 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}

	// Change
	rect.x = 320;
	rect.y += text_pointer->h + 10;
	rect.w = video_change->w;
	rect.h = video_change->h;

	SDL_BlitSurface( video_change, NULL, screen, &rect );	

	if( Menu_Item == 4 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}

	// Back
	rect.x = 320;
	rect.y += text_pointer->h + 10;
	rect.w = back1->w;
	rect.h = back1->h;

	SDL_BlitSurface( back1, NULL, screen, &rect );	

	if( Menu_Item == 5 )
	{
		rect.x -= text_pointer->w + 10;
		rect.w = text_pointer->w;
		rect.h = text_pointer->h;
		SDL_BlitSurface( text_pointer, NULL, screen, &rect );	
	}

	SDL_Flip( screen );	// for Double-Buffering
}

// ############################ Menu End ####################################### //

void cMainMenu :: GetSavedGames( void )
{
	int i;

	for( i = 0;i < 9;i++ )
	{
		if( SaveLoadTemp1[i] )
		{
			SDL_FreeSurface( SaveLoadTemp1[i] );
			SaveLoadTemp1[i] = NULL;
		}

		if( SaveLoadTemp2[i] )
		{
			SDL_FreeSurface( SaveLoadTemp2[i] );
			SaveLoadTemp2[i] = NULL;
		}
	}

	for( i = 0;i < 9;i++ )
	{
		SaveLoadTemp2[i] = TTF_RenderText_Shaded( font, Savegame_GetDescription( i + 1 ), colorBlack, colorWhite);

		TTF_SetFontStyle( font, TTF_STYLE_UNDERLINE ); // Underlined
		SaveLoadTemp1[i] = TTF_RenderText_Shaded( font, Savegame_GetDescription( i + 1 ), colorDarkGreen, colorWhite );

		TTF_SetFontStyle( font, TTF_STYLE_NORMAL ); // Back to Normal
	}
}

void cMainMenu :: SetScreeninfo( int Tmp_screen_w, int Tmp_screen_h, int Tmp_screen_Bpp, bool Tmp_screen_Fullscreen )
{
	SDL_FreeSurface( video_resolution_val );
	SDL_FreeSurface( video_bpp_val );
	SDL_FreeSurface( video_fullscreen_val );
	
	if( Tmp_screen_w == 800 && Tmp_screen_h == 600 )
	{
		video_resolution_val = TTF_RenderText_Shaded( font, "800x600 Recommended", colorGreen, colorWhite );
	}
	else if( Tmp_screen_w == 1024 && Tmp_screen_h == 768 )
	{
		video_resolution_val = TTF_RenderText_Shaded( font, "1024x768"" Not Recommended !", colorRed, colorWhite );
	}
	else
	{
		video_resolution_val = TTF_RenderText_Shaded( font, "Resolution Error", colorBlack, colorWhite );
	}

	if( Tmp_screen_Bpp == 16 )
	{
		video_bpp_val = TTF_RenderText_Shaded( font, "16", colorBlack, colorWhite );
	}
	else if( Tmp_screen_Bpp == 32 )
	{
		video_bpp_val = TTF_RenderText_Shaded( font, "32", colorGreen, colorWhite );
	}
	else
	{
		video_bpp_val = TTF_RenderText_Shaded( font, "Bpp Error", colorBlack, colorWhite );
	}

	if( Tmp_screen_Fullscreen )
	{
		video_fullscreen_val = TTF_RenderText_Shaded( font, "On", colorGreen, colorWhite );	
	}
	else
	{
		video_fullscreen_val = TTF_RenderText_Shaded( font, "Off", colorBlack, colorWhite );
	}
}
