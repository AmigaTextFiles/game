#define INTUI_V36_NAMES_ONLY

#include <clib/alib_protos.h>
#include <clib/asl_protos.h>
#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/graphics_protos.h>
#include <clib/icon_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <clib/wb_protos.h>
#include <dos.h>
#include <exec/lists.h>
#include <exec/memory.h>
#include <exec/nodes.h>
#include <exec/types.h>
#include <intuition/gadgetclass.h>
#include <stdio.h>
#include <string.h>

#include <dos.h>
#include <exec/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "defines.h"

static char *Version = VERSIONSTRING;
struct PREFS Prefs;


/* Search for a string in an array of strings
 * Return 1 if found, 0 if not
*/
UBYTE FindString(ULONG MaxNum, STRPTR Strings[], STRPTR Search)
{
	UWORD i;
	UBYTE Found = 0;

	for (i=0; i<MaxNum; i++)
	{
		if (strcmp(Strings[i], Search) == 0)
		{
			Found = 1;
			break;
		}
	}

	return (Found);
}

/* Parse arguments and set trainer values
*/
void PrefsConstructor (ULONG argc, char *argv [])
{
	Prefs.NoGUI     = FindString(argc, argv, "NOGUI");
	Prefs.InfLives  = FindString(argc, argv, "INF_LIVES");
	Prefs.InfBigGun = FindString(argc, argv, "INF_BIGGUN");
	Prefs.InfInvis  = FindString(argc, argv, "INF_INVIS");
	Prefs.InfThermo = FindString(argc, argv, "INF_THERMO");
	Prefs.InfBouncy = FindString(argc, argv, "INF_BOUNCY");
	Prefs.MaxBoosts = FindString(argc, argv, "MAXBOOSTS");
}

/*	This function calls all other constructors.
*/

BOOL GlobalConstructor (int argc, char *argv [])
{
	/* Parse arguments if any
	*/
	PrefsConstructor((ULONG)argc, argv);

	if (!Prefs.NoGUI)
	{
		/* Setup window layout stuff
		*/
		if (!WindowConstructor ())
		{
			PutStr ("ERROR: WindowConstructor() failed\n");
			return FALSE;
		}

		/* Layout the window
		*/
		if (!CreateControlPanel ())
		{
			PutStr ("ERROR: CreateControlPanel() failed\n");
			return FALSE;
		}

		/* Open the window
		*/
		if (!OpenControlPanel ())
		{
			PutStr ("ERROR: OpenControlPanel() failed\n");
			return FALSE;
		}

		/* Set gadgets
		*/
		SetCheckbox (GAD_LIVES,    Prefs.InfLives);
		SetCheckbox (GAD_GUN,      Prefs.InfBigGun);
		SetCheckbox (GAD_INVIS,    Prefs.InfInvis);
		SetCheckbox (GAD_THERMO,   Prefs.InfThermo);
		SetCheckbox (GAD_BOUNCY,   Prefs.InfBouncy);
		SetCheckbox (GAD_GUNBOOST, Prefs.MaxBoosts);
	}

	return TRUE;
}

/*	This function closes all things that were opened, and destructs all
	things that were constructed.
*/

void GlobalDestructor (void)
{
	if (!Prefs.NoGUI)
	{
		WindowDestructor ();
	}
}

/* Window processing loop
*/

BOOL HandleWindowEvents(void)
{
	struct IntuiMessage *IMsg;
	ULONG class;
	UWORD code;
	struct Gadget *Gad;
	struct Window *Win = Panel.Win;
	BOOL Done = FALSE;
	BOOL Play = FALSE;

	while (!Done)
	{
		Wait (1 << Win->UserPort->mp_SigBit);

		while (!Done &&	(IMsg = GT_GetIMsg(Win->UserPort)))
		{
			Gad   = (struct Gadget *)IMsg->IAddress;
			class = IMsg->Class;
			code  = IMsg->Code;

			GT_ReplyIMsg(IMsg);

			switch (class)
			{
				case IDCMP_GADGETDOWN:
				case IDCMP_GADGETUP:
					switch (Gad->GadgetID)
					{
						case GAD_LIVES:
							Prefs.InfLives = !Prefs.InfLives;
							SetCheckbox(GAD_LIVES, Prefs.InfLives);
							break;
						case GAD_GUN:
							Prefs.InfBigGun = !Prefs.InfBigGun;
							SetCheckbox(GAD_GUN, Prefs.InfBigGun);
							break;
						case GAD_INVIS:
							Prefs.InfInvis = !Prefs.InfInvis;
							SetCheckbox(GAD_INVIS, Prefs.InfInvis);
							break;
						case GAD_THERMO:
							Prefs.InfThermo = !Prefs.InfThermo;
							SetCheckbox(GAD_THERMO, Prefs.InfThermo);
							break;
						case GAD_BOUNCY:
							Prefs.InfBouncy = !Prefs.InfBouncy;
							SetCheckbox(GAD_BOUNCY, Prefs.InfBouncy);
							break;
						case GAD_GUNBOOST:
							Prefs.MaxBoosts = !Prefs.MaxBoosts;
							SetCheckbox(GAD_GUNBOOST, Prefs.MaxBoosts);
							break;
						case GAD_PLAY:
						case GAD_CANCEL:
							Done = TRUE;
							Play = ((Gad->GadgetID == GAD_PLAY) ? TRUE : FALSE);
							break;
					}
					break;

				case IDCMP_VANILLAKEY:
					switch (code)
					{
						case 'p':
						case 'P':
							Play = TRUE;
							Done = TRUE;
							break;
						case 'c':
						case 'C':
							Play = FALSE;
							Done = TRUE;
							break;
					}
					break;

				case IDCMP_CLOSEWINDOW:
					Play = FALSE;
					Done = TRUE;
					break;

				case IDCMP_REFRESHWINDOW:
					GT_BeginRefresh(Win);
					GT_EndRefresh(Win, TRUE);
					break;
			}
		}
	}

	return(Play);
}


/*	The main routine for GloomTrainer
*/

int main (int argc, char *argv [])
{
	BOOL Play;
	char BootString[100];

	if (argc == 0) {
		argc = _WBArgc;
		argv = _WBArgv;
	}

	/* Set up everything
	*/
	if (!GlobalConstructor (argc, argv))
	{
		GlobalDestructor ();
		exit (RETURN_WARN);
	}

	/* The main loop
	*/
	if (!Prefs.NoGUI)
	{
		Play = HandleWindowEvents();
	}
	else
	{
		Play = TRUE;
	}

	/* Clean up before leaving
	*/
	GlobalDestructor();

	/* If user selected to play, then run boot program
	*/
	if (Play)
	{	sprintf(BootString, "CGTBoot %d %d %d %d %d %d ",
					Prefs.InfLives, Prefs.InfBigGun, Prefs.InfInvis,
					Prefs.InfThermo, Prefs.InfBouncy, Prefs.MaxBoosts); 
		Execute(BootString, 0L, 0L);
	}

	exit (RETURN_OK);
}
