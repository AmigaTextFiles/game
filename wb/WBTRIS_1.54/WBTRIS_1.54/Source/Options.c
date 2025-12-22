#include "WBTRIS.h"

#define GD_SLIDER   0
#define GD_STRING   1
#define GD_CYCLE    2
#define GD_CHECK    3
#define GD_SLIDER2  4
#define GD_BUTTON1  5
#define GD_BUTTON2  6

#define GDX_SLIDER  0
#define GDX_STRING  1
#define GDX_CYCLE   2
#define GDX_CHECK   3
#define GDX_SLIDER2 4
#define GDX_BUTTON1 5
#define GDX_BUTTON2 6

#define Options_CNT 7

struct Window         *OptionsWnd = NULL;
struct Gadget         *OptionsGList = NULL;
struct Gadget         *OptionsGadgets[7];
UWORD                  OptionsLeft = 119;
UWORD                  OptionsTop = 125;
UWORD                  OptionsWidth;
UWORD                  OptionsHeight;
UBYTE                 *OptionsWdt = (UBYTE *)"WBTRIS Options";
struct TextAttr       *Font = NULL;
struct TextAttr        Attr;
UWORD                  FontX, FontY;
UWORD                  OffX, OffY;

extern struct Screen  *myscreen;
extern APTR            VisualInfo;
extern struct GfxBase *GfxBase;
extern struct TextAttr helvetica13;
extern struct TextAttr topaz8;
extern BOOL            UseLace;

extern char            Name[25];
extern BOOL            lockname;
extern BOOL            nextteil;
extern int             LevelOffset;
extern int             pulldownticks;

struct EasyStruct myES = {
    sizeof(struct EasyStruct),
    0,
    "WBTRIS INFO",
    "%s Version %s\n\n© 1993 by \n%s\n\nThis game is 'Cardware'!\nPlease read the manual for explanation.",
    "OK",
};

UBYTE *CYCLE0Labels[] = {
    (UBYTE *)"Lock Name",
    (UBYTE *)"Ask Name",
    NULL };

UWORD OptionsGTypes[] = {
    SLIDER_KIND,
    STRING_KIND,
    CYCLE_KIND,
    CHECKBOX_KIND,
    SLIDER_KIND,
    BUTTON_KIND,
    BUTTON_KIND
};

struct NewGadget OptionsNGad[] = {
     33,  25, 200, 17, (UBYTE *)"Startlevel", NULL, GD_SLIDER, PLACETEXT_RIGHT, NULL, NULL,
     33,  85, 200, 17, (UBYTE *)"Name", NULL, GD_STRING, PLACETEXT_RIGHT, NULL, NULL,
     33, 110, 111, 17, (UBYTE *)"Nameoptions", NULL, GD_CYCLE, PLACETEXT_RIGHT, NULL, NULL,
    133, 145,  26, 17, (UBYTE *)"Show next object", NULL, GD_CHECK, PLACETEXT_RIGHT ,NULL, NULL,
     33,  50, 200, 17, (UBYTE *)"Pulldownspeed", NULL, GD_SLIDER2, PLACETEXT_RIGHT ,NULL, NULL,
     33, 145,  71, 17, (UBYTE *)"Info", NULL, GD_BUTTON1, PLACETEXT_IN ,NULL, NULL,
     33, 170,  71, 17, (UBYTE *)"OK", NULL, GD_BUTTON2, PLACETEXT_IN ,NULL, NULL
};

ULONG OptionsGTags[] = {
    (GTSL_Max), 20, (GTSL_MaxLevelLen), 2, (GTSL_LevelFormat), (ULONG)"%2ld", (PGA_Freedom), LORIENT_HORIZ, (GA_RelVerify), TRUE, (TAG_DONE),
    (GTST_MaxChars), 20, (TAG_DONE),
    (GTCY_Labels), (ULONG)&CYCLE0Labels[0], (TAG_DONE),
    (GTCB_Checked), TRUE, (TAG_DONE),
    (GTSL_Max), 20, (GTSL_Level), 20, (GTSL_MaxLevelLen), 2, (GTSL_LevelFormat), (ULONG)"%2ld", (PGA_Freedom), LORIENT_HORIZ, (GA_RelVerify), TRUE, (TAG_DONE),
    (GA_Disabled), FALSE, (TAG_DONE),
    (TAG_DONE)
};



int OpenOptionsWindow(void)
{
    struct NewGadget  ng;
    struct Gadget    *g = NULL;
    UWORD             lc, tc;
    UWORD             wleft = OptionsLeft, wtop = OptionsTop;
    UWORD             ww, wh = 195;

   if (UseLace)
      ww = 337;
   else
      ww= 367;

    if ( ! ( g = CreateContext( &OptionsGList )))
        return( 1L );

    for( lc = 0, tc = 0; lc < Options_CNT; lc++ ) {

        CopyMem((char * )&OptionsNGad[ lc ], (char * )&ng, (long)sizeof( struct NewGadget ));

        ng.ng_VisualInfo = VisualInfo;

        if (UseLace)
           ng.ng_TextAttr   = &helvetica13;
        else
           ng.ng_TextAttr   = &topaz8;

        ng.ng_LeftEdge   = ng.ng_LeftEdge;
        ng.ng_TopEdge    = ng.ng_TopEdge+(myscreen->Font->ta_YSize)-10;
        ng.ng_Width      = ng.ng_Width;
        ng.ng_Height     = ng.ng_Height;

        OptionsGadgets[ lc ] = g = CreateGadgetA((ULONG)OptionsGTypes[ lc ], g, &ng, ( struct TagItem * )&OptionsGTags[ tc ] );

        while( OptionsGTags[ tc ] ) tc += 2;
        tc++;

        if ( NOT g )
        return( 2L );
    }

    if ( ! ( OptionsWnd = OpenWindowTags( NULL,
                    WA_Left,          wleft,
                    WA_Top,           wtop+(myscreen->Font->ta_YSize)+3,
                    WA_Width,         ww,
                    WA_Height,        wh+(myscreen->Font->ta_YSize),
                    WA_IDCMP,         SLIDERIDCMP|STRINGIDCMP|CYCLEIDCMP|CHECKBOXIDCMP|BUTTONIDCMP|IDCMP_CLOSEWINDOW|IDCMP_REFRESHWINDOW | IDCMP_ACTIVEWINDOW | IDCMP_RAWKEY,
                    WA_Flags,         WFLG_DRAGBAR|WFLG_DEPTHGADGET|WFLG_CLOSEGADGET|WFLG_SMART_REFRESH|WFLG_SIMPLE_REFRESH|WFLG_ACTIVATE,
                    WA_Gadgets,       OptionsGList,
                    WA_Title,         OptionsWdt,
                    TAG_DONE )))
        return( 4L );

    GT_SetGadgetAttrs(OptionsGadgets[GD_SLIDER], OptionsWnd, NULL,
                      GTSL_Level, LevelOffset,
                      TAG_END);
    GT_SetGadgetAttrs(OptionsGadgets[GD_STRING], OptionsWnd, NULL,
                      GTST_String, Name,
                      TAG_END);
    GT_SetGadgetAttrs(OptionsGadgets[GD_SLIDER2], OptionsWnd, NULL,
                      GTSL_Level, 20-pulldownticks*2,
                      TAG_END);
    GT_SetGadgetAttrs(OptionsGadgets[GD_CHECK], OptionsWnd, NULL,
                      GTCB_Checked, nextteil,
                      TAG_END);
    GT_SetGadgetAttrs(OptionsGadgets[GD_CYCLE], OptionsWnd, NULL,
                      GTCY_Active, !lockname,
                      TAG_END);
    GT_RefreshWindow( OptionsWnd, NULL );

    return( 0L );
}

void CloseOptionsWindow( void )
{
    if (OptionsWnd) {
        CloseWindow( OptionsWnd );
        OptionsWnd = NULL;
    }

    if (OptionsGList) {
        FreeGadgets( OptionsGList );
        OptionsGList = NULL;
    }
}



/*
** Function to handle a GADGETUP or GADGETDOWN event.  For GadTools gadgets,
** it is possible to use this function to handle MOUSEMOVEs as well, with
** little or no work.
*/
BOOL handleGadgetEvent(struct Window *win, struct Gadget *gad, UWORD code, struct Gadget *my_gads[])
{
   switch (gad->GadgetID) {
      case GD_SLIDER:
          LevelOffset = code;
          break;
      case GD_SLIDER2:
          pulldownticks = (20-code)/2;
          break;
      case GD_STRING:
          strcpy(Name, ((struct StringInfo *)gad->SpecialInfo)->Buffer);
          break;
      case GD_BUTTON1:
          EasyRequest(NULL, &myES, NULL, PROG_NAME, VERSION, AUTHOR);
          break;
      case GD_BUTTON2:
          return(TRUE);
          break;
      case GD_CYCLE:
          if (code == 0)
             lockname = TRUE;
          else
             lockname = FALSE;
          break;
      case GD_CHECK:
          nextteil = !nextteil;
          break;
   }
   return(FALSE);
}


/*
** Standard message handling loop with GadTools message handling functions
** used (GT_GetIMsg() and GT_ReplyIMsg()).
*/
VOID process_window_events(struct Window *mywin, struct Gadget *my_gads[])
{
   struct IntuiMessage *imsg = NULL;
   ULONG                imsgClass;
   UWORD                imsgCode;
   struct Gadget       *gad = NULL;
   BOOL                 terminated = FALSE;

   while (!terminated) {
      Wait (1 << mywin->UserPort->mp_SigBit);

      while ((!terminated) && (imsg = GT_GetIMsg(mywin->UserPort))) {
         gad = (struct Gadget *)imsg->IAddress;

         imsgClass = imsg->Class;
         imsgCode = imsg->Code;

         GT_ReplyIMsg(imsg);

         switch (imsgClass) {
            case IDCMP_ACTIVEWINDOW:
               ActivateGadget(OptionsGadgets[1], mywin, NULL);
               break;
            case IDCMP_GADGETDOWN:
            case IDCMP_GADGETUP:
               terminated = handleGadgetEvent(mywin, gad, imsgCode, my_gads);
               break;
            case IDCMP_RAWKEY:
               if (imsg->Code == '\x45')
                  terminated = TRUE;
               break;
            case IDCMP_CLOSEWINDOW:
               terminated = TRUE;
               break;
            case IDCMP_REFRESHWINDOW:
               GT_BeginRefresh(mywin);
               GT_EndRefresh(mywin, TRUE);
               break;
         }
      }
   }
}



/*
** Open all libraries and run.  Clean up when finished or on error..
*/
void OpenOptions(WORD winxpos, WORD winypos)
{
   OptionsLeft = winxpos;
   OptionsTop = winypos;

   if (UseLace)
      OptionsWidth = 313;
   else
      OptionsWidth = 363;

   if (lockname == FALSE)
      strcpy(Name, "");


   if (OpenOptionsWindow() == 0L) {
      process_window_events(OptionsWnd, OptionsGadgets);
      CloseOptionsWindow();
   }
}
