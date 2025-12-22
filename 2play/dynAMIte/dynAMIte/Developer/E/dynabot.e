MODULE  'dos/dos'

MODULE  '*dynamite'

PROC main()

  DEF done=FALSE, delay

  DEF dynasema=NIL:PTR TO dynamitesemaphore

  DEF ourplayer:PTR TO player, oldframe=0

  DEF thisbotnum

  -> check if dynamite is running

  -> try to find the semaphore
  Forbid()
  IF dynasema:=FindSemaphore('dynAMIte.0')
    -> increase opencount to tell dynamite that you are using the
    -> semaphore.  dynamite will remove the semaphore only if opencnt is
    -> 0 at its end

    dynasema.opencnt:=dynasema.opencnt+1
    thisbotnum:=dynasema.opencnt

    -> set botinfo string
    dynasema.botinfo[thisbotnum]:='dynamite sample bot v1.0 - doing nothing useful'
  ENDIF
  Permit()

  IF dynasema
    WriteF('dynAMIte is started\n')

    WriteF('Clients using the semaphore: \d\n',dynasema.opencnt)

    WHILE done=FALSE

      IF CheckSignal(SIGBREAKF_CTRL_C)

        done:=TRUE

      ELSE

        delay:=TRUE

        ObtainSemaphore(dynasema) -> lock it

        -> check if dynamite wants to quit
        IF dynasema.quit=1

          -> dynamite wants to quit, so we do dynamite a favour
          WriteF('dynAMIte is about to quit...\n')
          done:=TRUE

        ELSE

          -> if a game is running
          IF (dynasema.gamerunning>=GAME_GAME) AND (dynasema.gamerunning<GAME_NOTCONNECTED)

            -> and player is no observer
            IF dynasema.thisplayer<8

              delay:=FALSE

              ourplayer:=dynasema.player[dynasema.thisplayer]

              -> and our player is alive
              IF ourplayer.dead>0

                -> and current game frame has been increased
                IF dynasema.frames<>oldframe
                  oldframe:=dynasema.frames

                  -> do your AI stuff

                  dynasema.walk:=Rnd(DIR_UP+1)

                ENDIF
              ENDIF

            ENDIF

          ENDIF

        ENDIF

        ReleaseSemaphore(dynasema) -> release it

        IF delay
          -> no game is running
          -> do a small delay to let the cpu do other things :(
          Delay(10)
        ENDIF

      ENDIF
    ENDWHILE

    ObtainSemaphore(dynasema) -> lock it

    -> reset direction
    dynasema.walk:=DIR_NONE

    -> set botinfo entry back to 0
    dynasema.botinfo[thisbotnum]:=NIL

    -> decrease opencount to tell dynamite that you no longer need
    -> the semaphore.
    -> dynamite will remove the semaphore only if opencnt is
    -> 0 at the end

    dynasema.opencnt:=dynasema.opencnt-1

    ReleaseSemaphore(dynasema) -> release it


  ELSE -> not found

    WriteF('dynAMIte is not running\n')

  ENDIF

ENDPROC
