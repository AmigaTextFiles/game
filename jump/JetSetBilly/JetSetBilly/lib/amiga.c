/*
 *
 * This module which a screen and a window of desired size and depth.
 * Console device is used for output, and input is RawKeyConvert:ed.
 * We also allocate TmpRas for Flood().
 *
 * Usage:
 *
 *	openup(width, height, depth, viewmodes, char *title, flags);
 *
 * flags:
 *
 *	DOUBLE_BUFFER
 *	REDIR_SYSREQ
 *	SCREEN_QUIET
 *
 *
 *	(call HandleIDCMP, ConPuts etc. from your program)
 *
 *	cleandown(0);
 *
 */

#include <exec/types.h>
#include <exec/nodes.h>
#include <exec/lists.h>
#include <exec/ports.h>
#include <exec/io.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <devices/inputevent.h>
#include <libraries/dos.h>
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include <proto/all.h>
int CXBRK(void) { return 0; }

#include "console.h"
#include "externs.h"
#include "proto.h"

#define KEYBUF_SIZE	32

SHORT			SWidth, SHeight, SDepth;
USHORT			SMode;
ULONG			SFlags;

struct IntuitionBase	*IntuitionBase = NULL;
struct GfxBase		*GfxBase = NULL;
struct Library		*LayersBase = NULL;
struct ViewPort		*vp = NULL;
struct RastPort		*rp = NULL;
struct TmpRas		tmpras;
PLANEPTR		planeptr = NULL;
struct Screen		*screen = NULL;
struct Window		*window = NULL;
struct BitMap		*mybitmaps[2] = { NULL, NULL };
WORD			toggleframe = 0;
struct TextAttr		textattr = { (STRPTR)"topaz.font",TOPAZ_EIGHTY,0,0 };
struct Library		*ConsoleDevice = NULL;
int			tick;
unsigned int		incode;

char			*inkey = NULL;
int			inpos;
USHORT			rawkey;
struct IOStdReq		*writereq = NULL;
struct MsgPort		*writeport = NULL;
BOOL			OpenedConsole = FALSE;
char			buf[512];
char			inbuf[512];
ULONG			signalmask;

struct Process		*myprocess = NULL;
APTR			oldwindowptr = NULL;

ULONG			cursor_keys = 0L;	/* Cursor keys kept down */

USHORT			msg_code;
SHORT			mousex, mousey;

struct NewScreen new_screen = {
	0, 0, 320, 256, 3, 0, 1, NULL,
	CUSTOMSCREEN, &textattr, NULL, NULL, NULL
};

struct NewWindow new_window = {
	0, 0, 320, 256, 0, 1, RAWKEY | INTUITICKS | MOUSEBUTTONS,
	BACKDROP | BORDERLESS | SMART_REFRESH | RMBTRAP | ACTIVATE | NOCAREREFRESH,
	NULL, NULL, (NULL), NULL, NULL,
	80, 19, 320, 256, CUSTOMSCREEN
};

void
CloseWindowSafely(struct Window *win)
{
	Forbid();
	StripIntuiMessages( win->UserPort, win );
	win->UserPort = NULL;
	ModifyIDCMP( win, 0L );
	Permit();
	CloseWindow( win );
}

void
StripIntuiMessages(struct MsgPort *mp, struct Window *win)
{
	struct IntuiMessage *msg;
	struct Node *succ;

	msg = (struct IntuiMessage *) mp->mp_MsgList.lh_Head;

	while (succ =  msg->ExecMessage.mn_Node.ln_Succ) {
		if (msg->IDCMPWindow == win) {
			Remove(msg);
			ReplyMsg(msg);
		}
		msg = (struct IntuiMessage *) succ;
	}
}

void
StartFrame()
{
	if (SFlags & DOUBLE_BUFFER) {
		vp->RasInfo->BitMap = mybitmaps[toggleframe];
	} else {
		WaitBOVP(vp);
	}
}

void
EndFrame()
{
	if (SFlags & DOUBLE_BUFFER) {
		MakeScreen(screen);
		RethinkDisplay();
		toggleframe ^= 1;
		/* Flip to the next bitmap */
		window->WScreen->RastPort.BitMap = mybitmaps[toggleframe];
	} else {
		WaitTOF();
	}
}

void
openup(SHORT width, SHORT height, SHORT depth, USHORT mode,
	char *title, ULONG flags)
{
	BYTE	error;
	UWORD	coltab[] = { 0x000,0xfff,0xf00,0x0f0,0x00f,0xff0,0x0ff,0xf0f };
	int	i, j;

	IntuitionBase = (struct IntuitionBase *) OpenLibrary(
					  "intuition.library", 33L);
	GfxBase = (struct GfxBase *) OpenLibrary("graphics.library", 33L);
	LayersBase = OpenLibrary("layers.library", 33L);

	if (GfxBase == NULL || IntuitionBase == NULL || LayersBase == NULL)
		cleandown(ERROR_INVALID_RESIDENT_LIBRARY);

	SWidth  = new_screen.Width  = new_window.Width  = width;
	SHeight = new_screen.Height = new_window.Height = height;
	SDepth  = new_screen.Depth  = depth;
	SMode   = new_screen.ViewModes = mode | SPRITES;
	SFlags  = flags;
	new_screen.DefaultTitle = (UBYTE *)title;

	if (SFlags & SCREEN_QUIET) {
		new_screen.Type |= SCREENQUIET;
	}

	/* Double buffering? */
	if (SFlags & DOUBLE_BUFFER) {

	    for (j = 0; j < 2; j++) {

		if ((mybitmaps[j] = (struct BitMap *)AllocMem(
		    (LONG)sizeof(struct BitMap), MEMF_CLEAR)) == NULL)
			cleandown(ERROR_NO_FREE_STORE);

		InitBitMap(mybitmaps[j], SDepth, SWidth, SHeight);

		for (i = 0; i < SDepth; i++) {
		    if ((mybitmaps[j]->Planes[i] = (PLANEPTR)
			AllocRaster(SWidth, SHeight)) == NULL)
				cleandown(ERROR_NO_FREE_STORE);
		}
	    }

	    new_screen.Type |= CUSTOMBITMAP;
	    new_screen.CustomBitMap = mybitmaps[0];
	}

	/* Open intuition screen and window */
	screen = OpenScreen(&new_screen);
	if (!screen) cleandown(ERROR_NO_FREE_STORE);

	new_window.Screen = screen;
	window = OpenWindow(&new_window);
	if (!window) cleandown(ERROR_NO_FREE_STORE);

	rp = window->RPort;
	vp = &screen->ViewPort;

	signalmask = (1L << window->UserPort->mp_SigBit);

	if ((planeptr = (PLANEPTR)AllocRaster(SWidth, SHeight)) == NULL)
		cleandown(ERROR_NO_FREE_STORE);

	InitTmpRas(&tmpras, planeptr, RASSIZE(SWidth, SHeight));
	rp->TmpRas = &tmpras;

	/* Get color map */
	LoadRGB4(vp,coltab,8);

#if 0
	/* Draggaus katsoo screenin layerista title baarin joten ei voi
	   siirtää windowin layeriä päällimmäiseksi. */
	UpfrontLayer(NULL, window->RPort->Layer);
#endif

	if (SFlags & DOUBLE_BUFFER) {
		window->WScreen->RastPort.Flags  = DBUFFER;
		window->WScreen->RastPort.BitMap = mybitmaps[1];
		BltBitMapRastPort(mybitmaps[0],0,0,
			&window->WScreen->RastPort,0,0,SWidth,SHeight,0xc0);
		window->WScreen->RastPort.BitMap = mybitmaps[0];
	}

	if (SFlags & REDIR_SYSREQ) {
		myprocess = (struct Process *)FindTask(NULL);
		oldwindowptr = myprocess->pr_WindowPtr;
		myprocess->pr_WindowPtr = (APTR)window;
	}

	/* Create port for console write */
	if (!(writeport = CreatePort("game.console.write",0)))
		cleandown(RETURN_FAIL);

	/* Create and link write request */
	if (!(writereq = (struct IOStdReq *)CreateExtIO(writeport,
			(LONG)sizeof(struct IOStdReq))))
		cleandown(RETURN_FAIL);

	writereq->io_Data = (APTR) window;
	writereq->io_Length = sizeof(struct Window);

	/* Open console device */
	if (error = OpenDevice("console.device",0,writereq,0))
		cleandown(RETURN_FAIL);
	OpenedConsole = TRUE;

	/* Find console device */
	ConsoleDevice = (struct Library *)writereq->io_Device;

	/* Reserve keyboard input buffer */
	if ((inkey = AllocMem(KEYBUF_SIZE, MEMF_CLEAR)) == NULL)
		cleandown(ERROR_NO_FREE_STORE);

	inpos = tick = 0;

	RandomSeed((long)time(NULL));

	/* Set console top offset correctly (plus 1, it looks better) */

	/* intuition/screens.h demands it to be calculated this way. */
	sprintf(buf, "\233%dy",
		screen->WBorTop + screen->Font->ta_YSize + 2);

	/* This is how it can also be done (?) */
	/* sprintf(buf, "\233%dy", screen->BarHeight + 2); */

	ConPuts(buf);
}

void
cleandown(int error)
{
	int	i,j;


	if (inkey) FreeMem(inkey, KEYBUF_SIZE);

	if (OpenedConsole) CloseDevice(writereq);
	if (writereq) DeleteExtIO(writereq);
	if (writeport) DeletePort(writeport);

	if (window) {
	        if (SFlags & REDIR_SYSREQ) {
			myprocess->pr_WindowPtr = oldwindowptr;
		}
		CloseWindowSafely(window);
	}
	if (screen) CloseScreen(screen);
	if (planeptr) FreeRaster(planeptr, SWidth, SHeight);

	if (SFlags & DOUBLE_BUFFER) {
	    for (j = 0; j < 2; j++) {

		if (mybitmaps[j]) {
		    for (i = 0; i < SDepth; i++) {
			if (mybitmaps[j]->Planes[i])
			    FreeRaster(mybitmaps[j]->Planes[i], SWidth, SHeight);
		    }

		    FreeMem(mybitmaps[j], (LONG)sizeof(struct BitMap));
		}
	    }
	}

	if (LayersBase) CloseLibrary(LayersBase);
	if (GfxBase) CloseLibrary((struct Library *) GfxBase);
	if (IntuitionBase) CloseLibrary((struct Library *) IntuitionBase);

	exit(error);
}

void
panic(char *msg)
{
	if (msg) fprintf(stderr, "%s", msg);
	cleandown(-1);
}

struct IntuiText rq_txt[] = {
	{ 0,1,JAM2,20,5,NULL,"What? QUIT?!?!!",NULL },
	{ 0,1,JAM2,5,4,NULL,"Yes",NULL },
	{ 0,1,JAM2,6,4,NULL,"Oh, No!",NULL } };

int verify_quit() {
	return(int)
		(AutoRequest(window, &rq_txt[0], &rq_txt[1], &rq_txt[2],
		0, 0, 200, 50));
}

void
at(int x,int y)
{
	char temp[20];

	sprintf(temp,"\033[%d;%dH",y,x);
	ConPuts(temp);
}

/* Wait for input events */
void
WaitIDCMP()
{
	ULONG signals;

	do {
		signals = Wait(signalmask);
	} while(!(signals & signalmask));
}

void
HandleIDCMP()
{
	struct IntuiMessage *msg = NULL;
	struct InputEvent ievent = { NULL, IECLASS_RAWKEY, 0, 0, 0 };
	int i;
	ULONG  class;

	while ((msg = (struct IntuiMessage *) GetMsg(window->UserPort))) {
		class = msg->Class;
		msg_code = msg->Code;
		incode	= (unsigned int)msg->Qualifier;

		switch (class) {

			case RAWKEY:

				rawkey = msg_code;

				if (msg_code >= 0x50 && msg_code <= 0x59) {
					inkey[0] = (msg_code - 0x4f);
					inpos = 1;
					incode |= KEY_FUNCTION;
					break;
				}

				if (msg_code >= 0x4c && msg_code <= 0x4f) {
					inkey[0] = (msg_code - 0x4b);
					inpos = 1;
					incode |= KEY_CURSOR;
					switch(inkey[0]) {
					 case 1: cursor_keys |= CUR_UP; break;
					 case 2: cursor_keys |= CUR_DOWN; break;
					 case 3: cursor_keys |= CUR_RIGHT; break;
					 case 4: cursor_keys |= CUR_LEFT;break;
					 default: break;
					}
					break;
				}

				if (msg_code == 0x5f) {
					inkey[0] = msg_code;
					inpos = 1;
					incode |= KEY_HELP;
					break;
				}

				/* Released any cursor keys? */
				if (msg_code >= 0xcc && msg_code <= 0xcf) {
					switch((msg_code - 0xcb)) {
					 case 1: cursor_keys &= (~CUR_UP); break;
					 case 2: cursor_keys &= (~CUR_DOWN); break;
					 case 3: cursor_keys &= (~CUR_RIGHT); break;
					 case 4: cursor_keys &= (~CUR_LEFT);break;
					 default: break;
					}
					break;
				}


				/* Buffer is full, ignore keys */
				if (inpos >= (KEYBUF_SIZE - 15)) break;

				ievent.ie_Code = msg_code;
				ievent.ie_Qualifier = msg->Qualifier;
				ievent.ie_position.ie_addr = *((APTR *)msg->IAddress);

				i = RawKeyConvert(&ievent, &(inkey[inpos]),
						  KEYBUF_SIZE - inpos, NULL);
				if (i > 0) inpos += i;

				break;

			case INTUITICKS:
				tick++;
				break;

			case MOUSEBUTTONS:
				switch (msg_code) {
					case SELECTDOWN:
						cursor_keys |= MOUSE_SELECT_BUTTON;
						break;
					case SELECTUP:
						cursor_keys &= (~MOUSE_SELECT_BUTTON);
						break;
					case MENUDOWN:
						cursor_keys |= MOUSE_MENU_BUTTON;
						break;
					case MENUUP:
						cursor_keys &= (~MOUSE_MENU_BUTTON);
						break;
					default:
						/* What a strange mouse button. */
						break;
				}
				mousex = msg->MouseX;
				mousey = msg->MouseY;
				break;

			default:
				break;
		}

		ReplyMsg((struct Message *) msg);

	} /* End while */
}

/* Console device functions */
/* We use DoIO - we're not in a hurry... */

void
ConPutChar(char ch)
{
	writereq->io_Command = CMD_WRITE;
	writereq->io_Data = (APTR) &ch;
	writereq->io_Length = 1;
	DoIO(writereq);
}

void
ConWrite(char *string, LONG length)
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


/*
 * Input routines
 *
 */
void
flush_inkey(int n)
{
	int i;

	if (!n) {
		inkey[0] = '\0';
		inpos = 0;
		return;
	}

	for (i = 0; i < (32 - n); i++) {
		inkey[i] = inkey[n + i];
		if (!inkey[n + 1]) break;
		else inpos--;
	}
}

char
getch()
{
	char ch;

	while (!inpos) {
		WaitIDCMP();	/* Todo: delay/nodelay, cbreak etc. */
		HandleIDCMP();
	}

	ch = inkey[0];

	flush_inkey(0);

	return ch;
}

/*
 * Always prints one linefeed before returning.
 *
 */
char *
get_string(int maxlen)
{
	char *p, ch;
	BOOL end = FALSE;

	if (maxlen > 511 || maxlen < 1) return NULL; /* Illegal */

	inbuf[0] = 0; p = inbuf;

	ConPuts(CURSON);

	while(!end) {
		ch = getch();
		if (ch >= 0x20 && ch <= 0x7e && (p - inbuf) < maxlen) {
			ConPutChar(ch);
			*p++ = ch;
			*p = '\0';
		}
		else if (ch == 0x1b) {
			ConPutChar('\n');
			ConPuts(CURSOFF);
			return NULL; /* ESC - cancel */
		}
		else if (ch == 0x08) {
			if (p > inbuf) {
				p--;
				*p = '\0';
				ConPutChar(ch); ConPuts(DELCHAR);
			}
		}
		else if (ch == 0x0d) end = TRUE;
	}

	ConPutChar('\n');
	ConPuts(CURSOFF);

	return inbuf;
}

void
more()
{
	ConPuts("--more--");
	ConPuts(CURSON); (void)getch(); ConPuts(CURSOFF);
}

/* Yes or no? */
BOOL yn() {
	char ch;

	ConPuts(CURSON);

	for(;;) {
		ch = getch();

		if (ch == 'y' || ch == 'Y') {
			ConPuts("y\n");
			ConPuts(CURSOFF);
			return TRUE;
		}

		if (ch == 'n' || ch == 'N' || ch == 0x1b) {
			ConPuts("n\n");
			ConPuts(CURSOFF);
			return FALSE;
		}
	}
}
