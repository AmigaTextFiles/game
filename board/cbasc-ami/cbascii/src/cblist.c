/***************************************************************************
 * CBLIST -- List games in a ChessBase file.
 *
 * Copyright (c)1993 Andy Duplain.
 *
 * Version      Date            Comments
 * =======      ====            ========
 * 1.0          11/11/93        Initial.
 * 1.0A         01/03/96	Amiga Version	(c)1996 Ortwin Paetzold
 ***************************************************************************/

#include "global.h"
#ifdef MSDOS
#include <io.h>
#endif

#define BANNER "CBLIST  Copyright (c)1993-94 Andy Duplain, Amiga Version (c)1996 \
 Ortwin Paetzold  "
#ifdef ANSI_C
#define VERSION() output("V1.0-Amiga [%s %s]\n", __DATE__, __TIME__);
#else
#define VERSION() output("V1.0-Amiga\n");
#endif

#ifdef msc
#define isatty(x) _isatty(x)
#endif

static void usage P__((void));

static int quiet = 0;                  /* -q flag */
static int outpause = 0;               /* pause if writing to tty */
static char *dbname;
static u_long first = 1L, last = 0xffffffffL;
static Database db = NULL;
static Game game = NULL;

static void
usage()
{
    error("usage: cblist [options] database");
    error("options:");
    error("  -q\t\tquiet");
    error("  -r x-y\tspecify the first and last game to list");
    exit(1);
}

int
main(argc, argv)
    int argc;
    char **argv;
{
    int c, ret, nprinted;
    u_long i;

    ret = 0;

    opterr = 0;
    while ((c = getopt(argc, argv, "qr:")) != EOF) {
        switch (c) {
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
        case '?':
        default:
            usage();
        }
    }
    argc -= optind;
    argv += optind;

    if (argc != 1)
        usage();

    dbname = *argv;
    kill_ext(dbname);

    if (isatty(1))
        outpause = 1;

    if (!quiet) {
        output(BANNER);
        VERSION();
    }
    db = open_database(dbname);
    if (!db)
        return 1;

    if (last > db->ngames)
        last = db->ngames;
    if (first > last)
        first = last;

    game = (Game) mem_alloc(sizeof(struct game));
    if (!game) {
        ret = -1;
        goto quit;
    }
    nprinted = 0;
    for (i = first; i <= last; i++) {
        game_tidy(game);
        game->num = i;
        if (read_info(db, game) < 0)
            continue;
        output(format_info(game, 0));
        output("\n");
        nprinted++;
        if (outpause && nprinted == 20) {
            if (hit_return() == 1)
                break;
            nprinted = 0;
        }
    }

quit:
    if (game)
        free(game);
    close_database(db);

    return ret;
}
