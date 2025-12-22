// Defines

#define IMP_SCREEN_NAME   "IMP.SCREEN"
#define IMPSHARE_NAME     "ImpShare"
#define SNAPSHOT_FILE	  "ImpPro:Data/ImpPro.snapshots"

// Data directories in ImpPro

#define SAVE_DIRECTORY    "ImpPro:Save"
#define DATA_DIRECTORY	  "ImpPro:Data"
#define MODULES_DIRECTORY "ImpPro:Modules"
#define SCRIPT_DIRECTORY  "ImpPro:Scripts"

// Shared library stuff

#define IMPLIBNAME		"imppro.library"
#define IMPLIBVERSION		5

// Module IDs used for inter-module communication

#define MOD_LAUNCHER	MAKE_ID('L', 'A', 'U', 'N')
#define MOD_DICE	MAKE_ID('D', 'I', 'C', 'E')
#define MOD_CLOCK	MAKE_ID('C', 'L', 'O', 'C')
#define MOD_ENCOUNTER	MAKE_ID('E', 'N', 'C', 'O')
#define MOD_CHARACTER	MAKE_ID('C', 'H', 'A', 'R')
#define MOD_DUNGEON	MAKE_ID('D', 'U', 'N', 'G')
#define MOD_GAMELOG	MAKE_ID('G', 'L', 'O', 'G')
#define MOD_NAME	MAKE_ID('N', 'A', 'M', 'E')
#define MOD_CITY	MAKE_ID('C', 'I', 'T', 'Y')
#define MOD_TREASURE	MAKE_ID('T', 'R', 'E', 'A')
#define MOD_HORSE	MAKE_ID('H', 'O', 'R', 'S')

// Timestruct

#define TS_PARTS       6

#define TS_DAYS        0
#define TS_HOURS       1
#define TS_TURNS       2
#define TS_ROUNDS      3
#define TS_SEGS        4
#define TS_SECS        5

struct TimeStruct {
        int raw;
        int value[TS_PARTS];
};

// ImpPro shared semaphore, allocated by launcher on startup.  WILL GROW!

struct ImpShare {
        struct SignalSemaphore	is_Semaphore;
        int			is_RawTime;
	int			is_PartyXP;
};

// Snapshot structure used by all module to snapshot window positions to disk

struct ImpSnapshot {
	ULONG			is_ID;
	struct IBox		is_Bounds;
};

// Things for Game Log's message port

#define LOG_MESSAGE_PORT	"ImpLogPort"    // Soon this will be only the base name
#define LOG_MESSAGE_ID		100L

struct LogMessage {
	struct Message   lg_Msg;
	UBYTE 		*lg_Event;
	ULONG		 lg_ModuleID;  /* Added in version 5 of imppro.library */
};

// M A C R O S

#define DisableGadget(win, gad) SetGadgetAttrs((struct Gadget *)gad, win, NULL, GA_Disabled, TRUE, TAG_END)
#define EnableGadget(win, gad) SetGadgetAttrs((struct Gadget *)gad, win, NULL, GA_Disabled, FALSE, TAG_END)

// Prototypes for imppro.library

void 	impSeedRand(long);
int  	impRand(int);
int  	impInterpretAndRoll(STRPTR);
int  	impComputeDHTRSS(struct TimeStruct *);
int	impSetGameTimeRaw(int);
int  	impGetGameTimeRaw(void);
int  	impSetPartyXP(int);
int  	impGetPartyXP(void);
BOOL 	impLogEvent(STRPTR, ULONG);
BOOL 	impReadSnapshot(struct ImpSnapshot *);
BOOL 	impWriteSnapshot(struct ImpSnapshot *);
BOOL 	impARexxSelector(STRPTR);
BOOL 	impLaunchCommand(STRPTR);
BOOL	impLaunchCommandWait(STRPTR);
BOOL	impReturnStrSTEM(struct RexxMsg *rxm, STRPTR basename, ULONG numvars, UBYTE **varnames, UBYTE **varvalues);
BOOL	impReturnNumSTEM(struct RexxMsg *rxm, STRPTR basename, ULONG numvars, UBYTE **varvalues);
BOOL	impGotoFileLabel(BPTR fp, STRPTR label);
BOOL	impDisplayText(STRPTR);
BOOL	impDisplayPicture(STRPTR);
