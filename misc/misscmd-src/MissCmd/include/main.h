#ifndef GAME_MAIN_H
#define GAME_MAIN_H 1

#define PROGNAME "MissCmd"
#define GAME_EXE_NAME PROGNAME

#include "MissCmd_rev.h"

#include <exec/exec.h>
#include <dos/dos.h>
#include <workbench/icon.h>
#include <workbench/workbench.h>
#include <intuition/screens.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/rpattr.h>
#include <libraries/Picasso96.h>
#include <datatypes/pictureclass.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/icon.h>
#include <proto/wb.h>
#include <proto/utility.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/Picasso96API.h>
#include <proto/datatypes.h>
#include <proto/layers.h>
#include <proto/diskfont.h>
#ifndef __amigaos4__
#include <clib/alib_protos.h>
#endif

#include <stdlib.h>
#include <string.h>
#ifndef stricmp
#define stricmp(s1,s2) Stricmp(s1, s2)
#endif

#include <SDI_compiler.h>

typedef struct MinList LIST;
typedef struct MinNode NODE;

#ifdef __amigaos4__
#define CreateNode(nodesize) AllocSysObjectTags(ASOT_NODE, \
		ASO_MemoryOvr,	MEMF_PRIVATE|MEMF_CLEAR, \
		ASONODE_Min,	TRUE, \
		ASONODE_Size,	nodesize, \
		TAG_END)
#define DeleteNode(node) FreeSysObject(ASOT_NODE, node)
#else /* !defined(__amigao4__) */
#include "os4_types.h"
#define MEMF_SHARED 0
#define MEMF_PRIVATE 0
#define CreateNode(size) AllocVec(size, MEMF_CLEAR)
#define DeleteNode(ptr) FreeVec(ptr)
#include <stdio.h>
#define SNPrintf snprintf
#define VSNPrintf vsnprintf
#define MoveMem(src,dst,siz) memmove(dst,src,siz)
#define GetHead(list) (((list)->lh_Head != (struct Node *)&(list)->lh_Tail) ? (list)->lh_Head : NULL)
#endif

#include "endian.h"
#include "cfg.h"
#include "gfx.h"
#include "gfx_gradient.h"
#include "audio_ahi.h"
#include "pointer.h"
#include "timer.h"
#include "entropy.h"

#define KEYUP 0x80
#define KEY_ESCAPE 0x45
#define KEY_BACKSPACE 0x41
#define KEY_DELETE 0x46
#define KEY_RETURN 0x44
#define KEY_UP 0x4C
#define KEY_DOWN 0x4D
#define KEY_LEFT 0x4F
#define KEY_RIGHT 0x4E
#define KEY_HELP 0x5F
#define KEY_MENU 0x6B
#define KEY_PAUSE 0x6E

#include "game.h"

#endif /* GAME_MAIN_H */
