// Schuss.cpp - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#include "schuss.h"

extern CoRect *levEx [60][60];
extern SDL_Surface *schussBild;

bool Schuss::move(){

	for ( int i = 0; i< 10 ; ++i){

		if(levEx[xCoor/10][yCoor/10]->getTyp() > 0 && levEx[xCoor/10][yCoor/10]->getTyp() <= 10)		//Kolissionsabfrage mit Level
			return false;

		else{
			xCoor += richtung;
			coRect.setPosition(xCoor, yCoor);
		}
	}
	
	return true;
}

void Schuss::display(SDL_Surface* main) {
	
	SDL_Rect dest;
 	dest.x = getX();
  	dest.y = getY();

	SDL_BlitSurface (schussBild, NULL, main, &dest);

}
