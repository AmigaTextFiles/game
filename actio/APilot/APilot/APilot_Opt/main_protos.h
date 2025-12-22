/***************************************************************************
 *
 * main_protos.h -- Needed protos for functions in main.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 * 
 */

#include "common.h"

void init_world( void );
void init_display( int native );
void init_font( void );
void init_kbdrepeat( void );
void do_fade( void );
BOOL handleIDCMP( AShip *aShip );
void cleanExit( LONG returnValue, char *fmt, ... );
extern void cmdline(int argc, char **argv);
