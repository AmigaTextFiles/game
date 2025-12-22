/*
 * Copyright (C) 2005 Mark Olsen
 * Copyright (C) 2010 Krzysztof Smiechowicz
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <intuition/extensions.h>

#include <proto/exec.h>
#include <proto/intuition.h>

#include <proto/mesa.h>
#include <GL/arosmesa.h>

#include <proto/graphics.h>
#include <proto/cybergraphics.h>
#include <cybergraphx/cybergraphics.h>

#include "../renderer/tr_local.h"
#include "../client/client.h"

#include "aros_glimp.h"

int gl_NormalFontBase = 0;

struct Window *window;
struct Screen *screen;

static APTR pointermem;

AROSMesaContext glcont;

static const ULONG black0[] = { 1 << 16, 0, 0, 0, 0 };

int mousevisible;

static void stub_glMultiTexCoord2fARB(GLenum unit, GLfloat s, GLfloat t)
{
	glMultiTexCoord2fARB(unit, s, t);
}

static void stub_glActiveTextureARB(GLenum unit)
{
	glActiveTextureARB(unit);
}

static void stub_glClientActiveTextureARB(GLenum unit)
{
	glClientActiveTextureARB(unit);
}

static void stub_glLockArraysEXT(int a, int b)
{
	glLockArraysEXT(a, b);
}

static void stub_glUnlockArraysEXT()
{
	glUnlockArraysEXT();
}

void GLimp_Init(void)
{
    ULONG modeid = INVALID_ID;
    LONG depth;
    LONG r;
	int doclone;

    /* No gamma support in AROS */
    glConfig.deviceSupportsGamma = qfalse;

    /* Get configuration sizes */
    if (r_mode->integer == -2)
        doclone = 1;
    else
    {
        if (!R_GetModeInfo(&glConfig.vidWidth, &glConfig.vidHeight, &glConfig.windowAspect, r_mode->integer))
        {
            Sys_Error("Unable to get mode info\n");
            return;
        }
        doclone = 0;
    }
    /* Open new screen if needed */
    if (r_fullscreen->integer)
    {
        depth = r_colorbits->integer;

        if (depth == 32)
            depth = 24;

        if (depth != 15 && depth != 16 && depth != 24)
            depth = 16;

        modeid = BestCModeIDTags(
            CYBRBIDTG_Depth, depth,
            CYBRBIDTG_NominalWidth, glConfig.vidWidth,
            CYBRBIDTG_NominalHeight, glConfig.vidHeight,
            TAG_DONE);

        if (modeid == INVALID_ID)
        {
            ri.Printf(PRINT_ALL, "Unable to find a screen mode\n");
        }

        if (modeid != INVALID_ID)
        {
            screen = OpenScreenTags(0,
                SA_Type, CUSTOMSCREEN,
                doclone?TAG_IGNORE:SA_Width, glConfig.vidWidth,
                doclone?TAG_IGNORE:SA_Height, glConfig.vidHeight,
                doclone?TAG_IGNORE:SA_Depth, depth,
                SA_Quiet, TRUE,
                SA_Colors32, black0,
                modeid!=INVALID_ID?SA_DisplayID:TAG_IGNORE, modeid,
                SA_ShowTitle, FALSE,
                TAG_DONE);
        }
    }
    
	if (doclone)
	{
		if (screen)
		{
			glConfig.vidWidth = screen->Width;
			glConfig.vidHeight = screen->Height;
		}
		else
		{
			glConfig.vidWidth = 640;
			glConfig.vidHeight = 480;
		}

		glConfig.windowAspect = 1;
	}

    /* Open window */
    window = OpenWindowTags(0,
        WA_InnerWidth, glConfig.vidWidth,
        WA_InnerHeight, glConfig.vidHeight,
        WA_Title, "Return to Castle Wolfenstein",
        WA_DragBar, screen ? FALSE:TRUE,
        WA_DepthGadget, screen ? FALSE:TRUE,
        WA_Borderless, screen ? TRUE:FALSE,
        WA_RMBTrap, TRUE,
        screen ? WA_CustomScreen : TAG_IGNORE, (IPTR)screen,
        WA_Activate, TRUE,
        TAG_DONE);

    /* Create GL context */
    if (window)
    {
        struct TagItem attributes [14]; /* 14 should be more than enough :) */
        LONG i = 0;

        attributes[i].ti_Tag = AMA_Window;      attributes[i++].ti_Data = (IPTR)window;
        attributes[i].ti_Tag = AMA_Left;        attributes[i++].ti_Data = window->BorderLeft;
        attributes[i].ti_Tag = AMA_Top;         attributes[i++].ti_Data = window->BorderTop;
        attributes[i].ti_Tag = AMA_Bottom;      attributes[i++].ti_Data = window->BorderBottom;
        attributes[i].ti_Tag = AMA_Right;       attributes[i++].ti_Data = window->BorderRight;

        /* Double Buffer */
        attributes[i].ti_Tag = AMA_DoubleBuf;   attributes[i++].ti_Data = GL_TRUE;

        /* RGB(A) Mode */
        attributes[i].ti_Tag = AMA_RGBMode;     attributes[i++].ti_Data = GL_TRUE;

        /* Stencil/Accum */
        attributes[i].ti_Tag = AMA_NoStencil;   attributes[i++].ti_Data = !r_stencilbits->value;
        attributes[i].ti_Tag = AMA_NoAccum;     attributes[i++].ti_Data = GL_TRUE;

        /* Done */
        attributes[i].ti_Tag    = TAG_DONE;

        glcont = AROSMesaCreateContext(attributes);

        if (glcont)
        {
            AROSMesaMakeCurrent(glcont);
        }
        else
        {
            ri.Printf(PRINT_ALL, "Unable to create GL context\n");
            goto error;
        }
            

    }
    else
    {
        ri.Printf(PRINT_ALL, "Unable to open window\n");
        goto error;
    } 
    
    /* Allocate memory for mouse pointer */
	pointermem = AllocVec(256, MEMF_ANY | MEMF_CLEAR);
	if (pointermem)
		SetPointer(window, pointermem, 16, 16, 0, 0);
    else
    {
        ri.Printf(PRINT_ALL, "Unable to allocate memory for mouse pointer\n");
        goto error;
    }

    /* Query GL */
    glConfig.driverType = GLDRV_ICD;
    glConfig.hardwareType = GLHW_GENERIC;

    Q_strncpyz( glConfig.vendor_string, qglGetString (GL_VENDOR), sizeof( glConfig.vendor_string ) );
    Q_strncpyz( glConfig.renderer_string, qglGetString (GL_RENDERER), sizeof( glConfig.renderer_string ) );
    if (*glConfig.renderer_string && glConfig.renderer_string[strlen(glConfig.renderer_string) - 1] == '\n')
        glConfig.renderer_string[strlen(glConfig.renderer_string) - 1] = 0;
    Q_strncpyz( glConfig.version_string, qglGetString (GL_VERSION), sizeof( glConfig.version_string ) );
    Q_strncpyz( glConfig.extensions_string, qglGetString (GL_EXTENSIONS), sizeof( glConfig.extensions_string ) );


    if (strstr(glConfig.extensions_string, "GL_ARB_multitexture"))
    {
        qglGetIntegerv(GL_MAX_ACTIVE_TEXTURES_ARB, &glConfig.maxActiveTextures);
        if (glConfig.maxActiveTextures > 1)
        {
            qglMultiTexCoord2fARB = stub_glMultiTexCoord2fARB;
            qglActiveTextureARB = stub_glActiveTextureARB;
            qglClientActiveTextureARB = stub_glClientActiveTextureARB;
        }
    }
    
    if (strstr(glConfig.extensions_string, "EXT_texture_env_add"))
    {
        if (r_ext_texture_env_add->integer)
        {
            glConfig.textureEnvAddAvailable = qtrue;
        }
    }

    if (strstr(glConfig.extensions_string, "GL_EXT_compiled_vertex_array"))
    {
        if (r_ext_compiled_vertex_array->value)
        {
            qglLockArraysEXT = stub_glLockArraysEXT;
            qglUnlockArraysEXT = stub_glUnlockArraysEXT;
        }
    }

    glConfig.colorBits = GetBitMapAttr(window->WScreen->RastPort.BitMap, BMA_DEPTH);
    glGetIntegerv(GL_STENCIL_BITS, &r);
    glConfig.stencilBits = r;
//FIXME: why stencil is used for depth?!?!?!??!? 
    if (r)
        glConfig.depthBits = 24;
    else
        glConfig.depthBits = 16;

    return;

error:
    if (pointermem) { FreeVec(pointermem); pointermem = NULL; }
    if (glcont) { AROSMesaMakeCurrent(NULL); AROSMesaDestroyContext(glcont); glcont = NULL; }
    if (window) { CloseWindow(window); window = NULL; }
    if (screen) { CloseScreen(screen); screen = NULL; }

    Sys_Error("Unable to open a display\n");
}

void GLimp_Shutdown(void)
{
    if (pointermem) { FreeVec(pointermem); pointermem = NULL; }
    if (glcont) { AROSMesaMakeCurrent(NULL); AROSMesaDestroyContext(glcont); glcont = NULL; }
    if (window) { CloseWindow(window); window = NULL; }
    if (screen) { CloseScreen(screen); screen = NULL; }


    memset(&glConfig, 0, sizeof(glConfig));
    memset(&glState, 0, sizeof(glState));
}

void GLimp_LogComment(char *comment)
{
}

void GLimp_EndFrame(void)
{
    AROSMesaSwapBuffers(glcont);
}

void *GLimp_RendererSleep(void)
{
}

qboolean GLimp_SpawnRenderThread(void (*function)(void))
{
	return 0;
}

void GLimp_FrontEndSleep(void)
{
}

void GLimp_WakeRenderer(void *data)
{
}

void GLimp_SetGamma(unsigned char red[256], unsigned char green[256], unsigned char blue[256])
{
}

void GLimp_Frame()
{
	if (screen == NULL)
	{
		if ((cls.keyCatchers & KEYCATCH_CONSOLE))
		{
			if (!mousevisible)
			{
				ClearPointer(window);
				mousevisible = 1;
			}
		}
		else
		{
			if (mousevisible)
			{
				SetPointer(window, pointermem, 16, 16, 0, 0);

				mousevisible = 0;
			}
		}
	}
}
