
#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfx.h>

#include "animtools.h"

#include <graphics/gels.h>
#include <graphics/clip.h>
#include <graphics/rastport.h>
#include <graphics/view.h>
#include <graphics/gfxbase.h>

#include <proto/exec.h>
#include <proto/graphics.h>

struct GelsInfo *
setupGelSys(struct RastPort *rp, UBYTE reserved)
{
	struct GelsInfo		*ginfo;
	struct VSprite		*vsHead;
	struct VSprite		*vsTail;

	if ((ginfo = (struct GelsInfo *)AllocMem((LONG)sizeof(struct GelsInfo),
		MEMF_CLEAR)) != NULL)
	{
	  if ((ginfo->nextLine = (WORD *)AllocMem((LONG)sizeof(WORD) * 8,
	    MEMF_CLEAR)) != NULL)
	  {
	    if ((ginfo->lastColor = (WORD **)AllocMem((LONG)sizeof(LONG) *
		8, MEMF_CLEAR)) != NULL)
	    {
	      if ((ginfo->collHandler = (struct collTable *)AllocMem(
		    (LONG)sizeof(struct collTable), MEMF_CLEAR)) != NULL)
	      {
		if ((vsHead = (struct VSprite *)AllocMem((LONG)
			sizeof(struct VSprite), MEMF_CLEAR)) != NULL)
		{
		  if ((vsTail = (struct VSprite *)AllocMem((LONG)
			    sizeof(struct VSprite), MEMF_CLEAR)) != NULL)
		  {
		    ginfo->sprRsrvd	= reserved;
		    ginfo->leftmost	= 3;
		    ginfo->rightmost	= (rp->BitMap->BytesPerRow << 3) - 5;
		    ginfo->topmost	= 16;
		    ginfo->bottommost	= rp->BitMap->Rows - 22;

		    rp->GelsInfo = ginfo;

		    InitGels(vsHead, vsTail, ginfo);

		    return (ginfo);
		  }
		  FreeMem(vsHead, (LONG)sizeof(*vsHead));
		}
		FreeMem(ginfo->collHandler, (LONG)sizeof(struct collTable));
	      }
	      FreeMem(ginfo->lastColor, (LONG)sizeof(LONG) * 8);
	    }
	    FreeMem(ginfo->nextLine, (LONG)sizeof(WORD) * 8);
	  }
	  FreeMem(ginfo, (LONG)sizeof(*ginfo));
	}

	return (NULL);
}

void
cleanupGelSys(struct GelsInfo *ginfo, struct RastPort *rp)
{
	rp->GelsInfo = NULL;

	FreeMem(ginfo->collHandler, (LONG)sizeof(struct collTable));
	FreeMem(ginfo->lastColor, (LONG)sizeof(LONG) * 8);
	FreeMem(ginfo->nextLine, (LONG)sizeof(WORD) * 8);
	FreeMem(ginfo->gelHead, (LONG)sizeof(struct VSprite));
	FreeMem(ginfo->gelTail, (LONG)sizeof(struct VSprite));
	FreeMem(ginfo, (LONG)sizeof(*ginfo));
}

/*
 * mode NO_MASKS: Do not allocate ImageShadow nor CollMask
 */
struct VSprite *
makeVSprite(struct NewVSprite *nVSprite, UBYTE mode)
{
	struct VSprite	*vs;
	LONG		line_size;
	LONG		plane_size;

	line_size = (LONG)sizeof(WORD) * nVSprite->nvs_WordWidth;
	plane_size = line_size * nVSprite->nvs_LineHeight;

	if ((vs = (struct VSprite *)AllocMem((LONG)sizeof(struct VSprite),
		MEMF_CLEAR)) != NULL) {
	    if ((vs->BorderLine = (WORD *)AllocMem(line_size,
		    MEMF_CHIP)) != NULL) {
		if ((mode & NO_MASKS) ||
			(vs->CollMask = (WORD *)AllocMem(plane_size,
			MEMF_CHIP)) != NULL) {
		    vs->X		= nVSprite->nvs_X;
		    vs->Y		= nVSprite->nvs_Y;
		    vs->Flags		= nVSprite->nvs_Flags;
		    vs->Width		= nVSprite->nvs_WordWidth;
		    vs->Depth		= nVSprite->nvs_ImageDepth;
		    vs->Height		= nVSprite->nvs_LineHeight;
		    vs->MeMask		= 1;
		    vs->HitMask		= 1;
		    vs->ImageData	= nVSprite->nvs_Image;
		    vs->SprColors	= nVSprite->nvs_ColorSet;
		    vs->PlanePick	= 0x00;
		    vs->PlaneOnOff	= 0x00;

		    /* Bug: BorderLine is useless. */
		    if (!(mode & NO_MASKS)) InitMasks(vs);

		    return (vs);
		}
		FreeMem(vs->BorderLine, line_size);
	    }
	    FreeMem(vs, (LONG)sizeof(*vs));
	}

	return (NULL);
}

/*
 * mode NO_MASKS: Do not free ImageShadow nor CollMask
 */
void
freeVSprite(struct VSprite *vs, UBYTE mode)
{
	LONG		line_size;
	LONG		plane_size;

	line_size = (LONG)sizeof(WORD) * vs->Width;
	plane_size = line_size * vs->Height;

	FreeMem(vs->BorderLine, line_size);
	if (!(mode & NO_MASKS)) FreeMem(vs->CollMask, plane_size);
	FreeMem(vs, (LONG)sizeof(*vs));
}

/*
 * mode NO_MASKS: Do not allocate ImageShadow nor CollMask
 */
struct Bob *
makeBob(struct NewBob *nbob, UBYTE mode)
{
	struct Bob	*bob;
	struct VSprite	*vsprite;
	NEWVSPRITE	nvsprite;
	LONG		rassize;

	rassize = (LONG)sizeof(UWORD) *
		(nbob->nb_WordWidth * nbob->nb_LineHeight * nbob->nb_RasDepth);

	if ((bob = (struct Bob *)AllocMem((LONG)sizeof(struct Bob),
		MEMF_CLEAR)) != NULL) {
	    if ((bob->SaveBuffer = (WORD *)AllocMem(rassize,
		    MEMF_CHIP)) != NULL) {
		nvsprite.nvs_WordWidth	= nbob->nb_WordWidth;
		nvsprite.nvs_LineHeight = nbob->nb_LineHeight;
		nvsprite.nvs_ImageDepth = nbob->nb_ImageDepth;
		nvsprite.nvs_Image	= nbob->nb_Image;
		nvsprite.nvs_X		= nbob->nb_X;
		nvsprite.nvs_Y		= nbob->nb_Y;
		nvsprite.nvs_ColorSet	= NULL;
		nvsprite.nvs_Flags	= nbob->nb_BFlags;

		if ((vsprite = makeVSprite(&nvsprite, mode)) != NULL) {
		    vsprite->PlanePick = nbob->nb_PlanePick;
		    vsprite->PlaneOnOff = nbob->nb_PlaneOnOff;

		    vsprite->VSBob	= bob;
		    bob->BobVSprite	= vsprite;
		    if ((mode & NO_MASKS))
			bob->ImageShadow = NULL;
		    else
			bob->ImageShadow = vsprite->CollMask;

		    bob->Flags		= 0;
		    bob->Before		= NULL;
		    bob->After		= NULL;
		    bob->BobComp	= NULL;

		    if (nbob->nb_DBuf) {
			if ((bob->DBuffer = (struct DBufPacket *)
				AllocMem((LONG)sizeof(struct DBufPacket),
					MEMF_CLEAR)) != NULL) {
			    if ((bob->DBuffer->BufBuffer = (WORD *)AllocMem(
				    rassize, MEMF_CHIP)) != NULL) {

				return (bob);

			    }
			FreeMem(bob->DBuffer, (LONG)sizeof(struct DBufPacket));
			}
		    } else {
				bob->DBuffer = NULL;
				return (bob);
		    }
		    freeVSprite(vsprite, mode);
		}
		FreeMem(bob->SaveBuffer, rassize);
	    }
	    FreeMem(bob, (LONG)sizeof(*bob));
	}
	return (NULL);
}

/*
 * mode NO_MASKS: Do not free ImageShadow nor CollMask
 */
void
freeBob(struct Bob *bob, LONG rasdepth, UBYTE mode)
{
	int rassize;

	rassize = (LONG)sizeof(UWORD) * bob->BobVSprite->Width *
	    bob->BobVSprite->Height * rasdepth;

	if (bob->DBuffer != NULL) {
		FreeMem(bob->DBuffer->BufBuffer, rassize);
		FreeMem(bob->DBuffer, (LONG)sizeof(struct DBufPacket));
	}
	FreeMem(bob->SaveBuffer, rassize);
	freeVSprite(bob->BobVSprite, mode);
	FreeMem(bob, (LONG)sizeof(*bob));
}
