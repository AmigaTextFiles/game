;***************************************
;***   Collsion Checking Routines    ***
;*** Copyright (c) J.Gregory 1996-97 ***
;***          v2.0 15/03/97          ***
;***************************************

; Params  - Pointer to ColWork struct

; Returns - Array of upto 20 collision LONG pairs as follows :-
;           No Collision                    Type=0
;           Boundary Collsion         BCol  Type=1,Ref=NULL
;           ColArea Collision         ACol  Type=2,Ref=ColArea pointer
;           Fixed WObject Collision   FCol  Type=3,Ref=WObject pointer
;           Transient WObject Coll    TCOL  Type=4,Ref=WObject pointer

; NOTE - Type of 0 Terminates array.  Max colls is 20 so 41st LONG is
;        always a terminator.  

; Collision Priorities in case more than 20 collisions is as follows:-
; BCol,ACol,TCol then FCol (Fixed WObjects are least important)

; Trashes ColWork->R1Start during run

; d0 is set to type of 1st Collison, otherwise 0
         
; a0 = ColWork base pointer
; a1 = ColWork->CW_Ret array base pointer
; a2 = Remaining returns LONG pairs counter (init=10)

; a5 = WObject to ignore 1
; a6 = WObject to ignore 2

; d0 = Focus Wx
; d1 = Focus Wy
; d2 = Focus Height
; d3 = Focus Radius
        
;------------------------------
;   Collsion Check Main Line 
;------------------------------

_ASM_ChkCol:
  movem.l d1-d7/a0-a6,-(sp)   ; Stack Everything except d0 (ret) & SP
  
  move.l  60(sp),a0           ; Get ColWork base pointer (56+4)

  lea     CW_Ret(a0),a1       ; Get returns array base pointer
  move.l  #19,a2              ; Set remaining returns pairs counter
          ;^^ temp set to 19 from 20 for debug checking

  move.l  CW_Wx(a0),d0        ; Get Focus Wx
  move.l  CW_Wy(a0),d1        ; Get Focus Wy
  move.l  CW_Height(a0),d2    ; Get Focus Height
  move.l  CW_Radius(a0),d3    ; Get Focus Radius
  move.l  CW_Ignore1(a0),a5   ; Get Ignore1 WObject pointer
  move.l  CW_Ignore2(a0),a6   ; Get Ignore2 WObject pointer

  jsr     ACC_BCol            ; Check for boundary collisions
  jsr     ACC_ACol            ; Check for ColArea collisions
  jsr     ACC_TCol            ; Check for transient WObject collisions
  jsr     ACC_FCol            ; Check for fixed WObject collsions

  move.l  #0,(a1)+            ; Write terminating NULL to returns array
  move.l  CW_Ret(a0),d0       ; Return 1st Collision type in d0
    
ACC_Ret:
  movem.l (sp)+,d1-d7/a0-a6   ; Get registers back from stack
  rts


;-----------------------------------
;   Check for boundary collisions 
;-----------------------------------

ACC_BCol:
  cmp.l   CW_XMin(a0),d0      ; Check Focus Wx against Min/Max bounds      
  blt     ACCB_Hit
  
  cmp.l   CW_XMax(a0),d0
  bgt     ACCB_Hit

  cmp.l   CW_YMin(a0),d1      ; Check Focus Wy against Min/Max bounds
  blt     ACCB_Hit
  
  cmp.l   CW_YMax(a0),d1
  bgt     ACCB_Hit
  
  cmp.l   CW_HMin(a0),d2      ; Check Focus Height against Min/Max bounds
  blt     ACCB_Hit
  
  cmp.l   CW_HMax(a0),d2
  bgt     ACCB_Hit
  
ACCB_Ret:
  rts

ACCB_Hit:
  move.l  #1,(a1)+            ; Add boundary collision to returns array
  move.l  #0,(a1)+
  suba.l  #1,a2               ; Decrement remaining returns counter
  rts

;----------------------------------
;   Check for ColArea collisions
;----------------------------------

ACC_ACol:
  cmpa.l  #0,a2               ; Return if returns array full
  ble     ACCA_Ret

  move.l  CW_ColArea(a0),a3   ; Get ColArea array base pointer  

ACCA_Loop:
  move.l  CA_Wx(a3),d4        ; Get ColArea Wx  
  beq     ACCA_Ret            ; If Wx=0 then end of array
  bmi     ACCA_Next           ; If Wx<0 then deleted entry so skip

  sub.l   d3,d4               ; Sub Focus Radius from Wx (Lower X)  
  cmp.l   d4,d0               ; Is Focus Wx < Lower X
  blt     ACCA_Next           ; If yes skip to next ColArea

  move.l  CA_Wx2(a3),d4       ; Get ColArea Wx2
  add.l   d3,d4               ; Add Focus Radius to Wx2 (Upper X)
  cmp.l   d4,d0               ; Is Focus Wx > Upper X
  bgt     ACCA_Next           ; If yes skip to next ColArea

  
  move.l  CA_Wy(a3),d4        ; Get ColArea Wy
  sub.l   d3,d4               ; Sub Focus Radius from Wy (Lower Y)
  cmp.l   d4,d1               ; Is Focus Wy < Lower Y
  blt     ACCA_Next           ; If yes skip to next ColArea
  
  move.l  CA_Wy2(a3),d4       ; Get ColArea Wy2
  add.l   d3,d4               ; Add Focus Radius to Wy2 (Upper Y)
  cmp.l   d4,d1               ; Is Focus Wy > Upper Y
  bgt     ACCA_Next           ; If yes skip to next ColArea


  move.l  CA_Floor(a3),d4     ; Get ColArea floor height
  sub.l   d3,d4               ; Sub Focus radius from Floor
  cmp.l   d4,d2               ; Is Focus Height < Floor
  blt     ACCA_Next           ; If yes skip to next ColArea

  move.l  CA_Ceil(a3),d4      ; Get ColArea ceiling height
  add.l   d3,d4               ; Add Focus radius to ceiling height
  cmp.l   d4,d2               ; Is Focus Height > Ceiling
  bgt     ACCA_Next           ; If yes skip to next ColArea


ACCA_Hit:
  move.l  #2,(a1)+            ; Write Collision type code
  move.l  a3,(a1)+            ; Write Collision Ref (*ColArea)
  suba.l  #1,a2               ; Decrement remaing returns space counter
  cmpa.l  #0,a2               ; Is remaining space 0 ??
  beq     ACCA_Ret            ; If yes then end scan

ACCA_Next:
  adda.l  #CA_SizeOf,a3       ; Move to next entry in array
  bra     ACCA_Loop           ; Go back to top of loop

ACCA_Ret:
  rts


;---------------------------------------
;   Scan for Fixed WObject collisions 
;---------------------------------------

ACC_FCol:
  cmpa.l  #0,a2               ; Is returns array full ?
  ble     ACCF_Ret            ; If yes then return

  move.l  CW_R1Start(a0),d4   ; Get Row Start
  move.l  CW_R1End(a0),d5     ; Get Row End
  jsr     ACCF_ScanRow        ; Scan First SP Row

  move.l  CW_R2Start(a0),d4   ; Get Row Start
  move.l  CW_R2End(a0),d5     ; Get Row End
  jsr     ACCF_ScanRow        ; Scan Second SP Row

ACCF_Ret:
  rts

;--- Check SP Row ---

; Stores a7 (sp)  temporarily in CW_R1Start so can be used

ACCF_ScanRow:
  cmpa.l  #0,a2               ; Exit if no returns data space remains
  beq     ACCF_Ret

  move.l  CW_SpcPart(a0),a3   ; Get SP Pointers table base address
  move.l  a0,-(sp)            ; Stack work struct base pointer

ACCFSR_Loop:
  cmp.l   d5,d4               ; Is current pos > row End ??
  bgt     ACCFSR_Ret          ; If yes then nothing to check so return
  
  move.l  (a3,d4*4),a4        ; Get WObject pointer
  cmpa.l  #0,a4               ; Is WObject pointer=NULL ??
  beq     ACCFSR_Next         ; If yes then skip to next
  
  cmpa.l  a5,a4               ; Is WObject=Ignore1 ??    
  beq     ACCFSR_Next         ; If yes then skip to next
  
  cmpa.l  a6,a4               ; Is WObject=Ignore2 ??
  beq     ACCFSR_Next         ; If yes then skip to next
  
  move.l  WO_Radius(a4),a0    ; Get WObject Radius & Skip if =0
  cmpa.l  #0,a0               ; Is radius<=0 ??
  ble     ACCFSR_Next         ; If yes skip to next WObject
  adda.l  d3,a0               ; Add Focus Radius to WObject Radius
  
  
  move.l  WO_Wx(a4),d6        ; Get WOb Wx
  move.l  d6,d7               ; Get temp copy of Wx
  sub.l   a0,d7               ; Sub Radius's from Wx (=Lower X bound)
  cmp.l   d7,d0               ; Is Focus Wx < Lower X bound 
  blt     ACCFSR_Next         ; If yes then skip to next
  
  add.l   a0,d6               ; Add radius's to Wx (=Upper X bound)
  cmp.l   d6,d0               ; Is Focus Wx > Upper X bound
  bgt     ACCFSR_Next         ; If yes then skip to next


  move.l  WO_Wy(a4),d6        ; Get WOb Wy
  move.l  d6,d7               ; Get temp copy of Wy
  sub.l   a0,d7               ; Sub Radius's from Wy (=Lower Y bound)
  cmp.l   d7,d1               ; Is Focus Wy < Lower Y bound
  blt     ACCFSR_Next         ; If yes then skip to next

  add.l   a0,d6               ; Add radius's to Wy (=Upper Y bound)
  cmp.l   d6,d1               ; Is Focus Wy > Upper Y bound
  bgt     ACCFSR_Next         ; If yes then skip to next


  move.l  WO_Height(a4),d6    ; Get WOb Height
  move.l  d6,d7               ; Get temp copy of Height
  sub.l   a0,d7               ; Sub Radius's from Height (=Floor)
  cmp.l   d7,d2               ; Is Foucs Height < Floor
  blt     ACCFSR_Next         ; If yes then skip to next
  
  add.l   a0,d6               ; Add Radius's to Height (=Ceiling)
  cmp.l   d6,d2               ; IS Focus Height > Ceiling
  bgt     ACCFSR_Next         ; If yes then skip to next
  
  
ACCFSR_Hit:  
  move.l  #3,(a1)+            ; Write FCol return type
  move.l  a4,(a1)+            ; Write Out WObject pointer
  suba.l  #1,a2               ; Decrement returns data space counter
  cmpa.l  #0,a2               ; Is returns data space full ??
  beq     ACCFSR_Ret
  
ACCFSR_Next:
  addq.l  #1,d4               ; Increment current pos 
  bra     ACCFSR_Loop         ; go around again

ACCFSR_Ret:
  move.l  (sp)+,a0            ; Restore work struct base pointer  
  rts

;-------------------------------------------
;   Scan for Transient WObject collisions
;-------------------------------------------

ACC_TCol:
  cmpa.l  #0,a2               ; Is returns array full ?
  ble     ACCT_Ret            ; If yes then return
  move.l  CW_WObject(a0),a3   ; Get Pointer to 1st WObject to check

ACCT_Loop:
  cmpa.l  #0,a3               ; Is WObject pointer=NULL    
  beq     ACCT_Ret            ; If yes then no more to check

  cmpa.l  a5,a3               ; Is WObject=Ignore1
  beq     ACCT_Next           ; If yes then skip to next
  
  cmpa.l  a6,a3               ; Is WObject=Ignore2
  beq     ACCT_Next           ; If yes then skip to next
  
  move.l  WO_Radius(a3),d4    ; Get WObjects Radius
  ble     ACCT_Next           ; If Radius<=0 not collisionable so skip
  add.l   d3,d4               ; Add Focus Radius to WObject Radius
  
  move.l  WO_Wx(a3),d5        ; Get WObject Wx
  move.l  d5,d6               ; Get temp copy of Wx
  sub.l   d4,d6               ; Sub Radius's from Wx (=Lower X bound)
  cmp.l   d6,d0               ; Is Focus Wx < Lower X bound
  blt     ACCT_Next           ; If yes then skip to next
  
  add.l   d4,d5               ; Add Radius's to Wx (=Upper X bound)
  cmp.l   d5,d0               ; Is Focus Wx > Upper X bound
  bgt     ACCT_Next           ; If yes then skip to next
  
  
  move.l  WO_Wy(a3),d5        ; Get WObject Wy
  move.l  d5,d6               ; Get temp copy of Wy
  sub.l   d4,d6               ; Sub Radius's from Wy (=Lower Y bound)
  cmp.l   d6,d1               ; Is Focus Wy < Lower Y bound
  blt     ACCT_Next           ; If yes then skip to next
  
  add.l   d4,d5               ; Add Radius's to Wy (=Upper Y bound)
  cmp.l   d5,d1               ; Is Focus Wy > Upper Y bound
  bgt     ACCT_Next           ; If yes then skip to next
   
  
  move.l  WO_Height(a3),d5    ; Get WObject Height
  move.l  d5,d6               ; Get temp copy of Height
  sub.l   d4,d6               ; Sub Radius's form Height (=Floor)
  cmp.l   d6,d2               ; Is Focus Height < Floor
  blt     ACCT_Next           ; If yes then skip to next
  
  add.l   d4,d5               ; Add Radius's to Height (=Ceiling)
  cmp.l   d5,d2               ; Is Focus Height > Ceiling
  bgt     ACCT_Next           ; If yes then skip to next
  
  
ACCT_Hit:
  move.l  #4,(a1)+            ; Write out TCol type
  move.l  a3,(a1)+            ; Write out WObject pointer
  suba.l  #1,a2               ; Decrement remaining returns space
  cmpa.l  #0,a2               ; Is there any space remianing ??
  ble     ACCT_Ret            ; If not then exit
  
ACCT_Next:
  move.l  WO_Prev(a3),a3      ; Move back down link list
  bra     ACCT_Loop           ; Go around again
  
ACCT_Ret:
  rts

