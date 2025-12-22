/* amiga_global.h
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
 * $Header: RCS/amiga_global.h,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#define _AMIGA_GLOBAL_H	1

	/* Amiga interpreter version and revision. */

#define	AMIGA_VERSION	2
#define AMIGA_REVISION	20

#define VERSION_STRING	"\0$VER: AmigaInfocom 2.20 (6.10.92)"

	/* Stop GCC from complaining. */

#ifdef __GNUC__
#include <inline/stubs.h>
#endif	/* __GNUC__ */

	/* System library includes. */

#include <intuition/intuitionbase.h>
#include <graphics/displayinfo.h>
#include <workbench/workbench.h>
#include <libraries/iffparse.h>
#include <libraries/gadtools.h>
#include <graphics/gfxmacros.h>
#include <libraries/diskfont.h>
#include <workbench/startup.h>
#include <graphics/gfxbase.h>
#include <devices/conunit.h>
#include <devices/audio.h>
#include <devices/timer.h>
#include <exec/execbase.h>
#include <libraries/asl.h>
#include <dos/dosextens.h>
#include <exec/devices.h>
#include <exec/memory.h>
#include <dos/dostags.h>
#include <clib/macros.h>

	/* System library prototypes. */

#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/iffparse_protos.h>
#include <clib/diskfont_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/utility_protos.h>
#include <clib/console_protos.h>
#include <clib/exec_protos.h>
#include <clib/icon_protos.h>
#include <clib/alib_protos.h>
#include <clib/asl_protos.h>
#include <clib/dos_protos.h>
#include <clib/wb_protos.h>

	/* Standard ANSI `C' includes. */

#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

	/* Some help to keep the code size down. */

#ifdef AZTEC_C

#include <pragmas/utility_lib.h>
#include <pragmas/exec_lib.h>

#endif	/* AZTEC_C */

#ifdef LATTICE

#include <pragmas/utility_pragmas.h>
#include <pragmas/exec_pragmas.h>

#endif	/* LATTICE */

	/* We will try to block signal handling for GCC. */

#ifdef __GNUC__

#include <signal.h>

	/* Signals to trap while running. */

#define TRAPPED_SIGNALS (sigmask(SIGINT)|sigmask(SIGQUIT)|sigmask(SIGILL)|sigmask(SIGTRAP)|sigmask(SIGABRT)|sigmask(SIGEMT)|sigmask(SIGFPE)|sigmask(SIGBUS)|sigmask(SIGSEGV)|sigmask(SIGSYS)|sigmask(SIGALRM)|sigmask(SIGTERM)|sigmask(SIGTSTP))

#endif	/* __GNUC__ */

	/* Local header files. */

#include "patchlevel.h"
#include "infocom.h"

	/* Options changeable at runtime. */

enum	{	OPTION_ATTRIBUTE_ASSIGNMENTS, OPTION_ATTRIBUTE_TESTS, OPTION_ECHO, OPTION_PAGING,
		OPTION_PROMPT, OPTION_STATUS, OPTION_TANDY, OPTION_XFERS };

	/* Screen colour types. */

enum	{	COLOUR_INPUT, COLOUR_STATUS, COLOUR_TEXT, COLOUR_SPECIAL, COLOUR_ERROR };

	/* Cursor width codes. */

enum	{	CURSOR_AVERAGE = -1, CURSOR_NOCHANGE = 0 };

	/* Save file requester choices. */

enum	{	SAVE_CANCEL, SAVE_PROCEED, SAVE_NEWNAME };

	/* Serial and release number table entries. */

enum	{	SERIAL_INDEX, SERIAL_RELEASE, SERIAL_NUMBER };

	/* Menu numbers. */

enum	{	MENU_PROJECT, MENU_EDIT, MENU_COMMANDS, MENU_STORY, MENU_OPTIONS };

	/* Selected menu item codes. */

enum	{	PROJECTMENU_ABOUT = 0, PROJECTMENU_SCRIPT = 5 };

enum	{	EDITMENU_CUT = 0, EDITMENU_COPY = 1, EDITMENU_PASTE = 2, EDITMENU_UNDO = 4};

enum	{	OPTIONSMENU_ATTRIBUTE_ASSIGNMENTS, OPTIONSMENU_ATTRIBUTE_TESTS, OPTIONSMENU_ECHO,
		OPTIONSMENU_PAGING, OPTIONSMENU_PROMPT, OPTIONSMENU_STATUS, OPTIONSMENU_TANDY,
		OPTIONSMENU_XFERS };

	/* Chipdata offsets. */

enum	{	CHIPDATA_PATTERN, CHIPDATA_POINTER=2 };

	/* Transcript control panel gadget IDs. */

enum	{	SCRIPTGAD_PRINTER_STRING, SCRIPTGAD_PRINTER_WIDTH, SCRIPTGAD_PRINTER_ACCEPT,
		SCRIPTGAD_PRINTER_CANCEL, SCRIPTGAD_PRINTER_SELECT };

	/* Script file requester choices. */

enum	{	SCRIPT_CANCEL, SCRIPT_PROCEED, SCRIPT_APPEND, SCRIPT_NEWNAME };

	/* Two handy gadget data access macros. */

#define GT_STRING(G)		(((struct StringInfo *)(((struct Gadget *)(G)) -> SpecialInfo)) -> Buffer)
#define GT_INTEGER(G)		(((struct StringInfo *)(((struct Gadget *)(G)) -> SpecialInfo)) -> LongInt)

	/* A macro to attach the stopwatch mouse pointer to a window. */

#define WaitPointer(Window)	SetPointer(Window,&ChipData[CHIPDATA_POINTER],STOPWATCH_HEIGHT,STOPWATCH_WIDTH,STOPWATCH_LEFT_OFFSET,STOPWATCH_TOP_OFFSET)

	/* Chunk IDs required by the clipboard code. */

#define ID_FTXT			MAKE_ID('F','T','X','T')
#define ID_CHRS			MAKE_ID('C','H','R','S')

	/* Window/Screen title text. */

#define SCREEN_TITLE		"Portable Infocom Datafile Interpreter  Copyright \251 1987-1992 InfoTaskForce"

	/* Number of function keys. */

#define NUM_FKEYS		20

	/* Number of additional icon tool type entries. */

#define NUM_OPTIONS		13

	/* Number of menu entries. */

#define NUM_MENUS		44

	/* Length of `fake' input string. */

#define INPUT_LENGTH		1024

	/* Global temporary buffer size. */

#define BUFFER_LENGTH		1024

	/* Clipboard buffer length. */

#define CLIP_LENGTH		1024

	/* Game list control panel gadget IDs. */

enum	{	GAMEGAD_LIST, GAMEGAD_SELECT, GAMEGAD_CANCEL };

	/* Game levels. */

enum	{	LEVEL_INTRODUCTORY,LEVEL_STANDARD,LEVEL_ADVANCED,LEVEL_EXPERT };

	/* The number of type 3 games available. */

#define NUM_GAMES		24

	/* The script file name extension. */

#ifndef SCRIPT_EXT
#define SCRIPT_EXT		".Script"
#endif	/* !SCRIPT_EXT */

	/* How many history lines to keep, change this value if you
	 * wish to use a different number.
	 */

#ifndef HISTORY_LINES
#define HISTORY_LINES		20
#endif	/* !HISTORY_LINES */

	/* Default terminal window dimensions. */

#ifndef WINDOW_COLUMNS
#define WINDOW_COLUMNS		80
#endif	/* !WINDOW_COLUMNS */

#ifndef WINDOW_LINES
#define WINDOW_LINES		25
#endif	/* !WINDOW_LINES */

	/* Minimum terminal window dimensions. */

#ifndef MIN_WINDOW_COLUMNS
#define MIN_WINDOW_COLUMNS	40
#endif	/* !MIN_WINDOW_COLUMNS */

#ifndef MIN_WINDOW_LINES
#define MIN_WINDOW_LINES	10
#endif	/* !MIN_WINDOW_LINES */

	/* Minimum printer page width. */

#ifndef MIN_PRINTER_COLUMNS
#define MIN_PRINTER_COLUMNS	40
#endif	/* !MIN_PRINTER_COLUMNS */

	/* Default story file names. */

#ifndef FNAME_LST
#define FNAME_LST		{"Story",0}
#endif	/* !FNAME_LST */

	/* Default story file name extensions. */

#ifndef FEXT_LST
#define FEXT_LST		{"",".Dat",".Data",0}
#endif	/* !FEXT_LST */

	/* A handy alias for menu flags. */

#define MENU_TICK		(CHECKIT | MENUTOGGLE)

	/* Maximum filename length, including full path. */

#define MAX_FILENAME_LENGTH	256

	/* Maximum AmigaDOS file name length (dreaded BCPL artefact). */

#define AMIGADOS_NAME_LIMIT	31

	/* The length of the ".Save" file name suffix. */

#define SAVE_SUFFIX_LENGTH	5

	/* The ".Save" file suffix. */

#define SAVE_SUFFIX		".Save"

	/* Stopwatch mouse pointer size and offsets. */

#define STOPWATCH_HEIGHT	16
#define STOPWATCH_WIDTH		0
#define STOPWATCH_LEFT_OFFSET	-6
#define STOPWATCH_TOP_OFFSET	0

	/* Minimum system software revision required. */

#define LIB_VERSION		37

	/* Control sequence introducer. */

#define TERM_CSI		0x9B

	/* Backspace character. */

#define TERM_BS			'\b'

	/* Delete character. */

#define TERM_DEL		0x7F

	/* Return character. */

#define TERM_CR			'\r'

	/* Control-X, clear the input line. */

#define TERM_CUT		0x18

	/* Control-\, equivalent to hitting the window
	 * close gadget.
	 */

#define TERM_CLOSE		0x1C

	/* Control-A, moves cursor to beginning of line. */

#define TERM_BEGIN		0x01

	/* Control-Z, moves cursor to end of line. */

#define TERM_END		0x1A

	/* Control-W, deletes the word to the left of the cursor. */

#define TERM_DELWORD		0x17

	/* Control-K, delete everything from the cursor forward to
	 * the end of the line.
	 */

#define TERM_DELFWD		0x0B

	/* Control-U, delete everything from the cursor backward
	 * to the start of the line.
	 */

#define TERM_DELBCK		0x15

	/* Control-Y, undoes previous editing action. */

#define TERM_UNDO		0x19

	/* Control-C, copies input line to clipboard. */

#define TERM_COPY		0x03

	/* Form feed, returned when window is resized. */

#define TERM_RESIZE		'\f'

	/* This is a second measured in microseconds. */

#define SECOND			1000000

	/* Audio channel bits. */

#define LEFT0F  1
#define RIGHT0F  2
#define RIGHT1F  4
#define LEFT1F  8

	/* Three handy signal masks. */

#define SIG_WINDOW		(1L << Window -> UserPort -> mp_SigBit)
#define SIG_WORKBENCH		(WorkbenchPort ? (1L << WorkbenchPort -> mp_SigBit) : NULL)
#define SIG_TIME		(1L << TimePort -> mp_SigBit)

	/* Some definitions which may not yet be available in every
	 * include file set.
	 */

#ifndef GTMN_NewLookMenus
#define GTMN_NewLookMenus	(GT_TagBase+67)
#endif	/* !GTMN_NewLookMenus */

#ifndef WA_NewLookMenus
#define WA_NewLookMenus		(WA_Dummy+0x30)
#endif	/* !WA_NewLookMenus */

	/* A handle to hold command history lists and function key
	 * assignments.
	 */

struct StringBuffer
{
	int			 sb_Len;	/* Length of the string. */
	char			*sb_Buffer;	/* The string itself. */
};

	/* A special node type. */

struct GameNode
{
	struct Node		 gn_Node;	/* Vanilla Exec Node. */
	char			*gn_FileName;	/* Corresponding file name. */
};

	/* Local includes. */

#ifndef _AMIGA_DATA_C
#include "amiga_data.h"
#include "amiga_protos.h"
#endif	/* _AMIGA_DATA_C */
