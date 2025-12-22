;MazezaM - C64 version. (C) 2004 by Ventzislav Tzvetkov
;drHirudo@Amigascne.org http://drhirudo.foronlinegames.com
;assemble with >dasm MazezaM.s -oMazezaM.prg
;
; This game is also available for Amiga, Apple 2, GameBoy, Oric and Sinclair.
; Visit my website for more information.
;
; This is no optimized version. If you want to see optimized code,  download
; the Apple 2 version, which is 4092 bytes only, and there is place for even
; more optimizations.

; Music taken from MasterComposer by Playboy.

    processor 6502      ;6510 analog.

SCANKEYBOARD = $EA87

KEYPRESSED = $C5

HTAB   = $24
VTAB   = $25
CHTAB  = $26
CVTAB  = $27
RNDL   = $4E         ;Pseudo random number. Yeah I know using the SID gives
                     ;better results, but for this game this work fine.
HLP     = $80
LOOP    = $81
MAZENO  = $82
LIVES   = $83
DELIMO  = $84        ;Used in the division subroutine.
OSTATYK = $85        ;DELIMO  = DELIMO/DELITEL
DELITEL = $86        ;OSTATYK = DELIMO%DELITEL
LVLX1Y1 = $87        ;Level bytes
LVLX2Y1 = $88        ;Max level size
LVLX1Y2 = $89        ;16 * 12 (2 bytes * 8 bits * 12), but easily extended.
LVLX2Y2 = $8A
LVLX1Y3 = $8B
LVLX2Y3 = $8C
LVLX1Y4 = $8D
LVLX2Y4 = $8E
LVLX1Y5 = $8F
LVLX2Y5 = $90
LVLX1Y6 = $91
LVLX2Y6 = $92
LVLX1Y7 = $93
LVLX2Y7 = $94
LVLX1Y8 = $95
LVLX2Y8 = $96
LVLX1Y9 = $97
LVLX2Y9 = $98
LVLX1YA = $99
LVLX2YA = $9A
LVLX1YB = $9B
LVLX2YB = $9C 
WIDTH   = $9D            ;Level width.
HEIGHT  = $9E            ;Level height.
LX      = $9F            ;In line. Later used as I.
RX      = $A0            ;Out line.
L       = $A1
T       = $A2
R       = $A3
LEVELNL = $A4            ;Name pointer.
LEVELNH = $A5
I       = LX             ;To save some bytes.
SOUNDMADEFLAG = $A6
J       = $A7
SPRITEX = $A8
SPRITEY = $A9
SOUNDFLAG = $AA

;macros

   mac     pushxy
   txa
   pha
   tya
   pha
   endm

   mac     ysprite  ;Set sprite shape. Y contains the first sprite pointer. 
   sty $7F8
   iny
   sty $7F9
   iny
   sty $7FA
   iny
   sty $7FB
   iny
   endm

   mac music
   txa
   pha
   tya
   pha
   jsr $4000
   pla
   tay
   pla
   tax
   endm
        org $801
BASIC_PRG:      .byte $0b,$08           ;Address of next instruction
                .byte $19,$00           ;Line number 25
                .byte $9e               ;SYS
                .byte $32,$30,$36,$31   ;2061 = $80d
                .byte $00,$00,$00       ;12 bytes for the basic program.

Start
    sei         ;This game doesn't use interrupts in this version.
    cld         ;Clear the decimal flag, so it wouldn't mess around.
;    ldx #>Music    ;Misc initialisations.
;    stx $0315   ;Music routine.
;    lda #<Music
;    sta $0314
    lda #$7F
    sta $dc0d
    sta $dd0d
    lda #$00
    sta $D418   ;Disable sound.
    sta $D021   ;Black background.
    sta $D020   ;Black border.
    lda #12
    sta $D022   ;Multi-Color Register 0 -> 12 ($0C) - Grey.
    lda #9
    sta $D023   ;Multi-Color Register 1 -> 9 - Brown.
    ldx #$FF    ;Reset the stack pointer. Although I think I mess it
    txs         ;somewhere, but that doesn't matters, since this is no
                ;multitasking machine.
;    cli        ;Not used.
TITLESC
    jsr $4003 ;At $4003 is the music initialiser.
    lda #$1A
    sta $D018
    lda #%00011000
    sta $D016   ;Set Multi-Color Mode.
    jsr CLEAR
    ldx #39
.1  sta $428,x
    sta $450,x
    sta $478,x
    sta $5E0,x
    sta $608,x
    sta $630,x
    dex
    bpl .1
    ldx #9
.2  sta $49B,x
    sta $4C3,x
    sta $4EB,x
    sta $513,x
    sta $53B,x
    sta $563,x
    sta $58B,x
    sta $5B3,x
    dex
    bpl .2
    ldx #4
.3  lda #95
    sta $5DB,x
    lda #$0F
    sta $D9DB,x
    dex
    bpl .3
    ldx #6
.4  lda TitleText1,x
    sta $4D8,x
    lda TitleText2,x
    sta $500,x
    lda #3
    sta $D8D8,x
    sta $D900,x
    dex
    bpl .4
    ldx #22
.5  lda TitleText3,x
    sta $549,x
    lda #5
    sta $D949,x
    dex
    bpl .5
    ldx #18
.6  lda TitleText4,x
    sta $573,x
    lda #6
    sta $D973,x
    dex
    bpl .6
    ldx #4
.7  lda KeysText1,x
    sta $691,x
    lda #4
    sta $DA91,x
    dex
    bpl .7
    ldx #12
.8  lda KeysText2,x
    sta $6DD,x
    lda #4
    sta $DADD,x
    dex
    bpl .8
    ldx #30
.9  lda KeysText3,x
    sta $724,x
    lda #2
    sta $DB24,x
    dex
    bpl .9
    ldx #18
.10 lda KeysText4,x
    sta $77A,x
    lda #7
    sta $DB7A,x
    dex
    bpl .10
    ldx #24
.11 lda KeysText5,x
    sta $7C7,x
    lda #6
    sta $DBC7,x
    dex
    bpl .11
    lda #176
    sta DELIMO
    ldx #22
.12 lda DELIMO
    sta $458,x
    dec DELIMO
    lda #$59
    sta $D858,x
    dex
    bne .12
    lda #$B0
    sta SPRITEX
    lda #0
    sta $D010
    sta $D017
    sta $D01C
    sta $D01D
    sta $D01B
    lda #8
    sta $D027
    lda #10
    sta $D028
    lda #7
    sta $D029
    lda #6
    sta $D02A
    lda SPRITEX
    sta $D000
    sta $D002
    sta $D004
    sta $D006
    lda #$8A
    sta $D001
    sta $D003
    sta $D005
    sta $D007
    ldx #$C0
    stx $7F8
    inx
    stx $7F9
    inx
    stx $7FA
    inx
    stx $7FB
    lda #%00001111    ;enable sprites
    sta $D015
SpaceKeyP
    jsr DELAY
    jsr $4000
    lda $DC01
    cmp #$EF
    beq GBEGIN
#if BLAZON
    cmp #$BF          ;BLAZON end sequence viewer.
    bne .fire
    lda #11
    sta MAZENO
    jmp GAME
#endif

.fire
    lda #%00010000
    and $DC00
    bne SpaceKeyP
GBEGIN subroutine
    ldy #$C8
    ldx SPRITEX
.Walk
    ysprite
    jsr DELAY
    music
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$D0
    bne .inx
    ldy #$C4
.inx dec RNDL
    inx
    bne .Walk
    lda #%00001111         ;set x MSB for the sprites.
    sta $d010
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    lda #85
    sta LOOP
.Walk2
    ysprite
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$D0
    bne .inx2
    ldy #$C4
.inx2
    inx
    jsr DELAY
    music
    dec LOOP
    bne .Walk2
    lda #1
    sta MAZENO
    lda #3
    sta LIVES
GAME subroutine
    lda #0
    sta $D418   ;Disable sound.
    lda MAZENO
    jsr LEVEL
    lda #$18
    sta SPRITEX
    lda #$00
    sta $D010
    ldy #$C8
    ldx SPRITEX
    lda L  ;L*8+18
    asl
    asl
    asl
    clc
    adc #10
    sta LOOP
    lda LX
    asl
    asl
    asl
    sta HLP
    lda T  ;k=t+lx+1
    asl    ;8 times to get right offset in pixels. 8 pixel = 1 char.
    asl
    asl
    clc
    adc HLP
    adc #$32
    sta $D001
    sta $D003
    sta $D005
    sta $D007
    sta SPRITEY
    jsr DELAY
    lda #%00001111    ;enable sprites
    sta $D015
    dec LOOP
.Walk
    ysprite
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$D0
    bne .inx
    ldy #$C4
.inx dec LOOP
    beq GAMEST
    jsr DELAY
    inx
    bne .Walk
GAMEST
    stx SPRITEX
    ldy #$C0
    ysprite
    ldx #26
.LP jsr DELAY
    dex
    bne .LP
    lda T
    clc
    adc LX
    tax
    ldy L
    lda #139
    jsr PUTYXCHAR
    lda #1
    jsr PUTYXCOLOR
    ldy #$D0
    ysprite
    lda #12
    asl
    asl
    sta LOOP
.DL jsr DELAY
    dec LOOP
    bne .DL
    lda #1    ;i=lx;j=1
    sta J
    lda #138
    ldy L
    jsr PUTYXCHAR
    ldx #79
.DL2
    jsr DELAY
    dex
    bne .DL2
    ldy #$C0
    ysprite

GAMELO
    inc RNDL
    jsr SCANKEYBOARD
    lda KEYPRESSED
    cmp #62     ;Q key pressed.
    beq QKEY
    cmp #60
    bne .J
    lda $DC00
    and #%00010000
    beq RKEY
.J  cmp #17
    beq RKEY
    cmp #23
    beq RIGHTKEY        ;X key pressed.
    cmp #12
    beq LEFTKEY         ;Z key pressed.
    cmp #37
    beq UPKEY           ;K key pressed.
    cmp #36
    beq DOWNKEY         ;M key pressed.

    lda $DC00           ;Read the Joystick.
    tax                 ;save the value in x.
    and #%00001000
    beq RIGHTKEY
    txa
    and #%00000100
    beq LEFTKEY
    txa
    and #%00000010
    beq DOWNKEY
    txa
    and #%00000001
    beq UPKEY

#if BLAZON
    txa                 ;BLAZON trainer.
    and #%00010000      ;This doesn't appear in the public release!
    bne .END
    inc MAZENO
    inc LIVES
    jmp GAME
#endif

.END jmp GAMELO
     rts
   ;The key is read. Jump to the appropriate routine.
LEFTKEY subroutine
     jmp LEFTKEYP
RIGHTKEY subroutine
     jmp RIGHTKEYP
UPKEY subroutine
     jmp UPKEYP
DOWNKEY subroutine
     jmp DOWNKEYP
RKEY subroutine
     jmp RKEYP
QKEY subroutine
     jmp QKEYP

CLEAR subroutine
     jsr DELAY
     ldx #0
     stx $D015
.1   lda #$20
     sta $400,x
     sta $480,x
     sta $500,x
     sta $580,x
     sta $600,x
     sta $680,x
     sta $700,x
     sta $780,x
     lda #$99
     sta $D800,x
     sta $D880,x
     sta $D900,x
     sta $D980,x
     sta $DA00,x
     sta $DA80,x
     sta $DB00,x
     sta $DB80,x
     inx
     bpl .1
UPBRKS subroutine
    lda #137
    sta $400
    sta $401
    sta $412
    sta $413
    sta $414
    sta $426
    sta $427
    rts

; Level Drawing routine
LEVEL subroutine
    tax                       ;save the register
    sta DELIMO
    lda LEVELSWIDTHTABLE-1,x  ;use the saved reg to get the widht
    sta WIDTH
    lda LEVELSHEIGHTTABLE-1,x ;and height
    sta HEIGHT
    lda LXTABLE-1,x           ;and LX
    sta LX
    lda RXTABLE-1,x           ;and RX
    sta RX
    lda #>LVLPNT    ;Set return address - on the levelprint.
    pha             ;Put address on stack to simulate jump.
    lda #<LVLPNT-1
    pha
    txa       ;Return the saved x to the accumulator.
    asl       ;Double to create index
    tax       ;for address table.
    lda LEVELSTABLE-1,x ;High order byte
    pha
    lda LEVELSTABLE-2,x ;Low order byte
    pha
    lda NAMESTABLE-1,x
    sta LEVELNH        ;Get text index.
    lda NAMESTABLE-2,x
    sta LEVELNL
    rts

LVLPNT subroutine 
     ldy #10
     sty DELITEL
     jsr DIVISION
     clc
     lda DELIMO
     adc #48
     sta LevelText+8
     lda OSTATYK
     adc #48
     sta LevelText+9
     lda LIVES
     sta DELIMO
     jsr DIVISION
     clc
     lda DELIMO
     adc #48
     sta LivesText+8
     lda OSTATYK
     adc #48
     sta LivesText+9
     lda #40    ;l=((40-w)/2);t=((26-h)/2);r=38-l-w;
     sec
     sbc WIDTH
     lsr
     sta L
     lda #26
     sec
     sbc HEIGHT
     lsr
     sta T
     lda #38
     sec
     sbc L
     sec
     sbc WIDTH
     sta R
     jsr CLEAR
     ldx #11
.1   lda LevelText,x
     sta $404,x
     lda #6
     sta $d804,x
     lda LivesText,x
     sta $417,x
     lda #5
     sta $D817,x
     dex
     bpl .1
     lda #137                ;for (i=0;i<t;i++) printf(" ''''
     ldx T
     dex
BRoo 
     ldy #39
     jsr PUTYXCHAR
     dey
BRoi
     sta (HTAB),y
     dey
     bpl BRoi
     dex
     bne BRoo
     stx LOOP
     ldy HEIGHT
LDLOOP
     lda LOOP
     pha
     adc T
     tax
     pla
     cmp LX
     bne LBRICKS
     ldy L
     lda #95
     jsr PUTYXCHAR
     lda #7
     jsr PUTYXCOLOR
     dey
.3   lda #95
     sta (HTAB),y
     lda #7
     sta (CHTAB),y
     dey
     bpl .3
     bmi .4
LBRICKS
     lda #137
LDXL ldy L
     jsr PUTYXCHAR
     dey
LIM  sta (HTAB),y
     dey
     bpl LIM
.4   lda LOOP
     jsr RENDER
     ldy #39
     lda R
     sta HLP
     lda LOOP
     cmp RX
     bne RBRICKS
     lda #95
     jsr PUTYXCHAR
     lda #7
     jsr PUTYXCOLOR
     dey
     dec HLP
.5   lda #95
     sta (HTAB),y
     lda #7
     sta (CHTAB),y
     dey
     dec HLP
     bpl .5
     bmi .6
RBRICKS
     lda #137
     jsr PUTYXCHAR
     dey
     dec HLP
RIM  sta (HTAB),y
     dey
     dec HLP
     bpl RIM
.6   inc LOOP
     lda LOOP
     cmp HEIGHT
     bne LDLOOP
                 ;for (i=t+h;i<24;i++)
     lda T
     clc
     adc HEIGHT
     sta LOOP
     lda #24
     sec
     sbc LOOP
     sta LOOP
     lda #137
     inx
DWBRKS
     ldy #39
     jsr PUTYXCHAR
     dey
DWNBRKS
     sta (HTAB),y
     dey
     bpl DWNBRKS
     inx
     dec LOOP
     bne DWBRKS
     ldy #0
     pha      ;j = strlen(LevelName);
     lda #37
     sec
     sbc (LEVELNL),y
     lsr  ; divide it by two
     tay
     sta DELIMO
     pla
     ldx #24
LTBRICK
     jsr PUTYXCHAR               ;put brick on left and right
     sty HLP
     pha
     lda #39
     sec
     sbc HLP
     tay
     pla
     jsr PUTYXCHAR
     ldy HLP
     dey
     bpl LTBRICK
     ldy DELIMO
     iny
     tya
     ldx #$FF
     clc
     adc (LEVELNL+1),x          ;Put name between the bricks.
     sta HLP
     lda (LEVELNL+1),x          ;Get name lenght.
     sta LOOP
     ldx #24
NameTex
     ldy LOOP
     lda (LEVELNL),y
     ldy HLP
     sta (HTAB),y
     lda #4
     jsr PUTYXCOLOR
     dec HLP
     dec LOOP
     bne NameTex
     rts

DIVISION subroutine
         ldx #8
         lda #0
         sta OSTATYK
CYCLE    asl DELIMO
         rol OSTATYK
         sec
         lda OSTATYK
         sbc DELITEL
         BCC DECR
         sta OSTATYK
         inc DELIMO
DECR     dex
         bne CYCLE
         rts
LEVEL1
         lda #%01001000
         sta LVLX1Y1
         lda #%01001100
         sta LVLX1Y2
         rts
LEVEL2   lda #%00100111
         sta LVLX1Y1
         lda #%00101010 
         sta LVLX1Y2
;        lda #%01010100
         asl
         sta LVLX1Y3
         rts
LEVEL3   lda #%00100000
         sta LVLX1Y1
         lda #%01011000
         sta LVLX1Y2
         ldx #%01100000
         stx LVLX1Y3
         lda #%10100000
         sta LVLX1Y4
;         lda #%10100000
         sta LVLX1Y7
;         lda #%01010000
         lsr
         sta LVLX1Y5
;         lda #%01010000
         sta LVLX1Y8
;         lda #%01010000
         sta LVLX1Y9
         lda #%01110000
         sta LVLX1Y6
         lda #%10110000
         sta LVLX1YA
         lda #%01000000
         sta LVLX1YB
         rts
LEVEL4   lda #%00011111
         sta LVLX1Y1
         lda #%00000000
         sta LVLX2Y1
         lda #%10111110
         sta LVLX1Y2
         lda #%01110000
         sta LVLX2Y2
;         lda #%11100000
         asl
         sta LVLX2Y3
         lda #%01011101
         sta LVLX1Y3
         lda #%10100111
         sta LVLX1Y4
         lda #%11110000
         sta LVLX2Y4
         lda #%01110100
         sta LVLX1Y5
         lda #%01100000
         sta LVLX2Y5
         lda #%10101011
         sta LVLX1Y6
         lda #%00100000
         sta LVLX2Y6
         rts
LEVEL5   lda #%01111101
         sta LVLX1Y1
         lda #%10110000
         sta LVLX2Y1
         lda #%00011001
         sta LVLX1Y2
         lda #%10011000
         sta LVLX2Y2
         lda #%11001011
         sta LVLX1Y3
         lda #%01110000
         sta LVLX2Y3
         lda #%00011111
         sta LVLX1Y4
         lda #%11100100
         sta LVLX2Y4
         rts
LEVEL6   lda #%00010000
         sta LVLX1Y1
         lda #%01111000 
         sta LVLX1Y2
         lda #%01110110
         sta LVLX1Y3
         lda #%01010100
         sta LVLX1Y4
         lda #%01011000 
         sta LVLX1Y5
         asl
;         lda #%10110000
         sta LVLX1Y6
         rts
LEVEL7   lda #%00000001
         sta LVLX1Y1
         lda #%11111100
         sta LVLX2Y1
         lda #%00111101
         sta LVLX1Y2
         lda #%11101010
         sta LVLX2Y2
         lda #%11011011
         sta LVLX1Y3
         lda #%11110101
         sta LVLX2Y3
         lda #%11000001
         sta LVLX1Y4
         lda #%01000000
         sta LVLX2Y4
         lda #%00111111
         sta LVLX1Y5
         lda #%11111110
         sta LVLX2Y5
         lda #%01011000
         sta LVLX1Y6
         lda #%01011100
         sta LVLX2Y6
         lda #%00100011
         sta LVLX1Y7
         lda #%10000011
         sta LVLX2Y7
         rts
LEVEL8   lda #%01111001
         sta LVLX1Y1
         lda #%11100110
         sta LVLX2Y1
         ldx #%01011011
         stx LVLX1Y2
         lda #%01011000
         sta LVLX2Y2
;         lda #%01011011
         stx LVLX1Y3
         lda #%11011000
         sta LVLX2Y3
         lda #%01011001
         sta LVLX1Y4
         lda #%11100100
         sta LVLX2Y4
         rts
LEVEL9   lda #%01001111
         sta LVLX1Y1
         ldx #%00000000
         stx LVLX2Y1
         lda #%01001011
         sta LVLX1Y2
;         lda #%00000000
         stx LVLX2Y2
         lda #%01011110
         sta LVLX1Y3
         ldy #%10000000
         sty LVLX2Y3
         lda #%10110010
         sta LVLX1Y4
;         lda #%00000000
         stx LVLX2Y4
         lda #%00100011
         sta LVLX1Y5
;         lda #%10000000
         sty LVLX2Y5
         lda #%01111110
         sta LVLX1Y6
;         lda #%00000000
         stx LVLX2Y6
         lda #%00100000
         sta LVLX1Y7
;         lda #%00000000
         stx LVLX2Y7
         rts
LEVELA   ldy #%00000000
         sty LVLX1Y1
         lda #%00001000
         sta LVLX2Y1
         lda #%01111111
         sta LVLX1Y2
         lda #%11100100
         sta LVLX2Y2
         lda #%01110000
         sta LVLX1Y3
         ldx #%00011000
         stx LVLX2Y3
         ldx #%01011111
         stx LVLX1Y4
         ldx #%11101000
         stx LVLX2Y4
         ldx #%01110111
         stx LVLX1Y5
;         lda #%00111000
         lsr
         sta LVLX2Y5
         ldx #%01110001
         stx LVLX1Y6
;         lda #%00111000
         sta LVLX2Y6
         ldx #%01011111
         stx LVLX1Y7
         ldx #%11011000
         stx LVLX2Y7
         ldx #%01010100
         stx LVLX1Y8
;         lda #%00111000
         sta LVLX2Y8
         lda #%01111111
         sta LVLX1Y9
         lda #%11111000
         sta LVLX2Y9
;         lda #%00000000
         sty LVLX1YA
;         lda #%00000000
         sty LVLX2YA
         rts

GAMECOMPLETED subroutine
    ldx #%00001000
    stx $D016            ;Set Normal-Color Mode.
    ldx #0
    stx $D015
.1  lda #$20
    sta $400,x
    sta $500,x
    sta $600,x
    sta $700,x
    lda #15
    sta $D800,x
    sta $D900,x
    sta $DA00,x
    sta $DB00,x    ;Clear.
    inx
    bne .1
    lda #124       ;Draw Castle.
    sta $406
    sta $407
    sta $408
    ldx #8
.4  lda #124       ;It's a big one.
    sta $428,x
    sta $450,x
    sta $478,x
    sta $4A0,x
    sta $4C8,x
    sta $4F0,x
    sta $518,x
    sta $540,x
    sta $568,x
    sta $590,x
    sta $5B8,x
    sta $608,x
    sta $630,x
    sta $658,x
    sta $680,x
    sta $6A8,x
    sta $6D0,x     ;-O
    sta $6F8,x
    sta $720,x
    sta $748,x
    sta $770,x
    sta $798,x
    sta $7C0,x
    sta $7E8,x
    lda #95
    sta $5E0,x
    lda #7
    sta $D9E0,x
    dex
    bpl .4
    ldx #12
    lda #24
    sta LOOP
    ldy #39
    lda #140
    jsr PUTYXCHAR
    lda #5
    jsr PUTYXCOLOR
.GR lda #140             ;Draw Grass.
    sta (HTAB),y
    lda #5
    sta (CHTAB),y
    dey
    dec LOOP
    bne .GR
    lda #7
    sta LOOP
    inx
.BR lda #143             ;Draw Bridge.
    jsr PUTYXCHAR
    lda #14
    jsr PUTYXCOLOR
    dey
    dec LOOP
    bne .BR
    ldx #24
.GRD lda #142             ;Draw Ground.
    sta $617,x
    sta $63F,x
    sta $667,x
    sta $68F,x
    sta $6B7,x
    sta $6DF,x
    sta $707,x
    sta $72F,x
    sta $757,x
    sta $77F,x
    sta $7A7,x
    sta $7CF,x
    lda #9
    sta $DA17,x
    sta $DA3F,x
    sta $DA67,x
    sta $DA8F,x
    sta $DAB7,x
    sta $DADF,x
    sta $DB07,x
    sta $DB2F,x
    sta $DB57,x
    sta $DB7F,x
    sta $DBA7,x
    sta $DBCF,x
    dex
    bne .GRD
    ldx #7
.WTR lda #141               ;Draw Water.
     sta $660,x
     lda #126
     sta $688,x
     sta $6B0,x
     sta $6D8,x
     sta $700,x
     sta $728,x
     sta $750,x
     sta $778,x
     sta $7A0,x
     sta $7C8,x
     lda #6
     sta $DA60,x
     sta $DA88,x
     sta $DAB0,x
     sta $DAD8,x
     sta $DB00,x
     sta $DB28,x
     sta $DB50,x
     sta $DB78,x
     sta $DBA0,x
     sta $DBC8,x
     dex
     bne .WTR
     lda #146
     sta $5FD
     lda #4
     sta $D9FD
     ldx #7
.tx1 lda EndText1,x
     sta $492,x
     lda #13
     sta $D892,x
     lda EndText2,x
     sta $4BA,x
     lda #12
     sta $D8BA,x
     dex
     bpl .tx1
     ldx #9
.tx2 lda EndText3,x
     sta $509,x
     lda #4
     sta $D909,x
     dex
     bpl .tx2
     ldx #144
     stx $44C
     lda #11
     sta $D84C
     inx
     stx $44D
     sta $D84D
     ldx #$18
     stx $D000
     stx $D002
     stx $D004
     stx $D006
     lda #$92
     sta $D001
     sta $D003
     sta $D005
     sta $D007
     inx
     lda #%00001111
     sta $D015
FINALRUN subroutine
    ldy #$C8
.Walk
    jsr PUTYSPRITE
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpx #$93
    bne .cp2
    dec $D001
    dec $D003
    dec $D005
    dec $D007
.cp2 cpx #$94
    bne .cp3
    dec $D001
    dec $D003
    dec $D005
    dec $D007
.cp3 cpx #$EC
    bcc .cp
    txa
    pha
    ldx #6
.hr lda EndHurray,x
    sta $55B,x
    lda #3
    sta $D95B,x
    dex
    bpl .hr
    dec $D001
    dec $D003
    dec $D005
    dec $D007
    pla
    tax
.cp cpy #$D0
    bne .inx
    ldy #$C4
.inx dec RNDL
    jsr DELAY
    inx
    bne .Walk
    lda #%00001111    ;set x MSB for the sprites.
    sta $d010
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    lda #87
    sta LOOP
.Walk2
    jsr PUTYSPRITE
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpx #$5
    bcc .cx
    cpx #$19
    beq .NoHurray
    bcs .cx
    inc $D001
    inc $D003
    inc $D005
    inc $D007
    bne .cx
.NoHurray
    lda #$20
    sta $55B
    sta $55C
    sta $55D
    sta $55E
    sta $55F
    sta $560
    sta $561
.cx cpy #$D0
    bne .inx2
    ldy #$C4
.inx2
    inx
    jsr DELAY
    dec LOOP
    bne .Walk2
    jmp TITLESC

DELAY   lda #$af
.1      cmp $d012
        bne .1
        rts

PUTYXCHAR subroutine
          pha
          txa
          pha
          lda #$04
          sta VTAB
          lda #$00
          sta HTAB
.1        lda HTAB
          clc
          adc #40
          sta HTAB
          bcc .2
          inc VTAB     ;Calculate address.
.2        dex
          bne .1
          pla
          tax
          pla
PUTCHAR   sta (HTAB),y
          rts
PUTYXCOLOR subroutine
          pha
          txa
          pha
          lda #$d8
          sta CVTAB
          lda #$00
          sta CHTAB
.1        lda CHTAB
          clc
          adc #40
          sta CHTAB
          bcc .2
          inc CVTAB   ;Calculate address.
.2        dex
          bne .1
          pla
          tax
          pla
PUTCOLOR  sta (CHTAB),y
          rts

RENDER subroutine
        asl
        sta HLP            ;render the level line (A) VTAB is set
        stx J
        lda RNDL
        inc RNDL           ;Not much random, I know, but this prevents
        sta DELIMO         ;same colour appearing on next to each lines.
        lda #6
        sta DELITEL        ;Color = Line%6;
        pushxy
        jsr DIVISION
        lda HLP
        tax
        lda #8
        sta DELIMO
        lda WIDTH
        sta DELITEL
        cmp #9 ;Check if the Level uses 2 bytes per line i.e if WIDTH>8
        bcc .123           ;No...
        lda LVLX1Y1+1,x    ;Yes.
        bne .345
.123    lda #0       ;Clear the second byte so it wouldn't mess around.
.345    sta HLP      ;Save it in the Help byte.

LINE subroutine
        lda L              ;k=l+1
        tay
        iny
        lda LVLX1Y1,x      ;Load the level byte
        ldx J
        pha                ;Push it into stack for loop use.
.3      lda HLP
        asl                ;Shift left the second byte.
        sta HLP
        pla
        rol
        pha                ;Push into stack for later use.
        bcs .1
        lda #1
        sta SOUNDFLAG
        lda #32
        bne .2
.1      dec SOUNDFLAG
        beq .34
        rol
        bcs .333
        lda #130
        bne .2
.333    lda #129
        bne .2
.34     rol
        bcs .35
        lda #127
        bne .2
.35     bcs .36
        lda #129
        bne .2
.36     lda #128
.2      jsr PUTYXCHAR
        lda OSTATYK
        clc
        adc #2          ;Color 0 and 1 are unused here.
        jsr PUTYXCOLOR
        iny
        dec DELITEL
        bne .3
.5      pla     ;correct stack pointer.
        pla     ;pull y
        tay
        pla     ;and x
        tax
        rts

RENDERMOVED subroutine
        lda I
        sta HLP
        clc
        adc T            ;Calculate which line is it.
        tax
        lda #$04
        sta VTAB
        lda #$00
        sta HTAB
.1      lda HTAB
        clc
        adc #40
        sta HTAB
        bcc .2
        inc VTAB           ;calculate VTAB
.2      dex
        bne .1
        lda HLP
        asl
        tax
        lda WIDTH
        sta DELITEL
        cmp #9 ;Check if the Level uses 2 bytes per line i.e if WIDTH>8
        bcc .123           ;No...
        lda LVLX1Y1+1,x    ;Yes.
        bne .345
.123    lda #0       ;Clear the second byte so it wouldn't mess around.
.345    sta HLP      ;Save it in the Help byte.

LINEMOVED subroutine
        lda L              ;k=l+1
        tay
        iny
        lda LVLX1Y1,x      ;Load the level byte
        ldx J
        pha                ;Push it into stack for loop use.
.3      lda HLP
        asl                ;Shift left the second byte.
        sta HLP
        pla
        rol
        pha                ;Push into stack for later use.
        bcs .1
        lda #1
        sta SOUNDFLAG
        lda #32
        bne .2
.1      dec SOUNDFLAG
        beq .34
        rol
        bcs .333
        lda #130
        bne .2
.333    lda #129
        bne .2
.34     rol
        bcs .35
        lda #127
        bne .2
.35     bcs .36
        lda #129
        bne .2
.36     lda #128
.2      sta (HTAB),y
        iny
        dec DELITEL
        bne .3
.5      pla     ;correct stack pointer.
        rts

UPKEYP subroutine
       ldx I
       dex
       bpl .1         ;if (direction==UP && I>1)
.RTSPK jsr PUK
.RTS   jmp GAMELO
.1     txa          ; if (b[I-1][J-1]==0)
       asl
       tax
       lda J
       cmp #9
       bcc .2
       inx
       sbc #8       
.2     tay                ;y = J
       lda LVLX1Y1,x      ;level part  b[i-1]
.3     asl
       dey
       bne .3
       bcc .4
       bcs .RTSPK         ;Saves 1 byte.
.4  dec I                 ;Decrement the vertical position.
    lda #9
    sta LOOP
    ldy #$F0
    ldx SPRITEY
.Walk
    jsr PUTYSPRITE
    jsr DELAY
    stx $D001
    stx $D003
    stx $D005
    stx $D007
    cpy #$F4
    bne .inx
    ldy #$EC
.inx dec LOOP
    beq .9
    jsr DELAY
    dex
    bne .Walk
.9  stx SPRITEY
    jsr DELAY
    ldy #$C0
    jsr PUTYSPRITE
    lda #0
    sta SOUNDMADEFLAG
    beq .RTS

DOWNKEYP subroutine
       ldx I
       inx
       cpx HEIGHT     ;if (direction==DOWN && I<HEIGHT)
       bcc .1
.RTSPK jsr PUK
.RTS   jmp GAMELO
.1     txa            ; if (b[i+1][j-1]==0)
       asl
       tax
       lda J
       cmp #9
       bcc .2
       inx
       sbc #8       
.2     tay                ;y = j
       lda LVLX1Y1,x      ;level part  b[i+1]
.3     asl
      dey
      bne .3
      bcc .4
      bcs .RTSPK         ;saves 1 byte
.4    inc I              ;Incremet the vertical position.
      lda #9
      sta LOOP
      ldy #$FC
      ldx SPRITEY
.Walk
    jsr PUTYSPRITE
    jsr DELAY
    stx $D001
    stx $D003
    stx $D005
    stx $D007
    cpy #$00
    bne .inx
    ldy #$F4
.inx dec LOOP
    beq .9
    jsr DELAY
    inx
    bne .Walk
.9  stx SPRITEY
    jsr DELAY
    ldy #$C0
    jsr PUTYSPRITE
    lda #0
    sta SOUNDMADEFLAG
    beq .RTS

RKEYP subroutine ;R key was pressed or SPACE+Fire

#if BLAZON=0
      dec LIVES  ;Doesn't take lives in the BLAZON trained version.
      bne .1
      jmp QKEYP
#endif

.1    lda T      ;dead sequence
      sec
      adc I
      tay
      dey
      dey
      sty LOOP
      lda J
      adc R
      tay
      iny
      iny
      iny
      sty HLP
      lda RNDL
      sta DELIMO
      lda #9
      sta DELITEL
      jsr DIVISION
      lda OSTATYK
      asl            ;switch (rand()%9)
      tax
      lda RKEYPRESSTABLE,x
      sta LEVELNL
      lda RKEYPRESSTABLE+1,x
      sta LEVELNH         ;get text index
      ldy #4
      ldx LOOP
.2    tya                 ;Put angry text.
      pha
      lda (LEVELNL),y
      ldy HLP
      jsr PUTYXCHAR
      lda #2
      jsr PUTYXCOLOR
      dec HLP
      pla
      tay
      dey
      bpl .2
      jsr DELAY
      ldy #$D8            ;die animation
      jsr PUTYSPRITE
      ldx #26
.RP1  jsr DELAY
      dex
      bne .RP1
      jsr PUTYSPRITE
      ldx #$FF
.3    jsr DELAY
      lda $DC01
      cmp #$EF
      beq .4
      lda #%00010000
      and $DC00
      beq .4
      dex
      bne .3
.4    jmp GAME

QKEYP subroutine            ;QKEY was pressed or there is no lives left.
      jsr DELAY
      ldy #$D4
      jsr PUTYSPRITE
      lda #48
      sta $41F
      sta $420           ;Print 0 lives.
      ldx #8
.2    lda GOverText,x    ;Print Game Over Text.
    sta $5F0,x
    lda #2
    sta $D9F0,x
    dex
    bpl .2
    lda #48
    sta LOOP
.DIL jsr DELAY
    dec LOOP
    bne .DIL
    lda #250
    sta LOOP
.SpaceKeyP
    jsr DELAY
    lda $DC01
    cmp #$EF
    beq .4
    lda #%00010000
    and $DC00
    dec LOOP
    beq .4
    bne .SpaceKeyP
.4  lda #28
    sta LOOP
.5  jsr DELAY
    dec LOOP
    bne .5
    jmp TITLESC

RIGHTKEYP subroutine
       ldy J
       cpy WIDTH
       beq .L
       bcc .1
.L     lda I       ;if (i==rx && j==w)
       cmp RX
       bne .1
       jmp LEVELCOMPL
.1     cpy WIDTH    ;if (j<w)
       bcc .CT
.RTSPK jsr PUK
.RTS   jmp GAMELO                ; else
.CT    lda I
       asl          ; if (b[i][j]==0)
       tax
       lda J
       cmp #8
       bcc .2
       inx
       sbc #8
.2     tay                ;y = j
       iny
       lda LVLX1Y1,x      ;level part  b[i]
.3     asl
       dey
       bne .3
       bcc .4
       bcs .5             ; else
.4  lda #9
    sta LOOP
    inc J                 ;increment the horizontal position.
    ldy #$C8
    ldx SPRITEX
.Walk
    jsr PUTYSPRITE
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$D0
    bne .inx
    ldy #$C4
.inx dec LOOP
    beq .9
    jsr DELAY
    inx
    bne .Walk
.9  stx SPRITEX
    jsr DELAY
    ldy #$C0
    jsr PUTYSPRITE
    lda #0
    sta SOUNDMADEFLAG
    beq .RTS
.5  lda I
    asl
    tax
    lda WIDTH
    cmp #9
    bcc .22
    inx
    sbc #8
.22 sta HLP                ;y = number of right shifts to get w-1
    lda #9
    sec
    sbc HLP
    tay
    lda LVLX1Y1,x      ;if (b[i][w-1]==0)
.222   lsr
       dey
       bne .222
       bcc .6             ; yes
       bcs .RTSPK         ; else
.6     lda I
       asl
       tax
       lda LVLX1Y1,x
       lsr                ;set last bit in the carry flag.
       sta LVLX1Y1,x
       inx
       lda LVLX1Y1,x
       ror                ;first bit comes from carry
       sta LVLX1Y1,x
       jsr RENDERMOVED
       jmp .4

LEVELCOMPL subroutine
    ldy #$C8
    ldx SPRITEX
.Walk
    ysprite
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$D0
    bne .inx
    ldy #$C4
.inx dec RNDL
    jsr DELAY
    inx
    bne .Walk
    lda #%00001111         ;set x MSB for the sprites.
    sta $d010
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    lda #82
    sta LOOP
.Walk2
    ysprite
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$D0
    bne .inx2
    ldy #$C4
.inx2
    inx
    jsr DELAY
    dec LOOP
    bne .Walk2
    lda T
    clc
    adc I
    sta HLP
    dec HLP
    lda RNDL
    sta DELIMO
    lda #11
    sta DELITEL
    jsr DIVISION
    lda OSTATYK
    asl            ;switch (rand()%11)
    tax
    lda HURRAYSTABLE+1,x
    sta LEVELNH         ;get text index
    lda HURRAYSTABLE,x
    sta LEVELNL
    lda #39
    sta DELIMO
    ldx #0
    lda (LEVELNL),x
    tay
    ldx HLP
    pha
.TXT tya
     pha
     lda (LEVELNL),y
     ldy DELIMO
     jsr PUTYXCHAR
     lda #4
     jsr PUTYXCOLOR
     dec DELIMO
     pla
     tay
     dey
     bne .TXT
     ldx #$FF
.ddl  inc RNDL
      jsr DELAY
      dex
      bne .ddl
;.Muz   txa
;       pha
;       lda LEVELCOMPLNOTES-1,x
;       sta PITCH
;       lda LEVELCOMPLDELAYS-1,x
;       sta DURATION
;       jsr PLAYSOUND
;       jsr DELAY
;      pla
;       tax
;       lda $C000
;       cmp #$A0
;       beq .GO
;       lda $C061
;       bmi .GO
;       dex
;       bne .Muz
.GO    inc MAZENO
       inc LIVES
       jmp GAME

LEFTKEYP subroutine
       ldy J
       cpy #2
       bcs .1
.RTSPK jsr PUK
.RTS   jmp GAMELO
.1     dey
       lda I
       asl          ; if (b[i][j-2]==0)
       tax
       lda J
       cmp #9
       bcc .2
       beq .11
       sbc #9
       inx
       bne .2222
.11    lda #8
.2222  tay
.2     lda LVLX1Y1,x      ;level part  b[i]
.3     asl
       dey
       bne .3
       bcc .4
       bcs .5             ; else
.4  dec J                ;decrement horizontal position.
    lda #9
    sta LOOP
    ldy #$E8
    ldx SPRITEX
.Walk
    jsr PUTYSPRITE
    jsr DELAY
    stx $D000
    stx $D002
    stx $D004
    stx $D006
    cpy #$EC
    bne .inx
    ldy #$E0
.inx dec LOOP
    beq .9
    jsr DELAY
    dex
    bne .Walk
.9  stx SPRITEX
    jsr DELAY
    ldy #$C0
    jsr PUTYSPRITE
    lda #0
    sta SOUNDMADEFLAG
    beq .RTS
.5  lda I
    asl
    tax
    lda LVLX1Y1,x      ;if (b[i][0]==0)
    bpl .6             ; yes
    bmi .RTSPK         ; else
.6  lda WIDTH
    cmp #9             ;if (WIDTH < 9) shift only 1 byte
    bcc .8             ;carry is cleared so it wouldn't affect the rol.
    inx
    lda LVLX1Y1,x      ;else shift 2 bytes.
    asl                ;first bit goes to carry.
    sta LVLX1Y1,x
    dex                ;previus byte of the level line.
.8  lda LVLX1Y1,x      ;get it.
    rol                ;set eight bit from the carry flag.
    sta LVLX1Y1,x
    lda I
    jsr RENDERMOVED
    jmp .4

PUK subroutine   ;Noise sound here.
    lda SOUNDMADEFLAG
    bne .ex
    ldx #0
    stx $D40B
    stx $D412
    lda #%10000001
    sta $D404
    lda #15
    sta $D418
    jsr DELAY
    inc SOUNDMADEFLAG
    stx $D404
    stx $D418
.ex rts

PUTYSPRITE
    sty $7F8
    iny
    sty $7F9
    iny
    sty $7FA
    iny
    sty $7FB
    iny
    rts
;End of code.

;section DATA

LEVELSWIDTHTABLE
     .byte 7,8,5,13,14,7,16,15,9,14

LEVELSHEIGHTTABLE
     .byte 2,3,11,6,4,6,7,4,7,10

LXTABLE
     .byte 0,2,10,0,1,4,0,2,6,7

RXTABLE
     .byte 0,1,0,0,3,2,6,0,2,0

LEVELSTABLE
     dc.w #LEVEL1-1
     dc.w #LEVEL2-1
     dc.w #LEVEL3-1
     dc.w #LEVEL4-1
     dc.w #LEVEL5-1
     dc.w #LEVEL6-1
     dc.w #LEVEL7-1
     dc.w #LEVEL8-1
     dc.w #LEVEL9-1
     dc.w #LEVELA-1
     dc.w #GAMECOMPLETED-1

NAMESTABLE
     dc.w #NAME1
     dc.w #NAME2
     dc.w #NAME3
     dc.w #NAME4
     dc.w #NAME5
     dc.w #NAME6
     dc.w #NAME7
     dc.w #NAME8
     dc.w #NAME9
     dc.w #NAMEA

             ;lenght
NAME1 .byte 14,"Humble Origins"
NAME2 .byte 12,"Easy Does It"
NAME3 .byte 16,"Up, Up  and Away"
NAME4 .byte 10,"To and Fro"
NAME5 .byte 12,"Loop-de-Loop"
NAME6 .byte 12,"Be  Prepared"
NAME7 .byte 16,"Two  Front Doors"
NAME8 .byte 20,"Through and  through"
NAME9 .byte 12,"Double Cross"
NAMEA .byte 10,"Inside Out"

HURRAYSTABLE
     dc.w #HURRAY1
     dc.w #HURRAY2
     dc.w #HURRAY3
     dc.w #HURRAY4
     dc.w #HURRAY5
     dc.w #HURRAY6
     dc.w #HURRAY7
     dc.w #HURRAY8
     dc.w #HURRAY9
     dc.w #HURRAYA
     dc.w #HURRAYB

HURRAY1 .byte 7,"Hurray!"
HURRAY2 .byte 7,"Hurrah!"
HURRAY3 .byte 8,"Yes-Yes!"
HURRAY4 .byte 6,"Great!"
HURRAY5 .byte 8,"Yee-hah!"
HURRAY6 .byte 6,"Yayia!"
HURRAY7 .byte 7,"Yuppie!"
HURRAY8 .byte 8,"Success!"
HURRAY9 .byte 7,"SuperB!"
HURRAYA .byte 7,"Groovy!"
HURRAYB .byte 7,"Supaah!"

RKEYPRESSTABLE
         dc.w #ArghText
         dc.w #OuchText
         dc.w #GrrrText
         dc.w #NoouText
         dc.w #NaahText
         dc.w #UuufText
         dc.w #AaahText
         dc.w #OuufText
         dc.w #PuffText

ArghText   .byte "ARGH!"
OuchText   .byte "OUCH!"
GrrrText   .byte "GRRR!"
NoouText   .byte "NOOU!"
NaahText   .byte "NAAH!"
UuufText   .byte "UUUF!"
AaahText   .byte "AAAH!"
OuufText   .byte "OUUF!"
PuffText   .byte "PUFF!"

GOverText  .byte "GAME OVER"
EndText1   .byte "You have"
EndText2   .byte "Escaped."
EndText3   .byte "Well Done!"
EndHurray  .byte "Hurray!"
CongrText  .byte "CONGRATULATIONS!"

TitleText1 .byte 147,148,149,150,149,148,147
TitleText2 .byte 151,152,153,154,153,152,151
TitleText3 .byte "C64 version (C) 2004 by"
#if BLAZON
TitleText4 .byte "+Trained by BLAZON+"    ;I have nothing to do with BLAZON!
#else                                     ;But I am one of their uncountable
TitleText4 .byte "Ventzislav Tzvetkov"    ;fans, so I put this trainer code,
#endif                                    ;to save them some work.  They are
KeysText1  .byte "Keys:"                  ;busy guys, you know.
KeysText2  .byte "Move - ZX\/KM"
KeysText3  .byte "RETRY LEVEL - r   QUIT GAME - q"
KeysText4  .byte "Or use the Joystick"
KeysText5  .byte "Press Space/Fire to Start"
LevelText  .byte "* Level    *"
LivesText  .byte "* Lives    *"

    org $2900              ;The first 32 characters are unused.

#include MazezaMFont.asm

SPRITES SEG        ;Look at the Amiga source for the sprite graphics.
    org $3000                         ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3040                         ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3080                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $30C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100110,$00,$00
    ds     $28,#$00
    org $3100                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3140                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3180                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $31C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100000,$00,$00
    .byte #%00001100,$00,$00
    ds     $28,#$00
    org $3200                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3240                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3280                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $32C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100110,$00,$00
    ds     $28,#$00
    org $3300                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3340                         ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3380                         ;hair
    .byte #%00011000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $33C0                          ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000110,$00,$00
    .byte #%00110000,$00,$00
    ds     $28,#$00
    org $3400                         ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3440                         ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3480                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $34C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100110,$00,$00
    ds     $28,#$00
    org $3500                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%01111110,$00,$00
    .byte #%00011000,$00,$00
    ds     $28,#$00
    org $3540                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3580                          ;hair
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $35C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%11000011,$00,$00
    ds     $28,#$00
    org $3600                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01111110,$00,$00
    .byte #%00011000,$00,$00
    ds     $28,#$00
    org $3640                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%01011010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3680                          ;hair
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $36C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%11000011,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3700                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01111110,$00,$00
    .byte #%00011000,$00,$00
    ds     $28,#$00
    org $3740                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3780                          ;hair
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $37C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%11000011,$00,$00
    ds     $28,#$00
    org $3800                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3840                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3880                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $38C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100000,$00,$00
    .byte #%00001100,$00,$00
    ds     $28,#$00
    org $3900                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3940                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00100000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3980                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $39C0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100110,$00,$00
    ds     $28,#$00
    org $3A00                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011100,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3A40                         ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00111000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3A80                         ;hair
    .byte #%00011000,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $3AC0                          ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000110,$00,$00
    .byte #%00110000,$00,$00
    ds     $28,#$00
    org $3B00                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3B40                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3B80                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $3BC0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01100110,$00,$00
    ds     $28,#$00
    org $3C00                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3C40                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3C80                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $3CC0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%00000010,$00,$00
    .byte #%01100000,$00,$00
    ds     $28,#$00
    org $3D00                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3D40                         ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3D80                         ;hair
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $3DC0                          ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000110,$00,$00
    ds     $28,#$00
   org $3E00                           ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3E40                          ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3E80                          ;hair
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $3EC0                           ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%01000000,$00,$00
    .byte #%00000110,$00,$00
    ds     $28,#$00
   org $3F00                          ;suit
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00011000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3F40                         ;face and hands
    .byte #%00000000,$00,$00
    .byte #%00111100,$00,$00
    .byte #%00111100,$00,$00
    .byte #%01011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
    org $3F80                         ;hair
    .byte #%00011000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    ds     $28,#$00
   org $3FC0                          ;shoes
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000000,$00,$00
    .byte #%00000010,$00,$00
    .byte #%01100000,$00,$00
    ds     $28,#$00
End
