#include <stdio.h>
#include <exec/types.h>
#include <exec/libraries.h>
#include "wsearch.h"
#include "interface.h"
#include "funcs.h"
#include <libraries/ReqBase.h>

char word[MAXWORD][MAXSIZE+1];
char *puzzle=NULL, *key=NULL, *display=NULL;

int px=PXINIT,py=PYINIT,w,filter=255,rot=1;
BOOL LWActive=FALSE, DispKey = TRUE;

void main()
 {
   BOOL close_me;

    if(init()==FALSE) goto finish;

    if(Dimensions()==FALSE) goto finish;
    NewKey();
    NewPuzzle();
    NewDisplay();
    Msg.Class = NEWSIZE;
    puzdisplay();

    close_me = FALSE;

    while( close_me == FALSE )
     {
        Wait((1 << WLWin->UserPort->mp_SigBit)|
             (1 << DPWin->UserPort->mp_SigBit));
        IMsg=(struct IntuiMessage *)GetMsg(WLWin->UserPort);
        while(IMsg)
         {
            Msg.Class = IMsg->Class;
            Msg.IAddress = IMsg->IAddress;
            Msg.Code = IMsg->Code;
	    
	    if(Msg.Class==MENUVERIFY && Msg.Code==MENUHOT)
	    /* this code is currently disable since it can lock on a menu
	       selection and changing it clear all pending messages */
	    {
		if(LastWord->Flags|SELECTED!=0)
			LWActive=TRUE;
		else
			LWActive=FALSE;
	    }	
            
	    ReplyMsg( IMsg );

            if(Msg.Class == MENUPICK)
                menuctrl();
            else if(Msg.Class == CLOSEWINDOW)
                close_me = TRUE;
            else
                wordlist();
            while(IMsg=(struct IntuiMessage *)GetMsg(WLWin->UserPort))
            {
                if(IMsg->Class!=MOUSEMOVE) break;
                ReplyMsg(IMsg);/* Purge excessive MOUSEMOVE cmds */
            }
          }
        IMsg=(struct IntuiMessage *)GetMsg(DPWin->UserPort);
        while(IMsg)
         {
            Msg.Class = IMsg->Class;
            Msg.Code = IMsg->Code;
            ReplyMsg( IMsg );
	    
	    LWActive = FALSE;
	    
            if(Msg.Class == MENUPICK)
                menuctrl();
            else if(Msg.Class == CLOSEWINDOW)
                close_me = TRUE;
            else
                puzdisplay();
            while(IMsg=(struct IntuiMessage *)GetMsg(DPWin->UserPort))
            {
                if(IMsg->Class!=MOUSEMOVE) break;
                ReplyMsg(IMsg);/* Purge excessive MOUSEMOVE cmds */
            }
          }
     }

    finish:
        if(WLWin!=NULL)
        {
                ClearMenuStrip(WLWin);
                CloseWindow(WLWin);
        }
        if(DPWin!=NULL)
        {
                ClearMenuStrip(DPWin);
                CloseWindow(DPWin);
        }
        if(IntuitionBase!=NULL) CloseLibrary(IntuitionBase);
        if(ReqBase!=NULL) CloseLibrary(ReqBase);
        if(GfxBase!=NULL) CloseLibrary(GfxBase);
    return;
 }

