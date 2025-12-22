Global number.c
Global tnumber.d
Global text.s
Global song.s
Global title.s
Global b.s
Global z.c
Global zs.s
Global li.s
Global ll.s
Global t.s
Global cd.s

Procedure jsoncleaner(fname0$,fname1$)
  If OpenFile(0,fname1$)
      DeleteFile(fname1$)
  EndIf
  If OpenFile(0,fname0$) And Lof(0)<>0
  OpenFile(1,fname1$)
  Repeat 
    Number = ReadByte(0)
    If number=34
      WriteByte(1, 32)
    EndIf
    If number=44
      WriteByte(1, 10)
    EndIf
    If number=58
    EndIf
    If number=95
    EndIf
    If number=91 
      WriteByte(1, 10)
    EndIf
    If number= 123
      WriteByte(1, 10)
    EndIf
    If number=124
      WriteByte(1, 10)
    EndIf
    If number<>34 And number<>44 And number<>58 And number<>91 And number<>93 And number<>95 And number<>123 And number<>125
      WriteByte(1, number)
    EndIf
  Until Eof(0)
  CloseFile(0)
  CloseFile(1)
      
ElseIf Lof(0)=0
  CloseFile(0)
  DeleteFile(fname0$)
EndIf
EndProcedure
Procedure levelcreator(fname0$,fname1$,fname2$,fname3$,multiplier)
  If OpenFile(0,fname0$) And Lof(0)<>0
    If OpenFile(1,fname1$) And Lof(1)<>0
      OpenFile(2,fname2$)
      OpenFile(3,fname3$)
   
   Repeat 
   song.s = ReadString(0)
   If FindString(song.s, "songName")
     song.s=Trim(song.s)
     song.s=RemoveString(song.s, "songName  ")
     song.s=Trim(song.s)
     WriteString(2, song.s)
     WriteByte(2,13)
     WriteByte(2,10)
     e=1
   EndIf
   Until e=1
   e=0
   FileSeek(0,0)
   
   Repeat 
   title.s = ReadString(0)
   If FindString(title.s, "songSubName")
     title.s=Trim(title.s)
     title.s=RemoveString(title.s, "songSubName")
     title.s=Trim(title.s)
     WriteString(2, title.s)
     WriteByte(2,13)
     WriteByte(2,10)
     e=1
   EndIf
   Until e=1
   e=0
   FileSeek(0,0)
   
   Repeat 
   bpm.s = ReadString(0)
   If FindString(bpm.s, "beatsPerMinute")
     bpm.s=Trim(bpm.s)
     bpm.s=RemoveString(bpm.s, "beatsPerMinute ")
     number=Int(Val(bpm.s))
     bpm.s=Str(number)
     WriteString(2, bpm.s)
     WriteByte(2,13)
     WriteByte(2,10)
     e=1
   EndIf
   Until e=1
   e=0
   FileSeek(0,Lof(0))
  CloseFile (0)
  
  Repeat 
    text.s=ReadString(1)
    If FindString(text.s, "events")
      e=1
    EndIf
  Until e=1
  e=0
  
    Repeat 
        
    text.s=ReadString(1)
    
    If FindString(text.s, "notes")
      e=1
    EndIf
    
    If FindString(text.s, "time")
      zs.s=Trim(text.s)
      zs.s=RemoveString(zs.s, "time")
      zs.s=Trim(zs.s)
      
      tnumber.d=ValD(zs.s)*multiplier
      zs.s=Str(tnumber)

      WriteString(3, zs.s)
      WriteByte(3,13)
      WriteByte(3,10)
    EndIf
    
    If FindString(text.s, "type")
      li.s=Trim(text.s)
      li.s=RemoveString(li.s, "type")
      li.s=Trim(li.s)
      number=Int(Val(li.s))
      li.s=Str(number)
      WriteString(3, li.s)
      WriteByte(3,13)
      WriteByte(3,10)
    EndIf

    If FindString(text.s, "value")
      ll.s=Trim(text.s)
      ll.s=RemoveString(ll.s, "value")
      ll.s=Trim(ll.s)
      number=Int(Val(ll.s))
      ll.s=Str(number)
      WriteString(3, ll.s)
      WriteByte(3,13)
      WriteByte(3,10)
    EndIf
   
  Until E=1
  e=0
    
  Repeat 
        
    text.s=ReadString(1)
    
    If FindString(text.s, "obstacles")
      e=1
    EndIf
    
    If FindString(text.s, "time")
      zs.s=Trim(text.s)
      zs.s=RemoveString(zs.s, "time")
      zs.s=Trim(zs.s)
      
      tnumber.d=ValD(zs.s)*multiplier
      zs.s=Str(tnumber)

      WriteString(2, zs.s)
      WriteByte(2,13)
      WriteByte(2,10)
    EndIf
    
    If FindString(text.s, "lineIndex")
      li.s=Trim(text.s)
      li.s=RemoveString(li.s, "lineIndex")
      li.s=Trim(li.s)
      number=Int(Val(li.s))
      li.s=Str(number)
      WriteString(2, li.s)
      WriteByte(2,13)
      WriteByte(2,10)
    EndIf

    If FindString(text.s, "lineLayer")
      ll.s=Trim(text.s)
      ll.s=RemoveString(ll.s, "lineLayer")
      ll.s=Trim(ll.s)
      number=Int(Val(ll.s))
      ll.s=Str(number)
      WriteString(2, ll.s)
      WriteByte(2,13)
      WriteByte(2,10)
    EndIf

    If FindString(text.s, "type")
      t.s=Trim(text.s)
      t.s=RemoveString(t.s, "type")
      t.s=Trim(t.s)
      number=Int(Val(t.s))
      t.s=Str(number)
      WriteString(2, t.s)
      WriteByte(2,13)
      WriteByte(2,10)
    EndIf

    If FindString(text.s, "cutDirection")
      c.s=Trim(text.s)
      c.s=RemoveString(c.s, "cutDirection")
      t.s=Trim(t.s)
      number=Int(Val(c.s))
      c.s=Str(number)
      WriteString(2, c.s)
      WriteByte(2,13)
      WriteByte(2,10)
   EndIf
   
  Until E=1
  e=0
  CloseFile(1)
  CloseFile(2) 
  CloseFile(3)
            
    ElseIf Lof(1)=0
    CloseFile(0)
    CloseFile(1)
    EndIf
  ElseIf Lof(0)=0
    CloseFile(0)
  EndIf
  

If OpenFile(1,fname1$)
  CloseFile(1)
  DeleteFile(fname1$)
EndIf
If OpenFile(2,fname2$) And Lof(2)=0
  CloseFile(2)
  DeleteFile(fname2$)
EndIf
If OpenFile(3,fname3$) And Lof(3)=0
  CloseFile(3)
  DeleteFile(fname3$)
EndIf
EndProcedure

jsoncleaner("info.json","info.jsonc")
jsoncleaner("info.dat","info.datc")
jsoncleaner("Easy.json","Easy.jsonc")
jsoncleaner("Normal.json","Normal.jsonc")
jsoncleaner("Hard.json","Hard.jsonc")
jsoncleaner("Expert.json","Expert.jsonc")
jsoncleaner("ExpertPlus.json","ExpertPlus.jsonc")
jsoncleaner("NoArrowsEasy.json","NoArrowsEasy.jsonc")
jsoncleaner("NoArrowsNormal.json","NoArrowsNormal.jsonc")
jsoncleaner("NoArrowsHard.json","NoArrowsHard.jsonc")
jsoncleaner("NoArrowsExpert.json","NoArrowsExpert.jsonc")
jsoncleaner("NoArrowsExpertPlus.json","NoArrowsExpertPlus.jsonc")
jsoncleaner("OneSaberEasy.json","OneSaberEasy.jsonc")
jsoncleaner("OneSaberNormal.json","OneSaberNormal.jsonc")
jsoncleaner("OneSaberHard.json","OneSaberHard.jsonc")
jsoncleaner("OneSaberExpert.json","OneSaberExpert.jsonc")
jsoncleaner("OneSaberExpertPlus.json","OneSaberExpertPlus.jsonc")
jsoncleaner("Easy.dat","Easy.datc")
jsoncleaner("Normal.dat","Normal.datc")
jsoncleaner("Hard.dat","Hard.datc")
jsoncleaner("Expert.dat","Expert.datc")
jsoncleaner("ExpertPlus.dat","ExpertPlus.datc")
jsoncleaner("NoArrowsEasy.dat","NoArrowsEasy.datc")
jsoncleaner("NoArrowsNormal.dat","NoArrowsNormal.datc")
jsoncleaner("NoArrowsHard.dat","NoArrowsHard.datc")
jsoncleaner("NoArrowsExpert.dat","NoArrowsExpert.datc")
jsoncleaner("NoArrowsExpertPlus.dat","NoArrowsExpertPlus.datc")
jsoncleaner("OneSaberEasy.dat","OneSaberEasy.datc")
jsoncleaner("OneSaberNormal.dat","OneSaberNormal.datc")
jsoncleaner("OneSaberHard.dat","OneSaberHard.datc")
jsoncleaner("OneSaberExpert.dat","OneSaberExpert.datc")
jsoncleaner("OneSaberExpertPlus.dat","OneSaberExpertPlus.datc")
levelcreator("info.jsonc","Easy.jsonc","level 1 Easy json.txt","level 1 Easy json.afx",1000)
levelcreator("info.jsonc","Normal.jsonc","level 1 Normal json.txt","level 1 Normal json.afx",1000)
levelcreator("info.jsonc","Hard.jsonc","level 1 Hard json.txt","level 1 Hard json.afx",1000)
levelcreator("info.jsonc","Expert.jsonc","level 1 Expert json.txt","level 1 Expert json.afx",1000)
levelcreator("info.jsonc","ExpertPlus.jsonc","level 1 ExpertPlus json.txt","level 1 ExpertPlus json.afx",1000)
levelcreator("info.jsonc","NoArrowsEasy.jsonc","level 1 NoArrowsEasy json.txt","level 1 NoArrowsEasy json.afx",1000)
levelcreator("info.jsonc","NoArrowsNormal.jsonc","level 1 NoArrowsNormal json.txt","level 1 NoArrowsNormal json.afx",1000)
levelcreator("info.jsonc","NoArrowsHard.jsonc","level 1 NoArrowsHard json.txt","level 1 NoArrowsHard json.afx",1000)
levelcreator("info.jsonc","NoArrowsExpert.jsonc","level 1 NoArrowsExpert json.txt","level 1 NoArrowsExpert json.afx",1000)
levelcreator("info.jsonc","NoArrowsExpertPlus.jsonc","level 1 NoArrowsExpertPlus json.txt","level 1 NoArrowsExpertPlus json.afx",1000)
levelcreator("info.jsonc","OneSaberEasy.jsonc","level 1 OneSaberEasy json.txt","level 1 OneSaberEasy json.afx",1000)
levelcreator("info.jsonc","OneSaberNormal.jsonc","level 1 OneSaberNormal json.txt","level 1 OneSaberNormal json.afx",1000)
levelcreator("info.jsonc","OneSaberHard.jsonc","level 1 OneSaberHard json.txt","level 1 OneSaberHard json.afx",1000)
levelcreator("info.jsonc","OneSaberExpert.jsonc","level 1 OneSaberExpert json.txt","level 1 OneSaberExpert json.afx",1000)
levelcreator("info.jsonc","OneSaberExpertPlus.jsonc","level 1 OneSaberExpertPlus json.txt","level 1 OneSaberExpertPlus json.afx",1000)
levelcreator("info.datc","Easy.datc","level 1 Easy dat.txt","level 1 Easy dat.afx",1000)
levelcreator("info.datc","Normal.datc","level 1 Normal dat.txt","level 1 Normal dat.afx",1000)
levelcreator("info.datc","Hard.datc","level 1 Hard dat.txt","level 1 Hard dat.afx",1000)
levelcreator("info.datc","Expert.datc","level 1 Expert dat.txt","level 1 Expert dat.afx",1000)
levelcreator("info.datc","ExpertPlus.datc","level 1 ExpertPlus dat.txt","level 1 ExpertPlus dat.afx",1000)
levelcreator("info.datc","NoArrowsEasy.datc","level 1 NoArrowsEasy dat.txt","level 1 NoArrowsEasy dat.afx",1000)
levelcreator("info.datc","NoArrowsNormal.datc","level 1 NoArrowsNormal dat.txt","level 1 NoArrowsNormal dat.afx",1000)
levelcreator("info.datc","NoArrowsHard.datc","level 1 NoArrowsHard dat.txt","level 1 NoArrowsHard dat.afx",1000)
levelcreator("info.datc","NoArrowsExpert.datc","level 1 NoArrowsExpert dat.txt","level 1 NoArrowsExpert dat.afx",1000)
levelcreator("info.datc","NoArrowsExpertPlus.datc","level 1 NoArrowsExpertPlus dat.txt","level 1 NoArrowsExpertPlus dat.afx",1000)
levelcreator("info.datc","OneSaberEasy.datc","level 1 OneSaberEasy dat.txt","level 1 OneSaberEasy dat.afx",1000)
levelcreator("info.datc","OneSaberNormal.datc","level 1 OneSaberNormal dat.txt","level 1 OneSaberNormal dat.afx",1000)
levelcreator("info.datc","OneSaberHard.datc","level 1 OneSaberHard dat.txt","level 1 OneSaberHard dat.afx",1000)
levelcreator("info.datc","OneSaberExpert.datc","level 1 OneSaberExpert dat.txt","level 1 OneSaberExpert dat.afx",1000)
levelcreator("info.datc","OneSaberExpertPlus.datc","level 1 OneSaberExpertPlus dat.txt","level 1 OneSaberExpertPlus dat.afx",1000)
DeleteFile("info.jsonc")
DeleteFile("info.datc")
End

; IDE Options = PureBasic 5.30 (Windows - x64)
; FirstLine = 31
; Folding = 9
; Executable = Bs2As2.exe