/*
   $VER: SETLEVEL 1.0
     set a level you want to play.

   Written by Nils Goers.
*/

options results

PARSE ARG Level

IF Level == "" THEN DO
  options Prompt "Level: "
 parse pull Level
END

IF Level == "" THEN EXIT(5)


ADDRESS ASOKOBAN.1

GETLEVEL
OldLevel = result

IF Level == OldLevel THEN EXIT(0)

SETLEVEL Level
