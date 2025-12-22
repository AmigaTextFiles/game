// Spieler.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#ifndef _SPIELER_
#define _SPIELER_

#include "coRect.h"
#include <SDL.h>
#include <ctime>


class Spieler{

	private:
		int x, y;
		int vec, dimX, dimY;	//vec=bewegungsgeschw., dimX + dimY = Ausdehnung des Sprites
		int frame, count;	//für Animation
		int sprungCount;
		int alphaValue; 	// ermöglicht AlphaBlending beim Tod
		int munitionsCount, granatCount, gemCount; 	//Vorrat an bestimmten Extras
		bool links, rechts, sprung, fall, kauernd, aufEis, sterbend, gewonnen;	 //Status- Variablen
		bool keyCard, keyCardRot, keyCardGreen; 	//geben an welche Keys spieler besitzt
		bool facingLeft, schuss, wurf;	//wichtig für die Darstellung
		bool unsterblich;		//für Unsterblichkeitsmodus
		SDL_Rect framePos[20];	//für Animation
		time_t startZeit; //Nötig für Unsterblichkeitsmodus
		void extraReaktion(int);


	public:
		Spieler(int x, int y,int xD, int yD) : coRect (x+5, y, xD-2, yD, 11),
			lRect(x-1,y,1,yD-1,11), rRect(x+xD+1, y, 1, yD-1,11), oRect(x, y-1 , xD, 1,11),
			uRect(x, y+yD, xD, 1,11){

				Spieler::x = x;
				Spieler::y = y;
				dimX = xD;
				dimY = yD;
				vec=4;
				frame=count=0;
				alphaValue = 255;
				gemCount = 0;
				munitionsCount = 6;
				granatCount = 6;
				keyCard = keyCardRot = keyCardGreen = false;
				schuss = wurf = false;
				unsterblich = false;

			for(int z=0; z<14; ++z){
  				framePos[z].x = z*27;
				framePos[z].y = 0;
				framePos[z].w = 27;
				framePos[z].h = yD;
			}
			framePos[14].x= 379; framePos[14].y= 0; framePos[14].w=42 ; framePos[14].h =52;
			framePos[15].x= 442; framePos[15].y= 0; framePos[15].w=42 ; framePos[15].h =52;
			framePos[16].x= 485; framePos[16].y= 0; framePos[16].w=31 ; framePos[16].h =52;
			framePos[17].x= 517; framePos[17].y= 0; framePos[17].w=31 ; framePos[17].h =52;
			framePos[18].x= 550; framePos[18].y= 0; framePos[18].w=39 ; framePos[18].h =52;
			framePos[19].x= 590; framePos[19].y= 0; framePos[19].w=39 ; framePos[19].h =52;

		}

		CoRect coRect, lRect, rRect, oRect, uRect;

		void move();	//in Spieler.cpp definiert

		void display(SDL_Surface* main);	//in Spieler.cpp definiert
		
		void reset() {	//Setzt alle Bewegungs- Parameter zurück
			if (kauernd)	//CoRect zurückstellen!!
				setKauernd(false);
			links =  rechts = sprung = fall = kauernd = aufEis = schuss = wurf = false;
		}

		void setLinks(bool param){
			if(!rechts && !aufEis && !kauernd){
				links = param;
				facingLeft = true;
			}

		} 
		bool getLinks() {return links;}
		void setRechts(bool param){
			if(!links && !aufEis && !kauernd){
				rechts = param;
				facingLeft = false;
			}

		}
		bool getRechts() {return rechts;}
		void setSprung(bool param){
			if(!fall && !kauernd){
				sprung = param;
			}
		}
		bool getSprung() {return sprung;}
		void setFall(bool param){
			if(!sprung){
				fall = param;
			}
		}
		
		bool getKauernd() { return kauernd; }
		void setKauernd(bool newStatus) {
			if (! sprung && ! fall && !rechts && !links && newStatus){
				kauernd = true;
				coRect.setPosition(x+5, y+20);
				coRect.setDimension(dimY - 20, dimX-2);
			}
			if (kauernd && !newStatus){
				
				kauernd = false;
				coRect.setPosition(x+5, y);
				coRect.setDimension(dimY, dimX-2);
			}
		}

		void setSchuss(bool param) {schuss = param;}
		void setWurf(bool param) {wurf = param;}
		
		int getX() {return x;}
		int getY() {return y;}
		void setX(int param) { x += param;}
		void setY(int param) { y += param;}
		void setPosition (int newX, int newY) { 
			x = newX; y = newY;
			coRect.setPosition (newX, newY);
		}
		CoRect getPosition() { return coRect;}
		
		bool getFacingLeft() { return facingLeft; }
		
		void setSterbend ( bool ste) {
			sterbend = ste;
		}
		
		bool getGewonnen () { return gewonnen; }
		void setGewonnen (bool gew) { gewonnen = gew; }
		
		int getMunitionsCount() { return munitionsCount; }
		void setMunitionsCount();
		void setMunitionsCount(int mun);
		void resetMunitionsCount() { munitionsCount = 6; }
		
		int getGranatenCount() { return granatCount; }
		void setGranatenCount();
		void setGranatenCount(int gran);
		void resetGranatenCount() { granatCount = 6; }
		
		int getGemCount() { return gemCount; }
		void setGemCount(int gem) { gemCount = gem; }
		void resetGemCount() { gemCount = 0; }
		
		bool getKeyCard () { return keyCard; }
		void setKeyCard (bool kc) { keyCard = kc; }
		
		bool getUnsterblich () { return unsterblich; }
		void setUnsterblich (bool un) { unsterblich = un; }
		
		int getAlphaValue() { return alphaValue; }	//ermöglicht abbruch von level bei lebensverlust
		void setAlphaValue (int newValue) { alphaValue = newValue;}
};


#endif





