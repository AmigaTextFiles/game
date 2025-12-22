/* Amiga Scare Glk implementation */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "glk.h"
#include "glkterm.h"

char TitleBar[] = "Amiga Scare 1.3.10";
char AboutText[] =
  "Amiga Scare 1.3.10\n"
  "Scare © 2003-2008 by Simon Baldwin\n"
  "Amiga version written by David Kinder";
char InitReqTitle[] = "Select an ADRIFT Game";
char InitReqPattern[] = "#?.taf";

extern int gsc_startup_called;

int amiga_startup_code(char* path)
{
  frefid_t fileref;
  strid_t game_stream;

  fileref = gli_new_fileref(path,fileusage_BinaryMode|fileusage_Data,0);
  if (fileref != 0)
  {
    game_stream = glk_stream_open_file(fileref,filemode_Read,0);
    glk_fileref_destroy(fileref);
    if (game_stream != 0)
    {
      gsc_startup_called = TRUE;
      glk_stylehint_set(wintype_TextGrid,style_Normal,stylehint_ReverseColor,1);
      return gsc_startup_code(game_stream,0,0,0,0,0);
    }
  }

  return 0;
}

double difftime(time_t t1, time_t t2)
{
  return t1-t2;
}
