;
;****************************************
;** Chunky Sprite Sliver Scaler v2.01  **
;**       Copyright(c) J.Gregory       **
;**              20/03/96              **
;****************************************

;NOTE This variant does no X scaling i.e. it scale the 1st
;     coloum of pixel accross entire width.  This is fast
;     so can be used for scaled sprite walls etc.

; Source Image data is only 1 pixel wide but draw width can be more 

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
					 
_ASM_ScaleSpriteT:
  movem.l d0-d7/a0-a6,-(sp)   ; Stack all registers (60 bytes)
   
  move.l  64(sp),a0           ; Get 1st param from stack (+4 for ret addr) 
  move.l  68(sp),LineTab      ; Store 2nd param (linetab pointer)

	move.w	2(a0),d3	      		; Get source width
	move.w	4(a0),d4			      ; Get source height	

	move.w  10(a0),d0			      ; Get X centre
  cmp.w   #COORDRNG,d0        ; Make Sure XCentre within valid range    
  bgt     ScaleNormRet2
  cmp.w   #0-COORDRNG,d0
  ble     ScaleNormRet2

	move.w  12(a0),d1			      ; Get Y centre
  cmp.w   #COORDRNG,d1        ; Make Sure YCentre within valid range    
  bgt     ScaleNormRet2
  cmp.w   #0-COORDRNG,d1
  ble     ScaleNormRet2
      
	move.w  14(a0),d2			      ; Get scale		
	
	move.w	#9,d7				        ; Set d7 as shift count for divide (>>9)

	move.w	d3,d5				        ; Make copy of width
	muls.w	d2,d5				        ; Multiply by scale
	asr.l	  d7,d5				        ; Divide by 512 (>>9) to get scaled width
	move.w	d5,16(a0)			      ; Store scaled width
  ble     ScaleNormRet2       ; If Scaled width < 0 then exit  

	move.w	d4,d6				        ; Make copy of depth
	muls.w	d2,d6				        ; Multiply by scale
	asr.l   d7,d6				        ; Divide by 512 (>>9) to get scaled height
	move.w	d6,18(a0)			      ; Store scaled height
  ble     ScaleNormRet2       ; If scaled height <= 0 then exit
	
	asr.w	  #1,d5				        ; Divide width by 2 (>>1)
	asr.w	  #1,d6				        ; Divide height by 2 (>>1)	
	sub.w	  d5,d0				        ; ScrX(d0) = XCentre(d0) - .5*ScaledWidth(d5)
	sub.w	  d6,d1				        ; ScrY(d1) = YCentre(d1) - .5*ScaledHeight(d6)

	clr.l	  d5					        ; Scaled sprite x offset = 0 (d5)
	cmp.w	  #0,d0				        ; Is ScrX >= 0 ?
	bge		  NoLeftOH2 		      ; If yes then skip left overhang stuff
	
	neg.w   d0					        ; Calc size of left overhang (loh=0-scrX)
	move.w	d0,d5				        ; Get copy of left overhang size 
	clr.w   d0					        ; ScrX = 0 (d0)
	
NoLeftOH2:
	clr.l   d6					        ; Scaled sprite y offset = 0 (d6)
	cmp.w   #0,d1				        ; Is Scr Y >=0 ?
	bge     NoTopOH2		        ; If yes then skip top overhang stuff

	neg.w	  d1					        ; Calc size of top overhang (toh=0-scry)
	move.w	d1,d6				        ; Get copy of top overhang size
	clr.w	  d1					        ; ScrY = 0 (d1)
	
NoTopOH2:
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

ScaleDown2:
	
	;** Calculate base pointers into screen & sprite **

	move.l	d0,a3				        ; Store d0

  and.l	  #$FFFF,d2			      ; Clear high word of scale
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

SDCalcYData2:		
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
	ble		  SDCalcXData2		    ; If negative overhang height ok
	sub.w	  d4,d2				        ; If +overhang subtract it from bottom
		
	; d7.l - High precision (<<16) Y increment
	; d2.w - Number of pixels to process in Y direction

	;** Calc Horizontal feed back data **
	
SDCalcXData2:
  move.w	16(a0),d4			      ; Get scaled width
  and.l   #$FFFF,d4			      ; Clear high word
	
	sub.w	  d5,d4				        ; Sub X offset into scaled from scaled width
	move.w	d4,d5				        ; Take copy right edge co-ord
	add.w	  d0,d5				        ; Add scaled sprite X (left edge)
	sub.w	  #width,d5			      ; Subtract screen width to get right overhang
	ble		  SDCalcFinal2		    ; if negative overhang then width ok
	sub.w	  d5,d4				        ; If +overhang subtract it from right

	; d4.l - Number of pixels to process in X direction

	;** Do final scale down setup **

SDCalcFinal2:
  clr.l   d3                  ; Clear reg to hold screen line modulo
  move.w  #width,d3           ; Get width of screen
  sub.w   d4,d3               ; Sub plotted width to get screen modulo

	move.l	a4,d1				        ; Initialise High precision Y counter 
  move.l  28(a0),a4           ; Make copy of sprite line table base
	subq.w	#1,d2				        ; Decrement Y pixel count for use with DBRA
	bmi		  ScaleNormRet2		    ; If no pixels visible in Y direction exit
	subq.w	#1,d4				        ; Decrement X pixel count for use with DBRA
	bmi		  ScaleNormRet2	      ; If no pixels visible in X direction exit
	
	;** Vertical column calculation **

SDTLoop1:
	swap	  d1					        ; Reduce Y counter to normal precison
  move.w  d1,d5               ; Get current y offset
  lsl.w   #2,d5               ; Multiply by 4 to get line table offset
  move.l  (a4,d5.w),a3        ; Get pointer from table to line start
	swap	  d1					        ; Revert Y counter to high precision(HP)
	
	jsr		SDTCopy				        ; Call copy line routine
	  
	adda.l	d3,a2   			      ; Move chunky screen pointer down a line
	add.l	  d7,d1				        ; Add HP Y Increment to HP Y counter
	dbra	  d2,SDTLoop1			    ; Loop until no more Y's to process
	bra     ScaleNormRet2       ; Exit

	;** Copy line of pixels to chunky map **

SDTCopy:
	move.l	d4,d6				        ; Get copy X pixel counter (width)
 	move.b	(a3),d5		          ; Load pixel from source sprite
	beq		  SDTCSkip1			      ; If transparent (0) dont write 

SDTCLoop1:
 	move.b	d5,(a2)+	          ; Write non transparant pixel		
	dbra	  d6,SDTCLoop1  	    ; Loop until no more X's to process	
	rts

SDTCSkip1:					          ; ** Skip writing transparant row of pixels **
	add.w	  d4,a2				        ; Increment chunky screen pointer			
  addq.w  #1,a2               ; Add 1 because D4 0 based
	rts

ScaleNormRet2:
  movem.l (sp)+,d0-d7/a0-a6   ; Restore register contents
	rts

