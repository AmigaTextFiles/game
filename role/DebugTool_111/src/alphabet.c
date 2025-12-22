#include "frobnitz.h"

const char default_alphabet[3][26] =
{
  {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  },
  {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  },
  {
    '\0' /* ASCII literal */ , '\n',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '.', ',', '!', '?', '_', '#', '\'', '\"', '/', '\\', '-', ':', '(', ')'
  }
};

/*******************************************************************/
/*  Funktion: ReadAlphabet                                         */
/*******************************************************************/

void
ReadAlphabet (void)
{
  short int table, elem;

  if (header.alfabet_offset)
    {
      seek_pos (header.alfabet_offset);
      fread (alphabet, 1, 3 * 26, DatFile);
      alphabet[2][0] = '\0';
      alphabet[2][1] = '\n';
    }
  else
    {
      for (table = 0; table < 3; table++)
	for (elem = 0; elem < 26; elem++)
	  alphabet[table][elem] = default_alphabet[table][elem];
    }
  alph_read = 1;
}

/*******************************************************************/
/*  Funktion: PrintAlphabet                                        */
/*******************************************************************/

void
PrintAlphabet (void)
{
  short int table, elem;
  char c;

  printf ("ALPHABET:\n\n");

  printf ("\tA1\tA2\tA3\n");
  printf ("\
0\t[Space]\t[Space]\t[Space]\n\
1\t[M1->]\t[M1->]\t[M1->]\n\
2\t[M2->]\t[M2->]\t[M2->]\n\
3\t[M3->]\t[M3->]\t[M3->]\n\
4\t[A2->]\t[A2->]\t[A1->]\n\
5\t[A3->]\t[A1->]\t[A3->]\n\
");

  for (elem = 0; elem < 26; elem++)
    {
      printf ("%d\t", elem + 6);
      for (table = 0; table < 3; table++)
	{
	  c = alphabet[table][elem];
	  switch (c)
	    {
	    case '\0':
	      printf ("[ASCII->->]\t");
	      break;
	    case '\n':
	      printf ("[Return]\t");
	      break;
	    case 11:
	      printf ("[VTab]\t");
	      break;
	    case '\t':
	      printf ("[HTab]\t");
	      break;
	    case ' ':
	      printf ("[Space]\t");
	      break;
	    default:
	      printf ("%c\t", c);
	    }
	}
      newline ();
    }
  printf ("(Type: %s)\n", (header.alfabet_offset ? "special" : "default"));
}
