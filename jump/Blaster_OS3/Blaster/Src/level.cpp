// Level.cpp - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#include "coRect.h"
#include "gegner.h"
#include "level.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <iostream>

#if defined(linux)
#include <netinet/in.h>
#endif

extern int einfuellen(int x,int y,int w,int h,int typ, int x2, int y2);
extern void parseLevel();
extern Gegner gegnerArr[20];

//extern vector <CoRect> levEx;

bool Level::loadLevel(const char* fileName){

	files.push_back("level1.bdt");
	files.push_back("level2.bdt");
	files.push_back("level3.bdt");

	ifstream inFile(fileName);
	//ifstream inFile("test.dat");
	int x, y, w, h, typ;

	for(int i=0; i<60; ++i){
		for(int k=0; k<60; ++k){
			inFile.read((char*) &x, sizeof(x) );
			inFile.read((char*) &y, sizeof(y) );
			inFile.read((char*) &w, sizeof(w) );
			inFile.read((char*) &h, sizeof(h) );
			inFile.read((char*) &typ, sizeof(typ) );

			#if defined(linux)
			x = ntohl(x);
			y = ntohl(y);
			w = ntohl(w);
			h = ntohl(h);
			typ = ntohl(typ);
			#endif

			einfuellen(x,y,w,h,typ,k,i);

		}
	}

	for(int i=0; i<3; ++i){		//liest Eingänge ein
		inFile.read((char*) &x, sizeof(x) );
		inFile.read((char*) &y, sizeof(y) );
		
		#if defined(linux)
		x = ntohl(x);
		y = ntohl(y);
		#endif
		
		Eingang eingang;	//Eingänge ...
		eingang.xCoor = x;
		eingang.yCoor = y;

		einVec.push_back(eingang);
		
		int einXPos = x/10;
		int einYPos = y/10;
		for (int i=0; i < 3; ++i){
			for (int k=0; k < 6; ++k)
				einfuellen(x+10*i, y+10*k, 10, 10, 8, einXPos+i, einYPos+k);	//...Eingänge 
		}
		
	}
	inFile.read((char*) &x, sizeof(x) );		//Ausgang....
	inFile.read((char*) &y, sizeof(y) );
	#if defined(linux)
	x = ntohl(x);
	y = ntohl(y);
	#endif
	Eingang ausgang;
	ausgang.xCoor = x;
	ausgang.yCoor = y;
	this->ausgang = ausgang;

	
	inFile.read((char*) &x, sizeof(x) );		//GegnerAusgang....
	inFile.read((char*) &y, sizeof(y) );
	#if defined(linux)
	x = ntohl(x);
	y = ntohl(y);
	#endif
	Eingang gegnerAusgang;
	gegnerAusgang.xCoor = x;
	gegnerAusgang.yCoor = y;
	this->gegnerAusgang = gegnerAusgang;
	
	inFile.read((char*) &x, sizeof(x) );		//StartPosition...
	inFile.read((char*) &y, sizeof(y) );
	#if defined(linux)
	x = ntohl(x);
	y = ntohl(y);
	#endif
	Eingang startPosition;
	startPosition.xCoor = x;
	startPosition.yCoor = y;
	this->startPosition = startPosition;		//...StartPosition
	
	
	for(int i=0; i<20; ++i){		//liest Gegner- Steuerungs- Skript ein
		inFile.read((char*) &x, sizeof(x) );
		#if defined(linux)
		x = ntohl(x);
		#endif
		skript.push_back(x);
	}

	for(int i=0; i <3; ++i){
		inFile.read((char*) &x, sizeof(x) );		//StartPosition der stationären Gegner
		inFile.read((char*) &y, sizeof(y) );
		#if defined(linux)
		x = ntohl(x);
		y = ntohl(y);
		#endif
		if (x != -1 && y != -1){
			for (int i=0; i< 20 ; ++i) {			//Gegner generieren
					if ( ! (gegnerArr[i].getIsAlive())  ) {
						if (x%33 == 0)		//Möglichkeit, auch granatwefende stationäre Gegner zu schaffen!
							gegnerArr[i] = Gegner (x, y ,20,50, 4);
						else
							gegnerArr[i] = Gegner (x, y ,20,50, 2);
						break;
					}
			}
		}
	}
	
	inFile.read((char*) &x, sizeof(x) );	//Levelzeit einlesen
	#if defined(linux)
	x = ntohl(x);
	#endif
	levelZeit = x;
	
	parseLevel();
	//Startzeit des Levels bestimmen
	time(&levelStartZeit);

	return true;
}

void Level::gegnerGenerator() {
	
	Uint32 aktuelleZeit = SDL_GetTicks();
	if (aktuelleZeit > startzeit + 3000 ) {	//Wie oft kommt ein neuer Gegner
		startzeit = SDL_GetTicks();	
		
		Eingang aktEingang = einVec[einIndex];	//Aktueller Eingang zuweisen
		++einIndex;
		if (einIndex == 3) 
			einIndex =0;
			
		int aktSkript = skript[skriptIndex];		//Aktueller Skriptwert zuweisen
		++ skriptIndex;
		if (skriptIndex == 20)
			skriptIndex =0;
			
		//if (  ( aktEingang.xCoor != -100 )  &&  (aktEingang.yCoor != -100)  ){	//Mit -100/-100 kann das Produktionstempo vermindert werden
		if (aktSkript != 0){
			for (int i=0; i< 20 ; ++i) {			//Gegner generieren
						if ( ! (gegnerArr[i].getIsAlive())  ) {
							gegnerArr[i] = Gegner (aktEingang.xCoor, aktEingang.yCoor ,20,50, aktSkript);
							break;
						}
			}
		}
	
	}
	
}

void Level::reset() {
	for (int i=0; i<3; ++i){
		einVec.pop_back();
	}
	for (int i=0; i<20; ++i){
		skript.pop_back();
	}
	skriptIndex = 0;
}
		
		
		

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	






