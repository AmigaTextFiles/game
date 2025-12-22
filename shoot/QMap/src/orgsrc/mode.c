/* QMAP: Quake level viewer
 *
 *   mode.c    Copyright 1997 Sean Barett
 *   minor modifications by Jawed Karim
 *
 *   General screen functions (set graphics
 *   mode, blit to framebuffer, set palette)
 */

#include <dos.h>
#include <conio.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "s.h"
#include "mode.h"

char *framebuffer = (char *) 0xA0000;

void blit(char *src)
{
//   memcpy(framebuffer, src, 320*200);
   dosmemput(src, 320*200, 0xA0000);
}

void set_pal(unsigned char *pal)
{
   int i;
   outp(0x3c8, 0);
   for (i=0; i < 768; ++i)
      outp(0x3c9, pal[i] >> 2);
}

void set_mode (int mode)
{
	/* 0x13 - VGA
	   0x03 - Text */

	union REGS r, s;
	r.w.ax = mode;
	int386 (0x10, &r, &s);
}

bool graphics=0;
void set_lores(void)
{
   graphics = 1;
   set_mode(0x13);
}
   
void set_text(void)
{
   if (graphics) {
      set_mode(0x3);
      graphics = 0;
   }
}

void fatal_error(char *message, char *file, int line)
{
   set_text();
   printf("Error (%s line %d): %s\n", file, line, message);
   exit(1);
}
