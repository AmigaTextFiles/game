OPT MODULE

MODULE	'libraries/iffparse','iffparse'

EXPORT PROC savevaluechunk(handle,form,chunk,longvalue)
	DEF buffer
	buffer:=New(4)
	IF (buffer)
		PushChunk(handle,form,chunk,4)
			PutLong(buffer,longvalue)
			WriteChunkBytes(handle,buffer,4)
		PopChunk(handle)
		Dispose(buffer)
	ENDIF
ENDPROC

EXPORT PROC getvaluechunk(handle,form,chunk,longvalue)
	DEF sp=NIL:PTR TO storedproperty
	IF (sp:=FindProp(handle,form,chunk))
		longvalue:=Long(sp.data)
	ENDIF
ENDPROC longvalue

EXPORT PROC getprefstring(handle,form,chunkid,str)
	DEF sp=NIL:PTR TO storedproperty
	IF (sp:=FindProp(handle,form,chunkid))
		IF Long(sp.data)
			StrCopy(str,sp.data+4,Long(sp.data))
		ENDIF
	ENDIF
ENDPROC

EXPORT PROC writeprefstring(handle,form,chunkid,str)
	DEF buffer,n
	buffer:=New(10)
	PushChunk(handle,form,chunkid,IFFSIZE_UNKNOWN)
	n:=StrLen(str)
	PutLong(buffer,n)
	WriteChunkBytes(handle,buffer,4)
	IF n THEN WriteChunkBytes(handle,str,n)
	PopChunk(handle)
ENDPROC
