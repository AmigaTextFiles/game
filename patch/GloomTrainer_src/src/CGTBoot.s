				
	OPT O+,W-
	OUTPUT PROJ:GloomTrainer/dist/GloomTrainer/CGTBoot
;	OUTPUT GAMES:Gloom/CGTBoot

;----------------------------------------------------------------------

	;For NewStartup

StartSkip:	equ 1	;0=WB/CLI, 1=CLI only (eg. from AsmOne)
Processor:	equ 0	;0/680x0 (= 0 is faster than 68000)
MathProc:	equ 0	;FPU: 0(none)/68881/68882/68040

;-----------------

CALLA6:	MACRO
	jsr _LVO\1(a6)
	ENDM

EXECCALL:	MACRO
	move.l $4.w,a6
	CALLA6 \1
	ENDM

DOSCALL:	MACRO
	LIBBASE dos
	CALLA6 \1
	ENDM

;----------------------------------------------------------------------

	INCLUDE INCLUDE:NewStartup39.s

Init:	DEFLIB dos,36	;Open the libs we need
	DEFEND		;ALWAYS REQUIRED!!!

;------------------------------------------------------------------------------

NumTrainers:	equ 6	;Number of trainers
NumVersions:	equ 2	;Number of exe versions

;------------------------------------------------------------------------------

Start:	;Start by clearing/setting the trainer flags
	cmp.w	#NumTrainers*2+1,d0	;Right params?
	bne	.notrainers		;Skip if not (no trainers)

	lea	.tr_flagtab(pc),a1
	moveq	#NumTrainers-1,d1

.trloop:	movem.l	d1/a1,-(a7)		;Get next argv
	NEXTARG
	movem.l	(a7)+,d1/a1
	tst.l d0			;Anything?
	beq	.paramdone		;Skip if not

	move.l	d0,a0		;a0=argv
	moveq	#0,d0		;Get parameter in d0
	move.b	(a0),d0
	sub.w	#"0",d0		;Convert to number
	beq.s	.trl_setflag
	cmp.w	#1,d0
	bne.s	.notrainers

.trl_setflag:
	REPT NumVersions
	move.l	(a1)+,a0		;a0=trainerflag address
	move.w	d0,(a0)
	ENDR

.trl_next:	dbf	d1,.trloop
	bra.s	.paramdone
;---

.notrainers:	;Deactivate all trainers
	lea	.tr_flagtab(pc),a1
	moveq	#NumTrainers-1,d1
.ntrloop:
	REPT NumVersions
	move.l	(a1)+,a0
	clr.w	(a0)
	ENDR
	dbf 	d1,.ntrloop

;---
;	Load the executable

.paramdone:	move.l #FileName,d1	;Load the main exe
	DOSCALL LoadSeg
	move.l d0,SegList
	beq loadseg_err

	lsl.l #2,d0		;Get pointer to first hunk's data
	addq.l #4,d0
	move.l d0,a0		;a0=start of code
	move.l a0,ExeAddr

;---	;Which version of the exe have we loaded?

	cmp.l #$61000086,$162(a0)
	beq.s .have_v2

	lea .trainer_v1(pc),a1
	bra.s .got_trainertab

.have_v2:	lea .trainer_v2(pc),a1

;---

.got_trainertab:
	;Apply trainers to loaded exe
	;a1=trainer table to train from

	moveq #NumTrainers-1,d7	;d7=no of trainers-1

.at_loop:	tst.w (a1)+		;Use this trainer?
	bne.s .at_active	;Skip if yes

	;Trainer inactive...just read over its data
.at_skiploop:
	tst.l (a1)+
	beq.s .at_next
	addq.l #4,a1
	bra.s .at_skiploop

.at_active:	;Trainer active...apply the pokes, with checks!

.at_pokeloop:
	move.l (a1)+,d0	;d0=offset from base address
	beq.s .at_next	;Back to start if done

	move.l ExeAddr(pc),a0	;a0=base address
	add.l d0,a0		;a0=poke address

	move.w (a0),d0	;d0=current contents
	cmp.w (a1)+,d0	;What we expect?
	bne poke_err		;Skip if not

	move.w (a1)+,(a0)	;Do the poke
	bra.s .at_pokeloop

.at_next:	dbf d7,.at_loop

;---	
;	We should now have a suitably trained program - start it!

	move.l ExeAddr(pc),a0	;Call the game
	jsr (a0)

	move.l SegList,d1	;Unload the game
	DOSCALL UnLoadSeg

	moveq #0,d0		;All done!
	rts

;------------------------------------------------------------------------------

	;Trainer flag addresses
	; flag1,version1
	; flag1,version2
	; ...
	; flag1,versionN
	; flag2,version1
	; flag2,version2
	; ...
	; flag2,versionN
	; ...
	; flagM,versionN
	
.tr_flagtab:	dc.l .trf_v1lives
	dc.l .trf_v2lives
	dc.l .trf_v1biggun
	dc.l .trf_v2biggun
	dc.l .trf_v1invis
	dc.l .trf_v2invis
	dc.l .trf_v1thermo
	dc.l .trf_v2thermo
	dc.l .trf_v1bouncy
	dc.l .trf_v2bouncy
	dc.l .trf_v1maxboost
	dc.l .trf_v2maxboost

	;Trainer:
	;  Flag.w
	;  Poke 1:
	;    Offset.l
	;    Correct value.w
	;    Trained value.w
	;  ...
	;  Poke n:
	;    Offset.l
	;    Correct value.w
	;    Trained value.w
	;  0.l


.trainer_v1:	;Version 1 trainers

	;Infinite lives
.trf_v1lives:
	dc.w 0

	dc.l $3162
	dc.w $536d,$4a6d

	dc.l $317a
	dc.w $536d,$4a6d

	dc.l 0

	;Infinite max-gun
.trf_v1biggun:
	dc.w 0

	dc.l $3408
	dc.w $4a6d,$3b7c

	dc.l $340a
	dc.w $003a,$7fff

	dc.l $340c
	dc.w $671e,$003a

	dc.l $340e
	dc.w $536d,$3b7c

	dc.l $3410
	dc.w $003a,$0004	;$0004 is gun power, 0-4

	dc.l $3412
	dc.w $6618,$0054

	dc.l $3414
	dc.w $6100,$6016

	dc.l 0

	;Infinite invis
.trf_v1invis:
	dc.w 0

	dc.l $345c
	dc.w $4a6d,$3b7c

	dc.l $345e
	dc.w $00a2,$ffff

	dc.l $3460
	dc.w $671e,$00a2

	dc.l $3462
	dc.w $536d,$601c

	dc.l 0

	;Infinite thermo
.trf_v1thermo:
	dc.w 0

	dc.l $342c
	dc.w $4a6d,$3b7c

	dc.l $342e
	dc.w $00a0,$0800

	dc.l $3430
	dc.w $6720,$00a0

	dc.l $3432
	dc.w $536d,$601e

	dc.l 0

	;Infinite bouncies
.trf_v1bouncy:
	dc.w 0

	dc.l $966
	dc.w $426d,$42ad

	dc.l $96a
	dc.w $426d,$4e71

	dc.l $96c
	dc.w $00b8,$3b7c

	dc.l $96e
	dc.w $426d,$0020	;$20 is number of bounces

	dc.l 0

	;Gun boost gives maximum
.trf_v1maxboost:
	dc.w 0

	dc.l $3294
	dc.w $0c2d,$1b7c

	dc.l $329a
	dc.w $661e,$4e71

	dc.l 0


.trainer_v2:	;Version 2 trainers - GloomCD32

	;Infinite lives
.trf_v2lives:
	dc.w 0

	dc.l $315c
	dc.w $536d,$4a6d

	dc.l $3174
	dc.w $536d,$4a6d

	dc.l 0

	;Infinite max-gun
.trf_v2biggun:
	dc.w 0

	dc.l $3402
	dc.w $4a6d,$3b7c

	dc.l $3404
	dc.w $003a,$7fff

	dc.l $3406
	dc.w $671e,$003a

	dc.l $3408
	dc.w $536d,$3b7c

	dc.l $340a
	dc.w $003a,$0004	;$0004 is gun power, 0-4

	dc.l $340c
	dc.w $6618,$0054

	dc.l $340e
	dc.w $6100,$6016

	dc.l 0

	;Infinite invis
.trf_v2invis:
	dc.w 0

	dc.l $3456
	dc.w $4a6d,$3b7c

	dc.l $3458
	dc.w $00a2,$ffff

	dc.l $345a
	dc.w $671e,$00a2

	dc.l $345c
	dc.w $536d,$601c

	dc.l 0

	;Infinite thermo
.trf_v2thermo:
	dc.w 0

	dc.l $3426
	dc.w $4a6d,$3b7c

	dc.l $3428
	dc.w $00a0,$0800

	dc.l $342a
	dc.w $6720,$00a0

	dc.l $342c
	dc.w $536d,$601e

	dc.l 0

	;Infinite bouncies
.trf_v2bouncy:
	dc.w 0

	dc.l $960
	dc.w $426d,$42ad

	dc.l $964
	dc.w $426d,$4e71

	dc.l $966
	dc.w $00b8,$3b7c

	dc.l $968
	dc.w $426d,$0020	;$20 is number of bounces

	dc.l 0

	;Gun boost gives maximum
.trf_v2maxboost:
	dc.w 0

	dc.l $328e
	dc.w $0c2d,$1b7c

	dc.l $3294
	dc.w $661e,$4e71

	dc.l 0

;------------------------------------------------------------------------------

poke_err:	;Something is wrong with one of the pokes!
	move.l #.pw_msg,d2
	move.l #.pw_msge-.pw_msg,d3
	bsr LA_Message

	move.l SegList,d1	;Unload the exe
	DOSCALL UnLoadSeg
	moveq #20,d0
	rts

.pw_msg:	dc.b " - *** unknown 'Gloom' executable version! ***",13,10
	dc.b "   Please report this error to the author:",13,10
	dc.b "   (John Girvin) girv@girvnet.demon.co.uk",13,10,13,10
	dc.b 0
.pw_msge:
	EVEN

;------------------------------------------------------------------------------

loadseg_err:	move.l #.ls_msg,d2
	move.l #.ls_msge-.ls_msg,d3
	bsr.s LA_Message

	moveq #20,d0
	rts

.ls_msg:	dc.b " - could not load 'Gloom' executable!",13,10,13,10,0
.ls_msge:
	EVEN

;------------------------------------------------------------------------------

LA_Message:	;Print "loading aborted" message and reason
;Entry:	d2=reason message, d3=reason length

	movem.l 	d2/d3,-(a7)		;Save reason message regs

	move.l 	#.la_name,d1		;Setup output to current cli
	move.l 	#MODE_OLDFILE,d2
	DOSCALL 	Open
	tst.l 	d0		;exit if error (we're _really_ in trouble!)
	beq.s 	.la_out
	move.l 	d0,.la_handle

	move.l	#.la_msg_s,d2	;Print "Loading aborted" text
	move.l	#.la_msg_e-.la_msg_s,d3
	move.l 	d0,d1
	DOSCALL 	Write

	move.l 	.la_handle(pc),d1	;Output reason text
	movem.l 	(a7),d2/d3
	DOSCALL 	Write

	move.l 	.la_handle(pc),d1	;close output to cli
	DOSCALL 	Close

.la_out:	addq.l 	#8,a7
	rts

.la_handle:	dc.l 0
.la_name:	dc.b "CON:50/50/500/80/GloomTrainer FATAL ERROR!/CLOSE/WAIT",0

.la_msg_s:	dc.b 13,10,"Gloom loading aborted because:",13,10,0
.la_msg_e:
	EVEN

;-----------------------------------------------------

SegList:	dc.l 0
ExeAddr:	dc.l 0

	dc.b "$VER: Gloom Trainer loader v1.01 ("
	INCLUDE ENV:BuildTimeS.s
	dc.b ") © 1997 John Girvin",13,10,0

FileName:	dc.b "Gloom",0
	EVEN

;-----------------------------------------------------
