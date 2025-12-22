OPT MODULE

MODULE	'utility','utility/tagitem'

EXPORT PROC findtag(taglist,findtag,default=0)
	DEF tag:PTR TO tagitem
	IF (tag:=FindTagItem(findtag,taglist)) THEN default:=tag.data
ENDPROC default
