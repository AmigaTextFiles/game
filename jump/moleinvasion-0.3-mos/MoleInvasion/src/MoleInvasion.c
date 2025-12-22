/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include <unistd.h>

#include "MoleInvasion.h"
#include "worldmap.h"
#include "menu.h"

#ifdef __MORPHOS__
char version_tag[] = "$VER: MoleInvasion 0.3 (26.09.2006)";
#endif

void how_to_use(int exit_code)
{
	printf("\n");
	printf("\tMoleInvasion\n");
	printf("\t------------\n");
	printf("\n");
	printf("\t-f       => fullscreen mode (during play, 'f' toggles fullscreen)\n");
	printf("\t-h       => this tiny help\n");
	printf("\t-fps     => print FPS on tty\n");
	printf("\t-bpp=X   => set BPP (8,16,24,32) same as current X by default\n");
	printf("\t-nomusic => desactive the musics\n");
	printf("\t-nosound => desactive sounds effects\n");
	printf("\tfile_name=> full file name for reading specific level\n");
	printf("\n");
	printf("\tTry F1, F2 and F3 to change graphics behaviour ...");
	printf("\n");
	printf("\tMoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)\n");
	printf("\n");
	printf("\tThis program is free software; you can redistribute it and/or modify\n");
	printf("\tit under the terms of the GNU General Public License as published by\n");
	printf("\tthe Free Software Foundation; either version 2 of the License, or\n");
	printf("\t(at your option) any later version.\n");
	printf("\n");
	printf("\tThis program is distributed in the hope that it will be useful,\n");
	printf("\tbut WITHOUT ANY WARRANTY; without even the implied warranty of\n");
	printf("\tMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n");
	printf("\tGNU General Public License for more details.\n");
	printf("\n");
	printf("\tYou should have received a copy of the GNU General Public License\n");
	printf("\talong with this program; if not, write to the Free Software\n");
	printf("\tFoundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.\n");
	printf("\n");
	exit(exit_code);
}

int main( int argc, char** argv )
{	
	mySprite text;
	
	/* Information about the current video settings. */
	const SDL_VideoInfo* info = NULL;

	/* Color depth in bits of our window. */
	Uint8 i,fullscreen,show_FPS,debug_level;
	unsigned int bpp;
	Uint32 flags;

	/* fichier de travail */
	char *world_file_name;

	/* on se place dans le repertoire des datas */
	if(chdir(DATADIR))
		chdir("../");
/*	{char *dir_name;
	dir_name=get_current_dir_name();
	printf("DATADIR is %s\n", dir_name);
	free(dir_name);}*/

	/* defaults args */
	fullscreen = show_FPS = bpp = debug_level = 0;

	for(i=1;i<argc;i++)
	{	/* fullscreen */
		if(strcmp(argv[i],"-f")==0)
		{	fullscreen=1;
		}
		else /* FPS */
		if(strcmp(argv[i],"-fps")==0)
		{	show_FPS=1;
		}
		else /* help */
		if(strcmp(argv[i],"-h")==0)
		{	how_to_use(0);
		}
		else /* bpp */
		if(strncmp(argv[i],"-bpp=",5)==0)
		{	sscanf((char*)(argv[i]+5),"%d",&bpp);
			if(bpp != 8 && bpp != 16 && bpp != 24 && bpp != 32)
				how_to_use(0);
		}
		else /* nomusic */
		if(strcmp(argv[i],"-nomusic")==0)
		{	g_activate_music=0;
		}
		else /* nosound */
		if(strcmp(argv[i],"-nosound")==0)
		{	g_activate_sound=0;
		}
		else /* filename */
		{	world_file_name=(char*)(argv[i]);
			printf("world_file_name=>%s\n",world_file_name);
			debug_level=1;
		}
	}

	/* First, initialize SDL's video subsystem. */
	if( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE | SDL_INIT_TIMER ) < 0 ) 
	{	fprintf( stderr, "Video initialization failed: %s\n", SDL_GetError( ) );
		quit( 1 );
	}

	if(SDL_InitSubSystem(SDL_INIT_JOYSTICK) < 0 ) 
		fprintf( stderr, "No joystick support" );
	
	/* Let's get some video information. */
	info = SDL_GetVideoInfo( );
	if( !info ) 
	{	fprintf( stderr, "Video query failed: %s\n", SDL_GetError( ) );
		quit( 1 );
	}
	
	if(!bpp)
		bpp=info->vfmt->BitsPerPixel;

	flags=SDL_DOUBLEBUF | SDL_HWSURFACE;
	if(fullscreen)
		flags|= SDL_FULLSCREEN ;
	g_SDL_screen = SDL_SetVideoMode( 800, 600, bpp, flags);
	if( g_SDL_screen == 0 )
	{	fprintf( stderr, "Video mode set failed: %s\n", SDL_GetError( ) );
		quit( 1 );
	}
	else
		printf("Video mode set to %ux%u at %u bpp\n",800, 600, bpp);

	/* on enlève le curseur souris */
	SDL_ShowCursor(0);
	
	/* recuperation de la configuration sauvegardee */
	load_keyconfig();
	
	/* on ne lance que le niveau réclamé en option */
	if(debug_level)
	{	int ret=main_level(world_file_name,show_FPS);
		printf("ret=%d\n",ret);
	}
	else
		while(1)
		{	int ret,action=1;
			mySprite * background;

			/* font initialisation */
			{SDL_Color myText_fg={255,255,255};
			SDL_Color myText_bg={255,20,20};
			font_select(FONT_NAME,40,myText_bg,myText_fg,180);
			}
			text=font_long_text("[MAIN]",0,0);
			text.posY=40;
			text.posX=g_SDL_screen->w/2 - text.image->w/2;

			background=draw_backgrnd(DO_INIT,"gfx/ihm/accueil.jpg");

			/* ré-init des évènements */
			events_init();
			
			/* music */
			startTheMusic("snd/09-Partir.ogg");
	
			while(!any_event_found())
			{	all_events_status events;
	
				draw_backgrnd(DO_DRAW,background);
				displaySprite(text,g_SDL_screen,0,0);
				coef_frame_rate(show_FPS);
				SDL_Flip(g_SDL_screen);
				events=events_get_all();	
				if(events.f_kp)
					SDL_WM_ToggleFullScreen(g_SDL_screen);
				if(events.quit || events.esc)
				{	action=2;
					printf("IN ESC!\n");
				}
			}
			draw_backgrnd(DO_FREE,background);
			if(action==2)
				break;
			
			if(main_menu(show_FPS,&world_file_name) == 2)
				break;

			ret=main_worlmap(world_file_name,show_FPS);
			printf("ret=%d\n",ret);
		}
	/* fin */
	quit(0);
	return 0;
}
