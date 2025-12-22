#include "frobnitz.h"

/*******************************************************************/
/*  Funktion: ReadHeader                                           */
/*******************************************************************/

void
ReadHeader (void)
{
  seek_pos ((z_word) 0);

  if (fread (&header, sizeof (header), 1, DatFile) < 1)
    {
      quit (1);
    }

#ifndef AMIGA
  SwapHeader ();
#endif

  old_header = ((header.z_version == 3) ? 1 : 0);
}

/*******************************************************************/
/*  Funktion: PrintHeader                                          */
/*******************************************************************/

void
PrintHeader (void)
{
  int i;
  byte no_ver;

  static char *version_name[] =
  {
    "unknown version",
    "ZIP [very old]",
    "ZIP [old]",
    "ZIP",
    "EZIP",
    "XZIP",
    "YZIP"
  };

  static char *flag = ";flag ";

  static char *zip_flags_V3_notset[] =
  {
    "byte normal",
    ";SCORE display",
    "",
    "",
    "",
    "",
    "",
    ""
  };

  static char *zip_flags_V3_set[] =
  {
    "byte swapped",
    ";TIME display",
    "",
    ";Tandy",
    ";no status line",
    ";status windows",
    ";prop_fonts",
    ""
  };

  static char *zip_flags_V4_notset[] =
  {
    "no colours",
    "",
    "",
    ";no underline",
    "",
    "",
    "",
    ""
  };

  static char *zip_flags_V4_set[] =
  {
    "colours",
    "",
    ";max data area",
    ";underline",
    "",
    "",
    "",
    ""
  };

  static char *game_flags_V3_notset[] =
  {
    "script OFF",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  };

  static char *game_flags_V3_set[] =
  {
    "script ON",
    ";fixed font",
    ";refresh",
    "",
    ";sound",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  };

  static char *game_flags_V4_notset[] =
  {
    "script OFF",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  };

  static char *game_flags_V4_set[] =
  {
    "script ON",
    ";fixed font",
    ";refresh",
    ";graphics",
    ";undo",
    ";mouse",
    ";colour",
    ";sound",
    ";no command line",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  };

  static char *interpreters[] =
  {
    "Unknown",
    "DEC-20 / Debugging",
    "Apple IIe",
    "Macintosh",
    "Amiga",
    "Atari ST",
    "IBM",
    "Commodore 128",
    "Commodore 64",
    "Apple IIc",
    "Apple IIgs",
    "Tandy Color Computer"
  };

  printf ("DATA FILE HEADER:\n\n");

  printf ("Z-code version:  %d ", header.z_version);
  printf ("(%s)\n", ((header.z_version > 6) ? version_name[0] : version_name[header.z_version]));

  printf ("ZIP Flags:       $%x (", header.zip_flags);

  for (i = 0; i < 8; i++)
    {
      if (!(header.zip_flags & power (2, i)))
	printf ("%s", ((old_header) ? zip_flags_V3_notset[i] : zip_flags_V4_notset[i]));
      else
	{
	  if (old_header)
	    {
	      if (strlen (zip_flags_V3_set[i]))
		printf ("%s", zip_flags_V3_set[i]);
	      else
		printf ("%s%d", flag, i);
	    }
	  else
	    {
	      if (strlen (zip_flags_V4_set[i]))
		printf ("%s", zip_flags_V4_set[i]);
	      else
		printf ("%s%d", flag, i);
	    }
	}
    }
  printf (")\n");

  printf ("Release number:  %d\n", (header.release & 0x7ff));
  printf ("Resident size:   $%x\n", header.resident_size);
  printf ("Game offset:     $%x\n", header.game_offset);
  printf ("Vocab offset:    $%x\n", header.vocab_offset);
  printf ("Object offset:   $%x\n", header.object_offset);
  printf ("GlobVar offset:  $%x\n", header.variable_offset);
  printf ("Save area size:  $%x\n", header.save_area_size);

  printf ("Game flags:      $%x (", header.game_flags);
  for (i = 0; i < 16; i++)
    {
      if (!(header.game_flags & power (2, i)))
	printf ("%s", ((old_header) ? game_flags_V3_notset[i] : game_flags_V4_notset[i]));
      else
	{
	  if (old_header)
	    {
	      if (strlen (game_flags_V3_set[i]))
		printf ("%s", game_flags_V3_set[i]);
	      else
		printf ("%s%d", flag, i);
	    }
	  else
	    {
	      if (strlen (game_flags_V4_set[i]))
		printf ("%s", game_flags_V4_set[i]);
	      else
		printf ("%s%d", flag, i);
	    }
	}
    }
  printf (")\n");

  printf ("Serial number:   ");
  i = 0;
  while (i < 6)
    {
      printf ("%c", header.rev_date[i]);
      i++;
    }
  printf ("%s", ((header.rev_date[0] == 0x38) ? "" : " (no official release)"));
  newline ();

  printf ("Macro offset:    $%x\n", header.macro_offset);

  printf ("$Verify length:  $%x", header.verify_length);
  no_ver = ((header.verify_length == 0) ? 1 : 0);
  if (no_ver)
    printf (" (no officially released datafile)");
  newline ();

  if (no_ver == 0)
    printf ("$Verify chksm:   $%x\n", header.verify_checksum);

  if (header.zmach_version != 0)
    {
      printf ("Interpreter:     %s", ((header.zmach_version > 11) ? interpreters[0] : interpreters[header.zmach_version]));
      printf (" (%d) version ", header.zmach_version);
      if ((islower (header.zmach_subversion))
	  ||
	  (isupper (header.zmach_subversion)))
	printf ("%c", header.zmach_subversion);
      else
	printf ("%d", header.zmach_subversion);
      newline ();
    }

  if (header.screen_rows != 0)
    {
      printf ("Screen:          %d rows x %d columns", header.screen_rows, header.screen_columns);
      newline ();
      printf ("                 (left: %d; right: %d; top: %d; bottom: %d)", header.screen_left, header.screen_right, header.screen_top, header.screen_bottom);
      newline ();
    }

  if (header.max_char_width != 0)
    {
      printf ("Max Charsize:    %d wide x %d high", header.max_char_width, header.max_char_height);
      newline ();
    }

  if (header.unknown0 != 0)
    printf ("Unknown 0:       $%x\n", header.unknown0);

  if (header.unknown1 != 0)
    printf ("Unknown 1:       $%x\n", header.unknown1);

  if (header.unknown2 != 0)
    printf ("Unknown 2:       $%x\n", header.unknown2);

  if (header.fkey_offset != 0)
    printf ("FKey offset:     $%x\n", header.fkey_offset);

  if (header.unknown4 != 0)
    printf ("Unknown 4:       $%x\n", header.unknown4);

  if (header.unknown5 != 0)
    printf ("Unknown 5:       $%x\n", header.unknown5);

  if (header.alfabet_offset != 0)
    printf ("Alphabet offset: $%x\n", header.alfabet_offset);

  if (header.mouse_offset != 0)
    printf ("Mouse offset:    $%x\n", header.mouse_offset);

  if (header.user_name[0] != 0)
    {
      printf ("User Name:       ");
      i = 0;
      while ((header.user_name[i] != 0) && (i < 8))
	{
	  printf ("%c", header.user_name[i]);
	  i++;
	}
      newline ();
    }
}

/*******************************************************************/
/*  Funktion: HeaderLevel                                          */
/*******************************************************************/

void
HeaderLevel (void)
{
  int c = 0;
  int i, j;
  int file_ok = 0;

  header_level = 0;

  for (i = 0; i < 5; i++)
    {
      if (fseek (DatFile, (i * 512), SEEK_SET))
	quit (1);
      c = getc (DatFile);

      if ((c > 2) && (c < 7))
	{
	  header_level = i;
	  file_ok = 1;
	  for (j = 0; j < 17; j++)
	    {
	      c = getc (DatFile);
	    }
	  for (j = 0; j < 6; j++)
	    {
	      if (!(isprint (c = getc (DatFile))))
		file_ok = 0;
	    }
	}
      if (file_ok)
	break;
    }

/*
 *  Known header levels:
 *	(a) Datafiles:	0
 *	(b) Savefiles:	0 - InfoTaskForce
 *			1 - Amiga & Atari ZMachine 3; Pfaller/Barthel
 *			2 - Amiga ZMachine 4/5/6; Atari ZMachine 4/5;
 *			    IBM ZMachine 3/4; Mark Howell's ZIP
 *			4 - IBM ZMachine 5/6
 */

  if (!file_ok)
    quit (2);
}

/*******************************************************************/
/*  Funktion: IsSavefile                                           */
/*******************************************************************/

void
IsSavefile (void)
{
  is_savefile = ((header_level) ? 1 :
		 ((fseek (DatFile, (unsigned long) (header.vocab_offset + (header_level) * 512), SEEK_SET)) ? 1 : 0));
}

/*******************************************************************/
/*  Funktion: SwapHeader                                           */
/*******************************************************************/

void
SwapHeader (void)
{
  header.release = byteswap (header.release);
  header.resident_size = byteswap (header.resident_size);
  header.game_offset = byteswap (header.game_offset);
  header.vocab_offset = byteswap (header.vocab_offset);
  header.object_offset = byteswap (header.object_offset);
  header.variable_offset = byteswap (header.variable_offset);
  header.save_area_size = byteswap (header.save_area_size);
  header.game_flags = byteswap (header.game_flags);
  header.macro_offset = byteswap (header.macro_offset);
  header.verify_length = byteswap (header.verify_length);
  header.verify_checksum = byteswap (header.verify_checksum);
}
