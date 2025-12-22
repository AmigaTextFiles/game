;****************************************************
;****** Input Handler - Version 1.21  13/03/98 ******
;****************************************************
   
; Parameters - a0 - Pointer to 1st item in input event chain
;              a1 - Pointer to user data (4 long words bit per key)
;                   (1 = Key down, 0 = Key up)
;                   Additional longword on end contains 32 flags
;                   bit 0 = 1 = Record Key Presses
;                           0 = Ignore Key Presses

; Returns    - d0 - Pointer to new list or NULL if no list remains   

; NOTE - Some keys are not reported as down together by input.device
;        Events are allways passed on down the chain.

_ASM_InputHandler:
   movem.l d1-d3/a0-a2,-(sp)               ; Stack registers
   move.l  a0,a2                           ; Store event list head pointer
   move.l  16(a1),d0                       ; Get flags
   btst.l  #0,d0                           ; Check handler enable flag
   beq.s   AIH_PassOn                      ; If not enabled skip to end   

AIH_EventLoop:
   cmp.b   #IECLASS_RAWKEY,ie_Class(a0)    ; Is it a RAWKEY event ?
   bne.s   AIH_NextEvent                   ; If not skip to next event
   
   move.w  6(a0),d0                        ; Get raw key code
   move.w  d0,d1                           ; Get copy key code
   and.w   #$7F,d1                         ; Mask out key up down flag
   move.b  d1,d3                           ; Store key code for later use
   move.w  d1,d2                           ; Get copy of raw key code
   and.w   #7,d2                           ; d2 is bit to alter
   asr.w   #3,d1                           ; d1 is longword the bit is in

   btst    #7,d0                           ; Check key up down flag
   beq.s   AIH_KeyDown                     ; If key down jump to set bit

AIH_KeyUp:
   bclr    d2,(a1,d1.w)                    ; Clear bit relating to key code
   bra.s   AIH_NextEvent
   
AIH_KeyDown:      
   bset    d2,(a1,d1.w)                    ; Set bit relating to key code 
   move.b  d3,16(a1)                       ; Store last key down code

AIH_NextEvent:
   move.l  (a0),d0                         ; Check pointer to next event
   move.l  d0,a0                           ; Set pointer to next event
   bne.s   AIH_EventLoop                   ; If pointer valid then loop

AIH_NoPassOn:
   move.l   #0,d0                          ; Pass No Events to next handler
   movem.l  (sp)+,d1-d3/a0-a2              ; Pop registers
   rts
      
AIH_PassOn:
   move.l   a2,d0                          ; Pass events to next handler
   movem.l  (sp)+,d1-d3/a0-a2              ; Pop registers
   rts
   
;*********************************
;*** Key Status Check Function ***
;*********************************

;Parameters - a0.l - Pointer key status array
;             d1.l - Key code of key to check

;Returns - 1 if down, 0 if up

_ASM_KeyStatus:

   movem.l d1-d2/a0,-(sp)                  ; Stack trashed registers

   move.l  16(sp),a0                       ; Get key status array ptr
   move.l  20(sp),d1                       ; Get key code to check for
   
   move.w  d1,d2                           ; Get copy of key code
   move.w  #0,d0                           ; Default return is 0 (up)
   
   asr.w   #3,d1                           ; d1 = Byte bit is in
   and.w   #7,d2                           ; d2 = bit within byte
   btst    d2,(a0,d1.w)                    ; Check keys bit
   beq     AKS_Ret                         ; If not set then key up

   move.w  #1,d0                           ; Key down so set ret to 1

AKS_Ret:
   movem.l (sp)+,d1-d2/a0                  ; Restore registers from stack
   rts

