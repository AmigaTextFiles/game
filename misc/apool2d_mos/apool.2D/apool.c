/* This is "apool.c", main-fragment of the pool (billiards)-program
                   
                     "ANOTHER POOL".

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

/* ------------------------------ apool.c -------------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
/*#include <linux/random.h>*/
#include "apool.h"

double ALPHA, BETA, GAMMA, DELTA, ETA, BANDES, BANDEREF, BANDEZ,
 SPINC, MASS_WHITE;
double CURVES, CURVEP; /* eigentlich Konstanten, werden es später wieder !!! */
int TIME_STEP;
int first_hit, bande_hit, col_in, last_foul, freeball, extra_shot, ende,
 STEP, CLEV, cur=1, new_col, c_player=-1, anstoss, demo = 0,
 undo_freeball, undo_extra_shot, undo_cur, undo_color, last_anstoss=0,
 last_pocketed_balls;
double undo_spd, undo_wink, undo_ez;
struct vect undo_e;

struct ball k[BALLS];
struct player ply[2];
FILE *datei;
struct vect old_pos[BALLS]; int old_stat[BALLS]; /* f. undo().. */
struct statistic stats[2] = {{{0,0,0,0},0,0,0,0},{{0,0,0,0},0,0,0,-1}};

void init_table( void ) 
/* Hier wird alles, was es so an Variablen bezüglich Lage der Kugeln gibt, 
   neu initialisiert. init_table() wird immer beim Neustart aufgerufen */
 { 
  int i, j, l=0;
  for(i=0;i<5;i++) 
   for(j=-i;j<=i;j+=2)		/* Lage der Kugeln am Anfang */
    { 
     k[l].p.x = 0.75+((i/*-2*/)*XAB/DIFFX) + 0.25 * RND / DIFFX;
     k[l].p.y = 0.25+j/2.0*((2*RADIUS+2))/DIFFX + 0.25 * RND / DIFFX;
     k[l].v.x = k[l].v.y = k[l].e.x = k[l].e.y = k[l].ez = k[l].col = 0.0; 
     k[l].stat = 0; k[l++].m = 1.0;
    }
  k[BLACK].col = COL_BLACK; l = 0;
  do			/* Farbe der Kugeln, zufallsgesteuert */
   { 
    while( (i = 15.0*rand()/(RAND_MAX) ) == BLACK );
    if( !k[i].col ) { k[i].col = COL_RED; l++; }
   }
  while( l < (BALLS-2)/2 );
  for( i=0;i<WHITE;i++ ) if( !k[i].col ) k[i].col = COL_YELLOW;
  k[WHITE].stat = 1; /* Weiße ist anfangs NICHT auf dem Tisch */
  k[WHITE].m = MASS_WHITE;
  k[WHITE].col = COL_WHITE;
  for( i=0;i<2;i++)
   { ply[i].stat = ply[i].wait = ply[i].col = ply[i].hole_black = 0; }
  first_hit = bande_hit = anstoss = 1;
  plot_table();	 /* oben: damit nicht VOR dem Anfang bereits gefoult wurde */
  ply[0].speed = ply[1].speed = spd = 0.75; speed( spd );
  wink( alph );
  for( i=0;i<WHITE;i++) plot_one_ball( i );
  freeball = extra_shot = last_foul = col_in = 0;
  if( demo ) msg("press any key to stop demo");
 }
 
void save_current_position( void )
 { /* sichert die aktuelle Position der Kugeln, für undo() */
  int i;
  for( i=0;i<BALLS;i++ ) { old_pos[i].x = k[i].p.x; old_pos[i].y = k[i].p.y; 
   old_stat[i] = k[i].stat; }
  undo_cur = cur;
  undo_freeball = freeball;
  undo_extra_shot = extra_shot;
  undo_color = ply[cur].col;
  undo_spd = spd;
  undo_wink = alph;
  undo_e.x = k[WHITE].e.x;
  undo_e.y = k[WHITE].e.y;
  undo_ez = k[WHITE].ez;
 }
 
void undo( void )
 { /* naja, was wohl */
  int i;
  mouse_off();
  for( i=0;i<BALLS;i++ )
   {
    if( !k[i].stat ) plot_one_ball( i );
    k[i].p.x = old_pos[i].x; 
    k[i].p.y = old_pos[i].y; 
    k[i].stat = old_stat[i]; 
    if( !k[i].stat ) plot_one_ball( i );
   }
  plot_table();
  cur = undo_cur;
  freeball = undo_freeball;
  extra_shot = undo_extra_shot;
  ply[cur].col = undo_color;
  plot_cur_player( cur );
  if( ply[cur].col == COL_RED ) i = 4;
  else if( ply[cur].col == COL_YELLOW ) i = 11;
  else i = 6;
  if( freeball ) err2("free-ball", i);
  else if( extra_shot) err2("extra_shot", i);
  else err2(" ", 0);
  speed( spd = undo_spd );
  wink( alph = undo_wink );
  set_spin( undo_e.x, undo_e.y, undo_ez );
	plot_balls(1);
  mouse_on();
 }

void test_for_play_on_black( void )
/* Wenn alle Kugeln einer Farbe verschwinden sind, wird auf die Schwarze
   gespielt. Wann das der Fall ist, und wer Schwarz spielen muß, ermittelt
   dies Prozedur */
 {
  int i, j;
  for( j=0;j<2;j++ )
   if( (ply[j].col != COL_BLACK) && (ply[j].col) ) 
    {
     ply[j].hole_black = 0;
     for(i=0;i<WHITE;i++)
      if( k[i].stat && (k[i].col == ply[j].col) ) ply[j].hole_black++;
     if( ply[j].hole_black == (BALLS-2)/2 ) 
      {
       ply[j].col = COL_BLACK;
        /* ply[j].hole_black = last_hole gegenüber; */ /* SPÄTER !!! */
      }
    }
 } 
 
char *str_player( char *out2, int cur )
 { 
  sprintf(out2, "Player %d%s", cur+1, (c_player==cur) ? " (Computer)" : "");
  return out2;
 }

int test_if_game_is_over( void ) 
 { /* Wie der Name schon sagt, testet, ob Spiel zu Ende */
 char out[80], out2[30];
 int loser;
 if( k[BLACK].stat )
  {
   if( !(ply[cur].stat & FOUL_ANY_FOUL) ) 
    {        /* Schwarze wurde KORREKT eingelocht */
     loser = 1 - cur;
     sprintf(out,"%s wins!", str_player( out2, cur) );
     ply[cur].points += 1;
     stats[cur].wins += 1;
     stats[cur].pots += 1;
    }
   else
    { 
     loser = cur;
     sprintf(out,"black ball illegaly pocketed; %s loses!",
      str_player( out2, cur ) );
     ply[cur].points += 10000;
     stats[cur].losses += 1;
     cur = 1 - cur;
    }
   err(out);
   if( loser != last_anstoss ) last_anstoss = loser;
   if( demo || c_player == loser ) { msg("wait..."); wait_user_time( 5.0 ); }
   else wait_for_click();
   init_table();
   return 1;
  }
 return 0;
}
 
void rules( void )
/* Die Regeln, nach einem Stoß wird überprüft, ob keine Fouls aufgetreten
   sind. Sollte dies so sein, so erfolgen die "Strafen". Ruft die obigen
   Test-Prozeduren, das Menu und den Stoß auf ... */
 {
 int spielende=0, color; 
 mouse_off();
 init_table();
 ply[0].points = ply[0].points = 0;
 do
  {
   first_hit = bande_hit =  0;
   if( ply[cur].stat & FOUL_WHITE_POCKETED ) /* hier kommen die Fouls... */
    {
     err("white ball pocketed, foul!");
     last_foul = 1;
     stats[cur].fouls.whited += 1;
    }
   else if( ply[cur].stat & FOUL_NO_TOUCH )
    {
     err("no ball or no side touched, foul!");
     last_foul = 1;
     stats[cur].fouls.notouch += 1;
    }
   else if( ply[cur].stat & FOUL_WRONG_COLOR_POCKETED)
    {
     if( !freeball )
      {
       err("wrong color pocketed, foul!");
       last_foul = 1;
       stats[cur].fouls.wrongcp += 1;
      }
     else { ply[1-cur].wait = 1; }
    }
   else if( ply[cur].stat & FOUL_WRONG_COLOR_TOUCHED )
    {
     if( !freeball )
      {
       err("wrong color touched first, foul!");
       last_foul = 1;
       stats[cur].fouls.wrongct += 1;
      }
     else { extra_shot = 1; }
    }
   else if( !(ply[cur].stat & FOUL_ANY_FOUL) ) /* kein Foul gemacht */
    {
    if( ply[cur].stat & FOUL_CORRECT_POT )
     {
      last_foul = 0;
      stats[cur].pots += last_pocketed_balls;
      err("OK!"); /* Kugel eingelocht */
     }
    else /* keine Kugel eingelocht */
     {
      stats[cur].nopots += 1;
      if( ply[1-cur].wait == 1 ) { extra_shot = 1; ply[1-cur].wait = 0; }
      else cur = 1 - cur;
     }
    }
   if( col_in && last_foul ) { ply[cur].col = ply[1-cur].col = 0; }
   if( last_foul ) 
    { 
     ply[cur].wait = 1; cur = 1 - cur;
     if( ply[cur].col == COL_RED ) color = 4;
     else if( ply[cur].col == COL_YELLOW ) color = 11;
     else color = 6;
     err2("free-ball", color ); 
     freeball = 1; 
    }
   else if( extra_shot )
    {
     ply[cur].wait = 0;
     freeball = 0;
     if( ply[cur].col == COL_RED ) color = 4;
     else if( ply[cur].col == COL_YELLOW ) color = 11;
     else color = 6;
     err2("extra-shot", color);
    }
   else freeball = 0;
   if( !freeball && !extra_shot) err2(" ", 0);
   new_col = col_in = last_foul = extra_shot = last_pocketed_balls = 0;
   ply[0].stat = ply[1].stat = 0;  /* eigentlich nur ply[cur].stat */
   if( demo ) c_player = cur; 
   if( c_player != cur ) speed( spd = ply[cur].speed );
   if( !( spielende = menu() ) ) stoss(); /*HIER ROLLEN ERST D. KUGELN*/
   if( !test_if_game_is_over() ) test_for_play_on_black();   
   if( new_col & NEW_COL_NEW )
    {
    if( (new_col & NEW_COL_DOUBLE) /*&& (ply[cur].stat & FOUL_CORRECT_POT)*/ )
     ply[0].col = ply[1].col = 0;
    }
   if( (!first_hit) || (!bande_hit) ) ply[cur].stat |= FOUL_NO_TOUCH;
  }
 while( !spielende );
 }

void stop_it( void )
 { /* beendet Programm und gibt Statistiken und Stand aus */
 int i;
 close_graphics();
 if( datei ) fclose(datei);
 MSG;
 for( i=0;i<2;i++ )
  printf("\n	Player %d has won %d and lost %d game%s",i+1, 
   (int)(ply[i].points)%10000, (int)(ply[i].points)/10000,
   ( ((int)(ply[i].points)/10000) !=1 ) ? "s" : "");
 printf("\n\n");
 exit( 0 );
 }
 
int main( int argc, char *argv[])
 {
 time_t sys_time;
 SCREENRESX = 800; SCREENRESY=600; RADIUS=10.0;
 if( !(datei = fopen("konst.dat","r") ) ) 
  { /* Datei für die (phys.) Konstanten */
  printf("can't open file 'konst.dat'\n");
  exit( 0 ); 
  }
 fscanf(datei,"%lg%*[^\n]%lg%*[^\n]%lg%*[^\n]%lg%*[^\n]%lg%*[^\n]",
  &ALPHA, &BETA, &GAMMA, &DELTA, &ETA);
 fscanf(datei,"%lg%*[^\n]%lg%*[^\n]%lg%*[^\n]%lg%*[^\n]",
  &BANDES, &BANDEREF, &BANDEZ, &MASS_WHITE);
 fscanf(datei,"%d%*[^\n]%d%*[^\n]", &STEP, &CLEV);
 fscanf(datei,"%lg%*[^\n]%lg%*[^\n]%d%*[^\n]",&CURVES, &CURVEP, &TIME_STEP);
 if( CLEV > 15 ) CLEV = 15; /* Computer-Level max 15 */
 fclose(datei);
 /*if(argc>=4) init_graphics( atoi(argv[1]), atoi(argv[2]), atoi(argv[3]) );*/
 if( argc >= 3 )
  {
	if( !strcmp( argv[1], "-xy") )
	 {
	  SCREENRESX = atoi( argv[2] );
	  SCREENRESY = atoi( argv[3] );
	 }
	}
 RADIUS = SCREENRESY / 60.0 + 1.0;
 create_table( 4.0*RADIUS );
 init_graphics( SCREENRESX, SCREENRESY, 256 );
 datei = NULL;
/* datei = fopen("xxx.xxx","w"); */
 init_timer();
 sys_time = time( NULL );
 srand( sys_time % RAND_MAX );
 rules(); /* Start des Spiels */
 stop_it();
 return 0;
}

void calc_e_winkel( void )
 /* Als nächstes wird der "Einschußwinkel" der Mittellöcher berechnet, also
    der Winkel, "oberhalb des cos( dieses Winkels )" die Kugeln noch ins 
    Mittelloch versenkt werden können */
 {
 double dummy;
 dummy = (DIFFX/2 - ban[8].p0.x) - 0; /* wasndas?! */
 e_winkel = 90-180.0 / M_PI * 
 atan( ((ban[8].p0.y+RADIUS+2.0) - posl[2].m.y*(double)DIFFX) / dummy );
 }


