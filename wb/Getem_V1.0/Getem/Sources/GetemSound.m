Module GetemSound;

{ © By M. Illenseer                                                          }
{ Überarbeitete Version 0.2 , 3.9.1991                                       }
{ Erstellt mit Kickpascal V2.0 , thanx to the Himpire !                      }
{ Spezielles Module für Getem ab V0.8                                        }
{ Compilieren und als GetemSound.o abspeichern, nicht vom Linker irritieren  }
{ lassen !                                                                   }
{ Ermöglicht Abspielung eines 8SVX-Sound-Files (Standard IFF Sound )         }

Uses ExecSupport, ExecIO;
{ Benötigt natuerlich auch Exec ! }

{$incl 'devices/audio.h' }
{Braucht erst recht das AudioDevice... }

{Const Debug = 'Yes';} { Klammern löschen, wenn Debug erwuenscht }

{ Folgende Funktionen und Proceduren sind hier deklariert:

Function  PlaySInit(Filename:string):Boolean;
                    { Initialisiert den Sound, True wenn Device ok }
Procedure Piep;     { Macht unserern schoenen 'Piep', ein 8SVX-File }
Procedure EndPlay;  { Schliesst das Device wieder }

}

Const
  CLOCK = 3579545; { Gut was !? }

Type
  FileS = File of Byte; { Oder von mir aus auch File of Word ! }

  VHDRType = RECORD     { IFF Chunk }
               OneShotHiSamples: Long;
               RepeatHiSamples: Long;
               SamplesPerHiCycle: Long;
               SamplesPerSecond: Word;
               Oktaven: Byte;
               PackFlag: Byte;
               Volume: Long
             END;

  SamplePtr = ^SampleType;
  SampleType = RECORD
                 VHDR: VHDRType;
                 Len: LongInt;
                 Data: ARRAY[0..MaxLongInt] OF Short
               END;


Var F1                  : FileS;
    Filename            : STRING;
    MySample            : SamplePtr;
    allocIOB, lockIOB   : ^IOAudio;
    port                : ^MsgPort;
    mydevice            : p_Device;
    err                 : Long;


Function LoadSample(VAR f: FileS): SamplePtr;
  Type StrType = String[5];
  Var sp: SamplePtr;
      lw, err: LongInt;
      s1: StrType;
      HeadFlag, BodyFlag: Boolean;
      VHDR: VHDRType;

  Function ReadStr4: StrType;  { Kommt auf das File an, manche Files haben Long-Words}
    Var s: Array[1..5] OF Byte;
        s2: String[5];
    Begin
      Read(f, s[1], s[2], s[3], s[4] );
      s[5] := 0;
      s2 := Str(^s);
      ReadStr4 := S2;
    End;

  Function ReadLong: LongInt;
    Var b1, b2, b3, b4: Byte;
    Begin
      Read(f, b1, b2, b3, b4 );
      ReadLong := Long( Long(b1 shl 8 + b2) shl 8 + b3) shl 8 + b4
    End;

  Procedure Overread(Anz: LongInt);
    Var b: Byte;
    Begin
      While Anz>0 DO
        Begin
          Read(f, b);
          Dec(Anz)
        End
    End;

  Procedure ReadTo(Point: Ptr; Anz: Long );
    Var p2: ^Array[1..MaxLongInt] Of Byte;
        i: LongInt;
    Begin
      p2 := Point;
      For i:=1 to Anz Do Read(f, p2^[i]);
      { Blockread(f, p2^, Anz); }
    End;


  Begin    { LoadSample }
    s1 := ReadStr4;
    If s1 <> 'FORM' Then
      Begin
{$if def debug}
        Writeln('Kein IFF-Format!');  { So ein Pech :-) }
{$endif}
        LoadSample := Nil;
        Exit
      End;
    lw := ReadLong;
    s1 := ReadStr4;
    IF s1 <> '8SVX' THEN       { Magic-Number eines IFF-SoundFiles }
      Begin
{$if def Debug}
        Writeln('Kein 8SVX-File!');
{$endif}
        LoadSample := Nil;
        Exit
      End;

    sp := Nil;
    HeadFlag := false;
    BodyFlag := false;

    While not (HeadFlag and BodyFlag) Do
      Begin
        s1 := ReadStr4;
        lw := ReadLong;
        IF s1='VHDR' THEN
          Begin
            ReadTo(^VHDR, SizeOf(VHDRType));
            Overread(lw-SizeOf(VHDRType));
            HeadFlag := true
          End
        Else
        If s1='BODY' Then
          Begin
            If not HeadFlag Then
              Begin
{$if def debug}
                Writeln('Fehler in Dateiformat!');
{$endif}
                LoadSample := Nil;
                Exit
              End;
            sp := Ptr (Alloc_Mem (lw+4+SizeOf(VHDRType), 2));
            sp^.Len := lw+4+SizeOf(VHDRType);
            sp^.VHDR := VHDR;
            BlockRead(f, sp^.Data, lw);
            BodyFlag := true
          End
        Else
          OverRead(lw);

      End;

    LoadSample := sp
  End;



Procedure InitAudio;
  { Device öffnen, Ports einrichten, Kanäle reservieren usw. }
  Var alloctable : Array[1..4] Of Byte;
  Begin
    port := CreatePort ('Getem Sound Port', 0);
    If port=Nil Then Halt(0);

    allocIOB := CreateExtIO (port, SizeOf (IOAudio));
    If allocIOB=Nil Then Halt(0);

    lockIOB := CreateExtIO (port, SizeOf (IOAudio));
    If lockIOB=Nil Then Halt(0);

    Open_Device(AUDIONAME, 0, AllocIOB, 0);

    mydevice := allocIOB^.ioa_Request.io_Device;
    lockIOB^.ioa_Request.io_Device := mydevice;

    AllocTable[1] := %0001;
    AllocTable[2] := %0010;
    AllocTable[3] := %0100;
    AllocTable[4] := %1000;

    With allocIOB^, ioa_Request, io_Message Do
      Begin
        io_Flags := ADIOF_NOWAIT;
        ioa_Data := ^AllocTable;
        ioa_Length := 4;
        io_Command := ADCMD_ALLOCATE;
        BeginIO(allocIOB);
      End;
    err := WaitIO(allocIOB);
    If err <> 0 Then
      Error('Allocation failed');

    With lockIOB^, ioa_Request Do
      Begin
        io_Unit := allocIOB^.ioa_Request.io_Unit;
        io_Command := ADCMD_LOCK;
        ioa_AllocKey := allocIOB^.ioa_AllocKey;
      End;
    SendIO(lockIOB);
    If CheckIO(lockIOB) <> 0 Then
      Error('Channel stolen.');
  End;



Procedure PlaySample(s: SamplePtr);
  Var Laenge,Rate: Long;
  Begin
    With s^.VHDR Do
      Begin
        Laenge := OneShotHiSamples+RepeatHiSamples;
        Rate := (CLOCK div SamplesPerSecond) div 2;
      End;

    With lockIOB^, ioa_Request Do
      Begin
        io_Command := CMD_WRITE;
        io_Flags := ADIOF_PERVOL;
        ioa_Data := ^s^.Data;
        ioa_Length := Laenge;
        ioa_Volume := 64;
        ioa_Period := Rate;
        ioa_Cycles := 1;
      End;
    BeginIO(lockIOB);
{$if def debug}
    If not fromWB Then writeln('Playing...');
{$endif}
    err :=WaitIO(lockIOB)
 End;

Function PlaySinit(Filename: String):Boolean; Export;
Label  No_Play;

Begin

  Reset (F1, Filename);
  If IOResult <> 0 Then begin
    PlaySinit:=False;
    Goto No_Play;
  end;

  Buffer (F1, 5000);
  MySample := LoadSample (F1);
  Close (F1);
  If MySample=Nil then PlaySinit:=False
  Else  PlaySinit:=True;
  InitAudio;
No_Play:
End;

Procedure EndPlay; Export;
Begin
{$if def debug}
 Writeln('Schliesse Audio-Device');
{$endif}
 Close_Device(allocIOB);
End;

Procedure Piep; Export;
Begin
 If MySample <> Nil Then
      PlaySample(MySample);
End;

Begin
 { Tja, hier ist mir nichts eingefallen ... }
 { Aber hier braucht auch nix zu stehen :-)  }
End.

{ Also ehrlich! Das Zeugs ist mächtig kompliziert... }
{ Wenn jemand noch KickPascal 1.0 haben sollte, das ist das Modul hier }
{ in das Hauptfile 'Getem.p' zu INCLUDE-n , da KP 1.0 noch keinen Linker hat..}




