#include "frobnitz.h"

void
main (argc, argv)
     int argc;
     char **argv;
{
  int i = 1;

  if ((argc < 3))
    {
      if (argc == 1)
	helptxt ();
      else
	printf ("Usage: %s [-<options>] -<modifiers> <file>", argv[0]);
      newline ();
      exit (0);
    }

  strcpy (FilStr, argv[argc - 1]);

  DatFile = fopen (FilStr, "rb");

  if (DatFile == NULL)
    {
      fprintf (stderr, "Error: %s not found", argv[argc - 1]);
      quit (0);
    }

  HeaderLevel ();
  ReadHeader ();
  IsSavefile ();

  no_enum = no_attr = dec_enum = no_props = 0;
  game_print = header_print = alphabet_print = var_print = vocab_print = do_check = 0;
  alph_read = macros_read = objects_read = 0;

  while (i < (argc - 1))
    {
      parse (argv[i]);
      i++;
    }

  if (game_print == 1)
    {
      PrintGame (WhichGame ());
      newline ();
    }

  if (header_print == 1)
    {
      PrintHeader ();
      newline ();
    }

  if (alphabet_print == 1)
    {
      if (!(alph_read))
	ReadAlphabet ();
      PrintAlphabet ();
      newline ();
    }

  if (macros_print == 1)
    {
      if (!(alph_read))
	ReadAlphabet ();
      if (!(macros_read))
	ReadMacros ();
      PrintMacros ();
      newline ();
    }

  if (object_print == 1)
    {
      if (!(alph_read))
	ReadAlphabet ();
      if (!(macros_read))
	ReadMacros ();
      PrintObjects ();
      newline ();
    }

  if (tree_print == 1)
    {
      if (!(alph_read))
	ReadAlphabet ();
      if (!(macros_read))
	ReadMacros ();
      PrintTree ();
      newline ();
    }

  if (var_print == 1)
    {
      if (old_header)
	{
	  if (!(alph_read))
	    ReadAlphabet ();
	  if (!(macros_read))
	    ReadMacros ();
	}
      PrintVars ();
      newline ();
    }

  if (vocab_print == 1)
    {
      if (!(alph_read))
	ReadAlphabet ();
      PrintVocab ();
      newline ();
    }

  if (do_check == 1)
    {
      PerformCheck ();
      newline ();
    }

  fclose (DatFile);
  exit (0);

  printf (VERSTAG);		/*  will be NEVER reached ... thank god */

}				/*  End of MAIN  */
