/*
 * clockwindow.c V1.1
 *
 * clock window handling
 *
 * (c) 1992-1993 Holger Brunst
 */

#include <CClock.h>

/* Coordinates of game elements */  
struct Element {
                short x, y;
               };
/* Source coordinates of clock elements (foreground) */
static const struct Element clkFor[24] = {
                                            0,144,  64,144, 128,144, 192,144,
                                            0,176,  64,176, 128,176, 192,176,
                                            0,208,  64,208, 128,208, 192,208,
                                          256,144, 448,208, 384,208, 320,208,
                                          256,208, 448,176, 384,176, 320,176,
                                          256,176, 448,144, 384,144, 320,144
                                         };
/* Source coordinates of clock elements (background) */
static const struct Element clkBak[18] = {
                                           32,16, 112,16, 192,16,  32,56,
                                          112,56, 192,56,  32,96, 112,96,
                                          192,96,
                                          320,16, 400,16, 480,16, 320,56,
                                          400,56, 480,56, 320,96, 400,96,
                                          480,96
                                         };
/* Destination coordinates of clock elements */
static const struct Element clkDst[9] = {
                                         208, 44, 288, 44, 368, 44, 208, 84,
                                         288, 84, 368, 84, 208,124, 288,124,
                                         368,124
                                        };

/* Source coordinates of button elements */
static const struct Element butSrc[16] = {
                                          512,144, 512,160, 544,160, 544,144,
                                           88, 48,  88, 88, 168, 88, 168, 48,
                                          456, 48, 456, 88, 376, 88, 376, 48,
                                          544,176, 544,192, 512,192, 512,176
                                         };
/* Destination coordinates of button elements */
static const struct Element butDst[8] = {
                                         264,76, 264,116, 344,116, 344,76,
                                         344,76, 344,116, 264,116, 264,76
                                        };

/* Color pallete (all grey) */
static const USHORT darknes[16] = {
                                   0xaaa, 0xaaa, 0xaaa, 0xaaa,
                                   0xaaa, 0xaaa, 0xaaa, 0xaaa,
                                   0xaaa, 0xaaa, 0xaaa, 0xaaa,
                                   0xaaa, 0xaaa, 0xaaa, 0xaaa
                                  };

/* Menu data */
#define MENU_NEW    0
#define MENU_PAUSE  1
#define MENU_HIGH   2
#define MENU_ABOUT  3
#define MENU_QUIT   4

#define MENU_SIDE1  5
#define MENU_SIDE2  6
#define MENU_RAND   7
static const struct NewMenu mdata[] = {
                                {NM_TITLE,"Project"  , NULL, 0, ~0, NULL},
                                {NM_ITEM, "New game" , "N" , 0, ~0, MENU_NEW},
                                {NM_ITEM, "Pause"    , "P" , 0, ~0, MENU_PAUSE},
                                {NM_ITEM, "Highscore", "H" , 0, ~0, MENU_HIGH},
                                {NM_ITEM, NM_BARLABEL, NULL, 0, ~0, NULL},
                                {NM_ITEM, "About"    , NULL, 0, ~0, MENU_ABOUT},
                                {NM_ITEM, NM_BARLABEL, NULL, 0, ~0, NULL},
                                {NM_ITEM, "Quit..."  , "Q" , 0, ~0, MENU_QUIT},
                                {NM_TITLE,"Control"  , NULL, 0, ~0, NULL},
                                {NM_ITEM, "Side 1"   , "1" , 0, ~0, MENU_SIDE1},
                                {NM_ITEM, "Side 2"   , "2" , 0, ~0, MENU_SIDE2},
                                {NM_ITEM, NM_BARLABEL, NULL, 0, ~0, NULL},
                                {NM_ITEM, "Random"   , "R" , 0, ~0, MENU_RAND},
                                {NM_END}
                                      };

/* Gadget data */
#define GAD_CLK1L   0
#define GAD_CLK2L   1
#define GAD_CLK3L   2
#define GAD_CLK4L   3
#define GAD_CLK1R   4
#define GAD_CLK2R   5
#define GAD_CLK3R   6
#define GAD_CLK4R   7
#define GAD_BUT1    8
#define GAD_BUT2    9
#define GAD_BUT3    10
#define GAD_BUT4    11
#define GAD_TOGGLE  12
#define SIMPLE_GADGET(next, x, y, width, height, id) {\
                                            next, x, y, width, height\
                                            GFLG_GADGHNONE,\
                                            GACT_RELVERIFY,\
                                            GTYP_BOOLGADGET,\
                                            NULL, NULL, NULL, 0, NULL, id, NULL\
                                                     }                        

static const struct Gadget gads[] = {
                        SIMPLE_GADGET(&gads[1], 272,  76, 17, 10, GAD_BUT1),
                        SIMPLE_GADGET(&gads[2], 272, 116, 17, 10, GAD_BUT2),
                        SIMPLE_GADGET(&gads[3], 352, 116, 17, 10, GAD_BUT3),
                        SIMPLE_GADGET(&gads[4], 352,  76, 17, 10, GAD_BUT4),
                        SIMPLE_GADGET(&gads[5], 211,  46, 30, 29, GAD_CLK1L),
                        SIMPLE_GADGET(&gads[6], 241,  46, 29, 29, GAD_CLK1R),
                        SIMPLE_GADGET(&gads[7], 211, 126, 30, 29, GAD_CLK2L),
                        SIMPLE_GADGET(&gads[8], 241, 126, 29, 29, GAD_CLK2R),
                        SIMPLE_GADGET(&gads[9], 371, 126, 30, 29, GAD_CLK3L),
                        SIMPLE_GADGET(&gads[10],401, 126, 29, 29, GAD_CLK3R),
                        SIMPLE_GADGET(&gads[11],371,  46, 30, 29, GAD_CLK4L),
                        SIMPLE_GADGET(&gads[12],401,  46, 29, 29, GAD_CLK4R),
                        SIMPLE_GADGET(NULL,     291,  86, 59, 29, GAD_TOGGLE)
                                    };

/* GT-gadget data */
#define GAD_W       112
#define GAD_H       13

#define CTRLBOX_X   20 
#define CTRLBOX_Y   75
#define CTRLBOX_W   GAD_W+16
#define CTRLBOX_H   (GAD_H+2)*3+4+2

#define GAD_X       CTRLBOX_X+8
#define GAD_Y1      CTRLBOX_Y+4
#define GAD_Y2      GAD_Y1+GAD_H+2
#define GAD_Y3      GAD_Y2+GAD_H+2

#define GAD_SIDE    13
#define GAD_PAUSE   14
#define GTGADS      GAD_SIDE    /* gadgetID starts not at zero! */ 
#define GTGADNUM    2

static const char *sideLabels[]  = {"Side 2", "Side 1", NULL};
static const char *pauseLabels[] = {"Pause", "Game", NULL};

static const struct TagItem sideTags[]  = {GTCY_Labels, sideLabels, TAG_DONE}; 
static const struct TagItem pauseTags[] = {GTCY_Labels, pauseLabels, TAG_DONE}; 

static struct Gadget *gadList;
static struct GadgetData gtGads[] = {
        { NULL, CYCLE_KIND, 0, sideTags,  GAD_X, GAD_Y2, GAD_W, GAD_H, NULL},
        { NULL, CYCLE_KIND, 0, pauseTags, GAD_X, GAD_Y3, GAD_W, GAD_H, NULL}, 
}; 

/* Window data */
#define WINDOW_IDCMP    (IDCMP_MENUPICK|IDCMP_GADGETUP|IDCMP_REFRESHWINDOW|\
                         IDCMP_INTUITICKS|CYCLEIDCMP)
static struct Window    *win;
static struct Menu      *menu;
static struct RastPort  *rast;
static struct BitMap    *elements;

/* Window update flags */
#define UD_SIMPLE       0
#define UD_OPENHIGH     1
#define UD_NEWGAME      2
static short            updateCase = UD_SIMPLE;
static BOOL             updatePause;

/* Time display data */
static struct timeval gameTime, gameTimeBeg;
static struct IntuiText time = {
                        1, 0, JAM2, 0, 0, NULL, (UBYTE *) "0:00:00  ", NULL };

/* About requester data */
static const struct EasyStruct infoES = {
                                         sizeof (struct EasyStruct),
                                         0,
                                         GAME_NAME " Info",
                                         GAME_NAME " " VERSION "." REVISION
                                         " (" DATE ")\n"
                                         "Freely ditributable\n" 
                                         "© " CYEARS " Holger Brunst",
                                         "Cancel"
                                        };

/* Clock data */
static short    clkPos[18];
static BOOL     butPos[4];
static const long fmask[4] = {0x0000081b, 0x000200d8, 0x000081b0, 0x00000236};
static const long bmask[4] = {0x80006c01, 0x80036040, 0x8001b100, 0x80003604};
static const short clkPause[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};

/* Pointers to clock element data */
static short    *clkp;
static struct Element *clkf, *clkb, *buts, *butd;

/* Clock status flags */
#define FRONT_SIDE      TRUE
#define BACK_SIDE       !FRONT_SIDE
#define BUTTON_UP       TRUE
#define BUTTON_DOWN     !BUTTON_UP
#define LEFT_DIRECTION  1
#define RIGHT_DIRECTION -1
#define ALL_IMAGES      0x1fff
static BOOL  clockPaused = FALSE;
static BOOL  clockSide = BACK_SIDE;  /* TurnClock() will show front side */ 
static short clockNotCorrect; 

/* Control clock movement depending on buttons and clocks */ 
static ULONG MoveClock(USHORT gad)
{
 /* Init changes to none */
 ULONG changes = 0; 

 /* Clocks? */
 if (gad < 8) {
                short i, d;
                ULONG buf;

                /* Backside? */
                if (clockSide == BACK_SIDE)
                 /* Yes, use reversed gadgetID */ 
                 gad = 7 - gad;

                /* Move to which direction? */
                if (gad < 4)
                 d = RIGHT_DIRECTION;
                else {
                 d = LEFT_DIRECTION;
                 gad -= 4;
                }

                /* Is corresponding button up? */
                if (butPos[gad] == BUTTON_UP) {
                 /* Yes, find clocks to be moved */
                 for (i = 0; i < 4; ++i)
                  if (butPos[i] == BUTTON_UP)   /* Buttons up? */
                   changes |= fmask[i];
                }
                else {
                 /* No, find clocks to be moved */
                 for (i = 0; i < 4; ++i)
                  if (butPos[i] == BUTTON_DOWN) /* Buttons down? */
                   changes |= bmask[i];
                }

                /* Move selected clocks */
                clockNotCorrect = 0;    /* Set clockNotCorrect to FALSE */
                buf = changes;          /* Remember clocks to be updated */

                /* Check all clocks */
                for (i = 0; i < 18; ++i) {
                 /* Change-bit set? */ 
                 if ((buf & 1)) {
                  clkPos[i] += d;       /* Increase/decrease clock posions */
                  if (clkPos[i] > 11)
                   clkPos[i] = 0;
                  if (clkPos[i] < 0)
                   clkPos[i] = 11;
                 }
                 buf >>= 1;             /* Next change-bit */

                 /* If all clocks are at twelve clockNotCorrect is 0 */
                 clockNotCorrect += clkPos[i];
                }
  
                /* Are we on the frontside? */
                if (clockSide == FRONT_SIDE)
                 /* Yes, clear backside signal bits */
                 changes &= 0x1ff;
                else
                 /* No, shift backside signal bits to relevant position */
                 changes >>= 9;
               }
  
 /* Buttons? */
 else 
 if (gad < 12) {
                /* Relate buttonID to 0 */
                gad -= 8;

                /* Backside? */
                if (clockSide == BACK_SIDE)
                 /* Yes, use reversed gadgetID */
                 gad  = 3 - gad;

                /* Signalize toggled button */
                changes |= 0x200 << gad;

                /* toggle button */
                butPos[gad] = !butPos[gad];
               }
 return (changes); 
}

/* Update clock graphics */
static void UpdateClock(ULONG changes)
{
 short i;

 /* Do we have to update a clock? */
 for (i = 0; i < 9; ++i) {
  if (changes & 1) { 

   /* Yes, first we assemble the bachground and forground */
   BltBitMap(elements, clkb[i].x, clkb[i].y,
             elements, 576, 224,
             64, 32, 0xc0, 0xf,
             NULL); 
   BltBitMap(elements, clkf[clkp[i]].x, clkf[clkp[i]].y,
             elements, 576, 224,
             64, 32, 0xe0, 0xf,
             NULL);

   /* To avoid flickering we then make one single 'blit' */
   BltBitMapRastPort(elements, 576, 224,
                     rast, clkDst[i].x, clkDst[i].y,
                     64, 32, 0xc0);
  }
  changes >>= 1;
 }
 /* And the buttons? */
 for (i = 0; i < 4; ++i) {
  if (changes & 1) { 

   /* Yes. Button up? */
   if (butPos[i] == BUTTON_UP) {
    BltBitMapRastPort(elements, buts[i].x, buts[i].y,
                      rast, butd[i].x, butd[i].y,
                      32, 16, 0xc0);
   }
   else {
    BltBitMapRastPort(elements, buts[4+i].x, buts[4+i].y,
                      rast, butd[i].x, butd[i].y,
                      32, 16, 0xc0);
   }
  }
  changes >>= 1;
 }
}

/* Turn clock to certain side.
   Because of refreshing it is necessary to know 'who' wants
   to turn the clock */
static void TurnClock(BOOL side, USHORT who)
{
 /* Are we already on the right side? */
 if (clockSide != side) {
  /* No. We don't want to see the blitter work */
  Zoom(Screen, darknes, 16);

  /* Blit frontside or backside clock image */
  if (side == FRONT_SIDE) {
   BltBitMapRastPort(elements,   0,  0, rast,  176, 28, 288, 144, 0xc0);
   clkf = clkFor;
   clkb = clkBak;
   clkp = clkPos;
   buts = butSrc;
   butd = butDst;
  }
  else {
   BltBitMapRastPort(elements, 288,  0, rast,  176, 28, 288, 144, 0xc0);
   clkf = &clkFor[12];  
   clkb = &clkBak[9];
   clkp = &clkPos[9];  
   buts = &butSrc[8];
   butd = &butDst[4];
  }

  /* Refresh side cycle gadget if necessary */
  if (who != GAD_SIDE);
   GT_SetGadgetAttrs(gtGads[GAD_SIDE-GTGADS].gadget, win, NULL,
                     GTCY_Active, (side == FRONT_SIDE)? 0:1,
                     TAG_DONE);

  /* Refresh each clock */
  clockSide = side;
  UpdateClock(ALL_IMAGES);

  /* Turn the light back on */
  Zoom(Screen, (USHORT *) &elements->Planes[6], 16);
 }
}

/* Activate/deactivate clock */
static void PauseClock(BOOL status, USHORT who)
{
 static struct timeval pauseBeg;

 /* Clock already at demanded status */
 if (status != clockPaused) {
  /* No. Pause clock? */
  if (status) {
   /* Yes, set pause flag */
   clockPaused = status;

   /* Remember passed time */
   GetSysTime(&pauseBeg);

   /* Deactivate clock controls */   
   GT_SetGadgetAttrs(gtGads[GAD_SIDE-GTGADS].gadget, win, NULL,
                     GA_Disabled, TRUE,
                     TAG_DONE);
   OffMenu(win, 0xffe1);

   /* Midnight */
   clkp = clkPause;
   UpdateClock(ALL_IMAGES);
  }
  else {
   /* No, back to user's chaos */
   if (clockSide == FRONT_SIDE)
    clkp = clkPos;
   else
    clkp = &clkPos[9];
   UpdateClock(ALL_IMAGES);

   /* Reactivate clock controls */
   GT_SetGadgetAttrs(gtGads[GAD_SIDE-GTGADS].gadget, win, NULL,
                     GA_Disabled, FALSE,
                     TAG_DONE);
   OnMenu(win, 0xffe1);

   /* Start time counter */
   SubTime(&pauseBeg, &gameTimeBeg);
   AddTime(&gameTime, &pauseBeg);
   GetSysTime(&gameTimeBeg);

   /* Clear pause flag */
   clockPaused = status;
  }

  /* If necessary refresh 'pause cycle gadget' */
  if (who != GAD_PAUSE)
   GT_SetGadgetAttrs(gtGads[GAD_PAUSE-GTGADS].gadget, win, NULL,
                     GTCY_Active, (clockPaused == TRUE)? 1:0,
                     TAG_DONE);
 }
}

/* Move clocks to random positions */
static void RandomClock(void)
{
 short  i;
 long   sec, mic;

 /* Get start value for random function */
 CurrentTime(&sec, &mic);
 srand(mic);

 /* 50 changes should be enough */
 for (i = 50; i > 0; i--) {
  MoveClock(GAD_BUT1 + (rand() & 3));
  MoveClock(GAD_CLK1L + (rand() & 3));
 }

 /* Display changes */
 UpdateClock(ALL_IMAGES);
}

/* Reset clock to default */ 
static void ResetClock(void)
{
 short i;

 /* Midnight */
 for (i = 0; i < 18; i++) clkPos[i] = 0;
 for (i = 0; i < 4; i++) butPos[i] = BUTTON_UP;

 /* Draw boxes */
 DrawBevelBox(rast, GAD_X, GAD_Y1, GAD_W, GAD_H,
              GT_VisualInfo, ScreenVI,
              GTBB_Recessed, TRUE, 
              TAG_DONE);

 /* Draw clock image */
 if (clockSide == BACK_SIDE)
  TurnClock(FRONT_SIDE, -1);

 /* Clocks to random position */
 RandomClock();

 /* Reset & start game time */
 PauseClock(FALSE, ~0);
 GetSysTime(&gameTimeBeg);
 gameTime.tv_secs = 0; gameTime.tv_micro = 0; 
}

/* Open the clock */
ULONG OpenClockWindow(void)
{
 /* Open clock gfx elements */ 
 if (elements = OpenILBM(PIC_NAME)) {
  /* Set colors */
  LoadRGB4(&Screen->ViewPort, (USHORT *) &elements->Planes[6], 16); 
  /* Create menus */
  if (menu = CreateMenus(mdata, GTMN_FullMenu, TRUE, 
                                TAG_DONE)) {
   /* Layout menus */ 
   if (LayoutMenus(menu, ScreenVI, TAG_DONE))
    /* Create gadgets */
    if (gadList = CreateGadgetList(gtGads, GTGADNUM, GTGADS)) {
     /* Open window */
     if (win = OpenWindowTags(NULL, WA_Width, 640,
                                    WA_Height, 200,
                                    WA_PubScreen, Screen,
                                    WA_Gadgets, gads,
                                    WA_Flags, WFLG_BACKDROP|WFLG_SMART_REFRESH|
                                              WFLG_BORDERLESS|WFLG_ACTIVATE,
                                    WA_IDCMP, WINDOW_IDCMP,
                                    TAG_DONE)) {
      /* Set menu strip */
      if (SetMenuStrip(win, menu)) {

       /* Add gadgets to window */
       AddGList(win, gadList, ~0, ~0, NULL);
       RefreshGList(gadList, win, NULL, ~0);
       GT_RefreshWindow(win, NULL);

       /* Get rast-port */
       rast = win->RPort;
       
       /* Draw signature */
       BltBitMapRastPort(elements, 512, 208, rast,  580, 172, 60, 28, 0xc0);

       /* Init clocks */
       ResetClock();

       /* Link IDCMP routine to window */ 
       IDCMPPort = win->UserPort;
       win->UserData = HandleClockWindowIDCMP;

       /* All done correctly. Return IDCMP signal mask */ 
       return (1L << IDCMPPort->mp_SigBit);
      }
      CloseWindow(win);
     }
     FreeGadgets(gadList);
    } 
   FreeMenus(menu);
  }
  CloseILBM(elements);
 }
 /* fail */
 return (NULL);
}

/* Close all */
void CloseClockWindow(void)
{
 RemoveGList(win, gadList, ~0);
 ClearMenuStrip(win);
 CloseWindow(win);
 FreeGadgets(gadList);
 FreeMenus(menu);
 CloseILBM(elements);
} 

/* Handle window idcmp messages */
void *HandleClockWindowIDCMP(struct IntuiMessage *msg)
{
 switch (msg->Class) {

  /* Gadgets */
  case IDCMP_GADGETUP: {
   USHORT   gad = (((struct Gadget *) msg->IAddress)->GadgetID);

   /* Handle GT-gadgets */
   switch (gad) {

    /* Toggle side? */
    case GAD_SIDE:  TurnClock(!clockSide, GAD_SIDE);
                    break;
    /* Pause or activate game */
    case GAD_PAUSE: PauseClock(!clockPaused, GAD_PAUSE);
                    break;
   }

   /* Handle standard boolean gadgets if game is not paused */
   if (!clockPaused) {
    switch (gad) {

     /* Toggle side? */
     case GAD_TOGGLE: TurnClock(!clockSide, GAD_TOGGLE);
                      break;

     /* Any clock or button pressed? */
     default:         UpdateClock(MoveClock(gad));
                      /* Clock ok.? */
                      if (!clockNotCorrect) {
                       struct timeval gameTimeEnd;

                       /* Calculate & remember passed time */
                       clockPaused = TRUE;
                       GetSysTime(&gameTimeEnd);
                       SubTime(&gameTimeEnd, &gameTimeBeg);
                       AddTime(&gameTime, &gameTimeEnd);

                       /* Is it a new highscore */
                       if (AskHighScore(gameTime.tv_secs)) {
                        /* Yes, init window update environment */
                        UpdateWindow = UpdateClockWindow;
                        updateCase = UD_OPENHIGH;

                        /* Did open namewindow succeed? */
                        if (OpenNameWindow())
                         /* Yes, disable clock window */
                         DisableWindow(win);
                        else {
                         /* No, beep and update */  
                         DisplayBeep(Screen);
                         return ("MrS. NotEnoughMem");                                        
                        }
                       }
                       else {
                        /* No, show highscore */
                        UpdateWindow = UpdateClockWindow;
                        updateCase = UD_NEWGAME;
 
                        /* Did open highwindow succeed? */
                        if (OpenHighWindow())
                         /* Yes, disable clock window */
                         DisableWindow(win);
                        else {
                         /* No, beep and update */  
                         DisplayBeep(Screen);
                         return (TRUE);
                        }
                       } 
                      }
                      break;
    }
   }
   break;
  }
  /* Menus */
  case IDCMP_MENUPICK: {
   USHORT number = msg->Code;
   struct MenuItem *item;

   /* Scan all menu events */
   while (number != MENUNULL) {
    item = ItemAddress(menu, number);  

    /* Which menu selected? */
    switch (GTMENUITEM_USERDATA(item)) {

     case MENU_NEW:   ResetClock();
                      break;

     case MENU_HIGH:  /* pause clock */
                      updatePause = clockPaused;
                      PauseClock(TRUE, ~0);

                      /* Open highwindow ok.? */
                      if (OpenHighWindow()) {
                       /* Yes, set update environment */
                       DisableWindow(win);
                       updateCase = UD_SIMPLE;
                       UpdateWindow = UpdateClockWindow;
                      }
                      else {
                       /* No, beep */
                       DisplayBeep(Screen);
                       PauseClock(updatePause, ~0);
                      }
                      break;

     case MENU_ABOUT: /* pause clock */
                      updatePause = clockPaused;
                      PauseClock(TRUE, ~0);

                      /* Open info requester */
                      DisableWindow(win);
                      EasyRequest(win, &infoES, NULL, NULL);
                      EnableWindow(win, WINDOW_IDCMP);

                      PauseClock(updatePause, ~0);
                      break;

     case MENU_QUIT:  /* First reply message */
                      GT_ReplyIMsg(msg); 
                      return (TRUE);

     case MENU_SIDE1: TurnClock(FRONT_SIDE, -1);
                      break;

     case MENU_SIDE2: TurnClock(BACK_SIDE, -1);
                      break;

     case MENU_RAND:  RandomClock();
                      break;

     case MENU_PAUSE: PauseClock(!clockPaused, ~0);
                      break;
    }
    number = item->NextSelect;
   }
   break;
  }
  /* Update time display */
  case IDCMP_INTUITICKS: {
                          ULONG secs, hour;
                          struct timeval curr;

                          /* Game not paused? */
                          if (!clockPaused) {

                           /* Calculate passed game time */
                           GetSysTime(&curr);
                           SubTime(&curr, &gameTimeBeg);
                           AddTime(&curr, &gameTime);

                           /* I know stdio...
                              but it's the easiest way to convert bin to dec */ 
                           secs = curr.tv_secs;
                           hour = secs / 3600;
                           sprintf(time.IText, "%01ld:%02ld:%02ld  ",
                                   hour,
                                   secs / 60 - hour * 60,
                                   secs % 60); 
                           PrintIText(rast, &time, GAD_X+GAD_W/4, GAD_Y1+2);
                          }
                          break;
                         }
  /* Necessary because of GT */
  case IDCMP_REFRESHWINDOW: GT_BeginRefresh(win);
                            GT_EndRefresh(win, TRUE);
                            break;
 }
 return (NULL);
}

/* Update clock window */
void UpdateClockWindow(void *data)
{
 switch (updateCase) {

  /* Simple update after a window has been closed */
  case UD_SIMPLE:   UpdateWindow = NULL;
                    EnableWindow(win, WINDOW_IDCMP); 
                    PauseClock(updatePause, ~0);       
                    break;

  /* Open the highscore window after new name has been entered */
  case UD_OPENHIGH: InsertHighScore(data, gameTime.tv_secs);
                    /* Open highscore window ok.? */
                    if (OpenHighWindow()) {
                     /* Yes */
                     updateCase = UD_NEWGAME;
                     break;                     
                    }                    
                    /* No */
                    DisplayBeep(Screen);
                    /* Run trough */                     

  /* Start new game after someone's been successful */
  case UD_NEWGAME:  ResetClock();
                    UpdateWindow = NULL;
                    EnableWindow(win, WINDOW_IDCMP); 
                    break;
 }
}
