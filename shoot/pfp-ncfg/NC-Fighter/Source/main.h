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
 
#include <ncurses.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>

/* NAME:        object
 * DESCRIPTION: Deklaracja struktury przechowuj±cej dane o pocisku/wrogu i innych obiektach (paczki) 
 */
struct object{
    int type; //typ 0 - statek 1 - pocisk
    int x; //pozycja x
    int y; //pozycja y
    int w; //szerokosc
    int h; //wysokosc
    int frame; //0 - zywy 1-5 - fazy wybuchu 6 - martwy
    int time;
    int tols; // time of last shoot
    int ttw;
    int energy; /* energia stworka */
};

/* bedzie trzeba mniej pisac */
#define EN_SIZE sizeof(struct object)

#define ENEMY		    1	//wrog
#define ENEMY_MISSILE	    2	//pocisk wroga
#define ENEMY_MISSILE_C	    3	//pocisk skrecajacy
#define MISSILE		    4	//pocisk
#define MISSILE_L	    5	//pocisk lewy
#define MISSILE_R	    6	//pocisk prawy
#define BOSS		    7	//Boss
#define BOSS_MISSILE	    8	//pocisk bossa
#define BOSS_MISSILE_C	    9	//pocisk bossa skrecajacy
#define BOSS_MISSILE_L	    10	//pocisk bossa lewy
#define BOSS_MISSILE_R	    11	//pocisk bossa prawy
#define EXPLOSION	    12	//wybuch
#define SHIP		    13  //statek
#define EDGE		    14  //granica
#define WSINGLE		    15	//typ broni: pojedynczy strzal    
#define WTRIO		    16  //typ broni: potrojny strzal
#define WMVTRIO		    17  //typ broni: potrojny zmiennopozycyjny strzal
#define PACK_WSINGLE	    18  //typ paczki: daje WSINGLE
#define PACK_WTRIO	    19  //typ paczki: daje WTRIO
#define PACK_WMVTRIO	    20  //typ paczki: daje WMVTRIO
#define PACK_ARMOUR         21   //paczka pancerz
#define PACK_HEALTH         22   //paczka zdrowie
#define PACK_LIFE           23   //paczka statek


//WEAPON SINGLE | WEAPON TRIO | WEAPON SHAKING TRIO

WINDOW *tail;
WINDOW *view;
WINDOW *head;

void subs();
void message(WINDOW *win,char *text);
int get_msecs();
int rand_ab(int a, int b);
void disp_strings(WINDOW *win,char *tit, int p);
void clear_win(WINDOW *win);
void redraw_border(WINDOW *win);
void boom(int row, int col, int frame);
void check_edges(int ij);
void check_is_alive(int i);
void game();
void del_obj(int which, int size);
void disp_ship(int x);
void disp_missile(int x,int y);
void disp_boss(int x,int y);
void disp_enemy(int x,int y);
void add_object(int y,int x, int typ);
void draw_obj(int ij);
void blank(int i);
void blank_ship();
int collision(struct object *obj_a, struct object *obj_b );
