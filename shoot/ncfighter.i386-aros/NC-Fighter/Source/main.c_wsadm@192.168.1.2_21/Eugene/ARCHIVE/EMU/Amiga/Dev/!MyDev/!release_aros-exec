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

#define false 0
#define true 1

#include "main.h"
int size=0,pauza=0,boss=0, is_beep;
int live=1, armour = 50, health = 100, lives = 2,level=1, levels=2;
int score=0,shoots=0,missed=0, good=0, weapon = WSINGLE;

char *strings[] = {" NCurses Fighter by Radoslaw Gniazdowski "," Information ","LEFT, RIGHT, SPACE shot, p pause, q exit"};

int hmk[] = {50,0};

/* definicje zmiennych */
struct object obj[384];
struct object eleft =   { EDGE, 0, 0, 0, 0, 0, 0, 0, 0 };
struct object ebottom = { EDGE, 0, 0, 0, 0, 0, 0, 0, 0 }; /* type, x,y,w,h,frame,time,tols,ttw*/
struct object eright =  { EDGE, 0, 0, 0, 0, 0, 0, 0, 0 };
struct object ship =    { SHIP, 0, 0, 0, 0, 0, 0, 0, 0 };

/* NAME:	subs
 * DESCRIPTION:	Wy¶wietla punktacje liczbê wystrzelonych strza³ów, trafnych, chybionych
 */
void subs()
{
    mvwprintw(view,1,1,"Armour: %*d%% Health: %*d%% Ships: %*d Level: %*d/%*d ",3,armour,3,health,2,lives,2,level,1,levels);
    
    if(shoots!=0)
	mvwprintw(tail,2,1,"Score: %*d fires: %*d hits: %*d missed: %*d precision: %*.0f%% ",1,score,1,shoots,1,good,1,missed,2,((double) good)/((double) shoots)*100.0);
    else
	mvwprintw(tail,2,1,"Score: %d fires: %d hits: %d missed: %d ",score,shoots,good,missed);    
}
/* NAME:	message
 * DESCRIPTION:	Wy¶wietla komunikat, w wybranym oknie
 */
void message(WINDOW *win,char *text)
{
    mvwprintw(win,1,1,"%s",text);
    wrefresh(win);
}
/* NAME:	get_msecs
 * DESCRIPTION:	Pobiera czas dnia
 */
int get_msecs()
{
    struct timeval tv;
    struct timezone tz;

    gettimeofday( &tv, &tz );

    return tv.tv_sec*1000 + tv.tv_usec / 1000;
}
/* NAME:	rand_ab
 * DESCRIPTION:	Losuje liczby z przedzia³u od 'a' do 'b'
 */
int rand_ab(int a, int b)
{
    return a + (int) ( ((double)(b-a+1))*rand()/(RAND_MAX+1.0));
}
/* NAME:	disp_strings
 * DESCRIPTION:	Wy¶wietla tytu³, na ¶rodku górnego obramowania, podanego okna
 */
void disp_strings(WINDOW *win,char *tit, int p)
{
    mvwaddstr(win,0,p/2-strlen(tit)/2,tit);
    wrefresh(win);
}
/* NAME:	clear_win
 * DESCRIPTION:	Czy¶ci zawarto¶æ podanego okna, rysuj±c odnowa obramowanie okna i wszystkie tytu³y okien
 */
void clear_win(WINDOW *win)
{
    werase(win);
    box(win,0,0);
    disp_strings(view,strings[0],COLS-22);
    disp_strings(tail,strings[1],COLS);    
    message(tail,strings[2]);
    disp_ship(ship.x);
}
/* NAME:	redraw_border
 * DESCRIPTION:	rysuje obramowanie
 */
void redraw_border(WINDOW *win)
{
    box(win,0,0);
    disp_strings(view,strings[0],COLS-22);
    disp_strings(tail,strings[1],COLS);
    message(tail,strings[2]);
    wrefresh(win);
}
/* NAME:	boom
 * DESCRIPTION:	Wy¶wietla wybuch
 */
void boom(int row, int col, int frame)
{
    wattrset(view,COLOR_PAIR(1));
    switch(frame)
    {
	case 1:
	    mvwprintw(view,row - 1, col - 1, " - ");
	    mvwprintw(view,row + 0, col - 1, "-+-");
	    mvwprintw(view,row + 1, col - 1, " - ");
	    break;
	case 2:
	    mvwprintw(view,row - 2, col - 2, " --- ");
	    mvwprintw(view,row - 1, col - 2, "-+++-");
	    mvwprintw(view,row + 0, col - 2, "-+#+-");
	    mvwprintw(view,row + 1, col - 2, "-+++-");
	    mvwprintw(view,row + 2, col - 2, " --- ");
	    break;
	case 3:
	    wattrset(view,COLOR_PAIR(2));
	    mvwprintw(view,row - 2, col - 2, " +++ ");
	    mvwprintw(view,row - 1, col - 2, "++#++");
	    mvwprintw(view,row + 0, col - 2, "+# #+");
	    mvwprintw(view,row + 1, col - 2, "++#++");
	    mvwprintw(view,row + 2, col - 2, " +++ ");
	    break;
	case 4:
	    mvwprintw(view,row - 2, col - 2, "  #  ");
	    mvwprintw(view,row - 1, col - 2, "## ##");
	    mvwprintw(view,row + 0, col - 2, "#   #");
	    mvwprintw(view,row + 1, col - 2, "## ##");
	    mvwprintw(view,row + 2, col - 2, "  #  ");
	    break;
	case 5:
	    mvwprintw(view,row - 2, col - 2, " # # ");
	    mvwprintw(view,row - 1, col - 2, "#   #");
	    mvwprintw(view,row + 0, col - 2, "     ");
	    mvwprintw(view,row + 1, col - 2, "#   #");
	    mvwprintw(view,row + 2, col - 2, " # # ");
	    break;
	case 6:
	    mvwprintw(view,row - 2, col - 2, "     ");
	    mvwprintw(view,row - 1, col - 2, "     ");
	    mvwprintw(view,row + 0, col - 2, "     ");
	    mvwprintw(view,row + 1, col - 2, "     ");
	    mvwprintw(view,row + 2, col - 2, "     ");
	    break;
    };
    wattrset(view,COLOR_PAIR(0));
}
/* NAME:	check_is_alive
 * DESCRIPTION:	Sprawdza czy obiekt jest ¿ywy
 */
void check_is_alive(int i)
{
    obj[i].time = get_msecs();

    if(obj[i].frame>=6)
    {
	if(obj[i].type == BOSS)
	    redraw_border(view);
	del_obj(i,size);
	size--;
    }
}
/* NAME:	game
 * DESCRIPTION:	Pobiera klawisze i o¿ywia ca³± grê
 */
void game()
{
    int key, i, delta, tmp, zostalo, tmp2;
    int exit=0;
    char *end = "You killed it, it's a miracle!!!";
    tmp = get_msecs();
    tmp2 = get_msecs();
    subs();
    while(1)
    {
	key = wgetch(view);
	switch(key)
	{
	    case KEY_LEFT:
		if(live==1 && pauza==0)
		{
		    blank_ship();
		    ship.x-=2;
		    if(ship.x<1)
			ship.x=1;
		    disp_ship(ship.x);
		}
		if(live==0 && lives!=0){
		    live=1;
		    health=100;
		    armour=25;
		    subs();
		    disp_ship(ship.x);
		}
		break;
	    case KEY_RIGHT : 
		if(live==1 && pauza==0)
		{
		    blank_ship();
		    ship.x+=2;
		    if(ship.x>COLS-28)
		    {
			ship.x=COLS-28;
		    }
		    disp_ship(ship.x);
		}
		if(live==0 && lives!=0){
		    live=1;
		    health=100;
		    armour=25;
		    subs();
		    disp_ship(ship.x);
		}
		break;
	    case ' ': 
		if(live==1 && pauza==0)
		{
		    if(weapon == WSINGLE || weapon == WTRIO || weapon == WMVTRIO)
		    {
			shoots++;
			add_object(LINES-9,ship.x+2,MISSILE);
			if(weapon == WTRIO || weapon == WMVTRIO)
			{
			    shoots+=2;
			    add_object(LINES-9,ship.x+2,MISSILE_L);
			    add_object(LINES-9,ship.x+2,MISSILE_R);
			}
		    }
		    subs();
		}
		if(live==0 && lives!=0){
		    live=1;
		    health=100;
		    armour=25;
		    subs();
		    disp_ship(ship.x);
		}
		break;
	    case 'p': case 'P':
		pauza++;
		if(pauza==1) {
		    zostalo = 1200 - (get_msecs() - tmp);
		}
		if(pauza>1)
		{
		    tmp = get_msecs() - 1200 + zostalo;
		    pauza=0;	    
		}
		break;
	    case 'q': case 'Q':
		exit=1;
		break;
	    default:
		break;
	};

	if(exit==1)
	    break;

	if(armour<=0)
	    armour=0;

	if(pauza==0)
	{
	    if(get_msecs() - tmp>=1200 && boss == 0){
		add_object(false,false, ENEMY);
		tmp = get_msecs();
	    }
	    if(good == hmk[level-1] && boss == 0)
	    {
		boss = 1;
		add_object(4,rand_ab(2,COLS-23-27),BOSS);
	    }
	    if(level==levels+1 )
	    {
		level=levels;
		subs();
		mvwprintw(view,LINES/2-6,(COLS-22)/2-strlen(end)/2, "%s", end );
		wrefresh(view);
		sleep(2);
		mvwprintw(view,LINES/2-5,(COLS-22)/2-strlen(end)/2, "You win %s", getlogin() );
		wrefresh(view);
		sleep(5);
		break;
	    }
	    if(lives<=0 && health<=0 && armour<=0 )
	    {
		subs();
		mvwprintw(view,LINES/2-6,(COLS-22)/2-24/2, "Loser loser!!! Hahahaha!");
		wrefresh(view);
		sleep(2);
		mvwprintw(view,LINES/2-5,(COLS-22)/2-24/2, "You are dead %s", getlogin() );
		wrefresh(view);
		sleep(5);
		break;
	    }
	    if(get_msecs() - tmp2>=3500)
	    {
		switch(rand_ab(17,24))
		{
		    case PACK_WSINGLE:
			add_object(3,rand_ab(4, COLS-30), PACK_WSINGLE);
			break;
		    case PACK_WTRIO:
			add_object(3,rand_ab(4, COLS-30), PACK_WTRIO);
			break;
		    case PACK_WMVTRIO:
			add_object(3,rand_ab(4, COLS-30), PACK_WMVTRIO);
			break;
		    case PACK_ARMOUR:
			add_object(3,rand_ab(4, COLS-30), PACK_ARMOUR);	
			break;
		    case PACK_HEALTH:
			add_object(3,rand_ab(4, COLS-30), PACK_HEALTH);	
			break;
		    case PACK_LIFE:
			add_object(3,rand_ab(4, COLS-30), PACK_LIFE);
			break;
		    default:
			break;
		}
		tmp2 = get_msecs();
	    }

	    for(i=0;i<size;i++)
	    {
		delta = obj[i].frame==0 ? obj[i].ttw : 60;

		if(get_msecs()-obj[i].time>=delta)
		{
		    if(get_msecs()-obj[i].tols>=200 && obj[i].y < LINES-10 && obj[i].type == ENEMY )
		    {
			switch(rand_ab(0,4))
			{
			    case 0:
				wattrset(view,COLOR_PAIR(2));
				add_object(obj[i].y+4,obj[i].x+obj[i].w/2,ENEMY_MISSILE);
				break;
			    case 4:
				wattrset(view,COLOR_PAIR(2));
				add_object(obj[i].y+4,obj[i].x+obj[i].w/2,ENEMY_MISSILE_C);
				break;
			    default:
				break;
			};
			obj[i].tols=get_msecs();
		    }

		    if(get_msecs()-obj[i].tols>=15 && obj[i].type == BOSS && boss == 1)
		    {

			switch(rand_ab(0,4))
			{
			    case 0://prawy
				add_object(obj[i].y+obj[i].h-4, obj[i].x+obj[i].w-1,BOSS_MISSILE_C);
				break;
			    case 1: //lewy
				add_object(obj[i].y+obj[i].h-4, obj[i].x,BOSS_MISSILE_C);
				break;
			    case 2://obok prawego
				add_object(obj[i].y+obj[i].h-4, obj[i].x+obj[i].w-7,BOSS_MISSILE);
				add_object(obj[i].y+obj[i].h-4, obj[i].x+obj[i].w-7,BOSS_MISSILE_R);
				add_object(obj[i].y+obj[i].h-4, obj[i].x+obj[i].w-7,BOSS_MISSILE_L);
				break;
			    case 3: //obok lewego
				add_object(obj[i].y+obj[i].h-4, obj[i].x+6,BOSS_MISSILE);
				add_object(obj[i].y+obj[i].h-4, obj[i].x+6,BOSS_MISSILE_R);
				add_object(obj[i].y+obj[i].h-4, obj[i].x+6,BOSS_MISSILE_L);
				break;
			    case 4: // lewy
				add_object(obj[i].y+obj[i].h-4, obj[i].x,BOSS_MISSILE);	
				break;
			    default:
				break;
			}
			add_object(obj[i].y+obj[i].h, obj[i].x+obj[i].w-1-13,BOSS_MISSILE_C);
			add_object(obj[i].y+obj[i].h, obj[i].x+obj[i].w-1-13,BOSS_MISSILE_R);
			add_object(obj[i].y+obj[i].h, obj[i].x+obj[i].w-1-13,BOSS_MISSILE_L);
		    }

		    blank(i);
		    if(obj[i].frame==0)
		    {
			switch(obj[i].type)
			{
			    case MISSILE:
				obj[i].y--;
				if(weapon == WMVTRIO)
				{
				    switch(rand_ab(0,5))
				    {
					case 0:
					    obj[i].x++;
					    break;
					case 5:
					    obj[i].x--;
					    break;
					default:
					    break;
				    }
				}
				break;
			    case MISSILE_L:
				obj[i].y--;
				if(weapon == WMVTRIO)
				    obj[i].x-=rand_ab(0,1);
				else
				    obj[i].x--;
				break;
			    case MISSILE_R:
				obj[i].y--;
				if(weapon == WMVTRIO)
				    obj[i].x+=rand_ab(0,1);
				else
				    obj[i].x++;
				break;
			    case BOSS_MISSILE_R:
				obj[i].y++;
				obj[i].x+=rand_ab(0,1);
				break;
			    case BOSS_MISSILE_L:
				obj[i].y++;
				obj[i].x-=rand_ab(0,1);
				break;
			    case PACK_ARMOUR:
			    case PACK_HEALTH:
			    case PACK_LIFE:
			    case PACK_WSINGLE:
			    case PACK_WTRIO:
			    case PACK_WMVTRIO:
			    case ENEMY:
			    case ENEMY_MISSILE: 
			    case ENEMY_MISSILE_C:			
			    case BOSS_MISSILE:
			    case BOSS_MISSILE_C:
				obj[i].y++;
				break;
			    case BOSS:

				switch(rand_ab(0,1))
				{
				    case 0:
					obj[i].x+=rand_ab(1,2);
					break;
				    case 1:
					obj[i].x-=rand_ab(1,2);
					break;
				}
				switch(rand_ab(0,1))
				{
				    case 0:
					if(obj[i].y<LINES-12-obj[i].h)
					    obj[i].y++;
					break;
				    case 1:
					if(obj[i].y>3)
					    obj[i].y--;
					break;
				}
				if(obj[i].x+obj[i].w/2-2<ship.x)
				    obj[i].x++;
				else if(obj[i].x+obj[i].w/2>ship.x)
				    obj[i].x--;
				break;
			    default:
				break;
			}	
			/* ustalenie x */
			if(obj[i].type == ENEMY ||
				obj[i].type == ENEMY_MISSILE_C ||
				obj[i].type == BOSS_MISSILE_C)
			{

			    switch(rand_ab(0,6)){
				case 0:
				    obj[i].x += 1;
				    break;
				case 6:
				    obj[i].x -= 1;
				    break;
				default:
				    break;
			    };
			}
		    }
		    check_edges(i);
		    draw_obj(i);
		    check_is_alive(i);  /* zmienia time, jezeli frame>=6 usuwa */
		}
	    }
	    wrefresh(view);		  
	    wrefresh(tail); 
	}	
    }
}
/* NAME:	main
 * DESCRIPTION:	Funkcja g³ówna
 */
int main(int argc, char *argv[])
{
    int i, color;
    char *com;

    color = 1;
    is_beep = 1;

    for (i = 1; i < argc; i++) {
	com = argv[i];
	if (*com == '-')
	    if(com[2]!='\0')
	    {
		printf("Bad option %s\n",argv[i]);
		printf("Options:\n\t-q\tQuiet-mode, no beeps\n\t-n\tNo color\n");
		return 0;
	    }
	com++;
	switch (*com) {
	    case 'q':
		is_beep = 0;
		break;
	    case 'n':
		color = 0;
		break;
	    default:
		printf("Bad option %s\n",argv[i]);
		printf("Options:\n\t-q\tQuiet-mode, no beeps\n\t-n\tNo color\n");		
		return 0;
		break;
	}
    }
    /* ustawia LINES i COLS */
    initscr();

    /* inicjacja granic */
    /* type, x,y,w,h,frame,time,tols,ttw*/

    eleft.w = 1;
    eleft.h = LINES;

    ebottom.y = LINES-6;
    ebottom.w = COLS-22;
    ebottom.h = 1;

    eright.x = COLS-23;    
    eright.y = 0;
    eright.w = 1;
    eright.h = LINES;

    ship.x = COLS/2-12;
    ship.y = LINES-7;
    ship.w = 5;
    ship.h = 3;

    if(color == 1)
	start_color();

    init_pair(0,COLOR_WHITE,COLOR_BLACK);
    init_pair(1,COLOR_YELLOW,COLOR_BLACK); 
    init_pair(2,COLOR_RED,COLOR_BLACK);
    init_pair(3,COLOR_CYAN,COLOR_BLUE);
    init_pair(4,COLOR_MAGENTA,COLOR_BLUE);
    init_pair(5,COLOR_GREEN,COLOR_BLACK);

    noecho();
    curs_set(0); 
    cbreak();

    srand(time(NULL));

    view = newwin(LINES-4,COLS-22,0,11);
    clear_win(view);

    meta(view, true);
    nodelay(view,true);
    keypad(view, true);

    tail = newwin(4,COLS,LINES-4,0);
    clear_win(tail);
    disp_ship(ship.x);
    game();
    endwin();
    system("clear");
    printf("Options:\n\t-q\tQuiet-mode, no beeps\n\t-n\tNo color\n");
    return 0;
}

