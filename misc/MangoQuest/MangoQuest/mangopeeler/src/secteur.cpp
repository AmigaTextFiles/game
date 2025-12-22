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

#include <math.h>

#include "bonus.h"
#include "portals.h"
#include "geom.h"

#include "secteur.h"
//#include "labyr.h"

ElementSecteur::ElementSecteur(void)
{
  xmin = xmax = zmin = zmax = 0;
  suivant = NULL;
  precedent = NULL;
  visible = 0;
  numero = 0;
}

void ListeSecteurs::nouveauSecteur(double xm, double xM, double zm, double zM)
{
  ElementSecteur *s;

  s = new ElementSecteur;

  s->xmin = xm;
  s->zmin = zm;
  s->xmax = xM;
  s->zmax = zM;

  if (debut == NULL)
  {
    fin = debut = s;
  }
  else
  {
    s->precedent = fin;
    fin->suivant = s;
    fin = s;
  }

  courant = s;

  s->numero = cmptNum;
  cmptNum++;

  // fprintf(stderr, "--- je commence  un nouveau secteur\n");
}

void ListeSecteurs::ajouter(PORTAL * portal)
{
  courant->listePPortals.ajouter(portal);
}

void ListeSecteurs::ajouter(TRIANGLE * triangle)
{
  courant->listePTriangles.ajouter(triangle);
}

void ListeSecteurs::ajouter(ElementBonus elBonus)
{
  courant->listeBonus.ajouter(elBonus);
}

int ListeSecteurs::existence(double xm, double xM, double zm, double zM)
{
  ElementSecteur *temp;

  temp = getDebut();
  while (temp)
  {
    if ((temp->xmin == xm) && (temp->xmax == xM) && (temp->zmin == zm)
        && (temp->zmax == zM))
      return 1;
    temp = temp->getSuivant();
  }
  return 0;

}

ElementSecteur *ListeSecteurs::ouSuisJe(double posX, double posZ)
{
  ElementSecteur *temp;

  temp = getDebut();
  while (temp)
  {
    if ((posX >= temp->getXmin()) && (posX <= temp->getXmax())
        && (posZ >= temp->getZmin()) && (posZ <= temp->getZmax()))
      return temp;
    temp = temp->getSuivant();
  }
  return NULL;
}
