/* $Id: bac_lexical.h,v 1.3 2003/01/11 19:49:48 oohara Exp $ */

#ifndef __BAC_LEXICAL_H__
#define __BAC_LEXICAL_H__

/* yylex */
int bac_lex(void);

int bac_get_line_number(void);
void bac_clear_line_number(void);
void bac_read_from_file(FILE *file);
void bac_read_from_string(const char *string);
void bac_close_string(void);

#endif /* not __BAC_LEXICAL_H__ */
