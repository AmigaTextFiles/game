/****************************************************************************
 * getopt():	Return the next user option on each iteration. 
 *		This is a clone of the usual UNIX getopt() function.
 *		If you have never used a getopt() before, you'll have to
 * 		 read about it on any UNIX machine or other C system that
 * 		 documents it.
 *
 * Author:	Daniel Barrett, barrett@cs.jhu.edu.
 * Date:	February 20, 1991.
 * Version:	1.1.
 *
 * License:	This code is placed in the Public Domain.
 *		Give it away to anybody for free!
 *		Use it for any purpose you like!
 *
 *		If you use this code in a program, please give me credit
 *		for my work.  Thanks!
 *
 * Why I wrote it:
 *
 *		Because every other getopt() function I have ever seen
 *		 had source code that was difficult to understand.
 *		I wrote this code to be very modular and readable.
 *		I hope you find it instructive and/or helpful.
 *
 * REVISION HISTORY:
 *	Version:	1.1
 *	Date:		February 20, 1991.
 *	Comments:	Bug fix in Pass().  Forgot to check that the
 *			current argument is non-empty and starts with
 *			a DASH.
 *
 *			Got rid of the unnecessary "g_" at the beginning
 *			of each function name.  Since they're static, we
 *			don't have to worry about duplication of names
 *			by the calling program.
 *
 *	Version:	1.0
 *	Date:		April 12, 1990.
 *	Comments:	First released version.
 *
 ****************************************************************************/

#include <stdio.h>
#include <string.h>

#undef NULL
#define NULL 0L

/************************************************************************
* Some constants.
************************************************************************/

#define	DASH		'-'	/* This preceeds an option. */
#define	ARG_COMING	':'	/* In the option string, this indicates that
				 * that the option requires an argument. */
#define	UNKNOWN_OPT	'?'	/* The char returned for unknown option. */

/************************************************************************
* Internal error codes.
************************************************************************/

#define	ERROR_BAD_OPTION	1
#define	ERROR_MISSING_ARGUMENT	2

/************************************************************************
* Mnemonic macros.
************************************************************************/



/************************************************************************
* ANSI function prototypes.
************************************************************************/

int		getopt(int argc, char *argv[], char *optString);
static int	NextOption(char *argv[], char *optString);
static int	RealOption(char *argv[], char *str, int *skip, int *ind,
			     int opt);
static void	HandleArgument(char *argv[], int *optind, int *skip);
static void	Error(int err, int c);
static void	Pass(char *argv[], int *optind, int *optsSkipped);

/************************************************************************
* Global variables.  You must declare these externs in your program
* if you want to see their values!
************************************************************************/

char	*optarg	= NULL;	/* This will point to a required argument, if any. */
int	optind	= 1;	/* The index of the next argument in argv. */
int	opterr	= 1;	/* 1 == print internal error messages.  0 else. */
int	optopt;		/* The actual option letter that was found. */


int getopt(int argc, char *argv[], char *optString)
{
	optarg = NULL;
	if (optind < argc)		/* More arguments to check. */
		return(NextOption(argv, optString));
	else				/* We're done. */
		return(EOF);
}


/* If the current argument does not begin with DASH, it is not an option.
 * Return EOF.
 * If we have ONLY a DASH, and nothing after it... return EOF as well.
 * If we have a DASH followed immediately by another DASH, this is the
 * special "--" option that means "no more options follow."  Return EOF.
 * Otherwise, we have an actual option or list of options.  Process it. */

static int NextOption(char *argv[], char *optString)
{
	static int optsSkipped = 0;	/* In a single argv[i]. */

	if ((argv[optind][0] == DASH)
	&&  ((optopt = argv[optind][1+optsSkipped]) != '\0'))
	{
		if (optopt == DASH)
		{
			optind++;
			return(EOF);
		}
		else
			return(RealOption(argv, optString, &optsSkipped,
					    &optind, optopt));
	}
	else
		return(EOF);
}


/* At this point, we know that argv[optind] is an option or list of
 * options.  If this is a list of options, *optsSkipped tells us how
 * many of those options have ALREADY been parsed on previous calls
 * to getopt().
 * If the option is not legal (not in optString), complain and return
 * UNKNOWN_OPT.
 * If the option requires no argument, just return the option letter.
 * If the option requires an argument, call HandleArgument and return
 * the option letter. */

static int RealOption(char *argv[], char *optString, int *optsSkipped,
			int *optind, int optopt)
{
	char *where;

	(*optsSkipped)++;
	if (where = strchr(optString, optopt))
	{
		if (*(where+1) == ARG_COMING)
			HandleArgument(argv, optind, optsSkipped);

		Pass(argv, optind, optsSkipped);
		return(optopt);
	}
	else
	{
		Error(ERROR_BAD_OPTION, optopt);
		Pass(argv, optind, optsSkipped);
		return(UNKNOWN_OPT);
	}
}


/* We have an option in argv[optind] that requires an argument.  If there
 * is no whitespace after the option letter itself, take the rest of
 * argv[optind] to be the argument.
 * If there IS whitespace after the option letter, take argv[optind+1] to
 * be the argument.
 * Otherwise, if there is NO argument, complain! */

static void HandleArgument(char *argv[], int *optind, int *optsSkipped)
{
	if (argv[*optind][1+(*optsSkipped)])
		optarg = argv[*optind] + 1 + (*optsSkipped);
	else if (argv[(*optind)+1])
	{
		optarg = argv[(*optind)+1];
		(*optind)++;
	}
	else
		Error(ERROR_MISSING_ARGUMENT, optopt);

	(*optsSkipped) = 0;
	(*optind)++;
}


/* Print an appropriate error message. */

static void Error(int err, int c)
{
	static char *optmsg = "Illegal option.\n";
	static char *argmsg = "An argument is required, but missing.\n";

	if (opterr)
	{
		if (err == ERROR_BAD_OPTION)
			fprintf(stderr, "-%c: %s", c, optmsg);
		else if (err == ERROR_MISSING_ARGUMENT)
			fprintf(stderr, "-%c: %s", c, argmsg);

		else	/* Sanity check! */
			fprintf(stderr, "-%c: an unknown error occurred\n",
				c);
	}
}


/* We have reached the end of argv[optind]... there are no more options
 * in it to parse.  Skip to the next item in argv. */

static void Pass(char *argv[], int *optind, int *optsSkipped)
{
	if (argv[*optind]
	&&  (argv[*optind][0] == DASH)
	&&  (argv[*optind][1+(*optsSkipped)] == NULL))
	{
		(*optind)++;
		(*optsSkipped) = 0;
	}
}

/***************************************************************************
* A test program.  Compile this file with -DTESTME as an option.
***************************************************************************/

#ifdef TESTME
main(int argc, char *argv[])
{
	char c;

	while ((c = getopt(argc, argv, "a:b:cde")) != EOF)
    	{
		printf("OPTION %c", c);
		if ((c == 'a') || (c == 'b'))
			printf(", %s\n", optarg);
		else
			printf("\n");
		printf("argc=%d, optind=%d\n", argc, optind);
	}
	exit(0);
}
#endif
