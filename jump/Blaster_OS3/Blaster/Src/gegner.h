// Gegner.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#ifndef _GEGNER_
#define _GEGNER_

#include "coRect.h"
#include <SDL.h>

class Gegner{ 

        private:
                int x, y;
		int xDim,yDim;	//Verwendet für das CoRect und die Levelkolissionsabfrage
		int tempo;
		int frame, count, schussAusgeloest;		//Regelt Animation
		Uint32 startzeit;		//Regelt dauer von gewissen Animationsphasen
		int xRichtung, yRichtung;
		SDL_Surface *aktBild; //das jeweilige bild mit den Frames, wird im Konstruktor zugewiesen
		Uint8 alphaValue;		//Setzt Alpha- Wert fest, wird beim Tod verwendet. (langsames Ausblenden).
                bool links, rechts, fall, schuss, granate, bombe, stationaer, sterbend;
		bool facingLeft;
		bool isAlive;	// nötig, um Verwaltung von Gegnern in Array zu ermöglichen. isAlive = false bedeutet inaktive array- elemente
               // bool facingLeft;
		SDL_Rect framePos[14];
		
		void schussAusloesen (int ID);
		void granateAusloesen (int ID);
		

        public:
                Gegner(int x, int y, int xDim, int yDim, int typ, int tempo = 4);
		Gegner( ) { isAlive = false; }
                 
                CoRect coRect, lRect, rRect, uRect;
                bool move(int index);
		void display(SDL_Surface* main);
		
		int getX() {return x;}
		int getY() {return y;}
		void setX(int param) { x += param;}
		void setY(int param) { y += param;}
		bool getIsAlive() { return isAlive; }
		void loeschen() { isAlive =false; }
		



}; 

#endif
