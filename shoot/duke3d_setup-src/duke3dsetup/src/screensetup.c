#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <graphics/gfx.h>
#include <graphics/displayinfo.h>
#include <libraries/gadtools.h>
#include <libraries/asl.h>
#include <proto/dos.h>
#include <proto/asl.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/gadtools.h>
#include <cybergraphx/cybergraphics.h>
#include <proto/cybergraphics.h>

#include "dukesetupgui.h"
#include "amigasetupstructs.h"
#include "screensetup.h"

extern LONG request(STRPTR title, STRPTR bodytext, STRPTR reqtext);
void error_exit(STRPTR errormessage);

extern struct IntuitionBase *IntuitionBase;
extern struct GfxBase       *GfxBase;
extern struct Library       *GadToolsBase;
extern struct Library       *AslBase;

struct Library *CyberGfxBase;

/*****************************************************************************
    ScreenSetup
 *****************************************************************************/
void ScreenSetup(ScreenData *theScreenData)
{
    struct IntuiMessage *im;
    struct IntuiMessage imsg;
    struct Gadget *gad;
    ScreenData currentScreenData;
    UWORD imsgcode;
    BOOL done=FALSE;

    CopyMem(theScreenData,&currentScreenData,sizeof(ScreenData));

    CyberGfxBase = (struct Library *) OpenLibrary((UBYTE *)"cybergraphics.library",41L);

    if(OpenscreenWindow())
	error_exit("Couldn't open screensetup-window!");


    SetScreenGadgets(&currentScreenData);

    while( !done )
    {
	while( !( im = (struct IntuiMessage *)GT_GetIMsg( screenWnd->UserPort ) ) )
	    WaitPort( screenWnd->UserPort );

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
		    case GD_screen_mode:
			if(RequestScreenMode(&currentScreenData))
			{
			    GT_SetGadgetAttrs( screenGadgets[GD_screen_modedesc],screenWnd,NULL,
					       GTTX_Text,(int)currentScreenData.mode_name,
					       TAG_DONE);

			    if(currentScreenData.cgfx)
			    {
				GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
						   GA_Disabled,FALSE,
						   TAG_DONE);

				GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
						   GA_Disabled,FALSE,
						   TAG_DONE);
			    }
			    else
			    {
				currentScreenData.direct=FALSE;

				GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
						   GTCB_Checked,FALSE,
						   GA_Disabled,TRUE,
						   TAG_DONE);

				GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
						   GA_Disabled,FALSE,
						   TAG_DONE);
			    }
			}
		    break;

		    case GD_screen_dblbuffer:
			currentScreenData.dblbuffer=imsg.Code;
			if(currentScreenData.dblbuffer==FALSE)
			{
			    currentScreenData.direct=FALSE;

			    GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
					       GTCB_Checked,FALSE,
					       GA_Disabled,TRUE,
					       TAG_DONE);
			}
			else
			{
			    if(currentScreenData.cgfx)
			    {
				GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
						   GA_Disabled,FALSE,
						   TAG_DONE);
			    }
			}
		    break;

		    case GD_screen_directaccess:
			currentScreenData.direct=imsg.Code;
			if(currentScreenData.direct==TRUE)
			{
			    currentScreenData.dblbuffer=TRUE;

			    GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
					       GTCB_Checked,TRUE,
					       GA_Disabled,TRUE,
					       TAG_DONE);
			}
			else
			{
			    GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
					       GA_Disabled,FALSE,
					       TAG_DONE);
			}
		    break;

		    case GD_screen_ok:
			CopyMem(&currentScreenData,theScreenData,sizeof(ScreenData));
			done=TRUE;
		    break;

		    case GD_screen_cancel:
			done=TRUE;
		    break;
		}
	    break;
	}
    }
    ClosescreenWindow();
    if (CyberGfxBase) CloseLibrary(( struct Library *)CyberGfxBase);
}

/*****************************************************************************
    MakeDefaultScreenData
 *****************************************************************************/
void MakeDefaultScreenData(ScreenData *sd)
{
    sd->modeid=LORES_KEY;
    sd->width=320;
    sd->height=200;
    sd->dblbuffer=TRUE;
    sd->direct=FALSE;
    sd->cgfx=FALSE;

    GetScreenModeName(sd);
}

/*****************************************************************************
    SetScreenGadgets
 *****************************************************************************/
void SetScreenGadgets(ScreenData *sd)
{
    /* set mode-name */
    GT_SetGadgetAttrs( screenGadgets[GD_screen_modedesc],screenWnd,NULL,
		       GTTX_Text,(int)sd->mode_name,
		       TAG_DONE);

    /* set dblbuffer */
    if(sd->cgfx)
    {
	if(sd->direct)
	{
	    GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
			       GTCB_Checked,sd->dblbuffer,
			       GA_Disabled,TRUE,
			       TAG_DONE);
	}
	else
	{
	    GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
			       GTCB_Checked,sd->dblbuffer,
			       GA_Disabled,FALSE,
			       TAG_DONE);
	}
    }
    else
    {
	GT_SetGadgetAttrs( screenGadgets[GD_screen_dblbuffer],screenWnd,NULL,
			   GTCB_Checked,sd->dblbuffer,
			   GA_Disabled,FALSE,
			   TAG_DONE);
    }

    /* set direct access */
    if(sd->cgfx)
    {
	if(sd->dblbuffer)
	{
	    GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
			       GTCB_Checked,sd->direct,
			       GA_Disabled,FALSE,
			       TAG_DONE);
	}
	else
	{
	    GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
			       GTCB_Checked,sd->direct,
			       GA_Disabled,TRUE,
			       TAG_DONE);
	}
    }
    else
    {
	GT_SetGadgetAttrs( screenGadgets[GD_screen_directaccess],screenWnd,NULL,
			   GTCB_Checked,FALSE,
			   GA_Disabled,TRUE,
			   TAG_DONE);
    }
}

/*****************************************************************************
    GetScreenModeName
 *****************************************************************************/
void GetScreenModeName(ScreenData *sd)
{
    struct NameInfo nameinfo;
    int res;

    res=GetDisplayInfoData(0,(APTR)&nameinfo,sizeof(struct NameInfo),DTAG_NAME,sd->modeid);

    if(res)
    {
	CopyMem(nameinfo.Name,sd->mode_name,DISPLAYNAMELEN);
	sd->mode_name[DISPLAYNAMELEN+1]=0;
    }
    else
    {
	if(sd->cgfx)
	{
	    LONG w,h;

	    w=GetCyberIDAttr(CYBRIDATTR_WIDTH,sd->modeid);
	    h=GetCyberIDAttr(CYBRIDATTR_HEIGHT,sd->modeid);
	    sprintf(sd->mode_name,"CGFX: %ldx%ld",w,h);
	}
	else
	{
	    LONG w,h;
	    struct DimensionInfo di;

	    GetDisplayInfoData(NULL,(APTR)&di,sizeof(struct DimensionInfo),DTAG_DIMS,sd->modeid);

	    w=di.Nominal.MaxX - di.Nominal.MinX + 1;
	    h=di.Nominal.MaxY - di.Nominal.MinY + 1;
	    sprintf(sd->mode_name,"AGA: %ldx%ld",w,h);
	}
    }
}

/*****************************************************************************
    SMFilterFunc
 *****************************************************************************/
#define REG(reg,arg)  arg __asm( #reg )

LONG __interrupt __saveds SMFilterFunc(REG(a0,struct Hook *Hook),REG(a1,ULONG DisplayID),REG(a2,struct ScreenModeRequester *SMReq))
{
    /* filter all cgfx-modes with pixelformat != PIXFMT_LUT8 */

    if(CyberGfxBase)
    {
	if (IsCyberModeID(DisplayID))
	{
	    return (GetCyberIDAttr(CYBRIDATTR_PIXFMT,DisplayID)==PIXFMT_LUT8);
	}
    }
    return TRUE;
}

/*****************************************************************************
    RequestScreenMode
 *****************************************************************************/
BOOL RequestScreenMode(ScreenData *sd)
{
    struct ScreenModeRequester *request;
    BOOL suc=FALSE;
    struct Hook SMFilterHook;

    SMFilterHook.h_MinNode.mln_Succ=NULL;
    SMFilterHook.h_MinNode.mln_Pred=NULL;
    SMFilterHook.h_Entry=(void*)SMFilterFunc;
    SMFilterHook.h_SubEntry=NULL;
    SMFilterHook.h_Data=NULL;


    request=(struct ScreenModeRequester*)
	    AllocAslRequestTags(ASL_ScreenModeRequest,
				ASLSM_Window,(int)screenWnd,
				ASLSM_SleepWindow,1,
				ASLSM_TitleText,(int)"Select a mode",
				ASLSM_InitialDisplayID,sd->modeid,
				ASLSM_InitialDisplayWidth,sd->width,
				ASLSM_InitialDisplayHeight,sd->height,
				ASLSM_DoAutoScroll,0,
				ASLSM_DoDepth,0,
				ASLSM_DoOverscanType,0,
				ASLSM_MinDepth,8,
				ASLSM_MaxDepth,8,
				ASLSM_PropertyFlags,0,
				ASLSM_PropertyMask,DIPF_IS_DUALPF | DIPF_IS_PF2PRI | DIPF_IS_HAM | DIPF_IS_ECS | DIPF_IS_EXTRAHALFBRITE,
				ASLSM_FilterFunc,(int)&SMFilterHook,
				TAG_DONE);
    if(request)
    {
	if(AslRequestTags(request,NULL))
	{
	    sd->modeid=request->sm_DisplayID;
	    sd->width=request->sm_DisplayWidth;
	    sd->height=request->sm_DisplayHeight;

	    sd->cgfx=FALSE;
	    if(CyberGfxBase)
	    {
		if (IsCyberModeID(sd->modeid))
		    sd->cgfx=TRUE;
	    }

	    GetScreenModeName(sd);

	    suc=TRUE;
	    FreeAslRequest(request);
	}
    }
    return suc;
}

