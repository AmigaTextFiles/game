OPT MODULE
OPT EXPORT

MODULE	'gadtools','libraries/gadtools'
MODULE								'intuition/intuition','intuition/screens','intuition/gadgetclass',
											'intuition/screens','intuition/pointerclass',
											'intuition/classes', 'intuition/icclass','intuition/imageclass',
											'intuition/cghooks'
MODULE	'graphics/gfx','graphics/rastport'
MODULE	'utility/tagitem'

MODULE	'mod/macros'

PROC createslider(gad,x,y,w,h,id,min,max,level,vis,orient)
	gad:=CreateGadgetA(SLIDER_KIND,gad,
	[x,y,w,h,0,0,id,0,vis,0]:newgadget,
		[GTSL_MIN,min,GTSL_MAX,max,GTSL_LEVEL,level,
			PGA_FREEDOM,orient,
			NWAY_KIND,TRUE,GTVI_NWTAGS,TRUE,NIL,NIL])
ENDPROC gad,gad

PROC createscroller(gad,x,y,w,h,id,total,top,visible,vis,orient,arrows)
	gad:=CreateGadgetA(SCROLLER_KIND,gad,
	[x,y,w,h,0,0,id,0,vis,0]:newgadget,
		[GTSC_TOTAL,total,GTSC_TOP,top,GTSC_VISIBLE,visible,
			PGA_FREEDOM,orient,IF (arrows>0) THEN GTSC_ARROWS ELSE TAG_IGNORE,arrows,
			NWAY_KIND,TRUE,GTVI_NWTAGS,TRUE,NIL,NIL])
ENDPROC gad,gad

PROC createbool(gad,x,y,w,h,id,string,textattr,vis)
	gad:=CreateGadgetA(BUTTON_KIND,gad,
	[x,y,w,h,string,textattr,id,0,vis,0]:newgadget,[NIL,NIL])
ENDPROC gad,gad

PROC drawbevelbox(vis,rast:PTR TO rastport,x,y,w,h,ft=0,rec=0,pencol=-1)
	DEF olddm,oldafpt,oldafptsz
	DEF inw,inh
	IF rast=0 THEN RETURN
	olddm:=GetDrMd(rast)
	oldafpt:=rast.areaptrn
	oldafptsz:=rast.areaptsz
	IF ft=4 THEN ft:=0
	IF pencol>=0
		SELECT ft
		CASE 1;inw:=2;inh:=1
		CASE 2;inw:=4;inh:=2
		CASE 3;inw:=6;inh:=3
		DEFAULT;inw:=1;inh:=1
		ENDSELECT
		SetAPen(rast,pencol)
		IF (((w-inw-inw)>0) AND ((h-inh-inh)>0)) THEN RectFill(rast,x+inw,y+inh,x+w-1-inw,y+h-1-inh)
	ENDIF
	SetDrMd(rast,RP_JAM2)
	DrawBevelBoxA(rast,x,y,w,h,[GT_VISUALINFO,vis,
			GTBB_FRAMETYPE,ft,
			IF (rec<>0) THEN GTBB_RECESSED ELSE TAG_IGNORE,rec,TAG_END])
	SetDrMd(rast,olddm)
	setafpt(rast,oldafpt,oldafptsz)
ENDPROC

PROC bottomedge(win:PTR TO window) IS (win.height-win.borderbottom)
PROC rightedge(win:PTR TO window) IS (win.width-win.borderright)
PROC insidewidth(win:PTR TO window) IS (win.width-win.borderleft-win.borderright)
PROC insideheight(win:PTR TO window) IS (win.height-win.bordertop-win.borderbottom)

PROC disablegadget(x,win);IF ((x) AND (win)) THEN Gt_SetGadgetAttrsA(x,win,NIL,[GA_DISABLED,TRUE,NIL,NIL]);ENDPROC
PROC enablegadget(x,win);IF ((x) AND (win)) THEN Gt_SetGadgetAttrsA(x,win,NIL,[GA_DISABLED,FALSE,NIL,NIL]);ENDPROC

PROC extractmessage(mes:PTR TO intuimessage);RETURN mes.class,mes.iaddress,mes.code;ENDPROC
PROC windowtotals(w:PTR TO window) IS w.borderright+w.borderleft,w.borderbottom+w.bordertop

PROC newimageobject(which,dri,scr) IS
  NewObjectA(NIL,'sysiclass',
    [SYSIA_DRAWINFO,dri,SYSIA_WHICH,which,SYSIA_SIZE,sysisize(scr),NIL])

PROC newpropobject(freedom,taglist,dri:PTR TO drawinfo) IS
  NewObjectA(NIL,'propgclass',
    [ICA_TARGET,ICTARGET_IDCMP,PGA_FREEDOM,freedom,PGA_NEWLOOK,TRUE,
     PGA_BORDERLESS,(dri.flags AND DRIF_NEWLOOK) AND (dri.depth<>1),
     TAG_MORE,taglist])

PROC newbuttonobject(image:PTR TO object,taglist) IS
  NewObjectA(NIL,'buttongclass',
    [ICA_TARGET,ICTARGET_IDCMP,GA_IMAGE,image,TAG_MORE,taglist])

PROC sysisize(scr:PTR TO screen) IS
 IF scr.flags AND SCREENHIRES THEN SYSISIZE_MEDRES ELSE SYSISIZE_LOWRES

PROC updateprop(win,gadget:PTR TO object,attr,value) IS SetGadgetAttrsA(gadget,win,NIL,[attr,value,NIL])
