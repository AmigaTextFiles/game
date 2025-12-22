OPT MODULE

MODULE 'dos/dos'

EXPORT PROC createPath(name:PTR TO CHAR)
    DEF nd[256]:STRING,tl
    StrCopy(nd,name)
    PutChar(PathPart(nd),0)
    SetStr(nd,StrLen(nd))
    IF nd[StrLen(nd)-1]=":" THEN RETURN
    IF StrLen(nd)
        createPath(nd)
        tl:=Lock(nd,ACCESS_READ)
        IF tl=0 THEN IF (tl:=CreateDir(nd))=0 THEN Raise("MDIR")
        IF tl THEN UnLock(tl)
    ENDIF
ENDPROC


