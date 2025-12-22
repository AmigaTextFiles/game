/*
* This file is part of NeverMind.
* Copyright (C) 1998 Lennart Johannesson
* 
* NeverMind is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* NeverMind is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with NeverMind.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#include <clib/asl_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <clib/dos_protos.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "graphics.h"
#include "setup.h"

struct BitMap *blockpic=NULL;
struct BitMap *menupic=NULL;

ULONG *menupal=NULL;
ULONG *blockpal=NULL;

int power(int base,int up)
{
	int counter,sum=1;
	for(counter=1;counter<=up;counter++)
		sum*=base;
	return(sum);
}

ULONG *loadpalette(char *palettepath)
{
	FILE *palettefile=NULL;
	int count, colnum; 
	ULONG *palette;

	colnum=power(2,depth); /* Number of colors are calculated here */

	if((palette=(ULONG *)calloc((colnum*3+2),sizeof(ULONG)))==NULL)
		shutdown("loadpalette(): Not enough Memory"); /* Allocate memory for palette */
	
	if((palettefile=fopen(palettepath,"rb"))==NULL) /* Open the palette file stream */
	{
		free(palette);
		shutdown("loadpalette(): Could not open palettefile");
	}
		
	palette[0]=colnum<<16+0;    /* First word = Number of colours, second word = First color to set */
	colnum*=3;   /* To get the colorpalettes Last Longword */

	for(count=1; count<=colnum; count++)
	{
		if(fread(&palette[count], sizeof(ULONG), 1, palettefile)<1)
		{
			fclose(palettefile);
			free(palette);
			shutdown("loadpalette(): Could not read (whole) Palette!");
		}
	}

	palette[(colnum+1)]=0x00000000; /* Last longword MUST be 0 = End of palette */

	fclose(palettefile);
	return(palette);
}

void loadblocks(char *blockpath)
{
	FILE *blockfile=NULL;
	int planesize, current, length;

	if((blockfile=fopen(blockpath,"rb"))==NULL)
	{
		chooseblocks();
		shutdown("Try restarting NeverMind Now!");
   }
   	
	planesize=pic_xsize*pic_ysize/8;

	for(current=0;current<depth;current++)
	{
		if(fread(blockpic->Planes[current],sizeof(UBYTE),planesize,blockfile)<planesize)
		{
			fclose(blockfile);
			shutdown("loadblocks(): Failed during loading of BitMap, wrong filesize?");
		}
	}
	fclose(blockfile);

	if(blockpal) free(blockpal);	
	length=strlen(blockpath); /* The four rows here change the extension .nem to .pal */
	blockpath[length-3]='p';  
	blockpath[length-2]='a';
	blockpath[length-1]='l';
	blockpal=loadpalette(blockpath);
	blockpath[length-3]='n';  /* And to restore the extension again! :) */
	blockpath[length-2]='e';
	blockpath[length-1]='m';


}

void loadmenupic(char *menupath)
{
	FILE *menufile=NULL;
	int planesize, current;

	if((menufile=fopen(menupath,"rb"))==NULL)
	{
		shutdown("loadmenupic(): Could not open menupic, file missing?");
   }
   	
	planesize=menu_xsize*menu_ysize/8;

	for(current=0;current<depth;current++)
	{
		if(fread(menupic->Planes[current],sizeof(UBYTE),planesize,menufile)<planesize)
		{
			fclose(menufile);
			shutdown("loadmenupic(): Failed during loading of BitMap, wrong filesize?");
		}
	}
	fclose(menufile);
}

void putblock(int xpos, int ypos, int blocknumber)
{
	int row,col;  /* row 0 = First row & Col 0 = First Column */
	row = (blocknumber/20)*16;
   col = (blocknumber*16)-(row*20);
	BltBitMapRastPort(blockpic, col, row, RPort, xpos, ypos, 16, 16, (ABC|ABNC));
}

void menutitle()
{
	int row;
	for(row=-menu_ysize;row<0;row++)
	{
		BltBitMapRastPort(menupic, 0, 0, RPort, 0, row, menu_xsize, menu_ysize, (ABC|ABNC));
	}
}

void setpalette(ULONG *palette)
{
	LoadRGB32(&gamescreen->ViewPort, palette); /* Everything OK, Set the colors */
}

void gamebar(int surmines, int score)
{
	char outtext[21]="Mines Surrounding: ";
	char num[2]="0";
	int exponent;

	num[0]=(char) surmines+'0'; /* Convert the int to char, to be able to write it out! */
	SetAPen(RPort, 7);
	Move(RPort, 10,10);
	strcat(outtext, num);
	Text(RPort, outtext, strlen(outtext));

	strcpy(outtext,"Score ");

	for(exponent=1000;exponent>0;exponent/=10)
	{
	   num[0]=(char)('0'+score/exponent);
		strcat(outtext, num);
		score=score%exponent;
	}

	Move(RPort, 230,10);
	Text(RPort, outtext, strlen(outtext)); 

}

void inform(char *textmess, int xplace)
{
	int textlength; //, scorel=score; /* The score variable is duplicated */
	textlength=strlen(textmess)-1;
	SetAPen(RPort, 0);
	RectFill(RPort, 0,0, screenwidth,15);
	SetAPen(RPort, 7);
	Move(RPort, xplace, 10);
	Text(RPort, textmess, textlength);
/* Put in the score and recalculate it to ascii, then write out! */
}

void textxy(char *textmess, int xplace, int yplace, int color)
{
	int textlength;
	textlength=strlen(textmess)-1;
	SetAPen(RPort, color);
	Move(RPort, xplace, yplace);
	Text(RPort, textmess, textlength);
}

void wipescreen(int tid)
{
	int ypoint , skip;
	
	Delay(tid);
	for(ypoint=0;ypoint<screenheight;ypoint+=2)
	{
		BltBitMapRastPort(blockpic, 0, 0, RPort, 0, ypoint, screenwidth, 1,NULL);
		BltBitMapRastPort(blockpic, 0, 0, RPort, 0, screenheight-(ypoint-1), screenwidth, 1,NULL);
		skip++;
		if(skip>=3)
		{
			WaitTOF();
			skip=0;
		} 
	}
}

void cleararea(int x, int y, int width, int height)
{
	BltBitMapRastPort(blockpic, 0, 0, RPort, x, y, width, height,NULL);

}


void chooseblocks(void)
{
	struct FileRequester *nem_ask;
	int choose=0, length;

	nem_ask=AllocAslRequestTags(ASL_FileRequest, TAG_END);

	if(nem_ask)
	{
		choose=AslRequestTags(nem_ask,
					ASLFR_Screen, gamescreen,
					ASLFR_TitleText, "Choose a NeverMind block-file",
					ASLFR_InitialDrawer, "data",
					ASLFR_InitialFile, "Sea2.nem",
					ASLFR_InitialPattern, "#?.nem",
					TAG_END);
	}

	if(choose)
	{
		for(length=0;length<256;length++)
		{
			filename[length]=NULL; /* The old filename needs to be cleared! */
		}
		length=strlen(nem_ask->fr_Drawer);
		strncat(filename, nem_ask->fr_Drawer, length);
		strncat(filename, "/",1);
		length=strlen(nem_ask->fr_File);
		strncat(filename, nem_ask->fr_File, length);
		loadblocks(filename);
	}
	FreeAslRequest(nem_ask);
}
