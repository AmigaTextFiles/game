/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include "MoleInvasion.h"
#include "level_file.h"
#include "editor_texts.h"

#ifdef __MORPHOS__
char version_tag[] = "$VER: MIEditor 0.1 (26.09.2006)";
#endif

int mousex,mousey,show_FPS;

/* moves */
char key_up=0, key_down=0, key_left=0, key_right=0;
/* for sprites */
char sprite_add=0, sprite_del=0;

/* fichier de travail */
char level_file_name[128];

myList * tiles_tab;
unsigned int tile_position;

myList * level_tab;
unsigned int level_position;

level_info level_infos;
		
# define X_LIMITE	100
# define TILES_SPACE	2	

void how_to_use(int exit_code)
{
	printf("\n");
	printf("\tEditor-0.1\n");
	printf("\t-----------\n");
	printf("\n");
	printf("\t-f       => fullscreen mode (during play, 'f' toggles fullscreen)\n");
	printf("\t-h       => this tiny help\n");
	printf("\t-fps     => print FPS on tty\n");
	printf("\t-bpp=X   => set BPP (8,16,24,32) same as current X by default\n");
	printf("\tfile_name=> full file name for both reading and writing\n");
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

void init()
{	unsigned int i, newPosY;
	mySprite sprite;
	
	/* tiles vide au début */
	tiles_tab=InitList();

	/* on charge les tiles possibles */
	newPosY=0;
	for(i=0;i<GetNumberOfSprites();i++)
	{	LoadSprite(&sprite,GetIdOfPos(i));
		sprite.posX=X_LIMITE/2 - sprite.image->w/2;
		sprite.posY=newPosY;
		sprite.etat=ETAT_VISIBLE;
		AddToList(tiles_tab,&sprite,sizeof(mySprite));
		newPosY+=sprite.image->h+TILES_SPACE;
	}
	/* on les charge une deuxième fois pour permettre une liste visuelle sans fin */
	for(i=0;i<GetNumberOfSprites();i++)
	{	LoadSprite(&sprite,GetIdOfPos(i));
		sprite.posX=X_LIMITE/2 - sprite.image->w/2;
		sprite.posY=newPosY;
		sprite.etat=ETAT_VISIBLE;
		AddToList(tiles_tab,&sprite,sizeof(mySprite));
		newPosY+=sprite.image->h+TILES_SPACE;
	}

	tile_position=0;
	
	/* level vide au début */
	level_tab=InitList();
}

void perform_mouse_motion(mousex,mousey)
{	int x,y; 
	mySprite *sprite;
	mySprite disp_sprite;

	if(mousex < X_LIMITE || mousey > 17*32)
		return;
	
	/* on détermine l'emplacement correspondant */
	x=(int)((mousex-X_LIMITE)/32);
	y=(int)(mousey/32);
	
	sprite=GetPosList(tiles_tab,tile_position);
	
	disp_sprite.image=sprite->image;
	disp_sprite.posX=x*32+X_LIMITE;
	disp_sprite.posY=y*32;
	disp_sprite.etat=ETAT_VISIBLE;
	displaySprite(disp_sprite,g_SDL_screen,0,0);
}

void perform_mouse_add(mousex,mousey)
{	int x,y;
	mySprite *sprite;
	mySprite disp_sprite;
	unsigned int i;

	if(mousex < X_LIMITE || mousey > 17*32)
		return;
		
	/* on pose un sprite */
	
	/* on détermine l'emplacement correspondant */
	x=(int)((mousex-X_LIMITE)/32);
	y=(int)(mousey/32);
	
	sprite=GetPosList(tiles_tab,tile_position);
	disp_sprite=*sprite;
	disp_sprite.posX=x*32 + level_position*32;
	disp_sprite.posY=y*32;
	disp_sprite.etat=ETAT_VISIBLE;
	
	/* on supprime les éventuels sprites déjà à cette position */
	i=0;
	while(i<level_tab->size)
	{	sprite=GetPosList(level_tab,i);
		if(sprite->posX == disp_sprite.posX && sprite->posY == disp_sprite.posY)
			RemoveFromList(level_tab,i);
		i++;
	}
	
	AddToList(level_tab,&disp_sprite,sizeof(mySprite));
}

void perform_mouse_del(mousex,mousey)
{	int x,y;
	mySprite *sprite;
	unsigned int i;

	if(mousex < X_LIMITE || mousey > 17*32)
		return;
		
	/* on supprime un sprite */
	
	/* on détermine l'emplacement correspondant */
	x=(int)((mousex-X_LIMITE)/32);
	y=(int)(mousey/32);
	x=x*32 + level_position*32;
	y=y*32;

	i=0;
	while(i<level_tab->size)
	{	sprite=GetPosList(level_tab,i);
		if(sprite->posX == x && sprite->posY == y)
			RemoveFromList(level_tab,i);
		i++;
	}
}

void display_tiles()
{	unsigned int i,decalY;
	mySprite * sprite;
	SDL_Rect rect;
	Uint32 col;

	/* rectangle gris */
	rect.x=0;rect.y=0;
	rect.w=X_LIMITE;
	rect.h=g_SDL_screen->h;
	col=SDL_MapRGB(g_SDL_screen->format,100,100,100);
	SDL_FillRect(g_SDL_screen,&rect,col);
	
	/* le décalage fait l'ensemble des tailles des sprites passés */
	decalY=0;
	for(i=0;i<tile_position;i++)
	{	sprite=GetPosList(tiles_tab,i);
		decalY+=sprite->image->h+TILES_SPACE;
	}
	
	/* rectangle rouge */
	rect.x=0;rect.y=0;
	rect.w=X_LIMITE;
	sprite=GetPosList(tiles_tab,i);
	rect.h=sprite->image->h;
	col=SDL_MapRGB(g_SDL_screen->format,255,10,100);
	SDL_FillRect(g_SDL_screen,&rect,col);
	
	/* dessine les tiles à gauche */
	for(i=0;i<tiles_tab->size;i++)
	{	sprite=GetPosList(tiles_tab,i);
		displaySprite(*sprite,g_SDL_screen,0,-decalY);
	}
}

void display_level()
{	int i;
	mySprite * sprite;
	
	/* dessine le niveau à droite */
	for(i=0;i<level_tab->size;i++)
	{	sprite=GetPosList(level_tab,i);
		displaySprite(*sprite,g_SDL_screen,-level_position*32+X_LIMITE,0);
	}
}

static void quitandsave( int code )
{	
	if( strlen(level_file_name)>0 && wantToSave(level_file_name))
	{	while(1)
		{	if(confirmToSave(level_infos))
			{	if(save_levelfile(level_file_name,level_tab,level_infos) == 0)
				{	simpleMessage("[DONE]");
					break;
				}
				else
				{	simpleMessage("[PROBLEM]");
				}
			}
			else
				break;
		}
	}
	SDL_Quit();
	quit( code );
}

void scroll_sprite(char up,char from_mouse_roll)
{	static Uint32 last_scroll=0;

	/* 10 défilements par seconde avec le clavier */
	if(!from_mouse_roll)
		if(SDL_GetTicks()-last_scroll<100)
			return;
	last_scroll=SDL_GetTicks();

	if(up>0)
	{	if(tile_position)
			tile_position--;
		else
			tile_position=GetNumberOfSprites()-1;
	}
	else
	{	tile_position++;
    		if(tile_position>=GetNumberOfSprites())
			tile_position=0;
	}
}

static void handle_key( SDL_keysym* keysym, int down )
{
	switch( keysym->sym )
	{case SDLK_ESCAPE:  quitandsave( 0 );	break;
	case SDLK_LEFT:     key_left=down;	break;
	case SDLK_RIGHT:    key_right=down;	break;
	case SDLK_UP:	    key_up=down;	break;
	case SDLK_DOWN:     key_down=down;	break;
	case SDLK_f:	    if(down)
				SDL_WM_ToggleFullScreen(g_SDL_screen);
			    break;
	default: break;
	}
}

static void process_events( void )
{	SDL_Event event;
	while( SDL_PollEvent( &event ) )
	{	switch( event.type )
		{case SDL_KEYDOWN:	handle_key( &event.key.keysym,1 );	break;
		case SDL_KEYUP:		handle_key( &event.key.keysym,0 );	break;
		case SDL_MOUSEMOTION:	SDL_GetMouseState(&mousex, &mousey);	break;
        	case SDL_QUIT:		quitandsave( 0 );	break;
		case SDL_MOUSEBUTTONDOWN:
			switch(event.button.button)
			{case SDL_BUTTON_LEFT    :sprite_add=1;		break;
			case SDL_BUTTON_RIGHT    :sprite_del=1;		break;
#ifdef SDL_BUTTON_WHEELUP
			case SDL_BUTTON_WHEELUP  :scroll_sprite( 1,1);	break;
			case SDL_BUTTON_WHEELDOWN:scroll_sprite(-1,1);	break;
#endif
			}
			break;
		case SDL_MOUSEBUTTONUP:
			switch(event.button.button)
			{case SDL_BUTTON_LEFT    :sprite_add=0;		break;
			case SDL_BUTTON_RIGHT    :sprite_del=0;		break;
			}
			break;
        	}
	}
	if(key_up)
		scroll_sprite( 1,0);
	if(key_down)
		scroll_sprite(-1,0);
	if(key_left)
		if(level_position)level_position--;
	if(key_right)
		level_position++;
	if(sprite_add)
		perform_mouse_add(mousex,mousey);
	if(sprite_del)
		perform_mouse_del(mousex,mousey);
}

int main( int argc, char** argv )
{
	/* Information about the current video settings. */
	const SDL_VideoInfo* info = NULL;
	/* Color depth in bits of our window. */
	Uint8 fullscreen;
	unsigned int bpp;
	Uint32 i,flags;
	
	myList *level_sprites=NULL, *level_fg=NULL;

	/* defaults args */
	fullscreen = show_FPS = bpp = 0;
	strcpy(level_file_name,"lvl/default.lvl");

	/* on se place dans le repertoire des datas */
	if(chdir(DATADIR))
		chdir("../");

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
		else /* filename */
		{	strcpy(level_file_name,(char*)(argv[i]));
			printf("level_file_name=>%s\n",level_file_name);
		}
	}

	/* First, initialize SDL's video subsystem. */
	if( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE | SDL_INIT_TIMER) < 0 ) 
	{	fprintf( stderr, "Video initialization failed: %s\n", SDL_GetError( ) );
		quit( 1 );
	}

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

	/* initialisation */
	load_levelinfos(level_file_name,&level_infos);
	init_all_images(level_infos.wall_gfx_dir,EDITOR_MODE);
	init();
	if(load_levelfile(level_file_name,&level_tab,&level_sprites,&level_fg))
	{	fprintf(stderr,"Error on load_levelfile '%s'!\n",level_file_name);
	}
	else
	{	for(i=0;i<level_sprites->size;i++)
		{	mySprite* current=(mySprite*)GetPosList(level_sprites,i);
			AddToList(level_tab,current,sizeof(mySprite));
		}
		FreeList(level_sprites);
		for(i=0;i<level_fg->size;i++)
		{	mySprite* current=(mySprite*)GetPosList(level_fg,i);
			AddToList(level_tab,current,sizeof(mySprite));
		}
		FreeList(level_fg);
	}
	
	while( 1 ) {
		static Uint32 last_time=0;
		
		coef_frame_rate(show_FPS);
		
		/* drawing */
		SDL_FillRect(g_SDL_screen, NULL, SDL_MapRGB(g_SDL_screen->format, 0,0,0));
		process_events();
		display_level();
		display_tiles();
		
		perform_mouse_motion(mousex,mousey);
		
		/* envoi au hard */
		SDL_Flip(g_SDL_screen);
		
		/* on bloque à 30 FPS soit 33ms/frame en déchargeant le CPU */
		while(SDL_GetTicks()-last_time< 3)SDL_Delay(21);
		while(SDL_GetTicks()-last_time<13)SDL_Delay(11);
		while(SDL_GetTicks()-last_time<23)SDL_Delay(1);
		while(SDL_GetTicks()-last_time<33);
		last_time=SDL_GetTicks();
	}

	return 0;
}
