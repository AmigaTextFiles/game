
	OPT	O+,W-
	SECTION	buffer,CODE

	;
	; AmiSGE - savegame buffer (de)compress/(de)(en)crypt functions
	;
	; Adapted from code ripped from Amiga Frontier v1.06
	; (c) David Braben / GameTek
	;

	;
	; Exported symbols
	;

	XDEF	_gfMakeCloudBuffer	;make compressed/encrypted data
	XDEF	_gfMakeClearBuffer	;make decrypted/expanded data

;--------------------------------------------------------------------------------

FLASH:	MACRO
	move.w	#$c00,$dff106
	move.w	#\1,$dff180
	ENDM

ENC_SEED:	equ	$12350FD4	; = $12345678+$b95c

;--------------------------------------------------------------------------------

_gfMakeCloudBuffer:
	;
	; Compress and encrypt plain commander data
	;
	; Entry:	a0=decompressed/decrypted data source
	;	a1=compressed/encrypted data destination
	;	d1=length of source data
	;
	; Exit:	d0=length of compressed data, will be even
	;	data buffer will be a valid Frontier commander file
	;

	movem.l	d1-d7/a0-6,-(a7)

	move.w	#$0011,(a1)+	;write header

	move.l	a1,a4	;a4=saved destination address

	move.w	#$80ED,d0	;compress first section
	bsr	_mfCompress

	move.w	#$20B,d0	;second section not compressed
.mc_copy1:	move.b	(a0)+,(a1)+
	dbf	d0,.mc_copy1

	move.w	#$3661,d0	;compress third section
	bsr	_mfCompress

	move.l	a1,d1	;get d1=compressed length
	sub.l	a4,d1

	btst	#0,d1	;ensure compressed length is even
	beq.s	.mc_got_length
	addq.l	#1,d1
	clr.b	(a1)+
.mc_got_length:

	move.l	a4,a0	;encrypt compressed data
	move.l	d1,d0
	bsr	_mfEncrypt

	move.l	d0,(a1)+	;store checksum

	addq.l	#6,d1	;add on length of header & checksum
	move.l	d1,d0

	movem.l	(a7)+,d1-d7/a0-6
	rts

;--------------------------------------------------------------------------------

_gfMakeClearBuffer:
	;
	; Decrypt and decompress commander data
	;
	; Entry:	a0=compressed/encrypted data source
	;	a1=decompressed/decrypted data destination
	;	d1=length of source data
	;
	; Exit:	source data is trashed
	;	d0=0 if successful
	;	  =1 if source data was not a commander file
	;	  =2 if source data checksum was wrong
	;

	movem.l	d1-d7/a0-6,-(a7)

	cmpi.w	#$0011,(a0)+	;check header bytes
	bne.s	.mc_fail_data	;exit if header wrong

	subq.l	#6,d1	;adjust length for header & checksum

	move.l	d1,d0	;decrypt source data
	bsr	_mfDecrypt
	cmp.l	0(a0,d1.l),d0	;check checksum is correct
	bne.s	.mc_fail_csum

	; decompress now-decrypted source data to destination

	exg	a0,a1	;a0=dest, a1=source
	move.w	#$80ED,d0	;d0=max decompressed size
	bsr	_mfDecompress	;do decompression

	move.w	#$20B,d0
.mc_copy1:	move.b	(a1)+,(a0)+
	dbf	d0,.mc_copy1

	move.w	#$3661,d0	;d0=max decompressed size
	bsr	_mfDecompress	;do decompression

.mc_done:	movem.l	(a7)+,d1-d7/a0-6
	moveq	#0,d0
	rts

.mc_fail_data:
	movem.l	(a7)+,d1-d7/a0-6
	moveq	#1,d0
	rts

.mc_fail_csum:
	movem.l	(a7)+,d1-d7/a0-6
	moveq	#2,d0
	rts

;--------------------------------------------------------------------------------

_mfCompress:
	;
	; Compression function
	;
	; Entry:	a0=source (decompressed)
	;	a1=destination      (compressed)
	;	d0=data length
	;

.l66780B7C	move.b	(a0)+,(a1)+
	dbeq	d0,.l66780B7C
	bne.s	.cm_done
	subq.w	#1,d0
	bcs.s	.cm_done
.l66780B88	moveq	#0,d1
.l66780B8A	move.b	(a0)+,d2
	bne.s	.l66780B9C
	addq.b	#1,d1
	dbeq	d0,.l66780B8A
	bne.s	.l66780BA8
	subq.b	#1,d1
	subq.w	#1,d0
	bcs.s	.l66780BA8
.l66780B9C	move.b	d1,(a1)+
	move.b	d2,(a1)+
	dbeq	d0,.l66780B7C
	beq.s	.l66780B88
	bra.s	.cm_done
.l66780BA8	move.b	d1,(a1)+

.cm_done:
	rts

;--------------------------------------------------------------------------------

_mfEncrypt:	;
	; Encryption function
	;
	; Entry:	a0=buffer
	;	d0=length
	;
	; Exit:	d0=final encryption longword
	;

	movem.l	d1-2/a0,-(a7)

	move.l	d0,d2
	lsr.l	#1,d2
	move.l	#ENC_SEED,d0

.enc_loop:	move.w	(a0),d1
	eor.w	d0,(a0)+
	ext.l	d1
	add.l	d1,d0
	rol.l	#1,d0
	subq.l	#1,d2
	bne.s	.enc_loop

	movem.l	(a7)+,d1-2/a0
	rts

;--------------------------------------------------------------------------------

_mfDecompress:
	;
	; Decompression function
	;
	; Entry:	a0=destination (decompressed)
	;	a1=source      (compressed)
	;	d0=decompressed length
	;

	moveq	#0,d2	;d2=constant
.dc_main_loop:
	move.b	(a1)+,(a0)+
	dbeq	d0,.dc_main_loop
	bne.s	.dc_decomp_done
	move.b	(a1)+,d1
	andi.w	#$FF,d1
	sub.w	d1,d0
	bcs.s	.dc_decomp_done
	subq.w	#1,d1
	bmi.s	.dc_next
.dc_expand_zero_loop:
	move.b	d2,(a0)+
	dbf	d1,.dc_expand_zero_loop

.dc_next:	dbf	d0,.dc_main_loop

.dc_decomp_done:
	rts

;--------------------------------------------------------------------------------

_mfDecrypt:	;
	; Decryption function
	;
	; Entry:	a0=buffer
	;	d0=length
	;
	; Exit:	d0=final encryption longword
	;

	movem.l	d1-2/a0,-(a7)

	move.l	d0,d2
	lsr.l	#1,d2
	move.l	#ENC_SEED,d0

.dec_loop:	eor.w	d0,(a0)
	move.w	(a0)+,d1
	ext.l	d1
	add.l	d1,d0
	rol.l	#1,d0
	subq.l	#1,d2
	bne.s	.dec_loop

	movem.l	(a7)+,d1-2/a0
	rts

;--------------------------------------------------------------------------------
