#define VERSION        "\0$VER: CodeWar " INTEGERVERSION " (10.9.2017)" // always d.m.yyyy format
#define CW_VERSION     (1.65)
#define DECIMALVERSION "1.65"
#define INTEGERVERSION "1.65"
#define RELEASEDATE    "10 September 2017"
#define COPYRIGHT      "© 1995-2017 Rhett and James Jacobs of Amigan Software"

#define TRANSIENT              auto   /* automatic variables */
#define MODULE                 static /* external static (file-scope) */
#define PERSIST                static /* internal static (function-scope) */
#define DISCARD                (void) /* discarded return values */
#define elif                   else if
#define acase                  break; case
#define adefault               break; default
#define EXPORT
#define IMPORT                 extern
#define EOS                    0

#ifndef TRUE
    #define TRUE               (-1)
#endif
#define FALSE                  0

typedef signed char            SBYTE;
typedef unsigned char          FLAG;
typedef signed long            SLONG;

#define TWO_PI                    ((double)2.0 * M_PI)
#define deg_2_rad(X)              ((double)X*(double)M_PI/(double)180.0)
#define rad_2_deg(X)              ((double)X*(double)180.0/(double)M_PI)
#define pythagoras(X,Y)           sqrt((X)*(X)+(Y)*(Y))

// private!

#define MT_REGISTER_PROGRAM        (WM_APP + 0x01)
#define MT_PRINT_BUFFER            (WM_APP + 0x02)
#define MT_GET_VERSION             (WM_APP + 0x03)
#define MT_POWER                   (WM_APP + 0x04)
#define MT_ATOMIC                  (WM_APP + 0x05)
#define MT_BOMB                    (WM_APP + 0x06)
#define MT_CANNON                  (WM_APP + 0x07)
#define MT_MISSILE                 (WM_APP + 0x08)
#define MT_SCAN                    (WM_APP + 0x09)
#define MT_BOOST_SHIELDS           (WM_APP + 0x0A)
#define MT_GET_ACCELERATION        (WM_APP + 0x0B)
#define MT_GET_ATOMICS             (WM_APP + 0x0D)
#define MT_GET_BOMBS               (WM_APP + 0x0E)
#define MT_GET_BOUNDARYTYPE        (WM_APP + 0x0F)
#define MT_GET_CANNONS             (WM_APP + 0x10)
#define MT_GET_DAMAGE              (WM_APP + 0x11)
#define MT_GET_ELAPSEDTIME         (WM_APP + 0x12)
#define MT_GET_ENERGY              (WM_APP + 0x13)
#define MT_GET_FIELDLIMITS         (WM_APP + 0x14)
#define MT_GET_FORCE               (WM_APP + 0x15)
#define MT_GET_MASS                (WM_APP + 0x16)
#define MT_GET_MISSILES            (WM_APP + 0x17)
#define MT_GET_POSITION            (WM_APP + 0x18)
#define MT_GET_SHIELDS             (WM_APP + 0x19)
#define MT_GET_TIMEINTERVAL        (WM_APP + 0x1A)
#define MT_GET_VELOCITY            (WM_APP + 0x1B)
#define MT_SET_NAME                (WM_APP + 0x1C)
#define MT_HALT                    (WM_APP + 0x2B)
#define MT_TURN                    (WM_APP + 0x2C)
#define MT_TELEPORT                (WM_APP + 0x2E)
#define MT_GET_DAMAGE_MAX          (WM_APP + 0x30)

#define GLYPHS_ATOMIC      17
#define GLYPHS_BOMB        12
#define GLYPHS_CANNON       4
#define GLYPHS_MISSILE     16
#define WEAPONGLYPHS       (GLYPHS_ATOMIC + GLYPHS_BOMB + GLYPHS_CANNON + GLYPHS_MISSILE)

#define FIRSTGLYPH_ATOMIC   0
#define FIRSTGLYPH_BOMB    17
#define FIRSTGLYPH_CANNON  29
#define FIRSTGLYPH_MISSILE 33

// amiga|ibm.c
EXPORT void openconsole(void);
EXPORT void Line(int x1, int y1, int x2, int y2);
EXPORT void garbled(UNUSED int robot, int errornum);
EXPORT ULONG goodrand(void);
EXPORT void handlekybd(ULONG scancode);
EXPORT void msgpump(void);
EXPORT void play_sample(int sample);
#ifdef WIN32
    EXPORT void read_clip(int robot);
    EXPORT float zatof(STRPTR inputstr);
#endif
EXPORT void remove_player(int robot, FLAG playsound);
EXPORT void rq(STRPTR text);
#ifdef AMIGA
    EXPORT void start_sounds(void);
    EXPORT void stop_sounds(void);
    EXPORT void page_left(void);
    EXPORT void page_right(void);
#endif
EXPORT void thewait(void);
EXPORT void updateinteger(int gid, int number);
EXPORT void updatemessage(int whichrobot);
EXPORT void updatename(int whichrobot);
EXPORT void updatescreen(void);
EXPORT void updatestring(int gid);
EXPORT void updateticks(void);

// engine.c
EXPORT void setup_backdrop(void);
EXPORT void make_bodies(void);
EXPORT void draw_explosion(int whichrobot, int pixelradius, int leftx, int rightx, int topy, int bottomy);
EXPORT void draw_glyph(int whichglyph);
EXPORT void draw_robot(int robot, int x, int y);
#ifdef AMIGA
    EXPORT void draw_weapon(int robot, int x, int y, int kind, UNUSED int detonate);
#endif
#ifdef WIN32
    EXPORT void draw_weapon(int robot, int x, int y, int kind,        int detonate);
#endif
EXPORT int cw_server_process(void);
EXPORT void engine_setup(void);
EXPORT void srv_Boost_Shields(int robot, int energy);
EXPORT void srv_Print_Buffer(int robot);
EXPORT void srv_Power(int robot);
EXPORT void srv_Atomic(int robot);
EXPORT void srv_Bomb(int robot);
EXPORT void srv_Cannon(int robot);
EXPORT void srv_Missile(int robot);
EXPORT void srv_Scan(int robot);
EXPORT void srv_Halt(int robot);
EXPORT void srv_Turn(int robot);
EXPORT void srv_Teleport(int robot);
EXPORT void set_name(int robot);
EXPORT int valid(int x, int y);
EXPORT int x_to_gfx(float x);
EXPORT int y_to_gfx(float y);
EXPORT void energize(void);
EXPORT void heal(void);
EXPORT void rearm(void);
EXPORT void reposition(void);
EXPORT void initrobot(int robot);
EXPORT void draw_player_positions(void);

// #define VERBOSE

#define ROBOTS      8
#define WEAPONS    64
#define EXPLOSIONS 64

#define X_AXIS     (0)
#define Y_AXIS     (1)

#define WP_ATOMIC  (0)
#define WP_BOMB    (1)
#define WP_CANNON  (2)
#define WP_MISSILE (3)

#define FX_FIRE     4
#define FX_BORN     5
#define FX_DIE      6
#define FX_AMIGAN   7
#define FX_BOUNCE   8
#define SAMPLES     9 // counting from 1

#define OC openconsole()

typedef struct {
  float time_int;
  float field[2];
  float elapsed_time;
} Config;

typedef struct {
  int width;
  int height;
  float scale[2];
} game_window;

typedef struct {
  char         name[128],
               message[255];
  int          atomics,
               bombs,
               cannons,
               missiles,
               damage,
               shields,
               mass,
               energy;
  float        position[2],
               velocity[2],
               acc[2],
               accel,
               heading,
               scan,
               scan_dir,
               scan_precision;
  FLAG         alive;
  HWND         window,
               theirwindow;
#ifdef WIN32
  DWORD        processid;
#endif
#ifdef AMIGA
  struct Task* processid;
#endif
  UBYTE*       memory;
  int          pain,
               paintime,
               conqueror;
} Player;

typedef struct {
  FLAG  alive;
  short weapon;
  float position[2];
  float velocity[2];
  int   detonate,
        robot;
} Weapon;

typedef struct {
  FLAG alive;
  float position[2];
  int frame;
} Explosion;

enum wall_types{RUBBER, STONE, ABYSS, TWILIGHT};

#ifdef AMIGA
struct CodeWarSglMsg
{   struct Message cw_Msg;
    UBYTE          cw_Robot;
    ULONG          cw_Operation,
                   cw_Number,
                   cw_Result;
    STRPTR         cw_String;
    float          cw_Single1,
                   cw_Single2,
                   cw_Single3,
                   cw_ResultSgl1,
                   cw_ResultSgl2;
};
#endif

#define BACKDROPWIDTH     64
#define BACKDROPHEIGHT    64
#define WEAPONWIDTH       11
#define WEAPONHEIGHT      11
#define STATUSGLYPHWIDTH  10
#define STATUSGLYPHHEIGHT 10
#define ROBOTSIZE          5 // in metres
#define BODY_RADIUS       ((int) (ROBOTSIZE * battle.width / config.field[X_AXIS] / 2))
#define BODY_DIAMETER     ((int) (ROBOTSIZE * battle.width / config.field[X_AXIS]    ))

#define GLYPHPOS_PAUSED    0
#define GLYPHPOS_TURBO     1
#define GLYPHPOS_SOUND     2
#define GLYPHS             3

#define SPEED_1QUARTER   0
#define SPEED_2QUARTERS  1
#define SPEED_3QUARTERS  2
#define SPEED_4QUARTERS  3
#define SPEED_5QUARTERS  4
#define SPEED_6QUARTERS  5
#define SPEED_8QUARTERS  6
#define SPEED_16QUARTERS 7
#define SPEED_32QUARTERS 8
#define SPEED_MIN        SPEED_1QUARTER
#define SPEED_MAX        SPEED_32QUARTERS
