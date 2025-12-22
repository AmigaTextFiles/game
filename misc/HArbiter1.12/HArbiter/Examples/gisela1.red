; ANDRZEJ MACIEJCZAK
; (C) LISTOPAD 1992
; UL.ARMII KRAJOWEJ 3/18
; 98-200 SIERADZ,TEL.76-650
;
;	* GISELA1 *
;
         SPL $1       $0      
         DAT $0       $0      
         SUB #1       #64     
         SPL $-1      $-2
         MOV $-3      <-1
         MOV $-4      <-2
         JMN $-3      $-4
         DAT $2       $-2     
         MOV $4       $-4     
         MOV $8       $-8     
         MOV $16      $-16    
         CMP $32      $-32    
         CMP $64      $-64    
         MOV $64      $-64    
         JMP $-26     $11     
         MOV $6       $2
         ADD $11      $1
         MOV #9       $21
         JMP $15      $-5
         JMZ $5       $4
         ADD @-2      $1
START    CMP $96      $-96    
         JMP $-7      <1
         DJN $-3      #16     
         SUB #1       $-6
         MOV $-14     $-4
         ADD <5       $-5
         ADD $5       $5
         ADD $4       $-5
         DJN $-8      #6      
         MOV #-19     $-13
         JMP $8       $-19
         MOV #0       $8      
         MOV $-19     $-16
         CMP $-33     @-13
         JMP $8       $0      
         SUB $-15     $-19
         MOV $-20     @-20
         MOV #7       #7      
         MOV $-39     <-22
         MOV $-40     <-23
         DJN $-2      $-3
         JMP $-23     $0      
         ADD $-22     $-26
         JMP $-7      $0      
