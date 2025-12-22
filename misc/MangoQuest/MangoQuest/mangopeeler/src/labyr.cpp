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
#include <SDL/SDL_ttf.h>
#include <math.h>

#include "share.h"
#include "ch_tout.h"
#include "polices.h"
#include "volet.h"
#include "carte.h"

#include "editeur.h"

#include "carte.h"
#include "geom.h"
#include "portals.h"
#include "bonus.h"
#include "secteur.h"
#include "labyr.h"

#define SHX_DEBUG 0
extern CARTE *carte;

LABYRINTHE::LABYRINTHE()
{
  materiaux = new CUBE3D[carte->taille * carte->taille];
}

LABYRINTHE::~LABYRINTHE()
{
  int compteur = 0;

  for (compteur = 0; compteur < carte->taille * carte->taille; compteur++)
    delete[]materiaux[compteur].triangles;
  delete[]materiaux;
}

void LABYRINTHE::detruitMateriaux()
{
  
}

int LABYRINTHE::determine_n_triangles(int position)
{
  int nombre_triangles = 0;

  // un sol et un plafond => 4 triangles quoi qu'il arrive
  if ((carte->maillage[position].tex_sol > -1)
      && (carte->maillage[position].tex_mur < 0))
    nombre_triangles = 4;

  // un mur => 8 triangles maximum, on cherche à en enlever
  else
  {
    nombre_triangles = 8;

    // qqch à gauche
    if (position % carte->taille == 0)
      nombre_triangles -= 2;
    else if (carte->maillage[position - 1].tex_mur > -1)
      nombre_triangles -= 2;

    // qqch à droite
    if (position % carte->taille == (carte->taille - 1))
      nombre_triangles -= 2;
    else if (carte->maillage[position + 1].tex_mur > -1)
      nombre_triangles -= 2;

    // qqch au dessus
    if (position < carte->taille)
      nombre_triangles -= 2;
    else if (carte->maillage[position - carte->taille].tex_mur > -1)
      nombre_triangles -= 2;

    // qqch en dessous
    if (floor(position / carte->taille) == (carte->taille - 1))
      nombre_triangles -= 2;
    else if (carte->maillage[position + carte->taille].tex_mur > -1)
      nombre_triangles -= 2;
  }

//  fprintf(stderr,"(nombre_triangles: %d)\n",nombre_triangles);

  return nombre_triangles;
}

void LABYRINTHE::cree_triangles_sols(int position, SOMMET2D * valeurs)
{

  // S O L 

  // ABC

  materiaux[position].triangles[0].sommet[0].x = valeurs[0].x;
  materiaux[position].triangles[0].sommet[0].z = valeurs[0].z;
  materiaux[position].triangles[0].sommet[0].u = valeurs[0].u;
  materiaux[position].triangles[0].sommet[0].v = valeurs[0].v;

  materiaux[position].triangles[0].sommet[1].x = valeurs[1].x;
  materiaux[position].triangles[0].sommet[1].z = valeurs[1].z;
  materiaux[position].triangles[0].sommet[1].u = valeurs[1].u;
  materiaux[position].triangles[0].sommet[1].v = valeurs[1].v;

  materiaux[position].triangles[0].sommet[2].x = valeurs[2].x;
  materiaux[position].triangles[0].sommet[2].z = valeurs[2].z;
  materiaux[position].triangles[0].sommet[2].u = valeurs[2].u;
  materiaux[position].triangles[0].sommet[2].v = valeurs[2].v;

  materiaux[position].triangles[0].type = SOL_1;
  
  if ((carte->maillage[position].special == FOYER) 
      || ((carte->maillage[position].special >= TEL_D1)
	  &&(carte->maillage[position].special <= TEL_A5)))

    materiaux[position].triangles[0].texture = -3;

  else materiaux[position].triangles[0].texture = carte->maillage[position].tex_sol;

  // ACD 

  materiaux[position].triangles[1].sommet[0].x = valeurs[0].x;
  materiaux[position].triangles[1].sommet[0].z = valeurs[0].z;
  materiaux[position].triangles[1].sommet[0].u = valeurs[0].u;
  materiaux[position].triangles[1].sommet[0].v = valeurs[0].v;

  materiaux[position].triangles[1].sommet[1].x = valeurs[2].x;
  materiaux[position].triangles[1].sommet[1].z = valeurs[2].z;
  materiaux[position].triangles[1].sommet[1].u = valeurs[2].u;
  materiaux[position].triangles[1].sommet[1].v = valeurs[2].v;

  materiaux[position].triangles[1].sommet[2].x = valeurs[3].x;
  materiaux[position].triangles[1].sommet[2].z = valeurs[3].z;
  materiaux[position].triangles[1].sommet[2].u = valeurs[3].u;
  materiaux[position].triangles[1].sommet[2].v = valeurs[3].v;

  materiaux[position].triangles[1].type = SOL_2;

if ((carte->maillage[position].special == FOYER) 
      || ((carte->maillage[position].special >= TEL_D1)
	  &&(carte->maillage[position].special <= TEL_A5)))

  materiaux[position].triangles[1].texture = -3;

 else materiaux[position].triangles[1].texture = carte->maillage[position].tex_sol;

  // P L A F O N D
  // CBA

  materiaux[position].triangles[2].sommet[0].x = valeurs[2].x;
  materiaux[position].triangles[2].sommet[0].z = valeurs[2].z;
  materiaux[position].triangles[2].sommet[0].u = valeurs[2].u;
  materiaux[position].triangles[2].sommet[0].v = valeurs[2].v;

  materiaux[position].triangles[2].sommet[1].x = valeurs[1].x;
  materiaux[position].triangles[2].sommet[1].z = valeurs[1].z;
  materiaux[position].triangles[2].sommet[1].u = valeurs[1].u;
  materiaux[position].triangles[2].sommet[1].v = valeurs[1].v;

  materiaux[position].triangles[2].sommet[2].x = valeurs[0].x;
  materiaux[position].triangles[2].sommet[2].z = valeurs[0].z;
  materiaux[position].triangles[2].sommet[2].u = valeurs[0].u;
  materiaux[position].triangles[2].sommet[2].v = valeurs[0].v;

  materiaux[position].triangles[2].type = PLAFOND_1;
  materiaux[position].triangles[2].texture = carte->maillage[position].tex_pla;

  // DCA
  materiaux[position].triangles[3].sommet[0].x = valeurs[3].x;
  materiaux[position].triangles[3].sommet[0].z = valeurs[3].z;
  materiaux[position].triangles[3].sommet[0].u = valeurs[3].u;
  materiaux[position].triangles[3].sommet[0].v = valeurs[3].v;

  materiaux[position].triangles[3].sommet[1].x = valeurs[2].x;
  materiaux[position].triangles[3].sommet[1].z = valeurs[2].z;
  materiaux[position].triangles[3].sommet[1].u = valeurs[2].u;
  materiaux[position].triangles[3].sommet[1].v = valeurs[2].v;

  materiaux[position].triangles[3].sommet[2].x = valeurs[0].x;
  materiaux[position].triangles[3].sommet[2].z = valeurs[0].z;
  materiaux[position].triangles[3].sommet[2].u = valeurs[0].u;
  materiaux[position].triangles[3].sommet[2].v = valeurs[0].v;

  materiaux[position].triangles[3].type = PLAFOND_2;
  materiaux[position].triangles[3].texture = carte->maillage[position].tex_pla;

  // altitudes

  materiaux[position].triangles[0].sommet[0].y =
    materiaux[position].triangles[0].sommet[1].y =
    materiaux[position].triangles[0].sommet[2].y =
    materiaux[position].triangles[1].sommet[0].y =
    materiaux[position].triangles[1].sommet[1].y =
    materiaux[position].triangles[1].sommet[2].y = 0;

  materiaux[position].triangles[2].sommet[0].y =
    materiaux[position].triangles[2].sommet[1].y =
    materiaux[position].triangles[2].sommet[2].y =
    materiaux[position].triangles[3].sommet[0].y =
    materiaux[position].triangles[3].sommet[1].y =
    materiaux[position].triangles[3].sommet[2].y = HAUTEUR;

  materiaux[position].trFBC = NULL;
  materiaux[position].trFCG = NULL;
  materiaux[position].trGCD = NULL;
  materiaux[position].trGDH = NULL;
  materiaux[position].trHDA = NULL;
  materiaux[position].trHAE = NULL;
  materiaux[position].trEAB = NULL;
  materiaux[position].trEBF = NULL;
}

void LABYRINTHE::cree_triangles_murs(int position,
                                     SOMMET2D * valeurs)
{
  int compteur2 = 0;

  // qqch en dessous
  if (floor(position / carte->taille) == (carte->taille - 1))
  {
    materiaux[position].trFBC = materiaux[position].trFCG = NULL;
  }
  else if (carte->maillage[position + carte->taille].tex_mur > -1)
  {
    materiaux[position].trFBC = materiaux[position].trFCG = NULL;
  }
  // rien en dessous
  else
  {
    // FBC
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[1].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[1].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[1].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[1].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[2].x;
    materiaux[position].triangles[compteur2].sommet[2].y = 0;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[2].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 0.0f;

    materiaux[position].triangles[compteur2].type = MUR_1;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trFBC = &(materiaux[position].triangles[compteur2]);

    compteur2 += 1;

    // FCG
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[1].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[1].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[2].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[2].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[2].x;
    materiaux[position].triangles[compteur2].sommet[2].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[2].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 1.0f;

    materiaux[position].triangles[compteur2].type = MUR_1;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trFCG = &(materiaux[position].triangles[compteur2]);

    compteur2 += 1;
  }

  // qqch à droite
  if (position % carte->taille == (carte->taille - 1))
  {
    materiaux[position].trGCD = materiaux[position].trGDH = NULL;
  }
  else if (carte->maillage[position + 1].tex_mur > -1)
  {
    materiaux[position].trGCD = materiaux[position].trGDH = NULL;
  }
  // rien à droite
  else
  {
    // GCD
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[2].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[2].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[2].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[2].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[3].x;
    materiaux[position].triangles[compteur2].sommet[2].y = 0;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[3].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 0.0f;

    materiaux[position].triangles[compteur2].type = MUR_2;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trGCD = &(materiaux[position].triangles[compteur2]);
    compteur2 += 1;

    // GDH
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[2].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[2].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[3].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[3].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[3].x;
    materiaux[position].triangles[compteur2].sommet[2].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[3].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 1.0f;

    materiaux[position].triangles[compteur2].type = MUR_2;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trGDH = &(materiaux[position].triangles[compteur2]);

    compteur2 += 1;

  }

  // qqch au dessus
  if (position < carte->taille)
  {
    materiaux[position].trHDA = materiaux[position].trHAE = NULL;
  }
  else if (carte->maillage[position - carte->taille].tex_mur > -1)
  {
    materiaux[position].trHDA = materiaux[position].trHAE = NULL;
  }
  else
  {

    // HDA
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[3].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[3].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[3].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[3].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[0].x;
    materiaux[position].triangles[compteur2].sommet[2].y = 0;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[0].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 0.0f;

    materiaux[position].triangles[compteur2].type = MUR_3;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trHDA = &(materiaux[position].triangles[compteur2]);
    compteur2 += 1;

    // HAE
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[3].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[3].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[0].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[0].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[0].x;
    materiaux[position].triangles[compteur2].sommet[2].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[0].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 1.0f;

    materiaux[position].triangles[compteur2].type = MUR_3;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trHAE = &(materiaux[position].triangles[compteur2]);
    compteur2 += 1;
  }

  // rien à gauche
  if (position % carte->taille == 0)
  {
    materiaux[position].trEAB = materiaux[position].trEBF = NULL;
  }
  else if (carte->maillage[position - 1].tex_mur > -1)
  {
    materiaux[position].trEAB = materiaux[position].trEBF = NULL;
  }
  else
  {
    // EAB
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[0].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[0].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[0].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[0].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[1].x;
    materiaux[position].triangles[compteur2].sommet[2].y = 0;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[1].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 0.0f;

    materiaux[position].triangles[compteur2].type = MUR_4;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].trEAB = &(materiaux[position].triangles[compteur2]);
    compteur2 += 1;

    // EBF
    materiaux[position].triangles[compteur2].sommet[0].x = valeurs[0].x;
    materiaux[position].triangles[compteur2].sommet[0].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[0].z = valeurs[0].z;
    materiaux[position].triangles[compteur2].sommet[1].x = valeurs[1].x;
    materiaux[position].triangles[compteur2].sommet[1].y = 0;
    materiaux[position].triangles[compteur2].sommet[1].z = valeurs[1].z;
    materiaux[position].triangles[compteur2].sommet[2].x = valeurs[1].x;
    materiaux[position].triangles[compteur2].sommet[2].y = HAUTEUR;
    materiaux[position].triangles[compteur2].sommet[2].z = valeurs[1].z;

    materiaux[position].triangles[compteur2].sommet[0].u = 0.0f;
    materiaux[position].triangles[compteur2].sommet[0].v = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[1].v = 0.0f;
    materiaux[position].triangles[compteur2].sommet[2].u = 1.0f;
    materiaux[position].triangles[compteur2].sommet[2].v = 1.0f;
    materiaux[position].triangles[compteur2].texture =
      carte->maillage[position].tex_mur;

    materiaux[position].triangles[compteur2].type = MUR_4;

    materiaux[position].trEBF = &(materiaux[position].triangles[compteur2]);
    compteur2 += 1;
  }
}


void LABYRINTHE::transforme_en_polygones()
{
  // les "bases" sont les 4 sommets de bases communs aux triangles

  SOMMET2D *bases = new SOMMET2D[4];

  int compteur = 0;

  for (compteur = 0; compteur < (carte->taille * carte->taille); compteur++)
  {

    bases[0].x = (compteur % (carte->taille)) * SCALE_FACTOR;
    bases[0].z = floor(compteur / (carte->taille)) * SCALE_FACTOR;
    bases[0].u = 0.0f;
    bases[0].v = 1.0f;

    bases[1].x = bases[0].x;
    bases[1].z = bases[0].z + SCALE_FACTOR;
    bases[1].u = 0.0f;
    bases[1].v = 0.0f;

    bases[2].x = bases[0].x + SCALE_FACTOR;
    bases[2].z = bases[1].z;
    bases[2].u = 1.0f;
    bases[2].v = 0.0f;

    bases[3].x = bases[2].x;
    bases[3].z = bases[0].z;
    bases[3].u = 1.0f;
    bases[3].v = 1.0f;

    materiaux[compteur].n_triangles = determine_n_triangles(compteur);

    if (materiaux[compteur].n_triangles > 0)
      materiaux[compteur].triangles =
        new TRIANGLE[materiaux[compteur].n_triangles];

    else
      materiaux[compteur].triangles = 0;

    if (carte->maillage[compteur].tex_sol > -1)
    {
      cree_triangles_sols(compteur, bases);

    }

    else if (carte->maillage[compteur].tex_mur > -1)
    {
      cree_triangles_murs(compteur, bases);
    }
  }

  delete[]bases;

}

void LABYRINTHE::calculeNormales()
{
  //double a = 0, b = 0, c = 0, a_p = 0, b_p = 0, c_p = 0, racine = 0;
  int compteur = 0, compteur2 = 0;

  for (compteur = 0; compteur < carte->taille * carte->taille; compteur++)
  {

    for (compteur2 = 0; compteur2 < materiaux[compteur].n_triangles;
         compteur2++)
    {


      if ((materiaux[compteur].triangles[compteur2].type == SOL_1)
	  || (materiaux[compteur].triangles[compteur2].type == SOL_2))
	{

	  materiaux[compteur].triangles[compteur2].normal_x = 0;
	  materiaux[compteur].triangles[compteur2].normal_y = 1.0;
	  materiaux[compteur].triangles[compteur2].normal_z = 0;
	}

      if ((materiaux[compteur].triangles[compteur2].type == PLAFOND_1)
	  || (materiaux[compteur].triangles[compteur2].type == PLAFOND_2))
	{

	  materiaux[compteur].triangles[compteur2].normal_x = 0;
	  materiaux[compteur].triangles[compteur2].normal_y = -1.0;
	  materiaux[compteur].triangles[compteur2].normal_z = 0;
	}

      if (materiaux[compteur].triangles[compteur2].type == MUR_1)
	
	{

	  materiaux[compteur].triangles[compteur2].normal_x = 0;
	  materiaux[compteur].triangles[compteur2].normal_y = 0;
	  materiaux[compteur].triangles[compteur2].normal_z = 1.0;
	}

      if  (materiaux[compteur].triangles[compteur2].type == MUR_2)
	{

	  materiaux[compteur].triangles[compteur2].normal_x = 1.0;
	  materiaux[compteur].triangles[compteur2].normal_y = 0;
	  materiaux[compteur].triangles[compteur2].normal_z = 0;
	}

      if (materiaux[compteur].triangles[compteur2].type == MUR_3)
	
	{

	  materiaux[compteur].triangles[compteur2].normal_x = 0;
	  materiaux[compteur].triangles[compteur2].normal_y = 0;
	  materiaux[compteur].triangles[compteur2].normal_z = -1.0;
	}

      if  (materiaux[compteur].triangles[compteur2].type == MUR_4)
	{
	  materiaux[compteur].triangles[compteur2].normal_x = -1.0;
	  materiaux[compteur].triangles[compteur2].normal_y = 0;
	  materiaux[compteur].triangles[compteur2].normal_z = 0;

	}

    }
    

  }

}

void LABYRINTHE::creePortals()
{
  int i = 0, j = 0;
  PORTAL unPortal;
  POINT2D unPoint;

  for (j = 1; j < carte->taille - 1; j++)
  {
    for (i = j * carte->taille + 1; i < (j + 1) * (carte->taille) - 1; i++)
    {

      if (carte->maillage[i].tex_mur > -1)
      {

        // cas : ..==...
        if ((carte->testGauche(i)) && (carte->testDroite(i)))
        {
        }

        // cas idem en hauteur
        if ((carte->testHaut(i)) && (carte->testBas(i)))
        {
        }

        // cas |==...
        if ((carte->testDroite(i)) && (!(carte->testHaut(i)))
            && (!(carte->testBas(i))) && (!(carte->testGauche(i))))
        {

          unPortal.TYPE = HORIZ;
          unPortal.x2 = materiaux[i].trEAB->sommet[0].x;
          unPortal.z2 = materiaux[i].trEAB->sommet[0].z;

          unPoint = chercheGauche(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPoint.x;
          unPortal.z1 = unPortal.z2;

          if (!(carte->testHautGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }
          unPortal.z2 = materiaux[i].trEAB->sommet[2].z;
          unPoint = chercheGauche(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPoint.x;
          unPortal.z1 = unPortal.z2;

          if (!(carte->testBasGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

        }

        // cas ...==|
        if ((carte->testGauche(i)) && (!(carte->testHaut(i)))
            && (!(carte->testBas(i))) && (!(carte->testDroite(i))))
        {

          // le plus en haut
          unPortal.TYPE = HORIZ;

          unPortal.x1 = materiaux[i].trGCD->sommet[0].x;
          unPortal.z1 = materiaux[i].trGCD->sommet[2].z;

          unPoint = chercheDroite(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPoint.x;
          unPortal.z2 = unPortal.z1;

          if (!(carte->testHautDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          // le plus en bas
          unPortal.z1 = materiaux[i].trGCD->sommet[0].z;
          unPoint = chercheDroite(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPoint.x;
          unPortal.z2 = unPortal.z1;

          if (!(carte->testBasDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }
        }

        // cas rien extremite dessus
        if ((carte->testBas(i)) && (!(carte->testHaut(i)))
            && (!(carte->testGauche(i))) && (!(carte->testDroite(i))))
        {

          // le plus à gauche
          unPortal.TYPE = VERTI;
          unPortal.x2 = materiaux[i].trHAE->sommet[1].x;
          unPortal.z2 = materiaux[i].trHAE->sommet[1].z;

          unPoint = chercheHaut(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPortal.x2;
          unPortal.z1 = unPoint.z;

          if (!(carte->testHautGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          // le plus à droite
          unPortal.x2 = materiaux[i].trHAE->sommet[0].x;
          unPoint = chercheHaut(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPortal.x2;
          unPortal.z1 = unPoint.z;

          if (!(carte->testHautDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }
        }

        // cas rien extremite dessous
        if ((carte->testHaut(i)) && (!(carte->testGauche(i)))
            && (!(carte->testBas(i))) && (!(carte->testDroite(i))))
        {

          unPortal.TYPE = VERTI;
          unPortal.x1 = materiaux[i].trFBC->sommet[0].x;
          unPortal.z1 = materiaux[i].trFBC->sommet[0].z;

          unPoint = chercheBas(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPortal.x1;
          unPortal.z2 = unPoint.z;

          if (!(carte->testBasGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          unPortal.x1 = materiaux[i].trFBC->sommet[2].x;
          unPoint = chercheBas(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPortal.x1;
          unPortal.z2 = unPoint.z;

          if (!(carte->testBasDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }
        }

        // cas |_
        if ((carte->testHaut(i)) && (carte->testDroite(i))
            && (!(carte->testBas(i))) && (!(carte->testGauche(i))))
        {

          unPortal.TYPE = HORIZ;
          unPortal.x2 = materiaux[i].trEBF->sommet[0].x;
          unPortal.z2 = materiaux[i].trEBF->sommet[1].z;

          unPoint = chercheGauche(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPoint.x;
          unPortal.z1 = unPortal.z2;

          if (!(listePortals.chercher(unPortal)))
            listePortals.ajouter(unPortal);
       }

        // cas _|
        if ((carte->testHaut(i)) && (carte->testGauche(i))
            && (!(carte->testBas(i))) && (!(carte->testDroite(i))))
        {

          unPortal.TYPE = HORIZ;

          unPortal.x1 = materiaux[i].trGCD->sommet[0].x;
          unPortal.z1 = materiaux[i].trGCD->sommet[0].z;

          unPoint = chercheDroite(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPoint.x;
          unPortal.z2 = unPortal.z1;

          if (!(listePortals.chercher(unPortal)))
            listePortals.ajouter(unPortal);
        }

        // cas |- (coin)
        if ((carte->testBas(i)) && (carte->testDroite(i))
            && (!(carte->testHaut(i))) && (!(carte->testGauche(i))))
        {

          unPortal.TYPE = HORIZ;
          unPortal.x2 = materiaux[i].trEBF->sommet[0].x;
          unPortal.z2 = materiaux[i].trEBF->sommet[0].z;

          unPoint = chercheGauche(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPoint.x;
          unPortal.z1 = unPortal.z2;

          if (!(listePortals.chercher(unPortal)))
            listePortals.ajouter(unPortal);
        }

        // cas -| (coin)
        if ((carte->testBas(i)) && (carte->testGauche(i))
            && (!(carte->testHaut(i))) && (!(carte->testDroite(i))))
        {

          unPortal.TYPE = HORIZ;
          unPortal.x1 = materiaux[i].trGCD->sommet[0].x;
          unPortal.z1 = materiaux[i].trGCD->sommet[2].z;

          unPoint = chercheDroite(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPoint.x;
          unPortal.z2 = unPortal.z1;

          if (!(listePortals.chercher(unPortal)))
            listePortals.ajouter(unPortal);
        }

        // cas bloc isole, tres chiant à traiter...
        if ((!(carte->testBas(i))) && (!(carte->testGauche(i)))
            && (!(carte->testHaut(i))) && (!(carte->testDroite(i))))
        {

          // ==X
          unPortal.TYPE = HORIZ;
          unPortal.x2 = materiaux[i].trEAB->sommet[0].x;
          unPortal.z2 = materiaux[i].trEAB->sommet[0].z;

          unPoint = chercheGauche(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPoint.x;
          unPortal.z1 = unPortal.z2;

          if (!(carte->testHautGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          unPortal.z2 = materiaux[i].trEAB->sommet[2].z;
          unPoint = chercheGauche(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPoint.x;
          unPortal.z1 = unPortal.z2;

          if (!(carte->testBasGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          // X==
          unPortal.TYPE = HORIZ;

          unPortal.x1 = materiaux[i].trGCD->sommet[0].x;
          unPortal.z1 = materiaux[i].trGCD->sommet[2].z;

          unPoint = chercheDroite(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPoint.x;
          unPortal.z2 = unPortal.z1;

          if (!(carte->testHautDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          unPortal.z1 = materiaux[i].trGCD->sommet[0].z;
          unPoint = chercheDroite(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPoint.x;
          unPortal.z2 = unPortal.z1;

          if (!(carte->testBasDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          // les portals au dessus
          unPortal.TYPE = VERTI;
          unPortal.x2 = materiaux[i].trHAE->sommet[1].x;
          unPortal.z2 = materiaux[i].trHAE->sommet[1].z;

          unPoint = chercheHaut(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPortal.x2;
          unPortal.z1 = unPoint.z;

          if (!(carte->testHautGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          unPortal.x2 = materiaux[i].trHAE->sommet[0].x;
          unPoint = chercheHaut(i, unPortal.x2, unPortal.z2, carte);
          unPortal.x1 = unPortal.x2;
          unPortal.z1 = unPoint.z;

          if (!(carte->testHautDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          // les portals en dessous
          unPortal.TYPE = VERTI;
          unPortal.x1 = materiaux[i].trFBC->sommet[0].x;
          unPortal.z1 = materiaux[i].trFBC->sommet[0].z;

          unPoint = chercheBas(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPortal.x1;
          unPortal.z2 = unPoint.z;

          if (!(carte->testBasGauche(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

          unPortal.x1 = materiaux[i].trFBC->sommet[2].x;
          unPoint = chercheBas(i, unPortal.x1, unPortal.z1, carte);
          unPortal.x2 = unPortal.x1;
          unPortal.z2 = unPoint.z;

          if (!(carte->testBasDroite(i)))
          {
            if (!(listePortals.chercher(unPortal)))
              listePortals.ajouter(unPortal);
          }

        }

      }
    }
  }

  listePortals.coupePortals();
  listePortals.index_portals();
}

void LABYRINTHE::creeSecteurs()
{
  elementPortal *temp;
  char toto;                    // type du portal (nom à changer)
  double xGauche = 0, xDroite = 0, zBas = 0, zHaut = 0;

  temp = listePortals.getDebut();

  // if (listePortals.NPORTALS == 0)
//     {
//       xGauche =
//         chercheXgauche(10,10, carte->taille);

//       xDroite =
//         chercheXdroite(10,10, carte->taille);

//       zBas = chercheZbas(10,10, carte->taille);

//       zHaut = chercheZhaut(10,10, carte->taille);

//       listeSecteurs.nouveauSecteur(xGauche, xDroite, zHaut, zBas);
//       remplitSecteur();
//     }

//   else {

  // on parcourt tous les portals
  while (temp)
  {
    toto = temp->getTYPE();
    switch (toto)
    {
    case HORIZ:

      // coordonnees du secteur au dessus du portal
      xGauche =
        chercheXgauche(temp->getx1() + 1, temp->getz1() - 1, carte->taille);

      xDroite =
        chercheXdroite(temp->getx1() + 1, temp->getz1() - 1, carte->taille);

      zBas = temp->getz1();

      zHaut =
        chercheZhaut(temp->getx1() + 1, temp->getz1() - 1, carte->taille);

      if (!(listeSecteurs.existence(xGauche, xDroite, zHaut, zBas)))
      {
        listeSecteurs.nouveauSecteur(xGauche, xDroite, zHaut, zBas);
        // ajoute portals et polygones au secteur
        remplitSecteur();
      }

      // coordonnees du secteur au dessous
      xGauche =
        chercheXgauche(temp->getx2() - 1, temp->getz1() + 1, carte->taille);

      xDroite =
        chercheXdroite(temp->getx1() + 1, temp->getz1() + 1, carte->taille);

      zBas = chercheZbas(temp->getx1() + 1, temp->getz1() + 1, carte->taille);

      zHaut = temp->getz1();

      if (!(listeSecteurs.existence(xGauche, xDroite, zHaut, zBas)))
      {

        // printf("Coordonnees du portal : x1=%f x2=%f z1=%f z2=%f\n",
        // temp->getx1(),temp->getx2(),temp->getz1(),temp->getz2());

        // fprintf(stderr,"au dessous secteur: x1=%f x2=%f z1=%f z2=%f\n",
        // xGauche,xDroite,zHaut,zBas);
        listeSecteurs.nouveauSecteur(xGauche, xDroite, zHaut, zBas);
        remplitSecteur();
      }

      break;

    case VERTI:

      // coordonnees du secteur à gauche du portal
      xGauche =
        chercheXgauche(temp->getx1() - 1, temp->getz1() + 1, carte->taille);

      xDroite = temp->getx1();

      zBas = chercheZbas(temp->getx1() - 1, temp->getz1() + 1, carte->taille);

      zHaut =
        chercheZhaut(temp->getx1() - 1, temp->getz1() + 1, carte->taille);

      if (!(listeSecteurs.existence(xGauche, xDroite, zHaut, zBas)))
      {
        listeSecteurs.nouveauSecteur(xGauche, xDroite, zHaut, zBas);
        remplitSecteur();
      }

      // coordonnees du secteur à droite du portal
      xGauche = temp->getx1();

      xDroite =
        chercheXdroite(temp->getx1() + 1, temp->getz1() + 1, carte->taille);

      zBas = chercheZbas(temp->getx1() + 1, temp->getz1() + 1, carte->taille);

      zHaut =
        chercheZhaut(temp->getx1() + 1, temp->getz1() + 1, carte->taille);

      if (!(listeSecteurs.existence(xGauche, xDroite, zHaut, zBas)))
      {
        listeSecteurs.nouveauSecteur(xGauche, xDroite, zHaut, zBas);
        remplitSecteur();
      }

      break;
    }
    temp = temp->getSuivant();
  }

  // connexions portal => deux secteurs

  temp = listePortals.getDebut();
  while (temp)
  {
    switch (temp->portal.TYPE)
    {
    case HORIZ:
      temp->portal.connexion1 =
        (ElementSecteur *) listeSecteurs.ouSuisJe(temp->portal.x1 + 1,
                                                  temp->portal.z1 - 1);
      temp->portal.connexion2 =
        (ElementSecteur *) listeSecteurs.ouSuisJe(temp->portal.x1 + 1,
                                                  temp->portal.z1 + 1);
      break;
    case VERTI:
      temp->portal.connexion1 =
        (ElementSecteur *) listeSecteurs.ouSuisJe(temp->portal.x1 - 1,
                                                  temp->portal.z1 + 1);
      temp->portal.connexion2 =
        (ElementSecteur *) listeSecteurs.ouSuisJe(temp->portal.x1 + 1,
                                                  temp->portal.z1 + 1);
      break;
    }

    temp = temp->getSuivant();
  }

  printf("Checking for bad sectors... ");
  check_null_sectors();
  printf("done.\n");
  //}
}

void LABYRINTHE::check_null_sectors()
{
  int i=0, j=0;
  double xGauche = 0, xDroite = 0, zBas = 0, zHaut = 0;
  ElementSecteur *temp=0;
  for (i = 0; i < carte->taille * carte->taille; i++)
    {

      for (j = 0; j < materiaux[i].n_triangles; j++)
	{
	  if (materiaux[i].triangles[j].type == SOL)
	    {
	      temp = listeSecteurs.ouSuisJe(materiaux[i].triangles[j].sommet[0].x, materiaux[i].triangles[j].sommet[0].z);
	      
	      if (temp == NULL) {
		/* we are not in a sector */
		//printf("ERROR: not in a sector\n");
		xGauche = chercheXgauche(materiaux[i].triangles[j].sommet[0].x+1,materiaux[i].triangles[j].sommet[0].z+1,carte->taille);
		
		xDroite = chercheXdroite(materiaux[i].triangles[j].sommet[0].x+1,materiaux[i].triangles[j].sommet[0].z+1, carte->taille);

		zHaut = chercheZhaut(materiaux[i].triangles[j].sommet[0].x+1,materiaux[i].triangles[j].sommet[0].z+1, carte->taille);

		zBas = chercheZbas(materiaux[i].triangles[j].sommet[0].x+1,materiaux[i].triangles[j].sommet[0].z+1, carte->taille);

		

		if (!(listeSecteurs.existence(xGauche, xDroite, zHaut, zBas)))
		  {
		    //printf("Creating new sector\n");
		    listeSecteurs.nouveauSecteur(xGauche,xDroite,zHaut,zBas);
		    remplitSecteur();
		  }

	      }
	    }
	 
	  
	}                 
    }
}

void LABYRINTHE::remplitSecteur()
{
  int i = 0, j = 0, k = 0, toto = 0, positionCase_x = 0, positionCase_z = 0;
  elementPortal *temp;
  ElementBonus unBonus;

  //printf("--------- Nouveau sect., je présume ?\n");

  // connexions secteur => plusieurs portals

  if (listePortals.NPORTALS)
    {
      temp = listePortals.getDebut();
      while (temp)
	{
	  if ((temp->portal.x1 >= listeSecteurs.courant->xmin)
	      && (temp->portal.x2 <= listeSecteurs.courant->xmax)
	      && (temp->portal.z1 >= listeSecteurs.courant->zmin)
	      && (temp->portal.z2 <= listeSecteurs.courant->zmax))
	    {
	      listeSecteurs.ajouter(&(temp->portal));
	    }
	  temp = temp->getSuivant();
	}
    }
  // connexions secteur => polygones

  for (i = 0; i < carte->taille * carte->taille; i++)
  {

    for (j = 0; j < materiaux[i].n_triangles; j++)
    {
      toto = 0;

      for (k = 0; k < 3; k++)
      {
        if (
            (materiaux[i].triangles[j].sommet[k].x >=
             listeSecteurs.courant->xmin)
            && (materiaux[i].triangles[j].sommet[k].x <=
                listeSecteurs.courant->xmax)
            && (materiaux[i].triangles[j].sommet[k].z >=
                listeSecteurs.courant->zmin)
            && (materiaux[i].triangles[j].sommet[k].z <=
                listeSecteurs.courant->zmax))
        {
          toto++;

        }
      }
      // on ajoute des triangles, pas des sommets, donc il faut 3 points OK
      if (toto == 3) {
        listeSecteurs.ajouter(&(materiaux[i].triangles[j]));
      }

    }                           // fin du 2e for (j)

    // et se charge des bonus (bonii)

    unBonus.x = (i % (carte->taille)) * SCALE_FACTOR + 1.5; // + SCALE_FACTOR
                                                           // / 2;
    unBonus.z = floor(i / (carte->taille)) * SCALE_FACTOR + 1.5; // +
                                                                // SCALE_FACTOR 
                                                                // / 2;

    positionCase_x = (int) floor(unBonus.x / SCALE_FACTOR);
    positionCase_z = (int) floor(unBonus.z / SCALE_FACTOR);
    unBonus.type =
      carte->maillage[positionCase_z * carte->taille + positionCase_x].bonus;
    unBonus.caseCarte = positionCase_z * carte->taille + positionCase_x;

    unBonus.parametre = carte->maillage[unBonus.caseCarte].paramBonus;

    switch (unBonus.type)
    {
    case -1:
      unBonus.y = 0.09f;
      break;
    case SHMIXGOMME:
      unBonus.y = 0.6f;
      break;
    default:
      unBonus.y = 0.5f;
    }

    // CHANGE ICI

    if ((unBonus.x > listeSecteurs.courant->xmin)
        && (unBonus.x < listeSecteurs.courant->xmax)
        && (unBonus.z > listeSecteurs.courant->zmin)
        && (unBonus.z < listeSecteurs.courant->zmax))

      if (unBonus.type == -1)
	{
	  if ((carte->maillage[unBonus.caseCarte].tex_sol > -1) 
	      && (carte->maillage[unBonus.caseCarte].bonus == -1)
        && (carte->maillage[unBonus.caseCarte].special == -1))
	  
	    listeSecteurs.ajouter(unBonus);
	}
    
      else listeSecteurs.ajouter(unBonus);

  }                             // fin du 2eme for

}

double LABYRINTHE::chercheXgauche(double xCourant, double zCourant,
                                  int tailleCarte)
{
  int i = 0;
  double distMin = xCourant;
  double xMin = -1;
  double distance = 0;
  elementPortal *tempo;

  double xRabotte = xCourant;
  double zRabotte = zCourant;

  // on cherche d'abord dans les murs
  for (i = 0; i < tailleCarte * tailleCarte; i++)
  {

    // est-ce un mur ?
    if (materiaux[i].trGCD)
    {

      // est-il sur la meme ligne et a gauche ?
      if ((materiaux[i].trGCD->sommet[1].z >= zRabotte)
          && (materiaux[i].trGCD->sommet[2].z <= zRabotte)
          && (materiaux[i].trGCD->sommet[0].x <= xRabotte))
      {

        // on calcule la distance
        distance = xRabotte - materiaux[i].trGCD->sommet[0].x;
        // printf("calcul: %f\n",distance);
        if (distance < distMin)
        {
          distMin = distance;
          xMin = materiaux[i].trGCD->sommet[0].x;
          // printf("adjugé ! : %f\n",distMin);

        }
      }
    }
  }
  if (xMin >= 0)
  {
  }
  else
  {
    fprintf(stderr, "Erreur : pas de xMin à gauche.\n");
    fprintf(stderr, "Parametres: Xc=%f ; Zc=%f\nExiting.",xCourant,zCourant);
    exit(1);
  }

  // on cherche ensuite dans les portals
  tempo = listePortals.getDebut();
  // printf("pour rappel, distMin=%f\n",distMin);
  while (tempo)
  {

    // on s'interresse aux portals verticaux
    if ((tempo->getTYPE() == VERTI) && (tempo->getx1() <= xRabotte)
        && (tempo->getz1() <= zRabotte) && (tempo->getz2() >= zRabotte))
    {

      distance = xRabotte - tempo->getx1();

      if (distance < distMin)
      {
        distMin = distance;
        xMin = tempo->getx2();

        // printf("adgugé 2 ! %f et Xmin=%f, x1=%f x2=%f
        // courant=%f\n",distMin,xMin,tempo->getx1(),tempo->getx2(),
        // xCourant);
      }
    }
    tempo = tempo->getSuivant();

  }

  return xMin;

}

double LABYRINTHE::chercheXdroite(double xCourant, double zCourant,
                                  int tailleCarte)
{
  int i = 0;
  double distMin = tailleCarte * (SCALE_FACTOR + 1) - xCourant;
  double xMax = -1;
  double distance = 0;
  elementPortal *tempo;

  double xRabotte = xCourant;
  double zRabotte = zCourant;

  // on cherche d'abord dans les murs
  for (i = 0; i < tailleCarte * tailleCarte; i++)
  {

    // est-ce un mur ?
    if (materiaux[i].trEAB)
    {

      // est-il sur la meme ligne et a droite ?
      if ((materiaux[i].trEAB->sommet[2].z >= zRabotte)
          && (materiaux[i].trEAB->sommet[1].z <= zRabotte)
          && (materiaux[i].trEAB->sommet[0].x >= xRabotte))
      {

        // on calcule la distance
        distance = materiaux[i].trEAB->sommet[0].x - xRabotte;
        // printf("calcul: %f\n",distance);
        if (distance < distMin)
        {
          distMin = distance;
          xMax = materiaux[i].trEAB->sommet[0].x;
          // printf("adjugé ! : %f\n",distMin);

        }
      }
    }
  }
  if (xMax >= 0)
  {
  }
  else
  {
    fprintf(stderr, "Erreur : pas de xMax à droite.\n");
    fprintf(stderr, "Parametres: Xc=%f ; Zc=%f\nExiting.",xCourant,zCourant);
    exit(1);
  }

  // on cherche ensuite dans les portals
  tempo = listePortals.getDebut();
  // printf("pour rappel, distMin=%f\n",distMin);
  while (tempo)
  {

    // on s'interresse aux portals verticaux
    if ((tempo->getTYPE() == VERTI) && (tempo->getx1() >= xRabotte)
        && (tempo->getz1() <= zRabotte) && (tempo->getz2() >= zRabotte))
    {

      distance = tempo->getx1() - xRabotte;

      if (distance < distMin)
      {
        distMin = distance;
        xMax = tempo->getx2();
      }
    }
    tempo = tempo->getSuivant();

  }

  return xMax;
}

double LABYRINTHE::chercheZbas(double xCourant, double zCourant,
                               int tailleCarte)
{
  int i = 0;
  double distMin = tailleCarte * (SCALE_FACTOR + 1) - zCourant;
  double zMax = -1;
  double distance = 0;
  elementPortal *tempo;

  double xRabotte = xCourant;
  double zRabotte = zCourant;

  // on cherche d'abord dans les murs
  for (i = 0; i < tailleCarte * tailleCarte; i++)
  {

    // est-ce un mur ?
    if (materiaux[i].trHAE)
    {

      // est-il sur la meme colonne et en bas ?
      if ((materiaux[i].trHAE->sommet[0].x >= xRabotte)
          && (materiaux[i].trHAE->sommet[1].x <= xRabotte)
          && (materiaux[i].trHAE->sommet[0].z >= zRabotte))
      {

        // on calcule la distance
        distance = materiaux[i].trHAE->sommet[0].z - zRabotte;
        // printf("calcul: %f\n",distance);
        if (distance < distMin)
        {
          distMin = distance;
          zMax = materiaux[i].trHAE->sommet[0].z;
        }
      }
    }
  }
  if (zMax >= 0)
  {
  }
  else
  {
    fprintf(stderr, "Erreur : pas de zMax en bas.\n");
    fprintf(stderr, "Parametres: Xc=%f ; Zc=%f\nExiting.",xCourant,zCourant);
    exit(1);
  }

  // on cherche ensuite dans les portals
  tempo = listePortals.getDebut();
  while (tempo)
  {

    // on s'interresse aux portals horizontaux
    if ((tempo->getTYPE() == HORIZ) && (tempo->getz1() >= zRabotte)
        && (tempo->getx1() <= xRabotte) && (tempo->getx2() >= xRabotte))
    {

      distance = tempo->getz1() - zRabotte;

      if (distance < distMin)
      {
        distMin = distance;
        zMax = tempo->getz1();
      }
    }
    tempo = tempo->getSuivant();

  }

  return zMax;
}

double LABYRINTHE::chercheZhaut(double xCourant, double zCourant,
                                int tailleCarte)
{
  int i = 0;
  double distMin = zCourant;
  double zMin = -1;
  double distance = 0;
  elementPortal *tempo;

  double xRabotte = xCourant;
  double zRabotte = zCourant;

  // on cherche d'abord dans les murs
  for (i = 0; i < tailleCarte * tailleCarte; i++)
  {

    // est-ce un mur ?
    if (materiaux[i].trFBC)
    {

      // est-il sur la meme colonne et en haut ?
      if ((materiaux[i].trFBC->sommet[2].x >= xRabotte)
          && (materiaux[i].trFBC->sommet[1].x <= xRabotte)
          && (materiaux[i].trFBC->sommet[0].z <= zRabotte))
      {

        // on calcule la distance
        distance = zRabotte - materiaux[i].trFBC->sommet[0].z;
        // printf("calcul: %f\n",distance);
        if (distance < distMin)
        {
          distMin = distance;
          zMin = materiaux[i].trFBC->sommet[0].z;
        }
      }
    }
  }
  if (zMin >= 0)
  {
  }
  else
  {
    fprintf(stderr, "Erreur : pas de zMin en haut.\n");
    fprintf(stderr, "Parametres: Xc=%f ; Zc=%f\nExiting.",xCourant,zCourant);
    exit(1);
  }

  // on cherche ensuite dans les portals
  tempo = listePortals.getDebut();
  while (tempo)
  {

    // on s'interresse aux portals horizontaux
    if ((tempo->getTYPE() == HORIZ) && (tempo->getz1() <= zRabotte)
        && (tempo->getx1() <= xRabotte) && (tempo->getx2() >= xRabotte))
    {

      distance = zRabotte - tempo->getz1();

      if (distance < distMin)
      {
        distMin = distance;
        zMin = tempo->getz1();
      }
    }
    tempo = tempo->getSuivant();

  }

  return zMin;
}

POINT2D LABYRINTHE::chercheGauche(int pos, double x, double z, CARTE * carte)
{
  int i = 0, j = 0, k = 0;
  POINT2D bonPoint;

  bonPoint.z = z;
  bonPoint.x = 0;

  for (i = 0; i < carte->taille * carte->taille; i++)
  {

    for (j = 0; j < materiaux[i].n_triangles; j++)
    {

      if (materiaux[i].triangles[j].type >= MUR_1)
      {

        for (k = 0; k < 3; k++)
        {

          if ((materiaux[i].triangles[j].sommet[k].z == z)
              && (materiaux[i].triangles[j].sommet[k].x < x)
              && (materiaux[i].triangles[j].sommet[k].x >= bonPoint.x))
          {
            bonPoint.x = materiaux[i].triangles[j].sommet[k].x;

          }
        }
      }
    }
  }
  return bonPoint;
}

POINT2D LABYRINTHE::chercheDroite(int pos, double x, double z, CARTE * carte)
{
  int i = 0, j = 0, k = 0;
  POINT2D bonPoint;

  bonPoint.z = z;
  bonPoint.x = carte->taille * carte->taille * 2;

  for (i = 0; i < carte->taille * carte->taille; i++)
  {

    for (j = 0; j < materiaux[i].n_triangles; j++)
    {

      if (materiaux[i].triangles[j].type >= MUR_1)
      {

        for (k = 0; k < 3; k++)
        {

          if ((materiaux[i].triangles[j].sommet[k].z == z)
              && (materiaux[i].triangles[j].sommet[k].x > x)
              && (materiaux[i].triangles[j].sommet[k].x <= bonPoint.x))
          {
            bonPoint.x = materiaux[i].triangles[j].sommet[k].x;

          }
        }
      }
    }
  }
  return bonPoint;
}

POINT2D LABYRINTHE::chercheHaut(int pos, double x, double z, CARTE * carte)
{
  int i = 0, j = 0, k = 0;
  POINT2D bonPoint;

  bonPoint.z = 0;
  bonPoint.x = x;

  for (i = 0; i < carte->taille * carte->taille; i++)
  {

    for (j = 0; j < materiaux[i].n_triangles; j++)
    {

      if (materiaux[i].triangles[j].type >= MUR_1)
      {

        for (k = 0; k < 3; k++)
        {

          if ((materiaux[i].triangles[j].sommet[k].x == x)
              && (materiaux[i].triangles[j].sommet[k].z < z)
              && (materiaux[i].triangles[j].sommet[k].z >= bonPoint.z))
          {
            bonPoint.z = materiaux[i].triangles[j].sommet[k].z;

          }
        }
      }
    }
  }
  return bonPoint;
}

POINT2D LABYRINTHE::chercheBas(int pos, double x, double z, CARTE * carte)
{
  int i = 0, j = 0, k = 0;
  POINT2D bonPoint;

  bonPoint.z = carte->taille * carte->taille * 2;
  bonPoint.x = x;

  for (i = 0; i < carte->taille * carte->taille; i++)
  {

    for (j = 0; j < materiaux[i].n_triangles; j++)
    {

      if (materiaux[i].triangles[j].type >= MUR_1)
      {

        for (k = 0; k < 3; k++)
        {

          if ((materiaux[i].triangles[j].sommet[k].x == x)
              && (materiaux[i].triangles[j].sommet[k].z > z)
              && (materiaux[i].triangles[j].sommet[k].z <= bonPoint.z))
          {
            bonPoint.z = materiaux[i].triangles[j].sommet[k].z;

          }
        }
      }
    }
  }
  return bonPoint;
}
