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

#ifndef _GEOM_H_
#define _GEOM_H_

struct SOMMET2D
{
  double x, z;
  double u, v;
};

struct SOMMET
{
  double x, y, z;		// les coordonnees 3d
  double u, v;			// les coordonnees des textures
};

struct POINT2D
{
  double x, z;
};


struct TRIANGLE
{
  SOMMET sommet[3];
  int texture;			// le numero de la texture (0<= n< 36)
  char type;			// SOL, PLAFOND, MUR_1, MUR_2, MUR_3 ou MUR_4
  double normal_x, normal_y, normal_z;
};

struct CUBE3D			// une unite de base de labyrinthe
{
  TRIANGLE *triangles;		// les triangles constituant le cube
  int n_triangles;		// le nombre de triangles dans cette unite de carte
  TRIANGLE *trFBC,*trFCG,*trGCD,*trGDH,*trHDA,*trHAE,*trEAB,*trEBF;
  // pointeurs vers les triangles respectifs (cf. doc pour le nom des triangles)

};

class ElementPTriangle
{
 public:
  TRIANGLE *ptriangle;
  ElementPTriangle *suivant;
  ElementPTriangle *precedent;
  
  ElementPTriangle(void)
    {
      ptriangle=NULL;
      suivant=NULL;
      precedent=NULL;
      
    }
  ElementPTriangle *getSuivant(void) 
    {
      return suivant;
    }
  ElementPTriangle *getPrecedent(void)
    {
      return precedent;
    }

  void getPTriangle(TRIANGLE *candidat) 
    {
      candidat=ptriangle;
    }

  void getSommet(SOMMET *candidat)
    {
      candidat=ptriangle->sommet;
    }
};

class ListePTriangles //: public ElementPTriangle 
{
  ElementPTriangle *debut,*fin;
 public:
  int nombre;
  ListePTriangles(void)
    {
      debut = fin = NULL;
      nombre=0;
    }
  
  void ajouter(TRIANGLE *candidat);
  void detruire(ElementPTriangle *lequel);

  ElementPTriangle *chercher(TRIANGLE lequel);
  ElementPTriangle *getDebut(void) 
    {
      return debut;
    }
  ElementPTriangle *getFin(void)
    {
      return fin;
    }
};

#endif
