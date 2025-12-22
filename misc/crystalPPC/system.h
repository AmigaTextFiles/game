#ifndef SYSTEM_H
#define SYSTEM_H

#ifndef DEF_H
//vonmir
//#include "def.h"
#include "def.h"
//
#endif

#ifdef COMP_WCC
#include "watcom.h"
#endif

#if defined(COMP_DJGPP) && !defined(DO_SVGALIB)
# include "djgpp.h"
#endif

#ifdef DO_X11
#include "xlib/xwin.h"
#endif

#ifdef DO_SVGALIB
#include "svga.h"
#endif

#ifdef DO_AMIGAOS
//vonmir
//#include "amigalib/amiga.h"
#include "amiga.h"
//
#endif

struct colorRGB
{
  int red;
  int green;
  int blue;
};

#define KEY_UP 1000
#define KEY_DOWN 1001
#define KEY_LEFT 1002
#define KEY_RIGHT 1003
#define KEY_PGUP 1004
#define KEY_PGDN 1005
#define KEY_ESC 1006
#define KEY_BS 1007
#define KEY_END 1008

extern char *graphicsData;
extern colorRGB graphicsPalette[255];
extern int graphicsPalette_alloc[256];

class System
{
 public:
  System(int argc, char *argv[]);
  ~System(void);

  int Open(void);
  void Close(void);

  void Loop(void);

  Graphics *Graph;
  Keyboard *Key;
  int Shutdown;
};

#endif // SYSTEM_H
