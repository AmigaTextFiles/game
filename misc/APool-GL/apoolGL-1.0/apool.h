/* This is "apool.h", part of the pool (billiards)-program
                   
                     "Another Pool GL".
		     
   "apool.h" includes the constants, prototype and global variables.

 	 This file ist part of Another Pool / Another Pool GL (apool, apoolGL)

   Copyright (C) 1995/2002,2003,2013 by Gerrit Jahn (http://www.planetjahn.de)

   "Another Pool" is free software; you can redistribute it 
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

#define SPEED_FACTOR 1.0

#define VERSION "1.0"
#define DATE "2013/11/08"

#define LEFT 20		/* "Tischgrenze" links, rechts, oben, unten  */
#define RIGHT (((int)(1024/20))*20-20) /* SCREENRESX-20 */
#define DIFFX (double)(RIGHT-LEFT)	/* "L‰nge u. 2* Breite in Pixeln */
#define UP 70
#define DOWN (UP+DIFFX/2)
#define BALLS 16	/* Anzahl der B‰lle */
#define PIXELRADIUS 12.78 /* Radius der Kugeln in Pixel */
#define RADIUS (PIXELRADIUS/(double)DIFFX) /*Radius d. Kugeln in "Einheiten"*/
#define ROLL (5.0/7.0)	/* Anteil Transl.- zu Ges.energ. bei vollst. Rollen */
#define BLACK 4		/* Nr. der schwarzen Kugel */
#define WHITE (BALLS-1) /* dto. weiﬂ */
#define COL_WHITE 10	/* 'Farbe' der Kugeln, historisch bedingt ;-) */
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

int SCREENRESX, SCREENRESY;
 
 /* Es folgen die "richtigen" Makros: */
 
#define MSG \
 printf("\n\n ANOTHER POOL GL (V%s) - (c) 1995-2013 by Gerrit Jahn\n",\
 VERSION);\
 printf("  http://www.planetjahn.de/apool\n\n")
#define RND ((int)(2.0*rand()/RAND_MAX+0.5)-1) /* Zuf.zahl zw. 0 u. 1 */
#define XAB (sqrt(4*PIXELRADIUS*PIXELRADIUS-(PIXELRADIUS+1)*(PIXELRADIUS+1))+1.5) /* f.Dreieck */
#define MSG2 msg(\
 "l. button: cue, m. button: set spin, r. button: set power, F1: help")
#define SKALP( a,b ) ((a).x*(b).x+(a).y*(b).y)	/* Skalarprodukt */
#define SKALP3( a,b ) ((a).x*(b).x+(a).y*(b).y+(a).z*(b).z)	/* Skalarprodukt */
#define BETR( a ) sqrt( SKALP( a, a ) )		/* Betrag */
#define BETR3( a ) sqrt( SKALP3( a, a ) )		/* Betrag */
#define COS( a ) cos( (a) * M_PI / 180.0 )		/* cos mit Winkeln in ∞ */
#define SIN( a ) sin( (a) * M_PI / 180.0 )		/* cos mit Winkeln in ∞ */
#define COSV( a, b ) (((a.x || a.y) && (b.x || b.y)) ?\
 (SKALP( a, b)/(BETR( a ) * BETR( b ))) : 0 )	/* cos aus Skalaprod. */
#define COSV3( a, b ) (((a.x || a.y || a.z) && (b.x || b.y || b.z)) ?\
 (SKALP3( a, b)/(BETR3( a ) * BETR3( b ))) : 0 )	/* cos aus Skalaprod. */
#define DIFF(a, b) ((a)*(a) + (b)*(b)) /* DIFF, DIFF2: Abst.quadrate */
#define DIFF2(a, b) (((a)*(a) + (b)*(b)) * DIFFX*DIFFX) 
#define SET_V(s, ve) sqrt((2*DELTA*(s)+(ve)*(ve))/ROLL)
#define ABST(a,b) (((a).x-(b).x)*((a).x-(b).x) + ((a).y-(b).y)*((a).y-(b).y))

/* Definition der benˆtigten Strukturen */

struct vect { double x, y; };
struct vect3 { double x,y,z; };
struct ball { struct vect3 v, e, p; double m; struct vect3 rot; double mrot[16]; 
              unsigned char stat, col, nopaint, no, pocket; }; 
/* v: normale Translationsgeschw.; p: Koordinaten (0<=x<=1, 0<=y<=0.5); 
   e,ez: Effet, Spin; m: Masse          
   stat: "Status" der Kugel; col: Farbe (rot, gelb, schwarz) */ 
struct hole { struct vect3 p, m; double r; };
/* p: Pos. des Mittelpunktes des Kreises, der das jeweilige Loch darstellt,
   m: Pos. des Punktes auf den der Computer zielen muﬂ, damit er ins 
   Loch trifft, wird bei plot_table() oder so berechnet */
struct player { int stat, wait, points, col, hole_black; double speed;};
/* stat: f¸r Fouls, Treffer, etc.; col: welche Farbe darf angespielt werden;
   speed: letzter Powerfaktor */
struct bande { struct vect3 p0, p1, n, v; };
/* p0,p1: Die zwei Punkte, die die Position der Bande festlegen,
   n: 'Normalen-Vektor' der Bande */
struct target { struct vect3 pos; int kno, ord; struct target *next;
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
extern struct bande banpixel[18], ban[18];
extern struct player ply[2];
extern struct statistic stats[2];
extern FILE *datei;

/* functions in apool.c */
struct vect simulation[16000][16];
int simulation_flag;
struct vect undo_target;

void test_for_play_on_black( void );
int test_if_game_is_over( void );
void rules( void );
void init_table( void );
void undo( void );
void save_current_position( void );
void stop_it( void );
void calc_e_winkel( void );
void init_timer( void );
unsigned long timer( void );
void newstartpos(  double sx, double sy , double sz, int key, int invoke, int mouse_button );

/* functions in graphics.c */
int gamemode, last_gamemode;
char current_message[256],current_message2[256];
unsigned int err2_endtime;
char err2_msg1[80];
char err2_msg2[80];
unsigned int foul_endtime;
char foul_msg[128];

/* f. gamemode */
#define TARGET_MODE 2
#define FREELOOK_MODE 4
#define SPECIAL_TARGET_MODE 8
#define PLAY_MODE 16
#define SIMULATION_MODE 32
struct vect3 target;

void gl_plot_target(void);
void init_graphics( void );
void msg( char *ausgabestring );
void msg2( char *ausgabestring );
void speed( double geschwindigkeit, double scale, double posx, double posy );
void gl_plotall( int paintall );
void test_spin( void );
void paint_spin( double scale, double pos_y , double pos_x );
void wink( double winkel_alpha ); /* 0 <= alpha <= 85∞ */
void err( char *ausgabe_string );
void err2( char *out_first_line, char *out_second_line );
void gl_print_err2( void );
void foul( char *ausgabe_string, int time_in_milliseconds );
void gl_print_foul( void );
void debug( char *out_string );
int menu( void );
void wait_for_click( void );
void close_graphics( void );
void mouse_on( void );
void mouse_off( void );
void set_white_ball( void );
void calc_player_v( void );
void set_player_power( void );
void set_player_spin( void );
void set_test_power( void );
int set_test_power2( void );
void plot_statistics( double time, int graphics_on_off );
void delete_ball( int ballnr, int pocket );
void help( void );
void credits( void );
#define DETAIL_VERYLOW 1
#define DETAIL_LOW 2
#define DETAIL_MED 3
#define DETAIL_HIGH 4
#define DETAIL_VERYHIGH 5
int geo_detail; /* 1..5 */
#define TEXTURE_LOW 1
#define TEXTURE_HIGH 2
int txt_detail; /* 1..2 */
int env_map; /* Environment Mapping on/off (1/0) */
int ball_env_map; /* Environment Mapping for the balls on/off (1/0) */
int display_textures; /* klar, 1=yes, 0=no */
int display_floor_textures; /* klar, 1=yes, 0=no */
int new_game;

/* functions in physics.c */
/* f. k[x].stat */
#define FALLING (1<<3)
#define DELETED (1<<1)
#define ONTABLE (1<<2)
#define MOVING (1<<4)
#define GL_LISTED_NOT_MOVING (1<<5)
int calc_to_end;

void translate_spin( void );
void refl_kk( int kugelnr, struct vect3 kbande );
void coll( int kugel_a, int kugel_b );
void reflection( int kugelnr, int bandennr );
int in_line( int kugelnr, int bandennr );
int gl_move_balls( void );
void calc_v_end( int no_of_ball );
void gl_stoss( void );
void wait_user_time( double time );
int old_timer;

/* functions in computer.c */
int in_line_c( int ball_no_1, int ball_no_2, struct vect3 point_0, 
struct vect3 point_1, int color, int graphics_on_off );
struct vect3 calc_tp( struct vect3 cur_ball, struct vect3 target );
void set_c_speed( double end_speed, struct vect3 speed );
void computer_stoss( void );
int banden_stoss( void );
void calc_hot_spot( void );

/* functions and variables in gl.c */
int shadows;
#define NO_SHADOWS 0
#define PLANAR_SHADOWS 1
#define STENCIL_SHADOWS 2
#define STENCIL_SHADOWS2 3

double ico20[20*3*3];
double ico80[80*3*3];
double ico320[320*3*3];
double ico1280[1280*3*3];
double ico5120[5120*3*3];
double ico20480[20480*3*3];

#define ANZ_TEXTURES 37
GLuint *texture;
GLuint cube_texture[BALLS];

int table_color;
#define TABLE_BLUE 0
#define TABLE_GREEN 1
#define TABLE_RED 2

double frames_per_second;
int GLOPT;
int showfps;
struct vect3 oldang, oldstart, oldtrans;

void InitGL(int Width, int Height);
void calc_rotation(int i);
void calc_rotation_inkl_z(int i);
void gl_plotall( int paintall );
void clear_rotation_matrix(int i);
double angx,angy,angz,startx,starty,startz,transx,transy,transz;
double newangx, newangy, newangz, newstartx, newstarty, newstartz, newtransx, newtransy, newtransz;
void glPrint(int x, int y, char *outstring, int charset, double r, double g, double b, double a, double scale); 
void glPrintCentered(int y, char *out, int charset, float r, float g, float b, float alpha, float scale);
void gl_move_table(double x, double y, double z, double sx, double sy, double sz, double step, 
		   double transx, double transy, double transz );
void icosphere(double *ico, int no, double radius);
void gl_init_lists(void);
void title_screen(void);
void create_cubemaps(int which);
