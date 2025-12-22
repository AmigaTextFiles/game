*
* Copyright (C) 1996-1997 Id Software, Inc.
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License
* as published by the Free Software Foundation; either version 2
* of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*
* See the GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*

**
** Audio Interrupt routine
**
** used for M68k as well as for PowerPC
** written by Frank Wille <frank@phoenix.owl.de>
**

  incdir  "StormC:ASM-Include/"

	include	"devices/timer.i"
	include "hardware/custom.i"
	include	"hardware/intbits.i"

CUSTOM		equ	$dff000
GetSysTime	equ	-66

; a1 = IntData
; Offset 0:	*TimerBase
; Offset 4:	*FirstTime2
; Offset 8:	*aud_start_time


	code

	xdef	_AudioIntCode
	xdef	AudioIntCode
_AudioIntCode:
AudioIntCode:
	movem.l	a4-a6,-(sp)
	fsave   -(sp)
	fmovem.x fp0-fp2,-(sp)
	move.w	CUSTOM+intreqr,d0
	and.w	#INTF_AUD0|INTF_AUD1|INTF_AUD2|INTF_AUD3,d0
	move.w	d0,CUSTOM+intreq
	move.l	a1,a5
	move.l	(a5)+,a6		; TimerBase
	lea	TVstruct(pc),a0
	jsr	GetSysTime(a6)
	move.l	(a5)+,a1
	move.l	TV_SECS(a0),d0
	sub.l	(a1),d0			; - FirstTime2
	fmove.l	d0,fp0
	move.l	TV_MICRO(a0),d1
	fmove.l	d1,fp1
	fmove.l	#1000000,fp2
	fdiv	fp2,fp1
	move.l	(a5),a0
	fadd	fp1,fp0
	fmove.d	fp0,(a0)
	fmovem.x (sp)+,fp0-fp2
	frestore (sp)+
	movem.l	(sp)+,a4-a6
	moveq	#0,d0
	rts


	cnop	0,8
TVstruct:
	dcb.b	TV_SIZE,0
