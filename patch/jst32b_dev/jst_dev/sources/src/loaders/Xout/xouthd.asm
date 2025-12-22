; *** X-Out Hard Disk Loader BETA
; *** Written by Jean-François Fabre


   include  "jst.i"

   HD_PARAMS   "Xout.d",942944,2

PATCH_BLIT:MACRO
PatchBlitD\1:
   bsr   WaitBlit
   move.w   D\1,($58,A6)
   RTE
   ENDM

loader:
   Mac_printf  "X-Out HD Loader V1.0b"
   Mac_printf  "Coded by Jean-François Fabre © 1997"

   JSRABS   LoadDisks

   moveq.l  #0,D0
   move.l   #CACRF_CopyBack,D1
   JSRABS   Degrade

;  WAIT_LMB

   GO_SUPERVISOR
   SAVE_OSDATA $80000

   move.w   #$2700,SR

   MOVE  #$7FFF,D0
   MOVE  D0,dmacon(A6)
   MOVE  D0,intena(A6)
   MOVE  D0,intreq(A6)

   ; **** boot stuff and patch

   bsr   InstallBoot

   JSRGEN   FlushCachesHard   
   JMP   $1D000

InstallBoot:
   moveq #0,D0
   lea   $1CFFE,A0
   move.l   #$1750*2,D1
   moveq.l  #0,D2
   JSRGEN   ReadDiskPart
   
   ; *** first read routine

   PATCHUSRJMP $1D972,ReadRoutine

   ; *** remove gototrack 0, dskrdy code

   move.w   #$4E75,$1DA4C
   move.w   #$4E75,$1DA04
   move.w   #$4E75,$1DA22

   ; *** set disk change patches

   PATCHUSRJMP $1D678,SetDiskA
   PATCHUSRJMP $1D6DE,SetDiskB
   
   ; *** remove a clearmem+disable interrupts

   move.w   #$4E75,$1D4FE

   ; *** lay a patch for intro sequence

   PATCHUSRJMP $1D06C,PatchIntro

   ; *** lay a patch for weapon choose

   PATCHUSRJMP $1D5DE,PatchWeapons
   PATCHUSRJMP $1D60C,PatchWeapons

   ; *** lay a patch for game (disk 1 levels)

   PATCHUSRJMP $1D5B0,PatchGameD1

   ; *** lay a patch for game (disk 2 levels)

   PATCHUSRJMP $1D586,PatchGameD2

   ; *** lay a patch for hi-score sequence

   PATCHUSRJMP $1D4F8,PatchHiscores

   ; *** set trap handlers for blitter waits

   GETUSRADDR  PatchBlitD1
   move.l   D0,$B0.W
   GETUSRADDR  PatchBlitD3
   move.l   D0,$B4.W
   GETUSRADDR  PatchBlitD4
   move.l   D0,$B8.W
   GETUSRADDR  PatchBlitD6
   move.l   D0,$BC.W

   rts

SetDiskA:
   movem.l  D0/A0,-(sp)
   moveq #0,D0
   bra   SetDiskX 

SetDiskB:
   movem.l  D0/A0,-(sp)
   moveq #1,D0

SetDiskX:
   lea   currdisk(pc),A0
   move.l   D0,(A0)
   JSRGEN   SetDisk
   movem.l  (sp)+,D0/A0
   rts


PatchIntro:
   STORE_REGS

   ; *** install quit key

   PATCHUSRJSR $21700,KbInt
   move.w   #$4E71,$21706

   ; *** insert blitter waits

   move.l   #$4E4C4E71,$2110C

   lea   $21270,A0
   lea   $21600,A1
   bsr   InsertBlitWaits

   JSRGEN   GoECS
   JSRGEN   FlushCachesHard
   RESTORE_REGS
   JMP   $20048


PatchWeapons:
   STORE_REGS

   ; *** install quit key

   PATCHUSRJSR $220E2,KbInt
   move.w   #$4E71,$220E8

   ; *** insert blitter waits

   
   move.l   #$4E4C4E71,$21C2E

   lea   $21D00,A0
   lea   $22000,A1
   bsr   InsertBlitWaits

   JSRGEN   FlushCachesHard
   RESTORE_REGS
   JMP   $20000


; *** the code is different given the level!!

PatchGameD1:
   STORE_REGS

   ; *** install quit key

   lea   $28000,A0
   lea   $29000,A1
   bsr   InsertKbInt 

   ; *** insert blitter waits

   lea   $28000,A0
   lea   $29000,A1
   bsr   InsertBlitWaits

   lea   $28000,A0
   lea   $29000,A1
   bsr   InsertBlitWaitsGame

   JSRGEN   FlushCachesHard
   RESTORE_REGS
   JMP   $20006

; *** the code is different given the level!!

PatchGameD2:
   STORE_REGS

   ; *** install quit key

   lea   $26000,A0
   lea   $28000,A1
   bsr   InsertKbInt 

   ; *** insert blitter waits

   lea   $25000,A0
   lea   $28000,A1
   bsr   InsertBlitWaits

   lea   $25000,A0
   lea   $28000,A1
   bsr   InsertBlitWaitsGame

   JSRGEN   FlushCachesHard
   RESTORE_REGS
   JMP   $20000

PatchHiscores:
   STORE_REGS

   ; *** install quit key

   PATCHUSRJSR $20C5A,KbInt
   move.w   #$4E71,$20C60

   ; *** insert blitter waits

   move.l   #$4E4C4E71,$2079E

   lea   $20860,A0
   lea   $20B20,A1
   bsr   InsertBlitWaits

   JSRGEN   FlushCachesHard
   RESTORE_REGS
   JMP   $20000

   PATCH_BLIT  1
   PATCH_BLIT  3
   PATCH_BLIT  4
   PATCH_BLIT  6

WaitBlit:
wb$
   btst  #6,($2,A6)
   bne.b wb$
   rts

InsertKbInt:
   move.l   #$023900BF,D1

srch$
   cmp.l (A0),D1
   bne.b next$

   move.l   #$4E714EB9,(A0)+
   GETUSRADDR  KbIntGame
   move.l   D0,(A0)
   rts         ; patch only once

next$
   addq.l   #2,A0
   cmp.l A0,A1
   bne.b srch$
   rts

   
InsertBlitWaits:
   move.l   #$3D440058,D1
   move.l   #$3D460058,D2

srch$
   cmp.l (A0),D1
   bne   notblitd4$

   move.l   #$4E4E4E71,(A0)      ; trap $E
   bra   next$

notblitd4$
   cmp.l (A0),D2
   bne   next$

   move.l   #$4E4F4E71,(A0)      ; trap $F
next$
   addq.l   #2,A0
   cmp.l A0,A1
   bne   srch$
   rts

InsertBlitWaitsGame:
   move.l   #$3D410058,D1
   move.l   #$3D430058,D2

srch$
   cmp.l (A0),D1
   bne   notblitd1$

   move.l   #$4E4C4E71,(A0)      ; trap $C
   bra   next$

notblitd1$
   cmp.l (A0),D2
   bne   next$

   move.l   #$4E4D4E71,(A0)      ; trap $D
next$
   addq.l   #2,A0
   cmp.l A0,A1
   bne   srch$
   rts




KbIntGame:
   cmp.b #$5F,D0
   bne   KbInt    ; no level skip
   move.b   #1,$7F061
KbInt:
   and.b #$BF,$BFEE01
   cmp.b #$59,D0
   bne   noquit$
   JSRGEN   InGameExit
noquit$
   RTS

ReadRoutine:
   STORE_REGS
   move.l   currdisk(pc),D0

   move.l   16(A5),D2      ; offset

   move.l   12(A5),D1      ; length
   sub.l 8(A5),D1
   move.l   8(A5),A0

   JSRGEN   ReadDiskPart

   move.l   12(A5),8(A5)

   RESTORE_REGS
   rts

currdisk:
   dc.l  0
