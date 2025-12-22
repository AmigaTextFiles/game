/***************************************************************************
           main.cpp  -  main routines and infrastructure
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

int main( int argc, char *argv[] )
{
	if( argc == 2 )
	{
		// Use printf Boder :P
		if( 0 == strcmp( argv[1], "--help" ) || 0 == strcmp( argv[1], "-h" ) )
		{
			cout << CAPTION << " " << VERSION << "\n\n";
			cout << "Usage: " << argv[0] << " [OPTIONS] [LEVELFILE]" << endl;
			cout << "Where LEVELFILE is the name of the level to play or OPTIONS is one of the following." << endl;
			cout << "-h, --help\tDisplay this message" << endl;
			cout << "-v, --version\tShow the version of this binary" << endl;
			return 0;
		}
		else if( 0 == strcmp( argv[1], "--version" ) || 0 == strcmp( argv[1], "-v" ) )
		{
			cout << CAPTION << " " << VERSION << endl;
			return 0;
		}
	}
	
	Leveleditor_Mode = 0;
	Game_debug = 0;
	UpKeyTime = 0;
	cameraposx = 0;
	cameraposy = 0;
	_cameraposy = 0;
	_cameraposx = 0;

	HUDObjects = NULL;
	HUDCount = 0;
	AnimationObjects = NULL;
	AnimationCount = 0;
	MassiveObjects = NULL;
	MassiveCount = 0;
	PassiveObjects = NULL;
	PassiveCount = 0;
	ActiveObjects = NULL;
	ActiveCount = 0;
	EnemyObjects = NULL;
	EnemyCount = 0;
	DialogObjects = NULL;
	DialogCount = 0;

	pPreferences = new cPreferences;
	pPreferences->Load();

	ImageFactory = new cImageManager();

	pOverWorld = new cOverWorld();
	
	srand( time( NULL) );
	
	if( argc == 2 )
	{
		StartGame( argv[1] );
	}
	else
	{
		StartGame();
	}
	
	while( !done )
	{
		ProcessEvents();
		ProcessInput();
		UpdateGame();
		Framerate.SetSpeedFactor();
	}

	ExitGame();

	return 0;
}

void StartGame( string level_name )
{
	atexit( ExitGame );

	if( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE ) == -1 )
	{
	printf( "Error : SDL initialistaion failed\nReason : %s", SDL_GetError() );
		exit( 0 );
	}
	
	if( SDL_InitSubSystem( SDL_INIT_JOYSTICK ) == -1 )
	{
		printf( "Warning : SDL Joystick initialistaion failed\nReason : %s", SDL_GetError() );
		pPreferences->Joy_enabled = 0;
	}

	if( SDL_InitSubSystem( SDL_INIT_AUDIO ) == -1 )
	{
		printf( "Warning : SDL Audio initialistaion failed\nReason : %s", SDL_GetError() );
		pPreferences->Sounds = 0;
		pPreferences->Music = 0;
	}	
	
	pAudio = new cAudio();
	
	pPreferences->Apply();
	
	pAudio->Init();
	
	if( pPreferences->Fullscreen )
	{
		screen = SDL_SetVideoMode( pPreferences->Screen_W, pPreferences->Screen_H, pPreferences->Bpp, SDL_SWSURFACE | SDL_HWACCEL | SDL_RLEACCEL | SDL_FULLSCREEN );
	}
	else
	{
		screen = SDL_SetVideoMode( pPreferences->Screen_W, pPreferences->Screen_H, pPreferences->Bpp, SDL_SWSURFACE | SDL_HWACCEL | SDL_RLEACCEL | SDL_DOUBLEBUF );
	}

	if( !screen )
	{
		printf( "Error : Screen mode creation failed\nReason : %s", SDL_GetError() );
		exit( 0 );
	}

	magenta = SDL_MapRGB( screen->format, 255, 0, 255 );
	std_bgcolor = SDL_MapRGB( screen->format, 150, 200, 225 );
	darkblue = SDL_MapRGB( screen->format, 0, 0, 128 );
	white = SDL_MapRGB( screen->format, 255, 255, 255 );
	grey = SDL_MapRGB( screen->format, 128, 128, 128 );
	green = SDL_MapRGB( screen->format, 0, 230, 0 );

	colorDarkBlue.r = 0;	colorDarkBlue.g = 0;	colorDarkBlue.b = 128;	// Dark Blue
	colorWhite.r = 255;		colorWhite.g = 255;		colorWhite.b = 255;		// White
	colorBlack.r = 0;		colorBlack.g = 0;		colorBlack.b = 0;		// Black
	colorBlue.r = 150;		colorBlue.g = 200;		colorBlue.b = 225;		// Blue
	colorGreen.r = 0;		colorGreen.g = 230;		colorGreen.b = 0;		// Green
	colorDarkGreen.r = 1;	colorDarkGreen.g = 119;	colorDarkGreen.b = 34;	// Dark Green
	colorMagenta.r = 255;	colorMagenta.g = 0;		colorMagenta.b = 255;	// Magenta
	colorGrey.r = 128;		colorGrey.g = 128;		colorGrey.b = 128;		// Grey
	colorRed.r = 253;		colorRed.g = 22;		colorRed.b = 12;		// Red

	SDL_ShowCursor( SDL_DISABLE );
	SDL_WM_SetCaption( CAPTION, NULL );
	
	pJoystick = new cJoystick();
	
	if( TTF_Init() == -1 ) 
	{
		printf( "Error : SDL_TTF initialisation failed\nReason : %s", SDL_GetError() );
		exit( 0 );
	}

	font = TTF_OpenFont( FONT_DIR "/bluebold.ttf", 26 );
	font_16 = TTF_OpenFont( FONT_DIR "/bluebold.ttf", 16 );
	
	if( !font || !font_16 ) 
	{
		printf( "Error : Font loading failed\n" );
		exit( 0 );
	}
	
	pPlayer = new cPlayer( 120, 0 );
	pLevel = new cLevel();
	
	LoadHudObjects();

	pMenu = new cMainMenu();

	pMouseCursor = new cMouseCursor( 20, 20 );

	pLeveleditor = new cLevelEditor();

	if( !level_name.empty() && pLevel->Load( level_name ) )
	{
		Game_Mode = MODE_LEVEL;
	}
	else
	{
		pMenu->ShowMenu();
	}

	Preload_images();
}

void ExitGame( void )
{
	if( pPreferences )
	{
		pPreferences->Save();
	}

	if( ImageFactory ) 
	{
		ImageFactory->DeleteAll();

		delete ImageFactory;
		ImageFactory = NULL;
	}
	
	if( pAudio )
	{
		delete pAudio;
		pAudio = NULL;
	}
	
	if( pPlayer )
	{
		delete pPlayer;
		pPlayer = NULL;
	}
	if( pLevel )
	{
		delete pLevel;
		pLevel = NULL;
	}

	UnloadHudObjects();
	
	if( pLeveleditor )
	{
		delete pLeveleditor;
		pLeveleditor = NULL;
	}
	
	if( pPreferences ) 
	{
		delete pPreferences;
		pPreferences = NULL;
	}

	if( pMouseCursor ) 
	{
		delete pMouseCursor;
		pMouseCursor = NULL;
	}

	if( pJoystick )
	{
		delete pJoystick;
		pJoystick = NULL;
	}
	
	if( strlen( SDL_GetError() ) > 0 )
	{
		printf( "Last known Error : %s", SDL_GetError() );
	}

	SDL_Quit();
}

void ProcessEvents( void )
{
	SDL_GetMouseState( &mouseX, &mouseY );
	
	if( UpKeyTime )
	{
		UpKeyTime--;
	}
	
	if( pPlayer->startjump )
	{
		pPlayer->StartJump();
	}
	
	if( pPlayer->start_enemyjump )
	{
		pPlayer->StartJump( 23.0, 3.2 );
	}

	while( SDL_PollEvent( &event ) )
	{
		switch( event.type )
		{
		case SDL_QUIT:
		{
			done = 1;
			break;
		}
		case SDL_JOYBUTTONDOWN:
		{
			pJoystick->Handle_Button_Event();
			break;
		}
		case SDL_JOYBUTTONUP:
		{
			pJoystick->Handle_Button_Event();
			break;
		}
		case SDL_KEYDOWN:
		{
			KeyDown( event.key.keysym.sym );
			break;
		}
		case SDL_KEYUP:
		{
			KeyUp( event.key.keysym.sym );
			break;
		}
		case SDL_MOUSEMOTION:
		{
			if( pMouseCursor->MousePressed_left )
			{
				if( Leveleditor_Mode && pMouseCursor->MouseObject ) 
				{
					pMouseCursor->MouseObject_Update();
				}
			}
			else if( Leveleditor_Mode && pMouseCursor->mover_mode ) 
			{
				pMouseCursor->Mover_Update( event.motion.xrel, event.motion.yrel );
			}

			_mouseX = mouseX;
			_mouseY = mouseY;

			break;
		}
		case SDL_MOUSEBUTTONDOWN:
		{
			if( event.button.button == 1 ) // left
			{
				if( Leveleditor_Mode ) 
				{
					pMouseCursor->MousePressed_left = 1;

					if( pMouseCursor->clickcounter ) 
					{
						pMouseCursor->Double_Click();
					}
					else
					{
						pMouseCursor->clickcounter = DESIRED_FPS*0.9;
					}
				}
			}
			else if( event.button.button == 2 ) // middle
			{
				if( Leveleditor_Mode && pMouseCursor->MouseObject ) // Activates the Fastcopy mode
				{
					pMouseCursor->fastCopyMode = 1;
				}
				else if( Leveleditor_Mode )  // The Mover mode
				{
					if( !pMouseCursor->mover_mode )
					{
						pMouseCursor->mover_mode = 1;
					}
					else
					{
						pMouseCursor->mover_mode = 0;
					}
				}
			}
			else if( event.button.button == 3 ) // right
			{
				if( Leveleditor_Mode && pMouseCursor->MouseObject && !pMouseCursor->MousePressed_left ) 
				{
					pMouseCursor->Delete();
				}

				pMouseCursor->MousePressed_right = 1;
			}

			break;
		}
		case SDL_MOUSEBUTTONUP:
		{
			if( event.button.button == 1 )
			{
				pMouseCursor->MousePressed_left = 0;
			}
			else if( event.button.button == 2 )
			{
				pMouseCursor->fastCopyMode = 0;
			}
			else if( event.button.button == 3 )
			{
				pMouseCursor->MousePressed_right = 0;
			}

			break;
		}
		case SDL_JOYAXISMOTION:
		{
			pJoystick->Handle_Events();
			break;
		}
		}// event.type switch end
	} // Pollevent end
}

void KeyUp( SDLKey key )
{
	keys = SDL_GetKeyState( NULL );
	
	if( key == pPreferences->Key_right || key == pPreferences->Key_left )
	{
		pPlayer->Hold();
	}

	else if( key == pPreferences->Key_down )
	{
		if( pPlayer->ducked )
		{
			pPlayer->posy -= pPlayer->images[0]->h - pPlayer->images[10]->h + 4;
			pPlayer->ducked = 0;
			pPlayer->state = STAYING;
		}
	}
}

void MakeScreenshot( void )
{
	char filename[20];
	int i = 0;

	while( i < 1000 )
	{
		i++;

		sprintf( filename, "screenshots/%03d.bmp" , i );
		FILE *fp = fopen( filename, "r" );

		if( !fp )
		{
			// Todo : save it as png !
			SDL_SaveBMP( screen, filename );

			string snumber;
			snumber = filename;
			snumber.erase( 0, 12 );
			snumber.erase( snumber.length() - 4, 4 );

			sprintf( debugdisplay->text, "Screenshot %s saved\n", snumber.c_str() );
			debugdisplay->counter = DESIRED_FPS*2.5;

			return;
		}
		else
		{
			fclose( fp );
		}
	}
}

void KeyDown( SDLKey key )
{
	keys = SDL_GetKeyState( NULL );

	if( key == SDLK_l )
	{
		boxRGBA( screen, 0, 0, screen->w, screen->h , 0, 0, 0, 64 );

		string levelname = EditMessageBox( "Load a new Level", "Levelname", screen->w/2 - 200, screen->h/2 - 10, 1 );

		if( levelname.length() < 2 )
		{
			return;
		}

		string levelnameout = levelname;

		if( levelname.find( ".txt" ) == string::npos ) 
		{
			levelname.insert( levelname.length(), ".txt" );
		}

		if( levelname.find( "levels/" ) == string::npos ) 
		{
			levelname.insert( 0, "levels/" );
		}
		
		if( levelnameout.length() > 5 && ( levelnameout.find( ".txt" ) == levelnameout.length() - 4 ) ) 
		{
			levelnameout.erase( levelnameout.length() - 4, levelnameout.length());
		}

		if( levelnameout.find( "levels/" ) == 0 ) 
		{
			levelnameout.erase( 0, strlen( LEVEL_DIR ) + 1 );
		}

		if( !( Game_Mode == MODE_OVERWORLD ) )
		{
			if( pLevel->Load( levelname ) )
			{
				sprintf( debugdisplay->text, "Loaded %s", levelnameout.c_str() );
				Game_Mode = MODE_LEVEL;
				debugdisplay->counter = DESIRED_FPS*2;
			}
			else
			{
				sprintf( debugdisplay->text, "Error Loading %s", levelnameout.c_str() );
				pAudio->PlaySound( SOUNDS_DIR "/error.ogg" );
				debugdisplay->counter = DESIRED_FPS*2;
			}
		}
		return;
	}

	if( key == SDLK_ESCAPE && !( Game_Mode == MODE_MENU ) )
	{
		pMenu->ShowMenu();
		return;
	}

	if( Game_Mode == MODE_LEVEL )
	{
		KeyDown_Level( key );
	}
	else if( Game_Mode == MODE_OVERWORLD )
	{
		// todo
	}
	else if( Game_Mode == MODE_MENU )
	{
		// todo
	}
}

void KeyDown_Level( SDLKey key )
{
	if( key == SDLK_d && ( event.key.keysym.mod & KMOD_LCTRL ) )
	{
		if( Game_debug ) 
		{
			sprintf( debugdisplay->text, "Game debugmode Disabled" );
			debugdisplay->counter = DESIRED_FPS * 2;
			Game_debug = 0;
		}
		else
		{
			sprintf( debugdisplay->text, "Game debugmode Enabled" );
			debugdisplay->counter = DESIRED_FPS * 2;
			Game_debug = 1;
		}
		return;
	}
	// Debug Keys only for some testing ;)
	// use F2 - F4
	else if( key == SDLK_F3 && Game_debug )
	{
		pPlayer->GotoNextLevel();
		return;
	}
	else if( key == SDLK_F4 && 1 )//Gamedebug )
	{
		//golddisplay->AddGold( 50 );
		DrawEffect( 100 );
		//AddAnimation( 50, 50, 1 );

		return;
	}
	else if( key == SDLK_F5 )
	{
		MakeScreenshot( );
		return;
	}
	else if( key == pPreferences->Key_shoot && !Leveleditor_Mode )
	{
		pPlayer->Add_Fireball();
		return;
	}
	else if( key == SDLK_RETURN && !Leveleditor_Mode )
	{
		Itembox->Request_Item();
		return;
	}
	else if( key == SDLK_s && Leveleditor_Mode )
	{
		pLevel->Save();
		return;
	}
	else if( key == SDLK_F10 )
	{
		if( pAudio->bSounds )
		{
			pAudio->StopSounds();
			sprintf( debugdisplay->text, "Sound Disabled" );
			pAudio->bSounds = 0;
		}
		else
		{
			pAudio->bSounds = 1;
			pAudio->Init();

			sprintf( debugdisplay->text, "Sound Enabled" );
		}

		pPreferences->Sounds = pAudio->bSounds;

		debugdisplay->counter = DESIRED_FPS * 2;
		return;
	}
	else if( key == SDLK_F11 )
	{
		if( pAudio->bMusic )
		{
			pAudio->PauseMusic();
			sprintf( debugdisplay->text, "Music Disabled" );
			pAudio->bMusic = 0;
		}
		else
		{
			pAudio->bMusic = 1;
			pAudio->Init();

			sprintf( debugdisplay->text, "Music Enabled" );
		}

		pPreferences->Music = pAudio->bMusic;

		debugdisplay->counter = DESIRED_FPS * 2;
		return;
	}

	else if( key == SDLK_F8 )
	{
		Leveleditor_Mode = !Leveleditor_Mode;
		
		if( Leveleditor_Mode )
		{
			if( !pLeveleditor->wMenu_Count ) 
			{
				pLeveleditor->Load_Default_Menu();
			}

			sprintf( debugdisplay->text, "Editor Mode enabled" );
		}
		else
		{
			sprintf( debugdisplay->text, "Editor Mode disabled" );
			cameraposy = (int)(pPlayer->posy - screen->h/2 );
			cameraposx = (int)(pPlayer->posx + screen->w/2 );

			pMouseCursor->mover_mode = 0;
			pMouseCursor->fastCopyMode = 0;
		}

		debugdisplay->counter = DESIRED_FPS * 2;
		pAudio->PlaySound( SOUNDS_DIR "/leveleditor.ogg" );
		
		return;
	}

	else if( keys[SDLK_g] && keys[SDLK_o] && keys[SDLK_d] && !Leveleditor_Mode )
	{
		if( pPlayer->debugmode )
		{
			pPlayer->debugmode = 0;
			sprintf( debugdisplay->text, "Funky Godmode disabled" );
		}
		else
		{
			pPlayer->debugmode = 1;
			sprintf( debugdisplay->text, "Funky Godmode enabled" );
		}
		
		debugdisplay->counter = DESIRED_FPS * 2;

		return;
	}

	else if( key == pPreferences->Key_up && !Leveleditor_Mode && !pPlayer->ducked )
	{
		UpKeyTime = 10;
		return;
	}

	else if( SDLK_j && pPlayer->debugmode )
	{
		pPlayer->StartJump();
		return;
	}
	else if( key == pPreferences->Key_down && !Leveleditor_Mode )
	{
		pPlayer->Duck();
		return;
	}
	else if( Leveleditor_Mode ) // Additional EditMode Keys
	{
		if ( key == SDLK_F1 ) 
		{
			// Todo : a leveditor help screen
		}
		else if( key == SDLK_HOME ) // new
		{
			cameraposx = 0;
			cameraposy = 0;
		}
		else if( key == SDLK_END ) // new
		{
			int new_cameraposx = 0;
			int new_cameraposy = 0;
			
			for( int i = 0;i < ActiveCount;i++ )
			{
				if ( !ActiveObjects[i] )
				{
					continue;
				}

				if( ActiveObjects[i]->type == TYPE_LEVELEXIT && new_cameraposx < (int)ActiveObjects[i]->posx )
				{
					new_cameraposx = (int)ActiveObjects[i]->posx;
					new_cameraposy = (int)ActiveObjects[i]->posy;
				}

			}

			if( new_cameraposx != 0 || new_cameraposy != 0 ) 
			{
				cameraposx = new_cameraposx - (int)( pPreferences->Screen_W/2 );
				cameraposy = new_cameraposy - (int)( pPreferences->Screen_H/2 );
			}
		}
		else if( key == SDLK_n )
		{
			cameraposx += pPreferences->Screen_W;
		}
		else if( key == SDLK_p )
		{
			cameraposx -= pPreferences->Screen_W;
		}
		// Precise Pixel-Positioning
		else if( key == SDLK_KP2 && pMouseCursor->MouseObject )
		{
			if( pMouseCursor->fastCopyMode )
			{
				if( pMouseCursor->MouseObject->StartImage ) 
				{
					pMouseCursor->Copy( pMouseCursor->MouseObject, pMouseCursor->MouseObject->posx, pMouseCursor->MouseObject->posy + pMouseCursor->MouseObject->StartImage->h );
					cameraposy += pMouseCursor->MouseObject->StartImage->h;
				}
				
			}
			else
			{
				cameraposy++;
			}
		}
		else if( key == SDLK_KP4 && pMouseCursor->MouseObject )
		{
			if( pMouseCursor->fastCopyMode )
			{
				if( pMouseCursor->MouseObject->StartImage ) 
				{
					pMouseCursor->Copy( pMouseCursor->MouseObject, pMouseCursor->MouseObject->posx - pMouseCursor->MouseObject->StartImage->w, pMouseCursor->MouseObject->posy );
					cameraposx -= pMouseCursor->MouseObject->StartImage->w;	
				}
			}
			else
			{
				cameraposx--;
			}
		}
		else if( key == SDLK_KP6 && pMouseCursor->MouseObject )
		{
			if( pMouseCursor->fastCopyMode )
			{
				if( pMouseCursor->MouseObject->StartImage ) 
				{
					pMouseCursor->Copy( pMouseCursor->MouseObject, pMouseCursor->MouseObject->posx + pMouseCursor->MouseObject->StartImage->w, pMouseCursor->MouseObject->posy );
					cameraposx += pMouseCursor->MouseObject->StartImage->w;
				}
			}
			else
			{
				cameraposx++;
			}
		}
		else if( key == SDLK_KP8 && pMouseCursor->MouseObject )
		{
			if( pMouseCursor->fastCopyMode )
			{
				if( pMouseCursor->MouseObject->StartImage ) 
				{
					pMouseCursor->Copy( pMouseCursor->MouseObject, pMouseCursor->MouseObject->posx, pMouseCursor->MouseObject->posy - pMouseCursor->MouseObject->StartImage->h );
					cameraposy -= pMouseCursor->MouseObject->StartImage->h;
				}
			}
			else
			{
				cameraposy--;
			}
		}
		else if( key == SDLK_m && pMouseCursor->MouseObject )	// modify Passive/Massive/Halfmassive
		{
			int Index = -1;

			if( pMouseCursor->iCollisionType == 5 )	// from Passive to Massive
			{
				for( int i = 0; i < PassiveCount; i++ )
				{
					if( PassiveObjects[i] && ( PassiveObjects[i]->ID == pMouseCursor->MouseObject->ID ) )
					{
						Index = i;
					}
				}
				
				if( Index == -1 )
				{
					return;
				}

				pMouseCursor->MouseObject->massive = 1;
				AddMassiveObject( PassiveObjects[Index] ) ;
				PassiveObjects[Index] = NULL;
			}
			else if( pMouseCursor->iCollisionType == 1 && !pMouseCursor->MouseObject->halfmassive )	// From Massive to Halfmassive
			{
				for( int i = 0; i < MassiveCount;i++ )
				{
					if( MassiveObjects[i] && ( MassiveObjects[i]->ID == pMouseCursor->MouseObject->ID ) )
					{
						Index = i;
					}
				}
				if( Index == -1 ) 
				{
					return;
				}
				
				pMouseCursor->MouseObject->halfmassive = 1;
				pMouseCursor->MouseObject->massive = 0;
				pMouseCursor->MouseObject->type = TYPE_HALFMASSIVE;
				AddActiveObject( MassiveObjects[Index] ) ;
				MassiveObjects[Index] = NULL;
			}
			else if( pMouseCursor->MouseObject->type == TYPE_HALFMASSIVE )	// From Halfmassive to Passive
			{
				for( int i = 0; i < ActiveCount; i++ )
				{
					if( ActiveObjects[i] && ( ActiveObjects[i]->ID == pMouseCursor->MouseObject->ID ) )
					{
						Index = i;
					}
				}
				
				if( Index == -1 )
				{
					return;
				}

				pMouseCursor->MouseObject->massive = 0;
				pMouseCursor->MouseObject->halfmassive = 0;
				pMouseCursor->MouseObject->type = TYPE_SPRITE;
				AddPassiveObject( ActiveObjects[Index] ) ;
				ActiveObjects[Index] = NULL;
			}

			pMouseCursor->MouseObject = NULL;
			
			return;
		}
		else if( key == SDLK_c && ( event.key.keysym.mod & KMOD_LCTRL ) && Leveleditor_Mode ) // Copy an Sprite
		{
			if( pMouseCursor->MouseObject )
			{
				pMouseCursor->CopyObject = pMouseCursor->MouseObject;
			}
		}
		else if( key == SDLK_v && ( event.key.keysym.mod & KMOD_LCTRL ) && Leveleditor_Mode ) // Paste an Sprite
		{
			if( pMouseCursor->CopyObject )
			{
				pMouseCursor->Copy( pMouseCursor->CopyObject, pMouseCursor->posx, pMouseCursor->posy );
				pMouseCursor->mouse_H = pMouseCursor->CopyObject->rect.h/2;
				pMouseCursor->mouse_W = pMouseCursor->CopyObject->rect.w/2;
			}
		}
	}
}

void ProcessInput( void )
{
	keys = SDL_GetKeyState( NULL );
	
	// Drag Delete
	if( ( keys[SDLK_RCTRL] || keys[SDLK_LCTRL] ) && pMouseCursor->MousePressed_right && !pMouseCursor->CollsionCheck( pMouseCursor->posx, pMouseCursor->posy ) ) 
	{
		pMouseCursor->Delete();
	}

	// Camera Movement
	if( keys[pPreferences->Key_right] || ( pJoystick->right && pPreferences->Joy_enabled ) )
	{
		if( !Leveleditor_Mode )
		{
			pPlayer->direction = RIGHT;
		}
		else
		{
			cameraposx += (int)(CAMERASPEED * Framerate.speedfactor);
		}
	}
	else if( keys[pPreferences->Key_left] || ( pJoystick->left && pPreferences->Joy_enabled ) )
	{
		if( !Leveleditor_Mode )
		{
			pPlayer->direction = LEFT;
		}
		else
		{
			cameraposx -= (int)( CAMERASPEED * Framerate.speedfactor );
		}
	}

	if( keys[pPreferences->Key_up] || ( ( pJoystick->up || pJoystick->Button( pPreferences->Joy_jump ) ) && pPreferences->Joy_enabled ) )
	{
		if( !Leveleditor_Mode )
		{
			if(UpKeyTime && pPlayer->onGround && pPlayer->state != JUMPING && pPlayer->state != FALLING)
			{
				pPlayer->startjump = 1;
			}
		}
		else
		{
			cameraposy -= (int)(CAMERASPEED * Framerate.speedfactor);
		}
	}

	if( keys[pPreferences->Key_down] || ( pJoystick->down && pPreferences->Joy_enabled ) )
	{
		if( !Leveleditor_Mode )
		{
			if( pPlayer->onGround == 1 ) 
			{
				if( !pPlayer->ducked ) 
				{
					pPlayer->Duck();
				}
			}
			else if( pPlayer->onGround == 2 )
			{
				pPlayer->state = FALLING;
				pPlayer->posy += 1;
			}
		}
		else
		{
			cameraposy += (int)(CAMERASPEED * Framerate.speedfactor);
		}
	}

	if( Leveleditor_Mode && ( ( keys[pPreferences->Key_down] || keys[pPreferences->Key_up] || keys[pPreferences->Key_left] || 
		keys[pPreferences->Key_right] ) || ( pJoystick->down || pJoystick->up || pJoystick->left || pJoystick->right && pPreferences->Joy_enabled ) ) )
	{
		if( pMouseCursor->MousePressed_left && pMouseCursor->MouseObject )
		{
			pMouseCursor->MouseObject->startposx = (((int)pMouseCursor->posx) - pMouseCursor->mouse_W );
			pMouseCursor->MouseObject->startposy = (((int)pMouseCursor->posy) - pMouseCursor->mouse_H );
			
			if( pMouseCursor->MouseObject->type != TYPE_PLAYER ) 
			{
				pMouseCursor->MouseObject->posx = (((int)pMouseCursor->posx) - pMouseCursor->mouse_W );
				pMouseCursor->MouseObject->posy = (((int)pMouseCursor->posy) - pMouseCursor->mouse_H );
			}
		}
	}
}

void UpdateGame( void )
{
	if( !MassiveCount && !ActiveCount && pLevel->Levelfile.length() < 4 ) // If no Level is loaded enter the Overworld
	{
		pOverWorld->Enter();
	}

	pAudio->ResumeMusic();
	pAudio->Update();

	SDL_FillRect( screen, NULL, pLevel->background_color );

	pLevel->Draw();
	pPlayer->Update();

	UpdateDialogs();

	debugdisplay->GameDebugDraw();
	
	pMouseCursor->Update_Doubleclick();

	if( Leveleditor_Mode )
	{
		pLeveleditor->Draw( screen );

		pMouseCursor->Update_Position();
		pMouseCursor->MouseObject_Update();
		pMouseCursor->Update();
	}

	SDL_Flip( screen );	// Double Buffering

	_cameraposx = cameraposx;
	_cameraposy = cameraposy;
}
