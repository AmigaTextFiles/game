MODULE 'dos/dos'

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10

OBJECT kcfheader
  kissid:LONG
  filetype:CHAR
  colors:INT
ENDOBJECT

PROC main()
  DEF fh,pal[16]:ARRAY OF INT,fbuf:PTR TO CHAR,i
  fbuf:=FastNew(500)
  fh:=Open('RAM:palette.kcf',MODE_NEWFILE)

			PutLong(fbuf,"KiSS")
			PutChar(fbuf+4,FILE_MARK_PALET)
			PutChar(fbuf+5,$18)
			PutInt(fbuf+8,ibmconv($10))
			PutInt(fbuf+10,ibmconv(10))
			Write(fh,fbuf,32)
/*
			FOR t:=0 TO 9
					FOR i:=0 TO IF 4 ->(depth=4) THEN 15 ELSE 255
							PutChar(fbuf+(i*3),palet.color[i].red)
							PutChar(fbuf+(i*3)+1,palet.color[i].grn)
							PutChar(fbuf+(i*3)+2,palet.color[i].blu)
					ENDFOR
					Write(fh1,fbuf,IF (depth=4) THEN 16*3 ELSE 256*3)
			ENDFOR
*/
  Write(fh,{pal0},48)
  Write(fh,{pal1},48)
  Write(fh,{pal2},48)
  Write(fh,{pal3},48)
  Write(fh,{pal4},48)
  Write(fh,{pal5},48)
  Write(fh,{pal6},48)
  Write(fh,{pal7},48)
  Write(fh,{pal8},48)
  Write(fh,{pal9},48)
->  FOR i:=0 TO 9 DO Write(fh,{data},48)
  Close(fh)
ENDPROC

PROC ibmconv(a)
  DEF hi,lo,ret
  hi:=a AND $FF00
  lo:=a AND $00FF
  ret:=Shl(lo,8) OR Shr(hi,8)
ENDPROC ret

pal0:             -> wîosy zielone
CHAR 000,062,135,
	 068,068,068,
	 102,068,017,
	 085,085,085
CHAR 136,102,068,
	 051,153,102, -> wîosy ciemny
	 085,136,221,
	 119,170,238
CHAR 204,204,204,
	 119,221,153, -> wîosy jasny
	 204,238,255,
	 255,184,164
CHAR 255,203,184,
	 255,221,204,
	 255,255,255,
	 0,0,0

pal1:             -> wîosy czerwone
CHAR 000,062,135,
	 068,068,068,
	 102,068,017,
	 085,085,085
CHAR 136,102,068,
	 209,000,000, -> wîosy ciemny
	 085,136,221,
	 119,170,238
CHAR 204,204,204,
	 255,000,000, -> wîosy jasny
	 204,238,255,
	 255,184,164
CHAR 255,203,184,
	 255,221,204,
	 255,255,255,
	 0,0,0

pal2:             -> wîosy niebieskie
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 000,056,176, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 000,081,255, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal3:             -> wîosy blond
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 186,186,128, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 255,255,176, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal4:             -> wîosy róûowe
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 106,000,196, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 255,000,255, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal5:             -> wîosy biaîe
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 196,196,196, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 255,255,255, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal6:             -> wîosy czarne
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 010,010,010, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 020,020,020, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal7:             -> wîosy zielono ûóîte
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 010,255,010, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 255,255,000, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal8:             -> wîosy ciemny róû
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 102,068,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 171,000,097, -> wîosy ciemny
	 085,136,221, -> oczy ciemny
	 119,170,238  -> oczy jasny
CHAR 204,204,204,
	 255,000,146, -> wîosy jasny
	 204,238,255,
	 255,184,164  -> skóra ciemny
CHAR 255,203,184, -> skóra póîciemny
	 255,221,204, -> skóra jasny
	 255,255,255,
	 0,0,0

pal9:             -> wîosy kasztanowe, czerwone oczy, zielona skóra
CHAR 000,062,135, -> tîo
	 068,068,068, -> ubranie ciemny
	 000,000,017,
	 085,085,085  -> ubranie jasny
CHAR 136,102,068,
	 158,070,008, -> wîosy ciemny
	 207,000,000, -> oczy ciemny
	 255,000,000  -> oczy jasny
CHAR 204,204,204,
	 204,091,010, -> wîosy jasny
	 204,238,255,
	 042,113,017, -> skóra ciemny
	 052,138,021, -> skóra póîciemny
	 061,163,024, -> skóra jasny
	 255,255,255,
	 0,0,0
