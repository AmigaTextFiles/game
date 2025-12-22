MODULE 'dos/dos'

DEF hexa[16]:STRING

PROC main()
DEF jmeno[80]:STRING,znak,horni,dolni,i,j,k,blbecek,pitomecek,realstupid,oldstd
hexa:='0123456789ABCDEF'
oldstd:=stdout
WriteF('Input file name of a brush 48x20\n')
IF ReadStr(stdout,jmeno)<>-1
	IF blbecek:=Open(jmeno,OLDFILE)
     	IF pitomecek:=Open('RAM:output1',NEWFILE)
     	IF realstupid:=Open('RAM:output2',NEWFILE)

	Seek(blbecek,108,OFFSET_BEGINNING)

	FOR i:=1 TO 20

              	stdout:=pitomecek
              	FOR j:=1 TO 3
                WriteF('0x')

              	FOR k:=1 TO 2
                znak:=Inp(blbecek)
                horni:=znak/16
                dolni:=znak-(horni*16)
                WriteF('\c',hexa[15-horni])
		WriteF('\c',hexa[15-dolni])

                ENDFOR
                WriteF(' ')
		ENDFOR
		WriteF('\n')

		stdout:=realstupid
		FOR j:=1 TO 3
		WriteF('0x')

              	FOR k:=1 TO 2
                znak:=Inp(blbecek)
                horni:=znak/16
                dolni:=znak-(horni*16)
                WriteF('\c',hexa[horni])
		WriteF('\c',hexa[dolni])

                ENDFOR
                WriteF(' ')
		ENDFOR
		WriteF('\n')

	ENDFOR
        stdout:=oldstd

	Close(blbecek)
	Close(pitomecek)
	Close(realstupid)

	ELSE
	WriteF('Could not open output.\n')
	Close(blbecek)
	Close(pitomecek)
	ENDIF
	ELSE
	WriteF('Could not open output.\n')
	Close(blbecek)
	ENDIF
	ELSE
	WriteF('Could not find input file.\n')
	ENDIF
ELSE
WriteF('Name input has not succeed.\n')
ENDIF
CleanUp(0)
ENDPROC
