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

#include "geom.h"
#include "portals.h"

void ListePortals::ajouter(PORTAL candidat)
{
  elementPortal *p;

  p = new elementPortal;
  if (!p)
  {
    fprintf(stderr, "Erreur d'allocation memoire (portal)\n");
    exit(1);
  }
  p->portal.x1 = candidat.x1;
  p->portal.x2 = candidat.x2;
  p->portal.z1 = candidat.z1;
  p->portal.z2 = candidat.z2;

  p->portal.TYPE = candidat.TYPE;

  if (debut == NULL)
  {
    fin = debut = p;
  }
  else
  {
    p->precedent = fin;
    fin->suivant = p;
    fin = p;
  }

  NPORTALS++;

  // fprintf(stderr, "j'ajoute un portal : (%0.1f,%0.1f) (%0.1f,%0.1f)\n",
//   candidat.x1, candidat.z1, candidat.x2, candidat.z2);

  // fprintf(stderr, "j'ajoute un portal : numero %d\n",p->portal.numero);
}

void ListePortals::detruire(elementPortal * lequel)
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

  }

  NPORTALS--;

//  fprintf(stderr, "je detruis un portal (%0.1f,%0.1f) (%0.1f,%0.1f)\n",
//   lequel->portal.x1, lequel->portal.z1, lequel->portal.x2, lequel->portal.z2);

  // est-ce bien utile ?
  delete lequel;
}

elementPortal *ListePortals::chercher(PORTAL lequel)
{
  elementPortal *temp;

  temp = getDebut();
  while (temp)
  {
    if ((lequel.x1 == temp->portal.x1) && (lequel.x2 == temp->portal.x2)
        && (lequel.z1 == temp->portal.z1) && (lequel.z2 == temp->portal.z2)
        && (lequel.TYPE == temp->portal.TYPE))
      return temp;
    temp = temp->getSuivant();
  }
  return NULL;
}

void ListePortals::resette()
{
  elementPortal *temp;

  temp = getDebut();
  while (temp)
  {
    temp->portal.visible = 0;
    temp->portal.angleTest = 0;
    temp = temp->getSuivant();
  }
}

void ListePortals::coupePortals(void)
{
  elementPortal *temp, *probleme;

  temp = getDebut();

  while (temp)
  {

    // on regarde si ce portal en coupe un autre
    if ((probleme = interProbleme(temp)) != 0)
    {

      // si oui, on resoud le probleme
      resoudProbleme(temp, probleme);

      // et on recommence les tests depuis le debut
      temp = getDebut();
    }
    // pas de probleme -> on continue
    else
      temp = temp->getSuivant();
  }
}

elementPortal *ListePortals::interProbleme(elementPortal * lequel)
{
  elementPortal *lePb;

  lePb = getDebut();
  while (lePb)
  {

    if (lePb != lequel)
    {

      switch (lequel->portal.TYPE)
      {
      case HORIZ:
        // je vais couper un vertical
        if ((lePb->portal.TYPE == VERTI)
            && (lePb->portal.z1 < lequel->portal.z1)
            && (lePb->portal.z2 > lequel->portal.z1)
            && (lePb->portal.x1 > lequel->portal.x1)
            && (lePb->portal.x1 < lequel->portal.x2))
        {
          // printf("Z du pb: %0.2f\n",lePb->portal.z1);
          return lePb;
        }
        break;

      case VERTI:
        // je vais couper un horizontal
        if ((lePb->portal.TYPE == HORIZ)
            && (lePb->portal.z1 > lequel->portal.z1)
            && (lePb->portal.z1 < lequel->portal.z2)
            && (lePb->portal.x1 < lequel->portal.x1)
            && (lePb->portal.x2 > lequel->portal.x1))
        {
          // printf("Z du pb: %0.2f\n",lePb->portal.z1);
          return lePb;
        }
        break;
      }

    }

    lePb = lePb->getSuivant();
  }

  // pas de pb : on revoit NULL
  return NULL;
}

void ListePortals::resoudProbleme(elementPortal * unPortal,
                                  elementPortal * lePb)
{
  POINT2D intersection;
  PORTAL hor1, hor2, ver1, ver2;

  intersection.x = intersection.z = 0;

//  fprintf(stderr,"\nOn resoud un probleme\n");

  switch (unPortal->portal.TYPE)
  {
  case HORIZ:
    // je suis un portal horizontal qui coupe un vertical
    intersection.x = lePb->portal.x1;
    intersection.z = unPortal->portal.z1;

    // on cree 4 nouveaux portaux
    hor1.x1 = unPortal->portal.x1;
    hor1.x2 = intersection.x;
    hor1.z1 = unPortal->portal.z1;
    hor1.z2 = unPortal->portal.z1;

    hor2.x1 = intersection.x;
    hor2.x2 = unPortal->portal.x2;
    hor2.z1 = unPortal->portal.z1;
    hor2.z2 = unPortal->portal.z1;

    ver1.x1 = lePb->portal.x1;
    ver1.x2 = lePb->portal.x1;
    ver1.z1 = lePb->portal.z1;
    ver1.z2 = intersection.z;

    ver2.x1 = lePb->portal.x1;
    ver2.x2 = lePb->portal.x1;
    ver2.z1 = intersection.z;
    ver2.z2 = lePb->portal.z2;

    break;

  case VERTI:
    // je suis un portal vertical qui coupe un horizontal
    intersection.x = unPortal->portal.x1;
    intersection.z = lePb->portal.z1;

    // printf("et ici: %0.2f\n",lePb->portal.z1);

    ver1.x1 = unPortal->portal.x1;
    ver1.x2 = unPortal->portal.x1;
    ver1.z1 = unPortal->portal.z1;
    ver1.z2 = intersection.z;

    ver2.x1 = unPortal->portal.x1;
    ver2.x2 = unPortal->portal.x1;
    ver2.z1 = intersection.z;
    ver2.z2 = unPortal->portal.z2;

    hor1.x1 = lePb->portal.x1;
    hor1.x2 = intersection.x;
    hor1.z1 = lePb->portal.z1;
    hor1.z2 = lePb->portal.z1;

    hor2.x1 = intersection.x;
    hor2.x2 = lePb->portal.x2;
    hor2.z1 = lePb->portal.z1;
    hor2.z2 = lePb->portal.z1;

    break;
  }

  hor1.TYPE = HORIZ;
  hor2.TYPE = HORIZ;

  ver1.TYPE = VERTI;
  ver2.TYPE = VERTI;

  // ajout des nouveaux portals
  ajouter(hor1);
  ajouter(hor2);
  ajouter(ver1);
  ajouter(ver2);

  // on detruit les anciens
  detruire(unPortal);
  detruire(lePb);
}

void ListePortals::index_portals()
{
  elementPortal *temp;
  int i=0;

  temp = getDebut();
  while (temp)
  {
    temp->portal.numero = i;
    i++;
    temp = temp->getSuivant();
  }
}

////////////////////////////////////////////////////////////

void ListePPortals::ajouter(PORTAL * candidat)
{
  ElementPPortal *pp;

  pp = new ElementPPortal;
  pp->pportal = candidat;

  if (debut == NULL)
  {
    fin = debut = pp;
  }
  else
  {
    // on ajoute à la fin de la liste
    pp->precedent = fin;
    fin->suivant = pp;
    fin = pp;
  }

  nombre++;

//  fprintf(stderr, "j'ajoute un p_portal\n");
}

// ajouter un delete ?
void ListePPortals::detruire(ElementPPortal * lequel)
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
    lequel->pportal = 0;
  }
  nombre--;

}

ElementPPortal *ListePPortals::chercher(PORTAL lequel)
{
  ElementPPortal *temp;

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
