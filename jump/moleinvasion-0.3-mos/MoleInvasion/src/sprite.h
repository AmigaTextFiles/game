/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef SPRITE_H
#define SPRITE_H

# include "graphics.h"
# include "list.h"
# include "mixer.h"

/* for sprite management type */
# define SPRITE_TILE	0
# define SPRITE_PLAYER	1
# define SPRITE_FLYING	2
# define SPRITE_BOUNCY	4
# define SPRITE_FALL	8
# define SPRITE_MOVE	16
# define SPRITE_TURNONEDGE 32
# define SPRITE_JUMPONEDGE 64
# define SPRITE_SPECIFIC 128
# define SPRITE_FOREGROUND 256
# define SPRITE_MAKE_REBOUNCE 512

/* for player and ennemy status */
# define ETAT_NONE	0
# define ETAT_VISIBLE	1
# define ETAT_VIVANT	2
# define ETAT_GAGNANT	4

/* limite inférieure du jeu */
# define MAX_VERTICAL_POSITION		600

typedef struct mySprite{

    /* Id ( pos in tiles.c ( for recognition in level_files )) */
    unsigned int id;

    /* sprite position */
    long posX,posY;

    long posXinit,posYinit; /* position initiale pour déplacements relatifs */
    
    /* current image */
    SDL_Surface* image;
    
    /* current map */
    SDL_Surface* map;
    SDL_Surface* optmap; /* pour affichage */

    /* how to manage it ? */
    unsigned int sprite_management_type;

	/* FOR PLAYER AND ENNEMY ONLY */
	/******************************/

	/* pour les mouvements */
	int vertical_speed, horizontal_speed;
	
	/* actions */
	char goleft, goright, gojump, godown, gospace, rebounce;
	char acceleration, action, can_superjump;
	char must_die;
	
	/* divers */
	char touchground;
	char direction; /* <0 gauche >0 droite */
	
	/* images */
	struct gsi * spImages;

	/* draw image state */
	char draw_image_state;
	char draw_image_count;
	
	/* état */
	char etat;
	
	/* FOR PLAYER AND ENNEMY ONLY */
	/******************************/

	/* sprite qui tue player */
	struct mySprite * touch_by;
	/* sprite qui bloque player */
	struct mySprite * stop_by;
    
	/* duree d'invincibilite ( par 1/30 secondes ) */
	int invincible;
    
} mySprite;

# include "level.h"

unsigned int GetNumberOfSprites();

/* #define GAME_MODE	0
   #define EDITOR_MODE	1 */
int init_all_images(char * wall_gfx_dir, char mode);

int free_all_images();

int GetPosOfId(unsigned int id);
int GetIdOfPos(unsigned int pos);
char LoadSprite(mySprite * sprite,unsigned int id);

int displaySprite( mySprite sprite, SDL_Surface* screen, long decalX, long decalY);
int displaySpriteMap( mySprite sprite, SDL_Surface* screen, long decalX, long decalY);

/* gestion des collisions */
void giveOrderedListPlage(unsigned int * deb,myList * ordered_list, int xmin);
char testPositionAllowed(mySprite *player,myList * level_walls,myList * level_sprites, int modX, int modY);
char isPositionAllowed(mySprite *player,myList * level_walls,myList * level_sprites);
unsigned char * getCollisionList(mySprite *player,myList * level_walls,myList * level_sprites);
unsigned int isElementIn(unsigned char val,unsigned char * liste_coll);

/* codes collisions */
# define COLLISION_NONE		0
# define COLLISION_S1_STOP	1	/* sprite1 should stop */
# define COLLISION_S1_DIE	2	/* sprite1 should die */ 
# define COLLISION_S1_WIN	4	/* sprite1 should win */ 
# define COLLISION_S1_KILL	8	/* sprite1 has killed something */ 
# define COLLISION_S1_BONUS	16	/* sprite1 has obtained a bonus */ 
# define COLLISION_X		32
# define COLLISION_XX		64
# define COLLISION_XXX		128

/* code bonus */
# define BONUS_NONE		0
# define BONUS_TRANSF_LAPIN	1
# define BONUS_TRANSF_NINJA	2
# define BONUS_TRANSF_SMALL	3
# define BONUS_COIN		4
# define BONUS_COIN10		5
# define BONUS_CHRONO		6
unsigned int get_last_bonus();

void demi_tour(mySprite * player);

int commonMounvingSpriteBehaviour(mySprite *player,myList * level_walls,myList * level_sprites);

char calculeNewVitesse(mySprite *player,
	float max_horizontal_acceleration, float std_horizontal_acceleration, float std_horizontal_deceleration,
	float max_vertical_deceleration,   float std_vertical_acceleration,   float std_vertical_deceleration);

void calculeNewPosition(mySprite *player,unsigned char diminuX, unsigned char diminuY);

int nearestPosTo(mySprite *player,myList * level_walls,myList * level_sprites,long X, long Y, unsigned int marche);

char loadSpriteImages(mySprite * player,char * base_name);

#define POS_UP	 1
#define POS_SIDE 2
void createNewSpriteNear(mySprite * sprite,int id, char pos, myList * level_walls,myList * level_sprites);

void changeSpriteToId(mySprite * sprite, int id, myList * level_walls,myList * level_sprites, char reset);

void performSpriteImage(mySprite *sprite);

#endif
