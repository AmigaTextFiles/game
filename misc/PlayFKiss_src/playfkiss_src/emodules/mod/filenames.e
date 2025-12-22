OPT MODULE

EXPORT PROC splitname(str1,str2,str3)
  DEF filestart,pathlen,stt[5]:STRING
	filestart:=FilePart(str1)
	pathlen:=filestart-str1
	IF pathlen
		StrCopy(str2,str1,pathlen)
		MidStr(stt,str2,StrLen(str2)-1,1)
		IF StrCmp(stt,'/',ALL)
			MidStr(str2,str2,0,StrLen(str2)-1)
		ENDIF		
		StrCopy(str3,filestart,ALL)
	ELSE
		StrCopy(str2,'',ALL)
		StrCopy(str3,str1,ALL)
	ENDIF
ENDPROC

EXPORT PROC eaddpart(estring,string,maxbuf)
	AddPart(estring,string,maxbuf)
	SetStr(estring,StrLen(estring))
ENDPROC

EXPORT PROC stripinfo(name)
	DEF comp1[6]:STRING,comp2[6]:STRING
	StrCopy(comp1,'.INFO',ALL)
	MidStr(comp2,name,StrLen(name)-5,5)
	UpperStr(comp2)
	IF StrCmp(comp1,comp2,5)
		MidStr(name,name,0,(StrLen(name)-5))
	ENDIF
ENDPROC

