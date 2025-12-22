/* ttable.c -- Transposition table code to be included in search.c */
/* #include "gnuchess.h" /* already included, see search.c */
/* #include "ttable.h" /* dito */
/* NOTE: The static evaluation cache "EETable" belongs to eval.c and cannot*/
/*       be moved to ttable.c */
/* Privae types and data */

#include <proto/exec.h>
#include <exec/memory.h>
#include <proto/dos.h>

//#define TT_EXPIRATION 40000 // nominal exp node value

#ifndef AMIGA
struct hashentry
     {
       unsigned long hashbd;
       UCHAR flags, depth;      /* CHAR saves some space */
       tshort score;
       utshort mv;
#ifdef HASHTEST
       UCHAR bd[32];
#endif /* HASHTEST */
#ifdef NEWAGE
	utshort age;        /* age of last use */
#endif
     };
unsigned long ttblsize;
#endif // AMIGA

extern struct hashentry huge __aligned *ttable[2];

/* unsigned */ extern SHORT __aligned rehash;  /* -1 is used as a flag --tpm */
#ifdef NEWAGE
        utshort TTage;        /* Current ttable age */
        UTSHORT TTageClock,    /* Count till next age tick */
                TTageRate;      /* new entry counts per age tick */
        UTSHORT TTdepthage[MAXDEPTH+1];    /* Depth bonus for aging*/
        UTSHORT newage = NEWAGE;    /* Initialization tuning parameter */
        extern unsigned int __aligned TTadd;
#else
unsigned int ttbllimit;
extern unsigned int TTadd;
#endif

#ifdef HASHSTATS
unsigned long ttdepthin[MAXDEPTH+1], ttdepthout[MAXDEPTH+1];
unsigned long ttrehash[MAXrehash+1];
unsigned long ttprobe[MAXDEPTH+1];
unsigned long HashCnt, HashAdd, FHashCnt, FHashAdd, HashCol, THashCol;
#endif

/* hashtable flags */
#define truescore 0x0001
#define lowerbound 0x0002
#define upperbound 0x0004
#define kingcastle 0x0008
#define queencastle 0x0010
#define evalflag 0x0020


void
Initialize_ttable ()
{
  char astr[32];
  int doit = true;

  if (rehash < 0) rehash = MAXrehash;
while(doit && ttblsize >= (1<<13)){
  ttable[0] = (struct hashentry *)malloc(sizeof(struct hashentry)*(ttblsize+rehash));
  ttable[1] = (struct hashentry *)malloc(sizeof(struct hashentry)*(ttblsize+rehash));
  if(ttable[0] == NULL || ttable[1] == NULL){
  if(ttable[0] != NULL)free(ttable[0]);
  ttblsize = ttblsize>>1;
  } else doit = false;
}
  if(ttable[0] == NULL || ttable[1] == NULL)
   {
    ShowMessage("Critical Mem Failure");
    Delay(100L);
    AmigaShutDown();
    exit(1);
   }
  else {
#ifdef NEWAGE
	int j;
        unsigned long k;
#endif
        sprintf(astr,"transposition tbl is %d\n",ttblsize);
        ShowMessage(astr);
#ifdef NEWAGE
	/* WARNING: Bogus parameters ahead!
	 * The numbers that follow are based on pure fiction
	 * and are not contaminated with facts
	 */
	TTageRate = ttblsize/3000 + 1; // try 3k, 1500 and 5000 and see
					// which gives lowest node cnts
	TTdepthage[0] = 32768;
	for (j=1, k = 50; j<=MAXDEPTH; j++, k *= (13-j))
	  {
	    /* Maximum k = 50 * 11! ~= 2^31 (this is a fact) */
	    TTdepthage[j] = (TTdepthage[j-1] > k/TTageRate) ?
		TTdepthage[j-1] - k/TTageRate : 0;
	  }
#else
	ttbllimit = ttblsize<<1 - ttblsize>>2;
#endif
  }
}

#define CB(i) (UCHAR) ((color[2 * (i)] ? 0x80 : 0)\
	| (board[2 * (i)] << 4)\
	| (color[2 * (i) + 1] ? 0x8 : 0)\
	| (board[2 * (i) + 1]))

int __inline
ProbeTTable (int side,
	     int depth,
	     int ply,
	     SHORT *alpha,
	     SHORT *beta,
	     SHORT *score)

/*
 * Look for the current board position in the transposition table.
 */

{
  register struct hashentry *ptbl;
  register /*unsigned*/ SHORT i = 0;	/*to match new type of rehash --tpm*/

#ifndef NEWAGE
  ptbl = &ttable[side][hashkey % ttblsize];
  while (true)
    {
      if (ptbl->depth == 0) return false;
      if (ptbl->hashbd == hashbd) break;
      if (++i > rehash) return false;
      ptbl++;
    }
#else
  for (i=rehash, ptbl = &ttable[side][hashkey % ttblsize];
		ptbl->hashbd != hashbd; ptbl++)
    if (--i == 0) return false;
  /* Update age of rediscovered node */
  ptbl->age = TTage - TTdepthage[ptbl->depth];
#endif

  PV = SwagHt = ptbl->mv;
  if ((ptbl->depth >= (short) depth))
    {
      if (ptbl->flags & truescore)
	{
	  *score = ptbl->score;
	  /* adjust *score so moves to mate is from root */
	  if (*score > 9000) *score -= ply;
	  else if (*score < -9000) *score += ply;
	  *beta = -20000;
	}
      else if (ptbl->flags & lowerbound)
	{
	  if (ptbl->score > *alpha)
	    *alpha = ptbl->score;
	}
      return (true);
    }
  return (false);
}

int __inline
PutInTTable 
		(int side,
	     int score,
	     int depth,
	     int ply,
	     //int alpha,
	     int beta,
	     unsigned int mv)

/*
 * Store the current board position in the transposition table.
 */

  {
	register struct hashentry *ptbl,*oldest;
        unsigned short old;
	register /*unsigned*/ SHORT i = 0;	/*to match new type of rehash --tpm*/

#ifdef NEWAGE
	i=rehash;
	old = 0;
	ptbl = &ttable[side][hashkey % ttblsize];
	while (true)
	  {
	    if (ptbl->hashbd == hashbd)
	      {
	        if(ptbl->depth > (UCHAR)depth) return false;
	        else break;
	      }
 	    if (((TTage - ptbl->age) /*& 0xFFFF*/) > old) 
	      {
	        old = (TTage - ptbl->age)/* & 0xFFFF*/;
	        //if (old > TT_EXPIRATION) break; /* Use this expired entry */
	        oldest = ptbl;
	      }
	    if (--i == 0)
	      {
	        ptbl = oldest;
	        break;
	      }
	    ptbl++;
	  }
 
	if (--TTageClock == 0)
	  {
	    TTageClock = TTageRate;
	    TTage++;  /* Everyone is now just a little older */
	  }
        TTadd++;
	/* Update age of this node */
	ptbl->age = TTage - TTdepthage[ptbl->depth];
#else
	TTadd++;
#endif
#ifdef HASHSTATS
	HashAdd++;
#endif
	if(ptbl->depth > (UCHAR)depth) return false;
	ptbl->hashbd = hashbd;
	ptbl->depth = (UCHAR) depth;
	ptbl->score = score;
	ptbl->mv = mv;
	if (score > beta)
	  {
		ptbl->flags = lowerbound;
		ptbl->score = beta + 1;
	  }
	else
 	  {
                /* adjust score so moves to mate is from this ply */
 	        if (score > 9000) score += ply;
 	        else if (score < -9000 && score != -9999) score -= ply;
                ptbl->score = score;
  		ptbl->flags = truescore;
 	  }

	return true;
  }

void
ZeroTTable (int iop) /* iop: 0= clear any, 1= clear agged */
  {
#ifdef NEWAGE
	if(iop==0)
	  {
		TTageClock = TTageRate;
		TTage = TTdepthage[0]+1; /* used to be newage + 1Zero entries are pre-expired. */
                //TTage = TT_EXPIRATION + 1;
		//TTageRate = ttblsize/(newage/2); /* Average 1/2 of table will be expired */
		/* zero the age of all ttable entries */
	        if (!TTadd)
	         return;
#ifdef AMIGA
  ClearMem(ttable[0],sizeof(struct hashentry)*(ttblsize+rehash));
  ClearMem(ttable[1],sizeof(struct hashentry)*(ttblsize+rehash));
#else
  memset(ttable[white],0,sizeof(struct hashentry)*(unsigned)(ttblsize+rehash));
  memset(ttable[black],0,sizeof(struct hashentry)*(unsigned)(ttblsize+rehash));
#endif
	       TTadd = 0;
	  }
#ifdef ZERO_1_DOES
	else
          {
		/* Just add a major increment to TTage */
		TTage += (TTdepthage[0] - TTdepthage[MAXDEPTH-1]);  /* Just a guess */
          }
#endif
#else /* not NEWAGE */
	if ((iop==0 && TTadd) || TTadd > ttbllimit)
	  {
#ifdef AMIGA
  ClearMem(ttable[0],sizeof(struct hashentry)*(ttblsize+rehash));
  ClearMem(ttable[1],sizeof(struct hashentry)*(ttblsize+rehash));
#else
  memset(ttable[white],0,sizeof(struct hashentry)*(unsigned)(ttblsize+rehash));
  memset(ttable[black],0,sizeof(struct hashentry)*(unsigned)(ttblsize+rehash));
#endif
	    TTadd = 0;
      }
#endif /* NEWAGE */

}

/************************* Hash table statistics ****************************/

#ifdef HASHSTATS
long EADD,EGET;	/* Eval cache stats */

void
ClearHashStats()	/* initialize the stats */
  {
	memset ((CHAR *) ttdepthin, 0, sizeof (ttdepthin));
	memset ((CHAR *) ttdepthout, 0, sizeof (ttdepthout));
	memset ((CHAR *) ttrehash, 0, sizeof (ttrehash));
	memset ((CHAR *) ttprobe, 0, sizeof (ttprobe));
	HashAdd = HashCnt = THashCol = HashCol = FHashCnt = FHashAdd = 0;
	EADD = EGET = 0;
  }

void
ShowHashStats()	/* print the stats */
  {
	int ii;
	printf("Probe: ");
	for(ii=0;ii<MAXDEPTH;ii++)
		if (ttprobe[ii])
			printf(" %d:%ld", ii, ttprobe[ii]);
	printf("\nIn/Out: ");
	for(ii=0;ii<MAXDEPTH;ii++)
		if (ttdepthin[ii] || ttdepthout[ii])
			printf(" %d:%ld/%ld", ii, ttdepthin[ii], ttdepthout[ii]);
	printf("\nRehash: ");
	for(ii=0;ii<=MAXrehash;ii++)
		printf(" %ld", ttrehash[ii]);
	printf("\n");
	printf (CP[71],
		HashAdd, HashCnt, THashCol, HashCol,FHashCnt, FHashAdd);
#ifdef CACHE
	printf ("cache in/out: %ld/%ld\n", EADD, EGET);
#endif
  }
#endif

/************************* Hash File Stuf ****************************/
#ifdef HASHFILE
#define frehash 6

     struct fileentry
     {
       UCHAR bd[32];
       UCHAR f, t, flags, depth, sh, sl;
     };

FILE *hashfile = NULL;
unsigned long HFileSize;		/* Nunber of fileentry records in hash file */

void 
CreateHashFile(long sz)
/* NOTE: If sz is Odd the black and white positions will be
   scrambled (Is this good or bad?) */
  {
	if (hashfile = fopen (HASHFILE, RWA_ACC))	/* old file */
	  {	/* chech size, warn if shrinking? */
		fseek (hashfile, 0L, SEEK_END);
		HFileSize = ftell (hashfile) / sizeof (struct fileentry);
		if (sz < HFileSize) sz = HFileSize;
		fseek (hashfile, 0L, SEEK_SET);
	  }
	else if (sz)
	  {	/* create new file only if we have a size */
		hashfile = fopen (HASHFILE, WA_ACC);
	  }
	if (hashfile != NULL)
	  {
		long j;
		struct fileentry n[64]; /* Write a bunch at a time */
		
		printf (CP[66]);
		memset ((CHAR *) n, 0, sizeof (n));
/*		n.f = n.t = 0; */
/*		n.flags = 0; */
/*		n.depth = 0; */
/*		n.sh = n.sl = 0; */
		for (j = 0; j < sz; j += 64)
			fwrite (&n, sizeof (struct fileentry), sz-j<64 ? sz-j: 64, hashfile);
		fclose (hashfile);
		hashfile = NULL;
	  }
	else
		printf (CP[50], HASHFILE);
  }
  
void 
OpenHashFile() /* try to open hash file */
  {
	hashfile = fopen (HASHFILE, RWA_ACC);
	if (hashfile)
	  {
		fseek (hashfile, 0L, SEEK_END);
		HFileSize = ftell (hashfile) / sizeof (struct fileentry);
	  }
#if !defined CHESSTOOL && !defined XBOARD
	else
		ShowMessage (CP[98]);
#endif
  }

void
CloseHashFile()
  {
  	/* remember to write accumulated statistics if we keep such */
	if (hashfile)
		fclose (hashfile);
	hashfile = NULL;
  }
  
void 
TestHashFile()
  {
	int iopendit = false;
	if (!hashfile)
	  {
		OpenHashFile();
		iopendit = (hashfile != NULL);
	  }
	if (hashfile)
	  {
		int i; 
		long j;
		long nr[MAXDEPTH+1];
		struct fileentry n;
		
		printf (CP[49]);
		for (i = 0; i < MAXDEPTH; i++)
			nr[i] = 0;
		fseek (hashfile, 0L, SEEK_SET);
		for (j = 0; j < HFileSize; j++)
		  {
			fread (&n, sizeof (struct fileentry), 1, hashfile);
			if (n.depth > MAXDEPTH){printf("ERROR\n");exit(1);}
			if (n.depth)
			  {
				nr[n.depth]++;
				nr[0]++;
			  }
		  }
		printf (CP[109], nr[0], HFileSize);
		for (i = 1; i <= MAXDEPTH; i++)
			if (nr[i])
				printf (" %d:%ld", i,nr[i]);
		printf ("\n");
		if (iopendit)
			CloseHashFile();
	  }
  }

int 
Fbdcmp(UCHAR *a,UCHAR *b)
  {
	register int i;
	for(i = 0;i<32;i++)
		if(a[i] != b[i])
			return false;
	return true;
  }

int
ProbeFTable (SHORT side,
		SHORT depth,
		SHORT ply,
		SHORT *alpha,
		SHORT *beta,
		SHORT *score)

/*
* Look for the current board position in the persistent transposition table.
*/

  {
	register SHORT i;
	register unsigned long hashix;
	struct fileentry new, t;
	
	hashix = ((side == white) ? (hashkey & 0xFFFFFFFE) : (hashkey | 1)) % HFileSize;
	
	for (i = 0; i < 32; i++)
		new.bd[i] = CB (i);
	new.flags = 0;
	if (Mvboard[kingP[side]] == 0)
	  {
		if (Mvboard[qrook[side]] == 0)
			new.flags |= queencastle;
		if (Mvboard[krook[side]] == 0)
		new.flags |= kingcastle;
	  }
	for (i = 0; i < frehash; i++)
	  {
		fseek (hashfile,
			sizeof (struct fileentry) * ((hashix + 2 * i) % (HFileSize)),
			SEEK_SET);
		fread (&t, sizeof (struct fileentry), 1, hashfile);
		if (!t.depth) break;
		if(!Fbdcmp(t.bd, new.bd)) continue;
		if (((SHORT) t.depth >= depth) 
			&& (new.flags == (UTSHORT)(t.flags & (kingcastle | queencastle))))
		  {
#ifdef HASHSTATS
			FHashCnt++;
#endif
			PV = (t.f << 8) | t.t;
			*score = (t.sh << 8) | t.sl;
			/* adjust *score so moves to mate is from root */
			if (*score > 9000)
				*score -= ply;
			else if (*score < -9000)
				*score += ply;
			if (t.flags & truescore)
			  {
				*beta = -20000;
			  }
			else if (t.flags & lowerbound)
			  {
				if (*score > *alpha)
					*alpha = *score - 1;
			  }
			else if (t.flags & upperbound)
			  {
				if (*score < *beta)
					*beta = *score + 1;
			  }
			return (true);
		  }
	  }
	return (false);
  }

void
PutInFTable (SHORT side,
		SHORT score,
		SHORT depth,
		SHORT ply,
		SHORT alpha,
		SHORT beta,
		UTSHORT f,
		UTSHORT t)

/*
* Store the current board position in the persistent transposition table.
*/

  {
	register UTSHORT i;
	register unsigned long hashix;
	struct fileentry new, tmp;
	
	hashix = ((side == white) ? (hashkey & 0xFFFFFFFE) : (hashkey | 1)) % HFileSize;
	for (i = 0; i < 32; i++) new.bd[i] = CB (i);
	new.f = (UCHAR) f;
	new.t = (UCHAR) t;
	if (score < alpha)
		new.flags = upperbound;
	else
		new.flags = ((score > beta) ? lowerbound : truescore);
	if (Mvboard[kingP[side]] == 0)
	  {
		if (Mvboard[qrook[side]] == 0)
			new.flags |= queencastle;
		if (Mvboard[krook[side]] == 0)
			new.flags |= kingcastle;
	  }
	new.depth = (UCHAR) depth;
	/* adjust *score so moves to mate is from root */
	if (score > 9000)
		score += ply;
	else if (score < -9000)
		score -= ply;

	new.sh = (UCHAR) (score >> 8);
	new.sl = (UCHAR) (score & 0xFF);
	
	for (i = 0; i < frehash; i++)
	  {
		fseek (hashfile,
			sizeof (struct fileentry) * ((hashix + 2 * i) % (HFileSize)),
			SEEK_SET);
		if(fread (&tmp, sizeof (struct fileentry), 1, hashfile) == 0){perror("hashfile");exit(1);}
		if (tmp.depth && !Fbdcmp(tmp.bd,new.bd))continue;
		if ((SHORT) tmp.depth < new.depth)
		  {
			fseek (hashfile,
				sizeof (struct fileentry) * ((hashix + 2 * i) % (HFileSize)),
				SEEK_SET);
			fwrite (&new, sizeof (struct fileentry), 1, hashfile);
#ifdef HASHSTATS
			FHashAdd++;
#endif
		  }
		break;
	  }
  }

#endif /* HASHFILE */

/********************** Repitition cache ***********************/
extern SHORT rpthash[2][256];
extern SHORT ISZERO;

void
ZeroRPT (void)
{
#ifdef AMIGA
   if(ISZERO){ClearMem(rpthash, sizeof (rpthash));ISZERO=0;}
#else
   if(ISZERO){memset ((CHAR *) rpthash, 0, sizeof (rpthash));ISZERO=0;}
#endif
}
/********************** Hash code stuff ***********************/
/*
 * In a networked enviroment gnuchess might be compiled on different hosts
 * with different random number generators, that is not acceptable if they
 * are going to share the same transposition table.
 */
extern unsigned long int next;

#if defined NEWURAND
/*
This code copied from:

G. Wiesenekker. ZZZZZZ a chess program.
Copyright (C) 1993  G. Wiesenekker
E-mail: wiesenecker@sara.nl

A 32 bit random number generator. An implementation in C of the algorithm given by
Knuth, the art of computer programming, vol. 2, pp. 26-27. We use e=32, so 
we have to evaluate y(n) = y(n - 24) + y(n - 55) mod 2^32, which is implicitly
done by unsigned arithmetic.
*/

unsigned int urand(void)
{
	/*
	random numbers from Mathematica 2.0.
	SeedRandom = 1;
	Table[Random[Integer, {0, 2^32 - 1}]
	*/
	static unsigned long x[55] =
	{
		1410651636UL,
		3012776752UL,
		3497475623UL,
		2892145026UL,
		1571949714UL,
		3253082284UL,
		3489895018UL,
		387949491UL, 
		2597396737UL,
		1981903553UL,
		3160251843UL,
		129444464UL, 
		1851443344UL,
		4156445905UL,
		224604922UL,
		1455067070UL, 
		3953493484UL,
		1460937157UL,
		2528362617UL,
		317430674UL, 
		3229354360UL,
		117491133UL,
		832845075UL,
		1961600170UL, 
		1321557429UL,
		747750121UL,
		545747446UL,
		810476036UL,
		503334515UL, 
		4088144633UL,
		2824216555UL,
		3738252341UL,
		3493754131UL, 
		3672533954UL,
		29494241UL,
		1180928407UL,
		4213624418UL,
		33062851UL, 
		3221315737UL,
		1145213552UL,
		2957984897UL,
		4078668503UL, 
		2262661702UL,
		65478801UL,
		2527208841UL,
		1960622036UL,
		315685891UL, 
		1196037864UL,
		804614524UL,
		1421733266UL,
		2017105031UL, 
		3882325900UL,
		810735053UL,
		384606609UL,
		2393861397UL
	};
	static int init = TRUE;
	static unsigned long y[55];
	static int j, k;
	unsigned long ul;
	
	if (init)
	{
		int i;
		
		init = FALSE;
		for (i = 0; i < 55; i++)
			y[i] = x[i];
		j = 24 - 1;
		k = 55 - 1;
	}
	
	ul = (y[k] += y[j]);
	if (--j < 0) j = 55 - 1;
	if (--k < 0) k = 55 - 1;
	return((unsigned int)ul);
}

#else
unsigned int
urand (void)
{
  next *= 1103515245;
  next += 12345;
  return ((unsigned int) (next >> 16) & 0xFFFF);
}
#endif

void
gsrand (unsigned int seed)
{
  next = seed;
}

extern unsigned long hashkey, hashbd;
extern struct hashval hashcode[2][7][64];

#if !defined NOXRAND
unsigned int
xrand (int a, unsigned int b[])
{
  unsigned int i, r, loop;
  unsigned int j, c;
  unsigned int msk;
  if (!a)
    {
      for (i = 0; i < 4000; i++)
	b[i] = 0;
      return 0;
    }
  loop = true;
  while (loop)
    {
      r = urand ();
      msk = 1;
      c = 0;
      for (j = 0; j < 16; j++)
	{
	  if (r & msk)
	    c++;
	  msk = msk << 1;
	}
      if (c < 8)
	continue;
      loop = false;
      for (i = 0; i < a; i++)
	if (r == b[i])
	  {
	    loop = true;
	    break;
	  }
      if (!loop)
	{
	  b[a] = r;
	  return r;
	}
    }
  return 0;
}
#else
#define xrand(a,b) urand()
#endif

void
InitHashCode(unsigned int seed)
  {
	SHORT l, c, p;
//	unsigned int t[4000];
	unsigned int *t;
	int cnt = 0;

        ShowMessage("Hashcode init");
        ShowMessage("Please wait..");
	t = AllocMem(sizeof(int)*4000,MEMF_CLEAR);
        if (!t)
         {
 	  DisplayError("Cannot init hashtable");
	  return;
	 }
	xrand(cnt++,t);
	gsrand (seed);	/* idealy we would preserve the old seed but... */
	for (c = white; c <= black; c++)
	  for (p = pawn; p <= king; p++)
		for (l = 0; l < 64; l++)
		  {
			hashcode[c][p][l].key = (((unsigned long) xrand (cnt++,t)));
			hashcode[c][p][l].key += (((unsigned long) xrand (cnt++,t)) << 16);
			hashcode[c][p][l].bd = (((unsigned long) xrand (cnt++,t)));
			hashcode[c][p][l].bd += (((unsigned long) xrand (cnt++,t)) << 16);
#ifdef LONG64
			hashcode[c][p][l].key += (((unsigned long) xrand (cnt++,t)) << 32);
			hashcode[c][p][l].key += (((unsigned long) xrand (cnt++,t)) << 48);
			hashcode[c][p][l].bd += (((unsigned long) xrand (cnt++,t)) << 32);
			hashcode[c][p][l].bd += (((unsigned long) xrand (cnt++,t)) << 48);
#endif
		  }
	FreeMem(t,sizeof(int)*4000);
  }

