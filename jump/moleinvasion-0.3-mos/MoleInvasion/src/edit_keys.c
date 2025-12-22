/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

# include "edit_keys.h"

void draw_config(char action)
{	static myList * keys;
	static mySprite question, yesno;
	static mySprite * text=NULL;
	static mySprite * value=NULL;
	int i;

	if(action==DO_INIT)
	{	keys = get_current_config();
		if(keys)
			for(i=0;i<keys->size;i++)
			{	key_config_desc * info =  GetPosList(keys ,i);
				text=(mySprite *)realloc(text,sizeof(mySprite)*(i+1));
				value=(mySprite *)realloc(value,sizeof(mySprite)*(i+1));
				text[i]=font_long_text(info->txt_id,0,0);
				value[i]=font_text(info->txt_key,0,0);
				printf("(%s-%s)\n",info->txt_id,info->txt_key);
			}
		question=font_long_text("[AGREE_CONFIG]",0,0);
		yesno=font_long_text("[YESNO]",0,0);
	}
	else if(action==DO_FREE)
	{	for(i=0;i<keys->size;i++)
		{	SDL_FreeSurface(text[i].image);
			SDL_FreeSurface(value[i].image);
		}
		free(text);text=NULL;
		free(value);value=NULL;
		FreeList(keys);keys=NULL;
		SDL_FreeSurface(question.image);question.image=NULL;
		SDL_FreeSurface(yesno.image);yesno.image=NULL;
	}
	else if(action==DO_DRAW)
	{	int pos=40, decalX=200;

		displaySprite(question,g_SDL_screen,g_SDL_screen->w/2 - question.image->w/2, pos);
		pos+=question.image->h+40;
		if(keys)
			for(i=0;i<keys->size;i++)
			{	displaySprite(text[i],g_SDL_screen,g_SDL_screen->w/2 - 10 - text[i].image->w + decalX ,pos);
				displaySprite(value[i],g_SDL_screen,g_SDL_screen->w/2 + 10 + decalX ,pos);
				pos+=text[i].image->h+10;
			}
		pos+=40;
		displaySprite(yesno,g_SDL_screen,g_SDL_screen->w/2 - yesno.image->w/2, pos);
	}
}

void reconfigure_keys(mySprite * background)
{	int i,pos;
	myList * keys=get_current_config();
	mySprite question,key;
	
	for(i=0;i<keys->size;i++)
	{	key_config_desc * info =  GetPosList(keys ,i);
	
		question=font_long_text("[PRESSKEY]",0,0);
		key=font_long_text(info->txt_id,0,0);

		pos=100;
		draw_backgrnd(DO_DRAW,background);
		displaySprite(question,g_SDL_screen,g_SDL_screen->w/2 - question.image->w/2, pos);
		pos+=question.image->h+10;
		displaySprite(key,g_SDL_screen,g_SDL_screen->w/2 - key.image->w/2, pos);

		/* envoi au hard */
		SDL_Flip(g_SDL_screen);

		change_key_config(i);

		SDL_FreeSurface(question.image);
		SDL_FreeSurface(key.image);
	}
	save_keyconfig();
	FreeList(keys);
}

int main_edit_keys(Uint8 show_FPS)
{
	int action;
	mySprite * background;
	
	/* font initialisation */
	SDL_Color myText_bg={255,255,255};
	SDL_Color myText_fg={255,20,20};
	font_select(FONT_NAME,40,myText_fg,myText_bg,180);

	/* ré-init des évènements */
	events_init();

	background=draw_backgrnd(DO_INIT,"gfx/ihm/beach.jpg");
	draw_config(DO_INIT);

	while(1)
	{	draw_backgrnd(DO_DRAW,background);
		draw_config(DO_DRAW);

		/* envoi au hard */
		SDL_Flip(g_SDL_screen);

		/* on bloque à 30 FPS */
		coef_frame_rate(show_FPS);

		action=process_yesno_events();
		if(action==0 || action==2)
			break;
		if(action==1)
		{	reconfigure_keys(background);
			draw_config(DO_FREE);
			draw_config(DO_INIT);
		}
	}

	draw_config(DO_FREE);
	draw_backgrnd(DO_FREE,background);

	printf("returning\n");
	return 0;
}
