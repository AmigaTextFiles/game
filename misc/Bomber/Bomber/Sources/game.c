/*
 *     game.c
 *
 */

#include "Bomber.h"
#include <time.h>
#include <exec/memory.h>
#include "sound.h"


#ifdef DEBUG
# define D(debug) debug
#else
# define D(debug)
#endif


/* Bombenzahl = Größe * Level * BOMB_FACTOR */
#define BOMB_FACTOR 0.07

/* GesamtZeit = TIME_FACTOR * Bombenzahl */
#define TIME_FACTOR (8 - 2*spiel_level)


/*------------------------- Externe Daten...*/


extern int	time_counter, flag_counter;


/*------------------------- Daten dieses Moduls...*/


int			size_x, size_y, spiel_level=0, practice_mode=0,
			rest_felder=0, gesamtzeit=0;

UBYTE		*spielfeld = NULL;

/*
 * Codierung eines Feldes (bitweise geodert):
 *    128 = verdeckt
 *     64 = Flagge
 *     32 = Bombe
 *     16 = Markierung für 'Fläche freilegen'
 *  0..15 = Anzahl benachbarter Bomben
 *
 */


/*------------------------- Code-Deklarationen...*/


extern void stop_timer( void );

extern void window_sizing( BOOL );
extern void draw_field( int x, int y, UBYTE inhalt );
extern void clear_spielfeld( void );
extern void count_down( void );
extern void change_flagcounter( int wert );

extern void sound_play( int );

extern void highscore_eintrag( int x, int y, int zeit, int level );


/*------------------------- Code-Definitionen...*/


void init_game( void )
{
	// Bis jetzt nix zu initialisieren...
	// bleibt wahrscheinlich auch so...
}


void free_spielfeld( void )
{
	if( spielfeld )
	{
		FreeMem( spielfeld, size_x*size_y );
		spielfeld = NULL;
	}
}


void close_game( void )
{
	free_spielfeld();
}


void spielende( void )
{
	int		x, y;
	UBYTE	*inhalt = spielfeld;
	
	// CountDown stoppen
	stop_timer();
	
	// Alle noch bedeckten Felder anzeigen
	for( y=0; y<size_y; y++ )
	{
		for( x=0; x<size_x; x++ )
		{
			if( *inhalt & (128+64) )
			{
				*inhalt &= ~(128+64);
				draw_field( x, y, *inhalt );
			}
			
			++inhalt;
		}
	}
}


void check_rest_felder( void )
{
	/* Wird bei Änderungen von 'rest_felder' aufgerufen, um
	 * zu prüfen, ob der User gewonnen hat
	 */
	D(printf("rest = %d\n", rest_felder));
	
	if( rest_felder <= 0 )
	{
		int restzeit = time_counter;
		
		// Countdown stoppen
		stop_timer();
		
		// Noch in der Zeit?
		if( restzeit )
		{
			sound_play( SOUND_SIEG );
			
			if( !practice_mode )
			{
				highscore_eintrag( size_x, size_y, restzeit, spiel_level );
			}
		}
		
		window_sizing( TRUE );
	}
}


void mark( volatile UBYTE x, volatile UBYTE y )
{
	UBYTE *s = spielfeld + x + y*size_x;
	
	#define MARK( X, Y, S ) \
	{	if( (*(S) & 128+16) == 128 ) \
			mark( X, Y ); \
	}
	
	// Umgebung von (x,y) wird nur bei 0-Feldern weiter verfolgt:
	
	if( (*s |= 16) & 15 ) return;
	
	if( x )
	{
		MARK( x-1, y, s-1 );				// links
		
		if( y )
			MARK( x-1, y-1, s-1-size_x );	// links oben
		
		if( y<(size_y-1) )
			MARK( x-1, y+1, s-1+size_x );	// links unten
	}
		
	if( x<(size_x-1) )
	{
		MARK( x+1, y, s+1 );				// rechts
		
		if( y )
			MARK( x+1, y-1, s+1-size_x );	// rechts oben
		
		if( y<(size_y-1) )
			MARK( x+1, y+1, s+1+size_x );	// rechts unten
	}
	
	if( y )
		MARK( x, y-1, s-size_x );			// oben
	
	if( y<(size_y-1) )
		MARK( x, y+1, s+size_x );			// unten
}


void uncover_flaeche( int x, int y )
{
	int i, j;
	UBYTE *s;
	
	// Pass 1: Rekursiv alle angrenzenden Punkte markieren
	mark( x, y );
	
	// Pass 2: Markierte Felder Uncovern, Marks löschen
	s = spielfeld;
	for( i=0; i<size_y; i++ )
	{
		for( j=0; j<size_x; j++ )
		{
			/* Flächenmarkierung? */
			
			if( *s & 16 )
			{
				*s &= ~16;
				
				/* Keine Flagge? */
				
				if( !(*s & 64) )
				{
					*s &= ~128;
					--rest_felder;
					draw_field( j, i, *s );
				}
			}
			
			++s;
		}
	}
	
	check_rest_felder();
}


void neues_spiel( void )
{
	double ran( void );
	void sran( double );
	
	int i, j;
	UBYTE *s;
	
	#define RANDOM fabs(ran())
	#define INC(p) if(!(*(p) & 32)) ++(*(p))
	
	stop_timer();
	window_sizing( FALSE );
	clear_spielfeld();
	
	/* Anmerkung zum Speicher:
	 *  spielfeld wird nur hier allokiert.
	 *  freigegeben wird der Speicher bei Fenstergrössen-
	 *  änderung oder wenn NEW angeklickt wird (hier also).
	 *  Wenn NEW der Grund ist, müssen folglich die sizes noch
	 *  stimmen.
	 */
	
	free_spielfeld();
	spielfeld = AllocMem( j = size_x*size_y, MEMF_CLEAR );
	
	if( !spielfeld )
	{
		window_sizing( TRUE );
		return;
	}
	
	rest_felder = j;
	sound_play( SOUND_ANFANG );
	sran( (double) clock() );
	
	// Bomben plazieren, links oben 3*2-Feld freilassen
	
	flag_counter = j * (1 + spiel_level) * BOMB_FACTOR;
	
	i = flag_counter;
	while( i )
	{
		// Position bestimmen
		
		int x = RANDOM * size_x,
			y = RANDOM * size_y;
			
		s = spielfeld + x + y*size_x;
		
		if( (!(*s & 32)) && (x>3 || y>2) )
		{
			// Bombe setzen
			
			*s = 32;
			--i;
			
			// Umgebungsfelderinhalte erhöhen
			
			if( x )
			{
				INC( s-1 );				// links
				
				if( y )
					INC( s-1-size_x );	// links oben
				
				if( y<(size_y-1) )
					INC( s-1+size_x );	// links unten
			}
				
			if( x<(size_x-1) )
			{
				INC( s+1 );				// rechts
				
				if( y )
					INC( s+1-size_x );	// rechts oben
				
				if( y<(size_y-1) )
					INC( s+1+size_x );	// rechts unten
			}
			
			if( y )
				INC( s-size_x );		// oben
			
			if( y<(size_y-1) )
				INC( s+size_x );		// unten
		}
	}
	
	// Felder bedecken
	
	s = spielfeld;
	i = j;
	while( i-- )
	{
		*s++ |= 128;
	}
	
	// Anfangsfläche freilegen: (0,0) sicher frei (s.o.)
	
	uncover_flaeche( 0, 0 );
	
	// Rest des Spielfelds aufbauen
	
	s = spielfeld;
	for( i=0; i<size_y; i++ )
	{
		for( j=0; j<size_x; j++ )
		{
			if( *s & 128 )
			{
				draw_field( j, i, *s );
			}
			
			++s;
		}
	}
	
	// Zeitlimit und Flagcounter setzen
	
	change_flagcounter( 0 );
	
	time_counter = TIME_FACTOR * flag_counter + 1;
	gesamtzeit = time_counter;
	count_down();
}


void uncover_field( int x, int y )
{
	UBYTE *inhalt = spielfeld + y*size_x + x;
	
	if( !spielfeld ) return;
	
	if( *inhalt & 64 )
	{
		// Flagge entfernen
	
		*inhalt &= ~64;
		draw_field( x, y, *inhalt );
		
		change_flagcounter( +1 );
		
		sound_play( SOUND_CLICK );
		
		++rest_felder;
	}
	
	else if( *inhalt & 128 )
	{
		// Aufdecken
		
		*inhalt &= ~128;
		
		if( *inhalt & 32 )
		{
			/* GAME OVER weil auf Bombe gelatscht */
			sound_play( SOUND_EXPLOSION );
		
			*inhalt |= 128;		// Auch diese Bombe zeigen
			spielende();
			
			window_sizing( TRUE );
		}
		
		else
		{
			sound_play( SOUND_CLICK );
			
			if( *inhalt & 31 )
			{
				draw_field( x, y, *inhalt );
				--rest_felder;
				check_rest_felder();
			}
			else
			{
				uncover_flaeche( x, y );
			}
		}
	}
}


void set_flag( int x, int y )
{
	UBYTE *inhalt = spielfeld + y*size_x + x;
	
	if( !spielfeld || flag_counter==0 ) return;
	
	sound_play( SOUND_CLICK );
	
	if( !(*inhalt & 64) )
	{
		/* Flagge setzen */
		*inhalt |= 64;
		draw_field( x, y, *inhalt );
		
		change_flagcounter( -1 );
		
		--rest_felder;
		check_rest_felder();
	}
	else
	{
		/* Feld freilegen, Zeitstrafe */
		
		if( !(*inhalt & 32) )
		{
			/* Keine Bombe drunter -> Feld freilegen */
			
			*inhalt &= 15;
			
			draw_field( x, y, *inhalt );
			
			change_flagcounter( +1 );
		}
		
		/* Zeitstrafe: 5% von gesamtzeit */
		
		time_counter -= 0.05 * gesamtzeit;
		
		if( time_counter < 1 )
			time_counter = 1;
	}
}
