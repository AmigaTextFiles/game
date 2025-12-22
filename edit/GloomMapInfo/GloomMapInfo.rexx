/* $VER: GloomMapInfo.rexx 1.0 License: Public Domain */

PARSE ARG file

IF file="" | file="?" THEN
	SAY 'Usage: GloomMapInfo.rexx <file>'
ELSE
	CALL main

EXIT 0

main:
	PARSE VALUE 0 WITH player2, health, thermo, invisib, invinci, dragon, bouncys, marine, baldy, terra, ghoul, phantom, demon, ball1, ball2, ball3, ball4, ball5, 	lizard, dethhed, troll
	skip=2 /* skip some unwanted bytes */
	file=STRIP(file,'B','"')
	IF OPEN('f',file,'R') THEN DO
		CALL SEEK('f',22)
		offset=READCH('f',2)
		CALL SEEK('f',C2D(offset)+skip,'B')
		DO UNTIL item=FF
			chrs=READCH('f',2) /* get WORD (2 bytes) of data */
			item=RIGHT(C2X(chrs),2) /* $000A -> $0A */
			SELECT
				WHEN item=01 THEN player2=player2+1
				WHEN item=02 THEN health=health+1
				WHEN item=04 THEN thermo=thermo+1
				WHEN item=06 THEN invisib=invisib+1
				WHEN item=07 THEN invinci=invinci+1
				WHEN item=08 THEN dragon=dragon+1
				WHEN item=09 THEN bouncys=bouncys+1
				WHEN item=0A THEN marine=marine+1
				WHEN item=0B THEN baldy=baldy+1
				WHEN item=0C THEN terra=terra+1
				WHEN item=0D THEN ghoul=ghoul+1
				WHEN item=0E THEN phantom=phantom+1
				WHEN item=0F THEN demon=demon+1
				WHEN item=10 THEN ball1=ball1+1
				WHEN item=11 THEN ball2=ball2+1
				WHEN item=12 THEN ball3=ball3+1
				WHEN item=13 THEN ball4=ball4+1
				WHEN item=14 THEN ball5=ball5+1
				WHEN item=15 THEN lizard=lizard+1
				WHEN item=16 THEN dethhed=dethhed+1
				WHEN item=17 THEN troll=troll+1
				OTHERWISE NOP
			END
		END
		CALL CLOSE('f')
		IF player2>0 THEN SAY 'player2='player2 '// This map supports two player simultaneous gameplay mode :)' ; ELSE SAY 'This map cannot be played with two player simultaneous! :('
		IF health>0 THEN SAY 'health='health
		IF thermo>0 THEN SAY 'thermo='thermo
		IF invisib>0 THEN SAY 'invisib='invisib
		IF invinci>0 THEN SAY 'invinci='invinci
		IF dragon>0 THEN SAY 'dragon='dragon
		IF bouncys>0 THEN SAY 'bouncys='bouncys
		IF marine>0 THEN SAY 'marine='marine
		IF baldy>0 THEN SAY 'baldy='baldy
		IF terra>0 THEN SAY 'terra='terra
		IF ghoul>0 THEN SAY 'ghoul='ghoul
		IF phantom>0 THEN SAY 'phantom='phantom
		IF demon>0 THEN SAY 'demon='demon
		IF ball1>0 THEN SAY 'ball1='ball1
		IF ball2>0 THEN SAY 'ball2='ball2
		IF ball3>0 THEN SAY 'ball3='ball3
		IF ball4>0 THEN SAY 'ball4='ball4
		IF ball5>0 THEN SAY 'ball5='ball5
		IF lizard>0 THEN SAY 'lizard='lizard
		IF dethhed>0 THEN SAY 'dethhed='dethhed
		IF troll>0 THEN SAY 'troll='troll
		SAY 'Total objects='player2+health+thermo+invisib+invinci+dragon+bouncys+marine+baldy+terra+ghoul+phantom+demon+ball1+ball2+ball3+ball4+ball5+lizard+dethhed+troll
	END
	ELSE
		SAY "Error! Can't open file:" file
RETURN
