/* infocom.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/infocom.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <time.h>

#include "infocom.h"
#include "patchlevel.h"

#define COPYRIGHT   "\n\
    This program comes with ABSOLUTELY NO WARRANTY.\n\
    This program is free software, and you are welcome to redistribute it\n\
    under certain conditions; see the file COPYING in the source directory\n\
    for full details.\n"

#define USAGE       "Usage: %-8s [-aAehoOpPstTvV] [-c context] [-i indent] [-l lines]\n\t\t[-m margin] [-r savefile] "
#define OPTIONS     "aAc:ehi:l:m:oOpPr:stTvV"

#ifndef RMARGIN
#define RMARGIN 2
#endif
#ifndef LMARGIN
#define LMARGIN 0
#endif
#ifndef CONTEXT
#define CONTEXT 2
#endif

header_t    data_head;
obj_info_t  objd;
gflags_t    gflags;
file_t      file_info;

word        random1;
word        random2;
word        pc_offset;
word        pc_page;
word        resident_blocks;
word        save_blocks;

byte        *base_ptr;
byte        *base_end;
byte        *vocab;
byte        *global_ptr;
byte        *end_res_p;
word        *stack_base;
word        *stack_var_ptr;
word        *stack;

byte        *prog_block_ptr;

/* Score Routine Variables */

char        *ti_location;
char        *ti_status;

/* Input Routine Variables */

byte        *wsbf_strt;
byte        *end_of_sentence;
word        num_vocab_words;
word        vocab_entry_size;
byte        *strt_vocab_table;
byte        *end_vocab_table;

/* Print Routine Variables */

byte        *common_word_ptr;
print_buf_t *pbf_p;

char ws_table[] = { ' ','\t','\r','.',',','?','\0','\0' };

char table[] =
{
    'a','b','c','d','e','f','g','h','i','j','k','l','m',
    'n','o','p','q','r','s','t','u','v','w','x','y','z',
    'A','B','C','D','E','F','G','H','I','J','K','L','M',
    'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
    ' ',' ','0','1','2','3','4','5','6','7','8','9','.',
    ',','!','?','_','#','\'','"','/','\\','-',':','(',')',
    '\0','\0'
};


static void
usage A1(const char *, name)
{
    extern const char *scr_usage;
    extern const char *scr_long_usage;

    const char *cp;

    for (cp = &name[strlen(name)-1];
         cp>=name && (isalnum(*cp) || (*cp=='.') || (*cp=='_') || (*cp=='-'));
         --cp)
    {}

    fprintf(stdout, USAGE, cp+1);
    fprintf(stdout, "%s%s[filename]\n",
            scr_usage, *scr_usage ? " " : "");

    fprintf(stdout,
           "\nPortable Infocom Datafile Interpreter:  Version %d.%d\n",
           VERSION, PATCHLEVEL);
    puts(COPYRIGHT);

    puts("\
\t-h\toutput the data file header\n\
\t-o\toutput object names, attributes and links\n\
\t-O\toutput object tree\n\
\t-v\toutput the game vocabulary\n\
\t-V\tverify the game data file\n\n\
\t-a\tdisplay changes to object attributes while playing\n\
\t-A\tdisplay value tests of object attributes while playing\n\
\t-c #\tset # of context lines to keep when paging\n\
\t-e\techo each command before executing\n\
\t-i #\tindent game output # of spaces\n\
\t-l #\tset # of screen lines\n\
\t-m #\tset # of spaces as right margin\n\
\t-p\tdon't page long output\n\
\t-P\tset alternate prompt flag\n\
\t-r file\trestore saved game file after starting up\n\
\t-s\tdon't display status line\n\
\t-t\tdisplay changes to object tree while playing\n\
\t-T\tset Tandy licensing flag\n");

    if (scr_long_usage != NULL)
        puts(scr_long_usage);
}


void
seed_random()
{
    extern word     random1;
    extern word     random2;
#ifdef NO_RANDOM
    random1 = 0xFFFF;
    random2 = 0xFFFF;
#else
    random1 = time(0) >> 16;
    random2 = time(0) & 0xFFFF;
#endif
}


int
main A2(int, argc, char **, argv)
{
    extern int atoi P((const char *));
    extern int getopt P((int, char* const*, const char *));
    extern int  optind;
    extern char *optarg;

    extern char sname[];
    extern const char *scr_opt_list;

    char        *cmd_name;
    char        *optlist;
    char        *snm    = NULL;
    Bool        head    = 0;
    Bool        objs    = 0;
    Bool        vocab1  = 0;
    Bool        tree    = 0;
    Bool        verfy   = 0;
    Bool        play    = 1;
    Bool        prompt  = 0;
    Bool        tandy   = 0;
    int         margin  = RMARGIN;
    int         indent  = LMARGIN;
    int         lines   = 0;
    int         context = CONTEXT;
    int         width;
    int         c;

    cmd_name = argv[0];

    if ((argc = scr_cmdarg(argc, &argv)) == 0)
    {
        usage(cmd_name);
        return (1);
    }

    gflags.filenm = NULL;
    gflags.paged = 1;
    gflags.pr_status = 1;

    optlist = xmalloc(sizeof(OPTIONS) + strlen(scr_opt_list));

    strcpy(optlist, OPTIONS);
    strcat(optlist, scr_opt_list);

    while ((c = getopt(argc, argv, optlist)) != -1)
    {
        switch (c)
        {
            case 'a':
                gflags.pr_attr = 1;
                break;
            case 'A':
                gflags.pr_atest = 1;
                break;
            case 'c':
                context = atoi(optarg);
                break;
            case 'e':
                gflags.echo = 1;
                break;
            case 'h':
                head = 1;
                play = 0;
                break;
            case 'i':
                indent = atoi(optarg);
                break;
            case 'l':
                lines = atoi(optarg);
                break;
            case 'm':
                margin = atoi(optarg);
                break;
            case 'o':
                objs = 1;
                play = 0;
                break;
            case 'O':
                tree = 1;
                play = 0;
                break;
            case 'p':
                gflags.paged = 0;
                break;
            case 'P':
                prompt = 1;
                break;
            case 'r':
                snm = optarg;
                break;
            case 's':
                gflags.pr_status = 0;
                break;
            case 't':
                gflags.pr_xfers = 1;
                break;
            case 'T':
                tandy = 1;
                break;
            case 'v':
                vocab1 = 1;
                play = 0;
                break;
            case 'V':
                verfy = 1;
                play = 0;
                break;
            default:
                scr_getopt(c, optarg);
                break;

            case '?':
                usage(cmd_name);
                return (1);
        }
    }

    gflags.game_state = NOT_INIT;

    width = scr_setup(margin, indent, lines, context);

    /*
     * Open the game file, if possible...
     */
    if ((argc > optind+1)
        || ((gflags.filenm = open_file(argv[optind])) == NULL))
    {
        usage(cmd_name);
        return (1);
    }

    init();

    if (play)
    {
        check_version();

        scr_begin();

        gflags.game_state = INIT_GAME;

        if (snm != NULL)
        {
            strcpy(sname, snm);
            restore();
            gflags.game_state = PLAY_GAME;
        }
        else
            change_status();

        if (tandy)
            F1_SETB(B_TANDY);
        if (prompt)
            F1_SETB(B_ALT_PROMPT);

        interp();

        scr_end();
    }
    else
    {
        if (snm != NULL)
        {
            strcpy(sname, snm);
            restore();
        }

        pbf_p->max = width;
        options(verfy, head, objs, vocab1, tree);
    }

    scr_shutdown();

    return (0);
}
