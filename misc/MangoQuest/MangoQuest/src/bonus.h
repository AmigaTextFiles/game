/*  The Blue Mango Quest
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
 
#ifndef _BONUS_H_
#define _BONUS_H_

int whichBonusActive();
void execute_bonus(int type);
void stock_bonus(int number);
void locate_dituboites();
void use_stocked_bonus(int which);
int has_player_stock();


// classe de base BONUS
class BONUS
{
public:

  BONUS() { actif=0; timer=0;}
  
  virtual ~BONUS();

  GLint liste;
  GLuint texture;
  int name;

#ifdef HAVE_SDL_MIXER
  Mix_Chunk *sound;
#endif

  int actif;
  CHRONOMETRE *timer;

  virtual void construit(GLint typeListe);
  void load_datas();
  void affiche (float x, float y , float z, char avecRotat, char updown);
  void setUpTimer(int parametre);
  char updateTimer();
  void cancelAction();
  virtual void agir (int parametre);
  virtual void annuleEffets ();
};

class DITUBOITE:public BONUS
{
  public:
  DITUBOITE () {valeur=1;}
  ~DITUBOITE () { glDeleteTextures(1,&texture);}

  void construit(GLint typeListe);	
  void agir (int parametre);
  void annuleEffets ();
  int valeur;
};

class B_VIE:public BONUS
{
 public:
  B_VIE () { }
  ~B_VIE () { glDeleteTextures(1,&texture);}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_HASARD:public BONUS
{
 public:
  B_HASARD () { }
  ~B_HASARD () { glDeleteTextures(1,&texture);}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};	

class B_NUIT:public BONUS
{
 public:
  B_NUIT () { }
  ~B_NUIT () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_GLACON:public BONUS
{
 public:
  B_GLACON () { }
  ~B_GLACON () {glDeleteTextures(1,&texture);if (timer) delete timer; }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_COUPDEBOL:public BONUS
{
 public:
  B_COUPDEBOL () { }
  ~B_COUPDEBOL () {glDeleteTextures(1,&texture); }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_ONDEDECHOC:public BONUS
{
 public:
  B_ONDEDECHOC () { }
  ~B_ONDEDECHOC () {glDeleteTextures(1,&texture); }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_SHMIXGOMME:public BONUS
{
 public:
  B_SHMIXGOMME () { }
  ~B_SHMIXGOMME () {glDeleteTextures(1,&texture); if (timer) delete timer; }

  //UNITE_TEMPS TimeLimit;
  //CHRONOMETRE *myTimer;
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
  //void setUpMyTimer(int parametre);
  //char updateMyTimer();
};

class B_BOUCLIER:public BONUS
{
 public:
  B_BOUCLIER () { }
  ~B_BOUCLIER () {glDeleteTextures(1,&texture);if (timer) delete timer; }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_PERDBONUS:public BONUS
{
 public:
  B_PERDBONUS () { }
  ~B_PERDBONUS () {glDeleteTextures(1,&texture); }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_ARMAGGEDON:public BONUS
{
 public:
  B_ARMAGGEDON () { }
  ~B_ARMAGGEDON () {glDeleteTextures(1,&texture); }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_RAPIDE:public BONUS
{
 public:
  B_RAPIDE () { }
  ~B_RAPIDE () {glDeleteTextures(1,&texture); if (timer) delete timer; }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_LENT:public BONUS
{
 public:
  B_LENT () { }
  ~B_LENT () {glDeleteTextures(1,&texture);if (timer) delete timer; }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_STOPTEMPS:public BONUS
{
 public:
  B_STOPTEMPS () { }
  ~B_STOPTEMPS () {glDeleteTextures(1,&texture); if (timer) delete timer; }
  
  //CHRONOMETRE *myTimer;
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
  //void setUpMyTimer(int parametre);
  //char updateMyTimer();
};

class B_ULTRAPOINTS:public BONUS
{
 public:
  B_ULTRAPOINTS () { }
  ~B_ULTRAPOINTS () {glDeleteTextures(1,&texture); if (timer) delete timer; }
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_INVERTTOUCHES:public BONUS
{
 public:
  B_INVERTTOUCHES () { }
  ~B_INVERTTOUCHES () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_PLAFOND:public BONUS
{
 public:
  B_PLAFOND () { }
  ~B_PLAFOND () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_FOG:public BONUS
{
 public:
  B_FOG () { }
  ~B_FOG () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_MALUSMAP:public BONUS
{
 public:
  B_MALUSMAP () { }
  ~B_MALUSMAP () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_ANTIBOITES:public BONUS
{
 public:
  B_ANTIBOITES () { }
  ~B_ANTIBOITES () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

class B_FREEZESHX:public BONUS
{
 public:
  B_FREEZESHX () { }
  ~B_FREEZESHX () {glDeleteTextures(1,&texture); if (timer) delete timer;}
	
  void construit(GLint typeListe);
  void agir (int parametre);
  void annuleEffets ();
};

#endif
