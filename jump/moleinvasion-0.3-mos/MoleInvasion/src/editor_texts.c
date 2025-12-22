/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */
  
#include "editor_texts.h"

char process_yesno_events(void)
{	all_events_status events;

	events=events_get_all();
	if(events.y_kp || events.s_kp || events.o_kp )	return 1;
	if(events.n_kp)	return 0;
	if(events.quit)	quit(0);
	if(events.esc)	return 2;
	if(events.f_kp)	SDL_WM_ToggleFullScreen(g_SDL_screen);
	return -1;
}

char process_choice_events(void)
{	all_events_status events;

	events=events_get_all();
	if(events.n0_kp)return 0;
	if(events.n1_kp)return 1;
	if(events.n2_kp)return 2;
	if(events.n3_kp)return 3;
	if(events.n4_kp)return 4;
	if(events.n5_kp)return 5;
	if(events.n6_kp)return 6;
	if(events.n7_kp)return 7;
	if(events.n8_kp)return 8;
	if(events.n9_kp)return 9;
	if(events.quit)	quit(0);
	if(events.esc)	quit(0);
	if(events.f_kp)	SDL_WM_ToggleFullScreen(g_SDL_screen);
	return -1;
}

char wantToSave(char * file)
{	mySprite text, filename, pt;
	int ret=-1;

	SDL_Color myText_fg={255,0,0};
	SDL_Color myText_bg={0,0,0};

	font_select(FONT_NAME,30,myText_fg,myText_bg,SDL_ALPHA_OPAQUE);

	text = font_long_text("[WANTTOSAVE]",0, 0);
	text.posX = 800/2 - text.image->w/2;
	text.posY = 600/2 - text.image->h;

	filename=font_text(file,0,0);
	filename.posX = 800/2 - filename.image->w/2;
	filename.posY = 600/2;

	pt = font_long_text("[YESNO]",0, 0);
	pt.posX = 800/2 - pt.image->w/2;
	pt.posY = 600/2 + pt.image->h;
	
	events_init();
	while(ret<0)
	{	SDL_FillRect(g_SDL_screen,NULL,SDL_MapRGB(g_SDL_screen->format, 0, 0, 0));

		displaySprite(text,g_SDL_screen,0,0);
		displaySprite(filename,g_SDL_screen,0,0);
		displaySprite(pt,g_SDL_screen,0,0);
		coef_frame_rate(0);
		SDL_Flip(g_SDL_screen);
		ret=process_yesno_events();
		if(ret==2)quit(0);
	}
	return ret;
}

char confirmToSave(level_info level_infos)
{	mySprite name, author, music, time, backgrnd, wall, foregrnd;
	mySprite name_val, author_val, music_val, time_val, backgrnd_val, wall_val, foregrnd_val;
	mySprite text, pt;
	char * ptr,buff[10];
	int ret=-1, posY;

	SDL_Color myText_fg={255,0,0};
	SDL_Color myText_bg={0,0,0};

	font_select(FONT_NAME,30,myText_fg,myText_bg,SDL_ALPHA_OPAQUE);
	posY=50;

	name = font_text("NAME=",0, 0);
	name.posX = 800/2 - name.image->w;
	name_val = font_text(level_infos.level_name,800/2, 0);
	name.posY = name_val.posY = posY;posY+=name.image->h;

	author = font_text("AUTHOR=",0, 0);
	author.posX = 800/2 - author.image->w;
	author_val = font_text(level_infos.author_name,800/2, 0);
	author.posY = author_val.posY = posY;posY+=name.image->h;

	music = font_text("MUSIC=",0, 0);
	music.posX = 800/2 - music.image->w;
	music_val = font_text(level_infos.music_file,800/2, 0);
	music.posY = music_val.posY = posY;posY+=name.image->h;

	time = font_text("TIME=",0, 0);
	time.posX = 800/2 - time.image->w;
	sprintf(buff,"%d",level_infos.time_limit);
	time_val = font_text(buff,800/2,0);
	time.posY = time_val.posY = posY;posY+=name.image->h;

	backgrnd = font_text("BACKGROUND=",0, 0);
	backgrnd.posX = 800/2 - backgrnd.image->w;
	backgrnd_val = font_text(level_infos.background,800/2, 0);
	backgrnd.posY = backgrnd_val.posY = posY;posY+=name.image->h;

	wall = font_text("WALL_GFX_DIR=",0, 0);
	wall.posX = 800/2 - wall.image->w;
	wall_val = font_text(level_infos.wall_gfx_dir,800/2, 0);
	wall.posY = wall_val.posY = posY;posY+=name.image->h;

	foregrnd = font_text("FOREGROUND=",0, 0);
	foregrnd.posX = 800/2 - foregrnd.image->w;
	switch(level_infos.foreground)
	{case FRGRND_CLOUDS:ptr="CLOUDS";break;
	case FRGRND_RAIN:ptr="RAIN";break;
	case FRGRND_NIGHT:ptr="NIGHT";break;
	default:ptr="NONE";break;
	}
	foregrnd_val = font_text(ptr,800/2, 0);
	foregrnd.posY = foregrnd_val.posY = posY;posY+=name.image->h;
	
	posY+=50;

	text = font_long_text("[CONFIRM]",0, 0);
	text.posX = 800/2 - text.image->w/2;
	text.posY = posY;posY+=name.image->h;

	pt = font_long_text("[YESNO]",0, 0);
	pt.posX = 800/2 - pt.image->w/2;
	pt.posY = posY;posY+=name.image->h;

	events_init();
	while(ret<0)
	{	SDL_FillRect(g_SDL_screen,NULL,SDL_MapRGB(g_SDL_screen->format, 0, 0, 0));

		displaySprite(name,g_SDL_screen,0,0);
		displaySprite(author,g_SDL_screen,0,0);
		displaySprite(music,g_SDL_screen,0,0);
		displaySprite(time,g_SDL_screen,0,0);
		displaySprite(backgrnd,g_SDL_screen,0,0);
		displaySprite(wall,g_SDL_screen,0,0);
		displaySprite(foregrnd,g_SDL_screen,0,0);

		displaySprite(name_val,g_SDL_screen,0,0);
		displaySprite(author_val,g_SDL_screen,0,0);
		displaySprite(music_val,g_SDL_screen,0,0);
		displaySprite(time_val,g_SDL_screen,0,0);
		displaySprite(backgrnd_val,g_SDL_screen,0,0);
		displaySprite(wall_val,g_SDL_screen,0,0);
		displaySprite(foregrnd_val,g_SDL_screen,0,0);

		displaySprite(text,g_SDL_screen,0,0);
		displaySprite(pt,g_SDL_screen,0,0);

		coef_frame_rate(0);
		SDL_Flip(g_SDL_screen);
		ret=process_yesno_events();
		if(ret==2)quit(0);
	}
	return ret;
}

void simpleMessage(char * mesId)
{	mySprite text;

	SDL_Color myText_fg={255,0,0};
	SDL_Color myText_bg={0,0,0};

	font_select(FONT_NAME,30,myText_fg,myText_bg,SDL_ALPHA_OPAQUE);

	text = font_long_text(mesId,0, 0);
	text.posX = 800/2 - text.image->w/2;
	text.posY = 600/2 - text.image->h/2;

	events_init();
	while(!any_event_found())
	{	SDL_FillRect(g_SDL_screen,NULL,SDL_MapRGB(g_SDL_screen->format, 0, 0, 0));

		displaySprite(text,g_SDL_screen,0,0);

		coef_frame_rate(0);
		SDL_Flip(g_SDL_screen);
	}
}
