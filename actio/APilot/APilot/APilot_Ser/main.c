/**************************************************************************
 *
 * main.c -- APilot, an xpilot like game for the Amiga.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

/*------------------------------------------------------------------------*/

#include <math.h> 
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <exec/types.h>             /* The Amiga data types file.         */
#include <exec/memory.h>
#include <devices/input.h>
#include <devices/timer.h>
#include <intuition/intuition.h>    /* Intuition data strucutres, etc.    */
#include <graphics/displayinfo.h>   /* Release 2 Amiga display mode ID's  */
#include <libraries/dos.h>          /* Official return codes defined here */

#include <proto/exec.h>
#include <proto/input.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/diskfont.h>
#include <proto/timer.h>
#include <proto/dos.h>

#include <libraries/asl.h>
#include <proto/asl.h>

/*------------------------------------------------------------------------*/

#include "map_protos.h"
#include "points_protos.h"
#include "ships_protos.h"
#include "lists_protos.h"
#include "cannon_protos.h"
#include "collision_protos.h"
#include "fuelpod_protos.h"
#include "misc_protos.h"
#include "vertb_protos.h"
#include "prefs_protos.h"
#include "serial_protos.h"
#include "main_protos.h"

#include "common.h"
#include "vertb.h"
#include "map.h"
#include "prefs.h"

/*------------------------------------------------------------------------*/

/* Disable ctrl-c handling */
void __regargs __chkabort(void);
void __regargs __chkabort(void) { return; }

/*------------------------------------------------------------------------*/

char *version = "$VER: APilot_Ser is still beta (22.03.94)";

/*------------------------------------------------------------------------*/

/*
 * This is where all the action is
 */
AWorld World;

/*
 * For rawkey interpreting.
 */
#define RAWKEY_KP_MINUS 74
#define RAWKEY_KP_PLUS  94
#define RAWKEY_KP_STAR  93
#define RAWKEY_F        35
#define RAWKEY_T        20
#define RAWKEY_Q        16
#define RAWKEY_A        32
#define RAWKEY_S        33
#define RAWKEY_ENTER    68
#define RAWKEY_SPACE    64

/* This one is for the screenmode, sizes, etc. */
UserPrefs prefs;

#ifdef CPU_USAGE
static BOOL   cpu_meter   = FALSE;
struct Library *TimerBase = NULL;
static struct timerequest tr;
#endif

/*
 * Global structures and variables needed in this file
 */
static BYTE   deviceopen  = 1;
static UWORD  w_framerate = APILOT_NFR;  /* Wanted framerate */
static UWORD  oldrptdelay;
static struct TextFont    *hudFont  = 0;
static struct Screen      *myScreen = NULL;
static struct Window      *myWindow = NULL;
static struct BitMap      *myBitMap[MY_BUFFERS];
static struct RastPort    myRP[MY_BUFFERS];
static struct DBufInfo    *myDBI     = NULL;
static struct MsgPort     *inputPort = NULL;
static struct MsgPort     *dbufport  = NULL;
static struct timerequest *inputReqBlk = NULL;

/*------------------------------------------------------------------------*/

/*
 * init_world -- Initializes all data in the World structure.
 *
 */
void
init_world( void )
{
  APTR *dummy;

  World.Height = 0;
  World.Width  = 0;

  World.gravity = DEF_GRAVITY * PRECS;

  if ( (World.players = (AShip *) malloc(sizeof(AShip))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for players.\n" );
  if ( (dummy =  malloc(sizeof(AShip))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for players.\n" );
  ((AShip *)dummy)->next = (AShip *)dummy;
  World.players->next = (AShip *)dummy;

  if ( (World.fuelpods = (AFuelPod *) malloc(sizeof(AFuelPod))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for fuelpods.\n" );
  if ( (dummy =  malloc(sizeof(AFuelPod))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for fuelpods.\n" );
  ((AFuelPod *)dummy)->next = (AFuelPod *)dummy;
  World.fuelpods->next = (AFuelPod *)dummy;

  if ( (World.cannons = (ACannon *) malloc(sizeof(ACannon))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for cannons.\n" );
  if ( (dummy = malloc(sizeof(ACannon))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for cannons.\n" );
  ((ACannon *)dummy)->next = (ACannon *)dummy;
  World.cannons->next = (ACannon *)dummy;

  if ( (World.bases = (ABase *) malloc(sizeof(ABase))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for bases.\n" );
  if ( (dummy = malloc(sizeof(ABase))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for bases.\n" );
  ((ABase *)dummy)->next = (ABase *)dummy;
  World.bases->next = (ABase *)dummy;

  if ( (World.players = (AShip *) malloc(sizeof(AShip))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for players.\n" );
  if ( (dummy = malloc(sizeof(AShip))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for players.\n" );
  ((AShip *)dummy)->next = (AShip *)dummy;
  World.players->next = (AShip *)dummy;
  
  World.points  = NULL;

  /* Local stuff */
  World.framerate = APILOT_NFR;
  World.hudon     = TRUE;
  World.shld_bm   = NULL;
}

/*------------------------------------------------------------------------*/

/*
 * init_display -- Opens a screen with a backdrop window.
 *             
 */
void
init_display( void )
{
  int    h, i, j;
  int    myScreenLEdge;
  struct Screen wbScreen;
  struct RastPort rp;
  UWORD  pens[] = { (UWORD)~0 };
  
#ifdef DYN_SCR
  struct ScreenModeRequester *req;
  char *Postext = "Play";
  char *Toptext = "Select APilot ScreenMode";
#endif
  
  /* The first white will be faded to black later for a nice effect :) */
  struct ColorSpec mycolors[] = { { 0, 15, 15, 15 },        /* White */
                                  { 1, 13,  4,  4 },        /* Red   */
                                  { 2,  5,  5, 14 },        /* Blue  */
                                  { 3, 13, 13, 13 },        /* White */
                                  {-1,  0,  0,  0 } };

  /***************************************************************
   * SAS Handles auto-opening and closing of all needed librarys *
   ***************************************************************/ 

#ifdef DYN_SCR

  if (!prefs.native_mode) {
    /* Allocate requester, seems like  the player want another screenmode  */
    if ((req = AllocAslRequestTags(ASL_ScreenModeRequest,
				   ASLSM_DoOverscanType,1,
				   ASLSM_MinWidth,MINResX,
				   ASLSM_MaxWidth,MAXResX,
				   ASLSM_MinHeight,MINResY,
				   ASLSM_MaxHeight,MAXResY,
				   ASLSM_TitleText,Toptext,
				   ASLSM_PositiveText,Postext,
				   TAG_DONE)) == NULL)
      cleanExit( RETURN_WARN, "** Unable to allocate screenmode-requester.\n" );
    
    /* Prompt user */
    if (!AslRequestTags(req,
			ASLSM_DoOverscanType,1,
			ASLSM_MinWidth,MINResX,
			ASLSM_MaxWidth,MAXResX,
			ASLSM_MinHeight,MINResY,
			ASLSM_MaxHeight,MAXResY,
			ASLSM_TitleText,Toptext,
			ASLSM_PositiveText,Postext,
			TAG_DONE))
      cleanExit( RETURN_WARN, "** Unable to get screenmode.\n" ); 
    
    /* Requester turned out successfully, store values */
    prefs.dpy_oscan = req->sm_OverscanType;
    prefs.dpy_width = (int) (req->sm_DisplayWidth-1) | 1;  /* Ensure odd values */
    prefs.dpy_height = (int) (req->sm_DisplayHeight-1) | 1;
    prefs.dpy_modeid = req->sm_DisplayID;
  
    /* Now free requester memory */
    FreeAslRequest(req);
  }

#endif
  
  /* Allocate all bitmaps needed for display buffering. */
  for( i = 0; i < MY_BUFFERS; i++ ) {
    myBitMap[i] = AllocBitMap( SCR_WIDTH  + MAP_BLOCKSIZE*2,
			      SCR_HEIGHT + MAP_BLOCKSIZE*2,
			      SCR_DEPTH, 
			      BMF_CLEAR|BMF_DISPLAYABLE, NULL );
    
    if( myBitMap[i] == NULL )
      cleanExit( RETURN_WARN, "** Unable to allocate bitmaps.\n" );
    
    /* Init the rastport and attach the corresponding bitmap */
    InitRastPort( &myRP[i] );
    myRP[i].BitMap = myBitMap[i];
  }
  
  /*
   * Make a temporatry bitmap which we will use to draw the
   * ship shield images into. The bitmap will then later be used for 
   * blitting the shield images to display memory.
   */
  World.shld_bm = AllocBitMap( (SHL_SIZE*2+1)*SHL_ANIM, 
                               SHL_SIZE*2+1,
                               SCR_DEPTH, 
                               BMF_CLEAR|BMF_DISPLAYABLE, 
                               myBitMap[0] );
  if ( World.shld_bm == NULL )
    cleanExit( RETURN_WARN, "** Unable to allocate bitmaps.\n" );
  
  InitRastPort( &rp );
  rp.BitMap = World.shld_bm;
  
  /* Draw some shield images for animation. */
  for (i = 0; i < SHL_ANIM; i++)
    DrawEllipse(&rp, SHL_SIZE+((SHL_SIZE*2+1)*i), SHL_SIZE, SHL_SIZE, SHL_SIZE);

  /*
   * Draw some 'holes' into the circles so they look nicer. Last image is
   * kept from being changed, as it is used for clearing.
   */
  SetAPen(&rp, 0);

  for (h = 0; h < SHL_ANIM-1; h++)
    for (i = 0, j = h; i < 360; i++,j++) { 
      if (j > 15)
        WritePixel(&rp, (long)(SHL_SIZE+0.5 + 
                               SHL_SIZE * sin((double)PI/180*i)) + ((SHL_SIZE*2+1)*h),
                        (long)(SHL_SIZE+0.5 + 
                               SHL_SIZE * cos((double)PI/180*i)));
      if (j >= 20) j = 0;
    }

  /*
   * Get info about the wb screen so we can nicely center our own
   * screen in the 'middle' of the wbscreen. We don't need this for
   * dynamic screens, as they use standard clip-regions.
   *
   * Yes we do :) Think about an apilot screen smaller than the
   * wbscreen for example. Could happen if the user does NOT
   * choose the screenmode-requester option in the command line.
   * A smaller screen would be positioned at the left border
   * of the standard clip-region..Looks ugly :(
   */
  GetScreenData(&wbScreen, sizeof(struct Screen), WBENCHSCREEN, NULL);
  myScreenLEdge = (wbScreen.Width-SCR_WIDTH)/2 + wbScreen.LeftEdge;
  if (myScreenLEdge < 0) myScreenLEdge = 0;
  
  /* Open the screen */
  myScreen = OpenScreenTags(NULL,
                            SA_Left,      myScreenLEdge,
                            SA_Width,     SCR_WIDTH,
                            SA_Height,    SCR_HEIGHT, 
                            SA_BitMap,    myBitMap[0],
                            SA_Pens,      (ULONG)pens, 
                            SA_Colors,    mycolors,
                            SA_DisplayID, prefs.dpy_modeid,
                            SA_AutoScroll,0,
                            SA_Overscan,  prefs.dpy_oscan,
                            SA_Quiet,     1,
                            SA_Type,      CUSTOMSCREEN | CUSTOMBITMAP,
                            SA_Depth,     SCR_DEPTH,
                            SA_Title,     (ULONG)"APilot",
                            TAG_DONE);
  
  if (myScreen != NULL) {

    /* 
     * Now set the bitmap offsets so that part of the bitmap is outside
     * the visible screen. This way we don't have to do line clipping
     * on map-blocks and ships.
     */
    myScreen->ViewPort.RasInfo->RxOffset = MAP_BLOCKSIZE; 
    myScreen->ViewPort.RasInfo->RyOffset = MAP_BLOCKSIZE;
    ScrollVPort(&myScreen->ViewPort);

    /* Make the screen titlebar go behind the Backdrop window */
    ShowTitle(myScreen, FALSE);

    /* ... and open the window */
    myWindow = OpenWindowTags(NULL,
                              /* Specify window dimensions and limits */
                              WA_Left,         0,
                              WA_Top,          0,
                              WA_Width,        SCR_WIDTH,
                              WA_Height,       SCR_HEIGHT,
                              WA_MaxWidth,     ~0,
                              WA_MaxHeight,    ~0,
                              /* Specify the system gadgets we want */
                              WA_CloseGadget,  FALSE,
                              WA_SizeGadget,   FALSE,
                              WA_DepthGadget,  FALSE,
                              WA_DragBar,      FALSE,
                              WA_Borderless,   TRUE,
                              /* Specify other attributes           */
                              WA_RMBTrap,      TRUE,
                              WA_RptQueue,     0,
                              WA_Backdrop,     FALSE,
                              WA_Activate,     TRUE,
                              WA_NoCareRefresh,TRUE,
                              /* Specify the events we want to know about */
                              WA_IDCMP,        IDCMP_RAWKEY |
                                               IDCMP_INACTIVEWINDOW |
                                               IDCMP_ACTIVEWINDOW,
                              /* Attach the window to the open screen ...*/
                              WA_CustomScreen, myScreen,
                              WA_Title,        NULL,
                              WA_ScreenTitle,  NULL,
                              TAG_DONE);
    if (myWindow != NULL) {
      do_fade();
      return;
    }
  }
  cleanExit( RETURN_WARN, "** Unable to initialize screen\n" );  
}

/*------------------------------------------------------------------------*/

/*
 * init_font -- Opens a font from disk for the HUD display.
 *
 */
void
init_font(void)
{
  int i;
  struct TextAttr  hudtextAttr;

  hudtextAttr.ta_Name  = "SystemThin.font";
  hudtextAttr.ta_YSize = 8;
  hudtextAttr.ta_Style = FS_NORMAL;
  hudtextAttr.ta_Flags = FPF_DISKFONT | FPF_DESIGNED;

  if ((hudFont = OpenDiskFont(&hudtextAttr)) == 0)
    cleanExit( RETURN_WARN, "** Unable to open font 'SystemThin'." );
  
  for (i = 0; i < MY_BUFFERS; i++) {
    SetFont(&myRP[i], hudFont);
  }
}  

/*------------------------------------------------------------------------*/

/*
 * do_fade -- Smoothly fades the screen from white to black
 *
 */
void
do_fade(void)
{
  int i, r, g;
  UWORD color[] = { 0x0fff };

  r = g = 15;

  for (i = 0; i < 15; i++) {
    /* Red */
    color[0] = ( (color[0] & 0x00ff) | ((--r) << 8) );
    WaitTOF();
    WaitTOF();
    LoadRGB4(&myScreen->ViewPort, color, 1);
    /* Green */
    color[0] = ( (color[0] & 0x0f0f) | ((--g) << 4) );
    WaitTOF();
    LoadRGB4(&myScreen->ViewPort, color, 1);
    /* Blue */
    color[0]--;
    WaitTOF();    
    LoadRGB4(&myScreen->ViewPort, color, 1);
  }
}    


/*------------------------------------------------------------------------*/

/*
 * init_kbdrepeat -- Sets up structures for keyboard repeat modifying.
 *                   Repeats are modified because keyboard repeating
 *                   creates lag. Should perhaps read keys directly
 *                   from keyboard.device..Shrug. This is still the
 *                   easiest way I think.
 */
void
init_kbdrepeat(void)
{
  struct shortprefs {
    BYTE dummy1;
    UBYTE dummy2;
    UWORD dummy3;
    struct timeval dummy4;
    struct timeval keyRptDelay;
  } myPrefs;

  GetPrefs( (struct Preferences *) &myPrefs, sizeof(struct shortprefs) );
  oldrptdelay = myPrefs.keyRptDelay.tv_secs;

  if (!(inputPort = CreatePort( NULL, NULL )))
    cleanExit( RETURN_WARN, "** Unable to create message port\n" );
  if (!(inputReqBlk = (struct timerequest *) 
       CreateExtIO(inputPort, sizeof(struct timerequest))))
    cleanExit( RETURN_WARN, "** Unable to CreateExtIO()\n" ); 
  if ((deviceopen = OpenDevice("input.device", NULL, 
                               (struct IORequest *)inputReqBlk, NULL)))
    cleanExit( RETURN_WARN, "** Unable to open input.device\n" );

  inputReqBlk->tr_node.io_Command = IND_SETTHRESH;
  inputReqBlk->tr_time.tv_secs  = 0;
  inputReqBlk->tr_time.tv_micro = myPrefs.keyRptDelay.tv_micro;
}

/*------------------------------------------------------------------------*/

/*
 * Main...
 */
void
main(int argc, char *argv[])
{
  int   over = 0;
  int   frameinfo[4] = { 0, 0, 0, 0 };
  UWORD a_framerate;                   /* Actual framerate */

#ifdef CPU_USAGE
  int    cpu_usage;
  int    avg_cpu_usage  = 0;
  int    topcounter     = 75;
  int    top_cpu_usage  = 0;
  int    top_cpu_usage2 = 0;
  int    min_cpu_usage  = 100;
  ULONG  e_freq, time1, time2; 
  struct EClockVal eclock;
#endif

  AShip           myShip, remoteShip;
  UWORD           CurBuffer;
  ULONG           vb_signal;
  extern UWORD    vb_counter;         /* This comes from our vblank server */
  struct ViewPort *scrnVP;
  struct Task     *my_task;

  /*
   * Parse commandline for eventual options, and set default prefs.
   */
  set_prefs();

  /*
   * Init everything..
   */
  CurBuffer = 1;
  my_task   = FindTask(NULL);
  vb_signal = init_VertBServer();
  init_world();

  if (prefs.noserial == FALSE)
    init_connection();

  init_map();
  init_display();
  init_font();
  init_kbdrepeat();
  init_sctables();
#ifndef PURE_OS
  init_writepixel(myBitMap[0]->BytesPerRow);
#endif
  init_points();
  init_explosion();
  if (World.host) {
    init_ship(&myShip);
    init_ship(&remoteShip);
  } else {
    init_ship(&remoteShip);
    init_ship(&myShip);
  }  
  remoteShip.shields = FALSE;
  remoteShip.local   = FALSE;

  remoteShip.next = World.players->next;
  World.players->next = &remoteShip;
  myShip.next = World.players->next;
  World.players->next = &myShip;

  World.local_ship  = &myShip;
  World.remote_ship = &remoteShip;

  /*
   * Send this once so the loop can get started.
   */
  send_local(APILOT_NFR);


#ifdef CPU_USAGE
    if (OpenDevice("timer.device", UNIT_MICROHZ, (struct IORequest *) &tr, 0))
      cleanExit( RETURN_WARN, "** Failed to open timer.device.\n");

    TimerBase = (struct Library *)tr.tr_node.io_Device;
    /* Count how many e-ticks per screen update (50Hz) */
    e_freq = (ReadEClock(&eclock) / 100) * APILOT_NFR;
#endif    

  /*
   * Set up needed structures for double-buffering..
   */
  if ((dbufport = CreateMsgPort()) == NULL)
    cleanExit( RETURN_WARN, "** Unable to create message port\n" );

  scrnVP = &myScreen->ViewPort;
  if ((myDBI = AllocDBufInfo( scrnVP )) == NULL)
    cleanExit( RETURN_WARN, "** Unable to allocate DBufInfo\n" );

  myDBI->dbi_SafeMessage.mn_ReplyPort = dbufport;
  myDBI->dbi_DispMessage.mn_ReplyPort = NULL;

  vb_counter = 0;

  /*
   * Main loop...
   */
  while (TRUE) {

    a_framerate = vb_counter+1;
    if (a_framerate < 5 ) 
      frameinfo[a_framerate-1]++;

/*----------------------------------------------------*/
/* This part is run on a higher priority to eliminate */
/* flicker. This has VERY little impact on overall    */
/* system performace but is needed because for some   */
/* reason WaitTOF() isn't always very accurate on     */
/* lower priorities.                                  */
/*----------------------------------------------------*/
    SetTaskPri(my_task, 30); 
    if (a_framerate > APILOT_NFR) {
      over++;
      WaitTOF();
    }
    Wait(vb_signal);

#ifdef CPU_USAGE
    ReadEClock(&eclock);
    time1 = eclock.ev_lo;
#endif

    WaitBlit();
    ChangeVPBitMap(scrnVP, myBitMap[CurBuffer], myDBI);
    SetTaskPri(my_task,0); 
/*---------------------------------------------------*/

    CurBuffer ^= 1; 
    vb_counter = 0;

    /*
     * Update everything...
     */
    move_points(CurBuffer, w_framerate);  
    update_ship(&myShip, CurBuffer, w_framerate); 

    /*
     * Read what the remote ship is doing and then
     * update it.
     */
    if (update_remote(CurBuffer, w_framerate) == TRUE) {
      printf("Remote quit.\n");
      break;
    }

    update_cannons(&myShip, w_framerate); 
    update_fuelpods(w_framerate);
    check_collisions();

    /*
     * Now we read what the local ship is doing and then send
     * it over to the remote player.
     */
    if (handleIDCMP() == TRUE) {
      send_quit();
      break;
    }
    send_local(w_framerate);

    /* 
     * Wait for the 'safe to write' message 
     */
    while (!GetMsg(dbufport)) Wait(1l<<(dbufport->mp_SigBit));

    /*
     * Draw everything...
     */
    draw_ship(&myShip, &myRP[CurBuffer], CurBuffer);
    draw_ship(&remoteShip, &myRP[CurBuffer], CurBuffer);

#ifdef PURE_OS
    draw_points(&myShip, &myRP[CurBuffer], CurBuffer, w_framerate); 
#else
    draw_points(&myShip, myBitMap[CurBuffer], CurBuffer, w_framerate); 
#endif

    /* draw_map calls draw_hud */
    draw_map(&myRP[CurBuffer], &myShip, CurBuffer, w_framerate);


#ifdef CPU_USAGE
    ReadEClock(&eclock);
    time2 = eclock.ev_lo;

    cpu_usage = (abs(time2-time1)*(200/w_framerate))/e_freq % 300;
    /* Average of 2 just to smooth it a little. */
    avg_cpu_usage = (cpu_usage + avg_cpu_usage) / 2;

    if (cpu_usage > top_cpu_usage)
      top_cpu_usage = cpu_usage;
    if (cpu_usage > top_cpu_usage2)
      top_cpu_usage2 = cpu_usage;
    if (cpu_usage < min_cpu_usage)
      min_cpu_usage = cpu_usage;
    if (topcounter-- <= 0) {
      topcounter    = 75;
      top_cpu_usage = 0;
    }

    if (cpu_meter) {
      SetAPen(&myRP[CurBuffer], 0);
      SetWriteMask(&myRP[CurBuffer], 1l);
      RectFill( &myRP[CurBuffer], 70, 70,
                                  370, 78 );
      SetAPen(&myRP[CurBuffer], 1);
      Move(&myRP[CurBuffer], 70 + top_cpu_usage, 70);
      Draw(&myRP[CurBuffer], 70 + top_cpu_usage, 78);
      RectFill( &myRP[CurBuffer], 70, 70,
                                70 + avg_cpu_usage, 78 );
      Move(&myRP[CurBuffer], 70, 66);
      Draw(&myRP[CurBuffer], 70, 82);
      Move(&myRP[CurBuffer], 170, 66);
      Draw(&myRP[CurBuffer], 170, 82);
      Move(&myRP[CurBuffer], 270, 66);
      Draw(&myRP[CurBuffer], 270, 82);
    }
#endif

  }

  printf("Over wanted framerate: %d frames.\n", over);
  printf("50 fps : %d\n25 fps : %d\n16.7 fps : %d\n12.5fps : %d\n", 
          frameinfo[0], frameinfo[1], frameinfo[2], frameinfo[3]);

#ifdef CPU_USAGE
  printf("Max cpu usage during game: %d percent.\n", top_cpu_usage2 / 2);
  printf("Min cpu usage during game: %d percent.\n", min_cpu_usage  / 2);
#endif

  WaitBlit();
  cleanExit( RETURN_OK, "" );
}

/*------------------------------------------------------------------------*/

/*
 * handleIDCMP -- Reads keyboard events and does what the user tells it
 *                to do.
 */
BOOL 
handleIDCMP(void)
{
  BOOL done = FALSE;
  BOOL keyup;
  ULONG class;
  USHORT code;
  USHORT qual;
  AShip *ship = World.local_ship;

  struct IntuiMessage *message;    
  extern struct VertBData vertbdata;  /* From vertb.c */

  /* Examine pending messages */
  while( message = (struct IntuiMessage *)GetMsg(myWindow->UserPort) )
  {
    class = message->Class;  /* get all data we need from message */
    code  = message->Code;
    qual  = message->Qualifier;

    /* When we're through with a message, reply */
    ReplyMsg( (struct Message *)message);

    /* See what events occurred */
    keyup = (code & 0x80);

    switch( class ) {
      case IDCMP_RAWKEY:
        if(qual & IEQUALIFIER_RSHIFT) {
          ship->thrusting = TRUE;
        } else {
          ship->thrusting = FALSE;
        }
        switch( 0x7F & code )
        {
          case RAWKEY_ENTER:
            if (!keyup) {
              ship->fireing = TRUE;
            }
            break;
          case RAWKEY_A:
            if (keyup)
              ship->turning = NO;
            else 
              ship->turning = LEFT;
            break;
          case RAWKEY_S:
            if (keyup)
              ship->turning = NO;
            else
              ship->turning = RIGHT;
            break;
          case RAWKEY_Q:  
            done = TRUE;
            break;
          case RAWKEY_SPACE:
            if (keyup)
              ship->shields = FALSE;
            else
              ship->shields = TRUE;
            break;
          case RAWKEY_F:
            if (keyup) {
              ship->fueling = FALSE;
            } else {
              World.hudon   = TRUE;
              ship->fueling = TRUE;
              ship->fpod    = NULL;
            }
            break;
#ifdef CPU_USAGE
          case RAWKEY_KP_STAR:
            if (keyup)
              cpu_meter ^= 1;
            break;
#endif
          case RAWKEY_KP_MINUS:
            if (keyup) {
              if (w_framerate > 1) {
                World.framerate = --w_framerate;
                vertbdata.sigframe--;
              }
            }
            break;
          case RAWKEY_KP_PLUS:
            if (keyup) {
              if (w_framerate < 4) {
                World.framerate = ++w_framerate;
                vertbdata.sigframe++;
              }
            }
            break;
          default:
            break;
        }
        break;
      case IDCMP_ACTIVEWINDOW:
        /* 1000 Should be enough to prevent repeat. */
        inputReqBlk->tr_time.tv_secs = 1000;
        DoIO((struct IORequest *) inputReqBlk);
        break;
      case IDCMP_INACTIVEWINDOW:
        inputReqBlk->tr_time.tv_secs = oldrptdelay;
        DoIO((struct IORequest *) inputReqBlk);
        break;
      default:
        break;
    }
  }
  return(done);
}

/*------------------------------------------------------------------------*/

/*
 * cleanExit -- Closes windows, screens etc. and tries to exit
 *              gracefully.
 */
void 
cleanExit( LONG returnValue, char *fmt, ... )
{
  int i;
  va_list argp;

  va_start(argp, fmt);
  vfprintf (stderr, fmt, argp);
  va_end(argp);

  remove_VertBServer();
  if (deviceopen == 0) {
    /* Restore old repeat delay. */
    inputReqBlk->tr_time.tv_secs = oldrptdelay;
    DoIO((struct IORequest *) inputReqBlk);
    CloseDevice((struct IORequest *) inputReqBlk);
  }
  if (inputReqBlk)     DeleteExtIO((struct IORequest *) inputReqBlk);
  if (inputPort)       DeletePort( inputPort );
  if (myDBI)           FreeDBufInfo( myDBI );
  if (myWindow)        CloseWindow( myWindow );
  if (myScreen)        CloseScreen( myScreen );
  if (hudFont)         CloseFont(hudFont);
  if (!prefs.noserial) close_connection();

#ifdef CPU_USAGE
  if (TimerBase)       CloseDevice((struct IORequest *) &tr);
#endif

  if (dbufport) {
    /* Cleanup any pending messages */
    while (GetMsg(dbufport));
    DeleteMsgPort(dbufport);
  }

  if (World.shld_bm != NULL)
    FreeBitMap( World.shld_bm );

  for (i = 0; i < MY_BUFFERS; i++) {
    if (myBitMap[i] != NULL)
      FreeBitMap( myBitMap[i] );
  }
  exit(returnValue);
}

/*------------------------------------------------------------------------*/
