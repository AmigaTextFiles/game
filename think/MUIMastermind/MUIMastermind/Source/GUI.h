/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 22.09.98 22:35                               */
/************************************************/

#define INLINE __inline
#define REG(x) register __##x
#define SAVEDS __saveds

#include <libraries/mui.h>
#include <proto/muimaster.h>
#include <proto/exec.h>
#include <mui/ImageButton_mcc.h>

#include "Einstellungen.h"
#include "Mastermind.h"
#include "PopSymbol.h"

struct ObjApp
{
   APTR   App;
   APTR   MN_Root;
   APTR   WI_Hauptfenster;
   APTR   WI_Einstellungen;
   TEXT   STR_SymbolText[6][20];
   TEXT   STR_SymbolBild[6][50];
   TEXT   STR_BewertungS[5][50];
   TEXT   STR_BewertungW[5][50];
   struct MUI_CustomClass *CL_Einstellungen;
   struct MUI_CustomClass *CL_Mastermind;
   struct MUI_CustomClass *CL_PopSymbol;
};

