-> NOREV
OPT MODULE
OPT EXPORT

MODULE  'exec/nodes',
        'exec/lists',
        'exec/semaphores'

-> player.status
ENUM  PA_NONE=0, -> no player
      PA_VISI,   -> player is visitor
      PA_LOGGEDIN, -> player just logged in/after a game
      PA_PLAYING,  -> player is in game (no matter if he's dead)
      PA_COUNTDOWN, -> this is of no use. players only have this status if they logged in.
      PA_DEAD, -> this is of no use, it's not meant to see if a player is
               -> actually dead.  use player.dead instead.  it's only set
               -> after a successfull login for the other players
      PA_WON -> a player has this status if he won the last round

-> dynasema.gamerunning
ENUM  GAME_NOTCONNECTED=0, -> game is not connected (startscreen)
      GAME_CLOSEGAME,      -> transitional state to GAME_NOTCONNECTED after connection got closed
      GAME_MENU,           -> game is in menu eg: login screen
      GAME_ENDGAME,        -> transitional state to GAME_MENU after effect has been drawn
      GAME_EFFECT,         -> game draws effect after a match
      GAME_COUNTDOWN,      -> game is doing the countdown
      GAME_GAME,           -> game is running
      GAME_HURRYUP         -> game is running and is in hurry up mode

ENUM  DIR_NONE=-1,
      DIR_DOWN,
      DIR_RIGHT,
      DIR_LEFT,
      DIR_UP

CONST SPEED_NORMAL=4,
      SPEED_SLOW=3,
      SPEED_FAST=6

CONST BLOCK_FAKEBLOCK=-1,    -> used for remote/kick bombs which are placed into the map
      BLOCK_NOBLOCK=0,       -> empty field
      BLOCK_HARDBLOCK=1,     -> non-destroyable block
      BLOCK_DESTROYABLE=2,   -> destroyable block
      BLOCK_BOMB=3,          -> normal bomb
      BLOCK_BORDERWALL1=4,   -> borderblocks are equal to hardblock
      BLOCK_BORDERWALL2=5,
      BLOCK_BORDERWALL3=6,
      BLOCK_BORDERWALL4=7,
      BLOCK_BORDERWALL5=8,
      BLOCK_BORDERWALL6=10,
      BLOCK_BORDERWALL7=11,
      BLOCK_BORDERWALL8=12,
      BLOCK_BORDERWALL9=13,
      BLOCK_BORDERWALL10=14,
      BLOCK_BORDERWALL11=15,
      BLOCK_BORDERWALL12=16,

      BLOCK_ADDBOMB=19,    -> block that contains a bomb
      BLOCK_STRONG=20,
      BLOCK_GRAVESTONE=21

ENUM  BO_EXPANDFLAME=1, -> types for bonusgrid
      BO_ADDBOMB,
      BO_FLAMEMAX,
      BO_BOMBMAX,
      BO_RANDOMWALL,  -> 5
      BO_BOMBS2BLOCKS,
      BO_DROPALL,
      BO_EXPLALL,
      BO_FASTER,
      BO_SLOWER,      -> 10
      BO_SHORTERFUSE,
      BO_LONGERFUSE,
      BO_SHORTERFLAME,
      BO_SWAPCONTROLSRL,
      BO_FEWERBOMBS,  -> 15
      BO_NODROP,
      BO_SHIELD,
      BO_STANDSTILL,
      BO_TELEPORT,
      BO_REMOTEBOMB,  -> 20
      BO_BACK2BASIC,
      BO_KICKBOMB,
      BO_SABER,
      BO_SWAPCONTROLSUD,
      BO_MAGNET,      -> 25
      BO_PHOENIX,
      BO_DOHURRYUP,
      BO_INVISIBLE,
      BO_DUELL,
      BO_AFTERBURNER,  -> 30
      BO_FLAG,
      BO_TELEPORTALL,
      BO_MAPJUMP,
      BO_DARKNESS,
      BO_SWAPPOSITIONS, -> 35
      BO_WORMHOLE,
      BO_FART,
      BO_GOLDENHEART,
      BO_MAX

-> types for tempbomb.type
ENUM  BOMB_NORMAL=0,  -> normal bomb
      BOMB_ABOMB,
      BOMB_GEN,       -> predefined bomb (map)
      BOMB_REMOTE,    -> remote bomb
      BOMB_KICK       -> kick bomb

OBJECT serverdata
  servername[34]:ARRAY -> name of the server
  sysopname[18]:ARRAY  -> name of the sysop
  maxslots:INT         -> how many players allows this server
  maxobservers:INT     -> how many observers allows this server
ENDOBJECT

OBJECT tempbomb
  ln:mln

  x:INT -> x blockpos
  y:INT -> y blockpos

  x1:INT -> x pos (pixel)
  y1:INT -> y pos (pixel)

  fuse:INT -> >0 bomb is still ticking; =0 bomb is going to explode
  range:LONG -> flamlength

  dir:INT -> in case of kick/remote bomb holds the direction

  originx:INT -> holds the x/y pos (block) where the bomb was placed
  originy:INT -> (useful to find kick/remotebombs)

  type:INT -> is set to one of BOMB_#?

  player:INT
  playerobject:PTR TO LONG
  /******* private data *******/

ENDOBJECT

OBJECT player
  num:INT
  status:LONG -> this is set to one of PA_#?

  dead:INT -> >0 = player is alive

  x:INT -> xpos (pixel) + border (24 pixel)
  y:INT -> ypos (pixel) + border (16 pixel)

  px:INT -> xpos (block number)
  py:INT -> ypos (block number)

  bombc:INT -> how many bombs this player has currently ticking
  maxkickbombs:INT -> how many kickbombs this player has
  ->bomblist:PTR TO mlh -> doubly linked list of bombs belonging to this player

  remotebomb:PTR TO tempbomb -> obsolete

  maxrange:INT -> flamelen of player ranging from 2 to 15
  maxbombs:INT -> how many bombs this player can drop
  fuselen:INT -> fuselength of bombs the player can drop
  speed:INT -> player speed; SPEED_NORMAL=4, SPEED_SLOW=3, SPEED_FAST=6
  speedc:INT -> >0 = player has other speed (SPEED_SLOW, SPEED_FAST)

  swaprlc:INT -> >0 = swaped horizontal controls
  swapudc:INT -> >0 = swaped vertical controls
  nodropc:INT -> >0 = player can't drop bombs

  shieldc:INT -> >0 = player has shield

  standstillc:INT -> >0 = player can't move

  invisiblec:INT -> >0 = player is invisible

  afterburnerc:INT -> >0 = player has afterburner

  b2bc:INT

  flamethrowerc:INT -> >0 = player has lightsabre
  flamethrowerdir:INT -> direction of lightsabre
  flamethrowerr:INT -> range of light sabre

  magnetc:INT -> >0 = this player has magnet enabled
  magnetdir:INT -> direction of magnet

  name[34]:ARRAY -> players name
  system[64]:ARRAY -> players systemstring

  dir:INT -> players direction

  fartc:INT
  virusc:INT

  puppet:INT
  /******* private data *******/

ENDOBJECT

OBJECT dynamitesemaphore
  sema:ss -> embedded signalsemaphore

  opencnt:LONG -> you must increase this by 1 if you are going to use the
               -> semaphore the first time. decrease it by 1 if you are done

  quit:LONG -> dynamite will set this to 1 if it wants to quit.  Check this
            -> from time to time and end your program if quit gets set to 1

  gamerunning:LONG -> is set to one of GAME_#?

  frames:LONG -> once a game is running this long will be increased by 1
              -> every frame.

  walk:LONG     -> set to one of DIR_ to make the player move or stop
  drop:LONG     -> set to 1 to drop a bomb
  dropkick:LONG -> set to 1 to drop a kickbomb

  thisplayer:LONG -> number of this player in playerarray (>7 = observer)
  player:PTR TO LONG -> array ptr of players (15 entries max; >7 = observer)

  mapwidth:LONG  -> holds the width of the map in blocks
  mapheight:LONG -> holds the height of the map in blocks

  grid:PTR TO LONG -> array ptr to the actual map (29 entries max). each entry contains 1 line of the map without powerups
                   -> each element of line is INT sized

  bonusgrid:PTR TO LONG -> array ptr to the bonus map (29 entries max). each entry contains 1 line of the bonusmap
                        -> each element of line is CHAR sized

  addbubble:PTR TO CHAR -> setting this pointer to a string will make
                        -> dynamite show the string given here as bubble.
                        -> dynamite will reset this pointer to 0 after
                        -> successfull creation of the bubble

  serverdata:PTR TO serverdata -> see serverdata for details

  explosiongrid:PTR TO LONG -> array ptr to the explosion map (29 entries max). each entry contains 1 line of the explosion map
                            -> this map reflects where currently explosions are (explosion=1)
                            -> each element of line is CHAR sized

  version:LONG -> holds the version of dynamite (e.g. 45)

  botinfo:PTR TO LONG -> pointer to an array of 255 (so 255 bots max are
                      -> supported with this array) long pointers to hold a
                      -> string (versioninfo, description) of your bot.
                      -> You should set the entry for your bot after
                      -> opencnt has been increased by your bot and set it
                      -> back to NULL if your bot is about to decrease the
                      -> opencnt again on quit.

                      -> entry for your bot in this array is opencnt after
                      -> increasing (on botstartup, see example)

  bomblist:PTR TO mlh -> doubly linked list of bombs

  suicide:LONG -> set to 1 to kill bot/player

  teammode:INT

  fkeys:PTR TO LONG -> array ptr to 99 fkey texts
  activefkeybank:INT -> contains number of active fkey bank
  keypress:INT -> check for yourself :)
  overridefkeys:INT -> set to 1 if you dont want dynamite to display bubbles by itself
                    -> please make sure to reset this to 0 when your bot exits
ENDOBJECT
