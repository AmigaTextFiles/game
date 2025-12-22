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
**  Sound mixing routines for Amiga 68k
**  Written by Frank Wille <frank@phoenix.owl.de>
**

; dma_t (sound.h)
		rsreset
dma_gamealive	rs.l	1
dma_soundalive	rs.l	1
dma_splitbuffer	rs.l	1
dma_channels	rs.l	1
dma_samples	rs.l	1
dma_submission_chunk	rs.l	1
dma_samplepos	rs.l	1
dma_samplebits	rs.l	1
dma_speed	rs.l	1
dma_buffer	rs.l	1


	code

	xref	_shm
	xref	_paintbuffer
	xref	_paintedtime
	xref	_volume



	xdef	_S_TransferPaintBuffer
	cnop	0,4
_S_TransferPaintBuffer:
	movem.l	d2-d5/a2-a3,-(sp)
	setso	4+6*4
.endtim so.l	1

; The Amiga 68k version only supports 8 bit samples
	move.l	_shm,a1			; a1 shm (struct dma_t)
	lea	_paintbuffer,a0		; a0 paintbuffer (int left,int right)
	fmove.s	_volume+16,fp0		; volume.value * 256
	move.l	.endtim(sp),d2
	fmul.s	#256.0,fp0
	move.l	_paintedtime,d1
	sub.l	d1,d2			; d2 count
	beq	.exit
	move.l	dma_buffer(a1),a3	; a3 dma buffer start address
	fmove.l	fp0,d3			; d3 snd_vol
	move.l	dma_samples(a1),d0
	lea	(a3,d0.l),a2		; a2 dma buffer end address
	subq.l	#1,d0
	and.l	d0,d1
	lea	(a3,d1.l),a1		; a1 out
	move.l	#$7fffff,d4		; d4 max val
	move.l	d4,d5
	not.l	d5			; d5 min val

.loop8:	move.l	(a0),d0
	muls.l	d3,d0
	addq.l	#8,a0
	cmp.l	d4,d0
	ble.b	.1
	move.l	d4,d0
	bra.b	.2
.1:	cmp.l	d5,d0
	bge.b	.2
	move.l	d5,d0
.2:	swap	d0
	move.b	d0,(a1)+
	cmp.l	a2,a1
	bhs.b	.3
	subq.l	#1,d2
	bne.b	.loop8
.exit:	movem.l	(sp)+,d2-d5/a2-a3
	rts
.3:	move.l	a3,a1
	subq.l	#1,d2
	bne.b	.loop8
	bra.b	.exit
