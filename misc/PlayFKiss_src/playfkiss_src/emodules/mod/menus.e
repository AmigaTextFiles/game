OPT MODULE

MODULE	'intuition/intuition'

EXPORT PROC packmenunumber(menu=MENUNULL,item=NOITEM,sub=NOSUB)
	DEF work
	IF menu=-1 THEN menu:=MENUNULL
	IF item=-1 THEN item:=NOITEM
	IF sub=-1 THEN sub:=NOSUB
	menu:=menu AND %11111
  item:=item AND %111111
  sub:=sub AND %11111
	work:=Shl(sub,8)
	work:=Shl(work,3)
	work:=(work OR (Shl(item,5)))
	work:=(work OR menu)
ENDPROC work

EXPORT PROC unpackmenunumber(code)
	DEF menu,item,sub,c
	c:=code
	menu:=c AND %11111
	c:=Shr(c,5)
	item:=c AND %111111
	c:=Shr(c,6)
	sub:=c AND %11111
ENDPROC menu,item,sub

EXPORT PROC findmenuid(menu:PTR TO menu,id)							-> This routine takes ALOT of time.  :P
	DEF menuitem:PTR TO menuitem,subitem:PTR TO menuitem
	DEF t=-1,i=-1,si=-1
	DEF long:PTR TO LONG
	WHILE menu>0
		t:=t+1
		menuitem:=menu.firstitem
		WHILE menuitem>0
			i:=i+1
			subitem:=menuitem.subitem
			long:=menuitem+34
			IF (long[0]=id) THEN RETURN t,i,NOSUB
			WHILE subitem>0
				si:=si+1
				long:=subitem+34
				IF (long[0]=id) THEN RETURN t,i,si
				subitem:=subitem.nextitem			
			ENDWHILE
			menuitem:=menuitem.nextitem
			si:=-1
		ENDWHILE
		i:=-1
		menu:=menu.nextmenu
	ENDWHILE
ENDPROC -1,-1,-1

EXPORT PROC findmenuitem(menu:PTR TO menu,title,item=NOITEM,subitem=NOSUB)
	DEF menuitem:PTR TO menuitem
	DEF localscratch
	IF title>0
		FOR localscratch:=1 TO title
			menu:=menu.nextmenu
		ENDFOR
	ENDIF
	menuitem:=menu
	IF item<>NOITEM
		menuitem:=menu.firstitem
		FOR localscratch:=1 TO item
			menuitem:=menuitem.nextitem
		ENDFOR
		IF (subitem<>NOSUB)
			menuitem:=menuitem.subitem
			IF subitem>0
				FOR localscratch:=1 TO subitem
					menuitem:=menuitem.nextitem
				ENDFOR
			ENDIF
		ENDIF
	ENDIF
ENDPROC menuitem

EXPORT PROC ischecked(menu,id)
	DEF m,i,s
	DEF item:PTR TO menuitem
	m,i,s:=findmenuid(menu,id)
	item:=findmenuitem(menu,m,i,s)
	RETURN (item.flags AND CHECKED)
ENDPROC
	
EXPORT PROC check(menu,item,f=TRUE)
	DEF mi:PTR TO menuitem,t,i,si
	t,i,si:=findmenuid(menu,item)  ->  Finds t,s,si using our USERID!
	mi:=findmenuitem(menu,t,i,si)  ->  Finds a menuitem struct using t,s,si!  Redundant...
	IF mi>50
		IF f=0
			mi.flags:=(mi.flags AND Not(CHECKED))
		ELSE
			mi.flags:=(mi.flags OR CHECKED)
		ENDIF	
	ENDIF
ENDPROC
