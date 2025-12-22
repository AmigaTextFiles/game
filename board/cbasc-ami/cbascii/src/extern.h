#ifndef __EXTERN_H__
#define __EXTERN_H__

#include "cblibv.h"                    /* don't include dependancy in
                                          makefile! */

extern Database open_database P__((char *name));
extern Database create_database P__((char *name));
extern Database copy_database P__((Database db, char *name));
extern int rename_database P__((Database db, char *newname));
extern int close_database P__((Database db));
extern int delete_database P__((Database db));
extern int find_database_init P__((char *filespec));
extern char *find_database P__((void));
extern int find_database_exit P__((void));
extern int cmp_game P__((GameSort game1, GameSort game2, Order order[]));
extern u_char gamebuf[];
extern int ignore_chksum_err;
extern int chksum_err;
extern void game_free P__((Game game));
extern void game_tidy P__((Game game));
extern u_long read_index P__((Database db, u_long num));
extern int write_index P__((Database db, u_long num, u_long offset));
extern int read_ngames P__((Database db));
extern int write_ngames P__((Database db));
extern void seek_game P__((Database db, Game game));
extern int read_header P__((Database db, Game game));
extern int write_header P__((Database db, Game game));
extern int read_info P__((Database db, Game game));
extern int write_info P__((Database db, Game game));
extern int read_game P__((Database db, Game game));
extern int write_game P__((Database db, Game game));
extern int read_game_sort P__((Database db, u_long num, GameSort game));
extern char *format_info P__((Game game, int brief));
extern u_long kr_getentry P__((u_char * xe));
extern void kr_putentry P__((u_long value, u_char * xe));
extern int kr_read_all P__((File file));
extern int kr_read P__((File file, u_long recnum));
extern int kr_write P__((File file, u_long recnum));
extern u_char cb_board[];              /* board position */
extern int cb_enpassant;               /* en-passant mask */
extern int comment;                    /* comment available for last move */
extern struct move lastmove;           /* last move made */
extern int lastmove_num;               /* index of last move in movelist */
extern u_short lastmove_flags;         /* interesting move flags (castle,
                                          etc.) */
extern struct move movelist[];         /* list of valid moves for given
                                          position */
extern int moveidx;                    /* number of entries in movelist */
extern int var_level;                  /* current variation level */
extern u_char captured_piece;          /* piece just captured */
extern void init_board P__((u_char * board));
extern int process_moves P__((Game game, int (*func) P__((int halfmove))));
extern int match_moves P__((u_char * mptr1, int len1, u_char * mptr2, int len2));
extern void do_move P__((int from, int to, int prom));
extern char *format_move P__((Move move));
extern void dump_board P__((u_char * board, FILE * outfile));
extern char dump_piece P__((u_char piece));
extern int gen_movelist P__((int colour));
extern int is_check P__((int colour));
extern int is_mate P__((int colour));
extern char *cvt_sym P__((u_char * string));
extern char *cvt_syml P__((u_char * string, int len));
extern char *cvt_eval P__((int sym));
extern char *cvt_poseval P__((int sym));
extern char *cvt_moveval P__((int sym));
extern char *cvt_result P__((int res));
extern char *find_ext P__((char *path));
extern char *kill_ext P__((char *path));
extern int isdir P__((char *dir));
extern int isfile P__((char *file));
extern char *mem_alloc P__((unsigned len));
extern char *derive_name P__((char *name, char *ext));
extern File file_open P__((char *name, char *mode));
extern int file_close P__((File file));
extern int file_delete P__((File file));
#define file_seek(f,o) lseek(f->fd,o,SEEK_SET)
#define file_tell(f) lseek(f->fd,0L,SEEK_CUR)
extern int file_read P__((File file, char *buf, unsigned len));
extern int file_write P__((File file, char *buf, unsigned len));
extern int file_getc P__((File file));
extern int file_putc P__((File file, int c));
extern int file_copy P__((File from, File to));
extern int file_rename P__((File from, char *newname));
extern u_long file_length P__((int fd));
extern u_long read_long P__((File file));
extern int write_long P__((File file, u_long value));
extern u_long c2l P__((u_char * c));
extern u_short c2s P__((u_char * c));
extern void l2c P__((u_char * c, u_long value));
extern void s2c P__((u_char * c, u_short value));
extern int no_error;                   /* flag to turn on/off error reporting */
extern int error P__((char *fmt, ...));
extern int output P__((char *fmt, ...));
extern int hit_return P__((void));
extern int newline P__((void));
extern int spaces P__((int num));
extern int opterr, optind, optopt;
extern char *optarg;
extern u_long range_first P__((char *string));
extern u_long range_last P__((char *string));
extern int getopt P__((int argc, char **argv, char *optstring));
extern long xatol P__((char *s));
extern int xatol_err;
extern char *xatol_ptr;
extern char *xstrdup P__((char *s));
extern int mps_init P__((u_short blocksize));
extern int mps_cleanup P__((void));
extern PTR mps_addblk P__((u_long block));
extern PTR mps_getblk P__((u_long block));
extern int mps_swapblk P__((u_long block1, u_long block2));
extern int mps_copyblk P__((u_long block1, u_long block2));
extern int mps_toblk P__((u_long block, PTR buffer));
extern int mps_fromblk P__((u_long block, PTR buffer));
extern void copy_board P__((u_char *source, u_char *destination));
extern unsigned ustrlen P__((u_char * us));
extern char *xstrdup P__((char *s));
extern void strlower P__((char *s));
extern char *format_movenum P__((unsigned halfmove));
extern char *piece_list;
extern u_char text2piece P__((char c));
extern void tidy_string P__((char *s));
extern char *algebraic P__((int colour));
extern char *get_word P__((char *s, int *len));
extern char *read_listfile P__((FILE * fp));
extern void char_change P__((char *s, char c1, char c2));

#endif                                 /* __EXTERN_H__ */
