/**************************************************************************
 *                                                                        *
 * ????? Module --- A module for Imp Professional                         *
 *                                                                        *
 **************************************************************************/
 
#include "Module.h"

struct EasyStruct errEasyStruct =               // The error requester
{
   sizeof(struct EasyStruct), 0, "Module ERROR",
   NULL, "Give up!"
};

char PubName[] = IMP_SCREEN_NAME;
struct Library *ImpBase = NULL;

VOID Open_All()
{
   IntuitionBase = (struct IntuitionBase *)OpenLibrary( "intuition.library", 37L );
   if(!IntuitionBase)
      Close_All("Could not open Intuition v37+");
   
   GadToolsBase = OpenLibrary( "gadtools.library", 37L );
   if(!GadToolsBase)
      Close_All("Could not open GadTools library v37+");

   if (!(AslBase = OpenLibrary("asl.library", 37L)))
	Close_All("Could not open ASL library v37+");

   ImpBase = OpenLibrary( "imppro.library", 1L );
   if (!ImpBase)
      Close_All("Could not open ImpPro library v1+");
   
   PubScreenName = PubName;

   if (SetupScreen())         // SetupScreen returns a NULL if successful
						// SetupScreen should attempt to lock "IMP.SCREEN"
   {
      PubScreenName = NULL;   // Can't find IMP.SCREEN, so try Default public screen
      if (SetupScreen())
         Close_All("Could not lock IMP.SCREEN or Default public screen");
   }
}
 
VOID Close_All(char *errmsg)
{
   struct EasyStruct errEZ;
   
   if (errmsg)
   {
      errEZ = errEasyStruct;           // Display error message passed in
      errEZ.es_TextFormat = errmsg;
      EasyRequest(NULL, &errEZ, NULL);
   }

   CloseWindow();             // CloseWindow should close your window
   CloseDownScreen();         // CloseDownScreen should unlock the public screen
   if (IntuitionBase)   CloseLibrary   ((struct Library *)
                                        IntuitionBase );
   if (GadToolsBase )   CloseLibrary   ( GadToolsBase  );
   if (AslBase      )   CloseLibrary   ( AslBase       );
   if (ImpBase      )   CloseLibrary   ( ImpBase       );
   exit(0L);
}

 VOID main(VOID)
  {
   Open_All();                       //  Setup everything
   OpenWindow();    // Openwindow should open the window and set up the gadgets

   FOREVER
   {
        Wait(1L << Wnd->UserPort->mp_SigBit);      // Wait for message from Intuition
										 //  fill in Wnd with your window
        HandleHorseIDCMP();                        // Handle IDCMP for Window
   }
  }


// This is just a shell of a program, but you should get the gist of it.  Here's the routine
// for locking and unlocking a public screen:

int SetupScreen( void )
{
	if ( ! ( Scr = LockPubScreen( PubScreenName )))
		return( 1L );

	if ( ! ( VisualInfo = GetVisualInfo( Scr, TAG_DONE )))
		return( 2L );

	return( 0L );
}

void CloseDownScreen( void )
{
	if ( VisualInfo ) {
		FreeVisualInfo( VisualInfo );
		VisualInfo = NULL;
	}

	if ( Scr        ) {
		UnlockPubScreen( NULL, Scr );
		Scr = NULL;
	}
}
