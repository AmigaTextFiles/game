#include "frobnitz.h"

/*******************************************************************/
/*  Funktion: PrintVars                                            */
/*******************************************************************/

void
PrintVars (void)
{
  unsigned short int i;
  unsigned short int variable[256];
  unsigned short int max_glob, beg, end;
  byte temp, try_it = 0;

  max_glob = ((header.variable_offset < header.object_offset) ? (header.object_offset - header.variable_offset) : (header.save_area_size - header.variable_offset));
  max_glob /= 2;

  printf ("GLOBAL VARIABLES:\n\n");

  printf ("Number of globals: ");

  if (max_glob > 240)
    {
      try_it = 1;
      max_glob = 240;
    }
  else
    printf ("%d", max_glob);

  seek_pos (header.variable_offset);

  beg = ftell (DatFile) - header_level * 512;

  for (i = 16; i <= (max_glob + 15); i++)
    {
      variable[i] = fgetc (DatFile) * 0x100 + fgetc (DatFile);
    }

  end = ftell (DatFile) - header_level * 512;

  if (try_it == 1)
    {
      for (i = 16; i <= (max_glob + 15); i++)
	{
	  if ((variable[i] > beg) && (variable[i] < beg + (max_glob * 2)))
	    {
	      max_glob = (variable[i] - beg) / 2;
	    }
	}
      printf ("%d", max_glob);
    }

  newline ();

#ifdef DEBUG
  printf ("<V-BEG:$%04x>\n", beg);
#endif

#ifdef DEBUG
  printf ("<V-END:$%04x>\n", beg + (max_glob * 2));
#endif

  for (i = 16; i <= (max_glob + 15); i++)
    {
      if (dec_enum)
	printf ("%4d :  %5d", i - 16, variable[i]);
      else
	printf ("$%3x :  $%4x", i - 16, variable[i]);

      if (header.z_version == 3)
	{
	  if (i == 16)
	    {
	      printf (" [Location:");

	      if (variable[i] == 0)
		printf ("<none>");
	      else
		{
		  temp = no_enum;
		  no_enum = 1;
		  PrintObject ((int) (variable[i] - 1));
		  no_enum = temp;
		}

	      printf ("]");
	    }
	  if (i == 17)
	    printf (" [Score/Hours]");
	  if (i == 18)
	    printf (" [Moves/Minutes]");
	}

      newline ();
    }
}
