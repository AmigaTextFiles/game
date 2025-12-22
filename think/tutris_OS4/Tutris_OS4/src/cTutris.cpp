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
// Tiedosto: cTutris.cpp
// Tekij‰: Jarmo Hekkanen <jarski@2ndpoint.fi>
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Sis‰llytett‰v‰t otsikkotiedostot
#include "cTutris.hpp"
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <SDL_image.h>
//==============================================================================

//==============================================================================
// Constructor
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Alustetaan joitain muuttuja
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
cTutris::cTutris (void):
mpScreen (SDL_GetVideoSurface ()),	// Video surface
mpBackground (NULL),
mpBlocks (NULL)
{
};
//==============================================================================

//==============================================================================
// Destructor
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Vapautetaan grafiikkoja
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
cTutris::~cTutris (void)
{
	// Vapautetaan grafiikat
	SDL_FreeSurface (mpBackground);
	SDL_FreeSurface (mpBlocks);
};
//==============================================================================
	
//==============================================================================
// Initialize the game
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Alustaa pelin. Kun t‰m‰ metodi on suoritettu onnistuneesti, peli voidaan 
// k‰ynnist‰‰ MainLoop-metodia kutsumalla.
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Palauttaa:
// 		0: jos kaikki ok
//		1: jos tapahtui virhe
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
int 
cTutris::Initialize (void)
{
	// Siemennet‰‰n satunnaislukugeneraattori =)
	srand (time (NULL));
	
	// Ladataan taustakuva
	mpBackground = LoadImage (BackgroundFile);
	if ( mpBackground == NULL )
		return EXIT_FAILURE;
	
	// Ladataan palikoiden kuvat
	mpBlocks = LoadImage (BlocksFile);
	if ( mpBlocks == NULL )
		return EXIT_FAILURE;
	
	// Ladataan fontti
	SDL_Surface *pFontSurface = LoadImage (FontFile, false);
	if ( pFontSurface == NULL )
		return EXIT_FAILURE;
	
	mFont.load (pFontSurface);
	
	// Aloitetaan uusi peli
	NewGame ();
	
	return EXIT_SUCCESS;
}
//==============================================================================

//==============================================================================
// Aloittaa uuden pelin
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Alustaa muuttujat oikeisiin aloitusarvoihin
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
void 
cTutris::NewGame (void)
{
	// Tyhjennet‰‰n pelialue
	memset (mPlayArea, 0, AreaWidth * AreaHeight);
		
	// Alustetaan nykyinen palikka
	RandomShape (mCurrentShape);
	// Keskitet‰‰n palikka sivuttaissuunnassa
	mShapeX = (AreaWidth - 4) / 2;
	// Asetetaan palikka pelialueen yl‰laitaan
	mShapeY = 0;
		
	// Alustetaan seuraava palikka
	RandomShape (mNextShape);
	
	// Alustetaan pisteet
	mLevel = 1;
	mScore = mLines = 0;
	
	// Alustetaan palikan liikkeeseen liittyv‰t muuttujat
	mMoving = false;				// Pelaaja ei liikuta palikkaa t‰ll‰ hetkell‰
	mDropDelay = StartDropDelay;	// Aloitus viive palikan putoamiselle
	mLastDrop = SDL_GetTicks ();
	
	// Piirret‰‰n taustakuva ruudulle
	SDL_BlitSurface (mpBackground, NULL, mpScreen, NULL);
	SDL_Flip (mpScreen);
	
	// M‰‰r‰t‰‰n kaikki alueet piirrett‰viksi
	mRedrawPlayArea = true;
	mRedrawNextShape = true;
	mRedrawScore = true;
}
//==============================================================================

//==============================================================================
// P‰‰silmukka
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
int 
cTutris::MainLoop (void)
{
	// P‰‰silmukka pyˆrii kunnes mRunning asetetaan false:ksi
	mRunning = true;
	while ( mRunning )
	{
		// K‰sitell‰‰n tapahtumat
		EventHandler ();
		
		// Paljos se kello on t‰h‰n aikaan p‰iv‰st‰?
		Uint32 now = SDL_GetTicks ();
		
		// Lasketaan kuinka monta rivi‰ palikka on pudonnut sitten viime p‰ivityksen
		int linesToDrop = (now - mLastDrop) / mDropDelay;
		if ( linesToDrop > 0 )
		{
			// Lasketaan viimeisein pudotuksen aika
			mLastDrop += linesToDrop * mDropDelay;
			// Pudotetaan palikkaa
			DropShape (linesToDrop);
			// ...joten se tarvitsee uudelleen piirt‰mist‰
			mRedrawNextShape = true;
		}
		
		// Onko palikka liikkeess‰
		if ( mMoving )
		{
			// Onko seuraavan liikutuksen aika?
			if ( now - mLastMove >= MoveDelay )
			{
				// Liikutetaan palikkaa...
				MoveShape (mMoveDir);
				// ...ja lasketaan liikutuksen aika
				mLastMove = mLastMove + MoveDelay;
				// M‰‰r‰t‰‰n pelialue uudelleen piiirrett‰v‰ksi
			}
		}
		
		// Piirret‰‰n pelialue
		if ( mRedrawPlayArea )
		{
			// Pyyhit‰‰n pelialue eli kopioidaan taustakuvsta ao. alue n‰ytˆlle
			SDL_Rect playArea = {AreaX, AreaY, AreaWidth * BlockSize, AreaHeight * BlockSize};
			SDL_BlitSurface (mpBackground, &playArea, mpScreen, &playArea);
			
			// Piirret‰‰n pelialue
			DrawBlocks (AreaX, AreaY, AreaWidth, AreaHeight, mPlayArea);
			
			// Piirret‰‰n palikka
			DrawBlocks (AreaX + mShapeX * BlockSize, AreaY + mShapeY * BlockSize, 4, 4, mCurrentShape);
			
			mRedrawPlayArea = false;
			
			// P‰ivitet‰‰n n‰yttˆ
			SDL_UpdateRects (mpScreen, 1, &playArea);
		}
		
		// Piirret‰‰n 'seuraava palikka'-n‰yttˆ
		if ( mRedrawNextShape )
		{
			// Pyyhit‰‰n n‰yttˆ oikasta kohdasta
			SDL_Rect nextShape = { NextShapeX, NextShapeY, 4 * BlockSize, 4 * BlockSize };
			SDL_BlitSurface (mpBackground, &nextShape, mpScreen, &nextShape);
			
			// Piirret‰‰n seuraava palikka
			DrawBlocks (NextShapeX, NextShapeY, 4, 4, mNextShape);
			
			mRedrawNextShape = false;
			
			// P‰ivitet‰‰n n‰yttˆ
			SDL_UpdateRects (mpScreen, 1, &nextShape);
		}
		
		if ( mRedrawScore )
		{
			DrawScore ();
		}
		
		// Pikku viive
		SDL_Delay (SDL_TIMESLICE);
	}
	
	SDL_Delay (500);
	
	return EXIT_SUCCESS;
}
//==============================================================================

//==============================================================================
// Tapahtuma k‰sittelij‰
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// T‰m‰ metodi k‰sittelee SDL:n l‰hett‰mi‰ tapahtumia ja toimii kuten
// parhaaksi n‰kee...
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
void 
cTutris::EventHandler (void)
{
	SDL_Event event;
	
	while ( SDL_PollEvent (&event) != 0 )
	{
		switch ( event.type )
		{
			case SDL_QUIT:
				// Pys‰ytet‰‰n p‰‰silmukka
				mRunning = false;
				break;
			case SDL_KEYDOWN:
				switch ( event.key.keysym.sym )
				{
					case SDLK_ESCAPE:
						// Pys‰ytet‰‰n p‰‰silmukka
						mRunning = false;
						break;
					case SDLK_LEFT:
						mMoving = true;
						mMoveDir = Left;
						mLastMove = SDL_GetTicks () - MoveDelay;
						break;
					case SDLK_RIGHT:
						mMoving = true;
						mMoveDir = Right;
						mLastMove = SDL_GetTicks () - MoveDelay;
						break;
					case SDLK_DOWN:
						mMoving = true;
						mMoveDir = Down;
						mLastMove = SDL_GetTicks () - MoveDelay;
						break;
					case SDLK_UP:
						RotateShape (mCurrentShape);
						break;						
					case SDLK_SPACE:
						DropShape (AreaHeight + 4);
						break;
					case SDLK_F11:
						//SDL_WM_ToggleFullScreen (mpScreen);
						break;
					case SDLK_F10:
						// Tallennetaan screenshotti
						SDL_SaveBMP (mpScreen, "screenshot.bmp");
						break;
					case SDLK_F1:
						// Uusi peli
						NewGame ();
						break;
					case SDLK_F2:
						// Paussi
						Pause ();
						break;
					default:
						break;
				}
				break;
			case SDL_KEYUP:
				switch ( event.key.keysym.sym )
				{
					case SDLK_LEFT:
						if ( mMoveDir == Left )
							mMoving = false;
						break;
					case SDLK_RIGHT:
						if ( mMoveDir == Right )
							mMoving = false;
						break;
					case SDLK_DOWN:
						if ( mMoveDir == Down )
							mMoving = false;
						break;
					default:
						break;
				}
				break;
			default:
				break;
		}
	}
}
//==============================================================================

//==============================================================================
// Panee pelin pausille
//------------------------------------------------------------------------------
void 
cTutris::Pause (void)
{	
	// Tallennetaan ajat
	Uint32 now = SDL_GetTicks ();
	Uint32 dropTime = now - mLastDrop;
	Uint32 moveTime = now - mLastMove;
	
	SDL_Rect playArea = {AreaX, AreaY, AreaWidth * BlockSize, AreaHeight * BlockSize};
	
	// V‰liaikainen taulukko, jolla peitet‰‰n varsinainen pelialue
	Uint8 temp[AreaWidth * AreaHeight];
	Uint8 color = 1;	// T‰yttˆ v‰ri

	// Piirret‰‰n taulukko
	memset (temp, color, AreaWidth * AreaHeight);
	DrawBlocks (AreaX, AreaY, AreaWidth, AreaHeight, temp);
	// P‰ivitet‰‰n n‰yttˆ
	SDL_UpdateRects (mpScreen, 1, &playArea);

	// Odotellaan kunnes peli jatkuu
	bool paused = true;
	SDL_Event event;
	while ( paused )
	{
		if ( temp[0] != color )
		{
			// Piirret‰‰n taulukko
			memset (temp, color, AreaWidth * AreaHeight);
			DrawBlocks (AreaX, AreaY, AreaWidth, AreaHeight, temp);
			// P‰ivitet‰‰n n‰yttˆ
			SDL_UpdateRects (mpScreen, 1, &playArea);
		}

		// Odotetaan tapahtumia
		SDL_WaitEvent (&event);
		switch ( event.type )
		{
			case SDL_QUIT:
				paused = false;
				mRunning = false;
				break;
			case SDL_KEYDOWN:
				switch ( event.key.keysym.sym )
				{
					case SDLK_ESCAPE:
						paused = false;
						mRunning = false;
						break;
					case SDLK_F2:
						paused = false;
						break;
					default:
						// Vaihdetaan v‰ri‰
						color++;
						if ( color == 0 || color > NumberOfBlocks )
							color = 1;
						break;
				}
		}
	}
	// Piiret‰‰n varsinainen pelialue uudelleen
	mRedrawPlayArea = true;
	
	// Palautetaan ajat
	mLastDrop = SDL_GetTicks () - dropTime;
	mLastMove = SDL_GetTicks () - moveTime;
}
//==============================================================================

//==============================================================================
// Palikkataulukkojen piirtorutiini
//------------------------------------------------------------------------------
// Parametrit:
//		x: piirtoalueen vasemman yl‰kulman X-koordinaatti
//		y: piirtoalueen vasemman yl‰kulman Y-koordinaatti
//		width: taulukon leveys
//		height: taulukon korkeus
//		pArray: taulukko, joka piirret‰‰n (koko pit‰‰ olla width*height)
//------------------------------------------------------------------------------
void 
cTutris::DrawBlocks (int x, int y, int width, int height, Uint8 *pArray)
{
	SDL_Rect srcRect, dstRect;
	Uint8 blockID;
	
	// Asetetaan l‰hdenelikulmio
	srcRect.w = srcRect.h = BlockSize;
	srcRect.y = 0;
	
	// K‰yd‰‰n l‰pi taulukko
	for ( int yy = 0; yy < height; yy++ )
	{
		for ( int xx = 0; xx < width; xx++ )
		{
			// Haetaan palikan koodi
			blockID = pArray[yy * width + xx];
			
			// Jos palikka ei ole nolla, eik‰ suurempi kuin erilaisten palikoiden m‰‰r‰
			if ( blockID > 0 && blockID <= NumberOfBlocks )
			{
				// Valitaan oikea palikan kuva
				srcRect.x = (blockID - 1) * BlockSize;
				
				// Asetetaan kohdenelikulmio
				dstRect.x = x + xx * BlockSize;
				dstRect.y = y + yy * BlockSize;
				
				// Piirret‰‰n palikka
				SDL_BlitSurface (mpBlocks, &srcRect, mpScreen, &dstRect);
			}
		}
	}
}
//==============================================================================

//==============================================================================
// Alustaa palikan satunnaisesti valitulla muodolla
//------------------------------------------------------------------------------
void
cTutris::RandomShape (Uint8 *pShape)
{
	// Tyhjennet‰‰n taulukko
	memset (pShape, 0, 16);
	
	// Arvotaan muoto
	int randomShape = int (1.0f + 7.0f * rand () / (RAND_MAX + 1.0f));
	switch ( randomShape )
	{
		case 1:
			pShape[2] = pShape[6] = pShape[10] = pShape[14] = randomShape;
			break;
		case 2:
			pShape[5] = pShape[6] = pShape[9] = pShape[13] = randomShape;
			break;
		case 3:
			pShape[5] = pShape[6] = pShape[10] = pShape[14] = randomShape;
			break;
		case 4:
			pShape[2] = pShape[6] = pShape[5] = pShape[9] = randomShape;
			break;
		case 5:
			pShape[1] = pShape[5] = pShape[6] = pShape[10] = randomShape;
			break;
		case 6:
			pShape[5] = pShape[6] = pShape[9] = pShape[10] = randomShape;
			break;
		case 7:
			pShape[2] = pShape[6] = pShape[10] = pShape[5] = randomShape;
			break;
		default:
			cout << "Invalid random shape number " << randomShape << endl;
			break;
	}
	
}
//==============================================================================

//==============================================================================
// Palikan pudotusrutiini
//------------------------------------------------------------------------------
// Pudottaa palikkaa [linesToDrop] rivi‰ alasp‰in. Jos palikka tˆrm‰‰ johonkin
// 'Liimataan' se pelialueeseen.
// Parametrit:
//	linesToDrop: kuinka monta rivi‰ palikkaa pudotetaan
//------------------------------------------------------------------------------
void 
cTutris::DropShape (int linesToDrop)
{
	for ( int i = 0; i < linesToDrop; i++ )
	{
		// Pudotetaan palikkaa alasp‰in ja jos se tˆrm‰‰ johonkin...
		if ( MoveShape (Down) == false )
		{
			//...liimataan se pelialustaan
			ClueShape ();
			return;
		}
	}
}
//==============================================================================

//==============================================================================
// Palikan siirtorutiini
//------------------------------------------------------------------------------
// Tutkii voiko palikaa siirt‰‰ johonkin suuntaan ja siirt‰‰ sit‰ jos voi
// Parametrit:
//	direction: liikkeen suunta
// Palauttaa:
//	true: jos palikkaa siirrettiin (se ei tˆrm‰nnyt mihink‰‰n)
//	false: jos palikkaa ei voitu siirt‰‰ (se tˆrm‰si johonkin)
//------------------------------------------------------------------------------
bool
cTutris::MoveShape (Direction direction)
{
	// Palikan uudet koordinaatit
	int newX = mShapeX;
	int newY = mShapeY;
	
	// Muutetaan uusia koordinaatteja liikeen suunnasta riippuen
	switch ( direction )
	{
		case Left:
			newX--;
			break;
		case Right:
			newX++;
			break;
		case Down:
			newY++;
			break;
		default:
			return false;
	}
	
	// Tarkistetaan tˆrm‰‰kˆ palikka johonkin uusissa koordinaateissa
	if ( Collision (newX, newY, mCurrentShape) )
		return false;	// Jos tˆrm‰‰ niin palikkaa ei siirret‰
	
	// Palikka ei tˆrm‰‰, joten siirret‰‰n sit‰
	mShapeX = newX;
	mShapeY = newY;
	
	// Pelialue kaipaa uudelleen piirtoa
	mRedrawPlayArea = true;
	
	// Siirsimme palikkaa joten palautamme true...
	return true;
}
//==============================================================================

//==============================================================================
// Palikan pyˆritysrutiini
//------------------------------------------------------------------------------
// Tutkii voiko palikkaa pyˆritt‰‰ ja jos voi niin pyˆritt‰‰ sit‰
// 90 astetta myˆt‰p‰iv‰‰n
// Parametrit:
//	pShape: palikka jota pyˆritet‰‰n (koko t‰ytyy olla 16)
//------------------------------------------------------------------------------
void 
cTutris::RotateShape (Uint8 *pShape)
{
	// Pyˆritet‰‰n palikkaa ja tallennetaan tulos v‰liaikaiseen taulukkoon
	Uint8 tempShape[16];
	for ( int yy = 0; yy < 4; yy++ )
	{
		for ( int xx = 0; xx < 4; xx++ )
		{
			tempShape[xx * 4 + 3 - yy] = pShape[yy * 4 + xx];
		}
	}
	
	// Tarkistetaan tˆrm‰‰kˆ pyˆritetty palikka johonkin
	if ( Collision (mShapeX, mShapeY, tempShape) == false )
	{
		// Jos ei niin kopioidaan v‰liaikaisen taulukon sis‰ltˆ varsinaiseen taulukkoon...
		memcpy (pShape, tempShape, 16);
		// ...ja m‰‰r‰t‰‰n pelialue uudelleen piirrett‰v‰ksi
		mRedrawPlayArea = true;
	}
}
//==============================================================================

//==============================================================================
// Palikan tˆrm‰ystarkistus
//------------------------------------------------------------------------------
// Tarkistaa tˆrm‰‰kˆ annettu palikka annetussa kohdassa pelialueen reunoihin
// tai pelialueella oleviin rakennelmiin.
// Parametrit:
//	x: Palikan X-koordinaatti
//	y: Palikan Y-koordinaatti
// pShape: Palikka
//------------------------------------------------------------------------------
bool 
cTutris::Collision (int x, int y, Uint8 *pShape)
{
	int areaX, areaY;
	
	// K‰yd‰‰n l‰pi palikan osapalikat
	for ( int yy = 0; yy < 4; yy++ )
	{
		for ( int xx = 0; xx < 4; xx++ )
		{
			// Jos palikan t‰ss‰ kohtaa on osapalikka
			if ( pShape[yy * 4 + xx] != 0 )
			{
				// Lasketaan kyseisen osapalikan paikka pelialueella...
				areaX = x + xx;
				areaY = y + yy;

				// ...palikka tˆrm‰‰ jos kyseinen paikka on pelialueen ulkopuoella 
				if ( areaX < 0 || areaX >= AreaWidth || areaY >= AreaHeight )
					return true;
				// Jos osapalikka on pelialueen sis‰puoella
				if ( areaY >= 0 )
				{
					// Se tˆrm‰‰ jos pelialueen kyseinen paikka ei ole tyhj‰
					if ( mPlayArea[areaY * AreaWidth + areaX] != 0 )
						return true;
				}
			}
		}
	}
	
	// Palikka ei tˆrm‰‰ mihink‰‰n
	return false;
}
//==============================================================================

//==============================================================================
// Liimaa palikan pelialueelle
//------------------------------------------------------------------------------
void 
cTutris::ClueShape (void)
{
	int areaX, areaY;
	
	// K‰yd‰‰n l‰pi palikan osapalikat
	for ( int yy = 0; yy < 4; yy++ )
	{
		for ( int xx = 0; xx < 4; xx++ )
		{
			// Jos palikan t‰ss‰ kohtaa on osapalikka
			if ( mCurrentShape[yy * 4 + xx] != 0 )
			{
				// Survaistaan se pelialueelle
				areaX = mShapeX + xx;
				areaY = mShapeY + yy;
				assert ( areaX >= 0 && areaX < AreaWidth && areaY >= 0 && areaY < AreaHeight );
				
				mPlayArea[areaY * AreaWidth + areaX] = mCurrentShape[yy * 4 + xx];
			}
		}
	}
	
	// Pelialue kaipaa uudelleen piirtoa
	mRedrawPlayArea = true;
	
	// Tarkastetaan t‰ydet rivit
	CheckFullLines ();
	
	// Kopiodaan seuraava palikka nykyiseen palikkaan
	memcpy (mCurrentShape, mNextShape, 16);
	// Arvotaan uusi seuraava palikka
	RandomShape (mNextShape);
	// Uudelleen piirtoa...
	mRedrawNextShape = true;
	// Asetetaan palikka l‰htˆasetelmiin
	mShapeX = (AreaWidth - 4) / 2;
	mShapeY = 0;
	mLastDrop = SDL_GetTicks ();
	
	// Tarkistetaan tˆrm‰‰kˆ palikka johonkin
	if ( Collision (mShapeX, mShapeY, mCurrentShape) == true )
	{
		// Palikka tˆrm‰‰, joten pelialue on t‰ynn‰ ja peli loppuu
		GameOver ();
	}
}
//==============================================================================

//==============================================================================
// Tarkistaa onko pelialueella t‰ysi‰ rivej‰, ja poistaa ne. Jos rivej‰
// lˆytyy annetaan pelaajalle pisteit‰ mystisen kaavan mukaan.
//------------------------------------------------------------------------------
void
cTutris::CheckFullLines (void)
{
	bool full;		// Onko rivi t‰ysi
	int lines = 0;	// T‰ysien rivien m‰‰r‰
	
	// K‰yd‰‰n lapi pelialueen rivit ylh‰‰lt‰ aloittaen
	for ( int y = 0; y < AreaHeight; y++ )
	{
		// Oletetaan, ett‰ rivi on t‰ysi
		full = true;
		
		// K‰yd‰‰n l‰pi rivin palikat
		for ( int x = 0; x < AreaWidth; x++ )
		{
			// Jos reik‰ lˆytyy
			if ( mPlayArea[y * AreaWidth + x] == 0 )
			{
				// Rivi ei ole t‰ysi
				full = false;
				break;
			}
		}
		
		// Rivi oli t‰ysi
		if ( full )
		{
			// Lis‰t‰‰n t‰ysien rivien m‰‰r‰‰
			lines++;
			
			// Pudotetaan ylempi‰ rivej‰ alasp‰in
			for ( int yy = y; yy > 0; yy-- )
			{
				memcpy (&mPlayArea[yy * AreaWidth], &mPlayArea[(yy - 1) * AreaWidth], AreaWidth);
			}
			// Nollataan ylin rivi
			memset (mPlayArea, 0, AreaWidth);
		}
	}
	
	// Jos t‰ysi‰ rivej‰ lˆytyi
	if ( lines != 0 )
	{
		// Pelialuetta muutettiin, joten se kaipaa piristyst‰
		mRedrawPlayArea = true;		
		// Lis‰t‰‰n tuhottujen rivien m‰‰r‰‰
		mLines += lines;
		// Lis‰t‰‰n pisteit‰
		mScore += lines * lines * mLevel * mLevel;
			
		// Tarkistetaan nousimmeko seuraavalle levelille
		if ( mLines > mLevel * 10 )
		{
			mLevel++;
			// Lasketaan uusi putoamis nopeus
			mDropDelay = int ( float (mDropDelay) * 3.0f / 4.0f);
		}
		
		// Pisteet tarvii uudelleen piirtoa
		mRedrawScore = true;
	}
}
//==============================================================================

//==============================================================================
// Piirt‰‰ pistetilanteen ruudulle
//------------------------------------------------------------------------------
void 
cTutris::DrawScore (void)
{
	char buffer[20];
	
	SDL_Rect textRects[3];
	
	// Piirret‰‰n 'Taso'
	textRects[0].x = LevelX;
	textRects[0].y = LevelY;
	textRects[0].w = 50;
	textRects[0].h = 30;
	snprintf (buffer, 20, "%02i", mLevel);
	
	SDL_BlitSurface (mpBackground, &textRects[0], mpScreen, &textRects[0]);
	mFont.PutString (mpScreen, 	textRects[0].x + (textRects[0].w - mFont.TextWidth (buffer)) / 2, 
								textRects[0].y + (textRects[0].h - mFont.FontHeight ()) / 2, buffer, &textRects[0]);
	
	// Piirret‰‰n 'Pisteet'
	textRects[1].x = ScoreX;
	textRects[1].y = ScoreY;
	textRects[1].w = 150;
	textRects[1].h = 30;
	snprintf (buffer, 20, "%06i", mScore);
	
	SDL_BlitSurface (mpBackground, &textRects[1], mpScreen, &textRects[1]);
	mFont.PutString (mpScreen, 	textRects[1].x + (textRects[1].w - mFont.TextWidth (buffer)) / 2, 
								textRects[1].y + (textRects[1].h - mFont.FontHeight ()) / 2, buffer, &textRects[1]);

	// Piirret‰‰n 'Rivit'
	textRects[2].x = LinesX;
	textRects[2].y = LinesY;
	textRects[2].w = 150;
	textRects[2].h = 30;
	snprintf (buffer, 20, "%06i", mLines);

	SDL_BlitSurface (mpBackground, &textRects[2], mpScreen, &textRects[2]);
	mFont.PutString (mpScreen, 	textRects[2].x + (textRects[2].w - mFont.TextWidth (buffer)) / 2, 
								textRects[2].y + (textRects[2].h - mFont.FontHeight ()) / 2, buffer, &textRects[2]);

	// P‰ivitet‰‰n ruutu
	SDL_UpdateRects (mpScreen, 3, textRects);
}
//==============================================================================

//==============================================================================
// Pelin loppukikkailut
//------------------------------------------------------------------------------
void 
cTutris::GameOver (void)
{
	int color = 1;
	SDL_Rect playArea = {AreaX, AreaY, AreaWidth * BlockSize, AreaHeight * BlockSize};
	SDL_Rect nextShape = { NextShapeX, NextShapeY, 4 * BlockSize, 4 * BlockSize };
			
	for ( int y = 0; y < AreaHeight; y++ )
	{
		memset (&mPlayArea[y * AreaWidth], color, AreaWidth);
		memset (&mNextShape, color, 16);

		// Draw play area
		DrawBlocks (AreaX, AreaY, AreaWidth, AreaHeight, mPlayArea);
		SDL_UpdateRects (mpScreen, 1, &playArea);
		
		// Draw next shape
		DrawBlocks (NextShapeX, NextShapeY, 4, 4, mNextShape);
		SDL_UpdateRects (mpScreen, 1, &nextShape);
		
		color++;
		if ( color > NumberOfBlocks )
			color = 1;
		
		SDL_Delay (50);
	}
	
	memset (mCurrentShape, 0, 16);
	mRedrawPlayArea = false;
}
//==============================================================================

//==============================================================================
// Lataa kuvan tiedostosta ja konvertoi sen oikeaan formaattiin
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
SDL_Surface *
cTutris::LoadImage (string filename, bool alpha)
{
	// M‰‰ritell‰‰n tiedoston nimi, jossa on mukana hakemistopolku
	// Esim: background.png -> /usr/local/share/games/Tutris/background.png
	string completeFilename = DATA_DIR;
	completeFilename.append (filename);
	
	// Ensin yritet‰‰n ladata kuva hakemistosta, johon make sen asentaa
	SDL_Surface *pTemp = IMG_Load (completeFilename.c_str ());
	if ( pTemp == NULL )
	{
		// ...ja jos se ei onnitu, yritet‰‰n ladata kuva data-hakemistosta
		string temp = "../data/";
		temp.append (filename);
		pTemp = IMG_Load (temp.c_str ());
		if ( pTemp == NULL )
		{
			// Errormessu ja exit
			cerr << "Unable to load image " << completeFilename << " or " << temp << endl;
			return NULL;
		}
	}	
	SDL_Surface *pImage = NULL;
	
	if ( alpha )
	{
		// Konvertoidaan kuva (alpha versio)
		pImage = SDL_DisplayFormatAlpha (pTemp);
	}
	else
	{
		// Kovertoidaan kuva
		pImage = SDL_DisplayFormat (pTemp);
	}
	
	if ( pImage == NULL )
		cerr << "Unable to convert image to display format: " << SDL_GetError () << endl;
	
	// Palautetaan konvertoimaton kuva
	return pTemp;
}
//==============================================================================

//==============================================================================
// EOF
//==============================================================================
