
#include <exec/types.h>
#include <exec/exec.h>
#include <graphics/gfx.h>
#include <libraries/dos.h>

#include <clib/graphics_protos.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

#include <stdio.h>
#include <stdio.h>

#include "g_ilbm.h"
#include "g_video.h"


struct ilbm_bmhd_struct bmhd;
struct chunk_struct chunk;
struct colour_struct cmap[256]; /* up to 256 colours */
colour_4 cols[32];

extern UBYTE *displaymem;


int read_BMHD(FILE *file)
{
	if(fread(&bmhd, sizeof(struct ilbm_bmhd_struct), 1, file) != 1)
	{
		printf("fread() failed\n");
		fclose(file);
		return 0;
	}
	
	return 1;
}

int read_CMAP(FILE *file, struct palette_struct *pal)
{
	int i;

	if(bmhd.bitplanes == 1)
	{
		fseek(file, chunk.size, SEEK_CUR);
		return 1;
	}

	if(bmhd.bitplanes == 5)
	{
		if(fread(&cmap, sizeof(struct colour_struct[32]), 1, file) != 1)
		{
			printf("fread() failed\n");
			fclose(file);
			return 0;
		}
	}
	for(i = 0; i < 32; i++)
	{
		pal->c[i].red = cmap[i].red/16;
		pal->c[i].green = cmap[i].green/16;
		pal->c[i].blue = cmap[i].blue/16;
	}
	return 1;
}

int read_BODY(FILE *file, struct BitMap *nbm)
{
	int y, i, pos, bytes_per_row;

	bytes_per_row = bmhd.width / 8;
	/* init new bitmap */

	InitBitMap(nbm, bmhd.bitplanes, bmhd.width, bmhd.height);
	for(i = 0; i < bmhd.bitplanes; i++)
	{
		nbm->Planes[i] = (PLANEPTR)AllocRaster(bmhd.width, bmhd.height);
		if(nbm->Planes[i] == NULL)
		{
			return 0;
		}
	}

	for(y = 0; y < bmhd.height; y++)
	{
		for(i = 0; i < bmhd.bitplanes; i++)
		{
			displaymem = (UBYTE*)nbm->Planes[i];
			pos = y * bytes_per_row;
			if(fread(&displaymem[pos], bytes_per_row, 1, file) != 1) return 0;
		}
	}
	
	return 1;
}

int read_BODY_mask(FILE *file, unsigned char *maskbuf)
{
	int buf_size;
	
	buf_size = (bmhd.width * bmhd.height) / 8;
	
	if(fread(maskbuf, buf_size, 1, file) != 1) return 0;

	return 1;
}

int load_ilbm_mask(char *fname, unsigned char *maskbuf)
{
	FILE *file = NULL;
	unsigned char done = 0, err = 0, chunk_used = 0;
	struct form_id_struct form_id;
	struct palette_struct pal;

	file = fopen(fname, "r");
	if(!file)
	{
		printf("This file does not exist - %s\n", fname);
		return 0;
	}

	if(fread(&form_id, sizeof(struct form_id_struct), 1, file) != 1)
	{
		printf("fread() failed\n");
		fclose(file);
		return 0;
	}
	
	if(!(form_id.type_id[0] == 'I' && form_id.type_id[1] == 'L' && form_id.type_id[2] == 'B' && form_id.type_id[3] == 'M'))
	{
		printf("Not an ILBM file\n");
		fclose(file);
		return 0;
	}
	
	
	/* read through all the chunks in this file */
	while(done == 0 && err == 0)
	{
		if(fread(&chunk, sizeof(struct chunk_struct), 1, file) != 1)
		{
			fclose(file);
			done = 1;
			break;
		}
		
		if(chunk.chunk_id[0] == 'B' && chunk.chunk_id[1] == 'M' && chunk.chunk_id[2] == 'H' && chunk.chunk_id[3] == 'D')
		{
			if(!read_BMHD(file)) err = 1;
			else chunk_used = 1;
		}
		if(chunk.chunk_id[0] == 'C' && chunk.chunk_id[1] == 'M' && chunk.chunk_id[2] == 'A' && chunk.chunk_id[3] == 'P')
		{
			if(!read_CMAP(file, &pal)) err = 1;
			else chunk_used = 1;
		}
		if(chunk.chunk_id[0] == 'C' && chunk.chunk_id[1] == 'A' && chunk.chunk_id[2] == 'M' && chunk.chunk_id[3] == 'G')
		{
			fseek(file, chunk.size, SEEK_CUR);
			chunk_used = 1;
		}
		if(chunk.chunk_id[0] == 'B' && chunk.chunk_id[1] == 'O' && chunk.chunk_id[2] == 'D' && chunk.chunk_id[3] == 'Y')
		{
			if(!read_BODY_mask(file, maskbuf)) err = 1;
			chunk_used = 1;
		}
		
		if(chunk_used == 0)
		{
			done = 1; /* we didn't read it so quit */
			printf("Unrecognised chunk\n");
		}
		chunk_used = 0;
	}
	
	fclose(file);

	if(err) return 0;
	else return 1;
}

int load_ilbm(char *fname, struct BitMap *nbm, struct palette_struct *pal)
{
	FILE *file = NULL;
	unsigned char done = 0, chunk_used = 0;
	struct form_id_struct form_id;

	file = fopen(fname, "r");
	if(!file)
	{
		printf("This file does not exist- %s\n", fname);
		return 0;
	}
	
	if(fread(&form_id, sizeof(struct form_id_struct), 1, file) != 1)
	{
		printf("fread() failed\n");
		fclose(file);
		return 0;
	}
	
	if(!(form_id.type_id[0] == 'I' && form_id.type_id[1] == 'L' && form_id.type_id[2] == 'B' && form_id.type_id[3] == 'M'))
	{
		printf("Not an ILBM file\n");
		fclose(file);
		return 0;
	}
	
	/* read through all the chunks in this file */
	while(done == 0)
	{
		if(fread(&chunk, sizeof(struct chunk_struct), 1, file) != 1)
		{
			fclose(file);
			done = 1;
			break;
		}
		
		if(chunk.chunk_id[0] == 'B' && chunk.chunk_id[1] == 'M' && chunk.chunk_id[2] == 'H' && chunk.chunk_id[3] == 'D')
		{
			if(!read_BMHD(file)) done = 1;
			else chunk_used = 1;
		}
		if(chunk.chunk_id[0] == 'C' && chunk.chunk_id[1] == 'M' && chunk.chunk_id[2] == 'A' && chunk.chunk_id[3] == 'P')
		{
			if(!read_CMAP(file, pal)) done = 1;
			else chunk_used = 1;
		}
		if(chunk.chunk_id[0] == 'C' && chunk.chunk_id[1] == 'A' && chunk.chunk_id[2] == 'M' && chunk.chunk_id[3] == 'G')
		{
			fseek(file, chunk.size, SEEK_CUR);
			chunk_used = 1;
		}
		if(chunk.chunk_id[0] == 'B' && chunk.chunk_id[1] == 'O' && chunk.chunk_id[2] == 'D' && chunk.chunk_id[3] == 'Y')
		{
			read_BODY(file, nbm);
			chunk_used = 1;
		}
		
		if(chunk_used == 0)
		{
			done = 1; /* we didn't read it so quit */
			printf("Unrecognised chunk\n");
		}
		chunk_used = 0;
	}
	
	fclose(file);
	return 1;
}
