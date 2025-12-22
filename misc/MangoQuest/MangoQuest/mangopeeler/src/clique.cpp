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

#include <SDL/SDL.h>
#include "sge_draw.h"
#include <SDL/SDL_ttf.h>

#include "share.h"
#include "polices.h"
#include "volet.h"
#include "carte.h"
#include "editeur.h"

extern CARTE *carte;
extern int TabParamSpecial[NUM_SPECIAL];

int MiN(int x, int y)
{
  if (x < y)
    return x;
  else
    return y;
}

int MaX(int x, int y)
{
  if (x > y)
    return x;
  else
    return y;
}

CLIQUE_ET_GLISSE::CLIQUE_ET_GLISSE(int taille)
{
  debut.x = debut.y = fin.x = fin.y = compteur = compteur_2 = en_cours = 0;
  TAILLE_CASE = 700 / taille;
}

void CLIQUE_ET_GLISSE::commence(const SDL_Event * evenement)
{
  debut.x =
    (int) floor((evenement->button.x - 12) / TAILLE_CASE) * TAILLE_CASE + 12;

  debut.y =
    (int) floor((evenement->button.y - 45) / TAILLE_CASE) * TAILLE_CASE + 45;

  // debut.x=100; debut.y=100;

  debut_x_sauvegarde = case_debut.x = (debut.x - 12) / TAILLE_CASE;
  case_debut.y = (debut.y - 45) / TAILLE_CASE;

  en_cours = 1;

  case_avant.x = case_debut.x;
  case_avant.y = case_debut.y;
  // printf("CASE_debut.y:%d\n", case_debut.y);
}

// CLIQUE_ET_GLISSE::rectangle
// Cette fonction dessine un rectangle sur la surface donnee en argument
// (generalement l'ecran) et a besoin d'une surface de sauvegarde pour
// rafraichir le tout (generalement la grille)

void CLIQUE_ET_GLISSE::rectangle(const SDL_Event * evenement,
                                 SDL_Surface * surface,
                                 SDL_Surface * sauvegarde)
{
  int couleur1, couleur2, couleur3;

  if (evenement->button.button == 1)
  {
    couleur1 = couleur2 = couleur3 = 230;
  }
  else
  {
    couleur1 = 200;
    couleur2 = 220;
    couleur3 = 255;
  }
  SDL_Rect destination;

  // determination de la case ou est le curseur

  if ((evenement->button.x < 712) && (evenement->button.x > 12))
  {
    case_en_cours.x =
      ((int)
       floor(((evenement->button.x - 12) / TAILLE_CASE) * TAILLE_CASE + 12) -
       12) / TAILLE_CASE;
  }

  if (evenement->button.x > 712)
    case_en_cours.x = (712 - 13) / TAILLE_CASE;
  if (evenement->button.x < 12)
    case_en_cours.x = 15 / TAILLE_CASE;

  if ((evenement->button.y < 745) && (evenement->button.y > 23))
  {
    case_en_cours.y =
      ((int)
       floor(((evenement->button.y - 45) / TAILLE_CASE) * TAILLE_CASE + 45) -
       45) / TAILLE_CASE;
  }

  if (evenement->button.y > 745)
    case_en_cours.y = (745 - 46) / TAILLE_CASE;
  if (evenement->button.y < 23)
    case_en_cours.y = 24 / TAILLE_CASE;

  // changement de case => rafraichissement

  if ((case_en_cours.x != case_avant.x) || (case_en_cours.y != case_avant.y))
  {
    if (((case_en_cours.x < case_avant.x) && (case_avant.x > case_debut.x))
        || ((case_en_cours.x > case_avant.x) && (case_avant.x < case_debut.x))
        || ((case_en_cours.y > case_avant.y) && (case_avant.y < case_debut.y))
        || ((case_en_cours.y < case_avant.y)
            && (case_avant.y > case_debut.y)))
    {
      destination.x = 12;       // grille
      destination.y = 45;
      destination.w = sauvegarde->w;
      destination.h = sauvegarde->h;
      SDL_BlitSurface(sauvegarde, NULL, surface, &destination);
      // SDL_UpdateRect(surface, 12,45,700,700);

      /*SDL_UpdateRect(surface,
                     (MiN(case_avant.x, case_debut.x) * TAILLE_CASE) + 12,
                     (MiN(case_avant.y, case_debut.y) * TAILLE_CASE) + 45,
                     (MaX(case_avant.x, case_debut.x) - MiN(case_avant.x,
                                                            case_debut.x) +
                      1) * TAILLE_CASE, (MaX(case_avant.y,
                                             case_debut.y) - MiN(case_avant.y,
                                                                 case_debut.
                                                                 y) +
                                         1) * TAILLE_CASE);*/

      /*SDL_UpdateRect(surface,
                     (case_debut.x * TAILLE_CASE) + 12,
                     (case_en_cours.y * TAILLE_CASE) + 45,
                     (case_en_cours.x-case_debut.x +1) * TAILLE_CASE, 
		     (case_avant.y-case_en_cours.y +1) * TAILLE_CASE);*/

      if ((case_en_cours.x < case_avant.x) && (case_avant.x > case_debut.x))
	SDL_UpdateRect(surface,
                     (case_en_cours.x * TAILLE_CASE) + 12,
                     (MiN(MiN(case_en_cours.y,case_avant.y),case_debut.y) * TAILLE_CASE) + 45,
                     (case_avant.x-case_en_cours.x +1) * TAILLE_CASE, 
		     (MaX(MaX(case_en_cours.y,case_avant.y),case_debut.y)-MiN(MiN(case_en_cours.y,case_avant.y),case_debut.y) +1) * TAILLE_CASE);

      if ((case_en_cours.y < case_avant.y)&& (case_avant.y > case_debut.y))
	SDL_UpdateRect(surface,
                     (MiN(case_debut.x,MiN(case_en_cours.x,case_avant.x)) * TAILLE_CASE) + 12,
                     (case_en_cours.y * TAILLE_CASE) + 45,
                     (MaX(MaX(case_en_cours.x,case_avant.x),case_debut.x)-MiN(MiN(case_en_cours.x,case_avant.x),case_debut.x) +1) * TAILLE_CASE, 
		     (case_avant.y-case_en_cours.y +1) * TAILLE_CASE);

      if ((case_en_cours.y > case_avant.y) && (case_avant.y < case_debut.y))
	SDL_UpdateRect(surface,
		       (MiN(case_debut.x,MiN(case_en_cours.x,case_avant.x)) * TAILLE_CASE) + 12,
		       (case_avant.y * TAILLE_CASE) + 45,
		       (MaX(MaX(case_en_cours.x,case_avant.x),case_debut.x)-MiN(MiN(case_en_cours.x,case_avant.x),case_debut.x) +1) * TAILLE_CASE, 
		       (case_en_cours.y-case_avant.y +1) * TAILLE_CASE);

      if ((case_en_cours.x > case_avant.x) && (case_avant.x < case_debut.x))
	SDL_UpdateRect(surface,
                     (case_avant.x * TAILLE_CASE) + 12,
                     (MiN(MiN(case_en_cours.y,case_avant.y),case_debut.y) * TAILLE_CASE) + 45,
                     (case_en_cours.x-case_avant.x +1) * TAILLE_CASE, 
		     (MaX(MaX(case_en_cours.y,case_avant.y),case_debut.y)-MiN(MiN(case_en_cours.y,case_avant.y),case_debut.y) +1) * TAILLE_CASE);

    }

  //}
  case_avant.x = case_en_cours.x;
  case_avant.y = case_en_cours.y;

  // trace du rectangle

  if ((evenement->button.x >= debut.x) && (evenement->button.y >= debut.y))
  {
    sge_FilledRect(surface, 12 + case_debut.x * TAILLE_CASE,
                   45 + case_debut.y * TAILLE_CASE,
                   MiN(
                       ((int)
                        floor((evenement->button.x - 12) / TAILLE_CASE +
                              1) * TAILLE_CASE + 11), 712),
                   MiN(
                       ((int)
                        floor((evenement->button.y - 45) / TAILLE_CASE +
                              1) * TAILLE_CASE + 44), 745), couleur1,
                   couleur2, couleur3);

  }

  if ((evenement->button.x < debut.x) && (evenement->button.y >= debut.y))
  {

    sge_FilledRect(surface,
                   ((int) floor((evenement->button.x - 12) / TAILLE_CASE) *
                    TAILLE_CASE + 13), MaX(45 + case_debut.y * TAILLE_CASE,
                                           12),
                   11 + (case_debut.x + 1) * TAILLE_CASE,
                   MiN(
                       ((int)
                        floor((evenement->button.y - 45) / TAILLE_CASE +
                              1) * TAILLE_CASE + 44), 745), couleur1,
                   couleur2, couleur3);
  }

  if ((evenement->button.x < debut.x) && (evenement->button.y < debut.y))
  {
    sge_FilledRect(surface,
                   ((int) floor((evenement->button.x - 12) / TAILLE_CASE) *
                    TAILLE_CASE + 13),
                   MaX(
                       ((int) floor((evenement->button.y - 45) / TAILLE_CASE)
                        * TAILLE_CASE + 45), 45),
                   11 + (case_debut.x + 1) * TAILLE_CASE,
                   44 + (case_debut.y + 1) * TAILLE_CASE, couleur1, couleur2,
                   couleur3);
  }

  if ((evenement->button.x >= debut.x) && (evenement->button.y <= debut.y))
  {
    sge_FilledRect(surface, 12 + case_debut.x * TAILLE_CASE,
                   MaX(
                       ((int) floor((evenement->button.y - 45) / TAILLE_CASE)
                        * TAILLE_CASE + 45), 45),
                   MiN(
                       ((int)
                        floor((evenement->button.x - 12) / TAILLE_CASE +
                              1) * TAILLE_CASE + 11), 712),
                   44 + (case_debut.y + 1) * TAILLE_CASE, couleur1, couleur2,
                   couleur3);
  }
  }
}

void CLIQUE_ET_GLISSE::determineCaseFin(int sourisX, int sourisY)
{
  if ((sourisX < 712) && (sourisX > 12))
  {
    fin.x = (int) floor((sourisX - 12) / TAILLE_CASE) * TAILLE_CASE + 12;
  }

  if (sourisX > 712)
    fin.x = 711;
  if (sourisX < 12)
    fin.x = 15;

  if ((sourisY < 745) && (sourisY > 23))
  {
    fin.y = (int) floor((sourisY - 45) / TAILLE_CASE) * TAILLE_CASE + 45;
  }

  if (sourisY > 745)
    fin.y = 744;
  if (sourisY < 23)
    fin.y = 24;

  case_fin.x = (fin.x - 12) / TAILLE_CASE;
  case_fin.y = (fin.y - 45) / TAILLE_CASE;
}

void CLIQUE_ET_GLISSE::termineAjout(const SDL_Event * evenement, int item,
                                    unsigned short int mode, int isCTRL)
{

  en_cours = 0;
  int compteur1 = 0;
  int compteur2 = 0;
  int rafraichir_plafond = 0;

  int rafraichir_bonus = 0;
  int caseDyn = 0;

  int longueurX = 0, longueurY = 0;

  determineCaseFin(evenement->button.x, evenement->button.y);

  if ((mode==SPECIAL)||(mode==BONUS)) {
    case_debut.x=case_fin.x;
    case_debut.y=case_fin.y;
  }

  longueurY = MaX(case_debut.y, case_fin.y) - MiN(case_debut.y, case_fin.y);
  longueurX = MaX(case_debut.x, case_fin.x) - MiN(case_debut.x, case_fin.x);

  // printf("longeur X : %d , longeur Y : %d\n",longueurX, longueurY); 

  for (compteur1 = 0; compteur1 <= longueurY; compteur1++)
  {

    for (compteur2 = 0; compteur2 <= longueurX; compteur2++)
    {
      caseDyn =
        ((MiN(case_debut.y, case_fin.y)) + compteur1) * carte->taille +
        MiN(case_debut.x, case_fin.x) + compteur2;

      if (mode == SPECIAL)
      {
        if (carte->getItem(SOL, caseDyn) >= 0)
        {

          if (item <= SHMIXMAN_B)
          {
            if (carte->caseDepShmixman >= 0)
              carte->setItem(SPECIAL, carte->caseDepShmixman, -1);
            carte->caseDepShmixman = caseDyn;

            rafraichir_bonus = 1;
          }

	  if (item == FINISH_POS)
          {
            if (carte->caseFinShmixman >= 0)
              carte->setItem(SPECIAL, carte->caseFinShmixman, -1);
            carte->caseFinShmixman = caseDyn;

            rafraichir_bonus = 1;
          }

          if ((item >= TEL_D1) && (item <= TEL_A5))
          {
            if (carte->teleporteurs[item - TEL_D1] >= 0)
              carte->setItem(SPECIAL, carte->teleporteurs[item - TEL_D1], -1);
            carte->teleporteurs[item - TEL_D1] = caseDyn;
            rafraichir_bonus = 1;
          }

          carte->setItem(SPECIAL, caseDyn, item);
          carte->setItem(BONUS, caseDyn, -1);

        }
      }

      else if (mode == BONUS)
      {
        if (carte->getItem(SOL, caseDyn) >= 0)
        {
          //if (!(isCTRL)) {
	    //carte->setItem(BONUS, caseDyn, item);
	    //carte->setItem(SPECIAL, caseDyn, -1);
	  //}

	  //else {

	    if (carte->getItem(SPECIAL, caseDyn) == -1)
	      carte->setItem(BONUS, caseDyn, item);
	  //}
        }
      }

      else
      {
        if ((item >= 0) && (item < 12))
        {
          // on met un sol et on pete le mur
          if (!(isCTRL)) {
	    
	    carte->setItem(SOL, caseDyn, item);

	    if (carte->getItem(MUR, caseDyn) >= 0)
	      {
		carte->setItem(MUR, caseDyn, -1);
		rafraichir_plafond = 1;
	      }
	  }

	  // ctrl+click gauche
	  else {
	    if (carte->getItem(MUR, caseDyn) == -1)
	      {
		carte->setItem(SOL, caseDyn, item);
	      }
	  }

        }

        if ((item > 11) && (item < 24))
        {
          // on met un plafond uniquement s'il n'y a pas de mur 
          if (carte->getItem(MUR, caseDyn) < 0)
          {
            carte->setItem(PLAFOND, caseDyn, item);
          }
        }

        if (item > 23)
        {
	  /* we reset player start and finnish pos if needed */
	  if (carte->caseDepShmixman == caseDyn)
	    carte->caseDepShmixman=-1;

	  if (carte->caseFinShmixman == caseDyn)
	    carte->caseFinShmixman=-1;

          // on met un mur et on pete tout le reste
          carte->setItem(MUR, caseDyn, item);
          carte->setItem(SOL, caseDyn, -1);
          carte->setItem(PLAFOND, caseDyn, -1);
          carte->setItem(BONUS, caseDyn, -1);
	  carte->setItem(SPECIAL, caseDyn, -1);



        }
      }
    }
  }
  // //////////////////////////////////////////////////////////////////////////

  for (compteur_2 = 0; compteur_2 <= longueurY; compteur_2++)
  {

    for (compteur = 0; compteur <= longueurX; compteur++)
    {

      rect_destination.x = case_debut.x * TAILLE_CASE;
      rect_destination.y = case_debut.y * TAILLE_CASE;
      rect_destination.w = carte->textures[item]->w;
      rect_destination.h = carte->textures[item]->h;

      caseDyn = case_debut.y * carte->taille + case_debut.x;

      if (mode == SPECIAL)
      {
        if (carte->getItem(SOL, caseDyn) >= 0)
        {
          SDL_BlitSurface(carte->petitsSpecial[item], NULL,
                          carte->i_grilles[SPECIAL], &rect_destination);

        }
      }

      else if (mode == BONUS)
      {
        if (carte->getItem(SOL, caseDyn) >= 0)
        {

	  //if (!(isCTRL)) {
	    //SDL_BlitSurface(carte->petitsBonus[item], NULL,
                          //carte->i_grilles[BONUS], &rect_destination);
	  //}

	  //else {
	    if (carte->getItem(SPECIAL, caseDyn) == -1)
	      SDL_BlitSurface(carte->petitsBonus[item], NULL,
                          carte->i_grilles[BONUS], &rect_destination);
	  //}
          
        }
      }

      else
      {

        if (item < 12)
        {       

	  if (!(isCTRL)) {
	    SDL_BlitSurface(carte->textures[item], NULL, carte->i_grilles[SOL],
			    &rect_destination);
	    SDL_BlitSurface(carte->textures[item], NULL,
			    carte->i_grilles[BONUS], &rect_destination);

	    if (carte->getItem(BONUS, caseDyn) >= 0)
	      SDL_BlitSurface(carte->
			      petitsBonus[carte->getItem(BONUS, caseDyn)], NULL,
			      carte->i_grilles[BONUS], &rect_destination);

	    if (carte->getItem(SPECIAL, caseDyn) >= 0)
	      SDL_BlitSurface(carte->
			      petitsSpecial[carte->getItem(SPECIAL, caseDyn)], NULL,
			      carte->i_grilles[SPECIAL], &rect_destination);
	  }

	  // ctrl+click gauche
	  else {
	    if (carte->getItem(MUR, caseDyn) == -1)
	      {
		SDL_BlitSurface(carte->textures[item], NULL, carte->i_grilles[SOL],
			    &rect_destination);
		SDL_BlitSurface(carte->textures[item], NULL,
			    carte->i_grilles[BONUS], &rect_destination);

		if (carte->getItem(BONUS, caseDyn) >= 0)
		  SDL_BlitSurface(carte->
				  petitsBonus[carte->getItem(BONUS, caseDyn)], NULL,
				  carte->i_grilles[BONUS], &rect_destination);

		if (carte->getItem(SPECIAL, caseDyn) >= 0)
		  SDL_BlitSurface(carte->
				  petitsSpecial[carte->getItem(SPECIAL, caseDyn)], NULL,
				  carte->i_grilles[SPECIAL], &rect_destination);
	      }
	  }

                // c'est un sol 
          
        }
        else if ((item > 11) && (item < 24))
        {
          // c'est un plafond, on ne le met que s'il n'y a pas de mur
          if (carte->getItem(MUR, caseDyn) < 0)
          {
            SDL_BlitSurface(carte->textures[item], NULL,
                            carte->i_grilles[PLAFOND], &rect_destination);
          }
        }

        else
        {                       // c'est un mur 
          SDL_BlitSurface(carte->textures[item], NULL, carte->i_grilles[SOL],
                          &rect_destination);
          SDL_BlitSurface(carte->textures[item], NULL,
                          carte->i_grilles[PLAFOND], &rect_destination);
          SDL_BlitSurface(carte->textures[item], NULL,
                          carte->i_grilles[BONUS], &rect_destination);
        }
      }

      if (case_debut.x < case_fin.x)
        case_debut.x += 1;
      else
        case_debut.x -= 1;
    }                           // fin du 2eme for

    if (case_debut.y < case_fin.y)
      case_debut.y += 1;
    else
      case_debut.y -= 1;
    case_debut.x = debut_x_sauvegarde;

  }                             // fin du 1er for

  if (rafraichir_plafond)
  {
    carte->effaceGrille(PLAFOND);
    carte->refaitPlafonds();
  }

  if (rafraichir_bonus)
  {
    carte->effaceGrille(BONUS);
    carte->refaitBonus();
  }
}

void CLIQUE_ET_GLISSE::termineEnleve(const SDL_Event * evenement,
                                     unsigned short int mode, int encours,
				     int isCTRL)
{
  en_cours = 0;
  int compteur1 = 0;
  int compteur2 = 0;
  int caseDyn = 0;

  int longueurX = 0, longueurY = 0;

  rect_destination.x = 0;
  rect_destination.y = 0;
  rect_destination.w = 700;
  rect_destination.h = 700;

  carte->effaceGrille(mode);

  determineCaseFin(evenement->button.x, evenement->button.y);
  if ((mode==SPECIAL)||(mode==BONUS)) {
    case_debut.x=case_fin.x;
    case_debut.y=case_fin.y;
  }

  longueurX = MaX(case_debut.x, case_fin.x) - MiN(case_debut.x, case_fin.x);
  longueurY = MaX(case_debut.y, case_fin.y) - MiN(case_debut.y, case_fin.y);

  // on efface tout ce qui est concerne
  for (compteur1 = 0; compteur1 <= longueurY; compteur1++)
  {
    for (compteur2 = 0; compteur2 <= longueurX; compteur2++)
    {
      caseDyn =
        ((MiN(case_debut.y, case_fin.y)) + compteur1) * carte->taille +
        MiN(case_debut.x, case_fin.x) + compteur2;

      if (mode == SPECIAL) 
	{
	  if ((carte->getItem(mode, caseDyn) > -1)
	    && (carte->getItem(mode, caseDyn) <= SHMIXMAN_B))
	    carte->caseDepShmixman = -1;

	  if ((carte->getItem(mode, caseDyn) > -1)
	    && (carte->getItem(mode, caseDyn) >= TEL_D1)
	      && (carte->getItem(mode, caseDyn) <= TEL_A5))
	    {
	      carte->teleporteurs[carte->getItem(mode, caseDyn)-TEL_D1] = -1;
	    }
	    
	}

      if (isCTRL) 
	{ 
	  if (carte->getItem(mode, caseDyn) == encours)
	    carte->setItem(mode, caseDyn, -1);
	}
      else
	carte->setItem(mode, caseDyn, -1);

    }
  }

  // et on reconstruit (à optimiser)
  carte->concretiseCarte();
}
