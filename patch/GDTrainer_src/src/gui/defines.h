#include "PROJ:CGLE/gle.h"

/***** Version ******/

#define WINDOWTITLE		"GDTrainer v2.01"
#define VERSIONSTRING	"$VER: "				\
						WINDOWTITLE				\
						" (" __DATE__ " "  __TIME__ ") © 1997 John Girvin"


/***** Prefs ******/

typedef struct PREFS
{
	UBYTE NoGUI;
	UBYTE InfLives;
	UBYTE InfBigGun;
	UBYTE InfInvis;
	UBYTE InfThermo;
	UBYTE InfBouncy;
	UBYTE MaxBoosts;
};


/***** Gadget ID's ******/

#define	GAD_LIVES	1
#define	GAD_GUN		2
#define	GAD_INVIS	3
#define	GAD_THERMO	4
#define	GAD_BOUNCY	5
#define	GAD_GUNBOOST 6

#define	LAB_LIVES	7
#define	LAB_GUN		8
#define	LAB_INVIS	9
#define	LAB_THERMO	10
#define	LAB_BOUNCY	11
#define	LAB_GUNBOOST 12
#define	LAB_TRAINERS 13

#define	GAD_PLAY	14
#define	GAD_CANCEL	15

#define	GAD_BLANK1	16


/***** Prototypes ******/

BOOL CreateControlPanel (void);
