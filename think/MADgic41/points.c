/*
 * Points.c
 * by Scott Maxwell 18 March 92
 *
 * Takes a MADgic Core 4.0 tournament results file and translates it into
 *  a points-based system, where a win is worth 3 points, a tie is 1
 *  point, and a loss is of course 0 points. Any of those settings can
 *  be overridden by command-line arguments.
 *
 * I compiled it with:
 *  lc -cafis -d0 -mas -v -Lmv -E -O points
 */

/*
#include <types.h>
*/
#define VOID void
#define BOOL int

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE		1024


/**********************
 *                    *
 *  Global variables  *
 *                    *
 **********************/

FILE		*Ifp;									/* Input-file pointer  */



/*************************
 *                       *
 *  Function prototypes  *
 *                       *
 *************************/

VOID process_file(double, double, double);
VOID clean_string(char *);
VOID main(int, char *[]);


/************************
 *                      *
 *  Start of functions  *
 *                      *
 ************************/


/*
 * Clean everything out of a string except spaces and digits.
 */
VOID clean_string(char *clean_me)
{
	char new_string[BUFFER_SIZE], *ps, *pd;

	ps = clean_me;
	pd = new_string;

	while(*ps != '\0')
	{
		if ( (*ps == ' ') || ( (*ps >= '0') && (*ps <= '9') ) )
		{
			*pd = *ps;
			pd++;
		}
		ps++;
	}

	*pd = '\0';

	strcpy(clean_me, new_string);
}




/*
 * Process the input file, removing stuff with clean_string().
 */
VOID process_file(double wf, double tf, double lf)
{
	int i, wins, losses, ties;
	char buffer[BUFFER_SIZE];	/* Input buffer  */

	/* Preserve the banner */
	for (i = 0; i < 4; i++)
		if (fgets(buffer, BUFFER_SIZE, Ifp) != NULL) printf("%s", buffer);

	/* Loop 'til EOF. */	
	while(fgets(buffer, BUFFER_SIZE, Ifp) != NULL)				/* Blank line */
	{
		if (fgets(buffer, BUFFER_SIZE, Ifp) == NULL) break;   /* Filename */

		if (buffer[0] != '\0') /* Should never fail, but still ... */
			buffer[strlen(buffer) - 1] = '\0';
		printf("%30s", buffer); 										/* Filename */

		if (fgets(buffer, BUFFER_SIZE, Ifp) == NULL) break;	/* Results line */

		clean_string(buffer);

		sscanf(buffer, "%d %d %d", &wins, &losses, &ties);
		printf("    Points: %#6.2f\n", wf * wins + lf * losses + tf * ties);
	}

	puts("");
}

VOID main(int argc, char *argv[])
{
	double wf = 3.0, tf = 1.0, lf = 0.0;

	/* If user wants help, we'll give him help */
	if ( (argc < 2) || (argc > 5) || (argv[1][0] == '?') )
	{
		puts("\nPoints -- A freely redistributable program by Scott Maxwell   (C) 1992\n");
		puts("Assigns points based on MADgic Core 4.0 tournament manager output");
		printf("Usage: %s [>outfile] infile [win-factor [tie-factor [loss-factor]]]\n", argv[0]);
		puts("Defaults: win-factor = 3.0; tie-factor = 1.0; loss-factor = 0.0\n");
		exit(0);
	}

	/* (Else) invoked with filename */

	if ( (Ifp = fopen(argv[1], "r")) == NULL )
	{
		printf("Couldn't open file `%s' for reading.\n", argv[1]);
		exit(10);
	}

	if (argc > 2)
	{
		sscanf(argv[2], "%lf", &wf);
		if (argc > 3)
		{
			sscanf(argv[3], "%lf", &tf);
			if (argc > 4) sscanf(argv[4], "%lf", &lf);
		}
	}

	process_file(wf, tf, lf);

	if (fclose(Ifp) == EOF)
		puts("WARNING: inexplicable error closing input file ....");
}
