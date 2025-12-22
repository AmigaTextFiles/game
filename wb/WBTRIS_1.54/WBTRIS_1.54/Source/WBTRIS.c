/*
   *******************************************************************************
   *                                                                             *
   *                                                                             *
   *     WW            WW  BBBBBBBB  TTTTTTTTTT  RRRRRRRR   II     SSSSSSS       *
   *     WW            WW  BB     BB     TT      RR     RR  II    SS     SS      *
   *      WW    WW    WW   BB     BB     TT      RR     RR  II    SS             *
   *      WW   WWWW   WW   BBBBBBB       TT      RR   RRR   II     SSSSSSS       *
   *       WW WW  WW WW    BB    BB      TT      RRRRRR     II           SS      *
   *       WWWW    WWWW    BB     BB     TT      RR   RR    II           SS      *
   *        WWW    WWW     BB     BB     TT      RR    RR   II    SS     SS      *
   *        WW      WW     BBBBBBBB      TT      RR     RR  II     SSSSSSS       *
   *                                                                             *
   *                                                                             *
   *          COPYRIGHT © 1993 by Dirk Böhmer  ( medusa@uni-paderborn.de )       *
   *                                                                             *
   *                            & Ralf Pieper                                    *
   *                                                                             *
   *          All rights reserved.                                               *
   *                                                                             *
   *                                                                             *
   *******************************************************************************
*/

#include "WBTRIS.h"

#define SHOWHISCORE TRUE
#define SAVEHISCORE FALSE
#define RIGHTFIELD TRUE
#define LEFTFIELD FALSE

/*#define TEMPLATE "LEFT=LEFTEDGE/N/K,TOP=TOPEDGE/N/K,N=NAME/K,NOLOCK=NOLOCKNAME/K/S\
,NONEXT=SHOWNONEXT/K/S,NOLACE/K/S,LEVEL/N/K\
,PULLDOWNTICKS/N/K\
,R=MOVERIGHT/K,L=MOVELEFT/K,RR=ROTATERIGHT/K,RL=ROTATELEFT/K\
,D=MOVEDOWN/K,DQ=MOVEDOWNQUICK/K,TP=TWOPLAYER/K/S" */

#define TEMPLATE "LEFT=LEFTEDGE/N/K,TOP=TOPEDGE/N/K,N=NAME/K,NOLOCK=NOLOCKNAME/K/S\
,NONEXT=SHOWNONEXT/K/S,NOLACE/K/S,LEVEL/N/K\
,PULLDOWNTICKS/N/K\
,R=MOVERIGHT/K,L=MOVELEFT/K,RR=ROTATERIGHT/K,RL=ROTATELEFT/K\
,D=MOVEDOWN/K,DQ=MOVEDOWNQUICK/K,TF=TILEFILE/K"


extern struct Image Pausebrush;
extern struct Image logo;

extern struct Image Gruen;
extern struct Image GruenWeiss;
extern struct Image GruenWeissSchach;
extern struct Image GruenWeissSchraeg;
extern struct Image Schwarz;
extern struct Image SchwarzGruen;
extern struct Image SchwarzWeiss;

extern struct Image GruenNI;
extern struct Image GruenWeissNI;
extern struct Image GruenWeissSchachNI;
extern struct Image GruenWeissSchraegNI;
extern struct Image SchwarzNI;
extern struct Image SchwarzGruenNI;
extern struct Image SchwarzWeissNI;

char versionstring[] = "\0$VER: " PROG_NAME VERSION " " "von " AUTHOR;

UBYTE *CYCLELabels[] = {
    (UBYTE *)"Pause",
    (UBYTE *)"Go on",
    NULL };
;

struct obj {
  BOOL objData[4][4];
  int color;
};

struct obj objects[8];
struct obj objects2[8];

int field[YSIZE+1][XSIZE+2] = {
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
                     };

int field2[YSIZE+1][XSIZE+2] = {
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1},
                        {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
                     };

int            FieldsSpace = 125;
short          YOffSet = YOFFSET;
short          LGXOS;
short          BOXXSIZE;
short          BOXYSIZE;
short          NEXTXOFFSET;
short          MAINXOFFSET;
BOOL           UseLace = TRUE;
BOOL           TwoPlayer = FALSE;
short          boxxsize;
short          boxysize;
int            Highscore;
int            Score = 0;
int            Lines = 0;
int            time = DEFAULTTICKS;
int            oldtime = DEFAULTTICKS;
int            x = XSIZE/2;
int            y = 0;
int            time2 = DEFAULTTICKS;
int            oldtime2 = DEFAULTTICKS;
int            x2 = XSIZE/2;
int            y2 = 0;
UWORD          CursorUp    = CURSOR_UP,    CursorUp2    = CURSOR_UP2;
UWORD          CursorDown  = CURSOR_DOWN,  CursorDown2  = CURSOR_DOWN2;
UWORD          CursorLeft  = CURSOR_LEFT,  CursorLeft2  = CURSOR_LEFT2;
UWORD          CursorRight = CURSOR_RIGHT, CursorRight2 = CURSOR_RIGHT2;
UWORD          NormalSpace = SPACE   ,     NormalSpace2 = SPACE2;
UWORD          QuickSpace  = QUICKSPACE,   QuickSpace2  = QUICKSPACE2;

/* Timer */
BYTE                 TimerError = 0 ,  TimerError2 = 0 ;
struct MsgPort      *TimerMP = NULL , *TimerMP2 = NULL ;
struct timerequest  *TimerIO = NULL , *TimerIO2 = NULL ;
struct Message      *TimerMSG = NULL, *TimerMSG2 = NULL;

/* Options */
char        Name[25];
BOOL        SpacePressed = FALSE, SpacePressed2 = FALSE;
BOOL        lockname = TRUE;
BOOL        nextteil = TRUE;
int         LevelOffset = 0;
int         pulldownticks = 0;
int         WBTRIS_Window_Top = MAINWINDOWTOP;
int         WBTRIS_Window_Left= MAINWINDOWLEFT;

struct RastPort   *rp = NULL;
struct Library    *IntuitionBase = NULL;
struct Library    *KeymapBase    = NULL;
struct Library    *IconBase      = NULL;
struct Window     *window        = NULL;
struct obj        *objptr        = NULL;
struct obj        *nextptr       = NULL;
struct obj        *objptr2       = NULL;
struct obj        *nextptr2      = NULL;
struct Screen     *myscreen      = NULL;
struct TextFont   *font = NULL, *font2 = NULL;

int LineCounter = 0;
int Level;

struct TextAttr helvetica13 = {"helvetica.font", 13, 0, 0};
struct TextAttr topaz8 = {"topaz.font", 8, 0, 0};

APTR           VisualInfo = NULL;
struct Gadget *TetrisGList = NULL;
struct Gadget *TetrisGadgets[9];
BOOL           vonoptions = TRUE;
char           TileFile[80];

int obj1 = 0;
int obj2 = 0;
int obj3 = 0;
int obj4 = 0;
int obj5 = 0;
int obj6 = 0;
int obj7 = 0;




int wbmain(struct WBStartup *wbs)
{
   struct DiskObject *dobj = NULL;
   char             **toolsarray;
   char              *s = NULL;
   char              *tail = NULL;

   strcpy(TileFile, "");

   if ((IconBase = OpenLibrary("icon.library", 37l)) == NULL)
      exit(FALSE);

   CurrentDir(wbs->sm_ArgList->wa_Lock);
   if (dobj = (struct DiskObject *) GetDiskObject(wbs->sm_ArgList->wa_Name)) {
      toolsarray = (char **) dobj->do_ToolTypes;

      if (s = (char *) FindToolType(toolsarray, "LEFTEDGE"))
         WBTRIS_Window_Left = atoi(s);
      if (s = (char *) FindToolType(toolsarray, "TOPEDGE"))
         WBTRIS_Window_Top = atoi(s);
      if (s = (char *) FindToolType(toolsarray, "NAME"))
         strcpy(Name, s);
      if (s = (char *) FindToolType(toolsarray, "LOCKNAME")) {
         if ((strcmp(s, "TRUE")) == NULL)
            lockname = TRUE;
         else
            lockname = FALSE;
      }
      if (s = (char *) FindToolType(toolsarray, "SHOWNEXT")) {
         if ((strcmp(s, "TRUE")) == NULL)
            nextteil = TRUE;
         else
            nextteil = FALSE;
      }
      if (s = (char *) FindToolType(toolsarray, "USELACE")) {
         if ((strcmp(s, "TRUE")) == NULL)
            UseLace = TRUE;
         else
            UseLace = FALSE;
      }
/*      if (s = (char *) FindToolType(toolsarray, "TWOPLAYER")) {
         if ((strcmp(s, "TRUE")) == NULL)
            TwoPlayer = TRUE;
         else
            TwoPlayer = FALSE;
      }
*/
      if (s = (char *) FindToolType(toolsarray, "LEVEL"))
         LevelOffset = atoi(s);
      if (s = (char *) FindToolType(toolsarray, "PULLDOWNSPEED"))
         pulldownticks = (20 - atoi(s))/2;

      if (s = (char *) FindToolType(toolsarray, "MOVERIGHT"))
         CursorRight = strtol(s, &tail, 0);
      if (s = (char *) FindToolType(toolsarray, "MOVELEFT"))
         CursorLeft  = strtol(s, &tail, 0);
      if (s = (char *) FindToolType(toolsarray, "ROTATERIGHT"))
         CursorUp    = strtol(s, &tail, 0);
      if (s = (char *) FindToolType(toolsarray, "ROTATELEFT"))
         CursorDown  = strtol(s, &tail, 0);
      if (s = (char *) FindToolType(toolsarray, "MOVEDOWN"))
         NormalSpace = strtol(s, &tail, 0);
      if (s = (char *) FindToolType(toolsarray, "MOVEDOWNQUICK"))
         QuickSpace  = strtol(s, &tail, 0);
      if (s = (char *) FindToolType(toolsarray, "TILEFILE"))
         strcpy(TileFile, s);

      FreeDiskObject(dobj);
   }

   if (IconBase)
      CloseLibrary(IconBase);
   Real_Main();
   return(0);
}



int main(void)
{
   int            i;
/*   long           options[15];*/
   long           options[15];
   struct RDArgs *args = NULL;

   for (i=0; i<15; i++)
      options[i] = 0L;

/*   for (i=0; i<15; i++)
      options[i] = 0L;
*/

   strcpy(TileFile, "");

   args = ReadArgs(TEMPLATE, options, NULL);

   if (args) {
      if (options[0])
         WBTRIS_Window_Left = *(int *) options[0];
      if (options[1])
         WBTRIS_Window_Top = *(int *) options[1];
      if (options[2])
         strcpy(Name, (char *) options[2]);
      if (options[3])
         lockname = !options[3];
      if (options[4])
         nextteil = options[4];
      if (options[5])
         UseLace = !options[5];
      if (options[6])
         LevelOffset = *(int *) options[6];
      if (options[7])
         pulldownticks = (20 - *(int *) options[7])/2;
      if (options[8])
         CursorRight = (UWORD) strtol((char *) options[8], NULL, 0);
      if (options[9])
         CursorLeft = (UWORD) strtol((char *) options[9], NULL, 0);
      if (options[10])
         CursorUp = (UWORD) strtol((char *) options[10], NULL, 0);
      if (options[11])
         CursorDown = (UWORD) strtol((char *) options[11], NULL, 0);
      if (options[12])
         NormalSpace = (UWORD) strtol((char *) options[12], NULL, 0);
      if (options[13])
         QuickSpace = (UWORD) strtol((char *) options[13], NULL, 0);
      if (options[14])
         strcpy(TileFile, (char *) options[14]);
/*      if (options[14])
         TwoPlayer = options[14];*/
   }
   if (args)
      FreeArgs(args);

   Real_Main();
   return(0);
}



int Real_Main(void)
{
   struct IntuiMessage *imsg = NULL;
   struct InputEvent    inputevent = {0};
   struct Gadget       *gad = NULL;
   LONG                 windowsignal, timersignal, timersignal2;
   BOOL                 Done = FALSE;
   APTR                *eventptr = NULL;
   long                 mask;
   struct I0ExtSer     *reply = NULL;
   WORD                 Width, Height;
   char                 WindowTitle[80];
   struct EasyStruct AskQuit = {
       sizeof(struct EasyStruct),
       0,
       "Quit",
       "Do you really want to quit?",
       "Yes|Oops!",
   };

   InitObjects();
   openall();                    /* open Fonts, Libraries, VisualInfo, etc*/

   /* build windowtitle */
   strcpy(WindowTitle, PROG_NAME);
   strcat(WindowTitle, VERSION);

   if (UseLace) {
      LGXOS = 5;
      boxxsize = BOXXSIZE = 18;
      boxysize = BOXYSIZE = 16;
      NEXTXOFFSET = 14;
      MAINXOFFSET = 122;
   } else {
      LGXOS = 15;
      boxxsize = BOXXSIZE = 16;
      boxysize = BOXYSIZE = 8;
      NEXTXOFFSET = 155;
      MAINXOFFSET = 252;
   }

   YOffSet = YOFFSET + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
   if (TwoPlayer) {
      Width = 2*(XSIZE*boxxsize) + 30 + MAINXOFFSET + FieldsSpace;
      Height = YSIZE*boxysize + 11 + YOffSet;
   } else {
      Width = XSIZE*boxxsize + 35 + MAINXOFFSET;
      Height = YSIZE*boxysize + 11 + YOffSet;
   }

   gad = CreateAllGadgets(myscreen);

   window = OpenWindowTags(NULL,
                            WA_Left,    WBTRIS_Window_Left,
                            WA_Top,     WBTRIS_Window_Top,
                            WA_Width,   Width,
                            WA_Height,  Height,
                            WA_ScreenTitle, "WBTRIS",
                            WA_Title,   WindowTitle,
                            WA_Flags,   WFLG_CLOSEGADGET | WFLG_ACTIVATE | WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_RMBTRAP,
                            WA_Gadgets, TetrisGList,
                            WA_IDCMP,   BUTTONIDCMP | NUMBERIDCMP | IDCMP_REFRESHWINDOW | IDCMP_RAWKEY | IDCMP_CLOSEWINDOW
                                      | WFLG_DEPTHGADGET | WFLG_SMART_REFRESH  | IDCMP_ACTIVEWINDOW | IDCMP_INACTIVEWINDOW,
                            TAG_DONE);

   if (window == NULL)
      closeout("Can't open window",RETURN_FAIL);

   rp = window->RPort;
   Level = LevelOffset;

   x = XSIZE/2 - 1;
   oldtime = time = DEFAULTTICKS - Level*2;
   nextptr = RandomObject(LEFTFIELD);
   objptr = RandomObject(LEFTFIELD);
   y = 0;
   if (InFirstLine(objptr) == TRUE)
      y = 1;
   if (nextteil == TRUE)
      Draw_NextObject(nextptr, LEFTFIELD);

   if (TwoPlayer) {
      x2 = XSIZE/2 - 1;
      oldtime2 = time2 = DEFAULTTICKS - Level*2;
      nextptr2 = RandomObject(RIGHTFIELD);
      objptr2 = RandomObject(RIGHTFIELD);
      y2 = 0;
      if (InFirstLine(objptr2) == TRUE)
         y2 = 1;
      if (nextteil == TRUE)
         Draw_NextObject(nextptr2, RIGHTFIELD);
   }

   GT_RefreshWindow( window, NULL );

   DrawWindow();


   timersignal  = 1L << TimerMP->mp_SigBit;
   windowsignal = 1L << window->UserPort->mp_SigBit;

   /* Initialize InputEvent structure (already cleared to 0) */
   inputevent.ie_Class = IECLASS_RAWKEY;

   Highscore = Loadhiscore();

   GT_SetGadgetAttrs(TetrisGadgets[GD_HighscoreGadget], window, NULL,
                          GTNM_Number, (ULONG)Highscore,
                          TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_LevelGadget], window, NULL,
                          GTNM_Number, (ULONG)Level, TAG_END);

   TimerIO->tr_node.io_Command = TR_ADDREQUEST;
   TimerIO->tr_time.tv_secs = 0;
   TimerIO->tr_time.tv_micro = time * 20000;
   SendIO((struct IORequest *) TimerIO);

   if (TwoPlayer) {
      timersignal2  = 1L << TimerMP2->mp_SigBit;
      TimerIO2->tr_node.io_Command = TR_ADDREQUEST;
      TimerIO2->tr_time.tv_secs = 0;
      TimerIO2->tr_time.tv_micro = time2 * 20000;
      SendIO((struct IORequest *) TimerIO2);
   }

   while(!Done) {
      if (TwoPlayer)
         mask = Wait(timersignal | timersignal2 | windowsignal);
      else
         mask = Wait(timersignal | windowsignal);

      /*
      ** Signal kommt vom Timer
      */
      if (mask & timersignal) {
         while(reply = (struct I0ExtSer *)GetMsg(TimerMP))
         {
            /* we don't need these messages */
         }
         AbortIO((struct IORequest *) TimerIO);
         WaitIO((struct IORequest *) TimerIO);
         TimerIO->tr_node.io_Command = TR_ADDREQUEST;
         TimerIO->tr_time.tv_secs = 0;
         TimerIO->tr_time.tv_micro = time * 20000;
         SendIO((struct IORequest *) TimerIO);
         if (CollisionDown(objptr, field, x, y, LEFTFIELD) == FALSE) {
            AbortIO((struct IORequest *) TimerIO);
            WaitIO((struct IORequest *) TimerIO);
            time = oldtime;
            Done = GameOver(field, lockname);
            if (Done == FALSE) {
               objptr = nextptr;
               nextptr = RandomObject(LEFTFIELD);
               y = 0 ;
               if (InFirstLine(objptr) == TRUE)
                  y = 1;

               x = XSIZE/2 - 1;
               ClearNextField(LEFTFIELD);
               if (nextteil == TRUE)
                  Draw_NextObject(nextptr, LEFTFIELD);
            }
         } else {
            Draw_Object(x, y, objptr, FALSE, LEFTFIELD);
            y = y + 1;
            Draw_Object(x, y, objptr, TRUE, LEFTFIELD);
         }
      }

      /*
      ** Signal kommt vom Timer2
      */
      if ((mask & timersignal2) && TwoPlayer) {
         while(reply = (struct I0ExtSer *)GetMsg(TimerMP2))
         {
            /* we don't need these messages */
         }
         AbortIO((struct IORequest *) TimerIO2);
         WaitIO((struct IORequest *) TimerIO2);
         TimerIO2->tr_node.io_Command = TR_ADDREQUEST;
         TimerIO2->tr_time.tv_secs = 0;
         TimerIO2->tr_time.tv_micro = time2 * 20000;
         SendIO((struct IORequest *) TimerIO2);
         if (CollisionDown(objptr2, field2, x2, y2, RIGHTFIELD) == FALSE) {
            AbortIO((struct IORequest *) TimerIO2);
            WaitIO((struct IORequest *) TimerIO2);
            time2 = oldtime2;
            Done = GameOver(field2, lockname);
            if (Done == FALSE) {
               objptr2 = nextptr2;
               nextptr2 = RandomObject(RIGHTFIELD);
               y2 = 0 ;
               if (InFirstLine(objptr2) == TRUE)
                  y2 = 1;

               x2 = XSIZE/2 - 1;
               ClearNextField(RIGHTFIELD);
               if (nextteil == TRUE)
                  Draw_NextObject(nextptr2, RIGHTFIELD);
            }
         } else {
            Draw_Object(x2, y2, objptr2, FALSE, RIGHTFIELD);
            y2 = y2 + 1;
            Draw_Object(x2, y2, objptr2, TRUE, RIGHTFIELD);
         }
      }

      /*
      ** Signal kommt von Gadgets, Fenster, Tasten, usw.
      */
      if (mask & windowsignal) {
         while (imsg = (struct IntuiMessage *)GetMsg(window->UserPort)) {
            switch(imsg->Class) {
               case IDCMP_GADGETUP:
                  gad = (struct Gadget *)imsg->IAddress;
                  switch(gad->GadgetID) {
                     case GD_PauseGadget:
                        Done = Pause();
                        break;

                     case GD_NewGadget:
                        NewGame(field, FALSE, FALSE);
                        break;

                     case GD_ShowScoreGadget:
                        HideField();
                        HiscoreList(Name, Level, Score, LineCounter, window->LeftEdge, window->TopEdge, SHOWHISCORE);
                        ReDrawField(field, LEFTFIELD);
                        ReDrawField(field2, RIGHTFIELD);
                        ClearAllMsgPorts();
                        break;

                     case GD_OptGadget:
                        OpenOptions(window->LeftEdge, window->TopEdge);
                        NewGame(field, FALSE, TRUE);
                        break;

                     case GD_StatGadget:
                        HideField();
                        statistic(window->LeftEdge, window->TopEdge, obj1, obj2, obj3, obj4, obj5, obj6, obj7);
                        ReDrawField(field, LEFTFIELD);
                        ReDrawField(field2, RIGHTFIELD);
                        ClearAllMsgPorts();
                        break;
                  }
                  break;

                  case IDCMP_REFRESHWINDOW:
                     /* This handling is REQUIRED with GadTools. */
                     GT_BeginRefresh(window);
                     GT_EndRefresh(window, TRUE);
                     break;

                  case IDCMP_INACTIVEWINDOW:
                     WaitForActivateWindow();
                     break;

                  case IDCMP_CLOSEWINDOW:
                     QuitGame();
                     break;

                  case IDCMP_RAWKEY:
                     inputevent.ie_Code = imsg->Code;
                     inputevent.ie_Qualifier = imsg->Qualifier;



                     if (imsg->Code == '\x45') {
                        if (EasyRequest(NULL, &AskQuit, NULL, NULL))
                           Done = TRUE;
                        break;
                     }
                     if (imsg->Code == CursorUp) {
                        if (Rotate_Matrixl(objptr, field, x, y, LEFTFIELD)) {
                           Rotate_Matrixr(objptr, field, x, y, LEFTFIELD);
                           Draw_Object(x, y, objptr, FALSE, LEFTFIELD);
                           Rotate_Matrixl(objptr, field, x, y, LEFTFIELD);
                           Draw_Object(x, y, objptr, TRUE, LEFTFIELD);
                        }
                     } else {
                        if (imsg->Code == CursorDown) {
                        if (Rotate_Matrixr(objptr, field, x, y, LEFTFIELD)) {
                           Rotate_Matrixl(objptr, field, x, y, LEFTFIELD);
                           Draw_Object(x, y, objptr, FALSE, LEFTFIELD);
                           Rotate_Matrixr(objptr, field, x, y, LEFTFIELD);
                           Draw_Object(x, y, objptr, TRUE, LEFTFIELD);
                        }
                     } else {
                     if (imsg->Code == CursorLeft) {
                        if (CollisionLeft(objptr, field, x, y) == TRUE) {
                           Draw_Object(x, y, objptr, FALSE, LEFTFIELD);
                           x = x-1;
                           Draw_Object(x, y, objptr, TRUE, LEFTFIELD);
                        }
                     } else {
                     if (imsg->Code == CursorRight) {
                        if (CollisionRight(objptr, field, x, y) == TRUE) {
                           Draw_Object(x, y, objptr, FALSE, LEFTFIELD);
                           x=x+1;
                           Draw_Object(x, y, objptr, TRUE, LEFTFIELD);
                        }
                     } else {
                     if (imsg->Code == NormalSpace) {
                        if (!SpacePressed) {
                           AbortIO((struct IORequest *) TimerIO);
                           WaitIO((struct IORequest *) TimerIO);
                           SpacePressed = TRUE;
                           oldtime = time;
                           time = pulldownticks;
                        }
                     } else {
                     if (imsg->Code == QuickSpace) {
                        AbortIO((struct IORequest *) TimerIO);
                        WaitIO((struct IORequest *) TimerIO);
                        oldtime = time;
                        time = 0;
                     } else
                     if (TwoPlayer) {
                        if (imsg->Code == CursorUp2) {
                           if (Rotate_Matrixl(objptr2, field2, x2, y2, RIGHTFIELD)) {
                              Rotate_Matrixr(objptr2, field2, x2, y2, RIGHTFIELD);
                              Draw_Object(x2, y2, objptr2, FALSE, RIGHTFIELD);
                              Rotate_Matrixl(objptr2, field2, x2, y2, RIGHTFIELD);
                              Draw_Object(x2, y2, objptr2, TRUE, RIGHTFIELD);
                           }
                        } else {
                        if (imsg->Code == CursorDown2) {
                           if (Rotate_Matrixr(objptr2, field2, x2, y2, RIGHTFIELD)) {
                              Rotate_Matrixl(objptr2, field2, x2, y2, RIGHTFIELD);
                              Draw_Object(x2, y2, objptr2, FALSE, RIGHTFIELD);
                              Rotate_Matrixr(objptr2, field2, x2, y2, RIGHTFIELD);
                              Draw_Object(x2, y2, objptr2, TRUE, RIGHTFIELD);
                           }
                        } else {
                        if (imsg->Code == CursorLeft2) {
                           if (CollisionLeft(objptr2, field2, x2, y2) == TRUE) {
                              Draw_Object(x2, y2, objptr2, FALSE, RIGHTFIELD);
                              x2 = x2 - 1;
                              Draw_Object(x2, y2, objptr2, TRUE, RIGHTFIELD);
                           }
                        } else {
                        if (imsg->Code == CursorRight2) {
                           if (CollisionRight(objptr2, field2, x2, y2) == TRUE) {
                              Draw_Object(x2, y2, objptr2, FALSE, RIGHTFIELD);
                              x2=x2+1;
                              Draw_Object(x2, y2, objptr2, TRUE, RIGHTFIELD);
                           }
                        } else {
                        if (imsg->Code == NormalSpace2) {
                           if (!SpacePressed2) {
                              AbortIO((struct IORequest *) TimerIO2);
                              WaitIO((struct IORequest *) TimerIO2);
                              SpacePressed2 = TRUE;
                              oldtime2 = time2;
                              time2 = pulldownticks;
                           }
                        } else {
                        if (imsg->Code == QuickSpace2) {
                           AbortIO((struct IORequest *) TimerIO2);
                           WaitIO((struct IORequest *) TimerIO2);
                           oldtime2 = time2;
                           time2 = 0;
                        }
                        }}}}}}
                     else {
                        if (SpacePressed2) {
                          SpacePressed2 = FALSE;
                           time2 = oldtime2;
                        }
                        if (SpacePressed) {
                          SpacePressed = FALSE;
                           time = oldtime;
                        }

                     }
                  }}}}}
                  break;
            }
            ReplyMsg((struct Message *)imsg);
         }
      }
   }

   closeall();
   return(0);
}



/*
** Fragt die Kollision nach rechts ab
** FALSE, wenn Object oder rechte Wand im Weg
** TRUE , wenn Object nach rechts verschoben werden kann
*/
BOOL CollisionRight(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y)
{
   short i,j;

   for (j=3; j>=0; j--)
      for (i=0; i<4; i++) {
         if ((objptr->objData[i][j] > 0) && (field[y+i-1][j+x+1] != 0))
            return(FALSE);
      }
   return(TRUE);
}



/*
** Fragt die Kollision nach links ab
** FALSE, wenn Object oder linke Wand im Weg
** TRUE , wenn Object nach links verschoben werden kann
*/
BOOL CollisionLeft(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y)
{
   short i,j;

   for (j=0; j<4; j++)
      for (i=0; i<4; i++) {
         if ((objptr->objData[i][j] > 0) && (field[y+i-1][j+x-1] != 0))
            return(FALSE);
      }
   return(TRUE);
}



/*
** Fragt die Kollision nach unten ab
** FALSE, wenn Object oder Boden im Weg
** TRUE , wenn Object nach unten verschoben werden kann
*/
BOOL CollisionDown(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y, BOOL RightOrLeft)
{
   short i,j;

   for (j=0; j<4; j++)
      for (i=0; i<4; i++) {
         if ((objptr->objData[i][j] > 0) && (field[y+i][j+x] != 0)) {
            Score = Score + Level;
            SetNewMatrix(objptr, field, x, y);
            CleanUp(field, RightOrLeft);
            return(FALSE);
         }
      }
   return(TRUE);
}



void openall(void)
{
   if ((TimerMP = CreatePort(NULL, NULL)) == NULL)
      closeout("Couldn't create messageport", RETURN_FAIL);

   if ((TimerIO = (struct timerequest *) CreateExtIO(TimerMP, sizeof(struct timerequest))) == NULL)
      closeout("Couldn't create IOrequest", RETURN_FAIL);

   if ((TimerError = OpenDevice(TIMERNAME, UNIT_VBLANK, (struct IORequest *) TimerIO, 0L)) != NULL)
      closeout("Couldn't open timer.device", RETURN_FAIL);

   if (TwoPlayer) {
      if ((TimerMP2 = CreatePort(NULL, NULL)) == NULL)
         closeout("Couldn't create messageport", RETURN_FAIL);

      if ((TimerIO2 = (struct timerequest *) CreateExtIO(TimerMP2, sizeof(struct timerequest))) == NULL)
         closeout("Couldn't create IOrequest", RETURN_FAIL);

      if ((TimerError2 = OpenDevice(TIMERNAME, UNIT_VBLANK, (struct IORequest *) TimerIO2, 0L)) != NULL)
         closeout("Couldn't open timer.device", RETURN_FAIL);
   }

   if ((KeymapBase = OpenLibrary("keymap.library", 37)) == NULL)
      closeout("Kickstart 2.0 required",RETURN_FAIL);

   if ((IntuitionBase = OpenLibrary("intuition.library", 37)) == NULL)
      closeout("Can't open intuition",RETURN_FAIL);

   if ((font = OpenDiskFont(&helvetica13)) == NULL)
      closeout("Failed to open Helvetica 13", RETURN_FAIL);

   if ((font2 = OpenDiskFont(&topaz8)) == NULL)
      closeout("Failed to open Topaz 8", RETURN_FAIL);

   if ((myscreen = LockPubScreen(NULL)) == NULL)
      closeout("Couldn't lock default public screen", RETURN_FAIL);

   if ((myscreen->Height) < 400)
      UseLace = FALSE;

   if ((VisualInfo = GetVisualInfo(myscreen, TAG_END)) == NULL)
      closeout("GetVisualInfo() failed", RETURN_FAIL);
}



void closeall(void)
{
   AbortIO((struct IORequest *) TimerIO);
   WaitIO((struct IORequest *) TimerIO);

   if (window)
      CloseWindow(window);

   if (TetrisGList)
      FreeGadgets(TetrisGList);

   if (VisualInfo)
      FreeVisualInfo(VisualInfo);

   if (myscreen)
      UnlockPubScreen(NULL, myscreen);

   if (IntuitionBase)
      CloseLibrary(IntuitionBase);

   if (KeymapBase)
      CloseLibrary(KeymapBase);

   if (!TimerError)
      CloseDevice((struct IORequest *) TimerIO);

   if (TimerIO)
      DeleteExtIO((struct IORequest *) TimerIO);

   if (TimerMP)
      DeletePort(TimerMP);

   if (TwoPlayer) {
      if (!TimerError2)
         CloseDevice((struct IORequest *) TimerIO2);

      if (TimerIO2)
         DeleteExtIO((struct IORequest *) TimerIO2);

      if (TimerMP2)
         DeletePort(TimerMP2);
   }

   exit(0);
}



void closeout(UBYTE *errstring, LONG rc)
{
   struct EasyStruct myES = {
      sizeof(struct EasyStruct),
      0,
      "WBTRIS Error",
      "Error: %s\n",
      "OK",
   };

   if (*errstring)
      EasyRequest(NULL, &myES, NULL, errstring);

    closeall();
    exit(rc);
}



BOOL Rotate_Matrixr(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y, BOOL RightOrLeft)
{
   short i, j;
   struct obj b[1];

   b[0].objData[3][0] = objptr->objData[0][0];
   b[0].objData[2][0] = objptr->objData[0][1];
   b[0].objData[1][0] = objptr->objData[0][2];
   b[0].objData[0][0] = objptr->objData[0][3];
   b[0].objData[3][1] = objptr->objData[1][0];
   b[0].objData[2][1] = objptr->objData[1][1];
   b[0].objData[1][1] = objptr->objData[1][2];
   b[0].objData[0][1] = objptr->objData[1][3];
   b[0].objData[3][2] = objptr->objData[2][0];
   b[0].objData[2][2] = objptr->objData[2][1];
   b[0].objData[1][2] = objptr->objData[2][2];
   b[0].objData[0][2] = objptr->objData[2][3];
   b[0].objData[3][3] = objptr->objData[3][0];
   b[0].objData[2][3] = objptr->objData[3][1];
   b[0].objData[1][3] = objptr->objData[3][2];
   b[0].objData[0][3] = objptr->objData[3][3];

   if ((CollisionRight(b, field, x-1, y) == TRUE) && (CollisionLeft(b, field, x+1, y) == TRUE) && (CollisionDown(b, field, x, y-1, RightOrLeft) == TRUE)) {
      for (i=0; i<4; i++)
         for (j=0; j<4; j++)
            objptr->objData[i][j] = b[0].objData[i][j];
      return(TRUE);
   }
   return(FALSE);
}



BOOL Rotate_Matrixl(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y, BOOL RightOrLeft)
{
   short i, j;
   struct obj b[1];

   b[0].objData[0][3] = objptr->objData[0][0];
   b[0].objData[1][3] = objptr->objData[0][1];
   b[0].objData[2][3] = objptr->objData[0][2];
   b[0].objData[3][3] = objptr->objData[0][3];
   b[0].objData[0][2] = objptr->objData[1][0];
   b[0].objData[1][2] = objptr->objData[1][1];
   b[0].objData[2][2] = objptr->objData[1][2];
   b[0].objData[3][2] = objptr->objData[1][3];
   b[0].objData[0][1] = objptr->objData[2][0];
   b[0].objData[1][1] = objptr->objData[2][1];
   b[0].objData[2][1] = objptr->objData[2][2];
   b[0].objData[3][1] = objptr->objData[2][3];
   b[0].objData[0][0] = objptr->objData[3][0];
   b[0].objData[1][0] = objptr->objData[3][1];
   b[0].objData[2][0] = objptr->objData[3][2];
   b[0].objData[3][0] = objptr->objData[3][3];

   if ((CollisionRight(b, field, x-1, y) == TRUE) && (CollisionLeft(b, field, x+1, y) == TRUE) && (CollisionDown(b, field, x, y-1, RightOrLeft) == TRUE)) {
      for (i=0; i<4; i++)
         for (j=0; j<4; j++)
            objptr->objData[i][j] = b[0].objData[i][j];
      return(TRUE);
   }
   return(FALSE);
}



void Draw_NextObject(struct obj *objptr, BOOL FieldRight)
{
   short i,j;

   for (i=0; i<4; i++) {
      for (j=0; j<4; j++)
         if (objptr->objData[i][j] > 0)
            Draw_Box(j-5, i, objptr->color, TRUE, FieldRight);
   }
}



void ClearNextField(BOOL RightOrLeft)
{
   short i,j;

   for (i=0; i<4; i++) {
      for (j=0; j<4; j++)
            Draw_Box(j-5, i, 0, FALSE, RightOrLeft);
   }
}



void Draw_Object(int x, int y, struct obj *objptr, BOOL malen, BOOL RightOrLeft)
{
   short i,j;

   for (i=0; i<4; i++) {
      for (j=0; j<4; j++)
         if (objptr->objData[i][j] > 0)
            Draw_Box(x+j, y+i-1, objptr->color, malen, RightOrLeft);
   }
}



void Draw_Box(int x, int y, int color, int malen, BOOL RightOrLeft)
{
   int TwoPLayerOffSet;

   if (RightOrLeft)
      TwoPLayerOffSet = boxxsize*XSIZE + FieldsSpace;
   else
      TwoPLayerOffSet = 0;

   if (UseLace) {
      if (malen == TRUE) {
         switch(color) {
            case 1:
               DrawImage(rp, &GruenWeiss, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 2:
               DrawImage(rp, &GruenWeissSchach, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 3:
               DrawImage(rp, &GruenWeissSchraeg, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 4:
               DrawImage(rp, &Schwarz, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 5:
               DrawImage(rp, &SchwarzGruen, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 6:
               DrawImage(rp, &SchwarzWeiss, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 7:
               DrawImage(rp, &Gruen, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
         }
      } else {
         switch(color) {
            case 0:
               SetAPen(rp, 0);
               RectFill(rp, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize, MAINXOFFSET + x*boxxsize + BOXXSIZE + TwoPLayerOffSet, YOffSet + y*boxysize + BOXYSIZE);
               break;
            case 1:
               EraseImage(rp, &GruenWeiss, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 2:
               EraseImage(rp, &GruenWeissSchach, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 3:
               EraseImage(rp, &GruenWeissSchraeg, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 4:
               EraseImage(rp, &Schwarz, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 5:
               EraseImage(rp, &SchwarzGruen, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 6:
               EraseImage(rp, &SchwarzWeiss, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 7:
               EraseImage(rp, &Gruen, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
         }
      }
   } else {
      if (malen == TRUE) {
         switch(color) {
            case 1:
               DrawImage(rp, &GruenWeissNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 2:
               DrawImage(rp, &GruenWeissSchachNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 3:
               DrawImage(rp, &GruenWeissSchraegNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 4:
               DrawImage(rp, &SchwarzNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 5:
               DrawImage(rp, &SchwarzGruenNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 6:
               DrawImage(rp, &SchwarzWeissNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 7:
               DrawImage(rp, &GruenNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
         }
      } else {
         switch(color) {
            case 0:
               SetAPen(rp, 0);
               RectFill(rp, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize, MAINXOFFSET + x*boxxsize + BOXXSIZE + TwoPLayerOffSet, YOffSet + y*boxysize + BOXYSIZE);
               break;
            case 1:
               EraseImage(rp, &GruenWeissNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 2:
               EraseImage(rp, &GruenWeissSchachNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 3:
               EraseImage(rp, &GruenWeissSchraegNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 4:
               EraseImage(rp, &SchwarzNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 5:
               EraseImage(rp, &SchwarzGruenNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 6:
               EraseImage(rp, &SchwarzWeissNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
            case 7:
               EraseImage(rp, &GruenNI, MAINXOFFSET + x*boxxsize + TwoPLayerOffSet, YOffSet + y*boxysize);
               break;
         }
      }
   }
}



struct obj *RandomObject(BOOL RightOrLeft)
{
   static ULONG RandomResult = 0L; /* So the last random-number is still stored ! */
   ULONG Sec,Mic;

   CurrentTime((LONG *)&Sec,(LONG *)&Mic);

   RandomResult *= Sec;
   RandomResult += Mic;

   while (RandomResult > 32767L) RandomResult = RandomResult>>1;

   RandomResult = RandomResult % 7;

   UpdateStatistic(RandomResult);

   if (RightOrLeft == LEFTFIELD) {
      switch(RandomResult) {
         case 0:
            return(&objects[1]);
            break;
         case 1:
            return(&objects[2]);
            break;
         case 2:
            return(&objects[3]);
            break;
         case 3:
            return(&objects[4]);
            break;
         case 4:
            return(&objects[5]);
            break;
         case 5:
            return(&objects[6]);
            break;
         default:
            return(&objects[7]);
      }
   } else {
      switch(RandomResult) {
         case 0:
            return(&objects2[1]);
            break;
         case 1:
            return(&objects2[2]);
            break;
         case 2:
            return(&objects2[3]);
            break;
         case 3:
            return(&objects2[4]);
            break;
         case 4:
            return(&objects2[5]);
            break;
         case 5:
            return(&objects2[6]);
            break;
         default:
            return(&objects2[7]);
      }
   }
}



void DrawWindow(void)
{
   /* Mainfield */
   if (UseLace)
      DrawBevelBox(rp, MAINXOFFSET+14, YOffSet-2, (XSIZE+1)*boxxsize-10, YSIZE*boxysize+5, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);
   else
      DrawBevelBox(rp, MAINXOFFSET+13, YOffSet-2, (XSIZE+1)*boxxsize-10, YSIZE*boxysize+5, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);

   /* Next Object Field */
   DrawBevelBox(rp, NEXTXOFFSET+14, YOffSet-2, 5*boxxsize-10, 4*boxysize+4, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);

   /* Logo */
   if (UseLace)
      DrawImage(rp, &logo, LGXOS + 20, YOffSet + 300);
   else
      DrawImage(rp, &logo, LGXOS, YOffSet);

/*
   if (UseLace)
      DrawBevelBox(rp, MAINXOFFSET+14, YOffSet-2, (XSIZE+1)*boxxsize-10, YSIZE*boxysize+5, GT_VisualInfo, VisualInfo);
   else
      DrawBevelBox(rp, MAINXOFFSET+13, YOffSet-2, (XSIZE+1)*boxxsize-10, YSIZE*boxysize+5, GT_VisualInfo, VisualInfo);

   DrawBevelBox(rp, NEXTXOFFSET+14, YOffSet-2, 5*boxxsize-10, 4*boxysize+4, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);

   if (UseLace)
      DrawImage(rp, &logo, LGXOS + 20, YOffSet + LGYOS + 300);
   else
      DrawImage(rp, &logo, LGXOS, YOffSet - 2);
*/

   /*
   ** Only for 2 player mode
   */
   if (TwoPlayer) {
      /* Mainfield */
      if (UseLace)
         DrawBevelBox(rp, XSIZE*boxxsize + MAINXOFFSET+14 + FieldsSpace, YOffSet-2, (XSIZE+1)*boxxsize-10, YSIZE*boxysize+5, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);
      else
         DrawBevelBox(rp, XSIZE*boxxsize + MAINXOFFSET+13 + FieldsSpace, YOffSet-2, (XSIZE+1)*boxxsize-10, YSIZE*boxysize+5, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);

      /* Next Object Field */
      DrawBevelBox(rp, XSIZE*boxxsize + NEXTXOFFSET+14 + FieldsSpace, YOffSet-2, 5*boxxsize-10, 4*boxysize+4, GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);
   }
}



void SetNewMatrix(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y)
{
   short line, column;

   for (line=0; line<4; line++)
      for (column=0; column<4; column++) {
         if (objptr->objData[line][column] == 1)
            field[y+line-1][x+column] = objptr->color;
      }
}



void CleanUp(int ThisField[YSIZE+1][XSIZE+2], BOOL RightOrLeft)
{
   int i, j, line, column;
   BOOL Update = FALSE;
   BOOL KeineNull = TRUE;
   int LinesToRemove = 0;

   Lines = 0;
   for (line=1; line < YSIZE; line++) {
      for (column=1; column < XSIZE+1; column++)
         if (ThisField[line][column] == 0)
            KeineNull = FALSE;

      if (KeineNull == TRUE)
      {
         Lines++;
         LinesToRemove++;
         Update = TRUE;
         for (j=line; j>0; j--)
            for (i=1; i<XSIZE+1; i++)
               ThisField[j][i] = ThisField[j-1][i];
      }
      KeineNull = TRUE;
   }

   if (Update == TRUE) {
      if (TwoPlayer ) {
         if (LinesToRemove > 0) {
            if (RightOrLeft == RIGHTFIELD)
               PutRows(field, LEFTFIELD, LinesToRemove);
            else
               PutRows(field2, RIGHTFIELD, LinesToRemove);
         }
      }
      ReDrawField(ThisField, RightOrLeft);
   }

   LineCounter = LineCounter + Lines;
   Level = LineCounter / 10 + LevelOffset;
   if (Level >= 20)
      oldtime = 0;
   else
      oldtime = DEFAULTTICKS - Level*2;
   time = oldtime;

   if (TwoPlayer) {
      if (Level >= 20)
         oldtime2 = 0;
      else
         oldtime2 = DEFAULTTICKS - Level*2;
      time2 = oldtime2;
   }

   if (Level == 0)
      Score = Score + 5*Lines*Lines*(Level+1);
   else
      Score = Score + 10*Lines*Lines*Level;

   if (Score > Highscore)
      Highscore = Score;

   GT_SetGadgetAttrs(TetrisGadgets[GD_HighscoreGadget], window, NULL,
                     GTNM_Number, (ULONG)Highscore,
                     TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_ScoreGadget], window, NULL,
                     GTNM_Number, (ULONG)Score,
                     TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_LevelGadget], window, NULL,
                     GTNM_Number, (ULONG)Level,
                     TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_LineGadget], window, NULL,
                     GTNM_Number, (ULONG)LineCounter,
                     TAG_END);
}



/*
** Ist der obere Rand erreicht, dann ist das Spiel zu Ende
** TRUE,  wenn oberer Rand erreicht
** FALSE, wenn nicht
*/
BOOL GameOver(int field[YSIZE+1][XSIZE+2],BOOL lockname)
{
   int column;

   for (column=0; column<=XSIZE; column++) {
      if (field[1][column] > 0) {
         if (Score > Highscore)
         Highscore = Score;

         if ((lockname == FALSE) || (strlen(Name) == 0))
            AskForName();
         HiscoreList(Name, Level, Score, LineCounter, window->LeftEdge, window->TopEdge, SAVEHISCORE);

         if ((AskContinue()) == TRUE) {
             Score = 0;
             LineCounter = 0;
             Level = LevelOffset;
             NewGame(field, TRUE, FALSE);
         }
         else
            return(TRUE);
      }
   }
   return(FALSE);
}



/*
** Hier wird den Objekten die Form und die Farbe gegeben
*/
void InitObjects(void)
{
   FILE *fp = NULL;
   short ObjectNumber = 1;
   short line = 0;
   short column = 0;
   int number;

   objects[0].objData[0][0] = 0; objects[0].objData[0][1] = 0; objects[0].objData[0][2] = 0; objects[0].objData[0][3] = 0;
   objects[0].objData[1][0] = 0; objects[0].objData[1][1] = 0; objects[0].objData[1][2] = 0; objects[0].objData[1][3] = 0;
   objects[0].objData[2][0] = 0; objects[0].objData[2][1] = 0; objects[0].objData[2][2] = 0; objects[0].objData[2][3] = 0;
   objects[0].objData[3][0] = 0; objects[0].objData[3][1] = 0; objects[0].objData[3][2] = 0; objects[0].objData[3][3] = 0;
   objects[0].color = 0;

   objects2[0].objData[0][0] = 0; objects2[0].objData[0][1] = 0; objects2[0].objData[0][2] = 0; objects2[0].objData[0][3] = 0;
   objects2[0].objData[1][0] = 0; objects2[0].objData[1][1] = 0; objects2[0].objData[1][2] = 0; objects2[0].objData[1][3] = 0;
   objects2[0].objData[2][0] = 0; objects2[0].objData[2][1] = 0; objects2[0].objData[2][2] = 0; objects2[0].objData[2][3] = 0;
   objects2[0].objData[3][0] = 0; objects2[0].objData[3][1] = 0; objects2[0].objData[3][2] = 0; objects2[0].objData[3][3] = 0;
   objects2[0].color = 0;

   if ((strlen(TileFile) != 0) && ((fp = fopen(TileFile, "r")) != NULL)) {
         while (ObjectNumber <= 7) {
            for (line=0; line<=3; line++) {
               for (column=0; column<=3; column++) {
                  number = getc(fp);
                  while ((number != '0') && (number != '1') && (number != EOF))
                     number = getc(fp);
                  if (number == '1') {
                     objects[ObjectNumber].objData[line][column] = 1;
                     objects2[ObjectNumber].objData[line][column] = 1;
                  }
                  if (number == '0') {
                     objects[ObjectNumber].objData[line][column] = 0;
                     objects2[ObjectNumber].objData[line][column] = 0;
                  }
               }
            }
            objects[ObjectNumber].color = ObjectNumber;
            objects2[ObjectNumber].color = ObjectNumber;
            ObjectNumber++;
         }
         fclose(fp);
   } else {

      objects[1].objData[0][0] = 0; objects[1].objData[0][1] = 0; objects[1].objData[0][2] = 0; objects[1].objData[0][3] = 0;
      objects[1].objData[1][0] = 0; objects[1].objData[1][1] = 1; objects[1].objData[1][2] = 1; objects[1].objData[1][3] = 0;
      objects[1].objData[2][0] = 0; objects[1].objData[2][1] = 1; objects[1].objData[2][2] = 1; objects[1].objData[2][3] = 0;
      objects[1].objData[3][0] = 0; objects[1].objData[3][1] = 0; objects[1].objData[3][2] = 0; objects[1].objData[3][3] = 0;
      objects[1].color = 1;

      objects[2].objData[0][0] = 0; objects[2].objData[0][1] = 1; objects[2].objData[0][2] = 0; objects[2].objData[0][3] = 0;
      objects[2].objData[1][0] = 0; objects[2].objData[1][1] = 1; objects[2].objData[1][2] = 0; objects[2].objData[1][3] = 0;
      objects[2].objData[2][0] = 0; objects[2].objData[2][1] = 1; objects[2].objData[2][2] = 0; objects[2].objData[2][3] = 0;
      objects[2].objData[3][0] = 0; objects[2].objData[3][1] = 1; objects[2].objData[3][2] = 0; objects[2].objData[3][3] = 0;
      objects[2].color = 2;

      objects[3].objData[0][0] = 0; objects[3].objData[0][1] = 0; objects[3].objData[0][2] = 0; objects[3].objData[0][3] = 0;
      objects[3].objData[1][0] = 0; objects[3].objData[1][1] = 0; objects[3].objData[1][2] = 1; objects[3].objData[1][3] = 0;
      objects[3].objData[2][0] = 0; objects[3].objData[2][1] = 1; objects[3].objData[2][2] = 1; objects[3].objData[2][3] = 0;
      objects[3].objData[3][0] = 0; objects[3].objData[3][1] = 0; objects[3].objData[3][2] = 1; objects[3].objData[3][3] = 0;
      objects[3].color = 3;

      objects[4].objData[0][0] = 0; objects[4].objData[0][1] = 0; objects[4].objData[0][2] = 0; objects[4].objData[0][3] = 0;
      objects[4].objData[1][0] = 1; objects[4].objData[1][1] = 1; objects[4].objData[1][2] = 1; objects[4].objData[1][3] = 0;
      objects[4].objData[2][0] = 0; objects[4].objData[2][1] = 0; objects[4].objData[2][2] = 1; objects[4].objData[2][3] = 0;
      objects[4].objData[3][0] = 0; objects[4].objData[3][1] = 0; objects[4].objData[3][2] = 0; objects[4].objData[3][3] = 0;
      objects[4].color = 4;

      objects[5].objData[0][0] = 0; objects[5].objData[0][1] = 0; objects[5].objData[0][2] = 0; objects[5].objData[0][3] = 0;
      objects[5].objData[1][0] = 0; objects[5].objData[1][1] = 0; objects[5].objData[1][2] = 1; objects[5].objData[1][3] = 0;
      objects[5].objData[2][0] = 1; objects[5].objData[2][1] = 1; objects[5].objData[2][2] = 1; objects[5].objData[2][3] = 0;
      objects[5].objData[3][0] = 0; objects[5].objData[3][1] = 0; objects[5].objData[3][2] = 0; objects[5].objData[3][3] = 0;
      objects[5].color = 5;

      objects[6].objData[0][0] = 0; objects[6].objData[0][1] = 1; objects[6].objData[0][2] = 0; objects[6].objData[0][3] = 0;
      objects[6].objData[1][0] = 0; objects[6].objData[1][1] = 1; objects[6].objData[1][2] = 1; objects[6].objData[1][3] = 0;
      objects[6].objData[2][0] = 0; objects[6].objData[2][1] = 0; objects[6].objData[2][2] = 1; objects[6].objData[2][3] = 0;
      objects[6].objData[3][0] = 0; objects[6].objData[3][1] = 0; objects[6].objData[3][2] = 0; objects[6].objData[3][3] = 0;
      objects[6].color = 6;

      objects[7].objData[0][0] = 0; objects[7].objData[0][1] = 0; objects[7].objData[0][2] = 0; objects[7].objData[0][3] = 0;
      objects[7].objData[1][0] = 0; objects[7].objData[1][1] = 0; objects[7].objData[1][2] = 1; objects[7].objData[1][3] = 0;
      objects[7].objData[2][0] = 0; objects[7].objData[2][1] = 1; objects[7].objData[2][2] = 1; objects[7].objData[2][3] = 0;
      objects[7].objData[3][0] = 0; objects[7].objData[3][1] = 1; objects[7].objData[3][2] = 0; objects[7].objData[3][3] = 0;
      objects[7].color = 7;


      objects2[1].objData[0][0] = 0; objects2[1].objData[0][1] = 0; objects2[1].objData[0][2] = 0; objects2[1].objData[0][3] = 0;
      objects2[1].objData[1][0] = 0; objects2[1].objData[1][1] = 1; objects2[1].objData[1][2] = 1; objects2[1].objData[1][3] = 0;
      objects2[1].objData[2][0] = 0; objects2[1].objData[2][1] = 1; objects2[1].objData[2][2] = 1; objects2[1].objData[2][3] = 0;
      objects2[1].objData[3][0] = 0; objects2[1].objData[3][1] = 0; objects2[1].objData[3][2] = 0; objects2[1].objData[3][3] = 0;
      objects2[1].color = 1;

      objects2[2].objData[0][0] = 0; objects2[2].objData[0][1] = 1; objects2[2].objData[0][2] = 0; objects2[2].objData[0][3] = 0;
      objects2[2].objData[1][0] = 0; objects2[2].objData[1][1] = 1; objects2[2].objData[1][2] = 0; objects2[2].objData[1][3] = 0;
      objects2[2].objData[2][0] = 0; objects2[2].objData[2][1] = 1; objects2[2].objData[2][2] = 0; objects2[2].objData[2][3] = 0;
      objects2[2].objData[3][0] = 0; objects2[2].objData[3][1] = 1; objects2[2].objData[3][2] = 0; objects2[2].objData[3][3] = 0;
      objects2[2].color = 2;

      objects2[3].objData[0][0] = 0; objects2[3].objData[0][1] = 0; objects2[3].objData[0][2] = 0; objects2[3].objData[0][3] = 0;
      objects2[3].objData[1][0] = 0; objects2[3].objData[1][1] = 0; objects2[3].objData[1][2] = 1; objects2[3].objData[1][3] = 0;
      objects2[3].objData[2][0] = 0; objects2[3].objData[2][1] = 1; objects2[3].objData[2][2] = 1; objects2[3].objData[2][3] = 0;
      objects2[3].objData[3][0] = 0; objects2[3].objData[3][1] = 0; objects2[3].objData[3][2] = 1; objects2[3].objData[3][3] = 0;
      objects2[3].color = 3;

      objects2[4].objData[0][0] = 0; objects2[4].objData[0][1] = 0; objects2[4].objData[0][2] = 0; objects2[4].objData[0][3] = 0;
      objects2[4].objData[1][0] = 1; objects2[4].objData[1][1] = 1; objects2[4].objData[1][2] = 1; objects2[4].objData[1][3] = 0;
      objects2[4].objData[2][0] = 0; objects2[4].objData[2][1] = 0; objects2[4].objData[2][2] = 1; objects2[4].objData[2][3] = 0;
      objects2[4].objData[3][0] = 0; objects2[4].objData[3][1] = 0; objects2[4].objData[3][2] = 0; objects2[4].objData[3][3] = 0;
      objects2[4].color = 4;

      objects2[5].objData[0][0] = 0; objects2[5].objData[0][1] = 0; objects2[5].objData[0][2] = 0; objects2[5].objData[0][3] = 0;
      objects2[5].objData[1][0] = 0; objects2[5].objData[1][1] = 0; objects2[5].objData[1][2] = 1; objects2[5].objData[1][3] = 0;
      objects2[5].objData[2][0] = 1; objects2[5].objData[2][1] = 1; objects2[5].objData[2][2] = 1; objects2[5].objData[2][3] = 0;
      objects2[5].objData[3][0] = 0; objects2[5].objData[3][1] = 0; objects2[5].objData[3][2] = 0; objects2[5].objData[3][3] = 0;
      objects2[5].color = 5;

      objects2[6].objData[0][0] = 0; objects2[6].objData[0][1] = 1; objects2[6].objData[0][2] = 0; objects2[6].objData[0][3] = 0;
      objects2[6].objData[1][0] = 0; objects2[6].objData[1][1] = 1; objects2[6].objData[1][2] = 1; objects2[6].objData[1][3] = 0;
      objects2[6].objData[2][0] = 0; objects2[6].objData[2][1] = 0; objects2[6].objData[2][2] = 1; objects2[6].objData[2][3] = 0;
      objects2[6].objData[3][0] = 0; objects2[6].objData[3][1] = 0; objects2[6].objData[3][2] = 0; objects2[6].objData[3][3] = 0;
      objects2[6].color = 6;

      objects2[7].objData[0][0] = 0; objects2[7].objData[0][1] = 0; objects2[7].objData[0][2] = 0; objects2[7].objData[0][3] = 0;
      objects2[7].objData[1][0] = 0; objects2[7].objData[1][1] = 0; objects2[7].objData[1][2] = 1; objects2[7].objData[1][3] = 0;
      objects2[7].objData[2][0] = 0; objects2[7].objData[2][1] = 1; objects2[7].objData[2][2] = 1; objects2[7].objData[2][3] = 0;
      objects2[7].objData[3][0] = 0; objects2[7].objData[3][1] = 1; objects2[7].objData[3][2] = 0; objects2[7].objData[3][3] = 0;
      objects2[7].color = 7;
   }
}


/*
** Das Programm kann angehalten werden
*/
BOOL Pause(void)
{
   BOOL                 Done = FALSE;
   struct IntuiMessage *imsg = NULL;
   struct Gadget       *gad = NULL;
   int                  line,column;

   GT_SetGadgetAttrs(TetrisGadgets[GD_PauseGadget], window, NULL,
                     GTCY_Labels, &CYCLELabels[1], TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_NewGadget], window, NULL,
                     GA_Disabled, TRUE, TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_OptGadget], window, NULL,
                     GA_Disabled, TRUE, TAG_END);

   HideField();

   while(!Done)
   {
      Wait(1L << window->UserPort->mp_SigBit);

      while (imsg = (struct IntuiMessage *)GetMsg(window->UserPort)) {
         switch(imsg->Class) {
            case IDCMP_GADGETUP:
               gad = (struct Gadget *)imsg->IAddress;
               switch(gad->GadgetID) {
                  case GD_PauseGadget:
                     GT_SetGadgetAttrs(TetrisGadgets[GD_PauseGadget], window, NULL,
                                       GA_Disabled, FALSE, TAG_END);
                     GT_SetGadgetAttrs(TetrisGadgets[GD_NewGadget], window, NULL,
                                       GA_Disabled, FALSE, TAG_END);
                     GT_SetGadgetAttrs(TetrisGadgets[GD_OptGadget], window, NULL,
                                       GA_Disabled, FALSE, TAG_END);
                     GT_SetGadgetAttrs(TetrisGadgets[GD_PauseGadget], window, NULL,
                                       GTCY_Labels, &CYCLELabels[0], TAG_END);
                     Done = TRUE;
                     break;
                  case GD_StatGadget:
                     statistic(window->LeftEdge, window->TopEdge, obj1, obj2, obj3, obj4, obj5, obj6, obj7);
                     break;
                  case GD_ShowScoreGadget:
                     HiscoreList(Name, Level, Score, LineCounter, window->LeftEdge, window->TopEdge, SHOWHISCORE);
                     break;
               }
               break;

            case IDCMP_REFRESHWINDOW:
               GT_BeginRefresh(window);
               GT_EndRefresh(window, TRUE);
               break;

            case IDCMP_CLOSEWINDOW:
               QuitGame();
               break;
         }
         ReplyMsg((struct Message *)imsg);
      }
   }
   if (UseLace)
      EraseImage(rp, &Pausebrush, 190,150);
   else
      EraseImage(rp, &Pausebrush, 310,85);

   if (TwoPlayer) {
      if (UseLace)
         EraseImage(rp, &Pausebrush, 190 + XSIZE*boxxsize + FieldsSpace,150);
      else
         EraseImage(rp, &Pausebrush, 310 + XSIZE*boxxsize + FieldsSpace,85);
   }

   ReDrawField(field, LEFTFIELD);
   ReDrawField(field2, RIGHTFIELD);

   if (TwoPlayer) {
      for (line=1; line < YSIZE; line++) {
         for (column=1; column < XSIZE+1; column++) {
            switch(field2[line][column]) {
               case 0:
                  Draw_Box(column, line, 0, FALSE, RIGHTFIELD);
                  break;
               case 1:
                  Draw_Box(column, line, 1, TRUE, RIGHTFIELD);
                  break;
               case 2:
                  Draw_Box(column, line, 2, TRUE, RIGHTFIELD);
                  break;
               case 3:
                  Draw_Box(column, line, 3, TRUE, RIGHTFIELD);
                  break;
               case 4:
                  Draw_Box(column, line, 4, TRUE, RIGHTFIELD);
                  break;
               case 5:
                  Draw_Box(column, line, 5, TRUE, RIGHTFIELD);
                  break;
               case 6:
                  Draw_Box(column, line, 6, TRUE, RIGHTFIELD);
                  break;
               case 7:
                  Draw_Box(column, line, 7, TRUE, RIGHTFIELD);
                  break;
            }
         }
      }
   }
   return(FALSE);
}



/*
** Ein neues Spiel starten
*/
void NewGame(int ThisField[YSIZE+1][XSIZE+2], BOOL vongameover, BOOL vonoptions)
{
   int line, column;

   AbortIO((struct IORequest *) TimerIO);
   WaitIO((struct IORequest *) TimerIO);

   Level = LevelOffset;
   time = oldtime = DEFAULTTICKS - 2*LevelOffset;

   /* Feld loeschen */
   for (line=0; line < YSIZE; line++)
      for (column=1; column<=XSIZE; column++) {
         field[line][column] = 0;
         Draw_Box(column, line, 0, FALSE, LEFTFIELD);
      }

   ClearNextField(LEFTFIELD);

   nextptr = RandomObject(LEFTFIELD);
   objptr = RandomObject(LEFTFIELD);
   if (nextteil == TRUE)
      Draw_NextObject(nextptr, FALSE);

   x = XSIZE/2-1;
   y = 0;
   if (InFirstLine(objptr) == TRUE)
      y = 1;

   if (TwoPlayer) {
      time2 = oldtime2 = DEFAULTTICKS - 2*LevelOffset;
      /* Feld loeschen */
      for (line=0; line < YSIZE; line++)
         for (column=1; column<=XSIZE; column++) {
            field2[line][column] = 0;
            Draw_Box(column, line, 0, FALSE, RIGHTFIELD);
         }

      ClearNextField(RIGHTFIELD);

      nextptr2 = RandomObject(RIGHTFIELD);
      objptr2 = RandomObject(RIGHTFIELD);
      if (nextteil == TRUE)
         Draw_NextObject(nextptr2, TRUE);

      x2 = XSIZE/2-1;
      y2 = 0;
      if (InFirstLine(objptr2) == TRUE)
         y2 = 1;
   }

   vongameover = FALSE;
   vonoptions = FALSE;

   LineCounter = 0;

   if (Score > Highscore)
      GT_SetGadgetAttrs(TetrisGadgets[GD_HighscoreGadget], window, NULL, GTNM_Number, (ULONG)Score, TAG_END);
   else
      GT_SetGadgetAttrs(TetrisGadgets[GD_HighscoreGadget], window, NULL, GTNM_Number, (ULONG)Highscore, TAG_END);

   Score = 0;

   GT_SetGadgetAttrs(TetrisGadgets[GD_ScoreGadget], window, NULL,
                     GTNM_Number, (ULONG)Score, TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_LevelGadget], window, NULL,
                     GTNM_Number, (ULONG)Level, TAG_END);
   GT_SetGadgetAttrs(TetrisGadgets[GD_LineGadget], window, NULL,
                     GTNM_Number, (ULONG)LineCounter, TAG_END);
   ClearAllMsgPorts();
}



void QuitGame(void)
{
   if (Score > Highscore) {
      Highscore = Score;
      HiscoreList(Name, Level, Score, LineCounter, window->LeftEdge, window->TopEdge, SAVEHISCORE);
   }
   closeall();
}



BOOL InFirstLine(struct obj *objptr)
{
   int column;

   for (column=0; column<4; column++)
      if (objptr->objData[0][column] == 1)
         return(TRUE);
   return(FALSE);
}



int Loadhiscore(void)
{
   char   score[10];
   int    zaehler = 0, hiscore = 0, c;
   FILE  *fp = NULL;
   char  *ptr = NULL;
   char   FName[80];

   if (getenv("WBTRIS"))
      strcpy(FName, getenv("WBTRIS"));
   else
      strcpy(FName, FILENAME);

   ptr = &score[0];

   if ((fp = fopen(FName, "r")) == NULL)
      return(0);
   else {
      while (((c=getc(fp)) != EOF) && (zaehler != 2))
         if (c == '/') zaehler++;

      if (c != EOF) {
         while (c != '/') {
            *ptr = c;
            ptr++;
            c = getc(fp);
         }
         *ptr = '\0';
         hiscore = atoi(score);
      }

      fclose(fp);
      return(hiscore);
   }
}



BOOL AskContinue(void)
{
   struct EasyStruct myES = {
       sizeof(struct EasyStruct),
       0,
       "Continue",
       "Game over\n\nDo you want to play again ?",
       "YEA|No thanks",
   };
   LONG answer;

   answer = EasyRequest(NULL, &myES, NULL, "(Variable)");

   if (answer == 1)
      return(TRUE);
   else
      closeall();
}



void WaitForActivateWindow(void)
{
   BOOL                 Done = FALSE;
   struct IntuiMessage *imsg = NULL;

   AbortIO((struct IORequest *) TimerIO);
   WaitIO((struct IORequest *) TimerIO);

   HideField();

   while(!Done)
   {
      Wait(1L << window->UserPort->mp_SigBit);

      while (imsg = (struct IntuiMessage *)GetMsg(window->UserPort)) {
         switch(imsg->Class) {
            case IDCMP_ACTIVEWINDOW:
               Done = TRUE;
               break;

            case IDCMP_REFRESHWINDOW:
               GT_BeginRefresh(window);
               GT_EndRefresh(window, TRUE);
               break;

            case IDCMP_CLOSEWINDOW:
               QuitGame();
               break;
         }
         ReplyMsg((struct Message *)imsg);
      }
   }

   if (UseLace)
      EraseImage(rp, &Pausebrush, 190,150);
   else
      EraseImage(rp, &Pausebrush, 310,85);

   ReDrawField(field, LEFTFIELD);
   ReDrawField(field2, RIGHTFIELD);
}



void UpdateStatistic(int objnumber)
{
   switch(objnumber) {
      case 0:
         obj1++;
         break;
      case 1:
         obj2++;
         break;
      case 2:
         obj3++;
         break;
      case 3:
         obj4++;
         break;
      case 4:
         obj5++;
         break;
      case 5:
         obj6++;
         break;
      case 6:
         obj7++;
         break;
   }
}



/*
** Put rows onto the opponent's fieldbottom (only for 2-player-mode)
*/
void PutRows(int field[YSIZE+1][XSIZE+2], BOOL RightOrLeft, int NumberOfRows)
{
   int i, j;
   short line, column;
   BOOL FoundNull = FALSE;
   int NewRow[XSIZE+2];
   short Farbe;

   /* build new row */
   Farbe = 1 + rand() % 7;
   for (i = 0; i < XSIZE+2; i++)
      NewRow[i] = Farbe;
   NewRow[0]       = -1;
   NewRow[XSIZE+1] = -1;
   NewRow[1 + rand() % XSIZE] = 0;

   /* Put rows onto the opponent's field */
   for (j = 0; j < NumberOfRows; j++) {

      /* move field one row up */
      for (line = 0; line < YSIZE-1; line++)
         for (column = 1; column < XSIZE + 1; column++)
            field[line][column] = field[line+1][column];

      /* insert new row */
      for (i=0; i<XSIZE+2; i++)
         field[YSIZE-1][i] = NewRow[i];

      /* Abfrage auf Spielende */
      /*GameOver(field, lockname);*/

      /* Redraw the field */
      ReDrawField(field, RightOrLeft);
      if (RightOrLeft == RIGHTFIELD)
         Draw_Object(x2, y2, objptr2, TRUE, RIGHTFIELD);
      else
         Draw_Object(x, y, objptr, TRUE, LEFTFIELD);
   }
}



/*
** executes a refresh of the playfield(s)
*/
void ReDrawField(int field[YSIZE+1][XSIZE+2], BOOL RightOrLeft)
{
   short line, column;

   for (line=1; line < YSIZE; line++) {
      for (column=1; column < XSIZE+1; column++)
         switch(field[line][column]) {
            case 0:
               Draw_Box(column, line, 0, FALSE, RightOrLeft);
               break;
            case 1:
               Draw_Box(column, line, 1, TRUE, RightOrLeft);
               break;
            case 2:
               Draw_Box(column, line, 2, TRUE, RightOrLeft);
               break;
            case 3:
               Draw_Box(column, line, 3, TRUE, RightOrLeft);
               break;
            case 4:
               Draw_Box(column, line, 4, TRUE, RightOrLeft);
               break;
            case 5:
               Draw_Box(column, line, 5, TRUE, RightOrLeft);
               break;
            case 6:
               Draw_Box(column, line, 6, TRUE, RightOrLeft);
               break;
            case 7:
               Draw_Box(column, line, 7, TRUE, RightOrLeft);
               break;
         }
   }
}



void HideField(void)
{
   SetAPen(rp, 0);
   RectFill(rp, MAINXOFFSET+16, YOffSet-1, MAINXOFFSET+16 + (XSIZE+1)*boxxsize-15, YOffSet + YSIZE*boxysize+1);

   if (UseLace)
      DrawImage(rp, &Pausebrush, 190, 150);
   else
      DrawImage(rp, &Pausebrush, 310, 85);

   if (TwoPlayer) {
      RectFill(rp, MAINXOFFSET+16  + XSIZE*boxxsize + FieldsSpace, YOffSet-1, MAINXOFFSET+16 + (XSIZE+1)*boxxsize-15 + XSIZE*boxxsize + FieldsSpace, YOffSet + YSIZE*boxysize+1);

      if (UseLace)
         DrawImage(rp, &Pausebrush, 190 + XSIZE*boxxsize + FieldsSpace, 150);
      else
         DrawImage(rp, &Pausebrush, 310 + XSIZE*boxxsize + FieldsSpace, 85);
   }
}



void ClearAllMsgPorts(void)
{
   struct I0ExtSer     *reply = NULL;
   struct IntuiMessage *imsg = NULL;

   while(reply = (struct I0ExtSer *)GetMsg(TimerMP))
   {}
   if (TwoPlayer) {
      while(reply = (struct I0ExtSer *)GetMsg(TimerMP2))
      {}
   }
   while (imsg = (struct IntuiMessage *)GetMsg(window->UserPort))
      ReplyMsg((struct Message *)imsg);
}
