/****************************************************************
   This file was created automatically by `FlexCat 1.5'
   from "Catalogs/krsnake.cd".

   Do NOT edit by hand!
****************************************************************/

OPT MODULE

MODULE 'locale','libraries/locale','utility/tagitem','utility/hooks',
       'tools/installhook'

EXPORT CONST ID_INGAMESTATUS=0
EXPORT CONST ID_INITIALSTATUS=1
EXPORT CONST ID_GAMEOVERSTATUS=2
EXPORT CONST ID_BROKERINFO=3
EXPORT CONST ID_EDITPREFS=4
EXPORT CONST ID_EXCEPTION=5
EXPORT CONST ID_SAVE=6
EXPORT CONST ID_CANCEL=7
EXPORT CONST ID_PREFS=8
EXPORT CONST ID_OPTIONS1=9
EXPORT CONST ID_OPTIONS2=10
EXPORT CONST ID_SOUND=11
EXPORT CONST ID_COLOURS=12
EXPORT CONST ID_PUBSCREEN=13
EXPORT CONST ID_POPKEY=14
EXPORT CONST ID_PRIORITY=15
EXPORT CONST ID_LETHAL180=16
EXPORT CONST ID_APPICON=17
EXPORT CONST ID_APPMENU=18
EXPORT CONST ID_FREESOUNDS=19
EXPORT CONST ID_CONTSOUND=20
EXPORT CONST ID_STARTGAME=21
EXPORT CONST ID_EATFRUIT=22
EXPORT CONST ID_CRASH=23
EXPORT CONST ID_TEST=24
EXPORT CONST ID_BACKGROUND=25
EXPORT CONST ID_SNAKEBODY=26
EXPORT CONST ID_SNAKEHEAD=27
EXPORT CONST ID_FRUIT1=28
EXPORT CONST ID_FRUIT2=29
EXPORT CONST ID_FRUIT3=30
EXPORT CONST ID_FRUIT4=31
EXPORT CONST ID_FILLTYPE=32
EXPORT CONST ID_RGBTYPE=33
EXPORT CONST ID_DATATYPESTYPE=34
EXPORT CONST ID_GRAPHICTYPE=35
EXPORT CONST ID_DRIPEN=36
EXPORT CONST ID_RED=37
EXPORT CONST ID_GREEN=38
EXPORT CONST ID_BLUE=39
EXPORT CONST ID_IMAGE=40
EXPORT CONST ID_FILE=41
EXPORT CONST ID_PEN=42
EXPORT CONST ID_PUBSCREENWINDOW=43
EXPORT CONST ID_PUBSCREENLIST=44
EXPORT CONST MENUID_PROJECT=45
EXPORT CONST MENUID_ABOUT=46
EXPORT CONST MENUID_QUIT=47
EXPORT CONST MENUID_ESC=48
EXPORT CONST ABOUTID_TITLE=49
EXPORT CONST ABOUTID_MAIN=50
EXPORT CONST ABOUTID_WARRANTY=51
EXPORT CONST ABOUTID_CONDITIONS=52
EXPORT CONST ABOUTID_BUTTONS=53
EXPORT CONST ABOUTID_OK=54
EXPORT CONST ERRORID_EXCEPTION=55
EXPORT CONST ERRORID_MEM=56
EXPORT CONST ERRORID_OPEN=57
EXPORT CONST ERRORID_LOCK=58
EXPORT CONST ERRORID_WIN=59
EXPORT CONST ERRORID_LIB=60
EXPORT CONST ERRORID_SCR=61
EXPORT CONST ERRORID_BREAK=62
EXPORT CONST ERRORID_DOUB=63
EXPORT CONST ERRORID_SIG=64
EXPORT CONST ERRORID_CXBR=65
EXPORT CONST ERRORID_OLDKRSNAKELIB=66
EXPORT CONST ERRORID_NOKRSNAKE=67
EXPORT CONST REPLAYID_NOGAME=68
EXPORT CONST REPLAYID_RECORDING=69
EXPORT CONST REPLAYID_PAUSED=70
EXPORT CONST REPLAYID_FINISHED=71
EXPORT CONST REPLAYID_STOP=72
EXPORT CONST HALLID_ENTERNAMETITLE=73
EXPORT CONST HALLID_ENTERNAME=74
EXPORT CONST HALLID_PLAYER=75
EXPORT CONST HALLID_SCORE=76

DEF cat_krsnake:PTR TO catalog

EXPORT PROC getstr(id)
    IF cat_krsnake
        RETURN GetCatalogStr(cat_krsnake,id,getdefstr(id))
    ELSE
        RETURN getdefstr(id)
    ENDIF
ENDPROC

PROC getdefstr(id)
    SELECT 77 OF id
        CASE ID_INGAMESTATUS
           RETURN 'Score:%ld  Next:%ld'
        CASE ID_INITIALSTATUS
           RETURN 'Link size: [%ld,%ld]'
        CASE ID_GAMEOVERSTATUS
           RETURN 'Game over! You scored %ld'
        CASE ID_BROKERINFO
           RETURN 'The snake game'
        CASE ID_EDITPREFS
           RETURN 'Edit preferences...'
        CASE ID_EXCEPTION
           RETURN 'Exception'
        CASE ID_SAVE
           RETURN 'Save'
        CASE ID_CANCEL
           RETURN 'Cancel'
        CASE ID_PREFS
           RETURN 'KRSNAke Preferences'
        CASE ID_OPTIONS1
           RETURN 'Options 1'
        CASE ID_OPTIONS2
           RETURN 'Options 2'
        CASE ID_SOUND
           RETURN 'Sound'
        CASE ID_COLOURS
           RETURN 'Colours'
        CASE ID_PUBSCREEN
           RETURN 'Public Screen'
        CASE ID_POPKEY
           RETURN 'Popkey'
        CASE ID_PRIORITY
           RETURN 'Task Priority'
        CASE ID_LETHAL180
           RETURN '180° turns lethal'
        CASE ID_APPICON
           RETURN 'AppIcon when hidden'
        CASE ID_APPMENU
           RETURN 'AppMenuItem when hidden'
        CASE ID_FREESOUNDS
           RETURN 'Free sound buffers when hidden'
        CASE ID_CONTSOUND
           RETURN 'Play Start Game sound continuously'
        CASE ID_STARTGAME
           RETURN 'Start Game'
        CASE ID_EATFRUIT
           RETURN 'Eat Fruit'
        CASE ID_CRASH
           RETURN 'Crash'
        CASE ID_TEST
           RETURN 'Test'
        CASE ID_BACKGROUND
           RETURN 'Background'
        CASE ID_SNAKEBODY
           RETURN 'Snake body'
        CASE ID_SNAKEHEAD
           RETURN 'Snake head'
        CASE ID_FRUIT1
           RETURN 'Fruit 1'
        CASE ID_FRUIT2
           RETURN 'Fruit 2'
        CASE ID_FRUIT3
           RETURN 'Fruit 3'
        CASE ID_FRUIT4
           RETURN 'Fruit 4'
        CASE ID_FILLTYPE
           RETURN 'Type'
        CASE ID_RGBTYPE
           RETURN 'RGB Colour'
        CASE ID_DATATYPESTYPE
           RETURN 'Datatypes Image'
        CASE ID_GRAPHICTYPE
           RETURN 'KRSNAke Graphic'
        CASE ID_DRIPEN
           RETURN 'System Pen'
        CASE ID_RED
           RETURN 'Red'
        CASE ID_GREEN
           RETURN 'Green'
        CASE ID_BLUE
           RETURN 'Blue'
        CASE ID_IMAGE
           RETURN 'Image'
        CASE ID_FILE
           RETURN 'File'
        CASE ID_PEN
           RETURN 'Pen'
        CASE ID_PUBSCREENWINDOW
           RETURN 'Select a public screen'
        CASE ID_PUBSCREENLIST
           RETURN 'Public Screens'
        CASE MENUID_PROJECT
           RETURN 'Project'
        CASE MENUID_ABOUT
           RETURN 'About...'
        CASE MENUID_QUIT
           RETURN 'Quit'
        CASE MENUID_ESC
           RETURN 'ESC'
        CASE ABOUTID_TITLE
           RETURN 'About KRSNAke'
        CASE ABOUTID_MAIN
           RETURN 'KRSNAke comes with ABSOLUTELY NO WARRANTY;\nfor details click "Warranty".\n\nThis is free software, and you are welcome\nto redistribute it under certain conditions;\nclick "Conditions" for details.'
        CASE ABOUTID_WARRANTY
           RETURN 'This program is distributed in the hope that\nit will be useful, but WITHOUT ANY WARRANTY;\nwithout even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR\nPURPOSE. See the GNU General Public License\nfor more details.'
        CASE ABOUTID_CONDITIONS
           RETURN 'This program is free software; you can\nredistribute it and/or modify it under the\nterms of the GNU General Public License as\npublished by the Free Software Foundation;\neither version 2 of the License, or (at your\noption) any later version.'
        CASE ABOUTID_BUTTONS
           RETURN 'Conditions|Warranty|OK'
        CASE ABOUTID_OK
           RETURN 'OK'
        CASE ERRORID_EXCEPTION
           RETURN 'Program caused exception:'
        CASE ERRORID_MEM
           RETURN ' no memory'
        CASE ERRORID_OPEN
           RETURN ' could not open file %s'
        CASE ERRORID_LOCK
           RETURN ' could not lock file %s'
        CASE ERRORID_WIN
           RETURN ' could not open window %s'
        CASE ERRORID_LIB
           RETURN ' could not open library %s'
        CASE ERRORID_SCR
           RETURN ' could not lock public screen %s'
        CASE ERRORID_BREAK
           RETURN ' ***BREAK'
        CASE ERRORID_DOUB
           RETURN ' ARexx port already exists!'
        CASE ERRORID_SIG
           RETURN ' could not allocate signal'
        CASE ERRORID_CXBR
           RETURN ' could not create commodities broker'
        CASE ERRORID_OLDKRSNAKELIB
           RETURN 'KRSNAke.library revision too old'
        CASE ERRORID_NOKRSNAKE
           RETURN 'Unable to locate KRSNAke!'
        CASE REPLAYID_NOGAME
           RETURN 'No game recorded.'
        CASE REPLAYID_RECORDING
           RETURN 'Recording game...'
        CASE REPLAYID_PAUSED
           RETURN 'Recording paused.'
        CASE REPLAYID_FINISHED
           RETURN 'Press R to replay'
        CASE REPLAYID_STOP
           RETURN 'Press SPACE to stop'
        CASE HALLID_ENTERNAMETITLE
           RETURN 'Hall of Fame!'
        CASE HALLID_ENTERNAME
           RETURN 'Enter your name for the Hall of Fame:'
        CASE HALLID_PLAYER
           RETURN 'Player'
        CASE HALLID_SCORE
           RETURN 'Score'
    ENDSELECT
ENDPROC

EXPORT PROC openCatalog(loc=NIL:PTR TO locale,lang=NIL:PTR TO CHAR)
    closeCatalog()
    IF (localebase) AND (cat_krsnake=NIL)
        cat_krsnake:=OpenCatalogA(loc,'krsnake.catalog',[OC_BUILTINLANGUAGE,'english',
                                               IF lang THEN OC_LANGUAGE ELSE TAG_IGNORE,lang,
                                               OC_VERSION,1,TAG_DONE])
    ENDIF
ENDPROC

EXPORT PROC closeCatalog()
    IF localebase AND cat_krsnake THEN CloseCatalog(cat_krsnake)
    cat_krsnake:=NIL
ENDPROC

OBJECT fnord OF hook
    strptr:PTR TO CHAR
ENDOBJECT

EXPORT PROC lStringF(s,f,d,loc=NIL)
    DEF stuffCharHook:fnord
    installhook(stuffCharHook,{stuffChar})
    stuffCharHook.strptr:=s
    FormatString(loc,f,d,stuffCharHook)
    SetStr(s,StrLen(s))
ENDPROC

PROC stuffChar(hook:PTR TO fnord,loc,c)
    PutChar(hook.strptr,c)
    hook.strptr:=hook.strptr+1
ENDPROC

