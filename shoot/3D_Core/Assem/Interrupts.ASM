;**********************************
;****** Interrupt Code v1.00 ******
;**********************************

;***************************************
;*** Vertical Blank Interrupt Server ***
;***************************************

;_ASM_VertBServer - is an element in the BLank Interupt Server Chain

; Registers - d0,d1 (Scratch)
;             a0    (Scratch, except for highest pri server)
;             a1    (Pointer to is_Data)
;             a5    (Scratch, pointer to interrupt code)    
;             a6    (Scratch)

; is_Data is a pointer to VBData, layout as follows :-

  VBD_Count:    SET 0
  VBD_TermAud0: SET 4
  VBD_TermAud1: SET 8
  VBD_TermAud2: SET 12
  VBD_TermAud3: SET 16
  VBD_SizeOf:   SET 20
  
; The TermAudX fields are the DMA switch off times for the
; respective audio channels

_ASM_VertBServer:
  move.l  #$DFF000,a6           ; Setup custom chips base pointer
  move.l  (a1),d0               ; Get current VBlank time
  addq.l  #1,d0                 ; Increment VBlank time 

AVBS_Aud0:
  cmp.l   VBD_TermAud0(a1),d0   ; Channel 0 off time ?
  blt     AVBS_Aud1             ; If not then skip
  move.w  #DMAF_AUD0,dmacon(a6) ; Turn channel 0 DMA off

AVBS_Aud1:
  cmp.l   VBD_TermAud1(a1),d0   ; Channel 1 off time ?
  blt     AVBS_Aud2             ; If not then skip
  move.w  #DMAF_AUD1,dmacon(a6) ; Turn channel 1 DMA off

AVBS_Aud2:
  cmp.l   VBD_TermAud2(a1),d0   ; Channel 2 off time ?
  blt     AVBS_Aud3             ; If not then skip
  move.w  #DMAF_AUD2,dmacon(a6) ; Turn channel 2 DMA off

AVBS_Aud3:
  cmp.l   VBD_TermAud3(a1),d0   ; Channel 3 off time ?
  blt     AVBS_End              ; If not then skip
  move.w  #DMAF_AUD3,dmacon(a6) ; Turn channel 3 DMA off

AVBS_End:
  move.l  d0,(a1)               ; Write back updated VBlank time
  moveq.l #0,d0                 ; Set Z flag to pass control to next server
  rts
