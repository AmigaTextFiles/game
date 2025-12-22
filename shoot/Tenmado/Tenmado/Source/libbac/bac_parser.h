#ifndef BISON_BAC_PARSER_H
# define BISON_BAC_PARSER_H

#ifndef YYSTYPE
typedef union{
  int val_int;
  long int val_long_int;
  char *val_string;
} yystype;
# define YYSTYPE yystype
# define YYSTYPE_IS_TRIVIAL 1
#endif
# define	NEWLINE	257
# define	TAB	258
# define	LONG_INT	259
# define	STRING	260
# define	BEGIN_ENTRY_VERSION	261
# define	BEGIN_COMMENT	262
# define	BEGIN_STAGE_DATA_VERSION	263
# define	BEGIN_WHEN	264
# define	BEGIN_TOTAL_SCORE	265
# define	BEGIN_UID	266
# define	BEGIN_USER_NAME	267
# define	BEGIN_SCORE_SORT	268
# define	BEGIN_SCORE_TOTAL	269
# define	BEGIN_NUMBER_STAGE	270
# define	BEGIN_SCORE_STAGE	271
# define	END_OF_ENTRY	272
# define	LEXICAL_ERROR	273


extern YYSTYPE bac_lval;

#endif /* not BISON_BAC_PARSER_H */
