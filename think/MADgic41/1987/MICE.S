;      MICE.S
;      CHIP    WENDELL
;
       JMP     ORG
PTR    DAT     #0
ORG    MOV     #12,    PTR
LOOP   MOV     @PTR,   <COPY
       DJN     LOOP,   PTR
       SPL     @COPY
       ADD     #635,   COPY
       JMZ     ORG,    PTR
COPY   DAT     833
       END
