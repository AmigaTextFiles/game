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
#include "shxedit_win32.h"
#endif
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <SDL/SDL.h>
#include <SDL/SDL_ttf.h>
#include <string.h>
//#include <zlib.h>

#include "share.h"
#include "ch_tout.h"
#include "polices.h"
#include "volet.h"
#include "carte.h"

#include "geom.h"
#include "portals.h"
#include "bonus.h"
#include "secteur.h"
#include "labyr.h"

#include "editeur.h"

extern SDL_Surface *ecran;
extern SDL_Rect dest;
extern SDL_Color bleu;
extern const char *pathMondes[4];
extern const char *imagesBonus[NUM_BONUS];
extern const char *imagesSpecial[NUM_SPECIAL];
extern int TabParamBonus[NUM_BONUS];
extern int TabParamSpecial[NUM_SPECIAL];
extern POLICES *polices;
extern LABYRINTHE *labyr;

CARTE::CARTE()
{
  int i = 0;
  nomFichier = new char[255];

  maillage = 0;
  chargee = 0;
  compteur = compteur2 = 0;
  caseDepShmixman = -1;
  caseFinShmixman = -1;
  limiteTemps = 0;
  num_lives=3;

  for (i = 0; i < 10; i++)
    teleporteurs[i] = -1;

  compatibility_n = WRITE_COMPAT_NUMBER;
  nombreFoyers=0;
}

CARTE::~CARTE()
{
  delete[]nomFichier;
  
  for (compteur = 0; compteur < 3 * N_THUMBS; compteur++)
  {
    SDL_FreeSurface(textures[compteur]);
    textures[compteur] = 0;

    if (compteur < N_THUMBS)
    {
      SDL_FreeSurface(miniTex[compteur]);
      miniTex[compteur] = 0;
    }

    if (compteur < NUM_BONUS)
    {
      SDL_FreeSurface(petitsBonus[compteur]);
      petitsBonus[compteur] = 0;
    }

    if (compteur < NUM_SPECIAL)
    {
      SDL_FreeSurface(petitsSpecial[compteur]);
      petitsSpecial[compteur] = 0;
    }
  }

  SDL_FreeSurface(i_grilles[PLAFOND]);
  SDL_FreeSurface(i_grilles[SOL]);
  SDL_FreeSurface(i_grilles[BONUS]);
  SDL_FreeSurface(i_grille_vide);
}

void CARTE::reset_moi_ca()
{
  for (compteur = 0; compteur < taille * taille; compteur++)
  {
    maillage[compteur].tex_sol = maillage[compteur].tex_mur =
      maillage[compteur].tex_pla = maillage[compteur].bonus =
      maillage[compteur].special = maillage[compteur].paramBonus =
      maillage[compteur].paramSpecial = -1;
  }
}

void CARTE::nouvelleCarte(int tailleCarte, int mondeCarte, char *fichierCarte)
{
  taille = tailleCarte;
  tailleCase = 700 / taille;
  tailleMiniCase = 140 / taille;
  monde = mondeCarte;

  // risque de memory leak ici
  nomFichier = strncpy(nomFichier, fichierCarte, 255);

  printf("  *file : %s\n" "  *size  : %dx%d\n" "  *world   : %d\n",
         nomFichier, taille, taille, monde);

  maillage = new CUBE[taille * taille];

  reset_moi_ca();
}

char CARTE::setTeleport()
{
  int i=0;
  //printf("Teleporteurs: ");
  for (i=0; i<10; i++) {

    //printf("%d * ",teleporteurs[i]);

    if (i < 5) {
      if ((teleporteurs[i] >=0) && (teleporteurs[i+5] < 0)) {
	fprintf(stderr, "Error: teleport missing\n");
	return 0;
      }
    }

    else {
      if ((teleporteurs[i] >=0) && (teleporteurs[i-5] < 0)) {
	fprintf(stderr, "Error: teleport missing\n");
	return 0;
      }
    }
     
  }

  printf("\n");

  for (i=0; i< 10; i++) {

    if (i < 5) TabParamSpecial[i+TEL_D1] = teleporteurs[i+5];  
    else TabParamSpecial[TEL_A1+(i-5)] = teleporteurs[i-5];
  }

  //printf("Tableau:\n ");
  //for (i=0; i<NUM_SPECIAL; i++) printf("%d * ",TabParamSpecial[i]);
  //printf("\n");

  for (i=0; i<10; i++) {
    if (teleporteurs[i] >= 0) 
      maillage[teleporteurs[i]].paramSpecial = TabParamSpecial[maillage[teleporteurs[i]].special];
  }
  return 1;
}

// char CARTE::getTeleport()
// {
//   int i=0;

//   printf("\n");

//   for (i=0; i< 10; i++) {

//     if (i < 5) teleporteurs[i] = TabParamSpecial[i+TEL_A1];
//     else teleporteurs[i] = TabParamSpecial[TEL_D1+(i-5)];
//   }

//   printf("Teleporteurs:\n ");
//   for (i=0; i< 10; i++)  printf("%d * ",teleporteurs[i]);
//   printf("\n");

//   return 1;
// }

void CARTE::charger(char *nom_fichier)
{
  int *tableau;
  char *verification;           // verification qu'il s'agit bien d'une carte
  int num_shmolluxes=0, winning_post=0;

  nomFichier = strncpy(nomFichier, nom_fichier, 255);

  gzFile fichier;

  if (!(fichier = gzopen(nomFichier, "rb")))
  {
    fprintf(stderr, "Error opening file %s.\n",nomFichier);
    exit(1);
  }

  verification = new char[3];

  // chaque carte commence par la chaine "SHX"
  gzread(fichier, verification, sizeof(char)*3);

  if ((verification[0] != 'B') || (verification[1] != 'M')
      || (verification[2] != 'Q'))
  {
    printf("Error : This file is not a map for MangoQuest.\n");
    delete[]verification;
    exit(1);
  }

  gzread(fichier, &compatibility_n, sizeof(int)*1);

  if (compatibility_n < READ_COMPAT_NUMBER)
  {
    printf("Error: This map is not compatible with this version.\n");
    exit(1);
  }

  gzread(fichier, &taille, sizeof(int)*1);

//  printf ("Taille: %d\n", taille);
  gzread(fichier, &monde, sizeof(int)*1);

  printf("World: %d\n", monde);
  gzread(fichier, &limiteTemps, sizeof(int)*1);
  gzread(fichier, &nombreFoyers, sizeof(int)*1);
  gzread(fichier, &num_shmolluxes, sizeof(int)*1);
  gzread(fichier, &num_lives, sizeof(int)*1);
  gzread(fichier, &winning_post, sizeof(int)*1);

  tableau = new int[taille * taille * 7];
  gzread(fichier, tableau, sizeof(int)*taille * taille * 7);

  gzclose(fichier);
  // printf("fermeture du fichier.\n");
  if (maillage)
  {                             // on verifie si une carte est deja en
                                // memoire
    delete[]maillage;           // si c'est le cas on la detruit
    maillage = 0;
  }

  maillage = new CUBE[taille * taille];

  compteur2 = 0;
  for (compteur = 0; compteur < taille * taille; compteur++)
  {

    maillage[compteur].tex_sol = tableau[compteur2];
    maillage[compteur].tex_pla = tableau[compteur2 + 1];
    maillage[compteur].tex_mur = tableau[compteur2 + 2];

    maillage[compteur].bonus = tableau[compteur2 + 3];
    maillage[compteur].paramBonus = tableau[compteur2 + 4];

    maillage[compteur].special = tableau[compteur2 + 5];
    maillage[compteur].paramSpecial = tableau[compteur2 + 6];

    if ((maillage[compteur].special > -1)
        && (maillage[compteur].special <= SHMIXMAN_B))
    {
      caseDepShmixman = compteur;
    }

    if ((maillage[compteur].special >= TEL_D1)
        && (maillage[compteur].special <= TEL_A5))
    {
      teleporteurs[maillage[compteur].special - TEL_D1] = compteur;
    }

    compteur2 += 7;
  }
  delete[]tableau;
  delete[]verification;

  tailleCase = 700 / taille;
  tailleMiniCase = 140 / taille;

  chargee = 1;

//  printf ("Fin du chargement.\n");
}

int CARTE::sauvegarder(void)
{
  int *tableau = new int[taille * taille * 7];
  char integrite[3] = { 'B', 'M', 'Q' };
  char ceilingError=0; int winning_post=-1; int num_shmolluxes=0;
  gzFile fichier;

  polices->errorMessage("Saving map...");

  // printf("Ecriture... \n");  

  if (caseDepShmixman < 0) {
    fprintf(stderr,"Error: you must place Shmixman's position\n");
    polices->errorMessage("Error: you must place Shmixman's position");
    return 0;
  }

  if (setTeleport()==0) {
    fprintf(stderr,"Error: you must place the two parts of a teleport\n");
    polices->errorMessage("Error: you must place the two parts of a teleport");
    return 0;
  }
  
  compteur2 = 0;
  nombreFoyers=0;

  for (compteur = 0; compteur < taille * taille * 7; compteur += 7)
  {
    tableau[compteur] = maillage[compteur2].tex_sol;
    tableau[compteur + 1] = maillage[compteur2].tex_pla;
    tableau[compteur + 2] = maillage[compteur2].tex_mur;

    tableau[compteur + 3] = maillage[compteur2].bonus;
    tableau[compteur + 4] = maillage[compteur2].paramBonus;

    tableau[compteur + 5] = maillage[compteur2].special;
    tableau[compteur + 6] = maillage[compteur2].paramSpecial;
	 
    if (maillage[compteur2].special == FOYER) {
      nombreFoyers++;
      num_shmolluxes += maillage[compteur2].paramSpecial;
    }

    if (maillage[compteur2].special == FINISH_POS) winning_post=compteur2;
    if ((maillage[compteur2].tex_sol >= 0)&&(maillage[compteur2].tex_pla < 0))
      ceilingError=1;
    compteur2++;
    //if (maillage[compteur2].special == TEL_D1) printf("arrivee: %d\n",maillage[compteur2].paramSpecial);  
  }

  if (nombreFoyers == 0) {
    fprintf(stderr,"Error: you must place at least one Shmollux\n");
    polices->errorMessage("Error: you must place at least one Shmollux");
    delete [] tableau;
    return 0;
  }

  if (ceilingError) {
    fprintf(stderr,"Error: ceiling error\n");
    polices->errorMessage("Error: ceiling square(s) missing");
    delete [] tableau;
    return 0;
  }

  // printf("Ouverture...\n");
  if (!(fichier = (gzFile)gzopen(nomFichier, "wb9")))
  {
    fprintf(stderr, "Error creating file: %s.\n", nomFichier);
    exit(1);
  }

  compatibility_n = WRITE_COMPAT_NUMBER;

  gzwrite(fichier,integrite, sizeof(char)*3);
  gzwrite(fichier, &compatibility_n, sizeof(int)*1);
  gzwrite(fichier, &taille, sizeof(int)*1);
  gzwrite(fichier, &monde, sizeof(int)*1);
  gzwrite(fichier, &limiteTemps, sizeof(int)*1);
  gzwrite(fichier, &nombreFoyers, sizeof(int)*1);
  gzwrite(fichier, &num_shmolluxes, sizeof(int)*1);
  gzwrite(fichier, &num_lives, sizeof(int)*1);
  gzwrite(fichier, &winning_post, sizeof(int)*1);
  
  gzwrite(fichier, tableau, sizeof(int)* taille * taille * 7);

  // printf("Fermeture...\n");
  

  /* for (compteur = 0; compteur < 20 ; compteur ++) { printf("%d -- ",
     tableau[compteur]); } */

  save_geom(fichier);
  gzclose(fichier);
 
  creeMiniMap();

  fprintf(stderr,"Map %s saved successfuly.\n", nomFichier);
  polices->errorMessage("Map saved successfuly");

  delete[]tableau;
  return 1;
}

void CARTE::save_geom(gzFile fichier)
{
  int i=0;
  //FILE *fichier;
  ElementSecteur *unSecteur;
  ElementPPortal *unPPortal;
  ElementPTriangle *unPTriangle;
  ElementBonus *unBonus;
  elementPortal *unPortal;

  // if (!(fichier = fopen("default.mgq", "wb")))
//   {
//     fprintf(stderr, "Error creating file %s\n", nomFichier);
//     exit(1);
//   }

  printf("Saving geometry...\n");
  labyr = new LABYRINTHE;
  
  labyr->transforme_en_polygones();
  labyr->calculeNormales();
  labyr->creePortals();
  labyr->creeSecteurs();
  printf("%d portals.\n",labyr->listePortals.NPORTALS);
  printf("%d sectors.\n",labyr->listeSecteurs.cmptNum);

  gzwrite(fichier, &labyr->listePortals.NPORTALS, sizeof(int)* 1);
  unPortal = labyr->listePortals.getDebut();
  while (unPortal)
    {
      gzwrite(fichier, &unPortal->portal.x1, sizeof(double)* 1);
      gzwrite(fichier, &unPortal->portal.z1, sizeof(double)* 1);
      gzwrite(fichier, &unPortal->portal.x2, sizeof(double)* 1);
      gzwrite(fichier, &unPortal->portal.z2, sizeof(double)* 1);
      gzwrite(fichier, &unPortal->portal.TYPE, sizeof(char)* 1);
      gzwrite(fichier, &unPortal->portal.numero, sizeof(int)* 1);
      
      unPortal = unPortal->getSuivant();
    }

  gzwrite(fichier, &labyr->listeSecteurs.cmptNum, sizeof(int)* 1);
  unSecteur = labyr->listeSecteurs.getDebut();
  while (unSecteur)
    {
      //printf("----- NEW SECTOR -----\n");

      gzwrite(fichier, &unSecteur->xmin, sizeof(double)* 1);
      gzwrite(fichier, &unSecteur->zmin, sizeof(double)* 1);
      gzwrite(fichier, &unSecteur->xmax, sizeof(double)* 1);
      gzwrite(fichier, &unSecteur->zmax, sizeof(double)* 1);

      gzwrite(fichier, &unSecteur->listePPortals.nombre, sizeof(int)*1);
      unPPortal = unSecteur->listePPortals.getDebut();
      while(unPPortal) 
	{
	  gzwrite(fichier, &unPPortal->pportal->numero, sizeof(int)*1);
	  
	  unPPortal = unPPortal->getSuivant();
	}

      //printf(" - %d triangles\n", unSecteur->listePTriangles.nombre);
      gzwrite(fichier,&unSecteur->listePTriangles.nombre, sizeof(int)*1);
      unPTriangle = unSecteur->listePTriangles.getDebut();
      while(unPTriangle) 
	{
	  for (i=0; i<3; i++) {
	    gzwrite(fichier, &unPTriangle->ptriangle->sommet[i].x, 
		    sizeof(double)*1);
	    gzwrite(fichier, &unPTriangle->ptriangle->sommet[i].y, 
		   sizeof(double)*1);
	    gzwrite(fichier, &unPTriangle->ptriangle->sommet[i].z, 
		   sizeof(double)*1);
	    gzwrite(fichier, &unPTriangle->ptriangle->sommet[i].u, 
		   sizeof(double)*1);
	    gzwrite(fichier, &unPTriangle->ptriangle->sommet[i].v, 
		   sizeof(double)*1);
	  }
	  gzwrite(fichier, &unPTriangle->ptriangle->normal_x,sizeof(double)*1);
	  gzwrite(fichier, &unPTriangle->ptriangle->normal_y,sizeof(double)*1);
	  gzwrite(fichier, &unPTriangle->ptriangle->normal_z,sizeof(double)*1);

	  gzwrite(fichier, &unPTriangle->ptriangle->texture,sizeof(int)*1);
	  gzwrite(fichier, &unPTriangle->ptriangle->type,sizeof(char)*1);

	  unPTriangle = unPTriangle->getSuivant();
	}

      //printf(" - %d bonus\n", unSecteur->listeBonus.nombre);
      gzwrite(fichier, &unSecteur->listeBonus.nombre, sizeof(int)*1);
      unBonus = unSecteur->listeBonus.getDebut();
      while(unBonus) 
	{
	  gzwrite(fichier, &unBonus->caseCarte,sizeof(int)*1);
	  gzwrite(fichier, &unBonus->x,sizeof(double)*1);
	  gzwrite(fichier, &unBonus->y,sizeof(double)*1);
	  gzwrite(fichier, &unBonus->z,sizeof(double)*1);
	  gzwrite(fichier, &unBonus->type,sizeof(int)*1);
	  gzwrite(fichier, &unBonus->parametre,sizeof(int)*1);

	  unBonus = unBonus->getSuivant();
	}

      unSecteur = unSecteur->getSuivant();
    }

  //fclose(fichier);  
  delete labyr;


  printf("done.\n");

}

// concretiseCarte : remplit les 3 bitmaps (sol/mur ,  plafond, bonus/special)
// qui representent la carte aux yeux de l'utilisateur.
// cette fonction est appelee apres le chargement d'une carte.

void CARTE::concretiseCarte()
{
  int compteur = 0;

  SDL_Rect rect_destination;

  rect_destination.x = 0;
  rect_destination.y = 0;
  rect_destination.w = 700;
  rect_destination.h = 700;

  // on ecrase les grilles (remise à zero)
  SDL_BlitSurface(i_grille_vide, NULL, i_grilles[PLAFOND], &rect_destination);
  SDL_BlitSurface(i_grille_vide, NULL, i_grilles[SOL], &rect_destination);

  // on recree la carte en entier sur les grille vide
  for (compteur = 0; compteur < ((taille) * (taille)); compteur++)
  {

    if ((maillage[compteur].tex_sol >= 0) || (maillage[compteur].tex_mur >= 0)
        || (maillage[compteur].tex_pla >= 0)
        || (maillage[compteur].bonus >= 0))
    {

      rect_destination.x = (compteur % (taille)) * tailleCase;
      rect_destination.y = (int) (floor(compteur / taille)) * tailleCase;
      rect_destination.w = textures[0]->w;
      rect_destination.h = textures[0]->h;

      if (maillage[compteur].tex_sol >= 0)
      {
        SDL_BlitSurface(textures[maillage[compteur].tex_sol], NULL,
                        i_grilles[SOL], &rect_destination);
      }

      if (maillage[compteur].tex_mur >= 0)
      {
        SDL_BlitSurface(textures[maillage[compteur].tex_mur], NULL,
                        i_grilles[SOL], &rect_destination);
        SDL_BlitSurface(textures[maillage[compteur].tex_mur], NULL,
                        i_grilles[PLAFOND], &rect_destination);
      }

      if (maillage[compteur].tex_pla >= 0)
      {
        SDL_BlitSurface(textures[maillage[compteur].tex_pla], NULL,
                        i_grilles[PLAFOND], &rect_destination);
      }

    }                           // de if
  }
  // on s'occupe des bonus
  rect_destination.x = 0;
  rect_destination.y = 0;
  rect_destination.w = 700;
  rect_destination.h = 700;
  SDL_BlitSurface(i_grilles[SOL], NULL, i_grilles[BONUS], &rect_destination);

  for (compteur = 0; compteur < taille * taille; compteur++)
  {
    rect_destination.x = (compteur % (taille)) * tailleCase;
    rect_destination.y = (int) (floor(compteur / taille)) * tailleCase;
    rect_destination.w = textures[0]->w;
    rect_destination.h = textures[0]->h;

    if (maillage[compteur].bonus >= 0)
    {
      SDL_BlitSurface(petitsBonus[maillage[compteur].bonus], NULL,
                      i_grilles[BONUS], &rect_destination);
    }

    if (maillage[compteur].special >= 0)
    {
      SDL_BlitSurface(petitsSpecial[maillage[compteur].special], NULL,
                      i_grilles[SPECIAL], &rect_destination);

    }
  }
}

void CARTE::creeMiniMap()
{
  int compteur = 0;
  char *nomMinimap;
  char *nomMinimap_nb;
  SDL_Rect rect_destination;
  SDL_Surface *i_minimap = 0;
  SDL_Surface *i_minimap_nb = 0;
  SDL_Surface *i_noir=0;
  int tFichier = strlen(nomFichier);

  i_minimap = charge_image(SHXEDIT_DATA "interface/support_minimap.png");
  i_minimap_nb = charge_image(SHXEDIT_DATA "interface/support_minimap.png");
  i_noir = chargeStretch(SHXEDIT_DATA "interface/noir.png", tailleMiniCase, tailleMiniCase);

  for (compteur = 0; compteur < ((taille) * (taille)); compteur++)
  {

    if (maillage[compteur].tex_mur >= 0)
    {

      rect_destination.x = (compteur % (taille)) * tailleMiniCase;
      rect_destination.y = (int) (floor(compteur / taille)) * tailleMiniCase;
      rect_destination.w = miniTex[0]->w;
      rect_destination.h = miniTex[0]->h;

      // SDL_BlitSurface(miniTex[maillage[compteur].tex_mur - 2 * N_THUMBS],
//                       NULL, i_minimap, &rect_destination);

      SDL_BlitSurface(i_noir,NULL, i_minimap_nb, &rect_destination);
      SDL_BlitSurface(i_noir,NULL, i_minimap, &rect_destination);
    }
  }

  nomMinimap = new char[tFichier+1];
  nomMinimap_nb = new char[tFichier+2];

  strcpy(nomMinimap, nomFichier);
  nomFichier[tFichier] = '\0';
  nomMinimap[tFichier - 1] = 'p';
  nomMinimap[tFichier - 2] = 'm';
  nomMinimap[tFichier - 3] = 'b';

  strcpy(nomMinimap_nb, nomFichier);
  nomMinimap_nb[tFichier+1] = '\0';
  nomMinimap_nb[tFichier] = 'p';
  nomMinimap_nb[tFichier - 1] = 'm';
  nomMinimap_nb[tFichier - 2] = 'b';
  nomMinimap_nb[tFichier - 3] = '.';
  nomMinimap_nb[tFichier - 4] = '_';
  
  SDL_SaveBMP(i_minimap, nomMinimap);
  //printf("Saving %s!\n",nomMinimap_nb);
  //SDL_SaveBMP(i_minimap_nb, nomMinimap_nb);

  SDL_FreeSurface(i_minimap);
  SDL_FreeSurface(i_minimap_nb);
  SDL_FreeSurface(i_noir);

  delete nomMinimap;
  delete nomMinimap_nb;
}

void CARTE::refaitPlafonds()
{
  SDL_Rect rect_destination;

  for (compteur = 0; compteur < (taille * taille); compteur++)
  {

    if ((maillage[compteur].tex_sol >= 0) || (maillage[compteur].tex_mur >= 0)
        || (maillage[compteur].tex_pla >= 0))
    {

      rect_destination.x = (compteur % (taille)) * tailleCase;
      rect_destination.y = (int) (floor(compteur / taille)) * tailleCase;
      rect_destination.w = textures[0]->w;
      rect_destination.h = textures[0]->h;

      if (maillage[compteur].tex_mur >= 0)
      {
        SDL_BlitSurface(textures[maillage[compteur].tex_mur], NULL,
                        i_grilles[PLAFOND], &rect_destination);
      }

      if (maillage[compteur].tex_pla >= 0)
      {
        SDL_BlitSurface(textures[maillage[compteur].tex_pla], NULL,
                        i_grilles[PLAFOND], &rect_destination);
      }

    }
  }
}

void CARTE::refaitBonus()
{
  SDL_Rect rect_destination;

  rect_destination.x = 0;
  rect_destination.y = 0;
  rect_destination.w = 700;
  rect_destination.h = 700;
  SDL_BlitSurface(i_grilles[SOL], NULL, i_grilles[BONUS], &rect_destination);

  for (compteur = 0; compteur < ((taille) * (taille)); compteur++)
  {
    rect_destination.x = (compteur % (taille)) * tailleCase;
    rect_destination.y = (int) (floor(compteur / taille)) * tailleCase;
    rect_destination.w = textures[0]->w;
    rect_destination.h = textures[0]->h;

    if (maillage[compteur].bonus >= 0)
    {
      SDL_BlitSurface(petitsBonus[maillage[compteur].bonus], NULL,
                      i_grilles[BONUS], &rect_destination);
    }

    if (maillage[compteur].special >= 0)
    {
      SDL_BlitSurface(petitsSpecial[maillage[compteur].special], NULL,
                      i_grilles[SPECIAL], &rect_destination);
    }
  }
}

void CARTE::effaceGrille(int mode)
{
  dest.x = 0;
  dest.y = 0;
  dest.w = 700;
  dest.h = 700;

  // on ecrase la grille concernee (remise à zero)
  switch (mode)
  {
  case MUR:
    SDL_BlitSurface(i_grille_vide, NULL, i_grilles[PLAFOND], &dest);
    SDL_BlitSurface(i_grille_vide, NULL, i_grilles[SOL], &dest);
    break;
  case SOL:
    SDL_BlitSurface(i_grille_vide, NULL, i_grilles[SOL], &dest);
    break;
  case PLAFOND:
    SDL_BlitSurface(i_grille_vide, NULL, i_grilles[PLAFOND], &dest);
    break;
  case BONUS:
    SDL_BlitSurface(i_grille_vide, NULL, i_grilles[BONUS], &dest);
    break;
  case SPECIAL:
    SDL_BlitSurface(i_grille_vide, NULL, i_grilles[SPECIAL], &dest);
    break;
  }
}

void CARTE::chargeBitmaps(SDL_Surface * splash_screen, POLICES * polices)
{

  int compteur = 0;
  int compteur2 = 0;
  char *chemins__mur[N_THUMBS];
  char *chemins__sol[N_THUMBS];
  char *chemins__pla[N_THUMBS];

  // construction des noms de chemin pour le chargement
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {

    chemins__mur[compteur] = new char[255];

    sprintf(chemins__mur[compteur], SHXMAN_DATA "textures/%s/mur%02d.png",
            pathMondes[monde], compteur);

    chemins__sol[compteur] = new char[255];

    sprintf(chemins__sol[compteur], SHXMAN_DATA "textures/%s/sol%02d.png",
            pathMondes[monde], compteur);

    chemins__pla[compteur] = new char[255];

    sprintf(chemins__pla[compteur], SHXMAN_DATA "textures/%s/pla%02d.png",
            pathMondes[monde], compteur);
  }

  // chargement des "thumbs" de taille variable
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {

    textures[compteur] =
      chargeStretch(chemins__sol[compteur2], tailleCase, tailleCase);

    miniTex[compteur] =
      chargeStretch(chemins__mur[compteur2], tailleMiniCase, tailleMiniCase);

    compteur2++;
  }

  compteur2 = 0;
  for (compteur = N_THUMBS; compteur < 2 * N_THUMBS; compteur++)
  {

    textures[compteur] =
      chargeStretch(chemins__pla[compteur2], tailleCase, tailleCase);
    compteur2++;
  }

  compteur2 = 0;
  for (compteur = 2 * N_THUMBS; compteur < 3 * N_THUMBS; compteur++)
  {

    textures[compteur] =
      chargeStretch(chemins__mur[compteur2], tailleCase, tailleCase);
    compteur2++;
  }

  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {

    delete[]chemins__mur[compteur];
    delete[]chemins__sol[compteur];
    delete[]chemins__pla[compteur];
  }

  for (compteur = 0; compteur < NUM_BONUS; compteur++)
  {

    petitsBonus[compteur] =
      chargeStretch(imagesBonus[compteur], tailleCase, tailleCase);
  }

  for (compteur = 0; compteur < NUM_SPECIAL; compteur++)
  {

    petitsSpecial[compteur] =
      chargeStretch(imagesSpecial[compteur], tailleCase, tailleCase);
  }

}

void CARTE::chargeGrille(SDL_Surface * splash_screen, POLICES * polices)
{
  char *chemin__grille = new char[255];

  // polices->affiche_texte_ttf ("Chargement de la grille...", 135, 490,
  // FONT_SPLASH_PETIT, bleu, ecran);

  SDL_UpdateRect(ecran, 112, 208, splash_screen->w, splash_screen->h);

  sprintf(chemin__grille, SHXEDIT_DATA "interface/grille_%d.png", taille);

  i_grilles[SOL] = charge_image(chemin__grille);
  i_grilles[PLAFOND] = charge_image(chemin__grille);
  i_grilles[MUR] = i_grilles[SOL];
  i_grille_vide = charge_image(chemin__grille);
  i_grilles[BONUS] = charge_image(chemin__grille);
  i_grilles[SPECIAL] = i_grilles[BONUS];

  // SDL_SetAlpha(i_grilles[PLAFOND], SDL_SRCALPHA, 100); 

  delete[]chemin__grille;
}

void CARTE::afficherGrille(int laquelle)
{
  dest.x = 12;
  dest.y = 45;
  dest.w = i_grilles[SOL]->w;
  dest.h = i_grilles[SOL]->h;

  SDL_BlitSurface(i_grilles[laquelle], NULL, ecran, &dest);
  SDL_UpdateRect(ecran, 12, 45, 700, 700);
}

int CARTE::getItem(int mode, int quelleCase)
{
  switch (mode)
  {
  case MUR:
    return maillage[quelleCase].tex_mur;
    break;
  case SOL:
    return maillage[quelleCase].tex_sol;
    break;
  case PLAFOND:
    return maillage[quelleCase].tex_pla;
    break;
  case BONUS:
    return maillage[quelleCase].bonus;
    break;
  case SPECIAL:
    return maillage[quelleCase].special;
    break;

  }
  return -5;
}

void CARTE::setItem(int mode, int quelleCase, int nouveau)
{
  switch (mode)
  {
  case MUR:
    maillage[quelleCase].tex_mur = nouveau;
    break;
  case SOL:
    maillage[quelleCase].tex_sol = nouveau;
    break;
  case PLAFOND:
    maillage[quelleCase].tex_pla = nouveau;
    break;
  case BONUS:
    maillage[quelleCase].bonus = nouveau;
    if (nouveau < 0)
      maillage[quelleCase].paramBonus = -1;
    else
      maillage[quelleCase].paramBonus = TabParamBonus[nouveau];
    break;

  case SPECIAL:
    maillage[quelleCase].special = nouveau;
    if (nouveau < 0)
      maillage[quelleCase].paramSpecial = -1;
    else
      maillage[quelleCase].paramSpecial = TabParamSpecial[nouveau];
    break;
  }
}

unsigned char CARTE::testGauche(int pos)
{
  // on suppose que la valeur de pos est correcte
  if (pos % taille == 0)
  {
  }                             // on est sur le mur gauche

  if (maillage[pos - 1].tex_mur > -1)
    return 1;

  else
    return 0;
}

unsigned char CARTE::testDroite(int pos)
{
  if (pos % taille == (taille - 1))
  {
  }                             // on est sur le mur droit

  if (maillage[pos + 1].tex_mur > -1)
    return 1;
  else
    return 0;

}

unsigned char CARTE::testHaut(int pos)
{
  if (pos < taille)
  {
  }                             // on est sur le mur haut

  if (maillage[pos - taille].tex_mur > -1)
    return 1;
  else
    return 0;
}

unsigned char CARTE::testBas(int pos)
{
  if (floor(pos / taille) == (taille - 1))
  {
  }
  // (on est sur le mur bas)

  if (maillage[pos + taille].tex_mur > -1)
    return 1;
  else
    return 0;
}

unsigned char CARTE::testHautDroite(int pos)
{
  if (pos < taille)
  {
  }                             // on est sur le mur haut
  if (pos % taille == (taille - 1))
  {
  }                             // on est sur le mur droit

  if (maillage[pos - taille + 1].tex_mur > -1)
    return 1;
  else
    return 0;
}

unsigned char CARTE::testHautGauche(int pos)
{
  if (pos < taille)
  {
  }                             // on est sur le mur haut
  if (pos % taille == 0)
  {
  }                             // on est sur le mur gauche

  if (maillage[pos - taille - 1].tex_mur > -1)
    return 1;
  else
    return 0;
}

unsigned char CARTE::testBasGauche(int pos)
{
  if (floor(pos / taille) == (taille - 1))
  {
  }                             // (on est sur le mur bas)
  if (pos % taille == 0)
  {
  }                             // on est sur le mur gauche

  if (maillage[pos + taille - 1].tex_mur > -1)
    return 1;
  else
    return 0;
}

unsigned char CARTE::testBasDroite(int pos)
{
  if (floor(pos / taille) == (taille - 1))
  {
  }                             // (on est sur le mur bas)
  if (pos % taille == (taille - 1))
  {
  }                             // on est sur le mur gauche

  if (maillage[pos + taille + 1].tex_mur > -1)
    return 1;
  else
    return 0;
}
