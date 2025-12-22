/*
 * This is a modified version of Michael Warner's
 * Public Domain Workbench SNAKE game.
 *
 * This (improved?) version by Torsten Poulin
 * is, of course, still in the public domain.
 *
 *   Torsten Poulin
 *   Banebrinken 99, 2, 77
 *   DK-2400 Copenhagen NV
 *   DENMARK
 *
 * THIS IS A WB 2+ PROGRAM!!!
 *
 * $Log:	Orm.c,v $
 * Revision 1.4  93/10/21  16:21:23  Torsten
 * Pause key changed from 'P' to spacebar.
 * 
 * Revision 1.3  93/10/19  18:05:15  Torsten
 * Localized. Defaults to builtin Danish strings if
 * locale.library isn't available; thus, it still runs
 * under AmigaDOS 2.04 (V37).
 * 
 * Revision 1.2  93/10/12  18:03:27  Torsten
 * Added function prototypes.
 * Can be compiled with either DICE or SAS/C 5.10.
 * Tries to be smart about the screen display mode.
 * Obstacles disabled on two-colour screens.  
 * Knows about window border sizes.
 * 
 * Revision 1.1  93/10/12  00:04:41  Torsten
 * This is my first version of Michael's game.
 * 
 */

char RCSid[] = "$Id: Orm.c,v 1.4 93/10/21 16:21:23 Torsten Rel $";
char version[] = "$VER: Orm 1.4 (21.10.93)";
char copyright[] = "$COPYRIGHT:*PUBLIC DOMAIN* - M. Warner & T. Poulin$";

#include <exec/types.h>
#include <intuition/intuition.h>
#include <libraries/locale.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/dos_protos.h>
#include <clib/locale_protos.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include "orm.h"

/*
 * Compiler dependencies
 */

#if defined(__SASC) | defined(LATTICE) | defined(_DCC)

#ifdef _DCC
void fool_DICE(void) { _waitwbmsg(); }
#define main _main
#define __far
#define __stdargs

#else /* __SASC | LATTICE */
#ifdef __SASC_510
#include <pragmas/exec_pragmas.h>
#include <pragmas/intuition_pragmas.h>
#include <pragmas/graphics_pragmas.h>
#include <pragmas/locale_pragmas.h>
extern struct DosLibrary *DOSBase;
#include <pragmas/dos_pragmas.h>
#endif /* __SASC_510 */
void main(void);
void _main(char *dummy) { main(); }
#endif /* __SASC | LATTICE */

#else /* something else */
#define __far
#define __stdargs
#endif

#define XSIZE 40
#define YSIZE 40
#define BSIZE 3
#define NFROGS 4
#define PRIORITY 0

#define CLEAR 1
#define SNAKE 0
#define BRICK 3
#define FROG  2

#define KEY_ESC   69
#define KEY_Pause 64
#define KEY_UP    76
#define KEY_DOWN  77
#define KEY_RIGHT 78
#define KEY_LEFT  79

extern UWORD __stdargs RangeRand(ULONG maxValue);
void exit_prog(int num);
void open_window(void);
void close_window(void);
void notify(char *str);
void set_point(int x, int y, int item);
void clear_grid(void);
void draw_score(void);
void pause(void);
void create_frog(int n);
void check_frogs(void);
void replace_frog(int x, int y);
void setup_game(void);
BOOL play_one_game(void);
void play_game(void);
void randomize(void);
char *getcatalogstr(struct Catalog *, LONG, char *);

APTR IntuitionBase, GfxBase;
struct LocaleBase *LocaleBase;
struct Catalog *catalog;
struct Window *win;
struct RastPort *rp;
LONG xstretch, ystretch;
LONG border_left, border_top;

UBYTE grid[XSIZE][YSIZE];
UBYTE snx[1500], sny[1500], frx[NFROGS], fry[NFROGS];
int dir, length, head, tail, grow, frogtime[NFROGS];
UBYTE key;
BOOL has_obsta = FALSE;


void exit_prog(int num)
{
  if (LocaleBase) CloseLibrary((struct Library *) LocaleBase);
  if (GfxBase) CloseLibrary((struct Library *) GfxBase);
  if (IntuitionBase) CloseLibrary((struct Library *) IntuitionBase);
  exit(num);
}


void open_window(void)
{
  struct Screen *scr;
  struct DrawInfo *scr_di;
  char *title;

  if (!(scr = LockPubScreen(NULL)))
    exit_prog(20);

  if (scr_di = GetScreenDrawInfo(scr)) {
    has_obsta = scr_di->dri_Depth > 1;
    FreeScreenDrawInfo(scr, scr_di);
  }

  /*
   * Determine stretch factors heuristically.
   * Please note that this is a hack and the result
   * will not be pleasing in the VGA-ExtraLores modes :-(
   */
  if (scr->Width <= 500)
    xstretch = 1; /* Lores */
  else if (scr->Width <= 800)
    xstretch = 2; /* Hires */
  else
    xstretch = 4; /* SuperHires or A2024 */

  if (scr->Height <= 300)
    ystretch = 1; /* Not interlaced */
  else if (scr->Height <= 700)
    ystretch = 2; /* Productivity or interlaced */
  else
    ystretch = 4; /* Interlaced Productivity or A2024 */

  if (has_obsta)
    title = getcatalogstr(catalog, MSG_SCRTITLE1, MSG_SCRTITLE1_STR);
  else
    title = getcatalogstr(catalog, MSG_SCRTITLE2, MSG_SCRTITLE2_STR);

  win = OpenWindowTags(NULL,
		       WA_InnerWidth, XSIZE*BSIZE*xstretch+2*xstretch,
		       WA_InnerHeight, YSIZE*BSIZE*ystretch+2*ystretch+1,
		       WA_IDCMP, CLOSEWINDOW | RAWKEY,
		       WA_ScreenTitle, title,
		       WA_Flags, ACTIVATE
		       | WINDOWCLOSE
		       | WINDOWDRAG
		       | RMBTRAP
		       | WINDOWDEPTH
		       | SMART_REFRESH
		       | NOCAREREFRESH,
		       TAG_DONE);

  UnlockPubScreen(NULL, scr);

  if (!win)
    exit_prog(20);
  rp = win->RPort;
  border_left = win->BorderLeft + xstretch;
  border_top = win->BorderTop + ystretch;
}


void close_window(void)
{
  CloseWindow(win);
}


void notify(char *str)
{
  struct EasyStruct es;

  es.es_StructSize = sizeof(struct EasyStruct);
  es.es_Flags = 0;
  es.es_Title = getcatalogstr(catalog,
			      MSG_EASYREQ_RESULT_TITLE,
			      MSG_EASYREQ_RESULT_TITLE_STR);
  es.es_TextFormat = str;
  es.es_GadgetFormat = getcatalogstr(catalog,
				     MSG_EASYREQ_RESULT_GAD,
				     MSG_EASYREQ_RESULT_GAD_STR);
  EasyRequestArgs(NULL, &es, NULL, NULL);
}


#define bleft (border_left + (x * BSIZE * xstretch))
#define bwidth (border_left + (x * BSIZE * xstretch) + BSIZE * xstretch - 1)
#define btop (border_top + (y * BSIZE * ystretch))
#define bheight (border_top + (y * BSIZE * ystretch) + BSIZE * ystretch - 1)

void set_point(int x, int y, int item)
{
  grid[x][y] = item;

  SetAPen(rp, item);
  RectFill(rp, bleft, btop, bwidth, bheight);
}


void clear_grid(void)
{
  int x, y;

  for (x = 0; x < XSIZE; x++)
    for (y = 0; y < YSIZE; y++)
      grid[x][y] = CLEAR;
  SetAPen(rp, CLEAR);
  RectFill(rp,
	   border_left, border_top,
	   border_left + XSIZE * BSIZE * xstretch,
	   border_top + YSIZE * BSIZE * ystretch);
}


void draw_score(void)
{
  static char str[20];
  char *fmtstr;

  fmtstr = getcatalogstr(catalog, MSG_WINDOWTITLE, MSG_WINDOWTITLE_STR);
  sprintf(str, fmtstr, length);
  SetWindowTitles(win, str, (APTR) -1);
}


void pause(void)
{
  struct IntuiMessage *msg;

  for (;;) {
    msg = (struct IntuiMessage *) WaitPort(win->UserPort);
    if (msg->Class == RAWKEY && msg->Code & 0x80)
      ReplyMsg(GetMsg(win->UserPort));
    else
      return;
  }
}


void create_frog(int n)
{
  int x, y;

  do {
    x = RangeRand(XSIZE);
    y = RangeRand(YSIZE);
  } while (grid[x][y] != CLEAR);
  frx[n] = x;
  fry[n] = y;
  set_point(x, y, FROG);
  frogtime[n] = 20 + RangeRand(50);
}


void check_frogs(void)
{
  int n, x, y;

  for (n = 0; n < NFROGS; n++) {
    if (!frogtime[n]--) {
      x = frx[n];
      y = fry[n];
      create_frog(n);
      if (has_obsta)
	set_point(x, y, RangeRand(10) ? CLEAR : BRICK);
      else
	set_point(x, y, CLEAR);
    }
  }
}


void replace_frog(int x, int y)
{
  int n;

  for (n = 0; n < NFROGS; n++) {
    if (frx[n] == x && fry[n] == y)
      create_frog(n);
  }
  set_point(x, y, CLEAR);
}


void setup_game(void)
{
  int i;

  clear_grid();
  length = 1;
  draw_score();
  head = tail = 0;
  snx[0] = XSIZE / 2;
  sny[0] = YSIZE / 2;
  set_point(snx[0], sny[0], SNAKE);
  key = KEY_RIGHT;
  for (i = 0; i < NFROGS; i++)
    create_frog(i);
  draw_score();
}


BOOL play_one_game(void)
{
  int item;
  struct IntuiMessage *msg;
  ULONG class;
  USHORT code;
  int x, y, nx, ny;

  for (;;) {
    Delay(4L);
    WaitTOF();
    while (msg = (struct IntuiMessage *) GetMsg(win->UserPort)) {
      class = msg->Class;
      code = msg->Code;
      ReplyMsg((struct Message *) msg);
      switch (class) {
      case CLOSEWINDOW:
	return (TRUE);
      case RAWKEY:
	if (!(code & 0x80))
	  switch (code) {
	  case KEY_ESC:
	    return TRUE;
	  case KEY_Pause:
	    pause();
	    break;
	  case KEY_UP:
	  case KEY_DOWN:
	  case KEY_LEFT:
	  case KEY_RIGHT:
	    key = code;
	  }
      }
    }

    x = snx[head];
    y = sny[head];
    switch (key) {
    case KEY_UP:
      nx = x;
      ny = y - 1;
      break;
    case KEY_DOWN:
      nx = x;
      ny = y + 1;
      break;
    case KEY_LEFT:
      nx = x - 1;
      ny = y;
      break;
    case KEY_RIGHT:
      nx = x + 1;
      ny = y;
      break;
    }
    if (nx < 0 || ny < 0 || nx >= XSIZE || ny >= YSIZE)
      return FALSE;
    item = grid[nx][ny];
    switch (item) {
    case FROG:
      grow += 2 + RangeRand(10);
      replace_frog(nx, ny);
    case CLEAR:
      head = (head + 1) % 1500;
      snx[head] = nx;
      sny[head] = ny;
      set_point(nx, ny, SNAKE);
      if (grow) {
	grow--;
	length++;
	draw_score();
      } else {
	set_point(snx[tail], sny[tail], CLEAR);
	tail = (tail + 1) % 1500;
      }
      break;
    case SNAKE:
    case BRICK:
      return (FALSE);
    }
    check_frogs();
  }
}


void play_game(void)
{
  char str[80], *fmtstr;

  for (;;) {
    setup_game();
    WaitPort(win->UserPort);
    if (play_one_game())
      return;
    fmtstr = getcatalogstr(catalog,
			   MSG_EASYREQ_RESULT,
			   MSG_EASYREQ_RESULT_STR);
    sprintf(str, fmtstr, length);
    notify(str);
  }
}


void randomize(void)
{
  extern ULONG __far RangeSeed;
  time_t t;

  time(&t);
  RangeSeed = (ULONG) t;
}


char *getcatalogstr(struct Catalog *catalog, LONG strNum, char *defStr)
{
  if (LocaleBase)
    return (char *) GetCatalogStr(catalog, strNum, defStr);
  else
    return defStr;
}


void main(void)
{
  BYTE old_pri;
  struct TagItem OC_tags[2];

  OC_tags[0].ti_Tag = OC_BuiltInLanguage;
  OC_tags[0].ti_Data = (ULONG) "dansk";
  OC_tags[1].ti_Tag = TAG_DONE;
  OC_tags[1].ti_Data = NULL;

  if (IntuitionBase = OpenLibrary("intuition.library", 37L))
    if (GfxBase = OpenLibrary("graphics.library", 37L)) {
      LocaleBase = (struct LocaleBase *) OpenLibrary("locale.library", 38L);
      if (LocaleBase)
	catalog = OpenCatalogA(NULL, "Orm.catalog", OC_tags);
      randomize();
      open_window();
      old_pri = SetTaskPri(FindTask(0), PRIORITY);
      play_game();
      close_window();
      SetTaskPri(FindTask(0), old_pri);
      if (LocaleBase)
	CloseCatalog(catalog);
      }
  exit_prog(0);
}
