;
; Vault Assault
; by Brian Prescott
;
; This version of Vault Assault is different from the version that debuted at the
; Classic Gaming Expo in August of 2001.  Basically, the only difference is that
; this version of the game does not have the Easter egg in it.
;

	processor 6502
	include vcs.h

scoreAreaBackColor	= $36
normalBackColor		= $00
normalBaseColor		= $06

firstDigitPosition	= 56
secondDigitPosition	= 64
explosionTimer		= 30
explosionTimerA		= 13
fireDelayTimer		= 10
baseExplosionTimer	= 127
newFighterDelayTimer	= 15
newFighterDelayTimerA	= 10
blankTheExplosion	= 10
blankTheExplosionA	= 6

; game modes
; bit 7: 0 = display ship, ignore cannon, 1 = display ship, cannon, etc.

modeSelect		= %00000000
modeBaseExploding	= %00000001

modePlay		= %10000001

	SEG.U ram
	org $80

gameMode	DS	1

backColor	DS	1
pfColor		DS	1
p0Color		DS	1
fighterColor	DS	1
scoreColor	DS	1

cannonPosition	DS	1	; 0 = not visible, 1 = top, 2 = left, 3 = right, 4 = bottom
firePosition	DS	1	; 0 = not visible, 1 = top, 2 = left, 3 = right, 4 = bottom
fireCounter	DS	1
middleFirePF	DS	6
middleCannonG	DS	1	; temporary place to store the playfield for the cannon in the middle
				; this is done to make the two scan lines go as quickly as possible
				; so that the playfield graphics don't distort

cannonTopG	DS	2	; temporary place to store the graphics to use for the ship
cannonMiddleG	DS	2
cannonBottomG	DS	2

fighterTopG	DS	2	; temporary place to store the graphics for the fighter or bombs
fighterMiddleG	DS	2
fighterBottomG	DS	2

fighterTopWait		DS	1
fighterTopPos		DS	1
fighterMiddleWait	DS	1
fighterMiddlePos	DS	1
fighterBottomWait	DS	1
fighterBottomPos	DS	1

explosionTopCtr		DS	1
explosionLeftCtr	DS	1
explosionRightCtr	DS	1
explosionBottomCtr	DS	1
explosionBaseCtr	DS	1

fbFlags		DS	1	; bit 7 = fighter on top, bit 6 = left, bit 5 = right, bit 4 = bottom
				; bit 3 = bomb on top, bit 2 = left, bit 1 = right, bit 0 = bottom

newFighterCtr	DS	1	; delay a bit after a new fighter appears

scoreTable	DS	12
scoreDigits	DS	6
level		DS	1
thisLevel	DS	1
basesLeft	DS	1

temp1		DS	1
temp2		DS	1
tempFrame	DS	1

rnd		DS	2
timer		DS	1

lastFire	DS	1
diffSwitch	DS	1	; 0 = amateur, 1 = pro

rotateOffset	DS	1
rotateDelay	DS	1

note0		DS	2	; address of the channel 0 voice, note, and duration
duration0	DS	1	; used to count down the channel 0 note's duration
note1		DS	2	; address of the channel 1 voice, note, and duration
duration1	DS	1	; used to count down the channel 1 note's duration

rambottom

	SEG code
	org $F000

	.byte "(c) 2001 by Brian Prescott"

objectPositioning

; Position player 0 graphics (first digit) horizontally

	STA WSYNC
	STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDA #firstDigitPosition
	LDX #0
	STX HMP0
	JSR chrst

; Position missile 0 (ship filler) horizontally

	STA WSYNC
	STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDA #73
	LDX #2
	JSR chrst

; Position missile 1 (ship filler) horizontally

	STA WSYNC
	STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDA #87
	LDX #3
	JSR chrst

; Position player 1 (second digit) horizontally

	STA WSYNC
	STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDA #secondDigitPosition
	LDX #1
	JSR chrst

	RTS

;
; The calculate horizontal reset routine is courtesy of.........
;	none other than..................   Howard Scott Warshaw
; 
; Go into this subroutine with the accumulator being the desired
; position (0-159), and the X register being the proper item
; (0 = P0, 1 = P1, 2 = M0, 3 = M1, 4 = BL)
;
; His copious comments have been removed because I didn't understand
; them anyway?!?!
;

chrst

; clear all of the horizontal move registers
	LDY #0
	STY HMP0
	STY HMP1
	STY HMM0
	STY HMM1
	STY HMBL

	CLC
	ADC #$2E
	TAY
	AND #$0F
	STA temp1
	TYA
	LSR
	LSR
	LSR
	LSR
	TAY
	CLC
	ADC temp1
	CMP #15
	BCC chrst1
	SBC #15
	INY
chrst1
	EOR #7
	ASL
	ASL
	ASL
	ASL
	STA HMP0,X
	STA WSYNC
chrstReset
	DEY
	BPL chrstReset
	STA RESP0,X
chrstFineTune
	STA WSYNC
	STA HMOVE
	RTS

chrst_middlescan

	CLC
	ADC #$2E
	TAY
	AND #$0F
	STA temp1
	TYA
	LSR
	LSR
	LSR
	LSR
	TAY
	CLC
	ADC temp1
	CMP #15
	BCC chrst1_middlescan
	SBC #15
	INY
chrst1_middlescan
	EOR #7
	ASL
	ASL
	ASL
	ASL
	STA HMP0,X
	LDA #0
	STA ENAM0
	STA ENAM1
	STA WSYNC
chrstReset_middlescan
	DEY
	BPL chrstReset_middlescan
	STA RESP0,X
chrstFineTune_middlescan
	STA WSYNC
	STA HMOVE
	RTS

chrst_middlescan2

	CLC
	ADC #$2E
	TAY
	AND #$0F
	STA temp1
	TYA
	LSR
	LSR
	LSR
	LSR
	TAY
	CLC
	ADC temp1
	CMP #15
	BCC chrst1_middlescan2
	SBC #15
	INY
chrst1_middlescan2
	EOR #7
	ASL
	ASL
	ASL
	ASL
	STA HMP0,X
	LDA #2
	STA ENAM0
	STA ENAM1
	STA WSYNC
chrstReset_middlescan2
	DEY
	BPL chrstReset_middlescan2
	STA RESP0,X
chrstFineTune_middlescan2
	STA WSYNC
	STA HMOVE
	RTS

randomNumber

        ; Generate a pseudo-random number

	LDA rnd
	LSR
	LSR
	SBC rnd
	LSR
	ROR rnd+1
	ROR rnd
	ROR rnd
	LDA rnd
	EOR timer
	RTS

; ****************************************************************************
; The following org statement is in the code for debugging purposes.
; It is to insure that timing critical code does not cross page boundaries.
; ****************************************************************************

	org $F100

start

	SEI			; Disable interrupts, if there are any.
	CLD			; Clear BCD math bit.

	LDX #$FF
	TXS			; Set stack to beginning.

	LDA #0
b1      STA 0,X
	DEX
	BNE b1

	JSR gameInit

;
; Here is a representation of our program flow.
;

mainLoop

	INC tempFrame		; bump the frame counter

	JSR verticalBlank	; begin vertical sync
				; set timer

	JSR checkSwitches	; Check console switches.

	JSR objectPositioning	; position the first digit of the score
				; position missile 0 and 1 (ship filler)
				; position second digit of the score

	JSR gameCalc		; vertical blank calculations
				; set up cannon graphics
				; set up fighter graphics
				; middle playfield calculations

	JSR drawScreen		; Draw the screen

	JSR overScan		; Do more calculations during overscan

	DEC timer		; do something to keep the numbers semi random
	JSR randomNumber

	JMP mainLoop		; Continue forever.

verticalBlank  			; *********************** VERTICAL BLANK HANDLER

	LDX #0
	LDA #2
	STA WSYNC  
	STA WSYNC
	STA WSYNC
	STA VSYNC		; Begin vertical sync.
	STA WSYNC 		; First line of VSYNC
	STA WSYNC		; Second line of VSYNC.

	LDA #44
	STA TIM64T

	LDA #0			; clear the collision latches
	STA CXCLR
	STA HMP0
	STA HMP1
	STA HMM0
	STA HMM1
	STA HMBL

	STA WSYNC		; Third line of VSYNC.
	STA VSYNC		; (0)

	RTS  

checkSwitches 			; *************************** CONSOLE SWITCH HANDLER

	LDA backColor
	STA COLUBK 		; set the background color

	LDA #$40		; check the left difficulty switch
	BIT SWCHB
	BNE diffPro		; the result is not zero, bit 7 must be on
diffAmateur
	LDA #0
	BEQ diffSet
diffPro
	LDA #1
diffSet
	STA diffSwitch

	LDA fireCounter		; check to see if the laser blast is still on the screen
	BEQ checkSwitchesNotDone	; it is not, proceed with switch processing
	JMP checkSwitchesDone	; it is, skip all switch processing

checkSwitchesNotDone

; set the joystick port for input

	LDA #0
	STA $281

	LDA fireCounter
	BNE firePressedDone
	
	LDA INPT4		; check for the fire button
	BPL firePressed		; the fire button was pressed
	BMI firePressedDone

firePressed

	LDA lastFire		; check to make sure that the last time it was checked,
				; the fire button was not pressed
	BPL firePressedDone	; it was, so skip

	LDA cannonPosition	; check to see if the cannon has been positioned
	BEQ firePressedDone	; it has not

	STA firePosition
	LDA #fireDelayTimer
	STA fireCounter
	LDA #<soundFire		; somebody set us up the sound
	STA note0
	LDA #>soundFire
	STA note0+1
	LDY #2
	LDA (note0),Y
	STA duration0

firePressedDone

	LDA INPT4
	STA lastFire
	LDX cannonPosition

rightFireCheck

	LDA INPT5		; check the state of the right joystick fire button
	BPL rightFirePressed	; it was pressed	
	BMI switchHeldLeft	; it was not pressed

rightFirePressed

	JSR levelInit
	LDX #9
	STX level
	LDX #0
	JMP switchHeldDone

switchHeldLeft

	LDA #$40
	BIT SWCHA
	BNE switchHeldRight
	LDX #2
	JMP switchHeldDone

switchHeldRight

	LDA #$80
	BIT SWCHA
	BNE switchHeldUp
	LDX #3
	JMP switchHeldDone

switchHeldUp

	LDA #$10
	BIT SWCHA
	BNE switchHeldDown
	LDX #1
	JMP switchHeldDone

switchHeldDown

	LDA #$20
	BIT SWCHA
	BNE switchHeldReset
	LDX #4
	JMP switchHeldDone

switchHeldReset

	LDA #$01
	BIT SWCHB
	BNE switchHeldSelect
	;LDA #2
	;STA temp
	JSR levelInit
	LDX #0
	JMP switchHeldDone

switchHeldSelect		; make sure this is the last switch held check !!!

	LDA #$02
	BIT SWCHB
	BNE switchHeldDone
	;LDA #1
	;STA temp

switchHeldDone

	STX cannonPosition
	;LDA controlheld
	;BNE switchwashelddown
	;LDA temp
	;STA controlheld

checkSwitchesDone

	RTS

gameCalc 			; ******************************* GAME CALCULATION ROUTINES

; take care of game mode situations

gameModeSituationsBegin

	LDA gameMode
	AND #%10000000		; check bit 7 of the game mode
	BNE gameModeSituationsEnd
	LDA #0
	STA cannonPosition

gameModeSituationsEnd

selectModeRotateBegin

	LDA gameMode
	BNE selectModeRotateEnd	; not in select mode (0)

; set the background and playfield colors based on the rotate factor if the game is in select mode

	LDX rotateOffset
	LDA rotatingBack,X
	STA backColor
	STA pfColor
	STA p0Color
	LDA rotatingPF,X
	STA scoreColor

	DEC rotateDelay		; switch to another set of background and playfield colors?
	BNE selectModeRotateEnd
	LDA #250
	STA rotateDelay
	INC rotateOffset
	LDA rotateOffset
	CMP #16			; have we reached the end of the color cycling?
	BCC selectModeRotateEnd	
	LDA #0
	STA rotateOffset

selectModeRotateEnd

; Figure out which set of cannon graphics to use for player 0

cannonGraphicsSetupBegin

	LDA #<blankGraphics
	STA cannonTopG
	STA cannonMiddleG
	STA cannonBottomG
	LDA #>blankGraphics
	STA cannonTopG+1
	STA cannonMiddleG+1
	STA cannonBottomG+1

	LDX cannonPosition
	DEX
	BEQ cannonGraphicsSetupTop
	DEX
	BEQ cannonGraphicsSetupLeft
	DEX
	BEQ cannonGraphicsSetupRight
	DEX
	BEQ cannonGraphicsSetupBottom

; code falls through, cannon position must be bottom (or none)
	BNE cannonGraphicsSetupEnd

cannonGraphicsSetupBottom
	LDA #<cannonBottomGraphics
	STA cannonBottomG
	LDA #>cannonBottomGraphics
	STA cannonBottomG+1
	BNE cannonGraphicsSetupEnd

cannonGraphicsSetupTop
	LDA #<cannonTopGraphics
	STA cannonTopG
	LDA #>cannonTopGraphics
	STA cannonTopG+1
	BNE cannonGraphicsSetupEnd

cannonGraphicsSetupLeft
	LDA #<cannonLeftGraphics
	STA cannonMiddleG
	LDA #>cannonLeftGraphics
	STA cannonMiddleG+1
	BNE cannonGraphicsSetupEnd

cannonGraphicsSetupRight
	LDA #<cannonRightGraphics
	STA cannonMiddleG
	LDA #>cannonRightGraphics
	STA cannonMiddleG+1

cannonGraphicsSetupEnd

fighterGraphicsSetupBegin

fGSTemp

fGSSetTemp		; set temp1 variables depending on difficulty switch

	LDA diffSwitch		; check the difficulty setting
	BEQ fGSAmateur		; it is a zero, jump to the amateur level
	LDA #blankTheExplosionA	; use the pro level values
	BNE fGSStoreTemp1
fGSAmateur
	LDA #blankTheExplosion	; use the amateur level values
fGSStoreTemp1
	STA temp1
	
fGST					; top

	LDA explosionTopCtr		; check for an explosion
	BEQ fGSTBomb
	CMP temp1			; check to see if the explosion is about done
	BMI fGSTBlank			; it is, head for the blank code
	JSR randomNumber
	AND #3
	TAY
	LDX explosionGraphicsTableLow,Y
	INX
	LDA explosionGraphicsTableHigh,Y
	BNE fGSTEnd
fGSTBomb
	LDA fbFlags			; check to see if a bomb is present
	AND #%00001000
	BEQ fGSTFighter
	LDX #<bombGraphics
	LDA #>bombGraphics
	BNE fGSTEnd
fGSTFighter
	LDA fbFlags			; check to see if a fighter is present
	AND #%10000000
	BEQ fGSTBlank			; there is not, skip down
	LDX #<fighterTopGraphics	; set up with fighter graphics by default
	LDA #>fighterTopGraphics
	BNE fGSTEnd
fGSTBlank
	LDX #<blankGraphics
	LDA #>blankGraphics
fGSTEnd
	STX fighterTopG
	STA fighterTopG+1

fGSM					; middle

	CLC
	LDA explosionLeftCtr		; check for an explosion
	ADC explosionRightCtr		; need to add both the left and right counter
	BEQ fGSMBomb			; the value is zero, check for something else
	CMP temp1			; check to see if the explosion is about done
	BMI fGSMBlank			; it is, head for the blank code
	JSR randomNumber
	AND #3
	TAY
	LDX explosionGraphicsTableLow,Y
	LDA explosionGraphicsTableHigh,Y
	BNE fGSMEnd
fGSMBomb
	LDA fbFlags			; check to see if a bomb is present
	AND #%00000110
	BEQ fGSMFighterLeft
	LDX #<bombGraphics
	LDA #>bombGraphics
	BNE fGSMEnd
fGSMFighterLeft
	LDA fbFlags			; check to see if a fighter is present
	AND #%01000000
	BEQ fGSMFighterRight		; there is not, skip down
	LDX #<fighterLeftGraphics	; set up with fighter graphics by default
	LDA #>fighterLeftGraphics
	BNE fGSMEnd
fGSMFighterRight
	LDA fbFlags			; check to see if a fighter is present
	AND #%00100000
	BEQ fGSMBlank			; there is not, skip down
	LDX #<fighterRightGraphics	; set up with fighter graphics by default
	LDA #>fighterRightGraphics
	BNE fGSMEnd
fGSMBlank
	LDX #<blankGraphics
	LDA #>blankGraphics
fGSMEnd
	STX fighterMiddleG
	STA fighterMiddleG+1

fGSB					; bottom

	LDA explosionBottomCtr		; check for an explosion
	BEQ fGSBBomb
	CMP temp1		; check to see if the explosion is about done
	BMI fGSBBlank			; it is, head for the blank code
	JSR randomNumber
	AND #3
	TAY
	LDX explosionGraphicsTableLow,Y
	INX
	LDA explosionGraphicsTableHigh,Y
	BNE fGSBEnd
fGSBBomb
	LDA fbFlags			; check to see if a bomb is present
	AND #%00000001
	BEQ fGSBFighter
	LDX #<bombGraphics
	LDA #>bombGraphics
	BNE fGSBEnd
fGSBFighter
	LDA fbFlags			; check to see if a fighter is present
	AND #%00010000
	BEQ fGSBBlank			; there is not, skip down
	LDX #<fighterBottomGraphics	; set up with fighter graphics by default
	LDA #>fighterBottomGraphics
	BNE fGSBEnd
fGSBBlank
	LDX #<blankGraphics
	LDA #>blankGraphics
fGSBEnd
	STX fighterBottomG
	STA fighterBottomG+1

fighterGraphicsSetupEnd

fireCalculations

	LDA fireCounter
	BEQ fireCalculationsEnd
	DEC fireCounter
	BNE fireCalculationsEnd
	LDA #0
	STA firePosition

fireCalculationsEnd

middleFirePFCalc

; playfield graphics values to use for the player's horizontal fire
; no horizontal fire, $00, $00, $C0, $C0, $00, $00
; fire to the left,   $FF, $FF, $CF, $C0, $00, $00
; fire to the right,  $00, $00, $C0, $CF, $FF, $FF

	LDA firePosition
	CMP #2
	BEQ middleFirePFCalcLeft
	CMP #3
	BEQ middleFirePFCalcRight

middleFirePFCalcNone

; no horizontal fire

	LDA #$00
	STA middleFirePF
	STA middleFirePF+1
	STA middleFirePF+4
	STA middleFirePF+5
	LDA #$C0
	STA middleFirePF+2
	STA middleFirePF+3
	BNE middleFirePFCalcEnd

middleFirePFCalcRight

; fire to the right

	LDA #$00
	STA middleFirePF
	STA middleFirePF+1
	LDA #$C0
	STA middleFirePF+2
	LDA #$CF
	STA middleFirePF+3
	LDA #$FF
	STA middleFirePF+4
	STA middleFirePF+5
	BNE middleFirePFCalcEnd

middleFirePFCalcLeft

; fire to the left

	LDA #$FF
	STA middleFirePF
	STA middleFirePF+1
	LDA #$CF
	STA middleFirePF+2
	LDA #$C0
	STA middleFirePF+3
	LDA #$00
	STA middleFirePF+4
	STA middleFirePF+5
	;BEQ middleFirePFCalcEnd

middleFirePFCalcEnd

scoreTableCalcBegin

	LDX scoreDigits
	LDA digitGraphicsTableLow,X
	STA scoreTable
	LDA digitGraphicsTableHigh,X
	STA scoreTable+1

	LDX scoreDigits+1
	LDA digitGraphicsTableLow,X
	STA scoreTable+2
	LDA digitGraphicsTableHigh,X
	STA scoreTable+3

	LDX scoreDigits+2
	LDA digitGraphicsTableLow,X
	STA scoreTable+4
	LDA digitGraphicsTableHigh,X
	STA scoreTable+5

	LDX scoreDigits+3
	LDA digitGraphicsTableLow,X
	STA scoreTable+6
	LDA digitGraphicsTableHigh,X
	STA scoreTable+7

	LDX scoreDigits+4
	LDA digitGraphicsTableLow,X
	STA scoreTable+8
	LDA digitGraphicsTableHigh,X
	STA scoreTable+9

	LDX scoreDigits+5
	LDA digitGraphicsTableLow,X
	STA scoreTable+10
	LDA digitGraphicsTableHigh,X
	STA scoreTable+11

; change the score color based on the left difficulty switch (but only in non select game mode)

	LDA gameMode
	BEQ scoreTableCalcEnd
	LDA diffSwitch
	BEQ scoreTableColorAmateur
	LDA #$15
	BNE scoreTableColorSet
scoreTableColorAmateur
	LDA #$74
scoreTableColorSet
	STA scoreColor

scoreTableCalcEnd

levelBumpCheck

	LDY level
	DEY
	LDA levelFinishedAmount,Y
	CMP thisLevel
	BEQ levelBump
	BNE levelBumpCheckEnd
levelBump
	LDA #0
	STA thisLevel
	CPY #8
	BEQ levelBumpCheckEnd
	INC level

levelBumpCheckEnd

gameCalcEnd

; Position ball (up and down fire) horizontally

	LDA #80
	LDX #4
	JSR chrst

; figure out the graphics of the middle two scan lines

	LDA cannonPosition
	CMP #2
	BEQ middleCannonG_1
	CMP #3
	BEQ middleCannonG_1
	LDA #0
	BEQ middleCannonG_2

middleCannonG_1

	LDY #5
	LDA (cannonMiddleG),Y

middleCannonG_2
	STA middleCannonG

	RTS

drawScreen 			; **************************** SCREEN DRAWING ROUTINES

; Initialize some display variables.

	LDA pfColor		; playfield color
	STA COLUPF
	LDA backColor
	STA COLUBK

	LDA #0			; turn off the missiles
	STA ENAM0
	STA ENAM1
	STA HMBL		; clear the ball horizontal motion from gameCalc above

drawScreenLoop

; get ready for the score area

	LDA backColor
	STA COLUBK
	LDA #1
	STA VDELP0
	STA VDELP1
	LDA #7
	STA temp1

	LDA #3
	STA NUSIZ0		; 3 copies of player 0
	STA NUSIZ1		; 3 copies of player 1

	LDA scoreColor
	STA COLUP0
	STA COLUP1

	LDA INTIM
	BNE drawScreenLoop

	STA WSYNC
	STA VBLANK		; End the VBLANK period with a zero.

	;STA WSYNC

; Begin drawing the screen

; Draw the score and status area (24 lines)

score48pixel			; the famed 48 pixel hires routine (?!?)
	LDY temp1
	LDA (scoreTable),y
	STA GRP0
	STA WSYNC
	LDA (scoreTable+2),y
	STA GRP1
	LDA (scoreTable+4),y
	STA GRP0
	LDA (scoreTable+6),y
	STA temp2
	LDA (scoreTable+8),y
	TAX
	LDA (scoreTable+10),y
	TAY
	LDA temp2
	STA GRP1
	STX GRP0
	STY GRP1
	STA GRP0
	DEC temp1
	BPL score48pixel

; Position player 0 graphics (cannon) horizontally

	;STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDX cannonPosition
	LDA cannonPixelPosition,X	
	LDX #0
	STX HMP0
	STX HMP1
	JSR chrst

; kill some time with some other stuff

	;STA WSYNC
	LDA #0
	STA VDELP0
	STA VDELP1
	STA GRP0
	STA GRP1
	STA PF0
	STA PF1
	STA PF2

; Position player 1 (fighter or bomb) horizontally

	;STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDA #76
	LDX #1
	JSR chrst

	STA WSYNC
	LDA scoreColor
	STA COLUBK
	LDA #$10
	STA NUSIZ0
	STA NUSIZ1
	LDA p0Color
	STA COLUP0

; get ready for the top area with the last blank scan line of the score area

	STA WSYNC
	LDA backColor
	STA COLUBK
	LDY level
	DEY
	LDA levelFighterColor,Y
	STA fighterColor
	STA COLUP1
	LDA #0
	STA HMP0
	STA HMP1

	LDX #64			; use the X register instead of the Y register
				; because the Y register is needed in the
				; indirect indexed LDA below

scanTopFireArea

; first, subtract X register from top position
; if the value is greater than 7 or negative, skip the graphics

	STA WSYNC
	LDY firePosition
	LDA topBallEnableData,Y
	STA ENABL
	STX temp1
	LDA fighterTopPos
	SEC
	SBC temp1
	BMI scanTopFireNoGraphics
	CMP #8
	BCS scanTopFireNoGraphics
	TAY
	LDA (fighterTopG),Y
	STA GRP1
	DEX
	BNE scanTopFireArea
scanTopFireNoGraphics
	LDY #0
	STY GRP1
	DEX
	BNE scanTopFireArea

; Draw the area surrounding the ship

	LDY #8

scanShipTop

	STA WSYNC

	LDA p0Color
	STA COLUP1
	LDA (cannonTopG),Y
	STA GRP0
	LDA #$00
	STA ENABL
	STA PF0
	STA PF1
	LDA #$30
	STA PF2

	DEY
	CPY #2
	BNE scanShipTop

scanShipTop_b

	STA WSYNC

	LDA (cannonTopG),Y
	STA GRP0
	LDA #$02
	STA ENAM0
	STA ENAM1
	LDA #$00
	STA PF0
	STA PF1
	LDA #$30
	STA PF2
	LDA #$20
	STA HMM0
	LDA #$E0
	STA HMM1

	DEY
	BNE scanShipTop_b

scanShipMiddle

	;LDY #4

scanShipMiddle1

; 4 scan lines

	STA WSYNC

	STA HMOVE
	LDA #$C0
	STA PF2
	LDA #$00
	STA GRP0
	STA PF0
	STA PF1
	STA HMM0
	STA HMM1

	STA WSYNC

; position the player 1 graphics (fighter, bomb, or explosion)

	LDA fighterMiddlePos
	LDX #1
	JSR chrst_middlescan

; Draw the area surrounding the ship

	LDY #8

scanShipMiddle2_a

	STA WSYNC

	LDA fighterColor
	STA COLUP1
	LDA (cannonMiddleG),Y
	STA GRP0
	LDA (fighterMiddleG),Y
	STA GRP1
	LDA #$00
	STA PF0
	STA PF1
	LDA #$C0
	STA PF2

	DEY
	CPY #5
	BNE scanShipMiddle2_a

	;LDY #2

scanShipMiddle2_b

	STA WSYNC

	LDA middleCannonG
	STA GRP0
	LDA (fighterMiddleG),Y
	STA GRP1
	LDA middleFirePF
	STA PF0
	LDA middleFirePF+1
	STA PF1
	LDA middleFirePF+2
	STA PF2
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LDA middleFirePF+3
	STA PF2
	LDA middleFirePF+4
	STA PF1
	LDA middleFirePF+5
	STA PF0

	DEY
	CPY #3
	BNE scanShipMiddle2_b

	;LDY #3

scanShipMiddle2_c

	STA WSYNC

	LDA (cannonMiddleG),Y
	STA GRP0
	LDA (fighterMiddleG),Y
	STA GRP1
	LDA #$00
	STA PF0
	STA PF1
	LDA #$C0
	STA PF2
	DEY
	BNE scanShipMiddle2_c

	;LDY #4

scanShipMiddle3

; 4 scan lines

	STA WSYNC

	LDA #$00
	STA GRP0
	STA GRP1
	;STA PF0
	;STA PF1
	;LDA #$C0
	;STA PF2
	LDA p0Color
	STA COLUP1

	STA WSYNC

	LDA #76
	LDX #1
	JSR chrst_middlescan2

	;STA WSYNC
	LDA #$C0
	STA PF2
	LDA #$00
	STA PF0
	STA PF1
	LDA #$C0
	STA PF2
	LDA #$00
	STA PF0
	STA PF1
	LDA #$C0
	STA PF2
	LDA #$00
	STA PF0
	STA PF1

	LDA #$E0
	STA HMM0
	LDA #$20
	STA HMM1

	LDY #8

scanShipBottom

	STA WSYNC

	LDA #0
	STA HMP1
	STA HMOVE
	LDA (cannonBottomG),Y	; sprite graphics
	STA GRP0
	LDA #$30
	STA PF2
	LDA #$00
	STA PF0
	STA PF1
	CPY #6
	BEQ scanShipBottomDisable
	BNE scanShipBottomAfter
scanShipBottomDisable
	STA ENAM0
	STA ENAM1
scanShipBottomAfter
	STA HMM0
	STA HMM1
	DEY
	BNE scanShipBottom

	STY PF2
	LDX #64			; use the X register instead of the Y register
				; because the Y register is needed in the
				; indirect indexed LDA below

scanBottomFireArea

; first, subtract X register from top position
; if the value is greater than 7 or negative, skip the graphics

	STA WSYNC
	LDA fighterColor
	STA COLUP1
	LDY firePosition
	LDA bottomBallEnableData,Y
	STA ENABL
	STX temp1
	LDA fighterBottomPos
	SEC
	SBC temp1
	BMI scanBottomFireNoGraphics
	CMP #8
	BCS scanBottomFireNoGraphics
	TAY
	LDA (fighterBottomG),Y
	STA GRP1
	DEX
	BNE scanBottomFireArea
scanBottomFireNoGraphics
	LDY #0
	STY GRP1
	DEX
	BNE scanBottomFireArea

	STX ENABL		; turn off the cannon fire at the bottom of the screen

; Position player 0 graphics (first digit) horizontally

	STA WSYNC
	LDA scoreColor
	STA COLUBK

	LDA #<levelGraphics	; set up the graphics for the level indicator
	STA scoreTable
	LDA #>levelGraphics
	STA scoreTable+1

	LDA #<basesRemainingGraphics	; set up the graphics for the bases remaining indicator
	STA scoreTable+8
	LDA #>basesRemainingGraphics
	STA scoreTable+9

	LDX level		; set up the level digit
	LDA digitGraphicsTableLow,X
	STA scoreTable+2
	LDA digitGraphicsTableHigh,X
	STA scoreTable+3

	STA WSYNC
	LDA backColor
	STA COLUBK
	LDA #firstDigitPosition
	LDX #0
	STX HMP0
	JSR chrst

; Position player 1 (second digit) horizontally

	;STA WSYNC

	LDA #<blankGraphics	; set up the blank graphics
	STA scoreTable+4
	STA scoreTable+6
	LDA #>blankGraphics
	STA scoreTable+5
	STA scoreTable+7

	LDX basesLeft		; set up the bases remaining digit
	BPL basesRemainingDigitOK
	INX
basesRemainingDigitOK
	LDA digitGraphicsTableLow,X
	STA scoreTable+10
	LDA digitGraphicsTableHigh,X
	STA scoreTable+11

	;STA WSYNC		; make sure that 24 cycles are used before
				; modifying a horizontal move register
	LDA #secondDigitPosition
	LDX #1
	JSR chrst

; get ready for the status area

	LDA #1
	STA VDELP0
	STA VDELP1
	LDA #7
	STA temp1

	LDA #3
	STA NUSIZ0		; 3 copies of player 0
	STA NUSIZ1		; 3 copies of player 1

	LDA scoreColor
	STA COLUP0
	STA COLUP1

; Draw the score and status area (24 lines)

status48pixel			; the famed 48 pixel hires routine (?!?)
	LDY temp1
	LDA (scoreTable),y
	STA GRP0
	STA WSYNC
	LDA (scoreTable+2),y
	STA GRP1
	LDA (scoreTable+4),y
	STA GRP0
	LDA (scoreTable+6),y
	STA temp2
	LDA (scoreTable+8),y
	TAX
	LDA (scoreTable+10),y
	TAY
	LDA temp2
	STA GRP1
	STX GRP0
	STY GRP1
	STA GRP0
	DEC temp1
	BPL status48pixel

;
; Clear all registers here to prevent any possible bleeding.
;

	LDA #2
	STA WSYNC  		; Finish this scanline.
	STA VBLANK 		; Make TIA output invisible

	; Now we need to worry about it bleeding when we turn
	; the TIA output back on.
	; Y is still zero.

	STY PF0
	STY PF1
	STY PF1
	STY GRP0
	STY GRP1
	;STY ENAM0
	;STY ENAM1
	STY ENABL

	RTS

overScan   			;***************************** OVERSCAN CALCULATIONS

	LDA #35
	STA TIM64T

overScanGameModes

	LDA gameMode
	AND #%10000000		; check bit 7 of the game mode
	BNE doOverScanCalcs
	JMP skipOverscanCalcs	; skip over all of the fighter/bomb calculations

doOverScanCalcs

fighterExplosionCheck

	LDA duration1
	BNE fighterExplosionCheckEnd
	CLC
	LDA explosionTopCtr
	ADC explosionLeftCtr
	ADC explosionRightCtr
	ADC explosionBottomCtr
	BEQ fighterExplosionCheckEnd
	LDA #<soundFighterExplosion	; a fighter is exploding
	STA note1
	LDA #>soundFighterExplosion
	STA note1+1
	LDA #15
	STA duration1

fighterExplosionCheckEnd

decrementFighterBegin

decrementFighterTop

	LDA fighterTopWait
	BEQ decrementFighterMiddle
	DEC fighterTopWait	; decrement the fighter counter

decrementFighterMiddle

	LDA fighterMiddleWait
	BEQ decrementFighterBottom
	DEC fighterMiddleWait	; decrement the fighter counter

decrementFighterBottom

	LDA fighterBottomWait
	BEQ decrementFighterEnd
	DEC fighterBottomWait	; decrement the fighter counter

decrementFighterEnd

processFighterBegin

processFighterSetTemp		; set temp1 variables depending on difficulty switch

	LDA diffSwitch		; check the difficulty setting
	BEQ processFighterAmateur	; it is a zero, jump to the amateur level
	LDA #explosionTimerA	; use the pro level values
	BNE processFighterStoreTemp1
processFighterAmateur
	LDA #explosionTimer		; use the amateur level values
processFighterStoreTemp1
	STA temp1

processFighterTop

	LDA firePosition
	CMP #1			; is the player firing up?
	BNE processFighterLeft	; no
	LDA fbFlags
	AND #%10001000		; test for bits 7 or 3
	BEQ processFighterLeft
	LDA explosionTopCtr
	BNE processFighterLeft	; the ship is already exploding
	INC thisLevel		; bump the fighters for this level
	LDA fbFlags
	AND #%00001000
	BEQ processFighterTop2
	LDA temp1
	STA explosionTopCtr
	JSR scoreTen
	LDA fbFlags
	AND #%01110111		; turn off bits 7 and 3
	STA fbFlags
	JMP processFighterLeft
processFighterTop2
	LDA temp1
	STA explosionTopCtr	; set up the explosion
	JSR scoreHundred	; add 100 to the score
	LDA fbFlags
	AND #%01110111		; turn off bits 7 and 3
	STA fbFlags

processFighterLeft

	LDA firePosition
	CMP #2			; is the player firing left?
	BNE processFighterRight	; no
	LDA fbFlags
	AND #%01000100		; test for bits 6 or 2
	BEQ processFighterRight	; there is no ship or bomb
	LDA explosionLeftCtr
	BNE processFighterRight	; something is already exploding
	LDA #0
	STA fighterMiddleWait	; clear the fighter counter
	INC thisLevel		; bump the fighters for this level
	LDA fbFlags
	AND #%00000100
	BEQ processFighterLeft2
	LDA temp1
	STA explosionLeftCtr
	JSR scoreTen
	LDA fbFlags
	AND #%10111011		; turn off bits 6 and 2
	STA fbFlags
	JMP processFighterRight
processFighterLeft2
	LDA temp1
	STA explosionLeftCtr	; set up the explosion
	JSR scoreHundred	; add 100 to the score
	LDA fbFlags
	AND #%10111011		; turn off bits 6 and 2
	STA fbFlags

processFighterRight

	LDA firePosition
	CMP #3			; is the player firing right?
	BNE processFighterBottom	; no
	LDA fbFlags
	AND #%00100010		; test for bits 5 or 1
	BEQ processFighterBottom	; there is no ship or bomb
	LDA explosionRightCtr
	BNE processFighterBottom	; something is already exploding
	LDA #0
	STA fighterMiddleWait	; clear the fighter counter
	INC thisLevel		; bump the fighters for this level
	LDA fbFlags
	AND #%00000010
	BEQ processFighterRight2
	LDA temp1
	STA explosionRightCtr
	JSR scoreTen
	LDA fbFlags
	AND #%11011101		; turn off bits 5 and 1
	STA fbFlags
	JMP processFighterBottom
processFighterRight2
	LDA temp1
	STA explosionRightCtr	; set up the explosion
	JSR scoreHundred	; add 100 to the score
	LDA fbFlags
	AND #%11011101		; turn off bits 5 and 1
	STA fbFlags

processFighterBottom

	LDA firePosition
	CMP #4			; is the player firing down?
	BNE processFighterEnd	; no
	LDA fbFlags
	AND #%00010001		; test for bits 4 or 0
	BEQ processFighterEnd
	LDA explosionBottomCtr
	BNE processFighterEnd	; the ship is already exploding
	INC thisLevel		; bump the fighters for this level
	LDA fbFlags
	AND #%00000001
	BEQ processFighterBottom2
	LDA temp1
	STA explosionBottomCtr
	JSR scoreTen
	LDA fbFlags
	AND #%11101110		; turn off bits 4 and 0
	STA fbFlags
	JMP processFighterEnd
processFighterBottom2
	LDA temp1
	STA explosionBottomCtr	; set up the explosion
	JSR scoreHundred	; add 100 to the score
	LDA fbFlags
	AND #%11101110		; turn off bits 4 and 0
	STA fbFlags

processFighterEnd

moveFighterBegin

moveFighterTop

	LDA fbFlags
	AND #%10001000
	BEQ moveFighterLeft	; there is no fighter or bomb
	LDA fighterTopWait
	BNE moveFighterLeft	; the fighter is still waiting to fire
	LDA explosionTopCtr
	BNE moveFighterLeft	; something is exploding
	LDA fbFlags
	AND #%01111111		; turn off bit 7
	ORA #%00001000		; turn on bit 3
	STA fbFlags
	JSR fighterJustFired
	LDY level		; check which level the player is on
	DEY
	BNE moveFighterTopSubtract	; they are not on level 1, automatically subtract
	LDA tempFrame
	AND #1			; test to see if the tempFrame is even
	BEQ moveFighterLeft	; it is not, skip the subtract
moveFighterTopSubtract
	SEC
	LDA fighterTopPos	; load the bomb position back into the accumulator
	SBC fighterStepAmount,Y	; this will be the amount to move the bomb
				; is it less than 8?
	STA fighterTopPos	; put the accumulator back

moveFighterLeft

	LDA fbFlags
	AND #%01000100
	BEQ moveFighterRight	; there is no fighter or bomb
	LDA fighterMiddleWait
	BNE moveFighterRight	; the fighter is still waiting to fire
	LDA explosionLeftCtr
	BNE moveFighterRight	; something is exploding
	LDA fbFlags
	AND #%10111111		; turn off bit 6
	ORA #%00000100		; turn on bit 2
	STA fbFlags
	JSR fighterJustFired
	LDY level		; check which level the player is on
	DEY
	BNE moveFighterLeftSubtract	; they are not on level 1, automatically subtract
	LDA tempFrame
	AND #1			; test to see if the tempFrame is even
	BEQ moveFighterRight	; it is not, skip the subtract
moveFighterLeftSubtract
	CLC
	LDA fighterMiddlePos	; load the bomb position back into the accumulator
	ADC fighterStepAmount,Y	; this will be the amount to move the bomb
				; is it less than 8?
	STA fighterMiddlePos	; put the accumulator back

moveFighterRight

	LDA fbFlags
	AND #%00100010
	BEQ moveFighterBottom	; there is no fighter or bomb
	LDA fighterMiddleWait
	BNE moveFighterBottom	; the fighter is still waiting to fire
	LDA explosionRightCtr
	BNE moveFighterBottom	; something is exploding
	LDA fbFlags
	AND #%11011111		; turn off bit 6
	ORA #%00000010		; turn on bit 2
	STA fbFlags
	JSR fighterJustFired
	LDY level		; check which level the player is on
	DEY
	BNE moveFighterRightSubtract	; they are not on level 1, automatically subtract
	LDA tempFrame
	AND #1			; test to see if the tempFrame is even
	BEQ moveFighterBottom	; it is not, skip the subtract
moveFighterRightSubtract
	SEC
	LDA fighterMiddlePos	; load the bomb position back into the accumulator
	SBC fighterStepAmount,Y	; this will be the amount to move the bomb
				; is it less than 8?
	STA fighterMiddlePos	; put the accumulator back

moveFighterBottom

	LDA fbFlags
	AND #%00010001
	BEQ moveFighterEnd	; there is no fighter or bomb
	LDA fighterBottomWait
	BNE moveFighterEnd	; the fighter is still waiting to fire
	LDA explosionBottomCtr
	BNE moveFighterEnd	; something is exploding
	LDA fbFlags
	AND #%11101111		; turn off bit 4
	ORA #%00000001		; turn on bit 0
	STA fbFlags
	JSR fighterJustFired
	LDY level		; check which level the player is on
	DEY
	BNE moveFighterBottomSubtract	; they are not on level 1, automatically subtract
	LDA tempFrame
	AND #1			; test to see if the tempFrame is even
	BEQ moveFighterEnd	; it is not, skip the subtract
moveFighterBottomSubtract
	CLC
	LDA fighterBottomPos	; load the bomb position back into the accumulator
	ADC fighterStepAmount,Y	; this will be the amount to move the bomb
				; is it less than 8?
	STA fighterBottomPos	; put the accumulator back

moveFighterEnd

decrementExplosionBegin

decrementExplosionTop

	LDA explosionTopCtr
	BEQ decrementExplosionLeft
	DEC explosionTopCtr
	BNE decrementExplosionLeft
	LDA #0
	STA fighterTopPos

decrementExplosionLeft

	LDA explosionLeftCtr
	BEQ decrementExplosionRight
	DEC explosionLeftCtr
	BNE decrementExplosionRight
	LDA #0
	STA fighterMiddlePos

decrementExplosionRight

	LDA explosionRightCtr
	BEQ decrementExplosionBottom
	DEC explosionRightCtr
	BNE decrementExplosionBottom
	LDA #0
	STA fighterMiddlePos

decrementExplosionBottom

	LDA explosionBottomCtr
	BEQ decrementExplosionEnd
	DEC explosionBottomCtr
	BNE decrementExplosionEnd
	LDA #0
	STA fighterBottomPos

decrementExplosionEnd

newFighterBegin

	LDA newFighterCtr	; see if a fighter has appeared recently
	BEQ newFighterSetTemp
	DEC newFighterCtr
	JMP newFighterEnd

newFighterSetTemp		; set temp1 and temp2 variables depending on difficulty switch

	LDY level		; a fighter might be placed, figure out the threshold value
	DEY
	LDA diffSwitch		; check the difficulty setting
	BEQ newFighterAmateur	; it is a zero, jump to the amateur level
	LDA levelRandomNumberA,Y	; use the pro level values
	LDX fighterWaitAmountA,Y
	BNE newFighterStoreTemp1
newFighterAmateur
	LDA levelRandomNumber,Y		; use the amateur level values
	LDX fighterWaitAmount,Y
newFighterStoreTemp1
	STA temp1
	STX temp2

newFighterRandom		; pick a side at random 

	JSR randomNumber	; select a random number
	AND #3			; make the random value 0 to 3
	BEQ newFighterTop
	TAY
	DEY
	BEQ newFighterLeft
	DEY
	BEQ newFighterLeft
	JMP newFighterBottom

newFighterTop

	LDA fbFlags		; is there a fighter or bomb on top?
	AND #%10001000
	BNE newFighterTopEnd	; yes, skip to the end
	LDA explosionTopCtr	; is there something exploding on top?
	BNE newFighterTopEnd	; yes, skip to the end
	JSR randomNumber
	CMP temp1
	BCS newFighterTopEnd	; if the random number is greater than the number, skip to the left
	LDA temp2
	STA fighterTopWait
	LDA #64
	STA fighterTopPos
	LDA #0
	STA explosionTopCtr
	LDA fbFlags
	ORA #%10000000		; turn on bit 7
	AND #%11110111		; turn off bit 3
	STA fbFlags
	LDA #newFighterDelayTimer
	STA newFighterCtr
newFighterTopEnd
	JMP newFighterEnd

newFighterLeft

	LDA fbFlags		; is there a fighter or bomb on the left?
	AND #%01000100
	BNE newFighterLeftEnd	; yes, skip to the bottom
	LDA explosionLeftCtr	; is there something exploding on the left?
	BNE newFighterLeftEnd	; yes, skip to the bottom
	LDA fbFlags		; is there a fighter or bomb on the right?
	AND #%00100010
	BNE newFighterLeftEnd	; yes, skip to the bottom
	LDA explosionRightCtr	; is there something exploding on the right?
	BNE newFighterLeftEnd	; yes, skip to the bottom
	JSR randomNumber
	CMP temp1
	BCS newFighterLeftEnd	; if the random number is greater than the number, skip to the bottom
	LDA timer		; now check to see if it should go left or right
	AND #1
	BEQ newFighterRight
	LDA temp2
	STA fighterMiddleWait
	LDA #1
	STA fighterMiddlePos
	LDA #0
	STA explosionLeftCtr
	LDA fbFlags
	ORA #%01000000		; turn on bit 6
	AND #%11111011		; turn off bit 2
	STA fbFlags
	LDA #newFighterDelayTimer
	STA newFighterCtr
newFighterLeftEnd
	JMP newFighterEnd

newFighterRight

	LDA temp2
	STA fighterMiddleWait
	LDA #151
	STA fighterMiddlePos
	LDA #0
	STA explosionRightCtr
	LDA fbFlags
	ORA #%00100000		; turn on bit 5
	AND #%11111101		; turn off bit 1
	STA fbFlags
	LDA #newFighterDelayTimer
	STA newFighterCtr
	JMP newFighterEnd

newFighterBottom

	LDA fbFlags		; is there a fighter or bomb on the bottom?
	AND #%00010001
	BNE newFighterBottomEnd	; yes, skip to the end
	LDA explosionBottomCtr	; is there something exploding on the bottom?
	BNE newFighterBottomEnd	; yes, skip to the left
	LDY level
	DEY
	JSR randomNumber
	CMP temp1
	BCS newFighterBottomEnd	; if the random number is greater than the number, skip to the end
	LDA temp2
	STA fighterBottomWait
	LDA #9
	STA fighterBottomPos
	LDA #0
	STA explosionBottomCtr
	LDA fbFlags
	ORA #%00010000		; turn on bit 4
	AND #%11111110		; turn off bit 0
	STA fbFlags
	LDA #newFighterDelayTimer
	STA newFighterCtr
newFighterBottomEnd

newFighterEnd

newFighterDiffCheck

; check to see if the difficulty switch is set to pro and a new fighter was just put out there
; if both of these conditions are met, reduce the new fighter delay

	LDA diffSwitch
	BEQ newFighterDiffCheckEnd
	LDA newFighterCtr
	CMP #newFighterDelayTimer
	BNE newFighterDiffCheckEnd
	LDA #newFighterDelayTimerA
	STA newFighterCtr

newFighterDiffCheckEnd

shipExplosionCheckBegin

shipExplosionCheckTop

	LDA fbFlags
	AND #%00001000		; check to see if a bomb is on the way
	BEQ shipExplosionCheckLeft
	LDA fighterTopPos
	BEQ shipExplosionCheckLeft
	CMP #9
	BCS shipExplosionCheckLeft

; the ship has exploded

	JSR shipGoBoom
	JMP shipExplosionCheckEnd

shipExplosionCheckLeft

	LDA fbFlags
	AND #%00000110		; check to see if a bomb is on the way
	BEQ shipExplosionCheckBottom
	LDA fighterMiddlePos
	CMP #80			; compare to the middle of the screen
	BCS shipExplosionCheckRight	; whatever it is, it isn't on the left side
	CMP #58
	BCC shipExplosionCheckBottom

; the ship has exploded

	JSR shipGoBoom
	JMP shipExplosionCheckEnd

shipExplosionCheckRight

	CMP #95
	BCS shipExplosionCheckBottom

; the ship has exploded

	JSR shipGoBoom
	JMP shipExplosionCheckEnd

shipExplosionCheckBottom

	LDA fbFlags
	AND #%00000001		; check to see if a bomb is on the way
	BEQ shipExplosionCheckEnd
	LDA fighterBottomPos
	BEQ shipExplosionCheckEnd
	CMP #67
	BCC shipExplosionCheckEnd

; the ship has exploded

	JSR shipGoBoom

shipExplosionCheckEnd

skipOverscanCalcs

	LDA gameMode
	CMP #modeSelect
	BEQ baseExplosionDecrementEnd

baseExplosionDecrementBegin

	LDA explosionBaseCtr		; is the base exploding?
	BEQ baseExplosionDecrementEnd	; it is not
	DEC explosionBaseCtr		; drop the counter
	BEQ baseExplosionDone		; the base is done exploding
	JSR randomNumber
	ORA #1
	STA backColor
	CLC
	ADC #68
	STA p0Color
	STA pfColor
	BNE baseExplosionDecrementEnd

baseExplosionDone

; if the player has zero bases left, and their current base is destroyed, the bases left
; counter will go to 255, that's what we're checking for here...

	LDA basesLeft
	BPL continueGame

thyGameIsOver

	LDA #0
	STA basesLeft
	LDA #modeSelect
	STA gameMode
	LDA #0
	STA rotateOffset
	LDA #250
	STA rotateDelay
	JMP baseExplosionDecrementEnd

continueGame

	LDA #modePlay
	STA gameMode
	LDA #normalBackColor
	STA backColor
	LDA #normalBaseColor
	STA p0Color
	STA pfColor
	LDA #128
	STA newFighterCtr

baseExplosionDecrementEnd

sound0Processor

	LDY #0
	LDA (note0),Y		; check the current voice
	BMI sound0Off
	BEQ sound0Off		; is it a zero?  if yes, pump down the volume

	STA AUDC0		; set audio channel 0 voice
	INY
	LDA (note0),Y
	;BEQ sound0Silence	; if the note is a one, turn down the volume
	STA AUDF0		; set audio channel 0 frequency
	LDA #$0F		; max volume
	STA AUDV0		; set audio channel 0 volume
	JMP sound0Processor2

sound0Silence

	LDA #$00
	STA AUDV0

sound0Processor2

	DEC duration0		; bump down the duration
	LDA duration0
	BNE sound0ProcessorDone	; are we still holding the note?
	INC note0
	INC note0
	INC note0		; move the note address up by 3 bytes
	LDY #2
	LDA (note0),Y
	STA duration0		; set up the new duration
	JMP sound0ProcessorDone

sound0Off

	LDA #0
	STA AUDV0
	LDA #<theSoundOfSilence
	STA note0
	LDA #>theSoundOfSilence
	STA note0+1

sound0ProcessorDone

sound1Processor

	LDY #0
	LDA (note1),Y		; check the current voice
	BMI sound1Off
	BEQ sound1Off		; is it a zero?  if yes, pump down the volume

	STA AUDC1		; set audio channel 0 voice
	INY
	LDA (note1),Y
	;BEQ sound1Silence	; if the note is a one, turn down the volume
	STA AUDF1		; set audio channel 0 frequency
	LDA #$0F		; max volume
	STA AUDV1		; set audio channel 0 volume
	JMP sound1Processor2

sound1Silence

	LDA #$00
	STA AUDV1

sound1Processor2

	DEC duration1		; bump down the duration
	LDA duration1
	BNE sound1ProcessorDone	; are we still holding the note?
	INC note1
	INC note1
	INC note1		; move the note address up by 3 bytes
	LDY #2
	LDA (note1),Y
	STA duration1		; set up the new duration
	JMP sound1ProcessorDone

sound1Off

	LDA #0
	STA AUDV1
	LDA #<theSoundOfSilence
	STA note1
	LDA #>theSoundOfSilence
	STA note1+1

sound1ProcessorDone

overScanTimer

	LDA INTIM
	BNE overScanTimer

	STA WSYNC
	RTS

scoreTen

	INC scoreDigits+4
	LDA scoreDigits+4
	CMP #10
	BEQ bumpHundred
	RTS

bumpHundred

	LDA #0
	STA scoreDigits+4

scoreHundred

	INC scoreDigits+3
	LDA scoreDigits+3
	CMP #10
	BEQ bumpThousand
	RTS

bumpThousand

	LDA #0
	STA scoreDigits+3

scoreThousand

	INC scoreDigits+2
	LDA scoreDigits+2
	CMP #10
	BEQ bumpTenThousand
	RTS
	
bumpTenThousand

	LDA #0
	STA scoreDigits+2

; add a base to the reserve
; this works because there is no entry point directly to scoreTenThousand

	INC basesLeft		; increment the value
	LDA basesLeft		; check for overflow
	CMP #10			; is the number 10? (an overflow)
	BNE scoreTenThousand	; no, skip the decrement
	DEC basesLeft		; bring it back down to 9

scoreTenThousand

	INC scoreDigits+1
	LDA scoreDigits+1
	CMP #10
	BEQ bumpHundredThousand
	RTS
	
bumpHundredThousand

	LDA #0
	STA scoreDigits+1

scoreHundredThousand

	INC scoreDigits
	LDA scoreDigits
	CMP #11
	BEQ keepSmiling
	RTS
	
keepSmiling

	DEC scoreDigits
	RTS

shipGoBoom

	LDA #0

	STA firePosition	; clear out the firing variables
	STA fireCounter

	STA fighterTopPos	; clear out the fighter positions
	STA fighterMiddlePos
	STA fighterBottomPos

	STA explosionTopCtr	; clear out the explosion timers
	STA explosionLeftCtr
	STA explosionRightCtr
	STA explosionBottomCtr

	STA fbFlags		; clear out the fighter/bomb flags
	DEC basesLeft
	LDA #modeBaseExploding
	STA gameMode
	LDA #baseExplosionTimer
	STA explosionBaseCtr

	LDA #<soundBaseExplosion0
	STA note0
	LDA #>soundBaseExplosion0
	STA note0+1
	LDA #<soundBaseExplosion1
	STA note1
	LDA #>soundBaseExplosion1
	STA note1+1
	LDA #120
	STA duration0
	STA duration1

	RTS

gameInit

	LDA #0
	STA PF0			; playfield graphics
	STA PF1
	STA PF2

	STA firePosition
	STA fireCounter
	STA diffSwitch

	STA rotateOffset

	STA fighterTopPos
	STA fighterBottomPos
	STA fighterMiddleWait

	STA scoreDigits
	STA scoreDigits+1
	STA scoreDigits+2
	STA scoreDigits+3
	STA scoreDigits+4
	STA scoreDigits+5

	LDA #$11
	STA CTRLPF		; reflected playfield, double wide ball

	LDA #normalBackColor
	STA backColor		; set background color

	LDA #normalBaseColor
	STA pfColor		; color of gray
	STA p0Color
	STA COLUP0		; player 0 color
	LDA #$57
	STA fighterColor	; player 1 color

	LDA #250
	STA rotateDelay

	LDA #2
	STA ENAM0
	STA ENAM1

	LDA #47			; seed the random number generator
	STA timer
	LDA #$6D
	STA rnd
	LDA #23
	STA rnd+1

	LDA #modeSelect
	STA gameMode

	LDA #<theSoundOfSilence
	STA note0
	STA note1
	LDA #>theSoundOfSilence
	STA note0+1
	STA note1+1

	RTS

levelInit

	LDA #0
	STA fighterTopPos
	STA fighterTopWait
	STA fighterMiddlePos
	STA fighterMiddleWait
	STA fighterBottomPos
	STA fighterBottomWait

	STA scoreDigits
	STA scoreDigits+1
	STA scoreDigits+2
	STA scoreDigits+3
	STA scoreDigits+4
	STA scoreDigits+5

	STA fbFlags

	STA explosionBaseCtr

	STA newFighterCtr

	STA lastFire

	LDA #1
	STA level

	LDA #2
	STA basesLeft

	LDA #normalBackColor
	STA backColor
	LDA #normalBaseColor
	STA p0Color
	STA pfColor

	LDA tempFrame		; seed the random number generator
	STA rnd
	ADC #69
	STA rnd+1

	LDA #modePlay
	STA gameMode

	RTS

fighterJustFired

	LDA #<soundFighterFiring	; a fighter is firing
	STA note1
	LDA #>soundFighterFiring
	STA note1+1
	LDA #4
	STA duration1
	RTS

codeBottom

	org $FE40 		; *********************** GRAPHICS DATA

pageFEBegin

blankGraphics

	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00

cannonGraphicsData		; stored bottom up, of course

cannonTopGraphics

	.byte $00
	.byte $00		; . . . . . . . .
	.byte $FF		; # # # # # # # #
	.byte $66		; . # # . . # # .
	.byte $24		; . . # . . # . .
	.byte $3C		; . . # # # # . .
	.byte $5A		; . # . # # . # .
	.byte $99		; # . . # # . . #
	.byte $00		; . . . . . . . .

cannonBottomGraphics

	.byte $00
	.byte $00		; . . . . . . . .
	.byte $99		; # . . # # . . #
	.byte $5A		; . # . # # . # .
	.byte $3C		; . . # # # # . .
	.byte $24		; . . # . . # . .
	.byte $66		; . # # . . # # .
	.byte $FF		; # # # # # # # #
	.byte $00		; . . . . . . . .

cannonLeftGraphics

	.byte $00
	.byte $42		; . # . . . . # .
	.byte $26		; . . # . . # # .
	.byte $1E		; . . . # # # # .
	.byte $72		; . # # # . . # .
	.byte $72		; . # # # . . # .
	.byte $1E		; . . . # # # # .
	.byte $26		; . . # . . # # .
	.byte $42		; . # . . . . # .

cannonRightGraphics

	.byte $00
	.byte $42		; . # . . . . # .
	.byte $64		; . # # . . # . .
	.byte $78		; . # # # # . . .
	.byte $4E		; . # . . # # # .
	.byte $4E		; . # . . # # # .
	.byte $78		; . # # # # . . .
	.byte $64		; . # # . . # . .
	.byte $42		; . # . . . . # .

cannonPixelPosition

	.byte 0			; no cannon
	.byte 76		; top
	.byte 64		; left
	.byte 88		; right
	.byte 76		; bottom

fighterTopGraphics

	;.byte $00
	.byte $DB		; # # . # # . # #
	.byte $FF		; # # # # # # # #
	.byte $FF		; # # # # # # # #
	.byte $5A		; . # . # # . # .
	.byte $18		; . . . # # . . .
	.byte $3C		; . . # # # # . .
	.byte $3C		; . . # # # # . .
	.byte $18		; . . . # # . . .

fighterLeftGraphics

	.byte $00
	.byte $E0		; # # # . . . . .
	.byte $F0		; # # # # . . . .
	.byte $66		; . # # . . # # .
	.byte $FF		; # # # # # # # #
	.byte $FF		; # # # # # # # #
	.byte $66		; . # # . . # # .
	.byte $F0		; # # # # . . . .
	.byte $E0		; # # # . . . . .

fighterRightGraphics

	.byte $00
	.byte $07		; . . . . . # # #
	.byte $0F		; . . . . # # # #
	.byte $66		; . # # . . # # .
	.byte $FF		; # # # # # # # #
	.byte $FF		; # # # # # # # #
	.byte $66		; . # # . . # # .
	.byte $0F		; . . . . # # # #
	.byte $07		; . . . . . # # #

fighterBottomGraphics

	;.byte $00
	.byte $18		; . . . # # . . .
	.byte $3C		; . . # # # # . .
	.byte $3C		; . . # # # # . .
	.byte $18		; . . . # # . . .
	.byte $5A		; . # . # # . # .
	.byte $FF		; # # # # # # # #
	.byte $FF		; # # # # # # # #
	.byte $DB		; # # . # # . # #

bombGraphics

	.byte $00
	.byte $00		; ........
	.byte $42		; .#....#.
	.byte $18		; ...##...
	.byte $3C		; ..####..
	.byte $3C		; ..####..
	.byte $18		; ...##...
	.byte $42		; .#....#.
	.byte $00		; ........

explosionGraphics
explosion0Graphics

	.byte $00
	.byte $08		; ....#...
	.byte $2A		; ..#.#.#.
	.byte $76		; .###.#..
	.byte $88		; #...#...
	.byte $5A		; .#.##.#.
	.byte $D1		; ##.#...#
	.byte $2A		; ..#.#.#.
	.byte $14		; ...#.#..

explosion1Graphics

	.byte $00
	.byte $28		; ..#.#...
	.byte $62		; .##...#.
	.byte $56		; .#.#.##.
	.byte $EB		; ###.#.##
	.byte $56		; .#.#.##.
	.byte $1C		; ...###..
	.byte $56		; .#.#.##.
	.byte $08		; ....#...

explosion2Graphics

	.byte $00
	.byte $2C		; ..#.##..
	.byte $2A		; .##.#.#.
	.byte $56		; .#.#.##.
	.byte $D4		; ##.#.#..
	.byte $22		; ..#...#.
	.byte $66		; .##..##.
	.byte $D8		; ##.##...
	.byte $1C		; ...###..

explosion3Graphics

	.byte $00
	.byte $08		; ....#...
	.byte $4C		; .#..##..
	.byte $96		; #..#.##.
	.byte $69		; .##.#..#
	.byte $B2		; #.##..#.
	.byte $86		; #....##.
	.byte $68		; .##.#...
	.byte $08		; ....#...

; sound data
; voice, pitch, duration

soundBegin

theSoundOfSilence

	.byte  0,  0,  0

soundFire

	.byte  7,  0,  1
	.byte  7,  1,  1
	.byte  7,  2,  1
	.byte  7,  3,  1
	.byte  7,  4,  1
	.byte  7,  5,  1
	.byte  7,  6,  1
	.byte  7,  7,  1
	.byte  7,  8,  1
	.byte  0,  0,  0

soundFighterExplosion

	.byte 15, 31,  2
	.byte  0,  0,  0

soundFighterFiring

	.byte 14, 15,  4
	.byte  0,  0,  0

soundBaseExplosion0

	.byte  8, 31,120
	.byte  0,  0,  0

soundBaseExplosion1

	.byte  9, 31,120
	.byte  0,  0,  0

soundEnd

pageFEEnd

	org $FF00		; digits data

pageFFBegin

zeroGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $67		; .##..###
	.byte $67		; .##..###
	.byte $67		; .##..###
	.byte $63		; .##...##
	.byte $63		; .##...##
	.byte $7F		; .#######

oneGraphics

	.byte $00
	.byte $1C		; ...###..
	.byte $1C		; ...###..
	.byte $1C		; ...###..
	.byte $1C		; ...###..
	.byte $0C		; ....##..
	.byte $0C		; ....##..
	.byte $0C		; ....##..

twoGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $70		; .###....
	.byte $70		; .###....
	.byte $7F		; .#######
	.byte $03		; ......##
	.byte $03		; ......##
	.byte $7F		; .#######

threeGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $7F		; .#######
	.byte $03		; ......##
	.byte $03		; ......##
	.byte $7F		; .#######

fourGraphics

	.byte $00
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $7F		; .#######
	.byte $63		; .##...##
	.byte $63		; .##...##
	.byte $63		; .##...##

fiveGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $7F		; .#######
	.byte $60		; .##.....
	.byte $60		; .##.....
	.byte $7F		; .#######

sixGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $67		; .##..###
	.byte $67		; .##..###
	.byte $7F		; .#######
	.byte $60		; .##.....
	.byte $60		; .##.....
	.byte $7F		; .#######

sevenGraphics

	.byte $00
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $03		; ......##
	.byte $03		; ......##
	.byte $7F		; .#######

eightGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $67		; .##..###
	.byte $67		; .##..###
	.byte $7F		; .#######
	.byte $63		; .##...##
	.byte $63		; .##...##
	.byte $7F		; .#######

nineGraphics

	.byte $00
	.byte $7F		; .#######
	.byte $07		; .....###
	.byte $07		; .....###
	.byte $7F		; .#######
	.byte $63		; .##...##
	.byte $63		; .##...##
	.byte $7F		; .#######

smileyGraphics

	.byte $00
	.byte $0C		; ....##..
	.byte $66		; .##..##.
	.byte $63		; .##...##
	.byte $03		; ......##
	.byte $63		; .##...##
	.byte $66		; .##..##.
	.byte $0C		; ....##..

levelGraphics

	.byte $00
	.byte $DB		; ##.##.##
	.byte $FF		; ########
	.byte $5A		; .#.##.#.
	.byte $18		; ...##...
	.byte $3C		; ..####..
	.byte $3C		; ..####..
	.byte $18		; ...##...

basesRemainingGraphics

	.byte $00
	.byte $C3		; ##....##
	.byte $C3		; ##....##
	.byte $3C		; ..####..
	.byte $3C		; ..####..
	.byte $3C		; ..####..
	.byte $C3		; ##....##
	.byte $C3		; ##....##

digitGraphicsTableLow
	.byte <zeroGraphics
	.byte <oneGraphics
	.byte <twoGraphics
	.byte <threeGraphics
	.byte <fourGraphics
	.byte <fiveGraphics
	.byte <sixGraphics
	.byte <sevenGraphics
	.byte <eightGraphics
	.byte <nineGraphics
	.byte <smileyGraphics

digitGraphicsTableHigh
	.byte >zeroGraphics
	.byte >oneGraphics
	.byte >twoGraphics
	.byte >threeGraphics
	.byte >fourGraphics
	.byte >fiveGraphics
	.byte >sixGraphics
	.byte >sevenGraphics
	.byte >eightGraphics
	.byte >nineGraphics
	.byte >smileyGraphics

rotatingColorsBegin

rotatingBack

	.byte	$00,$16,$26,$36,$46,$56,$66,$76,$86,$96,$A6,$B6,$C6,$D6,$E6,$F6

rotatingPF

	.byte 	$06,$1A,$2A,$3A,$4A,$5A,$6A,$7A,$8A,$9A,$AA,$BA,$CA,$DA,$EA,$FA

rotatingColorsEnd

topBallEnableData
	.byte $00,$02,$00,$00,$00

bottomBallEnableData
	.byte $00,$00,$00,$00,$02

fighterStepAmount			; step amounts for the fighter movement per level (zero based)
	.byte   1,  1,  1,  1,  2,  2,  2,  2,  3

fighterWaitAmount			; wait amounts for the fighter movement per level (amateur)
	.byte 255,100, 50, 40, 60, 50, 45, 35, 30

fighterWaitAmountA			; wait amounts for the fighter movement per level (pro)
	.byte 255,100, 50, 40, 60, 50, 45, 35, 26

levelFinishedAmount			; number of fighters destroyed to complete level (zero based)
	.byte  10, 12, 14, 16, 18, 20, 20, 20,200

levelFighterColor			; fighter colors per level (zero based)
	.byte $57,$67,$77,$87,$97,$A7,$B7,$C7,$2F

levelRandomNumber			; random number to be less than to post a new fighter (amateur)
	.byte   3,  5,  7,  9, 11, 14, 16, 19, 23

levelRandomNumberA			; random number to be less than to post a new fighter (pro)
	.byte  10, 12, 14, 16, 18, 20, 22, 24, 33

explosionGraphicsTableLow		; rearranged to optimize space

	.byte <explosion0Graphics
	.byte <explosion1Graphics
	.byte <explosion2Graphics
	.byte <explosion3Graphics

explosionGraphicsTableHigh

	.byte >explosion0Graphics
	.byte >explosion1Graphics
	.byte >explosion2Graphics
	.byte >explosion3Graphics

pageFFEnd

keepSuperchargerHappy

	org $FFF8

	.byte $00

pcVectors

	org $FFFC 		; *********************** PROGRAM COUNTER VECTORS

	.word start
	.word start

; end of spacezap.asm
