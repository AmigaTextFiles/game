/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include "font.h"

#define LONG_TXT_FILE "long_texts.txt"

static TTF_Font * g_static_font=NULL;
static SDL_Color g_static_fg;
static SDL_Color g_static_bg;
static Uint8 g_alpha;
static int g_static_font_init=0;
static int g_static_font_select=0;

static SDL_Surface* g_static_all_int[10];

int font_init()
{	g_static_font_init=1;
	return TTF_Init();
}

SDL_Surface * static_font_text(char * txt, char alpha)
{	SDL_Surface * img_txt, *img_txt_ret;

	if(!g_static_font || !g_static_font_select)
	{	fprintf(stderr,"font not initialised!\n");
		return NULL;
	}
	img_txt=TTF_RenderText_Shaded(g_static_font, txt, g_static_fg, g_static_bg);
	if(!img_txt)
	{	fprintf(stderr,"TTF_RenderText_Shaded:%s\n",TTF_GetError());
		return NULL;
	}
	if(alpha)
	{	SDL_SetColorKey(img_txt, SDL_SRCCOLORKEY|SDL_RLEACCEL,
			SDL_MapRGB(img_txt->format, g_static_bg.r, g_static_bg.g, g_static_bg.b));
		if(g_alpha!=SDL_ALPHA_OPAQUE)
			SDL_SetAlpha(img_txt,SDL_SRCALPHA|SDL_RLEACCEL,g_alpha);
	}

	img_txt_ret=SDL_DisplayFormat(img_txt);
	SDL_FreeSurface(img_txt);

	return img_txt_ret;
}

TTF_Font * font_select(char * file_ttf,int size, SDL_Color fg, SDL_Color bg, Uint8 alpha)
{	int i;
	if(!g_static_font_init)
		font_init();

	if(g_static_font)
	{	TTF_CloseFont(g_static_font);
		for(i=0;i<10;i++)
			SDL_FreeSurface(g_static_all_int[i]);
	}
	g_static_font = TTF_OpenFont(file_ttf, size);
	if(!g_static_font)
	{	fprintf(stderr,"TTF_OpenFont:%s\n",TTF_GetError());
		g_static_font_select=0;
		return NULL;
	}

	g_static_font_select=1;

	g_static_fg=fg;
	g_static_bg=bg;

	g_alpha=alpha;
	
	for(i=0;i<10;i++)
	{	char txt[2];
		txt[1]=0;
		txt[0]=i+'0';
		g_static_all_int[i]=static_font_text(txt,1);
	}
	return g_static_font;
}

mySprite font_text(char * txt,int x, int y)
{	mySprite myText;

	myText.image=static_font_text(txt,1);
	myText.map=NULL;
	myText.posX=x;	myText.posY=y;
	myText.etat=ETAT_VISIBLE;

	return myText;
}

int font_render_integer(unsigned int value,int x, int y)
{	char tmp_txt[50];
	int i,posx=x;
	mySprite myText;

	if(!g_static_font || !g_static_font_select)
	{	fprintf(stderr,"font not initialised!\n");
		return 1;
	}

	sprintf(tmp_txt,"%49d",value);
	for(i=0;i<50;i++)
	{	if(tmp_txt[i]>='0' && tmp_txt[i]<='9')
		{	myText.image=g_static_all_int[tmp_txt[i]-'0'];
			myText.map=NULL;
			myText.posX=posx;	myText.posY=y;
			myText.etat=ETAT_VISIBLE;
			displaySprite(myText,g_SDL_screen,0,0);
			posx+=myText.image->w;
		}
	}
	return 0;
}

mySprite font_long_text(char * id,int x, int y)
{	mySprite myText;
	char buffer[255],*ptr;
	FILE * fd=NULL;

	if(getenv("LANG") && strchr(getenv("LANG"),'_'))
	{	snprintf(buffer,sizeof(buffer)-1-strlen(LONG_TXT_FILE),
			"txt/%s",getenv("LANG"));
		ptr=strchr(buffer,'_');
		sprintf(ptr,"_%s",LONG_TXT_FILE);

		if(strncmp(getenv("LANG"),"en",2))
		{	fd=fopen(buffer,"r");
			if(!fd)
				fprintf(stderr,"Cannot open : %s\n",buffer);
		}
	}
	if(!fd)
	{	snprintf(buffer,sizeof(buffer),"txt/%s",LONG_TXT_FILE);
		fd=fopen(buffer,"r");
	}
	if(fd)
	{	char is_in=0;
		SDL_Surface *tmpText0=NULL;

		while(!feof(fd))
		{	memset(buffer,0,sizeof(buffer));
			if(!fgets(buffer,sizeof(buffer),fd))
				continue;
			if(buffer[strlen(buffer)-1]=='\n')buffer[strlen(buffer)-1]=0;
			if(buffer[0] == '[')
			{	is_in=0;
				if(strncmp(buffer,id,strlen(id))==0)
					is_in=1;
			}
			else if(is_in)
			{	SDL_Surface *tmpText1,*tmpText2;
				SDL_Rect dest;
		
			/*	printf("READ : '%s'\n",buffer);*/
				if(strlen(buffer)<1)
				{	buffer[0]=' ';
					buffer[1]=0;
				}
				tmpText1=static_font_text(buffer,0);
				if(tmpText0)
				{	tmpText2=SDL_CreateRGBSurface(0,
						tmpText0->w>tmpText1->w?tmpText0->w:tmpText1->w ,
						tmpText0->h + tmpText1->h ,
						tmpText0->format->BitsPerPixel,
						tmpText0->format->Rmask, tmpText0->format->Gmask,
						tmpText0->format->Bmask, tmpText0->format->Amask);
					SDL_FillRect(tmpText2, NULL, SDL_MapRGB(tmpText2->format, g_static_bg.r, g_static_bg.g, g_static_bg.b));
					SDL_BlitSurface(tmpText0, NULL, tmpText2, NULL);
					dest.x = 0;
					dest.y = tmpText0->h;
					SDL_BlitSurface(tmpText1, NULL, tmpText2, &dest);
					SDL_FreeSurface(tmpText1);
					tmpText1=tmpText0;
					tmpText0=tmpText2;
					SDL_FreeSurface(tmpText1);
				}
				else
				{	tmpText0=tmpText1;
				}
			}
		}
		myText.image=NULL;
		if(tmpText0)
		{	SDL_SetColorKey(tmpText0, SDL_SRCCOLORKEY|SDL_RLEACCEL,
				SDL_MapRGB(tmpText0->format, g_static_bg.r, g_static_bg.g, g_static_bg.b));
			myText.image=SDL_DisplayFormat(tmpText0);
			SDL_FreeSurface(tmpText0);
		}
		else
			myText.image=static_font_text(id,1);
		fclose(fd);
	}
	else
	{	fprintf(stderr,"Cannot open %s for %s: %s\n",LONG_TXT_FILE,id,strerror(errno));
		myText.image=NULL;
		quit(1);
	}
	myText.map=NULL;
	myText.posX=x;	myText.posY=y;
	myText.etat=ETAT_VISIBLE;

	if(g_alpha!=SDL_ALPHA_OPAQUE)
		SDL_SetAlpha(myText.image,SDL_SRCALPHA|SDL_RLEACCEL,g_alpha);
	
	return myText;
}

