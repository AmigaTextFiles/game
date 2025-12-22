#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <libraries/gadtools.h>
#include <libraries/asl.h>
#include <proto/dos.h>
#include <proto/asl.h>
#include <proto/exec.h>
#include <proto/gadtools.h>
#include <proto/intuition.h>

#include "dukesetupgui.h"
#include "amigasetupstructs.h"
#include "mousesetup.h"

extern LONG request(STRPTR title, STRPTR bodytext, STRPTR reqtext);
void error_exit(STRPTR errormessage);

extern struct IntuitionBase *IntuitionBase;
extern struct Library       *GadToolsBase;

extern char *gamefunctions[];

struct Node mactslistview_nodes[53];

struct List mactslistview_list =
{
	&mactslistview_nodes[0],
	NULL,
	&mactslistview_nodes[52],
	0,
	0,
};

/*****************************************************************************
    MouseSetup
 *****************************************************************************/
void MouseSetup(MouseData *theMouseData)
{
    LONG i;
    struct IntuiMessage *im;
    struct IntuiMessage imsg;
    struct Gadget *gad;
    MouseData currentMouseData;
    UWORD imsgcode;
    BOOL done=FALSE;
    WORD res;

    CopyMem(theMouseData,&currentMouseData,sizeof(MouseData));

    /* prepare list for mouse-actions */
    mactslistview_nodes[0].ln_Succ = &mactslistview_nodes[1];
    mactslistview_nodes[0].ln_Pred = (struct Node*)&mactslistview_list.lh_Head;
    mactslistview_nodes[0].ln_Type = 0;
    mactslistview_nodes[0].ln_Pri = 0;
    mactslistview_nodes[0].ln_Name = gamefunctions[0];

    for(i=1;i<52;i++)
    {
	mactslistview_nodes[i].ln_Succ = &mactslistview_nodes[i+1];
	mactslistview_nodes[i].ln_Pred = &mactslistview_nodes[i-1];
	mactslistview_nodes[i].ln_Type = 0;
	mactslistview_nodes[i].ln_Pri = 0;
	mactslistview_nodes[i].ln_Name = gamefunctions[i];
    }

    mactslistview_nodes[i].ln_Succ = (struct Node*)&mactslistview_list.lh_Tail;
    mactslistview_nodes[i].ln_Pred = &mactslistview_nodes[i-1];
    mactslistview_nodes[i].ln_Type = 0;
    mactslistview_nodes[i].ln_Pri = 0;
    mactslistview_nodes[i].ln_Name = gamefunctions[i];


    if(OpenmouseWindow())
    {
	error_exit("Couldn't open mousesetup-window!");
    }

    SetMouseGadgets(&currentMouseData);
    SetMouseActionGadgets(&currentMouseData);

    while( !done )
    {
	while( !( im = (struct IntuiMessage *)GT_GetIMsg( mouseWnd->UserPort ) ) )
	    WaitPort( mouseWnd->UserPort );

	imsg = *im;
	imsgcode=imsg.Code;
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
		    case GD_mouse_scl:
			res=GetMouseAction();
			if(res!=-1)
			{
			    if(res==52)
				currentMouseData.sc_l=-1;
			    else
				currentMouseData.sc_l=res;

			    SetMouseActionGadgets(&currentMouseData);
			}
		    break;

		    case GD_mouse_scm:
			res=GetMouseAction();
			if(res!=-1)
			{
			    if(res==52)
				currentMouseData.sc_m=-1;
			    else
				currentMouseData.sc_m=res;

			    SetMouseActionGadgets(&currentMouseData);
			}
		    break;

		    case GD_mouse_scr:
			res=GetMouseAction();
			if(res!=-1)
			{
			    if(res==52)
				currentMouseData.sc_r=-1;
			    else
				currentMouseData.sc_r=res;

			    SetMouseActionGadgets(&currentMouseData);
			}
		    break;

		    case GD_mouse_dcl:
			res=GetMouseAction();
			if(res!=-1)
			{
			    if(res==52)
				currentMouseData.dc_l=-1;
			    else
				currentMouseData.dc_l=res;

			    SetMouseActionGadgets(&currentMouseData);
			}
		    break;

		    case GD_mouse_dcm:
			res=GetMouseAction();
			if(res!=-1)
			{
			    if(res==52)
				currentMouseData.dc_m=-1;
			    else
				currentMouseData.dc_m=res;

			    SetMouseActionGadgets(&currentMouseData);
			}
		    break;

		    case GD_mouse_dcr:
			res=GetMouseAction();
			if(res!=-1)
			{
			    if(res==52)
				currentMouseData.dc_r=-1;
			    else
				currentMouseData.dc_r=res;

			    SetMouseActionGadgets(&currentMouseData);
			}
		    break;

		    case GD_mouse_sensi:
			currentMouseData.sensi=imsgcode;
		    break;

		    case GD_mouse_invert:
			currentMouseData.flipped=imsgcode;
		    break;

		    case GD_mouse_defaults:
			MakeDefaultMouseData(&currentMouseData);
			SetMouseGadgets(&currentMouseData);
			SetMouseActionGadgets(&currentMouseData);
		    break;

		    case GD_mouse_ok:
		    {
			LONG mx;
			GT_GetGadgetAttrs( mouseGadgets[GD_mouse_aimmode],mouseWnd,NULL,
					   GTMX_Active,(int)&mx,
					   TAG_DONE);

			currentMouseData.aimtype=mx;

			CopyMem(&currentMouseData,theMouseData,sizeof(MouseData));
			done=TRUE;
		    }
		    break;

		    case GD_mouse_cancel:
			done=TRUE;
		    break;
		}
	    break;
	}
    }
    ClosemouseWindow();
}

/*****************************************************************************
    GetMouseAction
 *****************************************************************************/
WORD GetMouseAction(void)
{
    struct IntuiMessage *im;
    struct IntuiMessage imsg;
    struct Gadget *gad;
    UWORD imsgcode;
    BOOL done=FALSE;
    WORD ret=-1;

    struct Requester lockreq;

    SetWindowPointer(mouseWnd,WA_BusyPointer,1,TAG_DONE);
    InitRequester(&lockreq);
    Request(&lockreq,mouseWnd);

    if(OpenmactsWindow())
    {
	error_exit("Couldn't open mouseactions-window!");
    }

    /* set action list */
    GT_SetGadgetAttrs( mactsGadgets[GD_mact_list],mactsWnd,NULL,
		       GTLV_Labels,(int)&mactslistview_list,
		       TAG_DONE);

    while( !done )
    {
	while( !( im = (struct IntuiMessage *)GT_GetIMsg( mactsWnd->UserPort ) ) )
	    WaitPort( mactsWnd->UserPort );

	imsg = *im;
	imsgcode=imsg.Code;
	gad=(struct Gadget *)imsg.IAddress;
	GT_ReplyIMsg( im );

	switch( imsg.Class )
	{
	    case CLOSEWINDOW:
		ret=-1;
		done=TRUE;
	    break;

	    case GADGETUP:
		switch( gad->GadgetID )
		{
		    case GD_mact_list:
			ret=imsgcode;
			done=TRUE;
		    break;

		    case GD_mact_abort:
			ret=-1;
			done=TRUE;
		    break;
		}
	    break;
	}
    }
    ClosemactsWindow();
    EndRequest(&lockreq,mouseWnd);
    SetWindowPointer(mouseWnd,WA_BusyPointer,0,TAG_DONE);
    return(ret);
}

/*****************************************************************************
    MakeDefaultMouseData
 *****************************************************************************/
void MakeDefaultMouseData(MouseData *md)
{
   md->sc_l=GF_Fire;
   md->sc_m=GF_Move_Forward;
   md->sc_r=GF_Strafe;

   md->dc_l=-1;
   md->dc_m=-1;
   md->dc_r=GF_Open;

   md->sensi=100;

   md->aimtype=AIM_TOGGLE;

   md->flipped=FALSE;
}

/*****************************************************************************
    SetMouseGadgets
 *****************************************************************************/
void SetMouseGadgets(MouseData *md)
{
    /* set sensitivity slider */
    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_sensi],mouseWnd,NULL,
		       GTSL_Level,md->sensi,
		       TAG_DONE);

    /* set aiming mode mx*/
    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_aimmode],mouseWnd,NULL,
		       GTMX_Active,md->aimtype,
		       TAG_DONE);

    /* set invert checkbox */
    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_invert],mouseWnd,NULL,
		       GTCB_Checked,md->flipped,
		       TAG_DONE);
}

/*****************************************************************************
    SetMouseActionGadgets
 *****************************************************************************/
void SetMouseActionGadgets(MouseData *md)
{
    char *text;
    char nofunc[]="(none)";

    /* set textgadgets for single clicked buttons */
    if(md->sc_l==-1)
	text=nofunc;
    else
	text=gamefunctions[md->sc_l];

    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_scl_text],mouseWnd,NULL,
		       GTTX_Text,(int)text,
		       TAG_DONE);

    if(md->sc_m==-1)
	text=nofunc;
    else
	text=gamefunctions[md->sc_m];

    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_scm_text],mouseWnd,NULL,
		       GTTX_Text,(int)text,
		       TAG_DONE);
    if(md->sc_r==-1)
	text=nofunc;
    else
	text=gamefunctions[md->sc_r];

    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_scr_text],mouseWnd,NULL,
		       GTTX_Text,(int)text,
		       TAG_DONE);

    /* set textgadgets for double clicked buttons */
    if(md->dc_l==-1)
	text=nofunc;
    else
	text=gamefunctions[md->dc_l];

    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_dcl_text],mouseWnd,NULL,
		       GTTX_Text,(int)text,
		       TAG_DONE);

    if(md->dc_m==-1)
	text=nofunc;
    else
	text=gamefunctions[md->dc_m];

    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_dcm_text],mouseWnd,NULL,
		       GTTX_Text,(int)text,
		       TAG_DONE);
    if(md->dc_r==-1)
	text=nofunc;
    else
	text=gamefunctions[md->dc_r];

    GT_SetGadgetAttrs( mouseGadgets[GD_mouse_dcr_text],mouseWnd,NULL,
		       GTTX_Text,(int)text,
		       TAG_DONE);

}

