//=========================================================================
//=========================================================================
//
//	Daleks - main file
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#include	"Daleks.h"
#include	"Arena.h"
#include	"Timer.h"

// Menu details - will be localised before use!
static struct NewMenu MenuData[] =
{
	{ NM_TITLE, (APTR)MSG_PROJECT , NULL , 0, NULL, NULL              },
	{  NM_ITEM, (APTR)MSG_ABOUT   , " "  , 0, NULL, (APTR)MEN_ABOUT   },
	{  NM_ITEM, (APTR)MSG_ABOUTMUI, "?"  , 0, NULL, (APTR)MEN_ABOUTMUI},
	{  NM_ITEM, NM_BARLABEL       , NULL , 0, NULL, NULL              },
	{  NM_ITEM, (APTR)MSG_QUIT    , " "  , 0, NULL, (APTR)MEN_QUIT    },

	{ NM_TITLE, (APTR)MSG_PREFS   , NULL , 0, NULL, NULL              },
	{  NM_ITEM, "Daleks..."       , NULL , 0, NULL, (APTR)BT_PREFS    },
	{  NM_ITEM, "MUI..."          , NULL , 0, NULL, (APTR)MEN_MUIPREFS},

	{ NM_END,   NULL              , NULL , 0, NULL, NULL              }
};

//=========================================================================
// STRPTR getStr(ULONG)
//
// Return localised application string
//=========================================================================
STRPTR getStr(
				ULONG a_id
			 )
{
	if (LocaleBase && Locale && Catalog)
	{
		return(GetCatalogStr(Catalog, a_id, AppStr[a_id]));		
	}

	return(AppStr[a_id]);
}

//=========================================================================
// void exitProg(APTR, STRPTR, BOOL)
//
// Clean up and exit.
//
// Parameters:
//      errString   String to display in an EasyRequest. If this is
//                  NULL then nothing is displayed
//=========================================================================
void exitProg(
				STRPTR	errString
			 )
{
	static BOOL aborting = FALSE;

    struct EasyStruct ErrorDisplay =
	{
		sizeof(struct EasyStruct),
		0,
		NULL,
		"%s",
		NULL
	};

	if (!aborting)
	{
		aborting = TRUE;

	    // Close the window nicely
	    if (WI_Main)
		{
	        SetAttrs(WI_Main, MUIA_Window_Open, FALSE, TAG_DONE);
	    }

		// Free the game graphics
		unloadGFX();

	    // Show the error
	    if (errString)
		{
			ErrorDisplay.es_Title        = getStr(MSG_ERRORREQTITLE);
			ErrorDisplay.es_GadgetFormat = getStr(MSG_ERRORREQBUTTON);
			EasyRequest(NULL, &ErrorDisplay, 0, errString);
	    }

	    // Remove the application
	    if (MUI_App) MUI_DisposeObject(MUI_App);

		// Remove custom classes
	    if (DaleksArena_Class) MUI_DeleteCustomClass(DaleksArena_Class);
	    if (DaleksTimer_Class) MUI_DeleteCustomClass(DaleksTimer_Class);

		// Free signal
		if (SigNum != -1) FreeSignal(SigNum);

		// Close locale
		if (Catalog)
		{
			CloseCatalog(Catalog);
		}
		if (Locale)
		{
			CloseLocale(Locale);
		}

	    // Close libraries
	    if (DataTypesBase) CloseLibrary(DataTypesBase);
	    if (GfxBase)       CloseLibrary(GfxBase);
	    if (IntuitionBase) CloseLibrary(IntuitionBase);
	    if (LocaleBase)    CloseLibrary(LocaleBase);
	    if (MUIMasterBase) CloseLibrary(MUIMasterBase);
	    if (UtilityBase)   CloseLibrary(UtilityBase);
	}

    exit(errString ? 5 : 0);
}

//=========================================================================
// void initProg(void)
//
// Setup and initialise stuff.
//=========================================================================
static void initProg(
						void
					)
{
	struct NewMenu *nm;
	ULONG			id;

	//=====================================================================
	// Open libraries
	//=====================================================================
    if (!(DataTypesBase = OpenLibrary("datatypes.library", 39)))
		{ exitProg("Unable to open datatypes.library V39+"); }

    if (!(GfxBase = OpenLibrary("graphics.library", 37)))
		{ exitProg("Unable to open graphics.library V37+"); }

    if (!(IntuitionBase = OpenLibrary("intuition.library", 39)))
		{ exitProg("Unable to open intuition.library V39+"); }

    if (!(LocaleBase = OpenLibrary("locale.library", 37)))
		{ exitProg("Unable to open locale.library V37+"); }

    if (!(MUIMasterBase = OpenLibrary(MUIMASTER_NAME, MUIMASTER_VMIN)))
		{ exitProg("Unable to open " MUIMASTER_NAME "."); }

    if (!(UtilityBase = OpenLibrary("utility.library", 37)))
		{ exitProg("Unable to open utility.library V37+"); }

	//=====================================================================
	// Allocate signal bit
	//=====================================================================
    if ((SigNum = AllocSignal(-1L)) == -1)
	{
        exitProg("Unable to open allocate signal");
    }
	
	//=====================================================================
	// Create custom classes
	//=====================================================================
    if (!(DaleksArena_Class = MUI_CreateCustomClass(NULL, MUIC_Area, NULL, sizeof(struct DaleksArena_Data), DaleksArena_dispatcher)))
	{
        exitProg("Unable to create custom class (1)");
    }

    if (!(DaleksTimer_Class = MUI_CreateCustomClass(NULL, MUIC_Area, NULL, sizeof(struct DaleksTimer_Data), DaleksTimer_dispatcher)))
	{
        exitProg("Unable to create custom class (2)");
    }

	//=====================================================================
	// Open locale and catalog, don't care if these fail.
	//=====================================================================
	Locale  = OpenLocale(NULL);
	Catalog = OpenCatalog(Locale, "Daleks98", NULL);
	
	//=====================================================================
	// Localise our menu structure
	//=====================================================================
	nm = MenuData;
	while (nm->nm_Type != NM_END)
	{
		if (nm->nm_Label != NM_BARLABEL
			&& (nm->nm_Type == NM_ITEM || nm->nm_Type == NM_TITLE)
			&& ((id = (ULONG)(nm->nm_Label)) < MSG_lastmsg))
		{
			nm->nm_Label = getStr(id);
			if (nm->nm_CommKey != NULL && *(nm->nm_CommKey) == ' ')
			{
				*(nm->nm_CommKey) = *(nm->nm_Label);
			}
		}
		nm++;
	}
	
	//=====================================================================
	// Localise misc things.
	//=====================================================================
	Copyright1 = getStr(MSG_COPYRIGHT1);
	Copyright2 = getStr(MSG_COPYRIGHT2);
}

//=========================================================================
// void setGadgets()
//	
// Set interface state
//=========================================================================
static void setGadgets(
						void
					  )
{
	BOOL	tmpflg;
	char	tmpstr[40];
	
	//=====================================================================
	// Enable/disable top buttons
	//=====================================================================
	if (StateInfo.gs_state == GS_INITIALISING)
	{
		SetAttrs(BT_NewGame, MUIA_Disabled, TRUE, TAG_DONE);
		SetAttrs(BT_Quit   , MUIA_Disabled, TRUE, TAG_DONE);
		SetAttrs(BT_Prefs  , MUIA_Disabled, TRUE, TAG_DONE);
	}
	else
	{
		SetAttrs(BT_NewGame, MUIA_Disabled, StateInfo.gs_state != GS_ATTRACTMODE, TAG_DONE);
		SetAttrs(BT_Prefs  , MUIA_Disabled, StateInfo.gs_state != GS_ATTRACTMODE, TAG_DONE);
		SetAttrs(BT_Quit   , MUIA_Disabled, FALSE, TAG_DONE);
	}

	//=====================================================================
	// Set Score/Hiscore contents
	//=====================================================================
	if (StateInfo.gs_state == GS_INITIALISING)
	{
		strcpy(tmpstr, MUIX_B);
		strcat(tmpstr, getStr(MSG_SCORE));
		SetAttrs(TX_Score  , MUIA_Text_Contents, tmpstr, TAG_DONE);

		strcpy(tmpstr, MUIX_B);
		strcat(tmpstr, getStr(MSG_HISCORE));
		SetAttrs(TX_HiScore, MUIA_Text_Contents, tmpstr, TAG_DONE);
	}
	else
	{
		sprintf(tmpstr, MUIX_B "%s: " MUIX_N "%4d", getStr(MSG_SCORE), StateInfo.gs_score);
		SetAttrs(TX_Score  , MUIA_Text_Contents, tmpstr, TAG_DONE);

		sprintf(tmpstr, MUIX_B "%s: " MUIX_N "%4d by %s", getStr(MSG_HISCORE), 9999, "XXXXXXXX");
		SetAttrs(TX_HiScore, MUIA_Text_Contents, tmpstr, TAG_DONE);
	}
	
	//=====================================================================
	// Enable/disable bottom buttons
	//=====================================================================
	tmpflg = (StateInfo.gs_state == GS_INGAME) ? FALSE : TRUE;
	SetAttrs(BT_Tele , MUIA_Disabled, tmpflg, TAG_DONE);
	SetAttrs(BT_Screw, MUIA_Disabled, tmpflg, TAG_DONE);
	SetAttrs(BT_Last , MUIA_Disabled, tmpflg, TAG_DONE);
}


//=========================================================================
// setGameState(state)
//
// Set game state
//=========================================================================
void setGameState(
					ULONG a_newstate
			 	 )
{
	StateInfo.gs_state = a_newstate;
	setGadgets();
}


//=========================================================================
// layoutArena(struct Hook *, Object *, struct MUI_LayoutMsg *)
//
// Custom layout hook for GP_Arena group.
//=========================================================================
static __saveds __asm
ULONG layoutArena(
					register __a0 struct Hook			*hk,
					register __a2 Object				*obj,
					register __a1 struct MUI_LayoutMsg	*lm
				 )
{
	ULONG	w, h;

	switch (lm->lm_Type)
	{
		case MUILM_MINMAX:
		{
			//=============================================================
			// MinMax calculation - set group to size of BA_Arena object
			//=============================================================
			w = _minwidth(BA_Arena);
			h = _minheight(BA_Arena);

			lm->lm_MinMax.MinWidth  = w;
			lm->lm_MinMax.MinHeight = h;
			lm->lm_MinMax.DefWidth  = w;
			lm->lm_MinMax.DefHeight = h;
			lm->lm_MinMax.MaxWidth  = w;
			lm->lm_MinMax.MaxHeight = h;

			return(0);
		}

		case MUILM_LAYOUT:
		{
			//=============================================================
			// Place arena object at 0,0
			//=============================================================
			MUI_Layout(BA_Arena, 0, 0, (LONG)(_minwidth(BA_Arena)), (LONG)(_minheight(BA_Arena)), 0);

			//=============================================================
			// Place textbox group in center of arena object
			//=============================================================
			w = _minwidth(GP_Mbox);
			h = _minheight(GP_Mbox);
			MUI_Layout(GP_Mbox,
						(lm->lm_Layout.Width-w)/2,
						(lm->lm_Layout.Height-h)/3,
						w, h, 0);

			return(TRUE);
		}
	}
	return(MUILM_UNKNOWN);
}

//=========================================================================
// void newGame(void)
//
// Initialise for a new game
//=========================================================================
void newGame(
				void
			)
{
	StateInfo.gs_level = 1;
	StateInfo.gs_score = 0;
}


//=========================================================================
// void newLevel(void)
//
// Initialise for a new level
//=========================================================================
void newLevel(
				void
			 )
{
	StateInfo.gs_ndal  = 2;
	StateInfo.gs_count = 0;
}

//=========================================================================
// void createInterface(void)
//
// Sets up the interface.
//=========================================================================
static void createInterface(
							void
						   )
{
	static struct Hook	layouthook = { {0,0}, layoutArena, NULL, NULL };
	char				tmpstr[256];

	//=====================================================================
	// Create objects for the splash window
	//=====================================================================
	WI_Splash = WindowObject,
					MUIA_Window_ID         , MAKE_ID('S','P','L','S'),
					MUIA_Window_Title      , NULL,
					MUIA_Window_ScreenTitle, AppTitle,
					MUIA_Window_NoMenus    , TRUE,
					MUIA_Window_Borderless , TRUE,
					MUIA_Window_DragBar    , FALSE,
					MUIA_Window_CloseGadget, FALSE,
					MUIA_Window_DepthGadget, FALSE,
					MUIA_Window_SizeGadget , FALSE,
					MUIA_Window_Open       , FALSE,
					WindowContents, HGroup,
						GroupFrame,
						MUIA_Group_SameHeight, TRUE,
						Child, SimpleButton("[DALEK PICTURE]"),
						Child, VGroup,
							TextFrame,
							MUIA_Group_SameWidth, TRUE,
							MUIA_Background     , MUII_TextBack,
							Child, VSpace(10),
							Child, TX_Splash1 = TextObject,
									NoFrame,
									MUIA_Font, MUIV_Font_Big,
									End,
							Child, TX_Splash2 = TextObject,
									NoFrame,
									End,
						End,
					End,
				End;

	sprintf(tmpstr, MUIX_B MUIX_C "%s", AppTitle);
	SetAttrs(TX_Splash1, MUIA_Text_Contents, tmpstr, TAG_DONE);

	sprintf(tmpstr, MUIX_N MUIX_C "\n%s\n\n%s\n%s\n\n\n", 
						getStr(MSG_WRITTENBY),
						getStr(MSG_COPYRIGHT1),
						getStr(MSG_COPYRIGHT2));
	SetAttrs(TX_Splash2, MUIA_Text_Contents, tmpstr, TAG_DONE);

	//=====================================================================
	// Create buttons for main window
	//=====================================================================
	MN_Menus   = MUI_MakeObject(MUIO_MenustripNM, MenuData, 0);
	BT_NewGame = SimpleButton(getStr(MSG_BTNEWGAME));
	BT_Quit    = SimpleButton(getStr(MSG_BTQUIT));
	BT_Prefs   = SimpleButton(getStr(MSG_BTPREFS));
	BT_Tele    = SimpleButton(getStr(MSG_BTTELEPORT));
	BT_Screw   = SimpleButton(getStr(MSG_BTSCREW));
	BT_Last    = SimpleButton(getStr(MSG_BTLAST));
	TX_Score   = TextObject, NoFrame, End;
	TX_HiScore = TextObject, NoFrame, End;
	
	//=====================================================================
	// Create special group object for the playing arena.
	//=====================================================================
	GP_Arena   = HGroup,
					GroupFrame,
					InnerSpacing(0,0),
					MUIA_Group_LayoutHook, &layouthook,
					Child, BA_Arena = NewObject(DaleksArena_Class->mcc_Class, NULL,
							NoFrame,
							MUIA_Background, MUII_BACKGROUND,
							TAG_DONE),
					Child, GP_Mbox = VGroup,
							TextFrame,
							GroupSpacing(0),
							InnerSpacing(0,0),
							MUIA_Background     , MUII_TextBack,
							MUIA_ShowMe         , FALSE,
							MUIA_Group_SameWidth, TRUE,
							Child, VSpace(10),
							Child, TX_Mbox1 = TextObject,
									NoFrame,
									MUIA_Font, MUIV_Font_Big,
									End,
							Child, TX_Mbox2 = TextObject,
									NoFrame,
									MUIA_Font        , MUIV_Font_Fixed,
									MUIA_FixWidthTxt , "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
									MUIA_FixHeightTxt, "\n\n\n\n\n\n\n\n\n\n",
									End,
						 	End,
				 End;

	//=====================================================================
	// Create the application object!
	//=====================================================================
    MUI_App = ApplicationObject,
                MUIA_Application_Title      , AppTitle,
                MUIA_Application_Version    , Version,
                MUIA_Application_Copyright  , Copyright1,
                MUIA_Application_Author     , "John Girvin",
                MUIA_Application_Base       , BaseName,
                MUIA_Application_SingleTask , TRUE,

				SubWindow, WI_Splash,
				SubWindow, WI_Main = WindowObject,
					MUIA_Window_ID         , MAKE_ID('M','A','I','N'),
					MUIA_Window_Title      , AppTitle,
					MUIA_Window_ScreenTitle, AppTitle,
					MUIA_Window_Menustrip  , MN_Menus,
					MUIA_Window_Open       , FALSE,
					WindowContents, VGroup,
						Child, NewObject(DaleksTimer_Class->mcc_Class, NULL, TAG_DONE),
						Child, HGroup,
							ButtonFrame,
							MUIA_Background     , MUII_TextBack,
							MUIA_Group_SameWidth, TRUE,
							Child, BT_NewGame,
							Child, BT_Quit,
							Child, BT_Prefs,
							End,
						Child, HGroup,
							ButtonFrame,
							MUIA_Background     , MUII_TextBack,
							MUIA_Group_SameWidth, TRUE,
							Child, TX_Score,
							Child, TX_HiScore,
							End,
						Child, GP_Arena,
						Child, HGroup,
							ButtonFrame,
							MUIA_Background     , MUII_TextBack,
							MUIA_Group_SameWidth, TRUE,
							Child, BT_Tele,
							Child, BT_Screw,
							Child, BT_Last,
							End,
						End,
					End,
				End;

	if (MUI_App)
	{
		DoMethod(BT_NewGame, MUIM_Notify, MUIA_Pressed, FALSE, MUI_App, 2, MUIM_Application_ReturnID, BT_NEWGAME);
		DoMethod(BT_Quit   , MUIM_Notify, MUIA_Pressed, FALSE, MUI_App, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);
		DoMethod(BT_Prefs  , MUIM_Notify, MUIA_Pressed, FALSE, MUI_App, 2, MUIM_Application_ReturnID, BT_PREFS);
		DoMethod(BT_Tele   , MUIM_Notify, MUIA_Pressed, FALSE, MUI_App, 2, MUIM_Application_ReturnID, BT_TELE);
		DoMethod(BT_Screw  , MUIM_Notify, MUIA_Pressed, FALSE, MUI_App, 2, MUIM_Application_ReturnID, BT_SCREW);
		DoMethod(BT_Last   , MUIM_Notify, MUIA_Pressed, FALSE, MUI_App, 2, MUIM_Application_ReturnID, BT_LAST);

		DoMethod(WI_Main, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, MUI_App, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

		setGadgets();
	}
}

//=========================================================================
//=========================================================================
// Main routine
//=========================================================================
//=========================================================================
int main(
			int		argc,
			char	**argv
		)
{
    BOOL   Quit	= FALSE;
    BOOL   Done, GameOver;
    ULONG  Sig	= 0;
	ULONG  tick;

	if (argc == 0)
	{
		argc = _WBArgc;
		argv = _WBArgv;
	}

	srand(time(0));

    // Initialise the program
    initProg();

	// Create the interface
    createInterface();
    if(!MUI_App)
	{
        exitProg("Unable to create application");
    }

	// Open the main window
	SetAttrs(WI_Splash, MUIA_Window_Open, TRUE , TAG_DONE);
	SetAttrs(WI_Main  , MUIA_Window_Open, FALSE, TAG_DONE);

	// Get reference to our screen and font
	GetAttr(MUIA_Window_Screen, WI_Splash, (ULONG *)&Screen);
	if (!Screen)
	{
		exitProg("Unable to get screen pointer");
	}
	GameGfxSize = Screen->Font->ta_YSize;	

	// Load gfx & scale them to size of screen font
	if (!loadGFX(GameGfxSize, GameGfxSize))
	{
        exitProg("Unable to load graphics");
	}

	// Open the main window
	SetAttrs(WI_Splash, MUIA_Window_Open, FALSE, TAG_DONE);
	SetAttrs(WI_Main  , MUIA_Window_Open, TRUE , TAG_DONE);

	//=====================================================================
	// ATTRACTMODE LOOP
	//=====================================================================
	setGameState(GS_ATTRACTMODE);
	Done = FALSE;
	tick = 0;
	mboxAttractMode(0);
    while (!Quit && !Done)
	{
        switch (DoMethod(MUI_App, MUIM_Application_NewInput, &Sig))
		{
			// Window close gadget or Quit button
            case MUIV_Application_ReturnID_Quit:
            case MEN_QUIT:
				Quit = TRUE;
				break;

			// "About MUI..." menu option
            case MEN_ABOUTMUI:
				DoMethod(MUI_App, MUIM_Application_AboutMUI, WI_Main);
				break;

			// "New Game" - start the battle!
			case BT_NEWGAME:
				Done = TRUE;
				break;

			// Cycle attractmode text
			case MUIV_DaleksTimer_Tick:
				tick = (tick+1) & 0xff;
				mboxAttractMode(tick);
				break;
        }

		if (Sig)
		{
			Sig = Wait(Sig | SIGBREAKF_CTRL_C);
			if (Sig & SIGBREAKF_CTRL_C)
			{
				Quit = TRUE;
			}
		}
    }

	if (Quit)
	{
		goto QuitDaleks;
	}
	
	// Initialise things for a new game
	newGame();

	//=====================================================================
	// OUTER GAME LOOP
	//=====================================================================
	GameOver = FALSE;
	while (!Quit && !GameOver)
	{
		// Initialise for new level
		newLevel();

		//=====================================================================
		// LEVELINTRO LOOP
		//=====================================================================
		setGameState(GS_LEVELINTRO);
		mboxLevelIntro();
		Done = FALSE;
		tick = 0;
	    while (!Quit && !Done)
		{
	        switch (DoMethod(MUI_App, MUIM_Application_NewInput, &Sig))
			{
				// Window close gadget or Quit button
	            case MUIV_Application_ReturnID_Quit:
	            case MEN_QUIT:
					Quit = TRUE;
					break;

				// Delay to display level intro text
				case MUIV_DaleksTimer_Tick:
					tick++;
					if (tick > 3)
					{
						Done = TRUE;
					}
					break;
	        }

			if (Sig)
			{
				Sig = Wait(Sig | SIGBREAKF_CTRL_C);
				if (Sig & SIGBREAKF_CTRL_C)
				{
					Quit = TRUE;
				}
			}
	    }
		SetAttrs(GP_Mbox, MUIA_ShowMe, FALSE, TAG_DONE);

		if (Quit)
		{
			goto QuitDaleks;
		}

		
		//=================================================================
		// ONE-LEVEL LOOP
		//=================================================================
		setGameState(GS_INGAME);
		printf("ingame!\n");
		Quit = TRUE;
	}
	
	//=====================================================================
	// Clean up and exit
	//=====================================================================
QuitDaleks:
    exitProg(NULL);
}
