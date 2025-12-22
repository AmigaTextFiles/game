/**********************************************************************************
* amiLights.c
*
* Copyright © 1995, 1996 Douglas M. Dyer
*
* This source code is made available for everyone's mischief :)
* It demonstrates several ClassAct and SAS GUI features:
*
*	+using the window class to support iconification
*	+attaching and using a menu to the window class
*	+on-line amigaguide help (with an assist from the window class)
*	+layout tricks (the grid of buttons is not allocated on the stack,
*		you may modify NUM_ROW and NUM_COL to change the sizes)
*	+the button gadget VarArgs feature is used
*	+SAS/C WA_Arg support (arguments are transparently from the tooltypes or
*		CLI parameters)
*
* Obviously, I haven't had much time to document as I have figuring out the
* little nuances and cool features of ClassAct.  Ill try to improve this
* in the next update.
*
* Requirements to compile:
*	SAS/C 6.50 or better
*	OS2.04 or better includes and libs
*	ClassAct development kit
*
* Modifications:
* 3/10/96	+ Improved refreshing scheme
*			+ No longer uses the obsolete classact HELPKEY event
*			+ The workbench app-icon imagery matches the .info 
*			+ difficulty tooltype didn't really do anything
*			+ Modified the layout to have more attractive separator bar
*
***********************************************************************************/
#define __USE_SYSBASE

#include <stdlib.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <intuition/imageclass.h>
#include <intuition/icclass.h>
#include <utility/tagitem.h>
#include <math.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <libraries/gadtools.h>

#include <proto/amigaguide.h>
#include <clib/amigaguide_protos.h>
#include <libraries/amigaguide.h>


#include <dos.h>
#include <stdio.h>  
#include <intuition/gadgetclass.h>
#include <clib/dos_protos.h>
#include <clib/gadtools_protos.h>
#include <string.h>

/* protos */
#include <proto/listbrowser.h>
#include <proto/label.h>
#include <proto/button.h>
#include <proto/arexx.h>
#include <proto/checkbox.h>
#include <proto/chooser.h>
#include <proto/clicktab.h>
#include <proto/integer.h>
#include <proto/radiobutton.h>
#include <proto/scroller.h>
#include <proto/string.h>
#include <proto/window.h>
#include <proto/layout.h>

/* gadgets */
#include <gadgets/listbrowser.h>
#include <gadgets/button.h>
#include <gadgets/checkbox.h>
#include <gadgets/chooser.h>
#include <gadgets/clicktab.h>
#include <gadgets/integer.h>
#include <gadgets/radiobutton.h>
#include <gadgets/scroller.h>
#include <gadgets/string.h>
#include <gadgets/layout.h>


/* classes */
#include <classes/arexx.h>
#include <classes/window.h>

/* clibs */
#include <clib/classact_lib_protos.h>

#include <classact.h>
#include <classact_author.h>
#include <classact_lib.h>
#include <classact_macros.h> 

static const char *VersionString = "\0$VER:" ALVERSION " " __AMIGADATE__;

/* stack precautions */
long __stack = 10000;

/* amigaguide stuff */
#define HELP_KEY	0x5f
AMIGAGUIDECONTEXT agc = NULL;
struct NewAmigaGuide newAG = {NULL};
char guidePath[]	= "PROGDIR:amiLights.guide";
char appName[] 	= "amiLights";

VOID wait_for_close(void);

#define MAXPOINTS 25
#define NUM_ROW	5
#define NUM_COL	5

#define GRID(p,i,j)	{i=(p)/NUM_ROW; j=(p)%NUM_COL;}


typedef enum {
	G_LAYOUT = ((NUM_ROW+1)*NUM_COL) + 1,
	G_POINTS,
	G_SCORE,
	G_SMALL,
	G_BOARD,
	G_NEW,
	G_RESTART,
	G_MAX
} GadgetIDs;
static struct Gadget *GList[G_MAX];

static struct Gadget *GButtons[NUM_ROW][NUM_COL];
static struct Gadget *layoutRows[NUM_ROW];
static char grid[NUM_ROW][NUM_COL];
static char orig[MAXPOINTS];

static struct Window *win = NULL;
static struct Screen *screen = NULL;
static struct Menu *menubar = NULL;
static struct MsgPort *app_port;
static APTR vi = NULL;

struct NewMenu amiMenu[] =
{
 {NM_TITLE, "File", 		0,0,0,0,},
 {NM_ITEM, "About...",		"A",0,0,0,},
 {NM_ITEM, NM_BARLABEL, 	0,0,0,0,},
 {NM_ITEM, "Quit...",		"Q",0,0,0,},

 {NM_END, NULL, 0,0,0,0,},
};

/* menu defines */
#define FILETITLE	0
#define FILEABOUT	0
#define FILEQUIT	2

Object *appWindow, *layout, *playGrid;

ULONG lightcolor = 7;
ULONG darkcolor = 0;
ULONG difficulty = 5;

ULONG points=0, score[2]={0,0};
BOOL wonBoard = FALSE;

struct Library *AmigaGuideBase = NULL;

struct ClassLibrary *WindowBase = NULL;
struct ClassLibrary *ListBrowserBase = NULL;
struct ClassLibrary *LabelBase = NULL;
struct ClassLibrary *LayoutBase = NULL;
struct ClassLibrary *ButtonBase = NULL;
struct ClassLibrary *RadioButtonBase = NULL;
struct ClassLibrary *CheckBoxBase = NULL;
struct ClassLibrary *ChooserBase = NULL;
struct ClassLibrary *ScrollerBase = NULL;
struct ClassLibrary *IntegerBase = NULL;
struct ClassLibrary *StringBase = NULL;
struct ClassLibrary *ClickTabBase = NULL;


void main(int, char **);
void parseCmd(int, char **);
LONG easy_req(struct Window *, char *, char *, char *, ...);
BOOL libopen(void);
void libclose(void);

LONG AmiBaseHelp(void);
void AmiHelpMsg(void);
void startGame(BOOL);
void restartGame(void);
void selectLight(int, BOOL);
BOOL checkWin(void);
void applyLights(void);
void disableGrid(BOOL);
void scoreBoard(void);
void aboutLights(void);

/****************************************************
*****************************************************/
void main(int argc, char **argv)
{
 UWORD i,j;

 /* grab the screen! */
 if ( (screen = LockPubScreen(NULL)) == NULL) {
		easy_req(NULL,"Could not open destination screen", "Quit", "");
		exit(1);
 }
	

 /* lets take a look at our arguments */
 if (argc==0) {
	argc = _WBArgc;
	argv = _WBArgv;
 }
 parseCmd(argc,argv);

 if (!libopen()) {
	easy_req(NULL,"Could not open libraries", "Quit", "");
	exit(1);
 }

 /* create various necessities */
 app_port = CreateMsgPort();
 menubar = CreateMenus(amiMenu,TAG_DONE);
 vi = GetVisualInfo(screen, TAG_DONE);
 LayoutMenus(menubar, vi, 
		GTMN_NewLookMenus, TRUE,
		TAG_DONE);
  	
 /* create button layout */
 playGrid = VLayoutObject, End;
 for (i=0;i<NUM_ROW;i++) {
	layoutRows[i] = HLayoutObject, LAYOUT_Parent, playGrid, End;
	for (j=0;j<NUM_COL;j++) {
		GButtons[i][j] = ButtonObject, LAYOUT_Parent, layoutRows[i], End;
    	SetAttrs(layoutRows[i], 
				LAYOUT_AddChild, GButtons[i][j], 
				CHILD_MinWidth, 35, 
				CHILD_MinHeight, 25, 
				TAG_END);
	}

	SetAttrs((APTR)playGrid, LAYOUT_AddChild, layoutRows[i], TAG_END);
 }


 appWindow = WindowObject,
	WA_IDCMP, IDCMP_CLOSEWINDOW | IDCMP_REFRESHWINDOW | IDCMP_RAWKEY,
	WA_Flags, WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_CLOSEGADGET |
			WFLG_SIZEGADGET | WFLG_ACTIVATE ,
	WA_CustomScreen, screen,
    WA_DepthGadget, TRUE,
    WA_DragBar, TRUE,
    WA_CloseGadget, TRUE,
    WA_Activate, TRUE,
    WA_SizeGadget, TRUE,

	WA_Title, appName,

	WINDOW_IconTitle, appName,
	WINDOW_IconifyGadget, TRUE,
	WINDOW_Icon, GetDiskObject("PROGDIR:amiLights"),
	WINDOW_AppPort, app_port,
	WINDOW_MenuStrip, menubar,

	WINDOW_ParentGroup, GList[G_LAYOUT] = VGroupObject,
		LAYOUT_SpaceOuter, FALSE,
		LAYOUT_DeferLayout, TRUE,
		VCentered, HCentered,

	
		StartVGroup,

			StartVGroup,
				LAYOUT_SpaceOuter, TRUE,
					StartMember, playGrid,
					EndMember,
			EndVGroup,

			
			StartVGroup, VCentered, HCentered,
				LAYOUT_SpaceOuter, TRUE,
				LAYOUT_BevelStyle, VBarFrame,
			EndVGroup,
			CHILD_WeightedHeight,0,

			StartVGroup, 
				LAYOUT_SpaceOuter, TRUE,

				StartVGroup,
					LAYOUT_EvenSize, TRUE,

					StartMember, GList[G_BOARD]= LayoutObject,
						StartMember, GList[G_POINTS] = ButtonObject,
							GA_ReadOnly, TRUE,
							GA_Text, "%ld",
							BUTTON_VarArgs, &points,
						EndMember,
						CHILD_Label, LabelObject, LABEL_Text, "Points", LabelEnd,
					
						StartMember, GList[G_SCORE] = ButtonObject,
							GA_ReadOnly, TRUE,
							GA_Text, "%ld/%ld",
							BUTTON_VarArgs, &score,
						EndMember,
						CHILD_Label, LabelObject, LABEL_Text, "Score", LabelEnd,

					EndHGroup,
					CHILD_WeightedHeight, 0,

					StartMember, GList[G_SMALL] = LayoutObject, 
						StartMember, GList[G_NEW] = ButtonObject,
							GA_Text, "New Game",
						EndMember,

						StartMember, GList[G_RESTART] = ButtonObject,
							GA_Text, "Restart Game",
							GA_Disabled, TRUE,
						EndMember,
					EndHGroup,
					CHILD_WeightedHeight,0,

				EndVGroup,

			EndMember,
			CHILD_WeightedHeight,0,

		EndVGroup,

	EndWindow;

 if (appWindow == NULL)
	goto CLEANUP;


 /* initialize gadgets by asking for notification for each one */
 for (i=1;i<G_MAX;i++)
    SetAttrs(GList[i], GA_ID, i, GA_RelVerify, TRUE, TAG_END);

 for (i=0;i<NUM_ROW;i++)
	for (j=0;j<NUM_COL;j++)
		SetAttrs(GButtons[i][j], GA_ID, (i*NUM_COL) + j, GA_RelVerify, TRUE, TAG_END);


 if ( (win = CA_OpenWindow(appWindow)) == NULL)
	goto CLEANUP;

 disableGrid(TRUE);

 if (AmigaGuideBase != NULL) {
	AmiBaseHelp();
 }

 wait_for_close();

 CLEANUP:
	if (AmigaGuideBase && agc) CloseAmigaGuide(agc);
	if (vi) FreeVisualInfo(vi);
	if (appWindow) DisposeObject(appWindow);
	if (screen)	UnlockPubScreen(0,screen);
	libclose();
}


/*********************************************************************
**********************************************************************/
VOID wait_for_close(void)
{
 ULONG result, signal,wsig;
 UWORD code;
 BOOL done = FALSE;
 struct MenuItem *menu;
 UWORD menunum, title, item, sub;

 GetAttr(WINDOW_SigMask, appWindow, &wsig);

 while (!done) {
	signal = Wait( wsig | (1L << app_port->mp_SigBit) |
			(AmigaGuideBase && AmigaGuideSignal(agc)));

	if (signal & (AmigaGuideBase && AmigaGuideSignal(agc)) ) {
		AmiHelpMsg();
		continue;
	}

	/* react to signals on window */
	while ((result = CA_HandleInput (appWindow, &code)) != WMHI_LASTMSG) {
    	switch (result & WMHI_CLASSMASK) {

			case WMHI_ICONIFY:
				if (CA_Iconify(appWindow))
					win = NULL;
				break;

			case WMHI_UNICONIFY:
				win = CA_OpenWindow(appWindow);
				break;

         	case WMHI_GADGETUP:	
        		switch (result & WMHI_GADGETMASK) {
					case G_NEW:
						startGame(TRUE);
						break;

					case G_RESTART:
						startGame(FALSE);
						break;

					default:
						selectLight(result&WMHI_GADGETMASK, TRUE);
						if (points > 0) points--;

						scoreBoard();

						if (checkWin()) {
							wonBoard = TRUE;
							easy_req(NULL,"You WON!","OK","");
							disableGrid(TRUE);
						}
						break;
            		}
        		break;

			case WMHI_MENUPICK:
				menunum = result&WMHI_MENUMASK;
				while (menunum != MENUNULL) {
					menu = ItemAddress( menubar, menunum);
					title = MENUNUM(menunum);
					item = ITEMNUM(menunum);
					sub = SUBNUM(menunum);

					/* which items were selected? */
					switch (title) {
						case FILETITLE:
							switch (item) {
								case FILEABOUT:
									aboutLights();
									break;
								case FILEQUIT:
									done = TRUE;
									break;
							}
					}

					menunum = menu->NextSelect;
				}
				break;

			case WMHI_RAWKEY:
				switch (result & 0x0ff) {
					case HELP_KEY:
						if (AmigaGuideBase != NULL && agc != NULL)
							SendAmigaGuideCmd(agc,"LINK MAIN",NULL);
						break;
				break;

				}
				break;

			case WMHI_CLOSEWINDOW:
 				done = TRUE;
    			break;
	    	}
		} /* end collection of messages */
	
 } /* while not done */
}

/***************************************************************************************
****************************************************************************************/
BOOL libopen(void)
{
 if ((WindowBase = (struct ClassLibrary*)OpenLibrary("window.class",0L)) == NULL)
	return (FALSE);

 if ((LayoutBase = (struct ClassLibrary*)OpenLibrary("gadgets/layout.gadget",0L)) == NULL)
	return (FALSE);

 if ((ButtonBase = (struct ClassLibrary*)OpenLibrary("gadgets/button.gadget",0L)) == NULL)
	return (FALSE);

 if ((LabelBase = (struct ClassLibrary*)OpenLibrary("images/label.image",0L)) == NULL)
	return (FALSE);

 AmigaGuideBase = (struct Library *)OpenLibrary("amigaguide.library",0L);

 return TRUE;
}

/*************************************************************************
**************************************************************************/
void libclose(void)
{
  if (LayoutBase != NULL) CloseLibrary((struct Library *)LayoutBase);
  if (WindowBase != NULL) CloseLibrary((struct Library *)WindowBase);
  if (LabelBase != NULL) CloseLibrary((struct Library *)LabelBase);
  if (CheckBoxBase != NULL) CloseLibrary((struct Library *)CheckBoxBase);
  if (IntegerBase != NULL) CloseLibrary((struct Library *)IntegerBase);
  if (StringBase != NULL) CloseLibrary((struct Library *)StringBase);
  if (ClickTabBase != NULL) CloseLibrary((struct Library *)ClickTabBase);
  if (ChooserBase != NULL) CloseLibrary((struct Library *)ChooserBase);
  if (ButtonBase != NULL) CloseLibrary((struct Library *)ButtonBase);
  if (ListBrowserBase != NULL) CloseLibrary((struct Library *)ListBrowserBase);
  if (RadioButtonBase != NULL) CloseLibrary((struct Library *)RadioButtonBase);
  if (AmigaGuideBase != NULL) CloseLibrary((struct Library *)AmigaGuideBase);
}

/******************************************************************
*******************************************************************/
void parseCmd(int argc, char **argv)
{
 char *ptr;

 while (argc > 1) {
	if (strnicmp(argv[argc-1], "LIGHTCOLOR",strlen("LIGHTCOLOR")) == 0) {
		ptr = strchr(argv[argc-1],'=');
		if (ptr != NULL) {
			sscanf(ptr+1,"%d",&lightcolor);
		}
	}
	else if (strnicmp(argv[argc-1],"DARKCOLOR",strlen("DARKCOLOR")) == 0) {
		ptr = strchr(argv[argc-1],'=');
		if (ptr != NULL) {
			sscanf(ptr+1,"%d",&darkcolor);
		}
	}
	else if (strnicmp(argv[argc-1],"DIFFICULTY",strlen("DIFFICULTY")) == 0) {
		ptr = strchr(argv[argc-1],'=');
		if (ptr != NULL) {
			sscanf(ptr+1,"%d",&difficulty);
			if (difficulty > MAXPOINTS) difficulty = MAXPOINTS;
		}
	}

	argc--;
 }
}

/******************************************************************
*******************************************************************/
void startGame(BOOL new)
{
 int i,j;
 
 if (new) {
	SetAttrs(GList[G_RESTART], win, NULL,
		GA_Disabled, FALSE,	
		TAG_END);
	RefreshGList(GList[G_SMALL], win, NULL, 1);

	if (wonBoard) {
		score[0] += points;
		wonBoard = FALSE;
	}

	score[1] ++;
 }

 points = difficulty+1;
 scoreBoard();

 /* first, clear grid */
 for (i=0;i<NUM_ROW;i++)
 	for (j=0;j<NUM_COL;j++) {
		grid[i][j] = 0;
	}

 /* second, randomly select x number of points */
 for (i=0;i<difficulty;i++) {
	if (new)	orig[i] = lrand48() % (NUM_ROW*NUM_COL);
	selectLight(orig[i], FALSE);
 }

 /* now fill the buttons properly */
 disableGrid(FALSE);
 applyLights();
}

/******************************************************************
*******************************************************************/
BOOL checkWin(void)
{
 int i,j;

 for (i=0;i<NUM_ROW;i++)
	for (j=0;j<NUM_COL;j++) {
		if (grid[i][j]) return FALSE;
	}

 return TRUE;
}

/******************************************************************
*******************************************************************/
void selectLight(int light, BOOL update)
{
 int i,j;

 GRID(light,i,j);
 
 /* now we toggle this point, above/below, left/right */
 grid[i][j] = ~grid[i][j];
 if (i>0) 			grid[i-1][j] = ~grid[i-1][j];
 if (i<NUM_ROW-1)	grid[i+1][j] = ~grid[i+1][j];
 if (j>0)			grid[i][j-1] = ~grid[i][j-1];
 if (j<NUM_COL-1)	grid[i][j+1] = ~grid[i][j+1]; 

 if (update) {
	SetAttrs(GButtons[i][j],
		BUTTON_BackgroundPen, (grid[i][j])?lightcolor:darkcolor, 
		TAG_END);
	RefreshGList(GButtons[i][j],win,NULL,1);

	if (i>0) 		{	SetAttrs(GButtons[i-1][j],
							BUTTON_BackgroundPen, (grid[i-1][j])?lightcolor:darkcolor, 
							TAG_END);
						RefreshGList(GButtons[i-1][j],win, NULL,1);
	}
					
 	if (i<NUM_ROW-1) {	SetAttrs(GButtons[i+1][j], 
							BUTTON_BackgroundPen, (grid[i+1][j])?lightcolor:darkcolor, 
							TAG_END);
						RefreshGList(GButtons[i+1][j],win, NULL,1);
	}

 	if (j>0)		{	SetAttrs(GButtons[i][j-1], 
							BUTTON_BackgroundPen, (grid[i][j-1])?lightcolor:darkcolor, 
							TAG_END);	
						RefreshGList(GButtons[i][j-1],win, NULL,1);
	}

 	if (j<NUM_COL-1) {	SetAttrs(GButtons[i][j+1],
							BUTTON_BackgroundPen, (grid[i][j+1])?lightcolor:darkcolor, 
							TAG_END);	
						RefreshGList(GButtons[i][j+1],win, NULL,1);
	}
 }
}

/******************************************************************
*******************************************************************/
void applyLights(void)
{
 int i,j;

 for (i=0;i<NUM_ROW;i++)
	for (j=0;j<NUM_COL;j++) {
		SetAttrs(GButtons[i][j],
			BUTTON_BackgroundPen, (grid[i][j])?lightcolor:darkcolor,	
			TAG_END);
		RefreshGList(GButtons[i][j], win, NULL, 1);
	}
}

/*******************************************************************************
*******************************************************************************/
LONG easy_req(struct Window *win, char *reqtext, char *reqgads, char *reqargs,
...)
{
	struct EasyStruct general_es =
	{
		sizeof(struct EasyStruct),
		0,
		"amiLights Notice:",
		NULL,
		NULL
	};

	general_es.es_TextFormat = reqtext;
	general_es.es_GadgetFormat = reqgads;

	return(EasyRequestArgs(win, &general_es, NULL, &reqargs));
}

/*****************************************************************
*****************************************************************/
void disableGrid(BOOL disable)
{
 int i,j;

 for (i=0;i<NUM_ROW;i++)
	for (j=0;j<NUM_COL;j++) {
		SetAttrs(GButtons[i][j], win, NULL,
			GA_Disabled, disable,	
			TAG_END);
		RefreshGList(GButtons[i][j], win, NULL, 1);
	}

}

/******************************************************************
*******************************************************************/
void scoreBoard(void)
{
 /* refresh the scores */

 SetAttrs(GList[G_POINTS],
	BUTTON_VarArgs, &points,
	TAG_END);
 RefreshGList(GList[G_POINTS],win,NULL,1);

 SetAttrs(GList[G_SCORE],
	BUTTON_VarArgs, &score,
	TAG_END);
 RefreshGList(GList[G_SCORE], win, NULL,1);
}

/**************************************************
***************************************************/
LONG AmiBaseHelp(void)
{
 LONG retval = 0L;

  /* Fill in the NewAmigaGuide structure */
  memset(&newAG,0,sizeof(struct NewAmigaGuide));
  newAG.nag_Name = guidePath;
  newAG.nag_Screen = win->WScreen;
  
  /* Open the AmigaGuide client */
  if ( !(agc = OpenAmigaGuideAsync(&newAG,NULL))) {
	/* Get the reason for failure */
  	retval = IoErr();
  }

  return (retval);
}


/*********************************************************
**********************************************************/
void AmiHelpMsg(void)
{
 struct AmigaGuideMsg *agm;

 while ( agm = GetAmigaGuideMsg(agc)) {
		ReplyAmigaGuideMsg(agm);
 }

}

/********************************************************
*********************************************************/
void aboutLights(void) 
{
 char msg[200];
 sprintf(msg,"%s\nCopyright © 1995, 1996 Douglas M. Dyer\n\n%s %s",appName,ALVERSION, __AMIGADATE__);
 easy_req(NULL,msg,"OK","");
}
