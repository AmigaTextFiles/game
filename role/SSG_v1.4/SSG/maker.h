/*
	Solar systems constants
*/
#define	MAX_STAR	      4
#define MAX_PLANET	    20
#define MAX_MOON        20
#define NAMESTRLENGTH	  10
#define GRAVCON		      0.000014253542
#define EARTHSIZE	      12756
#define MAX_GAS		      4
#define MAX_MINERALS	  6
#define MAX_PLANET_SIZE 18000
#define BASE_MOON_SIZE  10000
#define AU_CON		      149.6
#define AVAILABLE       0
#define NO_OBJECT       1
#define NO_PLANET       2

#define grav(s,d) 	(s*d*GRAVCON)
#define calcbas(bas) (pow(bas,4.0)/10000)
#define calcsiz(bas,siz) ((bas*2*siz*BASE_MOON_SIZE)/(siz+40000))
#define yearl(d,m) (sqrt(pow(d,3.0)/m))
#define rnd(range) (rand()%range)
#define FreeRMem(key) FreeRemember(&key,TRUE)
#define NEW(s) (s *)AllocRemember(&MemKey,sizeof(s),MEMF_CLEAR);

struct Satelite {
  int   star;         /* Number of star this object rotates */
	int   diameter;     /* Size of satelite (in km.) */
	int   axial;        /* Satelites axial tilt (determines seasons) */
	int   daylength;    /* Time to complete one rotation around own axis */
	int   yearlength;   /* Time to complete one rotation around sentral sun */
	int   atmospress;   /* Pressure (simple) */
	int   climate;      /* Only important in biozone */
	int   liquidsurf;   /* The amount of surface covered in some liquid */
	int   humidity;     /* Only with a atmosphere */
	int   terrain[2];   /* The two most common terrain types */
  int   biosphere;    /* Life? */
	int   atmostype;    /* ? */
	int   atmosgas[MAX_GAS]; /* type of gas making up the atmosphere */
	int   atmosper[MAX_GAS]; /* percentage of each gas type */
	int   minerals[MAX_MINERALS]; /* available minerals */
	double density;     /* objects density (in g/cm³) */
  double orbdis;      /* distance to central STAR */
  int   orbit;        /* orbit number (around STAR) */
  int   sorbit;       /* sub system orbit number (for planets (-1) & moons(>=0)) */
  int   tag;          /* mysteriouse internal tag used for nameing planets */
};

struct Star {
	int type;                   /* Type of star; Oh, Be A Fine Girl, Kiss Me */
  int spec;                   /* Spectral class of star (0-9) */
	int size;                   /* Size of star */
  int age;                    /* Age of star (not used) */
	double bcon;                /* Bode's constant for this system */
	double dcon;                /* Initial Bode's constant */
  double orbdis;              /* distance to central object */
  int orbit;                  /* The orbital position of this star (-1 if this is the primary star, -2 if not in use) */
	int mother;                 /* The star this star orbits (-1 if it is the primary star */
};

struct StarData {
  double mass;    /* typical mass of this startype */
  double ibio;    /* lower limit of biozone */
  double obio;    /* upper limit of biozone */
  double inner;   /* minimum distance of a planet to the star (in AU) */
  double radius;  /* radius of star (in AU) */
  int    planets; /* chance that system has planets */
  int    number;  /* number of planets if it has */
  int    life;    /* chance of native life (in biozone) */
};
