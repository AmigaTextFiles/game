IMPLEMENTATION MODULE ReqSupp2;

FROM SYSTEM IMPORT
  ADR;
FROM DosD IMPORT
  FileInfoBlock, FileLockPtr, FileLock, accessRead;
FROM DosL IMPORT
  Examine, ExNext, Lock, UnLock;
FROM String IMPORT
  Copy, Length, Concat, ConcatChar;
FROM ReqSupport IMPORT
  SimpleFileRequester;
FROM StrSupport IMPORT
  Valid,UpString;

VAR
  Auto    : BOOLEAN;
  minlaas : FileLockPtr;
  fib     : FileInfoBlock;
  GFDFT   : TitlePtr;
  Wname   : ARRAY[0..32] OF CHAR;

PROCEDURE GetNextDirFile(VAR name,path,dir:ARRAY OF CHAR):BOOLEAN;
VAR
  n        : INTEGER;
  Got,OK,EX: BOOLEAN;
  ch       : CHAR;
  Uname    : ARRAY[0..32] OF CHAR;
BEGIN
  IF Auto OR SimpleFileRequester(GFDFT^,name,path,dir) THEN
    n:=0;
    WHILE (name[n]<>0C) & (name[n]<>'*') & (name[n]<>'?') DO
      INC(n);
    END;
    IF ~Auto & (name[n]=0C) THEN
      RETURN(TRUE);
    ELSE
      IF ~Auto THEN
        minlaas:=Lock(ADR(dir),accessRead);
        IF minlaas<>NIL THEN
          Copy(Wname,name);
          UpString(Wname);
          Auto:=TRUE;
          EX:=Examine(minlaas,ADR(fib)) 
        ELSE
          RETURN(FALSE);
        END;
      ELSE
        EX:=ExNext(minlaas,ADR(fib)) 
      END;
      OK:=FALSE;
      IF EX THEN
        REPEAT
          IF (fib.entryType<>2) THEN
            Copy(Uname,fib.fileName);
            UpString(Uname);
            IF Valid(Wname,Uname) THEN
              Copy(name,fib.fileName);
              Copy(path,dir);
              IF path[0]<>0C THEN
                ch:=path[Length(path)-1];
                IF (ch<>':') & (ch<>'/') THEN
                  ConcatChar(path,'/');
                END;
              END;
              Concat(path,name);
              OK:=TRUE;
            END;
          END;
        UNTIL OK OR ~ExNext(minlaas,ADR(fib));
      END;
      IF ~OK THEN UnLock(minlaas) END;
      RETURN(OK);
    END;
  ELSE
    RETURN(FALSE);
  END;
END GetNextDirFile;

PROCEDURE GetFirstDirFile(title:TitlePtr; VAR name,path,dir:ARRAY OF CHAR):BOOLEAN;
BEGIN
  Auto:=FALSE;
  GFDFT:=title;
  RETURN(GetNextDirFile(name,path,dir));
END GetFirstDirFile;

END ReqSupp2.
