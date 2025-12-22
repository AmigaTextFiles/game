REM Alternate Reality Map Maker - should have ARMap.bin file
REM 11.7.1990 - First version - doesn't draw anything useful 
REM 24.7.1990 - It works! Added own screen, better file handling etc.

CLEAR ,64000&
DEFINT a-z
DIM coltab(15),pattab(15),place(70,1),place$(70)
sy=7:sx=9
SCREEN 2,640,512,2,4
WINDOW 2,"Alternate Reality Map",,8,2
PALETTE 0,0,0,0
PALETTE 1,1,1,1
PALETTE 2,.8,.6,.53
PALETTE 3,1,.6,.67
WINDOW OUTPUT 2
WIDTH 76

FOR z=0 TO 7:READ bit(z):NEXT z:DATA 1,2,4,8,16,32,64,128
FOR i=0 TO 15:READ coltab(i):NEXT i
DATA 0,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1
FOR i=0 TO 15:READ pattab(i):NEXT i
DATA &HFFFF,&HFFFF,&HFFFF,&HCCCC,&HDB6D,&HAAAA,&HFFFF,&HFFFF
DATA &HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF

pm=0
WHILE place(pm,0)<>999
  pm=pm+1
  READ place(pm,0),place(pm,1),place$(pm)
WEND
REM i=inn, b=bank, t=tavern, s=shop, w=smithy, g=guild,
REM h=healer, d=dungeon entrance
DATA 26,32,i,25,33,i,24,33,i,20,10,i,4,32,i,7,61,i
DATA 53,34,i,55,29,i,30,40,t,20,33,t,25,8,t,13,14,t
DATA 10,45,t,3,61,t,31,61,t,34,58,t,36,6,t,36,7,t
DATA 55,2,t,63,21,t,54,34,t,57,53,t,28,39,b,7,31,b
DATA 62,3,b,25,36,s,31,36,s,14,1,s,13,4,s,6,20,s
DATA 16,26,s,9,52,s,10,53,s,19,56,s,37,47,s,56,34,s
DATA 57,38,a,62,61,s,60,27,s,44,21,s,44,22,s,38,10,s
DATA 28,33,w,10,55,w,35,51,w,33,20,w,20,5,h,30,30,h
DATA 3,56,g,15,48,g,22,34,g,48,19,g,12,28,g
DATA 15,6,g,5,3,g,60,51,g,50,58,g,50,62,g,43,12,g
DATA 35,44,g
REM These weren't in the original help file
DATA 35,42,t,57,39,s
REM Dungeon entrances
DATA 61,51,d,2,60,d
DATA 999 ,999,z

GOSUB DrawPlaces

OPEN "ARMap.bin" FOR INPUT AS 1

a$=INPUT$(8,1):REM Remove the garbage "y Wallxxxxxx"
x=0:y=0
map$=INPUT$(16384,1):REM Read the Alternate Reality Map File

x=0:y=0:EndFlag=0
WHILE EndFlag=0
  GOSUB Draw          :REM Draw map on screen 
  REM GOSUB Analyze
WEND 

WHILE INKEY$<>" ":WEND
WINDOW CLOSE 2:SCREEN CLOSE 2
END

Draw:
  addr=4*(y*64+x)+1
  FOR i=0 TO 3:a(i)=ASC(MID$(map$,addr+i,1)):NEXT i
  a=a(2) AND 15:c=coltab(a): PATTERN pattab(a) 
  LINE (x*sx,y*sy)-STEP(sx,0),c:REM N
  a=(a(2) AND 240)/16:c=coltab(a): PATTERN pattab(a) 
  LINE (x*sx+sx-1,y*sy)-STEP(0,sy-1),c:REM E
  a=a(3) AND 15:c=coltab(a): PATTERN pattab(a) 
  LINE (x*sx,y*sy+sy-1)-STEP(sx,0),c:REM S
  a=(a(3) AND 240)/16:c=coltab(a): PATTERN pattab(a) 
  LINE (x*sx,y*sy)-STEP(0,sy-1),c:REM W
  x=x+1:IF x>64 THEN y=y+1:x=0:IF y>64 THEN EndFlag=1
RETURN

DrawPlaces:
  FOR i=1 TO pm-1
    x=sx*(place(i,1)-1):y=441-sy*(place(i,0)-1)
    IF place$(i)="i" THEN
      LINE (x+2,y+1)-(x+6,y+1),3
      LINE (x+3,y+2)-(x+4,y+4),3,bf
      LINE (x+2,y+5)-(x+6,y+5),3
    END IF
    IF place$(i)="t" THEN
      LINE (x+1,y+1)-(x+7,y+1),3: LINE (x+3,y+2)-(x+4,y+5),3,bf
    END IF
    IF place$(i)="s" THEN
      LINE (x+1,y+1)-(x+2,y+3),3,bf: LINE (x+6,y+3)-(x+7,y+5),3,bf
      LINE (x+3,y+1)-(x+7,y+1),3:LINE (x+1,y+5)-(x+7,y+5),3
      LINE (x+3,y+3)-(x+5,y+3),3
    END IF
    IF place$(i)="g" THEN
      LINE (x+1,y+1)-(x+2,y+3),3,bf:LINE (x+3,y+1)-(x+5,y+1),3
      LINE (x+6,y+1)-(x+7,y+5),3,bf:LINE (x+3,y+3)-(x+5,y+3),3
      LINE (x+1,y+5)-(x+5,y+5),3
    END IF
    IF place$(i)="w" THEN
      LINE (x+1,y+1)-(x+7,y+5),3:LINE (x+1,y+5)-(x+7,y+1),3
    END IF
    IF place$(i)="h" THEN
      LINE (x+1,y+1)-(x+2,y+5),3,bf:LINE (x+6,y+1)-(x+7,y+5),3,bf
      LINE (x+3,y+3)-(x+5,y+3),3
    END IF
    IF place$(i)="b" THEN
      LINE (x+1,y+1)-(x+2,y+5),3,bf:LINE (x+3,y+3)-(x+7,y+5),3,bf
      LINE (x+3,y+4)-(x+6,y+4),0
    END IF
    IF place$(i)="d" THEN
      LINE (x+1,y+1)-(x+1,y+5),3: LINE (x+3,y+2)-(x+3,y+4),3
      LINE (x+5,y+3)-(x+5,y+3),3
    END IF
  NEXT i
RETURN

Analyze:
  x=x+1:IF x>64 THEN y=y+1:x=1:IF y>64 THEN EndFlag=1:RETURN
  addr=4*(y*64+x)+1
  FOR i=0 TO 3:a(i)=ASC(MID$(map$,addr+i,1)):NEXT i
  PRINT x;",";y;TAB(12);
  PRINT a(2) AND 15,(a(2) AND 240)/16,a(3) AND 15,(a(3) AND 240)/16
RETURN
