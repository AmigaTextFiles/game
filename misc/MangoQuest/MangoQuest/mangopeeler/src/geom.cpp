/*  The Blue Mango Quest : Mango Peeler
 *  Copyright (c) Clément 'phneutre' Bourdarias (code)
 *                   email: phneutre@users.sourceforge.net
 *                Guillaume 'GuBuG' Burlet (graphics)
 *                   email: gubug@users.sourceforge.net
 *
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

#ifdef WIN32
#include <windows.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>
#include <math.h>

//#include "share.h"
//#include "temps.h"
//#include "carte.h"
//#include "portals.h"
#include "geom.h"

// #include "shmollux.h"
// #include "shmixman.h"
// #include "bonus.h"

// #include "secteur.h"
// #include "labyr.h"
// #include "univers.h"

void ListePTriangles::ajouter(TRIANGLE * candidat)
{
  ElementPTriangle *t;

  t = new ElementPTriangle;
  t->ptriangle = candidat;

  if (debut == NULL)
  {
    fin = debut = t;
  }
  else
  {
    t->precedent = fin;
    fin->suivant = t;
    fin = t;
  }
  nombre++;
//  fprintf(stderr, "j'ajoute un p_triangle\n");
}

// ajouter un delete ?
void ListePTriangles::detruire(ElementPTriangle * lequel)
{
  if (lequel->precedent)
  {
    lequel->precedent->suivant = lequel->suivant;
    if (lequel->suivant)
      lequel->suivant->precedent = lequel->precedent;
    else
      fin = lequel->precedent;
  }

  else
  {
    if (lequel->suivant)
    {
      lequel->suivant->precedent = NULL;
      debut = lequel->suivant;
    }
    else
      debut = fin = NULL;
    lequel->ptriangle = 0;
  }

  nombre--;
}

ElementPTriangle *ListePTriangles::chercher(TRIANGLE lequel)
{
  ElementPTriangle *temp;

  temp = getDebut();
  while (temp)
  {
    /* if ((lequel.x1 == temp->portal.x1) && (lequel.x2 == temp->portal.x2)
       && (lequel.z1 == temp->portal.z1) && (lequel.z2 == temp->portal.z2) && 
       (lequel.TYPE == temp->portal.TYPE)) return temp; */
    temp = temp->getSuivant();
  }
  return NULL;
}
