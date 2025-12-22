#include "image.h"
#include "blocks.h"

image::image( SDL_RWops *f, Uint32 offset)
{
	this->f = f;
	xscroll = 0;
	
	SDL_RWseek(f, offset, SEEK_SET);
	
	b_seek(f, SEEK_CUR, "RMHD", "0");
	
	/* Read a RMHD block */	
	
	if  ((width = fread_wordLE(f)) == 730)	
	/* Then we have a Full Throttle room, so this */
	/* we have just read is MMucus version and we */
	/* have to read another WORD, which is the	  */
	/* real image width.					 	  */
		width = fread_wordLE(f);
		  	
	height = fread_wordLE(f);
	
	printf("Image Width: %u, Height: %u\n", width, height);
	
	offsets = new Uint32[width/8];
	
	/* Jump to the TRNS block */
	b_seek(f, SEEK_CUR, "TRNS", "0");
	
	/* Read transparency information */
	transp = (Uint8)fread_dwordLE(f);
	
	/* Jump to the CLUT (or APAL, or NPAL) block which contains palette */
	b_seek(f, SEEK_CUR, "CLUT", "APAL", "NPAL", "0");			
	
	/* Read palette */
	for (Uint16 x = 0 ; x < 256; x++) 
	{
		pal[x].r = fread_byte(f);
		pal[x].g = fread_byte(f);
		pal[x].b = fread_byte(f);
	}
	
	b_seek(f, SEEK_CUR, "SMAP", "0");
	
	Uint32 return_point = SDL_RWtell(f) - 2*DWORD;
		
	for (Uint8 x = 0; x < width/8; x++) 
		offsets[x] = fread_dwordLE(f) + return_point;
	
}

image::~image()
{
	delete offsets;
	xscroll = 0;
}

SDL_Surface *image::GetStrip( Uint8 pos)
{
	SDL_Surface *strip = NULL;
	Uint8 compr_method, parameter;
	bool horiz;	
		
	strip = SDL_CreateRGBSurface (SDL_SWSURFACE, 8, height, 16, 0, 0, 0, 0);
	
	/* Lock surface if needed */
	if ( SDL_MUSTLOCK(strip) ) { 
        if ( SDL_LockSurface(strip) < 0 ) { 
            fprintf(stderr, "Can't lock screen: %s\n", SDL_GetError()); 
            exit (EXIT_FAILURE); 
        } 
    }
     
	/* Map colors into SDL palette */
	for (Uint16 x = 0 ; x < 256; x++)
		palette[x] = SDL_MapRGB(strip->format, pal[x].r, pal[x].g, pal[x].b);
			
	SDL_RWseek(f, offsets[pos + xscroll], SEEK_SET);
	
	/* Initializes bit stream */
	getbit(f, 0);
					
	/* Find out strip compression method */
	/* and parameter.					 */
	compr_method = fread_byte(f);	
	parameter = (compr_method % 10);
				
	/* Is this an horizontally coded strip? */
	horiz = 1 - ((compr_method / 10) & 1);
	
	switch (compr_method / 10) 
	{
		case 0:
			/* Uncompressed */
			decode_uncompressed(strip, height);
			break;
					
		case 1:
	 	case 2:
	 	case 3:
	 	case 4:	 
	 	
			/* 1st compression method */
			if (horiz)
				decode_horiz(strip, height, parameter);
			else 
				decode_vert(strip, height, parameter);
			break;
	 
		default:
			/* 2nd compression method */
	  		if ((compr_method >= 0x54) && (compr_method <= 0x60))
	  			decode2transp(strip, height, parameter); 
			else
				decode2(strip, height, parameter);
			break;
	}
	
	if ( SDL_MUSTLOCK(strip) ) 
	   	SDL_UnlockSurface(strip);
	   	 
    return strip;	
}

Uint8 image::Scroll(Uint8 direction)
{
	switch (direction) 
	{
		case SCROLL_RIGHT:
		if (xscroll < (width - 320)/8)
		{
			xscroll+=1;
			break;
		}
		else return 1;
		
		case SCROLL_LEFT: 
		if (xscroll > 0)
		{
			xscroll-=1;
			break;
		}
		else return 1;
	}
	return 0;
}

/* Decoding Functions */

void image::decode_uncompressed(SDL_Surface *strip, Uint16 height)
{
	Uint8 index = 0;
	for (Uint16 y = 0; y < height; y++) 
	{
		for (Uint8 x = 0; x < 8; x++)
		{
			index = fread_byte(f);
			putpixel(strip, x, y, palette[index]);
		}
	 }
}

void image::decode2(SDL_Surface *strip, Uint16 height, Uint8 parameter)
{	
	Uint8 index = 0;
		
	for (Uint16 y = 0; y < height; y++) 
		{
			Uint8 x = 0;
			if (y == 0) 
			{ 
				index = fread_byte(f);
				putpixel(strip, 0, 0, palette[index]);
				x++; 
			}	
			while ( x < 8 ) 
			{				
				if (getbit(f,-1) == 0) 
					putpixel(strip, x++, y, palette[index]);
				else 
				{
					if (getbit(f,-1) == 0) 
					{
						index = 0;
						for (Uint8 cx = 0; cx < parameter; cx++) 
							index += (getbit(f,-1) << cx);
						putpixel(strip, x++, y, palette[index]);
					}
					else
					{						
						Uint8 command = 0;
						for (Uint8 val = 0; val < 3; val++) 
							command += (getbit(f,-1) << val);				
					
						if (command == 4) 
						{
						 	Uint8 run = 0;
						 	for (Uint8 bits = 0; bits < 8; bits++) 
						 		run += (getbit(f,-1) << bits);	 					 	
						 	for (Uint8 c = 0; c < run; c++) 
						 	{
						 		if (x > 7)
						 		{
						 			x = 0;
						 			y++;
						 		} 
						 		putpixel(strip, x++, y, palette[index]);						 		
						 	}
						}
						else 
						{
						 	index += command - 4;
							putpixel(strip, x++, y, palette[index]);
						}							
					}
				} 
			}
		}
}

void image::decode2transp(SDL_Surface *strip, Uint16 height, Uint8 parameter)
{
	Uint8 index = 0;
		
	for (Uint16 y = 0; y < height; y++) 
		{
			Uint8 x = 0;
			if (y == 0) 
			{ 
				index = fread_byte(f);
				if (index != transp)
					putpixel(strip, 0, 0, palette[index]); 
				x++;
			}	
			while ( x < 8 ) 
			{										
				if (getbit(f,-1) == 0) 
					putpixel(strip, x++, y, palette[index]);
				else 
					if (getbit(f,-1) == 0) 
					{
						index = 0;
						for (Uint8 cx = 0; cx < parameter; cx++) 
							index += (getbit(f,-1) << cx);
						if (index != transp)
							putpixel(strip, x, y, palette[index]); 
						x++;
					}
					else
					{						
						Uint8 command = 0;
						for (Uint8 val = 0; val < 3; val++) 
							command += (getbit(f,-1) << val);				
						if (command < 4) 
						{
							index -= 4-command;
							if (index != transp)
								putpixel(strip, x, y, palette[index]); 
							x++;
						}
						else if (command == 4) 
						{
						 	Uint8 run = 0;
						 	for (Uint8 bits = 0; bits < 8; bits++) 
						 		run += (getbit(f,-1) << bits);									 	 					 	
						 	for (Uint8 c = 0; c < run; c++) 
						 	{	
						 		if (x == 8) 
								{ 
									x = 0; 
									y++; 
								}
								if (index != transp)
									putpixel(strip, x, y, palette[index]); 
								x++;
						 		
						 	}
						}
						else 
						{
						 	index += command-4;
							if (index != transp)
								putpixel(strip, x, y, palette[index]); 
							x++;
						}							
					}
				} 
		}
}

void image::decode_horiz(SDL_Surface *strip, Uint16 height, Uint8 parameter)
{	
	Uint8 index = 0;
	Sint8 subt = 1;
		
	for (Uint16 y = 0; y < height; y++ ) 
	{
		for (Uint8 x = 0 ; x < 8; x++) 
		{
			if ((y == 0) && (x == 0)) 
			{
				index = fread_byte(f);
				putpixel(strip, 0, 0, palette[index]); 
				x++;
			}				
			if (getbit(f, -1) == 0) 
				putpixel(strip, x, y, palette[index]);
			else 
			{
				if (getbit(f, -1) == 0) 
				{
					index = 0;
				 	for (Uint8 cx = 0; cx < parameter; cx++)
						index += (getbit(f, -1) << cx );
					subt = 1;
				 	putpixel(strip, x, y, palette[index]);
				}
				else
				{	
				 	if (getbit(f, -1) == 0) 
				 	{						 
						index -= subt;
						putpixel(strip, x, y, palette[index]);
					}	
					else
				  	{
				  		subt =- subt;
						index -= subt;
						putpixel(strip, x, y, palette[index]);
					}
				} 
			} 
		} 
	}
}

void image::decode_vert(SDL_Surface *strip, Uint16 height, Uint8 parameter)
{
	Uint8 index = 0;
	Sint8 subt = 1;
		
	for (Uint16 y = 0; y < 8; y++ ) 
	{
		for (Uint16 x = 0 ; x < height; x++) 
		{
			if ((y == 0) && (x == 0)) 
			{
				index = fread_byte(f);
				putpixel(strip, 0, 0, palette[index]); 
				x++;
			}				
			if (getbit(f, -1) == 0) 
				putpixel(strip, y, x, palette[index]);
			else 
			{
				if (getbit(f, -1) == 0) 
				{
					index = 0;
				 	for (Uint8 cx = 0; cx < parameter; cx++) 
						index += (getbit(f, -1) << cx );
					subt = 1;
				 	putpixel(strip, y, x, palette[index]);
				}
				else
				{	
				 	if (getbit(f, -1) == 0) 
				 	{						 
						index -= subt;
						putpixel(strip, y, x, palette[index]);
					}	
					else
				  	{
				  		subt =- subt;
						index -= subt;
						putpixel(strip, y, x, palette[index]);
					}
				} 
			} 
		} 
	}
}

void image::decode_horiz_transp(SDL_Surface *strip, Uint16 height, Uint8 parameter)
{
	Uint8 index = 0;
	Sint8 subt = 1;
		
	for (Uint16 y = 0; y < height; y++ ) 
	{
		for (Uint8 x = 0 ; x < 8; x++) 
		{
			if ((y == 0) && (x == 0)) 
			{
				index = fread_byte(f);
				if (index != transp)
					putpixel(strip, 0, 0, palette[index]); 
				x++;
			}				
			if (getbit(f, -1) == 0) 
				if (index != transp)
					putpixel(strip, x, y, palette[index]);
			else 
			{
				if (getbit(f, -1) == 0) 
				{
					index = 0;
				 	for (Uint8 cx = 0; cx < parameter; cx++) 
						index += (getbit(f, -1) << cx );
					subt = 1;
				 	if (index != transp)
				 		putpixel(strip, x, y, palette[index]);
				}
				else
				{	
				 	if (getbit(f, -1) == 0) 
				 	{						 
						index -= subt;
						if (index != transp)
							putpixel(strip, x, y, palette[index]);
					}	
					else
				  	{
				  		subt =- subt;
						index -= subt;
						if (index != transp)
							putpixel(strip, x, y, palette[index]);
					}
				} 
			} 
		} 
	}
}

void image::decode_vert_transp(SDL_Surface *strip, Uint16 height, Uint8 parameter)	
{
	Uint8 index = 0;
	Sint8 subt = 1;
		
	for (Uint16 y = 0; y < 8; y++ ) 
	{
		for (Uint8 x = 0 ; x < height; x++) 
		{
			if ((y == 0) && (x == 0)) 
			{
				index = fread_byte(f);
				if (index != transp)
					putpixel(strip, 0, 0, palette[index]); 
				x++;
			}				
			if (getbit(f, -1) == 0) 
				if (index != transp)
					putpixel(strip, y, x, palette[index]);
			else 
			{
				if (getbit(f, -1) == 0) 
				{
					index = 0;
				 	for (Uint8 cx = 0; cx < parameter; cx++) 
						index += (getbit(f, -1) << cx );
					subt = 1;
				 	if (index != transp)
				 		putpixel(strip, y, x, palette[index]);
				}
				else
				{	
				 	if (getbit(f, -1) == 0) 
				 	{						 
						index -= subt;
						if (index != transp)
							putpixel(strip, y, x, palette[index]);
					}	
					else
				  	{
				  		subt =- subt;
						index -= subt;
						if (index != transp)
							putpixel(strip, y, x, palette[index]);
					}
				} 
			} 
		} 
	}
}
