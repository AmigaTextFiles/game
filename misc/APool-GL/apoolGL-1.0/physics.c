/* This is "physics.c", part of of the pool (billiards)-program
                   
                     "Another Pool GL".

   "physics.c" includes the 'physics' of the game, such as the 
   collision of the balls, the reflection on the walls, ...

   Copyright (C) 1995,2002 by Gerrit Jahn (http://www.planetjahn.de)

	 This file ist part of Another Pool / Another Pool GL (apool, apoolGL).

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

/* ------------------------------ physics.c ------------------------------ */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <SDL/SDL.h>
#include <GL/gl.h>
#include "apool.h"

void translate_spin( void ) 
/* Nachdem die Richtung der Geschw. feststeht, wird der Spin, der bisher im
   lokalen Koordinatensystem der Kugel festgelegt war auf globale (x,y)-
   Koordinaten umgerechnet. Das ist wichtig, da sich das lokale KS drehen
   kann, da auch "Curve-Balls" möglich sind... */
 {
 double puffer, dummy=0;  /* k.e.x : senkr., k.e.y: parall. zu k.v(x,y) !!! */
 struct vect3 s, add = { 0, 0 };
 if( alph )
  {
  /* senkr. Vektor zu v bestimmen: warum: s. unten */
  s.x = -k[WHITE].v.y; s.y = k[WHITE].v.x;
  if( (dummy = BETR( s )) )
   {
    s.x /= dummy; s.y /= dummy;
    dummy = sin( alph * M_PI / 180.0 );
    add.x = - s.x * dummy * k[WHITE].e.z / DIFFX / CURVES;
    add.y = - s.y * dummy * k[WHITE].e.z / DIFFX / CURVES;
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
  {		/* zuerst: k[WHITE].e.z umwandeln in x- und y-  Spin */
  dummy = ( k[WHITE].e.z*sin( M_PI*alph/180.0) ) / 
   sqrt(k[WHITE].v.x*k[WHITE].v.x + k[WHITE].v.y*k[WHITE].v.y);
  }
 puffer = k[WHITE].e.y;
 k[WHITE].e.x = -k[WHITE].v.x * dummy;
 k[WHITE].e.y = -k[WHITE].v.y * dummy; 
 if( k[WHITE].v.x || k[WHITE].v.y ) dummy = puffer / BETR( k[WHITE].v );
 else dummy = 0;
 k[WHITE].e.y -= k[WHITE].v.x * dummy; 
 k[WHITE].e.x += k[WHITE].v.y * dummy; 
 k[WHITE].e.z *= -cos( M_PI*alph/180.0); /* "-" modified by gj */
 k[WHITE].e.x /= (PIXELRADIUS * DIFFX);
 k[WHITE].e.y /= (PIXELRADIUS * DIFFX);
 k[WHITE].v.x += add.x;
 k[WHITE].v.y += add.y;
/*  k[WHITE].e.z = 0; /\* modified gj 2002/09/20 *\/ */
}

void refl_kk( int n, struct vect3 p)   
/* Kollisionsberechnugn zw. Kugeln und der Königsbande, die als infinitesimale
   Kugel an der jeweiligen Stelle angenommen wird, so daß prinzipiell
   jeder Abprall-Winkel an diese Bande möglich ist, Die Berechnung erfolgt 
   ähnlich wie der Stoß zwischen zwei Kugeln (s. coll() ) und ansonsten analog
   zu reflection() ... */
 {
 struct vect3 ab; /* ab := Abstandsvektor zw. den Mittelpunkten */
 double dummy, dv;
 ab.x = (k[n].p.x*DIFFX-p.x); ab.y = (k[n].p.y*DIFFX-p.y); 
 ab.x /= (dummy = BETR( ab )); /* Abfrage, ob dummy != 0 ??? !!! !!! !!!*/
 ab.y /= dummy;
 if( (ab.x*k[n].v.x+ab.y*k[n].v.y) >= 0 ) return;
 /* Berechnung der Geschwindigkeit der Kugel nach der Kollision */       
 dummy = (k[n].v.x * ab.x + k[n].v.y * ab.y);
 dv = BANDES * k[n].e.z * 0.0; /* modified gj 2002/09/20 */
 k[n].v.x -= dummy * (2*BANDEREF * ab.x + ab.y * dv );
 k[n].v.y -= dummy * (2*BANDEREF * ab.y - ab.x * dv );
  dv *= BANDEZ / BANDES; /* damit Energie bei Relfexion verloren geht... ! */
  k[n].e.z -= ( k[n].e.z > 0 ? 1 : -1) * fabs((k[n].e.z - sqrt( k[n].e.z*k[n].e.z 
   + 4.0/(5.0*PIXELRADIUS*PIXELRADIUS) * BETR( k[n].v ) * dv - dv*dv )));
/*   k[n].e.z = 0.0; /\* modified gj 2002/09/20 *\/ */
 dummy = ab.x;
 ab.x = -ab.y;
 ab.y = dummy;
 dummy = SKALP( k[n].e, ab );
 k[n].e.x -= ab.x * dummy * GAMMA;
 k[n].e.y -= ab.y * dummy * GAMMA;
 k[n].e.x *= BANDEREF;
 k[n].e.y *= BANDEREF;
 bande_hit = 1;
 calc_rotation(n);
 }

void coll( int a, int b) 
/* Stoß: Kollisionsberechnung zwischen den Kugeln a und b. Dabei wird die
   Masse der jeweiligen Kugel berücksichtigt, da die Weiße wohl manchmal
   schwerer ist. */
 { 
 struct vect3 ab, v; /* ab := Abstandsvektor zw. den Mittelpunkten */
 double dummy, dummy2;
 /* Abfrage, ob Kugeln kollidieren dürfen. Das ist der Fall, wenn der
    Winkel zwischen Relativgeschw. und Abst.vektor < 90° ist */
 if( ( (ab.x = k[a].p.x-k[b].p.x) * (v.x=k[a].v.x-k[b].v.x) +
       (ab.y = k[a].p.y-k[b].p.y) * (v.y=k[a].v.y-k[b].v.y) ) >= 0 )
        return;
 /* Abstand i.allg. zu klein (wg. Zeitschritten) -> Korrektur: */
 dummy2 = SKALP( ab, v ) / SKALP( v, v );
 dummy = ( SKALP( ab, ab ) - 4*RADIUS*RADIUS) / SKALP( v, v );
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
/* if( k[a].e.z && (k[a].v.x || k[a].v.y) )
  k[a].e.z *= (ab.x * k[a].v.x + ab.y * k[a].v.y) /  
   sqrt(k[a].v.x*k[a].v.x + k[a].v.y*k[a].v.y) * SPINC * 1 ! ;
 if( k[b].e.z && (k[b].v.x || k[b].v.y) )
  k[b].e.z *= (ab.x * k[b].v.x + ab.y * k[b].v.y) / 
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
 calc_rotation(a);
 calc_rotation(b);
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
 struct vect3 g;
 if( k[n].stat & FALLING )
  {
  k[n].v.x *= 0.95;  
  k[n].v.y *= 0.95;
  }
 else
  {
  /* 1. Anteil senkrecht zur Bande, in Richtung des "Normalen-Vektors" ber. */
  dummy = SKALP( k[n].v, banpixel[b].n );
  /* Geschw. nach Reflexion, ein Teil normale Reflexion, ohne Spin, zum anderen
     die Umsetzung des z-Spins i.Abh. von dummy */
  /* Die Wurzel müßte man noch durch einen eigenen Faktor ersetzen, Wurzel:
     verminderung der Rest-Geschw., BANDEREF: Verminderung der Geschw. 
     senkrecht  zur Bande. !!! */
  dv = BANDES * k[n].e.z /* * 0.0 */; /* modified gj 2002/09/20 */
  k[n].v.x -= dummy * ( 2 * BANDEREF * banpixel[b].n.x + dv * banpixel[b].n.y );
  k[n].v.y -= dummy * ( 2 * BANDEREF * banpixel[b].n.y - dv * banpixel[b].n.x ); 
  dv *= BANDEZ / BANDES; /* damit Energie bei Reflexion verloren geht... ! */
  k[n].e.z -= ((k[n].e.z > 0) ? 1 : -1) * 
    fabs((k[n].e.z - sqrt( k[n].e.z*k[n].e.z + 4.0/(5.0*PIXELRADIUS*PIXELRADIUS) * BETR( k[n].v ) * dv - dv*dv )));
  /*  k[n].e.z = 0.0;  /\* modified gj 2002/09/20 *\/ */
  g.x = -banpixel[b].n.y;
  g.y = banpixel[b].n.x;
  dummy = SKALP( k[n].e, g );
  k[n].e.x -= g.x * dummy * GAMMA;
  k[n].e.y -= g.y * dummy * GAMMA;
  k[n].e.x *= BANDEREF;
  k[n].e.y *= BANDEREF;
  bande_hit = 1;
  calc_rotation(n);
  }
 }

int in_line( int n, int b ) 
/* Überprüft, ob Mittelpt. der Kugel projeziert auf Banden-Gerade innerhalb 
   der beiden Grenzpunkte der Bande liegt und, ob der Abstand zwischen Bande
   und Kugel klein genug, ist, damit es zu einer Reflexion kommt ... */
 {
 struct vect3 kk, c;
 double t;
 c.x = banpixel[b].p0.x - banpixel[b].p1.x;
 c.y = banpixel[b].p0.y - banpixel[b].p1.y;
 t = - (c.x*(banpixel[b].p0.x-k[n].p.x*DIFFX) + c.y*(banpixel[b].p0.y-k[n].p.y*DIFFX)) /
       (c.x*c.x+c.y*c.y);
 kk.x = banpixel[b].p0.x + c.x * t;
 kk.y = banpixel[b].p0.y + c.y * t;
 return( (-c.x * (kk.x-banpixel[b].p0.x) >= 0) && (-c.y * (kk.y-banpixel[b].p0.y) >= 0)
  && (c.x * (kk.x-banpixel[b].p1.x) >= 0) && (c.y * (kk.y-banpixel[b].p1.y) >= 0) &&
  ( ((k[n].p.x*DIFFX-kk.x) * (k[n].p.x*DIFFX-kk.x) +
  (k[n].p.y*DIFFX-kk.y) * (k[n].p.y*DIFFX-kk.y)) <= (PIXELRADIUS)*(PIXELRADIUS) )); 
  /* oben: (PIXELRADIUS+0.5)^2 ??? !!! !!! !!! */
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
  if( (k[i].stat & ONTABLE) && (k[i].v.x || k[i].v.y) )
   {
   if( (k[i].p.x <= (PIXELRADIUS+1)/DIFFX) ) /* Kugel links in Nähe von Bande */
    {
    for( j=0;j<=2;j++ ) /* Abfrage, ob Kugel refl. an "großer" Bande */
     if( ((k[i].v.x*banpixel[j].n.x + k[i].v.y*banpixel[j].n.y) <= 0) && in_line(i, j) )
      { reflection( i, j ); break; }
    /* Reflexion an einer "Kugelbande" */
    if( DIFF( k[i].p.x-banpixel[1].p1.x/DIFFX, k[i].p.y-banpixel[1].p1.y/DIFFX ) <= RADIUS*RADIUS )
      refl_kk(i,banpixel[1].p1); 
    else if( DIFF( k[i].p.x-banpixel[1].p0.x/DIFFX, k[i].p.y-banpixel[1].p0.y/DIFFX ) <= RADIUS*RADIUS ) 
      refl_kk(i,banpixel[1].p0);
    /* Kugel in Loch, das zu den entspr. Banden gehört ? */
    for(j=0;j<=1;j++)
     if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y) < 
      posl[j].r*posl[j].r/(DIFFX*DIFFX)) { delete_ball( i, j ); break; }
    }
   else if( k[i].p.x >= (DIFFX-PIXELRADIUS-1)/DIFFX ) /* Kugel rechts */
    {
     for( j=3;j<=5;j++ )
      if(((k[i].v.x*banpixel[j].n.x + k[i].v.y*banpixel[j].n.y) <= 0) && in_line( i, j))
       { reflection( i, j ); break; }
     if( DIFF( k[i].p.x-banpixel[4].p1.x/DIFFX, k[i].p.y-banpixel[4].p1.y/DIFFX ) <=
      RADIUS*RADIUS ) refl_kk(i,banpixel[4].p1); 
     else if( DIFF( k[i].p.x-banpixel[4].p0.x/DIFFX, k[i].p.y-banpixel[4].p0.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[4].p0);
    for(j=3;j<=4;j++)
     if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y)
      < posl[j].r*posl[j].r/(DIFFX*DIFFX)) { delete_ball( i, j ); break; }
    }
   }
  if( (k[i].stat & ONTABLE) && (k[i].v.x || k[i].v.y) )
   {
   if( (k[i].p.y <= (PIXELRADIUS+1)/DIFFX) ) /* Kugel oben */
    {
     for( j=6;j<=8;j++ ) /* geht was nicht !!! !!! !!! */
      { 
       if(((k[i].v.x*banpixel[j].n.x + k[i].v.y*banpixel[j].n.y)<=0) && in_line( i, j))
        { reflection( i, j ); break; }
       else if(((k[i].v.x*banpixel[j+6].n.x + k[i].v.y*banpixel[j+6].n.y)<=0) 
        && in_line(i, j+6)) { reflection( i, j+6 ); break; }
      }
     if( DIFF( k[i].p.x-banpixel[7].p1.x/DIFFX, k[i].p.y-banpixel[7].p1.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[7].p1); 
     else if( DIFF( k[i].p.x-banpixel[7].p0.x/DIFFX, k[i].p.y-banpixel[7].p0.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[7].p0);
     else if( DIFF( k[i].p.x-banpixel[13].p1.x/DIFFX, k[i].p.y-banpixel[13].p1.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[13].p1); 
     else if( DIFF( k[i].p.x-banpixel[13].p0.x/DIFFX, k[i].p.y-banpixel[13].p0.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[13].p0);
     for(j=1;j<=3;j++)
      if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y) < 
       posl[j].r*posl[j].r/(DIFFX*DIFFX)) { delete_ball( i, j ); break; }
    }
   else if( k[i].p.y >= (DIFFX/2-PIXELRADIUS-1)/DIFFX ) /* Kugel unten */
    {
     for( j=9;j<=11;j++ )
      { 
       if(((k[i].v.x*banpixel[j].n.x + k[i].v.y*banpixel[j].n.y)<=0) && in_line( i, j)) 
        { reflection( i, j ); break; }
       else if(((k[i].v.x*banpixel[j+6].n.x + k[i].v.y*banpixel[j+6].n.y)<=0) 
        && in_line(i, j+6) ) { reflection( i, j+6 ); break; }
      }
     if( DIFF( k[i].p.x-banpixel[10].p1.x/DIFFX, k[i].p.y-banpixel[10].p1.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[10].p1); 
     else if( DIFF( k[i].p.x-banpixel[10].p0.x/DIFFX, k[i].p.y-banpixel[10].p0.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[10].p0);
     else if( DIFF( k[i].p.x-banpixel[16].p1.x/DIFFX, k[i].p.y-banpixel[16].p1.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[16].p1); 
     else if( DIFF( k[i].p.x-banpixel[16].p0.x/DIFFX, k[i].p.y-banpixel[16].p0.y/DIFFX ) <= RADIUS*RADIUS )
       refl_kk(i,banpixel[16].p0);
     for(j=4;j<=5;j++)
      if(DIFF(posl[j].p.x-k[i].p.x,posl[j].p.y-k[i].p.y) < 
       posl[j].r*posl[j].r/(DIFFX*DIFFX)) { delete_ball( i, j ); break; }
     if(DIFF(posl[0].p.x-k[i].p.x,posl[0].p.y-k[i].p.y) < 
      posl[j].r*posl[j].r/(DIFFX*DIFFX)) delete_ball( i, 0 );
    }
   }
  }
 }
 
int gl_move_balls( void ) 
/* Die Bewegung der Bälle mit Reibung, Effet, Umwandlung von Translations-
   in Rotationsenergie, Umwandlung von Spin in Geschwindigkeit, etc.... */
 {
  int i, nomove = 0;
  double dummy, test, betr_v;
  struct vect3 d_v, diff, v_trans, v_rot;
  for(i=0;i<BALLS;i++)
   {
   if( ! (k[i].stat & DELETED) )
    {
    if( fabs(k[i].v.x) > 1e-10 || fabs(k[i].v.y) > 1e-10 || 
	fabs(k[i].e.x) > 1e-10 || fabs(k[i].e.y) > 1e-10 || fabs(k[i].e.z) > 1e-10 || (k[i].stat & FALLING) )
     {
      k[i].stat |= MOVING;
      k[i].stat &= (0xff ^ GL_LISTED_NOT_MOVING);
      diff.x = (v_rot.x = k[i].e.x) - (v_trans.x = -k[i].v.y/PIXELRADIUS);
      diff.y = (v_rot.y = k[i].e.y) - (v_trans.y = k[i].v.x/PIXELRADIUS);
      if( diff.x || diff.y )
       {
        test = BETR( diff );
        if( test < ALPHA )
         { /* das funktioniert ganz gut ! */
          k[i].e.x -= diff.x * 2.0/7.0;
	  k[i].e.y -= diff.y * 2.0/7.0;
	  k[i].v.x += diff.y * 5.0/7.0 * PIXELRADIUS;
 	  k[i].v.y -= diff.x * 5.0/7.0 * PIXELRADIUS;
 	 }
        else   
         {
	  dummy = ALPHA / test;
          k[i].e.x -= (d_v.x = diff.x * dummy);
          k[i].e.y -= (d_v.y = diff.y * dummy);
 	  if( d_v.x || d_v.y )
 	   {
	    dummy = -0.5*( betr_v = BETR( k[i].v ) );
            test = dummy*dummy - PIXELRADIUS*PIXELRADIUS/5.0 * 
	     ( SKALP( d_v, d_v ) - 2.0*SKALP( d_v, k[i].e ) );
	    dummy += sqrt( fabs(test) );
	    dummy /= BETR( d_v );
            dummy = fabs(dummy);
            if( fabs( k[i].e.x )*PIXELRADIUS > fabs( k[i].v.y ) )
   	     k[i].v.x -= -d_v.y * dummy * ETA;
            else k[i].v.x -= -d_v.y * dummy;
            if( fabs( k[i].e.y )*PIXELRADIUS > fabs( k[i].v.x ) )
   	     k[i].v.y -= d_v.x * dummy * ETA;
            else k[i].v.y -=  d_v.x * dummy;
       	   }
         }
       }
      if( fabs(k[i].v.x) > 1e-10 || fabs(k[i].v.y) > 1e-10 )
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
        dummy = DELTA / ( BETR( k[i].e ) * PIXELRADIUS );
        if( dummy >= 1.0 ) k[i].e.x = k[i].e.y = 0;
        else
	 {
          k[i].e.x -= k[i].e.x * dummy;
          k[i].e.y -= k[i].e.y * dummy;
	 }
       }
      /* Abnahme von ez durch Bohrreibung! */
      if( fabs(k[i].e.z) > BETA )  k[i].e.z += (k[i].e.z > 0) ? -BETA : BETA;
      else k[i].e.z = 0.0;
      k[i].p.x += k[i].v.x;		/* Eigentliche Bewegung der Kugel */
      k[i].p.y += k[i].v.y;
      k[i].rot.x += k[i].e.x * M_PI/2.0 * M_PI * PIXELRADIUS * DIFFX * 0.75;
      k[i].rot.y += k[i].e.y * M_PI/2.0 * M_PI * PIXELRADIUS * DIFFX * 0.75;
      k[i].rot.z += k[i].e.z * 2.0 * M_PI * PIXELRADIUS * 0.01;
      if( k[i].stat & FALLING )
       {
       struct vect rad, vsub;
       k[i].v.z = -0.0002;
       k[i].e.x = k[i].e.y = k[i].e.z = 0;
       if( k[i].p.z < -2.0*RADIUS ) {k[i].stat |= DELETED; k[i].p.x = k[i].p.y = 1000.0;}
       rad.x = k[i].p.x - posl[k[i].pocket].p.x;       /* Effekt ist nicht perfekt, da RADIUSL */
       rad.y = k[i].p.y - posl[k[i].pocket].p.y;       /* größer als der sichtbare Teil... !   */
       if( (dummy=BETR(rad)) > (0.27841/DIFFX-RADIUS) ) /* 27... ist der gemalte Radius der Eck-Taschen */
	 {
	  rad.x /= dummy;
	  rad.y /= dummy;
	  dummy = SKALP(rad, k[i].v);
	  vsub.x = dummy * rad.x;
	  vsub.y = dummy * rad.y;
	  k[i].v.x -= vsub.x;
	  k[i].v.y -= vsub.y;
	}
       if( BETR(k[i].v) < 0.15/DIFFX ) 
	{
        struct vect dum;
	dum.x = posl[k[i].pocket].p.x - k[i].p.x;
	dum.y = posl[k[i].pocket].p.y - k[i].p.y;
	dummy = BETR(dum);
        k[i].v.x = dum.x / dummy * 0.16/DIFFX;
	k[i].v.y = dum.y / dummy * 0.16/DIFFX;
	}
       k[i].p.z += k[i].v.z;
       }
     }
    else { k[i].stat &= (0xff ^ MOVING); nomove++; }
    }
   else nomove++;
   }
 return nomove; /* Gibt an, wieviele Kugeln sich nicht mehr bewegen */
}

void gl_stoss( void )   
/* Der eigentliche Stoß, mit den Werten, die entweder der Spieler via Mouse
   oder der Computergegener hinsichtlich der Stoß-Geschwindigkeit (Betrag
   und Richtung, Effet) liefert, wird die Weiße losgelassen und die
   Kollisionen zwischen Kugeln und zw. Kugeln und Banden abgefragt... */
 {
  int nomove, i,j, count, mousex,mousey, pressed=0, buttons, simcount=0;
  double time_cur, time_start;
  struct timeval tp_start,tp_cur;
  SDL_Event event;
  Uint8 *keys;
  translate_spin();
  ply[cur].speed = spd;
  counter = 0;
  gettimeofday(&tp_start,NULL);
  time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
  if( !( gamemode & SIMULATION_MODE ) )
   {
   do
    {
    if( (!calc_to_end) ) 
      {
      gl_plotall(-1);
      msg2("mouse motion changes view");
      SDL_GL_SwapBuffers();
      }
    gettimeofday(&tp_cur,NULL);
    time_cur = tp_cur.tv_sec * 1000000 + tp_cur.tv_usec;
    if( (!calc_to_end) ) 
     {
     if( time_cur != time_start ) 
      {
      frames_per_second = 19.0*frames_per_second + 1000000.0 / (double)(time_cur - time_start);
      frames_per_second /= 20.0;
      }
     else frames_per_second = 1000.0;
     }
    count=0;
    do
     {
     nomove = gl_move_balls();
     if( !calc_to_end && ((!new_game && (gamemode & PLAY_MODE)) || (demo==1)  || (c_player == cur)) )
      {
      SDL_PollEvent(&event);
      keys = SDL_GetKeyState(NULL);
      buttons = SDL_GetMouseState(&mousex, &mousey);
      if( keys[SDLK_c] ) { c_player = -1; calc_to_end=1; }
      if( keys[SDLK_SPACE] ) 
       { 
       if( demo ) {ende = 0; c_player = -1; demo=0; calc_to_end=1; gamemode = last_gamemode; }
       else calc_to_end=1; 
       }
      if( keys[SDLK_ESCAPE] ) stop_it();
      if( keys[SDLK_z] ) calc_to_end = 1;
      if( buttons & SDL_BUTTON(3) ) 
       {
       if( !pressed ) pressed = 1; /* ?! */
       else
	{
	/* zoomen mit rechtem Knopf und Mausbewegung */
	startz+=(double)(SCREENRESY/2 - mousey) * 0.00333;
	SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2);
	}
       }
      else if( buttons & SDL_BUTTON(2) )
       {
       startx+=(double)(SCREENRESX/2 - mousex) * 0.000333;
       starty-=(double)(SCREENRESY/2 - mousey) * 0.000333;
       SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2);
       }
      else 
       {
       /* Tisch drehen nur mit Mausbewegung */
       angz-=(double)(SCREENRESX/2 - mousex) / 3.0;
       angx-=(double)(SCREENRESY/2 - mousey) / 3.0;
       SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2);
       pressed = 0;
       }
      }
     banden_test();
     for( i=0;i<BALLS;i++) /* Abfrage nach "potentieller" Kollision, d.h. */
      for(j=i;j<BALLS;j++) /* ob Abstand zw. Kugel i u. j klein genug !! */
       if( (j != i) && (k[i].stat & ONTABLE ) && (k[j].stat & ONTABLE ) &&
 	  (DIFF( k[i].p.x-k[j].p.x, k[i].p.y-k[j].p.y ) <= 4.0*RADIUS*RADIUS))
	 coll( i, j ); 
     count++;
     }
    while( count < ((time_cur - time_start)/1000.0) );
    gettimeofday(&tp_start,NULL);
    time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
    }
   while( nomove < BALLS );
   gl_plotall(1);
   for(i=0;i<BALLS;i++) calc_rotation(i); /* Endrotation abspeichern */
   calc_to_end = 0;
   }
  else
   {
   count=0;
   gettimeofday(&tp_start,NULL);
   time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
   do
    {
    nomove = gl_move_balls();
    banden_test();
    for( i=0;i<BALLS;i++) /* Abfrage nach "potentieller" Kollision, d.h. */
      for(j=i;j<BALLS;j++) /* ob Abstand zw. Kugel i u. j klein genug !! */
	if( (j != i) && (k[i].stat & ONTABLE ) && (k[j].stat & ONTABLE ) &&
	    (DIFF( k[i].p.x-k[j].p.x, k[i].p.y-k[j].p.y ) <= 4.0*RADIUS*RADIUS))
	  coll( i, j ); 
    count++;
    if( (count % 100) == 0 )
     {
     for(i=0;i<BALLS;i++)
      {
      simulation[simcount][i].x = (k[i].stat == DELETED ? -1000.0 : k[i].p.x);
      simulation[simcount][i].y = (k[i].stat == DELETED ? -1000.0 : k[i].p.y);
      }
     simcount++;
     }
    }
   while( nomove < BALLS );
#ifdef DEBUG
   printf("%g, %d\n",time_cur-time_start,simcount);
#endif
   undo();
   gl_plotall(-1);
   glDisable(GL_CULL_FACE);
   glDisable(GL_LIGHTING);
   glEnable(GL_BLEND);
   glBegin(GL_TRIANGLES);
   glNormal3f(0,0,1.0);
   for(j=0;j<simcount;j++)
    {
    for(i=0;i<BALLS;i++)
     {
     glColor4f(1.0,1.0,1.0,1.0);
     if( simulation[j][i].x > -500.0 )
      {
      glVertex3f(simulation[j][i].x - 0.5 - RADIUS/5.0, simulation[j][i].y - 0.25, RADIUS);
      glVertex3f(simulation[j][i].x - 0.5 + RADIUS/5.0, simulation[j][i].y - 0.25 - RADIUS/5.0, RADIUS);
      glVertex3f(simulation[j][i].x - 0.5 + RADIUS/5.0, simulation[j][i].y - 0.25 + RADIUS/5.0, RADIUS);
      }
     }
    }
   glEnd();
   glEnable(GL_CULL_FACE);
   glEnable(GL_LIGHTING);
   glDisable(GL_BLEND);
   SDL_GL_SwapBuffers();
   wait_for_click();
   gamemode &= (0xff ^ SIMULATION_MODE);
   }
 }

/* die Timer-Funktionen haben sich mit SDL etwas vereinfacht ;-) */
unsigned long timer(void)
 {
 return SDL_GetTicks();
 }

void init_timer(void)
 {
 old_timer = SDL_GetTicks();
 }
