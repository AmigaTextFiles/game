//=========================================================================
//=========================================================================
//
//	Daleks - functions to load & unload graphics files
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#include	"Daleks.h"
#include	<graphics/scale.h>

//=========================================================================
// Filenames of GFX files, must be in step with _gfx_picnumbers enum!
//=========================================================================
static STRPTR GfxNames[GFX_LAST] =
		{
			"DalekL",
			"DalekR",
			"Doctor",
			"UL",
			"UP",
			"UR",
			"RT",
			"DR",
			"DN",
			"DL",
			"LF"
		};


//=========================================================================
// struct dtPic *loadDTPicture(STRPTR)
//
// Load the given file and create a dtPic from it
// Returns NULL on error.
//=========================================================================
struct dtPic *loadDTPic(
						STRPTR a_fnam
					   )
{
	static struct dtPic dtp;
    	   struct FrameInfo Frame = { NULL };
		   struct dtPic *retval = NULL;

	if (!Screen)
	{
		return(NULL);
	}

	dtp.dp_bm	 = NULL;
	dtp.dp_bmhdr = NULL;
	dtp.dp_obj	 = NewDTObject(a_fnam,
								DTA_GroupID			 , GID_PICTURE,
								OBP_Precision		 , PRECISION_EXACT,
								PDTA_Screen			 , Screen,
								PDTA_FreeSourceBitMap, TRUE,
								PDTA_DestMode        , MODE_V43,
								PDTA_UseFriendBitMap , TRUE,
								TAG_DONE);

	if (dtp.dp_obj)
	{
		DoMethod(dtp.dp_obj, DTM_FRAMEBOX, NULL, &Frame, &Frame, sizeof(struct FrameInfo), 0);
		if (Frame.fri_Dimensions.Depth > 0)
		{
			if (DoMethod(dtp.dp_obj, DTM_PROCLAYOUT, NULL, 1))
			{
				GetDTAttrs(dtp.dp_obj, PDTA_BitMapHeader, &(dtp.dp_bmhdr), TAG_DONE);
				if (dtp.dp_bmhdr)
				{
					GetDTAttrs(dtp.dp_obj, PDTA_DestBitMap, &(dtp.dp_bm), TAG_DONE);

					if (!dtp.dp_bm)
					{
						GetDTAttrs(dtp.dp_obj, PDTA_BitMap, &(dtp.dp_bm), TAG_DONE);
					}

					if (dtp.dp_bm)
					{
						retval = &dtp;
					}
				}
			}
		}
	}

	return(retval);
}


//=========================================================================
// void unloadDTPic(struct dtPic *)
//
// Free all memory associated with a DTPic
//=========================================================================
void unloadDTPic(
					struct dtPic *a_dtp
				)
{
	a_dtp->dp_bm	= NULL;
	a_dtp->dp_bmhdr	= NULL;

	if (a_dtp->dp_obj)
	{
        DisposeDTObject(a_dtp->dp_obj);
   	    a_dtp->dp_obj = NULL;
	}
}

//=========================================================================
// BOOL loadGFX(ULONG, ULONG)
//
// Load & remap game graphics using datatypes.library.
// Scales remapped pictures to a_xs * a_ys and fills in
// GameGfx Bitmap array with the results.
//
// Returns success/failure.
//
//=========================================================================
BOOL loadGFX(
				ULONG	a_xs,
				ULONG	a_ys
			)
{
	BOOL				retval = TRUE;
	ULONG				i;
	char				tmpnam[40];
	struct dtPic		*this;
	struct BitMap		*bm;
	struct BitScaleArgs bsa;
	
	//=====================================================================
	// No screen, cant do anything!
	//=====================================================================
	if (!Screen)
	{
		return(FALSE);
	}

	//=====================================================================
	// Initialise all GameGfx bitmap pointers to NULL
	//=====================================================================
	for (i = 0; i < GFX_LAST; i++)
	{
		GameGfx[i] = NULL;
	}

	for (i = 0; i < GFX_LAST; i++)
	{
		//=================================================================
		// Try to load the picture
		//=================================================================
		sprintf(tmpnam, "gfx/%s.iff", GfxNames[i]);
		this = loadDTPic(tmpnam);

		//=================================================================
		// Did we get it? Scale to requested size if so.
		//=================================================================
		if (this)
		{
			//=============================================================
			// Allocate a bitmap to hold the scaled graphic
			//=============================================================
			bm  = AllocBitMap(a_xs, a_ys, (ULONG)this->dp_bmhdr->bmh_Depth,
									BMF_INTERLEAVED, Screen->RastPort.BitMap);
			if (!bm)
			{
				unloadDTPic(this);
				exitProg("Unable to allocate bitmap");
			}

			//=============================================================
			// Setup the scaling parameters
			//=============================================================
			bsa.bsa_SrcX       = 0;								// Src offsets
			bsa.bsa_SrcY       = 0;
			bsa.bsa_SrcWidth   = this->dp_bmhdr->bmh_Width;		// Src size
			bsa.bsa_SrcHeight  = this->dp_bmhdr->bmh_Height;
			bsa.bsa_XSrcFactor = this->dp_bmhdr->bmh_Width;		// Ratio denominators (src size)
			bsa.bsa_YSrcFactor = this->dp_bmhdr->bmh_Height;
			bsa.bsa_SrcBitMap  = this->dp_bm;					// Src bitmap
			bsa.bsa_DestX      = 0;								// Dest offsets
			bsa.bsa_DestY      = 0;
			bsa.bsa_XDestFactor= a_xs;							// Ratio numerators (dest size)
			bsa.bsa_YDestFactor= a_ys;
			bsa.bsa_DestBitMap = bm;							// Dest bitmap
			bsa.bsa_Flags      = 0;								// As required!

			//=============================================================
			// Do the scale, set the bitmap pointet & free the source
			//=============================================================
			BitMapScale(&bsa);
			GameGfx[i] = bm;
			unloadDTPic(this);
		}
		else
		{
			retval = FALSE;
		}
	}

	return(retval);
}

//=========================================================================
// void unloadGFX(void)
//
// Free all memory and structures related to game graphics
//=========================================================================
void unloadGFX(
				void
			  )
{
	ULONG	i;

	for (i = 0; i < GFX_LAST; i++)
	{
		if (GameGfx[i])
		{
			FreeBitMap(GameGfx[i]);
			GameGfx[i] = NULL;
		}
	}
}
