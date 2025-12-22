/**
*** amyboard.h -- Include file for AmyBoard (Amiga XBoard)
*** Copyright 1995, Jochen Wiedmann
***
*** ------------------------------------------------------------------------
*** This program is free software; you can redistribute it and/or modify
*** it under the terms of the GNU General Public License as published by
*** the Free Software Foundation; either version 2 of the License, or
*** (at your option) any later version.
***
*** This program is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*** GNU General Public License for more details.
***
*** You should have received a copy of the GNU General Public License
*** along with this program; if not, write to the Free Software
*** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*** ------------------------------------------------------------------------
***
*** See the file ChangeLog for a revision history.
***/

#ifndef _AMYBOARD_H
#define _AMYBOARD_H

#include <config.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>

#include <libraries/mui.h>
#include <proto/muimaster.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <clib/alib_protos.h>
#include <clib/macros.h>

#include "args.h"
#include "common.h"
#include "frontend.h"
#include "backend.h"


/**
***  Compiler specific stuff
**/
#if defined(_DCC)

#define _REG(r,arg) __ ## r arg
#define _SAVEDS_FUNC(rslt, name) __geta4 rslt name
#define _HOOK_FUNC(rslt,name,arg1, arg2,arg3) \
  _SAVEDS_FUNC(rslt, name) (_REG(a0,arg1), _REG(a2,arg2), _REG(a1,arg3))

#elif defined(__SASC)

#define _REG(r,arg) register __ ## r arg
#define SAVEDS_FUNC(rslt, name) __saveds __asm rslt name
#define _HOOK_FUNC(rslt,name,arg1,arg2,arg3) \
  _SAVEDS_FUNC(rslt, name) (_REG(a0,arg1), _REG(a2,arg2), _REG(a1,arg3))

#elif defined(__GNUC__)

#define ___PUSH(a) "movel\t" #a ",sp@-\n"
#define ___POP(a)  "movel\tsp@+," #a "\n"
#ifndef SMALL_DATA
#define __REGP(functype,funcname,pushlist,popval) \
  __asm(".even\n" ".globl _" #funcname "\n" "_" #funcname ":\n" \
   pushlist "jbsr\t___" #funcname "\n" "addw\t#" #popval ",sp\n" \
   "rts\n"); functype __##funcname
#else
#define __REGP(functype,funcname,pushlist,popval) \
  __asm(".even\n" ".globl _" #funcname "\n" "_" #funcname ":\n" ___PUSH(a4) \
   pushlist "jbsr\t_geta4\n" "jbsr\t___" #funcname "\n" "addw\t#" \
   #popval ",sp\n" ___POP(a4) "rts\n"); functype __##funcname
#endif
#define _SAVEDS_FUNC(rslt,name) __REGP(rslt,name, ,0)
#define _HOOK_FUNC(rslt,name,arg1,arg2,arg3) \
  extern rslt name (arg1, arg2, arg3); \
  __REGP(rslt,name,___PUSH(a1)___PUSH(a2)___PUSH(a0),12) (arg1,arg2,arg3)

#else
#error "Don't know how to handle your compiler."
#endif



/**
***  Amiga specific application data
**/
typedef struct
{ STRPTR icsWindow;
  LONG childPriority;
  LONG childStack;
} AmigaAppData;
extern AmigaAppData amigaAppData;



/**
***  amyboard.c prototypes
**/
extern Object* xboardApp;
extern Object* xboardWindow;


/**
***  childio.c prototypes
**/
extern ULONG pipeSignals;
extern VOID DoInputCallback(ULONG);
extern VOID PipesInit(VOID);
extern VOID PipesClose(VOID);


/**
***  time.c prototypes
**/
extern ULONG timeSignals;
extern VOID TimeCallback(ULONG);
extern VOID TimeInit(VOID);
extern VOID TimeClose(VOID);


/**
***  muiclass.c prototypes and Tag ID's
**/
extern APTR XBoardObject(Tag, ...);
extern VOID MuiClassInit(VOID);
extern VOID MuiClassClose(VOID);
extern VOID CloseMuiWindow(Object *);


#define MUI_XBOARD_BASE (TAG_USER | (86 << 16))

#define MUIM_XBoard_DrawPosition            (MUI_XBOARD_BASE | 0x00)

#define MUIA_XBoard_BitmapDirectory         (MUI_XBOARD_BASE | 0x40)
#define MUIA_XBoard_SquareWidth             (MUI_XBOARD_BASE | 0x42)
#define MUIA_XBoard_SquareHeight            (MUI_XBOARD_BASE | 0x43)
#define MUIA_XBoard_FlipView                (MUI_XBOARD_BASE | 0x44)
#define MUIA_XBoard_ShowCoords              (MUI_XBOARD_BASE | 0x45)
#define MUIA_XBoard_LightSquarePen          (MUI_XBOARD_BASE | 0x46)
#define MUIA_XBoard_DarkSquarePen           (MUI_XBOARD_BASE | 0x47)
#define MUIA_XBoard_WhitePiecePen           (MUI_XBOARD_BASE | 0x48)
#define MUIA_XBoard_BlackPiecePen           (MUI_XBOARD_BASE | 0x49)
#define MUIA_XBoard_AlwaysPromoteToQueen    (MUI_XBOARD_BASE | 0x4a)
#define MUIA_XBoard_EditPosition            (MUI_XBOARD_BASE | 0x4b)


#ifdef DEBUG
extern VOID iprintf(char *, ...);
extern VOID kprintf(char *, ...);
#endif


/**
***  amygamelist.c prototypes
**/
void ShowGameListProc(void);


/**
***  amyedittags.c prototypes
**/
void EditTagsProc(void);


#endif
