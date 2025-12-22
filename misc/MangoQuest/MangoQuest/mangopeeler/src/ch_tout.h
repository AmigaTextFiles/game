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

#ifndef CH_TOUT_H
#define CH_TOUT_H
struct CHEMINS_GENERAUX {
  char *chemins__mur[N_THUMBS];
  char *chemins__sol[N_THUMBS];
  char *chemins__pla[N_THUMBS];
  char *chemin__grille;
};

CODE_RETOUR chargeInterface();
CODE_RETOUR chargement_taille_map();
void charge_textures_variables(CHEMINS_GENERAUX * Chemins_textures);
void charge_grille(CHEMINS_GENERAUX * lesChemins);
void affiche_image_splash();
void charge_apercus();
void charge_explorateurs();
void charge_onglets();
void charge_cadre();
void incruste_apercus();
#endif
