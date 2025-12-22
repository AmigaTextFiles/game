/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#define GRAPHICS_C
#include "graphics.h"

void quit( int code )
{
    SDL_Quit( );
    exit( code );
}

Uint32 coef_frame_rate(char show_FPS)
{	static Uint32 totalTime=0;
	static Uint32 lastTime=0;
	static int nb_frame=0;
	Uint32 interval,currentTime,before;
	
	before = SDL_GetTicks();

	/* on bloque à 30 FPS soit 33ms/frame en déchargeant le CPU */
	while(SDL_GetTicks()-lastTime< 3)SDL_Delay(21);
	while(SDL_GetTicks()-lastTime<13)SDL_Delay(11);
	while(SDL_GetTicks()-lastTime<23)SDL_Delay(1);
	while(SDL_GetTicks()-lastTime<33);

	currentTime = SDL_GetTicks();
	interval=currentTime-lastTime;
//	printf("cur:%u bef:%u lst:%u total:%u inter:%u\n",currentTime,before,lastTime,totalTime,interval);
	lastTime=currentTime;
	nb_frame++;

	totalTime+=interval;
	if(totalTime>1000)
	{	/*printf("FPS : %f\n",((float)(nb_frame*1000)/(float)interval));*/
		if(show_FPS)printf("FPS : %d\n",nb_frame);
		totalTime=0;
		nb_frame=0;
	}

	return interval;
}

SDL_Surface * IMG_LoadOptCkey(char *filename)
{	Uint32 colorkey;
	SDL_Surface *tmp, *ret;

	tmp=IMG_Load(filename);
	if(!tmp)
	{	fprintf(stderr,"Cannot load : %s\n",filename);
		return NULL;
	}
	colorkey = SDL_MapRGB(tmp->format, 0, 0, 0); 
	SDL_SetColorKey (tmp, SDL_SRCCOLORKEY|SDL_RLEACCEL, colorkey);
	ret=SDL_DisplayFormatAlpha(tmp);
	SDL_FreeSurface(tmp);
	return ret;
}

SDL_Surface * IMG_LoadOptAlpha(char *filename)
{	SDL_Surface *tmp, *ret;

	tmp=IMG_Load(filename);
	if(!tmp)
	{	fprintf(stderr,"Cannot load : %s\n",filename);
		return NULL;
	}
	SDL_SetAlpha    (tmp, SDL_SRCALPHA   |SDL_RLEACCEL, SDL_ALPHA_OPAQUE);
	ret=SDL_DisplayFormatAlpha(tmp);
	SDL_FreeSurface(tmp);
	return ret;
}

SDL_Surface * IMG_LoadOptNone(char *filename)
{	SDL_Surface *tmp, *ret;

	tmp=IMG_Load(filename);
	if(!tmp)
	{	fprintf(stderr,"Cannot load : %s\n",filename);
		return NULL;
	}
	ret=SDL_DisplayFormat(tmp);
	SDL_FreeSurface(tmp);
	return ret;
}

void imageGetPixel(SDL_Surface* image, 
		unsigned int x, unsigned int y,
		unsigned char *r, unsigned char *v ,unsigned char *b)
{
	SDL_PixelFormat * fmt;
	Uint32 pixel,temp;
	SDL_Color color;
/* BUG en 24 bpp */
	fmt=image->format;
	
	if( x<0 || x>=image->w || y<0 || y>=image->h )
	{	printf("Out Of bound %d %d : %d %d\n",image->w,image->h,x,y);
		*r=*v=*b=0;
		return;
	}
	
	if(image->format->BitsPerPixel != 8)
		printf("BitsPerPixel != 8 !\n");
	
	switch(image->format->BitsPerPixel)
	{case 8 :pixel=*((Uint8*)image->pixels+(x+image->pitch*y));
		color=fmt->palette->colors[pixel];
		*r=color.r;	*v=color.g;	*b=color.b;
		return;
	case 16 :pixel=*((Uint16*)image->pixels+(x+image->w*y));
		break;
	case 24 :pixel=*((Uint32*)image->pixels+(x+image->w*y));
		break;
	case 32 :pixel=*((Uint32*)image->pixels+(x+image->w*y));
		break;
	default :fprintf(stderr,"Format d'image inconnu !!??\n");
		return;
	}
	/* Get Red component */
	temp=pixel&fmt->Rmask; /* Isolate red component */
	temp=temp>>fmt->Rshift;/* Shift it down to 8-bit */
	temp=temp<<fmt->Rloss; /* Expand to a full 8-bit number */
	*r=(Uint8)temp;
	
	/* Get Green component */
	temp=pixel&fmt->Gmask; /* Isolate green component */
	temp=temp>>fmt->Gshift;/* Shift it down to 8-bit */
	temp=temp<<fmt->Gloss; /* Expand to a full 8-bit number */
	*v=(Uint8)temp;
	
	/* Get Blue component */
	temp=pixel&fmt->Bmask; /* Isolate blue component */
	temp=temp>>fmt->Bshift;/* Shift it down to 8-bit */
	temp=temp<<fmt->Bloss; /* Expand to a full 8-bit number */
	*b=(Uint8)temp;
}

char GFX_loadCompleteSprite(struct gsi * csp, char * sp_name,int spwall_id,char * spwall_gfx_dir,char *sp_map,char mode)
{	char buff[512];
	SDL_Surface* 	tmpgfx;
	struct stat fstatb;
	int cpt;

	assert(csp);

	/* en fonction du mode, on ne chargera que ce qui est necessaire */

	/* la map */
	sprintf(buff,"%s/%.200s",GFX_DIR,sp_map);
	tmpgfx=IMG_Load(buff);
	if(!tmpgfx)
	{	fprintf(stderr,"Cannot load %s\n",buff);
		quit(1);
	}
	csp->map=tmpgfx;
			
	/* la optmap */
	sprintf(buff,"%s/%.200s",GFX_DIR,sp_map);
	tmpgfx=IMG_LoadOptCkey(buff);
	if(!tmpgfx)
	{	fprintf(stderr,"Cannot load %s\n",buff);
		quit(1);
	}
	csp->optmap=tmpgfx;

	for(cpt=0;cpt<sizeof(csp->imgs)/sizeof(csp->imgs[0]);cpt++)
		csp->imgs[cpt]=NULL;
				
	/* les images */
	if(!sp_name)
	{	/* cas wall */
		csp->type=SINGLE;
		csp->imgs_cnt=1;
		tmpgfx=NULL;
		if(mode == EDITOR_MODE)
		{	sprintf(buff,"%s/%s/wall-%.2d-editor.png",GFX_DIR,spwall_gfx_dir,spwall_id);
			tmpgfx=IMG_LoadOptAlpha(buff);
		}
		if(!tmpgfx)
		{	sprintf(buff,"%s/%s/wall-%.2d.png",GFX_DIR,spwall_gfx_dir,spwall_id);
			tmpgfx=IMG_LoadOptAlpha(buff);
		}
		if(!tmpgfx)
		{	fprintf(stderr,"Cannot load %s\n",buff);
			quit(1);
		}
		csp->imgs[0]=tmpgfx;
	}
	
	else if(strstr(sp_name,".png"))
	{	/* cas image static */
		csp->type=SINGLE;
		csp->imgs_cnt=1;
		tmpgfx=NULL;
		if(mode == EDITOR_MODE)
		{	char* ptr;
			sprintf(buff,"%s/%.40s",GFX_DIR,sp_name);
			ptr=strstr(buff,".png");
			sprintf(ptr,"-editor.png");
			tmpgfx=IMG_LoadOptAlpha(buff);
		}
		if(!tmpgfx)
		{	sprintf(buff,"%s/%.40s",GFX_DIR,sp_name);
			tmpgfx=IMG_LoadOptAlpha(buff);
		}
		if(!tmpgfx)
		{	fprintf(stderr,"Cannot load %s\n",buff);
			quit(1);
		}
		csp->imgs[0]=tmpgfx;
	}

	else
	{	/* cas image animee */
		if( mode == GAME_MODE )
		{	/* recherche de "sprite1.png" ou "sprite-gche-jump.png" */
			sprintf(buff,"%s/%s/%s",GFX_DIR,sp_name,"sprite1.png");
			if(stat(buff,&fstatb) == 0)
			{	/* image de type LIST */
				csp->type=LIST;
				
				for(cpt=0;cpt<sizeof(csp->imgs)/sizeof(csp->imgs[0]);cpt++)
				{	sprintf(buff,"%s/%s/sprite%d.png",GFX_DIR,sp_name,cpt+1);
					if(stat(buff,&fstatb) != 0)
						break;
					tmpgfx=IMG_LoadOptAlpha(buff);
					if(!tmpgfx)
					{	fprintf(stderr,"Cannot load %s\n",buff);
						quit(1);
					}
					csp->imgs[cpt]=tmpgfx;
				}
				csp->imgs_cnt=cpt;
			}
			else
			{	sprintf(buff,"%s/%s/%s",GFX_DIR,sp_name,"sprite-gche-jump.png");
				if(stat(buff,&fstatb) == 0)
				{	/* image de type FULL */
					csp->type=FULL;
					sprintf(buff,"%s/%.20s/sprite-drte-stop.png",GFX_DIR,sp_name);csp->imgs[DRTE_STOP]=IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av1.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV1] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av2.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV2] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av3.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV3] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av4.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV4] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-jump.png",GFX_DIR,sp_name);csp->imgs[DRTE_JUMP]=IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-fall.png",GFX_DIR,sp_name);csp->imgs[DRTE_FALL]=IMG_LoadOptAlpha(buff);
	
					sprintf(buff,"%s/%.20s/sprite-gche-stop.png",GFX_DIR,sp_name);csp->imgs[GCHE_STOP]=IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av1.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV1] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av2.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV2] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av3.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV3] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av4.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV4] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-jump.png",GFX_DIR,sp_name);csp->imgs[GCHE_JUMP]=IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-fall.png",GFX_DIR,sp_name);csp->imgs[GCHE_FALL]=IMG_LoadOptAlpha(buff);
	
					csp->imgs_cnt=14;
					for(cpt=0;cpt<csp->imgs_cnt;cpt++)
						if (!csp->imgs[cpt])
						{	fprintf(stderr,"Sprite %s imcomplet !\n",sp_name);
							quit(1);
						}
				}
				else
				{	/* image de type SIMPLE */
					csp->type=SIMPLE;
					sprintf(buff,"%s/%.20s/sprite-drte-av1.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV1] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av2.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV2] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av3.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV3] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-drte-av4.png",GFX_DIR,sp_name); csp->imgs[DRTE_AV4] =IMG_LoadOptAlpha(buff);
	
					sprintf(buff,"%s/%.20s/sprite-gche-av1.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV1] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av2.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV2] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av3.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV3] =IMG_LoadOptAlpha(buff);
					sprintf(buff,"%s/%.20s/sprite-gche-av4.png",GFX_DIR,sp_name); csp->imgs[GCHE_AV4] =IMG_LoadOptAlpha(buff);
	
					csp->imgs_cnt=8;
					for(cpt=0;cpt<4;cpt++)
						if (!csp->imgs[cpt])
						{	fprintf(stderr,"Sprite %s imcomplet !\n",sp_name);
							quit(1);
						}
					for(cpt=7;cpt<11;cpt++)
						if (!csp->imgs[cpt])
						{	fprintf(stderr,"Sprite %s imcomplet !\n",sp_name);
							quit(1);
						}
				}
			}
		}
		else if (mode == EDITOR_MODE )
		{	csp->type=SINGLE;
			csp->imgs_cnt=1;
			tmpgfx=NULL;

			sprintf(buff,"%s/%.20s/editor.png",GFX_DIR,sp_name);
			tmpgfx=IMG_LoadOptAlpha(buff);
			if(!tmpgfx)
			{	sprintf(buff,"%s/%.20s/sprite1.png",GFX_DIR,sp_name);
				tmpgfx=IMG_LoadOptAlpha(buff);
			}
			if(!tmpgfx)
			{	sprintf(buff,"%s/%.20s/sprite-gche-av1.png",GFX_DIR,sp_name);
				tmpgfx=IMG_LoadOptAlpha(buff);
			}
			if(!tmpgfx)
			{	fprintf(stderr,"Cannot load any editor img\n");
				quit(1);
			}
			csp->imgs[0]=tmpgfx;
		}
		else
		{	fprintf(stderr,"Mode %d unknonw !\n",mode);
			quit(1);
		}
	}

	return 0;
}
