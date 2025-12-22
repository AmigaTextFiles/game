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

#ifndef _BONUS_H_
#define _BONUS_H_


class ElementBonus
{
 public:
 double x, y, z;
 int caseCarte;
 int type;
 int parametre;
 int visible;
 int encoreLa;

 //int actif;
  
 ElementBonus *suivant;
 ElementBonus *precedent;
 
 ElementBonus(void) {
   suivant = precedent = NULL;
   visible=0;
   encoreLa=1;
   //actif=0;
 }
 
 ElementBonus *getSuivant(void) 
    {
      return suivant;
    }
 ElementBonus *getPrecedent(void)
   {
     return precedent;
   }
};

class ListeBonus
{
  public:
  int nombre;
  ElementBonus *debut,*fin;
  ListeBonus(void)
    {
      debut = fin = NULL;
      nombre=0;
    }
	 
  ElementBonus *getDebut(void) 
    {
      return debut;
    }
  ElementBonus *getFin(void)
    {
      return fin;
    }  
	 
  void ajouter(ElementBonus candidat);
};

#endif
