;**************************************
;*** 3D_Core - World Transformation ***
;***     Version 1.04  05/11/96     ***
;***  Copyright (c) J.Gregory 1996  ***
;**************************************

;Parameters a0 - Pointer to RotatetWork
;           a1 - Pointer to ActObj array
;           a2 - Pointer to DepthList
;           a3 - Pointer to SIN/COS tables
;           a4 - Pointer to ViewPoint WObject

;***************************************************************
; Note a possible optimisation may be do drop the storing of
; Vx & Vy back to the ActObj record as probably will not be used
; as generally Rx,Ry will be more usefull !!!!!!!!
;***************************************************************

_ASM_Rotate_World:
  movem.l d0-d7/a0-a6,-(sp)       ; Stack all registers (60 bytes)

  move.l  64(sp),a0               ; Get RotateWork ptr (+4 for ret addr)
  move.l  68(sp),a1               ; Get ActObj pointer
  move.l  72(sp),a2               ; Get Pointer to DepthList
  move.l  76(sp),a3               ; Get Pointer to SIN/COS tables
  move.l  80(sp),a4               ; Get Pointer to ViewPoint struct

  clr.l   d1                      ; Clear angle
  move.w  RW_Angle(a0),d1         ; Get Angle from RotWork
  move.l  SinTab(a3,d1.l*4),d6    ; Get Sin of Angle
  move.l  CosTab(a3,d1.l*4),d7    ; Get Cos of Angle
  move.l  WO_Wx(a4),a3            ; Get ViewPoints World X co-ord
  move.l  WO_Wy(a4),a6            ; Get Viewpoints World Y co-ord
  move.l  RW_Tan(a0),a4           ; Get Pointer to Tangents Table
  
  clr.l   d0                      ; Clear ActObj array size
  move.w  RW_Count(a0),d0         ; Get ActObj array size
  subq.l  #1,d0                   ; Dec ActObj count for use with dbra 

RW_Loop1:
  tst.l   (a1)                    ; Is this ActObj active ?
  beq     RW_Next                 ; if not skip to next

RW_Rot:
  move.l  (a1),a5                 ; Get Pointer to parent WObject
  move.l  WO_Wx(a5),d1            ; Get Objects World X co-ord
  move.l  WO_Wy(a5),d2            ; Get Objects World Y co-ord
  sub.l   a3,d1                   ; Sub VP X from Obj X
  sub.l   a6,d2                   ; Sub VP Y from Obj Y

  move.l  d1,AO_Vx(a1)            ; Write back view relative X
  move.l  d2,AO_Vy(a1)            ; Write back view relative Y

  move.l  d1,d3                   ; Get copy of X
  move.l  d2,d4                   ; Get copy of Y
  muls.l  d7,d3                   ; d3 = X * Cos(angle)
  muls.l  d6,d4                   ; d4 = Y * Sin(angle)
  sub.l   d4,d3                   ; d3 (New X) = d3 - d4
   
  move.l  d1,d4                   ; Get Copy of X
  move.l  d2,d5                   ; Get Copy of Y
  muls.l  d6,d4                   ; d4 = X * Sin(angle)
  muls.l  d7,d5                   ; d5 = Y * Cos(angle)
  add.l   d5,d4                   ; d4 (New Y) = d4 + d5
   
  asr.l   #TRIGSHFT1,d3           ; Remove SIN/COS tab precision shift
  asr.l   #TRIGSHFT2,d3
  asr.l   #TRIGSHFT1,d4           ; Remove SIN/COS tab precision shift
  asr.l   #TRIGSHFT2,d4
   
  move.l  d3,AO_Rx(a1)            ; Store New X back to WObject
  move.l  d4,AO_Ry(a1)            ; Store New Y back to WObject
  ble     RW_ClrDist              ; If Y is <= 0 don't add to DepthList

  tst.l   d3                      ; **** Discard peripheral objects ****  
  bpl     RW_Cont1                ; If X Dist = Negative then flip sign
  neg.l   d3   
RW_Cont1:       
  asr.l   #2,d3                   ; Divide X Distance by 4
  cmp.l   d3,d4                   ; Compare DY with DX/4 if less then skip
  ble     RW_ClrDist
  asl.l   #2,d3
      
  bsr     RW_FindAngle            ; Calc viewpoint to object angle

  move.l  d5,(a2)+                ; Write Distance into DepthList
  move.l  a1,(a2)+                ; Write ActObj pointer into DepthList

  bra     RW_Next

RW_ClrDist:
  move.l  #0,AO_Dist(a1)          ; Clear ActObj distance if not vissible

RW_Next:
  adda.w  #AO_SizeOf,a1           ; Move pointer to next actobj    
  dbra    d0,RW_Loop1             ; Dec ActObj Count, loop if more

  move.l  #0,(a2)                 ; Write terminating DepthEntry
  move.l  #0,(a2)                 ; Write terminating DepthEntry

  move.l  72(sp),a6               ; Get Pointer to DepthList
  sub.l   a6,a2                   ; Sub list start from list end
  move.l  a2,d0                   ; Move to a data register
  asr.l   #3,d0                   ; 8 bytes per entry so divide by 8

  move.w  d0,RW_Count(a0)         ; Write to rotate work (d0 = AQSSort param) 
  move.l  a6,a0                   ; Get DepthList start (a0 = AQSSort param) 

  jsr     AQSSort2                ; Call Reg.Param. Entry to QuickSort

RW_Ret:
  movem.l (sp)+,d0-d7/a0-a6       ; Restore registers
  rts   


;***************************************************
;*** Find Angle x2,y2 falls in relative to x1,y1 ***
;***    Low res version (nearest 10 degrees)     ***
;***************************************************

;Params  - d3,d4 - x1,y1
;        - x2,y2 - Allways 0,0 (VP)
;        - a4    - Pointer to Tangent Table

;Trashes - d1,d2,d3,d4,d5,a5
  
;Return  - Sets AO_Octant of ActObj to Angle x2,y2 falls
;          in relative to x1,y1 to nearest 10 degrees
;          d5 - Set to angle to place in depth list

;NOTE - Only used within rotate world !!!!!
                 
RW_FindAngle:
  move.l  d6,a5             ; Save d6
  
  move.l  d3,d1             ; Get copy of X1
  bpl     RWFA_SkipNeg1     ; DX = Abs(DX)
  neg.l   d1
  
RWFA_SkipNeg1:
  move.l  d1,d5             ; Get copy of DX
  
  asl.l   #TRIGSHFT1,d5     ; TDX = TDX * 2048
  asl.l   #TRIGSHFT2,d5
  move.l  d4,d2             ; Get copy of Y1
  divu.l  d2,d5             ; RATIO = TDX / DY  

  move.l  #6,d2             ; Set Counter for 7 Iterations
  move.l  #128,d1           ; Current angle (AVPT)
  move.l  #128,d6           ; Set Initial Power

RWFA_Loop1:
  asr.l   #1,d6             ; Lower current Power by 1 power of 2
  cmp.l   (a4,d1.l*4),d5    ; Compare ratio with tangent
  beq     RWFA_OctAdj       ; If found exact match end loop
  bgt     RWFA_SkipHigher   ; If Ration>Tangent Skip Higher

RWFA_SkipLower:
  sub.l   d6,d1             ; Skip downwards
  dbra    d2,RWFA_Loop1     ; Loop if more iterations required

  bra     RWFA_OctAdj
  
RWFA_SkipHigher:
  add.l   d6,d1             ; Skip upwards
  dbra    d2,RWFA_Loop1     ; Loop if more iterations required
  
RWFA_OctAdj:
  move.l  d4,d5             ; Get Copy of DY
  bpl     RWFA_SkipNeg3     ; If not negative skip sign flip
  neg.l   d5                ; Flip sign of DY

RWFA_SkipNeg3:
  move.l  AO_Dist(a1),d6    ; Get Active WObjects Distance
  ble     RWFA_CalcDist     ; If Distance <=0 Calculate Distance
 
  move.l  RW_VPFlags(a0),d2 ; Get VP WObject Flags
  btst.l  #WOBMOVED,d2      ; Test Moved flag bit
  bne     RWFA_CalcDist     ; If VP Moved Calculate Distance

  move.l  d6,d5             ; If not recalced use old distance 
  bra     RWFA_SkipDist     ; If neither moved then skip Distance Calc

RWFA_CalcDist:
  moveq.l #0,d2
  move.w  HPCOS(a4,d1.l*2),d2 ; Get HP Cosine of Angle
  asl.l   #TRIGSHFT1,d5     ; Multiply distance by 2048
  asl.l   #TRIGSHFT2,d5
  divu.l  d2,d5             ; (Dist*2048)/(Cos*2048)
  move.l  d5,AO_Dist(a1)    ; Store real distance to ActObj

RWFA_SkipDist:  
  tst.l   d3                ; Adjust actual angle returned
  bpl     RWFA_XP_YP        ; based on Quadrant DX & DY fell in

RWFA_XN_YP:
  move.w  #1023,d2          ; Angle = 1023 - Angle
  sub.w   d1,d2
  move.w  d2,AO_Angle(a1)
  move.l  a5,d6             ; Restore d6
  rts
  
RWFA_XP_YP:
  move.w  d1,AO_Angle(a1)   ; Angle = Angle
  move.l  a5,d6             ; Restore d6
  rts  
    


;***************************************************
;*** Find Angle x2,y2 falls in relative to x1,y1 ***
;***************************************************

;Heading 0 is parallel with the increasing X access and
;the headings proceed in an anti-clockwise direction

;Params - d0,d1 - x1,y1
;       - d2,d3 - x2,y2
;       - a0    - ptr to Tangents table (must have 90 WORDs !!) 

;Return - d0.l  - Angle (0-1023) (Not stacked as modified on return)

_ASM_FindAngle:
  movem.l d1-d5/a0,-(sp)    ; Stack all used registers (24 bytes)
  
  move.l  28(sp),d0         ; Get x1 (+4 for ret addr)
  move.l  32(sp),d1         ; Get y1
  move.l  36(sp),d2         ; Get x2
  move.l  40(sp),d3         ; Get y2
  move.l  44(sp),a0         ; Get ptr to tangents table

  sub.l   d0,d2             ; d2 = DX
  beq     AFA_DX_Zero       ; If DX=0 goto to DX=0 handler

  sub.l   d1,d3             ; d3 = DY
  beq     AFA_DY_Zero       ; If DY=0 goto to DY=0 handler
  
  move.l  d2,d0             ; d0 = Abs(DX) (ADX)
  bpl     AFA_SkipNeg1
  neg.l   d0
  
AFA_SkipNeg1:  
  move.l  d3,d1             ; d1 = Abs(DY) (ADY)
  bpl     AFA_SkipNeg2
  neg.l   d1

AFA_SkipNeg2:

  move.l  d0,d4             ; d4 RATIO = (ADX * 2048) / ADY
  asl.l   #TRIGSHFT1,d4
  asl.l   #TRIGSHFT2,d4
  divu.l  d1,d4      

  move.l  #6,d0             ; Set Counter for 7 Iterations
  move.l  #128,d1           ; Current angle (AVPT)
  move.l  #128,d5           ; Set Initial Power

AFA_Loop1:
  asr.l   #1,d5             ; Lower current Power by 1 power of 2
  cmp.l   (a0,d1.l*4),d4    ; Compare ratio with tangent
  beq     AFA_CalcFinal     ; If found exact match end loop
  bgt     AFA_SkipHigher    ; If Ration>Tangent Skip Higher

AFA_SkipLower:
  sub.l   d5,d1             ; Skip downwards
  dbra    d0,AFA_Loop1      ; Loop if more iterations required

  bra     AFA_CalcFinal
  
AFA_SkipHigher:
  add.l   d5,d1             ; Skip upwards
  dbra    d0,AFA_Loop1      ; Loop if more iterations required
  
AFA_CalcFinal:              ; Calc final angle based on quadrant (d1=angle)
  tst.l   d2                ; Test sign of DX
  bmi     AFA_XN            ; If negative jump
AFA_XP:
  tst.l   d3                ; Test sign of DY
  bmi     AFA_XP_YN         ; If negative jump
AFA_XP_YP:
  move.l  d1,d0
  bra     AFA_Ret           ; If X+ Y+ then Angle = Angle

AFA_XN:
  tst.l   d3
  bmi     AFA_XN_YN
AFA_XN_YP:
  move.l  #1023,d0          ; Angle = 1023 - Angle
  sub.l   d1,d0
  bra     AFA_Ret

AFA_XN_YN:
  add.l   #512,d1           ; Angle = 512 + Angle
  move.l  d1,d0
  bra     AFA_Ret

AFA_XP_YN:
  move.l  #511,d0           ; Angle = 511 - Angle
  sub.l   d1,d0

AFA_Ret:
  movem.l (sp)+,d1-d5/a0    ; Retrieve all used registers
  rts

;*** Antipode handlers *** 

AFA_DX_Zero:
  sub.l   d1,d3             ; d3 = DY
  bpl     AFA_DXZ_DYP       ; Jump if DY is +

AFA_DXZ_DYN:
  move.l  #511,d0           ; DY is - so Angle = 511           
  bra     AFA_Ret             

AFA_DXZ_DYP:
  moveq.l #0,d0             ; DY is + so Angle = 0
  bra     AFA_Ret


AFA_DY_Zero:
  tst.l   d2                ; Test DX
  bpl     AFA_DYZ_DXP       ; Jump if DX is +
  
AFA_DYZ_DXN:
  move.l  #767,d0           ; DX is - so Angle = 767
  bra     AFA_Ret

AFA_DYZ_DXP:
  move.l  #255,d0            ; DX is + so Angle = 255
  bra     AFA_Ret

