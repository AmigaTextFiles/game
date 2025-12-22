/*
 * bmptoraw <bmpfile> <img-width> <img-height> <img-depth> [MASK]
 *
 * Reads a BMP picture and cuts out a number of raw images.
 * Appends an interleaved mask when requested.
 *
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

struct bmppic {
  uint16_t width,height,depth,ncolors;
  uint8_t *bitmap;
  uint32_t *colormap;
};

FILE *bmpfile;


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


struct bmppic *read_bmp(FILE *f)
{
  struct bmppic *pic;
  uint32_t bmoffset,bisize,bicompression,bicolors,padding;
  uint16_t biwidth,biheight,biplanes,bibitcount;
  uint8_t *p,r,g,b,*top,*bottom;
  int i,topdown;

  /* check magic ID */
  if (read8(f) != 'B')
    return NULL;
  if (read8(f) != 'M')
    return NULL;

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
    skip(f,4);
  }
  if (bicolors == 0)
    bicolors = 1 << bibitcount;
  if ((int16_t)biheight < 0) {
    biheight = -(int16_t)biheight;
    topdown = 1;
  }
  else
    topdown = 0;

  if (bibitcount > 8) {
    fprintf(stderr,"true-color BMP not supported\n");
    exit(3);
  }
  if (bicompression != BI_RGB) {
    fprintf(stderr,"Compressed BMP not supported\n");
    exit(3);
  }

  /* create the bmppic object */
  pic = myalloc(sizeof(struct bmppic));
  pic->width = biwidth;
  pic->height = biheight;
  pic->depth = 8;

  /* load the palette */
  pic->ncolors = bicolors;
  pic->colormap = myalloc(sizeof(uint32_t) * bicolors);
  for (i=0; i<bicolors; i++) {
    b = read8(f);
    g = read8(f);
    r = read8(f);
    if (bisize != 12)
      skip(f,1);
    pic->colormap[i] = ((uint32_t)r << 16) | ((uint32_t)g << 8) | (uint32_t)b;
  }

  /* make an 8-bit bitmap for biwidth*biheight */
  top = pic->bitmap = myalloc((size_t)biwidth * (size_t)biheight);
  bottom = top + (size_t)biwidth * (size_t)biheight;

  /* determine line padding */
  switch (bibitcount) {
    case 1:
      i = (biwidth + 7) >> 3;
      padding = (i & 3) ? 4 - (i & 3) : 0;
      break;
    case 4:
      i = (biwidth + 1) >> 1;
      padding = (i & 3) ? 4 - (i & 3) : 0;
      break;
    default:
      padding = (biwidth & 3) ? 4 - (biwidth & 3) : 0;
      break;
  }

  /* write to bitmap */
  p = topdown ? top : bottom - biwidth;

  while (p>=top && p<bottom) {
    switch (bibitcount) {
      case 1:
      case 4:
        for (i=0; i<biwidth; i++) {
          if (i % (8/bibitcount) == 0)
            b = read8(f);
          *(p + i) = b >> (8-bibitcount);
          b <<= bibitcount;
        }
        break;
      default:
        if (fread(p,1,biwidth,f) != biwidth) {
          fprintf(stderr,"file read error\n");
          exit(5);
        }
        break;
    }
    if (padding)
      skip(f,padding);
    if (topdown)
      p += biwidth;
    else
      p -= biwidth;
  }

  return pic;
}


uint8_t get_planes(struct bmppic *pic)
{
  /* determines number of planes */
  if (pic->ncolors > 16)
    return 5;
  else if (pic->ncolors > 8)
    return 4;
  else if (pic->ncolors > 4)
    return 3;
  else if (pic->ncolors > 2)
    return 2;
  return 1;
}


void write_raw(FILE *f,struct bmppic *pic,int imgw,int imgh,int imgd,int mask)
{
  int iperrow,ipercol,isize,row,col,x,y,z,b,imgcnt;
  uint8_t *buf,*p,*msk,*src,pix;

  if (imgw>pic->width || imgh>pic->height || imgd>get_planes(pic)) {
    fprintf(stderr,"requested images too large\n");
    exit(2);
  }

  iperrow = pic->width / imgw;
  ipercol = pic->height / imgh;
  isize = (imgw>>3) * imgh * imgd;

  /* write out raw images */
  buf = myalloc(isize*2);  /* image buffer including mask */
  imgcnt = 0;

  for (col=0; col<ipercol; col++) {
    for (row=0; row<iperrow; row++) {
      p = buf;
      msk = buf + isize;
      memset(msk,0,isize);
      src = pic->bitmap + col*imgh*pic->width + row*imgw;

      for (y=0; y<imgh; y++) {
        for (z=0; z<imgd; z++) {
          for (x=0; x<(imgw>>3); x++) {
            for (b=0,pix=0; b<8; b++)
              pix |= ((src[(x<<3)+b] >> z) & 1) << (7-b);
            *p++ = pix;
            msk[x] |= pix;
          }
        }
        src += pic->width;

        /* duplicate mask for each interleaved plane */
        for (z=1; z<imgd; z++)
          memcpy(&msk[z*(imgw>>3)],msk,imgw>>3);
        msk += (imgw>>3)*imgd;
      }

      if (++imgcnt > (iperrow * ipercol))
        return;

      /* write out the image, including mask when requested */
      fwrite(buf,1,mask?isize*2:isize,f);
    }
  }
}


void cleanup(void)
{
  if (bmpfile)
    fclose(bmpfile);
}


int main(int argc,char *argv[])
{
  int imgw,imgh,imgd,mask;
  struct bmppic *pic;

  if (argc < 5) {
    fprintf(stderr,"%s <bmpfile> <img-width> <img-height> <img-depth> "
            " [MASK]\n",argv[0]);
    exit(1);
  }

  bmpfile = fopen(argv[1],"rb");
  imgw = atoi(argv[2]);
  imgh = atoi(argv[3]);
  imgd = atoi(argv[4]);

  if (bmpfile==NULL || imgd>5 || (imgw & 7)!=0) {
    fprintf(stderr,"%s: bad arguments\n",argv[0]);
    exit(2);
  }

  if (argc >= 5)
    mask = strcmp(argv[5],"MASK") == 0;
  else
    mask = 0;

  atexit(cleanup);

  pic = read_bmp(bmpfile);

  if (pic != NULL)
    write_raw(stdout,pic,imgw,imgh,imgd,mask);

  return 0;
}
