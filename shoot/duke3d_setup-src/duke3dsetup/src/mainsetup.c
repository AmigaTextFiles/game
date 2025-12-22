#include <intuition/intuition.h>
#include <exec/exec.h>
#include <dos/dos.h>
#include <pragmas/exec_pragmas.h>
#include <pragmas/dos_pragmas.h>
#include <pragmas/gadtools_pragmas.h>

#include "dukesetupgui.h"
#include "mainsetup.h"

extern struct Library *SysBase;
extern struct IntuitionBase *IntuitionBase;
extern struct Library       *GadToolsBase;
extern struct Library       *DOSBase;

void error_exit(STRPTR errormessage);

/*****************************************************************************
    MainSetup
 *****************************************************************************/
ULONG MainSetup( void )
{
    struct IntuiMessage *im;
    struct IntuiMessage imsg;
    struct Gadget *gad;
    UWORD imsgcode;
    ULONG retval=0;

    if(OpenmainWindow())
	error_exit("Couldn't open mainsetup-window!");

    while( !retval )
    {
	while( !( im = (struct IntuiMessage *)GT_GetIMsg( mainWnd->UserPort ) ) )
	    WaitPort( mainWnd->UserPort );

	imsg = *im;
	imsgcode=imsg.Code;
	gad=(struct Gadget *)imsg.IAddress;
	GT_ReplyIMsg( im );

	switch( imsg.Class )
	{
	  case CLOSEWINDOW:
	    retval=setup_cancel;
	  break;

	  case GADGETUP:
	    switch( gad->GadgetID )
	    {
	      case GD_main_soundsetup:
		retval=setup_sound;
	      break;

	      case GD_main_screensetup:
		retval=setup_screen;
	      break;

	      case GD_main_mousesetup:
		retval=setup_mouse;
	      break;

	      case GD_main_kbsetup:
		retval=setup_kb;
	      break;

	      case GD_main_ok:
		retval=setup_ok;
	      break;

	      case GD_main_cancel:
		retval=setup_cancel;
	      break;
	    }
	  break;
	}
    }
    ClosemainWindow();
    return retval;
}

