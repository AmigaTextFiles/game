#include <string.h>

char *strsep(char **input,const char *seps)
{
	char *in;
  int i;
  int start;
  int j;
  char *out;
  char *out2;

  in=*input;

	if (!stricmp(seps,"\0")) return in;

  out=strpbrk(in,seps);

	if (!out) return 0;
  *out=0;
  out2=out;
  out2++;
  input=&out2;

  return out;    
}
