// Defines for an external Imp Professional module

#include "ImpPro:Library_work/ImpLib.h"
#include "ImpPro:Library_work/ImpLib_pragmas.h"

#define BUF               80
#define IMP_SCREEN_NAME   "IMP.SCREEN"
#define OK                1
#define MOD_VERSION	  "0.69"
#define NUM_BUTTONS       8
#define BUTTON_LENGTH     20
#define BUTTON_FILENAME   "ImpPro:Save/Default.strip"

#define MAINWIN_ID	  MAKE_ID('M', 'D', 'I', '0')

// Protos for an external Imp Professional module

void Get_buttons(UBYTE *);
void Do_requester(STRPTR);
void cmdAddClicked();
void cmdDelClicked();
void Get_Buttons(UBYTE *);
void Put_Buttons(void);

/*
**      Protos for the arexx command functions.
**/

VOID rx_Quit( REXXARGS *, struct RexxMsg * );
VOID rx_Clear( REXXARGS *, struct RexxMsg * );
VOID rx_Roll( REXXARGS *, struct RexxMsg * );
VOID rx_Rand( REXXARGS *, struct RexxMsg * );
VOID rx_Get( REXXARGS *, struct RexxMsg * );
VOID rx_Blind( REXXARGS *, struct RexxMsg * );
