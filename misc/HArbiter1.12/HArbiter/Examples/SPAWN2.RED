; Spawn II - Return of the Phantom
; Dominik Kozaczko
; Troszke zmian i ulepszen
.WA91
start:  SPL             WP
WT:     SPL     $7      #-1      
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-38
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-75
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-112
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-149
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-186
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-223
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-260
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-297
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-334
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-371
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-408
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-445
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-482
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-519
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-556
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-593
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-630
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-666
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-704
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-741
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-778
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-815
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-852
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-889
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-926
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-963
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-1000
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-1037
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $7      #-1074
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #-1111
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        DAT     $0      #-1148
        MOV     $4         <-1
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
op1:    DAT             $500
        DAT             $0
        DAT             $0
        DAT             $0
op2:    DAT             $999
        DAT             $0
        DAT             $0
        DAT             $0
ratunku: MOV    imp     <op1            ; Swego rodzaju deska ratunkowa
        SPL     <op1                    ; Schowana w srodku...
        MOV     jum     <op2            ; ...dla bezpieczenstwa.
        SPL     <op2
        DAT             $0
        DAT             $0
        DAT             $0
imp:    MOV     $0      $1
        DAT             $0
        DAT             $0
jum:    JMP     $0
        DAT             $0
        DAT             $0
        DAT             $0
WP:     SPL     $8      #177
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #172
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #167
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #162
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #157
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #152
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #147
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #142
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #137
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #132
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #127
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #122
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #117
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #112
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #107
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #102
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #97
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #92
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #87
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #82
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #77
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #72
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #67
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #62
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #57
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #52
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #47
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #42
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #37
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $8      #32
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        SPL     $9      #27
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        DAT             $0
        DAT             $0
        DAT             $0
        DAT             $22
        MOV     $4         @-1
        ADD     #31      $-2
        SPL     ratunku
        JMP     $-3
        END
