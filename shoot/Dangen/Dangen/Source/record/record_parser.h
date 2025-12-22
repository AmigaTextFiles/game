#ifndef BISON_RECORD_PARSER_H
# define BISON_RECORD_PARSER_H

# ifndef YYSTYPE
#  define YYSTYPE int
#  define YYSTYPE_IS_TRIVIAL 1
# endif
# define	SPACE	257
# define	SEMICOLON	258
# define	VALUE_INT	259
# define	NUMBER_PLAY	260
# define	END	261
# define	PLAN	262
# define	SCORE_MAX	263
# define	NUMBER_CLEAR	264
# define	SCORE_MIN_CLEARED	265
# define	TOTAL	266
# define	TOTAL_SCORE	267
# define	STAGE_ID	268
# define	STAGE_SCORE	269
# define	STAGE_CLEARED	270
# define	NO_MATCH	271


extern YYSTYPE record_lval;

#endif /* not BISON_RECORD_PARSER_H */
