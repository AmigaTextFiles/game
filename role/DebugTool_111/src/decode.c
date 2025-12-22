#include "frobnitz.h"

byte alph[4];
byte macro[4];
byte ascii_tab;

/*******************************************************************/
/*  Funktion: StringDecode                                         */
/*******************************************************************/

void
StringDecode (void)
{
  short int i;
  int m;

  DecodeReset ();
  alph[1] = 1;
  PrintedChars = 0;

  for (i = 1; i <= EncodedString[0]; i++)
    {
      if (i > (MAXLEN_ENCSTR - 1))
	quit (6);

      m = EncodedString[i];
      if (ascii_tab)
	{
	  i++;
	  m = 32 * (m & 0x07) + (EncodedString[i] & 0x1f);
	}
      ExChar (m);
    }

  DecodedString[PrintedChars] = '\0';

  if (PrintedChars > (MAXLEN_DECSTR - 1))
    quit (7);
}

/*******************************************************************/
/*  Funktion: ExChar                                               */
/*******************************************************************/

int
ExChar (int m)
{
  int i;
/* ACHTUNG : Macros zuerst ! */

  for (i = 1; i < 4; i++)
    {
      if (macro[i])
	{
	  DecodeReset ();
	  alph[1] = 1;
	  PrintMacro ((i - 1), m);
	  DecodedString[PrintedChars] = '\0';
	  strcat (DecodedString, MacroString);
	  PrintedChars = strlen (DecodedString);
	  return m;
	}
    }

  if (m == 0)
    {
      DecodedString[PrintedChars] = ' ';
      PrintedChars++;
      return m;
    }

  for (i = 1; i < 4; i++)
    {
      if (m == i)
	{
	  DecodeReset ();
	  macro[i] = 1;
	  return m;
	}
    }

  if (m == 4)
    {
      for (i = 1; i < 4; i++)
	{
	  if (alph[i])
	    {
	      DecodeReset ();
	      alph[2 - (i == 3)] = 1;
	      return m;
	    }
	}
    }

  if (m == 5)
    {
      for (i = 1; i < 4; i++)
	{
	  if (alph[i])
	    {
	      DecodeReset ();
	      alph[3 - 2 * (i == 2)] = 1;
	      return m;
	    }
	}
    }

  if (m > 5)
    {
      for (i = 1; i < 4; i++)
	{
	  if (alph[i])
	    {
	      DecodeReset ();
	      if ((i == 3) && (m == 6))
		ascii_tab = 1;
	      else
		{
		  DecodedString[PrintedChars] = alphabet[i - 1][m - 6];
		  PrintedChars++;
		  alph[1] = 1;
		}
	      return m;
	    }
	}
    }				/* m> 5 */

  if (ascii_tab)
    {
      DecodedString[PrintedChars] = m;
      PrintedChars++;
      DecodeReset ();
      alph[1] = 1;
      return m;
    }

  printf ("ERR");
  return m;
}


/*******************************************************************/
/*  Funktion: DecodeReset                                          */
/*******************************************************************/

void
DecodeReset (void)
{
  alph[1] = alph[2] = alph[3] = macro[1] = macro[2] = macro[3] = ascii_tab = 0;
}
