//==============================================================================
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Library General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
//==============================================================================

//==============================================================================
// Tiedosto: cTutris.hpp
// Tekijä: Jarmo Hekkanen <jarski@2ndpoint.fi>
//­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-
#ifndef cTutris_hpp
#define cTutris_hpp
//­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-
// Sisällytettävät otsikkotiedostot
#include <string>
#include <SDL.h>
#include "SoFont.h"

using namespace std;
//­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-
// Peliin liittyvät vakiot
const int 		BlockSize 		= 15;	// Kuinka iso yksi palikka on (pikseleitä)
const int 		NumberOfBlocks	= 7;	// Kuinka monta erilaista palikkaa on
const int 		AreaWidth 		= 18;	// Kuinka leveä pelialue on (palikoita)
const int 		AreaHeight 		= 28;	// Kuinka korkea pelialue on (palikoita)
const Uint32	StartDropDelay	= 1000;	// Kuinka nopeasti palikkaa putoaa pelin alussa
const Uint32 	MoveDelay 		= 130;	// Kuinka nopeasti pelaaja voi liikuttaa palikkaa
const int 		AreaX 			= 185;	// Pelialueen X-koordinaatti
const int 		AreaY 			= 30;	// Pelialueen Y-koordinaatti
const int 		NextShapeX 		= 500;	// 'Seuraava palikka'-näytön X-koordinaatti
const int 		NextShapeY 		= 100;	// 'Seuraava palikka'-näytön Y-koordinaatti
const int 		LevelX 			= 120;	// 'Taso'-näytön X-koordinaatti
const int 		LevelY 			= 280;	// 'Taso'-näytön Y-koordinaatti
const int 		ScoreX 			= 20;	// 'Pisteet'-näytön X-koordinaatti
const int 		ScoreY 			= 340;	// 'Pisteet'-näytön Y-koordinaatti
const int 		LinesX 			= 20;	// 'Rivit'-näytön X-koordinaatti
const int 		LinesY 			= 400;	// 'Rivit'-näytön Y-koordinaatti
const string	BackgroundFile	= "background.png";
const string	BlocksFile		= "blocks.png";
const string	FontFile		= "font.png";
//­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-
// Palikan liikkeen mahdolliset suunnat
enum Direction { Left = 0, Right, Down };
//==============================================================================

//==============================================================================
// Tämä luokka sisältää kaikki pelissä tarvittavat muuttujat ja metodit
//­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-
class cTutris
{
	// Constructor & Destructor
	public:
		// Constructor
		cTutris (void);
		// Destructor
		~cTutris (void);
	
	// Yleiset metodit
	public:
		// Alustaa pelin
		int Initialize (void);
		// Pääsilmukka
		int MainLoop (void);
	
	// Yksityiset metodit
	private:
		// Aloittaa uuden pelin
		void NewGame (void);
		// Palikkataulukkojen piirtorutiini
		void DrawBlocks (int x, int y, int width, int height, Uint8 *pArray);
		// Piirtää pistetilanteen ruudulle
		void DrawScore (void);
		// Tapahtuma käsittelijä
		void EventHandler (void);
		// Tarkistaa onko pelialueella täysiä rivejä, ja poistaa ne
		void CheckFullLines (void);
		// Pelin loppukikkailut
		void GameOver (void);
		// Panee pelin pausille
		void Pause (void);
	
		// Alustaa palikan satunnaisesti valitulla muodolla
		void RandomShape (Uint8 *pShape);
		// Palikan pudotusrutiini
		void DropShape (int linesToDrop);
		// Palikan siirtorutiini
		bool MoveShape (Direction direction);
		// Palikan pyöritysrutiini
		void RotateShape (Uint8 *pShape);
		// Liimaa palikan pelialueelle
		void ClueShape (void);
		// Palikan törmäystarkistus
		bool Collision (int x, int y, Uint8 *pShape);
		
		// Lataa kuvan tiedostosta ja konvertoi sen oikeaan formaattiin
		SDL_Surface *LoadImage (string filename, bool alpha = false);
		
	// Yksityiset muuttujat
	private:
		// Yleiset muuttujat
		bool mRunning;				// Onko peli käynnissä?
		bool mRedrawPlayArea;		// Pitääkö pelialue piirtää
		bool mRedrawNextShape;		// Pitääkö seuraava palikka piirtää
		bool mRedrawScore;			// Pitääkö pisteet piirtää
				
		// Peli data
		Uint8 mCurrentShape[16];				// Pelaajan palikka
		Uint8 mNextShape[16];					// Seuraava palikka
		Uint8 mPlayArea[AreaWidth * AreaHeight];// Pelialue
		int mShapeX;							// Palikan X-koordinaatti
		int mShapeY;							// Palikan Y-koordinaatti
		
		// Palikan putoaminen
		Uint32 mLastDrop;						// Viimeisen pudotuksen tick count
		Uint32 mDropDelay;						// Pudotusten väli
		
		// Palikan ohjaus
		bool mMoving;		// Liikuttaako pelaaja palikkaa
		Direction mMoveDir;	// Liikkeen suunta
		Uint32 mLastMove;	// Viimeisen liikkeen tick count
		
		// Pisteet
		int mLevel;		// Taso
		int mScore;		// Pisteet
		int mLines;		// Rivit
	
		// Video data
		SDL_Surface *mpScreen;		// Video surface
		SDL_Surface *mpBackground;	// Taustakuva
		SDL_Surface *mpBlocks;		// Palikoiden kuvat
				
		// Fontti
		SoFont mFont;
};
//==============================================================================

//==============================================================================
#endif // cTutris_hpp
//­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-­-
// EOF
//==============================================================================
