Global A,A$

Print "  Level"
Print "   !Credits"
Print "   ! !Lives"
Print "   ! !!Weapon"
Print "   ! !! /!Keys"
Print "  /!/!!/ !![   ]"

Print "  ==============××"

Input A$
'A$="FKAAICAAAICAAA" : Print "? ";A$ 


A$=Upper$(A$) : Cup : Locate 0, : Print "  ";A$; : If A$="" Then Edit 

Proc CALC : A$="HB"
For I=1 To A : Proc CHECK : Next I

Print A$ : Print : Print "  THANKS,MNT!"



Procedure CHECK
   C$="SPNMLKJIHGFEDCBA"
   
   E=Instr(C$,Mid$(A$,2,1))
   Z=Instr(C$,Mid$(A$,1,1))
   
   If E=16
      Add Z,1,1 To 16
   End If 
   
   Add E,1,1 To 16
   
   A$=Mid$(C$,Z,1)+Mid$(C$,E,1)
End Proc

Procedure CALC
   C$="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
   A=0 : For I=1 To 14 : B=Instr(C$,Mid$(A$,I,1))-1 : A=A+B : Next I
End Proc
