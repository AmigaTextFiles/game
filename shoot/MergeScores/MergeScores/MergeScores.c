/*
 *  MergeScores.c    Merges Megaball score tables.
 *  (C) 1995 Richard Gledhill  -  93rpg@club.eng.cam.ac.uk
 *  Compile with Dice with "dcc mergescores.c -o MergeScores"
 *  7/2/95
 */

#include <stdio.h>
#include <stdlib.h>

#define FALSE 0
#define TRUE  -1
#define DEBUG FALSE

int
brk()
{
    puts("Stopped.");
    return(1);
}

main(ac, av)
char *av[];
{
	int   i, j;
	long  score1 = 0, score2 = 0;
  unsigned char  table1[24], table2[24], table3[24],										/* Score buffer  */
       *tablename1 = av[1], *tablename2 = av[2], *tablename3 = av[3],		/* Tablenames    */
        name1[21],  name2[21];																					/* Players names */
  FILE *ft1 = NULL, *ft2 = NULL, *ft3 = NULL;														/* File pointers */
  unsigned char  rt1 = TRUE, rt2 = TRUE;

  if (ac < 4)
	{
		printf("Megaball High Score Table-merging utility.\n");
		printf("(C) 1995 Richard Gledhill.\n");
		printf("Usage:\n     %s <table1> <table2> <outputtable>\n",av[0]);
		exit(1);
	}

	onbreak(brk);

	name1[20] = 0;
	name2[20] = 0;

/*
 * Open table 1
 */

	if (!(ft1 = fopen(tablename1,"rb")))
	{
		printf("Can't open table 1 : `%s' .\n",tablename1);
		return(1);
	}
	
/*
 * Open table 2
 */

	if (!(ft2 = fopen(tablename2,"rb")))
	{
		printf("Can't open table 2 : `%s' .\n",tablename2);
		return(1);
	}

/*
 * Open output table (3)
 */
	
	if (!(ft3 = fopen(tablename3,"wb")))
	{
		printf("Can't open table 3 : `%s' .\n",tablename3);
		return(1);
	}

	printf("New Score Table:\n");

	for (i = 0; i < 15; i++)
	{
		/* Read in score from table 1 if needed */
		if (rt1)
		{
			fread(table1,24,1,ft1);
#if DEBUG
			for (j = 0; j < 24; j++) printf("%02i ",table1[j]);
			printf("\n");
#endif
			strncpy(name1,table1,20);
			score1 = 0;
			for (j = 20; j < 24; j++)  score1 = score1*256 + table1[j];
		}
		
		/* Read in score from table 2 if needed */
		if (rt2)
		{
			fread(table2,24,1,ft2);
			strncpy(name2,table2,20);
#if DEBUG
			for (j = 0; j < 24; j++) printf("%02i ",table2[j]);
			printf("\n");
#endif
			score2 = 0;
			for (j = 20; j < 24; j++)  score2 = score2*256 + table2[j];
		}
		
#if DEBUG
		printf("Name1: %s    Score: %li\n",name1,score1);
		printf("Name2: %s    Score: %li\n",name2,score2);
#endif

		if ((strcmp(name1,name2) == 0) && (score1 == score2))
		{
		  /* Strip out duplicate entries: only write out one. */
			fwrite(table1,24,1,ft3);
			fwrite(table1,20,1,stdout);
			printf(" %8ld\n",score1);
			rt1 = TRUE;
			rt2 = TRUE;
		}
		else if (score1 > score2)
		{
			/* Write out name and score from table 1 */
			fwrite(table1,24,1,ft3);
			fwrite(table1,20,1,stdout);
			printf(" %8ld\n",score1);
			rt1 = TRUE;
			rt2 = FALSE;
		}
		else if (score1 < score2)
		{
			/* Write out name and score from table 2 */
			fwrite(table2,24,1,ft3);
			fwrite(table2,20,1,stdout);
			printf(" %8ld\n",score2);
			rt1 = FALSE;
			rt2 = TRUE;
		}
		else
		{
			/* Write out name and score from both tables */
			fwrite(table1,24,1,ft3);
			fwrite(table1,20,1,stdout);
			printf(" %8ld\n",score1);
			if (i < 14)
			{
				fwrite(table2,24,1,ft3);
				fwrite(table2,20,1,stdout);
				printf(" %8ld\n",score2);
			}
			rt1 = TRUE;
			rt2 = TRUE;
			i++;
		}
  }		

	fclose(ft1);
	fclose(ft2);
	fclose(ft3);
  return(0);
}

