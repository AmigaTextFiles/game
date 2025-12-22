/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include <assert.h>
#include "events.h"

/* configurable keys */
# define MIK_LEFT	0
# define MIK_RIGHT	1
# define MIK_JUMP	2
# define MIK_DOWN	3
# define MIK_ACCEL	4
# define MIK_SPECIAL	5

/* config par défaut */
static key_config_desc key_config[] = 
{{SDLK_LEFT	,NULL,	"[LEFT_KEY]"		},
 {SDLK_RIGHT	,NULL,	"[RIGHT_KEY]"		},
 {SDLK_UP	,NULL,	"[JUMP_KEY]"		},
 {SDLK_DOWN	,NULL,	"[DOWN_KEY]"		},
 {SDLK_LALT	,NULL,	"[ACCEL_KEY]"		},
 {SDLK_SPACE	,NULL,	"[SPECIAL_KEY]"		}};

static all_events_status all_current_events;
static char any_key_pressed;

/* réinitialise seuls les évènements "key-pressed" */
void events_kp_init()
{	all_current_events.F1_kp	= all_current_events.F2_kp      = 
	all_current_events.F3_kp	= all_current_events.F4_kp      = 
	all_current_events.F5_kp	= all_current_events.F6_kp      = 
	all_current_events.F7_kp	= all_current_events.F8_kp      = 

	all_current_events.n0_kp        = all_current_events.n1_kp      = 
	all_current_events.n2_kp        = all_current_events.n3_kp      = 
	all_current_events.n4_kp        = all_current_events.n5_kp      = 
	all_current_events.n6_kp        = all_current_events.n7_kp      = 
	all_current_events.n8_kp        = all_current_events.n9_kp      = 

	all_current_events.y_kp = all_current_events.o_kp =
	all_current_events.s_kp = all_current_events.n_kp =
	all_current_events.f_kp = all_current_events.p_kp =
	
	all_current_events.special_kp = all_current_events.jump_kp =
	
	all_current_events.arrow_up_kp   = all_current_events.arrow_down_kp  =
	all_current_events.arrow_left_kp = all_current_events.arrow_right_kp = 0;
}

/* réinitialise tous les évènements */
void events_init()
{	all_current_events.left		= all_current_events.right	=
	all_current_events.jump		= all_current_events.down	=
	all_current_events.space	= all_current_events.quit	=
	all_current_events.esc		= all_current_events.accel	= 
	any_key_pressed	= 0;
	events_kp_init();
}

static void handle_key( SDL_keysym* keysym, int pressed )
{
	/* configurable keys */
	if(keysym->sym==key_config[MIK_LEFT].key)
		all_current_events.left =pressed;
	else if(keysym->sym==key_config[MIK_RIGHT].key)
		all_current_events.right=pressed;
	else if(keysym->sym==key_config[MIK_JUMP].key)
		all_current_events.jump =pressed;
	else if(keysym->sym==key_config[MIK_DOWN].key)
		all_current_events.down =pressed;
	else if(keysym->sym==key_config[MIK_ACCEL].key)
		all_current_events.accel=pressed;
	/* others */
	switch( keysym->sym ) {
	case SDLK_SPACE:	all_current_events.space=pressed; break;
	case SDLK_ESCAPE:	all_current_events.esc	=pressed; break;
	default:	break;
	}

	if(pressed)
	{	/* configurable keys */
		if(keysym->sym==key_config[MIK_JUMP].key)
			all_current_events.jump_kp = 1;
		else if(keysym->sym==key_config[MIK_SPECIAL].key)
			all_current_events.special_kp = 1;
		/* others */
		switch( keysym->sym ) {
		case SDLK_F1:	all_current_events.F1_kp = 1; break;
		case SDLK_F2:	all_current_events.F2_kp = 1; break;
		case SDLK_F3:	all_current_events.F3_kp = 1; break;
		case SDLK_F4:	all_current_events.F4_kp = 1; break;
		case SDLK_F5:	all_current_events.F5_kp = 1; break;
		case SDLK_F6:	all_current_events.F6_kp = 1; break;
		case SDLK_F7:	all_current_events.F7_kp = 1; break;
		case SDLK_F8:	all_current_events.F8_kp = 1; break;

		case SDLK_0:case SDLK_KP0:case SDLK_WORLD_64:	all_current_events.n0_kp = 1; break;
		case SDLK_1:case SDLK_KP1:case SDLK_AMPERSAND:	all_current_events.n1_kp = 1; break;
		case SDLK_2:case SDLK_KP2:case SDLK_WORLD_73:	all_current_events.n2_kp = 1; break;
		case SDLK_3:case SDLK_KP3:case SDLK_QUOTEDBL:	all_current_events.n3_kp = 1; break;
		case SDLK_4:case SDLK_KP4:case SDLK_QUOTE:	all_current_events.n4_kp = 1; break;
		case SDLK_5:case SDLK_KP5:case SDLK_LEFTPAREN:	all_current_events.n5_kp = 1; break;
		case SDLK_6:case SDLK_KP6:case SDLK_MINUS:	all_current_events.n6_kp = 1; break;
		case SDLK_7:case SDLK_KP7:case SDLK_WORLD_72:	all_current_events.n7_kp = 1; break;
		case SDLK_8:case SDLK_KP8:case SDLK_UNDERSCORE:	all_current_events.n8_kp = 1; break;
		case SDLK_9:case SDLK_KP9:case SDLK_WORLD_71:	all_current_events.n9_kp = 1; break;

		case SDLK_f:	all_current_events.f_kp = 1; break;
		case SDLK_y:	all_current_events.y_kp = 1; break;
		case SDLK_o:	all_current_events.o_kp = 1; break;
		case SDLK_p:	all_current_events.p_kp = 1; break;
		case SDLK_s:	all_current_events.s_kp = 1; break;
		case SDLK_n:	all_current_events.n_kp = 1; break;
		
		case SDLK_LEFT:	all_current_events.arrow_left_kp = 1; break;
		case SDLK_RIGHT:all_current_events.arrow_right_kp= 1; break;
		case SDLK_UP:	all_current_events.arrow_up_kp	 = 1; break;
		case SDLK_DOWN:	all_current_events.arrow_down_kp = 1; break;
		
		default:	break;
		}
	}
}

all_events_status events_get_all()
{
	SDL_Event event;

	events_kp_init();
	while( SDL_PollEvent( &event ) ) 
	{	switch( event.type )
		{case SDL_KEYDOWN:
	    	    handle_key( &event.key.keysym,1 );
	    	    any_key_pressed=1;
	    	    break;
		case SDL_KEYUP:
	    	    handle_key( &event.key.keysym,0 );
	    	    any_key_pressed=0;
	    	    break;
		case SDL_QUIT:
	    	    all_current_events.quit=1;
	    	    break;
	    }
	}
	return all_current_events;
}

int any_event_found(void)
{	events_get_all();
	return any_key_pressed;
}

myList * get_current_config(void)
{	myList * retour = InitList();
	key_config_desc value;
	int i;

	if(!retour)
		return NULL;

	for(i=0;i<sizeof(key_config)/sizeof(key_config[0]);i++)
	{	value.key=key_config[i].key;
		value.txt_key=SDL_GetKeyName(key_config[i].key);
		value.txt_id=key_config[i].txt_id;
		AddToList(retour,&value,sizeof(key_config_desc));
	}
	return retour;
}

void change_key_config(int pos)
{	SDL_Event event;

	assert(pos<sizeof(key_config)/sizeof(key_config[0]));

	while( SDL_WaitEvent( &event ) )
		if( event.type == SDL_KEYDOWN )
		{	key_config[pos].key = event.key.keysym.sym;
			break;
		}
}


int save_keyconfig()
{	int i;
	FILE * fd;
	char * tmp_ch;
#ifdef __MORPHOS__
	tmp_ch=(char*)malloc(strlen(DATADIR) + strlen(KEYCONFIG_FILE) + 1);
	sprintf(tmp_ch, "%s%s", DATADIR, KEYCONFIG_FILE);
#else
#ifndef WIN32
	struct passwd * user;

	user=getpwuid(getuid());

	tmp_ch=(char*)malloc(strlen(user->pw_dir)+strlen(APP_NAME)+strlen(KEYCONFIG_FILE)+3);
	sprintf(tmp_ch,"%s/%s/%s",user->pw_dir,APP_NAME,KEYCONFIG_FILE);
#else
	tmp_ch=(char*)malloc(512);
	getcwd(tmp_ch,512);
	sprintf(tmp_ch,"%s\\%s\\%s",tmp_ch,APP_NAME,KEYCONFIG_FILE);
#endif
#endif

	fd=fopen(tmp_ch,"w");
	if(!fd)
	{	perror(tmp_ch);
		free(tmp_ch);
		return EXIT_FAILURE;
	}
	free(tmp_ch);
	for(i=0;i<sizeof(key_config)/sizeof(key_config[0]);i++)
		fprintf(fd,"%s \t %d\n",key_config[i].txt_id,key_config[i].key);
	fclose(fd);
	return EXIT_SUCCESS;
}

int load_keyconfig()
{	int key,i;
	FILE * fd;
	char * tmp_ch;
	char buffer[256];
#ifdef __MORPHOS__
	tmp_ch=(char*)malloc(strlen(DATADIR) + strlen(KEYCONFIG_FILE) + 1);
	sprintf(tmp_ch, "%s%s", DATADIR, KEYCONFIG_FILE);
#else
#ifndef WIN32
	struct passwd * user;

	user=getpwuid(getuid());

	tmp_ch=(char*)malloc(strlen(user->pw_dir)+strlen(APP_NAME)+strlen(KEYCONFIG_FILE)+3);
	sprintf(tmp_ch,"%s/%s/%s",user->pw_dir,APP_NAME,KEYCONFIG_FILE);
#else
	tmp_ch=(char*)malloc(512);
	getcwd(tmp_ch,512);
	sprintf(tmp_ch,"%s\\%s\\%s",tmp_ch,APP_NAME,KEYCONFIG_FILE);
#endif
#endif

	fd=fopen(tmp_ch,"r");
	if(!fd)
	{	perror(tmp_ch);
		free(tmp_ch);
		return EXIT_FAILURE;
	}
	free(tmp_ch);
	
	while(fscanf(fd,"%255s %d",buffer,&key)==2)
	{	for(i=0;i<sizeof(key_config)/sizeof(key_config[0]);i++)
		{	if(strcmp(key_config[i].txt_id,buffer)==0)
			{	key_config[i].key=key;
				break;
			}
		}
	}
	return EXIT_SUCCESS;
}
