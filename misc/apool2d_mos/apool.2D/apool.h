/* This is "apool.h", part of the pool (billiards)-program
                   
                     "ANOTHER POOL".
		     
   "apool.h" includes the constants, prototype and global variables.

   Copyright (C) 1995/2002 by Gerrit Jahn (http://www.planetjahn.de)

   "ANOTHER POOL" is free software; you can redistribute it 
   and/or modify it under the terms of the GNU General Public License 
   as published by the Free Software Foundation; either version 2 of 
   the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with GNU CC; see the file COPYING.  If not, write to
   the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* ------------------------------ apool.h ------------------------------ */

#include <stdlib.h>
#include <stdio.h>

#ifndef M_PI
#define M_PI     3.141592654
#endif

#define VERSION "0.982"
#define DATE "16/10/02"

int SCREENRESX, SCREENRESY, RADIUS;
#define LEFT 20		/* "Tischgrenze" links, rechts, oben, unten  */
#define RIGHT (((int)(SCREENRESX/20))*20-20) /* SCREENRESX-20 */
#define DIFFX (double)(RIGHT-LEFT)	/* "L‰nge u. 2* Breite in Pixeln */
#define UP 70
#define DOWN (UP+DIFFX/2)
#define BALLS 16	/* Anzahl der B‰lle */
#define PIXELRADIUS ((int)RADIUS) /* Radius der Kugeln in Pixel */
#define Radius ((int)RADIUS)
#define ROLL (5.0/7.0)	/* Anteil Transl.- zu Ges.energ. bei vollst. Rollen */
/*#define BANDEN 9 Anz. der "Banden", Zeile weg -> Proc. "unkompiliert" */
#define BLACK 4		/* Nr. der schwarzen Kugel */
#define WHITE (BALLS-1) /* dto. weiﬂ */
#define COL_WHITE 10	/* 'Farbe' der Kugeln */
#define COL_YELLOW 2
#define COL_RED 1
#define COL_BLACK 13
#define TEXTCOL 7
#define NEW_COL_NEW (1<<3)
#define NEW_COL_DOUBLE (1<<5)
#define FOUL_BLACK_ILLEGALY_POCKETED (1<<12)	/* Bits f¸r die Fouls */
#define FOUL_WHITE_POCKETED (1<<11)
#define FOUL_NO_TOUCH (1<<10)
#define FOUL_WRONG_COLOR_POCKETED (1<<9)
#define FOUL_WRONG_COLOR_TOUCHED (1<<8)
#define FOUL_CORRECT_POT (1<<5)
#define FOUL_NO_FOUL 0
#define FOUL_ANY_FOUL ( FOUL_BLACK_ILLEGALY_POCKETED | FOUL_WHITE_POCKETED\
 |FOUL_NO_TOUCH | FOUL_WRONG_COLOR_POCKETED| FOUL_WRONG_COLOR_TOUCHED )
 
 /* Es folgen die "richtigen" Makros: */
 
#define MSG \
 printf("\n\n ANOTHER POOL (V%s) - (c) 1995,2002 by Gerrit Jahn\n\n",VERSION)
#define RND ((int)(2.0*rand()/RAND_MAX+0.5)-1) /* Zuf.zahl zw. 0 u. 1 */
#define XAB (sqrt(4*RADIUS*RADIUS-(RADIUS+1)*(RADIUS+1))+1.5) /* f.Dreieck */
#define MSG2 msg(\
 "l. button: cue, m. button: set spin, r. button: set power, F1: help")
#define SKALP( a,b ) ((a).x*(b).x+(a).y*(b).y)	/* Skalarprodukt */
#define BETR( a ) sqrt( SKALP( a, a ) )		/* Betrag */
#define COS( a ) cos( a* M_PI / 180.0 )		/* cos mit Winkeln in ∞ */
#define COSV( a, b ) (((a.x || a.y)) ?\
 (SKALP( a, b)/(BETR( a ) * BETR( b ))) : 0 )	/* cos aus Skalaprod. */
#define DIFF(a, b) ((a)*(a) + (b)*(b)) /* DIFF, DIFF2: Abst.quadrate */
#define DIFF2(a, b) (((a)*(a) + (b)*(b)) * DIFFX*DIFFX) 
#define SET_V(s, ve) sqrt((2*DELTA*(s)+(ve)*(ve))/ROLL)

/* Definition der benˆtigten Strukturen */

struct vect { double x, y; };
struct ball { struct vect v, e, p; double ez, m; int stat, col, nopaint; }; 
/* v: normale Translationsgeschw.; p: Koordinaten (0<=x<=1, 0<=y<=0.5); 
   e,ez: Effet, Spin; m: Masse          
   stat: "Status" der Kugel; col: Farbe (rot, gelb, schwarz) */ 
struct hole { struct vect p, m; };
/* p: Pos. des Mittelpunktes des Kreises, der das jeweilige Loch darstellt,
   m: Pos. des Punktes auf den der Computer zielen muﬂ, damit er ins 
   Loch trifft, wird bei plot_table() oder so berechnet */
struct player { int stat, wait, points, col, hole_black; double speed;};
/* stat: f¸r Fouls, Treffer, etc.; col: welche Farbe darf angespielt werden;
   speed: letzter Powerfaktor */
struct bande { struct vect p0, p1, n; };
/* p0,p1: Die zwei Punkte, die die Position der Bande festlegen,
   n: 'Normalen-Vektor' der Bande */
struct target { struct vect pos; int kno, ord; struct target *next;
 double spd, angle; struct target *test; };
/* f. computer.c: pos: Position des Punktes, auf den der Computer zielt,
   kno, zugehˆrige Kugel, ord, wieviele Kugeln-1 liegen zwischen Weiﬂer und 
   Loch; angle: unter welchem (Gesamt)-Winkel werden die Kugeln versenkt 
   (wichtig f¸r Auwahl der zu spielenden Kugel). spd: wie fest muﬂ bisher
   gestoﬂen werden, damit die "vorderste" Kugel ins Loch rollt */
struct foul { int wrongct, wrongcp, whited, notouch; };
struct statistic { struct foul fouls; int wins, losses, pots, nopots; }; 
   
/* eigentlich Konstanten, werden es sp‰ter wieder !!!: */
extern double ALPHA, BETA, GAMMA, DELTA, ETA, BANDES, BANDEREF, MASS_WHITE; 
extern double BANDEZ, CURVES, CURVEP;
extern int STEP, CLEV, TIME_STEP;

/* jetzt kommen die globalen Variablen */

extern double oldalph, alph, spd, RADIUSL, e_winkel, old_min;
extern int counter, oldx[BALLS], oldy[BALLS], olds[2];
extern int first_hit, bande_hit, cur, col_in, last_foul, freeball, 
 extra_shot,ende, c_player, anstoss, demo, last_pocketed_balls;
extern int new_col, old_ball, old_hole;
extern struct ball k[BALLS];
extern struct hole posl[6];
extern struct bande ban[18];
extern struct player ply[2];
extern struct statistic stats[2];
extern FILE *datei;

/* functions in apool.c */

void test_for_play_on_black( void );
int test_if_game_is_over( void );
void rules( void );
void init_table( void );
void undo( void );
void save_current_position( void );
void stop_it( void );
void calc_e_winkel( void );
void init_timer( void );
void re_init_timer( void );
#ifdef __MORPHOS__
#define timer FOOBAR_timer
#endif
unsigned long timer( void );

/* functions in graphics.c */

void init_graphics( int x_auflsg, int y_auflsg, int anz_colors);
void msg( char *ausgabestring );
void plot_table( void );
void speed( double geschwindigkeit ); /* 0<= geschw. <= 1 */
void plot_balls( int paintall );
void plot_pockets( void );
void test_spin( int maus_x_pos, int maus_y_pos );
void set_spin( double spin_x, double spin_y , double spin_z);
void wink( double winkel_alpha ); /* 0 <= alpha <= 85∞ */
void plot_one_ball( int which_one );
void err( char *ausgabe_string );
void err2( char *ausgabe_string, int color );
void debug( char *out_string );
void make_mouse_cursor( void );
int menu( void );
void wait_for_click( void );
void close_graphics( void );
void mouse_on( void );
void mouse_off( void );
void plot_cur_player( int current_player );
void set_white_ball( void );
void calc_player_v( void );
void set_player_power( void );
void set_player_spin( void );
void set_test_power( void );
int set_test_power2( void );
void ctrl_break_off( void );
void plot_statistics( double time, int graphics_on_off );
void delete_ball( int ballnr );
void help( void );
void credits( void );
void smile( int stat );

/* functions in physics.c */

void translate_spin( void );
void refl_kk( int kugelnr, struct vect kbande );
void coll( int kugel_a, int kugel_b );
void reflection( int kugelnr, int bandennr );
int in_line( int kugelnr, int bandennr );
void banden_test( void );
int move_balls( void );
void calc_v_end( int no_of_ball );
int move_balls( void );
void stoss( void );
void wait_user_time( double time );

/* functions in computer.c */

int in_line_c( int ball_no_1, int ball_no_2, struct vect point_0, 
struct vect point_1, int color, int graphics_on_off );
struct vect calc_tp( struct vect cur_ball, struct vect target );
void set_c_speed( double end_speed, struct vect speed );
void computer_stoss( void );
int banden_stoss( void );
void calc_hot_spot( void );

/* function in creatabl.c */

void create_table( double width_of_holes_in_pixels );
