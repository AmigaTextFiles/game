OPT MODULE

MODULE	'intuition/intuition','intuition/imageclass','intuition/screens'
MODULE	'gadtools','libraries/gadtools'
MODULE	'graphics/text'
MODULE	'utility/tagitem'
MODULE	'exec/ports'
MODULE	'graphics/rastport'

MODULE	'mod/fonts'
MODULE	'mod/gadgets'
MODULE	'mod/compare'
MODULE	'mod/macros'

EXPORT PROC logowindow(windowtitle,text,logo:PTR TO image,buttontext,textfont:PTR TO textfont,textstyle,textattr,screen:PTR TO screen,drawinfo:PTR TO drawinfo,rast,visual)
	DEF str[2500]:STRING
	DEF strs[75]:LIST
	DEF i,t
	DEF fontw=0,fonth=0,dumw,dumh,totalh=0
	DEF win:PTR TO window
	DEF okgad=0:PTR TO gadget
	DEF tmp,gad
	DEF okw,okh
	DEF windoww,windowh
	DEF picked,code,iadd,class,qual
	DEF mes:PTR TO intuimessage

	StrCopy(str,text,ALL)

	t:=0
	strs[0]:=str
	FOR i:=1 TO StrLen(text)
		IF (Char(str+i)=10)
			t:=t+1
			strs[t]:=str+i+1
			PutChar(str+i,0)
		ENDIF
	ENDFOR
	FOR i:=0 TO t
		dumw,dumh:=fontsize2(rast,strs[i],textfont,textstyle)
		fontw:=bigger(fontw,dumw)
		fonth:=bigger(fonth,dumh)
	ENDFOR
	fontw:=fontw+16
	okw,okh:=fontsize2(rast,buttontext,textfont,textstyle)
	totalh:=fonth*(t+1)+8
	windoww:=bigger(logo.width,fontw+16)+26
	windowh:=logo.height+totalh+okh+28

	IF (gad:=CreateContext({tmp}))
		okgad,gad:=createbool(gad,screen.wborleft+(windoww/2)-(okw/2)-24,logo.height+totalh+18+screen.wbortop+screen.font.ysize,okw+48,okh+8,6453,buttontext,textattr,visual)
		win:=OpenWindowTagList(0,
			 [WA_CUSTOMSCREEN,screen,
				WA_LEFT,screen.mousex-(windoww/2)-(okw/2),
				WA_TOP,screen.mousey-(windowh)-(okh/2),
				WA_INNERWIDTH,windoww,
				WA_INNERHEIGHT,windowh,
				WA_AUTOADJUST,TRUE,
				WA_CUSTOMSCREEN,screen,
				WA_DEPTHGADGET,TRUE,
				WA_ACTIVATE,TRUE,
				WA_DRAGBAR,TRUE,
				WA_SMARTREFRESH,TRUE,
				WA_IDCMP,BUTTONIDCMP,
				WA_GADGETS,okgad,
				WA_TITLE,windowtitle,
				TAG_END])
		IF (win)
			SetAPen(win.rport,drawinfo.pens[SHINEPEN])
			SetBPen(win.rport,drawinfo.pens[BACKGROUNDPEN])
			setafpt(win.rport,[%1010101010101010,%0101010101010101]:INT,1)
			SetDrMd(win.rport,RP_JAM2)
			RectFill(win.rport,win.borderleft,win.bordertop,rightedge(win)-1,bottomedge(win)-1)
			setafpt(win.rport,0,0)

			drawbevelbox(visual,win.rport,win.borderleft+(windoww/2)-(logo.width/2)-2,win.bordertop+4,logo.width+4,logo.height+2,1,TRUE,0)
			drawbevelbox(visual,win.rport,win.borderleft+(windoww/2)-(fontw/2)-7,win.bordertop+logo.height+10,fontw+12,totalh+4,1,TRUE,0)
			DrawImageState(win.rport,logo,win.borderleft+(windoww/2)-(logo.width/2),win.bordertop+5,IDS_NORMAL,drawinfo)
			dumh:=win.bordertop+logo.height+15
			RefreshGList(okgad,win,0,-1)
			FOR i:=0 TO t
				SetFont(win.rport,textfont)
				SetAPen(win.rport,drawinfo.pens[TEXTPEN])
				Move(win.rport,win.borderleft+(windoww/2)-(fontsize2(rast,strs[i],textfont,textstyle)/2),dumh+textfont.baseline)
				Text(win.rport,strs[i],StrLen(strs[i]))
				dumh:=dumh+fonth
			ENDFOR
			dumw:=0
			REPEAT
				IF mes:=Gt_GetIMsg(win.userport)
					class,iadd,code:=extractmessage(mes)
					qual:=mes.qualifier
					IF (class=IDCMP_GADGETUP)
						picked:=code
					ENDIF
					IF class=IDCMP_REFRESHWINDOW
						Gt_BeginRefresh(win)
						Gt_EndRefresh(win,TRUE)
					ENDIF
					Gt_ReplyIMsg(mes)
				ELSE
					Wait(Shl(1,win.userport::mp.sigbit))
				ENDIF
		  UNTIL (picked)
			CloseWindow(win)
			FreeGadgets(tmp)
		ENDIF
	ENDIF
ENDPROC
