#include "frobnitz.h"

/*******************************************************************/
/*  Funktion: seek_pos                                             */
/*******************************************************************/

void
seek_pos (z_word pos)
{
  if (fseek (DatFile, ((unsigned long) (pos + (header_level) * 512)), SEEK_SET) != 0)
    quit (1);
}

/*******************************************************************/
/*  Funktion: newline                                              */
/*******************************************************************/

void
newline (void)
{
  printf ("\n");
}

/*******************************************************************/
/*  Funktion: power  --- thanx to K&R :-)                          */
/*******************************************************************/

int
power (int base, int n)
{
  int p;

  for (p = 1; n > 0; --n)
    p = p * base;
  return p;
}

/*******************************************************************/
/*  Funktion: parse                                                */
/*******************************************************************/

void
parse (char *parm)
{
  switch (*parm)
    {
      case '/':
      parse_opt (*++parm);
      break;
    case '-':
      while (*++parm)
	parse_opt (*parm);
      break;
    default:
      fprintf (stderr, "Unknown parameter: %s\n", parm);
      break;
    }
}

/*******************************************************************/
/*  Funktion: parse_opt                                            */
/*******************************************************************/

void
parse_opt (char p)
{
  switch (p)
    {
      case '0':
      no_enum = 1;
      break;
    case '1':
      no_attr = 1;
      break;
    case '2':
      dec_enum = 1;
      break;
    case '3':
      no_props = 1;
      break;
    case 'h':
      header_print = 1;
      break;
    case 'g':
      game_print = 1;
      break;
    case 'a':
      alphabet_print = 1;
      break;
    case 'm':
      macros_print = 1;
      break;
    case 'o':
      object_print = 1;
      break;
    case 't':
      tree_print = 1;
      break;
    case 'd':
      vocab_print = 1;
      break;
    case 'v':
      var_print = 1;
      break;
    case 'c':
      do_check = 1;
      break;
    default:
      fprintf (stderr, "Unknown option: %c\n", p);
      break;
    }
}

/*******************************************************************/
/*  Funktion: quit                                                 */
/*******************************************************************/

void
quit (int i)
{
  error (i);

  fclose (DatFile);
  exit (0);
}

/*******************************************************************/
/*  Funktion: error                                                */
/*******************************************************************/

void
error (int i)
{
  static char *errtype[] =
  {
    "",
    "File too short",
    "Not an Infocom file",
    "Unknown vocabulary type",
    "Macro too long",
    "Object too long",
    "EncStr too long",
    "DecStr too long",
    "Can't perform that on a savefile",
    "No verify info in header"
  };

  fprintf (stderr, "%s%s\n", (i ? "Error: " : ""), errtype[i]);
}

/*******************************************************************/
/*  Funktion: helptxt                                              */
/*******************************************************************/

void
helptxt (void)
{
  printf (STAMP);
  printf (" - Copyright (c) 1992 Paul David Doherty\n");
  printf ("All rights reserved. Not for commercial use.\n\n");
  printf ("\
Usage: DebugTool [-<options>] -<modifiers> <file>\n\
\n\
                        Where <options> is one of:\n\
\n\
  -g  Display game name                -h  Display game header\n\
  -a  Print alphabet                   -m  Print macros\n\
  -o  Print object list                -t  Print object tree\n\
  -v  Print variables                  -d  Print dictionary\n\
  -c  Check file\n\
\n\
                        And <modifiers> is one of:\n\
\n\
  -0  Suppress enumeration             -1  Suppress attributes\n\
  -2  Decimal enumeration              -3  Suppress properties");
}

/*******************************************************************/
/*  Funktion: byteswap  --- thanks to MA Howell                    */
/*******************************************************************/

z_word
byteswap (z_word word)
{
/* for big-endian machines */
#ifdef AMIGA
  return (word);

/* for little-endian machines */
#else
  return (((word << 8) & 0xff00) | ((word >> 8) & 0xff));

#endif
}
