/* hi emacs, this is a part of -*- C -*- source */
/* $Id: record_lexical.l,v 1.25 2005/06/30 18:35:21 oohara Exp $ */
/* process this file with flex -Precord_ */

/* definitions */
%option noyywrap
%option nounput

%{
#include <stdio.h>
/* strchr */
#include <string.h>

#include "record_util.h"
#include "record_parser_private.h"

#include "record_lexical.h"

static int line_number = 1;
static int value_int = 0;

static void count_line(const char *string);
%}

/* rules */
/* this comment must be before %% */
%%
(\/\*([^*]|(\*[^/]))*\*\/)|([[:space:]]+) {
  count_line(yytext);
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return SPACE;
}

; {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return SEMICOLON;
}

[+\-]?[0-9]+ {
  /* you can write 7 as 007 for example, but it is always decimal,
   * not octal */
  convert_to_number(&value_int, yytext);
  record_lval.n0 = value_int;
  record_lval.n1 = -1;
  return VALUE_INT;
}

number-play {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return NUMBER_PLAY;
}

end {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return END;
}

plan {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return PLAN;
}

score-max {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return SCORE_MAX;
}

number-clear {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return NUMBER_CLEAR;
}

score-min-cleared {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return SCORE_MIN_CLEARED;
}

total {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return TOTAL;
}

total-score {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return TOTAL_SCORE;
}

stage-id {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return STAGE_ID;
}

stage-score {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return STAGE_SCORE;
}

stage-cleared {
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return STAGE_CLEARED;
}

.|\n {
  /* catch-all */
  record_lval.n0 = -1;
  record_lval.n1 = -1;
  return NO_MATCH;
}
%%
/* user code */
int
record_get_line_number(void)
{
  return line_number;
}

void
record_clear_line_number(void)
{
  line_number = 1;
}

void
record_read_from_file(FILE *file)
{
  /* yyrestart */
  record_restart(file);
}

void
record_read_from_string(const char *string)
{
  /* yy_scan_string */
  record__scan_string(string);
}

static void
count_line(const char *string)
{
  const char *s;

  s = strchr(string, '\n');
  while (s != NULL)
  {
    (line_number)++;
    s = strchr(s + 1, '\n');
  }
}
