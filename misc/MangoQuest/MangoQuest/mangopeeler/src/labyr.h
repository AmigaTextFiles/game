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

#ifndef _LABYR_H_
#define _LABYR_H_

#define SOL_1 0
#define SOL_2 1
#define PLAFOND_1 10
#define PLAFOND_2 11
#define MUR_1 20
#define MUR_2 21
#define MUR_3 22
#define MUR_4 23

#define HAUTEUR 4               // hauteur des murs
#define SCALE_FACTOR 3

class LABYRINTHE { public:
  LABYRINTHE();
  ~LABYRINTHE();

  CUBE3D *materiaux;

  ListePortals listePortals;
  ListeSecteurs listeSecteurs;

  void transforme_en_polygones();
  void calculeNormales();
  void creePortals();
  void creeSecteurs();
  void remplitSecteur();
  void detruitMateriaux();
  void check_null_sectors();

  double chercheXgauche(double xCourant, double zCourant, int tailleCarte);
  double chercheXdroite(double xCourant, double zCourant, int tailleCarte);
  double chercheZbas(double xCourant, double zCourant, int tailleCarte);
  double chercheZhaut(double xCourant, double zCourant, int tailleCarte);

  POINT2D chercheGauche(int pos, double x, double z, CARTE * plan);
  POINT2D chercheDroite(int pos, double x, double z, CARTE * plan);
  POINT2D chercheHaut(int pos, double x, double z, CARTE * plan);
  POINT2D chercheBas(int pos, double x, double z, CARTE * plan);

private:
  // fct utilisées lors de transforme_en_polygones
  int determine_n_triangles(int position);
  void cree_triangles_sols( int position, SOMMET2D * valeurs);
  void cree_triangles_murs( int position, SOMMET2D * valeurs);
};

#endif
