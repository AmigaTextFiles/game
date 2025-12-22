#define OTTER_UP             0
#define OTTER_DOWN           1
#define OTTER_LEFT           2
#define OTTER_RIGHT          3

#define WORMQUEUELIMIT      15
#define DOGQUEUELIMIT      120
#define TIMELIMIT          599 // 9:99
#define SECONDSPERLEVEL     90 // assert(SECONDSPERLEVEL <= TIMELIMIT);
#define WEIGHT               5
#define ENCLOSURE_MAX       15 // maximum size of enclosure (interior area)
#define CHASING             10
#define CREATURES           80
#define POINTSLOTS           CREATURES
#define POINTDURATION        3
#define PROTECTORS           3 // <=4!
#define NOSE                 3 // if (NOSE > PROTECTORS) then nose is disabled

#define ANIMSPEED_BANANA     6
#define ANIMSPEED_BIRD       3
#define ANIMSPEED_EEL        8
#define ANIMSPEED_MISSILE    4
#define ANIMSPEED_SQUID      5

#define SPEED_PROTECTOR     12

#define DISTANCE_FAST        4
#define DISTANCE_BIRD        4
#define DISTANCE_GIRAFFE     5
#define DISTANCE_MOUSE      10
#define DISTANCE_PANDA       8
#define DISTANCE_NORMAL      3
#define DISTANCE_NOSE        4
#define DISTANCE_SLOW        2

#define  ADD_AMMO         5 // in bullets
#define  ADD_ARMOUR      25 // in VERYSLOWs
#define  ADD_BUTTERFLY   10 // in moves
#define  ADD_CLOCK       30 // in seconds
#define  ADD_CUTTER      30 // in VERYSLOWs
#define  ADD_GLOW        30 // in VERYSLOWs
#define  ADD_ICE         10 // in VERYSLOWs
#define  ADD_MINIHEALER   5 // in lives
#define  ADD_MINIBOMB     5 // in squares radius
#define  ADD_SUPERBOMB   10 // in squares radius
#define  ADD_SUPERHEALER 10 // in lives
#define  ADD_SUPERPULSE   5 // in squares
#define  ADD_TREASURE    15 // in seconds

#define RAND_ARMOUR       30
#define RAND_BUTTERFLY    20
#define RAND_CLOCK        30
#define RAND_CUTTER       25
#define RAND_GLOW         50
#define RAND_ICE           5
#define RAND_MINIBOMB     15
#define RAND_SUPERBOMB    30
#define RAND_SUPERPULSE   15
#define RAND_TREASURE     10

#define AMMOLIMIT        100
#define ARMOURLIMIT      100
#define CUTTERLIMIT      100
#define GLOWLIMIT        100
#define STARTLIVES_EASY   50
#define STARTLIVES_NORMAL 25
#define LIVESLIMIT        50
#define MULTILIMIT         8 /* don't set >8! */
#define POWERLIMIT         6
#define SCORELIMIT  99999999 // 99 million

struct CreatureStruct
{   FLAG  alive, visible;
    int   x, y, deltax, deltay,
          pos,                           // dogs, monkeys, snakes, elephants, eels, curvers
          tonguex,                       // frogs
          firex, firey;                  // snakes, octopi
    SBYTE dir,                           // octopi, bulls, frogs, birds, monkeys, curvers
          tonguedir,                     // frogs, monkeys, porcupines
          player;                        // drips, missiles, birds, dogs
    UBYTE speed;
    UWORD last, tail,
          nextlast, nexttail,            // bears, fish
          species;
    UBYTE dormant,                       // dogs, frogs, porcupines, superpulses
          frame,                         // birds, missiles
          journey, going,                // otters, porcupines
          then,                          // otters
          creator;                       // superpulses
    FLAG  kicked;                        // orbs
    UWORD subspecies;                    // camels, fragments
    SLONG score;
};
struct ProtectorStruct
{   SBYTE x, y, deltax, deltay, relx, rely;
    UBYTE last;
    FLAG  alive, visible;
};

#define PAIN_BOMB             3
#define PAIN_GLOW             3
#define PAIN_LIGHTNING        3
#define PAIN_METAL            3
#define PAIN_SLAYER           3
#define PAIN_STONE            3
#define PAIN_TELEPORT         3
#define PAIN_WORMFIRE         3
#define PAIN_WOOD             2
#define PAIN_ENEMYTAIL        2
#define PAIN_FRIENDLYTAIL     1

#define FREQ_SPIDERFIRE      30
#define FREQ_CAMELDROP       70
#define FREQ_CAMELTURN        2
#define FREQ_CLOUDFIRE       25
#define FREQ_CLOUDRAIN       15
#define FREQ_EELFIRE         14
#define FREQ_FROGFIRE        90
#define FREQ_FROGMOVE        25
#define FREQ_FRUIT          500
#define FREQ_HORSETURN       20
#define FREQ_KANGAROOFIRE    20
#define FREQ_KANGAROOTURN     5
#define FREQ_KOALAFIRE       10
#define FREQ_KOALAMOVE        5
#define FREQ_LEMMINGFIRE     10
#define FREQ_OCTOPUSFIRE     30
#define FREQ_OCTOPUSMOVE      5
#define FREQ_OCTOPUSSPIN      2
#define FREQ_PORCUPINEFIRE   15
#define FREQ_PORCUPINEMOVE    5
#define FREQ_RHINOCEROSFIRE  30
#define FREQ_SALAMANDERFIRE  35
#define FREQ_SLIME          195
#define FREQ_SLIMEGROW       95
#define FREQ_SNAKEFIRE       40
#define FREQ_SQUIDFIRE       10
#define FREQ_SQUIDTURN        5
#define FREQ_TELEPORT       210
#define FREQ_TURTLECHANGE    20
#define FREQ_TURTLEMOVE       5
#define FREQ_ZEBRATURN       15
