/*
** RobotFindsKitten
**
** www.robotfindskitten.org
**
** Rewritten rather than ported...
*/

MODULE 'intuition',
       'intuition/intuition',
       'intuition/screens',

       'graphics/text',
       'graphics/rastport',
       'graphics/gfx',
       'graphics/view',

       'diskfont',
       'libraries/diskfont',

       'exec/memory',

       'utility/tagitem',
       'utility',

       'dos/dos'


-> What the hell are we doing?
ENUM  DOING_INSTRUCTIONS = 0,
      DOING_GAME,
      DOING_MESSAGE,
      DOING_WIN_MESSAGE

-> Constants for our internal representation of the screen
CONST I_EMPTY = 255,
      I_ROBOT = 0,
      I_KITTEN = 1

-> Screen dimensions
CONST S_WIDTH   = 60,
      S_HEIGHT  = 25,
      S_ARRAYSZ = 2500,  /* S_WIDTH*S_HEIGHT. E's preprocessor sucks :( */
      S_COLOURS = 6

-> Row constants for the animation
CONST ADV_ROW = 1,
      ANIMATION_MEET = 50

-> Object that contains all info need to display
-> an object on the screen
OBJECT screen_object
  char:CHAR, -> This must be the first item (big bad bodge!)
  pad:CHAR,
  x,y,colour,
  bold
ENDOBJECT

OBJECT msgline
  buffer[S_WIDTH]:ARRAY OF CHAR
ENDOBJECT

-> Linked list for messages loaded from disk
OBJECT message_object
  next:PTR TO message_object,
  buffer[120]:ARRAY OF CHAR
ENDOBJECT

-> Globals for the window display
DEF win:PTR TO window,
    nfont:PTR TO textfont,
    nattr:textattr,
    plt[16]:ARRAY OF LONG,
    cols:PTR TO LONG,
    num_msgs=0,
    msg_pool=0,
    myargs:PTR TO LONG,
    rdargs=0,
    doing=0,
    win_x, win_y

-> Globals for the game
-> (to quote the linux port, "Bite Me". Globals *are* fun :)
DEF robot:screen_object,
    kitten:screen_object

DEF num_bogus,
    bogus:PTR TO screen_object,
    bogus_messages:PTR TO INT,
    used_messages :PTR TO INT,
    bogus_msg_list:PTR TO message_object,

    screen[S_ARRAYSZ]:ARRAY OF CHAR

PROC main() HANDLE

  DEF running = TRUE, class, code,
      msg:PTR TO intuimessage,
      checkx,checky,tx,ty,h

  get_stuff()

  Rnd( -Abs( getseconds() ) )

  doing := DOING_INSTRUCTIONS
  instructions()

  WHILE( running )

    WaitPort( win.userport )

    WHILE( msg := GetMsg( win.userport ) )

      class := msg.class
      code  := msg.code
      ReplyMsg( msg )

      checkx := robot.x
      checky := robot.y

      SELECT class
      CASE IDCMP_CLOSEWINDOW
        running := FALSE
      CASE IDCMP_RAWKEY
        SELECT doing
        CASE DOING_WIN_MESSAGE
          doing := DOING_INSTRUCTIONS
          instructions()
        CASE DOING_MESSAGE
          initialise_screen()
          doing := DOING_GAME
        CASE DOING_INSTRUCTIONS
          new_game()
        CASE DOING_GAME
          SELECT code
          CASE 69
            doing := DOING_INSTRUCTIONS
            instructions()
          CASE 79
            checkx--
          CASE 78
            checkx++
          CASE 76
            checky--
          CASE 77
            checky++
          ENDSELECT

          IF(( checkx <> robot.x ) OR ( checky <> robot.y ))
            IF(( checky > -1 ) AND ( checky < S_HEIGHT )  AND ( checkx > -1 ) AND ( checkx < S_WIDTH ))

              /* check for collision */
              SELECT screen[ checky*S_WIDTH + checkx ]
              CASE I_ROBOT
                /* Do nothing, we're in a timewarp! */
              CASE I_KITTEN
                play_animation( code )
                doing := DOING_WIN_MESSAGE
              CASE I_EMPTY
                SetAPen( win.rport, plt[ 0 ] )

                tx := Shl( robot.x, 3 )+win.borderleft
                ty := Shl( robot.y, 3 )+win.bordertop
                RectFill( win.rport, tx, ty, tx+7, ty+7 )
                screen[ robot.y*S_WIDTH + robot.x ] := I_EMPTY

                robot.x := checkx
                robot.y := checky
                screen[ robot.y*S_WIDTH + robot.x ] := I_ROBOT

                draw( robot )
              DEFAULT
                message( bogus_messages[ screen[ checky*S_WIDTH + checkx ] -2 ] )
              ENDSELECT
            ENDIF
          ENDIF

        ENDSELECT
      CASE IDCMP_VANILLAKEY
        SELECT doing
        CASE DOING_WIN_MESSAGE
          doing := DOING_INSTRUCTIONS
          instructions()
        CASE DOING_MESSAGE
          initialise_screen()
          doing := DOING_GAME
        CASE DOING_INSTRUCTIONS
          new_game()
        CASE DOING_GAME
          SELECT code
          CASE 27
            doing := DOING_INSTRUCTIONS
            instructions()
          ENDSELECT
        ENDSELECT
      ENDSELECT

    ENDWHILE

  ENDWHILE

  IF( h := Open( 'robotfindskitten.data', MODE_NEWFILE ) )
    win_x := win.leftedge
    win_y := win.topedge
    Write( h, {win_x}, 4 )
    Write( h, {win_y}, 4 )
    Close( h )
  ENDIF

EXCEPT DO

  SELECT exception
  CASE "DFNT"
    WriteF( 'Unable to open "diskfont.library"\n' )
  CASE "UTIL"
    WriteF( 'Unable to open "utility.library"\n' )
  CASE "FONT"
    WriteF( 'Unable to open "nintendo.font"\n' )
  CASE "WIN"
    WriteF( 'Unable to open window\n' )
  CASE "MSGS"
    WriteF( 'Unable to load the "messages.txt" file\n' )
  CASE "MEM"
    WriteF( 'Out of memory\n' )
  CASE "ARGS"
    WriteF( 'Bad args!\n' )
  ENDSELECT

  free_stuff()

ENDPROC

/*
** General purpose "allocate everything" routine
*/
PROC get_stuff()

  DEF i,h

  myargs := [0]
  IF( rdargs := ReadArgs( 'NUMBOGUS/N', myargs, 0 ) ) = NIL THEN Raise( "ARGS" )

  IF( diskfontbase := OpenLibrary( 'diskfont.library', 0 ) ) = NIL THEN Raise( "DFNT" )
  IF( utilitybase  := OpenLibrary( 'utility.library', 0 ) ) = NIL  THEN Raise( "UTIL" )

  AstrCopy( nattr.name, 'nintendo.font' )
  nattr.ysize  := 8
  nattr.style := 0
  nattr.flags := 0

  IF( nfont := OpenDiskFont( nattr ) ) = NIL THEN Raise( "FONT" )

  IF( msg_pool := CreatePool( MEMF_ANY+MEMF_CLEAR, 256, 128 ) ) = NIL THEN Raise( "MEM" )
  load_messages()

  IF( myargs[0] = 0 )
    num_bogus := 20
  ELSE
    num_bogus := Long( myargs[0] )
    IF(( num_bogus < 0 ) OR ( num_bogus > num_msgs )) THEN num_bogus := 20
  ENDIF

  IF( h := Open( 'robotfindskitten.data', MODE_OLDFILE ) )
    Read( h, {win_x}, 4 )
    Read( h, {win_y}, 4 )
    Close( h )
  ELSE
    win_x := win_y := 32
  ENDIF

  IF( win := OpenWindowTagList( 0,
    [WA_LEFT,        win_x,
     WA_TOP,         win_y,
     WA_INNERWIDTH,  S_WIDTH*8,
     WA_INNERHEIGHT, S_HEIGHT*8,
     WA_CLOSEGADGET, -1,
     WA_DEPTHGADGET, -1,
     WA_DRAGBAR,     -1,
     WA_IDCMP,       IDCMP_CLOSEWINDOW+IDCMP_VANILLAKEY+IDCMP_RAWKEY,
     WA_TITLE,       'robotfindskitten',
     WA_ACTIVATE,    TRUE,
     TAG_DONE] ) ) = NIL THEN Raise( "WIN" )

  cols := [  0,  0,  0,       /* black */
            -1, -1, -1,       /* white */
            -1, -1,  0,       /* yellow */
             0, -1,  0,       /* green */
            -1,  0, -1,       /* purple */
            -1,  0,  0 ]      /* red */

  FOR i := 0 TO S_COLOURS-1 DO plt[ i ] := ObtainBestPenA( win.wscreen.viewport.colormap, cols[ i*3 ], cols[ i*3+1], cols[ i*3+2 ], [TAG_DONE] )

  SetFont( win.rport, nfont )
  SetDrMd( win.rport, 1 )

ENDPROC

/*
** General purpose "free everything" routine
*/
PROC free_stuff()

  DEF i

  IF( win )
    CloseWindow( win )
    FOR i := 0 TO S_COLOURS-1 DO IF( plt[ i ] > -1 ) THEN ReleasePen( win.wscreen.viewport.colormap, plt[ i ] )
  ENDIF

  IF( msg_pool ) THEN DeletePool( msg_pool )
  IF( nfont ) THEN CloseFont( nfont )
  IF( utilitybase ) THEN CloseLibrary( utilitybase )
  IF( diskfontbase ) THEN CloseLibrary( diskfontbase )
  IF( rdargs ) THEN FreeArgs( rdargs )

ENDPROC

PROC load_messages() HANDLE

  DEF h, nmsg:PTR TO message_object,
      tmsg:PTR TO message_object, ibuf[120]:ARRAY OF CHAR,
      n

  IF( h := Open( 'messages.txt', MODE_OLDFILE ) ) = NIL THEN Raise( "MSGS" )

  tmsg := 0
  num_msgs := 0

  WHILE( Fgets( h, ibuf, 120 ) )

    n := StrLen( ibuf ) -1
    IF( ibuf[ n ] = 10 ) THEN ibuf[ n ] := 0    /* Remove LF */

    IF( nmsg := AllocPooled( msg_pool, SIZEOF message_object ) ) = NIL THEN Raise( "MEM" )
    AstrCopy( nmsg.buffer, ibuf, 120 )

    IF( tmsg )
      tmsg.next := nmsg
    ELSE
      bogus_msg_list := nmsg
    ENDIF

    tmsg := nmsg
    num_msgs++

  ENDWHILE

  Close( h )

  IF( bogus          := AllocPooled( msg_pool, (SIZEOF screen_object)*num_msgs ) ) = NIL THEN Raise( "MEM" )
  IF( bogus_messages := AllocPooled( msg_pool, Shl( num_msgs, 1 ) ) ) = NIL THEN Raise( "MEM" )
  IF( used_messages  := AllocPooled( msg_pool, Shl( num_msgs, 1 ) ) ) = NIL THEN Raise( "MEM" )

EXCEPT

  IF( h ) THEN Close( h )
  ReThrow()

ENDPROC

PROC new_game()
  doing := DOING_GAME

  -> Initialise the things of thingyness
  initialise_arrays()
  initialise_robot()
  initialise_kitten()
  initialise_bogus()
  initialise_screen()
ENDPROC

PROC initialise_screen()

  DEF count

  clear_window()

  FOR count := 0 TO num_bogus-1 DO draw( bogus[ count ] )
  draw( kitten )
  draw( robot )

ENDPROC


PROC randx()    IS Rnd( S_WIDTH )
PROC randy()    IS Rnd( S_HEIGHT )
PROC randchar() IS Rnd( (126-"!"+1) )+"!"
PROC randcol()  IS Rnd( S_COLOURS-1 )+1
PROC randbold() IS Rnd( 2 )

PROC validchar( c ) IS IF(( c = " " ) OR ( c = "#" ) OR ( c = 127 )) THEN FALSE ELSE TRUE

/*
** Initialise the arrays for the things that need arrays
*/
PROC initialise_arrays()

  DEF empty:screen_object, i

  empty.x      := -1
  empty.y      := -1
  empty.colour := 0
  empty.bold   := FALSE
  empty.char   := " "

  -> Clear the screen array
  FOR i := 0 TO S_ARRAYSZ-1 DO screen[ i ] := I_EMPTY

  -> Initialise the other arrays
  FOR i := 0 TO num_msgs-1
    used_messages[ i ] := 0
    bogus_messages[ i ] := 0
    CopyMem( empty, bogus[ i ], SIZEOF screen_object )
  ENDFOR

ENDPROC

/*
** Initialise the robot
*/
PROC initialise_robot()

  robot.x := randx()
  robot.y := randy()

  robot.char   := "#"
  robot.colour := 2      /* yellow */
  robot.bold   := FALSE

  screen[ robot.y*S_WIDTH + robot.x ] := I_ROBOT

ENDPROC

/*
** Initialise the kitten
*/
PROC initialise_kitten()

  REPEAT
    kitten.x := randx()
    kitten.y := randy()
  UNTIL screen[ kitten.y*S_WIDTH + kitten.x ] = I_EMPTY

  screen[ kitten.y*S_WIDTH + kitten.x ] := I_KITTEN

  kitten.char   := randchar()
  kitten.colour := randcol()
  kitten.bold   := randbold()

ENDPROC

/*
** Initialise the bogus objects
*/
PROC initialise_bogus()

  DEF i, index

  FOR i := 0 TO num_bogus-1

    bogus[i].colour := randcol()
    bogus[i].bold   := randbold()

    REPEAT
      bogus[i].char := randchar()
    UNTIL validchar( bogus[i].char )

    REPEAT
      bogus[i].x := randx()
      bogus[i].y := randy()
    UNTIL screen[ bogus[i].y*S_WIDTH + bogus[i].x ] = I_EMPTY

    screen[ bogus[i].y*S_WIDTH + bogus[i].x ] := i+2

    REPEAT
      index := Rnd( num_msgs )
    UNTIL used_messages[ index ] = 0

    bogus_messages[i]    := index
    used_messages[index] := 1

  ENDFOR

ENDPROC

PROC draw( o:PTR TO screen_object )

  SetAPen( win.rport, plt[ o.colour ] )
  Move( win.rport, Shl( o.x, 3 )+win.borderleft, Shl( o.y, 3 )+win.bordertop+nfont.baseline )
  Text( win.rport, o, 1 )  -> BIG BAD BODGE!

ENDPROC

/*
** Instructions !
*/
PROC instructions()

  clear_window()

  SetAPen( win.rport, plt[ 1 ] )
  centreText( 8, 'robotfindskitten' )

  centreText( 24, 'Created by the illustrious Leonard Richardson (C) 1997, 2000' )
  centreText( 34, 'Amiga version by the slightly wobbly Peter Gordon' )
  centreText( 42, 'email: pete@shagged.org' )

  SetAPen( win.rport, plt[ 2 ] )
  mvText( 0, Shl( S_HEIGHT, 2 )-30, 'In this game, you are robot (#). Your job is to find kitten.' )
  mvText( 0, Shl( S_HEIGHT, 2 )-22, 'This task is complicated by the existance of various things' )
  mvText( 0, Shl( S_HEIGHT, 2 )-14, 'which are not kitten. Robot must touch items to determine' )
  mvText( 0, Shl( S_HEIGHT, 2 )-6 , 'if they are kitten or not.' )
  mvText( 0, Shl( S_HEIGHT, 2 )+6 , 'The game ends when robotfindskitten. Alternatively, you may' )
  mvText( 0, Shl( S_HEIGHT, 2 )+14, 'end the game by hitting Esc, or closing the window. See the' )
  mvText( 0, Shl( S_HEIGHT, 2 )+22, 'documentation for more information.' )

  SetAPen( win.rport, plt[ 3 ] )
  centreText( Shl( S_HEIGHT-2, 3 ),'Press any key to start.' )

ENDPROC

PROC play_animation( code )

  DEF i, tx, ty

  clear_window()

  robot.y  := Shr( S_HEIGHT, 1 )
  kitten.y := Shr( S_HEIGHT, 1 )

  FOR i := 12 TO 0 STEP -1

    SetAPen( win.rport, plt[ 0 ] )
    tx := Shl( robot.x, 3 )+win.borderleft
    ty := Shl( robot.y, 3 )+win.bordertop
    RectFill( win.rport, tx, ty, tx+7, ty+7 )
    tx := Shl( kitten.x, 3 )+win.borderleft
    ty := Shl( kitten.y, 3 )+win.bordertop
    RectFill( win.rport, tx, ty, tx+7, ty+7 )

    IF(( code = 78 ) OR ( code = 77 ))
      kitten.x  := Shr( S_WIDTH, 1 ) + i
      robot.x   := Shr( S_WIDTH, 1 ) - (i+1)
    ELSE
      robot.x  := Shr( S_WIDTH, 1 ) + i
      kitten.x := Shr( S_WIDTH, 1 ) - (i+1)
    ENDIF

    draw( kitten )
    draw( robot )

    Delay( 3 )

  ENDFOR

  Delay( 50 )
  fixedmessage( 'You found kitten! Way to go, robot!' )

ENDPROC

PROC clear_window()
  SetAPen( win.rport, plt[ 0 ] )
  RectFill( win.rport, win.borderleft, win.bordertop, S_WIDTH*8+win.borderleft-1, S_HEIGHT*8+win.bordertop-1 )
  SetBPen( win.rport, plt[ 0 ] )
ENDPROC

PROC mvText( xp, yp, str:PTR TO CHAR )
  Move( win.rport, win.borderleft+xp, win.bordertop+yp+nfont.baseline )
  Text( win.rport, str, StrLen( str ) )
ENDPROC

PROC centreText( yp, str:PTR TO CHAR )

  DEF xp

  xp := S_WIDTH*4 - Shr( TextLength( win.rport, str, StrLen( str ) ), 1 )
  Move( win.rport, xp+win.borderleft, win.bordertop+yp+nfont.baseline )
  Text( win.rport, str, StrLen( str ) )

ENDPROC

PROC message( number )

  DEF n=0, tmsg:PTR TO message_object, x1, y1, x2, y2, mx, my,
      mlines[5]:ARRAY OF msgline

  tmsg := bogus_msg_list

  IF( number ) THEN FOR n := 1 TO number DO IF( tmsg ) THEN tmsg := tmsg.next

  IF( tmsg )

    SetAPen( win.rport, plt[ 5 ] )

    -> Warping red box doofrey
    mx := Shl( S_WIDTH,  2 )
    my := Shl( S_HEIGHT, 2 )
    FOR n := 1 TO 8
      x1 := mx - (n*Shr( S_WIDTH, 1 ))
      y1 := my - (n*4)
      x2 := (n*Shr( S_WIDTH, 1 ) + mx) -1
      y2 := (n*4 + my) -1
      RectFill( win.rport, win.borderleft+x1, win.bordertop+y1, win.borderleft+x2, win.bordertop+y2 )
      Delay( 1 )
    ENDFOR

    -> Split the description into lines
    n := 0
    x1 := 0
    x2 := 0
    y1 := 0
    y2 := 0
    REPEAT

      IF( tmsg.buffer[x1] = 32 )
        y1 := x2
        y2 := x1+1
      ENDIF

      mlines[n].buffer[x2++] := tmsg.buffer[x1++]

      IF( x2 >= (S_WIDTH-2) )
        mlines[n].buffer[x2] := 0
        IF( y1 > 0 )
          mlines[n].buffer[y1] := 0
          x1 := y2
        ENDIF
        x2 := 0
        y1 := 0
        n++
      ENDIF

    UNTIL(( n = 5 ) OR ( tmsg.buffer[x1-1] = 0 ))

    IF( n = 5 ) THEN n := 4

    SetAPen( win.rport, plt[ 1 ] )
    SetBPen( win.rport, plt[ 5 ] )

    y1 := Shl( S_HEIGHT, 2 ) - Shl( n+1, 2 )
    FOR x1 := 0 TO n
      centreText( y1, mlines[x1].buffer )
      y1 := y1 + 8
    ENDFOR

    doing := DOING_MESSAGE

  ENDIF

ENDPROC

PROC fixedmessage( fmsg:PTR TO CHAR )

  DEF n=0, x1, y1, x2, y2, mx, my,
      mlines[5]:ARRAY OF msgline

  SetAPen( win.rport, plt[ 4 ] )

  -> Warping red box doofrey
  mx := Shl( S_WIDTH,  2 )
  my := Shl( S_HEIGHT, 2 )
  FOR n := 1 TO 8
    x1 := mx - (n*Shr( S_WIDTH, 1 ))
    y1 := my - (n*4)
    x2 := (n*Shr( S_WIDTH, 1 ) + mx) -1
    y2 := (n*4 + my) -1
    RectFill( win.rport, win.borderleft+x1, win.bordertop+y1, win.borderleft+x2, win.bordertop+y2 )
    Delay( 1 )
  ENDFOR

  -> Split the description into lines
  n := 0
  x1 := 0
  x2 := 0
  y1 := 0
  y2 := 0
  REPEAT

    IF( fmsg[x1] = 32 )
      y1 := x2
      y2 := x1+1
    ENDIF

    mlines[n].buffer[x2++] := fmsg[x1++]

    IF( x2 >= (S_WIDTH-2) )
      mlines[n].buffer[x2] := 0
      IF( y1 > 0 )
        mlines[n].buffer[y1] := 0
        x1 := y2
      ENDIF
      x2 := 0
      y1 := 0
      n++
    ENDIF

  UNTIL(( n = 5 ) OR ( fmsg[x1-1] = 0 ))

  IF( n = 5 ) THEN n := 4

  SetAPen( win.rport, plt[ 1 ] )
  SetBPen( win.rport, plt[ 4 ] )

  y1 := Shl( S_HEIGHT, 2 ) - Shl( n+1, 2 )
  FOR x1 := 0 TO n
    centreText( y1, mlines[x1].buffer )
    y1 := y1 + 8
  ENDFOR

  doing := DOING_MESSAGE

ENDPROC

-> Only really used for random seed.
PROC getseconds()
  DEF seconds,now:datestamp
  DateStamp(now) -> datestamp datum
  seconds:=Smult32(now.days, 86400) + Smult32(now.minute, 60) + SdivMod32(now.tick, TICKS_PER_SECOND)
ENDPROC seconds
