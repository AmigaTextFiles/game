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
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/exec_protos.h>
#include <clib/diskfont_protos.h>
#include <stdlib.h>
#include <stdio.h>
#include "graphics.h"
#include "setup.h"
#include "sound.h"
#include "keys.h"
#include "game.h"
#include "scores.h"

struct Library *IntuitionBase=NULL;
struct Library *GraphicsBase=NULL;
struct Library *AslBase=NULL;
struct Library *DiskFontBase=NULL;
struct Library *MEDPlayerBase=NULL;

struct Screen *gamescreen=NULL;
struct Window *gamewindow=NULL;
struct RastPort *RPort=NULL;

struct TextFont *gamefont;
struct TextAttr nmfont=
{
   "NeverMind.font",
   8, 0, 0
};

UWORD emptypointer[] = { /* Stolen from ADoom */
  0x0000, 0x0000,	/* reserved, must be NULL */
  0x0000, 0x0000, 	/* 1 row of image data */
  0x0000, 0x0000	/* reserved, must be NULL */
};

char filename[256]="";

ULONG mode_id=0x00000000;
ULONG startcolors[]={2L<<16+0,	0x00000000,0x00000000,0x00000000,
											0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0}; /* StartColors */

void loadprefs(void)
{
	int preflevel=0;	
	FILE *prefsfile;

	if((prefsfile=fopen("NeverMind.prefs","rb")))
	{
		fread(&preflevel, sizeof(int), 1, prefsfile);           /* Gets the version of the prefsfile */
		if(preflevel>=1) fread(&mines_per_row, sizeof(int),1, prefsfile); /* Gets the difficulty level */
		if(preflevel>=1) fread(filename, sizeof(char), 256, prefsfile);   /* Gets the blockset-filename */
		if(preflevel>=2) fread(&mode_id, sizeof(ULONG), 1, prefsfile);    /* Gets the user defined mode_id */
		if(preflevel>=3) fread(&nm_music, sizeof(int), 1, prefsfile); /* Gets music or not */
		fclose(prefsfile);
	}
	if(!mines_per_row) mines_per_row=3;
	if(filename[0]=='\0') chooseblocks();
	if(mode_id==0) mode_request();
	if(!nm_music==1) nm_music=0; /* Sets the music off */
}

void saveprefs(void)
{
	FILE *prefsfile;

	if((prefsfile=fopen("NeverMind.prefs","wb")))
	{
		fwrite(&prefsversion, sizeof(int), 1, prefsfile);  /* Saves the version of the prefsfile */
		fwrite(&mines_per_row, sizeof(int), 1, prefsfile); /* Saves the difficulty level */
		fwrite(filename, sizeof(char), 256, prefsfile);    /* Saves the blockset-filename */
		fwrite(&mode_id, sizeof(ULONG), 1, prefsfile);     /* Saves the user defined mode_id */
		fwrite(&nm_music, sizeof(int), 1, prefsfile);      /* Saves if the music is enabled */
		fclose(prefsfile);
	}
}

void mode_request(void)
{
	struct ScreenModeRequester *scrreq;

	scrreq=AllocAslRequestTags(ASL_ScreenModeRequest, TAG_END);
	AslRequestTags(scrreq,
						ASLSM_TitleText, "NeverMind ScreenMode Req.",
						TAG_END);
	mode_id=scrreq->sm_DisplayID;   /* We need the mode_id for gfx-boards etc. */
	FreeAslRequest(scrreq);
}


void endmessage(char *errmess)
{
	struct EasyStruct bye=
	{
		sizeof(struct EasyStruct),
		NULL,
		"What's this all about?",
		errmess,
		"Acknowledged!"
	};
	EasyRequest(NULL,&bye,NULL);
}


void setup(void)
{

	if(!(IntuitionBase=OpenLibrary("intuition.library", intuiversion)))
	   shutdown("Could not open intution.library V39 or later");

	if(!(GraphicsBase=OpenLibrary("graphics.library",39L)))
		shutdown("Could not open graphics.library V39 or later");

	if(!(AslBase=OpenLibrary("libs:asl.library",39L))) 
		shutdown("Could not open asl.library V39 or later\n");

	if(!(DiskFontBase=OpenLibrary("libs:diskfont.library",39L))) 
		shutdown("Could not open diskfont.library V39 or later\n");

	if(!(MEDPlayerBase = OpenLibrary("libs:medplayer.library",0)))
		endmessage("Can't find medplayer.library, check your libs:\n");

	loadprefs();
	loadscores();

	if(!(gamescreen=OpenScreenTags(NULL,
			SA_DetailPen,0,
			SA_BlockPen,0,
			SA_Quiet,TRUE,
			SA_FullPalette,TRUE,
			SA_Colors32,startcolors,
			SA_Width,screenwidth, SA_Height,screenheight,
			SA_Depth,depth,
			SA_DisplayID, mode_i d, 
			SA_PubName, "NeverMind",
			SA_Type, CUSTOMSCREEN,
			TAG_END))) 
			shutdown("Screen could not be be opened.\nCheck if you have enough chipmem\nor try deleting NeverMind.prefs\nand start again!");

	if(!(gamewindow=OpenWindowTags(NULL,
			WA_Left,0, WA_Top,0,
			WA_Width,screenwidth,WA_Height,screenheight,
			WA_CustomScreen,gamescreen,
			WA_Flags, WFLG_BACKDROP,
			WA_IDCMP, IDCMP_RAWKEY,
			WA_Borderless,TRUE,
			WA_RMBTrap, TRUE,
			WA_Activate, TRUE,
			TAG_DONE))) 
			shutdown("My window could not be opened!");

	RPort=gamewindow->RPort;

	if(!(gamefont=OpenDiskFont(&nmfont)))
		shutdown("Could not find NeverMind.font your fonts directory");

	SetFont(RPort,gamefont);   /* Sets the gamewindow font to myfont */
   /*	initjoy(); */                /* Initializes the joy, locks the task? */

	if(!(blockpic=AllocBitMap(pic_xsize,pic_ysize,depth,BMF_CLEAR,NULL)))
		shutdown("Failed allocating BitMap for blocks, not enough memory?\n");
	
	if(!(menupic=AllocBitMap(menu_xsize,menu_ysize,depth,BMF_CLEAR,NULL)))
		shutdown("Failed allocating BitMap for menupic, not enough memory?\n");
				

   SetPointer(gamewindow, emptypointer, 1, 16, 0, 0);

	if(MEDPlayerBase && nm_music) nmplaysong();

}

void shutdown(char *mess)
{
	if(mess)
	{
		endmessage(mess);
	}
	if(gamewindow) CloseWindow(gamewindow);
	if(gamescreen) CloseScreen(gamescreen);

	if(GraphicsBase) CloseLibrary(GraphicsBase);
	if(AslBase) CloseLibrary(AslBase);
	if(DiskFontBase)
	{
		if(gamefont) CloseFont(gamefont);
		CloseLibrary(DiskFontBase);
	}
	if(blockpic)
	{
		WaitBlit();
		WaitTOF(); WaitTOF(); /* Just in case */
		FreeBitMap(blockpic);
	}
	if(blockpal) free(blockpal); /* Free the palette mem */

	if(menupic)
	{
		WaitBlit();
		WaitTOF(); WaitTOF(); /* Just in case */
		FreeBitMap(menupic);
	}
	if(menupal) free(menupal); /* Free the palette mem */

	saveprefs();
	savescores();

	if(MEDPlayerBase)
	{
		if(nm_music) nmstopsong();
		CloseLibrary(MEDPlayerBase);
	}

	if(IntuitionBase)
	{
		ClearPointer(gamewindow);
		CloseLibrary(IntuitionBase);
	}
	exit(0);
}
