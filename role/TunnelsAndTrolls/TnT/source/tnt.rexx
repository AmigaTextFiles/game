/* Program to show certain variables from T&T 4.32+ character files. */

PARSE ARG filename
IF ~OPEN('binfile',filename'.tnt','READ') THEN DO
    SAY "Can't open "filename".tnt!"
    EXIT
END
THEVALUE = C2D(READCH('binfile',1))     /* byte   0       */
IF THEVALUE != '07' THEN DO
    SAY "Not a valid T&T character file (wrong magic number)!"
    EXIT
END
THEVALUE = C2D(READCH('binfile',1))     /* byte   1       */
IF THEVALUE < '65' THEN DO
    SAY "Not a valid T&T 4.32+ character file (obsolete version)!"
    EXIT
END
VOID = SEEK('binfile',26)               /* bytes  2..  27 */
THEVALUE = C2D(READCH('binfile',1))     /* byte  28       */
SAY "Level:        "THEVALUE
THEVALUE = C2D(READCH('binfile',4))     /* bytes 29..  32 */
SAY "AP:           "THEVALUE
VOID = SEEK('binfile',42)               /* bytes 33..  74 */
MODULES=0
DO N=1 TO 31
    THEVALUE = C2D(READCH('binfile',1)) /* bytes 75.. 105 */
    IF THEVALUE = '01' THEN MODULES=MODULES+1
END
SAY "Modules done: "MODULES" of 31"
