/*
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include "main.h"

extern int  armour,
    missed,
    size,
    score,
    good,
    live,
    health,
    lives,
    weapon,
    boss,
    level,
    pauza,
    levels,
    is_beep,
    hmk[2];

extern struct object obj[384];
extern struct object eleft;
extern struct object ebottom;
extern struct object eright;
extern struct object ship;
extern char boss_mask_1[7][27];

/* NAME:	collision 
 * DESCRIPTION:	Sprawdza czy nie bylo kolizji
 */
int collision(struct object *obj_a, struct object *obj_b )
{
    if(obj_a->x + obj_a->w -1 < obj_b->x ||
	    obj_a->x > obj_b->x + obj_b->w -1 ||
	    obj_a->y > obj_b->y + obj_b->h -1 ||
	    obj_a->y + obj_a->h -1 < obj_b->y)
    {
	return 0;
    }
    return 1;
}

/* NAME:	adv_collision
 * DESCRIPTION:	Sprawdza czy nie bylo kolizji
 */
int adv_collision(struct object *pocisk, struct object *bossp )
{
    if( collision(pocisk,bossp) )
    {
	if(boss==1) {
	    if( boss_mask_1 [pocisk->y - bossp->y][pocisk->x - bossp->x] == 1 )
	    {
		return 1;
	    }
	}

    }
    return 0;
}

/* NAME:	check_edges
 * DESCRIPTION:	Sprawdza granice dla obiektu
 */
void check_edges(int ij)
{
    int i;
    /* czy obiekt wybucha? (ramka wieksza niz 0 oznacza faze wybuchu) */
    if(obj[ij].frame >=1 ) {
	if(obj[ij].frame < 6) 
	    obj[ij].frame++;
	return;
    }

    /* boczne krawedzie ekranu
     * nie wychodzi z funkcji, bo obiekt ktory
     * wychodzi za krawedz, moze tez nachodzic
     * na pocisk / statek */
    if(collision( &obj[ij], &eright))
	obj[ij].x=COLS-23-obj[ij].w;
    else if(collision( &obj[ij], &eleft))
	obj[ij].x=1;

    if(collision( &obj[ij], &ebottom)) 
    {
	if(obj[ij].type == ENEMY)
	{
	    obj[ij].y--;
	    if(is_beep == 1)
		beep();
	}
	if(obj[ij].type == PACK_ARMOUR  ||
		obj[ij].type == PACK_HEALTH  ||
		obj[ij].type == PACK_LIFE    ||
		obj[ij].type == PACK_WSINGLE ||
		obj[ij].type == PACK_WTRIO   ||
		obj[ij].type == PACK_WMVTRIO){
	    obj[ij].y-=2;
	    if(is_beep == 1)
		beep();
	}
	if(obj[ij].type == BOSS)
	    /* this should not happen */
	    obj[ij].y-=5;
	else
	    obj[ij].frame=1; /* przestawienie obiektu w faze wybuchu */
	return;
    }

    /* kolizja statku/pocisku wroga z naszym statkiem */
    if(collision(&obj[ij],&ship) && live==1 && lives!=0)
    {
	if(obj[ij].type == ENEMY_MISSILE ||
		obj[ij].type == ENEMY_MISSILE_C ||
		obj[ij].type == BOSS_MISSILE ||
		obj[ij].type == BOSS_MISSILE_C ||
		obj[ij].type == BOSS_MISSILE_L ||
		obj[ij].type == BOSS_MISSILE_R)
	    armour-=10;
	else if(obj[ij].type == ENEMY){
	    armour-=40;
	    if(is_beep == 1)
		beep();
	}
	if(armour<0) {
	    health+=armour;
	    disp_ship(ship.x);
	    armour=0;
	}
	if(health<=0)
	{
	    health=0;
	    armour=0;
	    live=0;
	    lives--;
	    blank_ship();
	    add_object(LINES-10,ship.x,EXPLOSION);
	}
	if(obj[ij].type == PACK_LIFE)
	    lives++;
	if(obj[ij].type == PACK_HEALTH)
	{
	    health+=40;
	    if(health>=100)
		health=100;
	}
	if(obj[ij].type == PACK_ARMOUR)
	{
	    armour+=40;
	    if(armour>=100)
		armour=100;
	}
	if(obj[ij].type == PACK_WSINGLE)
	{
	    weapon = WSINGLE;
	}
	if(obj[ij].type == PACK_WTRIO)
	{
	    weapon = WTRIO;
	}
	if(obj[ij].type == PACK_WMVTRIO)
	{
	    weapon = WMVTRIO;
	}
	subs();
	obj[ij].frame=1; /* przestawienie obiektu w faze wybuchu */
	if(obj[ij].type == PACK_ARMOUR  ||
		obj[ij].type == PACK_HEALTH  ||
		obj[ij].type == PACK_LIFE	|| 
		obj[ij].type == PACK_WSINGLE ||
		obj[ij].type == PACK_WTRIO   ||
		obj[ij].type == PACK_WMVTRIO)
	    obj[ij].y--;
	return;
    }
    if(obj[ij].type==MISSILE ||
	    obj[ij].type==MISSILE_L ||
	    obj[ij].type==MISSILE_R)
    {
	/* usuniecie rakiety */
	if(obj[ij].y==2)
	{
	    missed+=1;
	    subs();
	    obj[ij].frame=6;
	}
	/* sprawdzenie kolizji rakiety z wszystkimi statkami i rakietami wroga */
	for(i=0;i<size;i++)
	{
	    /* jezeli obiekt juz wybucha pomijamy go */
	    if(obj[i].frame>0)
		continue;

	    if(obj[i].type == ENEMY ||
		    obj[i].type == ENEMY_MISSILE ||
		    obj[i].type == ENEMY_MISSILE_C ||
		    obj[i].type == BOSS_MISSILE ||
		    obj[i].type == BOSS_MISSILE_C ||
		    obj[i].type == BOSS_MISSILE_R ||
		    obj[i].type == BOSS_MISSILE_L)
	    {
		if(collision( &obj[i], &obj[ij]) )
		{
		    score+=120;
		    good+=1;
		    subs();
		    blank(i);
		    if(is_beep == 1 && obj[i].type == ENEMY)
			beep();
		    obj[i].frame=1; /* przestawienie obiektu w faze wybuchu */
		    obj[ij].frame=6; /* rakieta do usuniecia */
		}
	    }else
		if(obj[i].type == BOSS)
		{
		    if(adv_collision( &obj[ij], &obj[i]) )
		    {
			score+=5;
			obj[i].energy -= 1;

			if(obj[i].energy <= 0)
			{
			    good++;
			    score+=10000;
			    obj[i].frame=1;
			    boss = 0 ;
			    level++;
			    if(is_beep == 1)
				beep();
			    if(level==levels)
			    {
				hmk[levels-1] = good + 120;
			    }
			}
			subs();
			obj[ij].frame=6;
		    }
		}
	}
    }
}

