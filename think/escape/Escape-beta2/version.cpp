
/* this code updates the version in version.h.
   It's only necessary for building official releases,
   and it shouldn't be included in the escape executable. */

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "version.h"

int main (int argc, char ** argv) {

  char buf[256];

  int t = time(0);

  strftime(buf, 255, "%Y%m%d0", localtime((time_t*)&t));

  int n = atoi(buf);
  int oldn = atoi(VERSION);

  if (n / 10 <= oldn / 10) {
    n = oldn + 1;
    if (n / 10 != oldn / 10) {
      fprintf(stderr, "Warning: more than 10 versions today!\n");
    }
  }

  printf("/* Generated file! Do not edit. */\n");
  printf("#define VERSION \"%d\"\n", n);

  return 0;
}
