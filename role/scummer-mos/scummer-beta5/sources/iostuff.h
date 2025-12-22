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

#ifndef _iostuff_h
#define _iostuff_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "SDL_endian.h"
#include "SDL.h"

#define BYTE 1
#define CHAR BYTE
#define WORD 2
#define DWORD 4

/* Uncomment if you are trying SCUMMER for the first time
 * or with an untested game.
 */
 
/* #define DEBUG */

extern Uint8 crypt_method;

/* File I/O Functions */
#define DMN 0x69

/*	These functions read different types of data from LucasArts(c) resource 	*
 *	files, decrypt it using different XOR values (depending on game version), 	*
 *	and return the value in native endianess. (For example: fread_dwordBE(f) 	*
 *	reads a dword (4 bytes), in Big Endian format, from file "f" (which is a 	*
 *	pointer	to a file structure), and returns it.)								*/
 
	Uint32 fread_dwordBE (SDL_RWops *f); /* Reads a dword, 4 bytes */
	
	Uint32 fread_dwordLE (SDL_RWops *f); /* Same as above, but in LE format */
	
	Uint16 fread_wordBE (SDL_RWops *f);	/* Reads a word, 2 bytes */
	
	Uint16 fread_wordLE (SDL_RWops *f);	/* Same as above, but in LE format */
	
	Uint8 fread_byte (SDL_RWops *f);	/* Reads a byte */
			
	char *fread_name (SDL_RWops *f);	/* Reads a string of 4 (or 2) chars */
	
	
/*	Use this function to read a bit stream from a file (reads a byte,	* 
 *	and start returning bits from the Less Significant Bit. Second		*
 *	argument is "0" to initialize the function, then "-1" (or whatever 	*
 *	you want) to get the next bit.										*/
 
	Uint8 getbit(SDL_RWops *f, Sint8 s);
		
#endif
