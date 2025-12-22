/*****************************************************************************
 * ChessBase Companion -  Copyright (c)1993 Andy Duplain
 *
 * File:        cb.h
 *
 * Description: ChessBase-specific functions and defines.
 *
 *****************************************************************************/

#ifndef __CB_H__
#define __CB_H__

/*
 * board offsets:
 *
 *    a  b  c  d  e  f  g  h
 *   +--+--+--+--+--+--+--+--+
 * 8 |07|15|23|31|39|47|55|63| 8
 *   +--+--+--+--+--+--+--+--+
 * 7 |06|14|22|30|38|46|54|62| 7
 *   +--+--+--+--+--+--+--+--+
 * 6 |05|13|21|29|37|45|53|61| 6
 *   +--+--+--+--+--+--+--+--+
 * 5 |04|12|20|28|36|44|52|60| 5
 *   +--+--+--+--+--+--+--+--+
 * 4 |03|11|19|27|35|43|51|59| 4
 *   +--+--+--+--+--+--+--+--+
 * 3 |02|10|18|26|34|42|50|58| 3
 *   +--+--+--+--+--+--+--+--+
 * 2 |01|09|17|25|33|41|49|57| 2
 *   +--+--+--+--+--+--+--+--+
 * 1 |00|08|16|24|32|40|48|56| 1
 *   +--+--+--+--+--+--+--+--+
 *    a  b  c  d  e  f  g  h
 */

/*
 * ChessBase structures
 */

/* key record types */
#define KR_EMPTY_TYPE   0x0000         /* empty record */
#define KR_MASTER_TYPE  0x0100         /* maser block record */
#define KR_KEY_TYPE     0x0201         /* key record */
#define KR_INDEX_TYPE   0x0300         /* index record */

/*
 * The master key record is used to store information about the whole key file
 */

#define MASTER_TITLE_LEN 63
struct kr_master {
    u_long nkeys;                      /* number of keys in key file */
    u_long nrecs;                      /* number of records in key file */
    u_long lastgame;                   /* last games that was classified */
    u_char title[MASTER_TITLE_LEN];    /* title */
};

typedef struct kr_master *KR_master;


/*
 * The key record is used to store information about a specific main or sub key
 */

#define KEY_NAME_LEN 69                /* size of key name (including null
                                          term) */

struct kr_key {
    u_long index;                      /* key index record number (same as
                                          "next") */
    char name[KEY_NAME_LEN];           /* name of key */
};

typedef struct kr_key *KR_key;

/*
 * The index record is used to store indexes to sub keys or games
 */

#define KR_ENTRY_MAX 24                /* number of entries in an index key
                                          record */

struct kr_index {
    u_long entry[KR_ENTRY_MAX];        /* sub key or game indexes */
};

typedef struct kr_index *KR_index;

/* mask for entry record to determine whether sub key or game entry */

#ifdef ANSI_C
#define SUBKEY_MASK     0x00800000UL   /* bit-23 set means sub key */
#define ENTRY_MASK      0x007fffffUL
#else
#define SUBKEY_MASK     0x00800000     /* bit-23 set means sub key */
#define ENTRY_MASK      0x007fffff
#endif

/* structure and union encompassing all key record structures */
struct kr {
    u_short type;                      /* type of record */
    u_long next, prev;                 /* next and previous in chain */
    union {
        struct kr_master m;
        struct kr_key k;
        struct kr_index i;
    } data;
};

typedef struct kr *KR;

/* structure to holds ChessBase file info */

struct database {
    u_long ngames;                     /* number of games in database */
    File cbf;                          /* games file */
    File cbi;                          /* index file */
};

typedef struct database *Database;

/* structure to hold ChessBase game */

struct game {
    u_long num;                        /* game number */
    u_short plen;                      /* players length in "info" */
    u_short slen;                      /* source length in "info" */
    u_short mlen;                      /* moves length in "moves" */
    u_short clen;                      /* comments length in "comments" */
    u_char header[14];                 /* packed header */
    u_char pinfo[65];                  /* player info */
    u_char sinfo[65];                  /* source info */
    u_char *moves;                     /* packed moves */
    u_char *comments;                  /* packed comments */
    u_char board[64];                  /* initial board position */
    u_short year;                      /* unpacked year */
    u_short w_elo;                     /* unpacked white ELO */
    u_short b_elo;                     /* unpacked black ELO */
    u_short nmoves;                    /* number of moves in game */
    u_short halfmove;                  /* first halfmove number */
    u_char ep;                         /* en-passant mask */
    u_char eco_letter;                 /* 'A' - 'E' of ECO code */
    u_char eco_main;                   /* main ECO code (0-99) */
    u_char eco_sub;                    /* sub ECO code (0-99)  */
};

typedef struct game *Game;

/* structure to hold ChessBase game during sort operation */

struct game_sort {
    u_long index;                      /* index of game in database */
    u_char pinfo[65];                  /* players info */
    u_char sinfo[65];                  /* source info */
    u_short wplayer_len;               /* length of White player name, or 0 */
    u_short bplayer_off;               /* offset of Black player in "pinfo" */
    u_short year;                      /* year game played */
    u_short nmoves;                    /* number of moves */
    u_short eco;                       /* ECO code */
    u_short round[3];                  /* round values */
};

typedef struct game_sort *GameSort;

/* structure to hold moves in the movelist */

struct move {
    u_char from;
    u_char to;
    u_char prom;
};

typedef struct move *Move;

#define NMOVELIST 128                  /* number of entries in movelist */
#define MOVELIST_SZ (NMOVELIST * sizeof(struct move))

/* signals passed to the function called by process_moves() when the start
   and end of variations are found */
#define START_VAR_SIGNAL        -1
#define END_VAR_SIGNAL          -2

/* pieces */

#define KING 1
#define QUEEN 2
#define KNIGHT 3
#define BISHOP 4
#define ROOK 5
#define PAWN 6

/* various flags defines */

#define ENPASSANT       0x0001
#define PROMOTION       0x0002
#define SHORT_CASTLE    0x0004
#define LONG_CASTLE     0x0008
#define CAPTURE         0x0010
#define CHECK           0x0020
#define MATE            0x0040
#define KINGSIDE        0x0080
#define QUEENSIDE       0x0100
#define WHITESIDE       0x0200
#define BLACKSIDE       0x0400
#define WHITESQUARE     0x0800
#define BLACKSQUARE     0x1000

/* macros to read/write ChessBase game header (pass in address of header) */
#define get_result(x) (x[1])
#define set_result(x, n) (x[1] = (u_char)n)
#define is_partial(x) (x[10] & 0x01)
#define is_full(x) (!is_partial(x))
#define set_partial(x) (x[10] |= 0x01)
#define set_full(x) (x[10] &= ~0x01)
#define get_tomove(x) (x[10] & 0x02 ? 1 : 0)
#define set_tomove(x, n) { if (n) x[10] |= 0x02; else x[10] &= ~0x02; }
#define is_wcl(x) (x[10] & 0x04)
#define is_wcs(x) (x[10] & 0x08)
#define is_bcl(x) (x[10] & 0x10)
#define is_bcs(x) (x[10] & 0x20)
#define set_wcl(x, n) { if (n) x[10] |= 0x04; else x[10] &= ~0x04; }
#define set_wcs(x, n) { if (n) x[10] |= 0x08; else x[10] &= ~0x08; }
#define set_bcl(x, n) { if (n) x[10] |= 0x10; else x[10] &= ~0x10; }
#define set_bcs(x, n) { if (n) x[10] |= 0x20; else x[10] &= ~0x20; }
#define is_marked(x) (x[10] & 0x40)
#define set_marked(x) (x[10] |= 0x40)
#define clr_marked(x) (x[10] &= ~0x40)
#define is_deleted(x) (x[10] & 0x80)
#define set_deleted(x) (x[10] |= 0x80)
#define clr_deleted(x) (x[10] &= ~0x80)
#define get_plen(x) (x[4] & 0x3f)
#define set_plen(x, n) { x[4] &= ~0x3f; x[4] |= n & 0x3f; }
#define get_slen(x) (x[5] & 0x3f)
#define set_slen(x, n) { x[5] &= ~0x3f; x[5] |= n & 0x3f; }
#define get_nmoves(x) (x[12])
#define set_nmoves(x, n) (x[12] = (u_char)n)
#define get_ep(x) (x[11] & 0x0f)
#define set_ep(x, n) { x[11] &= ~0x0f; x[11] |= n & 0x0f; }
#define get_eco1(x) ((x[10] & 0x3e) >> 1) | ((x[4] & 0xc0) >> 1) | ((x[5] & 0xc0) << 1)
#define get_eco2(x) (x[11] & 0x3f) | ((x[11] & 0x80) >> 1)
#define set_eco1(x, n) { x[10] &= ~0x3e; x[10] |= (n << 1) & 0x3e; \
                         x[4] &= ~0xc0; x[4] |= (n << 1) & 0xc0; \
                         x[5] &= ~0xc0; x[5] |= (n >> 1) & 0xc0; }
#define set_eco2(x, n) { x[11] &= ~0x3f; x[11] |= n & 0x3f; \
                         x[11] &= ~0x80; x[11] |= (n << 1) & 0x80; }

/* board macros */

#define to_offset(f,r) (((f)<<3)+((r)&7))
#define to_file(o) (((o)>>3)&7)
#define to_rank(o) ((o)&7)

/* conversion macros */
#define to_halfmove(m,c) (((m) * 2) - ((c) ? 0 : 1))
#define to_move(h) (((h) + 1) / 2)
#define to_colour(h) (((h) & 1) ? 0 : 1)

/* Items in game header that define the order of the sort operation */
typedef enum {
    NOORDER, W_PLAYER, B_PLAYER, SOURCE, YEAR, ECO, NMOVES, ROUND
} Order;
#define MAX_ORDER 8                    /* number of possible sort criteria */

#endif                                 /* __CB_H__ */
