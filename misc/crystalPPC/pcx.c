#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//vonmir
//#include <unistd.h>

//ersatzlos gestrichen
//
#include "global.h"

extern void dprintf (char *, ...);

typedef struct
{
        char    manufacturer;
        char    version;
        char    encoding;
        char    bits_per_pixel;
        word    xmin;
        word    ymin;
        word    xmax;
        word    ymax;
        word    hres;
        word    vres;
        byte    palette[48];
        char    reserved;
        char    color_planes;
        word    bytes_per_line;
        word    palette_type;
        char    filler[58];
        byte    data;
} pcx_header;

void WritePCX (char *name, char *data, byte *pal, int width, int height)
{
        int i, j, len;
        pcx_header *pcx;
        byte *pack;
        FILE *fp;

        pcx = (pcx_header*)malloc (width*height*2+1000);
        pcx->manufacturer = 0;
        pcx->version = 5;
        pcx->encoding = 1;
        pcx->bits_per_pixel = 8;
        pcx->xmin = 0;
        pcx->ymin = 0;
        pcx->xmax = width - 1;
        pcx->ymax = height - 1;
        pcx->hres = width;
        pcx->vres = height;
        memset (pcx->palette, 0, sizeof(pcx->palette));
        pcx->color_planes = 1;
        pcx->bytes_per_line = width;
        pcx->palette_type = 2;
        memset (pcx->filler, 0, sizeof(pcx->filler));
        pack = &(pcx->data);

        for (i=0; i<height; i++)
        {
                for (j=0; j<width; j++)
                {
                        if  ((*data & 0xc0) != 0xc0)
                                *pack++ = *data++;
                        else
                        {
                                *pack++ = 0xc1;
                                *pack++ = *data++;
                        }
                }
//              data += width;
        }
        *pack++ = 0x0c;
        for (i=0; i<768; i++)
                *pack++ = *pal++;
        len = pack - (byte *)pcx;
        fp = fopen (name, "wb");
        if (!fp) return;
        fwrite (pcx, len, 1, fp);
        fclose (fp);
        free (pcx);
}
