/*
 * RoleAid by Niilo Paasivirta 1993-1994
 *
 * Programmed with SAS/C 6.51 on Amiga A4000/040
 *
 * Changes:
 *
 * 26. 4.1992 (NP)
 *	-	first version works
 * 29. 4.1992 (NP)
 *	-	game time management developed
 *  1. 5.1992 (NP)
 *	-	weather system installed, and it's pseudo-
 *		randomized : same area at the same time has always
 *		the same weather (we can check how the weather was
 *		or will be in different times)
 *	-	several areas with different weather
 *  3. 5.1992 (NP)
 *	-	about requester added
 * 29.3. 1994 (NP)
 *	-	more areas added
 * 15.4. 1994 (NP)
 *	-	Now only on Kick 2.04 and higher
 *	-	adding file requesters and stuff...
 *	-	not on own screen any more, but as a window
 *
 *	-	saving and loading of settings is being developed
 * 16.5.1994 (NP)
 *	-	more gadtools stuff
 *	-	sounds added!
 * 29.5.1994 (NP)
 *	-	release 1.00 ready
 *
 */

/*
 * TODO:
 *	-	locals
 *	-	XPK'ed sounds?
 *	-	real time should be shown too, on window title (?)
 *	-	terrain types and encounter tables?
 *	-	movement calculation
 *	-	support all fonts properly, use gadtools for building menus
 *
 */

#include <exec/types.h>
#include <exec/io.h>
#include <exec/memory.h>
#include <exec/lists.h>
#include <intuition/intuition.h>
#include <libraries/gadtools.h>
#include <graphics/gfxbase.h>
#include <libraries/dos.h>
#include <dos.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include <proto/all.h>
int CXBRK(void) { return 0; }

#include "types.h"
#include "game_time.h"
#include "weather.h"
#include "menus.h"

/* Define this to get sounds */
#define SOUNDS

extern int area;
extern int temp; /* Temperature */

void openup(void);
void cleandown(int);
int random(int n);
void at(int, int);
void show_roletime(void);
void refresh_title(void);
void show_msg(char *msg);
static void about_requester(void);
void HandleMenus(USHORT);
void ConPuts(char *);
void ConWrite(char *,LONG);
void ConPutChar(char);
struct Node *AllocNode(char *name);
void FreeNode(struct Node *node);
void FreeList(struct List *list);

#define DEPTH 2
#define WIDTH 640
#define HEIGHT 256

static const char version_string[] = "\0$VER: RoleAid 1.00 (29.05.94)";
char		*wintitle = "RoleAid 1.00";
char		title[80] = "Custom Title"; /* So we can change it easily */

struct RastPort	*rp = NULL;
struct Window	*window = NULL;

APTR		visinfo = NULL;
struct Gadget	*gad = NULL;
struct Gadget	*glist = NULL;

struct FileRequester *request = NULL;

struct IOStdReq	*writereq = NULL;
struct MsgPort	*writeport = NULL;
BOOL		OpenedConsole = FALSE;
char		buf[512];
BOOL		fresh;

/* Yiks! */
struct TextAttr textattr = { (STRPTR)"topaz.font",TOPAZ_EIGHTY,0,0 };
struct NewGadget newgadget =
  { 8, 16, 256, 12, NULL, &textattr, 1, NULL, NULL, NULL };

#ifdef SOUNDS
struct List	sdirlist;
int		current_sample;
#endif

/* Some console commands */
#define RESETCON	"\033c"
#define CURSOFF		"\033[0 p"
#define CURSON		"\033[ p"
#define DELCHAR		"\033[P"
#define COLOR01		"\033[31m"
#define COLOR02		"\033[32m"
#define COLOR03		"\033[33m"
#define COLOR04		"\033[34m"
#define ITALICS		"\033[3m"
#define BOLD		"\033[1m"
#define UNDERLINE	"\033[4m"
#define NORMAL		"\033[0m"
#define EMPTY_LINE "                                                                          "
#define CLS ConPutChar('\014');

int
random(int n)
{
  return ((rand() >> 8) % n);
}

struct Node *
AllocNode(char *name) {
  struct Node *n = NULL;

  if (!(n = (struct Node *)AllocMem(sizeof(struct Node),
				    MEMF_CLEAR))) return NULL;

  if (!(n->ln_Name = AllocMem(strlen(name) + 1, 0L)))
    return NULL;

  (void)strcpy(n->ln_Name, name);

  return n;
}

void
FreeNode(struct Node *node) {
  if (node)
    {
      if (node->ln_Name)
	{
	  FreeMem(node->ln_Name, (strlen(node->ln_Name) + 1));
	  node->ln_Name = NULL;
	}
      FreeMem(node, sizeof(struct Node));
    }
}

void
FreeList(struct List *list) {
  struct Node *work_node, *next_node;

  work_node = list->lh_Head;

  while (next_node = work_node->ln_Succ) {
    FreeNode(work_node);
    work_node = next_node;
  }
}

struct Node *
NthNode(struct List *list, int n) {
  struct Node *node;

  node = list->lh_Head;
  n++;

  do { n--; } while ((n) && (node = node->ln_Succ));

  return node;
}

static void
about_requester(void)
{
  AutoRequest(window,&AboutText[0],&AboutText[1],
	      &AboutText[2],0,0,310,48);
}

static void
new_setting(void)
{
  init_game_time();
  area = DEFAULT_AREA;
  refresh_title();
}

static void
open_setting(void)
{

  FILE	*fp = NULL;
  char	nbuf[256];

  if (!request || !window) return;
  if (!AslRequestTags((APTR)request,
		      ASLFR_SleepWindow, TRUE,
		      ASLFR_TitleText, (STRPTR)"Open setting",
		      ASLFR_PositiveText, (STRPTR)"Open",
		      ASLFR_InitialPattern, (STRPTR)"#?.dat",
		      ASLFR_DoPatterns, TRUE,
		      TAG_DONE
		      )) return;

  strcpy(nbuf, request->fr_Drawer);
  AddPart(nbuf, request->fr_File, 256);

  /* Something like: */
  if ((fp = fopen(nbuf, "r")) == NULL) {
    sprintf(buf, "Error opening file %s", nbuf);
    show_msg(buf);
    return;
  }

  if (fscanf(fp, "%s\n", nbuf) != 1 ||
      strcmp(nbuf, "RAID") != 0) {
    show_msg("This is not a RoleAid data (.dat) file!\n");
    fclose(fp);
    return;
  }

  if (fscanf(fp, "%d\n%d\n%d\n%d\n%d\n%d\n",
	     &area, &year, &day, &hours, &mins, &secs) != 6)
    show_msg("Strange settings file loaded. May be wrong.");
  else
    show_msg("Settings loaded.");

  fclose(fp);

  return;
}

static void
save_setting(char flag)
{
  FILE	*fp = NULL;
  char	nbuf[256];

  if (!request || !window) return;
  if (!AslRequestTags(request,
		      ASLFR_DoSaveMode, TRUE,
		      ASLFR_SleepWindow, TRUE,
		      ASLFR_TitleText, (STRPTR)"Save settings",
		      ASLFR_PositiveText, (STRPTR)"Save",
		      ASLFR_InitialPattern, (STRPTR)"#?.dat",
		      ASLFR_DoPatterns, TRUE,
		      TAG_DONE)) return;

  strcpy(nbuf, request->fr_Drawer);
  AddPart(nbuf, request->fr_File, 256);

  /* Something like: */
  if ((fp = fopen(nbuf, "w")) == NULL) {
    sprintf(buf, "Error when saving to file %s", nbuf);
    show_msg(buf);
    return;
  }

  /* IFF RAID ? */
  fprintf(fp, "RAID\n%d\n%d\n%d\n%d\n%d\n%d\n",
	  area, year, day, hours, mins, secs);

  fclose(fp);

  show_msg("Saved.");

  return;
}

char *timenames[] = {
  "Second", "Round", "Minute", "Turn", "Hour", "Day", "Week", "Month", "Year"
};

void
openup()
{
  BYTE 		error;
  int		i;
#ifdef SOUNDS
  __aligned struct FileInfoBlock sdirfib;
  struct Node	*node = NULL;

  NewList(&sdirlist);
  current_sample = -1;
#endif

  window = OpenWindowTags(NULL,
			  WA_Top, 11,
			  WA_Height, 245,
			  WA_DetailPen, 0,
			  WA_BlockPen, 1,
			  WA_IDCMP,
			   IDCMP_MENUVERIFY | IDCMP_MENUPICK |
			   IDCMP_CLOSEWINDOW |
			   IDCMP_REFRESHWINDOW |
			   BUTTONIDCMP |
			   LISTVIEWIDCMP,
			  WA_Flags,
			   WFLG_CLOSEGADGET | WFLG_SMART_REFRESH |
			   WFLG_DEPTHGADGET | WFLG_ACTIVATE |
			   WFLG_DRAGBAR,
			  WA_PubScreen, NULL,
			  TAG_DONE
			  );

  if (!window) cleandown(ERROR_NO_FREE_STORE);

  rp = window->RPort;

/* TODO: Menus with LayOut...thing. Area menuitems' names are a problem... */
  /* Initialize IntuiTexts */
  for (i = 0; i < 34; i++) {

    AreaText[i].FrontPen = 2;
    AreaText[i].BackPen = 1;
    AreaText[i].DrawMode = JAM1;
    AreaText[i].LeftEdge = CHECKWIDTH;
    AreaText[i].TopEdge = 1;
    AreaText[i].ITextFont = NULL;
    AreaText[i].IText = aw[i].area_name;
    AreaText[i].NextText = NULL;
  }

  /* Attach menus */
  SetMenuStrip( window, FirstMenu);

/* TODO: Get rid of console! */
  /* Open console device & stuff */
  if (!(writeport = CreatePort("RoleAid.console.write",0)))
    cleandown(RETURN_FAIL);

  if (!(writereq = (struct IOStdReq *)CreateExtIO(writeport,
	   (LONG)sizeof(struct IOStdReq)))) cleandown(RETURN_FAIL);

  writereq->io_Data = (APTR) window;
  writereq->io_Length = sizeof(struct Window);

  if(error = OpenDevice("console.device",0,writereq,0))
    cleandown(RETURN_FAIL);
  OpenedConsole = TRUE;

#ifdef SOUNDS
  /* Read sound directory, if there is one, then prepare a
     listview of the sounds. */

  if (!dfind(&sdirfib, "sounds/#?", 0)) {
    do {
      if (!(node = AllocNode(sdirfib.fib_FileName)))
	cleandown(ERROR_NO_FREE_STORE);

      AddHead(&sdirlist, node);

    } while (!dnext(&sdirfib));
  }
#endif

  /* Gadtools stuff */
  if (!(visinfo = GetVisualInfoA(window->WScreen, NULL)))
    cleandown(ERROR_NO_FREE_STORE);

  if (!(gad = CreateContext(&glist))) cleandown(ERROR_NO_FREE_STORE);

  newgadget.ng_VisualInfo = visinfo;

  /* Do gadgets here...
   */

  /* Time texts and +/- buttons */
  newgadget.ng_Width = 70;
  newgadget.ng_Height = 10;

  for (i = 0; i < 9; i ++) {
    newgadget.ng_TopEdge = 66 + i * 11;
    newgadget.ng_LeftEdge = 68;
    newgadget.ng_Width = 65;
    newgadget.ng_GadgetText = NULL;
    gad = CreateGadget(TEXT_KIND, gad, &newgadget,
		       GTTX_Text, timenames[i],
		       GTTX_Border, TRUE,
		       GTTX_Justification, GTJ_CENTER,
		       TAG_DONE);

    newgadget.ng_Width = 30;
    newgadget.ng_LeftEdge = 142;
    newgadget.ng_GadgetText = "-";
    newgadget.ng_GadgetID = i * 2 + 1;
    gad = CreateGadget(BUTTON_KIND, gad, &newgadget, TAG_DONE);

    newgadget.ng_LeftEdge = 180;
    newgadget.ng_GadgetText = "+";
    newgadget.ng_GadgetID = i * 2;
    gad = CreateGadget(BUTTON_KIND, gad, &newgadget, TAG_DONE);
  }

  newgadget.ng_TopEdge = 53;
  newgadget.ng_LeftEdge = 68;
  newgadget.ng_Width = 142;
  newgadget.ng_Height = 10;
  newgadget.ng_GadgetText = NULL;
  gad = CreateGadget(TEXT_KIND, gad, &newgadget,
		     GTTX_Text, "Change time",
		     GTTX_Border, FALSE,
		     TAG_DONE);

  newgadget.ng_Width = 288;
  newgadget.ng_LeftEdge = 68;
  newgadget.ng_TopEdge = 18;
  newgadget.ng_GadgetText = "High Open-ended d100 (Attack Roll)";
  newgadget.ng_GadgetID = 0x1001;
  gad = CreateGadget(BUTTON_KIND, gad, &newgadget, TAG_DONE);

  newgadget.ng_Width = 288;
  newgadget.ng_LeftEdge = 68;
  newgadget.ng_TopEdge = 29;
  newgadget.ng_GadgetText = "Open-ended d100 (Skill Roll)";
  newgadget.ng_GadgetID = 0x1002;
  gad = CreateGadget(BUTTON_KIND, gad, &newgadget, TAG_DONE);

  newgadget.ng_Width = 288;
  newgadget.ng_LeftEdge = 68;
  newgadget.ng_TopEdge = 40;
  newgadget.ng_GadgetText = "Normal d100";
  newgadget.ng_GadgetID = 0x1003;
  gad = CreateGadget(BUTTON_KIND, gad, &newgadget, TAG_DONE);

#ifdef SOUNDS
  /* Create listview - if there is a list to view */
  if (!IsListEmpty(&sdirlist)) {
    newgadget.ng_Width = 160;
    newgadget.ng_Height = 100;
    newgadget.ng_LeftEdge = 234;
    newgadget.ng_TopEdge = 66;
    newgadget.ng_GadgetText = "Sounds";
    newgadget.ng_GadgetID = 0x2000;
    gad = CreateGadget(LISTVIEW_KIND, gad, &newgadget,
		       GTLV_Labels, &sdirlist,
		       GTLV_ReadOnly, FALSE,
		       GTLV_ShowSelected, NULL,
		       TAG_DONE);

    /* Create big "play sound" gadget */
    newgadget.ng_Width = 160;
    newgadget.ng_Height = 100;
    newgadget.ng_LeftEdge = 418;
    newgadget.ng_GadgetText = "Play Sound";
    newgadget.ng_GadgetID = 0x2001;
    gad = CreateGadget(BUTTON_KIND, gad, &newgadget, TAG_DONE);
  }
#endif

  AddGList(window, glist, ~0, ~0, NULL);
  RefreshGList(glist, window, NULL, ~0);
  GT_RefreshWindow(window, NULL);

  /* Allocate ASL Filerequester */
  request = (struct FileRequester *)
    AllocAslRequest(ASL_FileRequest, NULL);
}

void
cleandown(int error)
{
  if (OpenedConsole) CloseDevice(writereq);
  if (writereq) DeleteExtIO(writereq);
  if (writeport) DeletePort(writeport);

  if (request) FreeAslRequest((APTR)request);

  if (glist) {
    (void)RemoveGList(window, window->FirstGadget, ~0);
    FreeGadgets(glist);

  }

#ifdef SOUNDS
  if (!IsListEmpty(&sdirlist)) FreeList(&sdirlist);
#endif

  if (window) {
    if (window->MenuStrip) ClearMenuStrip(window);
    CloseWindow(window);
  }

  if (visinfo) FreeVisualInfo(visinfo);

  exit(error);
}

void
at(int x,int y)
{
  char temp[80];

  sprintf(temp,"\033[%d;%dH",y,x);
  ConPuts(temp);
}

void
diceshow(int x)
{
  at(1, 21); ConPuts(EMPTY_LINE); at(38,21);
  sprintf(buf, "%d",x);
  ConPuts(COLOR02); ConPuts(buf);
}

void
show_msg(char *msg)
{
  at(1, 21); ConPuts(EMPTY_LINE);

  if (!msg) return;

  at(40 - (strlen(msg) / 2), 21);

  ConPuts(COLOR02); ConPuts(msg);
}

void
handle_gadgets(struct IntuiMessage *msg, USHORT x)
{
  int	i, d;
  char buf[80];

  switch (x) {
  case 0:
    add_secs(1); fresh = TRUE; break;
  case 1:
    sub_secs(1); fresh = TRUE; break;
  case 2:
    add_secs(10); fresh = TRUE; break;
  case 3:
    sub_secs(10); fresh = TRUE; break;
  case 4:
    add_mins(1); fresh = TRUE; break;
  case 5:
    sub_mins(1); fresh = TRUE; break;
  case 6:
    add_mins(10); fresh = TRUE; break;
  case 7:
    sub_mins(10); fresh = TRUE; break;
  case 8:
    add_hours(1); fresh = TRUE; break;
  case 9:
    sub_hours(1); fresh = TRUE; break;
  case 10:
    add_days(1); fresh = TRUE; break;
  case 11:
    sub_days(1); fresh = TRUE; break;
  case 12:
    add_days(7); fresh = TRUE; break;
  case 13:
    sub_days(7); fresh = TRUE; break;
  case 14:
    add_days(30); fresh = TRUE; break;
  case 15:
    sub_days(30); fresh = TRUE; break;
  case 16:
    add_years(1); fresh = TRUE; break;
  case 17:
    sub_years(1); fresh = TRUE; break;
    
  case 0x1001:
    i = d = random(100) + 1;

    if (d > 95) {
      d = random(100) + 1;
      i += d;
      while (d > 95) {
	d = random(100) + 1;
	i += d;
      }
    }

    diceshow(i);
    break;

  case 0x1002:
    i = d = random(100) + 1;

    if (d > 95) {
      d = random(100) + 1;
      i += d;
      while (d > 95) {
	d = random(100) + 1;
	i += d;
      }
    } else if (d < 6) {
      d = random(100) + 1;
      i -= d;
      while (d > 95) {
	d = random(100) + 1;
	i -= d;
      }
    }

    diceshow(i);
    break;

  case 0x1003:
    d = random(100) + 1;
    diceshow(d);
    break;

#ifdef SOUNDS
  case 0x2000:
    current_sample = msg->Code;
    break;

  case 0x2001:
    /* Play sound! */
    if (current_sample == -1) {
      DisplayBeep(window->WScreen);
      break;
    }

    sprintf(buf, "C:Run >NIL: Play8SVX sounds/%s",
	    NthNode(&sdirlist, current_sample)->ln_Name);
    (void)system(buf);

    break;
#endif

  default:
    break;
  }
}

void
show_roletime(void)
{
  ConPuts(COLOR01);
  at(1, 23); ConPuts(EMPTY_LINE);
  at(40 - (strlen(aw[area].area_name) / 2), 23);
  ConPuts(aw[area].area_name);

  at(1, 25); ConPuts(EMPTY_LINE);
  sprintf(buf, "%s", weather_desc());
  at(40 - (strlen(buf) / 2), 25);

  /* Show weather in "cold" or "warm" color (or neutral when near 0°C) */
  if (temp < 31) ConPuts(COLOR02);
  else if (temp > 33) ConPuts(COLOR03);
  else ConPuts(COLOR01);
  ConPuts(buf);

  at(1, 27); ConPuts(EMPTY_LINE);
  at(1, 28); ConPuts(EMPTY_LINE);

  if (query_month() != -1)
    sprintf(buf, "%s, %d T.A., Day %d of month %d (%s)",
	    query_season_english(),
	    query_year(),
	    query_day(),
	    query_month(),
	    query_month_name());
  else
    /* Festival */
    sprintf(buf, "%s (%s) in %d T.A.",
	    query_season_english(),
	    query_month_name(),
	    query_year());

  at((40 - (strlen(buf) / 2)), 27);
  ConPuts(COLOR01); ConPuts(buf);

  sprintf(buf, "Time %02d:%02d:%02d (%s)",
	  query_hours(),
	  query_mins(),
	  query_secs(),
	  query_daytime());

  at((40 - (strlen(buf) / 2)),28);

  ConPuts(buf);
}

/* Show some information in the screen title */
void
refresh_title()
{
  sprintf(title, "Area: %s", aw[area].area_name);
  SetWindowTitles(window, wintitle, title);
}

/*
 * Main program
 *
 */
int
main(int argc, char *argv[])
{
  struct IntuiMessage *msg = NULL;
  ULONG class;
  USHORT code;

  srand(time(NULL));

  openup();
  refresh_title();

  ConPuts(CURSOFF); ConPuts(COLOR01);

  init_game_time();
  show_roletime();
  refresh_title();

  GT_RefreshWindow(window, NULL);

  for(;;) {

    Wait( 1L << window->UserPort->mp_SigBit );

    while ((msg = GT_GetIMsg(window->UserPort))) {
      class = msg->Class;
      code = msg->Code;

      switch (class) {

      case LISTVIEWIDCMP:
	DisplayBeep(window->WScreen);
	break;

      case BUTTONIDCMP:
	handle_gadgets(msg, ((struct Gadget *)(msg->IAddress))->GadgetID);
	break;

      case IDCMP_CLOSEWINDOW:
	cleandown(0);
	break;

      case IDCMP_MENUPICK:
	HandleMenus(code);
	break;

      case IDCMP_REFRESHWINDOW:
	GT_BeginRefresh(window);    
	GT_EndRefresh(window, TRUE);
	break;

      default:
	break;

      } /* End switch */

      GT_ReplyIMsg(msg);

    } /* End while ( msg = ... ) */

    if (fresh) {
      show_roletime();
      fresh = FALSE;
    }

  } /* End of main loop */

  cleandown(0); /* Can't come to this, but... */
}

void
HandleMenus(USHORT code)
{
  USHORT selection,flags;
  ULONG menunum,itemnum,subnum;

  selection = code;


  while(selection != MENUNULL) {
    menunum = MENUNUM(selection);
    itemnum = ITEMNUM(selection);
    subnum = SUBNUM(selection);
    flags = ((struct MenuItem *)
	     ItemAddress(FirstMenu, (LONG) selection))->Flags;

    switch (menunum)
      {
      case 0:		/* Project Menu */
	switch (itemnum)
	  {
	  case 0: /* New */
	    /* Todo: confirm */
	    new_setting();
	    fresh = TRUE;
	    break;
	  case 1: /* Open */
	    open_setting();
	    fresh = TRUE;
	    break;
	  case 2: /* Save */
	    save_setting(0);
	    fresh = TRUE;
	    break;
	  case 3: /* Save As... */
	    save_setting(1);
	    fresh = TRUE;
	    break;
	  case 4: /* Print */
	    break;
	  case 5: /* Setup */
	    break;
	  case 6: /* About */
	    about_requester();
	    break;
	  case 7: /* Quit */
	    cleandown(0);
	    break;
	  default:
	    break;
	  }
	break;
      case 1:		/* Northern Area Menu */
	area = itemnum; /* Simple */
	refresh_title();
	fresh = TRUE;
	break;
      default:
	/* What a strange menu */
	break;
      }
    selection = ((struct MenuItem *) ItemAddress
		 (FirstMenu, (LONG) selection))->NextSelect;
  }
}

/* Console device functions */
/* We use DoIO - we're not in a hurry... */

void ConPutChar(char ch)
{
  writereq->io_Command = CMD_WRITE;
  writereq->io_Data = (APTR) &ch;
  writereq->io_Length = 1;
  DoIO(writereq);
}

void ConWrite(char *string, LONG length)
{
  writereq->io_Command = CMD_WRITE;
  writereq->io_Data = (APTR) string;
  writereq->io_Length = length;
  DoIO(writereq);
}

/* Be careful with this one - it must be null-terminated... */
void ConPuts(char *string)
{
  writereq->io_Command = CMD_WRITE;
  writereq->io_Data = (APTR) string;
  writereq->io_Length = -1;
  DoIO(writereq);
}
