#include "frobnitz.h"

/*******************************************************************/
/*  Funktion: PerformCheck                                         */
/*******************************************************************/

void
PerformCheck (void)
{
  unsigned long check_length, file_length, count;
  unsigned short summa = 0;

  printf ("FILE CHECK:\n\n");

  if (is_savefile)
    {
      error (8);
    }
  else if (!header.verify_length)
    {
      error (9);
    }
  else
    {
      fseek (DatFile, (unsigned long) 0, SEEK_END);
      file_length = ftell (DatFile);

      check_length = header.verify_length * 2 * (header.z_version > 3 ? 2 : 1) * (header.z_version > 5 ? 2 : 1);

      if (check_length > file_length)
	{
	  error (1);
	}
      else
	{
	  printf ("Game length: %d\n", check_length);
	  printf ("Padding:     %d  ", file_length - check_length);

	  if (((file_length / 512) * 512) == file_length)
	    printf ("(to page size%s)", (((file_length - check_length) > 255) ? " 512" : "s 256/512"));
	  else if (((file_length / 256) * 256) == file_length)
	    printf ("(to page size 256)");
	  else if (file_length == check_length)
	    printf ("(none)");
	  else
	    printf ("(accidentally?)");

	  printf ("\n\n$Verify:     ");

	  seek_pos ((z_word) 0x40);
	  for (count = 0x40; count < check_length; count++)
	    {
	      summa = summa + fgetc (DatFile);
	    }

	  printf ("%s\n", (summa == header.verify_checksum) ? "Game correct" : "*** Failed ***");
	}
    }
}
