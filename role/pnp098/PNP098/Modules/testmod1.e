MODULE 'dos/dos'

PROC main()
DEF fh=NIL, buf[255]:STRING, myargs:PTR TO LONG,rdargs
    
DEF insclicked:LONG, dataptr:LONG,closed:LONG

myargs:=[0,0,0,0,0,0]
IF rdargs:=ReadArgs('SCREEN/A, WINDOW/A, A/A, B/A, C/A, D/A',myargs,NIL)
    /* scr:=myargs[0] */


    StringF(buf,'\s',myargs[3])
    insclicked:=Val(buf,NIL)
    StringF(buf,'\s',myargs[4])
    dataptr:=Val(buf,NIL)
    StringF(buf,'\s',myargs[5])
    closed:=Val(buf,NIL)
    FreeArgs(rdargs)

    StringF(^dataptr,'\s','Hallo2!')
    ^insclicked:=1


        StringF(buf,'\d:\s\n',dataptr,^dataptr)
    fh:=Open('ram:tst',NEWFILE)
        Write(fh,buf,StrLen(buf))
        StringF(buf,'\d\n',^insclicked)
        Write(fh,buf,StrLen(buf))
    Close(fh)

    ^closed:=1
  ELSE
    WriteF('Bad Args!\n')
  ENDIF
ENDPROC
