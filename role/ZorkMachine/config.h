/*
*	@(#)config.h	2.24
*/

# define I_HIST_LEN	1024	/* len of input history	*/
typedef	char ZWORD[2];		/* zmachine word	*/
#ifndef AMIGA
typedef unsigned short UWORD;	/* 16 bit unsigned	*/
#ifndef OSK
typedef short WORD;		/* 16 bit signed	*/
#endif
typedef unsigned char UBYTE;	/* unsigned 8 bit	*/
#else
#include <exec/types.h>
#endif	/* AMIGA */
