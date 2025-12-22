/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include "level_file.h"

#define APP_NAME  ".MoleInvasion"
#define SAVE_FILE "save_game"

int load_levelinfos(char* file, level_info * infos)
{	char buffer[256],player_init;
	FILE * fd;

	player_init=0;

	fd=fopen(file,"r");
	if(!fd)
	{	perror(file);
		return -1;
	}

	/* init */
	if(infos!=NULL)
	{	infos->level_name[0]=	infos->author_name[0]=
		infos->music_file[0]=	infos->background[0] = '\0';
		sprintf(infos->wall_gfx_dir,"wall-01");
		infos->foreground=0;
		infos->time_limit=200;
		infos->autoscroll=0;
	}

	/* level infos */
	while(!feof(fd))
	{	if(!fgets(buffer,sizeof(buffer),fd))
			continue;

		/* comment */
		if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
		if(strlen(buffer)<1 || buffer[0] == '#')
			continue;

		/* on attaque les datas */
		if(!strncmp(buffer,"<DATA>",6))
			break;

		if(infos!=NULL)
		{	if(!strncmp(buffer,"<NAME=",6))
				sscanf(buffer+6,"%127[^>]",infos->level_name);
			else if(!strncmp(buffer,"<AUTHOR=",8))
				sscanf(buffer+8,"%127[^>]",infos->author_name);
			else if(!strncmp(buffer,"<MUSIC=",7))
				sscanf(buffer+7,"%127[^>]",infos->music_file);
			else if(!strncmp(buffer,"<TIME=",6))
				sscanf(buffer+6,"%d",&infos->time_limit);
			else if(!strncmp(buffer,"<BACKGROUND=",12))
				sscanf(buffer+12,"%127[^>]",infos->background);
			else if(!strncmp(buffer,"<WALL_GFX_DIR=",14))
				sscanf(buffer+14,"%127[^>]",infos->wall_gfx_dir);
			else if(!strncmp(buffer,"<FOREGROUND=",12))
			{	if(!strncasecmp(buffer+12,"CLOUDS>",7))
					infos->foreground=FRGRND_CLOUDS;
				if(!strncasecmp(buffer+12,"RAIN>",5))
					infos->foreground=FRGRND_RAIN;
				if(!strncasecmp(buffer+12,"NIGHT>",6))
					infos->foreground=FRGRND_NIGHT;
			}
			else if(!strncmp(buffer,"<AUTOSCROLL=",12))
				sscanf(buffer+12,"%d",&infos->autoscroll);
			else
				printf("buff:%s\n",buffer);
		}
	}

	fclose(fd);

	return 0;
}

/* utilisé pour le tri de la liste des sprites TILES */
int compare_pos_sprite(const void * pa, const void * pb)
{	int pos_a = ((mySprite*)(((myElt*)pa)->value))->posX;
	int pos_b = ((mySprite*)(((myElt*)pb)->value))->posX;
	int ret = pos_a<pos_b?-1:(pos_a==pos_b?0:1);
	
//	printf("sort : %d %d -> %d\n",pos_a,pos_b,ret);
	
	return ret;
}
 
/* utilisé pour le tri de la liste des sprites OTHER */
int compare_type_sprite(const void * pa, const void * pb)
{	char t_a = ((mySprite*)(((myElt*)pa)->value))->sprite_management_type;
	char t_b = ((mySprite*)(((myElt*)pb)->value))->sprite_management_type;
	int ret;
	
	ret=0;
	if(t_a == SPRITE_FLYING)
		ret=-1;
	if(t_b == SPRITE_FLYING)
		ret=1;
	if(t_a == SPRITE_PLAYER)
		ret=1;
	if(t_b == SPRITE_PLAYER)
		ret=-1;
	
//	printf("type : %d %d -> %d\n",pos_a,pos_b,ret);
	
	return ret;
}

int load_levelfile(char* file, myList ** sp_wall_list, myList ** sp_sprite_list, myList ** sp_foreground_list)
{	char buffer[256],player_init;
	FILE * fd;
	unsigned int read_id;
	long posX,posY;
	mySprite   sprite_read;

	player_init=0;

	fd=fopen(file,"r");
	if(!fd)
	{	perror(file);
		return -1;
	}

	/* level infos */
	while(!feof(fd))
	{	if(!fgets(buffer,sizeof(buffer),fd))
			continue;

		/* comment */
		if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
		if(strlen(buffer)<1 || buffer[0] == '#')
			continue;

		/* on attaque les datas */
		if(!strncmp(buffer,"<DATA>",6))
			break;
	}

	if(feof(fd))
	{	fclose(fd);
		printf("Error on reading : no_data ! \n");
		return 1;
	}

	/* level data */
	*sp_wall_list=InitList();
	*sp_sprite_list=InitList();
	*sp_foreground_list=InitList();
	while(fscanf(fd,"%lu,%lu,%u;",&posX,&posY,&read_id)==3)
	{
		LoadSprite(&sprite_read,read_id);
		sprite_read.posX=posX;
		sprite_read.posY=posY;
		sprite_read.posXinit=posX;
		sprite_read.posYinit=posY;
		sprite_read.etat=ETAT_VISIBLE | ETAT_VIVANT;

		if(sprite_read.sprite_management_type == SPRITE_PLAYER)
		{	initPlayer(&sprite_read);
			player_init=1;
		}
		else if(sprite_read.sprite_management_type > SPRITE_PLAYER)
			initOther(&sprite_read);
		
		if(sprite_read.sprite_management_type == SPRITE_TILE)
			AddToList(*sp_wall_list,&sprite_read,sizeof(mySprite));
		else if(sprite_read.sprite_management_type == SPRITE_FOREGROUND)
			AddToList(*sp_foreground_list,&sprite_read,sizeof(mySprite));
		else
			AddToList(*sp_sprite_list,&sprite_read,sizeof(mySprite));
	}
	fclose(fd);

	/* on tri la liste par ordre croissant de bord gauche (pour optimiser les collisions et l'affichage) */
	qsort ((*sp_wall_list)->elt, (*sp_wall_list)->size, sizeof(myElt),compare_pos_sprite);

	/* on tri la liste par type (pour mettre les bonus au début et player a la fin) */
	qsort ((*sp_sprite_list)->elt, (*sp_sprite_list)->size, sizeof(myElt),compare_type_sprite);

	/* on tri la liste par ordre croissant de bord gauche (pour optimiser l'affichage) */
	qsort ((*sp_foreground_list)->elt, (*sp_foreground_list)->size, sizeof(myElt),compare_pos_sprite);

	printf("OPEN => '%s' %d tiles\n",file,(*sp_wall_list)->size);
	printf("OPEN => '%s' %d sprites\n",file,(*sp_sprite_list)->size);
	printf("OPEN => '%s' %d foreground\n",file,(*sp_foreground_list)->size);

	return 0;
}

int save_levelfile(char* file, myList * sp_list, level_info infos)
{	int i;
	mySprite * sprite;
	FILE * fd;

	fd=fopen(file,"w");
	if(!fd)
	{	perror(file);
		return 1;
	}

	if(infos.time_limit<1)
		infos.time_limit=200;

	/* infos */
	fprintf(fd,"<NAME=%s>\n",infos.level_name);
	fprintf(fd,"<AUTHOR=%s>\n",infos.author_name);
	fprintf(fd,"<MUSIC=%s>\n",infos.music_file);
	fprintf(fd,"<TIME=%d>\n",infos.time_limit);
	fprintf(fd,"<BACKGROUND=%s>\n",infos.background);
	fprintf(fd,"<WALL_GFX_DIR=%s>\n",infos.wall_gfx_dir);
	switch(infos.foreground)
	{case FRGRND_CLOUDS:fprintf(fd,"<FOREGROUND=CLOUDS>\n");break;
	case FRGRND_RAIN:fprintf(fd,"<FOREGROUND=RAIN>\n");break;
	case FRGRND_NIGHT:fprintf(fd,"<FOREGROUND=NIGHT>\n");break;
	default:fprintf(fd,"<FOREGROUND=NONE>\n");break;
	}
	fprintf(fd,"<AUTOSCROLL=%d>\n",infos.autoscroll);

	/* datas */
	fprintf(fd,"<DATA>\n");
	for(i=0;i<sp_list->size;i++)
	{	sprite=GetPosList(sp_list,i);

		/* repositionnement modulo 32 */
		if( sprite->posX % 32 != 0 )
			sprite->posX = (sprite->posX / 32) * 32;
		if( sprite->posY % 32 != 0 )
			sprite->posY = (sprite->posY / 32) * 32;

		fprintf(fd,"%lu,%lu,%u;",sprite->posX,sprite->posY,sprite->id);
	}
	fclose(fd);
	return 0;
}

/* pour les worlds */
level_desc * GetPosListById(myList * list,unsigned int id)
{	level_desc * current;
	unsigned int i;
	
	if(id<1)
		return NULL;

	for(i=0;i<list->size;i++)
	{	current=GetPosList(list,i);
		if(current->level_id == id)
			return current;
	}

	printf("GetPosListById:id: %d not found\n",id);
	return NULL;
}

int load_worldfile(char* file, myList ** lvl_list, worldmap * infos)
{	char buffer[256];
	FILE * fd;
	level_desc level_read;
	level_info level_infos;
	int i;

	fd=fopen(file,"r");
	if(!fd)
	{	perror(file);
		return -1;
	}

	/* init */
	if(infos!=NULL)
	{	infos->world_name[0]=	infos->next_world[0]=
		infos->music_file[0]=	infos->backgrnd_image[0]='\0';
	}

	/* world infos */
	while(!feof(fd))
	{	if(!fgets(buffer,sizeof(buffer),fd))
			continue;

		/* comment */
		if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
		if(strlen(buffer)<1 || buffer[0] == '#')
			continue;

		/* on attaque les datas */
		if(!strncmp(buffer,"<LEVELS_DESC>",13))
			break;

		if(infos!=NULL)
		{	if(!strncmp(buffer,"<NAME=",6))
				sscanf(buffer+6,"%127[^>]",infos->world_name);
			else if(!strncmp(buffer,"<NEXT=",6))
				sscanf(buffer+6,"%127[^>]",infos->next_world);
			else if(!strncmp(buffer,"<MUSIC=",7))
				sscanf(buffer+7,"%127[^>]",infos->music_file);
			else if(!strncmp(buffer,"<IMAGE=",7))
				sscanf(buffer+7,"%127[^>]",infos->backgrnd_image);
			else
				printf("buff:%s\n",buffer);
		}
	}

	if(feof(fd))
	{	fclose(fd);
		printf("Error on reading : no_level ! \n");
		return 1;
	}

	/* world data */
	*lvl_list=InitList();
	while(!feof(fd))
	{	if(!fgets(buffer,sizeof(buffer),fd))
			continue;

		/* comment */
		if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
		if(strlen(buffer)<1 || buffer[0] == '#')
			continue;

		if(strncmp(buffer,"<LEVEL>",7))
		{	printf(" => %s : format error (%s)\n",file,buffer);
			continue;
		}
		level_read.level_id=0;
		level_read.level_name[0]=0;
		level_read.fic_name[0]=0;
		level_read.posX=level_read.posY=0;
		level_read.move_up=level_read.move_down=level_read.move_left=level_read.move_right=0;
		level_read.level_status=CLOSE;
		while(!feof(fd))
		{	if(!fgets(buffer,sizeof(buffer),fd))
				continue;

			/* comment */
			if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
			if(strlen(buffer)<1 || buffer[0] == '#')
				continue;

			if(!strncmp(buffer,"<ID=",4))
				sscanf(buffer+4,"%u",&level_read.level_id);
			else if(!strncmp(buffer,"<NAME=",6))
				sscanf(buffer+6,"%127[^>]",level_read.level_name);
			else if(!strncmp(buffer,"<FILE=",6))
				sscanf(buffer+6,"%127[^>]",level_read.fic_name);
			else if(!strncmp(buffer,"<POSX=",6))
				sscanf(buffer+6,"%u",&level_read.posX);
			else if(!strncmp(buffer,"<POSY=",6))
				sscanf(buffer+6,"%u",&level_read.posY);
			else if(!strncmp(buffer,"<MOVEUP=",8))
				sscanf(buffer+8,"%u",&level_read.move_up);
			else if(!strncmp(buffer,"<MOVEDOWN=",10))
				sscanf(buffer+10,"%u",&level_read.move_down);
			else if(!strncmp(buffer,"<MOVELEFT=",10))
				sscanf(buffer+10,"%u",&level_read.move_left);
			else if(!strncmp(buffer,"<MOVERIGHT=",11))
				sscanf(buffer+11,"%u",&level_read.move_right);
			else if(!strncmp(buffer,"</LEVEL>",8))
				break;
			else
				printf("buff:%s\n",buffer);
		}
		if(load_levelinfos(level_read.fic_name,&level_infos) != -1)
		{	strncpy(level_read.level_name,level_infos.level_name,sizeof(level_read.fic_name));
			AddToList(*lvl_list,&level_read,sizeof(level_desc));
		}
		else
			printf("Broken level discarded : id=%d file=%s\n",level_read.level_id,level_read.fic_name);
	}
	fclose(fd);

	printf("OPEN => '%s' %d levels\n",file,(*lvl_list)->size);
	
	/* controls */
	for(i=0;i<(*lvl_list)->size;i++)
	{	level_desc *src,*dst;
		src=GetPosList(*lvl_list,i);
		if(src->move_up)
		{	dst=GetPosListById(*lvl_list,src->move_up);
			if(!dst)
				printf("world '%s' : %d up %d mais n'existe pas\n",file,src->level_id,src->move_up);
			else if(dst->move_down != src->level_id)
				printf("world '%s' : %d up %d mais pas l'inverse (%d)\n",file,src->level_id,src->move_up,dst->move_down);
		}
		if(src->move_down)
		{	dst=GetPosListById(*lvl_list,src->move_down);
			if(!dst)
				printf("world '%s' : %d up %d mais n'existe pas\n",file,src->level_id,src->move_down);
			else if(dst->move_up != src->level_id)
				printf("world '%s' : %d dn %d mais pas l'inverse (%d)\n",file,src->level_id,src->move_down,dst->move_up);
		}
		if(src->move_left)
		{	dst=GetPosListById(*lvl_list,src->move_left);
			if(!dst)
				printf("world '%s' : %d up %d mais n'existe pas\n",file,src->level_id,src->move_left);
			else if(dst->move_right != src->level_id)
				printf("world '%s' : %d lf %d mais pas l'inverse (%d)\n",file,src->level_id,src->move_left,dst->move_right);
		}
		if(src->move_right)
		{	dst=GetPosListById(*lvl_list,src->move_right);
			if(!dst)
				printf("world '%s' : %d up %d mais n'existe pas\n",file,src->level_id,src->move_right);
			else if(dst->move_left != src->level_id)
				printf("world '%s' : %d rh %d mais pas l'inverse (%d)\n",file,src->level_id,src->move_right,dst->move_left);
		}
	}

	return 0;
}

/* open levels list */

int is_level_in_open_list_str(myList * lvl_list, char * level)
{	int i;
	char * tmp_ch;

	assert(lvl_list);
	for(i=0;i<lvl_list->size;i++)
	{	tmp_ch=GetPosList(lvl_list,i);
		if(strcmp(tmp_ch,level)==0)
			return 1;
	}
	return 0;
}

statuslevel read_level_status(myList * open_list, worldmap world, level_desc level)
{	char *tmp_ch,*tmp_ch2;
	int i;
	statuslevel returnstatus=CLOSE;

	assert(open_list);
	tmp_ch=(char*)malloc(strlen(world.world_name)+strlen(level.level_name)+2);
	sprintf(tmp_ch,"%s+%s",world.world_name,level.level_name);
	
	for(i=0;i<open_list->size;i++)
	{	tmp_ch2=GetPosList(open_list,i);
		if(strncmp(tmp_ch,tmp_ch2,strlen(tmp_ch))==0)
		{	returnstatus=OPEN; /* for compatibility with old format */
			sscanf(tmp_ch2,"%*[^+]+%*[^+]+%d",(int*)&returnstatus);
			break;
		}
	}
	free(tmp_ch);
	return returnstatus;
}

int is_level_in_open_list(myList * lvl_list, worldmap world, level_desc level)
{	char * tmp_ch;
	int ret;

	assert(lvl_list);
	tmp_ch=(char*)malloc(strlen(world.world_name)+strlen(level.level_name)+2);
	sprintf(tmp_ch,"%s+%s+",world.world_name,level.level_name);
	ret=is_level_in_open_list_str(lvl_list,tmp_ch);
	free(tmp_ch);
	return ret;
}

int load_all_open_levels(myList * open_level_list)
{	FILE * fd;
	char * tmp_ch;
	char buffer[256];

#ifdef __MORPHOS__
	tmp_ch = (char*)malloc(strlen(DATADIR) + strlen(SAVE_FILE) + 1);
	sprintf(tmp_ch,"%s%s", DATADIR, SAVE_FILE);
#else
#ifndef WIN32
	struct passwd * user;

	user=getpwuid(getuid());

	tmp_ch=(char*)malloc(strlen(user->pw_dir)+strlen(APP_NAME)+strlen(SAVE_FILE)+3);
	sprintf(tmp_ch,"%s/%s/%s",user->pw_dir,APP_NAME,SAVE_FILE);
#else
	tmp_ch=(char*)malloc(512);
	getcwd(tmp_ch,512);
	sprintf(tmp_ch,"%s\\%s\\%s",tmp_ch,APP_NAME,SAVE_FILE);
#endif
#endif
	assert(open_level_list);

	fd=fopen(tmp_ch,"r");
	if(!fd)
	{	perror(tmp_ch);
		free(tmp_ch);
		return 0;
	}
	free(tmp_ch);

	while(!feof(fd))
	{	if(!fgets(buffer,sizeof(buffer),fd))
			continue;

		/* comment */
		if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
		if(strlen(buffer)<1 || buffer[0] == '#')
			continue;

/*		printf("add buff:-%s-\n",buffer); */
		if(!is_level_in_open_list_str(open_level_list,buffer))
			AddToList(open_level_list,buffer,strlen(buffer)+1);
	}
	fclose(fd);
	return 0;
}

int save_all_open_levels(myList * lvl_list, worldmap world,myList * open_list)
{	FILE * fd;
	char * tmp_ch;
	int i;

#ifdef __MORPHOS__
	tmp_ch = (char*)malloc(strlen(DATADIR) + strlen(SAVE_FILE) + 1);
	sprintf(tmp_ch,"%s%s", DATADIR, SAVE_FILE);
#else
#ifndef WIN32
	struct passwd * user;

	user=getpwuid(getuid());

	tmp_ch=(char*)malloc(strlen(user->pw_dir)+strlen(APP_NAME)+2);
	sprintf(tmp_ch,"%s/%s",user->pw_dir,APP_NAME);
	mkdir(tmp_ch, 0777);
	free(tmp_ch);

	tmp_ch=(char*)malloc(strlen(user->pw_dir)+strlen(APP_NAME)+strlen(SAVE_FILE)+3);
	sprintf(tmp_ch,"%s/%s/%s",user->pw_dir,APP_NAME,SAVE_FILE);
#else
	tmp_ch=(char*)malloc(512);
	getcwd(tmp_ch,512);
	sprintf(tmp_ch,"%s\\%s",tmp_ch,APP_NAME);
	mkdir(tmp_ch);
	free(tmp_ch);
	tmp_ch=(char*)malloc(512);
	getcwd(tmp_ch,512);
	sprintf(tmp_ch,"%s\\%s\\%s",tmp_ch,APP_NAME,SAVE_FILE);
#endif
#endif
	fd=fopen(tmp_ch,"w");
	if(!fd)
	{	perror(tmp_ch);
		printf("Cannot write open : %s\n",tmp_ch);
		free(tmp_ch);
		return 1;
	}
	free(tmp_ch);

	for(i=0;i<lvl_list->size;i++)
	{	level_desc * current=GetPosList(lvl_list,i);
		if(current->level_status != CLOSE)
		{	tmp_ch=(char*)malloc(strlen(world.world_name)+strlen(current->level_name)+4);
			sprintf(tmp_ch,"%s+%s+%01d",world.world_name,current->level_name,(int)current->level_status);
			fprintf(fd,"%s\n",tmp_ch);
		}
	}
	for(i=0;i<open_list->size;i++)
	{	tmp_ch=GetPosList(open_list,i);
		if(strncmp(world.world_name,tmp_ch,strlen(world.world_name)))
		{	fprintf(fd,"%s\n",tmp_ch);
		}
	}
	fclose(fd);
	return 0;
}
