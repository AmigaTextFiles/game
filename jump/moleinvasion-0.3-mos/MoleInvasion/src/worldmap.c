/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#define MAIN_WORLDMAP
#include "worldmap.h"
#include "events.h"
#include "font.h"

/* used for init the graphics functions */
#define DO_INIT	0
#define DO_DRAW 1
#define DO_FREE 2

myList* perform_road( int x1, int y1, int x2, int y2)
{	myList* road_list;
	myList* road_list2;
	road_element road_elt;
	road_element *road_elt_ptr;
	
	int dx,dy; 	/*differences*/
	int decision; 	/*variable de décision*/
	int inc1,inc2; 	/*les deux incrémentations */
	int x=0,y=0; 	/* coordonnees de tracage */
	int fin;	/* coordonnee de fin de tracage*/
	int temp,xx2,yy2;

//	printf("perform_road:%d,%d->%d,%d\n",x1,y1,x2,y2);
	xx2=x2;yy2=y2;

	road_list=InitList();
	
	temp=x2-x1;	dx=abs(temp);
	temp=y2-y1;	dy=abs(temp);

	if(dx>dy)
	{	if(x2<x1)
		{	/* il suffit de remplacer les valeurs */
			temp=x1;x1=x2;x2=temp;
			temp=y1;y1=y2;y2=temp;
		}

	/* 	decision=2*dy-dx;	inc1=2*dy;	inc2=2*(dy-dx);	*/
		decision=(dy<<1)-dx;	inc1=dy<<1;	inc2=(dy-dx)<<1;

		x=x1;y=y1;fin=x2;

		while(x<fin)
		{	x++;
			if(decision<0)
				decision+=inc1;
			else
			{	if(y2<y1)
					y--;
				else
					y++;
				decision+=inc2;
			}
			road_elt.X=x;
			road_elt.Y=y;
			AddToList(road_list,&road_elt,sizeof(road_element));
		}
		road_elt.X=x2;
		road_elt.Y=y2;
		AddToList(road_list,&road_elt,sizeof(road_element));
	}
	else
	{	if(y2<y1)
		{	/* il suffit de remplacer les valeurs */
			temp=x1;x1=x2;x2=temp;
			temp=y1;y1=y2;y2=temp;
		}

	/*	decision=2*dx-dy;	inc1=2*dx;	inc2=2*(dx-dy);	*/
		decision=(dx<<1)-dy;	inc1=dx<<1;	inc2=(dx-dy)<<1;

		x=x1;y=y1;fin=y2;

		while(y<fin)
		{	y++;
			if(decision<0)
				decision+=inc1;
			else
			{	if(x2<x1)
					x--;
				else
					x++;
				decision+=inc2;
			}
			road_elt.X=x;
			road_elt.Y=y;
			AddToList(road_list,&road_elt,sizeof(road_element));
		}
		road_elt.X=x2;
		road_elt.Y=y2;
		AddToList(road_list,&road_elt,sizeof(road_element));
	}

	/* si la position finale n'est pas en fin de liste : on inverse la liste 
	(optimisation de l'algo précédent) */
	road_elt_ptr=(road_element*)GetPosList(road_list,road_list->size-1);
	
//	printf("-%d,%d-%d,%d\n",road_elt_ptr->X , xx2 , road_elt_ptr->Y , yy2);
	
	if(road_elt_ptr->X != xx2 || road_elt_ptr->Y != yy2)
	{//	printf("in reverse ! \n");
		for(temp=road_list->size-2;temp>=0;temp--)
		{	road_elt_ptr=(road_element*)GetPosList(road_list,temp);
			AddToList(road_list,road_elt_ptr,sizeof(road_element));
			RemoveFromList(road_list,temp);
		}
	}
	
	road_list2=InitList();
	for(temp=0;temp<road_list->size;temp+=7) /* on prend 1 point sur 7 */
	{	road_elt_ptr=(road_element*)GetPosList(road_list,temp);
		AddToList(road_list2,road_elt_ptr,sizeof(road_element));
	}
	road_elt_ptr=(road_element*)GetPosList(road_list,road_list->size-1);
	AddToList(road_list2,road_elt_ptr,sizeof(road_element));
	FreeList(road_list);

	return(road_list2);
}

void change_level_status(myList * lvl_list,unsigned int levelId,statuslevel newstatus)
{	level_desc *level_read;
	
	assert(lvl_list);
	level_read=GetPosListById(lvl_list,levelId);
	if(level_read)
	{	if(newstatus>level_read->level_status)
		{	level_read->level_status=newstatus;
//			printf("Level %d becomes %d\n",levelId,newstatus);
		}
//		else
//			printf("Level %d stay %d\n",levelId,level_read->level_status);
	}
}

/* return 1 if some action key is pressed, 2 if want2quit */
int process_world_events( mySprite * player )
{	all_events_status events;

	events=events_get_all();

	player->goleft=events.left | events.arrow_left_kp;
	player->goright=events.right | events.arrow_right_kp;
	player->gojump=events.jump | events.arrow_up_kp;
	player->godown=events.down | events.arrow_down_kp;

	if(events.f_kp)
		SDL_WM_ToggleFullScreen(g_SDL_screen);

	if(events.special_kp || events.space || events.accel)
		return 1;
	if(events.quit || events.esc)
		return 2;
	return 0;
}

void draw_foregrnd(char action,worldmap world_infos)
{	static mySprite foregrnd;

	if(action==DO_DRAW)
	{	/* foreground */
		displaySprite(foregrnd,g_SDL_screen,0,0);
	}
	else if(action==DO_INIT)
	{	foregrnd.image = IMG_LoadOptAlpha("gfx/ihm/worldborder.png");
		foregrnd.posX=0;
		foregrnd.posY=0;
		foregrnd.etat=ETAT_VISIBLE;
	}
	else  if(action==DO_FREE)
	{	SDL_FreeSurface(foregrnd.image);
	}
}

void draw_world(char action,worldmap world_infos,myList * all_level_desc)
{	static mySprite backgrnd,level_point_close,level_point_open,level_point_done,path;
	static myList*	path_list=NULL;

	unsigned int i,j,k,move=0;
	level_desc *level_read,*level_dest;
	road_element *road_elt;

	if(action==DO_DRAW)
	{	/* background */
		displaySprite(backgrnd,g_SDL_screen,0,0);
		
		/* paths */
		if(path_list)
		{	for(i=0;i<path_list->size;i++)
			{	road_elt=GetPosList(path_list,i);
				displaySprite(path,g_SDL_screen,
					road_elt->X-path.image->w/2,
					road_elt->Y-path.image->h/2);
			}
		}

		/* levels points */
		for(i=0;i<all_level_desc->size;i++)
		{	level_read=(level_desc*)GetPosList(all_level_desc,i);
		
			if(level_read->level_status==OPEN)
				displaySprite(level_point_open,g_SDL_screen,
					level_read->posX-level_point_open.image->w/2,
					level_read->posY-level_point_open.image->h/2);
			else if(level_read->level_status==DONE)
				displaySprite(level_point_done,g_SDL_screen,
					level_read->posX-level_point_done.image->w/2,
					level_read->posY-level_point_done.image->h/2);
		}
	}
	else if(action==DO_INIT)
	{	backgrnd.image = IMG_Load(world_infos.backgrnd_image);
		backgrnd.posX=0;
		backgrnd.posY=0;
		backgrnd.etat=ETAT_VISIBLE;

		level_point_close.image = IMG_LoadOptAlpha("./gfx/dot_green.png");
		level_point_close.etat=ETAT_VISIBLE;
		
		level_point_open.image = IMG_LoadOptAlpha("./gfx/dot_red.png");
		level_point_open.etat=ETAT_VISIBLE;
		
		level_point_done.image = IMG_LoadOptAlpha("./gfx/dot_yellow.png");
		level_point_done.etat=ETAT_VISIBLE;

		path.image = IMG_LoadOptAlpha("./gfx/path.png");
		path.etat=ETAT_VISIBLE;
		
		/* récupération de tous les paths entre niveaux accessibles */
		for(i=0;i<all_level_desc->size;i++)
		{	level_read=(level_desc*)GetPosList(all_level_desc,i);
			if(level_read->level_status == CLOSE)
				continue;
			for(k=0;k<2;k++)
			{	switch(k)
				{case	0:move=level_read->move_up;	break;
				case	1:move=level_read->move_left;	break;
				/* on ne fait que la moitie car on a "forcemment" aller/retour 
				case	2:move=level_read->move_down;	break;
				case	3:move=level_read->move_right;	break;*/
				}
				if(move)
				{	myList*	tmppath_list;
			
					level_dest=(level_desc*)GetPosListById(all_level_desc,move);
					if(level_dest->level_status == CLOSE)
						continue;
					tmppath_list=perform_road(level_read->posX, level_read->posY,
								  level_dest->posX, level_dest->posY);
					assert(tmppath_list);
					/* concatenation */
					if(!path_list)
						path_list=InitList();
					for(j=0;j<tmppath_list->size;j++)
					{	road_elt=GetPosList(tmppath_list,j);
						AddToList(path_list,road_elt,sizeof(road_element));
					}
					FreeList(tmppath_list);
				}
			}
		}	
	}
	else  if(action==DO_FREE)
	{	SDL_FreeSurface(backgrnd.image);
		SDL_FreeSurface(level_point_close.image);
		SDL_FreeSurface(level_point_open.image);
		SDL_FreeSurface(level_point_done.image);
		SDL_FreeSurface(path.image);
		if(path_list)
		{	FreeList(path_list);
			path_list=NULL;
		}
	}
}

#define NONAMELEVEL "no name level"
void draw_level_name(int current_level,myList * all_level_desc)
{	static char * current_name=NULL;
	static mySprite text;
	level_desc *level_read;
	char change=0;
	
	level_read=GetPosListById(all_level_desc,current_level);
	if(level_read && strlen(level_read->level_name)>0)
	{	if(current_name != level_read->level_name)
		{	if(current_name)
				SDL_FreeSurface(text.image);
			change=1;
		}
		current_name = level_read->level_name;
	}
	else
	{	if(current_name != NONAMELEVEL)
		{	if(current_name)
				SDL_FreeSurface(text.image);
			change=1;
		}
		current_name = NONAMELEVEL;
	}	

	if(change)
		text=font_text(current_name,240,535);

	displaySprite(text,g_SDL_screen,-text.image->w/2,0);
}

int draw_player(char action,myList * all_level_desc,mySprite * param_player)
{	static int current_level;
	static myList* player_road=NULL;
	unsigned int x1,y1,x2,y2;
	level_desc *level_read;

	if(action==DO_DRAW)
	{	/* player */
		if(player_road)
		{	/* joueur en déplacement */
			if(player_road->size>0)
			{	road_element *road_elt;
				road_elt=GetPosList(player_road,0);
				param_player->posX=road_elt->X-param_player->image->w/2;
				param_player->posY=road_elt->Y-param_player->image->h;
				RemoveFromList(player_road,0);
			}
			else
			{	FreeList(player_road);
				player_road=NULL;
			}
		}
		else
		{	level_desc *level_read2;
			unsigned int go_to;
			level_read=GetPosListById(all_level_desc,current_level);
			x1=level_read->posX;
			y1=level_read->posY;
			param_player->posX=x1-param_player->image->w/2;
			param_player->posY=y1-param_player->image->h;
			
			/* deplacement ? */
			go_to=0;
			if( param_player->gojump && level_read->move_up )
				go_to=level_read->move_up;
			if( param_player->goright && level_read->move_right )
				go_to=level_read->move_right;
			if( param_player->goleft && level_read->move_left )
				go_to=level_read->move_left;
			if( param_player->godown && level_read->move_down )
				go_to=level_read->move_down;
			if(go_to)
			{	level_read2=GetPosListById(all_level_desc,go_to);
				if( level_read2->level_status != CLOSE )
				{	x2=level_read2->posX;
					y2=level_read2->posY;
					player_road=perform_road(x1,y1,x2,y2);
					current_level=go_to;
				}
			}
		}
		displaySprite(*param_player,g_SDL_screen,0,0);
	}
	else if(action==DO_INIT)
	{	/* le joueur se trouve au niveau 1 */
		current_level=1;
		memset(param_player,0,sizeof(mySprite));
		param_player->image = IMG_LoadOptAlpha("./gfx/small_sprite_drte.png");
		param_player->map=NULL;
		param_player->etat=ETAT_VISIBLE;
	}
	else if(action==DO_FREE)
	{	SDL_FreeSurface(param_player->image);
	}
	return current_level;
}

int main_worlmap(char * level_file_name, int show_FPS)
{
	worldmap world_infos;
	myList * all_level_desc=NULL;
	mySprite world_player;
	level_desc *level_read;
	int i;
		
	/* open levels list */
	myList * open_level_list=NULL;
	open_level_list=InitList();

	/* lecture du fichier de worldmap */
	if(load_worldfile(level_file_name,&all_level_desc,&world_infos))
	{	printf("Error on load_worldfile !\n");
		quit(1);
	}
	
	/* init des dessins */
	draw_player(DO_INIT,all_level_desc,&world_player);
	draw_foregrnd(DO_INIT,world_infos);

	/* load open levels */
	change_level_status(all_level_desc,1,OPEN);
	load_all_open_levels(open_level_list);
	for(i=0;i<all_level_desc->size;i++)
	{	level_read=GetPosList(all_level_desc,i);
		change_level_status(all_level_desc,level_read->level_id,
			read_level_status(open_level_list,world_infos,*level_read));
	}
	
	/* reset de la combinaison du joueur */
	static_world_datas.combi=0;
	while(1)
	{	/* world en cours */
		int current_level,action;
		
		/* font initialisation */
		{SDL_Color myText_bg={255,255,255};
		SDL_Color myText_fg={255,20,20};
		font_select(FONT_NAME,25,myText_fg,myText_bg,180);
		}

		/* music */
		startTheMusic(world_infos.music_file);

		/* init des dessins */
		draw_world(DO_INIT,world_infos,all_level_desc);

		/* ré-init des évènements */
		events_init();

		while(1)
		{	/* dessin du niveau */
			draw_world(DO_DRAW,world_infos,all_level_desc);
			current_level=draw_player(DO_DRAW,all_level_desc,&world_player);
			draw_foregrnd(DO_DRAW,world_infos);
			draw_level_name(current_level,all_level_desc);
			
			/* envoi au hard */
			SDL_Flip(g_SDL_screen);

			/* on bloque à 30 FPS */
			coef_frame_rate(show_FPS);

			/* déplacements de player + espace */
			action=process_world_events(&world_player);
			if(action)
				break;
		}

		/* free de dessin du niveau */
		draw_world(DO_FREE,world_infos,all_level_desc);

		if(action==2)
			break;
		else if(action==1)
		{	/* récupération du fichier du niveau */
			level_read=GetPosListById(all_level_desc,current_level);
			if(main_level(level_read->fic_name,show_FPS)==0)
			{	/* niveau gagné ! */
				int up,down,left,right;
				up   =level_read->move_up;	down =level_read->move_down;
				left =level_read->move_left;	right=level_read->move_right;
				
				/* let's open the levels ! */
				change_level_status(all_level_desc,current_level,DONE);
				if(up)
					change_level_status(all_level_desc,up,OPEN);
				if(down)
					change_level_status(all_level_desc,down,OPEN);
				if(left)
					change_level_status(all_level_desc,left,OPEN);
				if(right)
					change_level_status(all_level_desc,right,OPEN);
			}
		
			/* sauvegarde de la situation */
			save_all_open_levels(all_level_desc,world_infos,open_level_list);
		}
	}
	/* free de dessin du niveau */
	draw_player(DO_FREE,all_level_desc,&world_player);
	draw_foregrnd(DO_FREE,world_infos);

	FreeList(open_level_list);
	FreeList(all_level_desc);

	printf("returning\n");
	return 0;
}
