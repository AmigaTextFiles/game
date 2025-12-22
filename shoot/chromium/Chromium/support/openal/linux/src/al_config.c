/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_config.c
 *
 * Handling of the configuration file and alrc configuration variables.
 *
 * FIXME: make thread safe
 *        needs to be more robust.
 *        leaks memory
 *        needs gc
 *
 */
#include "al_siteconfig.h"

#include "al_main.h"
#include "al_ext.h"
#include "al_config.h"
#include "al_error.h"
#include "al_debug.h"

#include <AL/altypes.h>

#include <ctype.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

#include <string.h>

#define _AL_FNAME "openalrc"

#define LISP_OPEN  '('
#define LISP_CLOSE ')'
#define LISP_QUOTE '\''
#define DOUBLEQUOTE '"'

#ifndef PATH_MAX
#define PATH_MAX 4096
#endif

#define MAXSYMBOLS     30

#define islisp(c)  ((c == LISP_OPEN) || (c == LISP_CLOSE))
#define	isquote(c) (c == LISP_QUOTE)

/* procedures or primitives that return values */
typedef AL_rctree *(*func)(AL_rctree *args);

/* symbols */
typedef struct _AL_SymbolTable {
	char str[ALRC_MAXSTRLEN + 1];
	AL_rctree *datum;

	struct _AL_SymbolTable *left;
	struct _AL_SymbolTable *right;
} AL_SymbolTable;

#if 0
/* potential (non-env specific) locations of the config file */
static const char *rcdirs[] = {
    "/etc/",
    NULL
};
#endif

static AL_rctree *root = NULL;
static AL_SymbolTable *global_symbols;

/*
 * get any openalrc file and return it's contents.
 */
static char *_alOpenRcFile(void);

/*
 * generate tree from rcbuf, which contains a slurped file
 */
static AL_rctree *_alGenerateTree(const char *rcbuf);

/*
 * Evaluate a tree, updating global bindings, etc
 */
static AL_rctree *_alEvalTree(AL_rctree *head);

/* allocate a new symbol table object */
AL_SymbolTable *_alSymbolTableAlloc(void);

/* adds binding for symbol named by str to table*/
AL_SymbolTable *_alSymbolTableAdd(AL_SymbolTable *table,
				const char *symname, AL_rctree *datum);

/* helper function for _alGlobalBinding */
AL_rctree *_alSymbolTableGet(AL_SymbolTable *head, const char *str);

/* destroy the symbol table head */
static void _alSymbolTableDestroy(AL_SymbolTable *head);

/* puts token in buf, returns number of chars, -1 on error */
int gettokenstr(const char *rcbuf, unsigned int *offset, char *buf);

/*
 * advances *offset until rcbuf[*offset] is either NUL or contains one of
 * the characters in stop.
 *
 * offset is a pointer to the offset which the function should start
 * at, and is updated to reflect the terminating case.
 *
 * stop is a NUL terminated character string.
 */
void advance_until(const char *rcbuf, unsigned int *offset, const char *stop);

/*
 * advances *offset until rcbuf[*offset] is NUL or rcbuf[*offset] is not a 
 * character in nostop.
 */
void advance_while(const char *rcbuf, unsigned int *offset, const char *nostop);

/* grab token from stream buf, setting offset */
static AL_rctree *gettoken(const char *buf, unsigned int *offset);

/* add token newarg as an argument to head */
static AL_rctree *AL_rctree_argadd(AL_rctree *head, AL_rctree *newarg);

/* convert tokenname from str to token */
static AL_rctree *token_str_to_token(const char *tokenname);

/* helper functions */
static ALboolean is_string(const char *tokenname);
static ALboolean is_int(const char *tokenname);
static ALboolean is_number(const char *tokenname);
static ALboolean is_boolean(const char *tokenname);
static ALboolean is_true(const char *tokenname);
static ALboolean is_false(const char *tokenname);

AL_rctree *AL_rctree_copy(AL_rctree *dst, AL_rctree *src);

/* primitives */
static const AL_rctree *and_prim(AL_rctree *args);
static AL_rctree *let_prim(AL_rctree *args);
static AL_rctree *define_prim(AL_rctree *args);
static const AL_rctree *load_ext_prim(AL_rctree *args);
static AL_rctree *set_car_prim(AL_rctree *args);
static AL_rctree *set_cdr_prim(AL_rctree *args);

/* symbols to be defined as primitives */
static struct _global_table {
	char *symname;
	void *datum;
} global_primitive_table[] = {
	{ "and",             (void *) and_prim      },
	{ "let",             (void *) let_prim      },
	{ "define",          (void *) define_prim   },
	{ "load-extension",  (void *) load_ext_prim },
	{ "set-car!",        (void *) set_car_prim  },
	{ "set-cdr!",        (void *) set_cdr_prim  },
	{  NULL,  NULL }
};

/* string defining the default environment */
static const char *default_environment = 
	"(define speaker-num 2)"
	"(define display-banner #t)"
	"(define source-gain 1.0)";

/* invalid is returned as an error for functions returning
 * AL_rctree (not AL_rctree *) structures */
const AL_rctree scmfalse    = { ALRC_TAG,
			     ALRC_BOOL,
			     AL_FALSE,
			     { 0 },
			     NULL,
			     NULL };
const AL_rctree scmtrue     = { ALRC_TAG,
			     ALRC_BOOL,
			     AL_FALSE,
			     { 1 },
			     NULL,
			     NULL };

/* FIXME: clean this mess up */
ALboolean _alParseConfig(void) {
	ALboolean retval;
	char *rcbuf;
	int i;
	AL_rctree *temp;

	if(root != NULL) {
		/* already been here */
		return AL_TRUE;
	}
	
	for(i = 0; global_primitive_table[i].symname != NULL; i++) {
		temp = _alRcTreeAlloc();

		temp->type = ALRC_PRIMITIVE;
		temp->data.misc = global_primitive_table[i].datum;
		temp->args      = NULL;
		temp->next      = NULL;

		global_symbols = _alSymbolTableAdd(global_symbols,
				   global_primitive_table[i].symname,
				   temp);
	}

	/* now, evaluate our default environment */
	root = _alGenerateTree(default_environment);
	temp = _alEvalTree(root);
	if(temp == NULL) {
		debug(ALD_CONFIG, __FILE__, __LINE__, "Invalid default");
		return AL_FALSE;
	}

	_alRcTreeDestroyListArgs(root);
	root = NULL;

	/* now, parse user's config */
	rcbuf = _alOpenRcFile();
	if(rcbuf == NULL) {
		return AL_FALSE;
	}
	root = _alGenerateTree(rcbuf);
	temp = _alEvalTree(root);

	retval = AL_TRUE;
	if(temp == NULL) {
		retval = AL_FALSE;
	}

	_alRcTreeDestroyListArgs(root);
	root = NULL;

	free(rcbuf);

	return retval;
}

static char *_alOpenRcFile(void) {
	FILE *fh = NULL;
	static char pathname[PATH_MAX];
	char *retval = NULL;
	struct stat buf;
	int i;
	ALboolean got_a_rc_file = AL_FALSE;
	unsigned long filelen = 0;

	/*
	 * try home dir
	 */
	sprintf(pathname, "%s/.%s", getenv("HOME"), _AL_FNAME);
	if(stat(pathname, &buf) != -1) {
		fh = fopen(pathname, "rb");
		if(fh != NULL) {
			got_a_rc_file = AL_TRUE;
		}
			
		/* for later malloc, get size */
		filelen = buf.st_size;
	}

	if(fh == NULL) {
		return NULL;
	}

	retval = malloc(filelen + 1);
	if(retval == NULL) {
		return NULL;
	}
		
	fread(retval, filelen, 1, fh);
	retval[filelen] = '\0';

	fclose(fh);

	i = strlen(retval);

	/* trim newlines */
	while(retval[--i] == '\n') {
		retval[i] = '\0';
	}

	return retval;
}

/* fixme: leaks mem */
static AL_rctree *_alGenerateTree(const char *rcbuf) {
	AL_rctree *retval = NULL;
	AL_rctree *temp;
	unsigned int offset = 0;

	if(rcbuf == NULL) {
		return NULL;
	}

	/* the tree's root is an 'and' expression */
	retval = _alRcTreeAlloc();
	retval->type = ALRC_LIST;

	temp               = _alRcTreeAlloc();
	temp->type         = ALRC_SYMBOL;
	sprintf(temp->data.str.c_str, "and");
	temp->data.str.len = 3;

	retval = AL_rctree_argadd(retval, temp);

	while((temp = gettoken(rcbuf, &offset))) {
		retval = AL_rctree_argadd(retval, temp);
	}

	return retval;
}

static AL_rctree *gettoken(const char *buf, unsigned int *offset) {
	char tokstr[ALRC_MAXSTRLEN];
	AL_rctree *retval = NULL;
	int toklen;

	if((buf == NULL) || (offset == NULL)) {
		return NULL;
	}

	toklen = gettokenstr(buf, offset, tokstr);
	if(toklen == -1) {
		return NULL;
	}

	retval = token_str_to_token(tokstr);

	return retval;
}

static AL_rctree *AL_rctree_argadd(AL_rctree *head, AL_rctree *newarg) {
	AL_rctree *itr;

	if(head == NULL) {
		if(newarg == NULL) {
			return NULL;
		}

		return newarg; /* arg is the new head */
	}

	itr = head->args;
	while(itr && itr->next) {
		itr = itr->next;
	}

	if(itr == NULL) {
		/* head->args was NULL */
		head->args = newarg;
	} else {
		/* append new arg */
		itr->next = newarg;
	}

	return head;
}

/*
 * How ugly is this?
 * converts a string representation into a token of type AL_rctree.  
 */
static AL_rctree *token_str_to_token(const char *tokenbuf) {
	AL_rctree *retval;
	AL_rctree *temp;
	ALuint suboffset = 0;
	char *tokenptr;

	if(tokenbuf == NULL) {
		return NULL;
	}

	/* evil hack to turn off const */
	memcpy(&tokenptr, &tokenbuf, sizeof(tokenbuf));

	retval = _alRcTreeAlloc();
	if(retval == NULL) {
		return NULL;
	}

	if(isquote(*tokenptr)) {
		retval->isquoted = AL_TRUE;
		tokenptr++;
	}


	if(*tokenptr == LISP_OPEN) {
		retval->type = ALRC_LIST;
		retval->data.misc = NULL;

		suboffset = 1;
		while((temp = gettoken(tokenptr, &suboffset)) != NULL) {
			retval = AL_rctree_argadd(retval, temp);
		}
	} else if(is_number(tokenptr) == AL_TRUE) {
		if(is_int(tokenptr) == AL_TRUE) {
			retval->type   = ALRC_INTEGER;
			retval->data.i = atoi(tokenptr);
		} else {
			retval->type   = ALRC_FLOAT;
			retval->data.f = atof(tokenptr);
		}
	} else if(is_string(tokenptr) == AL_TRUE) {
		retval->type           = ALRC_STRING;

		/* skip initial and final quote */
		strncpy(retval->data.str.c_str, tokenptr+1, ALRC_MAXSTRLEN);

		retval->data.str.len   = strlen(tokenptr) - 2;
	} else if(is_boolean(tokenptr) == AL_TRUE) {
		if(is_true(tokenptr) == AL_TRUE) {
			*retval = scmtrue;
		} else {
			*retval = scmfalse;
		}
	} else {
		/* it's a symbol */
		retval->type	       = ALRC_SYMBOL;

		strncpy(retval->data.str.c_str, tokenptr, ALRC_MAXSTRLEN);
		retval->data.str.len   = strlen(tokenptr);
	}

	return retval;
}

ALboolean is_number(const char *tokenname) {
	int i = strlen(tokenname);
	int c;

	while(i--) {
		c = tokenname[i];

		if((isdigit(c) == 0) && 
			(c != '-')   &&
			(c != '.')) {
			return AL_FALSE;
		}
	}

	return AL_TRUE;
}

ALboolean is_int(const char *tokenname) {
	int i = strlen(tokenname);
	int c;

	while(i--) {
		c = tokenname[i];

		if(isdigit(c) == 0) {
			return AL_FALSE;
		}
	}

	return AL_TRUE;
}

ALboolean is_string(const char *tokenname) {
	int i = strlen(tokenname);
	int c;

	if(tokenname[0] != '"') {
		return AL_FALSE;
	}

	while(i--) {
		c = tokenname[i];

		if((isgraph(c) == 0) &&
		   (isspace(c) == 0)) {
			debug(ALD_CONFIG, __FILE__, __LINE__,
				"tokenname %s failed at %d '%c'",
				tokenname, i, tokenname[i]);

			return AL_FALSE;
		}
	}

	return AL_TRUE;
}

static ALboolean is_boolean(const char *tokenname) {
	if(is_true(tokenname) == AL_TRUE) {
		return AL_TRUE;
	}
	if(is_false(tokenname) == AL_TRUE) {
		return AL_TRUE;
	}

	return AL_FALSE;
}

static ALboolean is_true(const char *tokenname) {
	if(strcmp(tokenname,  "#t") == 0) {
		return AL_TRUE;
	}

	return AL_FALSE;
}

static ALboolean is_false(const char *tokenname) {
	if(strcmp(tokenname,  "#f") == 0) {
		return AL_TRUE;
	}

	return AL_FALSE;
}

int gettokenstr(const char *rcbuf, unsigned int *offset, char *retbuf) {
	unsigned int start = 0;
	int len;

	if((rcbuf == NULL) || (offset == NULL)) {
		return -1;
	}

	/* skip over initial whitespace */
	advance_while(rcbuf, offset, " \t\r\n");
	if(rcbuf[*offset] == ';') {
		/*
		 * if semi-colon, it's a comment, so we chomp until
		 * the newline
		 */
		advance_until(rcbuf, offset, "\n");
		return gettokenstr(rcbuf, offset, retbuf);
	}

	start = *offset;

	if(isquote(rcbuf[*offset]) || islisp(rcbuf[*offset])) {
		/* quoted argument */
		if(isquote(rcbuf[*offset]))  {
			(*offset)++; /* skip quote */
		}

		if(rcbuf[*offset] == LISP_OPEN) {
			int lisp_count = 0; /* ++ for (, -- for ) */

			/* copy until close */
			do {
				switch(rcbuf[*offset]) {
					case LISP_OPEN:
					  lisp_count++;
					  break;
					case LISP_CLOSE:
					  lisp_count--;
					  break;
					default:
					  break;
				}
				(*offset)++;
			} while(lisp_count > 0);
		} else {
			/* quoted symbol: not really meaningful? */
			advance_until(rcbuf, offset, " \t()\r\n");
		}
	} else {
		if(rcbuf[*offset] == DOUBLEQUOTE) {
			/* we've got a string. */
			(*offset)++;

			advance_until(rcbuf, offset, "\"");

			/* we want the closing '"'. */
			(*offset)++;
		} else {
			/* normal copying */
			advance_until(rcbuf, offset, " \t()\r\n");
		}
	}

	len = *offset - start;
	if(len == 0) {
		return -1;
	}
	if(len >= ALRC_MAXSTRLEN) {
		/* sanity check.  No tokens > ALRC_MAXSTRLEN */
		len = ALRC_MAXSTRLEN;
	}

	strncpy(retbuf, &rcbuf[start], len);
	retbuf[len] = '\0';

	return len;
}

AL_rctree *_alGlobalBinding(const char *str) {
	return _alSymbolTableGet(global_symbols, str);
}

AL_rctree *_alSymbolTableGet(AL_SymbolTable *head, const char *str) {
	int i;

	if(head == NULL) {
		return NULL;
	}

	i = strncmp(head->str, str, ALRC_MAXSTRLEN);

	if(i < 0) {
		return _alSymbolTableGet(head->left, str);
	} else if (i == 0) {
		return head->datum;
	} else if (i > 0) {
		return _alSymbolTableGet(head->right, str);
	}

	return NULL;
}

AL_SymbolTable *_alSymbolTableAdd(AL_SymbolTable *head,
				const char *symname, AL_rctree *datum) {
	int i;
	
	if(head == NULL) {
		head = _alSymbolTableAlloc();

		strncpy(head->str, symname, ALRC_MAXSTRLEN);

		head->datum = datum;

		return head;
	}

	i = strncmp(head->str, symname, ALRC_MAXSTRLEN);
	if(i < 0) {
		head->left = _alSymbolTableAdd(head->left, symname, datum);
		return head;
	}
	if(i == 0) {
		strncpy(head->str, symname, ALRC_MAXSTRLEN);

		head->datum = datum;

		return head;
	}
	if(i > 0) {
		head->right = _alSymbolTableAdd(head->right, symname, datum);
		return head;
	}

	return NULL;
}

AL_SymbolTable *_alSymbolTableAlloc(void) {
	AL_SymbolTable *retval;

	retval = malloc(sizeof *retval);
	if(retval == NULL) {
		return NULL;
	}

	memset(retval->str,    0, ALRC_MAXSTRLEN + 1);

	retval->datum = NULL;
	retval->left  = NULL;
	retval->right = NULL;

	return retval;
}

/* FIXME: implement */
static AL_rctree *let_prim(UNUSED(AL_rctree *args)) {
	return NULL;
}

/* define primitive */
static AL_rctree *define_prim(AL_rctree *args) {
	AL_rctree *symbol;
	AL_rctree *retval;

	if((args == NULL) || (args->next == NULL)) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
			"define fail args|args->next %p|%p",
				args, args ? args->next : NULL);

		return NULL;
	}

	symbol = args;
	retval = AL_rctree_copy(NULL, args->next);

	global_symbols = _alSymbolTableAdd(global_symbols,
				symbol->data.str.c_str,
				retval);

	debug(ALD_CONFIG, __FILE__, __LINE__,
			"define %s", symbol->data.str.c_str);

	return retval;
}

/*
 * args       :: our list
 * args->next :: our new car
 */
static AL_rctree *set_car_prim(AL_rctree *args) {
	AL_rctree *symbol = args;
	AL_rctree *newcar = AL_rctree_copy(NULL, args->next);

	newcar->next = symbol->args->next;
	symbol->args = newcar;

	return symbol;
}

/*
 * args       :: our list
 * args->next :: our new cdr
 */
static AL_rctree *set_cdr_prim(AL_rctree *args) {
	AL_rctree *symbol = args;

	symbol->args->next = AL_rctree_copy(NULL, args->next);

	return symbol;
}

/*
 * logically ands arguments.  fails on first invalid.
 */
static const AL_rctree *and_prim(AL_rctree *args) {
	AL_rctree *result;
	AL_rctree *itr;
	AL_rctree *temp;
	ALboolean keepgoing = AL_TRUE;

	itr = args;
	while(itr && (keepgoing == AL_TRUE)) {
		temp = itr->next;

		result = _alEvalTree(itr);

		if(result == NULL) {
			keepgoing = AL_FALSE;

			debug(ALD_CONFIG, __FILE__, __LINE__, "False");
		}

		itr = temp;

	}

	return &scmtrue;
}

void _alDestroyConfig(void) {
	_alSymbolTableDestroy(global_symbols);
	global_symbols = NULL;

	_alRcTreeDestroyAll(); /* gc replacement.  sigh */

	return;
}

static void _alSymbolTableDestroy(AL_SymbolTable *head) {
	if(head == NULL) {
		return;
	}

	if(head->left) {
		_alSymbolTableDestroy(head->left);
	}
	if(head->right) {
		_alSymbolTableDestroy(head->right);
	}

	free(head);

	return;
}


/* FIXME: return #t or something? */
static const AL_rctree *load_ext_prim(AL_rctree *args) {
	static char fname[128]; /* FIXME */
	char *symname;
	int len;

	if(args->type != ALRC_STRING) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
			"syntax error: load_ext_prim passed type is 0x%x",
			args->type);

		return NULL;
	}

	/* skip first and last quote */
	symname = args->data.str.c_str;
	len     = args->data.str.len;

	/* copy data */
	memcpy(fname, symname, len);
	fname[len] = '\0'; 

	if(_alLoadDL(fname) == AL_FALSE) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
			"Couldn't load %s");
		return NULL;
	}

	return &scmtrue;
}

/* fixme: hideous */
void advance_until(const char *rcbuf, unsigned int *offset, const char *stop) {
	int lenstop = strlen(stop);
	int i;

	while(rcbuf[*offset]) {
		for(i = 0; i < lenstop; i++) {
			if(rcbuf[*offset] == stop[i]) {
				return;
			}
		}
		(*offset)++;
	}

	return;
}

/* fixme: hideous
 * 
 * increments *offset until a character in nsch (no-stop characters) is
 * reached, or NUL.
 */
void advance_while(const char *rcbuf, unsigned int *offset, const char *nsch) {
	int lenns = strlen(nsch);
	int i;

	while(rcbuf[*offset]) {
		for(i = 0; (i < lenns) && (rcbuf[*offset] != nsch[i]); i++) {
			continue;
		}
		if(i == lenns) {
			return;
		}
		(*offset)++;
	}

	return;
}

static AL_rctree *_alEvalTree(AL_rctree *head) {
	func evalfunc = NULL;
	AL_rctree *retval;
	AL_rctree *applier;

	if(head == NULL) {
		return NULL;
	}

	if(head->isquoted == AL_TRUE) {
		return head;
	}

	switch(head->type) {
		case ALRC_INVALID:
			return NULL;
			break;
		case ALRC_STRING:
		case ALRC_INTEGER:
		case ALRC_FLOAT:
			/* literals evaluated to themselves */
			return head;
			break;
		case ALRC_SYMBOL:
			/* symbols are looked up, then evaluated */
			retval = _alEvalTree(_alGlobalBinding(head->data.str.c_str));

			if(retval == NULL) {
				debug(ALD_CONFIG, __FILE__, __LINE__,
					"invalid symbol %s",
					head->data.str.c_str);
			}

			return retval;
			break;
		case ALRC_LIST:
			/* lists are either quoted or expressions */
			if(head->isquoted == AL_TRUE) {
				/* sanity check */
				return head;
			}

			if(head->args == NULL) {
				return NULL;
			}

			applier = _alEvalTree(head->args);
			if(applier == NULL) {
				debug(ALD_CONFIG, __FILE__, __LINE__,
					"%s is not a function",
					head->args->data.str.c_str);

				_alRcTreeDestroyListArgs(head);

				return NULL;
			}

			applier->args = head->args->next;
			applier->next = NULL;

			if(applier->type == ALRC_PRIMITIVE) {
				evalfunc = (func) applier->data.misc;
				retval = evalfunc(applier->args);
			} else {
				retval = _alEvalTree(applier);
			}

			_alRcTreeDestroyListArgs(head->args);
			head->args = NULL;

			return retval;
			break;
		case ALRC_PRIMITIVE:
			/* the problem with primitives: the args are attached
			 * to the symbols, but the symbol isn't the primitive
			 * so we need to somehow either pass the args to the
			 * evaltree fork that evals the primitive or propagate
			 * them back to the symbol evaluation
			 */

			return head;
			break;
		default:
			debug(ALD_CONFIG, __FILE__, __LINE__,
				"Unhandled token type %x", head->type);
			

			return NULL;
			break;
	}

	return NULL;
}

AL_rctree *AL_rctree_copy(AL_rctree *dst, AL_rctree *src) {
	if(src == NULL) {
		return NULL;
	}

	if(dst == NULL) {
		dst = _alRcTreeAlloc();
	}

	dst->type = src->type;
	dst->data = src->data;

	if(src->args != NULL) {
		dst->args = AL_rctree_copy(dst->args, src->args);
	}

	if(src->next != NULL) {
		dst->next = AL_rctree_copy(dst->next, src->next);
	}

	return dst;
}

/* 
 *  This is the function that other functions call to get the linkage
 *  between a symbol name and the value it has.  The calling function
 *  has to pass the type information (base type and number of elements).
 *
 *  AL_TRUE if str corresponds to a symbol, AL_FALSE otherwise.  retref
 *  contains the copied data.
 *
 *  FIXME: fill out literal support
 */
ALboolean _alGetGlobalVector(const char *str,
			ALRcEnum type,
			ALuint num,
			void *retref) {
	AL_rctree *sym;
	AL_rctree *list; /* sym's data */
	ALfloat *fvp;
	ALint   *ivp; /* integer interator */
	ALuint i;

	if(retref == NULL) {
		return AL_FALSE;
	}

	sym = _alGlobalBinding(str);
	if((sym == NULL) || (sym->args == NULL)) {
		debug(ALD_CONFIG, __FILE__, __LINE__, "No such symbol %s", str);
		return AL_FALSE;
	}

	list = sym->args;
	if(list == NULL) {
		debug(ALD_CONFIG, __FILE__, __LINE__, "No such symbol %s", str);
		return AL_FALSE;
	}

	switch(type) {
		case ALRC_INTEGER:
		  ivp = retref;

		  for(i = 0; i < num; i++) {
			  if(list == NULL) {
				  return AL_FALSE;
			  }
			  switch(list->type) {
				  case ALRC_INTEGER:
				    ivp[i] = list->data.i;
				    break;
				  case ALRC_FLOAT:
				    ivp[i] = list->data.f;
				    break;
				  default:
				    debug(ALD_CONFIG,
					__FILE__, __LINE__,
					"list->type = 0x%x", list->type);
				    return AL_FALSE;
			  }

			  list = list->next;
		  }
		  return AL_TRUE;
		  break;
		case ALRC_FLOAT:
		  fvp = retref;

		  for(i = 0; i < num; i++) {
			  if(list == NULL) {
				  return AL_FALSE;
			  }
			  switch(list->type) {
				  case ALRC_INTEGER:
				    fvp[i] = list->data.i;
				    break;
				  case ALRC_FLOAT:
				    fvp[i] = list->data.f;
				    break;
				  default:
				    debug(ALD_CONFIG,
					__FILE__, __LINE__,
					"list->type = 0x%x", list->type);
				    return AL_FALSE;
			  }

			  list = list->next;
		  }
		  return AL_TRUE;
		  break;
		default:
		  break;
	}

	return AL_FALSE;
}

/* 
 *  This is the function that other functions call to get the linkage
 *  between a symbol name and the value it has.  The calling function
 *  has to pass the type information (base type and number of elements).
 *
 *  AL_TRUE if str corresponds to a symbol, AL_FALSE otherwise.  retref
 *  contains the copied data.
 *
 *
 *  FIXME: fill out literal support
 */
ALboolean _alGetGlobalScalar(const char *str, ALRcEnum type, void *retref) {
	AL_rctree *sym;
	ALfloat *fvp;
	ALint   *ivp;

	if(retref == NULL) {
		return AL_FALSE;
	}

	/* [fi]vp, the dereference helper */
	fvp = retref;
	ivp = retref;

	sym = _alGlobalBinding(str);
	if(sym == NULL) {
		debug(ALD_CONFIG, __FILE__, __LINE__,
		      "No such symbol %s", str);
		return AL_FALSE;
	}

	switch(sym->type) {
		case ALRC_INTEGER:
		case ALRC_BOOL:
			switch(type) {
				case ALRC_INTEGER:
				case ALRC_BOOL:
					*ivp = sym->data.i;
				case ALRC_FLOAT:
					*fvp = sym->data.i;
				default:
					return AL_FALSE;
			}
			break;
		case ALRC_FLOAT:
			switch(type) {
				case ALRC_INTEGER:
				case ALRC_BOOL:
					*ivp = sym->data.f;
				case ALRC_FLOAT:
					*fvp = sym->data.f;
				default:
					return AL_FALSE;
			}
			break;
		default:
			return AL_FALSE; break;
	}

	return AL_TRUE;
}

/*
 * external linkage eval function
 */
AL_rctree *_alEval(const char *expression) {
	AL_rctree *retval;
	AL_rctree *temp;

	temp = _alGenerateTree(expression);
	if(temp == NULL) {
		return NULL;
	}

	retval = _alEvalTree(temp);

	_alRcTreeDestroyListArgs(temp);

	return retval;
}

AL_rctree *_alDefine(const char *symname, AL_rctree *value) {
	AL_rctree *symbol;

	symbol = _alRcTreeAlloc();

	symbol->type = ALRC_SYMBOL;
	strncpy(symbol->data.str.c_str, symname, ALRC_MAXSTRLEN);

	symbol->next = AL_rctree_copy(NULL, value);

	return define_prim(symbol);
}
