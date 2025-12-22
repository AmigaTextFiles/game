/* $VER: SynchronizeSpells.rexx 1.2 (09.09.2003) by F.Delacroix */
/* This spell will read two (cf usage) spell directories. One will be taken as
** a reference (English/ by default) , the other one is supposed to be a translations
** directory. Then extraneous, missing spell descrptions, as well as those which
** do not have the correct case, will be reported, and scripts will be generated
** to correct this via AmigaDOS.
** New for v1.2: a new script will archive all the new english spell descriptions for
** sending to translators
**
** Requirements: rexxsupport.library, rexxdossupport.library
**
** Usage: rx SynchronizeSpells <TranslationDir> [ReferenceDir] [ScriptDir] [NOSCRIPT]
**
** Template: TranslationDir/A,ReferenceDir,ScriptDir,NOSCRIPT/S
**
** where:
**  TranslationDir (required) is the path to the directory to examine.
**  ReferenceDir (optional) is the path to the directory to serve as a reference
**               for TranslationDir (default: English, this assumes you are running
**               this script from the SpellDescriptions/ directory).
**  ScriptDir (optional) is the path to the directory where the scripts will be
**            generated. Default: RAM:. You will get 3 AmigaDOS scripts there,
**            you can read them to be sure and then Execute them in the shell:
**                - ExtraSpells (will delete extra translations, for spells that have
**                  been renamed or deleted). Better control everything is OK in there.
**                - MissingSpells (will copy missing translations from the Reference
**                  directory, to serve as a default for the translation) and then call
**                  an editor for each of them. The editor command is modifyable below)
**                - CorrectSpellCase (will adjust the case of the filenames). Just a
**                  detail.
**                - ArchiveNewSpells (will archive the new english spell descriptions.
**                  The archiver command is modifyable below. The archive will be
**                  created in the same directory as the script.
**
**            WARNING: If these scripts already exist, they will be deleted !
**  NOSCRIPT (switch): specify this if you don't want scripts to be generated.
**
**  Revision History:
**  -----------------
**  V1.0 (9.3.2003): Initial version
**
**  V1.1 (26.3.2003): No longer relies on the SORT option of the List command,
**                    so this should work with OS versions <3.9 (Requested by Robin)
**                    Improved error reporting.
**
**  V1.2 (9.9.2003): New script: ArchiveNewSpells.
**
*/


/*********** Modifiable variables ************************/
EditorCmd="Ed -s"	/* CygnusEd with sticky mode */
/* ArchiverCommand="LHA -I -r a" */
ArchiverCommand="lzx -r -a -e -3 a"
ArchiveName="NewSpells.lzx"
MaxSpellsToArchiveOnOneLine=15	/* avoid WRITELN()'s problems with very long lines */
/*********** End of freely modifiable variables *****************/

CALL ADDLIB("rexxdossupport.library",0,-30,2)
CALL ADDLIB("rexxsupport.library",0,-30,0)

Template="TranslationDir/A,ReferenceDir,ScriptDir,NOSCRIPT/S"

ReferenceDir="English"
ScriptDir="RAM:"
NOSCRIPT=0

IF ~ReadArgs(ARG(1),Template,) THEN DO
	SAY Fault(RC,"SynchronizeSpells")
	EXIT 20
END

ADDRESS COMMAND

SAY "Initializing..."
'List "'||ReferenceDir||'" LFORMAT "%n" FILES TO T:RefDirList.unsorted'
IF RC~=0 THEN DO
	SAY "Error listing reference files."
	EXIT 20
END
"Sort T:RefDirList.unsorted T:RefDirList"
IF RC~=0 THEN DO
	SAY "Error sorting reference files."
	EXIT 20
END
'List "'||TranslationDir||'" LFORMAT "%n" FILES TO T:TransDirList.unsorted'
IF RC~=0 THEN DO
	SAY "Error listing translated files."
	EXIT 20
END
"Sort T:TransDirList.unsorted T:TransDirList"
IF RC~=0 THEN DO
	SAY "Error sorting translated files."
	EXIT 20
END

IF ~OPEN("RefDir","T:RefDirList","Read") THEN DO
	SAY "Unable to open the list of reference files."
	EXIT 20
END

IF ~OPEN("TransDir","T:TransDirList","Read") THEN DO
	SAY "Unable to open the list of translated files."
	EXIT 20
END

IF ~NOSCRIPT THEN DO
	ExtraSpellsPath=AddPart(ScriptDir,"ExtraSpells")
	MissingSpellsPath=AddPart(ScriptDir,"MissingSpells")
	CorrectSpellCasePath=AddPart(ScriptDir,"CorrectSpellCase")
	ArchiveNewSpellsPath=AddPart(ScriptDir,"ArchiveNewSpells")
	MissingOpened=0
	ExtraOpened=0
	CorrectCaseOpened=0
	ArchiveNewSpellsOpened=0
	IF EXISTS(ExtraSpellsPath) THEN CALL DELETE(ExtraSpellsPath)
	IF EXISTS(MissingSpellsPath) THEN CALL DELETE(MissingSpellsPath)
	IF EXISTS(CorrectSpellCasePath) THEN CALL DELETE(CorrectSpellCasePath)
	IF EXISTS(ArchiveNewSpellsPath) THEN CALL DELETE(ArchiveNewSpellsPath)
END

SAY "Reading Reference directory" ReferenceDir||"..."
refcount=0
DO WHILE ~EOF("RefDir")
	/* read the whole refdir */
	refline=READLN("RefDir")
	IF refline~="" THEN DO
		refcount=refcount+1
		refdir.refcount=refline
	END
END

SAY "Reference directory read," refcount "spells found."

SAY "Reading Translation directory" TranslationDir||"..."
transcount=0
DO WHILE ~EOF("TransDir")
	/* read the whole transdir */
	transline=READLN("TransDir")
	IF transline~="" THEN DO
		transcount=transcount+1
		transdir.transcount=transline
	END
END

SAY "Translation directory read," refcount "spells found."

CALL CLOSE("RefDir")
CALL CLOSE("TransDir")

IF (refcount=0)|(transcount=0) THEN DO
	SAY "No reference or translated spell description found, aborting."
	EXIT 10
END

refi=1
transi=1

casecount=0
extracount=0
missingcount=0

DO WHILE (refi<=refcount)&(transi<=transcount)
	/* let's do the comparisons */
	IF UPPER(refdir.refi)==UPPER(transdir.transi) THEN DO	/* let's compare the cases */
		IF refdir.refi~=transdir.transi THEN DO
			SAY "Case mismatch for spell" refdir.refi
			CALL CorrectSpellCase(transdir.transi,refdir.refi)
			casecount=casecount+1
		END
		refi=refi+1
		transi=transi+1
	END
	ELSE DO
		IF UPPER(refdir.refi)<UPPER(transdir.transi) THEN DO	/* missing translation */
			SAY "Missing translation for spell" refdir.refi
			CALL MissingSpell(refdir.refi)
			refi=refi+1	/* do not advance transi, it's already too far ! */
			missingcount=missingcount+1
		END
		IF UPPER(refdir.refi)>UPPER(transdir.transi) THEN DO	/* extra spell */
			SAY "Extra translated spell" transdir.transi
			CALL ExtraSpell(transdir.transi)
			transi=transi+1	/* do not advance refi, it's already too far ! */
			extracount=extracount+1
		END
	END
END

SAY "Done."
SAY casecount "file(s) to be renamed in" TranslationDir
SAY extracount "extra file(s) to be deleted in" TranslationDir
SAY missingcount "missing file(s) in" TranslationDir
IF (~NOSCRIPT)&(MissingOpened|ExtraOpened|CorrectCaseOpened|ArchiveNewSpellsOpened) THEN DO
	SAY "See the generated scripts in" ScriptDir||":"
	IF MissingOpened THEN DO
		SAY "  MissingSpells"
		CALL CLOSE("Missing")
	END
	IF ExtraOpened THEN DO
		SAY "  ExtraSpells"
		CALL CLOSE("Extra")
	END
	IF CorrectCaseOpened THEN DO
		SAY "  CorrectSpellCase"
		CALL CLOSE("Correct")
	END
	IF ArchiveNewSpellsOpened THEN DO
		SAY "  ArchiveNewSpells"
		CALL FlushArchiveNew()
		CALL CLOSE("ArchiveNew")
	END
END

"Delete T:(Trans|Ref)DirList QUIET"

EXIT 0

MissingSpell:	/* MissingSpell(Name) */
	IF NOSCRIPT THEN RETURN
	IF ~MissingOpened THEN DO
		IF ~OPEN("Missing",MissingSpellsPath,"WRITE") THEN DO
			SAY "Unable to open the missing spells script for writing !"
			EXIT 20
		END
		MissingOpened=1
	END
	IF ~ArchiveNewSpellsOpened THEN DO
		IF ~OPEN("ArchiveNew",ArchiveNewSpellsPath,"WRITE") THEN DO
			SAY "Unable to open the ArchiveNewSpells script for writing !"
			EXIT 20
		END
		ArchiveNewSpellsOpened=1
		ArchiveNewLine=""
		ArchiveNewCount=0
	END
	CALL WRITELN("Missing",'Copy "'||AddPart(ReferenceDir,ARG(1))||'" To "'||TranslationDir||'" CLONE')
	CALL WRITELN("Missing",EditorCmd '"'||AddPart(TranslationDir,ARG(1))||'"')
	ArchiveNewLine=ArchiveNewLine '"'||AddPart(ReferenceDir,ARG(1))||'"'
	ArchiveNewCount=ArchiveNewCount+1
	IF ArchiveNewCount>=MaxSpellsToArchiveOnOneLine THEN CALL FlushArchiveNew()
RETURN

FlushArchiveNew:
	IF ArchiveNewCount>0 THEN DO
		CALL WRITELN("ArchiveNew",ArchiverCommand '"'||AddPart(ScriptDir,ArchiveName)||'"' ArchiveNewLine)
		ArchiveNewLine=""
		ArchiveNewCount=0
	END
	RETURN

ExtraSpell:	/* ExtraSpell(Name) */
	IF NOSCRIPT THEN RETURN
	IF ~ExtraOpened THEN DO
		IF ~OPEN("Extra",ExtraSpellsPath,"WRITE") THEN DO
			SAY "Unable to open the extra spells script for writing !"
			EXIT 20
		END
		ExtraOpened=1
	END
	CALL WRITELN("Extra",'Delete "'||AddPart(TranslationDir,ARG(1))||'"')
RETURN

CorrectSpellCase:	/* CorrectSpellCase(WrongName,CorrectName) */
	IF NOSCRIPT THEN RETURN
	IF ~CorrectCaseOpened THEN DO
		IF ~OPEN("Correct",CorrectSpellCasePath,"WRITE") THEN DO
			SAY "Unable to open the correct spell case script for writing !"
			EXIT 20
		END
		CorrectCaseOpened=1
	END
	CALL WRITELN("Correct",'Rename "'||AddPart(TranslationDir,ARG(1))||'" as "'||AddPart(TranslationDir,ARG(2))||'"')
RETURN
