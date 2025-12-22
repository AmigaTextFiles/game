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
 
#ifndef _CARTE_H_
#define _CARTE_H_

#include <zlib.h>

struct __POINT__                // changer le nom
{
  int x, y;
  int direction;
};

struct CUBE {
  int tex_sol;
  int tex_pla;
  int tex_mur;

  int bonus;
  int paramBonus;
  int special;
  int paramSpecial;
};

class CARTE { 
public:
  CARTE();
  ~CARTE();

  int getItem(int mode, int quelleCase);
  void setItem(int mode, int quelleCase, int nouveau);

  void chargeBitmaps(SDL_Surface * splash_screen, POLICES * polices);
  void chargeGrille(SDL_Surface * splash_screen, POLICES * polices);

  void dechargeBitmaps();

  void nouvelleCarte(int tailleCarte, int mondeCarte, char *fichierCarte);

  void reset_moi_ca();

  char setTeleport();
  //char getTeleport();
  int sauvegarder(void);
  void save_geom(gzFile fichier);

  void charger(char *nom_fichier);

  void concretiseCarte();
  void creeMiniMap();
  void refaitPlafonds();
  void refaitBonus();
  void effaceGrille(int mode);

  void afficherGrille(int laquelle); /* (mode : SOL, PLAFOND, MUR, BONUS,
                                        SPECIAL) */

  unsigned char testGauche(int pos);
  unsigned char testDroite(int pos);
  unsigned char testHaut(int pos);
  unsigned char testBas(int pos);
  unsigned char testHautDroite(int pos);
  unsigned char testHautGauche(int pos);
  unsigned char testBasDroite(int pos);
  unsigned char testBasGauche(int pos);

  char *nomFichier;
  int taille;
  int tailleCase;
  int tailleMiniCase;
  int chargee;
  int nombreFoyers;

  int monde;
  int compteur, compteur2;
  CUBE *maillage;

  SDL_Surface *i_grille_vide;
  SDL_Surface *i_grilles[5];

  SDL_Surface *textures[3 * N_THUMBS];
  SDL_Surface *miniTex[N_THUMBS];
  SDL_Surface *petitsBonus[NUM_BONUS];
  SDL_Surface *petitsSpecial[NUM_SPECIAL];

  int caseDepShmixman;
  int caseFinShmixman;
  int limiteTemps;              // en secondes
  int teleporteurs[10];         // positions des 10 bornes
  int num_lives;

  int compatibility_n;

private:
  //FILE *fichier;

};

#endif
