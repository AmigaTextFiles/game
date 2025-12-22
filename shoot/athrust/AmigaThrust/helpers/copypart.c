/*
 * copypart.c
 * Copy a file partially beginning at an arbitrary offset.
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>


main(int argc,char *argv[])
{
  FILE *fs,*fd;
  long offs,len;
  int c,r=0;

  if (argc != 5) {
    printf("Usage:\n  %s <src> <dest> <offset> <len>\n",argv[0]);
    exit(0);
  }
  if ((offs = atol(argv[3])) < 0 || (len = atol(argv[4])) < 0) {
    fprintf(stderr,"File offset and length must be positive!\n");
    exit(1);
  }
  if (fs = fopen(argv[1],"r")) {
    if (fd = fopen(argv[2],"w")) {
      if (!(fseek(fs,offs,SEEK_SET))) {
        do {
          if ((c = fgetc(fs)) == EOF)
            break;
          fputc(c,fd);
        }
        while (--len);
      }
      else {
        fprintf(stderr,"Seek error!\n");
        r = 1;
      }
      fclose(fd);
    }
    else {
      fprintf(stderr,"Can't open destination file \"%s\".\n",argv[2]);
      r = 1;
    }
    fclose(fs);
  }
  else {
    fprintf(stderr,"Can't open source file \"%s\".\n",argv[1]);
    r = 1;
  }
  exit(r);
}
