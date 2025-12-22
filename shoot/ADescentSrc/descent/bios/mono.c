/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/bios/mono.c,v $
 * $Revision: 1.3 $
 * $Author: tfrieden $
 * $Date: 1998/04/09 16:12:48 $
 *
 * Library functions for printing to mono card.
 *
 *
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: mono.c,v 1.3 1998/04/09 16:12:48 tfrieden Exp $";
#pragma on (unreferenced)

// Library functions for printing to mono card.

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

#include "key.h"

//#define NO_MONO

void mono_int_3();
#pragma aux mono_int_3 = "int 3";

#define MAX_NUM_WINDOWS 2

struct mono_element {
	unsigned char character;
	unsigned char attribute;
};

typedef struct  {
	short   first_row;
	short   height;
	short   first_col;
	short   width;
	short   cursor_row;
	short   cursor_col;
	short   open;
	struct  mono_element save_buf[25][80];
	struct  mono_element text[25][80];
} WINDOW;


void scroll( short n );
void drawbox( short n );

#define ROW             Window[n].first_row
#define HEIGHT          Window[n].height
#define COL             Window[n].first_col
#define WIDTH           Window[n].width
#define CROW            Window[n].cursor_row
#define CCOL            Window[n].cursor_col
#define OPEN            Window[n].open
#define CHAR(r,c)       (*monoscreen)[ROW+(r)][COL+(c)].character
#define ATTR(r,c)       (*monoscreen)[ROW+(r)][COL+(c)].attribute
#define XCHAR(r,c)      Window[n].text[ROW+(r)][COL+(c)].character
#define XATTR(r,c)      Window[n].text[ROW+(r)][COL+(c)].attribute

static WINDOW Window[MAX_NUM_WINDOWS];

struct mono_element (*monoscreen)[25][80];

void mputc( short n, char c )
{
#ifndef NO_MONO
	fprintf(stderr,"%c",c);
#endif
}

void mputc_at( short n, short row, short col, char c )
{
#ifndef NO_MONO
	mputc( n, c );
#endif
}

void scroll( short n )
{
}

static char temp_m_buffer[1000];
void _mprintf( short n, char * format, ... )
{
#ifndef NO_MONO
	va_list args;

	va_start(args, format );
	vfprintf(stderr,format,args);
#endif
}

void _mprintf_at( short n, short row, short col, char * format, ... )
{
#ifndef NO_MONO
	va_list args;
	
	va_start(args, format );
	vfprintf(stderr,format,args);
#endif
}


void drawbox(short n)
{
}

void mclear( short n )
{
}

void mclose(short n)
{
}

void mrefresh(short n)
{
}


int mono_present();     //return true if mono monitor in system


void mopen( short n, short row, short col, short width, short height, char * title )
{
}

int minit()
{
	return -1;  //everything ok
}

