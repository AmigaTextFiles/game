;$VER: SceltaGotcha199 1.0 (21.4.2022)
;i> 21 aprile 2022
;------------------
CD "Lavoro:Linguaggi/Compilati/Gotcha199"
Set SceltaGotcha199=`RequestChoice TITLE "Scelta Gotcha199" BODY "Which Gotcha199's version would you run?" GADGETS "AmiBlitz3|Blitz2|Forget"`
If $SceltaGotcha199 EQ "1"
 Run Gotcha199AB3
EndIf
If $SceltaGotcha199 EQ "2"
 Run Gotcha199
EndIF
UnSet SceltaGotcha199
