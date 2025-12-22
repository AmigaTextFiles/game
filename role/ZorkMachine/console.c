#include <intuition/intuitionbase.h>
#include <libraries/translator.h>
#include <workbench/workbench.h>
#include <libraries/gadtools.h>
#include <workbench/startup.h>
#include <graphics/gfxbase.h>
#include <devices/narrator.h>
#include <devices/conunit.h>
#include <libraries/asl.h>
#include <dos/dostags.h>
#include <exec/memory.h>

#include <clib/intuition_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/exec_protos.h>
#include <clib/icon_protos.h>
#include <clib/dos_protos.h>
#include <clib/asl_protos.h>
#include <clib/wb_protos.h>

#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "Zorkmachine.h"

enum	{	MEN_DUMMY,
		MEN_SAVE, MEN_SAVEAS, MEN_RESTORE, MEN_SCRIPT, MEN_PALETTE, MEN_ABOUT, MEN_QUIT,
		MEN_LOOK, MEN_WAIT, MEN_INVENTORY, MEN_DIAGNOSE,
		MEN_RESTART, MEN_VERBOSE, MEN_BRIEF, MEN_SUPERBRIEF, MEN_SCORE, MEN_TIME, MEN_SPEECH,
		MEN_NORTH, MEN_EAST, MEN_SOUTH, MEN_WEST, MEN_NORTHEAST, MEN_SOUTHEAST, MEN_SOUTHWEST, MEN_NORTHWEST, MEN_UP, MEN_DOWN, MEN_IN, MEN_OUT,
		MEN_VERIFY, MEN_VERSION, MEN_DEBUG };

enum	{	GAD_STRING, GAD_WIDTH, GAD_ACCEPT, GAD_SELECT, GAD_CANCEL };
enum	{	GAD_PALETTE_COLOURS, GAD_PALETTE_RED, GAD_PALETTE_GREEN, GAD_PALETTE_BLUE, GAD_PALETTE_USE, GAD_PALETTE_CANCEL };

#define SIG_CONSOLE	(1 << ConReadPort -> mp_SigBit)
#define SIG_WINDOW	(1 << Window -> UserPort -> mp_SigBit)
#define SIG_DEBUG	(DebugWindow ? (1 << DebugWindow -> UserPort -> mp_SigBit) : NULL)
#define SIG_WORKBENCH	(WorkbenchPort ? (1 << WorkbenchPort -> mp_SigBit) : NULL)
#define SIG_SPEECH	(1 << NarratorPort -> mp_SigBit)
#define SIG_TEXT	(1 << SpeechPort -> mp_SigBit)
#define SIG_KILL	SIGBREAKF_CTRL_C
#define SIG_HANDSHAKE	SIGBREAKF_CTRL_D
#define SIG_STOP	SIGBREAKF_CTRL_E

#define GT_STRING(G)	(((struct StringInfo *)(((struct Gadget *)(G)) -> SpecialInfo)) -> Buffer)
#define GT_INTEGER(G)	(((struct StringInfo *)(((struct Gadget *)(G)) -> SpecialInfo)) -> LongInt)

#ifdef LATTICE

ULONG CXBRK(VOID) { return(NULL); }

#endif

#ifdef AZTEC_C

LONG Chk_Abort(VOID) { return(NULL); }

VOID _wb_parse() {}

#define __chip
#define __saveds

#endif

VOID				SayMore(UBYTE *a,UBYTE *b);
VOID __saveds			SpeechServer(VOID);
VOID				DeleteSpeech(VOID);
BYTE				CreateSpeech(VOID);
VOID				BlockWindow(VOID);
VOID				UnblockWindow(VOID);
BOOL				ShowRequest(UBYTE *Text,UBYTE *Gadgets,...);
UBYTE *				GetSaveName(VOID);
UBYTE *				GetRestoreName(VOID);
VOID				ConPutC(UBYTE c);
UBYTE				ConGetC(VOID);
VOID				ConPutS(UBYTE *s);
VOID				ConPrintf(UBYTE *Text,...);
VOID				ConPutS2(UBYTE *a,UBYTE *b);
VOID				ConCleanup(VOID);
BYTE				OpenConsoleStuff(VOID);

extern struct WBStartup		*WBenchMsg;
extern UBYTE			*ProgramName;
extern char			*story_name,
				 print_name[];
extern int			 printer_width;

STATIC UBYTE			*VersionTag = VERSTAG;

struct IntuitionBase		*IntuitionBase;
struct GfxBase			*GfxBase;
struct Library			*GadToolsBase;
struct Library			*AslBase;
struct Library			*WorkbenchBase;
struct Library			*IconBase;
struct Library			*IFFParseBase;
struct Library			*TranslatorBase;

STATIC struct MsgPort		*SpeechPort;
STATIC struct Process		*SpeechProcess;
STATIC BYTE			 NarrateStory = FALSE;

STATIC struct FileRequester	*SaveRequest,
				*RestoreRequest,
				*ProtocolRequest;

struct Screen			*Screen;
STATIC struct Menu		*MachineMenu;
STATIC APTR			 VisualInfo;

struct Process			*ThisProcess;
STATIC APTR			 OldPtr;

STATIC struct IOStdReq		*ConReadRequest,
				*ConWriteRequest;

STATIC struct MsgPort		*ConWritePort,
				*ConReadPort;

STATIC struct MsgPort		*WorkbenchPort;
STATIC struct AppWindow		*WorkbenchWindow;

STATIC UBYTE			 ScreenTitle[80],
	 			 SharedBuffer[256];

STATIC struct Window		*DebugWindow;
STATIC BPTR			 DebugFile;
STATIC struct MenuItem		*DebugItem;
STATIC LONG			 DebugX = -1,DebugY = -1,DebugWidth = -1,DebugHeight = -1;

UBYTE				*String = NULL;
UBYTE				 LastFile[256];
BYTE				 DontAsk = FALSE;
BYTE				 CustomScreen = FALSE;
struct Window			*Window;
UWORD				 TwoColours[2];

struct TextAttr			 DefaultFont;
UBYTE				 DefaultFontName[256];
UWORD				 DefaultFontWidth;

STATIC UWORD __chip Stopwatch[(2 + 16) * 2] =
{
	0x0000,0x0000,

	0x0400,0x07C0,
	0x0000,0x07C0,
	0x0100,0x0380,
	0x0000,0x07E0,
	0x07C0,0x1FF8,
	0x1FF0,0x3FEC,
	0x3FF8,0x7FDE,
	0x3FF8,0x7FBE,
	0x7FFC,0xFF7F,
	0x7EFC,0xFFFF,
	0x7FFC,0xFFFF,
	0x3FF8,0x7FFE,
	0x3FF8,0x7FFE,
	0x1FF0,0x3FFC,
	0x07C0,0x1FF8,
	0x0000,0x07E0,

	0x0000,0x0000
};

STATIC UBYTE *MenuCodes[] =
{
	"",
	"save\r", "save\r", "restore\r", "script", "palette", "about\r", "quit\r",
	"look\r", "wait\r", "inventory\r", "diagnose\r",
	"restart\r", "verbose\r", "brief\r", "superbrief\r", "score\r", "time\r", "",
	"north\r", "east\r", "south\r", "west\r", "northeast\r", "southeast\r", "southwest\r", "northwest\r", "up\r", "down\r", "in\r", "out\r",
	"$verify\r", "version\r", ""
};

STATIC struct NewMenu MachineMenuConfig[] =
{
	{ NM_TITLE, "Project",			 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Save",			"S",0,			0,	(APTR)MEN_SAVE},
	{  NM_ITEM, "Save As...",		"A",0,			0,	(APTR)MEN_SAVEAS},
	{  NM_ITEM, "Open...",			"O",0,			0,	(APTR)MEN_RESTORE},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Protocol",			"P",CHECKIT|MENUTOGGLE,	0,	(APTR)MEN_SCRIPT},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Palette",			 0 ,0,			0,	(APTR)MEN_PALETTE},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "About...",			"?",0,			0,	(APTR)MEN_ABOUT},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Quit...",			"Q",0,			0,	(APTR)MEN_QUIT},

	{ NM_TITLE, "Commands",			 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Look",			"L",0,			0,	(APTR)MEN_LOOK},
	{  NM_ITEM, "Wait",			"W",0,			0,	(APTR)MEN_WAIT},
	{  NM_ITEM, "Inventory",		"I",0,			0,	(APTR)MEN_INVENTORY},
	{  NM_ITEM, "Diagnose",			"D",0,			0,	(APTR)MEN_DIAGNOSE},

	{ NM_TITLE, "Story",			 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Restart...",		"R",0,			0,	(APTR)MEN_RESTART},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Verbose",			",",CHECKIT,		~4,	(APTR)MEN_VERBOSE},
	{  NM_ITEM, "Brief",			"0",CHECKIT|CHECKED,	~8,	(APTR)MEN_BRIEF},
	{  NM_ITEM, "Superbrief",		".",CHECKIT,		~16,	(APTR)MEN_SUPERBRIEF},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Score",			"Z",0,			0,	(APTR)MEN_SCORE},
	{  NM_ITEM, "Time",			"T",0,			0,	(APTR)MEN_TIME},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Narrate story",		"N",CHECKIT|MENUTOGGLE,	0,	(APTR)MEN_SPEECH},

	{ NM_TITLE, "Movement",			 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "North",			"8",0,			0,	(APTR)MEN_NORTH},
	{  NM_ITEM, "East",			"6",0,			0,	(APTR)MEN_EAST},
	{  NM_ITEM, "South",			"2",0,			0,	(APTR)MEN_SOUTH},
	{  NM_ITEM, "West",			"4",0,			0,	(APTR)MEN_WEST},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Northeast",		"9",0,			0,	(APTR)MEN_NORTHEAST},
	{  NM_ITEM, "Southeast",		"3",0,			0,	(APTR)MEN_SOUTHEAST},
	{  NM_ITEM, "Southwest",		"1",0,			0,	(APTR)MEN_SOUTHWEST},
	{  NM_ITEM, "Northwest",		"7",0,			0,	(APTR)MEN_NORTHWEST},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Up",			"+",0,			0,	(APTR)MEN_UP},
	{  NM_ITEM, "Down",			"-",0,			0,	(APTR)MEN_DOWN},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "In",			"<",0,			0,	(APTR)MEN_IN},
	{  NM_ITEM, "Out",			">",0,			0,	(APTR)MEN_OUT},

	{ NM_TITLE, "Diagnose",			 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Verify disk",		 0 ,0,			0,	(APTR)MEN_VERIFY},
	{  NM_ITEM, "Version",			 0 ,0,			0,	(APTR)MEN_VERSION},
	{  NM_ITEM, NM_BARLABEL,		 0 ,0,			0,	(APTR)0},
	{  NM_ITEM, "Debug mode",		 0 ,CHECKIT|MENUTOGGLE,	0,	(APTR)MEN_DEBUG},

	{ NM_END, 0,				 0 ,0,			0,	(APTR)0}
};

VOID
AdjustTitle(STRPTR Title)
{
	if(!Screen)
	{
		STATIC UBYTE Title1[256],Title2[256];

		if(Title)
			strcpy((char *)Title1,(char *)Title);

		Title = Title1;

		if(NarrateStory && SpeechProcess)
			sprintf(Title2,"%s (narrating)",Title);
		else
			strcpy((char *)Title2,(char *)Title);

		SetWindowTitles(Window,Title2,(UBYTE *)-1);
	}
}

LONG
ahtoi(STRPTR String)
{
	LONG Value = 0;
	UBYTE c;

	while(c = *String)
	{
		Value <<= 4;

		if(c >= '0' && c <= '9')
			Value |= (c & 15);
		else
			Value |= (c & 15) + 9;

		++String;
	}

	return(Value);
}

VOID
CloseDebugWindow()
{
	if(DebugWindow)
	{
		DebugX		= DebugWindow -> LeftEdge;
		DebugY		= DebugWindow -> TopEdge;
		DebugWidth	= DebugWindow -> Width;
		DebugHeight	= DebugWindow -> Height;

		if(DebugFile)
			FreeSignal(DebugWindow -> UserPort -> mp_SigBit);
		else
			CloseWindow(DebugWindow);

		DebugWindow = NULL;
	}

	if(DebugFile)
	{
		Close(DebugFile);

		DebugFile = NULL;
	}

	if(DebugItem)
		DebugItem -> Flags &= ~CHECKED;
}

BYTE
OpenDebug()
{
	if(DebugWidth == -1)
	{
		DebugWindow = OpenWindowTags(NULL,
			WA_Top,			Window -> TopEdge	+ 20,
			WA_Left,		Window -> LeftEdge	+ 20,
			WA_InnerWidth,		GfxBase -> DefaultFont -> tf_XSize * 40,
			WA_InnerHeight,		GfxBase -> DefaultFont -> tf_YSize * 10,
			WA_Title,		"Debug Window",
			WA_MaxWidth,		Window -> WScreen -> Width,
			WA_MaxHeight,		Window -> WScreen -> Height,
			WA_CloseGadget,		TRUE,
			WA_IDCMP,		IDCMP_CLOSEWINDOW,
			WA_SimpleRefresh,	TRUE,
			WA_SizeBBottom,		TRUE,
			WA_SizeGadget,		TRUE,
			WA_DragBar,		TRUE,
			WA_DepthGadget,		TRUE,
			WA_RMBTrap,		TRUE,
			WA_CustomScreen,	Window -> WScreen,
		TAG_DONE);
	}
	else
	{
		DebugWindow = OpenWindowTags(NULL,
			WA_Top,			DebugY,
			WA_Left,		DebugX,
			WA_Width,		DebugWidth,
			WA_Height,		DebugHeight,
			WA_Title,		"Debug Window",
			WA_MaxWidth,		Window -> WScreen -> Width,
			WA_MaxHeight,		Window -> WScreen -> Height,
			WA_CloseGadget,		TRUE,
			WA_IDCMP,		IDCMP_CLOSEWINDOW,
			WA_SimpleRefresh,	TRUE,
			WA_SizeGadget,		TRUE,
			WA_DragBar,		TRUE,
			WA_DepthGadget,		TRUE,
			WA_RMBTrap,		TRUE,
			WA_CustomScreen,	Window -> WScreen,
		TAG_DONE);
	}

	if(DebugWindow)
	{
		UBYTE Buffer[40];

		sprintf(Buffer,"CON://///INACTIVE/WINDOW%08lx",DebugWindow);

		if(DebugFile = Open(Buffer,MODE_READWRITE))
			return(TRUE);

		CloseWindow(DebugWindow);
	}

	DebugWindow = NULL;

	return(FALSE);
}

VOID
DPrintf(STRPTR Format,...)
{
	if(DebugFile)
	{
		if(Format[0])
		{
			va_list VarArgs;

			va_start(VarArgs,Format);
			VFPrintf(DebugFile,Format,(APTR)VarArgs);
			va_end(VarArgs);
		}
		else
			Flush(DebugFile);

		if(SetSignal(0,0) & SIG_DEBUG)
		{
			struct IntuiMessage *Message;

			while(Message = (struct IntuiMessage *)GetMsg(DebugWindow -> UserPort))
				ReplyMsg((struct Message *)Message);

			SetSignal(0,SIG_DEBUG);

			CloseDebugWindow();
		}
	}
}

VOID
SayMore(UBYTE *a,UBYTE *b)
{
	if(SpeechPort && NarrateStory)
	{
		struct Message	*Msg;
		WORD		 Len = b - a;

		if(b[-1] == '>')
			Len--;

		if(Len > 0)
		{
			if(Msg = (struct Message *)AllocVec(sizeof(struct Message) + Len + 1,MEMF_ANY | MEMF_PUBLIC | MEMF_CLEAR))
			{
				Msg -> mn_Node . ln_Name	= (STRPTR)(Msg + 1);
				Msg -> mn_Length		= sizeof(struct Message) + Len + 1;

				memcpy(Msg -> mn_Node . ln_Name,a,Len);

				PutMsg(SpeechPort,Msg);
			}
		}
	}
}

VOID __saveds
SpeechServer()
{
	struct MsgPort		*NarratorPort;
	struct narrator_rb	*NarratorRequest;
	STRPTR			 TranslateBuffer;

#ifdef AZTEC_C
	geta4();
#endif	/* AZTEC_C */

	if(TranslateBuffer = (STRPTR)AllocVec(10000,MEMF_ANY))
	{
		if(NarratorPort = CreateMsgPort())
		{
			if(NarratorRequest = (struct narrator_rb *)CreateIORequest(NarratorPort,sizeof(struct narrator_rb)))
			{
				STATIC UBYTE AnyChannel[4] = { 1,8,2,4 };

				NarratorRequest -> ch_masks		= &AnyChannel[0];
				NarratorRequest -> nm_masks		= 4;

				NarratorRequest -> message . io_Command	= CMD_WRITE;
				NarratorRequest -> message . io_Data	= (APTR)TranslateBuffer;

				if(!OpenDevice("narrator.device",0,(struct IORequest *)NarratorRequest,0))
				{
					if(SpeechPort = CreateMsgPort())
					{
						struct Message	*Msg;
						ULONG		 SignalSet;
						BYTE		 Terminated = FALSE;

						Signal((struct Task *)ThisProcess,SIG_HANDSHAKE);

						while(!Terminated)
						{
							SignalSet = Wait(SIG_TEXT | SIG_KILL);

							if(SignalSet & SIG_KILL)
								break;

							if(SignalSet & SIG_TEXT)
							{
								if(NarrateStory)
								{
									SetSignal(0,SIG_STOP);

									while(Msg = GetMsg(SpeechPort))
									{
										if(!Translate(Msg -> mn_Node . ln_Name,strlen((char *)Msg -> mn_Node . ln_Name),TranslateBuffer,9999))
										{
											NarratorRequest -> message . io_Length = strlen((char *)TranslateBuffer);

											BeginIO(NarratorRequest);

											FOREVER
											{
												SignalSet = Wait(SIG_KILL | SIG_STOP | SIG_SPEECH);

												if(SignalSet & SIG_KILL)
												{
													if(!CheckIO((struct IORequest *)NarratorRequest))
														AbortIO((struct IORequest *)NarratorRequest);

													WaitIO((struct IORequest *)NarratorRequest);

													Terminated = TRUE;

													break;
												}

												if(SignalSet & SIG_STOP)
												{
													if(!CheckIO((struct IORequest *)NarratorRequest))
														AbortIO((struct IORequest *)NarratorRequest);

													WaitIO((struct IORequest *)NarratorRequest);

													while(Msg = GetMsg(SpeechPort))
														FreeVec(Msg);

													break;
												}

												if(SignalSet & SIG_SPEECH)
												{
													WaitIO((struct IORequest *)NarratorRequest);

													break;
												}
											}
										}

										FreeVec(Msg);

										if(Terminated)
											break;
									}
								}
								else
								{
									while(Msg = GetMsg(SpeechPort))
										FreeVec(Msg);
								}
							}
						}

						while(Msg = GetMsg(SpeechPort))
							FreeVec(Msg);

						DeleteMsgPort(SpeechPort);

						SpeechPort = NULL;
					}

					CloseDevice((struct IORequest *)NarratorRequest);
				}

				DeleteIORequest(NarratorRequest);
			}

			DeleteMsgPort(NarratorPort);
		}

		FreeVec(TranslateBuffer);
	}

	Forbid();

	SpeechProcess = NULL;

	Signal((struct Task *)ThisProcess,SIG_HANDSHAKE);
}

VOID
DeleteSpeech()
{
	if(SpeechProcess)
	{
		Signal((struct Task *)SpeechProcess,SIG_KILL);

		Wait(SIG_HANDSHAKE);
	}

	if(TranslatorBase)
	{
		CloseLibrary((struct Library *)TranslatorBase);

		TranslatorBase = NULL;
	}
}

BYTE
CreateSpeech()
{
	if(TranslatorBase = OpenLibrary("translator.library",37))
	{
		if(SpeechProcess = CreateNewProcTags(
			NP_Name,	"Zorkmachine Speech",
			NP_StackSize,	8192,
			NP_Priority,	5,
			NP_WindowPtr,	-1,
			NP_Entry,	SpeechServer,
		TAG_DONE))
		{
			Wait(SIG_HANDSHAKE);

			if(SpeechProcess)
				return(TRUE);
		}
	}

	DeleteSpeech();

	return(FALSE);
}

VOID
BlockWindow()
{
	SetPointer(Window,&Stopwatch[0],16,16,-6,0);

	Window -> Flags |= WFLG_RMBTRAP;

	if(DebugWindow)
		SetPointer(DebugWindow,&Stopwatch[0],16,16,-6,0);
}

VOID
UnblockWindow()
{
	ClearPointer(Window);

	Window -> Flags &= ~WFLG_RMBTRAP;

	if(DebugWindow)
		ClearPointer(DebugWindow);
}

BOOL
ShowRequest(UBYTE *Text,UBYTE *Gadgets,...)
{
	struct EasyStruct	Easy;
	BOOL			Result;
	ULONG			IDCMP = NULL;
	va_list	 		VarArgs;

	Easy . es_StructSize	= sizeof(struct EasyStruct);
	Easy . es_Flags		= NULL;
	Easy . es_Title		= (UBYTE *)ProgramName;
	Easy . es_TextFormat	= (UBYTE *)Text;
	Easy . es_GadgetFormat	= (UBYTE *)Gadgets;

	BlockWindow();

	va_start(VarArgs,Gadgets);
	Result = EasyRequestArgs(Window,&Easy,&IDCMP,VarArgs);
	va_end(VarArgs);

	UnblockWindow();

	return(Result);
}

struct Gadget *
CreateAllPaletteGadgets(struct Gadget **GadgetArray,struct Gadget **GadgetList,APTR VisualInfo,UWORD TopEdge,UWORD Width)
{
	struct Gadget		*Gadget;
	struct NewGadget	 NewGadget;
	UWORD			 Counter = 0;

	memset(&NewGadget,0,sizeof(struct NewGadget));

	if(Gadget = CreateContext(GadgetList))
	{
		NewGadget . ng_GadgetText	= "Palette";
		NewGadget . ng_TextAttr		= &DefaultFont;
		NewGadget . ng_VisualInfo	= VisualInfo;
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_Flags		= PLACETEXT_LEFT;
		NewGadget . ng_LeftEdge		= 10 + 9 * DefaultFontWidth;
		NewGadget . ng_TopEdge		= 1 + TopEdge;
		NewGadget . ng_Width		= 20 * DefaultFontWidth;
		NewGadget . ng_Height		= DefaultFont . ta_YSize * 3;

		GadgetArray[Counter++] = Gadget = CreateGadget(PALETTE_KIND,Gadget,&NewGadget,
			GTPA_Depth,		1,
			GTPA_Color,		0,
			GTPA_IndicatorWidth,	NewGadget . ng_Width / (1 << 2),
			GTPA_IndicatorHeight,	NewGadget . ng_Height,
		TAG_DONE);

		NewGadget . ng_GadgetText	= "Red   ";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;
		NewGadget . ng_Height		= DefaultFont . ta_YSize + 2;

		GadgetArray[Counter++] = Gadget = CreateGadget(SLIDER_KIND,Gadget,&NewGadget,
			GTSL_Min,		0,
			GTSL_Max,		15,
			GTSL_Level,		0,
			GTSL_LevelFormat,	"%2ld",
			GTSL_MaxLevelLen,	2,
		TAG_DONE);

		NewGadget . ng_GadgetText	= "Green   ";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;

		GadgetArray[Counter++] = Gadget = CreateGadget(SLIDER_KIND,Gadget,&NewGadget,
			GTSL_Min,		0,
			GTSL_Max,		15,
			GTSL_Level,		0,
			GTSL_LevelFormat,	"%2ld",
			GTSL_MaxLevelLen,	2,
		TAG_DONE);

		NewGadget . ng_GadgetText	= "Blue   ";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;

		GadgetArray[Counter++] = Gadget = CreateGadget(SLIDER_KIND,Gadget,&NewGadget,
			GTSL_Min,		0,
			GTSL_Max,		15,
			GTSL_Level,		0,
			GTSL_LevelFormat,	"%2ld",
			GTSL_MaxLevelLen,	2,
		TAG_DONE);

		NewGadget . ng_GadgetText	= "Okay";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_Flags		= NULL;
		NewGadget . ng_LeftEdge		= 10;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;
		NewGadget . ng_Width		= 11 * DefaultFontWidth + 8;
		NewGadget . ng_Height		= DefaultFont . ta_YSize + 6;

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,
			TAG_DONE);

		NewGadget . ng_GadgetText	= "Cancel";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_LeftEdge		= Width - 10 - NewGadget . ng_Width;

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,
			TAG_DONE);
	}

	return(Gadget);
}

VOID
EditPalette()
{
	struct Gadget		*GadgetList,
				*GadgetArray[6];

	struct Window		*LocalWindow;
	struct Requester	 GlobalRequester;

	WORD			 Width	= 2 * 10 + 20 * DefaultFontWidth + 9 * DefaultFontWidth,
				 Height	= 1 + Window -> WScreen -> WBorTop + Window -> WScreen -> Font -> ta_YSize + 1 + DefaultFont . ta_YSize * 3 + INTERHEIGHT + 3 * (DefaultFont . ta_YSize + 2 + INTERHEIGHT) + DefaultFont . ta_YSize + 6 + INTERHEIGHT,
				 i;

	UWORD			 NewPalette[2],
				 OldPalette[2],
				 R,G,B;

	for(i = 0 ; i < 2 ; i++)
		NewPalette[i] = OldPalette[i] = GetRGB4(Window -> WScreen -> ViewPort . ColorMap,i);

	SetPointer(Window,&Stopwatch[0],16,16,-6,0);

	memset(&GlobalRequester,0,sizeof(struct Requester));

	Request(&GlobalRequester,Window);

	if(CreateAllPaletteGadgets(&GadgetArray[0],&GadgetList,VisualInfo,Window -> WScreen -> WBorTop + Window -> WScreen -> Font -> ta_YSize + 1,Width))
	{
		if(LocalWindow = OpenWindowTags(NULL,
			WA_Top,			Window -> TopEdge + (Window -> Height - Height) / 2,
			WA_Left,		Window -> LeftEdge + (Window -> Width - Width) / 2,
			WA_Title,		"Palette",
			WA_Width,		Width,
			WA_Height,		Height,
			WA_IDCMP,		IDCMP_ACTIVEWINDOW | IDCMP_CLOSEWINDOW | PALETTEIDCMP | SLIDERIDCMP | BUTTONIDCMP,
			WA_Activate,		TRUE,
			WA_CloseGadget,		TRUE,
			WA_DragBar,		TRUE,
			WA_DepthGadget,		TRUE,
			WA_RMBTrap,		TRUE,
			WA_CustomScreen,	Window -> WScreen,
		TAG_DONE))
		{
			struct IntuiMessage	*Massage;
			ULONG			 Class,
						 Code;
			struct Gadget		*Gadget;

			BYTE			 Terminated = FALSE;
			WORD			 Active = 0;

			AddGList(LocalWindow,GadgetList,(UWORD)-1,(UWORD)-1,NULL);
			RefreshGList(GadgetList,LocalWindow,NULL,(UWORD)-1);
			GT_RefreshWindow(LocalWindow,NULL);

			R = (OldPalette[0] >> 8) & 0xF;
			G = (OldPalette[0] >> 4) & 0xF;
			B = (OldPalette[0]     ) & 0xF;

			GT_SetGadgetAttrs(GadgetArray[GAD_PALETTE_RED],LocalWindow,NULL,
				GTSL_Level,R,
			TAG_DONE);

			GT_SetGadgetAttrs(GadgetArray[GAD_PALETTE_GREEN],LocalWindow,NULL,
				GTSL_Level,G,
			TAG_DONE);

			GT_SetGadgetAttrs(GadgetArray[GAD_PALETTE_BLUE],LocalWindow,NULL,
				GTSL_Level,B,
			TAG_DONE);

			while(!Terminated)
			{
				WaitPort(LocalWindow -> UserPort);

				while(Massage = GT_GetIMsg(LocalWindow -> UserPort))
				{
					Class	= Massage -> Class;
					Code	= Massage -> Code;
					Gadget	= (struct Gadget *)Massage -> IAddress;

					GT_ReplyIMsg(Massage);

					switch(Class)
					{
						case IDCMP_CLOSEWINDOW:		Terminated = TRUE;
										break;

						case IDCMP_MOUSEMOVE:		switch(Gadget -> GadgetID)
										{
											case GAD_PALETTE_RED:	R = Code;

														NewPalette[Active] = (R << 8) | (G << 4) | B;

														SetRGB4(&Window -> WScreen -> ViewPort,Active,R,G,B);

														break;

											case GAD_PALETTE_GREEN:	G = Code;

														NewPalette[Active] = (R << 8) | (G << 4) | B;

														SetRGB4(&Window -> WScreen -> ViewPort,Active,R,G,B);

														break;

											case GAD_PALETTE_BLUE:	B = Code;

														NewPalette[Active] = (R << 8) | (G << 4) | B;

														SetRGB4(&Window -> WScreen -> ViewPort,Active,R,G,B);

														break;
										}

										break;

						case IDCMP_GADGETUP:		switch(Gadget -> GadgetID)
										{
											case GAD_PALETTE_RED:	R = Code;

														NewPalette[Active] = (R << 8) | (G << 4) | B;

														SetRGB4(&Window -> WScreen -> ViewPort,Active,R,G,B);

														break;

											case GAD_PALETTE_GREEN:	G = Code;

														NewPalette[Active] = (R << 8) | (G << 4) | B;

														SetRGB4(&Window -> WScreen -> ViewPort,Active,R,G,B);

														break;

											case GAD_PALETTE_BLUE:	B = Code;

														NewPalette[Active] = (R << 8) | (G << 4) | B;

														SetRGB4(&Window -> WScreen -> ViewPort,Active,R,G,B);

														break;

											case GAD_PALETTE_COLOURS:

														Active = Code;

														R = (NewPalette[Active] >> 8) & 0xF;
														G = (NewPalette[Active] >> 4) & 0xF;
														B = (NewPalette[Active]     ) & 0xF;

														GT_SetGadgetAttrs(GadgetArray[GAD_PALETTE_RED],LocalWindow,NULL,
															GTSL_Level,R,
														TAG_DONE);

														GT_SetGadgetAttrs(GadgetArray[GAD_PALETTE_GREEN],LocalWindow,NULL,
															GTSL_Level,G,
														TAG_DONE);

														GT_SetGadgetAttrs(GadgetArray[GAD_PALETTE_BLUE],LocalWindow,NULL,
															GTSL_Level,B,
														TAG_DONE);

														break;

											case GAD_PALETTE_CANCEL:

														LoadRGB4(&Window -> WScreen -> ViewPort,OldPalette,2);

											case GAD_PALETTE_USE:	Terminated = TRUE;

														break;
										}

										break;
					}
				}
			}

			CloseWindow(LocalWindow);
		}

		FreeGadgets(GadgetList);
	}

	EndRequest(&GlobalRequester,Window);

	ClearPointer(Window);
}

struct Gadget *
CreateAllGadgets(struct Gadget **GadgetArray,struct Gadget **GadgetList,APTR VisualInfo,UWORD TopEdge)
{
	struct Gadget		*Gadget;
	struct NewGadget	 NewGadget;
	UWORD			 Counter = 0;

	memset(&NewGadget,0,sizeof(struct NewGadget));

	if(Gadget = CreateContext(GadgetList))
	{
		WORD InterWidth;

		NewGadget . ng_GadgetText	= "Protocol output file/device";
		NewGadget . ng_TextAttr		= &DefaultFont;
		NewGadget . ng_VisualInfo	= VisualInfo;
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_Flags		= PLACETEXT_ABOVE;
		NewGadget . ng_LeftEdge		= 10;
		NewGadget . ng_TopEdge		= 1 + TopEdge + 2 * INTERHEIGHT + DefaultFont . ta_YSize;
		NewGadget . ng_Width		= 40 * DefaultFontWidth + 12;
		NewGadget . ng_Height		= DefaultFont . ta_YSize + 6;

		GadgetArray[Counter++] = Gadget = CreateGadget(STRING_KIND,Gadget,&NewGadget,
			GTST_MaxChars,	255,
		TAG_DONE);

		NewGadget . ng_GadgetText	= "Protocol page width";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + 2 * INTERHEIGHT + DefaultFont . ta_YSize;

		GadgetArray[Counter++] = Gadget = CreateGadget(INTEGER_KIND,Gadget,&NewGadget,
			GTIN_Number,	printer_width,
		TAG_DONE);

		InterWidth = (NewGadget . ng_Width - 3 * (11 * DefaultFontWidth + 8)) / 2;

		NewGadget . ng_GadgetText	= "Okay";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_Flags		= NULL;
		NewGadget . ng_TopEdge		= NewGadget . ng_TopEdge + NewGadget . ng_Height + INTERHEIGHT;
		NewGadget . ng_Width		= 11 * DefaultFontWidth + 8;
		NewGadget . ng_Height		= DefaultFont . ta_YSize + 6;

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,
			TAG_DONE);

		NewGadget . ng_GadgetText	= "Select File";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_LeftEdge		= NewGadget . ng_LeftEdge + NewGadget . ng_Width + InterWidth;

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,
			TAG_DONE);

		NewGadget . ng_GadgetText	= "Cancel";
		NewGadget . ng_GadgetID		= Counter;
		NewGadget . ng_LeftEdge		= NewGadget . ng_LeftEdge + NewGadget . ng_Width + InterWidth;

		GadgetArray[Counter++] = Gadget = CreateGadget(BUTTON_KIND,Gadget,&NewGadget,
			TAG_DONE);
	}

	return(Gadget);
}

BYTE
GetProtocolName(UBYTE *Name)
{
	struct Gadget		*GadgetList,
				*GadgetArray[5];

	struct Window		*LocalWindow;
	struct Requester	 GlobalRequester;

	BYTE			 Aborted = FALSE;

	SetPointer(Window,&Stopwatch[0],16,16,-6,0);

	memset(&GlobalRequester,0,sizeof(struct Requester));

	Request(&GlobalRequester,Window);

	if(CreateAllGadgets(&GadgetArray[0],&GadgetList,VisualInfo,Window -> WScreen -> WBorTop + Window -> WScreen -> Font -> ta_YSize + 1))
	{
		WORD	Width	= 2 * 10 + 40 * DefaultFontWidth + 12,
			Height	= 1 + Window -> WScreen -> WBorTop + Window -> WScreen -> Font -> ta_YSize + 1 + 4 * INTERHEIGHT + DefaultFont . ta_YSize + 2 * (DefaultFont . ta_YSize + 6) + Window -> WScreen -> WBorBottom + 2 * INTERHEIGHT + 2 * DefaultFont . ta_YSize + 6;

		if(LocalWindow = OpenWindowTags(NULL,
			WA_Top,			Window -> TopEdge + (Window -> Height - Height) / 2,
			WA_Left,		Window -> LeftEdge + (Window -> Width - Width) / 2,
			WA_Title,		"Open protocol",
			WA_Width,		Width,
			WA_Height,		Height,
			WA_IDCMP,		IDCMP_ACTIVEWINDOW | IDCMP_CLOSEWINDOW | STRINGIDCMP | BUTTONIDCMP,
			WA_Activate,		TRUE,
			WA_CloseGadget,		TRUE,
			WA_DragBar,		TRUE,
			WA_DepthGadget,		TRUE,
			WA_RMBTrap,		TRUE,
			WA_CustomScreen,	Window -> WScreen,
		TAG_DONE))
		{
			STATIC struct Requester	 Requester;

			struct IntuiMessage	*Massage;
			ULONG			 Class,
						 Code;
			struct Gadget		*Gadget;

			BYTE			 Terminated = FALSE;
			UBYTE			*Buffer;

			AddGList(LocalWindow,GadgetList,(UWORD)-1,(UWORD)-1,NULL);
			RefreshGList(GadgetList,LocalWindow,NULL,(UWORD)-1);
			GT_RefreshWindow(LocalWindow,NULL);

			GT_SetGadgetAttrs(GadgetArray[GAD_STRING],LocalWindow,NULL,
				GTST_String,	Name,
			TAG_DONE);

			Buffer = GT_STRING(GadgetArray[GAD_STRING]);

			ActivateGadget(GadgetArray[GAD_STRING],LocalWindow,NULL);

			memset(&Requester,0,sizeof(struct Requester));

			while(!Terminated)
			{
				WaitPort(LocalWindow -> UserPort);

				while(Massage = GT_GetIMsg(LocalWindow -> UserPort))
				{
					Class	= Massage -> Class;
					Code	= Massage -> Code;
					Gadget	= (struct Gadget *)Massage -> IAddress;

					GT_ReplyIMsg(Massage);

					switch(Class)
					{
						case IDCMP_CLOSEWINDOW:		Aborted = Terminated = TRUE;
										break;

						case IDCMP_ACTIVEWINDOW:	ActivateGadget(GadgetArray[GAD_STRING],LocalWindow,NULL);
										break;

						case IDCMP_GADGETUP:		switch(Gadget -> GadgetID)
										{
											case GAD_ACCEPT:	if(Buffer[0])
														{
															strcpy((char *)Name,(char *)Buffer);

															Terminated = TRUE;

															if((printer_width = GT_INTEGER(GadgetArray[GAD_WIDTH])) < 40)
																printer_width = 40;
														}

														break;

											case GAD_SELECT:	Request(&Requester,LocalWindow);

														SetPointer(LocalWindow,&Stopwatch[0],16,16,-6,0);

														if(AslRequestTags(ProtocolRequest,TAG_DONE))
														{
															if(ProtocolRequest -> fr_File[0])
															{
																strcpy((char *)SharedBuffer,(char *)ProtocolRequest -> fr_Drawer);

																if(AddPart(SharedBuffer,ProtocolRequest -> fr_File,256))
																{
																	GT_SetGadgetAttrs(GadgetArray[GAD_STRING],LocalWindow,NULL,
																		GTST_String,	SharedBuffer,
																	TAG_DONE);
																}
															}
														}

														ClearPointer(LocalWindow);

														EndRequest(&Requester,LocalWindow);

														break;

											case GAD_CANCEL:	Aborted = Terminated = TRUE;
														break;
										}

										break;
					}
				}
			}

			CloseWindow(LocalWindow);
		}

		FreeGadgets(GadgetList);
	}

	EndRequest(&GlobalRequester,Window);

	ClearPointer(Window);

	return(Aborted);
}

UBYTE *
GetSaveName()
{
	UBYTE *Dummy;

	if(!LastFile[0])
	{
		if(!GetCurrentDirName(LastFile,256))
			LastFile[0] = 0;

		if(!AddPart(LastFile,"Story.Save",256))
			LastFile[0] = 0;
	}

	strcpy((char *)SharedBuffer,(char *)LastFile);

	if(Dummy = PathPart(SharedBuffer))
		*Dummy = 0;

	BlockWindow();

	if(AslRequestTags(SaveRequest,
		ASL_File,	FilePart(LastFile),
		ASL_Dir,	SharedBuffer,
	TAG_DONE))
	{
		if(SaveRequest -> fr_File[0])
		{
			strcpy((char *)SharedBuffer,(char *)SaveRequest -> fr_Drawer);

			if(AddPart(SharedBuffer,SaveRequest -> fr_File,256))
			{
				BPTR FileLock;

				if(FileLock = Lock(SharedBuffer,ACCESS_READ))
				{
					if(!ShowRequest("You are about to write over an existing file.","Proceed|Cancel"))
					{
						UnLock(FileLock);

						UnblockWindow();

						return(NULL);
					}

					UnLock(FileLock);
				}

				strcpy((char *)LastFile,(char *)SharedBuffer);

				UnblockWindow();

				return(LastFile);
			}
		}
	}

	UnblockWindow();

	return(NULL);
}

UBYTE *
GetRestoreName()
{
	UBYTE *Dummy;

	if(!LastFile[0])
	{
		if(!GetCurrentDirName(LastFile,256))
			LastFile[0] = 0;

		if(!AddPart(LastFile,"Story.Save",256))
			LastFile[0] = 0;
	}

	strcpy((char *)SharedBuffer,(char *)LastFile);

	if(Dummy = PathPart(SharedBuffer))
		*Dummy = 0;

	BlockWindow();

	if(AslRequestTags(RestoreRequest,
		ASL_File,	FilePart(LastFile),
		ASL_Dir,	SharedBuffer,
	TAG_DONE))
	{
		if(RestoreRequest -> fr_File[0])
		{
			strcpy((char *)SharedBuffer,(char *)RestoreRequest -> fr_Drawer);

			if(AddPart(SharedBuffer,RestoreRequest -> fr_File,256))
			{
				strcpy((char *)LastFile,(char *)SharedBuffer);

				UnblockWindow();

				return(LastFile);
			}
		}
	}

	UnblockWindow();

	return(NULL);
}

VOID
ConPutC(UBYTE c)
{
	ConWriteRequest -> io_Command	= CMD_WRITE;
	ConWriteRequest -> io_Data	= &c;
	ConWriteRequest -> io_Length	= 1;

	DoIO((struct IORequest *)ConWriteRequest);
}

UBYTE
ConGetC()
{
	ULONG Signals;
	UBYTE c = 0;

	if(String)
	{
		if(*String)
			return(*String++);
		else
			String = NULL;
	}

	ConReadRequest -> io_Command	= CMD_READ;
	ConReadRequest -> io_Data	= &c;
	ConReadRequest -> io_Length	= 1;

	SendIO((struct IORequest *)ConReadRequest);

	FOREVER
	{
		Signals = Wait(SIG_WINDOW | SIG_CONSOLE | SIG_WORKBENCH | SIG_DEBUG);

		if(Signals & SIG_DEBUG)
		{
			struct IntuiMessage *Message;

			while(Message = (struct IntuiMessage *)GetMsg(DebugWindow -> UserPort))
				ReplyMsg((struct Message *)Message);

			CloseDebugWindow();
		}

		if(Signals & SIG_WORKBENCH)
		{
			struct AppMessage	*AppMessage;
			BYTE			 GotName = FALSE;
			LONG			 i;

			while(AppMessage = (struct AppMessage *)GetMsg(WorkbenchPort))
			{
				if(!GotName)
				{
					for(i = 0 ; !GotName && i < AppMessage -> am_NumArgs ; i++)
					{
						if(AppMessage -> am_ArgList[i] . wa_Lock)
						{
							if(NameFromLock(AppMessage -> am_ArgList[i] . wa_Lock,SharedBuffer,256))
							{
								if(AddPart(SharedBuffer,AppMessage -> am_ArgList[i] . wa_Name,256))
								{
									struct DiskObject *Icon;

									if(Icon = GetDiskObject(SharedBuffer))
									{
										if(Icon -> do_Type == WBPROJECT)
										{
											UBYTE *Result;

											if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"FILETYPE"))
											{
												if(!stricmp((char *)Result,"Z3SAVEFILE"))
													GotName = TRUE;
											}
										}

										FreeDiskObject(Icon);
									}
								}
							}
						}
					}
				}

				ReplyMsg((struct Message *)AppMessage);
			}

			if(GotName)
			{
				AbortIO((struct IORequest *)ConReadRequest);

				WaitIO((struct IORequest *)ConReadRequest);

				SetSignal(0,SIG_CONSOLE);

				String = "restore\r";

				strcpy((char *)LastFile,(char *)SharedBuffer);

				DontAsk = TRUE;

				return(24);
			}
		}

		if(Signals & SIG_CONSOLE)
		{
			WaitIO((struct IORequest *)ConReadRequest);

			return(c);
		}

		if(Signals & SIG_WINDOW)
		{
			struct IntuiMessage	*IMsg;
			ULONG			 Class,
						 Code;

			while(IMsg = GT_GetIMsg(Window -> UserPort))
			{
				Class	= IMsg -> Class;
				Code	= IMsg -> Code;

				GT_ReplyIMsg(IMsg);

				if(Class == IDCMP_CLOSEWINDOW)
				{
					if(!String)
						String = MenuCodes[MEN_QUIT];
				}

				if(Class == IDCMP_MENUPICK)
				{
					struct MenuItem *Item,*ScriptIt = NULL;

					while(Code != MENUNULL)
					{
						if(Item = ItemAddress(MachineMenu,Code))
						{
							LONG Menu = (LONG)GTMENUITEM_USERDATA(Item);

							switch(Menu)
							{
								case MEN_ABOUT:	ShowRequest("Zorkmachine 2.24\n\n\
 Created by\n\
  Matthias Pfaller\n\n\
 Amiga version %ld.%ld created by\n\
  Olaf Barthel\n\
   based on a fragmentary port by\n\
    martin@deepth.ulm.sub.org","Continue",VERSION,REVISION);
										break;

								case MEN_SPEECH:if(Item -> Flags & CHECKED)
											NarrateStory = TRUE;
										else
											NarrateStory = FALSE;

										if(!NarrateStory && SpeechProcess)
											Signal((struct Task *)SpeechProcess,SIG_STOP);

										AdjustTitle(NULL);

										break;

								default:	if(!String)
										{
											switch(Menu)
											{
												case MEN_PALETTE:

													EditPalette();
													break;

												case MEN_DEBUG:

													DebugItem = Item;

													if(Item -> Flags & CHECKED)
													{
														if(!OpenDebug())
															Item -> Flags &= ~CHECKED;
													}
													else
														CloseDebugWindow();

													break;

												case MEN_SCRIPT:

													if(Item -> Flags & CHECKED)
													{
														ScriptIt = Item;

														String = "script\r";
													}
													else
														String = "unscript\r";

													break;

												case MEN_SAVE:

													DontAsk = TRUE;

													String = MenuCodes[Menu];

													break;

												case 0:

													break;

												default:

													String = MenuCodes[Menu];

													break;
											}
										}

										break;
							}

							Code = Item -> NextSelect;
						}
					}

					if(ScriptIt)
					{
						BlockWindow();

						if(GetProtocolName((UBYTE *)print_name))
						{
							ScriptIt -> Flags &= ~CHECKED;

							String = "";
						}

						UnblockWindow();
					}
				}
			}

			if(String)
			{
				AbortIO((struct IORequest *)ConReadRequest);

				WaitIO((struct IORequest *)ConReadRequest);

				SetSignal(0,SIG_CONSOLE);

				return(24);
			}
		}
	}
}

VOID
ConPutS(UBYTE *s)
{
	ConWriteRequest -> io_Command	= CMD_WRITE;
	ConWriteRequest -> io_Data	= s;
	ConWriteRequest -> io_Length	= -1;

	DoIO((struct IORequest *)ConWriteRequest);
}

VOID
ConPrintf(UBYTE *Text,...)
{
	va_list VarArgs;

	va_start(VarArgs,Text);
	vsprintf(SharedBuffer,Text,VarArgs);
	va_end(VarArgs);

	ConPutS(SharedBuffer);
}

VOID
ConPutS2(UBYTE *a,UBYTE *b)
{
	ConWriteRequest -> io_Command	= CMD_WRITE;
	ConWriteRequest -> io_Data	= a;
	ConWriteRequest -> io_Length	= b - a;

	DoIO((struct IORequest *)ConWriteRequest);
}

VOID
ConCleanup()
{
	ThisProcess -> pr_WindowPtr = OldPtr;

	if(ConReadRequest)
	{
		if(ConReadRequest -> io_Device)
			CloseDevice((struct IORequest *)ConReadRequest);

		DeleteIORequest((struct IORequest *)ConReadRequest);
	}

	if(ConWriteRequest)
		DeleteIORequest((struct IORequest *)ConWriteRequest);

	if(ConReadPort)
		DeleteMsgPort(ConReadPort);

	if(ConWritePort)
		DeleteMsgPort(ConWritePort);

	if(WorkbenchWindow)
		RemoveAppWindow(WorkbenchWindow);

	if(WorkbenchPort)
	{
		struct Message *Message;

		while(Message = GetMsg(WorkbenchPort))
			ReplyMsg(Message);

		DeleteMsgPort(WorkbenchPort);
	}

	if(Window)
	{
		Window -> Flags |= WFLG_RMBTRAP;

		ClearMenuStrip(Window);

		CloseWindow(Window);
	}

	CloseDebugWindow();

	if(Screen)
		CloseScreen(Screen);

	if(MachineMenu)
		FreeMenus(MachineMenu);

	if(ProtocolRequest)
		FreeAslRequest(ProtocolRequest);

	if(SaveRequest)
		FreeAslRequest(SaveRequest);

	if(RestoreRequest)
		FreeAslRequest(RestoreRequest);

	DeleteSpeech();

	if(IFFParseBase)
		CloseLibrary(IFFParseBase);

	if(IconBase)
		CloseLibrary(IconBase);

	if(WorkbenchBase)
		CloseLibrary(WorkbenchBase);

	if(AslBase)
		CloseLibrary(AslBase);

	if(IntuitionBase)
		CloseLibrary((struct Library *)IntuitionBase);

	if(GfxBase)
		CloseLibrary((struct Library *)GfxBase);

	if(GadToolsBase)
		CloseLibrary(GadToolsBase);

	SoundCleanup();
}

BYTE
OpenConsoleStuff()
{
	struct Screen *PubScreen;

	ThisProcess = (struct Process *)FindTask(NULL);

	OldPtr = ThisProcess -> pr_WindowPtr;

	if(!(IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",37)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",37)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(GadToolsBase = OpenLibrary("gadtools.library",37)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(AslBase = OpenLibrary("asl.library",37)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!IconBase)
		IconBase = OpenLibrary("icon.library",37);

	if(!IconBase)
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(IFFParseBase = OpenLibrary("iffparse.library",37)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(PubScreen = LockPubScreen(NULL)))
	{
		ConCleanup();

		return(FALSE);
	}

	sprintf(ScreenTitle,"Amiga %s (%s)",VERS,DATE);

	if(!ProgramName)
	{
		if(WBenchMsg)
		{
			if(WBenchMsg -> sm_NumArgs > 1)
				ProgramName = FilePart(WBenchMsg -> sm_ArgList[1] . wa_Name);
			else
				ProgramName = FilePart(WBenchMsg -> sm_ArgList[0] . wa_Name);
		}
		else
			ProgramName = "Zorkmachine";
	}

	if(CustomScreen)
	{
		struct Rectangle	Overscan;
		ULONG			DisplayID = GetVPModeID(&PubScreen -> ViewPort);

		if(QueryOverscan(DisplayID,&Overscan,OSCAN_TEXT))
		{
			LONG	Width = Overscan . MaxX - Overscan . MinX + 1,
				NewWidth,
				FontWidth = GfxBase -> DefaultFont -> tf_XSize;

			NewWidth = (Width / FontWidth) * FontWidth;

			Overscan . MinX += (Width - NewWidth) >> 1;
			Overscan . MaxX -= (Width - NewWidth) >> 1;

			Screen = OpenScreenTags(NULL,
				SA_Title,	ScreenTitle,
				SA_Depth,	1,
				SA_ShowTitle,	TRUE,
				SA_Behind,	TRUE,
				SA_DisplayID,	DisplayID,
				SA_DClip,	&Overscan,
				SA_AutoScroll,	TRUE,
				SA_SysFont,	0,
			TAG_DONE);
		}
		else
		{
			Screen = OpenScreenTags(NULL,
				SA_Title,	ScreenTitle,
				SA_Depth,	1,
				SA_ShowTitle,	TRUE,
				SA_Behind,	TRUE,
				SA_DisplayID,	DisplayID,
				SA_Overscan,	OSCAN_TEXT,
				SA_AutoScroll,	TRUE,
				SA_SysFont,	0,
			TAG_DONE);
		}
	}
	else
		Screen = NULL;

	if(!Screen)
	{
		WorkbenchBase = OpenLibrary("workbench.library",37);

		if(Window = OpenWindowTags(NULL,
			WA_InnerWidth,		GfxBase -> DefaultFont -> tf_XSize * 80,
			WA_InnerHeight,		GfxBase -> DefaultFont -> tf_YSize * 25,
			WA_Left,		0,
			WA_Top,			PubScreen -> BarHeight + 1,
			WA_Title,		"Zorkmachine",
			WA_ScreenTitle,		ScreenTitle,
			WA_MaxWidth,		PubScreen -> Width,
			WA_MaxHeight,		PubScreen -> Height,
			WA_CloseGadget,		TRUE,
			WA_IDCMP,		IDCMP_CLOSEWINDOW | IDCMP_MENUPICK,
			WA_SimpleRefresh,	TRUE,
			WA_SizeGadget,		TRUE,
			WA_SizeBBottom,		TRUE,
			WA_DragBar,		TRUE,
			WA_DepthGadget,		TRUE,
			WA_RMBTrap,		TRUE,
			WA_Activate,		TRUE,
			WA_AutoAdjust,		TRUE,
			WA_CustomScreen,	PubScreen,
		TAG_DONE))
		{
			WindowLimits(Window,Window -> BorderLeft + Window -> BorderRight + GfxBase -> DefaultFont -> tf_XSize * 20,PubScreen -> WBorTop + PubScreen -> Font -> ta_YSize + 1 + Window -> BorderBottom + 4 * GfxBase -> DefaultFont -> tf_YSize,0,0);

			SetFont(Window -> RPort,GfxBase -> DefaultFont);

			AdjustTitle(ProgramName);
		}
	}
	else
	{
		Window = OpenWindowTags(NULL,
			WA_Width,		Screen -> Width,
			WA_Height,		Screen -> Height - (Screen -> BarHeight + 2),
			WA_Left,		0,
			WA_Top,			Screen -> BarHeight + 2,
			WA_IDCMP,		IDCMP_MENUPICK,
			WA_SimpleRefresh,	TRUE,
			WA_RMBTrap,		TRUE,
			WA_Activate,		TRUE,
			WA_Borderless,		TRUE,
			WA_Backdrop,		TRUE,
			WA_CustomScreen,	Screen,
		TAG_DONE);

		if(TwoColours[0] || TwoColours[1])
			LoadRGB4(&Screen -> ViewPort,TwoColours,2);
	}

	UnlockPubScreen(NULL,PubScreen);

	if(!Window)
	{
		ConCleanup();

		return(FALSE);
	}

	ThisProcess -> pr_WindowPtr = (APTR)Window;

	if(!(SaveRequest = AllocAslRequestTags(ASL_FileRequest,
		ASL_LeftEdge,	Window -> Width >> 2,
		ASL_TopEdge,	Window -> Height >> 2,
		ASL_Width,	Window -> Width >> 1,
		ASL_Height,	Window -> Height >> 1,
		ASL_Window,	Window,
		ASL_Hail,	"Save as...",
		ASL_OKText,	"Save",
		ASL_File,	"Story.Save",
		ASL_FuncFlags,	FILF_SAVE | FILF_NEWIDCMP,
	TAG_DONE)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(RestoreRequest = AllocAslRequestTags(ASL_FileRequest,
		ASL_LeftEdge,	Window -> Width >> 2,
		ASL_TopEdge,	Window -> Height >> 2,
		ASL_Width,	Window -> Width >> 1,
		ASL_Height,	Window -> Height >> 1,
		ASL_Window,	Window,
		ASL_Hail,	"Restore...",
		ASL_OKText,	"Restore",
		ASL_File,	"Story.Save",
		ASL_FuncFlags,	FILF_NEWIDCMP,
	TAG_DONE)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!GetCurrentDirName(SharedBuffer,256))
		SharedBuffer[0] = 0;

	if(!(ProtocolRequest = AllocAslRequestTags(ASL_FileRequest,
		ASL_LeftEdge,	Window -> Width >> 2,
		ASL_TopEdge,	Window -> Height >> 2,
		ASL_Width,	Window -> Width >> 1,
		ASL_Height,	Window -> Height >> 1,
		ASL_Window,	Window,
		ASL_Hail,	"Select protocol file",
		ASL_OKText,	"Select",
		ASL_File,	"Story.Protocol",
		ASL_Dir,	SharedBuffer,
		ASL_FuncFlags,	FILF_SAVE | FILF_NEWIDCMP,
	TAG_DONE)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(WorkbenchBase)
	{
		if(WorkbenchPort = CreateMsgPort())
			WorkbenchWindow = AddAppWindow(0,0,Window,WorkbenchPort,NULL);
	}

	if(!(VisualInfo = GetVisualInfo(Window -> WScreen,TAG_DONE)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(MachineMenu = CreateMenus(MachineMenuConfig,
		GTMN_FrontPen,	0,
	TAG_DONE)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(LayoutMenus(MachineMenu,VisualInfo,
		GTMN_TextAttr,	Window -> WScreen -> Font,
	TAG_DONE)))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(ConReadPort = CreateMsgPort()))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(ConWritePort = CreateMsgPort()))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(ConReadRequest = (struct IOStdReq *)CreateIORequest(ConReadPort,sizeof(struct IOStdReq))))
	{
		ConCleanup();

		return(FALSE);
	}

	if(!(ConWriteRequest = (struct IOStdReq *)CreateIORequest(ConWritePort,sizeof(struct IOStdReq))))
	{
		ConCleanup();

		return(FALSE);
	}

	ConReadRequest -> io_Data	= Window;
	ConReadRequest -> io_Length	= sizeof(struct Window);

	if(OpenDevice("console.device",CONU_SNIPMAP,(struct IORequest *)ConReadRequest,CONFLAG_DEFAULT))
	{
		ConCleanup();

		return(FALSE);
	}

	CopyMem(ConReadRequest,ConWriteRequest,sizeof(struct IOStdReq));

	ConWriteRequest -> io_Message . mn_ReplyPort = ConWritePort;

	SetMenuStrip(Window,MachineMenu);

	Forbid();

	strcpy(DefaultFontName,GfxBase -> DefaultFont -> tf_Message . mn_Node . ln_Name);

	DefaultFont . ta_Name	= DefaultFontName;
	DefaultFont . ta_YSize	= GfxBase -> DefaultFont -> tf_YSize;
	DefaultFont . ta_Style	= GfxBase -> DefaultFont -> tf_Style;
	DefaultFont . ta_Flags	= GfxBase -> DefaultFont -> tf_Flags & ~FPF_REMOVED;

	DefaultFontWidth = GfxBase -> DefaultFont -> tf_XSize;

	Permit();

	if(!CreateSpeech())
		OffMenu(Window,FULLMENUNUM(2,9,NOSUB));

	if(!Screen)
		OffMenu(Window,FULLMENUNUM(0,6,NOSUB));

	Window -> Flags &= ~WFLG_RMBTRAP;

        ScreenToFront(Window -> WScreen);

	return(TRUE);
}
