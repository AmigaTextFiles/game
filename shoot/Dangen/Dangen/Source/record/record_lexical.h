/* $Id: record_lexical.h,v 1.3 2005/06/30 14:22:47 oohara Exp $ */

#ifndef __DANGEN_RECORD_LEXICAL_H__
#define __DANGEN_RECORD_LEXICAL_H__

/* FILE */
#include <stdio.h>

/* yylex */
int record_lex(void);

int record_get_line_number(void);
void record_clear_line_number(void);

void record_read_from_file(FILE *file);
void record_read_from_string(const char *string);

#endif /* not __DANGEN_RECORD_LEXICAL_H__ */
