/*
 * main.c V1.1
 *
 * Crazy Clock main entry point
 *
 * (c) 1992-1993 Holger Brunst
 */

#include <CClock.h>

/* Version string */
static const char   version[] = "\0$VER: CrazyClock "VERSION"."REVISION" ("DATE")\r\n";

/* Use 3D look */
static const UWORD  new3d[] = {~0};
static ULONG        displayID = HIRES_KEY;

/* Garnet font pointer */
static struct TextFont  *grntFont;

/* Main entry point of Crazy Clock */
LONG main(void)
{
 BOOL   goOn = TRUE;
 ULONG  idcmpSigMsk;
 struct IntuiMessage    *msg;
 
 /* Get garnet-Font */
 if (grntFont = (struct TextFont *) OpenDiskFont(&GrntAttr)) {
  /* NTSC monitor available? */ 
  if (!ModeNotAvailable(NTSC_MONITOR_ID))
   /* Yes, add NTSC-ID to displayID */
   displayID |= NTSC_MONITOR_ID;
  /* Open clock screen */
  if (Screen = OpenScreenTags(NULL, SA_Title, GAME_NAME,
                                    SA_Width, 640,
                                    SA_Height, 200,
                                    SA_DisplayID, displayID,
                                    SA_Depth, 4,
                                    SA_PubName, GAME_NAME" Screen",
                                    SA_Type, PUBLICSCREEN,
                                    SA_Pens, new3d,
                                    SA_Font, &GrntAttr,
                                    SA_ShowTitle, FALSE,
                                    TAG_DONE)) {
   /* Get visual info */
   if (ScreenVI = GetVisualInfo(Screen, TAG_DONE)) {
    /* Open clock window */
    if (idcmpSigMsk = OpenClockWindow()) {
     /* Increase task priority (not necessary) */
     SetTaskPri(FindTask(NULL), 1);

     /* Get highscore */
     LoadHighScore();

     /* Input event handling */ 
     while (goOn) {

      /* Wait for IDCMP signals */ 
      Wait(idcmpSigMsk);

      /* Read IDCMP messages */
      while (msg = GT_GetIMsg(IDCMPPort)) {
       void *data;
       HandleIDCMPFunc *func = msg->IDCMPWindow->UserData;

       /* Handle IDCMP message. Window closed? */
       if (data = (*func)(msg))
        /* Yes. Update window? */
        if (UpdateWindow)
         /* Yes, update window */
         (*UpdateWindow)(data);
        else
         /* No, quit */
         goOn = FALSE;
       else
        /* No, reply message */
        GT_ReplyIMsg(msg);
      }
     }
     /* Free resources */
     SaveHighScore();
     CloseClockWindow();
    }
    FreeVisualInfo(ScreenVI);
   }
   CloseScreen(Screen);
  }
  CloseFont(grntFont);
 }
 return (NULL);
}

/* WB entry point */
int wbmain(struct WBStartup *wbs)
{
 return(main());
}
