// main.cpp - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#include <stdio.h>
#include <stdlib.h>
// #include <istream.h>
#include <iostream>
//#include <istream.h>
//#include <istream.h>
#include <fstream>
#include <string>
// Egen
//#include <istream.h>
//#include <ostream.h>

#include <SDL/SDL.h>
#include "SDL_mixer.h"
 
#include "main.h"
#include "schuss.h"
#include "granate.h"
#include "coRect.h"
#include "spieler.h"
#include "gegner.h"
#include "level.h"
#include "panel.h"

//#include <vector>
using namespace std;

//Surfaces für alle Bilder im Spiel
SDL_Surface *back1;
SDL_Surface *back2;
SDL_Surface *backAkt;	//Jeweils aktueller Hintergrund
SDL_Surface *schussBild;
SDL_Surface *granatBild;
SDL_Surface *screen;
SDL_Surface *levelBild;
SDL_Surface *levelVerkBild;
SDL_Surface *gegnerFrames;
SDL_Surface *juwelBild;
SDL_Surface *eisBild;
SDL_Surface *munitionsBild;
SDL_Surface *granatExtraBild;
SDL_Surface *stachelnBild;
SDL_Surface *icon;
SDL_Surface* spielerBild;
SDL_Surface* eingangBild;
SDL_Surface* ausgangBild;
SDL_Surface* ausgangOffenBild;
SDL_Surface* gegnerAusgangBild;
SDL_Surface* nummernBild;
SDL_Surface* feldRot;
SDL_Surface* feldRotDurchBild;
SDL_Surface* feldGruen;
SDL_Surface* feldGruenDurchBild;
SDL_Surface* keyRotBild;
SDL_Surface* keyGruenBild;
SDL_Surface* keyMainBild;
SDL_Surface* grafiken;
SDL_Surface* nummernBildGross;
SDL_Surface* schildBild;
SDL_Surface* titelSZBild;
SDL_Surface* titelCreditsBild;
SDL_Surface* erklaerungsBild;
SDL_Surface* steuerungsBild;
SDL_Surface* erklaerung2Bild;
SDL_Surface* erklaerung3Bild;
SDL_Surface* erklaerung4Bild;
SDL_Surface* endBild;
SDL_Surface* fireBild;


SDL_Rect nummernPos[10];	//Extrahiert richtige Ziffer aus Bild

Mix_Chunk* schussSound;	//Sound-Chunks für alle Soundeffekte
Mix_Chunk* explosionSound;
Mix_Chunk* juwelSound;
Mix_Chunk* jumpSound;
Mix_Chunk* applausSound;
Mix_Chunk* keySound;
Mix_Chunk* newlifeSound;
Mix_Chunk* sterbSound;
Mix_Chunk* gameOverSound;
Mix_Chunk* collectSound;
Mix_Chunk* slamSound;

bool soundActive; 	//haben wir sound?

Panel panel;	//Seitenpanelobjekt
Level level;		//Levelobjekt, wird im gesamten Spiel benutzt, lädt jeweils benötogte Level rein
Spieler spieler(260,50,20,50);	//Spieler- Objekt definieren, wird im gesamten Spiel benutzt

CoRect* levEx [60][60];	//Globale Arrays für Sprites und Levelelemente
Gegner gegnerArr [20];
Schuss schussArr [60];
Granate granatArr [60];

//#if defined(linux)
//const char*levelArr [] = { "data/level1.bdt" , "data/level2.bdt" , "data/level3.bdt" , "data/level4.bdt" ,"data/level5.bdt" , "data/level6.bdt" , "data/level7.bdt" , "data/level8.bdt" ,"data/level9.bdt" , "data/level10.bdt" , "data/level11.bdt" , "data/level12.bdt" , "data/level13.bdt" , "data/level14.bdt" , "data/level15.bdt" ,"data/level16.bdt" , "data/level17.bdt" , "data/level18.bdt" , "data/data/level19.bdt" ,"data/level20.bdt" , "data/level21.bdt" , "data/level22.bdt", "data/level23.bdt" , "data/level24.bdt" , "data/level25.bdt" , "data/level26.bdt" , "data/level27.bdt" , "data/level28.bdt" ,"data/level29.bdt" , "data/level30.bdt" , "data/level31.bdt" , "data/level32.bdt" ,"data/level33.bdt" , "data/level34.bdt" , "data/0level35.bdt"};
const char*levelArr [] = { "level1.bdt" , "level2.bdt" , "level3.bdt" , "level4.bdt" ,"level5.bdt" , "level6.bdt" , "level7.bdt" , "level8.bdt" ,"level9.bdt" , "level10.bdt" , "level11.bdt" , "level12.bdt" , "level13.bdt" , "level14.bdt" , "level15.bdt" ,"level16.bdt" , "level17.bdt" , "level18.bdt" , "level19.bdt" ,"level20.bdt" , "level21.bdt" , "level22.bdt", "level23.bdt" , "level24.bdt" , "level25.bdt" , "level26.bdt" , "level27.bdt" , "level28.bdt" ,"level29.bdt" , "level30.bdt" , "level31.bdt" , "level32.bdt" ,"level33.bdt" , "level34.bdt" , "level35.bdt"};
//#else
//const char*levelArr [] = { "level1Win.bdt" , "level2Win.bdt" , "level3Win.bdt" , "level4Win.bdt" ,"level5Win.bdt" , "level6Win.bdt" , "level7Win.bdt" , "level8Win.bdt" ,"level9Win.bdt" ,"level10Win.bdt" , "level11Win.bdt" , "level12Win.bdt" , "level13Win.bdt" ,"level14Win.bdt" , "level15Win.bdt" , "level16Win.bdt" , "level17Win.bdt" ,"level18Win.bdt",  "level19Win.bdt" , "level20Win.bdt" , "level21Win.bdt" , "level22Win.bdt" ,"level23Win.bdt" , "level24Win.bdt" , "level25Win.bdt" , "level26Win.bdt" ,"level27Win.bdt", "level28Win.bdt" , "level29Win.bdt" , "level30Win.bdt" , "level31Win.bdt" ,"level32Win.bdt" , "level33Win.bdt" , "level34Win.bdt" , "level35Win.bdt" };
//#endif

Uint32 startzeit;
int pausenZeit = 0; //Zeit die während Pausen verbracht wurde, wichtig für Countdown
int levelNummer = 0;
int lives;
int levelSave;	//Levelstand im gespeicherten Spiel
string pfad;	//Aufrufpfad des Programmes
string dataPfad;	//Für Levels, Saves und Highscores
string homePfad;	//Für Saves und Highscores
string finalerPfad;	//Für Bilder und Sounds
bool schussPoss = true;
bool granatePoss = true;

int score = 0;	//Score des Spielers
int highScore;	//Geladener Highscore


int main(int argc, char *argv[]) {

	#if !defined(WIN32)
	pfad = argv[0];		//absoluter Pfad ermitteln und speichern
	int laenge = pfad.length();
	pfad.erase(laenge-7, 7);
	
	#endif
	
	for (int i=0; i < argc; ++i){
		string arg = argv[i];	
		if(arg== "-nosound")	//Sound abstellen wenn -nousound option gegeben
			soundActive = false;	
		else
			soundActive = true;
	}
		
	for(int i=0; i<10; ++i){		//Nummer- Frame Vector füllen
  		nummernPos[i].x = i*50;
		nummernPos[i].y = 0;
		nummernPos[i].w = 50;
		nummernPos[i].h = 56;
	}
	
	
	for(int i=0; i<60; ++i){		//Level Array initialisieren
		for(int j=0; j<60; ++j){
			levEx[i][j] = NULL;
		}
	}

	if ( SDL_Init(SDL_INIT_AUDIO|SDL_INIT_VIDEO | SDL_INIT_TIMER) < 0 )	 {//SDL initialisieren
		printf("Unable to init SDL: %s\n", SDL_GetError());
		exit(1);
	}
	
	atexit(SDL_Quit);

	if (InitImages() == -1){//Bilder laden
		cerr << "Error loading images!! Exiting." << endl;
		exit(-1);
	}
	backAkt = back1;	//Aktueller Hintergrund setzen
	SDL_WM_SetIcon(icon, NULL);	//Icon setzen

	screen=SDL_SetVideoMode(700,600,32,SDL_HWSURFACE/*|SDL_DOUBLEBUF/*|SDL_FULLSCREEN*/ );	//Video initialisieren
	
	if ( screen == NULL ) {
		printf("Unable to set 640x480 video: %s\n", SDL_GetError());
		exit(1);
	}
	SDL_WM_SetCaption("Blaster","");	//Titel setzen
	
	if(soundActive){
		Mix_OpenAudio(MIX_DEFAULT_FREQUENCY, MIX_DEFAULT_FORMAT, MIX_DEFAULT_CHANNELS, 4096);	//SDL_Mixer initialisieren!
		if (initSounds() == -1)	//Sound initialisieren
			cerr<< "Sound loading Error" << endl;
	}

	atexit(Mix_CloseAudio);
	
	SDL_SetColorKey(spielerBild, SDL_SRCCOLORKEY,SDL_MapRGB(spielerBild->format, 255, 0, 255));
	SDL_SetColorKey(schussBild, SDL_SRCCOLORKEY,SDL_MapRGB(schussBild->format, 255, 0, 255));
	SDL_SetColorKey(granatBild, SDL_SRCCOLORKEY,SDL_MapRGB(granatBild->format, 255, 0, 255));
	SDL_SetColorKey(gegnerFrames, SDL_SRCCOLORKEY,SDL_MapRGB(gegnerFrames->format, 255, 0, 255));
	SDL_SetColorKey(juwelBild, SDL_SRCCOLORKEY,SDL_MapRGB(juwelBild->format, 255, 0, 255));
	SDL_SetColorKey(munitionsBild, SDL_SRCCOLORKEY,SDL_MapRGB(munitionsBild->format, 255, 255, 255));
	SDL_SetColorKey(granatExtraBild, SDL_SRCCOLORKEY,SDL_MapRGB(granatExtraBild->format, 255, 0, 255));
	SDL_SetColorKey(stachelnBild, SDL_SRCCOLORKEY,SDL_MapRGB(stachelnBild->format, 255, 0, 255));
	SDL_SetColorKey(nummernBild, SDL_SRCCOLORKEY,SDL_MapRGB(nummernBild->format, 255, 255, 255));
	SDL_SetColorKey(grafiken, SDL_SRCCOLORKEY,SDL_MapRGB(grafiken->format, 255, 0, 255));
	SDL_SetColorKey(nummernBildGross, SDL_SRCCOLORKEY,SDL_MapRGB(nummernBildGross->format, 255, 0, 255));
	SDL_SetColorKey(schildBild, SDL_SRCCOLORKEY,SDL_MapRGB(schildBild->format, 0, 0, 0));
	SDL_SetColorKey(fireBild, SDL_SRCCOLORKEY,SDL_MapRGB(schildBild->format, 255,255, 255));
	
	int done=0;
	while(done == 0 ) {	//Programm- Hauptschlaufe
		lives = 3;	//setzt Leben wieder zurück
		levelNummer = 0;	//setzt LevelNummer wieder zurück bei Neustart des Spieles
		spieler.resetMunitionsCount();
		spieler.resetGranatenCount();
		
//TEST
//		#if defined(linux)
//		
//		if(pfad == "/usr/local/bin/"){	//Bei regulärer Installation
//			dataPfad = "/usr/local/share/blaster/";
//			homePfad = getenv("HOME");
//			homePfad = (homePfad + "/.blaster/").c_str();
//		} 
//		else if(pfad == ""){	//Wenn mit Programmname im PATH aufgerufen wird
//			//dataPfad = "/usr/local/share/blaster/";
//			dataPfad = "data/";
//			homePfad = getenv("HOME");
//			homePfad = (homePfad + "/.blaster/").c_str();
//		}
//		else{	//Falls keine Reguläre Installation durchgeführt
			//dataPfad = "data/";
			//homePfad = dataPfad;
			//homePfad = getenv("HOME");
			//homePfad = (homePfad + "/.blaster/").c_str();
//		}
		/*level.loadLevel( (dataPfad +"level1.bdt").c_str() );	//Erster Level laden
		
//		#else
		/*level.loadLevel("level1Win.bdt");*/
		homePfad = "data/";
		dataPfad = "data/";
		// TEST
		level.loadLevel( (dataPfad +"level1.bdt").c_str() );
		//#endif
		
		#if defined(linux)	
		cout << "Home: " << homePfad << endl;
		ifstream inFile( homePfad.c_str() );
		if (!inFile){	//Existiert ein .blaster Verzeichnis im HOME- Verzeichnis?
			cout <<"No .blaster directory in your HOME- directory- Generating new .blaster directory " << endl;
			ofstream outFile( homePfad .c_str() );	//neues .blaster- Verzeichnis generieren!
			system(  ("mkdir " + homePfad).c_str() );
			//outFile.write((char*) &score, sizeof(score) );
		}
		inFile.close();	
		
		inFile.open ( (homePfad + "hsc.dat").c_str() ) ;	//Highscore laden
		if (!inFile){	//Existieren Highscores?
			cout <<"No Highscores- generating new file" << endl;
			ofstream outFile( (homePfad + "hsc.dat") .c_str() );
			score = 0;
			outFile.write((char*) &score, sizeof(score) );
		}
		#else
		ifstream inFile("hsc.dat");
		#endif

		//spieler.setPosition(level.getStartPosition().xCoor, level.getStartPosition().yCoor);	//Spieler auf vom level festgelegte StartPosition setzen
		//bool show = true;
		inFile.read((char*) &highScore, sizeof(highScore) );	//Eigentliches Highscore laden

		if (showStart(0) ) {	//Zeigt Titelbildschirm an und wartet auf Tastendruck, true = neues Spiel, false = altes Spiel laden, keine Infobildschirme anzeigen
			showStart(1);	//Zeigt Spiel- infobildschirm
			showStart(2);	//Zeigt Steuerungs- Infobildschirm
			#if defined(linux)
				level.loadLevel( (dataPfad +"level1.bdt").c_str() );	//Erster Level laden
			#else
				level.loadLevel( (dataPfad +"level1.bdt").c_str() );    //Ladda första leveln
			#endif
			spieler.setPosition(level.getStartPosition().xCoor, level.getStartPosition().yCoor);
			panel.init();	//Initialisiert Seitenpanel
		}
		else{
			//level.reset();
			
			#if defined(linux)
				level.loadLevel( (dataPfad + levelArr[levelNummer] ).c_str() );
			#else
				level.loadLevel( (dataPfad + levelArr[levelNummer] ).c_str() );
			#endif
		
			spieler.setPosition(level.getStartPosition().xCoor, level.getStartPosition().yCoor);	//Spieler auf vom level festgelegte StartPosition setzen
			panel.init();
			panel.drawMunition(spieler.getMunitionsCount() );
			panel.drawScore(score);
			panel.drawLives(lives);
			panel.drawGranaten(spieler.getGranatenCount() );
			panel.drawGems(spieler.getGemCount() );
			panel.drawLevelNummer(levelNummer+1);
		}
		DrawIMG(back1, 0, 0);	//Zeichnet Hinterfrundbild
		panel.drawTime(level.getLevelZeit());
		DrawBG();	//Neuer Level zeichnen um Spieler Orientierung zu erlauben
		DrawScene();
		SDL_Flip(screen);	//Zeichnungen wirklich durchführen (dank SDL)
		waitForPlayer(2);
		
		bool imGang = true;
		while(imGang) { 	//Game- Loop
			
			int message = mainLoop();	//hier findet das eigentliche Spiel statt!!
			
			if(message == 1){
				done = 1;	// beendet Programm, da done != 0
				imGang = false;	//beendet Game- Loop
			}
			if(message == 2){	//nächster Level laden
				
			if (levelNummer == 34){	//Spiel gewonnen!! Neuanfang...
					imGang = false;
					saveScore();	//Highscore sichern, falls neuer Rekord
					showStart(6);
					//lives = 3; spieler.setGemCount(0); spieler.setGranatenCount(6); spieler.setMunitionsCount(6); 
					break;
			}
					
				playSound(20);	//Applaus spielen
				reset();
				//DrawIMG(back, 0, 0);
				
				if ( (levelNummer+1)%5 == 0 && levelNummer > levelSave){	//Alle fünf Levels Zwischenstand abspeichern,aber nur wenn neue Bestleistung
					saveLevel();
				}
				showZwischentitel();
				if (levelNummer == 1) {	//Nach dem zweiten Level Erklärungsgrafik zeigen
					showStart(3);
					//showStart(3);
					panel.init();
					panel.drawMunition(spieler.getMunitionsCount() );
					panel.drawScore(score);
					panel.drawLives(lives);
					panel.drawGranaten(spieler.getGranatenCount() );
					panel.drawGems(spieler.getGemCount() );
					panel.drawLevelNummer(levelNummer+1);
				}
				if (levelNummer == 3) {	//Nach dem vierten Level Erklärungsgrafik zeigen
					showStart(4);
					panel.init();
					panel.init();
					panel.drawMunition(spieler.getMunitionsCount() );
					panel.drawScore(score);
					panel.drawLives(lives);
					panel.drawGranaten(spieler.getGranatenCount() );
					panel.drawGems(spieler.getGemCount() );
					panel.drawLevelNummer(levelNummer+1);
				}
				if (levelNummer == 6) {	//Nach dem siebten Level Erklärungsgrafik zeigen
					showStart(5);
					panel.init();
					panel.init();
					panel.drawMunition(spieler.getMunitionsCount() );
					panel.drawScore(score);
					panel.drawLives(lives);
					panel.drawGranaten(spieler.getGranatenCount() );
					panel.drawGems(spieler.getGemCount() );
					panel.drawLevelNummer(levelNummer+1);
				}
				
				++levelNummer;
				spieler.setKeyCard(false);
				panel.drawLevelNummer(levelNummer+1);	//Level- Anzeige updaten
				#if defined(linux)
				level.loadLevel( (dataPfad + levelArr[levelNummer] ).c_str() );
				#else
				level.loadLevel( (dataPfad + levelArr[levelNummer] ).c_str() );
				#endif
				spieler.setPosition(level.getStartPosition().xCoor, level.getStartPosition().yCoor);	//Spieler auf vom level festgelegte StartPosition setzen
				if (levelNummer%2 == 1){	//Hintergrund jedes Level wechseln
					backAkt = back2;
				}
				else
					backAkt = back1;
				DrawIMG(backAkt, 0, 0);	//stellt Hinterfrundbild wieder her
				DrawBG();	//Neuer Level zeichnen um Spieler Orientierung zu erlauben
				panel.drawTime(level.getLevelZeit());	//Neue Zeit anzeigen
				DrawScene();
				SDL_Flip(screen);
				waitForPlayer(message);	//auf Tastendruck von Spieler warten
			}
			if(message == 3 || message == 4){	// Leben verloren oder Zeit abgelaufen, gleicher Level neu laden
				if (--lives == 0){
					imGang = false;		//beendet Game- Loop
					saveScore();	//Highscore sichern, falls neuer Rekord
					score = 0; spieler.setGemCount(0);
					playSound(8);	//Gelächter einspielenm
					waitForPlayer(5);	//game- over message anzeigen und bestätigen lassen
					backAkt = back1;
				}
				else{
					reset();
					DrawIMG(backAkt, 0, 0);
					#if defined(linux)
					level.loadLevel( (dataPfad + levelArr[levelNummer] ).c_str() );	//MUSS GEÄNDERT WERDEN
					#else
					level.loadLevel( (dataPfad + levelArr[levelNummer] ).c_str() ); // Fix
					#endif
					spieler.setPosition(level.getStartPosition().xCoor, level.getStartPosition().yCoor);	//Spieler auf vom level festgelegte StartPosition setzen
					panel.drawLives(lives);
					panel.drawTime(level.getLevelZeit());	//ANGEZEIGTE Zeit zurücksetzen
					DrawBG();	//Neuer Level zeichnen um Spieler Orientierung zu erlauben
					DrawScene();
					waitForPlayer(message);	//auf Tastendruck von Spieler warten
				}
			}
		} //beendet main- Schlaufe
		reset();
		
	}	//Beendet Programm- Schlaufe

  return 0;
}

bool showStart(int param) {	//Titelbildschirm und Informationsbidlschirme anzeigen und auf Tastendruck warten
	SDL_Rect filter;
	SDL_Rect dest;
	Uint32 color;
	if(param==0){	//Ttitelbildschirm mit Highscore
		//color = SDL_MapRGB (screen->format, 50, 80, 170);
		color = SDL_MapRGB (screen->format, 0, 0, 0);
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bild schwarz machen
		dest.x = 250 ;	dest.y = 460; dest.w = 100 ; dest.h = 20;	
		filter.x = 99 ;	filter.y = 52;	filter.w = 166 ;	filter.h = 13;	//High- Label
		SDL_BlitSurface(nummernBild, &filter, screen, &dest);
		filter.x = 0	;	filter.y = 13;	filter.w = 81 ;	filter.h = 13;	//Score- Label
		dest.x = 330;
		SDL_BlitSurface(nummernBild, &filter, screen, &dest);
		dest.y = 500;
		
		vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
		ziffern.push_back(highScore/100000 % 10);
		ziffern.push_back(highScore/10000 % 10);
		ziffern.push_back(highScore/1000 % 10);
		ziffern.push_back(highScore/100 % 10);
		ziffern.push_back(highScore/10 % 10);
		ziffern.push_back(highScore% 10 ); 	//ergibt einer
			
		SDL_Rect nummernPos[10];	//Extrahiert richtige Ziffer aus Bild
		for(int i=0; i<10; ++i){		//Nummer- Frame Vector füllen
				nummernPos[i].x = i*17;
				nummernPos[i].y = 0;
				nummernPos[i].w = 17;
				nummernPos[i].h = 13;
			}
		bool zeichnen = false;	
		for (int i = 0; i < ziffern.size(); ++i){
			if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
				zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen
	
			if(zeichnen){
				dest.x = 290 + 15*i ;
				SDL_BlitSurface(nummernBild, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
			}
		}
		
		//Credits/ Anweisungen- Bild:
		dest.x = 50; dest.y = 220;
		SDL_BlitSurface(titelCreditsBild, NULL, screen, &dest);
		
		
		SDL_Rect framePos[20];	//für Titel- Animation
		for(int i=0; i<7; ++i){
			framePos[i].x = i*95;
			framePos[i].y = 0;
			framePos[i].w = 95;
			framePos[i].h = 70;
		}
		SDL_Rect dest; dest.w = 30; dest.h = 30; dest.y = 100;	//Frames für Titelbuchstaben
		SDL_Event event;
		for (int i=0; i < 7; ++i){	//Code um Titelschriftzug einzublenden!
			dest.x = 15 + i * 95;
			playSound(0);
			SDL_BlitSurface (titelSZBild, &framePos[i], screen, &dest);	//Buchstaben zeichnen
			SDL_Flip(screen);
			for (int j=0; j < 10; ++j){
				while(SDL_PollEvent(&event)){	//Event handling während titelanimation!
					if ( event.type == SDL_KEYDOWN ){
						if ( event.key.keysym.sym == SDLK_SPACE ) { 
							loadSaveDefault();
							return true; 
						}
						if ( event.key.keysym.sym == SDLK_ESCAPE){ exit(0); }
						if ( event.key.keysym.sym == SDLK_r ){ 
							if ( (event.key.keysym.mod & KMOD_CTRL) != 0){	//SPIELSTAND RESETEN!
								resetSave();
								return true;
							}
						}
						if ( event.key.keysym.sym == SDLK_l && param == 0){ 
							loadSave();
							return false;
						}
					}
				}
				SDL_Delay(80);
			}
		}
		
	}
	
	if (param==1){
		color = SDL_MapRGB (screen->format, 0, 0, 0);
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bild schwarz machen
		DrawIMG(erklaerungsBild, 50, 0);	//Erklärungsbild darstellen
	}
	if (param==2){
		color = SDL_MapRGB (screen->format, 0, 0, 0);
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bild schwarz machen
		DrawIMG(steuerungsBild, 100,100);	//Steuerungsbild darstellen
	}
	if (param==3){	//Grafik nach Level 2
		color = SDL_MapRGB (screen->format, 0, 0, 0);
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bild schwarz machen
		DrawIMG(erklaerung2Bild, 50, 0);	//Erklärungsbild2 darstellen
	}
	if (param==4){	//Grafik nach Level 4
		color = SDL_MapRGB (screen->format, 0, 0, 0);
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bild schwarz machen
		DrawIMG(erklaerung3Bild, 50, 0);	//Erklärungsbild3 darstellen
	}
	if (param==5){	//Grafik nach Level 7
		color = SDL_MapRGB (screen->format, 0, 0, 0);
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bild schwarz machen
		DrawIMG(erklaerung4Bild, 100, 50);	//Erklärungsbild4 darstellen
	}
	if (param==6){	//Siegesgrafik!
		SDL_Event event;
		bool laufend = true;
		int pos = 0;
		SDL_Rect bildPos[3];
		bildPos[0].x = 0; bildPos[0].y = 0; bildPos[0].w = 110; bildPos[0].h = 160;
		bildPos[1].x = 112; bildPos[1].y = 0; bildPos[1].w = 86; bildPos[1].h = 84;
		bildPos[2].x = 135; bildPos[2].y =100; bildPos[2].w = 60; bildPos[2].h = 55;
		SDL_Rect dest;
		dest.w = 700 ; dest.h = 600;	
		
		color = SDL_MapRGB (screen->format, 0, 0, 0);	//Schwarz
		dest.x = 0 ;	dest.y = 0; dest.w = 700 ; dest.h = 600;	
		SDL_FillRect (screen, &dest, color); //Bildschirm löschen
		DrawIMG(endBild, 100,100);
		while (laufend){
			
			switch(pos){
				case 0:	playSound(0); dest.x = 200; dest.y = 300;  SDL_BlitSurface (fireBild, &bildPos[0], screen, &dest); break;
				case 1:	playSound(0); dest.x = 400; dest.y = 400;  SDL_BlitSurface (fireBild, &bildPos[1], screen, &dest); break;
				case 2:	playSound(0); dest.x = 300; dest.y = 480;  SDL_BlitSurface (fireBild, &bildPos[2], screen, &dest); break;
				case 3:	dest.x = 200; dest.y = 300;  dest.w = 700 ; dest.h = 600; color = SDL_MapRGB (screen->format, 0, 0, 0); SDL_FillRect (screen, &dest, color); break;
			}
		
			SDL_Flip(screen);
			for (int j=0; j < 8; ++j){
				while(SDL_PollEvent(&event)){	//Event handling während titelanimation!
					if ( event.type == SDL_KEYDOWN ){
						if ( event.key.keysym.sym == SDLK_SPACE ) { 
							loadSaveDefault();
							return true; 
						}
					}
				}
			SDL_Delay(80);	
			}
			++pos;
			if (pos == 4)
				pos = 0;
		}
	}
	
	SDL_Flip(screen);
	SDL_Event event;
	
	while (true){	//solange schlaufe laufen lassen bis space gedrückt wird
		while ( SDL_PollEvent(&event) ){
			SDL_Delay(50);
			if ( event.type == SDL_KEYDOWN ){
				if ( event.key.keysym.sym == SDLK_SPACE ) { 
					loadSaveDefault();
					return true; 
				}
			if ( event.key.keysym.sym == SDLK_ESCAPE){ exit(0); }
			if ( event.key.keysym.sym == SDLK_r ){ 
					if ( (event.key.keysym.mod & KMOD_CTRL) != 0){	//SPIELSTAND RESETEN!
							resetSave();
							return true;
					}
			}
			if ( event.key.keysym.sym == SDLK_l && param == 0){ 
					loadSave();
					return false;
				}
			}
		SDL_Delay(30);	//Anderen programmen Zeit geben...
		}
	}
	
}

void showZwischentitel(){	//Bildschirm zwischen Levels anzeigen
	SDL_Event event;
	SDL_Rect dest;

	Uint32 color = SDL_MapRGB (screen->format, 0, 0, 0);
	dest.x = 0 ;	dest.y = 0;	dest.w = 600 ;	dest.h = 600;
	SDL_FillRect (screen, &dest, color);
	
	vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
		ziffern.push_back((levelNummer+1)/10 % 10);	//ergibt zehner
		ziffern.push_back((levelNummer+1) % 10 ); 	//ergibt einer
		
		bool zeichnen = false;	
		for (int i = 0; i < ziffern.size(); ++i){
			if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
				zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen
			if(zeichnen){
				SDL_Rect dest;
				dest.x = 390 + 40*i ; dest.y = 200; 
				SDL_BlitSurface(nummernBildGross, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
			}
		}	
	
	DrawIMG(grafiken, 200,200, 175,60,325,190); 	//Level- Grafik
	DrawIMG(grafiken, 150,300, 350,105,0,270);	//Completed- Grafik
	if ( (levelNummer+1)%5 == 0 && levelNummer > levelSave){	//Wenn Spielstand gesavet wird (alle fünf Levels)
		DrawIMG(grafiken, 80,100, 470 ,100, 360,285);	//Progress saved!
	}
	//DrawIMG(grafiken, 140,470, 380,90,190,0);	//Press- Space- Grafik
	
	SDL_Flip(screen);
	
	for ( ; ;){	//Pausieren...
			SDL_PollEvent(&event);	//Eventpumpe betätigen
			SDL_Delay(50);	//Anderen programmen Zeit geben...
			if ( event.type == SDL_KEYDOWN ){
				if ( event.key.keysym.sym == SDLK_SPACE ) {
					break;
				}
			}
	}
}

int mainLoop() {
	int done = 0;
	Uint8* keys;
	SDL_Event event;

	

	while(true) {	//Eigentlicher main-Loop
		
		int restzeit = SDL_GetTicks() - startzeit;

		if (restzeit < 30) { SDL_Delay( 30 - restzeit); }
			startzeit = SDL_GetTicks();
		
		while ( SDL_PollEvent(&event) ){		//Event- Schleife
			if ( event.type == SDL_QUIT )  {  done = 1;  }

			if ( event.type == SDL_KEYDOWN ){
				if ( event.key.keysym.sym == SDLK_ESCAPE ) { return 1; }
				if ( event.key.keysym.sym == SDLK_SPACE ) { /*return 2; */}	// 2= im nächsten Level fortfahren (Cheat)
				//if ( event.key.keysym.sym == SDLK_p) { SDL_Delay(3000); }
			}

			if ( event.type == SDL_KEYUP ){
				if ( event.key.keysym.sym == SDLK_s )  {schussPoss = true; spieler.setSchuss(false); }
				if ( event.key.keysym.sym == SDLK_a )  {granatePoss = true; spieler.setWurf(false);}
				if ( event.key.keysym.sym == SDLK_LEFT){ spieler.setLinks(false);}
				if ( event.key.keysym.sym == SDLK_RIGHT){ spieler.setRechts(false);}
				if ( event.key.keysym.sym == SDLK_UP){ spieler.setSprung(false);}
				if ( event.key.keysym.sym == SDLK_DOWN){ spieler.setKauernd(false);}

			}
		}	//Ende Event- Schleife

			
			keys = SDL_GetKeyState(NULL);	//Liefert aktueller Zustand ALLER Knöpfe
			// if ( keys[SDLK_UP] ) {  }
			if (keys[SDLK_i] && keys[SDLK_m] && keys[SDLK_p] ) { return 2; }
			if ( keys[SDLK_DOWN] ) { spieler.setKauernd(true); }
			if ( keys[SDLK_LEFT] ) { spieler.setLinks(true);}
			if ( keys[SDLK_RIGHT] ) { spieler.setRechts(true);}
			if ( keys[SDLK_p] ) { 	//Pausenfunktion
				time_t aktZeit;
				time(&aktZeit);	//aktuelle Zeit bestimmen
				DrawIMG(grafiken,200,200,190,60,0,0);	//Pausengrafik zeichnen
				DrawIMG(grafiken, 150,300, 380,90,190,0);	//press-space-grafik zeichnen
				SDL_Flip(screen);
				for ( ; ;){	//Pausieren...
					SDL_PollEvent(&event);	//Eventpumpe betätigen
					SDL_Delay(20);	//Anderen programmen Zeit geben...
					if ( event.type == SDL_KEYDOWN ){
						if ( event.key.keysym.sym == SDLK_SPACE ) {
							time_t schlussZeit;
							time(&schlussZeit);	//aktuelle Zeit bestimmen
							pausenZeit += (int) difftime(schlussZeit, aktZeit);	//Verstrichene Zeit berechnen
							DrawIMG(backAkt, 150,200, 400,260,150,200);	//Hintergrund wieder herstellen
							break;
						}
					}
				}
					
			}


			spieler.setSprung(false);	//Ohne diese Anweisung können Sprünge nicht abgebrochen werden
			
				if ( keys[SDLK_d] && (spieler.getSprung() == false)){
					spieler.setSprung(true);
				}
			
			if ( keys[SDLK_s] && schussPoss && spieler.getMunitionsCount() > 0 ) {	//Schuss nur wenn Schuss möglich, munition vorhanden und Spieler nicht zu nahe am Rand (sonst Segfault!)
				spieler.setMunitionsCount() ; 	//veringert Munitionsvorrat um 1
				spieler.setSchuss(true);

				for (int i=0; i< 60 ; ++i) {			//Schuss auslösen
					if ( ! (schussArr[i].getIsAlive())  ) {
						if(spieler.getFacingLeft() )	{//legt Richtung des Schusses fest
							if(spieler.getX() > 25 ){	//Schuss darf nicht zu nahe am Rand abgegeben werden, sonst Segfault!
								playSound(1);
								schussArr[i] = Schuss(spieler.coRect.getX()-25, spieler.coRect.getY()+5, 10, -1, 999, schussBild);
								
							}
						}
						else {
							if (spieler.getX() < 545 ) {
								playSound(1);
								schussArr[i] = Schuss(spieler.coRect.getX()+35, spieler.coRect.getY()+5, 10, 1, 999, schussBild);
							}
						}
						break;
					}
				}
				schussPoss = false;
			}
			
			if (keys[SDLK_a] && granatePoss && spieler.getGranatenCount() > 0) {
				spieler.setGranatenCount() ;	//verringert Granatenanzahl um eins
				spieler.setWurf(true);
				
				for (int i=0; i< 60 ; ++i) {			//Granatenwurf auslösen
					if ( ! (granatArr[i].getIsAlive())  ) {
						if(spieler.getFacingLeft() )	{//legt Richtung des Schusses fest
							granatArr[i] = Granate(spieler.coRect.getX()-10, spieler.coRect.getY(), -1, 999, granatBild);
						}
						else{
							granatArr[i] = Granate(spieler.coRect.getX()+20, spieler.coRect.getY(), 1, 999, granatBild);
						}
						break;
					}
				}
				granatePoss = false;
			}
							
				
			if (spieler.getGewonnen() == true) {	//Wenn Spieler durch Ausgang geht, Level erfolgreich beenden
				spieler.setGewonnen(false);		//zurüksetzen für nächsten Level
				return 2;
			}
			
			if (spieler.getAlphaValue() == 0 /*|| ( level.getLevelZeit() - (int) difftime(aktZeit, level.getStartZeit()) ) == 0 */){	//Bei Hindernis-/Gegnerkontakt
				spieler.setAlphaValue(255);	//Anfangszustand wiederherstellen
				spieler.setKeyCard(false);
				int i = SDL_SetAlpha (spielerBild, SDL_RLEACCEL | SDL_SRCALPHA, 255);
				spieler.setSterbend(false);
				return 3;
			}
			
			time_t aktZeit;
			time(&aktZeit);	//aktuelle Zeit bestimmen
			if (  (level.getLevelZeit() - (int) difftime(aktZeit, level.getStartZeit()) + pausenZeit) == 0 ){	//Bei abgelaufener Zeit
				spieler.setAlphaValue(255);	//Anfangszustand wiederherstellen
				spieler.setKeyCard(false);
				int i = SDL_SetAlpha (spielerBild, SDL_RLEACCEL | SDL_SRCALPHA, 255);
				spieler.setSterbend(false);
				return 4;
			}
			
			panel.drawTime(level.getStartZeit(), level.getLevelZeit() , pausenZeit);	//Countdown zeichnen 
			
				//panel.drawScore(200000);
			
			DrawScene();	//Spiel updaten, d.h. alle Gegner und Spieler und Objekte bewegen und zeichnen und Kolissionsabfragen durchführen und auswerten
	}	// ende main-loop - schleife
}


void spriteKoll(CoRect* s1, CoRect* s2){
	if(s1->intersects(s2)){
		spieler.setSterbend(true);
	
		if(lives >1)	//Um überdecken des Gameover- Sounds zu verhindern
			playSound(7);
	}
}

bool waffenKoll (CoRect* sprite) {	//Behandelt Kolission zwischen Spielfiguren und Waffen
	for (int i=0; i < 60 ; ++i ) {	//Schüsse
		if(schussArr[i].getIsAlive() ) {
			if ( sprite -> intersects ( & ( schussArr[i].coRect ))  ) {
				schussArr[i].loeschen();
				
				return true;
			}
		}

	}
	
	for (int i=0; i < 60 ; ++i ) {	//Granaten
		if(granatArr[i].getIsAlive() ) {
			if ( sprite -> intersects ( & ( granatArr[i].coRect ))  ) {
				return true;
			}
		}

	}
	
	return false;
}


void einfuellen(int x, int y, int w, int h, int typ, int x2, int y2){
	levEx[x2][y2] = new CoRect (x,y,w,h,typ);
}

void parseLevel(){
	CoRect* vorheriges = levEx[0][1];
	CoRect* aktuelles = NULL;
	CoRect* naechstes = NULL;
	for (int i=1; i < 58; ++i){		//Parser für Levelkanten
		for (int j=1; j <58; ++j){
			aktuelles = levEx[j][i];
			naechstes = levEx[j+1][i];
			if (aktuelles->getTyp() == 1){
				if((vorheriges->getTyp() == 0) || (naechstes->getTyp() == 0)){
					aktuelles->setKante(true);
				}
			}
			vorheriges = aktuelles;
		}
	}
}

void reset() {	//Stellt Anfangsbedingungen bezüglich Arrays und Vektoren wieder her, um neuen Level frisch laden zu können
	for(int i=0; i<60; ++i){
			for(int k=0; k<60; ++k)
				//levEx[k][i]->setTyp(0);
				delete levEx[k][i];
	}
	for (int i=0; i< 20 ; ++i) 
		gegnerArr[i].loeschen();
	for (int i=0; i< 60 ; ++i) 
		schussArr[i].loeschen();
	for (int i=0; i< 60 ; ++i) 
		granatArr[i].loeschen();
	
	level.reset();
	spieler.reset();
	pausenZeit = 0; 	//Muss wieder 0 sein wenn neuer Level beginnt!!
}



int InitImages(){
	#if defined(linux)
	
	if ( (back1 = SDL_LoadBMP( (pfad + "images/back1.bmp").c_str() ) ) != NULL){
		finalerPfad = pfad + "images/";
		
	}
	else if ( (back1= SDL_LoadBMP("/usr/local/share/blaster/images/back1.bmp") ) != NULL)
		finalerPfad = "/usr/local/share/blaster/images/";
	
	if ( ( back2 = SDL_LoadBMP((finalerPfad +"back2.bmp").c_str() )) == NULL)
		return -1;

	if ( (spielerBild = SDL_LoadBMP((finalerPfad +"spieler.bmp").c_str() )) == NULL)
		return -1;
	if ( (schussBild = SDL_LoadBMP((finalerPfad +"schussbild.bmp").c_str() )) == NULL)
		return -1;
	if ( (granatBild = SDL_LoadBMP((finalerPfad +"granate.bmp").c_str() ) ) == NULL)
		return -1;	
	if ((levelBild = SDL_LoadBMP((finalerPfad +"level.bmp").c_str() )) == NULL)
		return -1;
	if ((levelVerkBild = SDL_LoadBMP((finalerPfad +"levelVerk.bmp").c_str() )) == NULL)
		return -1;
	if((gegnerFrames = SDL_LoadBMP((finalerPfad + "gegner.bmp").c_str() ))==NULL)
		return -1;
	if((juwelBild = SDL_LoadBMP((finalerPfad + "juwel.bmp").c_str() )) == NULL)
		return -1;
	if((eisBild = SDL_LoadBMP((finalerPfad + "eis.bmp").c_str() )) == NULL)
		return -1;
	if((munitionsBild = SDL_LoadBMP((finalerPfad + "munition.bmp").c_str() )) == NULL)
		return -1;
	if((granatExtraBild = SDL_LoadBMP((finalerPfad + "granatExtraBild.bmp").c_str() )) == NULL)
		return -1;
	if((stachelnBild = SDL_LoadBMP((finalerPfad + "stacheln.bmp").c_str() )) == NULL)
		return -1;
	if((icon = SDL_LoadBMP((finalerPfad+"icon.bmp").c_str() )) == NULL)
		return -1;
	if((eingangBild = SDL_LoadBMP((finalerPfad+"eingang.bmp").c_str() )) == NULL)
		return -1;
	if((ausgangBild = SDL_LoadBMP((finalerPfad+"ausgang.bmp").c_str() ))==NULL)
		return -1;
	if((ausgangOffenBild = SDL_LoadBMP((finalerPfad+"ausgangOffen.bmp").c_str() ))==NULL)
		return -1;
	if((gegnerAusgangBild = SDL_LoadBMP((finalerPfad+"gegnerAusgang.bmp").c_str() ))==NULL)
		return -1;
	if((nummernBild = SDL_LoadBMP((finalerPfad+"nummernBild.bmp").c_str() ))==NULL)
		return -1;
	if((feldRot = SDL_LoadBMP((finalerPfad+"feldRot.bmp").c_str() )) == NULL)
		return -1;
	if((feldRotDurchBild = SDL_LoadBMP((finalerPfad+"feldRotDurch.bmp").c_str() )) == NULL)
		return -1;
	if((feldGruen = SDL_LoadBMP((finalerPfad+"feldGruen.bmp").c_str() ))==NULL)
		return -1;
	if((feldGruenDurchBild = SDL_LoadBMP((finalerPfad+"feldGruenDurch.bmp").c_str() )) ==NULL)
		return -1;
	if((keyRotBild = SDL_LoadBMP((finalerPfad+"keyRot.bmp").c_str() ))==NULL)
		return -1;
	if((keyGruenBild = SDL_LoadBMP((finalerPfad+"keyGruen.bmp").c_str() )) == NULL)
		return -1;
	if((keyMainBild = SDL_LoadBMP((finalerPfad+"keyMain.bmp").c_str() )) == NULL)
		return -1;
	if((grafiken = SDL_LoadBMP((finalerPfad+"grafiken.bmp").c_str() )) == NULL)
		return -1;
	if((nummernBildGross = SDL_LoadBMP((finalerPfad+"nummernBildGross.bmp").c_str() )) == NULL)
		return -1;
	if((schildBild = SDL_LoadBMP((finalerPfad+"schild.bmp").c_str() )) == NULL)
		return -1;
	if((titelSZBild = SDL_LoadBMP((finalerPfad+"titelSZ.bmp").c_str() )) == NULL)
		return -1;
	if((titelCreditsBild = SDL_LoadBMP((finalerPfad+"titelCredits.bmp").c_str() )) == NULL)
		return -1;
	if((erklaerungsBild = SDL_LoadBMP((finalerPfad+"erklaerung.bmp").c_str() )) == NULL)
		return -1;
	if((steuerungsBild = SDL_LoadBMP((finalerPfad+"steuerung.bmp").c_str() )) == NULL)
		return -1;
	if((erklaerung2Bild = SDL_LoadBMP((finalerPfad+"erklaerung2.bmp").c_str() )) == NULL)
		return -1;
	if((erklaerung3Bild = SDL_LoadBMP((finalerPfad+"erklaerung3.bmp").c_str() )) == NULL)
		return -1;
	if((erklaerung4Bild = SDL_LoadBMP((finalerPfad+"erklaerung4.bmp").c_str() )) == NULL)
		return -1;
	if((endBild = SDL_LoadBMP((finalerPfad+"end.bmp").c_str() )) == NULL)
		return -1;
	if((fireBild = SDL_LoadBMP((finalerPfad+"fire.bmp").c_str() )) == NULL)
		return -1;
	#else	
	//hier unter WINDOWS laden
	  back1 = SDL_LoadBMP("images/back1.bmp");
	  back2 = SDL_LoadBMP("images/back2.bmp");
	  spielerBild = SDL_LoadBMP("images/spieler.bmp");
	  schussBild = SDL_LoadBMP("images/schussbild.bmp");
	  granatBild = SDL_LoadBMP("images/granate.bmp");
	  levelBild = SDL_LoadBMP("images/level.bmp");
	  levelVerkBild = SDL_LoadBMP("images/levelVerk.bmp");
	  gegnerFrames = SDL_LoadBMP("images/gegner.bmp");
	  juwelBild = SDL_LoadBMP("images/juwel.bmp");
	  eisBild = SDL_LoadBMP("images/eis.bmp");
	  munitionsBild = SDL_LoadBMP("images/munition.bmp");
	  granatExtraBild = SDL_LoadBMP("images/granatExtraBild.bmp");
	  stachelnBild = SDL_LoadBMP("images/stacheln.bmp");
	  icon = SDL_LoadBMP("images/icon.bmp");
	  eingangBild = SDL_LoadBMP("images/eingang.bmp");
	  ausgangBild = SDL_LoadBMP("images/ausgang.bmp");
	  ausgangOffenBild = SDL_LoadBMP("images/ausgangOffen.bmp");
	  gegnerAusgangBild = SDL_LoadBMP("images/gegnerAusgang.bmp");
	  nummernBild = SDL_LoadBMP("images/nummernBild.bmp");
	  feldRot = SDL_LoadBMP("images/feldRot.bmp");
	  feldRotDurchBild = SDL_LoadBMP("images/feldRotDurch.bmp");
	  feldGruen = SDL_LoadBMP("images/feldGruen.bmp");
	  feldGruenDurchBild = SDL_LoadBMP("images/feldGruenDurch.bmp");
	  keyRotBild = SDL_LoadBMP("images/keyRot.bmp");
	  keyGruenBild = SDL_LoadBMP("images/keyGruen.bmp");
	  keyMainBild = SDL_LoadBMP("images/keyMain.bmp");
	  grafiken = SDL_LoadBMP("images/grafiken.bmp");
	  nummernBildGross = SDL_LoadBMP("images/nummernBildGross.bmp");
	  schildBild = SDL_LoadBMP("images/schild.bmp");
	  titelSZBild = SDL_LoadBMP("images/titelSZ.bmp");
	  titelCreditsBild = SDL_LoadBMP("images/titelCredits.bmp");
	  erklaerungsBild = SDL_LoadBMP("images/erklaerung.bmp");
	  erklaerung2Bild = SDL_LoadBMP("images/erklaerung2.bmp");
	  erklaerung3Bild = SDL_LoadBMP("images/erklaerung3.bmp");
	  erklaerung4Bild = SDL_LoadBMP("images/erklaerung4.bmp");
	  steuerungsBild = SDL_LoadBMP("images/steuerung.bmp");
	  fireBild = SDL_LoadBMP("images/fire.bmp");

	  
	 #endif
 
 return 0;
}

int initSounds() {
	#if defined(linux)
	string finalerPfad;
	if ( (schussSound = Mix_LoadWAV( (pfad+"sounds/shot.wav").c_str() ) ) != NULL )
		finalerPfad = pfad + "sounds/";
	else if ( (schussSound = Mix_LoadWAV( "/usr/local/share/blaster/sounds/shot.wav") ) != NULL ) 
		finalerPfad = "/usr/local/share/blaster/sounds/";
	

	explosionSound = Mix_LoadWAV( (finalerPfad + "explosion.wav").c_str() );
	juwelSound = Mix_LoadWAV( (finalerPfad + "juwel.wav").c_str() );
	jumpSound = Mix_LoadWAV( (finalerPfad + "jump.wav").c_str() );
	applausSound = Mix_LoadWAV( (finalerPfad + "applaus.wav").c_str() );
	keySound = Mix_LoadWAV( (finalerPfad + "key.wav").c_str() );
	newlifeSound = Mix_LoadWAV( (finalerPfad + "newlife.wav").c_str() );
	sterbSound = Mix_LoadWAV( (finalerPfad + "sterb.wav").c_str() );
	gameOverSound = Mix_LoadWAV( (finalerPfad + "gameover.wav").c_str() );
	collectSound = Mix_LoadWAV( (finalerPfad + "collect.wav").c_str() );
	slamSound = Mix_LoadWAV( (finalerPfad + "slam.wav").c_str() );
	
	#else
	schussSound = Mix_LoadWAV("sounds/shot.wav");
	explosionSound = Mix_LoadWAV("sounds/explosion.wav");
	juwelSound = Mix_LoadWAV("sounds/juwel.wav");
	jumpSound = Mix_LoadWAV("sounds/jump.wav");
	applausSound = Mix_LoadWAV("sounds/applaus.wav");
	newlifeSound = Mix_LoadWAV("sounds/newlife.wav");
	keySound = Mix_LoadWAV("sounds/key.wav");
	sterbSound = Mix_LoadWAV("sounds/sterb.wav");
	gameOverSound = Mix_LoadWAV("sounds/gameOver.wav");
	collectSound  = Mix_LoadWAV("sounds/collect.wav");
	slamSound  = Mix_LoadWAV("sounds/slam.wav");
	#endif
	
	if (!schussSound || !juwelSound || !jumpSound)
		return -1;
	
	return 0;
}

void playSound(int code){	//Zentrale Funktion um Sound abzuspielen
	Mix_Chunk* temp;
	switch(code){
		case 0: temp = slamSound; break;
		case 1: temp = schussSound; break;
		case 3: temp = explosionSound; break;
		case 5: temp = jumpSound; break;
		case 7: temp = sterbSound; break;
		case 8: temp = gameOverSound; break;
		case 9: temp = newlifeSound; break;
		case 10: temp = juwelSound; break;
		case 11: temp =keySound; break;
		case 12: temp =collectSound; break;
		case 20: temp = applausSound; break;
	}
	Mix_PlayChannel (-1, temp, 0); 
}

void waitForPlayer(int message , int level ) {	//Methode um zu pausieren, Message anzuzeigen und auf Spieler zu warten...
	SDL_Event event;
	if (message == 2){
		DrawIMG(grafiken, 200,200, 175,60,325,190);	//Level...
		
		vector<int>ziffern;	//int in Ziffern zerlegen und in diesem Vektor abspeichern
		ziffern.push_back((levelNummer+1)/10 % 10);	//ergibt zehner
		ziffern.push_back((levelNummer+1) % 10 ); 	//ergibt einer
		
		bool zeichnen = false;	
		for (int i = 0; i < ziffern.size(); ++i){
			if (ziffern[i] != 0 || i == ziffern.size()-1)	//Keine führenden Nullen zeichnen, ausser wenn wir die letzte Ziffer erreicht haben, diese auf jedenfall zeichnen!
				zeichnen = true;	//Ziffer zum ersten mal nicht Null, daher können wir von nun an zeichnen
			if(zeichnen){
				SDL_Rect dest;
				dest.x = 390 + 40*i ; dest.y = 200; 
				SDL_BlitSurface(nummernBildGross, &nummernPos[ ziffern[i] ], screen, &dest);	//Korrespondierendes Bild blitten
			}
		}	
	}
	else if (message ==3)
		DrawIMG(grafiken, 200,200, 280,95,0,90);	//Life lost
	else if (message == 4)
		DrawIMG(grafiken, 200,200, 250,90,280,90);	//time up
	else if (message == 5){
		DrawIMG(grafiken, 200,200, 325,90,0,190);	//Game Over
	}
	
	DrawIMG(grafiken, 150,300, 380,90,190,0);	//press space
	
	SDL_Flip(screen);
	time_t aktZeit;
	time(&aktZeit);	//aktuelle Zeit bestimmen
	for ( ; ;){	//Pausieren...
		/*DrawIMG(back, 150,300, 380,90,150,300);
		SDL_Flip(screen);*/
		SDL_PollEvent(&event);	//Eventpumpe betätigen
		SDL_Delay(20);	//Anderen programmen Zeit geben...
				if ( event.type == SDL_KEYDOWN ){
						if ( event.key.keysym.sym == SDLK_SPACE ) {	//nur bei space fortfahren
							time_t schlussZeit;
							time(&schlussZeit);	//aktuelle Zeit bestimmen
							pausenZeit += (int) difftime(schlussZeit, aktZeit);	//Verstrichene Zeit berechnen
							DrawIMG(backAkt, 150,200, 450,200,150,200);	//Hintergrund wieder herstellen
							//SDL_Flip(screen);
							break;
						}
					}
		/*SDL_Delay(1000);
		DrawIMG(grafiken, 150,300, 380,90,190,0); //"Press Space" - Grafik
		SDL_Flip(screen);
		SDL_Delay(1000);*/
		
	}
	return;
}

void saveScore(){

	if(score > highScore){
		#if defined(linux)
			cout << "Saving: " << homePfad << "hsc.dat" << endl;
			ofstream outFile( (homePfad + "hsc.dat").c_str() );
			
			#else
			ofstream outFile("hsc.dat");
			#endif

			outFile.write((char*) &score, sizeof(score) );
	}
	
}

void loadSaveDefault(){
	#if defined(linux)
		ifstream inFile( (homePfad +"gzs.bsv").c_str() );
		if (!inFile){
			cout << "No saves- generating new File!" << endl;
			ofstream outFile( (homePfad + "gzs.bsv").c_str() );
			int mun = 6;
			int gran = 6;
			int gem = 0;
			int levelEcht = 0;	//Um Sieteneffekte zu vermeiden
			int score = 0;
			int lives = 3;
			outFile.write((char*) &score, sizeof(score) );		//Wichtige Daten in File schreiben
			outFile.write((char*) &lives, sizeof(lives) );
			outFile.write((char*) &levelEcht, sizeof(levelEcht) );
			outFile.write((char*) &mun, sizeof(mun) );
			outFile.write((char*) &gran , sizeof(gran) );
			outFile.write((char*) &gem, sizeof(gem) );
			outFile.close();
		}
	
	#else
		ifstream inFile("gzs.bsv");
	#endif
	int x;		//SAVE muss eingelesen werden, sonst wissen wir nicht, was der beste Save ist!!
	inFile.read((char*) &x, sizeof(x) );	//Dummy
	inFile.read((char*) &x, sizeof(x) );	//Dummy
	inFile.read((char*) &levelSave, sizeof(levelSave) );
}

void loadSave(){
	
	#if defined(linux)
		ifstream inFile( (homePfad +"gzs.bsv").c_str() );
		if (!inFile){
			inFile.close();
			cout << "No saves- generating new File!" << endl;
			ofstream outFile( (homePfad + "gzs.bsv").c_str() );
			int mun =6;
			int gran = 6;
			int gem = 0;
			int levelEcht = 0;	//Um Seiteneffekte zu vermeiden
			int score = 0;
			int lives = 3;
			outFile.write((char*) &score, sizeof(score) );		//Wichtige Daten in File schreiben
			outFile.write((char*) &lives, sizeof(lives) );
			outFile.write((char*) &levelEcht, sizeof(levelEcht) );
			outFile.write((char*) &mun, sizeof(mun) );
			outFile.write((char*) &gran , sizeof(gran) );
			outFile.write((char*) &gem, sizeof(gem) );
			outFile.close();
			inFile.open( (homePfad +"gzs.bsv").c_str() );
		}
	#else
		ifstream inFile("gzs.bsv");
	#endif

	int sc, lv, mun, gran, gem;
	inFile.read((char*) &sc, sizeof(sc) );
	inFile.read((char*) &lv, sizeof(lv) );
	inFile.read((char*) &levelSave, sizeof(levelSave) );
	inFile.read((char*) &mun, sizeof(mun) );
	inFile.read((char*) &gran, sizeof(gran) );
	inFile.read((char*) &gem, sizeof(gem) );	
	lives = lv; levelNummer = levelSave; spieler.setMunitionsCount(mun); spieler.setGranatenCount(gran); spieler.setGemCount(gem);

}

void resetSave(){
	#if defined(linux)
	ofstream outFile( (homePfad + "gzs.bsv").c_str() );
	#else
	ofstream outFile("gzs.bsv");
	#endif	
	int lives = 3;
	int mun = 6;
	int gran = 6;
	int gem = 0;
	int levelEcht = 0;	//Wieder auf Level 1 zurücksetzen!	
	outFile.write((char*) &score, sizeof(score) );		//Wichtige Daten in File schreiben
	outFile.write((char*) &lives, sizeof(lives) );
	outFile.write((char*) &levelEcht, sizeof(levelEcht) );
	outFile.write((char*) &mun, sizeof(mun) );
	outFile.write((char*) &gran , sizeof(gran) );
	outFile.write((char*) &gem, sizeof(gem) );
	outFile.close();
}

void saveLevel(){	//Alle fünf Levels Spielzwischenstand abspeichern
	cout << "Saving level" << endl;
	#if defined(linux)
	ofstream outFile( (homePfad + "gzs.bsv").c_str() );
	#else
	ofstream outFile("gzs.bsv");
	#endif	
	int mun = spieler.getMunitionsCount();
	int gran = spieler.getGranatenCount();
	int gem = spieler.getGemCount();
	int levelEcht = levelNummer;	//Um Sieteneffekte zu vermeiden
	levelEcht +=1;
	outFile.write((char*) &score, sizeof(score) );		//Wichtige Daten in File schreiben
	outFile.write((char*) &lives, sizeof(lives) );
	outFile.write((char*) &levelEcht, sizeof(levelEcht) );
	outFile.write((char*) &mun, sizeof(mun) );
	outFile.write((char*) &gran , sizeof(gran) );
	outFile.write((char*) &gem, sizeof(gem) );
	outFile.close();
}


void DrawIMG(SDL_Surface *img, int x, int y)	{	//Methode die dasZeichnen von Surfaces kapselt
	SDL_Rect dest;
	dest.x = x;
	dest.y = y;
	SDL_BlitSurface(img, NULL, screen, &dest);
}

void DrawIMG(SDL_Surface *img, int x, int y, int w, int h, int x2, int y2) {	//x und y : ziel auf dem Bildschirm; x2, y2: ausschnitt aus dem quellbild
	SDL_Rect dest;
	dest.x = x;
	dest.y = y;
	SDL_Rect dest2;
	dest2.x = x2;
	dest2.y = y2;
	dest2.w = w;
	dest2.h = h;
	SDL_BlitSurface(img, &dest2, screen, &dest);
}



void DrawBG() {//Zeichnet den Hintergrund

	DrawIMG(backAkt,spieler.getX()-20, spieler.getY()-20, 70,85,spieler.getX()-20, spieler.getY() - 20);	//Spieler

	//die folgenden Methoden zeichnen den Hintergrund nur an jenen Stellen neu, wo sich vorher Objekte befunden haben
	for (int i=0; i < 60; ++i){	//Schüsse
		if (schussArr[i].getIsAlive() ){
			DrawIMG(backAkt,schussArr[i].getX()-10, schussArr[i].getY(), 40,7,schussArr[i].getX()-10, schussArr[i].getY() );
		}
	}
	
	for (int i=0; i < 60; ++i){	//Granaten
		if (granatArr[i].getIsAlive() ){
			DrawIMG(backAkt,granatArr[i].getX()-10, granatArr[i].getY(), 40,40, granatArr[i].getX()-10, granatArr[i].getY() );
		}
	}


	for (int i=0; i < 20; ++i){	//Gegner
		if (gegnerArr[i].getIsAlive() ){
			DrawIMG(backAkt,gegnerArr[i].getX()-20, gegnerArr[i].getY()-15, 70,80,gegnerArr[i].getX()-20, gegnerArr[i].getY() - 15);
		}
	}
   

}

void DrawScene() {		//Bewegt, zeichnet und löscht Sprites

	SDL_Rect clipRect;
	clipRect.x =0; clipRect.y = 0; clipRect.w = 600; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);
	
	DrawBG();
	
	for(int i=0; i<60; ++i){	//Level zeichnen
		for(int j=0; j<60; ++j){
			if(levEx[i][j]->getTyp() == 1){
				/*if(levEx[i][j]->getKante() == true)
					DrawIMG(feldGruen, levEx[i][j]->getX(), levEx[i][j]->getY());
				else*/
					DrawIMG(levelBild, levEx[i][j]->getX(), levEx[i][j]->getY());
				
			}
			else if(levEx[i][j]->getTyp() == 2){		//Eis = 2
				DrawIMG(eisBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 3){		//Stacheln = 3
				DrawIMG(stachelnBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 5)	{	//grünes Kraftfeld = 5
				DrawIMG(feldGruen, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 50)	{	//Durchlässiges grünes Kraftfeld
				DrawIMG(feldGruenDurchBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			
			else if(levEx[i][j]->getTyp() == 6)	{	//rotes Kraftfeld = 6
				DrawIMG(feldRot, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 60)	{	//Durchlässiges rotes Kraftfeld
				DrawIMG(feldRotDurchBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 11)	{	//Juwelen = 11
				DrawIMG(juwelBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 12)	{	//Munitionsextra = 12
				DrawIMG(munitionsBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 13)	{	//Rote Keycard= 13
				DrawIMG(keyRotBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 14)	{	//Grüne Keycard= 14
				DrawIMG(keyGruenBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 15)	{	//Main- Keycard = 15
				DrawIMG(keyMainBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 16)	{	//Granatenextra= 16
				DrawIMG(granatExtraBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			else if(levEx[i][j]->getTyp() == 17)	{	//Schildextra= 17
				DrawIMG(schildBild, levEx[i][j]->getX(), levEx[i][j]->getY());
			}
			
			
		}
	}
	
	for(int i=0; i < 58; ++i)	//Optische Verschönerung des Spielfeldrandes
		DrawIMG(levelVerkBild,0, 10 + i * 10);
	for(int i=0; i < 58; ++i)
		DrawIMG(levelVerkBild,590, 10 + i * 10);
	
	for (int i=0; i < 3; ++i) {	//Zeichnet Eingänge (Code 8)
				Eingang eingang = level.getEingang(i);
				DrawIMG(eingangBild, eingang.xCoor, eingang.yCoor);
			}
	
	Eingang ausgang = level.getAusgang();	//Zeichnet Ausgang (Code 21)
	if (spieler.getKeyCard() ) 
		DrawIMG(ausgangOffenBild, ausgang.xCoor, ausgang.yCoor);		//Zeichnet offene türe, wenn Spieler Main- KeyCard hat
	else
		DrawIMG(ausgangBild, ausgang.xCoor, ausgang.yCoor);	//geschlossene Türe, normaler Zustand
		
	Eingang gegnerAusgang = level.getGegnerAusgang();
	DrawIMG(gegnerAusgangBild, gegnerAusgang.xCoor, gegnerAusgang.yCoor);		//Zeichnet GegnerAusgang (Code 22)
	
	spieler.move();
	spieler.display(screen);

 	bool geloeschtS = false;		//Bewegt Schüsse und führt Kolissionsabfragen duch
	for (int i=0; i < 60; ++i){
		if(schussArr[i].getIsAlive() ) {
			if ( ! (schussArr[i].move())  ){
				schussArr[i].loeschen();
				geloeschtS = true;
			}
			if (! geloeschtS )
				schussArr[i].display(screen);

		}
	}
	
	bool geloeschtG = false;		//Bewegt Granaten und führt Kolissionsabfragen duch
	for (int i=0; i < 60; ++i){
		if(granatArr[i].getIsAlive() ) {
			if ( ! (granatArr[i].move())  ){
				granatArr[i].loeschen();
				geloeschtG = true;
			}
			if (! geloeschtG )
				granatArr[i].display(screen);

		}
	}
	
	bool geloescht =false;
	for (int i=0; i < 20; ++i){					//Gegner updaten
		if (gegnerArr[i].getIsAlive() ) {
			if ( gegnerArr[i].move(i)  ){
				gegnerArr[i].loeschen();
				geloescht = true;
			}
			if(!geloescht)
				gegnerArr[i].display(screen);
		}
	}
	
	level.gegnerGenerator();			//Scripting
	
	SDL_Flip(screen);
	
	clipRect.x =0; clipRect.y = 0; clipRect.w = 700; clipRect.h = 600;
	SDL_SetClipRect(screen, &clipRect);

}


