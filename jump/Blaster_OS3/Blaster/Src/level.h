// Level.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#ifndef _LEVEL_
#define _LEVEL_

#include <string>
#include <vector>
#include <ctime>
#include <SDL/SDL.h>
using namespace std;

struct Eingang{ int xCoor; int yCoor; };

class Level{
	private:
		vector <string> files;
		vector <Eingang> einVec;
		vector <int> skript;
		Eingang ausgang, gegnerAusgang, startPosition;	//Positionen des Ausganges und der Startposition des Spielers im Level
		vector <Eingang>::iterator posE;
		int einIndex;	//Index für Eingangs- Vektor
		int skriptIndex;
		vector <int>::iterator posS;
		int levelNummer;
		Uint32 startzeit;		//Für Timing des Gegner- Generators
		time_t levelStartZeit;	//Speichert Startzeit des Levels, wichtig für Countdown der verbleibenden Restzeit
		int levelZeit;	//Wieviel Zeit steht für einen Level zur verfügung??
		
		
		
		
	public:
		Level () { 
			startzeit = 0; 
			einIndex = 0;
			skriptIndex = 0;
			//levelZeit = 30;	//provisorisch
		}
		bool loadLevel(const char* fileName);
		void gegnerGenerator();
		void setLevelNummer(int lNr){ levelNummer = lNr; }
		void reset();
		Eingang getEingang (int index) {	return ( einVec[index] ); }
		Eingang getAusgang() { return ausgang;}
		Eingang getGegnerAusgang() { return gegnerAusgang;}
		Eingang getStartPosition() { return startPosition; }
		time_t getStartZeit() { return levelStartZeit; }
		int getLevelZeit() { return levelZeit; }

};

#endif
