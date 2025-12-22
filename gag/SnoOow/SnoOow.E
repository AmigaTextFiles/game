PROC main()
	DEF	max,left,width,upper,height,bwidth,wind,
			teml,rdargs,win,x,t,sts,run,
			args=NIL:PTR TO LONG,
			sx[5000]:ARRAY OF LONG,
			sy[5000]:ARRAY OF LONG

	max:=100
	wind:=0
	left:=270
	width:=100
	upper:=50
	height:=100
	bwidth:=16
	run:=TRUE

	IF wbmessage=NIL
		teml:='FILE/M'
		rdargs:=ReadArgs(teml,{args},NIL)
		IF rdargs
			IF args
				x:=0
				WHILE args[x]
					UpperStr(args[x])
					IF StrCmp(args[x],'/?',ALL)
						WriteF('SnoOow! V1.1\n')
						WriteF('Usage: SnoOow <INFO> <MAX=n> <WIND=n> <LEFT=n> <UPPER=n> <WIDTH=n> <HEIGHT=n> <BWIDTH=n>\n\n')
						x++
						run:=FALSE
					ELSEIF StrCmp(args[x],'INFO',ALL)
						WriteF('+-------------------------------+\n')
						WriteF('|             SnoOow!           |\n')
						WriteF('>-------------------------------<\n')
						WriteF('| Written by Jesper Wilhelmsson |\n')
						WriteF('|                               |\n')
						WriteF('| This program is ublic Domain  |\n')
						WriteF('|   Do with it as you please!   |\n')
						WriteF('| Send comments to:             |\n')
						WriteF('|               jive@algonet.se |\n')
						WriteF('+-------------------------------+\n')
						x++
						run:=FALSE
					ELSEIF StrCmp(args[x],'MAX',ALL)
						x++
						IF args[x]
							max:=Val(args[x])
							IF max<1 THEN max:=1
							IF max>5000 THEN max:=5000
							x++
						ENDIF
					ELSEIF StrCmp(args[x],'WIND',ALL)
						x++
						IF args[x]
							wind:=Val(args[x])
							IF wind<-4 THEN wind:=-4
							IF wind>4 THEN wind:=4
							x++
						ENDIF
					ELSEIF StrCmp(args[x],'LEFT',ALL)
						x++
						IF args[x]
							left:=Val(args[x])
							x++
						ENDIF
					ELSEIF StrCmp(args[x],'UPPER',ALL)
						x++
						IF args[x]
							upper:=Val(args[x])
							x++
						ENDIF
					ELSEIF StrCmp(args[x],'WIDTH',ALL)
						x++
						IF args[x]
							width:=Val(args[x])
							x++
						ENDIF
					ELSEIF StrCmp(args[x],'HEIGHT',ALL)
						x++
						IF args[x]
							height:=Val(args[x])
							x++
						ENDIF
					ELSEIF StrCmp(args[x],'BWIDTH',ALL)
						x++
						IF args[x]
							bwidth:=Val(args[x])
							x++
						ENDIF
					ELSE
						x++
					ENDIF
				ENDWHILE
			ENDIF
			FreeArgs(rdargs)
		ENDIF
	ENDIF
	IF run
		win:=OpenW(left,upper,width,height,$240,$1002,'',NIL,1,NIL)
		prepScreen(width,height,bwidth)
		sts:=0

		FOR x:=0 TO max-1
			sx[x]:=Rnd(width-10)+5
			sy[x]:=Rnd(height-25)-height
		ENDFOR

		WHILE sts<height
			IF sts>0 THEN sts:=sts+1
			FOR x:=0 TO max-1
				IF sy[x]>bwidth THEN Plot(sx[x],sy[x],0)
				sy[x]:=sy[x]+1
				IF sy[x]>bwidth
					t:=Rnd(3+wind)-1
					IF ReadPixel(stdrast,sx[x]+t,sy[x])=0 THEN sx[x]:=sx[x]+t
					IF (ReadPixel(stdrast,sx[x],sy[x]+1)<>0) AND (ReadPixel(stdrast,sx[x],sy[x]+2)<>0)
						IF ReadPixel(stdrast,sx[x]+1,sy[x]+1)=0
							sx[x]:=sx[x]+1
						ELSEIF ReadPixel(stdrast,sx[x]-1,sy[x]+1)=0
							sx[x]:=sx[x]-1
						ELSE
							Plot(sx[x],sy[x],2)
							IF sts=0
								IF sy[x]=(bwidth+4)
									prepScreen(width,height,bwidth)
									FOR x:=0 TO max-1
										sx[x]:=Rnd(width-10)+5
										sy[x]:=Rnd(height-25)-height
									ENDFOR
								ELSE
									sy[x]:=bwidth
									sx[x]:=Rnd(width-10)+5
								ENDIF
							ELSE
								sy[x]:=-2*height
							ENDIF
						ENDIF
					ENDIF
				ENDIF
				IF sy[x]>bwidth THEN Plot(sx[x],sy[x],2)
			ENDFOR
			IF Mouse()=%011 THEN sts:=1
			WaitTOF()
		ENDWHILE
		CloseW(win)
	ENDIF
ENDPROC

PROC prepScreen(width,height,bwidth)
	DEF x,y,w,h

	w:=width/2-30
	h:=height/2+4

	Box(3,bwidth,width-3,height-3,0)
	Colour(3)
	TextF(w,h,'SnoOow!')
	FOR x:=w TO w+53
		FOR y:=h-9 TO h+1
/*			IF (ReadPixel(stdrast, x + 1, y) = 3) AND (ReadPixel(stdrast, x, y) = 0) THEN Plot(x, y, 1)
*/			IF (ReadPixel(stdrast, x - 1, y) = 3) AND (ReadPixel(stdrast, x, y) = 0) THEN Plot(x, y, 1)
/*			IF (ReadPixel(stdrast, x, y + 1) = 3) AND (ReadPixel(stdrast, x, y) = 0) THEN Plot(x, y, 1)
*/			IF (ReadPixel(stdrast, x, y - 1) = 3) AND (ReadPixel(stdrast, x, y) = 0) THEN Plot(x, y, 1)
		ENDFOR
	ENDFOR
ENDPROC

CHAR '$VER: SnoOow V1.1 (97.09.15)'
