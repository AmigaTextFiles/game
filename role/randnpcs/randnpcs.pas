Program Random_Characters(Input, Output);

uses crt;

Const
   Version = 1.00;

var
   Index : integer;
   Char_File : text;
   Num_Chars : integer;

Procedure Roll_Stats;

var
   ST : integer;
   IQ : integer;
   DX : integer;
   HT : integer;

begin
   ST := random(5) + random(5) + random(5) + 3;
   IQ := random(5) + random(5) + random(5) + 3;
   DX := random(5) + random(5) + random(5) + 3;
   HT := random(5) + random(5) + random(5) + 3;
   Writeln(char_file, 'ST:',st,' IQ:',iq,' DX:',dx,' HT:',ht,' ');
end;

Procedure Get_Advantage;

var
   Advantage : integer;
   rolls : integer;
   Pass : integer;
   Advantage_array : array[1..100] of integer;
   Found : Boolean;
   Index : integer;

begin
   For Index := 1 to 100 do
      Advantage_Array[Index] := 0;
   rolls := 1;
   Write(Char_file, 'Adavntage(s): ');
   Pass := 0;
   repeat
      Pass := Pass + 1;
      If (Pass > 1) and ((Pass mod 3) <> 0) then Write(Char_File, ', ');
      Repeat
         Advantage := Random(5) + Random(5) + Random(5) +3;
         Found := False;
         For Index := 1 to 100 do
            If advantage = Advantage_array[index] then
               found := true;
      until not(found);
      Case Advantage of
         3,17,18 : Begin
                      Rolls := 3;
                      Pass := Pass - 1;
                   end;
         4 : Write(Char_File, 'Voice');
         5 : Write(Char_File, 'Charisma(+6)');
         6 : Write(Char_file, 'Alertness(+4)');
         7 : Write(Char_File, 'Common Sense');
         8 : Write(Char_File, 'Magical Aptitude(+2)');
         9 : Write(Char_file, 'Acute Vision(+5)');
         10 : Write(Char_File, 'Alertness(+2)');
         11 : Write(Char_File, 'Charisma(+3)');
         12 : Write(Char_File, 'Acute Taste/Smell(+5)');
         13 : Write(Char_file, 'Danger Sense');
         14 : Write(Char_file, 'Attractive Appearance');
         15 : Write(Char_File, 'Acute Hearing(+5)');
         16 : Write(Char_File, 'Handsome/Beautiful');
      end;
      if ((pass mod 3) = 0) and (pass <> 0) then
      begin
         writeln(char_file);
         write(char_file, '              ');
      end;
      Rolls := Rolls - 1;
   until rolls = 0;
   writeln(Char_file);
end;

Procedure Get_Disadvantage;

var
   Disadvantage : integer;
   rolls : integer;
   Pass : integer;
   Disadvantage_array : array[1..100] of integer;
   Found : Boolean;
   Index : integer;

begin
   For Index := 1 to 100 do
      Disadvantage_Array[Index] := 0;
   rolls := 1;
   Write(Char_file, 'Disadavntage(s): ');
   Pass := 0;
   repeat
      Pass := Pass + 1;
      If (Pass > 1) and ((Pass mod 3) <> 0) then Write(Char_File, ', ');
      Repeat
         Disadvantage := Random(5) + Random(5) + Random(5) +3;
         Found := False;
         For Index := 1 to 100 do
            If disadvantage = disadvantage_array[index] then
               found := true;
      until not(found);
      Case disadvantage of
         3,17,18 : Begin
                      Rolls := 3;
                      Pass := Pass - 1;
                   end;
         4 : Write(Char_File, 'Poor');
         5 : Write(Char_File, 'Cowardly');
         6 : Write(Char_File, 'Overweight');
         7 : Write(Char_file, 'Odious Personal Habit (-2)');
         8 : Write(Char_File, 'Bad Temper');
         9 : Write(Char_file, 'Unlucky');
         10 : Write(Char_File, 'Greedy');
         11 : Write(Char_File, 'Overconfident');
         12 : Write(Char_File, 'Honest');
         13 : Write(Char_file, 'Hard of Hearing');
         14 : Write(Char_file, 'Unattractive Appearance');
         15 : Write(Char_File, 'Bad Sight');
         16 : Write(Char_File, 'Hideous Appearance');
      end;
      if ((pass mod 3) = 0) and (pass <> 0) then
      begin
         writeln(char_file);
         write(char_file, '              ');
      end;
      Rolls := Rolls - 1;
   until rolls = 0;
   writeln(Char_file);
end;

Procedure Get_Description;

var
   Skin : integer;
   Hair : integer;
   Eyes : integer;
   sex : string[6];
   before : boolean;
   rolls: integer;
   other : integer;

begin
   Writeln(Char_file, 'Character Description: ');
   Write(Char_file, '   Sex: ');
   if Random(10) > 5 then
      sex := 'Female'
   else sex := 'Male';
   write(char_file, sex, ', ');
   skin := random(5) + random(5) + random(5) +3;
   Write(Char_File, 'Skin Color: ');
   case skin of
      3 : Write(Char_File, 'Blue-Black');
      4..6 : Write(Char_File, 'Black');
      7 : Write(Char_file, 'White with Freckles');
      8 : Write(Char_File, 'White, tanned');
      9..10 : Write(Char_File, 'White');
      11..12 : Write(Char_File, 'Brown');
      13..15 : Write(Char_File, 'Light Golden(Oriental)');
      16 : Write(Char_File, 'Golden');
      17..18 : Write(Char_File, 'Red-Bronze');
   end;
   hair := random(5) + random(5) + random(5) + 3;
   Write(Char_file, ', Hair Color: ');
   case hair of
      3 : Write(Char_File, 'Blue-Black');
      4..5 : Write(Char_File, 'Black');
      6 : Write(Char_File, 'Blond');
      7 : Begin
             if sex = 'male  ' then
                Write(Char_File, 'Bald')
             else
                 Write(Char_File, 'Blond');
          end;
      8 : Write(Char_file, 'Red-Brown');
      9 : Write(Char_file, 'Light Brown');
      10..11 : Write(Char_File, 'Brown');
      12..13 : Write(Char_File, 'Dark Brown');
      14 : Write(Char_file, 'Grey');
      15 : Write(Char_file, 'Strawberry Blond');
      16 : Write(Char_file, 'Bright Red/Orange');
      17 : Write(Char_file, 'Golden Blond');
      18 : Write(char_file, 'Pure White');
   end;
   Writeln(Char_file);
   Write(Char_File, '   Eye Color: ');
   Before := False;
   Rolls := 1;
   other := 0;
   repeat
   repeat
      eyes := random(5) + random(5) + random(5) + 3;
   until eyes <> other;
   case eyes of
      3 : Write(char_file, 'Purple');
      4 : Write(Char_file, 'Black');
      5 : Write(Char_file, 'Ice-Blue');
      6 : Write(Char_file, 'Gray');
      7..8 : Write(Char_File, 'Blue');
      9..11 : Write(Char_File, 'Brown');
      12 : Write(Char_file, 'Hazel');
      13 : Write(Char_file, 'Green');
      14 : Write(Char_File, 'Dark Blue');
      15..16 :Write(Char_file, 'Dark Green');
      17 : Write(Char_file, 'Golden');
      18 : Begin
              if Before then
                 Rolls := Rolls + 1
              else
              begin
                 Write(char_File, '(Split) ');
                 Rolls := 3;
                 Before := True;
              end;
           end;
   end;
   rolls := rolls - 1;
   other := eyes;
   if before and (rolls = 1) then
      write(Char_file, ', ');
   until rolls = 0;
   writeln(Char_file);
end;

Procedure Get_Skills;

var
   num_skills : integer;
   skills_array : array[1..3, 3..18] of boolean;
   index : integer;
   index2 : integer;
   chart : integer;
   skill : integer;
   before : boolean;

begin
   Writeln(Char_File, 'Skills:');
   write(char_file, '   ');
   num_skills := random(5) + random(5) + 2;
   for Index := 1 to 3 do
      for Index2 := 3 to 18 do
         skills_array[Index, Index2] := false;
   for Index := 1 to Num_Skills do
   begin
      chart := random(2) + 1;
      case chart of
         1 : Begin
                before := false;
                repeat
                   skill := random(5) + random(5) + random(5) + 3;
                   If skills_array[chart,skill] = true then
                      before := true
                   else
                      before := false;
                until not(before);
                skills_array[chart, skill] := true;
                case skill of
                   3 : Write(char_file, 'Caligraphy');
                   4 : Write(char_file, 'Botany');
                   5 : Write(char_file, 'Diplomacy');
                   6 : Write(char_file, 'Singing');
                   7 : Write(char_file, 'Animal Handling');
                   8 : Write(char_file, 'Stealth');
                   9 : Write(char_file, 'Hand Weapons(simple)');
                   10 : Write(char_file, 'Hand Weapons(complex)');
                   11 : Write(char_file, 'Running');
                   12 : Write(char_file, 'Missile Weapon(any)');
                   13 : Write(char_file, 'Carousing');
                   14 : Write(char_file, 'Gambling');
                   15 : Write(char_file, 'Musical Instrument(any)');
                   16 : Write(char_file, 'Forgery');
                   17 : Write(char_file, 'Judo or Karate');
                   18 : Write(char_file, 'History');
                end;
              end;
          2 : Begin
                before := false;
                repeat
                   skill := random(5) + random(5) + random(5) + 3;
                   If skills_array[chart,skill] = true then
                      before := true
                   else
                      before := false;
                until not(before);
                skills_array[chart, skill] := true;
                case skill of
                   3 : Write(char_file, 'Armoury');
                   4 : Write(char_file, 'Merchant');
                   5 : Write(char_file, 'Physician');
                   6 : Write(char_file, 'Language(any)');
                   7 : Write(char_file, 'Bard');
                   8 : Write(char_file, 'Scrounging');
                   9 : Write(char_file, 'Fast-Draw(any)');
                   10 : Write(char_file, 'Traps');
                   11 : Write(char_file, 'Brawling');
                   12 : Write(char_file, 'Pilot or Gunner(any)');
                   13 : Write(char_file, 'Law');
                   14 : Write(char_file, 'Streetwise');
                   15 : Write(char_file, 'Survival');
                   16 : Write(char_file, 'Disguise');
                   17 : Write(char_file, 'Naturalist');
                   18 : Write(char_file, 'Navigation');
                end;
              end;
          3 : Begin
                before := false;
                repeat
                   skill := random(5) + random(5) + random(5) + 3;
                   If skills_array[chart,skill] = true then
                      before := true
                   else
                      before := false;
                until not(before);
                skills_array[chart, skill] := true;
                case skill of
                   3 : Write(char_file, 'Biochemistry');
                   4 : Write(char_file, 'Sleight of Hand');
                   5 : Write(char_file, 'Sports(any)');
                   6 : Write(char_file, 'Veterinary');
                   7 : Write(char_file, 'Acting');
                   8 : Write(char_file, 'First Aid');
                   9 : Write(char_file, 'Climbing');
                   10 : Write(char_file, 'Shield');
                   11 : Write(char_file, 'Driving or Riding(any)');
                   12 : Write(char_file, 'Swimming');
                   13 : Write(char_file, 'Savoir-Faire');
                   14 : Write(char_file, 'Politics');
                   15 : Write(char_file, 'Lockpicking');
                   16 : Write(char_file, 'Mechanic');
                   17 : Write(char_file, 'Sex Appeal');
                   18 : Write(char_file, 'Poisons');
                end;
              end;
      end;
      if (Index <> Num_skills) then
         write(char_file, ', ');
      if ((Index mod 3) = 0) and (Index <> Num_Skills) then
      begin
         writeln(char_file);
         write(char_file, '   ');
      end;
   end;
   writeln(char_file);
end;

begin
   Assign(Char_file, 'Npc.fil');
   Rewrite(Char_file);
   clrscr;
   Writeln('GURPS Cyberpunk Random Character Generator');
   Writeln('Written By: Kevin Reynolds');
   Writeln('Version: ',Version:4:2);
   Writeln;
   Writeln(Char_file, 'GURPS Cyberpunk Random Character Generator');
   Writeln(Char_file, 'Written By: Kevin Reynolds');
   Writeln(Char_file, 'Version: ',Version:4:2);
   Writeln(Char_file);
   Write('How many NPC''s to roll out: ');
   readln(Num_Chars);
   Writeln('Generating ', Num_Chars, ' NPC''s. ');
   Writeln(Char_file, 'Generating ', Num_Chars, ' NPC''s. ');
   Writeln(Char_file);
   randomize;
   For Index := 1 to Num_Chars do
   begin
      write(Char_file, 'Char ',Index,': ');
      Roll_Stats;
      Get_Advantage;
      Get_Disadvantage;
      Get_Skills;
      Get_Description;
      Writeln(Char_File);
   end;
   Close(Char_File);
   Writeln('Done.');
end.
