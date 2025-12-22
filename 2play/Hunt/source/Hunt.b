{*************************************
name:         Hunt
genre:        strategy action
players:      2 (parallel)
progr. lang.: ACE 2.35
language:     English
status:       Freeware
author:       Malte Schreiber
              Schulring 38
              D-41812 Erkelenz
              Germany
*************************************}
randomize timer
defint a-z,_

shortint p  'current player (0 or 1)
dim laby$(200) size 201,v$(1,3,3) size 2,tv$(1,3,3) size 2'v$ = view(p,x,y)
dim x(1),y(1),TrX(9),TrY(9)  'TrX/TrY = transporter coordinates
dim TL$(1) size 2, TR$(1) size 2, FW$(1) size 2, MS$(1) size 2
dim MI$(1) size 2, SH$(1) size 2
dim keys(1),energy(1),mines(1),xR(1),yR(1)
string Key_pressed$ size 2
string t$ size 75 'temporary
string f$ size 2
shortint different  'Dungeon altered since last call?

rem *******************************SUBs******************************
sub shortint othpl(p)   'other player
  if p = 0 then othpl = 1 else othpl = 0
end sub

sub showValues(p)
  shared keys,energy,mines
  locate 17
  color 1,0
  prints tab(2+p*24);"keys:  ";str$(keys(p))  ;" "
  prints tab(2+p*24);"energy:";str$(energy(p));" "
  prints tab(2+p*24);"mines: ";str$(mines(p)) ;" "
end sub

sub viewfield(p)
  shared laby$,v$,tv$,xR,yR,x,y,different, t$
  different = 0
  for tx = 1 to 3
    for ty = 1 to 3
      case
        xR(p) = 1: t2x=x(p)+ty   : t2y=y(p)+tx-2
        xR(p) =-1: t2x=x(p)-ty   : t2y=y(p)-tx+2
        yR(p) = 1: t2x=x(p)-tx+2 : t2y=y(p)+ty
        yR(p) =-1: t2x=x(p)+tx-2 : t2y=y(p)-ty
      end case
      v$(p,tx,ty) = mid$(Laby$(t2y),t2x,1)
      if t2x = x(othpl(p)) and t2y = y(othpl(p)) then v$(p,tx,ty) = "!"
      if v$(p,tx,ty) <> tv$(p,tx,ty) then different = -1
      tv$(p,tx,ty) = v$(p,tx,ty)
    next
  next
  if v$(p,2,1) = "*" or v$(p,2,1) = "&" or v$(p,2,1) = "!" then
    v$(p,1,3) = " ": v$(p,2,3) = " ": v$(p,3,3) = " ": v$(p,1,2) = " "
    v$(p,2,2) = " ": v$(p,3,2) = " ": v$(p,1,1) = " ": v$(p,3,1) = " "
  end if
  if v$(p,2,2) = "*" or v$(p,2,2) = "&" or v$(p,2,2) = "!" then
    v$(p,2,3) = " "
    if v$(p,1,2) = "*" or v$(p,1,2) = "&" or v$(p,1,2) = "!" then v$(p,1,3)~
     = " "
    if v$(p,3,2) = "*" or v$(p,3,2) = "&" or v$(p,3,2) = "!" then v$(p,3,3)~
     = " "
  end if
end sub


sub show3D(p)
  shared v$
  ShiftX = p*192

  'basic graphic
  line (11+ShiftX,11)-(107+ShiftX,107),5,bf  'paint grey
  color 1,0
  area(10+ShiftX,51):area(108+ShiftX,51):area(108+ShiftX,67):area(10+ShiftX,67)
  areafill  'background black

  line (10+ShiftX,10)-(108+ShiftX,108),1:line (108+ShiftX,10)-(10+ShiftX,108),1

  line (10+ShiftX,42)-(108+ShiftX,42),1:line (10+ShiftX,76)-(108+ShiftX,76),1
  line (10+ShiftX,30)-(108+ShiftX,30),1:line (10+ShiftX,88)-(108+ShiftX,88),1

  if v$(p,1,3) = "*" or v$(p,1,3) = "&" or v$(p,1,3) = "!" then
    if v$(p,1,3) = "&" then color 7 else color 4
    if v$(p,1,3) = "!" then color 2
    area(11+ShiftX,43):area(41+ShiftX,43):area(50+ShiftX,51)
    area(50+ShiftX,67):area(41+ShiftX,75):area(11+ShiftX,75)
    areafill
    line (42+ShiftX,42)-(42+ShiftX,76),1
  end if
  if v$(p,3,3) = "*" or v$(p,3,3) = "&" or v$(p,3,3) = "!" then
    if v$(p,3,3) = "&" then color 7 else color 4
    if v$(p,3,3) = "!" then color 2
    area(68+ShiftX,51):area(76+ShiftX,43):area(107+ShiftX,43)
    area(107+ShiftX,75):area(77+ShiftX,75):area(68+ShiftX,67)
    areafill
    line (76+ShiftX,42)-(76+ShiftX,76),1
  end if
  if v$(p,2,3) = "*" or v$(p,2,3) = "&" or v$(p,2,3) = "!" then
    if v$(p,2,3) = "&" then color 7 else color 4
    if v$(p,2,3) = "!" then color 2
    area(43+ShiftX,43):area(75+ShiftX,43):area(75+ShiftX,75):area(43+ShiftX,75)
    areafill
    line (42+ShiftX,42)-(42+ShiftX,76),1:line (76+ShiftX,42)-(76+ShiftX,76),1
  end if

  if v$(p,1,2) = "*" or v$(p,1,2) = "&" or v$(p,1,2) = "!" then
    if v$(p,1,2) = "&" then color 7 else color 4
    if v$(p,1,2) = "!" then color 2
    area(11+ShiftX,31):area(30+ShiftX,31):area(41+ShiftX,42)
    area(41+ShiftX,76):area(30+ShiftX,87):area(11+ShiftX,87)
    areafill
    line (30+ShiftX,30)-(30+ShiftX,88),1:line (42+ShiftX,76)-(42+ShiftX,42),1
  end if
  if v$(p,3,2) = "*" or v$(p,3,2) = "&" or v$(p,3,2) = "!" then
    if v$(p,3,2) = "&" then color 7 else color 4
    if v$(p,3,2) = "!" then color 2
    area(107+ShiftX,87):area(107+ShiftX,31):area(88+ShiftX,31)
    area(77+ShiftX,42):area(77+ShiftX,76):area(88+ShiftX,87)
    areafill
    line (88+ShiftX,88)-(88+ShiftX,30),1:line (76+ShiftX,76)-(76+ShiftX,42),1
  end if
  if v$(p,2,2) = "*" or v$(p,2,2) = "&" or v$(p,2,2) = "!" then
    if v$(p,2,2) = "&" then color 7 else color 4
    if v$(p,2,2) = "!" then color 2
    area(31+ShiftX,31):area(87+ShiftX,31):area(87+ShiftX,87)
    area(31+ShiftX,87)
    areafill
    line (30+ShiftX,30)-(30+ShiftX,88),1:line (88+ShiftX,30)-(88+ShiftX,88),1
  end if

  if v$(p,1,1) = "*" or v$(p,1,1) = "&" or v$(p,1,1) = "!" then
    if v$(p,1,1) = "&" then color 7 else color 4
    if v$(p,1,1) = "!" then color 2
    area(11+ShiftX,12):area(29+ShiftX,30):area(29+ShiftX,88)
    area(11+ShiftX,106)
    areafill
    line (30+ShiftX,30)-(30+ShiftX,88),1
  end if
  if v$(p,3,1) = "*" or v$(p,3,1) = "&" or v$(p,3,1) = "!" then
    if v$(p,3,1) = "&" then color 7 else color 4
    if v$(p,3,1) = "!" then color 2
    area(107+ShiftX,106):area(89+ShiftX,88):area(89+ShiftX,30)
    area(107+ShiftX,12)
    areafill
    line (88+ShiftX,30)-(88+ShiftX,88),1
  end if
  if v$(p,2,1) = "*" or v$(p,2,1) = "&" or v$(p,2,1) = "!" then
    if v$(p,2,1) = "&" then color 7 else color 4
    if v$(p,2,1) = "!" then color 2
    area(11+ShiftX,11):area(107+ShiftX,11):area(107+ShiftX,107)
    area(11+ShiftX,107)
    areafill
  end if

  color 6,5
  locate 13
  prints tab(8+p*24);
  t$ = v$(p,2,1)
  if t$ = "$" or t$ = "§" or t$ = "-" or t$ = "%" then prints t$
  if val(t$) > 0 then prints "T"
end sub

sub showdir(p)
  shared xR,yR
  locate 1
  color 3,0
  prints tab(8+p*24);
  case
    yR(p) =-1: prints "N"
    yR(p) = 1: prints "S"
    xR(p) =-1: prints "W"
    xR(p) = 1: prints "E"
  end case
end sub

rem *********** Tastenbelegung laden *******************
open "I",#1,"Hunt.keys"
for p = 0 to 1
  TL$(p) = input$(1,#1)
  TR$(p) = input$(1,#1)
  FW$(p) = input$(1,#1)
  SH$(p) = input$(1,#1)
  MI$(p) = input$(1,#1)
next
close #1

rem **********************  screen, window and menu ********************
screen 1,320,256,3,1
window 1,"Hunt",(0,0)-(320,256),4,1
palette 0,.7,.7,.7  :palette 1,0,0,0         :palette 2,.1,.3,.1
palette 3,.3,.43,.8 :palette 5,.15,.15,.15
palette 4,.3,0,.23  :palette 6,.5,.5,.1 :palette 7,.3,.2,.1

menu 1,0,1,"Menu"
menu 1,1,1,"About   ","A"
menu 1,2,1,"New game","N"
menu 1,3,0,"---------------"
menu 1,4,1,"Quit    ","Q"
on menu gosub menuevent
menu on

rem *********************** load level ****************************
Again:
  open "I",#1,filebox$("SELECT A LEVEL!","levels")
  line input #1,t$
  if t$ <> "#HUNT LEVEL FILE" then close #1:goto again
  input #1,rows
  for t = 1 to rows
    line input #1,Laby$(t)
  next
  for p = 0 to 1
    input #1,x(p),y(p),mines(p),keys(p),energy(p),t$
    case
      t$ = "N": xR(p) = 0 : yR(p) =-1
      t$ = "S": xR(p) = 0 : yR(p) = 1
      t$ = "E": xR(p) = 1 : yR(p) = 0
      t$ = "W": xR(p) =-1 : yR(p) = 0
    end case
  next

  for t = 1 to 9
    input #1,TrX(t),TrY(t)
  next

  cls
  repeat
    line input #1,t$
    color 1,0
    prints t$
    if csrlin > 28 then
      color 3,0
      prints "Press SPACE to continue"
      Key_pressed$ = ""
      repeat
        sleep
        Key_pressed$ = inkey$
      until Key_pressed$ = " "
      cls
    end if
  until eof(1)
  close #1
  color 3,0
  prints "Press SPACE to start game"
  Key_pressed$ = ""
  repeat
    sleep
    Key_pressed$ = inkey$
  until Key_pressed$ = " "
  cls


rem ************ draw basic graphic *************
line (10,10)-(108,108),1,b
line (202,10)-(300,108),1,b

for p = 0 to 1
  showdir(p)
  viewfield(p)
  show3D(p)
  showValues(p)
next

dead = -1
rem *****************  M A I N   L O O P  ********************
repeat
  Key_pressed$ = ""
  repeat
    sleep
    Key_pressed$ = inkey$
  until Key_pressed$ <> "" or dead <> -1  'falls New game im Menu aufgerufen
  for t = 0 to 1
    if Key_pressed$=FW$(t) or Key_pressed$=TR$(t) or Key_pressed$=TL$(t) or~
     Key_pressed$=MS$(t) or Key_pressed$=MI$(t) or Key_pressed$=SH$(t) then~
     p = t
  next
  f$ = Mid$(Laby$(y(p)),x(p),1)
  if Key_pressed$ = FW$(p) then
    tf$ = mid$(Laby$(y(p)+yR(p)),x(p)+xR(p),1)
    if tf$ <> "*" and not (tf$ = "&" and keys(p) = 0) and not~
     (x(p)+xR(p) = x(othpl(p)) and y(p)+yR(p) = y(othpl(p))) then
      f$ = tf$
      x(p) = x(p) + xR(p)
      y(p) = y(p) + yR(p)
      if f$ = "&" or f$ = "%" or f$ = "$" or f$= "§" or f$ = "#" then
        if F$ = "&" then keys(p) = keys(p)-1
        if F$ = "%" then mines(p) = mines(p)+1
        if F$ = "§" then keys(p) = keys(p)+1
        if f$ = "$" then energy(p) = energy(p)+10
        if F$ = "#" then
          energy(p) = energy(p)-int(15+rnd*10)
          beep
          if energy(p) <= 0 then dead = p
        end if
        showValues(p)
        f$ = " "
      end if
      if val(F$) > 0 then
        x(p) = TrX(VAL(F$))
        y(p) = TrY(VAL(F$))
        f$ = mid$(Laby$(y(p)),x(p),1)
      end if
      viewfield(p)
      show3D(p)
      viewfield(othpl(p))
      if different then call show3D(othpl(p))
    end if
  end if
  if Key_pressed$ = TL$(p) or Key_pressed$ = TR$(p) then
    case
      xR(p) = 1: xR(p) = 0:yR(p) = 1
      xR(p) =-1: xR(p) = 0:yR(p) =-1
      yR(p) = 1: xR(p) =-1:yR(p) = 0
      yR(p) =-1: xR(p) = 1:yR(p) = 0
    end case
    if Key_pressed$ = TL$(p) then xR(p) = -1*xR(p):yR(p) = -1*yR(p)
    showdir(p)
    viewfield(p)
    show3D(p)
  end if
  if Key_pressed$ = MI$(p) and mines(p) > 0 and val(f$) = 0 then
    mines(p) = mines(p)-1
    f$ = "#"
    showValues(p)
  end if
  if Key_pressed$ = SH$(p) then
    showValues(p)
    tx = x(p)
    ty = y(p)
    t = 0
    Treffer = 0
    repeat
      tx = tx + xR(p)
      ty = ty + yR(p)
      t = t + 1
      if x(othpl(p)) = tx and y(othpl(p)) = ty then
        t = int(30+rnd*10-t*.2)
        if t > 0 then
          energy(othpl(p)) = energy(othpl(p))-t
          if energy(othpl(p)) <= 0 then dead = othpl(p)
          showValues(othpl(p))
          beep
        end if
        Treffer = -1
      end if
      if mid$(Laby$(ty),tx,1) = "*" or mid$(Laby$(ty),tx,1) = "&" then
        Treffer = -1
      end if
    until Treffer or dead <> -1
  end if
  Laby$(y(p)) = left$(Laby$(y(p)),x(p)-1)+f$+mid$(Laby$(y(p)),x(p)+1)
until dead <> -1

color 1,0
cls
if dead = 2 then
  prints "Both players are destroyed."
else
  prints "Player";dead+1;"is destroyed!!!"
  prints "Congratulations, player";str$(othpl(dead)+1);"!"
end if
goto Again




MenuEvent:
  if Menu(0) = 1 then
    if Menu(1) = 1 then
      msgbox "© 1996 Malte Schreiber (Freeware).","Continue"
    end if
    if Menu(1) = 2 then
      if msgbox("Stop this game?","Yes","No") then dead = 2
    end if
    if Menu(1) = 4 then
      if msgbox("Do you REALLY wanna quit?!!","Yes","No") then
        window close 1
        screen close 1
        close #1
        stop
      end if
    end if
  end if
  return



