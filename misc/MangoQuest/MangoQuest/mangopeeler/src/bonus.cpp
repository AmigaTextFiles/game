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

#include <math.h>
#include <stdlib.h>
#include <iostream.h>

#include "bonus.h"


void ListeBonus::ajouter(ElementBonus candidat)
{
  ElementBonus *b;

  b = new ElementBonus;
  b->x = candidat.x;
  b->z = candidat.z;
  b->y = candidat.y;
  b->type = candidat.type;
  b->parametre = candidat.parametre;
  b->caseCarte = candidat.caseCarte;

  if (debut == NULL)
  {
    fin = debut = b;
  }
  else
  {
    b->precedent = fin;
    fin->suivant = b;
    fin = b;
  }
  nombre++;
}
