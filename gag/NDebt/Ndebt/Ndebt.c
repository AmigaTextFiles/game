/*
Ndebt - display the national debt (approximately) in a small window.

                                Ron Charlton
                             9002 Balcor Circle
                             Knoxville, TN 37923

                             Phone: (615)694-0800

                              PLINK: R*CHARLTON
                           BINTNET: charltr@utkvx1

                                 05-Jul-90

This program is in the public domain.  It may be used for any purpose.
 
Will Run from Workbench and CLI.

History:
v1.0   creation
v1.1   convert to Manx Aztec C 5.0a
*/

char id [] = " Ndebt  by  Ron Charlton  V1.1  05-Jul-90 (public domain)";

#define INC 7673.015		/* delta debt per second */
#include <stdio.h>
#include <exec/types.h>
#include <intuition/intuition.h>
#include <time.h>

struct IntuitionBase *IntuitionBase;

struct Window *Wdw;

struct IntuiMessage *msg;

struct GfxBase *GfxBase;

#define Rp Wdw->RPort

struct NewWindow NewWdw = 
   {
   180, 15,		    /* left, top			  */
   250 ,21,		    /* width, height			  */
   0, 1,		    /* DetailPen, BlockPen		  */
   CLOSEWINDOW, 	    /* IDCMP flags			  */
   WINDOWCLOSE | WINDOWDEPTH | WINDOWDRAG | ACTIVATE,  /* window flags */ 
   NULL,		    /* pointer to 1st gadget		  */
   NULL,		    /* pointer to checkmark image	  */
   (void*)" USA National Debt",    /* title				  */
   NULL,		    /* pointer to screen structure, dummy */
   NULL,		    /* pointer to custom bit map	  */
   0,0,			    /* minimum width, height		  */
   0,0,			    /* maximum width, height		  */
   WBENCHSCREEN		    /* type of screen			  */
   };

char buf [ 80 ] = "";

/* these are required by detach() */
long _stack = 2000, _priority = 0, _BackGroundIO = 1;
char *_procname = "NdebtProcess";
/* end detach() stuff */

void _cli_parse(){} /* don't need it */
void _wb_parse(){}  /* don't need it, either */

/* ========================< main >============================== */

main() 
  {
  time_t time();
  double debt;
  time_t now;

  /* =-=-= open everything =-=-= */
  IntuitionBase = (struct IntuitionBase *)
       				OpenLibrary("intuition.library",0);
  if (IntuitionBase == NULL)
       quit ();

  GfxBase = (struct GfxBase *)
	OpenLibrary("graphics.library",0);
  if (GfxBase == NULL)
    quit();
 
  if (( Wdw = (struct Window *)OpenWindow(&NewWdw)) == NULL )
       quit ();

  SetWindowTitles ( Wdw, -1, id );
  SetAPen ( Rp, 1 );
  SetBPen ( Rp, 0 );

  time ( &now );
  if ( now < 300000000L ) /* before about 12/88 */
    {
    Move ( Rp, 37, 17 );
    Text ( Rp, "Set DATE/TIME first.", 20 );
    for (;;)
      {
      msg = (struct IntuiMessage *) GetMsg ( Wdw -> UserPort );
      if ( msg != NULL ) /* we got the big CLOSEWINDOW */
	{
        ReplyMsg ( msg );
	quit ();
	}
      }
    }

  buf [ 0 ] = '$';
  for (;;)	/* main loop */
    {
    msg = (struct IntuiMessage *) GetMsg ( Wdw -> UserPort );
    if ( msg != NULL ) /* we got the big CLOSEWINDOW */
	{
        ReplyMsg ( msg );
	break;
	}
    time ( &now );
    /* 
     * As of 12/31/88: debt = $2,707,284,000,000 & rate = $7673.015/sec.
     * Source - Survey of Current Business, c. January 1989.
     *
     * The following assumes 'now' is in seconds since 01-Jan-1970 (v5.0a).
     */
    debt = now * INC - 1.893579e12;
    sprintf ( buf+1, "%.0f", debt );
    addcommas ( buf );
    Move ( Rp, 37, 17 );
    Text ( Rp, buf, strlen ( buf ) );
    Delay ( 50L );
    }
    quit ();
}

/* 
 * add commas to an ASCII number in string s
 */
addcommas ( s )
  char *s;
  {
  char work [ 80 ], *w;
  int len = strlen ( s ), i;
  w = work;
  for ( i = 0; i < len; i++ )
    {
    if ( !(i % 3) && i )
      *w = ',', ++w;
    *w = s [ len - i - 1 ];
    ++w;
    }
  *w = '\0';
  /* reverse the string */
  for ( i = strlen ( work ); i > 0; i-- )
    *s++ = work [ i - 1 ];
  *s = '\0';
  }
 
quit()
  {
  if ( Wdw )           CloseWindow  ( Wdw );
  if ( GfxBase )       CloseLibrary ( GfxBase );
  if ( IntuitionBase ) CloseLibrary ( IntuitionBase );
  exit(0);
  }


