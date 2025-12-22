/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

# include "Sother.h"

# define STD_HORIZONTAL_SPEED		4  /* vitesse de déplacement standard */
# define STD_HORIZONTAL_ACCELERATION	1  /* accélération normale */
# define STD_HORIZONTAL_DECELERATION	1  /* décélération normale (frottements) */

# define MAX_VERTICAL_SPEED		21 /* vitesse de chute max */
# define STD_VERTICAL_ACCELERATION	21 /* force de saut */
# define STD_VERTICAL_DECELERATION	2  /* force de gravité */

int giveRandomBonus(void)
{	int id=0,rnd=rand() % 6;
	switch(rnd)
		{case 0:id=62;break;
		case 1:id=63;break;
		case 2:id=71;break;
		case 3:id=84;break;
		case 4:id=99;break;
		case 5:id=101;break;
		}
	return id;
}

char initOther(mySprite * player)
{
	player->vertical_speed=0;
	player->horizontal_speed=0;
	
	player->goright=0;
	player->acceleration=0;

	player->direction=0;
	if(player->sprite_management_type&SPRITE_MOVE)
	{	player->goleft=1;
		player->direction=-1;
	}
	else
	{	player->goleft=0;
		player->direction=0;
	}

	if(player->sprite_management_type&SPRITE_BOUNCY)
		player->gojump=1;
	else
		player->gojump=0;
	
	if(player->sprite_management_type & SPRITE_FLYING || player->id == 78)
		player->touchground=1;
	else
		player->touchground=0;
	player->draw_image_state = 0;
	player->etat=ETAT_VIVANT | ETAT_VISIBLE;

	return 0;
}

#define PLT_VERTICALE	0
#define PLT_HORIZONTALE	1
#define PLT_TOURNANTE	2
#define MAXDISTDIST 	10000 /* distance maximum d'éloignenment de posinit (au carré!) */
int performBonusPlateforme(mySprite *player,myList * level_walls,myList * level_sprites,int type)
{	char tourne=0;
	long sposX,sposY;

/*printf("IN %ld %ld\n",player->posX,player->posY);*/
	if(!player->direction)
		player->direction=1;

	if(type==PLT_HORIZONTALE)
	{	if(player->direction>0)
			player->horizontal_speed=STD_HORIZONTAL_SPEED;
		else
			player->horizontal_speed=-STD_HORIZONTAL_SPEED;
	}
	if(type==PLT_VERTICALE)
	{	if(player->direction>0)
			player->vertical_speed=STD_HORIZONTAL_SPEED;
		else
			player->vertical_speed=-STD_HORIZONTAL_SPEED;
	}

	/* sauvegarde des positions d'arrivée */
	sposX=player->posX;
	sposY=player->posY;

	nearestPosTo(player,level_walls,level_sprites,
		player->posX+player->horizontal_speed,
		player->posY+player->vertical_speed,
		0); /* à modifier pour essayer de monter les cotes */
		
	/* changement de direction ? */
	tourne=0;
	if(type==PLT_HORIZONTALE)
	{	if(player->direction>0)
			tourne=!testPositionAllowed(player, level_walls,level_sprites, 1, 0);
		else
			tourne=!testPositionAllowed(player, level_walls,level_sprites,-1, 0);
	}
	if(!tourne && type==PLT_VERTICALE)
	{	if(player->direction>0)
			tourne=!testPositionAllowed(player, level_walls,level_sprites, 0, 1);
		else
			tourne=!testPositionAllowed(player, level_walls,level_sprites, 0,-1);
	}
	if(tourne)
	{	player->direction=-player->direction;
		/*printf("tourne !\n");*/
	}
	/* trop éloigné de la position initiale ? */
	{	long distX=player->posX-player->posXinit;
		long distY=player->posY-player->posYinit;
		long distcc=distX*distX+distY*distY;
		
		if(distcc>=MAXDISTDIST)
		{	if(distX>0 || distY>0)
				player->direction=-1;
			if(distX<0 || distY<0)
				player->direction= 1;
			player->posX=sposX;
			player->posY=sposY;
			player->horizontal_speed=player->vertical_speed=0;
		}
	}
	
/*printf("OU %ld %ld\n",player->posX,player->posY);*/

	return 0;
}

int performSprite98(mySprite *player,myList * level_walls,myList * level_sprites)
{	long sposX,sposY,tX[3],tY[3],ecart[3];
	long distX,distY,distcc;
	int step,i,j;

	if(!player->direction)
		player->direction=1;

	for(step=0;step<4;step++)
	{
		/* sauvegarde des positions d'arrivée */
		sposX=player->posX;
		sposY=player->posY;

		if(sposX < player->posXinit && sposY < player->posYinit)
			player->direction=-2;
		if(sposX < player->posXinit && sposY > player->posYinit)
			player->direction=1;
		if(sposX > player->posXinit && sposY > player->posYinit)
			player->direction=2;
		if(sposX > player->posXinit && sposY < player->posYinit)
			player->direction=-1;
		/* 3 positions possibles */
		switch(player->direction)
		{case -2 :	tX[0]=sposX-1;	tY[0]=sposY;
				tX[1]=sposX-1;	tY[1]=sposY+1;
				tX[2]=sposX;	tY[2]=sposY+1;
				break;
		case 1 :	tX[0]=sposX+1;	tY[0]=sposY;
				tX[1]=sposX;	tY[1]=sposY+1;
				tX[2]=sposX+1;	tY[2]=sposY+1;
				break;
		case 2 :	tX[0]=sposX;	tY[0]=sposY-1;
				tX[1]=sposX+1;	tY[1]=sposY-1;
				tX[2]=sposX+1;	tY[2]=sposY;
				break;
		case -1 :	tX[0]=sposX-1;	tY[0]=sposY-1;
				tX[1]=sposX-1;	tY[1]=sposY;
				tX[2]=sposX;	tY[2]=sposY-1;
				break;
		}
		/* on sélectionne la plus proche du rayon */
		for(i=0;i<3;i++)
		{	distX=player->posXinit-tX[i];
			distY=player->posYinit-tY[i];
			distcc=distX*distX+distY*distY;
			for(ecart[i]=0;ecart[i]<MAXDISTDIST;ecart[i]++)
			{	if(distcc+ecart[i] == MAXDISTDIST || distcc-ecart[i] == MAXDISTDIST)
					break;
				for(j=0;j<i-1;j++)
					if(ecart[i] > ecart[j])
						ecart[i]=MAXDISTDIST;
			}
		}
		
		if(ecart[0]<ecart[1])
		{	if(ecart[0]<ecart[2])
				i=0;
			else
				i=2;
		}
		else
		{	if(ecart[1]<ecart[2])
				i=1;
			else
				i=2;
		}
	
		player->posX=tX[i];
		player->posY=tY[i];
	}		
	return 0;
}

/* switch */
int performBonus87(mySprite *player,myList * level_walls,myList * level_sprites)
{	
	if( player->must_die )
	{	/* on positionne le compte a rebours switch */
		static_level_datas.switchTime+=10;
		player->etat=ETAT_NONE;
	}
	return 0;
}

int performCanon(mySprite *player,myList * level_walls,myList * level_sprites)
{	
	if(player->draw_image_state<100)
		player->draw_image_state++;
	else
	{	player->draw_image_state=0;
		
		player->direction=-1; /* gauche */
		if( testPositionAllowed(player , level_walls,level_sprites , -20 , 0))
			createNewSpriteNear(player,103,POS_SIDE,level_walls,level_sprites);

		player->direction=1; /* droite */
		if( testPositionAllowed(player , level_walls,level_sprites , 20 , 0))
			createNewSpriteNear(player,103,POS_SIDE,level_walls,level_sprites);
	}
	return 0;
}

/* [!] box */
int performBonusTileRnd(mySprite *player,myList * level_walls,myList * level_sprites)
{	
	if( player->must_die )
	{	changeSpriteToId(player,66,level_walls,level_sprites,1);
		
		/* on rajoute un bonus au dessus */
		createNewSpriteNear(player,giveRandomBonus(),POS_UP,level_walls,level_sprites);
	}
	return 0;
}

int performBonusTile(mySprite *player,myList * level_walls,myList * level_sprites, int bonus_id)
{	
	if( player->must_die )
	{	changeSpriteToId(player,66,level_walls,level_sprites,1);
		
		/* on rajoute un bonus au dessus */
		createNewSpriteNear(player,bonus_id,POS_UP,level_walls,level_sprites);
	}
	return 0;
}

int performBoulet(mySprite *player,myList * level_walls,myList * level_sprites)
{	int code_retour=0; /* 0=on continue ; 1=sprite mort */

	/* calcul des nouvelles vitesses */
	calculeNewVitesse(player,STD_HORIZONTAL_SPEED,STD_HORIZONTAL_ACCELERATION,STD_HORIZONTAL_DECELERATION
					,MAX_VERTICAL_SPEED,  STD_VERTICAL_ACCELERATION,  STD_VERTICAL_DECELERATION);

	code_retour=commonMounvingSpriteBehaviour(player,level_walls,level_sprites);

	if( !player->must_die && player->etat == (ETAT_VISIBLE | ETAT_VIVANT) )
	{	/* on teste si on touche quelque chose alors on explose */
		if( ! testPositionAllowed(player , level_walls,level_sprites , player->horizontal_speed<0?-1:+1 , 0))
			changeSpriteToId(player,102,level_walls,level_sprites,1);
	}
	else	/* mourant */
	{	if(player->must_die)
		{	startTheSound("snd/kill.wav");
			player->must_die=0;
		}
		player->etat=ETAT_VISIBLE;
		player->touchground=0;
		if(player->vertical_speed<0)
			player->vertical_speed=0;
				
		player->posX+=player->horizontal_speed;
		player->posY+=player->vertical_speed;
	}

	/* si le sprite est tombé dans un trou ! */
	if(player->posY >= MAX_VERTICAL_POSITION)
	{	player->etat=ETAT_NONE;
		code_retour=1;
	}

	/* les boulets disparaissent si ils sont trop eloignés */
	if( player->posX + static_level_datas.decalX > 800 ||
	    player->posX + static_level_datas.decalX < -player->image->w )
	{	player->etat=ETAT_NONE;
		code_retour=1;
	}	
	
	/* choix de l'image */
	performSpriteImage(player);

	return code_retour;
}

int performExplosion(mySprite *player,myList * level_walls,myList * level_sprites)
{	int code_retour=0; /* 0=on continue ; 1=sprite mort */

	if( !player->must_die )
	{	/* on compte a partir de 100 */
		if(player->draw_image_state<100)
			player->draw_image_state=120;
		player->image=player->spImages->imgs[player->draw_image_state%2];
		player->draw_image_state--;
		if(player->draw_image_state<100)
			player->must_die=1;
	}
	else
	{	player->etat=ETAT_NONE;
		code_retour=1;
	}
	return code_retour;
}

int performExploBomb(mySprite *player,myList * level_walls,myList * level_sprites)
{	int code_retour=0; /* 0=on continue ; 1=sprite mort */

	/* calcul des nouvelles vitesses */
	calculeNewVitesse(player,STD_HORIZONTAL_SPEED,STD_HORIZONTAL_ACCELERATION,STD_HORIZONTAL_DECELERATION
					,MAX_VERTICAL_SPEED,  STD_VERTICAL_ACCELERATION,  STD_VERTICAL_DECELERATION);

	if( !player->must_die )
	{	code_retour=commonMounvingSpriteBehaviour(player,level_walls,level_sprites);
		
		if(player->draw_image_count)
		{	player->draw_image_count--;
		}
		else	 /* on compte a partir de 100 */
		{	if(player->draw_image_state<100)
				player->draw_image_state=110;
			if(player->draw_image_state>105)
				player->draw_image_count=10;
			else
				player->draw_image_count=5;
			player->image=player->spImages->imgs[player->draw_image_state%2];
			player->draw_image_state--;
			if(player->draw_image_state<100)
				player->must_die=1;
		}
	}
	else	/* on explose */
	{	changeSpriteToId(player,102,level_walls,level_sprites,1);
		code_retour=1;
	}
	return code_retour;
}

/* under ground mole */
int performBonus72(mySprite *player,myList * level_walls,myList * level_sprites)
{	
	int next,code_retour=0; /* 0=on continue ; 1=sprite mort */

	/* calcul des nouvelles vitesses */
	calculeNewVitesse(player,STD_HORIZONTAL_SPEED,STD_HORIZONTAL_ACCELERATION,STD_HORIZONTAL_DECELERATION
					,MAX_VERTICAL_SPEED,  STD_VERTICAL_ACCELERATION,  STD_VERTICAL_DECELERATION);

	if( !player->must_die )
	{	code_retour=commonMounvingSpriteBehaviour(player,level_walls,level_sprites);
			
		/* touche le sol ? */
		if(!testPositionAllowed(player, level_walls,level_sprites,0,1))
		{	player->touchground=1;
			/* comportement spécial si on va vers le vide (saut ou demi-tour) */
			/* x4 pour ne pas trop déborder des bords */
			if(testPositionAllowed(player, level_walls,level_sprites,player->horizontal_speed<<2,1))
				demi_tour(player);
		}
		else if(!(player->sprite_management_type & SPRITE_FLYING))
			player->touchground=0;
		
		/* comportement spécial : si on est proche du joueur, alors on meure pour se transformer et sortir de terre */
//		printf("DEBUG -> %ld %ld\n",static_level_datas.global_player->posX , player->posX);
		if(labs(static_level_datas.global_player->posX-player->posX) < 100)
			player->must_die=1;
	}
	else	/* mourant */
	{	if(player->draw_image_count)
		{	player->draw_image_count--;
		}
		else
		{	player->draw_image_count=5;
			next=player->draw_image_state+1;
			if(next>=player->spImages->imgs_cnt)
			{	/* en fait, on meure pour mieux revivre ;-) */
				changeSpriteToId(player,60,level_walls,level_sprites,0);
				player->posY -= player->map->h;
			}
			else
			{	player->image=player->spImages->imgs[next];
				player->draw_image_state=next;
			}
		}
	}

	/* si le player est tombé dans un trou ! */
	if(player->posY >= MAX_VERTICAL_POSITION)
	{	player->etat=ETAT_NONE;
		code_retour=1;
	}

	return code_retour;
}

int performOther(mySprite *player,myList * level_walls,myList * level_sprites)
{	
	char * liste_coll=NULL;
	int code_retour=0; /* 0=on continue ; 1=sprite mort */
	
	/* gestio speciales */
	switch(player->id)
	{case 87: /* switch */
		return performBonus87(player,level_walls,level_sprites);
	case  55: /* [!] */
	case  95:
		return performBonusTileRnd(player,level_walls,level_sprites);
	case 105: /* donne chrono 71 */
		return performBonusTile(player,level_walls,level_sprites,71);
	case 106: /* donne sac 62 */
		return performBonusTile(player,level_walls,level_sprites,62);
	case 107: /* donne potion 63 */
		return performBonusTile(player,level_walls,level_sprites,63);
	case 108: /* donne coin 83 */
		return performBonusTile(player,level_walls,level_sprites,83);
	case 109: /* donne coin 84 */
		return performBonusTile(player,level_walls,level_sprites,84);
	case 110: /* donne gem 99 */
		return performBonusTile(player,level_walls,level_sprites,99);
	case  72: /* deep mole */
		return performBonus72(player,level_walls,level_sprites);
	case  96: /* plateforme horizontale */
		return performBonusPlateforme(player,level_walls,level_sprites,PLT_HORIZONTALE);
	case  97: /* plateforme verticale */
		return performBonusPlateforme(player,level_walls,level_sprites,PLT_VERTICALE);
	case  98: /* rotating pics */
		return performSprite98(player,level_walls,level_sprites);
	case 101: /* explobomb */
		return performExploBomb(player,level_walls,level_sprites);
	case 102: /* explosion */
		return performExplosion(player,level_walls,level_sprites);
	case 103: /* boulet */
		return performBoulet(player,level_walls,level_sprites);
	case 104: /* canon */
		return performCanon(player,level_walls,level_sprites);
	}
	
	/* calcul des nouvelles vitesses */
	if(player->id == 76 || player->id == 89) /* shuriken , lpics */
		calculeNewVitesse(player,STD_HORIZONTAL_SPEED*4,STD_HORIZONTAL_SPEED*4,0,0,0,0);
	else if(player->id == 78) /* marteau */
		calculeNewVitesse(player,STD_HORIZONTAL_SPEED*2,STD_HORIZONTAL_SPEED*2,0
					,MAX_VERTICAL_SPEED,  STD_VERTICAL_ACCELERATION,  STD_VERTICAL_DECELERATION);
	else
		calculeNewVitesse(player,STD_HORIZONTAL_SPEED,STD_HORIZONTAL_ACCELERATION,STD_HORIZONTAL_DECELERATION
					,MAX_VERTICAL_SPEED,  STD_VERTICAL_ACCELERATION,  STD_VERTICAL_DECELERATION);

	if( !player->must_die && player->etat == (ETAT_VISIBLE | ETAT_VIVANT) )
	{
		code_retour=commonMounvingSpriteBehaviour(player,level_walls,level_sprites);

		/* on a trouvé le position finale du sprite */
		/* y a t-il une incidence ? (typiquement player à tuer) */
		liste_coll=getCollisionList(player,level_walls,level_sprites);

		/* contact fatal ? */
		if(	(player->id == 78 || player->id == 76 || player->id == 89)
			&& isElementIn(COLLISION_S1_DIE,liste_coll))
		{	player->etat=ETAT_NONE;
			code_retour=1;
		}
		else
		{	/* touche le sol ? */
			if(!testPositionAllowed(player, level_walls,level_sprites,0,1))
			{	player->touchground=1;
				if(player->sprite_management_type&SPRITE_BOUNCY)
					player->gojump=1;
				/* comportement spécial si on va vers le vide (saut ou demi-tour) */
				if(player->sprite_management_type&(SPRITE_TURNONEDGE|SPRITE_JUMPONEDGE))
				{	/* x4 pour ne pas trop déborder des bords */
					if(testPositionAllowed(player, level_walls,level_sprites,player->horizontal_speed<<2,1))
					{	if(player->sprite_management_type&SPRITE_TURNONEDGE)
							demi_tour(player);
						else
							player->gojump=1;
					}
				}
			}
			else if(!(player->sprite_management_type & SPRITE_FLYING))
			{	player->touchground=0;
				player->gojump=0;
			}

			/* armes lancées ! */	
			if(	(player->id == 57 || player->id == 82)
				&& rand()%100==0 ) /* lance une arme */
			{	
				if(player->id == 57) /* hammer */
					createNewSpriteNear(player,78,POS_SIDE,level_walls,level_sprites);
				else if(player->id == 82) /* lpic */
					createNewSpriteNear(player,89,POS_SIDE,level_walls,level_sprites);
			}
		}
	}
	else	/* mourant */
	{	if(player->must_die)
		{	startTheSound("snd/kill.wav");
			player->must_die=0;
		}
		player->etat=ETAT_VISIBLE;
		player->touchground=0;
		if(player->vertical_speed<0)
			player->vertical_speed=0;
				
		player->posX+=player->horizontal_speed;
		player->posY+=player->vertical_speed;
		if(player->id == 53) /* caisse devient bonus  */
		{	changeSpriteToId(player,giveRandomBonus(),level_walls,level_sprites,1);
			player->vertical_speed=0;
		}
		else if(player->id == 100) /* bomby devient explobomb  */
		{	changeSpriteToId(player,101,level_walls,level_sprites,1);
			player->horizontal_speed=0;
		}
		else if(player->id == 76 || player->id == 78 || player->id == 89)
		{	/* les armes disparaissent de suite */
			player->etat=ETAT_NONE;
			code_retour=1;
		}
	}

	/* si le sprite est tombé dans un trou ! */
	if(player->posY >= MAX_VERTICAL_POSITION)
	{	player->etat=ETAT_NONE;
		code_retour=1;
	}

	/* les armes disparaissent si elles sont trop eloignées */
	if( ( player->id == 76 || player->id == 78 || player->id == 89 ) &&
	    ( player->posX + static_level_datas.decalX > 800 ||
	      player->posX + static_level_datas.decalX < -player->image->w ) )
	{	player->etat=ETAT_NONE;
		code_retour=1;
	}
	
	/* pour les sprites que l'on peut "actionner", test présence gauche/droite */
	if( player->id == 53 || player->id == 56 )
	{	char d,g;
		long sposX=player->posX;
		/* a gauche */
		player->posX--;
		liste_coll=getCollisionList(player,level_walls,level_sprites);
		g=liste_coll[0];
		/* a droite */
		player->posX+=2;
		liste_coll=getCollisionList(player,level_walls,level_sprites);
		d=liste_coll[0];
		player->posX=sposX;
		
		/* pousse ? */
		if(player->goright || player->goleft)
		{	if(g != 0 && d == 0)
			{	player->goright=1;
				player->goleft=0;
				player->direction=1;
			}
			if(g == 0 && d != 0)
			{	player->goright=0;
				player->goleft=1;
				player->direction=-1;
			}
		}
		else
		{	if(g != 0 && d == 0)
				player->posX++;
			if(g == 0 && d != 0)
				player->posX--;
		}
	}
	
	/* choix de l'image */
	performSpriteImage(player);

	return code_retour;
}
