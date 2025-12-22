// Granate.cpp - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#include "granate.h"

extern CoRect *levEx [60][60];
extern void playSound(int code);

void Granate::display(SDL_Surface* main) {
	SDL_Rect dest;
 	dest.x = getX();
  	dest.y = getY();

	if (!explodierend)
		SDL_BlitSurface (granatBild, &framePos[0], main, &dest);
	else{
		SDL_BlitSurface (granatBild, &framePos[explosionsStatus], main, &dest);
		
	}
}

bool Granate::move(){
	
	countdown++;
	if(countdown>14){
		explodierend=true;
		playSound(3);
	}
	
	if(!explodierend){	//Behandelt den Fall, wenn die Granate am fliegen ist
		
		for(int i=0; i<10; i++){	//Bewegung in X-Richtung
				if(levEx[xCoor/10][yCoor/10]->getTyp() > 0 && levEx[xCoor/10][yCoor/10]->getTyp() <= 10)	//Kolissionsabfrage in X- Richtung
					richtung = -richtung;	//Ändert Richtung der Granate
				xCoor += richtung;
		}
		
		if(steigend){	//Wenn Granate aufsteigt
			for (int i=0; i < yAuf [moveCount]; ++i){
				if (levEx[xCoor/10] [(yCoor-1)/10]->getTyp() >0 &&  levEx[xCoor/10] [(yCoor-1)/10]->getTyp() <= 10){
					steigend = false;
					moveCount = 0;
				}
				else{
					yCoor -= 1;
				}
			}
		}
		
		if (!steigend){	//Wenn Granate fällt
			for (int i=0; i < yAb [moveCount]; ++i){
				if(levEx[xCoor/10][(yCoor+10)/10]->getTyp() > 0 && levEx[xCoor/10][(yCoor+10)/10]->getTyp()  <= 10){
					steigend = true;
					moveCount=0;
				}
				else{
					yCoor += 1;
				}
			}
		}
		
		coRect.setPosition(xCoor, yCoor);
		
		moveCount++;
		if (steigend && moveCount > 7){
			steigend = false;
			moveCount =0;
		}
		
	}	//beendet normale Bewegung (im Flug)
	
	else{	//Bei Explosion
		int currH = coRect.getH();
		int currW = coRect.getW();
		if (coRect.getH() <= 30){
			coRect.setH( currH += 4);	//Kolissionsrechteck vergrössern
			coRect.setW( currW += 4);
		}
		if (explosionsStatus <= 7)
			explosionsStatus ++;
		else
			return false;
	}
	
	return true;
	
}
		
		
		
		
		
		
	
	


			
