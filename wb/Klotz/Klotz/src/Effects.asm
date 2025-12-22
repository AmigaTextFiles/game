*
*   $VER: Effects.asm	0.4 (15.10.94)
*			0.1 (13.10.94)
*
*   Ausblendeffekte

SYMF_X	equ 1	; X-Symmetrie
SYMF_Y	equ 2	; Y-Symmetrie
FLAG_WAIT   equ 4   ; Nach jeder Ausgabe warten ?

TOKEN_WAIT  equ -1
TOKEN_END   equ -2
DoFX
*  =>	 a0: Effektdaten
*	 a1: RastPort
*	 d2: FarbFlag
*
    push    all
    copy.l  GfxBase,a6
    move.b  (a0)+,d4        ; FLAGS
    moveq   #0,d0
.loop
    moveq   #0,d3
    move.b  (a0)+,d3
    cmpi.b  #TOKEN_END,d3
    beq     .exitloop
    move.b  d4,d5
    andi.b  #FLAG_WAIT,d5
    bne     .wait
    cmpi.b  #TOKEN_WAIT,d3
    bne     .nowait
.wait
    push    d0-d1/a0-a1
    CALL    WaitTOF
    pop     d0-d1/a0-a1
    moveq   #6,d0
    bsr     RangeRand
    move.l  d0,d2
    cmpi.b  #TOKEN_WAIT,d3
    beq     .loop
.nowait
    moveq   #0,d1
    move.l  d3,d0
    divu    #10,d0
    move.b  d0,d1
    swap    d0
    andi.l  #$f,d0
    andi.l  #$1f,d1
    addq.b  #1,d0
    addq.b  #1,d1
    bsr     PutKlotz
    move.b  d4,d5
    andi.b  #SYMF_X|SYMF_Y,d5	    Keine Symmetrie
    beq     .loop
    move.b  d4,d5
    andi.b  #SYMF_X,d5
    beq     .nox
    subi.b  #11,d0
    neg.b   d0
.nox
    move.b  d4,d5
    andi.b  #SYMF_Y,d5
    beq     .noy
    subi.b  #19,d1
    neg.b   d1
.noy
    bsr     PutKlotz
    bra     .loop
.exitloop
    pop     all
    rts
DoRNDFX
* Zufällige Ausblenddaten aussuchen
*  =>	 a1: RastPort
*
*
    push    d0
    moveq   #6,d0	       ; verrückte farben ??
    bsr     RangeRand
    move.l  d0,d2
    moveq   #NUM_FX-1,d0
    bsr     RangeRand
    add.l   d0,d0
    lea     FXList(pc),a0
    add.w   0(a0,d0.w),a0
    pop     d0
    bra     DoFX
NUM_FX	    equ     8
FXList
    dc.w    Vorhang-FXList
    dc.w    Bounce-FXList
    dc.w    Kamm-FXList
    dc.w    Gate-FXList
    dc.w    Schlange-FXList
    dc.w    Spirale1-FXList
    dc.w    Spirale2-FXList
    dc.w    Kamm2-FXList
* Effekt-Daten
* Aufbau : Symmetrie-Flags , (x-1)+(y-1)*10 ={ 0 ,..,179} 0: links unten usw

Vorhang:
 dc.b SYMF_X
 dc.b		      170,TOKEN_WAIT,TOKEN_WAIT
 dc.b		  171,160,TOKEN_WAIT,TOKEN_WAIT
 dc.b	      172,161,150,TOKEN_WAIT,TOKEN_WAIT
 dc.b	  173,162,151,140,TOKEN_WAIT,TOKEN_WAIT
 dc.b 174,163,152,141,130,TOKEN_WAIT,TOKEN_WAIT
 dc.b 164,153,142,131,120,TOKEN_WAIT,TOKEN_WAIT
 dc.b 154,143,132,121,110,TOKEN_WAIT,TOKEN_WAIT
 dc.b 144,133,122,111,100,TOKEN_WAIT,TOKEN_WAIT
 dc.b 134,123,112,101,90,TOKEN_WAIT,TOKEN_WAIT
 dc.b 124,113,102,91,80,TOKEN_WAIT,TOKEN_WAIT
 dc.b 114,103,92,81,70,TOKEN_WAIT,TOKEN_WAIT
 dc.b 104,93,82,71,60,TOKEN_WAIT,TOKEN_WAIT
 dc.b  94,83,72,61,50,TOKEN_WAIT,TOKEN_WAIT
 dc.b  84,73,62,51,40,TOKEN_WAIT,TOKEN_WAIT
 dc.b  74,63,52,41,30,TOKEN_WAIT,TOKEN_WAIT
 dc.b  64,53,42,31,20,TOKEN_WAIT,TOKEN_WAIT
 dc.b  54,43,32,21,10,TOKEN_WAIT,TOKEN_WAIT
 dc.b  44,33,22,11,0,TOKEN_WAIT,TOKEN_WAIT
 dc.b  34,23,12,1,TOKEN_WAIT,TOKEN_WAIT
 dc.b  24,13,2,TOKEN_WAIT,TOKEN_WAIT
 dc.b  14,3,TOKEN_WAIT,TOKEN_WAIT
 dc.b	4,TOKEN_END
* 14.10.94 - 00.15 Chrrrr...
Bounce:
 dc.b SYMF_X!FLAG_WAIT
 dc.b 179,168,157,146,135,124,113,102,91,80,70,61,52
 dc.b 43,34,25,16,7,8,19,29,38,47,56,65,74,83
 dc.b 92,101,110,120,131,142,153,164,175,176,167,158
 dc.b 149,139,128,117,106,95,84,73,62,51,51,40,30,21,12
 dc.b 3,4,15,26,37,48,59,69,78,87,96,105,114,123
 dc.b 132,141,150,160,171,172,163,154,145,136,127,118
 dc.b 109,99,88,77,66,55,44,33,22,11,0,TOKEN_END

Kamm:
 dc.b  SYMF_X!SYMF_Y!FLAG_WAIT
 dc.b  179,169,159,149,139,129,119,109,99,89,79,69,59
 dc.b  49,39,29,19,9,177,167,157,147,137,127,117,107,97
 dc.b  87,77,67,57,47,37,27,17,7,175,165,155,145,135
 dc.b  125,115,105,95,85,75,65,55,45,35,25,15,5,173
 dc.b  163,153,143,133,123,113,103,93,83,73,63,53,43
 dc.b  33,23,13,3,171,161,151,141,131,121,111,101,91,81
 dc.b  71,61,51,41,31,21,11,1,TOKEN_END
Kamm2:
 dc.b SYMF_X!SYMF_Y
 dc.b 179,177,175,173,171,TOKEN_WAIT,TOKEN_WAIT
 dc.b 169,167,165,163,161,TOKEN_WAIT,TOKEN_WAIT
 dc.b 159,157,155,153,151,TOKEN_WAIT,TOKEN_WAIT
 dc.b 149,147,145,143,141,TOKEN_WAIT,TOKEN_WAIT
 dc.b 139,137,135,133,131,TOKEN_WAIT,TOKEN_WAIT
 dc.b 129,127,125,123,121,TOKEN_WAIT,TOKEN_WAIT
 dc.b 119,117,115,113,111,TOKEN_WAIT,TOKEN_WAIT
 dc.b 109,107,105,103,101,TOKEN_WAIT,TOKEN_WAIT
 dc.b 99,97,95,93,91,TOKEN_WAIT,TOKEN_WAIT
 dc.b 89,87,85,83,81,TOKEN_WAIT,TOKEN_WAIT
 dc.b 79,77,75,73,71,TOKEN_WAIT,TOKEN_WAIT
 dc.b 69,67,65,63,61,TOKEN_WAIT,TOKEN_WAIT
 dc.b 59,57,55,53,51,TOKEN_WAIT,TOKEN_WAIT
 dc.b 49,47,45,43,41,TOKEN_WAIT,TOKEN_WAIT
 dc.b 39,37,35,33,31,TOKEN_WAIT,TOKEN_WAIT
 dc.b 29,27,25,23,21,TOKEN_WAIT,TOKEN_WAIT
 dc.b 19,17,15,13,11,TOKEN_WAIT,TOKEN_WAIT
 dc.b 9,7,5,3,1,TOKEN_END

Gate:
 dc.b SYMF_X!SYMF_Y
 dc.b 0,TOKEN_WAIT,TOKEN_WAIT
 dc.b 10,1,TOKEN_WAIT,TOKEN_WAIT
 dc.b 20,11,2,TOKEN_WAIT,TOKEN_WAIT
 dc.b 30,21,12,3,TOKEN_WAIT,TOKEN_WAIT
 dc.b 40,31,22,13,4,TOKEN_WAIT,TOKEN_WAIT
 dc.b 50,41,32,23,14,5,TOKEN_WAIT,TOKEN_WAIT
 dc.b 60,51,42,33,24,15,6,TOKEN_WAIT,TOKEN_WAIT
 dc.b 70,61,52,43,34,25,16,7,TOKEN_WAIT,TOKEN_WAIT
 dc.b 80,71,62,53,44,35,26,17,8,TOKEN_WAIT,TOKEN_WAIT
 dc.b 90,81,72,63,54,45,36,27,18,9,TOKEN_WAIT,TOKEN_WAIT
 dc.b 100,91,82,73,64,55,46,37,28,19,TOKEN_WAIT,TOKEN_WAIT
 dc.b 110,101,92,83,74,65,56,47,38,29,TOKEN_WAIT,TOKEN_WAIT
 dc.b 120,111,102,93,84,75,66,57,48,39,TOKEN_WAIT,TOKEN_WAIT
 dc.b 130,121,112,103,94,85,76,67,58,49,TOKEN_END
Schlange:
 dc.b SYMF_X!SYMF_Y!FLAG_WAIT
 dc.b 0,1,2,3,4,5,6,7,8,9,19,18,17,16,15,14,13
 dc.b 12,11,10,20,21,22,23,24,25,26,27,28,29,39
 dc.b 38,37,36,35,34,33,32,31,30,40,41,42,43
 dc.b 44,45,46,47,48,49,59,58,57,56,55,54,53,52,51,50
 dc.b 60,61,62,63,64,65,66,67,68,69,79,78,77,76
 dc.b 75,74,73,72,71,70,80,81,82,83,84,85,86,87
 dc.b 88,89,TOKEN_END
Spirale1:
 dc.b FLAG_WAIT
 dc.b 95,94,84,85,86,96,106,105,104,103,93,83,73,74
 dc.b 75,76,77,87,97,107,117,116,115,114,113,112,102
 dc.b 92,82,72,62,63,64,65,66,67,68,78,88,98,108
 dc.b 118,128,127,126,125,124,123,122,121,111,101,91,81,71
 dc.b 61,51,52,53,54,55,56,57,58,59,69,79,89,99
 dc.b 109,119,129,139,138,137,136,135,134,133,132,131
 dc.b 130,120,110,100,90,80,70,60,50,40,41,42,43
 dc.b 44,45,46,47,48,49,149,148,147,146,145,144,143
 dc.b 142,141,140,30,31,32,33,34,35,36,37,38,39,159
 dc.b 158,157,156,155,154,153,152,151,150,20,21,22,23
 dc.b 24,25,26,27,28,29,69,169,168,167,166,165
 dc.b 164,163,162,161,160,10,11,12,13,14,15,16,17
 dc.b 18,19,179,178,177,176,175,174,173,172,171,170
 dc.b  0,1,2,3,4,5,6,7,8,9,TOKEN_END
Spirale2:
 dc.b SYMF_X!SYMF_Y!FLAG_WAIT
 dc.b 9,19,29,39,49,59,69,79,89,99,109,119,129,139
 dc.b 149,159,169,179,178,177,176,175,174,173,172,171
 dc.b 161,151,141,131,121,111,101,91,81,71,61,51,41
 dc.b 31,21,11,12,13,14,15
 dc.b 16,17,27,37,47,47,57,67,77,87,97,107,117
 dc.b 127,137,147,157,156,155,154,153,143,133,123,113
 dc.b 103,93,83,73,63,53,43,33,34,35,45,55,65,75
 dc.b  85,95,105,115,125,135,TOKEN_END
 cnop 0,4

