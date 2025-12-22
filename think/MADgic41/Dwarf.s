;      Dwarf.s
;
;      by A. K. Dewdney
;      May 1984
;
       JMP     LOOP
BOMB   DAT             #0
LOOP   MOV     BOMB,   @BOMB
       SUB     #4,     BOMB
       JMP     LOOP
       END