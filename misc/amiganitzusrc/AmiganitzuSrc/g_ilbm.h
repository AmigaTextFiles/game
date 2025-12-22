/* g_ilbm.h */

#ifndef _G_ILBM_H
#define _G_ILBM_H

#include <graphics/gfx.h>

struct form_id_struct
{
	char chunk_id[4];
	unsigned long chunk_size;
	char type_id[4];
};

struct chunk_struct
{
	char			chunk_id[4];
	unsigned long	size;
};

struct colour_struct
{
	unsigned char red, green, blue;
};

typedef struct 
{
	unsigned pad1 :4, red :4, green :4, blue :4;
} colour_4;

struct ilbm_bmhd_struct
{
	unsigned short	width;
	unsigned short	height;
	unsigned short	left; /* x coord */
	unsigned short	top; /* y coord */
	unsigned char	bitplanes; /* num of bitplanes */
	unsigned char	masking; /* type of masking */
	unsigned char	compression; /* 0 = none, 1 = packer */
	unsigned char	padding;
	unsigned short	transparency; /* trasp. colour */
	unsigned char	x_aspectratio;
	unsigned char	y_aspectratio;
	unsigned short	page_width;
	unsigned short	page_height;
};

int load_ilbm_mask(char*, unsigned char*);
int load_ilbm(char*, struct BitMap*, struct palette_struct*);

#endif
