/*
 * Splits a standard SoundTracker/ProTracker MOD file into two parts:
 * - <name>.trk : MOD data (header, sample info, song arrangement, patterns)
 * - <name>.smp : MOD samples (to be loaded into Chip RAM)
 *
 * Usage: splitmod <name>
 *
 * Written by Frank Wille in 2013.
 *
 * I, the copyright holder of this work, hereby release it into the
 * public domain. This applies worldwide.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


static size_t filesize(FILE *fp,const char *name)
{
  long oldpos,size;

  if ((oldpos = ftell(fp)) >= 0)
    if (fseek(fp,0,SEEK_END) >= 0)
      if ((size = ftell(fp)) >= 0)
        if (fseek(fp,oldpos,SEEK_SET) >= 0)
          return (size_t)size;

  fprintf(stderr,"Cannot determine file size of \"%s\"!\n",name);
  return 0;
}


static int splitmod(char *name,unsigned char *mod,size_t len)
{
  unsigned char *p;
  unsigned char maxpat;
  char *namebuf;
  size_t smp_off;
  FILE *f;
  int werr = 1;
  int i;

  /* buffer for new name with .trk or .smp extension */
  namebuf = malloc(strlen(name) + 5);
  if (!namebuf) {
    fprintf(stderr,"No memory for name buffer!\n");
    return 1;
  }

  /* determine number of patterns */
  for (p=&mod[952],maxpat=0,i=0; i<128; p++,i++) {
    if (*p > maxpat)
      maxpat = *p;
  }

  /* samples reside the patterns */
  smp_off = ((size_t)(maxpat+1) << 10) + 1084;

  /* write the tracker part */
  sprintf(namebuf,"%s.trk",name);
  if (f = fopen(namebuf,"wb")) {
    if (fwrite(mod,1,smp_off,f) == smp_off) {
      fclose(f);

      /* write the sample part */
      sprintf(namebuf,"%s.smp",name);
      if (f = fopen(namebuf,"wb")) {
        if (fwrite(mod+smp_off,1,len-smp_off,f) == len-smp_off)
          werr = 0;
        fclose(f);
      }
    }
  }

  if (werr) {
    fprintf(stderr,"Cannot write \"%s\"!\n",namebuf);
    return 1;
  }
  return 0;
}


int main(int argc,char *argv[])
{
  int rc = 1;
  FILE *f;

  if (argc != 2) {
    fprintf(stderr,"Usage: %s <name>\n",argv[0]);
    return 1;
  }

  if (f = fopen(argv[1],"rb")) {
    size_t len;
    unsigned char *mod;

    len = filesize(f,argv[1]);
    if (len) {
      mod = malloc(len);
      if (mod) {
        if (fread(mod,1,len,f) == len)
          rc = splitmod(argv[1],mod,len);
        else
          fprintf(stderr,"Read error (\"%s\")!\n",argv[1]);
      }
      else
        fprintf(stderr,"Out of memory!\n");
    }
    fclose(f);
  }
  else
    fprintf(stderr,"Cannot open \"%s\"!\n",argv[1]);

  return rc;
}
