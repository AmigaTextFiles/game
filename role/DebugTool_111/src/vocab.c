#include "frobnitz.h"

/*******************************************************************/
/*  Funktion: PrintVocab                                           */
/*******************************************************************/

void
PrintVocab (void)
{
  short int i, j, k;
  int voc_length, number_words, word_bytes, word_letters;
  byte interpunct_chars;
  unsigned char buffer[15];
  int twobytes;
  byte is_end;

  printf ("DICTIONARY:\n\n");

  if (is_savefile)
    {
      error (8);
      return;
    }

  seek_pos (header.vocab_offset);

#ifdef DEBUG
  printf ("<DI-BEG:$%04x>\n", ftell (DatFile));
#endif

  printf ("%d interpunction chars:\n", (interpunct_chars = fgetc (DatFile)));
  for (i = 0; i < interpunct_chars; i++)
    {
      if (!no_enum)
	if (dec_enum)
	  printf ("%4d :  ", i + 1);
	else
	  printf ("$%3x :  ", i + 1);
      printf ("%c\n", fgetc (DatFile));
    }

  switch (voc_length = fgetc (DatFile))
    {
    case 7:			/* v3 games */
      word_bytes = 4;
      break;
    case 8:			/* Sherlock */
    case 9:			/* v4-6 games */
    case 10:			/* Arthur, Shogun */
      word_bytes = 6;
      break;
    default:
      quit (3);
    }

  EncodedString[0] = (word_letters = (word_bytes / 2) * 3);

  number_words = (256 * fgetc (DatFile)) + fgetc (DatFile);

  printf ("%d words (length %d, %d flag bytes):", number_words, word_bytes, (voc_length - word_bytes));
  newline ();

  for (i = 0; i < number_words; i++)
    {
      fread (buffer, 1, voc_length, DatFile);

      for (j = 0; j < word_bytes; j = j + 2)
	{
	  k = ((j / 2) * 3) + 1;

	  twobytes = (256 * buffer[j]) + buffer[j + 1];
	  is_end = (twobytes > 0x7fff);

	  EncodedString[k] = (twobytes & 0x7c00) / 0x400;
	  EncodedString[k + 1] = (twobytes & 0x3e0) / 0x20;
	  EncodedString[k + 2] = (twobytes & 0x1f);
	}
      EncodedString[word_letters + 1] = '\0';

      if (!no_enum)
	{
	  if (dec_enum)
	    printf ("%4d :  ", i + 1);
	  else
	    printf ("$%3x :  ", i + 1);
	}
      if (!(is_end))
	printf ("[");

      StringDecode ();

      printf ("%s", DecodedString);

      if (!(is_end))
	printf ("]");

      if (!no_attr)
	{
	  if ((word_letters == 9) && (PrintedChars < 8))
	    printf ("\t");

	  printf ("\t- ");

	  for (j = word_bytes; j < voc_length; j++)
	    printf ("%02x ", buffer[j]);
	}
      newline ();
    }

#ifdef DEBUG
  printf ("<DI-END:$%04x>\n", ftell (DatFile));
#endif
}
