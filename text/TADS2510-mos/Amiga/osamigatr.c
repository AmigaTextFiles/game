/*
 * OS-dependent module for Amiga run-time.
 *
 * Jan-Erik Karlsson
*/

#include <ctype.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "os.h"
#include "osgen.h"
#include "trd.h"
#include "voc.h"

#define COLOUR_NORMAL  0
#define COLOUR_REVERSE 1
#define COLOUR_BOLD    2

int InputX,InputY;
int UseScreen = 1;

#include <clib/asl_protos.h>
#include <clib/diskfont_protos.h>
#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/graphics_protos.h>
#include <clib/icon_protos.h>
#include <clib/intuition_protos.h>
#include <exec/exec.h>
#include <graphics/videocontrol.h>
#include <workbench/startup.h>

#define TEXTBUFFER_SIZE 256
#define QUALIFIER_SHIFT (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT)

struct NewMenu NewMenus[] =
 {{ NM_TITLE,"Project",0,0,0,0 },
	{ NM_ITEM,"About...","?",0,0,0 },
	{ NM_ITEM,"Quit","Q",0,0,0 },
	{ NM_END,0,0,0,0,0 }};
struct TextAttr ScreenFont = { NULL,8,FS_NORMAL,0 };

char TitleBar[] = "MorphOS TADS 2.5.10";
char SwapDir[256];
char SwapName[256];
osfildef* SwapFile = NULL;
unsigned char TextBuffer[TEXTBUFFER_SIZE];
unsigned long TextBufferPtr;

extern struct Library *IntuitionBase;
extern struct GfxBase *GfxBase;
struct DiskObject *Icon;
struct Screen *Screen;
struct Window *Window;
struct Window *OldWindowPtr;
struct RastPort *RastPort;
struct Menu *Menus;
struct FileRequester *FileRequester;
struct Process *ThisProcess;
struct WBStartup *WBMessage;
struct TextFont *FixedFont;
APTR Visual;
BPTR StartLock,OldDir;
ULONG ScreenMode;

void os_waitc(void);
void amiga_init(void);
void amiga_exit(void);
void amiga_putchar(int c);
void amiga_flush(void);
void amiga_about(void);
void amiga_cursor(void);
void amiga_clr(int x1,int y1,int x2,int y2,int col);
void amiga_scrollup(int x1,int y1,int x2,int y2,int col);
void amiga_scrolldown(int x1,int y1,int x2,int y2,int col);
void amiga_colour(int colour);
void amiga_move(int x,int y);
int amiga_filereq(char *buffer,int buflen,...);

int os_askfile(const char *prompt, char *fname_buf, int fname_buf_len, int prompt_type, int file_type)
{
	if (prompt_type == OS_AFP_SAVE)
	{
		return amiga_filereq(fname_buf,fname_buf_len,
			ASLFR_Window,Window,
			ASLFR_TitleText,"Save",
			ASLFR_DoSaveMode,1,TAG_DONE);
	}
	else if (prompt_type == OS_AFP_OPEN)
	{
		return amiga_filereq(fname_buf,fname_buf_len,
			ASLFR_Window,Window,
			ASLFR_TitleText,"Restore",
			ASLFR_DoSaveMode,0,TAG_DONE);
	}
	return OS_AFE_FAILURE;
}

int os_init(int *argc, char *argv[], const char *prompt, char *buf, int bufsiz)
{
	amiga_init();

	sdesc_color = COLOUR_REVERSE;
	text_color  = COLOUR_NORMAL;

	osssbini(32767*8);
	status_mode = 1;
	os_printz("TADS");
	status_mode = 0;
	os_score(0,0);

	return 0;
}

void os_term(int status)
{
	osssbdel();
	os_printz("\n[Strike a key to exit.]");
	os_waitc();
	amiga_exit();
	exit(status);
}

void os_waitc(void)
{
	amiga_getkey(0);
}

int os_getc(void)
{
	int key = amiga_getkey(0);
	return key;
}

void ossdsp(int y, int x, int color, const char *msg)
{
int i;

	amiga_move(x,y);
	amiga_colour(color);
	for (i = 0; i < strlen(msg); i++) amiga_putchar(*(msg+i));
}

void ossclr(int top, int left, int bottom, int right, int blank_color)
{
	amiga_clr(left,top,right,bottom,blank_color);
}

void ossscu(int top, int left, int bottom, int right, int blank_color)
{
	amiga_scrolldown(left,top,right,bottom,blank_color);
}

void ossscr(int top, int left, int bottom, int right, int blank_color)
{
	amiga_scrollup(left,top,right,bottom,blank_color);
}

void ossloc(int row, int col)
{
	InputX = col;
	InputY = row;
}

void amiga_move(int x,int y)
{
	amiga_flush();
	Move(RastPort,Window->BorderLeft+(x*RastPort->TxWidth),
		Window->BorderTop+(y*RastPort->TxHeight));
}

void amiga_putchar(int c)
{
	if (TextBufferPtr == TEXTBUFFER_SIZE) amiga_flush();
	*(TextBuffer+(TextBufferPtr++)) = c;
}

void amiga_init(void)
{
	char* tooltype;
	char prog_name[256];
	ULONG id = INVALID_ID;
	struct NameInfo name;
	char font_name[MAXFONTPATH];
	char *name_ptr;
	struct TextAttr topaz8 = { "topaz.font",8,FS_NORMAL,0 };
	struct Screen *def_pub_scr;
	static WORD pens[] = { -1 };

	if (IntuitionBase->lib_Version < 37)
	{
		amiga_exit();
		exit(0);
	}

	if (Icon == NULL)
	{
		if (GetProgramName(prog_name,256))
			Icon = GetDiskObject(prog_name);
	}

	if (Icon)
	{
		if (tooltype = FindToolType(Icon->do_ToolTypes,"SWAPDIR"))
			strcpy(SwapDir,tooltype);

		if (FindToolType(Icon->do_ToolTypes,"WINDOW"))
			UseScreen = 0;

		if (tooltype = FindToolType(Icon->do_ToolTypes,"SCREENMODE"))
		{
			while ((id = NextDisplayInfo(id)) != INVALID_ID)
			{
	if (GetDisplayInfoData(NULL,(UBYTE *)&name,sizeof(struct NameInfo),
	  DTAG_NAME,id))
	{
	  if (stricmp(tooltype,name.Name) == 0)
						ScreenMode = id;
	}
			}
		}

		if (tooltype = FindToolType(Icon->do_ToolTypes,"FONT"))
		{
			strcpy(font_name,tooltype);
			if (name_ptr = strrchr(font_name,'/'))
			{
	ScreenFont.ta_Name = font_name;
	ScreenFont.ta_YSize = atoi(name_ptr+1);
	strcpy(name_ptr,".font");
			}
		}
		if (ScreenFont.ta_Name)
			FixedFont = OpenDiskFont(&ScreenFont);

		if (FixedFont)
		{
			if (FixedFont->tf_Flags & FPF_PROPORTIONAL)
			{
	CloseFont(FixedFont);
	FixedFont = NULL;
			}
		}
	}

	if (FixedFont == NULL)
		FixedFont = OpenFont(&topaz8);

	if ((def_pub_scr = LockPubScreen(0)) == 0)
	{
		amiga_exit();
		exit(1);
	}
	
	if (UseScreen)
	{
		Screen = OpenScreenTags(0,
			SA_Interleaved,1,
			SA_Pens,pens,
			SA_DisplayID,ScreenMode ? ScreenMode :
				GetVPModeID(&def_pub_scr->ViewPort),
			SA_Overscan,OSCAN_TEXT,
			SA_Depth,2,
			SA_Type,CUSTOMSCREEN|AUTOSCROLL,
			SA_Title,TitleBar,
			SA_Font,&ScreenFont,
			TAG_DONE);
		if (Screen == 0)
		{
			amiga_exit();
			exit(1);
		}

		if ((Window = OpenWindowTags(0,
			WA_Left,0,
			WA_Top,2,
			WA_Width,Screen->Width,
			WA_Height,Screen->Height-2,
			WA_SmartRefresh,1,
			WA_NewLookMenus,1,
			WA_Borderless,1,
			WA_Backdrop,1,
			WA_Activate,1,
			WA_Title,TitleBar,
			WA_ScreenTitle,TitleBar,
			WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_RAWKEY|IDCMP_MENUPICK,
			WA_CustomScreen,Screen,
			TAG_DONE)) == 0)
			{
				amiga_exit();
				exit(1);
			}
	}
	else
	{
		int ScrWidth = def_pub_scr->Width;
		int ScrHeight = def_pub_scr->Height;

		struct TagItem vti[] =
			{ VTAG_VIEWPORTEXTRA_GET,0,
				VTAG_END_CM,0 };
		struct ViewPortExtra *vpe;

		if (def_pub_scr->ViewPort.ColorMap)
		{
			if (VideoControl(def_pub_scr->ViewPort.ColorMap,vti) == 0)
			{
				int w,h;

				vpe = (struct ViewPortExtra *)vti[0].ti_Data;
				w = vpe->DisplayClip.MaxX - vpe->DisplayClip.MinX + 1;
				h = vpe->DisplayClip.MaxY - vpe->DisplayClip.MinY + 1;
				if ((w > 1) && (h > 1))
				{
	  ScrWidth = w;
	  ScrHeight = h;
	}
			}
		}

		if ((Window = OpenWindowTags(0,
			WA_Left,0,
			WA_Top,def_pub_scr->BarHeight+1,
			WA_Width,ScrWidth,
			WA_Height,ScrHeight-def_pub_scr->BarHeight-1,
			WA_SmartRefresh,1,
			WA_CloseGadget,1,
			WA_DragBar,1,
			WA_DepthGadget,1,
			WA_SizeGadget,1,
			WA_SizeBBottom,1,
			WA_NewLookMenus,1,
			WA_Activate,1,
			WA_Title,TitleBar,
			WA_ScreenTitle,TitleBar,
			WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_RAWKEY|IDCMP_MENUPICK|IDCMP_CLOSEWINDOW|IDCMP_NEWSIZE,
			TAG_DONE)) == 0)
			{
				amiga_exit();
				exit(1);
			}
	}

	ThisProcess = (struct Process *)FindTask(0);
	OldWindowPtr = ThisProcess->pr_WindowPtr;
	ThisProcess->pr_WindowPtr = Window;

	if ((Visual = GetVisualInfo(Window->WScreen,TAG_DONE)) == 0)
	{
		amiga_exit();
		exit(1);
	}
	if ((Menus = CreateMenus(NewMenus,GTMN_NewLookMenus,TRUE,TAG_DONE)) == 0)
	{
		amiga_exit();
		exit(1);
	}

	LayoutMenus(Menus,Visual,GTMN_NewLookMenus,TRUE,TAG_DONE);
	SetMenuStrip(Window,Menus);

	RastPort = Window->RPort;
	SetDrMd(RastPort,JAM2);
	SetAPen(RastPort,1);
	SetBPen(RastPort,0);

	UnlockPubScreen(0,def_pub_scr);

	G_oss_screen_width = (Window->Width-Window->BorderLeft-Window->BorderRight)/RastPort->TxWidth;
	G_oss_screen_height = (Window->Height-Window->BorderTop-Window->BorderBottom)/RastPort->TxHeight;
}

void amiga_rect(struct RastPort *rp,long xMin,long yMin,long xMax,long yMax,unsigned long pen)
{
unsigned long saved_pen;

	saved_pen = rp->FgPen;
	SetAPen(rp,pen);
	if (xMax > Window->Width-Window->BorderRight-1) xMax = Window->Width-Window->BorderRight-1;
	if (yMax > Window->Height-Window->BorderBottom-1) yMax = Window->Height-Window->BorderBottom-1;
	RectFill(rp,xMin,yMin,xMax,yMax);
	SetAPen(rp,saved_pen);
}

void amiga_flush(void)
{
static int semaphore;
int max;

	if (semaphore)
		return;
	semaphore = 1;

	max = (Window->Width-Window->BorderRight-RastPort->cp_x)/RastPort->TxWidth;
	if (TextBufferPtr > max)
		TextBufferPtr = max;
	if (TextBufferPtr > 0)
	{
		Move(RastPort,RastPort->cp_x,RastPort->cp_y+RastPort->TxBaseline);
		Text(RastPort,TextBuffer,TextBufferPtr);
		Move(RastPort,RastPort->cp_x,RastPort->cp_y-RastPort->TxBaseline);
	}
	TextBufferPtr = 0;

	semaphore = 0;
}

void amiga_resize(void)
{
	G_oss_screen_width = (Window->Width-Window->BorderLeft-Window->BorderRight)/RastPort->TxWidth;
	G_oss_screen_height = (Window->Height-Window->BorderTop-Window->BorderBottom)/RastPort->TxHeight;

	amiga_rect(RastPort,
		Window->BorderLeft,Window->BorderTop+(G_oss_screen_height*RastPort->TxHeight),
		Window->Width-Window->BorderRight-1,Window->Height-Window->BorderBottom-1,0);
	amiga_rect(RastPort,
		Window->BorderLeft+(G_oss_screen_width*RastPort->TxWidth),Window->BorderTop,
		Window->Width-Window->BorderRight-1,Window->Height-Window->BorderBottom-1,0);

	osssb_on_resize_screen();
}

#define PORTSIG(port) (1<<((struct MsgPort *)(port))->mp_SigBit)

int amiga_getkey(int raw)
{
struct IntuiMessage *imsg;
ULONG class, port_signals;
UWORD code, qualifier;
static int special = 0;

	WindowLimits(Window,64,64,~0,~0);
	amiga_move(InputX,InputY);
	if (special != 0)
	{
	int sending;

		sending = special;
		special = 0;
		return sending;
	}
	amiga_cursor();

	port_signals = PORTSIG(Window->UserPort);
	while(1)
	{
		while(imsg = (struct IntuiMessage *)GetMsg(Window->UserPort))
		{
			class = imsg->Class;
			code = imsg->Code;
			qualifier = imsg->Qualifier;
			ReplyMsg((struct Message *)imsg);
			switch(class)
			{
				case IDCMP_VANILLAKEY:
					switch (code)
					{
						case 127:
							special = (qualifier & QUALIFIER_SHIFT) ? CMD_DEOL : CMD_DEL;
							amiga_cursor();
							return 0;
						default:
							amiga_cursor();
							return code;
					}
				break;
				case IDCMP_MENUPICK:
					if (MENUNUM(code) == 0)
					{
						switch (ITEMNUM(code))
						{
							case 0:
								amiga_about();
							break;
							case 1:
								amiga_exit();
								exit(0);
							break;
						}
					}
				break;
				case IDCMP_RAWKEY:
					switch (code)
					{
						case 0x4C:
							special = CMD_UP;
							if (qualifier & QUALIFIER_SHIFT) special = CMD_PGUP;
							if (qualifier & IEQUALIFIER_CONTROL) special = CMD_TOP;
							amiga_cursor();
							return 0;
						case 0x4D:
							special = CMD_DOWN;
							if (qualifier & QUALIFIER_SHIFT) special = CMD_PGDN;
							if (qualifier & IEQUALIFIER_CONTROL) special = CMD_BOT;
							amiga_cursor();
							return 0;
						case 0x4F:
							special = (qualifier & QUALIFIER_SHIFT) ? CMD_HOME : CMD_LEFT;
							amiga_cursor();
							return 0;
						case 0x4E:
							special = (qualifier & QUALIFIER_SHIFT) ? CMD_END : CMD_RIGHT;
							amiga_cursor();
							return 0;
						case 0x50:
							special = raw ? CMD_F1 : CMD_SCR;
							amiga_cursor();
							return 0;
						case 0x51:
							special = (qualifier & QUALIFIER_SHIFT) ? CMD_SF2 : CMD_F2;
							amiga_cursor();
							return 0;
						case 0x52:
							special = CMD_F3;
							amiga_cursor();
							return 0;
						case 0x53:
							special = CMD_F4;
							amiga_cursor();
							return 0;
						case 0x54:
							special = CMD_F5;
							amiga_cursor();
							return 0;
						case 0x55:
							special = CMD_F6;
							amiga_cursor();
							return 0;
						case 0x56:
							special = CMD_F7;
							amiga_cursor();
							return 0;
						case 0x57:
							special = CMD_F8;
							amiga_cursor();
							return 0;
						case 0x58:
							special = CMD_F9;
							amiga_cursor();
							return 0;
						case 0x59:
							special = CMD_F10;
							amiga_cursor();
							return 0;
					}
				break;
				case IDCMP_CLOSEWINDOW:
					amiga_exit();
					exit(0);
				break;
				case IDCMP_NEWSIZE:
					amiga_resize();
				break;
			}
		}
		Wait(port_signals);
	}
}

void amiga_cursor(void)
{
BYTE saved_draw_mode;

	amiga_flush();
	saved_draw_mode = RastPort->DrawMode;
	SetDrMd(RastPort,COMPLEMENT);
	amiga_rect(RastPort,
		RastPort->cp_x,
		RastPort->cp_y,
		RastPort->cp_x+RastPort->TxWidth-1,
		RastPort->cp_y+RastPort->TxHeight-1,0);
	SetDrMd(RastPort,saved_draw_mode);
}

void amiga_about(void)
{
	amiga_req(Window,
		"MorphOS TADS Run-time interpreter\n"
		"TADS 2.5.10 © 1993-2002 by Michael J. Roberts\n"
		"MorphOS version written by Jan-Erik Karlsson","Continue");
}

void amiga_busy(struct Window *window,int busy)
{
	if ((IntuitionBase->lib_Version >= 39) && (window))
		SetWindowPointer(window,WA_BusyPointer,busy,TAG_DONE);
}

LONG amiga_req(struct Window *window,UBYTE *text,UBYTE *gadgets,...)
{
	va_list arguments;
	LONG return_value;
	static struct EasyStruct requester = { sizeof(struct EasyStruct),0,"TADS",0,0 };

	requester.es_TextFormat = text;
	requester.es_GadgetFormat = gadgets;
	va_start(arguments,gadgets);
		amiga_busy(window,1);
		return_value = EasyRequestArgs(window,&requester,0,arguments);
		amiga_busy(window,0);
	va_end(arguments);
}

void amiga_early(void)
{
	strcpy(SwapDir,"T:");
}

void amiga_exit(void)
{
	amiga_flush();

	if (SwapFile)
	{
		osfcls(SwapFile);
		osfdel(SwapName);
	}

	if (Menus) FreeMenus(Menus);
	if (Visual) FreeVisualInfo(Visual);
	if (ThisProcess) ThisProcess->pr_WindowPtr = OldWindowPtr;
	if (Window) CloseWindow(Window);
	if (Screen) CloseScreen(Screen);
	if (FileRequester) FreeAslRequest(FileRequester);
	if (Icon) FreeDiskObject(Icon);
	if (FixedFont) CloseFont(FixedFont);
	if (StartLock)
	{
		CurrentDir(OldDir);
		UnLock(StartLock);
	}
}

void amiga_clr(int x1,int y1,int x2,int y2,int col)
{
int last;

	amiga_flush();
	last = Window->BorderTop+((y2+1)*RastPort->TxHeight);
	if (last > Window->Height-Window->BorderBottom)
		last = Window->Height-Window->BorderBottom;
	amiga_rect(RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+(y1*RastPort->TxHeight),
		Window->BorderLeft+(x2*RastPort->TxWidth)-1,
		last-1,
		col != COLOUR_REVERSE ? 0 : 3);
}

void amiga_scrollup(int x1,int y1,int x2,int y2,int col)
{
	amiga_flush();
	ClipBlit(RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+((y1+1)*RastPort->TxHeight),
		RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+(y1*RastPort->TxHeight),
		((x2-x1+1)*RastPort->TxWidth),
		((y2-y1)*RastPort->TxHeight),0xC0);
	amiga_rect(RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+(y2*RastPort->TxHeight),
		Window->BorderLeft+((x2+1)*RastPort->TxWidth)-1,
		Window->BorderTop+((y2+1)*RastPort->TxHeight)-1,
		col != COLOUR_REVERSE ? 0 : 3);
}

void amiga_scrolldown(int x1,int y1,int x2,int y2,int col)
{
	amiga_flush();
	ClipBlit(RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+(y1*RastPort->TxHeight),
		RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+((y1+1)*RastPort->TxHeight),
		((x2-x1+1)*RastPort->TxWidth),
		((y2-y1)*RastPort->TxHeight),0xC0);
	amiga_rect(RastPort,
		Window->BorderLeft+(x1*RastPort->TxWidth),
		Window->BorderTop+(y1*RastPort->TxHeight),
		Window->BorderLeft+((x2+1)*RastPort->TxWidth)-1,
		Window->BorderTop+((y1+1)*RastPort->TxHeight)-1,
		col != COLOUR_REVERSE ? 0 : 3);
}

void amiga_colour(int colour)
{
	switch (colour)
	{
		case COLOUR_NORMAL:
			SetAPen(RastPort,1);
			SetBPen(RastPort,0);
			break;
		case COLOUR_REVERSE:
			SetAPen(RastPort,2);
			SetBPen(RastPort,3);
			break;
		case COLOUR_BOLD:
			SetAPen(RastPort,2);
			SetBPen(RastPort,0);
			break;
	}
}

int amiga_filereq(char *buffer,int buflen,...)
{
va_list arguments;
LONG asl_return;

	if (FileRequester == 0)
	{
		if ((FileRequester = AllocAslRequestTags(ASL_FileRequest,
			ASLFR_SleepWindow,1,
			ASLFR_RejectIcons,1,TAG_DONE)) == 0)
		{
			amiga_exit();
			exit(1);
		}
	}

	va_start(arguments,buflen);
	asl_return = AslRequest(FileRequester,arguments);
	va_end(arguments);

	if (asl_return)
	{
		strncpy(buffer,FileRequester->fr_Drawer,buflen);
		AddPart(buffer,FileRequester->fr_File,buflen);
		return OS_AFE_SUCCESS;
	}
	return OS_AFE_CANCEL;
}

wbmain(struct WBStartup *wbmsg)
{
	extern struct Library *IntuitionBase;
	char *args[2], *tooltype, dir[256], game[256];

	if (IntuitionBase->lib_Version < 37)
	{
		amiga_exit();
		exit(0);
	}

	args[0] = wbmsg->sm_ArgList[0].wa_Name;
	args[1] = game;

	if (wbmsg->sm_NumArgs > 1)
	{
		if (wbmsg->sm_ArgList[1].wa_Lock)
			CurrentDir(wbmsg->sm_ArgList[1].wa_Lock);
		strcpy(game,wbmsg->sm_ArgList[1].wa_Name);
		main(2,args);
	}
	else
	{
		strcpy(dir,"");
		if (Icon = GetDiskObject(args[0]))
		{
			if (tooltype = FindToolType(Icon->do_ToolTypes,"DIR"))
				strcpy(dir,tooltype);
		}
		if (amiga_filereq(game,256,
			ASLFR_TitleText,"Select a TADS Game",
			ASLFR_DoPatterns,1,
			ASLFR_InitialPattern,"#?.gam",
			ASLFR_InitialDrawer,dir,TAG_DONE) == 0)
		{
			if (StartLock = Lock(FileRequester->fr_Drawer,ACCESS_READ))
				OldDir = CurrentDir(StartLock);
			strcpy(game,FileRequester->fr_File);
			FreeAslRequest(FileRequester);
			FileRequester = 0;
			main(2,args);
		}
	}
	amiga_exit();
	exit(0);
}

char *strlwr(char *s)
{
	char *s1 = s;

	while (*s)
	{
		if (isupper(*s))
			*s = tolower(*s);
		s++;
	}
	return s1;
}

char *os_strlwr(char *s)
{
	return strlwr(s);
}

void os_get_tmp_path(char *s)
{
	strcpy(s,SwapDir);
}

void os_defext(char *fn, const char *ext)
{
	char *p;

	p = fn+strlen(fn);
	while (p > fn)
	{
		p--;
		if ( *p=='.' ) return;
		if ( *p=='/' || *p==':') break;
	}
	strcat(fn,".");
	strlwr(ext);
	strcat(fn,ext);
}

void os_remext(char *fn)
{
	char *p = fn+strlen(fn);

	while (p > fn)
	{
		p--;
		if ( *p=='.' )
		{
			*p = '\0';
			return;
		}
		if ( *p=='/' || *p==':') return;
	}
}

int memicmp(char* s1, char* s2, int len)
{
	char *x1, *x2;
	int result;
	int i;

	x1 = malloc(len);
	x2 = malloc(len);

	if (!x1 || !x2)
	{
		amiga_exit();
		exit(-1);
	}

	for (i = 0; i < len; i++)
	{
		if (isupper(s1[i]))
			x1[i] = tolower(s1[i]);
		else
			x1[i] = s1[i];

		if (isupper(s2[i]))
			x2[i] = tolower(s2[i]);
		else
			x2[i] = s2[i];
	}

	result = memcmp(x1,x2,len);
	free(x1);
	free(x2);
	return result;
}

osfildef *os_exeseek(const char *exefile, const char *typ)
{
	return (osfildef *)0;
}

int os_break(void)
{
	return 0;
}

int os_paramfile(char *buf)
{
	return 0;
}

osfildef *os_create_tempfile(const char *swapname, char *buf)
{
	osfildef *fp;

	if (swapname == 0)
	{
		int try;
		size_t len;
		time_t timer;
		int found;

		os_get_tmp_path(buf);
		len = strlen(buf);

		time(&timer);

		for (try = 0, found = FALSE; try < 100; ++try)
		{
			sprintf(buf + len, "SW%06ld.%03d", (long)timer % 999999, try);

			if (osfacc(buf))
			{
				found = TRUE;
				break;
			}
		}

		if (!found)
			return 0;

		swapname = buf;
	}

	fp = osfoprwtb(swapname, OSFTSWAP);
	os_settype(swapname, OSFTSWAP);

	strcpy(SwapName,swapname);
	SwapFile = fp;
	return fp;
}

#ifdef USE_TIMERAND
void os_rand(long *seed)
{
	time_t t;

	time(&t);
	*seed = (long)t;
}
#endif

void os_tzset()
{
}

#ifdef USE_NULLSTYPE
void os_settype(const char *f, int t)
{
}
#endif

void os_fprintf(osfildef *fp, const char *f, ...)
{
	va_list argptr;

	va_start(argptr, f);
	vfprintf(fp, f, argptr);
	va_end(argptr);
}

void os_vfprintf(osfildef *fp, const char *fmt, va_list argptr)
{
	vfprintf(fp, fmt, argptr);
}

int os_locate(const char *fname, int flen, const char *arg0, char *buf, size_t bufsiz)
{
	if (osfacc(fname) == 0)
	{
		memcpy(buf, fname, flen);
		buf[flen] = 0;
		return(1);
	}

	if (arg0 && *arg0)
	{
		char *p;

		for ( p = arg0 + strlen(arg0);
			p > arg0 && *(p-1) != OSPATHCHAR && !strchr(OSPATHALT, *(p-1));
			--p);

		if (p > arg0)
		{
			size_t len = (size_t)(p - arg0);

			memcpy(buf, arg0, len);
			memcpy(buf+len, fname, flen);
			buf[len+flen] = 0;
			if (osfacc(buf) == 0) return(1);
		}
	}

	return(0);
}

char *osfgets(char *s, int n, osfildef *fp)
{
	char  c, *s0 = s;

	if (n <= 1)
	{
		if (n == 1) *s++ = '\0';
		return s0;
	}

	while ((c = fgetc(fp)) != EOF)
	{
		*s++ = c;
		if (c == '\n' || c == '\r' || --n <= 1)
		{
			if (n >= 1) *s++ = '\0';
			return s0;
		}
	}

	if (ferror(fp))
		return NULL;
	else
	{
		if (s == s0)
			return NULL;
		else
		{
			if (n >= 1) *s++ = '\0';
			return s0;
		}
	}
}

#ifdef fopen
#undef fopen
#endif

void *our_memcpy(void *dst, const void *src, size_t size)
{
register char *d;
register const char *s;
register size_t n;

	if (size == 0) return(dst);

	s = src;
	d = dst;
	if ((char *)s <= d && (char *)s + (size-1) >= d)
	{
		s += size-1;
		d += size-1;
		for (n = size; n > 0; n--) *d-- = *s--;
	}
	else
		for (n = size; n > 0; n--) *d++ = *s++;

	return(dst);
}

FILE *our_fopen(filename, flags)
char *filename;
char *flags;
{
	return fopen(filename,flags);
}

char *os_get_root_name(char *buf)
{
	char *rootname;

	for (rootname = buf; *buf != '\0'; ++buf)
	{
		switch(*buf)
		{
			case '/':
			case ':':
				rootname = buf + 1;
			break;
			default:
			break;
		}
	}
	return rootname;
}

void os_addext(char *fn, const char *ext)
{
	strcat(fn,".");
	strcat(fn,ext);
}

void os_xlat_html4(unsigned int html4_char, char *result, size_t result_len)
{
	/* default character to use for unknown characters */
#define INV_CHAR "·"

	/* 
	 *   Translation table - provides mappings for characters the ISO
	 *   Latin-1 subset of the HTML 4 character map (values 128-255).
	 *   Characters marked "(not used)" are not used by HTML '&' markups.  
	 */
	static const char *xlat_tbl[] =
	{
		INV_CHAR,                                         /* 128 (not used) */
		INV_CHAR,                                         /* 129 (not used) */
		"'",                                                 /* 130 - sbquo */
		INV_CHAR,                                         /* 131 (not used) */
		"\"",                                                /* 132 - bdquo */
		INV_CHAR,                                         /* 133 (not used) */
		INV_CHAR,                                           /* 134 - dagger */
		INV_CHAR,                                           /* 135 - Dagger */
		INV_CHAR,                                         /* 136 (not used) */
		INV_CHAR,                                           /* 137 - permil */
		INV_CHAR,                                         /* 138 (not used) */
		"<",                                                /* 139 - lsaquo */
		"OE",                                                /* 140 - OElig */
		INV_CHAR,                                         /* 141 (not used) */
		INV_CHAR,                                         /* 142 (not used) */
		INV_CHAR,                                         /* 143 (not used) */
		INV_CHAR,                                         /* 144 (not used) */
		"'",                                                 /* 145 - lsquo */
		"'",                                                 /* 146 - rsquo */
		"\"",                                                /* 147 - ldquo */
		"\"",                                                /* 148 - rdquo */
		INV_CHAR,                                         /* 149 (not used) */
		"-",                                                /* 150 - endash */
		"-",                                                /* 151 - emdash */
		INV_CHAR,                                         /* 152 (not used) */
		"(tm)",                                              /* 153 - trade */
		INV_CHAR,                                         /* 154 (not used) */
		">",                                                /* 155 - rsaquo */
		"oe",                                                /* 156 - oelig */
		INV_CHAR,                                         /* 157 (not used) */
		INV_CHAR,                                         /* 158 (not used) */
		"Y",                                                  /* 159 - Yuml */
		INV_CHAR,                                         /* 160 (not used) */
		"¡",                                                 /* 161 - iexcl */
		"¢",                                                  /* 162 - cent */
		"£",                                                 /* 163 - pound */
		INV_CHAR,                                           /* 164 - curren */
		"¥",                                                   /* 165 - yen */
		"|",                                                /* 166 - brvbar */
		INV_CHAR,                                             /* 167 - sect */
		INV_CHAR,                                              /* 168 - uml */
		"©",                                                  /* 169 - copy */
		"ª",                                                  /* 170 - ordf */
		"«",                                                 /* 171 - laquo */
		"¬",                                                   /* 172 - not */
		" ",                                                   /* 173 - shy */
		"®",                                                   /* 174 - reg */
		INV_CHAR,                                             /* 175 - macr */
		"°",                                                   /* 176 - deg */
		"±",                                                /* 177 - plusmn */
		"²",                                                  /* 178 - sup2 */
		"³",                                                  /* 179 - sup3 */
		"'",                                                 /* 180 - acute */
		"µ",                                                 /* 181 - micro */
		INV_CHAR,                                             /* 182 - para */
		"·",                                                /* 183 - middot */
		",",                                                 /* 184 - cedil */
		"¹",                                                  /* 185 - sup1 */
		"º",                                                  /* 186 - ordm */
		"»",                                                 /* 187 - raquo */
		"¼",                                                /* 188 - frac14 */
		"½",                                                /* 189 - frac12 */
		"¾",                                                /* 190 - frac34 */
		"¿",                                                /* 191 - iquest */
		"À",                                                /* 192 - Agrave */
		"Á",                                                /* 193 - Aacute */
		"Â",                                                 /* 194 - Acirc */
		"Ã",                                                /* 195 - Atilde */
		"Ä",                                                  /* 196 - Auml */
		"Å",                                                 /* 197 - Aring */
		"Æ",                                                 /* 198 - AElig */
		"Ç",                                                /* 199 - Ccedil */
		"È",                                                /* 200 - Egrave */
		"É",                                                /* 201 - Eacute */
		"Ê",                                                 /* 202 - Ecirc */
		"Ë",                                                  /* 203 - Euml */
		"Ì",                                                /* 204 - Igrave */
		"Í",                                                /* 205 - Iacute */
		"Î",                                                 /* 206 - Icirc */
		"Ï",                                                  /* 207 - Iuml */
		"Ð",                                                   /* 208 - ETH */
		"Ñ",                                                /* 209 - Ntilde */
		"Ò",                                                /* 210 - Ograve */
		"Ó",                                                /* 211 - Oacute */
		"Ô",                                                 /* 212 - Ocirc */
		"Õ",                                                /* 213 - Otilde */
		"Ö",                                                  /* 214 - Ouml */
		"×",                                                 /* 215 - times */
		"Ø",                                                /* 216 - Oslash */
		"Ù",                                                /* 217 - Ugrave */
		"Ú",                                                /* 218 - Uacute */
		"Û",                                                 /* 219 - Ucirc */
		"Ü",                                                  /* 220 - Uuml */
		"Ý",                                                /* 221 - Yacute */
		"Þ",                                                 /* 222 - THORN */
		"ß",                                                 /* 223 - szlig */
		"à",                                                /* 224 - agrave */
		"á",                                                /* 225 - aacute */
		"â",                                                 /* 226 - acirc */
		"ã",                                                /* 227 - atilde */
		"ä",                                                  /* 228 - auml */
		"å",                                                 /* 229 - aring */
		"æ",                                                 /* 230 - aelig */
		"ç",                                                /* 231 - ccedil */
		"è",                                                /* 232 - egrave */
		"é",                                                /* 233 - eacute */
		"ê",                                                 /* 234 - ecirc */
		"ë",                                                  /* 235 - euml */
		"ì",                                                /* 236 - igrave */
		"í",                                                /* 237 - iacute */
		"î",                                                 /* 238 - icirc */
		"ï",                                                  /* 239 - iuml */
		"ð",                                                   /* 240 - eth */
		"ñ",                                                /* 241 - ntilde */
		"ò",                                                /* 242 - ograve */
		"ó",                                                /* 243 - oacute */
		"ô",                                                 /* 244 - ocirc */
		"õ",                                                /* 245 - otilde */
		"ö",                                                  /* 246 - ouml */
		"÷",                                                /* 247 - divide */
		"ø",                                                /* 248 - oslash */
		"ù",                                                /* 249 - ugrave */
		"ú",                                                /* 250 - uacute */
		"û",                                                 /* 251 - ucirc */
		"ü",                                                  /* 252 - uuml */
		"ý",                                                /* 253 - yacute */
		"þ",                                                 /* 254 - thorn */
		"ÿ"                                                   /* 255 - yuml */
	};

	/*
	 *   Map certain extended characters into our 128-255 range.  If we
	 *   don't recognize the character, return the default invalid
	 *   charater value.  
	 */
	if (html4_char > 255)
	{
		switch(html4_char)
		{
		case 338: html4_char = 140; break;
		case 339: html4_char = 156; break;
		case 376: html4_char = 159; break;
		case 352: html4_char = 154; break;
		case 353: html4_char = 138; break;
		case 8211: html4_char = 150; break;
		case 8212: html4_char = 151; break;
		case 8216: html4_char = 145; break;
		case 8217: html4_char = 146; break;
		case 8218: html4_char = 130; break;
		case 8220: html4_char = 147; break;
		case 8221: html4_char = 148; break;
		case 8222: html4_char = 132; break;
		case 8224: html4_char = 134; break;
		case 8225: html4_char = 135; break;
		case 8240: html4_char = 137; break;
		case 8249: html4_char = 139; break;
		case 8250: html4_char = 155; break;
		case 8482: html4_char = 153; break;
		default:
			result[0] = '·';
			result[1] = 0;
			return;
		}
	}
	
	/* 
	 *   if the character is in the regular ASCII zone, return it
	 *   untranslated 
	 */
	if (html4_char < 128)
	{
		result[0] = (unsigned char)html4_char;
		result[1] = '\0';
		return;
	}
	/* look up the character in our table and return the translation */
	strcpy(result, xlat_tbl[html4_char - 128]);
}

void os_advise_load_charmap(char *id, char *ldesc, char *sysinfo)
{
}

void os_gen_charmap_filename(char *filename, char *internal_id, char *argv0)
{
	filename = NULL;
}

void os_sleep_ms(long delay_in_milliseconds)
{
	Delay(delay_in_milliseconds/20);
}

int osfdel_temp(const char *fname)
{
	osfdel(fname);
	SwapFile = NULL;
	return 0;
}

long os_get_sys_clock_ms(void)
{
	static long timeZero = 0;

	if (timeZero == 0)
		timeZero = time(0);
	return ((time(0) - timeZero) * 1000);
}

int os_get_event(unsigned long timeout_in_milliseconds, int use_timeout, os_event_info_t *info)
{
	if (use_timeout)
			return OS_EVT_NOTIMEOUT;

	info->key[0] = os_getc();
	if (info->key[0] == 0)
			info->key[1] = os_getc();

	return OS_EVT_KEY;
}

void os_set_title(const char *title)
{
static char ScreenTitle[256];

	sprintf(ScreenTitle,"%s [%s]",TitleBar,title);
	if (Window)
		SetWindowTitles(Window,(UBYTE*)~0,ScreenTitle);
}

int osfrb(osfildef *fp, unsigned char *buf, int bufl)
{
	return (fread(buf, bufl, 1, fp) != 1);
}

int osfwb(osfildef *fp, unsigned char *buf, int bufl)
{
	return (fwrite(buf, bufl, 1, fp) != 1);
}

typedef int (*external_fn)(void *);

external_fn os_exfil(const char *name)
{
	return 0;
}

external_fn os_exfld(osfildef *fp, unsigned len)
{
	return 0;
}

int os_excall(int (*extfn)(void *), void *arg)
{
	return 0;
}

int os_getc_raw(void)
{
	return amiga_getkey(1);
}

osfildef *osfoprwb(char *fname, int typ)
{
	osfildef *fp;

	fp = fopen(fname,"r+b");
	if (fp != 0)
		return fp;
	return fopen(fname,"w+b");
}

void os_build_full_path(char *fullpathbuf, size_t fullpathbuflen, const char *path, const char *filename)
{
	size_t plen, flen;
	int add_sep;

	plen = strlen(path);
	add_sep = (plen != 0 && path[plen-1] != OSPATHCHAR && strchr(OSPATHALT, path[plen-1]) == 0);

	if (plen > fullpathbuflen - 1)
		plen = fullpathbuflen - 1;
	memcpy(fullpathbuf, path, plen);

	if (add_sep && plen + 2 < fullpathbuflen)
		fullpathbuf[plen++] = OSPATHCHAR;

	flen = strlen(filename);
	if (flen > fullpathbuflen - plen - 1)
		flen = fullpathbuflen - plen - 1;
	memcpy(fullpathbuf + plen, filename, flen);

	fullpathbuf[plen + flen] = '\0';
}

int oss_get_sysinfo(int code, void *param, long *result)
{
	switch(code)
	{
	case SYSINFO_TEXT_COLORS:
		*result = SYSINFO_TXC_PARAM;
		return TRUE;
	case SYSINFO_TEXT_HILITE:
		*result = 1;
		return TRUE;
	}
	return FALSE;
}

int ossgetcolor(int fg, int bg, int attrs, int screen_color)
{
	if (attrs & OS_ATTR_HILITE)
		return COLOUR_BOLD;
	return COLOUR_NORMAL;
}

void os_fprintz(osfildef *fp, const char *str)
{
	fprintf(fp,"%s",str);
}

void oss_raw_key_to_cmd(os_event_info_t *evt)
{
	switch(evt->key[0])
	{
	case 0:
		if (evt->key[1] == CMD_F1)
			/* toggle scrollback mode */
			evt->key[1] = CMD_SCR;
		break;

	case 1:
		/* ^A - start of line */
		evt->key[0] = 0;
		evt->key[1] = CMD_HOME;
		break;

	case 2:
		/* ^B - left */
		evt->key[0] = 0;
		evt->key[1] = CMD_LEFT;
		break;

	case 4:
		/* ^D - delete */
		evt->key[0] = 0;
		evt->key[1] = CMD_DEL;
		break;

	case 5:
		/* ^E - end of line */
		evt->key[0] = 0;
		evt->key[1] = CMD_END;
		break;
				
	case 6:
		/* ^F - right */
		evt->key[0] = 0;
		evt->key[1] = CMD_RIGHT;
		break;

	case 11:
		/* ^K - delete to end of line */
		evt->key[0] = 0;
		evt->key[1] = CMD_DEOL;
		break;

	case 21:
	case 27:
		/* ^U/Escape - delete entire line */
		evt->key[0] = 0;
		evt->key[1] = CMD_KILL;
		break;
	}
}

int main(int argc, char** argv)
{
	int err;

	amiga_early();
	os_init(&argc,argv,(char*)0,(char*)0,0);
	err = os0main2(argc,argv,trdmain,"","config.tr",0);
	os_term(err);
	//amiga_exit();
}

