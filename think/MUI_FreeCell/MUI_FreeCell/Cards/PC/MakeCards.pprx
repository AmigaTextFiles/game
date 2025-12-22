/* Personal Paint Amiga Rexx script - Copyright © 1996 Cloanto Italia srl */

/* $VER: XTool.pprx 1.0 */

/** ENG
 This is a example of a "tool script". This tool, entirely created in
 Rexx, draws an "X" on the image, using the current brush, foreground
 color and paint mode.
*/

/** DEU
 Dies ist ein Beispiel für ein "Tool Skript". Dieses ausschließlich
 in Rexx geschriebene Tool zeichnet ein "X" auf das Bild, wobei die
 aktuellen Einstellungen für Brush, Vordergrundfarbe und Malmodus
 verwendet werden.
*/

IF ARG(1, EXISTS) THEN
    PARSE ARG PPPORT .
ELSE
    EXIT 0  /* macro execution only */

ADDRESS VALUE PPPORT
OPTIONS RESULTS
OPTIONS FAILAT 10000

Get 'LANG'
IF RESULT = 1 THEN DO       /* Deutsch */
    txt_err_oldclient = 'Für dieses Skript_ist eine neuere Version_von Personal Paint erforderlich'
END
ELSE IF RESULT = 2 THEN     /* Italiano */
    txt_err_oldclient = 'Questa procedura richiede_una versione più recente_di Personal Paint'
ELSE                /* English */
    txt_err_oldclient = 'This script requires a newer_version of Personal Paint'

Version 'REXX'
IF RESULT < 7 THEN DO
    RequestNotify 'PROMPT "'txt_err_oldclient'"'
    EXIT 10
END

xp = 0
yp = 0

FreeBrush
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD03 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD07 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD11 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD15 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD19 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD23 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD27 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD31 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD35 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD39 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD43 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD47 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD51 "ILBM" "COMPR=1"'
FreeBrush

xp = 0
yp = yp + 98

DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD04 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD08 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD12 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD16 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD20 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD24 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD28 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD32 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD36 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD40 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD44 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD48 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD52 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD02 "ILBM" "COMPR=1"'
FreeBrush

xp = 0
yp = yp + 98

DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD05 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD09 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD13 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD17 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD21 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD25 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD29 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD33 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD37 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD41 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD45 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD49 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD53 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD01 "ILBM" "COMPR=1"'
FreeBrush

xp = 0
yp = yp + 98

DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD06 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD10 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD14 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD18 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD22 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD26 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD30 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD34 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD38 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD42 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD46 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD50 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 73
DefineBrush xp yp xp+70 yp+95 'POINTS'
SaveBrush 'T:CARD54 "ILBM" "COMPR=1"'
FreeBrush


