IMPLEMENTATION MODULE VersionLog;

(*$ DEFINE Test:=TRUE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

FROM Heap IMPORT
  Allocate;
FROM String IMPORT
  Concat,Length,Copy;

(*$ IF Test *)
FROM W IMPORT
   WRITE,WRITELN,CONCAT,c,s,l,lf,READs;
(*$ ENDIF *)

CONST
  VersionLogModCompilation="10";

VAR
  n:CARDINAL;

PROCEDURE LogVersion(Name:ARRAY OF CHAR; Version:ARRAY OF CHAR);
BEGIN
END LogVersion;
  
BEGIN
END VersionLog.
