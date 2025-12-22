/*
   main_menu.c -- main program menu module

   This module is intended to handle the opening and title screen, and
   provide a `home base' for accessing the other user modules: the map
   editor, the options editor and the game play.  It also provides some
   all-purpose utility functions.

   This source code is free.  You may make as many copies as you like.

 ***********************************************************************
 ***            THE GAME OF INVASION FORCE FOR THE AMIGA             ***
 ***                         by Tony Belding                         ***
 ***********************************************************************

 The game was written with the SAS/C compiler.
 Compatibility with other compilers is anybody's guess.
*/

// standard header for all program modules
#include "global.h"

#define CE_RESTART (-17)

//    GLOBAL VARIABLES

char *version = "$VER: Invasion Force 0.17 (22.5.97)";
short revision = 17;


// an all-purpose workspace
char foo[256], bar[256];

// system (Intuition, etc.) globals
BPTR my_console = NULL;
struct Screen *title_screen = NULL;
struct BitMap title_bmp = { 0,0,0,0,0, 0,0,0,0, 0,0,0,0};
__far extern char title_picture[];
struct Screen *map_screen = NULL;
APTR vi = NULL;      // visual-info handle for GadTools
struct Window *map_window = NULL;
struct Window *terrain_window = NULL;
struct Menu *main_menu_strip = NULL;
struct ReqToolsBase *ReqToolsBase = NULL;
struct MEDPlayerBase *MEDPlayerBase = NULL;

char default_sound[MAX_SOUNDS][216] = {                // default sound effects
   "PROGDIR:Data/Sound/8SVX.donk",
   "PROGDIR:Data/Sound/8SVX.boom",
   "PROGDIR:Data/Sound/8SVX.death_cry",
   "PROGDIR:Data/Sound/8SVX.low_smash",
   "PROGDIR:Data/Sound/8SVX.yeah"
};

char current_sound[MAX_SOUNDS][216];     // currently active sound effects

char win_title[80];     // area to store window title text

int disp_wd, disp_ht;   // display size in MAP HEXES, not pixels

struct Gadget *context = NULL,
   *vert_scroller = NULL,
   *horz_scroller = NULL;

APTR vs_si=NULL, hs_si=NULL;

// the identifiers for my various fonts
struct TextAttr topaz8 = { (STRPTR)"topaz.font",8,0,0 };
struct TextAttr topaz9 = { (STRPTR)"topaz.font",9,0,0 };
struct TextAttr topaz11 = { (STRPTR)"topaz.font",11,0,0 };
struct TextAttr topaz11bold = { (STRPTR)"topaz.font",11,FSF_BOLD,0 };

// the default requester TRUE or FALSE exit keys
// some versions of Intution allowed the user to alter these using a PREFS tool,
// but I don't have any documentation on how to handle that, or even if it's still
// supposed to be supported -- I suspect it is not
char req_true = 'V', req_false = 'B';

struct Emp2Prefs {
   ULONG DisplayID;
   UWORD DisplayWidth;
   UWORD DisplayHeight;
   UWORD OverscanType;
} prefs;

struct newEmp2Prefs {
   ULONG DisplayID;        // display specs for main map screen
   UWORD DisplayWidth;
   UWORD DisplayHeight;
   UWORD OverscanType;
   ULONG WM_DisplayID;     // specs for World Map display
   UWORD WM_DisplayWidth;
   UWORD WM_DisplayHeight;
   UWORD WM_OverscanType;
   UWORD WM_Fatness;       // pixel magnification
} newprefs;

//    BEGIN OF PROGRAM FUNCTIONS

void print(string)
char *string;
{  // print to the console: used mainly for error reports & debugging.
   if (my_console)
      Write(my_console,string,strlen(string));
   else
      Write(Output(),string,strlen(string));
}


// alarm() gives the user a message -- using a ReqTools requester if possible
// (i.e. if ReqTools.library is available) or otherwise using print() to console

void alarm(string)
char *string;
{  // tell the user about a bug or other error
   DisplayBeep(NULL);
   if (ReqToolsBase)
      (void)rtEZRequestTags(string,"DRAT!", NULL, NULL,
         RT_Window, map_window,
         RT_ScreenToFront, TRUE,
         RT_LockWindow, FALSE,
         TAG_DONE);
   else {
      print(string);
      print("\n");
      Delay(300L);   // so I can read it before the window closes
   FI
}


/*
   UPDATE: I have expanded the function of clean_exit() to restart the program
   as well as terminate it.  When clean_exit() is passed the error value
   CE_RESTART, it will close down everything but will not terminate the program
   execution.
*/

void clean_exit(error,text)
int error;
char *text;
{  // de-allocate and close EVERTHING, then exit the program
   /*
      I may try to find a more efficient way to pass messages later on, to
      avoid repeating error text throughout my program.
   */
   if (text)
      alarm(text);

   // De-allocate the sound effects and music player.
   freeSounds();
   FreePlayer();

   // free data structures
   cleanup_game();

   // close the map window
   if (map_window) {
      ClearMenuStrip(map_window);
      CloseWindow(map_window);
      map_window = NULL;
   FI

   // free the clipping region
   if (map_region) {
      DisposeRegion(map_region);
      map_region = NULL;
   FI
   if (bar_region) {
      DisposeRegion(bar_region);
      bar_region = NULL;
   FI

   // free my scroller gadgets
   if (hs_si) {
      FreeVec(hs_si);
      hs_si = NULL;
   FI
   if (vs_si) {
      FreeVec(vs_si);
      vs_si = NULL;
   FI
   FreeGadgets(context);
   context = NULL;

   // free the menu strips
   if (main_menu_strip) {
      FreeMenus(main_menu_strip);
      main_menu_strip = NULL;
   FI
   if (editor_menu_strip) {
      FreeMenus(editor_menu_strip);
      editor_menu_strip = NULL;
   FI
   if (move_menu_strip) {
      FreeMenus(move_menu_strip);
      move_menu_strip = NULL;
   FI
   if (vey_menu_strip) {
      FreeMenus(vey_menu_strip);
      vey_menu_strip = NULL;
   FI
   if (prod_menu_strip) {
      FreeMenus(prod_menu_strip);
      prod_menu_strip = NULL;
   FI

   // close the ViewInfo handle
   if (vi) {
      FreeVisualInfo(vi);
      vi = NULL;
   FI

   // Close the screens.
   if (title_screen) {
      CloseScreen(title_screen);
      title_screen = NULL;
   FI
   if (map_screen) {
      CloseScreen(map_screen);
      map_screen = NULL;
   FI

   // Close the console.
   if (my_console) {
      Close(my_console);
      my_console = NULL;
   FI

   // Close the libraries.
   CloseLibrary((APTR)ReqToolsBase);
   CloseLibrary((APTR)MEDPlayerBase);

   if (error!=CE_RESTART)
      exit(error);

}


void open_libraries()
{  // open libs, only those not opened by SAS/C itself
   ReqToolsBase=(struct ReqToolsBase *)OpenLibrary(REQTOOLSNAME,REQTOOLSVERSION);
   if (ReqToolsBase==NULL)
      clean_exit(1,"ERROR: Unable to open ReqTools.library!");

   MEDPlayerBase=(struct MEDPlayerBase *)OpenLibrary("medplayer.library",0);
   if (MEDPlayerBase==NULL)
      clean_exit(1,"ERROR: Unable to open MedPlayer.library!");

}


// alert() uses ReqTools to pop up a quick-and-easy alert box, though
// it will be better sometimes to go straight for rtEZRequestTags()

int alert(window,title,hail,gads)
struct Window *window;
char *title, *hail, *gads;
{  // quick & dirty alert boxes via the ReqTools library
   // these are best used for reporting non-fatal errors
   return (int)rtEZRequestTags(hail,gads,NULL,NULL,
      RTEZ_ReqTitle,title,
      RT_Window,window,
      RT_ReqPos,REQPOS_CENTERWIN,
      RT_LockWindow, TRUE,
      TAG_END );
}


/*
   The Post-It=AE note system is used to inform the user about ongoing,
   time-consuming processes, such as loading from disk (I'm thinking floppy
   disk here) or the artificial opponents moving.  It puts a small window with
   the message on screen in the upper left corner, then removes it when the
   process is complete.  This method is more informative than merely showing
   a busy pointer.

   NOTE: Certain versions of reqtools.library have a bug causing the note to
   extend across the full width of the screen.  This is supposed to be fixed
   RSN.  Until then, it's merely a nuisance.

   The application must keep track of the ReqTools handle to close the note.
*/

struct rtHandlerInfo *post_it(message)
char *message;
{  // stick a Post-It=AE note up on the display
   struct rtHandlerInfo *handle;

   (void)rtEZRequestTags(message,NULL,NULL,NULL,
      RT_Window, map_window,
      RT_ReqPos, REQPOS_TOPLEFTWIN,
      RT_LeftOffset,5L,
      RT_TopOffset,15L,
      RT_LockWindow, FALSE,
      RT_ReqHandler, &handle,
      RTEZ_ReqTitle, "Status",
      TAG_END );
   return handle;
}

// remove a Post-It=AE note from the screen
void unpost_it(handle)
struct rtHandlerInfo *handle;
{
   rtReqHandler(handle,NULL,RTRH_EndRequest,TRUE,TAG_END);
}


int left_buttonP()
{  // returns TRUE if left mouse button is down
   char *pra = (char *)0xBFE001;  // CIA-A port register A

   if ( (*pra & 0x40)==0 )
      return TRUE;
   else
      return FALSE;
}



void set_title_palette()
{
   struct ViewPort *ScreenViewPort;

   UWORD MyPalette[16] = {  // the #define colors relate to these
      0x0000, 0x0000,
      0x0000, 0x0000,
      0x0000, 0x0000,
      0x0000, 0x0000,
      0x0000, 0x000F,
      0x0142, 0x0F00,
      0x099B, 0x0ED9,
      0x0FF0, 0x0FEE
   };

   ScreenViewPort = &title_screen->ViewPort;
   LoadRGB4(ScreenViewPort,MyPalette,16L);
}



void open_title_screen()
{
   //short my_pens[] = { ~0 };

   // open the screen
   struct NewScreen new_title_screen = {
      0,0,       // x/y position
      320,200,   // x/y size
      4,         // depth
      BLACK,         // detail pen
      WHITE,         // block pen
      NULL,    // ViewModes
      CUSTOMSCREEN|CUSTOMBITMAP|SCREENQUIET,  // Type
      NULL,  // font
      NULL,  // default title; change it in a second
      NULL,  // gadgets
      NULL   // custom bitmap
   };


      new_title_screen.CustomBitMap = &title_bmp;

      title_screen=(struct Screen *)OpenScreen(&new_title_screen);
      if (title_screen==NULL) {
                clean_exit(1,"ERROR: Unable to open title screen.\n");
      FI
      set_title_palette();
}

void load_title_graphics()
{
   InitBitMap(&title_bmp,4,320,200);  // initialize my custom bitmap

   title_bmp.Planes[0] = (PLANEPTR)title_picture;
   title_bmp.Planes[1] = (PLANEPTR)title_picture+8000;
   title_bmp.Planes[2] = (PLANEPTR)title_picture+16000;
   title_bmp.Planes[3] = (PLANEPTR)title_picture+24000;
}

void title_show()
{
        int music;

   //load_title_graphics();
   //open_title_screen();
        music = GetPlayer(0);
        if (music != 0)
                clean_exit(1,"ERROR: Unable to open music player!");

        PlayModule(LoadModule("PROGDIR:Data/Music/princessofdawn.med"));
   //SetTempo(33);
        system("vts title2.ham");
        //wait_for_click();
   //CloseScreen(title_screen);
        UnLoadModule(0);
        FreePlayer();
}




void open_map_screen()
{  // this will be the custom screen for the map display
   short my_pens[] = { ~0 };

   // open the screen
   map_screen = OpenScreenTags(NULL,
      SA_Type,       CUSTOMSCREEN,
      SA_DetailPen,  BLACK,
      SA_BlockPen,   WHITE,
      SA_Title,      "Invasion Force",
      SA_Font,       &topaz11,
      SA_DisplayID,  prefs.DisplayID,
      SA_Overscan,   prefs.OverscanType,
      SA_Width,      prefs.DisplayWidth,
      SA_Height,     prefs.DisplayHeight,
      SA_AutoScroll, TRUE,
      SA_Depth,      4,
      SA_Pens,       my_pens,
      TAG_END );
   if (map_screen==NULL)
      map_screen = OpenScreenTags(NULL,
         SA_Type,       CUSTOMSCREEN,
         SA_DetailPen,  BLACK,
         SA_BlockPen,   WHITE,
         SA_Title,      "Invasion Force",
         SA_Font,       &topaz11,
         SA_DisplayID,  HIRESLACE_KEY,
         SA_Width,      640,
         SA_Height,     400,
         SA_AutoScroll, TRUE,
         SA_Depth,      4,
         SA_Pens,       my_pens,
         TAG_END );
   if (map_screen==NULL)
      clean_exit(1,"ERROR: Unable to open map screen!");

   prefs.DisplayWidth = map_screen->Width;
   prefs.DisplayHeight = map_screen->Height;
   save_prefs();

   vi = GetVisualInfo(map_screen,TAG_END);
}


void open_map_window()
{  // open the map window, which the game is built upon
   int wide, high;

   map_window = OpenWindowTags(NULL,
      WA_CustomScreen,map_screen,
      WA_Title,"Top Level",
      WA_Top,           map_screen->BarHeight+1,
      WA_Height,        map_screen->Height-map_screen->BarHeight-1,
      WA_IDCMP,IDCMP_MENUPICK|IDCMP_VANILLAKEY,
      WA_Flags,WFLG_BACKDROP|WFLG_ACTIVATE|NOCAREREFRESH,
      TAG_END );
   if (map_window==NULL)
      clean_exit(1,"ERROR: Unable to open map window!");

   // set this window as my default for graphics operations
   rast_port = map_window->RPort;

   // calculate hex display size
   // This will adapt my graphics functions to fit whatever display size has been opened.

   // first, the width in pixels (-10 for movement bar meter)
   wide = map_window->Width-map_window->BorderLeft-map_window->BorderRight;

   // subtract extra room needed for various things on the borders, then divide by hex
   // width (30) and add one extra hex if there is any remainder
   // figure 13 pixels for the left border area; 29 for the right border and scroller
   wide -= (12+18);
   disp_wd = (wide/30)+(((wide%30)!=0)?1:0);

   // next, the height in pixels, calculated much as we did for width
   high = map_window->Height-map_window->BorderTop-map_window->BorderBottom;
   high -= (1+13);
   disp_ht = (high/24)+(((high%24)!=0)?1:0);
}


void set_default_palette(scrn)
struct Screen *scrn;
{  // Set the basic 16-color screen palette for the game.
   struct ViewPort *screen_view_port;

   UWORD default_palette[16] = {  // the #define colors relate to these
      0x0AAA, 0x0000,
      0x0EEE, 0x066F,
      0x0CA8, 0x0444,
      0x090C, 0x0F80,
      0x0C00, 0x001D,
      0x033F, 0x0852,
      0x0777, 0x0262,
      0x06C6, 0x0494
   };

   screen_view_port = &scrn->ViewPort;
   LoadRGB4(screen_view_port,default_palette,16L);
}


// check for required font(s), currently only Topaz 11
// if it doesn't find what it needs, it will deliver a FATALITY!
void check_fonts()
{
   struct TextFont *font;
   UWORD font_size;
   char errmsg[] = "ERROR: Unable to open Topaz 11 font!";

   // Set the DESIGNED flag bit so it won't try to rescale for me.
   topaz11.ta_Flags |= FPF_DESIGNED;
   topaz11.ta_YSize = 11;

   font = OpenDiskFont(&topaz11);
   if (font) {
      font_size = font->tf_YSize;
      CloseFont(font);
      if (font_size!=11)
         clean_exit(1,errmsg);
   } else
      clean_exit(1,errmsg);
}


void seed_random()
{  // kick off the random number generator
   time_t t;

   time(&t);
   RangeSeed = t;

   /*
      Note on random numbers: the function RangeRand() is not adequately
      documented in the RKM.  RangeRand(a) returns a number from 0 though
      a-1.  Thus RangeRand(10L) will give a number from 0 through 9.
   */
}


void create_console()
{  // set up my own console output for debugging and error reports
   if (Output()==NULL)
      my_console=Open("CON:20/20/500/100/Invasion Force",MODE_OLDFILE);
   print("The Game of Invasion Force\n");
   print("Version 0.17 - by Tony Belding\n");
}


void build_main_gadget_list()
{  // prepare the scroller gadgets for use
   struct NewGadget new_vert_scroller = {
      620,14,     // leftedge, topedge
      16,358,     // width, height
      NULL,       // text label
      NULL,       // font
      1,          // gadget ID
      NULL,       // flags
      NULL,       // set to retval of GetVisualInfo()
      NULL        // UserData
   };
   struct NewGadget new_horz_scroller = {
      4,372,      // leftedge, topedge
      616,12,     // width, height
      NULL,       // text label
      NULL,       // font
      2,          // gadget ID
      NULL,       // flags
      NULL,       // set to retval of GetVisualInfo()
      NULL        // UserData
   };

   // window adaptive values for the scroller gadgets
   new_vert_scroller.ng_LeftEdge = map_window->Width-map_window->BorderRight-16;
   new_vert_scroller.ng_Height = map_window->Height-map_window->BorderTop-map_window->BorderBottom-12;
   new_horz_scroller.ng_TopEdge = map_window->Height-map_window->BorderBottom-12;
   new_horz_scroller.ng_Width = map_window->Width-map_window->BorderLeft-map_window->BorderRight-16;

   new_vert_scroller.ng_VisualInfo = new_horz_scroller.ng_VisualInfo = vi;
   if (!CreateContext(&context))
      clean_exit(1,"ERROR: Unable to create context gadget!");
   vert_scroller = CreateGadget(SCROLLER_KIND,context,&new_vert_scroller,
      GTSC_Arrows,13L,
      PGA_Freedom,LORIENT_VERT,
      GA_RelVerify,TRUE,
      TAG_END );
   horz_scroller = CreateGadget(SCROLLER_KIND,vert_scroller,&new_horz_scroller,
      GTSC_Arrows,16L,
      PGA_Freedom,LORIENT_HORIZ,
      GA_RelVerify,TRUE,
      TAG_END );
   if (vert_scroller==NULL || horz_scroller==NULL)
      clean_exit(1,"ERROR: Unable to create scroller gadgets!");

   //efmV added code to allocate memory for  ->SpecialInfo
   // NOTE: The OS is supposed to allocate and intialize this, but some
   //       versions fail to do so.  The adaptive code will check for this
   //       and correct it.
   if (horz_scroller->SpecialInfo==NULL)
      hs_si = horz_scroller->SpecialInfo = AllocVec(sizeof(struct PropInfo),0);
   if (horz_scroller->SpecialInfo==NULL)
      clean_exit(1,"allocation error");
   if (vert_scroller->SpecialInfo==NULL);
      vs_si = vert_scroller->SpecialInfo = AllocVec(sizeof(struct PropInfo),0);
   if (horz_scroller->SpecialInfo==NULL)
      clean_exit(1,"allocation error");
   //end of what I added

   ((struct PropInfo *)(horz_scroller->SpecialInfo))->Flags = FREEHORIZ|PROPNEWLOOK;
   ((struct PropInfo *)(vert_scroller->SpecialInfo))->Flags = FREEVERT|PROPNEWLOOK;

   // attach gadgets to window
   AddGList(map_window,context,0,-1,NULL);
   RefreshGList(context,map_window,NULL,-1);
   GT_RefreshWindow(map_window,NULL);
}


void build_main_menu()
{  // prepare the main opening menu for use
   struct NewMenu new_menu_strip[]  = {
      { NM_TITLE, "Project", NULL, 0, NULL, NULL },
      { NM_ITEM, "About Invasion Force", "A", ITEMTEXT, NULL, NULL },
      { NM_ITEM, NM_BARLABEL, NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "New Game", "N", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Load Game", "L", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Map Editor", "M", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Quit Program", "Q", ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Prefs", NULL, 0, NULL, NULL },
      { NM_ITEM, "Define Sounds", "D", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Screen Mode", "G", ITEMTEXT, NULL, NULL },
      { NM_END, NULL, NULL, NULL, NULL, NULL }
   };

   if (!(main_menu_strip = CreateMenus(new_menu_strip,GTMN_FrontPen,BLACK,TAG_END)))
      clean_exit(1,"ERROR: Unable to create main menu strip!");

   if (!(LayoutMenus(main_menu_strip,vi,TAG_END)))
      clean_exit(1,"ERROR: Unable to layout menus!");
}


void about_empire()
{  // copyright, author, version info and such
   (void)rtEZRequestTags("Invasion Force version 0.17\nby Tony Belding\n\nThis software is free.\nYou may make as many copies as you like.",
      "Okay",NULL,NULL,
      RTEZ_Flags,EZREQF_CENTERTEXT,
      RT_DEFAULT,TAG_END);
}


void quit_program()
{  // quit the program with the user's confirmation
   if (rtEZRequestTags("Really quit the program?","Exit|Cancel",NULL,NULL,
      RTEZ_ReqTitle,"Exit Invasion Force",
      RT_DEFAULT,TAG_END ) )
      clean_exit(0,NULL);
}


void load_prefs()
{
   char *filename="progdir:data/iforce.prefs";
   BPTR file;
   short revcheck;

   // set default prefs; they will be overwritten if the file is found
   prefs.DisplayID = HIRESLACE_KEY;
   prefs.DisplayWidth = 640;
   prefs.DisplayHeight = 400;
   prefs.OverscanType = OSCAN_TEXT;

   if (FLength(filename)<0L) {   // first filename not found
      filename = "progdir:iforce.prefs";  // use second name
      if (FLength(filename)<0L)   // second filename not found
         return;
   FI

   file = Open(filename,MODE_OLDFILE);
   if (file==NULL)
      return;
   (void)Read(file,foo,8L);
   if (strncmp(foo,"EMP2PREF",8)) {
      Close(file);
      return;
   FI
   (void)Read(file,&revcheck,2L);
   if (revcheck<7 || revcheck>revision) {
      Close(file);
      return;
   FI
   Read(file,&prefs,sizeof(prefs));
   if (revcheck>=16) {
      int k=0;

      for (;k<MAX_SOUNDS;k++) {
         Read(file,foo,216L);
         // we never accept a filename unless we can prove the file exists
         if (FLength(foo)>0)
            strncpy(current_sound[k],foo,215L);
      }
   }
   Close(file);
}


void save_prefs()
{
   BPTR file=Open("progdir:data/iforce.prefs",MODE_NEWFILE);

   if (file==NULL)
      file = Open("progdir:iforce.prefs",MODE_NEWFILE);
   if (file) {
      // the basic header information
      Write(file,"EMP2PREF",8L);    // magic identifies my prefs files
      Write(file,&revision,2L);     // identify revision of Invasion Force
      Write(file,&prefs,sizeof(prefs));
      {
         int k=0;
         for (;k<MAX_SOUNDS;k++)
            Write(file,current_sound[k],216L);
      }
      Close(file);
   FI
}


void change_screenmode()
{
   struct rtScreenModeRequester *smr=rtAllocRequest(RT_SCREENMODEREQ,NULL);
   int new;

   if (smr==NULL)    // can't open the requester
      return;
   new = rtScreenModeRequest(smr,"Select the screen mode...",
      RT_Window,        map_window,
      RT_ReqPos,        REQPOS_CENTERWIN,
      RT_LockWindow,    TRUE,
      RTSC_Flags,       SCREQF_OVERSCANGAD|SCREQF_GUIMODES|SCREQF_SIZEGADS,
      RTSC_MinWidth,    640,
      RTSC_MinHeight,   400,
      TAG_END);
   rtFreeRequest(smr);

   if (new) {
      // extract data from smr
      prefs.DisplayID      = smr->DisplayID;
      prefs.DisplayWidth   = smr->DisplayWidth;
      prefs.DisplayHeight  = smr->DisplayHeight;
      prefs.OverscanType   = smr->OverscanType;
      save_prefs();
//      clean_exit(CE_RESTART,NULL);
//      control_flag = CE_RESTART;

      // close down the old map_window environment
      if (map_window) {
         ClearMenuStrip(map_window);
         CloseWindow(map_window);
         map_window = NULL;
      FI
      if (map_region) {
         DisposeRegion(map_region);
         map_region = NULL;
      FI
      if (bar_region) {
         DisposeRegion(bar_region);
         bar_region = NULL;
      FI
      if (hs_si) {
         FreeVec(hs_si);
         hs_si = NULL;
      FI
      if (vs_si) {
         FreeVec(vs_si);
         vs_si = NULL;
      FI
      FreeGadgets(context);
      context = NULL;
      if (main_menu_strip) {
         FreeMenus(main_menu_strip);
         main_menu_strip = NULL;
      FI
      if (vi) {
         FreeVisualInfo(vi);
         vi = NULL;
      FI
      if (map_screen) {
         CloseScreen(map_screen);
         map_screen = NULL;
      FI

      // open the new one and re-attach everything
      open_map_screen();
      set_default_palette(map_screen);
      open_map_window();
      build_main_gadget_list();
      init_map_grafx();
      clear_movebar();
      build_main_menu();   // prepare the main drop-down menus for use
   FI
}


void change_sounds()
{
   struct Window *snd_window = NULL;
   struct Gadget *context, *ok_gad, *defaults_gad;

   struct Gadget *snd_button[5], *snd_field[5], *play_button[5];
   char snd_label[5][10]={"Alert:","Battle:","Defeat:","No-Go:","Victory:"};

   struct NewGadget button = {
      159,219, // leftedge, topedge
      105,16,   // width, height
      "Continue",    // text label
      &topaz11bold,  // font
      1,             // gadget ID
      PLACETEXT_IN,  // flags
      NULL,NULL   // visual info, user data
   };
   struct NewGadget stringfield = {
      77,50,
      300,16,
      "_Name:",
      &topaz11,
      2,
      PLACETEXT_LEFT,
      NULL,NULL
   };

   int wd=518, ht=170;
   int left_edge, top_edge;

   left_edge = (map_screen->Width-wd)/2;
   top_edge = (map_screen->Height-ht)/2;

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");

   {
      int i;
      struct Gadget *previous = context;

      // the [SND] requester buttons
      button.ng_VisualInfo = vi;
      button.ng_LeftEdge = 12;
      button.ng_TopEdge = 18;
      button.ng_Width = 80;
      button.ng_Height = 15;
      button.ng_TextAttr = &topaz11;

      for (i=0; i<MAX_SOUNDS; i++) {
         button.ng_GadgetText = snd_label[i];
         previous = snd_button[i] = CreateGadget(BUTTON_KIND,previous,&button,TAG_END);
         button.ng_TopEdge += 20;
      }

      // the [play] buttons
      button.ng_LeftEdge = 458;
      button.ng_TopEdge = 18;
      button.ng_Width = 48;
      button.ng_Height = 15;
      button.ng_TextAttr = &topaz11;
      button.ng_GadgetText = "play";

      for (i=0; i<MAX_SOUNDS; i++) {
         previous = play_button[i] = CreateGadget(BUTTON_KIND,previous,&button,TAG_END);
         button.ng_TopEdge += 20;
      }

      // create string gadget for SND filenames
      stringfield.ng_VisualInfo = vi;
      stringfield.ng_LeftEdge = 100;
      stringfield.ng_TopEdge = 18;
      stringfield.ng_Width = 350;
      stringfield.ng_Height = 16;
      stringfield.ng_GadgetText = NULL;

      for (i=0; i<MAX_SOUNDS; i++) {
         previous = snd_field[i] = CreateGadget(STRING_KIND,previous,&stringfield,
            GTST_String,   current_sound[i],
            GTST_MaxChars, 115L,
            STRINGA_Justification, GACT_STRINGCENTER,
            TAG_END);
         stringfield.ng_TopEdge += 20;
      }
   }

   // create the [Restore Defaults] and [I'm Done] buttons
   button.ng_VisualInfo = vi;
   button.ng_Width = 148;
   button.ng_LeftEdge = (wd-button.ng_Width)/2;
   button.ng_TopEdge = stringfield.ng_TopEdge+5;
   button.ng_GadgetText = "Restore Defaults";
   button.ng_TextAttr = &topaz11;
   defaults_gad = CreateGadget(BUTTON_KIND,snd_field[MAX_SOUNDS-1],&button,TAG_END);

   button.ng_Width = 100;
   button.ng_LeftEdge = (wd-button.ng_Width)/2;
   button.ng_TopEdge += 20;
   button.ng_GadgetText = "I'm Done";
   button.ng_TextAttr = &topaz11bold;
   ok_gad = CreateGadget(BUTTON_KIND,defaults_gad,&button,TAG_END);

   left_edge = (map_screen->Width-wd)/2;
   top_edge = (map_screen->Height-ht)/2;

   snd_window = OpenWindowTags(NULL,
      WA_Gadgets,       context,
      WA_Title,         "Game Sound Preferences",
      WA_CustomScreen,  map_screen,
      WA_Top,           top_edge,
      WA_Left,          left_edge,
      WA_Height,        ht,
      WA_Width,         wd,
      WA_IDCMP,         IDCMP_GADGETUP|IDCMP_VANILLAKEY,
      WA_Flags,         WFLG_SMART_REFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
      TAG_END );
   if (snd_window==NULL)
      clean_exit(1,"ERROR: Unable to open player sound prefs window!");
   GT_RefreshWindow(snd_window,NULL);
   rast_port = snd_window->RPort;

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(snd_window->UserPort);
         while (message = GT_GetIMsg(snd_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               if (code==13) {
                  // show the button depressed
                  show_depress(ok_gad,snd_window->RPort);
                  Delay(10L);
                  goto exit_snd_window;
               FI
            FI
            if (class==IDCMP_GADGETUP) {
               int sfx;

               if (object==ok_gad)
                  goto exit_snd_window;

               if (object==defaults_gad) {
                  int i;

                  for (i=0; i<MAX_SOUNDS; i++) {
                     strcpy(current_sound[i],default_sound[i]);
                     GT_SetGadgetAttrs(snd_field[i],snd_window,NULL,
                        GTST_String,   current_sound[i],
                        TAG_DONE);

                     loadSound(current_sound[i],&sdata[i]);
                  }
                  continue;
               }

               /* See if a button has been hit. */
               sfx=0;
               while (sfx<MAX_SOUNDS) {
                  if (object==snd_button[sfx])
                     break;
                  sfx++;
               }
               if (sfx<MAX_SOUNDS) {   /* We have a match! */
                  struct rtFileRequester *req = NULL;
                  char path[216], name[216];
                  BOOL chosen;

                  req = rtAllocRequestA(RT_FILEREQ,NULL);
                  if (req==NULL) {
                     alert(snd_window,NULL,"Failed to allocate ReqTools file requester.","Drat!");
                     continue;
                  FI

                  /* split the pan into path and name */
                  {
                     char *pan=current_sound[sfx];
                     int i, j;

                     path[0]='\0';
                     strncpy(name,pan,216L);
                     i = j = strlen(pan);
                     while (i>0) {
                        i--;
                        if (pan[i]==':' || pan[i]=='/') {
                           strncpy(path,pan,i);
                           path[i] = '\0';
                           if (i<j) {
                              strncpy(name,pan+i+1,j-i);
                              name[j-i] = '\0';
                           }
                           break;
                        }
                     }
                  }

                  rtChangeReqAttr(req,
                     RTFI_Dir,      path,
                     RTFI_MatchPat, "#?",
                     TAG_END);

                  chosen = (BOOL)rtFileRequest(req,name,"Select Sound",
                     RTFI_Flags, FREQF_PATGAD,
                     RT_DEFAULT, TAG_END);


                  if (chosen) {
                     int dirlen = strlen(req->Dir);
                     long l;

                     strcpy(foo,req->Dir);
                     if (dirlen)
                        if (foo[dirlen-1]!='/' && foo[dirlen-1]!=':')
                           strcat(foo,"/");
                     strcat(foo,name);

                     /* See if the file really exists. */
                     l = FLength(foo);
                     if (l<=0L)
                        alert(snd_window,NULL,
                           "There seems to be a problem with that file!",
                           "Drat!");
                     else {
                        // copy pan into the string gadget
                        strncpy(current_sound[sfx],foo,216L);
                        GT_SetGadgetAttrs(snd_field[sfx],snd_window,NULL,
                           GTST_String,   current_sound[sfx],
                           TAG_DONE);

                        loadSound(current_sound[sfx],&sdata[sfx]);
                        playSound(sfx,64);
                     }
                  FI
                  rtFreeRequest(req);
                  continue;
               FI    // end of SOUND BUTTONS handling

               /* See if a text field has been edited. */
               sfx=0;
               while (sfx<MAX_SOUNDS) {
                  if (object==snd_field[sfx])
                     break;
                  sfx++;
               }
               if (sfx<MAX_SOUNDS) {   /* We have a match! */
                  struct StringInfo *stringthing=snd_field[sfx]->SpecialInfo;
                  long l;

                  strcpy(foo,stringthing->Buffer);
                  l = FLength(foo);
                  if (l<=0L) {
                     alert(snd_window,NULL,
                        "There seems to be a problem with that file!",
                        "Drat!");
                     // change it back to original
                     GT_SetGadgetAttrs(snd_field[sfx],snd_window,NULL,
                        GTST_String,   current_sound[sfx],
                        TAG_DONE);
                  } else {
                     strcpy(current_sound[sfx],foo);
                     loadSound(current_sound[sfx],&sdata[sfx]);
                     playSound(sfx,64);
                  }
                  continue;
               FI    // end of TEXT FIELD handling

               /* See if a button has been hit. */
               sfx=0;
               while (sfx<MAX_SOUNDS) {
                  if (object==play_button[sfx])
                     break;
                  sfx++;
               }
               if (sfx<MAX_SOUNDS) {   /* We have a match! */
                  playSound(sfx,64);
                  continue;
               FI    // end of PLAY BUTTONS handling

            FI
         OD
      OD
   OD

 exit_snd_window:

   save_prefs();

   // now close up everything with the prefs_window
   CloseWindow(snd_window);
   snd_window = NULL;
   FreeGadgets(context);

   // reset everything for map window
   rast_port = map_window->RPort;
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_MENUPICK);
}


void main_menu()
{  // handle the main opening menu
   struct IntuiMessage *message; // the message the IDCMP sends us

   // useful for interpreting IDCMP messages
   UWORD code;
   ULONG class;

   // attach the menu to my window
   SetMenuStrip(map_window,main_menu_strip);

   // enable menus
   OnMenu(map_window,FULLMENUNUM(0,NOITEM,0));
   OnMenu(map_window,FULLMENUNUM(1,NOITEM,0));

//   OffMenu(map_window,FULLMENUNUM(1,0,0));

   while (TRUE) {
      WaitPort(map_window->UserPort);
      while (message = GT_GetIMsg(map_window->UserPort)) {
         code = message->Code;  // MENUNUM
         class = message->Class;
         GT_ReplyIMsg(message);

         if ( class == MENUPICK ) { // MenuItems
            OffMenu(map_window,FULLMENUNUM(0,-1,0));
            OffMenu(map_window,FULLMENUNUM(1,-1,0));
            switch (MENUNUM(code)) {
               case 0:  // the Project menu
                  switch (ITEMNUM(code)) {
                     case 0:  // About Invasion Force
                        about_empire();
                        break;
                     case 4:  // Map Editor
                        map_editor();
                        break;
                     case 5:  // Quit
                        clean_exit(0,NULL);
                        break;
                     case 2:  // New Game
                        if (!edit_options())
                           break;
                        play_game();
                        break;
                     case 3:  // Load game
                        if (rt_loadsave_game(FALSE))
                           restore_game();
                  }
                  break;
               case 1:  // the prefs menu
                  switch (ITEMNUM(code)) {
                     case 0: // Define Sounds
                        change_sounds();
                        break;
                     case 1:  // Screen Mode
                        ClearMenuStrip(map_window);
                        change_screenmode();
                        SetMenuStrip(map_window,main_menu_strip);
//                        if (control_flag==CE_RESTART)
//                           return;
                  }
            }
            OnMenu(map_window,FULLMENUNUM(0,NOITEM,0));
            OnMenu(map_window,FULLMENUNUM(1,NOITEM,0));
         FI
      OD
   OD
}


void main()
{
   // initialize everything
   control_flag = 0;
   create_console();  // create my debugging console
   open_libraries();
   seed_random();     // seed the random number generator.
   check_fonts();     // see if I have all the fonts I need
   title_show();

   {
      /*
         default sound effects: these sounds aren't loaded yet, they may
         be changed momentarily by the user prefs
      */
      int k=0;
      for (;k<MAX_SOUNDS;k++)
         strncpy(current_sound[k],default_sound[k],215L);
   }

   /* prefs load before opening the screen, so we know what screenmode */
   load_prefs();

   open_map_screen();      // put together my display
   set_default_palette(map_screen);
   open_map_window();
   build_main_gadget_list();
   init_map_grafx();
   clear_movebar();
   build_main_menu();   // prepare the main drop-down menus for use

   initSounds();        // prepare sound effects for use

   NewList((struct List *)&city_list);  // initialize the city list
   NewList((struct List *)&unit_list);  // initialize the active units list
   NewList((struct List *)&GovList);    // initialize the governors list for
                                        // the AI players

   // initialize default PAN (Path And Name)
   strcpy(game_filepath,"ProgDir:Games/");
   strcpy(game_filename,"Game.IF");

   // jump into the program itself
   main_menu();
   if (control_flag==CE_RESTART)
      main();
   clean_exit(0,NULL);
}

// end of listing



