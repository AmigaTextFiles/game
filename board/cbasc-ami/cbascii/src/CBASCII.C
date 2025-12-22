/***************************************************************************
 * CBASCII -- Convert ChessBase games to and from ASCII files.
 *
 * Copyright (c)1993 Andy Duplain.
 *
 * Version      Date            Comments
 * =======      ====            ========
 * 1.0          11/11/93        Initial.
 * 1.3cA        01/03/96	Amiga Version	(c)1996 Ortwin Paetzold
 ***************************************************************************/

#include "global.h"
#include "aexport.h"
#include "aimport.h"
#include "cbascii.h"
#include <ctype.h>

#define BANNER "CBASCII  Copyright (c)1993-94 Andy Duplain, Amiga Version (c)1996 \
 Ortwin Paetzold  "
#ifdef ANSI_C
#define VERSION() output("V1.3c-Amiga [%s %s]\n", __DATE__, __TIME__);
#else
#define VERSION() output("V1.3c-Amiga\n");
#endif

/* "conv" defines */
#define EXPORT          1
#define IMPORT          2

int conv = 0;                          /* conversion */
int comm_strip = 0;                    /* strip comments */
int var_strip = 0;                     /* strip variations */
int format = 0;                        /* import / export format */
int append = 0;                        /* -a flag */
int quiet = 0;                         /* -q flag */
int testmode = 0;                      /* -t flag */
int ignore_errors = 0;                 /* -I flag */
int no_nag = 0;                        /* PGN without NAGs */
u_long first = 1, last = 0xffffffffL;
char *dbname;
char *asciiname;
Database db = NULL;
FILE *file;
char comm_start = 0;                   /* comment start character */
char comm_end = 0;                     /* comment end character */
char var_start = 0;                    /* variation start character */
char var_end = 0;                      /* variation end character */

static void usage P__((void));
static int parse_char_arg P__((char *s, char *type));
static void set_char P__((char *var, char value));
static int parse_format_arg P__((char *s));

static void
usage()
{
    error("usage: cbascii -e|-i [options] ascii-file database");
    error("  -e\t\texport (ChessBase -> ASCII)");
    error("  -i\t\timport (ASCII -> ChessBase)");
    error("options:");
    error("  -r x-y\tspecify first and last game to convert");
    error("  -q\t\tquiet");
    error("  -s\t\tstrip comments");
    error("  -S\t\tstrip variations");
    error("export-only options:");
    error("  -a\t\topen ascii-file in \"append\" mode");
    error("  -c char|value\tspecify 'comment start' character");
    error("  -C char|value\tspecify 'comment end' character");
    error("  -f format\tspecify export format (default is \"pgn\")");
    error("  -v char|value\tspecify 'variation start' character");
    error("  -V char|value\tspecify 'variation end' character");
    error("import-only options:");
    error("  -I\t\tmake errors none fatal (ignore errors)");
    error("  -t\t\ttest mode; parse ascii-file without adding to database");
    exit(1);
}

/*
 * PARSE_CHAR_ARG
 *
 * Get the comment/variation character specifier as either a character or
 * as a decimal value
 */
static int
parse_char_arg(s, type)
    char *s, *type;
{
    int ret;

    if (strlen(s) == 3 && *s == '\'' && *(s + 2) == '\'')
        return *(s + 1);               /* character */

    ret = (int) xatol(s);
    if (!xatol_err)
        return ret & 0xff;

    error("invalid %s character specifier \"%s\"", type, s);
    error("characters should be specified as either a character enclosed");
    error("in quotes (e.g 'A') or as its decimal value (e.g. 65)");
    exit(1);
}

/*
 * SET_UCHAR
 *
 * Set the value of an unsigned character, but only if it is currently
 * unset (used to set comment and variation characters).
 */
static void
set_char(var, value)
    char *var;
    char value;
{
    if (!*var)
        *var = value;
}

/*
 * PARSE_FORMAT_ARG
 *
 * Parse format-type argument
 */
static int
parse_format_arg(s)
    char *s;
{
    if (strcmp(s, "cb") == 0) {
        format = TYPE_CB;
        set_char(&comm_start, 0);
        set_char(&comm_end, 0);
        set_char(&var_start, '[');
        set_char(&var_end, ']');
        return 0;
    }
    if (strcmp(s, "pgn") == 0) {
        format = TYPE_PGN;
        set_char(&comm_start, '{');
        set_char(&comm_end, '}');
        set_char(&var_start, '(');
        set_char(&var_end, ')');
        no_nag = 0;
        return 0;
    }
    if (strcmp(s, "pgn_no_nag") == 0) {
        format = TYPE_PGN;
        set_char(&comm_start, '{');
        set_char(&comm_end, '}');
        set_char(&var_start, '(');
        set_char(&var_end, ')');
        no_nag = 1;
        return 0;
    }
    error("invalid format specifier: valid specifiers are:");
    error("\"cb\"\t\tChessBase-format");
    error("\"pgn\"\t\tPortable Game Notation");
    error("\"pgn_no_nag\"\tPortable Game Notation (without NAGs)");
    exit(1);
}

int
main(argc, argv)
    int argc;
    char **argv;
{
    int c, ret;
    char *mode;

    ret = 0;

    opterr = 0;
    while ((c = getopt(argc, argv, "ac:C:ef:iIqr:sStv:V:")) != EOF) {
        switch (c) {
        case 'a':
            append++;
            break;
        case 'c':
            comm_start = parse_char_arg(optarg, "comment");
            break;
        case 'C':
            comm_end = parse_char_arg(optarg, "comment");
            break;
        case 'e':
            if (conv) {
                error("specify either \"-e\" or \"-i\"");
                return 1;
            }
            conv = EXPORT;
            break;
        case 'f':
            parse_format_arg(optarg);
            break;
        case 'i':
            if (conv) {
                error("specify either \"-e\" or \"-i\"");
                return 1;
            }
            conv = IMPORT;
            break;
        case 'I':
            ignore_errors++;
            break;
        case 'q':
            quiet++;
            break;
        case 'r':
            first = range_first(optarg);
            last = range_last(optarg);
            if ((!first || !last) || first > last) {
                error("invalid range");
                return 1;
            }
            break;
        case 's':
            comm_strip++;
            break;
        case 'S':
            var_strip++;
            break;
        case 't':
            testmode++;
            break;
        case 'v':
            var_start = parse_char_arg(optarg, "variation");
            break;
        case 'V':
            var_end = parse_char_arg(optarg, "variation");
            break;
        case '?':
        default:
            usage();
        }
    }
    argc -= optind;
    argv += optind;

    if (!conv) {
        error("you must specify \"-e\" to export or \"-i\" to import");
        return 1;
    }
    if (argc != 2)
        usage();

    if (!format) {
        format = TYPE_PGN;
        set_char(&comm_start, '{');
        set_char(&comm_end, '}');
        set_char(&var_start, '(');
        set_char(&var_end, ')');
    }
    asciiname = *argv++;
    dbname = *argv;
    kill_ext(dbname);

    if (!quiet) {
        output(BANNER);
        VERSION();
#ifdef PD
        output("Public Domain version.\n");
#endif
    }
    no_error = 1;
    db = open_database(dbname);
    no_error = 0;
    if (!db) {
        if (conv == IMPORT) {
            if (!quiet)
                output("creating database %s\n", dbname);
            db = create_database(dbname);
            if (!db)
                return 1;
        } else {                       /* exporting */
            error("error opening database %s", dbname);
            return 1;
        }
    }
    if (conv == EXPORT) {
        if (last > db->ngames)
            last = db->ngames;
        if (first > last)
            first = last;
    }
 /* open the ASCII file */
    if (conv == IMPORT)
        mode = "rt";
    else
        mode = append ? "at" : "wt";
    file = fopen(asciiname, mode);
    if (!file) {
        error("error opening \"%s\"", asciiname);
        return 1;
    }
    if (conv == EXPORT) {
        ret = export();
    } else {                           /* importing */
        ret = import();
    }

    close_database(db);
    fclose(file);

    return ret;
}
