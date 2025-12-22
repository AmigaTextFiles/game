
/* Console routines by Russell Wallace 1987, some obtained from other programs
 * books etc. Feel free to copy them or use them in your own programs. Use
 * +L option if compiling with Aztec C. */

#include "graphics/text.h"
#include "graphics/gfxbase.h"
#include "exec/exec.h"
#include "devices/console.h"
#include "devices/keymap.h"
#include "libraries/dos.h"
#include "intuition/intuition.h"

#define CloseConsole(x) CloseDevice(x)
#define XOFFSET 26
#define YOFFSET 39

extern struct Window *OpenWindow ();
extern struct MsgPort *CreatePort ();
extern struct IOStdReq *CreateStdIO ();

short row=0;
short column=0;
short font_width,font_height;
int class,code;
struct GfxBase *GfxBase=0;
long IntuitionBase=0;
struct NewWindow mynewwindow=
{
	0,0,		/* x,y co-ords of top left corner */
	640,200,	/* start size */
	0,1,		/* detailpen,blockpen */
	MENUPICK|CLOSEWINDOW,	/* want to know if these happen */
	ACTIVATE|GIMMEZEROZERO|WINDOWSIZING|WINDOWDRAG|WINDOWDEPTH|WINDOWCLOSE,
	0,0,"Labyrinth II",0,0,
	120,88,		/* minimum size */
	640,256,	/* maximum size */
	WBENCHSCREEN
};
struct IOStdReq *consoleWriteMsg=0;
struct IOStdReq *consoleReadMsg=0;
struct MsgPort *consoleWritePort=0;
struct MsgPort *consoleReadPort=0;
unsigned char letter;
struct Window *mywindow=0;
struct IntuiMessage *message;

	/* Start() must be called at beginning; returns window pointer - if 0,
	 * program has failed ... everything already cleaned up here, main ()
	 * must do its own cleaning up then exit */

struct Window *start ()
{
	if (!(GfxBase=(struct GfxBase *)OpenLibrary ("graphics.library",0)))
		goto FAILED;
	if (!(IntuitionBase=OpenLibrary ("intuition.library",0)))
		goto FAILED;
	if (!(mywindow=OpenWindow (&mynewwindow)))
		goto FAILED;
	if (!(consoleWritePort=CreatePort ("my.con.write",0)))
		goto FAILED;
	if (!(consoleReadPort=CreatePort ("my.con.read",0)))
		goto FAILED;
	if (!(consoleWriteMsg=CreateStdIO (consoleWritePort)))
		goto FAILED;
	if (!(consoleReadMsg=CreateStdIO (consoleReadPort)))
		goto FAILED;
	if (OpenConsole (consoleWriteMsg,consoleReadMsg,mywindow))
		goto FAILED;
	QueueRead (consoleReadMsg,&letter);
	font_width=GfxBase->DefaultFont->tf_XSize;
	font_height=GfxBase->DefaultFont->tf_YSize;
	return (mywindow);
FAILED:
	closeall ();
	return (0L);
}

	/* Call finish() at the end IF start() was successful */

finish ()
{
	AbortIO (consoleReadMsg);
	CloseConsole (consoleWriteMsg);
	closeall ();
}

closeall ()
{
	if (GfxBase)
		CloseLibrary (GfxBase);
	if (IntuitionBase)
		CloseLibrary (IntuitionBase);
	if (mywindow)
		CloseWindow (mywindow);
	if (consoleWritePort)
		DeletePort (consoleWritePort);
	if (consoleReadPort)
		DeletePort (consoleReadPort);
	if (consoleWriteMsg)
		DeleteStdIO (consoleWriteMsg);
	if (consoleReadMsg)
		DeleteStdIO (consoleReadMsg);
}

int OpenConsole (writerequest,readrequest,window)
struct IOStdReq *writerequest,*readrequest;
struct Window *window;
{
	register int error;
	writerequest->io_Data=(APTR)window;
	writerequest->io_Length=sizeof(*window);
	error=OpenDevice ("console.device",0,writerequest,0);
	readrequest->io_Device=writerequest->io_Device;
	readrequest->io_Unit  =writerequest->io_Unit;
	return (error);
}

QueueRead (request,whereto)
struct IOStdReq *request;
char *whereto;
{
	request->io_Command=CMD_READ;
	request->io_Data=(APTR)whereto;
	request->io_Length=1;
	SendIO (request);
}

	/* Call checkinput() every so often to find out what the user is doing:
	 * a -ve number -1,-2 ... means the user has selected menu item 1,2 ...
	 * a +ve number means the user has typed a character, 1000 means the
	 * closewindow gadget has been selected, so do your ARE YOU SURE routine
	 * then call finish() and wind up. 0 means nothing's happened. */

long checkinput ()
{
	if (message=(struct IntuiMessage *)GetMsg (mywindow->UserPort))
	{
		class=message->Class;
		code=message->Code;
		ReplyMsg (message);
		if (class==CLOSEWINDOW)
			return (1000);
		if (class==MENUPICK && code!=MENUNULL)
			return (-1-ITEMNUM (code));
	}
	if (GetMsg (consoleReadPort))
	{
		code=letter;
		QueueRead (consoleReadMsg,&letter);
		return (code);
	}
	return (0);
}

	/* Writechar() writes a character to the window ... to get a response from
	 * typed input, call it immediately with any characters returned from
	 * checkinput(). */

writechar (c)	/* NOTE - MUST BE CALLED WITH THE CHARACTER CAST TO TYPE LONG*/
char c;			/* Don't blame me, I don't know why, blame the Amiga */
{				/* systems programmers. */
	consoleWriteMsg->io_Command=CMD_WRITE;
	consoleWriteMsg->io_Data=(APTR)&c;
	consoleWriteMsg->io_Length=1;
	DoIO (consoleWriteMsg);
	if (c=='\n')
	{
		column=0;
		row++;
	}
	else
		column++;
	if ((row*font_height)+YOFFSET > mywindow->Height)
	{
		nprint ("MORE...");
		do
			;
		while (!checkinput ());
		row=0;
		nprint ("\r       \r");

	/* This is to prevent a large quantity of text from scrolling off the top
	 * of the window before the user has time to read it all e.g. in
	 * adventure games. Remove it if you don't need it. Note - don't let the
	 * user make the window too small vertically or an infinite loop occurs.*/

	}
}

	/* Print() does a formatted (i.e. trying not to split up words on the ends
	 * of lines) print of a null-terminated string; very useful for text-
	 * oriented applications in a variable-sized window. */

print (string)
char *string;
{
	short x;
	for (;;)
	{
		x=0;
		while (string[x]!='\0' && string[x]!=' ' && string[x]!='\n')
			x++;
		if (((column+x)*font_width)+XOFFSET > mywindow->Width && column)
		{							/* If word would go off end of line, */
			writechar ((long)'\n');	/* go on to next line before print */
		}
		consoleWriteMsg->io_Command=CMD_WRITE;
		consoleWriteMsg->io_Data=(APTR)string;
		consoleWriteMsg->io_Length=x;
		DoIO (consoleWriteMsg);
		column+=x;
		if (string[x]=='\n')
			writechar ((long)'\n');
		if (string[x]==' ')
			writechar ((long)' ');
		if (string[x]=='\0')
			break;
		string+=x+1;
	}
}

nprint (string)		/* Non-formatted print */
char *string;
{
	consoleWriteMsg->io_Command=CMD_WRITE;
	consoleWriteMsg->io_Data=(APTR)string;
	consoleWriteMsg->io_Length=-1;
	DoIO (consoleWriteMsg);
}

resetscroll ()		/* Reset scroll pause feature */
{
	row=0;
}
