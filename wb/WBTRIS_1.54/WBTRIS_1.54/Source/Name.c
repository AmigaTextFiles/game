#include "WBTRIS.h"

#define GD_Gadget00     0
#define GDX_Gadget00    0
#define Project0_CNT    1

extern struct Screen         *myscreen;
extern APTR                   VisualInfo;
struct Window         *Project0Wnd = NULL;
struct Gadget         *Project0GList = NULL;
struct Gadget         *Project0Gadgets[1];
struct Gadget         *g = NULL;
UWORD                  Project0Left = 68;
UWORD                  Project0Top = 127;
UWORD                  Project0Width = 225;
UWORD                  Project0Height = 61;
UBYTE                 *Project0Wdt = NULL; /*(UBYTE *)"Give me your name";*/

extern struct TextAttr helvetica13;

UWORD Project0GTypes[] = {
    STRING_KIND
};

struct NewGadget Project0NGad[] = {
    29, 17, 156, 21, (UBYTE *)"Enter you name", NULL, GD_Gadget00, PLACETEXT_ABOVE ,NULL, NULL
};

ULONG Project0GTags[] = {
    (GTST_MaxChars), 25, (TAG_DONE)
};

int OpenProject0Window( void )
{
    struct NewGadget     ng;
    UWORD                lc, tc;
    UWORD                offx = myscreen->WBorLeft, offy = myscreen->WBorTop + myscreen->RastPort.TxHeight + 1;

    if ( ! ( g = CreateContext( &Project0GList )))
        return( 1L );

    for( lc = 0, tc = 0; lc < Project0_CNT; lc++ ) {

        CopyMem((char * )&Project0NGad[ lc ], (char * )&ng, (long)sizeof( struct NewGadget ));

        ng.ng_VisualInfo = VisualInfo;
        ng.ng_TextAttr   = &helvetica13;
        ng.ng_LeftEdge  += offx;
        ng.ng_TopEdge   += offy;

        Project0Gadgets[ lc ] = g = CreateGadgetA((ULONG)Project0GTypes[ lc ], g, &ng, ( struct TagItem * )&Project0GTags[ tc ] );

        while( Project0GTags[ tc ] ) tc += 2;
        tc++;

        if ( NOT g )
        return( 2L );
    }

    if ( ! ( Project0Wnd = OpenWindowTags( NULL,
                    WA_Left,          Project0Left,
                    WA_Top,           Project0Top,
                    WA_Width,         Project0Width,
                    WA_Height,        Project0Height + offy,
                    WA_IDCMP,         STRINGIDCMP | IDCMP_REFRESHWINDOW | IDCMP_ACTIVEWINDOW,
                    WA_Flags,         WFLG_SMART_REFRESH | WFLG_ACTIVATE,
                    WA_Gadgets,       Project0GList,
                    WA_Title,         Project0Wdt,
                    TAG_DONE )))
        return( 4L );

    GT_RefreshWindow( Project0Wnd, NULL );

    return( 0L );
}

void CloseProject0Window( void )
{
    if ( Project0Wnd        ) {
        CloseWindow( Project0Wnd );
        Project0Wnd = NULL;
    }

    if ( Project0GList      ) {
        FreeGadgets( Project0GList );
        Project0GList = NULL;
    }
}




void AskForName(void)
{
   BOOL                 Done = FALSE;
   struct IntuiMessage *imsg = NULL;
   extern struct RastPort *rp;
   extern short          MAINXOFFSET;
   extern short          boxxsize;
   extern short          boxysize;
   extern BOOL           UseLace;
   extern char           Name[25];


   OpenProject0Window();

   while(!Done)
   {
      Wait(1L << Project0Wnd->UserPort->mp_SigBit);

      while (imsg = (struct IntuiMessage *)GetMsg(Project0Wnd->UserPort)) {
         switch(imsg->Class) {
            case IDCMP_ACTIVEWINDOW:
               ActivateGadget(Project0Gadgets[0], Project0Wnd, NULL);
               break;
            case IDCMP_REFRESHWINDOW:
               GT_BeginRefresh(Project0Wnd);
               GT_EndRefresh(Project0Wnd, TRUE);
               break;

            case IDCMP_GADGETUP:
               if (g->GadgetID == GD_Gadget00)
                  if (strlen(((struct StringInfo *)g->SpecialInfo)->Buffer) != 0) {
                     strcpy(Name, ((struct StringInfo *)g->SpecialInfo)->Buffer);
                     Done = TRUE;
                  } else
                     ActivateGadget(Project0Gadgets[0], Project0Wnd, NULL);
               break;
         }
         ReplyMsg((struct Message *) imsg);
      }
   }

   CloseProject0Window();
}
