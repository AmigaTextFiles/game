MODULE GetDirTest;

FROM SYSTEM IMPORT
  ADR;
FROM GetDir IMPORT
  DirArray,ScanDir;
FROM W IMPORT
  WRITE,WRITELN,s,lf;

VAR
  m:INTEGER;
  dirarr:DirArray;
  n,fc:INTEGER;
BEGIN
  fc:=ScanDir('ram:',ADR(dirarr));
  FOR n:=1 TO fc DO
    WRITE(lf(dirarr[n].Type,16));
    IF dirarr[n].Type<0 THEN
      WRITE(lf(dirarr[n].Size,16));
    ELSE
      WRITE(s('        <dir>   '));
    END; 
    WRITELN(s('  "')+s(dirarr[n].Name)+s('"'));
  END;
  WRITELN(lf(n,4)+s(' entrys'));
END GetDirTest.
