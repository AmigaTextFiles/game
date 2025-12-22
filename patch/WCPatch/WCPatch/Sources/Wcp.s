*
* Wing Commander Patch
* ©1997-1998, CdBS Software
* $Id: Wcp.s 2.4 1998/02/13 00:12:25 MORB Exp MORB $
*

;fs "Includes"
	 machine   68020
	 incdir    "Include:"
	 include   "exec/exec_lib.i"
	 include   "exec/memory.i"
	 include   "exec/execbase.i"
	 include   "dos/dos_lib.i"
	 include   "dos/dos.i"
	 include   "dos/dostags.i"
	 include   "intuition/intuition_lib.i"
	 include   "intuition/screens.i"
	 include   "graphics/graphics_lib.i"
	 include   "hardware/custom.i"
	 include   "hardware/blit.i"
	 include   "hardware/dmabits.i"
;fe
;fs "Macros"
AbsExecBase        = 4
CustomBase         = $dff000

TRUE     = -1
FALSE    = 0

CALL     macro
	 jsr       _LVO\1(a6)
	 endm

CALLJMP  macro
	 jmp       _LVO\1(a6)
	 endm
;fe
;fs "Main code"
start:
	 bra.s     .AfterVer
	 Dc.b      "$VER: Wing Commander Patch 2.1 (13.2.98) ©1997-1998, CdBS Software"
	 even
.AfterVer:
	 move.l    (AbsExecBase).w,a6
	 lea       dos_name,a1
	 moveq     #39,d0
	 CALL      OpenLibrary
	 move.l    d0,dos_base
	 beq       no_dos

	 move.l    d0,a6
	 lea       ArgsTemplate(pc),a0
	 move.l    a0,d1
	 move.l    #ArgsArray,d2
	 clr.l     d3
	 call      ReadArgs
	 move.l    d0,Rda
	 beq       dos_Error

	 tst.l     germarg(pc)
	 beq.s     .NoGerm
	 lea       GerFilename(pc),a0
	 move.l    a0,filename
.NoGerm:

	 move.l    stackarg,d0
	 beq.s     NoStack
	 move.l    d0,a1
	 move.l    (a1),stack          ; Hihihi
NoStack:

	 lea       cl,a1
	 move.l    campaignarg,d0
	 beq.s     NoCampaign
	 move.l    d0,a1
	 move.l    (a1),d0             ; Hihihi
NoCampaign:

	 andi.l    #7,d0
	 add.l     #48,d0
	 eori.w    #"h"<<8,d0
	 move.w    d0,(a1)+

	 tst.l     NoExit
	 beq.s     NoExitDone
	 move.w    #" x",(a1)+

NoExitDone:
	 tst.l     Invuln
	 bne.s     ForceTrainer
	 tst.l     Trainer
	 beq.s     NoTrainer

ForceTrainer:
	 move.l    #" Ori",(a1)+
	 move.l    #"gin&",(a1)+
	 move.l    #"toni",(a1)+
	 move.b    #"c",(a1)+
NoTrainer:

	 tst.l     Invuln
	 beq.s     NoInvuln
	 move.w    #" -",(a1)+
	 move.b    #"k",(a1)+
NoInvuln:

	 move.l    SlowDownArg,d0
	 beq.s     NoSlowDown
	 move.l    d0,a1
	 move.l    (a1),SlowDown
NoSlowDown:

	 tst.l     WingOpts
	 beq       NoWingOpts
	 tst.l     AddArg
	 bne       AddWingOpts
	 move.l    d0,args

AddWingOpts:
	 move.l    d0,a2
	 move.b    #" ",(a1)+
.Loop:
	 move.b    (a2)+,(a1)+
	 bne.s     .Loop

NoWingOpts:
	 move.w    #$A00,(a1)

	 move.l    filename,d1
	 clr.l     d2
	 CALL      LoadSeg
	 move.l    d0,seglist
	 beq       dos_Error

	 move.l    (AbsExecBase).w,a6
	 move.l    seglist,a5
	 add.l     a5,a5
	 add.l     a5,a5

***** Ugly hack to support imploded exe file *****
	 cmp.l     #$d482d482,$44(a5)
	 bne.s     .NotPacked

	 move.w    #$4ef9,$62(a5)
	 move.l    #_PackedPatch,$64(a5)
	 bra.s     .Packed
*****

.NotPacked:
	 jsr       _Patch

.Packed:
	 CALL      CacheClearU
	 clr.l     start-4

	 move.l    seglist,d1
	 move.l    dos_base,a6
	 move.l    #tags,d1
	 CALL      CreateNewProc

no_seg:
	 move.l    a6,a1
	 move.l    (AbsExecBase).w,a6
	 CALL      CloseLibrary
no_dos:
	 moveq     #0,d0
	 rts

dos_Error:
	 CALL      IoErr
	 move.l    d0,d1
	 move.l    #ErrHeader,d2
	 CALL      PrintFault
	 move.l    seglist,d1
	 CALL      UnLoadSeg
	 bra.s     no_seg
;fe
;fs "Main data"
;fs "CreateNewProc Taglist"
tags:
	 dc.l      NP_Cli,-1
	 dc.l      NP_StackSize
stack:
	 dc.l      32768
	 dc.l      NP_Seglist
seglist:
	 ds.l      1
	 dc.l      NP_Arguments
args:
	 dc.l      cl
	 dc.l      NP_ExitCode
	 dc.l      _FreeSeg
	 dc.l      0,0
;fe
;fs "Args array"
ArgsArray:

germarg:
	 ds.l      1
filename:
	 dc.l      EngFilename
stackarg:
	 ds.l      1
campaignarg:
	 ds.l      1
NoExit:
	 ds.l      1
Trainer:
	 ds.l      1
Invuln:
	 ds.l      1
NoJoy:
	 ds.l      1
SlowDownArg:
	 ds.l      1
NoC2P:
	 ds.l      1
NoWOTG:
	 ds.l      1
AddArg:
	 ds.l      1
WingOpts:
	 ds.l      1
;fe
;fs "Misc"
Rda:
	 ds.l      1
EngFilename:
	 dc.b      "wing.english",0
GerFilename:
	 dc.b      "wing.german",0
dos_name:
	 dc.b      "dos.library",0
ArgsTemplate:
	 dc.b      "G=German/S,Exe=WingName/K,S=Stack/N,C=Campaign/N,NE=NoExit/S,T=Trainer/S,I=Invincibility/S,Pad=NoJoy/S,SD=SlowDown/N,NoC2p/S,NoWOTG/S,Add/S,WO=WingOpts/F",0
ErrHeader:
	 dc.b      "Wing Commander Patch",0
	 even
;fe
;fe

;fs "Patch code"
	 section   coin,CODE
H2Begin:
;fs "_PackedPatch"
_PackedPatch:
	 move.l    15*4(a7),a5
	 subq.l    #4,a5
	 bsr.s     _Patch

	 move.l    (AbsExecBase).w,a6
	 CALL      CacheClearU

	 movem.l   (a7)+,d0-7/a0-6
	 rts
;fe
;fs "_Patch"
_Patch:
	 lea       _GfxBaseOfst(pc),a0

***** Hack: German/English version check *****
	 cmp.w     #$1124,$28+4(a5)
	 beq.s     _GermanPatch
;fe
;fs "_EnglishPatch"
_EnglishPatch:     ; Patchs for the english version
	 move.w    #-$30a,(a0)

	 move.l    (a5),a4
	 add.l     a4,a4
	 add.l     a4,a4
	 tst.l     NoJoy
	 bne.s     .NoJoy
	 move.b    #3,$7e3b+4(a4)      ; Patch joystick
.NoJoy:

	 lea       $28ca(a4),a2
	 addq.l    #4,a5

	 lea       $30000(a5),a4
	 move.l    $4aa6(a4),_NearPtr

	 move.b    #$2c,$3862(a4)       ;
	 move.b    #$6e,$3867(a4)       ; Fix several dumb bugs that
	 move.l    #$203c0000,$386c(a4) ; prevented wc to work on
	 move.l    #$01004e71,$3870(a4) ; machines with fast ram
	 move.b    #$bc,$3bcb(a4)       ;

	 tst.l     NoC2P
	 bne.s     .OldC2P
	 move.b    #$60,$1fca(a4)                ;
	 move.w    #$4ef9,$2028(a4)              ;
	 move.l    #_ChunkyToPlanar,$202a(a4)    ; Replacement of the
	 lea       $1ff8(a4),a3                  ; ugly slooow c2p
	 add.w     (a3),a3                       ; routine
	 move.l    a3,_BufSwitch                 ;
	 move.l    #$4e714e71,$1ff6(a4)          ;
	 bra.s     .C2POk

.OldC2P:
	 move.w    #$ffff,$17cc(a4)
	 move.b    #$14,$1ef7(a4)      ; Force the chunky buffer in chip
				       ; ram in order to make the original
				       ; c2p work (no more fast to chip
				       ; blits :)))
.C2POk:
	 lea       $1f000(a5),a4
	 move.w    #19,d0
	 tst.l     NoWOTG
	 bne.s     .NoWOTG

**** Some funny credits patchs ****

	 move.w    #58,d0
	 move.w    d0,$e40(a4)
	 move.w    #$4eb9,$dfa(a4)
	 move.l    #Cred,$dfc(a4)
	 move.w    #$4e71,$e00(a4)

	 lea       NewCredz,a1
	 move.l    (a2)+,(a1)+
	 addq.l    #4,a2
	 move.l    #MyCred0,(a1)+
	 Move.l    #MyCred00,(a1)+
	 Move.l    #MyCred000,(a1)+
	 moveq     #$f,d0

.CLoop:
	 move.l    (a2)+,(a1)+
	 dbf       d0,.CLoop
	 move.l    #MyCred1,(a1)+
	 move.l    #MyCred2,(a1)+
	 move.l    #MyCred3,(a1)+
	 move.l    #MyCred4,(a1)+
	 move.l    #MyCred5,(a1)+
	 move.l    #MyCred6,(a1)+
	 move.l    #MyCred7,(a1)+
	 move.l    #MyCred8,(a1)+
	 move.l    #MyCred9,(a1)+
	 move.l    #MyCreda,(a1)+
	 move.l    #MyCredb,(a1)+
	 move.l    #MyCredc,(a1)+
	 move.l    #MyCredd,(a1)+
	 move.l    #MyCrede,(a1)+
	 move.l    #MyCredf,(a1)+
	 move.l    #MyCred10,(a1)+
	 move.l    #MyCred11,(a1)+
	 move.l    #MyCred12,(a1)+
	 move.l    #MyCred13,(a1)+
	 move.l    #MyCred14,(a1)+
	 move.l    #MyCred15,(a1)+
	 move.l    #MyCred16,(a1)+
	 move.l    #MyCred161,(a1)+
	 move.l    #MyCred17,(a1)+
	 move.l    #MyCred18,(a1)+
	 move.l    #MyCred19,(a1)+
	 move.l    #MyCred1a,(a1)+
	 move.l    #MyCred1b,(a1)+
	 move.l    #MyCred1c,(a1)+
	 move.l    #MyCred1d,(a1)+
	 move.l    #MyCred1e,(a1)+
	 move.l    #MyCred1f,(a1)+
	 move.l    #MyCred20,(a1)+
	 move.l    #MyCred21,(a1)+
	 move.l    #MyCred22,(a1)+
	 move.l    #MyCred23,(a1)+
	 move.l    #MyCred24,(a1)+
	 move.l    #MyCred25,(a1)+
.NoWOTG:

	 rts
;fe
;fs "_GermanPatch"
_GermanPatch:      ; Patchs for the german version
	 move.w    #-$2de,(a0)

	 move.l    (a5),a4
	 add.l     a4,a4
	 add.l     a4,a4
	 tst.l     NoJoy
	 bne.s     .NoJoy
	 move.b    #3,$7e67+4(a4)      ; Patch joystick
.NoJoy:

	 lea       $28e2(a4),a2
	 addq.l    #4,a5

	 lea       $30000(a5),a4
	 move.l    $4c68(a4),_NearPtr

	 move.b    #$2c,$3a24(a4)       ;
	 move.b    #$6e,$3a29(a4)       ; Fix several dumb bugs that
	 move.l    #$203c0000,$3a2e(a4) ; prevented wc to work on
	 move.l    #$01004e71,$3a32(a4) ; machines with fast ram
	 move.b    #$bc,$33d8(a4)       ;

	 tst.l     NoC2P
	 bne.s     .OldC2P
	 move.b    #$60,$218c(a4)                ;
	 move.w    #$4ef9,$21ea(a4)              ;
	 move.l    #_ChunkyToPlanar,$21ec(a4)    ; Replacement of the
	 lea       $21ba(a4),a3                  ; ugly slooow c2p
	 add.w     (a3),a3                       ; routine
	 move.l    a3,_BufSwitch                 ;
	 move.l    #$4e714e71,$21b8(a4)          ;
	 bra.s     .C2POk

.OldC2P:
	 move.w    #$ffff,$198e(a4)
	 move.b    #$14,$20b9(a4)      ; Force the chunky buffer in chip
				       ; ram in order to make the original
				       ; c2p work (no more fast to chip
				       ; blits :)))
.C2POk:
	 lea       $1f000(a5),a4
	 move.w    #19,d0
	 tst.l     NoWOTG
	 bne.s     .NoWOTG

**** Some funny credits patchs ****

	 move.w    #58,d0
	 move.w    d0,$f44(a4)
	 move.w    #$4eb9,$efe(a4)
	 move.l    #Cred,$f00(a4)
	 move.w    #$4e71,$f04(a4)

	 lea       NewCredz,a1
	 move.l    (a2)+,(a1)+
	 addq.l    #4,a2
	 move.l    #MyCred0,(a1)+
	 move.l    #MyCred00,(a1)+
	 Move.l    #MyCred000,(a1)+
	 moveq     #$f,d0

.CLoop:
	 move.l    (a2)+,(a1)+
	 dbf       d0,.CLoop
	 move.l    #MyCred1,(a1)+
	 move.l    #MyCred2,(a1)+
	 move.l    #MyCred3,(a1)+
	 move.l    #MyCred4,(a1)+
	 move.l    #MyCred5,(a1)+
	 move.l    #MyCred6,(a1)+
	 move.l    #MyCred7,(a1)+
	 move.l    #MyCred8,(a1)+
	 move.l    #MyCred9,(a1)+
	 move.l    #MyCreda,(a1)+
	 move.l    #MyCredb,(a1)+
	 move.l    #MyCredc,(a1)+
	 move.l    #MyCredd,(a1)+
	 move.l    #MyCrede,(a1)+
	 move.l    #MyCredf,(a1)+
	 move.l    #MyCred10,(a1)+
	 move.l    #MyCred11,(a1)+
	 move.l    #MyCred12,(a1)+
	 move.l    #MyCred13,(a1)+
	 move.l    #MyCred14,(a1)+
	 move.l    #MyCred15,(a1)+
	 move.l    #MyCred16,(a1)+
	 move.l    #MyCred161,(a1)+
	 move.l    #MyCred17,(a1)+
	 move.l    #MyCred18,(a1)+
	 move.l    #MyCred19,(a1)+
	 move.l    #MyCred1a,(a1)+
	 move.l    #MyCred1b,(a1)+
	 move.l    #MyCred1c,(a1)+
	 move.l    #MyCred1d,(a1)+
	 move.l    #MyCred1e,(a1)+
	 move.l    #MyCred1f,(a1)+
	 move.l    #MyCred20,(a1)+
	 move.l    #MyCred21,(a1)+
	 move.l    #MyCred22,(a1)+
	 move.l    #MyCred23,(a1)+
	 move.l    #MyCred24,(a1)+
	 move.l    #MyCred25,(a1)+
.NoWOTG:

	 rts
;fe

*
* ChunkyToPlanar conversion routine - 256 color version
* ©1997, CdBS Software (MORB)
*
;fs "_ChunkyToPlanar"
ChunkySize         = 320*200
_WorkOutputBuffer:
	 dc.l      _OutputBuffer1
_BlitOutputBuffer:
	 dc.l      _OutputBuffer2

_ChunkyToPlanar:
	 movem.l   d0-7/a0-6,-(a7)

	 ext.l     d2

	 move.l    a4,-(a7)
	 move.l    a1,-(a7)

	 move.l    _WorkOutputBuffer,a1
	 lea       $f0f0f0f0,a4
	 lea       $cccc3333,a5
	 lea       $ff00ff00,a6

	 move.w    d0,d6
	 lsr.w     #4,d6
	 mulu      d3,d6
	 movem.l   d2/d6,-(a7)
	 subq.w    #1,d6

.Loop:
	 move.l    a4,d7
	 move.l    (a0),d0
	 move.l    d0,d1
	 and.l     d7,d0
	 eor.l     d0,d1
	 move.l    4(a0),d2
	 move.l    d2,d3
	 and.l     d7,d2
	 eor.l     d2,d3
	 lsr.l     #4,d2
	 or.l      d2,d0
	 lsl.l     #4,d1
	 or.l      d1,d3

	 move.l    8(a0),d1
	 move.l    d1,d2
	 and.l     d7,d1
	 eor.l     d1,d2
	 move.l    12(a0),d4
	 move.l    d4,d5
	 and.l     d7,d4
	 eor.l     d4,d5
	 lsr.l     #4,d4
	 or.l      d4,d1
	 lsl.l     #4,d2
	 or.l      d2,d5

	 move.l    a5,d7

	 move.l    d0,d2
	 and.l     d7,d0
	 eor.l     d0,d2
	 lsr.w     #2,d2
	 swap      d2
	 lsl.w     #2,d2
	 or.l      d2,d0

	 move.l    d3,d2
	 and.l     d7,d3
	 eor.l     d3,d2
	 lsr.w     #2,d2
	 swap      d2
	 lsl.w     #2,d2
	 or.l      d2,d3

	 move.l    d1,d2
	 and.l     d7,d1
	 eor.l     d1,d2
	 lsr.w     #2,d2
	 swap      d2
	 lsl.w     #2,d2
	 or.l      d2,d1

	 move.l    d5,d2
	 and.l     d7,d5
	 eor.l     d5,d2
	 lsr.w     #2,d2
	 swap      d2
	 lsl.w     #2,d2
	 or.l      d2,d5

	 move.l    a6,d7

	 move.l    d0,d2
	 and.l     d7,d0
	 eor.l     d0,d2
	 move.l    d1,d4
	 and.l     d7,d1
	 eor.l     d1,d4
	 lsr.l     #8,d1
	 or.l      d1,d0
	 move.l    d0,(a1)+
	 lsl.l     #8,d2
	 or.l      d2,d4
	 move.l    d4,(a1)+

	 move.l    d3,d2
	 and.l     d7,d3
	 eor.l     d3,d2
	 move.l    d5,d4
	 and.l     d7,d5
	 eor.l     d5,d4
	 lsr.l     #8,d5
	 or.l      d5,d3
	 move.l    d3,(a1)+
	 lsl.l     #8,d2
	 or.l      d2,d4
	 move.l    d4,(a1)+

	 lea       16(a0),a0
	 dbf       d6,.Loop

	 ;move.w    #$c040,$dff09a
	 ;move.w    #$8300,$dff096
.Wait:
	 tst.b     _Busy(pc)
	 bne.s     .Wait

	 st        _Busy

	 move.l    _WorkOutputBuffer,a2
	 move.l    _BlitOutputBuffer,_WorkOutputBuffer
	 move.l    a2,_BlitOutputBuffer
	 lea       DestPtr(pc),a3
	 lea       SrcInc(pc),a6
	 lea       DestOfst(pc),a1
	 movem.l   (a7)+,d2/d5

	 move.l    a3,a5
	 moveq     #6,d3
.Glou:
	 move.l    d2,d7
	 muls      (a1)+,d7
	 move.l    d7,(a5)+
	 dbf       d3,.Glou
	 move.l    d2,d7
	 muls      (a1)+,d7
	 addq.l    #2,d7
	 move.l    d7,(a5)+

	 move.l    (a7)+,a5
	 move.l    a5,d6
	 moveq     #5,d7
	 moveq     #0,d2
	 moveq     #0,d3
	 move.l    #$0de41000,d4
	 lea       BlitRegs,a1

	 movem.l   d0-6/a2-6,(a1)

	 move.l    (a7)+,a4
	 move.w    _GfxBaseOfst(pc),d0
	 move.l    (a4,d0.w),a6

	 move.l    SlowDown(pc),d2
	 beq.s     .NoSlowDown

	 subq.w    #1,d2
.SDLoop:
	 CALL      WaitTOF
	 dbf       d2,.SDLoop

.NoSlowDown:

	 lea       BltNode1(pc),a1
	 CALL      QBlit
	 lea       BltNode2(pc),a1
	 CALL      QBlit
	 lea       BltNode3(pc),a1
	 CALL      QBlit
	 lea       BltNode4(pc),a1
	 CALL      QBlit
	 lea       BltNode5(pc),a1
	 CALL      QBlit
	 lea       BltNode6(pc),a1
	 CALL      QBlit
	 lea       BltNode7(pc),a1
	 CALL      QBlit
	 lea       BltNode8(pc),a1
	 CALL      QBlit

	 movem.l   (a7)+,d0-7/a0-6
	 rts
_CleanUp:
	 sf        _Busy

	 movem.l   d0-7/a0-6,-(a7)
	 move.l    _NearPtr(pc),a4
	 move.l    _BufSwitch(pc),a0
	 jsr       (a0)
	 movem.l   (a7)+,d0-7/a0-6

	 rts
SrcInc:
	 dc.l      0,2,0,6,0,2,0,6
DestPtr:
	 ds.l      8
DestOfst:
	 dc.w      7,-3,1,-3,1,-3,1,5

_Busy:
	 ds.w      1

_BufSwitch:
	 ds.l      1
_NearPtr:
	 ds.l      1
_GfxBaseOfst:
	 ds.l      1

_C2pBlit:
	 movem.l   d1-7/a0-6,-(a7)
	 lea       BlitRegs,a1
	 movem.l   (a1),d0-6/a2-6
	 lea       $dff040,a0

	 add.l     (a6)+,a2
	 move.l    d4,(a0)+
	 moveq     #-1,d1
	 move.l    d1,(a0)+
	 addq.l    #4,a0
	 lea       4(a2,d2.w),a4
	 move.l    a4,(a0)+
	 ;lea       (a2),a4
	 move.l    a2,(a0)+
	 add.l     (a3)+,a5
	 lea       (a5,d3.w),a4
	 move.l    a4,(a0)+
	 lea       10(a0),a4
	 addq.l    #4,a0
	 move.w    #14,(a4)+
	 move.w    #14,(a4)+
	 move.w    #0,(a4)+
	 addq.l    #8,a4
	 move.w    #$aaaa,(a4)
	 addq.l    #6,a4
	 move.w    d5,(a0)+
	 move.w    #1,(a0)

	 eor.w     #-16,d2
	 eor.l     #-2,d3
	 eor.l     #$f0001000,d4
	 eor.b     #1,d5

	 movem.l   d0-6/a2-6,(a1)

	 moveq     #0,d0
	 movem.l   (a7)+,d1-7/a0-6
	 rts

BltNode1:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode2:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode3:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode4:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode5:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode6:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode7:
	 dc.l      0,_C2pBlit
	 dc.b      0,0
	 dc.w      0,0
	 dc.l      0
BltNode8:
	 dc.l      0,_C2pBlit
	 dc.b      CLEANME,0
	 dc.w      0,0
	 dc.l      _CleanUp
;fe
;fs "Cred"
Cred:
	 lea       NewCredz,a0
	 move.l    (a7),-(a7)
	 move.l    (a0,d0.l),4(a7)
	 rts
MyCred0:
	 dc.b      "Destroyed",$a
	 dc.b      "by",$a
	 dc.b      "Nick Pelling",0
MyCred00:
	 dc.b      "Enhanced",$a
	 dc.b      "by",$a
	 Dc.b      "CdBS Software",0
MyCred000 Dc.b      "Thanks to",$a
	Dc.b      "Jan Vieten",$a
	Dc.b      "for Beta-Testing",0
MyCred1:
	 Dc.b      "Hello guy",$a
	 Dc.b      "that s",$a
	 Dc.b      "good credits, no",0
MyCred2:
	 Dc.b      "You must be happy",$a
	 Dc.b      "with your brand new",$a
	 Dc.b      "Wing Commander",0
MyCred3:
	 Dc.b      "With our mega",$a
	 Dc.b      "super top fast",$a
	 Dc.b      "ChunkyToPlanar.",0
MyCred4:
	 Dc.b      "Well, the first",$a
	 Dc.b      "was a wreck",0
MyCred5   Dc.b      "You known, it",$a
	  Dc.b      "was like every",$a
	  Dc.b      "Nick Pelling s stuff",0
MyCred6   Dc.b      "he ho...",0
MyCred7   Dc.b      "Are you there",0
MyCred8   Dc.b      "Help",$a
	  Dc.b      "Someone Call",$a
	  Dc.b      "police",0
MyCred9   Dc.b      "the user is dead",0
MyCreda   Dc.b      "OK, you want to",$a
	  Dc.b      "read all the credits",0
MyCredb   Dc.b      "Well... If you want...",0
MyCredc   Dc.b      "But you don't know",$a
	  Dc.b      "how long credits",$a
	  Dc.b      "could be",0
MyCredd   Dc.b      "This one is not long",0
MyCrede   Dc.b      "END OF CREDITS",0
MyCredf   Dc.b      "",0
MyCred10  Dc.b      "uh oh...",$a
	  Dc.b      "You re not so fool",0
MyCred11  Dc.b      "OK, that s good",0
MyCred12  Dc.b      "But there s",$a
	  Dc.b      "another problem",0
MyCred13  Dc.b      "I don t known",$a
	  Dc.b      "what to say now.",0
MyCred14  Dc.b      "you known, what",$a
	  Dc.b      "did Nick Pelling",$a
	  Dc.b      "was really bad",0
MyCred15  Dc.b      "The badest error",$a
	  Dc.b      "was that he forgot",$a
	  Dc.b      "a sharp in is source",0
MyCred16  Dc.b      "Really fool",0
MyCred161 dc.b      "I am sorry, but this",$a
	  dc.b      "font is so lame that",$a
	  dc.b      "it misses sharps,",$a
	  dc.b      "numbers, exclamation",$a
	  dc.b      "and interogation points",0
MyCred17  Dc.b      "what",0
MyCred18  Dc.b      "It s not interresting",0
MyCred19  Dc.b      "OK...",0
MyCred1a  Dc.b      "perhaps could I",$a
	  Dc.b      "find a story",0
MyCred1b  Dc.b      "Once upon a time...",0
MyCred1c  Dc.b      "All right,",$a
	  Dc.b      "you don t like it.",0
MyCred1d  Dc.b      "So I must find",$a
	  Dc.b      "something else.",0
MyCred1e  Dc.b      "Oh, I ve found:",$a
	  Dc.b      "You re waiting",$a
	  Dc.b      "for the end of",$a
	  Dc.b      "the music",0
MyCred1f  Dc.b      "OK, so in this case,",$a
	  Dc.b      "you don t want to",$a
	  Dc.b      "read these credits.",0
MyCred20  Dc.b      0,0
MyCred21  Dc.b      0,0
MyCred22  Dc.b      "The music should",$a
	  Dc.b      "have reached its",$a
	  Dc.b      "end now.",0
MyCred23  Dc.b      "So what are you",$a
	  Dc.b      "waiting for ?!",0
MyCred24  Dc.b      "hey, you really",$a
	  Dc.b      "want to read the credits",$a
	  Dc.b      "till the end",0
MyCred25  Dc.b      "OK, here we are...",0
;fe
;fs "Data"
dos_base:
	 ds.l      1
SlowDown:
	 ds.l      1
;fe
;fs "_FreeSeg"
_FreeSeg:
	 move.l    dos_base,a6
	 lea       H2Begin-4(pc),a0
	 move.l    a0,d1
	 lsr.l     #2,d1
	 CALLJMP   UnLoadSeg
;fe
;fe
;fs "Patch BSS"
	 section   glonk,BSS
BlitRegs:
	 ds.l      13
NewCredz:
	 ds.l      66
cl:
	 ds.b      256+2
cle:

	 section   paf,BSS_C
_OutputBuffer1:
	 ds.b      320*200
_OutputBuffer2:
	 ds.b      320*200
;fe
	 END
