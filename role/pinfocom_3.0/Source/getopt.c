/*
 * getopt.c  - Simulates getopt(1) and getopt(3)
 *
 * This program (or library) simulates the getopt(1) program (and
 * the getopt(3) library function).
 *
 * Copyright:
 *      Copyright (C) 1988  Paul D. Smith
 *      Permission is given to use, modify, and distribute this code
 *      in any manner the user sees fit, as long as this C comment
 *      remains intact.
 *
 *      This code is distributed in the hope that it will be useful,
 *      but WITHOUT ANY WARRANTY; without even the implied warranty of
 *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * Author(s):
 *  pds - Paul D. Smith (paul_smith@dg.com: was pds@cs.cmu.edu)
 *
 * History:
 *  15 Apr 88 pds - Created.
 */

/*
 * $Header: RCS/getopt.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>


#ifdef GETOPT_DEBUG
#   define  DB(_x)      fprintf _x
#else
#   define  DB(_x)
#endif

#define USAGE           "usage: getopt legal-args $*\n"

#define NO_OPTARG       ": option requires an argument -- "
#define NO_OPT          ": illegal option -- "

#define IS_VALID(_c)    (((_c) != '\0') && ((_c) != ':'))
#define IS_OPT(_s)      ((*(_s) == '-') && IS_VALID((_s)[1]))


char *optarg=NULL;
int optind=1, opterr=1;


int getopt(argc, argv, optstring)
int argc;
char **argv;
char *optstring;
{
    register char *argp, *optp;
    char *errp;
    static int prev_offset=0;
    int c;

    optarg = NULL;

    parse_next:
    if (optind >= argc)
    {
        DB((stderr, "getopt: no more args (optind=%d)\n", optind));
        return (-1);
    }

    /*
     * Do we have a real option?  Must be a "-?*" format, where
     * ? cannot be ':'.
     */
    argp = argv[optind];

    if (!IS_OPT(argp))
    {
        DB((stderr, "getopt: not an option = %s\n", argp));
        return (-1);
    }

    /*
     * Do we have a '--' argument?  Skip it & we're done.
     */
    if (argp[1] == '-')
    {
        DB((stderr, "getopt: end of options = %s\n", argp));
        ++optind;
        return (-1);
    }

    /*
     * Skip into the middle of the last option we were parsing
     */
    argp += ++prev_offset;

    /*
     * Is this the end of the argument?  If so parse the next arg.
     */
    if (*argp == '\0')
    {
        ++optind;
        prev_offset = 0;
        goto parse_next;
    }

    /*
     * Otherwise, find the option in the optstring.
     */
    for (optp=optstring; *optp != '\0'; ++optp)
    {
        if (*optp == *argp)
        {
            DB((stderr, "getopt: found option = %c\n", *argp));
            c = (int)*(argp++);

            /*
             * Process option-arguments
             */
            if (*(++optp) == ':')
            {
                DB((stderr, "getopt: Requires argument, ="));
                prev_offset = 0;

                if (*argp == '\0')
                {
                    DB((stderr, "(next arg) "));
                    if (++optind == argc)
                    {
                        errp = NO_OPTARG;
                        goto error;
                    }
                    argp = argv[optind];
                }

                optarg = argp;
                ++optind;
                DB((stderr, " %s\n", optarg));
                return (c);
            }

            /*
             * Otherwise it's a simple option.
             */
            if (*argp == '\0')
            {
                ++optind;
                prev_offset = 0;
            }

            return (c);
        } /* if */
    }/* for */

    /*
     * We have come to the end of the optstring without finding
     * an option, so print & return an error.
     */
    c = *argp;
    if (*(++argp) == '\0')
    {
        ++optind;
        prev_offset = 0;
    }
    errp = NO_OPT;

error:
    if (opterr)
    {
        fputs(argv[0], stderr);
        fputs(errp, stderr);
        putc(c, stderr);
        putc('\n', stderr);
    }
    return ('?');
}


#ifdef EXE

/*
 * This program simulates the getopt(1) program.
 */


int main(argc, argv)
int argc;
char **argv;
{
    register char **av, *cp, *op;
    int c, i;
    char options[1024];

    /*
     * Make sure we've got something:
     */
    if (argc < 2)
    {
        fputs(USAGE, stderr);
        exit (2);
    }

    /*
     * Get beyond the optstring, which is the first argument.
     */
    ++optind;
    op = options;

    while ((c = getopt(argc, argv, argv[1])) != -1)
    {
        DB((stderr, "main: got opt %c\n", c));
        if (c == '?')
        {
            exit (2);
        }

        *(op++) = '-';
        *(op++) = c;

        if (optarg)
        {
            DB((stderr, "main: optarg = %s\n", optarg));
            *(op++) = ' ';

            for (cp = optarg; *cp != '\0'; *(op++) = *(cp++))
            {}
        }

        *(op++) = ' ';
    }/*while*/

    DB((stderr, "main: End of options\n"));

    *op = '\0';
    fputs(options, stdout);
    putchar('-');
    putchar('-');
    putchar(' ');

    for (i = optind, av = &argv[i]; i < argc; ++i, ++av)
    {
        DB((stderr, "main: regular arg = %s\n", *av));

        fputs(*av, stdout);
        if (i != argc)
        {
            putchar(' ');
        }
    }
    putchar('\n');

    exit (0);
}


#endif  /* EXE */
