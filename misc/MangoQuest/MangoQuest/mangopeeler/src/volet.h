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

#ifndef _VOLET_H_
#define _VOLET_H_

enum {
  SHMIXGOMME,
  VIE,  
  BOUCLIER,
  ARMAGGEDON,
  ONDEDECHOC,  
  STOPTEMPS,
  
  ULTRAPOINTS,
  GLACON,
  RAPIDE,
  COUPDEBOL, 
  
  NUIT,
  PERDBONUS,
  INVERTTOUCHES,
  PLAFOND,
  FOG,
  MALUSMAP,
  ANTIBOITES,
  FREEZESHX,
  LENT,
  HASARD,
  
  NUM_BONUS
};

enum {
  SHMIXMAN_G,
  SHMIXMAN_D,
  SHMIXMAN_H,
  SHMIXMAN_B,

  FOYER,

  TEL_D1,
  TEL_D2,
  TEL_D3,
  TEL_D4,
  TEL_D5,

  TEL_A1,
  TEL_A2,
  TEL_A3,
  TEL_A4,
  TEL_A5,

  LIMITE_TEMPS,
  VIES,
  FINISH_POS,

  NUM_SPECIAL
};

class VOLET {
public:
  VOLET();
  virtual ~ VOLET();

  void charge();
  int getMode() { return mode;
  } virtual void rafraichit();
  virtual void selectionne();
  virtual void changeItem(Uint16 sourisX, Uint16 sourisY);
  int itemEnCours;              // la texture / le bonus en cours

  int mode;                     // SOL, PLAFOND, MUR, BONUS, SPECIAL

protected:
   SDL_Surface * i_onglet;      // image du petit onglet en haut

  void effaceAide();
  void rectangle(int x1, int x2, int y1, int y2);
  virtual void chargeBase();
  virtual void chargeApercus();
  virtual void incrusteApercus();

  virtual void afficheAide();
};

class VOLET_TEXTURES:public VOLET { public:
  VOLET_TEXTURES();
  ~VOLET_TEXTURES();

  void rafraichit();
  void selectionne();
  void changeItem(Uint16 sourisX, Uint16 sourisY);

  SDL_Surface *i_sol, *i_mur, *i_pla;
  SDL_Surface *i_sol_passif, *i_mur_passif, *i_pla_passif;

private:
   SDL_Surface * i_apercus_tex_mur[N_THUMBS];
  SDL_Surface *i_apercus_tex_sol[N_THUMBS];
  SDL_Surface *i_apercus_tex_pla[N_THUMBS];

  void chargeBase();
  void chargeApercus();
  void incrusteApercus();

  void afficheAide();

};

class VOLET_BONUS:public VOLET { public:
  VOLET_BONUS();
  ~VOLET_BONUS();

  void rafraichit();
  void selectionne();
  void changeItem(Uint16 sourisX, Uint16 sourisY);

  void changeParam(int valeur, int lequel);
  void incrementeParam(unsigned short int facon);

private:
   SDL_Surface * i_bonus;
  SDL_Surface *i_apercus_bonus[N_BONUS];

  void chargeBase();
  void chargeApercus();
  void incrusteApercus();
  void ecritParams();
  void ecritParamPartout();
  void afficheAide();
};

class VOLET_SPECIAL:public VOLET { public:
  VOLET_SPECIAL();
  ~VOLET_SPECIAL();

  void rafraichit();
  void selectionne();
  void changeItem(Uint16 sourisX, Uint16 sourisY);

  void changeParam(int valeur, int lequel);
  void incrementeParam(unsigned short int facon);

private:
   SDL_Surface * i_special;
  SDL_Surface *i_apercus_special[N_BONUS];
//  SDL_Surface *i_param, *i_param_vierge;

  void chargeBase();
  void chargeApercus();
  void incrusteApercus();
  void ecritParams();
  void ecritParamPartout();
  void afficheAide();
};

#endif
