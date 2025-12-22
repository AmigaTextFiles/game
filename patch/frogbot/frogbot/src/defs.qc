#define QUAKE
//#define QUAKEWORLD
//#define MANUAL





#ifdef QUAKE

/*
==============================================================================

			SOURCE FOR GLOBALVARS_T C STRUCTURE

==============================================================================
*/

//
// system globals
//
entity		self;
entity		other;
entity		world;
float		time;
float		frametime;

float		force_retouch;		// force all entities to touch triggers
								// next frame.  this is needed because
								// non-moving things don't normally scan
								// for triggers, and when a trigger is
								// created (like a teleport trigger), it
								// needs to catch everything.
								// decremented each frame, so set to 2
								// to guarantee everything is touched
string		mapname;

float		deathmatch;
float		coop;
float		teamplay;

float		serverflags;		// propagated from level to level, used to
								// keep track of completed episodes

float		total_secrets;
float		total_monsters;

float		found_secrets;		// number of secrets found
float		killed_monsters;	// number of monsters killed

// spawnparms are used to encode information about clients across server
// level changes
float		parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, parm9, parm10, parm11, parm12, parm13, parm14, parm15, parm16;

//
// global variables set by built in functions
//	
vector		v_forward, v_up, v_right;	// set by makevectors()
	
// set by traceline / tracebox
float		trace_allsolid;
float		trace_startsolid;
float		trace_fraction;
vector	trace_endpos;
vector	trace_plane_normal;
float		trace_plane_dist;
entity	trace_ent;
float		trace_inopen;
float		trace_inwater;

entity		msg_entity;				// destination of single entity writes

//
// required prog functions
//
void() 		main;						// only for testing

void()		StartFrame;

void() 		PlayerPreThink;
void() 		PlayerPostThink;

void()		ClientKill;
void()		ClientConnect;
void() 		PutClientInServer;		// call after setting the parm1... parms
void()		ClientDisconnect;

void()		SetNewParms;			// called when a client first connects to
									// a server. sets parms so they can be
									// saved off for restarts

void()		SetChangeParms;			// call to set parms for self so they can
									// be saved for a level transition


//================================================
void		end_sys_globals;		// flag for structure dumping
//================================================

/*
==============================================================================

			SOURCE FOR ENTVARS_T C STRUCTURE

==============================================================================
*/

//
// system fields (*** = do not set in prog code, maintained by C code)
//
.float		modelindex;		// *** model index in the precached list
.vector		absmin, absmax;	// *** origin + ((mins - 1) or (maxs + 1))
.float		ltime;			// local time for entity
.float		movetype;
.float		solid;

.vector		origin;			// ***
.vector		oldorigin;		// ***
.vector		velocity;
.vector		angles;
.vector		avelocity;

.vector		punchangle;		// temp angle adjust from damage or recoil

.string		classname;		// spawn function
.string		model;
.float		frame;
.float		skin;
.float		effects;

.vector		mins, maxs;		// bounding box extents reletive to origin
.vector		size;			// maxs - mins

.void()		touch;
.void()		use;
.void()		think;
.void()		blocked;		// for doors or plats, called when can't push other
.float		nextthink;
.entity		groundentity;

// stats
.float		health;
.float		frags;
.float		weapon;			// one of the IT_SHOTGUN, etc flags
.string		weaponmodel;
.float		weaponframe;
.float		currentammo;
.float		ammo_shells, ammo_nails, ammo_rockets, ammo_cells;

.float		items;			// bit flags

.float		takedamage;
.entity		chain;
.float		deadflag;

.vector		view_ofs;			// add to origin to get eye point


.float		button0;		// fire
.float		button1;		// use
.float		button2;		// jump

.float		impulse;		// weapon changes

.float		fixangle;
.vector		v_angle;		// view / targeting angle for players, range -180 to 180
.float		idealpitch;		// calculated pitch angle for lookup up slopes

.string		netname;

.entity 	enemy;

.float		flags;

.float		colormap;
.float		team;

.float		max_health;		// players maximum health is stored here

.float		teleport_time;	// don't back up

.float		armortype;		// save this fraction of incoming damage
.float		armorvalue;

.float		waterlevel;		// 0 = not in, 1 = feet, 2 = waist, 3 = eyes
.float		watertype;		// a contents value

.float		ideal_yaw;
.float		yaw_speed;

.entity		aiment;

.entity 	goalentity;		// a movetarget or an enemy

.float		spawnflags;

.string		target;
.string		targetname;

// damage is accumulated through a frame. and sent as one single
// message, so the super shotgun doesn't generate huge messages
.float		dmg_take;
.float		dmg_save;
.entity		dmg_inflictor;

.entity		owner;		// who launched a missile
.vector		movedir;	// mostly for doors, but also used for waterjump

.string		message;		// trigger messages

.float		sounds;		// either a cd track number or sound number

.string		noise, noise1, noise2, noise3;	// contains names of wavs to play

//================================================
void		end_sys_fields;			// flag for structure dumping
//================================================

#endif // QUAKE


#ifdef QUAKEWORLD

/*
==============================================================================

			SOURCE FOR GLOBALVARS_T C STRUCTURE

==============================================================================
*/

//
// system globals
//
entity          self;
entity          other;
entity          world;
float           time;
float           frametime;

entity          newmis;                         // if this is set, the entity that just
								// run created a new missile that should
								// be simulated immediately


float           force_retouch;          // force all entities to touch triggers
								// next frame.  this is needed because
								// non-moving things don't normally scan
								// for triggers, and when a trigger is
								// created (like a teleport trigger), it
								// needs to catch everything.
								// decremented each frame, so set to 2
								// to guarantee everything is touched
string          mapname;

float           serverflags;            // propagated from level to level, used to
								// keep track of completed episodes

float           total_secrets;
float           total_monsters;

float           found_secrets;          // number of secrets found
float           killed_monsters;        // number of monsters killed


// spawnparms are used to encode information about clients across server
// level changes
float           parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, parm9, parm10, parm11, parm12, parm13, parm14, parm15, parm16;

//
// global variables set by built in functions
//      
vector          v_forward, v_up, v_right;       // set by makevectors()
	
// set by traceline / tracebox
float           trace_allsolid;
float           trace_startsolid;
float           trace_fraction;
vector          trace_endpos;
vector          trace_plane_normal;
float           trace_plane_dist;
entity          trace_ent;
float           trace_inopen;
float           trace_inwater;

entity          msg_entity;                             // destination of single entity writes

//
// required prog functions
//
void()          main;                                           // only for testing

void()          StartFrame;

void()          PlayerPreThink;
void()          PlayerPostThink;

void()          ClientKill;
void()          ClientConnect;
void()          PutClientInServer;              // call after setting the parm1... parms
void()          ClientDisconnect;

void()          SetNewParms;                    // called when a client first connects to
									// a server. sets parms so they can be
									// saved off for restarts

void()          SetChangeParms;                 // call to set parms for self so they can
									// be saved for a level transition


//================================================
void            end_sys_globals;                // flag for structure dumping
//================================================

/*
==============================================================================

			SOURCE FOR ENTVARS_T C STRUCTURE

==============================================================================
*/

//
// system fields (*** = do not set in prog code, maintained by C code)
//
.float          modelindex;             // *** model index in the precached list
.vector         absmin, absmax; // *** origin + mins / maxs

.float          ltime;                  // local time for entity
.float          lastruntime;    // *** to allow entities to run out of sequence

.float          movetype;
.float          solid;

.vector         origin;                 // ***
.vector         oldorigin;              // ***
.vector         velocity;
.vector         angles;
.vector         avelocity;

.string         classname;              // spawn function
.string         model;
.float          frame;
.float          skin;
.float          effects;

.vector         mins, maxs;             // bounding box extents reletive to origin
.vector         size;                   // maxs - mins

.void()         touch;
.void()         use;
.void()         think;
.void()         blocked;                // for doors or plats, called when can't push other


.float          nextthink;
.entity         groundentity;



// stats
.float          health;
.float          frags;
.float          weapon;                 // one of the IT_SHOTGUN, etc flags
.string         weaponmodel;
.float          weaponframe;
.float          currentammo;
.float          ammo_shells, ammo_nails, ammo_rockets, ammo_cells;

.float          items;                  // bit flags

.float          takedamage;
.entity         chain;
.float          deadflag;

.vector         view_ofs;                       // add to origin to get eye point


.float          button0;                // fire
.float          button1;                // use
.float          button2;                // jump

.float          impulse;                // weapon changes

.float          fixangle;
.vector         v_angle;                // view / targeting angle for players, range -180 to 180

.string         netname;

.entity         enemy;

.float          flags;

.float          colormap;
.float          team;

.float          max_health;             // players maximum health is stored here

.float          teleport_time;  // don't back up

.float          armortype;              // save this fraction of incoming damage
.float          armorvalue;

.float          waterlevel;             // 0 = not in, 1 = feet, 2 = wast, 3 = eyes
.float          watertype;              // a contents value

.float          ideal_yaw;
.float          yaw_speed;

.entity         aiment;

.entity         goalentity;             // a movetarget or an enemy

.float          spawnflags;

.string         target;
.string         targetname;

// damage is accumulated through a frame. and sent as one single
// message, so the super shotgun doesn't generate huge messages
.float          dmg_take;
.float          dmg_save;
.entity         dmg_inflictor;

.entity         owner;          // who launched a missile
.vector         movedir;        // mostly for doors, but also used for waterjump

.string         message;                // trigger messages

.float          sounds;         // either a cd track number or sound number

.string         noise, noise1, noise2, noise3;  // contains names of wavs to play

//================================================
void            end_sys_fields;                 // flag for structure dumping
//================================================

#endif // QUAKEWORLD




/*
==============================================================================

				VARS NOT REFERENCED BY C CODE

==============================================================================
*/


//================================================

//
// quakeed fields
//
.string		wad;
.string 		map;
.float		worldtype;	// 0=medieval 1=metal 2=base

.string		killtarget;
.float		light_lev;		// not used by game, but parsed by light util
.float		style;
.float		count;			// for counting triggers

.vector		mangle;			// angle at start
.float		speed;
.float		wait;
.float		delay;
.float		dmg;			// damage done by door when hit
.float		lip;
.float		height;


.void start_remove_fieldnames_;

.string		mdl;

//
// constants
//

float FALSE					= 0;
float TRUE					= 1;

// edict.flags
float	FL_FLY				= 1;
float	FL_SWIM				= 2;
float	FL_CLIENT				= 8;		// set for all client edicts
float	FL_INWATER				= 16;		// for enter / leave water splash
float	FL_MONSTER				= 32;
float	FL_GODMODE				= 64;		// player cheat
float	FL_NOTARGET				= 128;	// player cheat
float	FL_ITEM				= 256;	// extra wide size for bonus items
								// only used for items which have small marker
								// size, due to door nearby moving it (eg. red armor in dm2 near water)
float	FL_ONGROUND				= 512;	// standing on something
float	FL_PARTIALGROUND			= 1024;	// not all corners are valid
float	FL_WATERJUMP			= 2048;	// player jumping out of water
float	FL_JUMPRELEASED			= 4096;	// for jump debouncing
float FL_FROGBOT				= 8192;
float FL_ONTRAIN				= 16384;	// for Frogbot train movement
float FL_WASONGROUND			= 32768;	// for Frogbot stairwalking
float FL_MARKER				= 65536;
float FL_REMOVE				= 131072;	// for items
float FL_PLAYER				= 262144;
float FL_THUD				= 1048576;	// for thud removal

#ifdef QUAKE
float FL_KASCAM				= 524288;
float FL_QWPHYSICS			= 2097152;
float FL_BODYQUE				= 4194304;

float FL_PLAYER_BODYQUE			= 4456448;
#endif // QUAKE

float FL_ONGROUND_PARTIALGROUND	= 1536;
float FL_NOT_WASONGROUND_ONTRAIN	= 16728063;
float FL_NOT_JUMPRELEASED		= 16773119;
float FL_NOT_ONGROUND			= 16776703;

#ifdef QUAKE
float FL_FROGBOT_QWPHYSICS		= 2105344;
float FL_FROGBOT_PLAYER_KASCAM	= 794624;
float FL_CLIENT_FROGBOT_PLAYER_KASCAM_QWPHYSICS	= 2891784;
#endif // QUAKE

#ifdef QUAKEWORLD
float FL_CLIENT_FROGBOT_PLAYER	= 270344;
#endif // QUAKEWORLD


.float client_;
float marker_time;
float next_marker_time;

// spawnflags values for players
float START_SKILL			= 1;
float START_SKIN			= 2;
float START_SHIRT			= 3;
float START_PANTS			= 4;
float START_TEAMSHIRT		= 5;
float START_TEAMPANTS		= 6;

float START_TEAMPLAY		= 7;
float START_DEATHMATCH		= 8;
float START_TIMELIMIT		= 9;
float START_FRAGLIMIT		= 10;

float START_LINES			= 11;

float START_NAME			= 13;
float START_QWSKIN		= 14;

float START_MSG			= 18;
float START_BOTS			= 12;

float START_ADMIN1		= 15;
float START_ADMIN2		= 16;
float START_ADMIN3		= 17;




//---------------------------
float IMP_START1		= 13;			// command value, during loading
float IMP_SKILL		= 13;
float IMP_SKIN		= 14;
float IMP_SHIRT		= 15;
float IMP_PANTS		= 16;
float IMP_TEAMSHIRT	= 17;
float IMP_TEAMPANTS	= 18;
float IMP_END1		= 18;
//---------------------------
float IMP_NAME		= 19;			// sequence, during loading
float IMP_QWSKIN		= 20;
//---------------------------
float IMP_SETNAME		= 21;			// end of loading
float IMP_LINES		= 22;
//---------------------------
float IMP_ADDBOT		= 23;			// requires admin, end of loading
float IMP_ADD2BOTS	= 24;
float IMP_ADD3BOTS	= 25;
float IMP_ADD4BOTS	= 26;
float IMP_ADDBOT0		= 27;
float IMP_ADDBOT1		= 28;
float IMP_ADDBOT2		= 29;
float IMP_ADDBOT3		= 30;
float IMP_ADDBOT4		= 31;
float IMP_ADDBOT5		= 32;
float IMP_ADDBOT6		= 33;
float IMP_ADDBOT7		= 34;
float IMP_ADDBOT8		= 35;
float IMP_ADDBOT9		= 36;
float IMP_ADDBOT10	= 37;
float IMP_ADDBOT11	= 38;
float IMP_ADDBOT12	= 39;
float IMP_ADDBOT13	= 40;
float IMP_END2		= 40;
//---------------------------
float IMP_MSG		= 41;			// command value, not in loading
float IMP_BOTS		= 42;
//---------------------------
float IMP_ADMIN		= 43;
//---------------------------
float IMP_KASCAM		= 44;			// not in loading
float IMP_LETTERCODES	= 45;
float IMP_TIME		= 46;
float IMP_RULES		= 47;
float IMP_SETSKIN		= 48;
float IMP_FLASH		= 49;
//---------------------------
float IMP_START3		= 50;			// requires admin, command value
float IMP_TEAMPLAY	= 50;
float IMP_DEATHMATCH	= 51;
float IMP_TIMELIMIT	= 52;
float IMP_FRAGLIMIT	= 53;
float IMP_END3		= 53;
//---------------------------
float IMP_HIDE		= 54;			// requires admin, not in loading
float IMP_REMOVEBOT	= 55;
float IMP_REMOVEALLBOTS	= 56;
float IMP_FROGBOT		= 57;
float IMP_LAVACHEAT	= 58;
float IMP_LOOKCHEAT	= 59;
float IMP_FRAMERATE	= 60;
float IMP_POWERUP		= 61;
float IMP_RUNE		= 62;
float IMP_HOOK		= 63;
float IMP_CTF		= 64;
float IMP_CUSTOM		= 65;
float IMP_READY		= 66;
float IMP_MATCH		= 67;
float IMP_RL_PREF		= 68;
float IMP_RUNE_RJ		= 69;
float IMP_QWPHYSICS	= 70;
float IMP_NOSKINS		= 71;
float IMP_QWAIM		= 72;
float IMP_SKINFIX		= 73;
float IMP_MAP_DM4		= 74;
float IMP_MAP_DM6		= 75;
float IMP_MAP_ZTNDM3	= 76;
float IMP_END4		= 76;
//---------------------------
float IMP_RANDOM		= 14;
float IMP_IMPULSE_0	= 255;
//---------------------------


// edict.movetype values
float	MOVETYPE_NONE			= 0;	// never moves
float	MOVETYPE_WALK			= 3;	// players only
float	MOVETYPE_STEP			= 4;	// discrete, not real time unless fall
float	MOVETYPE_FLY			= 5;
float	MOVETYPE_TOSS			= 6;	// gravity
float	MOVETYPE_PUSH			= 7;	// no clip to world, push and crush
float	MOVETYPE_NOCLIP			= 8;
float	MOVETYPE_FLYMISSILE		= 9;	// fly with extra size against monsters
float	MOVETYPE_BOUNCE			= 10;
float	MOVETYPE_BOUNCEMISSILE		= 11;	// bounce with extra size

// edict.solid values
float	SOLID_NOT				= 0;	// no interaction with other objects
float	SOLID_TRIGGER			= 1;	// touch on edge, but not blocking
float	SOLID_BBOX				= 2;	// touch on edge, block
float	SOLID_SLIDEBOX			= 3;	// touch on edge, but not an onground
float	SOLID_BSP				= 4;	// bsp clip, touch on edge, block

// deadflag values

float	DEAD_NO				= 0;
float	DEAD_DYING				= 1;
float	DEAD_DEAD				= 2;
float	DEAD_RESPAWNABLE			= 3;

// takedamage values

float	DAMAGE_NO				= 0;
float	DAMAGE_YES				= 1;
float	DAMAGE_AIM				= 2;

// items
float	IT_AXE				= 4096;
float	IT_SHOTGUN				= 1;
float	IT_SUPER_SHOTGUN			= 2;
float	IT_NAILGUN				= 4;
float	IT_SUPER_NAILGUN			= 8;
float	IT_GRENADE_LAUNCHER		= 16;
float	IT_ROCKET_LAUNCHER		= 32;
float	IT_LIGHTNING			= 64;
// CTF ->
float	IT_HOOK				= 128;
// CTF <-
float IT_EITHER_NAILGUN			= 12;
float IT_NAILGUN_ROCKET			= 44;
float IT_VELOCITY				= 60;
float IT_CONTINUOUS			= 76;
// CTF ->
float IT_AXE_HOOK				= 4224;
// CTF <-
float IT_AXE_SHOTGUN			= 4097;
float IT_ALL_BUT_GRENADE		= 4207;
float IT_ALL				= 4223;

float	IT_SHELLS				= 256;
float	IT_NAILS				= 512;
float	IT_ROCKETS				= 1024;
float	IT_CELLS				= 2048;
float IT_NOT_AMMO				= 16773375;

float	IT_ARMOR1				= 8192;
float	IT_ARMOR2				= 16384;
float	IT_ARMOR3				= 32768;
float IT_ARMOR				= 57344;
float IT_NOT_ARMOR			= 16719871;

// CTF ->
float	IT_KEY1				= 131072;
float	IT_KEY2				= 262144;
// CTF <-

float	IT_INVISIBILITY			= 524288;
float	IT_INVULNERABILITY		= 1048576;
float	IT_SUIT				= 2097152;
float	IT_QUAD				= 4194304;

float	IT_INVULNERABILITY_QUAD		= 5242880;
float IT_POWERUP				= 7864320;
float IT_ARMOR3_INVULNERABILITY	= 1081344;

float	IT_NOT_INVISIBILITY		= 16252927;
float IT_NOT_INVULNERABILITY		= 15728639;
float IT_NOT_SUIT				= 14680063;
float	IT_NOT_QUAD				= 12582911;

// CTF ->
float	IT_SIGIL1				= 268435456;
float	IT_SIGIL2				= 536870912;
float	IT_SIGIL3				= 1073741824;
float	IT_SIGIL4				= 2147483648;
// CTF <-

float ITEM_RUNE1_FLAG		= 1;
float ITEM_RUNE2_FLAG		= 2;
float ITEM_RUNE3_FLAG		= 4;
float ITEM_RUNE4_FLAG		= 8;
float ITEM_RUNE_MASK		= 15;

// point content values

float	CONTENT_EMPTY			= -1;
float	CONTENT_SOLID			= -2;
float	CONTENT_WATER			= -3;
float	CONTENT_SLIME			= -4;
float	CONTENT_LAVA			= -5;
float	CONTENT_SKY				= -6;

float	STATE_TOP		= 0;
float	STATE_BOTTOM	= 1;
float	STATE_UP		= 2;
float	STATE_DOWN		= 3;

#ifdef QUAKEWORLD

float TE_BLOOD		= 12;
float TE_LIGHTNINGBLOOD = 13;

#endif // QUAKEWORLD

vector	VEC_ORIGIN = '0 0 0';
vector	VEC_HULL_MIN = '-16 -16 -24';
vector	VEC_HULL_MAX = '16 16 32';

vector	VEC_HULL2_MIN = '-32 -32 -24';
vector	VEC_HULL2_MAX = '32 32 64';

// protocol bytes
#ifdef QUAKE
float SVC_DISCONNECT		= 2;
#endif // QUAKE

float SVC_SETVIEWPORT		= 5;
float MSG_PRINT			= 8;
float MSG_STUFFCMD		= 9;
float MSG_UPDATENAME		= 13;
float MSG_UPDATEFRAGS		= 14;
float MSG_UPDATECOLORS		= 17;
float	SVC_TEMPENTITY		= 23;
float SVC_CENTERPRINT		= 26;
float	SVC_KILLEDMONSTER		= 27;
float	SVC_FOUNDSECRET		= 28;
float	SVC_INTERMISSION		= 30;
float	SVC_CDTRACK			= 32;

#ifdef QUAKEWORLD

float SVC_SMALLKICK		= 34;
float SVC_BIGKICK			= 35;
float SVC_UPDATEPING		= 36;
float SVC_UPDATETIME		= 37;
float SVC_MUZZLEFLASH		= 39;
float SVC_UPDATEUSERINFO	= 40;
float SVC_PLAYERINFO		= 42;

#endif // QUAKEWORLD

float	TE_SPIKE		= 0;
float	TE_SUPERSPIKE	= 1;
float	TE_GUNSHOT		= 2;
float	TE_EXPLOSION	= 3;
float	TE_LIGHTNING2	= 6;
float	TE_LAVASPLASH	= 10;
float	TE_TELEPORT		= 11;

// sound channels
// channel 0 never willingly overrides
// other channels (1-7) allways override a playing sound on that channel
float	CHAN_AUTO		= 0;
float	CHAN_WEAPON		= 1;
float	CHAN_VOICE		= 2;
float	CHAN_ITEM		= 3;
float	CHAN_BODY		= 4;

#ifdef QUAKEWORLD
float	CHAN_NO_PHS_ADD = 8;	// ie: CHAN_BODY+CHAN_NO_PHS_ADD
#endif // QUAKEWORLD

float	ATTN_NONE		= 0;
float	ATTN_NORM		= 1;
float	ATTN_IDLE		= 2;
float	ATTN_STATIC		= 3;

// entity effects

float	EF_MUZZLEFLASH 	= 2;
float	EF_DIMLIGHT 	= 8;

float NOT_EF_DIMLIGHT	= 16777207;

#ifdef QUAKEWORLD
// GLQuakeWorld Stuff
float EF_BLUE		= 64;	// Blue Globe effect for Quad
float	EF_RED		= 128;	// Red Globe effect for Pentagram
float EF_DIMLIGHT_BLUE	= 72;
float EF_DIMLIGHT_RED	= 136;

float NOT_EF_BLUE		= 16777151;
float NOT_EF_RED		= 16777087;
#endif // QUAKEWORLD


// messages
float	MSG_BROADCAST		= 0;		// unreliable to all
float	MSG_ONE			= 1;		// reliable to one (msg_entity)
float	MSG_ALL			= 2;		// reliable to all

// message levels
float   PRINT_LOW		= 0;            // pickup messages
float   PRINT_MEDIUM	= 1;            // death messages
float   PRINT_HIGH	= 2;            // critical messages

#ifdef QUAKEWORLD

float   MSG_MULTICAST   = 4;            // for multicast() call

// multicast sets
float   MULTICAST_PHS   = 1;            // within hearing
float   MULTICAST_PVS   = 2;            // within sight

#endif // QUAKEWORLD

float MAX_SKILL = 200;
float MAX_TEAMPLAY = 5;
float MAX_DEATHMATCH = 6;

float enter = 10;
float space = 32;
float quote = 34;
float minus = 45;
float _0 = 48;
float _1 = 49;
float _2 = 50;
float _3 = 51;
float _4 = 52;
float _5 = 53;
float _6 = 54;
float _7 = 55;
float _8 = 56;
float _9 = 57;
float _A = 65;
float _B = 66;
float _C = 67;
float _D = 68;
float _E = 69;
float _F = 70;
float _G = 71;
float _H = 72;
float _I = 73;
float _J = 74;
float _K = 75;
float _L = 76;
float _M = 77;
float _N = 78;
float _O = 79;
float _P = 80;
float _Q = 81;
float _R = 82;
float _S = 83;
float _T = 84;
float _U = 85;
float _V = 86;
float _W = 87;
float _X = 88;
float _Y = 89;
float _Z = 90;
float _a = 97;
float _b = 98;
float _c = 99;
float _d = 100;
float _e = 101;
float _f = 102;
float _g = 103;
float _h = 104;
float _i = 105;
float _j = 106;
float _k = 107;
float _l = 108;
float _m = 109;
float _n = 110;
float _o = 111;
float _p = 112;
float _q = 113;
float _r = 114;
float _s = 115;
float _t = 116;
float _u = 117;
float _v = 118;
float _w = 119;
float _x = 120;
float _y = 121;
float _z = 122;

float CLIENTKILL = 11;


//================================================

//
// globals
//
float	gameover;		// set when a rule exits

entity	newmis;			// launch_spike sets this after spawning it

entity	activator;		// the entity that activated a trigger or brush

entity attacker;
float	framecount;

float skill;
float old_skill;
float skill_;

float temp1;

string str;

#ifdef QUAKEWORLD

float teamplay;
float deathmatch;

#endif // QUAKEWORLD

float next_teamplay;
float next_deathmatch;

float modelindex_player;
float	modelindex_eyes;
float modelindex_head;


// CTF ->
entity runespawn;
// CTF <-

//
// player only fields
//

.float oldwaterlevel;
.float oldwatertype;
.float realteam;
.float score_pos;

float realteam_;

.float healamount, healtype;
.float ammo_shells, ammo_nails, ammo_rockets, ammo_cells;
.float total_armor;

float current_team;
float current_frogbot;

.void() th_pain;
.void() th_die;

.float walkframe;

.float 		attack_finished;
.float		pain_finished;

// CTF ->

.float hook_out; // TRUE if hook is in use
.entity hookentity;

#ifdef QUAKE
entity hook_;
entity link;
entity prevlink;
float linknum;
#endif // QUAKE

#ifdef QUAKEWORLD
.float on_hook;// TRUE if hook is anchored and client is being pulled
.entity hook;// pointer to client's hook
vector rel_hook_origin;
#endif // QUAKEWORLD

// CTF <-

.float		invincible_finished;
.float		invisible_finished;
.float		super_damage_finished;
.float		radsuit_finished;

.float		invincible_time, invincible_sound;
.float		invisible_time, invisible_sound;
.float		super_time, super_sound;
// CTF ->
.float		regeneration_sound;//RUNE: Elder Magic
.float		haste_sound;//RUNE: Hell Magic
// CTF <-
.float		rad_time;
.float		fly_sound;

float			axhitme;
float			axhitme_;

.float		jump_flag;		// player jump flag
.float		swim_flag;		// player swimming sound flag
.float		air_finished;	// when time > air_finished, start drowning
.float		bubble_count;	// keeps track of the number of bubbles
string		deathtype;		// keeps track of how the player died

// CTF ->
.float 		player_flag;	// misc flags (skins, etc.)
.float		regen_time;		// time to next regen


// ZOID: Capture the flag
float ITEM_ENEMY_FLAG		= 16;
// TEAMPLAY
float		TEAM_STUFF_COLOR	= 32;

// CTF <-

float healthplay;
float armorplay;

float gamemode;
float new_gamemode;
float game_disable_powerups;
float game_enable_runes;
float game_enable_hook;
float game_enable_ctf;
float game_capture_custom;
float game_not_rune_rj;
float game_rl_pref;
float game_not_match;
float game_lava_cheat;
float game_look_cheat;
float game_show_rules;

#ifdef QUAKE
float game_qwphysics;
float game_skins;
float game_qwaim;
float game_skinfix;
#endif // QUAKE

#ifdef QUAKEWORLD
float game_qizmo;
#endif // QUAKEWORLD

// gamemode values
float GAME_ENABLE_POWERUPS		= 1;
float GAME_ENABLE_RUNES			= 2;
float GAME_RUNE_RJ			= 4;
float GAME_ENABLE_HOOK			= 8;
float GAME_ENABLE_CTF			= 16;
float GAME_CAPTURE_CUSTOM		= 32;	// custom models
float GAME_MATCH				= 64;
float GAME_RL_PREF			= 128;
float GAME_LAVA_CHEAT			= 256;
float GAME_LOOK_CHEAT			= 512;
float GAME_HIDE_RULES			= 1024;

#ifdef QUAKE
float GAME_NOSKINS			= 2048;
float GAME_QWPHYSICS			= 4096;	// Quakeworld wall and edge slide
float GAME_QWAIM				= 8192;	// Quakeworld aim
float GAME_SKINFIX			= 16384;
#endif // QUAKE


//
// object stuff
//
.float		t_length, t_width;

//
// doors, etc
//
.vector		dest;
.entity		trigger_field;	// door's trigger entity
.string		noise4;


.float		aflag;
	
	
//
// subs
//
.void()		think1;
.vector		finaldest, finalangle;

//
// plats / doors / buttons
//
.float		state;
.vector		pos1, pos2;		// top and bottom positions


//===========================================================================


//
// builtin functions
//

void(vector ang)	makevectors		= #1;		// sets v_forward, etc globals
void(entity e, vector o) setorigin	= #2;
void(entity e, string m) setmodel	= #3;		// set movetype and solid first
void(entity e, vector min, vector max) setsize = #4;
// #5 was removed
float() random						= #7;		// returns 0 - 1
void(entity e, float chan, string samp, float vol, float atten) sound_apply = #8;
void(float chan, string samp, float vol, float atten) sound;
vector(vector v) normalize			= #9;
float(vector v) vlen				= #12;
float(vector v) vectoyaw			= #13;	// returns 0 to 360
entity() spawn						= #14;
void(entity e) remove_apply				= #15;
void() remove =
{
	remove_apply(self);
};

// sets trace_* globals
// nomonsters can be:
// An entity will also be ignored for testing if forent == test,
// forent->owner == test, or test->owner == forent
// a forent of world is ignored
void(vector v1, vector v2, float nomonsters, entity forent) traceline = #16;	

entity(entity start, .string fld, string match) find = #18;
string(string s) precache_sound		= #19;
string(string s) precache_model		= #20;
void(entity client, string s) stuffcmd_apply = #21;
void(string s) stuffcmd =
{
	if (msg_entity.flags & FL_PLAYER)
		stuffcmd_apply (msg_entity, s);
};
entity(vector org, float rad) findradius = #22;
//void(string s) dprint				= #25;
string(float f) ftos				= #26;
//string(vector v) vtos				= #27;
float(float yaw, float dist) walkmove	= #32;	// returns TRUE or FALSE
// #33 was removed
float() droptofloor = #34;	// TRUE if landed on floor
void(float style, string value) lightstyle = #35;
float(float v) rint					= #36;		// round to nearest int
float(float v) floor				= #37;		// largest integer <= v
float(float v) ceil					= #38;		// smallest integer >= v
// #39 was removed
#ifdef QUAKE
float(entity e) checkbottom			= #40;		// true if e is on ground
#endif // QUAKE
float(vector v) pointcontents		= #41;		// returns a CONTENT_*
// #42 was removed
float(float f) fabs = #43;
float(string s) cvar = #45;						// return cvar.value
void(string s) localcmd = #46;					// put string into local que
entity(entity e) nextent = #47;					// for looping through all ents
#ifdef QUAKE
void(vector o, vector d, float color, float count_) particle = #48;// start a particle effect
#endif // QUAKE
// #50 was removed
vector(vector v) vectoangles			= #51;	// returns 0 to 360

//
// direct client message generation
//
void(float to, float f) WriteByte		= #52;
//void(float to, float f) WriteChar		= #53;
void(float to, float f) WriteShort		= #54;
void(float to, float f) WriteCoord		= #56;
#ifdef QUAKEWORLD
void(float to, float f) WriteLong		= #55;
void(float to, float f) WriteAngle		= #57;
#endif // QUAKEWORLD
void(float to, string s) WriteString	= #58;
void(float to, entity e) WriteEntity	= #59;

//
// broadcast client message generation
//

//string(string s) precache_file	= #68;  // no effect except for -copy
void(entity e) makestatic		= #69;
void(string s) changelevel = #70;

//#71 was removed

void(string var, string val) cvar_set = #72;	// sets cvar.value
/*
void(entity client, string s) centerprint_apply = #73;	// sprint, but in middle
void(entity client, string s) centerprint =
{
	if (client.flags & FL_PLAYER)
		centerprint_apply(client, s);
};
*/
#ifdef QUAKE
void(entity client, string s, string s1, string s2, string s3, string s4, string s5) centerprint6 = #73;	// sprint, but in middle
#endif // QUAKE
void(vector pos, string samp, float vol, float atten) ambientsound = #74;

string(string s) precache_model2	= #75;		// registered version only
string(string s) precache_sound2	= #76;		// registered version only
//string(string s) precache_file2	= #77;          // registered version only

//void(entity e) setspawnparms		= #78;		// set parm1... to the
												// values at level start
												// for coop respawn

#ifdef QUAKEWORLD

string(entity e, string key) infokey    = #80;  // get a key value (world = serverinfo)
float(string s) stof                            = #81;          // convert string to float
void(vector where, float set) multicast = #82;  // sends the temp message to a set
								// of clients, possibly in 

#endif // QUAKEWORLD


void(entity name_client) bprint_netname;
void(entity name_client) sprint_netname;
void(entity client, float insert_character) insert_netname;

void(float message_ , entity client) WriteName_apply;
void(float message_ , entity client) WriteName;
void(float message_, float value) NumberToString;

void(string s) bprintold				= #23;

/*
void(entity client, string s) sprint_apply = #24;
void(entity client, string s) sprintold =
{
	if (client.flags & FL_PLAYER)
		sprint_apply (client, s);
};
*/


float msg_level;

#ifdef QUAKE
.float msg_level_;
#endif // QUAKE

void(string s) sprint =
{
	if (msg_entity.flags & FL_PLAYER)
	{
	#ifdef QUAKE
		if (msg_entity.msg_level_ <= msg_level)
	#endif // QUAKE

	#ifdef QUAKEWORLD
		if ((stof(infokey(msg_entity,"msg"))) <= msg_level)
	#endif // QUAKEWORLD
		{
			WriteByte(MSG_ONE, MSG_PRINT);
		#ifdef QUAKEWORLD
			WriteByte(MSG_ONE, msg_level);
		#endif // QUAKEWORLD
			WriteString(MSG_ONE, s);
		}
	}
};

void(string s) bprint =
{
	local entity client;

	msg_entity = find(world, classname, "player");
	while (msg_entity)
	{
		sprint(s);
		msg_entity = find(msg_entity, classname, "player");
	}
};


void(float f) bprint_ftos =
{
	str = ftos(f);
	bprint(str);
};

void(float f) bprintold_ftos =
{
	str = ftos(f);
	bprintold(str);
};

void(float f) sprint_ftos =
{
	str = ftos(f);
	sprint(str);
};

void(float f) localcmd_ftos =
{
	str = ftos(f);
	localcmd(str);
};

void(float f) stuffcmd_ftos =
{
	str = ftos(f);
	stuffcmd(str);
};


//===========================================================================

//
// subs.qc
//
void(vector tdest, float tspeed) SUB_CalcMove;
void()  SUB_CalcMoveDone;
void() SUB_UseTargets;
void() SUB_Remove;

//
//	combat.qc
//
void() T_Damage;
float() CanDamage;

entity targ;
float damage;
float t_radius_damage;
entity ignore;

void() check_sound;
void(entity client) UpdateTotalDamage;

void(string var, float value) cvar_set_ =
{
	str = ftos(value);
	cvar_set(var, str);
};

void(string var, float value) cvar_log =
{
	cvar_set_(var, value);
	bprint("\"");
	bprint(var);
	bprint("\" changed to \"");
	bprint_ftos(value);
	bprint("\"\n");
};

void(float value) sprint_ =
{
	str = ftos(value);
	sprint(str);
};

//============================================================================

//
// frogbot variables
//

.float arrow;
.float swim_arrow;
.float button0_;
.float arrow_time;
.float arrow_time2;
.float enemy_time;
.float visible_object_time;
.float linked_marker_time;
.float touch_marker_time;
.float enemy_dist;

float predict_time;

entity previous_spot;

entity enemy_;
entity virtual_enemy;
entity look_object_;
entity visible_object;
entity goalentity_;

entity test_enemy;
entity self_aiment;
vector targ_origin;
vector targ_centre;
vector inflictor_origin;
entity inflictor;
float damage_radius;
float inflictor_dist;
entity self_sound;
float look_for_enemy;

float FORWARD		= 1;
float BACK			= 2;
float LEFT			= 4;
float RIGHT			= 8;
float FORWARD_LEFT	= 5;
float FORWARD_RIGHT	= 9;
float BACK_LEFT		= 6;
float BACK_RIGHT		= 10;
float UP			= 16;
float DOWN			= 32;

float JUMPSPEED = 270;

float numberofbots;

float numberofclients;
float scoreboardsize;

.float index;

.float print_framerate;

.vector oldvelocity;
float new_pitch;

#ifdef QUAKE
.vector postvelocity;
#endif // QUAKE

vector oldvelocity_;

.vector obstruction_normal;
.vector velocity_normal;

float average_frametime;
float time_12;

entity current_waiting_bot;
entity first_client;
entity first_item;
entity first_frogbot;
entity frogbot_spawned;
entity first_ent;
entity first_teleport;
entity first_takedamage;

float takedamage_exists;

#ifdef QUAKE
entity first_kascam;
#endif // QUAKE

.entity previous;
.entity next;

.float oldsolid;

float DROP_SUCCESS			= -2;
float DROP_FAILED				= -1;
float FALL_FALSE				= 0;
float FALL_BLOCKED			= 1;
float FALL_LAND				= 2;
float FALL_DEATH				= 3;

entity dropper;
entity platform;

float fallheight;

.float real_pitch;
.float real_yaw;
.float pitchspeed;
.float yawspeed;
.float pitchaccel;
.float yawaccel;
.vector pitch_tangent;
.vector yaw_tangent;
.float track_pitchspeed;
.float track_yawspeed;
float mouse_friction;

vector pitch_tangent_;
vector yaw_tangent_;
float mouse_vel_;
float pitchspeed_;
float yawspeed_;
float total_pitchspeed;
float total_yawspeed;
float real_pitch_;

#ifdef QUAKE
.vector stored_angle;
#endif // QUAKE

//
// Paths
//

.entity P0;
.entity P1;
.entity P2;
.entity P3;
.entity P4;
.entity P5;

entity m_P;

// Path times
.float P0_time;
.float P1_time;
.float P2_time;
.float P3_time;
.float P4_time;
.float P5_time;

float P_time;

// description of path
.float D0;
.float D1;
.float D2;
.float D3;
.float D4;
.float D5;

float m_D;

.float path_state;
float new_path_state;
float old_path_state;

// path_state/path_mode values for paths
float DIFFICULT			= 4;
float NO_LOOK			= 32;
float WAIT_GROUND			= 128;	// when to register touch
float DM6_DOOR			= 256;
float SHORT_HAZARD		= 512;
float JUMP_LEDGE			= 1024;
float LOOKAHEAD			= 2048;	// look ahead to .P0
float HIGH_ENOUGH			= 8192;

float DISCONNECT_MARKERS	= 1048576;	// a path_mode not a path_state

float NOT_JUMP_LEDGE		= 16776191;


.float T;	// marker type

// T values for markers/type_mode
float UNREACHABLE				= 1;


entity dm6_door;

// state values for clients
float SHOOT_GROUND			= 8;
float CLEAR_SHOT				= 16;
float NOTARGET_ENEMY			= 32;
float UPDATE_WEAPONS			= 64;
float AWARE_SURROUNDINGS		= 128;
float DELAY_UPDATE_WEAPONS		= 512;
float HURT_SELF				= 1024;

float NOT_HURT_SELF			= 16776191;
float NOT_NOTARGET_ENEMY		= 16777183;
float NOT_AWARE_SURROUNDINGS		= 16777087;
float NOT_SHOOT_GROUND_CLEAR_SHOT	= 16777191;
float NOT_UPDATE_WEAPONS_DELAY_UPDATE_WEAPONS	= 16776639;

.entity linked_marker;
.entity old_linked_marker;
.entity look_object;
.entity friend;

.float frogbot_nextthink;
.float fire_nextthink;

float nextthink_;

//
// SaveMarker variables
//

float marker_index;
float item_marker_index;
float que_size;
float markers_loaded;
float no_change;
//entity new_m_G;	// new marker Goal
float goal_index;
entity m;
vector m_pos;
entity load_position1, load_position2, load_position3, load_position4, load_position5;
entity load_position6, load_position7, load_position8, load_position9, load_position10;
entity load_position11, load_position12, load_position13, load_position14, load_position15;
entity load_position16, load_position17, load_position18, load_position19, load_position20;
entity current_load_position;

entity m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20;
entity m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32,m33,m34,m35,m36,m37,m38,m39,m40;
entity m41,m42,m43,m44,m45,m46,m47,m48,m49,m50,m51,m52,m53,m54,m55,m56,m57,m58,m59,m60;
entity m61,m62,m63,m64,m65,m66,m67,m68,m69,m70,m71,m72,m73,m74,m75,m76,m77,m78,m79,m80;
entity m81,m82,m83,m84,m85,m86,m87,m88,m89,m90,m91,m92,m93,m94,m95,m96,m97,m98,m99,m100;
entity m101,m102,m103,m104,m105,m106,m107,m108,m109,m110,m111,m112,m113,m114,m115,m116,m117,m118,m119,m120;
entity m121,m122,m123,m124,m125,m126,m127,m128,m129,m130,m131,m132,m133,m134,m135,m136,m137,m138,m139,m140;
entity m141,m142,m143,m144,m145,m146,m147,m148,m149,m150,m151,m152,m153,m154,m155,m156,m157,m158,m159,m160;
entity m161,m162,m163,m164,m165,m166,m167,m168,m169,m170,m171,m172,m173,m174,m175,m176,m177,m178,m179,m180;
entity m181,m182,m183,m184,m185,m186,m187,m188,m189,m190,m191,m192,m193,m194,m195,m196,m197,m198,m199,m200;
entity m201,m202,m203,m204,m205,m206,m207,m208,m209,m210,m211,m212,m213,m214,m215,m216,m217,m218,m219,m220;
entity m221,m222,m223,m224,m225,m226,m227,m228,m229,m230,m231,m232,m233,m234,m235,m236,m237,m238,m239,m240;
entity m241,m242,m243,m244,m245,m246,m247,m248,m249,m250,m251,m252,m253,m254,m255,m256,m257,m258,m259,m260;
entity m261,m262,m263,m264,m265,m266,m267,m268,m269,m270,m271,m272,m273,m274,m275,m276,m277,m278,m279,m280;
entity m281,m282,m283,m284,m285,m286,m287,m288,m289,m290,m291,m292,m293,m294,m295,m296,m297,m298,m299,m300;


//
// goals
//
float NUMBER_GOALS = 24;

.entity G1_, G2_, G3_, G4_, G5_, G6_, G7_, G8_, G9_, G10_, G11_, G12_, G13_, G14_, G15_, G16_;
.entity G17_, G18_, G19_, G20_, G21_, G22_, G23_, G24_;

// time to goals
.float G1_time, G2_time, G3_time, G4_time, G5_time, G6_time, G7_time, G8_time;
.float G9_time, G10_time, G11_time, G12_time, G13_time, G14_time, G15_time, G16_time;
.float G17_time, G18_time, G19_time, G20_time, G21_time, G22_time, G23_time, G24_time;

// goal number
.float G_;
float goal_number;
entity test_goal;

.entity virtual_goal;

//
// zones
//
float NUMBER_ZONES = 16;

.entity Z1_, Z2_, Z3_, Z4_, Z5_, Z6_, Z7_, Z8_, Z9_, Z10_, Z11_, Z12_, Z13_, Z14_, Z15_, Z16_;

// time to zones
.float Z1_time, Z2_time, Z3_time, Z4_time, Z5_time, Z6_time, Z7_time, Z8_time;
.float Z9_time, Z10_time, Z11_time, Z12_time, Z13_time, Z14_time, Z15_time, Z16_time;

// zone number
.float Z_;

.entity Z_head;
.entity Z_next;

entity Z1_head, Z2_head, Z3_head, Z4_head, Z5_head, Z6_head, Z7_head, Z8_head;
entity Z9_head, Z10_head, Z11_head, Z12_head, Z13_head, Z14_head, Z15_head, Z16_head;

entity Z1_tail, Z2_tail, Z3_tail, Z4_tail, Z5_tail, Z6_tail, Z7_tail, Z8_tail;
entity Z9_tail, Z10_tail, Z11_tail, Z12_tail, Z13_tail, Z14_tail, Z15_tail, Z16_tail;

float Z1_S_index, Z2_S_index, Z3_S_index, Z4_S_index, Z5_S_index, Z6_S_index, Z7_S_index, Z8_S_index;
float Z9_S_index, Z10_S_index, Z11_S_index, Z12_S_index, Z13_S_index, Z14_S_index, Z15_S_index, Z16_S_index;


//
// sub-zones
//
float NUMBER_SUBZONES = 32;

.float S1_time, S2_time, S3_time, S4_time, S5_time, S6_time, S7_time, S8_time;
.float S9_time, S10_time, S11_time, S12_time, S13_time, S14_time, S15_time, S16_time;
.float S17_time, S18_time, S19_time, S20_time, S21_time, S22_time, S23_time, S24_time;
.float S25_time, S26_time, S27_time, S28_time, S29_time, S30_time, S31_time, S32_time;

float S_index;

// sub-zone number
.float S_;

//
// tasks
//
.float Z1_task;


.float goal_respawn_time;

.void() sub_arrival_time;
.entity() zone_marker;
//.entity() next_marker;
.void() desire;
.float saved_goal_desire;
.float saved_respawn_time;
.float saved_goal_time;

entity from_marker;
entity middle_marker;
entity to_marker;

entity goal_entity;

.float goal_refresh_time;		// when must recheck goals

.float total_damage;
.float firepower;
//.float toughness;

float toughness_;

float items_;
float weapon_;
float	am;
float attackbonus;
float firepower_;

float	save;
float	take;

.float desire_armor1;
.float desire_armor2;
.float desire_armorInv;
.float desire_health0;
.float desire_health2;
.float desire_supershotgun;
.float desire_nailgun;
.float desire_supernailgun;
.float desire_grenadelauncher;
.float desire_rocketlauncher;
.float desire_lightning;
.float desire_rockets;
.float desire_cells;
.float desire_nails;
.float desire_shells;

float maxplayers;

#ifdef QUAKE
float score_pos_;
#endif // QUAKE

.entity touch_marker;
.float touch_distance;

entity touch_marker_;

#ifdef QUAKE
.float spawn_skin;
#endif // QUAKE
.float color_;
.float teamcolor;
.float bot_skill;
.float admin_code;
.float lines;
.float input_time;

.float mouse_accel;
.float dodge_amount;
.float mouse_vel;
.float lookahead_time;
.float prediction_error;
.float look_anywhere;
.float stop_turn_speed;
.float accuracy;
.float firing_reflex;
.float cheat_aim;

float lookahead_time_;
float prediction_error_;
vector origin_;

float impulse_;

float time_start;
float framecount_start;
float real_frametime;
float sv_accelerate;
float sv_maxfriction;
float sv_accelerate_frametime;
float timelimit;
float fraglimit;
float sv_maxspeed;
float half_sv_maxspeed;
float inv_sv_maxspeed;
float sv_maxstrafespeed;
float quad_factor;

float sv_friction;
float sv_friction_frametime;
float inv_sv_friction_framtime;
float sv_friction_frametime_100;

#ifdef QUAKE
float inv_sv_friction_framtime_2;
float sv_friction_frametime_200;
float double_friction;
#endif // QUAKE

#ifdef QUAKEWORLD
float old_time;
#endif // QUAKEWORLD

float distance;
vector hor_velocity;
float hor_speed;
float last_clear_hor_speed;
vector hor_direction;
vector dir_forward;
float current_maxspeed;
float velocity_forward;
float accel_forward;
float max_accel_forward;
vector desired_accel;
float arrow_;
float yaw;
float dist;
vector new_velocity;
vector new_origin;
float oldflags;
float current_arrow;
float content;
float content1;
float content2;
float content3;
float fall;
float new_fall;
float current_fallspot;
vector edge_normal;
float normal_comp;
float best_dotproduct;
float best_arrow;
float test_forward;
float test_forward_left;
float test_forward_right;
float test_right;
float test_left;
float test_back;
float test_back_left;
float test_back_right;
vector self_view;
vector testplace;
vector hor_velocity;
float dist_inc;
float tries;
vector last_clear_point;
vector last_clear_velocity;
float jumpspeed;
vector dir_move;
float desired_yaw;
float yawerror;
float path_score;
float total_goal_time;
entity goal_marker2;
vector self_dir;
float best_score;
entity best_goal;
entity best_goal_marker;
float best_goal_desire;
float best_goal_time;
float best_score2;
entity best_goal2;
float goal_desire;
float enemy_desire;
float enemy_repel;
float best_goal_score;
float current_goal_time;
float current_goal_time_125;
float best_respawn_time;
entity goalentity_marker;	// closest marker to self.goalentity (dynamically changes)
float goal_late_time;
entity linked_marker_;
vector linked_marker_origin;
vector dir_look;
float goal_score;
float goal_score2;
float goal_time2;
float same_dir;
float avoid;
vector marker_pos;
float look_score;
float enemy_score;
vector rel_pos;
vector rel_pos2;
vector rel_dir;
float rel_dist;
vector rel_hor_dir;
vector desired_angle;
float hor_component;
vector angle_error;
float try_shoot;
entity enemy_touch_marker;
entity touch_marker_;
float new_health;
vector src;
entity missile;
vector direction;
vector desired_angle;
vector angle_error;
float predict_desired_yaw;
float predict_yaw_error;
vector rel_pos;
float rel_dist;
float risk;
float risk_factor;
float risk_strength;
vector rocket_origin;
float weapon_speed;
float splash_damage;
float shaft_available;
vector rel_pos;
vector enemy_angles;
float avoid_rockets;
entity grenade_marker;
float desired_weapon;
entity bot;
float rnd;
float minutes;
float seconds;
float time_to_print;
entity spawn_pos;
float attacker_damaged;
float attacker_damage;
entity spots;
float pcount;
entity thing;
float numspots;
float totalspots;
entity t;
vector vec1;
vector vec2;
vector vec_;
entity think_ent;
entity trigger;
vector cmins;
vector cmaxs;
entity trigger;
entity item;
vector tmin;
vector tmax;
float or;
float nr;
float leave;
float best_weapon;
entity new_bot;
float frogbot_number;
float score_count;
vector item_pos;
entity closest_marker;
float shortest_distance;
vector marker_pos;
entity marker_;
entity marker2;
float zone_time;
entity load_position;
float real_yaw_;
entity fireball;
entity bubble;
entity bubble_spawner;
vector org_;
float rnd1;
float rnd2;
float rnd3;
float character;
float block_;
float char_count;
float word_count;
float spawnflags_;
float digit;
float exponent;
float previous_exponent;
entity target_;
float traveltime;
float traveltime2;
float traveltime2;
entity flag_self;
float flag_pos;
entity flag1;
entity flag2;
entity tfog;
vector weapons_vel;
entity death;
entity trace_ent1;
entity trace_ent2;
entity old_self;
float forward;
string deathstring;
string deathstring2;
entity removebot_self;
float min_first;
float min_second;
vector start;
vector end;
float description;
float goal_time;
float path_time;
entity test_marker;
float component_speed;
float do_jump;

entity killed_self;
entity rune_self;
entity fallspot_self;
entity door_enemy;

#ifdef QUAKE
entity unhook_self;
entity lists_self;
entity bodyque_entry;
#endif // QUAKE

entity multi_ent;
float	multi_damage;

vector  blood_org;

#ifdef QUAKEWORLD
float   blood_count;
vector  puff_org;
float   puff_count;

float clientpants;
float clientshirt;
#endif // QUAKEWORLD

.float hit_z;

#ifdef QUAKE
vector test_point;
vector arrow_velocity;	// arrow key input velocity
#endif // QUAKE


float load_frogbots;
float frogbot_removetime;

.float number_bots;

float invalid_map;
float frogbot_load_stage;

#ifdef QUAKE
float NUMBER_LOAD_STAGE = 6;
#endif // QUAKE

#ifdef QUAKEWORLD
float NUMBER_LOAD_STAGE = 8;
#endif // QUAKEWORLD

float NUMBERHARDBOTS = 16;

float	intermission_running;
float	intermission_exittime;

entity bodyque_head;

#ifdef QUAKE
entity bodyque_client;
entity first_bodyque;
#endif // QUAKE

.float dmgtime;

float rocket_alert;
vector rocket_endpos;

#ifdef QUAKE
float host_framerate;
#endif // QUAKE

string nextmap;

entity postphysics;


// match variables
float use_ammo;
float available_weapons;
float pre_game;
float start_time;
float real_time;
float time_left;
float minutes_left;

.float block0;
.float block1;
.float block2;
.float block3;
.float block4;

#ifdef QUAKEWORLD
.float skin0;
.float skin1;
.float skin2;
#endif // QUAKEWORLD

.float spawnbit0;
.float spawnbit1;
.float number_spawnbits;

float spawnbit0_;
float spawnbit1_;

float registered;

float check_parm_time;

.float letter_index;

// KasCam ->
#ifdef QUAKE
.float pausetime;
.float search_time;
.float attack_state;
#endif // QUAKE
// KasCam <-

.entity movetarget;

#ifdef QUAKE
float SPAWN_SIZE = 4;
#endif // QUAKE

#ifdef QUAKEWORLD
float SPAWN_SIZE = 1;
#endif // QUAKEWORLD

// sharing AI
.entity touchPlayer;
.float touchPlayerTime;

// unstick AI
float unstick_time;
float no_bots_stuck;

// hit wall in flight prediction AI
float first_trace_fraction;
vector first_trace_plane_normal;

// air turning prediction AI
float turning_speed;
vector hor_normal_vec;
float radian_turning_speed;
vector last_clear_angle;
vector velocity_hor_angle;

// preferences
.float preferences;

float PREF_FLASH		= 1;


.void end_remove_fieldnames_;


//
// manual only stuff
//

#ifdef MANUAL

entity active_marker;

float manual_mode;
.entity display;

float mode;
float path_mode;
float type_mode;

//
// mode values
//

float ONE_WAY			= 1;
float STATIC_ACTIVE_MARKER	= 2;
float CONNECT_MARKERS		= 4;
float CLOSEST_MARKER		= 8;
float DISPLAY_TRAVEL_TIME	= 16;
float DISPLAY_ZONE		= 32;
float DISPLAY_TYPE		= 64;

float log_number;
float log_m_Z;
entity save_position;
entity virtual_marker;
float Z_index;

#endif // MANUAL
