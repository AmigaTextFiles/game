; *** $VER: trackdisk.device utilities V1.2
; *** Written by Jean-François Fabre
; ***
; *** Thanks to Harry


	include	"/lib/libs.i"
	include	"/lib/macros.i"
	include	"devices/trackdisk.i"
	include	"exec/io.i"

	XREF	_SysBase

; *** DOS Disks track read/write
; *** Sorry for the shitty code
;
; At least it works fine

DOS_SECTOR_LEN=512
DOS_TRACK_LEN=DOS_SECTOR_LEN*11


	XDEF	_ReadRawTrackSync
	XDEF	@ReadRawTrackSync

	XDEF	_ReadRawTrackIndex
	XDEF	@ReadRawTrackIndex

	XDEF	_ReadDosTrack
	XDEF	_WriteDosTrack
	XDEF	_ReadSector
	XDEF	_WriteSector
	XDEF	_InitTrackDisk
	XDEF	_ShutTrackDisk
	
	XDEF	_ReadBoot
	XDEF	_WriteBoot
	XDEF	_CheckDiskIn
	XDEF	_CheckWriteProtect
	XDEF	@ReadBoot

_ReadRawTrackIndex:
	move.l	8(A7),A0
	move.l	4(A7),D0
@ReadRawTrackIndex:
	movem.l	D1-D6/A1-A6,-(sp)
	lea	diskio,a1
	move.w	#TD_RAWREAD,IO_COMMAND(a1)
	move.b	#IOTDB_INDEXSYNC,IO_FLAGS(a1)
	move.l	A0,IO_DATA(a1)
	move.l	#$7FFE,IO_LENGTH(a1)
	move.l	D0,IO_OFFSET(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	movem.l	(sp)+,D1-D6/A1-A6
	rts	


_ReadRawTrackSync:
	move.l	8(A7),A0
	move.l	4(A7),D0
@ReadRawTrackSync:
	movem.l	D1-D6/A1-A6,-(sp)
	lea	diskio,a1
	move.w	#TD_RAWREAD,IO_COMMAND(a1)
	move.b	#IOTDB_WORDSYNC,IO_FLAGS(a1)
	move.l	A0,IO_DATA(a1)
	; *** something missing!!!!!!!
	move.l	#$7C00,IO_LENGTH(a1)
	move.l	D0,IO_OFFSET(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	movem.l	(sp)+,D1-D6/A1-A6
	rts	

_ReadDosTrack:
	move.l	8(A7),A0
	move.l	4(A7),D0
@ReadDosTrack:
	STORE_REGS
	mulu.w	#DOS_TRACK_LEN,D0
	lea	diskio,a1
	move.w	#2,28(a1)
	move.l	A0,40(a1)
	move.l	#DOS_TRACK_LEN,36(a1)
	move.l	D0,44(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	RESTORE_REGS
	moveq	#0,D0	
	rts

_ReadBoot:
	move.l	4(A7),D0
@ReadBoot:
	STORE_REGS
	lea	diskio,a1
	move.w	#2,28(a1)	; Command = read
	move.l	D0,40(a1)	; Buffer
	move.l	#2*DOS_SECTOR_LEN,36(a1)	; Boot length
	move.l	#0,44(a1)	; Boot sector
	move.l  _SysBase,a6
	JSRLIB	DoIO
	RESTORE_REGS
	moveq	#0,D0	
	rts

_WriteBoot:
	move.l	4(A7),D0
@WriteBoot:
	STORE_REGS
	lea	diskio,a1
	move.w	#3,28(a1)	; Command = write
	move.l	D0,40(a1)	; Buffer
	move.l	#2*DOS_SECTOR_LEN,36(a1)	; Boot length
	move.l	#0,44(a1)	; Boot sector
	move.l  _SysBase,a6
	JSRLIB	DoIO
	RESTORE_REGS
	moveq	#0,D0	
	rts

_WriteDosTrack:
	move.l	8(A7),A0
	move.l	4(A7),D0
@WriteDosTrack:
	STORE_REGS
	mulu.w	#DOS_TRACK_LEN,D0
	lea     diskio(PC),a1
	move    #3,28(a1)		; CMD_WRITE
	move.l  A0,40(a1)
	move.l  #DOS_TRACK_LEN,36(a1)
	move.l  D0,44(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	RESTORE_REGS
	moveq	#0,D0	
	rts
	
_WriteSector:
	move.l	8(A7),A0
	move.l	4(A7),D0
@WriteSector:
	STORE_REGS
	mulu.w	#DOS_SECTOR_LEN,D0
	lea     diskio(PC),a1
	move.w	#3,28(a1)		; CMD_WRITE
	move.l  A0,40(a1)
	move.l  #DOS_SECTOR_LEN,36(a1)
	move.l  D0,44(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	RESTORE_REGS
	moveq	#0,D0	
	rts

_ReadSector:
	move.l	8(A7),A0
	move.l	4(A7),D0
@ReadSector:
	STORE_REGS
	mulu.w	#DOS_SECTOR_LEN,D0
	lea     diskio(PC),a1
	move.w	#2,28(a1)		; CMD_READ
	move.l  A0,40(a1)
	move.l  #DOS_SECTOR_LEN,36(a1)
	move.l  D0,44(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	RESTORE_REGS
	moveq	#0,D0	
	rts


@SendCommand:
	movem.l	D1-A6,-(sp)
	lea	diskio(PC),a1
	move.w	d0,IO_COMMAND(a1)
	move.l  _SysBase,a6
	JSRLIB	DoIO
	move.l  32(a1),d0
	movem.l	(sp)+,D1-A6
	rts

_CheckDiskIn:
@CheckDiskIn:
	moveq	#14,d0		; Test Disk Inserted
	bsr	@SendCommand
	rts

_CheckWriteProtect:
@CheckWriteProtect:
	moveq	#15,d0		; Test Disk Write Protected
	bsr	@SendCommand
	rts

_InitTrackDisk:
	move.l	4(sp),D0
@InitTrackDisk:
	STORE_REGS

	move.l	D0,diskunit

	move.l	_SysBase,a6
	sub.l	a1,a1
	JSRLIB	FindTask
	move.l	d0,diskrep+$10
	
	lea	diskrep(PC),a1
	JSRLIB	AddPort
	
	lea	diskio(PC),a1
	move.l	#diskrep,14(a1)
	move.l	diskunit,d0
	clr.l	d1
	lea	trddevice(PC),a0
	JSRLIB	OpenDevice
	RESTORE_REGS
	move.l	#diskio,D0
	rts
	
_ShutTrackDisk:
@ShutTrackDisk:
	STORE_REGS
	move.l _SysBase,a6
	lea     diskio,a1  ; pointeur sur I/O disque
	move.l  32(a1),d7
	move    #9,28(a1)  ;  Moteur marche/arret
	move.l  #0,36(a1)  ; 0=arret,1=marche,c'est a dire arreter
	JSRLIB	DoIO   ; moteur
	
	lea	diskio,a1
	JSRLIB	CloseDevice ;  Fermer Trackdisk.device
	
	lea	diskrep,a1
	JSRLIB	RemPort	; Liberer port
	RESTORE_REGS
	moveq	#0,D0
	rts
	

diskio:
	blk.l 20,0
	
diskrep:
	blk.l 8,0

diskunit:
	dc.l	0

trddevice:
	dc.b	'trackdisk.device',0
	cnop	0,4

