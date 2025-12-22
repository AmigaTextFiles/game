#include "graphics_support.h"
#include <proto/dos.h>
#include <proto/graphics.h>
#include <libraries/iffparse.h>
#include <datatypes/pictureclass.h>
#include <proto/iffparse.h>

#include <malloc.h>
#include <stdio.h>


/*
** INPUTS:
**          pens        = pointer to an array of pen numbers
**          num_pens    = the size of the array (how many pens it can hold)
**                        NB: max = 256
**
** RESULT:
**          The free pen index, or -1 on failure
*/
WORD findfreepen (struct pen *pens, UWORD num_pens)
{
    UWORD i;

    for (i=0; i<num_pens; i++)
    {
        if (pens[i].number==-1)
            return i;
    }
    return -1;  // if we get this far, there were no free pens
}


/*
** INPUTS:
**          R, G, B     = red, green and blue values (32 bit left justified fraction)
**          pens        = pointer to an array of pen numbers
**          num_pens    = the size of the array (how many pens it can hold)
**                        NB: max = 256
**
** RESULT:
**          The pen number of a pen already allocated for R, G and B, or -1 if no pen
**          was previously allocated
*/
STATIC WORD alreadyallocated (ULONG R, ULONG G, ULONG B, struct pen *pens, UWORD num_pens)
{
    UWORD i;

    for (i=0; i<num_pens; i++)
    {
        if (pens[i].number==-1)
            return -1;
        else
        {
            if (pens[i].red==R && pens[i].green==G && pens[i].blue==B)
                return i;
        }
    }
    return -1;
}


/*
** INPUTS:
**          bitmap      = pointer to a bitmap (the bitmap contents will be altered)
**          cm          = pointer to ColorMap of the viewport
**          palette     = pointer to an array of RGB values the bitmap would like to use
**          pens        = pointer to an array of storage for (hopefully) allocated pens
**                        NB: all elements of pens array must be set to 0, prior to calling this function!
**          num_pens    = the size of the array (how many pens it can hold)
**
** RESULT:
**          None
**
** NOTES:
**          This call must be matched with a call to freeallocatedpens()
**
**          This function remaps the bitmap in-place, i.e. in the same memory space as the
**          original bitmap.
*/
void remapbitmap (struct BitMap *bitmap, struct ColorMap *cm, ULONG *palette, struct pen *pens, UWORD num_pens)
{
    ULONG R, G, B;
    UBYTE cmap_index[8];    // each pixel ends up with its cmap index val in cmap_index[pixel]
    WORD i;
    UWORD row, byteinrow;
    ULONG offset=0;

    for (row=0; row<bitmap->Rows; row++)
    {
        for (byteinrow=0; byteinrow<bitmap->BytesPerRow; byteinrow++)
        {
            #ifdef GRAPHICS_SUPPORT_DEBUG
            printf("offset:%d\n", offset);
            #endif

            // Read in 8 pixels down through the relevant bitplanes
            {
                int plane_shift;
                int buffer[8];

                // Erase contents of cmap_index and buffer
                for (i=0; i<8; i++)
                {
                    cmap_index[i]=0;
                    buffer[i]=0;
                }

                #ifdef GRAPHICS_SUPPORT_DEBUG
                printf("Reading plane data\n");
                #endif
                // Plane[0] is least significant plane!
                plane_shift=bitmap->Depth-1;
                for (i=bitmap->Depth-1; i>=0; i--)
                {
                    buffer[i]=*(bitmap->Planes[i]+offset);
                    cmap_index[0]=((UBYTE)(((buffer[i] & 128) >> 7) << plane_shift)) | cmap_index[0];
                    cmap_index[1]=((UBYTE)(((buffer[i] & 64)  >> 6) << plane_shift)) | cmap_index[1];
                    cmap_index[2]=((UBYTE)(((buffer[i] & 32)  >> 5) << plane_shift)) | cmap_index[2];
                    cmap_index[3]=((UBYTE)(((buffer[i] & 16)  >> 4) << plane_shift)) | cmap_index[3];
                    cmap_index[4]=((UBYTE)(((buffer[i] & 8)   >> 3) << plane_shift)) | cmap_index[4];
                    cmap_index[5]=((UBYTE)(((buffer[i] & 4)   >> 2) << plane_shift)) | cmap_index[5];
                    cmap_index[6]=((UBYTE)(((buffer[i] & 2)   >> 1) << plane_shift)) | cmap_index[6];
                    cmap_index[7]=((UBYTE)(((buffer[i] & 1)       ) << plane_shift)) | cmap_index[7];
                    plane_shift--;
                    #ifdef GRAPHICS_SUPPORT_DEBUG
                    printf("buffer[%d]:%4.d   cmap0:%d   cmap1:%d   cmap2:%d   cmap3:%d   cmap4:%d   cmap5:%d   cmap6:%d   cmap7:%d\n",
                            i, buffer[i], cmap_index[0], cmap_index[1], cmap_index[2], cmap_index[3], cmap_index[4], cmap_index[5], cmap_index[6], cmap_index[7]);
                    #endif
                }
            }

            #ifdef GRAPHICS_SUPPORT_DEBUG
            printf("\n");
            #endif

            // Allocate any pens we need, and give each pixel its new pen value
            for (i=0; i<8; i++) // Test each pixel
            {
                if (cmap_index[i]!=0)   // Ignore colour 0, which should be a transparent background
                {
                    WORD gotpen;
                    int index=3*cmap_index[i];

                    R=palette[index];
                    G=palette[index+1];
                    B=palette[index+2];
                    #ifdef GRAPHICS_SUPPORT_DEBUG
                    printf("R=%x  G=%x  B=%x\n", R, G, B);
                    #endif

                    if ((gotpen=alreadyallocated(R, G, B, pens, num_pens))!=-1)
                    {
                        cmap_index[i]=(UBYTE)(pens[gotpen].number);
                        #ifdef GRAPHICS_SUPPORT_DEBUG
                        printf("gotpen:%4.d  pennum=%4.d  cmap[%d]:%d\n", gotpen, pens[gotpen].number, i, cmap_index[i]);
                        #endif
                    }
                    else
                    {
                        WORD freepen;
                        if ((freepen=findfreepen(pens, num_pens))!=-1)
                        {
                            if ((pens[freepen].number=ObtainBestPen(cm, R, G, B, OBP_Precision, PRECISION_IMAGE, TAG_DONE))!=-1)
                            {
                                pens[freepen].red=R;
                                pens[freepen].green=G;
                                pens[freepen].blue=B;
                                cmap_index[i]=(UBYTE)(pens[freepen].number);
                                #ifdef GRAPHICS_SUPPORT_DEBUG
                                printf("gotpen:%4.d  pennum=%4.d  cmap[%d]:%d\n", gotpen, pens[gotpen].number, i, cmap_index[i]);
                                #endif
                            }
                        }
                    }
                }
            }

            #ifdef GRAPHICS_SUPPORT_DEBUG
            print_pens(pens, num_pens);
            printf("\n");
            #endif

            // Write 8 pixels back into bitmap with new cmap index values for current
            // viewport's struct ColorMap
            #ifdef GRAPHICS_SUPPORT_DEBUG
            printf("Writing plane data\n");
            #endif
            {
                UBYTE buffer;
                int bitmask=1;
                int shift=0;

                for (i=bitmap->Depth-1; i>0; i--)
                    bitmask=bitmask*2;

                // Plane[0] is least significant plane!
                for (i=bitmap->Depth-1; i>=0; i--)
                {
                    buffer=   ((cmap_index[0] & bitmask)<<shift)
                            | ((cmap_index[1] & bitmask)<<shift)>>1
                            | ((cmap_index[2] & bitmask)<<shift)>>2
                            | ((cmap_index[3] & bitmask)<<shift)>>3
                            | ((cmap_index[4] & bitmask)<<shift)>>4
                            | ((cmap_index[5] & bitmask)<<shift)>>5
                            | ((cmap_index[6] & bitmask)<<shift)>>6
                            | ((cmap_index[7] & bitmask)<<shift)>>7;

                    #ifdef GRAPHICS_SUPPORT_DEBUG
                    printf("bitmask:%4.d   i:%d buffer:%d\n", bitmask, i, buffer);
                    #endif
                    *(bitmap->Planes[i]+offset)=buffer;
                    bitmask=bitmask>>1;
                    shift++;
                }
            }
            #ifdef GRAPHICS_SUPPORT_DEBUG
            printf("\n\n");
            #endif
            offset++;
        }
    }
}


/*
** INPUTS:
**          cm          = pointer to ColorMap of the viewport
**          pens        = pointer to an array of pen numbers
**          num_pens    = the size of the array (how many pens it can hold)
**                        NB: max = 256
**
** RESULT:
**          None
*/
void freeallocatedpens (struct ColorMap *cm, struct pen *pens, UWORD num_pens)
{
    UWORD i;

    for (i=0; i<num_pens; i++)
    {
        if (pens[i].number!=-1)
            ReleasePen(cm, pens[i].number);
        else
            break;
    }
}

#ifdef GRAPHICS_SUPPORT_DEBUG
void print_pens (struct pen *pens, UWORD num_pens)
{
    UWORD i;

    printf("Pens: ");
    for (i=0; i<num_pens; i++)
    {
        if (pens[i].number!=-1)
            printf("%3.d = R:%x G:%x B%x\n", pens[i].number, pens[i].red, pens[i].green, pens[i].blue);
        else
            break;
    }
    printf("\n");
}
#endif


struct BitMap *bodytobitmap (ULONG width, ULONG height, ULONG depth, CONST UBYTE *body)
{
    struct BitMap *bitmap;

    // Allocate 8 bitplanes so that the remapping routine has room to write
    // back pen numbers from ObtainBestPen() with values up to 255
    bitmap=AllocBitMap(width, height, 8, BMF_CLEAR | BMF_MINPLANES, NULL);

    {
        UBYTE plane, scanline;
        int row_width=((width+15)/16)*2;   // row width in bytes
        CONST UBYTE *body_rover;
        int plane_offset=0;

        body_rover=body;

        for (scanline=0; scanline<height; scanline++)
        {
            for (plane=0; plane<depth; plane++)
            {
                memcpy(bitmap->Planes[plane]+plane_offset, body_rover, row_width);
                body_rover+=row_width;
            }
            plane_offset=row_width*(scanline+1);
        }
    }

    return bitmap;
}

BOOL loadiff (CONST_STRPTR filename, ULONG *width, ULONG *height, ULONG *depth, ULONG *compression, UBYTE **body, ULONG **palette)
{
    struct IFFHandle *iff;
    BOOL result=FALSE;

    if (iff=AllocIFF())
    {
        if (iff->iff_Stream=Open(filename, MODE_OLDFILE))
        {
            InitIFFasDOS(iff);

            if (!OpenIFF(iff, IFFF_READ))
            {
                if (!PropChunk(iff, ID_ILBM, ID_BMHD))
                {
                    if (!PropChunk(iff, ID_ILBM, ID_CMAP))
                    {
                        if (!StopChunk(iff, ID_ILBM, ID_BODY))
                        {
                            ParseIFF(iff, IFFPARSE_SCAN);

                            {
                                struct StoredProperty *bmhd;

                                if (bmhd=FindProp(iff, ID_ILBM, ID_BMHD))
                                {
                                    struct BitMapHeader *the_bmhd;

                                    the_bmhd=(struct BitMapHeader *)bmhd->sp_Data;
                                    *width=the_bmhd->bmh_Width;
                                    *height=the_bmhd->bmh_Height;
                                    *depth=the_bmhd->bmh_Depth;

                                    // Don't store bmh_Compression value if compression==NULL
                                    if (compression)
                                        *compression=the_bmhd->bmh_Compression;
                                }
                            }

                            {
                                struct StoredProperty *cmap;

                                if (cmap=FindProp(iff, ID_ILBM, ID_CMAP))
                                {
                                    int num_primary_colours=cmap->sp_Size;
                                    UBYTE *primary_colour=cmap->sp_Data;
                                    int i;

                                    *palette=(ULONG *)calloc(num_primary_colours, sizeof(ULONG));
                                    memset(*palette, 0, sizeof(ULONG)*num_primary_colours);

                                    for (i=0; i<num_primary_colours; i++)
                                    {
                                        (*palette)[i]=*primary_colour++;
                                        (*palette)[i]=(*palette)[i]<<24;
                                    }
                                }
                            }

                            {
                                struct ContextNode *cn;

                                cn=CurrentChunk(iff);
                                *body=(UBYTE *)malloc(cn->cn_Size);
                                ReadChunkBytes(iff, *body, cn->cn_Size);
                            }

                            result=TRUE;
                        }
                    }
                }
                CloseIFF(iff);
            }
            Close(iff->iff_Stream);
        }
        FreeIFF(iff);
    }

    return result;
}


