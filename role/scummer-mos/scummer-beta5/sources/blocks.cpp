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
 
#include "blocks.h"

extern Uint8 crypt_method;

Uint32 room_offset(SDL_RWops *f, Uint8 room)
{
	Uint32 result;		
	b_seek(f, SEEK_SET, "LOFF", "0");
	
	SDL_RWseek(f, room*(BYTE+DWORD)+2*BYTE, SEEK_CUR);
			
	result = fread_dwordLE (f);
	return result;
}

Uint8 room_number (SDL_RWops *f)
{
	Uint8 nRooms = 0;
	
	b_seek(f, SEEK_SET, "LOFF", "0");
	
	nRooms = fread_byte(f);
	return nRooms;
}

void b_seek (SDL_RWops *f, Sint8 set, ... )
{
	va_list arg_ptr;
	char *tmp, *test; 
		
	SDL_RWseek (f, 0L, set);
		
	while (1) 
	{	
		tmp = fread_name(f);
		va_start(arg_ptr, set);
		
#ifdef DEBUG
printf("Searching block..., file position %lu\n", SDL_RWtell(f));
#endif

		/* Finish when argument is "0" */
		while (strcmp(test = (va_arg(arg_ptr, char *)) , "0"))
		{	
			/* If wanted block is found, return */
			if (!strcmp(tmp, test))
			{
							
#ifdef DEBUG
printf("Found! At position %lu\n\n", SDL_RWtell(f));
#endif

				va_end(arg_ptr);
				SDL_RWseek(f, DWORD, SEEK_CUR);
				return;
			}		
		}	
		va_end(arg_ptr);
		SDL_RWseek(f, -3L, SEEK_CUR);			
	}				
}

void analyze(SDL_RWops *f)
{
	printf("Let's find what the hell this file is...\n");
	crypt_method = DMN;
	printf("Is this file a new SCUMM resource file? ");
	SDL_RWseek(f, 0L, SEEK_SET);
	if (!strcmp((char*)fread_name(f) , "LECF")) 
	{
		printf("YES.\n");
		return;
	}
	else printf("NO.\n");
	/*crypt_method = 0x00;
	printf("So this is an old SCUMM room file ? ");
	SDL_RWseek(f, DWORD, SEEK_SET);
	if (!strcmp((char*)fread_name(f), "RO")) 
		printf ("YES.\n");
	else printf("NO.\n");*/
	printf("\nSorry. Unsupported file type.\n");
	exit(EXIT_FAILURE);
}

