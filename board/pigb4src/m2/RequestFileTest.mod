MODULE RequestFileTest; (* test af FileRequester biblioteksmodul *)

FROM RequestFile IMPORT
  FileRequest;
FROM W IMPORT
  WRITELN,s;

VAR
  pth:ARRAY[0..255] OF CHAR;  
  fnv,ptt:ARRAY[0..25] OF CHAR;  
  OK:BOOLEAN;
BEGIN
  pth:='';
  fnv:='';
  ptt:='~*.(info,bak)';
  REPEAT
    OK:=FileRequest(pth,fnv,ptt,' Vælg Fil ',' Hent ',' Ups! ',
                    ' Sti','Navn','Udvalgt',NIL);
    IF OK THEN
      WRITELN(s('pth=')+s(pth)+s(' fnv=')+s(fnv));
    END;
  UNTIL NOT OK;
END RequestFileTest.
