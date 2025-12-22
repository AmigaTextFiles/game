/* ElectriBones - v2.7 */

MODULE 'intuition/intuition','dos/dos','other/stderr','other/stayrandom'

ENUM ER_NONE,ER_WINDOW

CONST MAXGADGETS=GADGETSIZE*19,NX=28,NY=15,DX=84,DY=80

DEF wptr:PTR TO window,next,buf[MAXGADGETS]:ARRAY,cdie,cnum,ret

PROC main()
        DEF version,class,object:PTR TO gadget,gad
        version:='$VER: ElectriBones v2.7 (9.18.94)'
        err_New('EB')
        stayrandom()
        IF arg[]<>0 THEN cliOutput()
        initGadgets()

        wptr:=OpenW(160,35,158,151,
            IDCMP_CLOSEWINDOW OR IDCMP_GADGETUP,
            WFLG_CLOSEGADGET OR WFLG_DEPTHGADGET OR
            WFLG_DRAGBAR OR WFLG_SMART_REFRESH OR WFLG_ACTIVATE,
            'ElectriBones',NIL,1,buf)

        IF wptr=NIL THEN easyExit(ER_WINDOW)

        cnum:=3
        cdie:=6
        ret:=0
        drawLines()
        highlight(cnum,cdie)

        REPEAT
                class:=WaitIMessage(wptr)
                IF class=IDCMP_GADGETUP
                        object:=MsgIaddr()
                        gad:=object.userdata
                        IF gad<15 THEN cnum:=gad
                        IF (gad>15) AND (gad<>999) THEN cdie:=(gad/10)
                        IF gad=999
                                ret:=doRandom(cnum,cdie)
                                convert(ret)
                        ENDIF
                        highlight(cnum,cdie)
                ENDIF
        UNTIL class=IDCMP_CLOSEWINDOW
        easyExit(ER_NONE)
ENDPROC

/* Functions */

PROC highlight(num,die)
        DEF x,y,xx,yy,val,ref[7]:ARRAY OF LONG
        ref:=[2,4,6,8,10,12,20,100]
        SetBPen(wptr.rport,0)
        FOR y:=0 TO 4
                FOR x:=0 TO 1
                        SetAPen(wptr.rport,1)
                        val:=(x+1+(y*2))
                        IF num=val THEN SetAPen(wptr.rport,2)
                        xx:=NX+(x*24)+8
                        yy:=NY+(y*12)+8
                        IF val=10 THEN xx:=xx-4
                        TextF(xx,yy,'\d',val)
                ENDFOR
        ENDFOR
        FOR y:=0 TO 3
                FOR x:=0 TO 1
                        SetAPen(wptr.rport,1)
                        val:=(x+1+(y*2))-1
                        IF die=ref[val] THEN SetAPen(wptr.rport,2)
                        xx:=DX+(x*24)+8
                        yy:=NY+(y*12)+8
                        IF ref[val]>9 THEN xx:=xx-4
                        IF ref[val]=100
                                TextF(xx+4,yy,'%')
                        ELSE
                                TextF(xx,yy,'\d',ref[val])
                        ENDIF
                ENDFOR
        ENDFOR
ENDPROC

PROC convert(num)
        DEF huns,tens,ones,leds[9]:ARRAY OF LONG
        lightLeds(0,0)
        lightLeds(0,1)
        lightLeds(0,2)
        leds:=[%1110111,%0100100,%1011101,%1101101,%0101110,%1101011,
        %1111011,%0100101,%1111111,%1101111]
        huns:=num/100
        tens:=(num-(huns*100))/10
        ones:=num-(huns*100)-(tens*10)
        IF num=1000
                ones:=0
                tens:=0
                huns:=0
        ENDIF
        IF num<100
                lightLeds(0,0)
        ELSE
                lightLeds(leds[huns],0)
        ENDIF
        IF num<10
                lightLeds(0,1)
        ELSE
                lightLeds(leds[tens],1)
        ENDIF
        lightLeds(leds[ones],2)
ENDPROC

PROC doRandom(num,die)
        DEF loop,tempVar,total
        total:=0
        FOR loop:=1 TO num STEP 1
                tempVar:=Rnd(die)+1
                total:=total+tempVar
        ENDFOR
ENDPROC total

PROC initGadgets()
        next:=Gadget(buf,NIL,1,0,NX,NY,24,'')
        next:=Gadget(next,buf,2,0,NX+24,NY,24,'')
        next:=Gadget(next,buf,3,0,NX,NY+12,24,'')
        next:=Gadget(next,buf,4,0,NX+24,NY+12,24,'')
        next:=Gadget(next,buf,5,0,NX,NY+24,24,'')
        next:=Gadget(next,buf,6,0,NX+24,NY+24,24,'')
        next:=Gadget(next,buf,7,0,NX,NY+36,24,'')
        next:=Gadget(next,buf,8,0,NX+24,NY+36,24,'')
        next:=Gadget(next,buf,9,0,NX,NY+48,24,'')
        next:=Gadget(next,buf,10,0,NX+24,NY+48,24,'')

        next:=Gadget(next,buf,20,0,DX,NY,24,'')
        next:=Gadget(next,buf,40,0,DX+24,NY,24,'')
        next:=Gadget(next,buf,60,0,DX,NY+12,24,'')
        next:=Gadget(next,buf,80,0,DX+24,NY+12,24,'')
        next:=Gadget(next,buf,100,0,DX,NY+24,24,'')
        next:=Gadget(next,buf,120,0,DX+24,NY+24,24,'')
        next:=Gadget(next,buf,200,0,DX,NY+36,24,'')
        next:=Gadget(next,buf,1000,0,DX+24,NY+36,24,'')
        next:=Gadget(next,buf,999,0,DX,NY+48,48,'Roll')
ENDPROC

PROC lightLeds(leds,led)
        DEF xx,colr
        xx:=17+(43*led)
        colr:=3
        IF (leds AND %1)=%1 THEN colr:=2
        Line(xx+02,DY+00,xx+37,DY+00,colr)
        Line(xx+04,DY+01,xx+35,DY+01,colr)
        Line(xx+06,DY+02,xx+33,DY+02,colr)
        Line(xx+07,DY+03,xx+32,DY+03,colr)
        colr:=3
        IF (leds AND %10)=%10 THEN colr:=2
        Line(xx+00,DY+01,xx+00,DY+21,colr)
        Line(xx+01,DY+01,xx+01,DY+21,colr)
        Line(xx+02,DY+02,xx+02,DY+20,colr)
        Line(xx+03,DY+02,xx+03,DY+20,colr)
        Line(xx+04,DY+03,xx+04,DY+19,colr)
        Line(xx+05,DY+03,xx+05,DY+19,colr)
        colr:=3
        IF (leds AND %100)=%100 THEN colr:=2
        Line(xx+39,DY+01,xx+39,DY+21,colr)
        Line(xx+38,DY+01,xx+38,DY+21,colr)
        Line(xx+37,DY+02,xx+37,DY+20,colr)
        Line(xx+36,DY+02,xx+36,DY+20,colr)
        Line(xx+35,DY+03,xx+35,DY+19,colr)
        Line(xx+34,DY+03,xx+34,DY+19,colr)
        colr:=3
        IF (leds AND %1000)=%1000 THEN colr:=2
        Line(xx+06,DY+20,xx+33,DY+20,colr)
        Line(xx+04,DY+21,xx+35,DY+21,colr)
        Line(xx+02,DY+22,xx+37,DY+22,colr)
        Line(xx+02,DY+23,xx+37,DY+23,colr)
        Line(xx+04,DY+24,xx+35,DY+24,colr)
        Line(xx+06,DY+25,xx+33,DY+25,colr)
        colr:=3
        IF (leds AND %10000)=%10000 THEN colr:=2
        Line(xx+00,DY+24,xx+00,DY+44,colr)
        Line(xx+01,DY+24,xx+01,DY+44,colr)
        Line(xx+02,DY+25,xx+02,DY+43,colr)
        Line(xx+03,DY+25,xx+03,DY+43,colr)
        Line(xx+04,DY+26,xx+04,DY+42,colr)
        Line(xx+05,DY+26,xx+05,DY+42,colr)
        colr:=3
        IF (leds AND %100000)=%100000 THEN colr:=2
        Line(xx+39,DY+24,xx+39,DY+44,colr)
        Line(xx+38,DY+24,xx+38,DY+44,colr)
        Line(xx+37,DY+25,xx+37,DY+43,colr)
        Line(xx+36,DY+25,xx+36,DY+43,colr)
        Line(xx+35,DY+26,xx+35,DY+42,colr)
        Line(xx+34,DY+26,xx+34,DY+42,colr)
        colr:=3
        IF (leds AND %1000000)=%1000000 THEN colr:=2
        Line(xx+07,DY+42,xx+32,DY+42,colr)
        Line(xx+06,DY+43,xx+33,DY+43,colr)
        Line(xx+04,DY+44,xx+35,DY+44,colr)
        Line(xx+02,DY+45,xx+37,DY+45,colr)
ENDPROC

PROC drawLines()
        Box(6,12,152,NY-1,3)
        Box(6,NY,NX-1,NY+59,3)
        Box(NX+48,NY,DX-1,NY+59,3)
        Box(DX+48,NY,152,NY+59,3)
        Box(6,NY+60,152,147,3)

        RefreshGadgets(buf,wptr,NIL)

        Line(NX,NY,NX+22,NY,2)
        Line(NX,NY,NX,NY+10,2)
        Line(NX+24,NY,NX+24+22,NY,2)
        Line(NX+24,NY,NX+24,NY+10,2)
        Line(NX,NY+12,NX+22,NY+12,2)
        Line(NX,NY+12,NX,NY+10+12,2)
        Line(NX+24,NY+12,NX+24+22,NY+12,2)
        Line(NX+24,NY+12,NX+24,NY+10+12,2)
        Line(NX,NY+24,NX+22,NY+24,2)
        Line(NX,NY+24,NX,NY+10+24,2)
        Line(NX+24,NY+24,NX+24+22,NY+24,2)
        Line(NX+24,NY+24,NX+24,NY+10+24,2)
        Line(NX,NY+36,NX+22,NY+36,2)
        Line(NX,NY+36,NX,NY+10+36,2)
        Line(NX+24,NY+36,NX+24+22,NY+36,2)
        Line(NX+24,NY+36,NX+24,NY+10+36,2)
        Line(NX,NY+48,NX+22,NY+48,2)
        Line(NX,NY+48,NX,NY+10+48,2)
        Line(NX+24,NY+48,NX+24+22,NY+48,2)
        Line(NX+24,NY+48,NX+24,NY+10+48,2)

        Line(DX,NY,DX+22,NY,2)
        Line(DX,NY,DX,NY+10,2)
        Line(DX+24,NY,DX+24+22,NY,2)
        Line(DX+24,NY,DX+24,NY+10,2)
        Line(DX,NY+12,DX+22,NY+12,2)
        Line(DX,NY+12,DX,NY+10+12,2)
        Line(DX+24,NY+12,DX+24+22,NY+12,2)
        Line(DX+24,NY+12,DX+24,NY+10+12,2)
        Line(DX,NY+24,DX+22,NY+24,2)
        Line(DX,NY+24,DX,NY+10+24,2)
        Line(DX+24,NY+24,DX+24+22,NY+24,2)
        Line(DX+24,NY+24,DX+24,NY+10+24,2)
        Line(DX,NY+36,DX+22,NY+36,2)
        Line(DX,NY+36,DX,NY+10+36,2)
        Line(DX+24,NY+36,DX+24+22,NY+36,2)
        Line(DX+24,NY+36,DX+24,NY+10+36,2)
        Line(DX,NY+48,DX+22+24,NY+48,2)
        Line(DX,NY+48,DX,NY+10+48,2)

        Box(13,NY+63,146,NY+112,0)
        Box(15,NY+64,144,NY+111,1)
        convert(ret)

        SetAPen(wptr.rport,1)
        SetBPen(wptr.rport,0)
        TextF(DX+8,NY+56,'Roll')

        SetAPen(wptr.rport,1)
        SetBPen(wptr.rport,3)

        TextF(4+8,NY+8+5, 'N')
        TextF(4+8,NY+16+5,'u')
        TextF(4+8,NY+24+5,'m')
        TextF(4+8,NY+32+5,'b')
        TextF(4+8,NY+40+5,'e')
        TextF(4+8,NY+48+5,'r')
        TextF(DX+48+8,NY+8+6, 'D')
        TextF(DX+48+8,NY+16+6,'i')
        TextF(DX+48+8,NY+24+6,'c')
        TextF(DX+48+8,NY+32+6,'e')

        TextF(13,NY+122,'© 1994 BlackLight')
        TextF(13,NY+130,'        Software')
        SetAPen(wptr.rport,0)
        TextF(13,NY+130,'  v2.7')
ENDPROC

PROC easyExit(error)
        SELECT error
                CASE ER_NONE
                        CloseW(wptr)
                        err_Dispose()
                        CleanUp(0)
                CASE ER_WINDOW
                        err_WriteF('Error Opening Window!\n')
                        err_Dispose()
                        CleanUp(11)
        ENDSELECT
ENDPROC

PROC cliOutput()
        DEF tempStr[15]:STRING,tempPtr,tempNum,num,die,ret
        IF arg[]="?"
                echoUsage()
                CleanUp(0)
        ENDIF
        tempPtr:=2
        IF arg[]="1"
                num:=1
                IF arg[1]="0"
                        num:=10
                        tempPtr:=3
                ENDIF
        ELSE
                tempStr[]:=arg[]
                num:=Val(tempStr,NIL)
        ENDIF
        IF arg[tempPtr]="%"
                die:=100
        ELSE
                MidStr(tempStr,arg,tempPtr,ALL)
                die:=Val(tempStr,NIL)
        ENDIF
        WHILE (arg[tempPtr]<>"-") AND (arg[tempPtr]<>"+") AND (arg[tempPtr]<>0) DO INC tempPtr
        IF arg[tempPtr]="+" THEN INC tempPtr
        MidStr(tempStr,arg,tempPtr,ALL)
        tempNum:=Val(tempStr,NIL)
        ret:=doRandom(num,die)
        WriteF('\d\n',ret+tempNum)
        CleanUp(0)
ENDPROC

PROC echoUsage()
        WriteF( 'ElectricBones v2.7 - © 1994 BlackLight Software\n' );
        WriteF( 'Usage: EB <Number>d<Die>+/-<Add>\n' );
ENDPROC
