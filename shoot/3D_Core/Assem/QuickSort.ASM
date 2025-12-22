;*******************************************
;**** Quicksort Routine v1.00  02/11/95 ****
;****   Copyright (c) J.Gregory 1995    ****
;*******************************************

;This routine quicksorts an array of long word pairs
;The 1st longword is a 32 bit weight to sort by
;The 2nd longword value related to the weight

;Parameters - a0 - Pointer to 1st element of array
;             d0 - Number of longword pairs (items)


_ASM_QuickSort:                ; **** Call this if Params on Stack ****
   movem.l d0-d7/a0-a6,-(sp)   ; Stack all registers (60 bytes)
   
   move.l  64(sp),a0           ; Get pointer to items array from stack
   move.l  68(sp),d0           ; Get number of items in list to sort   
   bra     AQSStart            ; Skip to main body of quicksort

AQSSort2:                      ; **** Call this if Params in registers ****
   movem.l d0-d7/a0-a6,-(sp)   ; Stack all registers (60 bytes)

AQSStart:
   move.l  #0,d1               ; Low  = 0
   move.l  d0,d2
   subq.l  #1,d2               ; High = Items-1
   jsr     AQS_Sort
   
AQSRet:
   movem.l (sp)+,d0-d7/a0-a6   ; Restore register contents
   rts

;**** Actual recursive sort sub routine ****

; d1.l - Low index
; d2.l - high index

AQS_Sort:
   movem.l d3-d6,-(sp)         ; Stack data important to prev iteration

   move.l  d2,d3               ; Get copy of high
   sub.l   d1,d3               ; Sub low from temp high
   Ble     AQSS_Ret            ; if res <= 0 then nothing to do

   cmp.l   #1,d3               ; if res = 1 goto two item check/swap
   Beq     AQSS_2Item          

   asr.l   #1,d3               ; Divide high-low by 2
   add.l   d1,d3               ; add low to make (d3 = middle index)
   move.l  d3,d4               ; get temp copy of middle index
   move.l  d2,d5               ; get temp copy of high index
   asl.l   #3,d4               ; Multiply middle index by item size (8)
   asl.l   #3,d5               ; Multiply high index by item size (8)

   move.l  4(a0,d4),d6         ; Get middle pointer
   move.l  4(a0,d5),d7         ; Get high pointer
   move.l  d6,4(a0,d5)         ; Write middle value in place of high
   move.l  d7,4(a0,d4)         ; Write high value in place of middle

   move.l  (a0,d4),d6          ; Get middle sort value (d6 = pivot)
   move.l  (a0,d5),d7          ; Get high sort value 
   move.l  d6,(a0,d5)          ; Write middle value in place of high
   move.l  d7,(a0,d4)          ; Write high value in place of middle
   
AQSS_Loop1:
   move.l  d1,d7               ; Init pointer (a1) relating to L
   asl.l   #3,d7
   lea     (a0,d7),a1

   move.l  d2,d7               ; Init pointer (a2) relating to H
   asl.l   #3,d7
   lea     (a0,d7),a2

AQSS_Loop2:
   cmpa.l  a2,a1               ; Compare L with H
   bge     AQSS_Loop3          ; If L >= H end loop
   move.l  (a1),d7             ; Get sort value of item L
   cmp.l   d6,d7               ; Compare item L with pivot
   bgt     AQSS_Loop3          ; If item L > pivot end loop
   adda.w  #8,a1               ; Move pointer in step with L   
   bra     AQSS_Loop2          ; Go back around again
   
AQSS_Loop3:
   cmpa.l  a1,a2               ; Compare H with L
   ble     AQSS_ExChk          ; If H <= L end loop
   move.l  (a2),d7             ; Get sort value of item H
   cmp.l   d6,d7               ; Compare item H with pivot
   blt     AQSS_ExChk          ; If H < pivot end loop
   suba.w  #8,a2               ; Move pointer in step with H
   bra     AQSS_Loop3          ; Go back around again 

AQSS_ExChk:
   cmp.l   a2,a1               ; Compare L with H
   blt     AQSS_Ex             ; If L < H then jump to L/H exchange

   move.l  d2,d5               ; Get temp copy of high
   asl.l   #3,d5
   
   move.l  (a1),d6             ; Get sort val L
   move.l  (a0,d5),d7          ; Get high sort val
   move.l  d6,(a0,d5)          ; Write L in place of High
   move.l  d7,(a1)             ; Write High in place of L

   move.l  4(a1),d6            ; Get pointer L
   move.l  4(a0,d5),d7         ; Get high pointer
   move.l  d6,4(a0,d5)         ; Write L in place of High
   move.l  d7,4(a1)            ; Write High in place of L

   move.l  a1,d3               ; Get L pointer
   sub.l   a0,d3               ; Subtract base pointer
   asr.l   #3,d3               ; Divide by 8 to get index

   move.l  d3,d4               ; Get temp copy of L
   sub.l   d1,d4               ; Sub low from L  (d4 = L-Low)
   move.l  d2,d5               ; Get temp copy of high
   sub.l   d3,d5               ; Sub L from high (d5 = High-L)
   cmp.l   d5,d4               ; Compare (L-low) with (High-L)
   bge     AQSS_Launch2        ; If >= then do 2nd set of recursive sorts
   
AQSS_Launch1:
   move.l  d1,d4               ; d4 = Low
   move.l  d2,d5               ; d5 = High
   move.l  d3,d6
   addq.l  #1,d6               ; d6 = L+1
   subq.l  #1,d3               ; d3 = L-1
   
   move.l  d4,d1               ; Low  = Low
   move.l  d3,d2               ; High = L-1
   jsr     AQS_Sort
   
   move.l  d6,d1               ; Low  = L+1
   move.l  d5,d2               ; High = High
   jsr     AQS_Sort

   bra     AQSS_Ret

AQSS_Launch2:
   move.l  d1,d4               ; d4 = Low
   move.l  d2,d5               ; d5 = High
   move.l  d3,d6
   addq.l  #1,d6               ; d6 = L+1
   subq.l  #1,d3               ; d3 = L-1
     
   move.l  d6,d1               ; Low  = L+1
   move.l  d5,d2               ; High = High
   jsr     AQS_Sort

   move.l  d4,d1               ; Low  = Low
   move.l  d3,d2               ; High = L-1
   jsr     AQS_Sort
    
   bra     AQSS_Ret            ; Return to previous iteration

AQSS_2Item:
   asl.l   #3,d1               ; Multiply low by item size (8)
   asl.l   #3,d2               ; Multiply high by item size (8)
   move.l  (a0,d1),d3          ; Get low sort value
   move.l  (a0,d2),d4          ; Get high sort value
   cmp.l   d4,d3               ; Compare low with high
   Ble     AQSS_Ret            ; If low <= high nothing to do
   move.l  d3,(a0,d2)          ; Write low value into high position
   move.l  d4,(a0,d1)          ; Write high value into low position

   move.l  4(a0,d1),d3         ; Get low pointer
   move.l  4(a0,d2),d4         ; Get high pointer
   move.l  d3,4(a0,d2)         ; Put low pointer into high
   move.l  d4,4(a0,d1)         ; Put high pointer into low
   
AQSS_Ret:
   movem.l (sp)+,d3-d6         ; Restore data important to prev iteration
   rts

;**** L < H so swap Item(L) with Item(H) ****

AQSS_Ex:   
   move.l  (a1),d5             ; Get sort value L
   move.l  (a2),d7             ; Get sort value H
   move.l  d5,(a2)             ; Put L in place of H
   move.l  d7,(a1)             ; Put H in place of L
   
   move.l  4(a1),d5            ; Get pointer L
   move.l  4(a2),d7            ; Get pointer H
   move.l  d5,4(a2)            ; Put L in place of H
   move.l  d7,4(a1)            ; Put H in place of L
   
   bra     AQSS_Loop1          ; branch back to loop 1
