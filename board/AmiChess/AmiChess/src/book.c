#include <clib/alib_protos.h>
#include <clib/asyncio_protos.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "catalog.h"
#include "common.h"
#include "book.h"

#define MAXMOVES 200
#define MAXMATCH 100

#define wins_off 0
#define losses_off 2
#define draws_off 4
#define key_off 6

static int bookcnt;
static HashType posshash[MAXMOVES];

static int book_allocated=0;

#define MAGIC_LENGTH 5

static const char magic_str[]="\x42\x23\x08\x15\x03";

static int check_magic(struct AsyncFile *f)
{
char buf[MAGIC_LENGTH];
return ReadAsync(f,&buf,MAGIC_LENGTH)==MAGIC_LENGTH&&memcmp(buf,magic_str,MAGIC_LENGTH)==0;
}

static int write_magic(struct AsyncFile *f)
{
return (WriteAsync(f,&magic_str,MAGIC_LENGTH)!=MAGIC_LENGTH)?BOOK_EIO:BOOK_SUCCESS;
}

static int write_size(struct AsyncFile *f,unsigned int size)
{
if(WriteAsync(f,&size,sizeof(size))==sizeof(size)) return BOOK_SUCCESS;
return BOOK_EIO;
}

static unsigned int read_size(struct AsyncFile *f)
{
unsigned int size=0;
if(ReadAsync(f,&size,sizeof(size))!=sizeof(size)) return 0;
return size;
}

#define MAX_DIGEST_BITS 20

static int digest_bits;

#define DIGEST_SIZE (1<<digest_bits)
#define DIGEST_MASK (DIGEST_SIZE-1)

static struct hashtype
{
unsigned short wins;
unsigned short losses;
unsigned short draws;
HashType key;
} *bookpos;

__inline int is_empty(unsigned int index)
{
struct hashtype *b=&bookpos[index];
return b->key==0&&b->wins==0&&b->draws==0&&b->losses==0;
}

/*
#define DIGEST_START(key) ((key)&DIGEST_MASK)
#define DIGEST_MATCH(i,the_key) ((the_key)==bookpos[i].key)
#define DIGEST_EMPTY(i) is_empty(i)
#define DIGEST_COLLISION(i,key) (!DIGEST_MATCH(i,key)&&!DIGEST_EMPTY(i))
#define DIGEST_NEXT(i,key) (((i)+(((key)>>digest_bits)|1))&DIGEST_MASK)
*/

/* 68k is faster without macros */

static int DIGEST_START(HashType key)
{
return key&DIGEST_MASK;
}

static int DIGEST_MATCH(int i,HashType key)
{
return key==bookpos[i].key;
}

static int DIGEST_EMPTY(int i)
{
return is_empty(i);
}

static int DIGEST_COLLISION(int i,HashType key)
{
struct hashtype *b=&bookpos[i];
return key!=bookpos[i].key&&(b->key||b->wins||b->draws||b->losses);
}

static int DIGEST_NEXT(int i,HashType key)
{
HashType t=key>>digest_bits;
return (i+(((int)t)|1))&DIGEST_MASK;
}

static int bookhashcollisions=0;

#define DIGEST_LIMIT ((95*DIGEST_SIZE)/100)

static int compare(const void *aa,const void *bb)
{
int ret;
const leaf *a=(const leaf *)aa;
const leaf *b=(const leaf *)bb;
if(b->score>a->score) ret=1;
else if(b->score<a->score) ret=-1;
else ret=0;
return ret;
}

static int read_book(struct AsyncFile *f)
{
struct hashtype buf;
if(book_allocated)
	{
	free(bookpos);
	book_allocated=0;
	}
bookpos=(struct hashtype *)calloc(DIGEST_SIZE,sizeof(struct hashtype));
if(!bookpos) return BOOK_ENOMEM;
book_allocated=1;
bookcnt=0;
bookhashcollisions=0;
while(ReadAsync(f,&buf,sizeof(buf))==sizeof(buf))
	{
	int i;
	for(i=DIGEST_START(buf.key);DIGEST_COLLISION(i,buf.key);i=DIGEST_NEXT(i,buf.key)) bookhashcollisions++;
	if(i<DIGEST_SIZE)
		{
		struct hashtype *b=&bookpos[i];
		b->wins+=buf.wins;
		b->draws+=buf.draws;
		b->losses+=buf.losses;
		b->key=buf.key;
		bookcnt++;
		}
	}
return BOOK_SUCCESS;
}

int BookBuilderOpen(void)
{
struct AsyncFile *rfp,*wfp;
int res;
if(rfp=OpenAsync("PROGDIR:book.dat",MODE_READ,65536))
	{
	char text[100];
	DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_OPENED));
	if(!check_magic(rfp))
		{
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_NOTCONFORM));
		CloseAsync(rfp);
		return BOOK_EFORMAT;
		}
	digest_bits=MAX_DIGEST_BITS;
	read_size(rfp);
	res=read_book(rfp);
	CloseAsync(rfp);
	if(res!=BOOK_SUCCESS) return res;
	sprintf(text,getstr(MSG_BOOK_READPOS),bookcnt,bookhashcollisions);
	DoMethod(mui_app,MUIM_Chess_ShowThinking,text);
	}
else
	{
	if(!(wfp=OpenAsync("PROGDIR:book.dat",MODE_WRITE,65536)))
		{
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_NOTCREATE));
		return BOOK_EIO;
		}
	if(write_magic(wfp)!=BOOK_SUCCESS)
		{
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_NOTWRITE));
		CloseAsync(wfp);
		return BOOK_EIO;
		}
	if(CloseAsync(wfp)<0)
		{
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_NOTWRITE));
		return BOOK_EIO;
		}
	DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_CREATENEW));
	if(!(rfp=OpenAsync("PROGDIR:book.dat",MODE_READ,65536)))
		{
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_NOTREAD));
		return BOOK_EIO;
		}
	digest_bits=MAX_DIGEST_BITS;
	if(read_book(rfp)==BOOK_ENOMEM)
		{
		CloseAsync(rfp);
		return BOOK_ENOMEM;
		}
	CloseAsync(rfp);
	}
return BOOK_SUCCESS;
}

int BookBuilder(int result,int side)
{
unsigned int i;
if(GameCnt>BOOKDEPTH) return BOOK_EMIDGAME;
CalcHashKey();
for(i=DIGEST_START(HashKey);;i=DIGEST_NEXT(i,HashKey))
	{
	if(HashKey==bookpos[i].key)
		{
		existpos++;
		break;
		}
	else if(DIGEST_EMPTY(i))
		{
		if(bookcnt>DIGEST_LIMIT) return BOOK_EFULL;
		bookpos[i].key=HashKey;
		newpos++;
		bookcnt++;
		break;
		}
	else bookhashcollisions++;
	}
if(side==white)
	{
	if(result==R_WHITE_WINS) bookpos[i].wins++;
	else if(result==R_BLACK_WINS) bookpos[i].losses++;
	else if(result==R_DRAW) bookpos[i].draws++;
	}
else
	{
	if(result==R_WHITE_WINS) bookpos[i].losses++;
	else if(result==R_BLACK_WINS) bookpos[i].wins++;
	else if(result==R_DRAW) bookpos[i].draws++;
	}
return BOOK_SUCCESS;
}

int BookBuilderClose(void)
{
struct AsyncFile *wfp;
unsigned int i;
int errcode=BOOK_SUCCESS;
char text[100];
if(!(wfp=OpenAsync("PROGDIR:book.dat",MODE_WRITE,65536)))
	{
	errcode=BOOK_EIO;
	goto bailout_noclose;
	}
if(write_magic(wfp)!=BOOK_SUCCESS)
	{
	errcode=BOOK_EIO;
	goto bailout;
	}
if(write_size(wfp,bookcnt)!=BOOK_SUCCESS)
	{
	errcode=BOOK_EIO;
	goto bailout;
	}
for(i=0;i<DIGEST_SIZE;i++)
	{
	if(!is_empty(i))
		{
		if(WriteAsync(wfp,&bookpos[i],sizeof(struct hashtype))!=sizeof(struct hashtype))
			{
			errcode=BOOK_EIO;
			goto bailout;
			}
		}
	}
sprintf(text,getstr(MSG_BOOK_COLLISIONS),bookhashcollisions);
DoMethod(mui_app,MUIM_Chess_ShowThinking,text);

bailout:
if(CloseAsync(wfp)<0) errcode=BOOK_EIO;

bailout_noclose:
free(bookpos);
book_allocated=0;
bookloaded=0;
return errcode;
}

int BookQuery(void)
{
int i,j,k,icnt=0,mcnt,found,maxdistribution;
int matches[MAXMATCH] ;
leaf m[MAXMOVES];
leaf pref[MAXMOVES];
struct {
unsigned short wins;
unsigned short losses;
unsigned short draws;
} r[MAXMOVES];
leaf *p;
int side,xside,temp;
unsigned int booksize;
int res;
char text[100];
if(bookloaded&&!book_allocated) return BOOK_ENOBOOK;
if(!bookloaded)
	{
	struct AsyncFile *rfp;
	bookloaded=1;
	if(!(rfp=OpenAsync("PROGDIR:book.dat",MODE_READ,65536))) return BOOK_ENOBOOK;
	DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_READING));
	if(!check_magic(rfp))
		{
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_BOOK_NOTCONFORM));
		CloseAsync(rfp);
		return BOOK_EFORMAT;
		}
	booksize=(read_size(rfp)*106)/100;
	for(digest_bits=1;booksize;booksize>>=1) digest_bits++;
	res=read_book(rfp);
	CloseAsync(rfp);
	if(res!=BOOK_SUCCESS) return res;
	sprintf(text,getstr(MSG_BOOK_COLLISIONS),bookhashcollisions);
	DoMethod(mui_app,MUIM_Chess_ShowThinking,text);
	}
mcnt=-1;
side=board.side;
xside=1^side;
TreePtr[2]=TreePtr[1];
GenMoves(1);
FilterIllegalMoves(1);
for(p=TreePtr[1];p<TreePtr[2];p++)
	{
	MakeMove(side,&p->move);
	m[icnt].move=p->move;
	posshash[icnt]=HashKey;
	icnt++;
	UnmakeMove(xside,&p->move);
	}
for(i=0;i<icnt;i++)
	{
	for(j=DIGEST_START(posshash[i]);!DIGEST_EMPTY(j);j=DIGEST_NEXT(j,posshash[i]))
		{
		if(DIGEST_MATCH(j,posshash[i]))
			{
			found=0;
			for(k=0;k<mcnt;k++) if(matches[k]==i)
				{
				found=1;
				break;
				}
			if(!found)
				{
				matches[++mcnt]=i;
				pref[mcnt].move=m[i].move;
				r[i].losses=bookpos[j].losses;
				r[i].wins=bookpos[j].wins;
				r[i].draws=bookpos[j].draws;
				pref[mcnt].score=m[i].score=100*(r[i].wins+(r[i].draws/2))/(MAX(r[i].wins+r[i].losses+r[i].draws,1))+r[i].wins/2;
				}
			if(mcnt>=MAXMATCH) goto fini;
			break;
			}
		}
	}

fini:  
if(mcnt==-1) return BOOK_ENOMOVES;
k=0;
if(mcnt+1)
	{
	if(bookmode==BOOKRAND)
		{
		k=rand();
		k=k%(mcnt+1);
		RootPV=m[matches[k]].move;
/*		printf("\n(Random picked move #%d %s%s from above list)\n",k,algbr[FROMSQ(RootPV)],algbr[TOSQ(RootPV)]);
		tot=r[matches[k]].wins+r[matches[k]].draws+r[matches[k]].losses;
		if(tot) printf("B p=%2.0f\n",100.0*(r[matches[k]].wins+r[matches[k]].draws)/tot);
		else printf("p=NO EXPERIENCES\n");
*/
		}
	else if(bookmode==BOOKBEST)
		{
		qsort(&pref,mcnt+1,sizeof(leaf),compare);
		RootPV=pref[0].move;
		}
	else if(bookmode==BOOKWORST)
		{
		qsort(&pref,mcnt+1,sizeof(leaf),compare);
		RootPV=pref[mcnt].move;
		}
	else if(bookmode==BOOKPREFER)
		{
		qsort(&pref,mcnt+1,sizeof(leaf),compare);
		for(i=0;i<=mcnt;i++) m[i].move=pref[i].move;
		temp=(bookfirstlast>mcnt+1?mcnt+1:bookfirstlast);
		maxdistribution=0;
		for(i=0;i<temp;i++) maxdistribution+=pref[i].score;
		if(!maxdistribution) return BOOK_ENOMOVES;
		k=rand()%maxdistribution;
		maxdistribution=0;
		for(i=0;i<temp;i++)
			{
			maxdistribution+=pref[i].score;
			if(k>=maxdistribution-pref[i].score&&k<maxdistribution)
				{
				k=i;
				RootPV=m[k].move;
				break;
				}
			}
		}
	}
return BOOK_SUCCESS;
}
