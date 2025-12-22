#include "main.h"

gfx **LoadGfxArray(char **filenames) {
	gfx **array;
	char **name;
	int32 i, num;
	for (name = filenames, num = 0; *name; name++) num++;
	array = AllocVec(sizeof(uint32) + sizeof(APTR)*(num+1), MEMF_ANY|MEMF_CLEAR);
	if (array) {
		*(uint32 *)array = num;
		array = (gfx **)((uint32 *)array + 1);

		for (i = 0; i < num; i++) {
			array[i] = LoadGfxDT(filenames[i]);
			if (!array[i]) {
				FreeGfxArray(array);
				return NULL;
			}
		}
	}
	return array;
}

void FreeGfxArray(gfx **array) {
	gfx **tmp;
	if (!array) return;
	for (tmp = array; *tmp; tmp++) FreeGfx(*tmp);
	FreeVec((uint32 *)array - 1);
}

gfx *LoadGfxDT (char *filename) {
	Object *dt;
	struct BitMapHeader *bmh = NULL;
	int32 width, height;
	uint32 fmt;
	gfx *gfx = NULL;

	dt = NewDTObject(filename,
			DTA_GroupID,	GID_PICTURE,
			PDTA_DestMode,	PMODE_V43,
			TAG_END);
	if (!dt) return NULL;

	GetDTAttrs(dt, PDTA_BitMapHeader, &bmh, TAG_END);
	if (bmh) {
		width = bmh->bmh_Width;
		height = bmh->bmh_Height;

		if (bmh->bmh_Depth <= 8)
			fmt = GFX_FMT_CLUT8;
		else
			fmt = GFX_FMT_ARGB32;

		gfx = CreateGfx(fmt, width, height);
	}

	if (gfx) {
		if (fmt == GFX_FMT_CLUT8) {
			int32 n, ncolors = 0;
			struct ColorRegister * cregs = NULL;
			color *clut;

			GetDTAttrs(dt,
				PDTA_NumColors,		&ncolors,
				PDTA_ColorRegisters,	&cregs,
				TAG_END);

			clut = AllocCLUT(gfx, ncolors);
			if (clut) {
				DoMethod(dt, PDTM_READPIXELARRAY,
					gfx->gfx, PBPAFMT_LUT8, gfx->bpr, 0, 0, width, height);
				for (n = 0; n < ncolors; n++) {
					clut->alpha = 255;
					clut->red = cregs->red;
					clut->green = cregs->green;
					clut->blue = cregs->blue;
					clut++; cregs++;
				}
				DisposeDTObject(dt);
				return gfx;
			}
		} else {
			DoMethod(dt, PDTM_READPIXELARRAY,
				gfx->gfx, PBPAFMT_ARGB, gfx->bpr, 0, 0, width, height);
			DisposeDTObject(dt);
			return gfx;
		}
	}

	FreeGfx(gfx);
	DisposeDTObject(dt);
	return NULL;
}
