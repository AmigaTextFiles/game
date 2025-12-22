IMPLEMENTATION MODULE Util;

IMPORT Libraries;

FROM TermInOut IMPORT WriteString, WriteLn, WriteHex;
FROM SYSTEM IMPORT ADDRESS, ADR, BYTE;
FROM System IMPORT HALTX;


(**********************************)

PROCEDURE OpenLibrary( LibraryName : ARRAY OF CHAR ): Libraries.LibraryPtr;
VAR
  LibPtr : Libraries.LibraryPtr;
BEGIN
  LibPtr := Libraries.OpenLibrary( ADR(LibraryName), 0 );
  IF LibPtr = NIL THEN
    WriteString("Couldn't open library ");
    WriteString( LibraryName );
    WriteLn();
    HALTX;
  END;
  RETURN LibPtr;
END OpenLibrary;

(**********************************)

PROCEDURE WriteAddress( Addr : ADDRESS );
TYPE
  UnType = RECORD
             CASE Selector : BOOLEAN OF
             |  TRUE: Address : ADDRESS;
             | FALSE: Card    : ARRAY [0..1] OF CARDINAL; 
             END;
           END;
VAR
  x : UnType;
BEGIN
  x.Address := Addr;
  WriteHex( x.Card[0], 4 );
  WriteHex( x.Card[1], 4 );
END WriteAddress;

(************************************)

PROCEDURE WriteByte( Byte : BYTE; Width : CARDINAL );
BEGIN
  WriteHex( CARDINAL(Byte), Width );
  WriteString("H");
END WriteByte;

(************************************)

PROCEDURE WriteStringPtr( Ptr : ADDRESS );
VAR
  StringPtr : STRINGPTR;
BEGIN
  IF Ptr = NIL THEN
    WriteString("NIL");
  ELSE
    StringPtr := Ptr;
    WriteString( StringPtr^ );
  END;
END WriteStringPtr;

(************************************)

END Util.
