OPT PREPROCESS

MODULE 'dos/dos'
MODULE '*kiss_files'

#define PROGRAMNAME 'celinfo'
#define PROGRAMVERSION '1.0'
#define PROGRAMDATE '13.09.98'

#define ibmconv(var) (Shl((var AND $00FF),8) OR Shr((var AND $FF00),8))

ENUM ERR_NONE,ERR_BADARGS,ERR_OPENFILE,ERR_READFILE

PROC main() HANDLE
  DEF rdargs=NIL,args[1]:LIST,files:PTR TO LONG,fh=NIL,buffer,i=0
  DEF kissheader:PTR TO kiss_celfileheader,rawheader:PTR TO kiss_rawcelfileheader
  IF (rdargs:=ReadArgs('FILES/M/A',args,NIL))=NIL THEN Raise(ERR_BADARGS)
  files:=args[0]
  kissheader:=FastNew(SIZEOF kiss_celfileheader)
  rawheader:=FastNew(SIZEOF kiss_rawcelfileheader)
  WHILE files[i]
    IF (fh:=Open(files[i],MODE_OLDFILE))=NIL THEN Throw(ERR_OPENFILE,files[i])
    -> check for KiSS file id
    Read(fh,buffer,4)
    IF ^buffer=KISS_ID
      Seek(fh,0,OFFSET_BEGINNING)
      IF Read(fh,kissheader,SIZEOF kiss_celfileheader)<SIZEOF kiss_celfileheader THEN Throw(ERR_READFILE,files[i])
      PrintF('Name: \s\n'+
             'Width:           \r\d[4]\n'+
             'Height:          \r\d[4]\n'+
             'X offset:        \r\d[4]\n'+
             'Y offset:        \r\d[4]\n'+
             'Bytes per pixel: \r\d[4]\n',files[i],ibmconv(kissheader.width),ibmconv(kissheader.height),ibmconv(kissheader.xoffset),ibmconv(kissheader.yoffset),kissheader.bitsperpixel)
    ELSE
      Seek(fh,0,OFFSET_BEGINNING)
      IF Read(fh,rawheader,SIZEOF kiss_rawcelfileheader)<SIZEOF kiss_rawcelfileheader THEN Throw(ERR_READFILE,files[i])
      PrintF('Name: \s\n'+
             'Width:           \r\d[4]\n'+
             'Height:          \r\d[4]\n',files[i],ibmconv(rawheader.width),ibmconv(rawheader.height))
    ENDIF
    Close(fh) ; fh:=NIL
    INC i
    IF files[i] THEN PrintF('\n')
  ENDWHILE
  Raise(ERR_NONE)
EXCEPT
  IF rdargs THEN FreeArgs(rdargs)
  IF fh THEN Close(fh)
  IF exception=NIL THEN RETURN
  PrintF('Error \d\n',exception)
ENDPROC

programversion:
CHAR '$VER: ',PROGRAMNAME,32,PROGRAMVERSION,32,'(',PROGRAMDATE,')',0
