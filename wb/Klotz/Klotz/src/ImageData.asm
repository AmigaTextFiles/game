*
* $VER: ImageData.asm 0.6 (27.2.95) - Nur noch Logo
*		      0.5 (4.10.94)
*		      0.4 (5.9.93)
*
    SECTION "",DATA,CHIP
 ifne 0
    xdef   imWBlData
imWBlData
; Plane 1
 dc.w $0001
 dc.w $2AAB
 dc.w $1557
 dc.w $2AAB
 dc.w $1557
 dc.w $2AAB
 dc.w $1557
 dc.w $7FFF
; Plane 2
 dc.w $FFFE
 dc.w $FFFC ;$EAA8
 dc.w $FFFC ;$D554
 dc.w $FFFC ;$EAA8
 dc.w $FFFC ;$D554
 dc.w $FFFC ;$EAA8
 dc.w $FFFC ;$D554
 dc.w $8000

     xdef   imGrBlData
imGrBlData
; Plane 1
 dc.w $0001
 dc.w $2AAB
 dc.w $1557
 dc.w $2AAB
 dc.w $1557
 dc.w $2AAB
 dc.w $1557
 dc.w $7FFF
; Plane 2
 dc.w $FFFE
 dc.w $EAA8
 dc.w $D554
 dc.w $EAA8
 dc.w $D554
 dc.w $EAA8
 dc.w $D554
 dc.w $8000

     xdef   imSBlData
imSBlData
; Plane 1
 dc.w $0001
 dc.w $3FFF ;$2AAB
 dc.w $3FFF ;$1557
 dc.w $3FFF ;$2AAB
 dc.w $3FFF ;$1557
 dc.w $3FFF ;$2AAB
 dc.w $3FFF ;$1557
 dc.w $7FFF
; Plane 2
 dc.w $FFFE
 dc.w $EAA8
 dc.w $D554
 dc.w $EAA8
 dc.w $D554
 dc.w $EAA8
 dc.w $D554
 dc.w $8000

    xdef    imBlData
imBlData
 dc.w $0001,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$7FFF
 dc.w $FFFE,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$8000

    xdef    imGrData
imGrData
 dc.w $0001,$0003,$0003,$0003,$0003,$0003,$0003,$7FFF
 dc.w $FFFE,$C000,$C000,$C000,$C000,$C000,$C000,$8000

    xdef    imSGrData
imSGrData
 dc.w $0001,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$7FFF
 dc.w $FFFE,$C000,$C000,$C000,$C000,$C000,$C000,$8000

    xdef    imWGrData
imWGrData
 dc.w $0001,$0003,$0003,$0003,$0003,$0003,$0003,$7FFF
 dc.w $FFFE,$D554,$EAA8,$D554,$EAA8,$D554,$EAA8,$8000

* Lace - Images (added 4.10.94)
    xdef   imWBlDataLace
imWBlDataLace
 dc.w $0001,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$2AAB
 dc.w $1557,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$7FFF
 dc.w $FFFE,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC
 dc.w $FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$8000

     xdef   imGrBlDataLace
imGrBlDataLace
 dc.w $0001,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$2AAB
 dc.w $1557,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$7FFF
 dc.w $FFFE,$EAA8,$D554,$EAA8,$D554,$EAA8,$D554,$EAA8
 dc.w $D554,$EAA8,$D554,$EAA8,$D554,$EAA8,$D554,$8000

     xdef   imSBlDataLace
imSBlDataLace
 dc.w $0001,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF
 dc.w $3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$7FFF
 dc.w $FFFE,$EAA8,$D554,$EAA8,$D554,$EAA8,$D554,$EAA8
 dc.w $D554,$EAA8,$D554,$EAA8,$D554,$EAA8,$D554,$8000

    xdef    imBlDataLace
imBlDataLace
 dc.w $0001,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF
 dc.w $3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$3FFF,$7FFF
 dc.w $FFFE,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC
 dc.w $FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$FFFC,$8000

    xdef    imGrDataLace
imGrDataLace
 dc.w $0001,$0003,$0003,$0003,$0003,$0003,$0003,$0003
 dc.w $0003,$0003,$0003,$0003,$0003,$0003,$0003,$7FFF
 dc.w $FFFE,$C000,$C000,$C000,$C000,$C000,$C000,$C000
 dc.w $C000,$C000,$C000,$C000,$C000,$C000,$C000,$8000

    xdef    imSGrDataLace
imSGrDataLace
 dc.w $0001,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$2AAB
 dc.w $1557,$2AAB,$1557,$2AAB,$1557,$2AAB,$1557,$7FFF
 dc.w $FFFE,$C000,$C000,$C000,$C000,$C000,$C000,$C000
 dc.w $C000,$C000,$C000,$C000,$C000,$C000,$C000,$8000

    xdef    imWGrDataLace
imWGrDataLace
 dc.w $0001,$0003,$0003,$0003,$0003,$0003,$0003,$0003
 dc.w $0003,$0003,$0003,$0003,$0003,$0003,$0003,$7FFF
 dc.w $FFFE,$D554,$EAA8,$D554,$EAA8,$D554,$EAA8,$D554
 dc.w $EAA8,$D554,$EAA8,$D554,$EAA8,$D554,$EAA8,$8000

 endc
    xdef    LogoData
LogoData
 dc.w $07FF,$FFC0,$07FF,$FFF0,$07FC,$007C,$0FF8
 dc.w $001E,$0FF8,$000F,$0FF8,$000F,$1FF0,$001E,$1FF0
 dc.w $007C,$1FFF,$FFF8,$3FFF,$FFF0,$3FE0,$007C,$3FE0
 dc.w $001E,$7FC0,$000F,$7FC0,$000F,$7FC0,$001E,$FF80
 dc.w $007C,$FFFF,$FFF0,$FFFF,$FFC0,$0000,$0000,$C0CF
 dc.w $1F1F,$C0D9,$9998,$6D9F,$9F1E,$7FB0,$D998,$3330
 dc.w $D8DF,$A800,$000A,$5000,$0005,$A002,$AA00,$5001
 dc.w $5540,$A002,$AAA0,$4005,$5540,$A002,$AA80,$4005
 dc.w $5401,$8000,$0002,$4000,$0005,$800A,$AA02,$0015
 dc.w $5540,$800A,$AAA0,$0015,$5540,$002A,$AA80,$0015
 dc.w $5401,$0000,$0002,$0000,$0015,$AAAA,$AAAA,$1510
 dc.w $4040,$2A22,$2222,$0040,$4041,$800A,$2222,$4445
 dc.w $0500

    END
