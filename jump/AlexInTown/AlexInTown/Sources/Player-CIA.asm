;=============================================================================
;================================== a h x ====================================
;=============================================================================
;=================== r e p l a y e r routines  ==========================
;=============================================================================
;=============================================================================
;========================= v e r s i o n   1 . 3 ===========================
;=============================================================================
;=============================================================================
    XDEF _InitPlayer
    XDEF _TitleSong
    XDef _InGameSong
    XDEF _GameOverSong
    XDEF _WinSong
    XDEF _StopSong
    XDEF _KillPlayer
  ;-------------------T-----------T-----------------T---------T---------------

ahxInitCIA          = 0*4
ahxInitPlayer       = 1*4
ahxInitModule       = 2*4
ahxInitSubSong      = 3*4
ahxInterrupt        = 4*4
ahxStopSong         = 5*4
ahxKillPlayer       = 6*4
ahxKillCIA          = 7*4
ahxNextPattern      = 8*4       ;implemented, although no-one requested it :-)
ahxPrevPattern      = 9*4       ;implemented, although no-one requested it :-)

ahxBSS_P            = 10*4      ;pointer to ahx's public (fast) memory block
ahxBSS_C            = 11*4      ;pointer to ahx's explicit chip memory block
ahxBSS_Psize        = 12*4      ;size of public memory (intern use only!)
ahxBSS_Csize        = 13*4      ;size of chip memory (intern use only!)
ahxModule           = 14*4      ;pointer to ahxModule after InitModule
ahxIsCIA            = 15*4      ;byte flag (using ANY (intern/own) cia?)
ahxTempo            = 16*4      ;word to cia tempo (normally NOT needed to xs)

ahx_pExternalTiming = 0         ;byte, offset to public memory block
ahx_pMainVolume     = 1         ;byte, offset to public memory block
ahx_pSubsongs       = 2         ;byte, offset to public memory block
ahx_pSongEnd        = 3         ;flag, offset to public memory block
ahx_pPlaying        = 4         ;flag, offset to public memory block
ahx_pVoice0Temp     = 14        ;struct, current Voice 0 values
ahx_pVoice1Temp     = 246       ;struct, current Voice 1 values
ahx_pVoice2Temp     = 478       ;struct, current Voice 2 values
ahx_pVoice3Temp     = 710       ;struct, current Voice 3 values

ahx_pvtTrack        = 0         ;byte          (relative to ahx_pVoiceXTemp!)
ahx_pvtTranspose    = 1         ;byte          (relative to ahx_pVoiceXTemp!)
ahx_pvtNextTrack    = 2         ;byte          (relative to ahx_pVoiceXTemp!)
ahx_pvtNextTranspose= 3         ;byte          (relative to ahx_pVoiceXTemp!)
ahx_pvtADSRVolume   = 4         ;word, 0..64:8 (relative to ahx_pVoiceXTemp!)
ahx_pvtAudioPointer = 92        ;pointer       (relative to ahx_pVoiceXTemp!)
ahx_pvtAudioPeriod  = 100       ;word          (relative to ahx_pVoiceXTemp!)
ahx_pvtAudioVolume  = 102       ;word          (relative to ahx_pVoiceXTemp!)

; current ADSR Volume (0..64) = ahx_pvtADSR.w >> 8        (I use 24:8 32-Bit)
; ahx_pvtAudioXXX are the REAL Values passed to the hardware!

_InitPlayer
    lea    _ahxCIAInterrupt,a0
    moveq    #0,d0
    jsr    ahxReplayer+ahxInitCIA
    tst    d0
    bne.b   _ahxInitFailed
    sub.l    a0,a0    ;auto-allocate public (fast)
    sub.l    a1,a1    ;auto-allocate chip
    moveq    #0,d0    ;load waves from hd if possible
    moveq    #0,d1
    jsr    ahxReplayer+ahxInitPlayer
    rts

_TitleSong
    lea    ahxTitleMod,a0    ;Title module
    jsr    _StartSong
    rts

_InGameSong
    lea    ahxInGameMod,a0    ;InGame Module
    jsr    _StartSong
    rts


_GameOverSong
    lea    ahxGameOverMod,a0    ;GameOver Module
    jsr    _StartSong
    rts

_WinSong
    lea    ahxWinMod,a0    ;GameOver Module
    jsr    _StartSong
    rts

_StartSong
    jsr    ahxReplayer+ahxInitModule
    ;check d0=result normally here...
    moveq    #0,d0    ;Subsong #0 = Mainsong
    moveq    #0,d1    ;Play immediately
    jsr    ahxReplayer+ahxInitSubSong
    rts


_StopSong
    jsr    ahxReplayer+ahxStopSong
    rts

_KillPlayer
    jsr    ahxReplayer+ahxKillPlayer ;don't forget!
    jsr    ahxReplayer+ahxKillCIA    ;don't forget!
    rts

_ahxInitFailed
    moveq    #0,d0
    RTS

_ahxCIAInterrupt
    jsr    ahxReplayer+ahxInterrupt
    RTS

ahxReplayer    IncBIN    AHX-Replayer.bin ;Available in the AHX pack.
ahxTitleMod    IncBIN    Title.AHX
ahxInGameMod   IncBIN    Ingame.AHX
ahxGameOverMod IncBIN    GameOver.AHX
ahxWinMod      IncBIN    Win.AHX

;Sorry I haven't included the mods in the archive. They are pretty
;easy for rip anyway.