;
;*********************************
;** Chunky Sprite Scaler v2.01  **
;**   Copyright(c) J.Gregory    **
;**          04/06/95           **
;*********************************

; Entry parameters : a0 - Pointer to working sprite structure (on stack)
;                    a1 - Pointer to chunky screen line table (on stack) 
;				             Preserves all registers

;*****************************				 
;** Working sprite sructure **
;*****************************
 
; 0   WORD  ID
; 2   WORD  Width
; 4   WORD  Height
; 6   LONG  Size
; 10	WORD  XCentre
; 12	WORD  YCentre
; 14	WORD  Scale
; 16	WORD  ScaledWidth
; 18	WORD  ScaledDepth
; 20	WORD  ScaledX
; 22	WORD  ScaledY
; 24	ULONG *SpritePointer
; 28  ULONG *SprireLineTable
; 32+ Defined in C can just ignore here though
					 
_ASM_ScaleSpriteN:
  movem.l d0-d7/a0-a6,-(sp)   ; Stack all registers (60 bytes)
   
  move.l  64(sp),a0           ; Get 1st param from stack (+4 for ret addr) 
  move.l  68(sp),LineTab      ; Store 2nd param (linetab pointer)

	move.w	2(a0),d3	      		; Get source width
	move.w	4(a0),d4			      ; Get source height	

	move.w  10(a0),d0			      ; Get X centre
  cmp.w   #COORDRNG,d0        ; Make Sure XCentre within valid range    
  bgt     ScaleNormRet
  cmp.w   #0-COORDRNG,d0
  ble     ScaleNormRet

	move.w  12(a0),d1			      ; Get Y centre
  cmp.w   #COORDRNG,d1        ; Make Sure YCentre within valid range    
  bgt     ScaleNormRet
  cmp.w   #0-COORDRNG,d1
  ble     ScaleNormRet
      
	move.w  14(a0),d2			      ; Get scale		
	
	move.w	#9,d7				        ; Set d7 as shift count for divide (>>9)

	move.w	d3,d5				        ; Make copy of width
	muls.w	d2,d5				        ; Multiply by scale
	asr.l	  d7,d5				        ; Divide by 512 (>>9) to get scaled width
	move.w	d5,16(a0)			      ; Store scaled width
  ble     ScaleNormRet        ; If Scaled width < 0 then exit  

	move.w	d4,d6				        ; Make copy of depth
	muls.w	d2,d6				        ; Multiply by scale
	asr.l   d7,d6				        ; Divide by 512 (>>9) to get scaled height
	move.w	d6,18(a0)			      ; Store scaled height
  ble     ScaleNormRet        ; If scaled height <= 0 then exit
	
	asr.w	  #1,d5				        ; Divide width by 2 (>>1)
	asr.w	  #1,d6				        ; Divide height by 2 (>>1)	
	sub.w	  d5,d0				        ; ScrX(d0) = XCentre(d0) - .5*ScaledWidth(d5)
	sub.w	  d6,d1				        ; ScrY(d1) = YCentre(d1) - .5*ScaledHeight(d6)

	clr.l	  d5					        ; Scaled sprite x offset = 0 (d5)
	cmp.w	  #0,d0				        ; Is ScrX >= 0 ?
	bge		  NoLeftOH			      ; If yes then skip left overhang stuff
	
	neg.w   d0					        ; Calc size of left overhang (loh=0-scrX)
	move.w	d0,d5				        ; Get copy of left overhang size 
	clr.w   d0					        ; ScrX = 0 (d0)
	
NoLeftOH:
	clr.l   d6					        ; Scaled sprite y offset = 0 (d6)
	cmp.w   #0,d1				        ; Is Scr Y >=0 ?
	bge     NoTopOH			        ; If yes then skip top overhang stuff

	neg.w	  d1					        ; Calc size of top overhang (toh=0-scry)
	move.w	d1,d6				        ; Get copy of top overhang size
	clr.w	  d1					        ; ScrY = 0 (d1)
	
NoTopOH:
	move.w	d0,20(a0)			      ; Store scaled sprite x pos
	move.w	d1,22(a0)			      ; Store scaled sprite y pos
	
	;*****************************
	;** Current register status **
	;*****************************
	
	;d0 - Scaled sprite X (left edge) 
	;d1 - Scaled sprite Y (top edge)
	;d2 - Scale
	;d3 - Source sprite width
	;d4 - Source sprite height
	;d5 - Starting X offset within scaled sprite
	;d6 - starting Y offset within scaled sprite
	;d7 - Shift count (512)
	;a0 - Pointer to source sprite structure
	
	;Scaled sprite Width,Height,XPos & YPos stored back to sprite struct
	
	;*********************************************
	;** Copy sprite to chunky map while scaling **
	;*********************************************

ScaleDown:
	
	;** Calculate base pointers into screen & sprite **

	move.l	d0,a3				        ; Store d0

	move.w	d5,d0				        ; Get copy of x offset into scaled sprite
	and.l	  #$FFFF,d0			      ; Clear high word of scaled x offset
	and.l	  #$FFFF,d2			      ; Clear high word of scale
  swap    d0                  ; Multiply by 65536 (<<16)
	divs.l	d2,d0				        ; Divide by scale to get source HP x offset
  asl.l	  d7,d0				        ; Multiply by 512 (<<9)
	move.l	d0,a1				        ; Store source sprite HP start value (X)

	move.w	d6,d0				        ; Get copy of y offset into scaled sprite
	and.l	  #$FFFF,d0			      ; Clear high word
  swap    d0                  ; Multiply by 65536 (<<16)
	divs.l	d2,d0				        ; Divide by scale to get source y offset
	asl.l	  d7,d0				        ; Multiply by 512 (<<9)
	move.l	d0,a4				        ; Store source sprite HP Start value (Y)

	move.l	a3,d0				        ; Restore d0
	
	move.l	LineTab,a2			    ; Pointer to chunky screen Line pointer table
	move.w	d1,d7				        ; Temp(d7) = ScrY(d1)
	lsl.w	  #2,d7				        ; Multiply by 4
	move.l	(a2,d7.w),a2		    ; Pointer to 1st line in chunky map to be used
	adda.w	d0,a2				        ; Add X Offset to chunky map pointer

	;** Calculate Vertical Interploation Info ** 

SDCalcYData:		
	move.w	d4,d7				        ; Get copy of source height
	and.l	  #$FFFF,d7			      ; Clear high word
	swap	  d7					        ; Swap to effectively <<16
	move.w	18(a0),d2			      ; Get scaled height
	and.l	  #$FFFF,d2			      ; Clear high word
	divs.l	d2,d7				        ; Y inc = (Src height << 16) / (Scaled height)

	sub.w	  d6,d2				        ; Sub Y offset into scaled from scaled height
	move.w	d2,d4				        ; Take copy of depth
	add.w	  d1,d4				        ; Add scaled sprite Y (top edge)
	sub.w	  #height,d4			    ; Subtract screen depth to get bottom overhang
	ble		  SDCalcXData			    ; If negative overhang height ok
	sub.w	  d4,d2				        ; If +overhang subtract it from bottom
		
	; d7.l - High precision (<<16) Y increment
	; d2.w - Number of pixels to process in Y direction

	;** Calc Horizontal feed back data **
	
SDCalcXData:
	move.w	d3,d6				        ; Get copy of souce width
	and.l	  #$FFFF,d6			      ; Clear high word
	swap	  d6					        ; Swap equivalent of <<16
	move.w	16(a0),d4			      ; Get scaled width
	and.l	  #$FFFF,d4			      ; Clear high word
	divs.l	d4,d6				        ; X inc = (Src width << 16) / (Scaled width)
	
	sub.w	  d5,d4				        ; Sub X offset into scaled from scaled width
	move.w	d4,d5				        ; Take copy right edge co-ord
	add.w	  d0,d5				        ; Add scaled sprite X (left edge)
	sub.w	  #width,d5			      ; Subtract screen width to get right overhang
	ble		  SDCalcFinal			    ; if negative overhang then width ok
	sub.w	  d5,d4				        ; If +overhang subtract it from right

	; d6.l - High precision (<<16) X increment
	; d4.l - Number of pixels to process in X direction

	;** Do final scale down setup **

SDCalcFinal:
  clr.l   d3                  ; Clear reg to hold screen line modulo
  move.w  #width,d3           ; Get width of screen
  sub.w   d4,d3               ; Sub plotted width to get screen modulo

	move.l	a4,d1				        ; Initialise High precision Y counter 
  move.l  28(a0),a4           ; Make copy of sprite line table base
	subq.w	#1,d2				        ; Decrement Y pixel count for use with DBRA
	bmi		  ScaleNormRet		    ; If no pixels visible in Y direction exit
	subq.w	#1,d4				        ; Decrement X pixel count for use with DBRA
	bmi		  ScaleNormRet	      ; If no pixels visible in X direction exit
	
	;** Vertical column calculation **

SDLoop1:
	swap	  d1					        ; Reduce Y counter to normal precison
  move.w  d1,d5               ; Get current y offset
  lsl.w   #2,d5               ; Multiply by 4 to get line table offset
  move.l  (a4,d5.w),a3        ; Get pointer from table to line start
	swap	  d1					        ; Revert Y counter to high precision(HP)
	
	jsr		SDCopy				        ; Call copy line routine
	  
	adda.l	d3,a2   			      ; Move chunky screen pointer down a line
	add.l	  d7,d1				        ; Add HP Y Increment to HP Y counter
	dbra	  d2,SDLoop1			    ; Loop until no more Y's to process
	bra     ScaleNormRet        ; Exit

	;** Copy line of pixels to chunky map **

SDCopy:
	move.l	d4,a5				        ; Temp store X pixel counter
	move.l	a1,d0				        ; Init HP X Counter

SDCLoop1:
	swap	  d0					        ; Reduce X counter to normal precision
	move.b	(a3,d0.w),d5		    ; Load pixel from source sprite
	beq		  SDCSkip1			      ; If transparent (0) dont write 

;  jsr     CheckBound          ; ****** Call debuging routine ******

 	move.b	d5,(a2)+	          ; Write non transparant pixel		

	swap	  d0					        ; Revert X counter to HP
	add.l	  d6,d0				        ; Add HP X increment to HP X counter
	dbra	  d4,SDCLoop1			    ; Loop until no more X's to process
	
	move.l	a5,d4				        ; Restore X pixel counter
	rts

SDCSkip1:						          ; ** Skip writing transparant pixel **
	addq.w	#1,a2				        ; Increment chunky screen pointer		
	swap	  d0					        ; Revert X counter to HP
	add.l	  d6,d0				        ; Add HP X increment to HP X counter
	dbra	  d4,SDCLoop1			    ; Loop until no more X's to process
	
	move.l	a5,d4				        ; Restore X pixel counter
	rts

ScaleNormRet:
  movem.l (sp)+,d0-d7/a0-a6   ; Restore register contents
	rts



;****************************************************
;******* Temporary Write Bounds Checking Code *******
;****************************************************

;To add this code in to check pixel writes exchange following :-
;Replace: move.b d5,(a2)+ with: jsr CheckBound  

;Sets ID of chunkwork to 0 if traps an illegal write

CheckBound:
  movem.l a3-a4,-(sp)
  
  move.l  LineTab,a3          ; Get Address of screen's line table        
  move.l  (a3),a3             ; Get pointer to chunky screen base
  move.l  a3,a4               ; Get copy of base pointer
  adda.l  #width*height,a4    ; Add screen size to get end pointer

  cmpa.l  a2,a3               ; Compare target with lower bound
  bgt     CB_Err              ; Below lower bound so set error  
  cmpa.l  a2,a4               ; Compare target with upper bound
  blt     CB_Err              ; Above upper bound so set error

  move.b  d5,(a2)+
  
CB_Ret:
  movem.l (sp)+,a3-a4
  rts  

CB_Err:
  addq.w  #1,a2               ; Increment Chunky screen pointer
  move.w  #0,(a0)             ; Set ID to 0 (Error flag)
  bra     CB_Ret              

;*****************************************************
;*****************************************************
