/*
 * Converts a WAV-RIFF 8/16-bit PCM file into Amiga 8-bit raw at 11KHz.
 * wavtoraw <wav-file>
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


struct riff {
  char riffid[4];
  char totsize[4];
  char type[4];
};

struct fmt {
  char formatTag[2];
  char channels[2];
  char samplesPerSec[4];
  char bytesPerSec[4];
  char blockAlign[2];
  char bitsPerSample[2];
};



uint16_t le16(uint8_t *p)
{
  return ((uint16_t)p[1]<<8) | (uint16_t)p[0];
}


uint32_t le32(uint8_t *p)
{
  return ((uint32_t)p[3]<<24) | ((uint32_t)p[2]<<16) | ((uint32_t)p[1]<<8) |
         (uint32_t)p[0];
}


void readbytes(FILE *f,void *buf,size_t len)
{
  if (fread(buf,1,len,f) != len) {
    fprintf(stderr,"File read error!\n");
    exit(4);
  }
}


void write8(FILE *f,uint8_t v)
{
  uint8_t buf[1];

  buf[0] = v;
  if (fwrite(buf,1,1,f) != 1) {
    fprintf(stderr,"File write error!\n");
    exit(4);
  }
}


void skip(FILE *f,size_t nbytes)
{
  if (nbytes > 0) {
    if (fseek(f,nbytes,SEEK_CUR) != 0) {
      fprintf(stderr,"File seek error!\n");
      exit(4);
    }
  }
}


void parse_riff(FILE *f,uint32_t totsize)
{
  uint8_t buf[8];
  uint32_t len;
  int fac = 0;
  int smpbytes;

  while (totsize > 8) {

    /* read next chunk header */
    readbytes(f,buf,8);
    len = le32(&buf[4]);
    totsize -= 8 + len;

    if (!strncmp(buf,"fmt ",4) && len>=16) {
      /* parse fmt chunk */
      struct fmt fmt;
      int rate;

      readbytes(f,&fmt,sizeof(struct fmt));
      len -= sizeof(struct fmt);

      if (le16(fmt.formatTag)!=1 ||
          (le16(fmt.bitsPerSample)!=8 && le16(fmt.bitsPerSample)!=16)) {
        fprintf(stderr,"Need uncompressed 8 or 16-bit mono PCM!\n");
        exit(5);
      }
      smpbytes = le16(fmt.bitsPerSample) == 8 ? 1 : 2;

      rate = le32(fmt.samplesPerSec) * le16(fmt.channels);
      if (rate > 11025) {
        if (rate % 11025 != 0) {
          fprintf(stderr,"%u is not a multiple of 11025.\n",
                  le32(fmt.samplesPerSec));
          exit(6);
        }
        fac = rate / 11025;
      }
      else if (rate < 11025) {
        if (11025 % rate != 0) {
          fprintf(stderr,"11025 is not a divisor of %u.\n",
                  le32(fmt.samplesPerSec));
          exit(6);
        }
        fac = -(rate / 11025);
      }
      else
        fac = 1;
    }
    else if (!strncmp(buf,"data",4)) {
      /* convert PCM data */
      uint8_t dat;
      uint32_t written = 2;
      int i = 0;

      if (fac == 0) {
        fprintf(stderr,"fmt chunk missing!\n");
        exit(5);
      }

      /* write two 0-bytes at the beginning for repeat */
      write8(stdout,0);
      write8(stdout,0);

      while (len >= smpbytes) {
        readbytes(f,buf,smpbytes);
        len -= smpbytes;
        if (smpbytes == 1)
          buf[1] = buf[0] - 0x80;

        if (fac < 0) {
          for (i=0; i>fac; i--) {
            write8(stdout,buf[1]);
            written++;
          }
        }
        else {
          if (i == 0) {
            write8(stdout,buf[1]);
            written++;
          }
          if (++i == fac)
            i = 0;
        }
      }

      if (written & 1)
        write8(stdout,buf[1]);
    }

    skip(f,len);
  }
}


int main(int argc,char *argv[])
{
  struct riff buf;
  FILE *f;

  if (argc != 2) {
    fprintf(stderr,"Usage: %s <wav-file>\n",argv[1]);
    exit(1);
  }

  if (f = fopen(argv[1],"rb")) {
    readbytes(f,&buf,sizeof(struct riff));
    if (!strncmp(buf.riffid,"RIFF",4) && !strncmp(buf.type,"WAVE",4)) {
      parse_riff(f,le32(buf.totsize));
    }
    else {
      fprintf(stderr,"Not a RIFF-WAV file!\n");
      exit(3);
    }
    fclose(f);
  }
  else {
    fprintf(stderr,"Cannot open \"%s\"!\n",argv[1]);
    exit(2);
  }

  return 0;
}
