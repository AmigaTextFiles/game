OPT MODULE

MODULE 'rexxsyslib','rexx/rexxio','rexx/rxslib','rexx/errors','rexx/storage'
MODULE 'exec/ports','exec/nodes'

EXPORT ENUM RXTYPE_ERROR=0,RXTYPE_NOMSG,RXTYPE_MSG,RXTYPE_REPLY
EXPORT OBJECT rexx_handle
	rexxmsg:PTR TO rexxmsg
	rexxargs:PTR TO CHAR
	command:PTR TO CHAR
	cmdline:PTR TO CHAR
	result1:LONG
	result2:LONG
	replyport:PTR TO mp
ENDOBJECT
EXPORT DEF unconfirmed

EXPORT PROC handleRexxMsg(hostport)
	DEF rexxmsg:PTR TO rexxmsg
	DEF msgnode:PTR TO mn
	DEF listnode:PTR TO ln
	DEF rexxargs:PTR TO LONG
	DEF command:PTR TO CHAR
	DEF handle:PTR TO rexx_handle
	DEF result1,result2

	rexxmsg:=GetMsg(hostport)
	IF (rexxmsg)
		msgnode:=rexxmsg.mn
		listnode:=msgnode.ln
		rexxargs:=rexxmsg.args
		IF (listnode.type=NT_REPLYMSG)
			IF (rexxargs[15]) THEN ReplyMsg(rexxargs[15])
			IF (rexxargs[0]) THEN DeleteArgstring(rexxargs[0])
			result1:=rexxmsg.result1
			result2:=rexxmsg.result2
			DeleteRexxMsg(rexxmsg)
			DEC unconfirmed
			RETURN result1,RXTYPE_REPLY,result2
		ELSE
			NEW handle
->			handle.command:=String(150)
->			handle.cmdline:=String(2000)
			handle.rexxargs:=rexxargs[0]
			handle.result1:=0
			handle.result2:=0
			handle.rexxmsg:=rexxmsg
			handle.replyport:=hostport
->			StrCopy(handle.command,TrimStr(rexxargs[0]))
			RETURN handle,RXTYPE_MSG
		ENDIF
	ELSE
		RETURN 0,RXTYPE_NOMSG
	ENDIF
ENDPROC 0,RXTYPE_ERROR

EXPORT PROC forwardRexxMsg(handle:PTR TO rexx_handle)
	DEF rexxargs:PTR TO LONG
	rexxargs:=handle.rexxmsg.args
	IF sendRexxMsg('REXX',rexxargs[0],handle.rexxmsg,0,handle.replyport)=NIL
		xReplyRexxCmd(handle.rexxmsg,RC_FATAL,NIL)
		ReplyMsg(handle.rexxmsg)
	ENDIF
	END handle
ENDPROC

EXPORT PROC replyRexxMsg(handle:PTR TO rexx_handle,res1=0,res2=0)
	xReplyRexxCmd(handle.rexxmsg,res1,res2)
	ReplyMsg(handle.rexxmsg)
	END handle
ENDPROC

PROC xReplyRexxCmd(rexxmsg:PTR TO rexxmsg,returncode,returnstring)
	rexxmsg.result1:=returncode
	rexxmsg.result2:=IF ((rexxmsg.action AND RXFF_RESULT) AND (returnstring<>NIL) AND (returncode=0)) THEN CreateArgstring(returnstring,StrLen(returnstring)) ELSE NIL
ENDPROC

EXPORT PROC sendRexxMsg(hostname,command,unknownmsg,flags,replyport:PTR TO mp,addressname=0,extname=0)
	DEF arexxport=NIL:PTR TO mp
	DEF rexxmsg=NIL:PTR TO rexxmsg
	DEF rexxargs:PTR TO LONG
	DEF listnode=NIL:PTR TO ln
	DEF temp=NIL
	IF replyport=NIL THEN RETURN NIL
	listnode:=replyport.ln
	IF (rexxmsg:=CreateRexxMsg(replyport,'rexx',listnode.name))=NIL THEN RETURN NIL
	rexxargs:=rexxmsg.args
	IF addressname THEN rexxmsg.commaddr:=addressname
	IF extname THEN rexxmsg.fileext:=extname
	IF temp:=CreateArgstring(command,StrLen(command))
		rexxargs[0]:=temp
		rexxmsg.action:=RXCOMM OR flags
		rexxargs[15]:=unknownmsg
		Forbid()
		IF (arexxport:=FindPort(hostname)) THEN PutMsg(arexxport,rexxmsg)
		Permit()
		IF arexxport
			INC unconfirmed
			RETURN rexxmsg
		ENDIF
	ENDIF
	IF temp THEN DeleteArgstring(temp)
	IF rexxmsg THEN DeleteRexxMsg(rexxmsg)
ENDPROC 0
