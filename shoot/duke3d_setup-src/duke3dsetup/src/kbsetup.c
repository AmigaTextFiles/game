#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <libraries/gadtools.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>

#include "dukesetupgui.h"
#include "amigasetupstructs.h"
#include "kbsetup.h"

#include <proto/lowlevel.h>

extern LONG request(STRPTR title, STRPTR bodytext, STRPTR reqtext);
void error_exit(STRPTR errormessage);

extern struct IntuitionBase *IntuitionBase;
extern struct Library       *GadToolsBase;
extern struct Library       *LowLevelBase;

extern char *gamefunctions[];

char kblistnames[52][64];

UBYTE primlastchanged[52];

struct Node kblistview_nodes[52];

struct List kblistview_list =
{
	&kblistview_nodes[0],
	NULL,
	&kblistview_nodes[52],
	0,
	0,
};

extern char *kbnames[128];

static WORD keydefaults[] =
{
    AMIKB_UP,           AMIKB_KP8, 
    AMIKB_DOWN,         AMIKB_KP2, 
    AMIKB_LEFT,         AMIKB_KP4, 
    AMIKB_RIGHT,        AMIKB_KP6, 
    AMIKB_LALT,         AMIKB_RALT, 
    AMIKB_LCTRL,        AMIKB_RCTRL, 
    AMIKB_SPACE,        -1, 
    AMIKB_LSHIFT,       AMIKB_RSHIFT,
    AMIKB_CAPSLOCK,     -1,
    AMIKB_A,            AMIKB_SLASH, 
    AMIKB_Z,            -1, 
    AMIKB_PAGEUP,       -1, 
    AMIKB_PAGEDOWN,     -1,
    AMIKB_INSERT,       -1,
    AMIKB_DEL,          AMIKB_DELETE, 
    AMIKB_COMMA,        -1, 
    AMIKB_PERIOD,       -1, 
    AMIKB_HOME,         -1, 
    AMIKB_END,          -1,
    AMIKB_1,            -1, 
    AMIKB_2,            -1, 
    AMIKB_3,            -1, 
    AMIKB_4,            -1, 
    AMIKB_5,            -1, 
    AMIKB_6,            -1, 
    AMIKB_7,            -1, 
    AMIKB_8,            -1, 
    AMIKB_9,            -1, 
    AMIKB_0,            -1, 
    AMIKB_RETURN,       AMIKB_KP_ENTER, 
    AMIKB_LEFTBRACKET,  -1, 
    AMIKB_RIGHTBRACKET, -1, 
    AMIKB_H,            -1, 
    AMIKB_J,            -1, 
    AMIKB_N,            -1, 
    AMIKB_M,            -1, 
    AMIKB_BACKSPACE,    -1, 
    AMIKB_T,            -1, 
    AMIKB_TAB,          -1, 
    AMIKB_MINUS,        AMIKB_KP_MINUS, 
    AMIKB_EQUALS,       AMIKB_KP_PLUS, 
    AMIKB_KP5,          -1, 
    AMIKB_SCROLLOCK,    -1, 
    AMIKB_W,            -1, 
    AMIKB_F,            -1, 
    AMIKB_K,            -1, 
    AMIKB_U,            -1, 
    AMIKB_I,            -1, 
    AMIKB_R,            -1, 
    AMIKB_QUOTE,        -1, 
    AMIKB_BACKQUOTE,    -1, 
    AMIKB_SEMICOLON,    -1 
};


static char *joystickdefaults[] =
   {
   "Fire",
   "Strafe",
   "Run",
   "Open",
   "Aim_Down",
   "Look_Right",
   "Aim_Up",
   "Look_Left",
   };


static char *joystickclickeddefaults[] =
   {
   "",
   "Inventory",
   "Jump",
   "Crouch",
   "",
   "",
   "",
   "",
   };


static char *mouseanalogdefaults[] =
   {
   "analog_turning",
   "analog_moving",
   };


static char *mousedigitaldefaults[] =
   {
   "",
   "",
   "",
   "",
   };


static char *gamepaddigitaldefaults[] =
   {
   "Turn_Left",
   "Turn_Right",
   "Move_Forward",
   "Move_Backward",
   };


static char *joystickanalogdefaults[] =
   {
   "analog_turning",
   "analog_moving",
   "analog_strafing",
   "",
   };


static char *joystickdigitaldefaults[] =
   {
   "",
   "",
   "",
   "",
   "",
   "",
   "Run",
   "",
   };

/*****************************************************************************
    KeyboardSetup
 *****************************************************************************/
void KeyboardSetup(KeyboardData *theKbData)
{
    struct IntuiMessage *im;
    struct IntuiMessage imsg;
    struct Gadget *gad;
    KeyboardData currentKbData;
    BOOL done=FALSE;
    WORD key;


    if(OpenkeyboardWindow())
	error_exit("Couldn't open keyboardsetup-window!");

    CopyMem(theKbData,&currentKbData,sizeof(KeyboardData));
    GenerateKbListNames(&currentKbData);
    SetKeyboardGadgets(&currentKbData);

    memset(primlastchanged,0,52);

    while(!done)
    {
	while(!(im=(struct IntuiMessage*)GT_GetIMsg(keyboardWnd->UserPort)))
	    WaitPort(keyboardWnd->UserPort);

	imsg = *im;
	gad=(struct Gadget *)imsg.IAddress;
	GT_ReplyIMsg( im );

	switch( imsg.Class )
	{
	    case CLOSEWINDOW:
		done=TRUE;
	    break;

	    case GADGETUP:
		switch( gad->GadgetID )
		{
		    case GD_kb_listview:
			key=GetKeyRequest();
			if(key!=-1 && currentKbData.primary_kbassigns[imsg.Code]!=key && currentKbData.secondary_kbassigns[imsg.Code]!=key)
			{
			    LONG i;
			    BOOL suc;

			    i=0;
			    suc=FALSE;
			    while(!suc && i<52)
			    {
				if(currentKbData.primary_kbassigns[i]!=key)
				    i++;
				else
				    suc=TRUE;
			    }
			    if(suc)
			    {
				ShowUsedWarning(key,i);
				currentKbData.primary_kbassigns[i]=-1;
				MakeSingleKbListName(&currentKbData,i);
			    }

			    i=0;
			    suc=FALSE;
			    while(!suc && i<52)
			    {
				if(currentKbData.secondary_kbassigns[i]!=key)
				    i++;
				else
				    suc=TRUE;
			    }
			    if(suc)
			    {
				ShowUsedWarning(key,i);
				currentKbData.secondary_kbassigns[i]=-1;
				MakeSingleKbListName(&currentKbData,i);
			    }


			    if(currentKbData.primary_kbassigns[imsg.Code]!=-1 && currentKbData.secondary_kbassigns[imsg.Code]!=-1)
			    {
				if(!primlastchanged[imsg.Code])
				{
				    currentKbData.primary_kbassigns[imsg.Code]=key;
				    primlastchanged[imsg.Code]=1;
				}
				else
				{
				    currentKbData.secondary_kbassigns[imsg.Code]=key;
				    primlastchanged[imsg.Code]=0;
				}
			    }
			    else if(currentKbData.primary_kbassigns[imsg.Code]==-1)
			    {
				currentKbData.primary_kbassigns[imsg.Code]=key;
			    }
			    else
			    {
				currentKbData.secondary_kbassigns[imsg.Code]=key;
			    }
			    MakeSingleKbListName(&currentKbData,imsg.Code);
			}
		    break;

		    case GD_kb_defaults:
			MakeDefaultKeyboardData(&currentKbData);
			GenerateKbListNames(&currentKbData);
			SetKeyboardGadgets(&currentKbData);
			memset(primlastchanged,0,52);
		    break;

		    case GD_kb_ok:
			CopyMem(&currentKbData,theKbData,sizeof(KeyboardData));
			done=TRUE;
		    break;

		    case GD_kb_cancel:
			done=TRUE;
		    break;
		}
	    break;
	}
    }
    ClosekeyboardWindow();
}

/*****************************************************************************
    MakeDefaultKeyboardData
 *****************************************************************************/
void MakeDefaultKeyboardData(KeyboardData *kb)
{
    LONG i;

    for(i=0;i<52;i++)
    {
	kb->primary_kbassigns[i]=keydefaults[i*2];
	kb->secondary_kbassigns[i]=keydefaults[i*2+1];
    }
}

/*****************************************************************************
    SetKeyboardGadgets
 *****************************************************************************/
void SetKeyboardGadgets(KeyboardData *kb)
{
    LONG i;

    kblistview_nodes[0].ln_Succ = &kblistview_nodes[1];
    kblistview_nodes[0].ln_Pred = (struct Node*)&kblistview_list.lh_Head;
    kblistview_nodes[0].ln_Type = 0;
    kblistview_nodes[0].ln_Pri = 0;
    kblistview_nodes[0].ln_Name = kblistnames[0];

    for(i=1;i<51;i++)
    {
	kblistview_nodes[i].ln_Succ = &kblistview_nodes[i+1];
	kblistview_nodes[i].ln_Pred = &kblistview_nodes[i-1];
	kblistview_nodes[i].ln_Type = 0;
	kblistview_nodes[i].ln_Pri = 0;
	kblistview_nodes[i].ln_Name = kblistnames[i];
    }

    kblistview_nodes[i].ln_Succ = (struct Node*)&kblistview_list.lh_Tail;
    kblistview_nodes[i].ln_Pred = &kblistview_nodes[i-1];
    kblistview_nodes[i].ln_Type = 0;
    kblistview_nodes[i].ln_Pri = 0;
    kblistview_nodes[i].ln_Name = kblistnames[i];

    /* set mode-name */
    GT_SetGadgetAttrs( keyboardGadgets[GD_kb_listview],keyboardWnd,NULL,
		       GTLV_Labels,(int)&kblistview_list,
		       TAG_DONE);
}

/*****************************************************************************
    MakeSingleKbListName
 *****************************************************************************/
void MakeSingleKbListName(KeyboardData *kb, LONG number)
{
    LONG s,d;
    char *cursrc, *curdst;

    s=d=0;
    curdst=kblistnames[number];
    cursrc=gamefunctions[number];
    while(cursrc[s])
    {
	curdst[d]=cursrc[s];
	s++;
	d++;
    }

    while(d<24)
    {
	curdst[d]=0x20;
	d++;
    }

    s=0;
    if(kb->primary_kbassigns[number]!=-1)
    {
	cursrc=kbnames[kb->primary_kbassigns[number]];
	while(cursrc[s])
	{
	    curdst[d]=cursrc[s];
	    s++;
	    d++;
	}
    }

    while(d<32)
    {
	curdst[d]=0x20;
	d++;
    }

    s=0;
    if(kb->secondary_kbassigns[number]!=-1)
    {
	cursrc=kbnames[kb->secondary_kbassigns[number]];
	while(cursrc[s])
	{
	    curdst[d]=cursrc[s];
	    s++;
	    d++;
	}
    }

    curdst[d]=0;

    /* set mode-name */
    GT_SetGadgetAttrs( keyboardGadgets[GD_kb_listview],keyboardWnd,NULL,
		       GTLV_Labels,(int)&kblistview_list,
		       TAG_DONE);
}

/*****************************************************************************
    GenerateKbListNames
 *****************************************************************************/
void GenerateKbListNames(KeyboardData *kb)
{
    LONG i,s,d;
    char *cursrc, *curdst;

    for(i=0;i<52;i++)
    {
	s=d=0;
	curdst=kblistnames[i];
	cursrc=gamefunctions[i];
	while(cursrc[s])
	{
	    curdst[d]=cursrc[s];
	    s++;
	    d++;
	}

	while(d<24)
	{
	    curdst[d]=0x20;
	    d++;
	}

	s=0;
	if(kb->primary_kbassigns[i]!=-1)
	{
	    cursrc=kbnames[kb->primary_kbassigns[i]];
	    while(cursrc[s])
	    {
		curdst[d]=cursrc[s];
		s++;
		d++;
	    }
	}

	while(d<32)
	{
	    curdst[d]=0x20;
	    d++;
	}

	s=0;
	if(kb->secondary_kbassigns[i]!=-1)
	{
	    cursrc=kbnames[kb->secondary_kbassigns[i]];
	    while(cursrc[s])
	    {
		curdst[d]=cursrc[s];
		s++;
		d++;
	    }
	}

	curdst[d]=0;
    }
}

/*****************************************************************************
    GetKeyRequest

	- this a little strange, i couldn't get the requester
	  to always return RAWKEY for a pressed key :(
	  now i'm doing this via lowlevel.library...

 *****************************************************************************/
WORD GetKeyRequest( void )
{
    struct Window *req;
    struct IntuiMessage *msg;
    unsigned long iclass;
    unsigned short code;
    struct Gadget *gad;
    BOOL done=FALSE;
    WORD ret=-1;

    struct EasyStruct es =
    {
	sizeof(struct EasyStruct),
	0,
	"Getkey",
	"Please press a key, or click abort...",
	"Abort"
    };


    req=BuildEasyRequest(NULL,&es,GADGETUP | RAWKEY);

    while(!done)
    {
	WaitPort(req->UserPort);

	while((msg = (struct IntuiMessage *)GetMsg(req->UserPort)))
	{
	    iclass = msg->Class;
	    code = msg->Code;
	    gad=(struct Gadget *)msg->IAddress;
	    ReplyMsg((struct Message *)msg);

	    if(iclass==GADGETUP)
	    {
		ret=-1;
		done=TRUE;
	    }
	    else if(iclass==RAWKEY)
	    {
		ret=code;
		done=TRUE;
	    }
	    else
	    {
		ret=GetKey();
		done=TRUE;
	    }
	}
    }
    FreeSysRequest(req);
    return(ret);
}

/*****************************************************************************
    ShowUsedWarning
 *****************************************************************************/
void ShowUsedWarning( WORD key, LONG action )
{
    LONG i,s,d;
    char *cursrc;
    char warntext[128];
    char *defaultwarn=" has already been assigned to ";

    i=0;

    s=d=0;
    cursrc=kbnames[key];
    while(cursrc[s])
    {
	warntext[d]=cursrc[s];
	s++;
	d++;
    }

    s=0;
    while(defaultwarn[s])
    {
	warntext[d]=defaultwarn[s];
	s++;
	d++;
    }

    s=0;
    cursrc=gamefunctions[action];
    while(cursrc[s])
    {
	warntext[d]=cursrc[s];
	s++;
	d++;
    }
    warntext[d]=0;

    request("Warning!",warntext,"OK");
}

