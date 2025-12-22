OPT MODULE
MODULE	'exec/ports','exec/nodes'
MODULE	'intuition/intuition'
MODULE	'exec/lists','exec/nodes','exec/ports','exec/memory'

EXPORT PROC createPort(portname,priority)
  DEF port=NIL:PTR TO mp
  DEF node=NIL:PTR TO ln
  IF portname
    Forbid()
    IF FindPort(portname)=0
      IF port:=CreateMsgPort()
        node:=port.ln
        node.name:=portname
        node.pri:=priority
        AddPort(port)
      ENDIF
    ENDIF
    Permit()
  ELSE
    port:=CreateMsgPort()
  ENDIF
ENDPROC port,port.sigbit

EXPORT PROC deletePort(port:PTR TO mp)
  DEF node=NIL:PTR TO ln
  DEF msg=NIL:PTR TO mn
  IF port
    node:=port.ln
    IF node.name THEN RemPort(port)
    Forbid()
    WHILE msg:=GetMsg(port) DO ReplyMsg(msg)
    DeleteMsgPort(port)
    Permit()
  ENDIF
ENDPROC

EXPORT PROC stripintuimessages(mp:PTR TO mp,win:PTR TO window)
	DEF msg:PTR TO intuimessage
	DEF succ:PTR TO ln
	DEF list:PTR TO lh

->     |-intuimessage |-message |-node(ln)       |-msgport |-node
->     |              |                          |
->     |                                         | ->list(lh)->head

	list:=mp.msglist
	msg:=list.head
	IF (msg<>0)
		WHILE ((succ:=msg::ln.succ)<>0)
			IF msg.idcmpwindow=win
				Remove(msg)
				ReplyMsg(msg)
			ENDIF
			msg:=succ
		ENDWHILE
	ENDIF
ENDPROC

EXPORT PROC closewindowsafely(win:PTR TO window)
	Forbid()
	stripintuimessages(win.userport,win)
	win.userport:=NIL
	ModifyIDCMP(win,NIL)
	Permit()
	CloseWindow(win)
ENDPROC
