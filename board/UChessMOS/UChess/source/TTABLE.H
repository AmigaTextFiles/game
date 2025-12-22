/************************* Tuning parameters ****************************/

/*
 * ttblsz can be a any size. Setting ttblsz 0 removes the transposition
 * tables.
 */
//#ifdef MSDOS
//#define ttblsz 8001
//#else
//#define ttblsz 150001
//#endif /* MSDOS */
#define MINTTABLE (8000)	/* min ttable size -1 */
//#define MAXrehash (7)

#if defined MORESTATS
#if !defined HASHSTATS
#define HASHSTATS			/* Enable hash statistics */  
#endif
#endif
#if defined AGING
#define NEWAGE (8)
#endif

#ifdef BAREBONES /* Remove all stats for RAW speed */
#undef   HASHSTATS
#endif /* BAREBONES */

/************************* Hash table stuf ****************************/
extern /*unsigned*/ SHORT rehash;  /* main.c */ /* -1 is used as a flag --tpm */
//extern unsigned long ttblsize; /* main.c */
extern UTSHORT  newage;

#if ttblsz
extern void Initialize_ttable (void);
extern void ZeroTTable (int iop); /* iop: 0= clear any, 1= clear agged */
extern int
      ProbeTTable (int side,
	    int depth,
	    int ply,
	    SHORT *alpha,
	    SHORT *beta,
	    SHORT *score);
extern int
      PutInTTable (int side,
		int score,
		int depth,
		int ply,
		//int alpha,
		int beta,
		unsigned int mv);
#else
#define Initialize_ttable(void)
#define ZeroTTable(iop)
#define ProbeTTable(side,depth,ply,alpha,beta,score) (false)
#define PutInTTable(side,score,depth,ply,alpha,beta,mv) (false)
#endif /* ttblsz */

/************************* Hash File Stuf ****************************/

#ifdef HASHFILE
extern FILE *hashfile;  /* search.c: test if hashfile is opened */

extern int
      ProbeFTable (SHORT side,
		    SHORT depth,
		    SHORT ply,
		    SHORT *alpha,
		    SHORT *beta,
		    SHORT *score);
extern void
      PutInFTable (SHORT side,
		    SHORT score,
		    SHORT depth,
		    SHORT ply,
		    SHORT alpha,
		    SHORT beta,
		    UTSHORT f,
		    UTSHORT t);


extern void TestHashFile();
extern void CreateHashFile(long sz);
extern void OpenHashFile();
extern void CloseHashFile();
#else /* Define null ops so we dont need ifdefs */
//#define hashfile (NULL)
//#define OpenHashFile()
//#define CloseHashFile()
//#define ProbeFTable(side,depth,ply,alpha,beta,score) (0)
//#define PutInFTable(side,score,depth,ply,alpha,beta,f,t)
#endif /* HASHFILE */


/************************hash code stuff **************************/
//struct hashval
//  {
//	 unsigned long key, bd;
//  };

extern struct hashval hashcode[2][7][64];
extern void InitHashCode(unsigned int seed);

/*
 * hashbd contains a 32 bit "signature" of the board position. hashkey
 * contains a 16 bit code used to address the hash table. When a move is
 * made, XOR'ing the hashcode of moved piece on the from and to squares with
 * the hashbd and hashkey values keeps things current.
 */
extern unsigned long hashkey, hashbd;

#define UpdateHashbd(side, piece, f, t) \
{\
  if ((f) >= 0)\
    {\
      hashbd ^= hashcode[side][piece][f].bd;\
      hashkey ^= hashcode[side][piece][f].key;\
    }\
  if ((t) >= 0)\
    {\
      hashbd ^= hashcode[side][piece][t].bd;\
      hashkey ^= hashcode[side][piece][t].key;\
    }\
}

extern void gsrand (unsigned int);
extern unsigned int urand (void);

/************************* Repitition hash table ****************************/

extern SHORT ISZERO;
extern SHORT rpthash[2][256];
extern void ZeroRPT (void);
#define ProbeRPThash(side,hashkey) (rpthash[side][hashkey & 0xFF] > 0)
#define IncrementRPThash(side,hashkey) {rpthash[side][hashkey & 0xFF]++;ISZERO++;}
#define DecrementRPThash(side,hashkey) {rpthash[side][hashkey & 0xFF]--;ISZERO--;}

/************************* Evaluation cache ********************************/

#ifndef AMIGA
#ifdef CACHE
	struct etable
	{ unsigned long ehashbd;
		tshort escore[2];
		tshort sscore[64];
		tshort score;
		tshort hung[2];
	} ;
extern struct etable *etab[2];
extern UTSHORT ETABLE;
#endif
#endif //amiga

/************************* Hash table statistice ****************************/

#ifdef HASHSTATS
void ClearHashStats();	/* initialize the stats */
void ShowHashStats();	/* print the stats */
extern long EADD, EGET; /* Evaluation cache stats counters */
extern unsigned long HashCnt, HashAdd, FHashCnt, FHashAdd, HashCol, THashCol;
#else
	#define ClearHashStats()		/* stats calls ignored */
	#define ShowHashStats()
#endif
