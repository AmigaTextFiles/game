#include "frobnitz.h"

int entry_length;

/*******************************************************************/
/*  Funktion: ReadObjects                                          */
/*******************************************************************/

void
ReadObjects (void)
{
  unsigned long present_count, min_data, address;
  z_word start_objs;

  present_count = start_objs = header.object_offset + (old_header ? NUM_PROPS_OLD : NUM_PROPS_NEW) * 2;

  entry_length = ((old_header) ? 9 : 14);

  seek_pos (start_objs);

#ifdef DEBUG
  printf ("<RO-BEG:$%04x>\n", ftell (DatFile));
#endif

  min_data = 0xffff;
  objects_count = 0;

  while (present_count < min_data)
    {
      fread (object_table[objects_count], 1, entry_length, DatFile);

      address = (object_table[objects_count][entry_length - 2] * 256) + object_table[objects_count][entry_length - 1];

      if (address < min_data)
	min_data = address;

      present_count = present_count + entry_length;
      objects_count++;
    }

#ifdef DEBUG
  printf ("<RO-END:$%04x>\n", ftell (DatFile));
#endif

  objects_read = 1;
}

/*******************************************************************/
/*  Funktion: PrintObjects                                         */
/*******************************************************************/

void
PrintObjects (void)
{
  int i, j, k;
  byte first;

  printf ("OBJECTS:\n\n");

  if (!objects_read)
    ReadObjects ();

  if (!no_props)
    PrintDefProperties ();

  printf ("%d objects:\n", objects_count);

  for (i = 0; i < objects_count; i++)
    {
      PrintObject (i);

      newline ();

      if (!no_attr)
	{
	  printf ("\tParent: ");
	  if (dec_enum)
	    printf ("%d", ((old_header) ? object_table[i][4] : ((object_table[i][6] * 256) + object_table[i][7])));
	  else
	    printf ("$%3x", ((old_header) ? object_table[i][4] : ((object_table[i][6] * 256) + object_table[i][7])));

	  printf ("   Sibling: ");
	  if (dec_enum)
	    printf ("%d", ((old_header) ? object_table[i][5] : ((object_table[i][8] * 256) + object_table[i][9])));
	  else
	    printf ("$%3x", ((old_header) ? object_table[i][5] : ((object_table[i][8] * 256) + object_table[i][9])));

	  printf ("   Child: ");
	  if (dec_enum)
	    printf ("%d", ((old_header) ? object_table[i][6] : ((object_table[i][10] * 256) + object_table[i][11])));
	  else
	    printf ("$%3x", ((old_header) ? object_table[i][6] : ((object_table[i][10] * 256) + object_table[i][11])));

	  newline ();

	  printf ("\tAttribs: ");
	  first = 1;
	  for (j = 0; j < ((old_header) ? 4 : 6); j++)
	    {
	      for (k = 7; k >= 0; k--)
		{
		  if ((object_table[i][j] >> k) & 1)
		    {
		      printf ("%c%d", (first ? '(' : ','), ((7 - k) + (j * 8)));
		      first = 0;
		    }
		}
	    }
	  printf ("%s", (first ? "" : ")"));
	  newline ();
	}

      if (!no_props)
	PrintProperties (i);

      if ((!no_attr) || (!no_props))
	newline ();
    }
}

/*****************************************************************/
/*     FUNKTION: PrintObject                                     */
/*****************************************************************/

void
PrintObject (int l)
{
  int name_length;
  z_word pos;
  long int twobytes;
  byte is_end;
  int j, k;
  unsigned char buffer[MAXLEN_OBJECT * 2];

  if (!objects_read)
    ReadObjects ();

  pos = (object_table[l][entry_length - 2] * 256) + object_table[l][entry_length - 1];

  seek_pos (pos);

  name_length = fgetc (DatFile);
  if (name_length > (MAXLEN_OBJECT - 1))
    quit (5);
  fread (buffer, 1, (name_length * 2), DatFile);

  for (j = 0; j < (name_length * 2); j = j + 2)
    {
      is_end = ((twobytes = (256 * buffer[j]) + buffer[j + 1]) > 0x7fff);

      k = ((j / 2) * 3) + 1;

      EncodedString[k] = (twobytes & 0x7c00) / 0x400;
      EncodedString[k + 1] = (twobytes & 0x3e0) / 0x20;
      EncodedString[k + 2] = (twobytes & 0x1f);
    }

  EncodedString[0] = ((name_length) ? (k + 2) : 0);
  EncodedString[k + 3] = '\0';

  if (!no_enum)
    if (dec_enum)
      printf ("%4d : %s", l + 1, (((is_end) && (name_length)) ? "" : "[]"));
    else
      printf ("$%3x : %s", l + 1, (((is_end) && (name_length)) ? "" : "[]"));
  else
    printf ("%s", (((is_end) && (name_length)) ? "" : "[]"));

  StringDecode ();

  printf ("%s", DecodedString);
}


/*****************************************************************/
/*     FUNKTION: PrintDefProperties                              */
/*****************************************************************/

void
PrintDefProperties (void)
{
  unsigned short int i;
  z_word pos;

  if (!objects_read)
    ReadObjects ();
  printf ("%d properties:\n", (old_header ? NUM_PROPS_OLD : NUM_PROPS_NEW));

  pos = header.object_offset;

  seek_pos (pos);

#ifdef DEBUG
  printf ("<PRD-BEG:$%04x>\n", ftell (DatFile));
#endif

  for (i = 1; i <= (old_header ? NUM_PROPS_OLD : NUM_PROPS_NEW); i++)
    {
      printf ("[%2d]  %02x", i, fgetc (DatFile));
      printf (" %02x\n", fgetc (DatFile));
    }

#ifdef DEBUG
  printf ("<PRD-END:$%04x>\n", ftell (DatFile));
#endif

  newline ();
}


/*****************************************************************/
/*     FUNKTION: PrintProperties                                 */
/*****************************************************************/

void
PrintProperties (int l)
{
  unsigned short int jump, index, size, id;
  z_word pos;
  unsigned short int i;
  unsigned short int ind_block_num, size1, index2, ignored2, ignored3,
   size2;
#ifdef DEBUG
  z_word next;
  unsigned short int j;
#endif

  if (!objects_read)
    ReadObjects ();

  pos = (object_table[l][entry_length - 2] * 256) + object_table[l][entry_length - 1];

  seek_pos (pos);

#ifdef DEBUG
  printf ("<PR-BEG:$%04x>\n", ftell (DatFile));
#endif

  printf ("\tProps:  ");

  jump = fgetc (DatFile) * 2;
  for (i = 0; i < jump; i++)
    fgetc (DatFile);

  index = fgetc (DatFile);

  if (index == 0)
    newline ();

  if (old_header)
    {
      while (index != 0)
	{
	  size = (index >> 5) + 1;
	  id = (index & 0x1f);

	  printf (" [%2d] ", id);
	  for (i = 0; i < size; i++)
	    printf (" %02x", fgetc (DatFile));
	  newline ();

	  index = fgetc (DatFile);
	  if (index != 0)
	    printf ("\t        ");
	}
    }
  else
    {
      while (index != 0)
	{
	  ind_block_num = (index >> 7) + 1;
	  size = size1 = ((index >> 6) & 1) + 1;
	  id = (index & 0x3f);

	  if (ind_block_num == 2)
	    {
#ifdef DEBUG
	      if (size == 2)
		printf ("ALERT! size1 = 1\n\t        ");
#endif
	      index2 = fgetc (DatFile);

	      ignored2 = (index2 >> 7);
	      ignored3 = (index2 >> 6) & 1;
	      size = size2 = (index2 & 0x3f);

#ifdef DEBUG
	      if (ignored2 == 0)
		printf ("ALERT! i2 = 0\n\t        ");
	      if (ignored3 == 0)
		printf ("ALERT! i3 = 0\n\t        ");
#endif
	    }

	  printf (" [%2d] ", id);

	  for (i = 0; i < size; i++)
	    printf (" %02x", fgetc (DatFile));
	  newline ();

	  index = fgetc (DatFile);

	  if (index != 0)
	    printf ("\t        ");
	}
    }

#ifdef DEBUG
  pos = ftell (DatFile);
  printf ("<PR-END:$%04x>\n", pos);

  next = 0;
  for (j = 0; j < objects_count; j++)
    {
      if (pos == (object_table[j][entry_length - 2] * 256) + object_table[j][entry_length - 1])
	next = j + 1;
    }

  printf ("Next proplist: ");
  if (next != 0)
    {
      printf ("$%3x", next);
    }
  else
    printf ("NONE");
  newline ();
#endif
}
