**
** Equ.s - Program vars & constant definitions
** Programmed by Peter Bakota, ©1995-96 Tenax Software, All rights reserved.
**

OpenLib		equ	-552
CloseLib	equ	-414
OpenDev		equ	-444
CloseDev	equ	-450
AddPort		equ	-354
RemPort		equ	-360
AllocSig	equ	-330
FreeSig		equ	-336
SendIO		equ	-462
AllocMem	equ	-198
FreeMem		equ	-210
AvailMem 	equ	-216
FindTask	equ	-294
GetMsg		equ	-372
ReplyMsg	equ	-378
WaitPort	equ	-384
Forbid		equ	-132
Permit		equ	-138
Disable		equ	-120
Enable		equ	-126
AddIntServer	equ	-168
RemIntServer	equ	-174
SetFunc		equ	-420

Open		equ	-30
Close 		equ	-36
Read		equ	-42
Write		equ	-48
Seek		equ	-66
Lock		equ	-84
UnLock		equ	-90
DupLock		equ	-96
CurrDir		equ	-126
IoErr		equ	-132
ParentDir	equ	-210

OwnBlitter	equ	-456
DisownBlitter	equ	-462
WaitBlit 	equ	-228

LoadView 	equ	-222
WaitTOF		equ	-270

OpenScreen	equ	-198
CloseScreen 	equ	-66
AutoReq		equ	-348
WBToFront	equ	-342
WBToBack	equ	-336

NT_MSGPORT	EQU	4

mp_Type		equ	8
mp_Pri		equ	9
mp_Name		equ	10
mp_SigBit	equ	15
mp_Task		equ	16
mp_SIZEOF	equ	34

CMD_ADDINTSERVER EQU	$9	;for input.device
CMD_REMINTSERVER EQU	CMD_ADDINTSERVER+1

IOF_QUICK	EQU	1

RAWK_A		EQU	$20

io_ReplyPort	equ	14
io_Device	equ	20
io_Command	equ	28
io_Flags	equ	30
io_Error	equ	31
io_Data		equ	40
io_SIZEOF	equ	48

ie_Next		equ	0
ie_Class	equ	4
ie_Code		equ	6
ie_Qualify	equ	8

IE_RAWKEY	equ	1
IE_RAWMOUSE	equ	2

is_Type		equ	8
is_Pri		equ	9
is_Data		equ	14
is_Code		equ	18
is_SIZEOF	equ	22

bm_SIZEOF	equ	40

CallGfx	MACRO
	move.l	GfxBase(a5),a6
	jsr	\1(a6)
	ENDM

CallInt	MACRO
	move.l	IntuiBase(a5),a6
	jsr	\1(a6)
	ENDM

CallSys	MACRO
	move.l	4.w,a6
	jsr	\1(a6)
	ENDM

CallDOS	MACRO
	move.l	DosBase(a5),a6
	jsr	\1(a6)
	ENDM

clc	MACRO
	and.b #$fe,ccr
	ENDM

sec	MACRO
	or.b	#1,ccr
	ENDM

MakeFx	MACRO
	lea	\1(pc),a1
	bsr	PlayFx
	ENDM

MakeA1Fx MACRO
	move.l	a1,-(sp)
	lea	\1(pc),a1
	bsr	PlayFx
	move.l	(sp)+,a1
	ENDM

MakeSpecialFx MACRO
	movem.l	d0/a1,-(sp)
	lea	\1(pc),a1
	move.l	#\2,d0
	bsr	PlaySpecialFx
	movem.l	(sp)+,d0/a1
	ENDM

MakeBankFx MACRO
	move.l	d0,-(sp)
	moveq	#\1,d0
	bsr	PlayBankFx
	move.l	(sp)+,d0
	ENDM
	
PALSAMPLERATE EQU 3546894	; PAL=3546894, NTSC=3579545

SETRATE	MACRO
	dc.w	\1
	dc.w	(\1*1000000)/PALSAMPLERATE
	ENDM
	
CallMusic MACRO
	move.l	MusicBase(a5),a0
	jsr	\1(a0)
	ENDM

ciaa	equ	$bfe001		;CIA registers base address!
ciab	equ	$bfd000

ACCESS_READ	EQU	-2
MODE_OLDFILE	EQU	1005
MODE_NEWFILE	EQU	1006

OFFSET_BEGINING EQU	-1
MOTORDELAY	EQU	200	;Delay for disk motor off!

TFSFILENAME	MACRO
		dc.b	"TB.Data",0	;TFS data file name!
		ENDM

CFGFILENAME	MACRO
		dc.b	"TB.Cfg",0	;Config file nev!
		ENDM

DEFSBKNAME	MACRO
		dc.b	"Def.Sbk",0	;Default SBK name!
		ENDM

PRPASSCODE	MACRO
		dc.b	"UNLOCKME",$d
		ENDM
		
MAXTFSFILES 	EQU	48	;Max. Files in TFS data file!

mt_init		equ	0
mt_end		equ	mt_init+4
mt_music 	equ	mt_end+4

MEMF_PUBLIC	EQU	$1	;Memory flags!
MEMF_CHIP	EQU	$2
MEMF_FAST	EQU	$4
MEMF_CLEAR	EQU	$10000
MEMF_LARGEST	EQU	$20000

bitMUSICOK	equ	0	;System flags!
bitPASSOK	equ	1	; PASSWORD OK!

LIBVER		equ	34	;Low library version (WB 1.3)
gb_OldCop	equ	$26	;graphics.library copper list ptr!

COPPERLISTSIZE	EQU	1*1024	;Copper/Data buffer size
ScreenSIZEOF	EQU	42*256	;Main screen sizeof

REG_Process 	EQUR	A2	;for WB start!
pr_MsgPort	EQU	92
pr_CLI		EQU	172
pr_WindowPtr	EQU	184

; for find & set command directory!
sm_ArgList	equ	36
wa_Lock		equ	0
cli_CommandName	equ	16

fl_Volume	equ	16
dl_Name		equ	40

***************************************************************************
********************************************** Program definitions!
***************************************************************************

GyASTRO		EQU	0
GyBABY		EQU	1
GyBARTSIMPSON	EQU	2
GyCHINESE	EQU	3
GyCOOLGUY	EQU	4
GyCRAZYGUY	EQU	5
GyDEVIL		EQU	6
GyDIVER		EQU	7
GyDOCTOR	EQU	8
GyDRACULA	EQU	9
GyFRANKY	EQU	10
GyKING		EQU	11
GyMARTIAN	EQU	12
GyMUMMY		EQU	13
GyNINJA		EQU	14
GyPEASANT	EQU	15
GyPOLICEMAN	EQU	16
GyROBINHOOD	EQU	17
GySOLDIER	EQU	18
GyTARZAN	EQU	19
GyWORKER	EQU	20

MAXGUYS		EQU	21	;Set to LASTGUY+1

AREAX 		EQU	21
AREAY 		EQU	15
OBJECTSNB	EQU	6*20
BOBSNB		EQU	5*30
MAXBOBS		EQU	8

ATOMW		equ	7	;Az atom bomba zonaja
ATOMH		equ	7

DEFAULTBOMBTIME		EQU 120	 ;Normal bomba idozitese
DEFAULTALARMTIME 	EQU 5000 ;Az "alarm" idozitese
DEFAULTSHRINKTIME 	EQU 160  ;A shrink megkezdese
DEFAULTWINTIME		EQU 300  ;A jatekos kitartasa
DEFAULTSTOPTIME		EQU 120	 ;"Stop" ido
DEFAULTCTRLSWAPTIME	EQU 120	 ;"Control Swap" time
DEFAULTNIGHTTIME	EQU 1000 ;A sotetedes ideje
DEFAULTNIGHTDEPTH	EQU 10   ;A sotetedes "melysege"
DEFAULTFADESPEED	EQU 2	 ;A sotetedes sebessege (Fade-out)
DEFAULTPROTTIME		EQU 100	 ;A protection villogas ido
DEFAULTPACMANTIME	EQU 300	 ;PacMan "ido"
DEFAULTBETEGTIME	EQU 500  ;betegseg idozites
DEFAULTICETIME		EQU 300	 ;Megfagyas idozites!

;********** Enemy definicio ******************

MAXENEMYFRAMES		EQU 21
ENEMYSPRITESIZE		EQU 192
ENEMYDATASIZE		EQU MAXENEMYFRAMES*ENEMYSPRITESIZE
ENEMYHEIGHT		EQU 22
SPRITE2OFFSET		EQU ENEMYHEIGHT*4+8

MAXENEMYDCOUNT		EQU 4	;Maximum mozgas egy iranyban!

		rsreset
enX		rs.w	1
enY		rs.w	1
enDCount	rs.w	1
enASpeed	rs.w	1
enDirection	rs.b	1
enFlags		rs.b	1
enFazis		rs.w	1
enIData		rs.w	1
enSprite	rs.l	1
enSIZEOF	equ	__RS

edDown		equ	0
edRight		equ	1
edUp		equ	2
edLeft		equ	3

bitENEMYKILLED	EQU	0
bitENEMYKSEQ	EQU	1

;*** Bob definicio ****
		rsreset
bobX		rs.w	1
bobY		rs.w	1
bobASpeed	rs.w	1
bobFazisHi	rs.b	1
bobFazisLo	rs.b	1
bobFlags 	rs.w	1
bobImage 	rs.l	1
bobSIZEOF	equ	__RS

;*** Player definicio ***
		rsreset
plName		rs.b	8	;A jatekos neve!
plPlayerID	rs.b	1	;playerID!
plControl	rs.b	1	;Control method
plKeyboard	rs.b	5	;Keyboard keys (if plControl == ctKeyb!!!)
plJoystick	rs.b	1	;Actual joystick position
plBob 		rs.l	1	;bob
plFlags		rs.l	1	;flags
plSbk		rs.w	1	;Player's sample bank (0..5)
plGuyImage	rs.b	1	;Actual guy image number!
plTeam		rs.b	1	;Player's team (0 or 1)
plMoney		rs.w	1	;money
plWinTime	rs.w	1	;A jatekos gyozelmei!
plVars		equ	__RS
plColBits	rs.b	1	;Collosion bits
plColMask	rs.b	1	;Mask for collosion bits
plBetegseg	rs.w	1	;Betegsegek amelyek atadhatok!
plBetCount	rs.w	1	;A betegseg szamlaloja!
plBombCount 	rs.w	1	;lerakott bombak szmalaloja!
plBombTime	rs.w	1	;a lerakott bomba idozitese a robbanashoz! (timebomb)
plStopCount 	rs.w	1	;ha STOP akkor ez a szamlalo!
plCSwapCount	rs.w	1	;Ha CtrlSwap akkor ez a count!
plProtCount 	rs.w	1	;A protection villogas count!
plPMCount	rs.w	1	;PacMan counter
plIceCount	rs.w	1	;"IceMan" counter
plCBOffset	rs.w	1	;A controled bomba offsetje!
plBomb		rs.w	1	;bombs
plPower		rs.w	1	;power
plSpeed		rs.w	1	;speed
plSIZEOF 	equ	__RS

; Keyboard kontrol
kbDown		equ	0
kbRight		equ	1
kbUp		equ	2
kbLeft		equ	3
kbFire		equ	4

bitDown		equ	0
bitRight 	equ	1
bitUp 		equ	2
bitLeft		equ	3
bitFire		equ	4

; Control type

ctJoy0		equ	0	;Joystick port #1 (Mouse port!)
ctJoy1		equ	1	;Joystick port #2
ctJoy2		equ	2	;Paralel #1
ctJoy3		equ	3	;Paralel #2
ctKeyb		equ	4	;Keyboard

* Player flags	(BYTE 0)
bitFREEZED	equ	1
bitCTRLSWAP	equ	2
bitSTOP		equ	3
bitSUPERMAN 	equ	4
bitCONTROLER	equ	5
bitATOMBOMB	equ	6
bitTIMEBOMB 	equ	7

*		(BYTE 1)
bitPROTECTION	equ	8
bitGHOST 	equ	9
bitPACMAN	equ	10
bitICEMAN	equ	11
bitTHIEF	equ	12
bitOUT		equ	13
bitDEAD		equ	14
bitKILLSEQ	equ	15

*		(BYTE 2)
bitSELECTED	equ	16

* Betegsegek
btNEMBETEG	equ	0
btNOBOMB	equ	1	;Nembir lerakni bombat
btMICROBOMB	equ	2	;micro bomb
btFIREON	equ	3	;allandoan lenyomva a FIRE
btPERSONSWAP	equ	4	;szemelyiseg csere
btBACHUS	equ	5	;meg a leg lassabtol is lassab!
btSPRINTER	equ	6	;sprinter meg a leg gyorsabtol is gyorsabb

MAXBETEGSEG	equ	7	;A betegsegek szama


; A lerakot bomba/explode valzozoi
		rsreset
bcPlayerID	rs.b	1
bcCount		rs.b	1	;(Bomba idozites (1-255))
bcSIZEOF 	equ	__RS

; Animacios valtozok!
		rsreset
anType		rs.w	1	;Tipus (bomba, fal, robbanas, stb.)
anFazis		rs.b	1	;Fazis szamlalo
anACount 	rs.b	1	;Animacios sebesseg!
anSIZEOF 	equ	__RS

;Animacios kodok
anEXPLODE	equ	0
anKEMENY 	equ	1
anBOMBA		equ	2
anSHRINK 	equ	3
anTEGLA		equ	4
anTEGLAM1	equ	5
anTEGLAM2	equ	6
anTEGLAM3	equ	7
anTEGLAM4	equ	8
anTEGLAM5	equ	9
anTEGLAM6	equ	10
anTEGLAM7	equ	11
anTEGLAM8	equ	12
anBOMBAM1	equ	13
anBOMBAM2	equ	14
anBOMBAM3	equ	15
anBOMBAM4	equ	16
anBOMBAM5	equ	17
anBOMBAM6	equ	18
anBOMBAM7	equ	19
anBOMBAM8	equ	20
anBOMBB		equ	21
anBOMBBM1	equ	22
anBOMBBM2	equ	23
anBOMBBM3	equ	24
anBOMBBM4	equ	25
anBOMBBM5	equ	26
anBOMBBM6	equ	27
anBOMBBM7	equ	28
anBOMBBM8	equ	29

*  0 = Explode #1	30 = Wall explode #2	60 = Bomb L/R #1/Team A	90 = Bomb U/D #3/Team B
*  1 = Explode #2	31 = Wall explode #3	61 = Bomb L/R #2/Team A	91 = Bomb U/D #4/Team B
*  2 = Explode #3	32 = Wall explode #4	62 = Bomb L/R #3/Team A	92 = Bomb U/D #5/Team B
*  3 = Explode #4	33 = Wall explode #5	63 = Bomb L/R #4/Team A	93 = Bomb U/D #6/Team B
*  4 = Explode #5	34 = Bomb #1 - Team A	64 = Bomb L/R #5/Team A	94 = Bomb L/R #1/Team B
*  5 = Explode #6	35 = Bomb #2 		65 = Bomb L/R #6/Team A	95 = Bomb L/R #2/Team B
*  6 = Crash Wall	36 = Bomb #3		66 = <Icer>		96 = Bomb L/R #3/Team B
*  7 = Crash Wall #1	37 = Constant brick	67 = <Teleport>		97 = Bomb L/R #4/Team B
*  8 = Crash Wall #2	38 = Wall		68 = <Vizard>		98 = Bomb L/R #5/Team B
*  9 = Crash Wall #3	39 = <Bomb>		69 = <First Aid>	99 = Bomb L/R #6/Team B
* 10 = Crash Wall #4	40 = <Power>		70 = <Detonator>	100=
* 11 = Crash Wall #5	41 = <Superman>		71 = <Racs>
* 12 = Crash Wall #6	42 = <Controler>	72 = <Foot ball>
* 13 = Serleg		43 = <Protection>	73 = <Pac-Man>
* 14 = Wall L/R #1	44 = <Ghost>		74 = <Sequeez>
* 15 = Wall L/R #2	45 = <Person Swapper>	75 = <Tenis>
* 16 = Wall U/D #1	46 = <Speed>		76 = <Money Bag>
* 17 = Wall U/D #2	47 = <Skull>		77 = <Thief>
* 18 = <Empty color 0>	48 = <?>		78 = <Empty color 0>
* 19 = <Empty color 0>	49 = <Time bomb>	79 = <Empty color 0>
* 20 = Shrink #1	50 = <Stop>		80 = Constant brick #1
* 21 = Shrink #2	51 = <Money>		81 = Constant brick #2
* 22 = Shrink #3	52 = <Empty BKG>	82 = Constant brick #3
* 23 = Shrink #4	53 = <Empty color 0>	83 = Constant brick #4
* 24 = Shrink #5	54 = Bomb U/D #1/Team A	84 = Constant brick #5
* 25 = <Vortex>		55 = Bomb U/D #2	85 = Bomb #1 - Team B
* 26 = <Control Swap>	56 = Bomb U/D #3	86 = Bomb #2 - Team B
* 27 = <Atom bomb>	57 = Bomb U/D #4	87 = Bomb #3 - Team B
* 28 = <Night play>	58 = Bomb U/D #5	88 = Bomb U/D #1/Team B
* 29 = Wall explode #1	59 = Bomb U/D #6	89 = Bomb U/D #2/Team B

; A blokk kodok!
blURES		equ	52
blFAL 		equ	37
blTEGLA		equ	38
blEXPLODE	equ	0
blKEMENY 	equ	6
blSHRINK 	equ	20
blWEXPLODE	equ	29

blBOMBA		equ	34 ;34,35,36
blBOMBAUD 	equ	54
blBOMBALR	equ	60

blBOMBB		equ	85 ;85,86,87
blBOMBBUD 	equ	88
blBOMBBLR	equ	94

blVORTEX	equ	25
blCTRLSWAP	equ	26
blATOMBOMB	equ	27
blNIGHT		equ	28
blEXTRABOMB	equ	39
blPOWER		equ	40
blSUPERMAN	equ	41
blCONTROLER 	equ	42
blPROTECTION	equ	43
blGHOST		equ	44
blPERSWAP	equ	45
blSPEED		equ	46
blSKULL 	equ	47
blRANDOM 	equ	48
blTIMEBOMB	equ	49
blSTOP		equ	50
blMONEY		equ	51
blICEMAN	equ	66
blTELEPORT	equ	67
blVIZARD	equ	68
blFIRSTAID	equ	69
blDETONATOR	equ	70
blFOOTBALL	equ	72
blPACMAN	equ	73
blSQUEEZE	equ	74
blTENIS		equ	75
blMONEYBAG	equ	76
blLOPO		equ	77

blCOLOR0 	equ	53
blSERLEG	equ	13
blCBRICKS	equ	80

exKERET		equ	-1		* A keret kodja az ATOM BOMBA vegett!

******************************** Global flags
; GlobalFlags (Preferences byte)
bitGAMBLING 	equ	0
bitSHRINKING	equ	1
bitSHOP		equ	2
bitTIMELIMIT	equ	3
bitFASTIG	equ	4
bitMUSICON	equ	5

;              (Effects byte)
bitNIGHT	equ	8
bitATOMEXPLODE	equ	9
bitGAMEEND	equ	10
bitENEMYSTOP	equ	11

;Level codes
lcNORMAL 	equ	0
lcMAD 		equ	1
lcNOWALLS	equ	2
lcRANDOM 	equ	3

****************** Soundfx defs!
fxEXPLODE	EQU	1
fxOLALA		EQU	2
fxEXTRO		EQU	3
fxMAIN		EQU	4
fxALARM		EQU	5
fxSUPER		EQU	6
fxLASER		EQU	7
fxGHOST		EQU	8
fxTIMEB		EQU	9
fxMONEY		EQU	10
fxTELEPORT	EQU	11
fxCOUNT		EQU	12

;fxYEAH		EQU	5
;fxGO		EQU	10
;fxTHIEF	EQU	14
;fxDAME		EQU	16
;fxHEY		EQU	17

MAXSAMPLES	EQU	12	;Set to last sample

		rsreset
fxSample 	rs.b	1
fxVolume 	rs.b	1
fxPeriod 	rs.w	1
fxRate		rs.w	1
fxSIZEOF 	equ	__RS

;Effect info!
		rsreset
eiStart		rs.l	1
eiLength 	rs.w	1
eiSIZEOF 	equ	__RS

bfxDEAD		EQU	0	;"Dead" Fx
bfxPROTECTION	EQU	1	;"Protection" Fx
bfxTHIEF	EQU	2	;"Thief" Fx
bfxATOMBOMB	EQU	3	;"Got an aotm bomb" Fx
bfxDISEASES	EQU	4	;"Got an diseases" Fx
bfxGO		EQU	5	;"Speed up!" Fx

BANKFXSTART	EQU	MAXSAMPLES+1
MAXBANKFX	EQU	6	;Set to max. bank fx

***************************************************************************
****          Variables for Game pointed by A5 register!               ****
***************************************************************************

		rsreset
; SystemVars
SystemSP 	rs.l	1
PSP		rs.l	1
GfxBase		rs.l	1
IntuiBase	rs.l	1
DosBase		rs.l	1
ThisTask 	rs.l	1
oldprWindow 	rs.l	1
OldDir		rs.l	1
oldAReq		rs.l	1
FScreen		rs.l	1
SysPlaneA	rs.l	1
SysPlaneB	rs.l	1
SysPlaneC	rs.l	1
IntEnabled	rs.w	1
MotorFlag	rs.w	1
MotorCnt	rs.w	1
RndSeed		rs.l	1
BeamCount	rs.l	1
PRFlag		rs.w	1
PRPtr		rs.l	1
SysFlags	rs.w	1	;System flags (MEGACHIP, MC68020, etc.)
MainVolume	rs.b	80	;Main disk volume name! (for RESTORE TB DISK...)

;Copperlist vars
LastCopperList 	rs.l	1
CopperListA 	rs.l	1
CopperListB 	rs.l	1
copPlanes	rs.l	1
copPaletta	rs.l	1
copReg102 	rs.l	1
copSprites	rs.l	1
copJmpPtr	rs.l	1
PlaneA		rs.l	1
PlaneB		rs.l	1
PlaneC		rs.l	1

; Memory variables
SysLocMem	rs.l	1
SysLocLen	rs.l	1
SysExtMem	rs.l	1
SysExtLen	rs.l	1

MaxLocMem	rs.l	1
LowLocMem	rs.l	1
LocTop		rs.l	1

MaxExtMem	rs.l	1
LowExtMem	rs.l	1
ExtTop		rs.l	1

;Interrupt/System vars
Interrupt68 	rs.b	is_SIZEOF
Interrupt6c 	rs.b	is_SIZEOF
IEIOReq		rs.b	io_SIZEOF
IEInterrupt	rs.b	is_SIZEOF
Old68 		rs.l	1
Old6c 		rs.l	1
s96		rs.w	1
s9a		rs.w	1
SystemFlag	rs.w	1	({0}=System DISABLED! {-1}=System ENABLED!)

;Music vars
MusicEnabled	rs.w	1
MusicBase	rs.l	1
MusicData	rs.l	1
MusicLength	rs.l	1

; KeyboardVars
KBMatrix 	rs.b	128
KBLastK		rs.b	1
KBRaw 		rs.b	1

;TFS data system vars
TFSHandler	rs.l	1
TFSData		rs.l	1
TFSHeader	rs.b	8+MAXTFSFILES*8

;Blaster text vars
BSpeed		rs.w	1
BlasterCnt	rs.w	1
BTextPtr 	rs.l	1
BlasterPlaneA	rs.l	1
BlasterPlaneB	rs.l	1

;"Night" effect variables
NightCount	rs.w	1
FadeCount	rs.w	1
FadeSpeed	rs.w	1

;"AtomExplode" effect vars
AtomCount	rs.w	1

;Audio vars
FxCounters	rs.w	4
FXChanel 	rs.l	1
DMAReg		rs.w	1
SampleInfo	rs.b	eiSIZEOF*MAXSAMPLES
Bank0Info	rs.b	eiSIZEOF*MAXBANKFX
Bank1Info	rs.b	eiSIZEOF*MAXBANKFX
Bank2Info	rs.b	eiSIZEOF*MAXBANKFX
Bank3Info	rs.b	eiSIZEOF*MAXBANKFX
Bank4Info	rs.b	eiSIZEOF*MAXBANKFX
Bank5Info	rs.b	eiSIZEOF*MAXBANKFX

;Sound banks def
Bank0Fx		rs.b	fxSIZEOF*MAXBANKFX
Bank1Fx		rs.b	fxSIZEOF*MAXBANKFX
Bank2Fx		rs.b	fxSIZEOF*MAXBANKFX
Bank3Fx		rs.b	fxSIZEOF*MAXBANKFX
Bank4Fx		rs.b	fxSIZEOF*MAXBANKFX
Bank5Fx		rs.b	fxSIZEOF*MAXBANKFX
Bank1Name	rs.b	16
Bank2Name	rs.b	16
Bank3Name	rs.b	16
Bank4Name	rs.b	16
Bank5Name	rs.b	16

;Global flags variable
GlobalFlags 	rs.l	1

;Options/Shop vars
SetUpItems	rs.l	1
OPNumber 	rs.w	1
OPLastStick 	rs.b	1
		rs.b	1
Brick		rs.w	1
WinsNeeded	rs.w	1
StartMoney	rs.w	1
LevelCode	rs.w	1
CrLevel		rs.w	1
TeamMode	rs.w	1
GhostsNb	rs.w	1
LastGImage	rs.b	6

GBPlayers	rs.l	5
WinPlayers	EQU	GBPlayers

;Alarm/Shrink vars
AlarmCount	rs.w	1
AlarmDX		rs.w	1
AlarmCReg	rs.w	1
ShrinkSpeed	rs.w	1
ShrinkCount	rs.w	1

; Enemy vars
EStopCount	rs.w	1
Enemy1DEF	rs.b	enSIZEOF
Enemy2DEF	rs.b	enSIZEOF
Enemy3DEF	rs.b	enSIZEOF
Enemy4DEF	rs.b	enSIZEOF
Enemy1Data	rs.l	1
Enemy2Data	rs.l	1
Enemy3Data	rs.l	1
Enemy4Data	rs.l	1

; Draw bob vars
ObjectsData 	rs.l	1
ObjectsAddress 	rs.l	OBJECTSNB
BobOffsets	rs.l	BOBSNB
GhostImage	rs.l	1
PacManData	rs.l	1
PacManMask	rs.l	1
BobMask		rs.l	1
BobData		rs.l	1
BobSaveA 	rs.l	1
BobSaveB 	rs.l	1
NewBobPtr	rs.l	1
NewBobs		rs.l	MAXBOBS
SaveBuf1 	rs.l	MAXBOBS*2
SaveBuf2 	rs.l	MAXBOBS*2

;Blocks draw vars
BlockSpare	rs.b	AREAX*AREAY*6+6
CliCommandName	equ	BlockSpare
CfgBuffer	equ	BlockSpare
SBHeader	equ	BlockSpare

AreaB1		rs.l	1
AreaB2		rs.l	1

;Block animations vars
AnimationsTab	rs.b	anSIZEOF*AREAX*AREAY

; GameVars

WinnerIs	rs.w	1
WinnerCount	rs.w	1
EndOfGame	rs.w	1
PlayersTB	rs.l	5
Player1DEF	rs.b	plSIZEOF
Player2DEF	rs.b	plSIZEOF
Player3DEF	rs.b	plSIZEOF
Player4DEF	rs.b	plSIZEOF
Player5DEF	rs.b	plSIZEOF

BobPlayer1	rs.b	bobSIZEOF
BobPlayer2	rs.b	bobSIZEOF
BobPlayer3	rs.b	bobSIZEOF
BobPlayer4	rs.b	bobSIZEOF
BobPlayer5	rs.b	bobSIZEOF

BombArea 	rs.b	bcSIZEOF*AREAX*AREAY

AreaA 		rs.b	AREAX*AREAY
AreaA1		rs.b	AREAX*AREAY
AreaA2		rs.b	AREAX*AREAY
Extras		rs.b	AREAX*AREAY

DataLong 	equ	__RS

