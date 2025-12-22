IMPLEMENTATION MODULE mdgenerallib;

(*      This is a general library of procedures that I like and use in    *)
(* in various ways.  Nothing special about the grouping other than that   *)
(* they are things that I personally think are useful.                    *)
(*         - MD                                                           *)


FROM AmigaDOS
  IMPORT   DateStampRecord, DateStamp;
FROM AmigaDOSProcess
  IMPORT Delay;
FROM InitMathLib0
  IMPORT OpenMathLib0, CloseMathLib0;
FROM MathLib0
  IMPORT exp, ln, real;
FROM TermInOut IMPORT WriteString, WriteLn;

VAR
  seed : REAL;		(* Seed for random number generator *)

(*********************************************************)

PROCEDURE MyPause (time : CARDINAL);
        (* Pauses for number of seconds input *)

BEGIN
   Delay (time * 50);
END MyPause;

(********************************************************)

PROCEDURE RealRandom () : REAL;
        (* Returns a random number in the range [0, 1). *)

VAR
  temp : REAL;

BEGIN
  IF NOT OpenMathLib0() THEN
     WriteString("Couldn't open math libraries!"); WriteLn;
     RETURN (0.5);
     END;
  temp := exp(5.0 * ln(seed + 3.14159)); 
  seed := temp - real(LONGINT(TRUNC(temp)));
  CloseMathLib0();
  RETURN seed;
END RealRandom;

(********************************************************)

VAR
  d : DateStampRecord;

BEGIN
        (******************************)
        (* Init the Random Generator  *)
        (******************************)
  DateStamp(d);
  seed := (real(d.dsMinute) + real(d.dsTick)) / 4440.0 ;
END mdgenerallib.
