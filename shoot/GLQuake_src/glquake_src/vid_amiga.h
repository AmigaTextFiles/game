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

/* gfxboard-software specific driver functions (prototypes) */

extern void VID_SetPalette_ChunkyPPC (unsigned char *);
extern void VID_ShiftPalette_ChunkyPPC (unsigned char *);
extern void VID_Init_ChunkyPPC (unsigned char *);
extern void VID_Shutdown_ChunkyPPC (void);
extern void VID_Update_ChunkyPPC (vrect_t *);
extern void SysSendKeyEvents_ChunkyPPC(void);

extern void VID_SetPalette_CGFX (unsigned char *);
extern void VID_ShiftPalette_CGFX (unsigned char *);
extern void VID_Init_CGFX (unsigned char *);
extern void VID_Shutdown_CGFX (void);
extern void VID_Update_CGFX (vrect_t *);
extern void SysSendKeyEvents_CGFX(void);

extern void VID_SetPalette_AGA (unsigned char *);
extern void VID_ShiftPalette_AGA (unsigned char *);
extern void VID_Init_AGA (unsigned char *);
extern void VID_Shutdown_AGA (void);
extern void VID_Update_AGA (vrect_t *);
extern void SysSendKeyEvents_AGA(void);
