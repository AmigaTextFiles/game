OPT MODULE

MODULE	'exec/nodes','exec/lists'

EXPORT PROC isfirst(node:PTR TO ln)
	IF node.pred
		IF node.pred.pred=0 THEN RETURN TRUE
	ENDIF
ENDPROC FALSE

EXPORT PROC islast(node:PTR TO ln)
	IF node.succ
		IF node.succ.succ=0 THEN RETURN TRUE
	ENDIF
ENDPROC FALSE
EXPORT PROC ishead(node:PTR TO ln) IS IF (node.pred=0) THEN TRUE ELSE FALSE
EXPORT PROC istail(node:PTR TO ln) IS IF (node.succ=0) THEN TRUE ELSE FALSE
EXPORT PROC isempty(list:PTR TO lh) IS IF (list.head.succ=0) THEN TRUE ELSE FALSE

EXPORT PROC sortlist(list:PTR TO lh)	-> MUST HAVE AT LEAST 2 NODES
	DEF n1:PTR TO ln
	DEF n2:PTR TO ln
	DEF sorted,order
	IF (list)
		IF (isempty(list)=0)
			IF ((islast(list.head))=0)
				REPEAT
					sorted:=FALSE
					n1:=list.head
					n2:=n1.succ
					REPEAT
						order:=OstrCmp(n1.name,n2.name)
						IF (order=-1)
							Remove(n1)
							Insert(list,n1,n2)
							sorted:=TRUE
						ENDIF
						n1:=n2
						n2:=n2.succ
					UNTIL (n2.succ=0)
				UNTIL (sorted=FALSE)
			ENDIF
		ENDIF
	ENDIF
ENDPROC

EXPORT PROC countnodes(lh:PTR TO lh)
	DEF next,node:PTR TO ln
	DEF n=0
	node:=lh.head
	WHILE (node)
		next:=node.succ
		IF (next) THEN n:=n+1
		node:=next
	ENDWHILE
ENDPROC n

EXPORT PROC getnode(lh:PTR TO lh,num)
	DEF node:PTR TO ln
	DEF i
	node:=lh.head
	IF (num>0)
		FOR i:=1 TO num
			IF (node) THEN node:=node.succ
		ENDFOR
	ENDIF
	IF (node) THEN IF (istail(node)) THEN node:=0
ENDPROC node
