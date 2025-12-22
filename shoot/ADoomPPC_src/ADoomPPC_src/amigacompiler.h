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

/* compiler dependant definitions */

#ifdef __SASC
#   define SAVEDS       __saveds
#   define ASM          __asm
#   define REG(x,y)     register __##x y
#elif defined(__GNUC__)
#   define SAVEDS
#   define ASM
#   define REG(x,y)     y __asm__(#x)
#elif defined(_DCC)
#   define SAVEDS       __geta4
#   define ASM
#   define REG(x,y)     __##x y
#elif defined(__STORM__)
#   define SAVEDS       __saveds
#   define ASM
#   define REG(x,y)     register __##x y
#elif defined(__VBCC__)
#   define SAVEDS       __saveds
#   define ASM
#   define REG(x,y)     __reg(#x) y
#else
#   error   add #defines for your compiler...
#endif
