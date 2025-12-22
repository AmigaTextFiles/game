/*
** BloodnetCheat 1.0
** This is just a quick hack to get it working.
** Read the doc for more info about the offsets.
**
** 96-11-03 Peter Karlsson (Peter.Karlsson@swipnet.se)
*/

MODULE 'dos/dos','tools/file'

ENUM ER_NONE, ER_IO, ER_LEN
CONST LENGTH=29410
RAISE ER_IO IF ReadArgs() = NIL

PROC main() HANDLE

   DEF rdargs = NIL,myargs=NIL:PTR TO LONG,mem=NIL,len=NIL,filename[255]:STRING,
       loop=NIL,offset=NIL:PTR TO LONG

   offset:=[$034b,$034c,$034d,$6e8e,$6e8f,$6e90,
            $0358,$0359,$035a,$035b,$035c,$6eb5,
            $6ecd,$6e9d,$6eab,$6e9f,$0370,$0371,
            $0373,$6eb0,$6ea7,$6e9a,$036a,$036b,
            $036c,$036d,$036e,$036f,$6e99,$6eb3,
            $6ecc,$6ea4,$6eca,$6ecb,$035d,$035e,
            $035f,$0360,$0361,$0362,$6ea0,$6e8f,
            $6ea5,$6ea9,$6e9e,$6eaa,$0363,$0364,
            $0365,$0366,$0367,$0368,$0369,$6ea6,
            $6ea3,$6eac,$6eaf,$6eb1,$6eb4,$6eb2,
            $034f,$0350,$0351,$6e96,$6e97,$6e98]

   rdargs := ReadArgs( 'FILE/A', myargs, NIL )
   StrCopy(filename,myargs[0],ALL)
   PrintF('Scanning \s ...\n',filename)
   mem,len:=readfile(filename)
   IF len <> LENGTH THEN Raise(ER_LEN)
   PutStr('Patching...\n')
   FOR loop:=0 TO 65
      PutChar((mem+offset[loop]),255)
   ENDFOR
   writefile(filename,mem,len)
   PutStr('Done!\n')
   Raise( ER_NONE )

EXCEPT

   IF mem THEN freefile(mem)
   IF rdargs THEN FreeArgs( rdargs )

   SELECT exception
      CASE ER_IO
         _ShowError()
      CASE ER_LEN
         PrintF('\q\s\q is not a Bloodnet savefile!\nAborted...\n',filename)
      CASE "NEW"
         _ShowError()
      CASE "OPEN"
         _ShowError()
      CASE "IN"
         _ShowError()
      CASE "OUT"
         _ShowError()
      DEFAULT
         NOP
   ENDSELECT

ENDPROC

PROC _ShowError() IS PrintFault( IoErr(), 'Error' )

CHAR 0,'$VER: BloodnetCheat 1.0 (3.11.96) Peter Karlsson (Peter.Karlsson@swipnet.se)',0
