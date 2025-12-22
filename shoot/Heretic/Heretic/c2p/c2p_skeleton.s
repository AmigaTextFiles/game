;This is skeleton for external c2p modules
;3 functions must be provided:
; C2P_Init
; C2P_CleanUp
; C2P_Do
;

; this in plugin module, cannot be started as any other program
        moveq   #0,d0
        rts

; Do not change this:

        dc.b    "C2P",0                 ;module id, MUST BE 'C2P'!!!
        dc.l    C2P_Init                ; pointer to init routine
        dc.l    C2P_CleanUp             ;pointer to de-init routine
        dc.l    C2P_Do                  ;pointer to main c2p function
        dc.l    0

        cnop    0,4
C2P_Init
; Here you can do all initializations needed by yours c2p
; In:
;  d0.l SCREENWIDTH
;  d1.l SCREENHEIGHT
; Out:
;  0  - something went wrong
;  1  - Init ok, C2P supports every resolution
;  2  - Init ok, C2P supports only 320x200 resolution.

        rts

        cnop    0,4
C2P_CleanUp
; Here you should clean all things you have made in C2P_Init 
; (like freeing memory, etc.)

        rts

        cnop    0,4
C2P_Do
;Core c2p routine.
;
; In:
;  a0.l - pointer to chunky in fastmem. (SCREENWIDTH*SCREENHEIGHT)
;  a1.l - pointer to INTERLEAVED bitplanes
; Out:
;  None

        rts
