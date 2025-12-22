						/* SCUMMER */
		
	/* Copyright (C) 2001  Jack Burton aka Stefano Ceccherini */	
						
/*	A program which reads and display images from GREAT old
 *	LucasArts games files. It can display images contained in 
 *	"*.001" files, from MONKEY ISLAND I CD version, MONKEY 
 *	ISLAND II, INDIANA JONES AND THE FATE OF ATLANTIS, 
 *	probably others.											
						
					
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; see docs/LICENSE for further details.
 */

#ifndef blocks_h
#define blocks_h

#include "iostuff.h"
#include <stdarg.h>

Uint32 room_offset (SDL_RWops *f, Uint8 room);
void analyze(SDL_RWops *f);

/*	Returns total rooms number	*/

	Uint8 room_number (SDL_RWops *f);


/*	Search for blocknames, starting from "set" (SEEK_SET, SEEK_CUR,	*
 *	SEEK_END). Accept multiple arguments, and put file index after	* 
 *	block header (block offset 8, where is real data) of any args.	*
 *	Argument list MUST end with "0" (a zero).						*
 *	It returns nothing (to be changed in the future), and put file	*
 *	index after a block header (block offset 8, where is real data).*/
	
	void b_seek (SDL_RWops *f, Sint8 set, ... );

#endif
