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
// Tiedosto: Main.cpp
// Tekij‰: Jarmo Hekkanen <jarski@2ndpoint.fi>
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Sis‰llytett‰v‰t otsikkotiedostot
#include <iostream>
#include <stdexcept>
#include <stdlib.h>
#include <SDL.h>
#include "cTutris.hpp"

#ifdef HAVE_CONFIG_H
	#include "config.h"
#endif
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
using namespace std;
//==============================================================================

//==============================================================================
// Main funktio
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
// Parametrit:
//		argc komentoriviparametrien m‰‰r‰
//		argv komentorivitparametrit
//
// Palauttaa:
//		EXIT_SUCCESS: Normaali ohjelmasta poistuminen
//		EXIT_FAILURE: Ohjelmasta poistuttiin virheen seurauksena
//
//		EXIT_SUCCESS- ja EXIT_FAILURE-makrot on m‰‰ritelty stdlib.h:ssa
//≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-≠-
int main (int argc, char *argv[])
{
	// Koodi on kirjoitettu try-lohkon sis‰‰n, jotta mahdolliset poikkeukset 
	// saataisiin pyydystetty‰. 
	try
	{
		// T‰t‰ muuttujaa k‰ytet‰‰n kun p‰‰tet‰‰n mit‰ lippuja SDL_SetVideoMode:lle annetaan
		// Alustamme muuttujan arvolla false, joten ohjelma k‰ynnistet‰‰n oletuksena ikkunaan eik‰
		// kokoruututilaan. T‰m‰n muuttujan arvoa voidaan vaihtaa antamalla ohjelmalle --fullscreen 
		// parametri
		bool fullscreen = false;
		
		// Tarkistetaan mahdolliset komentoriviparametrit
		if ( argc > 1 )
		{
			// K‰yd‰‰n parametrit l‰pi indeksin arvosta yksi l‰htien. T‰m‰ siksi, 
			// ett‰ ensimm‰inen parametri (eli siis argv[0]) on ohjelman
			// k‰ynnist‰miseen k‰ytetty komento (esim src/tutris)
			for ( int i = 1; i < argc; i++ )
			{
				// Tarkistus "--help"-parametrille
				if ( strcmp (argv[i], "--help") == 0 )
				{
					// Tulostetaan opastus ohjelman komentoriviparametreist‰...
					cout << "Usage: tutris [OPTION]\n\n";
					cout << "  --help                     Display this help and exit.\n";
					cout << "  --version                  Output version information and exit.\n";
					cout << "\nVideo options\n\n";
					cout << " --fullscreen                Run the game in fullscreen mode.\n";
					cout << "\nControls\n\n";
					cout << "ESC                          Quit game\n";
					cout << "F1                           New game\n";
					cout << "F2                           Pause\n";
					cout << "F10                          Screenshot\n";
					cout << "F11                          Toggle fullscreen mode\n";
					cout << "Left/Right arrow             Move shape left/right\n";
					cout << "Down arrow                   Move shape down\n";
					cout << "Up arrow                     Rotate shape\n";
					cout << "Space                        Drop shape\n";
					cout << endl;
					// ...ja poistutaan ohjelmasta
					return EXIT_SUCCESS;
				}
				
				// Tarkistus "--version"-parametrille
				if ( strcmp (argv[i], "--version") == 0 )
				{
					// Tulostetaan ohjelman versio...
					cout << "tutris version " << VERSION << endl;
					// ...ja poistutaan ohjelmasta
					return EXIT_SUCCESS;
				}
				
				// Tarkistus "--fullscreen"-parametrille
				if ( strcmp (argv[i], "--fullscreen") == 0 )
				{
					// Aktivoidaan kokoruututila
					fullscreen = true;
				}
			}
		}
				
		// Alustetaan SDL. T‰m‰ on teht‰v‰ ennen kuin mit‰‰n muita SDL-kirjaston funktioita
		// kutsutaan...
		if ( SDL_Init (SDL_INIT_VIDEO) !=  0 )
		{
			// Alustus ep‰onnistui. Tulostetaan virheilmoitus...
			cerr << "Initialization of the SDL failed: " << SDL_GetError () << endl;
			// ..ja poistutaan ohjelmasta
			return EXIT_FAILURE;
		}
		// Varmistetaan, ett‰ SDL_Quit-funktiota kutsutaan kun ohjelmasta poistutaan
		atexit (SDL_Quit);
		
		// M‰‰ritell‰‰n SDL_SetVideoMode:lla annettavat liput
		Uint32 videoFlags = 0;
		if ( fullscreen == true )
			videoFlags |= SDL_FULLSCREEN;
		
		// Asetetaan ikkunan otsikko
		SDL_WM_SetCaption ("Tutris", NULL);
				
		// Yritet‰‰n avata haluttu videotila
		SDL_Surface *pScreen = SDL_SetVideoMode (640, 480, 16, videoFlags);
		if ( pScreen == NULL )
		{
			// Avaus ap‰onnistui. Tulostetaan virheilmoitus...
			cerr << "Unable to set video mode: " << SDL_GetError () << endl;
			// ...ja poistutaan ohjelmasta
			return EXIT_FAILURE;
		}
		
		// Karsitaan turhia tapahtumia
		SDL_EventState (SDL_MOUSEMOTION, SDL_IGNORE);
		SDL_EventState (SDL_MOUSEBUTTONDOWN, SDL_IGNORE);
		SDL_EventState (SDL_MOUSEBUTTONUP, SDL_IGNORE);
		SDL_EventState (SDL_ACTIVEEVENT, SDL_IGNORE);
		
		cTutris game;
		// Alustetaan peli
		if ( game.Initialize () != 0 )
		{
			// Alustus ep‰onnistui. Tulostetaan virheilmoitus...
			cerr << "Initialization of the game failed." << endl;
			// ...ja poistutaan ohjelmasta
			return EXIT_FAILURE;
		}
		
		// Hyp‰t‰‰n pelin p‰‰silmukkaan ja poistutaan ohjelmasta sitten kun se loppuu...
		return game.MainLoop ();
	}
	catch ( exception x )	// K‰sitell‰‰n STL:n poikkeukset
	{
		cerr << "Exception caught: " << x.what () << endl;
	}
	catch ( ... )			// Yleinen poikkeusk‰sittelij‰
	{
		cerr << "Unknown exception caught." << endl;
	}
	
	// Poistutaan ohjelmasta
	return EXIT_FAILURE;
}
//==============================================================================

//==============================================================================
// EOF
//==============================================================================
