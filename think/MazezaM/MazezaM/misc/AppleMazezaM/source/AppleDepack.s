;««««««««««««««««««««««««««««»»»»»»»»»»»»»»»»»»»»»»»»»»
;« APPLE depacker for executables packed with PRGPACK »
;««««««««««««««««««««««««««««»»»»»»»»»»»»»»»»»»»»»»»»»»

                processor 6502
                include MazezaM.h           ;Some definitions there.

PackedOrigin    = $2000                     ;Can be any other.

PackedLenght    = 4096-4                    ;4096 - 4 bytes header
                org PackedOrigin-4
                .byte #<depacker
                .byte #>depacker
                .byte #<PackedLenght
                .byte #>PackedLenght

DEPACKADR       = MazezaMORG     ;Same as the assembled program.

strlen          = HLP            ;Zero page cells.
bitcode         = LOOP           ;They are used by BASIC, but BASIC is in
srcl            = MAZENO         ;no use in this game.
srch            = LIVES
destl           = L
desth           = T

depacker        jsr MODEL                       ;Show Apple ][ model.
                lda #<packeddata                ;Right after the depacker
                sta srcl                        ;I place the packed data.
                lda #>packeddata
                sta srch
                lda #>DEPACKADR                 ;DepackADR Hi
                sta desth
                lda #<DEPACKADR                 ;DepackADR Lo
                sta destl                       ;change it for your executable
                nop
                ldy #0
                ldx #0                          ;x and has to be 0 for a start.
depackstart:    txa                             ;Time to get new bit-code?
                bne dp_nonew
                jsr dp_get
                sta bitcode
                ldx #$08                        ;Eight bits now...
dp_nonew:       dex                             ;Get one bit from the bitcode,
                lsr bitcode                     ;that tells whether the next
                bcs dp_string                   ;byte in the stream is an
                jsr dp_get                      ;unpacked byte or a string
                jsr dp_put
                jmp depackstart
dp_string:      jsr dp_get                      ;If it's a string, take its
                sta dp_copystrpos+1             ;offset and length
                jsr dp_get
                sta strlen
dp_copystring:  dec desth                       ;String copying loop
dp_copystrpos:  ldy #$00
                lda (destl),y
                inc desth
                ldy #$00
                jsr dp_put
                dec strlen
                bne dp_copystring
                jmp depackstart

dp_get:         lda (srcl),y                    ;Get byte at source pointer
                pha
                tya
                sta (srcl),y
                inc srcl
                bne dp_get2
                inc srch
                lda srch
                cmp #$30          ;high end of the packed data
                beq start
dp_get2:        pla
                rts

start:          ;Everything is depacked. Start the depacked program.
                jmp DEPACKADR

dp_put:         sta (destl),y                   ;Put byte at destination
                inc destl                       ;pointer
                bne dp_put2
                inc desth
dp_put2:        rts

packeddata:
         ;incbin MazezaMpacked ;No headers just raw data eg /r switch
