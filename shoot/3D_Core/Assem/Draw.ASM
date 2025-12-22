   ;********************************************
   ;****** Generic Draw Related Functions ******
   ;****** Copyright (c) Jonathan Gregory ******
   ;******     Version 1.20  20/01/98     ******
   ;********************************************
   

   
   ;*** Fill memory block with specified long word ***

   ; Parameter 1 - a0.l - Pointer to block to fill (long word aligned)
   ;           2 - d0.l - Number of longwords to fill (UWORD values only)
   ;           3 - d1.l - Pattern to place in longwords
   
_ASM_FillMemLong:
   movem.l d0-d1/a0,-(sp)  ; Preserve used registers (12 bytes)
   move.l  16(sp),a0       ; Get arg 1 (+4 to skip return addr)
   move.l  20(sp),d0       ; Get arg 2 (Counter)
   move.l  24(sp),d1       ; Get arg 3 (Fill pattern)                
   sub.w  #1,d0            ; Decrement counter for use with dbra

FML_Loop:
   move.l  d1,(a0)+        ; Write long word
   dbra    d0,FML_Loop     ; Loop until counter = -1

   movem.l (sp)+,d0-d1/a0  ; Restore used registers
   rts



   ;*** Draw Chunky Sprite Un-scaled into chunky screen ***
   ;*** clipped but colour 0 not treated as transparant ***
   
   ; Parameter 1 - a0.l - Pointer to chunky sprite structure
   ;           2 - a1.l - Pointer to chunky screen line table
   ;           3 - d0.w - X Co-ord (left edge not centre)
   ;           4 - d1.w - Y Co-ord (top edge note centre)
   ;                      X & Y are passed by c as longwords on stack
   ;           5 - d7.l - col 0 status - 0=Transparant otherwise opaque

_ASM_DrawClipChunky:

   movem.l d0-d7/a0-a6,-(sp)   ; Preserve registers on stack (60 bytes)
   move.l  64(sp),a0           ; Get param 1 (+4 to skip return addr)
   move.l  68(sp),a1           ; Get param 2
   move.l  72(sp),d0           ; Get param 3
   move.l  76(sp),d1           ; Get param 4
   move.l  80(sp),d7           ; Get param 5   

   move.w  CIM_PxWidth(a0),d2  ; Get image width
   move.w  d2,a5               ; Make copy of image width
   tst.w   d0                  ; Test X Co-ord
   bge     ADCC_XPos           ; if X is >= 0 branch
   
   add.w   d0,d2               ; Add X (neg) to width (effective sub)
   move.w  #0,d3               ; Screen X = 0
   neg.w   d0                  ; Sprite X offset = X * -1
   bra     ADCC_RChk           ; Jump to right edge check
   
ADCC_XPos:
   move.w  d0,d3               ; Screen X = X
   move.w  #0,d0               ; Sprite X offset = 0
   
ADCC_RChk:
   move.w  d2,d4               ; Get temp copy of viewable width
   add.w   d3,d4               ; Add screen X offset
   cmp.w   #width,d4           ; compare VWidth + ScrX with Screen width
   bgt     ADCC_RClip          ; If greater then jump to right clip
   bra     ADCC_ChkWid         ; Jump to final width check
        
ADCC_RClip:
   move.w  #width,d2           ; Viewable width is max of screen width
   sub.w   d3,d2               ; minus screen X offset

ADCC_ChkWid:
   tst.w   d2                  ; If viewable width <= zero
   ble     ADCC_End            ; then exit


   move.w  CIM_PxHeight(a0),d4 ; Get image height
   tst.w   d1                  ; Test Y Co-ord
   bge     ADCC_YPos           ; if y >= 0 branch
   
   add.w   d1,d4               ; Add Y (neg) to height (effective sub)
   move.w  #0,d5               ; Screen Y = 0
   neg.w   d1                  ; Sprite Y offset = Y * -1
   bra     ADCC_BChk           ; Jump to bottom edge check

ADCC_YPos:
   move.w  d1,d5               ; Screen Y = Y
   move.w  #0,d1               ; Sprite X offset = 0
   
ADCC_BChk:
   move.w  d4,d6               ; Get temp copy of viewable height
   add.w   d5,d6               ; Add Screen Y offset
   cmp.w   #height,d6          ; compare VHeight + ScrY with Scr height  
   bgt     ADCC_BClip          ; If greater then jump to bottom clip
   bra     ADCC_ChkHgt         ; Jump to final height check
   
ADCC_BClip:
   move.w  #height,d4          ; Viewable height is max of screen height
   sub.w   d5,d4               ; minus screen Y offset

ADCC_ChkHgt:
   tst.w   d4                  ; If viewable height <= zero
   ble     ADCC_End            ; then exit
   
   move.l  CIM_LineTab(a0),a2  ; Get base sprite line table base pointer
   move.w  d1,d6               ; Get copy source sprite Y offset
   asl.w   #2,d6               ; Multiply by 4 to get offset into table
   move.l  (a2,d6.w),a2        ; Put Y line start into start pointer
   adda.w  d0,a2               ; Add X offset to sprite start pointer (a2)
   
   move.w  d5,d6               ; Get copy of screen Y offset
   asl.w   #2,d6               ; Multiply by 4 to get offset into table
   move.l  (a1,d6.w),a3        ; Put Y line start into start pointer
   adda.w  d3,a3               ; Add X offset to screen start pointer (a3)

   sub.w   d2,a5               ; a6 Source line modulo (width - vissible)
   move.l  #width,a6           ; Get target width
   sub.w   d2,a6               ; a5 Target line modulo (width - vissible)

   tst.l   d7                  ; Is sprite copy to use transparant col 0
   beq     ADCC_CopyTrans      ; if yes then jump to transparant copy

   ;*** Non transparant (FAST) copy routine ***

   clr.w   d6                  ; Blank excess bytes counter
   asr.w   #1,d2               ; Make d2 long word counter (divide by 4)
   roxr.w  #1,d6               ; and put remainder into d6 which is
   asr.w   #1,d2               ; the excess byte counter
   roxr.w  #1,d6
   rol.w   #2,d6               ; move bits to start of word

;*******************************************************
; Register contents :-

; d0 - X offset into sprite
; d1 - Y offset into sprite
; d2 - long words to copy in X direction
; d3 - Screen X offset
; d4 - Pixels to copy in Y direction
; d5 - Screen Y offset
; d6 - Any excess bytes to copy in X direction
; a0 - Pointer to chunky sprite header (not work struct)
; a1 - Pointer to chunky screen line table
; a2 - Pointer to starting position in source sprite
; a3 - Pointer to starting position in chunky screen
; a5 - Source line modulo
; a6 - Target line modulo
;******************************************************* 

   subq.w  #1,d4               ; Dec Y pixel count for use with dbra
   
ADCC_YLoop:
   jsr     ADCC_CopyLine       ; Call copy line routine
   adda.l  a5,a2               ; Move sprite pointer down 1 line
   adda.l  a6,a3               ; Move chunky screen pointer down 1 line
   dbra    d4,ADCC_YLoop       ; Loop until no more lines to copy
   bra     ADCC_End            ; Jump to exit

ADCC_CopyLine:
   move.w  d2,d7               ; Use temp copy of long word counter
   beq     ADCC_CopyBytes      ; If no long words to copy skip to bytes
   subq.w  #1,d7               ; Sub 1 form count to use with dbra
   
ADCC_CL_Loop:
   move.l  (a2)+,(a3)+         ; Move long word from sprite to screen
   dbra    d7,ADCC_CL_Loop     ; Loop until all long words copied

ADCC_CopyBytes:
   move.w  d6,d7               ; Get temp copy of byte counter
   beq     ADCC_Ret            ; if no excess bytes to copy return
   subq.w  #1,d7               ; Sub 1 to use as counter with dbra

ADCC_CLB_Loop:
   move.b  (a2)+,(a3)+         ; Move byte from source to target
   dbra    d7,ADCC_CLB_Loop    ; Loop until no more bytes to copy

ADCC_Ret:
   rts

   ;*** Copy sprite with transparant colour 0 (SLOW) ***

   ; Changes to above register contents
   ; d2 - Total bytes to copy in X direction
   ; d6 - Spare

ADCC_CopyTrans:
   subq.w  #1,d2               ; Dec X direction bytes to use with dbra
   subq.w  #1,d4               ; Dec Y direction counter to use with dbra

ADCC_YLoop1:
   jsr     ADCC_CopyLine1      ; Call copy line function
   adda.l  a5,a2               ; Move down 1 line in souce sprite
   adda.l  a6,a3           ; Move down screen 1 line
   dbra    d4,ADCC_YLoop1      ; Loop until no more lines to copy
   bra     ADCC_End            ; Jump to exit

ADCC_CopyLine1:
   move.w  d2,d7               ; Get copy of X distance byte count

ADCC_CL1_Loop:
   move.b  (a2)+,d6            ; Get byte from source
   beq     ADCC_PixSkip        ; If transparant (0) then skip
   move.b  d6,(a3)+            ; Otherwise write to screen
   dbra    d7,ADCC_CL1_Loop    ; Loop until no more bytes to copy
   rts

ADCC_PixSkip:
   addq.w  #1,a3               ; Increment target pointer
   dbra    d7,ADCC_CL1_Loop    ; Loop until no more bytes to copy
   rts

ADCC_End:
   movem.l (sp)+,d0-d7/a0-a6   ; Retrieve registers from stack
   rts


   
   
   ;*************************************************
   ;******    Draw a box into chunky screen    ******
   ;****** No clipping is done by this routine ******
   ;*************************************************
      
   ;Parameters - a0.l - Pointer to chunky screen line table
   ;             d0.l - X Co-ord      (WORD)
   ;             d1.l - Y Co-ord      (WORD)
   ;             d2.l - Width of box  (WORD)
   ;             d3.l - Height of box (WORD)
   ;             d4.l - box colour    (BYTE)
   ;All values are passed as long word regardless of actual type

_ASM_BoxChunky:
   movem.l d0-d7/a0-a6,-(sp)   ; Preserve all registers

   move.l  64(sp),a0           ; Get Chunky line table pointer
   move.l  68(sp),d0           ; Get X Co-ord
   bmi     ABC_End             ; Exit if X < 0

   move.l  72(sp),d1           ; Get Y Co-ord
   bmi     ABC_End             ; Exit if Y < 0
   
   move.l  76(sp),d2           ; Get Width of box
   ble     ABC_End             ; Exit if width <= 0

   move.l  80(sp),d3           ; Get Height of box
   ble     ABC_End             ; Exit if height <= 0

   move.l  84(sp),d4           ; Get Box Colour
      
   move.b  d4,d5               ; Build long word version of colour
   asl.w   #8,d5               ; Left shift by 8
   move.b  d4,d5               ; Fill second byte with colour
   move.w  d5,d4               ; Move back to low word of colour register
   swap    d4                  ; Swap low word for high
   move.w  d5,d4               ; Move back to new low word of colour reg
   
   move.w  d1,d5               ; Get temp copy of Y offset
   asl.w   #2,d5               ; Multiply by 4 to get line table offset
   move.l  (a0,d5.w),a1        ; Get pointer to start of screen line
   adda.w  d0,a1               ; Add X co-ord to screen pointer

   move.w  #width,d6           ; Get screen width
   sub.w   d2,d6               ; Screen modulo (width - vissible)
   
   clr.w   d5                  ; Clear excess byte counter
   asr.w   #1,d2               ; Divide by four X so is lonword count
   roxr.w  #1,d5               ; Making d5 remaining byte counter
   asr.w   #1,d2
   roxr.w  #1,d5
   rol.w   #2,d5               ; Move bits shifted in to start of word

   ; Register contents (extra)
   ; d4 - Now contains colour byte replicated to longword
   ; d2 - Now X Direction longword count (width1)
   ; d5 - X Direction excess byte count (width2)
   ; d6 - Screen line modulo
   ; a1 - Pointer to 1st pixel in chunky screen to fill
   
   subq.w  #1,d3               ; Dec Y to use with dbra

ABC_YLoop:
   jsr ABC_CopyLong            ; Jump to copy line long words func
   adda.w  d6,a1               ; Move screen pointer down 1 line
   dbra    d3,ABC_YLoop        ; Loop until no more lines to copy
   bra     ABC_End             ; Jump to exit
   
ABC_CopyLong:
   move.w  d2,d7               ; Make temp copy of long word counter
   beq     ABC_CopyByte        ; If no longs then skip to byte copy
   subq.w  #1,d7               ; Dec counter to use with dbra

ABC_CL_Loop:
   move.l  d4,(a1)+            ; Write long word
   dbra    d7,ABC_CL_Loop      ; Loop until all long words copied
   
ABC_CopyByte:
   move.w  d5,d7               ; Make temp copy of byte counter
   beq     ABC_Ret             ; If no byte to copy then return
   subq.w  #1,d7               ; Dec counter to use with dbra

ABC_CB_Loop:
   move.b  d4,(a1)+            ; Write byte
   dbra    d7,ABC_CB_Loop      ; Loop until no more bytes to copy

ABC_Ret:
   rts

ABC_End:
   movem.l (sp)+,d0-d7/a0-a6   ; Retrieve stacked registers
   rts


   ;*****************************************************
   ;**** Copy a Plannar Sprite into BitMap & Clip it ****
   ;*****************************************************
   
   ;Parameters - a0.l - Pointer to Plannar sprite
   ;           - a1.l - Pointer to bitmap struct of plannar screen
   ;           - d0.l - X Co-ord (WORD) (Is rounded down to nearest 8)
   ;           - d1.l - Y Co-ord (WORD)

_ASM_DrawClipPlan:
   movem.l d0-d7/a0-a6,-(sp)   ; Preserve all registers
   move.l  64(sp),a0           ; Get plannar sprite pointer
   move.l  68(sp),a1           ; Get screens bitmap pointer
   move.l  72(sp),d0           ; Get X co-ord
   move.l  76(sp),d1           ; Get Y co-ord
   
   asr.w   #3,d0               ; Make X byte count to nearest lower 8

   move.w  6(a0),d2            ; Get image width (bytes)
   tst.w   d0                  ; Test X co-ord
   bge     ADCP_XPos           ; if X >= 0 the branch
   
   add.w   d0,d2               ; Add X (Neg) to width (effective sub)
   move.w  #0,d3               ; Screen X = 0
   neg.w   d0                  ; Sprite X offset = X * -1
   bra     ADCP_RChk           ; Jump to right edge check
      
ADCP_XPos:
;   sub.w   d0,d2               ; Sub X from width
   move.w  d0,d3               ; Screen X = X
   move.w  #0,d0               ; Screen X offset = 0
   
ADCP_RChk:
   move.w  d2,d4               ; Get temp copy of width
   add.w   d3,d4               ; Add Screen X offset
   cmp.w   (a1),d4             ; compare width + screen x with screen width
   bgt     ADCP_RClip          ; if >= the jump to right clip
   bra     ADCP_WidChk         ; Otherwise jump to final width check
   
ADCP_RClip:
   move.w  (a1),d2             ; Viewable width is Screen width
   sub.w   d3,d2               ; Minus X offset
   
ADCP_WidChk:
   tst.w   d2                  ; Test calculated width
   ble     ADCP_End            ; If <= 0 then exit
   

   move.w  8(a0),d4            ; Get image height
   tst.w   d1                  ; Test Y Co-ord
   bge     ADCP_YPos           ; if >= 0 then branch
   
   add.w   d1,d4               ; Add Y (Neg) to height (effective sub)
   move.w  #0,d5               ; Screen Y = 0
   neg.w   d1                  ; Sprite Y offset = Y * -1
   bra     ADCP_BChk           ; Jump to bottom edge check
   
ADCP_YPos:
;   sub.w   d1,d4               ; Sub Y from height
   move.w  d1,d5               ; Screen Y = Y
   move.w  #0,d1               ; Sprite X offset = 0
   
ADCP_BChk:
   move.w  d4,d6               ; Get temp copy of height
   add.w   d5,d6               ; Add Y offset
   cmp.w   2(a1),d6            ; Compare width + Y with screen height
   bgt     ADCP_BClip          ; If > then jump to bottom clip
   bra     ADCP_HgtChk         ; Otherwise jump to final height check
   
ADCP_BClip:
   move.w  2(a1),d4            ; Max viewable width = screen width
   sub.w   d5,d4               ; Minus Y offset
    
ADCP_HgtChk:
   tst.w   d4                  ; Check calculated height
   ble     ADCP_End            ; If <= 0 then exit
   
   move.w  d1,d6               ; Get temp copy of sprite y offset
   muls.w  6(a0),d6            ; Multiply by sprite width
   move.l  d6,a2               ; Set sprite Y offset
   adda.w  d0,a2               ; Add X offset (a2 = Sprite offset into planes)
   
   move.w  d5,d6               ; Get copy of screen y offset
   muls.w  (a1),d6             ; Multiply by screen width
   move.l  d6,a3               ; Set screen Y offset
   adda.w  d3,a3               ; Add X offset (a3 = Screen offset into planes)

   move.w  6(a0),d6            ; Get source sprite width (bytes)
   sub.w   d2,d6               ; Calculate source line modulo
   move.w  (a1),d7             ; Get target screen width (bytes)
   sub.w   d2,d7               ; Calculate target line modulo

   clr.w   d3                  ; Clear excess byte counter
   asr.w   #1,d2               ; Shift out low order bit
   roxr.w  #1,d3               ; Shift it into excess byte counter
   asr.w   #1,d2               ; Shift ou next low order bit
   roxr.w  #1,d3               ; Shift it into excess byte counter
   rol.w   #2,d3               ; Shift bits to low order bits

   move.w  10(a0),d0           ; Get source plane count
   clr.w   d1                  ; Clear target plane count
   move.b  5(a1),d1            ; Get target plane count
   cmp.w   d0,d1               ; Compare target planes to soucre planes
   blt     ADCP_PClip          ; If less planes in target then clip count
   bra     ADCP_Copy
   
ADCP_PClip:
   move.w  d1,d0               ; Planes to copy = target count
   
   ;Registers

   ;d0.w - Number of bit planes to copy
   ;d1   - Contents obsolete
   ;d2.w - Number of long words to copy in X direction
   ;d3.w - Number of bytes to copy in X direction
   ;d4.w - Number of rows to copy
   ;d5   - Contents obsolete
   ;d6.w - Sprite line modulo in bytes
   ;d7.w - Screen line modulo in bytes
   ;a0.l - Pointer to source plannar image
   ;a1.l - Pointer to screen bitmap structure
   ;a2.l - Offset to add to source plane pointers
   ;a3.l - Offset to add to target plane pointers

ADCP_Copy:

   subq.w  #1,d0               ; Decrement plane count to use with dbra

ADCP_Plane:
   move.w  d0,d1               ; Get temp copy of plane number
   and.l   #$FFFF,d1           ; Clear high word
   mulu.l  16(a0),d1           ; Multiply by plane size to get offset
   lea     24(a0),a4           ; Get source planes base
   adda.l  d1,a4               ; Add offset to get to correct plane
   adda.l  a2,a4               ; Add offset within src to 1st byte to copy
   
   move.w  d0,d1               ; Get current plane number
   asl.w   #2,d1               ; Multiply by four
   move.l  8(a1,d1.w),a5       ; Get pointer to required target plane
   adda.l  a3,a5               ; Add offset within tgt to 1st byte to copy
   
   move.w  d4,d1               ; Get temp copy of number of rows
   subq.w  #1,d1               ; sub 1 to use with dbra

ADCP_YLoop:
   jsr     ADCP_CopyLong       ; Jump to long word copy routine
   adda.w  d6,a4               ; Move down 1 line in source
   adda.w  d7,a5               ; Move down 1 line in target
   dbra    d1,ADCP_YLoop       ; Loop until no more rows to copy
   dbra    d0,ADCP_Plane       ; Loop until no more planes to copy

ADCP_End:
   movem.l (sp)+,d0-d7/a0-a6   ; Retrieve registers from stack
   rts   

ADCP_CopyLong:
   move.w  d2,d5               ; Get copy of number of long words to copy
   beq     ADCP_CopyByte       ; If none jump to byte copy
   subq.w  #1,d5               ; sub 1 from long word count for dbra

ADCP_CL_Loop:
   move.l  (a4)+,(a5)+         ; Copy a long word
   dbra    d5,ADCP_CL_Loop     ; Loop until no more long words

ADCP_CopyByte:
   move.w  d3,d5               ; Get copy of number of bytes to copy
   beq     ADCP_Ret            ; If none return to Y loop
   subq.w  #1,d5               ; sub 1 to use with dbra

ADCP_CB_Loop:
   move.b  (a4)+,(a5)+         ; Copy a byte
   dbra    d5,ADCP_CB_Loop     ; Loop until no more bytes

ADCP_Ret:
   rts   
     

;********************************************
;**** Draw line with Optional Clipping ******
;********************************************

;Arguments - a0 - Ptr to Line Rect 
;            a1 - Ptr to Screen info
;            a2 - Ptr to Screen Rect
;            a1 - Ptr to Cliping Rect (a1 is re-used after clip done)
;            a6 - Colour

; Cliping is optional and is only carried out if pointer
; to cliping rectangle structure is supplied.

; In Chunky mode the screen info ptr is a pointer to the
; screens line table.

; NOTE - Plannar mode not yet implemented.


_ASM_DrawLine:
  movem.l d0-d7/a0-a6,-(sp)   ; Stack all registers (60 bytes)
  
  move.l  64(sp),a0           ; Get ptr to line rect from stack (+4)
  move.l  76(sp),a1           ; Get ptr to Cliping Rect
  cmpa.l  #0,a1               ; Clip Rect ptr NULL ?
  beq     ADL_Start           ; If NULL don't call cliping routine
  jsr     ACL_Start           ; Clip line co-ords
    
ADL_Start:
  move.l  68(sp),a1           ; Get ptr to Screen info
  move.l  72(sp),a2           ; Get ptr to Screen Rect 
  move.l  80(sp),a6           ; Get Colour
  
  move.l  RCT_X2(a0),d0       ; Get X2
  move.l  RCT_Y2(a0),d1       ; Get Y2
  move.l  RCT_X1(a0),d2       ; Get X1
  move.l  RCT_Y1(a0),d3       ; Get Y1
  
  moveq.l #1,d4               ; MVX = 1
  sub.l   d2,d0               ; DX  = X2 - X1
  bpl     ADL_Cont1           ; If + distance then skip negative flip
  moveq.l #-1,d4              ; MVX = -1
  neg.l   d0                  ; DX  = 0 - DX

ADL_Cont1:  

  moveq.l #1,d5               ; MVY = 1 
  sub.l   d3,d1               ; DY  = Y2 - Y1
  bpl     ADL_Cont2           ; If + distance then skip negative flip
  moveq.l #-1,d5              ; MVY = -1
  neg.l   d1                  ; DY  = 0 - DY

ADL_Cont2:
  move.l  #0,a4               ; Swapped = No (0)
  cmp.l   d0,d1               ; Compare DY with DX
  ble     ADL_Cont3           ; If DY <= DX then skip swap
  move.l  #1,a4               ; Swapped = Yes (1)
  exg     d0,d1               ; Exchange DX and DY
  
ADL_Cont3:

  move.l  d1,d6               ; E1  = DY
  asl.l   #1,d6               ; E1  = E1 * 2

  move.l  d6,d1               ; D   = E1
  sub.l   d0,d1               ; D   = D - DX
  
  move.l  d6,d7               ; E2  = E1
  asl.l   #1,d0               ; tmp = DX * 2
  sub.l   d0,d7               ; E2  = E2 - tmp


  asr.l   #1,d0               ; Count = DX
  cmpa.l  #1,a4               ; Is swapped flag set ?
  beq     ADL_Swapped         ; If yes jump to swapped loop

  ;**** X & Y Not Swapped ****  

ADL_Normal:
  asl.w   #2,d3               ; LineTab offset = Y * 4
  move.l  (a1,d3.w),a5        ; Get ptr to line Y
  adda.l  d2,a5               ; Add X offset to line start

  move.l  d5,d2               ; oldMVY = MVY
  move.l  RCT_X2(a2),d5       ; EYM = Screen width
  tst.l   d2                  ; Check oldMVY
  bpl     ADLN_XAdj           ; if oldMVY >= 0 then don't neg EYM
  neg.l   d5                  ; Else neg EYM
ADLN_XAdj:
  add.l   d4,d5               ; E2M (Screen Move) = EYM + MVX (E1M)
  move.l  a6,d2               ; Get Colour

ADLN_Loop:
  move.b  d2,(a5)             ; Write pixel (Chunky 8 bit)
  tst.l   d1                  ; Check D (Decision Value)
  bpl     ADLN_Pos            ; If positive skip negative stuff
  adda.l  d4,a5               ; ptr = ptr + E1M
  add.l   d6,d1               ; D   = D   + E1
  dbra    d0,ADLN_Loop        ; Dec Count & loop if more X required
  bra     ADL_Ret

ADLN_Pos:
  adda.l  d5,a5               ; ptr = ptr + E2M 
  add.l   d7,d1               ; D   = D   + E2
  dbra    d0,ADLN_Loop        ; Dec Count & loop if more X required
  bra     ADL_Ret

  ;**** X & Y Swapped ****

ADL_Swapped:
  asl.w   #2,d3               ; LineTab offset = Y * 4
  move.l  (a1,d3.w),a5        ; Get ptr to line Y
  adda.l  d2,a5               ; Add X offset to line start

  move.l  d5,d2               ; oldMVY = MVY
  move.l  RCT_X2(a2),d5       ; EYM =  Screen Width
  tst.l   d2                  ; Check oldMVY
  bpl     ADLS_XAdj           ; if oldMVY >= 0 then don't neg EYM
  neg.l   d5                  ; Else neg EYM
ADLS_XAdj:
  move.l  d5,d3               ; E1M = EYM
  add.l   d4,d5               ; E2M = EYM + MVX
  move.l  a6,d2               ; Get Colour

ADLS_Loop:
  move.b  d2,(a5)             ; Write pixel (Chunky 8 bit)
  tst.l   d1                  ; Check D (Decision Value)
  bpl     ADLS_Pos            ; If positive skip negative stuff
  adda.l  d3,a5               ; ptr = ptr + E1M
  add.l   d6,d1               ; D   = D   + E1
  dbra    d0,ADLS_Loop        ; Dec Count & loop if more X required
  bra     ADL_Ret

ADLS_Pos:
  adda.l  d5,a5               ; ptr = ptr + E2M 
  add.l   d7,d1               ; D   = D   + E2
  dbra    d0,ADLS_Loop        ; Dec Count & loop if more X required

ADL_Ret:
  movem.l (sp)+,d0-d7/a0-a6   ; Restore registers before return
  rts 


;*******************************
;****** Clip Line Co-ords ******
;*******************************

;Params - a0 - Pointer to line Rect structure
;         a1 - Pointer to Cliping Rect sturcture
          
;Result - d0 - 1 if not visible at all, otherwise 0 
;              If 0 then line Rect contains Clipped Co-ords

; NOTE - If called via ACL_Start, assume all registers trashed
;        except A0 (ptr to line)

_ASM_ClipLine:
  movem.l d1-d7/a0-a6,-(sp)   ; Stack important registers (56 bytes)

  move.l  60(sp),a0           ; Get line Rect pointer (56+4 for ret addr)
  move.l  64(sp),a1           ; Get clip Rect pointer

  jsr     ACL_Start           ; Call actual cliping routine

  movem.l (sp)+,d1-d7/a0-a6   ; Restore all important registers
  rts  

ACL_Start:
  move.l  RCT_X1(a1),a2       ; Get XMIN (a2)
  move.l  RCT_X2(a1),a3       ; Get XMAX (a3)
  move.l  RCT_Y1(a1),a4       ; Get YMIN (a4)
  move.l  RCT_Y2(a1),a5       ; Get YMAX (a5)

  move.l  RCT_X1(a0),d0       ; Get X1 (d0)
  move.l  RCT_Y1(a0),d1       ; Get Y1 (d1)
  move.l  RCT_X2(a0),d2       ; Get X2 (d2)
  move.l  RCT_Y2(a0),d3       ; Get Y2 (d3)

ACL_Discard1:
  cmp.l   a2,d0               ; IF X1<XMIN & X2<XMIN Then Discard
  bge     ACL_Discard2
  cmp.l   a2,d2
  blt     ACL_Ret1

ACL_Discard2:
  cmp.l   a3,d0               ; IF X1>XMAX & X2>XMAX Then Discard
  ble     ACL_Discard3
  cmp.l   a3,d2
  bgt     ACL_Ret1

ACL_Discard3:
  cmp.l   a4,d1               ; IF Y1<YMIN & Y2<YMIN Then Discard
  bge     ACL_Discard4
  cmp.l   a4,d3
  blt     ACL_Ret1

ACL_Discard4:
  cmp.l   a5,d1               ; IF Y1>YMAX & Y2>YMAX Then Discard
  ble     ACL_Test1
  cmp.l   a5,d3
  bgt     ACL_Ret1
  
ACL_Test1:                    
  cmp.l   a2,d0               ; Is X1 < XMIN
  bge     ACL_Test2           ; If not then skip
  cmp.l   a2,d2               ; Is X2 >= XMIN
  blt     ACL_Test2           ; If not then skip
  
  move.l  a2,d4               ; Known Intersect = XMIN 
  move.l  d2,a1               ; Store X2,Y2
  move.l  d3,a6
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d2               ; Restore X2,Y2
  move.l  a6,d3

  move.l  a2,d0               ; X1 = XMIN
  move.l  d6,d1               ; Y1 = Result

ACL_Test2:
  cmp.l   a2,d2               ; Is X2 < XMIN
  bge     ACL_Test3           ; If not then skip
  cmp.l   a2,d0               ; Is X1 >= XMIN
  blt     ACL_Test3           ; If not then skip
  
  move.l  a2,d4               ; Known Intersect = XMIN 
  move.l  d0,a1               ; Store X1,Y1
  move.l  d1,a6
  exg     d0,d2               ; Swap X1 with X2
  exg     d1,d3               ; Swap Y1 with Y2
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d0               ; Restore X1,Y1
  move.l  a6,d1
  
  move.l  a2,d2               ; X2 = XMIN
  move.l  d6,d3               ; Y2 = Result

ACL_Test3:                    
  cmp.l   a3,d0               ; Is X1 <= XMAX
  bgt     ACL_Test4           ; If not then skip
  cmp.l   a3,d2               ; Is X2 > XMAX
  ble     ACL_Test4           ; If not then skip
  
  move.l  a3,d4               ; Known Intersect = XMAX 
  move.l  d0,a1               ; Store X1,Y1
  move.l  d1,a6
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d0               ; Restore X1,Y1
  move.l  a6,d1
  
  move.l  a3,d2               ; X2 = XMAX
  move.l  d6,d3               ; Y2 = Result

ACL_Test4:
  cmp.l   a3,d2               ; Is X2 <= XMAX
  bgt     ACL_Discard5        ; If not then skip
  cmp.l   a3,d0               ; Is X1 > XMAX
  ble     ACL_Discard5        ; If not then skip
  
  move.l  a3,d4               ; Known Intersect = XMAX
  move.l  d2,a1               ; Store X2,Y2
  move.l  d3,a6
  exg     d0,d2               ; Swap X1 with X2
  exg     d1,d3               ; Swap Y1 with Y2
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d2               ; Restore X2,Y2
  move.l  a6,d3

  move.l  a3,d0               ; X1 = XMAX
  move.l  d6,d1               ; Y1 = Result

ACL_Discard5:
  cmp.l   a4,d1               ; IF Y1<YMIN & Y2<YMIN Then Discard
  bge     ACL_Discard6
  cmp.l   a4,d3
  blt     ACL_Ret1

ACL_Discard6:
  cmp.l   a5,d1               ; IF Y1>YMAX & Y2>YMAX Then Discard
  ble     ACL_Test5
  cmp.l   a5,d3
  bgt     ACL_Ret1
 
ACL_Test5:
  cmp.l   a4,d1               ; Is Y1 < YMIN
  bge     ACL_Test6           ; If not then skip
  cmp.l   a4,d3               ; Is Y2 >= YMIN
  blt     ACL_Test6           ; If not then skip
  
  move.l  a4,d4               ; Known Intersect = YMIN
  move.l  d2,a1               ; Store X2,Y2
  move.l  d3,a6
  exg     d0,d1               ; Swap X1 with Y1
  exg     d2,d3               ; Swap X2 with Y2
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d2               ; Restore X2,Y2
  move.l  a6,d3

  move.l  d6,d0               ; X1 = Result
  move.l  a4,d1               ; Y1 = YMIN

ACL_Test6:
  cmp.l   a4,d3               ; Is Y2 < YMIN
  bge     ACL_Test7           ; If not then skip
  cmp.l   a4,d1               ; Is Y1 >= YMIN
  blt     ACL_Test7           ; If not then skip
  
  move.l  a4,d4               ; Known Intersect = YMIN
  move.l  d0,a1               ; Store X1,Y1
  move.l  d1,a6
  exg     d0,d3               ; Swap X1 with Y2
  exg     d1,d2               ; Swap X2 with Y1
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d0               ; Restore X1,Y1
  move.l  a6,d1

  move.l  d6,d2               ; X2 = Result
  move.l  a4,d3               ; Y2 = YMIN
  
ACL_Test7:
  cmp.l   a5,d1               ; Is Y1 <= YMAX
  bgt     ACL_Test8           ; If not then skip
  cmp.l   a5,d3               ; Is Y2 > YMAX
  ble     ACL_Test8           ; If not then skip
  
  move.l  a5,d4               ; Known Intersect = YMAX
  move.l  d0,a1               ; Store X1,Y1
  move.l  d1,a6
  exg     d0,d1               ; Swap X1 with Y1
  exg     d2,d3               ; Swap X2 with Y2
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d0               ; Restore X1,Y1
  move.l  a6,d1
  
  move.l  d6,d2               ; X2 = Result
  move.l  a5,d3               ; Y2 = YMAX
  
ACL_Test8:
  cmp.l   a5,d3               ; Is Y2 <= YMAX
  bgt     ACL_Discard7        ; If not then skip
  cmp.l   a5,d1               ; Is Y1 > YMAX
  ble     ACL_Discard7        ; If not then skip
 
  move.l  a5,d4               ; Known intersect = YMAX
  move.l  d2,a1               ; Store X2,Y2
  move.l  d3,a6
  exg     d0,d3               ; Swap X1 with Y2
  exg     d1,d2               ; Swap X2 with Y1
  jsr     _ASM_FindInter      ; Find intersection
  move.l  a1,d2               ; Restore X2,Y2
  move.l  a6,d3

  move.l  d6,d0               ; X1 = Result  
  move.l  a5,d1               ; Y1 = YMAX

ACL_Discard7:
  cmp.l   a2,d0               ; IF X1<XMIN & X2<XMIN Then Discard
  bge     ACL_Discard8
  cmp.l   a2,d2
  blt     ACL_Ret1

ACL_Discard8:
  cmp.l   a3,d0               ; IF X1>XMAX & X2>XMAX Then Discard
  ble     ACL_Ret0
  cmp.l   a3,d2
  bgt     ACL_Ret1

ACL_Ret0:
  move.l  d0,RCT_X1(a0)       ; Put X1 (d0)
  move.l  d1,RCT_Y1(a0)       ; Put Y1 (d1)
  move.l  d2,RCT_X2(a0)       ; Put X2 (d2)
  move.l  d3,RCT_Y2(a0)       ; Put Y2 (d3)
  moveq.l #0,d0               ; Return visible (0)
  rts

ACL_Ret1:
  moveq.l #1,d0               ; Return not visible (1)
  rts
  
  
;*******************************
;****** Find Intersection ******
;*******************************

; Params   - d0 - X1
;            d1 - Y1
;            d2 - X2
;            d3 - Y2
;            d4 - XINT

; Internal - d5 - TEMP1 & XAVE
;            d6 - TEMP2 & YAVE
;            d7 - Decision 

; Result   - d6 - YINT (Y for X intersect)

; NOTE - d0-d3 & d5-d7 changed on exit


_ASM_FindInter:
  move.l  d4,d5               ; TEMP1 = XINT
  move.l  d4,d6               ; TEMP2 = XINT
  sub.l   d0,d5               ; TEMP1 = TEMP1 - X1
  sub.l   d2,d6               ; TEMP2 = TEMP2 - X2

  move.l  d5,d7               ; D = (TEMP1 + TEMP2) / 2
  add.l   d6,d7
  asr.l   #1,d7
  beq     AFI_Found           ; If D=0 Then Intersect Found

  move.l  d0,d5               ; XAVE = (X1 + X2) / 2
  add.l   d2,d5
  asr.l   #1,d5

  move.l  d1,d6               ; YAVE = (Y1 + Y2) / 2
  add.l   d3,d6
  asr.l   #1,d6
  
  tst.l   d7                  ; Check D
  bmi     AFI_Negative        ; IF less Negative Skip +ve stuff

  move.l  d5,d0               ; X1 = XAVE
  move.l  d6,d1               ; Y1 = YAVE
  bra     _ASM_FindInter

AFI_Negative:
  move.l  d5,d2               ; X2 = XAVE
  move.l  d6,d3               ; Y2 = YAVE
  bra     _ASM_FindInter

AFI_Found:
  move.l  d1,d6               ; YAVE = (Y1 + Y2) / 2
  add.l   d3,d6
  asr.l   #1,d6
  rts



;********************
;*** Draw Polygon ***
;********************

; Params - 64 - Pointer to Screen Line Start/End Table
;          68 - Pointer to Screen Line Address Table
;          72 - Pointer to Screen Size Rect Structure
;          76 - Pointer to Vertex List
;          80 - Vertex Count
;          84 - Colour
           
_ASM_DrawPoly:
  movem.l d0-d7/a0-a6,-(sp)   ; Store all registers
  
  move.l  64(sp),a0           ; Get pointer to work table
  move.l  72(sp),a1
  move.l  RCT_Y2(a1),d0       ; Get screen depth
  subq.l  #1,d0               ; Decrement height for use with DBRA
  jsr     ADP_InitWorkTab     ; Initialise Work Table
  
  move.l  64(sp),a0           ; Get pointer to work table
  move.l  76(sp),a1           ; Get pointer to vertex list
  move.l  80(sp),d7           ; Get vertex count
  jsr     ADP_CalcEnds        ; Calc Line Start & End Values

  move.l  68(sp),a1           ; Get pointer to Screen Line Addr table
  move.l  72(sp),a2           ; Get pointer to Screen Size Rect struct
  move.l  84(sp),d5           ; Get Colour
  jsr     ADP_PlotLines
  
  movem.l (sp)+,d0-d7/a0-a6   ; Restore all registers 
  rts

;*** Initialise Screen Start/End Work Table ***

ADP_InitWorkTab:
  move.l  #$FFFF,(a0)+        ; Init start (65536)
  move.l  #-1,(a0)+           ; Init End   (-1)
  dbra    d0,ADP_InitWorkTab  ; Decrement & do again if more lines
  rts


;*** Calculate Line Start & End Values ***

; Params - a0 - Line Start/End Table Pointer
;          a1 - Pointer to Vertex List (Long word pairs)
;          d7 - Vertex Count

; Result - d4 - Contains Lowest Y that requires ploting

; Internal - d7 - Count
;            d6 - Prev Vertex Offset
;            d5 - Current Vertex Offset

ADP_CalcEnds:
  subq.l  #1,d7               ; Decrement Vertex Count for use with DBRA
  move.l  d7,d6               ; Get temp copy of count
  asl.l   #3,d6               ; Multiply by vertex entry size (8 bytes)
  moveq.l #0,d5               ; Init Current Vertex Offset
  move.l  #$FFFFFF,d4         ; Init 1st line to plot store

ADPCE_Loop:
  move.l   (a1,d5.w),d0       ; Get X2
  move.l  4(a1,d5.w),d1       ; Get Y2
  move.l   (a1,d6.w),d2       ; Get X1
  move.l  4(a1,d6.w),d3       ; Get Y1

  movem.l d4-d7/a0-a1,-(sp)   ; Store registers
  jsr     ADP_CalcLine        ; Calc Line Stuff
  movem.l (sp)+,d4-d7/a0-a1   ; Restore registers

  cmp.l   d4,a6               ; Is Lowest X from call lower than current 
  bge     ASPCE_Cont1         ; If not then skip current update
  move.l  a6,d4               ; else current = lowest from prev call  
  
ASPCE_Cont1:  
  move.l  d5,d6               ; Prev Vertex = Current
  addq.l  #8,d5               ; Increment Current Vertex
  dbra    d7,ADPCE_Loop
  rts
  

;*** Calc Line Starts and Ends ***

; Params - d0 - X2
;          d1 - Y2
;          d2 - X1
;          d3 - Y1
;          a0 - Pointer to Line Start/End Work Table

; Internal - d0 - X2 DX
;            d1 - Y2 DY  D 
;            d4 - MVX
;            d5 - MVY
;            d6 - E1
;            d7 - E2
;            a4 - Swapped flag (1=swapped)
;            a5 - Temp pointer to work table
;            a6 - Lowest Y

; Result - a6 - Lowest Y used for calculating 1st line to plot

ADP_CalcLine:
  moveq.l #1,d4               ; MVX = 1
  sub.l   d2,d0               ; DX  = X2 - X1
  bpl     ADPCL_Cont1         ; If + distance then skip negative flip
  moveq.l #-1,d4              ; MVX = -1
  neg.l   d0                  ; DX  = 0 - DX

ADPCL_Cont1:  
  move.l  d1,d6               ; Take temp copy of Y2
  move.l  d3,a6               ; Lowest Y = Y1
  moveq.l #1,d5               ; MVY = 1 
  sub.l   d3,d1               ; DY  = Y2 - Y1
  bpl     ADPCL_Cont2         ; If + distance then skip negative flip
  moveq.l #-1,d5              ; MVY = -1
  neg.l   d1                  ; DY  = 0 - DY
  move.l  d6,a6               ; Lowest Y = Y2

ADPCL_Cont2:
  move.l  #0,a4               ; Swapped = No (0)
  cmp.l   d0,d1               ; Compare DY with DX
  ble     ADPCL_Cont3         ; If DY <= DX then skip swap
  move.l  #1,a4               ; Swapped = Yes (1)
  exg     d0,d1               ; Exchange DX and DY
  
ADPCL_Cont3:

  move.l  d1,d6               ; E1  = DY
  asl.l   #1,d6               ; E1  = E1 * 2

  move.l  d6,d1               ; D   = E1
  sub.l   d0,d1               ; D   = D - DX
  
  move.l  d6,d7               ; E2  = E1
  asl.l   #1,d0               ; tmp = DX * 2
  sub.l   d0,d7               ; E2  = E2 - tmp

  asr.l   #1,d0               ; Count = DX
  cmpa.l  #1,a4               ; Is swapped flag set ?
  beq     ADPCL_Swapped       ; If yes jump to swapped loop

ADPCL_Normal:
  move.l  a0,a5               ; Get ptr to Start/End Table
  asl.l   #3,d3               ; Offset = Y * 8
  add.l   d3,a5               ; Add offset to table base ptr
  asl.l   #3,d5               ; MVY = MVY * 8 (-8 or +8)

ADPCLN_Cont0:
  cmp.l   (a5),d2             ; Is X >= Current Start
  bge     ADPCLN_Cont1        ; If so then skip Start change
  move.l  d2,(a5)             ; else set Start to X

ADPCLN_Cont1:  
  cmp.l   4(a5),d2            ; Is X <= Current End
  ble     ADPCLN_Loop         ; If so then skip End change
  move.l  d2,4(a5)            ; else set End to X

ADPCLN_Loop:
  tst.l   d1                  ; Check Decision Variable
  bge     ADPCLN_Pos          ; If posative jump to E2 handler
  add.l   d6,d1               ; D = D + E1
  add.l   d4,d2               ; X = X + MVX
  dbra    d0,ADPCLN_Loop      ; Loop if more X moves required  
  rts

ADPCLN_Pos:
  add.l   d7,d1               ; D = D + E2
  add.l   d4,d2               ; X = X + MVX
  add.l   d5,a5               ; Start/End Tab Offset += (MVY * 8)
  dbra    d0,ADPCLN_Cont0     ; Loop if more X moves required
  rts


ADPCL_Swapped:
  move.l  a0,a5               ; Get ptr to Start/End Table
  asl.l   #3,d3               ; Offset = Y * 8
  add.l   d3,a5               ; Add offset to table base ptr
  asl.l   #3,d5               ; MVY = MVY * 8 (-8 or +8)

ADPCLS_Loop:
  cmp.l   (a5),d2             ; Is X >= Current Start
  bge     ADPCLS_Cont1        ; If so then skip Start change
  move.l  d2,(a5)             ; else set Start to X

ADPCLS_Cont1:  
  cmp.l   4(a5),d2            ; Is X <= Current End
  ble     ADPCLS_Cont2        ; If so then skip End change
  move.l  d2,4(a5)            ; else set End to X

ADPCLS_Cont2:
  tst.l   d1                  ; Check Decision Variable
  bge     ADPCLS_Pos          ; If posative jump to E2 handler
  add.l   d6,d1               ; D = D + E1
  add.l   d5,a5               ; Start/End Tab Offset += (MVY * 8)
  dbra    d0,ADPCLS_Loop      ; Loop if more X moves required  
  rts

ADPCLS_Pos:
  add.l   d7,d1               ; D = D + E2
  add.l   d4,d2               ; X = X + MVX
  add.l   d5,a5               ; Start/End Tab Offset += (MVY * 8)
  dbra    d0,ADPCLS_Loop      ; Loop if more X moves required
  rts


;*** Fill Required Lines from Start X to End X ***

; Params - a0 - Ptr to Screen Start/End Table
;          a1 - Ptr to Screen Line Addr Table
;          a2 - Ptr to Screen Size Rect Structure
;          d4 - 1st Y Line to be plotted
;          d5 - Colour

; Internal - d0 - Screen Height 
;            d1 - Y Counter
;            d2 - Start X
;            d3 - End X
;            a3 - Pointer to Current Start/End entry
;            a4 - Pointer to Start of Current Screen line

ADP_PlotLines:
  move.l  RCT_X2(a2),d0       ; Get Screen Width
  move.l  d0,d1               ; Count = Height
  sub.l   d4,d1               ; Count = Count - Y
  subq.l  #1,d1               ; Decrement for use with DBRA

  asl.l   #2,d4               ; Screen Line table offset = Y*4
  move.l  a1,a4               ; Get pointer to Screen Line table
  move.l  (a4,d4.w),a4        ; Get pointer to 1st Screen Line

  move.l  a0,a3               ; Get pointer to Start/End table
  asl.l   #1,d4               ; Screen Start/End table offset = (Y*4)*2
  add.l   d4,a3               ; Add offset to get 1st Start/End pointer

  move.b  d5,d6               ; Get copy of colour byte
  asl.l   #8,d5               ; Replicate byte through d5
  move.b  d6,d5
  asl.l   #8,d5
  move.b  d6,d5
  asl.l   #8,d5
  move.b  d6,d5

ADPPL_LineLoop:
  move.l  (a3),d2             ; Get X start for current line
  move.l  4(a3),d3            ; Get X end for current line
  bmi     ADP_End             ; If end is -1 then no more lines to plot
  
  move.l  a4,a5               ; Get temp copy of line pointer
  add.l   d2,a5               ; Add starting X to line pointer

  sub.l   d2,d3               ; DX (d3) = X2 - X1
  addq.l  #1,d3               ; DX = number of pixels to plot

  move.l  a5,d6               ; Get temp copy 1st address                
  and.l   #3,d6               ; Get number of alignment byte writes
  beq     ADPPL_Cont1         ; If no alignment bytes then skip

  cmp.l   d3,d6               ; Is alignment > DX
  ble     ADPPL_Cont2         ; If not then skip alignment length fix   
  move.l  d3,d6               ; Else alignment bytes = DX

ADPPL_Cont2:
  sub.l   d6,d3               ; DX = DX - Align bytes written
  subq.l  #1,d6               ; Decrement byte counter for use with DBRA

ADPPL_SAlignLoop:
  move.b  d5,(a5)+            ; Write byte
  dbra    d6,ADPPL_SAlignLoop ; If more align bytes required then loop

ADPPL_Cont1:
  move.l  d3,d6               ; Get copy of DX
  ble     ADPPL_NextLine      ; If DX <= 0 then skip to next line
  move.l  d3,d7               ; Get another copy of DX
  and.l   #3,d7               ; (d7) = End alignment bytes required
  asr.l   #2,d6               ; (d6) = Number of longwords to write
  beq     ADPPL_EndAlign      ; If no long words the skip to end align

  subq.l  #1,d6               ; Decrement long count for use with DBRA

ADPPL_LongLoop:
  move.l  d5,(a5)+            ; Write longword
  dbra    d6,ADPPL_LongLoop   ; Loop if more lon words required

ADPPL_EndAlign:
  subq.l  #1,d7               ; Sub 1 from end align count for DBRA
  bmi     ADPPL_NextLine      ; If neg after dec then no end align 

ADPPL_EAlignLoop:
  move.b  d5,(a5)+            ; Write end alignment byte
  dbra    d7,ADPPL_EAlignLoop ; Loop if more bytes required
  
ADPPL_NextLine:
  add.l   d0,a4               ; Move down screen 1 line
  add.l   #8,a3               ; Move down Start/End table 1 line
  dbra    d1,ADPPL_LineLoop   ; Do next line if any remain

ADP_End:
  rts



;**************************************
;*** Apply Screen Pixel Translation ***
;**************************************

; Parameter 1 - a0.l - Pointer to Chunky Screen
;           2 - a1.l - Pointer to Colour Trans table
;           3 - d0.l - Longwords to translate
           
_ASM_ColTrans:
  movem.l d0-d2/a0-a1,-(sp)   ; Store all registers used
  
  move.l  24(sp),a0           ; Get Chunky Screen Pointer
  move.l  28(sp),a1           ; Get Pointer to Colour Trans Table
  move.l  32(sp),d0           ; Get Longwords count
  subq.l  #1,d0               ; Decrement height for use with DBRA
  clr.l   d2                  ; Clear longword D2

ACT_Loop1:
  move.l  (a0),d1             ; Get 4 bytes from source
  move.b  d1,d2               ; Get pixel value
  move.b  (a1,d2),d1          ; Get translated byte

  ror.l   #8,d1               ; Get next byte
  move.b  d1,d2               ; Get pixel value
  move.b  (a1,d2),d1          ; Get translated byte
             
  ror.l   #8,d1               ; Get next byte
  move.b  d1,d2               ; Get pixel value
  move.b  (a1,d2),d1          ; Get translated byte
             
  ror.l   #8,d1               ; Get next byte
  move.b  d1,d2               ; Get pixel value
  move.b  (a1,d2),d1          ; Get translated byte
             
  ror.l   #8,d1               ; Final rotate for original alignment
  move.l  d1,(a0)+            ; Write translated 4 pixels back
  dbra    d0,ACT_Loop1        ; Loop if mor longs to process

  movem.l (sp)+,d0-d2/a0-a1   ; Restore all registers used
  rts

