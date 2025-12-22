/* QMAP: Quake level viewer
 *
 *   mode.c    Copyright 1997 Sean Barett
 *   minor modifications by Jawed Karim
 *
 *   General screen functions (set graphics
 *   mode, blit to framebuffer, set palette)
 */

//#include <dos.h>
//#include <conio.h>
#include <power.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "s.h"
#include "mode.h"

struct PDisplay *display = (struct PDisplay *) 0L;

void blit(char *src)
{
	PBltChkHidden(display,src,0,0,320,200);
	PSwapDisplay(display);	
}

void set_pal(unsigned char *pal)
{
	if(display)
		PSetPalette(display,pal);
}

void set_lores(void)
{
	display=POpenDisplay(320,200,8);
}
   
void set_text(void)
{
   if (display) {
   	PCloseDisplay(display);
	display = (struct PDisplay *)0L;
   }
}

void fatal_error(char *message, char *file, int line)
{
   set_text();
   printf("Error (%s line %d): %s\n", file, line, message);
   exit(1);
}
