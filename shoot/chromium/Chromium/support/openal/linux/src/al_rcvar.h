/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_rcvar.h
 *
 * Stuff related to the Rcvar config interface
 *
 */
#ifndef AL_RCVAR_H_
#define AL_RCVAR_H_

#include "AL/altypes.h"

typedef void *Rcvar; /* lisp-like var */

typedef enum {
	ALRC_INVALID,
	ALRC_PRIMITIVE,
	ALRC_EXPRESSION,
	ALRC_LIST,
	ALRC_SYMBOL,
	ALRC_INTEGER,
	ALRC_FLOAT,
	ALRC_STRING,
	ALRC_BOOL
} ALRcEnum;

Rcvar     rc_lookup(const char *name);
Rcvar     rc_define(const char *symname, Rcvar *val);
Rcvar     rc_eval(const char *str);
ALRcEnum  rc_type(Rcvar sym);
Rcvar     rc_car(Rcvar sym);
Rcvar     rc_cdr(Rcvar sym);
Rcvar     rc_tostr0(Rcvar sym, char *retstr, int len);
Rcvar     rc_symtostr0(Rcvar sym, char *retstr, int len);
ALboolean rc_tobool(Rcvar sym);
ALint     rc_toint( Rcvar sym );

Rcvar rc_copy(Rcvar argp);
Rcvar rc_newlist(Rcvar argp);

#endif /* AL_RCVAR_H_ */
