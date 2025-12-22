/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

# include "menu.h"

mySprite * draw_backgrnd(char action, void * element)
{	mySprite * backgrnd;

	if(action==DO_DRAW)
	{	if(element)
			displaySprite( *(mySprite *)element,g_SDL_screen,0,0);
		return NULL;
	}
	else if(action==DO_INIT)
	{	backgrnd=(mySprite *)malloc(sizeof(mySprite));
		assert(backgrnd);
		backgrnd->image = IMG_Load((char*)element);
		if(!backgrnd->image)
			fprintf(stderr,"Cannot load : %s\n",(char*)element);
		backgrnd->posX=0;
		backgrnd->posY=0;
		backgrnd->etat=ETAT_VISIBLE;
		return backgrnd;
	}
	else if(action==DO_FREE)
	{	if(element)
		{	SDL_FreeSurface( ((mySprite *)element)->image);
			free(element);
		}
		return NULL;
	}
	assert(action!=action);
	return NULL;
}

void draw_menu(char action)
{	static mySprite choice, history;
	static int progress;
	
	if(action==DO_INIT)
	{	choice=font_long_text("[CHOICE]",0,0);
		history=font_long_text("[HISTORY]",0,0);
		progress=-120<<1;
	}
	else if(action==DO_FREE)
	{	SDL_FreeSurface(choice.image);choice.image=NULL;
		SDL_FreeSurface(history.image);history.image=NULL;
	}
	else if(action==DO_DRAW)
	{	SDL_Rect src, dest;

		displaySprite(choice,g_SDL_screen,615, 30);
		
		src.x = 0;		src.y = progress>>1;
		src.w = 400;		src.h = 120;
		dest.x = 160;		dest.y = 440;
		SDL_BlitSurface(history.image, &src, g_SDL_screen, &dest);
		
		progress++;
		if( progress>>1 > history.image->h)
			progress=-120<<1;
	}
}

void main_credits(Uint8 show_FPS)
{	mySprite * background;
	mySprite text;

	/* font initialisation */
	{SDL_Color myText_bg={255,255,255};
	SDL_Color myText_fg={255,20,20};
	font_select(FONT_NAME,30,myText_fg,myText_bg,180);
	}
	
	text=font_long_text("[CREDITS]",0,0);
	text.posY=40;
	text.posX=g_SDL_screen->w/2 - text.image->w/2;
	background=draw_backgrnd(DO_INIT,"gfx/ihm/beach.jpg");

	/* ré-init des évènements */
	events_init();
		
	while(!any_event_found())
	{	all_events_status events;
	
		draw_backgrnd(DO_DRAW,background);
		displaySprite(text,g_SDL_screen,0,0);

		/* envoi au hard */
		SDL_Flip(g_SDL_screen);

		/* on bloque à 30 FPS */
		coef_frame_rate(show_FPS);

		events=events_get_all();	
		if(events.f_kp)
		{	SDL_WM_ToggleFullScreen(g_SDL_screen);
			events_init();
		}
	}
	draw_backgrnd(DO_FREE,background);
	SDL_FreeSurface(text.image);
}

int main_menu(Uint8 show_FPS,char ** worldname)
{
	int action=0;
	mySprite * background;
	
	/* font initialisation */
	SDL_Color myText_bg={255,255,255};
	SDL_Color myText_fg={255,20,20};
	font_select(FONT_NAME,20,myText_fg,myText_bg,180);

	/* ré-init des évènements */
	events_init();

	background=draw_backgrnd(DO_INIT,"gfx/ihm/menu.jpg");
	draw_menu(DO_INIT);

	while(1)
	{	all_events_status events;
	
		draw_backgrnd(DO_DRAW,background);
		draw_menu(DO_DRAW);

		/* envoi au hard */
		SDL_Flip(g_SDL_screen);

		/* on bloque à 30 FPS */
		coef_frame_rate(show_FPS);

		events=events_get_all();	
		if(events.f_kp)
			SDL_WM_ToggleFullScreen(g_SDL_screen);
		if(events.n1_kp) /* start wld1 */
		{	action=0;
			*worldname="lvl/world.wld";
			break;
		}
		if(events.n2_kp) /* start wld2 */
		{	action=0;
			*worldname="lvl/world2.wld";
			break;
		}
		if(events.n3_kp) /* configure keys */
		{	main_edit_keys(show_FPS);
			events_init();
		}
		if(events.n4_kp) /* credits */
		{	main_credits(show_FPS);
			events_init();
		}
		if(events.n5_kp  /* quit */
		 || events.quit || events.esc)
		{	action=2;
			break;
		}
	}

	draw_menu(DO_FREE);
	draw_backgrnd(DO_FREE,background);

	printf("returning\n");
	return action;
}
