// Emacs style mode select   -*- C++ -*-
//-----------------------------------------------------------------------------
//
// $Id: i_system.c,v 1.15 1998/09/07 20:06:44 jim Exp $
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
//
//-----------------------------------------------------------------------------

static const char
rcsid[] = "$Id: i_system.c,v 1.15 1998/09/07 20:06:44 jim Exp $";

#include <stdio.h>
#include <stdarg.h>

#include "i_system.h"
#include "i_sound.h"
#include "doomstat.h"
#include "m_misc.h"
#include "g_game.h"
#include "w_wad.h"
#include "lprintf.h"  // jff 08/03/98 - declaration of lprintf


// Amiga includes.
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/timer.h>


extern boolean nomusicparm, nosfxparm;



struct Device *TimerBase = NULL;
struct timerequest *TimerIO = NULL;
struct MsgPort *TimerMP = NULL;






// Most of the following has been rewritten by Lee Killough
//
// I_GetTime
//
int I_GetTime (void) {
	struct timeval tp;

	GetSysTime(&tp);

	return (tp.tv_secs * TICRATE) + (tp.tv_micro * TICRATE / 1000000);
}







void I_Shutdown(void) {

	if (TimerIO) {
		CloseDevice(&TimerIO->tr_node);
		DeleteIORequest(&TimerIO->tr_node);
		TimerIO = NULL;
	}

	if (TimerMP) {
		DeleteMsgPort(TimerMP);
		TimerMP = NULL;
	}

	TimerBase = NULL;
}

void I_Init(void) {

	TimerMP = CreateMsgPort();
	TimerIO = (struct timerequest *)CreateIORequest(TimerMP, sizeof(struct timerequest));
	OpenDevice("timer.device", UNIT_VBLANK, &TimerIO->tr_node, 0);
	TimerBase=TimerIO->tr_node.io_Device;

	if (!TimerBase) {
		I_Error("Can't open timer.device!");
	}


   if (!(nomusicparm && nosfxparm)) {
		I_InitSound();
	}

	atexit(I_Shutdown);
}




//
// I_Quit
//



void I_Quit(void) {
	if (demorecording) {
		G_CheckDemoStatus();
	}

	M_SaveDefaults ();

	closeConsole();
}

//
// I_Error
//

static int has_exited = 0;


void I_Error(const char *error, ...)
{
	va_list		argptr;
	char	text[2048];
	FILE    *errorFile;

	if (!has_exited) {
		has_exited = 1;   // Prevent infinitely recursive exits -- killough

		errorFile = fopen("ERROR.TXT", "wb");
		if (errorFile) {
			va_start (argptr, error);
			vsprintf (text, error, argptr);
			va_end (argptr);

			fwrite (text, 1, strlen(text), errorFile);
			fclose(errorFile);
		}

		exit(1);
	}
}




//----------------------------------------------------------------------------
//
// $Log: i_system.c,v $
// Revision 1.15  1998/09/07  20:06:44  jim
// Added logical output routine
//
// Revision 1.14  1998/05/03  22:33:13  killough
// beautification
//
// Revision 1.13  1998/04/27  01:51:37  killough
// Increase errmsg size to 2048
//
// Revision 1.12  1998/04/14  08:13:39  killough
// Replace adaptive gametics with realtic_clock_rate
//
// Revision 1.11  1998/04/10  06:33:46  killough
// Add adaptive gametic timer
//
// Revision 1.10  1998/04/05  00:51:06  phares
// Joystick support, Main Menu re-ordering
//
// Revision 1.9  1998/04/02  05:02:31  jim
// Added ENDOOM, BOOM.TXT mods
//
// Revision 1.8  1998/03/23  03:16:13  killough
// Change to use interrupt-driver keyboard IO
//
// Revision 1.7  1998/03/18  16:17:32  jim
// Change to avoid Allegro key shift handling bug
//
// Revision 1.6  1998/03/09  07:12:21  killough
// Fix capslock bugs
//
// Revision 1.5  1998/03/03  00:21:41  jim
// Added predefined ENDBETA lump for beta test
//
// Revision 1.4  1998/03/02  11:31:14  killough
// Fix ENDOOM message handling
//
// Revision 1.3  1998/02/23  04:28:14  killough
// Add ENDOOM support, allow no sound FX at all
//
// Revision 1.2  1998/01/26  19:23:29  phares
// First rev with no ^Ms
//
// Revision 1.1.1.1  1998/01/19  14:03:07  rand
// Lee's Jan 19 sources
//
//----------------------------------------------------------------------------
