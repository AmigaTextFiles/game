// Spieler.cpp - Copyright (C) 2003 Oliver Pearce, see COPYINGfor details

#include "spieler.h"
#include <iostream>
#include "panel.h"
#include "level.h"
using namespace std;

extern SDL_Surface *spielerBild;
extern SDL_Surface *feldRot;
extern Level level;
extern int lives;
extern CoRect* levEx [60][60];
extern bool waffenKoll (CoRect* sprite);
extern Panel panel;
extern void playSound(int code);
extern int score;

void Spieler::display(SDL_Surface* main){


	if(count >= 4){
  		count=0;
		++frame;
  	}
	if(frame==4 ){
  		frame=0;
  	}

  	if(sterbend){			//ermöglicht AlphaBlending
		if (alphaValue >= 20)
	        	alphaValue -= 20;
		else
			alphaValue = 0;

		int i = SDL_SetAlpha (spielerBild, SDL_RLEACCEL | SDL_SRCALPHA, alphaValue);
	}
	
	SDL_Rect dest;
  	dest.x = getX();
  	dest.y = getY();

  	if(schuss){
		if(kauernd){	//Wenn Spieler kauernd einen Schuss abgiebt muss eine andere Grafik dargestellt werden
			if(facingLeft){
				dest.x = getX() -12;	//muss angepasst werden, sonst rückversetzung der figur...
				SDL_BlitSurface (spielerBild, &framePos[19], main, &dest);
			}
			else{
				SDL_BlitSurface (spielerBild, &framePos[18], main, &dest);
			}
		}
		else{
			if(facingLeft){
				dest.x = getX() - 20;	//muss angepasst werden, sonst rückversetzung der figur...
				SDL_BlitSurface (spielerBild, &framePos[15], main, &dest);
			}
			else{
				dest.x = getX() + 5;
				SDL_BlitSurface (spielerBild, &framePos[14], main, &dest);
			}
		}
	}
	
	else if(wurf && !kauernd){
		if(facingLeft){
			SDL_BlitSurface (spielerBild, &framePos[17], main, &dest);
		}
		else{
			SDL_BlitSurface (spielerBild, &framePos[16], main, &dest);
		}
	}
	else {
		if(rechts && !sprung && !fall && !aufEis){		//bei gang nach rechts
			SDL_BlitSurface (spielerBild, &framePos[frame], main, &dest);
  		}
 		if(links && !sprung && !fall && !aufEis){		//bei gang nach links
			SDL_BlitSurface (spielerBild, &framePos[frame+6], main, &dest);
		}

		if(facingLeft){
			if(!rechts && !links && !sprung && !fall && !kauernd || aufEis){	//wenn Spieler still steht oder springt oder fällt.
				SDL_BlitSurface(spielerBild, &framePos[5],main, &dest);
			}
			if(sprung || fall){
				SDL_BlitSurface(spielerBild, &framePos[11],main, &dest);
			}
			if(kauernd){
				SDL_BlitSurface(spielerBild, &framePos[13],main, &dest);
			}

		}
		else{
			if(!rechts && !links && !sprung && !fall && !kauernd || aufEis){	//wenn Spieler still steht oder springt oder fällt.
				dest.x = getX() - 5;
				SDL_BlitSurface(spielerBild, &framePos[4],main, &dest);
			}
			if(sprung || fall){
				SDL_BlitSurface(spielerBild, &framePos[10],main, &dest);
			}
			if(kauernd){
				SDL_BlitSurface(spielerBild, &framePos[12],main, &dest);
			}
		}
	}
}


void Spieler::move(){

	for(int z=0; z< vec; ++z){
		if(waffenKoll(&coRect) ) {		//Kolissionsabfrage mit Waffen
			if(!unsterblich) { sterbend = true;  if(lives >1) playSound(7);	/*Schrei anspielen*/ }
		}

		if (links){

			for(int i=0; i<5; ++i)
				if( levEx[(getX()-1)/10][getY()/10 + i]->getTyp() >0 && levEx[(getX()-1)/10][getY()/10 + i]->getTyp() <= 10)
					links = false;

			if( levEx[(getX()-1)/10][(getY()-1)/10 + 5]->getTyp() > 0 &&levEx[(getX()-1)/10][(getY()-1)/10 + 5]->getTyp() <= 10 )
				links = false;

		}

		if (rechts){

			for(int i=0; i<5; ++i)
				if( levEx[(getX()+dimX )/10][getY()/10 + i]->getTyp() >0 && levEx[(getX()+dimX )/10][getY()/10 + i]->getTyp() <= 10)
					rechts = false;

			if( levEx[(getX()+dimX )/10][(getY()-1)/10 + 5]->getTyp() >0 && levEx[(getX()+dimX )/10][(getY()-1)/10 + 5]->getTyp() <= 10)
				rechts = false;

		}
		if (sprung){

			if (levEx[x/10] [(y-1)/10]->getTyp() >0 &&  levEx[x/10] [(y-1)/10]->getTyp() <= 10   || levEx[x/10+1] [(y-1)/10]->getTyp() >0 &&  levEx[x/10+1] [(y-1)/10]->getTyp() <= 10
			 || levEx[(x-1)/10+2] [(y-1)/10]->getTyp() >0 && levEx[(x-1)/10+2] [(y-1)/10]->getTyp() <= 10  ){
				sprung = false;
				fall=true;
			}

			//levEx[40][57]->setTyp(0);

		}

		if (fall){
			if(levEx[x/10][(y+dimY)/10]->getTyp() > 0 && levEx[x/10][(y+dimY)/10]->getTyp()  <= 10 ||  levEx[x/10+1][(y+dimY)/10]->getTyp() >0  &&
			levEx[x/10+1][(y+dimY)/10]->getTyp() <=10 ||  levEx[x/10+2][(y+dimY)/10]->getTyp() > 0 &&  levEx[x/10+2][(y+dimY)/10]->getTyp() <= 10 )
				fall = false;
		}

		/*if(levEx[x/10][(y+dimY)/10]->getTyp() == 0 && levEx[x/10+1][(y+dimY)/10]->getTyp() == 0  && levEx[(x-1)/10+2][(y+dimY)/10]->getTyp() == 0 && !sprung || sprungCount ==45 ||
	(levEx[x/10][(y+dimY)/10]->getTyp() == 60 && levEx[x/10+1][(y+dimY)/10]->getTyp() == 60  && levEx[(x-1)/10+2][(y+dimY)/10]->getTyp() == 60 && !sprung )  ||
		(levEx[x/10][(y+dimY)/10]->getTyp() == 50 && levEx[x/10+1][(y+dimY)/10]->getTyp() == 50  && levEx[(x-1)/10+2][(y+dimY)/10]->getTyp() == 50 && !sprung)  ){*/	//löst Fall aus bei keinem Boden und auch wenn Sprung zu ende ist
		if(  (levEx[x/10][(y+dimY)/10]->getTyp() == 0 || levEx[x/10][(y+dimY)/10]->getTyp() == 50 || levEx[x/10][(y+dimY)/10]->getTyp() == 60) &&
			(levEx[x/10+1][(y+dimY)/10]->getTyp() == 0 || levEx[x/10+1][(y+dimY)/10]->getTyp() == 50 || levEx[x/10+1][(y+dimY)/10]->getTyp() == 60) &&
			(levEx[(x-1)/10+2][(y+dimY)/10]->getTyp() == 0 || levEx[(x-1)/10+2][(y+dimY)/10]->getTyp() == 50 || levEx[(x-1)/10+2][(y+dimY)/10]->getTyp() == 60)
			&& !sprung || sprungCount ==45 ) {
			
			sprung = false;
			fall = true;
			sprungCount=0;
		}
		if(levEx[x/10][(y+dimY)/10]->getTyp() == 2 || levEx[x/10+1][(y+dimY)/10]->getTyp() == 2  || levEx[(x)/10+2][(y+dimY)/10]->getTyp() == 2){	//Testet auf Eis
			aufEis = true;
		}
		if(! (levEx[x/10][(y+dimY)/10]->getTyp() == 2 || levEx[x/10+1][(y+dimY)/10]->getTyp() == 2  || levEx[(x)/10+2][(y+dimY)/10]->getTyp() == 2) && aufEis ) {	//Stoppt Bewegung nachdem Eis verlassen wurde
			aufEis = rechts = links = false;
		}
		if(aufEis && facingLeft && !rechts && !links)	//Setzt Spieler wieder in bewegung, der auf Eis gesprungen ist, ohne Richtung zu haben
			links = true;
		if(aufEis && !facingLeft && !rechts && !links)
			rechts = true;

		for (int i=0; i <60 ; ++i){		//überprüft auf Kolission mit Extras
			for (int k=0; k<60; ++k){
				if(levEx[k][i]->getTyp() > 10 || levEx[k][i]->getTyp() == 3){
					if (coRect.intersects(levEx[k][i]) ) {
						extraReaktion(levEx[k][i]->getTyp() );
						if(levEx[k][i]->getTyp() != 3 && levEx[k][i] -> getTyp()  <=  20)	//Stacheln und durchl.  Kraftfelder usw. nicht löschen
							levEx[k][i]->setTyp(0);
					}
				}
			}
		}
		
		CoRect ausRect = (CoRect) level.getAusgang();	//Prüft ob Spieler durch Ausgang geht (um Level zu beenden)
		if ( keyCard &&  ausRect.contains(coRect) && !sterbend )	{
			panel.drawScore(score+=1000);
			gewonnen = true;
		}
		
		int xRichtung = 0;
		int yRichtung = 0;
		
		if(links)		//Hier werden die Bewegungen festgelegt
			xRichtung = -1;
		else if(rechts)
			xRichtung = 1;
		if(sprung){
			yRichtung = -2;
			++sprungCount;
		}
		else if(fall)
			yRichtung = 2;

		coRect.setX(xRichtung);
		coRect.setY(yRichtung);
		setX(xRichtung);
		setY(yRichtung);

	}	//Schliesst for- Schlaufe

	if(links || rechts && !fall && !sprung){
		++count;
	}
	
	if (unsterblich){		//Unsterblichkeit überprüfen, gegebenenfalls beenden
		time_t aktZeit;
		time(&aktZeit);
		if ( (difftime(aktZeit, startZeit)) >= 10){
			unsterblich = false;
			SDL_SetAlpha (spielerBild, SDL_RLEACCEL | SDL_SRCALPHA, 255);
		}
	}

}

void Spieler::extraReaktion(int extraCode){			//Behandelt die Reaktion der Spielfigur auf die Kolission mit Extras
	switch (extraCode){
		case 3 :	if(!unsterblich) { sterbend = true; if(lives >1) playSound(7); } break;		//Spikes
		case 11:	++gemCount; panel.drawGems(gemCount); 
				panel.drawScore(score+=50);	//score erhöhen
				if (gemCount == 100){
					gemCount=0;
					panel.drawGems(gemCount); 
					++lives;
					panel.drawLives(lives);
					playSound(9); 	//Newlife Sound abspielen
				}
				playSound (10);
					break;
		case 12:	munitionsCount += 5; panel.drawMunition(munitionsCount); playSound(12); 	break;
		case 13:	for (int i=0; i <60 ; ++i){		//Rotes Kraftfeld durchlässig machen
					for (int k=0; k<60; ++k){
							if(levEx[k][i]->getTyp() == 6)
								levEx[k][i] -> setTyp(60);
					}
				}
				playSound (11);
				/*keyCard = true;*/	break;
		case 14:	for (int i=0; i <60 ; ++i){		//Grünes Kraftfeld durchlässig machen
					for (int k=0; k<60; ++k){
							if(levEx[k][i]->getTyp() == 5)
								levEx[k][i] -> setTyp(50);
					}
				} playSound (11);
				break;
		case 15:	keyCard = true; playSound (11);	break;
		case 16:	granatCount += 5; panel.drawGranaten(granatCount); playSound(12);  break;
		case 17:	unsterblich = true;   time(&startZeit);  SDL_SetAlpha (spielerBild, SDL_RLEACCEL | SDL_SRCALPHA, 128);/*aktuelle Zeit bestimmen*/ 	break; 
	}

}

void Spieler::setMunitionsCount() { 
	--munitionsCount; 
	panel.drawMunition(munitionsCount);
}
void Spieler::setMunitionsCount(int mun) {
	munitionsCount = mun;
}

void Spieler::setGranatenCount() { 
	--granatCount; 
	panel.drawGranaten(granatCount);
}
void Spieler::setGranatenCount(int gran) { 
	granatCount = gran;
}







		
		
		
		
		
		


