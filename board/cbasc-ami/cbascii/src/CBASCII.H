#ifndef __CBASCII_H__
#define __CBASCII_H__

/* "header" and "preset" defines */
#define TYPE_CB 1                      /* ChessBase */
#define TYPE_PGN        2              /* Portable Game Notation (PGN) */

extern int conv;                       /* conversion */
extern int comm_strip;                 /* strip comments */
extern int var_strip;                  /* strip variations */
extern int format;                     /* import / export format */
extern int append;                     /* -a flag */
extern int quiet;                      /* -q flag */
extern int testmode;                   /* -t flag */
extern int ignore_errors;              /* -I flag */
extern int no_nag;                     /* PGN without NAGs */
extern u_long first, last;
extern char *dbname;
extern char *asciiname;
extern Database db;
extern FILE *file;
extern char comm_start;                /* comment start character */
extern char comm_end;                  /* comment end character */
extern char var_start;                 /* variation start character */
extern char var_end;                   /* variation end character */

#endif                                 /* __CBASCII_H__ */
