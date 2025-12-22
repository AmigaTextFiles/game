/*
 * OpenBOR - http://www.LavaLit.com
 * -----------------------------------------------------------------------
 * All rights reserved, see LICENSE in OpenBOR root for details.
 *
 * Copyright (c) 2004 - 2011 OpenBOR Team
 */

/////////////////////////////////////////////////////////////////////////////
//	Beats of Rage                                                           //
//	Side-scrolling beat-'em-up                                              //
/////////////////////////////////////////////////////////////////////////////

#include "openbor.h"
#include "commands.h"
#include "models.h"

#define GET_ARG(z) (arglist.count > z ? arglist.args[z] : "")
#define GET_ARG_LEN(z) (arglist.count > z ? arglist.arglen[z] : 0)
#define GET_ARGP(z) (arglist->count > z ? arglist->args[z] : "")
#define GET_ARGP_LEN(z) (arglist->count > z ? arglist->arglen[z] : 0)
#define GET_INT_ARG(z) getValidInt(GET_ARG(z), filename, command)
#define GET_FLOAT_ARG(z) getValidFloat(GET_ARG(z), filename, command)
#define GET_INT_ARGP(z) getValidInt(GET_ARGP(z), filename, command)
#define GET_FLOAT_ARGP(z) getValidFloat(GET_ARGP(z), filename, command)

#define GET_FRAME_ARG(z) (stricmp(GET_ARG(z), "this")==0?newanim->numframes:GET_INT_ARG(z))

#define NaN 0xAAAAAAAA

static const char* E_OUT_OF_MEMORY = "Error: Could not allocate sufficient memory.\n";
static int DEFAULT_OFFSCREEN_KILL = 3000;


s_sprite_list *sprite_list;
s_sprite_map *sprite_map;

s_savelevel* savelevel;
s_savescore savescore;
s_savedata savedata;

/////////////////////////////////////////////////////////////////////////////
//  Global Variables                                                        //
/////////////////////////////////////////////////////////////////////////////

s_set_entry *levelsets = NULL;
int        num_difficulties;

int		skiptoset = -1;

s_level*            level               = NULL;
s_filestream* filestreams = NULL;
int numfilestreams = 0;
s_screen*           vscreen             = NULL;
s_screen*           background          = NULL;
s_videomodes        videomodes;
int sprite_map_max_items = 0;
int cache_map_max_items = 0;

int startup_done = 0; // startup is only called when a game is loaded. so when exitting from the menu we need a way to figure out which resources to free.
List* modelcmdlist = NULL;
List* modelstxtcmdlist = NULL;
List* levelcmdlist = NULL;
List* levelordercmdlist = NULL;

int atkchoices[MAX_ANIS]; //tempory values for ai functions, should be well enough LOL

//see types.h
const s_drawmethod plainmethod = {
	NULL, // table
	NULL, //fp
	0,    // fillcolor
	1,    //flag
	-1,   // alpha
	-1,   // remap
	0,    //flipx
	0,    //flipy
	0,    //transbg
	0,    //fliprotate
	0,    //rotate
	256,  //scalex
	256,  //scaley
	0,    //shiftx
	0,    //centerx  //currently used only by gfxshadow, do not touch it
	0,    //centery
	1,    //xrepeat
	1,    //yrepeat
	0,    //xspan
	0,    //yspan
	255,255,255, //rgb channels
	0, //tintmode?
	0,
	{{.beginsize=0.0}, {.endsize=0.0}, 0, {.wavespeed=0}, 0} //water
};

const s_defense default_defense = 
{
	1.f,
	0.f,
	1.f,
	0.f,
	0.f,
	0.f,
	0.f
};

// unknockdown attack
const s_attack emptyattack = {
	0, // force
   {0,0,0,0,0}, // coods
   {0, 0, 0}, // dropv
   {0,0,0}, //staydown
   -1, // sound
   -1, // flash
   -1, // blockflash
   -1, // blocksound
   0, //no_block
   0, //counterattack;
   0, //no_pain
   0, //no_kill
   0, //no_flash
   0, //grab
   0, //freeze
   0, //steal
   0, //blast
   0, //force_direction
   0, //forcemap
   0, //seal
   0, //freezetime
   0, //maptime;
   0, //sealtime;
   0, //dot
   0, //dot_index
   0, //dot_time
   0, //dot_force
   0, //dot_rate
   0, //otg
   0, //jugglecost
   0, //guardcost
   0, //attack_drop
   0, //attack_type
   0, //damage_on_landing
   0, //grab_distance
   0, //pause_add
   0 //pain_time
};

//default values 
float default_level_maxtossspeed = 100.0f;
float default_level_maxfallspeed = -6.0f;
float default_level_gravity = -0.1f;

float default_model_jumpheight = 4.0f;
float default_model_jumpspeed = -1;
float default_model_dropv[3] = {3.0f, 1.2f, 0.0f};
float default_model_grabdistance = 36.0f;

// AI attack debug stuff for development purpose, 
// Don't open them to modders yet
float move_noatk_factor=3.0f;
float group_noatk_factor=0.01f;
float agg_noatk_factor=0.0f;
float min_noatk_chance=0.0f;
float max_noatk_chance=0.6f;
float offscreen_noatk_factor=0.5f;
float noatk_duration=0.75f;

char                *custScenes = NULL;
char                *custBkgrds = NULL;
char                *custLevels = NULL;
char                *custModels = NULL;
char                rush_names[2][MAX_NAME_LEN];
char				skipselect[MAX_PLAYERS][MAX_NAME_LEN];
char                branch_name[MAX_NAME_LEN+1];    // Used for branches
int					useSave = 0;
unsigned char       pal[MAX_PAL_SIZE] = {""};
int                 blendfx[MAX_BLENDINGS] = {0,1,0,0,0,0};
char                blendfx_is_set = 0;
int                 fontmonospace[MAX_FONTS] = {0,0,0,0,0,0,0,0};
int                 fontmbs[MAX_FONTS] = {0,0,0,0,0,0,0,0};

// move all blending effects here
unsigned char*      blendings[MAX_BLENDINGS] = {NULL, NULL, NULL, NULL, NULL, NULL} ;
// function pointers to create the tables
palette_table_function blending_table_functions[MAX_BLENDINGS] = {palette_table_screen, palette_table_multiply, palette_table_overlay,palette_table_hardlight, palette_table_dodge, palette_table_half};
blend_table_function blending_table_functions16[MAX_BLENDINGS] = {create_screen16_tbl,create_multiply16_tbl,create_overlay16_tbl,create_hardlight16_tbl,create_dodge16_tbl,create_half16_tbl};
blend_table_function blending_table_functions32[MAX_BLENDINGS] = {create_screen32_tbl,create_multiply32_tbl,create_overlay32_tbl,create_hardlight32_tbl,create_dodge32_tbl,create_half32_tbl};

int                 current_set = 0;
int                 current_level = 0;
int                 current_stage = 1;

int					timevar;
float               bgtravelled;
int                 traveltime;
int                 texttime;
int					timetoshow;
int					showgo;
float               advancex;
float               advancey;

float               scrolldx;                       // advancex changed previous loop
float               scrolldy;                       // advancey .....................
float               scrollminz;                     // Limit level z-scroll
float               scrollmaxz;
float               blockade;                       // Limit x scroll back
float               lasthitx;						//Last hit X location.
float               lasthitz;						//Last hit Z location.
float               lasthita;						//Last hit A location.
int                 lasthitt;                       //Last hit type.
int                 lasthitc;                       //Last hit confirm (i.e. if engine hit code will be used).

int					combodelay = GAME_SPEED/2;		// avoid annoying 112112... infinite combo

// used by gfx shadow
int                 light[2] = {128, 64};
int                 shadowcolor = 0;
int                 shadowalpha = BLEND_MULTIPLY+1;

u64 totalram = 0;
u64 usedram = 0;
u64 freeram = 0;
u32 interval = 0;
extern unsigned long seed;

int                 SAMPLE_GO			= -1;
int                 SAMPLE_BEAT			= -1;
int                 SAMPLE_BLOCK		= -1;
int                 SAMPLE_INDIRECT		= -1;
int                 SAMPLE_GET			= -1;
int                 SAMPLE_GET2			= -1;
int                 SAMPLE_FALL			= -1;
int                 SAMPLE_JUMP			= -1;
int                 SAMPLE_PUNCH		= -1;
int                 SAMPLE_1UP			= -1;
int                 SAMPLE_TIMEOVER		= -1;
int                 SAMPLE_BEEP			= -1;
int                 SAMPLE_BEEP2		= -1;
int                 SAMPLE_BIKE			= -1;

int                 max_downs           = MAX_DOWNS;
int                 max_ups             = MAX_UPS;
int                 max_backwalks       = MAX_BACKWALKS;
int                 max_walks           = MAX_WALKS;
int                 max_idles           = MAX_IDLES;
int                 max_attack_types    = MAX_ATKS;
int                 max_freespecials    = MAX_SPECIALS;
int                 max_follows         = MAX_FOLLOWS;
int                 max_attacks         = MAX_ATTACKS;
int                 max_animations      = MAX_ANIS;

// -------dynamic animation indexes-------
int*                animdowns           = NULL;
int*                animups             = NULL;
int*                animbackwalks       = NULL;
int*                animwalks           = NULL;
int*                animidles           = NULL;
int*                animpains           = NULL;
int*                animdies            = NULL;
int*                animfalls           = NULL;
int*                animrises           = NULL;
int*                animriseattacks     = NULL;
int*                animblkpains        = NULL;
int*                animattacks         = NULL;
int*                animfollows         = NULL;
int*                animspecials        = NULL;

// system default values
int                 downs[MAX_DOWNS]        = {ANI_DOWN};
int                 ups[MAX_UPS]            = {ANI_UP};
int                 backwalks[MAX_BACKWALKS]= {ANI_BACKWALK};
int                 walks[MAX_WALKS]        = {ANI_WALK};
int                 idles[MAX_IDLES]        = {ANI_IDLE};

int                 falls[MAX_ATKS] = {
						ANI_FALL,  ANI_FALL2, ANI_FALL3, ANI_FALL4,
						ANI_FALL,  ANI_BURN,  ANI_FALL,  ANI_SHOCK,
						ANI_FALL,  ANI_FALL5, ANI_FALL6, ANI_FALL7,
						ANI_FALL8, ANI_FALL9, ANI_FALL10
					};

int                 rises[MAX_ATKS] = {
						ANI_RISE,  ANI_RISE2, ANI_RISE3, ANI_RISE4,
						ANI_RISE,  ANI_RISEB,  ANI_RISE,  ANI_RISES,
						ANI_RISE,  ANI_RISE5, ANI_RISE6, ANI_RISE7,
						ANI_RISE8, ANI_RISE9, ANI_RISE10
					};

int                 riseattacks[MAX_ATKS] = {
						ANI_RISEATTACK,  ANI_RISEATTACK2, ANI_RISEATTACK3, ANI_RISEATTACK4,
						ANI_RISEATTACK,  ANI_RISEATTACKB,  ANI_RISEATTACK,  ANI_RISEATTACKS,
						ANI_RISEATTACK,  ANI_RISEATTACK5, ANI_RISEATTACK6, ANI_RISEATTACK7,
						ANI_RISEATTACK8, ANI_RISEATTACK9, ANI_RISEATTACK10
					};

int                 pains[MAX_ATKS] = {
						ANI_PAIN,  ANI_PAIN2,    ANI_PAIN3, ANI_PAIN4,
						ANI_PAIN,  ANI_BURNPAIN, ANI_PAIN,  ANI_SHOCKPAIN,
						ANI_PAIN,  ANI_PAIN5,    ANI_PAIN6, ANI_PAIN7,
						ANI_PAIN8, ANI_PAIN9,    ANI_PAIN10
					};

int                 deaths[MAX_ATKS] = {
						ANI_DIE,   ANI_DIE2,     ANI_DIE3,  ANI_DIE4,
						ANI_DIE,   ANI_BURNDIE,  ANI_DIE,   ANI_SHOCKDIE,
						ANI_DIE,   ANI_DIE5,     ANI_DIE6,  ANI_DIE7,
						ANI_DIE8,  ANI_DIE9,     ANI_DIE10
					};

int                 blkpains[MAX_ATKS] = {
						ANI_BLOCKPAIN,  ANI_BLOCKPAIN2,    ANI_BLOCKPAIN3, ANI_BLOCKPAIN4,
						ANI_BLOCKPAIN,  ANI_BLOCKPAINB, ANI_BLOCKPAIN,  ANI_BLOCKPAINS,
						ANI_BLOCKPAIN,  ANI_BLOCKPAIN5,    ANI_BLOCKPAIN6, ANI_BLOCKPAIN7,
						ANI_BLOCKPAIN8, ANI_BLOCKPAIN9,    ANI_BLOCKPAIN10
					};

int                 normal_attacks[MAX_ATTACKS] = {
						ANI_ATTACK1, ANI_ATTACK2, ANI_ATTACK3, ANI_ATTACK4
					};

int                 grab_attacks[5][2] = {
						{ANI_GRABATTACK, ANI_GRABATTACK2},
						{ANI_GRABFORWARD, ANI_GRABFORWARD2},
						{ANI_GRABUP, ANI_GRABUP2},
						{ANI_GRABDOWN, ANI_GRABDOWN2},
						{ANI_GRABBACKWARD, ANI_GRABBACKWARD2}
					};

int                 freespecials[MAX_SPECIALS] = {
						ANI_FREESPECIAL,   ANI_FREESPECIAL2,  ANI_FREESPECIAL3,
						ANI_FREESPECIAL4,  ANI_FREESPECIAL5,  ANI_FREESPECIAL6,
						ANI_FREESPECIAL7,  ANI_FREESPECIAL8
					};

int                 follows[MAX_FOLLOWS] = {
						ANI_FOLLOW1, ANI_FOLLOW2, ANI_FOLLOW3, ANI_FOLLOW4
					};

#ifndef DISABLE_MOVIE
#define DISABLE_MOVIE
#endif

//movie log stuffs
#ifndef DISABLE_MOVIE
#define MOVIEBUF_LEN 2048
int movielog = 0;
int movieplay = 0;
int moviebufptr = 0;
int movielen = 0;
int movieloglen = 0;
FILE* moviefile = NULL;
u32 (*moviebuffer)[5][2] = NULL; //keyflags, newkeyflags;
#endif

// background cache to speed up in-game menus
#if WII
s_screen*           bg_cache[MAX_CACHED_BACKGROUNDS] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
unsigned char		bg_palette_cache[MAX_CACHED_BACKGROUNDS][MAX_PAL_SIZE];
#endif

/*
int                 maxplayers[MAX_DIFFICULTIES] = {2,2,2,2,2,2,2,2,2,2};
int                 ctrlmaxplayers[MAX_DIFFICULTIES] = {0,0,0,0,0,0,0,0,0,0};
unsigned int        num_levels[MAX_DIFFICULTIES];
unsigned int        ifcomplete[MAX_DIFFICULTIES];
unsigned int        noshowhof[MAX_DIFFICULTIES];
unsigned int        difflives[MAX_DIFFICULTIES];				// What too easy?  change the # of lives players get
unsigned int        custfade[MAX_DIFFICULTIES];
unsigned int        diffcreds[MAX_DIFFICULTIES];				// What still to easy - lets see how they do without continues!
unsigned int        diffoverlap[MAX_DIFFICULTIES];				// Music overlap
unsigned int        typemp[MAX_DIFFICULTIES];
unsigned int        continuescore[MAX_DIFFICULTIES];             //what to do with score if continue is used.
char*               (*skipselect)[MAX_DIFFICULTIES][MAX_PLAYERS] = NULL;              // skips select screen and automatically gives players models specified
int                 cansave_flag[MAX_DIFFICULTIES];             // 0, no save, 1 save level position 2 save all: lives/credits/hp/mp/also player
int                 same[MAX_DIFFICULTIES];						// ltb 1-13-05   sameplayer
*/
int                 cameratype          = 0;
int					defaultmaxplayers	= 2;

u32                 go_time             = 0;
u32                 time                = 0;
u32                 newtime             = 0;
unsigned char       slowmotion[3]       = {0,2,0};              // [0] = enable/disable; [1] = duration; [2] = counter;
int                 disablelog          = 0;
int                 currentspawnplayer  = 0;
int					ent_list_size		= 0;
int                 PLAYER_MIN_Z        = 160;
int                 PLAYER_MAX_Z        = 232;
int                 BGHEIGHT            = 160;
int                 MAX_WALL_HEIGHT     = 1000;					// Max wall height that an entity can be spawned on
int                 saveslot            = 0;
int                 current_palette     = 0;
int                 fade                = 24;
int                 credits             = 0;
int                 gosound             = 0;					// Used to prevent go sound playing too frequently,
int                 musicoverlap        = 0;
int                 colorbars           = 0;
int                 current_spawn       = 0;
int                 level_completed     = 0;
int                 nojoin              = 0;					// dont allow new hero to join in, use "Please Wait" instead of "Select Hero"
int                 groupmin            = 0;
int					groupmax            = 0;
int                 selectScreen        = 0;					// Flag to determine if at select screen (used for setting animations)
int					titleScreen			= 0;
int					menuScreen			= 0;
int					hallOfFame			= 0;
int					gameOver			= 0;
int					showComplete		= 0;
char*				currentScene		= NULL;
int                 tospeedup           = 0;          			// If set will speed the level back up after a boss hits the ground
int                 reached[4]          = {0,0,0,0};			// Used with TYPE_ENDLEVEL to determine which players have reached the point //4player
int                 noslowfx			= 0;           			// Flag to determine if sound speed when hitting opponent slows or not
int                 equalairpause 		= 0;         			// If set to 1, there will be no extra pausetime for players who hit multiple enemies in midair
int                 hiscorebg			= 0;					// If set to 1, will look for a background image to display at the highscore screen
int                 completebg			= 0;           			// If set to 1, will look for a background image to display at the showcomplete screen
s_loadingbar        loadingbg[2] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // If set to 1, will look for a background image to display at the loading screen
int					loadingmusic        = 0;
int                 unlockbg            = 0;         			// If set to 1, will look for a different background image after defeating the game
int                 pause               = 0;
int					nofadeout			= 0;
int					nosave				= 0;
int                 nopause             = 0;                    // OX. If set to 1 , pausing the game will be disabled.
int                 noscreenshot        = 0;                    // OX. If set to 1 , taking screenshots is disabled.
int                 endgame             = 0;
int                 forcecheatsoff      = 0;
int                 cheats              = 0;
int                 livescheat          = 0;
int                 keyscriptrate       = 0;
int                 creditscheat        = 0;
int                 healthcheat         = 0;
int                 showtimeover        = 0;
int                 sameplayer          = 0;            		// 7-1-2005  flag to determine if players can use the same character
int                 PLAYER_LIVES        = 3;					// 7-1-2005  default setting for Lives
int                 CONTINUES           = 5;					// 7-1-2005  default setting for continues
int                 colourselect		= 0;					// 6-2-2005 Colour select is optional
int                 autoland			= 0;					// Default set to no autoland and landing is valid with u j combo
int                 ajspecial			= 0;					// Flag to determine if holding down attack and pressing jump executes special
int                 nolost				= 0;					// variable to control if drop weapon when grab a enemy by tails
int                 nocost				= 0;					// If set, special will not cost life unless an enemy is hit
int                 mpstrict			= 0;					// If current system will check all animation's energy cost when set new animations
int                 magic_type			= 0;					// use for restore mp by time by tails
entity*             textbox				= NULL;
entity*             smartbomber			= NULL;
entity*				stalker				= NULL;					// an enemy (usually) tries to go behind the player
entity*				firstplayer			= NULL;
int					stalking			= 0;
int					nextplan			= 0;
int                 plife[4][2]         = {{0,0},{0,0},{0,0},{0,0}};// Used for customizable player lifebar
int                 plifeX[4][3]        = {{0,0,-1},{0,0,-1},{0,0,-1},{0,0,-1}};// Used for customizable player lifebar 'x'
int                 plifeN[4][3]        = {{0,0,-1},{0,0,-1},{0,0,-1},{0,0,-1}};// Used for customizable player lifebar number of lives
int                 picon[4][2]         = {{0,0},{0,0},{0,0},{0,0}};// Used for customizable player icon
int                 piconw[4][2]        = {{0,0},{0,0},{0,0},{0,0}};// Used for customizable player weapon icons
int                 mpicon[4][2]        = {{0,0},{0,0},{0,0},{0,0}};// Used for customizable magicbar player icon
int                 pnameJ[4][7]        = {{0,0,0,0,0,0,-1},{0,0,0,0,0,0,-1},{0,0,0,0,0,0,-1},{0,0,0,0,0,0,-1}};// Used for customizable player name, Select Hero, (Credits, Press Start, Game Over) when joining
int                 pscore[4][7]        = {{0,0,0,0,0,0,-1},{0,0,0,0,0,0,-1},{0,0,0,0,0,0,-1},{0,0,0,0,0,0,-1}};// Used for customizable player name, dash, score
int                 pshoot[4][3]        = {{0,0,-1},{0,0,-1},{0,0,-1},{0,0,-1}};// Used for customizable player shootnum
int                 prush[4][8]         = {{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0}};// Used for customizable player combo/rush system
int                 psmenu[4][4]        = {{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}};// Used for customizable player placement in select menu
int                 mpcolourtable[11]   = {0,0,0,0,0,0,0,0,0,0,0};
int                 hpcolourtable[11]   = {0,0,0,0,0,0,0,0,0,0,0};
int                 ldcolourtable[11]   = {0,0,0,0,0,0,0,0,0,0,0};
char                musicname[128]      = {""};
char                currentmusic[128]    = {""};
float               musicfade[2]        = {0,0};
int                 musicloop           = 0;
u32                 musicoffset         = 0;
int					alwaysupdate		= 0; //execute update/updated scripts whenever it has a chance

s_barstatus         loadingbarstatus =
{
	0,                          //int          offsetx:16;
	0,                          //int          offsety:16;
	0,                          //int          sizex:16;
	10,                          //int          sizey:16;
	percentagebar,                   //bartype      type:8;
	horizontalbar,              //barorient    orientation:8;
	0,                          //int          noborder:8;
	0,                          //int          direction:8;
	0,                          //int          barlayer;
	0,                          //int          backlayer;
	0,                          //int          borderlayer;
	0,                          //int          shadowlayer;
	&ldcolourtable
};
s_barstatus         lbarstatus =                                // Used for customizable lifebar size
{
	0,                          //int          offsetx:16;
	0,                          //int          offsety:16;
	0,                          //int          sizex:16;
	0,                          //int          sizey:16;
	valuebar,                   //bartype      type:8;
	horizontalbar,              //barorient    orientation:8;
	0,                          //int          noborder:8;
	0,                          //int          direction:8;
	0,                          //int          barlayer;
	0,                          //int          backlayer;
	0,                          //int          borderlayer;
	0,                          //int          shadowlayer;
	&hpcolourtable
};
s_barstatus         olbarstatus =                               // Used for customizable opponent lifebar size
{
	0,                          //int          offsetx:16;
	0,                          //int          offsety:16;
	0,                          //int          sizex:16;
	0,                          //int          sizey:16;
	valuebar,                   //bartype      type:8;
	horizontalbar,              //barorient    orientation:8;
	0,                          //int          noborder:8;
	0,                          //int          direction:8;
	0,                          //int          barlayer;
	0,                          //int          backlayer;
	0,                          //int          borderlayer;
	0,                          //int          shadowlayer;
	&hpcolourtable
};
int                 timeloc[6]			= {0,0,0,0,0,-1};		// Used for customizable timeclock location/size
int                 timeicon			= -1;
short               timeicon_offsets[2] = {0,0};
char                timeicon_path[128]  = {""};
int                 bgicon   			= -1;
short               bgicon_offsets[3]	= {0,0,0};
char                bgicon_path[128]    = {""};
int                 olicon    			= -1;
short               olicon_offsets[3]	= {0,0,0};
char                olicon_path[128]    = {""};
int                 elife[4][2]         = {{0,0},{0,0},{0,0},{0,0}};// Used for customizable enemy lifebar
int                 ename[4][3]         = {{0,0,-1},{0,0,-1},{0,0,-1},{0,0,-1}};// Used for customizable enemy name
int                 eicon[4][2]         = {{0,0},{0,0},{0,0},{0,0}};// Used for customizable enemy icon
int                 scomplete[6]		= {0,0,0,0,0,0};		// Used for customizable Stage # Complete
int                 cbonus[10]          = {0,0,0,0,0,0,0,0,0,0};// Used for customizable clear bonus
int                 lbonus[10]          = {0,0,0,0,0,0,0,0,0,0};// Used for customizable life bonus
int                 rbonus[10]          = {0,0,0,0,0,0,0,0,0,0};// Used for customizable rush bonus
int                 tscore[10]          = {0,0,0,0,0,0,0,0,0,0};// Used for customizable total score
int                 scbonuses[4]        = {10000, 1000, 100, 0};//Stage complete bonus multipliers
int                 showrushbonus       = 0;
int                 noshare				= 0;					// Used for when you want to keep p1 & p2 credits separate
int                 nodropen			= 0;					// Drop or not when spawning is now a modder option
int					nodropspawn			= 0;					// don't spawn from the sky if the modder doesn't set it
int                 gfx_x_offset		= 0;                    //2011_04_03, DC: Enable X offset adjustment by modders.
int                 gfx_y_offset		= 0;
int                 gfx_y_offset_adj    = 0;                    //2011_04_03, DC: Enable Y offset adjustment by modders.

// 2011/10/22 UT: temporary solution for custom viewport
int					viewportx			= 0;
int					viewporty			= 0;
int					viewportw			= 0;
int					viewporth			= 0;


int                 timeleft			= 0;
int                 oldtime             = 0;                    // One second back from time left.
int                 holez				= 0;					// Used for setting spawn points
int                 allow_secret_chars	= 0;
unsigned int        lifescore			= 50000;				// Number of points needed to earn a 1-up
unsigned int        credscore			= 0;					// Number of points needed to earn a credit
int                 mpblock				= 0;					// Take chip damage from health or MP first?
int                 blockratio			= 0;					// Take half-damage while blocking?
int                 nochipdeath			= 0;					// Prevents entities from dying due to chip damage (damage while blocking)
int                 noaircancel         = 0;					// Now, you can make jumping attacks uncancellable!
int                 nomaxrushreset[5]   = {0,0,0,0,0};
s_barstatus         mpbarstatus =                               // Used for customizable lifebar size
{
	0,                          //int          offsetx:16;
	0,                          //int          offsety:16;
	0,                          //int          sizex:16;
	0,                          //int          sizey:16;
	valuebar,                   //bartype      type:8;
	horizontalbar,              //barorient    orientation:8;
	0,                          //int          noborder:8;
	0,                          //int          direction:8;
	0,                          //int          barlayer;
	0,                          //int          backlayer;
	0,                          //int          borderlayer;
	0,                          //int          shadowlayer;
	&mpcolourtable
};
int			        mpbartext[4]		= {-1,0,0,0};			// Array for adjusting MP status text (font, Xpos, Ypos, Display type).
int			        lbartext[4]			= {-1,0,0,0};			// Array for adjusting HP status text (font, Xpos, Ypos, Display type).
int                 pmp[4][2]			= {{0,0},{0,0},{0,0},{0,0}};// Used for customizable player mpbar
int                 spdirection[4]		= {1,0,1,0};			// Used for Select Player Direction for select player screen
int                 bonus				= 0;					// Used for unlocking Bonus difficulties
int                 versusdamage		= 2;					// Used for setting mode. (ability to hit other players)
int                 z_coords[3]			= {0,0,0};				// Used for setting customizable walkable area
int                 rush[6]				= {0,2,3,3,3,3};
int                 color_black			= 0;
int                 color_red			= 0;
int                 color_orange		= 0;
int                 color_yellow		= 0;
int                 color_white			= 0;
int                 color_blue			= 0;
int                 color_green			= 0;
int                 color_pink			= 0;
int                 color_purple		= 0;
int                 color_magic			= 0;
int                 color_magic2		= 0;
int                 lifebarfgalpha      = 0;
int                 lifebarbgalpha      = 2;
int                 shadowsprites[6]	= {-1,-1,-1,-1,-1,-1};
int                 gosprite			= -1;
int                 golsprite			= -1;
int                 holesprite			= -1;
int                 videoMode			= 0;
int                 scoreformat			= 0;					// If set fill score values with 6 Zeros

// Funny neon lights
unsigned char       neontable[MAX_PAL_SIZE];
unsigned int        neon_time			= 0;

int                 panel_width			= 0;
int                 panel_height		= 0;
int                 frontpanels_loaded	= 0;

unsigned int        sprites_loaded		= 0;
unsigned int        anims_loaded		= 0;

unsigned int        models_loaded		= 0;
unsigned int        models_cached		= 0;

entity**            ent_list;
entity*             self;
int                 ent_count			= 0;					// log count of entites
int                 ent_max				= 0;

s_player            player[4];
u32                 bothkeys, bothnewkeys;

s_playercontrols    playercontrols1;
s_playercontrols    playercontrols2;
s_playercontrols    playercontrols3;
s_playercontrols    playercontrols4;
s_playercontrols*   playercontrolpointers[] = {&playercontrols1, &playercontrols2, &playercontrols3, &playercontrols4};


//global script
Script level_script;    //execute when level start
Script endlevel_script; //execute when level finished
Script update_script;   //execute when ingame update
Script updated_script;  //execute when ingame update finished
Script loading_script;	// in loading screen
Script key_script_all;  //keyscript for all players
Script timetick_script; //time tick script.

//player script
Script score_script[4];     //execute when add score, 4 players
Script key_script[4];       //key listeners, lol
Script join_script[4];      //player join scripts
Script respawn_script[4];   //player respawn scripts
Script pdie_script[4];      //player death scripts

extern Script* pcurrentscript;//used by local script functions
//-------------------------methods-------------------------------

void setDrawMethod(s_anim* a, ptrdiff_t index, s_drawmethod* m) {
	assert(index >= 0);
	assert(a != NULL);
	assert(m != NULL);
	assert(index < a->numframes);
	a->drawmethods[index] = m;
}

s_drawmethod* getDrawMethod(s_anim* a, ptrdiff_t index) {
	assert(index >= 0);
	assert(a != NULL);
	assert(index < a->numframes);
	return a->drawmethods[index];
}

int isLoadingScreenTypeBg(loadingScreenType what) {
	return (what & LSTYPE_BACKGROUND) == LSTYPE_BACKGROUND;
}

int isLoadingScreenTypeBar(loadingScreenType what) {
	return (what & LSTYPE_BAR) == LSTYPE_BAR;
}

char* fill_s_loadingbar(s_loadingbar* s, char set, short bx, short by, short bsize, short tx, short ty, char tf, int ms) {
	switch (set) {
		case 1: s->set = (LSTYPE_BACKGROUND | LSTYPE_BAR); break;
		case 2: s->set = LSTYPE_BACKGROUND; break;
		case 3: s->set = LSTYPE_BAR; break;
		case 0: s->set = LSTYPE_NONE; break;
		default:
			s->set = LSTYPE_NONE;
			printf("invalid loadingbg type %d!\n", set);
	}
	s->tf = tf;
	s->bx = bx;
	s->by = by;
	s->bsize = bsize;
	s->tx = tx;
	s->ty = ty;
	s->refreshMs = (ms ? ms : 100);
	return NULL;
}


// returns: 1 - succeeded 0 - failed
int buffer_pakfile(char* filename, char** pbuffer, size_t* psize)
{
	int handle;
	*psize = 0;
	*pbuffer = NULL;
	// Read file
#ifdef VERBOSE
	printf("pakfile requested: %s.\n", filename); //ASDF
#endif

	if((handle=openpackfile(filename,packfile)) < 0) {
#ifdef VERBOSE
		printf("couldnt get handle!\n");
#endif
		return 0;
	}
	*psize = seekpackfile(handle,0,SEEK_END);
	seekpackfile(handle,0,SEEK_SET);

	*pbuffer = (char*)malloc(*psize+1);
	if(*pbuffer == NULL){
		*psize = 0;
		closepackfile(handle);
		shutdown(1, "Can't create buffer for packfile '%s'", filename);
		return 0;
	}
	if(readpackfile(handle, *pbuffer, *psize) != *psize){
		if(*pbuffer != NULL){
			free(*pbuffer);
			*pbuffer = NULL;
			*psize = 0;
		}
		closepackfile(handle);
		shutdown(1, "Can't read from packfile '%s'", filename);
		return 0;
	}
	(*pbuffer)[*psize] = 0;        // Terminate string (important!)
	closepackfile(handle);
	return 1;
}

int buffer_append(char** buffer, const char* str, size_t n, size_t* bufferlen, size_t *len)
{
	size_t appendlen = strlen(str);
	if(appendlen>n) appendlen = n;
	if(appendlen+*len+1>*bufferlen)
	{
		printf("*Debug* reallocating buffer...\n");
		*buffer = realloc(*buffer, *bufferlen=appendlen+*len+1024);
		if(*buffer==NULL) shutdown(1, "Unalbe to resize buffer.\n");
	}
	strncpy(*buffer+*len, str, appendlen);
	*len = *len + appendlen;
	(*buffer)[*len] = 0;
	return *len;
}

int handle_txt_include(char* command, ArgList *arglist, char** fn, char* namebuf, char** buf, ptrdiff_t* pos, size_t* len)
{
	char* incfile, *filename=*fn, *buf2, *endstr="\r\n@end";
	size_t size, t;
	if(stricmp(command, "@include")==0){
		incfile = GET_ARGP(1);
		buffer_pakfile(incfile, &buf2, &size) ;
		if(buf2){
			*buf = realloc(*buf, *len+size+strlen(incfile)+strlen(filename)+100); //leave enough memory for jump command
			if(*buf==NULL) {
				shutdown(1, "Unalbe to resize buffer. (handle_txt_include)\n");
				free(buf2);
				return 0;
			}
			sprintf((*buf)+*len-1, "%s\r\n@filename %s\r\n", endstr, incfile);
			strcat((*buf)+*len, buf2);
			t = strlen(*buf);
			sprintf((*buf)+t, "\r\n@filename %s\r\n@jump %d\r\n", filename, (int)(*pos));
			(*buf)[*pos] = '#';
			*pos = *len + strlen(endstr); //continue from the new file position
			*len = strlen(*buf);
			free(buf2);
			//printf(*buf);
			return 1;
		}
		shutdown(1, "Can't find file '%s' to include.\n", incfile);
	}else if(stricmp(command, "@jump")==0){
		*pos = GET_INT_ARGP(1);
		return 2;
	}else if(stricmp(command, "@end")==0){
		*pos = *len;
		return 3;
	}else if(stricmp(command, "@filename")==0){
		strcpy(namebuf, GET_ARGP(1));
		*fn = namebuf;
		return 4;
	}
	return 0;
}

//this method is used by script engine, we move it here
// it will get a system property, put it in the ScriptVariant
// if failed return 0, otherwise return 1
int getsyspropertybyindex(ScriptVariant* var, int index)
{
	if(!var) return 0;

	switch(index)
	{
	case _sv_count_enemies:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)count_ents(TYPE_ENEMY);
		break;
	case _sv_count_players:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)count_ents(TYPE_PLAYER);
		break;
	case _sv_count_npcs:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)count_ents(TYPE_NPC);
		break;
	case _sv_count_entities:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)ent_count;
		break;
	case _sv_ent_max:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)ent_max;
		break;
	case _sv_in_level:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(level != NULL);
		break;
	case _sv_in_gameoverscreen:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(gameOver);
		break;
	case _sv_in_menuscreen:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		if(selectScreen || titleScreen || hallOfFame || gameOver || showComplete || currentScene || level)
			var->lVal = (LONG)0;
		else var->lVal = (LONG)(menuScreen);
		break;
	case _sv_in_showcomplete:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(showComplete);
		break;
	case _sv_in_titlescreen:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(titleScreen);
		break;
	case _sv_in_halloffamescreen:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(hallOfFame);
		break;
	case _sv_effectvol:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)savedata.effectvol;
		break;
	case _sv_elapsed_time:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)time;
		break;
	case _sv_game_speed:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)GAME_SPEED;
		break;
	case _sv_pause:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)pause;
		break;
    case _sv_gfx_x_offset:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)gfx_x_offset;
		break;
	case _sv_gfx_y_offset:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)gfx_y_offset;
		break;
    case _sv_gfx_y_offset_adj:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)gfx_y_offset_adj;
		break;
	case _sv_in_selectscreen:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(selectScreen);
		break;
	case _sv_lasthita:
		ScriptVariant_ChangeType(var, VT_DECIMAL);
		var->dblVal = (DOUBLE)(lasthita);
		break;
	case _sv_lasthitc:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(lasthitc);
		break;
	case _sv_lasthitt:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(lasthitt);
		break;
	case _sv_lasthitx:
		ScriptVariant_ChangeType(var, VT_DECIMAL);
		var->dblVal = (DOUBLE)(lasthitx);
		break;
	case _sv_lasthitz:
		ScriptVariant_ChangeType(var, VT_DECIMAL);
		var->dblVal = (DOUBLE)(lasthitz);
		break;
	case _sv_xpos:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_DECIMAL);
		var->dblVal = (DOUBLE)advancex;
		break;
	case _sv_ypos:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_DECIMAL);
		var->dblVal = (DOUBLE)advancey;
		break;
	case _sv_hResolution:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)videomodes.hRes;
		break;
	case _sv_vResolution:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)videomodes.vRes;
		break;
	case _sv_current_scene:
		if(currentScene){
			ScriptVariant_ChangeType(var, VT_STR);
			strcpy(StrCache_Get(var->strVal), currentScene);
		}else ScriptVariant_Clear(var);
		break;
	case _sv_current_set:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(current_set);
		break;
	case _sv_current_level:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(current_level);
		break;
	case _sv_current_palette:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(current_palette);
		break;
	case _sv_current_stage:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(current_stage);
		break;
	case _sv_levelwidth:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(level->width);
		break;
	case _sv_levelheight:
		if(!level) return 0;
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(panel_height);
		break;
	case _sv_branchname:
		ScriptVariant_ChangeType(var, VT_STR);
		strcpy(StrCache_Get(var->strVal), branch_name);
		break;
	case _sv_current_branch:
		ScriptVariant_ChangeType(var, VT_STR);
		if(levelsets[current_set].levelorder[current_level].branchname)
			strcpy(StrCache_Get(var->strVal), levelsets[current_set].levelorder[current_level].branchname);
		else ScriptVariant_Clear(var);
		break;
	case _sv_pakname:
		ScriptVariant_ChangeType(var, VT_STR);
		getPakName(StrCache_Get(var->strVal), -1);
		break;
	case _sv_maxentityvars:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)max_entity_vars;
		break;
	case _sv_maxglobalvars:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)max_global_vars;
		break;
	case _sv_maxindexedvars:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)max_indexed_vars;
		break;
	case _sv_maxplayers:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)levelsets[current_set].maxplayers;
		break;
	case _sv_maxscriptvars:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)max_script_vars;
		break;
	case _sv_models_cached:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)models_cached;
		break;
	case _sv_models_loaded:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)models_loaded;
		break;
	case _sv_musicvol:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)savedata.musicvol;
		break;
	case _sv_nofadeout:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)nofadeout;
		break;
	case _sv_nopause:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)nopause;
		break;
	case _sv_nosave:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)nosave;
		break;
	case _sv_noscreenshot:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)noscreenshot;
		break;
	case _sv_numpalettes:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(level->numpalettes);
		break;
	case _sv_pixelformat:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)pixelformat;
		break;
	case _sv_player:
	case _sv_player1:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)player;
		break;
	case _sv_player2:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)(player+1);
		break;
	case _sv_player3:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)(player+2);
		break;
	case _sv_player4:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)(player+3);
		break;
	case _sv_player_max_z:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(PLAYER_MAX_Z);
		break;
	case _sv_player_min_z:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(PLAYER_MIN_Z);
		break;
	case _sv_lightx:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(light[0]);
		break;
	case _sv_lightz:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)(light[1]);
		break;
	case _sv_self:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)self;
		break;
	case _sv_shadowalpha:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)shadowalpha;
		break;
	case _sv_shadowcolor:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)shadowcolor;
		break;
	case _sv_skiptoset:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)skiptoset;
		break;
	case _sv_slowmotion:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)slowmotion[0];
		break;
	case _sv_slowmotion_duration:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)slowmotion[1];
		break;
	case _sv_soundvol:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)savedata.soundvol;
		break;
	case _sv_game_paused:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)pause;
		break;
	case _sv_totalram:
		 ScriptVariant_ChangeType(var, VT_INTEGER);
		 var->lVal = (LONG)getSystemRam(KBYTES);
		break;
	case _sv_freeram:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)getFreeRam(KBYTES);
		break;
	case _sv_usedram:
		 ScriptVariant_ChangeType(var, VT_INTEGER);
		 var->lVal = (LONG)getUsedRam(KBYTES);
		break;
	case _sv_usesave:
		 ScriptVariant_ChangeType(var, VT_INTEGER);
		 var->lVal = (LONG)useSave;
		break;
	case _sv_background:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)background;
		break;
	case _sv_vscreen:
		ScriptVariant_ChangeType(var, VT_PTR);
		var->ptrVal = (VOID*)vscreen;
		break;
	case _sv_viewportx:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)viewportx;
		break;
	case _sv_viewporty:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)viewporty;
		break;
	case _sv_viewportw:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)viewportw;
		break;
	case _sv_viewporth:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)viewporth;
		break;
	case _sv_waiting:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = level?(LONG)level->waiting:0;
	case _sv_maxattacktypes:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)max_attack_types;
		break;
	case _sv_maxanimations:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)max_animations;
		break;
	case _sv_ticks:
		ScriptVariant_ChangeType(var, VT_INTEGER);
		var->lVal = (LONG)timer_gettick();
		break;
	default:
		// We use indices now, but players/modders don't need to be exposed
		// to that implementation detail, so we write "name" and not "index".
		printf("Unknown system property name.\n");
		return 0;
	}
	return 1;
}

// change a system variant, used by script
int changesyspropertybyindex(int index, ScriptVariant* value)
{
	//char* tempstr = NULL;
	LONG ltemp;
	//DOUBLE dbltemp;

	switch(index)
	{
	case _sv_elapsed_time:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			time = (int)ltemp;
		break;
	case _sv_current_stage:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			current_stage = (int)ltemp;
		break;
	case _sv_current_set:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			current_set = (int)ltemp;
		break;
	case _sv_current_level:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			current_level = (int)ltemp;
		break;
    case _sv_gfx_x_offset:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			gfx_x_offset = (int)ltemp;
		break;
    case _sv_gfx_y_offset:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			gfx_y_offset = (int)ltemp;
		break;
    case _sv_gfx_y_offset_adj:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			gfx_y_offset_adj = (int)ltemp;
		break;
	case _sv_levelpos:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			level->pos = (int)ltemp;
		break;
	case _sv_xpos:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			advancex = (float)ltemp;
		break;
	case _sv_ypos:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			advancey = (float)ltemp;
		break;
	case _sv_scrollminz:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			scrollminz = (float)ltemp;
		break;
	case _sv_scrollmaxz:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			scrollmaxz = (float)ltemp;
		break;
	case _sv_blockade:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			shadowalpha = (float)ltemp;
		break;
	case _sv_shadowcolor:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			shadowcolor = (int)ltemp;
		break;
	case _sv_shadowalpha:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			skiptoset = (int)ltemp;
		break;
	case _sv_skiptoset:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			skiptoset = (int)ltemp;
		break;
	case _sv_slowmotion:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			slowmotion[0] = (unsigned char)ltemp;
		break;
	case _sv_slowmotion_duration:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			slowmotion[1] = (unsigned char)ltemp;
		break;
	case _sv_lasthitx:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			lasthitx = (float)ltemp;
		break;
	case _sv_lasthita:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			lasthita = (float)ltemp;
		break;
	 case _sv_lasthitc:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			lasthitc = (int)ltemp;
		break;
	case _sv_lasthitz:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			lasthitz = (float)ltemp;
		break;
	case _sv_lasthitt:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			lasthitt = (int)ltemp;
		break;
	case _sv_smartbomber:
		smartbomber = (entity*)value->ptrVal;
		break;
	case _sv_textbox:
		textbox = (entity*)value->ptrVal;
		break;
	case _sv_nofadeout:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			nofadeout = (int)ltemp;
		break;
	case _sv_nopause:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			nopause = (int)ltemp;
		break;
	case _sv_nosave:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			nosave = (int)ltemp;
		break;
	case _sv_noscreenshot:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			noscreenshot = (int)ltemp;
		break;
	case _sv_usesave:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			useSave = (int)ltemp;
		break;
	case _sv_viewportx:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			viewportx = (int)ltemp;
		break;
	case _sv_viewporty:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			viewporty = (int)ltemp;
		break;
	case _sv_viewportw:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			viewportw = (int)ltemp;
		break;
	case _sv_viewporth:
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			viewporth = (int)ltemp;
		break;
	case _sv_waiting:
		if(!level) break;
		if(SUCCEEDED(ScriptVariant_IntegerValue(value, &ltemp)))
			level->waiting = (int)ltemp;
		break;
	default:
		return 0;
	}

	return 1;
}


int load_script(Script* script, char* file)
{
	size_t size = 0;
	int failed = 0;
	char* buf = NULL;

	if(buffer_pakfile(file, &buf, &size)!=1) return 0;

	failed = !Script_AppendText(script, buf, file);

	if(buf != NULL)
	{
		free(buf);
		buf = NULL;
	}

	// text loaded but parsing failed, shutdown
	if(failed) shutdown(1, "Failed to parse script file: '%s'!\n", file);
	return !failed;
}

// this method is used by load_scripts, don't call it
void init_scripts()
{
	int i;
	Script_Global_Init();
	Script_Init(&update_script,     "update",  NULL,  1);
	Script_Init(&updated_script,    "updated",  NULL, 1);
	Script_Init(&level_script,      "level",    NULL,  1);
	Script_Init(&endlevel_script,   "endlevel",  NULL, 1);
	Script_Init(&key_script_all,    "keyall",   NULL,  1);
	Script_Init(&timetick_script,   "timetick",  NULL, 1);
	Script_Init(&loading_script,    "loading",   NULL, 1);
	for(i=0; i<4; i++) Script_Init(&score_script[i],    "score",    NULL,  1);
	for(i=0; i<4; i++) Script_Init(&key_script[i],      "key",      NULL,  1);
	for(i=0; i<4; i++) Script_Init(&join_script[i],     "join",      NULL, 1);
	for(i=0; i<4; i++) Script_Init(&respawn_script[i],  "respawn",   NULL, 1);
	for(i=0; i<4; i++) Script_Init(&pdie_script[i],     "die",       NULL, 1);
}

// This method is called once when the engine starts, do not use it multiple times
// It should be calld after load_script_setting
void load_scripts()
{
	int i;
	init_scripts();
	//Script_Clear's second parameter set to 2, because the script fails to load,
	//and will never have another chance to be loaded, so just clear the variable list in it
	if(!load_script(&update_script,     "data/scripts/update.c"))   Script_Clear(&update_script,        2);
	if(!load_script(&updated_script,    "data/scripts/updated.c"))  Script_Clear(&updated_script,       2);
	if(!load_script(&level_script,      "data/scripts/level.c"))    Script_Clear(&level_script,         2);
	if(!load_script(&endlevel_script,   "data/scripts/endlevel.c")) Script_Clear(&endlevel_script,      2);
	if(!load_script(&key_script_all,    "data/scripts/keyall.c"))   Script_Clear(&key_script_all,       2);
	if(!load_script(&timetick_script,   "data/scripts/timetick.c")) Script_Clear(&timetick_script,      2);
	if(!load_script(&loading_script,    "data/scripts/loading.c"))  Script_Clear(&loading_script,       2);
	if(!load_script(&score_script[0],   "data/scripts/score1.c"))   Script_Clear(&score_script[0],      2);
	if(!load_script(&score_script[1],   "data/scripts/score2.c"))   Script_Clear(&score_script[1],      2);
	if(!load_script(&score_script[2],   "data/scripts/score3.c"))   Script_Clear(&score_script[2],      2);
	if(!load_script(&score_script[3],   "data/scripts/score4.c"))   Script_Clear(&score_script[3],      2);
	if(!load_script(&key_script[0],     "data/scripts/key1.c"))     Script_Clear(&key_script[0],        2);
	if(!load_script(&key_script[1],     "data/scripts/key2.c"))     Script_Clear(&key_script[1],        2);
	if(!load_script(&key_script[2],     "data/scripts/key3.c"))     Script_Clear(&key_script[2],        2);
	if(!load_script(&key_script[3],     "data/scripts/key4.c"))     Script_Clear(&key_script[3],        2);
	if(!load_script(&join_script[0],    "data/scripts/join1.c"))    Script_Clear(&join_script[0],       2);
	if(!load_script(&join_script[1],    "data/scripts/join2.c"))    Script_Clear(&join_script[1],       2);
	if(!load_script(&join_script[2],    "data/scripts/join3.c"))    Script_Clear(&join_script[2],       2);
	if(!load_script(&join_script[3],    "data/scripts/join4.c"))    Script_Clear(&join_script[3],       2);
	if(!load_script(&respawn_script[0], "data/scripts/respawn1.c")) Script_Clear(&respawn_script[0],    2);
	if(!load_script(&respawn_script[1], "data/scripts/respawn2.c")) Script_Clear(&respawn_script[1],    2);
	if(!load_script(&respawn_script[2], "data/scripts/respawn3.c")) Script_Clear(&respawn_script[2],    2);
	if(!load_script(&respawn_script[3], "data/scripts/respawn4.c")) Script_Clear(&respawn_script[3],    2);
	if(!load_script(&pdie_script[0],    "data/scripts/die1.c"))     Script_Clear(&pdie_script[0],       2);
	if(!load_script(&pdie_script[1],    "data/scripts/die2.c"))     Script_Clear(&pdie_script[1],       2);
	if(!load_script(&pdie_script[2],    "data/scripts/die3.c"))     Script_Clear(&pdie_script[2],       2);
	if(!load_script(&pdie_script[3],    "data/scripts/die4.c"))     Script_Clear(&pdie_script[3],       2);
	Script_Compile(&update_script);
	Script_Compile(&updated_script);
	Script_Compile(&level_script);
	Script_Compile(&endlevel_script);
	Script_Compile(&key_script_all);
	Script_Compile(&timetick_script);
	Script_Compile(&loading_script);
	for(i=0; i<4; i++) Script_Compile(&score_script[i]);
	for(i=0; i<4; i++) Script_Compile(&key_script[i]);
	for(i=0; i<4; i++) Script_Compile(&join_script[i]);
	for(i=0; i<4; i++) Script_Compile(&respawn_script[i]);
	for(i=0; i<4; i++) Script_Compile(&pdie_script[i]);
}

// This method is called once when the engine is shutting down, do not use it multiple times
void clear_scripts()
{
	int i;
	//Script_Clear's second parameter set to 2, because the script fails to load,
	//and will never have another chance to be loaded, so just clear the variable list in it
	Script_Clear(&update_script,    2);
	Script_Clear(&updated_script,   2);
	Script_Clear(&level_script,     2);
	Script_Clear(&endlevel_script,  2);
	Script_Clear(&key_script_all,   2);
	Script_Clear(&timetick_script,  2);
	Script_Clear(&loading_script,   2);
	for(i=0; i<4; i++)
		Script_Clear(&score_script[i],      2);
	for(i=0; i<4; i++)
		Script_Clear(&key_script[i],        2);
	for(i=0; i<4; i++)
		Script_Clear(&join_script[i],       2);
	for(i=0; i<4; i++)
		Script_Clear(&respawn_script[i],    2);
	for(i=0; i<4; i++)
		Script_Clear(&pdie_script[i],       2);
	Script_Global_Clear();
}

#define scripts_membercount (sizeof(s_scripts) / sizeof(Script*))

void alloc_all_scripts(s_scripts** s) {
	size_t i;

	if(!(*s))
	{
		*s = (s_scripts*)malloc(sizeof(s_scripts));
		for (i = 0; i < scripts_membercount; i++) {
			(((Script**) (*s))[i]) = alloc_script();
		}
	}
}

void clear_all_scripts(s_scripts* s, int method) {
	size_t i;
	Script** ps = (Script**) s;

	for (i = 0; i < scripts_membercount; i++) {
		Script_Clear(ps[i],   method);
	}
}

void free_all_scripts(s_scripts** s) {
	size_t i;
	Script** ps = (Script**) (*s);

	for (i = 0; i < scripts_membercount; i++) {
		if (ps[i]) {
			free(ps[i]);
			ps[i] = NULL;
		}
	}
	free(*s);
	*s = NULL;
}

void copy_all_scripts(s_scripts* src, s_scripts* dest, int method) {
	size_t i;
	Script** ps = (Script**) src;
	Script** pd = (Script**) dest;

	for (i = 0; i < scripts_membercount; i++) {
			Script_Copy(pd[i], ps[i], method);
	}
}

void execute_animation_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->animation_script;
	Script* s1 = ent->model->scripts->animation_script;
	Script* s2 = ent->defaultmodel->scripts->animation_script;
	if(Script_IsInitialized(s1) || Script_IsInitialized(s2))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)ent->animnum;
		Script_Set_Local_Variant(cs, "animnum", &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)ent->animpos;
		Script_Set_Local_Variant(cs, "frame",   &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)ent->animation->index;
		Script_Set_Local_Variant(cs, "animhandle",   &tempvar);
		if(Script_IsInitialized(s1)){
			Script_Copy(cs, s1, 0);
			Script_Execute(cs);
		}
		if(ent->model!=ent->defaultmodel && Script_IsInitialized(s2)){
			Script_Copy(cs, s2, 0);
			Script_Execute(cs);
		}
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",    &tempvar);
		Script_Set_Local_Variant(cs, "animnum", &tempvar);
		Script_Set_Local_Variant(cs, "frame",   &tempvar);
		Script_Set_Local_Variant(cs, "animhandle",   &tempvar);
	}
}

void execute_takedamage_script(entity* ent, entity* other, int force, int drop, int type, int noblock, int guardcost, int jugglecost, int pauseadd)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->takedamage_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)force;
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		tempvar.lVal = (LONG)drop;
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		tempvar.lVal = (LONG)type;
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		tempvar.lVal = (LONG)noblock;
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		tempvar.lVal = (LONG)guardcost;
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		tempvar.lVal = (LONG)jugglecost;
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		tempvar.lVal = (LONG)pauseadd;
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
	}
}

void execute_onpain_script(entity* ent, int iType, int iReset)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onpain_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.lVal = (LONG)iType;
		Script_Set_Local_Variant(cs, "attacktype",   &tempvar);
		tempvar.lVal = (LONG)iReset;
		Script_Set_Local_Variant(cs, "reset",       &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "type",        &tempvar);
		Script_Set_Local_Variant(cs, "reset",       &tempvar);
	}
}

void execute_onfall_script(entity* ent, entity* other, int force, int drop, int type, int noblock, int guardcost, int jugglecost, int pauseadd)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onfall_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)force;
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		tempvar.lVal = (LONG)drop;
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		tempvar.lVal = (LONG)type;
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		tempvar.lVal = (LONG)noblock;
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		tempvar.lVal = (LONG)guardcost;
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		tempvar.lVal = (LONG)jugglecost;
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		tempvar.lVal = (LONG)pauseadd;
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
	}
}

void execute_onblocks_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onblocks_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_onblockw_script(entity* ent, int plane, float height)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onblockw_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)plane;
		Script_Set_Local_Variant(cs, "plane",      &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_DECIMAL);
		tempvar.dblVal = (DOUBLE)height;
		Script_Set_Local_Variant(cs, "height",      &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "plane", &tempvar);
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "height", &tempvar);
	}
}

void execute_onblocko_script(entity* ent, entity* other)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onblocko_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "obstacle",    &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "obstacle",    &tempvar);
	}
}

void execute_onblockz_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onblockz_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_onblocka_script(entity* ent, entity* other)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onblocka_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "obstacle",    &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "obstacle",    &tempvar);
	}
}

void execute_onmovex_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onmovex_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_onmovez_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onmovez_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_onmovea_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onmovea_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);

		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_ondeath_script(entity* ent, entity* other, int force, int drop, int type, int noblock, int guardcost, int jugglecost, int pauseadd)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->ondeath_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)force;
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		tempvar.lVal = (LONG)drop;
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		tempvar.lVal = (LONG)type;
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		tempvar.lVal = (LONG)noblock;
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		tempvar.lVal = (LONG)guardcost;
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		tempvar.lVal = (LONG)jugglecost;
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		tempvar.lVal = (LONG)pauseadd;
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
	}
}

void execute_onkill_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onkill_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_didblock_script(entity* ent, entity* other, int force, int drop, int type, int noblock, int guardcost, int jugglecost, int pauseadd)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->didblock_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)force;
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		tempvar.lVal = (LONG)drop;
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		tempvar.lVal = (LONG)type;
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		tempvar.lVal = (LONG)noblock;
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		tempvar.lVal = (LONG)guardcost;
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		tempvar.lVal = (LONG)jugglecost;
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		tempvar.lVal = (LONG)pauseadd;
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "attacker",    &tempvar);
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
	}
}

void execute_ondoattack_script(entity* ent, entity* other, int force, int drop, int type, int noblock, int guardcost, int jugglecost, int pauseadd, int iWhich, int iAtkID)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->ondoattack_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "other",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)force;
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		tempvar.lVal = (LONG)drop;
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		tempvar.lVal = (LONG)type;
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		tempvar.lVal = (LONG)noblock;
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		tempvar.lVal = (LONG)guardcost;
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		tempvar.lVal = (LONG)jugglecost;
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		tempvar.lVal = (LONG)pauseadd;
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		tempvar.lVal = (LONG)iWhich;
		Script_Set_Local_Variant(cs, "which",    &tempvar);
		tempvar.lVal = (LONG)iAtkID;
		Script_Set_Local_Variant(cs, "attackid",    &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "other",		&tempvar);
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		Script_Set_Local_Variant(cs, "which",		&tempvar);
		Script_Set_Local_Variant(cs, "attackid",	&tempvar);
	}
}

void execute_updateentity_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->update_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_think_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->think_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_didhit_script(entity* ent, entity* other, int force, int drop, int type, int noblock, int guardcost, int jugglecost, int pauseadd, int blocked)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->didhit_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		tempvar.ptrVal = (VOID*)other;
		Script_Set_Local_Variant(cs, "damagetaker", &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)force;
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		tempvar.lVal = (LONG)drop;
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		tempvar.lVal = (LONG)type;
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		tempvar.lVal = (LONG)noblock;
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		tempvar.lVal = (LONG)guardcost;
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		tempvar.lVal = (LONG)jugglecost;
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		tempvar.lVal = (LONG)pauseadd;
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		tempvar.lVal = (LONG)blocked;
		Script_Set_Local_Variant(cs, "blocked",     &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",        &tempvar);
		Script_Set_Local_Variant(cs, "damagetaker", &tempvar);
		Script_Set_Local_Variant(cs, "damage",      &tempvar);
		Script_Set_Local_Variant(cs, "drop",        &tempvar);
		Script_Set_Local_Variant(cs, "attacktype",  &tempvar);
		Script_Set_Local_Variant(cs, "noblock",     &tempvar);
		Script_Set_Local_Variant(cs, "guardcost",   &tempvar);
		Script_Set_Local_Variant(cs, "jugglecost",  &tempvar);
		Script_Set_Local_Variant(cs, "pauseadd",    &tempvar);
		Script_Set_Local_Variant(cs, "blocked",     &tempvar);
	}
}

void execute_onspawn_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs = ent->scripts->onspawn_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self", &tempvar);
	}
}

void execute_entity_key_script(entity* ent)
{
	ScriptVariant tempvar;
	Script* cs ;
	if(!ent) return;
	cs = ent->scripts->key_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_PTR);
		tempvar.ptrVal = (VOID*)ent;
		Script_Set_Local_Variant(cs, "self",    &tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)ent->playerindex;
		Script_Set_Local_Variant(cs, "player",  &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "self",    &tempvar);
		Script_Set_Local_Variant(cs, "player",  &tempvar);
	}
}

void execute_spawn_script(s_spawn_entry* p, entity* e)
{
	s_spawn_script_list_node* tempnode = p->spawn_script_list_head;
	ScriptVariant tempvar;
	Script* cs;
	while(tempnode)
	{
		cs = tempnode->spawn_script;
		if(e)
		{
			ScriptVariant_Init(&tempvar);
			ScriptVariant_ChangeType(&tempvar, VT_PTR);
			tempvar.ptrVal = (VOID*)e;
			Script_Set_Local_Variant(cs, "self", &tempvar);
		}
		Script_Execute(cs);
		if(e)
		{
			ScriptVariant_Clear(&tempvar);
			Script_Set_Local_Variant(cs, "self", &tempvar);
		}
		tempnode = tempnode->next;
	}
}

void execute_level_key_script(int player)
{
	ScriptVariant tempvar;
	Script* cs = &(level->key_script);
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)player;
		Script_Set_Local_Variant(cs, "player", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "player", &tempvar);
	}
}

void execute_key_script_all(int player)
{
	ScriptVariant tempvar;
	Script* cs = &key_script_all;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)player;
		Script_Set_Local_Variant(cs, "player", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "player", &tempvar);
	}
}

void execute_timetick_script(int time, int gotime)
{
	ScriptVariant tempvar;
	Script* cs = &timetick_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)time;
		Script_Set_Local_Variant(cs, "time",    &tempvar);
		tempvar.lVal = (LONG)gotime;
		Script_Set_Local_Variant(cs, "gotime", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "time",    &tempvar);
		Script_Set_Local_Variant(cs, "gotime",  &tempvar);
	}
}

void execute_loading_script(int value, int max)
{
	ScriptVariant tempvar;
	Script* cs = &loading_script;
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&tempvar);
		ScriptVariant_ChangeType(&tempvar, VT_INTEGER);
		tempvar.lVal = (LONG)value;
		Script_Set_Local_Variant(cs, "value",    &tempvar);
		tempvar.lVal = (LONG)max;
		Script_Set_Local_Variant(cs, "max", &tempvar);
		Script_Execute(cs);
		//clear to save variant space
		ScriptVariant_Clear(&tempvar);
		Script_Set_Local_Variant(cs, "value",    &tempvar);
		Script_Set_Local_Variant(cs, "max",  &tempvar);
	}
}

void execute_key_script(int index)
{
	if(Script_IsInitialized(&key_script[index]))
	{
		Script_Execute(&key_script[index]);
	}
}

void execute_join_script(int index)
{
	if(Script_IsInitialized(&join_script[index]))
	{
		Script_Execute(&join_script[index]);
	}
}

void execute_respawn_script(int index)
{
	if(Script_IsInitialized(&respawn_script[index]))
	{
		Script_Execute(&respawn_script[index]);
	}
}

void execute_pdie_script(int index)
{
	if(Script_IsInitialized(&pdie_script[index]))
	{
		Script_Execute(&pdie_script[index]);
	}
}

// ------------------------ Save/load -----------------------------

void clearsettings()
{
	savedata.compatibleversion = COMPATIBLEVERSION;
	savedata.gamma = 0;
	savedata.brightness = 0;
	savedata.usesound = 1;
	savedata.soundrate = 44100;
	savedata.soundbits = 16;
	savedata.soundvol = 15;
	savedata.usemusic = 1;
	savedata.musicvol = 100;
	savedata.effectvol = 120;
	savedata.usejoy = 1;
	savedata.mode = 0;
	savedata.showtitles = 0;
	savedata.windowpos = 0;
	savedata.logo = 0;
	savedata.uselog = 1;
	savedata.debuginfo = 0;
	savedata.fullscreen = 0;
	savedata.stretch = 0;

#ifdef SDL
	savedata.usegl[0] = 0;
	savedata.usegl[1] = 1;
	savedata.glscale = 1.0;
	savedata.glfilter[0] = 1;
	savedata.glfilter[1] = 0;
#endif

	savedata.screen[0][0] = 0; savedata.screen[0][1] = 0;
	savedata.screen[1][0] = 0; savedata.screen[1][1] = 0;
	savedata.screen[2][0] = 0; savedata.screen[2][1] = 0;
	savedata.screen[3][0] = 0; savedata.screen[3][1] = 0;
	savedata.screen[4][0] = 0; savedata.screen[4][1] = 0;
	savedata.screen[5][0] = 0; savedata.screen[5][1] = 0;
	savedata.screen[6][0] = 0; savedata.screen[6][1] = 0;

#ifdef PSP
	savedata.screen[1][0] = 3;
	savedata.pspcpuspeed = 2;
	savedata.overscan[0] = 0;
	savedata.overscan[1] = 0;
	savedata.overscan[2] = 0;
	savedata.overscan[3] = 0;
#endif

	savedata.keys[0][SDID_MOVEUP]    = CONTROL_DEFAULT1_UP;
	savedata.keys[0][SDID_MOVEDOWN]  = CONTROL_DEFAULT1_DOWN;
	savedata.keys[0][SDID_MOVELEFT]  = CONTROL_DEFAULT1_LEFT;
	savedata.keys[0][SDID_MOVERIGHT] = CONTROL_DEFAULT1_RIGHT;
	savedata.keys[0][SDID_ATTACK]    = CONTROL_DEFAULT1_FIRE1;
	savedata.keys[0][SDID_ATTACK2]   = CONTROL_DEFAULT1_FIRE2;
	savedata.keys[0][SDID_ATTACK3]   = CONTROL_DEFAULT1_FIRE3;
	savedata.keys[0][SDID_ATTACK4]   = CONTROL_DEFAULT1_FIRE4;
	savedata.keys[0][SDID_JUMP]      = CONTROL_DEFAULT1_FIRE5;
	savedata.keys[0][SDID_SPECIAL]   = CONTROL_DEFAULT1_FIRE6;
	savedata.keys[0][SDID_START]     = CONTROL_DEFAULT1_START;
	savedata.keys[0][SDID_SCREENSHOT]= CONTROL_DEFAULT1_SCREENSHOT;

	savedata.keys[1][SDID_MOVEUP]    = CONTROL_DEFAULT2_UP;
	savedata.keys[1][SDID_MOVEDOWN]  = CONTROL_DEFAULT2_DOWN;
	savedata.keys[1][SDID_MOVELEFT]  = CONTROL_DEFAULT2_LEFT;
	savedata.keys[1][SDID_MOVERIGHT] = CONTROL_DEFAULT2_RIGHT;
	savedata.keys[1][SDID_ATTACK]    = CONTROL_DEFAULT2_FIRE1;
	savedata.keys[1][SDID_ATTACK2]   = CONTROL_DEFAULT2_FIRE2;
	savedata.keys[1][SDID_ATTACK3]   = CONTROL_DEFAULT2_FIRE3;
	savedata.keys[1][SDID_ATTACK4]   = CONTROL_DEFAULT2_FIRE4;
	savedata.keys[1][SDID_JUMP]      = CONTROL_DEFAULT2_FIRE5;
	savedata.keys[1][SDID_SPECIAL]   = CONTROL_DEFAULT2_FIRE6;
	savedata.keys[1][SDID_START]     = CONTROL_DEFAULT2_START;
	savedata.keys[1][SDID_SCREENSHOT]= CONTROL_DEFAULT2_SCREENSHOT;

	savedata.keys[2][SDID_MOVEUP]    = CONTROL_DEFAULT3_UP;
	savedata.keys[2][SDID_MOVEDOWN]  = CONTROL_DEFAULT3_DOWN;
	savedata.keys[2][SDID_MOVELEFT]  = CONTROL_DEFAULT3_LEFT;
	savedata.keys[2][SDID_MOVERIGHT] = CONTROL_DEFAULT3_RIGHT;
	savedata.keys[2][SDID_ATTACK]    = CONTROL_DEFAULT3_FIRE1;
	savedata.keys[2][SDID_ATTACK2]   = CONTROL_DEFAULT3_FIRE2;
	savedata.keys[2][SDID_ATTACK3]   = CONTROL_DEFAULT3_FIRE3;
	savedata.keys[2][SDID_ATTACK4]   = CONTROL_DEFAULT3_FIRE4;
	savedata.keys[2][SDID_JUMP]      = CONTROL_DEFAULT3_FIRE5;
	savedata.keys[2][SDID_SPECIAL]   = CONTROL_DEFAULT3_FIRE6;
	savedata.keys[2][SDID_START]     = CONTROL_DEFAULT3_START;
	savedata.keys[2][SDID_SCREENSHOT]= CONTROL_DEFAULT3_SCREENSHOT;

	savedata.keys[3][SDID_MOVEUP]    = CONTROL_DEFAULT4_UP;
	savedata.keys[3][SDID_MOVEDOWN]  = CONTROL_DEFAULT4_DOWN;
	savedata.keys[3][SDID_MOVELEFT]  = CONTROL_DEFAULT4_LEFT;
	savedata.keys[3][SDID_MOVERIGHT] = CONTROL_DEFAULT4_RIGHT;
	savedata.keys[3][SDID_ATTACK]    = CONTROL_DEFAULT4_FIRE1;
	savedata.keys[3][SDID_ATTACK2]   = CONTROL_DEFAULT4_FIRE2;
	savedata.keys[3][SDID_ATTACK3]   = CONTROL_DEFAULT4_FIRE3;
	savedata.keys[3][SDID_ATTACK4]   = CONTROL_DEFAULT4_FIRE4;
	savedata.keys[3][SDID_JUMP]      = CONTROL_DEFAULT4_FIRE5;
	savedata.keys[3][SDID_SPECIAL]   = CONTROL_DEFAULT4_FIRE6;
	savedata.keys[3][SDID_START]     = CONTROL_DEFAULT4_START;
	savedata.keys[3][SDID_SCREENSHOT]= CONTROL_DEFAULT4_SCREENSHOT;
}


void savesettings(){
#ifndef DC
	FILE *handle = NULL;
	char path[128] = {""};
	char tmpname[128] = {""};
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 4);
	strcat(path, tmpname);
	handle = fopen(path, "wb");
	if(handle==NULL) return;
    fwrite(&savedata, 1, sizeof(s_savedata), handle);
	fclose(handle);
#endif
}

void saveasdefault(){
#ifndef DC
	FILE *handle = NULL;
	char path[128] = {""};
	getBasePath(path, "Saves", 0);
	strncat(path, "default.cfg", 128);
	handle = fopen(path, "wb");
	if(handle==NULL) return;
    fwrite(&savedata, 1, sizeof(s_savedata), handle);
	fclose(handle);
#endif
}


void loadsettings(){
#ifndef DC
	FILE *handle = NULL;
	char path[128] = {""};
	char tmpname[128] = {""};
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 4);
	strcat(path, tmpname);
	if(!(fileExists(path)))
	{
		loadfromdefault();
		return;
	}
	clearsettings();
	handle = fopen(path, "rb");
	if(handle == NULL) return;
    fread(&savedata, 1, sizeof(s_savedata), handle);
	fclose(handle);
	if(savedata.compatibleversion != COMPATIBLEVERSION) clearsettings();
#else
	clearsettings();
#endif
}

void loadfromdefault(){
#ifndef DC
	FILE *handle = NULL;
	char path[128] = {""};
	getBasePath(path, "Saves", 0);
	strncat(path, "default.cfg", 128);
	clearsettings();
	handle = fopen(path, "rb");
	if(handle == NULL) return;
    fread(&savedata, 1, sizeof(s_savedata), handle);
	fclose(handle);
	if(savedata.compatibleversion != COMPATIBLEVERSION) clearsettings();
#else
	clearsettings();
#endif
}




void clearSavedGame(){
	memset(savelevel, 0, sizeof(s_savelevel)*num_difficulties);
}



void clearHighScore(){
	int i;
	savescore.compatibleversion = CV_HIGH_SCORE;
	for(i=0; i<10; i++) {
		savescore.highsc[i] = 0;    // Resets all the highscores to 0
		strcpy(savescore.hscoren[i], "None");    // Resets all the highscore names to "None"
	}
}



int saveGameFile(){
#ifndef DC
	FILE *handle = NULL;
	char path[256] = {""};
	char tmpname[256] = {""};
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 0);
	strcat(path, tmpname);
	//if(!savelevel[saveslot].level) return;
	handle = fopen(path, "wb");
	if(handle == NULL) return 0;
    fwrite(savelevel, sizeof(s_savelevel), num_difficulties, handle);
	fclose(handle);
	return 1;
#else
	return 1;
#endif
}


int loadGameFile(){
#ifndef DC
	int result = 1;
	FILE *handle = NULL;
	char path[256] = {""};
	char tmpname[256] = {""};
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 0);
	strcat(path,tmpname);
	handle = fopen(path, "rb");
	if(handle == NULL) return 0;
    if(fread(savelevel, sizeof(s_savelevel), num_difficulties, handle)>=sizeof(s_savelevel) && savelevel[0].compatibleversion!=CV_SAVED_GAME){ //TODO: check file length
		clearSavedGame();
		result = 0;
	}
	fclose(handle);
	return result;
#else
	clearSavedGame();
	return 0;
#endif
}


int saveHighScoreFile(){
#ifndef DC
	FILE *handle = NULL;
	char path[256] = {""};
	char tmpname[256] = {""};
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 1);
	strcat(path, tmpname);
	handle = fopen(path, "wb");
	if(handle == NULL) return 0;
    fwrite(&savescore, 1, sizeof(s_savescore), handle);
	fclose(handle);
	return 1;
#else
	return 1;
#endif
}


int loadHighScoreFile(){
#ifndef DC
	FILE *handle = NULL;
	char path[256] = {""};
	char tmpname[256] = {""};
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 1);
	strcat(path,tmpname);
	clearHighScore();
	handle = fopen(path, "rb");
	if(handle == NULL) return 0;
    fread(&savescore, 1, sizeof(s_savescore), handle);
	fclose(handle);
	if(savescore.compatibleversion != CV_HIGH_SCORE) {
		clearHighScore();
		return 0;
	}
	return 1;
#else
	clearHighScore();
	return 0;
#endif
}


#ifndef DC
static void vardump(ScriptVariant *var, char buffer[])
{
	char* tmpstr;
	int l, t, c;
	buffer[0] = 0;
	switch(var->vt)
	{

	case VT_STR:
		strcpy(buffer, "\"");
		tmpstr = StrCache_Get(var->strVal);
		l = strlen(tmpstr);
		for(c=0; c<l; c++){
			if(tmpstr[c]=='\n'){
				strcat(buffer, "\\n");
			}else if(tmpstr[c]=='\r'){
				strcat(buffer, "\\r");
			}else if(tmpstr[c]=='\\'){
				strcat(buffer, "\\\\");
			}else{
				t = strlen(buffer);
				buffer[t] = tmpstr[c];
				buffer[t+1] = 0;
			}					
		}
		strcat(buffer, "\"");
		break;
	case VT_DECIMAL:
		sprintf(buffer, "%lf", (double)var->dblVal);
		break;
	case VT_INTEGER:
		sprintf(buffer, "%ld", (long)var->lVal);
		break;
	default:
		strcpy(buffer, "NULL()");
		break;
	}
}

#endif


int saveScriptFile()
{
#ifndef DC
	#define _writestr(v) fwrite(v, strlen(v), 1, handle);
	#define _writetmp  _writestr(tmpvalue)
	#define _writeconst(s) strcpy(tmpvalue,s);_writetmp
	FILE *handle = NULL;
	int i, l;
	char path[256] = {""};
	char tmpvalue[256] = {""};
	//named list
	//if(max_global_vars<=0) return ;
	getBasePath(path, "Saves", 0);
	getPakName(tmpvalue, 2);//.scr
	strcat(path, tmpvalue);
	l = strlen(path); //s00, s01, s02 etc
	path[l-2] = '0'+(current_set/10);
	path[l-1] = '0'+(current_set%10);
	handle = fopen(path, "wb");
	if(handle == NULL) return 0;

	_writeconst("void main() {\n");
	for(i=0; i<=max_global_var_index; i++)
	{
		if(!global_var_list[i]->owner && 
			global_var_list[i]->key[0] &&
			global_var_list[i]->value.vt!=VT_EMPTY &&
			global_var_list[i]->value.vt!=VT_PTR){
			_writeconst("\tsetglobalvar(\"")
			_writestr(global_var_list[i]->key)
			_writeconst("\",")
			vardump(&(global_var_list[i]->value), tmpvalue);
			_writetmp
			_writeconst(");\n")
		}
	}
	// indexed list
	for(i=0; i<max_indexed_vars; i++) {
		if(indexed_var_list[i].vt != VT_PTR && indexed_var_list[i].vt!=VT_EMPTY){
			_writeconst("\tsetindexedvar(")
			sprintf(tmpvalue, "%d", i);
			_writetmp
			_writeconst(",")
			vardump(indexed_var_list+i, tmpvalue);
			_writetmp
			_writeconst(");\n")
		}
		
	}
	_writeconst("}\n");

	fclose(handle);
	return 1;
	#undef _writestr
	#undef _writetmp
	#undef _writeconst
#else
	return 1;
#endif
}


int loadScriptFile(){
#ifndef DC
	Script script;
	int result = 0;
	char* buf = NULL;
	ptrdiff_t l;
	size_t len;
	FILE *handle = NULL;

	char path[256] = {""};
	char tmpname[256] = {""};
	//named list
	//if(max_global_vars<=0) return ;
	getBasePath(path, "Saves", 0);
	getPakName(tmpname, 2);//.scr
	strcat(path,tmpname);
	l = strlen(path); //s00, s01, s02 etc
	path[l-2] = '0'+(current_set/10);
	path[l-1] = '0'+(current_set%10);

	handle = fopen(path, "rb");
	if(handle == NULL) return 0;

	fseek(handle, 0, SEEK_END);
	len = ftell(handle);
	fseek(handle, 0, SEEK_SET);
	buf = malloc(len+1);

	if(!buf) return 0;

	fread(buf, 1, len, handle);
	buf[len-1] = 0;

	Script_Init(&script, "loadScriptFile",  NULL, 1);

	result = (Script_AppendText(&script, buf, path) &&
		Script_Compile(&script) && 
		Script_Execute(&script) );
	
	Script_Clear(&script, 2);
	free(buf);
	return result;
#else
	return 0;
#endif
}

// ----------------------- Sound ------------------------------

int music(char *filename, int loop, long offset)
{
	char t[64];
	char a[64];
	int res = 1;
	if(!savedata.usemusic) return 0;
	if(!sound_open_music(filename, packfile, savedata.musicvol, loop, offset)) {
		printf("\nCan't play music file '%s'\n", filename);
		res = 0;
	}
	if(savedata.showtitles && sound_query_music(a,t))
	{
		if(a[0] && t[0]) debug_printf("Playing \"%s\" by %s", t, a);
		else if(a[0]) debug_printf("Playing unknown song by %s", a);
		else if(t[0]) debug_printf("Playing \"%s\" by unknown artist", t);
		else debug_printf("");
	}
	strncpy(currentmusic, filename, sizeof(currentmusic)-1);
	return res;
}

void check_music(){
	if(musicfade[1] > 0)
	{
		musicfade[1] -= musicfade[0];
		sound_volume_music((int)musicfade[1], (int)musicfade[1]);
	}
	else if(musicname[0])
	{
		music(musicname, musicloop, musicoffset);
		sound_volume_music(savedata.musicvol, savedata.musicvol);
		musicname[0] = 0;
	}
}

// ----------------------- General ------------------------------
// atof and atoi return a valid number, if only the first char is one.
// so we only check that.
int isNumeric(char* text) {
	char* p = text;
	assert(p);
	if(!*p) return 0;
	switch(*p) {
		case '-': case '+':
			p++;
			break;
		default:
			break;
	}
	switch (*p) {
		case '0': case '1': case '2': case '3': case '4':
		case '5': case '6': case '7': case '8': case '9':
			return 1;
		default:
			return 0;
	}
	return 1;
}


int getValidInt(char* text, char* file, char* cmd)  {
	static const char* WARN_NUMBER_EXPECTED = "WARNING: %s tries to load a nonnumeric value at %s, where a number is expected!\nerroneus string: %s\n";
	if(!text || !*text) return 0;
	if(isNumeric(text)) {
		return atoi(text);
	} else {
		printf(WARN_NUMBER_EXPECTED, file, cmd, text);
		return 0;
	}

}

float getValidFloat(char* text, char* file, char* cmd)  {
	static const char* WARN_NUMBER_EXPECTED = "WARNING: %s tries to load a nonnumeric value at %s, where a number is expected!\nerroneus string: %s\n";
	if(!text || !*text) return 0.0f;
	if(isNumeric(text)) {
		if(text[strlen(text)-1]=='%')
			return atof(text)/100.0f;
		return atof(text);
	} else {
		printf(WARN_NUMBER_EXPECTED, file, cmd, text);
		return 0.0f;
	}
}

size_t ParseArgs(ArgList* list, char* input, char* output) {
	assert(list);
	assert(input);
	assert(output);
	//static const char diff = 'a' - 'A';

	size_t pos = 0;
	size_t wordstart = 0;
	size_t item = 0;
	int done = 0;
	int space = 0;
	//int makelower = 0;

	while(pos < MAX_ARG_LEN-1 && item < MAX_ARG_COUNT) {
		switch(input[pos]) {
			case '\r': case '\n': case '#': case '\0':
				done = 1;
			case ' ': case '\t':
				output[pos] = '\0';
				if(!space && wordstart != pos) {
					list->args[item] = output + wordstart;
					list->arglen[item] = pos - wordstart;
					item++;
				}
				space = 1;
				break; /*
			case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': case 'G': case 'H': case 'I':
			case 'J': case 'K': case 'L': case 'M': case 'N': case 'O': case 'P': case 'Q': case 'R':
			case 'S': case 'T': case 'U': case 'V': case 'W': case 'X': case 'Y': case 'Z':
				makelower = 1; */

			default:
				if(space)
					wordstart = pos;
				/*output[pos] = makelower ? input[pos] + diff : input[pos];*/
				output[pos] = input[pos];
				space = 0;
				//makelower = 0;
		}
		if(done)
			break;
		pos++;
	}
	list->count = item;
	return item;
}

char *findarg(char *command, int which){
	static const char* comment_mark = "#";
	int d;
	int argc;
	int inarg;
	int argstart;
	static char arg[MAX_ARG_LEN];


	// Copy the command line, replacing spaces by zeroes,
	// finally returning a pointer to the requested arg.
	d = 0;
	inarg = 0;
	argstart = 0;
	argc = -1;

	while(d<MAX_ARG_LEN-1 && command[d]){
		// Zero out whitespace
		if(command[d]==' ' || command[d]=='\t'){
			arg[d] = 0;
			inarg = 0;
			if(argc == which) return arg + argstart;
		}
		else if(command[d]==0 || command[d]=='\n' || command[d]=='\r' ||
			strncmp(command+d, comment_mark, strlen(comment_mark))==0){
				// End of line
				arg[d] = 0;
				if(argc == which) return arg + argstart;
				return arg + d;
			}
		else{
			if(!inarg){
				// if(argc==-1 && command[d]=='#') return arg;
				inarg = 1;
				argstart = d;
				argc++;
			}
			arg[d] = command[d];
		}
		++d;
	}

	return arg;
}




float diff(float a, float b){
	if(a<b) return b-a;
	return a-b;
}



int inair(entity *e)
{
	return (diff(e->a, e->base) >= 0.1);
}



float randf(float max){
	float f;
	if(max==0) return 0;
	f = (float)(rand32()%10000);
	f /= (10000/max);
	return f;
}



// ----------------------- Loaders ------------------------------


// Creates a remapping table from two images
int load_colourmap(s_model * model, char *image1, char *image2)
{
	int i, j, k;
	unsigned char *map = NULL;
	s_bitmap *bitmap1 = NULL;
	s_bitmap *bitmap2 = NULL;

	// Can't use same image twice!
	if(stricmp(image1,image2)==0) return 0;

	__realloc(model->colourmap, model->maps_loaded);
	k = model->maps_loaded++;

	if((map = malloc(MAX_PAL_SIZE/4)) == NULL)
	{
		return -2;
	}
	if((bitmap1 = loadbitmap(image1, packfile, PIXEL_8)) == NULL)
	{
		free(map);
		map = NULL;
		return -3;
	}
	if((bitmap2 = loadbitmap(image2, packfile, PIXEL_8)) == NULL)
	{
		freebitmap(bitmap1);
		free(map);
		map = NULL;
		return -4;
	}

	// Create the colour map
	for(i=0;i<MAX_PAL_SIZE/4;i++) map[i] = i;
	for(j=0; j<bitmap1->height && j<bitmap2->height; j++)
	{
		for(i=0; i<bitmap1->width && i<bitmap2->width; i++)
		{
			map[(unsigned)(bitmap1->data[j*bitmap1->width+i])] = bitmap2->data[j*bitmap2->width+i];
		}
	}

	freebitmap(bitmap1);
	freebitmap(bitmap2);

	model->colourmap[k] = map;
	return 1;
}

//PIXEL_x8
// This function is used to enable remap command in 24bit mode
// So old mods can still run under 16/24/32bit color system
// This function should be called when all colourmaps are loaded, e.g.,
// at the end of load_cached_model
// map flag is used to determine whether a colourmap is a real colourmap
int convert_map_to_palette(s_model* model, unsigned char mapflag[])
{
	int i, c;
	unsigned char *newmap, *oldmap;
	unsigned char *p1, *p2;
	unsigned pb = pixelbytes[(int)screenformat];
	if(model->palette==NULL) return 0;
	for(c=0; c<model->maps_loaded; c++)
	{
		if(mapflag[c]==0) continue;
		if((newmap = malloc(PAL_BYTES)) == NULL)
		{
			shutdown(1, "Error convert_map_to_palette for model: %s\n", model->name);
		}
		// Create new colour map
		memcpy(newmap, model->palette, PAL_BYTES);
		oldmap = model->colourmap[c];
		for(i=0; i<MAX_PAL_SIZE/4; i++)
		{
			if(oldmap[i]==i) continue;
			p1 = newmap + i*pb;
			p2 = model->palette + oldmap[i]*pb;
			memcpy(p1, p2, pb);
		}
		model->colourmap[c] = newmap;
		free(oldmap); oldmap = NULL;
	}
	return 1;
}

static int _load_palette16(unsigned char* palette, char* filename)
{
	int handle, i;
	unsigned char tp[3];
	handle = openpackfile(filename, packfile);
	if(handle <0) return 0;
	memset(palette, 0, MAX_PAL_SIZE/2);
	for(i=0; i<MAX_PAL_SIZE/4; i++)
	{
		if(readpackfile(handle, tp, 3) != 3)
		{
			closepackfile(handle);
			return 0;
		}
		((unsigned short*)palette)[i] = colour16(tp[0], tp[1], tp[2]);
	}
	closepackfile(handle);
	*(unsigned short*)palette = 0;

	return 1;
}


static int _load_palette32(unsigned char* palette, char* filename)
{
	int handle, i;
	unsigned* dp;
	unsigned char tpal[3];
	handle = openpackfile(filename, packfile);
	if(handle <0) return 0;
	memset(palette, 0, MAX_PAL_SIZE);
	dp = (unsigned*)palette;
	for(i=0; i<MAX_PAL_SIZE/4; i++)
	{
		if(readpackfile(handle, tpal, 3) != 3)
		{
			closepackfile(handle);
			return 0;
		}
		dp[i] = colour32(tpal[0],tpal[1],tpal[2]);

	}
	closepackfile(handle);
	dp[0] = 0;

	return 1;
}

//load a 256 colors' palette
int load_palette(unsigned char* palette, char* filename)
{
	int handle;
	if(screenformat==PIXEL_32)
		return _load_palette32(palette, filename);
	else if(screenformat==PIXEL_16)
		return _load_palette16(palette, filename);

	handle = openpackfile(filename, packfile);
	if(handle <0) return 0;
	if(readpackfile(handle, palette, 768) != 768){
		closepackfile(handle);
		return 0;
	}
	closepackfile(handle);
	palette[0] = palette[1] = palette[2] = 0;

	return 1;
}

// create blending tables for the palette
int create_blending_tables(unsigned char* palette, unsigned char* tables[], int usemap[])
{
	int i;
	if(pixelformat!=PIXEL_8) return 1;
	if(!palette || !tables) return 0;

	memset(tables, 0, MAX_BLENDINGS*sizeof(unsigned char*));
	for(i=0; i<MAX_BLENDINGS; i++)
	{
		if(!usemap || usemap[i])
		{
			tables[i] = (blending_table_functions[i])(palette);
			if(!tables[i]) return 0;
		}
	}

	return 1;
}

void create_blend_tables_x8(unsigned char* tables[]){
	int i;
	for(i=0; i<MAX_BLENDINGS; i++){
		switch(screenformat){
		case PIXEL_16:
			tables[i] = blending_table_functions16[i]?(blending_table_functions16[i])():NULL;
			break;
		case PIXEL_32:
			tables[i] = blending_table_functions32[i]?(blending_table_functions32[i])():NULL;
			break;
		}
	}

}


//change system palette by index
void change_system_palette(int palindex)
{
	if(palindex < 0) palindex = 0;
	//if(current_palette == palindex ) return;


	if(!level || palindex == 0 || palindex > level->numpalettes)
	{
		current_palette = 0;
		if(screenformat==PIXEL_8)
		{
			palette_set_corrected(pal, savedata.gamma,savedata.gamma,savedata.gamma, savedata.brightness,savedata.brightness,savedata.brightness);
			set_blendtables(blendings); // set global blending tables
		}
	}
	else if(level)
	{
		current_palette = palindex;
		if(screenformat==PIXEL_8)
		{
			palette_set_corrected(level->palettes[palindex-1], savedata.gamma,savedata.gamma,savedata.gamma, savedata.brightness,savedata.brightness,savedata.brightness);
			set_blendtables(level->blendings[palindex-1]);
		}
	}
}

// Load colour 0-127 from data/pal.act
void standard_palette(int immediate){
	unsigned char* pp[MAX_PAL_SIZE] = {0};
	if(load_palette((unsigned char*)pp, "data/pal.act"))
	{
		memcpy(pal, pp, (PAL_BYTES)/2);
	}
	if(immediate)
	{
	   change_system_palette(0);
	}
}


void unload_background(){
	int i;
	if (background)	clearscreen(background);
	for(i=0; i<MAX_BLENDINGS; i++)
	{
		if(blendings[i]) free(blendings[i]);
		blendings[i] = NULL;
	}
}


int _makecolour(int r, int g, int b)
{
	switch(screenformat)
	{
	case PIXEL_8:
		return palette_find(pal, r, g, b);
	case PIXEL_16:
		 return colour16(r,g,b);
	case PIXEL_32:
		return colour32(r,g,b);
	}
	return 0;
}

// parses a color string in the format "R_G_B" or as a raw integer
int parsecolor(const char* string)
{
	int r, g, b;
	if(strchr(string, '_') != strrchr(string, '_'))
	{ // 2 underscores; color is in "R_G_B" format
		r = atoi(string);
		g = atoi(strchr(string, '_')+1);
		b = atoi(strrchr(string, '_')+1);
		return _makecolour(r,g,b);
	} else return atoi(string); // raw integer
}

// ltb 1-17-05   new function for lifebar colors
void lifebar_colors()
{
	char * filename = "data/lifebar.txt";
	char *buf;
	size_t size;
	int pos;
	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";


	char * command;

	if(buffer_pakfile(filename, &buf, &size)!=1)
	{
		color_black = 0;
		color_red = 0;
		color_orange = 0;
		color_yellow = 0;
		color_white = 0;
		color_blue = 0;
		color_green = 0;
		color_pink = 0;
		color_purple = 0;
		color_magic = 0;
		color_magic2 = 0;
		shadowcolor = 0;
		shadowalpha = BLEND_MULTIPLY+1;
		return;
	}

	pos = 0;
	colorbars=1;
	while(pos<size){
	    if(ParseArgs(&arglist,buf+pos,argbuf)){
			command = GET_ARG(0);
			if(command && command[0])
			{
				if(stricmp(command, "blackbox")==0)
					color_black = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "whitebox")==0)
					color_white = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color300")==0)
					color_orange = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color25")==0)
					color_red = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color50")==0)
					color_yellow = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color100")==0)
					color_green = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color200")==0)
					color_blue = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color400")==0)
					color_pink = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "color500")==0)
					color_purple = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				//magic bars color declarations by tails
				else if(stricmp(command, "colormagic")==0)
					color_magic = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "colormagic2")==0)
					color_magic2 = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				//end of magic bars color declarations by tails
				else if(stricmp(command, "shadowcolor")==0)
					shadowcolor = _makecolour(GET_INT_ARG(1), GET_INT_ARG(2), GET_INT_ARG(3));
				else if(stricmp(command, "shadowalpha")==0) //gfxshadow alpha
					shadowalpha = GET_INT_ARG(1);
				else
					if(command && command[0])
						printf("Warning: Unknown command in lifebar.txt: '%s'.\n", command);
			}
		}

		// Go to next line
	pos += getNewLineStart(buf + pos);
	}
	if(buf != NULL){
		free(buf);
		buf = NULL;
	}
}
// ltb 1-17-05 end new lifebar colors


void init_colourtable()
{
	mpcolourtable[0]  = color_magic2;
	mpcolourtable[1]  = color_magic;
	mpcolourtable[2]  = color_magic;
	mpcolourtable[3]  = color_magic;
	mpcolourtable[4]  = color_magic2;
	mpcolourtable[5]  = color_magic;
	mpcolourtable[6]  = color_magic2;
	mpcolourtable[7]  = color_magic;
	mpcolourtable[8]  = color_magic2;
	mpcolourtable[9]  = color_magic;
	mpcolourtable[10] = color_magic2;

	hpcolourtable[0]  = color_purple;
	hpcolourtable[1]  = color_red;
	hpcolourtable[2]  = color_yellow;
	hpcolourtable[3]  = color_green;
	hpcolourtable[4]  = color_blue;
	hpcolourtable[5]  = color_orange;
	hpcolourtable[6]  = color_pink;
	hpcolourtable[7]  = color_purple;
	hpcolourtable[8]  = color_black;
	hpcolourtable[9]  = color_white;
	hpcolourtable[10] = color_white;

	memcpy(ldcolourtable, hpcolourtable, 11*sizeof(int));
}

void load_background(char *filename, int createtables)
{
	//if(pixelformat!=PIXEL_8) createtables = 0;
	unload_background();

	if(pixelformat==PIXEL_8)
	{
		if(!loadscreen(filename, packfile, pal, PIXEL_8, &background))
		{
			shutdown(1, "Error loading background (PIXEL_8) file '%s'", filename);
		}
	}
	else if(pixelformat==PIXEL_x8)
	{
		if(!loadscreen(filename, packfile, NULL, PIXEL_x8, &background))
		{
			shutdown(1, "Error loading background (PIXEL_x8) file '%s'", filename);
		}
		memcpy(pal, background->palette, PAL_BYTES);
		memcpy(neontable, pal, PAL_BYTES);
	}
	else
	{
		shutdown(1, "Error loading background, Unknown Pixel Format!\n");
	}

	if(createtables)
	{
		standard_palette(0);
		if(!create_blending_tables(pal, blendings, blendfx))
			shutdown(1, "Failed to create colour conversion tables! (Out of memory?)");
	}

	lifebar_colors();
	if(!color_black)  color_black = _makecolour(0,0,0);           // black boxes 500-600HP
	if(!color_red)    color_red = _makecolour(255,0,0);           // 1% - 25% Full Health
	if(!color_orange) color_orange = _makecolour(255,150,0);      // 200-300HP
	if(!color_yellow) color_yellow = _makecolour(0xF8,0xB8,0x40); // 26%-50% Full health
	if(!color_white)  color_white = _makecolour(255,255,255);     // white boxes 600+ HP
	if(!color_blue)   color_blue = _makecolour(0,0,255);          // 100-200 HP
	if(!color_green)  color_green = _makecolour(0,255,0);         // 51% - 100% full health
	if(!color_pink)   color_pink = _makecolour(255,0,255);        // 300-400HP
	if(!color_purple) color_purple = _makecolour(128,48,208);     // transbox 400-500HP
	if(!color_magic)  color_magic = _makecolour(98,180,255);      // 1st magic bar color by tails
	if(!color_magic2) color_magic2 = _makecolour(24,48,143);      // 2sec magic bar color by tails
	if(!shadowcolor)  shadowcolor =  _makecolour(64,64,64);
	init_colourtable();

	video_clearscreen();
	pal[0] = pal[1] = pal[2] = 0;
	//palette_set_corrected(pal, savedata.gamma,savedata.gamma,savedata.gamma, savedata.brightness,savedata.brightness,savedata.brightness);
	change_system_palette(0);
}

void load_cached_background(char *filename, int createtables)
{
#if !WII
	load_background(filename, createtables);
#else
	int index = -1;
	unload_background();

	if(strcmp(filename, "data/bgs/logo")==0)
		index = 0;
	else if(strcmp(filename, "data/bgs/title")==0)
		index = 1;
	else if(strcmp(filename, "data/bgs/titleb")==0)
		index = 2;
	else if(strcmp(filename, "data/bgs/loading")==0)
		index = 3;
	else if(strcmp(filename, "data/bgs/loading2")==0)
		index = 4;
	else if(strcmp(filename, "data/bgs/hiscore")==0)
		index = 5;
	else if(strcmp(filename, "data/bgs/complete")==0)
		index = 6;
	else if(strcmp(filename, "data/bgs/unlockbg")==0)
		index = 7;
	else if(strcmp(filename, "data/bgs/select")==0)
		index = 8;

	if((index==-1) || (bg_cache[index]==NULL))
		shutdown(1, "Error: can't load cached background '%s'", filename);

	if(background) freescreen(&background);
	background = allocscreen(videomodes.hRes, videomodes.vRes, pixelformat);
	copyscreen(background, bg_cache[index]);

	if(pixelformat==PIXEL_8)
		memcpy(pal, bg_palette_cache[index], PAL_BYTES);
	else if(pixelformat==PIXEL_x8)
	{
		memcpy(background->palette, bg_cache[index]->palette, PAL_BYTES);
		memcpy(pal, background->palette, PAL_BYTES);
	}


	if(createtables)
	{
		standard_palette(0);
		if(!create_blending_tables(pal, blendings, blendfx))
			shutdown(1, "Failed to create colour conversion tables! (Out of memory?)");
	}

	video_clearscreen();
	pal[0] = pal[1] = pal[2] = 0;
	//palette_set_corrected(pal, savedata.gamma,savedata.gamma,savedata.gamma, savedata.brightness,savedata.brightness,savedata.brightness);
	change_system_palette(0);
	printf("use cached bg\n");
#endif
}

#if WII
void cache_background(char *filename)
{
	s_screen *bg = allocscreen(videomodes.hRes, videomodes.vRes, pixelformat);
	int index = -1;

	if(pixelformat==PIXEL_8)
	{
		if(!loadscreen(filename, packfile, pal, pixelformat, &bg))
		{
			freescreen(&bg);
			bg = NULL;
		}
	}
	else if(pixelformat==PIXEL_x8)
	{
		if(!loadscreen(filename, packfile, NULL, pixelformat, &bg))
		{
			freescreen(&bg);
			bg = NULL;
		}
	}
	else
	{
		shutdown(1, "Error caching background, Unknown Pixel Format!\n");
	}

	if(strcmp(filename, "data/bgs/logo")==0)
		index = 0;
	else if(strcmp(filename, "data/bgs/title")==0)
		index = 1;
	else if(strcmp(filename, "data/bgs/titleb")==0)
		index = 2;
	else if(strcmp(filename, "data/bgs/loading")==0)
		index = 3;
	else if(strcmp(filename, "data/bgs/loading2")==0)
		index = 4;
	else if(strcmp(filename, "data/bgs/hiscore")==0)
		index = 5;
	else if(strcmp(filename, "data/bgs/complete")==0)
		index = 6;
	else if(strcmp(filename, "data/bgs/unlockbg")==0)
		index = 7;
	else if(strcmp(filename, "data/bgs/select")==0)
		index = 8;
	else shutdown(1, "Error: unknown cached background '%s'", filename);

	bg_cache[index] = bg;

	if(pixelformat==PIXEL_8)
		memcpy(bg_palette_cache[index], pal, PAL_BYTES);

	change_system_palette(0);
}

void cache_all_backgrounds()
{
	cache_background("data/bgs/logo");
	cache_background("data/bgs/title");
	cache_background("data/bgs/titleb");
	cache_background("data/bgs/loading2");
	cache_background("data/bgs/hiscore");
	cache_background("data/bgs/complete");
	cache_background("data/bgs/unlockbg");
	cache_background("data/bgs/select");
}
#endif

void load_layer(char *filename, int index)
{
	if(!level) return;

	if(filename && level->layers[index].gfx.handle ==NULL){

		if ((level->layers[index].drawmethod.alpha>0 || level->layers[index].drawmethod.transbg) && !level->layers[index].drawmethod.water.watermode)
		{
		// assume sprites are faster than screen when transparency or alpha are specified
			level->layers[index].gfx.sprite = loadsprite2(filename, &(level->layers[index].width),&(level->layers[index].height));
		}
		else
		{
		// use screen for water effect for now, it should be faster than sprite
		// otherwise, a screen should be fine, especially in 8bit mode, it is super fast,
		//            or, at least it is not slower than a sprite
			if(loadscreen(filename, packfile, NULL, pixelformat, &level->layers[index].gfx.screen))
			{
				level->layers[index].height = level->layers[index].gfx.screen->height;
				level->layers[index].width = level->layers[index].gfx.screen->width;
			}
		}
	}

	if(filename && level->layers[index].gfx.handle ==NULL) shutdown(1, "Error loading file '%s'", filename);
	else{
		if(level->layers[index].drawmethod.xrepeat<0) {
			level->layers[index].xoffset -= level->layers[index].width*20000;
			level->layers[index].drawmethod.xrepeat = 40000;
		}
		if(level->layers[index].drawmethod.yrepeat<0) {
			level->layers[index].zoffset -= level->layers[index].height*20000;
			level->layers[index].drawmethod.yrepeat = 40000;
		}
		//printf("bglayer width=%d height=%d xoffset=%d zoffset=%d xrepeat=%d zrepeat%d\n", level->layers[index].width, level->layers[index].height, level->layers[index].xoffset, level->layers[index].zoffset, level->layers[index].xrepeat, level->layers[index].zrepeat);
	}

}


s_sprite* loadsprite2(char *filename, int* width, int* height)
{
	size_t size;
	s_bitmap *bitmap = NULL;
	s_sprite *sprite = NULL;
	int clipl, clipr, clipt, clipb;

	bitmap = loadbitmap(filename, packfile, pixelformat);
	if(!bitmap) return NULL;
	if(width) *width = bitmap->width;
	if(height) *height = bitmap->height;
	clipbitmap(bitmap, &clipl, &clipr, &clipt, &clipb);
	size = fakey_encodesprite(bitmap);
	sprite = (s_sprite*)malloc(size);
	if(!sprite){
		freebitmap(bitmap);
		return NULL;
	}
	encodesprite(-clipl, -clipt, bitmap, sprite);
	sprite->offsetx = clipl;
	sprite->offsety = clipt;
	sprite->srcwidth = bitmap->width;
	sprite->srcheight = bitmap->height;
	freebitmap(bitmap);

	return sprite;
}


// Added to conserve memory
void resourceCleanUp(){
	freesprites();
	free_models();
	free_modelcache();
	load_special_sounds();
	load_script_setting();
	load_special_sprites();
	load_levelorder();
	load_models();
}

void freesprites()
{
	unsigned short i;
	s_sprite_list *head;
	for(i=0; i<=sprites_loaded; i++)
	{
		if(sprite_list != NULL)
		{
			free(sprite_list->sprite);
			sprite_list->sprite = NULL;
			free(sprite_list->filename);
			sprite_list->filename = NULL;
			head = sprite_list->next;
			free(sprite_list);
			sprite_list = head;
		}
	}
	if(sprite_map != NULL)
	{
		free(sprite_map);
		sprite_map = NULL;
	}
	sprites_loaded = 0;
}

// allocate enough members for sprite_map
void prepare_sprite_map(size_t size)
{
	if(sprite_map == NULL || size + 1 > sprite_map_max_items )
	{
#ifdef VERBOSE
		printf("%s %p\n", "prepare_sprite_map was", sprite_map);
#endif
		sprite_map_max_items = (((size+1)>>8)+1)<<8;
		sprite_map = realloc(sprite_map, sizeof(s_sprite_map) * sprite_map_max_items);
		if(sprite_map == NULL) shutdown(1, "Out Of Memory!  Failed to create a new sprite_map\n");
	}
}

void cachesprite(int index, int load){
	if(sprite_map && index>=0 && index<sprites_loaded){
		if(!load && sprite_map[index].node->sprite){
			free(sprite_map[index].node->sprite);
			sprite_map[index].node->sprite = NULL;
			//printf("uncached sprite: %s\n", sprite_map[index].node->filename);
		}else if(load && !sprite_map[index].node->sprite){
			sprite_map[index].node->sprite = loadsprite2(sprite_map[index].node->filename, NULL, NULL);
		}
	}
}

// Returns sprite index.
// Does not return on error, as it would shut the program down.
// UT:
// bmpformat - In 24bit mode, a sprite can have a 24bit palette(e.g., panel),
//             so add this paramter to let sprite encoding function know.
//             Actually the sprite pixel encoding method is the same, but a
//             24bit palettte sprite should have a palette allocated at the end of
//             pixel data, and the information is carried by the bitmap paramter.
int loadsprite(char *filename, int ofsx, int ofsy, int bmpformat)
{
	ptrdiff_t i, size, len;
	s_bitmap *bitmap = NULL;
	int clipl, clipr, clipt, clipb;
	s_sprite_list *curr = NULL, *head = NULL, *toshare = NULL;

	for(i=0; i<sprites_loaded; i++) {
		if(sprite_map && sprite_map[i].node) {
			if(stricmp(sprite_map[i].node->filename, filename) == 0) {
				if(!sprite_map[i].node->sprite){
					sprite_map[i].node->sprite = loadsprite2(filename, NULL, NULL);
				}
				if(sprite_map[i].centerx+sprite_map[i].node->sprite->offsetx == ofsx && 
					sprite_map[i].centery+sprite_map[i].node->sprite->offsety == ofsy) {
					return i;
				} else {
					toshare = sprite_map[i].node;
				}
			}
		}
	}

	if(toshare){
		prepare_sprite_map(sprites_loaded+1);
		sprite_map[sprites_loaded].node = toshare;
		sprite_map[sprites_loaded].centerx = ofsx-toshare->sprite->offsetx;
		sprite_map[sprites_loaded].centery = ofsy-toshare->sprite->offsety;
		++sprites_loaded;
		return sprites_loaded-1;
	}

	bitmap = loadbitmap(filename, packfile, bmpformat);
	if(bitmap == NULL) shutdown(1, "Unable to load file '%s'\n", filename);

	clipbitmap(bitmap, &clipl, &clipr, &clipt, &clipb);

	len = strlen(filename);
	size = fakey_encodesprite(bitmap);
	curr = malloc(sizeof(s_sprite_list));
	curr->sprite = malloc(size);
	curr->filename = malloc(len + 1);
	if(curr == NULL || curr->sprite == NULL || curr->filename == NULL){
		freebitmap(bitmap);
		shutdown(1, "loadsprite() Out of memory!\n");
	}
	memcpy(curr->filename, filename,len);
	curr->filename[len] = 0;
	encodesprite(ofsx-clipl, ofsy-clipt, bitmap, curr->sprite);
	if(sprite_list == NULL){
		sprite_list = curr;
		sprite_list->next = NULL;
	}
	else{
		head = sprite_list;
		sprite_list = curr;
		sprite_list->next = head;
	}
	prepare_sprite_map(sprites_loaded+1);
	sprite_map[sprites_loaded].node = sprite_list;
	sprite_map[sprites_loaded].centerx = ofsx-clipl;
	sprite_map[sprites_loaded].centery = ofsy-clipt;
	sprite_list->sprite->offsetx = clipl;
	sprite_list->sprite->offsety = clipt;
	sprite_list->sprite->srcwidth = bitmap->width;
	sprite_list->sprite->srcheight = bitmap->height;
	freebitmap(bitmap);
	++sprites_loaded;
	return sprites_loaded-1;
}

void load_special_sprites()
{
	memset(shadowsprites, -1, sizeof(shadowsprites[0])*6);
	golsprite = gosprite = -1;
	if(testpackfile("data/sprites/shadow1.gif", packfile) >=0) shadowsprites[0] = loadsprite("data/sprites/shadow1",9,3,pixelformat);
	if(testpackfile("data/sprites/shadow2.gif", packfile) >=0) shadowsprites[1] = loadsprite("data/sprites/shadow2",14,5,pixelformat);
	if(testpackfile("data/sprites/shadow3.gif", packfile) >=0) shadowsprites[2] = loadsprite("data/sprites/shadow3",19,6,pixelformat);
	if(testpackfile("data/sprites/shadow4.gif", packfile) >=0) shadowsprites[3] = loadsprite("data/sprites/shadow4",24,8,pixelformat);
	if(testpackfile("data/sprites/shadow5.gif", packfile) >=0) shadowsprites[4] = loadsprite("data/sprites/shadow5",29,9,pixelformat);
	if(testpackfile("data/sprites/shadow6.gif", packfile) >=0) shadowsprites[5] = loadsprite("data/sprites/shadow6",34,11,pixelformat);
	if(testpackfile("data/sprites/arrow.gif", packfile) >=0) gosprite  = loadsprite("data/sprites/arrow",35,23,pixelformat);
	if(testpackfile("data/sprites/arrowl.gif", packfile) >=0) golsprite = loadsprite("data/sprites/arrowl",35,23,pixelformat);
	if(timeicon_path[0]) timeicon = loadsprite(timeicon_path,0,0,pixelformat);
	if(bgicon_path[0]) bgicon = loadsprite(bgicon_path,0,0,pixelformat);
	if(olicon_path[0]) olicon = loadsprite(olicon_path,0,0,pixelformat);
}

void unload_all_fonts()
{
	int i;
	for(i=0; i<MAX_FONTS; i++)
	{
		font_unload(i);
	}
}

void load_all_fonts()
{
	char path[256];
	int i;

	for(i=0; i<MAX_FONTS; i++){
		if(i==0) strcpy(path, "data/sprites/font");
		else sprintf(path, "%s%d", "data/sprites/font", i+1);
		if(font_load(i, path, packfile, fontmonospace[i]|fontmbs[i]))
			printf("%d ", i+1);
	}
}

void load_menu_txt()
{
	char * filename = "data/menu.txt";
	int pos, i;
	char *buf, *command;
	size_t size;
	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";

	// Read file
	if(buffer_pakfile(filename, &buf, &size)!=1)
	{
		return;
	}

	// Now interpret the contents of buf line by line
	pos = 0;
	while(pos<size){
		if(ParseArgs(&arglist,buf+pos,argbuf)){
			command = GET_ARG(0);
			if(command && command[0]){
				if(stricmp(command, "disablekey")==0){
					// here to keep from crashing
				}
				else if(stricmp(command, "renamekey")==0){
					// here to keep from crashing
				}
				else if(stricmp(command, "fontmonospace")==0)
				{
					for(i=0; i<MAX_FONTS; i++)
						fontmonospace[i] = GET_INT_ARG((i+1))?FONT_MONO:0;
				}
				else if(stricmp(command, "fontmbs")==0)
				{
					for(i=0; i<MAX_FONTS; i++)
						fontmbs[i] = GET_INT_ARG((i+1))?FONT_MBS:0;
				}
				else
					if(command && command[0])
						printf("Command '%s' not understood in file '%s'!", command, filename);
			}
		}

		// Go to next line
		pos += getNewLineStart(buf + pos);
	}

	if(buf != NULL){
		free(buf);
		buf = NULL;
	}
}

int load_special_sounds()
{
	sound_unload_all_samples();
	SAMPLE_GO		= sound_load_sample("data/sounds/go.wav",		packfile,	0);
	SAMPLE_BEAT		= sound_load_sample("data/sounds/beat1.wav",	packfile,	0);
	SAMPLE_BLOCK	= sound_load_sample("data/sounds/block.wav",	packfile,	0);
	SAMPLE_FALL		= sound_load_sample("data/sounds/fall.wav",		packfile,	0);
	SAMPLE_GET		= sound_load_sample("data/sounds/get.wav",		packfile,	0);
	SAMPLE_GET2		= sound_load_sample("data/sounds/money.wav",	packfile,	0);
	SAMPLE_JUMP		= sound_load_sample("data/sounds/jump.wav",		packfile,	0);
	SAMPLE_INDIRECT	= sound_load_sample("data/sounds/indirect.wav",	packfile,	0);
	SAMPLE_PUNCH	= sound_load_sample("data/sounds/punch.wav",	packfile,	0);
	SAMPLE_1UP		= sound_load_sample("data/sounds/1up.wav",		packfile,	0);
	SAMPLE_TIMEOVER = sound_load_sample("data/sounds/timeover.wav", packfile,	0);
	SAMPLE_BEEP		= sound_load_sample("data/sounds/beep.wav",		packfile,	0);
	SAMPLE_BEEP2	= sound_load_sample("data/sounds/beep2.wav",	packfile,	0);
	SAMPLE_BIKE		= sound_load_sample("data/sounds/bike.wav",		packfile,	0);
	if(SAMPLE_GO < 0 || SAMPLE_BEAT < 0 || SAMPLE_BLOCK < 0 ||
	   SAMPLE_FALL < 0 || SAMPLE_GET < 0 || SAMPLE_GET2 < 0 ||
	   SAMPLE_JUMP < 0 || SAMPLE_INDIRECT < 0 || SAMPLE_PUNCH < 0 ||
	   SAMPLE_1UP < 0 || SAMPLE_TIMEOVER < 0 || SAMPLE_BEEP < 0 ||
	   SAMPLE_BEEP2 < 0 || SAMPLE_BIKE < 0) return 0;
	return 1;
}

// Use by player select menus
s_model* nextplayermodel(s_model *current){
	int i;
	int curindex = -1;
	int loops;
	if(current){
		// Find index of current player model
		for(i=0; i<models_cached; i++){
			if(model_cache[i].model == current){
				curindex = i;
				break;
			}
		}
	}
	// Find next player model (first one after current index)
	for(i=curindex+1, loops=0; loops<models_cached; i++, loops++){
		if(i >= models_cached) i = 0;
		if(model_cache[i].model && model_cache[i].model->type==TYPE_PLAYER &&
		  (allow_secret_chars || !model_cache[i].model->secret) &&
			model_cache[i].model->clearcount<=bonus && model_cache[i].selectable){
			//printf("next %s\n", model_cache[i].model->name);
			return model_cache[i].model;
		}
	}
	shutdown(1, "Fatal: can't find any player models!");
	return NULL;
}

// Use by player select menus
s_model* prevplayermodel(s_model *current){
	int i;
	int curindex = -1;
	int loops;
	if(current){
		// Find index of current player model
		for(i=0; i<models_cached; i++){
			if(model_cache[i].model == current){
				curindex = i;
				break;
			}
		}
	}
	// Find next player model (first one after current index)
	for(i=curindex-1, loops=0; loops<models_cached; i--, loops++){
		if(i < 0) i = models_cached-1;
		if(model_cache[i].model && model_cache[i].model->type==TYPE_PLAYER &&
		  (allow_secret_chars || !model_cache[i].model->secret) &&
			model_cache[i].model->clearcount<=bonus && model_cache[i].selectable){
			//printf("prev %s\n", model_cache[i].model->name);
			return model_cache[i].model;
		}
	}
	shutdown(1, "Fatal: can't find any player models!");
	return NULL;
}

// Reset All Player Models to on/off for Select Screen.
static void reset_playable_list(char which)
{
	int i;
	for(i=0;i<models_cached;i++)
	{
		if(!which || (model_cache[i].model && model_cache[i].model->type == TYPE_PLAYER))
		{
			model_cache[i].selectable = which;
		}
	}
}

// Specify which Player Models are allowable for selecting
static void load_playable_list(char* buf)
{
	int i, index;
	char* value;
	s_model *playermodels = NULL;
	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";

	reset_playable_list(0);
	ParseArgs(&arglist,buf,argbuf);

	for(i=1;(value=GET_ARG(i))[0];i++)
	{
		playermodels = findmodel(value);
		//if(playermodels == NULL) shutdown(1, "Player model '%s' is not loaded.\n", value);
		index = get_cached_model_index(playermodels->name);
		if(index == -1) shutdown(1, "Player model '%s' is not cached.\n", value);
		model_cache[index].selectable = 1;
	}
}

void alloc_specials(s_model* newchar){
	newchar->special = realloc(newchar->special, sizeof(s_com)*(newchar->specials_loaded+1));
	memset(newchar->special+newchar->specials_loaded, 0, sizeof(s_com));
}

void alloc_frames(s_anim * anim, int fcount)
{
	anim->sprite = malloc(fcount * sizeof(anim->sprite));
	anim->delay = malloc(fcount * sizeof(anim->delay));
	anim->vulnerable = malloc(fcount * sizeof(anim->vulnerable));
	memset(anim->sprite, 0, fcount*sizeof(anim->sprite));
	memset(anim->delay, 0, fcount*sizeof(anim->delay));
	memset(anim->vulnerable, 0, fcount*sizeof(anim->vulnerable));
}

void free_frames(s_anim * anim)
{
	int i;
	if(anim->idle)			{free(anim->idle);			anim->idle = NULL;}
	if(anim->seta)          {free(anim->seta);          anim->seta = NULL;}
	if(anim->move)          {free(anim->move);          anim->move = NULL;}
	if(anim->movez)         {free(anim->movez);         anim->movez = NULL;}
	if(anim->movea)         {free(anim->movea);         anim->movea = NULL;}
	if(anim->delay)         {free(anim->delay);         anim->delay = NULL;}
	if(anim->sprite)        {free(anim->sprite);        anim->sprite = NULL;}
	if(anim->platform)      {free(anim->platform);      anim->platform = NULL;}
	if(anim->vulnerable)    {free(anim->vulnerable);    anim->vulnerable = NULL;}
	if(anim->bbox_coords)   {free(anim->bbox_coords);   anim->bbox_coords = NULL;}
	if(anim->shadow)        {free(anim->shadow);        anim->shadow = NULL;}
	if(anim->shadow_coords) {free(anim->shadow_coords); anim->shadow_coords = NULL;}
	if(anim->soundtoplay)   {free(anim->soundtoplay);   anim->soundtoplay = NULL;}
	if(anim->attacks)
	{
		for(i=0; i<anim->numframes; i++)
		{
			if(anim->attacks[i])
			{
				free(anim->attacks[i]);
				anim->attacks[i] = NULL;
			}
		}
		free(anim->attacks);
		anim->attacks = NULL;
	}
	if(anim->drawmethods)
	{
		for(i=0; i<anim->numframes; i++)
		{
			if(anim->drawmethods[i])
			{
				free(anim->drawmethods[i]);
				anim->drawmethods[i] = NULL;
			}
		}
		free(anim->drawmethods);
		anim->drawmethods = NULL;
	}
}

#if 0
s_anim_list *anim_list_delete(s_anim_list *list, int index)
{
	if(list == NULL) return NULL;
	if(list->anim->model_index == index)
	{
		s_anim_list *next;
		next = list->next;
		free_anim(list->anim);
		free(list);
		--anims_loaded;
		return next;
	}
	list->next = anim_list_delete(list->next, index);
	return list;
}
#endif

void anim_list_delete(int index)
{
	s_anim_list head;
	head.next = anim_list;
	s_anim_list* list = &head;
	while(list && list->next)
	{
		if(list->next->anim->model_index == index)
		{
			s_anim_list *next = list->next->next;
			free_anim(list->next->anim);
			if(list->next==anim_list)
				anim_list = next;
			free(list->next);
			--anims_loaded;
			list->next = next;
		}else list = list->next;
	}
}

void free_anim(s_anim * anim)
{
	if(!anim) return;
	free_frames(anim);
	if(anim->weaponframe)
	{
		free(anim->weaponframe);
		anim->weaponframe = NULL;
	}
	if(anim->spawnframe)
	{
		free(anim->spawnframe);
		anim->spawnframe = NULL;
	}
	if(anim->summonframe)
	{
		free(anim->summonframe);
		anim->summonframe = NULL;
	}
	free(anim);
}

int hasFreetype(s_model* m, ModelFreetype t) {
	assert(m);
	return (m->freetypes & t) == t;
}

void addFreeType(s_model* m, ModelFreetype t) {
	assert(m);
	m->freetypes |= t;
}

void cache_model_sprites(s_model* m, int ld){
	int i, f;
	s_anim* anim;
	cachesprite(m->icon.def, ld);
	cachesprite(m->icon.die, ld);
	cachesprite(m->icon.get, ld);
	cachesprite(m->icon.mphigh, ld);
	cachesprite(m->icon.mplow, ld);
	cachesprite(m->icon.mpmed, ld);
	cachesprite(m->icon.pain, ld);
	cachesprite(m->icon.weapon, ld);
	for(i=0; i<MAX_PLAYERS; i++)
		cachesprite(m->parrow[i][0], ld);

	//if(hasFreetype(model, MF_ANIMLIST)){
	for(i=0; i<max_animations; i++){
		anim = m->animation[i];
		if(anim){
			for(f=0;f<anim->numframes;f++){
				cachesprite(anim->sprite[f], ld);
			}
		}
	}
}

// Unload single model from memory
int free_model(s_model* model)
{
	int i;
	if(!model) return 0;
	printf("Unload '%s' ", model->name);

	if(hasFreetype(model, MF_ANIMLIST))
		anim_list_delete(model->index);

	printf(".");

	if(hasFreetype(model, MF_COLOURMAP))
	{
		for(i=0; i<model->maps_loaded; i++)
		{
			if(model->colourmap[i] != NULL)
			{
				free(model->colourmap[i]);
				model->colourmap[i] = NULL;
			}
		}
		if(model->colourmap) free(model->colourmap);
		model->colourmap = NULL;
		model->maps_loaded = 0;
	}

	printf(".");

	if(hasFreetype(model, MF_PALETTE) && model->palette)
		{free(model->palette); model->palette = NULL;}
	printf(".");
	if(hasFreetype(model, MF_WEAPONS) && model->weapon && model->ownweapons)
		{free(model->weapon); model->weapon = NULL;}
	printf(".");
	if(hasFreetype(model, MF_BRANCH) && model->branch)
		{free(model->branch); model->branch = NULL;}
	printf(".");
	if(hasFreetype(model, MF_ANIMATION) && model->animation)
		{free(model->animation); model->animation = NULL;}
	printf(".");
	if(hasFreetype(model, MF_DEFENSE) && model->defense)
		{free(model->defense); model->defense = NULL;}
	printf(".");
	if(hasFreetype(model, MF_OFF_FACTORS) && model->offense_factors)
		{free(model->offense_factors); model->offense_factors = NULL;}
	printf(".");
	if(hasFreetype(model, MF_SPECIAL) && model->special)
		{free(model->special); model->special = NULL;}
	printf(".");
	if(hasFreetype(model, MF_SMARTBOMB) && model->smartbomb)
		{free(model->smartbomb); model->smartbomb = NULL;}
	printf(".");

	if(hasFreetype(model, MF_SCRIPTS)) {
		clear_all_scripts(model->scripts,2);
		free_all_scripts(&model->scripts);
	}
	printf(".");

	model_cache[model->index].model = NULL;
	deleteModel(model->name);
	printf(".");

	printf("done.\n");

	return models_loaded--;
}

// Unload all models and animations memory
void free_models()
{
	s_model* temp;

	while((temp = getFirstModel()))
		free_model(temp);

	// free animation ids
	if(animdowns)       {free(animdowns);       animdowns          = NULL;}
	if(animups)         {free(animups);         animups            = NULL;}
	if(animbackwalks)   {free(animbackwalks);   animbackwalks      = NULL;}
	if(animwalks)       {free(animwalks);       animwalks          = NULL;}
	if(animidles)       {free(animidles);       animidles          = NULL;}
	if(animspecials)    {free(animspecials);    animspecials       = NULL;}
	if(animattacks)     {free(animattacks);     animattacks        = NULL;}
	if(animfollows)     {free(animfollows);     animfollows        = NULL;}
	if(animpains)       {free(animpains);       animpains          = NULL;}
	if(animfalls)       {free(animfalls);       animfalls          = NULL;}
	if(animrises)       {free(animrises);       animrises          = NULL;}
	if(animriseattacks) {free(animriseattacks); animriseattacks    = NULL;}
	if(animblkpains)    {free(animblkpains);    animblkpains       = NULL;}
	if(animdies)        {free(animdies);        animdies           = NULL;}
}


s_anim * alloc_anim()
{
	static int animindex = 0;
	s_anim_list *curr = NULL, *head = NULL;
	curr = malloc(sizeof(s_anim_list));
	curr->anim = malloc(sizeof(s_anim));
	if(curr == NULL || curr->anim == NULL) return NULL;
	memset(curr->anim, 0, sizeof(s_anim));
	curr->anim->index = animindex++;
	if(anim_list == NULL){
		anim_list = curr;
		anim_list->next = NULL;
	}
	else{
		head = anim_list;
		anim_list = curr;
		anim_list->next = head;
	}
	++anims_loaded;
	return anim_list->anim;
}


int addframe(s_anim * a, int spriteindex, int framecount, short delay, unsigned char idle,
			 short *bbox, s_attack* attack, short move, short movez, short movea, 
			 short seta, float* platform, int frameshadow, short* shadow_coords, int soundtoplay, s_drawmethod* drawmethod)
{
	ptrdiff_t currentframe;
	if(framecount>0) alloc_frames(a, framecount);
	else framecount = -framecount; // for alloc method, use a negative value

	currentframe = a->numframes;
	++a->numframes;

	a->sprite[currentframe] = spriteindex;
	a->delay[currentframe] = delay * GAME_SPEED / 100;

	if((bbox[2]-bbox[0]) && (bbox[3]-bbox[1]))
	{
		if(!a->bbox_coords)
		{
			a->bbox_coords = malloc(framecount * sizeof(*a->bbox_coords));
			memset(a->bbox_coords, 0, framecount * sizeof(*a->bbox_coords));
		}
		memcpy(a->bbox_coords[currentframe], bbox, sizeof(*a->bbox_coords));
		a->vulnerable[currentframe] = 1;
	}
	if((attack->attack_coords[2]-attack->attack_coords[0]) &&
		(attack->attack_coords[3]-attack->attack_coords[1]))
	{
		if(!a->attacks)
		{
			a->attacks = malloc(framecount * sizeof(s_attack*));
			memset(a->attacks, 0, framecount * sizeof(s_attack*));
		}
		a->attacks[currentframe] = malloc(sizeof(s_attack));
		memcpy(a->attacks[currentframe], attack, sizeof(s_attack));
	}
	if(drawmethod->flag)
	{
		if(!a->drawmethods)
		{
			a->drawmethods = malloc(framecount * sizeof(s_drawmethod*));
			memset(a->drawmethods, 0, framecount * sizeof(s_drawmethod*));
		}
		setDrawMethod(a, currentframe, malloc(sizeof(s_drawmethod)));
		//a->drawmethods[currenframe] = malloc(sizeof(s_drawmethod));
		memcpy(getDrawMethod(a,currentframe), drawmethod, sizeof(s_drawmethod));
		//memcpy(a->drawmethods[currentframe], drawmethod, sizeof(s_drawmethod));
	}
	if(idle && !a->idle)
	{
		a->idle = malloc(framecount*sizeof(*a->idle));
		memset(a->idle, 0, framecount*sizeof(*a->idle));
	}
	if(a->idle) a->idle[currentframe] = idle;
	if(move && !a->move)
	{
		a->move = malloc(framecount * sizeof(*a->move));
		memset(a->move, 0, framecount * sizeof(*a->move));
	}
	if(a->move) a->move[currentframe] = move;
	if(movez && !a->movez)
	{
		a->movez = malloc(framecount * sizeof(*a->movez));
		memset(a->movez, 0, framecount * sizeof(*a->movez));
	}
	if(a->movez) a->movez[currentframe] = movez;						           // Move command for the "z" axis
	if(movea && !a->movea)
	{
		a->movea = malloc(framecount * sizeof(*a->movea));
		memset(a->movea, 0, framecount * sizeof(*a->movea));
	}
	if(a->movea) a->movea[currentframe] = movea;						           // Move command for moving along the "a" axis
	if(seta>=0 && !a->seta)
	{
		a->seta = malloc(framecount * sizeof(*a->seta));
		memset(a->seta, -1, framecount * sizeof(*a->seta)); //default to -1
	}
	if(a->seta) a->seta[currentframe] = seta;						               // Sets the "a" for the character on a frame/frame basis
	if(frameshadow >= 0 && !a->shadow)
	{
		a->shadow = malloc(framecount * sizeof(*a->shadow));
		memset(a->shadow, -1, framecount * sizeof(*a->shadow)); //default to -1
	}
	if(a->shadow) a->shadow[currentframe] = frameshadow;                          // shadow index for each frame
	if(shadow_coords[0] || shadow_coords[1])
	{
		if(!a->shadow_coords)
		{
			a->shadow_coords=malloc(framecount * sizeof(*a->shadow_coords));
			memset(a->shadow_coords, 0, framecount * sizeof(*a->shadow_coords));
		}
		memcpy(a->shadow_coords[currentframe], shadow_coords, sizeof(*a->shadow_coords));
	}
	if(platform[7]) //height
	{
		if(!a->platform)
		{
			a->platform = malloc(framecount * sizeof(*a->platform));
			memset(a->platform, 0, framecount * sizeof(*a->platform));
		}
		memcpy(a->platform[currentframe], platform, sizeof(*a->platform));// Used so entity can be landed on
	}
	if(soundtoplay >= 0)
	{
		if(!a->soundtoplay)
		{
			a->soundtoplay = malloc(framecount * sizeof(*a->soundtoplay));
			memset(a->soundtoplay, -1, framecount * sizeof(*a->soundtoplay)); // default to -1
		}
		a->soundtoplay[currentframe] = soundtoplay;
	}

	return a->numframes;
}


// ok this func only seems to overwrite the name which was assigned from models.txt with the one
// in the models own text file.
// it does so in the cache.
void _peek_model_name(int index)
{
	size_t size = 0;
	ptrdiff_t pos = 0, len;
	char *buf = NULL;
	char *command, *value;
	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";
	modelCommands cmd;

	if(buffer_pakfile(model_cache[index].path, &buf, &size)!=1) return;

	while(pos<size)
	{
		ParseArgs(&arglist,buf+pos,argbuf);
		command = GET_ARG(0);

		if(command && command[0]){
			cmd = getModelCommand(modelcmdlist, command);
			if(cmd == CMD_MODEL_NAME)
			{
				value = GET_ARG(1);
				free(model_cache[index].name);
				model_cache[index].name = NULL;
				len = strlen(value);
				model_cache[index].name = malloc(len + 1);
				strcpy(model_cache[index].name, value);
				model_cache[index].name[len] = 0;
				break;
			}
		}
		pos += getNewLineStart(buf + pos);
	}

	if(buf != NULL)
	{
		free(buf);
		buf = NULL;
	}
}

void prepare_cache_map(size_t size)
{
	if(model_cache== NULL || size + 1 > cache_map_max_items )
	{
#ifdef VERBOSE
		printf("%s %p\n", "prepare_cache_map was", model_cache);
#endif
		do {
			cache_map_max_items += 128;
		}
		while (size + 1 > cache_map_max_items);

		model_cache = realloc(model_cache, sizeof(s_modelcache) * cache_map_max_items);
		if(model_cache == NULL) shutdown(1, "Out Of Memory!  Failed to create a new cache_map\n");
	}
}

void cache_model(char *name, char *path, int flag)
{
	int len;
	printf("Cacheing '%s' from %s\n", name, path);
	prepare_cache_map(models_cached+1);
	memset(&model_cache[models_cached], 0, sizeof(s_modelcache));

	len = strlen(name);
	model_cache[models_cached].name = malloc(len + 1);
	strcpy(model_cache[models_cached].name, name);
	model_cache[models_cached].name[len] = 0;

	len = strlen(path);
	model_cache[models_cached].path = malloc(len + 1);
	strcpy(model_cache[models_cached].path, path);
	model_cache[models_cached].path[len] = 0;

	model_cache[models_cached].loadflag = flag;

	_peek_model_name(models_cached);
	++models_cached;
}


void free_modelcache()
{
	if(model_cache != NULL)
	{
		while(models_cached)
		{
			--models_cached;
			free(model_cache[models_cached].name);
			model_cache[models_cached].name = NULL;
			free(model_cache[models_cached].path);
			model_cache[models_cached].path = NULL;
		}
		free(model_cache);
		model_cache = NULL;
	}
}


int get_cached_model_index(char * name)
{
	int i;
	for(i=0; i<models_cached; i++)
	{
		if(stricmp(name, model_cache[i].name)==0) return i;
	}
	return -1;
}

char *get_cached_model_path(char * name)
{
	int i;
	for(i=0; i<models_cached; i++)
	{
		if(stricmp(name, model_cache[i].name)==0) return model_cache[i].path;
	}
	return NULL;
}

static void _readbarstatus(char*, s_barstatus*);

void lcmHandleCommandName(ArgList* arglist, s_model* newchar, int cacheindex) {
	char* value = GET_ARGP(1);
	s_model* tempmodel;
	if((tempmodel=findmodel(value)) && tempmodel!=newchar) shutdown(1, "Duplicate model name '%s'", value);
	/*if((tempmodel=find_model(value))) {
		return tempmodel;
	}*/
	model_cache[cacheindex].model = newchar;
	newchar->name = model_cache[cacheindex].name;
	if(stricmp(newchar->name, "steam")==0)
	{
		newchar->alpha = 1;
	}
}

void lcmHandleCommandType(ArgList* arglist, s_model* newchar, char* filename) {
	char* value = GET_ARGP(1);
	int i;
	if(stricmp(value, "none")==0){
		newchar->type = TYPE_NONE;
	}
	else if(stricmp(value, "player")==0){
		newchar->type = TYPE_PLAYER;
		newchar->nopassiveblock = 1;
		for(i=0; i<MAX_ATCHAIN; i++)
		{
			if(i < 2 || i > 3) newchar->atchain[i] = 1;
			else newchar->atchain[i] = i;
		}
		newchar->chainlength            = 4;
		newchar->bounce                 = 1;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_obstacle    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_screen      = 1;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->no_adjust_base         = 0;
	}
	else if(stricmp(value, "enemy")==0){
		newchar->type                   = TYPE_ENEMY;
		newchar->bounce                 = 1;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_obstacle    = 1;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->no_adjust_base         = 0;
	}
	else if(stricmp(value, "item")==0){
		newchar->type                   = TYPE_ITEM;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_obstacle    = 1;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->no_adjust_base         = 0;
	}
	else if(stricmp(value, "obstacle")==0){
		newchar->type                   = TYPE_OBSTACLE;
		if(newchar->aimove==-1) newchar->aimove = 0;
		newchar->aimove |= AIMOVE1_NOMOVE;
		if(newchar->aimove==-1) newchar->aiattack = 0;
		newchar->aimove |= AIATTACK1_NOATTACK;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->no_adjust_base         = 0;
	}
	else if(stricmp(value, "steamer")==0){
		newchar->type = TYPE_STEAMER;
	}
	// my new types   7-1-2005
	else if(stricmp(value, "pshot")==0){
		newchar->type = TYPE_SHOT;
		if(newchar->aimove==-1) newchar->aimove = 0;
		newchar->aimove |= AIMOVE1_ARROW;
		if(!newchar->offscreenkill) newchar->offscreenkill = 200;
		newchar->subject_to_hole                = 0;
		newchar->subject_to_gravity             = 1;
		newchar->subject_to_wall                = 0;
		newchar->subject_to_platform            = 0;
		newchar->subject_to_screen              = 0;
		newchar->subject_to_minz                = 1;
		newchar->subject_to_maxz                = 1;
		newchar->subject_to_platform            = 0;
		newchar->no_adjust_base                 = 1;
	}
	else if(stricmp(value, "trap")==0){
		newchar->type                   = TYPE_TRAP;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->no_adjust_base         = 0;
	}
	else if(stricmp(value, "text")==0){    // Used for displaying text/images and freezing the screen
		newchar->type                   = TYPE_TEXTBOX;
		newchar->subject_to_gravity     = 0;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
	}
	else if(stricmp(value, "endlevel")==0){    // Used for ending the level when the players reach a certain point
		newchar->type                   = TYPE_ENDLEVEL;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_obstacle    = 1;
		newchar->subject_to_gravity     = 1;
	}
	else if(stricmp(value, "npc")==0){    // NPC type
		newchar->type                   = TYPE_NPC;
		newchar->bounce                 = 1;
		newchar->subject_to_wall        = 1;
		newchar->subject_to_platform    = 1;
		newchar->subject_to_hole        = 1;
		newchar->subject_to_obstacle    = 1;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->no_adjust_base         = 0;
	}
	else if(stricmp(value, "panel")==0){    // NPC type
		newchar->type                   = TYPE_PANEL;
		newchar->antigravity            = 1.0; //float type
		newchar->subject_to_gravity     = 1;
		newchar->no_adjust_base         = 1;
	}
	else shutdown(1, "Model '%s' has invalid type: '%s'", filename, value);
}

void lcmHandleCommandSubtype(ArgList* arglist, s_model* newchar, char* filename) {
	char* value = GET_ARGP(1);
	int i;
	if(stricmp(value, "biker")==0){
		newchar->subtype                                        = SUBTYPE_BIKER;
		if(newchar->aimove==-1) newchar->aimove                 = 0;
		newchar->aimove |= AIMOVE1_BIKER;
		if(!newchar->offscreenkill) newchar->offscreenkill = 300;
		for(i=0; i<max_attack_types; i++)
			newchar->defense[i].factor = 2.f;
		newchar->subject_to_hole                                = 1;
		newchar->subject_to_gravity                             = 1;
		newchar->subject_to_wall                                = 0;
		newchar->subject_to_platform                            = 0;
		newchar->subject_to_screen                              = 0;
		newchar->subject_to_minz                                = 1;
		newchar->subject_to_maxz                                = 1;
		newchar->subject_to_platform                            = 0;
		newchar->no_adjust_base                                 = 0;
	}
	else if(stricmp(value, "arrow")==0){  // 7-1-2005 Arrow type
		newchar->subtype = SUBTYPE_ARROW;   // 7-1-2005 Arrow type
		if(newchar->aimove==-1) newchar->aimove = 0;
		newchar->aimove |= AIMOVE1_ARROW;
		if(!newchar->offscreenkill) newchar->offscreenkill = 200;
		newchar->subject_to_hole        = 0;
		newchar->subject_to_gravity     = 1;
		newchar->subject_to_wall        = 0;
		newchar->subject_to_platform    = 0;
		newchar->subject_to_screen      = 0;
		newchar->subject_to_minz        = 1;
		newchar->subject_to_maxz        = 1;
		newchar->subject_to_platform    = 0;
		newchar->no_adjust_base         = 1;
	}
	else if(stricmp(value, "notgrab")==0){  // 7-1-2005 notgrab type
		newchar->subtype = SUBTYPE_NOTGRAB;   // 7-1-2005 notgrab type
	}
	//    ltb 1-18-05  Item Subtype
	else if(stricmp(value, "touch")==0){  // 7-1-2005 notgrab type
		newchar->subtype = SUBTYPE_TOUCH;   // 7-1-2005 notgrab type
	}
	else if(stricmp(value, "weapon")==0){  // 7-1-2005 notgrab type
		newchar->subtype = SUBTYPE_WEAPON;   // 7-1-2005 notgrab type
	}
	else if(stricmp(value, "noskip")==0){    // Text animation cannot be skipped if subtype noskip
		newchar->subtype = SUBTYPE_NOSKIP;
	}
	else if(stricmp(value, "flydie")==0){    // Obstacle will fly across the screen when hit if subtype flydie
		newchar->subtype = SUBTYPE_FLYDIE;
	}
	else if(stricmp(value, "both")==0){
		newchar->subtype = SUBTYPE_BOTH;
	}
	else if(stricmp(value, "project")==0){
		newchar->subtype = SUBTYPE_PROJECTILE;
	}
	else if(stricmp(value, "follow")==0){
		newchar->subtype = SUBTYPE_FOLLOW;
	}
	else if(stricmp(value, "chase")==0){
		newchar->subtype = SUBTYPE_CHASE;
	}
	//    end new subtype
	else shutdown(1, "Model '%s' has invalid subtype: '%s'", filename, value);
}

void lcmHandleCommandSmartbomb(ArgList* arglist, s_model* newchar, char* filename) {
	//smartbomb now use a normal attack box
	if(!newchar->smartbomb) {
		newchar->smartbomb = malloc(sizeof(s_attack));
		*(newchar->smartbomb) = emptyattack;
	} else shutdown(1, "Model '%s' has multiple smartbomb commands defined.", filename);

	newchar->smartbomb->attack_force = atoi(GET_ARGP(1));			// Special force
	newchar->smartbomb->attack_type = atoi(GET_ARGP(2));			// Special attack type
	newchar->smartbomb->attack_drop = 1; //by default
	newchar->smartbomb->dropv[0] = default_model_dropv[0];

	if(newchar->smartbomb->attack_type==ATK_BLAST) {
		newchar->smartbomb->blast = 1;
		newchar->smartbomb->dropv[1] = default_model_dropv[1]*2.083f;
	} else {
		newchar->smartbomb->dropv[1] = default_model_dropv[1];
	}

	if(newchar->smartbomb->attack_type==ATK_FREEZE) {
		newchar->smartbomb->freeze = 1;
		newchar->smartbomb->forcemap = -1;
		newchar->smartbomb->attack_drop = 0;
	} else if(newchar->smartbomb->attack_type==ATK_STEAL) {
		newchar->smartbomb->steal = 1;
	}

	if(newchar->type == TYPE_ITEM) {
		newchar->dofreeze = 0;								// Items don't animate
		newchar->smartbomb->freezetime = atoi(GET_ARGP(3)) * GAME_SPEED;
	} else {
		newchar->dofreeze = atoi(GET_ARGP(3));		// Are all animations frozen during special
		newchar->smartbomb->freezetime = atoi(GET_ARGP(4)) * GAME_SPEED;
	}
}

void lcmHandleCommandHostile(ArgList* arglist, s_model* newchar) {
	int i = 1;
	char* value = GET_ARGP(i);
	newchar->hostile = 0;

	while(value && value[0])
	{
		if(stricmp(value, "enemy")==0){
			newchar->hostile |= TYPE_ENEMY;
		} else if(stricmp(value, "player")==0){
			newchar->hostile |= TYPE_PLAYER;
		} else if(stricmp(value, "obstacle")==0){
			newchar->hostile |= TYPE_OBSTACLE;
		} else if(stricmp(value, "shot")==0){
			newchar->hostile |= TYPE_SHOT;
		} else if(stricmp(value, "npc")==0){
			newchar->hostile |= TYPE_NPC;
		}
		i++;
		value = GET_ARGP(i);
	}
}
void lcmHandleCommandCandamage(ArgList* arglist, s_model* newchar) {
	int i = 1;
	char* value = GET_ARGP(i);
	newchar->candamage = 0;

	while(value && value[0])
	{
		if(stricmp(value, "enemy")==0){
			newchar->candamage |= TYPE_ENEMY;
		} else if(stricmp(value, "player")==0){
			newchar->candamage |= TYPE_PLAYER;
		} else if(stricmp(value, "obstacle")==0){
			newchar->candamage |= TYPE_OBSTACLE;
		} else if(stricmp(value, "shot")==0){
			newchar->candamage |= TYPE_SHOT;
		} else if(stricmp(value, "npc")==0){
			newchar->candamage |= TYPE_NPC;
		} else if(stricmp(value, "ground")==0){ // not really needed, though
			newchar->ground = 1;
		}
		i++;
		value = GET_ARGP(i);
	}
}

void lcmHandleCommandProjectilehit(ArgList* arglist, s_model* newchar) {
	int i = 1;
	char* value = GET_ARGP(i);

	newchar->projectilehit = 0;

	while(value && value[0])
	{
		if(stricmp(value, "enemy")==0){
			newchar->projectilehit |= TYPE_ENEMY;
		} else if(stricmp(value, "player")==0){
			newchar->projectilehit |= TYPE_PLAYER;
		} else if(stricmp(value, "obstacle")==0){
			newchar->projectilehit |= TYPE_OBSTACLE;
		} else if(stricmp(value, "shot")==0){
			newchar->projectilehit |= TYPE_SHOT;
		} else if(stricmp(value, "npc")==0){
			newchar->projectilehit |= TYPE_NPC;
		}
		i++;
		value = GET_ARGP(i);
	}
}

void lcmHandleCommandAimove(ArgList* arglist, s_model* newchar, int* aimoveset, char* filename) {
	char* value = GET_ARGP(1);
	if(!*aimoveset)
	{
		newchar->aimove = 0;
		*aimoveset = 1;
	}

	//main A.I. move switches
	if(value && value[0])
	{
		if(stricmp(value, "normal")==0){
			newchar->aimove |= AIMOVE1_NORMAL;
		}
		else if(stricmp(value, "chase")==0){
			newchar->aimove |= AIMOVE1_CHASE;
		}
		else if(stricmp(value, "chasex")==0){
			newchar->aimove |= AIMOVE1_CHASEX;
		}
		else if(stricmp(value, "chasez")==0){
			newchar->aimove |= AIMOVE1_CHASEZ;
		}
		else if(stricmp(value, "avoid")==0){
			newchar->aimove |= AIMOVE1_AVOID;
		}
		else if(stricmp(value, "avoidx")==0){
			newchar->aimove |= AIMOVE1_AVOIDX;
		}
		else if(stricmp(value, "avoidz")==0){
			newchar->aimove |= AIMOVE1_AVOIDZ;
		}
		else if(stricmp(value, "wander")==0){
			newchar->aimove |= AIMOVE1_WANDER;
		}
		else if(stricmp(value, "biker")==0){
			newchar->aimove |= AIMOVE1_BIKER;
		}
		else if(stricmp(value, "arrow")==0){
			newchar->aimove |= AIMOVE1_ARROW;
			if(!newchar->offscreenkill) newchar->offscreenkill = 200;
		}
		else if(stricmp(value, "star")==0){
			newchar->aimove |= AIMOVE1_STAR;
		}
		else if(stricmp(value, "bomb")==0){
			newchar->aimove |= AIMOVE1_BOMB;
		}
		else if(stricmp(value, "nomove")==0){
			newchar->aimove |= AIMOVE1_NOMOVE;
		}
		else shutdown(1, "Model '%s' has invalid A.I. move switch: '%s'", filename, value);
	}
	value = GET_ARGP(2);
	//sub A.I. move switches
	if(value && value[0])
	{
		if(stricmp(value, "normal")==0){
			newchar->aimove |= AIMOVE2_NORMAL;
		}
		else if(stricmp(value, "ignoreholes")==0){
			newchar->aimove |= AIMOVE2_IGNOREHOLES;
		}
		else if(stricmp(value, "notargetidle")==0){
			newchar->aimove |= AIMOVE2_NOTARGETIDLE;
		}
		else shutdown(1, "Model '%s' has invalid A.I. move switch: '%s'", filename, value);
	}
}
void lcmHandleCommandAiattack(ArgList* arglist, s_model* newchar, int* aiattackset, char* filename) {
	char* value = GET_ARGP(1);
	if(!*aiattackset)
	{
		newchar->aiattack = 0;
		*aiattackset = 1;
	}

	//main A.I. move switches
	if(value && value[0])
	{
		if(stricmp(value, "normal")==0){
			newchar->aiattack |= AIATTACK1_NORMAL;
		}
		else if(stricmp(value, "always")==0){
			newchar->aiattack |= AIATTACK1_ALWAYS;
		}
		else if(stricmp(value, "noattack")==0){
			newchar->aiattack |= AIATTACK1_NOATTACK;
		}
		else printf("Model '%s' has invalid A.I. attack switch: '%s'\n", filename, value);
	}
	/*
	value = GET_ARGP(2);
	//sub A.I. move switches
	if(value && value[0])
	{

	}*/
}

void lcmHandleCommandWeapons(ArgList* arglist, s_model* newchar) {
	int weap;
	char* value;
	for(weap = 0; ; weap++){
		value = GET_ARGP(weap+1);
		if(!value[0]) break;
	}

	if(!weap) return;

	newchar->numweapons = weap;

	if(!newchar->weapon)
	{
		newchar->weapon = malloc(sizeof(*newchar->weapon)*newchar->numweapons);
		memset(newchar->weapon, 0xFF, sizeof(*newchar->weapon)*newchar->numweapons);
		newchar->ownweapons = 1;
	}
	for(weap = 0; weap<newchar->numweapons ; weap++){
		value = GET_ARGP(weap+1);
		if(stricmp(value, "none")!=0){
			newchar->weapon[weap] = get_cached_model_index(value);
		} else { // make empty weapon slots  2007-2-16
			newchar->weapon[weap] = -1;
		}
	}
}
void lcmHandleCommandScripts(ArgList* arglist, Script* script, char* scriptname, char* filename) {
	Script_Init(script, scriptname, filename, 0);
	if(load_script(script, GET_ARGP(1)))
		Script_Compile(script);
	else shutdown(1, "Unable to load %s '%s' in file '%s'.\n", scriptname, GET_ARGP(1), filename);
}

//alloc a new model, and everything thats required,
//set all values to defaults
s_model* init_model(int cacheindex, int unload) {
	//to free: newchar, newchar->offense_factors, newchar->special, newchar->animation - OK
	int i;

	s_model* newchar = calloc(1, sizeof(s_model));
	if(!newchar) shutdown(1, (char*)E_OUT_OF_MEMORY);
	newchar->name = model_cache[cacheindex].name; // well give it a name for sort method
	newchar->index = cacheindex;
	newchar->isSubclassed = 0;
	newchar->freetypes = MF_ALL;

	newchar->defense		        = (s_defense*)calloc(max_attack_types + 1, sizeof(s_defense));
	newchar->offense_factors        = (float*)calloc(max_attack_types + 1, sizeof(float));

	newchar->special                = (s_com*)calloc(1, sizeof(s_com));

	alloc_all_scripts(&newchar->scripts);

	newchar->unload             = unload;
	newchar->jumpspeed          = default_model_jumpspeed;
	newchar->jumpheight         = default_model_jumpheight; // 28-12-2004   Set default jump height to 4, if not specified
	newchar->runjumpheight      = default_model_jumpheight; // Default jump height if a player is running
	newchar->runjumpdist        = 1; // Default jump distane if a player is running
	newchar->grabdistance       = default_model_grabdistance; //  30-12-2004 Default grabdistance is same as originally set
	newchar->grabflip		    = 3;
	newchar->throwdamage        = 21; // default throw damage
	newchar->icon.def			= -1;
	newchar->icon.die           = -1;
	newchar->icon.pain          = -1;
	newchar->icon.get           = -1;
	newchar->icon.weapon		= -1;			    // No weapon icon set yet
	newchar->diesound           = -1;
	newchar->nolife             = 0;			    // default show life = 1 (yes)
	newchar->remove             = 1;			    // Flag set to weapons are removed upon hitting an opponent
	newchar->throwdist          = default_model_jumpheight*0.625f;
	newchar->counter            = 3;			    // Default 3 times to drop a weapon / projectile
	newchar->aimove             = -1;
	newchar->aiattack           = -1;
	newchar->throwframewait     = -1;               // makes sure throw animations run normally unless throwfram is specified, added by kbandressen 10/20/06
	newchar->path               = model_cache[cacheindex].path;         // Record path, so script can get it without looping the whole model collection.
	newchar->icon.mphigh        = -1;               //No mphigh icon yet.
    newchar->icon.mplow         = -1;               //No mplow icon yet.
    newchar->icon.mpmed         = -1;               //No mpmed icon yet.

		// Default Attack1 in chain must be referenced if not used.
	for(i=0; i<MAX_ATCHAIN; i++) newchar->atchain[i] = 1;
	newchar->chainlength = 1;

	if(magic_type == 1) newchar->mprate = 1;
	else newchar->mprate                = 2;
	newchar->chargerate = newchar->guardrate = 2;
	newchar->risetime[0]                = -1;
	newchar->sleepwait                  = 1000;
	newchar->jugglepoints.current = newchar->jugglepoints.maximum = 0;
	newchar->guardpoints.current = newchar->guardpoints.maximum = 0;
	newchar->mpswitch                   = -1;       // switch between reduce mp or gain mp for mpstabletype 4
	newchar->weaploss[0]                = -1;
	newchar->weaploss[1]                = -1;
	newchar->lifespan                   = (float)0xFFFFFFFF;
	newchar->summonkill                 = 1;
	newchar->candamage                  = -1;
	newchar->hostile                    = -1;
	newchar->projectilehit              = -1;
	newchar->subject_to_wall            = -1;
	newchar->subject_to_platform        = -1;
	newchar->subject_to_obstacle        = -1;
	newchar->subject_to_hole            = -1;
	newchar->subject_to_gravity         = -1;
	newchar->subject_to_screen          = -1;
	newchar->subject_to_minz            = -1;
	newchar->subject_to_maxz            = -1;
	newchar->no_adjust_base             = -1;
	newchar->pshotno                    = -1;
	newchar->project                    = -1;
	newchar->dust[0]                    = -1;
	newchar->dust[1]                    = -1;
	newchar->dust[2]                    = -1;
	newchar->bomb                       = -1;
	newchar->star                       = -1;
	newchar->knife                      = -1;
    newchar->stealth.hide               = 0;
    newchar->stealth.detect             = 0;
	newchar->attackthrottle				= 0.0f;
	newchar->attackthrottletime			= noatk_duration*GAME_SPEED;

	newchar->animation = (s_anim**)calloc(max_animations, sizeof(s_anim*));
	if(!newchar->animation) shutdown(1, (char*)E_OUT_OF_MEMORY);

	// default string value, only by reference
	newchar->rider = get_cached_model_index("K'");
	newchar->flash = newchar->bflash = get_cached_model_index("flash");

	//Default offense/defense values.
	for(i=0;i<max_attack_types;i++)
	{
		newchar->offense_factors[i]     = 1;
		newchar->defense[i]				= default_defense;
	}

	//Default sight ranges.
    newchar->sight.amin = -9999;
    newchar->sight.amax = 9999;
    newchar->sight.xmin = -9999;
    newchar->sight.xmax = 9999;
    newchar->sight.zmin = -9999;
    newchar->sight.zmax = 9999;

	return newchar;
}

void update_model_loadflag(s_model* model, char unload) {
	model->unload = unload;
}

s_model* load_cached_model(char * name, char * owner, char unload)
{
	s_model *newchar = NULL,
	*tempmodel = NULL;

	s_anim *newanim = NULL;

	char *filename = NULL,
	*buf = NULL,
	*scriptbuf = NULL,
	*command = NULL,
	*value = NULL,
	*value2 = NULL,
	*value3 = NULL;

	char fnbuf[128] = {""},
		namebuf[256] = {""},
		argbuf[MAX_ARG_LEN+1] = "";

	ArgList arglist;

	float tempFloat;

	int ani_id = -1,
		script_id = -1,
		i = 0,
		j = 0,
		tempInt = 0,
		framecount = 0,
		frameset = 0,
		peek = 0,
		cacheindex = 0,
		curframe = 0,
		delay = 0,
		errorVal = 0,
		shadow_set = 0,
		idle = 0,
		move = 0,
		movez = 0,
		movea = 0,
		seta = -1,			// Used for setting custom "a". Set to -1 to distinguish between disabled and setting "a" to 0
		frameshadow = -1,	// -1 will use default shadow for this entity, otherwise will use this value
		soundtoplay = -1,
		aimoveset = 0,
		aiattackset = 0,
		maskindex = -1,
		nopalette = 0;

	size_t size = 0,
		line = 0,
		len = 0,
		sbsize=0,
		scriptlen=0;

	ptrdiff_t pos = 0,
		index = 0;

	short bbox[6] = { 0,0,0,0,0,0 },
		bbox_con[6] = { 0,0,0,0,0,0 },
		abox[6] = { 0,0,0,0,0,0 },
		offset[2] = { 0,0 },
		shadow_xz[2] = {0,0},
		shadow_coords[2] = {0,0};

	float platform[8] = { 0,0,0,0,0,0,0,0 },
		platform_con[8] = { 0,0,0,0,0,0,0,0 };

	s_attack attack,
	*pattack = NULL;
	s_defense defense;
	char* shutdownmessage = NULL;

	s_drawmethod drawmethod;

	unsigned char* mapflag = NULL; // in 24bit mode, we need to know whether a colourmap is a common map or a palette

	static const char* pre_text =  // this is the skeleton of frame function
		"void main()\n"
		"{\n"
		"    int frame = getlocalvar(\"frame\");\n"
		"    int animhandle = getlocalvar(\"animhandle\");\n"
		"\n}\n";

	static const char* sur_text = // end of function text
		"\n}\n";

	static const char* ifid_text = // if expression to check animation id
		"    if(animhandle==%ld)\n"
		"    {\n"
		"        return;\n"
		"    }\n";

	static const char* endifid_text = // end of if
		"        return;\n"
		"    }\n";

	static const char* if_text = // this is the if expression of frame function
		"        if(frame==%d)\n"
		"        {\n";

	static const char* endif_text = // end of if
		"\n"
		"        }\n" ;

	static const char* comma_text = // arguments separator
		", ";

	static const char* call_text = //begin of function call
		"            %s(";

	static const char* endcall_text = //end of function call
		");\n";

	modelCommands cmd;
	s_scripts* tempscripts;

#ifdef DEBUG
	printf("load_cached_model: %s, unload: %d\n", name, unload);
#endif

	// Model already loaded but we might want to unload after level is completed.
	if((tempmodel=findmodel(name))!=NULL) {
		update_model_loadflag(tempmodel,unload);
		cache_model_sprites(tempmodel, 1);
		return tempmodel;
	}

	cacheindex = get_cached_model_index(name);
	if(cacheindex < 0) shutdown(1, "Fatal: No cache entry for '%s' within '%s'\n\n", name, owner);

	filename = model_cache[cacheindex].path;

	if(buffer_pakfile(filename, &buf, &size)!=1) shutdown(1, "Unable to open file '%s'\n\n", filename);
	
	sbsize = size+1;
	scriptbuf = (char*)malloc(sbsize);

	if(scriptbuf==NULL){
		shutdown(1, "Unable to create script buffer for file '%s' (%i bytes)", filename, size*2);
	}
	scriptbuf[0] = 0;

	//_peek_model_name(cacheindex);
	newchar = init_model(cacheindex, unload);
	//newchar->name = name;

	//attention, we increase models_loaded here, this can be dangerous if we access that value later on,
	//since recursive calls will change it!
	models_loaded++;
	addModel(newchar);

	attack = emptyattack;      // empty attack
	drawmethod = plainmethod;  // better than memset it to 0


	//char* test = "load   knife 0";
	//ParseArgs(&arglist,test,argbuf);

	// Now interpret the contents of buf line by line
	while(pos<size)
	{
		//command = GET_ARG(0);
		line++;
		if(ParseArgs(&arglist,buf+pos,argbuf)){
			command = GET_ARG(0);
			cmd = getModelCommand(modelcmdlist, command);

			switch(cmd) {
				case CMD_MODEL_SUBCLASS:
					//inherit everything from an existing, cached model
					tempmodel = findmodel(GET_ARG(1));
					if (!tempmodel) {
						shutdownmessage = "tried to subclass a non-existing/not previously loaded model!";
						goto lCleanup;
					}
					tempscripts = newchar->scripts;
					*newchar = *tempmodel;
					newchar->scripts = tempscripts;
					copy_all_scripts(tempmodel->scripts, newchar->scripts, 1);
					newchar->isSubclassed = 1;
					newchar->freetypes = MF_SCRIPTS;
					break;
				case CMD_MODEL_NAME:
					lcmHandleCommandName(&arglist, newchar, cacheindex);
					break;
				case CMD_MODEL_TYPE:
					lcmHandleCommandType(&arglist, newchar, filename);
					break;
				case CMD_MODEL_SUBTYPE:
					lcmHandleCommandSubtype(&arglist, newchar, filename);
					break;
				case CMD_MODEL_STATS:
					value = GET_ARG(1);
					newchar->stats[atoi(value)] = GET_FLOAT_ARG(2);
					break;
				case CMD_MODEL_HEALTH:
					value = GET_ARG(1);
					newchar->health = atoi(value);
					break;
				case CMD_MODEL_SCROLL:
					value = GET_ARG(1);
					newchar->scroll = atof(value);
					break;
				case CMD_MODEL_MP: //Left for backward compatability. See mpset. // mp values to put max mp for player by tails
					value = GET_ARG(1);
					newchar->mp = atoi(value);
					break;
				case CMD_MODEL_NOLIFE:	// Feb 25, 2005 - Flag to display enemy life or not
					newchar->nolife = GET_INT_ARG(1);
					break;
				case CMD_MODEL_MAKEINV:	// Mar 12, 2005 - If a value is supplied, corresponds to amount of time the player spawns invincible
					newchar->makeinv = GET_INT_ARG(1) * GAME_SPEED;
					if(GET_INT_ARG(2)) newchar->makeinv = -newchar->makeinv;
					break;
				case CMD_MODEL_RISEINV:
					newchar->riseinv = GET_FLOAT_ARG(1) * GAME_SPEED;
					if(GET_INT_ARG(2)) newchar->riseinv = -newchar->riseinv;
					break;
				case CMD_MODEL_LOAD:
					value = GET_ARG(1);
					tempmodel = findmodel(value);
					if(!tempmodel)
						load_cached_model(value, name, GET_INT_ARG(2));
					else
						update_model_loadflag(tempmodel, GET_INT_ARG(2));
					break;
				case CMD_MODEL_SCORE:
					newchar->score = GET_INT_ARG(1);
					newchar->multiple = GET_INT_ARG(2);			// New var multiple for force/scoring
					break;
				case CMD_MODEL_SMARTBOMB:
					lcmHandleCommandSmartbomb(&arglist, newchar, filename);
					break;
				case CMD_MODEL_BOUNCE:
					newchar->bounce = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NOQUAKE:  // Mar 12, 2005 - Flag to determine if entity shakes screen
					newchar->noquake = GET_INT_ARG(1);
					break;
				case CMD_MODEL_BLOCKBACK:	// Flag to determine if attacks can be blocked from behind
					newchar->blockback = GET_INT_ARG(1);
					break;
				case CMD_MODEL_HITENEMY:	// Flag to determine if an enemy projectile will hit enemies
					value = GET_ARG(1);
					if(atoi(value) == 1)
						newchar->candamage = newchar->hostile = TYPE_PLAYER | TYPE_ENEMY;
					else if(atoi(value) == 2)
						newchar->candamage = newchar->hostile = TYPE_PLAYER;
					newchar->ground = GET_INT_ARG(2);    // Added to determine if enemies are damaged with mid air projectiles or ground only
					break;
				case CMD_MODEL_HOSTILE:
					lcmHandleCommandHostile(&arglist, newchar);
					break;
				case CMD_MODEL_CANDAMAGE:
					lcmHandleCommandCandamage(&arglist, newchar);
					break;
				case CMD_MODEL_PROJECTILEHIT:
					lcmHandleCommandProjectilehit(&arglist, newchar);
					break;
				case CMD_MODEL_AIMOVE:
					lcmHandleCommandAimove(&arglist, newchar, &aimoveset, filename);
					break;
				case CMD_MODEL_AIATTACK:
					lcmHandleCommandAiattack(&arglist, newchar, &aiattackset, filename);
					break;
				case CMD_MODEL_SUBJECT_TO_WALL:
					newchar->subject_to_wall = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_HOLE:
					newchar->subject_to_hole = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_PLATFORM:
					newchar->subject_to_platform = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_OBSTACLE:
					newchar->subject_to_obstacle = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_GRAVITY:
					newchar->subject_to_gravity = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_SCREEN:
					newchar->subject_to_screen = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_MINZ:
					newchar->subject_to_minz = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_SUBJECT_TO_MAXZ:
					newchar->subject_to_maxz = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_NO_ADJUST_BASE:
					newchar->no_adjust_base = (0!=GET_INT_ARG(1));
					break;
				case CMD_MODEL_INSTANTITEMDEATH:
					newchar->instantitemdeath = GET_INT_ARG(1);
					break;
				case CMD_MODEL_SECRET:
					newchar->secret = GET_INT_ARG(1);
					newchar->clearcount = GET_INT_ARG(2);
					break;
				case CMD_MODEL_MODELFLAG: //model copy flag
					newchar->model_flag = GET_INT_ARG(1);
					break;
				// weapons
				case CMD_MODEL_WEAPLOSS:
					newchar->weaploss[0] = GET_INT_ARG(1);
					newchar->weaploss[1] = GET_INT_ARG(2);
					break;
				case CMD_MODEL_WEAPNUM:
					newchar->weapnum = GET_INT_ARG(1);
					break;
				case CMD_MODEL_PROJECT: // New projectile subtype
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->project = -1;
					else newchar->project = get_cached_model_index(value);
					break;
				case CMD_MODEL_WEAPONS:
					lcmHandleCommandWeapons(&arglist, newchar);
					break;
				case CMD_MODEL_SHOOTNUM: //here weapons things like shoot rest type of weapon ect..by tails
					newchar->shootnum = GET_INT_ARG(1);
					break;
				case CMD_MODEL_RELOAD:
					newchar->reload = GET_INT_ARG(1);
					break;
				case CMD_MODEL_TYPESHOT:
					newchar->typeshot = GET_INT_ARG(1);
					break;
				case CMD_MODEL_COUNTER:
					newchar->counter = GET_INT_ARG(1);
					break;
				case CMD_MODEL_ANIMAL:
					newchar->animal = GET_INT_ARG(1);
					break;
				case CMD_MODEL_RIDER:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->rider = -1;
					else newchar->rider = get_cached_model_index(value);
					break;
				case CMD_MODEL_KNIFE: case CMD_MODEL_FIREB: case CMD_MODEL_PLAYSHOT: case CMD_MODEL_PLAYSHOTW:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->knife = -1;
					else  newchar->knife = get_cached_model_index(value);
					break;
				case CMD_MODEL_PLAYSHOTNO:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->pshotno = -1;
					else newchar->pshotno = get_cached_model_index(value);
					break;
				case CMD_MODEL_STAR:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->star = -1;
					else newchar->star = get_cached_model_index(value);
					break;
				case CMD_MODEL_BOMB: case CMD_MODEL_PLAYBOMB:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->bomb = -1;
					else newchar->bomb = get_cached_model_index(value);
					break;
				case CMD_MODEL_FLASH:	 // Now all characters can have their own flash - even projectiles (useful for blood)
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->flash = -1;
					else newchar->flash = get_cached_model_index(value);
					break;
				case CMD_MODEL_BFLASH:	// Flash that is spawned if an attack is blocked
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->bflash = -1;
					else newchar->bflash = get_cached_model_index(value);
					break;
				case CMD_MODEL_DUST:	// Spawned when hitting the ground to "kick up dust"
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) newchar->dust[0] = -1;
					else newchar->dust[0] = get_cached_model_index(value);
					value = GET_ARG(2);
					if(stricmp(value, "none")==0) newchar->dust[1] = -1;
					else newchar->dust[1] = get_cached_model_index(value);
					value = GET_ARG(3);
					if(stricmp(value, "none")==0) newchar->dust[2] = -1;
					else newchar->dust[2] = get_cached_model_index(value);
					break;
				case CMD_MODEL_BRANCH: // for endlevel item's level branch
					value = GET_ARG(1);
					if(!newchar->branch)
					{
						newchar->branch = malloc(MAX_NAME_LEN+1);
						newchar->branch[0] = 0;
					}
					strncpy(newchar->branch, value, MAX_NAME_LEN);
					break;
				case CMD_MODEL_CANTGRAB: case CMD_MODEL_NOTGRAB:
					tempInt = GET_INT_ARG(1);
					if(tempInt == 2) newchar->grabforce = -999999;
					else             newchar->antigrab = 1;
					break;
				case CMD_MODEL_ANTIGRAB: // a can grab b: a->antigrab - b->grabforce <=0
					newchar->antigrab = GET_INT_ARG(1);
					break;
				case CMD_MODEL_GRABFORCE:
					newchar->grabforce = GET_INT_ARG(1);
					break;
				case CMD_MODEL_GRABBACK:
					newchar->grabback = GET_INT_ARG(1);
					break;
				case CMD_MODEL_OFFSCREENKILL:
					newchar->offscreenkill = GET_INT_ARG(1);
					break;
				case CMD_MODEL_FALLDIE: case CMD_MODEL_DEATH:
					newchar->falldie = GET_INT_ARG(1);
					break;
				case CMD_MODEL_SPEED:
					value = GET_ARG(1);
					newchar->speed = atof(value);
					newchar->speed /= 10;
					if(newchar->speed < 0.5) newchar->speed = 0.5;
					if(newchar->speed > 30) newchar->speed = 30;
					break;
				case CMD_MODEL_SPEEDF:
					value = GET_ARG(1);
					newchar->speed = atof(value);
					break;
				case CMD_MODEL_JUMPSPEED:
					value = GET_ARG(1);
					newchar->jumpspeed = atof(value);
					newchar->jumpspeed /= 10;
					break;
				case CMD_MODEL_JUMPSPEEDF:
					value = GET_ARG(1);
					newchar->jumpspeed = atof(value);
					break;
				case CMD_MODEL_ANTIGRAVITY:
					value = GET_ARG(1);
					newchar->antigravity = atof(value);
					newchar->antigravity /= 100;
					break;
				case CMD_MODEL_STEALTH:
					newchar->stealth.hide = GET_INT_ARG(1);
					newchar->stealth.detect = GET_INT_ARG(2);
					break;
				case CMD_MODEL_JUGGLEPOINTS:
					value = GET_ARG(1);
					newchar->jugglepoints.current = atoi(value);
					newchar->jugglepoints.maximum = atoi(value);
					break;
				case CMD_MODEL_RISEATTACKTYPE:
					value = GET_ARG(1);
					newchar->riseattacktype = atoi(value);
					break;
				case CMD_MODEL_GUARDPOINTS:
					value = GET_ARG(1);
					newchar->guardpoints.current = atoi(value);
					newchar->guardpoints.maximum = atoi(value);
					break;
				case CMD_MODEL_DEFENSE:
					#define tempdef(x, y) \
					x(stricmp(value, #y)==0)\
					{\
						newchar->defense[ATK_##y] = defense;\
					}
					{
						value = GET_ARG(1);
						defense = default_defense;
						if(newchar->subtype==SUBTYPE_BIKER) defense.factor=2.f;

						if(arglist.count>=2) defense.factor = GET_FLOAT_ARG(2);
						if(arglist.count>=3) defense.pain = GET_FLOAT_ARG(3);
						if(arglist.count>=4) defense.knockdown = GET_FLOAT_ARG(4);
						if(arglist.count>=5) defense.blockpower = GET_FLOAT_ARG(5);
						if(arglist.count>=6) defense.blockthreshold = GET_FLOAT_ARG(6);
						if(arglist.count>=7) defense.blockratio = GET_FLOAT_ARG(7);
						if(arglist.count>=8) defense.blocktype = GET_FLOAT_ARG(8);

						tempdef(if, NORMAL)
						tempdef(else if, NORMAL2)
						tempdef(else if, NORMAL3)
						tempdef(else if, NORMAL4)
						tempdef(else if, NORMAL5)
						tempdef(else if, NORMAL6)
						tempdef(else if, NORMAL7)
						tempdef(else if, NORMAL8)
						tempdef(else if, NORMAL9)
						tempdef(else if, NORMAL10)
						tempdef(else if, BLAST)
						tempdef(else if, STEAL)
						tempdef(else if, BURN)
						tempdef(else if, SHOCK)
						tempdef(else if, FREEZE)
						else if(strnicmp(value, "normal", 6)==0)
						{
							tempInt = atoi(value+6);
							if(tempInt<11) tempInt = 11;
							newchar->defense[tempInt+STA_ATKS-1] = defense;
						}
						else if(stricmp(value, "ALL")==0)
						{
							for(i=0;i<max_attack_types;i++) newchar->defense[i] = defense;
						}
					}
					#undef tempdef
					break;
				case CMD_MODEL_OFFENSE:
					#define tempoff(x, y, z) \
					x(stricmp(value, #y)==0)\
					{\
					newchar->z[ATK_##y] = GET_FLOAT_ARG(2);\
					/*newchar->z[ATK_##y] /= 100;*/\
					}
					{
						value = GET_ARG(1);
						tempoff(if,         NORMAL,     offense_factors)
						tempoff(else if,    NORMAL2,    offense_factors)
						tempoff(else if,    NORMAL3,    offense_factors)
						tempoff(else if,    NORMAL4,    offense_factors)
						tempoff(else if,    NORMAL5,    offense_factors)
						tempoff(else if,    NORMAL6,    offense_factors)
						tempoff(else if,    NORMAL7,    offense_factors)
						tempoff(else if,    NORMAL8,    offense_factors)
						tempoff(else if,    NORMAL9,    offense_factors)
						tempoff(else if,    NORMAL10,   offense_factors)
						tempoff(else if,    BLAST,      offense_factors)
						tempoff(else if,    STEAL,      offense_factors)
						tempoff(else if,    BURN,       offense_factors)
						tempoff(else if,    SHOCK,      offense_factors)
						tempoff(else if,    FREEZE,     offense_factors)
						else if(strnicmp(value, "normal", 6)==0)
						{
							tempInt = atoi(value+6);
							if(tempInt<11) tempInt = 11;
							newchar->offense_factors[tempInt+STA_ATKS-1] = GET_FLOAT_ARG(2);
						}
						else if(stricmp(value, "ALL")==0)
						{
							tempFloat = GET_FLOAT_ARG(2);
							for(i=0;i<max_attack_types;i++)
							{
								newchar->offense_factors[i] = tempFloat;
							}
						}
					}
					#undef tempoff
					break;
				case CMD_MODEL_HEIGHT:
					newchar->height = GET_INT_ARG(1);
					break;
				case CMD_MODEL_JUMPHEIGHT:
					newchar->jumpheight = GET_FLOAT_ARG(1);
					break;
				case CMD_MODEL_JUMPMOVE:
					newchar->jumpmovex = GET_INT_ARG(1);
					newchar->jumpmovez = GET_INT_ARG(2);
					break;
				case CMD_MODEL_KNOCKDOWNCOUNT:
					newchar->knockdowncount = GET_FLOAT_ARG(1);
					break;
				case CMD_MODEL_GRABDISTANCE:
					newchar->grabdistance = GET_FLOAT_ARG(1);                    // 30-12-2004 and store for character
					break;
				case CMD_MODEL_GRABFLIP:
					newchar->grabflip = GET_INT_ARG(1);
					break;
				case CMD_MODEL_GRABFINISH:
					newchar->grabfinish = GET_INT_ARG(1);
					break;
				case CMD_MODEL_THROWDAMAGE:
					newchar->throwdamage = GET_INT_ARG(1);
					break;
				case CMD_MODEL_SHADOW:
					newchar->shadow = GET_INT_ARG(1);
					break;
				case CMD_MODEL_GFXSHADOW:
					newchar->gfxshadow = GET_INT_ARG(1);
					break;
				case CMD_MODEL_AIRONLY:	// Shadows display in air only?
					newchar->aironly = GET_INT_ARG(1);
					break;
				case CMD_MODEL_FMAP:	// Map that corresponds with the remap when a character is frozen
					newchar->maps.frozen = GET_INT_ARG(1);
					break;
				case CMD_MODEL_KOMAP:	// Remap when character is KO'd.
					newchar->maps.ko = GET_INT_ARG(1);  //Remap.
					newchar->maps.kotype = GET_INT_ARG(2);  //Type: 0 start of fall/death, 1 last frame.
					break;
				case CMD_MODEL_HMAP:	// Maps range unavailable to player in select screen.
					newchar->maps.hide_start = GET_INT_ARG(1); //First unavailable map.
					newchar->maps.hide_end = GET_INT_ARG(2); //Last unavailable map.
					break;
				case CMD_MODEL_SETLAYER:
					newchar->setlayer = GET_INT_ARG(1);
					break;
				case CMD_MODEL_TOFLIP:	  // Flag to determine if flashes images will be flipped or not
					newchar->toflip = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NODIEBLINK:
					// Added to determine if dying animation blinks or not
					newchar->nodieblink = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NOATFLASH:	 // Flag to determine if an opponents attack spawns their flash or not
					newchar->noatflash = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NOMOVE:
					// If set, will be static (speed must be set to 0 or left blank)
					newchar->nomove = GET_INT_ARG(1);
					newchar->noflip = GET_INT_ARG(2);    // If set, static will not flip directions
					if(newchar->nomove) newchar->nodrop = 1;
					break;
				case CMD_MODEL_NODROP:
					newchar->nodrop = GET_INT_ARG(1);
					break;
				case CMD_MODEL_THOLD:
					// Threshold for enemies/players block
					newchar->thold = GET_INT_ARG(1);
					break;
				case CMD_MODEL_RUNNING:
					// The speed at which the player runs
					newchar->runspeed = GET_FLOAT_ARG(1);
					newchar->runspeed /= 10;
					newchar->runjumpheight = GET_FLOAT_ARG(2);    // The height at which a player jumps when running
					newchar->runjumpdist = GET_FLOAT_ARG(3);    // The distance a player jumps when running
					newchar->runupdown = GET_INT_ARG(4);
					newchar->runhold = GET_INT_ARG(5);
					break;
				case CMD_MODEL_BLOCKODDS:
					// Odds that an attack will hit an enemy (1 : blockodds)
					newchar->blockodds = GET_INT_ARG(1);
					break;
				case CMD_MODEL_HOLDBLOCK:
					newchar->holdblock = GET_INT_ARG(1);
					break;
				case CMD_MODEL_BLOCKPAIN:
					newchar->blockpain = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NOPASSIVEBLOCK:
					newchar->nopassiveblock = GET_INT_ARG(1);
					break;
				case CMD_MODEL_EDELAY:
					newchar->edelay.mode        = GET_INT_ARG(1);
					newchar->edelay.factor      = GET_FLOAT_ARG(2);
					newchar->edelay.cap_min     = GET_INT_ARG(3);
					newchar->edelay.cap_max     = GET_INT_ARG(4);
					newchar->edelay.range_min   = GET_INT_ARG(5);
					newchar->edelay.range_max   = GET_INT_ARG(6);
					break;
				case CMD_MODEL_PAINGRAB:
					newchar->paingrab = GET_INT_ARG(1);
					break;
				case CMD_MODEL_THROW:
					newchar->throwdist = GET_FLOAT_ARG(1);
					newchar->throwheight = GET_FLOAT_ARG(2);
					break;
				case CMD_MODEL_GRABWALK:
					newchar->grabwalkspeed = GET_FLOAT_ARG(1);
					newchar->grabwalkspeed /= 10;
					if(newchar->grabwalkspeed < 0.5) newchar->grabwalkspeed = 0.5;
					break;
				case CMD_MODEL_GRABTURN:
					newchar->grabturn = GET_INT_ARG(1);
					break;
				case CMD_MODEL_THROWFRAMEWAIT:
					newchar->throwframewait = GET_INT_ARG(1);
					break;
				case CMD_MODEL_DIESOUND:
					newchar->diesound = sound_load_sample(GET_ARG(1), packfile, 0);
					break;
				case CMD_MODEL_ICON:
					value = GET_ARG(1);
					if(newchar->icon.def > -1) {
						shutdownmessage = "model has multiple icons defined";
						goto lCleanup;
					}
					newchar->icon.def = loadsprite(value,0,0,pixelformat); //use same palette as the owner
					newchar->icon.pain = newchar->icon.def;
					newchar->icon.die = newchar->icon.def;
					newchar->icon.get = newchar->icon.def;
					break;
				case CMD_MODEL_ICONPAIN:
					value = GET_ARG(1);
					newchar->icon.pain = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_ICONDIE:
					value = GET_ARG(1);
					newchar->icon.die = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_ICONGET:
					value = GET_ARG(1);
					newchar->icon.get = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_ICONW:
					value = GET_ARG(1);
					newchar->icon.weapon = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_ICONMPHIGH:
					value = GET_ARG(1);
					newchar->icon.mphigh = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_ICONMPHALF:
					value = GET_ARG(1);
					newchar->icon.mpmed = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_ICONMPLOW:
					value = GET_ARG(1);
					newchar->icon.mplow = loadsprite(value,0,0,pixelformat);
					break;
				case CMD_MODEL_PARROW:
					// Image that is displayed when player 1 spawns invincible
					value = GET_ARG(1);
					newchar->parrow[0][0] = loadsprite(value,0,0,pixelformat);
					newchar->parrow[0][1] = GET_INT_ARG(2);
					newchar->parrow[0][2] = GET_INT_ARG(3);
					break;
				case CMD_MODEL_PARROW2:
					// Image that is displayed when player 2 spawns invincible
					value = GET_ARG(1);
					newchar->parrow[1][0] = loadsprite(value,0,0,pixelformat);
					newchar->parrow[1][1] = GET_INT_ARG(2);
					newchar->parrow[1][2] = GET_INT_ARG(3);
					break;
				case CMD_MODEL_PARROW3:
					value = GET_ARG(1);
					newchar->parrow[2][0] = loadsprite(value,0,0,pixelformat);
					newchar->parrow[2][1] = GET_INT_ARG(2);
					newchar->parrow[2][2] = GET_INT_ARG(3);
					break;
				case CMD_MODEL_PARROW4:
					value = GET_ARG(1);
					newchar->parrow[3][0] = loadsprite(value,0,0,pixelformat);
					newchar->parrow[3][1] = GET_INT_ARG(2);
					newchar->parrow[3][2] = GET_INT_ARG(3);
					break;
				case CMD_MODEL_ATCHAIN:
					newchar->chainlength = 0;
					for(i = 0; i < MAX_ATCHAIN; i++)
					{
						newchar->atchain[i] = GET_INT_ARG(i + 1);
						if(newchar->atchain[i] < 0) newchar->atchain[i] = 0;
						if(newchar->atchain[i] > max_attacks) newchar->atchain[i] = max_attacks;
						if(newchar->atchain[i]) newchar->chainlength = i+1;
					}
					break;
				case CMD_MODEL_COMBOSTYLE:
					newchar->combostyle = GET_INT_ARG(1);
					break;
				case CMD_MODEL_CREDIT:
					newchar->credit = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NOPAIN:
					newchar->nopain = GET_INT_ARG(1);
					break;
				case CMD_MODEL_ESCAPEHITS:
					// How many times an enemy can be hit before retaliating
					newchar->escapehits = GET_INT_ARG(1);
					break;
				case CMD_MODEL_CHARGERATE:
					// How much mp does this character gain while recharging?
					newchar->chargerate = GET_INT_ARG(1);
					break;
				case CMD_MODEL_MPRATE:
					newchar->mprate = GET_INT_ARG(1);
					break;
				case CMD_MODEL_MPSET:
					// Mp bar wax/wane.
					newchar->mp             = GET_INT_ARG(1); //Max MP.
					newchar->mpstable       = GET_INT_ARG(2); //MP stable setting.
					newchar->mpstableval    = GET_INT_ARG(3); //MP stable value (% Mp bar will try and maintain).
					newchar->mprate         = GET_INT_ARG(4); //Rate MP value rises over time.
					newchar->mpdroprate     = GET_INT_ARG(5); //Rate MP value drops over time.
					newchar->chargerate     = GET_INT_ARG(6); //MP Chargerate.
					break;
				case CMD_MODEL_SLEEPWAIT:
					newchar->sleepwait = GET_INT_ARG(1);
					break;
				case CMD_MODEL_GUARDRATE:
					newchar->guardrate = GET_INT_ARG(1);
					break;
				case CMD_MODEL_AGGRESSION:
					newchar->aggression = GET_INT_ARG(1);
					break;
				case CMD_MODEL_ATTACKTHROTTLE:
					newchar->attackthrottle = GET_FLOAT_ARG(1);
					if(arglist.count>=2)
						newchar->attackthrottletime = GET_FLOAT_ARG(2)*GAME_SPEED;
					break;
				case CMD_MODEL_RISETIME:
					newchar->risetime[0] = GET_INT_ARG(1);
					newchar->risetime[1] = GET_INT_ARG(2);
					break;
				case CMD_MODEL_FACING:
					newchar->facing = GET_INT_ARG(1);
					break;
				case CMD_MODEL_TURNDELAY:
					newchar->turndelay = GET_INT_ARG(1);
					break;
				case CMD_MODEL_LIFESPAN:
					newchar->lifespan = GET_FLOAT_ARG(1)*GAME_SPEED;
					break;
				case CMD_MODEL_SUMMONKILL:
					newchar->summonkill = GET_INT_ARG(1);
					break;
				case CMD_MODEL_LIFEPOSITION:
					if((value=GET_ARG(1))[0]) newchar->hpx = atoi(value);
					if((value=GET_ARG(2))[0]) newchar->hpy = atoi(value);
					break;
				case CMD_MODEL_LIFEBARSTATUS:
					_readbarstatus(buf+pos, &(newchar->hpbarstatus));
					newchar->hpbarstatus.colourtable = &hpcolourtable;
					break;
				case CMD_MODEL_ICONPOSITION:
					if((value=GET_ARG(1))[0]) newchar->icon.x = atoi(value);
					if((value=GET_ARG(2))[0]) newchar->icon.y = atoi(value);
					break;
				case CMD_MODEL_NAMEPOSITION:
					if((value=GET_ARG(1))[0]) newchar->namex = atoi(value);
					if((value=GET_ARG(2))[0]) newchar->namey = atoi(value);
					break;
				case CMD_MODEL_COM:
					{
						// Section for custom freespecials starts here
						int i, t;
						alloc_specials(newchar);
						for(i = 0, t = 1; i < MAX_SPECIAL_INPUTS-3; i++, t++)
						{
							value = GET_ARG(t);
							if(!value[0]) break;
							if(stricmp(value, "u")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_MOVEUP;
							}
							else if(stricmp(value, "d")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_MOVEDOWN;
							}
							else if(stricmp(value, "f")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_FORWARD;
							}
							else if(stricmp(value, "b")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_BACKWARD;
							}
							else if(stricmp(value, "a")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK;
							}
							else if(stricmp(value, "a2")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK2;
							}
							else if(stricmp(value, "a3")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK3;
							}
							else if(stricmp(value, "a4")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK4;
							}
							else if(stricmp(value, "j")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_JUMP;
							}
							else if(stricmp(value, "s")==0 || stricmp(value, "k")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_SPECIAL;
							}
							else if(strnicmp(value, "freespecial", 11)==0 && (!value[11] || (value[11] >= '1' && value[11] <= '9'))){
								tempInt = atoi(value+11);
								if(tempInt<1) tempInt = 1;
								newchar->special[newchar->specials_loaded].anim = animspecials[tempInt-1];
							}
							else {
								shutdownmessage = "Invalid freespecial command";
								goto lCleanup;
							}
						}
						newchar->special[newchar->specials_loaded].steps=i-1; // max steps
						newchar->specials_loaded++;
					}
					// End section for custom freespecials
					break;
				case CMD_MODEL_REMAP:
					{
						// This command should not be used under 24bit mode, but for old mods, just give it a default palette
						value = GET_ARG(1);
						value2 = GET_ARG(2);
						__realloc(mapflag, newchar->maps_loaded);
						errorVal = load_colourmap(newchar, value, value2);
						if(pixelformat==PIXEL_x8 && newchar->palette==NULL)
						{
							newchar->palette = malloc(PAL_BYTES);
							if(loadimagepalette(value, packfile, newchar->palette)==0) {
								shutdownmessage = "Failed to load palette!";
								goto lCleanup;
							}
						}
						mapflag[newchar->maps_loaded-1] = 1;
						if(!errorVal){
							switch(errorVal){
								case 0: // uhm wait, we just tested for !errorVal...
									shutdownmessage = "Failed to create colourmap. Image Used Twice!";
									goto lCleanup;
									break;
								case -1: //should not happen now
									shutdownmessage = "Failed to create colourmap. MAX_COLOUR_MAPS full!";
									goto lCleanup;
									break;
								case -2:
									shutdownmessage = "Failed to create colourmap. Failed to allocate memory!";
									goto lCleanup;
									break;
								case -3:
									shutdownmessage = "Failed to create colourmap. Failed to create bitmap1";
									goto lCleanup;
									break;
								case -4:
									shutdownmessage = "Failed to create colourmap. Failed to create bitmap2";
									goto lCleanup;
									break;
							}
						}
					}
					break;
				case CMD_MODEL_PALETTE:
					// main palette for the entity under 24bit mode
					if(pixelformat!=PIXEL_x8) printf("Warning: command '%s' is not available under 8bit mode\n", command);
					else if(newchar->palette==NULL)
					{
						value = GET_ARG(1);
						if(stricmp(value, "none")==0){
							if(pixelformat==PIXEL_x8) nopalette = 1;
						}else{
							newchar->palette = malloc(PAL_BYTES);
							if(loadimagepalette(value, packfile, newchar->palette)==0) {
								shutdownmessage = "Failed to load palette!";
								goto lCleanup;
							}
						}
					}
					break;
				case CMD_MODEL_ALTERNATEPAL:
					// remap for the entity under 24bit mode, this method can replace remap command
					if(pixelformat!=PIXEL_x8) printf("Warning: command '%s' is not available under 8bit mode\n", command);
					else {
						__realloc(mapflag, newchar->maps_loaded);
						__realloc(newchar->colourmap, newchar->maps_loaded);
						value = GET_ARG(1);
						newchar->colourmap[newchar->maps_loaded] = malloc(PAL_BYTES);
						if(loadimagepalette(value, packfile, newchar->colourmap[newchar->maps_loaded])==0) {
							shutdownmessage = "Failed to load palette!";
							goto lCleanup;
						}
						newchar->maps_loaded++;
					}
					break;
				case CMD_MODEL_GLOBALMAP:
					// use global palette under 24bit mode, so some entity/panel/bg can still use palette feature, that saves some memory
					if(pixelformat!=PIXEL_x8) printf("Warning: command '%s' is not available under 8bit mode\n", command);
					else newchar->globalmap = GET_INT_ARG(1);
					break;
				case CMD_MODEL_ALPHA:
					newchar->alpha = GET_INT_ARG(1);
					break;
				case CMD_MODEL_REMOVE:
					newchar->remove = GET_INT_ARG(1);
					break;
				case CMD_MODEL_SCRIPT:
					//load the update script
					lcmHandleCommandScripts(&arglist, newchar->scripts->update_script, "updateentityscript", filename);
					break;
				case CMD_MODEL_THINKSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->think_script, "thinkscript", filename);
					break;
				case CMD_MODEL_TAKEDAMAGESCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->takedamage_script, "takedamagescript", filename);
					break;
				case CMD_MODEL_ONFALLSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onfall_script, "onfallscript", filename);
					break;
				case CMD_MODEL_ONPAINSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onpain_script, "onpainscript", filename);
					break;
				case CMD_MODEL_ONBLOCKSSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onblocks_script, "onblocksscript", filename);
					break;
				case CMD_MODEL_ONBLOCKWSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onblockw_script, "onblockwscript", filename);
					break;
				case CMD_MODEL_ONBLOCKOSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onblocko_script, "onblockoscript", filename);
					break;
				case CMD_MODEL_ONBLOCKZSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onblockz_script, "onblockzscript", filename);
					break;
				case CMD_MODEL_ONBLOCKASCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onblocka_script, "onblockascript", filename);
					break;
				case CMD_MODEL_ONMOVEXSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onmovex_script, "onmovexscript", filename);
					break;
				case CMD_MODEL_ONMOVEZSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onmovez_script, "onmovezscript", filename);
					break;
				case CMD_MODEL_ONMOVEASCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onmovea_script, "onmoveascript", filename);
					break;
				case CMD_MODEL_ONDEATHSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->ondeath_script, "ondeathscript", filename);
					break;
				case CMD_MODEL_ONKILLSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onkill_script, "onkillscript", filename);
					break;
				case CMD_MODEL_DIDBLOCKSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->didblock_script, "didblockscript", filename);
					break;
				case CMD_MODEL_ONDOATTACKSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->ondoattack_script, "ondoattackscript", filename);
					break;
				case CMD_MODEL_DIDHITSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->didhit_script, "didhitscript", filename);
					break;
				case CMD_MODEL_ONSPAWNSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->onspawn_script, "onspawnscript", filename);
					break;
				case CMD_MODEL_ANIMATIONSCRIPT:
					Script_Init(newchar->scripts->animation_script, "animationscript", filename, 0);
					if(!load_script(newchar->scripts->animation_script, GET_ARG(1))) {
						shutdownmessage = "Unable to load animation script!";
						goto lCleanup;
					}
					//dont compile, until at end of this function
					break;
				case CMD_MODEL_KEYSCRIPT:
					lcmHandleCommandScripts(&arglist, newchar->scripts->key_script, "entitykeyscript", filename);
					break;
				case CMD_MODEL_ANIM:
					{
						value = GET_ARG(1);
						frameset = 0;
						framecount = 0;
						// Create new animation
						newanim = alloc_anim();
						if(!newanim){
							shutdownmessage = "Not enough memory for animations!";
							goto lCleanup;
						}
						newanim->model_index = newchar->index;
						// Reset vars
						curframe = 0;
						memset(bbox, 0, sizeof(bbox));
						memset(abox, 0, sizeof(abox));
						memset(offset, 0, sizeof(offset));
						memset(shadow_coords, 0, sizeof(shadow_coords));
						memset(shadow_xz, 0, sizeof(shadow_xz));
						memset(platform, 0, sizeof(platform));
						shadow_set = 0;
						attack = emptyattack;
						attack.hitsound = SAMPLE_BEAT;
						attack.hitflash = -1;
						attack.blockflash = -1;
						attack.blocksound = -1;
						drawmethod = plainmethod;
						idle = 0;
						move = 0;
						movez = 0;
						movea = 0;
						seta = -1;
						frameshadow = -1;
						soundtoplay = -1;

						if(!newanim->range.xmin) newanim->range.xmin = -10;
						newanim->range.xmax = (int)newchar->jumpheight*20;    //30-12-2004 default range affected by jump height
						newanim->range.zmin = (int)-newchar->grabdistance/3;  //zmin
						newanim->range.zmax = (int)newchar->grabdistance/3;   //zmax
						newanim->range.amin = -1000;                          //amin
						newanim->range.amax = 1000;                           //amax
						newanim->range.bmin = -1000;                          //Base min.
						newanim->range.bmax = 1000;                           //Base max.

						newanim->jumpframe.v = 0;                           // Default disabled
						//newanim->fastattack = 0;
						newanim->energycost.mponly = 0;							//MP only.
						newanim->energycost.disable = 0;							//Disable flag.
						newanim->chargetime = 2;			// Default for backwards compatibility
						newanim->shootframe = -1;
						newanim->throwframe = -1;
						newanim->tossframe = -1;			// this get 1 of weapons numshots shots in the animation that you want(normaly the last)by tails
						newanim->jumpframe.f = -1;
						newanim->flipframe = -1;
						newanim->attackone = -1;
						newanim->dive = 0;
						newanim->followanim = 0;			// Default disabled
						newanim->followcond = 0;
						newanim->counterrange.framestart = -1;		//Start frame.
						newanim->counterrange.frameend = -1;		//End frame.
						newanim->counterrange.condition = 0;		//Counter cond.
						newanim->counterrange.damaged = 0;		//Counter damage.
						newanim->unsummonframe = -1;
						newanim->landframe.frame = -1;
						newanim->dropframe = -1;
						newanim->cancel = 0;  // OX. For cancelling anims into a freespecial. 0 by default , 3 when enabled. IMPORTANT!! Must stay as it is!
						newanim->animhits = 0; //OX counts hits on a per anim basis for cancels.
						newanim->subentity = newanim->custbomb = newanim->custknife = newanim->custstar = newanim->custpshotno = -1;
						newanim->quakeframe.framestart = 0;
						newanim->sync = -1;

						if(strnicmp(value, "idle", 4)==0 &&
						(!value[4] || (value[4] >= '1' && value[4]<='9'))){
								tempInt = atoi(value+4);
								if(tempInt<1) tempInt = 1;
								ani_id = animidles[tempInt-1];
						}
						else if(stricmp(value, "waiting")==0){
								ani_id = ANI_SELECT;
						}
						else if(strnicmp(value, "walk", 4)==0 &&
						(!value[4] || (value[4] >= '1' && value[4]<='9'))){
							tempInt = atoi(value+4);
							if(tempInt<1) tempInt = 1;
							ani_id = animwalks[tempInt-1];
							newanim->sync = ANI_WALK;
						}
						else if(stricmp(value, "sleep")==0){
							ani_id = ANI_SLEEP;
						}
						else if(stricmp(value, "run")==0){
							ani_id = ANI_RUN;
						}
						else if(strnicmp(value, "up", 2)==0 &&
						(!value[2] || (value[2] >= '1' && value[2]<='9'))){
							tempInt = atoi(value+2);
							if(tempInt<1) tempInt = 1;
							ani_id = animups[tempInt-1];
							newanim->sync = ANI_WALK;
						}
						else if(strnicmp(value, "down", 4)==0 &&
						(!value[4] || (value[4] >= '1' && value[4]<='9'))){
							tempInt = atoi(value+4);
							if(tempInt<1) tempInt = 1;
							ani_id = animdowns[tempInt-1];
							newanim->sync = ANI_WALK;
						}
						else if(strnicmp(value, "backwalk", 8)==0 &&
						(!value[8] || (value[8] >= '1' && value[8]<='9'))){
							tempInt = atoi(value+8);
							if(tempInt<1) tempInt = 1;
							ani_id = animbackwalks[tempInt-1];
							newanim->sync = ANI_WALK;
						}
						else if(stricmp(value, "jump")==0){
							ani_id = ANI_JUMP;
							newanim->range.xmin = 50;    // Used for enemies that jump on walls
							newanim->range.xmax = 60;    // Used for enemies that jump on walls
						}
						else if(stricmp(value, "duck")==0){
							ani_id = ANI_DUCK;
						}
						else if(stricmp(value, "land")==0){
							ani_id = ANI_LAND;
						}
						else if(stricmp(value, "pain")==0){
							ani_id = ANI_PAIN;
						}
						else if(strnicmp(value, "pain", 4)==0 && value[4]>='1' && value[4]<='9'){
							tempInt = atoi(value+4);
							if(tempInt==1){
								ani_id = ANI_PAIN;
							}
							else if(tempInt==2){
								ani_id = ANI_PAIN2;
							}
							else if(tempInt==3){
								ani_id = ANI_PAIN3;
							}
							else if(tempInt==4){
								ani_id = ANI_PAIN4;
							}
							else if(tempInt==5){
								ani_id = ANI_PAIN5;
							}
							else if(tempInt==6){
								ani_id = ANI_PAIN6;
							}
							else if(tempInt==7){
								ani_id = ANI_PAIN7;
							}
							else if(tempInt==8){
								ani_id = ANI_PAIN8;
							}
							else if(tempInt==9){
								ani_id = ANI_PAIN9;
							}
							else if(tempInt==10){
								ani_id = ANI_PAIN10;
							}
							else{
								if(tempInt<MAX_ATKS-STA_ATKS+1) tempInt = MAX_ATKS-STA_ATKS+1;
								ani_id = animpains[tempInt+STA_ATKS-1];
							}
						}
						else if(stricmp(value, "spain")==0){    // If shock attacks don't knock opponent down, play this
							ani_id = ANI_SHOCKPAIN;
						}
						else if(stricmp(value, "bpain")==0){    // If burn attacks don't knock opponent down, play this
							ani_id = ANI_BURNPAIN;
						}
						else if(stricmp(value, "fall")==0){
							ani_id = ANI_FALL;   // If no new animation, load fall animation into both "respawn" & "fall"
							newanim->bounce = 4;
						}
						else if(strnicmp(value, "fall", 4)==0 && value[4]>='1' && value[4]<='9'){
							tempInt = atoi(value+4);
							if(tempInt==1){
								ani_id = ANI_FALL;
							}
							else if(tempInt==2){
								ani_id = ANI_FALL2;
							}
							else if(tempInt==3){
								ani_id = ANI_FALL3;
							}
							else if(tempInt==4){
								ani_id = ANI_FALL4;
							}
							else if(tempInt==5){
								ani_id = ANI_FALL5;
							}
							else if(tempInt==6){
								ani_id = ANI_FALL6;
							}
							else if(tempInt==7){
								ani_id = ANI_FALL7;
							}
							else if(tempInt==8){
								ani_id = ANI_FALL8;
							}
							else if(tempInt==9){
								ani_id = ANI_FALL9;
							}
							else if(tempInt==10){
								ani_id = ANI_FALL10;
							}
							else{
								if(tempInt<MAX_ATKS-STA_ATKS+1) tempInt = MAX_ATKS-STA_ATKS+1;
								ani_id = animfalls[tempInt+STA_ATKS-1];
							}
							newanim->bounce = 4;
						}
						else if(stricmp(value, "shock")==0){    // If shock attacks do knock opponent down, play this
							ani_id = ANI_SHOCK;
							newanim->bounce = 4;
						}
						else if(stricmp(value, "burn")==0){    // If burn attacks do knock opponent down, play this
							ani_id = ANI_BURN;
							newanim->bounce = 4;
						}
						else if(stricmp(value, "death")==0){      //  If new animation is present, overwrite new_anim with it.
							ani_id = ANI_DIE;
						}
						else if(strnicmp(value, "death", 5)==0 && value[5]>='1' && value[5]<='9'){
							tempInt = atoi(value+5);
							if(tempInt==1){
								ani_id = ANI_DIE;
							}
							else if(tempInt==2){
								ani_id = ANI_DIE2;
							}
							else if(tempInt==3){
								ani_id = ANI_DIE3;
							}
							else if(tempInt==4){
								ani_id = ANI_DIE4;
							}
							else if(tempInt==5){
								ani_id = ANI_DIE5;
							}
							else if(tempInt==6){
								ani_id = ANI_DIE6;
							}
							else if(tempInt==7){
								ani_id = ANI_DIE7;
							}
							else if(tempInt==8){
								ani_id = ANI_DIE8;
							}
							else if(tempInt==9){
								ani_id = ANI_DIE9;
							}
							else if(tempInt==10){
								ani_id = ANI_DIE10;
							}
							else{
								if(tempInt<MAX_ATKS-STA_ATKS+1) tempInt = MAX_ATKS-STA_ATKS+1;
								ani_id = animdies[tempInt+STA_ATKS-1];
							}
						}
						else if(stricmp(value, "sdie")==0){
							ani_id = ANI_SHOCKDIE;
						}
						else if(stricmp(value, "bdie")==0){
							ani_id = ANI_BURNDIE;
						}
						else if(stricmp(value, "chipdeath")==0){
							ani_id = ANI_CHIPDEATH;
						}
						else if(stricmp(value, "guardbreak")==0){
							ani_id = ANI_GUARDBREAK;
						}
						else if(stricmp(value, "riseb")==0){
							ani_id = ANI_RISEB;
						}


						else if(stricmp(value, "rises")==0){
							ani_id = ANI_RISES;
						}
						else if(stricmp(value, "rise")==0){
							ani_id = ANI_RISE;   // If no new animation, load fall animation into both "respawn" & "fall"
						}
						else if(strnicmp(value, "rise", 4)==0 && value[4]>='1' && value[4]<='9'){
							tempInt = atoi(value+4);
							if(tempInt==1){
								ani_id = ANI_RISE;
							}
							else if(tempInt==2){
								ani_id = ANI_RISE2;
							}
							else if(tempInt==3){
								ani_id = ANI_RISE3;
							}
							else if(tempInt==4){
								ani_id = ANI_RISE4;
							}
							else if(tempInt==5){
								ani_id = ANI_RISE5;
							}
							else if(tempInt==6){
								ani_id = ANI_RISE6;
							}
							else if(tempInt==7){
								ani_id = ANI_RISE7;
							}
							else if(tempInt==8){
								ani_id = ANI_RISE8;
							}
							else if(tempInt==9){
								ani_id = ANI_RISE9;
							}
							else if(tempInt==10){
								ani_id = ANI_RISE10;
							}
							else{
								if(tempInt<MAX_ATKS-STA_ATKS+1) tempInt = MAX_ATKS-STA_ATKS+1;
								ani_id = animrises[tempInt+STA_ATKS-1];
							}
						}
						else if(stricmp(value, "riseattackb")==0){
							ani_id = ANI_RISEATTACKB;
						}
						else if(stricmp(value, "riseattacks")==0){
							ani_id = ANI_RISEATTACKS;
						}
						else if(stricmp(value, "riseattack")==0){
							ani_id = ANI_RISEATTACK;   // If no new animation, load fall animation into both "respawn" & "fall"
						}
						else if(strnicmp(value, "riseattack", 10)==0 && value[10]>='1' && value[10]<='9'){
							tempInt = atoi(value+10);
							if(tempInt==1){
								ani_id = ANI_RISEATTACK;
							}
							else if(tempInt==2){
								ani_id = ANI_RISEATTACK2;
							}
							else if(tempInt==3){
								ani_id = ANI_RISEATTACK3;
							}
							else if(tempInt==4){
								ani_id = ANI_RISEATTACK4;
							}
							else if(tempInt==6){
								ani_id = ANI_RISEATTACK5;
							}
							else if(tempInt==6){
								ani_id = ANI_RISEATTACK6;
							}
							else if(tempInt==7){
								ani_id = ANI_RISEATTACK7;
							}
							else if(tempInt==8){
								ani_id = ANI_RISEATTACK8;
							}
							else if(tempInt==9){
								ani_id = ANI_RISEATTACK9;
							}
							else if(tempInt==10){
								ani_id = ANI_RISEATTACK10;
							}
							else{
								if(tempInt<MAX_ATKS-STA_ATKS+1) tempInt = MAX_ATKS-STA_ATKS+1;
								ani_id = animriseattacks[tempInt+STA_ATKS-1];
							}
						}
						else if(stricmp(value, "select")==0){
							ani_id = ANI_PICK;
						}
						else if(strnicmp(value, "attack", 6)==0 &&
							(!value[6] || (value[6] >= '1' && value[6]<='9')))
						{
							tempInt = atoi(value+6);
							if(tempInt<1) tempInt = 1;
							ani_id = animattacks[tempInt-1];
						}
						else if(stricmp(value, "throwattack")==0){
							ani_id = ANI_THROWATTACK;
						}
						else if(stricmp(value, "upper")==0){
							ani_id = ANI_UPPER;
							attack.counterattack = 100; //default to 100
							newanim->range.xmin = -10;
							newanim->range.xmax = 120;
						}
						else if(stricmp(value, "cant")==0){
							ani_id = ANI_CANT;
						}
						else if(stricmp(value, "jumpcant")==0){
							ani_id = ANI_JUMPCANT;
						}
						else if(stricmp(value, "charge")==0){
							ani_id = ANI_CHARGE;
						}
						else if(stricmp(value, "faint")==0){
							ani_id = ANI_FAINT;
						}
						else if(stricmp(value, "dodge")==0){
							ani_id = ANI_DODGE;
						}
						else if(stricmp(value, "special")==0 || stricmp(value, "special1")==0){
							ani_id = ANI_SPECIAL;
							newanim->energycost.cost = 6;
						}
						else if(stricmp(value, "special2")==0){
							ani_id = ANI_SPECIAL2;
						}
						else if(stricmp(value, "special3")==0 || stricmp(value, "jumpspecial")==0){
							ani_id = ANI_JUMPSPECIAL;
						}
						else if(strnicmp(value, "freespecial", 11)==0 && (!value[11] || (value[11] >= '1' && value[11] <= '9'))){
							tempInt = atoi(value+11);
							if(tempInt<1) tempInt = 1;
							ani_id = animspecials[tempInt-1];
						}
						else if(stricmp(value, "jumpattack")==0){
							ani_id = ANI_JUMPATTACK;
							if(newchar->jumpheight==4)
							{
								newanim->range.xmin = 150;
								newanim->range.xmax = 200;
							}
						}
						else if(stricmp(value, "jumpattack2")==0){
							ani_id = ANI_JUMPATTACK2;
						}
						else if(stricmp(value, "jumpattack3")==0){
							ani_id = ANI_JUMPATTACK3;
						}
						else if(stricmp(value, "jumpforward")==0){
							ani_id = ANI_JUMPFORWARD;
						}
						else if(stricmp(value, "runjumpattack")==0){
							ani_id = ANI_RUNJUMPATTACK;
						}
						else if(stricmp(value, "runattack")==0){
							ani_id = ANI_RUNATTACK;    // New attack for when a player is running
						}
						else if(stricmp(value, "attackup")==0){
							ani_id = ANI_ATTACKUP;    // New attack for when a player presses u u
						}
						else if(stricmp(value, "attackdown")==0){
							ani_id = ANI_ATTACKDOWN;    // New attack for when a player presses d d
						}
						else if(stricmp(value, "attackforward")==0){
							ani_id = ANI_ATTACKFORWARD;    // New attack for when a player presses f f
						}
						else if(stricmp(value, "attackbackward")==0){
							ani_id = ANI_ATTACKBACKWARD;    // New attack for when a player presses b a
						}
						else if(stricmp(value, "attackboth")==0){    // Attack that is executed by holding down j and pressing a
							ani_id = ANI_ATTACKBOTH;
						}
						else if(stricmp(value, "get")==0){
							ani_id = ANI_GET;
						}
						else if(stricmp(value, "grab")==0){
							ani_id = ANI_GRAB;
						}
						else if(stricmp(value, "grabwalk")==0){
							ani_id = ANI_GRABWALK;
							newanim->sync = ANI_GRABWALK;
						}
						else if(stricmp(value, "grabwalkup")==0){
							ani_id = ANI_GRABWALKUP;
							newanim->sync = ANI_GRABWALK;
						}
						else if(stricmp(value, "grabwalkdown")==0){
							ani_id = ANI_GRABWALKDOWN;
							newanim->sync = ANI_GRABWALK;
						}
						else if(stricmp(value, "grabbackwalk")==0){
							ani_id = ANI_GRABBACKWALK;
							newanim->sync = ANI_GRABWALK;
						}
						else if(stricmp(value, "grabturn")==0){
							ani_id = ANI_GRABTURN;
						}
						else if(stricmp(value, "grabbed")==0){    // New grabbed animation for when grabbed
							ani_id = ANI_GRABBED;
						}
						else if(stricmp(value, "grabbedwalk")==0){    // New animation for when grabbed and forced to walk
							ani_id = ANI_GRABBEDWALK;
							newanim->sync = ANI_GRABBEDWALK;
						}
						else if(stricmp(value, "grabbedwalkup")==0){
							ani_id = ANI_GRABWALKUP;
							newanim->sync = ANI_GRABBEDWALK;
						}
						else if(stricmp(value, "grabbedwalkdown")==0){
							ani_id = ANI_GRABWALKDOWN;
							newanim->sync = ANI_GRABBEDWALK;
						}
						else if(stricmp(value, "grabbedbackwalk")==0){
							ani_id = ANI_GRABBEDBACKWALK;
							newanim->sync = ANI_GRABBEDWALK;
						}
						else if(stricmp(value, "grabbedturn")==0){
							ani_id = ANI_GRABBEDTURN;
						}
						else if(stricmp(value, "grabattack")==0){
							ani_id = ANI_GRABATTACK;
							newanim->attackone = 1; // default to 1, attack one one opponent
						}
						else if(stricmp(value, "grabattack2")==0){
							ani_id = ANI_GRABATTACK2;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabforward")==0){    // New grab attack for when pressing forward attack
							ani_id = ANI_GRABFORWARD;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabforward2")==0){    // New grab attack for when pressing forward attack
							ani_id = ANI_GRABFORWARD2;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabbackward")==0){    // New grab attack for when pressing backward attack
							ani_id = ANI_GRABBACKWARD;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabbackward2")==0){    // New grab attack for when pressing backward attack
							ani_id = ANI_GRABBACKWARD2;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabup")==0){    // New grab attack for when pressing up attack
							ani_id = ANI_GRABUP;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabup2")==0){    // New grab attack for when pressing up attack
							ani_id = ANI_GRABUP2;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabdown")==0){    // New grab attack for when pressing down attack
							ani_id = ANI_GRABDOWN;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "grabdown2")==0){    // New grab attack for when pressing down attack
							ani_id = ANI_GRABDOWN2;
							newanim->attackone = 1;
						}
						else if(stricmp(value, "spawn")==0){      //  spawn/respawn works separately now
							ani_id = ANI_SPAWN;
						}
						else if(stricmp(value, "respawn")==0){      //  spawn/respawn works separately now
							ani_id = ANI_RESPAWN;
						}
						else if(stricmp(value, "throw")==0){
							ani_id = ANI_THROW;
						}
						else if(stricmp(value, "block")==0){    // Now enemies can block attacks on occasion
							ani_id = ANI_BLOCK;
							newanim->range.xmin = 1;
							newanim->range.xmax = 100;
						}
						else if(strnicmp(value, "follow", 6)==0 && (!value[6] || (value[6]>='1' && value[6]<='9'))){
							tempInt = atoi(value+6);
							if(tempInt<1) tempInt = 1;
							ani_id = animfollows[tempInt-1];
						}
						else if(stricmp(value, "chargeattack")==0){
							ani_id = ANI_CHARGEATTACK;
						}
						else if(stricmp(value, "vault")==0){
							ani_id = ANI_VAULT;
						}
						else if(stricmp(value, "turn")==0){
							ani_id = ANI_TURN;
						}
						else if(stricmp(value, "forwardjump")==0){
							ani_id = ANI_FORWARDJUMP;
						}
						else if(stricmp(value, "runjump")==0){
							ani_id = ANI_RUNJUMP;
						}
						else if(stricmp(value, "jumpland")==0){
							ani_id = ANI_JUMPLAND;
						}
						else if(stricmp(value, "jumpdelay")==0){
							ani_id = ANI_JUMPDELAY;
						}
						else if(stricmp(value, "hitwall")==0){
							ani_id = ANI_HITWALL;
						}
						else if(stricmp(value, "slide")==0){
							ani_id = ANI_SLIDE;
						}
						else if(stricmp(value, "runslide")==0){
							ani_id = ANI_RUNSLIDE;
						}
						else if(stricmp(value, "blockpainb")==0){
							ani_id = ANI_BLOCKPAINB;
						}
						else if(stricmp(value, "blockpains")==0){
							ani_id = ANI_BLOCKPAINS;
						}
						else if(stricmp(value, "blockpain")==0){
							ani_id = ANI_BLOCKPAIN;   // If no new animation, load fall animation into both "respawn" & "fall"
						}
						else if(strnicmp(value, "blockpain", 9)==0 && value[9]>='1' && value[9]<='9'){
							tempInt = atoi(value+9);
							if(tempInt==1){
								ani_id = ANI_BLOCKPAIN;
							}
							else if(tempInt==2){
								ani_id = ANI_BLOCKPAIN2;
							}
							else if(tempInt==3){
								ani_id = ANI_BLOCKPAIN3;
							}
							else if(tempInt==4){
								ani_id = ANI_BLOCKPAIN4;
							}
							else if(tempInt==5){
								ani_id = ANI_BLOCKPAIN5;
							}
							else if(tempInt==6){
								ani_id = ANI_BLOCKPAIN6;
							}
							else if(tempInt==7){
								ani_id = ANI_BLOCKPAIN7;
							}
							else if(tempInt==8){
								ani_id = ANI_BLOCKPAIN8;
							}
							else if(tempInt==9){
								ani_id = ANI_BLOCKPAIN9;
							}
							else if(tempInt==10){
								ani_id = ANI_BLOCKPAIN10;
							}
							else{
								if(tempInt<MAX_ATKS-STA_ATKS+1) tempInt = MAX_ATKS-STA_ATKS+1;
								ani_id = animblkpains[tempInt+STA_ATKS-1];
							}
						}
						else if(stricmp(value, "duckattack")==0){
							ani_id = ANI_DUCKATTACK;
						}
						else if(stricmp(value, "walkoff")==0){
							ani_id = ANI_WALKOFF;
						}
						else {
							shutdownmessage = "Invalid animation name!";
							goto lCleanup;
						}

						newchar->animation[ani_id] = newanim;
					}
					break;
				case CMD_MODEL_LOOP:
					if(!newanim) {
						shutdownmessage = "Can't set loop: no animation specified!";
						goto lCleanup;
					}
					newanim->loop.mode          = GET_INT_ARG(1); //0 = Off, 1 = on.
					newanim->loop.framestart    = GET_INT_ARG(2); //Loop to frame.
					newanim->loop.frameend      = GET_INT_ARG(3); //Loop end frame.
					break;
				case CMD_MODEL_ANIMHEIGHT:
					newanim->height = GET_INT_ARG(1);
					break;
				case CMD_MODEL_DELAY:
					delay = GET_INT_ARG(1);
					break;
				case CMD_MODEL_OFFSET:
					offset[0] = GET_INT_ARG(1);
					offset[1] = GET_INT_ARG(2);
					break;
				case CMD_MODEL_SHADOWCOORDS:
					shadow_xz[0] = GET_INT_ARG(1);
					shadow_xz[1] = GET_INT_ARG(2);
					shadow_set=1;
					break;
				case CMD_MODEL_ENERGYCOST: case CMD_MODEL_MPCOST:
					newanim->energycost.cost    = GET_INT_ARG(1);
					newanim->energycost.mponly  = GET_INT_ARG(2);
					newanim->energycost.disable = GET_INT_ARG(3);
					break;
				case CMD_MODEL_MPONLY:
					newanim->energycost.mponly = GET_INT_ARG(1);
					break;
				case CMD_MODEL_CHARGETIME:
					newanim->chargetime = GET_FLOAT_ARG(1);
					break;
				case CMD_MODEL_ATTACKONE:
					newanim->attackone = GET_INT_ARG(1);
					break;
				case CMD_MODEL_COUNTERATTACK:
					attack.counterattack = GET_INT_ARG(1);
					break;
				case CMD_MODEL_THROWFRAME:	case CMD_MODEL_PSHOTFRAME: case CMD_MODEL_PSHOTFRAMEW: case CMD_MODEL_PSHOTFRAMENO:
					newanim->throwframe = GET_FRAME_ARG(1);
					newanim->throwa = GET_INT_ARG(2);
					if(!newanim->throwa)
						newanim->throwa = 70;
					else if(newanim->throwa == -1)
						newanim->throwa = 0;
					break;
				case CMD_MODEL_SHOOTFRAME:
					newanim->shootframe = GET_FRAME_ARG(1);
					newanim->throwa = GET_INT_ARG(2);
					if(newanim->throwa == -1)
						newanim->throwa = 0;
					break;
				case CMD_MODEL_TOSSFRAME: case CMD_MODEL_PBOMBFRAME:
					newanim->tossframe = GET_FRAME_ARG(1);
					newanim->throwa = GET_INT_ARG(2);
					if(newanim->throwa < 0) newanim->throwa = -1;
					break;
				case CMD_MODEL_CUSTKNIFE: case CMD_MODEL_CUSTPSHOT: case CMD_MODEL_CUSTPSHOTW:
					newanim->custknife= get_cached_model_index(GET_ARG(1));
					break;
				case CMD_MODEL_CUSTPSHOTNO:
					newanim->custpshotno= get_cached_model_index(GET_ARG(1));
					break;
				case CMD_MODEL_CUSTBOMB: case CMD_MODEL_CUSTPBOMB:
					newanim->custbomb= get_cached_model_index(GET_ARG(1));
					break;
				case CMD_MODEL_CUSTSTAR:
					newanim->custstar= get_cached_model_index(GET_ARG(1));
					break;

				// UT: merge dive and jumpframe, because they can't be used at the same time
				case CMD_MODEL_DIVE:	//dive kicks
					newanim->dive = 1;
					newanim->jumpframe.f = 0;
					newanim->jumpframe.x = GET_FLOAT_ARG(1);
					newanim->jumpframe.v = -GET_FLOAT_ARG(2);
					newanim->jumpframe.ent = -1;
					break;
				case CMD_MODEL_DIVE1:
					newanim->dive = 1;
					newanim->jumpframe.f = 0;
					newanim->jumpframe.x = GET_FLOAT_ARG(1);
					newanim->jumpframe.ent = -1;
					break;
				case CMD_MODEL_DIVE2:
					newanim->dive = 1;
					newanim->jumpframe.f = 0;
					newanim->jumpframe.v = -GET_FLOAT_ARG(1);
					newanim->jumpframe.ent = -1;
					break;
				case CMD_MODEL_JUMPFRAME:
					{
						newanim->jumpframe.f    = GET_FRAME_ARG(1);   //Frame.
						newanim->jumpframe.v    = GET_FLOAT_ARG(2); //Vertical velocity.
						value = GET_ARG(3);
						if(value[0])
						{
							newanim->jumpframe.x = GET_FLOAT_ARG(3);
							newanim->jumpframe.z = GET_FLOAT_ARG(4);
						}
						else // k, only for backward compatibility :((((((((((((((((
						{
							if(newanim->jumpframe.v <= 0)
							{
								if(newchar->type == TYPE_PLAYER)
								{
									newanim->jumpframe.v = newchar->jumpheight / 2;
									newanim->jumpframe.z = 0;
									newanim->jumpframe.x = 2;
								}
								else
								{
									newanim->jumpframe.v = newchar->jumpheight;
									newanim->jumpframe.z = newanim->jumpframe.x = 0;
								}
							}
							else
							{
								if(newchar->type != TYPE_ENEMY && newchar->type != TYPE_NPC)
									newanim->jumpframe.z = newanim->jumpframe.x = 0;
								else
								{
									newanim->jumpframe.z = 0;
									newanim->jumpframe.x = (float)1.3;
								}
							}
						}

						value = GET_ARG(5);
						if(value[0]) newanim->jumpframe.ent = get_cached_model_index(value);
						else newanim->jumpframe.ent = -1;

					}
					break;
				case CMD_MODEL_BOUNCEFACTOR:
					newanim->bounce = GET_FLOAT_ARG(1);
					break;
				case CMD_MODEL_LANDFRAME:
					newanim->landframe.frame = GET_FRAME_ARG(1);
					value = GET_ARG(2);
					if(value[0]) newanim->landframe.ent = get_cached_model_index(value);
					else newanim->landframe.ent = -1;
					break;
				case CMD_MODEL_DROPFRAME:
					newanim->dropframe = GET_FRAME_ARG(1);
					break;
				case CMD_MODEL_CANCEL:
					{
						int i, t;
						alloc_specials(newchar);
						newanim->cancel = 3;
						for(i = 0, t = 4; i < MAX_SPECIAL_INPUTS-6; i++, t++)
						{
							value = GET_ARG(t);
							if(!value[0]) break;
							if(stricmp(value, "u")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_MOVEUP;
							}
							else if(stricmp(value, "d")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_MOVEDOWN;
							}
							else if(stricmp(value, "f")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_FORWARD;
							}
							else if(stricmp(value, "b")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_BACKWARD;
							}
							else if(stricmp(value, "a")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK;
							}
							else if(stricmp(value, "a2")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK2;
							}
							else if(stricmp(value, "a3")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK3;
							}
							else if(stricmp(value, "a4")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_ATTACK4;
							}
							else if(stricmp(value, "j")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_JUMP;
							}
							else if(stricmp(value, "s")==0 || stricmp(value, "k")==0){
								newchar->special[newchar->specials_loaded].input[i] = FLAG_SPECIAL;
							}
							else if(strnicmp(value, "freespecial", 11)==0 && (!value[11] || (value[11] >= '1' && value[11] <= '9'))){
								tempInt = atoi(value+11);
								if(tempInt<1) tempInt = 1;
								newchar->special[newchar->specials_loaded].anim = animspecials[tempInt-1];
								newchar->special[newchar->specials_loaded].startframe = GET_INT_ARG(1); // stores start frame
								newchar->special[newchar->specials_loaded].endframe = GET_INT_ARG(2); // stores end frame
								newchar->special[newchar->specials_loaded].cancel = ani_id;                    // stores current anim
								newchar->special[newchar->specials_loaded].hits = GET_INT_ARG(3);// stores hits
							}
							else {
								shutdownmessage = "Invalid cancel command!";
								goto lCleanup;
							}
						}
						newchar->special[newchar->specials_loaded].steps = i-1; // max steps
						newchar->specials_loaded++;
					}
					break;
				case CMD_MODEL_SOUND:
					soundtoplay = sound_load_sample(GET_ARG(1), packfile, 0);
					break;
				case CMD_MODEL_HITFX:
					if(stricmp(GET_ARG(1),"none")==0) attack.hitsound=-1;
					else attack.hitsound = sound_load_sample(GET_ARG(1), packfile, 0);
					break;
				case CMD_MODEL_HITFLASH:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) attack.hitflash = -1;
					else attack.hitflash = get_cached_model_index(value);
					break;
				case CMD_MODEL_BLOCKFLASH:
					value = GET_ARG(1);
					if(stricmp(value, "none")==0) attack.blockflash = -1;
					else attack.blockflash = get_cached_model_index(value);
					break;
				case CMD_MODEL_BLOCKFX:
					attack.blocksound = sound_load_sample(GET_ARG(1), packfile, 0);
					break;
				case CMD_MODEL_FASTATTACK:
					if(GET_INT_ARG(1))
						attack.pain_time = GAME_SPEED/20;
					break;
				case CMD_MODEL_BBOX:
					bbox[0] = GET_INT_ARG(1);
					bbox[1] = GET_INT_ARG(2);
					bbox[2] = GET_INT_ARG(3);
					bbox[3] = GET_INT_ARG(4);
					bbox[4] = GET_INT_ARG(5);
					bbox[5] = GET_INT_ARG(6);
					break;
				case CMD_MODEL_BBOXZ:
					bbox[4] = GET_INT_ARG(1);
					bbox[5] = GET_INT_ARG(2);
					break;
				case CMD_MODEL_PLATFORM:
					newchar->hasPlatforms=1;
					//for(i=0;(GET_ARG(i+1)[0]; i++);
					for(i=0;i<arglist.count && arglist.args[i] && arglist.args[i][0];i++);
					if(i<8)
					{
						for(i=0;i<6; i++) platform[i+2] = GET_FLOAT_ARG(i+1);
						platform[0] = 99999;
					}
					else for(i=0; i<8; i++) platform[i] = GET_FLOAT_ARG(i+1);
					break;
				case CMD_MODEL_DRAWMETHOD:
					value = GET_ARG(1);
					if(isNumeric(value))
					{
						// special effects
						drawmethod.scalex = GET_INT_ARG(1);
						drawmethod.scaley = GET_INT_ARG(2);
						drawmethod.flipx = GET_INT_ARG(3);
						drawmethod.flipy = GET_INT_ARG(4);
						drawmethod.shiftx = GET_INT_ARG(5);
						drawmethod.alpha = GET_INT_ARG(6);
						drawmethod.remap = GET_INT_ARG(7);
						drawmethod.fillcolor = parsecolor(GET_ARG(8));
						drawmethod.rotate = GET_INT_ARG(9);
						drawmethod.fliprotate = GET_INT_ARG(10);
					}
					else if (0==stricmp(value, "scale"))
					{
						drawmethod.scalex = GET_FLOAT_ARG(2)*256;
						drawmethod.scaley = arglist.count>3?GET_FLOAT_ARG(3)*256:drawmethod.scalex;
					}
					else if (0==stricmp(value, "scalex"))
					{
						drawmethod.scalex = GET_FLOAT_ARG(2)*256;
					}
					else if (0==stricmp(value, "scaley"))
					{
						drawmethod.scaley = GET_FLOAT_ARG(2)*256;
					}
					else if (0==stricmp(value, "flipx"))
					{
						drawmethod.flipx = GET_INT_ARG(2);
					}
					else if (0==stricmp(value, "flipy"))
					{
						drawmethod.flipy = GET_INT_ARG(2);
					}
					else if (0==stricmp(value, "shiftx"))
					{
						drawmethod.shiftx = GET_FLOAT_ARG(2)*256;
					}
					else if (0==stricmp(value, "rotate"))
					{
						drawmethod.rotate = GET_INT_ARG(2);
					}
					else if (0==stricmp(value, "fliprotate"))
					{
						drawmethod.fliprotate = GET_INT_ARG(2);
					}
					else if (0==stricmp(value, "fillcolor"))
					{
						drawmethod.fliprotate = parsecolor(GET_ARG(2));
					}
					else if (0==stricmp(value, "remap"))
					{
						drawmethod.remap = GET_INT_ARG(2);
					}
					else if (0==stricmp(value, "channel"))
					{
						drawmethod.channelr = GET_FLOAT_ARG(2)*255;
						drawmethod.channelg = arglist.count>3?GET_FLOAT_ARG(3)*255:drawmethod.channelr;
						drawmethod.channelb = arglist.count>4?GET_FLOAT_ARG(4)*255:drawmethod.channelr;
					}
					else if (0==stricmp(value, "channelr"))
					{
						drawmethod.channelr = GET_FLOAT_ARG(2)*255;
					}
					else if (0==stricmp(value, "channelg"))
					{
						drawmethod.channelg = GET_FLOAT_ARG(2)*255;
					}
					else if (0==stricmp(value, "channelb"))
					{
						drawmethod.channelb = GET_FLOAT_ARG(2)*255;
					}
					else if (0==stricmp(value, "tintmode"))
					{
						drawmethod.tintmode = GET_INT_ARG(2);
					}
					else if (0==stricmp(value, "tintcolor"))
					{
						drawmethod.tintcolor = parsecolor(GET_ARG(2));
					}
					else if (0==stricmp(value, "alpha"))
					{
						drawmethod.alpha = GET_INT_ARG(2);
					}
					if(drawmethod.scalex<0) {drawmethod.scalex = -drawmethod.scalex;drawmethod.flipx = !drawmethod.flipx;}
					if(drawmethod.scaley<0) {drawmethod.scaley = -drawmethod.scaley;drawmethod.flipy = !drawmethod.flipy;}
					if(drawmethod.rotate)
					{
						drawmethod.rotate = (drawmethod.rotate%360 + 360)%360;
					}
					if(!blendfx_is_set)
					{
						if(drawmethod.alpha>0 && drawmethod.alpha<=MAX_BLENDINGS)
						{
							blendfx[drawmethod.alpha-1] = 1;
						}
					}
					drawmethod.flag = 1;
					break;
				case CMD_MODEL_NODRAWMETHOD:
					//disable special effects
					drawmethod.flag = 0;
					break;
				case CMD_MODEL_ATTACK: case CMD_MODEL_ATTACK1:  case CMD_MODEL_ATTACK2: case CMD_MODEL_ATTACK3:
				case CMD_MODEL_ATTACK4: case CMD_MODEL_ATTACK5: case CMD_MODEL_ATTACK6: case CMD_MODEL_ATTACK7:
				case CMD_MODEL_ATTACK8: case CMD_MODEL_ATTACK9: case CMD_MODEL_ATTACK10:
				case CMD_MODEL_SHOCK: case CMD_MODEL_BURN: case CMD_MODEL_STEAL: case CMD_MODEL_FREEZE: case CMD_MODEL_ITEMBOX:
				case CMD_MODEL_ATTACK_ETC:
					abox[0] = GET_INT_ARG(1);
					abox[1] = GET_INT_ARG(2);
					abox[2] = GET_INT_ARG(3);
					abox[3] = GET_INT_ARG(4);
					attack.dropv[0] = default_model_dropv[0];
					attack.dropv[1] = default_model_dropv[1];
					attack.dropv[2] = default_model_dropv[2];
					attack.attack_force = GET_INT_ARG(5);

					attack.attack_drop = GET_INT_ARG(6);

					attack.no_block = GET_INT_ARG(7);
					attack.no_flash = GET_INT_ARG(8);
					attack.pause_add = GET_INT_ARG(9);
					attack.attack_coords[4] = GET_INT_ARG(10); // depth or z

					switch(cmd) {
						case CMD_MODEL_ATTACK: case CMD_MODEL_ATTACK1:
							attack.attack_type = ATK_NORMAL;
							break;
						case CMD_MODEL_ATTACK2:
							attack.attack_type  = ATK_NORMAL2;
							break;
						case CMD_MODEL_ATTACK3:
							attack.attack_type  = ATK_NORMAL3;
							break;
						case CMD_MODEL_ATTACK4:
							attack.attack_type  = ATK_NORMAL4;
							break;
						case CMD_MODEL_ATTACK5:
							attack.attack_type  = ATK_NORMAL5;
							break;
						case CMD_MODEL_ATTACK6:
							attack.attack_type  = ATK_NORMAL6;
							break;
						case CMD_MODEL_ATTACK7:
							attack.attack_type  = ATK_NORMAL7;
							break;
						case CMD_MODEL_ATTACK8:
							attack.attack_type  = ATK_NORMAL8;
							break;
						case CMD_MODEL_ATTACK9:
							attack.attack_type  = ATK_NORMAL9;
							break;
						case CMD_MODEL_ATTACK10:
							attack.attack_type  = ATK_NORMAL10;
							break;
						case CMD_MODEL_SHOCK:
							attack.attack_type  = ATK_SHOCK;
							break;
						case CMD_MODEL_BURN:
							attack.attack_type  = ATK_BURN;
							break;
						case CMD_MODEL_STEAL:
							attack.steal = 1;
							attack.attack_type  = ATK_STEAL;
							break;
						case CMD_MODEL_FREEZE:
							attack.attack_type  = ATK_FREEZE;
							attack.freeze = 1;
							attack.freezetime = GET_FLOAT_ARG(6) * GAME_SPEED;
							attack.forcemap = -1;
							attack.attack_drop = 0;
							break;
						case CMD_MODEL_ITEMBOX:
							attack.attack_type  = ATK_ITEM;
							break;
						default:
							tempInt = atoi(command+6);
							if(tempInt<MAX_ATKS-STA_ATKS+1)
								tempInt = MAX_ATKS-STA_ATKS+1;
							attack.attack_type = tempInt+STA_ATKS-1;
					}
					break;
				case CMD_MODEL_ATTACKZ: case CMD_MODEL_HITZ:
					attack.attack_coords[4] = GET_INT_ARG(1);
					attack.attack_coords[5] = GET_INT_ARG(2);
					break;
				case CMD_MODEL_BLAST:
					abox[0] = GET_INT_ARG(1);
					abox[1] = GET_INT_ARG(2);
					abox[2] = GET_INT_ARG(3);
					abox[3] = GET_INT_ARG(4);
					attack.dropv[0] = default_model_dropv[0];
					attack.dropv[1] = default_model_dropv[1]*2.083f;
					attack.dropv[2] = 0;
					attack.attack_force = GET_INT_ARG(5);
					attack.no_block = GET_INT_ARG(6);
					attack.no_flash = GET_INT_ARG(7);
					attack.pause_add = GET_INT_ARG(8);
					attack.attack_drop = 1;
					attack.attack_type = ATK_BLAST;
					attack.attack_coords[4] = GET_INT_ARG(9); // depth or z
					attack.blast = 1;
					break;
				case CMD_MODEL_DROPV:
					// drop velocity add if the target is knocked down
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->dropv[0] = GET_FLOAT_ARG(1); // height add
					pattack->dropv[1] = GET_FLOAT_ARG(2); // xdir add
					pattack->dropv[2] = GET_FLOAT_ARG(3); // zdir add
					break;
				case CMD_MODEL_OTG:
					// Over The Ground hit.
					attack.otg = GET_INT_ARG(1);
					break;
				case CMD_MODEL_JUGGLECOST:
					// if cost >= opponents jugglepoints , we can juggle
					attack.jugglecost = GET_INT_ARG(1);
					break;
				case CMD_MODEL_GUARDCOST:
					// if cost >= opponents guardpoints , opponent will play guardcrush anim
					attack.guardcost = GET_INT_ARG(1);
					break;
				case CMD_MODEL_STUN:
					//Like Freeze, but no auto remap.
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->freeze = 1;
					pattack->freezetime = GET_FLOAT_ARG(1) * GAME_SPEED;
					pattack->attack_drop = 0;
					break;
				case CMD_MODEL_GRABIN:
					// fake grab distanse efffect, not link
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->grab =  GET_INT_ARG(1);
					pattack->grab_distance = GET_FLOAT_ARG(2);
					break;
				case CMD_MODEL_NOREFLECT:
					// only cost target's hp, don't knock down or cause pain, unless the target is killed
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->no_pain = GET_INT_ARG(1);
					break;
				case CMD_MODEL_NOKILL:
					// don't kill the target, leave 1 hp
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->no_kill = GET_INT_ARG(1);
					break;
				case CMD_MODEL_FORCEDIRECTION:
					// the attack direction
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->force_direction = GET_INT_ARG(1);
					break;
				case CMD_MODEL_DAMAGEONLANDING:
					// fake throw damage on landing
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->damage_on_landing = GET_INT_ARG(1);
					pattack->blast = GET_INT_ARG(2);
					break;
				case CMD_MODEL_SEAL:
					// Disable special moves for specified time.
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->sealtime = GET_INT_ARG(1) * GAME_SPEED;
					pattack->seal = GET_INT_ARG(2);
					break;
				case CMD_MODEL_STAYDOWN:
					// Disable special moves for specified time.
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->staydown[0]    = GET_INT_ARG(1); //Risetime modifier.
					pattack->staydown[1]    = GET_INT_ARG(2); //Riseattack time addition and toggle.
					break;
				case CMD_MODEL_DOT:
					// Cause damage over time effect.
					attack.dot_index  = GET_INT_ARG(1);  //Index.
					attack.dot_time   = GET_INT_ARG(2);  //Time to expiration.
					attack.dot        = GET_INT_ARG(3);  //Mode, see common_dot.
					attack.dot_force  = GET_INT_ARG(4);  //Amount per tick.
					attack.dot_rate   = GET_INT_ARG(5);  //Tick delay.
					break;
				case CMD_MODEL_FORCEMAP:
					// force color map change for specified time
					pattack = (!newanim && newchar->smartbomb)?newchar->smartbomb:&attack;
					pattack->forcemap = GET_INT_ARG(1);
					pattack->maptime = GET_FLOAT_ARG(2) * GAME_SPEED;
					break;
				case CMD_MODEL_IDLE:
					idle = GET_INT_ARG(1);
					break;
				case CMD_MODEL_MOVE:
					move = GET_INT_ARG(1);
					break;
				case CMD_MODEL_MOVEZ:
					movez = GET_INT_ARG(1);
					break;
				case CMD_MODEL_MOVEA:
					movea = GET_INT_ARG(1);
					break;
				case CMD_MODEL_SETA:
					seta = GET_INT_ARG(1);
					break;
				case CMD_MODEL_FSHADOW:
					frameshadow = GET_INT_ARG(1);
					break;
				case CMD_MODEL_RANGE:
					if(!newanim) {
						shutdownmessage = "Cannot set range: no animation!";
						goto lCleanup;
					}
					newanim->range.xmin = GET_INT_ARG(1);
					newanim->range.xmax = GET_INT_ARG(2);
					if(newanim->range.xmin==newanim->range.xmax)
						newanim->range.xmin--;
					break;
				case CMD_MODEL_RANGEZ:
					if(!newanim) {
						shutdownmessage = "Cannot set rangez: no animation!";
						goto lCleanup;
					}
					newanim->range.zmin = GET_INT_ARG(1);
					newanim->range.zmax = GET_INT_ARG(2);
					break;
				case CMD_MODEL_RANGEA:
					if(!newanim) {
						shutdownmessage = "Cannot set rangea: no animation!";
						goto lCleanup;
					}
					newanim->range.amin = GET_INT_ARG(1);
					newanim->range.amax = GET_INT_ARG(2);
					break;
				case CMD_MODEL_RANGEB:
					if(!newanim) {
						shutdownmessage = "Cannot set rangeb: no animation!";
						goto lCleanup;
					}
					newanim->range.bmin = GET_INT_ARG(1);
					newanim->range.bmax = GET_INT_ARG(2);
					break;
				case CMD_MODEL_PATHFINDSTEP:
					newchar->pathfindstep = GET_FLOAT_ARG(1);
					break;
				case CMD_MODEL_FRAME:
					{
						if(!newanim) {
							shutdownmessage = "Cannot add frame: animation not specified!";
							goto lCleanup;
						}
						peek = 0;
						if(frameset && framecount>=0) framecount = -framecount;
						while(!frameset){
							value3 = findarg(buf+pos+peek, 0);
							if(stricmp(value3, "frame")==0) framecount++;
							if((stricmp(value3, "anim")==0) || (pos+peek >= size)) frameset = 1;
							// Go to next line
							while(buf[pos+peek] && buf[pos+peek]!='\n' && buf[pos+peek]!='\r') ++peek;
							while(buf[pos+peek]=='\n' || buf[pos+peek]=='\r') ++peek;
						}
						value = GET_ARG(1);
						//printf("frame count: %d\n",framecount);
						//printf("Load sprite '%s'...\n", value);
						index = loadsprite(value, offset[0], offset[1],nopalette?PIXEL_x8:PIXEL_8);//don't use palette for the sprite since it will one palette from the entity's remap list in 24bit mode
						if(pixelformat==PIXEL_x8 && !nopalette)
						{
							// for old mod just give it a default palette
							if(newchar->palette==NULL)
							{
								newchar->palette = malloc(PAL_BYTES);
								if(loadimagepalette(value, packfile, newchar->palette)==0) {
									shutdownmessage = "Failed to load palette!";
									goto lCleanup;
								}
							}
							if(index>=0 && !nopalette)
							{
								sprite_map[index].node->sprite->palette = newchar->palette;
								sprite_map[index].node->sprite->pixelformat = pixelformat;
							}
						}
						if((index>=0) && (maskindex>=0))
						{
							sprite_map[index].node->sprite->mask = sprite_map[maskindex].node->sprite;
							maskindex = -1;
						}
						// Adjust coords: add offsets and change size to coords
						bbox_con[0] = bbox[0] - offset[0];
						bbox_con[1] = bbox[1] - offset[1];
						bbox_con[2] = bbox[2] + bbox_con[0];
						bbox_con[3] = bbox[3] + bbox_con[1];
						bbox_con[4] = bbox[4];
						bbox_con[5] = bbox[5];
						if(bbox[5]>bbox[4])
						{
							bbox[4] -= offset[1];
							bbox[5] -= offset[1];
						}
						attack.attack_coords[0] = abox[0] - offset[0];
						attack.attack_coords[1] = abox[1] - offset[1];
						attack.attack_coords[2] = abox[2] + attack.attack_coords[0];
						attack.attack_coords[3] = abox[3] + attack.attack_coords[1];
						if(attack.attack_coords[5]>attack.attack_coords[4])
						{
							attack.attack_coords[4] -= offset[1];
							attack.attack_coords[5] -= offset[1];
						}
						//attack.attack_coords[4] = abox[4];
						if(platform[0]==99999) // old style
						{
							platform_con[0] = 0;
							platform_con[1] = 3;
							platform_con[2] = platform[2] - offset[0];
							platform_con[3] = platform[3] - offset[0];
							platform_con[4] = platform[4] - offset[0];
							platform_con[5] = platform[5] - offset[0];
							platform_con[6] = platform[6]+3;
						}
						else // wall style
						{
							platform_con[0] = platform[0] - offset[0];
							platform_con[1] = platform[1] - offset[1];
							platform_con[2] = platform[2];
							platform_con[3] = platform[3];
							platform_con[4] = platform[4];
							platform_con[5] = platform[5];
							platform_con[6] = platform[6];
						}
						platform_con[6] = platform[6];
						platform_con[7] = platform[7];
						if(shadow_set)
						{
							shadow_coords[0] = shadow_xz[0] - offset[0];
							shadow_coords[1] = shadow_xz[1] - offset[1];
						}
						else
						{
							shadow_coords[0] = shadow_coords[1] = 0;
						}

						curframe = addframe(newanim, index, framecount, delay, (unsigned char)idle,
								bbox_con, &attack, move, movez,
								movea, seta, platform_con, frameshadow, shadow_coords, soundtoplay, &drawmethod);

								memset(bbox_con, 0, sizeof(bbox_con));
								soundtoplay = -1;
					}
					break;
				case CMD_MODEL_ALPHAMASK:
					if(!newanim){
						shutdownmessage = "Cannot add alpha mask: animation not specified!";
						goto lCleanup;
					}
					if(maskindex>=0) {
						shutdownmessage = "Cannot add alpha mask: a mask has already been specified for this frame!";
						goto lCleanup;
					}
					value = GET_ARG(1);
					//printf("frame count: %d\n",framecount);
					//printf("Load sprite '%s'...\n", value);
					index = loadsprite(value, offset[0], offset[1],PIXEL_8);//don't use palette for the mask
					maskindex = index;
					break;
				case CMD_MODEL_FLIPFRAME:
					newanim->flipframe = GET_FRAME_ARG(1);
					break;
				case CMD_MODEL_FOLLOWANIM:
					newanim->followanim = GET_INT_ARG(1);
					if(newanim->followanim > max_follows) newanim->followanim = max_follows;
					if(newanim->followanim < 0) newanim->followanim = 0;
					break;
				case CMD_MODEL_FOLLOWCOND:
					newanim->followcond = GET_INT_ARG(1);
					break;
				case CMD_MODEL_COUNTERFRAME:
					newanim->counterrange.framestart    = GET_FRAME_ARG(1);
					newanim->counterrange.frameend	    = newanim->counterrange.framestart;
					newanim->counterrange.condition	    = GET_INT_ARG(2);
					newanim->counterrange.damaged	    = GET_INT_ARG(3);
					break;
				case CMD_MODEL_COUNTERRANGE:
					newanim->counterrange.framestart	= GET_FRAME_ARG(1);
					newanim->counterrange.frameend	    = GET_FRAME_ARG(2);
					newanim->counterrange.condition	    = GET_INT_ARG(3);
					newanim->counterrange.damaged	    = GET_INT_ARG(4);
					break;
				case CMD_MODEL_WEAPONFRAME:
					newanim->weaponframe    = malloc(2 * sizeof(newanim->weaponframe));
					memset(newanim->weaponframe, 0, 2 * sizeof(newanim->weaponframe));
					newanim->weaponframe[0] = GET_FRAME_ARG(1);
					newanim->weaponframe[1] = GET_INT_ARG(2);
					break;
				case CMD_MODEL_QUAKEFRAME:
					newanim->quakeframe.framestart  = GET_FRAME_ARG(1);
					newanim->quakeframe.repeat      = GET_INT_ARG(2);
					newanim->quakeframe.v           = GET_INT_ARG(3);
					newanim->quakeframe.cnt         = 0;
					break;
				case CMD_MODEL_SUBENTITY: case CMD_MODEL_CUSTENTITY:
					value = GET_ARG(1);
					if(value[0]) newanim->subentity = get_cached_model_index(value);
					break;
				case CMD_MODEL_SPAWNFRAME:
					newanim->spawnframe    = malloc(5 * sizeof(newanim->spawnframe));
					memset(newanim->spawnframe, 0, 5 * sizeof(newanim->spawnframe));
					newanim->spawnframe[0] = GET_FRAME_ARG(1);
					newanim->spawnframe[1] = GET_FLOAT_ARG(2);
					newanim->spawnframe[2] = GET_FLOAT_ARG(3);
					newanim->spawnframe[3] = GET_FLOAT_ARG(4);
					newanim->spawnframe[4] = GET_FLOAT_ARG(5);
					break;
				case CMD_MODEL_SUMMONFRAME:
					newanim->summonframe    = malloc(5 * sizeof(newanim->summonframe));
					memset(newanim->summonframe, 0, 5 * sizeof(newanim->summonframe));
					newanim->summonframe[0] = GET_FRAME_ARG(1);
					newanim->summonframe[1] = GET_FLOAT_ARG(2);
					newanim->summonframe[2] = GET_FLOAT_ARG(3);
					newanim->summonframe[3] = GET_FLOAT_ARG(4);
					newanim->summonframe[4] = GET_FLOAT_ARG(5);
					break;
				case CMD_MODEL_UNSUMMONFRAME:
					newanim->unsummonframe = GET_FRAME_ARG(1);
					break;
				case CMD_MODEL_AT_SCRIPT:
					if(!scriptbuf[0]){ // if empty, paste the main function text here
						buffer_append(&scriptbuf, pre_text, 0xffffff, &sbsize, &scriptlen);
					}
					scriptbuf[scriptlen - strlen(sur_text)] = 0; // cut last chars
					scriptlen = strlen(scriptbuf);
					if(ani_id>=0)
					{
						if(script_id != ani_id){ // if expression 1
							sprintf(namebuf, ifid_text, newanim->index);
							buffer_append(&scriptbuf, namebuf, 0xffffff, &sbsize, &scriptlen);
							script_id = ani_id;
						}
						scriptbuf[scriptlen - strlen(endifid_text)] = 0; // cut last chars
						scriptlen = strlen(scriptbuf);
					}
					while(strncmp(buf+pos, "@script", 7)){
						pos++;
					}
					pos += 7;
					len = 0;
					while(strncmp(buf+pos, "@end_script", 11)){
						len++; pos++;
					}
					buffer_append(&scriptbuf, buf+pos-len, len, &sbsize, &scriptlen);
					pos += 11;
					
					if(ani_id>=0)
					{
						buffer_append(&scriptbuf, endifid_text, 0xffffff, &sbsize, &scriptlen);// put back last  chars
					}
					buffer_append(&scriptbuf, sur_text, 0xffffff, &sbsize, &scriptlen);// put back last  chars
					break;
				case CMD_MODEL_AT_CMD:
					//translate @cmd into script function call
					if(ani_id < 0) {
						shutdownmessage = "command '@cmd' must follow an animation!";
						goto lCleanup;
					}
					if(!scriptbuf[0]){ // if empty, paste the main function text here
						buffer_append(&scriptbuf, pre_text, 0xffffff, &sbsize, &scriptlen);
					}
					scriptbuf[scriptlen - strlen(sur_text)] = 0; // cut last chars
					scriptlen = strlen(scriptbuf);
					if(script_id != ani_id){ // if expression 1
						sprintf(namebuf, ifid_text, newanim->index);
						buffer_append(&scriptbuf, namebuf, 0xffffff, &sbsize, &scriptlen);
						script_id = ani_id;
					}
					j = 1;
					value = GET_ARG(j);
					scriptbuf[scriptlen - strlen(endifid_text)] = 0; // cut last chars
					scriptlen = strlen(scriptbuf);
					if(value && value[0]){
						sprintf(namebuf, if_text, curframe);//only execute in current frame
						buffer_append(&scriptbuf, namebuf, 0xffffff, &sbsize, &scriptlen);
						sprintf(namebuf, call_text, value);
						buffer_append(&scriptbuf, namebuf, 0xffffff, &sbsize, &scriptlen);
						do{ //argument and comma
							j++;
							value = GET_ARG(j);
							if(value && value[0]) {
								if(j!=2) buffer_append(&scriptbuf, comma_text, 0xffffff, &sbsize, &scriptlen);
								buffer_append(&scriptbuf, value, 0xffffff, &sbsize, &scriptlen);
							}
						}while(value && value[0]);
					}
					buffer_append(&scriptbuf, endcall_text, 0xffffff, &sbsize, &scriptlen);
					buffer_append(&scriptbuf, endif_text, 0xffffff, &sbsize, &scriptlen);//end of if
					buffer_append(&scriptbuf, endifid_text, 0xffffff, &sbsize, &scriptlen); // put back last  chars
					buffer_append(&scriptbuf, sur_text, 0xffffff, &sbsize, &scriptlen); // put back last  chars
					break;
				default:
					if(command && command[0]) {
						if(!handle_txt_include(command, &arglist, &filename, fnbuf, &buf, &pos, &size))
							printf("Command '%s' not understood in file '%s'!\n", command, filename);
					}
			}

		}
		// Go to next line
		pos += getNewLineStart(buf + pos);
	}


	tempInt = 1;
	if(scriptbuf[0]) {
		//printf("\n%s\n", scriptbuf);
		if(!Script_IsInitialized(newchar->scripts->animation_script))
			Script_Init(newchar->scripts->animation_script, newchar->name, filename, 0);
		tempInt = Script_AppendText(newchar->scripts->animation_script, scriptbuf, filename);
		//Interpreter_OutputPCode(newchar->scripts->animation_script.pinterpreter, "code");
		writeToScriptLog("\n####animationscript function main#####\n# ");
		writeToScriptLog(filename);
		writeToScriptLog("\n########################################\n");
		writeToScriptLog(scriptbuf);
	}
	if(!newchar->isSubclassed)
		Script_Compile(newchar->scripts->animation_script);

	if(!tempInt)// parse script failed
	{
		shutdownmessage = "Error parsing function main of animation script in file '%s'!";
		goto lCleanup;
	}

	// We need a little more work to initialize the new A.I. types if they are not loaded from file
	if(newchar->aiattack==-1) newchar->aiattack = 0;
	if(newchar->aimove==-1) newchar->aimove = 0;
	//if(!newchar->offscreenkill) newchar->offscreenkill = 1000;

	//temporary patch for conflicting moves
	if(newchar->animation[ANI_FREESPECIAL] && !is_set(newchar, ANI_FREESPECIAL))
	{
		alloc_specials(newchar);
		newchar->special[newchar->specials_loaded].input[0] = FLAG_FORWARD;
		newchar->special[newchar->specials_loaded].input[1] = FLAG_FORWARD;
		newchar->special[newchar->specials_loaded].input[2] = FLAG_ATTACK;
		newchar->special[newchar->specials_loaded].anim = ANI_FREESPECIAL;
		newchar->special[newchar->specials_loaded].steps = 3;
		newchar->specials_loaded++;
	}
	if(newchar->animation[ANI_FREESPECIAL2] && !is_set(newchar, ANI_FREESPECIAL2))
	{
		alloc_specials(newchar);
		newchar->special[newchar->specials_loaded].input[0] = FLAG_MOVEDOWN;
		newchar->special[newchar->specials_loaded].input[1] = FLAG_MOVEDOWN;
		newchar->special[newchar->specials_loaded].input[2] = FLAG_ATTACK;
		newchar->special[newchar->specials_loaded].anim = ANI_FREESPECIAL2;
		newchar->special[newchar->specials_loaded].steps = 3;
		newchar->specials_loaded++;
	}
	if(newchar->animation[ANI_FREESPECIAL3] && !is_set(newchar, ANI_FREESPECIAL3))
	{
		alloc_specials(newchar);
		newchar->special[newchar->specials_loaded].input[0] = FLAG_MOVEUP;
		newchar->special[newchar->specials_loaded].input[1] = FLAG_MOVEUP;
		newchar->special[newchar->specials_loaded].input[2] = FLAG_ATTACK;
		newchar->special[newchar->specials_loaded].anim = ANI_FREESPECIAL3;
		newchar->special[newchar->specials_loaded].steps = 3;
		newchar->specials_loaded++;
	}

	if(newchar->risetime[0]==-1)
	{
		if(newchar->type==TYPE_PLAYER)
		{
			if(newchar->animation[ANI_RISEATTACK]) newchar->risetime[0] = GAME_SPEED/2;
			else newchar->risetime[0]=GAME_SPEED;
		}
		else if(newchar->type==TYPE_ENEMY || newchar->type==TYPE_NPC)
		{
			newchar->risetime[0] = 0;
		}
	}

	if(newchar->hostile<0) {// not been initialized, so initialize it
		switch (newchar->type){
		case TYPE_ENEMY:
			newchar->hostile = TYPE_PLAYER ;
			break;
		case TYPE_PLAYER: // dont really needed, since you don't need A.I. control for players
			newchar->hostile = TYPE_PLAYER | TYPE_ENEMY | TYPE_OBSTACLE;
			break;
		case TYPE_TRAP:
			newchar->hostile  = TYPE_ENEMY | TYPE_PLAYER;
		case TYPE_OBSTACLE:
			newchar->hostile = 0;
			break;
		case TYPE_SHOT:  // only target enemies
			newchar->hostile = TYPE_ENEMY ;
			break;
		case TYPE_NPC: // default npc behivior
			newchar->hostile = TYPE_ENEMY ;
			break;
		}
	}

	if(newchar->candamage<0) {// not been initialized, so initialize it
		switch (newchar->type){
		case TYPE_ENEMY:
			newchar->candamage = TYPE_PLAYER | TYPE_SHOT;
			if(newchar->subtype == SUBTYPE_ARROW) newchar->candamage |= TYPE_OBSTACLE;
			break;
		case TYPE_PLAYER:
			newchar->candamage = TYPE_PLAYER | TYPE_ENEMY | TYPE_OBSTACLE;
			break;
		case TYPE_TRAP:
			newchar->candamage  = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
		case TYPE_OBSTACLE:
			newchar->candamage = TYPE_PLAYER | TYPE_ENEMY | TYPE_OBSTACLE;
			break;
		case TYPE_SHOT:
			newchar->candamage = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
			break;
		case TYPE_NPC:
			newchar->candamage = TYPE_ENEMY | TYPE_OBSTACLE;
			break;
		case TYPE_ITEM:
			newchar->candamage = TYPE_PLAYER;
			break;
		}
	}

	if(newchar->projectilehit<0) {// not been initialized, so initialize it
		switch (newchar->type){
		case TYPE_ENEMY:
			newchar->projectilehit = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
			break;
		case TYPE_PLAYER:
			newchar->projectilehit = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
			break;
		case TYPE_TRAP: // hmm, don't really needed
			newchar->projectilehit  = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
		case TYPE_OBSTACLE: // hmm, don't really needed
			newchar->projectilehit = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
			break;
		case TYPE_SHOT: // hmm, don't really needed
			newchar->projectilehit = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
			break;
		case TYPE_NPC:
			newchar->projectilehit = TYPE_ENEMY | TYPE_PLAYER | TYPE_OBSTACLE;
			break;
		}
	}

	if(newchar->jumpspeed < 0) newchar->jumpspeed = MAX(newchar->speed, 1);

	if(blendfx_is_set==0)
	{
		if(newchar->alpha)
		{
			blendfx[newchar->alpha-1] = 1;
		}
		if(newchar->gfxshadow || newchar->shadow)
		{
			blendfx[BLEND_MULTIPLY] = 1;
		}
	}

	// we need to convert 8bit colourmap into 24bit palette
	if(pixelformat==PIXEL_x8)
	{
		convert_map_to_palette(newchar, mapflag);
	}

	printf("Loading '%s' from %s\n", newchar->name, filename);

	lCleanup:

	if(buf != NULL){
		free(buf);
		buf = NULL;
	}
	if(scriptbuf){
		free(scriptbuf);
		scriptbuf = NULL;
	}
	if(mapflag){
		free(mapflag);
		mapflag = NULL;
	}

	if(!shutdownmessage)
		return newchar;

	shutdown(1, "Fatal Error in load_cached_model, file: %s, line %d, message: %s\n", filename, line, shutdownmessage);
	return NULL;
}



int is_set(s_model * model, int m){    // New function to determine if a freespecial has been set
	int i;

	for(i = 0; i < model->specials_loaded; i++){
		if(model->special[i].anim == m){
			return 1;
		}
	}

	return 0;
}

int load_script_setting()
{
	char * filename = "data/script.txt";
	char *buf, *command;
	ptrdiff_t pos = 0;
	size_t size = 0;
	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";

	if(buffer_pakfile(filename, &buf, &size)!=1) return 0;

	while(pos<size)
	{
		if(ParseArgs(&arglist,buf+pos,argbuf)){
			command = GET_ARG(0);
			if(command && command[0])
			{
				if(stricmp(command, "maxscriptvars")==0) // each script can have a variable list that can be accessed by index
				{
					max_script_vars = GET_INT_ARG(1) ;
					if(max_script_vars<0) max_script_vars = 0;
				}
				else if(stricmp(command, "maxentityvars")==0) // each entity can have a variable list that can be accessed by index
				{
					max_entity_vars = GET_INT_ARG(1) ;
					if(max_entity_vars<0) max_entity_vars = 0;
				}
				else if(stricmp(command, "maxindexedvars")==0) // a global variable list that can be accessed by index
				{
					max_indexed_vars = GET_INT_ARG(1);
					if(max_indexed_vars<0) max_indexed_vars = 0;
				}
				else if(stricmp(command, "maxglobalvars")==0) // for global_var_list, default to 2048
				{
					max_global_vars = GET_INT_ARG(1);
					if(max_global_vars<0) max_global_vars = 0;
				}
				else if(stricmp(command, "keyscriptrate")==0) // Rate that keyscripts fire when holding a key.
				{
					keyscriptrate = GET_INT_ARG(1);
				}
				else if(stricmp(command, "alwaysupdate")==0) //execute update script whenever update() is called
				{
					alwaysupdate = GET_INT_ARG(1);
				}
			}
		}
		// Go to next line
	pos += getNewLineStart(buf + pos);
	}

	if(buf != NULL)
	{
		free(buf);
		buf = NULL;
	}
	return 1;
}

// Load / cache all models
int load_models()
{
	char filename[128] = "data/models.txt";
	int i;
	char *buf;
	size_t size;
	ptrdiff_t pos;
	char * command;
	int line = 0;

	char tmpBuff[128] = {""};
	int maxanim = MAX_ANIS; // temporary counter

	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";
	modelstxtCommands cmd;
	int modelLoadCount = 0;

	free_modelcache();

	if(isLoadingScreenTypeBg(loadingbg[0].set)) {
		// New alternative background path for PSP
		if(custBkgrds != NULL)
		{
			strcpy(tmpBuff,custBkgrds);
			strncat(tmpBuff,"loading", 7);
			load_background(tmpBuff, 0);
		}
		else load_background("data/bgs/loading", 0);
		standard_palette(1);
	}
	if(isLoadingScreenTypeBar(loadingbg[0].set)) {
		lifebar_colors();
		init_colourtable();
	}

	update_loading(&loadingbg[0], -1, 1); // initialize the update screen

	// reload default values
	max_idles        = MAX_IDLES;
	max_walks        = MAX_WALKS;
	max_ups          = MAX_UPS;
	max_downs        = MAX_DOWNS;
	max_backwalks    = MAX_BACKWALKS;
	max_attack_types = MAX_ATKS;
	max_freespecials = MAX_SPECIALS;
	max_follows      = MAX_FOLLOWS;
	max_attacks      = MAX_ATTACKS;
	max_animations   = MAX_ANIS;

	// free old values
	if(animspecials){free(animspecials); animspecials = NULL;}
	if(animattacks){free(animattacks);  animattacks = NULL;}
	if(animfollows){free(animfollows);  animfollows = NULL;}
	if(animpains){free(animpains);    animpains = NULL;}
	if(animfalls){free(animfalls);    animfalls = NULL;}
	if(animrises){free(animrises);    animrises = NULL;}
	if(animriseattacks){free(animriseattacks);    animriseattacks = NULL;}
	if(animblkpains) {free(animblkpains); animblkpains = NULL;}
	if(animdies){free(animdies);     animdies = NULL;}
	if(animwalks){free(animwalks);     animwalks = NULL;}
	if(animbackwalks){free(animbackwalks);     animbackwalks = NULL;}
	if(animidles){free(animidles);     animidles = NULL;}
	if(animups){free(animups);     animups = NULL;}
	if(animdowns){free(animdowns);     animdowns = NULL;}

	if(custModels != NULL)
	{
		strcpy(filename, "data/");
		strcat(filename, custModels);
	}

	// Read file
	if(buffer_pakfile(filename, &buf, &size)!=1) shutdown(1, "Error loading model list from %s", filename);

	pos = 0;
	while(pos<size) // peek global settings
	{
		line++;
		if(ParseArgs(&arglist,buf+pos,argbuf)){
			command = GET_ARG(0);
			cmd = getModelCommand(modelstxtcmdlist, command);
			switch(cmd) {
				case CMD_MODELSTXT_MAXIDLES:
					// max idle stances
					max_idles = GET_INT_ARG(1);
					if(max_idles < MAX_IDLES) max_idles = MAX_IDLES;
					break;
				case CMD_MODELSTXT_MAXWALKS:
					max_walks = GET_INT_ARG(1);
					if(max_walks < MAX_WALKS) max_walks = MAX_WALKS;
					break;
				case CMD_MODELSTXT_MAXBACKWALKS:
					// max backward walks
					max_backwalks = GET_INT_ARG(1);
					if(max_backwalks < MAX_BACKWALKS) max_backwalks = MAX_BACKWALKS;
					break;
				case CMD_MODELSTXT_MAXUPS:
					// max up walks
					max_ups = GET_INT_ARG(1);
					if(max_ups < MAX_UPS) max_ups = MAX_UPS;
					break;
				case CMD_MODELSTXT_MAXDOWNS:
					// max down walks
					max_downs = GET_INT_ARG(1);
					if(max_downs < MAX_DOWNS) max_downs = MAX_DOWNS;
					break;
				case CMD_MODELSTXT_MAXATTACKTYPES:
					// max attacktype/pain/fall/die
					max_attack_types = GET_INT_ARG(1) + STA_ATKS;
					if(max_attack_types < MAX_ATKS) max_attack_types = MAX_ATKS;
					break;
				case CMD_MODELSTXT_MAXFOLLOWS:
					// max follow-ups
					max_follows = GET_INT_ARG(1);
					if(max_follows<MAX_FOLLOWS) max_follows = MAX_FOLLOWS;
					break;
				case CMD_MODELSTXT_MAXFREESPECIALS:
					// max freespecials
					max_freespecials = GET_INT_ARG(1);
					if(max_freespecials<MAX_SPECIALS) max_freespecials = MAX_SPECIALS;
					break;
				case CMD_MODELSTXT_MAXATTACKS:
					max_attacks = GET_INT_ARG(1);
					if(max_attacks<MAX_ATTACKS) max_attacks = MAX_ATTACKS;
					break;
				case CMD_MODELSTXT_COMBODELAY:
					combodelay = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_MUSIC:
					music(GET_ARG(1), 1, atol(GET_ARG(2)));
					break;
				case CMD_MODELSTXT_LOAD:
					// Add path to cache list
					modelLoadCount++;
					cache_model(GET_ARG(1), GET_ARG(2), 1);
					break;
				case CMD_MODELSTXT_COLOURSELECT:
					// 6-2-2005 if string for colourselect found
					colourselect =  GET_INT_ARG(1);          //  6-2-2005
					break;
				case CMD_MODELSTXT_SPDIRECTION:
					// Select Player Direction for select player screen
					spdirection[0] =  GET_INT_ARG(1);
					spdirection[1] =  GET_INT_ARG(2);
					spdirection[2] =  GET_INT_ARG(3);
					spdirection[3] =  GET_INT_ARG(4);
					break;
				case CMD_MODELSTXT_AUTOLAND:
					// New flag to determine if a player auto lands when thrown by another player (2 completely disables the ability to land)
					autoland = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_NOLOST:
					// this is use for dont lost your weapon if you grab a enemy flag it to 1 to no drop by tails
					nolost = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_AJSPECIAL:
					// Flag to determine if a + j executes special
					ajspecial = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_NOCOST:
					// Nocost set in models.txt
					nocost = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_NOCHEATS:
					//disable cheat option in menu
					forcecheatsoff =  GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_NODROPEN:
					nodropen = 1;
					break;
				case CMD_MODELSTXT_NODROPSPAWN:
					nodropspawn = 1;
					break;
				case CMD_MODELSTXT_KNOW:
					// Just add path to cache list
					cache_model(GET_ARG(1), GET_ARG(2), 0);
					break;
				case CMD_MODELSTXT_NOAIRCANCEL:
					noaircancel = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_NOMAXRUSHRESET:
					nomaxrushreset[4] = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_MPBLOCK:
					// Take from MP first?
					mpblock = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_BLOCKRATIO:
					// Nullify or reduce damage?
					blockratio = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_NOCHIPDEATH:
					nochipdeath = GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_LIFESCORE:
					lifescore =  GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_CREDSCORE:
					// Number of points needed to earn a 1-up
					credscore =  GET_INT_ARG(1);
					break;
				case CMD_MODELSTXT_VERSUSDAMAGE:
					// Number of points needed to earn a credit
					versusdamage =  GET_INT_ARG(1);
					if(versusdamage == 0 || versusdamage == 1) savedata.mode = versusdamage^1;
					break;
				case CMD_MODELSTXT_DROPV:
					default_model_dropv[0] =  GET_FLOAT_ARG(1);
					default_model_dropv[1] =  GET_FLOAT_ARG(2);
					default_model_dropv[2] =  GET_FLOAT_ARG(3);
					break;
				case CMD_MODELSTXT_JUMPSPEED:
					default_model_jumpspeed =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_JUMPHEIGHT:
					default_model_jumpheight =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_GRABDISTANCE:
					default_model_grabdistance =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_MNAF:
					move_noatk_factor =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_GNAF:
					group_noatk_factor =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_ANAF:
					agg_noatk_factor =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_MINNA:
					min_noatk_chance =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_MAXNA:
					max_noatk_chance =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_OSNAF:
					offscreen_noatk_factor =  GET_FLOAT_ARG(1);
					break;
				case CMD_MODELSTXT_DEBUG_NAD:
					noatk_duration =  GET_FLOAT_ARG(1);
					break;
				default:
					printf("command %s not understood in %s, line %d\n", command, filename, line);
			}
		}

		// Go to next line
		pos += getNewLineStart(buf + pos);
	}
	// calculate max animations
	max_animations += (max_attack_types - MAX_ATKS) * 6 +// multply by 5, for fall/die/pain/rise/blockpain/riseattack
			(max_follows - MAX_FOLLOWS) +
			(max_freespecials - MAX_SPECIALS) +
			(max_attacks - MAX_ATTACKS) +
			(max_idles - MAX_IDLES)+
			(max_walks - MAX_WALKS)+
			(max_ups - MAX_UPS)+
			(max_downs - MAX_DOWNS)+
			(max_backwalks - MAX_BACKWALKS);

	// alloc indexed animation ids
	animdowns       = (int*)malloc(sizeof(int)*max_downs);
	animups         = (int*)malloc(sizeof(int)*max_ups);
	animbackwalks   = (int*)malloc(sizeof(int)*max_backwalks);
	animwalks       = (int*)malloc(sizeof(int)*max_walks);
	animidles       = (int*)malloc(sizeof(int)*max_idles);
	animpains       = (int*)malloc(sizeof(int)*max_attack_types);
	animdies        = (int*)malloc(sizeof(int)*max_attack_types);
	animfalls       = (int*)malloc(sizeof(int)*max_attack_types);
	animrises       = (int*)malloc(sizeof(int)*max_attack_types);
	animriseattacks = (int*)malloc(sizeof(int)*max_attack_types);
	animblkpains    = (int*)malloc(sizeof(int)*max_attack_types);
	animattacks     = (int*)malloc(sizeof(int)*max_attacks);
	animfollows     = (int*)malloc(sizeof(int)*max_follows);
	animspecials    = (int*)malloc(sizeof(int)*max_freespecials);

	// copy default values and new animation ids
	memcpy(animdowns, downs, sizeof(int)*MAX_DOWNS);
	for(i=MAX_DOWNS; i<max_downs; i++) animdowns[i] = maxanim++;
	memcpy(animups, ups, sizeof(int)*MAX_UPS);
	for(i=MAX_UPS; i<max_ups; i++) animups[i] = maxanim++;
	memcpy(animbackwalks, backwalks, sizeof(int)*MAX_BACKWALKS);
	for(i=MAX_BACKWALKS; i<max_backwalks; i++) animbackwalks[i] = maxanim++;
	memcpy(animwalks, walks, sizeof(int)*MAX_WALKS);
	for(i=MAX_WALKS; i<max_walks; i++) animwalks[i] = maxanim++;
	memcpy(animidles, idles, sizeof(int)*MAX_IDLES);
	for(i=MAX_IDLES; i<max_idles; i++) animidles[i] = maxanim++;
	memcpy(animspecials, freespecials,   sizeof(int)*MAX_SPECIALS);
	for(i=MAX_SPECIALS; i<max_freespecials; i++) animspecials[i] = maxanim++;
	memcpy(animattacks,  normal_attacks, sizeof(int)*MAX_ATTACKS);
	for(i=MAX_ATTACKS; i<max_attacks; i++) animattacks[i] = maxanim++;
	memcpy(animfollows,  follows,        sizeof(int)*MAX_FOLLOWS);
	for(i=MAX_FOLLOWS; i<max_follows; i++) animfollows[i] = maxanim++;
	memcpy(animpains,    pains,          sizeof(int)*MAX_ATKS);
	for(i=MAX_ATKS; i<max_attack_types; i++) animpains[i] = maxanim++;
	memcpy(animfalls,    falls,          sizeof(int)*MAX_ATKS);
	for(i=MAX_ATKS; i<max_attack_types; i++) animfalls[i] = maxanim++;
	memcpy(animrises,    rises,          sizeof(int)*MAX_ATKS);
	for(i=MAX_ATKS; i<max_attack_types; i++) animrises[i] = maxanim++;
	memcpy(animriseattacks,    riseattacks,          sizeof(int)*MAX_ATKS);
	for(i=MAX_ATKS; i<max_attack_types; i++) animriseattacks[i] = maxanim++;
	memcpy(animblkpains,    blkpains,    sizeof(int)*MAX_ATKS);
	for(i=MAX_ATKS; i<max_attack_types; i++) animblkpains[i] = maxanim++;
	memcpy(animdies,     deaths,         sizeof(int)*MAX_ATKS);
	for(i=MAX_ATKS; i<max_attack_types; i++) animdies[i] = maxanim++;

	// Defer load_cached_model, so you can define models after their nested model.
	printf("\n");

	for(i=0,pos=0; i<models_cached; i++) {
		//printf("Checking '%s' '%s'\n", model_cache[i].name, model_cache[i].path);
		if(model_cache[i].loadflag) {
			load_cached_model(model_cache[i].name, "models.txt", 0);
			update_loading(&loadingbg[0], ++pos, modelLoadCount);
		}
	}
	printf("\nLoading models...............\tDone!\n");


	if(buf)
		free(buf);

	return 1;
}




void unload_levelorder(){
	int i, j;
	s_level_entry *le;
	s_set_entry *se;

	if(levelsets){
		for(i=0; i<num_difficulties; i++){
			se = levelsets+i;
			if(se->name){
				free(se->name);
			}
			for(j=0; j<MAX_PLAYERS; j++){
				if(se->skipselect[j])
					free(se->skipselect[j]);
			}
			if(se->numlevels){
				for(j=0; j<se->numlevels; j++){
					le = se->levelorder + j;
					if(le->branchname) free(le->branchname);
					if(le->filename) free(le->filename);
				}
				free(se->levelorder);
			}
		}

		free(levelsets);
		levelsets = NULL;
	}
	
	num_difficulties = 0;
}



// Add a level to the level order
s_level_entry* add_level(char *filename, s_set_entry* set){
	s_level_entry* le = NULL;
	int Zs[3] = {0,0,0};

	if(z_coords[0] > 0) Zs[0] = z_coords[0];
	else Zs[0] = PLAYER_MIN_Z;

	if(z_coords[1] > 0) Zs[1] = z_coords[1];
	else Zs[1] = PLAYER_MAX_Z;

	if(z_coords[2] > 0) Zs[2] = z_coords[2];
	else Zs[2] = PLAYER_MIN_Z;

	set->levelorder = realloc(set->levelorder, (++set->numlevels)*sizeof(s_level_entry));
	le = set->levelorder + set->numlevels-1;
	memset(le, 0, sizeof(s_level_entry));
	if(branch_name[0])
		le->branchname = NAME(branch_name);
	le->filename = NAME(filename);
	le->z_coords[0] = Zs[0];
	le->z_coords[1] = Zs[1];
	le->z_coords[2] = Zs[2];
	return le;
}



// Add a scene to the level order
s_level_entry* add_scene(char *filename, s_set_entry* set){
	s_level_entry* le = NULL;

	set->levelorder = realloc(set->levelorder, (++set->numlevels)*sizeof(s_level_entry));
	le = set->levelorder + set->numlevels-1;
	memset(le, 0, sizeof(s_level_entry));
	if(branch_name[0])
		le->branchname = NAME(branch_name);
	le->filename = NAME(filename);
	le->type = cut_scene;
	return le;
}

// Add a select screen file to the level order
s_level_entry* add_select(char *filename, s_set_entry* set){
	s_level_entry* le = NULL;

	set->levelorder = realloc(set->levelorder, (++set->numlevels)*sizeof(s_level_entry));
	le = set->levelorder + set->numlevels-1;
	memset(le, 0, sizeof(s_level_entry));
	if(branch_name[0])
		le->branchname = NAME(branch_name);
	le->filename = NAME(filename);
	le->type = select_screen;
	return le;
}

static void _readbarstatus(char* buf, s_barstatus* pstatus)
{
	char* value;
	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";

	ParseArgs(&arglist,buf,argbuf);
	if((value=GET_ARG(1))[0]) pstatus->sizex       = atoi(value);
	else return;
	if((value=GET_ARG(2))[0]) pstatus->sizey       = atoi(value);
	else return;
	if((value=GET_ARG(3))[0]) pstatus->noborder    = atoi(value);
	else return;
	if((value=GET_ARG(4))[0]) pstatus->type        = atoi(value);
	else return;
	if((value=GET_ARG(5))[0]) pstatus->orientation = atoi(value);
	else return;
	if((value=GET_ARG(6))[0]) pstatus->borderlayer = atoi(value);
	else return;
	if((value=GET_ARG(7))[0]) pstatus->shadowlayer = atoi(value);
	else return;
	if((value=GET_ARG(8))[0]) pstatus->barlayer    = atoi(value);
	else return;
	if((value=GET_ARG(9))[0]) pstatus->backlayer   = atoi(value);
	else return;
}

s_set_entry* add_set(){
	s_set_entry* set = NULL;
	++num_difficulties;
	if(levelsets) levelsets = realloc(levelsets, sizeof(s_set_entry)*num_difficulties);
	else levelsets = calloc(1, sizeof(s_set_entry));
	set = levelsets+num_difficulties-1;
	memset(set, 0, sizeof(s_set_entry));
	set->maxplayers = defaultmaxplayers;
	return set;
}

// Load list of levels
void load_levelorder()
{
	static const char* defaulterr = "Error in level order: a set must be specified.";
#define CHKDEF if(!set) { errormessage = (char*) defaulterr; goto lCleanup; }
	char filename[128] = "";
	int i=0,j=0;
	char *buf;
	size_t size;
	int pos;
	s_set_entry* set = NULL;
	s_level_entry* le = NULL;
	char * command;
	char* arg;
	char* errormessage = NULL;
	int plifeUsed[2]  = {0,0};
	int elifeUsed[2]  = {0,0};
	int piconUsed[2]  = {0,0};
	int piconwUsed[2] = {0,0};
	int eiconUsed[4]  = {0,0,0,0};
	int pmpUsed[4]    = {0,0,0,0};
	int plifeXused[4] = {0,0,0,0};        // 4-7-2006 New custimizable variable for players 'x'
	int plifeNused[4] = {0,0,0,0};        // 4-7-2006 New custimizable variable for players 'lives'
	int enameused[4]  = {0,0,0,0};        // 4-7-2006 New custimizable variable for enemy names
	int pnameJused[4] = {0,0,0,0};        // 1-8-2006 New custimizable variable for players name Select Hero
	int pscoreUsed[4] = {0,0,0,0};        // 1-8-2006 New custimizable variable for players name Select Hero

	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";
	levelOrderCommands cmd;
	int line = 0;

	unload_levelorder();

	if(custLevels != NULL)
	{
		strcpy(filename,"data/");
		strcat(filename,custLevels);
	}
	else strcpy(filename,"data/levels.txt");

	// Read file

	if(buffer_pakfile(filename, &buf, &size)!=1) shutdown(1, "Error loading level list from %s", filename);

	// Now interpret the contents of buf line by line
	pos = 0;

	// Custom lifebar/timebox/icon positioning and size
	picon[0][0] = piconw[0][0] = picon[2][0] = piconw[2][0] = eicon[0][0] = eicon[2][0] = 2;
	picon[1][0] = piconw[1][0] = picon[3][0] = piconw[3][0] = eicon[1][0] = eicon[3][0] = 2 + P2_STATS_DIST;
	picon[0][1] = piconw[0][1] = picon[1][1] = piconw[1][1] = 2;
	picon[2][1] = piconw[2][1] = picon[3][1] = piconw[3][1] = 202;
	plife[0][0] = pmp[0][0] = plife[2][0] = pmp[2][0] = elife[0][0] = elife[2][0] = 20;
	plife[1][0] = pmp[1][0] = plife[3][0] = pmp[3][0] = elife[1][0] = elife[3][0] = 20 + P2_STATS_DIST;
	plife[0][1] = plife[1][1] = 10;
	plife[2][1] = plife[3][1] = 210;
	pmp[0][1] = pmp[1][1] = 18;
	pmp[2][1] = pmp[3][1] = 218;

	memset(psmenu, 0, sizeof(int)*4*4);

	eicon[0][1] = eicon[1][1] = 19;
	eicon[2][1] = eicon[3][1] = 220;
	elife[0][1] = elife[1][1] = 27;
	elife[2][1] = elife[3][1] = 227;

	timeloc[0] = 149;
	timeloc[1] = 4;
	timeloc[2] = 21;
	timeloc[3] = 20;
	timeloc[4] = 0;

	lbarstatus.sizex  = mpbarstatus.sizex = 100;
	lbarstatus.sizey  = 5;
	mpbarstatus.sizey = 3;
	lbarstatus.noborder = mpbarstatus.noborder = 0;

	// Show Complete Default Values
	scomplete[0] = 75;
	scomplete[1] = 60;
	scomplete[2] = 0;
	scomplete[3] = 0;
	scomplete[4] = 0;
	scomplete[5] = 0;

	// Show Complete Y Values
	cbonus[0] = lbonus[0] = rbonus[0] = tscore[0] = 10;
	cbonus[1] = cbonus[3] = cbonus[5] = cbonus[7] = cbonus[9] = 100;
	lbonus[1] = lbonus[3] = lbonus[5] = lbonus[7] = lbonus[9] = 120;
	rbonus[1] = rbonus[3] = rbonus[5] = rbonus[7] = rbonus[9] = 140;
	tscore[1] = tscore[3] = tscore[5] = tscore[7] = tscore[9] = 160;

	// Show Complete X Values
	cbonus[2] = lbonus[2] = rbonus[2] = tscore[2] = 100;
	cbonus[4] = lbonus[4] = rbonus[4] = tscore[4] = 155;
	cbonus[6] = lbonus[6] = rbonus[6] = tscore[6] = 210;
	cbonus[8] = lbonus[8] = rbonus[8] = tscore[8] = 265;


	while(pos<size){
		line++;
		ParseArgs(&arglist,buf+pos,argbuf);
		command = GET_ARG(0);
		cmd = getLevelOrderCommand(levelordercmdlist, command);
		switch(cmd) {
			case CMD_LEVELORDER_BLENDFX:
				for(i=0; i<MAX_BLENDINGS; i++)
				{
					if(GET_INT_ARG(i+1)) blendfx[i] = 1;
					else blendfx[i] = 0;
				}
				blendfx_is_set = 1;
				break;
			case CMD_LEVELORDER_SET:
				set = add_set();
				set->name = NAME(GET_ARG(1));
				set->ifcomplete = 0;
				set->saveflag  = 1; // default to 1, so the level can be saved
				branch_name[0] = 0;
				le = NULL;
				break;
			case CMD_LEVELORDER_IFCOMPLETE:
				CHKDEF;
				set->ifcomplete = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_SKIPSELECT:
				CHKDEF;
				if(arglist.count==1)
				{
					set->noselect = 1;
				}
				else
				{
					for(i=0; i<4;i++) {
						if((arg=GET_ARG(i+1))[0]) {
							set->skipselect[i] = NAME(arg);
						}
					}
				}
				break;
			case CMD_LEVELORDER_FILE:
				CHKDEF;
				le = add_level(GET_ARG(1), set);
				break;
			case CMD_LEVELORDER_SCENE:
				CHKDEF;
				le = add_scene(GET_ARG(1), set);
				break;
			case CMD_LEVELORDER_SELECT:
				CHKDEF;
				le = add_select(GET_ARG(1), set);
				break;
			case CMD_LEVELORDER_NEXT:
				CHKDEF;
				// Set 'gonext' flag of last loaded level
				if(le) le->gonext = 1;
				break;
			case CMD_LEVELORDER_END:
				CHKDEF;
				// Set endgame flag of last loaded level
				if(le) le->gonext = 2;
				break;
			case CMD_LEVELORDER_LIVES:
				// 7-1-2005  credits/lives/singleplayer start here
				// used to read the new # of lives/credits from the levels.txt
				CHKDEF;
				set->lives = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_DISABLEHOF:
				CHKDEF;
				set->noshowhof = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_CANSAVE:
				// 07-12-31
				// 0 this set can't be saved
				// 1 save level only
				// 2 save player info and level, can't choose player in select menu
				CHKDEF;
				set->saveflag = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_Z:
				//    2-10-05  adjust the walkable coordinates
				CHKDEF;
				z_coords[0] = GET_INT_ARG(1);
				z_coords[1] = GET_INT_ARG(2);
				z_coords[2] = GET_INT_ARG(3);
				break;
			case CMD_LEVELORDER_BRANCH:
				//    2007-2-22 level branch name
				CHKDEF;
				strncpy(branch_name, GET_ARG(1), MAX_NAME_LEN);
				break;
			case CMD_LEVELORDER_P1LIFE: case CMD_LEVELORDER_P2LIFE: case CMD_LEVELORDER_P3LIFE: case CMD_LEVELORDER_P4LIFE:
				switch(cmd) {
					case CMD_LEVELORDER_P1LIFE: i = 0; break;
					case CMD_LEVELORDER_P2LIFE: i = 1; break;
					case CMD_LEVELORDER_P3LIFE: i = 2; plifeUsed[0] = 1; break;
					case CMD_LEVELORDER_P4LIFE: i = 3; plifeUsed[1] = 1; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) plife[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) plife[i][1] = atoi(arg);
				break;
			case CMD_LEVELORDER_P1MP: case CMD_LEVELORDER_P2MP: case CMD_LEVELORDER_P3MP: case CMD_LEVELORDER_P4MP:
				switch(cmd) {
					case CMD_LEVELORDER_P1MP: i = 0; break;
					case CMD_LEVELORDER_P2MP: i = 1; break;
					case CMD_LEVELORDER_P3MP: i = 2; break;
					case CMD_LEVELORDER_P4MP: i = 3; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) pmp[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) pmp[i][1] = atoi(arg);
				pmpUsed[i] = 1;
				break;
			case CMD_LEVELORDER_P1LIFEX: case CMD_LEVELORDER_P2LIFEX: case CMD_LEVELORDER_P3LIFEX: case CMD_LEVELORDER_P4LIFEX:
				switch(cmd) {
					case CMD_LEVELORDER_P1LIFEX: j = 0; break;
					case CMD_LEVELORDER_P2LIFEX: j = 1; break;
					case CMD_LEVELORDER_P3LIFEX: j = 2; break;
					case CMD_LEVELORDER_P4LIFEX: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<3; i++)
					if((arg=GET_ARG(i+1))[0]) plifeX[j][i] = atoi(arg);
				plifeXused[j] = 1;
				break;
			case CMD_LEVELORDER_P1LIFEN: case CMD_LEVELORDER_P2LIFEN: case CMD_LEVELORDER_P3LIFEN: case CMD_LEVELORDER_P4LIFEN:
				switch(cmd) {
					case CMD_LEVELORDER_P1LIFEN: j = 0; break;
					case CMD_LEVELORDER_P2LIFEN: j = 1; break;
					case CMD_LEVELORDER_P3LIFEN: j = 2; break;
					case CMD_LEVELORDER_P4LIFEN: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<3; i++)
					if((arg=GET_ARG(i+1))[0]) plifeN[j][i] = atoi(arg);
				plifeNused[j] = 1;
				break;
			case CMD_LEVELORDER_E1LIFE: case CMD_LEVELORDER_E2LIFE: case CMD_LEVELORDER_E3LIFE: case CMD_LEVELORDER_E4LIFE:
				switch(cmd) {
					case CMD_LEVELORDER_E1LIFE: i = 0; break;
					case CMD_LEVELORDER_E2LIFE: i = 1; break;
					case CMD_LEVELORDER_E3LIFE: i = 2; elifeUsed[0] = 1; break;
					case CMD_LEVELORDER_E4LIFE: i = 3; elifeUsed[1] = 1; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) elife[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) elife[i][1] = atoi(arg);
				break;
			case CMD_LEVELORDER_P1ICON: case CMD_LEVELORDER_P2ICON: case CMD_LEVELORDER_P3ICON: case CMD_LEVELORDER_P4ICON:
				switch(cmd) {
					case CMD_LEVELORDER_P1ICON: i = 0; break;
					case CMD_LEVELORDER_P2ICON: i = 1; break;
					case CMD_LEVELORDER_P3ICON: i = 2; piconUsed[0] = 1; break;
					case CMD_LEVELORDER_P4ICON: i = 3; piconUsed[1] = 1; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) picon[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) picon[i][1] = atoi(arg);
				break;
			case CMD_LEVELORDER_P1ICONW: case CMD_LEVELORDER_P2ICONW: case CMD_LEVELORDER_P3ICONW: case CMD_LEVELORDER_P4ICONW:
				switch(cmd) {
					case CMD_LEVELORDER_P1ICONW: i = 0; break;
					case CMD_LEVELORDER_P2ICONW: i = 1; break;
					case CMD_LEVELORDER_P3ICONW: i = 2; piconwUsed[0] = 1; break;
					case CMD_LEVELORDER_P4ICONW: i = 3; piconwUsed[1] = 1; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) piconw[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) piconw[i][1] = atoi(arg);
				break;
			case CMD_LEVELORDER_MP1ICON: case CMD_LEVELORDER_MP2ICON: case CMD_LEVELORDER_MP3ICON: case CMD_LEVELORDER_MP4ICON:
				switch(cmd) {
					case CMD_LEVELORDER_MP1ICON: i = 0; break;
					case CMD_LEVELORDER_MP2ICON: i = 1; break;
					case CMD_LEVELORDER_MP3ICON: i = 2; break;
					case CMD_LEVELORDER_MP4ICON: i = 3; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) mpicon[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) mpicon[i][1] = atoi(arg);
				break;
			case CMD_LEVELORDER_P1NAMEJ: case CMD_LEVELORDER_P2NAMEJ: case CMD_LEVELORDER_P3NAMEJ: case CMD_LEVELORDER_P4NAMEJ:
				switch(cmd) {
					case CMD_LEVELORDER_P1NAMEJ: j = 0; break;
					case CMD_LEVELORDER_P2NAMEJ: j = 1; break;
					case CMD_LEVELORDER_P3NAMEJ: j = 2; break;
					case CMD_LEVELORDER_P4NAMEJ: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<7; i++)
					if((arg=GET_ARG(i+1))[0]) pnameJ[j][i] = atoi(arg);
				pnameJused[j] = 1;
				break;
			case CMD_LEVELORDER_P1SCORE: case CMD_LEVELORDER_P2SCORE: case CMD_LEVELORDER_P3SCORE: case CMD_LEVELORDER_P4SCORE:
				switch(cmd) {
					case CMD_LEVELORDER_P1SCORE: j = 0; break;
					case CMD_LEVELORDER_P2SCORE: j = 1; break;
					case CMD_LEVELORDER_P3SCORE: j = 2; break;
					case CMD_LEVELORDER_P4SCORE: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<7; i++)
					if((arg=GET_ARG(i+1))[0]) pscore[j][i] = atoi(arg);
				pscoreUsed[j] = 1;
				break;
			case CMD_LEVELORDER_P1SHOOT: case CMD_LEVELORDER_P2SHOOT: case CMD_LEVELORDER_P3SHOOT: case CMD_LEVELORDER_P4SHOOT:
				switch(cmd) {
					case CMD_LEVELORDER_P1SHOOT: j = 0; break;
					case CMD_LEVELORDER_P2SHOOT: j = 1; break;
					case CMD_LEVELORDER_P3SHOOT: j = 2; break;
					case CMD_LEVELORDER_P4SHOOT: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<3; i++)
					if((arg=GET_ARG(i+1))[0]) pshoot[j][i] = atoi(arg);
				break;
			case CMD_LEVELORDER_P1RUSH: case CMD_LEVELORDER_P2RUSH: case CMD_LEVELORDER_P3RUSH: case CMD_LEVELORDER_P4RUSH:
				switch(cmd) {
					case CMD_LEVELORDER_P1RUSH: j = 0; break;
					case CMD_LEVELORDER_P2RUSH: j = 1; break;
					case CMD_LEVELORDER_P3RUSH: j = 2; break;
					case CMD_LEVELORDER_P4RUSH: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<8; i++)
					if((arg=GET_ARG(i+1))[0]) prush[j][i] = atoi(arg);
				break;
			case CMD_LEVELORDER_E1ICON: case CMD_LEVELORDER_E2ICON: case CMD_LEVELORDER_E3ICON: case CMD_LEVELORDER_E4ICON:
				switch(cmd) {
					case CMD_LEVELORDER_E1ICON: i = 0; break;
					case CMD_LEVELORDER_E2ICON: i = 1; break;
					case CMD_LEVELORDER_E3ICON: i = 2; eiconUsed[0] = 1; break;
					case CMD_LEVELORDER_E4ICON: i = 3; eiconUsed[1] = 1; break;
					default: assert(0);
				}
				if((arg=GET_ARG(1))[0]) eicon[i][0] = atoi(arg);
				if((arg=GET_ARG(2))[0]) eicon[i][1] = atoi(arg);
				break;
			case CMD_LEVELORDER_E1NAME: case CMD_LEVELORDER_E2NAME: case CMD_LEVELORDER_E3NAME: case CMD_LEVELORDER_E4NAME:
				switch(cmd) {
					case CMD_LEVELORDER_E1NAME: j = 0; break;
					case CMD_LEVELORDER_E2NAME: j = 1; break;
					case CMD_LEVELORDER_E3NAME: j = 2; break;
					case CMD_LEVELORDER_E4NAME: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<3; i++)
					if((arg=GET_ARG(i+1))[0]) ename[j][i] = atoi(arg);
				enameused[j] = 1;
				break;
			case CMD_LEVELORDER_P1SMENU: case CMD_LEVELORDER_P2SMENU: case CMD_LEVELORDER_P3SMENU: case CMD_LEVELORDER_P4SMENU:
				switch(cmd) {
					case CMD_LEVELORDER_P1SMENU: j = 0; break;
					case CMD_LEVELORDER_P2SMENU: j = 1; break;
					case CMD_LEVELORDER_P3SMENU: j = 2; break;
					case CMD_LEVELORDER_P4SMENU: j = 3; break;
					default: assert(0);
				}
				for(i=0; i<4; i++)
					if((arg=GET_ARG(i+1))[0]) psmenu[j][i] = atoi(arg);
				break;
			case CMD_LEVELORDER_TIMEICON:
   				strncpy(timeicon_path, GET_ARG(1), 127);
				timeicon = loadsprite(timeicon_path,0,0,pixelformat);
				if((arg=GET_ARG(2))[0]) timeicon_offsets[0] = atoi(arg);
				if((arg=GET_ARG(3))[0]) timeicon_offsets[1] = atoi(arg);
				break;
			case CMD_LEVELORDER_BGICON:
				strncpy(bgicon_path, GET_ARG(1), 127);
				bgicon = loadsprite(bgicon_path,0,0,pixelformat);
				if((arg=GET_ARG(2))[0]) bgicon_offsets[0] = atoi(arg);
				if((arg=GET_ARG(3))[0]) bgicon_offsets[1] = atoi(arg);
				if((arg=GET_ARG(4))[0]) bgicon_offsets[2] = atoi(arg);
				else bgicon_offsets[2] = HUD_Z / 2;
				break;
			case CMD_LEVELORDER_OLICON:
				strncpy(olicon_path, GET_ARG(1), 127);
				olicon = loadsprite(olicon_path,0,0,pixelformat);
				if((arg=GET_ARG(2))[0]) olicon_offsets[0] = atoi(arg);
				if((arg=GET_ARG(3))[0]) olicon_offsets[1] = atoi(arg);
				if((arg=GET_ARG(4))[0]) olicon_offsets[2] = atoi(arg);
				else olicon_offsets[2] = HUD_Z * 3;
				break;
			case CMD_LEVELORDER_TIMELOC:
				for(i=0; i<6; i++)
					if((arg=GET_ARG(i+1))[0]) timeloc[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_LBARSIZE:
				_readbarstatus(buf+pos, &lbarstatus);
				break;
			case CMD_LEVELORDER_OLBARSIZE:
				_readbarstatus(buf+pos, &olbarstatus);
				break;
			case CMD_LEVELORDER_MPBARSIZE:
				_readbarstatus(buf+pos, &mpbarstatus);
				break;
			case CMD_LEVELORDER_LBARTEXT:
				for(i=0; i<4; i++)
					if((arg=GET_ARG(i+1))[0]) lbartext[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_MPBARTEXT:
				for(i=0; i<4; i++)
					if((arg=GET_ARG(i+1))[0]) mpbartext[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_SHOWCOMPLETE:
				for(i=0; i<6; i++)
					if((arg=GET_ARG(i+1))[0]) scomplete[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_CLEARBONUS:
				for(i=0; i<10; i++)
					if((arg=GET_ARG(i+1))[0]) cbonus[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_RUSHBONUS:
				for(i=0; i<10; i++)
					if((arg=GET_ARG(i+1))[0]) rbonus[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_LIFEBONUS:
				for(i=0; i<10; i++)
					if((arg=GET_ARG(i+1))[0]) lbonus[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_SCBONUSES:
				for(i=0; i<4; i++)
					if((arg=GET_ARG(i+1))[0]) scbonuses[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_TOTALSCORE:
				for(i=0; i<10; i++)
					if((arg=GET_ARG(i+1))[0]) tscore[i] = atoi(arg);
				break;
			case CMD_LEVELORDER_MUSICOVERLAP:
				CHKDEF;
				set->musicoverlap = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_SHOWRUSHBONUS:
				showrushbonus = 1;
				break;
			case CMD_LEVELORDER_NOSLOWFX:
				noslowfx = 1;
				break;
			case CMD_LEVELORDER_EQUALAIRPAUSE:
				equalairpause = 1;
				break;
			case CMD_LEVELORDER_HISCOREBG:
				hiscorebg = 1;
				break;
			case CMD_LEVELORDER_COMPLETEBG:
				completebg = 1;
				break;
			case CMD_LEVELORDER_LOADINGBG:
				errormessage = fill_s_loadingbar(&loadingbg[0], GET_INT_ARG(1), GET_INT_ARG(2),GET_INT_ARG(3),GET_INT_ARG(4),GET_INT_ARG(5),GET_INT_ARG(6),GET_INT_ARG(7),GET_INT_ARG(8));
				if(errormessage) goto lCleanup;
				break;
			case CMD_LEVELORDER_LOADINGBG2:
				errormessage = fill_s_loadingbar(&loadingbg[1], GET_INT_ARG(1), GET_INT_ARG(2),GET_INT_ARG(3),GET_INT_ARG(4),GET_INT_ARG(5),GET_INT_ARG(6),GET_INT_ARG(7),GET_INT_ARG(8));
				if(errormessage) goto lCleanup;
				break;
			case CMD_LEVELORDER_LOADINGMUSIC:
				loadingmusic = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_UNLOCKBG:
				unlockbg = 1;
				break;
			case CMD_LEVELORDER_NOSHARE:
				noshare = 1;
				break;
			case CMD_LEVELORDER_CUSTFADE:
				//8-2-2005 custom fade
				CHKDEF;
				set->custfade = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_CONTINUESCORE:
				//8-2-2005 custom fade end
				//continuescore
				CHKDEF;
				set->continuescore = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_CREDITS:
				CHKDEF;
				set->credits = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_TYPEMP:
				//typemp for change for mp restored by time (0) to by enemys (1) or no restore (2) by tails
				CHKDEF;
				set->typemp = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_SINGLE:
				if(set) 
					set->maxplayers = 1;
				else
					defaultmaxplayers = 1;
				break;
			case CMD_LEVELORDER_MAXPLAYERS:
				if(set) 
					set->maxplayers = GET_INT_ARG(1);
				else
					defaultmaxplayers = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_NOSAME:
				CHKDEF;
				set->nosame = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_RUSH:
				rush[0] = GET_INT_ARG(1);
				rush[1] = GET_INT_ARG(2);
				strncpy(rush_names[0], GET_ARG(3), MAX_NAME_LEN);
				rush[2] = GET_INT_ARG(4);
				rush[3] = GET_INT_ARG(5);
				strncpy(rush_names[1], GET_ARG(6), MAX_NAME_LEN);
				rush[4] = GET_INT_ARG(7);
				rush[5] = GET_INT_ARG(8);
				break;
			case CMD_LEVELORDER_MAXWALLHEIGHT:
				MAX_WALL_HEIGHT = GET_INT_ARG(1);
				if(MAX_WALL_HEIGHT < 0) MAX_WALL_HEIGHT = 1000;
				break;
			case CMD_LEVELORDER_SCOREFORMAT:
				scoreformat = GET_INT_ARG(1);
				break;
			case CMD_LEVELORDER_GRAVITY:
				default_level_gravity = GET_FLOAT_ARG(1);
				default_level_maxfallspeed = GET_FLOAT_ARG(2);
				default_level_maxtossspeed = GET_FLOAT_ARG(3);
				break;
			case CMD_LEVELORDER_SKIPTOSET:
				skiptoset = GET_INT_ARG(1);
				break;
			default:
				if (command && command[0])
					printf("Command '%s' not understood in level order!", command);
		}

		// Go to next line
		pos+=getNewLineStart(buf + pos);
	}

#undef CHKDEF

	// Variables without defaults will be auto populated.
	if(olbarstatus.sizex==0) {olbarstatus = lbarstatus;}

	if(!plifeUsed[0]){ plife[2][0] = plife[0][0]; plife[2][1] = plife[2][1] + (plife[0][1] - 10); }
	if(!plifeUsed[1]){ plife[3][0] = plife[1][0]; plife[3][1] = plife[3][1] + (plife[1][1] - 10); }

	if(!elifeUsed[0]){ elife[2][0] = elife[0][0]; elife[2][1] = elife[2][1] + (elife[0][1] - 27); }
	if(!elifeUsed[1]){ elife[3][0] = elife[1][0]; elife[3][1] = elife[3][1] + (elife[1][1] - 27); }

	if(!piconUsed[0]){ picon[2][0] = picon[0][0]; picon[2][1] = picon[2][1] + (picon[0][1] - 2); }
	if(!piconUsed[1]){ picon[3][0] = picon[1][0]; picon[3][1] = picon[3][1] + (picon[1][1] - 2); }

	if(!piconwUsed[0]){ piconw[2][0] = piconw[0][0]; piconw[2][1] = piconw[2][1] + (piconw[0][1] - 2); }
	if(!piconwUsed[1]){ piconw[3][0] = piconw[1][0]; piconw[3][1] = piconw[3][1] + (piconw[1][1] - 2); }

	if(!eiconUsed[0]){ eicon[2][0] = eicon[0][0]; eicon[2][1] = eicon[2][1] + (eicon[0][1] - 19); }
	if(!eiconUsed[1]){ eicon[3][0] = eicon[1][0]; eicon[3][1] = eicon[3][1] + (eicon[1][1] - 19); }

	if(!pmpUsed[0]){ pmp[0][0] = plife[0][0]; pmp[0][1] = plife[0][1] + 8; }
	if(!pmpUsed[1]){ pmp[1][0] = plife[1][0]; pmp[1][1] = plife[1][1] + 8; }
	if(!pmpUsed[2]){ pmp[2][0] = pmp[0][0]; pmp[2][1] = pmp[2][1] + (pmp[0][1] - 18); }
	if(!pmpUsed[3]){ pmp[3][0] = pmp[1][0]; pmp[3][1] = pmp[1][1] + (pmp[1][1] - 18); }

	if(!plifeXused[0]){ plifeX[0][0] = plife[0][0] + lbarstatus.sizex + 4; plifeX[0][1] = picon[0][1] + 7; }
	if(!plifeXused[1]){ plifeX[1][0] = plife[1][0] + lbarstatus.sizex + 4; plifeX[1][1] = picon[1][1] + 7; }
	if(!plifeXused[2]){ plifeX[2][0] = plife[2][0] + lbarstatus.sizex + 4; plifeX[2][1] = picon[2][1] + 7; }
	if(!plifeXused[3]){ plifeX[3][0] = plife[3][0] + lbarstatus.sizex + 4; plifeX[3][1] = picon[3][1] + 7; }
	for(i=0; i<4; i++) if(plifeX[i][2] == -1) plifeX[i][2] = 0;

	if(!plifeNused[0]){ plifeN[0][0] = plife[0][0] + lbarstatus.sizex + 11; plifeN[0][1] = picon[0][1]; }
	if(!plifeNused[1]){ plifeN[1][0] = plife[1][0] + lbarstatus.sizex + 11; plifeN[1][1] = picon[1][1]; }
	if(!plifeNused[2]){ plifeN[2][0] = plifeN[0][0]; plifeN[2][1] = picon[2][1]; }
	if(!plifeNused[3]){ plifeN[3][0] = plifeN[1][0]; plifeN[3][1] = picon[3][1]; }
	for(i=0; i<4; i++) if(plifeN[i][2] == -1) plifeN[i][2] = 3;

	if(!pnameJused[0]){ pnameJ[0][2] = pnameJ[0][4] = pnameJ[0][0] = plife[0][0] + 1; pnameJ[0][5] = pnameJ[0][1] = picon[0][1]; pnameJ[0][3] = 10 + pnameJ[0][5]; }
	if(!pnameJused[1]){ pnameJ[1][2] = pnameJ[1][4] = pnameJ[1][0] = plife[1][0] + 1; pnameJ[1][5] = pnameJ[1][1] = picon[1][1]; pnameJ[1][3] = 10 + pnameJ[1][5]; }
	if(!pnameJused[2]){ pnameJ[2][2] = pnameJ[2][4] = pnameJ[2][0] = plife[2][0] + 1; pnameJ[2][5] = pnameJ[2][1] = picon[2][1]; pnameJ[2][3] = 10 + pnameJ[2][5]; }
	if(!pnameJused[3]){ pnameJ[3][2] = pnameJ[3][4] = pnameJ[3][0] = plife[3][0] + 1; pnameJ[3][5] = pnameJ[3][1] = picon[3][1]; pnameJ[3][3] = 10 + pnameJ[3][5]; }
	for(i=0; i<4; i++) if(pnameJ[i][6] == -1) pnameJ[i][6] = 0;

	if(!pscoreUsed[0]){ pscore[0][0] = plife[0][0] + 1; pscore[0][1] = picon[0][1]; }
	if(!pscoreUsed[1]){ pscore[1][0] = plife[1][0] + 1; pscore[1][1] = picon[1][1]; }
	if(!pscoreUsed[2]){ pscore[2][0] = plife[2][0] + 1; pscore[2][1] = picon[2][1]; }
	if(!pscoreUsed[3]){ pscore[3][0] = plife[3][0] + 1; pscore[3][1] = picon[3][1]; }
	for(i=0; i<4; i++) if(pscore[i][6] == -1) pscore[i][6] = 0;

	if(!enameused[0]){ ename[0][0] = elife[0][0] + 1; ename[0][1] = eicon[0][1]; }
	if(!enameused[1]){ ename[1][0] = elife[1][0] + 1; ename[1][1] = eicon[1][1]; }
	if(!enameused[2]){ ename[2][0] = ename[0][0]; ename[2][1] = eicon[2][1]; }
	if(!enameused[3]){ ename[3][0] = ename[1][0]; ename[3][1] = eicon[3][1]; }
	for(i=0; i<4; i++) if(ename[i][2] == -1) ename[i][2] = 0;

	branch_name[0] = 0; //clear up branch name, so we can use it in game

	for(i=0; i<4; i++) if(pshoot[i][2] == -1) pshoot[i][2] = 2;
	if(timeloc[5] == -1) timeloc[5] = 3;

	if(!set)
		errormessage = "No levels were loaded!";

	lCleanup:

	if(buf)
		free(buf);

	if(!savelevel) savelevel = calloc(num_difficulties, sizeof(s_savelevel));

	if(errormessage)
		shutdown(1, "load_levelorder ERROR in %s at %d, msg: %s\n", filename, line, errormessage);
}


void free_level(s_level* lv)
{
	int i, j;
	s_spawn_script_list_node* templistnode;
	s_spawn_script_list_node* templistnode2;
	s_spawn_script_cache_node* tempnode;
	s_spawn_script_cache_node* tempnode2;
	if(!lv) return;
	//offload blending tables
	for(i=0; i<lv->numpalettes; i++)
	{
		for(j=0; j<MAX_BLENDINGS; j++)
		{
			if(lv->blendings[i][j]) free(lv->blendings[i][j]);
			lv->blendings[i][j] = NULL;
		}
	}
	//offload layers
	for(i=1; i<lv->numlayers; i++)
	{
		if(lv->layers[i].gfx.handle && lv->layers[i].gfx.handle!=background)
		{
			free(lv->layers[i].gfx.handle);
			lv->layers[i].gfx.handle = NULL;
		}
	}
	//offload textobjs
	for(i=0; i<lv->numtextobjs; i++)
	{
		if(lv->textobjs[i].text)
		{
			free(lv->textobjs[i].text);
			lv->textobjs[i].text = NULL;
		}
	}

	//offload scripts
	Script_Clear(&(lv->update_script), 2);
	Script_Clear(&(lv->updated_script), 2);
	Script_Clear(&(lv->key_script), 2);
	Script_Clear(&(lv->level_script), 2);
	Script_Clear(&(lv->endlevel_script), 2);

	for(i=0; i<lv->numspawns; i++)
	{
		if(lv->spawnpoints[i].spawn_script_list_head)
		{
			templistnode = lv->spawnpoints[i].spawn_script_list_head;
			lv->spawnpoints[i].spawn_script_list_head = NULL;
			while(templistnode)
			{
				templistnode2 = templistnode->next;
				templistnode->next = NULL;
				templistnode->spawn_script = NULL;
				free(templistnode);
				templistnode = templistnode2;
		    }
		}
	}

	tempnode = lv->spawn_script_cache_head;
	lv->spawn_script_cache_head = NULL;
	while(tempnode)
	{
		tempnode2 = tempnode->next;
		Script_Clear(tempnode->cached_spawn_script, 2);
		free(tempnode->cached_spawn_script);
		tempnode->cached_spawn_script = NULL;
		free(tempnode->filename);
		tempnode->filename = NULL;
		tempnode->next = NULL;
		free(tempnode);
		tempnode = tempnode2;
	}

	if(lv->spawnpoints) free(lv->spawnpoints);
	if(lv->layers) free(lv->layers);
	if(lv->layersref) free(lv->layersref);
	if(lv->panels) free(lv->panels);
	if(lv->frontpanels) free(lv->frontpanels);
	if(lv->bglayers) free(lv->bglayers);
	if(lv->fglayers) free(lv->fglayers);
	if(lv->genericlayers) free(lv->genericlayers);
	if(lv->waters) free(lv->waters);
	if(lv->textobjs) free(lv->textobjs);
	if(lv->holes) free(lv->holes);
	if(lv->walls) free(lv->walls);
	if(lv->palettes) free(lv->palettes);
	if(lv->blendings) free(lv->blendings);
	if(lv->textobjs) free(lv->textobjs);

	free(lv);
	lv = NULL;
}


void unload_level(){
	s_model* temp;

	unload_background();

	if(level){

		level->pos = 0;
		level->advancetime = 0;
		level->quake = 0;
		level->quaketime = 0;
		level->waiting = 0;

		printf("Level Unloading: '%s'\n", level->name);
		getRamStatus(BYTES);
		free(level->name);
		level->name = NULL;
		free_level(level);
		level = NULL;
		temp = getFirstModel();
		do {
			if(!temp) break;
			if((temp->unload&2)){
				cache_model_sprites(temp, 0);
			}
			if((temp->unload&1)){
				free_model(temp);
				temp = getCurrentModel();
			} else temp = getNextModel();
		} while(temp);
		printf("Done.\n");
		getRamStatus(BYTES);


	}

	advancex = 0;
	advancey = 0;
	nojoin = 0;
	current_spawn = 0;
	groupmin = 100;
	groupmax = 100;
	scrollminz = 0;
	scrollmaxz = 0;
	blockade = 0;
	level_completed = 0;
	tospeedup = 0;    // Reset so it sets to normal speed for the next level
	reached[0] = reached[1] = reached[2] = reached[3] = 0;    // TYPE_ENDLEVEL values reset after level completed //4player
	showtimeover = 0;
	pause = 0;
	endgame = 0;
	go_time = 0;
	debug_time = 0;
	neon_time = 0;
	time = 0;
	cameratype = 0;
	light[0] = 128;
	light[1] = 64;
	gfx_y_offset = gfx_x_offset = gfx_y_offset_adj = 0;    // Added so select screen graphics display correctly
}

char* llHandleCommandSpawnscript(ArgList* arglist, s_spawn_entry* next) {
	char* result = NULL;
	char* value;
	size_t len;

	s_spawn_script_cache_node* tempnode;
	s_spawn_script_cache_node* tempnode2;
	s_spawn_script_list_node* templistnode;

	value = GET_ARGP(1);

	tempnode = level->spawn_script_cache_head;

	templistnode = next->spawn_script_list_head;
	if(templistnode) {
		while(templistnode->next)
		{
			templistnode = templistnode->next;
		}
		templistnode->next = malloc(sizeof(s_spawn_script_list_node));
		templistnode = templistnode->next;
	} else	{
		next->spawn_script_list_head = malloc(sizeof(s_spawn_script_list_node));
		templistnode = next->spawn_script_list_head;
	}
	templistnode->spawn_script = NULL;
	templistnode->next = NULL;
	if(tempnode) {
		while(1) {
			if(stricmp(value, tempnode->filename)==0) {
				templistnode->spawn_script = tempnode->cached_spawn_script;
				break;
			} else {
				if(tempnode->next)
					tempnode = tempnode->next;
				else
					break;
			}
		}
	}
	if(!templistnode->spawn_script) {
		templistnode->spawn_script = alloc_script();
		Script_Init(templistnode->spawn_script, GET_ARGP(0), NULL, 0);

		if(load_script(templistnode->spawn_script, value)) {
			Script_Compile(templistnode->spawn_script);
			len = strlen(value);

			if(tempnode) {
				tempnode2 = malloc(sizeof(s_spawn_script_cache_node));
				tempnode2->cached_spawn_script = templistnode->spawn_script;
				tempnode2->filename = malloc(len + 1);
				strcpy(tempnode2->filename, value);
				tempnode2->filename[len] = 0;
				tempnode2->next = NULL;
				tempnode->next = tempnode2;
			} else {
				level->spawn_script_cache_head = malloc(sizeof(s_spawn_script_cache_node));
				level->spawn_script_cache_head->cached_spawn_script = templistnode->spawn_script;
				level->spawn_script_cache_head->filename = malloc(len + 1);
				level->spawn_script_cache_head->next = NULL;
				strcpy(level->spawn_script_cache_head->filename, value);
				level->spawn_script_cache_head->filename[len] = 0;
			}
		} else {
			result = "Failed loading spawn entry script!";
		}
	}
	return result;
}


void load_level(char *filename){
	char *buf;
	size_t size, len;
	ptrdiff_t pos, oldpos;
	char *command;
	char *value;
	char string[128] = {""};
	s_spawn_entry next;
	s_model *tempmodel, *cached_model;

	int i = 0, j = 0, crlf = 0;
	int usemap[MAX_BLENDINGS];
	char bgPath[128] = {""}, fnbuf[128];
	s_loadingbar bgPosi = {0, 0, 0, 0, 0, 0, 0};
	char musicPath[128] = {""};
	u32 musicOffset = 0;

	ArgList arglist;
	char argbuf[MAX_ARG_LEN+1] = "";

	ArgList arglist2;
	char argbuf2[MAX_ARG_LEN+1] = "";

	levelCommands cmd;
	levelCommands cmd2;
	int line = 0;
	char* errormessage = NULL;
	char* scriptname = NULL;
	Script* tempscript = NULL;
	s_drawmethod* dm;
	s_layer* bgl;
	int (*panels)[3] = NULL;
	int *order = NULL;
	int panelcount = 0;

	unload_level();

	printf("Level Loading:   '%s'\n", filename);



	getRamStatus(BYTES);

	if(isLoadingScreenTypeBg(loadingbg[1].set)) {
		if(custBkgrds) {
			strcpy(string, custBkgrds);
			strcat(string, "loading2");
			load_background(string, 0);
		} else {
			load_cached_background("data/bgs/loading2", 0);
		}
		clearscreen(vscreen);
		spriteq_clear();
		standard_palette(1);
	}

	if(isLoadingScreenTypeBar(loadingbg[1].set)) {
	    lifebar_colors();
	    init_colourtable();
	}

	update_loading(&loadingbg[1], -1, 1); // initialize the update screen

	memset(&next, 0, sizeof(s_spawn_entry));

	level = calloc(1,sizeof(s_level));
	if(!level) {
		errormessage = "load_level() #1 FATAL: Out of memory!";
		goto lCleanup;
	}
	len = strlen(filename);
	level->name = malloc(len + 1);

	if(!level->name) {
		errormessage = "load_level() #1 FATAL: Out of memory!";
		goto lCleanup;
	}
	strcpy(level->name, filename);

	if(buffer_pakfile(filename, &buf, &size)!=1) {
		errormessage = "Unable to load level file!";
		goto lCleanup;
	}

	level->settime = 100;    // Feb 25, 2005 - Default time limit set to 100
	level->nospecial = 0;    // Default set to specials can be used during bonus levels
	level->nohurt = 0;    // Default set to players can hurt each other during bonus levels
	level->nohit = 0;    // Default able to hit the other player
	level->spawn[0][2] = level->spawn[1][2] = level->spawn[2][2] = level->spawn[3][2] = 300;    // Set the default spawn a to 300
	level->setweap = 0;
	level->maxtossspeed = default_level_maxtossspeed;
	level->maxfallspeed = default_level_maxfallspeed;
	level->gravity = default_level_gravity;
	level->scrolldir = SCROLL_RIGHT;
	level->scrollspeed = 1;
	level->cameraxoffset = 0;
	level->camerazoffset = 0;
	level->bosses = 0;
	blendfx[BLEND_MULTIPLY] = 1;
	bgtravelled = 0;
	traveltime = 0;
	texttime = 0;
	nopause = 0;
	nofadeout = 0;
	noscreenshot = 0;
	panel_width = panel_height = frontpanels_loaded = 0;

	//reset_playable_list(1);

	// Now interpret the contents of buf line by line
	pos = 0;
	while(pos<size){
		line++;
		ParseArgs(&arglist,buf+pos,argbuf);
		command = GET_ARG(0);
		cmd = getLevelCommand(levelcmdlist, command);
		switch(cmd) {
			case CMD_LEVEL_LOADINGBG:
				load_background(GET_ARG(1), 0);
				errormessage = fill_s_loadingbar(&bgPosi, GET_INT_ARG(2), GET_INT_ARG(3), GET_INT_ARG(4), GET_INT_ARG(5), GET_INT_ARG(6), GET_INT_ARG(7), GET_INT_ARG(8), GET_INT_ARG(9));
				if (errormessage) goto lCleanup;
				standard_palette(1);
				lifebar_colors();
				init_colourtable();
				update_loading(&bgPosi, -1, 1); // initialize the update screen
				break;
			case CMD_LEVEL_MUSICFADE:
				memset(&next,0,sizeof(s_spawn_entry));
				next.musicfade = GET_FLOAT_ARG(1);
				break;
			case CMD_LEVEL_MUSIC:
				value = GET_ARG(1);
				strncpy(string, value, 128);
				musicOffset = atol(GET_ARG(2));
				if(loadingmusic) {
					music(string, 1, musicOffset);
					musicPath[0] = 0;
				} else {
					oldpos = pos;
					// Go to next line
					pos += getNewLineStart(buf + pos);
					#define GET_ARG2(z) arglist2.count > z ? arglist2.args[z] : ""
					if(pos<size) {
						ParseArgs(&arglist2,buf+pos,argbuf2);
						command = GET_ARG2(0);
						cmd2 = getLevelCommand(levelcmdlist, command);
					} else
						cmd2 = (levelCommands) 0;

					if(cmd2 == CMD_LEVEL_AT) {
						if(next.musicfade == 0) memset(&next,0,sizeof(s_spawn_entry));
						strncpy(next.music, string, 128);
						next.musicoffset = musicOffset;
					} else {
						strncpy(musicPath, string, 128);
					}
					pos = oldpos;
					#undef GET_ARG2
				}
				break;
			case CMD_LEVEL_ALLOWSELECT:
				load_playable_list(buf+pos);
				break;
			case CMD_LEVEL_LOAD:
				#ifdef DEBUG
				printf("load_level: load %s, %s\n", GET_ARG(1), filename);
				#endif
				tempmodel = findmodel(GET_ARG(1));
				if (!tempmodel)
					load_cached_model(GET_ARG(1), filename, GET_INT_ARG(2));
				else
					update_model_loadflag(tempmodel, GET_INT_ARG(2));
				break;
			case CMD_LEVEL_BACKGROUND:
			case CMD_LEVEL_BGLAYER:
			case CMD_LEVEL_LAYER:
			case CMD_LEVEL_FGLAYER:
				__realloc(level->layers, level->numlayers);
				bgl = &(level->layers[level->numlayers]);

				if(cmd==CMD_LEVEL_BACKGROUND || cmd==CMD_LEVEL_BGLAYER){
					i = 0;
					bgl->z = MIN_INT;
				}else{
					i = 1;
					bgl->z =  GET_FLOAT_ARG(2);
					if(cmd==CMD_LEVEL_FGLAYER) bgl->z += FRONTPANEL_Z;
				}

				if(cmd==CMD_LEVEL_BACKGROUND){
					if(bgPath[0]){
						errormessage = "Background is already defined!";
						goto lCleanup;
					}
					value = GET_ARG(1);
					strncpy(bgPath, value, strlen(value)+1);
					bgl->oldtype = bgt_background;
				}else if(cmd==CMD_LEVEL_BGLAYER) bgl->oldtype = bgt_bglayer;
				else if(cmd==CMD_LEVEL_FGLAYER) bgl->oldtype = bgt_fglayer;
				else if(cmd==CMD_LEVEL_LAYER) bgl->oldtype = bgt_generic;

				dm = &(bgl->drawmethod);
				*dm = plainmethod;

				bgl->xratio = GET_FLOAT_ARG(i+2); // x ratio
				bgl->zratio = GET_FLOAT_ARG(i+3); // z ratio
				bgl->xoffset = GET_INT_ARG(i+4); // x start
				bgl->zoffset = GET_INT_ARG(i+5); // z start
				bgl->xspacing = GET_INT_ARG(i+6); // x spacing
				bgl->zspacing = GET_INT_ARG(i+7); // z spacing
				dm->xrepeat = GET_INT_ARG(i+8); // x repeat
				dm->yrepeat = GET_INT_ARG(i+9); // z repeat
				dm->transbg = GET_INT_ARG(i+10); // transparency
				dm->alpha = GET_INT_ARG(i+11); // alpha
				dm->water.watermode = GET_INT_ARG(i+12); // amplitude
				if(dm->water.watermode==3){
					dm->water.beginsize = GET_FLOAT_ARG(i+13); // beginsize
					dm->water.endsize = GET_FLOAT_ARG(i+14); // endsize
					dm->water.perspective = GET_INT_ARG(i+15); // amplitude
				}else{
					dm->water.amplitude = GET_INT_ARG(i+13); // amplitude
					dm->water.wavelength = GET_FLOAT_ARG(i+14); // wavelength
					dm->water.wavespeed = GET_FLOAT_ARG(i+15); // waterspeed
				}
				bgl->bgspeedratio = GET_FLOAT_ARG(i+16); // moving
				bgl->quake = GET_INT_ARG(i+17); // quake
				bgl->neon = GET_INT_ARG(i+18); // neon
				bgl->enabled = 1; // enabled

				if((GET_ARG(i+2))[0]==0) bgl->xratio = (cmd==CMD_LEVEL_FGLAYER?1.5:0.5);
				if((GET_ARG(i+3))[0]==0) bgl->zratio = (cmd==CMD_LEVEL_FGLAYER?1.5:0.5);

				if((GET_ARG(i+8))[0]==0) dm->xrepeat = -1;
				if((GET_ARG(i+9))[0]==0) dm->yrepeat = -1;
				if(cmd==CMD_LEVEL_BACKGROUND && (GET_ARG(i+16))[0]==0) bgl->bgspeedratio = 1.0;

				if(blendfx_is_set==0 && dm->alpha) blendfx[dm->alpha-1] = 1;

				if(cmd!=CMD_LEVEL_BACKGROUND) load_layer(GET_ARG(1), level->numlayers);
				level->numlayers++;
				break;
			case CMD_LEVEL_WATER:
				__realloc(level->layers, level->numlayers);
				bgl = &(level->layers[level->numlayers]);
				dm = &(bgl->drawmethod);
				*dm = plainmethod;

				bgl->oldtype = bgt_water;
				bgl->z = MIN_INT+1;

				bgl->xratio = 0.5; // x ratio
				bgl->zratio = 0.5; // z ratio
				bgl->xoffset = 0; // x start
				bgl->zoffset = NaN; // z start
				bgl->xspacing = 0; // x spacing
				bgl->zspacing = 0; // z spacing
				dm->xrepeat = -1; // x repeat
				dm->yrepeat = 1; // z repeat
				dm->transbg = 0; // transparency
				dm->alpha = 0; // alpha
				dm->water.watermode = 2; // amplitude
				dm->water.amplitude = GET_INT_ARG(2); // amplitude
				dm->water.wavelength = 40; // wavelength
				dm->water.wavespeed = 1.0; // waterspeed
				bgl->bgspeedratio = 0; // moving
				bgl->enabled = 1; // enabled

				if(dm->water.amplitude<1)dm->water.amplitude = 1;

				load_layer(GET_ARG(1), level->numlayers);
				level->numlayers++;
				break;
			case CMD_LEVEL_DIRECTION:
				value = GET_ARG(1);
				if(stricmp(value, "up")==0) level->scrolldir = SCROLL_UP;
				else if(stricmp(value, "down")==0) level->scrolldir = SCROLL_DOWN;
				else if(stricmp(value, "left")==0) level->scrolldir = SCROLL_LEFT;
				else if(stricmp(value, "both")==0 || stricmp(value, "rightleft")==0) level->scrolldir = SCROLL_BOTH;
				else if(stricmp(value, "leftright")==0) level->scrolldir = SCROLL_LEFTRIGHT;
				else if(stricmp(value, "right")==0) level->scrolldir = SCROLL_RIGHT;
				else if(stricmp(value, "in")==0) level->scrolldir = SCROLL_INWARD;
				else if(stricmp(value, "out")==0) level->scrolldir = SCROLL_OUTWARD;
				else if(stricmp(value, "inout")==0) level->scrolldir = SCROLL_INOUT;
				else if(stricmp(value, "outin")==0) level->scrolldir = SCROLL_OUTIN;
				break;
			case CMD_LEVEL_FACING:
				level->facing = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ROCK:
				level->rocking = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_BGSPEED:
				level->bgspeed = GET_FLOAT_ARG(1);
				if(GET_INT_ARG(2))level->bgspeed*=-1;
				break;
			case CMD_LEVEL_SCROLLSPEED:
				level->scrollspeed = GET_FLOAT_ARG(1);
				break;
			case CMD_LEVEL_MIRROR:
				level->mirror = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_BOSSMUSIC:
				strncpy(level->bossmusic, GET_ARG(1), 255);
				level->bossmusic_offset = atol(GET_ARG(2));
				break;
			case CMD_LEVEL_NOSAVE:
				nosave = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_NOFADEOUT:
				nofadeout = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_NOPAUSE:
				nopause = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_NOSCREENSHOT:
				noscreenshot = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_SETTIME:
				// If settime is found, overwrite the default 100 for time limit
				level->settime = GET_INT_ARG(1);
				if(level->settime > 100 || level->settime < 0) level->settime = 100;
				// Feb 25, 2005 - Time limit loaded from individual .txt file
				break;
			case CMD_LEVEL_SETWEAP:
				// Specify a weapon for each level
				level->setweap = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_NOTIME:
				// Flag to if the time should be displayed 1 = no, else yes
				level->notime = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_NORESET:
				// Flag to if the time should be reset when players respawn 1 = no, else yes
				level->noreset = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_NOSLOW:
				// If set, level will not slow down when bosses are defeated
				level->noslow = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_TYPE:
				level->type = GET_INT_ARG(1);    // Level type - 1 = bonus, else regular
				level->nospecial = GET_INT_ARG(2);    // Can use specials during bonus levels (default 0 - yes)
				level->nohurt = GET_INT_ARG(3);    // Can hurt other players during bonus levels (default 0 - yes)
				break;
			case CMD_LEVEL_NOHIT:
				level->nohit = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_GRAVITY:
				level->gravity = GET_FLOAT_ARG(1);
				level->gravity /= 100;
				break;
			case CMD_LEVEL_MAXFALLSPEED:
				level->maxfallspeed = GET_FLOAT_ARG(1);
				level->maxfallspeed /= 10;
				break;
			case CMD_LEVEL_MAXTOSSSPEED:
				level->maxtossspeed = GET_FLOAT_ARG(1);
				level->maxtossspeed /= 10;
				break;
			case CMD_LEVEL_CAMERATYPE:
				cameratype = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_CAMERAOFFSET:
				level->cameraxoffset = GET_INT_ARG(1);
				level->camerazoffset = GET_INT_ARG(2);
				break;
			case CMD_LEVEL_SPAWN1: case CMD_LEVEL_SPAWN2: case CMD_LEVEL_SPAWN3: case CMD_LEVEL_SPAWN4:
				switch(cmd) {
					case CMD_LEVEL_SPAWN1: i = 0; break;
					case CMD_LEVEL_SPAWN2: i = 1; break;
					case CMD_LEVEL_SPAWN3: i = 2; break;
					case CMD_LEVEL_SPAWN4: i = 3; break;
					default:
						assert(0);
				}
				level->spawn[i][0] = GET_INT_ARG(1);
				level->spawn[i][1] = GET_INT_ARG(2);
				level->spawn[i][2] = GET_INT_ARG(3);

				if(level->spawn[i][1] > 232 || level->spawn[i][1] < 0) level->spawn[i][1] = 232;
				if(level->spawn[i][2] < 0) level->spawn[i][2] = 300;
				break;
			case CMD_LEVEL_FRONTPANEL:
			case CMD_LEVEL_PANEL:
				if(level->numlayers==0) {
					__realloc(level->layers,level->numlayers);
					level->numlayers = 1; // reserve for background
				}
				
				__realloc(level->layers,level->numlayers);
				bgl = &(level->layers[level->numlayers]);
				dm = &(bgl->drawmethod);
				*dm = plainmethod;

				bgl->oldtype = (cmd==CMD_LEVEL_FRONTPANEL?bgt_frontpanel:bgt_panel);

				if(bgl->oldtype==bgt_panel) {
					bgl->order = panelcount+1;
					__realloc(panels, panelcount);
					panels[panelcount++][0] = level->numlayers;
					bgl->z = PANEL_Z;
					bgl->xratio = 0; // x ratio
					bgl->zratio = 0; // z ratio
					dm->xrepeat = 1; // x repeat
				}else {
					frontpanels_loaded++;
					bgl->z = FRONTPANEL_Z;
					bgl->xratio = -0.4; // x ratio
					bgl->zratio = 1; // z ratio
					dm->xrepeat = -1; // x repeat
				}

				bgl->bgspeedratio = 0;
				bgl->zoffset = 0;
				dm->yrepeat = 1; // z repeat
				dm->transbg = 1; // transparency
				bgl->enabled = 1; // enabled
				bgl->quake = 1; // accept quake and rock

				load_layer(GET_ARG(1), level->numlayers);
				level->numlayers++;

				if(stricmp(GET_ARG(2), "none")!=0 && GET_ARG(2)[0])
				{
				__realloc(level->layers,level->numlayers);
				bgl = &(level->layers[level->numlayers]);
				*bgl = *(bgl-1);
				panels[panelcount-1][1] = level->numlayers;

				bgl->z = NEONPANEL_Z;
				bgl->neon = 1;
				bgl->gfx.handle = NULL;
				load_layer(GET_ARG(2), level->numlayers);
				level->numlayers++;
				}

				if(stricmp(GET_ARG(3), "none")!=0 && GET_ARG(3)[0])
				{
				__realloc(level->layers,level->numlayers);
				bgl = &(level->layers[level->numlayers]);
				*bgl = *(bgl-1);
				panels[panelcount-1][2] = level->numlayers;
				dm = &(bgl->drawmethod);

				bgl->z = SCREENPANEL_Z;
				bgl->neon = 0;
				dm->alpha = 1;
				bgl->gfx.handle = NULL;
				load_layer(GET_ARG(3), level->numlayers);
				level->numlayers++;
				}
				break;
			case CMD_LEVEL_STAGENUMBER:
				current_stage = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ORDER:
				// Append to order
				value = GET_ARG(1);
				i = 0;
				while(value[i] ){
					j = value[i];
					// WTF ?
					if(j>='A' && j<='Z') j-='A';
					else if(j>='a' && j<='z') j-='a';
					else {
						errormessage = "Illegal character in panel order!";
						goto lCleanup;
					}
					__realloc(order, level->numpanels);
					__realloc(level->panels, level->numpanels);
					order[level->numpanels] = j;
					level->numpanels++;
					i++;
				}
				break;
			case CMD_LEVEL_HOLE:
				value = GET_ARG(1);    // ltb    1-18-05  adjustable hole sprites

				if(holesprite < 0) {
					if(testpackfile(value, packfile) >= 0) holesprite = loadsprite(value,0,0,pixelformat);// ltb 1-18-05  load new hole sprite
					else holesprite = loadsprite("data/sprites/hole",0,0,pixelformat);    // ltb 1-18-05  no new sprite load the default
				}

				__realloc(level->holes, level->numholes);
				level->holes[level->numholes][0] = GET_FLOAT_ARG(1);
				level->holes[level->numholes][1] = GET_FLOAT_ARG(2);
				level->holes[level->numholes][2] = GET_FLOAT_ARG(3);
				level->holes[level->numholes][3] = GET_FLOAT_ARG(4);
				level->holes[level->numholes][4] = GET_FLOAT_ARG(5);
				level->holes[level->numholes][5] = GET_FLOAT_ARG(6);
				level->holes[level->numholes][6] = GET_FLOAT_ARG(7);

				if(!level->holes[level->numholes][1]) level->holes[level->numholes][1] = 240;
				if(!level->holes[level->numholes][2]) level->holes[level->numholes][2] = 12;
				if(!level->holes[level->numholes][3]) level->holes[level->numholes][3] = 1;
				if(!level->holes[level->numholes][4]) level->holes[level->numholes][4] = 200;
				if(!level->holes[level->numholes][5]) level->holes[level->numholes][5] = 287;
				if(!level->holes[level->numholes][6]) level->holes[level->numholes][6] = 45;
				level->numholes++;
				break;
			case CMD_LEVEL_WALL:
				__realloc(level->walls, level->numwalls);
				level->walls[level->numwalls][0] = GET_FLOAT_ARG(1);
				level->walls[level->numwalls][1] = GET_FLOAT_ARG(2);
				level->walls[level->numwalls][2] = GET_FLOAT_ARG(3);
				level->walls[level->numwalls][3] = GET_FLOAT_ARG(4);
				level->walls[level->numwalls][4] = GET_FLOAT_ARG(5);
				level->walls[level->numwalls][5] = GET_FLOAT_ARG(6);
				level->walls[level->numwalls][6] = GET_FLOAT_ARG(7);
				level->walls[level->numwalls][7] = GET_FLOAT_ARG(8);
				level->numwalls++;
				break;
			case CMD_LEVEL_PALETTE:
				__realloc(level->palettes, level->numpalettes);
				__realloc(level->blendings, level->numpalettes);
				for(i=0; i<MAX_BLENDINGS; i++)
					usemap[i] = GET_INT_ARG(i+2);
				if(!load_palette(level->palettes[level->numpalettes], GET_ARG(1)) ||
				!create_blending_tables(level->palettes[level->numpalettes], level->blendings[level->numpalettes], usemap))
				{
					errormessage = "Failed to create colour conversion tables for level! (Out of memory?)";
					goto lCleanup;
				}
				level->numpalettes++;
				break;
			case CMD_LEVEL_UPDATESCRIPT: case CMD_LEVEL_UPDATEDSCRIPT: case CMD_LEVEL_KEYSCRIPT:
			case CMD_LEVEL_LEVELSCRIPT: case CMD_LEVEL_ENDLEVELSCRIPT:
				switch(cmd) {
					case CMD_LEVEL_UPDATESCRIPT:
						tempscript = &(level->update_script);
						scriptname = "levelupdatescript";
						break;
					case CMD_LEVEL_UPDATEDSCRIPT:
						tempscript = &(level->updated_script);
						scriptname = "levelupdatedscript";
						break;
					case CMD_LEVEL_KEYSCRIPT:
						tempscript = &(level->key_script);
						scriptname = "levelkeyscript";
						break;
					case CMD_LEVEL_LEVELSCRIPT:
						tempscript = &(level->level_script);
						scriptname = command;
						break;
					case CMD_LEVEL_ENDLEVELSCRIPT:
						tempscript = &(level->endlevel_script);
						scriptname = command;
						break;
					default:
						assert(0);

				}
				value = GET_ARG(1);
				if(!Script_IsInitialized(tempscript))
					Script_Init(tempscript, scriptname, value, 1);
				else {
					errormessage = "Multiple level script!";
					goto lCleanup;
				}
				if(load_script(tempscript, value))
					Script_Compile(tempscript);
				else {
					errormessage = "Failed loading script!";
					goto lCleanup;
				}
				break;
			case CMD_LEVEL_BLOCKED:
				level->exit_blocked = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ENDHOLE:
				level->exit_hole = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_WAIT:
				// Clear spawn thing, set wait state instead
				memset(&next,0,sizeof(s_spawn_entry));
				next.wait = 1;
				break;
			case CMD_LEVEL_NOJOIN: case CMD_LEVEL_CANJOIN:
				// Clear spawn thing, set nojoin state instead
				memset(&next,0,sizeof(s_spawn_entry));
				next.nojoin = 1;
				break;
			case CMD_LEVEL_SHADOWCOLOR:
				memset(&next,0,sizeof(s_spawn_entry));
				next.shadowcolor = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_SHADOWALPHA:
				memset(&next,0,sizeof(s_spawn_entry));
				next.shadowalpha = GET_INT_ARG(1);
				if(blendfx_is_set==0 && next.shadowalpha>0) blendfx[next.shadowalpha-1] = 1;
				break;
			case CMD_LEVEL_LIGHT:
				memset(&next,0,sizeof(s_spawn_entry));
				next.light[0] = GET_INT_ARG(1);
				next.light[1] = GET_INT_ARG(2);
				if(next.light[1] == 0) next.light[1] = 64;
				break;
			case CMD_LEVEL_SCROLLZ: case CMD_LEVEL_SCROLLX:
				// now z scroll can be limited by this
				// if the level is vertical, use scrollx, only different in name ..., but makes more sense
				memset(&next,0,sizeof(s_spawn_entry));
				next.scrollminz = GET_INT_ARG(1);
				next.scrollmaxz = GET_INT_ARG(2);
				if(next.scrollminz <= 0) next.scrollminz = 0;
				if(next.scrollmaxz <= 0) next.scrollmaxz = 0;
				break;
			case CMD_LEVEL_BLOCKADE:
				// now x scroll can be limited by this
				memset(&next,0,sizeof(s_spawn_entry));
				next.blockade = GET_INT_ARG(1);
				if(next.blockade==0) next.blockade = -1;
				break;
			case CMD_LEVEL_SETPALETTE:
				// change system palette
				memset(&next,0,sizeof(s_spawn_entry));
				next.palette = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_GROUP:
				// Clear spawn thing, set group instead
				memset(&next,0,sizeof(s_spawn_entry));
				next.groupmin = GET_INT_ARG(1);
				next.groupmax = GET_INT_ARG(2);
				if(next.groupmax < 1) next.groupmax = 1;
				if(next.groupmin < 1) next.groupmin = 100;
				break;
			case CMD_LEVEL_SPAWN:
				// Back to defaults
				next.spawnplayer_count = 0;
				memset(&next,0,sizeof(s_spawn_entry));
				next.index = next.itemindex = next.weaponindex = -1;
				// Name of entry to be spawned
				// Load model (if not loaded already)
				cached_model = findmodel(GET_ARG(1));
				#ifdef DEBUG
				printf("load_level: spawn %s, %s, cached: %p\n", GET_ARG(1), filename, cached_model);
				#endif
				if(cached_model) tempmodel = cached_model;
				else tempmodel = load_cached_model(GET_ARG(1), filename, 0);
				if(tempmodel)
				{
					next.name = tempmodel->name;
					next.index = get_cached_model_index(next.name);
					next.spawntype = 1;     //2011_03_23, DC; Spawntype 1 (level spawn).
					crlf = 1;
				}
				break;
			case CMD_LEVEL_2PSPAWN:
				// Entity only for 2p game
				next.spawnplayer_count = 1;
				break;
			case CMD_LEVEL_3PSPAWN:
				// Entity only for 3p game
				next.spawnplayer_count = 2;
				break;
			case CMD_LEVEL_4PSPAWN:
				// Entity only for 4p game
				next.spawnplayer_count = 3;
				break;
			case CMD_LEVEL_BOSS:
				next.boss = GET_INT_ARG(1);
				level->bosses += next.boss ? 1 : 0;
				break;
			case CMD_LEVEL_FLIP:
				next.flip = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_HEALTH:
				next.health[0] = next.health[1] = next.health[2] = next.health[3] = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_2PHEALTH:
				// Health the spawned entity will have if 2 people are playing
				next.health[1] = next.health[2] = next.health[3] = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_3PHEALTH:
				// Health the spawned entity will have if 2 people are playing
				next.health[2] = next.health[3] = GET_INT_ARG(1);  //4player
				break;
			case CMD_LEVEL_4PHEALTH:
				// Health the spawned entity will have if 2 people are playing
				next.health[3] = GET_INT_ARG(1);  //4player
				break;
			case CMD_LEVEL_MP:
				// mp values to put max mp for player by tails
				next.mp = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_SCORE:
				// So score can be overriden in the levels .txt file
				next.score = GET_INT_ARG(1);
				if(next.score < 0) next.score = 0;    // So negative values cannot be added
				next.multiple = GET_INT_ARG(2);
				if(next.multiple < 0) next.multiple = 0;    // So negative values cannot be added
				break;
			case CMD_LEVEL_NOLIFE:
				// Flag to determine if entity life is shown when hit
				next.nolife = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ALIAS:
				// Alias (name displayed) of entry to be spawned
				strncpy(next.alias, GET_ARG(1), MAX_NAME_LEN);
				break;
			case CMD_LEVEL_MAP:
				// Colourmap for new entry
				next.colourmap = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ALPHA:
				// Item to be contained by new entry
				next.alpha = GET_INT_ARG(1);
				if(blendfx_is_set==0 && next.alpha) blendfx[next.alpha-1] = 1;
				break;
			case CMD_LEVEL_DYING:
				// Used to store which remake corresponds with the dying flash
				next.dying = GET_INT_ARG(1);
				next.per1 = GET_INT_ARG(2);
				next.per2 = GET_INT_ARG(3);
				break;
			case CMD_LEVEL_ITEM: case CMD_LEVEL_2PITEM: case CMD_LEVEL_3PITEM: case CMD_LEVEL_4PITEM:
				switch(cmd) {
					// Item to be contained by new entry
					case CMD_LEVEL_ITEM:   next.itemplayer_count = 0; break;
					case CMD_LEVEL_2PITEM: next.itemplayer_count = 1; break;
					case CMD_LEVEL_3PITEM: next.itemplayer_count = 2; break;
					case CMD_LEVEL_4PITEM: next.itemplayer_count = 3; break;
					default: assert(0);
				}
				// Load model (if not loaded already)
				cached_model = findmodel(GET_ARG(1));
				if(cached_model)
					tempmodel = cached_model;
				else
					tempmodel = load_cached_model(GET_ARG(1), filename, 0);
				if(tempmodel) {
					next.item = tempmodel->name;
					next.itemindex = get_cached_model_index(next.item);
				}
				break;
			case CMD_LEVEL_ITEMMAP:
				next.itemmap = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ITEMHEALTH:
				next.itemhealth = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ITEMALIAS:
				strncpy(next.itemalias, GET_ARG(1), MAX_NAME_LEN);
				break;
			case CMD_LEVEL_WEAPON:
				//spawn with a weapon 2007-2-12 by UTunnels
				// Load model (if not loaded already)
				cached_model = findmodel(GET_ARG(1));
				if(cached_model) tempmodel = cached_model;
				else tempmodel = load_cached_model(GET_ARG(1), filename, 0);
				if(tempmodel) {
					next.weapon = tempmodel->name;
					next.weaponindex = get_cached_model_index(next.weapon);
				}
				break;
			case CMD_LEVEL_AGGRESSION:
				// Aggression can be set per spawn.
				next.aggression = next.aggression + GET_INT_ARG(1);
				break;
			case CMD_LEVEL_CREDIT:
				next.credit = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_ITEMTRANS: case CMD_LEVEL_ITEMALPHA:
				next.itemtrans = GET_INT_ARG(1);
				break;
			case CMD_LEVEL_COORDS:
				next.x = GET_FLOAT_ARG(1);
				next.z = GET_FLOAT_ARG(2);
				next.a = GET_FLOAT_ARG(3);
				break;
			case CMD_LEVEL_SPAWNSCRIPT:
				errormessage = llHandleCommandSpawnscript(&arglist, &next);
				if (errormessage)
					goto lCleanup;
				break;
			case CMD_LEVEL_AT:
				// Place entry on queue
				next.at = GET_INT_ARG(1);

				__realloc(level->spawnpoints, level->numspawns);
				memcpy(&level->spawnpoints[level->numspawns], &next, sizeof(s_spawn_entry));
				level->numspawns++;

				// And clear...
				memset(&next,0,sizeof(s_spawn_entry));
				break;
			default:
				if(command && command[0]){
					if(!handle_txt_include(command, &arglist, &filename, fnbuf, &buf, &pos, &size))
						printf("Command '%s' not understood in file '%s'!\n", command, filename);
				}
		}

		// Go to next line
		pos += getNewLineStart(buf + pos);

		if(isLoadingScreenTypeBar(bgPosi.set) || isLoadingScreenTypeBg(bgPosi.set))
			update_loading(&bgPosi, pos, size);
			//update_loading(bgPosi[0]+videomodes.hShift, bgPosi[1]+videomodes.vShift, bgPosi[2], bgPosi[3]+videomodes.hShift, bgPosi[4]+videomodes.vShift, pos, size, bgPosi[5]);
		else
			update_loading(&loadingbg[1], pos, size);
	}

	if(level->numpanels < 1) {
		errormessage = "Level error: level has no panels";
		goto lCleanup;
	}

	if(bgPath[0])
	{
		clearscreen(vscreen);
		spriteq_clear();
		load_background(bgPath, 1);
	}
	else if(background) unload_background();

	if(level->numlayers) {
		
		for(i=0; i<level->numlayers; i++){
			bgl = &(level->layers[i]);
			switch(bgl->oldtype){
			case bgt_water: // default water hack
				bgl->zoffset = background?background->height:level->layers[0].height;
				dm = &(bgl->drawmethod);
				if(level->rocking) {
					dm->water.watermode =3;
					dm->water.beginsize = 1.0;
					dm->water.endsize = 1 + bgl->height/11.0;
					dm->water.perspective = 0;
					bgl->bgspeedratio =2;
				}
				break;
			case bgt_panel:
				panel_width = bgl->width;
				panel_height = bgl->height;
			case bgt_frontpanel:
				if(level->scrolldir&(SCROLL_UP|SCROLL_DOWN))
					bgl->zratio = 1;
				break;
			case bgt_background:
				bgl->gfx.screen=background;
				bgl->width=background->width;
				bgl->height=background->height;
				level->background = bgl;
				break;
			default:
				break;
			}
			load_layer(NULL, i);
		}

		if(level->background)
		{
			__realloc(level->layersref,level->numlayersref);
			level->layersref[level->numlayersref] = *(level->background);
			level->background = (s_layer*)level->numlayersref++;
		}


		// non-panel type layers
		for(i=0; i<level->numlayers; i++){
			bgl = &(level->layers[i]);
			if(bgl->oldtype != bgt_panel && bgl->oldtype != bgt_background){
				__realloc(level->layersref,level->numlayersref);
				level->layersref[level->numlayersref] = *bgl;
				bgl = &(level->layersref[level->numlayersref]);
				switch(bgl->oldtype){
				case bgt_bglayer:
					__realloc(level->bglayers,level->numbglayers);
					level->bglayers[level->numbglayers++] = (s_layer*)level->numlayersref;
					break;
				case bgt_fglayer:
					__realloc(level->fglayers,level->numfglayers);
					level->fglayers[level->numfglayers++] = (s_layer*)level->numlayersref;
					break;
				case bgt_water:
					__realloc(level->waters,level->numwaters);
					level->waters[level->numwaters++] = (s_layer*)level->numlayersref;
					break;
				case bgt_generic:
					__realloc(level->genericlayers,level->numgenericlayers);
					level->genericlayers[level->numgenericlayers++] = (s_layer*)level->numlayersref;
					break;
				case bgt_frontpanel:
					bgl->xoffset = level->numfrontpanels*bgl->width;
					bgl->xspacing = (frontpanels_loaded-1)*bgl->width;
					__realloc(level->frontpanels,level->numfrontpanels);
					level->frontpanels[level->numfrontpanels++] = (s_layer*)level->numlayersref;
					break;
				default:
					break;
				}
				level->numlayersref++;
			}
		}

		//panels, normal neon screen
		for(i=0; i<level->numpanels; i++){
			for(j=0; j<3; j++){
				if(panels[order[i]][j]){
					__realloc(level->layersref,level->numlayersref);
					level->layersref[level->numlayersref] = level->layers[panels[order[i]][j]];
					bgl = &(level->layersref[level->numlayersref]);
					bgl->xoffset = panel_width*i;
					level->panels[i][j] = (s_layer*)level->numlayersref;
					level->numlayersref++;
				}
			}
		}

		//fix realloc junk pointers
		bgl = level->layersref;
		level->background = bgl + (size_t)level->background;
		for(i=0; i<level->numpanels; i++)
			for(j=0; j<3; j++) level->panels[i][j] = bgl + (size_t)level->panels[i][j];
		for(i=0; i<level->numfrontpanels; i++)
			level->frontpanels[i] = bgl + (size_t)level->frontpanels[i];
		for(i=0; i<level->numbglayers; i++)
			level->bglayers[i] = bgl + (size_t)level->bglayers[i];
		for(i=0; i<level->numfglayers; i++)
			level->fglayers[i] = bgl + (size_t)level->fglayers[i];
		for(i=0; i<level->numgenericlayers; i++)
			level->genericlayers[i] = bgl + (size_t)level->genericlayers[i];
		for(i=0; i<level->numwaters; i++)
			level->waters[i] = bgl + (size_t)level->waters[i];

	}

	if(musicPath[0]) music(musicPath, 1, musicOffset);

	timeleft = level->settime * COUNTER_SPEED;    // Feb 24, 2005 - This line moved here to set custom time
	level->width = level->numpanels * panel_width;

	if(level->width<videomodes.hRes) level->width = videomodes.hRes;

	if(level->scrolldir&SCROLL_LEFT)
		advancex = (float)(level->width-videomodes.hRes);
	else if(level->scrolldir&SCROLL_INWARD)
		advancey = (float)(panel_height-videomodes.vRes);

	if(crlf) printf("\n");
	printf("Level Loaded:    '%s'\n", level->name);
	totalram = getSystemRam(BYTES); freeram = getFreeRam(BYTES); usedram = getUsedRam(BYTES);
	printf("Total Ram: %"PRIu64" Bytes\n Free Ram: %"PRIu64" Bytes\n Used Ram: %"PRIu64" Bytes\n", totalram, freeram, usedram);
	printf("Total sprites mapped: %d\n\n", sprites_loaded);

	lCleanup:

	if (panels) free(panels);
	if (order) free(order);

	if(buf != NULL)
		free(buf);

	if(errormessage)
		shutdown(1, "ERROR: load_level, file %s, line %d, message: %s", filename, line, errormessage);
}





/////////////////////////////////////////////////////////////////////////////
//  Status                                                                  //
/////////////////////////////////////////////////////////////////////////////
void bar(int x, int y, int value, int maxvalue, s_barstatus* pstatus)
{
	int max = 100, len, alphabg=0, bgindex, colourindex;
	int forex, forey, forew,foreh, bkw, bkh;
	s_drawmethod dm = plainmethod;

	x += pstatus->offsetx;
	y += pstatus->offsety;

	if(pstatus->orientation==horizontalbar)    max = pstatus->sizex;
	else if(pstatus->orientation==verticalbar) max = pstatus->sizey;
	else return;

	if (value > maxvalue) value = maxvalue;

	if(pstatus->type==valuebar)
	{
		if(max>maxvalue) max = maxvalue;
		if(colorbars)
		{
			if(value<=max/4) {bgindex = 0; colourindex = 1;}
			else if(value<=max/2) {bgindex=0; colourindex = 2;}
			else if(value<=max) {bgindex=0; colourindex = 3;}
			else {colourindex = value/(max+1) + 3; bgindex = colourindex-1;}
			if(colourindex>10) colourindex = bgindex = 10;
		}
		else
		{
			colourindex = 2;
			bgindex = value>max? 5:1;
		}

		len = value%max;
		if(!len && value) len = max;
		alphabg = value>max?0:(BLEND_MULTIPLY+1);
	}
	else if(pstatus->type==percentagebar)
	{
		colourindex = colorbars?(value*5/maxvalue+1):2;
		bgindex = colorbars?8:1;
		len = value * max / maxvalue;
		if(!len && value) len = 1;
		alphabg = BLEND_MULTIPLY+1;
	}
	else return;

	if(pstatus->orientation==horizontalbar)
	{
		forex = pstatus->direction?(x + max - len):x;
		forey = y;
		forew = len; bkw = max;
		bkh = foreh = pstatus->sizey;
	}
	else if(pstatus->orientation==verticalbar)
	{
		forex = x;
		forey = pstatus->direction?y:(y + max - len);
		bkw = forew = pstatus->sizex;
		foreh = len; bkh = max;
	}
	else return;

	if(!pstatus->colourtable) pstatus->colourtable = &hpcolourtable;

	dm.alpha = alphabg;
	spriteq_add_box(x+1, y+1, bkw, bkh, HUD_Z+1+pstatus->backlayer, (*pstatus->colourtable)[bgindex], &dm);
	spriteq_add_box(forex+1, forey+1, forew, foreh, HUD_Z+2+pstatus->barlayer, (*pstatus->colourtable)[colourindex], NULL);

	if(pstatus->noborder==0)
	{
		spriteq_add_line(x, y, x+bkw+1, y, HUD_Z+3+pstatus->borderlayer, color_white, NULL); //Top border.
		spriteq_add_line(x, y+bkh+1, x+bkw+1, y+bkh+1, HUD_Z+3+pstatus->borderlayer, color_white, NULL); //Bottom border.
		spriteq_add_line(x, y+1, x, y+bkh, HUD_Z+3+pstatus->borderlayer, color_white, NULL); //Left border.
		spriteq_add_line(x+bkw+1, y+1, x+bkw+1, y+bkh, HUD_Z+3+pstatus->borderlayer, color_white, NULL); //Right border.
		spriteq_add_line(x, y+bkh+2, x+bkw+1, y+bkh+2, HUD_Z+pstatus->borderlayer, color_black, NULL); //Bottom shadow.
		spriteq_add_line(x+bkw+2, y+1, x+bkw+2, y+bkh+2, HUD_Z+pstatus->borderlayer, color_black, NULL); //Right shadow.
	}
}


void pausemenu()
{
	int pauselector = 0;
	int quit = 0;
	s_screen* pausebuffer = allocscreen(videomodes.hRes, videomodes.vRes, screenformat);

	copyscreen(pausebuffer, vscreen);
	spriteq_draw(pausebuffer, 0, MIN_INT, MAX_INT, 0, 0);
	spriteq_clear();
	spriteq_add_screen(0, 0, MIN_INT, pausebuffer, NULL, 0);
	spriteq_lock();

	pause = 2;
	bothnewkeys = 0;
	while(!quit)
	{
		_menutextm(3, -2, 0, "Pause");
		_menutextm((pauselector==0), -1, 0, "Continue");
		_menutextm((pauselector==1), 0, 0, "End Game");

		update(1,0);

		if(bothnewkeys & (FLAG_MOVEUP|FLAG_MOVEDOWN)){
			pauselector ^= 1;
			sound_play_sample(SAMPLE_BEEP, 0, savedata.effectvol,savedata.effectvol, 100);
		}
		if(bothnewkeys & FLAG_START){
			if(pauselector){
				player[0].lives = player[1].lives = player[2].lives = player[3].lives = 0; //4player
				endgame = 1;
			}
			quit = 1;
			sound_pause_music(0);
			sound_pause_sample(0);
			sound_play_sample(SAMPLE_BEEP2, 0, savedata.effectvol,savedata.effectvol, 100);
			pauselector = 0;
		}
		if(bothnewkeys & FLAG_ESC){
			quit = 1;
			sound_pause_music(0);
			sound_pause_sample(0);
			sound_play_sample(SAMPLE_BEEP2, 0, savedata.effectvol,savedata.effectvol, 100);
			pauselector = 0;
		}
		if(bothnewkeys & FLAG_SCREENSHOT){
			pause = 1;
			sound_pause_music(1);
			sound_pause_sample(1);
			sound_play_sample(SAMPLE_BEEP2, 0, savedata.effectvol,savedata.effectvol, 100);
			options();
		}
	}
	pause = 0;
	bothnewkeys = 0;
	spriteq_unlock();
	spriteq_clear();
	freescreen(&pausebuffer);
}

unsigned getFPS(void)
{
	static unsigned lasttick=0,framerate = 0;
	unsigned curtick = timer_gettick();
	if(lasttick > curtick) lasttick = curtick;
	framerate = (framerate + (curtick-lasttick))/2;
	lasttick = curtick;
	if(!framerate) return 0;
#ifdef PSP
	return ((10000000/framerate)+9)/10;
#else
	return ((10000000/framerate)+9)/10000;
#endif
}

void updatestatus(){

	int dt;
	int tperror=0;
	int i,x;
	s_model * model = NULL;
	s_set_entry *set = levelsets + current_set;

	for(i=0; i<set->maxplayers; i++)
	{
		if(player[i].ent)
		{
			;
		}
		else if(player[i].joining && player[i].name[0])
		{
			model = findmodel(player[i].name);
			if((player[i].playkeys & FLAG_ANYBUTTON || skipselect[i][0]) && !freezeall && !nojoin)    // Can't join while animations are frozen
			{
				// reports error if players try to use the same character and sameplay mode is off
				if(sameplayer){
					for(x=0; x<set->maxplayers; x++){
						if((strncmp(player[i].name,player[x].name,strlen(player[i].name)) == 0) && (i != x)){
							tperror = i+1;
							break;
						}
					}
				}

				if (!tperror){    // Fixed so players can be selected if other player is no longer va //4player                        player[i].playkeys = player[i].newkeys = 0;
					player[i].lives = PLAYER_LIVES;            // to address new lives settings
					player[i].joining = 0;
					player[i].hasplayed = 1;
					player[i].spawnhealth = model->health;
					player[i].spawnmp = model->mp;

					spawnplayer(i);

					execute_join_script(i);

					player[i].playkeys = player[i].newkeys = player[i].releasekeys = 0;

					if(!nodropen) drop_all_enemies();   //27-12-2004  If drop enemies is on, drop all enemies

					if(!level->noreset) timeleft = level->settime * COUNTER_SPEED;    // Feb 24, 2005 - This line moved here to set custom time

				}

			}
			else if(player[i].playkeys & FLAG_MOVELEFT)
			{
				player[i].colourmap = i;
				model = prevplayermodel(model);
				strcpy(player[i].name, model->name);

				while(   // Keep looping until a non-hmap is found
					((model->maps.hide_start) && (model->maps.hide_end) &&
					player[i].colourmap >= model->maps.hide_start &&
					player[i].colourmap <= model->maps.hide_end)
					)
					{
						player[i].colourmap++;
						if(player[i].colourmap > model->maps_loaded) player[i].colourmap = 0;
					}

				player[i].playkeys = 0;
			}
			else if(player[i].playkeys & FLAG_MOVERIGHT)
			{
				player[i].colourmap = i;
				model = nextplayermodel(model);
				strcpy(player[i].name, model->name);

				while(   // Keep looping until a non-hmap is found
					((model->maps.hide_start) && (model->maps.hide_end) &&
					player[i].colourmap >= model->maps.hide_start &&
					player[i].colourmap <= model->maps.hide_end)
					)
					{
						player[i].colourmap++;
						if(player[i].colourmap > model->maps_loaded) player[i].colourmap = 0;
					}

				player[i].playkeys = 0;

			}
			// don't like a characters color try a new one!
			else if(player[i].playkeys & FLAG_MOVEUP && colourselect)
			{

				do{
					player[i].colourmap++;

					if(player[i].colourmap > model->maps_loaded) player[i].colourmap = 0;
				}
				while(    // Keep looping until a non frozen map is found
					(model->maps.frozen &&
					player[i].colourmap - 1 == model->maps.frozen - 1) ||
					((model->maps.hide_start) && (model->maps.hide_end) &&
					player[i].colourmap - 1 >= model->maps.hide_start - 1 &&
					player[i].colourmap - 1 <= model->maps.hide_end - 1)
					);

					player[i].playkeys = 0;
			}
			else if(player[i].playkeys & FLAG_MOVEDOWN && colourselect)
			{

				do{
					player[i].colourmap--;

					if(player[i].colourmap < 0) player[i].colourmap = model->maps_loaded;
				}
				while(    // Keep looping until a non frozen map is found
					(model->maps.frozen &&
					player[i].colourmap - 1 == model->maps.frozen - 1) ||
					((model->maps.hide_start) && (model->maps.hide_end) &&
					player[i].colourmap - 1 >= model->maps.hide_start - 1 &&
					player[i].colourmap - 1 <= model->maps.hide_end - 1)
					);

					player[i].playkeys = 0;
			}
		}
		else if(player[i].credits || credits || (!player[i].hasplayed && noshare))
		{
			if(player[i].playkeys & FLAG_START)
			{
				player[i].lives = 0;
				model = skipselect[i][0]?findmodel(skipselect[i]):nextplayermodel(NULL);
				strncpy(player[i].name, model->name, MAX_NAME_LEN);
				player[i].colourmap = i;
				 // Keep looping until a non-hmap is found
				while(model->maps.hide_start && model->maps.hide_end && player[i].colourmap >= model->maps.hide_start && player[i].colourmap <= model->maps.hide_end)
				{
					player[i].colourmap++;
					if(player[i].colourmap > model->maps_loaded) player[i].colourmap = 0;
				}

				player[i].joining = 1;
				player[i].playkeys = player[i].newkeys = player[i].releasekeys = 0;

				if(!level->noreset) timeleft = level->settime * COUNTER_SPEED;    // Feb 24, 2005 - This line moved here to set custom time

				if(!player[i].hasplayed && noshare) player[i].credits = CONTINUES;

				if(!creditscheat)
				{
					if(noshare) --player[i].credits;
					else --credits;
					if(set->continuescore == 1)player[i].score = 0;
					if(set->continuescore == 2)player[i].score = player[i].score+1;
				}
			}
		}
	}// end of for

	dt = timeleft/COUNTER_SPEED;
	if(dt>=99)
	{
		dt      = 99;

		oldtime = 99;
	}
	if(dt<=0)
	{
		dt      = 0;
		oldtime = 99;
	}

	if(dt < oldtime || oldtime == 0)
	{
		execute_timetick_script(dt, go_time);
		oldtime = dt;
	}

	timetoshow = dt;

	if(dt<99) showtimeover = 0;

	if(go_time>time)
	{
		dt = (go_time-time)%GAME_SPEED;

		if(dt < GAME_SPEED/2){
			showgo = 1;
			if(gosound == 0 ){

				if(SAMPLE_GO >= 0) sound_play_sample(SAMPLE_GO, 0, savedata.effectvol,savedata.effectvol, 100);// 26-12-2004 Play go sample as arrow flashes

				gosound = 1;                // 26-12-2004 Sets sample as already played - stops sample repeating too much
			}
		}else showgo = gosound = 0;    //26-12-2004 Resets go sample after loop so it can be played again next time
	}else showgo = 0;

}

void predrawstatus(){

	int icon = 0;
	int i;
	unsigned long tmp;
	s_set_entry* set = levelsets+current_set;
	s_model * model = NULL;
	s_drawmethod drawmethod = plainmethod;

	if(bgicon >= 0) spriteq_add_sprite(videomodes.hShift+bgicon_offsets[0],savedata.windowpos+bgicon_offsets[1], bgicon_offsets[2], bgicon, NULL, 0);
	if(olicon >= 0) spriteq_add_sprite(videomodes.hShift+olicon_offsets[0],savedata.windowpos+olicon_offsets[1], olicon_offsets[2], olicon, NULL, 0);

	for(i=0; i<set->maxplayers; i++)
	{
		if(player[i].ent)
		{
			tmp = player[i].score; //work around issue on 64bit where sizeof(long) != sizeof(int)
			if(!pscore[i][2] && !pscore[i][3] && !pscore[i][4] && !pscore[i][5])
		    font_printf(videomodes.shiftpos[i]+pscore[i][0], savedata.windowpos+pscore[i][1], pscore[i][6], 0, (scoreformat ? "%s - %09lu" : "%s - %lu"), (char*)(player[i].ent->name), tmp);
			else
			{
				font_printf(videomodes.shiftpos[i]+pscore[i][0], savedata.windowpos+pscore[i][1], pscore[i][6], 0, "%s", player[i].ent->name);
				font_printf(videomodes.shiftpos[i]+pscore[i][2], savedata.windowpos+pscore[i][3], pscore[i][6], 0, "-");
				font_printf(videomodes.shiftpos[i]+pscore[i][4], savedata.windowpos+pscore[i][5], pscore[i][6], 0, (scoreformat ? "%09lu" : "%lu"), tmp);
			}

			if(player[i].ent->health <= 0) icon = player[i].ent->modeldata.icon.die;
			else if(player[i].ent->inpain) icon = player[i].ent->modeldata.icon.pain;
			else if(player[i].ent->getting) icon = player[i].ent->modeldata.icon.get;
			else icon = player[i].ent->modeldata.icon.def;

			if(icon>=0)
			{
				drawmethod.table = player[i].ent->colourmap;
				spriteq_add_sprite(videomodes.shiftpos[i]+picon[i][0],savedata.windowpos+picon[i][1],10000, icon, &drawmethod, 0);
			}

			if(player[i].ent->weapent)
			{
				if(player[i].ent->weapent->modeldata.icon.weapon >= 0)
				{
					drawmethod.table = player[i].ent->weapent->colourmap;
					spriteq_add_sprite(videomodes.shiftpos[i]+piconw[i][0],savedata.windowpos+piconw[i][1],10000, player[i].ent->weapent->modeldata.icon.weapon, &drawmethod, 0);
				}

				if(player[i].ent->weapent->modeldata.typeshot && player[i].ent->weapent->modeldata.shootnum)
					font_printf(videomodes.shiftpos[i]+pshoot[i][0], savedata.windowpos+pshoot[i][1], pshoot[i][2], 0, "%u", player[i].ent->weapent->modeldata.shootnum);
			}

			if(player[i].ent->modeldata.mp)
			{
				if(player[i].ent->modeldata.icon.mphigh > 0 && (player[i].ent->oldmp >= (player[i].ent->modeldata.mp * .66))){
					drawmethod.table = player[i].ent->colourmap;
					spriteq_add_sprite(videomodes.shiftpos[i]+mpicon[i][0],savedata.windowpos+mpicon[i][1],10000, player[i].ent->modeldata.icon.mphigh, &drawmethod, 0);
				}
				else if(player[i].ent->modeldata.icon.mpmed > 0 && (player[i].ent->oldmp >= (player[i].ent->modeldata.mp * .33) && player[i].ent->oldmp < (player[i].ent->modeldata.mp * .66))){
					drawmethod.table = player[i].ent->colourmap;
					spriteq_add_sprite(videomodes.shiftpos[i]+mpicon[i][0],savedata.windowpos+mpicon[i][1],10000, player[i].ent->modeldata.icon.mpmed, &drawmethod, 0);
				}
				else if(player[i].ent->modeldata.icon.mplow > 0 && (player[i].ent->oldmp >= 0 && player[i].ent->oldmp < (player[i].ent->modeldata.mp * .33))){
					drawmethod.table = player[i].ent->colourmap;
					spriteq_add_sprite(videomodes.shiftpos[i]+mpicon[i][0],savedata.windowpos+mpicon[i][1],10000, player[i].ent->modeldata.icon.mplow, &drawmethod, 0);
				}
				else if(player[i].ent->modeldata.icon.mphigh > 0 && player[i].ent->modeldata.icon.mpmed == -1 && player[i].ent->modeldata.icon.mplow == -1){
					drawmethod.table = player[i].ent->colourmap;
					spriteq_add_sprite(videomodes.shiftpos[i]+mpicon[i][0],savedata.windowpos+mpicon[i][1],10000, player[i].ent->modeldata.icon.mphigh, &drawmethod, 0);
				}
			}

			font_printf(videomodes.shiftpos[i]+plifeX[i][0],savedata.windowpos+plifeX[i][1], plifeX[i][2], 0, "x");
			font_printf(videomodes.shiftpos[i]+plifeN[i][0],savedata.windowpos+plifeN[i][1], plifeN[i][2], 0, "%i", player[i].lives);

			if(rush[0] && player[i].ent->rush[0] > 1 && time <= player[i].ent->rushtime)
			{
				font_printf(videomodes.shiftpos[i]+prush[i][0],prush[i][1], rush[2], 0, "%s", rush_names[0]);
				font_printf(videomodes.shiftpos[i]+prush[i][2],prush[i][3], rush[3], 0, "%i", player[i].ent->rush[0]);

				if(rush[0] != 2){
					font_printf(videomodes.shiftpos[i]+prush[i][4],prush[i][5], rush[4], 0, "%s", rush_names[1]);
					font_printf(videomodes.shiftpos[i]+prush[i][6],prush[i][7], rush[5], 0, "%i", player[i].ent->rush[1]);
				}
			}

			if(rush[0] == 2)
			{
				font_printf(videomodes.shiftpos[i]+prush[i][4],prush[i][5], rush[4], 0, "%s", rush_names[1]);
				font_printf(videomodes.shiftpos[i]+prush[i][6],prush[i][7], rush[5], 0, "%i", player[i].ent->rush[1]);
			}

			if(player[i].ent->opponent && !player[i].ent->opponent->modeldata.nolife)
			{    // Displays life unless overridden by flag
				font_printf(videomodes.shiftpos[i]+ename[i][0], savedata.windowpos+ename[i][1], ename[i][2], 0, player[i].ent->opponent->name);
				if(player[i].ent->opponent->health <= 0) icon = player[i].ent->opponent->modeldata.icon.die;
				else if(player[i].ent->opponent->inpain) icon = player[i].ent->opponent->modeldata.icon.pain;
				else if(player[i].ent->opponent->getting) icon = player[i].ent->opponent->modeldata.icon.get;
				else icon = player[i].ent->opponent->modeldata.icon.def;

				if(icon>=0)
				{
					drawmethod.table = player[i].ent->opponent->colourmap;
					spriteq_add_sprite(videomodes.shiftpos[i]+eicon[i][0],savedata.windowpos+eicon[i][1],10000, icon, &drawmethod, 0);    // Feb 26, 2005 - Changed to opponent->map so icons don't pallete swap with die animation
				}
			}
		}
		else if(player[i].joining && player[i].name[0])
		{
			model = findmodel(player[i].name);
			font_printf(videomodes.shiftpos[i]+pnameJ[i][0], savedata.windowpos+pnameJ[i][1], pnameJ[i][6], 0, player[i].name);
			if(nojoin) font_printf(videomodes.shiftpos[i]+pnameJ[i][2], savedata.windowpos+pnameJ[i][3], pnameJ[i][6], 0, "Please Wait");
			else font_printf(videomodes.shiftpos[i]+pnameJ[i][2], savedata.windowpos+pnameJ[i][3], pnameJ[i][6], 0, "Select Hero");
			icon = model->icon.def;

			if(icon>=0)
			{
				drawmethod.table = model_get_colourmap(model, player[i].colourmap);
				spriteq_add_sprite(videomodes.shiftpos[i]+picon[i][0],picon[i][1], 10000, icon, &drawmethod, 0);
			}
		}
		else if(player[i].credits || credits || (!player[i].hasplayed && noshare))
		{
			if(player[i].credits && (time/(GAME_SPEED*2)) & 1) font_printf(videomodes.shiftpos[i]+pnameJ[i][4], savedata.windowpos+pnameJ[i][5], pnameJ[i][6], 0, "Credit %i", player[i].credits);
			else if(credits && (time/(GAME_SPEED*2)) & 1) font_printf(videomodes.shiftpos[i]+pnameJ[i][4], savedata.windowpos+pnameJ[i][5], pnameJ[i][6], 0, "Credit %i", credits);
			else if(nojoin) font_printf(videomodes.shiftpos[i]+pnameJ[i][4], savedata.windowpos+pnameJ[i][5], pnameJ[i][6], 0, "Please Wait");
			else font_printf(videomodes.shiftpos[i]+pnameJ[i][4], savedata.windowpos+pnameJ[i][5], pnameJ[i][6], 0, "Press Start");

		}
		else
		{
			font_printf(videomodes.shiftpos[i]+pnameJ[i][4], savedata.windowpos+pnameJ[i][5], pnameJ[i][6], 0, "GAME OVER");
		}
	}// end of for

	if(savedata.debuginfo)
	{
		spriteq_add_box(0, videomodes.dOffset-12, videomodes.hRes, videomodes.dOffset+12, 0x0FFFFFFE, 0, NULL);
		font_printf(2,                   videomodes.dOffset-10, 0, 0, "FPS: %03d", getFPS());
		font_printf(videomodes.hRes / 2, videomodes.dOffset-10, 0, 0, "Free Ram: %s KBytes", commaprint(freeram/1000));
		font_printf(2,                   videomodes.dOffset,    0, 0, "Total Ram: %s KBytes", commaprint(totalram/1000));
		font_printf(videomodes.hRes / 2, videomodes.dOffset,    0, 0, "Used Ram: %s KBytes", commaprint(usedram/1000));
	}

	if(timeicon >= 0) spriteq_add_sprite(videomodes.hShift+timeicon_offsets[0], savedata.windowpos+timeicon_offsets[1],10000, timeicon, NULL, 0);
	if(!level->notime) font_printf(videomodes.hShift+timeloc[0]+2, savedata.windowpos+timeloc[1]+2, timeloc[5], 0, "%02i", timetoshow);
	if(showtimeover) font_printf(videomodes.hShift+113, videomodes.vShift+savedata.windowpos+110, timeloc[5], 0, "TIME OVER");

	if(showgo){
		if(level->scrolldir&SCROLL_LEFT){ //TODO: upward and downward go

			if(golsprite >= 0) spriteq_add_sprite(40,60+videomodes.vShift,10000, golsprite, NULL, 0); // new sprite for left direction
			else
			{
				drawmethod.table = 0;
				drawmethod.flipx = 1;
				spriteq_add_sprite(40,60+videomodes.vShift,10000, gosprite, &drawmethod, 0);
			}
		}
		else if(level->scrolldir&SCROLL_RIGHT){
			spriteq_add_sprite(videomodes.hRes-40,60+videomodes.vShift,10000, gosprite, NULL, 0);
		}
	}
}

// draw boss status on screen
void drawenemystatus(entity* ent)
{
	s_drawmethod drawmethod;
	int icon;

	if(ent->modeldata.namex>-1000 && ent->modeldata.namey>-1000) font_printf(ent->modeldata.namex, ent->modeldata.namey, 0, 0, "%s", ent->name);

	if(ent->modeldata.icon.x>-1000 &&  ent->modeldata.icon.y>-1000)
	{
		if(ent->health <= 0) icon = ent->modeldata.icon.die;
		else if(ent->inpain) icon = ent->modeldata.icon.pain;
		else if(ent->getting) icon = ent->modeldata.icon.get;
		else icon = ent->modeldata.icon.def;

		if(icon>=0)
		{
			drawmethod = plainmethod;
			drawmethod.table = ent->colourmap;
			spriteq_add_sprite(ent->modeldata.icon.x, ent->modeldata.icon.y, HUD_Z, icon, &drawmethod, 0);
		}
	}

	if(ent->modeldata.health && ent->modeldata.hpx>-1000 && ent->modeldata.hpy>-1000)
		bar(ent->modeldata.hpx, ent->modeldata.hpy, ent->oldhealth, ent->modeldata.health, &(ent->modeldata.hpbarstatus));
}


void drawstatus(){
	int i;

	for(i=0; i < MAX_PLAYERS; i++)
	{
		if(player[i].ent)
		{
			// Health bars
			bar(videomodes.shiftpos[i]+plife[i][0],savedata.windowpos+plife[i][1], player[i].ent->oldhealth, player[i].ent->modeldata.health, &lbarstatus);
			if(player[i].ent->opponent && !player[i].ent->opponent->modeldata.nolife && player[i].ent->opponent->modeldata.health)
				bar(videomodes.shiftpos[i]+elife[i][0], savedata.windowpos+elife[i][1], player[i].ent->opponent->oldhealth, player[i].ent->opponent->modeldata.health,&olbarstatus); // Tied in with the nolife flag
			// Draw mpbar
			if(player[i].ent->modeldata.mp)
			{
				bar(videomodes.shiftpos[i]+pmp[i][0], savedata.windowpos+pmp[i][1], player[i].ent->oldmp, player[i].ent->modeldata.mp, &mpbarstatus);
			}
		}
	}

	// Time box
	if(!level->notime && !timeloc[4])    // Only draw if notime is set to 0 or not specified
	{
		spriteq_add_line(videomodes.hShift+timeloc[0],                savedata.windowpos+timeloc[1],                videomodes.hShift+timeloc[0]+timeloc[2],     savedata.windowpos+timeloc[1],                HUD_Z, color_black, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0],                savedata.windowpos+timeloc[1],                videomodes.hShift+timeloc[0],                savedata.windowpos+timeloc[1]+timeloc[3],     HUD_Z,  color_black, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0]+timeloc[2],     savedata.windowpos+timeloc[1],                videomodes.hShift+timeloc[0]+timeloc[2],     savedata.windowpos+timeloc[1]+timeloc[3],     HUD_Z,  color_black, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0],                savedata.windowpos+timeloc[1]+timeloc[3],     videomodes.hShift+timeloc[0]+timeloc[2],     savedata.windowpos+timeloc[1]+timeloc[3],     HUD_Z, color_black, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0] - 1,            savedata.windowpos+timeloc[1] - 1,            videomodes.hShift+timeloc[0]+timeloc[2] - 1, savedata.windowpos+timeloc[1] - 1,            HUD_Z+1,   color_white, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0] - 1,            savedata.windowpos+timeloc[1] - 1,            videomodes.hShift+timeloc[0] - 1,            savedata.windowpos+timeloc[1]+timeloc[3] - 1, HUD_Z+1,  color_white, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0]+timeloc[2] - 1, savedata.windowpos+timeloc[1] - 1,            videomodes.hShift+timeloc[0]+timeloc[2] - 1, savedata.windowpos+timeloc[1]+timeloc[3] - 1, HUD_Z+1,  color_white, NULL);
		spriteq_add_line(videomodes.hShift+timeloc[0] - 1,            savedata.windowpos+timeloc[1]+timeloc[3] - 1, videomodes.hShift+timeloc[0]+timeloc[2] - 1, savedata.windowpos+timeloc[1]+timeloc[3] - 1, HUD_Z+1, color_white, NULL);
	}
}

void update_loading(s_loadingbar* s,  int value, int max) {
	static unsigned int lasttick = 0;
	static unsigned int soundtick = 0;
	static unsigned int keybtick = 0;
	int pos_x = s->bx + videomodes.hShift;
	int pos_y = s->by + videomodes.vShift;
	int size_x = s->bsize;
	int text_x = s->tx + videomodes.hShift;
	int text_y = s->ty + videomodes.vShift;
	unsigned int ticks = timer_gettick();

	if(ticks - soundtick > 20) {
		sound_update_music();
		soundtick = ticks;
	}

	if(ticks - keybtick > 250) {
		control_update(playercontrolpointers, 1); // Respond to exit and/or fullscreen requests from user/OS
		keybtick = ticks;
	}


	if(ticks - lasttick > s->refreshMs || value < 0 || value == max) { // Negative value forces a repaint. used when only bg is drawn for the first time
		spriteq_clear();
		execute_loading_script(value, max);
		if(s->set) {
			if (value < 0) value = 0;
			if(isLoadingScreenTypeBar(s->set)) {
				loadingbarstatus.sizex = size_x;
				bar(pos_x, pos_y, value, max, &loadingbarstatus);
			}
			font_printf(text_x, text_y, s->tf, 0, "Loading...");
			if(isLoadingScreenTypeBg(s->set)) {
				if(background)
					putscreen(vscreen, background, 0, 0, NULL);
				else
					clearscreen(vscreen);
			}
			spriteq_draw(vscreen, 0, MIN_INT, MAX_INT, 0, 0);
			video_copy_screen(vscreen);
			spriteq_clear();
		}
		else if(value < 0) { // Original BOR v1.0029 used this method.  Since loadingbg is optional, we should print this one again.
			clearscreen(vscreen);
			font_printf(120 + videomodes.hShift, 110 + videomodes.vShift, 0, 0, "Loading...");
			spriteq_draw(vscreen, 0, MIN_INT, MAX_INT, 0, 0);
			video_copy_screen(vscreen);
			spriteq_clear();
		}
		lasttick = ticks;
	}
}

void addscore(int playerindex, int add){
	unsigned int s ;
	unsigned int next1up;
	ScriptVariant var; // used for execute script
	Script* cs;

	if(playerindex < 0) return;//dont score if <0, e.g., npc damage enemy, enemy damage enemy

	playerindex &= 3;

	s = player[playerindex].score;
	cs = score_script + playerindex;

	next1up = ((s/lifescore)+1) * lifescore;

	s += add;
	if(s>999999999) s=999999999;

	while(s>next1up){

		if(SAMPLE_1UP >= 0) sound_play_sample(SAMPLE_1UP, 0, savedata.effectvol,savedata.effectvol, 100);

		player[playerindex].lives++;
		next1up += lifescore;
	}

	player[playerindex].score = s;

	//execute a script then
	if(Script_IsInitialized(cs))
	{
		ScriptVariant_Init(&var);
		ScriptVariant_ChangeType(&var, VT_INTEGER);
		var.lVal = (LONG)add;
		Script_Set_Local_Variant(cs, "score", &var);
		Script_Execute(score_script+playerindex);
		ScriptVariant_Clear(&var);
		Script_Set_Local_Variant(cs, "score", &var);
	}
}




// ---------------------------- Object handling ------------------------------

void free_ent(entity* e)
{
	int i;
	if(!e) return;
	clear_all_scripts(e->scripts,2);
	free_all_scripts(&e->scripts);

	if(e->waypoints) { free(e->waypoints); e->waypoints = NULL;}
	if(e->defense){ free(e->defense); e->defense = NULL; }
	if(e->offense_factors){ free(e->offense_factors); e->offense_factors = NULL; }
	if(e->entvars)
	{
		// Although free_ent will be only called once when the engine is shutting down,
		// just clear those in case we forget something
		for(i=0; i<max_entity_vars; i++)
		{
			ScriptVariant_Clear(e->entvars+i);
		}
		free(e->entvars); e->entvars = NULL;
	}
	free(e);
	e = NULL;
}

void free_ents()
{
	int i;
	if(!ent_list) return;
	for(i=0; i<ent_list_size; i++) free_ent(ent_list[i]);
	free(ent_list);
	ent_list = NULL;
	ent_list_size = ent_max = ent_count = 0;
}

entity* alloc_ent()
{
	entity* ent = (entity*)malloc(sizeof(entity));
	if(!ent) return NULL;
	memset(ent, 0, sizeof(entity));
	ent->defense = (s_defense*)malloc(sizeof(s_defense)*max_attack_types);
	memset(ent->defense, 0, sizeof(s_defense)*max_attack_types);
	ent->offense_factors = (float*)malloc(sizeof(float)*max_attack_types);
	memset(ent->offense_factors, 0, sizeof(float)*max_attack_types);
	if(max_entity_vars>0)
	{
		ent->entvars = (ScriptVariant*)malloc(sizeof(ScriptVariant)*max_entity_vars);
		// memset should be OK by know, because VT_EMPTY is zero by value, or else we should use ScriptVariant_Init
		memset(ent->entvars, 0, sizeof(ScriptVariant)*max_entity_vars);
	}
	alloc_all_scripts(&ent->scripts);
	return ent;
}


int alloc_ents()
{
	int i;
	
	ent_list_size += MAX_ENTS;

	if(!ent_list) ent_list = malloc(sizeof(entity*)*ent_list_size);
	else ent_list = realloc(ent_list, sizeof(entity*)*ent_list_size);

	if(!ent_list) goto alloc_ents_error;

	for(i=ent_list_size-MAX_ENTS; i<ent_list_size; i++)
	{
		ent_list[i] = alloc_ent();
		if(!ent_list[i])
		{
			 goto alloc_ents_error;
		}
		ent_list[i]->sortid = i*100;
	}
	//ent_count = ent_max = 0;
	return 1;

alloc_ents_error:
	free_ents();
	return 0;
}

// this method initialize an entity's A.I. behaviors
void ent_default_init(entity* e)
{
	int dodrop;
	int wall;
	entity *other;

	if(!e) return;

	if((!selectScreen && !time) || e->modeldata.type != TYPE_PLAYER )
	{
		if( validanim(e,ANI_SPAWN)) ent_set_anim(e, ANI_SPAWN, 0); // use new playerselect spawn anim
		//else set_idle(e);
	}
	else if(!selectScreen && time && e->modeldata.type == TYPE_PLAYER) // mid-level respawn
	{
		if( validanim(e,ANI_RESPAWN)) ent_set_anim(e, ANI_RESPAWN, 0);
		else if( validanim(e,ANI_SPAWN)) ent_set_anim(e, ANI_SPAWN, 0);
		//else set_idle(e);
	}
	else if(selectScreen && validanim(e,ANI_SELECT)) ent_set_anim(e, ANI_SELECT, 0);
	//else set_idle(e);

	if(!level)
	{
		if(!e->animation) set_idle(e);
		return;
	}

	switch(e->modeldata.type){
		case TYPE_ENDLEVEL:
		case TYPE_ITEM:
			e->nograb = 1;
			break;

		case TYPE_PLAYER:
			//e->direction = (level->scrolldir != SCROLL_LEFT);
			e->takedamage = player_takedamage;
			e->think = player_think;
			e->trymove = player_trymove;

			if(validanim(e,ANI_SPAWN) || validanim(e,ANI_RESPAWN))
			{
				e->takeaction = common_spawn;
			}
			else if(!e->animation)
			{
				if(time && level->spawn[(int)e->playerindex][2] > e->a)
				{
					e->takeaction = common_drop;
					e->a = (float)level->spawn[(int)e->playerindex][2];
					if(validanim(e, ANI_JUMP))
					ent_set_anim(e, ANI_JUMP, 0);
				}
			}
			if(time && e->modeldata.makeinv)
			{
						// Spawn invincible code
				e->invincible = 1;
				e->blink = (e->modeldata.makeinv > 0);
				e->invinctime = time + ABS(e->modeldata.makeinv);
				e->arrowon = 1;    // Display the image above the player
			}
			break;
		case TYPE_NPC: // use NPC(or A.I. player) instread of an enemy subtype or trap subtype, for further A.I. use
			if(e->modeldata.multiple ==0) e->modeldata.multiple = -1;

		case TYPE_ENEMY:
			e->think = common_think;
			if(e->modeldata.subtype == SUBTYPE_BIKER)
			{
				e->nograb = 1;
				e->attacking = 1;
				//e->direction = (e->x<0);
				if(e->modeldata.speed)
					e->xdir = (e->direction)?(e->modeldata.speed):(-e->modeldata.speed);
				else
					e->xdir = (e->direction)?(1.7 + randf((float)0.6)):(-(1.7 + randf((float)0.6)));
				e->takedamage = biker_takedamage;
				break;
			}
			// define new subtypes
			else if(e->modeldata.subtype == SUBTYPE_ARROW)
			{
				e->health = 1;
				if(!e->modeldata.speed && !e->modeldata.nomove)
					e->modeldata.speed = 2;    // Set default speed to 2 for arrows
				else if(e->modeldata.nomove)
					e->modeldata.speed = 0;
				if(e->ptype)
					e->base = 0;
				else
					e->base = e->a;
				e->nograb = 1;
				e->attacking = 1;
				e->takedamage = arrow_takedamage;
				break;
			}
			else
			{
				e->trymove = common_trymove;
				// Must just be a regular enemy, set defaults accordingly
				if(!e->modeldata.speed && !e->modeldata.nomove)
					e->modeldata.speed = 1;
				else if(e->modeldata.nomove)
					e->modeldata.speed = 0;
				if(e->modeldata.multiple==0)
					e->modeldata.multiple = 5;
				e->takedamage = common_takedamage;//enemy_takedamage;
			}

			if(e->modeldata.subtype == SUBTYPE_NOTGRAB) e->nograb = 1;

			if(validanim(e,ANI_SPAWN) /*|| validanim(e,ANI_RESPAWN)*/)
			{
				e->takeaction = common_spawn;
			}
			else
			{
				dodrop = (e->modeldata.subtype != SUBTYPE_ARROW && level && (level->scrolldir==SCROLL_UP || level->scrolldir==SCROLL_DOWN));

				if(!nodropspawn && (dodrop || (e->x > advancex-30 && e->x < advancex + videomodes.hRes+30 && e->a == 0)) )
				{
					e->a += videomodes.vRes + randf(40);
				}
				if(inair(e)){
					e->takeaction = common_drop;//enemy_drop;
					if(validanim(e, ANI_JUMP)) ent_set_anim(e, ANI_JUMP, 0);
				}
			}
			break;
		// define trap type
		case TYPE_TRAP:
			e->think = trap_think;
			e->takedamage =  common_takedamage;//enemy_takedamage;
			break;
		case TYPE_OBSTACLE:
			e->nograb = 1;
			if(e->health<=0)
				e->dead = 1; // so it won't get hit
			e->takedamage = obstacle_takedamage;//obstacle_takedamage;
			break;
		case TYPE_STEAMER:
			e->nograb = 1;
			e->think = steamer_think;
			e->base = e->a;
			break;
		case TYPE_TEXTBOX:    // New type for displaying text purposes
			e->nograb = 1;
			e->think = text_think;
			break;
		case TYPE_SHOT:
			e->health = 1;
			e->nograb = 1;
			e->think = common_think;
			e->takedamage = arrow_takedamage;
			e->attacking = 1;
			if(!e->model->speed && !e->modeldata.nomove)
				e->modeldata.speed = 2;    // Set default speed to 2 for arrows
			else if(e->modeldata.nomove)
				e->modeldata.speed = 0;
			if(e->ptype)
				e->base = 0;
			else
				e->base = e->a;
			break;
		case TYPE_NONE:
			e->nograb = 1;
			if(e->modeldata.subject_to_gravity<0) e->modeldata.subject_to_gravity = 1;
			//e->base=e->a; //complained?
			if(e->modeldata.no_adjust_base<0) e->modeldata.no_adjust_base= 1;

			if(validanim(e,ANI_WALK))
			{
				if(e->direction) e->xdir = e->modeldata.speed;
				else e->xdir = -(e->modeldata.speed);
				e->think = anything_walk;

				common_walk_anim(e);
				//ent_set_anim(e, ANI_WALK, 0);
			}
			break;
		case TYPE_PANEL:
			e->nograb = 1;
			break;
	}

	if(!e->animation){
		set_idle(e);
	}

	if(e->modeldata.multiple < 0)
		e->modeldata.multiple = 0;

	if(e->modeldata.subject_to_platform>0 && (other=check_platform_below(e->x, e->z, e->a, e)))
		e->base += other->a + other->animation->platform[other->animpos][7];
	else if(e->modeldata.subject_to_wall>0 && (wall=checkwall_below(e->x, e->z, 9999999)) >= 0)
		e->base += level->walls[wall][7];
}

void ent_spawn_ent(entity* ent)
{
	entity* s_ent = NULL;
	float* spawnframe = ent->animation->spawnframe;
	float dy = level?4.0:0.0;
	// spawn point relative to current entity
	if(spawnframe[4] == 0)
		s_ent = spawn(ent->x + ((ent->direction)?spawnframe[1]:-spawnframe[1]),ent->z + spawnframe[2], ent->a + spawnframe[3], ent->direction, NULL, ent->animation->subentity, NULL);
	//relative to screen position
	else if(spawnframe[4] == 1)
	{
		if(level && !(level->scrolldir&SCROLL_UP) && !(level->scrolldir&SCROLL_DOWN))
			s_ent = spawn(advancex+spawnframe[1], advancey+spawnframe[2]+dy, spawnframe[3], 0, NULL, ent->animation->subentity, NULL);
		else
			s_ent = spawn(advancex+spawnframe[1], spawnframe[2]+dy, spawnframe[3], 0, NULL, ent->animation->subentity, NULL);
	}
	//absolute position in level
	else s_ent = spawn(spawnframe[1], spawnframe[2], spawnframe[3]+0.001, 0, NULL, ent->animation->subentity, NULL);

	if(s_ent)
	{
		//ent_default_init(s_ent);
		if(s_ent->modeldata.type & TYPE_SHOT) s_ent->playerindex = ent->playerindex;
		if(s_ent->modeldata.subtype == SUBTYPE_ARROW) s_ent->owner = ent;
		s_ent->parent = ent;  //maybe used by A.I.
		execute_onspawn_script(s_ent);
	}
}

void ent_summon_ent(entity* ent){
	entity* s_ent = NULL;
	float* spawnframe = ent->animation->summonframe;
	float dy = level?4.0:0.0;
	// spawn point relative to current entity
	if(spawnframe[4] == 0)
		s_ent = spawn(ent->x + ((ent->direction)?spawnframe[1]:-spawnframe[1]),ent->z + spawnframe[2],  ent->a + spawnframe[3], ent->direction, NULL, ent->animation->subentity, NULL);
	//relative to screen position
	else if(spawnframe[4] == 1)
	{
		if(level && !(level->scrolldir&SCROLL_UP) && !(level->scrolldir&SCROLL_DOWN))
			s_ent = spawn(advancex+spawnframe[1], advancey+spawnframe[2]+dy, spawnframe[3], 0, NULL, ent->animation->subentity, NULL);
		else
			s_ent = spawn(advancex+spawnframe[1], spawnframe[2]+dy, spawnframe[3], 0, NULL, ent->animation->subentity, NULL);
	}
	//absolute position in level
	else
		s_ent = spawn(spawnframe[1], spawnframe[2], spawnframe[3], 0, NULL, ent->animation->subentity, NULL);

	if(s_ent)
	{
		if(!spawnframe[4])
			s_ent->direction = ent->direction;
		//ent_default_init(s_ent);
		if(s_ent->modeldata.type & TYPE_SHOT)
			s_ent->playerindex = ent->playerindex;
		if(s_ent->modeldata.subtype == SUBTYPE_ARROW)
			s_ent->owner = ent;
		//maybe used by A.I.
		s_ent->parent = ent;
		ent->subentity = s_ent;
		execute_onspawn_script(s_ent);
	}
}

// move here to prevent some duplicated code in ent_sent_anim and update_ents
void update_frame(entity* ent, int f)
{
	entity* tempself;
	entity* dust;
	s_attack attack;
	float move, movez, movea;
	int iDelay, iED_Mode, iED_Capmin, iED_CapMax, iED_RangeMin, iED_RangeMax;
	float fED_Factor;
	s_anim* anim = ent->animation;

	if(f >= anim->numframes) // prevent a crash with invalid frame index.
		return;

	//important!
	tempself = self;
	self = ent;

	self->animpos = f;
	//self->currentsprite = self->animation->sprite[f];

	if(self->animating){
		iDelay          = anim->delay[f];
		iED_Mode        = self->modeldata.edelay.mode;
		fED_Factor      = self->modeldata.edelay.factor;
		iED_Capmin      = self->modeldata.edelay.cap_min;
		iED_CapMax      = self->modeldata.edelay.cap_max;
		iED_RangeMin    = self->modeldata.edelay.range_min;
		iED_RangeMax    = self->modeldata.edelay.range_max;

		if (iDelay >= iED_RangeMin && iDelay <= iED_RangeMax) //Regular delay within ignore ranges?
		{
			switch(iED_Mode)
			{
				case 1:
					iDelay = (int)(iDelay * fED_Factor);
					break;
				default:
					iDelay += (int)fED_Factor;
					break;
			}

			if (iED_Capmin && iDelay < iED_Capmin){ iDelay = iED_Capmin; }
			if (iED_CapMax && iDelay > iED_CapMax){ iDelay = iED_CapMax; }
		}

		self->nextanim = time + iDelay;
		self->pausetime = 0;
		execute_animation_script(self);
	}

	if(ent->animation!=anim || ent->animpos!=f)
		goto uf_interrupted;

	if(level && (anim->move || anim->movez))
	{
		move = (float)(anim->move?anim->move[f]:0);
		movez = (float)(anim->movez?anim->movez[f]:0);
		if(self->direction==0) move = -move;
		if(movez || move)
		{
			if(self->trymove)
			{
				self->trymove(move, movez);
			}
			else
			{
				self->x += move;
				self->z += movez;
			}
		}
	}

	if(anim->seta && anim->seta[0] >= 0 && self->base <= 0)
		ent->base = (float)anim->seta[0];
	else if(!anim->seta || anim->seta[0] < 0)
	{
		movea = (float)(anim->movea?anim->movea[f]:0);
		self->base += movea;
		if(movea!=0) self->altbase += movea;
		else self->altbase = 0;
	}

	if(anim->flipframe == f) self->direction = !self->direction;

	if(anim->weaponframe && anim->weaponframe[0] == f)
	{
		dropweapon(2);
		set_weapon(self, anim->weaponframe[1], 0);
		self->idling = 1;
	}

	if(anim->quakeframe.framestart+anim->quakeframe.cnt == f)
	{
		if(level) {
			if(anim->quakeframe.cnt%2 || anim->quakeframe.v > 0) level->quake = anim->quakeframe.v;
			else level->quake = anim->quakeframe.v * -1;
		}
		if((anim->quakeframe.repeat-anim->quakeframe.cnt) > 1) anim->quakeframe.cnt++;
		else anim->quakeframe.cnt = 0;
	}

	if(anim->unsummonframe == f)
	{
		if(self->subentity)
		{
			self = self->subentity;
			attack = emptyattack;
			attack.dropv[0] = default_model_dropv[0]; 
			attack.dropv[1] = default_model_dropv[1]; 
			attack.dropv[2] = default_model_dropv[2];
			attack.attack_force = self->health;
			attack.attack_type = max_attack_types;
			if(self->takedamage) self->takedamage(self, &attack);
			else kill(self);
			self = ent; // lol ...
			self->subentity = NULL;
		}
	}

	//spawn / summon /unsummon features
	if(anim->spawnframe && anim->spawnframe[0] == f && anim->subentity) ent_spawn_ent(self);

	if(anim->summonframe && anim->summonframe[0] == f && anim->subentity)
	{
		//subentity is dead
		if(!self->subentity || self->subentity->dead) ent_summon_ent(self);
	}

	if(anim->soundtoplay && anim->soundtoplay[f] >= 0)
		sound_play_sample(anim->soundtoplay[f], 0, savedata.effectvol,savedata.effectvol, 100);

	if(anim->jumpframe.f == f)
	{
		// Set custom jumpheight for jumpframes
		/*if(self->animation->jumpframe.v > 0)*/ toss(self, anim->jumpframe.v);
		self->xdir = self->direction?anim->jumpframe.x:-anim->jumpframe.x;
		self->zdir = anim->jumpframe.z;

		if(anim->jumpframe.ent>=0)
		{
			dust = spawn(self->x, self->z, self->a, self->direction, NULL, anim->jumpframe.ent, NULL);
			if(dust){
				dust->base = self->a;
				dust->autokill = 2;
				execute_onspawn_script(dust);
			}
		}
	}

	if(anim->throwframe == f)
	{
		// For backward compatible thing
		// throw stars in the air, hmm, strange
		// custstar custknife in animation should be checked first
		// then if the entity is jumping, check star first, if failed, try knife instead
		// well, try knife at last, if still failed, try star, or just let if shutdown?
#define __trystar star_spawn(self->x + (self->direction ? 56 : -56), self->z, self->a+67, self->direction)
#define __tryknife knife_spawn(NULL, -1, self->x, self->z, self->a + anim->throwa, self->direction, 0, 0)
		if(anim->custknife>=0 || anim->custpshotno>=0)
			__tryknife;
		else if(anim->custstar>=0)
			__trystar;
		else if(self->jumping) {
			if(!__trystar)
				__tryknife;
		}
		else if(!__tryknife)
			__trystar;
		self->reactive=1;
	}

	if(anim->shootframe == f)
	{
		knife_spawn(NULL, -1, self->x, self->z, self->a, self->direction, 1, 0);
		self->reactive=1;
	}

	if(anim->tossframe == f)
	{
		bomb_spawn(NULL, -1, self->x, self->z, self->a + anim->throwa, self->direction, 0);
		self->reactive=1;
	}

uf_interrupted:

	//important!
	self = tempself;
}


void ent_set_anim(entity *ent, int aninum, int resetable)
{
	s_anim *ani = NULL;
	int animpos;

	if(!ent) {
		//printf("FATAL: tried to set animation with invalid address (no such object)");
		return;
	}

	if(aninum<0 || aninum>=max_animations) {
		//printf("FATAL: tried to set animation with invalid index (%s, %i)", ent->name, aninum);
		return;
	}

	if(!validanim(ent, aninum)) {
		//printf("FATAL: tried to set animation with invalid address (%s, %i)", ent->name, aninum);
		return;
	}

	ani = ent->modeldata.animation[aninum];

	if(!resetable && ent->animation == ani)
		return;

	if(ani->numframes == 0)
		return;

	if(ent->animation && ani->sync>=0 && ent->animation->sync==ani->sync){
		animpos = ent->animpos;
		if(animpos>=ani->numframes)
			animpos = 0;
		ent->animnum = aninum;
		ent->animation = ani;
		ent->animpos=animpos;
	}else{
		if(aninum!=ANI_SLEEP)
			ent->sleeptime = time + ent->modeldata.sleepwait;
		ent->animation = ani;
		ent->animnum = aninum;    // Stored for nocost usage
		ent->animation->animhits = 0;

		ent->animating = 1;
		ent->lasthit = ent->grabbing;
		ent->altbase = 0;

		update_frame(ent, 0);
	}
}

unsigned char* model_get_colourmap(s_model* model, unsigned which)
{
	if(which<=0 || which>model->maps_loaded)
		return model->palette;
	else
		return model->colourmap[which-1];
}

// 0 = none, 1+ = alternative
void ent_set_colourmap(entity *ent, unsigned int which)
{
	if(which>ent->modeldata.maps_loaded) which = 0;
	if(which<=0)
		ent->colourmap = ent->modeldata.palette;
	else
		ent->colourmap = ent->modeldata.colourmap[which-1];
	ent->map = which;
}

// used by ent_set_model
void ent_copy_uninit(entity* ent, s_model* oldmodel)
{
	if(ent->modeldata.multiple<0)
		ent->modeldata.multiple             = oldmodel->multiple;
	if(ent->modeldata.subject_to_wall<0)
		ent->modeldata.subject_to_wall      = oldmodel->subject_to_wall;
	if(ent->modeldata.subject_to_platform<0)
		ent->modeldata.subject_to_platform  = oldmodel->subject_to_platform;
	if(ent->modeldata.subject_to_obstacle<0)
		ent->modeldata.subject_to_obstacle  = oldmodel->subject_to_obstacle;
	if(ent->modeldata.subject_to_hole<0)
		ent->modeldata.subject_to_hole      = oldmodel->subject_to_hole;
	if(ent->modeldata.subject_to_gravity<0)
		ent->modeldata.subject_to_gravity   = oldmodel->subject_to_gravity;
	if(ent->modeldata.subject_to_screen<0)
		ent->modeldata.subject_to_screen    = oldmodel->subject_to_screen;
	if(ent->modeldata.subject_to_minz<0)
		ent->modeldata.subject_to_minz      = oldmodel->subject_to_minz;
	if(ent->modeldata.subject_to_maxz<0)
		ent->modeldata.subject_to_maxz      = oldmodel->subject_to_maxz;
	if(ent->modeldata.no_adjust_base<0)
		ent->modeldata.no_adjust_base       = oldmodel->no_adjust_base;
	if(ent->modeldata.aimove<0)
		ent->modeldata.aimove               = oldmodel->aimove;
	if(ent->modeldata.aiattack<0)
		ent->modeldata.aiattack             = oldmodel->aiattack;
	if(ent->modeldata.hostile<0)
		ent->modeldata.hostile              = oldmodel->hostile;
	if(ent->modeldata.candamage<0)
		ent->modeldata.candamage            = oldmodel->candamage;
	if(ent->modeldata.projectilehit<0)
		ent->modeldata.projectilehit        = oldmodel->projectilehit;
	if(!ent->modeldata.health)
		ent->modeldata.health               = oldmodel->health;
	if(!ent->modeldata.mp)
		ent->modeldata.mp                   = oldmodel->mp;
	if(ent->modeldata.risetime[0]==-1)
		ent->modeldata.risetime[0]          = oldmodel->risetime[0];
	/*
	if(!ent->modeldata.antigrab)
		ent->modeldata.antigrab             = oldmodel->antigrab;
	if(!ent->modeldata.grabforce)
		ent->modeldata.grabforce            = oldmodel->grabforce;
	if(!ent->modeldata.paingrab)
		ent->modeldata.paingrab             = oldmodel->paingrab;*/

	if(ent->health>ent->modeldata.health)
		ent->health = ent->modeldata.health;
	if(ent->mp>ent->modeldata.mp)
		ent->mp = ent->modeldata.mp;
}


//if syncAnim is set, only change animation reference
void ent_set_model(entity * ent, char * modelname, int syncAnim)
{
	s_model *m = NULL;
	s_model oldmodel;
	if(ent==NULL) shutdown(1, "FATAL: tried to change model of invalid object");
	m = findmodel(modelname);
	if(m==NULL) shutdown(1, "Model not found: '%s'", modelname);
	oldmodel = ent->modeldata;
	ent->model = m;
	ent->modeldata = *m;
	ent_copy_uninit(ent, &oldmodel);
	ent_set_colourmap(ent, ent->map);

	if(syncAnim && m->animation[ent->animnum])
	{
		ent->animation = m->animation[ent->animnum];
		update_frame(ent, ent->animpos);
	}
	else
	{
		ent->attacking = 0;

		if((!selectScreen && !time) || ent->modeldata.type != TYPE_PLAYER)
		{
			// use new playerselect spawn anim
			if( validanim(ent,ANI_SPAWN))
				ent_set_anim(ent, ANI_SPAWN, 0);
			else
				ent_set_anim(ent, ANI_IDLE, 0);
		}
		else if(!selectScreen && time && ent->modeldata.type == TYPE_PLAYER)
		{
			// mid-level respawn
			if( validanim(ent, ANI_RESPAWN))
				ent_set_anim(ent, ANI_RESPAWN, 0);
			else if( validanim(ent, ANI_SPAWN))
				ent_set_anim(ent, ANI_SPAWN, 0);
			else
				ent_set_anim(ent, ANI_IDLE, 0);
		}
		else if(selectScreen && validanim(ent, ANI_SELECT))
			ent_set_anim(ent, ANI_SELECT, 0);
		else
			ent_set_anim(ent, ANI_IDLE, 0);
	}
}


entity * spawn(float x, float z, float a, int direction, char * name, int index, s_model* model)
{
	entity *e = NULL;
	int i, j, id;
	s_defense *dfs;
	float *ofs;
	ScriptVariant* vars;
	s_scripts* scripts;

	if(!model)
	{
		if(index>=0)
			model = model_cache[index].model;
		else if(name)
			model = findmodel(name);
	}

	// Be a bit more tolerant...
	if(model==NULL)
	{
		/*
		if(index>=0)
			printf("FATAL: attempt to spawn object with invalid model cache id (%d)!\n", index);
		else if(name)
			printf("FATAL: attempt to spawn object with invalid model name (%s)!\n", name);*/
		return NULL;
	}

	if(ent_count>=ent_list_size && !alloc_ents()) return NULL; //out of memory ? 

	for(i=0; i<ent_list_size; i++)
	{
		if(!ent_list[i]->exists)
		{
			e = ent_list[i];
			// save these values, or they will loss when memset called
			id      = e->sortid;
			dfs     = e->defense;
			ofs     = e->offense_factors;
			vars    = e->entvars;
			for(j=0; j<max_entity_vars; j++)
				ScriptVariant_Clear(&vars[j]);
			memcpy(dfs, model->defense, sizeof(s_defense)*max_attack_types);
			memcpy(ofs, model->offense_factors, sizeof(float)*max_attack_types);
			// clear up
			clear_all_scripts(e->scripts, 1);
			if(e->waypoints) free(e->waypoints);

			scripts = e->scripts;
			memset(e, 0, sizeof(entity));
			e->drawmethod = plainmethod;
			e->drawmethod.flag = 0;

			// add to list and count current entities
			e->exists = 1;
			ent_count++;

			e->modeldata = *model; // copy the entir model data here
			e->model = model;
			e->defaultmodel = model;

			e->scripts = scripts;
			// copy from model a fresh script

			copy_all_scripts(model->scripts, e->scripts, 1);

			if(ent_count>ent_max) ent_max=ent_count;
			e->timestamp = time; // log time so update function will ignore it if it is new

			e->health = e->modeldata.health;
			e->mp = e->modeldata.mp;
			e->knockdowncount = e->modeldata.knockdowncount;
			e->x = x;
			e->z = z;
			e->a = a;
			e->direction = direction;
			e->nextthink = time + 1;
			ent_set_colourmap(e, 0);
			e->lifespancountdown = model->lifespan; // new life span countdown
			if((e->modeldata.type & (TYPE_PLAYER|TYPE_SHOT)) && level && (level->nohit || savedata.mode)) e->modeldata.hostile &= ~TYPE_PLAYER;
			if(e->modeldata.type==TYPE_PLAYER) e->playerindex = currentspawnplayer;

			if(e->modeldata.type == TYPE_TEXTBOX) textbox = e;

			strncpy(e->name, e->modeldata.name, MAX_NAME_LEN);
			// copy back the value
			e->sortid = id;
			e->defense = dfs;
			e->offense_factors = ofs;
			e->entvars = vars;
			ent_default_init(e);
			return e;
		}
	}
	return NULL;
}



// Break the link an entity has with another one
void ent_unlink(entity *e) {
	if(e->link){
		e->link->link = NULL;
		e->link->grabbing = NULL;
	}
	e->link = NULL;
	e->grabbing = NULL;
}



// Link two entities together
void ents_link(entity *e1, entity *e2)
{
	ent_unlink(e1);
	ent_unlink(e2);
	e1->grabbing = e2;    // Added for platform layering
	e1->link = e2;
	e2->link = e1;
}



void kill(entity *victim)
{
	int i = 0;
	s_attack attack;
	entity* tempent = self;

	execute_onkill_script(victim);

	if(!victim || !victim->exists)
		return;

	if(victim->modeldata.type == TYPE_SHOT && player[(int)victim->playerindex].ent)
		player[(int)victim->playerindex].ent->cantfire = 0;

	ent_unlink(victim);
	victim->weapent = NULL;
	victim->health = 0;
	victim->exists = 0;
	ent_count--;

	clear_all_scripts(victim->scripts, 1);

	if(victim->parent && victim->parent->subentity == victim) victim->parent->subentity = NULL;
	victim->parent = NULL;
	if(victim->modeldata.summonkill)
	{
		attack = emptyattack;
		attack.attack_type = max_attack_types;
		attack.dropv[0] = default_model_dropv[0]; 
		attack.dropv[1] = default_model_dropv[1]; 
		attack.dropv[2] = default_model_dropv[2];
	}
	// kill minions
	if(victim->modeldata.summonkill == 1 && victim->subentity)
	{
		// kill only summoned one
		victim->subentity->parent = NULL;
		self = victim->subentity;
		attack.attack_force = self->health;
		if(self->takedamage && !level_completed)
			self->takedamage(self, &attack);
		else
			kill(self);
	}
	victim->subentity = NULL;

	if(victim==player[0].ent) player[0].ent = NULL;
	else if(victim==player[1].ent) player[1].ent = NULL;
	else if(victim==player[2].ent) player[2].ent = NULL;
	else if(victim==player[3].ent) player[3].ent = NULL;

	if(victim == smartbomber) smartbomber = NULL;
	if(victim == textbox)  textbox = NULL;

	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i]->exists)
		{
			// kill all minions
			self = ent_list[i];
			if(self->parent == victim)
			{
				self->parent = NULL;
				if(victim->modeldata.summonkill == 2)
				{
					attack.attack_force = self->health;
					if(self->takedamage && !level_completed) self->takedamage(self, &attack);
					else kill(self);
				}
			}
			if(self->owner == victim)
			{
				self->owner = victim->owner;
			}
			if(self->opponent == victim) self->opponent = NULL;
			if(self->bound == victim) self->bound = NULL;
			if(self->landed_on_platform == victim) self->landed_on_platform = NULL;
			if(self->hithead == victim) self->hithead = NULL;
			if(self->lasthit == victim) self->lasthit = NULL;
			if(!textbox && self->modeldata.type == TYPE_TEXTBOX)
			textbox = self;
		}
	}
	self = tempent;
}


void kill_all()
{
	int i;
	entity *e = NULL;
	for(i=0; i<ent_max; i++)
	{
		e = ent_list[i];
		if (e && e->exists){
			execute_onkill_script(e);
			clear_all_scripts(e->scripts, 1);
		}
		e->exists = 0; // well, no need to use kill function
	}
	textbox = smartbomber = NULL;
	time = 0;
	ent_count = ent_max = 0;
	if(ent_list_size>MAX_ENTS){ //shrinking...
		free_ents();
		alloc_ents(); //this shouldn't return 0, because the list shrinks...
	}
}


int checkhit(entity *attacker, entity *target, int counter)
{
	short *coords1;
	short *coords2;
	int x1, x2, y1, y2;
	float medx, medy;
	int debug_coords[2][4];
	int topleast, bottomleast, leftleast, rightleast;
	float zdist = 0, z1, z2;

	if(attacker == target || !target->animation->bbox_coords ||
	!attacker->animation->attacks || !target->animation->vulnerable[target->animpos] ||
	((attacker->modeldata.type == TYPE_PLAYER && target->modeldata.type == TYPE_PLAYER) && savedata.mode)) return 0;

	z1 = attacker->z; z2 = target->z;
	coords1 = attacker->animation->attacks[attacker->animpos]->attack_coords;

	if(!counter)
		coords2 = target->animation->bbox_coords[target->animpos];
	else if((target->animation->attacks && target->animation->attacks[target->animpos]) && target->animation->attacks[target->animpos]->counterattack <= attacker->animation->attacks[attacker->animpos]->counterattack)
		coords2 = target->animation->attacks[target->animpos]->attack_coords;
	else return 0;

	if(coords1[5] > coords1[4])
	{
		z1 += coords1[4] + (coords1[5]-coords1[4])/2;
		zdist += (coords1[5]-coords1[4])/2;
	}
	else if(coords1[4])
		zdist += coords1[4];
	else
		zdist += attacker->modeldata.grabdistance/3+1;//temporay fix for integer to float conversion
	if(coords2[5] > coords2[4])
	{
		z2 += coords2[4] + (coords2[5]-coords2[4])/2;
		zdist += (coords2[5]-coords2[4])/2;
	}
	else if(coords2[4])
		zdist += coords2[4];

	zdist++; // pass >= <= check

	if(diff(z1, z2) > zdist)
		return 0;

	x1 = (int)(attacker->x);
	y1 = (int)(z1 - attacker->a);
	x2 = (int)(target->x);
	y2 = (int)(z2 - target->a);


	if(attacker->direction==0){
		debug_coords[0][0] = x1-coords1[2];
		debug_coords[0][1] = y1+coords1[1];
		debug_coords[0][2] = x1-coords1[0];
		debug_coords[0][3] = y1+coords1[3];
	}
	else{
		debug_coords[0][0] = x1+coords1[0];
		debug_coords[0][1] = y1+coords1[1];
		debug_coords[0][2] = x1+coords1[2];
		debug_coords[0][3] = y1+coords1[3];
	}
	if(target->direction==0){
		debug_coords[1][0] = x2-coords2[2];
		debug_coords[1][1] = y2+coords2[1];
		debug_coords[1][2] = x2-coords2[0];
		debug_coords[1][3] = y2+coords2[3];
	} else {
		debug_coords[1][0] = x2+coords2[0];
		debug_coords[1][1] = y2+coords2[1];
		debug_coords[1][2] = x2+coords2[2];
		debug_coords[1][3] = y2+coords2[3];
	}

	if(debug_coords[0][0] > debug_coords[1][2]) return 0;
	if(debug_coords[1][0] > debug_coords[0][2]) return 0;
	if(debug_coords[0][1] > debug_coords[1][3]) return 0;
	if(debug_coords[1][1] > debug_coords[0][3]) return 0;

	// Find center of attack area
	leftleast = debug_coords[0][0];
	if(leftleast < debug_coords[1][0])
		leftleast = debug_coords[1][0];
	topleast = debug_coords[0][1];
	if(topleast < debug_coords[1][1])
		topleast = debug_coords[1][1];
	rightleast = debug_coords[0][2];
	if(rightleast > debug_coords[1][2])
		rightleast = debug_coords[1][2];
	bottomleast = debug_coords[0][3];
	if(bottomleast > debug_coords[1][3])
		bottomleast = debug_coords[1][3];

	medx = (float)(leftleast + rightleast) / 2;
	medy = (float)(topleast + bottomleast) / 2;

	// Now convert these coords to 3D
	lasthitx = medx;

	if(attacker->z > target->z)
		lasthitz = z1 + 1;    // Changed so flashes always spawn in front
	else
		lasthitz = z2 + 1;

	lasthita = lasthitz - medy;
	lasthitt = attacker->animation->attacks[attacker->animpos]->attack_type;
	lasthitc = 1;
	return 1;
}



/*
Calculates the coef relative to the bottom left point. This is done by figuring out how far the entity is from
the bottom of the platform and multiplying the result by the difference of the bottom left point and the top
left point divided by depth of the platform. The same is done for the right side, and checks to see if they are
within the bottom/top and the left/right area.
*/
int testhole(int hole, float x, float z)
{
	float coef1, coef2;
	if(z < level->holes[hole][1] && z > level->holes[hole][1] - level->holes[hole][6])
	{
		coef1 = (level->holes[hole][1] - z) * ((level->holes[hole][2] - level->holes[hole][3]) / level->holes[hole][6]);
		coef2 = (level->holes[hole][1] - z) * ((level->holes[hole][4] - level->holes[hole][5]) / level->holes[hole][6]);
		if(x > level->holes[hole][0] + level->holes[hole][3] + coef1 && x < level->holes[hole][0] + level->holes[hole][5] + coef2)
			return 1;
	}
	return 0;
}

/// find all holes here and return the count
int checkholes(float x, float z)
{
	int i, c;

	for(i=0, c=0; i<level->numholes; i++)
		c += testhole(i, x, z);

	return c;
}

// find the 1st hole here
int checkhole(float x, float z)
{
	int i;

	if(level==NULL) return 0;

	if(level->exit_hole){
		if(x > level->width-(PLAYER_MAX_Z-z)) return 2;
	}

	for(i=0; i<level->numholes; i++)
	{
		if(testhole(i, x, z))
		{
			holez = i;
			return 1;
		}
	}
	return 0;
}

/*
Calculates the coef relative to the bottom left point. This is done by figuring out how far the entity is from
the bottom of the platform and multiplying the result by the difference of the bottom left point and the top
left point divided by depth of the platform. The same is done for the right side, and checks to see if they are
within the bottom/top and the left/right area.
*/
int testwall(int wall, float x, float z)
{
	float coef1, coef2;
//    if(wall >= level->numwalls || wall < 0) return 0;
	if(z < level->walls[wall][1] && z > level->walls[wall][1] - level->walls[wall][6])
	{
		coef1 = (level->walls[wall][1] - z) * ((level->walls[wall][2] - level->walls[wall][3]) / level->walls[wall][6]);
		coef2 = (level->walls[wall][1] - z) * ((level->walls[wall][4] - level->walls[wall][5]) / level->walls[wall][6]);
		if(x > level->walls[wall][0] + level->walls[wall][3] + coef1 && x < level->walls[wall][0] + level->walls[wall][5] + coef2) return 1;
	}

	return 0;
}

// find all walls here within altitude1 and 2, return the count
int checkwalls(float x, float z, float a1, float a2)
{
	int i, c;

	for(i=0, c=0; i<level->numwalls; i++)
		c += (testwall(i, x, z) && level->walls[i][7] >= a1 && level->walls[i][7] <= a2);

	return c;
}

// get a highest wall below this altitude
int checkwall_below(float x, float z, float a)
{
	float maxa;
	int i, ind;

	if(level==NULL) return -1;

	maxa = 0;
	ind = -1;
	for(i=0; i<level->numwalls; i++)
	{
		if(testwall(i, x, z) && level->walls[i][7] <= a && level->walls[i][7] > maxa)
		{
			maxa = level->walls[i][7];
			ind = i;
		}
	}

	return ind;
}

// return the 1st wall found here
int checkwall(float x, float z)
{
	int i;
	if(level==NULL) return -1;

	for(i=0; i<level->numwalls; i++)
		if(testwall(i, x, z)) return i;

	return -1;
}

/*
Calculates the coef relative to the bottom left point. This is done by figuring out how far the entity is from
the bottom of the platform and multiplying the result by the difference of the bottom left point and the top
left point divided by depth of the platform. The same is done for the right side, and checks to see if they are
within the bottom/top and the left/right area.
*/
int testplatform(entity* plat, float x, float z, entity* exclude)
{
	float coef1, coef2;
	float offz, offx;
	if(plat==exclude) return 0;
	if(!plat->animation || !plat->animation->platform || !plat->animation->platform[plat->animpos][7]) return 0;
	offz = plat->z+plat->animation->platform[plat->animpos][1];
	offx = plat->x+plat->animation->platform[plat->animpos][0];
	if(z <= offz && z > offz - plat->animation->platform[plat->animpos][6])
	{
		coef1 = (offz - z) * ((plat->animation->platform[plat->animpos][2] -
			plat->animation->platform[plat->animpos][3]) / plat->animation->platform[plat->animpos][6]);
		coef2 = (offz - z) * ((plat->animation->platform[plat->animpos][4] -
			plat->animation->platform[plat->animpos][5]) / plat->animation->platform[plat->animpos][6]);

		if(x > offx + plat->animation->platform[plat->animpos][3] + coef1 &&
		   x < offx + plat->animation->platform[plat->animpos][5] + coef2) return 1;
	}
	return 0;
}


//find the first platform between these 2 altitudes
entity * check_platform_between(float x, float z, float amin, float amax, entity* exclude)
{
	entity *plat = NULL;
	int i;

	if(level==NULL) return NULL;

	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i]->exists && testplatform(ent_list[i], x, z, exclude) )
		{
			plat = ent_list[i];
			if(plat->a <= amax && plat->a + plat->animation->platform[plat->animpos][7] > amin)
			{
				return plat;
			}
		}
	}
	return NULL;
}

//find a lowest platform above this altitude
entity * check_platform_above(float x, float z, float a, entity* exclude)
{
	float mina;
	entity *plat = NULL;
	int i, ind;

	if(level==NULL) return NULL;

	mina = 9999999;
	ind = -1;
	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i]->exists && testplatform(ent_list[i], x, z, exclude) )
		{
			plat = ent_list[i];
			if(plat->a >= a && plat->a < mina)
			{
				mina = plat->a;
				ind = i;
			}
		}
	}
	return (ind>=0)?ent_list[ind]:NULL;
}

//find a highest platform below this altitude
entity * check_platform_below(float x, float z, float a, entity* exclude)
{
	float maxa;
	entity *plat = NULL;
	int i, ind;

	if(level==NULL) return NULL;

	maxa = MIN_INT;
	ind = -1;
	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i]->exists && testplatform(ent_list[i], x, z, exclude) )
		{
			plat = ent_list[i];
			if(plat->a + plat->animation->platform[plat->animpos][7] <= a &&
			   plat->a + plat->animation->platform[plat->animpos][7] > maxa)
			{
				maxa = plat->a + plat->animation->platform[plat->animpos][7];
				ind = i;
			}
		}
	}
	return (ind>=0)?ent_list[ind]:NULL;
}

// find the 1st platform entity here
entity * check_platform(float x, float z, entity* exclude)
{
	int i;
	if(level==NULL) return NULL;

	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i]->exists && testplatform(ent_list[i], x, z, exclude))
		{
			return ent_list[i];
		}
	}
	return NULL;
}

// for adjust grab position function, test if an entity can move from a to b
// TODO: check points between the two pionts, if necessary
int testmove(entity* ent, float sx, float sz, float x, float z){
	entity *other = NULL;
	int wall, heightvar;
	float xdir, zdir;

	xdir = x - sx;
	zdir = z - sz;

	if(!xdir && !zdir) return 1;

	// -----------bounds checking---------------
	// Subjec to Z and out of bounds? Return to level!
	if (ent->modeldata.subject_to_minz>0)
	{
		if(zdir && z < PLAYER_MIN_Z)
			return 0;
	}

	if (ent->modeldata.subject_to_maxz>0)
	{
		if(zdir && z > PLAYER_MAX_Z)
			return 0;
	}

	// End of level is blocked?
	if(level->exit_blocked)
	{
		if(x > level->width-30-(PLAYER_MAX_Z-z)) return 0;
	}
	// screen checking
	if(ent->modeldata.subject_to_screen>0)
	{
		if(x < advancex+10) return 0;
		else if(x > advancex+(videomodes.hRes-10)) return 0;
	}
	//-----------end of bounds checking-----------

	//-------------hole checking ---------------------
	if(ent->modeldata.subject_to_hole>0)
	{
		if(checkhole(x, z) && checkwall(x, z)<0 && (((other = check_platform(x, z, ent)) &&  ent->base < other->a + other->animation->platform[other->animpos][7]) || other == NULL))
			return 0;
	}
	//-----------end of hole checking---------------

	//--------------obstacle checking ------------------
	if(ent->modeldata.subject_to_obstacle>0)
	{
		if((other = find_ent_here(ent, x, z, (TYPE_OBSTACLE | TYPE_TRAP), NULL)) &&
		   (!other->animation->platform||!other->animation->platform[other->animpos][7]))
			return 0;
	}
	//-----------end of obstacle checking--------------

	// ---------------- platform checking----------------

	if(ent->animation->height) heightvar = ent->animation->height;
	else heightvar = ent->modeldata.height;

	// Check for obstacles with platform code and adjust base accordingly
	if(ent->modeldata.subject_to_platform>0 && (other = check_platform_between(x, z, ent->a, ent->a+heightvar, ent)) )
	{
		return 0;
	}
	//-----------end of platform checking------------------

	// ------------------ wall checking ---------------------
	if(ent->modeldata.subject_to_wall>0 && (wall = checkwall(x, z))>=0 && level->walls[wall][7]>ent->a)
	{
		if(validanim(ent,ANI_JUMP) && sz<level->walls[wall][1] && sz>level->walls[wall][1]-level->walls[wall][6]) //Can jump?
		{
			//rmin = (float)ent->modeldata.animation[ANI_JUMP]->range.xmin;
			//rmax = (float)ent->modeldata.animation[ANI_JUMP]->range.xmax;
			if(level->walls[wall][7]<ent->a+ent->modeldata.animation[ANI_JUMP]->range.xmax) return -1;
		}
		return 0;
	}
	//----------------end of wall checking--------------

	return 1;

}

// find real opponent
void set_opponent(entity* ent, entity* other)
{
	entity* realself, *realother;

	if(!ent) return;

	realself = ent;
	while(realself->owner) realself = realself->owner;

	realother = other;
	while(realother && realother->owner) realother = realother->owner;

	realself->opponent = ent->opponent = realother;
	if(realother) realother->opponent = other->opponent = realself;

}


void do_attack(entity *e)
{
	int them;
	int i;
	int force;
	entity *temp            = NULL;
	entity *flash           = NULL;    // Used so new flashes can be used
	entity *def             = NULL;
	entity *topowner        = NULL;
	entity *otherowner      = NULL;
	int didhit              = 0;
	int didblock            = 0;    // So a different sound effect can be played when an attack is blocked
	int current_attack_id;
	int current_follow_id   = 0;
#define followed (current_anim!=e->animation)
	s_anim* current_anim;
	s_attack* attack = e->animation->attacks[e->animpos];
	static unsigned int new_attack_id = 1;
	int fdefense_blockthreshold = (int)self->defense[(short)attack->attack_type].blockthreshold; //Maximum damage that can be blocked for attack type.

	// Can't get hit after this
	if(level_completed || !attack) return;

	topowner = e; // trace the top owner, for projectile combo checking :)
	while(topowner->owner) topowner = topowner->owner;

	if(e->projectile>0) them = e->modeldata.projectilehit;
	else them = e->modeldata.candamage;

	// Every attack gets a unique ID to make sure no one
	// gets hit more than once by the same attack
	current_attack_id = e->attack_id;

	if(!current_attack_id)
	{
		++new_attack_id;
		if(new_attack_id==0) new_attack_id = 1;
		e->attack_id = current_attack_id = new_attack_id;
	}

	force = attack->attack_force;
	current_anim = e->animation;

	for(i=0; i<ent_max && !followed; i++)
	{

		// if #0
		if( ent_list[i]->exists &&
			!ent_list[i]->dead && // dont hit the dead
			(ent_list[i]->invincible != 1 || attack->attack_type == ATK_ITEM) && // so invincible people can get items
			!(current_anim->attackone>0 && e->lasthit && ent_list[i]!=e->lasthit) &&
			(ent_list[i]->modeldata.type & them) &&
			ent_list[i]->pain_time<time && //(ent_list[i]->pain_time<time || current_anim->fastattack) &&
			ent_list[i]->takedamage &&
			ent_list[i]->hit_by_attack_id != current_attack_id &&
			((ent_list[i]->takeaction != common_lie && attack->otg < 2) || (attack->otg >= 1 && ent_list[i]->takeaction == common_lie)) && //over the ground hit
			((ent_list[i]->falling == 0 && attack->jugglecost >= 0) || (ent_list[i]->falling == 1 && attack->jugglecost <= ent_list[i]->modeldata.jugglepoints.current)) && // juggle system
			(checkhit(e, ent_list[i], 0) || // normal check bbox
			 (attack->counterattack && checkhit(e, ent_list[i], 1)))  )// check counter, e.g. upper
		{
			temp = self;
			self = ent_list[i];

			execute_ondoattack_script(self, e, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add, 0, current_attack_id);	//Execute on defender.
			execute_ondoattack_script(e, self, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add, 1, current_attack_id);	//Execute on attacker.

			if(!lasthitc){	return;	}	//12312010, DC: Allows modder to cancel engine's attack handling. Useful for parry systems, alternate blocking, or other scripted hit events.

			didhit = 1;

			otherowner = self; // trace top owner for opponent
			while(otherowner->owner) otherowner = otherowner->owner;

			//if #01, if they are fired by the same owner, or the owner itself
			if(topowner == otherowner) didhit = 0;

			//if #02 , ground missle checking, and bullets wont hit each other
			if( (e->owner && self->owner) ||
				(e->modeldata.ground && inair(e))  )
			{
				didhit = 0;
			}//end of if #02

			//if #05,   blocking code section
			if(didhit)
			{
				if(attack->attack_type == ATK_ITEM){
					 execute_didhit_script(e, self, force, attack->attack_drop, self->modeldata.subtype, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add, 1);
					 didfind_item(e);
					 return;
				}
				//if #051
				if(self->toexplode == 1) self->toexplode = 2;    // Used so the bomb type entity explodes when hit
				//if #052
				if(e->toexplode == 1) e->toexplode = 2;    // Used so the bomb type entity explodes when hitting

				if(inair(self)) self->modeldata.jugglepoints.current = self->modeldata.jugglepoints.current - attack->jugglecost; //reduce available juggle points.

				//if #053
				if( !self->modeldata.nopassiveblock && // cant block by itself
					validanim(self,ANI_BLOCK) && // of course, move it here to avoid some useless checking
					((self->modeldata.guardpoints.maximum == 0) || (self->modeldata.guardpoints.maximum > 0 && self->modeldata.guardpoints.current > 0)) &&
					!(self->link ||
					inair(self) ||
					self->frozen ||
					(self->direction == e->direction && self->modeldata.blockback < 1) ||                       // Can't block an attack that is from behind unless blockback flag is enabled
					(!self->idling && self->attacking>=0)) &&                                                   // Can't block if busy, attack <0 means the character is preparing to attack, he can block during this time
					attack->no_block <= self->defense[attack->attack_type].blockpower &&       // If unblockable, will automatically hit
					(rand32()&self->modeldata.blockodds) == 1 &&                                                // Randomly blocks depending on blockodds (1 : blockodds ratio)
					(!self->modeldata.thold || (self->modeldata.thold > 0 && self->modeldata.thold > force))&&
					(!fdefense_blockthreshold ||                                                                //Specific attack type threshold.
					(fdefense_blockthreshold > force)))
				{   //execute the didhit script
					execute_didhit_script(e, self, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add, 1);
					self->takeaction = common_block;
					set_blocking(self);
					self->xdir = self->zdir = 0;
					ent_set_anim(self, ANI_BLOCK, 0);
					execute_didblock_script(self, e, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add);
					if(self->modeldata.guardpoints.maximum > 0) self->modeldata.guardpoints.current = self->modeldata.guardpoints.current - attack->guardcost;
					++current_anim->animhits;
					didblock = 1;    // Used for when playing the block.wav sound
					// Spawn a flash
					//if #0531
					if(!attack->no_flash)
					{
						if(!self->modeldata.noatflash)
						{
							if(attack->blockflash>=0) flash = spawn(lasthitx, lasthitz, lasthita, 0, NULL, attack->blockflash, NULL); // custom bflash
							else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, ent_list[i]->modeldata.bflash, NULL);    // New block flash that can be smaller
						}
						else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, self->modeldata.bflash, NULL);
						//ent_default_init(flash); // initiliaze this because there're no default values now

						if(flash) execute_onspawn_script(flash);
					}
					//end of if #0531
				}
				else if(self->modeldata.nopassiveblock && // can block by itself
					self->blocking &&  // of course he must be blocking
					((self->modeldata.guardpoints.maximum == 0) || (self->modeldata.guardpoints.maximum > 0 && self->modeldata.guardpoints.current > 0)) &&
					!((self->direction == e->direction && self->modeldata.blockback < 1)|| self->frozen) &&    // Can't block if facing the wrong direction (unless blockback flag is enabled) or frozen in the block animation or opponent is a projectile
					attack->no_block <= self->defense[(short)attack->attack_type].blockpower &&    // Make sure you are actually blocking and that the attack is blockable
					(!self->modeldata.thold ||
					(self->modeldata.thold > 0 &&
					self->modeldata.thold > force))&&
					(!self->defense[(short)attack->attack_type].blockthreshold ||                   //Specific attack type threshold.
					(self->defense[(short)attack->attack_type].blockthreshold > force)))
				{    // Only block if the attack is less than the players threshold
					//execute the didhit script
					execute_didhit_script(e, self, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add, 1);
					if(self->modeldata.guardpoints.maximum > 0) self->modeldata.guardpoints.current = self->modeldata.guardpoints.current - attack->guardcost;
					++current_anim->animhits;
					didblock = 1;    // Used for when playing the block.wav sound

					if(self->modeldata.blockpain && self->modeldata.blockpain <= force && self->animation == self->modeldata.animation[ANI_BLOCK]) //Blockpain 1 and in block animation?
					{
						set_blockpain(self, attack->attack_type, 0);
					}
					execute_didblock_script(self, e, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add);

					// Spawn a flash
					if(!attack->no_flash)
					{
						if(!self->modeldata.noatflash)
						{
							if(attack->blockflash>=0) flash = spawn(lasthitx, lasthitz, lasthita, 0, NULL, attack->blockflash, NULL); // custom bflash
							else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, ent_list[i]->modeldata.bflash, NULL);    // New block flash that can be smaller
						}
						else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, self->modeldata.bflash, NULL);
						//ent_default_init(flash); // initiliaze this because there're no default values now
						if(flash) execute_onspawn_script(flash);
					}
				}
				else if((self->animpos >= self->animation->counterrange.framestart && self->animpos <= self->animation->counterrange.frameend)  &&	//Within counter range?
					!self->frozen)// &&																								//Not frozen?
					//(self->animation->counterrange.condition <= 1 && e->modeldata.type & them)) //&&												//Friend/foe?
					//(self->animation->counterrange.condition <= 3 && !attack->no_block) &&														//Counter attack self couldn't block?
					//self->animation->counterrange.condition <= 2 ||
					//self->animation->counterrange.condition <= 2 || !(self->direction == e->direction)) //&&										//Direction check.
					//(self->animation->counterrange.condition <= 3 || !attack->freeze))															//Freeze attacks?

					//&& (!self->animation->counterrange.damaged || self->health > force))													// Does damage matter?
				{
					if(self->animation->counterrange.damaged) self->health -= force;					// Take damage?
					current_follow_id = animfollows[self->animation->followanim - 1];
					if(validanim(self,current_follow_id))
					{
						if(self->modeldata.animation[current_follow_id]->attackone==-1)
							self->modeldata.animation[current_follow_id]->attackone = self->animation->attackone;
						ent_set_anim(self, current_follow_id, 0);
						self->hit_by_attack_id = current_attack_id;
					}

					if(!attack->no_flash)
					{
						if(!self->modeldata.noatflash)
						{
							if(attack->blockflash>=0) flash = spawn(lasthitx, lasthitz, lasthita, 0, NULL, attack->blockflash, NULL); // custom bflash
							else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, ent_list[i]->modeldata.bflash, NULL);    // New block flash that can be smaller
						}
						else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, self->modeldata.bflash, NULL);
						//ent_default_init(flash); // initiliaze this because there're no default values now
						if(flash) execute_onspawn_script(flash);
					}
				}
				else if(self->takedamage(e, attack))
				{    // Didn't block so go ahead and take the damage
					execute_didhit_script(e, self, force, attack->attack_drop, attack->attack_type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add, 0);
					++e->animation->animhits;

					e->lasthit = self;

					// Spawn a flash
					if(!attack->no_flash)
					{
						if(!self->modeldata.noatflash)
						{
							if(attack->hitflash>=0) flash = spawn(lasthitx, lasthitz, lasthita, 0, NULL, attack->hitflash, NULL);
							else flash = spawn(lasthitx, lasthitz, lasthita, 0, NULL, e->modeldata.flash, NULL);
						}
						else flash = spawn(lasthitx,lasthitz,lasthita, 0, NULL, self->modeldata.flash, NULL);
						if(flash) execute_onspawn_script(flash);
					}
					topowner->combotime = time + combodelay; // well, add to its owner's combo

					if(e->pausetime<time || (inair(e) && !equalairpause))          // if equalairpause is set, inair(e) is nolonger a condition for extra pausetime
					{    // Adds pause to the current animation
						e->toss_time += attack->pause_add;      // So jump height pauses in midair
						e->nextanim += attack->pause_add;       //Pause animation for a bit
						e->nextthink += attack->pause_add;      // So anything that auto moves will pause
						e->pausetime = time + attack->pause_add ; //UT: temporary solution
					}

					self->toss_time += attack->pause_add;       // So jump height pauses in midair
					self->nextanim += attack->pause_add;        //Pause animation for a bit
					self->nextthink += attack->pause_add;       // So anything that auto moves will pause

				}
				else
				{
					didhit = 0;
					continue;
				}
				// end of if #053

				// if #054
				if(flash)
				{
					if(flash->modeldata.toflip) flash->direction = (e->x > self->x);    // Now the flash will flip depending on which side the attacker is on

					flash->base = lasthita;
					flash->autokill = 2;
				}//end of if #054

				// 2007 3 24, hmm, def should be like this
				if(didblock && !def)  def = self;
				//if #055
				if((e->animation->followanim) &&                                        // follow up?
					(e->animation->counterrange.framestart == -1) &&                                // This isn't suppossed to be a counter, right?
					((e->animation->followcond < 2) || (self->modeldata.type & e->modeldata.hostile)) &&    // Does type matter?
					((e->animation->followcond < 3) || ((self->health > 0) &&
					!didblock)) &&                   // check if health or blocking matters
					((e->animation->followcond < 4) || cangrab(e,self))  )// check if nograb matters
				{
					current_follow_id = animfollows[e->animation->followanim-1];
					if(validanim(e,current_follow_id))
					{
						if(e->modeldata.animation[current_follow_id]->attackone==-1)
							e->modeldata.animation[current_follow_id]->attackone = e->animation->attackone;
						ent_set_anim(e, current_follow_id, 1);          // Then go to it!
					}
					//followed = 1; // quit loop, animation is changed
				}//end of if #055

				self->hit_by_attack_id = current_attack_id;
				if(self==def) self->blocking = didblock; // yeah, if get hit, stop blocking
				
				//2011/11/24 UT: move the pain_time logic here, 
				// because block needs this as well otherwise blockratio causes instant death
				self->pain_time = time + (attack->pain_time?attack->pain_time:(GAME_SPEED / 5));
				self->nextattack = 0; // reset this, make it easier to fight back
			}//end of if #05
			self = temp;
		}//end of if #0

	}//end of for


	// if ###
	if(didhit)
	{
		// well, dont check player or not - UTunnels. TODO: take care of that healthcheat
		if(e==topowner && current_anim->energycost.cost > 0 && nocost && !healthcheat) e->tocost = 1;    // Set flag so life is subtracted when animation is finished
		else if(e!=topowner && current_anim->energycost.cost > 0 && nocost && !healthcheat && !e->tocost) // if it is not top, then must be a shot
		{
			if(current_anim->energycost.mponly != 2 && topowner->mp > 0)
			{
				topowner->mp -= current_anim->energycost.cost;
				if(topowner->mp < 0) topowner->mp = 0;
			}
			else
			{
				topowner->health -= current_anim->energycost.cost;
				if(topowner->health <= 0) topowner->health = 1;
			}

			topowner->cantfire = 0;    // Life subtracted, so go ahead and allow firing
			e->tocost = 1;    // Little backwards, but set to 1 so cost doesn't get subtracted multiple times
		}
		// New blocking checks
		//04/27/2008 Damon Caskey: Added checks for defense property specfic blockratio and type. Could probably use some cleaning.
		if(didblock)
		{
			if(blockratio || def->defense[(short)attack->attack_type].blockratio) // Is damage reduced?
			{
				if (def->defense[(short)attack->attack_type].blockratio){                      //Typed blockratio?
					force = (int)(force * def->defense[(short)attack->attack_type].blockratio);
				}else{                                                                            //No typed. Use static block ratio.
					force = force / 4;
				}

				if(mpblock && !def->defense[(short)attack->attack_type].blocktype){                                                                                 // Drain MP bar first?
					def->mp -= force;
					if(def->mp < 0)
					{
						force = -def->mp;
						def->mp = 0;
					}
					else force = 0;                                                               // Damage removed from MP!
				}else if(def->defense[(short)attack->attack_type].blocktype==1){                //Damage from MP only for this attack type.
					def->mp -= force;
					if(def->mp < 0){
						force = -def->mp;
						def->mp = 0;
					}
					else force = 0;                                                               // Damage removed from MP!
				}else if(def->defense[(short)attack->attack_type].blocktype==2){              //Damage from both HP and MP at once.
					def->mp -= force;
				}else if(def->defense[(short)attack->attack_type].blocktype==-1){             //Health only?
					//Do nothing. This is so modders can overidde energycost.mponly 1 with health only.
				}

				if(force < def->health)                    // If an attack won't deal damage, this line won't do anything anyway.
					def->health -= force;
				else if(nochipdeath)                       // No chip deaths?
					def->health = 1;
				else
				{
					temp = self;
					self = def;
					self->takedamage(e, attack);           // Must be a fatal attack, then!
					self = temp;
				}
			}
		}

		if(!didblock)
		{
			topowner->rushtime = time + (GAME_SPEED*rush[1]);
			topowner->rush[0]++;
			if(topowner->rush[0] > topowner->rush[1] && topowner->rush[0] > 1) topowner->rush[1] = topowner->rush[0];
		}

		if(didblock)
		{
			if(attack->blocksound >= 0) sound_play_sample(attack->blocksound, 0, savedata.effectvol,savedata.effectvol, 100); // New custom block sound effect
			else if(SAMPLE_BLOCK >= 0) sound_play_sample(SAMPLE_BLOCK, 0, savedata.effectvol,savedata.effectvol, 100);    // Default block sound effect
		}
		else if(e->projectile > 0 && SAMPLE_INDIRECT >= 0) sound_play_sample(SAMPLE_INDIRECT, 0, savedata.effectvol,savedata.effectvol, 100);
		else
		{
			if(noslowfx)
			{
				if(attack->hitsound >= 0) sound_play_sample(attack->hitsound, 0, savedata.effectvol,savedata.effectvol, 100);
			}
			else
			{
				if(attack->hitsound >= 0) sound_play_sample(attack->hitsound, 0, savedata.effectvol,savedata.effectvol, 105 - force);
			}
		}

		if(e->remove_on_attack) kill(e);
	}//end of if ###
#undef followed
}


void check_gravity()
{
	int heightvar;
	entity* other, *dust;
	s_attack attack;
	float gravity;
	float fmin,fmax;

	if(!is_frozen(self) )// Incase an entity is in the air, don't update animations
	{
		if((self->falling || self->tossv || self->a!=self->base) && self->toss_time <= time)
		{
			if(self->modeldata.subject_to_platform>0 && self->tossv>0)
				other = check_platform_above(self->x, self->z, self->a+self->tossv, self);
			else other = NULL;

			if(self->animation->height) heightvar = self->animation->height;
			else heightvar = self->modeldata.height;

			if( other && other->a<=self->a+heightvar)
			{
				if(self->hithead == NULL) // bang! Hit the ceiling.
				{
					self->tossv = 0;
					self->hithead = other;
					execute_onblocka_script(self, other);
				}
			}
			else self->hithead = NULL;
			// gravity, antigravity factors
			self->a += self->tossv;
			if(self->animation->dive) gravity = 0;
			else gravity = (level?level->gravity:default_level_gravity) * (1.0-self->modeldata.antigravity-self->antigravity);
			if(self->modeldata.subject_to_gravity>0)
				self->tossv += gravity;

			fmin = (level?level->maxfallspeed:default_level_maxfallspeed);
			fmax = (level?level->maxtossspeed:default_level_maxtossspeed);

			if(self->tossv < fmin)
			{
				self->tossv = fmin;
			}
			else if(self->tossv > fmax)
			{
				self->tossv = fmax;
			}
			if(self->animation->dropframe>=0 && self->tossv<=0 && self->animpos<self->animation->dropframe) // begin dropping
			{
				update_frame(self, self->animation->dropframe);
			}
			if (self->tossv) execute_onmovea_script(self); //Move A event.

			if(self->idling && validanim(self, ANI_WALKOFF))
			{
				self->idling = 0;
				self->takeaction = common_walkoff;
				ent_set_anim(self, ANI_WALKOFF, 0);
			}

			// UTunnels: tossv <= 0 means land, while >0 means still rising, so
			// you wont be stopped if you are passing the edge of a wall
			if( (self->a<=self->base || !inair(self)) && self->tossv <= 0)
			{
				self->a = self->base;
				self->falling = 0;
				//self->projectile = 0;
				// cust dust entity
				if(self->modeldata.dust[0]>=0 && self->tossv < -1 && self->drop)
				{
					dust = spawn(self->x, self->z, self->a, self->direction, NULL, self->modeldata.dust[0], NULL);
					if(dust){
						dust->base = self->a;
						dust->autokill = 2;
						execute_onspawn_script(dust);
					}
				}
				// bounce/quake
				if(tobounce(self) && self->modeldata.bounce)
				{
					int i;
					self->xdir /= self->animation->bounce;
					self->zdir /= self->animation->bounce;
					toss(self, (-self->tossv)/self->animation->bounce);
					if(level && !self->modeldata.noquake) level->quake = 4;    // Don't shake if specified
					if(SAMPLE_FALL >= 0) sound_play_sample(SAMPLE_FALL, 0, savedata.effectvol,savedata.effectvol, 100);
					if(self->modeldata.type == TYPE_PLAYER) control_rumble(self->playerindex, 100*(int)self->tossv/2);
					for(i=0; i<MAX_PLAYERS; i++) control_rumble(i, 75*(int)self->tossv/2);
				}
				else if((!self->animation->seta || self->animation->seta[self->animpos]<0) &&
					(!self->animation->movea || self->animation->movea[self->animpos]<=0))
					self->xdir = self->zdir = self->tossv= 0;
				else self->tossv = 0;

				if(self->animation->landframe.frame>=0                                 //Has landframe?
                    && self->animation->landframe.frame<= self->animation->numframes   //Not over animation frame count?
                    && self->animpos < self->animation->landframe.frame)               //Not already past landframe?
				{
					if(self->animation->landframe.ent>=0)
					{
						dust = spawn(self->x, self->z, self->a, self->direction, NULL, self->animation->landframe.ent, NULL);
						if(dust){
							dust->base = self->a;
							dust->autokill = 2;
							execute_onspawn_script(dust);
						}
					}
					update_frame(self, self->animation->landframe.frame);
				}

				// takedamage if thrown or basted
				if(self->damage_on_landing > 0 && !self->dead)
				{
					if(self->takedamage)

					{
						attack              = emptyattack;
						attack.attack_force = self->damage_on_landing;
						attack.attack_type  = self->damagetype;
						self->takedamage(self, &attack);
					}
					else
					{
						self->health -= self->damage_on_landing;
						if(self->health <=0 ) kill(self);
						self->damage_on_landing = 0;
					}
				}
				// in case landing, set hithead to NULL
				self->hithead = NULL;
			}// end of if - land checking
			self->toss_time = time + (GAME_SPEED/100);
		}// end of if  - in-air checking

	}//end of if
}

void check_lost()
{
	s_attack attack;
	int osk = self->modeldata.offscreenkill?self->modeldata.offscreenkill:DEFAULT_OFFSCREEN_KILL;

	if((self->z!=100000 && (advancex - self->x>osk || self->x - advancex - videomodes.hRes>osk ||
		(level->scrolldir!=SCROLL_UP && level->scrolldir!=SCROLL_DOWN && (advancey - self->z + self->a>osk || self->z - self->a - advancey - videomodes.vRes>osk)) ||
		((level->scrolldir==SCROLL_UP || level->scrolldir==SCROLL_DOWN) && (self->z-self->a<-osk || self->z-self->a>videomodes.vRes + osk))		) )
		|| self->a < 2*PIT_DEPTH) //self->z<100000, so weapon item won't be killed
	{
		if(self->modeldata.type==TYPE_PLAYER)
		player_die();
		else
		kill(self);
		return;
	}
	// fall in to a pit
	if(self->a < PIT_DEPTH || self->lifespancountdown<0)
	{
		if(!self->takedamage) kill(self);
		else
		{
			attack              = emptyattack;
			attack.dropv[0] = default_model_dropv[0];
			attack.dropv[1] = default_model_dropv[1];
			attack.dropv[2] = default_model_dropv[2];
			attack.attack_force = self->health;
			attack.attack_type  = max_attack_types;
			self->health = 0;
			self->takedamage(self, &attack);
		}
		return;
	}//else
	// Doom count down
	if(!is_frozen(self) && self->lifespancountdown != (float)0xFFFFFFFF) self->lifespancountdown--;
}

// grab walk check
void check_link_move(float xdir, float zdir)
{
	float x, z, gx, gz;
	int tryresult;
	entity* tempself = self;
	gx = self->grabbing->x; gz = self->grabbing->z;
	x = self->x; z = self->z;
	self = self->grabbing;
	tryresult = self->trymove(xdir, zdir);
	self = tempself;
	if(tryresult!=1) // changed
	{
		xdir = self->grabbing->x - gx;
		zdir = self->grabbing->z - gz;
	}
	tryresult = self->trymove(xdir, zdir);
	if(tryresult != 1)
	{
		self->grabbing->x = self->x - x + gx;
		self->grabbing->z = self->z - z + gz;
	}
}

void check_ai()
{
	entity* plat;
	// check moving platform
	if((plat=self->landed_on_platform) &&
		(plat->xdir || plat->zdir) &&
		(plat->nextthink <= time || (plat->update_mark & 2)) &&// plat is updated before self or will be updated this loop
		testplatform(plat,self->x,self->z, NULL) &&
		self->a <= plat->a + plat->animation->platform[plat->animpos][7] ) // on the platform?
	{
		// passive move with the platform
		if(self->trymove )
		{
			// grab walk check
			if(self->grabbing && self->grabwalking && self->grabbing->trymove)
			{
				check_link_move(plat->xdir, plat->zdir);
			}
			else self->trymove(plat->xdir, plat->zdir);
		}
		else
		{
			self->x += plat->xdir;
			self->z += plat->zdir;
		}
	}

	if(self->nextthink <= time && !endgame)
	{
		self->update_mark |= 2; //mark it
		// take actions
		if(self->takeaction) self->takeaction();

		// A.I. think
		if(self->think)
		{
			if(self->nextthink<=time) self->nextthink = time + THINK_SPEED;
			// use noaicontrol flag to turn of A.I. think
			if(!self->noaicontrol) self->think();
		}

		// Execute think script
		execute_think_script(self);

		// A.I. move
		if (self->xdir || self->zdir)
		{
			if(self->trymove)
			{
				// grab walk check
				if(self->grabbing && self->grabwalking && self->grabbing->trymove)
				{
					check_link_move(self->xdir, self->zdir);
				}
				else if(self->trymove(self->xdir, self->zdir)!=1 && self->idling)
				{
					self->pathblocked++; // for those who walk against wall or borders
				}
				else
				{
					self->pathblocked = 0;
				}
			}
			else
			{
				self->x += self->xdir;
				self->z += self->zdir;
			}
		}
		// Used so all entities can have a spawn animation, and then just changes to the idle animation when done
		// move here to so players wont get stuck
		if((self->animation == self->modeldata.animation[ANI_SPAWN] || self->animation == self->modeldata.animation[ANI_RESPAWN]) && !self->animating /*&& (!inair(self)||!self->modeldata.subject_to_gravity)*/) set_idle(self);
	}
}


void update_animation()
{
	int f, wall, hole;
	float move, movez, seta;
	entity *other = NULL;

	if(level)
	{
		if(self->modeldata.facing == 1 || level->facing == 1) self->direction = 1;
		else if(self->modeldata.facing == 2 || level->facing == 2) self->direction = 0;
		else if((self->modeldata.facing == 3 || level->facing == 3) && (level->scrolldir & SCROLL_RIGHT)) self->direction = 1;
		else if((self->modeldata.facing == 3 || level->facing == 3) && (level->scrolldir & SCROLL_LEFT)) self->direction = 0;
		if(self->modeldata.type == TYPE_PANEL)
		{
			self->x += scrolldx * ((float)(self->modeldata.speed));
			if(level->scrolldir==SCROLL_UP)
			{
				self->a += scrolldy * ((float)(self->modeldata.speed));
			}
			else if(level->scrolldir==SCROLL_DOWN)
			{
				self->a -= scrolldy * ((float)(self->modeldata.speed));
			}
			else
			{
				self->a -= scrolldy * ((float)(self->modeldata.speed));
			}
		}
		if(self->modeldata.scroll)
		{
			self->x += scrolldx * ((float)(self->modeldata.scroll));
			if(level->scrolldir==SCROLL_UP)
			{
				self->a += scrolldy * ((float)(self->modeldata.scroll));
			}
			else if(level->scrolldir==SCROLL_DOWN)
			{
				self->a -= scrolldy * ((float)(self->modeldata.scroll));
			}
			else
			{
				self->a -= scrolldy * ((float)(self->modeldata.scroll));
			}
		}
	}

	if(self->invincible && time >= self->invinctime)    // Invincible time has run out, turn off
	{
		self->invincible    = 0;
		self->blink         = 0;
		self->invinctime    = 0;
		self->arrowon       = 0;
	}

	if(self->freezetime && time >= self->freezetime)
	{
		unfrozen(self);
	}

	if(self->maptime && time >= self->maptime)
	{
		ent_set_colourmap(self, self->map);
	}

	if(self->sealtime && time >= self->sealtime) //Remove seal, special moves are available again.
	{
		self->seal = 0;
	}
	// Reset their escapecount if they aren't being spammed anymore.
	if(self->modeldata.escapehits && !self->inpain) self->escapecount = 0;

	if(self->nextanim == time ||
		(self->modeldata.type == TYPE_TEXTBOX && self->modeldata.subtype != SUBTYPE_NOSKIP &&
		 (bothnewkeys&(FLAG_JUMP|FLAG_ATTACK|FLAG_ATTACK2|FLAG_ATTACK3|FLAG_ATTACK4|FLAG_SPECIAL))))// Textbox will autoupdate if a valid player presses an action button
	{    // Now you can display text and cycle through with any jump/attack/special unless SUBTYPE_NOSKIP

		f = self->animpos + self->animating;

		//Specified loop break frame.
		if(self->animation->loop.mode && self->animation->loop.frameend)
		{
			if (f == self->animation->loop.frameend)
			{
				if(f<0) f = self->animation->numframes-1;
				else f = 0;

				if (self->animation->loop.framestart)
				{
					f = self->animation->loop.framestart;
				}
			}
			else if((unsigned)f >= (unsigned)self->animation->numframes)
			{
				self->animating = 0;

				if(self->autokill)
				{
					kill(self);
					return;
				}
			}
		}
		else if((unsigned)f >= (unsigned)self->animation->numframes)
		{
			if(f<0) f = self->animation->numframes-1;
			else f = 0;

			if(!self->animation->loop.mode)
			{
				self->animating = 0;

				if(self->autokill)
				{
					kill(self);
					return;
				}
			}
			else
			{
				if (self->animation->loop.framestart)
				{
					f = self->animation->loop.framestart;
				}
			}
		}

		if(self->animating)
		{
			//self->nextanim = time + (self->animation->delay[f]);
			self->update_mark |= 1; // frame updated, mark it
			// just switch frame to f, if frozen, expand_time will deal with it well
			update_frame(self, f);
		}
	}

	if(self->modeldata.subject_to_platform>0)
	{
		other = self->landed_on_platform;
		if(other && testplatform(other, self->x, self->z, NULL) && self->a <= other->a + other->animation->platform[other->animpos][7])
		{
			self->a = self->base = other->a + other->animation->platform[other->animpos][7];
		}
		else other = check_platform_below(self->x, self->z, self->a, self);
	}
	else other = NULL;
	self->landed_on_platform = other;
	// adjust base
	if(self->modeldata.no_adjust_base<=0)
	{
		seta = (float)((self->animation->seta)?(self->animation->seta[self->animpos]):(-1));

		// Checks to see if entity is over a wall and or obstacle, and adjusts the base accordingly
		//wall = checkwall_below(self->x, self->z);
		//find a wall below us
		if(self->modeldata.subject_to_wall>0)
			wall = checkwall_below(self->x, self->z, self->a);
		else wall = -1;

		if(self->modeldata.subject_to_hole>0)
		{
			hole = (wall<0&&!other)?checkhole(self->x, self->z):0;

			if(seta<0 && hole)
			{
				self->base=-1000;
				ent_unlink(self);
			}
			else if(!hole && self->base == -1000)
			{
				 if(self->a>=0) self->base = 0;
				 else
				 {
					 self->xdir = self->zdir = 0; // hit the hole border
				 }
			}
		}

		if(self->base != -1000 || wall>=0)
		{
			if(other != NULL && other != self )
			{
				self->base = (seta + self->altbase >=0 ) * (seta+self->altbase) + (other->a + other->animation->platform[other->animpos][7]);
			}
			else if(wall >= 0)
			{
				//self->modeldata.subject_to_wall &&//we move this up to avoid some checking time
				self->base = (seta + self->altbase >=0 ) * (seta+self->altbase) + (self->a >= level->walls[wall][7]) * level->walls[wall][7];
			}
			else if(seta >= 0) self->base = (seta + self->altbase >=0 ) * (seta+self->altbase);
			else if(self->animation != self->modeldata.animation[ANI_VAULT] && (!self->animation->movea || self->animation->movea[self->animpos] == 0))
			{
				// Don't want to adjust the base if vaulting
				// No obstacle/wall or seta, so just set to 0
				self->base = 0;
			}
		}
	}

	// Code for when entities move (useful for moving platforms, etc)
	if(other && other != self )
	{
		// a bit complex, other->nextanim == time means other is behind self and not been updated,
		// update_mark & 1 means other is updated in this loop and before self
		if((other->nextanim == time || (other->update_mark & 1)) && self->a <= other->a + other->animation->platform[other->animpos][7])
		{
			if(other->update_mark & 1) f = other->animpos;
			else f = other->animpos + other->animating;
			if(f >= other->animation->numframes)
			{
				if(f<0) f = other->animation->numframes-1;
				else f = 0;
			}
			//printf("%d %d %d\n", other->nextanim, time, other->update_mark);
			move = (float)(other->animation->move?other->animation->move[f]:0);
			movez = (float)(other->animation->movez?other->animation->movez[f]:0);
			if(other->direction==0) move = -move;
			if(move||movez)
			{
				if(self->trymove)
				{
					self->trymove(move, movez);
				}
				else
				{
					self->z += movez;
					self->x += move;
				}
			}
		}
	}
}

void check_attack()
{
	// a normal fall
	if(self->falling && !self->projectile)
	{
		self->attack_id = 0;
		return;
	}
	// on ground
	if(self->drop && !self->falling)
	{
		self->attack_id= 0;
		return;
	}

	// Can't hit an opponent if you are frozen
	if(!is_frozen(self) && self->animation->attacks &&
		self->animation->attacks[self->animpos])
	{
		do_attack(self);
		return;
	}
	self->attack_id = 0;
}


void update_health()
{
	//12/30/2008: Guardrate by OX. Guardpoints increase over time.
	if(self->modeldata.guardpoints.maximum > 0 && time >= self->guardtime) // If this is > 0 then guardpoints are set..
	{
		if(self->blocking)
		{
			self->modeldata.guardpoints.current += (self->modeldata.guardrate/2);
			if(self->modeldata.guardpoints.current > self->modeldata.guardpoints.maximum) self->modeldata.guardpoints.current = self->modeldata.guardpoints.maximum;
		}
		else
		{
			self->modeldata.guardpoints.current += self->modeldata.guardrate;
			if(self->modeldata.guardpoints.current > self->modeldata.guardpoints.maximum) self->modeldata.guardpoints.current = self->modeldata.guardpoints.maximum;
		}
		self->guardtime = time + GAME_SPEED;    //Reset guardtime.
	}

	common_dot();   //Damage over time.

	// this is for restoring mp by time by tails
	// Cleaning and addition of mpstable by DC, 08172008.
	// stabletype 4 added by OX 12272008
	if(magic_type == 0 && !self->charging)
	{
		if(time >= self->magictime)
		{

			// 1 Only recover MP > mpstableval.
			// 2 No recover. Drop MP if MP < mpstableval.
			// 3 Both: recover if MP if MP < mpstableval and drop if MP > mpstableval.
			// 0 Default. Recover MP at all times.


			if (self->modeldata.mpstable == 1){
				if (self->mp < self->modeldata.mpstableval) self->mp += self->modeldata.mprate;
			}else if(self->modeldata.mpstable == 2){
				if (self->mp > self->modeldata.mpstableval) self->mp -= self->modeldata.mpdroprate;
			}else if (self->modeldata.mpstable == 3){
				if (self->mp < self->modeldata.mpstableval)
				{

					self->mp += self->modeldata.mprate;
				}
				else if (self->mp > self->modeldata.mpstableval)
				{
					self->mp -= self->modeldata.mpdroprate;
				}
			}

			// OX. Stabletype 4. Gain mp until it reaches max. Then it drops down to mpstableval.
			else if (self->modeldata.mpstable == 4)
			{
				if(self->mp <= self->modeldata.mpstableval) self->modeldata.mpswitch = 0;
				else if(self->mp == self->modeldata.mp) self->modeldata.mpswitch = 1;

				if(self->modeldata.mpswitch == 1)
				{
					self->mp -= self->modeldata.mpdroprate;
				}
				else if(self->modeldata.mpswitch == 0)
				{
					self->mp += self->modeldata.mprate;
				}
			}
			else
			{
				self->mp += self->modeldata.mprate;
			}

			self->magictime = time + GAME_SPEED;    //Reset magictime.
		}
	}
	if(self->charging && time >= self->mpchargetime)
	{
		self->mp += self->modeldata.chargerate;
		self->mpchargetime = time + (GAME_SPEED / 4);
	}
	if(self->mp > self->modeldata.mp) self->mp = self->modeldata.mp; // Don't want to add more than the max

	if(self->oldhealth < self->health) self->oldhealth++;
	else if(self->oldhealth > self->health) self->oldhealth--;

	if(self->oldmp < self->mp) self->oldmp++;
	else if(self->oldmp > self->mp) self->oldmp--;
}

void common_dot()
{
	//common_dot
	//Damon V. Caskey
	//06172009
	//Mitigates damage over time (dot). Moved here from update_health().

	int         iFForce;    //Final force; total damage after defense and offense factors are applied.
	int         iType;      //Attack type.
	int         iIndex;     //Dot index.
	int         iDot;       //Dot mode.
	int         iDot_time;  //Dot expire time.
	int         iDot_cnt;   //Dot next tick time.
	int         iDot_rate;  //Dot tick rate.
	int         iForce;     //Unmodified force.
	float       fOffense;   //Owner's offense.
	float       fDefense;   //Self defense.
	entity*     eOpp;       //Owner of dot effect.
	s_attack    attack;     //Attack struct.

	for(iIndex=0; iIndex<=MAX_DOTS; iIndex++)                                                   //Loop through all DOT indexes.
	{
		iDot_time   =   self->dot_time[iIndex];                                                 //Get expire time.
		iDot_cnt    =   self->dot_cnt[iIndex];                                                  //Get next tick time.
		iDot_rate   =   self->dot_rate[iIndex];                                                 //Get tick rate.

		if(iDot_time)                                                                           //Dot time present?
		{
			if(time > iDot_time)                                                                //Dot effect expired? Then clear variants.
			{
				self->dot[iIndex]       = 0;
				self->dot_atk[iIndex]   = 0;
				self->dot_cnt[iIndex]   = 0;
				self->dot_rate[iIndex]  = 0;
				self->dot_time[iIndex]  = 0;
				self->dot_force[iIndex] = 0;
			}
			else if(time >= iDot_cnt && self->health>=0)                                        //Time for a dot tick and alive?
			{
				self->dot_cnt[iIndex] = time + (iDot_rate * GAME_SPEED / 100);                  //Reset next tick time.

				iDot    =   self->dot[iIndex];                                                  //Get dot mode.
				iForce  =   self->dot_force[iIndex];                                            //Get dot force.

				if(iDot==1 || iDot==3 || iDot==4 || iDot==5)                                    //HP?
				{
					eOpp        = self->dot_owner[iIndex];                                      //Get dot effect owner.
					iType       = self->dot_atk[iIndex];                                        //Get attack type.
					iFForce     = iForce;                                                       //Initialize final force.
					fOffense    = eOpp->offense_factors[iType];                       //Get owner's offense.
					fDefense    = self->defense[iType].factor;                       //Get Self defense.

					if (fOffense){  iFForce = (int)(iForce  * fOffense);    }                   //Apply offense factors.
					if (fDefense){  iFForce = (int)(iFForce * fDefense);    }                   //Apply defense factors.

					if(iFForce >= self->health && (iDot==4 || iDot==5))                         //Total force lethal?
					{
						attack              = emptyattack;                                      //Clear struct.
						attack.attack_type  = iType;                                            //Set type.
						attack.attack_force = iForce;                                           //Set force. Use unmodified force here; takedamage applys damage mitigation.
						attack.dropv[0]     = default_model_dropv[0];                           //Apply drop Y.
						attack.dropv[1]     = default_model_dropv[1];                           //Apply drop X
						attack.dropv[2]     = default_model_dropv[2];                           //Apply drop Z

						if(self->takedamage)                                                    //Defender uses takedamage()?
						{
							self->takedamage(eOpp, &attack);                                    //Apply attack to kill defender.
						}
						else
						{
							kill(self);                                                         //Kill defender instantly.
						}
					}
					else                                                                        //Total force less then health or using non lethal setting.
					{
						if (self->health > iFForce)                                             //Final force less then health?
						{
							self->health -= iFForce;                                            //Reduce health directly. Using takedamage() breaks grabs and spams defender's status in HUD.
						}
						else
						{
							self->health = 1;                                                   //Set minimum health.
						}
						execute_takedamage_script(self, eOpp, iForce, 0, iType, 0, 0, 0, 0);    //Execute the takedamage script.
					}
				}

				if(iDot==2 || iDot==3 || iDot==5)                                               //MP?
				{
					self->mp -= iForce;                                                         //Subtract force from MP.
					if(self->mp<0) self->mp = 0;                                                //Stablize MP at 0.
				}
			}
		}
	}
}

void adjust_bind(entity* e)
{
	if(e->bindanim)
	{
		if(e->animnum!=e->bound->animnum)
		{
			if(!validanim(e,e->bound->animnum))
			{
				if(e->bindanim&4)
				{
				   kill(e);
				}
				e->bound=NULL;
				return;
			}
			ent_set_anim(e, e->bound->animnum, 1);
		}
		if(e->animpos!=e->bound->animpos && e->bindanim&2)
		{
			update_frame(e, e->bound->animpos);
		}
	}
	e->z = e->bound->z +e->bindoffset[1];
	e->a = e->bound->a + e->bindoffset[2];
	switch(e->bindoffset[3])
	{
	case 0:
		if(e->bound->direction) e->x = e->bound->x + e->bindoffset[0];
		else e->x = e->bound->x - e->bindoffset[0];
		break;
	case 1:
		e->direction = e->bound->direction;
		if(e->bound->direction) e->x = e->bound->x + e->bindoffset[0];
		else e->x = e->bound->x - e->bindoffset[0];
		break;
	case -1:
		e->direction = !e->bound->direction;
		if(e->bound->direction) e->x = e->bound->x + e->bindoffset[0];
		else e->x = e->bound->x - e->bindoffset[0];
		break;
	case 2:
		e->direction = 1;
		e->x = e->bound->x + e->bindoffset[0];
		break;
	case -2:
		e->direction = 0;
		e->x = e->bound->x + e->bindoffset[0];
		break;
	default:
		e->x = e->bound->x + e->bindoffset[0];
		break;
	// the default is no change :), just give a value of 12345 or so
	}
}

// arrenge the list reduce its length
void arrange_ents()
{
	int i, ind=-1;
	entity* temp;
	if(ent_count == 0) return;
	if(ent_max == ent_count)
	{
		for(i=0; i<ent_max; i++)
		{
			ent_list[i]->update_mark = 0;
			if(ent_list[i]->exists && ent_list[i]->bound)
			{
				adjust_bind(ent_list[i]);
			}
		}
	}
	else
	{
		for(i=0; i<ent_max; i++)
		{
			if(!ent_list[i]->exists && ind<0)
				ind = i;
			else if(ent_list[i]->exists && ind>=0)
			{
				temp = ent_list[i];
				ent_list[i] = ent_list[ind];
				ent_list[ind] = temp;
				ind++;
			}
			ent_list[i]->update_mark = 0;
			if(ent_list[i]->exists && ent_list[i]->bound)
			{
				adjust_bind(ent_list[i]);
			}
		}
		ent_max = ent_count;
	}
}

// Update all entities that wish to think or animate in this cycle.
// All loops are separated because "self" might die during a pass.
void update_ents()
{
	int i;
	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i]->exists && time != ent_list[i]->timestamp)// dont update fresh entity
		{
			self = ent_list[i];
			self->update_mark = 0;
			if(level) check_lost();// check lost caused by level scrolling or lifespan
			if(!self->exists) continue;
			// expand time incase being frozen
			if(is_frozen(self)){expand_time(self);}
			else
			{
				execute_updateentity_script(self);// execute a script
				if(!self->exists) continue;
				check_ai();// check ai
				if(!self->exists) continue;
				check_gravity();// check gravity
				if(!self->exists) continue;
				update_animation(); // if not frozen, update animation
				if(!self->exists) continue;
				check_attack();// Collission detection
				if(!self->exists) continue;
				update_health();// Update displayed health
			}
		}
	}//end of for
	arrange_ents();
	/*
	if(time>=nextplan){
		plan();
		nextplan = time+GAME_SPEED/2;
	}*/
}


void display_ents()
{
	unsigned f;
	int i, z, wall = 0, wall2;
	entity *e = NULL;
	entity *other = NULL;
	int qx, qy, sy,sz, alty;
	int sortid;
	float temp1, temp2;
	int useshadow = 0;
	int can_mirror = 0;
	int shadowz;
	s_drawmethod* drawmethod = NULL;
	s_drawmethod commonmethod;
	s_drawmethod shadowmethod;
	int use_mirror = (level && level->mirror);

	int scrx = screenx - gfx_x_offset, scry = screeny - gfx_y_offset;

	if(level) shadowz = SHADOW_Z;
	else shadowz = MIN_INT + 100;

	for(i=0; i<ent_max; i++)
	{
		if(ent_list[i] && ent_list[i]->exists)
		{
			e = ent_list[i];
			if(e->modeldata.hpbarstatus.sizex)
			{
				drawenemystatus(e);

			}
			sortid = e->sortid;
			if(freezeall || !(e->blink && (time%(GAME_SPEED/10))<(GAME_SPEED/20)))
			{    // If special is being executed, display all entities regardless
				f = e->animation->sprite[e->animpos];

				other = check_platform(e->x, e->z, e);
				wall = checkwall(e->x, e->z);

				if(f<sprites_loaded)
				{
					// var "z" takes into account whether it has a setlayer set, whether there are other entities on
					// the same "z", in which case there is a layer offset, whether the entity is on an obstacle, and
					// whether the entity is grabbing someone and has grabback set

					z = (int)e->z;    // Set the layer offset

					if(e->bound) sortid = e->bound->sortid-1;

					if(e->grabbing && e->modeldata.grabback)
						sortid = e->link->sortid - 1;    // Grab animation displayed behind
					else if(!e->modeldata.grabback && e->grabbing)
						sortid = e->link->sortid + 1;
/*
					if(e->bound && e->bound->grabbing==e)
					{
						if(e->bound->modeldata.grabback) z--;
						else                             z++;
					}
*/
					if(other && e->a >= other->a + other->animation->platform[other->animpos][7] && !other->modeldata.setlayer)
					{
						if(
							e->link &&
							((e->modeldata.grabback &&
							!e->grabbing) ||
							(e->link->modeldata.grabback &&
							e->link->grabbing) ||
							e->grabbing)
							)
							z = (int)(other->z + 2);    // Make sure entities get displayed in front of obstacle and grabbee

						else z = (int)(other->z + 1);    // Entity should always display in front of the obstacle

					}

					if(e->owner) sortid = e->owner->sortid+1;    // Always in front

					if(e->modeldata.setlayer) z = HOLE_Z + e->modeldata.setlayer;    // Setlayer takes precedence

					if(checkhole(e->x, e->z)==2) z = PANEL_Z-1;        // place behind panels

					drawmethod = e->animation->drawmethods?getDrawMethod(e->animation, e->animpos):NULL;
		    //drawmethod = e->animation->drawmethods?e->animation->drawmethods[e->animpos]:NULL;
					if(e->drawmethod.flag) drawmethod = &(e->drawmethod);
					if(!drawmethod)
						commonmethod = plainmethod;
					else
						commonmethod = *drawmethod;
					drawmethod = &commonmethod;

					if(e->modeldata.alpha >=1 && e->modeldata.alpha <= MAX_BLENDINGS)
					{
						if(drawmethod->alpha<0)
						{
							drawmethod->alpha = e->modeldata.alpha;
						}
					}

					if(!drawmethod->table){

						if(drawmethod->remap>=1 && drawmethod->remap<=e->modeldata.maps_loaded)
						{
							drawmethod->table = model_get_colourmap(&(e->modeldata), drawmethod->remap);
						}

						if(e->colourmap)
						{
							if(drawmethod->remap<0) drawmethod->table = e->colourmap;
						}
						if(!drawmethod->table) drawmethod->table = e->modeldata.palette;
						if(e->modeldata.globalmap)
						{
							if(level&&current_palette)
								drawmethod->table = level->palettes[current_palette-1];
							else drawmethod->table = pal;
						}
					}
					if(e->dying)    // Code for doing dying flash
					{
						if((e->health <= e->per1 && e->health > e->per2 && (time %(GAME_SPEED / 5)) < (GAME_SPEED / 10)) ||
							(e->health <= e->per2 && (time %(GAME_SPEED / 10)) < (GAME_SPEED / 20)))
						{
							if(e->health > 0 )
							{
								drawmethod->table = model_get_colourmap(&(e->modeldata), e->dying);
							}
						}
					}

					if(!e->direction)
					{
						drawmethod->flipx = !drawmethod->flipx;
						if(drawmethod->fliprotate && drawmethod->rotate)
							drawmethod->rotate = 360-drawmethod->rotate;
					}

					if(!use_mirror || z > MIRROR_Z) // don't display if behind the mirror
					{
						spriteq_add_sprite((int)(e->x - scrx), (int)(e->z-e->a - scry), z, f, drawmethod, sortid);
					}

					can_mirror = (use_mirror && self->z>MIRROR_Z);
					if(can_mirror)
					{
						spriteq_add_sprite((int)(e->x-scrx), (int)((2*MIRROR_Z - e->z)-e->a-scry), 2*PANEL_Z - z , f, drawmethod, ent_list_size*100 - sortid);
					}
				}//end of if(f<sprites_loaded)

				if(e->modeldata.gfxshadow==1 && f<sprites_loaded)//gfx shadow
				{
					useshadow = (e->animation->shadow?e->animation->shadow[e->animpos]:1) && shadowcolor && light[1];
					//printf("\n %d, %d, %d\n", shadowcolor, light[0], light[1]);
					if(useshadow && e->a>=0 && (!e->modeldata.aironly || (e->modeldata.aironly && inair(e))))
					{
						wall = checkwall_below(e->x, e->z, e->a);
						if(wall<0)
						{
							alty = (int)e->a;
							temp1 = -1*e->a*light[0]/256; // xshift
							temp2 = (float)(-alty*light[1]/256);                   // zshift
							qx = (int)(e->x - scrx/* + temp1*/);
							qy = (int)(e->z - scry/* +  temp2*/);
						}
						else
						{
							alty = (int)(e->a-level->walls[wall][7]);
							temp1 = -1*(e->a-level->walls[wall][7])*light[0]/256; // xshift
							temp2 = (float)(-alty*light[1]/256);                   // zshift
							qx = (int)(e->x - scrx/* + temp1*/);
							qy = (int)(e->z - scry /*+  temp2*/ - level->walls[wall][7]);
						}

						wall2=checkwall_below(e->x + temp1, e->z + temp2, e->a); // check if the shadow drop into a hole or fall on another wall

						//TODO check platforms, don't want to go through the entity list again right now
						if(!(checkhole(e->x + temp1, e->z + temp2) && wall2<0 && !other) )//&& !(wall>=0 && level->walls[wall][7]>e->a))
						{
							if(wall>=0 && wall2 >= 0)
							{
							   alty += (int)(level->walls[wall][7] - level->walls[wall2][7]);
							   /*qx += -1*(level->walls[wall][7]-level->walls[wall2][7])*light[0]/256;
							   qy += (level->walls[wall][7]-level->walls[wall2][7]) - (level->walls[wall][7]-level->walls[wall2][7])*light[1]/256;*/
							}
							else if(wall>=0)
							{
							   alty += (int)(level->walls[wall][7]);
							   /*qx += -1*level->walls[wall][7]*light[0]/256;
							   qy += level->walls[wall][7] - level->walls[wall][7]*light[1]/256;*/
							}
							else if(wall2>=0)
							{
							   alty -= (int)(level->walls[wall2][7]);
							   /*qx -= -1*level->walls[wall2][7]*light[0]/256;
							   qy -= level->walls[wall2][7] - level->walls[wall2][7]*light[1]/256;*/
							}
							sy = (2*MIRROR_Z - qy) - 2*scry;
							z = shadowz;
							sz = PANEL_Z-HUD_Z;
							if(e->animation->shadow_coords)
							{
								if(e->direction) qx += e->animation->shadow_coords[e->animpos][0];
								else qx -= e->animation->shadow_coords[e->animpos][0];
								qy += e->animation->shadow_coords[e->animpos][1];
								sy -= e->animation->shadow_coords[e->animpos][1];
							}
							shadowmethod = plainmethod;
							shadowmethod.fillcolor = (shadowcolor>0?shadowcolor:0);
							shadowmethod.alpha = shadowalpha;
							shadowmethod.table = drawmethod->table;
							shadowmethod.scalex = drawmethod->scalex;
							shadowmethod.flipx = drawmethod->flipx;
							shadowmethod.scaley = light[1]*drawmethod->scaley/256;
							shadowmethod.flipy = drawmethod->flipy;
							shadowmethod.centery += alty;
							if(shadowmethod.flipy) shadowmethod.centery = -shadowmethod.centery;
							if(shadowmethod.scaley<0)
							{
								shadowmethod.scaley = -shadowmethod.scaley;
								shadowmethod.flipy = !shadowmethod.flipy;
							}
							shadowmethod.rotate = drawmethod->rotate;
							shadowmethod.shiftx = drawmethod->shiftx + light[0];

							spriteq_add_sprite(qx, qy, z, f, &shadowmethod, 0);
							if(use_mirror)
							{
								shadowmethod.flipy = !shadowmethod.flipy;
								shadowmethod.centery = -shadowmethod.centery;
								spriteq_add_sprite(qx, sy, sz, f, &shadowmethod, 0);
							}
						}
					}//end of gfxshadow
				}
				else //plain shadow
				{
					useshadow = e->animation->shadow?e->animation->shadow[e->animpos]:e->modeldata.shadow;
					if(useshadow<0) {useshadow=e->modeldata.shadow;}
					if(useshadow && e->a>=0 && !(checkhole(e->x, e->z) && checkwall_below(e->x, e->z, e->a)<0) && (!e->modeldata.aironly || (e->modeldata.aironly && inair(e))))
					{
						if(other && other != e && e->a >= other->a + other->animation->platform[other->animpos][7])
						{
							qx = (int)(e->x - scrx);
							qy = (int)(e->z - other->a - other->animation->platform[other->animpos][7] - scry);
							sy = (int)((2*MIRROR_Z - e->z) - other->a - other->animation->platform[other->animpos][7] - scry);
							z = (int)(other->z + 1);
							sz = 2*PANEL_Z - z;
						}
						else if(level && wall >= 0)// && e->a >= level->walls[wall][7])
						{
							qx = (int)(e->x - scrx);
							qy = (int)(e->z - level->walls[wall][7] - scry);
							sy = (int)((2*MIRROR_Z - e->z)  - level->walls[wall][7] - scry);
							z = shadowz;
							sz = PANEL_Z-HUD_Z;
						}
						else
						{
							qx = (int)(e->x - scrx);
							qy = (int)(e->z - scry);
							sy = (int)((2*MIRROR_Z - e->z) - scry);
							z = shadowz;
							sz = PANEL_Z-HUD_Z;
						}
						if(e->animation->shadow_coords)
						{   if(e->direction) qx += e->animation->shadow_coords[e->animpos][0];
							else qx -= e->animation->shadow_coords[e->animpos][0];
							qy += e->animation->shadow_coords[e->animpos][1];
							sy -= e->animation->shadow_coords[e->animpos][1];
						}
						shadowmethod=plainmethod;
						shadowmethod.alpha = BLEND_MULTIPLY+1;
						shadowmethod.flipx = !e->direction;
						spriteq_add_sprite(qx, qy, z, shadowsprites[useshadow-1], &shadowmethod, 0);
						if(use_mirror)
						spriteq_add_sprite(qx, sy, sz, shadowsprites[useshadow-1], &shadowmethod, 0);
					}//end of plan shadow
				}
			}// end of blink checking

			if(e->arrowon)    // Display the players image while invincible to indicate player number
			{
				if(e->modeldata.parrow[(int)e->playerindex][0] && e->invincible == 1)
					spriteq_add_sprite((int)(e->x - scrx + e->modeldata.parrow[(int)e->playerindex][1]), (int)(e->z-e->a-scry + e->modeldata.parrow[(int)e->playerindex][2]), (int)e->z, e->modeldata.parrow[(int)e->playerindex][0], NULL, sortid*2);
			}
		}// end of if(ent_list[i]->exists)
	}// end of for
}



void toss(entity *ent, float lift)
{
	if(!lift) return; //zero?
	ent->toss_time = time + 1;
	ent->tossv = lift;
	ent->a += 0.5;        // Get some altitude (needed for checks)
}



entity * findent(int types)
{
	int i;
	for(i=0; i<ent_max; i++)
	{ // 2007-12-18, remove all nodieblink checking, because dead corpse with nodieblink 3 will be changed to TYPE_NONE
	  // so if it is "dead" and TYPE_NONE, it must be a corpse
		if(ent_list[i]->exists && (ent_list[i]->modeldata.type & types) && !(ent_list[i]->dead && ent_list[i]->modeldata.type==TYPE_NONE))
		{
				return ent_list[i];
		}
	}
	return NULL;
}



int count_ents(int types)
{
	int i;
	int count = 0;
	for(i=0; i<ent_max; i++)
	{ // 2007-12-18, remove all nodieblink checking, because dead corpse with nodieblink 3 will be changed to TYPE_NONE
	  // so if it is "dead" and TYPE_NONE, it must be a corpse
		count += (ent_list[i]->exists && (ent_list[i]->modeldata.type & types) && !(ent_list[i]->dead && ent_list[i]->modeldata.type==TYPE_NONE));
	}
	return count;
}

int isItem(entity* e) {
	return e->modeldata.type & TYPE_ITEM;
}

int isSubtypeTouch(entity* e) {
	return e->modeldata.subtype == SUBTYPE_TOUCH;
}

int isSubtypeWeapon(entity* e) {
	return e->modeldata.subtype == SUBTYPE_WEAPON;
}

int isSubtypeProjectile(entity* e) {
	return e->modeldata.subtype == SUBTYPE_PROJECTILE;
}

int canBeDamaged(entity* who, entity* bywhom) {
	return (who->modeldata.candamage & bywhom->modeldata.type) == bywhom->modeldata.type;
}

//check if an item is usable by the entity
int normal_test_item(entity* ent, entity* item){
	return (
		isItem(item) &&
		(item->modeldata.stealth.hide <= ent->modeldata.stealth.detect) &&
		diff(item->x,ent->x) + diff(item->z,ent->z)< videomodes.hRes/2 &&
		item->animation->vulnerable[item->animpos] && !item->blink &&
		(validanim(ent,ANI_GET) || (isSubtypeTouch(item) && canBeDamaged(item, ent))) &&
		(
			(isSubtypeWeapon(item) && !ent->weapent && ent->modeldata.weapon && 
			 ent->modeldata.numweapons>=item->modeldata.weapnum && ent->modeldata.weapon[item->modeldata.weapnum-1]>=0)
			||(isSubtypeProjectile(item) && !ent->weapent)
			||(item->health && (ent->health < ent->modeldata.health) && ! isSubtypeProjectile(item) && ! isSubtypeWeapon(item))
		)
	);
}

int test_item(entity* ent, entity* item){
	if (!(
		isItem(item) &&
		item->animation->vulnerable[item->animpos] && !item->blink &&
		(validanim(ent,ANI_GET) || (isSubtypeTouch(item) && canBeDamaged(item, ent)))
	)) return 0;
	if(isSubtypeProjectile(item) && ent->weapent) return 0;
	if(isSubtypeWeapon(item) && 
		(ent->weapent || !ent->modeldata.weapon || 
		ent->modeldata.numweapons<item->modeldata.weapnum || 
		ent->modeldata.weapon[item->modeldata.weapnum-1]<0)
	) return 0;
	return 1;
}

int player_test_pickable(entity* ent, entity* item){
	if(isSubtypeTouch(item)) return 0;
	if(isSubtypeWeapon(item) && ent->modeldata.animal==2) return 0;
	if(diff(ent->base , item->a)>0.1) return 0;
	return test_item(ent, item);
}

int player_test_touch(entity* ent, entity* item){
	if(!isSubtypeTouch(item)) return 0;
	if(isSubtypeWeapon(item) && ent->modeldata.animal==2) return 0;
	if(diff(ent->base , item->a)>1) return 0;
	return test_item(ent, item);
}

entity * find_ent_here(entity *exclude, float x, float z, int types, int (*test)(entity*,entity*))
{
	int i;
	for(i=0; i<ent_max; i++)
	{
		if( ent_list[i]->exists
			&& ent_list[i] != exclude
			&& (ent_list[i]->modeldata.type & types)
			&& diff(ent_list[i]->x,x)<(self->modeldata.grabdistance*0.83333)
			&& diff(ent_list[i]->z,z)<(self->modeldata.grabdistance/3)
			&& ent_list[i]->animation->vulnerable[ent_list[i]->animpos]
			&& (!test || test(exclude,ent_list[i]))
		)
		{
			return ent_list[i];
		}
	}
	return NULL;
}

int set_idle(entity* ent)
{
	//int ani = ANI_IDLE;
	//if(validanim(ent,ANI_FAINT) && ent->health <= ent->modeldata.health / 4) ani = ANI_FAINT;
	//if(validanim(ent,ani)) ent_set_anim(ent, ani, 0);
	if (common_idle_anim(ent))
	{
	}
	else return 0;
	ent->idling = 1;
	ent->attacking = 0;
	ent->inpain = 0;
	ent->jumping = 0;
	ent->blocking = 0;
	return 1;
}

int set_death(entity *iDie, int type, int reset)
{
	//iDie->xdir = iDie->zdir = iDie->tossv = 0; // stop the target
	if(iDie->blocking && validanim(iDie, ANI_CHIPDEATH)){
		ent_set_anim(iDie,ANI_CHIPDEATH,reset);
		iDie->idling = 0;
		iDie->getting = 0;
		iDie->jumping = 0;
		iDie->charging = 0;
		iDie->attacking = 0;
		iDie->blocking = 0;
		return 1;
	}
	if(type < 0 || type >= max_attack_types || !validanim(iDie,animdies[type])) type = 0;
	if(validanim(iDie,animdies[type])) ent_set_anim(iDie, animdies[type], reset);
	else return 0;

	iDie->idling = 0;
	iDie->getting = 0;
	iDie->jumping = 0;
	iDie->charging = 0;
	iDie->attacking = 0;
	iDie->blocking = 0;
	if(iDie->frozen) unfrozen(iDie);
	return 1;
}


int set_fall(entity *iFall, int type, int reset, entity* other, int force, int drop, int noblock, int guardcost, int jugglecost, int pauseadd)
{
	if(type < 0 || type >= max_attack_types || !validanim(iFall,animfalls[type])) type = 0;
	if(validanim(iFall,animfalls[type])) ent_set_anim(iFall, animfalls[type], reset);
	else return 0;
	iFall->drop = 1;
	iFall->inpain = 0;
	iFall->idling = 0;
	iFall->falling = 1;
	iFall->jumping = 0;
	iFall->getting = 0;
	iFall->charging = 0;
	iFall->attacking = 0;
	iFall->blocking = 0;
	iFall->nograb = 1;
	if(iFall->frozen) unfrozen(iFall);
	execute_onfall_script(iFall, other, force, drop, type, noblock, guardcost, jugglecost, pauseadd);

	return 1;
}

int set_rise(entity *iRise, int type, int reset)
{
	if(type < 0 || type >= max_attack_types || !validanim(iRise,animrises[type])) type = 0;
	if(validanim(iRise,animrises[type])) ent_set_anim(iRise, animrises[type], reset);
	else return 0;
	iRise->takeaction = common_rise;
	// Get up again
	iRise->drop = 0;
	iRise->falling = 0;
	iRise->projectile = 0;
	iRise->nograb = 0;
	iRise->xdir = self->zdir = self->tossv = 0;
	iRise->modeldata.jugglepoints.current = iRise->modeldata.jugglepoints.maximum; //reset jugglepoints
	return 1;
}

int set_riseattack(entity *iRiseattack, int type, int reset)
{
	if(!validanim(iRiseattack,animriseattacks[type]) && iRiseattack->modeldata.riseattacktype == 1) type = 0;
	if(iRiseattack->modeldata.riseattacktype == 0 || type < 0 || type >= max_attack_types) type = 0;
	if(!validanim(iRiseattack,animriseattacks[type])) return 0;

	iRiseattack->takeaction = common_attack_proc;
	self->staydown.riseattack_stall = 0;			//Reset riseattack delay.
	set_attacking(iRiseattack);
	iRiseattack->drop = 0;
	iRiseattack->nograb = 0;
	iRiseattack->modeldata.jugglepoints.current = iRiseattack->modeldata.jugglepoints.maximum; //reset jugglepoints
	ent_set_anim(iRiseattack, animriseattacks[type], 0);
	return 1;
}

int set_blockpain(entity *iBlkpain, int type, int reset)
{
	if(!validanim(iBlkpain,ANI_BLOCKPAIN)){
		iBlkpain->takeaction = common_pain;
		return 1;
	}
	if(type < 0 || type >= max_attack_types || !validanim(iBlkpain,animblkpains[type])) type = 0;
	if(!validanim(iBlkpain,animblkpains[type])) return 0;
	iBlkpain->takeaction = common_block;
	set_attacking(iBlkpain);
	ent_set_anim(iBlkpain, animblkpains[type], reset);
	return 1;
}

int set_pain(entity *iPain, int type, int reset)
{
	int pain = 0;

	iPain->xdir = iPain->zdir = iPain->tossv = 0; // stop the target
	if(iPain->modeldata.guardpoints.maximum > 0 && iPain->modeldata.guardpoints.current <= 0) pain = ANI_GUARDBREAK;
	else if(type == -1 || type >= max_attack_types) pain = ANI_GRABBED;
	else pain = animpains[type];
	if(validanim(iPain,pain))              ent_set_anim(iPain, pain, reset);
	else if(validanim(iPain,animpains[0])) ent_set_anim(iPain, animpains[0], reset);
	else if(validanim(iPain,ANI_IDLE))     ent_set_anim(iPain, ANI_IDLE, reset);
	else return 0;

	if(pain == ANI_GRABBED) iPain->inpain = 0;
	else iPain->inpain = 1;

	iPain->idling = 0;
	iPain->falling = 0;
	iPain->projectile = 0;
	iPain->drop = 0;
	iPain->attacking = 0;
	iPain->getting = 0;
	iPain->charging = 0;
	iPain->jumping = 0;
	iPain->blocking = 0;
	if(iPain->modeldata.guardpoints.maximum > 0 && iPain->modeldata.guardpoints.current <= 0) iPain->modeldata.guardpoints.current = iPain->modeldata.guardpoints.maximum;
	if(iPain->frozen) unfrozen(iPain);

	execute_onpain_script(iPain, type, reset);
	return 1;
}


//change model, anim_flag 1: reset animation 0: use original animation
void set_model_ex(entity* ent, char* modelname, int index, s_model* newmodel, int anim_flag)
{
	s_model* model = NULL;
	int   i;
	int   type = ent->modeldata.type;

	model = ent->model;
	if(!newmodel)
	{
		if(index>=0) newmodel = model_cache[index].model;
		else newmodel = findmodel(modelname);
	}
	if(!newmodel) shutdown(1, "Can't set model for entity '%s', model not found.\n", ent->name);
	if(newmodel==model) return;

	if(!(newmodel->model_flag & MODEL_NO_COPY))
	{
		if(!newmodel->speed) newmodel->speed = model->speed;
		if(!newmodel->runspeed)
		{
			newmodel->runspeed = model->runspeed;
			newmodel->runjumpheight = model->runjumpheight;
			newmodel->runjumpdist = model->runjumpdist;
			newmodel->runupdown = model->runupdown;
			newmodel->runhold = model->runhold;
		}
		if(newmodel->icon.def           <   0)  newmodel->icon.def          = model->icon.def;
		if(newmodel->icon.pain       <   0)  newmodel->icon.pain      = model->icon.pain;
		if(newmodel->icon.get        <   0)  newmodel->icon.get       = model->icon.get;
		if(newmodel->icon.die        <   0)  newmodel->icon.die       = model->icon.die;
		if(newmodel->shadow         <   0)  newmodel->shadow        = model->shadow;
		if(newmodel->knife          <   0)  newmodel->knife         = model->knife;
		if(newmodel->pshotno        <   0)  newmodel->pshotno       = model->pshotno;
		if(newmodel->bomb           <   0)  newmodel->bomb          = model->bomb;
		if(newmodel->star           <   0)  newmodel->star          = model->star;
		if(newmodel->flash          <   0)  newmodel->flash         = model->flash;
		if(newmodel->bflash         <   0)  newmodel->bflash        = model->bflash;
		if(newmodel->dust[0]        <   0)  newmodel->dust[0]       = model->dust[0];
		if(newmodel->dust[1]        <   0)  newmodel->dust[1]       = model->dust[1];
		if(newmodel->diesound       <   0)  newmodel->diesound      = model->diesound;

		for(i=0; i<max_animations; i++)
		{
			if(!newmodel->animation[i] && model->animation[i] && model->animation[i]->numframes>0)
				newmodel->animation[i] = model->animation[i];
		}
		// copy the weapon list if model flag is not set to use its own weapon list
		if(!(newmodel->model_flag & MODEL_NO_WEAPON_COPY))
		{
			newmodel->weapnum = model->weapnum;
			if(!newmodel->weapon) {
				newmodel->weapon = model->weapon;
				newmodel->numweapons = model->numweapons;
			}
		}
	}

	ent_set_model(ent, newmodel->name, anim_flag);

	ent->modeldata.type = type;

	if((newmodel->model_flag & MODEL_NO_SCRIPT_COPY))
		clear_all_scripts(ent->scripts, 0);

	copy_all_scripts(newmodel->scripts, ent->scripts, 0);
	memcpy(ent->defense, ent->modeldata.defense, sizeof(s_defense)*max_attack_types);
	memcpy(ent->offense_factors, ent->modeldata.offense_factors, sizeof(float)*max_attack_types);

	ent_set_colourmap(ent, ent->map);
}

void set_weapon(entity* ent, int wpnum, int anim_flag) // anim_flag added for scripted midair weapon changing
{
	if(!ent) return;
//printf("setweapon: %d \n", wpnum);

	if(ent->modeldata.weapon && wpnum > 0 && wpnum <= ent->modeldata.numweapons && ent->modeldata.weapon[wpnum-1])
		set_model_ex(ent, NULL, ent->modeldata.weapon[wpnum-1], NULL, !anim_flag);
	else set_model_ex(ent, NULL, -1, ent->defaultmodel, 1);

	if(ent->modeldata.type == TYPE_PLAYER) // save current weapon for player's weaploss 3
	{
		if(ent->modeldata.weaploss[0] >= 3) player[(int)ent->playerindex].weapnum = wpnum;
		else player[(int)ent->playerindex].weapnum = level->setweap;
	}
}

//////////////////////////////////////////////////////////////////////////
//                  common A.I. code for enemies & NPCs
//////////////////////////////////////////////////////////////////////////


entity* melee_find_target()
{
	return NULL;
}

entity* long_find_target()
{
	return NULL;
}

entity* block_find_target(int anim, int iDetect){
	int i , min, max;
	int index = -1;
	min = 0;
	max = 9999;
	float diffx, diffz, diffd, diffo = 0;

    iDetect += self->modeldata.stealth.detect;

	//find the 'nearest' attacking one
	for(i=0; i<ent_max; i++)
	{
		if( ent_list[i]->exists && ent_list[i] != self //cant target self
			&& (ent_list[i]->modeldata.candamage & self->modeldata.type)
			&& (anim<0||(anim>=0 && check_range(self, ent_list[i], anim)))
			&& !ent_list[i]->dead &&  ent_list[i]->attacking//must be alive
			&& ent_list[i]->animation->attacks && (!ent_list[i]->animation->attacks[ent_list[i]->animpos]
			|| ent_list[i]->animation->attacks[ent_list[i]->animpos]->no_block==0)
			&& (diffd=(diffx=diff(ent_list[i]->x,self->x))+ (diffz=diff(ent_list[i]->z,self->z))) >= min
			&& diffd <= max
			&& (ent_list[i]->modeldata.stealth.hide <= iDetect) //Stealth factor less then perception factor (allows invisibility).
			  )
		{
					
			if(index <0 || diffd < diffo)
			{
				index = i;
				diffo = diffd;
			}
		}
	}
	if( index >=0) {return ent_list[index];}
	return NULL;
}

entity* normal_find_target(int anim, int iDetect)
{

    /*
    normal_find_target
    Author unknown
    Date unknown
    ~Damon Caskey, 2011_07_22: Add support for detect adjustment.

    int anim:       Animation find range will be calculated by. Default to current animation if not passed.
    int iDetect:    Local detection adjustment. Allows lesser or greater penetration of target's stealth for location.
    */

	int i , min, max;
	int index = -1;
	min = 0;
	max = 9999;
	float diffx, diffz, diffd, diffo = 0;

    iDetect += self->modeldata.stealth.detect;

	//find the 'nearest' one
	for(i=0; i<ent_max; i++)
	{
		if( ent_list[i]->exists && ent_list[i] != self //cant target self
			&& (ent_list[i]->modeldata.type & self->modeldata.hostile)
			&& (anim<0||(anim>=0 && check_range(self, ent_list[i], anim)))
			&& !ent_list[i]->dead //must be alive
			&& (diffd=(diffx=diff(ent_list[i]->x,self->x))+ (diffz=diff(ent_list[i]->z,self->z))) >= min
			&& diffd <= max
			&& (ent_list[i]->modeldata.stealth.hide <= iDetect) //Stealth factor less then perception factor (allows invisibility).
			  )
		{
					
			if(index <0 || (index>=0 && (!ent_list[index]->animation->vulnerable[ent_list[index]->animpos] || ent_list[index]->invincible == 1)) ||
				( 
					(self->x < ent_list[i]->x) == (self->direction) && // don't turn to the one on the back
					//ent_list[i]->x >= advancex-10 && ent_list[i]->x<advancex+videomodes.hRes+10 && // don't turn to an offscreen target
					//ent_list[i]->z >= advancey-10 && ent_list[i]->z<advancey+videomodes.vRes+10 &&
					diffd < diffo
				)
			)
			{
				index = i;
				diffo = diffd;
			}
		}
	}
	if( index >=0) {return ent_list[index];}
	return NULL;
}

//Used by default A.I. pattern
// A.I. characters try to find a pickable item
entity * normal_find_item(){

	int i;
	int index = -1;
	entity* ce = NULL;
	//find the 'nearest' one
	for(i=0; i<ent_max; i++){
		ce = ent_list[i];

		if( ce->exists && normal_test_item(self, ce) ){
			if(index <0 || diff(ce->x, self->x) + diff(ce->z, self->z) < diff(ent_list[index]->x, self->x) + diff(ent_list[index]->z, self->z))
				index = i;
		}
	}
	if( index >=0) return ent_list[index];
	return NULL;
}

int long_attack()
{
	return 0;
}

int melee_attack()
{
	return 0;
}

// chose next attack in atchain, if succeeded, return 1, otherwise return 0.
int perform_atchain()
{
	int pickanim = 0;
	if(self->combotime > time)
		self->combostep[0]++;
	else self->combostep[0] = 1;

	if(self->modeldata.atchain[self->combostep[0]-1]==0) // 0 means the chain ends
	{
		self->combostep[0] = 0;
		return 0;
	}

	if(validanim(self,animattacks[self->modeldata.atchain[self->combostep[0]-1]-1]) )
	{
		if(((self->combostep[0]==1||!(self->modeldata.combostyle&1)) && self->modeldata.type==TYPE_PLAYER) ||  // player should use attack 1st step without checking range
		   (!(self->modeldata.combostyle&1) && normal_find_target(animattacks[self->modeldata.atchain[0]-1],0)) || // normal chain just checks the first attack in chain(guess no one like it)
		   ((self->modeldata.combostyle&1) && normal_find_target(animattacks[self->modeldata.atchain[self->combostep[0]-1]-1],0))) // combostyle 1 checks all anyway
		{
			pickanim = 1;
		}
		else if((self->modeldata.combostyle&1) && self->combostep[0]!=1) // ranged combo? search for a valid attack
		{
			while(++self->combostep[0]<=self->modeldata.chainlength)
			{
				if(self->modeldata.atchain[self->combostep[0]-1] &&
				   validanim(self,animattacks[self->modeldata.atchain[self->combostep[0]-1]-1]) &&
				   (self->combostep[0]==self->modeldata.chainlength ||
					normal_find_target(animattacks[self->modeldata.atchain[self->combostep[0]-1]-1],0)))
				{
					pickanim = 1;
					break;
				}
			}
		}
	}
	else self->combostep[0] = 0;
	if(pickanim)
	{
		self->takeaction = common_attack_proc;
		set_attacking(self);
		ent_set_anim(self, animattacks[self->modeldata.atchain[self->combostep[0]-1]-1], 1);
	}
	if(!pickanim || self->combostep[0] > self->modeldata.chainlength) self->combostep[0] = 0;
	if((self->modeldata.combostyle&2)) self->combotime = time + combodelay;
	return pickanim;
}

void normal_prepare()
{
	int i, j;
	int found = 0, special = 0;
	int predir = self->direction;

	entity* target = normal_find_target(-1,0);

	self->xdir = self->zdir = 0; //stop

	if(!target)
	{
		self->idling = 1;
		self->takeaction = NULL;
		return;
	}

	//check if target is behind, so we can perform a turn back animation
	if(!self->modeldata.noflip) self->direction = (self->x < target->x);
	if(predir != self->direction && validanim(self,ANI_TURN))

	{
		self->takeaction = common_turn;
		self->direction = predir;
		set_turning(self);
		ent_set_anim(self, ANI_TURN, 0);
		return;
	}

	// Wait...
	if(time < self->stalltime) return;


	// let go the projectile, well
	if( self->weapent && self->weapent->modeldata.subtype == SUBTYPE_PROJECTILE &&
		validanim(self,ANI_THROWATTACK) &&
		check_range(self, target, ANI_THROWATTACK))
	{
		self->takeaction = common_attack_proc;
		set_attacking(self);
		ent_set_anim(self, ANI_THROWATTACK, 0);
		return ;
	}

	// move freespecial check here

	for(i=0; i<max_freespecials; i++) {
		if(validanim(self,animspecials[i]) &&
		   (check_energy(1, animspecials[i]) ||
			check_energy(0, animspecials[i])) &&
			check_range(self, target, animspecials[i]))
		{
			atkchoices[found++] = animspecials[i];
		}
	}
	if((rand32()&7) < 2)
	{
		if(found && check_costmove(atkchoices[(rand32()&0xffff)%found], 1, 0) ){
			return;
		}
	}
	special = found;

	if(self->modeldata.chainlength > 1) // have a chain?
	{
		if(perform_atchain()) return;
	}
	else // dont have a chain so just select an attack randomly
	{
		// Pick an attack
		for(i=0; i<max_attacks; i++)
		{
			if( validanim(self,animattacks[i]) &&
				check_range(self, target, animattacks[i]))
			{
				// a trick to make attack 1 has a greater chance to be chosen
				// 6 5 4 3 2 1 1 1 1 1 ....
				for(j=((5-i)>=0?(5-i):0); j>=0; j--) atkchoices[found++] = animattacks[i];
			}
		}
		if(found>special){
			self->takeaction = common_attack_proc;
			set_attacking(self);
			ent_set_anim(self, atkchoices[special + (rand32()&0xffff)%(found-special)], 0);
			return ;
		}
	}
	
	// if no attack was picked, just choose a random one from the valid list
	if(special && check_costmove(atkchoices[(rand32()&0xffff)%special], 1, 0)){
		return;
	}

	// No attack to perform, return to A.I. root
	self->idling = 1;
	self->takeaction = NULL;
}

void common_jumpland()
{
	if(self->animating) return;
	self->takeaction = NULL;
	set_idle(self);
}

//A.I characters play the jump animation
void common_jump()
{
	entity* dust;

	if(inair(self))
	{
		return;
	}

	if(self->tossv<=0) // wait if it is still go up
	{
		self->tossv = 0;
		self->a = self->base;

		self->jumping = 0;
		self->attacking = 0;

		if(!self->modeldata.runhold) self->running = 0;

		self->zdir = self->xdir = 0;

		if(validanim(self,ANI_JUMPLAND) && self->animation->landframe.frame == -1) // check if jumpland animation exists and not using landframe
		{
			self->takeaction = common_jumpland;
			ent_set_anim(self, ANI_JUMPLAND, 0);
			if(self->modeldata.dust[1]>=0)
			{
				dust = spawn(self->x, self->z, self->a, self->direction, NULL, self->modeldata.dust[1], NULL);
				if(dust){
					dust->base = self->a;
					dust->autokill = 2;
					execute_onspawn_script(dust);
				}
			}
		}
		else
		{
			if(self->modeldata.dust[1]>=0 && self->animation->landframe.frame == -1)
			{
				dust = spawn(self->x, self->z, self->a, self->direction, NULL, self->modeldata.dust[1], NULL);
				if(dust){
					dust->base = self->a;
					dust->autokill = 2;
					execute_onspawn_script(dust);
				}
			}
			if(self->animation->landframe.frame >= 0 && self->animating) return;

			self->takeaction = NULL; // back to A.I. root
			set_idle(self);
		}
	}
}

//A.I. characters spawn
void common_spawn()
{
	self->idling = 0;
	if(self->animating) return;
	self->takeaction = NULL; // come to life
	set_idle(self);
}

//A.I. characters drop from the sky
void common_drop()
{
	if(inair(self)) return;
	self->idling = 1;
	self->takeaction = NULL;
	if(self->health<=0) kill(self);
}

//Similar as above, walk off a wall/cliff
void common_walkoff()
{
	if(inair(self) || self->animating) return;
	self->takeaction = NULL;
	set_idle(self);
}

// play turn animation and then flip
void common_turn()
{
	if(!self->animating)
	{
		self->takeaction = NULL;
		self->xdir = self->zdir = 0;
		self->direction = !self->direction;
		set_idle(self);
	}
}

// switch to land animation, land safely
void doland()
{
	self->xdir = self->zdir = 0;
	self->drop = 0;
	self->projectile = 0;
	self->damage_on_landing = 0;
	if(validanim(self,ANI_LAND))
	{
		self->takeaction = common_land;
		self->direction = !self->direction;
		ent_set_anim(self, ANI_LAND, 0);
	}
	else
	{
		self->takeaction = NULL;
		set_idle(self);
	}
}

void common_fall()
{
	// Still falling?
	if(self->falling ||  inair(self) || self->tossv)
	{
		return;
	}


	//self->xdir = self->zdir;

	// Landed
	if(self->projectile > 0)
	{
		if(self->projectile == 2)
		{   // damage_on_landing==-2 means a player has pressed up+jump and has a land animation
			if((autoland == 1 && self->damage_on_landing == -1) ||self->damage_on_landing == -2)
			{
				// Added autoland option for landing
				doland();
				return;
			}
		}
		//self->projectile = 0;
		self->falling = 0;
	}

	// Drop Weapon due to Enemy Falling.
	//if(self->modeldata.weaploss[0] == 1) dropweapon(1);

	if(self->boss && level_completed) tospeedup = 1;

	// Pause a bit...
	self->takeaction	= common_lie;
	self->stalltime		= time + MAX(0, (int)(self->staydown.rise + GAME_SPEED - self->modeldata.risetime[0]));	//Set rise delay.
	self->staydown.riseattack_stall	= time + MAX(0, (int)(self->staydown.riseattack - self->modeldata.risetime[1]));					//Set rise attack delay.
	self->staydown.rise = 0; //Reset staydown.
	self->staydown.riseattack = 0; //Reset staydown atk.
}

void common_try_riseattack()
{
	entity * target;
	if(!validanim(self,ANI_RISEATTACK)) return;

	target = normal_find_target(ANI_RISEATTACK,0);
	if(!target)
	{
		self->direction = !self->direction;
		target = normal_find_target(ANI_RISEATTACK,0);
		self->direction = !self->direction;
	}

	if(target)
	{
		self->direction = (target->x > self->x);    // Stands up and swings in the right direction depending on chosen target
		set_riseattack(self, self->damagetype, 0);
	}
}

void common_lie()
{
	// Died?
	if(self->health <= 0)
	{
		if(self->modeldata.falldie == 2) set_death(self, self->damagetype, 0);
		if(!self->modeldata.nodieblink || (self->modeldata.nodieblink == 1 && !self->animating))
		{    // Now have the option to blink or not
			self->takeaction = (self->modeldata.type == TYPE_PLAYER)?player_blink:suicide;
			self->blink = 1;
			self->stalltime  = time + GAME_SPEED * 2;
		}
		else if(self->modeldata.nodieblink == 2  && !self->animating)
		{
			self->takeaction = (self->modeldata.type == TYPE_PLAYER)?player_die:suicide;

		}
		else if(self->modeldata.nodieblink == 3  && !self->animating)
		{
			if(self->modeldata.type == TYPE_PLAYER)
			{
				self->takeaction = player_die;

			}
			else
			{
				self->modeldata.type = TYPE_NONE;
				self->noaicontrol = 1;
			}
		}

		if (self->modeldata.maps.ko)   //Have a KO map?
		{
			if (!self->modeldata.maps.kotype || !self->animating)  //Wait for fall/death animation to finish?
				self->colourmap = model_get_colourmap(&(self->modeldata), self->modeldata.maps.ko);       //Apply map.
		}

		return;
	}

	if(time < self->stalltime || self->a!=self->base || self->tossv) return;

	//self->takeaction = common_rise;
	// Get up again
	//self->drop = 0;
	//self->falling = 0;
	//self->projectile = 0;
	//self->xdir = self->zdir = self->tossv = 0;

	set_rise(self, self->damagetype, 0);
}

// rise proc
void common_rise()
{
	if(self->animating) return;
	self->takeaction = NULL;
	self->staydown.riseattack_stall = 0;	//Reset riseattack delay.
	if(self->modeldata.riseinv)
	{
		self->blink = self->modeldata.riseinv>0;
		self->invinctime = time + ABS(self->modeldata.riseinv);
		self->invincible = 1;
	}
	set_idle(self);
}

// pain proc
void common_pain()
{
	//self->xdir = self->zdir = 0; // complained

	if(self->animating || inair(self)) return;

	self->inpain = 0;
	if(self->link){
//        set_pain(self, -1, 0);
		self->takeaction = common_grabbed;
	}
	else if(self->blocking)
	{
		self->takeaction = common_block;
		ent_set_anim(self, ANI_BLOCK, 1);
	}
	else
	{
		self->takeaction = NULL;
		set_idle(self);
	}
}

void doprethrow()
{
	entity * other = self->link;
	other->takeaction = common_prethrow;
	self->takeaction = common_throw_wait;
	self->xdir = self->zdir = self->tossv = other->xdir = other->zdir = other->tossv = 0;
	ent_set_anim(self, ANI_THROW, 0);
}

// 1 grabattack 2 grabforward 3 grabup 4 grabdown 5 grabbackward
// other means grab finisher at once
void dograbattack(int which)
{
	entity * other = self->link;
	self->takeaction = common_grabattack;
	self->attacking = 1;
	other->xdir = other->zdir = self->xdir = self->zdir = 0;
	if(which<5 && which>=0)
	{
		++self->combostep[which];
		if(self->combostep[which] < 3)
			ent_set_anim(self, grab_attacks[which][0], 0);
		else
		{
			memset(self->combostep, 0, sizeof(int)*5);
			if(validanim(self,grab_attacks[which][1])) ent_set_anim(self, grab_attacks[which][1], 0);
			else ent_set_anim(self, ANI_ATTACK3, 0);
		}
	}
	else
	{
		memset(self->combostep, 0, sizeof(int)*5);
		if(validanim(self,grab_attacks[0][1])) ent_set_anim(self, grab_attacks[0][1], 0);
		else if(validanim(self,ANI_ATTACK3)) ent_set_anim(self, ANI_ATTACK3, 0);
	}
}

void dovault()
{
	int heightvar;
	entity * other = self->link;
	self->takeaction = common_vault;
	self->link->xdir = self->link->zdir = self->xdir = self->zdir = 0;

	self->attacking = 1;
	self->x = other->x;

	if(other->animation->height) heightvar = other->animation->height;
	else heightvar = other->modeldata.height;

	self->base = other->base + heightvar;
	ent_set_anim(self, ANI_VAULT, 0);
}

void common_grab_check()
{
	int rnum, which;
	entity * other = self->link;

	if(other == NULL || (self->modeldata.grabfinish && self->animating && !self->grabwalking)) return;

	if(self->base != other->base)
	{       // Change this from ->a to ->base
		self->takeaction = NULL;
		ent_unlink(self);
		set_idle(self);
		return;
	}

	if(!nolost && self->modeldata.weaploss[0] <= 0) dropweapon(1);

	self->attacking = 0; //for checking

	rnum = rand32()&31;

	if(time > self->releasetime)
	{
		if(rnum < 12)
		{
			// Release
			self->takeaction = NULL;
			ent_unlink(self);
			set_idle(self);
			return;
		}
		else self->releasetime = time + (GAME_SPEED/2);
	}

	if(validanim(self,ANI_THROW) && rnum < 7)
	{
		if(self->modeldata.throwframewait >= 0)
			doprethrow();
		else
			dothrow();
		return;
	}
	//grab finisher
	if(rnum < 4)
	{
		 dograbattack(-1);
		 return;
	}
	which = rnum%5;
	// grab attacks
	if(rnum > 12 && validanim(self,grab_attacks[which][0]))
	{
		dograbattack(which);
		return;
	}
	// Vaulting.
	if(rnum < 8 && validanim(self,ANI_VAULT))
	{
		dovault();
		return;
	}
}

//grabbing someone
void common_grab()
{
	// if(self->link) return;
	if(self->link || (self->modeldata.grabfinish && self->animating && !self->grabwalking)) return;

	self->takeaction = NULL;
	self->attacking = 0;
	memset(self->combostep, 0, sizeof(int)*5);
	set_idle(self);
}

// being grabbed
void common_grabbed()
{
	// Just check if we're still grabbed...
	if(self->link) return;

	self->stalltime=0;
	self->takeaction = NULL;
	set_idle(self);
}

// picking up something
void common_get()
{
	if(self->animating) return;

	self->getting = 0;
	self->takeaction = NULL;
	set_idle(self);
}

// A.I. characters do the block
void common_block()
{
	if(self->animating) return;

	self->blocking = 0;
	self->takeaction = NULL;
	set_idle(self);
}


void common_charge()
{
	if(self->animating) return;

	self->charging = 0;
	self->takeaction = NULL;
	set_idle(self);
}


// common code for entities hold an item
entity* drop_item(entity* e)
{
	s_spawn_entry p;
	entity* item;
	memset(&p, 0, sizeof(s_spawn_entry));

	p.index = e->item;
	p.itemindex = p.weaponindex = -1;
	strcpy(p.alias, e->itemalias);
	p.a = e->a+0.01; // for check, or an enemy "item" will drop from the sky
	p.health[0] = e->itemhealth;
	p.alpha = e->itemtrans;
	p.colourmap = e->itemmap;
	p.flip = e->direction;

	item = smartspawn(&p);

	if(item)
	{
		item->x = e->x;
		item->z = e->z;
		if(item->x < advancex) item->x = advancex + 10;
		else if(item->x > advancex + videomodes.hRes) item->x = advancex + videomodes.hRes - 10;
		if(!(level->scrolldir &(SCROLL_UP|SCROLL_DOWN)))
		{
			if(item->z-item->a < advancey) item->z = advancey + 10;
			else if(item->z-item->a > advancey + videomodes.vRes) item->z = advancey + videomodes.vRes - 10;
		}
		if(e->boss && item->modeldata.type==TYPE_ENEMY) item->boss = 1;
	}
	return item;
}

//drop the driver, just spawn, dont takedamage
// damage will adjust by the biker
entity* drop_driver(entity* e)
{
	int i;
	s_spawn_entry p;
	entity* driver;
	memset(&p, 0, sizeof(s_spawn_entry));

	if(e->modeldata.rider>=0) p.index = e->modeldata.rider;
	else         return NULL; // should not happen, just in case
	/*p.x = e->x - advancex; p.z = e->z; */p.a = e->a + 10;
	p.itemindex = e->item;
	p.weaponindex = -1;
	strcpy(p.itemalias, e->itemalias);
	strcpy(p.alias, e->name);
	p.itemmap = e->itemmap;
	p.itemtrans = e->itemtrans;
	p.itemhealth = e->itemhealth;
	p.itemplayer_count = e->itemplayer_count;
	//p.colourmap = e->map;
	for(i=0; i<MAX_PLAYERS; i++) p.health[i] = e->modeldata.health;
	p.boss = e->boss;

	driver = smartspawn(&p);
	if(driver)
	{
		driver->x = e->x;
		driver->z = e->z;
	}
	return driver;
}


void checkdeath()
{
	if(self->health>0) return;
	self->dead = 1;
	//be careful, since the opponent can be other types
	if(self->opponent && self->opponent->modeldata.type == TYPE_PLAYER)
	{
		addscore(self->opponent->playerindex, self->modeldata.score);    // Add score to the player
	}
	self->nograb = 1;
	self->idling = 0;

	if(self->modeldata.diesound >= 0) sound_play_sample(self->modeldata.diesound, 0, savedata.effectvol,savedata.effectvol, 100);

	// drop item
	if(self->item && count_ents(TYPE_PLAYER) > self->itemplayer_count)
    {
		drop_item(self);
	}

	if(self->boss){
		self->boss = 0;
		--level->bosses;
		if(!level->bosses && self->modeldata.type == TYPE_ENEMY){
			kill_all_enemies();
			level_completed = 1;
		}
	}
}

void checkdamageflip(entity* other, s_attack* attack)
{
	if(other == NULL || other==self || (!self->drop && (attack->no_pain || self->modeldata.nopain || (self->defense[(short)attack->attack_type].pain && attack->attack_force < self->defense[(short)attack->attack_type].pain)))) return;

	if(!self->frozen && !self->modeldata.noflip)// && !inair(self))
	{
		if(attack->force_direction == 0)
		{
			if(self->x < other->x) self->direction = 1;
			else if(self->x > other->x) self->direction = 0;
		}
		else if(attack->force_direction == 1)
		{
			self->direction = other->direction;
		}
		else if(attack->force_direction == -1)
		{
			self->direction = !other->direction;
		}
		else if(attack->force_direction == 2)
		{
			self->direction = 1;
		}
		else if(attack->force_direction == -2)
		{
			self->direction = 0;
		}
	}
}

void checkdamageeffects(s_attack* attack)
{
#define _freeze         attack->freeze
#define _maptime        attack->maptime
#define _freezetime     attack->freezetime
#define _remap          attack->forcemap
#define _blast          attack->blast
#define _steal          attack->steal
#define _seal           attack->seal
#define _sealtime       attack->sealtime
#define _dot            attack->dot
#define _dot_index      attack->dot_index
#define _dot_time       attack->dot_time
#define _dot_force      attack->dot_force
#define _dot_rate       attack->dot_rate
#define _staydown0      attack->staydown[0]
#define _staydown1		attack->staydown[1]

	entity* opp = self->opponent;

	if(_steal && opp && opp!=self)
	{
		if(self->health >= attack->attack_force) opp->health += attack->attack_force;
		else opp->health += self->health;
		if(opp->health > opp->modeldata.health)
			opp->health = opp->modeldata.health;
	}
	if(_freeze && !self->frozen && !self->owner && !self->modeldata.nomove)
	{    // New freeze attack - If not frozen, freeze entity unless it's a projectile
		self->frozen = 1;
		if(self->freezetime == 0) self->freezetime = time + _freezetime;
		if(_remap == -1 && self->modeldata.maps.frozen != -1) self->colourmap = model_get_colourmap(&(self->modeldata),self->modeldata.maps.frozen);    //12/14/2007 Damon Caskey: If opponents frozen map = -1 or only stun, then don't change the color map.
		self->drop = 0;
	}
	else if(self->frozen)
	{
		unfrozen(self);
		self->drop = 1;
	}

	if(_remap>0 && !_freeze)
	{
		self->maptime = time + _maptime;
		self->colourmap = model_get_colourmap(&(self->modeldata), _remap);
	}

	if(_seal)                                                                       //Sealed: Disable special moves.
	{
		self->sealtime  = time + _sealtime;                                         //Set time to apply seal. No specials for you!
		self->seal      = _seal;                                                    //Set seal. Any animation with energycost > seal is disabled.
	}

	if(_dot)                                                                        //dot: Damage over time effect.
	{
		self->dot_owner[_dot_index] = self->opponent;                               //dot owner.
		self->dot[_dot_index]       = _dot;                                         //Mode: 1. HP (non lethal), 2. MP, 3. HP (non lethal) & MP, 4. HP, 5. HP & MP.
		self->dot_time[_dot_index]  = time + (_dot_time * GAME_SPEED / 100);        //Gametime dot will expire.
		self->dot_force[_dot_index] = _dot_force;                                   //How much to dot each tick.
		self->dot_rate[_dot_index]  = _dot_rate;                                    //Delay between dot ticks.
		self->dot_atk[_dot_index]   = attack->attack_type;                          //dot attack type.
	}


	if(self->modeldata.nodrop) self->drop = 0;                                      // Static enemies/nodrop enemies cannot be knocked down

	if(inair(self) && !self->frozen && self->modeldata.nodrop<2) self->drop = 1;

	if(attack->no_pain) self->drop = 0;

	self->projectile = _blast;

	if(self->drop)
	{
		self->staydown.rise	= _staydown0;                                            //Staydown: Add to risetime until next rise.
		self->staydown.riseattack   = _staydown1;
	}

#undef _freeze
#undef _maptime
#undef _freezetime
#undef _remap
#undef _blast
#undef _steal
#undef _seal
#undef _sealtime
#undef _dot
#undef _dot_index
#undef _dot_time
#undef _dot_force
#undef _dot_rate
#undef _staydown0
#undef _staydown1
}

void checkdamagedrop(s_attack* attack)
{
	int attackdrop = attack->attack_drop;
	float fdefense_knockdown = self->defense[(short)attack->attack_type].knockdown;
	if(self->modeldata.animal) self->drop = 1;
	if(self->modeldata.guardpoints.maximum > 0 && self->modeldata.guardpoints.current <= 0) attackdrop = 0; //guardbreak does not knock down.
	if(self->drop || attack->no_pain) return; // just in case, if we already fall, dont check fall again
	// reset count if knockdowntime expired.
	if(self->knockdowntime && self->knockdowntime<time)
		self->knockdowncount = self->modeldata.knockdowncount;

	self->knockdowncount -= (attackdrop * fdefense_knockdown);
	self->knockdowntime = time + GAME_SPEED;
	self->drop = (self->knockdowncount<0); // knockdowncount < 0 means knocked down
}

void checkmpadd()
{
	entity* other = self->opponent;
	if(other == NULL || other == self) return;

	if(magic_type == 1 )
	{
		other->mp += other->modeldata.mprate;

		if(other->mp > other->modeldata.mp) other->mp = other->modeldata.mp;
		else if(other->mp < 0) other->mp = 0;
	}
}

void checkhitscore(entity* other, s_attack* attack)
{
	entity* opp = self->opponent;
	if(!opp) return;
	if(opp && opp!=self && opp->modeldata.type == TYPE_PLAYER)
	{    // Added obstacle so explosions can hurt enemies
		addscore(opp->playerindex, attack->attack_force*self->modeldata.multiple);    // New multiple variable
		control_rumble(opp->playerindex, attack->attack_force*2);
	}
	// Don't animate or fall if hurt by self, since
	// it means self fell to the ground already. :)
	// Add throw score to the player
	else if(other==self && self->damage_on_landing > 0) addscore(opp->playerindex, attack->attack_force);
}

void checkdamage(entity* other, s_attack* attack)
{
	int force = attack->attack_force;
	int type = attack->attack_type;
	if(self->modeldata.guardpoints.maximum > 0 && self->modeldata.guardpoints.current <= 0) force = 0; //guardbreak does not deal damage.
	if(!(self->damage_on_landing && self == other) && !other->projectile && type >= 0 && type<max_attack_types)
	{
		force = (int)(force * other->offense_factors[type]);
		force = (int)(force * self->defense[type].factor);
	}

	self->health -= force; //Apply damage.

	if (self->health > self->modeldata.health) self->health = self->modeldata.health; //Cap negative damage to max health.

	if(attack->no_kill && self->health<=0) self->health = 1;

	execute_takedamage_script(self, other, force, attack->attack_drop, type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add);                       //Execute the take damage script.

	if (self->health <= 0)                                      //Health at 0?
	{
		if(!(self->a < PIT_DEPTH || self->lifespancountdown<0)) //Not a pit death or countdown?
		{
			if (self->invincible == 2)                          //Invincible type 2?
			{
				self->health = 1;                               //Stop at 1hp.
			}
			else if(self->invincible == 3)                      //Invincible type 3?
			{
				self->health = self->modeldata.health;          //Reset to max health.
			}
		}
		execute_ondeath_script(self, other, force, attack->attack_drop, type, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add);   //Execute ondeath script.
	}
}

int checkgrab(entity *other, s_attack* attack)
{
	//if(attack->no_pain) return  0; //no effect, let modders to deside, don't bother check it here
	if(self!=other && attack->grab && cangrab(other, self))
	{
		if(adjust_grabposition(other, self, attack->grab_distance, attack->grab))
		{
			ents_link(other, self);
			self->a = other->a;
		}
		else return 0;
	}
	return 1;
}

int arrow_takedamage(entity *other, s_attack* attack)
{
	self->modeldata.no_adjust_base = 0;
	self->modeldata.subject_to_wall = self->modeldata.subject_to_platform = self->modeldata.subject_to_hole = self->modeldata.subject_to_gravity = 1;
	if( common_takedamage(other, attack) && self->dead)
	{
			  return 1;
	}
	return 0;
}

int common_takedamage(entity *other, s_attack* attack)
{
	if(self->dead) return 0;
	if(self->toexplode == 2) return 0;
	// fake 'grab', if failed, return as the attack hit nothing
	if(!checkgrab(other, attack)) return 0; // try to grab but failed, so return 0 means attack missed

	// set pain_time so it wont get hit too often
	// 2011/11/24 UT: move this to do_attack to merge with block code
	//self->pain_time = time + (attack->pain_time?attack->pain_time:(GAME_SPEED / 5));
	// set oppoent
	if(self!=other) set_opponent(self, other);
	// adjust type
	if(attack->attack_type >= 0 && attack->attack_type<max_attack_types) self->damagetype = attack->attack_type;
	else self->damagetype = ATK_NORMAL;
	// pre-check drop
	checkdamagedrop(attack);
	// Drop Weapon due to being hit.
	if(self->modeldata.weaploss[0] <= 0) dropweapon(1);
	// check effects, e.g., frozen, blast, steal
	if(!(self->modeldata.guardpoints.maximum > 0 && self->modeldata.guardpoints.current <= 0)) checkdamageeffects(attack);
	// check flip direction
	checkdamageflip(other, attack);
	// mprate can also control the MP recovered per hit.
	checkmpadd();
	//damage score
	checkhitscore(other, attack);
	// check damage, cost hp.
	checkdamage(other, attack);
	// is it dead now?
	checkdeath();

	if(self->modeldata.type == TYPE_PLAYER) control_rumble(self->playerindex, attack->attack_force * 3);
	if(self->a<=PIT_DEPTH && self->dead)
	{
		if(self->modeldata.type == TYPE_PLAYER) player_die();
		else kill(self);
		return 1;
	}
	// fall to the ground so dont fall again
	if(self->damage_on_landing)
	{
		self->damage_on_landing = 0;
		return 1;
	}
	// unlink due to being hit
	if((self->opponent && self->opponent->grabbing != self)||
	   self->dead || self->frozen || self->drop)
	{
		ent_unlink(self);
	}
	// Enemies can now use SPECIAL2 to escape cheap attack strings!
	if(self->modeldata.escapehits)
	{
		if(self->drop) self->escapecount = 0;
		else self->escapecount++;
	}
	// New pain, fall, and death animations. Also, the nopain flag.
	if(self->drop || self->health <= 0)
	{
		self->takeaction = common_fall;
		// Drop Weapon due to death.
		if(self->modeldata.weaploss[0] <= 2 && self->health <= 0) dropweapon(1);
		else if(self->modeldata.weaploss[0] <= 1) dropweapon(1);

		if(self->health <= 0 && self->modeldata.falldie == 1)
		{
			self->xdir = self->zdir = self->tossv = 0;
			set_death(self, self->damagetype, 0);
		}
		else
		{
			self->xdir = attack->dropv[1];
			self->zdir = attack->dropv[2];
			if(self->direction) self->xdir = -self->xdir;
			toss(self, attack->dropv[0]);
			self->damage_on_landing = attack->damage_on_landing;
			self->knockdowncount = self->modeldata.knockdowncount; // reset the knockdowncount
			self->knockdowntime = 0;

			// Now if no fall/die animations exist, entity simply disapears
			//set_fall(entity *iFall, int type, int reset, entity* other, int force, int drop)
			if(!set_fall(self, self->damagetype, 1, other, attack->attack_force, attack->attack_drop, attack->no_block, attack->guardcost, attack->jugglecost, attack->pause_add))
			{
				if(self->modeldata.type == TYPE_PLAYER) player_die();
				else kill(self);
				return 1;
			}
		}
		if(self->modeldata.type == TYPE_PLAYER) control_rumble(self->playerindex, attack->attack_force * 3);
	}
	else if(attack->grab && !attack->no_pain)
	{
		self->takeaction = common_pain;
		other->takeaction = common_grabattack;
		other->stalltime = time + GRAB_STALL;
		self->releasetime = time + (GAME_SPEED/2);
		set_pain(self, self->damagetype, 0);
	}
	// Don't change to pain animation if frozen
	else if(!self->frozen && !self->modeldata.nopain && !attack->no_pain && !(self->defense[(short)attack->attack_type].pain && attack->attack_force < self->defense[(short)attack->attack_type].pain))
	{
		self->takeaction = common_pain;
		set_pain(self, self->damagetype, 1);
	}
	return 1;
}

// A.I. try upper cut
int common_try_upper(entity* target)
{
	if(!validanim(self,ANI_UPPER)) return 0;


	if(!target) target = normal_find_target(ANI_UPPER,0);

	// Target jumping? Try uppercut!
	if(target && target->jumping )
	{
		self->takeaction = common_attack_proc;
		set_attacking(self);
		self->zdir = self->xdir = 0;
		// Don't waste any time!
		ent_set_anim(self, ANI_UPPER, 0);
		return 1;
	}
	return 0;
}

int common_try_runattack(entity* target)
{
	if(!self->running || !validanim(self,ANI_RUNATTACK)) return 0;


	if(!target) target = normal_find_target(ANI_RUNATTACK,0);

	if(target)
	{
		if(!target->animation->vulnerable[target->animpos] && (target->drop || target->attacking)) 
			return 0;
		self->takeaction = common_attack_proc;
		self->zdir = self->xdir = 0;
		set_attacking(self);
		ent_set_anim(self, ANI_RUNATTACK, 0);
		return 1;
	}
	return 0;
}

int common_try_block(entity* target)
{
	if(self->modeldata.nopassiveblock==0 ||
	   (rand32()&self->modeldata.blockodds) != 1 ||
	   !validanim(self,ANI_BLOCK))
	   return 0;

	if(!target) target = block_find_target(ANI_BLOCK,0); // temporary fix, other wise ranges never work

	// no passive block, so block by himself :)
	if(target && target->attacking)
	{
		self->takeaction = common_block;
		set_blocking(self);
		self->zdir = self->xdir = 0;
		ent_set_anim(self, ANI_BLOCK, 0);
		return 1;
	}
	return 0;
}

// this logic could be used for multiple times, so make a function
// pick a random attack or return the first attacks if testonly is set
// when testonly is set, the function will not check special attacks (upper, jumpattack)
// if target is NULL, ranges are not checked
int pick_random_attack(entity* target, int testonly){
	int found = 0, i, j;

	for(i=0; i<max_attacks; i++) // TODO: recheck range for attacks chains
	{
		if(validanim(self,animattacks[i]) &&
			(!target || check_range(self, target, animattacks[i])))
		{
			for(j=((5-i)>=0?(5-i):0)*3; j>=0; j--) 
				atkchoices[found++] = animattacks[i];
		}
	}
	for(i=0; i<max_freespecials; i++)
	{
		if(validanim(self,animspecials[i]) &&
		   (check_energy(1, animspecials[i]) ||
			check_energy(0, animspecials[i])) &&
		    (!target || check_range(self, target, animspecials[i])))
		{
			atkchoices[found++] = animspecials[i];
		}
	}
	if( validanim(self,ANI_THROWATTACK) &&
		self->weapent && self->weapent->modeldata.subtype == SUBTYPE_PROJECTILE &&
		(!target || check_range(self, target, ANI_THROWATTACK) ))
	{
		atkchoices[found++] = ANI_THROWATTACK;
	}

	if(testonly){
		if(found) return atkchoices[(rand32()&0xffff)%found];
		return -1;
	}

	if( validanim(self,ANI_JUMPATTACK) &&
		(!target || check_range(self, target, ANI_JUMPATTACK)) )
	{
		if(testonly) return ANI_JUMPATTACK;
		atkchoices[found++] = ANI_JUMPATTACK;
	}
	if( validanim(self,ANI_UPPER) &&
		(!target || check_range(self, target, ANI_UPPER)) )
	{
		if(testonly) return ANI_UPPER;
		atkchoices[found++] = ANI_UPPER;
	}

	if(found){
		return atkchoices[(rand32()&0xffff)%found];
	}

	return -1;
}


// code to lower the chance of attacks, may change while testing old mods
// min - min attack chance
// max - max attack chance
int check_attack_chance(entity* target, float min, float max){
	
	float chance, chance1, chance2;//, aggfix;

	if(self->modeldata.aiattack&AIATTACK1_ALWAYS) return 1;

	chance1 = MIN(1.0f,(diff(self->x, self->destx)+diff(self->z, self->destz))/(videomodes.hRes+videomodes.vRes)*move_noatk_factor);
	chance2 = MIN(1.0f, (count_ents(self->modeldata.type)-1)*group_noatk_factor);

	chance = (1.0f-chance1)*(1.0f-chance2);
	
	if(chance>max) chance = max;
	else if(chance<min) chance = min;

	chance *= (1.0-self->modeldata.attackthrottle);

	if(self->x<screenx-10 || self->x>screenx+videomodes.hRes+10){
		chance *= (1.0-offscreen_noatk_factor);
	}

	return (randf(1)<=chance);
}

//make a function, mostly for debug purpose
//give it a chance to reset current noattack timer
u32 recheck_nextattack(entity* target)
{
	if(target->blocking) self->nextattack = 0;
	else if(target->attacking && self->nextattack>4) self->nextattack-=4;
	else if(target->jumping && self->nextattack>16) self->nextattack-=16;

	return self->nextattack;
}

int common_try_normalattack(entity* target)
{
	target = normal_find_target(-1, 0);

	if(!target) return 0;

	recheck_nextattack(target);

	if(recheck_nextattack(target)>time) return 0;

	if(!target->animation->vulnerable[target->animpos] && (target->drop || target->attacking || target->takeaction==common_rise)) 
		return 0;

	if(pick_random_attack(target, 1)>=0) {
		if(self->combostep[0] && self->combotime>time) self->stalltime = time+1;
		else 
		{
			if(!check_attack_chance(target, 1.0f-min_noatk_chance, 1.0f-min_noatk_chance)) {
				self->nextattack = time + randf(self->modeldata.attackthrottletime);
				return 0;
			} else
				self->stalltime = time + (int)randf((float)MAX(1,GAME_SPEED*3/4 - self->modeldata.aggression));
		}
		self->takeaction = normal_prepare;
		self->zdir = self->xdir = 0;
		set_idle(self);
		self->idling = 0; // not really idle, in fact it is thinking
		self->attacking = -1; // pre-attack, for AI-block check
		return 1;
	}

	return 0;
}

int common_try_jumpattack(entity* target)
{
	entity* dust;
	int rnum, ani = 0;
	if((validanim(self,ANI_JUMPATTACK) || validanim(self,ANI_JUMPATTACK2)))
	{
		if(!validanim(self,ANI_JUMPATTACK)) rnum = 1;
		else if(validanim(self,ANI_JUMPATTACK2) && (rand32()&1)) rnum = 1;
		else rnum = 0;
		
		if(rnum==0 &&
			// do a jumpattack
			(target || (target = normal_find_target(ANI_JUMPATTACK,0))) )
		{
			if(recheck_nextattack(target)>time) return 0;

			if(!target->animation->vulnerable[target->animpos] && (target->drop || target->attacking))
				rnum = -1;
			else{
				if(!check_attack_chance(target,0.05f,0.4f)) {
					self->nextattack = time + randf(self->modeldata.attackthrottletime);
					return 0;
				}
				//ent_set_anim(self, ANI_JUMPATTACK, 0);
				ani = ANI_JUMPATTACK;
				if(self->direction) self->xdir = (float)1.3;
				else self->xdir = (float)-1.3;
				self->zdir = 0;
			}
		}
		else if(rnum==1 &&
			// do a jumpattack2
			(target || (target = normal_find_target(ANI_JUMPATTACK2,0))) )
		{
			if(recheck_nextattack(target)>time) return 0;

			if(!target->animation->vulnerable[target->animpos] && (target->drop || target->attacking))
				rnum = -1;
			else{
				if(!check_attack_chance(target,0.05f,0.5f)) {
					self->nextattack = time + randf(self->modeldata.attackthrottletime);
					return 0;
				}
				//ent_set_anim(self, ANI_JUMPATTACK2, 0);
				ani = ANI_JUMPATTACK2;
				self->xdir = self->zdir = 0;
			}
		} else {
			rnum = -1;
		}

		if(rnum >= 0)
		{

			self->takeaction = common_jump;
			set_attacking(self);
			self->jumping = 1;
			toss(self, self->modeldata.jumpheight);

			if(self->modeldata.dust[2]>=0)
			{
				dust = spawn(self->x, self->z, self->a, self->direction, NULL, self->modeldata.dust[2], NULL);
				if(dust){
					dust->base = self->a;
					dust->autokill = 2;
					execute_onspawn_script(dust);
				}
			}

			ent_set_anim(self, ani, 0);

			return 1;
		}
	}
	return 0;
}

int common_try_grab(entity* other)
{
	int trygrab(entity* t);
	if( (rand()&7)==0 &&
		(validanim(self,ANI_THROW) ||
		 validanim(self,ANI_GRAB)) && self->idling &&
		(other || (other = find_ent_here(self,self->x, self->z, self->modeldata.hostile, NULL)))&&
		trygrab(other))
	{
		return 1;
	}
	return 0;
}

// Normal attack style
// Used by root A.I., what to do if a target is found.
// return 0 if no action is token
// return 1 if an action is token
int normal_attack()
{
	//int rnum;

	//rnum = rand32()&7;
	if( common_try_grab(NULL) ||
		common_try_upper(NULL) ||
		common_try_block(NULL) ||
		common_try_runattack(NULL) ||
	   //(rnum < 2 && common_try_freespecial(NULL)) ||
		common_try_normalattack(NULL) ||
		common_try_jumpattack(NULL) )
	{
		self->running = 0;
		return 1;
	}
	return 0;// nothing to do? so go to next think step
}

// A.I. characters do a throw
void common_throw()
{
	if(self->animating) return; // just play the throw animation

	// we have done the throw, return to A.I. root
	self->takeaction = NULL;

	set_idle(self);
}

// toss the grabbed one
void dothrow()
{
	entity* other;
	self->xdir = self->zdir = 0;
	other = self->link;
	if(other == NULL) //change back to idle, or we will get stuck here
	{
		self->takeaction = NULL;// A.I. root again
		set_idle(self);
		return;
	}

	if(other->modeldata.throwheight) toss(other, other->modeldata.throwheight);
	else toss(other, other->modeldata.jumpheight);

	other->direction = self->direction;
	other->projectile = 2;
	other->xdir = (other->direction)?(-other->modeldata.throwdist):(other->modeldata.throwdist);

	if(autoland == 1 && validanim(other,ANI_LAND)) other->damage_on_landing = -1;
	else other->damage_on_landing = self->modeldata.throwdamage;

	ent_unlink(other);

	other->takeaction = common_fall;
	self->takeaction = common_throw;
	set_fall(other, ATK_NORMAL, 0, self, 0, 0, 0, 0, 0, 0);
	ent_set_anim(self, ANI_THROW, 0);
}


// Waiting until throw frame reached
void common_throw_wait()
{
	if(!self->link)
	{
		self->takeaction = NULL;// A.I. root again
		set_idle(self);
		return;
	}

	self->releasetime += THINK_SPEED; //extend release time

	if(self->animpos != self->modeldata.throwframewait) return;

	dothrow();
}


void common_prethrow()
{
	self->running = 0;    // Quits running if grabbed by opponent

	// Just check if we're still grabbed...
	if(self->link) return;

	self->takeaction = NULL;// A.I. root again

	set_idle(self);
}

// warp to its parent entity, just like skeletons in Diablo 2
void npc_warp()
{
	if(!self->parent) return;
	self->z = self->parent->z;
	self->x = self->parent->x;
	self->a = self->parent->a;
	self->xdir = self->zdir = 0;
	self->base = self->parent->base;
	self->tossv = 0;

	if(validanim(self,ANI_RESPAWN)) {
		self->takeaction = common_spawn;
		ent_set_anim(self, ANI_RESPAWN, 0);
	} else if(validanim(self,ANI_SPAWN)) {
		self->takeaction = common_spawn;
		ent_set_anim(self, ANI_SPAWN, 0);
	}
}

int adjust_grabposition(entity* ent, entity* other, float dist, int grabin)
{
	float x1, z1, x2, z2, x;

	if(ent->a!=other->a) return 0;
	if(ent->base!=other->base) return 0;

	if(grabin==1)
	{
		x1 = ent->x;
		z1 = z2 = ent->z;
		x2 = ent->x + ((other->x>ent->x)?dist:-dist);
	}
	else
	{
		x = (ent->x + other->x)/2;
		x1 = x + ((ent->x>=other->x)?(dist/2):(-dist/2));
		x2 = x + ((other->x>ent->x)?(dist/2):(-dist/2));
		z1 = z2 = (ent->z + other->z)/2;
	}

	if(0>=testmove(ent, ent->x, ent->z, x1, z1) || 0>=testmove(other, other->x, other->z, x2, z2))
		return 0;

	ent->x = x1; ent->z = z1;
	other->x = x2; other->z = z2;
	//other->a = ent->a;
	//other->base = ent->base;
	return 1;
}

int trygrab(entity* other)
{
	if( cangrab(self, other) &&	adjust_grabposition(self, other, self->modeldata.grabdistance, 0))
	{
		if(self->model->grabflip&1) self->direction = (self->x < other->x);

		set_opponent(other, self);
		ents_link(self, other);
		other->attacking = 0;
		self->idling = 0;
		self->running = 0;

		self->xdir = self->zdir =
		other->xdir = other->zdir = 0;
		if(validanim(self,ANI_GRAB))
		{
			if(self->model->grabflip&2) other->direction = !self->direction;
			self->attacking = 0;
			memset(self->combostep, 0, 5*sizeof(int));
			other->stalltime = time + GRAB_STALL;
			self->releasetime = time + (GAME_SPEED/2);
			other->takeaction = common_grabbed;
			self->takeaction = common_grab;
			ent_set_anim(self, ANI_GRAB, 0);
			set_pain(other, -1, 0); //set grabbed animation
		}
		// use original throw code if throwframewait not present, kbandressen 10/20/06
		else if(self->modeldata.throwframewait == -1)
			dothrow();
		// otherwise enemy_throw_wait will be used, kbandressen 10/20/06
		else
		{
			if(self->model->grabflip&2) other->direction = !self->direction;

			other->takeaction = common_prethrow;
			self->takeaction = common_throw_wait;
			ent_set_anim(self, ANI_THROW, 0);
			set_pain(other, -1, 0); // set grabbed animation
		}
		return 1;
	}
	return 0;
}


int common_trymove(float xdir, float zdir)
{
	entity *other = NULL;
	int wall, heightvar;
	float x, z, oxdir, ozdir;

	if(!xdir && !zdir) return 0;

	oxdir = xdir; ozdir = zdir;
	/*
	// entity is grabbed by other
	if(self->link && self->link->grabbing==self && self->link->grabwalking)
	{
		return 1; // just return so we don't have to check twice
	}*/

	x = self->x + xdir;  z = self->z + zdir;
	// -----------bounds checking---------------
	// Subjec to Z and out of bounds? Return to level!
	if (self->modeldata.subject_to_minz>0)
	{
		if(zdir && z < PLAYER_MIN_Z)
		{
			zdir = PLAYER_MIN_Z - self->z;
			execute_onblockz_script(self);
		}
	}

	if (self->modeldata.subject_to_maxz>0)
	{
		if(zdir && z > PLAYER_MAX_Z)
		{
			zdir = PLAYER_MAX_Z - self->z;
			execute_onblockz_script(self);
		}
	}

	// End of level is blocked?
	if(level->exit_blocked)
	{
		if(x > level->width-30-(PLAYER_MAX_Z-z))
		{
			xdir = level->width-30-(PLAYER_MAX_Z-z) - self->x;
		}
	}
	// screen checking
	if(self->modeldata.subject_to_screen>0)
	{
		if(x < advancex+10)
		{
			xdir = advancex+10 - self->x;
			execute_onblocks_script(self);  //Screen block event.
		}
		else if(x > advancex+(videomodes.hRes-10))
		{
			xdir = advancex+(videomodes.hRes-10) - self->x;
			execute_onblocks_script(self);  //Screen block event.
		}
	}

	if(!xdir && !zdir) return 0;
	x = self->x + xdir;  z = self->z + zdir;

	//-----------end of bounds checking-----------

	//-------------hole checking ---------------------
	// Don't walk into a hole or walk off platforms into holes
	if( self->modeldata.type!=TYPE_PLAYER && self->idling &&
		(!self->animation->seta||self->animation->seta[self->animpos]<0) &&
		self->modeldata.subject_to_hole>0 && !inair(self) &&
		!(self->modeldata.aimove&AIMOVE2_IGNOREHOLES))
	{

		if(zdir && checkhole(self->x, z) && checkwall(self->x, z)<0 && (((other = check_platform(self->x, z, self)) &&  self->base < other->a + other->animation->platform[other->animpos][7]) || other == NULL))
		{
			zdir = 0;
		}
		if(xdir && checkhole(x, self->z) && checkwall(x, self->z)<0 && (((other = check_platform(x, self->z, self)) &&  self->base < other->a + other->animation->platform[other->animpos][7]) || other == NULL))
		{
			xdir = 0;
		}
	}

	if(!xdir && !zdir) return 0;
	x = self->x + xdir;  z = self->z + zdir;
	//-----------end of hole checking---------------

	//--------------obstacle checking ------------------
	if(self->modeldata.subject_to_obstacle>0 /*&& !inair(self)*/)
	{
		if((other = find_ent_here(self, x, self->z, (TYPE_OBSTACLE | TYPE_TRAP), NULL)) &&
		   (xdir>0 ? other->x > self->x: other->x < self->x) &&
		   (!other->animation->platform||!other->animation->platform[other->animpos][7]))
			{
				xdir    = 0;
				execute_onblocko_script(self, other);
			}
		if((other = find_ent_here(self, self->x, z, (TYPE_OBSTACLE | TYPE_TRAP), NULL)) &&
		   (zdir>0 ? other->z > self->z: other->z < self->z) &&
		   (!other->animation->platform||!other->animation->platform[other->animpos][7]))
			{
				zdir    = 0;
				execute_onblocko_script(self, other);
			}
	}

	if(!xdir && !zdir) return 0;
	x = self->x + xdir*2;  z = self->z + zdir*2;

	//-----------end of obstacle checking--------------

	// ---------------- platform checking----------------

	if(self->animation->height) heightvar = self->animation->height;
	else heightvar = self->modeldata.height;

	// Check for obstacles with platform code and adjust base accordingly
	if(self->modeldata.subject_to_platform>0 && (other = check_platform_between(x, z, self->a, self->a+heightvar, self)) )
	{
		if(xdir>0 ? other->x>self->x : other->x<self->x) {xdir = 0; }
		if(zdir>0 ? other->z>self->z : other->z<self->z) {zdir = 0; }
	}

	if(!xdir && !zdir) return 0;
	x = self->x + xdir;  z = self->z + zdir;

	//-----------end of platform checking------------------

	// ------------------ wall checking ---------------------
	if(self->modeldata.subject_to_wall){

		if((wall = checkwall(x, self->z))>=0 && level->walls[wall][7]>self->a)
		{
			if(xdir > 0.5){ xdir = 0.5; }
			else if(xdir < -0.5){ xdir = -0.5; }
			if((wall = checkwall(self->x + xdir, self->z))>=0 && level->walls[wall][7]>self->a){
				xdir = 0;
				execute_onblockw_script(self,1,(double)level->walls[wall][7]);
			}
		}
		if((wall = checkwall(self->x, z))>=0 && level->walls[wall][7]>self->a)
		{
			if(zdir > 0.5){ zdir = 0.5; }
			else if(zdir < -0.5){ zdir = -0.5; }
			if((wall = checkwall(self->x, self->z + zdir))>=0 && level->walls[wall][7]>self->a){
				zdir = 0;
				execute_onblockw_script(self,2,(double)level->walls[wall][7]);
			}
		}
	}


	if(!xdir && !zdir) return 0;
	x = self->x + xdir;  z = self->z + zdir;
	//----------------end of wall checking--------------

	//------------------ grab/throw checking------------------
	if(self->modeldata.type==TYPE_PLAYER &&
		(rand()&7)==0 &&
		(validanim(self,ANI_THROW) ||
		 validanim(self,ANI_GRAB)) && self->idling &&
		(other = find_ent_here(self, self->x, self->z, self->modeldata.hostile, NULL)))
	{
		if(trygrab(other)) return 0;
	}
	// ---------------  end of grab/throw checking ------------------------

	// do move and return
	self->x += xdir;
	self->z += zdir;

	if(xdir)    execute_onmovex_script(self);   //X move event.
	if(zdir)    execute_onmovez_script(self);   //Z move event.
	return 2-(xdir==oxdir && zdir ==ozdir);     // return 2 for some checks
}

// enemies run off after attack
void common_runoff()
{
	entity *target = normal_find_target(-1,0);

	if(target == NULL) { //sealth checking
		self->zdir = self->xdir = 0;
		self->takeaction = NULL; // OK, back to A.I. root
		set_idle(self); 
		return;
	}

	if(!self->modeldata.noflip) self->direction = (self->x < target->x);
	if(self->direction) self->xdir = -self->modeldata.speed/2;
	else self->xdir = self->modeldata.speed/2;

	self->zdir = 0;

	if(time > self->stalltime) self->takeaction = NULL; // OK, back to A.I. root

	adjust_walk_animation(target);
}


void common_stuck_underneath()
{
	if(!check_platform_between(self->x, self->z, self->a, self->a+self->modeldata.height, self) )
	{
		self->takeaction = NULL;
		set_idle(self);
		return;
	}
	if(player[self->playerindex].keys & FLAG_MOVELEFT)
	{
		self->direction = 0;
	}
	else if(player[self->playerindex].keys & FLAG_MOVERIGHT)
	{
		self->direction = 1;
	}
	if(player[self->playerindex].playkeys & FLAG_ATTACK && validanim(self,ANI_DUCKATTACK))
	{
		player[self->playerindex].playkeys -= FLAG_ATTACK;
		self->takeaction = common_attack_proc;
		set_attacking(self);
		self->xdir = self->zdir = 0;
		self->combostep[0] = 0;
		self->running = 0;
		ent_set_anim(self, ANI_DUCKATTACK, 0);
		return;
	}
	if((player[self->playerindex].keys & FLAG_MOVEDOWN) && (player[self->playerindex].playkeys & FLAG_JUMP) && validanim(self,ANI_SLIDE))
	{
		player[self->playerindex].playkeys -= FLAG_JUMP;
		self->takeaction = common_attack_proc;
		set_attacking(self);
		self->xdir = self->zdir = 0;
		self->combostep[0] = 0;
		self->running = 0;
		ent_set_anim(self, ANI_SLIDE, 0);
		return;
	}
}


// finish attacking, do something
void common_attack_finish()
{
	entity *target;
	int stall;

	self->xdir = self->zdir = 0;

	if(self->modeldata.type == TYPE_PLAYER)
	{
		self->takeaction = NULL;
		set_idle(self);
		return;
	}

	target = self->opponent;

	if(target && !self->modeldata.nomove && diff(self->x, target->x)<80 && (rand32()&3))
	{
		self->takeaction = NULL;//common_runoff;
		self->des