/*======================================================*/
/*																											*/
/* Cli command to set the rgb values of a color		V1.0	*/
/* This utility changes the rgb values of the front			*/
/* screen																								*/
/*																											*/
/* © J.Tyberghein   6 sep 89	 V1.0											*/
/*		Tue Dec 19 15:42:36 1989													*/
/*																											*/
/* Compile with:																				*/
/*		Lattice 5.0x:																			*/
/*			lc -v -cms -L -O rgb														*/
/*		Aztec 3.6:																				*/
/*			cc rgb.c																				*/
/*			ln +q rgb.o -lc																	*/
/*																											*/
/*======================================================*/


#include <exec/types.h>
#include <graphics/gfxbase.h>
#include <intuition/intuitionbase.h>

#ifdef LATTICE
#include <proto/graphics.h>
#include <proto/exec.h>
#endif
#ifndef LATTICE
#include <functions.h>
#endif


struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;


void main (argc,argv)
int argc;
char *argv[];
{
	LONG cn,r,g,b;

	if (argc != 5)
		{
			printf ("Usage: <color> <red> <green> <blue>\n");
			exit (0);
		}
	if (!(IntuitionBase = (struct IntuitionBase *)OpenLibrary ("intuition.library",0L)))
		{
			printf ("Error opening Intuition !\n");
			exit (1);
		}
	if (!(GfxBase=(struct GfxBase *)OpenLibrary ("graphics.library",0L)))
		{
			CloseLibrary ((struct Library *)IntuitionBase);
			printf ("Error opening graphics !\n");
			exit (1);
		}
	sscanf (argv[1],"%ld",&cn);
	sscanf (argv[2],"%ld",&r);
	sscanf (argv[3],"%ld",&g);
	sscanf (argv[4],"%ld",&b);
	SetRGB4 (&(IntuitionBase->FirstScreen->ViewPort),cn%32L,r%16L,g%16L,b%16L);
	CloseLibrary ((struct Library *)IntuitionBase);
	CloseLibrary ((struct Library *)GfxBase);
}
