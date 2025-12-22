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

// un portal est soir horiontal, soit vertical
#define HORIZ 1
#define VERTI 2


static int cmpt=0;


struct PORTAL
{
  double x1, x2, z1, z2;
  char TYPE; //HORIZ ou VERTI

  // un portal joint deux secteurs entre eux
  // pointeur void à changer si possible
  void *connexion1;
  void *connexion2;

  char visible;
  char dejaDessine;

  double angleTest;

  int numero; //le numero du portal

};

class elementPortal 
{
 public:
  PORTAL portal;
  elementPortal *suivant;
  elementPortal *precedent;

  elementPortal(void)
    {
      portal.x1=0;
      portal.x2=0;
      portal.z1=0;
      portal.z2=0;
      
      portal.TYPE=0; // ce type n'existe pas

      portal.dejaDessine=0;
      portal.visible=0;
      portal.angleTest=0;

      
      suivant=NULL;
      precedent=NULL;

      portal.numero=cmpt;
      cmpt++;
     // printf("cmpt= %d\n",cmpt);
      

    }
  elementPortal *getSuivant(void) 
    {
      return suivant;
    }
  elementPortal *getPrecedent(void)
    {
      return precedent;
    }
  void change(PORTAL nouveau)
    {
      portal.x1=nouveau.x1;
      portal.x2=nouveau.x2;
      portal.z1=nouveau.z1;
      portal.z2=nouveau.z2;

      portal.TYPE = nouveau.TYPE;
            
    }

  void getPortal(PORTAL &candidat) 
    {
      candidat=portal;
    }
  double getx1() 
    {
      return portal.x1;
    }
  double getx2()
    {
      return portal.x2;
    }
  double getz1()
    {
      return portal.z1;
    }
  double getz2()
    {
      return portal.z2;
    }

  char getTYPE()
    {
      return portal.TYPE;
    }
  
};

class ElementPPortal 
{
 public:
  PORTAL *pportal;
  ElementPPortal *suivant;
  ElementPPortal *precedent;
  int visible;

  int nTests;
    
  ElementPPortal(void)
    {
      pportal=NULL;

      suivant=NULL;
      precedent=NULL;

      visible=0;
      nTests=0;
      
    }
  ElementPPortal *getSuivant(void) 
    {
      return suivant;
    }
  ElementPPortal *getPrecedent(void)
    {
      return precedent;
    }
  
  void getPortal(PORTAL *candidat) 
    {
      candidat=pportal;
    }

  char getTYPE()
    {
      return pportal->TYPE;
    }
  
};

class ListePPortals //: public ElementPPortal 
{

 public:
  ElementPPortal *debut,*fin;
  int nombre;
  

  ListePPortals(void)
    {
      debut = fin = NULL; 
      nombre=0;
    }
  
  void ajouter(PORTAL *candidat);
  void detruire(ElementPPortal *lequel);

  ElementPPortal *chercher(PORTAL lequel);
  ElementPPortal *getDebut(void) 
    {
      return debut;
    }
  ElementPPortal *getFin(void)
    {
      return fin;
    }
};


class ListePortals //: public elementPortal 
{
  elementPortal *debut,*fin;
  
 public:
int NPORTALS;
  ListePortals(void)
    {
      debut = fin = NULL;
      NPORTALS=0;
    }
  
  void ajouter(PORTAL candidat);
  void detruire(elementPortal *lequel);
  elementPortal *chercher(PORTAL lequel);

  //int existence(PORTAL lequel);

  elementPortal *getDebut(void) 
    {
      return debut;
    }
  elementPortal *getFin(void)
    {
      return fin;
    }
  void coupePortals(void);
  elementPortal *interProbleme(elementPortal *lequel);
  void resoudProbleme(elementPortal *un,elementPortal *deux);
  
  void resette();
  void index_portals();

};

////////////////////////////

class ElementDouble 
{
 public:
  double angle;
  
  ElementDouble *suivant;
  ElementDouble *precedent;

  ElementDouble(void)
    {
      suivant=NULL;
      precedent=NULL;

      angle=0;
    }
  ElementDouble *getSuivant(void) 
    {
      return suivant;
    }
  ElementDouble *getPrecedent(void)
    {
      return precedent;
    }
 
  double getDouble()
    {
      return angle;
      
    }

  
};

class ListeDouble : public ElementDouble
{
  ElementDouble *debut,*fin;
 public:
  ListeDouble(void)
    {
      debut = fin = NULL;
    }
  
  void ajouter(double nombre);
  void detruire(elementPortal *lequel);
  
  //ElementDouble *chercher(double lequel);

  int existence(double lequel);

  ElementDouble *getDebut(void) 
    {
      return debut;
    }
  ElementDouble *getFin(void)
    {
      return fin;
    }
  
  void RAZ();

};

