/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'You are standing in front of the central heating system with the cannister in your left hand...what now?'
  pull answer
   Select
    When answer = Throw Cannister then cmd = 'sock2.rexx'
    When answer = Throw then cmd = 'sock2.rexx'
    When answer = Cannister then cmd = 'sock2.rexx'
    When answer = throw cannister into central heating system then cmd = 'sock2.rexx'
    When answer = put cannister in central heating system then cmd = 'sock2.rexx'
    When answer = throw cannister in central heating system then cmd = 'sock2.rexx'
    When answer = throw cannister central heating system then cmd = 'sock2.rexx'
    When answer = Throw the Cannister into the central heating system  then cmd = 'sock2.rexx'
    When answer = Throw Cannister into heating system then cmd = 'sock2.rexx'
    When answer = Throw the cannister into the heating system then cmd = 'sock2.rexx'
    When answer = Throw Cannister Central heating system then cmd = 'sock2.rexx'
    When answer = Throw cannister into the heating system then cmd = 'sock2.rexx'
    When answer = Use Cannister then cmd = 'sock2.rexx'
    When answer = Use Cannister on Heating system then cmd = 'sock2.rexx'
    When answer = Use cannister on Central heating System then cmd = 'sock2.rexx'
    When answer = Put cannister in heating system then cmd = 'sock2.rexx'
    When answer = put cannister in central heating system then cmd = 'sock2.rexx'
    When answer = Put can in central heating system then cmd = 'sock2.rexx'
    When answer = put cannister in central heating system then cmd = 'sock2.rexx'
    When answer = Use the Cannister with the central heating system  then cmd = 'sock2.rexx'
    When answer = Use can with system then cmd = 'sock2.rexx'
    When answer = Use cannister with heating system then cmd = 'sock2.rexx'
    When answer = Use cannister on heating system then cmd = 'sock2.rexx'
    When answer = Use can then cmd = 'sock2.rexx'
    When answer = Throw the Can then cmd = 'sock2.rexx'
    When answer = Shit then cmd = 'savini.rexx'
   Otherwise cmd = 'heating.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

  

