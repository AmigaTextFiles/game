/***************************************************************************
 * AIMPORT.C -- Import ASCII data to ChessBase
 *
 * Copyright (c)1993 Andy Duplain.
 *
 * Version      Date            Comments
 * =======      ====            ========
 * 1.0          11/01/94        Initial.
 * 1.1          22/01/94        Added check for ambiguous input move, and
 *                              changed name of variables so as not to
 *                              clash with to_file() and to_rank()!!!
 *                              Added tidy_name().
 * 1.2          09/04/94        Added call to char_change() from tidy_name().
 * 1.3          30/04/94        Added call to tidy_string() from
 *                              get_pgn_header() (for Event/Site), and from
 *                              tidy_name().
 ***************************************************************************/

#include "global.h"
#include "aimport.h"
#include "cbascii.h"
#include "ascan.h"
#include "nag.h"
#include <ctype.h>

/* add_to_field() "type" defines */
#define SOURCE_FIELD    1              /* add to source field */
#define PLAYER_FIELD    2              /* add to player field */

/* "pos" defines */
#define MOVES_SZ        1024
#define COMMS_SZ        16384
static Game game;
static u_char *moves, *moves_ptr;
static unsigned nmoves;
static u_char *comms, *comms_ptr;
static unsigned ncomms;
static char *init_comm;
static u_char *last_comm;
static int comm_full;
static char *wplayer, *bplayer, *event, *site, *round, *annotator;
static int varlev;
static unsigned next_report;
static unsigned game_count, move_count;
static int in_game;
static int init_halfmove;
#define REPORT_INC 5;
static u_char eval, poseval, moveval;

static void setup_game P__((void));
static int parse_game P__((unsigned halfmove));
static int parse_move P__((unsigned halfmove, int token, char *s));
static int test_check P__((int colour, Move moveptr));
static int add_move P__((u_char move));
static int get_file_rank P__((char *s));
static char *format_movetype P__((int token));
static int get_pgn_header P__((int token, char *s));
static void tidy_name P__((char *s));
static int add_info_data P__((void));
static int add_to_field P__((int field, char *data, char *sep, char leadchar,
    char endchar));
static int parse_fen P__((char *s));
static void decode_nag P__((char *s));
static int flush_eval P__((void));
static int add_comment P__((char *s));
static int add_comm P__((u_char comm));

/*
 * IMPORT
 */
int
import()
{
    int res, nerrors;
    u_long gamenum;

    game = (Game) mem_alloc(sizeof(struct game));
    if (!game)
        return -1;
    moves = (u_char *) mem_alloc(MOVES_SZ);
    if (!moves) {
        free(game);
        return -1;
    }
    comms = (u_char *) mem_alloc(COMMS_SZ);
    if (!comms) {
        free(game);
        free(moves);
        return -1;
    }
    gamenum = db->ngames + 1L;
    file_seek(db->cbf, read_index(db, gamenum));

    yyin = file;
    linenum = 1;
    next_report = REPORT_INC;
    game_count = 0;
    nerrors = 0;

    do {
        setup_game();
        res = parse_game(1);
        if (res == 0 || (ignore_errors && res == -1))
            game_count++;

        if (res == 0 && !testmode && ((unsigned) first <= game_count
            && (unsigned) last >= game_count)) {

            game->num = gamenum;
            game->mlen = nmoves;
            if (ncomms > 1)
                game->clen = ncomms;
            if (write_game(db, game) < 0) {
                res = -1;
            }
            db->ngames++;
            write_ngames(db);
            gamenum++;
        }
        if (ignore_errors && res == -1) {
            nerrors++;
            res = 0;
        }
    } while (res == 0);

    if (!quiet) {
        output("game: %u\n", game_count);
        if (ignore_errors) {
            output("%d error%s\n", nerrors,
              nerrors == 1 ? "" : "s");
        }
    }
    if (init_comm)
        free(init_comm);
    game_free(game);
    return 0;
}

/*
 * SETUP_GAME
 *
 * Setup the game structure and reset global variables.
 */
static void
setup_game()
{
    bzero((char *) game, sizeof(struct game));
    bzero((char *) moves, MOVES_SZ);
    bzero((char *) comms, COMMS_SZ);
    game->moves = moves;
    game->comments = comms;
    game->halfmove = 1;
    nmoves = 0;
    ncomms = 1;
    moves_ptr = moves;
    comms_ptr = comms;
    *comms_ptr++ = 0xff;               /* set initial marker */
    if (init_comm)
        free(init_comm);
    init_comm = NULL;
    last_comm = NULL;
    comm_full = 0;
    init_board(cb_board);
    cb_enpassant = 0;
    varlev = 0;
    in_game = 0;
    init_halfmove = 0;
    move_count = 0;
    wplayer = NULL;
    bplayer = NULL;
    event = NULL;
    site = NULL;
    round = NULL;
    annotator = NULL;
    eval = 0;
    poseval = 0;
    moveval = 0;
}

/*
 * PARSE_GAME
 *
 * Parse the moves in a game.
 *
 * Returns: 0 if end of game or variation found, 1 if end of file found,
 *          -1 if error.
 */
static int
parse_game(halfmove)
    unsigned halfmove;
{
    u_char saved_board[64], prev_board[64];
    int saved_ep, prev_ep;
    int i, c, colour;

    if (varlev && !var_strip)
        if (add_move(0xff) < 0)
            return -1;

    while (c = yylex()) {

    /* ignore everything until a game header is seen */
        if (!in_game && !(c >= A_PGN_HEADER_S && c <= A_PGN_HEADER_E))
            continue;

        if (!quiet && game_count >= next_report) {
            output("game: %u\r", game_count);
            next_report += REPORT_INC;
        }
        colour = to_colour(halfmove);

        if (c >= A_PGN_HEADER_S && c <= A_PGN_HEADER_E) {
            if (varlev) {
                error("%s(%u): header in middle of game!",
                  asciiname, linenum);
                return -1;
            }
            if (get_pgn_header(c, yytext) < 0)
                return -1;
            if (init_halfmove)
                halfmove = init_halfmove;
            in_game = 1;
        } else if (c >= A_MOVENUM_S && c <= A_MOVENUM_E) {
            i = atoi(yytext);
            if (!i) {
                error("%s(%u): invalid move number \"%s\"",
                  asciiname, linenum, yytext);
                return -1;
            }
            i = to_halfmove(i, c == A_BLACK_MOVENUM);
            if ((int) halfmove != i) {
                error("%s(%u): expected \"%s\" rather than \"%s\"",
                  asciiname, linenum, format_movenum(halfmove), yytext);
                return -1;
            }
        } else if (c >= A_MOVE_S && c <= A_MOVE_E) {

            flush_eval();

            copy_board(cb_board, prev_board);
            prev_ep = cb_enpassant;

            if (varlev && var_strip) {
                halfmove++;
                continue;
            }
            if (parse_move(halfmove, c, yytext) < 0)
                return -1;
            if (!varlev)
                move_count++;
            halfmove++;

        } else if (c >= A_RESULT_S && c <= A_RESULT_E) {
            break;
        } else if (c == A_COMMENT) {
            if (comm_strip || (varlev && var_strip)) {
                eval = 0;
                poseval = 0;
                moveval = 0;
                continue;
            }
            if (!nmoves) {
                if (!init_comm) {
                    init_comm = xstrdup(yytext);
                    if (!init_comm)
                        return -1;
                }
            } else {
                if (add_comment(yytext) == 0)
                    *(moves_ptr - 1) |= 0x80;
            }
        } else if (c >= A_EVAL_S && c <= A_EVAL_E) {
            switch (c) {
            case A_GOOD_MOVE:
                eval = 1;
                break;
            case A_BAD_MOVE:
                eval = 2;
                break;
            case A_INTERESTING_MOVE:
                eval = 3;
                break;
            case A_DUBIOUS_MOVE:
                eval = 4;
                break;
            case A_BRILLIANT_MOVE:
                eval = 5;
                break;
            case A_BLUNDER_MOVE:
                eval = 6;
                break;
            case A_NAG:
                decode_nag(yytext);
                break;
            default:
                break;
            }
            continue;
        } else if (c == A_VARSTART) {
            if (!nmoves) {
                error("%s(%u): no move for variation!",
                  asciiname, linenum);
                return -1;
            }
            flush_eval();

        /* put the position before the last move was parsed back into the
           global board */
            copy_board(cb_board, saved_board);
            saved_ep = cb_enpassant;
            copy_board(prev_board, cb_board);
            cb_enpassant = prev_ep;

            varlev++;
            if (parse_game(halfmove - 1) < 0)
                return -1;
            varlev--;

        /* restore position before variation */
            copy_board(saved_board, cb_board);
            cb_enpassant = saved_ep;
        } else if (c == A_VAREND) {
            break;
/* the following has to commented out on AMIGAS!! */
#ifndef AMIGA
        } else {
            if (c == '{')
                error("%s(%u): broken comment (unmatched braces ?)",
                  asciiname, linenum);

            else
                error("%s(%u): spurious character '%c'",
                  asciiname, linenum, c);
            return -1;
#endif
        }
    }

    if (!varlev) {
    /* end of main line */
        flush_eval();
        add_info_data();
        if (init_halfmove && to_colour(init_halfmove))
            move_count++;
        game->nmoves = (move_count + 1) / 2;
        if (init_comm) {
            add_comment(init_comm);
            free(init_comm);
            init_comm = NULL;
        }
    } else {
    /* end of variation */
        if (c != A_VAREND) {
            error("%s(%u): end of game in middle of variation",
              asciiname, linenum);
            return -1;
        }
        if (!var_strip) {
            flush_eval();
            if (add_move(0x80) < 0)
                return -1;
        } else {
            eval = 0;
            poseval = 0;
            moveval = 0;
        }
    }

    return c ? 0 : 1;                  /* return 1 if EOF seen */
}

/*
 * PARSE_MOVE
 *
 * Parse a move.
 */
static int
parse_move(halfmove, token, s)
    unsigned halfmove;
    int token;
    char *s;
{
    int i, flags, colour, movenum;
    u_char piece, prom;
    u_char file_from, rank_from, file_to, rank_to, to;
    Move moveptr;

    flags = 0;
    prom = 0;
    movenum = -1;
    file_from = 0xff;
    rank_from = 0xff;
    colour = to_colour(halfmove);

    switch (token) {
    case A_PAWN_MOVE:
    case A_PAWN_MOVE_P:
        piece = PAWN;
        file_to = *s++ - 'a';
        rank_to = *s++ - '1';
        if (token == A_PAWN_MOVE_P) {
            if (*s == '=')
                s++;
            prom = text2piece(*s++);
            flags |= PROMOTION;
        }
        break;
    case A_PAWN_CAPTURE:
    case A_PAWN_CAPTURE_P:
        piece = PAWN;
        file_from = *s++ - 'a';
        if (*s == 'x' || *s == 'X')
            s++;                       /* optional for pawn capture */
        file_to = *s++ - 'a';
        rank_to = *s++ - '1';
        flags |= CAPTURE;
        if (token == A_PAWN_CAPTURE_P) {
            if (*s == '=')
                s++;
            prom = text2piece(*s++);
            flags |= PROMOTION;
        }
        break;
    case A_PIECE_MOVE:
    case A_PIECE_MOVE_F:
    case A_PIECE_MOVE_R:
    case A_PIECE_MOVE_FR:
        piece = text2piece(*s++);
        if (token == A_PIECE_MOVE_F || token == A_PIECE_MOVE_FR) {
            file_from = *s++ - 'a';
        }
        if (token == A_PIECE_MOVE_R || token == A_PIECE_MOVE_FR) {
            rank_from = *s++ - '1';
        }
        file_to = *s++ - 'a';
        rank_to = *s++ - '1';
        break;
    case A_PIECE_CAPTURE:
    case A_PIECE_CAPTURE_F:
    case A_PIECE_CAPTURE_R:
    case A_PIECE_CAPTURE_FR:
        piece = text2piece(*s++);
        if (token == A_PIECE_CAPTURE_F || token == A_PIECE_CAPTURE_FR) {
            file_from = *s++ - 'a';
        }
        if (token == A_PIECE_CAPTURE_R || token == A_PIECE_CAPTURE_FR) {
            rank_from = *s++ - '1';
        }
        s++;                           /* 'x' or 'X' */
        file_to = *s++ - 'a';
        rank_to = *s++ - '1';
        flags |= CAPTURE;
        break;
    case A_SHORT_CASTLE:
        piece = KING;
        if (colour) {                  /* black */
            file_from = 4;
            rank_from = 7;
            file_to = 6;
            rank_to = 7;
        } else {                       /* white */
            file_from = 4;
            rank_from = 0;
            file_to = 6;
            rank_to = 0;
        }
        flags |= SHORT_CASTLE;
        s += 3;
        break;
    case A_LONG_CASTLE:
        piece = KING;
        if (colour) {                  /* black */
            file_from = 4;
            rank_from = 7;
            file_to = 2;
            rank_to = 7;
        } else {                       /* white */
            file_from = 4;
            rank_from = 0;
            file_to = 2;
            rank_to = 0;
        }
        flags |= LONG_CASTLE;
        s += 5;
        break;
    default:
        error("parse_move(): invalid token %d", token);
        return -1;
    }

    to = to_offset(file_to, rank_to);
    if (colour)
        piece |= 8;

    gen_movelist(colour);

    for (i = 0; i < moveidx; i++) {
        moveptr = &movelist[i];

        if (moveptr->to != to)
            continue;
        if ((u_char) cb_board[moveptr->from] != piece)
            continue;
        if (file_from != 0xff &&
          (u_char) to_file(moveptr->from) != file_from)
            continue;
        if (rank_from != 0xff &&
          (u_char) to_rank(moveptr->from) != rank_from)
            continue;
        if (flags & PROMOTION && moveptr->prom != prom)
            continue;
        if (test_check(colour, moveptr))
            continue;
        movenum = i;
        break;
    }

    if (movenum == -1) {
        error("%s(%u): illegal %s \"%s%s\"", asciiname, linenum,
          format_movetype(token), format_movenum(halfmove), yytext);
        dump_board(cb_board, stdout);
        return -1;
    }
 /* check if the move is ambiguous by looking for another... */
    if (file_from == 0xff && rank_from == 0xff) {
        for (i = movenum + 1; i < moveidx; i++) {
            moveptr = &movelist[i];

            if (moveptr->to != to)
                continue;
            if ((u_char) cb_board[moveptr->from] != piece)
                continue;
            if (file_from != 0xff &&
              (u_char) to_file(moveptr->from) != file_from)
                continue;
            if (rank_from != 0xff &&
              (u_char) to_rank(moveptr->from) != rank_from)
                continue;
            if (flags & PROMOTION && moveptr->prom != prom)
                continue;
        /* file specified, and this file not the same */
            if (file_from != 0xff &&
              (to_file(moveptr->from) != to_file(movelist[i].from)))
                continue;
        /* rank specified, and this rank not the same */
            if (rank_from != 0xff &&
              (to_rank(moveptr->from) != to_rank(movelist[i].from)))
                continue;
            if (test_check(colour, moveptr))
                continue;
        /* must be ambiguous */
            error("%s(%u): ambiguous %s \"%s%s\"", asciiname,
              linenum, format_movetype(token),
              format_movenum(halfmove), yytext);
            dump_board(cb_board, stdout);
            return -1;
        }
    }
    moveptr = &movelist[movenum];
    do_move(moveptr->from, moveptr->to, moveptr->prom);
    if (add_move((u_char) (movenum + 1)) < 0)
        return -1;

    if (flags & CAPTURE) {
        if (!(lastmove_flags & CAPTURE))
            output("%s(%u): \"%s%s\" is not a capture!\n",
              asciiname, linenum, format_movenum(halfmove),
              yytext);
    } else {
        if (lastmove_flags & CAPTURE)
            output("%s(%u): \"%s%s\" is a capture!\n",
              asciiname, linenum, format_movenum(halfmove),
              yytext);
    }

    return 0;
}

/*
 * TEST_CHECK
 *
 * Test if a move is illegal because it results in check.
 */
static int
test_check(colour, moveptr)
    int colour;
    Move moveptr;
{
    u_char saved_board[64];
    int saved_ep, ret;

    colour = colour ? 0 : 8;           /* reverse colour */
    copy_board(cb_board, saved_board);
    saved_ep = cb_enpassant;
    do_move(moveptr->from, moveptr->to, moveptr->prom);
    ret = is_check(colour);
    cb_enpassant = saved_ep;
    copy_board(saved_board, cb_board);
    return ret;
}

/*
 * ADD_MOVE
 *
 * Add a move to the movelist.
 */
static int
add_move(move)
    u_char move;
{
    if (nmoves >= MOVES_SZ) {
        error("%s(%u): move buffer full!", asciiname, linenum);
        return -1;
    }
    *moves_ptr++ = move;
    nmoves++;
    return 0;
}

/*
 * FORMAT_MOVETYPE
 *
 * Return a string which describes the type of move parsed, based on the
 * token returned from (f)lex.
 */
static char *
format_movetype(token)
    int token;
{
    switch (token) {
    case A_PAWN_MOVE:
        return "pawn move";
    case A_PAWN_MOVE_P:
        return "pawn promotion";
    case A_PAWN_CAPTURE:
        return "pawn capture";
    case A_PAWN_CAPTURE_P:
        return "pawn capture and promotion";
    case A_PIECE_MOVE:
    case A_PIECE_MOVE_F:
    case A_PIECE_MOVE_R:
    case A_PIECE_MOVE_FR:
        return "piece move";
    case A_PIECE_CAPTURE:
    case A_PIECE_CAPTURE_F:
    case A_PIECE_CAPTURE_R:
    case A_PIECE_CAPTURE_FR:
        return "piece capture";
    case A_SHORT_CASTLE:
        return "kingside castle";
    case A_LONG_CASTLE:
        return "queenside castle";
    default:
        return "move";
    }
}

/*
 * GET_PGN_HEADER
 *
 * Extract data from a PGN header field.
 */
static int
get_pgn_header(token, s)
    int token;
    char *s;
{
    char *data, *cptr;
    int len, i;

    while (*s && *s != '"')
        s++;
    if (!*s)
        return -1;
    data = ++s;
    while (*s && *s != '"') {
        if (*s == '\\' && (*(s + 1) == '"' || *(s + 1) == '\\')) {
        /* process escaped quotes or backslashes */
            cptr = s;
            while (*cptr) {
                *cptr = *(cptr + 1);
                cptr++;
            }
        }
        s++;
    }

    if (*s != '"') {
        error("%s(%u): unmatched quotes in PGN header", asciiname,
          linenum);
        return -1;
    }
    *s = '\0';
    len = strlen(data);
    if (!len)
        return 0;
    if (strcmp(data, "?") == 0)
        return 0;

    switch (token) {
    case A_PGN_EVENT:
        event = xstrdup(data);
        if (!event)
            return -1;
        tidy_string(event);
        break;
    case A_PGN_SITE:
        site = xstrdup(data);
        if (!site)
            return -1;
        tidy_string(site);
        break;
    case A_PGN_DATE:
        game->year = atoi(data);
        break;
    case A_PGN_ROUND:
        round = xstrdup(data);
        if (!round)
            return -1;
        break;
    case A_PGN_WHITE:
        wplayer = xstrdup(data);
        if (!wplayer)
            return -1;
        tidy_name(wplayer);
        break;
    case A_PGN_BLACK:
        bplayer = xstrdup(data);
        if (!bplayer)
            return -1;
        tidy_name(bplayer);
        break;
    case A_PGN_RESULT:
        if (strcmp(data, "0-1") == 0)
            i = 0;
        else if (strcmp(data, "1/2-1/2") == 0)
            i = 1;
        else if (strcmp(data, "1-0") == 0)
            i = 2;
        else
            i = 16;
        set_result(game->header, i);
        break;
    case A_PGN_WHITEELO:
        game->w_elo = atoi(data);
        break;
    case A_PGN_BLACKELO:
        game->b_elo = atoi(data);
        break;
    case A_PGN_ECO:
        if (*data >= 'A' && *data <= 'E') {
            game->eco_letter = *data;
        } else if (*data >= 'a' && *data <= 'e') {
            game->eco_letter = *data + 'A' - 'a';
        } else {
            error("%s(%u): invalid ECO code", asciiname, linenum);
            return -1;
        }
        data++;
        if (isdigit(*data) && isdigit(*(data + 1))) {
            game->eco_main = atoi(data);
        } else {
            error("%s(%u): invalid ECO code", asciiname, linenum);
            return -1;
        }
        data += 2;
        if (*data == '/' || *data == '_') {
            data++;
            if (isdigit(*data) && isdigit(*(data + 1))) {
                game->eco_sub = atoi(data);
            } else {
                error("%s(%u): invalid ECO code", asciiname, linenum);
                return -1;
            }
        }
        break;
    case A_PGN_ANNOTATOR:
        annotator = xstrdup(data);
        if (!annotator)
            return -1;
        tidy_name(annotator);
        break;
    case A_PGN_FEN:
        if (parse_fen(data) < 0)
            return -1;
        break;
    default:
        break;
    }
    return 0;
}

/*
 * TIDY_NAME
 *
 * Remove space after comma, remove trailing period.
 */
static void
tidy_name(s)
    char *s;
{
    int len;
    char *cptr;

 /* change all occurances of '-' to '_' */
    char_change(s, '-', '_');

 /* remove space after comma */
    cptr = index(s, ',');
    if (cptr) {
        if (*(cptr + 1) == ' ') {
            cptr++;
            len = strlen(cptr + 1);
            strncpy(cptr, cptr + 1, len);
            *(cptr + len) = '\0';
        }
    }
 /* remove space before comma */
    cptr = index(s, ',');
    if (cptr) {
        if (*(cptr - 1) == ' ') {
            cptr--;
            len = strlen(cptr + 1);
            strncpy(cptr, cptr + 1, len);
            *(cptr + len) = '\0';
        }
    }
 /* remove trailing period */
    cptr = s;
    len = strlen(cptr);
    if (len >= 3) {
        cptr += len - 1;
        if (*cptr == '.' && isupper(*(cptr - 1)) && !isalpha(*(cptr - 2)))
            *cptr = '\0';
    }

 /* generally tidy the string */
    tidy_string(s);
}

/*
 * ADD_INFO_DATA
 *
 * Add the captured game information to the game structure.
 */
static int
add_info_data()
{
    if (wplayer) {
        add_to_field(PLAYER_FIELD, wplayer, NULL, 0, 0);
        free(wplayer);
        wplayer = NULL;
    }
    if (bplayer) {
        add_to_field(PLAYER_FIELD, bplayer, "-", 0, 0);
        free(bplayer);
        bplayer = NULL;
    }
 /* check that "event" doesn't contain data from "site" */
    if (event && site) {
        if (strncmp(event, site, strlen(event)) == 0) {
            free(event);
            event = NULL;
        }
    }
    if (event) {
        add_to_field(SOURCE_FIELD, event, NULL, 0, 0);
        free(event);
        event = NULL;
    }
    if (site) {
        add_to_field(SOURCE_FIELD, site, ", ", 0, 0);
        free(site);
        site = NULL;
    }
    if (round) {
        add_to_field(SOURCE_FIELD, round, " ", '(', ')');
        free(round);
        round = NULL;
    }
    if (annotator) {
        add_to_field(SOURCE_FIELD, annotator, " ", '[', ']');
        free(annotator);
        annotator = NULL;
    }
    return 0;
}

/*
 * ADD_TO_FIELD
 *
 * Add data to the game fields in a controlled way.
 *
 * "type" is either "SOURCE_FIELD" or "PLAYER_FIELD",
 * "data" is the string to add,
 * "sep" is the string to add if data already exists in the field,
 * "leadchar" is the character to prefix the added data with,
 * "endchar" is the character to suffix the added data with.
 */
static int
add_to_field(type, data, sep, leadchar, endchar)
    int type;
    char *data, *sep, leadchar, endchar;

{
    u_char *field;
    int ret, len, datalen, seplen;

    ret = 0;
    if (type == SOURCE_FIELD) {
        field = game->sinfo;
        len = game->slen;
    } else if (type == PLAYER_FIELD) {
        field = game->pinfo;
        len = game->plen;
    } else {
        return -1;
    }

    field += len;

    if (len && sep) {
        seplen = strlen(sep);
        if (seplen + len > 47) {
            ret = -1;
            goto quit;
        }
        strcpy((char *) field, sep);
        field += seplen;
        len += seplen;
    }
    if (leadchar) {
        if (len + 1 > 47) {
            ret = -1;
            goto quit;
        }
        *field++ = leadchar;
        len++;
    }
    datalen = strlen(data);
    if (len + datalen > 47)
        datalen = 47 - len;
    if (datalen <= 0) {
        ret = -1;
        goto quit;
    }
    strncpy((char *) field, data, datalen);
    field += datalen;
    len += datalen;

    if (endchar) {
        if (len + 1 > 47) {
            ret = -1;
            goto quit;
        }
        *field++ = endchar;
        len++;
    }
quit:
    if (type == SOURCE_FIELD)
        game->slen = len;
    else if (type == PLAYER_FIELD)
        game->plen = len;
    return ret;
}

/*
 * PARSE_FEN
 *
 * Parse a Forsythe-Edwards Notation string.
 */
static int
parse_fen(s)
    char *s;
{
    int file, rank, colour, move, len;
    u_char piece, *board;
    char *args[6];

    for (file = 0; file < 6; file++) {
        args[file] = get_word(s, &len);
        if (!args[file]) {
            error("%s(%u): not enough arguments in FEN string",
              asciiname, linenum);
            return -1;
        }
        s = args[file] + len;
        *s++ = '\0';
    }

    board = game->board;
    bzero((char *) board, 64);

    s = args[0];
    for (rank = 7; rank >= 0; rank--, s++) {
        for (file = 0; file < 8 && *s && *s != '/'; file++, s++) {
            if (isdigit(*s)) {
                file += (*s - '0') - 1;
                continue;
            } else if (isalpha(*s)) {
                piece = text2piece(*s);
                if (piece != 0xff) {
                    board[to_offset(file, rank)] = piece;
                    continue;
                }
            }
            error("%s(%u): invalid piece list character ('%c') in FEN string",
              asciiname, linenum, *s);
            return -1;
        }
    }
    copy_board(board, cb_board);

    s = args[1];
    if (*s == 'w') {
        colour = 0;
    } else if (*s == 'b') {
        colour = 8;
    } else {
        error("%s(%u): invalid active colour ('%c') in FEN string",
          asciiname, linenum, *s);
        return -1;
    }

    s = args[2];
    if (*s != '-') {
        while (*s) {
            switch (*s) {
            case 'K':
                set_wcs(game->header, 1);
                break;
            case 'Q':
                set_wcl(game->header, 1);
                break;
            case 'k':
                set_bcs(game->header, 1);
                break;
            case 'q':
                set_bcl(game->header, 1);
                break;
            default:
                error("%s(%u): invalid castling availability ('%c') in FEN string",
                  asciiname, linenum, *s);
                return -1;
            }
            s++;
        }
    }
    s = args[3];
    if (*s != '-') {
        if (*s >= 'a' && *s <= 'h') {
            game->ep = *s - 'a' + 1;
            cb_enpassant = game->ep;
        } else {
            error("%s(%u): invalid en-passant file ('%c') in FEN string",
              asciiname, linenum, *s);
            return -1;
        }
        s++;
        if ((colour && *s != '3') || (!colour && *s != '6')) {
            error("%s(%u): invalid en-passant rank ('%c') in FEN string",
              asciiname, linenum, *s);
            return -1;
        }
    }
    s = args[4];
    while (*s) {
        if (!isdigit(*s)) {
            error("%s(%u): invalid halfmove clock number ('%c') if FEN string",
              asciiname, linenum, *s);
            return -1;
        }
        s++;
    }

    s = args[5];
    move = atoi(s);
    if (!move) {
        error("%s(%u): invalid fullmove number in FEN string",
          asciiname, linenum);
        return -1;
    }
    init_halfmove = to_halfmove(move, colour);
    game->halfmove = init_halfmove;
    set_partial(game->header);

    return 0;
}

/*
 * DECODE_NAG
 *
 * Convert a Numeric Annotation Glyph into a value in "eval", "poseval" or
 * "moveval".
 */
static void
decode_nag(s)
    char *s;
{
    int i;
    struct nag *nag;

    i = atoi(s + 1);
    if (*s != '$' || i <= 0 || i > MAX_NAG) {
        error("%s(%u): invalid NAG \"%s\"", asciiname, linenum,
          s);
        return;
    }
    nag = &nags[i];
    switch (nag->var) {
    case VAR_EVAL:
        eval = nag->value;
        break;
    case VAR_POSEVAL:
        poseval = nag->value;
        break;
    case VAR_MOVEVAL:
        moveval = nag->value;
        break;
    default:
        break;
    }
}

/*
 * FLUSH_EVAL
 *
 * Add "eval", "poseval" or "moveval" are non-zero then append a comment
 * to store them, and set bit-7 of the last move.
 */
static int
flush_eval()
{
    if (eval || poseval || moveval) {
        if (comm_full)
            return -1;

        add_comm(eval);
        if (poseval || moveval) {
            add_comm(poseval);
            if (moveval)
                add_comm(moveval);
        }
        add_comm(0xff);
        *(moves_ptr - 1) |= 0x80;
        eval = 0;
        poseval = 0;
        moveval = 0;
    }
    return 0;
}

/*
 * ADD_COMMENT
 *
 * Tidy and insert comments into game data.  Only returns -1 if the comment
 * buffer is full when adding the comment header.
 */
static int
add_comment(s)
    char *s;
{
    int nrows, ncols, len;
    char *word;

    if (comm_full)
        return -1;

 /* store comment markers */
    add_comm((u_char) eval);
    add_comm((u_char) poseval);
    add_comm((u_char) moveval);
    add_comm(0);
    eval = 0;
    poseval = 0;
    moveval = 0;

 /* format 3 rows of 78 characters */
    for (nrows = 0, ncols = 0; nrows < 3; nrows++) {
        while (ncols < 79) {
            word = get_word(s, &len);
            if (!word)
                break;
            if (len > 78) {
                len = (78 - ncols) - (ncols ? 1 : 0);
            } else if (ncols + len + (ncols ? 1 : 0) > 78) {
                if (nrows < 2) {       /* first 2 lines */
                    break;
                } else {               /* last line */
                    len = (78 - ncols) - (ncols ? 1 : 0);
                }
            }
            if (len < 0) {
                len = 0;
                break;
            }
            if (ncols) {
                if (add_comm(' ') < 0)
                    return 0;
                ncols++;
            }
            while (len--) {
                if (add_comm(*word++) < 0)
                    return 0;
                ncols++;
            }
            s = word;
        }
    /* add a newline if first 2 lines and more text to follow */
        if (nrows < 2 && get_word(s, NULL)) {
            if (add_comm(0xfe) < 0)
                return 0;
            ncols = 0;
        }
    }
    add_comm(0xff);
    return 0;
}

/*
 * ADD_COMM
 *
 * Actually put a comment byte into the buffer.
 */
static int
add_comm(comm)
    u_char comm;
{
    if (ncomms >= COMMS_SZ) {
        error("%s(%u): comment buffer full!", asciiname, linenum);
        comm_full++;
        ncomms = COMMS_SZ;
        comms_ptr = comms + (COMMS_SZ - 1);
        *comms_ptr = 0xff;             /* terminate last comment */
        return -1;
    }
    *comms_ptr++ = comm;
    ncomms++;
    return 0;
}
