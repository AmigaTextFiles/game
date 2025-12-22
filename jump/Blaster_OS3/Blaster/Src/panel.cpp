// panel.cpp - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#include "panel.h"
#include <iostream>
#include <sstream>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <climits> 
//für INT_MAX

using namespace std;

extern SDL_Surface* nummernBild;
extern SDL_Surface *munitionsBild;
extern SDL_Surface *granatBild;
extern SDL_Surface *juwelBild;
extern SDL_Surface* screen;

Panel::Panel() {
	for(int i=0; i<10; ++i){		//Nummer- Frame Vector füllen
  				nummernPos[i].x = i*17;
				nummernPos[i].y = 0;
				nummernPos[i].w = 17;
				nummernPos[i].h = 13;
			}
}

void Panel::init() {
	//color = SDL_MapRGB (screen->format, 30, 128, 255);		//Hintergrundfarbe zeichnen
	color = SDL_MapRGB (screen->format, 0, 80, 70);
	dest.x = 600 ;
	dest.y = 0;
	dest.w = 100 ;
	dest.h = 600;
	SDL_FillRect (screen, &dest, color);
	
	SDL_Rect filter;		
	
	filter.x = 68 ;	filter.y = 39;	filter.w = 63 ;	filter.h = 13;	//Time- Label
	dest.x = 610;	
	dest.y = 20;
	SDL_BlitSurface(nummernBild, &filter, screen, &dest);
	
	filter.x = 0 ;	filter.y = 13;	filter.w = 81 ;	filter.h = 13;	//Score- Label
	dest.x = 610;	
	dest.y = 100;
	SDL_BlitSurface(nummernBild, &filter, screen, &dest);
	dest.x = 675;	
	dest.y = 127;
	SDL_BlitSurface(nummernBild,  &nummernPos[0], screen, &dest);
	
	filter.x = 81 ;	filter.y = 13;	filter.w = 85 ;	filter.h = 13;		//Level- Label
	dest.x = 610;	
	dest.y = 180;
	SDL_BlitSurface(nummernBild, &filter, screen, &dest);
	dest.x = 645;	
	dest.y = 205;
	SDL_BlitSurface(nummernBild,  &nummernPos[1], screen, &dest);
	
	filter.x = 0 ;	filter.y = 52;	filter.w = 86 ;	filter.h = 12;	dest.x = 610;		dest.y = 340;	//Items- label
	SDL_BlitSurface(nummernBild, &filter, screen, &dest);	
	
	dest.x = 610;			//Munitions- Icon zeichnen
	dest.y = 367;
	SDL_BlitSurface(munitionsBild, NULL, screen, &dest);
	dest.x = 660;
	SDL_BlitSurface(nummernBild, &nummernPos[6], screen, &dest);
	
	dest.x = 610;			//Granaten- Icon zeichnen
	dest.y = 390;
	filter.x =0; filter.y = 0; filter.w = 10; filter.h = 14; 
	SDL_BlitSurface(granatBild, &filter, screen, &dest);
	dest.x = 660;
	SDL_BlitSurface(nummernBild, &nummernPos[6], screen, &dest);
	
	dest.x = 610;			//Juwel- Icon zeichnen
	dest.y = 413;
	SDL_BlitSurface(juwelBild, &filter, screen, &dest);
	dest.x = 660;
	SDL_BlitSurface(nummernBild, &nummernPos[0], screen, &dest);
	
	filter.x = 68 ;	filter.y = 27;	filter.w = 82 ;	filter.h = 13;	//Lives- Label
	dest.x = 610;	
	dest.y = 260;
	SDL_BlitSurface(nummernBild, &filter, screen, &dest);
	dest.x = 645;	
	dest.y = 287;
	SDL_BlitSurface(nummernBild,  &nummernPos[3], screen, &dest);

	zeit = INT_MAX;
	
}

void Panel::drawTime (time_t startZeit, int levelZeit, int pausenZeit){	//Param: startZeit: startzeit des Levels; levelZeit: Zeit die für Level zur Verfügng steht: pausenZeit: Zeit die während Spielpausen verbecht wurde
	time_t aktZeit;
	time(&aktZeit);	//aktuelle Zeit bestimmen
	int restZeit = levelZeit - (int) difftime(aktZeit, startZeit) + pausenZeit;
	
	
	if (restZeit != zeit){	//ist die aktuelle Zeit ungleich der zur Zeit dargestelten Zeit?
		zeit = restZeit;	//Variable, die aktuell dargestellte Zeit speichert, updaten
		
		SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
		clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
		SDL_SetClipRect(screen, &clipRect);
	
		dest.x = 610 ;	dest.y = 37; dest.w = 60 ; dest.h = 20;
		SDL_FillRect (screen, &dest, color);
		
		timeVec.clear();
		string s;
		ostringstream zeitOS (s);
		zeitOS << zeit;		//Int in String umwandeln
		string zeitStr = zeitOS.str();
		for (int i=0; i < zeitStr.length() ; ++i) {
			timeVec.push_back(zeitStr[i]);
		}
		for (int i=0; i <timeVec.size() ; ++i) {
			dest.x = 610 + 15*i ;
			dest.y = 37;
			int index = timeVec[i] - 48;	// Umrechnung von ASCII- Code in Ziffer
			SDL_BlitSurface(nummernBild, &nummernPos[index], screen, &dest);
		}
	}
	
	
}

void Panel::drawTime(int time){
		zeit = time;	//Variable, die aktuell dargestellte Zeit speichert, updaten
		
		SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
		clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
		SDL_SetClipRect(screen, &clipRect);
	
		dest.x = 610 ;	dest.y = 37; dest.w = 60 ; dest.h = 20;
		SDL_FillRect (screen, &dest, color);
		
		timeVec.clear();
		string s;
		ostringstream zeitOS (s);
		zeitOS << zeit;		//Int in String umwandeln
		string zeitStr = zeitOS.str();
		for (int i=0; i < zeitStr.length() ; ++i) {
			timeVec.push_back(zeitStr[i]);
		}
		for (int i=0; i <timeVec.size() ; ++i) {
			dest.x = 610 + 15*i ;
			dest.y = 37;
			int index = timeVec[i] - 48;	// Umrechnung von ASCII- Code in Ziffer
			SDL_BlitSurface(nummernBild, &nummernPos[index], screen, &dest);
		}
}
	

void Panel::drawScore (int score) {

	SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
	clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	dest.x = 600 ;	dest.y = 127; dest.w = 100 ; dest.h = 20;	//Bestehende Anzeige überschreiben
	SDL_FillRect (screen, &dest, color);

	vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
	ziffern.push_back(score/100000 % 10);
	ziffern.push_back(score/10000 % 10);
	ziffern.push_back(score/1000 % 10);
	ziffern.push_back(score/100 % 10);
	ziffern.push_back(score/10 % 10);
	ziffern.push_back(score % 10 ); 	//ergibt einer
	
	bool zeichnen = false;	
	for (int i = 0; i < ziffern.size(); ++i){
		if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
			zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen

		if(zeichnen){
			dest.x = 605 + 15*i ;
			SDL_BlitSurface(nummernBild, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
		}
	}
	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;	//Clippingrechteck wieder zurücksetzen
	SDL_SetClipRect(screen, &clipRect);
	
	/*string s;
	 ostringstream scoreOS (s);
	 scoreOS << score;		//Int in String umwandeln
	 string scoreStr = scoreOS.str();
	 for (int i=0; i < scoreStr.length() ; ++i) {
		scoreVec.push_back(scoreStr[i]);
	 }
	 for (int i=0; i < scoreVec.size() ; ++i) {
		dest.x = 610 + 15*i ;
		dest.y = 125;
		int index = scoreVec[i] - 48;	// Umrechnung von ASCII- Code in Ziffer
		SDL_BlitSurface(nummernBild, &nummernPos[index], screen, &dest);
	}*/
}

void Panel::drawMunition (int munitionsCount) {
	//color = SDL_MapRGB (screen->format, 30, 128, 255);		//Bisherige Anzeige löschen
	SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
	clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	dest.x = 600 ;
	dest.y = 367;
	dest.w = 100 ;
	dest.h = 20;
	SDL_FillRect (screen, &dest, color);
	
	dest.x = 610;	//Icon zeichnen
	dest.y = 367;
	SDL_BlitSurface(munitionsBild, NULL, screen, &dest);

	vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
	ziffern.push_back(munitionsCount/100 % 10);
	ziffern.push_back(munitionsCount/10 % 10);
	ziffern.push_back(munitionsCount % 10 ); 	//ergibt einer
		
	bool zeichnen = false;	
	for (int i = 0; i < ziffern.size(); ++i){
		if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
			zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen

		if(zeichnen){
			dest.x = 630 + 15*i ;
			SDL_BlitSurface(nummernBild, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
		}
	}	
	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;	//Clippingrechteck wieder zurücksetzen
	SDL_SetClipRect(screen, &clipRect);

}

void Panel::drawGranaten (int granatCount){
	SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
	clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	dest.x = 600 ;
	dest.y = 390;
	dest.w = 100 ;
	dest.h = 20;
	SDL_FillRect (screen, &dest, color);
	
	dest.x = 610;	//Icon zeichnen
	dest.y = 390;
	SDL_Rect filter;
	filter.x =0; filter.y = 0; filter.w = 10; filter.h = 14; 
	SDL_BlitSurface(granatBild, &filter, screen, &dest);

	vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
	ziffern.push_back(granatCount/100 % 10);
	ziffern.push_back(granatCount/10 % 10);
	ziffern.push_back(granatCount % 10 ); 	//ergibt einer
	
	bool zeichnen = false;	
	for (int i = 0; i < ziffern.size(); ++i){
		if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
			zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen

		if(zeichnen){
			dest.x = 630 + 15*i ;
			SDL_BlitSurface(nummernBild, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
		}
	}	
	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);


}


void Panel::drawLevelNummer(int nr) {
	SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
	clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	dest.x = 645 ;	//Bisherige Anzeige löschen
	dest.y = 205;
	dest.w = 60 ;
	dest.h = 20;
	SDL_FillRect (screen, &dest, color);

	levelVec.clear();
	string s;
	ostringstream levelOS (s);
	levelOS << nr;		//Int in String umwandeln
	string levelStr = levelOS.str();
	for (int i=0; i < levelStr.length() ; ++i) {
		levelVec.push_back(levelStr[i]);
	}
	for (int i = levelVec.size() -1 ; i >= 0 ; --i) {	//Zahl zeichnen
		dest.x = 645 + 15*i ;
		int index = levelVec[i] - 48;	// Umrechnung von ASCII- Code in Ziffer
		SDL_BlitSurface(nummernBild, &nummernPos[index], screen, &dest);
	}
	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
}

void Panel::drawLives(int count) {
	SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
	clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	dest.x = 645 ;	dest.y = 287;	dest.w = 50 ;	dest.h = 20;	//Bisherige Anzeige löschen
	SDL_FillRect (screen, &dest, color);

	livesVec.clear();
	string s;
	ostringstream livesOS (s);
	livesOS << count;		//Int in String umwandeln
	string livesStr = livesOS.str();
	for (int i=0; i < livesStr.length() ; ++i) {
		livesVec.push_back(livesStr[i]);
	}
	for (int i = livesVec.size() -1 ; i >= 0 ; --i) {	//Zahl zeichnen
		dest.x = 645 + 15*i ;
		int index = livesVec[i] - 48;	// Umrechnung von ASCII- Code in Ziffer
		SDL_BlitSurface(nummernBild, &nummernPos[index], screen, &dest);
	}
	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
}

void Panel::drawGems(int gemCount) {
	SDL_Rect clipRect;	//clipping rectangle muss zuerst richtig gesetzt werden!
	clipRect.x =600; clipRect.y = 0; clipRect.w = 100; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	
	dest.x = 630 ;	dest.y = 413;	dest.w = 50 ;	dest.h = 20;	//Bisherige Anzeige löschen
	SDL_FillRect (screen, &dest, color);

	vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
	ziffern.push_back(gemCount/100 % 10);
	ziffern.push_back(gemCount/10 % 10);
	ziffern.push_back(gemCount % 10 ); 	//ergibt einer
	
	bool zeichnen = false;	
	for (int i = 0; i < ziffern.size(); ++i){
		if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
			zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen

		if(zeichnen){
			dest.x = 630 + 15*i ;
			SDL_BlitSurface(nummernBild, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
		}
	}	

	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
}






