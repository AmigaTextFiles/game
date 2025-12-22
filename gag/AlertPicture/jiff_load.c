/**********************************************************************
*
*			jiff.c   Jim Kent's iff - ilbm  reader
*
* This is the (sortof) short (sortof) simple no-frills IFF reader
* to get something out of DPaint, Images, or the Animator.  It
* works well with the Aztec C compiler.  It should work with Lattice
* but you never know until you try it.  I haven't.
*
* I've included a simple main program.  This is just to make it
* stand alone.  Since amiga screen initializations are massive, all
* it does as is is read it into a BitMap, and then free up the BitMap.
* Should crash it if it's gonna crash though.
*
* The main interface to this is through the routine read_iff(filename).
* This returns a ILBM_info structure-pointer on success, and NULL on
* failure.  It cleans up after itself on failure.
*
* I hope you will find this useful and easy to use.  Please forgive
* my funky indentation style?  Well at least I'm consistent!
*
* To demonstrate what a nice guy I am even though I'm far from wild
* about the IFF standard I'm placing this in the public domain.  When
* you remove the DEBUG and PARANOID definitions the code is only
* 1536 bytes long.
*
*		-Jim Kent  April 22, 1986
*
* Restructured for error messages where paranoid.
*
*     -Tim Ferguson, Alchemy Software Development.  June 14, 1993
************************************************************************/

#include <stdio.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfx.h>
#include <libraries/dos.h>
#include "jiff.h"

char iff_err_msg_read[80], iff_warn_msg_read[80];

static struct ILBM_info *read_body(FILE *, register struct ILBM_info *, long);
static struct ILBM_info *read_ilbm(FILE *, struct ILBM_info *, long, short);


/* --------------------------------------------------------------------- */
struct ILBM_info *read_iff(char *name, struct ILBM_info *info, short just_colors)
{
FILE *file;
struct form_chunk chunk;

	if((file = fopen(name, "r") ) == 0)
		{
		sprintf(iff_err_msg_read, "Couldn't Open %s to read.\n", name);
		return(NULL);
		}

	if(fread(&chunk, sizeof(struct form_chunk), 1, file) != 1)
		{
		sprintf(iff_err_msg_read, "ILBM truncated at 1\n");
		fclose(file);
		return(NULL);
		}

	if(chunk.fc_type.b4_type != FORM)
		{
		sprintf(iff_err_msg_read, "Not a FORM - %s\n", name);
		fclose(file);
		return(NULL);
		}

	if(chunk.fc_subtype.b4_type != ILBM)
		{
		sprintf(iff_err_msg_read, "FORM not an ILBM - %s\n", name);
		fclose(file);
		return(NULL);
		}

	info = read_ilbm(file, info, chunk.fc_length - sizeof(chunk), just_colors);
	fclose(file);
	return(info);
}


/* --------------------------------------------------------------------- */
static struct ILBM_info *read_ilbm(FILE *file, struct ILBM_info *info, long length, short just_colors)
{
struct iff_chunk chunk;
int i;
long read_in = 0;
int got_header = FALSE;  /*to make sure gots the header first*/
int got_cmap = FALSE;  /*make sure get cmap before "BODY" */

/* make sure the Planes are all NULL so can free up memory easily
  on error abort */
	for(i = 0; i < 8; i++) info->bitmap.Planes[i] = NULL;

	while(read_in < length)
		{
		if(fread(&chunk, sizeof(chunk), 1, file) != 1)
			{
			sprintf(iff_err_msg_read, "ILBM truncated at 1\n");
			return(NULL);
			}

		switch (chunk.iff_type.b4_type)
			{
			case BMHD:
				if(fread(&info->header, sizeof(info->header), 1, file) != 1)
					{
					sprintf(iff_err_msg_read, "ILBM truncated at 2\n");
					return(NULL);
					}

				got_header = TRUE;
				break;

			case CMAP:
				if(!got_header)
					{
					sprintf(iff_err_msg_read, "CMAP before BMHD\n");
					return(NULL);
					}

				if(chunk.iff_length <= 3*MAXCOL )
					{
					if(fread(info->cmap, (int)chunk.iff_length, 1, file) != 1)
						{
						sprintf(iff_err_msg_read, "ILBM truncated at 3\n");
						return(NULL);
						}
					}
				else
					{
					sprintf(iff_err_msg_read, "warning, more than %d colors in ILBM CMAP\n", MAXCOL);
					if(fread(info->cmap, 3*MAXCOL, 1, file) != 1)
						{
						sprintf(iff_err_msg_read, "ILBM truncated at 4\n");
						return(NULL);
						}
					bit_bucket(file, chunk.iff_length - sizeof(3*MAXCOL));
					}
				got_cmap = TRUE;

				if(just_colors) return(info);
				break;

			case BODY:
				if(!got_cmap)
					{
					sprintf(iff_err_msg_read, "BODY before CMAP\n");
					return(NULL);
					}
				return(read_body(file, info, chunk.iff_length));

			default:	/*squawk about unknown types if PARANOID */
				sprintf(iff_warn_msg_read, "unknown type %lx of b4_type\n", chunk.iff_type.b4_type);

			case GRAB:  /*ignore documented but unwanted types*/
			case DEST:
			case SPRT:
			case CAMG:
			case CRNG:
			case CCRT:
				bit_bucket(file, chunk.iff_length);
				break;
			}

		read_in += chunk.iff_length + sizeof(chunk);
		}

	sprintf(iff_err_msg_read, "No BODY in ILBM\n");
	return(NULL); 
}


/* --------------------------------------------------------------------- */
static struct ILBM_info *read_body(FILE *file, register struct ILBM_info *info, long length)
{
struct ILBM_header *header;
struct BitMap *bm;
int i, j;
int rlength;
int plane_offset;

	if(info->header.nPlanes > 8)
		{
		sprintf(iff_err_msg_read, "IFF %d planes is too large.  Maximum planes is 8\n",
			info->header.nPlanes);
		return(NULL);
		}

/* ok a little more error checking */
	if(info->header.compression != 0 && info->header.compression != 1)
		{
		sprintf(iff_err_msg_read, "unrecognized compression type %d\n", info->header.compression);
		return(NULL);
		}

/*set up the bitmap part that doesn't involve memory allocation first -
  hey this part does get done, and let's be optimistic...*/

	info->bitmap.BytesPerRow = line_bytes(info->header.w);
	info->bitmap.Rows = info->header.h;
	info->bitmap.Depth = info->header.nPlanes;
	info->bitmap.Flags = info->bitmap.pad = 0;

	rlength = info->bitmap.Rows * info->bitmap.BytesPerRow;

	for(i=0; i<info->header.nPlanes; i++)
		{
		if((info->bitmap.Planes[i] = ralloc(rlength)) == NULL)
			{
			sprintf(iff_err_msg_read, "couldn't alloc plane %d in read_body\n",i);
			free_planes( &info->bitmap );
			return(NULL);
			}
		}

	plane_offset = 0;
	for(i=0; i<info->bitmap.Rows; i++)
		{
	/* this test should be in the inner loop for shortest code,
	   in the outer loop for greatest speed, so sue me I compromised */
		if(info->header.compression == 0)
			{
			for(j = 0; j < info->bitmap.Depth; j++)
				{
				if(fread(info->bitmap.Planes[j] + plane_offset,
					info->bitmap.BytesPerRow, 1, file) != 1)
					{
					sprintf(iff_err_msg_read, "ILBM truncated at 6\n");
					free_planes(&info->bitmap);
					return(NULL);
					}
				}
			}
		else
			{
			register char *dest, value;
			register int so_far, count;  /*how much have unpacked so far*/

			for(j = 0; j < info->bitmap.Depth; j++)
				{
				so_far = info->bitmap.BytesPerRow;
				dest = (char *)info->bitmap.Planes[j] + plane_offset;
				while(so_far > 0)
					{
					if((value = getc(file)) == 128);
					else if(value > 0)
						{
						count = (int)value + 1;
						so_far -= count;
						if(fread(dest, count, 1, file) != 1)
							{
							sprintf(iff_err_msg_read, "ILBM truncated at 7\n");
							free_planes(&info->bitmap);
							return(NULL);
							}
						dest += count;
						}
					else 
						{
						count = (int)-value + 1;
						so_far -= count;
						value = getc(file);
						while(--count >= 0)  /*this is fastest loop in C */
							*dest++ = value;
						}
					}
				if(so_far != 0)
					{
					sprintf(iff_err_msg_read, "compression quite screwed up, aborting %d\n", so_far);
					free_planes(&info->bitmap);
					return(NULL);
					}
				}
			}
		plane_offset += info->bitmap.BytesPerRow;
		}
	return(info);
}


/* --------------------------------------------------------------------- */
void free_planes(register struct BitMap *bmap)
{
PLANEPTR plane;
long length;
short i;

	length = bmap->BytesPerRow * bmap->Rows;

	for(i = 0; i < 8; i++)
		if((plane = bmap->Planes[i]) != NULL) rfree(plane, length);
}
