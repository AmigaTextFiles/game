/***************************************************************************
 * AEXPORT.C -- Export ChessBase data to ASCII
 *
 * Copyright (c)1993 Andy Duplain.
 *
 * Version      Date            Comments
 * =======      ====            ========
 * 1.0          23/12/93        Initial.
 ***************************************************************************/

#include "global.h"
#include "aexport.h"
#include "cbascii.h"
#include "nag.h"
#include <ctype.h>

/* column limits */
#define COLUMN_LAST     72             /* last column of text */

static int column;
static u_char *comm_ptr;
static char *wplayer, *bplayer, *round, *annotator;
static int print_movenum;
static int last_halfmove;
static int no_output;
static u_char eval, poseval, moveval, annotation;

static int export_move P__((int halfmove));
static u_char *extract_eval P__((u_char * comm_ptr));
static int to_column P__((int num));
static u_char *output_annot P__((u_char * comm_ptr, int init_comm));
static int output_nag P__((void));
static void get_players P__((char *s));
static void get_round P__((char *s));
static void get_annotator P__((char *s));
static char *remove_info P__((char *s, int len));
static void output_header P__((Game game));
static int output_string 
P__((FILE * file, char *prefix, char *s,
    char *suffix, int name));
    static void output_partial P__((Game game));
    static char *pgn_result P__((Game game));

/*
 * EXPORT
 *
 * Export games in ASCII.
 */
    int
     export()
{
    Game game;
    int ret, comm_count, j;
    int progress, last_report;
    u_long i;
    char *res;
    u_char *uptr;

    game = (Game) mem_alloc(sizeof(struct game));
    if (!game)
        return 1;

    for (i = first; i <= last; i++) {
        game->num = i;
        if (read_game(db, game) < 0)
            continue;

    /* initialise comment pointer */
        if (game->clen)
            comm_ptr = game->comments;
        else
            comm_ptr = NULL;

        output_header(game);
        print_movenum = 1;
        column = 0;

    /* check if an initial comment exists */
        if (game->clen && game->mlen && !comm_strip) {
            comm_count = 0;
            j = game->mlen;
            uptr = game->moves;
            while (j--) {
                if (*uptr != 0x80 && *uptr != 0xff
                  && *uptr & 0x80)
                    comm_count++;
                uptr++;
            }
            j = game->clen - 1;
            uptr = game->comments;
            uptr++;
            while (j--) {
                if (*uptr == 0xff)
                    comm_count--;
                uptr++;
            }

            if (comm_count < 0) {
                uptr -= 2;
                while (*uptr != 0xff) {
                    uptr--;
                }
                output_annot(uptr + 5, 1);
            }
        }
        process_moves(game, export_move);
        if (format == TYPE_PGN)
            res = pgn_result(game);
        else
            res = cvt_result(get_result(game->header));
        if (column + strlen(res) + 1 >= COLUMN_LAST)
            to_column(0);
        else
            fputc(' ', file);
        fprintf(file, "%s\n\n", res);

        if (!quiet) {
            progress = (int) (((i - first + 1) * 100L) / ((last - first) + 1));
            if (last_report != progress) {
                output("%d%%\r", progress);
                last_report = progress;
            }
        }
        game_tidy(game);
    }

    free(game);
    return ret;
}

/*
 * EXPORT_MOVE
 *
 * Export a move to ASCII.
 */
static int
export_move(halfmove)
    int halfmove;
{
    int len, colour, move;
    char *cptr;

    eval = 0;
    poseval = 0;
    moveval = 0;
    annotation = 0;

    if (var_strip && var_level)
        no_output = 1;
    else
        no_output = 0;

    if (halfmove == START_VAR_SIGNAL) {
        if (!var_strip) {
            if (column) {
                fputc(' ', file);
                column++;
            }
            if (var_start)
                fputc(var_start, file);
            print_movenum = 1;
        }
        last_halfmove = halfmove;
        return 0;
    } else if (halfmove == END_VAR_SIGNAL) {
        if (!var_strip) {
            if (var_end)
                fputc(var_end, file);
            print_movenum = 1;
        }
        last_halfmove = halfmove;
        return 0;
    }
    if (!no_output && column && (last_halfmove != START_VAR_SIGNAL)) {
        fputc(' ', file);
        column++;
    }
    colour = to_colour(halfmove);
    move = to_move(halfmove);

 /* output order is: movenum, move-eval, move, eval, pos-eval */

    if (!no_output) {
        cptr = format_movenum(halfmove);
        len = strlen(cptr);
        if (colour == 0 || print_movenum) {
            if (column + len >= COLUMN_LAST)
                to_column(0);
            fputs(cptr, file);
            column += len;
        }
    }
    if (comment && *comm_ptr == 0xff)
        comm_ptr = extract_eval(comm_ptr);
    cptr = algebraic(colour);
    len = strlen(cptr);

    if (column + len >= COLUMN_LAST)
        to_column(0);

    if (!no_output && format != TYPE_PGN)
        if (moveval)
            column += fprintf(file, "%s", cvt_moveval(moveval));

    if (!no_output) {
        fputs(cptr, file);
        column += len;
    }
    if (column > COLUMN_LAST)
        to_column(0);

    if (!no_output) {
        if (format != TYPE_PGN) {
            if (eval)
                column += fprintf(file, "%s", cvt_eval(eval));
            if (poseval && format != TYPE_PGN)
                column += fprintf(file, "%s", cvt_poseval(poseval));
        } else if (no_nag && eval > 0 && eval < 7) {
            column += fprintf(file, "%s", cvt_eval(eval));
        }
    /* do PGN NAG */
        if (format == TYPE_PGN && !no_nag && (eval || poseval || moveval))
            column += output_nag();
    }
    if (annotation && !comm_strip) {
        comm_ptr = output_annot(comm_ptr, 0);
        print_movenum = 1;
    } else {
        print_movenum = 0;
    }

    last_halfmove = halfmove;
    return 0;
}

/*
 * EXTRACT_EVAL
 *
 * Extract evaluation codes.  Returns the current position of the comment
 * pointer.
 */
static u_char *
extract_eval(comm_ptr)
    u_char *comm_ptr;
{
    if (*++comm_ptr != 0xff) {         /* evaluation */
        eval = *comm_ptr;
        if (*++comm_ptr != 0xff) {     /* position evaluation */
            poseval = *comm_ptr;
            if (*++comm_ptr != 0xff) { /* move evaluation */
                moveval = *comm_ptr;
                if (*++comm_ptr != 0xff) {      /* null */
                    if (*++comm_ptr != 0xff) {  /* annotation */
                        annotation = 1;
                    }
                }
            }
        }
    }
    return comm_ptr;
}

/*
 * TO_COLUMN
 *
 * Move to a specific column in the file
 */
static int
to_column(num)
    int num;
{
    if (num < column) {
        fputc('\n', file);
        column = 0;
    }
    while (column < num) {
        fputc(' ', file);
        column++;
    }
    return column;
}

/*
 * OUTPUT_ANNOT
 *
 * Output a formatted annotation string.
 *
 * Note: "do_move()" must have been called prior to this function.
 */
static u_char *
output_annot(comm_ptr, init_comm)
    u_char *comm_ptr;
    int init_comm;                     /* don't print space before comment */
{
    register char *cptr, *cptr1;
    int len, first, very_first;

    first = 1;
    very_first = 1;

    cptr = (char *) comm_ptr;
    for (len = 0; *comm_ptr != 0xff; len++)
        comm_ptr++;

    if (no_output)
        return comm_ptr;

    cptr = cvt_syml((u_char *) cptr, len);

 /* check that the comment isn't full of spaces */
    cptr1 = cptr;
    while (*cptr1 == ' ')
        cptr1++;
    if (!*cptr1)
        return comm_ptr;

 /* check that the comment character doesn't exist in the comment text itself */
    for (cptr1 = cptr; *cptr1; cptr1++) {
        if (*cptr1 == comm_start)
            *cptr1 = '*';
        else if (*cptr1 == comm_end)
            *cptr1 = '*';
    }

    if (!init_comm)
        fputc(' ', file);
    column++;
    if (comm_start) {
        fputc(comm_start, file);
        column++;
    }
    while (*cptr) {
        while (*cptr == ' ')
            cptr++;
        if (!*cptr)
            break;
        for (len = 0, cptr1 = cptr; *cptr1 && *cptr1 != ' '; len++)
            cptr1++;

        if (column + len >= COLUMN_LAST) {
            to_column(0);
            first = 1;
        }
        if (!first) {
            fputc(' ', file);
            column++;
        } else {
            first = 0;
        }

        fwrite((char *) cptr, 1, len, file);
        column += len;

        cptr += len;
        very_first = 0;
    }

    if (comm_end) {
        fputc(comm_end, file);
        column++;
    }
    return comm_ptr;
}

/*
 * OUTPUT_NAG
 *
 * Output evaluations as Numeric Annotation Glyphs (PGN only).
 */
static int
output_nag()
{
    int i, ret;

    ret = 0;

    if (eval) {
        for (i = 0; i <= MAX_NAG; i++) {
            if (nags[i].value == eval && nags[i].var == VAR_EVAL) {
                ret += fprintf(file, " $%d", i);
                break;
            }
        }
    }
    if (poseval) {
        for (i = 0; i <= MAX_NAG; i++) {
            if (nags[i].value == poseval &&
              nags[i].var == VAR_POSEVAL) {
                ret += fprintf(file, " $%d", i);
                break;
            }
        }
    }
    if (moveval) {
        for (i = 0; i <= MAX_NAG; i++) {
            if (nags[i].value == moveval &&
              nags[i].var == VAR_MOVEVAL) {
                ret += fprintf(file, " $%d", i);
                break;
            }
        }
    }
    return ret;
}

/*
 * GET_PLAYERS
 *
 * Find the White and Black player names for a game.
 */
static void
get_players(s)
    char *s;
{
    char *hyphen, *hyphen1;
    char *comma;

    if (!*s)
        return;

    hyphen = index(s, '-');
    if (hyphen)
        hyphen1 = index(hyphen + 1, '-');
    else
        hyphen1 = NULL;
    comma = index(s, ',');

 /* choose the hyphen after the first comma */
    if (hyphen && hyphen1)
        if (comma > hyphen)
            hyphen = hyphen1;

    wplayer = s;
    if (hyphen) {
        bplayer = hyphen + 1;
        *hyphen = '\0';
    }
}

/*
 * GET_ROUND
 *
 * Get the round number from a string.
 */
static void
get_round(s)
    char *s;
{
    char *anchor;
    int len;

    while (*s) {
        if (*s == '(') {
            anchor = s++;
            while (*s && *s != ')') {
                if (isdigit(*s) || *s == '.')
                    s++;
                else
                    break;
            }
            if (*s == ')') {
                len = (s - anchor) + 1;
                if (len > 2) {
                    round = remove_info(anchor, len);
                    return;
                }
            }
        }
        s++;
    }
}

/*
 * GET_ANNOTATOR
 *
 * Get the annotator name from a string.
 */
static void
get_annotator(s)
    char *s;
{
    char *anchor;
    int len;

    while (*s) {
        if (*s == '[') {
            anchor = s++;
            while (*s && *s != ']')
                s++;
            if (*s == ']') {
                len = (s - anchor) + 1;
                if (len > 2) {
                    annotator = remove_info(anchor, len);
                    return;
                }
            }
        }
        s++;
    }
}

/*
 * REMOVE_INFO
 *
 * Extract information from a string and replace the characters with spaces.
 */
static char *
remove_info(s, len)
    char *s;
    int len;
{
    char *ret;

    ret = mem_alloc(len - 1);
    if (!ret)
        return NULL;

    *s++ = ' ';
    len--;
    strncpy(ret, s, len - 1);
    while (len--)
        *s++ = ' ';
    return ret;
}

/*
 * OUTPUT_HEADER
 *
 * Output the game header
 */
static void
output_header(game)
    Game game;
{
    char *info;

    wplayer = NULL;
    bplayer = NULL;
    round = NULL;
    annotator = NULL;

    if (game->plen)
        get_round((char *) game->pinfo);
    if (!round && game->slen)
        get_round((char *) game->sinfo);
    if (game->slen)
        get_annotator((char *) game->sinfo);
    if (game->plen)
        tidy_string((char *) game->pinfo);
    if (game->slen)
        tidy_string((char *) game->sinfo);

    switch (format) {
    case TYPE_CB:
        if (game->plen) {
            info = cvt_sym(game->pinfo);
            get_players(info);
        }
        if (wplayer) {
            fputs(wplayer, file);
            if (game->w_elo)
                fprintf(file, " (%d)", game->w_elo);
        }
        if (wplayer && bplayer)
            fputs(" - ", file);
        if (bplayer) {
            fputs(bplayer, file);
            if (game->b_elo)
                fprintf(file, " (%d)", game->b_elo);
        }
        if (round)
            fprintf(file, " (%s)", round);
        if (game->eco_letter)
            fprintf(file, "    [%c%02d]", game->eco_letter,
              game->eco_main);
        fputc('\n', file);
        if (game->slen) {
            info = cvt_sym(game->sinfo);
            fputs(info, file);
        }
        if (game->year) {
            if (game->slen)
                fputs(", ", file);
            fprintf(file, "%u", game->year);
        }
        fputc('\n', file);
        break;

/* Amiga Database Enpassant includes the Event and not the Site information
   to carry the tournament data. Therefore this is exchanged here !!!
*/

    case TYPE_PGN:
#ifdef AMIGA
        if (game->slen) {
            info = cvt_sym(game->sinfo);
            output_string(file, "[Event \"", info, "\"]\n", 0);
        } else {
            fprintf(file, "[Event \"?\"]\n");
        }

        fprintf(file, "[Site \"?\"]\n");
#else
        fprintf(file, "[Event \"?\"]\n");

        if (game->slen) {
            info = cvt_sym(game->sinfo);
            output_string(file, "[Site \"", info, "\"]\n", 0);
        } else {
            fprintf(file, "[Site \"?\"]\n");
        }
#endif
        if (game->year)
            fprintf(file, "[Date \"%d.??.??\"]\n", game->year);
        else
            fprintf(file, "[Date \"??.??.??\"]\n");

        if (game->pinfo) {
            info = cvt_sym(game->pinfo);
            get_players(info);
        }
        if (round)
            fprintf(file, "[Round \"%s\"]\n", round);
        else
            fprintf(file, "[Round \"?\"]\n");

        if (wplayer)
            output_string(file, "[White \"", wplayer, "\"]\n", 1);
        else
            fprintf(file, "[White \"?\"]\n");

        if (bplayer)
            output_string(file, "[Black \"", bplayer, "\"]\n", 1);
        else
            fprintf(file, "[Black \"?\"]\n");

        fprintf(file, "[Result \"%s\"]\n", pgn_result(game));

        if (game->eco_letter)
            fprintf(file, "[ECO \"%c%02d\"]\n", game->eco_letter,
              game->eco_main);

        if (game->w_elo)
            fprintf(file, "[WhiteElo \"%d\"]\n", game->w_elo);

        if (game->b_elo)
            fprintf(file, "[BlackElo \"%d\"]\n", game->b_elo);

        if (annotator)
            output_string(file, "[Annotator \"", annotator, "\"]\n", 1);
        break;
    default:
        break;
    }

    if (is_partial(game->header)) {
        output_partial(game);
    }
    if (format == TYPE_PGN)
        fputc('\n', file);

    if (round)
        free(round);
    if (annotator)
        free(annotator);
}

/*
 * OUTPUT_STRING
 *
 * Output a string, escaping double quotes.  If the "name" argument is non-
 * zero a space will be written after a comma, and a period after a single
 * uppercase letter.
 */
static int
output_string(file, prefix, s, suffix, name)
    FILE *file;
    char *prefix, *s, *suffix;
    int name;
{
    int ret, len, comma, upper;

    /* change all occurances of '_' to '-' */
    if (name)
        char_change(s, '_', '-');

    ret = 0;
    len = 0;
    comma = 0;
    upper = 0;
    if (prefix)
        ret = fputs(prefix, file);
    while (*s) {
        if (*s == '"') {
        /* convert " -> \" */
            fputc('\\', file);
            fputc('"', file);
            ret += 2;
        } else if (*s == '\\') {
        /* convert \ -> \\ */
            fputc('\\', file);
            fputc('\\', file);
            ret += 2;
        } else if (name && *s == ',') {
        /* add space after comma */
            fputc(',', file);
            ret++;
            if (*(s + 1) && *(s + 1) != ' ') {
                fputc(' ', file);
                ret++;
                comma = 1;
            }
        } else {
            fputc(*s, file);
            ret++;
        }

    /* count the number of characters after outputing the comma */
        if (comma && isalpha(*s))
            len++;

        s++;

        if (comma && len == 1 && (!*s || isspace(*s))) {
            fputc('.', file);
            ret++;
        }
    }
    if (suffix)
        ret += fputs(suffix, file);
    return ret;
}


/*
 * OUTPUT_PARTIAL
 *
 * Output board set-up for partial games
 */
static void
output_partial(game)
    Game game;
{
    int i, c, p, x, first, need_comma;

    switch (format) {
    case TYPE_CB:
        for (c = 0; c < 2; c++) {
            if (!c) {                  /* White */
                fputc('(', file);
                fputc('w', file);
            } else {                   /* Black */
                fputc(';', file);
                fputc(' ', file);
                fputc('b', file);
            }
            need_comma = 0;
            for (p = KING; p <= PAWN; p++) {
                x = p | (c ? 8 : 0);
                first = 1;
                for (i = 0; i < 64; i++) {
                    if (game->board[i] == (u_char) x) {
                        if (need_comma) {
                            fputc(',', file);
                            need_comma = 0;
                        }
                        if (first) {
                            fputc(piece_list[p], file);
                            first = 0;
                        }
                        fputc(to_file(i) + 'a', file);
                        fputc(to_rank(i) + '1', file);
                        need_comma = 1;
                    }
                }
            }
        }
        fputc(')', file);
        break;
    case TYPE_PGN:
        fputs("[SetUp \"1\"]\n", file);
        fputs("[FEN \"", file);
        for (i = 7; i >= 0; i--) {     /* rank */
            x = 0;
            for (c = 0, x = 0; c < 8; c++) {    /* file */
                p = game->board[to_offset(c, i)];
                if (!p) {
                    x++;
                } else {
                    if (x) {
                        fprintf(file, "%d", x);
                        x = 0;
                    }
                    if (p & 8)
                        fputc(piece_list[p & 7] + ('a' - 'A'),
                          file);
                    else
                        fputc(piece_list[p], file);
                }
            }
            if (x)
                fprintf(file, "%d", x);
            if (i)
                fputc('/', file);
        }
        c = to_colour(game->halfmove);
        fprintf(file, " %c ", c ? 'b' : 'w');
        x = 0;
        if (is_wcs(game->header)) {
            fputc('K', file);
            x++;
        }
        if (is_wcl(game->header)) {
            fputc('Q', file);
            x++;
        }
        if (is_bcs(game->header)) {
            fputc('k', file);
            x++;
        }
        if (is_bcl(game->header)) {
            fputc('q', file);
            x++;
        }
        if (!x)
            fputc('-', file);

        fputc(' ', file);
        if (game->ep) {
            fputc('a' + game->ep - 1, file);
            if (c)
                fputc('3', file);
            else
                fputc('6', file);
        } else {
            fputc('-', file);
        }

        fprintf(file, " 0 %d\"]", to_move(game->halfmove));
        break;
    default:
        break;
    }
    fputc('\n', file);
}


/*
 * PGN_RESULT
 *
 * Return the result text in PGN format
 */
static char *
pgn_result(game)
    Game game;
{
    u_char res;

    res = get_result(game->header);
    switch (res) {
    case 0:
        return "0-1";
    case 1:
        return "1/2-1/2";
    case 2:
        return "1-0";
    default:
        return "*";
    }
}
