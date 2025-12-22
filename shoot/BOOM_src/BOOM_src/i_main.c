// Emacs style mode select   -*- C++ -*-
//-----------------------------------------------------------------------------
//
// $Id: i_main.c,v 1.9 1998/09/07 20:10:02 jim Exp $
//
//  BOOM, a modified and improved DOOM engine
//  Copyright (C) 1999 by
//  id Software, Chi Hoang, Lee Killough, Jim Flynn, Rand Phares, Ty Halderman
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//      Main program, simply calls D_DoomMain high level loop.
//
//-----------------------------------------------------------------------------

static const char rcsid[] = "$Id: i_main.c,v 1.9 1998/09/07 20:10:02 jim Exp $";

char *ID = "$VER: BOOM 1.0.0.012\r\n";

#include "doomdef.h"
#include "m_argv.h"
#include "d_main.h"
#include "i_system.h"

#include "lprintf.h"  // jff 08/03/98 - declaration of lprintf



// Amiga includes.
#include <proto/dos.h>
#include <clib/icon_protos.h>
#include <workbench/startup.h>

#include "amiga_defines.h"


#define MAXARGVS        100


int main(int argc, char **argv) {


	return 0;
}


  /* these command line arguments are flags */
  static char *flags[] = {
    "-nomonsters",
    "-respawn",
    "-fast",
    "-nosound",
    "-nomusic",
    "-nosfx",
    "-nodraw"
  };


  /* these command line arguments each take a value */
  static char *settings[] = {
	"-turbo",
	"-playdemo",
	"-fastdemo",
	"-timedemo",
	"-skill",
	"-episode",
	"-timer",
	"-warp",
	"-wart",
    "-dumplumps",
    "-record",
    "-playdemo",
    "-iwad",
	"-debugfile"
  };


void wbmain(struct WBStartup *wbStartup) {

	char path[PATH_MAX];
	char *argv[] = {"BOOM", NULL};
	int argc;
	struct DiskObject *diskObject;
	DisplayType_t displayType = PAL;
	int i;
	char *toolType;

	// 1/18/98 killough: start up memory stuff first
	Z_Init();


	NameFromLock(wbStartup->sm_ArgList[0].wa_Lock, path, PATH_MAX);

	// Set the current directory.
	CurrentDir(wbStartup->sm_ArgList[0].wa_Lock);



	D_setDoomExeDir(path);


	// Setup command line.
	argc = sizeof(argv) / sizeof(char *) - 1;
	myargc = argc;

	myargv = malloc(sizeof(char *)*MAXARGVS);
	memset(myargv, 0, sizeof(char *)*MAXARGVS);

	memcpy(myargv, argv, sizeof(char *)*myargc);


	// Process Tooltypes.
	diskObject = GetDiskObject((char*)wbStartup->sm_ArgList[0].wa_Name);
	if (diskObject != NULL) {
        toolType = (char*)FindToolType((char* const*)diskObject->do_ToolTypes, "displaytype");
        if (toolType != NULL) {
			if (MatchToolValue(toolType, "NTSC")) {
				displayType = NTSC;
			}
        }


		// Process DOS command line flags.
		for (i = 0; i < sizeof(flags)/sizeof(flags[0]); i++) {
			if (FindToolType((char* const*)diskObject->do_ToolTypes, &flags[i][1]) != NULL) {
				myargv[myargc++] = flags[i];
			}
		}

		// Process DOS command line settings.
		for (i = 0; i < sizeof(settings)/sizeof(settings[0]); i++) {
			if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, &settings[i][1])) != NULL) {
				myargv[myargc++] = settings[i];
				myargv[myargc] = malloc(strlen(toolType)+1);
				strcpy(myargv[myargc++], toolType);
			}
		}


		// Handle loose files.
		if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, "file1")) != NULL) {
			myargv[myargc++] = "-file";
			myargv[myargc] = malloc(strlen(toolType)+1);
			strcpy(myargv[myargc++], toolType);

			// look for file 2.
			if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, "file2")) != NULL) {
				myargv[myargc] = malloc(strlen(toolType)+1);
				//strcpy(myargv[myargc++], " ");
				strcpy(myargv[myargc++], toolType);

				// look for file 3.
				if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, "file3")) != NULL) {
					myargv[myargc] = malloc(strlen(toolType)+1);
					//strcpy(myargv[myargc++], " ");
					strcpy(myargv[myargc++], toolType);
				}
			}
		}

		if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, "deh1")) != NULL) {
			myargv[myargc++] = "-deh";
			myargv[myargc] = malloc(strlen(toolType)+1);
			strcpy(myargv[myargc++], toolType);

			// look for file 2.
			if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, "deh3")) != NULL) {
				myargv[myargc] = malloc(strlen(toolType)+1);
				//strcpy(myargv[myargc++], " ");
				strcpy(myargv[myargc++], toolType);

				// look for file 3.
				if ((toolType = FindToolType ((char* const*)diskObject->do_ToolTypes, "deh3")) != NULL) {
					myargv[myargc] = malloc(strlen(toolType)+1);
					//strcpy(myargv[myargc++], " ");
					strcpy(myargv[myargc++], toolType);
				}
			}
		}
	}



	// Open a console window
	openConsole();


	atexit(I_Quit);

	// Setup fixed point maths for 060.
	__asm
	(
		"move.l		d0,-(sp) \n\t"
		
		"fmove.l	#65536,fp6 \n\t"
		"fmove.l	#1,fp7 \n\t"
		"fdiv.l		#65536,fp7 \n\t"
		
/*		"fmove.l	#16,fp6 \n\t"
		"fmove.l	#-16,fp7 \n\t"*/

		"fmove.l	fpcr,d0 \n\t"
		"or.b		#0x20,d0 \n\t"		/* runden gegen -unendlich */
		"or.b		#0x80,d0 \n\t"		/* runden auf double */
		"and.b	#0xFF-0x10-0x40,d0 \n\t"
		"fmove.l	d0,fpcr \n\t"
		
		"move.l		(sp)+,d0 \n\t"
	);

	// Never returns.
	D_DoomMain(displayType);
}



//----------------------------------------------------------------------------
//
// $Log: i_main.c,v $
// Revision 1.9  1998/09/07  20:10:02  jim
// Logical output routine added
//
// Revision 1.8  1998/05/15  00:34:03  killough
// Remove unnecessary crash hack
//
// Revision 1.7  1998/05/13  22:58:04  killough
// Restore Doom bug compatibility for demos
//
// Revision 1.6  1998/05/03  22:38:36  killough
// beautification
//
// Revision 1.5  1998/04/27  02:03:11  killough
// Improve signal handling, to use Z_DumpHistory()
//
// Revision 1.4  1998/03/09  07:10:47  killough
// Allow CTRL-BRK during game init
//
// Revision 1.3  1998/02/03  01:32:58  stan
// Moved __djgpp_nearptr_enable() call from I_video.c to i_main.c
//
// Revision 1.2  1998/01/26  19:23:24  phares
// First rev with no ^Ms
//
// Revision 1.1.1.1  1998/01/19  14:02:57  rand
// Lee's Jan 19 sources
//
//----------------------------------------------------------------------------