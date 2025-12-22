/*
	Read a file (obdata.dat) manipulate records in it.

	This program is © 1999 Kay Ove Ovesen. You may spread it freely, as long as
	the original archive contents is unchanged. You may include parts of the
	code in your own programs without permission from the author.

	The program was written under OS 3.0 and compiled with AmigaE v3.3a.

*/

MODULE 'tools/file', 'tools/exceptions'

/*	For practical reasons, some variables are defined globally */

DEF obfile, oblen, obname, verbose=0

	/* OBJECT INITIALIZATION */

OBJECT weapon
	indx:CHAR			->Internal Index number
	name[20]:ARRAY		->Offset 00
	damage:CHAR			->Offset 16
	ammo1:CHAR			->Offset 1A
	ammo2:CHAR			->Offset 1B
	ammo3:CHAR			->Offset 1C
	dtype:CHAR			->Offset 1F
	accauto:CHAR		->Offset 20
	accsnap:CHAR		->Offset 21
	accaimed:CHAR		->Offset 22
	timeauto:CHAR		->Offset 23
	timesnap:CHAR		->Offset 24
	timeaimed:CHAR		->Offset 25
	ammords:CHAR		->Offset 26
ENDOBJECT

/*	END Object init */

/* OBJECT Methods */

PROC readobvalues(y) OF weapon
	MidStr(self.name,obfile,y)
	self.damage:=obfile[y+22]
	self.ammo1:=obfile[y+26]
	self.ammo2:=obfile[y+27]
	self.ammo3:=obfile[y+28]
	self.dtype:=obfile[y+31]
	self.accauto:=obfile[y+32]
	self.accsnap:=obfile[y+33]
	self.accaimed:=obfile[y+34]
	self.timeauto:=obfile[y+35]
	self.timesnap:=obfile[y+36]
	self.timeaimed:=obfile[y+37]
	self.ammords:=obfile[y+38]
	self.indx:=y/54
ENDPROC

PROC writeobvalues(y, wep:PTR TO weapon)
	obfile[y+22]:=wep.damage
	obfile[y+26]:=wep.ammo1
	obfile[y+27]:=wep.ammo2
	obfile[y+28]:=wep.ammo3
	obfile[y+31]:=wep.dtype
	obfile[y+32]:=wep.accauto
	obfile[y+33]:=wep.accsnap
	obfile[y+34]:=wep.accaimed
	obfile[y+35]:=wep.timeauto
	obfile[y+36]:=wep.timesnap
	obfile[y+37]:=wep.timeaimed
	obfile[y+38]:=wep.ammords
ENDPROC

PROC impvalues(rcd, wepname) OF weapon
/*	All values are checked for valid ranges before import */

	MidStr(self.name,wepname,0)

	self.indx:=rcd[0]

	IF (rcd[2]>255) OR (rcd[2]<0)
		PrintF('\tWARNING: Damage for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.damage:=rcd[2]
	ENDIF

	IF ((rcd[3]<>255) AND ((rcd[3]>79) OR (rcd[4]<0)))
		PrintF('\tWARNING: Ammo1 for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.ammo1:=rcd[3]
	ENDIF

	IF ((rcd[4]<>255) AND ((rcd[4]>79) OR (rcd[4]<0)))
		PrintF('\tWARNING: Ammo2 for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.ammo2:=rcd[4]
	ENDIF

	IF ((rcd[5]<>255) AND ((rcd[5]>79) OR (rcd[5]<0)))
		PrintF('\tWARNING: Ammo3 for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
	self.ammo3:=rcd[5]
	ENDIF

	IF (rcd[6]>255) OR (rcd[6]<0) OR ((rcd[6]>6) AND (rcd[6]<255))
		PrintF('\tWARNING: Damagetype for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.dtype:=rcd[6]
	ENDIF

	IF (rcd[7]>255) OR (rcd[7]<0)
		PrintF('\tWARNING: AccAuto for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.accauto:=rcd[7]
	ENDIF

	IF (rcd[8]>255) OR (rcd[8]<0)
		PrintF('\tWARNING: AccSnap for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.accsnap:=rcd[8]
	ENDIF

	IF (rcd[9]>255) OR (rcd[9]<0)
		PrintF('\tWARNING: AccAimed for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.accaimed:=rcd[9]
	ENDIF

	IF (rcd[10]>100) OR (rcd[10]<0)
		PrintF('\tWARNING: TUAuto for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.timeauto:=rcd[10]
	ENDIF

	IF (rcd[11]>100) OR (rcd[11]<0)
		PrintF('\tWARNING: TUSnap for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.timesnap:=rcd[11]
	ENDIF

	IF (rcd[12]>100) OR (rcd[12]<0)
		PrintF('\tWARNING: TUAimed for object #\d (\s) is out of range!\n', rcd[0], wepname) 
		RETURN 1
	ELSE
		self.timeaimed:=rcd[12]
	ENDIF

	IF (rcd[13]>255) OR (rcd[13]<0)
		PrintF('\nWARNING: AmmoRds for object #\d (\s) is out of range!\n', rcd[0], wepname)
		RETURN 1
	ELSE
		self.ammords:=rcd[13]
	ENDIF
ENDPROC

PROC printobvalues(wep:PTR TO weapon)
	PrintF('\nIndex:\t\t\d', wep.indx)
	PrintF('\nName:\t\t\s', wep.name)
	PrintF('\nDamage:\t\t\d', wep.damage)
	PrintF('\nDmgType:\t\d', wep.dtype)
	PrintF('\nRounds:\t\t\d', wep.ammords)
	PrintF('\nAmmo 1:\t\t\d', wep.ammo1)
	PrintF('\nAmmo 2:\t\t\d', wep.ammo2)
	PrintF('\nAmmo 3:\t\t\d', wep.ammo3)
	PrintF('\nAcc. Auto:\t\d', wep.accauto)
	PrintF('\nAcc. Snap:\t\d', wep.accsnap)
	PrintF('\nAcc. Aimed:\t\d', wep.accaimed)
	PrintF('\nTU Auto:\t\d', wep.timeauto)
	PrintF('\nTU Snap:\t\d', wep.timesnap)
	PrintF('\nTU Aimed:\t\d', wep.timeaimed)
	PrintF('\n\n')
ENDPROC

/*	END Object methods */

PROC main() HANDLE
	DEF templ, rdargs, y, args=NIL:PTR TO LONG
	DEF wep:PTR TO weapon
	templ:='FILE/M,OPT2/K,OPT3/K'
	rdargs:=ReadArgs(templ,{args},NIL)

	PrintF('\n\t***   UFO Weapons editor v1.2   ***\n')

	IF args[0]=NIL
		PrintF('\nUsage: OBEdit <FILENAME> <RECORD>')
		PrintF('\nWhere <FILENAME> is file to scan and <RECORD> is #record to display.\n')
		PrintF('If <RECORD> is ommitted or out of range, the program will list all records in file.\n')
		PrintF('If <RECORD> is "all" then the program will list ALL objects in the file.\n\n')
		PrintF('Use "export(r)ff" <FILENAME> to make an RFF 1.1-compatible database file.\n')
		PrintF('Use "export(c)sv" <FILENAME> to make an ASCII-standard Comma-separated database file\n')
		PrintF('Use "export(t)sv" <FILENAME> to make an ASCII-standard Tab-separated database\n')
		PrintF('file with headers. (Compatible with most database programs and spreadsheets.)\n')
		PrintF('Use "(i)mport" <FILENAME> to import a tab- or comma-separated ASCII file.\n')
		PrintF('Use "ex" for a short list of examples.\n')
		RETURN
	ENDIF

	IF StrCmp(LowerStr(args[0]),'ex') THEN printexamples()

	obfile,oblen:=readfile(args[0])
	PrintF('File: \s', args[0])
	PrintF('\nSize: \d bytes.',oblen)
	IF oblen=4320
		PrintF('\nFile seems to be of correct lenght.\n')
		obname:=args[0]
	ELSE
		PrintF(' - File is not of correct lenght for OBDATA.DAT.\n')
		PrintF('Examining...')
		IF StrCmp(LowerStr(args[1]),'all') OR StrCmp(args[1],'a') THEN verbose:=1
		checkformat(args[0], 0)
		RETURN
	ENDIF

	IF StrCmp(LowerStr(args[1]),'exportcsv') OR StrCmp(args[1],'csv') OR StrCmp(args[1],'c')
		IF (StrCmp(LowerStr(args[3]),'verbose') OR StrCmp(LowerStr(args[3]),'v')) THEN verbose:=1
		writecsv(args[2], LowerStr(args[3]))
		RETURN
	ENDIF

	IF StrCmp(LowerStr(args[1]),'exporttsv') OR StrCmp(args[1],'tsv') OR StrCmp(args[1],'t')
		IF (StrCmp(LowerStr(args[3]),'verbose') OR StrCmp(LowerStr(args[3]),'v')) THEN verbose:=1
		writerff(args[2], LowerStr(args[3]), 0)
		RETURN
	ENDIF

	IF StrCmp(LowerStr(args[1]),'exportrff') OR StrCmp(args[1], 'rff') OR StrCmp(args[1],'r') 
		IF (StrCmp(LowerStr(args[3]),'verbose') OR StrCmp(LowerStr(args[3]),'v')) THEN verbose:=1
		writerff(args[2], LowerStr(args[3]), 1)
		RETURN
	ENDIF

	IF StrCmp(LowerStr(args[1]),'import') OR StrCmp(args[1], 'i') OR StrCmp(args[1], 'imp')
		IF (StrCmp(LowerStr(args[3]),'verbose') OR StrCmp(LowerStr(args[3]),'v')) THEN verbose:=1
		checkformat(args[2], 1)
		RETURN
	ENDIF

	IF StrCmp(LowerStr(args[1]),'all') OR StrCmp(args[1], 'a')
		FOR y:=0 TO (oblen-54) STEP 54
			NEW wep
			wep.readobvalues(y)
			printobvalues(wep)
			END wep
			IF CtrlC() THEN CleanUp()
		ENDFOR
		RETURN
	ENDIF

	y:=(Val(args[1])*54)
	IF y>(oblen-54)
		PrintF('\nERROR: Record \d does not exist in \s!\n', Val(args[1]), args[0])
		listrecords()
		RETURN
	ENDIF
	
	IF args[1]=NIL
		listrecords()
		RETURN
	ENDIF

	NEW wep
	wep.readobvalues(y)
	printobvalues(wep)
	END wep

EXCEPT
	report_exception()
ENDPROC

PROC listrecords() ->If no record number is given, this will simply list all records in the file.
	DEF y
	DEF navn

	PrintF('\nIndex:\tName:\n---------------------------\n')
	FOR y:=0 TO (oblen-54) STEP 54
		IF CtrlC() THEN CleanUp()
		navn:=obfile+y
		IF (y/54)<10
			PrintF('0')
		ENDIF
		->hexnumber:=(y/54)
		->hexnumber:=Val($hexnumber)
		PrintF('\d\t\s\n', y/54, navn)
	ENDFOR
ENDPROC

PROC writecsv(csvfile, all)
	DEF wep:PTR TO weapon, y
	DEF tempstring[60]:STRING
	DEF em[4000]:STRING
	StrCopy(em, 'Index,Name,Damage,Ammo1,Ammo2,Ammo3,DmgType,Accauto,Accsnap,Accaimed,TUAuto,TUSnap,TUAimed,Rounds\n')
	FOR y:=0 TO (IF StrCmp(all, 'all') THEN oblen-54 ELSE 2646) STEP 54
		IF CtrlC() THEN CleanUp()
		NEW wep
		wep.readobvalues(y)
		StringF(tempstring,'\d,\s,\d,\d,\d,\d,\d,\d,\d,\d,\d,\d,\d,\d\n', (y/54),wep.name,wep.damage,wep.ammo1,wep.ammo2,wep.ammo3,wep.dtype,wep.accauto,wep.accsnap,wep.accaimed,wep.timeauto,wep.timesnap,wep.timeaimed,wep.ammords)
		IF (verbose<>0) THEN PrintF('Found weapon "\s" at index #\d.\n', wep.name, y/54)
		END wep
		StrAdd(em,tempstring)
	ENDFOR
	StrAdd(em, '\0')
	writefile(csvfile,em,StrLen(em))
	PrintF('\nWrote CSV-file "\s".\n\n', csvfile)
	CleanUp()
ENDPROC

PROC writerff(rffile, all, hdr)
	DEF wep:PTR TO weapon, y
	DEF tempstring[60]:STRING ->rffhdr[550]:STRING
	DEF em[5000]:STRING

/*	Creating RFF Field Names */

	StrCopy(em, 'Index\tName\tDamage\tAmmo1\tAmmo2\tAmmo3\tDmgType\tAccauto\tAccsnap\tAccaimed\tTUAuto\tTUSnap\tTUAimed\tRounds\n')

/* Creating an RFF header if hdr is '1' (defined by the 'exporttsv' argument) */
	IF (hdr=1)
		IF FileLength('s:OBEdit.hdr')>-1	->Check for a custom RFF header file and load this if possible.
			StrAdd(em, readfile('s:OBEdit.hdr', 0))
			PrintF('\nUsing custom RFF header from S:OBEdit.hdr\n')
		ELSE
			/* If no custom RFF header is found, default values are used. */
			PrintF('\nS:OBEdit.hdr not found, using built-in default.\n')
			StrAdd(em, '@RFF=1.1,TYPE=form\tFTYP=text,NAME=Index,OFFS=0,SIZE=3,NEXT=tab\tFTYP=text,NAME=Name,OFFS=1,SIZE=22,NEXT=nl\tFTYP=cycle,CENT=0,CENT=1,CENT=2,CENT=3,CENT=4,CENT=5,CENT=6,CENT=255,NAME=DmgType,OFFS=6,SIZE=6,NEXT=tab\tNAME=Damage,OFFS=2,SIZE=3,NEXT=tab\tNAME=Rounds,OFFS=13,SIZE=3,NEXT=nl\tNAME=Ammo1,OFFS=3,SIZE=3,NEXT=tab\tNAME=Ammo2,OFFS=4,SIZE=3,NEXT=tab\tNAME=Ammo3,OFFS=5,SIZE=3,NEXT=nl\tNAME=Accauto,OFFS=7,SIZE=3,NEXT=tab\tNAME=Accsnap,OFFS=8,SIZE=3,NEXT=tab\tNAME=Accaimed,OFFS=9,SIZE=3,NEXT=nl\tNAME=TUAuto,OFFS=10,SIZE=3,NEXT=tab\tNAME=TUSnap,OFFS=11,SIZE=3,NEXT=tab\tNAME=TUAimed,OFFS=12,SIZE=3,NEXT=para\n')
		ENDIF
	ENDIF

/*	Reading values from .dat file in memory and create an RFF file. */

	FOR y:=0 TO (IF StrCmp(all, 'all') THEN oblen-54 ELSE 2646) STEP 54
		IF CtrlC() THEN CleanUp()
		NEW wep
		wep.readobvalues(y)
		StringF(tempstring,'\d\t\s\t\d\t\d\t\d\t\d\t\d\t\d\t\d\t\d\t\d\t\d\t\d\t\d\n', (y/54),wep.name,wep.damage,wep.ammo1,wep.ammo2,wep.ammo3,wep.dtype,wep.accauto,wep.accsnap,wep.accaimed,wep.timeauto,wep.timesnap,wep.timeaimed,wep.ammords)
		IF (verbose<>0) THEN PrintF('Found object "\s" at index #\d.\n', wep.name, y/54)
		END wep
		StrAdd(em,tempstring)
	ENDFOR
	StrAdd(em, '\0') -> Making sure the file is null-terminated

	writefile(rffile,em,StrLen(em))
	IF hdr=1 THEN PrintF('\nWrote RFF-file "\s".\n\n', rffile) ELSE PrintF('\nWrote TSV-file "\s".\n\n', rffile)
	CleanUp()
ENDPROC

PROC checkformat(infile, imp)
	DEF fhandle, firstline[30]:STRING
	
	IF fhandle:=Open(infile, OLDFILE)
		Fgets(fhandle,firstline,30)
		Close(fhandle)
	ELSE
		PrintF('\nCould not open file "\s".',infile)
		RETURN
	ENDIF

	IF (InStr(firstline, ',')<>-1)
		PrintF('\nFile "\s" is CSV-ADCH format.\n', infile)
		IF imp=1 THEN importcsv(infile) ELSE testdata(',')
	ELSEIF (InStr(firstline,'	')<>-1)
		PrintF('\nFile "\s" is TSV-ADTH/RFF-DB format.\n', infile)
		IF imp=1 THEN importrff(infile) ELSE testdata('	')
	ELSE
		PrintF('\nABORTED: File "\s" has an unknown format.\n', infile)
	ENDIF
ENDPROC

PROC importrff(infile)
	DEF rff, len
	DEF start=0, end
	rff, len:=readfile(infile)

/*	Skip to the first line after the RFF header.*/

	IF InStr(rff, '@')<>-1
		start:=InStr(rff, '\n', InStr(rff, '@', start))+1
	ELSE
		start:=InStr(rff, '\n', start)+1
	ENDIF

	REPEAT
		end:=InStr(rff, '\n', start)
		IF end<>-1 THEN rff[end]:=NIL
		procline(rff+start, '	')
		start:=end+1
	UNTIL (start>=len) OR (end=-1)

	writefile(obname, obfile, oblen)
	PrintF('\nSuccessfully imported RFF file to "\s".\n', obname)
	RETURN
ENDPROC

PROC importcsv(infile)
	DEF csv, len
	DEF start=0, end
	csv,len:=readfile(infile)

/*	Skip the first line containing the headers.*/

	start:=InStr(csv, '\n',start)+1

	REPEAT
		end:=InStr(csv, '\n', start)
		IF end<>-1 THEN csv[end]:=NIL
		procline(csv+start, ',')
		start:=end+1
	UNTIL (start>=len) OR (end=-1)

	writefile(obname, obfile, oblen)
	PrintF('\nSuccessfully imported CSV file to "\s".\n', obname)

	RETURN
ENDPROC

PROC procline(line, delim)
	DEF start=0, end, s, i=0
	DEF rcd[14]:STRING, errline[76]:STRING, wepname[20]:STRING
	DEF wep:PTR TO weapon

	IF StrLen(line)<20 THEN RETURN
	StrCopy(errline, line)
	REPEAT
		end:=InStr(line,delim,start)
		IF end<>-1 THEN line[end]:=NIL
		s:=line+start
		IF ((Val(s)>255) OR (Val(s)<0)) AND (i<>0)
			PrintF('\tSKIPPED: "\s" - Value \d out of range (\d)!\n', errline, i+1, Val(s))
			RETURN
		ELSEIF ((Val(s)>79) OR (Val(s)<0)) AND (i=0)
			PrintF('\tSKIPPED: "\s" - Invalid object index "\d"!\n', errline, Val(s))
			RETURN
		ELSE
			rcd[i]:=Val(s)
		ENDIF
		IF(i=1) THEN StrCopy(wepname, s)
		INC i
		start:=end+1
	UNTIL end=-1

	IF i<>14 THEN RETURN -> Check that the line contained exactly 14 values.

	NEW wep
		IF	(wep.impvalues(rcd, wepname)<>1)
			writeobvalues(rcd[0]*54, wep)
			IF (verbose<>0) THEN PrintF('Imported object "\s" at index #\d.\n', wepname, rcd[0])
		ELSE
			PrintF('\tSkipped object #\d!\n', rcd[0])
		ENDIF
	END wep

ENDPROC

PROC printexamples() -> Print some examples of usage.
	PrintF('\nAbbrevations:\n')
	PrintF('\tI - Import\n')
	PrintF('\tC - ExportCSV\n')
	PrintF('\tT - ExportTSV\n')
	PrintF('\tR - ExportRFF\n')
	PrintF('\tV - Verbose\n')
	PrintF('\nExamples:\n\n')
	PrintF('\tOBEdit obdata.dat\n\n')
	PrintF('Print a list of objects found in file "obdata.dat".\n\n')
	PrintF('\tOBEdit obdata.dat 12\n\n')
	PrintF('Print details about object #12 in "obdata.dat".\n\n')
	PrintF('\tOBEdit obdata.dat all\n\n')
	PrintF('Prints detail about ALL objects in "obdata.dat".\n\n')
	PrintF('\tOBEdit obdata.dat exportcsv data.csv\n\n')
	PrintF('Export data in "obdata.dat" to a comma-separated ASCII file "data.csv".\n\n')
	PrintF('\tOBEdit obdata.dat exporttsv data.tsv\n\n')
	PrintF('Export data in "obdata.dat" to a tab-separated ASCII file "data.tsv".\n\n')
	PrintF('\tOBEdit obdata.dat exportrff data.db\n\n')
	PrintF('Export data in "obdata.dat" to a tab-separated RFF file "data.db".\n\n')
	PrintF('\tOBEdit obdata.dat import data.whatever\n\n')
	PrintF('Import data from file "data.whatever" (either tab- or comma-separated) to "obdata.dat".\n')
	CleanUp()
ENDPROC

PROC testdata(delim)	/* Examine a CSV/TSV/RFF file */
	DEF wep:PTR TO weapon, lstart=0,lend,start=0,end,i, records=0, errors=0, lines=0
	DEF rcd[14]:STRING, line[76]:STRING, errline[76]:STRING, wepname[20]:STRING, s

/* Skip line 1 */
	lstart:=InStr(obfile, '\n', lstart)+1
	INC lines
/* Skip RFF header if found */
	IF InStr(obfile,'@',lstart)<>-1
		lstart:=InStr(obfile,'\n',lstart)+1
		INC lines
	ENDIF
	lend:=InStr(obfile,'\n',lstart)

/* Start reading */

	PrintF('\n')
	IF verbose=0 THEN PrintF('Line\tIndex\tName\n------------------------\n')

	REPEAT
		IF CtrlC() THEN CleanUp()
		i:=0
		start:=0
		MidStr(line,obfile,lstart,lend-lstart)
		StrCopy(errline, line)
		INC lines
		IF StrLen(line)>20

			REPEAT
				IF CtrlC() THEN CleanUp()
				end:=InStr(line,delim,start)
				IF end<>-1 THEN line[end]:=NIL
				s:=line+start
				IF(i=1) THEN StrCopy(wepname, s)
				IF ((Val(s)>255) OR (Val(s)<0)) AND (i<>0)
					PrintF('\tWarning: Value \d out of range (\d)!\n', i+1, Val(s))
					PrintF('Line \d: \s\n\n', lines, errline)
					INC errors
					JUMP endline
				ELSEIF ((Val(s)>79) OR (Val(s)<0)) AND (i=0)
					PrintF('\tWARNING: Invalid object index "\d"!\n', Val(s))
					PrintF('Line \d: \s\n\n', lines, errline)
					INC errors
					JUMP endline
				ELSE
					rcd[i]:=Val(s)
				ENDIF
				INC i
				start:=end+1

			UNTIL end=-1
			IF i<>14
				PrintF('\tWARNING: Line \d contains incomplete or superfluous data!\n', lines)
				PrintF('Line \d: \s\n\n', lines, errline)
				INC errors
				JUMP endline
			ELSE
				NEW wep
				IF	(wep.impvalues(rcd, wepname)<>1)
					IF verbose=1
						PrintF('Line \d: \s', lines, errline)
						printobvalues(wep)
					/* If Verbose is not checked, print a standard list of objects in file. */
					ELSEIF verbose=0
						PrintF('\d\t\d\t\s\n',lines,wep.indx,wep.name)
					ENDIF
					INC records
				ELSE
					PrintF('Line \d: \s\n', lines, errline)
					PrintF('\n')
					INC errors
				ENDIF
				END wep
			ENDIF

		ENDIF
			endline:
			lstart:=lend+1
			lend:=InStr(obfile,'\n',lstart)
	UNTIL lend=-1

/* Print Summary */
	PrintF('\n\tSUMMARY:\n')
	PrintF('-------------------------\n')
	PrintF('File lenght (lines):   \d\n', lines-3)
	PrintF('Valid objects found:   \d\n', records)
	PrintF('Invalid objects found: \d\n', errors)

ENDPROC

ver: CHAR 0,'$VER: OBEdit 1.2 (05.07.99) By Kay Ove Ovesen <ai97koo@stud.hib.no>',0
