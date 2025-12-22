OPT MODULE

MODULE	'exec/memory'

EXPORT PROC createpool(type=MEMF_CLEAR,puddlesize=4096,threshold=2048)
	DEF poolhandle
	poolhandle:=CreatePool(type,puddlesize,threshold)
ENDPROC poolhandle

EXPORT PROC alloc(handle,size)
	DEF mem
	size:=size+4
	mem:=AllocPooled(handle,size)
	IF (mem)
		MOVE.L	mem,A0
		MOVE.L	size,(A0)
		mem:=mem+4
	ENDIF
ENDPROC mem

EXPORT PROC free(handle,mem)
	DEF size
	IF (handle)
		IF (mem)
			mem:=mem-4
			MOVE.L	mem,A0
			MOVE.L	(A0),D0
			MOVE.L	D0,size
			FreePooled(handle,mem,size)
		ENDIF
	ENDIF
ENDPROC

EXPORT PROC deletepool(poolhandle)
	IF poolhandle
		DeletePool(poolhandle)
	ENDIF
ENDPROC
