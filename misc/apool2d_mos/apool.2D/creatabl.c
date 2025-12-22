/* This is "creatable.c", part of the pool (billiards)-program
                   
                     "ANOTHER POOL".

   "creatable.c" calculates the 'geometry' of the table to "table.dat".

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

/* ------------------------------ creatable.c ----------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "apool.h"

#define w_c (1.0/sqrt(2.0)*wide_c)
#define q_c (5.0/10.0*wide_c)
#define r_c (1.0/sqrt(2.0)*t_c)
#define RIGHT_C ((double)RIGHT-20)
#define DOWN_C RIGHT_C / 2
#define MID_C RIGHT_C / 2
#define FAKTOR_C (3.0/3.0) /* wie tief reicht Loch in die Bande */
#define SKALARP(a,b) ( (a).x*(b).x + (a).y*(b).y )
#define WB_C 20.0 /* Breite der Bande (komplett mit unsichtbaren Teilen */
#define WB_C2 (WB_C/2)
#define W (60.0 * M_PI / 180.0) /* Winkel f. Mittelloch-Bande */
#define Q (35.0 * M_PI / 180.0)	/* Winkel f. Eckloch-Banden */
#define ABST 3

void create_table( double wide_c ) /* berechnet Lage der Löcher und Banden */
 {			      /* in Abhängigkeit von der Breite der Löcher */
 struct vect { double x, y; } m_c, a_c, b_c, g_c, f_c;
 double t_c, rad_c, dummym, dummyp;
 FILE *datei;
 if( !(datei=fopen("table.dat","w") ) ) 
  {
  printf("can't open 'table.dat' for writing (!) \n");
  exit( 0 );
  }
 if( wide_c < 10.0) wide_c = 10.0;
 else if( wide_c > 100.0) wide_c = 100.0;
 /* dritten Punkt auf Kreis bestimmen (für die Löcher) */
 a_c.x = -WB_C2;
 a_c.y = w_c - WB_C2;
 m_c.x = a_c.x + FAKTOR_C * WB_C2 + 1.0/sqrt(8.0) * wide_c;
 m_c.y = a_c.y + FAKTOR_C * WB_C2 - 1.0/sqrt(8.0) * wide_c;
 b_c.x = a_c.x + w_c/2.0;
 b_c.y = a_c.y - w_c/2.0;
 /* Vektor in Richtung m --> Mittelpunkt bestimmen: */
 g_c.x = b_c.x-m_c.x; g_c.y = b_c.y-m_c.y;
 /* Vektor a-m bestimmen */
 f_c.x = a_c.x-m_c.x;
 f_c.y = a_c.y-m_c.y;
 t_c = -1.0/2.0 * ( SKALARP( f_c, f_c ) / SKALARP( g_c, f_c ) );
 f_c.x = m_c.x + g_c.x * t_c;
 f_c.y = m_c.y + g_c.y * t_c;
 rad_c=sqrt( (m_c.x-f_c.x)*(m_c.x-f_c.x) + (m_c.y-f_c.y)*(m_c.y-f_c.y) );
 t_c = rad_c - sqrt((b_c.x-m_c.x)*(b_c.x-m_c.x)+
  (b_c.y-m_c.y)*(b_c.y-m_c.y))+1.5;
 fprintf(datei,"%g\n",rad_c+0.5 ); /* Radius der Löcher schreiben */
 /* Die sechs Löcher schreiben, Reihenfolge: lu, lo, mo, ro, ru, mu */
 fprintf(datei,"%g %g\n",b_c.x-r_c-ABST, DOWN_C-b_c.y+r_c + ABST);
 fprintf(datei,"%g %g\n",b_c.x-r_c-ABST, b_c.y-r_c-ABST);
 fprintf(datei,"%g %g\n",MID_C,-(((1.0-FAKTOR_C)*WB_C2)+rad_c));
 fprintf(datei,"%g %g\n",RIGHT_C-b_c.x+r_c+ABST, b_c.y-r_c-ABST);
 fprintf(datei,"%g %g\n",RIGHT_C-b_c.x+r_c+ABST, DOWN_C-b_c.y+r_c+ABST);
 fprintf(datei,"%g %g\n",MID_C,DOWN_C+(1.0-FAKTOR_C)*WB_C2+rad_c);
 /* Banden schreiben, gegeben durch ihre 4 Eckpunkte, immer gegen den Uhr-
    zeigersinn und der vierten Seite "außerhalb" des Tisches. Reihenfolge:
    links, rechts, oben links, unten links, oben rechts, unten rechts      */
 dummyp = w_c/2.0 + WB_C2/tan( Q );
 dummym = w_c/2.0 - WB_C2/tan( Q );
 fprintf( datei,"%g %g %g %g %g %g %g %g\n", 
  -WB_C, DOWN_C-dummym, 0.0, DOWN_C-dummyp, 0.0, dummyp, -WB_C, dummym );
 fprintf(datei,"%g %g %g %g %g %g %g %g\n", 
  RIGHT_C+WB_C, dummym, RIGHT_C, dummyp, RIGHT_C, DOWN_C-dummyp, 
   RIGHT_C+WB_C, DOWN_C-dummym );
 fprintf(datei,"%g %g %g %g %g %g %g %g\n", dummym, -WB_C, dummyp, 0.0, 
  MID_C-q_c-WB_C2/tan(W), 0.0, MID_C-q_c + WB_C2/tan(W), -WB_C );
 fprintf(datei,"%g %g %g %g %g %g %g %g\n", MID_C-q_c + WB_C2/tan(W), 
  DOWN_C+WB_C, MID_C-WB_C2/tan(W)-q_c, DOWN_C, dummyp, DOWN_C, dummym, 
  DOWN_C+WB_C );
 fprintf(datei,"%g %g %g %g %g %g %g %g\n", MID_C+q_c+0.5 - WB_C2/tan(W), 
  -WB_C, MID_C+WB_C2/tan(W)+q_c+0.5, 0.0, RIGHT_C-dummyp, 0.0, 
   RIGHT_C-dummym, -WB_C );
 fprintf(datei,"%g %g %g %g %g %g %g %g\n", RIGHT_C-dummym, 
  DOWN_C+WB_C, RIGHT_C-dummyp, DOWN_C, MID_C+WB_C2/tan(W)+q_c+0.5,
  DOWN_C, MID_C+q_c+0.5-WB_C2/tan(W), DOWN_C+WB_C);
 fclose(datei);
 }
