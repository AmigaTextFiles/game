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

xp = 2
yp = 1

FreeBrush
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD03 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD07 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD11 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD15 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD19 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD23 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD27 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD31 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD35 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD39 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD43 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD47 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD51 "ILBM" "COMPR=1"'
FreeBrush

xp = 2
yp = yp + 131

DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD04 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD08 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD12 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD16 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD20 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD24 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD28 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD32 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD36 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD40 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD44 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD48 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD52 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD02 "ILBM" "COMPR=1"'
FreeBrush

xp = 2
yp = yp + 131

DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD05 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD09 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD13 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD17 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD21 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD25 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD29 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD33 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD37 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD41 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD45 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD49 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD53 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD01 "ILBM" "COMPR=1"'
FreeBrush

xp = 2
yp = yp + 131

DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD06 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD10 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD14 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD18 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD22 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD26 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD30 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD34 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD38 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD42 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD46 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD50 "ILBM" "COMPR=1"'
FreeBrush

xp = xp + 90
DefineBrush xp yp xp+87 yp+129 'POINTS'
SaveBrush 'dh1:t/CARD54 "ILBM" "COMPR=1"'
FreeBrush


