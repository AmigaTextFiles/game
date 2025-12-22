MODULE ReqSupp2Test;

FROM SYSTEM IMPORT
  ADR;
FROM W IMPORT
  WRITELN, s, READs;
FROM ReqSupp2 IMPORT
  GetFirstDirFile, GetNextDirFile;

VAR
  filename,path,dirname:ARRAY[0..80] OF CHAR;

BEGIN
  filename:='*.info';
  IF GetFirstDirFile(ADR('Titel'),filename,path,dirname) THEN
    REPEAT
      WRITELN(s(path));
    UNTIL ~GetNextDirFile(filename,path,dirname);
  END;
  READs(filename);
END ReqSupp2Test.
