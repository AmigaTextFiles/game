// panel.h- Copyright (C) 2003 Oliver Pearce, see COPYING for details
#ifndef _PANEL_
#define _PANEL_

#include <SDL.h>
#include <vector>
#include <ctime>
using namespace std;

class Panel {
	private:
		vector <char> timeVec;
		vector <char> scoreVec;
		vector <char> munVec;
		vector <char> granatVec;
		vector <char> levelVec;
		vector <char> livesVec;
		vector <char> gemsVec;
		SDL_Rect nummernPos[10];	//Extrahiert richtige Ziffer aus Bild
		Uint32 color;
		SDL_Rect dest;	//dient zur Bestimmung von Bereichen auf denen gemalt/geblittet wird
		int zeit; 	//zuletzt gezeichnete Countdown- Zeit
		
		 
	public:
		Panel();
		void init();
		void drawTime (time_t startZeit, int levelZeit, int pausenZeit);
		void drawTime (int time);
		void drawScore (int score);
		void drawMunition (int munitionsCount);
		void drawGranaten (int granatCount);
		void drawLevelNummer (int nr);
		void drawLives (int count);
		void drawGems (int gemCount);

};


#endif
