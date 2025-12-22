;$VER: TilesSlide 3.0 (2.11.2023)
;-> Executable MED for General MIDI instruments launcher
;-> Made by Stefano Maria Regattin
;i> Saturday, 11th August 2007
;m> 15,16 Aug 2007
;m> 2 Sep 2007
;m> 14,30 Jan 2008
;m> 2,17,18,20 Feb 2008
;m> 6,22 Mar 2008
;m> 30 Apr 2008
;m> 5,12 May 2008
;m> 29 Dec 2011
;m> 4,15 Mar 2012
;m> 13 Sep 2012
;m> 16 Sep 2013
;m> 2 Nov 2013
;m> 23 May 2018
;m> 25 Feb 2020
;m> 25 Sep 2020
;m> 9,10 Dec 2021
;m> 2 Nov 2023
;--------------
Set Musica=`RequestChoice TITLE "TilesSlide 3.0 request" BODY "Select the MIDI song to listen..." GADGETS "AuMiDD|BluBro|BubBob|DonKon|QuiBal|None"`
If $Musica EQ "1"
 Run >NIL: AugustMiddleDay.EXE
EndIf
If $Musica EQ "2"
 Run >NIL: BluesBrothers.EXE
EndIf
If $Musica EQ "3"
 Run >NIL: BubbleBobbleInGame.EXE
EndIf
If $Musica EQ "4"
 Run >NIL: DonkeyKong.EXE
EndIf
If $Musica EQ "5"
 Run >NIL: QuickBallet.EXE
EndIf
Run >NIl: TilesSlide
UnSet Musica
