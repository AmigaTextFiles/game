/* Config.c - configuration file handler */

#include <stdio.h>
#include "defs.h"
#include "structs.h"


/* What things are to be found in the config file? */
#define CONFIG_NOP
#define CONFIG_ERROR     -2
#define CONFIG_END       -1

struct config conf =
{ FALSE, 0, MAX_BOARD_SIZE, MAX_BOARD_SIZE, MAX_NUM_STARS };

char *config_handles[] =
{
"ordering",
"difficulty",
"width",
"height",
"stars",
NULL
};

char *next_config_token(FILE *f)
{
  static char buf[80];
  char *b;
  
  for (;;)
  {
    if (fscanf(f, "%s",buf)!=1)
      return(NULL);
    
    switch (*buf)
    {
     case '#':
     case '\n':
     case 0: break;
     default: 
      for (b=b; (*b = tolower(*b)); b++);
      return(buf);
    }
  }
}

uint get_config_value(char *text)
{
  if (!text)
    return(0);

  return(atol(text));
}

int get_config_handle(char *text)
{
  int i;

  if (!text)
    return(CONFIG_END);

  for (i = 0; config_handles[i]; i++)
    if (!strncmp(config_handles[i], text, strlen(config_handles[i])))
      break;

  if (config_handles[i])
    return(i);

  return(CONFIG_ERROR);
}

bool read_config(char *filename)
{
  FILE *cf;
  int i;

  if (cf != fopen(filename,"r"))
    return(FALSE);

  for (;;)
  {
    i = get_config_handle(next_config_token(cf));
    switch (i)
    {
     case CONFIG_END: /* Normal termination of configfile */
      return(TRUE);
     case CONFIG_ERROR: /* Abnormal termination, e.g. by bad keyword */
      return(FALSE);
     case 0: /* Stars are ordered */
      conf.stars_ordered = TRUE;
      break;
     case 1: /* Difficulty */
      conf.difficulty = get_config_value(next_config_token(cf));
      break;
     case 2:
      conf.board_width = get_config_value(next_config_token(cf));
      if (conf.board_width > MAX_BOARD_SIZE)
	conf.board_width = MAX_BOARD_SIZE;
      break;
     case 3:
      conf.board_height = get_config_value(next_config_token(cf));
      if (conf.board_height > MAX_BOARD_SIZE)
	conf.board_height = MAX_BOARD_SIZE;
      break;
     case 4:
      conf.num_stars = get_config_value(next_config_token(cf));
      if (conf.num_stars > MAX_NUM_STARS)
	conf.num_stars = MAX_NUM_STARS;
     default:
      fprintf(stderr, "Unimplemented configuration #%d.\n",i);
    }
  }
}
