/*
 * main.c
 * ======
 * Main module.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <dos/dosextens.h>
#include <intuition/gadgetclass.h>
#include <intuition/imageclass.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>

#include <apputil.h>

#include "menustrip.h"
#include "menuactions.h"
#include "boardgadget.h"
#include "panelgadget.h"
#include "markers.h"
#define CATCOMP_NUMBERS
#include "stringnumbers.h"


#define APPNAME        "NewMasterMind"
#define BASENAME       "newmastermind"
#define VERSION        "1.3"
#define VERSION_DATE   "(8.11.100)"
#define COPYRIGHT_YEAR "1994-2000"
#define AUTHOR         "Håkan L. Younes"
#define EMAIL_ADDRESS  "(lorens@hem.passagen.se)"

#define TEMPLATE "PUBSCREEN/K,SETTINGS/K,LANGUAGE/K"
#define PUBSCREEN_ARG 0
#define SETTINGS_ARG  1
#define LANGUAGE_ARG  2
#define NUM_ARGS      3

static UBYTE version[] = "$VER: " APPNAME " " VERSION " " VERSION_DATE;

LONG __oslibversion = 37L;

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct Library *GadToolsBase;
struct Library *UtilityBase;

static Class *buttonClass = NULL;
static Class *boardClass = NULL;
static Class *panelClass = NULL;

static struct Process *proc;
static struct Screen *screen = NULL;
static struct Window *main_win = NULL;
static struct Gadget *boardGad = NULL;
static struct Gadget *panelGad = NULL;
static struct Gadget *okGad = NULL;

static BOOL quit = FALSE;


static BOOL Initialize(STRPTR screenName);
static BOOL InitLibraries(VOID);
static BOOL InitDisplay(STRPTR screenName);
static BOOL InitGadgets(VOID);
static VOID EventLoop(VOID);
static VOID Finalize(VOID);


typedef struct {
  BOOL useColors;
  Opponent opponent;
  CorrectionMethod correctionMethod;
  short numColors;
  WORD winLeft, winTop;
  WORD zoomLeft, zoomTop;
  WORD scrWidth, scrHeight;
} Settings;

static Settings settings = {
  TRUE,
  OPPONENT_COMPUTER,
  CORRECTION_METHOD_ADULTS,
  6,
  -1, -1,
  -1, -1,
  -1, -1
};


int main(int argc, char **argv) {
  LONG args[NUM_ARGS];
  struct RDArgs *rdargs;

  args[PUBSCREEN_ARG] = NULL;
  args[SETTINGS_ARG] = NULL;
  args[LANGUAGE_ARG] = NULL;
  if (argc == 0) {
    rdargs = ReadArgsWB(TEMPLATE, args, (struct WBStartup *)argv);
  } else {
    rdargs = ReadArgsCLI(TEMPLATE, args);
  }

  InitSettings((STRPTR)args[SETTINGS_ARG], BASENAME, &settings,
	       sizeof settings);
  PreCheckMenuItem(MENU_ITEM_OPPONENT + settings.opponent + 1L);
  PreCheckMenuItem(MENU_ITEM_CORRECTION + settings.correctionMethod + 1L);
  PreCheckMenuItem(MENU_ITEM_NUM_COLORS + settings.numColors / 2 - 1L);

  InitLocaleInfo(BASENAME ".catalog", (STRPTR)args[LANGUAGE_ARG], 0);
  if (Initialize((STRPTR)args[PUBSCREEN_ARG])) {
    EventLoop();
  }
  FreeArgsCLIWB(rdargs);
  Finalize();
  DisposeLocaleInfo();
  DisposeSettings();

  return 0;
}


static VOID EventLoop(VOID) {
  struct IntuiMessage *msg;
  ULONG class;
  UWORD code;
  WORD  mx, my;
  ULONG fullIDCMP = main_win->IDCMPFlags;
  BOOL zoomed = FALSE;

  while (!quit) {
    WaitPort(main_win->UserPort);
    while (msg = (struct IntuiMessage *)GetMsg(main_win->UserPort)) {
      class = msg->Class;
      code = msg->Code;
      mx = msg->MouseX;
      my = msg->MouseY;
      ReplyMsg((struct Message *)msg);
      switch (class) {
      case IDCMP_RAWKEY:
      case IDCMP_MOUSEMOVE:
      case IDCMP_ACTIVEWINDOW:
	if (PointInGadget((ULONG)(mx << 16L) + my, boardGad)) {
	  ActivateGadget(boardGad, main_win, NULL);
	}
	break;
      case IDCMP_GADGETUP:
	BoardEnterRow(boardGad, main_win);
	break;
      case IDCMP_MENUPICK:
	ProcessMenuEvents(main_win, code);
	break;
      case IDCMP_CLOSEWINDOW:
	Quit();
	break;
      case IDCMP_CHANGEWINDOW:
	if (!zoomed && (main_win->Flags & WFLG_ZOOMED)) {
	  zoomed = TRUE;
	  ModifyIDCMP(main_win, IDCMP_CLOSEWINDOW |
		      IDCMP_CHANGEWINDOW | IDCMP_REFRESHWINDOW);
	} else if (zoomed && !(main_win->Flags & WFLG_ZOOMED)) {
	  zoomed = FALSE;
	  ModifyIDCMP(main_win, fullIDCMP);
	}
	if (zoomed) {
	  settings.zoomLeft = main_win->LeftEdge;
	  settings.zoomTop = main_win->TopEdge;
	}
	break;
      }
    }
  }
}


static BOOL Initialize(STRPTR screenName) {
  return (BOOL)(InitLibraries() && InitDisplay(screenName));
}


static BOOL InitLibraries(VOID) {
  IntuitionBase =
    (struct IntuitionBase *)OpenLibrary("intuition.library", 37L);
  GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 37L);
  GadToolsBase = OpenLibrary("gadtools.library", 37L);
  UtilityBase = OpenLibrary("utility.library", 37L);
  if (IntuitionBase == NULL) {
    return FALSE;
  } else if (GfxBase == NULL) {
    MessageRequester(NULL, "Init Error",
		     "Could not open %s!", "OK", "graphics.library");
  } else if (GadToolsBase == NULL) {
    MessageRequester(NULL, "Init Error",
		     "Could not open %s!", "OK", "gadtools.library");
  } else if (UtilityBase == NULL) {
    MessageRequester(NULL, "Init Error",
		     "Could not open %s!", "OK", "utility.library");
  } else {
    return TRUE;
  }

  return FALSE;
}


static BOOL InitDisplay(STRPTR screenName) {
  UWORD winWidth, winHeight;
  WORD zoomBox[4];

  buttonClass = CreateButtonClass();
  if (buttonClass == NULL) {
    MessageRequester(NULL, "Init Error",
		     "Could not create %s class!", "OK", "button gadget");
    return FALSE;
  }

  boardClass = CreateBoardClass();
  if (boardClass == NULL) {
    MessageRequester(NULL, "Init Error",
		     "Could not create %s class!", "OK", "board gadget");
    return FALSE;
  }

  panelClass = CreatePanelClass();
  if (panelClass == NULL) {
    MessageRequester(NULL, "Init Error",
		     "Could not create %s class!", "OK", "panel gadget");
    return FALSE;
  }

  screen = LockPubScreen(screenName);
  if (screen == NULL && screenName != NULL) {
    screen = LockPubScreen(NULL);
  }
  if (screen == NULL) {
    MessageRequesterA(NULL, "Init Error",
		      "Could not lock public screen!", "OK", NULL);
    return FALSE;
  }

  if (!InitMarkers(screen)) {
    MessageRequesterA(NULL, "Init Error",
		      "Could not initialize graphics!", "OK", NULL);
    return FALSE;
  }

  if (!UseColoredMarkers()) {
    PreDisableMenuItem(MENU_ITEM_COLOR_DISPLAY);
  }
  SetColoredMarkers(settings.useColors);
  if (!UseColoredMarkers()) {
    PreCheckMenuItem(MENU_ITEM_COLOR_DISPLAY);
  }

  if (!InitGadgets()) {
    MessageRequesterA(NULL, "Init Error",
		      "Could not create gadgets!", "OK", NULL);
    return FALSE;
  }

  winWidth = boardGad->LeftEdge + boardGad->Width + INTERWIDTH +
    screen->WBorRight;
  winHeight = panelGad->TopEdge + panelGad->Height + INTERHEIGHT +
    screen->WBorBottom;
  if (winWidth > screen->Width || winHeight > screen->Height) {
    MessageRequesterA(NULL, "Init Error",
		      "Screen is too small!", "OK", NULL);
    return FALSE;
  }

  SetupWindowPosition(screen, settings.scrWidth, settings.scrHeight,
		      winWidth, winHeight,
		      &settings.winLeft, &settings.winTop,
		      &settings.zoomLeft, &settings.zoomTop);
  settings.scrWidth = screen->Width;
  settings.scrHeight = screen->Height;
  zoomBox[0] = settings.zoomLeft;
  zoomBox[1] = settings.zoomTop;
  TitleBarExtent(screen, APPNAME, &zoomBox[2], &zoomBox[3]);
  main_win =
    OpenWindowTags(NULL,
		   WA_Left, settings.winLeft,
		   WA_Top, settings.winTop,
		   WA_Width, winWidth,
		   WA_Height, winHeight,
		   WA_Zoom, zoomBox,
		   WA_AutoAdjust, TRUE,
		   WA_Activate, TRUE,
		   WA_Gadgets, boardGad,
		   WA_CloseGadget, TRUE,
		   WA_DepthGadget, TRUE,
		   WA_DragBar, TRUE,
		   WA_Title, APPNAME,
		   WA_ScreenTitle,
		   APPNAME " v" VERSION " - ©" COPYRIGHT_YEAR " " AUTHOR,
		   WA_PubScreen, screen,
		   WA_NewLookMenus, TRUE,
		   WA_ReportMouse, TRUE,
		   WA_IDCMP, (IDCMP_RAWKEY |
			      IDCMP_MOUSEMOVE |
			      IDCMP_ACTIVEWINDOW |
			      IDCMP_GADGETUP |
			      IDCMP_MENUPICK |
			      IDCMP_CLOSEWINDOW |
			      IDCMP_CHANGEWINDOW),
		   TAG_DONE);
  if (main_win == NULL) {
    MessageRequesterA(NULL, "Init Error",
		      "Could not open window!", "OK", NULL);
    return FALSE;
  }

  proc = (struct Process *)FindTask(NULL);
  if (proc != NULL) {
    proc->pr_WindowPtr = main_win;
  }

  if (!CreateMenuStrip(main_win)) {
    MessageRequesterA(NULL, "Init Error",
		      "Could not create menu strip", "OK", NULL);
    return FALSE;
  }

  return TRUE;
}


static BOOL InitGadgets(VOID) {
  struct Image *frame;
  struct DrawInfo *dri;

  panelGad = (struct Gadget *)NewObject(panelClass, NULL,
					PANEL_NumColors, settings.numColors,
					TAG_DONE);
  if (panelGad == NULL) {
    return FALSE;
  }

  frame = (struct Image *)NewObject(NULL, "frameiclass",
				    IA_FrameType, FRAME_BUTTON,
				    TAG_DONE);
  if (frame == NULL) {
    return FALSE;
  }

  dri = GetScreenDrawInfo(screen);
  if (dri == NULL) {
    return FALSE;
  }

  okGad = (struct Gadget *)NewObject(buttonClass, NULL,
				     GA_Previous, panelGad,
				     GA_Image, frame,
				     GA_DrawInfo, dri,
				     GA_Text, GetLocString(MSG_OK_GAD),
				     GA_Disabled, TRUE,
				     GA_RelVerify, TRUE,
				     TAG_DONE);
  FreeScreenDrawInfo(screen, dri);
  if (okGad == NULL) {
    DisposeObject(frame);
    return FALSE;
  }

  boardGad =
    (struct Gadget *)NewObject(boardClass, NULL,
			       GA_Left, screen->WBorLeft + INTERWIDTH,
			       GA_Top, (screen->WBorTop +
					screen->Font->ta_YSize +
					INTERHEIGHT + 1),
			       BOARD_Opponent, settings.opponent,
			       BOARD_CorrectionMethod,
			       settings.correctionMethod,
			       BOARD_Panel, panelGad,
			       BOARD_EnterButton, okGad,
			       TAG_DONE);
  if (boardGad == NULL) {
    return FALSE;
  }

  boardGad->NextGadget = panelGad;
  panelGad->LeftEdge = boardGad->LeftEdge;
  panelGad->TopEdge = boardGad->TopEdge + boardGad->Height + INTERHEIGHT;
  okGad->LeftEdge = panelGad->LeftEdge + panelGad->Width + INTERWIDTH;
  okGad->TopEdge = panelGad->TopEdge;
  if (panelGad->Height < okGad->Height) {
    panelGad->Height = okGad->Height;
  } else if (okGad->Height < panelGad->Height) {
    okGad->TopEdge += (panelGad->Height - okGad->Height) / 2;
  }

  return TRUE;
}


static VOID Finalize(VOID) {
  if (main_win != NULL) {
    DisposeMenuStrip(main_win);
    if (proc != NULL) {
      proc->pr_WindowPtr = NULL;
    }
    CloseWindow(main_win);
  }
  if (okGad != NULL) {
    DisposeObject(okGad->GadgetRender);
  }
  DisposeObject(okGad);
  DisposeObject(panelGad);
  DisposeObject(boardGad);
  if (screen != NULL) {
    FreeMarkers(screen);
    UnlockPubScreen(NULL, screen);
  }
  if (panelClass != NULL) {
    FreeClass(panelClass);
  }
  if (boardClass != NULL) {
    FreeClass(boardClass);
  }
  if (buttonClass != NULL) {
    FreeClass(buttonClass);
  }
  CloseLibrary(UtilityBase);
  CloseLibrary(GadToolsBase);
  CloseLibrary((struct Library *)GfxBase);
  CloseLibrary((struct Library *)IntuitionBase);
}


VOID New(VOID) {
  SetGadgetAttrs(panelGad, main_win, NULL,
		 PANEL_NumColors, settings.numColors,
		 TAG_DONE);
  BoardNewGame(boardGad, main_win,
	       settings.opponent, settings.correctionMethod);
}


VOID About(VOID) {
  MessageRequester(main_win, GetLocString(MSG_ABOUT_REQTITLE),
		   GetLocString(MSG_ABOUT_REQMSG),
		   GetLocString(MSG_CONTINUE_GAD),
		   APPNAME, VERSION, AUTHOR, EMAIL_ADDRESS,
		   COPYRIGHT_YEAR, AUTHOR);
}


VOID Quit(VOID) {
  quit = TRUE;
}


VOID ColorDisplay(BOOL checked) {
  settings.useColors = !checked;
  SetColoredMarkers(settings.useColors);
  RefreshGList(boardGad, main_win, NULL, 2);
}


VOID OpponentHuman(BOOL checked) {
  if (checked) {
    settings.opponent = OPPONENT_HUMAN;
  }
}


VOID OpponentComputer(BOOL checked) {
  if (checked) {
    settings.opponent = OPPONENT_COMPUTER;
  }
}


VOID CorrectionChildren(BOOL checked) {
  if (checked) {
    settings.correctionMethod = CORRECTION_METHOD_CHILDREN;
  }
}


VOID CorrectionAdults(BOOL checked) {
  if (checked) {
    settings.correctionMethod = CORRECTION_METHOD_ADULTS;
  }
}


VOID NumColors4(BOOL checked) {
  if (checked) {
    settings.numColors = 4;
  }
}


VOID NumColors6(BOOL checked) {
  if (checked) {
    settings.numColors = 6;
  }
}


VOID NumColors8(BOOL checked) {
  if (checked) {
    settings.numColors = 8;
  }
}


VOID SaveSettingsAction(VOID) {
  settings.winLeft = main_win->LeftEdge;
  settings.winTop = main_win->TopEdge;
  SaveSettings(BASENAME, &settings, sizeof settings);
}
