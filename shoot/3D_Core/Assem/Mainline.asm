;*************************************************
;****** Mainline global hook to compile all ******
;******  3D_Core assem code from one file   ******
;******    Also contains global equates     ******
;******  Copyright(c) J.Gregory 20/01/98    ******
;*************************************************
   
  INCLUDE "exec/types.i"
  INCLUDE "devices/inputevent.i"
  INCLUDE "hardware/custom.i"
  INCLUDE "hardware/dmabits.i"

;***************************
;*** Exportable Routines ***
;***************************

  XDEF _ASM_ConvScreen
  XDEF _ASM_ScaleSpriteN
  XDEF _ASM_ScaleSpriteT

  XDEF _ASM_FillMemLong
  XDEF _ASM_DrawClipChunky
  XDEF _ASM_BoxChunky
  XDEF _ASM_DrawClipPlan
  XDEF _ASM_ClipLine
  XDEF _ASM_DrawLine
  XDEF _ASM_DrawPoly
  XDEF _ASM_ColTrans
  
  XDEF _ASM_InputHandler
  XDEF _ASM_KeyStatus
  XDEF _ASM_VertBServer

  XDEF _ASM_QuickSort

  XDEF _ASM_Rotate_World
  XDEF _ASM_FindAngle

  XDEF _ASM_ChkCol
    
  section data
   
;*****************
;**** Equates ****
;*****************
     
  width:      SET 320                 ; Screen width Must be mult of 32 
  height:     SET 130                 ; Screen height
  plsiz:      SET (width/8)*height    ; Size of 1 bit plane

  SinTab:     SET 0                   ; Offset to start of Sine table
  CosTab:     SET 4096                ; Offset to start of Cosine table
   
  COORDRNG:   SET 8191                ; Max X,Y Centre allowed for scaling

  HPCOS:      SET 1024                ; Offset of HP_CosTab from HP_TanTab

  TRIGSHFT1:  SET 8                   ; Shifts used for Trig Precision
  TRIGSHFT2:  SET 3

  WOBMOVED:   SET 0                   ; Wobject Moved Flag bit (0)

;**** Rotate Work Structure ****

  RW_Angle:   SET 0       ; WORD
  RW_Count:   SET 2       ; UWORD
  RW_VPFlags: SET 4
  RW_Tan:     SET 8
  RW_Cos:     SET 12
  RW_SizeOf:  SET 16

;**** ActObj Data Structure ****

  AO_WObject:     SET 0
  AO_Frame:       SET 4   ; UWORD
  AO_Time:        SET 6
  AO_Angle:       SET 10  ; UWORD
  AO_ObAng:       SET 12  ; UWORD
  AO_ActDef:      SET 14
  AO_ChnkWork:    SET 18
  AO_Vx:          SET 54
  AO_Vy:          SET 58
  AO_Rx:          SET 62
  AO_Ry:          SET 66
  AO_Dist:        SET 70
  AO_SizeOf:      SET 74
  
;**** ColWork Data Structure (Parameter block) ****

  CW_Wx:          SET 0 
  CW_Wy:          SET 4 
  CW_Height:      SET 8 
  CW_Radius:      SET 12 
  CW_ColArea:     SET 16
  CW_WObject:     SET 20 
  CW_SpcPart:     SET 24 
  CW_Ignore1:     SET 28 
  CW_Ignore2:     SET 32 
  CW_XMin:        SET 36 
  CW_XMax:        SET 40 
  CW_YMin:        SET 44 
  CW_YMax:        SET 48 
  CW_HMin:        SET 52 
  CW_HMax:        SET 56 
  CW_R1Start:     SET 60 
  CW_R1End:       SET 64 
  CW_R2Start:     SET 68  
  CW_R2End:       SET 72  
  CW_Ret:         SET 76  ; LONG[41]
  CW_SizeOf:      SET 240

;**** ColArea Data Structure (ColArea Array) ****

  CA_Wx:          SET 0
  CA_Wy:          SET 4
  CA_Wx2:         SET 8
  CA_Wy2:         SET 12
  CA_Floor:       SET 16
  CA_Ceil:        SET 20
  CA_ID:          SET 24
  CA_SizeOf:      SET 28

;**** WObject Data Structure ****

  WO_Wx:          SET 0
  WO_Wy:          SET 4
  WO_Height:      SET 8
  WO_Heading:     SET 12   ; WORD
  WO_Size:        SET 14
  WO_Radius:      SET 18
  WO_Speed:       SET 22
  WO_ObjDef0:     SET 26
  WO_ObjDef1:     SET 30
  WO_ObjDef2:     SET 34
  WO_ObjDef3:     SET 38
  WO_ActObj:      SET 42   ; UWORD
  WO_Data:        SET 44
  WO_Flags:       SET 48
  WO_ID:          SET 52
  WO_IntID:       SET 56
  WO_Next:        SET 60
  WO_Prev:        SET 64
  WO_MovFunc:     SET 68 
  WO_ColFunc:     SET 72
  WO_SizeOf:      SET 76

;**** Rectangle Data Structure ****

  RCT_X1:         SET 0
  RCT_Y1:         SET 4
  RCT_X2:         SET 8
  RCT_Y2:         SET 12
  RCT_SizeOf:     SET 16

;**** Chunky Image Structure ****

  CIM_Magic:      SET 0
  CIM_ID:         SET 4
  CIM_PxWidth:    SET 6
  CIM_PxHeight:   SET 8
  CIM_Depth:      SET 10
  CIM_Flags:      SET 12
  CIM_Next:       SET 16
  CIM_Data:       SET 20
  CIM_LineTab:    SET 24
  CIM_Size:       SET 28
  CIM_Prev:       SET 32
  CIM_SizeOf:     SET 36
   
;********************************
;**** Temporary data storage ****
;********************************

  LineTab:    dc.l    0               ; Pointer to chunky screen line table
   
;*********************************
;**** Main Body Code Includes ****
;*********************************

  section code
   
  INCLUDE "C2P020.ASM"
  INCLUDE "ScSprite.ASM"
  INCLUDE "ScSpriteThin.ASM"
  INCLUDE "Draw.ASM"
  INCLUDE "InputHandler.ASM"
  INCLUDE "Interrupts.ASM"
  INCLUDE "QuickSort.ASM"
  INCLUDE "Rotation.ASM"
  INCLUDE "Collision.ASM"
   
  end
