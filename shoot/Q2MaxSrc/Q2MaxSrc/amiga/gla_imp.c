/*
Copyright (C) 1997-2001 Id Software, Inc.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/
/*
** GLA_IMP.C
**
** This file contains ALL Amiga specific stuff having to do with the
** OpenGL refresh.  When a port is being made the following functions
** must be implemented by the port:
**
** GLimp_EndFrame
** GLimp_Init
** GLimp_Shutdown
** GLimp_SwitchFullscreen
**
*/
#include <exec/exec.h>
#include <exec/memory.h>
#include <exec/execbase.h>
#include <mgl/gl.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <cybergraphx/cybergraphics.h>
#include <clib/chunkyppc_protos.h>
#include <clib/intuition_protos.h>
#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <proto/intuition.h>
#include <proto/exec.h>
#include <proto/cybergraphics.h>
#include <proto/timer.h>

#include "../ref_gl/gl_local.h"

#ifdef IMAGECACHE
cvar_t *gl_texturecache;
hard_cache *TextureCache;
#endif

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct Library *CyberGfxBase;

cvar_t *gl_lockmode;
cvar_t *gl_texturecache;
cvar_t *gl_drawparticles;
cvar_t *gl_framestat;

GLboolean old_context = GL_FALSE;

int gl_lmaps_drawn = 0;
int gl_bpolies_drawn = 0;


extern cvar_t *vid_fullscreen;
extern cvar_t *vid_ref;

void OpenLibs(void)
{
	if (MGLInit() == GL_FALSE)
	    Sys_Error("Unable to initialize MiniGL");
}

void CloseLibs(void)
{
	MGLTerm();
}


void GL_SetLockMode(char *mode)
{
	if (0 == stricmp(mode, "SMART"))
	{
		Com_Printf("MiniGL Lock Mode: Smart\n");
		mglLockMode(MGL_LOCK_SMART);
	}
	else if (0 == stricmp(mode, "AUTO"))
	{
		Com_Printf("MiniGL Lock Mode: Automatic\n");
		mglLockMode(MGL_LOCK_AUTOMATIC);
	}
	else
	{
		Com_Printf("MiniGL Lock Mode: Manual (per Frame)\n");
		mglLockMode(MGL_LOCK_MANUAL);
	}
}


/*
** VID_CreateWindow
*/
#define WINDOW_CLASS_NAME       "Quake 2"

qboolean VID_CreateWindow( int width, int height, qboolean fullscreen )
{
	cvar_t                  *vid_xpos, *vid_ypos;
	int                     x, y, w, h;
	int                     exstyle;
	cvar_t                  *depth, *buffers, *cv;

	if (old_context)
	{
	    mglDeleteContext();
	    old_context = GL_FALSE;
	}


	depth =     ri.Cvar_Get("gl_forcedepth", "15", CVAR_ARCHIVE);
	buffers =   ri.Cvar_Get("gl_buffers", "3", CVAR_ARCHIVE);
	cv =        ri.Cvar_Get("gl_closeworkbench", "1", CVAR_ARCHIVE);

	if (cv->value) mglProposeCloseDesktop(GL_TRUE);
	else           mglProposeCloseDesktop(GL_FALSE);

	mglChoosePixelDepth((int)depth->value);
	mglChooseNumberOfBuffers((int)buffers->value);


	if (fullscreen)
	{
		x = 0;
		y = 0;
	}
	else
	{
		vid_xpos = ri.Cvar_Get ("vid_xpos", "0", 0);
		vid_ypos = ri.Cvar_Get ("vid_ypos", "0", 0);
		x = vid_xpos->value;
		y = vid_ypos->value;
		mglChooseWindowMode(GL_TRUE);
	}

#ifdef Q2MAX
	mglChooseVertexBufferSize(40000);
#else
	mglChooseVertexBufferSize(15000);
#endif	
	old_context = (NULL == mglCreateContext(0, 0, width, height) ? GL_FALSE : GL_TRUE);

	if (!old_context)
	    ri.Sys_Error (ERR_FATAL, "Couldn't create window");
	if (!fullscreen)
	    MoveWindow(mglGetWindowHandle(), x, y);

	if (buffers->value == 3)
	    mglEnableSync(GL_FALSE);
	else
	    mglEnableSync(GL_TRUE);

	gl_lockmode = ri.Cvar_Get("gl_lockmode", "MANUAL", CVAR_ARCHIVE);
	GL_SetLockMode(gl_lockmode->string);

	gl_drawparticles = ri.Cvar_Get("gl_drawparticles", "1", 0);
	gl_framestat = ri.Cvar_Get("gl_framestat", "0", 0);

	// let the sound and input subsystems know about the new window
	ri.Vid_NewWindow (width, height);
	return true;
}


/*
** GLimp_SetMode
*/
rserr_t GLimp_SetMode( int *pwidth, int *pheight, int mode, qboolean fullscreen )
{
	int width, height;
	const char *win_fs[] = { "W", "FS" };

	ri.Con_Printf( PRINT_ALL, "Initializing OpenGL display\n");
	ri.Con_Printf (PRINT_ALL, "...setting mode %d:", mode );

	if ( !ri.Vid_GetModeInfo( &width, &height, mode ) )
	{
		ri.Con_Printf( PRINT_ALL, " invalid mode\n" );
		return rserr_invalid_mode;
	}

	// do a CDS if needed
	if (fullscreen)
	{
		ri.Con_Printf( PRINT_ALL, "fullscreen\n" );
		*pwidth = width;
		*pheight = height;
		if ( !VID_CreateWindow (width, height, true) )
			return rserr_invalid_mode;
	}
	else
	{
		ri.Con_Printf( PRINT_ALL, "windowed\n" );
		*pwidth = width;
		*pheight = height;
		if ( !VID_CreateWindow (width, height, false) )
			return rserr_invalid_mode;
	}

	return rserr_ok;
}

/*
** GLimp_Shutdown
**
** This routine does all OS specific shutdown procedures for the OpenGL
** subsystem.  Under OpenGL this means NULLing out the current DC and
** HGLRC, deleting the rendering context, and releasing the DC acquired
** for the window.  The state structure is also nulled out.
**
*/
void GLimp_Shutdown( void )
{
	if (old_context == GL_TRUE)
	    mglDeleteContext();

	old_context = GL_FALSE;
#ifdef IMAGECACHE
  if (TextureCache) HARD_DeleteCache(TextureCache);
#endif
	CloseLibs();
}

#ifdef IMAGECACHE
void GLimp_TextureSwap(void *data, int ordinal)
{
        image_t *img = (image_t *)data;
        img->is_swapped = true;
        glDeleteTextures(1, &img->texnum);
}

void GLimp_TextureReload(void *data, int ordinal)
{
        extern void GL_RestoreImage(image_t *image);
        image_t *img = (image_t *)data;
        GL_RestoreImage(img);
        img->is_swapped = false;
}
#endif


/*
** GLimp_Init
**
** This routine is responsible for initializing the OS specific portions
** of OpenGL.  Under Win32 this means dealing with the pixelformats and
** doing the wgl interface stuff.
*/
int GLimp_Init( void *hinstance, void *wndproc )
{
	OpenLibs();
#ifdef IMAGECACHE
  gl_texturecache = ri.Cvar_Get("gl_imagecache", "4000000", CVAR_ARCHIVE);
	if ((int)(gl_texturecache->value) != 0)
	{
        TextureCache = HARD_CreateCache(gl_texturecache->value,
											MAX_GLTEXTURES-TEXNUM_IMAGES+1024,
                        								GLimp_TextureSwap, GLimp_TextureReload);
  }
#endif
	return 1;
}


/*
** GLimp_BeginFrame
*/
void GLimp_BeginFrame( float camera_separation )
{
	extern cvar_t *gl_debug;

	static int timed = 0;
	static struct timeval tv;
	ULONG ms;
	
	if (timed == 0)
	{
#ifdef __PPC__	
	    GetSysTimePPC(&tv);
#else
      if (!TimerBase) TimerBase=FindName(&SysBase->DeviceList,"timer.device");      
      GetSysTime(&tv);
#endif
	    timed = 1;
	}
	else
	{
	    struct timeval end;
	    struct timeval start;

#ifndef __PPC__
      extern struct ExecBase *SysBase;
#endif

	    start = tv;

#ifdef __PPC__
	    GetSysTimePPC(&end);
	    tv = end;

	    SubTimePPC(&end, &start);
#else
      if (!TimerBase) TimerBase=FindName(&SysBase->DeviceList,"timer.device");      

      GetSysTime(&end);
      tv = end;
          
      SubTime(&end,&start);  

#endif
#ifdef __PPC__
	    ms = end.tv_micro;
#endif
	}

#ifdef IMAGECACHE
	if (gl_texturecache->modified)
	{
        if (gl_texturecache->value < 1000000)
        {
            ri.Cvar_SetValue(gl_texturecache, 1000000);
            Com_Printf("Cannot accept values below 1000000\nSetting to 1000000\n");
        }
        HARD_ResizeCache(TextureCache, gl_texturecache->value);
        gl_texturecache->modified = false;
	}
#endif

	if ( gl_lockmode->modified)
	{
		GL_SetLockMode(gl_lockmode->string);
		gl_lockmode->modified = false;
	}

	glHint(MGL_W_ONE_HINT, GL_FASTEST);

/*        if ( gl_bitdepth->modified )
	{
		if ( gl_bitdepth->value != 0)
		{
			ri.Cvar_SetValue( "gl_bitdepth", 0 );
			ri.Con_Printf( PRINT_ALL, "gl_bitdepth not supported (yet)\n" );
		}
		gl_bitdepth->modified = false;
	}*/

	mglLockDisplay();

	if (gl_framestat->value == 1)
	{
	    ri.Con_Printf(PRINT_ALL, "Frame time: %d microseconds\n", ms);
	    ri.Con_Printf(PRINT_ALL, "FPS: %3.3f fps\n", 1000000.0/(float)ms);
	    ri.Con_Printf(PRINT_ALL, "LM: %d   BP: %d\n", gl_lmaps_drawn, gl_bpolies_drawn);
	}

	gl_lmaps_drawn = 0;
	gl_bpolies_drawn = 0;
}

/*
** GLimp_EndFrame
** 
** Responsible for doing a swapbuffers and possibly for other stuff
** as yet to be determined.  Probably better not to make this a GLimp
** function and instead do a call to GLimp_SwapBuffers.
*/
void GLimp_EndFrame (void)
{
	mglUnlockDisplay();
	mglSwitchDisplay();
}

/*
** GLimp_AppActivate
*/
void GLimp_AppActivate( qboolean active )
{
}


struct Window *GetWindowHandle(void)
{
    return mglGetWindowHandle();
}

