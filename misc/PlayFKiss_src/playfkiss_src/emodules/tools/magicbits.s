    xdef byte2long_i
    xdef byte2word_i
    xdef word2byte_i
    xdef word2long_i
    xdef long2byte_i
    xdef long2word_i
    xdef pcword_i
    xdef pclong_i

byte2word_i:
    move.l  4(a7),d0        ; D0=$??????AB
    andi.l  #$ff,d0         ; D0=$000000AB
    move.l  d0,d1           ; D1=$000000AB
    lsl.l   #8,d1           ; D1=$0000AB00
    or.l    d1,d0           ; D0=$0000ABAB
    rts                     ; done

byte2long_i:
    move.l  4(a7),d0        ; D0=$??????AB
    andi.l  #$ff,d0         ; D0=$000000AB
    move.l  d0,d1           ; D1=$000000AB
    lsl.l   #8,d1           ; D1=$0000AB00
    or.l    d1,d0           ; D0=$0000ABAB
    move.l  d0,d1           ; D1=$0000ABAB
    swap    d1              ; D1=$ABAB0000
    or.l    d1,d0           ; D0=$ABABABAB
    rts                     ; done

word2byte_i:
    move.l  4(a7),d0        ; D0=$????AB??
    andi.l  #$ff00,d0       ; D0=$0000AB00
    lsr.w   #8,d0           ; D0=$000000AB
    rts                     ; done

word2long_i:
    move.l  4(a7),d0        ; D0=$????ABCD
    andi.l  #$ffff,d0       ; D0=$0000ABCD
    move.l  d0,d1           ; D1=$0000ABCD
    swap    d1              ; D1=$ABCD0000
    or.l    d1,d0           ; D0=$ABCDABCD
    rts                     ; done

long2byte_i:
    move.l  4(a7),d0        ; D0=$AB??????
    andi.l  #$ff000000,d0   ; D0=$AB000000
    rol.l   #8,d0           ; D0=$000000AB
    rts                     ; done

long2word_i:
    move.l  4(a7),d0        ; D0=$ABCD????
    andi.l  #$ffff0000,d0   ; D0=$ABCD0000
    swap    d0              ; D0=$0000ABCD
    rts                     ; done

pcword_i:
    move.l  4(a7),d0        ; D0=$????ABCD
    move.w  d0,d1           ; D1=$????ABCD
    andi.w  #$00ff,d1       ; D1=$????00CD
    lsl.l   #8,d1           ; D1=$??00CD00
    andi.l  #$ff00,d0       ; D0=$0000AB00
    lsr.l   #8,d0           ; D0=$000000AB
    or.w    d1,d0           ; D0=$0000CDAB
    rts                     ; done

pclong_i:
    move.l  4(a7),d0        ; D0=$12345678
    move.b  d0,d1           ; D1=$??????78
    move.l  d0,d2           ; D2=$12345678
    andi.l  #$000000ff,d1   ; D1=$00000078
    ror.l   #8,d1           ; D1=$78000000
    andi.l  #$0000ff00,d2   ; D2=$00005600
    lsl.l   #8,d2           ; D2=$00560000
    or.l    d1,d2           ; D2=$78560000
    ; upper byte
    move.l  d0,d1           ; D1=$12345678
    andi.l  #$00ff0000,d1   ; D1=$00340000
    lsr.l   #8,d1           ; D1=$00003400
    andi.l  #$ff000000,d0   ; D0=$12000000
    rol.l   #8,d0           ; D0=$00000012
    or.l    d1,d0           ; D1=$00003412
    or.l    d2,d0           ; D0=$78563412
    rts                     ; done
