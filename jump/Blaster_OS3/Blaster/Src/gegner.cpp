// Gegner.cpp - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#include "gegner.h"
#include "spieler.h"
#include "schuss.h"
#include "granate.h"
#include "panel.h"
#include <iostream>
using namespace std;


extern void spriteKoll(CoRect* s1, CoRect* s2);
extern Spieler spieler;	//Für Kollissionsabfrage mit Spieler
extern SDL_Surface *gegnerFrames;
extern SDL_Surface *statGegnerFrames;
extern SDL_Surface *spielerFrame;
extern SDL_Surface *schussBild;	//Für Schussauslösung
extern SDL_Surface *granatBild;	//Für Granatwurfauslösung
extern Level level;
extern CoRect *levEx [60][60];	//Für Kollissionsabfrage mit Level
extern Schuss schussArr [60];	//Für das Auslösen von Schüssen nötig
extern Granate granatArr [60];	//für das Auslösen von granatwürfen nötig
extern Gegner gegnerArr [20];	//für das Auslösen von Schüssen und Granaten müssen informationen über andere Gegnersprites vorhanden sein
extern bool waffenKoll (CoRect* sprite);
extern Panel panel;
extern int score;

Gegner::Gegner(int x, int y, int xDim, int yDim, int typ, int tempo ) : coRect (x,y,xDim,yDim,12), lRect(x-1,y,1,yDim-1,12),
                rRect(x+xDim+1,y,1,yDim-1,12), uRect(x,y+yDim,xDim,1,12) {

        links =false;    rechts=true; isAlive = true; sterbend = false;
	isAlive = true;
	schussAusgeloest = false;

	frame=count=0;
	tempo=4;
	alphaValue =255;
	startzeit = 0;
	
	Gegner::x=x;
	Gegner::y=y;
	
	Gegner::xDim = xDim;
	Gegner::yDim = yDim;

        int frameBreite;		//framebreite und Frameanzahl je nach Gegnertyp festlegen
	int frameAnzahl;
	int frameCode;
	if ( typ == 1) {
		frameBreite = 25;
		frameAnzahl = 8;
		frameCode = 1;
		aktBild = gegnerFrames;
	}
	else if ( typ == 2) {
		frameBreite = 30;
		frameAnzahl = 8;
		frameCode = 3;
		aktBild = gegnerFrames;
	}
	else if ( typ == 4) {
		frameBreite = 30;
		frameAnzahl = 8;
		frameCode = 3;
		aktBild = gegnerFrames;
	}
	else if ( typ == 3) {
		frameBreite = 25;
		frameAnzahl = 10;
		frameCode = 0;
		aktBild = gegnerFrames;
	}
	else if ( typ == 5) {
		frameBreite = 28;
		frameAnzahl = 8;
		frameCode = 2;
		aktBild = gegnerFrames;
	}
		
	
	for(int z=0; z<frameAnzahl; ++z){			//Frames in Array einfüllen, je nach Gegnertyp unterschiedliche Frames!!
 		framePos[z].x = z*frameBreite;
		framePos[z].y = 0 + frameCode * 50;
		framePos[z].w = frameBreite;
		framePos[z].h = yDim;
	}

	/* Gegnertypen:
	1= mobil, unbewaffnet
	2= stationär, unbewaffnet
	3= mobil, Pistole
	4= stationär, granate, realisiert direkt via loadLevel
	5= mobil, Granate
	6= mobil, Pistole
	*/
	if(typ == 3 || typ == 6){		//Variablen nach Gegnertypen zuordnen
                schuss=true; 
		 
        }
        else{ 
                schuss=false;
        }
         
        if(typ == 4 || typ == 5){ 
                granate = true; 
        } 
        else{ 
                granate = false; 
        }

        if(typ == 2 || typ == 4){
                stationaer = true; 
        } 
        else{ 
                stationaer = false;
        } 

}



void Gegner::display(SDL_Surface* main){
	Uint32 aktuelleZeit = SDL_GetTicks();	//Holt sich aktuelle Zeit zur regelung von gewissen Animationsphasen
	
	if(count >= 4){
  		count=0;
		++frame;
  	}
	if(frame==3){
  		frame=0;
  	}
	
	if(sterbend){			//ermöglicht AlphaBlending
		if (alphaValue >= 20)
	        	alphaValue -= 20;
		else
			alphaValue = 0;

		int i = SDL_SetAlpha (aktBild, SDL_RLEACCEL | SDL_SRCALPHA, alphaValue);
	}

	SDL_Rect dest;
 	dest.x = getX();
  	dest.y = getY();

	if(schussAusgeloest){
		if(links){
			dest.x = coRect.getX() - 20;	//muss angepasst werden, sonst rückversetzung der figur...
			SDL_BlitSurface (aktBild, &framePos[9], main, &dest);
		}
		else{
			dest.x = coRect.getX() + 5;
			SDL_BlitSurface (aktBild, &framePos[8], main, &dest);
		}
	
		if (aktuelleZeit > startzeit +200 ) {	//Beendet nach gewisser Zeit Schuss- Animation
			schussAusgeloest = false;
		}
	
	}
	else{
		if(rechts && !fall){		//bei gang nach rechts
			SDL_BlitSurface(aktBild, &framePos[frame], main, &dest);
  		}
 		if(links && !fall){		//bei gang nach links
			SDL_BlitSurface(aktBild, &framePos[frame+4], main, &dest);
		}
		if(fall){
			if(links)
				SDL_BlitSurface(aktBild, &framePos[4],main, &dest);
			else
				SDL_BlitSurface(aktBild, &framePos[3],main, &dest);
		}
	}
	
	if (alphaValue < 255)
		int i = SDL_SetAlpha (aktBild, SDL_RLEACCEL | SDL_SRCALPHA, SDL_ALPHA_OPAQUE);		//Alpha Wert muss für Oberfläche wieder zurückgesetzt werden!!

}


bool Gegner::move(int id){
       tempo=5;
      
      
      if(schuss) 	//Gibt bei schiessenden Gegnern Schuss ab
	      schussAusloesen(id);
	
      if(granate)
	      granateAusloesen(id);
		
      for (int i=0; i<tempo; ++i){
		
		if(waffenKoll(&coRect) ) {		//Kolissionsabfrage mit Waffen
			if(!sterbend)	//um doppeltes zählen eines treffers zu vermeiden
				panel.drawScore(score+=100);	//Score für Spieler erhöhen
			sterbend = true;
		}
		
		if(rechts){

			for(int i=0; i<5; ++i)
				//if( levEx[(getX()+xDim)/10][getY()/10 + i]->getTyp() ==1){
				if( levEx[(getX()+xDim )/10][getY()/10 + i]->getTyp() >0 && levEx[(getX()+xDim )/10][getY()/10 + i]->getTyp() <= 6){
					rechts = false;
					links= true;
					facingLeft = true;
				}
				
				//if( levEx[(getX()+xDim )/10][(getY()-1)/10 + 5]->getTyp() ==1){
				if( levEx[(getX()+xDim )/10][(getY()-1)/10 + 5]->getTyp() >0 && levEx[(getX()+xDim )/10][(getY()-1)/10 + 5]->getTyp() <= 6){
					rechts = false;
					links= true;
					facingLeft = true;
				}
				
				if(stationaer){
					if (levEx[x/10+1][(y+yDim)/10]->getKante() == true){
						rechts = false;
						links= true;
						facingLeft = true;
					}
				}

		}

		else if(links){

			for(int i=0; i<5; ++i)
				//if( levEx[(getX()-1)/10][getY()/10 + i]->getTyp()==1 ){
				if( levEx[(getX()-1)/10][getY()/10 + i]->getTyp() >0 && levEx[(getX()-1)/10][getY()/10 + i]->getTyp() <= 6){
					links = false;
					rechts=true;
					facingLeft = false;
				}

				//if( levEx[(getX()-1)/10][(getY()-1)/10 + 5]->getTyp()==1 ) {
				if( levEx[(getX()-1)/10][(getY()-1)/10 + 5]->getTyp() > 0 &&levEx[(getX()-1)/10][(getY()-1)/10 + 5]->getTyp() <= 6 ) {
					links= false;
					rechts=true;
					facingLeft = false;
				}
				
			if(stationaer){
					if (levEx[x/10+1][(y+yDim)/10]->getKante() == true){
						links= false;
						rechts=true;
						facingLeft = false;
					}
				}
		}


		if(fall){
			if( levEx[x/10][(y+yDim)/10]->getTyp() > 0 &&  levEx[x/10][(y+yDim)/10]->getTyp() <= 6  || levEx[x/10+1][(y+yDim)/10]->getTyp() > 0  && levEx[x/10+1][(y+yDim)/10]->getTyp()  <= 6 ||   levEx[x/10+2][(y+yDim)/10]->getTyp() > 0  &&  levEx[x/10+2][(y+yDim)/10]->getTyp() <= 6 )
				/*if(levEx[x/10][(y+yDim)/10]->getTyp() > 0 && levEx[x/10][(y+yDim)/10]->getTyp()  <= 10 ||  levEx[x/10+1][(y+yDim/10)]->getTyp() >0 &&
					levEx[x/10+1][(y+yDim)/10]->getTyp() <=10 ||  levEx[x/10+2][(y+yDim)/10]->getTyp() > 0 &&  levEx[x/10+2][(y+yDim)/10]->getTyp() <= 10 )*/
				fall = false;
		}

		if(levEx[x/10][(y+yDim)/10]->getTyp() == 0 && levEx[x/10+1][(y+yDim)/10]->getTyp() == 0  && levEx[(x-1)/10+1+1][(y+yDim)/10]->getTyp() == 0 ){
			fall = true;
		}

		CoRect ausRect = (CoRect) level.getGegnerAusgang();	//Prüft ob Spieler durch Ausgang geht (um Level zu beenden)
		if ( ausRect.contains(coRect)  )	
			return true;
		
		xRichtung = 0;
		yRichtung = 0;

		if(links)
			xRichtung = -1;
		if(rechts)
			xRichtung = 1;
		if(fall)
			yRichtung = 2;

		coRect.setX(xRichtung);
		lRect.setX(xRichtung);
		rRect.setX(xRichtung);
		uRect.setX(xRichtung);
		coRect.setY(yRichtung);
		lRect.setY(yRichtung);
		rRect.setY(yRichtung);
		uRect.setY(yRichtung);
		setX(xRichtung);
		setY(yRichtung);

	}	//schliesst for- Schlaufe

	coRect.setPosition(x,y);

	if(links || rechts && !fall){
		++count;
	}

	if (!sterbend){			//Verhindert Kolission mit Spieler wenn sterbend
		if(! (spieler.getUnsterblich()) ) {
			spriteKoll(&coRect, &spieler.coRect);		//Kolissionsabfrage mit Spieler!!!!!!
		}
	}
	if (alphaValue == 0){
		return true;
	}
	else{
		return false;
	}

}

void Gegner::schussAusloesen (int ID) {
	
	if (!sterbend){
		if(facingLeft){
			if(y < spieler.getY() + 90 && y > spieler.getY() -30 && x > spieler.getX()  && x > 50 ){		//Ist Spieler in Reichweite ?
					for(int i=0;i<10;i++){								
						if(gegnerArr[i].getIsAlive() ){	//Schaut ob anderer Gegner im Weg steht,gegnerID verhindert positive Abfrage mit eigenem gegerRect...
							if(i != ID){
								if(  y <gegnerArr[i].getY() + 90 && y > gegnerArr[i].getY() -30 && x > gegnerArr[i].getX()  ) {	//Wenn Gegner im Weg ist nicht schiessen
									
									return;	
									//return false; 	//Gegner im weg, nicht schiessen...
								}
							}
						}
					}
					
					for(int j=0; j<60; ++j) {	
						if (schussArr[j].getIsAlive() ) {	//Haben wir noch einen freien Slot?
							if (schussArr[j].getID()  == ID)  {	//Hat dieser Gegner schon eine Granate abgegeben?
								return;	
								
							}
						}
					}
					
					for (int k=0; k< 60 ; ++k) {			//Wurf auslösen
						if ( ! (schussArr[k].getIsAlive())  ) {
							schussArr[k] = Schuss(x-25, y+5, 10, -1, ID, schussBild);
							schussAusgeloest = true;	//für Animation
							startzeit = SDL_GetTicks();	//Um Animation zu timen
							break;	
								
						}
					}
			}
		}
	
	
		if (! facingLeft) {
			if(y < spieler.getY() + 90 && y > spieler.getY() -30 && x < spieler.getX()  && x < 550){		//Ist Spieler in Reichweite ?
					for(int i=0;i<10;i++){								
						if(gegnerArr[i].getIsAlive() ){	//Schaut ob anderer Gegner im Weg steht,gegnerID verhindert positive Abfrage mit eigenem gegerRect...
							if(i != ID){
								if(  y <gegnerArr[i].getY() + 90 && y > gegnerArr[i].getY() -30 && x < gegnerArr[i].getX()  ) 	{//Wenn Gegner im Weg ist nicht schiessen
									
									return;	
									//return false; 	//Gegner im weg, nicht schiessen...
								}
							}
						}
					}
					
					for(int j=0; j<60; ++j) {
						if (schussArr[j].getIsAlive() ) {
							if (schussArr[j].getID()  == ID) {
								return;	
								
							}
						}
					}
					
					for (int k=0; k< 60 ; ++k) {			//Wurf auslösen
						if ( ! (schussArr[k].getIsAlive())  ) {
							schussArr[k] = Schuss(x+35, y+5, 10, 1, ID, schussBild);
							schussAusgeloest = true;
							startzeit = SDL_GetTicks();
							break;	
							
						}
					}
			}
		}
	}
	
}


void Gegner::granateAusloesen (int ID) {

	if (!sterbend){
	
		if(facingLeft){
			if(y < spieler.getY() + 120 && y > spieler.getY() -90 && x > spieler.getX()  && x > 50 ){		//Ist Spieler in Reichweite ?
					for(int i=0;i<10;i++){								
						if(gegnerArr[i].getIsAlive() ){	//Schaut ob anderer Gegner im Weg steht,gegnerID verhindert positive Abfrage mit eigenem gegerRect...
							if(i != ID){
								if(  y <gegnerArr[i].getY() + 90 && y > gegnerArr[i].getY() -30 && x > gegnerArr[i].getX()  ) {	//Wenn Gegner im Weg ist nicht schiessen
									
									return;	
									//return false; 	//Gegner im weg, nicht schiessen...
								}
							}
						}
					}
					//bool schussAbgeben = true;
					for(int j=0; j<60; ++j) {
						if (granatArr[j].getIsAlive() ) {
							if (granatArr[j].getID()  == ID)  {
								
								return;	
								//return false;
							}
						}
					}
					
					for (int k=0; k< 60 ; ++k) {			//Schuss auslösen
						if ( ! (granatArr[k].getIsAlive())  ) {
							granatArr[k] = Granate(x-25, y+5,  -1, ID, granatBild);
							//schussAusgeloest = true;
							startzeit = SDL_GetTicks();
							break;	
								//return true;
						}
					}
			}
		}
		if (! facingLeft) {
			if(y < spieler.getY() + 120 && y > spieler.getY() -90 && x < spieler.getX()  && x < 550){		//Ist Spieler in Reichweite ?
					for(int i=0;i<10;i++){								
						if(gegnerArr[i].getIsAlive() ){	//Schaut ob anderer Gegner im Weg steht,gegnerID verhindert positive Abfrage mit eigenem gegerRect...
							if(i != ID){
								if(  y <gegnerArr[i].getY() + 90 && y > gegnerArr[i].getY() -30 && x < gegnerArr[i].getX()  ) 	{//Wenn Gegner im Weg ist nicht schiessen
										
									return;	
									//return false; 	//Gegner im weg, nicht schiessen...
								}
							}
						}
					}
					//bool schussAbgeben = true;
					for(int j=0; j<60; ++j) {
						if (granatArr[j].getIsAlive() ) {
							if (granatArr[j].getID()  == ID) {
								
								return;	
								//return false;
							}
						}
					}
					
					for (int k=0; k< 60 ; ++k) {			//Schuss auslösen
						if ( ! (granatArr[k].getIsAlive())  ) {
							granatArr[k] = Granate(x+35, y+5,  1, ID, granatBild);
							//schussAusgeloest = true;
							startzeit = SDL_GetTicks();
							break;	
								//return true;
						}
					}
			}
		}
	
	}
	
}
		
									
										
		
		















