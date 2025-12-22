
	OPT O+,W-
;	OUTPUT GAMES:GloomDeluxe/GDTBoot
	OUTPUT PROJ:GDTrainer/dist/GDTrainer/GDTBoot

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

NumVersions:	equ 2	;Number of exe versions supported
NumTrainers:	equ 6	;Number of trainers

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
.ntrloop:	move.l	(a1)+,a0
	clr.w	(a0)
	dbf 	d1,.ntrloop

;---
;	Load the "playgloom" executable

.paramdone:	move.l #PGFileName,d1		;Load the exe
	DOSCALL LoadSeg
	move.l d0,PGSegList
	beq loadpg_err

	lsl.l #2,d0			;Get pointer to first hunk's data
	addq.l #4,d0
	move.l d0,a0			;a0=start of code

	lea $fc(a0),a1		;Redirect game exe jump to us

	cmp.l #$e5882240,(a1)		;Right program?
	bne pgver_err		;Exit if not

	move.w #$4eb9,(a1)+		;JSR .one
	move.l #.one,(a1)+
	move.w #$4e71,(a1)

	jsr (a0)			;Start 'playgloom' program

	move.l PGSegList(pc),d1		;Unload playgloom
	DOSCALL UnLoadSeg

	moveq #0,d0			;Exit
	rts

;---
;	;Called after playgloom has loaded the correct exe...
	;d0=SegList of loaded exe

.one:	lsl.l #2,d0			;Get code start
	move.l d0,a1
	lea 4(a1),a1			;a1=code start

	move.l a0,-(a7)		;Patch game start jump
	lea $2c(a1),a0
	cmp.l #$7c004e94,(a0)
	bne.s .1_vererr

	move.w #$4ef9,(a0)+		;JMP .two
	move.l #.two,(a0)
	bra.s .1_startgame

.1_vererr:	;Unknown exe version...just dont apply any cheats
	move.w #$f00,$dff180

.1_startgame:
	move.l (a7)+,a0		;Start the game
	jmp (a1)

;---
;	;Called after game has decrunched itself

.two:	moveq #0,d6			;Do some stuff...
	jsr (a4)

	;a1=execution address
	movem.l d0-7/a0-6,-(a7)
	move.l a1,a2

	;Determine exe version we are dealing with
	cmp.w #$536d,$3566(a1)
	beq.s .getv2tab

	lea .trainer_v1(pc),a1		;"gloom" exe
	bra.s .got_trainertab

.getv2tab:	lea .trainer_v2(pc),a1		;"gloom2" exe

;---

.got_trainertab:
	;Apply trainers to loaded exe
	;a1=trainer table to train from

	moveq #NumTrainers-1,d7		;d7=no of trainers-1

.at_loop:	tst.w (a1)+			;Use this trainer?
	bne.s .at_active		;Skip if yes

	;Trainer inactive...just read over its data
.at_skiploop:
	tst.l (a1)+
	beq.s .at_next
	addq.l #4,a1
	bra.s .at_skiploop

.at_active:	;Trainer active...apply the pokes, with checks!

.at_pokeloop:
	move.l (a1)+,d0		;d0=base address offset
	beq.s .at_next		;Back to start if done

	lea 0(a2,d0.l),a0		;a0=poke address

	move.w (a0),d0		;d0=current contents
	cmp.w (a1)+,d0		;What we expect?
	beq.s .at_pokeok		;Skip if yes

	addq.l #2,a1
	move.w #$f00,$dff180
	bra.s .at_pokeloop

.at_pokeok:	move.w (a1)+,(a0)		;Do the poke
	bra.s .at_pokeloop

.at_next:	dbf d7,.at_loop

;---	
;	We should now have a suitably trained program - start it!

	movem.l (a7)+,d0-7/a0-6		;Start the game...
	jmp (a1)

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
	;    Pointer to base pointer
	;    Offset.l
	;    Correct value.w
	;    Trained value.w
	;  ...
	;  Poke n:
	;    Pointer to base pointer
	;    Offset.l
	;    Correct value.w
	;    Trained value.w
	;  0.l


.trainer_v1:	;Version 1 trainers "gloom" exe

	;Infinite lives
.trf_v1lives:
	dc.w 0

	dc.l $3100
	dc.w $536d,$4a6d

	dc.l $3118
	dc.w $536d,$4a6d

	dc.l 0

	;Infinite max-gun
.trf_v1biggun:
	dc.w 0

	dc.l $33a6
	dc.w $4a6d,$3b7c

	dc.l $33a8
	dc.w $003a,$7fff

	dc.l $33aa
	dc.w $671e,$003a

	dc.l $33ac
	dc.w $536d,$3b7c

	dc.l $33ae
	dc.w $003a,$0004

	dc.l $33b0
	dc.w $6618,$0054

	dc.l $33b2
	dc.w $6100,$6016

	dc.l 0

	;Infinite invis
.trf_v1invis:
	dc.w 0

	dc.l $33fa
	dc.w $4a6d,$3b7c

	dc.l $33fc
	dc.w $00a2,$ffff

	dc.l $33fe
	dc.w $671e,$00a2

	dc.l $3400
	dc.w $536d,$601c

	dc.l 0

	;Infinite thermo
.trf_v1thermo:
	dc.w 0

	dc.l $33ca
	dc.w $4a6d,$3b7c

	dc.l $33cc
	dc.w $00a0,$0800

	dc.l $33ce
	dc.w $6720,$00a0

	dc.l $33d0
	dc.w $536d,$601e

	dc.l 0

	;Infinite bouncies
.trf_v1bouncy:
	dc.w 0

	dc.l $8fa
	dc.w $426d,$42ad

	dc.l $8fe
	dc.w $426d,$4e71

	dc.l $900
	dc.w $00b8,$3b7c

	dc.l $902
	dc.w $426d,$0020	;$20 is number of bounces

	dc.l 0


	;Maximum gun boosts
.trf_v1maxboost:
	dc.w 0

	dc.l $3232
	dc.w $0c2d,$1b7c

	dc.l $3238
	dc.w $661e,$4e71

	dc.l 0


.trainer_v2:	;Version 2 trainers "gloom2" exe

	;Infinite lives
.trf_v2lives:
	dc.w 0

	dc.l $3566
	dc.w $536d,$4a6d

	dc.l $357e
	dc.w $536d,$4a6d

	dc.l 0

	;Infinite max-gun
.trf_v2biggun:
	dc.w 0

	dc.l $38dc
	dc.w $4a6d,$3b7c

	dc.l $38de
	dc.w $003a,$7fff

	dc.l $38e0
	dc.w $672c,$003a

	dc.l $38e2
	dc.w $536d,$3b7c

	dc.l $38e4
	dc.w $003a,$0004

	dc.l $38e6
	dc.w $6618,$0054

	dc.l $38e8
	dc.w $6100,$6016

	dc.l 0

	;Infinite invis
.trf_v2invis:
	dc.w 0

	dc.l $3934
	dc.w $4a6d,$3b7c

	dc.l $3936
	dc.w $00a2,$ffff

	dc.l $3938
	dc.w $671e,$00a2

	dc.l $393a
	dc.w $536d,$601c

	dc.l 0

	;Infinite thermo
.trf_v2thermo:
	dc.w 0

	dc.l $390e
	dc.w $4a6d,$3b7c

	dc.l $3910
	dc.w $00a0,$0800

	dc.l $3912
	dc.w $6720,$00a0

	dc.l $3914
	dc.w $536d,$601e

	dc.l 0

	;Infinite bouncies
.trf_v2bouncy:
	dc.w 0

	dc.l $d1e
	dc.w $426d,$42ad

	dc.l $d22
	dc.w $426d,$4e71

	dc.l $d24
	dc.w $00b8,$3b7c

	dc.l $d26
	dc.w $426d,$0020	;$20 is number of bounces

	dc.l 0

	;Maximum gun boosts
.trf_v2maxboost:
	dc.w 0

	dc.l $3792
	dc.w $0c2d,$1b7c

	dc.l $3798
	dc.w $661e,$4e71
	
	dc.l 0

;------------------------------------------------------------------------------

pgver_err:	move.l #.pv_msg,d2
	move.l #.pv_msge-.pv_msg,d3
	bsr LA_Message

	move.l PGSegList(pc),d1
	DOSCALL UnLoadSeg
	moveq #20,d0
	rts

.pv_msg:	dc.b " - unknown version of 'playgloom' program!",13,10,13,10,0
.pv_msge:
	EVEN

;------------------------------------------------------------------------------

loadpg_err:	move.l #.ls_msg,d2
	move.l #.ls_msge-.ls_msg,d3
	bsr.s LA_Message

	moveq #20,d0
	rts

.ls_msg:	dc.b " - could not load 'playgloom' program!",13,10,13,10,0
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
.la_name:	dc.b "CON:50/50/500/80/GloomDeluxeTrainer FATAL ERROR!/CLOSE/WAIT",0

.la_msg_s:	dc.b 13,10,"Gloom Deluxe loading aborted because:",13,10,0
.la_msg_e:
	EVEN

;-----------------------------------------------------

PGSegList:	dc.l 0
ExeAddr:	dc.l 0

	dc.b "$VER: Gloom Deluxe Trainer loader v2.01 ("
	INCLUDE ENV:BuildTimeS.s
	dc.b ") © 1997 John Girvin",13,10,0

PGFileName:	dc.b "playgloom",0
	EVEN

;-----------------------------------------------------
