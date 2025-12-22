/*
** Requester
** =========
**
** General requester used by AmberCheat.
*/

#include  <proto/muimaster.h>
#include  "AmberCheat_gui.h"
#include  "AmberCheat_req.h"

extern struct ObjApp *gui;

/*///"int request( STRPTR, APTR, ... )"
** General purpose-requester. Provided with two Gadgets: Yes|No
*/
int request( STRPTR text, APTR arg1, ... )
{
	return( MUI_RequestA( gui->App, gui->MainWindow, 0, "AmberCheat-Bestätigung", "*OK|_Abbruch", text, &arg1 ) );
}
/*///*/
/*///"void requestNA( STRPTR, APTR, ... )"
** General-Purpose-Requester2: No answers possible.
*/
void requestNA( STRPTR text, APTR arg1, ... )
{
	MUI_RequestA( gui->App, gui->MainWindow, 0, "AmberCheat-Bestätigung", "*Okay", text, &arg1 );
}
/*///*/
/*///"int requester( STRPTR, STRPTR, APTR, ... )"
** More friendly MUI-requester: Gadgets are taken from parameters.
*/
int requester( STRPTR text, STRPTR gadgets, APTR arg1, ... )
{
	return( MUI_RequestA( gui->App, gui->MainWindow, 0, "AmberCheat-Bestätigung", gadgets, text, &arg1 ) );
}
/*///*/

