/* This is "computer.c", a part of the pool (billiards)-program
                   
                     "ANOTHER POOL".

   "computer.c" includes the procedures needed for the computer-
   player of ANOTHER POOL. "computer.c" also uses SDL (see graphics.c)

   Copyright (C) 1995 by Gerrit Jahn (http://www.planetjahn.de)

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

/* ------------------------------ computer.c ----------------------------- */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "apool.h"
#include <SDL.h>
#include <SDL_gfxPrimitives.h>

extern SDL_Surface *display;

#define GrLine(a,b,c,d,e ) \
  lineRGBA(display, a, b, c, d, col2[e][0], col2[e][1], col2[e][2], 255)
#define GrFilledCircle(a,b,c,d) \
  filledCircleRGBA(display, a, b, c, col2[d][0], col2[d][1], col2[d][2], 255)
#define GrCircle(a,b,c,d)  \
  circleRGBA(display, a, b, c, col2[d][0], col2[d][1], col2[d][2], 255)

int col2[20][3] = {{0,0,0},{255,0,0},{255,255,0},{32,32,32},{0,128,0},
                  {124,224,224},{55,0,0},{255,0,255},{32,32,222},{0,256,0},
                  {255,255,255},{255,55,55},{0,0,0},{0,0,96},{0,0,255},
		  {0,0,128},{140,90,40},{0,0,196},{0,0,128},{0,0,128}};


struct target t; /* Kopf der 'target'-Liste ... (s.u.) */

int in_line_c( int b,int b2,struct vect x0,struct vect x1,int color,int grx)
/* diese wichtigste Funktion überhaupt, testet, ähnlich wie in_line() in 
   graphics.c, ob im Abstand RADIUS der Verbindungslinie x0--> x1 eine Kugel
   liegt, welche dann natürlich einen Stoß in diese Richtung verbieten muß !*/
 {
 struct vect kk, c;
 double t, dummy;
 int i;
 kk.x = x1.x - x0.x;
 kk.y = x1.y - x0.y;
 /* unten: der Weg der Kugel muß noch um 2*RADIUS weiter überprüft werden ! */
 if( (dummy = BETR( kk )) ) 
  {
   kk.x /= dummy;
   kk.y /= dummy;
   x1.x += (2*RADIUS)/DIFFX * kk.x; 
   x1.y += (2*RADIUS)/DIFFX * kk.y;
  }
 c.x = x1.x - x0.x; c.y = x1.y - x0.y;
 if( grx ) 
  {
  GrLine( x0.x*DIFFX+LEFT, x0.y*DIFFX+UP, x1.x*DIFFX+LEFT, 
   x1.y*DIFFX+UP, color );
  }
 for( i=0;i<WHITE;i++ )
  if( (i != b) && ( i!= b2) && !(k[i].stat) )
   {
    t = -(c.x*(x0.x-k[i].p.x)+c.y*(x0.y-k[i].p.y)) / (SKALP(c,c));
    kk.x = x0.x + c.x * t;
    kk.y = x0.y + c.y * t;
    if( (c.x * (kk.x-x0.x) >= 0) && (c.y * (kk.y-x0.y) >= 0) &&
     (c.x * (kk.x-x1.x) <= 0) && (c.y * (kk.y-x1.y) <= 0) )
     {
      if( grx ) GrLine(k[i].p.x*DIFFX+LEFT,k[i].p.y*DIFFX+UP,kk.x*DIFFX+LEFT,
       kk.y*DIFFX+UP,  color );
      if( sqrt( DIFF(k[i].p.x-kk.x, k[i].p.y-kk.y) ) <= (2*RADIUS)/DIFFX )
       { if( grx ) GrCircle( k[i].p.x*DIFFX+LEFT, k[i].p.y*DIFFX+UP, 5, 
        color ); return 1; }
	/* Abstand (Verbind.linie -> Kugel) zu klein --> Kugel liegt im Weg */
     }
   }
  return 0;
 }
 
/*#define HOLE_INLINE 1 */ 

#ifdef HOLE_INLINE
int hole_inline( struct vect v, struct vect x0 )
 /* es wird berechnet, ob sich ein Loch in der Bahn des jeweiligen
    Abstandsvektors befindet. */
 {
 struct vect kk, c, x1;
 double t;
 int i;
 x1.x = x0.x + v.x;
 x1.y = x0.y + v.y;	/* alles ein bißchen doppelt gemoppelt !!! !!! !!! */
 c.x = x1.x - x0.x; 
 c.y = x1.y - x0.y;
 for( i=0;i<6;i++ )
  {
   t = -(c.x*(x0.x-posl[i].m.x)+c.y*(x0.y-posl[i].m.y)) / (SKALP(c, c));
   kk.x = x0.x + c.x * t;
   kk.y = x0.y + c.y * t;
   if( (c.x * (kk.x-x0.x) >= 0) && (c.y * (kk.y-x0.y) >= 0) &&
    (c.x * (kk.x-x1.x) <= 0) && (c.y * (kk.y-x1.y) <= 0) )
    {
     if( sqrt( DIFF(posl[i].m.x-kk.x, posl[i].m.y-kk.y) ) 
      <= (5*RADIUS)/DIFFX ) return 1;
    }
  }
  return 0;
 }
#endif

struct vect calc_tp( struct vect a, struct vect b )
/* berechnet den Punkt, an den die Kugel ball getroffen werden muß, damit
   sie in Richtung h rollt... ! !!! !!! !!! stimmt SO nicht mehr */
 {
  struct vect c;
  double dummy;
  c.x = b.x - a.x; c.y = b.y - a.y;
  if( (dummy=BETR( c )) ) { c.x /= dummy; c.y /= dummy; }
  a.x -= 2.0*RADIUS/DIFFX * c.x;
  a.y -= 2.0*RADIUS/DIFFX * c.y;
  return a;
 }

void set_c_speed( double v0, struct vect v )
 { /* berechnet die Geschwindigkeit, mit der der Computer stoßen muß; in 
      Richtung v, Streckenlänge strecke */
  double dummy; /* v : zeigt in Richtung der Geschwindigkeit */
  char out[80];
  if( (dummy=BETR( v )) ) { v.x/=dummy; v.y/=dummy; }
  spd = DIFFX * v0;
  if( spd > 1.0 ) 
   { 
    sprintf(out, "sorry, %s I'm to weak... (only %3.0f%%)",
    (1/spd > 0.94) ? "maybe" : "", 100.0/spd);
    debug(out);
    spd = 1.0; 
   }
  k[WHITE].v.x = spd/DIFFX * v.x;
  k[WHITE].v.y = spd/DIFFX * v.y;
  speed( spd );
 }	     

#ifdef BANDEN
struct ball ball_copy( int nr, int xl, int yl, int xr, int yr )
/* je nach Aufruf wird der Tisch nach oben, unten links, rechts gespiegelt,
   womit sich Bandenstöße (allerdings nur, falls Einfallswinkel=Ausfallswinkel
   gilt) leichter berechnen lassen */
 {
  struct ball ret;
  ret.p.x = k[nr].p.x + xl * k[nr].p.x + xr * (1.0 - k[nr].p.x);
  ret.p.y = k[nr].p.y + yl * k[nr].p.y + yr * (0.5 - k[nr].p.y);
  ret.col = k[nr].col;
  ret.stat = k[nr].stat; /* Rest: Masse, Geschw. nicht nötig */
  return ret;
 }
#endif

#ifdef BANDEN
void plot_sides(  struct ball *kb, struct hole *poslb )
/* malt auf den normalen Tisch die mit ball_copy() kopierten Tische auf 
    wird wohl eher zum graphischen Debuggen dienen ... !!! !!! !!!*/
 {
 int i, j;
 GrLine( LEFT+200, UP+0, LEFT+200, UP+300, 6 );
 GrLine( LEFT+400, UP+0, LEFT+400, UP+300, 6 );
 GrLine( LEFT+0, UP+100, LEFT+600, UP+100, 6 );
 GrLine( LEFT+0, UP+200, LEFT+600, UP+200, 6 );
 for( i=0;i<BANDEN;i++ )
  for( j=0;j<WHITE;j++ )
  { 
   GrFilledCircle( LEFT + 200+kb[i*BALLS+j].p.x*200,  
    UP + 100 + kb[i*BALLS+j].p.y*200, 2, (3*kb[i*BALLS+j].col + 3)  );
  }
 for( i=0;i<BANDEN;i++ )
  for( j=0;j<6;j++ )
   GrFilledCircle( LEFT+200+poslb[i*6+j].m.x*200, UP+100+200*poslb[i*6+j].m.y,
    1, 15 );
 }

struct hole hole_copy( int x, int y, int n )
/* analog ball_copy werden hier für die Bandenstöße die Löcher gespiegelt,
   wobei man natürlich aufgrund der Symmetrie nicht "richtig" spiegeln 
   muß, einfach verschieben genügt hierbei auch */
 {
 struct hole ret;
 ret.p.x = posl[n].p.x + x*1.0;
 ret.p.y = posl[n].p.y + y*0.5;
 ret.m.x = posl[n].m.x + x*1.0;
 ret.m.y = posl[n].m.y + y*0.5;
 return ret; 
 }

int banden_stoss( void )
/* berechnet den Stoß über eine bzw., falls eine Kugel über Eck rollt,
   zwei Banden ... da gibt's noch etwas Arbeit !!! !!! !!!*/
 {
 int ret = 0, i, j;
 struct ball kb[BALLS*9];
 struct hole poslb[9*6];
 /* zuerst: nur 1.5 (1 hoch/runter, 2 mit "übereck") Banden !!! !!! !!!*/
 /* 1, Aktion: Kugeln in alle 8 Richtungen spiegeln: */
 for( j=0;j<6;j++ )
  {
  poslb[0*6+j] = hole_copy( -1, -1, j );
  poslb[1*6+j] = hole_copy(  0, -1, j );
  poslb[2*6+j] = hole_copy(  1, -1, j );
  poslb[3*6+j] = hole_copy( -1,  0, j );
  poslb[4*6+j] = hole_copy(  0,  0, j );
  poslb[5*6+j] = hole_copy(  1,  0, j );
  poslb[6*6+j] = hole_copy( -1,  1, j );
  poslb[7*6+j] = hole_copy(  0,  1, j );
  poslb[8*6+j] = hole_copy(  1,  1, j );
  }
 for( i=0;i<WHITE;i++ )
  {
  kb[0*BALLS+i] = ball_copy( i, -2, -2, 0, 0 );		/* links oben */
  kb[1*BALLS+i] = ball_copy( i, 0, -2, 0, 0 );		/* oben */
  kb[2*BALLS+i] = ball_copy( i, 0, -2, 2, 0 );		/* oben rechts */
  kb[3*BALLS+i] = ball_copy( i, -2, 0, 0, 0 );		/* links */
  kb[4*BALLS+i] = ball_copy( i, 0, 0, 0, 0 );		/* mitte */
  kb[4*BALLS+WHITE].p.x = k[WHITE].p.x;
  kb[4*BALLS+WHITE].p.y = k[WHITE].p.y;
  kb[5*BALLS+i] = ball_copy( i, 0, 0, 2, 0 );		/* rechts */
  kb[6*BALLS+i] = ball_copy( i, -2, 0, 0, 2 );		/* links unten */
  kb[7*BALLS+i] = ball_copy( i, 0, 0, 0, 2 );		/* unten */
  kb[8*BALLS+i] = ball_copy( i, 0, 0, 2, 2 );		/* unten rechts */
  }
plot_sides( kb, poslb );
/*
if( (c_player == -1) || (cur != c_player) ) 
 if( getkey() == 27 ) stop_it();
*/
plot_sides( kb, poslb );
return ret;
}
#endif

int out_of_bounds( struct vect p )
/* Es wird überprüft, ob der Treffpunkt, der bei calc_tp berechnet wurde,
   innerhalb des spielbaren Bereichs des Tisches, also nicht in den Banden
   liegt. Könnte man mit calc_tp evtl. kombinieren ... !!! !!! !!! */
/* ACHTUNG !!! !!! !!! Fehlerquelle, könnte sein, daß die Treffpunkte, die
   in der Nähe eines Lochs liegen so ebenfalls herausgefiltert werden ! */
 {
 if( (p.x > (DIFFX-RADIUS)/DIFFX) || (p.x < RADIUS/DIFFX) ||
  (p.y > (DIFFX/2-RADIUS)/DIFFX) || (p.y < RADIUS/DIFFX) )
  return 1;
 return 0;
 }

struct target *mark_higher_combies( struct target *last,int ordnung,int egal,
 double max_angle )
/* es werden die Treffpunkte an den Kugeln berechnet, die, wenn sie angespielt
   werden, dazu "führen", daß eine ander Kugel entweder ins Loch geht oder
   wiederum eine andere trifft, ... */
 {
 int i;
 double dummy;
 struct target *end, *current, *dum;
 struct vect b, c, d, e;
 end = last;
 SDL_Flip(display);
 if( t.next != NULL ) /* t ist der Kopf der "Target-Liste" */
  for( i=0;i<WHITE;i++ )
   {
    current = t.next;
    while((current!=NULL)&& (current->ord) < ordnung-1) current = current->next;
    if( !k[i].stat && ( (k[i].col == ply[cur].col) ||
    (!ply[cur].col && (i != BLACK)) || egal ) )
    while( (current != NULL) && (current->ord == (ordnung-1)) ) /* hmmmmm */
     {
      b.x = k[i].p.x; b.y = k[i].p.y;
      if( !in_line_c( i, current->kno, b, current->pos, 0, 0 ) )
       {
       c = calc_tp( b, current->pos );
       if( !out_of_bounds( c ) )
        {
        d.x = k[current->kno].p.x - current->pos.x; 
        d.y = k[current->kno].p.y - current->pos.y;
        e.x = current->pos.x - c.x;
	e.y = current->pos.y - c.y;
        if( (dummy = COSV( d, e )) > max_angle )
         {

	  /* Zirkelschlüsse vermeiden !!! !!! !!! */
          dum = malloc( sizeof( struct target ) );
          dum->pos.x = c.x;
          dum->pos.y = c.y;
	  dum->test = current;
	  /* unten: es dürfen nicht ALLE (auch die vorherigen) Strecken durch
	     den cos geteilt werden, nur die letzte !!! !!! !!! */
	  dum->spd = SET_V( BETR(e), current->spd / dummy );
	  dum->angle = (current->angle) * dummy;
          dum->kno = i;
          dum->ord = ordnung;
          dum->next = end->next;
          end->next = dum;
          end = end->next; /* = dum */	      
         }
	}
       }
      current = current->next;
     }
   }
 return end;
}

int plot_targets( void )
/* Malt die mit mark_combi, mark_higher_combies berechneten Punkte */
 {
 int i = 0, x, y;
 struct target *curt;
 curt = t.next;
 while( curt != NULL )
  {
  x = curt->pos.x*DIFFX+LEFT;
  y = curt->pos.y*DIFFX+UP;
  GrLine( x-2, y-2, x+2, y+2, 1 );
  GrLine( x-2, y+2, x-1, y+1, 1 );
  GrLine( x+1, y-1, x+2, y-2, 1 );
  curt = curt->next;
  i++;
  }
 return i; 
 }

/* 
 UNTEN: einfachster Weg wäre: erstmal die möglichen Ziele ausrechnen, 
 d.h. z.B. pro Loch 5 Punkte (zentral, direkt an den Banden und dazwischen.
 Danach so verfahren wie unten, d.h. schauen, bei welcher Kugel sich die 
 Weiße am wenigsten bewegt, wenn eines der möglichen Ziele von der
 getroffenen Kugel anvisiert wird....  
*/

void mark_combi( void )
/* markiert die "targets", also die Punkte, die, wenn man sie mit der Weißen
   anspielt, entweder direkt, oder über einige andere Kugeln (Kombie), eine
   Kugel versenken ... !, s. auch mark_higher_combies() */
 {
 int i, j, next;
 double dummy;
 struct vect a, b, c, d, e;
 struct target *dum, *curt;
 curt = &t;
 /* Es folgen die "targets" 0. Ordnung, also eigentlich keine Kombies,
    sondern einfach Kugeln, die direkt ins Loch gespielt werden können */
 for( i=0;i<WHITE;i++ )
  if( !k[i].stat && ( (k[i].col == ply[cur].col) ||
  (!ply[cur].col && (i != BLACK)) ) )
   {
   for( j=0;j<6;j++ )
    {
      b.x = posl[j].p.x-posl[j].m.x;
      b.y = posl[j].p.y-posl[j].m.y;
     /* u: dieses if fragt ab, ob sich eine Kugel schon fast im Loch befindet,
        ob sie also so liegt, daß man sie einfach nur in Richutung Loch 
	(irgendwie) anstoßen muß, damit sie ins Loch rollt; die "14" ergibt
	sich (bei den Ecklöchern aus sqrt(2)*Bandendicke... */ /* !?!?!? */
     if( DIFF( posl[j].p.x-k[i].p.x, posl[j].p.y-k[i].p.y ) <= 
      ((RADIUSL+14)*(RADIUSL+14)/(DIFFX*DIFFX)) )
       { c.x = posl[j].p.x - k[i].p.x; c.y = posl[j].p.y - k[i].p.y; }
     else /* d.h., Kugel liegt noch nicht fast im Loch */
      { c.x = posl[j].m.x - k[i].p.x; c.y = posl[j].m.y - k[i].p.y; }
     if( ( ((j == 2) || (j == 5)) && (COSV(b, c) > COS(e_winkel)) ) 
      || ( (j != 2)  && (j != 5 )) )
      {
       d.x = k[i].p.x; d.y = k[i].p.y;
       if( DIFF( posl[j].p.x-k[i].p.x, posl[j].p.y-k[i].p.y ) <= 
        ((RADIUSL+14)*(RADIUSL+14)/(DIFFX*DIFFX)) )
        {  
        /* "unsaubere" Lösung: Wenn eine Kugel schon fast im Loch liegt,
	   wird hier einfach der Treffpunkt in Richtung Mittelpunkt des Lochs
	   verschoben, da dieser besser zu treffen ist !!! */
        b.x = posl[j].p.x - posl[j].m.x;
	b.y = posl[j].p.y - posl[j].m.y; 
	if( (dummy = BETR( b )) ) { b.x /= dummy; b.y /= dummy; }
	c.x = d.x - b.x * 2.0*RADIUS/DIFFX; 
	c.y = d.y - b.y * 2.0*RADIUS/DIFFX;
	next = 1;
	}
       else /* d.h., Kugel liegt noch nicht fast im Loch */
        { 
	 b.x = posl[j].m.x; b.y = posl[j].m.y; next = 0; 
         c = calc_tp( d, b );
        }
       if( next || !out_of_bounds( c ) )
        {
        d.x = c.x - k[WHITE].p.x;
        d.y = c.y - k[WHITE].p.y;
        e.x = k[i].p.x - c.x;
        e.y = k[i].p.y - c.y;
	a.x = k[i].p.x;
	a.y = k[i].p.y;    /* -0.95 ? */
        if( (COSV( d, e ) > -0.95) && (!in_line_c( i, i, a, b, 6, 0) ) )
         {
          dum = malloc( sizeof( struct target ) );
          dum->pos.x = c.x;
          dum->pos.y = c.y;
          b.x = posl[j].m.x - c.x;
          b.y = posl[j].m.y - c.y;   /* u: letzteres, da nicht IM Loch ..! */
	  dum->spd = SET_V( BETR(b), 0 );
	  dum->angle = 1.0;
          dum->kno = i;
          dum->ord = 0;
	  dum->test = NULL;
          dum->next = curt->next;
          curt->next = dum;
          curt = curt->next; /* = dum */	
	 }
       }
      }
    }
   }
/* jetzt: Kombies höherer Ordnung, also "echte" Mehrfachstöße .... */
 for( i=1;i<CLEV;i++ )
  curt = mark_higher_combies( curt, i, 1, 0.05 + 0.05*i );
 mark_higher_combies( curt, CLEV, freeball, 0.05 + 0.05*i );
 }

void mark_combi_orig( void )
/* markiert die "targets", also die Punkte, die, wenn man sie mit der Weißen
   anspielt, entweder direkt, oder über einige andere Kugeln (Kombie), eine
   Kugel versenken ... !, s. auch mark_higher_combies() */
 {
 int i, j, next;
 double dummy;
 struct vect a, b, c, d, e;
 struct target *dum, *curt;
 curt = &t;
 /* Es folgen die "targets" 0. Ordnung, also eigentlich keine Kombies,
    sondern einfach Kugeln, die direkt ins Loch gespielt werden können */
 for( i=0;i<WHITE;i++ )
  if( !k[i].stat && ( (k[i].col == ply[cur].col) ||
  (!ply[cur].col && (i != BLACK)) ) )
   {
   for( j=0;j<6;j++ )
    {
      b.x = posl[j].p.x-posl[j].m.x;
      b.y = posl[j].p.y-posl[j].m.y;
     /* u: dieses if fragt ab, ob sich eine Kugel schon fast im Loch befindet,
        ob sie also so liegt, daß man sie einfach nur in Richutung Loch 
	(irgendwie) anstoßen muß, damit sie ins Loch rollt; die "14" ergibt
	sich (bei den Ecklöchern aus sqrt(2)*Bandendicke... */ /* !?!?!? */
     if( DIFF( posl[j].p.x-k[i].p.x, posl[j].p.y-k[i].p.y ) <= 
      ((RADIUSL+14)*(RADIUSL+14)/(DIFFX*DIFFX)) )
       { c.x = posl[j].p.x - k[i].p.x; c.y = posl[j].p.y - k[i].p.y; }
     else /* d.h., Kugel liegt noch nicht fast im Loch */
      { c.x = posl[j].m.x - k[i].p.x; c.y = posl[j].m.y - k[i].p.y; }
     if( ( ((j == 2) || (j == 5)) && (COSV(b, c) > COS(e_winkel)) ) 
      || ( (j != 2)  && (j != 5 )) )
      {
       d.x = k[i].p.x; d.y = k[i].p.y;
       if( DIFF( posl[j].p.x-k[i].p.x, posl[j].p.y-k[i].p.y ) <= 
        ((RADIUSL+14)*(RADIUSL+14)/(DIFFX*DIFFX)) )
        {  
        /* "unsaubere" Lösung: Wenn eine Kugel schon fast im Loch liegt,
	   wird hier einfach der Treffpunkt in Richtung Mittelpunkt des Lochs
	   verschoben, da dieser besser zu treffen ist !!! */
        b.x = posl[j].p.x - posl[j].m.x;
	b.y = posl[j].p.y - posl[j].m.y; 
	if( (dummy = BETR( b )) ) { b.x /= dummy; b.y /= dummy; }
	c.x = d.x - b.x * 2.0*RADIUS/DIFFX; 
	c.y = d.y - b.y * 2.0*RADIUS/DIFFX;
	next = 1;
	}
       else /* d.h., Kugel liegt noch nicht fast im Loch */
        { 
	 b.x = posl[j].m.x; b.y = posl[j].m.y; next = 0; 
         c = calc_tp( d, b );
        }
       if( next || !out_of_bounds( c ) )
        {
        d.x = c.x - k[WHITE].p.x;
        d.y = c.y - k[WHITE].p.y;
        e.x = k[i].p.x - c.x;
        e.y = k[i].p.y - c.y;
	a.x = k[i].p.x;
	a.y = k[i].p.y;    /* -0.95 ? */
        if( (COSV( d, e ) > -0.95) && (!in_line_c( i, i, a, b, 6, 0) ) )
         {
          dum = malloc( sizeof( struct target ) );
          dum->pos.x = c.x;
          dum->pos.y = c.y;
          b.x = posl[j].m.x - c.x;
          b.y = posl[j].m.y - c.y;   /* u: letzteres, da nicht IM Loch ..! */
	  dum->spd = SET_V( BETR(b), 0 );
	  dum->angle = 1.0;
          dum->kno = i;
          dum->ord = 0;
	  dum->test = NULL;
          dum->next = curt->next;
          curt->next = dum;
          curt = curt->next; /* = dum */	
	 }
       }
      }
    }
   }
/* jetzt: Kombies höherer Ordnung, also "echte" Mehrfachstöße .... */
 for( i=1;i<CLEV;i++ )
  curt = mark_higher_combies( curt, i, 1, 0.05 + 0.05*i );
 mark_higher_combies( curt, CLEV, freeball, 0.05 + 0.05*i );
 }

void delete_targets( struct target *dum )
/* Löscht am Ende alle mit mark_combi() erstellten targets aus der Liste */
 {
 if( dum->next != NULL ) delete_targets( dum->next );
 free( dum );
 }

void plot_line( struct target *head, int color ) 
/* malt den Weg, von der Weißen ausgehend bis ins Loch, evtl über alle 
   Kombies, den die Kugeln nehmen sollen (!), nachdem der Computer mit 
   mark_... diesen Weg indirekt berechnet hat */
 {
  struct target *current;
  int oldx, oldy, x, y, i;
  struct vect a, b;
  current = head;
  oldx = k[WHITE].p.x*DIFFX+LEFT;
  oldy = k[WHITE].p.y*DIFFX+UP;
  while( current->test != NULL )
   {
   x = (current->pos.x)*DIFFX+LEFT;
   y = (current->pos.y)*DIFFX+UP;
   if( color ) lineRGBA(display,oldx, oldy, x, y, 0,0,0,255);    
   else lineRGBA(display,oldx, oldy, x, y, 0,128,0,255);    
   oldx = x;
   oldy = y;
   current = current->test;
   }
  x = (current->pos.x)*DIFFX+LEFT;
  y = (current->pos.y)*DIFFX+UP;
  if( color ) lineRGBA(display,oldx, oldy, x, y, 0,0,0,255);    
  else lineRGBA(display,oldx, oldy, x, y, 0,128,0,255);    
  /* letzter Weg muß "geraten" werden (!?) */
  for( i=0;i<6;i++ )
   {
    a.x = posl[i].m.x - current->pos.x;
    a.y = posl[i].m.y - current->pos.y;
    b.x = k[current->kno].p.x - current->pos.x;
    b.y = k[current->kno].p.y - current->pos.y;
    if( (COSV( a, b ) > 0.99) || (sqrt(DIFF( posl[i].p.x - k[current->kno].p.x,
     posl[i].p.y - k[current->kno].p.y )) < (RADIUSL+2.0*RADIUS)/DIFFX) )
     {
      if( color ) lineRGBA( display, x, y, posl[i].m.x*DIFFX+LEFT, 
			    posl[i].m.y*DIFFX+UP, 0,0,0,255);
      else lineRGBA( display, x, y, posl[i].m.x*DIFFX+LEFT, 
		     posl[i].m.y*DIFFX+UP, 0,128,0,255);
      break;
     }
   }
  SDL_Flip(display);
 }

void computer_stoss( void )
/* Der eigentliche Computer-"Spieler", hier werden die obigen Prozeduren
   benötigt... */
 {
 struct vect v, v1, v2;
 int j, ende=0, color=0, ok = -10;
 double dummy, dummy2;
 struct target *dum, *best_dum = NULL;
 char out[80];
 set_spin( 0.0, 0.0, 0.0 );
 wink( alph=0.0 );
 old_ball = -1;
 old_hole = -1;
 old_min = 0.0001;
 t.next = NULL; /* t: Kopf der "target-Liste" */
 if( anstoss )
  {
  mouse_off();
  k[WHITE].p.x = 0.25;
  k[WHITE].p.y = 0.5 - (RADIUS+1)/DIFFX;
  v.x = k[WHITE-1].p.x - k[WHITE].p.x;
  v.y = k[WHITE-1].p.y - k[WHITE].p.y;
  dummy = BETR( v );
  k[WHITE].v.x = v.x / (dummy * DIFFX);
  k[WHITE].v.y = v.y / (dummy * DIFFX);
  k[WHITE].stat = 0;
  speed( spd = 1 );
  set_spin( 0.0, -0.67, 0.0 );
  wink( alph = 0 );
  plot_balls(1);
  debug("full-power first one...");
  wait_user_time( 2.0/3.0 );
  return;
  }
 mark_combi();
 if( t.next != NULL ) /* d.h., es gibt anspielbare Kugeln ! */
  {
   dum = t.next;
   do
    {
     v.x = k[WHITE].p.x;
     v.y = k[WHITE].p.y;
     color = k[dum->kno].col;
     if( (color == ply[cur].col) || (!ply[cur].col && ( color != 3 )) 
         || freeball )
      if( !in_line_c( dum->kno, dum->kno, v, dum->pos, 0, 0 ) )
       {
        v1.x = dum->pos.x - v.x;
        v1.y = dum->pos.y - v.y;
        v2.x = k[dum->kno].p.x - dum->pos.x;
        v2.y = k[dum->kno].p.y - dum->pos.y;
	if( ((dummy2=COSV( v1, v2 )) > 0.1) && ( old_min < ( dummy2 *
	 (dum->angle) ) ) )
         {
#ifdef HOLE_INLINE
	  Abfrage, ob Weiße ins Loch fällt !!! !!! !!! ist noch arg
	  verbesserungsbedürftig, muß noch die Rest-Geschw. der Weißen nach
	  dem Stoß miteinbeziehen !!!  
	  struct vect v3, v4, v5;
	  v3.x = k[dum->kno].p.x - dum->pos.x;
	  v3.y = k[dum->kno].p.y - dum->pos.y;
	  dummy = BETR( v3 ); / if != 0, (naja) /
	  v3.x /= dummy; v3.y /= dummy;
	  v4.x = dum->pos.x - k[WHITE].p.x; v4.y = dum->pos.y - k[WHITE].p.y;
	  dummy = BETR( v4 );
	  v4.x /= dummy; v4.y /= dummy;
	  v5.x = (dummy3=SKALP( v3, v4 )) * v3.x; 
	  v5.y = dummy3 * v3.y;
	  v4.x -= v5.x; v4.y -= v5.y;
	  dummy = BETR( v4 );
	  v4.x /= dummy; v4.y /= dummy;
	  if( !(hole_inline( v4, dum->pos ) && dummy2 < 0.85 ) )
#endif
           {
	    old_min = dummy2 * (dum->angle);
            best_dum = dum;
           }
#ifdef HOLE_INLINE
          else /*"Weiße wäre reingegegangen !!!" */ {}
#endif
         }
       }
     if( dum->next == NULL ) ende = 1;
     else dum = dum->next;
    }
   while( !ende );
  }
 /* So... der beste Stoß verläuft nun in Richtung best_dum ..... */   
 if( best_dum != NULL )
 /* Man müßte noch testen, ob sich eine der Konigs-Kugelbanden im Weg einer
    Kugel befindet ... !!! !!! !!! */
  {
   if( best_dum->ord == 0) sprintf(out,"will be a normal shot...");
   else sprintf(out, "o.k., this will be a 'Combi' with %d Balls",
		best_dum->ord+1);
   debug(out);
   v1.x = best_dum->pos.x - v.x;
   v1.y = best_dum->pos.y - v.y;
   v2.x = k[best_dum->kno].p.x - best_dum->pos.x;
   v2.y = k[best_dum->kno].p.y - best_dum->pos.y;
   /* Hier wird's viel zuviel, da die GESAMTE bisherige Strecke durch den
      Kosinus geteilt wird !!! !!! !!! */
   if( (dummy2 = COSV( v1, v2 )) )
    dummy = SET_V( BETR(v1), best_dum->spd / dummy2);
   else dummy = 100000.0;
   set_c_speed( dummy, v1 );
   plot_line( best_dum, 1 );
   if( 0 && ((c_player == -1) || (cur != c_player)) ) /* !?!?!?!?! */
    { 
     plot_targets();
    } /*  */
   else wait_user_time( 2.0/3.0 );
   plot_line( best_dum, 0 );
  }
 else
  {
   for( j=0;j<WHITE;j++)
    if( !k[j].stat && ( (k[j].col == ply[cur].col) 
     || ( !ply[cur].col && (j != BLACK) ) ) )
      {
       /* 1. Fall: einen Ball der akt.Farbe zentral treffen (safety-shot) */
       v.x = k[WHITE].p.x; v.y = k[WHITE].p.y; 
       v1.x = k[j].p.x - v.x; v1.y = k[j].p.y - v.y;
       if( (dummy = BETR( v1 )) ) { v2.x = v1.x/dummy; v2.y = v1.y/dummy; }
       else v2.x = v2.y = 0;
       v1.x = k[j].p.x - v2.x * 2.0*RADIUS/DIFFX;
       v1.y = k[j].p.y - v2.y * 2.0*RADIUS/DIFFX;
       /* obiges, da in in_line_c() wieder verlängert wird ... !! */
       if( !in_line_c( j, j, v, v1, 6, 0 ) ) { ok = 0; }
       if( ok == -10 ) /* 2. Fall, links am Rand ... */
        {
         v1.x = k[j].p.x; v1.y = k[j].p.y;
	 v2.x = v1.x - v.x; v2.y = v1.y - v.y;
	 if( (dummy = BETR( v2 )) ) { v2.x /= dummy; v2.y /= dummy; }
	 dummy = v2.x;
	 v1.x -= (2*RADIUS-1.0)/DIFFX * v2.y;
	 v1.y += (2*RADIUS-1.0)/DIFFX * v2.x;
         if( !in_line_c( j, j, v, v1, 6, 0 ) )  { ok = 1; }
	}
       if( ok == -10 ) /* 3. Fall: rechts am Rand... */
        {
         v1.x = k[j].p.x; v1.y = k[j].p.y;
	 v1.x += (2*RADIUS-1.0)/DIFFX * v2.y;
	 v1.y -= (2*RADIUS-1.0)/DIFFX * v2.x;
         if( !in_line_c( j, j, v, v1, 6, 0 ) )  { ok = -1; }
	}
       if( ok != -10 ) j = BALLS; /* ---> eigentlich break; */
      }
     if( ( ok == -10 ) && !freeball ) 
      {
       debug("I've no idea..."); /* Kein Ball "stoßbar" */
       /* Wenn der Computer schon foult, dann so, daß die Weiße hinter
       irgendeiner Kugel liegen bleibt ... */
       /* zuerst überprüfen, ob Weg zur Schwarzen frei! */
       v.x = k[BLACK].p.x - k[WHITE].p.x;
       v.y = k[BLACK].p.y - k[WHITE].p.y;
       if( (dummy = BETR( v )) ) { v2.x = v.x/dummy; v2.y = v.y/dummy; }
       else v2.x = v2.y = 0;
       v1.x = k[BLACK].p.x - v2.x * 2*RADIUS/DIFFX; 
       v1.y = k[BLACK].p.y - v2.y * 2*RADIUS/DIFFX;
       if( in_line_c( BLACK, BLACK, k[WHITE].p, v1, 0, 0 ) )
        { /* d.h., Weg zur Schwarzen ist nicht frei ! ... */
         dummy = 100000;
         for( j=0;j<WHITE;j++ )
	  if( !k[j].stat 
	   && (DIFF( k[j].p.x-k[WHITE].p.x, k[j].p.y-k[WHITE].p.y ) < dummy) )
 	   { dummy = DIFF( k[j].p.x-k[WHITE].p.x, k[j].p.y-k[WHITE].p.y ); 
	     color=j; }
         v.x = k[color].p.x - k[WHITE].p.x;
         v.y = k[color].p.y - k[WHITE].p.y;
        }
       set_c_speed( SET_V(BETR( v ) - (2.0*RADIUS)/DIFFX,0), v );
      }
     else /* if( ok ==-1,0,1), d.h. Ball kann getroffen werden */
      {
       if( ok == 0 ) debug("'safety-shot' <c>");
       else if( ok == -1 ) debug("'safety-shot' <l>");
       else if( ok == 1 ) debug("'safety-shot' <r>");
       v.x = v1.x - k[WHITE].p.x;  v.y = v1.y - k[WHITE].p.y;
       /* Geschwindigkeit wird bisher noch so gesetzt, daß in die aktuelle 
          Richtung einfach die Strecke 1 dazugezählt wird, was meistens einen
  	  viel zu festen "safety-shot" zur Folge hat, ÄNDERN !!! !!! !!! 
	  (ist inzwischen schon viel besser, prinz. aber verbessern) */
       set_c_speed(SET_V(BETR(v)+1.0+4.0*(ply[1-cur].wait!=0),0),v);
      }
    wait_user_time( 2.0/3.0 );
  }
 if( t.next != NULL ) delete_targets( t.next );
 }

void calc_hot_spot( void )
 { /* Mittelpunkte der Löcher, zum Zielen für den Computer-Gegner */
 posl[0].m.x = (ban[1].p0.x+RADIUS-1)/DIFFX;		/* Loch l. unten */
 posl[0].m.y = (ban[10].p0.y-RADIUS+1)/DIFFX; 
 posl[1].m.x = (ban[1].p0.x+RADIUS)/DIFFX;		/* links oben */
 posl[1].m.y = (ban[7].p0.y+RADIUS+0.5)/DIFFX;
 posl[2].m.x = (ban[8].p1.x+ban[12].p0.x)/(2.0*DIFFX);	/* Mitte oben */
 posl[2].m.y = posl[2].p.y + (RADIUSL-1.5)/DIFFX;
 posl[3].m.x = (ban[4].p1.x-RADIUS)/DIFFX;		/* rechts oben */
 posl[3].m.y = (ban[13].p1.y+RADIUS+0.5)/DIFFX;
 posl[4].m.x = (ban[4].p0.x-RADIUS+1)/DIFFX;		/* rechts unten */
 posl[4].m.y = (ban[16].p0.y-RADIUS+1)/DIFFX;
 posl[5].m.x = (ban[9].p0.x+ban[17].p1.x)/(2.0*DIFFX);	/* Mitte unten */
 posl[5].m.y = posl[5].p.y - (RADIUSL-1.5)/DIFFX;
 }

void wait_user_time( double time )
 { /* wartet time Sekunden */ 
 SDL_Event event;
 SDL_PollEvent(&event);
 if( demo ) time /= 2.0;
 if( event.type == SDL_QUIT ) stop_it();
 else if( event.type == SDL_MOUSEBUTTONUP ) demo=0;
 else if( event.type == SDL_KEYDOWN )
  {
  if( event.key.keysym.sym == SDLK_ESCAPE )
    stop_it();
  if( event.key.keysym.sym == SDLK_SPACE ) demo=0;
  }
 if( !demo ) msg("demo will stop after current turn");
 SDL_Delay(time*1000);
 }
