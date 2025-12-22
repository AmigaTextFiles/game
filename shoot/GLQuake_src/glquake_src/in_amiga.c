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

// Main Module for Input Code for Amiga Version, can be easily expanded
// to support other Init-Devices

/*
            Portability
            ===========

            This file should compile fine under all Amiga-Based Kernels,
            including WarpUP, 68k and PowerUP.

            Steffen Haeuser (MagicSN@Birdland.es.bawue.de)
*/

#include "quakedef.h"
#include "in_amiga.h"

int psxused;

void IN_Init (void)
{
  FILE *fil=fopen("devs:psxport.device","r");
  IN_InitMouse();
  psxused=0;
  if (fil)
  {
    fclose(fil);
    psxused=1;
    IN_InitPsx();
  }  
  IN_InitJoy();
}


void IN_Shutdown (void)
{
  if (psxused) IN_ShutdownPsx();
  IN_ShutdownJoystick();
  IN_ShutdownMouse();
}

void IN_Commands (void)
{
  IN_MouseCommands();
}

void IN_Move (usercmd_t *cmd)
{
  IN_MouseMove(cmd);
  if (psxused) IN_PsxMove(cmd);
  IN_JoyMove(cmd);
}
