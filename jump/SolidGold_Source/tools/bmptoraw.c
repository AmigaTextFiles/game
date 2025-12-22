/*
 * bmptoraw <bmpfile> <img-width> <img-height> <img-depth>
 *          [TEST|CMAP|MASK|NOMASK|SPRITE|TYPES|HEADER]
 *          [maximgs] / [types-file [maximgs]] / [spr-file1 [spr-file2]]
 *
 * Reads a BMP picture and cuts out a number of raw images.
 * mode="TEST" writes an ILBM image for testing (dimensions irrelevant).
 * mode="CMAP" writes the pictures colormap.
 * mode="MASK" writes a binary with block masks.
 * mode="NOMASK" writes a binary without block masks.
 * mode="TYPES" write masks or leave out blocks, according to types-file
 * mode="HEADER" writes a binary without block masksm but with a header
 *               containing width, height and the RGB4 color map.
 * mode="SPRITE" writes a 4-color or two 16-color sprites.
 * Otherwise create a binary output with <img-depth> masks.
 *
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

/* operation modes */
#define TEST      0
#define CMAP      1
#define MASK      2
#define NOMASK    3
#define TYPES     4
#define HEADER    5
#define SPRITE    6

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

FILE *bmpfile,*typesfile;


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


void write8(FILE *f,uint8_t v)
{
  uint8_t buf[1];

  buf[0] = v;
  if (fwrite(buf,1,1,f) != 1) {
    fprintf(stderr,"file write error\n");
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


void write32be(FILE *f,uint32_t v)
{
  uint8_t buf[4];

  buf[0] = (v >> 24) & 0xff;
  buf[1] = (v >> 16) & 0xff;
  buf[2] = (v >> 8) & 0xff;
  buf[3] = v & 0xff;
  if (fwrite(buf,1,4,f) != 4) {
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
    skip(f,bisize-36);
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


void write_ilbm(FILE *f,struct bmppic *pic)
{
  uint8_t nplanes,pix,*src,*dst;
  uint32_t rowsize,col;
  int i,j,row,d;

  nplanes = get_planes(pic);
  rowsize = ((pic->width+15) >> 4) << 1;

  write32be(f,0x464f524d);  /* FORM */
  /* FORM size: ILBM + BMHD(20) + CMAP(3*ncols) + BODY(rowsz*hght*nplanes) */
  write32be(f,4+4+20+4+3*(1<<nplanes)+4+rowsize*pic->height*nplanes);
  write32be(f,0x494c424d);  /* ILBM */

  /* BMHD */
  write32be(f,0x424d4844);
  write32be(f,20);
  write16be(f,pic->width);
  write16be(f,pic->height);
  write32be(f,0);
  write8(f,nplanes);
  write8(f,0);  /* no masking */
  write8(f,0);  /* no compression */
  write8(f,0);
  write16be(f,0);
  write16be(f,0x0a0b);
  write16be(f,pic->width);
  write16be(f,pic->height);

  /* CMAP */
  write32be(f,0x434d4150);
  write32be(f,3*(1<<nplanes));
  for (i=0; i<(1<<nplanes); i++) {
    col = pic->colormap[i];
    write8(f,(col>>16)&0xff);
    write8(f,(col>>8)&0xff);
    write8(f,col&0xff);
  }

  /* BODY */
  write32be(f,0x424f4459);
  write32be(f,rowsize*pic->height*nplanes);
  src = pic->bitmap;
  for (row=0; row<pic->height; row++) {
    for (d=0; d<nplanes; d++) {
      for (i=0; i<(pic->width>>3); i++) {
        for (j=0,pix=0; j<8; j++)
          pix |= ((src[(i<<3)+j] >> d) & 1) << (7-j);
        write8(f,pix);
      }
      for (i=pic->width>>3; i<rowsize; i++)
        write8(f,0);
    }
    src += pic->width;
  }
}


void write_raw(FILE *f,struct bmppic *pic,int imgw,int imgh,int imgd,
               FILE *tf,int nomask,int maximgs)
{
  int iperrow,ipercol,isize,row,col,x,y,z,b,imgcnt;
  uint8_t *types,*buf,*p,*msk,*src,pix;

  if (imgw>pic->width || imgh>pic->height || imgd>get_planes(pic)) {
    fprintf(stderr,"requested images too large\n");
    exit(2);
  }

  /* width/height of 0 defaults to picture width/height */
  if (imgw == 0)
    imgw = pic->width;
  if (imgh == 0)
    imgh = pic->height;
  if (imgd == 0)
    imgd = get_planes(pic);

  iperrow = pic->width / imgw;
  ipercol = pic->height / imgh;
  isize = (imgw>>3) * imgh * imgd;

  if (maximgs==0 || maximgs>iperrow*ipercol)
    maximgs = iperrow * ipercol;

  /* read types file, when given */
  types = myalloc(maximgs);
  memset(types,nomask?1:2,maximgs);
  if (tf) {
    fread(types,1,maximgs,tf);
    if (ferror(tf)) {
      fprintf(stderr,"error reading types file\n");
      exit(3);
    }
  }

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

      if (++imgcnt > maximgs)
        return;

      /* write out the image, including mask when requested (type==2) */
      if (*types > 0)
        fwrite(buf,1,(*types>1)?isize*2:isize,f);
      types++;
    }
  }
}


void write_sprite(FILE *f1,FILE *f2,struct bmppic *pic,
                  int imgw,int imgh,int imgd)
{
  int ssize,row,col,x,y,z,b;
  uint8_t *types,*buf,*p,*msk,*src,pix;

  if (imgw>pic->width || imgh>pic->height || imgd>get_planes(pic)) {
    fprintf(stderr,"requested images too large\n");
    exit(2);
  }
  if (imgd!=2 && imgd!=4) {
    fprintf(stderr,"illegal depth for a sprite\n");
    exit(2);
  }
  if (imgw != 16) {
    fprintf(stderr,"illegal width for a sprite\n");
    exit(2);
  }

  ssize = (imgw>>3) * imgh * 2;
  buf = myalloc(2*ssize);           /* maximum of 2 sprites (16 colors) */
  memset(buf,0,2*ssize);

  /* write out raw sprites */
  src = pic->bitmap;
  for (y=0; y<imgh; y++) {
    for (z=0; z<imgd; z++) {
      for (x=0; x<2; x++) {
        for (b=0,pix=0; b<8; b++)
          pix |= ((src[(x<<3)+b] >> z) & 1) << (7-b);
        buf[(z>=2?ssize:0)+y*4+x+2*(z&1)] = pix;
      }
    }
    src += pic->width;
  }

  if (f1)
    fwrite(buf,1,ssize,f1);
  if (f2!=NULL && imgd>2)
    fwrite(buf+ssize,1,ssize,f2);
}


void write_cmap(FILE *f,struct bmppic *pic,int imgd)
{
  int i,ncol;
  uint32_t col;
  uint16_t rgb4;

  if (imgd > get_planes(pic)) {
    fprintf(stderr,"requested colormap depth is too high\n");
    exit(3);
  }

  ncol = 1 << imgd;
  for (i=0; i<ncol; i++) {
    col = pic->colormap[i];
    rgb4 = ((col>>12)&0xf00) | ((col>>8)&0x0f0) | ((col>>4)&0x00f);
    write16be(f,rgb4);
  }
}


void cleanup(void)
{
  if (typesfile)
    fclose(typesfile);
  if (bmpfile)
    fclose(bmpfile);
}


int main(int argc,char *argv[])
{
  int mode,imgw,imgh,imgd,maximgs;
  struct bmppic *pic;

  if (argc < 5) {
    fprintf(stderr,"%s <bmpfile> <img-width> <img-height> <img-depth> "
            "[CMAP|MASK|NOMASK|SPRITE|TYPES|HEADER] [maximgs] or "
            "[types-file [maximgs]] or [sprite-file1 [sprite-file2]]\n",
            argv[0]);
    exit(1);
  }

  bmpfile = fopen(argv[1],"rb");
  imgw = atoi(argv[2]);
  imgh = atoi(argv[3]);
  imgd = atoi(argv[4]);

  if (argc >= 6) {
    if (strcmp(argv[5],"TEST") == 0)
      mode = TEST;
    else if (strcmp(argv[5],"CMAP") == 0)
      mode = CMAP;
    else if (strcmp(argv[5],"MASK") == 0)
      mode = MASK;
    else if (strcmp(argv[5],"NOMASK") == 0)
      mode = NOMASK;
    else if (strcmp(argv[5],"HEADER") == 0)
      mode = HEADER;
    else if (strcmp(argv[5],"TYPES") == 0) {
      if (argc < 7) {
        fprintf(stderr,"%s: missing types-files\n",argv[0]);
        exit(2);
      }
      typesfile = fopen(argv[6],"rb");
      mode = TYPES;
    }
    else if (strcmp(argv[5],"SPRITE") == 0)
      mode = SPRITE;
    else {
      fprintf(stderr,"%s: bad mode: %s\n",argv[0],argv[5]);
      exit(2);
    }
  }
  else if (imgw==0 && imgh==0 && imgd==0)
    mode = TEST;
  else
    mode = MASK;

  if (typesfile!=NULL && argc>=8)
    maximgs = atoi(argv[7]);
  else if ((mode==MASK || mode==NOMASK) && argc>=7)
    maximgs = atoi(argv[6]);
  else
    maximgs = 0;

  if (bmpfile==NULL || imgd>5 || (imgw & 7)!=0) {
    fprintf(stderr,"%s: bad arguments\n",argv[0]);
    exit(2);
  }

  atexit(cleanup);

  pic = read_bmp(bmpfile);

  if (pic != NULL) {
    FILE *f1,*f2;

    switch (mode) {
      case TEST:
        write_ilbm(stdout,pic);  /* test mode: ILBM image */
        break;
      case MASK:
        write_raw(stdout,pic,imgw,imgh,imgd,NULL,0,maximgs);
        break;
      case NOMASK:
        write_raw(stdout,pic,imgw,imgh,imgd,NULL,1,maximgs);
        break;
      case HEADER:  /* width.w, height.w, ncolors * rgb4.w, [raw data] */
        if (imgd == 0)
          imgd = get_planes(pic);
        write16be(stdout,pic->width);
        write16be(stdout,pic->height);
        write_cmap(stdout,pic,imgd);
        write_raw(stdout,pic,pic->width,pic->height,imgd,NULL,1,0);
        break;
      case SPRITE:
        f1 = f2 = NULL;
        if (argc > 6)
          f1 = fopen(argv[6],"wb");
        if (argc > 7)
          f2 = fopen(argv[7],"wb");
        if (f1 == NULL) {
          fprintf(stderr,"%s: missing sprite output file name\n",argv[0]);
          exit(2);
        }
        write_sprite(f1,f2,pic,imgw,imgh,imgd);
        if (f2)
          fclose(f2);
        if (f1)
          fclose(f1);
        break;
      case CMAP:
        write_cmap(stdout,pic,imgd?imgd:get_planes(pic));
        break;
      default:
        write_raw(stdout,pic,imgw,imgh,imgd,typesfile,1,maximgs);
        break;
    }
  }

  return 0;
}
