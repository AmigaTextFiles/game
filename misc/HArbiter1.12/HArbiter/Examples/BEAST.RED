;BEAST
;PIOTR MOZDZYNSKI UL.PRALATOWSKA 6/130
;03-510 W-WA
;WA'91
 
 CO    DAT 0
 START MOV #7    $-1
       MOV @-2   <CEL
       DJN $-1   CO
 CEL   SPL @CEL  200
       ADD #350  CEL
       JMZ START CO
       END 
       
       
