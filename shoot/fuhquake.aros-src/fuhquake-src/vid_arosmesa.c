#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <intuition/extensions.h>
#include <cybergraphx/cybergraphics.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/cybergraphics.h>
#include <GL/arosmesa.h>

#include "quakedef.h"
#include "input.h"
#include "keys.h"
#include "gl_local.h"

#define WARP_WIDTH		320
#define WARP_HEIGHT		200

AROSMesaContext __amContext;

extern viddef_t vid;

struct Screen *screen = 0;
struct Window *window = 0;

static void *pointermem;

qboolean vid_hwgamma_enabled = false;

char pal[256*4];

cvar_t _windowed_mouse = {"_windowed_mouse", "1", CVAR_ARCHIVE};

static unsigned int lastwindowedmouse;

int real_width, real_height;

void VID_Init(unsigned char *palette)
{
	int argnum;

	//int r;

	int i;

	int depth = 24;

	Cvar_Register(&_windowed_mouse);

	vid.width = 640;
	vid.height = 480;
	vid.maxwarpwidth = WARP_WIDTH;
	vid.maxwarpheight = WARP_HEIGHT;
	vid.numpages = 1;
	vid.colormap = host_colormap;
	vid.fullbright = 256 - LittleLong (*((int *)vid.colormap + 2048));

	argnum = COM_CheckParm("-width");
	if (argnum)
	{
		if (argnum >= com_argc - 1)
			Sys_Error("VID: -width <width>");

		vid.width = Q_atoi(com_argv[argnum+1]);

		if (vid.width == 0)
			Sys_Error("VID: Bad width");
	}

	argnum = COM_CheckParm("-height");
	if (argnum)
	{
		if (argnum >= com_argc - 1)
			Sys_Error("VID: -height <height>");

		vid.height = Q_atoi(com_argv[argnum+1]);

		if (vid.height == 0)
			Sys_Error("VID: Bad height");
	}

	argnum = COM_CheckParm("-depth");
	if (argnum)
	{
		if (argnum >= com_argc - 1)
			Sys_Error("VID: -depth <depth>");

		depth = Q_atoi(com_argv[argnum+1]);

		if (depth != 15 && depth != 16 && depth != 24)
			Sys_Error("VID: Bad depth");
	}

	if (vid.width <= 640)
	{
		vid.conwidth = vid.width;
		vid.conheight = vid.height;
	}
	else
	{
		vid.conwidth = vid.width/2;
		vid.conheight = vid.height/2;
	}

	if ((i = COM_CheckParm("-conwidth")) && i + 1 < com_argc)
	{
		vid.conwidth = Q_atoi(com_argv[i + 1]);

		// pick a conheight that matches with correct aspect
		vid.conheight = vid.conwidth * 3 / 4;
	}

	vid.conwidth &= 0xfff8; // make it a multiple of eight

	if ((i = COM_CheckParm("-conheight")) && i + 1 < com_argc)
		vid.conheight = Q_atoi(com_argv[i + 1]);

	if (vid.conwidth < 320)
		vid.conwidth = 320;

	if (vid.conheight < 200)
		vid.conheight = 200;

    vid.rowbytes = vid.width;
	vid.direct = 0; /* Isn't used anywhere, but whatever. */
	vid.aspect = ((float)vid.height / (float)vid.width) * (320.0 / 240.0);

	argnum = COM_CheckParm("-window");

	if (argnum == 0)
	{
		ULONG modeid = INVALID_ID;

			modeid = BestCModeIDTags(
				CYBRBIDTG_Depth, depth,
				CYBRBIDTG_NominalWidth, vid.width,
				CYBRBIDTG_NominalHeight, vid.height,
				TAG_DONE);

		if (modeid != INVALID_ID)
		{
			screen = OpenScreenTags(0,
				modeid!=INVALID_ID?SA_DisplayID:TAG_IGNORE, modeid,
				SA_Width, vid.width,
				SA_Height, vid.height,
				SA_Depth, depth,
				SA_Quiet, TRUE,
                SA_ShowTitle, FALSE,
				TAG_DONE);
		}
	}

	window = OpenWindowTags(0,
		WA_InnerWidth, vid.width,
		WA_InnerHeight, vid.height,
		WA_Title, "Fuhquake",
		WA_DragBar, screen?FALSE:TRUE,
		WA_DepthGadget, screen?FALSE:TRUE,
		WA_Borderless, screen?TRUE:FALSE,
		WA_RMBTrap, TRUE,
        screen?WA_CustomScreen:TAG_IGNORE, (ULONG)screen,
		WA_Activate, TRUE,
		TAG_DONE);

	if (window == 0)
		Sys_Error("Unable to open window");

    __amContext = AROSMesaCreateContextTags(
        AMA_Window, (IPTR)window,
        AMA_Left, screen?0:window->BorderLeft,
        AMA_Top, screen?0:window->BorderTop,
        AMA_Width, vid.width,
        AMA_Height, vid.height,
        screen?AMA_Screen:TAG_IGNORE, (ULONG)screen,
        AMA_DoubleBuf, GL_TRUE,
        AMA_RGBMode, GL_TRUE,
        AMA_NoStencil, GL_TRUE,
        AMA_NoAccum, GL_TRUE,
        TAG_DONE);
        
    if (__amContext == 0)
	{
		Sys_Error("Unable to initialize GL context");
	}

    AROSMesaMakeCurrent(__amContext);

	pointermem = AllocVec(256, MEMF_ANY|MEMF_CLEAR);
	if (pointermem == 0)
	{
		Sys_Error("Unable to allocate memory for mouse pointer");
	}

	SetPointer(window, pointermem, 16, 16, 0, 0);

	lastwindowedmouse = 1;

	real_width = vid.width;
	real_height = vid.height;

	if (vid.conheight > vid.height)
		vid.conheight = vid.height;
	if (vid.conwidth > vid.width)
		vid.conwidth = vid.width;

	vid.width = vid.conwidth;
	vid.height = vid.conheight;

	GL_Init();

	Check_Gamma(palette);

	VID_SetPalette(palette);

	vid.recalc_refdef = 1;
}

void VID_Shutdown()
{
    if (__amContext)
    {
        AROSMesaDestroyContext(__amContext);
    }
    

	if (window)
	{
		CloseWindow(window);
		window = 0;
	}

	if (pointermem)
	{
		FreeVec(pointermem);
		pointermem = 0;
	}

	if (screen)
	{
		CloseScreen(screen);
		screen = 0;
	}
}

void VID_ShiftPalette(unsigned char *p)
{
	VID_SetPalette(p);
}

void Sys_SendKeyEvents()
{
}

void VID_LockBuffer()
{
}

void VID_UnlockBuffer()
{
}

qboolean VID_IsLocked()
{
	return 0;
}

void D_BeginDirectRect(int x, int y, byte *pbitmap, int width, int height)
{
}

void D_EndDirectRect(int x, int y, int width, int height)
{
}

void VID_SetCaption(char *text)
{
}

void GL_BeginRendering (int *x, int *y, int *width, int *height)
{
	*x = *y = 0;
	*width = real_width;
	*height = real_height;
}

void GL_EndRendering(void)
{
	/* Check for the windowed mouse setting here */
	if (lastwindowedmouse != _windowed_mouse.value && !screen)
	{
		lastwindowedmouse = _windowed_mouse.value;

		if (lastwindowedmouse == 1)
		{
			/* Hide pointer */

			SetPointer(window, pointermem, 16, 16, 0, 0);
		}
		else
		{
			/* Show pointer */

			ClearPointer(window);
		}
	}

    AROSMesaSwapBuffers(__amContext);	
}

void VID_SetDeviceGammaRamp(unsigned short *ramps)
{
}

