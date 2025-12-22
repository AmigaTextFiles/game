/*
 * Bytekiller Cruncher
 * Portable version rewritten in C by Frank Wille <frank@phoenix.owl.de> 2012
 *
 * Written by Frank Wille in 2013.
 *
 * I, the copyright holder of this work, hereby release it into the
 * public domain. This applies worldwide.
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

static const uint32_t MaxOffsets[4] = { 0x100,0x200,0x400,0x1000 };
static const int OffsBits[4] = { 8,9,10,12 };
static const int CmdBits[4] = { 2,3,3,3 };
static const uint32_t CmdWord[4] = { 1,4,5,6 };

static uint32_t ScanWidth = 4096;

static uint8_t *dst,*dststart;
static size_t dstfree;
static uint32_t bitstream;
static int bitsfree;
static uint32_t chksum;


static void w32(uint8_t *p,uint32_t v)
{
  *p++ = v >> 24;
  *p++ = (v >> 16) & 0xff;
  *p++ = (v >> 8) & 0xff;
  *p = v & 0xff;
}


static void writelong(void)
{
  if (dstfree < 4) {
    uint32_t off = dst - dststart;

    dststart = realloc(dststart,off*2);
    dst = dststart + off;
    dstfree = off;
  }

  w32(dst,bitstream);
  dst += 4;
  dstfree -= 4;
  chksum ^= bitstream;

  bitstream = 0;
  bitsfree = 32;
}


static void writebits(int bits,uint32_t val)
{
  while (bits--) {
    bitstream = (bitstream << 1) | (val & 1);
    val >>= 1;
    if (--bitsfree == 0)
      writelong();
  }
}


static void dump(int n)
{
  if (n >= 9)
    writebits(11,0x700|(n-9));
  else if (n >= 1)
    writebits(5,n-1);
}


int bk_crunch(uint8_t *src,size_t srclen,void **buf,size_t *buflen)
{
  uint8_t *srcend;
  uint8_t *scanptr,*scanend;
  int dumpcnt;
  int copylen,bestlen;
  int copytype,besttype;
  uint32_t copyoffs,bestoffs;

  srcend = src + srclen;
  dststart = malloc(srclen/4 + 12);
  dst = dststart + 12;
  dstfree = srclen/4;

  bitstream = 0;
  bitsfree = 32;
  chksum = 0;
  dumpcnt = 0;

  while (src < srcend) {
    scanend = src + ScanWidth;
    if (scanend >= srcend)
      scanend = srcend - 1;

    bestlen = 1;
    scanptr = src + 1;

    /* scan for sequences to copy */
    while (scanptr < scanend) {
      if (src[0]==scanptr[0] && src[1]==scanptr[1]) {
        /* can copy at least 2 bytes, determine length of sequence */
        for (copylen=0;
             &scanptr[copylen]<scanend && src[copylen]==scanptr[copylen];
             copylen++);

        if (copylen > bestlen) {
          /* found new longest sequence to copy */
          copyoffs = scanptr - src;
          if (copylen > 4) {
            copytype = 3;
            if (copylen > 0x100)
              copylen = 0x100;  /* max sequence length is 256 */
          }
          else
            copytype = copylen - 2;

          if (copyoffs < MaxOffsets[copytype]) {
            /* remember new best sequence */
            bestlen = copylen;
            bestoffs = copyoffs;
            besttype = copytype;
          }
        }

        scanptr += copylen;
      }
      else
        scanptr++;
    }

    if (bestlen > 1) {
      /* we found a copy-sequence */
      dump(dumpcnt);
      dumpcnt = 0;
      writebits(OffsBits[besttype],bestoffs);
      if (besttype == 3)
        writebits(8,bestlen-1);
      writebits(CmdBits[besttype],CmdWord[besttype]);

      src += bestlen;
    }
    else {
      /* nothing to copy, dump the current src-byte */
      writebits(8,*src++);
      if (++dumpcnt >= 0x108) {
        dump(dumpcnt);
        dumpcnt = 0;
      }
    }
  }

  dump(dumpcnt);
  bitstream |= 1L<<(32-bitsfree);
  writelong();

  w32(dststart,dst-dststart-12);
  w32(dststart+4,srclen);
  w32(dststart+8,chksum);

  *buf = dststart;
  *buflen = dst - dststart;
  return 0;
}


int main(int argc,char *argv[])
{
  int rc = 1;

  if (argc==3 || argc==4) {
    FILE *in,*out;
    void *p,*buf;
    size_t flen,buflen;

    if (in = fopen(argv[1],"rb")) {
      fseek(in,0,SEEK_END);
      flen = ftell(in);
      fseek(in,0,SEEK_SET);
      if (p = malloc(flen)) {
        if (fread(p,1,flen,in) == flen) {
          if (argc == 4) {
            ScanWidth = atoi(argv[3]);
            if (ScanWidth < 8)
              ScanWidth = 8;
            else if (ScanWidth > 4096)
              ScanWidth = 4096;
          }
          if (bk_crunch(p,flen,&buf,&buflen) == 0) {
            if (out = fopen(argv[2],"wb")) {
              fwrite(buf,1,buflen,out);
              fclose(out);
              rc = 0;
            }
            else
              fprintf(stderr,"Cannot open output file '%s'!\n",argv[2]);
          }
          else
            fprintf(stderr,"Cannot crunch '%s'.\n",argv[1]);
        }
        else
          fprintf(stderr,"Read error on '%s'!\n",argv[1]);
      }
      else
        fprintf(stderr,"Failed to allocate %lu bytes of memory!\n",flen);
      fclose(in);
    }
    else
      fprintf(stderr,"Cannot open input file '%s'!\n",argv[1]);
  }
  else
    fprintf(stderr,"Usage: %s <src file> <crunched file> [scan width]\n",
            argv[0]);

  return rc;
}
