	IFND DYNAMITE_I
DYNAMITE_I	SET	1

;	Assembler includes for dynamite bot developers
;	Created by Ilkka Lehtoranta 3-Jun-2001
;			   updated 10-jun-2001

	IFND EXEC_LISTS_I
	INCLUDE "exec/lists.i"
	ENDC	; EXEC_LISTS_I

	IFND EXEC_SEMAPHORES_I
	INCLUDE "exec/semaphores.i"
	ENDC	; EXEC_SEMAPHORES_I


*	plr_Status		*

PA_NONE		EQU	0	; no player
PA_VISI		EQU	1	; visitor
PA_LOGGEDIN	EQU	2	; just logged in/after a game
PA_PLAYING	EQU	3	; is in game (no matter if he's dead)
PA_COUNTDOWN	EQU	4	; this is of no use. players only have this status if they logged in.
PA_DEAD		EQU	5	; this is of no use, it's not meant to see if a player is actually dead.
				; use player.dead instead. it's only set after successfull login for
				; other players
PA_WON		EQU	6	; a player has this status if he won the last round


*	ds_GameRunning		*

GAME_NOTCONNECTED	EQU	0	; game is not connected (startscreen)
GAME_CLOSEGAME		EQU	1	; transitional state to GAME_MENU after connection got closed
GAME_MENU       	EQU	2	; game is in menu eg: login screen
GAME_ENDGAME		EQU	3	; transitional state to GAME_MENU after effect has been drawn
GAME_EFFECT     	EQU	4	; game draws effect after a match
GAME_COUNTDOWN		EQU	5	; game is doing countdown
GAME_GAME       	EQU	6	; game is running
GAME_HURRYUP		EQU	7	; game is running and is in hurry up mode

DIR_NONE		EQU	-1
DIR_DOWN		EQU	0
DIR_RIGHT		EQU	1
DIR_LEFT		EQU	2
DIR_UP			EQU	3

SPEED_NORMAL		EQU	4
SPEED_SLOW		EQU	3
SPEED_FAST		EQU	6

BLOCK_FAKEBLOCK		EQU	-1	; used for remote/kick bombs which are placed into the map
BLOCK_NOBLOCK		EQU	0	; empty field
BLOCK_HARDBLOCK		EQU	1	; non-destroyable block
BLOCK_DESTROYABLE	EQU	2	; normal block
BLOCK_BOMB		EQU	3	; normal bomb
BLOCK_BORDERWALL1	EQU	4	; borderblocks are equal to hardblock
BLOCK_BORDERWALL2	EQU	5
BLOCK_BORDERWALL3	EQU	6
BLOCK_BORDERWALL4	EQU	7
BLOCK_BORDERWALL5	EQU	8
BLOCK_BORDERWALL6	EQU	10
BLOCK_BORDERWALL7	EQU	11
BLOCK_BORDERWALL8	EQU	12
BLOCK_BORDERWALL9	EQU	13
BLOCK_BORDERWALL10	EQU	14
BLOCK_BORDERWALL11	EQU	15
BLOCK_BORDERWALL12	EQU	16
BLOCK_ADDBOMB		EQU	19	; block which contains a bomb

BO_EXPANDFLAME		EQU	1	; types for bonusgrid
BO_ADDBOMB		EQU	2
BO_FLAMEMAX		EQU	3
BO_BOMBMAX		EQU	4
BO_RANDOMWALL		EQU	5
BO_BOMBS2BLOCKS		EQU	6
BO_DROPALL		EQU	7
BO_EXPLALL		EQU	8
BO_FASTER		EQU	9
BO_SLOWER		EQU	10
BO_SHORTERFUSE		EQU	11	; min fuse is 20 and max is 65
BO_LONGERFUSE		EQU	12
BO_SHORTERFLAME		EQU	13
BO_SWAPCONTROLSLR	EQU	14
BO_FEWERBOMBS		EQU	15
BO_NODROP		EQU	16
BO_SHIELD		EQU	17
BO_STANDSTILL		EQU	18
BO_TELEPORT		EQU	19
BO_REMOTEBOMB		EQU	20
BO_BACK2BASIC		EQU	21
BO_KICKBOMB		EQU	22
BO_SABER		EQU	23
BO_SWAPCONTROLSUD	EQU	24
BO_MAGNET		EQU	25
BO_PHOENIX		EQU	26
BO_DOHURRYUP		EQU	27
BO_INVISIBLE		EQU	28
BO_DUELL		EQU	29
BO_AFTERBURNER		EQU	30
BO_FLAG			EQU	31
BO_TELEPORTALL		EQU	32
BO_MAPJUMP		EQU	33
BO_RESTARTMAP		EQU	34
BO_SWAPPOSITIONS	EQU	35
BO_MAX			EQU	36


BOMB_NORMAL	EQU	0	; normal bomb
BOMB_GEN	EQU	1	; predefined bomb (map)
BOMB_REMOTE	EQU	2	; remote bomb
BOMB_KICK	EQU	3	; kick bomb


	STRUCTURE ServerData,0
	STRUCT	sd_ServerName,34
	STRUCT	sd_SysOpName,18
	WORD	sd_MaxSlots
	WORD	sd_MaxObservers
	LABEL	ServerData_SIZEOF

	STRUCTURE TempBomb,0
	STRUCT	bmb_Node,MLN_SIZE
	WORD	bmb_BlockX
	WORD	bmb_BlockY
	WORD	bmb_PixelX
	WORD	bmb_PixelY
	WORD	bmb_Fuse		; >0 bomb is still ticking; =0 bomb is going to explode
	LONG	bmb_Range
	WORD	bmb_Direction		; in case of kick/remote bomb holds the direction
	WORD	bmb_OriginX		; holds the x/y pos (block) where the bomb was placed
	WORD	bmb_OriginY		; useful to find kick/remotebombs
	WORD	bmb_Type		; is set to one of BOMB_#?
	LABEL	TempBomb_SIZEOF

	STRUCTURE Player,0
	WORD	plr_Player		; player num
	LONG	plr_Status		; this is set to one of PA_#?
	WORD	plr_Dead		; >0 = player is alive
	WORD	plr_PixelX		; xpos + border (24 pixel)
	WORD	plr_PixelY		; ypos + border (16 pixel)
	WORD	plr_BlockX		; xpos (block number)
	WORD	plr_BlockY		; ypos (block number)

	WORD	plr_BombCount		; how many bombs this player has currently ticking
	WORD	plr_MxKickBombs		; how many kickbombs this player has

	APTR	plr_RemoteBomb		; -> Bomb Node

	WORD	plr_MaxRange		; flamele of player ranging from 2-15
	WORD	plr_MaxBombs		; how many bombs this player can drop
	WORD	plr_FuseLength		; fuselength of bombs the player can drop
	WORD	plr_Speed		; player speed; SPEED_NORMAL=4, SPEED_SLOW=3, SPEED_FAST=6
	WORD	plr_SpeedC		; >0 = player has other speed (SPEED_SLOW, SPEED_FAST)

	WORD	plr_SwapHoriz		; >0 = swaped horizontal controls
	WORD	plr_SwapVert
	WORD	plr_NoDrop		; >0 = player can't drop bombs

	WORD	plr_ShieldCount		; >0 = player has shield
	WORD	plr_StandStillCount	; >0 = player can't move
	WORD	plr_InvisibleCount	; >0 = player is invisible
	WORD	plr_AfrerBurnerCount	; >0 = player has afterburner
	WORD	plr_b2bc

	WORD	plr_FlameThrowerCount	; >0 = player has lightsaber
	WORD	plr_FlameThrowerDir
	WORD	plr_FlameThrowerRange	; 0-4

	WORD	plr_MagnetCount
	WORD	plr_MagnetDir

	STRUCT	plr_Name,34
	STRUCT	plr_System,64
	LABEL	Player_SIZEOF

	STRUCTURE dynSemaphore,0
	STRUCT	ds_Semaphore,SS_SIZE	; embedded signalsemaphore
	LONG	ds_OpenCnt
	LONG	ds_Quit			; dynamite will set this to 1 if it wants to quit
	LONG	ds_GameRunning		; is set to one of GAME_#?
	LONG	ds_Frames
	LONG	ds_Walk			; set to one of DIR_ to make the player move or stop
	LONG	ds_Drop			; set to 1 to drop a bomb
	LONG	ds_DropKick		; set to 1 to drop a kickbomb
	LONG	ds_PlayerNum		; 0-15
	APTR	ds_Players		; array to players (0-15)
	LONG	ds_MapWidth		; holds the width of the map in blocks
	LONG	ds_MapHeight		; holds the height of the map in blocks
	APTR	ds_Grid			; array ptr to the actual map (29 entries max). each entry contains 1 line of the map without powerups
	APTR	ds_BonusGrid
	APTR	ds_AddBubble		; setting this pointer to a string will make dynamite show the string given here as bubble. dynamite
					; will reset this pointer to 0 after succesfull creation of the bubble
	APTR	ds_ServerData		; see serverdata for details
	APTR	ds_ExplosionGrid	; array ptr to the explosion map (29 entries max). each entry contains 1 line of the explosion map
					; this map reflects where currently explosions are (explosion=1)
					; each element of line is CHAR sized
	LONG	ds_Version		; holds the version of dynamite (e.g. 45)

	APTR	ds_BotInfo		; pointer to an array of 255 (so 255 bots max are
					; supported with this array) long pointers to hold a
					; string (versioninfo, description) of your bot.
					; You should set the entry for your bot after
					; opencnt has been increased by your bot and set it
					; back to NULL if your bot is about to decrease the
					; opencnt again on quit.

					; entry for your bot in this array is opencnt after
					; increasing (on botstartup, see example)

	APTR	BombListHeader	; -> MLH doubly linked list of bombs belonging to this player

	LABEL	dynSemaphore_SIZEOF

	ENDC	; DYNAMITE_I