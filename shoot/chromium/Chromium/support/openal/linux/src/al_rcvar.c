/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_rcvar.c
 *
 * Stuff related to the rcvar configuration interface
 *
 */
#include "al_siteconfig.h"

#include <stdlib.h>
#include <string.h>

#include "AL/altypes.h"

#include "al_config.h"
#include "al_debug.h"
#include "al_rcvar.h"
#include "al_rctree.h"

Rcvar rc_lookup(const char *name) {
	AL_rctree *sym = _alGlobalBinding(name);

	if(sym == NULL) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
		      "No such symbol %s", name);

		return NULL;
	}

	return sym;
}

ALRcEnum rc_type(Rcvar symp) {
	AL_rctree *sym = (AL_rctree *) symp;

	if(sym == NULL) {
		return ALRC_INVALID;
	}

	return sym->type;
}

Rcvar rc_car(Rcvar symp) {
	AL_rctree *sym = symp;

	if(sym == NULL) {
		return NULL;
	}

	if(rc_type(sym) != ALRC_LIST) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
		      "rc_car: needs list, has 0x%x",
		      rc_type(sym));

		return NULL;
	}

	return sym->args;
}

Rcvar rc_cdr(Rcvar symp) {
	AL_rctree *sym = symp;

	if(sym == NULL) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
		      "Not a list");

		return NULL;
	}

	if(rc_type(sym) != ALRC_LIST) {
		return NULL;
	}
	if(sym->args == NULL) {
		return NULL;
	}

	return rc_newlist(sym->args->next);
}

Rcvar rc_tostr0(Rcvar symp, char *retstr, int len) {
	AL_rctree *sym = (AL_rctree *) symp;
	static AL_rctree retval;

	if(sym == NULL) {
		return NULL;
	}

	if(rc_type(sym) != ALRC_STRING) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
		      "Not a string");

		return NULL;
	}

	if(len > sym->data.str.len) {
		len = sym->data.str.len;
	}

	memcpy(retstr, sym->data.str.c_str, len);
	retstr[len] = '\0';

	retval = scmtrue;

	return &retval;
}

Rcvar rc_copy(Rcvar argp) {
	AL_rctree *src = argp;
	AL_rctree *retval = NULL;

	if(src == NULL) {
		return retval;
	}

	if(src->type == ALRC_LIST) {
		rc_newlist(src->args);
	}

	retval = _alRcTreeAlloc();
	*retval = *src;

	return retval;
}

Rcvar rc_newlist(Rcvar argp) {
	AL_rctree *args = (AL_rctree *) argp;
	AL_rctree *retval;

	retval = _alRcTreeAlloc();
	if(retval == NULL) {
		/* do something */
	}

	retval->type = ALRC_LIST;
	retval->args = args;

	return retval;
}

Rcvar rc_symtostr0(Rcvar symp, char *retstr, int len) {
	AL_rctree *sym = (AL_rctree *) symp;
	static AL_rctree retval;

	if(sym == NULL) {
		return NULL;
	}

	if(rc_type(sym) != ALRC_SYMBOL) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
		      "Not a string");

		return NULL;
	}

	if(len > sym->data.str.len) {
		len = sym->data.str.len;
	}

	memcpy(retstr, sym->data.str.c_str, len);
	retstr[len] = '\0';

	retval = scmtrue;

	return &retval;
}

ALboolean rc_tobool(Rcvar symp) {
	AL_rctree *sym = (AL_rctree *) symp;

	if(sym == NULL) {
		return AL_FALSE;
	}

	if(sym->type != ALRC_BOOL) {
		return AL_FALSE;
	}

	return sym->data.i;
}

Rcvar rc_eval(const char *str) {
	return (Rcvar) _alEval(str);
}

Rcvar rc_define(const char *symname, Rcvar *value) {
	return _alDefine(symname, (AL_rctree *) value);
}

ALint rc_toint( Rcvar symp ) {
	AL_rctree *sym = (AL_rctree *) symp;

	ASSERT( sym );

	switch( sym->type ) {
		case ALRC_BOOL:
		case ALRC_INTEGER:
			return sym->data.i;
			break;
		case ALRC_FLOAT:
			return (ALint) sym->data.f;
			break;
		default:
			break;
	}

	return 0;
}
