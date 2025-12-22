
/*
	blip.c - or also called 'EGSUliGauge' ("Gow-Gah" !)
	Nothing serious. Really, in fact useless. Nevertheless - cute. :-)

	This program is published under the S.U.C.K.S. label
	Initially triggered by Matthias 'DrMabuse' Luehr in de.comp.sys.amiga.misc (?)

	Frank Neumann, October 1994
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <exec/types.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

#include <egs/egs.h>
#include <egs/egsintui.h>
#include <egs/egsgfx.h>
#include <egs/clib/egs_protos.h>
#include <egs/clib/egsintui_protos.h>
#include <egs/clib/egsgfx_protos.h>

/* include image maps */
#include "img/n1.h"
#include "img/n2.h"
#include "img/n3.h"
#include "img/n4.h"
#include "img/n5.h"
#include "img/n6.h"
#include "img/n7.h"
#include "img/n8.h"
#include "img/design.h"
#include "img/flame.h"
#include "img/sun.h"
#include "img/egs.h"
#include "img/fish.h"
#include "img/franky.h"
#include "img/mountain.h"
#include "img/steffi.h"


/* defines */
#define WIDTH   256
#define HEIGHT  128
#define FALSE 0
#define TRUE  1

#define IMG_WIDTH	30
#define IMG_HEIGHT	30

#define GRAY 0x50505000

/* global variables */
/* yes, there are already too much of these by now.. *sigh* */
struct Library		*EGSIntuiBase   = NULL;
struct Library		*EGSBase        = NULL;
struct Library		*EGSGfxBase 	= NULL;

struct EI_NewWindow my_newwindow;
EI_WindowPtr     	my_window;
EI_EIntuiMsgPtr		msg;
E_EGSClassPtr		mapclass = NULL;
E_EBitMapPtr		pixmaps[8] = NULL;


/* version information */
static char *vers = "$VER: EGSGowgah 0.1pre (27.10.94)";

/* prototypes */
void          main( int, char *[] );
void          draw_randblink( int x, int y, EG_RastPortPtr rp );
void          draw_bincount( int x, int y, EG_RastPortPtr rp );
void          draw_enterprise( int x, int y, EG_RastPortPtr rp );
void          draw_activity( int x, int y, EG_RastPortPtr rp, unsigned long col, int ind, int del );
void          draw_zip( int x, int y, EG_RastPortPtr rp, int ind );
void          draw_bars( int x, int y, EG_RastPortPtr rp, int ind );
void          draw_vbars( int x, int y, EG_RastPortPtr rp, int ind );
void          draw_ekg( int x, int y, EG_RastPortPtr rp, int ind );
void          draw_pix( int x, int y, EG_RastPortPtr rp );
void          crash(char * string);

/*******************************************/
/* entry point when started from Workbench */
/*******************************************/
int wbmain(struct WBStartup *wbs)
{
    return(main(0, (char **)wbs));
}


/********************/
/*** main function **/
/********************/
void main(int argc, char *argv[])
{
	int i, flag = 0;
	int done = FALSE;
	E_Symbol mapsymbol;
	unsigned long *maps[16] =
	{
		noise1_image,
		noise2_image,
		noise3_image,
		noise4_image,
		noise5_image,
		noise6_image,
		noise7_image,
		noise8_image,
		design_image,
		egs_image,
		sun_image,
		flame_image,
		fish_image,
		franky_image,
		mountain_image,
		steffi_image
	};

	srand(time(NULL));

	/* be nice.. */
	SetTaskPri(FindTask(0), -1);

    /* open required libraries */
	EGSBase = (APTR)OpenLibrary("egs.library", 5L);
    if (EGSBase == NULL)
    	crash("Could not open egs.library");

	EGSIntuiBase = (APTR)OpenLibrary("egsintui.library", 6L);
    if (EGSIntuiBase == NULL)
    	crash("Could not open egsintui.library");

	EGSGfxBase = (APTR)OpenLibrary("egsgfx.library", 6L);
    if (EGSGfxBase == NULL)
    	crash("Could not open egsgfx.library");

	/* get the symbol name of the 24 bit chunkymap class */
    mapsymbol  = E_GetSymbol("ChunkyMap24.class");

	/* obtain public class of that symbol - that is, load and init the */
	/* class if this has not already been done */
    mapclass = E_ObtainPublicClass(mapsymbol);

    if (mapclass == NULL)
    	crash("could not obtain public class for chunkymap24");

    /* Create the pixmaps for images */
	for (i = 0; i < 16; i++)
	{
	    pixmaps[i] = E_AllocBitMapFrame(mapclass, IMG_WIDTH, IMG_HEIGHT, 0);
		if (pixmaps[i] == NULL)
			crash("could not alloc bitmap frame");

		pixmaps[i]->Plane = maps[i];
		pixmaps[i]->BytesPerRow = 4 * IMG_WIDTH;
	}

    my_newwindow.LeftEdge = 20;
    my_newwindow.TopEdge  = 20;
    my_newwindow.Width    = WIDTH;
    my_newwindow.Height   = HEIGHT;
    my_newwindow.MinWidth = WIDTH;
    my_newwindow.MinHeight= HEIGHT;
    my_newwindow.MaxWidth = WIDTH;
    my_newwindow.MaxHeight= HEIGHT;
    my_newwindow.Screen   = NULL;
    my_newwindow.Bordef.SysGadgets =  EI_WINDOWCLOSE | EI_WINDOWFRONT | EI_WINDOWDRAG;
    my_newwindow.FirstGadgets  = NULL;
    my_newwindow.Title     = "EGSGowgah by Franky (S.U.C.K.S.)",
    my_newwindow.Flags    = EI_SMART_REFRESH | EI_GIMMEZEROZERO;
    my_newwindow.IDCMPFlags = EI_iCLOSEWINDOW;
    my_newwindow.Port     = NULL;
    my_newwindow.Menu     = NULL;
    my_newwindow.Render   = NULL;

	my_window = EI_OpenWindow(&my_newwindow);
	if (my_window == NULL)
		crash("could not open window.");

	EG_SetAPen(my_window->RPort, 0);
	EG_RectFill(my_window->RPort, 0, 0, WIDTH, HEIGHT);

	/* loop until we get an EI_iWINDOWCLOSE message */
	while (!done)
	{
/*		WaitPort(my_window->UserPort); */
		if (msg = (EI_EIntuiMsgPtr)GetMsg(my_window->UserPort))
		{
			switch (msg->Class)
			{
				case EI_iCLOSEWINDOW:
					ReplyMsg((struct Message *)msg);
					done = TRUE;
					break;

				default:
					printf(" Unknown message %ld\n", msg->Class);
					ReplyMsg((struct Message *)msg);
			}
		}

		/* do the drawing... */
		Delay(1);

		draw_randblink(10, 20, my_window->RPort);
		draw_bincount(90, 20, my_window->RPort);
		draw_enterprise(86, 40, my_window->RPort);
		draw_activity( 90, 54, my_window->RPort, 0xffd00000, 0, 4);
		draw_activity( 90, 72, my_window->RPort, 0x00ff0000, 1, 10);
		draw_activity(110, 54, my_window->RPort, 0x80ff4000, 2, 20);
		draw_activity(110, 72, my_window->RPort, 0xe0ff0000, 3, 12);

		draw_ekg(124, 48, my_window->RPort, 0);

		draw_zip(2, 120, my_window->RPort, 0);
		draw_zip(2,   6, my_window->RPort, 1);
		draw_bars(4,  88, my_window->RPort, 0);
		draw_bars(4,  98, my_window->RPort, 1);
		draw_bars(4, 108, my_window->RPort, 2);

		draw_vbars(210, 13, my_window->RPort, 0);
		draw_vbars(220, 13, my_window->RPort, 1);
		draw_vbars(230, 13, my_window->RPort, 2);
		draw_vbars(240, 13, my_window->RPort, 3);

		draw_pix(164, 48, my_window->RPort);
	}

	crash(NULL);
}

/********************/
/* draw_randblink() */
/********************/

void draw_randblink(int x, int y, EG_RastPortPtr rp)
{
	static int been_here = FALSE;
	int i, j, xp, yp;
	long r, g, b, col;

	if (been_here == FALSE)
	{
        been_here = TRUE;

		for (i = 0; i < 8; i++)
		{
            for (j = 0; j < 8; j++)
			{
				EG_SetAPen(rp, GRAY);
				EG_Move(rp, x + i * 8, y + j * 8);
				EG_Draw(rp, x + i * 8 + 5 , y + j * 8);
				EG_Draw(rp, x + i * 8 + 5 , y + j * 8 + 5);
				EG_Draw(rp, x + i * 8, y + j * 8 + 5);
				EG_Draw(rp, x + i * 8, y + j * 8);
			}
		}
	}

	xp = rand() % 8;
	yp = rand() % 8;

	r = rand() % 255;
	g = rand() % 255;
	b = rand() % 255;
	col = r << 24 | g << 16 | b << 8;

	if (rand() % 2 == 1)
	{
		if (rand() % 100 == 42)
			EG_SetAPen(rp, 0xff200000);
		else
			EG_SetAPen(rp, 0xffd00000);

		EG_RectFill(rp, x + xp * 8 + 1, y + yp * 8 + 1, 4, 4);
	}
	else
	{
		EG_SetAPen(rp, 0x00000000);
		EG_RectFill(rp, x + xp * 8 + 1, y + yp * 8 + 1, 4, 4);
	}
}

/*****************/
/* draw_bincount */
/*****************/

void draw_bincount(int x, int y, EG_RastPortPtr rp)
{
	static int been_here = FALSE;
	static unsigned char val = 0;
	static int cnt2 = 0;
	int r, g;
	int i, cnt;

	if (been_here == FALSE)
	{
        been_here = TRUE;

        for (i = 0; i < 8; i++)
		{
			EG_SetAPen(rp, GRAY);
			EG_Move(rp, x + i * 12 + 1, y);
			EG_Draw(rp, x + i * 12 + 8 , y);

			EG_Move(rp, x + i * 12 + 9, y + 1);
			EG_Draw(rp, x + i * 12 + 9, y + 8);

			EG_Move(rp, x + i * 12 + 8, y + 9);
			EG_Draw(rp, x + i * 12 + 1, y + 9);

			EG_Move(rp, x + i * 12, y + 8);
			EG_Draw(rp, x + i * 12, y + 1);
		}
	}

	cnt2++;
	if (cnt2 == 4)
	{
        cnt2 = 0;

		val++;
		if (val == 256)
			val = 0;

		cnt = 7;
		for (i = 1; i < 256; i = i << 1)
		{
    	    if (val & i)
			{
				if (rand() % 256 == 42)
					EG_SetAPen(rp, 0xff200000);
				else
				{
	        		if (val > 192)
    	    		{
						r = 0x00 + ((val - 192) * 3);
						g = 0xff - ((val - 192) * 3);
						EG_SetAPen(rp, r << 24 | g << 16);
	        		}
					else
						EG_SetAPen(rp, 0x00ff0000);
				}

				EG_RectFill(rp, x + cnt * 12 + 1, y + 1, 8, 8);
			}
			else
	   		{
				EG_SetAPen(rp, 0x00000000);
				EG_RectFill(rp, x + cnt * 12 + 1, y + 1, 8, 8);
			}
			cnt--;
		}
	}
}


/*******************/
/* draw_enterprise */
/*******************/
void draw_enterprise(int x, int y, EG_RastPortPtr rp)
{
	static int been_here = FALSE;
	static unsigned char val = 0, oldval = -1;
	static int cnt2 = 0;
	unsigned char r, g, b;
	unsigned long col;
	int i;

	if (been_here == FALSE)
	{
        been_here = TRUE;

        for (i = 0; i < 11; i++)
		{
			EG_SetAPen(rp, GRAY);
			EG_RectFill(rp, x + i * 10, y, 6, 2);
		}
 	}

	cnt2++;
	if (cnt2 == 3)
	{
        cnt2 = 0;

		if (oldval != -1)
		{
			EG_SetAPen(rp, GRAY);
			EG_RectFill(rp, x + oldval * 10, y, 6, 2);
			EG_RectFill(rp, x + (10 - oldval) * 10, y, 6, 2);
		}
		if (val < 5)
		{
			EG_SetAPen(rp, 0xffd00000);
			EG_RectFill(rp, x + val * 10, y, 6, 2);
			EG_RectFill(rp, x + (10 - val) * 10, y, 6, 2);
		}
		else
		{
			r = 0x30 + (9 - val) * 32;
			g = 0x30 + (9 - val) * 32;
			b = 0x30 + (9 - val) * 32;
			col = r << 24 | g << 16 | b << 8;

			EG_SetAPen(rp, col);
			EG_RectFill(rp, x + 5 * 10, y, 6, 2);
		}

		val++;
		if (val > 5)
		{
			oldval = -1;
			if (val == 10)
				val = 0;
		}
		else
			oldval = val - 1;

    }
}


/*****************/
/* draw_activity */
/*****************/
void draw_activity(int x, int y, EG_RastPortPtr rp, unsigned long col, int ind, int del)
{
	static int been_here[10] = FALSE;
	static int cnt2[10] = 0;
	static int defcnt[10];

	if (been_here[ind] == FALSE)
	{
        been_here[ind] = TRUE;

		EG_SetAPen(rp, 0x30303000);
    	EG_AreaCircle(rp, x, y, 6);

		EG_SetAPen(rp, 0x40404000);
    	EG_AreaCircle(rp, x, y, 5);

		EG_SetAPen(rp, 0x50505000);
    	EG_AreaCircle(rp, x-1, y-1, 4);

		EG_SetAPen(rp, 0x60606000);
    	EG_AreaCircle(rp, x-1, y-1, 3);

		EG_SetAPen(rp, 0x70707000);
	    EG_AreaCircle(rp, x-2, y-2, 2);

		EG_SetAPen(rp, 0x8f8f8f00);
    	EG_AreaCircle(rp, x-3, y-3, 1);
    	defcnt[ind] = 0;
	}

	if ( (rand() % 1024 == 42) && (defcnt[ind] == 0) )
	{
		EG_SetAPen(rp, 0x30303000 & 0xff000000);
		EG_AreaCircle(rp, x, y, 6);

		EG_SetAPen(rp, 0x50505000 & 0xff000000);
		EG_AreaCircle(rp, x, y, 5);

		EG_SetAPen(rp, 0x70707000 & 0xff000000);
		EG_AreaCircle(rp, x-1, y-1, 4);

		EG_SetAPen(rp, 0x90909000 & 0xff000000);
		EG_AreaCircle(rp, x-1, y-1, 3);

		EG_SetAPen(rp, 0xc0c0c000 & 0xff000000);
	    EG_AreaCircle(rp, x-2, y-2, 2);

		EG_SetAPen(rp, 0xffffff00 & 0xff000000);
    	EG_AreaCircle(rp, x-3, y-3, 1);

		defcnt[ind] = 50 + rand() % 100;
	}
	else
	{
		if (defcnt[ind] != 0)
			defcnt[ind]--;
		else
        {
			cnt2[ind]++;
			if (cnt2[ind] == del)
			{
				EG_SetAPen(rp, 0x30303000 & col);
    			EG_AreaCircle(rp, x, y, 6);

				EG_SetAPen(rp, 0x50505000 & col);
    			EG_AreaCircle(rp, x, y, 5);

				EG_SetAPen(rp, 0x70707000 & col);
    			EG_AreaCircle(rp, x-1, y-1, 4);

				EG_SetAPen(rp, 0x90909000 & col);
    			EG_AreaCircle(rp, x-1, y-1, 3);

				EG_SetAPen(rp, 0xc0c0c000 & col);
			    EG_AreaCircle(rp, x-2, y-2, 2);

				EG_SetAPen(rp, 0xffffff00 & col);
		    	EG_AreaCircle(rp, x-3, y-3, 1);
			}
			else if (cnt2[ind] == del * 2)
			{
				cnt2[ind] = 0;

				EG_SetAPen(rp, 0x30303000);
    			EG_AreaCircle(rp, x, y, 6);

				EG_SetAPen(rp, 0x40404000);
    			EG_AreaCircle(rp, x, y, 5);

				EG_SetAPen(rp, 0x50505000);
    			EG_AreaCircle(rp, x-1, y-1, 4);

				EG_SetAPen(rp, 0x60606000);
    			EG_AreaCircle(rp, x-1, y-1, 3);

				EG_SetAPen(rp, 0x70707000);
		    	EG_AreaCircle(rp, x-2, y-2, 2);

				EG_SetAPen(rp, 0x8f8f8f00);
    			EG_AreaCircle(rp, x-3, y-3, 1);
			}
		}
	}
}

/************/
/* draw_zip */
/************/
void draw_zip(int x, int y, EG_RastPortPtr rp, int ind)
{
	static int been_here[10] = FALSE;
	static unsigned char val[10];
	static int cnt[10];
	static int cnt2[10];
	int i;

	if (been_here[ind] == FALSE)
	{
        been_here[ind] = TRUE;

		/* minimal delay 2 seconds, max 4 seconds (200 jiffies) */
		cnt[ind] = 100 + rand() % 100;
		cnt2[ind] = 0;
		val[ind] = 0;

        for (i = 0; i < 16; i++)
		{
			EG_SetAPen(rp, GRAY);
			EG_RectFill(rp, x + i * 16, y, 10, 2);
		}
 	}

	if (cnt2[ind] == cnt[ind])
	{
		if (val[ind] > 0 && val[ind] < 17)
		{
			EG_SetAPen(rp, GRAY);
			EG_RectFill(rp, x + (val[ind] - 1) * 16, y, 10, 2);
		}
		if (val[ind] < 16)
		{
			if (rand() % 64 == 42)
				EG_SetAPen(rp, 0xff200000);
			else
				EG_SetAPen(rp, 0xffd00000);
			EG_RectFill(rp, x + val[ind] * 16, y, 10, 2);
		}
		val[ind]++;

		if (val[ind] == 17)
		{
            val[ind] = 0;
            cnt2[ind] = 0;
            cnt[ind] = 100 + rand() % 100;
		}
    }
	else
		cnt2[ind]++;
}


/*************/
/* draw_bars */
/*************/
void draw_bars(int x, int y, EG_RastPortPtr rp, int ind)
{
	static int been_here[20] = FALSE;
	static int new_val[20], cur_val[20];
	int step, diff;
	int r, g, b;

	if (been_here[ind] == FALSE)
	{
        been_here[ind] = TRUE;

		EG_SetAPen(rp, GRAY);
		EG_RectFill(rp, x, y, 200, 5);

		new_val[ind] = rand() % 200;
		cur_val[ind] = 0;
	}

	diff = abs(new_val[ind] - cur_val[ind]);
	if (diff > 20)
		step = 8;
	else if (diff > 10)
		step = 4;
	else if (diff > 5)
		step = 3;
	else
		step = 1;

	if (cur_val[ind] > new_val[ind])
		step = -step;

	cur_val[ind] += step;

	if (cur_val[ind] == new_val[ind])
		new_val[ind] = rand() % 200;


	/* critical values - remove green */
	if (cur_val[ind] > 150)
	{
		r = 0xff - ((cur_val[ind] - 150) * 4);
		g = 0xd0 - ((cur_val[ind] - 150) * 2);
		b = 0x00 + ((cur_val[ind] - 150) * 5);
		EG_SetAPen(rp, r << 24 | g << 16 | b << 8);
	}
	else
		EG_SetAPen(rp, 0xffd00000);

	EG_RectFill(rp, x, y, cur_val[ind], 5);
	EG_SetAPen(rp, GRAY);
	EG_RectFill(rp, x + cur_val[ind], y, 200 - cur_val[ind], 5);
}



/**************/
/* draw_vbars */
/**************/
void draw_vbars(int x, int y, EG_RastPortPtr rp, int ind)
{
	static int been_here[20] = FALSE;
	static int new_val[20], cur_val[20];
	int step, diff, g;

	if (been_here[ind] == FALSE)
	{
        been_here[ind] = TRUE;

		EG_SetAPen(rp, GRAY);
		EG_RectFill(rp, x, y, 8, 100);

		new_val[ind] = rand() % 100;
		cur_val[ind] = 0;
	}

	diff = abs(new_val[ind] - cur_val[ind]);
	if (diff > 20)
		step = 8;
	else if (diff > 10)
		step = 4;
	else if (diff > 5)
		step = 3;
	else
		step = 1;

	if (cur_val[ind] > new_val[ind])
		step = -step;

	cur_val[ind] += step;

	if (cur_val[ind] == new_val[ind])
		new_val[ind] = rand() % 100;

	/* critical values - remove green */
	if (cur_val[ind] < 40)
	{
		g = 0xd0 - ((40 - cur_val[ind]) * 4);
		EG_SetAPen(rp, 0xff000000 | g << 16);
	}
	else
		EG_SetAPen(rp, 0xffd00000);

	EG_RectFill(rp, x, y + cur_val[ind], 8, 100 - cur_val[ind]);
	EG_SetAPen(rp, GRAY);
	EG_RectFill(rp, x, y, 8, cur_val[ind]);
}


/************/
/* draw_ekg */
/************/
void draw_ekg(int x, int y, EG_RastPortPtr rp, int ind)
{
	static int been_here[20] = FALSE;
	static int red_val[20], grn_val[20], grn_dir[20], oldgrn[20], real_grn[20];
	int xp;

	if (been_here[ind] == FALSE)
	{
        been_here[ind] = TRUE;

		EG_SetAPen(rp, GRAY);
		EG_Move(rp, x, y);
		EG_Draw(rp, x + 31, y);
		EG_Draw(rp, x + 31, y + 31);
		EG_Draw(rp, x, y + 31);
		EG_Draw(rp, x, y);
		grn_val[ind] = 15;
		grn_dir[ind] = 1;
		oldgrn[ind] = 15;
	}

	red_val[ind]++;
	if (red_val[ind] > 17)
	{
		xp = 5 + rand() % 2;
	}
	else
	{
		xp = 25 + rand() % 2;
	}
	if (red_val[ind] == 34)
		red_val[ind] = 0;

	EG_SetAPen(rp, 0xff000000);
	if (red_val[ind] == 0 || red_val[ind] == 17)
	{
		EG_Move(rp, x + 5, y + 29);
		EG_Draw(rp, x + 25, y + 29);
	}
	EG_WritePixel(rp, x + xp, y + 29);

	grn_val[ind] += grn_dir[ind];
	if (grn_val[ind] == 25)
	{
        grn_val[ind] = 24;
        grn_dir[ind] = -1;
	}
	else if (grn_val[ind] == 4)
	{
        grn_val[ind] = 5;
        grn_dir[ind] = 1;
	}
	real_grn[ind] = grn_val[ind] + rand() % 5;
	EG_SetAPen(rp, 0xffd00000);
	EG_Move(rp, x + oldgrn[ind], y + 28);
    EG_Draw(rp, x + real_grn[ind], y + 29);

	oldgrn[ind] = real_grn[ind];

//	EG_WritePixel(rp, x + grn_val[ind] + rand() % 3, y + 29);

/*
	xp = rand() % 30;
	yp = rand() % 29;
	EG_WritePixel(rp, x + xp + 1, y + yp + 1);
*/

	EG_ScrollRasterNoClear(rp, x + 1, y + 1, 30, 30, 0, 1);
}


/*****************************************/
/* draw_pix - draws various small images */
/*****************************************/
void draw_pix(int x, int y, EG_RastPortPtr rp)
{
	static int been_here = FALSE;
	static int num = 0, delay = 0, del2 = 0, noise = 0;

	if (been_here == FALSE)
	{
        been_here = TRUE;

		EG_SetAPen(rp, GRAY);
		EG_Move(rp, x, y);
		EG_Draw(rp, x + 31, y);
		EG_Draw(rp, x + 31, y + 31);
		EG_Draw(rp, x, y + 31);
		EG_Draw(rp, x, y);
		/* min delay 2 seconds, max 4 seconds */
		delay = rand() % 100 + 100;
	}

	if (delay)
	{
		delay--;
		noise++;
		if (noise == 8)
			noise = 0;
		EG_CopyBitMapRastPort(pixmaps[noise], rp, 0, 0, IMG_WIDTH, IMG_HEIGHT, x + 1, y + 1);
	}
	else
	{
		if (del2 == 0)
		{
			del2 = rand() % 50 + 50;
			num = rand() % 8 + 8;
			EG_CopyBitMapRastPort(pixmaps[num], rp, 0, 0, IMG_WIDTH, IMG_HEIGHT, x + 1, y + 1);
		}

		del2--;
		if (del2 == 0)
			delay = rand() % 100 + 100;
		/* the next time this function is called, we are automatically placed */
		/* in the upper part of the if when delay was set to a new value here */
	}
}


/**************************************************/
/* crash function - frees all allocated resources */
/**************************************************/
void crash(char * string)
{
	int i;

	for (i = 0; i < 16; i++)
	{
		if (pixmaps[i])
			E_DisposeBitMapFrame(pixmaps[i]);
	}

	if (mapclass)
		E_ReleaseClass(mapclass);

	if (my_window)
		EI_CloseWindow(my_window);

	if (EGSGfxBase != NULL)
		CloseLibrary(EGSGfxBase);

	if (EGSIntuiBase != NULL)
		CloseLibrary(EGSIntuiBase);

	if (EGSBase != NULL)
		CloseLibrary(EGSBase);

	if (NULL == string)
		exit (0);
	else
    {
    	printf ("%s.\n", string);
    	exit (10);
    }
}

