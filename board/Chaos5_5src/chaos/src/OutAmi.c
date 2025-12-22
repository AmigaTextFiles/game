/*  Chaos:                  The Chess HAppening Organisation System     V5.3
    Copyright (C)   1993    Jochen Wiedmann

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


    $RCSfile: OutAmi.c,v $
    $Revision: 3.2 $
    $Date: 1994/11/19 19:32:01 $

    These are the system dependent output functions.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef CHAOS_H
#include "chaos.h"
#endif

#ifdef AMIGA
#include <exec/libraries.h>
#include <exec/execbase.h>
#include <prefs/prefhdr.h>
#include <prefs/printertxt.h>
#include <proto/iffparse.h>
#endif  /*  AMIGA   */




/*
    The following function makes text being centered on the printer.
    This isn't needed at all and might be a stub function on other systems
    than the Amiga.

    Inputs: device - the device to which the output goes

    Results: TRUE, if successfull, FALSE otherwise
*/
int CenterText(int device)

#ifdef AMIGA    /*  The following lines produce centered output */
{
  if ((device == DEVICE_PrinterLQ  ||  device == DEVICE_PrinterDraft)  &&
      !lprint("\2331 F"))
  { return(FALSE);
  }
  return(TRUE);
}
#endif  /*  AMIGA   */




/*
    The InitOutput() function gets called by output functions before they
    do any output via lprint() or longlprint().

    Inputs: title     - the printed document's title
	    prthead   - the head to print above each page (printer output)
	    scrhead   - the head to appear on top of the output window
			(screen output)
	    filename  - the destination file (used if output to file only);
			this can be NULL, in which case InitOutput() brings
			up a filerequester asking for the filename
	    device    - the output device: DEVICE_Screen, DEVICE_PrinterDraft,
			DEVICE_PrinterLQ, Device_FileAscii or DEVICE_FileTeX
	    prtlines  - the number of lines, that one item needs on the
			printer
	    scrlines  - the number of lines, that one item needs on the
			screen

    Result: TRUE, if successfull, FALSE otherwise
*/
static char *titleOutput;
static char *prtheadOutput;
static char *scrheadOutput;
static char *filenameOutput;
static int deviceOutput;
static int prtlinesOutput;
static int scrlinesOutput;
void *OutputMemList;
struct MinList OutputList;
char *OutputLine;
int OutputLineLen;
int OutputLineMaxLen;
int OutputReturnCode;

int InitOutput(char *title, char *prthead, char *scrhead, char *filename,
	       char *ending, int device, int prtlines, int scrlines)

#ifdef AMIGA
{
  prtlinesOutput = prtlines;
  scrlinesOutput = scrlines;

  OutputReturnCode = 0;
  OutputMemList = NULL;
  OutputLine = NULL;
  OutputLineLen = OutputLineMaxLen = (device == DEVICE_Screen) ? 0 : -1;
  deviceOutput = device;
  NewList((struct List *) &OutputList);

  if ((device == DEVICE_FileAscii  ||  device == DEVICE_FileTeX)  &&
      filename == NULL)
  { if ((filename = FileRequest(NULL,
				(char *) WND_ASCIIFILE_TITLE,
				(device == DEVICE_FileTeX) ? "#?.tex" : ending,
				TRUE))
		  ==  NULL)
    { OutputReturnCode = RETURN_WARN;
      return(FALSE);
    }
  }

  if (!(titleOutput = GetStringMem(&OutputMemList, title))  ||
      !(prtheadOutput = GetStringMem(&OutputMemList, prthead))  ||
      !(scrheadOutput = GetStringMem(&OutputMemList, scrhead))  ||
       (filename != NULL  &&
	!(filenameOutput = GetStringMem(&OutputMemList, filename))))
  { TerminateOutput();
    OutputReturnCode = RETURN_ERROR;
    return(FALSE);
  }
  return(TRUE);
}
#endif  /*  AMIGA   */




/*
    TerminateOutput() gets called from the output functions if an error
    occurs or if the output is ended.
*/
void TerminateOutput(void)

#ifdef AMIGA
{
  PutMemList(&OutputMemList);
}
#endif  /*  AMIGA   */




/*
    ProcessOutput() gets called, if a list of lines to be printed is setup
    with lprint or "by hand". (see OutRound)

    Inputs: list -  list of lines to be printed; this can be NULL, in which
		    case OutputList is assumed
*/
void ProcessOutput(void)

#ifdef AMIGA
{ struct MinNode *line;


  /*
      Output to a file is rather simple...
  */
  if (deviceOutput == DEVICE_FileAscii  ||  deviceOutput == DEVICE_FileTeX)
  { FILE *fh;

    if ((fh = fopen(filenameOutput, "w"))  ==  NULL)
    { ShowError((char *) MSG_NO_WRITE_FILE,
		filenameOutput, IoErr());
      OutputReturnCode = RETURN_ERROR;
      return;
    }

    if (deviceOutput == DEVICE_FileAscii  &&
	(fputs(TrnName, fh) < 0  ||  fputs("\n\n", fh) < 0  ||
	 fputs(titleOutput, fh) < 0  ||  fputs("\n\n", fh) < 0  ||
	 fputs(prtheadOutput, fh) < 0  ||  fputs("\n\n", fh) < 0))
    { OutputReturnCode = RETURN_ERROR;
    }
    else
    { for(line = OutputList.mlh_Head;  line->mln_Succ != NULL;
	  line = line->mln_Succ)
      { if (fputs((char *) (line+1), fh) < 0  ||
	    fputc('\n', fh) == EOF)
	{ OutputReturnCode = RETURN_ERROR;
	  break;
	}
      }
    }
    fclose(fh);
  }

  /*
      Output to the printer is a little bit more complicated, because it
      is page oriented. The largest problem is to get the paper length.
      Sigh! Why are the new preferences that complicated?
  */
  else if (deviceOutput != DEVICE_Screen)
  { int paperlen, pagenr, lines;
    FILE *fh;
    int j, writeerr;

    /*
	Get the paperlength
    */
    struct Preferences Prefs;

    GetPrefs(&Prefs, sizeof(Prefs));
    paperlen = Prefs.PaperLength;
#ifdef V39_INCLUDES
    { struct IFFHandle *iffhandle;
      struct StoredProperty *sp;
      int ifferr;
      extern struct Library *IFFParseBase;
      extern struct Library *SysBase;

      if(IFFParseBase != NULL  &&  SysBase->LibNode.lib_Version >= 37)
      { if ((iffhandle = AllocIFF())  !=  NULL)
	{ if ((iffhandle->iff_Stream = Open((STRPTR) "ENV:SYS/Printer.prefs",
					    MODE_OLDFILE))
				     !=  NULL)
	  { InitIFFasDOS(iffhandle);
	    if (OpenIFF(iffhandle, IFFF_READ)  ==  0)
	    { if (PropChunk(iffhandle, ID_PREF, ID_PTXT)  ==  0)
	      { for(;;)
		{ ifferr = ParseIFF(iffhandle, IFFPARSE_STEP);
		  if (ifferr  !=  0)
		  { if (ifferr  ==  IFFERR_EOC)
		    { continue;
		    }
		    else
		    { break;
		    }
		  }

		  if ((sp = FindProp(iffhandle, ID_PREF, ID_PTXT))
			  !=  NULL)
		  { paperlen = ((struct PrinterTxtPrefs *)
			       (sp->sp_Data))->pt_PaperLength;
		    break;
		  }
		}
	      }
	      CloseIFF(iffhandle);
	    }
	    Close(iffhandle->iff_Stream);
	  }
	  FreeIFF(iffhandle);
	}
      }
    }
#endif


    if ((fh = fopen("prt:", "w"))  ==  NULL)
    { ShowError((char *) MSG_NO_PRINTER);
      OutputReturnCode = RETURN_ERROR;
      return;
    }
    writeerr = TRUE;

    /*
	Put application into sleep mode.
    */
    set(App, MUIA_Application_Sleep, TRUE);

    /*
	Put printer into draft or LQ mode
    */
    if (fprintf(fh, "%s",
		(deviceOutput == DEVICE_PrinterDraft)  ?
		    "\2331\"z" : "\2332\"z")    <  0)
    { goto WriteError;
    }


    line = OutputList.mlh_Head;
    pagenr = 0;
    while (line->mln_Succ != NULL)
    {
      if (fprintf(fh, "%s\n\n", TrnName)  <  0                  ||
	  fprintf(fh, "%-65s  %7s %d\n\n", titleOutput,
		  MSG_PAGENR, ++pagenr)  <  0   ||
	  fprintf(fh, "%s\n\n", prtheadOutput)  <  0)
      { goto WriteError;
      }
      lines = 7 + prtlinesOutput;

      while (lines+prtlinesOutput < paperlen  &&  line->mln_Succ != NULL)
      { lines += prtlinesOutput;
	for (j = 0;  j < prtlinesOutput;  j++)
	{ if (fprintf(fh, "%s\n", line+1)  <  0)
	  { goto WriteError;
	  }
	  line = line->mln_Succ;
	}
      }

      while (lines++ < paperlen)
      { if (fprintf(fh, "\n")  <  0)
	{ goto WriteError;
	}
      }

      if (fprintf(fh, "\n%s\n", PVERSION)  <  0     ||
	  fprintf(fh, "\f")  <  0)
      { goto WriteError;
      }
    }
    writeerr = FALSE;

WriteError:
    fclose(fh);
    if (writeerr)
    { ShowError((char *) MSG_PrinterError);
    }

    /*
	Awake application
    */
    set(App, MUIA_Application_Sleep, FALSE);
  }

  /*
      At last output to the screen, which isn't very complicated too.
      Thanks MUI.
  */
  else
  { ULONG open, signal;
    APTR OutWnd;        /*  output window                       */
    APTR OutWnd_Head;   /*  page head gadget                    */
    APTR OutWnd_LV;     /*  output text gadget                  */

    OutWnd = WindowObject,
		MUIA_Window_ID, MAKE_ID('O','U','T','\0'),
		MUIA_Window_Width, MUIV_Window_Width_MinMax(70),
		MUIA_Window_Height, MUIV_Window_Height_MinMax(30),
		MUIA_Window_Title, titleOutput,
		WindowContents, VGroup,
		    Child, OutWnd_Head = TextObject,
			MUIA_Text_Contents, scrheadOutput,
			ReadListFrame,
			MUIA_Font, MUIV_Font_Fixed,
		    End,
		    Child, OutWnd_LV = ListviewObject,
			MUIA_Listview_List, FloattextObject,
			    MUIA_Floattext_Text, OutputLine,
			    ReadListFrame,
			    MUIA_Font, MUIV_Font_Fixed,
			End,
		    End,
		End,
	    End;

    if (!OutWnd)
    { return;
    }


    /*
	Add the new window as a member to the application.
	Setting up the notification events for the output window:
	CloseWindow gadget only
    */
#define ID_OutWnd_Cancel 100
    DoMethod(App, OM_ADDMEMBER, OutWnd);
    DoMethod(OutWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	     App, 2, MUIM_Application_ReturnID, ID_OutWnd_Cancel);

    /*
	Open the window
    */
    set(OutWnd, MUIA_Window_Open, TRUE);
    get(OutWnd, MUIA_Window_Open, &open);
    if (!open)
    { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
      DoMethod(App, OM_REMMEMBER, OutWnd);
      MUI_DisposeObject(OutWnd);
      return;
    }

    /*
	Close the main window while the output window is open
    */
    set(MainWnd, MUIA_Window_Open, FALSE);

    /*
	Wait for user actions
    */
    for(;;)
    { switch(DoMethod(App, MUIM_Application_Input, &signal))
      { case MUIV_Application_ReturnID_Quit:
	  if (TestSaved())
	  { exit(0);
	  }
	  break;
	case ID_OutWnd_Cancel:
	  set(OutWnd, MUIA_Window_Open, FALSE);
	  DoMethod(App, OM_REMMEMBER, OutWnd);
	  MUI_DisposeObject(OutWnd);
	  return;
      }

      if (signal)
      { Wait(signal);
      }
    }
  }
}
#endif  /*  AMIGA   */




/*
    AskForBirthday() should bring up a requester and ask for the birthday
    of a player whose birthday field isn't set or valid.

    Inputs: plr - the player who is asked for

    Results: 1 = Assume that player is 20 or younger
	     2 = Assume that player is between 21 and 25 years old
	     3 = Assume that player is 26 or older
	     4 = The player wants to modify the players data
	     5 = Skip this player (will not be present in the DWZ report)
	     0 = Cancel
*/
int AskForBirthday(struct Player *plr)

#ifdef AMIGA
{
  return(MUI_Request(App, MainWnd, 0,
		     (char *) MSG_ATTENTION,
		     (char *) MSG_NO_BIRTHDAY_GADGETS,
		     (char *) MSG_NO_BIRTHDAY,
		     plr->Name));
}
#endif  /*  AMIGA   */
