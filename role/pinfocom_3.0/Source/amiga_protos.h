/* amiga_protos.h
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/amiga_protos.h,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

	/* Clipboard support routines. */

VOID		ClipClose(VOID);
LONG		ClipRead(STRPTR Buffer,const LONG Len);
VOID		ClipSave(const STRPTR Buffer,const LONG Len);
Bool		ClipOpen(VOID);

	/* Console text output and auxilary routines. */

UWORD		ConCharWidth(const UBYTE Char);
VOID		ConCursorOff(VOID);
VOID		ConCursorOn(const int New);
VOID		ConSet(const int X,const int Y,const int New);
VOID		ConMove(const int Delta,const int New);
VOID		ConClearEOL(VOID);
VOID		ConCharBackspace(const int Delta,const int New);
VOID		ConCharDelete(const int New);
VOID		ConCharInsert(const UBYTE Char);
VOID		ConScrollUp(VOID);
VOID		ConWrite(const char *Line,LONG Len,LONG Indent);
VOID		ConCloseLibs(VOID);
Bool		ConOpenLibs(VOID);
VOID		ConCleanup(VOID);
Bool		ConSetup(VOID);
UBYTE		ConGetChar(const Bool SingleKey);
VOID		ConSetColour(const int Colour);
VOID		ConSetKey(const int Key,const STRPTR String,const int Len);
VOID		ConPrintf(const char *Format,...);
VOID		ConSwap(STRPTR a,STRPTR b,int Len);
int		ConInput(char *Prompt,char *Input,const int MaxLen,const Bool DoHistory);
VOID		ConPrintStatus(const char *Left,const char *Right);
LONG		ConShowRequest(const struct Window *Window,const STRPTR Text,const STRPTR Gadgets,...);
Bool		ConQueryOption(int Option);
VOID		ConUpdateMenus(VOID);
VOID		ConLockMenus(VOID);
VOID		ConUnlockMenus(VOID);
char *		ConSplitLine(char *Line,int Len,Bool ReturnPrompt);
VOID		ConPrintLine(const char *Buffer,int Len,int Indent);
Bool		ConCheckStory(const char *Name);
char *		ConLocateStory(const char *Directory,const char *Default);
VOID		ConQueryStoryInformation(const char *Name);
VOID		ConAbout(VOID);

	/* Game file selection routines. */

VOID		GameAdd(struct List *List,int Index,const char *FileName);
Bool		GameMatch(const char *Name,const char *Pattern);
VOID		GameMultiScan(struct List *GameList,const char *Pattern);
char *		GameGetNodeName(struct List *List,const int Offset);
VOID		GameFreeList(struct List *List);
Bool		GameIsAssign(const STRPTR Name);
struct List *	GameBuildList(const char *Pattern);
char *		GameGetStoryName(const char *Pattern,const struct Window *Window);
VOID		GameCentreWindow(const struct Screen *Screen,const WORD WindowWidth,const WORD WindowHeight,WORD *LeftEdge,WORD *TopEdge);
struct Gadget *	GameCreateGadgets(struct Gadget **GadgetArray,struct Gadget **GadgetList,const APTR VisualInfo,const struct List *Labels,const struct Screen *Screen,WORD *Width,WORD *Height);
Bool		GameSelect(char *Name);

	/* Scripting support routines. */

Bool		ScriptWrite(const char *Buffer,const int Width);
struct Gadget *	ScriptCreateGadgets(struct Gadget **GadgetArray,struct Gadget **GadgetList,const APTR VisualInfo,UWORD *Width,UWORD *Height,const struct Screen *Screen);
Bool		ScriptGetPrinterName(STRPTR PrinterName,int *PrinterWidth);
char *		ScriptSplitLine(char *Line,int Len,const Bool ReturnPrompt);

	/* Sound support routines. */

Bool		SoundInit(VOID);
VOID		SoundExit(VOID);
VOID		SoundAbort(VOID);
VOID		SoundStop(VOID);
VOID		SoundStart(VOID);
