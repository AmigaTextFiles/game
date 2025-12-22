/****h* IChing/IChingReq.c [2.0] **************************************
*
* NAME
*    IChingReq.c
*
* NOTES
*    GUI Designed by : Jim Steichen
*    $VER: IChingReq.c 2.0 (13-Jul-2001) by J.T. Steichen
***********************************************************************
*
*/

#include <stdio.h>
#include <string.h>

#include <exec/types.h>

#include <AmigaDOSErrs.h>

#include <intuition/intuition.h>
#include <intuition/classes.h>
#include <intuition/classusr.h>
#include <intuition/gadgetclass.h>

#include <libraries/gadtools.h>

#include <graphics/displayinfo.h>
#include <graphics/gfxbase.h>

#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/graphics_protos.h>
#include <clib/utility_protos.h>
#include <clib/diskfont_protos.h>

#include "CPGM:GlobalObjects/CommonFuncs.h"


#define L1Zero    0
#define L1One     1
#define L1Two     2
#define L1Three   3
#define L2Zero    4
#define L2One     5
#define L2Two     6
#define L2Three   7
#define L3Zero    8
#define L3One     9
#define L3Two     10
#define L3Three   11
#define L4Zero    12
#define L4One     13
#define L4Two     14
#define L4Three   15
#define L5Zero    16
#define L5One     17
#define L5Two     18
#define L5Three   19
#define L6Zero    20
#define L6One     21
#define L6Two     22
#define L6Three   23
#define ResetBt   24
#define DoneBt    25

#define ICR_CNT   26

// ------------------------------------------------------------------

IMPORT struct IntuitionBase *IntuitionBase;
IMPORT struct GfxBase       *GfxBase;
IMPORT struct Library       *GadToolsBase;

IMPORT struct Screen   *Scr;
IMPORT UBYTE           *PubScreenName;
IMPORT APTR             VisualInfo;

IMPORT struct TextAttr *Font;
IMPORT struct CompFont  CFont;

// ------------------------------------------------------------------

PRIVATE struct Window       *ICRWnd = NULL;
PRIVATE struct Gadget       *ICRGList = NULL;
PRIVATE struct Gadget       *ICRGadgets[ ICR_CNT ];

PRIVATE struct IntuiMessage  ICRMsg;

PRIVATE UWORD  ICRLeft   = 155;
PRIVATE UWORD  ICRTop    = 15;
PRIVATE UWORD  ICRWidth  = 330;
PRIVATE UWORD  ICRHeight = 340;
PRIVATE UBYTE *ICRWdt    = "IChing ©1992-2001 by J.T. Steichen:";

PRIVATE struct TextFont *ICRFont = NULL;

#define ICR_TNUM 7

PRIVATE struct IntuiText ICRIText[ ICR_TNUM ] = {

   2, 0, JAM1, 179,  9, NULL, (UBYTE *)"Enter # of heads per toss:", NULL,

   2, 0, JAM1, 50,  49, NULL, (UBYTE *)"Line 1:", NULL,
   2, 0, JAM1, 50,  97, NULL, (UBYTE *)"Line 2:", NULL,
   2, 0, JAM1, 50, 147, NULL, (UBYTE *)"Line 3:", NULL,
   2, 0, JAM1, 50, 196, NULL, (UBYTE *)"Line 4:", NULL,
   2, 0, JAM1, 50, 245, NULL, (UBYTE *)"Line 5:", NULL,
   2, 0, JAM1, 50, 294, NULL, (UBYTE *)"Line 6:", NULL 
};


PRIVATE UWORD ICRGTypes[] = {

   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,
   CHECKBOX_KIND,   CHECKBOX_KIND,   CHECKBOX_KIND,

   BUTTON_KIND,     BUTTON_KIND
};

PRIVATE int L1ZeroClicked(  void );
PRIVATE int L1OneClicked(   void );
PRIVATE int L1TwoClicked(   void );
PRIVATE int L1ThreeClicked( void );
PRIVATE int L2ZeroClicked(  void );
PRIVATE int L2OneClicked(   void );
PRIVATE int L2TwoClicked(   void );
PRIVATE int L2ThreeClicked( void );
PRIVATE int L3ZeroClicked(  void );
PRIVATE int L3OneClicked(   void );
PRIVATE int L3TwoClicked(   void );
PRIVATE int L3ThreeClicked( void );
PRIVATE int L4ZeroClicked(  void );
PRIVATE int L4OneClicked(   void );
PRIVATE int L4TwoClicked(   void );
PRIVATE int L4ThreeClicked( void );
PRIVATE int L5ZeroClicked(  void );
PRIVATE int L5OneClicked(   void );
PRIVATE int L5TwoClicked(   void );
PRIVATE int L5ThreeClicked( void );
PRIVATE int L6ZeroClicked(  void );
PRIVATE int L6OneClicked(   void );
PRIVATE int L6TwoClicked(   void );
PRIVATE int L6ThreeClicked( void );
PRIVATE int ResetBtClicked( void );
PRIVATE int DoneBtClicked(  void );

PRIVATE struct NewGadget ICRNGad[] = {

    82,  43, 26, 11, (UBYTE *) "0:", NULL, L1Zero,  PLACETEXT_ABOVE, NULL,
   (APTR) L1ZeroClicked,
   113,  43, 26, 11, (UBYTE *) "1:", NULL, L1One,   PLACETEXT_ABOVE, NULL,
   (APTR) L1OneClicked,
   146,  43, 26, 11, (UBYTE *) "2:", NULL, L1Two,   PLACETEXT_ABOVE, NULL,
   (APTR) L1TwoClicked,
   177,  43, 26, 11, (UBYTE *) "3:", NULL, L1Three, PLACETEXT_ABOVE, NULL,
   (APTR) L1ThreeClicked,

    82,  92, 26, 11, (UBYTE *) "0:", NULL, L2Zero,  PLACETEXT_ABOVE, NULL,
   (APTR) L2ZeroClicked,
   113,  92, 26, 11, (UBYTE *) "1:", NULL, L2One,   PLACETEXT_ABOVE, NULL,
   (APTR) L2OneClicked,
   145,  92, 26, 11, (UBYTE *) "2:", NULL, L2Two,   PLACETEXT_ABOVE, NULL,
   (APTR) L2TwoClicked,
   177,  92, 26, 11, (UBYTE *) "3:", NULL, L2Three, PLACETEXT_ABOVE, NULL, 
   (APTR) L2ThreeClicked,
   
    82, 141, 26, 11, (UBYTE *) "0:", NULL, L3Zero,  PLACETEXT_ABOVE, NULL, 
   (APTR) L3ZeroClicked,
   113, 141, 26, 11, (UBYTE *) "1:", NULL, L3One,   PLACETEXT_ABOVE, NULL, 
   (APTR) L3OneClicked,
   145, 141, 26, 11, (UBYTE *) "2:", NULL, L3Two,   PLACETEXT_ABOVE, NULL, 
   (APTR) L3TwoClicked,
   177, 141, 26, 11, (UBYTE *) "3:", NULL, L3Three, PLACETEXT_ABOVE, NULL, 
   (APTR) L3ThreeClicked,
   
    82, 190, 26, 11, (UBYTE *) "0:", NULL, L4Zero,  PLACETEXT_ABOVE, NULL, 
   (APTR) L4ZeroClicked,
   113, 190, 26, 11, (UBYTE *) "1:", NULL, L4One,   PLACETEXT_ABOVE, NULL, 
   (APTR) L4OneClicked,
   145, 190, 26, 11, (UBYTE *) "2:", NULL, L4Two,   PLACETEXT_ABOVE, NULL, 
   (APTR) L4TwoClicked,
   177, 190, 26, 11, (UBYTE *) "3:", NULL, L4Three, PLACETEXT_ABOVE, NULL, 
   (APTR) L4ThreeClicked,
   
    82, 239, 26, 11, (UBYTE *) "0:", NULL, L5Zero,  PLACETEXT_ABOVE, NULL, 
   (APTR) L5ZeroClicked,
   113, 239, 26, 11, (UBYTE *) "1:", NULL, L5One,   PLACETEXT_ABOVE, NULL, 
   (APTR) L5OneClicked,
   145, 239, 26, 11, (UBYTE *) "2:", NULL, L5Two,   PLACETEXT_ABOVE, NULL, 
   (APTR) L5TwoClicked,
   177, 239, 26, 11, (UBYTE *) "3:", NULL, L5Three, PLACETEXT_ABOVE, NULL, 
   (APTR) L5ThreeClicked,
   
    82, 288, 26, 11, (UBYTE *) "0:", NULL, L6Zero,  PLACETEXT_ABOVE, NULL, 
   (APTR) L6ZeroClicked,
   113, 288, 26, 11, (UBYTE *) "1:", NULL, L6One,   PLACETEXT_ABOVE, NULL, 
   (APTR) L6OneClicked,
   145, 288, 26, 11, (UBYTE *) "2:", NULL, L6Two,   PLACETEXT_ABOVE, NULL, 
   (APTR) L6TwoClicked,
   177, 288, 26, 11, (UBYTE *) "3:", NULL, L6Three, PLACETEXT_ABOVE, NULL, 
   (APTR) L6ThreeClicked,

    16, 319, 65, 18, (UBYTE *) "_RESET", NULL, ResetBt, PLACETEXT_IN, NULL,
   (APTR) ResetBtClicked,

   240, 319, 65, 18, (UBYTE *) "_DONE!", NULL, DoneBt,  PLACETEXT_IN, NULL,
   (APTR) DoneBtClicked
};

PRIVATE ULONG ICRGTags[] = {

   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),
   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),
   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),
   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),
   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),
   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),   (TAG_DONE),

   (GT_Underscore), '_', (TAG_DONE),
   (GT_Underscore), '_', (TAG_DONE)
};

// --------------------------------------------------------------------

PRIVATE void CloseICRWindow( void )
{
   if (ICRWnd) 
      {
      CloseWindow( ICRWnd );
      ICRWnd = NULL;
      }

   if (ICRGList) 
      {
      FreeGadgets( ICRGList );
      ICRGList = NULL;
      }

   if (ICRFont) 
      {
      CloseFont( ICRFont );
      ICRFont = NULL;
      }

   return;
}

// --------------------------------------------------------------------

PRIVATE int LineValues[6] = { 0, };

PRIVATE void Convert_To_Type( int line, int *type )
{
   if (line == 1 || line >= 3)
      *type = 0;
   else if (line <= 0 || line == 2)
      *type = 1;

   return;
}

PRIVATE int DoneBtClicked( void )
{
   IMPORT int line_type1[], line_type2[];
   int i;
   
   for (i = 0; i < 6; i++)    
      {
      Convert_To_Type( LineValues[i], &line_type1[i] );
  
      if (LineValues[i] == 3)  
         LineValues[i] = 0;
      else if (LineValues[i] == 0)  
         LineValues[i] = 3;

      Convert_To_Type( LineValues[i], &line_type2[i] );
      }

   CloseICRWindow();

   return( FALSE );
}

// --------------------------------------------------------------------
    
PRIVATE int L1ZeroClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L1One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[0] = 0;

   return( TRUE );   
}

PRIVATE int L1OneClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L1Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[0] = 1;

   return( TRUE );   
}

PRIVATE int L1TwoClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L1One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[0] = 2;

   return( TRUE );   
}

PRIVATE int L1ThreeClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L1One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[0] = 3;

   return( TRUE );   
}

PRIVATE int L2ZeroClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L2One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[1] = 0;

   return( TRUE );   
}

PRIVATE int L2OneClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L2Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[1] = 1;

   return( TRUE );   
}

PRIVATE int L2TwoClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L2One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[1] = 2;

   return( TRUE );   
}

PRIVATE int L2ThreeClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L2One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[1] = 3;

   return( TRUE );   
}

PRIVATE int L3ZeroClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L3One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[2] = 0;

   return( TRUE );   
}

PRIVATE int L3OneClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L3Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[2] = 1;

   return( TRUE );   
}

PRIVATE int L3TwoClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L3One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[2] = 2;

   return( TRUE );   
}

PRIVATE int L3ThreeClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L3One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[2] = 3;

   return( TRUE );   
}

PRIVATE int L4ZeroClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L4One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[3] = 0;

   return( TRUE );   
}

PRIVATE int L4OneClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L4Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[3] = 1;

   return( TRUE );   
}

PRIVATE int L4TwoClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L4One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[3] = 2;

   return( TRUE );   
}

PRIVATE int L4ThreeClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L4One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[3] = 3;

   return( TRUE );   
}

PRIVATE int L5ZeroClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L5One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[4] = 0;

   return( TRUE );   
}

PRIVATE int L5OneClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L5Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[4] = 1;

   return( TRUE );   
}

PRIVATE int L5TwoClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L5One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[4] = 2;

   return( TRUE );   
}

PRIVATE int L5ThreeClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L5One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[4] = 3;

   return( TRUE );   
}

PRIVATE int L6ZeroClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L6One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[5] = 0;

   return( TRUE );   
}

PRIVATE int L6OneClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L6Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[5] = 1;

   return( TRUE );   
}

PRIVATE int L6TwoClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L6One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[5] = 2;

   return( TRUE );   
}

PRIVATE int L6ThreeClicked( void )
{
   GT_SetGadgetAttrs( ICRGadgets[ L6One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   LineValues[5] = 3;

   return( TRUE );   
}

PRIVATE int ResetBtClicked( void )
{
   int i;
   
   GT_SetGadgetAttrs( ICRGadgets[ L1Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L1Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   GT_SetGadgetAttrs( ICRGadgets[ L2Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L2Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   GT_SetGadgetAttrs( ICRGadgets[ L3Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L3Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   GT_SetGadgetAttrs( ICRGadgets[ L4Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L4Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   GT_SetGadgetAttrs( ICRGadgets[ L5Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L5Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   GT_SetGadgetAttrs( ICRGadgets[ L6Zero ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6One ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Two ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );

   GT_SetGadgetAttrs( ICRGadgets[ L6Three ], ICRWnd, NULL,
                      GTCB_Checked, FALSE, TAG_DONE
                    );
   
   for (i = 0; i < 6; i++)
      LineValues[i] = 0;
      
   return( TRUE );
}

// --------------------------------------------------------------------

PRIVATE void ICRRender( void )
{
   struct IntuiText   it;
   UWORD         cnt;

   ComputeFont( Scr, Font, &CFont, ICRWidth, ICRHeight );

   DrawBevelBox( ICRWnd->RPort, CFont.OffX + ComputeX( CFont.FontX, 16 ),
                 CFont.OffY + ComputeY( CFont.FontY, 24 ),
                 ComputeX( CFont.FontX, 193 ),
                 ComputeY( CFont.FontY, 45 ),
                 GT_VisualInfo, VisualInfo, TAG_DONE
               );

   DrawBevelBox( ICRWnd->RPort, CFont.OffX + ComputeX( CFont.FontX, 16 ),
                 CFont.OffY + ComputeY( CFont.FontY, 70 ),
                 ComputeX( CFont.FontX, 193 ),
                 ComputeY( CFont.FontY, 45 ),
                 GT_VisualInfo, VisualInfo, TAG_DONE
               );

   DrawBevelBox( ICRWnd->RPort, CFont.OffX + ComputeX( CFont.FontX, 16 ),
                 CFont.OffY + ComputeY( CFont.FontY, 218 ),
                 ComputeX( CFont.FontX, 193 ),
                 ComputeY( CFont.FontY, 45 ),
                 GT_VisualInfo, VisualInfo, TAG_DONE 
               );

   DrawBevelBox( ICRWnd->RPort, CFont.OffX + ComputeX( CFont.FontX, 16 ),
                 CFont.OffY + ComputeY( CFont.FontY, 267 ),
                 ComputeX( CFont.FontX, 193 ),
                 ComputeY( CFont.FontY, 45 ),
                 GT_VisualInfo, VisualInfo, TAG_DONE 
               );

   DrawBevelBox( ICRWnd->RPort, CFont.OffX + ComputeX( CFont.FontX, 16 ),
                 CFont.OffY + ComputeY( CFont.FontY, 118 ),
                 ComputeX( CFont.FontX, 193 ),
                 ComputeY( CFont.FontY, 45 ),
                 GT_VisualInfo, VisualInfo, TAG_DONE 
               );

   DrawBevelBox( ICRWnd->RPort, CFont.OffX + ComputeX( CFont.FontX, 16 ),
                 CFont.OffY + ComputeY( CFont.FontY, 168 ),
                 ComputeX( CFont.FontX, 193 ),
                 ComputeY( CFont.FontY, 45 ),
                 GT_VisualInfo, VisualInfo, TAG_DONE 
               );

   for (cnt = 0; cnt < ICR_TNUM; cnt++) 
      {
      CopyMem( (char *) &ICRIText[ cnt ], (char *) &it, 
               (long) sizeof( struct IntuiText )
             );
      
      it.ITextFont = Font;
      
      it.LeftEdge  = CFont.OffX + ComputeX( CFont.FontX, it.LeftEdge ) 
                     - (IntuiTextLength( &it ) >> 1);
      
      it.TopEdge   = CFont.OffY + ComputeY( CFont.FontY, it.TopEdge ) 
                     - (Font->ta_YSize >> 1);
      
      PrintIText( ICRWnd->RPort, &it, 0, 0 );
      }
}

PRIVATE int OpenICRWindow( void )
{
   struct NewGadget  ng;
   struct Gadget    *g;
   UWORD             lc, tc;
   UWORD             wleft = ICRLeft, wtop = ICRTop, ww, wh;

   ComputeFont( Scr, Font, &CFont, ICRWidth, ICRHeight );

   ww = ComputeX( CFont.FontX, ICRWidth );
   wh = ComputeY( CFont.FontY, ICRHeight );

   if ((wleft + ww + CFont.OffX + Scr->WBorRight) > Scr->Width) 
      wleft = Scr->Width - ww;
   
   if ((wtop + wh + CFont.OffY + Scr->WBorBottom) > Scr->Height) 
      wtop = Scr->Height - wh;

   if ((ICRFont = OpenDiskFont( Font )) == NULL)
      return( -5 );

   if ((g = CreateContext( &ICRGList )) == NULL)
      return( -1 );

   for (lc = 0, tc = 0; lc < ICR_CNT; lc++) 
      {
      CopyMem( (char *) &ICRNGad[ lc ], (char *) &ng, 
               (long) sizeof( struct NewGadget )
             );

      ng.ng_VisualInfo = VisualInfo;
      ng.ng_TextAttr   = Font;

      ng.ng_LeftEdge   = CFont.OffX + ComputeX( CFont.FontX,
                                                ng.ng_LeftEdge
                                              );

      ng.ng_TopEdge    = CFont.OffY + ComputeY( CFont.FontY, 
                                                ng.ng_TopEdge
                                              );

      ng.ng_Width      = ComputeX( CFont.FontX, ng.ng_Width );
      ng.ng_Height     = ComputeY( CFont.FontY, ng.ng_Height);

      ICRGadgets[ lc ] = g 
                       = CreateGadgetA( (ULONG) ICRGTypes[ lc ], 
                                        g, 
                                        &ng, 
                                        (struct TagItem *)&ICRGTags[ tc ] 
                                      );

      while (ICRGTags[ tc ] != TAG_DONE) 
         tc += 2;

      tc++;

      if (g == NULL)
         return( -2 );
      }

   if ((ICRWnd = OpenWindowTags( NULL,
   
            WA_Left,      wleft,
            WA_Top,       wtop,
            WA_Width,     ww + CFont.OffX + Scr->WBorRight,
            WA_Height,    wh + CFont.OffY + Scr->WBorBottom,
 
            WA_IDCMP,     CHECKBOXIDCMP | BUTTONIDCMP | IDCMP_GADGETDOWN
              | IDCMP_VANILLAKEY | IDCMP_REFRESHWINDOW,
 
            WA_Flags,     WFLG_DRAGBAR | WFLG_DEPTHGADGET 
              | WFLG_SMART_REFRESH | WFLG_ACTIVATE,

            WA_Gadgets,   ICRGList,
            WA_Title,     ICRWdt,
            WA_MinWidth,  260,
            WA_MinHeight, 20,
            WA_MaxWidth,  640,
            WA_MaxHeight, 480,
            WA_CustomScreen, Scr,

            TAG_DONE )
      ) == NULL)
      return( -4 );

   GT_RefreshWindow( ICRWnd, NULL );

   ICRRender();

   return( 0 );
}

PRIVATE int ICRVanillaKey( int whichkey )
{
   int rval = TRUE;
   
   switch (whichkey)
      {
      case 'd':
      case 'D':
         rval = DoneBtClicked();
         break;
         
      case 'r':
      case 'R':
         rval = ResetBtClicked();
         break;
      }
      
   return( rval );
}


PRIVATE int HandleICRIDCMP( void )
{
   struct IntuiMessage *m;
   int                (*func)( void );
   BOOL                 running = TRUE;

   while (running == TRUE)
      {
      if ((m = GT_GetIMsg( ICRWnd->UserPort )) == NULL) 
         {
         (void) Wait( 1L << ICRWnd->UserPort->mp_SigBit );
         continue;
         }

      CopyMem( (char *) m, (char *) &ICRMsg, 
               (long) sizeof( struct IntuiMessage )
             );

      GT_ReplyIMsg( m );

      switch (ICRMsg.Class) 
         {
         case   IDCMP_REFRESHWINDOW:
            GT_BeginRefresh( ICRWnd );
            ICRRender();
            GT_EndRefresh( ICRWnd, TRUE );
            break;

         case   IDCMP_VANILLAKEY:
            running = ICRVanillaKey( ICRMsg.Code );
            break;

         case   IDCMP_GADGETUP:
         case   IDCMP_GADGETDOWN:
            func = (void *) ((struct Gadget *) ICRMsg.IAddress)->UserData;

            if (func != NULL)
               running = func();
   
            break;
         }
      }

   return( running );
}

PUBLIC int HandleICReq( int linetype1[], int linetype2[] )
{
   if (OpenICRWindow() < 0)
      return( FALSE );
      
   (void) HandleICRIDCMP();
   
   return( TRUE );
}

/* ------------------ END of IChingReq.c file! -------------------- */
