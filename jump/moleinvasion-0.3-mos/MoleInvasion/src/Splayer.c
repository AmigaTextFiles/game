/* MoleInvasion 0.3 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

# include "worldmap.h"
# include "Sother.h"
# include "Splayer.h"

# define STD_HORIZONTAL_SPEED		7  /* vitesse de déplacement max */
# define MAX_HORIZONTAL_SPEED		10 /* vitesse de déplacement max avec acceleration */
# define STD_HORIZONTAL_ACCELERATION	2  /* accélération normale */
# define STD_HORIZONTAL_DECELERATION	1  /* décélération normale (frottements) */

# define MAX_VERTICAL_SPEED		21 /* vitesse de chute max */
# define STD_VERTICAL_ACCELERATION	21 /* force de saut */
# define MAX_VERTICAL_ACCELERATION	24 /* force de saut avec acceleration */
# define STD_VERTICAL_DECELERATION	2  /* force de gravité */

# define DECALAGE 400

char initPlayer(mySprite * player)
{	
	player->vertical_speed=0;
	player->horizontal_speed=0;
	player->touchground=0;
	
	player->goleft=player->goright=player->gojump=player->acceleration=0;
	player->direction=1;
	
	player->etat=ETAT_VIVANT | ETAT_VISIBLE;
	
	return 0;
}

int performPlayer(mySprite *player,myList * level_walls,myList * level_sprites)
{	
	char * liste_coll;
	int code_retour=0; /* 0=on continue ; 1=player mort ; 2=player gagnant */

	/* calcul des nouvelles vitesses */
	if(player->acceleration && abs(player->horizontal_speed) >= STD_HORIZONTAL_SPEED )
		calculeNewVitesse(player,MAX_HORIZONTAL_SPEED,STD_HORIZONTAL_ACCELERATION,STD_HORIZONTAL_DECELERATION
					,MAX_VERTICAL_SPEED
					,MAX_VERTICAL_ACCELERATION
					,STD_VERTICAL_DECELERATION);
	else
		calculeNewVitesse(player,STD_HORIZONTAL_SPEED,STD_HORIZONTAL_ACCELERATION,STD_HORIZONTAL_DECELERATION
					,MAX_VERTICAL_SPEED
					,STD_VERTICAL_ACCELERATION
					,STD_VERTICAL_DECELERATION);

	code_retour=commonMounvingSpriteBehaviour(player,level_walls,level_sprites);
	
	/* position finale */
	liste_coll=getCollisionList(player,level_walls,level_sprites);
	
	/* a sauté ? */
	if(player->touchground && player->gojump)
		startTheSound("snd/jump.wav");
	
	/* touche le sol en tombant ? */
	if(player->vertical_speed>=0)
	{	if(!testPositionAllowed(player, level_walls,level_sprites,0,+1))
		{	player->touchground=player->can_superjump=1;
			/* de plus si le sprite fait rebondir */
			if(player->stop_by->sprite_management_type & SPRITE_MAKE_REBOUNCE)
			{	printf("id rebo=%d\n",player->stop_by->id);
				if(player->rebounce)
				{	if(player->acceleration)
						player->vertical_speed=-MAX_VERTICAL_ACCELERATION; /* grand saut */
					else
						player->vertical_speed=-STD_VERTICAL_ACCELERATION; /* saut */
				}
				else
					player->vertical_speed=-((int)STD_VERTICAL_ACCELERATION)/2; /* petit rebond */
			}
		}
		else
			player->touchground=0;
	}
	else
		player->touchground=0;

	/* contact fatal ? */
	if( !player->invincible && player->must_die)
	{	printf("Touched by %d (dir=%d)!\n",player->touch_by->id, player->touch_by->direction);
		/* si on est Tux de base, alors on meure sinon, on redevient Tux */
		if(player->id == 50)
		{	player->etat=ETAT_VISIBLE;
			code_retour=1;
		}
		else
		{	startTheSound("snd/loose.wav");
			changeSpriteToId(player,50,level_walls,level_sprites,0);
			/* + saut en arrière */
			if(player->touch_by->direction)
				player->horizontal_speed= player->touch_by->direction * (float)MAX_HORIZONTAL_SPEED ;
			else
				player->horizontal_speed= - player->direction * (float)MAX_HORIZONTAL_SPEED;
			/* 3 secondes d'invincibilite */
			player->invincible=30*3;
			player->must_die=0;
		}
	}/* invincibilite ? */
	else if(player->invincible)
		player->invincible--;

	/* si le player est tombé dans un trou ! */
	if(player->posY >= MAX_VERTICAL_POSITION)
	{	player->etat=ETAT_VISIBLE;
		code_retour=1;
	}

	/* contact gagnant ? */
	if(isElementIn(COLLISION_S1_WIN,liste_coll))
	{	player->etat|=ETAT_GAGNANT;
		code_retour=2;
	}
	
	/* un bonus pour le sprite ? */
	if(isElementIn(COLLISION_S1_BONUS,liste_coll))
	{	unsigned int bonus = get_last_bonus();
	
		if(bonus == BONUS_TRANSF_LAPIN)
		{	startTheSound("snd/transfo.wav");
			changeSpriteToId(player,74,level_walls,level_sprites,0);
		}
		else if(bonus == BONUS_TRANSF_NINJA)
		{	startTheSound("snd/transfo.wav");
			changeSpriteToId(player,67,level_walls,level_sprites,0);
		}
		else if(bonus == BONUS_TRANSF_SMALL)
		{	startTheSound("snd/transfo.wav");
			changeSpriteToId(player,64,level_walls,level_sprites,0);
		}
		else if(bonus == BONUS_COIN)
		{	startTheSound("snd/coin.wav");
			static_world_datas.coins++;
		}	
		else if(bonus == BONUS_COIN10)
		{	startTheSound("snd/coin.wav");
			static_world_datas.coins+=10;
		}	
		else if(bonus == BONUS_CHRONO)
		{	startTheSound("snd/chrono.wav");
			static_level_datas.currentTime+=20;
		}	
	}
	
	if(player->id == 67 && player->action ) /* ninja lance un shuriken */
	{	/* on rajoute un shuriken à gauche ou a droite */
		createNewSpriteNear(player,76,POS_SIDE,level_walls,level_sprites);
	}
	
	if(player->id == 74 && player->action && player->can_superjump) /* lapin fait un double saut */
	{	player->vertical_speed=-MAX_VERTICAL_ACCELERATION; /* grand saut */
		player->can_superjump=0;
	}
	
	/* choix de l'image */
	performSpriteImage(player);
	
	return code_retour;
}
