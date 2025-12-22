/****h* IChing/IChing.c [2.0] *******************************************
*
* NAME
*    IChing.c
*
* DESCRIPTION
*    Take input coin tosses and convert to a hexagram.
*
* SYNOPSIS
*    iching [t1 t2 t3 t4 t5 t6]
*
* INPUTS
*    t1 - t6 = The number of heads in each 3-coin toss.
*
* HISTORY
*    16-Jul-2001 Started a re-write of the entire program to use
*                GadTools.
*    23-Apr-1992
*
* NOTES
*    $VER: IChing.c 2.0 (16-JUl-2001) by J.T. Steichen
*************************************************************************
*
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <exec/types.h>

#include <AmigaDOSErrs.h>

#include <intuition/intuition.h>
#include <intuition/classes.h>
#include <intuition/classusr.h>
#include <intuition/imageclass.h>
#include <intuition/gadgetclass.h>

#include <libraries/gadtools.h>

#include <dos/dosextens.h>
#include <dos/dos.h>

#include <graphics/displayinfo.h>
#include <graphics/gfxbase.h>

#include <workbench/workbench.h>
#include <workbench/startup.h>
#include <workbench/icon.h>

#include <clib/exec_protos.h>
#include <clib/dos_protos.h>
#include <clib/intuition_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/graphics_protos.h>
#include <clib/utility_protos.h>
#include <clib/diskfont_protos.h>

#include "IChing.h"
#include "IChingStructs.h"

#include "CPGM:GlobalObjects/CommonFuncs.h"

// -------------------------------------------------------------------

IMPORT struct PAGE        *FirstPage;
IMPORT struct IntuiText   *Attr, *FirstLine;
IMPORT struct WBStartup   *_WBenchMsg;

// -------------------------------------------------------------------

PUBLIC struct IntuitionBase *IntuitionBase;
PUBLIC struct GfxBase       *GfxBase;
PUBLIC struct Library       *GadToolsBase;
PUBLIC struct Library       *IconBase;

PUBLIC struct TextAttr      *Font   = NULL, FAttr = { 0, };
PUBLIC struct CompFont       CFont  = { 0, };
PUBLIC struct Screen        *Scr    = NULL;
PUBLIC struct Window        *ICMWnd = NULL;

PUBLIC APTR                  VisualInfo = NULL;

PUBLIC int line_type1[6], line_type2[6];

// -------------------------------------------------------------------

PRIVATE char v[] = "\0$VER: IChing 2.0 " __AMIGADATE__ " by J.T. Steichen\0";


PRIVATE char  TextFile[]       = "TEXTFILE";
PRIVATE char  DefTextFile[128] = "IChing.txt";
PRIVATE char *TTTextFile       = &DefTextFile[0];

PRIVATE struct DiskObject   *diskobj  = NULL;
PRIVATE struct Menu         *ICMMenus = NULL;
PRIVATE struct TextFont     *ICMFont  = NULL;
PRIVATE struct IntuiMessage  ICMMsg;

PRIVATE UWORD  ICMLeft   = 0;
PRIVATE UWORD  ICMTop    = 14;
PRIVATE UWORD  ICMWidth  = 640;
PRIVATE UWORD  ICMHeight = 200;
PRIVATE UBYTE *ICMWdt    = "IChing -- The SoothSayer ©1992 by J.T. Steichen:";


PRIVATE int ICMNewHexMI(  void );
PRIVATE int ICMNextHexMI( void );
PRIVATE int ICMQuitMI(    void );

PRIVATE struct NewMenu ICMNewMenu[] = {

   NM_TITLE, (STRPTR)"PROJECT", NULL, 0, NULL, NULL,
  
    NM_ITEM, (STRPTR) "New Hexagram",  (STRPTR) "N", 0, 0L, 
    (APTR) ICMNewHexMI,

    NM_ITEM, (STRPTR) "Next Hexagram", (STRPTR) "H", 0, 0L, 
    (APTR) ICMNextHexMI,
    
    NM_ITEM, (STRPTR) "Quit",          (STRPTR) "Q", 0, 0L, 
    (APTR) ICMQuitMI,
  
   NM_END, NULL, NULL, 0, 0L, NULL 
};

PRIVATE struct ColorSpec ScreenColors[] = {

    0, 0x00, 0x00, 0x00,  // Black
    1, 0x0F, 0x0F, 0x0F,  // White
    2, 0x0F, 0x00, 0x00,  // Red
    3, 0x0F, 0x07, 0x01,  // Orange
    4, 0x0E, 0x0E, 0x00,  // Yellow
    5, 0x00, 0x0E, 0x00,  // Green
    6, 0x00, 0x00, 0x0F,  // Blue
    7, 0x0D, 0x00, 0x0D,  // Purple
    8, 0x00, 0x0F, 0x0F,  // Cyan
    9, 0x0F, 0x07, 0x07,  // Pink
   10, 0x03, 0x0F, 0x08,  // Light Green
   11, 0x0F, 0x00, 0x0F,  // Lavender
   12, 0x08, 0x08, 0x08,  // Gray1
   13, 0x04, 0x04, 0x04,  // Gray2
   14, 0x00, 0x09, 0x03,  // Dark Green
   15, 0x05, 0x08, 0x00,  // Brown
   16, 0x00, 0x00, 0x00,
   17, 0x0F, 0x0F, 0x00,
   18, 0x00, 0x00, 0x00,
   19, 0x0F, 0x00, 0x00,
   20, 0x04, 0x04, 0x04,
   21, 0x05, 0x05, 0x05,
   22, 0x06, 0x06, 0x06,
   23, 0x07, 0x07, 0x07,
   24, 0x08, 0x08, 0x08,
   25, 0x09, 0x09, 0x09,
   26, 0x0A, 0x0A, 0x0A,
   27, 0x0B, 0x0B, 0x0B,
   28, 0x0C, 0x0C, 0x0C,
   29, 0x0D, 0x0D, 0x0D,
   30, 0x0E, 0x0E, 0x0E,
   31, 0x0F, 0x0F, 0x0F,
   ~0, 0x00, 0x00, 0x00 
};

PRIVATE UWORD DriPens[] = { 0xFFFF, };

PRIVATE int   index1, index2;
PRIVATE int   line_val1[6], line_val2[6], Trigram[4];

// -------------------------------------------------------------------

/* change # of heads to 6 -> 9 & assign YIN or YANG to type[]: */

SUBFUNC void  process_heads( int *type, int *value )
{
   int   i;

   for (i = 0; i < 6; i++) 
      {
      value[i] = 9 - value[i];
      
      if (value[i] == 7 || value[i] == 9)
         type[i] = YANG;
      else if (value[i] == 6 || value[i] == 8)
         type[i] = YIN;
      }

   return;
}

/* set up next hexagram based on what the old hexagram is,
** then set up line_type2[].    
*/

SUBFUNC void  make_next_hexagram( void )
{
   int   i;

   for (i = 0; i < 6; i++) 
      {
      if (line_val1[i] == 6)
         line_val2[i] = 9;
      else if (line_val1[i] == 9)
         line_val2[i] = 6;
      else
         line_val2[i] = line_val1[i];

      if (line_val2[i] == 7 || line_val2[i] == 9)
         line_type2[i] = YANG;
      else if (line_val2[i] == 6 || line_val2[i] == 8)
         line_type2[i] = YIN;
      }

   return;
}

SUBFUNC int pow2( int power )    /* return:  2 ^ power */
{
   int   count, rval = 1;

   count = power;
   if (power == 0)
      return( rval );

   while (count-- > 0)
      rval *= 2;

   return( rval );
}

/* change the binary no. in type to a Hexadecimal index into
** the page table.
*/

SUBFUNC void  determine_index( int *index, int *type )
{
   int   i, pow2( int );

   *index = 0;

   for (i = 0; i < 6; i++)
      {
      if (type[i] == 1)
         *index += pow2( i );
      }

   return;
}

/* determine what trigrams are represented by the line_typeX[] arrays: */

SUBFUNC void  get_trigrams( void )
{
   int   i;

   Trigram[0] = Trigram[1] = Trigram[2] = Trigram[3] = 0;

   for (i = 0; i < 3; i++)  
      {
      if (line_type1[i] == 1)
         Trigram[0] += pow2( i );

      if (line_type1[i + 3] == 1)
         Trigram[1] += pow2( i + 3 );

      if (line_type2[i] == 1)
         Trigram[2] += pow2( i );

      if (line_type2[i + 3] == 1)
         Trigram[3] += pow2( i + 3 );
      }

   return;
}

/* the no. of heads was not on the command line. */

SUBFUNC void enter_heads( void )
{
   int   count = 0;  char  buff[3];

   while (count < 6) 
      {
      fprintf( stderr, "\nEnter the number of heads for toss %d: ",
               count + 1 );

      fflush( stderr );

      line_val1[count] = atoi( gets( buff ));

      fprintf( stderr, "\nValue received: %d\n", line_val1[count] );
      count++;
      }

   return;
}

SUBFUNC void  DeallocateStrings( struct IntuiText *pgs )
{
   int   i;
   
   for (i = 0; i < 768; i++)
      free( pgs[i].IText );

   return;
}

/* draw a double dashed line for YIN: */

SUBFUNC void DrawYIN( int x, int y )
{
   Move( ICMWnd->RPort, x, y );
   Draw( ICMWnd->RPort, x + 26, y );
   Move( ICMWnd->RPort, x, y + 1 );
   Draw( ICMWnd->RPort, x + 26, y + 1 );

   Move( ICMWnd->RPort, x + 39, y );
   Draw( ICMWnd->RPort, x + 65, y );
   Move( ICMWnd->RPort, x + 39, y + 1 );
   Draw( ICMWnd->RPort, x + 65, y + 1 );

   return;
}

/* draw a double solid line for YANG */

SUBFUNC void  DrawYANG( int x, int y ) 
{
   Move( ICMWnd->RPort, x, y );
   Draw( ICMWnd->RPort, x + 65, y );
   Move( ICMWnd->RPort, x, y + 1 );
   Draw( ICMWnd->RPort, x + 65, y + 1 );

   return;
}

/* display fortune text & hexagram */

SUBFUNC void  Display( int *hexagram, int index )
{
   struct   PAGE      *p     = (FirstPage + index);
   struct   IntuiText *lines = (FirstLine + index * 12);
   int                 line_num;

   (void) SetAPen( ICMWnd->RPort, 0 );             /* erase old stuff: */

   RectFill( ICMWnd->RPort, 3L, 11L, 640L, 200L );

   PrintIText( ICMWnd->RPort, Attr, 0, 0 );
   PrintIText( ICMWnd->RPort, p->Top_Trigram->TriText, 100, 21 );
   PrintIText( ICMWnd->RPort, p->Bot_Trigram->TriText, 100, 46 );
   DrawImage(  ICMWnd->RPort, p->Top_Trigram->TriImage, 550, 12 );
   DrawImage(  ICMWnd->RPort, p->Bot_Trigram->TriImage, 550, 39 );

   PrintIText( ICMWnd->RPort, p->HexName, 11, 55 );

   (void) SetAPen( ICMWnd->RPort, 1 );

   for (line_num = 0; line_num < 6; line_num++) 
      {
      if (hexagram[ line_num ] == YIN)
         DrawYIN(  18, 48 - line_num * 5 ); /* draw the bottom line 1st */
      else
         DrawYANG( 18, 48 - line_num * 5 );
      }

   for (line_num = 0; line_num < 12; line_num++)
      PrintIText( ICMWnd->RPort, (lines + line_num),
                  11, 68 + line_num * 10 );

   return;
}

PRIVATE char  NIL_[ 81 ];

SUBFUNC char *ReadLine( FILE *fp )
{
   char  *string = &NIL_[0];
   int   letter;
   
   while ((letter = getc( fp )) != '\n' && letter != EOF)
      *string++ = letter;

   *string = '\0';

   return( &NIL_[0] );  
}

SUBFUNC int ReadTextFile( char *filename ) /* Read the IChing.txt file. */
{
   extern struct IntuiText pg[];
   
   FILE  *infile;  /* struct IntuiText pg[ 64 * 12 ] is in IChingText.c */
   int   i;
   char  *temp, *s;
   
   if ((infile = fopen( filename, "r" )) == NULL)
      return -1;
   else  
      {
      for (i = 0; i < 768; i++)  // 64 * 12 = 768
         {  
         /* 64 hexagrams * 12 lines of text */
         
         temp = ReadLine( infile );
         
         if ((s = calloc( 1, 81 )) == NULL)
            return( -1 );
         
         (void) strcpy( s, temp );

         pg[ i ].IText = s;
         }
          
      fclose( infile );
      return( 0 );
      }
}

// -------------------------------------------------------------------

PRIVATE int SetupScreen( void )
{
   if ((Scr = OpenScreenTags( NULL, 

               SA_Left,       0,
               SA_Top,        0,
               SA_Width,      640,
               SA_Height,     480,
               SA_Depth,      8,
               SA_Colors,     &ScreenColors[0],
               SA_Type,	      CUSTOMSCREEN,
               SA_DisplayID,  DEFAULT_MONITOR_ID | LORES_KEY,
               SA_AutoScroll, TRUE,
               SA_Overscan,   OSCAN_TEXT,
               SA_Pens,	      &DriPens[0],
               SA_Title,      "IChing ©1992-2001:",
               TAG_DONE )
       
       ) == NULL)
       return( -1 );

   Font = &FAttr;

   ComputeFont( Scr, Font, &CFont, 0, 0 );

   if ((VisualInfo = GetVisualInfo( Scr, TAG_DONE )) == NULL)
      return( -2 );

   return( 0 );
}

PRIVATE void CloseDownScreen( void )
{
   if (VisualInfo != NULL) 
      {
      FreeVisualInfo( VisualInfo );
      VisualInfo = NULL;
      }

   if (Scr != NULL) 
      {
      CloseScreen( Scr );
      Scr = NULL;
      }

   return;
}

PRIVATE void CloseICMWindow( void )
{
   if (ICMMenus != NULL) 
      {
      ClearMenuStrip( ICMWnd );
      FreeMenus( ICMMenus );
      ICMMenus = NULL;	
      }

   if (ICMWnd != NULL) 
      {
      CloseWindow( ICMWnd );
      ICMWnd = NULL;
      }

   if (ICMFont != NULL) 
      {
      CloseFont( ICMFont );
      ICMFont = NULL;
      }

   return;
}

// ------------------------------------------------------------------

PRIVATE int ICMNewHexMI( void )
{
   IMPORT int HandleICReq( int *, int * );
   
   if (HandleICReq( line_type1, line_type2 ) == TRUE) 
      {
      determine_index( &index1, line_type1 );
      determine_index( &index2, line_type2 );
     
      Display( line_type1, index1 );
      }

   return( TRUE );
}

PRIVATE int ICMNextHexMI( void )
{
   Display( line_type2, index2 );

   return( TRUE );
}

PRIVATE int ICMCloseWindow( void )
{
   CloseICMWindow();
   return( FALSE );
}

PRIVATE int ICMQuitMI( void )
{
   return( ICMCloseWindow() );
}

// ------------------------------------------------------------------

PRIVATE int OpenICMWindow( void )
{
   UWORD wleft = ICMLeft, wtop = ICMTop, ww, wh;

   ComputeFont( Scr, Font, &CFont, ICMWidth, ICMHeight );

   ww = ComputeX( CFont.FontX, ICMWidth );
   wh = ComputeY( CFont.FontY, ICMHeight );

   if ((wleft + ww + CFont.OffX + Scr->WBorRight) > Scr->Width) 
      wleft = Scr->Width - ww;
   
   if ((wtop + wh + CFont.OffY + Scr->WBorBottom) > Scr->Height) 
      wtop = Scr->Height - wh;

   if ((ICMFont = OpenDiskFont( Font )) == NULL)
      return( -5 );

   if ((ICMMenus = CreateMenus( ICMNewMenu, GTMN_FrontPen,
                                0L, TAG_DONE )) == NULL)
      return( -3 );

   LayoutMenus( ICMMenus, VisualInfo, TAG_DONE );

   if ((ICMWnd = OpenWindowTags( NULL,

                  WA_Left,         wleft,
                  WA_Top,          wtop,
                  WA_Width,        ww + CFont.OffX + Scr->WBorRight,
                  WA_Height,       wh + CFont.OffY + Scr->WBorBottom,
                  
                  WA_IDCMP,        IDCMP_MENUPICK | IDCMP_CLOSEWINDOW
                    | IDCMP_REFRESHWINDOW | IDCMP_VANILLAKEY,
                  
                  WA_Flags,        WFLG_CLOSEGADGET | WFLG_SMART_REFRESH
                    | WFLG_ACTIVATE | WFLG_BORDERLESS,
                  
                  WA_Title,        ICMWdt,
                  WA_CustomScreen, Scr,
                  TAG_DONE )
      ) == NULL)
      return( -4 );

   SetMenuStrip( ICMWnd, ICMMenus );
   GT_RefreshWindow( ICMWnd, NULL );

   return( 0 );
}

PRIVATE int ICMVanillaKey( int whichkey )
{
   int rval = TRUE;
   
   switch (whichkey)
      {
      case 'n':
      case 'N':
         rval = ICMNewHexMI();
         break;
      
      case 'h':
      case 'H':
         rval = ICMNextHexMI();
         break;
      
      case 'q':
      case 'Q':
      case 'x':
      case 'X':
      case 'e':
      case 'E':
         rval = ICMQuitMI();
         break;
      }
      
   return( rval );
}

PRIVATE int HandleICMIDCMP( void )
{
   struct IntuiMessage *m;
   struct MenuItem     *n;
   int                (*mfunc)( void );
   BOOL                 running = TRUE;

   while (running == TRUE)
      {
      if ((m = GT_GetIMsg( ICMWnd->UserPort )) == NULL) 
         {
         (void) Wait( 1L << ICMWnd->UserPort->mp_SigBit );
         continue;
         }

       CopyMem( (char *) m, (char *) &ICMMsg, 
                (long) sizeof( struct IntuiMessage )
              );

       GT_ReplyIMsg( m );

       switch (ICMMsg.Class) 
          {
          case IDCMP_REFRESHWINDOW:
             GT_BeginRefresh( ICMWnd );
             GT_EndRefresh( ICMWnd, TRUE );
             break;

          case IDCMP_VANILLAKEY:
             running = ICMVanillaKey( ICMMsg.Code );
             break;
             
          case IDCMP_CLOSEWINDOW:
             running = ICMCloseWindow();
             break;

          case IDCMP_MENUPICK:
            if (ICMMsg.Code != MENUNULL)
               {
               n = ItemAddress( ICMMenus, ICMMsg.Code );

               if (n == NULL)
                  break;

               mfunc = (void *) (GTMENUITEM_USERDATA( n ));

               if (mfunc == NULL)
                  break;

               running = mfunc();
               }
/*             
             while (ICMMsg.Code != MENUNULL) 
                {
                n = ItemAddress( ICMMenus, ICMMsg.Code );
                mfunc = (void *) (GTMENUITEM_USERDATA( n ));
                running = mfunc();
                ICMMsg.Code = n->NextSelect;
                }
*/             
             break;
          }
       }

   return( running );
}

PRIVATE void ShowHelpReq( void )
{
   char msg[] =    

    "I Ching operating instructions:\n"
    "From WorkBench, once the program is running, select the New Hexagram\n"
    "menu entry & enter the # of heads for the 6 tosses of 3 coins,\n"
    "then press the DONE! button on the requester to see your fortune.\n\n"
    "From the CLI, either enter the 6 coin tosses as command arguments,\n"
    "or wait for the program to prompt you for the 6 numbers from the\n"
    "CLI you invoked I Ching from.\n\n"
    "Next Hexagram menu entry will change 0 or 3-head line entries to the\n"
    "opposite type of line; 1 & 2-head entries do not change.\n";

   UserInfo( msg, "I Ching Instructions:" );
   
   return;
}

PRIVATE void *processToolTypes( char **toolptr )
{
   if (toolptr == NULL)
      return( NULL );

   TTTextFile = GetToolStr( toolptr, TextFile,  DefTextFile );

   return( NULL );
}

PRIVATE void ShutdownProgram( void )
{
   CloseICMWindow();
   CloseDownScreen();
   CloseLibs();

   return;
}

PRIVATE int SetupProgram( void )
{
   if (OpenLibs() < 0)
      return( -1 );

   if ((IconBase = OpenLibrary( ICONNAME, 0L )) == NULL)
      {
      CloseLibs();
      return( -2 );
      }
      
   if (SetupScreen() < 0)
      {
      ShutdownProgram();
      return( -3 );
      }
      
   if (OpenICMWindow() < 0)
      {
      ShutdownProgram();
      return( -4 );
      }

   return( 0 );
}

PUBLIC int main( int argc, char **argv )
{
   extern struct IntuiText pg[];

   struct WBArg  *wbarg;
   char         **toolptr = NULL;
   int            i;

   if (SetupProgram() < 0)
      return( IoErr() );
      
   if (argc > 0)    /* from CLI:       */
      {
      // We prefer to use the ToolTypes: 
      (void) FindIcon( &processToolTypes, diskobj, argv[0] );
      
      if (argc == 1)
         {
         if (ReadTextFile( TTTextFile ) < 0)
            {
            fprintf( stderr, "Couldn't find %s file to read!\n\n", 
                             TTTextFile 
                   );

            ShutdownProgram();
            return( ERROR_OBJECT_NOT_FOUND );
            }
            
         ScreenToBack( Scr );
         enter_heads();
         ScreenToFront( Scr );
         }
      else if (argc == 7)
         {
         if (ReadTextFile( TTTextFile ) < 0)
            {
            fprintf( stderr, "Couldn't find %s file to read!\n\n", 
                             TTTextFile 
                   );

            ShutdownProgram();
            return( ERROR_OBJECT_NOT_FOUND );
            }
   
         for (i = 0; i < 6; i++)
            line_val1[i] = atoi( argv[i + 1] );
         }
      else
         {
         fprintf( stderr, "USAGE: %s [h1 h2 h3 h4 h5 h6]\n", argv[0] );
         ShutdownProgram();
         return( ERROR_REQUIRED_ARG_MISSING );
         }

      process_heads( &line_type1[0], &line_val1[0] );
      make_next_hexagram();
      determine_index( &index1, &line_type1[0] );
      determine_index( &index2, &line_type2[0] );
      get_trigrams();
      }
   else             /* from Workbench: */
      {
      wbarg   = &(_WBenchMsg->sm_ArgList[ _WBenchMsg->sm_NumArgs - 1 ]);
      toolptr = FindTools( diskobj, wbarg->wa_Name, wbarg->wa_Lock );

      processToolTypes( toolptr );

      if (ReadTextFile( TTTextFile ) < 0)
         {
         fprintf( stderr, "Couldn't find %s file to read!\n\n", 
                          TTTextFile 
                );

         ShutdownProgram();
         return( ERROR_OBJECT_NOT_FOUND );
         }
      }
    
   SetNotifyWindow( ICMWnd );
   
   Display( &line_type1[0], index1 );

   ShowHelpReq();
   
   (void) HandleICMIDCMP();

   ShutdownProgram();
   DeallocateStrings( pg );
         
   FreeDiskObject( diskobj );
   CloseLibrary( IconBase );
   
   return( RETURN_OK );
}

/* ------------------ END of IChing.c file! ----------------------- */
