/*
 * Sinus table generator.
 *
 * Written by Frank Wille in 2013.
 *
 * I, the copyright holder of this work, hereby release it into the
 * public domain. This applies worldwide.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PI 3.14159265358979323846
#define DCPERLINE 8
#define DC "dc.b"

int main(int argc,char *argv[])
{
  int ent,i;
  double amp,v;

  if (argc != 3) {
    printf("Usage: %s <amplitude> <entries>\n",argv[0]);
    exit(1);
  }
  
  amp = (double)atoi(argv[1]);
  ent = atoi(argv[2]);

  for (i=0; i<ent; i++) {
    if (i % DCPERLINE == 0)
      printf("\n\t%s\t",DC);
    else
      putchar(',');
    v = amp * sin((2.0*PI / ent) * (double)i);
    printf("%d",(int)(v+0.5));
  }
  putchar('\n');

  return 0;
}
