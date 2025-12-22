#include <exec/exec.h>
#include <proto/exec.h>

#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <proto/intuition.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include <stdio.h>
#include <dos.h>
#include <string.h>

#include "fil.h"

UBYTE *version = "$VER: FiveInLine 2.2 21.04.94\n";

struct ReqToolsBase	*ReqToolsBase = NULL;
APTR				VisualInfo = NULL;
struct Screen		*Scr = NULL;
struct Window		*mwWnd = NULL;
struct Menu			*mwMenus = NULL;
BOOL				startplayer = NULL;
UBYTE				currentplayer = NULL;
UWORD				offx = 0;
UWORD				offy = 0;
int					boardsize = 15;

int main ( int argc, char *argv[] )
{
	BOOL	terminated = FALSE;
	BOOL	running;
	FLOAT	playlevel = LEVEL5;
	int		amiga_old_row;
	int		amiga_old_col = 0;
	int		i;
	char	*p;
	char	beginyesno [ 3 ];
	int		level;

	if ( argc == 0 ) {
		argc = _WBArgc;
		argv = _WBArgv;
	}
	
	for ( i = 1; i < argc; i ++ ) {
		if ( strnicmp ( argv [ i ], "BoardSize", 9) == 0) {
			p = strchr ( argv [ i ], '=' );
			p ++;
			sscanf ( p, "%d", &boardsize );
			if ( boardsize < 11 ) boardsize = 11;
			else if ( boardsize > 31 ) boardsize = 31;
		}
		else if ( strnicmp ( argv [ i ], "UserBegins", 9) == 0) {
			p = strchr ( argv [ i ], '=' );
			p ++;
			sscanf ( p, "%2s", &beginyesno );
			if ( strnicmp ( beginyesno, "No", 2) == 0) {
				startplayer = FALSE;
				currentplayer = AMIGA;
			}
			else {
				startplayer = TRUE;
				currentplayer = HUMAN;
			}
		}
		else if ( strnicmp ( argv [ i ], "PlayLevel", 9) == 0) {
			p = strchr ( argv [ i ], '=' );
			p ++;
			sscanf ( p, "%d", &level );
			switch ( level ) {
				case ( 1 ): 
					playlevel = LEVEL1;
					break;
				case ( 2 ): 
					playlevel = LEVEL2;
					break;
				case ( 3 ): 
					playlevel = LEVEL3;
					break;
				case ( 4 ): 
					playlevel = LEVEL4;
					break;
				case ( 5 ): 
					playlevel = LEVEL5;
					break;
			}
		}
	}

	openreqtools ();
	if ( ReqToolsBase != NULL ) {
		if ( setupscreen () != NULL ) {
			printf ( "Unable to access workbench screen.\n" );
			return ( 10 );
		}
		else {	
			if ( currentplayer == NULL ) startplayer = reqbegin ();

			if ( setupwindow () != NULL ) {
				printf ( "Unable to open window.\n" );
				return ( 10 );
			}
			else {
			
				while ( ! terminated ) {
					running = initnewgame ();
					amiga_old_row = -1;

					while ( running ) {
						if ( currentplayer == HUMAN ) {
							running = checkdrawgame ();
							if ( running ) 
								running = handleidcmp ( &amiga_old_row, amiga_old_col, &terminated, &playlevel );
						}
						else {
							running = checkdrawgame ();
							if ( running )
								running = amigamove ( &amiga_old_row, &amiga_old_col, playlevel );
						}
					}
					currentplayer = NULL;
				}
			}			
			closedownscreen ();
		}
	}
	closereqtools ();
}
