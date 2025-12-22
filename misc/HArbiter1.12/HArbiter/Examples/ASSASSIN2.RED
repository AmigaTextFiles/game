; redcode WA '91
; name  ASSASSIN
; author Aleksander Dudek IVc
; spirala 3-punktowa po 21 procesow na punkt
; nie wygra turnieju, ale powinna troche zamieszac
; slaba przeciwko replikatorom
; poprawiony przez Dominika Kozaczko - poprzednia wersja wysypywala sie
; z powodu drobnego bledu w komilatorze.

; deklaracje stalych

j1      =       1334
j2      =       667

; program wlasciwy

start   spl 1
        spl 1
        spl 1
        spl 1
        spl 1
        mov -1, 0

        jmp <0, imp

        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0
        jmp imp+j1
        jmp imp+j2
        jmp imp+0

imp     mov 0,667
