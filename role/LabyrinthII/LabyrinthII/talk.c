
/* Speech routines by Russell Wallace 1988, developed from speech demo program
 * in ROM Kernel Manual. Routines are as follows:
 * openmouth () sets everything up - returns nonzero if error condition
 * say (string) says a null-terminated character string
 * closemouth () shuts everything down - don't use it if openmouth ()
 *	returned an error.
 * Parameters for voice are contained in openmouth () and may be changed,
 * so may MAXLEN if you have very long strings or all of them are going to
 * be fairly short. Use +L if compiling with Aztec C. Requires presence of
 * translator.library in system disk LIBS directory.
 * This code may be freely used in writing Amiga programs. */

#include "exec/exec.h"
#include "exec/execbase.h"
#include "devices/narrator.h"
#include "libraries/translator.h"

#define MAXLEN 1024		/* Maximum length of translated string */

struct MsgPort *readport=0;
struct MsgPort *writeport=0;

struct MsgPort *CreatePort ();
struct IORequest *CreateExtIO ();
struct Library *OpenLibrary ();

struct narrator_rb *writeNarrator=0;
struct mouth_rb *readNarrator=0;
struct Library *TranslatorBase=0;
UBYTE *sampleinput;
UBYTE outputstring[MAXLEN];
BYTE audChanMasks[4]={3,5,10,12};

int openmouth ()
{
	TranslatorBase=OpenLibrary ("translator.library",1);
	if (TranslatorBase==0)
		return (1);
	writeport=CreatePort (0,0);
	if (writeport==0)
	{
		closemouth ();
		return (3);
	}
	readport=CreatePort (0,0);
	if (readport==0)
	{
		closemouth ();
		return (4);
	}
	writeNarrator=(struct narrator_rb *)CreateExtIO (writeport,sizeof(struct narrator_rb));
	if (writeNarrator==0)
	{
		closemouth ();
		return (5);
	}
	readNarrator=(struct mouth_rb *)CreateExtIO (readport,sizeof(struct mouth_rb));
	if (readNarrator==0)
	{
		closemouth ();
		return (6);
	}

		/* Set up parameters for write-message to Narrator device */

	writeNarrator->ch_masks=(audChanMasks);
	writeNarrator->nm_masks=sizeof(audChanMasks);
	writeNarrator->message.io_Data=(APTR)outputstring;
	writeNarrator->message.io_Length=strlen (outputstring);
	writeNarrator->mouths=0;	/* Don't bother calculating mouths */
	writeNarrator->message.io_Command=CMD_WRITE;

		/* Open device */

	if (OpenDevice ("narrator.device",0,writeNarrator,0))
	{
		closemouth ();
		return (7);
	}

		/* Set up parameters for read-message to Narrator device */

	readNarrator->voice.message.io_Device=writeNarrator->message.io_Device;
	readNarrator->voice.message.io_Unit=writeNarrator->message.io_Unit;
	readNarrator->voice.message.io_Command=CMD_READ;

		/* Send asynchronous write request to device */

	if (SendIO (writeNarrator))
	{
		closemouth ();
		return (8);
	}

		/* keep sending until says "no write in progress" */

	do
		DoIO (readNarrator);
	while ((readNarrator->voice.message.io_Error)!=ND_NoWrite);

		/* set parameters for speech */

	writeNarrator->sex=FEMALE;
	writeNarrator->pitch=DEFPITCH;

	return (0);		/* Everything OK */
}

say (string)
char *string;
{
	(void)Translate (string,strlen (string),outputstring,MAXLEN);
	writeNarrator->message.io_Data=(APTR)outputstring;
	writeNarrator->message.io_Length=strlen (outputstring);
	DoIO (writeNarrator);
}

closemouth ()
{
	if (writeNarrator)
	{
		CloseDevice (writeNarrator);
		DeleteExtIO (writeNarrator,sizeof(struct narrator_rb));
	}
	if (readNarrator)
		DeleteExtIO (readNarrator,sizeof(struct mouth_rb));
	if (writeport)
		DeletePort (writeport);
	if (readport)
		DeletePort (readport);
	if (TranslatorBase)
		CloseLibrary (TranslatorBase);
}
