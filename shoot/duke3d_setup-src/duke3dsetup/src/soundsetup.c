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

#include <proto/ahi.h>
#include <devices/ahi.h>

#include "dukesetupgui.h"
#include "amigasetupstructs.h"
#include "soundsetup.h"

extern LONG request(STRPTR title, STRPTR bodytext, STRPTR reqtext);
void error_exit(STRPTR errormessage);

extern struct IntuitionBase *IntuitionBase;
extern struct Library       *GadToolsBase;

struct Library      *AHIBase;
struct MsgPort      *AHImp     = NULL;
struct AHIRequest   *AHIio     = NULL;
BYTE                 AHIDevice = -1;

/*****************************************************************************
    SoundSetup
 *****************************************************************************/
void SoundSetup(SoundData *theSoundData)
{
    struct IntuiMessage *im;
    struct IntuiMessage imsg;
    struct Gadget *gad;
    SoundData currentSoundData;
    UWORD imsgcode;
    BOOL done=FALSE;

    CopyMem(theSoundData,&currentSoundData,sizeof(SoundData));

    if(!OpenAHI())
    {
	error_exit("Please install AHI!");
    }

    if(OpensoundWindow())
    {
	error_exit("Couldn't open soundsetup-window!");
    }


    SetSoundGadgets(&currentSoundData);

    while( !done )
    {
	while( !( im = (struct IntuiMessage *)GT_GetIMsg( soundWnd->UserPort ) ) )
	    WaitPort( soundWnd->UserPort );

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
		    case GD_sound_ahisetup:

			if(RequestAHI(&currentSoundData))
			{
			    GT_SetGadgetAttrs( soundGadgets[GD_sound_selecteddevice],soundWnd,NULL,
					       GTTX_Text,(int)currentSoundData.ahi_name,
					       TAG_DONE);

			    if(currentSoundData.stereo)
			    {
				GT_SetGadgetAttrs( soundGadgets[GD_sound_rvstereo],soundWnd,NULL,
						   GA_Disabled,FALSE,
						   TAG_DONE);
			    }
			    else
			    {
				GT_SetGadgetAttrs( soundGadgets[GD_sound_rvstereo],soundWnd,NULL,
						   GA_Disabled,TRUE,
						   TAG_DONE);
			    }
			}
		    break;

		    case GD_sound_sfxvolume:
			currentSoundData.sfxvolume=imsg.Code;
		    break;

		    case GD_sound_rvstereo:
			currentSoundData.rvstereo=imsg.Code;
		    break;

		    case GD_sound_voices:
			currentSoundData.numvoices=imsg.Code+1;
		    break;

		    case GD_sound_ok:
			CopyMem(&currentSoundData,theSoundData,sizeof(SoundData));
			done=TRUE;
		    break;

		    case GD_sound_cancel:
			done=TRUE;
		    break;
		}
	    break;
	}
    }
    ClosesoundWindow();
}

/*****************************************************************************
    MakeDefaultSoundData
 *****************************************************************************/
void MakeDefaultSoundData(SoundData *sd)
{
    char defaultname[]="(none)";

    sd->ahi_id=AHI_INVALID_ID;
    sd->ahi_bits=8;
    sd->freq=22050;
    sd->bits=16;
    sd->numvoices=8;
    sd->sfxvolume=240;
    sd->musicvolume=128;
    sd->music=FALSE;
    sd->stereo=FALSE;
    sd->rvstereo=FALSE;
    CopyMem(defaultname,sd->ahi_name,6);
    sd->ahi_name[7]=0;
}

/*****************************************************************************
    SetSoundGadgets
 *****************************************************************************/
void SetSoundGadgets(SoundData *sd)
{
    /* set ahi-name */
    GT_SetGadgetAttrs( soundGadgets[GD_sound_selecteddevice],soundWnd,NULL,
		       GTTX_Text,(int)sd->ahi_name,
		       TAG_DONE);

    /* set voices */
    GT_SetGadgetAttrs( soundGadgets[GD_sound_voices],soundWnd,NULL,
		       GTCY_Active,sd->numvoices-1,
		       TAG_DONE);

    /* set rvsstereo */
    GT_SetGadgetAttrs( soundGadgets[GD_sound_rvstereo],soundWnd,NULL,
		       GTCB_Checked,sd->rvstereo,
		       TAG_DONE);

    if(sd->stereo)
    {
	GT_SetGadgetAttrs( soundGadgets[GD_sound_rvstereo],soundWnd,NULL,
			   GA_Disabled,FALSE,
			   TAG_DONE);
    }
    else
    {
	GT_SetGadgetAttrs( soundGadgets[GD_sound_rvstereo],soundWnd,NULL,
			   GA_Disabled,TRUE,
			   TAG_DONE);
    }

    /* set sfx-volume */
    GT_SetGadgetAttrs( soundGadgets[GD_sound_sfxvolume],soundWnd,NULL,
		       GTSL_Level,sd->sfxvolume,
		       TAG_DONE);
}

/*****************************************************************************
    OpenAHI
 *****************************************************************************/
BOOL OpenAHI(void)
{
    if((AHImp = CreateMsgPort()))
    {
	if((AHIio = (struct AHIRequest *)CreateIORequest(AHImp,sizeof(struct AHIRequest))))
	{
	    if(!(AHIDevice = OpenDevice(AHINAME, AHI_NO_UNIT,(struct IORequest *) AHIio,NULL)))
	    {
		AHIBase = (struct Library *) AHIio->ahir_Std.io_Device;
		return TRUE;
	    }
	}
    }
    return FALSE;
}

/*****************************************************************************
    CloseAHI
 *****************************************************************************/
void CloseAHI(void)
{
    if(!AHIDevice)
	CloseDevice((struct IORequest *)AHIio);
    AHIDevice=-1;

    if(AHIio)
	DeleteIORequest((struct IORequest *)AHIio);
    AHIio=NULL;

    if(AHImp)
	DeleteMsgPort(AHImp);
    AHImp=NULL;
}

/*****************************************************************************
    RequestAHI
 *****************************************************************************/
BOOL RequestAHI(SoundData *sd)
{
    struct AHIAudioModeRequester *req;
    struct TagItem filtertags[6];
    BOOL   rc = FALSE;
    LONG stereo=0;

    filtertags[0].ti_Tag=AHIDB_Panning;     filtertags[0].ti_Data=1;
    filtertags[1].ti_Tag=AHIDB_Volume;      filtertags[1].ti_Data=1;
    filtertags[2].ti_Tag=AHIDB_Realtime;    filtertags[2].ti_Data=1;
    filtertags[3].ti_Tag=AHIDB_Bits;        filtertags[3].ti_Data=8;
    filtertags[4].ti_Tag=AHIDB_Stereo;      filtertags[4].ti_Data=1;
    filtertags[5].ti_Tag=TAG_DONE;

    req = AHI_AllocAudioRequest(AHIR_PubScreenName, NULL,
				AHIR_TitleText,     (int)"Select a mode and rate",
				AHIR_DoMixFreq,     TRUE,
				AHIR_Window, (int)soundWnd,
				AHIR_SleepWindow, 1,
				AHIR_InitialAudioID,sd->ahi_id,
				AHIR_InitialMixFreq,sd->freq,
				AHIR_FilterTags,(int)filtertags,
				TAG_DONE);

    if(req)
    {
	if(AHI_AudioRequest(req, TAG_DONE))
	{
	    sd->ahi_id=req->ahiam_AudioID;
	    sd->freq=req->ahiam_MixFreq;

	    if(sd->freq<=16000)
		sd->freq=11025;
	    else if(sd->freq<=28000)
		sd->freq=22050;
	    else if(sd->freq<=46000)
		sd->freq=44100;
	    else
		sd->freq=48000;

	    AHI_GetAudioAttrs( req->ahiam_AudioID, NULL,
			       AHIDB_BufferLen,128,
			       AHIDB_Name, (int)(sd->ahi_name),
			       AHIDB_Stereo, (int)(&stereo),
			       AHIDB_Bits, (int)(&sd->ahi_bits),
			       TAG_DONE);

	    sd->stereo=stereo;

	    /*if(sd->ahi_bits<=8)
		sd->bits=8;
	    else
		sd->bits=16;*/

	    /* at the moment sound in duke3d only works fine with 16bit */
	    sd->bits=16;

	    rc=TRUE;
	}
	AHI_FreeAudioRequest(req);
    }
    return rc;
}

