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

char boss_mask_1[7][27] ={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {0,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,0},
    {0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,1,1,1,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0}};

extern int armour,
    missed,
    size,
    score,
    good,
    live,
    health,
    lives,
    weapon;

extern struct object obj[384];
extern struct object ship;

/* NAME:	del_obj
 * DESCRIPTION: Usuwa obiekt
 */
void del_obj(int which, int size)
{
    /* EN_SIZE to rozmiar pojedynczej struktury */
    memmove( obj+which, obj+which+1, (size-which-1)*EN_SIZE );
}

/* NAME:	disp_ship
 * DESCRIPTION:	Wy¶wietla statek którym kieruje gracz podczas gry
 */
void disp_ship(int x)
{
    wattrset(view,COLOR_PAIR(5));
    mvwaddstr ( view , LINES-8,x, "-/A\\-" );
    mvwaddstr ( view , LINES-7,x, "{|O|}"  );
    mvwaddstr ( view , LINES-6, x, "/-|-\\" );
    wattrset(view,COLOR_PAIR(0));
}

/* NAME:	disp_boss
 * DESCRIPTION:	BOSS
 */
void disp_boss(int x, int y)
{
    wattrset(view,COLOR_PAIR(1));
    mvwaddstr ( view , y,x,  "\\/\\U/\\/*\\/U-\\U/-U\\/*\\/\\U/\\/");
    mvwaddstr ( view , y+1,x, "|Y   Y|O {^:HTH:^} O|Y   Y|");
    mvwaddstr ( view , y+2,x, "T  Q  T-<|^:HTH:^|>-T  Q  T");
    mvwaddstr ( view , y+3,x+1,"\\ I /   T\\HHYHH/T   \\ I /");
    mvwaddstr ( view , y+4,x+2, "\\I/      \\UIU/      \\I/");
    mvwaddstr ( view , y+5,x+11,"< I >");
    mvwaddstr ( view , y+6,x+12,"\\V/");
    wattrset(view,COLOR_PAIR(0));
}

/* NAME:	disp_missile
* DESCRIPTION:	Wy¶wietla pocisk
    */
void disp_missile(int x,int y)
{
    mvwaddstr ( view , y , x , "*"  );
    wattrset(view,COLOR_PAIR(0));
}

/* NAME:	disp_enemy
 * DESCRIPTION:	Wy¶wietla wrogi statek
 */
void disp_enemy(int x,int y)
{
    wattrset(view,COLOR_PAIR(1));
    mvwaddstr(view,y,x+1,"\\+/");
    mvwaddstr(view,y+1,x,"{|T|}");
    mvwaddstr(view,y+2,x+1,"\\O/");
    wattrset(view,COLOR_PAIR(0));
}

/* NAME:	disp_pack
 * DESCRIPTION:	Wyswietla paczke
 */
void disp_pack(int y , int x , int type)
{
    switch(type)
    {
	case PACK_ARMOUR:
	    wattrset(view,COLOR_PAIR(rand_ab(3,5)));
	    mvwprintw(view,y,x,"*A*");
	    wattrset(view,COLOR_PAIR(0));
	    break;
	case PACK_HEALTH:
	    wattrset(view,COLOR_PAIR(rand_ab(3,5)));
	    mvwprintw(view,y,x,"*H*");
	    wattrset(view,COLOR_PAIR(0));
	    break;
	case PACK_LIFE:
	    wattrset(view,COLOR_PAIR(rand_ab(3,5)));
	    mvwprintw(view,y,x,"*S*");
	    wattrset(view,COLOR_PAIR(0));
	    break;
	case PACK_WMVTRIO:
	    wattrset(view,COLOR_PAIR(3));
	    mvwprintw(view,y,x,"*W*");
	    wattrset(view,COLOR_PAIR(0));
	    break;
	case PACK_WTRIO:
	    wattrset(view,COLOR_PAIR(4));
	    mvwprintw(view,y,x,"*W*");
	    wattrset(view,COLOR_PAIR(0));
	    break;
	case PACK_WSINGLE:
	    wattrset(view,COLOR_PAIR(5));
	    mvwprintw(view,y,x,"*W*");
	    wattrset(view,COLOR_PAIR(0));
	    break;
	default:
	    break;
    }
}

/* NAME:	add_object
 * DESCRIPTION:	Dodaje obiekt, wy¶wietlaj±c go na ekranie gry
 */
void add_object(int y,int x, int typ)
{
    if(typ == ENEMY)
    {
	size++;
	obj[size-1].type = typ;
	obj[size-1].x = rand_ab(2,COLS-28);
	obj[size-1].y = 3;
	obj[size-1].w = 5;
	obj[size-1].h = 3;
	obj[size-1].frame = 0;
	obj[size-1].time = get_msecs();    
	obj[size-1].tols = get_msecs();
	obj[size-1].ttw = rand_ab(90,190);
	draw_obj(size-1);
    } else
	if(typ == MISSILE || typ == MISSILE_L || typ == MISSILE_R)
	{
	    size++;
	    obj[size-1].type = typ;
	    obj[size-1].x = x;
	    obj[size-1].y = y;
	    obj[size-1].w = 1;
	    obj[size-1].h = 1;
	    obj[size-1].frame = 0;
	    obj[size-1].time = get_msecs();
	    obj[size-1].ttw = 20;
	    draw_obj(size-1);
	} else
	    if(typ == ENEMY_MISSILE ||
		    typ == ENEMY_MISSILE_C ||
		    typ == BOSS_MISSILE    ||
		    typ == BOSS_MISSILE_C  ||
		    typ == BOSS_MISSILE_L  ||
		    typ == BOSS_MISSILE_R)
	    {
		size++;
		obj[size-1].type = typ;
		obj[size-1].x = x;
		obj[size-1].y = y;
		obj[size-1].w = 1;
		obj[size-1].h = 1;
		obj[size-1].frame = 0;
		obj[size-1].time = get_msecs();
		obj[size-1].ttw = rand_ab(75,100);
		draw_obj(size-1);
	    }else
		if(typ == EXPLOSION)
		{
		    size++;
		    obj[size-1].type = typ;
		    obj[size-1].x = x;
		    obj[size-1].y = y;
		    obj[size-1].w = 5;
		    obj[size-1].h = 5;
		    obj[size-1].frame = 1;
		    draw_obj(size-1);
		}
		else 
		    if(typ == PACK_ARMOUR  ||
			    typ == PACK_HEALTH  ||
			    typ == PACK_LIFE    ||
			    typ == PACK_WSINGLE ||
			    typ == PACK_WTRIO   ||
			    typ == PACK_WMVTRIO)
		    {
			size++;
			obj[size-1].type = typ;
			obj[size-1].x = x;
			obj[size-1].y = y;
			obj[size-1].w = 3;
			obj[size-1].h = 1;
			obj[size-1].frame = 0;
			obj[size-1].time = get_msecs();
			obj[size-1].ttw = rand_ab(120,250);
			draw_obj(size-1);
		    } else 
			if(typ == BOSS)
			{
			    size++;
			    obj[size-1].type = typ;
			    obj[size-1].x = x;
			    obj[size-1].y = y;
			    obj[size-1].w = 27;
			    obj[size-1].h = 7;
			    obj[size-1].frame = 0;
			    obj[size-1].time = get_msecs();
			    obj[size-1].ttw = rand_ab(80,150);
			    obj[size-1].tols = get_msecs();
			    obj[size-1].energy = 300;
			    draw_obj(size-1);

			}

}

/* NAME:	draw_obj
 * DESCRIPTION:	Rysuje obiekt
 */
void draw_obj(int ij)
{
    if(obj[ij].type == ENEMY)
    {
	if(obj[ij].frame == 0) {
	    disp_enemy(obj[ij].x,obj[ij].y);
	} else {

	    /* wyswietlenie odpowiedniej klatki wybuchu */
	    boom(obj[ij].y+(obj[ij].h-1)/2,obj[ij].x+(obj[ij].w-1)/2,obj[ij].frame);
	    if(collision(&obj[ij],&ship) && health!=0 && live == 1 && lives!=0 && obj[ij].frame == 6)
		disp_ship(ship.x);
	}
    }else
	if(obj[ij].type == MISSILE ||
		obj[ij].type == MISSILE_L ||
		obj[ij].type == MISSILE_R )
	{
	    if(obj[ij].frame==0)
	    {
		if(weapon == WSINGLE)
		    wattrset(view,COLOR_PAIR(5));
		if(weapon == WTRIO)
		    wattrset(view,COLOR_PAIR(4));
		if(weapon == WMVTRIO)
		    wattrset(view,COLOR_PAIR(3));
		disp_missile(obj[ij].x,obj[ij].y);
	    }
	}
	else 
	    if(obj[ij].type == ENEMY_MISSILE ||
		    obj[ij].type == ENEMY_MISSILE_C ||
		    obj[ij].type == BOSS_MISSILE ||
		    obj[ij].type == BOSS_MISSILE_L ||
		    obj[ij].type == BOSS_MISSILE_R || 
		    obj[ij].type == BOSS_MISSILE_C)
	    {
		if(obj[ij].frame == 0)
		{
		    wattrset(view,COLOR_PAIR(1));
		    disp_missile(obj[ij].x,obj[ij].y);
		}
		if(collision(&obj[ij],&ship) && health!=0 && live == 1 && lives!=0 && obj[ij].frame == 6)
		    disp_ship(ship.x);
	    }
	    else
		if(obj[ij].type == PACK_ARMOUR  ||
			obj[ij].type == PACK_HEALTH ||
			obj[ij].type == PACK_LIFE ||
			obj[ij].type == PACK_WSINGLE ||
			obj[ij].type == PACK_WTRIO ||
			obj[ij].type == PACK_WMVTRIO)
		{
		    if(obj[ij].frame == 0)
		    {
			disp_pack(obj[ij].y,obj[ij].x,obj[ij].type);
		    }
		    else
		    {

			boom(obj[ij].y+(obj[ij].h-1)/2,obj[ij].x+(obj[ij].w-1)/2,obj[ij].frame);
			if(health!=0 && live == 1 && lives!=0 && obj[ij].frame == 6)
			    disp_ship(ship.x);
		    } 

		} 
		else
		    if(obj[ij].type == EXPLOSION)
		    {
			boom(obj[ij].y+(obj[ij].h-1)/2,obj[ij].x+(obj[ij].w-1)/2,obj[ij].frame);
		    }
		    else 
			if(obj[ij].type == BOSS)
			{
			    if(obj[ij].frame==0)
				disp_boss(obj[ij].x, obj[ij].y);
			    else
			    {
				boom(obj[ij].y+obj[ij].h/2-2,obj[ij].x+obj[ij].w/2-2,obj[ij].frame);
				boom(obj[ij].y+obj[ij].h/2,obj[ij].x+obj[ij].w/2,obj[ij].frame);
				boom(obj[ij].y+obj[ij].h/2,obj[ij].x+obj[ij].w/2-6,obj[ij].frame);
				boom(obj[ij].y+obj[ij].h/2,obj[ij].x+obj[ij].w/2-8,obj[ij].frame);
				boom(obj[ij].y+obj[ij].h/2,obj[ij].x+obj[ij].w/2-12,obj[ij].frame);
				boom(obj[ij].y+obj[ij].h/2,obj[ij].x+obj[ij].w/2+4,obj[ij].frame);
				boom(obj[ij].y+obj[ij].h/2+2,obj[ij].x+obj[ij].w/2-4,obj[ij].frame);
			    }
			}
}

/* NAME:	blank
 * DESCRIPTION:	Sprawdza typ obiektu, odpowiednio go zamazuje
 */
void blank(int i)
{
    switch(obj[i].type)
    {
	case ENEMY:
	    mvwaddstr(view, obj[i].y, obj[i].x+1,  "   ");
	    mvwaddstr(view, obj[i].y+1, obj[i].x    , "     ");
	    mvwaddstr(view, obj[i].y+2, obj[i].x+1 , "   ");
	    break;
	case MISSILE:
	case ENEMY_MISSILE:
	case ENEMY_MISSILE_C:
	case MISSILE_L:
	case MISSILE_R:
	case BOSS_MISSILE:
	case BOSS_MISSILE_C:
	case BOSS_MISSILE_R:
	case BOSS_MISSILE_L:	
	    mvwaddstr(view,obj[i].y, obj[i].x, " ");
	    break;
	case PACK_ARMOUR:
	case PACK_LIFE:
	case PACK_HEALTH:
	case PACK_WSINGLE:
	case PACK_WTRIO:
	case PACK_WMVTRIO:
	    mvwaddstr(view,obj[i].y, obj[i].x, "   ");
	    break;
	case BOSS:
	    mvwaddstr ( view , obj[i].y  ,obj[i].x   ,  "                           ");
	    mvwaddstr ( view , obj[i].y+1,obj[i].x   ,  "                           ");
	    mvwaddstr ( view , obj[i].y+2,obj[i].x   ,  "                           ");
	    mvwaddstr ( view , obj[i].y+3,obj[i].x+1 ,   "                         ");
	    mvwaddstr ( view , obj[i].y+4,obj[i].x+2 ,    "                       ");
	    mvwaddstr ( view , obj[i].y+5,obj[i].x+11,             "     ");
	    mvwaddstr ( view , obj[i].y+6,obj[i].x+12,              "   ");
	    break;
    }
}

/* NAME:	blank_ship
 * DESCRIPTION:	Czysci statek
 */
void blank_ship()
{
    mvwaddstr(view,LINES-8,ship.x ,"     ");
    mvwaddstr(view,LINES-7,ship.x ,"     ");
    mvwaddstr(view,LINES-6 ,ship.x,"     ");
}

