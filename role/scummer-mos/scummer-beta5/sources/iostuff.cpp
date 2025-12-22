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
 
#include "iostuff.h"

Uint8 fread_byte (SDL_RWops *f)
{ 
	Uint8 result;
	SDL_RWread(f, &result, 1, 1);
	result ^= crypt_method;
	return result; 
}

char *fread_name (SDL_RWops *f)
{
	static char result[5];
	Uint8 count;
			
	/* Read 4 chars */ 
	SDL_RWread(f, result, 4, 1);
		
	/* XOR them with crypt_method */	
	for (count = 0; count < 4; count++) 
	{ 		
		result[count] ^= crypt_method;
	}
		
	return result;
}


Uint16 fread_wordBE (SDL_RWops *f) 
{
	Uint16 result = 0;
	Uint8 buffer;
			
	/* Read 2 bytes, XOR with crypt_method and swap */
	/* if ENDIANESS is different */
			
	Uint8 count;
	for (count = 0; count < 2; count++) 
	{
		SDL_RWread(f,&buffer,1,1);
		buffer^=crypt_method;
		result+=(buffer << (8*count));
	}
	
	if (SDL_BYTEORDER == SDL_LIL_ENDIAN)
	{
		SDL_Swap16(result);
	}		
	
	
	return result;
}

Uint32 fread_dwordBE (SDL_RWops *f)
{	
	Uint32 result = 0;
	Uint8 buffer = 0;
			
	/* Read 4 bytes, XOR with crypt_method and swap */
	/* if ENDIANESS is different */
	
	Uint8 count;
	for (count = 0; count < 4; count++)
	{
		SDL_RWread(f,&buffer,1,1);
		buffer^=crypt_method;
		result+=(buffer << (8 * count));
	}	
	
	if (SDL_BYTEORDER == SDL_LIL_ENDIAN)
	{
		SDL_Swap32(result);
	}
	
	return result;
}


Uint16 fread_wordLE (SDL_RWops *f) 
{
	Uint16 result = 0;
	Uint8 buffer = 0;
			
	/* Read 2 bytes, XOR with crypt_method and swap */
	/* if ENDIANESS is different */
	
	Uint8 count;
	for (count = 0; count < 2; count++) 
	{
		SDL_RWread(f,&buffer,1,1);
		buffer^=crypt_method;
		result+=(buffer << (8*count));
	}
	
	if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
	{
		SDL_Swap16(result);
	}
			
	return result;
}

Uint32 fread_dwordLE (SDL_RWops *f)
{	
	Uint32 result = 0;
	Uint8 buffer = 0;
		
	/* Read 4 bytes, XOR with crypt_method and swap */
	/* if ENDIANESS is different */
	
	Uint8 count;
	for (count = 0; count < 4; count++)
	{
		SDL_RWread(f,&buffer,1,1);
		buffer^=crypt_method;
		result+=(buffer << (8 * count));
	}	
	
	if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
	{
		SDL_Swap32(result);
	}
	
	return result;
}


Uint8 getbit(SDL_RWops *f, Sint8 s)
{
	static Uint8 mask, byte;
  	  	
  	if (s == 0)
  	{
  		mask = 256;
  		return 0;
  	}
  	
  	if ((mask <<= 1) == 0) 
  	{
  		mask = 1;
  		byte = fread_byte(f);
  	}
  
  	return ((byte & mask) != 0);
}
