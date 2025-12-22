/*********************************************************************
 *
 * QR print
 *
 * Author: Marten W.
 * Date  : 5/2021
 *
 *********************************************************************/

/* std */

#include <stdio.h>
#include <string.h>

/* os */

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <graphics/gfxbase.h>
#include <libraries/dos.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/dos_protos.h>

/* others */

#include "qrcode.h"

/* defines */

#define QR_VERSION (12)

#define HISCORE_FILENAME ("hiscore")
#define HISCORE_SIZE (108)
#define URL_MAX_SIZE (4096)

/* global */

struct Library *dosLibrary = NULL;
struct IntuitionBase *IntuitionBase = NULL;
struct GfxBase *GfxBase = NULL;

char g_urlBuffer[URL_MAX_SIZE];
char g_fileBuffer[HISCORE_SIZE];

/* more can go wrong than work */

typedef enum 
{
	REC_OK = 0,
	REC_DOS_FAIL = -1,
	REC_INTUITION_FAIL = -2,
	REC_GFX_FAIL = -3,
	REC_QRBUF_FAIL = -4,
	REC_QRENCODE_FAIL = -5,
	REC_OPENWINDOW_FAIL = -6,
	REC_HISCORE_OPEN_FAIL = -7,
	REC_HISCORE_READ_FAIL = -8,
	REC_URL_ENCODE_FAIL = -9
	
} retErrorCodes_t;

/**
 * @brief encodeByteToString
 * @param din char
 * @param offsetChar
 * @return ptr to string (note: static)
 */
 
static char *encodeByteToString(unsigned char din,char offsetChar)
{
	static char dualString[3];
	
	dualString[0] = (din>>4)  + offsetChar;
	dualString[1] = (din&0xf) + offsetChar;
	dualString[2] = 0;
	
	return dualString;
}

/**
 * @brief encodeUrl
 * @param from is source
 * @param to is destination
 * @param fromSize size of source in bytes
 * @return status
 */

static bool encodeUrl(char *from,char *to,int fromSize,int destSize)
{
	int i;
	unsigned char xorVal = 42;
	
	to[0] = 0;
	to = strcat(to,"https://www.goldmomo.org/php/spod/hiscore.php?upload=");
	
	for(i=0;i<fromSize;i++)
	{
		unsigned char d = *from++;
		xorVal = xorVal ^ d;
		to = strcat(to,encodeByteToString(d,'A'));
	}
	
	to = strcat(to,encodeByteToString(xorVal,'a'));
	
	return true;
}

/**
 * @brief main
 * @param argc is ignored
 * @param argv is ignored
 * @return status
 */
 
int main(int, char**)
{	
	int retVal = REC_OK;
	struct NewWindow newWindow = {0};
	struct Window *window;
	uint8_t *qrcodeBuffer;
	int qrcodeBufferSize,bytesRead;
	QRCode qrcode;
	BPTR fileHandle;
	
	/* open dos libraries */

	struct Library *dosLibrary = (struct Library *) OpenLibrary("dos.library",0UL);
	if (!dosLibrary)
	{
		puts("Error can't open dos.library");
		return REC_DOS_FAIL; 
	}
	
	/* open, check, read and convert hiscore */
	
	fileHandle = Open(HISCORE_FILENAME,MODE_OLDFILE);
	if(!fileHandle)
	{				
		printf("Error can't open file %s (maybe not written)\n",HISCORE_FILENAME);		
		CloseLibrary((struct Library*)dosLibrary);				
		return REC_HISCORE_OPEN_FAIL; 	
	}
	
	bytesRead = (int) Read(fileHandle,g_fileBuffer,HISCORE_SIZE);
	if(bytesRead != HISCORE_SIZE)
	{
		printf("Error %s file read count is not %d bytes\n",HISCORE_FILENAME,HISCORE_SIZE);
		Close(fileHandle);
		CloseLibrary((struct Library*)dosLibrary);				
		return REC_HISCORE_READ_FAIL; 				
	}
	
	puts("Generate QR code (this can take over a minute), so please wait ...");
	if(!encodeUrl(g_fileBuffer,g_urlBuffer,HISCORE_SIZE,URL_MAX_SIZE))
	{
		puts("Error encoding url");
		Close(fileHandle);
		CloseLibrary((struct Library*)dosLibrary);				
		return REC_URL_ENCODE_FAIL; 	
	}
				
	Close(fileHandle);
	
	/* open other libraries */

	IntuitionBase = (struct IntuitionBase *) OpenLibrary("intuition.library", 0UL);
	if (!IntuitionBase)
	{
		puts("Error can't open intuition.library");
		CloseLibrary((struct Library*)dosLibrary);
		return REC_INTUITION_FAIL; 
	}
	
	GfxBase = (struct GfxBase *) OpenLibrary("graphics.library", 0UL);
	if (!GfxBase)
	{
		puts("Error can't open graphics.library");
		CloseLibrary((struct Library*)dosLibrary);	
		CloseLibrary((struct Library*)IntuitionBase);
		return REC_GFX_FAIL; 	
	}
	
	/* get memory for qrcode generator */
	
	qrcodeBufferSize = qrcode_getBufferSize(QR_VERSION);
	
	qrcodeBuffer = (uint8_t*) AllocMem(qrcodeBufferSize,MEMF_ANY);
	if(!qrcodeBuffer)
	{
		printf("Error can't allocate %d bytes for qrcode buffer\n",qrcodeBufferSize);
		CloseLibrary((struct Library*)dosLibrary);	
		CloseLibrary((struct Library*)GfxBase);
		CloseLibrary((struct Library*)IntuitionBase);
		return REC_QRBUF_FAIL; 
	}
	
	/* generate code */
	
	if(qrcode_initText(&qrcode, qrcodeBuffer, QR_VERSION, ECC_MEDIUM, g_urlBuffer))
	{
		puts("Error can't create qr code");
		FreeMem((void *)qrcodeBuffer,qrcodeBufferSize);
		CloseLibrary((struct Library*)dosLibrary);	
		CloseLibrary((struct Library*)GfxBase);
		CloseLibrary((struct Library*)IntuitionBase);
		return REC_QRENCODE_FAIL; 
	}
	
	/* setup and open window */
	
	newWindow.LeftEdge = 10;
	newWindow.TopEdge = 10;
	newWindow.Width = 310;
	newWindow.Height = 175;
	newWindow.DetailPen = 0;
	newWindow.BlockPen = 1;
	newWindow.Title = "SPOD hiscore to QR code";
	newWindow.Flags = WFLG_SMART_REFRESH | WFLG_ACTIVATE | WFLG_CLOSEGADGET | WFLG_DRAGBAR | WFLG_DEPTHGADGET;
	newWindow.IDCMPFlags = CLOSEWINDOW;
	newWindow.Type = WBENCHSCREEN;
	newWindow.FirstGadget = NULL;
	newWindow.CheckMark = NULL;
	newWindow.Screen = NULL;
	newWindow.BitMap = NULL;
	newWindow.MinWidth = 0;
	newWindow.MinHeight = 0;
	newWindow.MaxWidth = 0;
	newWindow.MaxHeight = 0;
	
	window = (struct Window *)OpenWindow(&newWindow);	
	
	if (window)
	{	
		BOOL doExit = FALSE;
		struct RastPort *rastPort = window->RPort;
		if(rastPort)
		{
			int x,y,zx,zy;
			const int xo=25,yo=15;
			const int zoomx = 4;
			const int zoomy = 2;
			
			const char *textString1 = "Scan QR code to upload";
			const char *textString2 = "your hiscore";
			
			/* draw text */
			
			SetAPen(rastPort, 1);			
			Move(rastPort,15,yo+(qrcode.size*zoomy)+10);
			Text(rastPort,(STRPTR)textString1,strlen(textString1));
			Move(rastPort,15,yo+(qrcode.size*zoomy)+20);
			Text(rastPort,(STRPTR)textString2,strlen(textString2));
			
			/* draw qr code */
				
			for (y = 0; y < qrcode.size; y++) 
			{
			    for (x = 0; x < qrcode.size; x++)
			    {
				if (qrcode_getModule(&qrcode, x, y))
				{
				   for (zy = 0; zy < zoomy; zy++) 
				   {	
					for (zx = 0; zx < zoomx; zx++) 
					{
						WritePixel(rastPort, xo+x*zoomx+zx, yo+y*zoomy+zy);
					}
				   }				   
				} 
			    }
			}						
		}
			
		/* wait for close window */
		
		do
		{
			struct IntuiMessage *msg;
			Wait(1 << window->UserPort->mp_SigBit); 
			
			msg = (struct IntuiMessage *) GetMsg((struct MsgPort *)window->UserPort); 
			ReplyMsg((struct Message*)msg);
			if (msg->Class == IDCMP_CLOSEWINDOW)
			{
				CloseWindow(window);
				doExit = TRUE;
			}			
		}
		while(!doExit);
	}
	else
	{
		puts("Error can't open window");
		retVal = REC_OPENWINDOW_FAIL;
	}
	
	/* clean up */
	
	FreeMem((void *)qrcodeBuffer,qrcodeBufferSize);
	
	CloseLibrary((struct Library*)dosLibrary);
	CloseLibrary((struct Library*)GfxBase);
	CloseLibrary((struct Library*)IntuitionBase);
	
	return retVal;
}
