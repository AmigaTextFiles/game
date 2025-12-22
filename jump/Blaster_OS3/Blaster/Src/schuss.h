// Schuss.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#ifndef _SCHUSS_
#define _SCHUSS_


#include <SDL.h>
#include "coRect.h"


class Schuss{
	private:
		int xCoor, yCoor, vektor;
		int richtung;  //legt Richtung des Schusses fest, -1 für links, 1 für Rechts
		int ID;	//zeigt wer Schuss abgegeben hat
		bool isAlive;
		SDL_Surface* schussBild;

	
	public:
		Schuss(int x, int y, int velo, int richt, int ID,  SDL_Surface* bild) : coRect(x,y,9,2,1){
			xCoor= x;
			yCoor= y;
			vektor = velo;
			richtung = richt;
			this->ID = ID;
			schussBild = bild;
			coRectPtr = &coRect;
			isAlive = true;
		}
		Schuss(){
			isAlive = false;
		}

		
		bool move();

		void display(SDL_Surface* main);
		
		int getX(){ return xCoor;}
		int getY(){ return yCoor;}
		int getVektor(){ return vektor;}
		void setX(int neu){xCoor = neu;}
		int getID() { return ID; }
		bool getIsAlive() { return isAlive; }
		void loeschen () { isAlive = false; }
		
		CoRect coRect;
		CoRect* coRectPtr;

		
};

#endif
