/*
 * bmptocop <bmpfile> [DITHER]
 *
 * Reads a 24-bit BMP picture and writes a sequence of: number of lines
 * with the same color, RGB4 color code. The information is retrieved
 * from the first pixel of each line.
 *
 * Written by Frank Wille in 2013.
 *
 * I, the copyright holder of this work, hereby release it into the
 * public domain. This applies worldwide.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

/* BMP compression encodings */
#define BI_RGB		0
#define BI_RLE8		1
#define BI_RLE4		2
#define BI_BITFIELDS	3

FILE *bmpfile;
int dither;


uint8_t read8(FILE *f)
{
  uint8_t buf[1];

  if (fread(buf,1,1,f) != 1) {
    fprintf(stderr,"file read error\n");
    exit(5);
  }
  return buf[0];
}


uint16_t read16le(FILE *f)
{
  uint8_t buf[2];

  if (fread(buf,1,2,f) != 2) {
    fprintf(stderr,"file read error\n");
    exit(5);
  }
  return (buf[1] << 8) | buf[0];
}


uint32_t read32le(FILE *f)
{
  uint8_t buf[4];

  if (fread(buf,1,4,f) != 4) {
    fprintf(stderr,"file read error\n");
    exit(5);
  }
  return (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
}


void skip(FILE *f,uint32_t off)
{
  if (fseek(f,off,SEEK_CUR) != 0) {
    fprintf(stderr,"file seek error\n");
    exit(5);
  }
}


void write16be(FILE *f,uint16_t v)
{
  uint8_t buf[2];

  buf[0] = v >> 8;
  buf[1] = v & 0xff;
  if (fwrite(buf,1,2,f) != 2) {
    fprintf(stderr,"file write error\n");
    exit(5);
  }
}


void *myalloc(size_t n)
{
  void *p;

  if (n == 0)
    n = 1;
  p = malloc(n);
  if (p == NULL) {
    fprintf(stderr,"out of memory\n");
    exit(5);
  }
  return p;
}


void bmp_to_cop(FILE *f)
{
  uint32_t bmoffset,bisize,bicompression,bicolors,padding;
  uint16_t h,biwidth,biheight,biplanes,bibitcount,rgb4;
  uint16_t *p,*top,*bottom,last;
  uint8_t pixel24[3];
  int i,topdown;

  /* check magic ID */
  if (read8(f) != 'B')
    exit(2);
  if (read8(f) != 'M')
    exit(2);

  /* skip size and reserved fields */
  skip(f,8);

  bmoffset = read32le(f);

  /* read BITMAPINFOHEADER */
  bisize = read32le(f);
  if (bisize == 12) {
    biwidth = read16le(f);
    biheight = read16le(f);
    biplanes = read16le(f);
    bibitcount = read16le(f);
    bicompression = BI_RGB;
    bicolors = 0;
  }
  else {
    biwidth = read32le(f);
    biheight = read32le(f);
    biplanes = read16le(f);
    bibitcount = read16le(f);
    bicompression = read32le(f);
    skip(f,12);
    bicolors = read32le(f);
    skip(f,bisize-36);
  }
  if (bicolors == 0)
    bicolors = 1 << bibitcount;
  if ((int16_t)biheight < 0) {
    biheight = -(int16_t)biheight;
    topdown = 2;
  }
  else
    topdown = -2;

  if (bibitcount != 24) {
    fprintf(stderr,"Not a true-color BMP\n");
    exit(3);
  }
  if (bicompression != BI_RGB) {
    fprintf(stderr,"Compressed BMP not supported\n");
    exit(3);
  }

  /* allocate color buffer for biheight entries */
  p = myalloc((size_t)(biheight+2) * sizeof(uint16_t)*2);
  p += 2;

  /* determine line padding */
  padding = (biwidth & 3) ? 4 - (biwidth & 3) : 0;

  /* write leftmost pixels to temporary color buffer */
  i = topdown>0 ? -2 : biheight*2;
  p[i] = 0;
  p[i+1] = ~0;

  for (h=0; h<biheight; h++) {
    if (fread(pixel24,1,3,f) != 3) {
      fprintf(stderr,"file read error\n");
      exit(5);
    }
    skip(f,((biwidth-1)*3)+padding);
    rgb4 = ((pixel24[2]&0xf0)<<4) | (pixel24[1]&0xf0) | ((pixel24[0]&0xf0)>>4);

    if (p[i+1] != rgb4) {
      i += topdown;
      p[i+1] = rgb4;
      p[i] = 1;
    }
    else {
      p[i]++;

      if (dither && p[i]==3 && p[i-topdown]>2) {
        /* Two bars with a minimum height of 3: dither the edge between them */
        /* xxyxyy */
        /*   ^^   */
        p[i+2*topdown] = p[i] - 1;
        p[i+2*topdown+1] = p[i+1];
        p[i-topdown]--;
        p[i] = p[i+topdown] = 1;
        p[i+1] = p[i+2*topdown+1];
        p[i+topdown+1] = p[i-topdown+1];
        i += 2*topdown;
      }
    }
  }

  /* write output */
  if (topdown > 0)
    for (h=0; h<i+2; write16be(stdout,p[h++]));
  else
    for (h=i; h<biheight*2; write16be(stdout,p[h++]));
}


void cleanup(void)
{
  if (bmpfile)
    fclose(bmpfile);
}


int main(int argc,char *argv[])
{
  int mode,imgw,imgh,imgd,maximgs;
  struct bmppic *pic;

  if (argc < 2) {
    fprintf(stderr,"%s <bmpfile> [DITHER]\n",argv[0]);
    exit(1);
  }

  dither = argc > 2 && !strcmp(argv[2],"DITHER");
  bmpfile = fopen(argv[1],"rb");
  atexit(cleanup);
  bmp_to_cop(bmpfile);

  return 0;
}
