IMPLEMENTATION MODULE GetDir;

FROM SYSTEM IMPORT
  ADR;
FROM DosD IMPORT
  FileInfoBlock, FileInfoBlockPtr, FileLockPtr, FileLock, accessRead;
FROM DosL IMPORT
  Examine, ExNext, Lock, UnLock; 
FROM String IMPORT
  Copy;
FROM W IMPORT
  WRITELN,s,lf;

VAR
  minlaas : FileLockPtr;  
  fib     : FileInfoBlock; (* !! Må ikke være lokalvariabel 32-bit-align!! *)

PROCEDURE ScanDir(path:ARRAY OF CHAR; dap:DirArrayPtr):INTEGER;
VAR
  n       : INTEGER;
BEGIN
  n:=-1;
  minlaas:=Lock(ADR(path),accessRead);
  IF minlaas<>NIL THEN
    n:=0;
    IF Examine(minlaas,ADR(fib)) THEN
      WRITELN(s('ScanDir of ')+s(path));
      REPEAT   
        INC(n);
        IF n<257 THEN
          dap^[n].Type:=fib.entryType;
          dap^[n].Size:=fib.size;
          Copy(dap^[n].Name,fib.fileName);
          IF fib.entryType=2 THEN
            WRITELN(s('Directory  ')+s(fib.fileName));
          ELSE
            WRITELN(lf(fib.size,9)+s('  ')+s(fib.fileName));
          END;
        END; 
      UNTIL NOT ExNext(minlaas,ADR(fib));
      UnLock(minlaas);
    END;
  END;
  RETURN(n);
END ScanDir;

BEGIN
END GetDir.
