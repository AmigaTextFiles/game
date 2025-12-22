; MazezaM Apple ][ Version (C) 2004 by Ventzislav Tzvetkov
;  drHirudo@Amigascne.org           http://drhirudo.hit.bg
;
; This game is also available for Amiga, GameBoy, Oric Atmos and
; Sinclair ZX Spectrum. Visit my website for more information.
;

#if PACKED

NOPACKED = 0             ; 1 for the Work Release , 0 for the public

#else

NOPACKED = 1

#endif
        processor 6502

PAGE   = $E6             ;Selected page (#$20 or #$40)
HTAB   = $24
VTAB   = $25
RNDL   = $4E             ;Pseudo random number.
IOSAVE = $FF4A           ;Saves the registers at $45 etc..
IORESTORE = $FF3F        ;Restore registers.
WAIT   = $FCA8           ;Wait A.
RESET  = $3F3            ;Reset vector.
PREAD  = $FB1E           ;Y = PDL(X).
SETPWRC = $FB6F          ;Set reset vector.
SPEAKER = $C030          ;Speaker softswitch.

DELAYTIME = #177

DELIMO  = $84            ;used in the divison subroutine
OSTATYK = $85            ;DELIMO  = DELIMO/DELITEL
DELITEL = $86            ;OSTATYK = DELIMO%DELITEL
LVLX1Y1 = $87            ;Level bytes
LVLX2Y1 = $88            ;Max level size
LVLX1Y2 = $89            ;16 * 12 (2 bytes * 8 bits * 12)
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
WIDTH   = $9D            ;Level width
HEIGHT  = $9E            ;Level height
LX      = $9F            ;In line. Later used as I.
RX      = $A0            ;Out line
R       = $A3
LEVELNL = $A4            ;Name pointer
LEVELNH = $A5
I       = LX    ;to save some bytes
J       = $A7
JOYFLAG = $A8   ;if joystick is present set, else clear.
SOUNDFLAG = $A9

;macros

            mac     pushxy
            txa
            pha
            tya
            pha
            endm

           include MazezaM.h

;Begin    4 byte DOS 3.3 header

         org MazezaMORG

#if NOPACKED
         org MazezaMORG-4
LONG = END-START
        .byte #<START
        .byte #>START
        .byte #<LONG
        .byte #>LONG
#endif
START                            ;Inits
#if NOPACKED
        jsr MODEL                   ;Show Apple Model while drawing.
                                    ;If packed - it's in the depack routine.
#endif
        lda #<MazezaMORG            ;Set reset vector
        sta RESET-1                 ;to point of the start of the program
        lda #>MazezaMORG            ;i.e. pressing RESET button will
        sta RESET                   ;do jmp MazezaMORG.
        jsr SETPWRC                 ;Actualize $3F4 on flag.
        ldx #0                      ;check if Joystick is present.
        stx JOYFLAG
        lda #$20
        sta PAGE
TITLESC lda #1                      ;print title screen
        sta MAZENO
        jsr CLEAR
        jsr UPBRKS
        ldy #3
BRICKLO ldx #39
BRICKLI jsr PUTXYCHAR
        pha
        tya
        adc #9
        sta VTAB
        pla
        jsr PUTXCHAR
        dex
        bpl BRICKLI
        dey
        bne BRICKLO
        ldy #4
BRCI    sty VTAB
PUTRBRICK
        ldx #39
PUTLBRICK
        jsr PUTXCHAR
        dex
        jsr PUTXCHAR
        dex
        jsr PUTXCHAR
        dex
        jsr PUTXCHAR
        dex
        jsr PUTXCHAR
        dex
        bmi BRY
        ldx #4
        bne PUTLBRICK
BRY     iny
        cpy #10
        beq TITLE
        bne BRCI
TITLE   ldx #5
        lda #22
        sta HTAB
        stx VTAB
        inx
PRINTMT lda TitleText,x             ;Print MazezaM
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTMT
        ldx #24
        ldy #32
        sty HTAB
        lda #7
        sta VTAB
PRINTAT lda AppleText,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTAT
        inc VTAB
        sty HTAB
        ldx #24
PRINTAT2 lda AppleText2,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTAT2
        lda #22
        sta HTAB
        lda #14
        sta VTAB
        ldx #4
PRINTK1 lda KeysText,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTK1
        lda #16
        sta VTAB
        lda #26
        sta HTAB
        ldx #12
PRINTK2 lda KeysText2,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTK2
        lda #18
        sta VTAB
        ldy #34
        sty HTAB
        ldx #29
PRINTK3 lda KeysText3,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTK3
        lda #21
        sta VTAB
        ldy #30
        sty HTAB
        ldx #19
PRINTSP lda SpaceText,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl PRINTSP
        lda #23
        sta VTAB
        iny
        ldx #39
        stx HTAB
PRINTU  lda URLText,x
        jsr DRAWINVERSECHAR      ;print the URL line (inversed).
        dec HTAB
        dex
        bpl PRINTU
        lda $C057
SHOW    lda PAGE
        cmp #$20
        bne PAGE2
        lda $C054
        jmp GFSW
PAGE2   lda $C055              ;switch to high res graphics.
GFSW    lda $C050              ;switch to graphics.
        lda $C052              ;full page (no mixed text/graphics).
        lda $C010
MUZAK   ldx #TITLEMUSICDELAYS-TITLEMUSICNOTES   ;longitudity of the music
KEY     txa
        pha
        lda TITLEMUSICNOTES-1,x
        sta PITCH
        lda TITLEMUSICDELAYS-1,x
        sta DURATION
        jsr PLAYSOUND
        jsr DELAY
        lda $C061                  ;Check if JoyStick button 1 was pressed.
        bmi GBEGIN
        pla
        tax
        dex
        beq MUZAK                  ;loop the music on the title.
        lda $C000
        cmp #$A0                   ;check if SPACE was pressed.
        bne KEY
GBEGIN  lda #1                     ;Yes. Start the game.
        sta MAZENO
        lda #3
        sta LIVES
GAME    lda MAZENO
        jsr LEVEL
GAMELO  lda $C010
GKEY    inc RNDL                   ;Increment the RNDL cell.
        lda T
        sec
        adc I
        sta VTAB
        lda L
        clc
        adc J
        sta HTAB
        lda $C000
#if NOPACKED
        cmp #$A0
        beq SPACEKEY   ; it doesn't appear in the public release
#endif
        cmp #136     ;Left Arrow
        beq LEFTKEY
        cmp #180     ;4 key
        beq LEFTKEY
        cmp #149     ;Right Arrow
        beq RIGHTKEY
        cmp #182     ;6 key
        beq RIGHTKEY
        cmp #184     ;8 key
        beq UPKEY
        cmp #178     ;2 Key
        beq DOWNKEY
        and #%11011111 ;Clear the third bit, so it will work Apple ][ and //e
                       ;i.e. convert to uppercase.
        cmp #193     ;A key
        beq UPKEY
        cmp #139     ;Up arrow
        beq UPKEY
        cmp #218     ;Z 
        beq DOWNKEY
        cmp #138
        beq DOWNKEY  ;Down arrow
        cmp #210
        beq RKEY
        cmp #209
        beq QKEY
        cmp #155     ;Escape Pressed
        beq QKEY
        cmp #144     ;Ctrl+P for JoyStick.
        bne JoyStick
        sta JOYFLAG
JoyStick subroutine
.3      jsr DELAY               ;Else it's too fast.
        lda JOYFLAG             ;Check the joystick flag.
        beq .2     ;No joystick present. The buttons (Apple-keys) still work).
        ldx #0                  ;Read Joystick if present.
        jsr PREAD
        cpy #30    ;pdl(0) < 30
        bcc LEFTKEY
        cpy #210   ;pdl(0) > 210
        bcs RIGHTKEY
        inx
        jsr PREAD
        cpy #30    ;pdl(1) < 30
        bcc UPKEY
        cpy #210   ;pdl(1) >210
        bcs DOWNKEY
        lda $C061               ;read joystick buttons. If both are pressed = RKEYP
        bpl .2
        lda $C062
        bmi RKEY
.2      jmp GKEY

#if NOPACKED 
SPACEKEY inc MAZENO             ; Doesn't appear in the public release.
        jmp GAME
#endif

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

PUTXYCHAR sty VTAB
PUTXCHAR stx HTAB
DRAWCHAR subroutine
        jsr IOSAVE
        lda #0
        sta HLP
        lda VTAB
        asl
        asl
        asl
        jsr $F411  ;gives in $26 and $27 first byte address
        lda $45    ;load the saved A
        asl        ;multiplicate by 8
        rol HLP
        asl
        rol HLP
        asl
        rol HLP
; end of multiplication
        sta $8
        lda HLP
        adc #>Characters ;Get charcter high address
        sta $9           ;and put it on $9
        lda #8
        sta HLP
        ldx #0
        ldy HTAB
.1      lda ($8,x)       ;get character byte
        sta ($26),y      ;put it on the graphics page
        inc $8
        bne .2
        inc $9
.2      lda #4           ;!for addressing of
        clc              ;!next row from
        adc $27          ;!the graphic page
        sta $27
        dec HLP
        bne .1
        jmp IORESTORE    ;restore registers

;INVERSEDRAW

DRAWINVERSECHAR subroutine
        jsr IOSAVE
        lda #0
        sta HLP
        lda VTAB
        asl
        asl
        asl
        jsr $F411  ;gives in $26 and $27 first byte address
        lda $45    ;load the saved A
        asl        ;multiplicate by 8
        rol HLP
        asl
        rol HLP
        asl
        rol HLP
; end of multiplication
        sta $8
        lda HLP
        adc #>Characters
        sta $9
        lda #8
        sta HLP
        ldx #0
        ldy HTAB
.1      lda ($8,x)
        eor #%01111111    ;invert the character byte
        sta ($26),y
        inc $8
        bne .2
        inc $9
.2      lda #4           ;!for addressing of
        clc              ;!next row from
        adc $27          ;!the graphic page
        sta $27
        dec HLP
        bne .1
        jmp IORESTORE    ;restore registers

; Level Drawing routine

LEVEL subroutine
        tax                       ;save the register
        lda #$20
        cmp PAGE
        beq .1                    ;switch to the other page
        bne .2
.1      lda #$40
.2      sta PAGE
        jsr CLEAR
        lda LEVELSWIDTHTABLE-1,x  ;use the saved reg to get the widht
        sta WIDTH
        lda LEVELSHEIGHTTABLE-1,x ;and height
        sta HEIGHT
        lda LXTABLE-1,x           ;and LX
        sta LX
        lda RXTABLE-1,x           ;and RX
        sta RX
        lda #>LVLPNT    ;set return address - on the levelprint
        pha             ;put address on stack to simulate jump
        lda #<LVLPNT-1
        pha
        txa       ;return the saved x to the accumulator
        asl       ;double to create index
        tax       ;for address table
        lda LEVELSTABLE-1,x ; High order byte
        pha
        lda LEVELSTABLE-2,x   ;Low order byte
        pha
        lda NAMESTABLE-1,x
        sta LEVELNH         ;get text index
        lda NAMESTABLE-2,x
        sta LEVELNL
        rts
LVLPNT  jsr UPBRKS
        ldx #4
        lda #13
        jsr PUTXCHAR
        ldx #15
        jsr PUTXCHAR
        ldx #23
        jsr PUTXCHAR
        ldx #34
        jsr PUTXCHAR
        ldx #11
        ldy #4
LTX     dex
        lda UpLvlText1,y
        jsr PUTXCHAR
        txa
        pha
        adc #19
        tax
        lda UpLvlText2,y
        jsr PUTXCHAR
        pla
        tax
        dey
        bpl LTX
        lda MAZENO
        sta DELIMO
        ldy #10
        sty DELITEL
        jsr DIVISION
        clc
        lda DELIMO
        adc #16
        ldx #12
        jsr PUTXCHAR
        lda OSTATYK
        adc #16
        inx
        jsr PUTXCHAR
        lda LIVES
        sta DELIMO
        jsr DIVISION
        ldx #31
        clc
        lda DELIMO
        adc #16
        jsr PUTXCHAR
        lda OSTATYK
        adc #16
        inx
        jsr PUTXCHAR
        lda #40    ;l=((40-w)/2);t=((24-h)/2);r=38-l-w;
        sec
        sbc WIDTH
        lsr
        sta L
        lda #24
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
        lda #8                 ;for (i=0;i<t;i++) printf(" ''''
        inc VTAB
        ldy T
BRoo    ldx #39
BRoi    jsr PUTXCHAR
        dex
        bpl BRoi
        inc VTAB
        dey
        bne BRoo
        sty LOOP
        ldy HEIGHT
LDLOOP  lda #0
        sta HTAB
        lda LOOP
        cmp LX
        bne LBRICKS
        lda #63
        bne LDXL
LBRICKS lda #8
LDXL    ldx L
LIM     jsr DRAWCHAR
        inc HTAB
        dex
        bpl LIM
        lda LOOP
        jsr RENDER
        lda #39
        sta HTAB
        lda LOOP
        cmp RX
        bne RBRICKS
        lda #63
        bne RDXL
RBRICKS lda #8
RDXL    ldx R
RIM     jsr DRAWCHAR
        dec HTAB
        dex
        bpl RIM
        inc VTAB
        inc LOOP
        dey
        bne LDLOOP
                    ;for (i=t+h;i<22;i++)
        lda T
        clc
        adc HEIGHT
        sta LOOP
        lda #22
        sec
        sbc LOOP
        tay
        lda #8
DWBRKS  ldx #39
DWNBRKS jsr PUTXCHAR
        dex
        bpl DWNBRKS
        inc VTAB
        dey
        bne DWBRKS
        pha      ;j = strlen(n[0]
        lda #37  ;for (k=0;k<((37-j)/2);k++)
        sec
        sbc (LEVELNL),y
        lsr  ; divide it by two
        tax
        tay
        pla
LTBRICK jsr PUTXCHAR               ; put brick on left and right
        pha
        lda #39
        sec
        sbc HTAB
        sta HTAB
        pla
        jsr DRAWCHAR
        dex
        bpl LTBRICK
        iny
        tya
        clc                        ; x is -1 LEVELNL+1+(-1)=LEVELNL
        adc (LEVELNL+1),x          ; put name between the bricks
        sta HTAB                   ; set end HTAB
        lda (LEVELNL+1),x          ; get name lenght
        tay
NameTex lda (LEVELNL),y
        jsr DRAWCHAR
        dec HTAB
        dey
        bne NameTex
        jsr SHOWL
        ldx #0
        sec
        lda T
        adc LX
        tay      ;k=t+lx+1
        lda #2
        jsr PUTXYCHAR
        ldx L
        jsr RUNC
        dec HTAB
        lda #1
        sta J      ;i=lx;j=1
        lda #9
        jsr DRAWCHAR     ;sound here
        lda #160
        sta PITCH
        lda #2
        sta DURATION
        jmp PLAYSOUND

SHOWL subroutine
        lda PAGE
        cmp #$20
        bne LEPAGE2
        lda $C054
        jmp .1
LEPAGE2 lda $C055
.1      rts

UPBRKS subroutine     ;Draws the upper bricks
        ldx #$00
        stx VTAB
        lda #8
        jsr PUTXCHAR
        inx
        jsr PUTXCHAR
        ldx #18
        jsr PUTXCHAR
        inx
        jsr PUTXCHAR
        inx
        jsr PUTXCHAR
        ldx #38
        jsr PUTXCHAR
        inx
        jsr PUTXCHAR
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
        lda #8
        ldy #0
        tax
        jsr PUTXYCHAR
        dex
        jsr PUTXCHAR
        dex
        jsr PUTXCHAR
        ldy #23
.1      tax
.2      jsr PUTXYCHAR
        dex
        bpl .2
        dey
        bne .1
        ldy #12
        tax
        lda #63
.3      jsr PUTXYCHAR              ;Draw _
        dex
        bpl .3
        iny
        lda #4
        ldx #9
        jsr PUTXYCHAR
        tay
.6      inx
        lda HTAB
        lsr
        bcs .4
        lda #4
        bne .5
.4      lda #3
.5      jsr PUTXCHAR
        dey
        bne .6
        lda #23
        sta VTAB
        ldy #8
.10     lda #9                 ;Draw Water
        sta HTAB
        ldx #5
.7      lda HTAB
        lsr
        bcs .8
        lda #5
        bne .9
.8      lda #6
.9      jsr DRAWCHAR
        inc HTAB
        dex
        bne .7
        dec VTAB
        dey
        bne .10
        ldx #9
.12     lda #11
        jsr PUTXCHAR
        inx
        lda #10
        jsr PUTXCHAR
        inx
        cpx #15
        bne .12
        ldx #23
        stx VTAB
        ldy #10
GROUND subroutine
.10     lda #39                 ;Draw GROUND
        sta HTAB
        ldx #27
.7      lda HTAB
        lsr
        bcs .8
        lda #6
        bne .9
.8      lda #5
.9      jsr DRAWCHAR
        dec HTAB
        dex
        bne .7
        dec VTAB
        dey
        bne .10
        inc HTAB
        inc HTAB
GRASS subroutine       
        ldx     #26
.7      lda HTAB
        lsr
        bcs .8
        lda #4
        bne .9
.8      lda #3
.9      jsr DRAWCHAR
        inc HTAB
        dex
        bne .7
TEXT subroutine
        lda #5
        sta VTAB
        lda #34
        sta HTAB
        ldx #7
        
.1      dec VTAB
        lda EndText1,x
        jsr DRAWCHAR
        lda EndText2,x
        inc VTAB
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl .1
        inc VTAB
        inc VTAB
        ldx #9
.2      lda EndText3,x
        jsr DRAWINVERSECHAR
        inc HTAB
        dex
        bpl .2
        jsr SHOWL
        inx
        ldy #12
        lda #2
        jsr PUTXYCHAR
        sta DELIMO
        ldx #8
FINALRUN subroutine
        jsr RUNC
        ldx #17
.2      inc HTAB
        jsr DRAWMAN
        dec HTAB
        lda #0
        jsr DRAWCHAR
        inc HTAB
        jsr DELAY
        dex
        bpl .2
        lda #33
        sta HTAB
        lda #9
        sta VTAB
        ldx #6
.3      lda EndHurray,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl .3
        ldx HTAB
        inx
.4      lda #0
        jsr PUTXYCHAR
        inx
        dey
        lda #2
        jsr PUTXYCHAR
        jsr DELAY
        dec DELIMO
        bne .4
        lda #2
        sta DELIMO
.5      lda #0
        jsr PUTXYCHAR
        inx
        lda #2
        jsr PUTXYCHAR
        jsr DELAY
        dec DELIMO
        bne .5
        lda #2
        sta DELIMO
.6      lda #0
        jsr PUTXYCHAR
        inx
        iny
        lda #2
        jsr PUTXYCHAR
        jsr DELAY
        dec DELIMO
        bne .6
        lda #33
        sta HTAB
        lda #9
        sta VTAB
        ldx #6
        stx DELIMO
        lda #0
.end    jsr DRAWCHAR
        dec HTAB
        dex
        bpl .end
        ldx #33
        ldy #12
.7      lda #0
        jsr PUTXYCHAR
        inx
        lda #2
        jsr PUTXYCHAR
        jsr DELAY
        dec DELIMO
        bne .7
        lda $C010
        lda #10
        sta VTAB
        ldx #16
.CONGR  lda CongrText,x
        jsr DRAWCHAR
        dec HTAB
        dex
        bpl .CONGR
EMUZAK  ldx #70
.WAIT   txa
        pha
        lda COMPLETEDNOTES-1,x
        sta PITCH
        lda COMPLETEDDELAYS-1,x
        sta DURATION
        jsr PLAYSOUND
        jsr DELAY
        lda $C061
        bmi GTTITLE
        lda $C062
        bmi GTTITLE
        pla
        tax
        dex
        beq GTTITLE
        lda $C000
        cmp #$A0
        bne .WAIT
GTTITLE lda #$20
        cmp PAGE
        beq .P1                    ;switch to the other page
        bne .P2
.P1      lda #$40
.P2      sta PAGE
        jmp TITLESC

RENDER  sta DELIMO            ;render the level line (A) VTAB is set
        sta HLP
        pushxy
        lda #6
        sta DELITEL
        jsr DIVISION
        ldx #8
        stx DELIMO
        ldx L       ;k=l+1
        inx
        stx HTAB
        ldy WIDTH
        lda OSTATYK
        asl
        tax
        lda LINESTABLE+1,x ; High order byte
        pha
        lda LINESTABLE,x   ;Low order byte
        pha
        lda HLP
        asl
        tax
        lda LVLX1Y1,x
        rts

LINE1   subroutine
.3      rol
        pha
        bcs .1
        lda #0
        beq .4
.1      lda HTAB
        lsr
        bcs .2
        lda #3
        bne .4
.2      lda #4
.4      jsr DRAWCHAR
        inc HTAB
        pla
        dec DELIMO
        beq .6
        dey
        beq .5
        bne .3
.6      lda LVLX1Y1+1,x
        dey
        bne .3
.5      jmp popxy
     

LINE2   subroutine
.3      rol
        pha
        bcs .1
        lda #0
        beq .4
.1      lda HTAB
        lsr
        bcs .2
        lda #5
        bne .4
.2      lda #6
.4      jsr DRAWCHAR
        inc HTAB
        pla
        dec DELIMO
        beq .6
        dey
        beq .5
        bne .3
.6      lda LVLX1Y1+1,x
        dey
        bne .3
.5  jmp popxy

LINE3   subroutine
.3      rol
        pha
        bcs .1
        lda #0
        beq .4
.1      lda HTAB
        lsr
        bcs .2
        lda #4
        bne .4
.2      lda #3
.4      jsr DRAWCHAR
        inc HTAB
        pla
        dec DELIMO
        beq .6
        dey
        beq .5
        bne .3
.6      lda LVLX1Y1+1,x
        dey
        bne .3
.5  jmp popxy

LINE4   subroutine
.3      rol
        pha
        bcs .1
        lda #0
        beq .4
.1      lda HTAB
        lsr
        bcs .2
        lda #6
        bne .4
.2      lda #5
.4      jsr DRAWCHAR
        inc HTAB
        pla
        dec DELIMO
        beq .6
        dey
        beq .5
        bne .3
.6      lda LVLX1Y1+1,x
        dey
        bne .3
.5  jmp popxy

LINE5   subroutine
.3      rol
        pha
        bcs .1
        lda #0
        beq .4
.1      lda HTAB
        lsr
        bcs .2
        lda #62
        bne .4
.2      lda #64
.4      jsr DRAWCHAR
        inc HTAB
        pla
        dec DELIMO
        beq .6
        dey
        beq .5
        bne .3
.6      lda LVLX1Y1+1,x
        dey
        bne .3
.5      jmp popxy
     

LINE6   subroutine
.3      rol
        pha
        bcs .1
        lda #0
        beq .4
.1      lda HTAB
        lsr
        bcs .2
        lda #60
        bne .4
.2      lda #7
.4      jsr DRAWCHAR
        inc HTAB
        pla
        dec DELIMO
        beq .6
        dey
        beq .5
        bne .3
.6      lda LVLX1Y1+1,x
        dey
        bne .3
.5  jmp popxy

RUNC subroutine              ;number of moves is in X
.1      inc HTAB             ;HTAB and VTAB are set
        jsr DRAWMAN
        dec HTAB
        lda #63
        jsr DRAWCHAR
        inc HTAB
        jsr DELAY
        dex
        bpl .1
        rts
popxy
        pla
        tay
        pla
        tax
        rts

DELAY   lda #DELAYTIME
        jmp WAIT

  ;The key is read so we decide what to do.

RIGHTKEYP subroutine
       ldy J
       cpy WIDTH
       beq .L
       bcc .1
.L     lda I       ;if (i==rx && j==w)
       cmp RX
       beq LEVELCOMPL
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
.4     inc J
       jsr CLEARMAN
       inc HTAB
.9     jsr DRAWMAN
       bne .RTS
.5     lda I
       asl
       tax
       lda WIDTH
       cmp #9
       bcc .22
       inx
       sbc #8
.22    sta HLP                ;y = number of right shifts to get w-1
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
.8     lda I
       jsr RENDER
       inc J
       clc
       lda L
       adc J
       sta HTAB
       bne .9

LEVELCOMPL subroutine
       jsr CLEARMAN
       inc HTAB          ;  for (i=l+w;i<39;i++)
       jsr DRAWMAN
       jsr DELAY
       lda #37
       sec
       sbc WIDTH
       sbc L
       tax
       jsr RUNC
       dec VTAB
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
       ldx #0
       lda (LEVELNL),x
       tay
.TXT   lda (LEVELNL),y
       jsr DRAWINVERSECHAR
       dec HTAB
       dey
       bne .TXT
       lda $C010
       ldx #12
.Muz   txa
       pha
       lda LEVELCOMPLNOTES-1,x
       sta PITCH
       lda LEVELCOMPLDELAYS-1,x
       sta DURATION
       jsr PLAYSOUND
       jsr DELAY
       pla
       tax
       lda $C000
       cmp #$A0
       beq .GO
       lda $C061
       bmi .GO
       dex
       bne .Muz
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
.4     dec J
       jsr CLEARMAN
       dec HTAB
.9     jsr DRAWMAN
       bne .RTS
.5     lda I
       asl
       tax
       lda LVLX1Y1,x      ;if (b[i][0]==0)
       bpl .6             ; yes
       bmi .RTSPK         ; else
.6     lda WIDTH
       cmp #9             ;if (WIDTH < 9) shift only 1 byte
       bcc .8             ;carry is cleared so it wouldn't affect the rol.
       inx
       lda LVLX1Y1,x      ;else shift 2 bytes.
       asl                ;first bit goes to carry.
       sta LVLX1Y1,x
       dex                ;previus byte of the level line.
.8     lda LVLX1Y1,x      ;get it.
       rol                ;set eight bit from the carry flag.
       sta LVLX1Y1,x
       lda I
       jsr RENDER
       dec J
       clc
       lda L
       adc J
       sta HTAB
       bne .9

UPKEYP subroutine
       ldx I
       dex
       bpl .1         ;if (direction==UP && i>1)
.RTSPK jsr PUK
.RTS   jmp GAMELO
.1     txa          ; if (b[i-1][j-1]==0)
       asl
       tax
       lda J
       cmp #9
       bcc .2
       inx
       sbc #8       
.2     tay                ;y = j
       lda LVLX1Y1,x      ;level part  b[i-1]
.3     asl
       dey
       bne .3
       bcc .4
       bcs .RTSPK          ;saves 1 byte
.4     dec I
       jsr CLEARMAN
       dec VTAB
       jsr DRAWMAN
       bne .RTS

DOWNKEYP subroutine
       ldx I
       inx
       cpx HEIGHT     ;if (direction==DOWN && i<H)
       bcc .1
.RTSPK  jsr PUK
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
.4     inc I
       jsr CLEARMAN
       inc VTAB
       jsr DRAWMAN
       bne .RTS

RKEYP subroutine
      lda #31
      jsr DRAWCHAR
      dec LIVES
      bne .1
      jmp QKEYP
.1    ldx #4
      dec VTAB
      inc HTAB
      lda RNDL
      sta DELIMO
      lda #9
      sta DELITEL
      jsr DIVISION
      lda OSTATYK
      asl            ;switch (rand()%9)
      tax
      lda RKEYPRESSTABLE+1,x
      sta LEVELNH         ;get text index
      lda RKEYPRESSTABLE,x
      sta LEVELNL
      ldy #4
.2    lda (LEVELNL),y
      jsr DRAWINVERSECHAR
      dec HTAB
      dey
      bpl .2
      ldx #8
.3
SND   ldy #3
      lda #63
      sta A1+1
A1    ldx #63
.A2   txa
.A3   dex
      bne .A3
      tax
      lda SPEAKER
      inc A1+1
      inx
      cpx #102
      bne .A2
      jsr DELAY
      dey
      bne A1
      ldx #12
.WTS  jsr DELAY
      lda $C000
      cmp $A0
      beq .EX
      dex
      bne .WTS
.EX   lda RNDL
      jsr CLEAR+2
      jmp GAME

QKEYP subroutine            ;QKEY was pressed or there is no lives left.
      lda #27
      jsr DRAWCHAR          ;Draw grave.
      lda #32
      sta HTAB
      lda #0
      sta VTAB
      lda #16
      jsr DRAWCHAR         ;Print 0 lives.
      dec HTAB
      jsr DRAWCHAR
      lda #24              ;Set Game Over Text location.
      sta HTAB
      lda #12
      sta VTAB
      ldx #8
.2    lda GOverText,x      ;Print Game Over Text.
      jsr DRAWINVERSECHAR
      dec HTAB
      dex
      bpl .2
GAMEOVER .subroutine
      lda $C010
      lda #7
      sta LOOP
      lda #180
ZOUND
      lda DELITEL
      pha
      lda #1
      sta DELIMO
.1    ldy DELIMO
.2    lda SPEAKER
      ldx DELITEL
.3    dex
      bne .3
      dey
      bne .2
      dec DELITEL
      bne .1
      jsr DELAY
      pla
      sbc #22
      dec LOOP
      bne ZOUND
endM  subroutine
      ldx #79
.3    jsr DELAY
      lda $C000
      cmp #$A0
      beq .4
      lda $C061               ;read joystick button.
      bmi .4
      dex
      bpl .3
.4    jmp GTTITLE

CLEARMAN subroutine
      lda #0
.3    jmp DRAWCHAR
DRAWMAN
      lda #2
      sta SOUNDFLAG
      bne .3
      
PUK subroutine
     lda SOUNDFLAG
     beq RTSS
     lda #86
     sta PITCH
     lda #4
     sta DURATION
     lda #0
     sta SOUNDFLAG

PLAYSOUND subroutine
     lda SPEAKER
.2   dey
     bne .1
     dec DURATION
     beq RTSS
.1   dex
     bne .2
     ldx PITCH
     jmp PLAYSOUND
RTSS rts

CLEAR subroutine
     lda #0
     sta $1C
     lda $E6
     sta $1B
     ldy #0
     sty $1A
.2   lda $1C
     sta ($1A),y
     jsr .3
     iny
     bne .2
     inc $1B
     lda $1B
     and #$1F
     bne .2
     rts
.3   asl
     cmp #$C0
     bpl .4
     lda $1C
     eor #$7F
     sta $1C
.4   rts
  ;section DATA

PITCH    .byte 0
DURATION .byte 0

LEVELCOMPLNOTES
    .byte 72,96,144,128,192,230,216,144,107,96,128,192
LEVELCOMPLDELAYS
    .byte 170,30,90,120,30,90,120,30,90,120,30,90

TITLEMUSICNOTES
     .byte 120,114,145,114,120,107,120,107,120,107,145,114,120,107,120
     .byte 107,120,107,136,120,153,145,136,120,128,136,120,136
     .byte 120,136,120,136,120,136,120,162,153,145,136,120
     .byte 96,85,76,85,76,72,76,72,64,57,64
     .byte 96,85,76,72,76,72,64,57,64
     .byte 96,85,76,72,76,72,64,57,64,85,72,102,85,128,102
     .byte 72,76,72,85,72,76,72,85,72,76,72,85,57,64,57
     .byte 72,57,64,57,72,57,64,57,72,57,54,45,57,48,54
     .byte 48,57,48,54,48,57,96,72,114,96,114,144,128,114
     .byte 108,114,108,96,85,96,85,76,72,144,96,144,114,144

TITLEMUSICDELAYS
     .byte 128,128,68,68,48,68,48,68,48,68,68,68,48,68,48
     .byte 68,48,68,68,68,68,68,68,68,68,68,68,68
     .byte 68,68,68,68,68,68,68,68,68,68,68,68
     .byte 255,248,245,186,158,130,105,99,88,72,64
     .byte 128,114,100,86,70,59,48,38,32
     .byte 128,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
     .byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
     .byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,64,64,64,64
     .byte 64,64,128,32,32,32,32,32,32,32,32,32,64,64,64,64,64,64

COMPLETEDNOTES

     .byte 102,96,85,96,128,128,128,128,114,102,96,114,144,96,85,76,128,144
     .byte 144,96,85,85,85,114,128,114,128,128,114,102,96,114,144,96,85,76
     .byte 128,144,144,96,85,85,85,152,171,152,114,128,114,102,96,114,114,102
     .byte 96,85,76,152,171,152,114,128,114,102,96,114,114,102,96,85,76,102

COMPLETEDDELAYS

     .byte 64,64,64,64,128,64,64,64,128,64,64,128,64,64,128,64,64,128
     .byte 64,64,64,64,255,64,64,128,64,64,128,64,64,128,64,64,128
     .byte 64,64,128,64,64,64,64,255,64,64,64,64,64,64,64,64,128
     .byte 64,64,64,192,255,64,64,64,64,64,64,64,64,128,64,64,64,192

LEVELSWIDTHTABLE
     .byte 7,8,5,13,14,7,16,15,9,14

LEVELSHEIGHTTABLE
     .byte 2,3,11,6,4,6,7,4,7,10

LXTABLE
     .byte 0,2,10,0,1,4,0,2,6,7

RXTABLE
     .byte 0,1,0,0,3,2,6,0,2,0

LINESTABLE
     dc.w #LINE1-1
     dc.w #LINE2-1
     dc.w #LINE3-1
     dc.w #LINE4-1
     dc.w #LINE5-1
     dc.w #LINE6-1

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
NAME1 .byte 14,40,85,77,66,76,69,0,47,82,73,71,73,78,83 ;Humble Origins
NAME2 .byte 12,37,65,83,89,0,36,79,69,83,0,41,84 ;Easy Does It
NAME3 .byte 16,53,80,12,0,53,80,0,0,65,78,68,0,33,87,65,89 ;Up, Up  and Away
NAME4 .byte 10,52,79,0,65,78,68,0,38,82,79 ;To and Fro
NAME5 .byte 12,44,79,79,80,0,68,69,0,44,79,79,80 ;Loop de Loop
NAME6 .byte 12,34,69,0,0,48,82,69,80,65,82,69,68 ;Be Prepared
NAME7 .byte 16,52,87,79,0,0,38,82,79,78,84,0,36,79,79,82,83 ;Two  Front Doors
NAME8 .byte 20,52,72,82,79,85,71,72,0,65,78,68,0,0,84,72,82,79,85,71,72,0 ;Through and  through
NAME9 .byte 12,36,79,85,66,76,69,0,35,82,79,83,83 ;Double Cross
NAMEA .byte 10,41,78,83,73,68,69,0,47,85,84 ;Inside Out

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

HURRAY1 .byte 7,40,"URRAY",1 ;Hurray!
HURRAY2 .byte 7,40,"URRAH",1 ;Hurrah!
HURRAY3 .byte 8,57,"ES",29,57,"ES",1 ;Yes-Yes!
HURRAY4 .byte 6,39,"REAT",1 ;Great!
HURRAY5 .byte 8,57,"EE",29,"HAH",1 ;Yee-hah!
HURRAY6 .byte 6,57,"AYIA",1 ;Yayia!
HURRAY7 .byte 7,57,"UPPIE",1 ;Yuppie!
HURRAY8 .byte 8,51,"UCCESS",1 ;Success!
HURRAY9 .byte 7,51,"UPER",34,1 ;SuperB!
HURRAYA .byte 7,39,"ROOVY",1 ;Groovy!
HURRAYB .byte 7,51,"UPAAH",1 ;Supaah!

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

ArghText   .byte 33,50,39,40,1 ;ARGH!
OuchText   .byte 47,53,35,40,1 ;OUCH!
GrrrText   .byte 39,50,50,50,1 ;GRRR!
NoouText   .byte 46,47,47,47,1 ;NOOU!
NaahText   .byte 46,33,33,40,1 ;NAAH!
UuufText   .byte 53,53,53,38,1 ;UUUF!
AaahText   .byte 33,33,33,40,1 ;AAAH!
OuufText   .byte 47,53,53,38,1 ;OUUF!
PuffText   .byte 48,53,38,38,1 ;PUFF!

GOverText  .byte 39,33,45,37,0,47,54,37,50 ;GAME OVER
TitleText  .byte 45,65,90,69,90,65,45 ;MazezaM
AppleText  .byte 33,80,80,76,69,0,61,59,0,86,69,82,83,73,79,78,0,28,35,30,0,18,16,16,20 ;Apple ][ Version (C) 2004
AppleText2 .byte 66,89,0,0,54,69,78,84,90,73,83,76,65,86,0,0,0,52,90,86,69,84,75,79,86  ;By  Ventzislav Tzvetkov
KeysText   .byte 43,37,57,51,26 ;KEYS:
KeysText2  .byte 45,47,54,37,0,29,0,33,50,50,47,55,51
KeysText3  .byte 50,37,52,50,57,0,44,37,54,37,44,0,29,0,82,0,0
           .byte 49,53,41,52,0,39,33,45,37,0,29,0,81
SpaceText  .byte 48,82,69,83,83,0,51,48,33,35,37,0,84,79,0,83,84,65,82,84
URLText    .byte 0,0,0,0,0,0,0,0,0,0,72,84,84,80,26,15,15,68,82,72,73,82,85,68,79,14,72,73,84,14,66,71,0,0,0,0,0,0,0,0
UpLvlText1 .byte 44,69,86,69,76
UpLvlText2 .byte 44,73,86,69,83
EndText1   .byte 57,79,85,0,72,65,86,69
EndText2   .byte 69,83,67,65,80,69,68,14
EndText3   .byte 1,37,46,47,36,0,44,44,37,55
EndHurray  .byte 40,85,82,82,65,89,1
CongrText  .byte 35,47,46,39,50,33,52,53,44,33,52,41,47,46,51,1 ;CONGRATULATIONS!
 org $1d00
Characters
           include MazezaMCharset.asm
END
