/*  Chaos:                  The Chess HAppening Organisation System     V5.4
    Copyright (C)   1993    Jochen Wiedmann

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


    $RCSfile: main.c,v $
    $Revision: 3.3 $
    $Date: 1994/11/19 19:32:01 $

    This file contains main() and some other global stuff.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
                Am Eisteich 9
          72555 Metzingen
                Tel. 07123 / 14881
                Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


char *AVERSION = "Chaos V5.5";
char *PVERSION = "Chaos V5.5     (C) 1993-1995   by  Jochen Wiedmann";
char *VERVERSION = "$VER: Chaos 5.5 (05.06.95)";


#ifndef CHAOS_H
#include "chaos.h"
#endif


/*
    Global variables
*/
struct List PlayerList;
int IsSaved                             = TRUE;
int OutputDevice                        = FALSE;
char TrnFileName [TRNFILENAME_LEN+1]    = "";
int AllowErrorMessage                   = TRUE;
int DefaultWinnerPoints                 = 2;
int DefaultDrawPoints                   = 1;

/*
    The following global variables get saved into the tournament file.
*/
int NumRounds                           = 0;
struct Player *RankingFirst             = NULL;
int NumPlayers                          = 0;
int NumGamesMissing;
char TrnName [TRNNAME_LEN+1]            = "";
int WinnerPoints;
int DrawPoints;
int TrnMode                             = TNMODEF_SWISS_PAIRING;



/*
    The Cleanup() function gets called when the program terminates.
*/
void Cleanup(void)

  {
    TerminateMainWnd();
    PutMemAll();
    CloseLibs();
  }



/*
    Die übliche main()-Funktion
*/
void main(int argc, char *argv[])

{
  if (atexit(Cleanup))
  { exit(20);
  }
  /*  Initialize the libraries                  */
  OpenLibs();
  /*  Initialize the random number generator    */
  InitRandom();
  /*  Initialize the tournament data            */
  DeleteTournament(NULL);
  /*  Process the arguments                     */
  DoStartup(argc, argv);

  InitMainWnd();
  ProcessMainWnd();
}



/*
    wbmain() gets called from DICE startup code when running from the
    Workbench. We do nothing special except calling main() to be Aztec
    compatible.
*/
#ifdef _DCC
void wbmain(void *wbmsg)

{ main(0, (char **) wbmsg);
}
#endif  /*  _DCC    */



#ifdef DEBUG
#undef strlen
size_t dbg_strlen(const char *ptr)
{ if (ptr == NULL)
  { printf("strlen: NULL pointer!\n");
  }
  return(strlen(ptr));
}

#undef strcpy
char *dbg_strcpy(char *dest, const char *src)
{ if (src == NULL  ||  dest == NULL)
  { printf("strcpy: NULL pointer!\n");
  }
  return(strcpy (dest, src));
}

#undef printf
int dbg_printf(const char *fmt, ...)
{ char **args = &fmt;

  if (fmt == NULL)
  { printf("printf: NULL pointer!\n");
  }
  return(printf(fmt, args[1], args[2], args[3], args[4], args[5], args [6],
         args[7], args[8], args[9], args[10], args[11], args[12], args[13],
         args[14], args[15], args[16], args[17], args[18], args[19],
         args[20]));
}

#undef sprintf
int dbg_sprintf(char *dest, const char *fmt, ...)
{ char **args = &fmt;

  if (dest == NULL  ||  fmt == NULL)
  { printf("sprintf: NULL pointer!\n");
  }
  return(sprintf(dest, fmt, args[1], args[2], args[3], args[4], args[5],
         args [6], args[7], args[8], args[9], args[10], args[11], args[12],
         args[13], args[14], args[15], args[16], args[17], args[18],
         args[19], args[20]));
}

#undef fprintf
int dbg_fprintf(FILE *fh, const char *fmt, ...)
{ char **args = &fmt;

  if (fh == NULL  ||  fmt == NULL)
  { printf("fprintf: NULL pointer!\n");
  }
  return(fprintf(fh, fmt, args[1], args[2], args[3], args[4], args[5],
         args [6], args[7], args[8], args[9], args[10], args[11], args[12],
         args[13], args[14], args[15], args[16], args[17], args[18],
         args[19], args[20]));
}
#endif
