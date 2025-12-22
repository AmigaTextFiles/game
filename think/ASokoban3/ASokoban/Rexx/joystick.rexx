/*
   $VER: Joystick_Player.rexx (23.8.96)

   Written by Nils Goers.

   This script is based on Joystick.rexx, i got from
             humpty@tomate.tng.oche.de (Andreas Mixich)
*/

OPTIONS RESULTS

s.   = ""
s.ce = ""
s.ne = ""
s.nw = ""
s.sw = ""
s.se = ""
s.n  = "UP"
s.e  = "RIGHT"
s.s  = "DOWN"
s.w  = "LEFT"

j   = ''
lim = 51

SIGNAL ON break_c
SIGNAL ON halt
SIGNAL ON ioerr
SIGNAL ON syntax

IF ~show(Ports,ASOKOBAN.1) THEN DO
  say "Please start ASOKOBAN first."
  EXIT(0)
END

ADDRESS "ASOKOBAN.1"

do until exit = 1
   count = 1

   do until (oldj ~= j) | (count = lim)
      oldj  = j
    do wait = 1 to 10
      j     = ReadJoystick()
    end
      count = count + 1


      if length(j)=1 then
	 str = s.ce
      else
	 str = MOVE value('s.'substr(j,2))

      /* If button is down, overwrite center character with a `*'. */
      if left(j,1) then UNDO

        IF str ~= "" THEN DO
           IF WORDS(STR) >1 THEN str
        END

    end
   end
exit


/***************************** ReadJoystick ********************************/

/* ReadJoystick

   Return a string of 1 to 3 characters describing the state of the joystick
   in port #2. The first character describes the fire button, either 0 (up)
   or 1 (down). The second and third characters give the direction of the
   stick, as n, ne, e, se, s, sw, w, nw. If there is no second character, the
   stick is centered.

   Usage: state = ReadJoystick()
*/

ReadJoyStick: procedure
   fb = ~bittst(import('00bfe001'x,1),7)
   js = import('00dff00c'x,2)

   if bittst(js,1) then
      jd = 'e'
   else if bittst(js,9) then
      jd = 'w'
   else
      jd = ''

   if bittst(js,1) ^ bittst(js,0) then
      jd = 's'jd
   else if bittst(js,9) ^ bittst(js,8) then
      jd = 'n'jd
	
   return fb || jd

/*******************************************************************************
** Routine, die bei einer Unterbrechung des Scripts aufgerufen wird
*******************************************************************************/

break_c:
failure:
halt:
ioerr:
syntax:
   EXIT(0)
