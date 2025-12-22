#include "frobnitz.h"

/*******************************************************************/
/* Funktion: ReadMacros                                           */
/*******************************************************************/

void
ReadMacros ()
{
  short int i, j;
  z_word macro_pos[3 * 32];
  long int twobytes;
  byte count, is_end;

  seek_pos (header.macro_offset);

#ifdef DEBUG
  printf ("<MAC-T-BEG:$%04x>\n", ftell (DatFile));
#endif

  for (i = 0; i < 3; i++)
    {
      for (j = 0; j < 32; j++)
	{
	  macro_pos[i * 32 + j] = 2 * ((fgetc (DatFile) * 256) + fgetc (DatFile));
	}
    }

#ifdef DEBUG
  printf ("<MAC-T-END:$%04x>\n", ftell (DatFile));
#endif

  for (i = 0; i < 3; i++)
    {
      for (j = 0; j < 32; j++)
	{
	  seek_pos (macro_pos[i * 32 + j]);

#ifdef DEBUG
	  if ((i == j) && (j == 0))
	    printf ("<MAC-S-BEG:$%04x>\n", ftell (DatFile));
#endif

	  count = 1;
	  is_end = 0;

	  while (!(is_end))
	    {
	      twobytes = (256 * fgetc (DatFile) + fgetc (DatFile));
	      is_end = (twobytes > 0x7fff);

	      EncodedString[count] = (twobytes & 0x7c00) / 0x400;
	      EncodedString[count + 1] = (twobytes & 0x3e0) / 0x20;
	      EncodedString[count + 2] = (twobytes & 0x1f);

	      count = count + 3;
	    }
	  EncodedString[0] = (count - 1);
	  EncodedString[count] = '\0';

	  StringDecode ();

	  if (PrintedChars > (MAXLEN_MACRO - 1))
	    quit (4);

	  strcpy (macros[i * 32 + j], DecodedString);
	}
    }

#ifdef DEBUG
  printf ("<MAC-S-END:$%04x>\n", ftell (DatFile));
#endif

  macros_read = 1;
}


/*******************************************************************/
/* Funktion: PrintMacros                                           */
/*******************************************************************/

void
PrintMacros (void)
{
  int i, j;

  printf ("MACROS:\n\n");

  printf ("\tM1\t\tM2\t\tM3\n");

  for (i = 0; i < 32; i++)
    {
      printf ("%d\t", i);
      for (j = 0; j < 3; j++)
	{
	  printf ("[");
	  PrintMacro (j, i);
	  printf ("%s", MacroString);
	  printf ("]\t");
	  if (MacroLength (j, i) < 6)
	    printf ("\t");
	}
      newline ();
    }
}


/*******************************************************************/
/* Funktion: PrintMacro                                            */
/*******************************************************************/

/* i = 0..2 - j = 0...31  */

void
PrintMacro (int i, int j)
{
  strcpy (MacroString, macros[i * 32 + j]);
}


/*******************************************************************/
/* Funktion: MacroLength                                           */
/*******************************************************************/

/* i = 0..2 - j = 0...31  */

int
MacroLength (int i, int j)
{
  return (strlen (macros[i * 32 + j]));
}
