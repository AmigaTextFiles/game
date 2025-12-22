/*
Copyright (C) 1996-1997 Id Software, Inc.

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

// gl_vidamiga.c - 19/01/2000 Massimiliano Tretene

#include <sys/ioctl.h>
#include <stdarg.h>
#include <stdio.h>
#include <signal.h>

#include "quakedef.h"

#include <mgl/gl.h>

#define WARP_WIDTH              320
#define WARP_HEIGHT             240
 
unsigned char rawkeyconv[] = {
  '`','1','2','3','4','5','6','7','8','9','0','-','=','\\',0,'0',
  'q','w','e','r','t','y','u','i','o','p','[',']',0,K_END,K_DOWNARROW,K_PGDN,
  'a','s','d','f','g','h','j','k','l',';','\'',K_F12,0,K_LEFTARROW,0,K_RIGHTARROW,
  K_F11,'z','x','c','v','b','n','m',',','.','/',0,0,K_HOME,K_UPARROW,K_PGUP,
  K_SPACE,K_BACKSPACE,K_TAB,K_ENTER,K_ENTER,K_ESCAPE,K_DEL,0,
  0,0,'-',0,K_UPARROW,K_DOWNARROW,K_RIGHTARROW,K_LEFTARROW,
  K_F1,K_F2,K_F3,K_F4,K_F5,K_F6,K_F7,K_F8,K_F9,K_F10,'(',')','/','*','+',K_PAUSE,
  K_SHIFT,K_SHIFT,0,K_CTRL,K_ALT,K_ALT,0,0,
  K_MOUSE1,K_MOUSE2,K_MOUSE3
};
int shutdown_keyboard;

struct Window *QuakeWindow = NULL;

GLboolean zbuffer = GL_TRUE;

GLfloat mouse_x = 0.0, mouse_y = 0.0, mouse_z = 0.0;
GLint offset = 0;
GLfloat fov = 70.0;
GLfloat inf_w = 0.1;
GLfloat zback = 1000.0;
GLfloat alpha = 1.0;

GLcontext context;
int numb=3;
int bpp = 15;
qboolean gl_warp = true;

unsigned    d_8to24table[256];
unsigned char d_15to8table[65536];

static qboolean gl_videosync = true;
static qboolean gl_dithering = true;
static int gl_lockmode = MGL_LOCK_MANUAL;
static int scr_width, scr_height;
static float width;
static qboolean UPDATE = FALSE;  
static GLfloat gl_polyoffset = 0.0;

void VID_MenuDraw (void);
void VID_MenuKey (int);

/*-----------------------------------------------------------------------*/

//int   texture_mode = GL_NEAREST;
//int   texture_mode = GL_NEAREST_MIPMAP_NEAREST;
//int   texture_mode = GL_NEAREST_MIPMAP_LINEAR;
//int   texture_mode = GL_LINEAR_MIPMAP_NEAREST;
//int   texture_mode = GL_LINEAR_MIPMAP_LINEAR;

#ifdef __060__
int   texture_mode = GL_NEAREST;
#else
int   texture_mode = GL_LINEAR;
#endif

extern int   gl_filter_min;
extern int   gl_filter_max;
extern cvar_t gl_fog;
extern cvar_t gl_max_size;

int   texture_extension_number = 1;

float   gldepthmin, gldepthmax;

cvar_t  gl_ztrick = {"gl_ztrick","0"};
cvar_t  gl_width = {"gl_width","320"};

const char *gl_vendor;
const char *gl_renderer;
const char *gl_version;
const char *gl_extensions;

static float vid_gamma = 1.0;

qboolean is8bit = false;
qboolean isPermedia = false;
qboolean gl_mtexable = false;

/*-----------------------------------------------------------------------*/
void D_BeginDirectRect (int x, int y, byte *pbitmap, int width, int height)
{
}

void D_EndDirectRect (int x, int y, int width, int height)
{
}


void VID_Shutdown(void)
{
   if (context) {
      mglDeleteContext();
      MGLTerm();   
   }   
}

void signal_handler(int sig)
{
  printf("Received signal %d, exiting...\n", sig);
  Sys_Quit();
  exit(0);
}

void InitSig(void)
{
  signal(SIGABRT, signal_handler);
  signal(SIGFPE, signal_handler);
  signal(SIGILL, signal_handler);
  signal(SIGINT, signal_handler);
  signal(SIGSEGV, signal_handler);
  signal(SIGTERM, signal_handler);
}

static void Check_Gamma (unsigned char *pal)
{
  float f, inf;
  static unsigned char palette[768];
  register int   i;
  //static qboolean firsttime = false;
  //if (firsttime) return;
  
  if ((i = COM_CheckParm("-gamma")) == 0) {
    if ((gl_renderer && strstr(gl_renderer, "Voodoo")) ||
      (gl_vendor && strstr(gl_vendor, "3Dfx")))
      vid_gamma = 1;
    else
      vid_gamma = 0.7; // default to 0.7 on non-3dfx hardware
  } else
    vid_gamma = Q_atof(com_argv[i+1]);

  //firsttime=true;

  for (i=0 ; i<768 ; i++)
  {
    f = pow ( (pal[i]+1)/256.0 , vid_gamma );
    inf = f*255 + 0.5;
    if (inf < 0)
      inf = 0;
    if (inf > 255)
      inf = 255;
    palette[i] = inf;
  }

  memcpy (pal, palette, sizeof(palette));
}
/*
void VID_ShiftPalette(unsigned char *p)
{
  VID_SetPalette(p);
}
*/
void	VID_SetPalette (unsigned char *palette)
{
	register byte	*pal;
	register unsigned short r,g,b;
	register unsigned     v;
	register unsigned short i;
	register unsigned	*table;
	int     r1,g1,b1;
	int		k;
	FILE *f;
	char s[255];
	float dist, bestdist;
	static qboolean palflag = false;

//
// 8 8 8 encoding
//
	pal = palette;
	table = d_8to24table;
	for (i=0 ; i<256 ; i++)
	{
		r = pal[0];
		g = pal[1];
		b = pal[2];
		pal += 3;
		
		//v = (255<<24) + (r<<0) + (g<<8) + (b<<16);
		//v = (255<<0) + (r<<24) + (g<<16) + (b<<8);
//    v = LittleLong((170<<24) + (r<<0) + (g<<8) + (b<<16));

    v = (170<<0) + (r<<24) + (g<<16) + (b<<8);
		*table++ = v;
	}
	d_8to24table[255] &= 0xffffff00;	// 255 is transparent

	// JACK: 3D distance calcs - k is last closest, l is the distance.
	// FIXME: Precalculate this and cache to disk.
	if (palflag)
		return;
	palflag = true;

	COM_FOpenFile("glquake/15to8.pal", &f);
	if (f) {
		fread(d_15to8table, 1<<15, 1, f);
		fclose(f);
	} else {
		for (i=0; i < (1<<15); i++) {
			/* Maps
 			000000000000000
 			000000000011111 = Red  = 0x1F
 			000001111100000 = Blue = 0x03E0
 			111110000000000 = Grn  = 0x7C00
 			*/
 			r = ((i & 0x1F) << 3)+4;
 			g = ((i & 0x03E0) >> 2)+4;
 			b = ((i & 0x7C00) >> 7)+4;
			pal = (unsigned char *)d_8to24table;
			for (v=0,k=0,bestdist=10000.0; v<256; v++,pal+=4) {
 				r1 = (int)r - (int)pal[0];
 				g1 = (int)g - (int)pal[1];
 				b1 = (int)b - (int)pal[2];
				dist = sqrt(((r1*r1)+(g1*g1)+(b1*b1)));
				if (dist < bestdist) {
					k=v;
					bestdist = dist;
				}
			}
			d_15to8table[i]=k;
		}
		sprintf(s, "%s/glquake", com_gamedir);
 		Sys_mkdir (s);
		sprintf(s, "%s/glquake/15to8.pal", com_gamedir);
		if ((f = fopen(s, "wb")) != NULL) {
			fwrite(d_15to8table, 1<<15, 1, f);
			fclose(f);
		}
	}
}


/*
===============
GL_Init
===============
*/
void GL_Init (void)
{
  gl_vendor = glGetString (GL_VENDOR);
  Con_Printf ("GL_VENDOR: %s\n", gl_vendor);
  gl_renderer = glGetString (GL_RENDERER);
  Con_Printf ("GL_RENDERER: %s\n", gl_renderer);
  if (strstr(gl_renderer, "(virge)")) gl_polyoffset = -0.0005;

  gl_version = glGetString (GL_VERSION);
  Con_Printf ("GL_VERSION: %s\n", gl_version);
  gl_extensions = glGetString (GL_EXTENSIONS);
  Con_Printf ("GL_EXTENSIONS: %s\n", gl_extensions);

//  Con_Printf ("%s %s\n", gl_renderer, gl_version);

  glClearColor (1,0,0,0);
  glCullFace(GL_FRONT);
  glEnable(GL_TEXTURE_2D);

  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER, 0.666);

  glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
  glShadeModel (GL_FLAT);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

//  glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, (GLint)GL_REPLACE);
}

/*
=================
GL_BeginRendering

=================
*/
void GL_BeginRendering (int *x, int *y, int *width, int *height)
{
  extern cvar_t gl_clear;

  *x = *y = 0;
  *width = scr_width;
  *height = scr_height;

  if (gl_lockmode == MGL_LOCK_MANUAL) MGLLockDisplay(context);

//    if (!wglMakeCurrent( maindc, baseRC ))
//    Sys_Error ("wglMakeCurrent failed");

//  glViewport (*x, *y, *width, *height);
}


void GL_EndRendering (void)
{
   MGLUnlockDisplay(context);
   MGLSwitchDisplay(context);
   
   if (UPDATE) {
      gl_width.value = width;
      Con_Printf("CHANGED ------------------------------ %4.0f\n",gl_width.value);
   
      scr_width = (int)gl_width.value;
      scr_height = scr_width * 3 / 4;
      vid.conwidth = scr_width;
      vid.conwidth &= 0xfff8; // make it a multiple of eight

      if (vid.conwidth < 320) vid.conwidth = 320;
      vid.conheight = vid.conwidth * 3 / 4;

	    vid.width = vid.conwidth;
      vid.height = vid.conheight;
 
      MGLResizeContext(context, vid.width, vid.height);
      QuakeWindow = mglGetWindowHandle();
      vid.recalc_refdef = 1;
      //if (gl_lockmode == MGL_LOCK_MANUAL) mglLockDisplay();
      //SCR_UpdateScreen();
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
      //mglUnlockDisplay();
      
      UPDATE = FALSE;
   }   
/*   
   {   
     GLint current = 0;
     GLint peek = 0;
     MGLTexMemStat(context,&current,&peek);
     printf("Current: %d - Peek: %d\n",current,peek);
   }  
*/   
}

qboolean VID_Is8bit(void)
{
  return is8bit;
}

void ChangeVideoSync_f (void)
{
  if (Cmd_Argc() == 1)
  {
     Con_Printf ("GL_VIDEOSYNC %d\n", gl_videosync);
     return;
  }

  gl_videosync = Q_atoi(Cmd_Argv(1)); 
  mglEnableSync(gl_videosync);
}

void ChangeDithering_f (void)
{
  if (Cmd_Argc() == 1)
  {
     Con_Printf ("GL_DITHERING IS %d\n", gl_dithering);
     return;
  }

  gl_dithering = Q_atoi(Cmd_Argv(1)); 
  MGLSetState(context,GL_DITHER,gl_dithering);
}

void ChangeLockMode_f (void)
{
  if (Cmd_Argc() == 1)
  {
     if (gl_lockmode == MGL_LOCK_SMART) Con_Printf ("SMART\n");
     else if (gl_lockmode == MGL_LOCK_AUTOMATIC) Con_Printf ("AUTOMATIC\n");
     else if (gl_lockmode == MGL_LOCK_MANUAL) Con_Printf ("MANUAL\n");
     else Con_Printf ("UNKNOWN\n");
     return;
  }
  
  if (Q_strcasecmp(Cmd_Argv(1),"SMART") == 0) gl_lockmode = MGL_LOCK_SMART;
  if (Q_strcasecmp(Cmd_Argv(1),"AUTOMATIC") == 0) gl_lockmode = MGL_LOCK_AUTOMATIC;
  if (Q_strcasecmp(Cmd_Argv(1),"MANUAL") == 0) gl_lockmode = MGL_LOCK_MANUAL;

  mglLockMode(gl_lockmode);
}

void ChangeVideoMode_f (void)
{
  if (Cmd_Argc() == 1)
  {
     Con_Printf ("GL_WIDTH is %4.0f\n", gl_width.value);
     return;
  }

   width = Q_atof(Cmd_Argv(1)); 
   if (width != gl_width.value) UPDATE = TRUE;
}

void ChangePolyOffset_f (void)
{
  if (Cmd_Argc() == 1)
  {
     Con_Printf ("GL_POLYOFFSET is %f\n", gl_polyoffset);
     return;
  }

   gl_polyoffset = Q_atof(Cmd_Argv(1)); 
   mglSetZOffset(gl_polyoffset);
}

void ChangeWarp_f (void)
{
  if (Cmd_Argc() == 1)
  {
     Con_Printf ("GL_WARP is %d\n", gl_warp);
     return;
  }

   gl_warp = Q_atof(Cmd_Argv(1)); 
}

void VID_Init(unsigned char *palette)
{
  int i;
  char gldir[MAX_OSPATH];
  
	Cvar_RegisterVariable (&gl_ztrick);
	//Cvar_RegisterVariable (&gl_width);

  Cmd_AddCommand ("gl_videosync", &ChangeVideoSync_f);
  Cmd_AddCommand ("gl_lockmode", &ChangeLockMode_f);
  Cmd_AddCommand ("gl_dithering", &ChangeDithering_f);
  Cmd_AddCommand ("gl_width", &ChangeVideoMode_f);
  Cmd_AddCommand ("gl_polyoffset", &ChangePolyOffset_f);
  Cmd_AddCommand ("gl_warp", &ChangeWarp_f);
  
  // fog 

  if ((i = COM_CheckParm("-fog")) != 0) gl_fog.value = 1;

  // texturemode

  if ((i = COM_CheckParm("-texturemode")) != 0) {
    if (Q_strcasecmp(com_argv[i+1],"GL_NEAREST") == 0) texture_mode = GL_NEAREST;
    if (Q_strcasecmp(com_argv[i+1],"GL_LINEAR") == 0) texture_mode = GL_LINEAR;
    if (Q_strcasecmp(com_argv[i+1],"GL_NEAREST_MIPMAP_NEAREST") == 0) texture_mode = GL_NEAREST_MIPMAP_NEAREST;
    if (Q_strcasecmp(com_argv[i+1],"GL_NEAREST_MIPMAP_LINEAR") == 0) texture_mode = GL_NEAREST_MIPMAP_LINEAR;
    if (Q_strcasecmp(com_argv[i+1],"GL_LINEAR_MIPMAP_NEAREST") == 0) texture_mode = GL_LINEAR_MIPMAP_NEAREST;
    if (Q_strcasecmp(com_argv[i+1],"GL_LINEAR_MIPMAP_LINEAR") == 0) texture_mode = GL_LINEAR_MIPMAP_LINEAR;

    gl_filter_min = texture_mode;
    gl_filter_max = texture_mode;
  }  
  
  // dither

  if ((i = COM_CheckParm("-dither")) != 0) {
    if (Q_strcasecmp(com_argv[i+1],"ON") == 0) gl_dithering = GL_TRUE;
    if (Q_strcasecmp(com_argv[i+1],"OFF") == 0) gl_dithering = GL_FALSE;
  }  
  
  // lockmode

  if ((i = COM_CheckParm("-lockmode")) != 0) {
    if (Q_strcasecmp(com_argv[i+1],"SMART") == 0) gl_lockmode = MGL_LOCK_SMART;
    if (Q_strcasecmp(com_argv[i+1],"AUTOMATIC") == 0) gl_lockmode = MGL_LOCK_AUTOMATIC;
    if (Q_strcasecmp(com_argv[i+1],"MANUAL") == 0) gl_lockmode = MGL_LOCK_MANUAL;
  }  
  
  // number of buffers
  
  if ((i = COM_CheckParm("-buf")) != 0)
    numb = Q_atoi(com_argv[i+1]);
  
  if (numb < 2) numb = 2;   
  if (numb > 3) numb = 3;   
  
  if (numb == 2) gl_videosync = true;
  else gl_videosync = false;
  
  // width

  scr_width = 320; //gl_width.value;
  scr_height = scr_width * 3 / 4;
  
  if ((i = COM_CheckParm("-width")) != 0) {
    scr_width = Q_atoi(com_argv[i+1]);
    scr_height = scr_width * 3 / 4;
  }  

  // height

  if ((i = COM_CheckParm("-height")) != 0) {
    scr_height = Q_atoi(com_argv[i+1]);
  }  

  // bpp

  if ((i = COM_CheckParm("-bpp")) != 0) {
    bpp = Q_atoi(com_argv[i+1]);
    if (bpp < 15) bpp = 15;
    if (bpp > 16) bpp = 16;
  }  
  
  // set vid parameters

  vid.colormap = host_colormap;
  vid.fullbright = 256 - LittleLong (*((int *)vid.colormap + 2048));

  vid.conwidth = scr_width;
  vid.conwidth &= 0xfff8; // make it a multiple of eight

  if (vid.conwidth < 320)
    vid.conwidth = 320;

  // pick a conheight that matches with correct aspect
  
  vid.conheight = scr_height;

  //if ((i = COM_CheckParm("-conwidth")) != 0)
  //  vid.conwidth = Q_atoi(com_argv[i+1]);
  //if ((i = COM_CheckParm("-conheight")) != 0)
  //  vid.conheight = Q_atoi(com_argv[i+1]);
  //if (vid.conheight < 200)
  //  vid.conheight = 200;

	vid.width = vid.conwidth;
	vid.height = vid.conheight;
  vid.maxwarpwidth = WARP_WIDTH;
  vid.maxwarpheight = WARP_HEIGHT;
  vid.aspect = ((float)vid.height / (float)vid.width) * (320.0 / 240.0);
	//vid.aspect = 1;
	vid.numpages = 2;
	gl_width.value = vid.width;

	Con_Printf("Calling MGLInit...\n");
	MGLInit();
	
	// vertexbuffer
	
	Con_Printf("Setting Vertex Buffer Size to 16000...\n");
  mglChooseVertexBufferSize(16000);

	// windowmode

  if ((i = COM_CheckParm("-windowmode")) != 0) {
    Con_Printf("Window mode ON\n");
    mglChooseWindowMode(GL_TRUE);
  }   
  else {
    
     Con_Printf("Setting pixel depth to %d...\n",bpp);
	   mglChoosePixelDepth(bpp);

	   Con_Printf("Setting number of buffers to %d...\n", numb);
	   mglChooseNumberOfBuffers(numb);

     if ((i = COM_CheckParm("-closewb")) != 0) {
       Con_Printf("Closing the Workbench...\n");
       mglProposeCloseDesktop(GL_TRUE);
    }   
  }   
  
	Con_Printf("Creating context...\n");
	if (context = mglCreateContext(0,0, vid.width, vid.height)) {
	
	   Con_Printf("Switching sync...\n");
		 mglEnableSync(gl_videosync);	 
		 mglLockMode(gl_lockmode);
     MGLSetState(context,GL_DITHER,gl_dithering);
   
     if (QuakeWindow = mglGetWindowHandle()) ModifyIDCMP(QuakeWindow, IDCMP_RAWKEY|IDCMP_MOUSEBUTTONS);

     GL_Init();
     
     mglSetZOffset(gl_polyoffset);

     sprintf (gldir, "%s/glquake", com_gamedir);
     Sys_mkdir (gldir);

     Check_Gamma(palette);
     VID_SetPalette(palette);

     Con_SafePrintf ("Video mode %dx%d initialized.\n", scr_width, scr_height);

     vid.recalc_refdef = 1;        // force a surface cache flush
     //vid_menudrawfn = VID_MenuDraw;
     //vid_menukeyfn = VID_MenuKey;
  }   
  else Sys_Error("no context, exiting...\n");
}

void Force_CenterView_f (void)
{
  cl.viewangles[PITCH] = 0;
}

void Sys_SendKeyEvents (void)
{
  struct IntuiMessage *imsg;
  int kn;

  if (QuakeWindow) {

    while (imsg = (struct IntuiMessage *)GetMsg(QuakeWindow->UserPort)) {

      if (imsg->Class==IDCMP_RAWKEY || imsg->Class==IDCMP_MOUSEBUTTONS) {
        kn = (int)rawkeyconv[imsg->Code & 0x7f];
        if (imsg->Code & IECODE_UP_PREFIX)
          Key_Event(kn,false);
        else
          Key_Event(kn,true);
        if (shutdown_keyboard)
        {
          shutdown_keyboard=0;
          return;
        }
      }
      
      ReplyMsg((struct Message *)imsg);
    }      
  }
}

/*
================
VID_MenuDraw
================
*/

#define MAX_COLUMN_SIZE 11
#define MAX_MODEDESCS   33
typedef struct
{
  int     modenum;
  char    *desc;
  int     iscur;
} modedesc_t;
static modedesc_t   modedescs[33];
int numvidmodes=11;
static int vid_wmodes,vid_line;
int vid_column_size;

void VID_MenuDraw (void)
{
  qpic_t      *p;
  char        *ptr;
  int         nummodes, i, j, column, row, dup;
  char        temp[100];

  p = Draw_CachePic ("gfx/vidmodes.lmp");
  M_DrawPic ( (320-p->width)/2, 4, p);

  M_Print (9*8, 36 + MAX_COLUMN_SIZE * 8 + 8*3, "Press Enter to set mode");
  //ptr = VID_GetModeDescription (vid_modenum);
  sprintf (temp, "D to make %s the default", ptr);
  M_Print (6*8, 36 + MAX_COLUMN_SIZE * 8 + 8*5, temp);
  //ptr = VID_GetModeDescription ((int)_vid_default_mode.value);
/*
  if (ptr)
  {
    sprintf (temp, "Current default is %s", ptr);
    M_Print (7*8, 36 + MAX_COLUMN_SIZE * 8 + 8*6, temp);
  }
*/
  M_Print (15*8, 36 + MAX_COLUMN_SIZE * 8 + 8*8, "Esc to exit");

  row = 36 + (vid_line % vid_column_size) * 8;
  column = 8 + (vid_line / vid_column_size) * 13*8;

  M_DrawCharacter (column, row, 12+((int)(realtime*4)&1));
}

/*
================
VID_MenuKey
================
*/
void VID_MenuKey (int key)
{
  switch (key)
  {
    case K_ESCAPE:
      S_LocalSound ("misc/menu1.wav");
      M_Menu_Options_f ();
      break;
  
    case K_UPARROW:
      S_LocalSound ("misc/menu1.wav");
      vid_line--;
  
      if (vid_line < 0) vid_line = vid_wmodes - 1;
      break;
  
    case K_DOWNARROW:
      S_LocalSound ("misc/menu1.wav");
      vid_line++;

      if (vid_line >= vid_wmodes)
      vid_line = 0;
      break;
  
    case K_LEFTARROW:
      S_LocalSound ("misc/menu1.wav");
      vid_line -= vid_column_size;
  
      if (vid_line < 0)
      {
        vid_line += ((vid_wmodes + (vid_column_size - 1)) /
                     vid_column_size) * vid_column_size;
  
        while (vid_line >= vid_wmodes)
               vid_line -= vid_column_size;
      }
      break;
  
    case K_RIGHTARROW:
      S_LocalSound ("misc/menu1.wav");
      vid_line += vid_column_size;
  
      if (vid_line >= vid_wmodes)
      {
        vid_line -= ((vid_wmodes + (vid_column_size - 1)) /
                     vid_column_size) * vid_column_size;
  
        while (vid_line < 0)
          vid_line += vid_column_size;
      }
      break;
  
    case K_ENTER:
      S_LocalSound ("misc/menu1.wav");
      Cvar_SetValue("gl_width",modedescs[vid_line].modenum);
      //vid_modenum=modedescs[vid_line].modenum;
      //config_notify=1;
      break;
/*
    case 'D':
    case 'd':
      S_LocalSound ("misc/menu1.wav");
      Cvar_SetValue ("_vid_default_mode", modedescs[vid_line].modenum);
      vid_modenum=modedescs[vid_line].modenum;
      break;
*/
    default:
      break;
  }
}
