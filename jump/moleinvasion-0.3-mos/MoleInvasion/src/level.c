/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#define MAIN_LEVEL
#include "level.h"
#include "font.h"
#include "events.h"
#include "worldmap.h"

/* used for init the graphics functions */
#define DO_INIT	0
#define DO_DRAW 1
#define DO_FREE 2

/* booleans */
char g_display_background=1;
char g_display_foreground=1;
char g_display_map_only=0;
char g_display_map_on_it=0;
char g_display_map_behind_it=0;

/*****/

/* return non-nul if esc pressed */
int process_level_events( mySprite * player )
{	all_events_status events;

	events=events_get_all();

	player->goleft=events.left;
	player->goright=events.right;
	player->gojump=events.jump_kp;
	player->rebounce=events.jump;
	player->acceleration=events.accel;

	player->action=events.special_kp;

	if(events.F1_kp)
		g_display_background=!g_display_background;
	if(events.F2_kp)
		g_display_foreground=!g_display_foreground;
	if(events.F3_kp)
	{	if(g_display_map_only)
		{	g_display_map_on_it=1;g_display_map_only=0;		}
		else if(g_display_map_on_it)
		{	g_display_map_behind_it=1;g_display_map_on_it=0;	}
		else if(g_display_map_behind_it)
		{	g_display_map_behind_it=0;	}
		else
			g_display_map_only=1;
	}

	if(events.quit)
		quit(0);
	if(events.esc)
		return 1;
	if(events.f_kp)
		SDL_WM_ToggleFullScreen(g_SDL_screen);
	if(events.p_kp)
	{	if(static_level_datas.pause)
			static_level_datas.pause=0;
		else
			static_level_datas.pause=1;
	}
	return 0;
}

/* retours: 0:en cours, 1:mort, 2:gagnant */
int manage_sprites(myList * level_walls,myList * level_sprites, long decalX, long decalY)
{	int i;

	/* gestion des éléments graphiques */
	for(i=0;i<level_sprites->size;i++)
	{	mySprite* current=(mySprite*)GetPosList(level_sprites,i);
		if(current->sprite_management_type == SPRITE_PLAYER)
		{	performPlayer(current,level_walls,level_sprites);
		}
		else if(current->sprite_management_type > SPRITE_PLAYER)
		{	/* on ne gère que les ennemis visibles suffisament proches de PLAYER */
			if( current->etat & ETAT_VISIBLE
			 && current->posX + decalX < (800+20)
			 && current->posX + decalX > (-current->map->w-20) )
				performOther(current,level_walls,level_sprites);
		}
	}

	/* etat mort */
	if( ! (static_level_datas.global_player->etat & ETAT_VIVANT ))
		return 1;

	/* etat gagnant */
	if(static_level_datas.global_player->etat & ETAT_GAGNANT)
		return 2;

	/* jeu en cours */
	return 0;
}

void draw_background(char action, level_info infos, long decalX, long decalY)
{	static mySprite backgrnd;

	if(action==DO_DRAW)
	{	if(backgrnd.image && g_display_background)
		{	long decX,decY;
			
			/* scrolling différentiel */
			decX=decalX>>1;
			decY=decalY>>1;
	
			/* repetition * 2 */
			while(-decX>=backgrnd.image->w)
				decX += backgrnd.image->w;
	
			/* fond d'écran */
			displaySprite(backgrnd,g_SDL_screen,decX,decY);
			if(decX+backgrnd.image->w<g_SDL_screen->w)
				displaySprite(backgrnd,g_SDL_screen,decX+backgrnd.image->w,decY);
		}
		else
			SDL_FillRect(g_SDL_screen, NULL, SDL_MapRGB(g_SDL_screen->format, 0, 0, 0));
	}
	else if(action==DO_INIT)
	{	backgrnd.image=NULL;
		if(strlen(infos.background)>0)
		{	backgrnd.image=IMG_LoadOptNone(infos.background);
			backgrnd.posX=0;
			backgrnd.posY=0;
			backgrnd.etat=ETAT_VISIBLE;
		}
	}
	else if(action==DO_FREE)
	{	if(strlen(infos.background)>0)
		{	SDL_FreeSurface(backgrnd.image);
		}
	}
}

int displaySpriteOrMap( mySprite sprite, SDL_Surface* screen, long decalX, long decalY)
{	if(g_display_map_only)
	{	return displaySpriteMap(sprite, screen, decalX, decalY);
	}
	else if(g_display_map_on_it)
	{	displaySprite(sprite, screen, decalX, decalY);
		return displaySpriteMap(sprite, screen, decalX, decalY);
	}
	else if(g_display_map_behind_it)
	{	displaySpriteMap(sprite, screen, decalX, decalY);
		return displaySprite(sprite, screen, decalX, decalY);
	}
	else
	{	return displaySprite(sprite, screen, decalX, decalY);
	}
}

void switchSprites(myList * level_walls,myList * level)
{	unsigned int i;
	mySprite* current;
	
	/* on bascule toutes les gold_box(88) en coins(83) et réciproque */
	for(i=0;i<level->size;i++)
	{	current=(mySprite*)GetPosList(level,i);
		if(current -> id == 88)
			changeSpriteToId(current,83,level_walls,level,0);
		else if(current -> id == 83)
			changeSpriteToId(current,88,level_walls,level,0);
	}
}

void draw_list_to_screen(myList * listofsprites, long decalX, long decalY, char ordered_list)
{	unsigned int i,j;
	mySprite* current;
	int nb=0;

	/* positionnement des éléments graphiques */
	if(ordered_list)
	{	giveOrderedListPlage(&i,listofsprites, -decalX);
		for(j=i;j<listofsprites->size;j++)
		{	current=(mySprite*)GetPosList(listofsprites,j);
			/* fin de la partie triée intéressante */
			if( current->posX > g_SDL_screen->w - decalX)
				break;
			displaySpriteOrMap(*current,g_SDL_screen,decalX,decalY);
			nb++;
		}
//		printf("dessin de %d sprites triés\n",nb);
	}
	else
	{	for(i=0;i<listofsprites->size;i++)
			displaySpriteOrMap(*((mySprite*)GetPosList(listofsprites,i)),g_SDL_screen,decalX,decalY);
	}
}

void draw_foreground(char action, level_info infos, long decalX, long decalY)
{	
	static mySprite nuages[4];
	static mySprite rain,storm;static int storm_lenght;
	static mySprite night;

	switch(infos.foreground)
	{case FRGRND_CLOUDS:
		if(action==DO_DRAW && g_display_foreground)
		{	int i;
			for(i=0;i<4;i++)
			{	if(nuages[i].posX<static_level_datas.global_player->posX-g_SDL_screen->w)
				{	nuages[i].posX=rand()%g_SDL_screen->w+g_SDL_screen->w+static_level_datas.global_player->posX;
					nuages[i].posY=rand()%g_SDL_screen->h-nuages[i].image->h+50;
					nuages[i].horizontal_speed=rand()%5+1;
				}
				nuages[i].posX-=nuages[i].horizontal_speed;
				displaySprite(nuages[i],g_SDL_screen,decalX,decalY);
			}
		}
		else if(action==DO_INIT)
		{	nuages[0].image=IMG_LoadOptAlpha("./gfx/nuage1.png");
			nuages[0].etat=ETAT_VISIBLE;
			nuages[0].posX=nuages[0].posY=-g_SDL_screen->w;
			nuages[1].image=IMG_LoadOptAlpha("./gfx/nuage2.png");
			nuages[1].etat=ETAT_VISIBLE;
			nuages[1].posX=nuages[1].posY=-g_SDL_screen->w;
			nuages[2].image=nuages[0].image;
			nuages[2].etat=ETAT_VISIBLE;
			nuages[2].posX=nuages[2].posY=-g_SDL_screen->w;
			nuages[3].image=nuages[1].image;
			nuages[3].etat=ETAT_VISIBLE;
			nuages[3].posX=nuages[3].posY=-g_SDL_screen->w;
		}
		else if(action==DO_FREE)
		{	SDL_FreeSurface(nuages[0].image);
			SDL_FreeSurface(nuages[1].image);
		}
		break;
	case FRGRND_RAIN:
		if(action==DO_DRAW && g_display_foreground)
		{	displaySprite(rain,g_SDL_screen,-(rand()%20),-(rand()%40));
			if(rand()%150==0)
				storm_lenght=10;
			if(storm_lenght)
			{	displaySprite(storm,g_SDL_screen,0,0);
				if(storm_lenght--==10)
					startTheSound("snd/storm.wav");
			}
		}
		else if(action==DO_INIT)
		{	SDL_Surface * SDL_tile = SDL_CreateRGBSurface(g_SDL_screen->flags,
					g_SDL_screen->w, g_SDL_screen->h,
					g_SDL_screen->format->BitsPerPixel,
					g_SDL_screen->format->Rmask, g_SDL_screen->format->Gmask,
					g_SDL_screen->format->Bmask, g_SDL_screen->format->Amask);
			
			SDL_FillRect(SDL_tile, NULL, SDL_MapRGB(g_SDL_screen->format, 255, 255, 255));
			SDL_SetAlpha(SDL_tile, SDL_SRCALPHA   |SDL_RLEACCEL, 128);
			storm.image=SDL_DisplayFormatAlpha(SDL_tile);
			SDL_FreeSurface(SDL_tile);
			storm.etat=ETAT_VISIBLE;
			storm.posX=0;
			storm.posY=0;
			rain.image=IMG_LoadOptAlpha("./gfx/rain.png");
			rain.etat=ETAT_VISIBLE;
			rain.posX=0;
			rain.posY=0;
			storm_lenght=0;
		}
		else if(action==DO_FREE)
		{	SDL_FreeSurface(rain.image);
			SDL_FreeSurface(storm.image);
		}
		break;
	case FRGRND_NIGHT:
		if(action==DO_DRAW && g_display_foreground)
		{	displaySprite(night,g_SDL_screen,0,0);
		}
		else if(action==DO_INIT)
		{	SDL_Surface * SDL_tile = SDL_CreateRGBSurface(g_SDL_screen->flags,
					g_SDL_screen->w, g_SDL_screen->h,
					g_SDL_screen->format->BitsPerPixel,
					g_SDL_screen->format->Rmask, g_SDL_screen->format->Gmask,
					g_SDL_screen->format->Bmask, g_SDL_screen->format->Amask);
			
			SDL_FillRect(SDL_tile, NULL, SDL_MapRGB(g_SDL_screen->format, 0, 0, 255));
			SDL_SetAlpha(SDL_tile, SDL_SRCALPHA   |SDL_RLEACCEL, 64);
			night.image=SDL_DisplayFormatAlpha(SDL_tile);
			SDL_FreeSurface(SDL_tile);
			night.etat=ETAT_VISIBLE;
			night.posX=0;
			night.posY=0;
		}
		else if(action==DO_FREE)
		{	SDL_FreeSurface(night.image);
		}
		break;
	}
}

void draw_status(char action,int previous_state)
{
	static mySprite loser, winner, loser_txt, winner_txt;

	if(action==DO_DRAW)
	{	
		/* etat mort */
		if(previous_state==1)
		{	displaySprite(loser,g_SDL_screen,0,0);
			displaySprite(loser_txt,g_SDL_screen,0,0);
		}

		/* etat gagnant */
		if(previous_state==2)
		{	displaySprite(winner,g_SDL_screen,0,0);
			displaySprite(winner_txt,g_SDL_screen,0,0);
		}
	}
	else if(action==DO_INIT)
	{	SDL_Color myText_bg={255,255,255};
		SDL_Color myText_fg={255,20,20};
		font_select(FONT_NAME,36,myText_fg,myText_bg,180);

		loser.image = IMG_LoadOptAlpha("./gfx/ihm/loser.jpg");
		loser.posX=g_SDL_screen->w/2 - loser.image->w/2;
		loser.posY=g_SDL_screen->h/2 - loser.image->h/2;
		loser.etat=ETAT_VISIBLE;
		loser_txt = font_long_text("[LOSER]",0, 0);
		loser_txt.posX=g_SDL_screen->w/2 - loser_txt.image->w/2;
		loser_txt.posY=g_SDL_screen->h/2 - loser_txt.image->h/2;
		
		winner.image = IMG_LoadOptAlpha("./gfx/ihm/winner.jpg");
		winner.posX=g_SDL_screen->w/2 - winner.image->w/2;
		winner.posY=g_SDL_screen->h/2 - winner.image->h/2;
		winner.etat=ETAT_VISIBLE;
		winner_txt = font_long_text("[WINNER]",0, 0);
		winner_txt.posX=g_SDL_screen->w/2 - winner_txt.image->w/2;
		winner_txt.posY=g_SDL_screen->h/2 - winner_txt.image->h/2;
	}
	else if(action==DO_FREE)
	{	SDL_FreeSurface(loser.image);
		SDL_FreeSurface(winner.image);
	}
}

void draw_bandeau(char action)
{	static mySprite bandeau,time;
	static SDL_Surface* accel;
	
	if(action==DO_DRAW)
	{	int y,x;
		SDL_Rect srcrect,dstrect;
		displaySprite(bandeau,g_SDL_screen,0,0);

		/* time */
		x= 20;
		y= 575 - time.image->h/2 ;
		displaySprite(time,g_SDL_screen,x,y);
		font_render_integer(static_level_datas.currentTime,x+time.image->w,y);
		
		/* switch */
		x= 400;
		font_render_integer(static_level_datas.switchTime,x,y);

		/* coins */
		x= 550;
		font_render_integer(static_world_datas.coins,x,y);
		
		/* acceleration */
		srcrect.x=0;
		srcrect.y=0;
		srcrect.h=(abs(static_level_datas.global_player->horizontal_speed)*36/*taille_max*/)/10/*vit max*/+2/*trait mini*/;
		srcrect.w=accel->w;
		dstrect.x=447;
		dstrect.y=593-srcrect.h;
		SDL_BlitSurface(accel,&srcrect,g_SDL_screen,&dstrect);
	}
	else if(action==DO_INIT)
	{	SDL_Color myText_bg={255,255,255};
		SDL_Color myText_fg={255,20,20};

		/* fonte */
		font_select(FONT_NAME,22,myText_fg,myText_bg,180);
		time = font_long_text("[TIME]",0, 0);

		/* bandeau */	
		bandeau.image=IMG_LoadOptAlpha("gfx/ihm/bandeau.jpg");
		bandeau.posX=0;
		bandeau.posY=544;
		bandeau.etat=ETAT_VISIBLE;
		
		/* barre d'accélération */
		accel=SDL_CreateRGBSurface(g_SDL_screen->flags, 45, 40,
					g_SDL_screen->format->BitsPerPixel,
					g_SDL_screen->format->Rmask, g_SDL_screen->format->Gmask,
					g_SDL_screen->format->Bmask, g_SDL_screen->format->Amask);
		SDL_FillRect(accel, NULL, SDL_MapRGB(g_SDL_screen->format, 255, 0, 0));
		SDL_SetAlpha(accel, SDL_SRCALPHA|SDL_RLEACCEL,200);
	}
	else if(action==DO_FREE)
	{	SDL_FreeSurface(bandeau.image);
		SDL_FreeSurface(time.image);
		SDL_FreeSurface(accel);
	}
}

void performDecals(char action, level_info infos)
{	//static int affect;

	if(action==DO_INIT)
		static_level_datas.decalX=400-static_level_datas.global_player->posX;
	else if(action==DO_DRAW)
	{	if(infos.autoscroll)
			static_level_datas.decalX-=infos.autoscroll;
		else
			static_level_datas.decalX=400-static_level_datas.global_player->posX;
	}
	if(static_level_datas.decalX>0)
		static_level_datas.decalX=0;
}

void performDecalsToImprove(char action)
{	static int affect;

	if(action==DO_INIT)
		affect=0;
/*
	if(static_level_datas.global_player->horizontal_speed>0 && affect<100)
		affect+=4;
	else if(static_level_datas.global_player->horizontal_speed<0 && affect>-100)
		affect-=4;
	printf("affect%d\n",affect);
*/
	static_level_datas.decalX=(800-400)-static_level_datas.global_player->posX-affect;
	if(static_level_datas.decalX>0)
		static_level_datas.decalX=0;
}
void performDecalsexpermiment(char action)
{	static long affect,pos,pX;
	static char sens;

	if(action==DO_INIT)
	{	sens=1;
		pX=static_level_datas.global_player->posX;
		affect=pX;
	}

	pos=static_level_datas.global_player->posX+static_level_datas.decalX-static_level_datas.global_player->horizontal_speed;
	printf("pos=%ld decal=%ld\n",pos,static_level_datas.decalX);

	if(sens==1) /* vers la droite, donc a gauche de l'ecran */
	{	affect-=pX-static_level_datas.global_player->posX;
		pX=static_level_datas.global_player->posX;
		if(affect>160)
			sens=2;
	}
	else
	{	affect+=pX-static_level_datas.global_player->posX;
		pX=static_level_datas.global_player->posX;
		if(affect<-160)
			sens=1;
	}
	
/*
	if(static_level_datas.global_player->horizontal_speed>0 && affect<100)
		affect+=4;
	else if(static_level_datas.global_player->horizontal_speed<0 && affect>-100)
		affect-=4;
*/
	
	printf("pX:%ld affect:%ld sens:%d\n",pX,affect,sens);

	static_level_datas.decalX=400-static_level_datas.global_player->posX-affect;
	if(static_level_datas.decalX>0)
		static_level_datas.decalX=0;
}
/* retourne 0 si le niveau est fni gagnant */
int main_level(char * level_file_name, int show_FPS)
{
	/* niveau en cours */
	myList * level_walls=NULL;
	myList * level_sprites=NULL;
	myList * level_foreground=NULL;
	level_info infos;
	int status;

	SDL_Color myText_bg={255,255,255};
	SDL_Color myText_fg={255,20,20};
	
	mySprite ft_name,ft_author;

				
	/* init the level */
	if(load_levelinfos(level_file_name,&infos))
	{	printf("Error on load_levelinfos !\n");
		return 1;
	}
	if(init_all_images(infos.wall_gfx_dir,GAME_MODE))
	{	printf("Error on init_all_images !\n");
		return 1;
	}

	/* pour la presentation */
	font_select(FONT_NAME,36,myText_fg,myText_bg,180);
	ft_name   = font_text(infos.level_name ,0, 150);
	ft_author = font_text(infos.author_name,0, 250);

	/* init the music */
	startTheMusic(infos.music_file);
	
	/* init the graphics */
	draw_background(DO_INIT,  infos, 0, 0);
	draw_status(DO_INIT ,0);
	draw_bandeau(DO_INIT);

	while(1)
	{	Uint32 lastTime;
		
		if(load_levelfile(level_file_name,&level_walls,&level_sprites,&level_foreground))
		{	printf("Error on load_levelfile !\n");
			status=1;
			break;
		}

		/* init the graphics */
		draw_foreground(DO_INIT ,  infos,0, 0);

		/* player tjrs en dernière position de la liste */
		static_level_datas.global_player=GetPosList(level_sprites,level_sprites->size-1);
		
		/* niveau de jeu en cours */
		static_level_datas.currentTime=infos.time_limit;
		static_level_datas.switchTime=0;
		static_level_datas.is_switched=0;
		status=0;

		/* récupération de l'éventuelle dernière combinaison */
		if(static_world_datas.combi)
			changeSpriteToId(static_level_datas.global_player,static_world_datas.combi,level_walls,level_sprites,0);
		
		/**************************/
		/* presentation du niveau */
		/**************************/
		if(ft_name.image)
			ft_name.posX=g_SDL_screen->w/2 - ft_name.image->w/2;
		if(ft_author.image)
			ft_author.posX=g_SDL_screen->w/2 - ft_author.image->w/2;

		performDecals(DO_INIT,infos);

		/* ré-init des évènements */
		events_init();
		while(!any_event_found())
		{
			/* dessin des décors */
			draw_background(DO_DRAW, infos,static_level_datas.decalX,static_level_datas.decalY);
			draw_foreground(DO_DRAW, infos,static_level_datas.decalY,static_level_datas.decalY);
			draw_bandeau(DO_DRAW);
			
			displaySprite(ft_name, g_SDL_screen, 0, 0);
			displaySprite(ft_author, g_SDL_screen, 0, 0);
			
			/* on bloque à 30 FPS */
			coef_frame_rate(show_FPS);
			
			/* envoi au hard */
			SDL_Flip(g_SDL_screen);
		}

		/*****************/
		/* jeu du niveau */
		/*****************/
		static_level_datas.pause=0;
		lastTime=SDL_GetTicks();
		while(!status)
		{
			if(!static_level_datas.pause)
			{	/* gestion des sprites */
				status=manage_sprites(level_walls,level_sprites,static_level_datas.decalX,static_level_datas.decalY);
			
				/* calcul des décalages pour le scrolling */
				performDecals(DO_DRAW,infos);
			}
		
			/* dessin du niveau */
			draw_background(DO_DRAW, infos,static_level_datas.decalX,static_level_datas.decalY);
			draw_list_to_screen(level_walls,static_level_datas.decalX,static_level_datas.decalY,1);
			draw_list_to_screen(level_sprites,static_level_datas.decalX,static_level_datas.decalY,0);
			draw_list_to_screen(level_foreground,static_level_datas.decalX,static_level_datas.decalY,1);
			draw_foreground(DO_DRAW, infos,static_level_datas.decalX,static_level_datas.decalY);
			draw_bandeau(DO_DRAW);
			
			/* on bloque à 30 FPS */
			coef_frame_rate(show_FPS);
			
			/* envoi au hard */
			SDL_Flip(g_SDL_screen);
		
			/* gestion du switch */
			if(static_level_datas.switchTime == 10 && !static_level_datas.is_switched)
			{	switchSprites(level_walls,level_sprites);
				static_level_datas.is_switched=1;
			}
			if(static_level_datas.switchTime == 0 && static_level_datas.is_switched)
			{	switchSprites(level_walls,level_sprites);
				static_level_datas.is_switched=0;
			}

			/* gestion du temps */
			if(SDL_GetTicks()-lastTime>1000)
			{	if(!static_level_datas.pause)
				{	static_level_datas.currentTime--;
					if(static_level_datas.switchTime>0)
						static_level_datas.switchTime--;
				}
				lastTime+=1000;
			}
			if(static_level_datas.currentTime<1)
				status=1;
				
			if(process_level_events(static_level_datas.global_player))
				status=1;
		}
		/*****************/
		/* niveau fini   */
		/*****************/
		if(status==1)
		{	startTheSound("snd/loose.wav");
		}
		else if(status==2)
			startTheSound("snd/win.wav");
		else
			printf("level fini ??? : %d\n",status);

		/* ré-init des évènements */
		events_init();
		static_level_datas.global_player->goright=static_level_datas.global_player->goleft=0;

		/* niveau en attente d'une touche <- ou -> */
		while(!static_level_datas.global_player->goright && !static_level_datas.global_player->goleft)
		{
			/* dessin du niveau */
			draw_background(DO_DRAW, infos,static_level_datas.decalX,static_level_datas.decalY);
			draw_list_to_screen(level_walls,static_level_datas.decalX,static_level_datas.decalY,1);
			draw_list_to_screen(level_sprites,static_level_datas.decalX,static_level_datas.decalY,0);
			draw_list_to_screen(level_foreground,static_level_datas.decalX,static_level_datas.decalY,1);
			draw_foreground(DO_DRAW, infos,static_level_datas.decalX,static_level_datas.decalY);
			draw_status(DO_DRAW, status);
			draw_bandeau(DO_DRAW);
			
			/* envoi au hard */
			SDL_Flip(g_SDL_screen);
		
			/* on bloque à 30 FPS */
			coef_frame_rate(show_FPS);

			if(process_level_events(static_level_datas.global_player) == 1)
				static_level_datas.global_player->goright=1;
		}
		
		if(status==2)	/* sauvegrde de la combinaison finale */
			static_world_datas.combi = static_level_datas.global_player->id;
		else		/* perte de la combinaison */
			static_world_datas.combi=0;

		/* liberation memoire */
		FreeList(level_walls);
		FreeList(level_sprites);
		FreeList(level_foreground);
		draw_foreground(DO_FREE, infos, 0, 0);
		performDecals(DO_FREE,infos);

		/* succés ! */
		if(status==2)
		{	status=0;
			break;
		}
		
		/* sinon si on abandonne : retour à la map */
		if(static_level_datas.global_player->goright)
		{	status=1;
			break;
		}
		/* sinon échec, on reboucle sur le même niveau */
	}
	
	/* free the graphics */
	draw_background(DO_FREE, infos, 0, 0);
	draw_status(DO_FREE ,0);
	draw_bandeau(DO_FREE);

	/* free the level */
	free_all_images();

	SDL_FreeSurface(ft_name.image);
	SDL_FreeSurface(ft_author.image);

	return status;
}
