#include "goutils.h"
#include <stdio.h>

char *getStrPos (int x, int y) {

  static char msg [128];
  char c = 'A'+x;
  if (c>='I') c++;
  sprintf (msg, "%c%d", c,19-y);
  return msg;
}


Case strToCase (char *s) {

  Case ret;
  char c = *s;
  int num = atoi (s+1);
  if (c > 'I') c--;

  ret.x = c - 'A';
  ret.y = 19 - num;

  return ret;
}
