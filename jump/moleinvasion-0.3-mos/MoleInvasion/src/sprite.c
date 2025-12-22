/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

# include "sprite.h"

# define NUMBER_OF_SPRITES 111
struct gsi all_imgs_surf [NUMBER_OF_SPRITES];

struct {
	/* à NULL pour les 47 premiers => tiles
	si contient ".png" -> image chargée telle que 
	sinon c'est un identifiant utilisé pour les images des sprites */
	char * img_name;
	char * map_name;
	unsigned int sprite_management_type;
	unsigned int id;
}
all_tiles[NUMBER_OF_SPRITES] = {
/* murs */
{NULL ,"wall_mask.png" ,SPRITE_TILE,0}, {NULL ,"wall_mask.png" ,SPRITE_TILE,1}, 
{NULL ,"wall_mask.png" ,SPRITE_TILE,2}, {NULL ,"wall_mask.png" ,SPRITE_TILE,3}, 
{NULL ,"wall_mask.png" ,SPRITE_TILE,4}, {NULL ,"wall_mask.png" ,SPRITE_TILE,5}, 
{NULL ,"wall_mask.png" ,SPRITE_TILE,6}, {NULL ,"wall_mask.png" ,SPRITE_TILE,7}, 
{NULL ,"wall_mask.png" ,SPRITE_TILE,8}, {NULL ,"wall_mask.png" ,SPRITE_TILE,9}, 
{NULL ,"wall_mask.png" ,SPRITE_TILE,10},{NULL ,"wall_mask.png" ,SPRITE_TILE,11},
{NULL ,"wall_mask.png" ,SPRITE_TILE,12},{NULL ,"wall_mask.png" ,SPRITE_TILE,13},
{NULL ,"wall_mask.png" ,SPRITE_TILE,14},{NULL ,"wall_mask.png" ,SPRITE_TILE,15},
{NULL ,"wall_mask.png" ,SPRITE_TILE,16},{NULL ,"wall_mask.png" ,SPRITE_TILE,17},
{NULL ,"wall_mask.png" ,SPRITE_TILE,18},{NULL ,"wall_mask.png" ,SPRITE_TILE,19},
{NULL ,"wall_mask.png" ,SPRITE_TILE,20},{NULL ,"wall_mask.png" ,SPRITE_TILE,21},
{NULL ,"wall_mask.png" ,SPRITE_TILE,22},{NULL ,"wall_mask.png" ,SPRITE_TILE,23},
{NULL ,"wall_mask.png" ,SPRITE_TILE,24},{NULL ,"wall_mask.png" ,SPRITE_TILE,25},
{NULL ,"wall_mask.png" ,SPRITE_TILE,26},{NULL ,"wall_mask.png" ,SPRITE_TILE,27},
{NULL ,"wall_mask.png" ,SPRITE_TILE,28},{NULL ,"wall_mask.png" ,SPRITE_TILE,29},
{NULL ,"wall_mask.png" ,SPRITE_TILE,30},{NULL ,"wall_mask.png" ,SPRITE_TILE,31},
{NULL ,"wall_mask.png" ,SPRITE_TILE,32},{NULL ,"wall_mask.png" ,SPRITE_TILE,33},
{NULL ,"wall_mask.png" ,SPRITE_TILE,34},{NULL ,"wall_mask.png" ,SPRITE_TILE,35},
{NULL ,"wall_mask.png" ,SPRITE_TILE,36},{NULL ,"wall_mask.png" ,SPRITE_TILE,37},
{NULL ,"wall_mask.png" ,SPRITE_TILE,38},{NULL ,"wall_mask.png" ,SPRITE_TILE,39},
{NULL ,"wall_mask.png" ,SPRITE_TILE,40},{NULL ,"wall_mask.png" ,SPRITE_TILE,41},
{NULL ,"wall_mask.png" ,SPRITE_TILE,42},{NULL ,"wall_mask.png" ,SPRITE_TILE,43},
{NULL ,"wall_mask.png" ,SPRITE_TILE,44},{NULL ,"wall_mask.png" ,SPRITE_TILE,45},
{NULL ,"wall_mask.png" ,SPRITE_TILE,46},
{"bois-l.png"		,"wall_mask.png"	,SPRITE_TILE, 68 },
{"bois-m.png"		,"wall_mask.png"	,SPRITE_TILE, 69 },
{"bois-r.png"		,"wall_mask.png"	,SPRITE_TILE, 70 },
{"fer-l.png"		,"wall_mask.png"	,SPRITE_TILE, 75 },
{"fer-m.png"		,"wall_mask.png"	,SPRITE_TILE, 79 },
{"fer-r.png"		,"wall_mask.png"	,SPRITE_TILE, 80 },
/* décors */
{"herbe1.png"		,"herbe_mask.png"	,SPRITE_FOREGROUND, 85 },
{NULL			,"nowall_mask.png"	,SPRITE_FOREGROUND, 90 }, /* 04 up */
{NULL			,"nowall_mask.png"	,SPRITE_FOREGROUND, 91 }, /* 05 down*/
{NULL			,"nowall_mask.png"	,SPRITE_FOREGROUND, 92 }, /* 07 left */
{NULL			,"nowall_mask.png"	,SPRITE_FOREGROUND, 93 }, /* 06 right */
{NULL			,"nowall_mask.png"	,SPRITE_FOREGROUND, 94 }, /* 09 center */
{"herbe2.png"		,"herbe_mask.png"	,SPRITE_FOREGROUND, 86 },
/* plateformes */
{"skate.png"		,"skate_mask.png"	,SPRITE_MOVE|SPRITE_TURNONEDGE, 56 },
{"ballB.png"		,"wall_mask.png"	,SPRITE_BOUNCY|SPRITE_MAKE_REBOUNCE, 52 },
{"skateH.png"		,"skate_mask.png"	,SPRITE_SPECIFIC, 96 }, /* plateforme horizontale */
{"skateV.png"		,"skate_mask.png"	,SPRITE_SPECIFIC, 97 }, /* plateforme verticale */
/* jokers */
{"caisse.png"		,"caisse_mask.png"	,SPRITE_FALL|SPRITE_MAKE_REBOUNCE, 53 },
{"box-0.png"		,"wall_mask.png"	,SPRITE_TILE, 66 },
{"box-1.png"		,"box_mask.png"		,SPRITE_SPECIFIC, 55 },
{"box-invisible.png"	,"box_mask.png"		,SPRITE_SPECIFIC, 95 },
{"gold_box.png"		,"gold_box_mask.png"	,SPRITE_FLYING, 88 },
{"switch.png"		,"switch_mask.png"	,SPRITE_SPECIFIC|SPRITE_MAKE_REBOUNCE, 87 },
{"box-chrono"		,"box-chrono/mask.png"	,SPRITE_SPECIFIC, 105 }, /* donne chrono 71 */
{"box-sac"		,"box-sac/mask.png"	,SPRITE_SPECIFIC, 106 }, /* donne sac 62 */
{"box-potion"		,"box-potion/mask.png"	,SPRITE_SPECIFIC, 107 }, /* donne potion 63 */
{"box-coin1"		,"box-coin1/mask.png"	,SPRITE_SPECIFIC, 108 }, /* donne coin 83 */
{"box-coin10"		,"box-coin10/mask.png"	,SPRITE_SPECIFIC, 109 }, /* donne coin10 84 */
{"box-gem"		,"box-gem/mask.png"	,SPRITE_SPECIFIC, 110 }, /* donne gem 99 */
/* dangers */
{"lava.png"		,"lava_mask.png"	,SPRITE_TILE, 47 }, /* pics */
{"pics.png"		,"pics_mask.png"	,SPRITE_TILE, 48 }, /* mine */
{"pics-turn.png"	,"pics_mask.png"	,SPRITE_SPECIFIC, 98 }, /* mine en rotation */
{"canon.png"		,"wall_mask.png"	,SPRITE_SPECIFIC, 104 }, /* cannon double */
{"explobomb"		,"explobomb/mask.png"	,SPRITE_SPECIFIC, 101 }, /* bombe qui va exploser */
{"explosion"		,"explosion/mask.png"	,SPRITE_SPECIFIC, 102 }, /* explosion */
/* fin */
{"win_gate.png"		,"win_gate_mask.png"	,SPRITE_TILE, 49 },
/* ennemies */
{"sp51.png"		,"sp51_mask.png"	,SPRITE_BOUNCY, 51 },
{"sp54.png"		,"sp54_mask.png"	,SPRITE_BOUNCY|SPRITE_MAKE_REBOUNCE, 54 },
{"sp59"			,"sp59/mask.png"	,SPRITE_MOVE|SPRITE_BOUNCY|SPRITE_MAKE_REBOUNCE, 59 }, /* OGM potato */
{"sp72"			,"sp72/mask.png"	,SPRITE_MOVE, 72 }, /* under ground mole */
{"sp73"			,"sp73/mask.png"	,SPRITE_MOVE|SPRITE_MAKE_REBOUNCE, 73 }, /* giant mole */
{"sp77"			,"sp77/mask.png"	,SPRITE_MOVE|SPRITE_FLYING|SPRITE_MAKE_REBOUNCE, 77 }, /* bat */
{"sp57"			,"sp57/mask.png"	,SPRITE_MOVE|SPRITE_TURNONEDGE|SPRITE_MAKE_REBOUNCE, 57 }, /* hammer mole */
{"sp58"			,"sp58/mask.png"	,SPRITE_MOVE|SPRITE_MAKE_REBOUNCE, 58 }, /* scout mole */
{"sp60"			,"sp60/mask.png"	,SPRITE_MOVE|SPRITE_JUMPONEDGE|SPRITE_MAKE_REBOUNCE, 60 }, /* jumpin' mole */
{"sp61"			,"sp61/mask.png"	,SPRITE_MOVE, 61 }, /* armoured mole */
{"sp81"			,"sp81/mask.png"	,SPRITE_MOVE|SPRITE_FLYING|SPRITE_MAKE_REBOUNCE, 81 }, /* flying mole */
{"sp82"			,"sp82/mask.png"	,SPRITE_MOVE|SPRITE_TURNONEDGE|SPRITE_MAKE_REBOUNCE, 82 }, /* pic mole */
{"bomby"		,"bomby/mask.png"	,SPRITE_MOVE|SPRITE_MAKE_REBOUNCE, 100 }, /* bomby */
/* bonus */
{"chrono.png"		,"chrono_mask.png"	,SPRITE_FLYING, 71 },
{"sac.png"		,"sac_mask.png"		,SPRITE_FALL, 62 },
{"potion.png"		,"potion_mask.png"	,SPRITE_FALL, 63 },
{"coin"			,"coin/mask.png"	,SPRITE_FLYING, 83 },
{"coin10"		,"coin10/mask.png"	,SPRITE_FLYING, 84 },
{"gem"			,"gem/mask.png"		,SPRITE_BOUNCY, 99 },
/* joueurs */
{"sprite1"		,"sprite1/mask.png"	,SPRITE_PLAYER, 50 }, /* tux */
{"sprite2"		,"sprite2/mask.png"	,SPRITE_PLAYER, 64 }, /* frozen tux */
{"sprite3"		,"sprite3/mask.png"	,SPRITE_PLAYER, 65 }, /* i-robot */
{"sprite4"		,"sprite4/mask.png"	,SPRITE_PLAYER, 74 }, /* lapin */
{"sprite5"		,"sprite5/mask.png"	,SPRITE_PLAYER, 67 }, /* ninja */
/* armes */
{"hammer"		,"hammer/mask.png"	,SPRITE_MOVE|SPRITE_BOUNCY, 78 },
{"lpics.png"		,"lpics_mask.png"	,SPRITE_MOVE|SPRITE_FLYING, 89 },
{"shuriken.png"		,"shuriken_mask.png"	,SPRITE_MOVE|SPRITE_FLYING, 76 },
{"boulet"		,"boulet/mask.png"	,SPRITE_MOVE|SPRITE_FLYING|SPRITE_MAKE_REBOUNCE, 103 } /* bomby */
};

static unsigned int maxSpriteWidth;

int init_all_images(char * wall_gfx_dir, char mode)
{	int i;

	maxSpriteWidth=0;
	for(i=0;i<NUMBER_OF_SPRITES;i++)
	{	GFX_loadCompleteSprite(&all_imgs_surf[i],
				all_tiles[i].img_name,
				all_tiles[i].id,
				wall_gfx_dir,
				all_tiles[i].map_name,
				mode);

		/* recuperation de la plus grande largeur */
		if(all_imgs_surf[i].map->w > maxSpriteWidth)
			maxSpriteWidth=all_imgs_surf[i].map->w;
	}
	printf("maxSpriteWidth=%u\n",maxSpriteWidth);
	return 0;
}

int free_all_images()
{	int i,j;

	for(i=0;i<NUMBER_OF_SPRITES;i++)
	{	SDL_FreeSurface(all_imgs_surf[i].map);
		SDL_FreeSurface(all_imgs_surf[i].optmap);
		for(j=0;j<sizeof(all_imgs_surf[i].imgs)/sizeof(all_imgs_surf[i].imgs[0]);j++)
			if(all_imgs_surf[i].imgs[j])
			{	SDL_FreeSurface(all_imgs_surf[i].imgs[j]);
				all_imgs_surf[i].imgs[j]=NULL;
			}
	}
	return 0;
}

char LoadSprite(mySprite * sprite,unsigned int id)
{
	sprite->posX=sprite->posY=
	sprite->posXinit=sprite->posYinit=
	sprite->vertical_speed=sprite->horizontal_speed=
	sprite->goleft=sprite->goright=sprite->gojump=sprite->godown=sprite->gospace=
	sprite->rebounce=sprite->action=sprite->can_superjump=sprite->direction=
	sprite->touchground=sprite->must_die = 
	sprite->etat = sprite->draw_image_count = 
	sprite->invincible = 0;
	sprite->touch_by = sprite->stop_by = NULL;
	sprite->draw_image_state = 0;
	sprite->map=sprite->image=NULL;

	changeSpriteToId(sprite,id,NULL,NULL,0);

	if(!sprite->map || !sprite->image)
	{	fprintf(stderr,"Cannot LoadSprite id %d\n",id);
		return 1;
	}
	return 0;
}

void createNewSpriteNear(mySprite * sprite,int id, char pos,myList * level_walls,myList * level_sprites)
{
	mySprite sprite_read;

	LoadSprite(&sprite_read,id);
	sprite_read.etat=ETAT_VISIBLE | ETAT_VIVANT;
	initOther(&sprite_read);
	if(pos == POS_UP)
	{	sprite_read.posX=sprite->posX + (sprite->map->w/2) - (sprite_read.map->w/2);
		sprite_read.posY=sprite->posY-sprite_read.map->h;
	}
	else if(pos == POS_SIDE)
	{	//sprite_read.posY=player->posY+10;
		sprite_read.posY=sprite->posY + (sprite->map->h/2) - (sprite_read.map->h/2);
	
		if(sprite->direction<0) /* gauche */
		{	sprite_read.posX=sprite->posX-sprite_read.map->w;
			sprite_read.goright=0;
			sprite_read.goleft=1;
		}
		else /* droite */
		{	sprite_read.posX=sprite->posX+sprite->map->w;
			sprite_read.goright=1;
			sprite_read.goleft=0;
		}
	}
	else
	{	fprintf(stderr,"createNewSpriteNear: unknown pos:%d\n",pos);
		return;
	}
	AddToList(level_sprites,&sprite_read,sizeof(mySprite));
	printf("ICI : create %d\n",id);
	changeSpriteToId(&sprite_read,id,level_walls,level_sprites,0);

}

void changeSpriteToId(mySprite * sprite, int id, myList * level_walls,myList * level_sprites, char reset)
{	
	int imgw=0,imgh=0;

	sprite->id = id;
	id=GetPosOfId(id);
	
	if(sprite && sprite->map)
	{	imgw=sprite->map->w;
		imgh=sprite->map->h;
	}

	sprite->spImages= &all_imgs_surf[id];
	sprite->image	= sprite->spImages->imgs[0];
	sprite->map	= sprite->spImages->map;
	sprite->optmap	= sprite->spImages->optmap;
 
	assert(sprite->image);
	assert(sprite->map);
	assert(sprite->optmap);
 
 	sprite->sprite_management_type = all_tiles[id].sprite_management_type;

	sprite->etat = (ETAT_VISIBLE | ETAT_VIVANT);
	sprite->must_die=0;
	
	if(reset)
		initOther(sprite);
	if(imgw&&imgh)
	{	/* on centre le nouveau sur l'ancien */
		sprite->posX=sprite->posX+imgw/2-sprite->map->w/2;
		sprite->posY=sprite->posY+imgh/2-sprite->map->h/2;
	}
	
	/* deplacement eventuel du sprite (a cause du changement de mask) */
/*	printf("changing to %d\n",sprite->id);*/
	if(level_walls && level_sprites)
		if(!isPositionAllowed(sprite, level_walls,level_sprites))
		{	// sprite doit se pousser
			int pouss=0;
			long sposX,sposY;
			sposX=sprite->posX;
			sposY=sprite->posY;
			// on teste en tournant et en s'éloignant
			while(1)
			{	pouss++;
				// haut 
				sprite->posX=sposX;		sprite->posY=sposY-pouss;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// haut - gauche
				sprite->posX=sposX-pouss;	sprite->posY=sposY-pouss;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// gauche 
				sprite->posX=sposX-pouss;	sprite->posY=sposY;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// gauche -bas 
				sprite->posX=sposX-pouss;	sprite->posY=sposY+pouss;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// bas 
				sprite->posX=sposX;		sprite->posY=sposY+pouss;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// bas - droite
				sprite->posX=sposX+pouss;	sprite->posY=sposY+pouss;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// droite 
				sprite->posX=sposX+pouss;	sprite->posY=sposY;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
				// droite - haut
				sprite->posX=sposX+pouss;	sprite->posY=sposY-pouss;
				if(isPositionAllowed(sprite, level_walls,level_sprites))
					break;
			}
			printf("POUSS :%d (%d)\n",sprite->id,pouss);
		}
}

inline unsigned int GetNumberOfSprites()
{	return NUMBER_OF_SPRITES;
}

int GetPosOfId(unsigned int id)
{	int pos;

	/* recherche de l'indice du sprite via son identifiant */
	for(pos=0;pos<NUMBER_OF_SPRITES;pos++)
		if(all_tiles[pos].id == id)
			return pos;
	return -1;
}

inline int GetIdOfPos(unsigned int pos)
{	assert(pos<NUMBER_OF_SPRITES);
	return all_tiles[pos].id;
}

int displaySurface( SDL_Surface* surface, SDL_Surface* screen, Sint16 x, Sint16 y)
{	SDL_Rect dest;
	
	if(!surface)
		return 1;

	dest.x = x;		dest.y = y;
	SDL_BlitSurface(surface, NULL, screen, &dest);

	return 0;
}

inline int displaySprite( mySprite sprite, SDL_Surface* screen, long decalX, long decalY)
{	
	return sprite.etat & ETAT_VISIBLE ?
		displaySurface(sprite.image, screen, sprite.posX+decalX,sprite.posY+decalY):
		1;
}

inline int displaySpriteMap( mySprite sprite, SDL_Surface* screen, long decalX, long decalY)
{	
	return	sprite.etat & ETAT_VISIBLE ?
		displaySurface(sprite.optmap, screen, sprite.posX+decalX,sprite.posY+decalY):
		1;
}

/******************************/
/*   gestion des collisions   */
/******************************/

/* fonctionnement des masques de collision :
R, V, B
0, 0, 0 : RIEN
FF,0, 0 : MUR (SPRITE_MUR)
0, FF,0 : VULNERABLE (SPRITE_VULN)
0, 0, FF: MORTEL (SPRITE_MORTEL) - detruit player
FF,FF,0 : SPRITE_J1 
0, FF,FF: SPRITE_J2 
11,44,77: ARME_AMI (SPRITE_F_WEAPON) - detruit ennemis, meure au contact
77,44,11: ARME_ENNEMIE (SPRITE_E_WEAPON) - detruit player, meure au contact
30,30,00: DESTRUCTEUR (SPRITE_DALL) - detruit tout sauf les murs
FF,0, FF: FIN DE NIVEAU (SPRITE_END)
AA,AA,xx: BONUS1 (mobile): 00 transfo_lapin, 11 transfo_ninja, 22 transfo petit
BB,BB,xx: BONUS2 (immobile) : DD coin10, EE coin1, FF chrono */

/* for collision type */
#define SPRITE_NONE	0
#define SPRITE_J1	1
#define SPRITE_J2	2
#define SPRITE_END	3
#define SPRITE_MUR	4
#define SPRITE_MORTEL	5
#define SPRITE_VULN	6
#define SPRITE_BONUS1	7
#define SPRITE_BONUS2	8
#define SPRITE_F_WEAPON	9
#define SPRITE_E_WEAPON	10
#define SPRITE_DALL	11

static unsigned int last_bonus=BONUS_NONE;

inline unsigned int get_last_bonus()
{	return last_bonus;
}

unsigned char convertRVBtoSprite(unsigned char r,unsigned char v,unsigned char b)
{	unsigned char sp_msk=SPRITE_NONE,err=0;

	if(r ==0x00 )
	{	if(v ==0x00 )
		{	if(b ==0x00 )
			{	sp_msk=SPRITE_NONE;
			}else if( b ==0xFF )
			{	sp_msk=SPRITE_MORTEL;
			}else
				err=1;
		}else if(v ==0xFF )
		{	if(b ==0x00 )
			{	sp_msk=SPRITE_VULN;
			}else
				err=1;
		}else
			err=1;
	}else if(r ==0xFF)
	{	if(v ==0x00 )
		{	if(b ==0x00 )
			{	sp_msk=SPRITE_MUR;
			}else if( b ==0xFF )
			{	sp_msk=SPRITE_END;
			}else
				err=1;
		}else if(v ==0xFF )
		{	if(b ==0x00 )
			{	sp_msk=SPRITE_J1;
			}else
				err=1;
		}else
			err=1;
	}
	else if( r == 0x30 && v == 0x30 && b == 0x00)
		sp_msk=SPRITE_DALL;
	else if( r == 0x11 && v == 0x44 && b == 0x77)
		sp_msk=SPRITE_F_WEAPON;
	else if( r == 0x77 && v == 0x44 && b == 0x11)
		sp_msk=SPRITE_E_WEAPON;
	else if(r ==0xAA && v ==0xAA )
	{	/* bonus mobile (contact avec autres sprites) ! */
		sp_msk=SPRITE_BONUS1;
		switch(b)
		{case 0x00 : last_bonus=BONUS_TRANSF_LAPIN	;break;
		case 0x11  : last_bonus=BONUS_TRANSF_NINJA	;break;
		case 0x22  : last_bonus=BONUS_TRANSF_SMALL	;break;
		default    : err=1;last_bonus=BONUS_NONE	;break;
		}
	}
	else if(r ==0xBB && v ==0xBB )
	{	/* bonus immobile (pas de contact) ! */
		sp_msk=SPRITE_BONUS2;
		switch(b)
		{case 0xDD  : last_bonus=BONUS_COIN10		;break;
		case 0xEE  : last_bonus=BONUS_COIN		;break;
		case 0xFF  : last_bonus=BONUS_CHRONO		;break;
		default    : err=1;last_bonus=BONUS_NONE	;break;
		}
	}
	else
		err=1;
	if(err)
	{	fprintf(stderr,"Mask collision(%d,%d,%d) unknown !! \n",(int)r,(int)v,(int)b);
		sp_msk=SPRITE_NONE;
	}
	return sp_msk;
}

static unsigned char spriteCollision(mySprite *sp1,mySprite *sp2, char stop_only)
{	unsigned int i,j,i2,j2;
	unsigned char r,v,b,r2,v2,b2,ret=COLLISION_NONE;
	
	/* self collision ;-) */
	if(sp1->id == sp2->id && sp1->posY == sp2->posY && sp1->posX == sp2->posX)
		return ret;
	
	if(	/* conflit vertical */
	  ( (sp2->posY >= sp1->posY && sp2->posY < (sp1->posY+sp1->map->h))
	 || (sp1->posY >= sp2->posY && sp1->posY < (sp2->posY+sp2->map->h)) )
	 &&	 /* conflit horizontal */
	  ( (sp2->posX >= sp1->posX && sp2->posX < (sp1->posX+sp1->map->w))
	 || (sp1->posX >= sp2->posX && sp1->posX < (sp2->posX+sp2->map->w)) ) )
	{
//		printf("coll: %d %d -> %d: %d %d\n",sp1->posX,sp1->posY,sp2->id,sp2->posX,sp2->posY);
	 	/* les 2 sprites se chevauchent ... y a-t-il réelle collision ? */
		/* on parcours chaque pixel du mask de SP1 en vérifiant s'il correspond à un pixel du mask de SP2 */
		if(SDL_MUSTLOCK(sp1->map))SDL_LockSurface(sp1->map);
		if(SDL_MUSTLOCK(sp2->map))SDL_LockSurface(sp2->map);
		for(j=0;j<sp1->map->h;j++)
		{	if(j+sp1->posY < sp2->posY || j+sp1->posY >= sp2->posY+sp2->map->h)
				continue;
			for(i=0;i<sp1->map->w;i++)
			{	if(i+sp1->posX < sp2->posX || i+sp1->posX >= sp2->posX+sp2->map->w)
					continue;
				imageGetPixel(sp1->map,i,j,&r,&v,&b);
				if(r || v || b )
				{	/* pixel correspondant sur SP2 */
					i2=i+sp1->posX-sp2->posX;
					j2=j+sp1->posY-sp2->posY;
					imageGetPixel(sp2->map,i2,j2,&r2,&v2,&b2);
					if(r2 || v2 || b2 )
					{	unsigned char sp1_msk,sp2_msk;
						
						sp1_msk=convertRVBtoSprite(r, v, b);
						sp2_msk=convertRVBtoSprite(r2,v2,b2);

//						printf("1contact %u %u-%u %u %u-%d\n",i,j,r,v,b,sp1_msk);
//						printf("2contact %u %u-%u %u %u-%d\n",i2,j2,r2,v2,b2,sp2_msk);
												
						switch(sp1_msk)
						{case SPRITE_J1:
							switch(sp2_msk)
							{case SPRITE_MUR:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_DIE;break;
							case SPRITE_END:	ret |= COLLISION_S1_WIN;break;
							case SPRITE_VULN:	ret |= COLLISION_S1_KILL;break;
							case SPRITE_BONUS1:	ret |= COLLISION_S1_BONUS | COLLISION_S1_KILL;break;
							case SPRITE_BONUS2:	ret |= COLLISION_S1_BONUS | COLLISION_S1_KILL;break;
							case SPRITE_E_WEAPON:	ret |= COLLISION_S1_DIE;break;
							case SPRITE_DALL:	ret |= COLLISION_S1_DIE;break;
							}break;
						case SPRITE_MUR:
							switch(sp2_msk)
							{case SPRITE_MUR:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_J1:		ret |= COLLISION_S1_STOP;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_VULN:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_BONUS1:	ret |= COLLISION_S1_STOP;break;
							}break;
						case SPRITE_MORTEL:
							switch(sp2_msk)
							{case SPRITE_J1:	ret |= COLLISION_S1_KILL;break;
							case SPRITE_MUR:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_VULN:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_BONUS1:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_DALL:	ret |= COLLISION_S1_DIE;break;
							}break;
						case SPRITE_VULN:
							switch(sp2_msk)
							{//case SPRITE_J1:	ret |= COLLISION_S1_DIE;break;
							case SPRITE_MUR:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_VULN:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_DALL:	ret |= COLLISION_S1_DIE;break;
							}break;
						case SPRITE_BONUS1:
							switch(sp2_msk)
							{case SPRITE_MUR:	ret |= COLLISION_S1_STOP;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_STOP;break;
							}break;
						case SPRITE_F_WEAPON:
							switch(sp2_msk)
							{case SPRITE_MUR:	ret |= COLLISION_S1_DIE;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_KILL|COLLISION_S1_DIE;break;
							case SPRITE_VULN:	ret |= COLLISION_S1_KILL|COLLISION_S1_DIE;break;
							case SPRITE_E_WEAPON:	ret |= COLLISION_S1_KILL|COLLISION_S1_DIE;break;
							case SPRITE_DALL:	ret |= COLLISION_S1_DIE;break;
							}break;
						case SPRITE_E_WEAPON:
							switch(sp2_msk)
							{case SPRITE_MUR:	ret |= COLLISION_S1_DIE;break;
							case SPRITE_J1:		ret |= COLLISION_S1_KILL/*|COLLISION_S1_DIE*/;break;
							case SPRITE_F_WEAPON:	ret |= COLLISION_S1_KILL|COLLISION_S1_DIE;break;
							case SPRITE_DALL:	ret |= COLLISION_S1_DIE;break;
							}break;
						case SPRITE_DALL:
							switch(sp2_msk)
							{case SPRITE_J1:	ret |= COLLISION_S1_KILL;break;
							case SPRITE_MORTEL:	ret |= COLLISION_S1_KILL;break;
							case SPRITE_VULN:	ret |= COLLISION_S1_KILL;break;
							case SPRITE_F_WEAPON:	ret |= COLLISION_S1_KILL;break;
							case SPRITE_E_WEAPON:	ret |= COLLISION_S1_KILL;break;
							}break;
						}
						
						if(stop_only && (ret & COLLISION_S1_STOP))
						{	if(SDL_MUSTLOCK(sp2->map))SDL_UnlockSurface(sp2->map);
							if(SDL_MUSTLOCK(sp1->map))SDL_UnlockSurface(sp1->map);
//							printf("return COLLISION_S1_STOP\n");
							return ret;
						}
					}
				}
			}
		}
		if(SDL_MUSTLOCK(sp2->map))SDL_UnlockSurface(sp2->map);
		if(SDL_MUSTLOCK(sp1->map))SDL_UnlockSurface(sp1->map);
	}
	return ret;
}

/* pour parcourir un minimum une liste triée, on donne les xmin et ca renvoi le premier indice */
void giveOrderedListPlage(unsigned int * deb,myList * ordered_list, int xmin)
{	unsigned int i;
	unsigned int step=1;
	mySprite* current;

	assert(ordered_list);
	assert(deb);

	i=0;
	while(step)
	{	do
		{	i+=step;
			current=(mySprite*)GetPosList(ordered_list,i);
		}while(current && current->posX + maxSpriteWidth < xmin);
		i-=step;
		step>>=1;
	}
	*deb=i;
}

char testPositionAllowed(mySprite *player,myList * level_walls,myList * level_sprites, int modX, int modY)
{	char retour;
	long sposX,sposY;

	sposY=player->posY;	sposX=player->posX;

	player->posX+=modX;	player->posY+=modY;
	retour=isPositionAllowed(player, level_walls,level_sprites);

	player->posY=sposY;	player->posX=sposX;
	return retour;
}

char isPositionAllowed(mySprite *player,myList * level_walls,myList * level_sprites)
{	unsigned char collision;
	unsigned int i,j;
	mySprite* current;
	
	if( ! (player->etat & ETAT_VIVANT))
		return 1;
	
	if(level_walls)
	{	/* contacts avec tiles (liste triée) */
		giveOrderedListPlage(&i,level_walls, player->posX);
		for(j=i;j<level_walls->size;j++)
		{	current=(mySprite*)GetPosList(level_walls,j);
			/* fin de la partie triée intéressante */
			if( current->posX > player->posX + player->map->w)
				break;
			if( ! (current->etat & ETAT_VIVANT))
				continue;
			collision=spriteCollision(player,current,1);
	
			if( collision & COLLISION_S1_STOP )
			{	player->stop_by=current;
				return 0;
			}
		}
	}
	if(level_sprites)
	{	/* contacts avec sprites */
		for(i=0;i<level_sprites->size;i++)
		{	current=(mySprite*)GetPosList(level_sprites,i);
			if( ! (current->etat & ETAT_VIVANT))
				continue;
			collision=spriteCollision(player,current,1);
	
			if( collision & COLLISION_S1_STOP )
			{	player->stop_by=current;
				return 0;
			}
		}
	}
	return 1;
}

unsigned char * getCollisionList(mySprite *player,myList * level_walls,myList * level_sprites)
{
#define DEFAULT_COLLISION_NUMBER	32
	static unsigned char lst[DEFAULT_COLLISION_NUMBER];
	unsigned int nb_el=0,i,j;
	unsigned char collision;
	mySprite* current;

	/* contacts avec tiles (liste triée) */
	giveOrderedListPlage(&i,level_walls, player->posX);
	for(j=i;j<level_walls->size;j++)
	{	current=(mySprite*)GetPosList(level_walls,j);
		/* fin de la partie triée intéressante */
		if( current->posX > player->posX + player->map->w)
			break;
		if( ! (current->etat & ETAT_VIVANT) )
			continue;
		collision=spriteCollision(player,current,0);
		if( collision != COLLISION_NONE )
		{
			/* ajout en liste */
			lst[nb_el++]=collision;
			if(nb_el>DEFAULT_COLLISION_NUMBER-1)
			{	printf("So much collisions !!!! \n");
			}
			
			/* mort éventuelle du sprite 2 */
			if( collision & COLLISION_S1_KILL && !current->invincible)
			{	printf("(%d) killing (%d)\n",player->id,current->id);
				current->touch_by=player;
				current->must_die=1;
			}
			/* player touché par un ennemi -> on note lequel */
			if( collision & COLLISION_S1_DIE && !player->invincible)
			{	printf("(%d) killed by (%d)\n",player->id,current->id);
				player->touch_by=current;
				player->must_die=1;
			}
 		}
	}
	/* contacts avec sprites */
	for(i=0;i<level_sprites->size;i++)
	{	current=(mySprite*)GetPosList(level_sprites,i);
		if( ! (current->etat & ETAT_VIVANT) )
			continue;
		collision=spriteCollision(player,current,0);
		if( collision != COLLISION_NONE )
		{	
			/* ajout en liste */
			lst[nb_el++]=collision;
			if(nb_el>DEFAULT_COLLISION_NUMBER-1)
			{	printf("So much collisions !!!! \n");
			}
			
			/* mort éventuelle du sprite 2 */
			if( collision & COLLISION_S1_KILL && !current->invincible)
			{	printf("(%d) killing (%d)\n",player->id,current->id);
				current->touch_by=player;
				current->must_die=1;
			}
			/* player touché par un ennemi -> on note lequel */
			if( collision & COLLISION_S1_DIE && !player->invincible)
			{	printf("(%d) killed by (%d)\n",player->id,current->id);
				player->touch_by=current;
				player->must_die=1;
			}
 		}
	}
	/* NULL terminal */
	lst[nb_el]=0;
	return &lst[0];
}

unsigned int isElementIn(unsigned char val,unsigned char * liste_coll)
{	unsigned int i=0;
	if(!liste_coll)
		return 0;
	while(liste_coll[i])
		if( liste_coll[i++] & val )
			return 1;
	return 0;
}

void demi_tour(mySprite * player)
{	player->horizontal_speed=0;
	if(player->goleft)
	{	player->goleft=0;
		player->goright=1;
		player->direction=1;
	}
	else
	{	player->goleft=1;
		player->goright=0;
		player->direction=-1;
	}
}

int commonMounvingSpriteBehaviour(mySprite *player,myList * level_walls,myList * level_sprites)
{	long sposX,sposY;
	int vspeed,hspeed;
	int code_retour=0; /* 0=on continue ; 1=player mort ; 2=player gagnant */
	
	if(player->horizontal_speed>0)
		player->direction=1; /* droite */
	if(player->horizontal_speed<0)
		player->direction=-1; /* gauche */

	/* sauvegarde des positions d'arrivée */
	sposX=player->posX;
	sposY=player->posY;

	/* si !jump && touch_ground => dépl horiontal seul */
	if(player->gojump == 0 &&
	   !testPositionAllowed(player, level_walls,level_sprites,0,+1))
		player->vertical_speed=0;

	/* on rentre latéralement dans un mur */
	if(player->horizontal_speed != 0 &&
	   !testPositionAllowed(player , level_walls,level_sprites , player->horizontal_speed<0?-1:+1 , 0))
	{	player->horizontal_speed=0;
		if(player->sprite_management_type&SPRITE_MOVE)
			demi_tour(player);
	}

	/* une plateforme mouvante modifie notre vitesse */
	if(player->sprite_management_type&SPRITE_PLAYER && 
	   !testPositionAllowed(player, NULL,level_sprites,0,+1) && player->stop_by->horizontal_speed != 0)
		hspeed=player->horizontal_speed+player->stop_by->horizontal_speed;
	else
		hspeed=player->horizontal_speed;
	/* TODO */
	vspeed=player->vertical_speed;

	nearestPosTo(player,level_walls,level_sprites,
		player->posX + hspeed,
		player->posY + vspeed,
		0); /* à modifier pour essayer de monter les cotes */

	/* reset de l'accélération verticale - utile si on tape un plafond */
	if(sposY==player->posY || !testPositionAllowed(player, NULL,level_sprites,0,-1))
		player->vertical_speed=0;

	return code_retour;
}

char calculeNewVitesse(mySprite *player,
	float max_horizontal_acceleration, float std_horizontal_acceleration, float std_horizontal_deceleration,
	float max_vertical_deceleration,   float std_vertical_acceleration,   float std_vertical_deceleration)
{	
	/* mouvements de player */
	if(player->goleft)
	{	if(player->horizontal_speed > -max_horizontal_acceleration)
		{	player->horizontal_speed -=(int)std_horizontal_acceleration;
			player->horizontal_speed=MAX(player->horizontal_speed,(int)-max_horizontal_acceleration);
		}
		else if(player->horizontal_speed != -max_horizontal_acceleration)
		{	player->horizontal_speed+=(int)std_horizontal_deceleration;
			player->horizontal_speed=MIN(player->horizontal_speed,(int)-max_horizontal_acceleration);
		}
	}
	else if(!player->goright)
	{	if(player->horizontal_speed < 0)
		{	player->horizontal_speed+=(int)std_horizontal_deceleration;
			player->horizontal_speed=MIN(player->horizontal_speed,0);
		}
	}
	if(player->goright)
	{	if(player->horizontal_speed < max_horizontal_acceleration)
		{	player->horizontal_speed +=(int)std_horizontal_acceleration;
			player->horizontal_speed=MIN(player->horizontal_speed,(int)max_horizontal_acceleration);
		}
		else if(player->horizontal_speed != max_horizontal_acceleration)
		{	player->horizontal_speed-=(int)std_horizontal_deceleration;
			player->horizontal_speed=MAX(player->horizontal_speed,(int)max_horizontal_acceleration);
		}
	}
	else if(!player->goleft)
	{	if(player->horizontal_speed > 0)
		{	player->horizontal_speed-=(int)std_horizontal_deceleration;
			player->horizontal_speed=MAX(player->horizontal_speed,0);
		}
	}

	/* saut */
	if(player->gojump && player->touchground)
		player->vertical_speed = -std_vertical_acceleration;

	/* chute */
	if( (!(player->sprite_management_type & SPRITE_FLYING) || !(player->etat & ETAT_VIVANT))
		&& player->vertical_speed<max_vertical_deceleration)
			player->vertical_speed+=std_vertical_deceleration;

/*printf("IN %d %d %ld %ld %d\n",	player->vertical_speed,player->horizontal_speed,
		player->posY,player->posX,
		player->touchground);
*/	return 0;
}

int nearestPosTo(mySprite *player,myList * level_walls,myList * level_sprites,long X, long Y, unsigned int marche)
{	long sposXI,sposYI,sposX1,sposY1,sposX2,sposY2,sposX3,sposY3;
	char got_it=0;
	char diminuX,diminuY;
/*# define DEBUG*/

#ifdef DEBUG
printf("DEBUT %lu %lu ; %lu %lu ; %d\n"
	,player->posX,player->posY,X,Y,marche);
#endif
	if(X<player->posX)
		diminuX=1;
	else if(X>player->posX)
		diminuX=-1;
	else
		diminuX=0;
	if(Y<player->posY)
		diminuY=1;
	else if(Y>player->posY)
		diminuY=-1;
	else
		diminuY=0;
	
	/* on teste 3 positions :
	1 -> pos d'arrivée
	2 -> pos à mi-chemin
	3 -> pos arrivée + X en hauteur (pour monter les pentes)
	si 1 dispo -> pos=1
	sinon si 2 dispo -> pos=entre 1 et 2 (appel récursif)
	sinon si 3 dispo -> pos entre 1 et 3
	sinon -> pos entre 2 et posInit (appel récursif) */

	sposXI=player->posX;	/* pos I */
	sposYI=player->posY;
	
	sposX1=X;		/* pos 1 */
	sposY1=Y;

	sposX2=MIN(player->posX,X)+((MAX(player->posX,X)-MIN(player->posX,X))/2); /* pos 2 */
	sposY2=MIN(player->posY,Y)+((MAX(player->posY,Y)-MIN(player->posY,Y))/2);

	sposX3=X;		/* pos 3 */
	sposY3=Y-marche;
	
#ifdef DEBUG
	printf("P :%lu %lu ; %lu %lu ; %lu %lu ; %lu %lu : %d\n",
		sposXI,sposYI,sposX1,sposY1,sposX2,sposY2,sposX3,sposY3,marche);
#endif
	
	/* pos 1 */
	player->posX=sposX1;
	player->posY=sposY1;

	got_it=isPositionAllowed(player, level_walls,level_sprites);
#ifdef DEBUG
	printf("P1G:%d\n",got_it);
#endif
	/* pos 2 */
	if(!got_it && (sposX1!=sposX2 || sposY1!=sposY2) && (sposXI!=sposX2 || sposYI!=sposY2))
	{
#ifdef DEBUG
		printf("P2T\n");
#endif
		player->posX=sposX2;
		player->posY=sposY2;
		if(isPositionAllowed(player, level_walls,level_sprites))
		{
#ifdef DEBUG
			printf("P2\n");
#endif
			if(sposX2==X)diminuX=0;
			if(sposY2==Y)diminuY=0;
			nearestPosTo(player,level_walls,level_sprites,X+diminuX,Y+diminuY,marche>>1);
			got_it=1;
		}
	}
#ifdef DEBUG
	printf("P2G:%d\n",got_it);
#endif
	/* pos 3 */
	if(!got_it && marche)
	{	
#ifdef DEBUG
		printf("P3T\n");
#endif
		player->posX=sposX3;
		player->posY=sposY3;
		if(isPositionAllowed(player, level_walls,level_sprites))
		{
#ifdef DEBUG
			printf("P3\n");
#endif
			nearestPosTo(player,level_walls,level_sprites,X,Y-1,0);
			got_it=1;
		}
	}
#ifdef DEBUG
	printf("P3G:%d\n",got_it);
#endif
	/* posinit */
	if(!got_it && (sposXI!=sposX1 || sposYI!=sposY1) && (sposX1!=sposX2 || sposY1!=sposY2))
	{
#ifdef DEBUG
		printf("PIT\n");
#endif
		player->posX=sposXI;
		player->posY=sposYI;
#ifdef DEBUG
		printf("PI\n");
#endif
		if(sposXI==sposX2)diminuX=0;
		if(sposYI==sposY2)diminuY=0;
		nearestPosTo(player,level_walls,level_sprites,sposX2+diminuX,sposY2+diminuY,0);
		got_it=1;
	}
	if(!got_it)
	{	player->posX=sposXI;
		player->posY=sposYI;
#ifdef DEBUG
		printf("PF\n");
#endif
		got_it=1;
	}
#ifdef DEBUG
printf("FIN\n");
#endif
	return got_it;
}

void performSpriteImage(mySprite *sprite)
{	int next,vue; /*  >0 =drte ; <O =gche */

	/* si image statique -> rien à faire */
	if(sprite->spImages->type==SINGLE)
		return;

	/* pour l'invincibilite */
	if(sprite->invincible)
	{	if(sprite->invincible%4==0)
		{	sprite->image=NULL;
			return;
		}
	}

	/* defini le rythme auquel on change d'image */
	if(sprite->draw_image_count)
	{	sprite->draw_image_count--;
		return;
	}
	
	sprite->draw_image_count=3;

	/* on fait simplement defiler les images */
	if(sprite->spImages->type==LIST)
	{	next=sprite->draw_image_state+1;
		if(next>=sprite->spImages->imgs_cnt)
			next=0;
		sprite->image=sprite->spImages->imgs[next];
		sprite->draw_image_state=next;
		return;
	}

	vue=sprite->direction;

	if(sprite->spImages->type==SIMPLE)
	{	next=sprite->draw_image_state+1;
		if(vue>0)
		{	if(next<DRTE_AV1 || next>DRTE_AV4)
				next=DRTE_AV1;
		}
		else
		{	if(next<GCHE_AV1 || next>GCHE_AV4)
				next=GCHE_AV1;
		}
		sprite->image=sprite->spImages->imgs[next];
		sprite->draw_image_state=next;
	}
	else /* COMPLETE */
	{
		/* joueur chute */
		if(sprite->vertical_speed>0)
		{	if(vue>0)
			{	sprite->image=sprite->spImages->imgs[DRTE_FALL];
				sprite->draw_image_state=DRTE_FALL;
			}
			else
			{	sprite->image=sprite->spImages->imgs[GCHE_FALL];
				sprite->draw_image_state=GCHE_FALL;
			}
		}
		/* joueur " a plat" */
		else if(sprite->touchground)
		{	/* joueur a l'arret */
			if(sprite->horizontal_speed == 0)
			{	if(vue>0)
				{	sprite->image=sprite->spImages->imgs[DRTE_STOP];
					sprite->draw_image_state=DRTE_STOP;
				}
				else
				{	sprite->image=sprite->spImages->imgs[GCHE_STOP];
					sprite->draw_image_state=GCHE_STOP;
				}
			}
			/* joueur avance */
			else
			{	next=sprite->draw_image_state+1;
				if(vue>0)
				{	if(next<DRTE_AV1 || next>DRTE_AV4)
						next=DRTE_AV1;
				}
				else
				{	if(next<GCHE_AV1 || next>GCHE_AV4)
						next=GCHE_AV1;
				}
				sprite->image=sprite->spImages->imgs[next];
				sprite->draw_image_state=next;
			}
		}
		/* joueur saute */
		else
		{	if(vue>0)
			{	sprite->image=sprite->spImages->imgs[DRTE_JUMP];
				sprite->draw_image_state=DRTE_JUMP;
			}
			else
			{	sprite->image=sprite->spImages->imgs[GCHE_JUMP];
				sprite->draw_image_state=GCHE_JUMP;
			}
		}
	}
}
