/*
 * amiga.c
 * Amiga specific graphic routines for Thrust.
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#undef USE_INLINE_STDARG

#if defined(HAVE_GETOPT_H) && defined(HAVE_GETOPT_LONG_ONLY)
# include <getopt.h>
#elif !defined(HAVE_GETOPT_LONG_ONLY)
# include "getopt.h"
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <cybergraphx/cgxvideo.h>
#include <cybergraphx/cybergraphics.h>
#include <exec/types.h>
#include <exec/libraries.h>
#include <libraries/iffparse.h>

#include <proto/cgxvideo.h>
#include <proto/cybergraphics.h>
#include <proto/intuition.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/muimaster.h>

#include "thrust.h"
#include "fast_gr.h"
#include "gr_drv.h"
#include "options.h"

#include "morphos.h"

#define SCREEN_WIDTH  320
#define SCREEN_HEIGHT 200
#define	SCALE_MULTIPLIER	16384

static UBYTE framebuffer[SCREEN_WIDTH * SCREEN_HEIGHT];
static ULONG palette[256];

unsigned char *gfxbuf = framebuffer;  /* gfx buffer - same dimensions as fb */
ULONG rtgwidth = SCREEN_WIDTH, rtgheight = SCREEN_HEIGHT, totalsize = SCREEN_WIDTH*SCREEN_HEIGHT;

static struct timerequest   *timer_io;
static struct MsgPort *timer_port;
static LONG timer_open = -1;

static struct MUI_CustomClass *CL_Display = NULL;
static APTR app;
APTR display;

/**********************************************************************
	mNew
**********************************************************************/

ULONG mNew(struct IClass *cl, Object *obj, struct opSet *msg)
{
	if (obj = (Object *)DoSuperMethodA(cl, obj, (Msg)msg))
	{
		struct Display_Data	*data	= (struct Display_Data *)INST_DATA(cl, obj);

        data->KeyList.mlh_Head		= (struct MinNode *)&data->KeyList.mlh_Tail;
        data->KeyList.mlh_TailPred	= (struct MinNode *)&data->KeyList.mlh_Head;

        data->ehnode.ehn_Object    = obj;
        data->ehnode.ehn_Class     = cl;
        data->ehnode.ehn_Events    = IDCMP_RAWKEY;

        InitRastPort(&data->RastPort);
	}

	return (ULONG)obj;
}

/**********************************************************************
	mShow
**********************************************************************/

static ULONG mShow(struct IClass *cl, Object *obj, Msg msg, struct Display_Data *data)
{
    ULONG	rc;

    if (rc = DoSuperMethodA(cl, obj, msg))
    {
        DRAWMODE    mode;
        ULONG   mwidth, mheight;

        DoMethod(_win(obj), MUIM_Window_AddEventHandler, &data->ehnode);

        mwidth  = _mwidth(obj);
        mheight = _mheight(obj);
        mode    = DRAW_DIRECT;

        data->width     = mwidth;
        data->height    = mheight;

        if (mwidth != SCREEN_WIDTH || mheight != SCREEN_HEIGHT)
        {
            struct Screen *screen = _screen(obj);
            ULONG   depth;

            data->VLayer    = CreateVLayerHandleTags(screen,
                VOA_SrcType, SRCFMT_RGB16,
                VOA_SrcWidth, SCREEN_WIDTH,
                VOA_SrcHeight, SCREEN_HEIGHT,
                VOA_UseColorKey, TRUE,
                VOA_UseBackfill, TRUE,
            TAG_DONE);

            if (data->VLayer)
            {
                struct Window *window = _window(obj);
                ULONG   mleft, mtop;

                mleft   = _mleft(obj);
                mtop    = _mtop(obj);

                if (!AttachVLayerTags(data->VLayer, window,
                    VOA_TopIndent, mtop - window->BorderTop,
                    VOA_LeftIndent, mleft - window->BorderLeft,
                    VOA_RightIndent, window->Width - mleft - mwidth - window->BorderRight - 1,
                    VOA_BottomIndent, window->Height - mtop - mheight - window->BorderBottom - 1,
                TAG_DONE))
                {
                    mode = DRAW_OVERLAY;
                    goto done;
                }
                else
                {
                    DeleteVLayerHandle(data->VLayer);
                    data->VLayer = NULL;
                }
            }

            data->pixfmt            = GetCyberMapAttr(screen->RastPort.BitMap, CYBRMATTR_PIXFMT);
            depth                   = GetBitMapAttr(screen->RastPort.BitMap, BMA_DEPTH);
            data->RastPort.BitMap   = AllocBitMap(mwidth, mheight, depth, BMF_DISPLAYABLE|BMF_MINPLANES, screen->RastPort.BitMap);
            mode                    = DRAW_SCALED;

            if (data->RastPort.BitMap == NULL)
            {
                CoerceMethod(cl, obj, MUIM_Hide);
                rc = FALSE;
            }
        }

done:
        data->DrawMode = mode;
    }

    return rc;
}

/**********************************************************************
	mHide
**********************************************************************/

static VOID mHide(Object *obj, struct Display_Data *data)
{
    DoMethod(_win(obj), MUIM_Window_RemEventHandler, &data->ehnode);

    if (data->VLayer)
    {
        DetachVLayer(data->VLayer);
        DeleteVLayerHandle(data->VLayer);
    }

    FreeBitMap(data->RastPort.BitMap);

    data->VLayer            = NULL;
    data->RastPort.BitMap   = NULL;
}

/**********************************************************************
	mAskMinMax
**********************************************************************/

static ULONG mAskMinMax(struct IClass *cl, Object *obj, struct MUIP_AskMinMax *msg)
{
	DoSuperMethodA(cl, obj, (Msg)msg);
	msg->MinMaxInfo->MinWidth	+= SCREEN_WIDTH;
	msg->MinMaxInfo->MinHeight	+= SCREEN_HEIGHT;
	msg->MinMaxInfo->MaxWidth	+= MUI_MAXMAX;
	msg->MinMaxInfo->MaxHeight	+= MUI_MAXMAX;
	msg->MinMaxInfo->DefWidth	+= SCREEN_WIDTH;
	msg->MinMaxInfo->DefHeight	+= SCREEN_HEIGHT;
	return 0;
}

/**********************************************************************
	mUpdatePalette
**********************************************************************/

static ULONG mUpdatePalette(struct Display_Data *data)
{
	ULONG	i, *tmp, *src, *dst, pixfmt;
	UWORD	*overlay;

	src		= palette;
	dst		= data->ScreenColors;
	overlay	= data->OverlayColors;
	tmp		= src;

	// Colour table for an overlay

	for (i = 0; i < 256; i++)
	{
		ULONG	col, green;
		UWORD	newcol;

		col	= *tmp++;

		newcol   = ((col & 0xf8) << 5);	// Blue
		green    = ((col & 0xfc00) >> 10);
		newcol	|= ((col & 0xf80000) >> 16);
		newcol	|= green >> 3;
		newcol	|= green << 13;

		*overlay++	= newcol;
	}

	if (data->pixfmt != PIXFMT_LUT8)
	{
		switch (data->pixfmt)
		{
			case PIXFMT_ARGB32	: CopyMemQuick(src, dst, 256 * sizeof(ULONG)); break;

			case PIXFMT_BGRA32	:
			{
				for (i = 0; i < 256; i++)
				{
					ULONG	col	= *src++;

					*dst++	= ((col & 0xff) << 24) | ((col & 0xff00) << 8) | ((col >> 8) & 0xff00);
				}
			}
			break;

			case PIXFMT_RGBA32	:
			{
				for (i = 0; i < 256; i++)
					*dst++	= *src++ << 8;
			}
			break;

			case PIXFMT_BGR24		:
			{
				UBYTE	*tmp	= (UBYTE *)dst;

				for (i = 0; i < 256; i++)
				{
					ULONG	col	= *src++;

					*tmp++	= col;
					*tmp++	= col >> 8;
					*tmp++	= col >> 24;
				}
			}
			break;

			case PIXFMT_RGB24		:
			{
				UBYTE	*tmp	= (UBYTE *)dst;

				for (i = 0; i < 256; i++)
				{
					ULONG	col	= *src++;

					*tmp++	= col >> 24;
					*tmp++	= col >> 8;
					*tmp++	= col;
				}
			}
			break;

			case PIXFMT_RGB16PC		:
			{
				UWORD	*tmp	= (UWORD *)dst;

				for (i = 0; i < 256; i++)
				{
					ULONG	col, green;
					UWORD	newcol;

					col	= *src++;

					newcol	 = ((col & 0xf8) << 5);	// Blue
					green    = ((col & 0xff00) >> 10);
					newcol	|= ((col & 0xf80000) >> 16);
					newcol	|= green >> 3;
					newcol	|= green << 13;

					*tmp++	= newcol;
				}
			}
			break;

			case PIXFMT_RGB16		:
			{
				UWORD	*tmp	= (UWORD *)dst;

				for (i = 0; i < 256; i++)
				{
					ULONG	col;
					UWORD	newcol;

					col	= *src++;

					newcol	 = ((col & 0xff) >> 3);	// Blue
					newcol	|= ((col & 0xfc00) >> 5);
					newcol	|= ((col & 0xf80000) >> 8);

					*tmp++	= newcol;
				}
			}
			break;

			case PIXFMT_RGB15PC		:
			{
				UWORD	*tmp	= (UWORD *)dst;

				for (i = 0; i < 256; i++)
				{
					ULONG	col, green;
					UWORD	newcol;

					col	= *src++;

					newcol	 = ((col & 0xf8) << 8);	// Blue
					green    = ((col & 0xf800) >> 11);
					newcol	|= ((col & 0xf80000) >> 17);
					newcol	|= green >> 3;
					newcol	|= green << 13;

					*tmp++	= newcol;
				}
			}
			break;

			case PIXFMT_RGB15			:
			{
				UWORD	*tmp	= (UWORD *)dst;

				for (i = 0; i < 256; i++)
				{
					ULONG	col;
					UWORD	newcol;

					col	= *src++;

					newcol	 = ((col & 0xf8) >> 3);	// Blue
					newcol	|= ((col & 0xf800) >> 6);
					newcol	|= ((col & 0xf80000) >> 9);

					*tmp++	= newcol;
				}
			}
			break;
		}
	}

    return 0;
}

/**********************************************************************
	mRender16
**********************************************************************/

static VOID mRender16(CONST UWORD *table, CONST UBYTE *chunky, UWORD *buf, ULONG offset)
{
	ULONG	i;

	for (i = 0; i < SCREEN_HEIGHT; i++)
	{
		ULONG	j;
		UWORD	*tmp;

		tmp		= buf;

		for (j = 0; j < SCREEN_WIDTH; j++)
			*tmp++	= table[ chunky[ j ] ];

		chunky	+= SCREEN_WIDTH;
		buf		+= offset / 2;
	}
}

/**********************************************************************
	mDo16
**********************************************************************/

static VOID mDo16(struct RastPort *rp, CONST UBYTE *chunky, UWORD *buf, ULONG width, ULONG height, ULONG offset, CONST UWORD *table, ULONG x, ULONG y)
{
	ULONG	yy, i, tail, prev_z;

	tail		 = width % SCREEN_WIDTH;
	yy			 = 0;
	prev_z	 = 1;
	i			 = 0;
	width		-= tail;

	do
	{
		if (prev_z == (yy / SCALE_MULTIPLIER))
		{
			MovePixelArray(0, i-1, rp, 0, i, width + tail, 1);
		}
		else
		{
			ULONG	j, z;
			UWORD	*tmp;

			tmp		= buf;
			prev_z	= yy / SCALE_MULTIPLIER;
			z			= 0;
			j			= width;

			do
			{
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
				j	-= 3;
			}
			while (j);

			for (j = 0; j < tail; j++)
			{
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
			}

			chunky	+= SCREEN_WIDTH;
		}

		height--;
		i++;
		yy		+= y;
		buf	+= offset / 2;
	}
	while (height);
}

/**********************************************************************
	mDo24
**********************************************************************/

static VOID mDo24(struct RastPort *rp, CONST UBYTE *chunky, UBYTE *buf, ULONG width, ULONG height, ULONG offset, CONST UBYTE *table, ULONG x, ULONG y)
{
	ULONG	yy, i, tail, prev_z;

	tail		 = width % SCREEN_WIDTH;
	yy			 = 0;
	prev_z	 = 1;
	i			 = 0;
	width		-= tail;

	do
	{
		if (prev_z == (yy / SCALE_MULTIPLIER))
		{
			MovePixelArray(0, i-1, rp, 0, i, width + tail, 1);
		}
		else
		{
			ULONG	j, z;
			UBYTE	*tmp;

			prev_z	= yy / SCALE_MULTIPLIER;
			tmp		= buf;
			z			= 0;
			j			= width;

			do
			{
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] * 3 + 0 ];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] * 3 + 1];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] * 3 + 2];
				z	+= x;
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER  ] * 3 + 0 ];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER  ] * 3 + 1];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER  ] * 3 + 2];
				z	+= x;
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER  ] * 3 + 0 ];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER  ] * 3 + 1];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER  ] * 3 + 2];
				z	+= x;
				j	-= 3;
			}
			while (j);

			for (j = 0; j < tail; j++)
			{
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] * 3 + 0];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] * 3 + 1];
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] * 3 + 2];
				z	+= x;
			}

			chunky	+= SCREEN_WIDTH;
		}

		height--;
		i++;
		yy		+= y;
		buf	+= offset;
	}
	while (height);
}

/**********************************************************************
	mDo32
**********************************************************************/

static VOID mDo32(struct RastPort *rp, CONST UBYTE *chunky, ULONG *buf, ULONG width, ULONG height, ULONG offset, CONST ULONG *table, ULONG x, ULONG y)
{
	ULONG	yy, i, tail, prev_z;

	tail		 = width % SCREEN_WIDTH;
	prev_z	 = 1;
	width		-= tail;
	yy			 = 0;
	i			 = 0;

	do
	{
		if (prev_z == (yy / SCALE_MULTIPLIER))
		{
			MovePixelArray(0, i-1, rp, 0, i, width + tail, 1);
		}
		else
		{
			ULONG	*tmp, j, z;

			prev_z	= yy / SCALE_MULTIPLIER;
			tmp		= buf;
			z			= 0;
			j			= width;

			do
			{
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
				j	-= 3;
			}
			while (j);

			for (j = 0; j < tail; j++)
			{
				*tmp++	= table[ chunky[ z / SCALE_MULTIPLIER ] ];
				z	+= x;
			}

			chunky	+= SCREEN_WIDTH;
		}

		height--;
		i++;
		yy		+= y;
		buf	+= offset / 4;
	}
	while (height);
}

/**********************************************************************
	mStretch
**********************************************************************/

static VOID mStretch(struct Display_Data *data, CONST UBYTE *chunky)
{
	ULONG	address, bm_offset;
	APTR	handle;

	if (handle = LockBitMapTags(data->RastPort.BitMap, LBMI_BASEADDRESS, &address, LBMI_BYTESPERROW, &bm_offset, TAG_DONE))
	{
		ULONG	format	= data->pixfmt;

		if (format > PIXFMT_LUT8 && format <= PIXFMT_RGBA32)
		{
			ULONG		x, y;

			x	= (SCREEN_WIDTH * SCALE_MULTIPLIER) / data->width;
			y	= (SCREEN_HEIGHT * SCALE_MULTIPLIER) / data->height;

			if (format >= PIXFMT_ARGB32)
			{
				mDo32(&data->RastPort, chunky, (ULONG *)address, data->width, data->height, bm_offset, data->ScreenColors, x, y);
			}
			else if (format >= PIXFMT_RGB24)
			{
				mDo24(&data->RastPort, chunky, (UBYTE *)address, data->width, data->height, bm_offset, (UBYTE *)&data->ScreenColors, x, y);
			}
			else
			{
				mDo16(&data->RastPort, chunky, (UWORD *)address, data->width, data->height, bm_offset, (UWORD *)&data->ScreenColors, x, y);
			}
		}

		UnLockBitMap(handle);
	}
}

/**********************************************************************
	mHandleEvent
**********************************************************************/

static ULONG mHandleEvent(struct Display_Data *data, struct MUIP_HandleEvent *msg)
{
	struct IntuiMessage	*imsg;
	ULONG	ret;

	imsg	= msg->imsg;
	ret	= 0;

	if (imsg)
    {
    	if (imsg->Class == IDCMP_RAWKEY)
	    {
		    UWORD	code	= imsg->Code;

    		switch (code)
	    	{
		    	default:
			    {
				    struct KeyNode	*kn;

	    			if (kn = (struct KeyNode *)AllocTaskPooled(sizeof(*kn)))
		    		{
			    		kn->Code	= code;
   						ADDTAIL(&data->KeyList, kn);
					}
				}
			}

    		ret	= MUI_EventHandlerRC_Eat;
        }
	}

	return ret;
}

/**********************************************************************
    mGetKey
**********************************************************************/

static ULONG mGetKey(struct Display_Data *data, struct MUIP_Display_GetKey *msg)
{
    struct KeyNode  *kn;
    ULONG   rc;

    kn  = REMHEAD(&data->KeyList);
    rc  = 0;

    if (kn)
    {
        *msg->key   = kn->Code;
        FreeTaskPooled(kn, sizeof(*kn));
        rc  = 1;
    }

    return rc;
}

/**********************************************************************
	mDrawDisplay
**********************************************************************/

static ULONG mDrawDisplay(Object *obj)
{
	return MUI_Redraw(obj, MADF_DRAWUPDATE);
}

/**********************************************************************
	mDraw
**********************************************************************/

static ULONG mDraw(struct IClass *cl, Object *obj, struct MUIP_Draw *msg, struct Display_Data *data)
{
    struct RastPort *rp;
    ULONG mleft, mtop, mwidth, mheight;

    DoSuperMethodA(cl, obj, msg);

	mleft   = _mleft(obj);
	mtop    = _mtop(obj);
	mwidth  = data->width;
	mheight = data->height;
	rp      = _rp(obj);

    switch (data->DrawMode)
    {
        case DRAW_DIRECT:
            WriteLUTPixelArray(gfxbuf, 0, 0, SCREEN_WIDTH, rp, &palette, mleft, mtop, SCREEN_WIDTH, SCREEN_HEIGHT, CTABFMT_XRGB8);
            break;

        case DRAW_OVERLAY:
            if (LockVLayer(data->VLayer))
            {
                UWORD   *srcdata;
                srcdata	= (UWORD *)GetVLayerAttr((struct VLayerHandle *)data->VLayer, VOA_BaseAddress);
                mRender16((const UWORD *)&data->OverlayColors, (CONST UBYTE *)&framebuffer, srcdata, SCREEN_WIDTH * sizeof(UWORD));
                UnlockVLayer(data->VLayer);
            }
            break;

        case DRAW_SCALED:
            mStretch(data, (CONST UBYTE *)&framebuffer);
            BltBitMapRastPort(data->RastPort.BitMap, 0, 0, rp, mleft, mtop, mwidth, mheight, 0xc0);
            break;
    }

    return 0;
}

/**********************************************************************
	mDispatcher
**********************************************************************/

static ULONG mDispatcherCode(void)
{
	struct IClass	*cl	= (struct IClass *)REG_A0;
	Object *obj	= (Object *)REG_A2;
	Msg msg	= (Msg)REG_A1;

	struct Display_Data	*data	= (struct Display_Data *)INST_DATA(cl, obj);

	switch (msg->MethodID)
	{
        case OM_NEW                     : return mNew           (cl, obj, (APTR)msg);
		case MUIM_AskMinMax             : return mAskMinMax     (cl, obj, (APTR)msg);
        case MUIM_Hide                  :        mHide          (obj, data); break;
		case MUIM_Draw                  : return mDraw          (cl, obj, (APTR)msg, data);
        case MUIM_HandleEvent           : return mHandleEvent   (data, (APTR)msg);
        case MUIM_Show                  : return mShow          (cl, obj, msg, data);
        case MUIM_Display_GetKey        : return mGetKey        (data, (APTR)msg);
		case MUIM_Display_Update        : return mDrawDisplay   (obj);
        case MUIM_Display_UpdatePalette : return mUpdatePalette (data);
	}

    return DoSuperMethodA(cl, obj, msg);
}

struct EmulLibEntry mDispatcher = { TRAP_LIB, 0, (void (*)())&mDispatcherCode };

void clearscr(void)
{
	memset(gfxbuf,0,totalsize);
}

#ifndef __VBCC__ /* inlined */
void putarea(unsigned char *source, int x, int y, int width, int height,
             int bytesperline, int destx, int desty)
{
  int ix;
  unsigned char *s = source+(y*bytesperline)+x;

  unsigned char *d = gfxbuf+(desty*rtgwidth)+destx;

  int smod = bytesperline - width;
  int dmod = rtgwidth - width;

  for (; height>0; height--,s+=smod,d+=dmod)
    for (ix=0; ix<width; ix++,*d++=*s++);
}
#endif


static ULONG signals = 0;

void usleep(unsigned long time)
{
    ULONG timersig;

    timer_io->tr_time.tv_secs = 0;
    timer_io->tr_time.tv_micro = time;

    SendIO((struct IORequest *)timer_io);

    timersig = 1 << timer_port->mp_SigBit;

	for (;;)
	{
		DoMethod(app, MUIM_Application_NewInput, &signals);

		if (signals)
		{
			signals	= Wait(signals | timersig);

			if (signals & timersig && GetMsg(timer_port))
				break;
		}
	}
}

void syncscreen(void)
{
    usleep(20000);
}


void displayscreen(void)
{
    DoMethod(display, MUIM_Display_Update);
}


void fadepalette(int first, int last, unsigned char *rgb, int fade, int flag)
{
    fade = fade << 2;

    do
    {
        ULONG r, g, b;

        r   = *rgb++;
        g   = *rgb++;
        b   = *rgb++;

        r   = (((r * fade) >> 8) & 0xff) << 16;
        g   = (((g * fade) >> 8) & 0xff) << 8;
        b   = (((b * fade) >> 8) & 0xff);

        palette[first] = r | g | b;

        first++;
    }
    while (first <= last);

    if(flag)
        syncscreen();

    DoMethod(display, MUIM_Display_UpdatePalette);
    displayscreen();
}


void fade_in(void)
{
  int i;

  for(i=0; i<=64; i+=4)
    fadepalette(0, 255, bin_colors, i, 1);
}


void fade_out(void)
{
  int i;

  for(i=64; i; i-=4)
    fadepalette(0, 255, bin_colors, i, 1);
  clearscr();
  displayscreen();
  usleep(200000L);
}


void graphics_preinit(void)
{
}


int graphicsinit(int argc, char **argv)
{
    static CONST CONST_STRPTR ClassList[] = { NULL };

    CL_Display  = MUI_CreateCustomClass(NULL, MUIC_Area, NULL, sizeof(struct Display_Data), (APTR)&mDispatcher);
	timer_port  = CreateMsgPort();
    timer_io    = (struct timerequest *)CreateIORequest(timer_port, sizeof(struct timerequest));

    if (CL_Display && timer_io)
    {
        timer_open  = OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest *)timer_io, 0);

        if (timer_open == 0)
        {
            APTR win;

			timer_io->tr_node.io_Command = TR_ADDREQUEST;

            app = ApplicationObject,
                MUIA_Application_UsedClasses, (ULONG)&ClassList,
                MUIA_Application_Title, "AmigaThrust",
                MUIA_Application_Version, "AmigaThrust V0.83c",
                MUIA_Application_Copyright, "Peter Ekberg, Frank Wille, Juha Niemimäki, Ilkka Lehtoranta",
                MUIA_Application_Author, "Peter Ekbergk, Frank Wille (AmigaOS), Juha Niemimäki (AmigaOS 4.0), Ilkka Lehtoranta (MorphOS)",
                MUIA_Application_Description, "MorphOS port of XThrust",
                MUIA_Application_Base, "AMIGATHRUST",
                SubWindow, win = WindowObject,
                    MUIA_Window_CloseGadget, FALSE,
                    MUIA_Window_Title, "AmigaThrust",
                    MUIA_Window_ID, MAKE_ID('M','A','I','N'),
                    MUIA_Window_DisableKeys, 0xffffffff,
                    WindowContents, VGroup,
                        Child, display = NewObject(CL_Display->mcc_Class, NULL,
                            ReadListFrame,
                            MUIA_FillArea, FALSE,
                        End,
                    End,
                End,
            End;

            if (app)
            {
                set(win, MUIA_Window_Open, TRUE);
                fadepalette(0, 255, bin_colors, 1, 0);
                return (0);
            }
        }
    }

    graphicsclose();

    return (-1);
}


int graphicsclose(void)
{
    MUI_DisposeObject(app);

    if (CL_Display)
        MUI_DeleteCustomClass(CL_Display);

    if (timer_open == 0)
    {
        timer_open = -1;
        CloseDevice((struct IORequest *)timer_io);
    }

    DeleteIORequest(timer_io);
    DeleteMsgPort(timer_port);

    CL_Display  = NULL;
    app         = NULL;
    timer_io    = NULL;
    timer_port  = NULL;

    return (0);
}


char *graphicsname(void)
{
  static const char name[] = "MorphOS";

  return (char *)name;
}
