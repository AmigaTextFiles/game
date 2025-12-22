#include "frobnitz.h"

int depth = 0;
byte was_chained[MAXNUM_OBJECT];

/*******************************************************************/
/*  Funktion: PrintTree                                            */
/*******************************************************************/

void
PrintTree (void)
{
  byte first;
  unsigned long i;

  printf ("OBJECT TREE:\n\n");

  if (!(objects_read))
    ReadObjects ();

  printf ("%d objects:\n", objects_count);

  for (i = 0; i < objects_count; i++)
    {
      if ((old_header) ? (!object_table[i][4]) : (!((object_table[i][6] * 256) + object_table[i][7])))
	{
	  ChainObj (i);
	  newline ();
	  depth = 0;
	}
    }

  first = 1;
  for (i = 0; i < objects_count; i++)
    {
      if (was_chained[i] == 0)
	{
	  printf ("%s", (first ? "Closed chains:\n" : "\n"));
	  first = 0;

	  printf ("\n ... : ...\t(...)\n");
	  depth = 1;
	  ChainObj (i);
	  newline ();
	}
    }
}

/*****************************************************************/
/*   Funktion: ChainObj                                          */
/*****************************************************************/

void
ChainObj (unsigned long i)
{
  int j, k;
  byte first;

  for (j = 0; j < depth; j++)
    printf ("\t");

  PrintObject (i);

  if (!no_attr)
    {
      first = 1;

      for (j = 0; j < ((old_header) ? 4 : 6); j++)
	{
	  for (k = 7; k >= 0; k--)
	    {
	      if ((object_table[i][j] >> k) & 1)
		{
		  printf ("%s%d", (first ? "\t(" : ","), ((7 - k) + (j * 8)));
		  first = 0;
		}
	    }
	}
      printf ("%s", (first ? "" : ")"));
    }

  newline ();

  if (was_chained[i] == 1)
    {
      printf ("Warning: Object already chained!\n");
      depth--;
      return;
    }
  else
    was_chained[i] = 1;

  if ((old_header) ? object_table[i][6] : ((object_table[i][10] * 256) + object_table[i][11]))
    {
      depth++;
      ChainObj ((old_header) ? (object_table[i][6] - 1) : (((object_table[i][10] * 256) + object_table[i][11]) - 1));
    }
  if ((old_header) ? object_table[i][5] : (((object_table[i][8] * 256) + object_table[i][9]) != 0))
    {
      ChainObj ((old_header) ? (object_table[i][5] - 1) : (((object_table[i][8] * 256) + object_table[i][9]) - 1));
    }
  else
    depth--;
}
