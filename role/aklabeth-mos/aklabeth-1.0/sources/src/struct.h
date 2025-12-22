/************************************************************************/
/************************************************************************/
/*																		*/
/*							Data Structures								*/
/*																		*/
/************************************************************************/
/************************************************************************/

typedef struct _Coord						/* Coordinate structure */
{ int x,y; } COORD;

/************************************************************************/

typedef struct _Rect						/* Rectangle structure */
{
	int left,top,right,bottom;				/* Rectangle coords */
} RECT;

/************************************************************************/

typedef struct _WorldMap					/* World Map structure */
{
	int MapSize;							/* Size of map */
	unsigned char Map[WORLD_MAP_SIZE]		/* Map information */
							[WORLD_MAP_SIZE];
} WORLDMAP;

/************************************************************************/

typedef struct _Monster						/* Monster structure */
{
	COORD Loc;								/* Position */
	int	  Type;								/* Monster type */
	int	  Strength;							/* Strength */
	int	  Alive;							/* Alive flag */
} MONSTER;

/************************************************************************/

typedef struct _DungeonMap					/* Dungeon Map Structure */
{
	int MapSize;							/* Size of Map */
	unsigned char Map[DUNGEON_MAP_SIZE]		/* Map information */
							[DUNGEON_MAP_SIZE];
	int	MonstCount;							/* Number of Monsters */
	MONSTER Monster[MAX_MONSTERS];			/* Monster records */
} DUNGEONMAP;

/************************************************************************/

typedef struct _Player						/* Player structure */
{
	char  Name[MAX_NAME+1];					/* Player Name */
	COORD World;							/* World map position */
	COORD Dungeon;							/* Dungeon map position */
	COORD DungDir;							/* Dungeon direction facing */
	char  Class;							/* Player class (F or M) */
	int   HPGain;							/* HPs gained in dungeon */
	int	  Level;							/* Dungeon level, 0 = world map */
	int	  Skill;							/* Skill level */
	int	  Task;								/* Task set (-1 = none) */
	int	  TaskCompleted;					/* Task completed */
	int	  LuckyNumber;						/* Value used for seeding */
	int	  Attributes;						/* Number of attributes */
	int	  Objects;							/* Number of objects */
	int   Attr[MAX_ATTR];					/* Attribute values */
	double Object[MAX_OBJ];					/* Object counts */
} PLAYER;
