;Dude
;standard CWS'88 i WA'91
I       MOV     #0        -1
J       JMP     I
        MOV     TRP2      J
C3      DAT               0
start   MOV     #0        CNT
        MOV     #201      C2
        MOV     #-99      C3
LOOP    MOV     <CNT      <C2
        MOV     BMB       <C3
        CMP     #-16      CNT
C2      JMP     LOOP      0
        MOV     CNT       @C3
TTT     SPL     188
        JMP     I
TRP2    JMP     TTT
BMB     SPL     BMB
CNT     DAT                0
        END
