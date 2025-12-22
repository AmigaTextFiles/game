
/* Written by Peter Ekberg, peda@lysator.liu.se */
/* Sound sample support by Frank Wille, frank@phoenix.owl.de */

#ifdef HAVE_CONFIG_H
# include "../src/config.h"
#endif

#ifdef HAVE_UNISTD_H
# include <unistd.h>
#endif

#ifndef AMIGA
#include <sys/types.h>
#endif
#include <stdio.h>
#include <string.h>

#define LL (8)

void quit(char *str);
int writebuf(int count);

unsigned char buf[LL+1];
static int len;


void
quit(char *str)
{
  perror(str);
  exit(1);
}

int
writebuf(int count)
{
  int i;
  
  len += count;
#if PRINTF_RETURN >= 0
  if(
#endif
     printf("\t")
#if PRINTF_RETURN == 1
                  != 1
#endif
#if PRINTF_RETURN >= 0
                      )
    return(1)
#endif
      ;

  for(i=0; i<count-1; i++)
#if PRINTF_RETURN >= 0
    if(
#endif
       printf("0x%02x, ", buf[i])
#if PRINTF_RETURN == 1
                                  != 6
#endif
#if PRINTF_RETURN >= 0
                                      )
      return(1)
#endif
      ;

  if(i<count)
#if PRINTF_RETURN >= 0
    if(
#endif
       printf("0x%02x", buf[i])
#if PRINTF_RETURN == 1
                                != 4
#endif
#if PRINTF_RETURN >= 0
                                    )
      return(1)
#endif
      ;

  return(0);
}

int
main(int argc, char *argv[])
{
  int stat;
  int end=0;
  FILE *si;

  len = 0;
  if(argc!=2) {
    fprintf(stderr, "%s: Usage '%s variable_name'\n",
            argv[0],
            argv[0]);
    exit(1);
  }

#ifdef AMIGA
  si = stdin;
#else
  si = fdopen(fileno(stdin), "rb");
#endif

#if PRINTF_RETURN >= 0
  if(
#endif
     printf("\nunsigned char %s[] = {\n", argv[1])
#if PRINTF_RETURN == 1
                                                   != (22 + strlen(argv[1]))
#endif
#if PRINTF_RETURN >= 0
                                                                            )
    quit(argv[0])
#endif
      ;
  stat=fread(buf+LL, 1, 1, si);
  if(stat!=1) {
    if(ferror(si))
      quit(argv[0]);
    end=1;
  }
  while(!end) {
    *buf=*(buf+LL);
    stat=fread(buf+1, 1, LL, si);
    if(stat!=LL) {
      if(ferror(si))
        quit(argv[0]);
      end=1;
      if(writebuf(stat+1))
        quit(argv[0]);
    }
    else {
      if(writebuf(LL))
        quit(argv[0]);
#if PRINTF_RETURN >= 0
      if(
#endif
         printf(",\n")
#if PRINTF_RETURN == 1
                       != 2
#endif
#if PRINTF_RETURN >= 0
                           )
        quit(argv[0])
#endif
          ;
    }
  }  
#if PRINTF_RETURN >= 0
  if(
#endif
     printf(" };\n")
#if PRINTF_RETURN == 1
                     != 4
#endif
#if PRINTF_RETURN >= 0
                         )
    quit(argv[0])
#endif
      ;

  if (!strncmp(argv[1],"sound_",6))                 /* phx 08/98 */
    printf("\nunsigned int %s_len = %d;\n",argv[1],len);

  return(0);
}
