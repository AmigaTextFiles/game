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

#ifndef _SECTEUR_H_
#define _SECTEUR_H_

class ElementSecteur
{
 public:
  ListePPortals listePPortals;
  ListePTriangles listePTriangles;
  ListeBonus listeBonus;

  double xmin,zmin,xmax,zmax;
  int visible, numero;

  ElementSecteur *suivant;
  ElementSecteur *precedent;
  
  ElementSecteur(void);
   
  ElementSecteur *getSuivant(void) 
    {
      return suivant;
    }
  ElementSecteur *getPrecedent(void)
    {
      return precedent;
    }

  double getXmin()
    {
      return xmin;
    }
  
  double getZmin() 
    {
      return zmin;
    }
  
  double getXmax() 
    {
      return xmax;
    }
  
  double getZmax() 
    {
      return zmax;
    }

};


class ListeSecteurs
{
 public:
  ElementSecteur *debut,*fin, *courant;
  int cmptNum;
  
  ListeSecteurs(void)
    {
      debut = fin = NULL;
      cmptNum=0;
      
    }
  
  void nouveauSecteur(double xm,double xM, double zm,double zM);
  void ajouter(PORTAL *portal);
  void ajouter(TRIANGLE *triangle);
  void ajouter(ElementBonus elBonus);
  
  void detruire(ElementSecteur *lequel);

  ElementSecteur *ouSuisJe(double posX, double posZ);
  int existence(double xm, double xM, double zm, double zM);

  ElementSecteur *getDebut(void) 
    {
      return debut;
    }
  ElementSecteur *getFin(void)
    {
      return fin;
    }  
};

#endif
