/**************************************************************************
 *                                                                        *
 * Dice Module --- A dice-rolling module for Imp Professional             *
 *                                                                        *
 **************************************************************************/

#include <datatypes/arexxclass.h>
#include <libraries/bgui.h>
#include <libraries/bgui_macros.h>
#include <libraries/gadtools.h>

#include <clib/alib_protos.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/bgui.h>
#include <proto/intuition.h>

#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "Module.h"

// ID's for BGUI gadgets

#define ID_txtCOMBO	100L
#define ID_cmdROLL	101L
#define ID_cmdCLEAR	102L
#define ID_lstDice	103L
#define ID_cmdAdd	104L
#define ID_cmdDel	105L

// Menu strip

#define ID_LOAD		1001L
#define ID_SAVE		1002L
#define ID_ABOUT		1003L
#define ID_QUIT		1004L
#define ID_SNAPSHOT		1005L
#define ID_AREXX		1006L

struct NewMenu MainMenus[] = {
	Title( "Project" ),
		Item( "Load die strip...", "L", ID_LOAD ),
		Item( "Save die strip...", "S", ID_SAVE ),
		ItemBar,
		Item( "AREXX launch...", "A", ID_AREXX ),
		ItemBar,
	     Item( "About...", "?", ID_ABOUT ),
		Item( "Quit",     "Q", ID_QUIT  ),
	Title( "Settings" ),
		Item( "Snapshot window", "N", ID_SNAPSHOT ),
	End
};

// Globals

struct Library			*BGUIBase = NULL;
struct Library			*ImpBase = NULL;
struct ImpSnapshot		 ssMain;
ULONG				 Total = 0, Result = 0;
struct Window			*window;
Class				*ARexxClass;
Object				*WO_Window, *GO_lstDice, *GO_Combo, *GO_Result, *GO_Total, *AO_Rexx,
					*GO_Roll, *GO_Clear, *GO_Add, *GO_Del;
BOOL					 running = TRUE, Blind = FALSE;
UBYTE				 rxbuf[256];

struct EasyStruct errEasyStruct =               // The error requester
{
   sizeof(struct EasyStruct), 0, "Dice Module ERROR",
   NULL, "Give up!"
};

REXXCOMMAND Commands[] = {
	"RAND",		"/N",					rx_Rand,
	"ROLL",		"/A",					rx_Roll,
	"CLEAR",		NULL,					rx_Clear,
	"GET",		"COMBO/S, TOTAL/S",			rx_Get,
	"BLIND",		"ON/S, OFF/S",				rx_Blind,
	"QUIT",		NULL,					rx_Quit,
};

// Aux functions

UBYTE	*AboutText	=	ISEQ_C "Dice module for Imp Professional\n\n"
						"Version " MOD_VERSION ", compiled " __DATE__;

void Sprintf(char *buffer, const char *ctl, ...)
{
   va_list args;

   va_start(args, ctl);
   RawDoFmt(ctl, args, (void (*))"\x16\xc0\x4e\x75", buffer);
   va_end(args);
}

/*
**      Put up a simple requester.
**/
ULONG Req( struct Window *win, UBYTE *gadgets, UBYTE *body, ... )
{
        struct bguiRequest      req = { NULL };

        req.br_GadgetFormat     = gadgets;
        req.br_TextFormat       = body;
        req.br_Flags            = BREQF_CENTERWINDOW|BREQF_XEN_BUTTONS;

        return( BGUI_RequestA( win, &req, ( ULONG * )( &body + 1 )));
}

void Toggle_gadgets(BOOL value)
{
	SetGadgetAttrs((struct Gadget *)GO_Del, window, NULL, GA_Disabled, value, TAG_END);
}

int LoadRequest(char *ret)
{
	Object	*filereq;
     ULONG	pa, rc;

	filereq = FileReqObject, ASLFR_DoPatterns, TRUE,
						ASLFR_TitleText, (ULONG) "Select die strip to load",
						ASLFR_InitialDrawer, (LONG) SAVE_DIRECTORY,
						ASLFR_InitialPattern, "#?.strip",
						ASLFR_Window, window,
						EndObject;
	if ( filereq ) {
		if ( ! ( rc = DoRequest( filereq )))
		{
                              GetAttr( FRQ_Path, filereq, &pa);
						strcpy(ret, (char *)pa);
						DisposeObject(filereq);
						return TRUE;
		}
		DisposeObject( filereq);
	} else
		Do_requester( "Unable to create filerequester object." );
	return FALSE;
}

int SaveRequest(char *ret)
{
	Object	*filereq;
     ULONG	pa, rc;

	filereq = FileReqObject, ASLFR_DoPatterns, TRUE,
						ASLFR_TitleText, (ULONG) "Select die strip to save",
						ASLFR_InitialDrawer, (LONG) SAVE_DIRECTORY,
						ASLFR_InitialPattern, "#?.strip",
						ASLFR_Window, window,
						ASLFR_InitialFile, "unnamed.strip",
						ASLFR_DoSaveMode, TRUE,
						EndObject;
	if ( filereq ) {
		if ( ! ( rc = DoRequest( filereq )))
		{
                              GetAttr( FRQ_Path, filereq, &pa);
						strcpy(ret, (char *)pa);
						DisposeObject(filereq);
						return TRUE;
		}
		DisposeObject( filereq);
	} else
		Do_requester( "Unable to create filerequester object." );
	return FALSE;
}

void Display_die(int n)
{
	Total += n;
	Result = n;

	SetGadgetAttrs((struct Gadget *)GO_Result, window, NULL, INFO_Args, &Result, TAG_END);
	SetGadgetAttrs((struct Gadget *)GO_Total, window, NULL, INFO_Args, &Total, TAG_END);
}

void cmdClearClicked( void )
{
	Total = 0;
	Result = 0;

	SetGadgetAttrs((struct Gadget *)GO_Total, window, NULL, INFO_Args, &Total, TAG_END);
	SetGadgetAttrs((struct Gadget *)GO_Result, window, NULL, INFO_Args, &Result, TAG_END);
}

void cmdRollClicked( void )
{
	ULONG temp;
	char buf[BUF];

	GetAttr(STRINGA_TextVal, GO_Combo, &temp);
	SetGadgetAttrs((struct Gadget *)GO_Combo, window, NULL,
				STRINGA_BufferPos, 0, TAG_END);
	strcpy(buf, (UBYTE *)temp);
	Display_die(impInterpretAndRoll( buf ));
}

void txtComboClicked( void )
{
	cmdRollClicked();
	ActivateGadget((struct Gadget *)GO_Combo, window, NULL);
}

void Get_buttons(UBYTE *fname)
{
     BPTR fh;
     UBYTE buf[BUF], *temp;
	UBYTE filename[108];

	if (fname == NULL)
	{
		if (!LoadRequest(filename))
			return;
	}
	else
	{
		strcpy(filename, fname);
	}

     if (fh = Open(filename, MODE_OLDFILE))
     {
		LockList(GO_lstDice);
		ClearList(window, GO_lstDice);
	     while (FGets(fh, buf, BUF))
	     {
			temp = strchr(buf, '\n');     // Strip the trailing newline
			*temp = '\0';
			AddEntry(window, GO_lstDice, buf, LVAP_TAIL);
		}
		UnlockList(window, GO_lstDice);
		Close( fh );
	}
}

void Put_buttons( void )
{
	APTR worknode;
	char filename[BUF];
	BPTR fh;

	if (SaveRequest(filename))
	{
		if (fh = Open(filename, MODE_NEWFILE))
		{
			if ( worknode = (APTR)DoMethod(GO_lstDice, LVM_FIRSTENTRY, NULL, 0L))
			{
				do {
					FPuts(fh, worknode);
					FPutC(fh, '\n');
					worknode = (APTR)DoMethod(GO_lstDice, LVM_NEXTENTRY, worknode, 0L);
				} while (worknode);
			}
			Close(fh);
		}
	}
}

void cmdAddClicked(void)
{
	ULONG tmp;

	GetAttr(STRINGA_TextVal, GO_Combo, &tmp);

	if (strcmp((UBYTE *)tmp, ""))
	{
		LockList(GO_lstDice);
		AddEntrySelect(window, GO_lstDice, (UBYTE *)tmp, LVAP_TAIL);
		UnlockList(window, GO_lstDice);
	}
}

void cmdDelClicked(void)
{
	ULONG obj;

	obj = FirstSelected(GO_lstDice);

	if (obj)
	{
		LockList(GO_lstDice);
		RemoveEntryVisible(window, GO_lstDice, obj);
		UnlockList(window, GO_lstDice);
		Toggle_gadgets(TRUE);
	}
}

void lstDiceClicked(void)
{
	static ULONG ds[2], dm[2], last = 0, clicked;
	UBYTE *diestring;

	GetAttr( LISTV_LastClicked, GO_lstDice, &clicked );

	if ( clicked == last ) {
		CurrentTime( &ds[ 1 ], &dm[ 1 ] );
			if ( DoubleClick( ds[ 0 ], dm[ 0 ], ds[ 1 ], dm [ 1 ] )) {
				/* Double clicked */
				txtComboClicked();
				last = NULL;
			}
			else
				last = NULL;
	}
	else
	{
		CurrentTime( &ds[ 0 ], &dm[ 0 ] );
		last = clicked;
		ActivateGadget((struct Gadget *)GO_Combo, window, NULL);
	}

	diestring = (UBYTE *)clicked;

	SetGadgetAttrs((struct Gadget *)GO_Combo, window, NULL, STRINGA_TextVal, diestring, TAG_END);
	Toggle_gadgets(FALSE);
}

void Do_requester( STRPTR errmsg )
{
	struct EasyStruct errEZ;

	if (errmsg)
	{
		errEZ = errEasyStruct;           // Display error message passed in
		errEZ.es_TextFormat = errmsg;
		EasyRequest(NULL, &errEZ, NULL);
	}
}

int main(int argc,char *argv[])
{
	ULONG ret, signal, rc, tmp, rxsig = NULL;

	if ( ImpBase = OpenLibrary( IMPLIBNAME, IMPLIBVERSION )) {
	  if ( BGUIBase = OpenLibrary( BGUINAME, BGUIVERSION )) {
	   if ( ARexxClass = InitARexxClass() ) {
		AO_Rexx = NewObject( ARexxClass, NULL, AC_HostName, "IMPDICE", AC_CommandList, Commands, TAG_END );		
          /*
          **      Create the window object.
          **/
		WO_Window = WindowObject,
			WINDOW_Title,			"Dice",
			WINDOW_SizeGadget,		TRUE,
			WINDOW_ScaleWidth,  	30,
			WINDOW_MenuStrip,   	MainMenus,
			WINDOW_HelpFile,		"ImpPro:ImpPro.Guide",
			WINDOW_HelpNode,		"Dice_module",
			WINDOW_SmartRefresh,	TRUE,
			WINDOW_PubScreenName,	"IMP.SCREEN",
			WINDOW_MasterGroup,
				HGroupObject, HOffset( 4 ), VOffset( 4 ), Spacing( 4 ), FillRaster,
					StartMember,
						VGroupObject, Spacing( 1 ),
							StartMember,
								GO_lstDice = StrListview(NULL, NULL, ID_lstDice),
							EndMember,
							StartMember,
								HGroupObject, Spacing( 1 ),
									StartMember,
										GO_Add = XenKeyButton("_Add", ID_cmdAdd),
									EndMember,
									StartMember,
										GO_Del = XenKeyButton("_Del", ID_cmdDel),
									EndMember,
								EndObject, FixMinHeight,
							EndMember,
						EndObject,
					EndMember,
					StartMember,
						VGroupObject, Spacing( 2 ),
							StartMember, GO_Roll = XenKeyButton("_Roll", ID_cmdROLL), Weight(110), EndMember,
							StartMember, GO_Clear = XenKeyButton("_Clear", ID_cmdCLEAR), EndMember,
						EndObject, FixMinWidth,
					EndMember,
					StartMember,
						VGroupObject, HOffset( 4 ), VOffset( 4 ), Spacing( 4 ), Weight(110),
							VarSpace(20),
							StartMember, GO_Combo  = KeyString("C_ombo", "", 20, ID_txtCOMBO), EndMember, FixMinHeight,
							VarSpace(20),
							StartMember, HorizSeperator, EndMember,
							VarSpace(20),
							StartMember, GO_Result = InfoFixed("Result", "\33b\33c%ld", &Result, 1), EndMember, FixMinHeight,
							StartMember, GO_Total  = InfoFixed("Total", "\33c%ld", &Total, 1), EndMember, FixMinHeight,
							VarSpace(20),
						EndObject, Weight(150),
					EndMember,
				EndObject,
		EndObject;

		ssMain.is_ID = MAINWIN_ID;
		if (impReadSnapshot(&ssMain))
			SetAttrs(WO_Window, WINDOW_Bounds, &ssMain.is_Bounds, TAG_END);

		if (WO_Window ) {
			tmp  = GadgetKey( WO_Window, GO_Roll,  "r" );
			tmp += GadgetKey( WO_Window, GO_Clear, "c" );
			tmp += GadgetKey( WO_Window, GO_Combo, "o" );
			if ( tmp == 3) {
				if ( window = WindowOpen( WO_Window )) {
					GetAttr( WINDOW_SigMask, WO_Window, &signal );
					GetAttr( AC_RexxPortMask, AO_Rexx, &rxsig );
					Get_buttons(BUTTON_FILENAME);
					impSeedRand(NULL);
					Toggle_gadgets(TRUE);
					ActivateGadget((struct Gadget *)GO_Combo, window, NULL);
					do {
						ret = Wait( signal | rxsig );
					  	if (ret & rxsig )
							DoMethod( AO_Rexx, ACM_HANDLE_EVENT );

						if (ret & signal)
						{
							while (( rc = HandleEvent( WO_Window )) != WMHI_NOMORE ) {
								switch ( rc ) {
									case	WMHI_CLOSEWINDOW:
									case	ID_QUIT:
										running = FALSE;
										break;
									case ID_ABOUT:
										Req(window, "Okay", AboutText);
										break;
									case ID_LOAD:
										Get_buttons(NULL);
										break;
									case ID_SAVE:
										Put_buttons();
										break;
									case ID_txtCOMBO:
										txtComboClicked();
										break;
									case ID_cmdROLL:
										cmdRollClicked();
										break;
									case ID_cmdCLEAR:
										cmdClearClicked();
										break;
									case ID_lstDice:
										lstDiceClicked();
										break;
									case ID_cmdAdd:
										cmdAddClicked();
										break;
									case ID_cmdDel:
										cmdDelClicked();
										break;
									case ID_SNAPSHOT:
										GetAttr(WINDOW_Bounds, WO_Window, (ULONG *)&ssMain.is_Bounds);
										impWriteSnapshot(&ssMain);
										break;
									case ID_AREXX:
										impARexxSelector("dice");
										break;
								}
							}
						}
					} while ( running );
				} else
					Do_requester ( "Could not open the window" );
			} else
				Do_requester ( "Could not assign gadget keys" );
			if (WO_Window)		DisposeObject( WO_Window );
			if (AO_Rexx)		DisposeObject( AO_Rexx );
		} else
			Do_requester ( "Could not create the window object" );
	     FreeARexxClass( ARexxClass );
	    } else
		    Do_requester ( "Could not initialize AREXX Class" );
		CloseLibrary( BGUIBase );
	  } else
		  Do_requester ( "Unable to open the bgui.library" );
	CloseLibrary( ImpBase );
	} else
		Do_requester ( "Unable to open " IMPLIBNAME );
	return( 0 );
}

VOID rx_Quit( REXXARGS *ra, struct RexxMsg *rxm )
{
	running = FALSE;
	ra->ra_Result = "OK";
}

VOID rx_Clear( REXXARGS *ra, struct RexxMsg *rxm )
{
	cmdClearClicked();
	ra->ra_Result = "OK";
}

VOID rx_Roll( REXXARGS *ra, struct RexxMsg *rxm )
{
	ULONG ret;

	if (ra->ra_ArgList[0])
	{
		if (Blind)
			ret = impInterpretAndRoll((STRPTR)ra->ra_ArgList[0]);
		else
		{
			SetGadgetAttrs((struct Gadget *)GO_Combo, window, NULL,
						STRINGA_TextVal, (UBYTE *)ra->ra_ArgList[0], TAG_END);
			cmdRollClicked();
			ret = Result;
		}
	}
	else
	{
		cmdRollClicked();
		ret = Result;
	}
	Sprintf(rxbuf, "%ld", ret);
	ra->ra_Result = rxbuf;
}

VOID rx_Rand( REXXARGS *ra, struct RexxMsg *rxm )
{
	LONG ret;

	if (ra->ra_ArgList[0])
	{
		ret = impRand(*((ULONG *)ra->ra_ArgList[0]));
		Sprintf(rxbuf, "%ld", ret);
		ra->ra_Result = rxbuf;
	}
	else
		ra->ra_Result = "Missing parameter!";
}

VOID rx_Get( REXXARGS *ra, struct RexxMsg *rxm )
{
	ULONG ret;

	if (ra->ra_ArgList[0])
	{
		GetAttr(STRINGA_TextVal, GO_Combo, &ret);
		strcpy(rxbuf, (UBYTE *)ret);
	}
	if (ra->ra_ArgList[1])
		Sprintf(rxbuf, "%ld", Total);

	ra->ra_Result = rxbuf;
}

VOID rx_Blind( REXXARGS *ra, struct RexxMsg *rxm )
{
	if (ra->ra_ArgList[0])
		Blind = TRUE;	
	else
		Blind = FALSE;

	ra->ra_Result = "OK";
}
