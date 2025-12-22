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

#ifndef _EDITEUR_H_
#define _EDITEUR_H_

#define P_FONT_SPLASH "data/font.ttf"

#define SOL 0
#define PLAFOND 1
#define MUR 2
#define BONUS 3
#define SPECIAL 4

struct _POINT_ {
  int x, y;
};

class CLIQUE_ET_GLISSE { public:
  CLIQUE_ET_GLISSE(int tailleMap);

  void determineCaseDebut();
  void determineCaseFin(int sourisX, int sourisY);

  void commence(const SDL_Event * evenement);
  void rectangle(const SDL_Event * evenement, SDL_Surface * surface,
                 SDL_Surface * sauvegarde);

  void termineAjout(const SDL_Event * evenement, int numero_texture,
                    unsigned short int quoi, int isCTRL);

  void termineEnleve(const SDL_Event * evenement, unsigned short int quoi,
		     int encours, int isCTRL);

  unsigned short int en_cours;

private:
   _POINT_ debut;
  _POINT_ fin;
  _POINT_ case_debut, case_fin;
  _POINT_ case_en_cours, case_avant;
  SDL_Rect rect_destination;
  unsigned short int compteur, compteur_2;
  int debut_x_sauvegarde;
  int TAILLE_CASE;

};

//SDL_Surface * charge_image(const char *chemin);

void charge_tout(int tailleMap, int mondeMap, char *fichierMap);
void detruit_tout();
void affiche_support_splash();

//CODE_RETOUR chargement();
void affiche_interface(int avec_splash);
void fauxSplash();

void loop_moi_ca();

//CODE_RETOUR chargement_taille_map();
void toggle_plein_ecran();
void selectionne_onglet(int lequel);
void change_texture_sol(SDL_Event * evenement);
void change_texture_plafond(SDL_Event * evenement);
void change_texture_mur(SDL_Event * evenement);
void rectangle(int x1, int x2, int y1, int y2);
void texte_ttf(char *phrase, int x, int y, TTF_Font * police);

#endif
