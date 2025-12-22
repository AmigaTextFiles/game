// Granate.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#ifndef _GRANATE_
#define _GRANATE_


#include <SDL.h>
#include "coRect.h"

class Granate {
	
	private:
		int xCoor, yCoor;
		int ID;	//zeigt wer Granate abgegeben hat
		int richtung;  //legt Richtung des Schusses fest, -1 für links, 1 für Rechts
		int explosionsStatus;
		bool steigend, isAlive;
		SDL_Surface* granatBild;
		int yAuf[8], yAb[8];
		int countdown,moveCount;	//Counter für Granatenbewegung und Zähler bis zur Explosion
		bool explodierend; //zeigt an ob Granate am explodieren ist oder noch fliegt
		SDL_Rect framePos[8];	//für Animation
		
		
	public:
		Granate(int x, int y, int richtung, int ID,  SDL_Surface* bild) : coRect(x,y,-1,-1,1){
			xCoor= x;
			yCoor= y;
			this->ID = ID;
			this->richtung = richtung;
			granatBild = bild;
			steigend = true;		//Granate steigt zu Beginn immer
			isAlive = true;
			countdown = moveCount = explosionsStatus =  0;
			explodierend = false;
			
			yAuf[0]=9;
			yAuf[1]=9;
			yAuf[2]=9;
			yAuf[3]=6;
			yAuf[4]=6;
			yAuf[5]=6;
			yAuf[6]=3;
			yAuf[7]=3;
			
			yAb[0]=3;
			yAb[1]=3;
			yAb[2]=6;
			yAb[3]=6;
			yAb[4]=6;
			yAb[5]=9;
			yAb[6]=9;
			yAb[7]=9;
			
			framePos[0].x= 0; framePos[0].y= 0; framePos[0].w=10 ; framePos[0].h =14;
			framePos[1].x= 10; framePos[1].y= 0; framePos[1].w=10 ; framePos[1].h =12;
			framePos[2].x= 20; framePos[2].y= 0; framePos[2].w=13 ; framePos[2].h =14;
			framePos[3].x= 33; framePos[3].y= 0; framePos[3].w=16 ; framePos[3].h =15;
			framePos[4].x= 49; framePos[4].y= 0; framePos[4].w=21 ; framePos[4].h =18;
			framePos[5].x= 70; framePos[5].y= 0; framePos[5].w=24 ; framePos[5].h =23;
			framePos[6].x= 94; framePos[6].y= 0; framePos[6].w=25 ; framePos[6].h =25;
			framePos[7].x= 119; framePos[7].y= 0; framePos[7].w=27 ; framePos[7].h =25;
		}
		Granate(){
			isAlive = false;
		}
		bool move();

		void display(SDL_Surface* main);
		
		int getX(){ return xCoor;}
		int getY(){ return yCoor;}
		void setX(int neu){xCoor = neu;}
		int getID() { return ID; }
		bool getIsAlive() { return isAlive; }
		void loeschen () { isAlive = false; }
		
		CoRect coRect;
		
};

#endif
		
		
		
		
		
		
		
		
		
		
		
