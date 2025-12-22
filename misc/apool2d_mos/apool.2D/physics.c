/* This is "physics.c", part of of the pool (billiards)-program
                   
                     "ANOTHER POOL".

   "physics.c" includes the 'physics' of the game, such as the 
   collision of the balls, the reflection on the walls, ...

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

/* ------------------------------ physics.c ------------------------------ */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "apool.h"
#include <SDL.h>

int old_timer;

void translate_spin( void ) 
/* Nachdem die Richtung der Geschw. feststeht, wird der Spin, der bisher im
   lokalen Koordinatensystem der Kugel festgelegt war auf globale (x,y)-
   Koordinaten umgerechnet. Das ist wichtig, da sich das lokale KS drehen
   kann, da auch "Curve-Balls" möglich sind... */
 {
 double puffer, dummy=0;  /* k.e.x : senkr., k.e.y: parall. zu k.v(x,y) !!! */
 struct vect s, add = { 0, 0 };
 if( alph )
  {
  /* senkr. Vektor zu v bestimmen: warum: s. unten */
  s.x = -k[WHITE].v.y; s.y = k[WHITE].v.x;
  if( (dummy = BETR( s )) )
   {
    s.x /= dummy; s.y /= dummy;
    dummy = sin( alph * M_PI / 180.0 );
    add.x = - s.x * dummy * k[WHITE].ez / DIFFX / CURVES;
    add.y = - s.y * dummy * k[WHITE].ez / DIFFX / CURVES;
   }
  s.x = k[WHITE].v.x; s.y = k[WHITE].v.y;
  if( (dummy = BETR( s )) ) /* dummy = dasselbe wie oben !!! !!! !!!*/
   {
   s.x /= dummy; s.y /= dummy;
   dummy = sin( alph * M_PI / 180.0 );
   add.x += s.x * dummy * k[WHITE].e.y / DIFFX / CURVEP;
   add.y += s.y * dummy * k[WHITE].e.y / DIFFX / CURVEP;
   }
  }
 /* bis hier wurde das "Ausbrechen" des weißen Balls beim Curve-Ball,
    also die Zusatzgeschw., die der Ball durch den nicht mittigen Treffpkt
    bekommt, wenn der Queue noch dazu nicht parallel zum Tisch steht, 
    berechnet. jetzt kommt der "normale" Spin ... */
 if( (k[WHITE].v.x ) || (k[WHITE].v.y ) )
  {		/* zuerst: k[WHITE].ez umwandeln in x- und y-  Spin */
  dummy = ( k[WHITE].ez*sin( M_PI*alph/180.0) ) / 
   sqrt(k[WHITE].v.x*k[WHITE].v.x + k[WHITE].v.y*k[WHITE].v.y);
  }
 puffer = k[WHITE].e.y;
 k[WHITE].e.x = -k[WHITE].v.x * dummy;
 k[WHITE].e.y = -k[WHITE].v.y * dummy; 
 if( k[WHITE].v.x || k[WHITE].v.y ) dummy = puffer / BETR( k[WHITE].v );
 else dummy = 0;
 k[WHITE].e.y -= k[WHITE].v.x * dummy; 
 k[WHITE].e.x += k[WHITE].v.y * dummy; 
 k[WHITE].ez *= cos( M_PI*alph/180.0);
 k[WHITE].e.x /= (RADIUS * DIFFX);
 k[WHITE].e.y /= (RADIUS * DIFFX);
 k[WHITE].v.x += add.x;
 k[WHITE].v.y += add.y;
}

void refl_kk( int n, struct vect p)   
/* Kollisionsberechnugn zw. Kugeln und der Königsbande, die als infinitesimale
   Kugel an der jeweiligen Stelle angenommen wird, so daß prinzipiell
   jeder Abprall-Winkel an diese Bande möglich ist, Die Berechnung erfolgt 
   ähnlich wie der Stoß zwischen zwei Kugeln (s. coll() ) und ansonsten analog
   zu reflection() ... */
 {
 struct vect ab; /* ab := Abstandsvektor zw. den Mittelpunkten */
 double dummy, dv;
 ab.x = (k[n].p.x*DIFFX-p.x); ab.y = (k[n].p.y*DIFFX-p.y); 
 ab.x /= (dummy = BETR( ab )); /* Abfrage, ob dummy != 0 ??? !!! !!! !!!*/
 ab.y /= dummy;
 if( (ab.x*k[n].v.x+ab.y*k[n].v.y) >= 0 ) return;
 /* Berechnung der Geschwindigkeit der Kugel nach der Kollision */       
 dummy = (k[n].v.x * ab.x + k[n].v.y * ab.y);
 dv = BANDES * k[n].ez;
 k[n].v.x -= dummy * (2*BANDEREF * ab.x + ab.y * dv );
 k[n].v.y -= dummy * (2*BANDEREF * ab.y - ab.x * dv );
  dv *= BANDEZ / BANDES; /* damit Energie bei Relfexion verloren geht... ! */
 k[n].ez -= (((k[n].ez > 0)<<1)-1) * fabs((k[n].ez - sqrt( k[n].ez*k[n].ez 
   + 4.0/(5.0*RADIUS*RADIUS) * BETR( k[n].v ) * dv - dv*dv )));
 dummy = ab.x;
 ab.x = -ab.y;
 ab.y = dummy;
 dummy = SKALP( k[n].e, ab );
 k[n].e.x -= ab.x * dummy * GAMMA;
 k[n].e.y -= ab.y * dummy * GAMMA;
 k[n].e.x *= BANDEREF;
 k[n].e.y *= BANDEREF;
 bande_hit = 1;
 }

void coll( int a, int b) 
/* Stoß: Kollisionsberechnung zwischen den Kugeln a und b. Dabei wird die
   Masse der jeweiligen Kugel berücksichtigt, da die Weiße wohl manchmal
   schwerer ist. */
 { 
 struct vect ab, v; /* ab := Abstandsvektor zw. den Mittelpunkten */
 double dummy, dummy2;
 /* Abfrage, ob Kugeln kollidieren dürfen. Das ist der Fall, wenn der
    Winkel zwischen Relativgeschw. und Abst.vektor < 90° ist */
 if( ( (ab.x = k[a].p.x-k[b].p.x) * (v.x=k[a].v.x-k[b].v.x) +
       (ab.y = k[a].p.y-k[b].p.y) * (v.y=k[a].v.y-k[b].v.y) ) >= 0 )
        return;
 /* Abstand i.allg. zu klein (wg. Zeitschritten) -> Korrektur: */
 dummy2 = SKALP( ab, v ) / SKALP( v, v );
 dummy = ( SKALP( ab, ab ) - 4*RADIUS*RADIUS/(DIFFX*DIFFX) )
  / SKALP( v, v );
 dummy2 += sqrt( dummy2 * dummy2 - dummy );
 k[a].p.x -= k[a].v.x * dummy2;
 k[a].p.y -= k[a].v.y * dummy2;
 k[b].p.x -= k[b].v.x * dummy2;
 k[b].p.y -= k[b].v.y * dummy2;
 ab.x = k[a].p.x - k[b].p.x;
 ab.y = k[a].p.y - k[b].p.y;
 /* Ende (vorerst (s.u.)) der "zu kleinen Abstands-korrektur" */
 dummy = BETR( ab );  /* ab = abst-vektor normieren */
 ab.x /= dummy;
 ab.y /= dummy;
 /* Abnahme des z-Spins, wenn Kugeln stoßen (gibt's, aber anders, eigentlich 
    erhält die gestoßene Kugel einen (sehr kleinen) Teil des z-Spins der
    Stoßenden ...) */
/* if( k[a].ez && (k[a].v.x || k[a].v.y) )
  k[a].ez *= (ab.x * k[a].v.x + ab.y * k[a].v.y) /  
   sqrt(k[a].v.x*k[a].v.x + k[a].v.y*k[a].v.y) * SPINC * 1 ! ;
 if( k[b].ez && (k[b].v.x || k[b].v.y) )
  k[b].ez *= (ab.x * k[b].v.x + ab.y * k[b].v.y) / 
   sqrt(k[b].v.x*k[b].v.x + k[b].v.y*k[b].v.y) * SPINC  ;*/
 /* Berechnung der Geschwindigkeit der Kugeln nach der Kollision: */
 dummy = (k[a].v.x - k[b].v.x) * ab.x + (k[a].v.y - k[b].v.y) * ab.y;
 k[a].v.x -= (2.0*k[b].m/(k[a].m+k[b].m)) * ab.x * dummy; /* mit untersch.  */
 k[a].v.y -= (2.0*k[b].m/(k[a].m+k[b].m)) * ab.y * dummy; /* MASSEN der Kug,*/
 k[b].v.x += (2.0*k[a].m/(k[a].m+k[b].m)) * ab.x * dummy;
 k[b].v.y += (2.0*k[a].m/(k[a].m+k[b].m)) * ab.y * dummy;
 /* Zeitschritt (s.o.) wieder hinzuzählen ... */
 k[a].p.x += k[a].v.x * dummy2;
 k[a].p.y += k[a].v.y * dummy2;
 k[b].p.x += k[b].v.x * dummy2;
 k[b].p.y += k[b].v.y * dummy2;
 if( !first_hit ) /* Überprüfen, ob Foul durch falsches Anspielen */
  { 
  if( a != WHITE ) first_hit = k[a].col; /* eigentlich albern, da WEISSE */
  else first_hit = k[b].col;               /* = letzte Kugel in Reihe...   */
  if( !freeball && ((ply[cur].col && (first_hit != ply[cur].col)) 
   || ((!ply[cur].col) && (first_hit==COL_BLACK))) ) 
    ply[cur].stat |= FOUL_WRONG_COLOR_TOUCHED;
  }
 if( anstoss ) anstoss = 0; /* für Computer-Anstoss ... */
 }

void reflection( int n, int b ) 
/* Reflexion der Kugel n an der Bande b. Der Winkel, den die Bande hat, ist
   egal, es werden auch die schrägen Königsbanden berechnet. An den Banden
   ändert sich die senkrecht zur Bande stehende Geschwindigkeitskomponente der
   Kugel in 2*die entgegengesetzte Richtung. Desweiteren wirkt sich der
   z-Spin aus. Ein Problem bei den Banden besteht darin, daß Einfallswinkel
   NICHT gleich Ausfallswinkel ist, wodurch der Computer, wenn er über Banden
   spielen könne sollte, leichte Probleme bekommen könnte. */
 { 
 double dummy, dv;
 struct vect g;
 /* 1. Anteil senkrecht zur Bande, in Richtung des "Normalen-Vektors" ber. */
 dummy = SKALP( k[n].v, ban[b].n );
 /* Geschw. nach Reflexion, ein Teil normale Reflexion, ohne Spin, zum anderen
    die Umsetzung des z-Spins i.Abh. von dummy */
 /* Die Wurzel müßte man noch durch einen eigenen Faktor ersetzen, Wurzel:
    verminderung der Rest-Geschw., BANDEREF: Verminderung der Geschw. 
    senkrecht  zur Bande. !!! */
 dv = BANDES * k[n].ez;
 k[n].v.x -= dummy * ( 2 * BANDEREF * ban[b].n.x + dv * ban[b].n.y );
 k[n].v.y -= dummy * ( 2 * BANDEREF * ban[b].n.y - dv * ban[b].n.x ); 
 dv *= BANDEZ / BANDES; /* damit Energie bei Reflexion verloren geht... ! */
 k[n].ez -= ((k[n].ez > 0) ? 1 : -1) * fabs((k[n].ez - sqrt( k[n].ez*k[n].ez 
   + 4.0/(5.0*RADIUS*RADIUS) * BETR( k[n].v ) * dv - dv*dv )));
 g.x = -ban[b].n.y;
 g.y = ban[b].n.x;
 dummy = SKALP( k[n].e, g );
 k[n].e.x -= g.x * dummy * GAMMA;
 k[n].e.y -= g.y * dummy * GAMMA;
 k[n].e.x *= BANDEREF;
 k[n].e.y *= BANDEREF;
 bande_hit = 1;
}

int in_line( int n, int b ) 
/* Überprüft, ob Mittelpt. der Kugel projeziert auf Banden-Gerade innerhalb 
   der beiden Grenzpunkte der Bande liegt und, ob der Abstand zwischen Bande
   und Kugel klein genug, ist, damit es zu einer Reflexion kommt ... */
 {
 struct vect kk, c;
 double t;
 c.x = ban[b].p0.x - ban[b].p1.x;
 c.y = ban[b].p0.y - ban[b].p1.y;
 t = - (c.x*(ban[b].p0.x-k[n].p.x*DIFFX) + c.y*(ban[b].p0.y-k[n].p.y*DIFFX)) /
       (c.x*c.x+c.y*c.y);
 kk.x = ban[b].p0.x + c.x * t;
 kk.y = ban[b].p0.y + c.y * t;
 return( (-c.x * (kk.x-ban[b].p0.x) >= 0) && (-c.y * (kk.y-ban[b].p0.y) >= 0)
  && (c.x * (kk.x-ban[b].p1.x) >= 0) && (c.y * (kk.y-ban[b].p1.y) >= 0) &&
  ( ((k[n].p.x*DIFFX-kk.x) * (k[n].p.x*DIFFX-kk.x) +
  (k[n].p.y*DIFFX-kk.y) * (k[n].p.y*DIFFX-kk.y)) <= (RADIUS)*(RADIUS) )); 
  /* oben: (RADIUS+0.5)^2 ??? !!! !!! !!! */
 }

void banden_test( void )  
 { /* Abfrage ob Kugeln Bande oder Löcher treffen ...  */ 
 int i, j;
 for(i=0;i<BALLS;i++)
  {
  /* Untenst. Abfrage kann man noch beschleunigen, indem man 1. die Abfrage
     bezgl. der großen Bande oben und unten in je zwei Teile links und rechts
     vom Mittelloch aufteilt und 2. die Königsbanden nicht mehr abfragt,
     wenn bereits eine Reflexion an einer "normalen", großen Bande statt-
     gefunden hat... Aber auch so ist diese Prozedur schon umständlich genug
     geschrieben ... (der Geschw. wegen) !!! !!! !!! */
  if( !k[i].stat && (k[i].v.x || k[i].v.y) )
   {
   if( (k[i].p.x <= (RADIUS+1)/DIFFX) ) /* Kugel links in Nähe von Bande */
    {
    for( j=0;j<=2;j++ ) /* Abfrage, ob Kugel refl. an "großer" Bande */
     if( ((k[i].v.x*ban[j].n.x + k[i].v.y*ban[j].n.y) <= 0) && in_line(i, j) )
      { reflection( i, j ); break; }
    /* Reflexion an einer "Kugelbande" */
    if( DIFF( k[i].p.x-ban[1].p1.x/DIFFX, k[i].p.y-ban[1].p1.y/DIFFX ) <=
     RADIUS*RADIUS/(DIFFX*DIFFX) ) refl_kk(i,ban[1].p1); 
    else if( DIFF( k[i].p.x-ban[1].p0.x/DIFFX, k[i].p.y-ban[1].p0.y/DIFFX ) <=
     RADIUS*RADIUS/(DIFFX*DIFFX)) refl_kk(i,ban[1].p0);
    /* Kugel in Loch, das zu den entspr. Banden gehört ? */
    for(j=0;j<=1;j++)
     if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y) < 
      RADIUSL*RADIUSL/(DIFFX*DIFFX)) { delete_ball( i ); break; }
    }
   else if( k[i].p.x >= (DIFFX-RADIUS-1)/DIFFX ) /* Kugel rechts */
    {
     for( j=3;j<=5;j++ )
      if(((k[i].v.x*ban[j].n.x + k[i].v.y*ban[j].n.y) <= 0) && in_line( i, j))
       { reflection( i, j ); break; }
     if( DIFF( k[i].p.x-ban[4].p1.x/DIFFX, k[i].p.y-ban[4].p1.y/DIFFX ) <=
      RADIUS*RADIUS/(DIFFX*DIFFX) ) refl_kk(i,ban[4].p1); 
     else if( DIFF( k[i].p.x-ban[4].p0.x/DIFFX, k[i].p.y-ban[4].p0.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX)) refl_kk(i,ban[4].p0);
    for(j=3;j<=4;j++)
     if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y)
      < RADIUSL*RADIUSL/(DIFFX*DIFFX)) { delete_ball( i ); break; }
    }
   }
  if( !k[i].stat && (k[i].v.x || k[i].v.y) )
   {
   if( (k[i].p.y <= (RADIUS+1)/DIFFX) ) /* Kugel oben */
    {
     for( j=6;j<=8;j++ ) /* geht was nicht !!! !!! !!! */
      { 
       if(((k[i].v.x*ban[j].n.x + k[i].v.y*ban[j].n.y)<=0) && in_line( i, j))
        { reflection( i, j ); break; }
       else if(((k[i].v.x*ban[j+6].n.x + k[i].v.y*ban[j+6].n.y)<=0) 
        && in_line(i, j+6)) { reflection( i, j+6 ); break; }
      }
     if( DIFF( k[i].p.x-ban[7].p1.x/DIFFX, k[i].p.y-ban[7].p1.y/DIFFX ) 
      <= RADIUS*RADIUS/(DIFFX*DIFFX) ) refl_kk(i,ban[7].p1); 
     else if( DIFF( k[i].p.x-ban[7].p0.x/DIFFX, k[i].p.y-ban[7].p0.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX)) refl_kk(i,ban[7].p0);
     else if( DIFF( k[i].p.x-ban[13].p1.x/DIFFX, k[i].p.y-ban[13].p1.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX) ) refl_kk(i,ban[13].p1); 
     else if( DIFF( k[i].p.x-ban[13].p0.x/DIFFX, k[i].p.y-ban[13].p0.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX)) refl_kk(i,ban[13].p0);
     for(j=1;j<=3;j++)
      if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y) < 
       RADIUSL*RADIUSL/(DIFFX*DIFFX)) { delete_ball( i ); break; }
    }
   else if( k[i].p.y >= (DIFFX/2-RADIUS-1)/DIFFX ) /* Kugel unten */
    {
     for( j=9;j<=11;j++ )
      { 
       if(((k[i].v.x*ban[j].n.x + k[i].v.y*ban[j].n.y)<=0) && in_line( i, j)) 
        { reflection( i, j ); break; }
       else if(((k[i].v.x*ban[j+6].n.x + k[i].v.y*ban[j+6].n.y)<=0) 
        && in_line(i, j+6) ) { reflection( i, j+6 ); break; }
      }
     if( DIFF( k[i].p.x-ban[10].p1.x/DIFFX, k[i].p.y-ban[10].p1.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX) ) refl_kk(i,ban[10].p1); 
     else if( DIFF( k[i].p.x-ban[10].p0.x/DIFFX, k[i].p.y-ban[10].p0.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX)) refl_kk(i,ban[10].p0);
     else if( DIFF( k[i].p.x-ban[16].p1.x/DIFFX, k[i].p.y-ban[16].p1.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX) ) refl_kk(i,ban[16].p1); 
     else if( DIFF( k[i].p.x-ban[16].p0.x/DIFFX, k[i].p.y-ban[16].p0.y/DIFFX )
      <= RADIUS*RADIUS/(DIFFX*DIFFX)) refl_kk(i,ban[16].p0);
     for(j=4;j<=5;j++)
      if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y) < 
       RADIUSL*RADIUSL/(DIFFX*DIFFX)) { delete_ball( i ); break; }
     if(DIFF(posl[0].p.x-k[i].p.x,posl[0].p.y-k[i].p.y) < 
      RADIUSL*RADIUSL/(DIFFX*DIFFX)) delete_ball( i );
    }
   }
  }
 }
 
int move_balls( void ) 
/* Die Bewegung der Bälle mit Reibung, Effet, Umwandlung von Translations-
   in Rotationsenergie, Umwandlung von Spin in Geschwindigkeit, etc.... */
 {
  int i, nomove = 0;
  double dummy, test, betr_v;
  struct vect d_v, diff, v_trans, v_rot;
  re_init_timer();
  for(i=0;i<BALLS;i++)
   {
   if( !k[i].stat )
    {
    if( k[i].v.x || k[i].v.y || k[i].e.x || k[i].e.y || k[i].ez )
     {
      k[i].nopaint = 0;
      diff.x = (v_rot.x = k[i].e.x) - (v_trans.x = -k[i].v.y/RADIUS);
      diff.y = (v_rot.y = k[i].e.y) - (v_trans.y = k[i].v.x/RADIUS);
      if( diff.x || diff.y )
       {
        test = BETR( diff );
        if( test < ALPHA )
         { /* das funktioniert ganz gut ! */
          k[i].e.x -= diff.x * 2.0/7.0;
	  k[i].e.y -= diff.y * 2.0/7.0;
	  k[i].v.x += diff.y * 5.0/7.0 * RADIUS;
 	  k[i].v.y -= diff.x * 5.0/7.0 * RADIUS;
 	 }
        else   
         {
	  dummy = ALPHA / test;
          k[i].e.x -= (d_v.x = diff.x * dummy);
          k[i].e.y -= (d_v.y = diff.y * dummy);
 	  if( d_v.x || d_v.y )
 	   {
	    dummy = -0.5*( betr_v = BETR( k[i].v ) );
            test = dummy*dummy - RADIUS*RADIUS/5.0 * 
	     ( SKALP( d_v, d_v ) - 2.0*SKALP( d_v, k[i].e ) );
	    dummy += sqrt( fabs(test) );
	    dummy /= BETR( d_v );
            dummy = fabs(dummy);
            if( fabs( k[i].e.x )*RADIUS > fabs( k[i].v.y ) )
   	     k[i].v.x -= -d_v.y * dummy * ETA;
            else k[i].v.x -= -d_v.y * dummy;
            if( fabs( k[i].e.y )*RADIUS > fabs( k[i].v.x ) )
   	     k[i].v.y -= d_v.x * dummy * ETA;
            else k[i].v.y -=  d_v.x * dummy;
       	   }
         }
       }
      if( k[i].v.x || k[i].v.y )
       {
        dummy = DELTA / BETR( k[i].v );
        if( dummy >= 1 ) k[i].v.x = k[i].v.y = 0;
        else
	 {
          k[i].v.x -= k[i].v.x * dummy;
          k[i].v.y -= k[i].v.y * dummy;
	 }
       }
      if( k[i].e.x || k[i].e.y )
       {
        dummy = DELTA / ( BETR( k[i].e ) * RADIUS );
        if( dummy >= 1.0 ) k[i].e.x = k[i].e.y = 0;
        else
	 {
          k[i].e.x -= k[i].e.x * dummy;
          k[i].e.y -= k[i].e.y * dummy;
	 }
       }
      k[i].p.x += k[i].v.x;		/* Eigentliche Bewegung der Kugel */
      k[i].p.y += k[i].v.y;
      /* Abnahme von ez durch Bohrreibung! */
      if( fabs(k[i].ez) > BETA )  k[i].ez += (k[i].ez > 0) ? -BETA : BETA;
      else k[i].ez = 0.0;
     }
    else { k[i].nopaint = 1; nomove++; }
    }
   else nomove++;
   }
  if( (++counter > STEP ) )
   {
   int dummy = timer();
   if( dummy < old_timer + TIME_STEP )
       SDL_Delay( old_timer + TIME_STEP - dummy );
   re_init_timer();
   plot_balls(0);
   counter = 0; 
   }            
 return nomove; /* Gibt an, wieviele Kugeln sich nicht mehr bewegen */
}

void stoss( void )   
/* Der eigentliche Stoß, mit den Werten, die entweder der Spieler via Mouse
   oder der Computergegener hinsichtlich der Stoß-Geschwindigkeit (Betrag
   und Richtung, Effet) liefert, wird die Weiße losgelassen und die
   Kollisionen zwischen Kugeln und zw. Kugeln und Banden abgefragt... */
 {
  int i,j;
  save_current_position(); 
  translate_spin();
  ply[cur].speed = spd;
  counter = 0;
 smile( 1 );
  do
   {
    banden_test();
    for( i=0;i<BALLS;i++) /* Abfrage nach "potentieller" Kollision, d.h. */
     for(j=i;j<BALLS;j++) /* ob Abstand zw. Kugel i u. j klein genug !! */
      if( (j != i) && (!k[i].stat) && (!k[j].stat) &&
       (DIFF( k[i].p.x-k[j].p.x, k[i].p.y-k[j].p.y ) <= 
        4.0*RADIUS/DIFFX*RADIUS/DIFFX))
        coll( i, j ); 
   } 
  while( move_balls() < BALLS ); /* solange sich noch Bälle bewegen */
  plot_pockets();
  plot_balls(1);
  smile( 0 );
 }


unsigned long timer(void)
{
    return SDL_GetTicks();
}

void init_timer(void)
{
    old_timer = SDL_GetTicks();
}

void re_init_timer(void)
{
    old_timer = SDL_GetTicks();
}
