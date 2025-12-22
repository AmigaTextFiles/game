
;                             CYBER-INT LIBRARY               22 Mar 1993
	bra.w	INTERRUPT	;
	bra.w	SET_UP		;At start of game..PILLs/GV?s/
	bra.w	CYBER_INT	;
	bra.w	GHOST_INT	;
	bra.w	GAME_INT	;

; END of CYBER-DRAW library
****************************************************************************
****************************************************************************
; DEF_TAB.asm                                                 22 Mar 1993
;
; indirizzi TABELLE usate da CYBER-MAN

BLIMIT0		= $0000		;.B (BDIST)
BLIMIT1		= $0010		;.B (BDIST)
L5		= $0090		;.B = L5 (RLINE)
L4		= $0490		;.B = L4 (RLINE)
L3		= $0890		;.B = L3 (RLINE)
L2		= $0c90		;.B = L2 (RLINE) non usato!
L1		= $1090		;.B = L1 (RLINE)
L0		= $1490		;.B = L0 (RLINE) non usato!
PX		= $1890		;.W = PX  (BRX,RLINE)
BORDER0		= $5890		;.B = Usato per ricavare BCODE / PR= 0..31
BORDER1		= $5990		;.B = Usato per ricavare BCODE / PR=32..63
WAVE_LIST	= $5a90		;.B ( wave 0,1,2,3 )
MASK_LEFT	= $5ad0		;.W = MASK_LEFT  per RECTANGLE AFWM
MASK_RIGHT	= $5af0		;.W = MASK_RIGHT per RECTANGLE ALWM

; $5b10		= VAR.asm	; vedi il FILE 'VAR.asm'
; $5e00		= VAR_INT.asm	; vedi il FILE 'VAR_INT.asm'

WHICH_LEVEL	= $6000		;.B = MAP localizzazione 4K
; $7000-$7400	= COPPER	;|||||| PER LO SVILUPPO COPPERLIST ||||||
Mul_Y		= $7400		;.W = Addr_Y*44 (Y)
OBJ_E		= $7650		; Rotate 4 Bits...
OBJ_S		= $7660		; Rotate 4 Bits...
OBJ_W		= $7670		; Rotate 4 Bits...
HIGH_SKY	= $7680		;.B = TAB(H) altezza CYBER/16 per SKY
; $7780-$7900	=  ---Empty!---	; 288 bytes ($120)
ENEMYes_BAK	= $7800		; 25/32 GHOST STRUCT SetUp
ENEMYes		= $7A80		; 25/32 GHOST STRUCT Game
JUMP_SHORT	= $7D00		; 128 bytes
JUMP_MID	= $7D80		; 256 bytes
JUMP_LONG	= $7E80		; 384 bytes
;PY		= $8000		;.W = (H,RLINE) --- H=64..255 / DIST=0..255

; END of DEF_TAB.asm
****************************************************************************
; VAR_INT.asm                                                 22 Mar 1993
;  dichiarazione VARIABILI usate dall'INTERRUPT di CYBER_MAN
;   default = .W

THISM		= $5e00	; il Joy attuale
LASTM		= $5e02	; il Joy precedente
M		= $5e04	; movimento attuale
MLEFT		= $5e06	; JoyLEFT
MRIGHT		= $5e08	; JoyRIGHT
MDOWN		= $5e0a	; JoyDOWN
SALTA		= $5e0c	; FLAG ..0=non salta \ 1=SHORT \ 2=MID \ 3=LONG
JUMP		= $5e0e	; --- FASE DI SALTO ---
BX		= $5e10	; blocco X dove si trova CYBER
BY		= $5e12	;    "   Y   "   "   "     "
PBX		= $5e14	; 0..63 posizione X dentro il blocco
PBY		= $5e16	; 0..63     "     Y    "    "    "
ALPHA		= $5e18	; 0..NORTH \ 1..EAST \ 2..SOUTH \ 3..WEST
VX		= $5e1a	; coordinata assoluta X di CYBER
VY		= $5e1c	;      "         "    Y  "   "
TYPE		= $5e20	; contiene il TYPE del blocco dove e' CYBER
OBJ		= $5e22	;     "     "  OBJ  "     "     "  "    "
UP		= $5e24	; contiene il TYPE sopra CYBER
LE		= $5e26	;     "     "   "  a sinistra di CYBER
RI		= $5e28	;     "     "   "  a destra di CYBER
DW		= $5e2a	;     "     "   "  sotto CYBER
SUPERPILL	= $5e2c	; conta i VB durante ' FANTASMI mangiabili '
GHOSTSTOP	= $5e2e	; conta i VB durante ' STOP FANTASMI '
DEVIL		= $5e30	; conta i VB durante ' DIAVOLO rubaenergia '
ANGEL		= $5e32	; conta i VB durante ' ANGELO imbattibile '
POWERJUMP	= $5e3e	; da immettere in SALTA
SPEED		= $5e40	; velocita' corrente di CYBER ( VEDI SLOW/FAST/QUICK )
VELOCITY	= $5e42	; velocita' settata di CYBER ( senza JOYUP )
H		= $5e44	; altezza CYBER
LEVEL		= $5e46	; current level (1..5) or 0=OUT 
PILLS_1		= $5e48	;.B contiene il numero di pillole del LIVELLO 1
PILLS_2		= $5e49	;.B contiene il numero di pillole del LIVELLO 2
PILLS_3		= $5e4a	;.B contiene il numero di pillole del LIVELLO 3
PILLS_4		= $5e4b	;.B contiene il numero di pillole del LIVELLO 4
PILLS_5		= $5e4c	;.B contiene il numero di pillole del LIVELLO 5
GFAIL		= $5e4e	;BYTE! -comune per TUTTI i GHOST
GLAST		= $5e4f	;BYTE! -comune per TUTTI i GHST
REMCYBER	= $5e50	;LONG! -puntatore GHOST MAP precedente al CYBER attuale
GAMEOVER	= $5e54	;BYTE! -FLAG (NORMAL=0/Game Over=1)
ENDGAME		= $5e55	;BYTE! -FLAG (NORMAL=0/End Game=1)
GHOST_OVERLAY	= $5e56	;BYTE! ---- FLAG (usato internamente)
WELCOMED	= $5e57	;BYTE! ---- FLAG (gia' chiusa porta?)

;OFFSET rispetto a RG_STRUCT
RGVX		= 0	;WORD! =GVX
RGVY		= 2	;WORD! =GVY
RGALPHA		= 4	;BYTE! =GALPHA
RGBAD		= 5	;BYTE! =BAD
RGFACE		= 6	;BYTE! =per GHOST DRAW
RGCTRL		= 7	;BYTE! =GCONTROL

;OFFSET rispetto a STRUCT_GHOST -->reg.A1
GVX		= $0	;WORD!
GVY		= $2	;WORD!
GSPEED		= $4	;WORD!
GALPHA		= $6	;BYTE!
GBAD		= $7	;BYTE! --- AGGRESSIVO
GLIBERO		= $8	;BYTE!
GGHOST		= $9	;BYTE!
GCYBER		= $a	;BYTE!
GLIBEROV	= $b	;BYTE! --- VULNERABILE
GGHOSTV		= $c	;BYTE! --- VULNERABILE
GCYBERV		= $d	;BYTE! --- VULNERABILE
GFACE		= $e	;BYTE! per CYBER_DRAW shape del GHOST
GCONTROL	= $f	;BYTE! bit 0=VULNERABILE (if=1)

; ---- ESTERNI ----
ADDRESS_MAP	= $5ba4	;LONG WORD!   --- COMUNE A CYBER DRAW (!!!)
TURNSPEED	= $5e4d	;BYTE! --- usato da TURN --- comune a CYBER DRAW (!!!)
PAUSE		= $5e1e	;BYTE! INPUT stop interrupt - COMUNE A CYBER DRAW (!!!)
GPAUSE		= $5e1f	;BYTE! INPUT stop interrupt - COMUNE A CYBER DRAW (!!!)
WAVS		= $5c0c	;WORD! COMUNE A CYBER DRAW (!!!)
VB		= $5e34	; LONG WORD!  .. conta i VB ( PAUSA = stop! )
SCORE		= $5e38	; LONG WORD!  .. contiene i PUNTI
ENERGY		= $5e3c	; quantita' ENERGIA di CYBER..
BLEEDING	= $5c3a	;BYTE! ---- FLAG (fa diventare lo schermo rosso)
RADAR		= $5c3b	;BYTE! ---- FLAG (1=RADAR acceso)
RADAR_PT	= $5c3c ; LONG! - puntatore dati SPRITE
CHEAT_E		= $5c42	;WORD!
CHEAT_L		= $5c44	;WORD!
CHEATED		= $5c46	;BYTE!
WELL_DONE_CNT	= $5c47	;BYTE!

; ---- AUDIO ----
	rsset	$5d00
AUDIO_PT	rs.l	1	;LONG! Puntatore BASE Audio

WIND_PT		rs.l	1	;LONG! Puntatore indirizzo suono WIND
BACK_PT		rs.l	1	;LONG! Puntatore indirizzo suono BACK
ALARM_PT	rs.l	1	;LONG! Puntatore indirizzo suono ALARM
ANGEL_PT	rs.l	1	;LONG! Puntatore indirizzo suono ANGEL
DEVIL_PT	rs.l	1	;LONG! Puntatore indirizzo suono DEVIL
EAT_PT		rs.l	1	;LONG! Puntatore indirizzo suono EAT
BLEEDING_PT	rs.l	1	;LONG! Puntatore indirizzo suono BLEEDING
CASHING_PT	rs.l	1	;LONG! Puntatore indirizzo suono CASHING
WELCOME_PT	rs.l	1	;LONG! Puntatore indirizzo suono WELCOME
ENDLEVEL_PT	rs.l	1	;LONG! Puntatore indirizzo suono ENDLEVEL
BONUS_PT	rs.l	1	;LONG! Puntatore indirizzo suono BONUS
EMPTY_PT	rs.l	1	;LONG! Puntatore indirizzo suono EMPTY
MACKINTOSH_PT	rs.l	1	;LONG! Puntatore indirizzo suono MACKINTOSH
JOYPAD_PT	rs.l	1	;LONG! Puntatore indirizzo suono JOYPAD
SYNTAX_PT	rs.l	1	;LONG! Puntatore indirizzo suono SYNTAX
PITAGORAs_PT	rs.l	1	;LONG! Puntatore indirizzo suono PITAGORAs

WIND_LEN	rs.w	1	;LONG! Lunghezza suono WIND
BACK_LEN	rs.w	1	;LONG! Lunghezza suono BACK
ALARM_LEN	rs.w	1	;LONG! Lunghezza suono ALARM
ANGEL_LEN	rs.w	1	;LONG! Lunghezza suono ANGEL
DEVIL_LEN	rs.w	1	;LONG! Lunghezza suono DEVIL
EAT_LEN		rs.w	1	;LONG! Lunghezza suono EAT
BLEEDING_LEN	rs.w	1	;LONG! Lunghezza suono BLEEDING
CASHING_LEN	rs.w	1	;LONG! Lunghezza suono CASHING
WELCOME_LEN	rs.w	1	;LONG! Lunghezza suono WELCOME
ENDLEVEL_LEN	rs.w	1	;LONG! Lunghezza suono ENDLEVEL
BONUS_LEN	rs.w	1	;LONG! Lunghezza suono BONUS
EMPTY_LEN	rs.w	1	;LONG! Lunghezza suono EMPTY
MACKINTOSH_LEN	rs.w	1	;LONG! Lunghezza suono MACKINTOSH
JOYPAD_LEN	rs.w	1	;LONG! Lunghezza suono JOYPAD
SYNTAX_LEN	rs.w	1	;LONG! Lunghezza suono SYNTAX
PITAGORAs_LEN	rs.w	1	;LONG! Lunghezza suono PITAGORAs

AUD0_PT		rs.l	1	;LONG!
AUD0_LEN	rs.w	1	;WORD!
AUD0_PER	rs.w	1	;WORD!

AUD2_PT		rs.l	1	;LONG! CANALE GHOST 1
AUD2_LEN	rs.w	1	;WORD!
AUD2_PER	rs.w	1	;WORD!
AUD2_VOL	rs.w	1	;WORD!

AUD3_PT		rs.l	1	;LONG! CANALE GHOST 2
AUD3_LEN	rs.w	1	;WORD!
AUD3_PER	rs.w	1	;WORD!
AUD3_VOL	rs.w	1	;WORD!

AUD_FLAG	rs.b	1	;Usato in varie parti
AUD1_PRI	rs.b	1	;Priorita' sul canale 1

; END of VAR_INT.asm
*******************************************************************************
*******************************************************************************
; GAME INT routine                                            22 Mar 1993
;
;

GAME_INT:
	TST.W	DEVIL(A0)
	BNE.B	.over
	TST.W	ANGEL(A0)
	BNE.B	.over
	CMP.W	#16384,ENERGY(A0)
	BHI.B	.wind
	MOVE.L	ALARM_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD0_PT(A0)
	MOVE.W	ALARM_LEN(A0),AUD0_LEN(A0)
	MOVE.W	#15872,D0
	ADD.W	ENERGY(A0),D0
	LSR.W	#7,D0
	MOVE.W	D0,AUD0_PER(A0)
	MOVE.W	D0,$A6(A6)		;AUD0PER
	MOVE.W	#48,$A8(A6)		;aud0vol
	BRA.B	.over
.wind	MOVE.L	WIND_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD0_PT(A0)
	MOVE.W	WIND_LEN(A0),AUD0_LEN(A0)
	MOVE.W	#636,D0
	SUB.W	H(A0),D0
	SUB.W	H(A0),D0
	MOVE.W	D0,AUD0_PER(A0)
	MOVE.W	D0,$A6(A6)		;AUD0PER
	MOVE.W	#64,$A8(A6)		;aud0vol
.over	TST.W	DEVIL(A0)
	BEQ.B	.nodev
	MOVE.L	DEVIL_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD0_PT(A0)
	MOVE.W	DEVIL_LEN(A0),AUD0_LEN(A0)
	MOVE.W	#1360,AUD0_PER(A0)
	MOVE.W	#64,$A8(A6)		;aud0vol
	BRA.B	.cont
.nodev	TST.W	ANGEL(A0)
	BEQ.W	.cont
	MOVE.L	ANGEL_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD0_PT(A0)
	MOVE.W	ANGEL_LEN(A0),AUD0_LEN(A0)
	MOVE.W	#636,D0
	SUB.W	H(A0),D0
	SUB.W	H(A0),D0
	MOVE.W	D0,AUD0_PER(A0)
	MOVE.W	D0,$A6(A6)		;AUD0PER
	MOVE.W	#64,$A8(A6)		;aud0vol
	BRA.W	GAME_INT_EXIT
.cont	MOVE.W	LEVEL(A0),D0
	BEQ.W	GAME_INT_EXIT
	ADD.W	D0,D0
	MOVE.W	.tab(PC,D0.W),D0
	SUB.W	D0,ENERGY(A0)
	BCS.W	GAME_OVER
	BRA.B	.ok
.tab	DC.W	0		;LEVEL0
	DC.W	16		;ENERGY=-16 per frame (LEVEL1)
	DC.W	24		;ENERGY=-24 per frame (LEVEL2)
	DC.W	32		;ENERGY=-32 per frame (LEVEL3)
	DC.W	48		;ENERGY=-48 per frame (LEVEL4)
	DC.W	64		;ENERGY=-64 per frame (LEVEL5)
.ok	TST.W	DEVIL(A0)
	BEQ.B	GAME_INT_1
	SUB.W	#32,ENERGY(A0)		;ENERGY= altri -32 per frame
	BCS.W	GAME_OVER
GAME_INT_1:
	MOVE.W	VB+2(A0),D0
	AND.W	#$01FF,D0		;ogni 512 frames
	BNE.W	GAME_INT_2
	MOVE.W	6(A6),D0		;RND -vhposr
	ADD.W	$14(A6),D0		;    -pot1dat
	AND.W	#$000F,D0
	CMP.W	#$2,D0
	BLS.W	GAME_INT_2
;SUONO "BONUS"
	MOVEQ	#0,D7
	BSR.W	RADAR_BONUS
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	BSR.W	AUD1_OFF
	MOVE.L	BONUS_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	BONUS_LEN(A0),$B4(A6)	;AUD1LEN
	MOVE.W	#540,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.B	#2,AUD1_PRI(A0)
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1

	MOVE.L	ADDRESS_MAP(A0),A1
	MOVE.W	LEVEL(A0),D1
	ADD.W	D1,D1
	MOVE.W	GAME_INT_TAB(PC,D1.W),D1
	JMP	GAME_INT_TAB(PC,D1.W)
GAME_INT_TAB:
PC	set	*
	DC.W	GAME_INT_2-PC
	DC.W	GAME_INT_L1-PC
	DC.W	GAME_INT_L2-PC
	DC.W	GAME_INT_L3-PC
	DC.W	GAME_INT_L4-PC
	DC.W	GAME_INT_L5-PC
GAME_INT_L1:
	LSL.B	#4,D0			;D0=RND
	ADD.B	#$01,D0			;3..15
	MOVE.B	D0,$248(A1)
	BRA.B	GAME_INT_2

GAME_INT_L2:
	LSL.B	#4,D0			;D0=RND
	ADD.B	#$01,D0			;3..15
	MOVE.B	D0,$366(A1)
	BRA.B	GAME_INT_2

GAME_INT_L3:
	LSL.B	#4,D0			;D0=RND
	ADD.B	#$01,D0			;3..15
	MOVE.B	D0,$D49(A1)
	BRA.B	GAME_INT_2

GAME_INT_L4:
	LSL.B	#4,D0			;D0=RND
	ADD.B	#$01,D0			;3..15
	MOVE.B	D0,$E65(A1)
	BRA.B	GAME_INT_2

GAME_INT_L5:
	LSL.B	#4,D0			;D0=RND
	ADD.B	#$01,D0			;3..15
	MOVE.B	D0,$BF8(A1)
	BRA.W	GAME_INT_2

GAME_INT_2:
****
GAME_INT_EXIT:
	RTS
*******************************************************************************
; GAME OVER routine                                           22 Mar 1993
GAME_OVER:
	ST.B	GAMEOVER(A0)
	RTS
; END of GAME INT routine
*******************************************************************************
; END of GAME INT routine
*******************************************************************************
*******************************************************************************
; SET UP routine                                              22 Mar 1993
;
;

SET_UP:
	LEA	$DFF000,A6		; CUSTOM
	MOVE.W	#512,VX(A0)
	MOVE.W	#320,VY(A0)
	MOVE.W	#1,ALPHA(A0)
	MOVE.W	#64,H(A0)
	MOVE.W	#1,VELOCITY(A0)
	MOVE.W	#2,POWERJUMP(A0)
	CLR.B	GAMEOVER(A0)
	CLR.B	ENDGAME(A0)
	CLR.W	SALTA(A0)
	CLR.W	JUMP(A0)
	CLR.W	SUPERPILL(A0)
	CLR.W	GHOSTSTOP(A0)
	CLR.W	DEVIL(A0)
	CLR.W	ANGEL(A0)
	MOVE.W	#65535,ENERGY(A0)
	CLR.L	SCORE(A0)
	CLR.L	VB(A0)
	MOVE.W	$6(A6),GFAIL(A0)	;RND -> GFAIL+GLAST
	CLR.B	WELCOMED(A0)

	MOVE.B	#178,PILLS_1(A0)	;STRANGERTOWN
	MOVE.B	#189,PILLS_2(A0)	;FUNKY TOWN
	MOVE.B	#126,PILLS_3(A0)	;ELECTRICITY
	MOVE.B	#145,PILLS_4(A0)	;HEARTBEAT CITY
	MOVE.B	#165,PILLS_5(A0)	;PARADISE CITY

	LEA.L	ENEMYes_BAK(A0),A1	;
	LEA.L	ENEMYes(A0),A2		;LEVEL_1 / GHOST_1
	MOVE.W	#159,D0
SET_UP_ENEMYes:
	MOVE.L	(A1)+,(A2)+
	DBRA	D0,SET_UP_ENEMYes

	LEA.L	WHICH_LEVEL(A0),A4
	MOVEQ	#1,D7			;RADAR Pills
	MOVE.L	ADDRESS_MAP(A0),A1
	MOVE.L	A1,A2
	ADD.L	#$7000,A2		;A2=MAP GHOST
	MOVE.W	#4095,D0
SET_UP_MAP_GHOST:
	CLR.B	(A2,D0.W)
	MOVE.B	(A1,D0.W),D1		;Type/Obj
	AND.B	#$0F,D1
	CMP.B	#$01,D1			;Restore PILLS
	BNE.B	SET_UP_MAP_GHOST_0
	MOVE.B	#$11,(A1,D0.W)
SET_UP_MAP_GHOST_0:
	CMP.B	#$02,D1			;Restore GHOST MAP
	BCC.B	SET_UP_MAP_GHOST_1
	MOVE.B	#1,(A2,D0.W)
SET_UP_MAP_GHOST_1:
	MOVE.W	D0,-(SP)		;save D0
	CMP.B	#$01,D1
	BNE.B	SETUP_RADAR_CONT
	MOVE.B	(A4,D0.W),D3		;D3=LEVEL
	MOVE.W	D0,D1
	AND.W	#63,D0			;D0=BX
	LSR.W	#6,D1			;D1=BY
	AND.W	#$00FF,D3
	ADD.W	D3,D3
	MOVE.W	RADAR_SETUP_TAB(PC,D3.W),D3
	JSR	RADAR_SETUP_TAB(PC,D3.W)
	BRA.B	SETUP_RADAR_CONT
RADAR_SETUP_TAB:
PC	set	*
	DC.W	RADAR_EAT_EXIT-PC
	DC.W	RADAR_EAT_1-PC
	DC.W	RADAR_EAT_2-PC
	DC.W	RADAR_EAT_3-PC
	DC.W	RADAR_EAT_4-PC
	DC.W	RADAR_EAT_5-PC
SETUP_RADAR_CONT:
	MOVE.W	(SP)+,D0		;restore D0
	DBRA	D0,SET_UP_MAP_GHOST
	MOVE.L	ADDRESS_MAP(A0),A1	;A1=MAP TYPE/OBJ

	MOVE.B	#$01,$248(A1)		;Prepare BONUS Level 1
	BSR.W	RADAR_BONUS_1
	MOVE.B	#$01,$366(A1)		;Prepare BONUS Level 2
	BSR.W	RADAR_BONUS_2
	MOVE.B	#$01,$D49(A1)		;Prepare BONUS Level 3
	BSR.W	RADAR_BONUS_3
	MOVE.B	#$01,$E65(A1)		;Prepare BONUS Level 4
	BSR.W	RADAR_BONUS_4
	MOVE.B	#$01,$BF8(A1)		;Prepare BONUS Level 5
	BSR.W	RADAR_BONUS_5

	MOVEQ	#0,D7
	MOVE.W	#8,D0		;BX
	MOVE.W	#5,D1		;BY
	BSR.W	RADAR_EAT_1			;Clear START Pill LEVEL 1
	MOVE.W	#32,D0		;BX
	MOVE.W	#13,D1		;BY
	BSR.W	RADAR_EAT_2			;Clear START Pill LEVEL 2
	MOVE.W	#9,D0		;BX
	MOVE.W	#43,D1		;BY
	BSR.W	RADAR_EAT_3			;Clear START Pill LEVEL 3
	MOVE.W	#28,D0		;BX
	MOVE.W	#51,D1		;BY
	BSR.W	RADAR_EAT_4			;Clear START Pill LEVEL 4
	MOVE.W	#56,D0		;BX
	MOVE.W	#40,D1		;BY
	BSR.W	RADAR_EAT_5			;Clear START Pill LEVEL 5

	MOVEQ	#2,D7		;SUPERPILL
	MOVE.B	#$21,$0C1(A1)		;Prepare SuperPill Level 1
	MOVE.W	#1,D0		;BX
	MOVE.W	#3,D1		;BY
	BSR.W	RADAR_EAT_1
	MOVE.B	#$21,$0CF(A1)		;Prepare SuperPill Level 1
	MOVE.W	#15,D0		;BX
	MOVE.W	#3,D1		;BY
	BSR.W	RADAR_EAT_1
	MOVE.B	#$21,$348(A1)		;Prepare SuperPill Level 1
	MOVE.W	#8,D0		;BX
	MOVE.W	#13,D1		;BY
	BSR.W	RADAR_EAT_1
	MOVE.B	#$21,$501(A1)		;Prepare SuperPill Level 1
	MOVE.W	#1,D0		;BX
	MOVE.W	#20,D1		;BY
	BSR.W	RADAR_EAT_1
	MOVE.B	#$21,$50F(A1)		;Prepare SuperPill Level 1
	MOVE.W	#15,D0		;BX
	MOVE.W	#20,D1		;BY
	BSR.W	RADAR_EAT_1

	MOVE.B	#$21,$0E2(A1)		;Prepare SuperPill Level 2
	MOVE.W	#34,D0		;BX
	MOVE.W	#3,D1		;BY
	BSR.W	RADAR_EAT_2
	MOVE.B	#$21,$072(A1)		;Prepare SuperPill Level 2
	MOVE.W	#50,D0		;BX
	MOVE.W	#1,D1		;BY
	BSR.W	RADAR_EAT_2
	MOVE.B	#$21,$1EC(A1)		;Prepare SuperPill Level 2
	MOVE.W	#44,D0		;BX
	MOVE.W	#7,D1		;BY
	BSR.W	RADAR_EAT_2
	MOVE.B	#$21,$4EC(A1)		;Prepare SuperPill Level 2
	MOVE.W	#34,D0		;BX
	MOVE.W	#22,D1		;BY
	BSR.W	RADAR_EAT_2
	MOVE.B	#$21,$5A2(A1)		;Prepare SuperPill Level 2
	MOVE.W	#44,D0		;BX
	MOVE.W	#19,D1		;BY
	BSR.W	RADAR_EAT_2

	MOVE.B	#$21,$B01(A1)		;Prepare SuperPill Level 3
	MOVE.W	#1,D0		;BX
	MOVE.W	#44,D1		;BY
	BSR.W	RADAR_EAT_3
	MOVE.B	#$21,$B11(A1)		;Prepare SuperPill Level 3
	MOVE.W	#17,D0		;BX
	MOVE.W	#44,D1		;BY
	BSR.W	RADAR_EAT_3
	MOVE.B	#$21,$C49(A1)		;Prepare SuperPill Level 3
	MOVE.W	#9,D0		;BX
	MOVE.W	#49,D1		;BY
	BSR.W	RADAR_EAT_3
	MOVE.B	#$21,$E83(A1)		;Prepare SuperPill Level 3
	MOVE.W	#3,D0		;BX
	MOVE.W	#58,D1		;BY
	BSR.W	RADAR_EAT_3
	MOVE.B	#$21,$E8F(A1)		;Prepare SuperPill Level 3
	MOVE.W	#15,D0		;BX
	MOVE.W	#58,D1		;BY
	BSR.W	RADAR_EAT_3

	MOVE.B	#$21,$B1E(A1)		;Prepare SuperPill Level 4
	MOVE.W	#30,D0		;BX
	MOVE.W	#44,D1		;BY
	BSR.W	RADAR_EAT_4
	MOVE.B	#$21,$B2C(A1)		;Prepare SuperPill Level 4
	MOVE.W	#44,D0		;BX
	MOVE.W	#44,D1		;BY
	BSR.W	RADAR_EAT_4
	MOVE.B	#$21,$C65(A1)		;Prepare SuperPill Level 4
	MOVE.W	#37,D0		;BX
	MOVE.W	#49,D1		;BY
	BSR.W	RADAR_EAT_4
	MOVE.B	#$21,$E9E(A1)		;Prepare SuperPill Level 4
	MOVE.W	#30,D0		;BX
	MOVE.W	#58,D1		;BY
	BSR.W	RADAR_EAT_4
	MOVE.B	#$21,$EAC(A1)		;Prepare SuperPill Level 4
	MOVE.W	#44,D0		;BX
	MOVE.W	#58,D1		;BY
	BSR.W	RADAR_EAT_4

	MOVE.B	#$21,$AB2(A1)		;Prepare SuperPill Level 5
	MOVE.W	#50,D0		;BX
	MOVE.W	#42,D1		;BY
	BSR.W	RADAR_EAT_5
	MOVE.B	#$21,$ABE(A1)		;Prepare SuperPill Level 5
	MOVE.W	#62,D0		;BX
	MOVE.W	#42,D1		;BY
	BSR.W	RADAR_EAT_5
	MOVE.B	#$21,$CF8(A1)		;Prepare SuperPill Level 5
	MOVE.W	#56,D0		;BX
	MOVE.W	#51,D1		;BY
	BSR.W	RADAR_EAT_5
	MOVE.B	#$21,$F32(A1)		;Prepare SuperPill Level 5
	MOVE.W	#50,D0		;BX
	MOVE.W	#60,D1		;BY
	BSR.W	RADAR_EAT_5
	MOVE.B	#$21,$F3E(A1)		;Prepare SuperPill Level 5
	MOVE.W	#62,D0		;BX
	MOVE.W	#60,D1		;BY
	BSR.W	RADAR_EAT_5

	MOVE.B	#$A0,$35F(A1)		;Open In Door Level 2
	MOVE.B	#$50,$A89(A1)		;Open In Door Level 3
	MOVE.B	#$A0,$CDB(A1)		;Open In Door Level 4
	MOVE.B	#$50,$9F8(A1)		;Open In Door Level 5

	MOVE.B	#$A6,$350(A1)		;Close Out Door Level 1
	MOVE.B	#$A6,$1F3(A1)		;Close Out Door Level 2
	MOVE.B	#$A6,$CCF(A1)		;Close Out Door Level 3
	MOVE.B	#$56,$B25(A1)		;Close Out Door Level 4

	ADD.W	#$148,A1
	MOVE.L	A1,REMCYBER(A0)

	RTS
; END of SET_UP routine
*******************************************************************************

AUD1_OFF:
	MOVEM.L	D0-D2,-(SP)
	MOVE.L	#0,$B0(A6)		;AUD1PT
	MOVE.W	#1,$B4(A6)		;AUD1LEN
	MOVE.W	#0,$B8(A6)		;AUD1VOL
	MOVE.W	#1,$B6(A6)		;AUD1PER (was 124)
	MOVE.W	#$0002,$96(A6)		;AUD1_DMA OFF

	MOVEQ	#12,D2			;wait for 12 hbl's
.Whbl0l	MOVE.L	$DFF004,D1
	AND.L	#$000000FF,D1
	CMP.L	#$00000038,D1
	BCS.B	.Whbl0l
.Whbl0	MOVE.W	#$8202,$DFF096
	MOVE.W	#0,$DFF0BA		;output null sound
	MOVE.W	#$0002,$DFF096
	MOVE.L	$DFF004,D0
	AND.L	#$000000FF,D0
	CMP.L	D1,D0
	BCC.B	.Whbl0
	DBRA	D2,.Whbl0l

	MOVEM.L	(SP)+,D0-D2
	RTS

*******************************************************************************
*******************************************************************************
; LVL3_INTERRUPT                                              28 Mar 1993
;
;

INTERRUPT:
	MOVEM.L	D0-D7/A1-A5,-(SP)
	MOVE.W	$1C(A6),D0
	AND.W	$1E(A6),D0
	BTST.L	#5,D0
	BEQ.B	LVL3_EXIT

	ADDQ.B	#1,3.W
	BSR.W	CYBER_INT
	BSR.W	GHOST_INT
	BSR.W	GAME_INT

LVL3_EXIT:
	MOVE.W	#$0060,$9C(A6)		;Clear VB(+BLIT) bit
	MOVEM.L	(SP)+,D0-D7/A1-A5
	RTE

; END of LEVEL 3 INTERRUPT SERVER ROUTINE
*******************************************************************************
; CYBER_INT                                                   22 Mar 1993
;
;

CYBER_INT:
	LEA	$DFF000,A6		; CUSTOM
	TST.B	PAUSE(A0)
	BNE.W	CYBER_LEVEL

	TST.B	WELL_DONE_CNT(A0)
	BEQ.B	.well1
	SUBQ.B	#1,WELL_DONE_CNT(A0)

.well1	ST.B	RADAR(A0)		;accendi RADAR
	TST.B	0.W			;CUBE visible
	BEQ.B	.CV
	CLR.B	RADAR(A0)		;spegni RADAR
	SUBQ.B	#1,0.W

	MOVE.W	LEVEL(A0),D0
	BEQ.B	.TV
	ADD.W	#LEVEL+1,D0	;d0=pointer of PILLS_?
	MOVE.B	(A0,D0.W),D0	;PILLs del livello corrente
	AND.W	#$00FF,D0
	MOVE.L	#200,D1		;SCORE=SCORE+((200-PILLs)/8)
	SUB.W	D0,D1
	LSR.W	#3,D1
	ADD.L	D1,SCORE(A0)

.CV	TST.B	1.W			;TUBE visible
	BEQ.B	.TV
	CLR.B	RADAR(A0)		;spegni RADAR
	SUBQ.B	#1,1.W	

	MOVE.W	LEVEL(A0),D0
	BEQ.B	.TV
	ADD.W	#LEVEL+1,D0	;d0=pointer of PILLS_?
	MOVE.B	(A0,D0.W),D0	;PILLs del livello corrente
	AND.W	#$00FF,D0
	MOVE.L	#200,D1		;SCORE=SCORE+((200-PILLs)/32)
	SUB.W	D0,D1
	LSR.W	#5,D1
	ADD.L	D1,SCORE(A0)

.TV
	SUBQ.W	#1,CHEAT_E(A0)
	BPL.B	.1
	CLR.W	CHEAT_E(A0)
.1	CMP.W	#40,CHEAT_E(A0)
	BCS.B	.2
	MOVE.W	#65535,ENERGY(A0)	;FULL ENERGY
	MOVE.L	SCORE(A0),D0
	LSR.L	#1,D0
	MOVE.L	D0,SCORE(A0)		;SCORE=SCORE/2
	ADD.L	#3000,VB(A0)		;TIME=TIME+60
	CLR.W	CHEAT_E(A0)

.2	SUBQ.W	#1,CHEAT_L(A0)
	BPL.B	.3
	CLR.W	CHEAT_L(A0)
.3	CMP.W	#40,CHEAT_L(A0)
	BCS.B	.4
	ST.B	CHEATED(A0)		;TAKE NOTE
	BSR.W	OPENDOOR

.4	MOVE.L	REMCYBER(A0),A2
	MOVE.B	#1,(A2)
	
	MOVE.W	VX(A0),D0
	LSR.W	#6,D0
	MOVE.W	D0,BX(A0)
	MOVE.W	VY(A0),D0
	LSR.W	#6,D0
	MOVE.W	D0,BY(A0)

	MOVE.W	#64,H(A0)		;NEMMENO la prima volta H<64!
	MOVE.W	SALTA(A0),D0
	ADD.W	D0,D0
	MOVE.W	SALTA_TAB(PC,D0.W),D0
	JMP	SALTA_TAB(PC,D0.W)
SALTA_TAB:
PC	set	*
	dc.w	VB_CNT-PC
	dc.w	SHORT-PC
	dc.w	MID-PC
	dc.w	LONG-PC


SHORT	MOVE.W	#JUMP_SHORT,D0
	ADD.W	JUMP(A0),D0
	MOVE.B	(A0,D0.W),H+1(A0)
	ADD.W	#1,JUMP(A0)
	CMPI.W	#128,JUMP(A0)
	BCS.B	VB_CNT
	CLR.W	SALTA(A0)
	CLR.W	JUMP(A0)
	BRA.B	VB_CNT

MID	MOVE.W	#JUMP_MID,D0
	ADD.W	JUMP(A0),D0
	MOVE.B	(A0,D0.W),H+1(A0)
	ADD.W	#1,JUMP(A0)
	CMPI.W	#256,JUMP(A0)
	BCS.B	VB_CNT
	CLR.W	SALTA(A0)
	CLR.W	JUMP(A0)
	BRA.B	VB_CNT

LONG	MOVE.W	#JUMP_LONG,D0
	ADD.W	JUMP(A0),D0
	MOVE.B	(A0,D0.W),H+1(A0)
	ADD.W	#1,JUMP(A0)
	CMPI.W	#384,JUMP(A0)
	BCS.B	VB_CNT
	CLR.W	SALTA(A0)
	CLR.W	JUMP(A0)

VB_CNT:	ADD.L	#1,VB(A0)
	sub.w	#1,SUPERPILL(a0)
	bpl.b	SUPERPILL_OK
	clr.w	SUPERPILL(a0)
SUPERPILL_OK:
	sub.w	#1,GHOSTSTOP(a0)
	bpl.b	GHOSTSTOP_OK
	clr.w	GHOSTSTOP(a0)
GHOSTSTOP_OK:
	sub.w	#1,DEVIL(a0)
	bpl.b	DEVIL_OK
	clr.w	DEVIL(a0)
DEVIL_OK:
	sub.w	#1,ANGEL(a0)
	bpl.b	ANGEL_OK
	clr.w	ANGEL(a0)
ANGEL_OK:

	move.b	#1,TURNSPEED(A0)
	bsr.w	JOY
	move.w	VELOCITY(a0),SPEED(a0)
	btst	#0,d0
	beq.b	NO_JOYUP
	move.b	#0,TURNSPEED(A0)
	lsl.w	SPEED(a0)	;SPEED=VELOCITY*2 when joystick is UP
NO_JOYUP:
	btst.b	#7,$bfe001
	bne.b	NO_FIRE
	move.w	POWERJUMP(A0),SALTA(A0)	;sequenza di volo
NO_FIRE:
	move.w	THISM(a0),LASTM(a0)
	andi.w	#$000e,d0	;joy and 8+4+2
	move.w	d0,THISM(a0)
	cmp.w	LASTM(a0),d0	;if THISM=LASTM then goto SAMEJ
	beq.b	SAMEJ
	move.w	d0,M(a0)	;M=THISM
SAMEJ:
	MOVE.W	ALPHA(A0),D0
	ADD.W	D0,D0
	MOVE.W	TAB_INT(PC,D0.W),D0
	JSR	TAB_INT(PC,D0.W)
	BRA.B	CYBER_LEVEL

TAB_INT:
PC	set	*

	dc.w	NORTH-PC
	dc.w	EAST-PC
	dc.w	SOUTH-PC
	dc.w	WEST-PC
*****
CYBER_LEVEL:
	MOVE.L	#$06000,A1
	ADD.L	A0,A1
	ADD.W	BX(A0),A1
	MOVE.W	BY(A0),D0
	LSL.W	#6,D0
	MOVE.B	(A1,D0.W),LEVEL+1(A0)

	MOVE.L	ADDRESS_MAP(A0),A2
	ADD.W	BX(A0),A2
	MOVE.W	VY(A0),D0
	AND.W	#$0FC0,D0
	ADD.W	D0,A2
	ADD.W	#$7000,A2		;GHOST MAP
	MOVE.B	#3,(A2)
	MOVE.L	A2,REMCYBER(A0)

	TST.B	WELCOMED(A0)
	BNE.W	CYBER_EXIT
	CLR.B	AUD_FLAG(A0)		;nessun suono WELCOME
	MOVE.L	ADDRESS_MAP(A0),A1
	SUB.L	A1,A2
	MOVE.W	A2,D0
	AND.W	#$0FFF,D0
	CMP.W	#$360,D0		;Trap LEVEL 2 ?
	BNE.W	TRAP_3
	MOVE.B	#$A6,$35F(A1)		;Close In Door Level 2
	CLR.B	$735F(A1)		;Close In Door Level 2 GHOST
	ST.B	AUD_FLAG(A0)	;SUONO WELCOME
	BRA.B	PLAY_WELCOME
TRAP_3:	CMP.W	#$AC9,D0		;Trap LEVEL 3 ?
	BNE.W	TRAP_4
	MOVE.B	#$56,$A89(A1)		;Close In Door Level 3
	CLR.B	$7A89(A1)		;Close In Door Level 3 GHOST
	ST.B	AUD_FLAG(A0)	;SUONO WELCOME
	BRA.B	PLAY_WELCOME
TRAP_4:	CMP.W	#$CDC,D0		;Trap LEVEL 4 ?
	BNE.W	TRAP_5
	MOVE.B	#$A6,$CDB(A1)		;Close In Door Level 4
	CLR.B	$7CDB(A1)		;Close In Door Level 4 GHOST
	ST.B	AUD_FLAG(A0)	;SUONO WELCOME
	BRA.B	PLAY_WELCOME
TRAP_5:	CMP.W	#$A38,D0		;Trap LEVEL 5 ?
	BNE.W	CYBER_EXIT
	MOVE.B	#$56,$9F8(A1)		;Close In Door Level 5
	CLR.B	$79F8(A1)		;Close In Door Level 5 GHOST
	ST.B	AUD_FLAG(A0)	;SUONO WELCOME
PLAY_WELCOME:
	TST.B	AUD_FLAG(A0)
	BEQ.B	CYBER_EXIT
	ST.B	WELCOMED(A0)
;SUONO "WELCOME"
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	BSR.W	AUD1_OFF
	MOVE.L	WELCOME_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	WELCOME_LEN(A0),$B4(A6)	;AUD1LEN
	MOVE.W	#214,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.B	#2,AUD1_PRI(A0)
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1
;
CYBER_EXIT:
	RTS
; END of CYBER_INT routine
;********************************************
JOY:	move.w	$c(a6),d0	;joy1dat
	move.w	d0,d1
	andi.w	#3,d0
	andi.w	#$300,d1
	lsr.w	#6,d1
	or.w	d0,d1
	move.b	JOY_TABLE(pc,d1.w),d0
	rts
JOY_TABLE:
	dc.b	%0000
	dc.b	%0010
	dc.b	%1010
	dc.b	%1000
	dc.b	%0001
	dc.b	%0011
	dc.b	%1011
	dc.b	%1001
	dc.b	%0101
	dc.b	%0111
	dc.b	%1111
	dc.b	%1101
	dc.b	%0100
	dc.b	%0110
	dc.b	%1110
	dc.b	%1100
;END of JOY routine
*******************************************************************************

NORTH:	MOVE.W	VY(A0),D0
	AND.W	#$3F,D0
	MOVE.W	D0,PBY(A0)
	MOVE.W	VX(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$20,D0
	MOVE.W	D0,VX(A0)
	MOVE.W	BY(A0),D0
	LSL.W	#6,D0
	ADD.W	BX(A0),D0
	MOVEA.L	ADDRESS_MAP(A0),A1
	ADDA.W	D0,A1
	MOVE.W	#15,D2
	MOVE.B	(A1),D3
	MOVE.W	D3,D1
	AND.W	D2,D1
	MOVE.W	D1,TYPE(A0)
	AND.W	#$F0,D3
	LSR.W	#4,D3
	MOVE.W	D3,OBJ(A0)
	MOVE.B	$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,UP(A0)
	MOVE.B	-1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,LE(A0)
	MOVE.B	1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,RI(A0)
	MOVE.B	-$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,DW(A0)
	CMPI.W	#1,TYPE(A0)
	BNE.B	NORTH_JOY
	CMPI.W	#90,H(A0)
	BCC.B	NORTH_JOY
	MOVE.W	OBJ(A0),D0
	ADD.W	D0,D0
	MOVE.W	TAB_OBJ_N(PC,D0.W),D0
	JSR	TAB_OBJ_N(PC,D0.W)
	BRA.B	NORTH_JOY

TAB_OBJ_N:
PC	set	*

	dc.w	_NULL-PC	; no-op!
	dc.w	_PILL-PC	;PILL-1:SCORE+100:ENERGY+1000
	dc.w	_SUPERPILL-PC	;+16 sec ( 800 frames di cui 200 Att!)SCORE+500
	dc.w	_GHOSTSTOP-PC	;+16 sec (  "    "    "   "   "   "  )
	dc.w	_FULLENERGY-PC	; ENERGY=65535 ( -32 x frame )
	dc.w	_DEVIL-PC	;+10 sec of bleeding ENERGY ( 500 frames )
	dc.w	_ANGEL-PC	;+20 sec of immortality ( 1000 norm/200 Att! )
	dc.w	_L_JUMP-PC	; JUMP = JUMP - 1
	dc.w	_M_JUMP-PC	; JUMP = JUMP + 1
	dc.w	_NO_CUBE-PC	;    for 5 sec
	dc.w	_L_SPEED-PC	; SPEED=SPEED - 1
	dc.w	_M_SPEED-PC	; SPEED=SPEED + 1
	dc.w	_NO_TUBE-PC	;    for 5 sec
	dc.w	_ENERGY5000-PC	;SCORE & ENERGY
	dc.w	_ENERGY10000-PC	;  "   "   "
	dc.w	_ENERGY20000-PC	;  "   "   "

NORTH_JOY:
	TST.W	THISM(A0)
	BEQ.S	NORTH_12C
	BTST	#3,M+1(A0)
	BEQ.S	NORTH_0F4
	CMPI.W	#1,RI(A0)
	BGT.S	NORTH_0F4
	CMPI.W	#$20,PBY(A0)
	BGT.S	NORTH_0F4
	MOVE.W	#1,ALPHA(A0)
	CLR.W	M(A0)
	RTS

NORTH_0F4:
	BTST	#2,M+1(A0)
	BEQ.S	NORTH_118
	CMPI.W	#1,LE(A0)
	BGT.S	NORTH_118
	CMPI.W	#$20,PBY(A0)
	BGT.S	NORTH_118
	MOVE.W	#3,ALPHA(A0)
	CLR.W	M(A0)
	RTS

NORTH_118:
	BTST	#1,M+1(A0)
	BEQ.S	NORTH_12C
	MOVE.W	#2,ALPHA(A0)
	CLR.W	M(A0)
	RTS

NORTH_12C:
	MOVE.W	SPEED(A0),D0
	ADD.W	D0,VY(A0)
	MOVE.W	VY(A0),D0
	AND.W	#$3F,D0
	CMPI.W	#1,UP(A0)
	BLE.S	NORTH_15A
	CMP.W	#$1E,D0
	BLE.S	NORTH_15A
	MOVE.W	VY(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$1E,D0
	MOVE.W	D0,VY(A0)
NORTH_15A:
	RTS


;************************


EAST:	MOVE.W	VX(A0),D0
	AND.W	#$3F,D0
	MOVE.W	D0,PBX(A0)
	MOVE.W	VY(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$20,D0
	MOVE.W	D0,VY(A0)
	MOVE.W	BY(A0),D0
	LSL.W	#6,D0
	ADD.W	BX(A0),D0
	MOVEA.L	ADDRESS_MAP(A0),A1
	ADDA.W	D0,A1
	MOVE.W	#15,D2
	MOVE.B	(A1),D3
	MOVE.W	D3,D1
	AND.W	D2,D1
	MOVE.W	D1,TYPE(A0)
	AND.W	#$F0,D3
	LSR.W	#4,D3
	MOVE.W	D3,OBJ(A0)
	MOVE.B	$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,UP(A0)
	MOVE.B	-1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,LE(A0)
	MOVE.B	1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,RI(A0)
	MOVE.B	-$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,DW(A0)
	CMPI.W	#1,TYPE(A0)
	BNE.S	EAST_0CA
	CMPI.W	#90,H(A0)
	BCC.B	EAST_0CA
	MOVE.W	OBJ(A0),D0
	ADD.W	D0,D0
	MOVE.W	TAB_OBJ_E(PC,D0.W),D0
	JSR	TAB_OBJ_E(PC,D0.W)
EAST_0A6:
	BRA.S	EAST_0CA

TAB_OBJ_E:
PC	set	*

	dc.w	_NULL-PC	; no-op!
	dc.w	_PILL-PC	;PILL-1:SCORE+100:ENERGY+1000
	dc.w	_SUPERPILL-PC	;+16 sec ( 800 frames di cui 200 Att!)SCORE+500
	dc.w	_GHOSTSTOP-PC	;+16 sec (  "    "    "   "   "   "  )
	dc.w	_FULLENERGY-PC	; ENERGY=65535 ( -32 x frame )
	dc.w	_DEVIL-PC	;+10 sec of bleeding ENERGY ( 500 frames )
	dc.w	_ANGEL-PC	;+20 sec of immortality ( 1000 norm/200 Att! )
	dc.w	_L_JUMP-PC	; JUMP = JUMP - 1
	dc.w	_M_JUMP-PC	; JUMP = JUMP + 1
	dc.w	_NO_CUBE-PC	;    for 5 sec
	dc.w	_L_SPEED-PC	; SPEED=SPEED - 1
	dc.w	_M_SPEED-PC	; SPEED=SPEED + 1
	dc.w	_NO_TUBE-PC	;    for 5 sec
	dc.w	_ENERGY5000-PC	;SCORE & ENERGY
	dc.w	_ENERGY10000-PC	;  "   "   "
	dc.w	_ENERGY20000-PC	;  "   "   "

EAST_0CA:
	TST.W	THISM(A0)
	BEQ.S	EAST_12C
	BTST	#3,M+1(A0)
	BEQ.S	EAST_0F4
	CMPI.W	#1,DW(A0)
	BGT.S	EAST_0F4
	CMPI.W	#$20,PBX(A0)
	BGT.S	EAST_0F4
	MOVE.W	#2,ALPHA(A0)
	CLR.W	M(A0)
	RTS

EAST_0F4:
	BTST	#2,M+1(A0)
	BEQ.S	EAST_118
	CMPI.W	#1,UP(A0)
	BGT.S	EAST_118
	CMPI.W	#$20,PBX(A0)
	BGT.S	EAST_118
	MOVE.W	#0,ALPHA(A0)
	CLR.W	M(A0)
	RTS

EAST_118:
	BTST	#1,M+1(A0)
	BEQ.S	EAST_12C
	MOVE.W	#3,ALPHA(A0)
	CLR.W	M(A0)
	RTS

EAST_12C:
	MOVE.W	SPEED(A0),D0
	ADD.W	D0,VX(A0)
	MOVE.W	VX(A0),D0
	AND.W	#$3F,D0
	CMPI.W	#1,RI(A0)
	BLE.S	EAST_15A
	CMP.W	#$1E,D0
	BLE.S	EAST_15A
	MOVE.W	VX(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$1E,D0
	MOVE.W	D0,VX(A0)
EAST_15A:
	RTS



;************************



SOUTH:	MOVE.W	VY(A0),D0
	AND.W	#$3F,D0
	MOVE.W	D0,PBY(A0)
	MOVE.W	VX(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$20,D0
	MOVE.W	D0,VX(A0)
	MOVE.W	BY(A0),D0
	LSL.W	#6,D0
	ADD.W	BX(A0),D0
	MOVEA.L	ADDRESS_MAP(A0),A1
	ADDA.W	D0,A1
	MOVE.W	#15,D2
	MOVE.B	(A1),D3
	MOVE.W	D3,D1
	AND.W	D2,D1
	MOVE.W	D1,TYPE(A0)
	AND.W	#$F0,D3
	LSR.W	#4,D3
	MOVE.W	D3,OBJ(A0)
	MOVE.B	$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,UP(A0)
	MOVE.B	-1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,LE(A0)
	MOVE.B	1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,RI(A0)
	MOVE.B	-$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,DW(A0)
	CMPI.W	#1,TYPE(A0)
	BNE.S	SOUTH_0CA
	CMPI.W	#90,H(A0)
	BCC.B	SOUTH_0CA
	MOVE.W	OBJ(A0),D0
	ADD.W	D0,D0
	MOVE.W	TAB_OBJ_S(PC,D0.W),D0
	JSR	TAB_OBJ_S(PC,D0.W)
SOUTH_0A6:	
	BRA.S	SOUTH_0CA

TAB_OBJ_S:
PC	set	*

	dc.w	_NULL-PC	; no-op!
	dc.w	_PILL-PC	;PILL-1:SCORE+100:ENERGY+1000
	dc.w	_SUPERPILL-PC	;+16 sec ( 800 frames di cui 200 Att!)SCORE+500
	dc.w	_GHOSTSTOP-PC	;+16 sec (  "    "    "   "   "   "  )
	dc.w	_FULLENERGY-PC	; ENERGY=65535 ( -32 x frame )
	dc.w	_DEVIL-PC	;+10 sec of bleeding ENERGY ( 500 frames )
	dc.w	_ANGEL-PC	;+20 sec of immortality ( 1000 norm/200 Att! )
	dc.w	_L_JUMP-PC	; JUMP = JUMP - 1
	dc.w	_M_JUMP-PC	; JUMP = JUMP + 1
	dc.w	_NO_CUBE-PC	;    for 5 sec
	dc.w	_L_SPEED-PC	; SPEED=SPEED - 1
	dc.w	_M_SPEED-PC	; SPEED=SPEED + 1
	dc.w	_NO_TUBE-PC	;    for 5 sec
	dc.w	_ENERGY5000-PC	;SCORE & ENERGY
	dc.w	_ENERGY10000-PC	;  "   "   "
	dc.w	_ENERGY20000-PC	;  "   "   "

SOUTH_0CA:
	TST.W	THISM(A0)
	BEQ.S	SOUTH_12C
	BTST	#3,M+1(A0)
	BEQ.S	SOUTH_0F4
	CMPI.W	#1,LE(A0)
	BGT.S	SOUTH_0F4
	CMPI.W	#$20,PBY(A0)
	BLT.S	SOUTH_0F4
	MOVE.W	#3,ALPHA(A0)
	CLR.W	M(A0)
	RTS

SOUTH_0F4:
	BTST	#2,M+1(A0)
	BEQ.S	SOUTH_118
	CMPI.W	#1,RI(A0)
	BGT.S	SOUTH_118
	CMPI.W	#$20,PBY(A0)
	BLT.S	SOUTH_118
	MOVE.W	#1,ALPHA(A0)
	CLR.W	M(A0)
	RTS

SOUTH_118:
	BTST	#1,M+1(A0)
	BEQ.S	SOUTH_12C
	MOVE.W	#0,ALPHA(A0)
	CLR.W	M(A0)
	RTS

SOUTH_12C:
	MOVE.W	SPEED(A0),D0
	SUB.W	D0,VY(A0)
	MOVE.W	VY(A0),D0
	AND.W	#$3F,D0
	CMPI.W	#1,DW(A0)
	BLE.S	SOUTH_15A
	CMP.W	#$22,D0
	BGE.S	SOUTH_15A
	MOVE.W	VY(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$22,D0
	MOVE.W	D0,VY(A0)
SOUTH_15A:
	RTS



;************************



WEST:	MOVE.W	VX(A0),D0
	AND.W	#$3F,D0
	MOVE.W	D0,PBX(A0)
	MOVE.W	VY(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$20,D0
	MOVE.W	D0,VY(A0)
	MOVE.W	BY(A0),D0
	LSL.W	#6,D0
	ADD.W	BX(A0),D0
	MOVEA.L	ADDRESS_MAP(A0),A1
	ADDA.W	D0,A1
	MOVE.W	#15,D2
	MOVE.B	(A1),D3
	MOVE.W	D3,D1
	AND.W	D2,D1
	MOVE.W	D1,TYPE(A0)
	AND.W	#$F0,D3
	LSR.W	#4,D3
	MOVE.W	D3,OBJ(A0)
	MOVE.B	$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,UP(A0)
	MOVE.B	-1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,LE(A0)
	MOVE.B	1(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,RI(A0)
	MOVE.B	-$40(A1),D1
	AND.W	D2,D1
	MOVE.W	D1,DW(A0)
	CMPI.W	#1,TYPE(A0)
	BNE.S	WEST_0CA
	CMPI.W	#90,H(A0)
	BCC.B	WEST_0CA
	MOVE.W	OBJ(A0),D0
	ADD.W	D0,D0
	MOVE.W	TAB_OBJ_W(PC,D0.W),D0
	JSR	TAB_OBJ_W(PC,D0.W)
WEST_0A6:
	BRA.S	WEST_0CA

TAB_OBJ_W:
PC	set	*

	dc.w	_NULL-PC	; no-op!
	dc.w	_PILL-PC	;PILL-1:SCORE+100:ENERGY+1000
	dc.w	_SUPERPILL-PC	;+16 sec ( 800 frames di cui 200 Att!)SCORE+500
	dc.w	_GHOSTSTOP-PC	;+16 sec (  "    "    "   "   "   "  )
	dc.w	_FULLENERGY-PC	; ENERGY=65535 ( -32 x frame )
	dc.w	_DEVIL-PC	;+10 sec of bleeding ENERGY ( 500 frames )
	dc.w	_ANGEL-PC	;+20 sec of immortality ( 1000 norm/200 Att! )
	dc.w	_L_JUMP-PC	; JUMP = JUMP - 1
	dc.w	_M_JUMP-PC	; JUMP = JUMP + 1
	dc.w	_NO_CUBE-PC	;    for 5 sec
	dc.w	_L_SPEED-PC	; SPEED=SPEED - 1
	dc.w	_M_SPEED-PC	; SPEED=SPEED + 1
	dc.w	_NO_TUBE-PC	;    for 5 sec
	dc.w	_ENERGY5000-PC	;SCORE & ENERGY
	dc.w	_ENERGY10000-PC	;  "   "   "
	dc.w	_ENERGY20000-PC	;  "   "   "

WEST_0CA:
	TST.W	THISM(A0)
	BEQ.S	WEST_12C
	BTST	#3,M+1(A0)
	BEQ.S	WEST_0F4
	CMPI.W	#1,UP(A0)
	BGT.S	WEST_0F4
	CMPI.W	#$20,PBX(A0)
	BLT.S	WEST_0F4
	MOVE.W	#0,ALPHA(A0)
	CLR.W	M(A0)
	RTS

WEST_0F4:
	BTST	#2,M+1(A0)
	BEQ.S	WEST_118
	CMPI.W	#1,DW(A0)
	BGT.S	WEST_118
	CMPI.W	#$20,PBX(A0)
	BLT.S	WEST_118
	MOVE.W	#2,ALPHA(A0)
	CLR.W	M(A0)
	RTS

WEST_118:
	BTST	#1,M+1(A0)
	BEQ.S	WEST_12C
	MOVE.W	#1,ALPHA(A0)
	CLR.W	M(A0)
	RTS

WEST_12C:
	MOVE.W	SPEED(A0),D0
	SUB.W	D0,VX(A0)
	MOVE.W	VX(A0),D0
	AND.W	#$3F,D0
	CMPI.W	#1,LE(A0)
	BLE.S	WEST_15A
	CMP.W	#$22,D0
	BGE.S	WEST_15A
	MOVE.W	VX(A0),D0
	AND.W	#$FFC0,D0
	ADD.W	#$22,D0
	MOVE.W	D0,VX(A0)
WEST_15A:
	RTS

;
; OBJ routines...
;

_NULL:
	rts

_PILL:
;SUONO di EAT
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	TST.B	AUD1_PRI(A0)
	BNE.B	.nosnd
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	BSR.W	AUD1_OFF
	MOVE.L	EAT_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	EAT_LEN(A0),$B4(A6)	;AUD1LEN
	MOVE.W	#404,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1
;
.nosnd	AND.B	D2,(A1)			;CLEAR MAP
	add.l	#100,SCORE(A0) 		;SCORE+100
	add.w	#1000,ENERGY(A0)	;ENERGY+1000
	bcc.b	_PILL_V
	move.w	#65535,ENERGY(A0)
_PILL_V:
	move.w	LEVEL(A0),d0
	beq.b	_PILL_L
	add.w	#LEVEL+1,d0	;d0=pointer of PILLS_?
	subq.b	#1,(A0,D0.W)	;PILLs=PILLs-1 del livello corrente
	beq.b	END_LEVEL
_PILL_L:
	rts
END_LEVEL:
	CLR.B	WELCOMED(A0)		;prepara per WELCOME
;SUONO "ENDLEVEL"
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	BSR.W	AUD1_OFF
	MOVE.L	ENDLEVEL_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	ENDLEVEL_LEN(A0),$B4(A6);AUD1LEN
	MOVE.W	#264,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.B	#2,AUD1_PRI(A0)
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1
;
OPENDOOR:
	move.l	ADDRESS_MAP(A0),A1
	move.w	LEVEL(A0),d0
	add.w	d0,d0
	move.w	PILL_EL_TAB(PC,D0.W),D0
	jmp	PILL_EL_TAB(PC,D0.W)
PILL_EL_TAB:
PC	set	*

	DC.W	END_LEVEL_EXIT-PC
	DC.W	END_LEVEL1-PC
	DC.W	END_LEVEL2-PC
	DC.W	END_LEVEL3-PC
	DC.W	END_LEVEL4-PC
	DC.W	END_LEVEL5-PC
*******
END_LEVEL_EXIT:
	rts
END_LEVEL1:
	MOVE.B	#$A0,$350(A1)		;Open Out Door Level 1
	ST.B	WELL_DONE_CNT(A0)
	rts

END_LEVEL2:
	MOVE.B	#$A0,$1F3(A1)		;Open Out Door Level 2
	ST.B	WELL_DONE_CNT(A0)
	rts

END_LEVEL3:
	MOVE.B	#$A0,$CCF(A1)		;Open Out Door Level 3
	ST.B	WELL_DONE_CNT(A0)
	rts

END_LEVEL4:
	MOVE.B	#$50,$B25(A1)		;Open Out Door Level 4
	ST.B	WELL_DONE_CNT(A0)
	rts

END_LEVEL5:				;END GAME!
	ST.B	ENDGAME(A0)
	RTS
*******
_SUPERPILL:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.l	#500,SCORE(A0)		;SCORE+500
	add.w	#500,SUPERPILL(A0)	;+10 sec!
	rts

_GHOSTSTOP:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.l	#500,SCORE(A0)		;SCORE+500
	add.w	#800,GHOSTSTOP(A0)	;+16 sec!
	rts

_FULLENERGY:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	move.w	#65535,ENERGY(A0)
	rts

_DEVIL:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.w	#500,DEVIL(A0)		;+10 sec!
	rts

_ANGEL:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.w	#1000,ANGEL(A0)		;+20 sec!
	rts

_L_JUMP:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	cmp.w	#1,POWERJUMP(A0)
	bls.b	.no
	subq.w	#1,POWERJUMP(A0)
.no	rts

_M_JUMP:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	cmp.w	#3,POWERJUMP(A0)
	bcc.b	.no
	addq.w	#1,POWERJUMP(A0)
.no	rts

_NO_CUBE:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	st.b	0.W
	rts

_L_SPEED:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	cmp.w	#1,VELOCITY(A0)
	bls.b	.no
	subq.w	#1,VELOCITY(A0)
.no	rts

_M_SPEED:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.W	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	cmp.w	#3,VELOCITY(A0)
	bcc.b	.no
	addq.w	#1,VELOCITY(A0)
.no	rts

_NO_TUBE:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.B	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	st.b	1.W
	rts

_ENERGY5000:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.B	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.l	#5000,SCORE(A0)
	add.w	#10000,ENERGY(A0)
	bcc.b	_E5000_EXIT
	move.w	#65535,ENERGY(A0)
_E5000_EXIT
	rts

_ENERGY10000:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.B	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.l	#10000,SCORE(A0)
	add.w	#20000,ENERGY(A0)
	bcc.b	_E10000_EXIT
	move.w	#65535,ENERGY(A0)
_E10000_EXIT
	rts

_ENERGY20000:
	MOVEQ	#0,D7		;RADAR_EAT Clear block
	BSR.W	RADAR_EAT
	BSR.B	BIG_EAT
	AND.B	D2,(A1)			;CLEAR MAP
	add.l	#20000,SCORE(A0)
	add.w	#40000,ENERGY(A0)
	bcc.b	_E20000_EXIT
	move.w	#65535,ENERGY(A0)
_E20000_EXIT
	rts

********
BIG_EAT:
;SUONO di BIG_EAT
	TST.B	AUD1_PRI(A0)
	BNE.B	.nosnd
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	BSR.W	AUD1_OFF
	MOVE.L	BONUS_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	BONUS_LEN(A0),$B4(A6)	;AUD1LEN
	MOVE.W	#200,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1
.nosnd	RTS
********

; END of CYBER_INT routine
*******************************************************************************
*******************************************************************************
*******************************************************************************
*******************************************************************************
; GHOST INT routine                                           22 Mar 1993
;
; INPUT : A1 = Address of GHOST_STRUCT
;         A2 = Address of BX,BY
; OUTPUT: D0 = SUP
;         D1 = SDW
;         D2 = SLE
;         D3 = SRI
;         D4 = COD
; SCRATCH D5
; FIX   : D6 = O
;         D7 = GSEE
;

GHOST_INT:
	TST.B	GPAUSE(A0)
	BNE.W	GHOST_EXIT
	MOVE.W	LEVEL(A0),D0
	BEQ.W	GHOST_EXIT

	LEA	ENEMYes(A0),A1
	SUBQ.W	#1,D0
	LSL.W	#7,D0
	ADD.W	D0,A1
	BSR.B	GHOST_INT2		;GHOST 0
	ADD.W	#$10,A1
	BSR.B	GHOST_INT2		;GHOST 1
	ADD.W	#$10,A1
	BSR.B	GHOST_INT2		;GHOST 2
	ADD.W	#$10,A1
	BSR.B	GHOST_INT2		;GHOST 3
	ADD.W	#$10,A1
	BSR.B	GHOST_INT2		;GHOST 4
	RTS

GHOST_INT2:
	MOVE.W	GVX(A1),D0
	MOVE.W	D0,D1
	SUB.W	#31,D0
	ADD.W	#31,D1
	CMP.W	VX(A0),D0
	BGE.W	.go
	CMP.W	VX(A0),D1
	BLE.W	.go
	MOVE.W	GVY(A1),D0
	MOVE.W	D0,D1
	SUB.W	#31,D0
	ADD.W	#31,D1
	CMP.W	VY(A0),D0
	BGE.W	.go
	CMP.W	VY(A0),D1
	BLE.W	.go
	CMP.W	#150,H(A0)		;ci sto volando sopra?
	BCC.W	.go
	TST.W	SUPERPILL(A0)
	BEQ.B	.norm
;SUONO di "COIN IN" (stiamo guadagnando punti con SUPERPILL)
	TST.B	AUD1_PRI(A0)
	BNE.B	.nosnd
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	MOVE.L	CASHING_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	CASHING_LEN(A0),$B4(A6)	;AUD1LEN
	MOVE.W	#300,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1
;
.nosnd	ADD.L	#100,SCORE(A0)
	RTS
.norm	TST.W	ANGEL(A0)
	BNE.W	.go
	ST.B	BLEEDING(A0)
	SUB.W	#256,ENERGY(A0)		;BLEEDING!!!
	BCS.W	GAME_OVER
;SUONO di COLLISIONE BLEEDING
	TST.B	AUD1_PRI(A0)
	BNE.B	.nosnd2
	MOVE.W	#$0100,$9A(A6)		;DISABLE INT
	MOVE.L	BLEEDING_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)		;AUD1PT
	MOVE.W	BLEEDING_LEN(A0),$B4(A6);AUD1LEN
	MOVE.W	#300,$B6(A6)		;AUD1PER
	MOVE.W	#64,$B8(A6)		;AUD1VOL
	MOVE.W	#$0100,$9C(A6)		;clear REQ
	MOVE.W	#$C100,$9A(A6)		;set INT
	MOVE.W	#$8202,$96(A6)		;START DMA AUDIO 1
.nosnd2	RTS
.go	MOVE.L	ADDRESS_MAP(A0),A2
	MOVE.W	GVX(A1),D0
	LSR.W	#6,D0			;D0=BX
	MOVE.W	GVY(A1),D1
	AND.W	#$0FC0,D1		;D1=BY*64
	ADD.W	D1,D0
	ADD.W	#$7000,D0		;GHOST MAP
	ADD.W	D0,A2			;A2=Address of GHOST place
	
	ST.B	GHOST_OVERLAY(A0)
	CMP.B	#3,(A2)			;IF CYBER then RETURN
	BNE.B	GHOST_INT_GO
	CLR.B	GHOST_OVERLAY(A0)
GHOST_INT_GO:
	TST.W	GHOSTSTOP(A0)
	BNE.W	GHOST_EXIT
	MOVE.B	#1,(A2)			;clear GHOST MAP 
	MOVE.B	GALPHA(A1),D0
	AND.W	#$0003,D0
	ADD.W	D0,D0
	MOVE.W	GHOST_TAB(PC,D0.W),D0
	JSR	GHOST_TAB(PC,D0.W)
	BRA.B	GHOST_OVER
GHOST_TAB:
PC	set	*
	DC.W	GNORTH-PC
	DC.W	GEAST-PC
	DC.W	GSOUTH-PC
	DC.W	GWEST-PC

GHOST_OVER:
	TST.B	GHOST_OVERLAY(A0)
	BEQ.B	.over
	MOVE.L	ADDRESS_MAP(A0),A2
	MOVE.W	GVX(A1),D0
	LSR.W	#6,D0			;D0=BX
	MOVE.W	GVY(A1),D1
	AND.W	#$0FC0,D1		;D1=BY*64
	ADD.W	D1,D0
	ADD.W	#$7000,D0		;GHOST MAP
	ADD.W	D0,A2			;A2=Address of GHOST place
	MOVE.B	#2,(A2)

.over	CMP.B	#5,GFAIL(A0)
	BCS.B	GHOST_EXIT
	OR.B	#2,GLAST(A0)
	CLR.B	GFAIL(A0)
GHOST_EXIT:	
	RTS

*******************************************************************************
; SUP routine
;
; INPUT : A1 = Address of GHOST_STRUCT
;         A2 = Address of BX,BY
; OUTPUT: D0 = SUP
;         D4 = COD
;

SUP:				;OUTPUT: d0=SUP
	TST.B	1*64(A2)
	BNE.B	SUP_1
	MOVEQ	#0,D0		; SUP=0
	MOVEQ	#0,D4		; COD=0
	RTS
SUP_1:
	MOVE.B	2*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.W	SUP_GHOST
	CMP.B	#3,D0
	BEQ.W	SUP_CYBER

	MOVE.B	3*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.B	SUP_GHOST
	CMP.B	#3,D0
	BEQ.W	SUP_CYBER

	MOVE.B	4*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.B	SUP_GHOST
	CMP.B	#3,D0
	BEQ.B	SUP_CYBER

	MOVE.B	5*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.B	SUP_GHOST
	CMP.B	#3,D0
	BEQ.B	SUP_CYBER

	MOVE.B	6*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.B	SUP_GHOST
	CMP.B	#3,D0
	BEQ.B	SUP_CYBER

	MOVE.B	7*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.B	SUP_GHOST
	CMP.B	#3,D0
	BEQ.B	SUP_CYBER

	MOVE.B	8*64(A2),D0
	BEQ.B	SUP_EXIT
	CMP.B	#2,D0
	BEQ.B	SUP_GHOST
	CMP.B	#3,D0
	BEQ.B	SUP_CYBER

SUP_EXIT:
	TST.W	SUPERPILL(A0)
	BNE.B	SUP_EXITV
	MOVE.B	GLIBERO(A1),D0	; SUP=LIBERO
	MOVEQ	#1,D4		; COD=1
	RTS
SUP_EXITV:
	MOVE.B	GLIBEROV(A1),D0	; SUP=LIBERO VULNERABILE
	MOVEQ	#1,D4		; COD=1
	RTS

SUP_GHOST:
	TST.W	SUPERPILL(A0)
	BNE.B	SUP_GHOSTV
	MOVE.B	GGHOST(A1),D0	; SUP=GHOST
	MOVEQ	#2,D4		; COD=2
	RTS
SUP_GHOSTV:
	MOVE.B	GGHOSTV(A1),D0	; SUP=GHOST VULNERABILE
	MOVEQ	#2,D4		; COD=2
	RTS

SUP_CYBER:
	TST.W	SUPERPILL(A0)
	BNE.B	SUP_CYBERV
	MOVE.B	GCYBER(A1),D0	; SUP=CYBER
	MOVEQ	#3,D4		; COD=3
	RTS
SUP_CYBERV:
	MOVE.B	GCYBERV(A1),D0	; SUP=CYBER VULNERABILE
	MOVEQ	#3,D4		; COD=3
	RTS

*******************************************************************************
; SDW routine
;
; INPUT : A1 = Address of GHOST_STRUCT
;         A2 = Address of BX,BY
; OUTPUT: D1 = SDW
;         D4 = COD
;

SDW:				;OUTPUT: D1=SDW
	TST.B	-1*64(A2)
	BNE.B	SDW_1
	MOVEQ	#0,D1		; SDW=0
	MOVEQ	#0,D4		; COD=0
	RTS
SDW_1:
	MOVE.B	-2*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.W	SDW_GHOST
	CMP.B	#3,D1
	BEQ.W	SDW_CYBER

	MOVE.B	-3*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.B	SDW_GHOST
	CMP.B	#3,D1
	BEQ.W	SDW_CYBER

	MOVE.B	-4*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.B	SDW_GHOST
	CMP.B	#3,D1
	BEQ.B	SDW_CYBER

	MOVE.B	-5*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.B	SDW_GHOST
	CMP.B	#3,D1
	BEQ.B	SDW_CYBER

	MOVE.B	-6*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.B	SDW_GHOST
	CMP.B	#3,D1
	BEQ.B	SDW_CYBER

	MOVE.B	-7*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.B	SDW_GHOST
	CMP.B	#3,D1
	BEQ.B	SDW_CYBER

	MOVE.B	-8*64(A2),D1
	BEQ.B	SDW_EXIT
	CMP.B	#2,D1
	BEQ.B	SDW_GHOST
	CMP.B	#3,D1
	BEQ.B	SDW_CYBER

SDW_EXIT:
	TST.W	SUPERPILL(A0)
	BNE.B	SDW_EXITV
	MOVE.B	GLIBERO(A1),D1	; SDW=LIBERO
	MOVEQ	#1,D4		; COD=1
	RTS
SDW_EXITV:
	MOVE.B	GLIBEROV(A1),D1	; SDW=LIBERO VULNERABILE
	MOVEQ	#1,D4		; COD=1
	RTS

SDW_GHOST:
	TST.W	SUPERPILL(A0)
	BNE.B	SDW_GHOSTV
	MOVE.B	GGHOST(A1),D1	; SDW=GHOST
	MOVEQ	#2,D4		; COD=2
	RTS
SDW_GHOSTV:
	MOVE.B	GGHOSTV(A1),D1	; SDW=GHOST VULNERABILE
	MOVEQ	#2,D4		; COD=2
	RTS

SDW_CYBER:
	TST.W	SUPERPILL(A0)
	BNE.B	SDW_CYBERV
	MOVE.B	GCYBER(A1),D1	; SDW=CYBER
	MOVEQ	#3,D4		; COD=3
	RTS
SDW_CYBERV:
	MOVE.B	GCYBERV(A1),D1	; SDW=CYBER VULNERABILE
	MOVEQ	#3,D4		; COD=3
	RTS

*******************************************************************************
; SLE routine
;
; INPUT : A1 = Address of GHOST_STRUCT
;         A2 = Address of BX,BY
; OUTPUT: D2 = SLE
;         D4 = COD
;

SLE:				;OUTPUT: D2=SLE
	TST.B	-1(A2)
	BNE.B	SLE_1
	MOVEQ	#0,D2		; SLE=0
	MOVEQ	#0,D4		; COD=0
	RTS
SLE_1:
	MOVE.B	-2(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.W	SLE_GHOST
	CMP.B	#3,D2
	BEQ.W	SLE_CYBER

	MOVE.B	-3(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.B	SLE_GHOST
	CMP.B	#3,D2
	BEQ.W	SLE_CYBER

	MOVE.B	-4(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.B	SLE_GHOST
	CMP.B	#3,D2
	BEQ.B	SLE_CYBER

	MOVE.B	-5(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.B	SLE_GHOST
	CMP.B	#3,D2
	BEQ.B	SLE_CYBER

	MOVE.B	-6(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.B	SLE_GHOST
	CMP.B	#3,D2
	BEQ.B	SLE_CYBER

	MOVE.B	-7(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.B	SLE_GHOST
	CMP.B	#3,D2
	BEQ.B	SLE_CYBER

	MOVE.B	-8(A2),D2
	BEQ.B	SLE_EXIT
	CMP.B	#2,D2
	BEQ.B	SLE_GHOST
	CMP.B	#3,D2
	BEQ.B	SLE_CYBER

SLE_EXIT:
	TST.W	SUPERPILL(A0)
	BNE.B	SLE_EXITV
	MOVE.B	GLIBERO(A1),D2	; SLE=LIBERO
	MOVEQ	#1,D4		; COD=1
	RTS
SLE_EXITV:
	MOVE.B	GLIBEROV(A1),D2	; SLE=LIBERO VULNERABILE
	MOVEQ	#1,D4		; COD=1
	RTS

SLE_GHOST:
	TST.W	SUPERPILL(A0)
	BNE.B	SLE_GHOSTV
	MOVE.B	GGHOST(A1),D2	; SLE=GHOST
	MOVEQ	#2,D4		; COD=2
	RTS
SLE_GHOSTV:
	MOVE.B	GGHOSTV(A1),D2	; SLE=GHOST VULNERABILE
	MOVEQ	#2,D4		; COD=2
	RTS

SLE_CYBER:
	TST.W	SUPERPILL(A0)
	BNE.B	SLE_CYBERV
	MOVE.B	GCYBER(A1),D2	; SLE=CYBER
	MOVEQ	#3,D4		; COD=3
	RTS
SLE_CYBERV:
	MOVE.B	GCYBERV(A1),D2	; SLE=CYBER VULNERABILE
	MOVEQ	#3,D4		; COD=3
	RTS

*******************************************************************************
; SRI routine
;
; INPUT : A1 = Address of GHOST_STRUCT
;         A2 = Address of BX,BY
; OUTPUT: D3 = SRI
;         D4 = COD
;

SRI:				;OUTPUT: D3=SRI
	TST.B	1(A2)
	BNE.B	SRI_1
	MOVEQ	#0,D3		; SRI=0
	MOVEQ	#0,D4		; COD=0
	RTS
SRI_1:
	MOVE.B	2(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.W	SRI_GHOST
	CMP.B	#3,D3
	BEQ.W	SRI_CYBER

	MOVE.B	3(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.B	SRI_GHOST
	CMP.B	#3,D3
	BEQ.W	SRI_CYBER

	MOVE.B	4(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.B	SRI_GHOST
	CMP.B	#3,D3
	BEQ.B	SRI_CYBER

	MOVE.B	5(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.B	SRI_GHOST
	CMP.B	#3,D3
	BEQ.B	SRI_CYBER

	MOVE.B	6(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.B	SRI_GHOST
	CMP.B	#3,D3
	BEQ.B	SRI_CYBER

	MOVE.B	7(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.B	SRI_GHOST
	CMP.B	#3,D3
	BEQ.B	SRI_CYBER

	MOVE.B	8(A2),D3
	BEQ.B	SRI_EXIT
	CMP.B	#2,D3
	BEQ.B	SRI_GHOST
	CMP.B	#3,D3
	BEQ.B	SRI_CYBER

SRI_EXIT:
	TST.W	SUPERPILL(A0)
	BNE.B	SRI_EXITV
	MOVE.B	GLIBERO(A1),D3	; SRI=LIBERO
	MOVEQ	#1,D4		; COD=1
	RTS
SRI_EXITV:
	MOVE.B	GLIBEROV(A1),D3	; SRI=LIBERO VULNERABILE
	MOVEQ	#1,D4		; COD=1
	RTS

SRI_GHOST:
	TST.W	SUPERPILL(A0)
	BNE.B	SRI_GHOSTV
	MOVE.B	GGHOST(A1),D3	; SRI=GHOST
	MOVEQ	#2,D4		; COD=2
	RTS
SRI_GHOSTV:
	MOVE.B	GGHOSTV(A1),D3	; SRI=GHOST VULNERABILE
	MOVEQ	#2,D4		; COD=2
	RTS

SRI_CYBER:
	TST.W	SUPERPILL(A0)
	BNE.B	SRI_CYBERV
	MOVE.B	GCYBER(A1),D3	; SRI=CYBER
	MOVEQ	#3,D4		; COD=3
	RTS
SRI_CYBERV:
	MOVE.B	GCYBERV(A1),D3	; SRI=CYBER VULNERABILE
	MOVEQ	#3,D4		; COD=3
	RTS

; END of SEE routines
*******************************************************************************
; GNORTH routine
;

GNORTH:
	MOVE.W	GVY(A1),D5
	AND.B	#$3F,D5		;D5=PBY
	BSR.W	SUP
	MOVE.B	D4,D7		;GSEE=COD
	CMP.B	#32,D5
	BNE.W	GNORTH_L3
	BSR.W	SLE
	BSR.W	SRI
	TST.B	D7
	BLS.B	GNORTH_1
	MOVE.B	D2,D5
	ADD.B	D3,D5		;D5=SLE+SRI
	BLS.B	GNORTH_1
	ADDQ.B	#1,GFAIL(A0)	;INC FAIL
GNORTH_1:
	BTST.B	#1,GLAST(A0)
	BEQ.B	GNORTH_LA
	TST.B	D5
	BEQ.B	GNORTH_LA
	MOVEQ	#0,D0		;SUP=0
	AND.B	#1,GLAST(A0)
GNORTH_LA:
	CMP.B	#2,D5
	BCS.B	GNORTH_L0	;IF (SLE+SRI) <2 then goto GNORTH_L0
	TST.B	D0
	BNE.B	GNORTH_L0
	EOR.B	#1,GLAST(A0)
GNORTH_L0:
	CMP.B	D2,D3		;IF SLE<>SRI then goto GNORTH_CHOOSE
	BNE.B	GNORTH_CHOOSE
	BTST.B	#0,GLAST(A0)
	BNE.B	GNORTH_2
	MOVEQ	#0,D3		;SRI=0
	BRA.B	GNORTH_CHOOSE
GNORTH_2:
	MOVEQ	#0,D2		;SLE=0
GNORTH_CHOOSE:
	CMP.B	#3,D7
	BEQ.B	GNORTH_P
	MOVE.B	D0,D4		;MA=SUP
	MOVEQ	#1,D6		;O=1
	CMP.B	D4,D2		;IF SLE<=MA then goto GNORTH_L1
	BLS.B	GNORTH_L1
	MOVE.B	#3,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
	MOVE.B	D2,D4		;MA=SLE
GNORTH_L1:
	CMP.B	D4,D3		;IF SRI<=MA then goto GNORTH_L2
	BLS.B	GNORTH_L2
	MOVE.B	#1,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
GNORTH_L2:
	TST.B	D6
	BNE.B	GNORTH_INV
	RTS			;HA GIRATO
GNORTH_INV:
	ADD.B	D0,D5		;D5=(SUP+SLE+SRI)
	BHI.B	GNORTH_L3
	MOVE.B	#2,GALPHA(A1)
	RTS
GNORTH_L3:
	TST.B	GBAD(A1)	;AGGRESSIVO?
	BEQ.B	GNORTH_EXIT
GNORTH_P:
	CMP.B	#3,D7
	BNE.B	GNORTH_EXIT
	MOVE.W	GVY(A1),D6
	MOVE.W	GSPEED(A1),D5
	MOVE.W	D5,D4
	NOT.W	D4
	AND.W	D4,D6
	ADD.W	D5,D6
	ADD.W	D5,D6
	MOVE.W	D6,GVY(A1)
	RTS
GNORTH_EXIT:
	MOVE.W	GSPEED(A1),D5
	ADD.W	D5,GVY(A1)
	RTS
; END of GNORTH routine
*******************************************************************************
; GEAST routine
;

GEAST:
	MOVE.W	GVX(A1),D5
	AND.B	#$3F,D5		;D5=PBX
	BSR.W	SRI
	MOVE.B	D4,D7		;GSEE=COD
	CMP.B	#32,D5
	BNE.W	GEAST_L3
	BSR.W	SUP
	BSR.W	SDW
	TST.B	D7
	BLS.B	GEAST_1
	MOVE.B	D0,D5
	ADD.B	D1,D5		;D5=SUP+SDW
	BLS.B	GEAST_1
	ADDQ.B	#1,GFAIL(A0)	;INC FAIL
GEAST_1:
	BTST.B	#1,GLAST(A0)
	BEQ.B	GEAST_LA
	TST.B	D5
	BEQ.B	GEAST_LA
	MOVEQ	#0,D3		;SRI=0
	AND.B	#1,GLAST(A0)
GEAST_LA:
	CMP.B	#2,D5
	BCS.B	GEAST_L0	;IF (SUP+SDW) <2 then goto GEAST_L0
	TST.B	D3
	BNE.B	GEAST_L0
	EOR.B	#1,GLAST(A0)
GEAST_L0:
	CMP.B	D0,D1		;IF SUP<>SDW then goto GEAST_CHOOSE
	BNE.B	GEAST_CHOOSE
	BTST.B	#0,GLAST(A0)
	BNE.B	GEAST_2
	MOVEQ	#0,D1		;SDW=0
	BRA.B	GEAST_CHOOSE
GEAST_2:
	MOVEQ	#0,D0		;SUP=0
GEAST_CHOOSE:
	CMP.B	#3,D7
	BEQ.B	GEAST_P
	MOVE.B	D3,D4		;MA=SRI
	MOVEQ	#1,D6		;O=1
	CMP.B	D4,D0		;IF SUP<=MA then goto GEAST_L1
	BLS.B	GEAST_L1
	MOVE.B	#0,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
	MOVE.B	D0,D4		;MA=SUP
GEAST_L1:
	CMP.B	D4,D1		;IF SDW<=MA then goto GEAST_L2
	BLS.B	GEAST_L2
	MOVE.B	#2,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
GEAST_L2:
	TST.B	D6
	BNE.B	GEAST_INV
	RTS			;HA GIRATO
GEAST_INV:
	ADD.B	D3,D5		;D5=(SRI+SUP+SDW)
	BHI.B	GEAST_L3
	MOVE.B	#3,GALPHA(A1)
	RTS
GEAST_L3:
	TST.B	GBAD(A1)	;AGGRESSIVO?
	BEQ.B	GEAST_EXIT
GEAST_P:
	CMP.B	#3,D7
	BNE.B	GEAST_EXIT
	MOVE.W	GVX(A1),D6
	MOVE.W	GSPEED(A1),D5
	MOVE.W	D5,D4
	NOT.W	D4
	AND.W	D4,D6
	ADD.W	D5,D6
	ADD.W	D5,D6
	MOVE.W	D6,GVX(A1)
	RTS
GEAST_EXIT:
	MOVE.W	GSPEED(A1),D5
	ADD.W	D5,GVX(A1)
	RTS
; END of GEAST routine
*******************************************************************************
; GSOUTH routine
;

GSOUTH:
	MOVE.W	GVY(A1),D5
	AND.B	#$3F,D5		;D5=PBY
	BSR.W	SDW
	MOVE.B	D4,D7		;GSEE=COD
	CMP.B	#32,D5
	BNE.W	GSOUTH_L3
	BSR.W	SLE
	BSR.W	SRI
	TST.B	D7
	BLS.B	GSOUTH_1
	MOVE.B	D2,D5
	ADD.B	D3,D5		;D5=SLE+SRI
	BLS.B	GSOUTH_1
	ADDQ.B	#1,GFAIL(A0)	;INC FAIL
GSOUTH_1:
	BTST.B	#1,GLAST(A0)
	BEQ.B	GSOUTH_LA
	TST.B	D5
	BEQ.B	GSOUTH_LA
	MOVEQ	#0,D1		;SDW=0
	AND.B	#1,GLAST(A0)
GSOUTH_LA:
	CMP.B	#2,D5
	BCS.B	GSOUTH_L0	;IF (SLE+SRI) <2 then goto GSOUTH_L0
	TST.B	D1
	BNE.B	GSOUTH_L0
	EOR.B	#1,GLAST(A0)
GSOUTH_L0:
	CMP.B	D2,D3		;IF SLE<>SRI then goto GSOUTH_CHOOSE
	BNE.B	GSOUTH_CHOOSE
	BTST.B	#0,GLAST(A0)
	BNE.B	GSOUTH_2
	MOVEQ	#0,D2		;SLE=0
	BRA.B	GSOUTH_CHOOSE
GSOUTH_2:
	MOVEQ	#0,D3		;SRI=0
GSOUTH_CHOOSE:
	CMP.B	#3,D7
	BEQ.B	GSOUTH_P
	MOVE.B	D1,D4		;MA=SDW
	MOVEQ	#1,D6		;O=1
	CMP.B	D4,D3		;IF SRI<=MA then goto GSOUTH_L1
	BLS.B	GSOUTH_L1
	MOVE.B	#1,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
	MOVE.B	D3,D4		;MA=SRI
GSOUTH_L1:
	CMP.B	D4,D2		;IF SLE<=MA then goto GSOUTH_L2
	BLS.B	GSOUTH_L2
	MOVE.B	#3,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
GSOUTH_L2:
	TST.B	D6
	BNE.B	GSOUTH_INV
	RTS			;HA GIRATO
GSOUTH_INV:
	ADD.B	D1,D5		;D5=(SDW+SLE+SRI)
	BHI.B	GSOUTH_L3
	MOVE.B	#0,GALPHA(A1)
	RTS
GSOUTH_L3:
	TST.B	GBAD(A1)	;AGGRESSIVO?
	BEQ.B	GSOUTH_EXIT
GSOUTH_P:
	CMP.B	#3,D7
	BNE.B	GSOUTH_EXIT
	MOVE.W	GVY(A1),D6
	MOVE.W	GSPEED(A1),D5
	MOVE.W	D5,D4
	NOT.W	D4
	AND.W	D4,D6
	SUB.W	D5,D6
	SUB.W	D5,D6
	MOVE.W	D6,GVY(A1)
	RTS
GSOUTH_EXIT:
	MOVE.W	GSPEED(A1),D5
	SUB.W	D5,GVY(A1)
	RTS
; END of GSOUTH routine
*******************************************************************************
; GWEST routine
;

GWEST:
	MOVE.W	GVX(A1),D5
	AND.B	#$3F,D5		;D5=PBX
	BSR.W	SLE
	MOVE.B	D4,D7		;GSEE=COD
	CMP.B	#32,D5
	BNE.W	GWEST_L3
	BSR.W	SUP
	BSR.W	SDW
	TST.B	D7
	BLS.B	GWEST_1
	MOVE.B	D0,D5
	ADD.B	D1,D5		;D5=SUP+SDW
	BLS.B	GWEST_1
	ADDQ.B	#1,GFAIL(A0)	;INC FAIL
GWEST_1:
	BTST.B	#1,GLAST(A0)
	BEQ.B	GWEST_LA
	TST.B	D5
	BEQ.B	GWEST_LA
	MOVEQ	#0,D2		;SLE=0
	AND.B	#1,GLAST(A0)
GWEST_LA:
	CMP.B	#2,D5
	BCS.B	GWEST_L0	;IF (SUP+SDW) <2 then goto GWEST_L0
	TST.B	D2
	BNE.B	GWEST_L0
	EOR.B	#1,GLAST(A0)
GWEST_L0:
	CMP.B	D0,D1		;IF SUP<>SDW then goto GWEST_CHOOSE
	BNE.B	GWEST_CHOOSE
	BTST.B	#0,GLAST(A0)
	BNE.B	GWEST_2
	MOVEQ	#0,D0		;SUP=0
	BRA.B	GWEST_CHOOSE
GWEST_2:
	MOVEQ	#0,D1		;SDW=0
GWEST_CHOOSE:
	CMP.B	#3,D7
	BEQ.B	GWEST_P
	MOVE.B	D2,D4		;MA=SLE
	MOVEQ	#1,D6		;O=1
	CMP.B	D4,D1		;IF SDW<=MA then goto GWEST_L1
	BLS.B	GWEST_L1
	MOVE.B	#2,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
	MOVE.B	D1,D4		;MA=SDW
GWEST_L1:
	CMP.B	D4,D0		;IF SUP<=MA then goto GWEST_L2
	BLS.B	GWEST_L2
	MOVE.B	#0,GALPHA(A1)
	MOVEQ	#0,D6		;O=0
GWEST_L2:
	TST.B	D6
	BNE.B	GWEST_INV
	RTS			;HA GIRATO
GWEST_INV:
	ADD.B	D2,D5		;D5=(SLE+SUP+SDW)
	BHI.B	GWEST_L3
	MOVE.B	#1,GALPHA(A1)
	RTS
GWEST_L3:
	TST.B	GBAD(A1)	;AGGRESSIVO?
	BEQ.B	GWEST_EXIT
GWEST_P:
	CMP.B	#3,D7
	BNE.B	GWEST_EXIT
	MOVE.W	GVX(A1),D6
	MOVE.W	GSPEED(A1),D5
	MOVE.W	D5,D4
	NOT.W	D4
	AND.W	D4,D6
	SUB.W	D5,D6
	SUB.W	D5,D6
	MOVE.W	D6,GVX(A1)
	RTS
GWEST_EXIT:
	MOVE.W	GSPEED(A1),D5
	SUB.W	D5,GVX(A1)
	RTS
; END of GWEST routine
*******************************************************************************
; END of GHOST_INT routine
*******************************************************************************
*******************************************************************************
; RADAR_EAT                                                   27 Apr 1993
;
;  att!-non modificare D2,A1

RADAR_EAT:
;	TST.B	RADAR(A0)
;	BEQ.B	RADAR_EAT_EXIT
	MOVE.W	BX(A0),D0
	MOVE.W	BY(A0),D1
	MOVE.W	LEVEL(A0),D3
	ADD.W	D3,D3
	MOVE.W	RADAR_TAB_EAT(PC,D3.W),D3
	JMP	RADAR_TAB_EAT(PC,D3.W)
RADAR_TAB_EAT:
PC	set	*
	DC.W	RADAR_EAT_EXIT-PC
	DC.W	RADAR_EAT_1-PC
	DC.W	RADAR_EAT_2-PC
	DC.W	RADAR_EAT_3-PC
	DC.W	RADAR_EAT_4-PC
	DC.W	RADAR_EAT_5-PC
RADAR_EAT_EXIT:
	RTS

RADAR_EAT_1:
	MOVE.L	RADAR_PT(A0),A5
	MOVE.W	D0,D3		;D3=BX
	LSR.W	#1,D3		;D3=BX/2
	MULU.W	#40,D1		;D1=BY*4*10
	SUB.W	D1,D3
	ADD.W	#$17D2,D3
	ADD.W	D3,A5		;A5=V
	BTST.L	#0,D0
	BNE.W	RADAR_EAT_H_134
	BRA.W	RADAR_EAT_L_134

RADAR_EAT_2:
	MOVE.L	RADAR_PT(A0),A5
	SUB.W	#31,D0
	MOVE.W	D0,D3		;D3=BX
	LSR.W	#1,D3		;D3=BX/2
	MULU.W	#48,D1		;D1=BY*4*12
	SUB.W	D1,D3
	ADD.W	#$1CE4,D3
	ADD.W	D3,A5		;A5=V
	BTST.L	#0,D0
	BNE.W	RADAR_EAT_H_2
	BRA.W	RADAR_EAT_L_2

RADAR_EAT_3:
	MOVE.L	RADAR_PT(A0),A5
	SUB.W	#42,D1
	MOVE.W	D0,D3		;D3=BX
	LSR.W	#1,D3		;D3=BX/2
	MULU.W	#40,D1		;D1=BY*4*10
	SUB.W	D1,D3
	ADD.W	#$207E,D3
	ADD.W	D3,A5		;A5=V
	BTST.L	#0,D0
	BNE.W	RADAR_EAT_H_134
	BRA.W	RADAR_EAT_L_134

RADAR_EAT_4:
	MOVE.L	RADAR_PT(A0),A5
	SUB.W	#27,D0
	SUB.W	#44,D1
	MOVE.W	D0,D3		;D3=BX
	LSR.W	#1,D3		;D3=BX/2
	MULU.W	#40,D1		;D1=BY*4*10
	SUB.W	D1,D3
	ADD.W	#$242A,D3
	ADD.W	D3,A5		;A5=V
	BTST.L	#0,D0
	BNE.W	RADAR_EAT_H_134
	BRA.W	RADAR_EAT_L_134

RADAR_EAT_5:
	MOVE.L	RADAR_PT(A0),A5
	SUB.W	#49,D0
	SUB.W	#40,D1
	MOVE.W	D0,D3		;D3=BX
	LSR.W	#1,D3		;D3=BX/2
	MULU.W	#32,D1		;D1=BY*4*8
	SUB.W	D1,D3
	ADD.W	#$27D8,D3
	ADD.W	D3,A5		;A5=V
	BTST.L	#0,D0
	BNE.W	RADAR_EAT_H_5
	BRA.W	RADAR_EAT_L_5

RADAR_EAT_H_134:
	AND.B	#$F0,(A5)	;D7=0 : Clear
	AND.B	#$F0,10(A5)	;  =1 : Set PILL
	AND.B	#$F0,20(A5)	;  =2 : Set SUPERPILL
	AND.B	#$F0,30(A5)
	TST.B	D7		;Set PILL / SUPERPILL ?
	BEQ.B	.exit
	OR.B	#$02,20(A5)	;Set PILL
	CMP.W	#1,D7
	BEQ.B	.exit
	OR.B	#$06,10(A5)	;Set SUPERPILL
	OR.B	#$06,20(A5)
.exit	RTS

RADAR_EAT_L_134:
	AND.B	#$0F,(A5)	;D7=0 : Clear
	AND.B	#$0F,10(A5)	;  =1 : Set PILL
	AND.B	#$0F,20(A5)	;  =2 : Set SUPERPILL
	AND.B	#$0F,30(A5)
	TST.B	D7		;Set PILL / SUPERPILL ?
	BEQ.B	.exit
	OR.B	#$20,20(A5)	;Set PILL
	CMP.W	#1,D7
	BEQ.B	.exit
	OR.B	#$60,10(A5)	;Set SUPERPILL
	OR.B	#$60,20(A5)
.exit	RTS

RADAR_EAT_H_2:
	AND.B	#$F0,(A5)	;D7=0 : Clear
	AND.B	#$F0,12(A5)	;  =1 : Set PILL
	AND.B	#$F0,24(A5)	;  =2 : Set SUPERPILL
	AND.B	#$F0,36(A5)
	TST.B	D7		;Set PILL / SUPERPILL ?
	BEQ.B	.exit
	OR.B	#$02,24(A5)	;Set PILL
	CMP.W	#1,D7
	BEQ.B	.exit
	OR.B	#$06,12(A5)	;Set SUPERPILL
	OR.B	#$06,24(A5)
.exit	RTS

RADAR_EAT_L_2:
	AND.B	#$0F,(A5)	;D7=0 : Clear
	AND.B	#$0F,12(A5)	;  =1 : Set PILL
	AND.B	#$0F,24(A5)	;  =2 : Set SUPERPILL
	AND.B	#$0F,36(A5)
	TST.B	D7		;Set PILL / SUPERPILL ?
	BEQ.B	.exit
	OR.B	#$20,24(A5)	;Set PILL
	CMP.W	#1,D7
	BEQ.B	.exit
	OR.B	#$60,12(A5)	;Set SUPERPILL
	OR.B	#$60,24(A5)
.exit	RTS

RADAR_EAT_H_5:
	AND.B	#$F0,(A5)	;D7=0 : Clear
	AND.B	#$F0,8(A5)	;  =1 : Set PILL
	AND.B	#$F0,16(A5)	;  =2 : Set SUPERPILL
	AND.B	#$F0,24(A5)
	TST.B	D7		;Set PILL / SUPERPILL ?
	BEQ.B	.exit
	OR.B	#$02,16(A5)	;Set PILL
	CMP.W	#1,D7
	BEQ.B	.exit
	OR.B	#$06,8(A5)	;Set SUPERPILL
	OR.B	#$06,16(A5)
.exit	RTS

RADAR_EAT_L_5:
	AND.B	#$0F,(A5)	;D7=0 : Clear
	AND.B	#$0F,8(A5)	;  =1 : Set PILL
	AND.B	#$0F,16(A5)	;  =2 : Set SUPERPILL
	AND.B	#$0F,24(A5)
	TST.B	D7		;Set PILL / SUPERPILL ?
	BEQ.B	.exit
	OR.B	#$20,16(A5)	;Set PILL
	CMP.W	#1,D7
	BEQ.B	.exit
	OR.B	#$60,8(A5)	;Set SUPERPILL
	OR.B	#$60,16(A5)
.exit	RTS

; END of RADAR_EAT routine
*******************************************************************************
; RADAR_BONUS                                                 27 Apr 1993
;
;

RADAR_BONUS:
	TST.B	RADAR(A0)
	BEQ.B	RADAR_BONUS_EXIT
	MOVE.W	LEVEL(A0),D1
	ADD.W	D1,D1
	MOVE.W	RADAR_TAB_BONUS(PC,D1.W),D1
	JMP	RADAR_TAB_BONUS(PC,D1.W)
RADAR_TAB_BONUS:
PC	set	*
	DC.W	RADAR_BONUS_EXIT-PC
	DC.W	RADAR_BONUS_1-PC
	DC.W	RADAR_BONUS_2-PC
	DC.W	RADAR_BONUS_3-PC
	DC.W	RADAR_BONUS_4-PC
	DC.W	RADAR_BONUS_5-PC
RADAR_BONUS_EXIT:
	RTS

RADAR_BONUS_1:
	MOVE.L	RADAR_PT(A0),A5
	ADD.L	#$166E,A5
	BRA.W	RADAR_BONUS_H_134

RADAR_BONUS_2:
	MOVE.L	RADAR_PT(A0),A5
	ADD.L	#$1A77,A5
	AND.B	#$F0,(A5)
	AND.B	#$F0,12(A5)
	AND.B	#$F0,24(A5)
	AND.B	#$F0,36(A5)
	TST.B	D7
	BNE.B	.exit
	OR.B	#$02,12(A5)
	OR.B	#$07,24(A5)
	OR.B	#$02,36(A5)
.exit	RTS

RADAR_BONUS_3:
	MOVE.L	RADAR_PT(A0),A5
	ADD.L	#$1ECA,A5
	BRA.B	RADAR_BONUS_L_134

RADAR_BONUS_4:
	MOVE.L	RADAR_PT(A0),A5
	ADD.L	#$2227,A5
	BRA.B	RADAR_BONUS_H_134

RADAR_BONUS_5:
	MOVE.L	RADAR_PT(A0),A5
	ADD.L	#$26FB,A5
	AND.B	#$F0,(A5)
	AND.B	#$F0,8(A5)
	AND.B	#$F0,16(A5)
	AND.B	#$F0,24(A5)
	TST.B	D7
	BNE.B	.exit
	OR.B	#$02,8(A5)
	OR.B	#$07,16(A5)
	OR.B	#$02,24(A5)
.exit	RTS
*******
RADAR_BONUS_L_134:
	AND.B	#$F0,(A5)
	AND.B	#$F0,10(A5)
	AND.B	#$F0,20(A5)
	AND.B	#$F0,30(A5)
	TST.B	D7
	BNE.B	.exit
	OR.B	#$02,10(A5)
	OR.B	#$07,20(A5)
	OR.B	#$02,30(A5)
.exit	RTS

RADAR_BONUS_H_134:
	AND.B	#$0F,(A5)
	AND.B	#$0F,10(A5)
	AND.B	#$0F,20(A5)
	AND.B	#$0F,30(A5)
	TST.B	D7
	BNE.B	.exit
	OR.B	#$20,10(A5)
	OR.B	#$70,20(A5)
	OR.B	#$20,30(A5)
.exit	RTS

; END of RADAR_BONUS routine
*******************************************************************************
