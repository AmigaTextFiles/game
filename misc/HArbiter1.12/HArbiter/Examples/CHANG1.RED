;chang1
;standard CWS'88 i WA'91
;
IMPSTMP    MOV     #0           -1
IMPTRAP    JMP     IMPSTMP
PICKET     DAT                  +9
start      SPL     IMPTRAP
           SPL     SPWNIMP
           ADD     #-16         PICKET
           MOV     #0           @PICKET
           JMP     start
SPWNIMP    SPL     IMP
           JMP     SPWNIMP
IMP        MOV     IMP          1
           END
